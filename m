Return-Path: <fd@cisco.com>
Subject: Re: [Bluez-users] Kernel 2.6.6 + mh1 patch set -- linker error
From: Frederic Detienne <fd@cisco.com>
Reply-To: fd@cisco.com
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1085223910.22191.59.camel@pegasus>
References: <1085206521.10621.17.camel@metal.cisco.com>
	 <1085223910.22191.59.camel@pegasus>
Content-Type: text/plain
Message-Id: <1085230273.10614.23.camel@metal.cisco.com>
Mime-Version: 1.0
Date: Sat, 22 May 2004 14:51:14 +0200
List-ID: <bluez-users.lists.sourceforge.net>

On Sat, 2004-05-22 at 13:05, Marcel Holtmann wrote:
> Hi Frederic,
> 
> > I have applied the -mh1 patch set on a 2.6.6 tree and get linker errors
> > related to duplicate HID function definitions. I included the error
> > messages as well as my .config.
> > 
> > There is apparently a conflict between hid-core and hidp. Is my config
> > nonsensical ?
> 
> we already discussed this here and the problem is that you can't use
> both hidp and usbhid built-in right now.

oops. I searched first but did not see that thread; truly sorry.

> I fixed it in my tree and with
> -mh2 it should be possible again, but this patch isn't out yet. Use
> modules to prevent this error.

ack. thanks for re-explaining!

best regards,

	fred

> Regards
> 
> Marcel
> 
