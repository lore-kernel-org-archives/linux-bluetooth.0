Return-Path: <jon@valvatne.com>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Jon Valvatne <jon@valvatne.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087511911.4309.94.camel@pegasus>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
	 <1087510775.4309.86.camel@pegasus>
	 <1087511321.3103.32.camel@localhost.localdomain>
	 <1087511911.4309.94.camel@pegasus>
Content-Type: text/plain
Message-Id: <1087512926.3103.51.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 00:55:27 +0200
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2004-06-18 at 00:38, Marcel Holtmann wrote: 
> Hi Jon,
> 
> > > show us the output of "hciconfig -a".
> > 
> > # hciconfig -a
> > hci0:   Type: PCCARD
> >         BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
> >         UP RUNNING PSCAN ISCAN 
> >         RX bytes:1374134 acl:63939 sco:0 events:4549 errors:0
> >         TX bytes:741932 acl:3358 sco:0 commands:158 errors:0
> >         Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
> >         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 
> >         Link policy: RSWITCH HOLD SNIFF PARK 
> >         Link mode: ACCEPT MASTER 
> >         Name: 'BlueZ (0)'
> >         Class: 0x000100
> >         Service Classes: Unspecified
> >         Device Class: Computer, Uncategorized
> >         HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver:
> > 0x21a
> >         Manufacturer: Nokia Mobile Phones (1)
> 
> this looks like a card problem. Do "hciconfig hci0 features" show the
> role switch support? May you try the link mode accept and slave, because
> the hidd will force the role switch by itself.

Yep:

# hciconfig hci0 features
hci0:   Type: PCCARD
        BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
        Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset> 
                <timing accuracy> <role switch> <sniff mode> 

And I tried with accept and slave; no change.

> > > Check with "hcidump -x" what happens when you press a button of your
> > > second device.
> > 
> > Nothing at all, I'm afraid.
> 
> In this case it is on the link manager level and I can't debug it.

Can anyone? This may be a silly question, but what exactly is the link
manager? Is there anything I can do to track the problem down, or should
I just give up?

Just to make sure I've understood this right: The problem is that once
the first connection is set up, the link manager won't accept (or
detect?) another incoming connection. The reason it works when I do it
manually is that the connect button on the keyboard makes the keyboard
listen for a connection, and the subsequent 'hidd --connect <addr>'
makes the CF card connect to the keyboard. Is that right?

Jon
