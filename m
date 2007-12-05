Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <bc2917430712050522y53baf906q1c13111b5125f90d@mail.gmail.com>
Date: Wed, 5 Dec 2007 14:22:56 +0100
From: "Franck F" <celos94@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <1196859942.12292.179.camel@violet>
MIME-Version: 1.0
References: <bc2917430712040950x21220f7an64d0d558939d42f7@mail.gmail.com>
	<1196839466.12292.154.camel@violet>
	<bc2917430712050434y7c3eb69bm57fce2702c977f64@mail.gmail.com>
	<1196859942.12292.179.camel@violet>
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
Content-Type: multipart/mixed; boundary="===============0120620531=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0120620531==
Content-Type: multipart/alternative;
	boundary="----=_Part_2960_14204734.1196860976252"

------=_Part_2960_14204734.1196860976252
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

2007/12/5, Marcel Holtmann <marcel@holtmann.org>:
>
> Hi Franck,
>
> >         > I've been trying to make my embedded bluetooth card work,
> >         but it seems
> >         > i have a big problem...
> >         > Before explaining it, here is my hardware specification:
> >         > Dell D830 laptop, and my bluetooth card (running lsusb):
> >         > Bus 001 Device 003: ID 413c:8140 Dell Computer Corp.
> >         Wireless 360
> >         > Bluetooth
> >
> >         show me /proc/bus/usb/devices for your card.
> >
> > T:  Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> > D:  Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=  1
> > P:  Vendor=413c ProdID=8140 Rev=43.15
> > C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=  0mA
> > I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=81(I) Atr=03(Int.) MxPS=  16 Ivl=1ms
> > E:  Ad=02(O) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > E:  Ad=82(I) Atr=02(Bulk) MxPS=  64 Ivl=0ms
> > I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   0 Ivl=1ms
> > I:  If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=   9 Ivl=1ms
> > I:  If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  17 Ivl=1ms
> > I:  If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  25 Ivl=1ms
> > I:  If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  33 Ivl=1ms
> > I:  If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
> > E:  Ad=03(O) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > E:  Ad=83(I) Atr=01(Isoc) MxPS=  49 Ivl=1ms
> > I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
>
> if I am not mistaken, then this is a CSR based dongle. Would need to
> decode the Rev=43.15 into the build id. However an easier way is when
> you boot into Windows first and then into Linux so the dongle works and
> then execute bccmd buildname (as root).


Here is the result of bccmd buildname:
Build name: cyt_8unified_fl_bt2.0_kymodo_21d_0702212310_encr56 2007-02-21

What should i do with that ?

