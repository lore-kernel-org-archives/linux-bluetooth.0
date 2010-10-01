Return-Path: <cyrus@holtmann.org>
Subject: Re: HDP development status and collaboration
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=iso-8859-1
From: =?iso-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
In-Reply-To: <AANLkTi=xdBH5prtbfkviPdzfLrBkt5ixGFrM36G-jJ-D@mail.gmail.com>
Date: Fri, 1 Oct 2010 13:38:24 -0300
Cc: linux-bluetooth@vger.kernel.org,
	Aldenor Martins <aldenor.martins@signove.com>,
	Santiago Carot-Nemesio <scarot@libresoft.es>
Message-Id: <0952AD43-0136-45A3-8FDA-47FDD78190A7@signove.com>
References: <1879C724-F5EC-48FE-AD5D-46C8B290DEC6@signove.com> <AANLkTi=xdBH5prtbfkviPdzfLrBkt5ixGFrM36G-jJ-D@mail.gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 01/10/2010, at 11:29, Jose Antonio Santos Cadenas wrote:

> Hi Elvis,
> 
> Find inline comments about the state of the development
> 
> 2010/9/29 Elvis Pfützenreuter <epx@signove.com>:
>> Attached is a spreadsheet with a simple breakdown of HDP development tasks. Managers like spreadsheets, most of us don't, so the most relevant part -- the pending tasks -- are listed below for convenience:
>> 
>> device.Echo                     PENDING
> 
> Partially done win the CreateChanel petition (almost complete)
> 
>> device.CreateChannel            IN PROGRESS (OpenHealth)
> 
> Done, needs a little bit more testing
> 
>> device.DestroyChannel           PENDING
> 
> In progress
> 
>> device.ChannelConnected         PENDING
> 
> This is already done
> 
>> device.ChannelDeleted           PENDING
> 
> This one is also done.
> 
>> device properties               PENDING
>> Channel object                  PENDING
> 
> The object channel is also created, but not the methods.
> 
>> channel.Acquire                 PENDING
>> channel.Release                 PENDING
>> channel properties              PENDING
>> HDP verification against PTS    PENDING (depends on the rest)
>> 
>> I'd say that we are getting near completion. Would be nearer if we could distribute those tasks; currently, only OpenHealth friends are working on HDP code, in their repository.
>> 
>> I know it's sometimes difficult to collaborate while working on the very same source files, but we should try; the breakdown by API calls seem to be the way to divide work among available developers.
>> 

Lots of progress, congratulations. I had seen some of those in the repository, before the e-mail.

>> 
>> 
> As you say, the collaboration over the same code is difficult, event
> for Satiago and me working in the same office, because all the code is
> very related. I think that the development is going quite fast and we
> plan to finisht it soon, note that the last week we were a little bit
> delayed because we were creating most of the core functions that will
> be reused for the other petitions, so the development of the other
> functionality will be faster than expected.

Please let us know if you need help in anything.

We will begin to test and PTS the code as it progresses, so at least that one is parallelized.

That Python-based implementation of HDP (HDPy), that mimics the (future) D-Bus BlueZ API, already passes PTS tests, save by 8 of them (which I am investigating). So we have something to compare against, if needed.

> 
> Regards.
> 
> Jose.

