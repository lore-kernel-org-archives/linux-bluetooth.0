Return-Path: <cyrus@holtmann.org>
Date: Tue, 31 Mar 2009 23:21:24 -0400
From: jayjwa <jayjwa@atr2.ath.cx>
To: Gene Heskett <gene.heskett@verizon.net>
cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: Newbie, can't find device
In-Reply-To: <200903300928.02545.gene.heskett@verizon.net>
Message-ID: <alpine.LNX.2.00.0903312308510.7564@nge2.ngu.pk>
References: <200903252037.03024.gene.heskett@verizon.net> <200903262205.52669.gene.heskett@verizon.net> <alpine.LNX.2.00.0903292339240.32436@nge2.ngu.pk> <200903300928.02545.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On Mon, 30 Mar 2009, Gene Heskett wrote:

> Last night I went through a make xconfig with the intent of turning on the
> module building of anything even remotely related, rebuilt 2.6.28.9 and
> rebooted. FWIW, 2.6.29 is unusable due to loss of networking problems at about
> a 24 hour uptime.
>
> hciconfig -a now returns:
>
> [root@coyote /]# hciconfig -a
> hci0:   Type: USB
>        BD Address: 11:11:11:11:11:11 ACL MTU: 672:3 SCO MTU: 48:1
>        UP RUNNING PSCAN ISCAN
>        RX bytes:1416 acl:0 sco:0 events:53 errors:0
>        TX bytes:475 acl:0 sco:0 commands:53 errors:0
>        Features: 0xff 0x3e 0x85 0x38 0x18 0x18 0x00 0x00
>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>        Link policy: RSWITCH HOLD SNIFF PARK
>        Link mode: SLAVE ACCEPT
>        Name: 'coyote.coyote.den-0'
>        Class: 0x022104
>        Service Classes: Networking
>        Device Class: Computer, Desktop workstation
>        HCI Ver: 2.0 (0x3) HCI Rev: 0x1f4 LMP Ver: 2.0 (0x3) LMP Subver: 0x1f4
>        Manufacturer: CONWISE Technology Corporation Ltd (66)

That looks better. It should be OK now. Maybe it was missing a module.

> And on the reboot, there was a /net directory created on the / drive, but its
> empty.

Not sure what that is, but it's not related to Bluetooth. The only "/net" 
directories I'm familiar with are /ect/net from the 'etcnet' Linux networking 
project, and the 'net' directory created in the modules tree by Madwifi 
wireless kernel module install. Some people make a '/mnt/net' for things like 
NFS remote filesystem mounts ...


> From dmseg now:
> [root@coyote linux-2.6.28.9]# dmesg |grep Bluetooth
> [    8.998327] Bluetooth: Core ver 2.13
> [    8.998405] Bluetooth: HCI device and connection manager initialized
> [    8.998407] Bluetooth: HCI socket layer initialized
> [    9.140422] Bluetooth: Generic Bluetooth USB driver ver 0.3
> [   21.147971] Bluetooth: L2CAP ver 2.11
> [   21.147974] Bluetooth: L2CAP socket layer initialized
> [   21.304643] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
> [   21.304646] Bluetooth: BNEP filters: protocol multicast
> [   21.402288] Bluetooth: SCO (Voice Link) ver 0.6
> [   21.402291] Bluetooth: SCO socket layer initialized
> [   22.124825] Bluetooth: RFCOMM socket layer initialized
> [   22.124837] Bluetooth: RFCOMM TTY layer initialized
> [   22.124838] Bluetooth: RFCOMM ver 1.10
>
> But there is not yet a /dev/hciX device being created.

That's expected because no such thing exists, the same as there's no 
"/dev/eth0" or such on Linux.


> What is next?

That depends on what you want to do exactly. You should be able to follow the 
commands from my first post, to bind an rfcomm device (assuming you're trying 
to connect to something like a bluetooth modem, since you mentioned Minicom). 
You should be able to view the services available on the remote system now:


sdptool browse <address>

Find the one you want, and note the channel it's on. You can then use rfcomm, 
which should make your /dev/rfcomm0 device that's giving access to the remote 
device at the specified channel. See 'rfcomm --help' for rfcomm commands (it 
doesn't have a "--help" parameter, but doing that will cause the same output 
as if it did.)


