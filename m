Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C20@EXDCVYMBSTM005.EQ1STM.local>
References: <BANLkTinaWe5A1T1zqkbKrSD-bLRUMwPr8A@mail.gmail.com>
	<1309473458.5023.88.camel@novo.hadess.net>
	<AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C20@EXDCVYMBSTM005.EQ1STM.local>
Date: Fri, 1 Jul 2011 09:16:55 -0700
Message-ID: <BANLkTi=FBPKcY9JgAqQE0+VNTAWJ_+gz2Q@mail.gmail.com>
Subject: Re: How to build gatttool
From: mike tsai <mikeyhtsai@gmail.com>
To: Arun Kumar SINGH <arunkr.singh@stericsson.com>
Cc: Bastien Nocera <hadess@hadess.net>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Fri, Jul 1, 2011 at 12:29 AM, Arun Kumar SINGH
<arunkr.singh@stericsson.com> wrote:
> Hello Bastien, Mike,
>>>
>>>    Adding --enable-attrib in bootstrap-configure does not work any
>>> more. Is there a new way to build gatttool?
>>
>>It's now an automagic dependency, as some people call it. Install
>>readline-devel (or whatever your distro calls it).
>
> Previously readline was needed only for interactive gatttool but I guess from Bluez 4.90 onwards, it[interactive version] got merged with regular gatttool version and it would get compiled automatically once readline-devel is installed on your host- as Bastien points...
>
Yes, the gatttool can be built now after installation of readline library,

regards,

mike

> Thanks,
> Arun
>
