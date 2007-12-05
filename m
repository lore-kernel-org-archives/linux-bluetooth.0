Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <bc2917430712050434y7c3eb69bm57fce2702c977f64@mail.gmail.com>
Date: Wed, 5 Dec 2007 13:34:21 +0100
From: "Franck F" <celos94@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1196839466.12292.154.camel@violet>
MIME-Version: 1.0
References: <bc2917430712040950x21220f7an64d0d558939d42f7@mail.gmail.com>
	<1196839466.12292.154.camel@violet>
Subject: Re: [Bluez-users] Dell D830 laptop BT card doesn't start
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0800970869=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0800970869==
Content-Type: multipart/alternative;
	boundary="----=_Part_2828_4122248.1196858061640"

------=_Part_2828_4122248.1196858061640
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel, thanks for the previous answer :)

> I've been trying to make my embedded bluetooth card work, but it seems
> > i have a big problem...
> > Before explaining it, here is my hardware specification:
> > Dell D830 laptop, and my bluetooth card (running lsusb):
> > Bus 001 Device 003: ID 413c:8140 Dell Computer Corp. Wireless 360
> > Bluetooth
>
> show me /proc/bus/usb/devices for your card.


T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=413c ProdID=8140 Rev=43.15
C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)

> I have installed bluez-utils, bluez-libs, bluetooth, everything that
> > is seem to be needed.
> >
> > Here is what hciconfig give me:
> > hci0:   Type: USB
> >         BD Address: 00:1A:6B:8A:xx:xx ACL MTU: 310:10 SCO MTU: 64:8
> >         UP RUNNING PSCAN ISCAN
> >         RX bytes:4134 acl:0 sco:0 events:136 errors:0
> >         TX bytes:2047 acl:0 sco:0 commands:133 errors:0
> >
> > So my BT card seems to work ... but when I run a scan or an inq (with
> > hcitool), nothing is found. Also, the bluetooth led of my laptop is
> > off ...
> >
> > After doing many test, i was wondering if it was not a hardware
> > problem, so i have boot to windows to see if my card words. Everything
> > worked fine, the led was on, the scan showed my phone. Then i reboot
> > on linux, and here is the thing weird, my bluetooth card was still
> > working (the led was on).
> >
> > So i start bluetooth daemon (hcid, sdpd), i run a scan, and my phone
> > is found !!!
> >
> > The problem seems to be the bluetooth card doesn't "start"/"stop" on
> > linux (the led story confirms that). So, is there a way to solve this
> > thing ? Have I done something wrong ?
>
> The card might need a special init sequence to make it work. You can try
> to load hci_usb with reset=1 module option. That might be enough.



I tried and nothing change :(

-- 
Franck.

------=_Part_2828_4122248.1196858061640
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Marcel, thanks for the previous answer :)<br><span class="gmail_quote"></span><br><div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; I&#39;ve been trying to make my embedded bluetooth card work, but it seems
<br>&gt; i have a big problem...<br>&gt; Before explaining it, here is my hardware specification:<br>&gt; Dell D830 laptop, and my bluetooth card (running lsusb):<br>&gt; Bus 001 Device 003: ID 413c:8140 Dell Computer Corp. Wireless 360
<br>&gt; Bluetooth<br><br>show me /proc/bus/usb/devices for your card. </blockquote><div><br>T:&nbsp; Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=&nbsp; 3 Spd=12&nbsp; MxCh= 0<br>D:&nbsp; Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=&nbsp; 1
<br>P:&nbsp; Vendor=413c ProdID=8140 Rev=43.15<br>C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=&nbsp; 0mA<br>I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>E:&nbsp; Ad=81(I) Atr=03(Int.) MxPS=&nbsp; 16 Ivl=1ms<br>E:&nbsp; Ad=02(O) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms
<br>E:&nbsp; Ad=82(I) Atr=02(Bulk) MxPS=&nbsp; 64 Ivl=0ms<br>I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 17 Ivl=1ms
<br>I:&nbsp; If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 25 Ivl=1ms<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 25 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 33 Ivl=1ms<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 33 Ivl=1ms<br>I:&nbsp; If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>E:&nbsp; Ad=03(O) Atr=01(Isoc) MxPS=&nbsp; 49 Ivl=1ms<br>E:&nbsp; Ad=83(I) Atr=01(Isoc) MxPS=&nbsp; 49 Ivl=1ms
<br>I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)</div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt; I have installed bluez-utils, bluez-libs, bluetooth, everything that
<br>&gt; is seem to be needed.<br>&gt;<br>&gt; Here is what hciconfig give me:<br>&gt; hci0:&nbsp;&nbsp; Type: USB<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:1A:6B:8A:xx:xx ACL MTU: 310:10 SCO MTU: 64:8<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>

&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:4134 acl:0 sco:0 events:136 errors:0<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:2047 acl:0 sco:0 commands:133 errors:0<br>&gt;<br>&gt; So my BT card seems to work ... but when I run a scan or an inq (with<br>&gt; hcitool), nothing is found. Also, the bluetooth led of my laptop is
<br>&gt; off ...<br>&gt;<br>&gt; After doing many test, i was wondering if it was not a hardware<br>&gt; problem, so i have boot to windows to see if my card words. Everything<br>&gt; worked fine, the led was on, the scan showed my phone. Then i reboot
<br>&gt; on linux, and here is the thing weird, my bluetooth card was still<br>&gt; working (the led was on).<br>&gt;<br>&gt; So i start bluetooth daemon (hcid, sdpd), i run a scan, and my phone<br>&gt; is found !!!<br>&gt;
<br>&gt; The problem seems to be the bluetooth card doesn&#39;t &quot;start&quot;/&quot;stop&quot; on<br>&gt; linux (the led story confirms that). So, is there a way to solve this<br>&gt; thing ? Have I done something wrong ?
<br><br>The card might need a special init sequence to make it work. You can try<br>to load hci_usb with reset=1 module option. That might be enough.</blockquote><div><br><br>I tried and nothing change :( <br></div><br></div>

-- <br>Franck.

------=_Part_2828_4122248.1196858061640--


--===============0800970869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============0800970869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0800970869==--
