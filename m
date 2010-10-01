Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1879C724-F5EC-48FE-AD5D-46C8B290DEC6@signove.com>
References: <1879C724-F5EC-48FE-AD5D-46C8B290DEC6@signove.com>
From: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Date: Fri, 1 Oct 2010 16:29:57 +0200
Message-ID: <AANLkTi=xdBH5prtbfkviPdzfLrBkt5ixGFrM36G-jJ-D@mail.gmail.com>
Subject: Re: HDP development status and collaboration
To: =?ISO-8859-1?Q?Elvis_Pf=FCtzenreuter?= <epx@signove.com>
Cc: linux-bluetooth@vger.kernel.org,
	"Jarvenpaa Jarmo (Nokia/Oulu)" <jarmo.jarvenpaa@nokia.com>,
	Aldenor Martins <aldenor.martins@signove.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Santiago Carot-Nemesio <scarot@libresoft.es>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Elvis,

Find inline comments about the state of the development

2010/9/29 Elvis Pfützenreuter <epx@signove.com>:
> Attached is a spreadsheet with a simple breakdown of HDP development tasks. Managers like spreadsheets, most of us don't, so the most relevant part -- the pending tasks -- are listed below for convenience:
>
> device.Echo                     PENDING

Partially done win the CreateChanel petition (almost complete)

> device.CreateChannel            IN PROGRESS (OpenHealth)

Done, needs a little bit more testing

> device.DestroyChannel           PENDING

In progress

> device.ChannelConnected         PENDING

This is already done

> device.ChannelDeleted           PENDING

This one is also done.

> device properties               PENDING
> Channel object                  PENDING

The object channel is also created, but not the methods.

> channel.Acquire                 PENDING
> channel.Release                 PENDING
> channel properties              PENDING
> HDP verification against PTS    PENDING (depends on the rest)
>
> I'd say that we are getting near completion. Would be nearer if we could distribute those tasks; currently, only OpenHealth friends are working on HDP code, in their repository.
>
> I know it's sometimes difficult to collaborate while working on the very same source files, but we should try; the breakdown by API calls seem to be the way to divide work among available developers.
>
>
>
As you say, the collaboration over the same code is difficult, event
for Satiago and me working in the same office, because all the code is
very related. I think that the development is going quite fast and we
plan to finisht it soon, note that the last week we were a little bit
delayed because we were creating most of the core functions that will
be reused for the other petitions, so the development of the other
functionality will be faster than expected.

Regards.

Jose.
