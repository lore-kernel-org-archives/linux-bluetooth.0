Return-Path: <postfix@gmx.com>
Date: Fri, 13 Feb 2004 11:50:35 +0100
From: Radu Maurer <a400@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Apple keyboard
Message-ID: <20040213105035.GA10464@mail.gmx.de>
References: <20040210175802.GA17705@mail.gmx.de> <1076451979.2777.21.camel@pegasus> <20040211151146.GA19818@mail.gmx.de> <1076515215.2696.36.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1076515215.2696.36.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

On Mi, 11 Feb, 2004 at 17:00:15 +0100, Marcel Holtmann wrote:
> Hi Radu,
> 
> > /var/log/daemon.log sais:
> > bthid[19500]: Bluetooth HID service started
> > 
> > after a few seconds I get the message:
> > bthid[19500]: Connection failed: Function not implemented (38)
> 
> this can be a paring problem, because the Apple HID devices don't allow
> unencrypted connections. Run "hcidump -w <file>" so I can see what is on
> the HCI layer.

hi Marcel,

hcidump -w <file> seems to write a binary file. Do you nee that file? 
Anyway, if I don't give the -w option, it dumps this to stdout:

# hcidump
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection(0x01|0x0005) plen 13
> HCI Event: Command Status(0x0f) plen 4
> HCI Event: PIN Code Request(0x16) plen 6
> HCI Event: Connect Complete(0x03) plen 11

thanks
Radu
