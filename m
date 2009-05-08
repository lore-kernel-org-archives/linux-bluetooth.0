Return-Path: <cyrus@holtmann.org>
Subject: Re: btusb auto suspend
From: Marcel Holtmann <marcel@holtmann.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	linux-usb@vger.kernel.org
In-Reply-To: <200905090018.52198.oliver@neukum.org>
References: <1241433271.7620.4748.camel@twins>
	 <200905082223.16014.oliver@neukum.org>
	 <1241820581.4903.63.camel@localhost.localdomain>
	 <200905090018.52198.oliver@neukum.org>
Content-Type: text/plain
Date: Fri, 08 May 2009 15:20:41 -0700
Message-Id: <1241821241.4903.65.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

> > > It will have to be changed to work with those buggy devices.
> > > Do you have a pointer to a page describing the problem in detail?
> >
> > The problem is that the interrupt URBs and bulk URBs for RX have to be
> > always scheduled. Not matter if we have an ACL link or. Once the device
> > is up they have to there. Some devices just don't like it if we only
> > have interrupt URBs.
> 
> OK, I see. Does the order they are submitted in matter?

I really don't think so, but you never know.

Regards

Marcel


