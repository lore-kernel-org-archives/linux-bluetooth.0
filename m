Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: "soraberri" <malfonso@able.es>
Message-ID: <cnv835$fvn$1@sea.gmane.org>
References: <cnv248$vgv$1@sea.gmane.org> <1101204892.26578.63.camel@pegasus>
Subject: [Bluez-users] Re: seems that device is not found
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 23 Nov 2004 12:48:07 +0100

Thanks Marcel!
Well, I'm enjoying quite a lot now...
I wasn't able to execute hciconfig, it is not in the path variable by
default so I have to fix it.
Once I discovered the hciconfig tool I got very happy and set the device up
(by the way I needed root privileges)
So far, so good:
[root@castejon sbin]# ./hciconfig -a hci0 up
[root@castejon sbin]# ./hciconfig -a
hci0:   Type: USB
        BD Address: 00:10:60:A5:96:AA ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:71 acl:0 sco:0 events:8 errors:0
        TX bytes:31 acl:0 sco:0 commands:8 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'Luis'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0x33c LMP Ver: 1.1 (0x1) LMP Subver:
0x33c
        Manufacturer: Cambridge Silicon Radio (10)

Thanks!

"Marcel Holtmann" <marcel@holtmann.org> escribió en el mensaje
news:1101204892.26578.63.camel@pegasus...
> Hi,
>
> > OK, I have just installed a ready fresh Fedora Core 3 distribution
kernel
> > 2.6.9-1.667, no additional packages from bluez.org (I'm guessing they
are
> > included in my linux distribution, is this correct?). So, I plug a
> > Conceptronic CBT100U adapter device (listed in bluetooth adapter list
> > www.holtmann.org), execute hcitool dev, and all I get is:
> >
> > Devices:
> >
> > ...anything else. By the way, I get the same response in three different
> > linux boxes with the same kernel version.
> > I'm afraid this is not the best welcome I could hope, or it is? so I
would
> > like your opinion for that. Also, I wonder how can I know which of the
bluez
> > downloads should I install and which don't, and how can I know if they
are
> > already installed on my system (also Linux novice, excuses for that..)
>
> check with "hciconfig -a" if your device is detected and if it is up and
> running.
>
> Regards
>
> Marcel
>
>
>
>
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://productguide.itmanagersjournal.com/





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
