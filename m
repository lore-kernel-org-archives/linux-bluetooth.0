Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alex <welpan@gmx.de>
To: "Nicholas A. Preyss" <nalp@gmx.net>, bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Error message
References: <200405211611.38038.welpan@gmx.de> <20040521172502.GA15835@gmx.net>
In-Reply-To: <20040521172502.GA15835@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200405211928.52193.welpan@gmx.de>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 21 May 2004 19:28:52 +0200

A
> On  0, Alex <welpan@gmx.de> wrote:
> > Okay this is  my first mail in this list, so I am sorry for mistakes.
> > I try to connect a Headset with a dongle.
> > The problem begins if  I plug in my dongle  and boot my System, my Syst=
em
> > hangs.
>
> Do you use ehci-hcd driver for USB2.0? What does the syslog say, after
> plugging in the dongle.
Yes is installed and ohci, uhci
Syslog:
May 21 19:27:02 welpix usb.agent[1928]:      hci_usb: already loaded
May 21 19:27:02 welpix hcid[1593]: HCI dev 0 registered
May 21 19:27:02 welpix usb.agent[1962]:      hci_usb: already loaded
May 21 19:27:02 welpix kernel: i810_audio: drain_dac, dma timeout?
May 21 19:27:02 welpix hcid[1593]: HCI dev 0 up
May 21 19:27:02 welpix hcid[1593]: Starting security manager 0
May 21 19:27:02 welpix kernel: hci_scodata_packet: hci0 SCO packet for unkn=
own=20
connection handle 0
May 21 19:27:12 welpix last message repeated 49999 times
May 21 19:27:12 welpix kernel: cket: hci0 SCO packet for unknown connection=
=20
handle 0
May 21 19:27:12 welpix kernel: hci_scodata_packet: hci0 SCO packet for unkn=
own=20
connection handle 0
May 21 19:27:13 welpix last message repeated 2290 times
May 21 19:27:13 welpix pppd[1477]: Serial connection established.
May 21 19:27:13 welpix kernel: hci_scodata_packet: hci0 SCO packet for unkn=
own=20
connection handle 0

>
> > So i plugged my dongle after booting my System i get this message:
> > hci_scodata_packet :hci0 sco packet unknown connection for handle 0
> >
> > I killed this message and  make : hciconfig
> > Nothing is found
>
> You can kill a message?

Sorry, I cannot kill a message I killed the Service (its a never ending=20
message), that make this message.

> > I make this in KDE-Shell
> > no Error message , hciconfig find my dongle
>
> Plz post the output of "hciconfig -a" if dongle is recognized.

hciconfig -a
hci0: =A0 Type: USB
=A0 =A0 =A0 =A0 BD Address: 08:00:17:13:82:61 ACL MTU: 339:4 =A0SCO MTU: 60=
:9
=A0 =A0 =A0 =A0 UP RUNNING PSCAN ISCAN
=A0 =A0 =A0 =A0 RX bytes:128797 acl:0 sco:37800 events:14 errors:0
=A0 =A0 =A0 =A0 TX bytes:300 acl:0 sco:0 commands:13 errors:0
=A0 =A0 =A0 =A0 Features: 0xff 0x3a 0x05 0x00 0x00 0x00 0x00 0x00
=A0 =A0 =A0 =A0 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
=A0 =A0 =A0 =A0 Link policy: HOLD SNIFF PARK
=A0 =A0 =A0 =A0 Link mode: SLAVE ACCEPT
=A0 =A0 =A0 =A0 Name: 'welpix-0'
=A0 =A0 =A0 =A0 Class: 0x000100
=A0 =A0 =A0 =A0 Service Classes: Unspecified
=A0 =A0 =A0 =A0 Device Class: Computer, Uncategorized
=A0 =A0 =A0 =A0 HCI Ver: 1.1 (0x1) HCI Rev: 0x178 LMP Ver: 1.1 (0x1) LMP Su=
bver: 0x178
=A0 =A0 =A0 =A0 Manufacturer: RTX Telecom A/S (21)


> > I can scan for headset and find it, but i cant get any connection.
> >
> > I make hcidump, I get this message:
> >
> > SCO data: handle 0x0000 dlen0
>
> Maybe you can post the whole hcidump trace not only a single line.

This is the whole message, its running over my Monitor.
>
> > My System: Debian unstable
> >                    Kernel 2.6.6
> > installed bluez packages:
> > 		   bluez-bluefw
> >   		   bluez-hcidump
> >                  bluez-utils
> > 		   bluez-pan
> >                  bluez-pin
>
> The Packages in unstable are a bit outdated. But I don't believe this
> can be the reason.

I use the bluez debian mirror

> nicholas
>
> You can contact me in german as well, but if please directly by mail.

>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: Oracle 10g
> Get certified on the hottest thing ever to hit the market... Oracle 10g.
> Take an Oracle 10g class now, and we'll give you the exam FREE.
> http://ads.osdn.com/?ad_id=3D3149&alloc_id=3D8166&op=3Dclick
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
