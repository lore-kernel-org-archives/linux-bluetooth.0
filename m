Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] L2Ping / Rfcomm connect : Function not implemented
References: <200412122356.09617.wim.delvaux@adaptiveplanet.com> <1102924939.8750.84.camel@pegasus>
In-Reply-To: <1102924939.8750.84.camel@pegasus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200412131147.13321.wim.delvaux@adaptiveplanet.com>
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
Date: Mon, 13 Dec 2004 11:47:13 +0100

On Monday 13 December 2004 09:02, Marcel Holtmann wrote:
> Hi Wim,
>
> > If I  execute on my 3870 Ipaq
> >
> > l2ping 00:60:57:35:81:B6
> >
> > Where the BDAddr is of a Nokial 6310 telephone
> >
> > I get the above error.
> >
> > Hcidump -x shows
> >
> >
> > < HCI Command: Create Connection(0x01|0x0005) plen 13
> >   B6 81 35 57 60 00 18 CC 02 00 00 00 01
> >
> > > HCI Event: Command Status(0x0f) plen 4
> >
> >   00 01 05 04
> >
> > > HCI Event: Connect Complete(0x03) plen 11
> >
> >   1F 00 00 B6 81 35 57 60 00 01 00
> >
> > If I read the specs properly 0x1f is a 'unspecified error' ;-(
> >
> > What could be wrong ?
>
> show us "hciconfig -a" from the iPAQ.

hci0:   Type: UART
        BD Address: 00:02:C7:0D:85:96 ACL MTU: 128:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH
        RX bytes:1181186 acl:3150 sco:0 events:1857 errors:0
        TX bytes:220702 acl:2025 sco:0 commands:49 errors:0
        Features: 0xff 0xff 0x05 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'familiar'
        Class: 0x120112
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Handheld
        HCI Ver: 1.1 (0x1) HCI Rev: 0x72 LMP Ver: 1.1 (0x1) LMP Subver: 0x72
        Manufacturer: Cambridge Silicon Radio (10)

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
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
