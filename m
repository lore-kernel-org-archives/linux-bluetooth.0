Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <adf2d65c0611141259h2c2c8d60xd136a2b46813042c@mail.gmail.com>
Date: Tue, 14 Nov 2006 21:59:22 +0100
From: Arthur <avandorp@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1163485178.22566.2.camel@localhost>
MIME-Version: 1.0
References: <adf2d65c0611130332h65523aa1ycf17bce10e957f8e@mail.gmail.com>
	<1163485178.22566.2.camel@localhost>
Subject: Re: [Bluez-users] Targus ACB20EU: Scan times out
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1816736996=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1816736996==
Content-Type: multipart/alternative;
	boundary="----=_Part_46148_11841553.1163537962327"

------=_Part_46148_11841553.1163537962327
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel

> Scanning for other devices with the Targus ACB20EU USB dongle (a
> > bluetooth 2.0 adapter with EDR support according to the packaging)
> > always times out. It doesn't help to run hcid or hciconfig hci0 up
> > beforehand. This is how it looks like:
> >
> > # hcitool scan
> > Scanning ...
> > Inquiry failed: Connection timed out
> >
> > Running hcidump -X -V at the same time only yields this output:
> >
> > # hcidump -X -V
> > HCI sniffer - Bluetooth packet analyzer ver 1.32
> > device: hci0 snap_len: 1028 filter: 0xffffffff
> > < HCI Command: Inquiry (0x01|0x0001) plen 5
> >      lap 0x9e8b33 len 8 num 0
> >  > HCI Event: Command Complete (0x0e) plen 4
> >      Inquiry (0x01|0x0001) ncmd 1
> >      0000: 0c
>
> this is a broken chip anyway. The failure of HCI_Inquiry must be
> answered with a HCI_Command_Status event and not a HCI_Command_Complete
> event.
>
> Is this another Broadcom based dongle?
>
> Try loading the hci_usb with "reset=1" and post the content
> of /proc/bus/usb/devices.


A thousand thanks for your answer. Yes, now I can see that it's a Broadcom
BCM2045B2.
What's up with the "reset=1" parameter? I've now successfully paired it with
a Nokia BH-300 Headset and have it working with the btsco tools. :)
Wonderful.

Again, many thanks.

Regards

Arthur


For reference some data from /proc/bus/usb/devices and hciconfig -a:

# modprobe hci_usb reset=1
# cat /proc/bus/usb/devices
[... other devices ...]

T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  6 Spd=12  MxCh= 3
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
P:  Vendor=0a5c ProdID=4500 Rev= 1.00
S:  Manufacturer=Broadcom
S:  Product=BCM2045B2
C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   1 Ivl=255ms

T:  Bus=01 Lev=02 Prnt=06 Port=00 Cnt=01 Dev#=  7 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0a5c ProdID=2100 Rev= 1.00
S:  Manufacturer=Broadcom Corp
S:  Product=BCM92045DG-Flash_UHE
C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:  If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  32 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  32 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
E:  Ad=83(I) Atr=01(Isoc) MxPS=  64 Ivl=1ms
E:  Ad=03(O) Atr=01(Isoc) MxPS=  64 Ivl=1ms
I:  If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
E:  Ad=84(I) Atr=02(Bulk) MxPS=  32 Ivl=0ms
E:  Ad=04(O) Atr=02(Bulk) MxPS=  32 Ivl=0ms
I:  If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

# hciconfig -a
hci0:   Type: USB
        BD Address: 00:16:38:3A:63:5E ACL MTU: 1017:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:1045 acl:0 sco:0 events:47 errors:0
        TX bytes:358 acl:0 sco:0 commands:24 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'hobbes-0'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object Transfer,
Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP Subver:
0x415c
        Manufacturer: Broadcom Corporation (15)

