Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Michal Semler <cijoml@volny.cz>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] usb trendnet
References: <41DC8010.7050600@debiancolombia.org> <1105014610.4299.28.camel@pegasus> <41F94E81.90207@debiancolombia.org>
In-Reply-To: <41F94E81.90207@debiancolombia.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200501280058.09843.cijoml@volny.cz>
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
Date: Fri, 28 Jan 2005 00:58:09 +0100

You can use OSI model on BlueZ using bnep=20

But you should understand, that Bluetooth devices usually don't use OSI, bu=
t=20
some of profiles supported via SDP and things like that.

Michal

Dne =E8t 27. ledna 2005 21:26 Fredy P. napsal(a):
> Marcel Holtmann escribi=F3:
> > Hi Fredy,
> >
> >>I read the HW compatible list, and no is in it usb trendnet adapters, is
> >>becouse are no tested or becouse are no soported?
> >>
> >>I read the user and developer list archives whit the word trendnet and i
> >>no get information.
> >>
> >>I neds buy a usb adapter, the trendent TBW-102UB have 1000m, buy it?
> >>are any other 100m tested in linux?
> >
> > you only know if it works if you buy it, but in general every USB
> > adapter works. However the CSR ones seem to work better than the rest,
> > but this is not a BlueZ problem.
> >
> > After you get it working send us "hciconfig -a" and the content
> > of /proc/bus/usb/devices.
>
> Hi Marcel, i buy the trendent TBW-102UB bluetooth usb adapter, i can see
> other devices and the other devices can see the pc but y can not send or
> recive information (the other device is a sonyericsson movil), i read
> but can understand very good, where can get information abut?
> i like see bluetooth in the OSI model for understand, you can help me
> whit a link?
>
> tanks and sorry my bad english
>
> # hciconfig -a
> hci0:   Type: USB
>          BD Address: 00:E0:98:D1:A8:B3 ACL MTU: 192:8  SCO MTU: 64:8
>          UP RUNNING PSCAN ISCAN
>          RX bytes:99 acl:0 sco:0 events:13 errors:0
>          TX bytes:296 acl:0 sco:0 commands:12 errors:0
>          Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>          Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>          Link policy: RSWITCH HOLD SNIFF PARK
>          Link mode: ACCEPT MASTER
>          Name: 'PINGU-0'
>          Class: 0x000100
>          Service Classes: Unspecified
>          Device Class: Computer, Uncategorized
>          HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP
> Subver: 0x20d
>          Manufacturer: Cambridge Silicon Radio (10)
> ################# end ################
>
> # cat /proc/bus/usb/devices
> T:  Bus=3D01 Lev=3D00 Prnt=3D00 Port=3D00 Cnt=3D00 Dev#=3D  1 Spd=3D12  M=
xCh=3D 2
> B:  Alloc=3D 27/900 us ( 3%), #Int=3D  1, #Iso=3D  2
> D:  Ver=3D 1.10 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 MxPS=3D 8 #Cfgs=3D  1
> P:  Vendor=3D0000 ProdID=3D0000 Rev=3D 0.00
> S:  Product=3DUSB OHCI Root Hub
> S:  SerialNumber=3Dcc2f1000
> C:* #Ifs=3D 1 Cfg#=3D 1 Atr=3D40 MxPwr=3D  0mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 1 Cls=3D09(hub  ) Sub=3D00 Prot=3D00 Driver=
=3Dhub
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D   2 Ivl=3D255ms
> T:  Bus=3D01 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D  2 Spd=3D12  M=
xCh=3D 0
> D:  Ver=3D 1.10 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1
> P:  Vendor=3D07b8 ProdID=3Db02a Rev=3D 5.25
> S:  Product=3DBluetooth USB Adapter
> C:* #Ifs=3D 3 Cfg#=3D 1 Atr=3D80 MxPwr=3D 86mA
> I:  If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms
> E:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> E:  Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms
> I:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms
> I:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=
=3Dhci_usb
> E:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms
> I:  If#=3D 2 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00 Driver=
=3D(none)
>   ######################### end #########################################
>
> PD: CSR =3D Cambridge Silicon Radio ?
>
> > Regards
> >
> > Marcel
> >
> >
> >
> >
> > -------------------------------------------------------
> > The SF.Net email is sponsored by: Beat the post-holiday blues
> > Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
> > It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users

=2D-=20
S pozdravem

Michal Semler


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
