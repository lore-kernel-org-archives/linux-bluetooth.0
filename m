Return-Path: <ashuang@gmail.com>
Message-ID: <ef9938ec0408131032bc7d05f@mail.gmail.com>
Date: Fri, 13 Aug 2004 13:32:49 -0400
From: Albert Huang <ashuang@gmail.com>
Reply-To: Albert Huang <ashuang@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Re: [Bluez-devel] want duplicate inquiry results during a single device inquiry
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1092416317.28711.258.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <ef9938ec04081309406c2abae3@mail.gmail.com> <1092416317.28711.258.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

on the HP iPAQ h5550:
# hciconfig -a
hci0:   Type: UART
        BD Address: 08:00:17:1B:0A:21 ACL MTU: 339:4  SCO MTU: 60:9
        UP RUNNING PSCAN ISCAN
        RX bytes:84 acl:0 sco:0 events:10 errors:1
        TX bytes:298 acl:0 sco:0 commands:10 errors:0
        Features: 0x00 0x00 0x00 0x00
        Packet type: DM1 DH1 HV1
        Link policy: HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'familiar (0)'
        Class: 0x120112
        Service Classes: Networking, Object Transfer
        Device Class: Computer, Handheld
        HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
        Manufacturer: RTX Telecom A/S (21)

on the desktop (d-link DBT-120):
# hciconfig -a
hci0:   Type: USB
        BD Address: 00:80:C8:35:19:C8 ACL MTU: 192:8  SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN 
        RX bytes:8308 acl:0 sco:0 events:450 errors:0
        TX bytes:2202 acl:0 sco:0 commands:338 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
        Link policy: HOLD SNIFF PARK 
        Link mode: SLAVE ACCEPT 
        Name: 'OKN-32-G838'
        Class: 0x000100
        Service Classes: Unspecified
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x1bb LMP Ver: 1.1 (0x1) LMP Subver: 0x1bb
        Manufacturer: Cambridge Silicon Radio (10)

-albert

On Fri, 13 Aug 2004 18:58:37 +0200, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Albert,
> 
> 
> 
> > While experimenting with a hp ipaq running a 2.4.19 kernel, I noticed
> > that during a since device inquiry, multiple EVT_INQUIRY_RESULT events
> > could be generated from the same remote device.  The inquiry was done
> > using a raw hci socket.  On x86 PCs running the same userland code but
> > with more recent versions of bluez and the linux kernel, the duplicate
> > events are no longer generated.  Instead, during a single inquiry, a
> > response will be received from a remote device at most once.
> >
> > I'm assuming that sometime in the recent past, kernel level caching
> > was implemented to prevent these duplicate inquiry results from
> > propagating up to user land.  Is there a way to turn this off, so that
> > all inquiry results are passed through?
> 
> this is device specific and can be controlled by a HCI command. Show us
> the outputs of "hciconfig -a" for both devices.
> 
> Regards
> 
> Marcel
> 
>
