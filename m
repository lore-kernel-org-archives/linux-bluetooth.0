Return-Path: <Bernd.Jucknischke@web.de>
From: Bernd Jucknischke <Bernd.Jucknischke@web.de>
Reply-To: Bernd.Jucknischke@web.de
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Bluez-users] AVM AP-X and DUN profile
Date: Fri, 5 Mar 2004 08:34:00 +0100
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
References: <200403030832.19665.Bernd.Jucknischke@web.de> <200403040924.58522.Bernd.Jucknischke@web.de> <1078398559.5347.1.camel@pegasus>
In-Reply-To: <1078398559.5347.1.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200403050834.01008.Bernd.Jucknischke@web.de>
Sender: Bernd.Jucknischke@web.de
List-ID: <bluez-users.lists.sourceforge.net>

On Donnerstag, 4. M=E4rz 2004 12:09, Marcel Holtmann wrote:
> Hi Bernd,
>
> > Thanks for the fast reply. I know that page already. I'm running the 2.6
> > kernel series and haven't been able to find a working capi, yet. I guess
> > I'll have to wait until it's (capi) supported for 2.6...
>
> you can search for a patch named i4l-t9bk22 or use 2.6.4-rc1 which
> already includes every ISDN update that is needed. However you must make
> sure that the module capi.ko is loaded and that /dev/capi is mounted,
> because capiinit sometimes forget about it.

Thanks again! That's info I didn't have and I'll try it immediately...

> Regards
>
> Marcel

Later,
Bernd
