Return-Path: <jon@valvatne.com>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Jon Valvatne <jon@valvatne.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087510775.4309.86.camel@pegasus>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
	 <1087510775.4309.86.camel@pegasus>
Content-Type: text/plain
Message-Id: <1087511321.3103.32.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 00:28:42 +0200
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2004-06-18 at 00:19, Marcel Holtmann wrote:
> Hi Jon,
> 
> > > do you've activated the role switch support on your host device?
> > 
> > I believe so:
> > 
> > # hciconfig hci0 lm
> > hci0:   Type: PCCARD
> >         BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
> >         Link mode: ACCEPT MASTER 
> > # hciconfig hci0 lp
> > hci0:   Type: PCCARD
> >         BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
> >         Link policy: RSWITCH HOLD SNIFF PARK 
> 
> show us the output of "hciconfig -a".

# hciconfig -a
hci0:   Type: PCCARD
        BD Address: 00:E0:03:25:3E:29 ACL MTU: 340:4  SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN 
        RX bytes:1374134 acl:63939 sco:0 events:4549 errors:0
        TX bytes:741932 acl:3358 sco:0 commands:158 errors:0
        Features: 0xbf 0x00 0x20 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 
        Link policy: RSWITCH HOLD SNIFF PARK 
        Link mode: ACCEPT MASTER 
        Name: 'BlueZ (0)'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x0 LMP Ver: 1.1 (0x1) LMP Subver:
0x21a
        Manufacturer: Nokia Mobile Phones (1)

> 
> > # hidd --server --nodaemon
> > hidd[6666]: Bluetooth HID daemon
> > hidd[6666]: New HID device 00:07:61:1A:78:E2 (Logitech Bluetooth Mouse)
> > 
> > ... and then nothing when I try to use the keyboard. Is there something
> > I've overlooked regarding the role-switch stuff?
> > 
> > I've done some simple debugging in hidd's main.c, which so far only
> > reveals that the poll() call in run_server() fails to produce any new
> > events once the first create_device() call has been made. The problem
> > doesn't appear to be caused inside hidd itself though, because killing
> > and restarting it after it's established the connection to the first
> > device doesn't help it discover the second one.
> > 
> > Any pointers to where else I might look for the bug? I'm afraid I don't
> > really know my way around BlueZ internals.
> 
> Check with "hcidump -x" what happens when you press a button of your
> second device.

Nothing at all, I'm afraid.

Jon
