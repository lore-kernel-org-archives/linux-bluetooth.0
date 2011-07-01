Return-Path: <cyrus@holtmann.org>
From: Arun Kumar SINGH <arunkr.singh@stericsson.com>
To: Bastien Nocera <hadess@hadess.net>,
	mike tsai <mikeyhtsai@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Fri, 1 Jul 2011 09:29:27 +0200
Subject: RE: How to build gatttool
Message-ID: <AFCDDB4A3EA003429EEF1E7B211FDBBA33A2BA4C20@EXDCVYMBSTM005.EQ1STM.local>
References: <BANLkTinaWe5A1T1zqkbKrSD-bLRUMwPr8A@mail.gmail.com>
 <1309473458.5023.88.camel@novo.hadess.net>
In-Reply-To: <1309473458.5023.88.camel@novo.hadess.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello Bastien, Mike,
>>
>>    Adding --enable-attrib in bootstrap-configure does not work any
>> more. Is there a new way to build gatttool?
>
>It's now an automagic dependency, as some people call it. Install
>readline-devel (or whatever your distro calls it).

Previously readline was needed only for interactive gatttool but I guess from Bluez 4.90 onwards, it[interactive version] got merged with regular gatttool version and it would get compiled automatically once readline-devel is installed on your host- as Bastien points...

Thanks,
Arun
