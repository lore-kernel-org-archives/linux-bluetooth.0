Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20120427122649.GB24847@x220.P-661HNU-F1>
References: <CAB7rCTgjdGhM7bk=R=uPzmuUOL3+MB+ApiJiP8Xkgrvsd=APTw@mail.gmail.com>
	<20120427122649.GB24847@x220.P-661HNU-F1>
Date: Fri, 27 Apr 2012 08:31:43 -0500
Message-ID: <CAB7rCTgBi=+s0NpAD_TOdoBzOPHo2qT6wUFX3v5K81O=V_QaKQ@mail.gmail.com>
Subject: Re: TP/SIG/SMG/BI-14-C AVDTP_RECONFIGURE
From: Mike <puffy.taco@gmail.com>
To: Mike <puffy.taco@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>> Is there a method of passing TP/SIG/SMG/BI-14-C, which needs to send a
>> AVDTP_RECONFIGURE command series?  It doesn't appear to be a part of
>> avtest.c.  If no one has done it, I'll end up having to write it.
>
> Why don't you just mark AVDTP_Reconfigure as not supported in the PICS
> (10/5, an optional feature). BlueZ doesn't support it anyway.
>

Thanks!  That helps.

Mike
