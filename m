Return-Path: <pmk@cray.com>
Date: Tue, 2 Dec 2003 11:42:03 -0600
From: Peter Klausler <pmk@cray.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Edd Dumbill <edd@usefulinc.com>, Peter Klausler <peter@klausler.com>,
   Charles Bueche <charles@bueche.ch>,
   BlueZ Developers List <bluez-devel@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Logitech MX900 mouse with Dell Inspiron 8600
Message-ID: <20031202114203.A31354@schnell.us.cray.com>
References: <1070201531.8187.20.camel@bluez.bueche.ch> <1070218289.8534.30.camel@bluez.bueche.ch> <20031201093804.A1281@schnell.us.cray.com> <1070380522.19169.52.camel@saag> <1070386758.18577.2.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
In-Reply-To: <1070386758.18577.2.camel@pegasus>; from marcel@holtmann.org on Tue, Dec 02, 2003 at 11:39:18 -0600
List-ID: <bluez-devel.lists.sourceforge.net>

On 2003.12.02 11:39 Marcel Holtmann wrote:
> Hi Edd,
> 
> > Hmm, I'd thought I'd sent this to the list, but obviously didn't.
> 
> yes you sent it to list. It still resides in my Bluetooth mailbox and
> it
> is working fine. I think Marcelo will take my backport of the uinput
> driver into 2.4.24 and so uinput should be the way to go, even if this
> means that we have to implement our own HID parser in userspace.

What's wrong with the HID parser in bthid today?
