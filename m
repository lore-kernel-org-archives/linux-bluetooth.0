Return-Path: <m_laverd@alcor.concordia.ca>
Date: Mon, 16 Feb 2004 15:17:40 -0500 (EST)
From: Marc-Andre Laverdiere-Papineau <m_laverd@alcor.concordia.ca>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Major slowdown when service discovery+opening a
 service happens on two systems trying to talk to each other
In-Reply-To: <1076921935.2840.43.camel@pegasus>
Message-ID: <Pine.OSF.4.44.0402161503210.336210-100000@alcor.concordia.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

Thanks Marcel for the help!

I'm not following all the terminology, since
I'm working with Java. I was wondering what you would suggest that would
be better for performance.

This project is about ad-hoc networking and so the devices need to be
constantly looking out for others that can be part of the network. The
design wasn't built thinking that performance would be so hit. Do you have
any idea why those two scenarios are different?

Scenario 1:
Device A: Device Discovery, Service Discovery, connects to Device B and
sends data
Device B: Device Discovery, Service Discovery, L2CAP service
This works super well. In this context the Service Discovery for Device B
never finds anything. I don't know if that makes a difference or not.

Scenario 2:
Device A: Device Discovery, Service Discovery, L2CAP service, connects to
Device B and sends data
Device B: Device Discovery, Service Discovery, L2CAP service
This makes me wish I never got in this project :(

On Mon, 16 Feb 2004, Marcel Holtmann wrote:
<snip>
> so it is possible that you run an inquiry while you page another device.
Actually, in the current situation, we have only 2 'devices', so they
boringly scan each other and that's it.

Hciconfig shows a few options for page scan (device discovery?) and
inquiry scan (service discovery?). Should I consider tweaking those?
> Actually I don't know if this is supported by any Bluetooth chips on the
> market. And you run an inquiry while you have an ACL link opened. This
> works with most devices that supports scatternet, but is not one of the
> best ideas and can decrease your performance. What does "hciconfig -a"
> say about your devices?
<snip>
It says:
# hciconfig hci0 up
# sdpd
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:0A:3A:50:9C:DA ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:69 acl:0 sco:0 events:8 errors:0
        TX bytes:27 acl:0 sco:0 commands:7 errors:0
        Features: 0xff 0xff 0x0b 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
0x20d
        Manufacturer: Cambridge Silicon Radio (10)
