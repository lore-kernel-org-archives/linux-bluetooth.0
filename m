Return-Path: <postfix@gmx.com>
Date: Wed, 11 Feb 2004 18:35:19 +0100
From: Radu Maurer <a400@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple keyboard
Message-ID: <20040211173519.GA6412@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de> <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de> <1076515215.2696.36.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076515215.2696.36.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Mi, 11 Feb, 2004 at 17:00:15 +0100, Marcel Holtmann wrote:
> > after a few seconds I get the message:
> > bthid[19500]: Connection failed: Function not implemented (38)
> 
> this can be a paring problem, because the Apple HID devices don't allow
> unencrypted connections. Run "hcidump -w <file>" so I can see what is on
> the HCI layer.

Ok, I'm trying
right now to compile hcidump from cvs but configure fails:

checking "for bluetooth/bluetooth.h"... (/usr/include) yes
checking "for libbluetooth"... "no"
configure: error: Bluetooth library not found.
                Please compile and install bluez-libs package.

although I do have libbluetooth.so installed in /usr/lib (package
libbluetooth2_0.1-1_i386.deb)

Radu
