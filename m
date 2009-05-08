Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb auto suspend
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-usb@vger.kernel.org
In-Reply-To: <200905082223.16014.oliver@neukum.org>
References: <1241433271.7620.4748.camel@twins>
	 <1241458142.2903.35.camel@localhost.localdomain>
	 <200905082223.16014.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 08 May 2009 15:09:41 -0700
Message-Id: <1241820581.4903.63.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > What is the current status of btusb auto suspend? btusb not having this
> > > feature basically renders BT useless on mobile devices.
> > >
> > > I found some rfc patches and discussion over on linux-pm/-usb but
> > > couldn't find a clear consensus.
> >
> > I think none of the patches apply anymore. So they have to be redone
> > against the latest -rc4 kernel or bluetooth-testing.git.
> 
> I am porting forward to Linus' tree. I thought they'd safely wait for
> the next merge window.

I can push them into bluetooth-testing.git tree.

> > We had some battles with broken Bluetooth hardware that requires to keep
> > the interrupt and bulk URBs in fly, because otherwise the firmware
> > inside the controller can't sync them up and times out. These are all
> > fixed now, but nobody has looked at the auto suspend stuff. Feel free to
> 
> It will have to be changed to work with those buggy devices.
> Do you have a pointer to a page describing the problem in detail?

The problem is that the interrupt URBs and bulk URBs for RX have to be
always scheduled. Not matter if we have an ACL link or. Once the device
is up they have to there. Some devices just don't like it if we only
have interrupt URBs.

Regards

Marcel