------=_Part_46148_11841553.1163537962327
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel<br><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; Scanning for other devices with the Targus ACB20EU USB dongle (a<br>
&gt; bluetooth 2.0 adapter with EDR support according to the packaging)<br>&gt; always times out. It doesn't help to run hcid or hciconfig hci0 up<br>&gt; beforehand. This is how it looks like:<br>&gt;<br>&gt; # hcitool scan
<br>&gt; Scanning ...<br>&gt; Inquiry failed: Connection timed out<br>&gt;<br>&gt; Running hcidump -X -V at the same time only yields this output:<br>&gt;<br>&gt; # hcidump -X -V<br>&gt; HCI sniffer - Bluetooth packet analyzer ver 
1.32<br>&gt; device: hci0 snap_len: 1028 filter: 0xffffffff<br>&gt; &lt; HCI Command: Inquiry (0x01|0x0001) plen 5<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;lap 0x9e8b33 len 8 num 0<br>&gt;&nbsp;&nbsp;&gt; HCI Event: Command Complete (0x0e) plen 4<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Inquiry (0x01|0x0001) ncmd 1
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;0000: 0c<br><br>this is a broken chip anyway. The failure of HCI_Inquiry must be<br>answered with a HCI_Command_Status event and not a HCI_Command_Complete<br>event.<br><br>Is this another Broadcom based dongle?
<br><br>Try loading the hci_usb with &quot;reset=1&quot; and post the content<br>of /proc/bus/usb/devices.</blockquote><div><br>A thousand thanks for your answer. Yes, now I can see that it's a Broadcom BCM2045B2.<br>What's up with the &quot;reset=1&quot; parameter? I've now successfully paired it with a Nokia BH-300 Headset and have it working with the btsco tools. :) Wonderful.
<br><br>Again, many thanks.<br><br>Regards<br><br>Arthur<br><br><br>For reference some data from /proc/bus/usb/devices and hciconfig -a:<br><br># modprobe hci_usb reset=1<br># cat /proc/bus/usb/devices<br>[... other devices ...]
<br><br>T:&nbsp; Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=&nbsp; 6 Spd=12&nbsp; MxCh= 3<br>D:&nbsp; Ver= 2.00 Cls=09(hub&nbsp; ) Sub=00 Prot=00 MxPS= 8 #Cfgs=&nbsp; 1<br>P:&nbsp; Vendor=0a5c ProdID=4500 Rev= 1.00<br>S:&nbsp; Manufacturer=Broadcom<br>S:&nbsp; Product=BCM2045B2
<br>C:* #Ifs= 1 Cfg#= 1 Atr=a0 MxPwr=100mA<br>I:&nbsp; If#= 0 Alt= 0 #EPs= 1 Cls=09(hub&nbsp; ) Sub=00 Prot=00 Driver=hub<br>E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp; 1 Ivl=255ms<br><br>T:&nbsp; Bus=01 Lev=02 Prnt=06 Port=00 Cnt=01 Dev#=&nbsp; 7 Spd=12&nbsp; MxCh= 0
<br>D:&nbsp; Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=&nbsp; 1<br>P:&nbsp; Vendor=0a5c ProdID=2100 Rev= 1.00<br>S:&nbsp; Manufacturer=Broadcom Corp<br>S:&nbsp; Product=BCM92045DG-Flash_UHE<br>C:* #Ifs= 4 Cfg#= 1 Atr=a0 MxPwr=&nbsp; 0mA<br>
I:&nbsp; If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<br>E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp; 16 Ivl=1ms<br>E:&nbsp; Ad=82(I) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<br>E:&nbsp; Ad=02(O) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<br>I:&nbsp; If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms
<br>I:&nbsp; If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb
<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 32 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 32 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms
<br>I:&nbsp; If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=hci_usb<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 64 Ivl=1ms<br>I:&nbsp; If#= 2 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=ff Driver=(none)
<br>E:&nbsp; Ad=84(I) Atr=02(Bulk) MxPS=&nbsp; 32 Ivl=0ms<br>E:&nbsp; Ad=04(O) Atr=02(Bulk) MxPS=&nbsp; 32 Ivl=0ms<br>I:&nbsp; If#= 3 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)<br><br># hciconfig -a<br>hci0:&nbsp;&nbsp; Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:16:38:3A:63:5E ACL MTU: 1017:8 SCO MTU: 64:8
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:1045 acl:0 sco:0 events:47 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:358 acl:0 sco:0 commands:24 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'hobbes-0'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x3e0100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Service Classes: Networking, Rendering, Capturing, Object Transfer, Audio
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: 0x2000 LMP Ver: 2.0 (0x3) LMP Subver: 0x415c<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corporation (15)<br><br><br><br>&nbsp;</div><br></div><br>

------=_Part_46148_11841553.1163537962327--


--===============1816736996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1816736996==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1816736996==--
