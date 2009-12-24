Return-Path: <cyrus@holtmann.org>
Date: Thu, 24 Dec 2009 16:29:52 +0000 (GMT)
To: Ed Tsang <netdesign_98@yahoo.com>
Cc: Bluettooth Linux <linux-bluetooth@vger.kernel.org>
Subject: Re: How to disable simple pairing? (Vista -> Linux using fix pin)
In-Reply-To: <509357.32587.qm@web52606.mail.re2.yahoo.com>
References: <509357.32587.qm@web52606.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Message-Id: <1261672192.331418.15984.nullmailer@galant.ukfsn.org>
From: Iain Hibbert <plunky@rya-online.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 17 Dec 2009, Ed Tsang wrote:

> The situation is: I am using a linux box. It will have to talk to other
> devices (cell phone, notbook ..etc.). The linux box is unmaned. It could
> force the box to use a fix pin by modifying the simple-agent. All other
> devices user know the fix pin. It work fine with most cell phones so far
> (not the latest phone?). But with Window Vista, it fail, because vista
> when try to pair with the box will generate a random number (great
> security) and expect us to enter the same number in the other side.

> I am not sure but I guess it is associate with the new simple paring
> feature?
> Is there a way to tell the other side we do not support simple pairing?

It does not sound related to simple pairing.

> Or is there a way to tell the other side that we do not have a pin input
> method?

Not that I know of. (for a gross hack, you could change the class of
device to be the same as a device that does not have a pin input method,
that might make it guess that a fixed pin is needed)

but if you pair from the Vista side you should be able to provide a PIN.
Here is a page that describes setting up a Bluetooth connection

  http://www.vista4beginners.com/How-to-setup-a-Bluetooth-connection

and the pictures show exactly what you want to be possible..

iain


