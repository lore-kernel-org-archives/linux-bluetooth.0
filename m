Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2C00E66@EXDCVYMBSTM005.EQ1STM.local>
References: <1309458277-30407-1-git-send-email-claudio.takahasi@openbossa.org>
	<1309465011.5023.85.camel@novo.hadess.net>
	<BANLkTi=X__bC+4gAKuYzhvYPP-S3+QWGkw@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C12@EXDCVYMBSTM005.EQ1STM.local>
	<BANLkTikCHccP+-_dopoAWrAMFdwh8LHaQw@mail.gmail.com>
	<BANLkTikdgm==V3onWH+-fHEGmvT2ZTBrdw@mail.gmail.com>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A2C00E66@EXDCVYMBSTM005.EQ1STM.local>
Date: Wed, 6 Jul 2011 16:59:27 -0300
Message-ID: <CAKT1EBcZTnGUT2Fp_JPQSYWFcvb884OtVW16SioDfKMNhRCpnw@mail.gmail.com>
Subject: Re: [RFC BlueZ] Add Proximity API
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,
<snip>

>
> Also how about setting profile specific LSTO? Proximity specs recommends this value to be 6X connection interval but I guess we may give the user/application some flexibility to play around on this? Same may be the case for connection interval, scan interval, latency values etc...I believe these values can be pretty much user/platform specific and user should have control over these ...

We will investigate it later. The first step is to push the ATT
connection management and Proximity patches upstream.

Briefly: the idea is to create "profiles" related to connection speed
and power consumption.

Regards,
Claudio.
>
> Thanks,
> Arun
>
