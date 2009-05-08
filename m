Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: btusb auto suspend
Date: Sat, 9 May 2009 00:18:51 +0200
Cc: linux-bluetooth@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 linux-usb@vger.kernel.org
References: <1241433271.7620.4748.camel@twins> <200905082223.16014.oliver@neukum.org> <1241820581.4903.63.camel@localhost.localdomain>
In-Reply-To: <1241820581.4903.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905090018.52198.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Samstag, 9. Mai 2009 00:09:41 schrieb Marcel Holtmann:
> > It will have to be changed to work with those buggy devices.
> > Do you have a pointer to a page describing the problem in detail?
>
> The problem is that the interrupt URBs and bulk URBs for RX have to be
> always scheduled. Not matter if we have an ACL link or. Once the device
> is up they have to there. Some devices just don't like it if we only
> have interrupt URBs.

OK, I see. Does the order they are submitted in matter?

	Regards
		Oliver
