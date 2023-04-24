create table #percentPopulationVaccintedtoo
(
contintent nvarchar(255),
location nvarchar (255),
date datetime,
population numeric,
new_vaccinated numeric,
rollingpeopleVaccinatedtoo numeric
)
insert into #percentPopulationVaccintedtoo
select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations
,sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as rollingpeopleVaccinatedtoo
----, (rollingpeopleVaccinatedtoo/population)*100
from portfolioProject..CovidDeaths$ dea
join portfolioProject..CovidVaccinations$ vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
--order by 2,3

select*,(rollingpeopleVaccinatedtoo/population)*100
from #percentPopulationVaccintedtoo
