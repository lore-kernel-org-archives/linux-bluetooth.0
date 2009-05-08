Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: btusb auto suspend
Date: Fri, 8 May 2009 22:23:15 +0200
Cc: Peter Zijlstra <peterz@infradead.org>,
 linux-usb@vger.kernel.org
References: <1241433271.7620.4748.camel@twins> <1241458142.2903.35.camel@localhost.localdomain>
In-Reply-To: <1241458142.2903.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905082223.16014.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Montag, 4. Mai 2009 19:29:02 schrieb Marcel Holtmann:
> Hi Peter,
>
> > What is the current status of btusb auto suspend? btusb not having this
> > feature basically renders BT useless on mobile devices.
> >
> > I found some rfc patches and discussion over on linux-pm/-usb but
> > couldn't find a clear consensus.
>
> I think none of the patches apply anymore. So they have to be redone
> against the latest -rc4 kernel or bluetooth-testing.git.

I am porting forward to Linus' tree. I thought they'd safely wait for
the next merge window.

> We had some battles with broken Bluetooth hardware that requires to keep
> the interrupt and bulk URBs in fly, because otherwise the firmware
> inside the controller can't sync them up and times out. These are all
> fixed now, but nobody has looked at the auto suspend stuff. Feel free to

It will have to be changed to work with those buggy devices.
Do you have a pointer to a page describing the problem in detail?

> pick Oliver's patches up and send them for review. If you do so, please
> use linux-bluetooth@vger.kernel.org since I do miss posting on LKML from
> time to time.

Peter, are you willing to test?

	Regards
		Oliver