>         The card might need a special init sequence to make it work.
> >         You can try
> >         to load hci_usb with reset=1 module option. That might be
> >         enough.
> >
> >
> > I tried and nothing change :(
>
> You could sniff the init sequence under Windows. Would help to find the
> init sequence.


hmm, How can i do that ? and what should i do when i'll find the init
sequence ?

Thanks again.
-- 
Franck F.

------=_Part_2960_14204734.1196860976252
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">2007/12/5, Marcel Holtmann &lt;<a href="mailto:marcel@holtmann.org">marcel@holtmann.org</a>&gt;:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi Franck,<br><br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; I&#39;ve been trying to make my embedded bluetooth card work,<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; but it seems<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; i have a big problem...<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Before explaining it, here is my hardware specification:
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Dell D830 laptop, and my bluetooth card (running lsusb):<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Bus 001 Device 003: ID 413c:8140 Dell Computer Corp.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wireless 360<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; Bluetooth<br>&gt;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; show me /proc/bus/usb/devices for your card.<br>&gt;<br>&gt; T:&nbsp;&nbsp;Bus=01 Lev=01 Prnt=01 Port=01 Cnt=01 Dev#=&nbsp;&nbsp;3 Spd=12&nbsp;&nbsp;MxCh= 0<br>&gt; D:&nbsp;&nbsp;Ver= 2.00 Cls=e0(unk. ) Sub=01 Prot=01 MxPS=64 #Cfgs=&nbsp;&nbsp;1<br>&gt; P:&nbsp;&nbsp;Vendor=413c ProdID=8140 Rev=
43.15<br>&gt; C:* #Ifs= 3 Cfg#= 1 Atr=e0 MxPwr=&nbsp;&nbsp;0mA<br>&gt; I:* If#= 0 Alt= 0 #EPs= 3 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>&gt; E:&nbsp;&nbsp;Ad=81(I) Atr=03(Int.) MxPS=&nbsp;&nbsp;16 Ivl=1ms<br>&gt; E:&nbsp;&nbsp;Ad=02(O) Atr=02(Bulk) MxPS=&nbsp;&nbsp;64 Ivl=0ms
<br>&gt; E:&nbsp;&nbsp;Ad=82(I) Atr=02(Bulk) MxPS=&nbsp;&nbsp;64 Ivl=0ms<br>&gt; I:* If#= 1 Alt= 0 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>&gt; E:&nbsp;&nbsp;Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms<br>&gt; E:&nbsp;&nbsp;Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 0 Ivl=1ms
<br>&gt; I:&nbsp;&nbsp;If#= 1 Alt= 1 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>&gt; E:&nbsp;&nbsp;Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>&gt; E:&nbsp;&nbsp;Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp; 9 Ivl=1ms<br>&gt; I:&nbsp;&nbsp;If#= 1 Alt= 2 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)
<br>&gt; E:&nbsp;&nbsp;Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp;17 Ivl=1ms<br>&gt; E:&nbsp;&nbsp;Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp;17 Ivl=1ms<br>&gt; I:&nbsp;&nbsp;If#= 1 Alt= 3 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>&gt; E:&nbsp;&nbsp;Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp;25 Ivl=1ms
<br>&gt; E:&nbsp;&nbsp;Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp;25 Ivl=1ms<br>&gt; I:&nbsp;&nbsp;If#= 1 Alt= 4 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>&gt; E:&nbsp;&nbsp;Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp;33 Ivl=1ms<br>&gt; E:&nbsp;&nbsp;Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp;33 Ivl=1ms
<br>&gt; I:&nbsp;&nbsp;If#= 1 Alt= 5 #EPs= 2 Cls=e0(unk. ) Sub=01 Prot=01 Driver=(none)<br>&gt; E:&nbsp;&nbsp;Ad=03(O) Atr=01(Isoc) MxPS=&nbsp;&nbsp;49 Ivl=1ms<br>&gt; E:&nbsp;&nbsp;Ad=83(I) Atr=01(Isoc) MxPS=&nbsp;&nbsp;49 Ivl=1ms<br>&gt; I:* If#= 2 Alt= 0 #EPs= 0 Cls=fe(app. ) Sub=01 Prot=00 Driver=(none)
<br><br>if I am not mistaken, then this is a CSR based dongle. Would need to<br>decode the Rev=43.15 into the build id. However an easier way is when<br>you boot into Windows first and then into Linux so the dongle works and
<br>then execute bccmd buildname (as root).</blockquote><div><br>Here is the result of bccmd buildname:<br>Build name: cyt_8unified_fl_bt2.0_kymodo_21d_0702212310_encr56 2007-02-21<br><br>What should i do with that ?<br></div>
<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The card might need a special init sequence to make it work.<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; You can try
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to load hci_usb with reset=1 module option. That might be<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enough.<br>&gt;<br>&gt;<br>&gt; I tried and nothing change :(<br><br>You could sniff the init sequence under Windows. Would help to find the
<br>init sequence.</blockquote><div><br>hmm, How can i do that ? and what should i do when i&#39;ll find the init sequence ?<br></div><br></div>Thanks again.<br>-- <br>Franck F.

------=_Part_2960_14204734.1196860976252--


--===============0120620531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
--===============0120620531==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0120620531==--
