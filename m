Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C12@EXDCVYMBSTM005.EQ1STM.local>
References: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
	<1309465011.5023.85.camel@novo.hadess.net>
	<BANLkTi=X__bC+4gAKuYzhvYPP-S3+QWGkw@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C12@EXDCVYMBSTM005.EQ1STM.local>
Date: Fri, 1 Jul 2011 06:50:15 -0400
Message-ID: <BANLkTikCHccP+-_dopoAWrAMFdwh8LHaQw@mail.gmail.com>
Subject: Re: [RFC BlueZ] Add Proximity API
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Fri, Jul 1, 2011 at 3:22 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
> Hello Anderson,
>
>>>> Covers the Proximity Reporter for Link Loss, Tx Power and Immediate
>
> [clip ...]
>
>>> Is this
>>> good enough to implement both sides of the profile, or just one side of
>>> it?
>>
>>The API is for the Proximity Monitor role.
>
> Sounds bit confusing.. Ain't these API's being proposed for Proximity Reporter Role which is what Claudio mentioned in the original RFC? Which bring me to the next question- since a GATT client makes more sense for a dual mode stack such as Bluez, shouldn't we focus first on Monitor kind of roles for LE profiles and later consider Reporter type roles for testing only?

Sorry, actually it was a mistake from Claudio (which I hadn't noticed
when I made my comments) :) This is a *Monitor* API as I mentioned.
The doc itself mentions:

+Interface      org.bluez.ProximityMonitor

And you are correct, our current focus is on Proximity Monitor & Find
Me Locator (AKA "client") roles. The "server" roles will be initially
implemented for testing purposes.

Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
