Return-Path: <jon@valvatne.com>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Jon Valvatne <jon@valvatne.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087504160.4309.78.camel@pegasus>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
Content-Type: text/plain
Message-Id: <1087507199.3103.27.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Thu, 17 Jun 2004 23:19:59 +0200
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, 2004-06-17 at 22:29, Marcel Holtmann wrote:
> Hi Jon,
> 
> > I've got my Logitech diNovo mouse & keyboard working with BlueZ by
> > finding them manually with hidd (with '--search' or '--connect <addr>').
> > But for some reason 'hidd --server' doesn't want to recognize both of
> > the devices at the same time: When it starts up it will detect whichever
> > device I use first, and not the other.
> > 
> > In other words, if I start typing on my keyboard after starting hidd, it
> > will work, but the mouse won't. If I start by clicking the mouse, that
> > will work, but the keyboard won't. This happens consistently, and the
> > non-working device will only start working if I first press its little
> > 'connect' button and then manually connect it with 'hidd --connect
> > <addr>'.
> > 
> > Has anyone experienced anything like this? I can't imagine this is
> > intended or required behavior; if it can recognize one, why not the
> > other?
> 
> do you've activated the role switch support on your host device?
> 

I believe so:

# hciconfig hci0 lm
hci0:   Type: PCCARD
        BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
        Link mode: ACCEPT MASTER 
# hciconfig hci0 lp
hci0:   Type: PCCARD
        BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
        Link policy: RSWITCH HOLD SNIFF PARK 
# hidd --server --nodaemon
hidd[6666]: Bluetooth HID daemon
hidd[6666]: New HID device 00:07:61:1A:78:E2 (Logitech Bluetooth Mouse)

... and then nothing when I try to use the keyboard. Is there something
I've overlooked regarding the role-switch stuff?

I've done some simple debugging in hidd's main.c, which so far only
reveals that the poll() call in run_server() fails to produce any new
events once the first create_device() call has been made. The problem
doesn't appear to be caused inside hidd itself though, because killing
and restarting it after it's established the connection to the first
device doesn't help it discover the second one.

Any pointers to where else I might look for the bug? I'm afraid I don't
really know my way around BlueZ internals.

Jon
