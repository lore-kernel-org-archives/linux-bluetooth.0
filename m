Return-Path: <krose+bluez@krose.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] AMD64 HID pairing
References: <khnacuya23u.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097185188.7325.75.camel@pegasus>
	<khnr7oa8ah1.fsf@hunter-killer.kendall.corp.akamai.com>
	<1097186322.7325.79.camel@pegasus>
From: Kyle Rose <krose+bluez@krose.org>
Date: Thu, 07 Oct 2004 18:07:06 -0400
In-Reply-To: <1097186322.7325.79.camel@pegasus> (Marcel Holtmann's message of
	"Thu, 07 Oct 2004 23:58:42 +0200")
Message-ID: <khnk6u289o5.fsf@hunter-killer.kendall.corp.akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

Marcel Holtmann <marcel@holtmann.org> writes:

> If this is a Debian system then hid2hci will normaly run a boot time and
> switch it from HID to HCI mode.

You are correct, and this is being run at boot time.  However, I don't
think this does anything interesting in my case since I have USB
legacy support disabled in my BIOS as I have only a bluetooth mouse
and not a bluetooth keyboard, the former of which I don't need until
after Linux boots.

> Then use "-x". I think the "-X" option was introduced with 1.11 or so
> and the Debian packages are a little bit behind.

I'll have to do this when I get home, so I can move the mouse around
and see what I get.

Thanks,
Kyle
