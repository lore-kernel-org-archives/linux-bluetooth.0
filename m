Return-Path: <cyrus@holtmann.org>
From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
To: linux-bluetooth@vger.kernel.org
Subject: Re: BT git version triggers BUG: scheduling while atomic: swapper/0/0x10000100
Date: Tue, 5 May 2009 03:23:40 +0200
References: <200905050301.37528.Hugo.Mildenberger@namir.de> <1241485973.3319.1.camel@localhost.localdomain>
In-Reply-To: <1241485973.3319.1.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905050323.42101.Hugo.Mildenberger@namir.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag, 5. Mai 2009 schrieb Marcel Holtmann:
> Hi Hugo,
>
> > When I tried to get a mobile phone connected to asterisk via bluetooth,
> > the current git version of the linux bluetooth stack triggers a kernel
> > bug:
> >
> > 	BUG: scheduling while atomic: swapper/0/0x10000100
> >
> > This is triggered the moment when asterisk tries to pair the phone and
> > leaves at least the BT subsystem in an unusable state.
>
> are you running Linus' tree or bluetooth-testing.git? If your are not
> running bluetooth-testing.git, then please try that one since it
> includes a fix for it.
>
> Regards
>
> Marcel

Marcel,

I'm running bluetooth-testing.git and pulled that tree just an hour ago.
