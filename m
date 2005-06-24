Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <98e24d19050624042213b619f7@mail.gmail.com>
From: Joel - JFX <jfxbrazil@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] how to scan for other bluetooth device
In-Reply-To: <42BB637B.1010804@e28.com.hk>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_15100_2974870.1119612166455"
References: <Pine.LNX.4.44.0506231858020.7539-100000@zeskia.int.eridani.co.uk>
	 <42BB637B.1010804@e28.com.hk>
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
Date: Fri, 24 Jun 2005 08:22:46 -0300

------=_Part_15100_2974870.1119612166455
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

try this config on your hcid.conf

options {
autoinit yes;
security user;
pairing multi;
pin_helper /usr/bin/bluepin;
}=20

device {
name "(%d)";
class 0x120104;
iscan enable;
pscan enable;
lm accept;
lp hold,sniff,park;
auth enable;
encrypt enable;
}

if the hcitool scan works, you need to add your device address on=20
rfcomm.conf like this:

rfcomm0 {
bind yes;
device 01:07:E0:41:DD:62;
channel 3;
comment "my Palm";
}

if you need more devices, you can add a new rfcomm "conection" on your=20
rfcomm.conf:

rfcomm0 {
bind yes;
device 01:07:E0:41:DD:62;
channel 3;
comment "my Palm";
}
rfcomm1 {
bind yes;
device 02:08:E1:42:DE:63;
channel 3;
comment "my Mobile";
}

best regards,

Joel


2005/6/23, Jacky Cheung <jackycheung@e28.com.hk>:
> Hi all,
>=20
> My mobile device is MOTO A760. And set it is "Find Me"
>=20
> in the PC, here are my steps:
>=20
> # hciconfig hci0 up
> # hcitool scan
>=20
> Sometimes I saw it scanning from few seconds, sometimes it returns quickl=
y
>=20
> Thanks a lot
>=20
> Jacky Cheung
> cat /etc/bluetooth/hcid.conf
> #
> # HCI daemon configuration file.
> #
> # $Id: hcid.conf,v 1.7 2004/12/13 14:16:03 holtmann Exp $
> #
>=20
> # HCId options
> options {
> # Automatically initialize new devices
> autoinit yes;
>=20
> # Security Manager mode
> # none - Security manager disabled
> # auto - Use local PIN for incoming connections
> # user - Always ask user for a PIN
> #
> security auto;
>=20
> # Pairing mode
> # none - Pairing disabled
> # multi - Allow pairing with already paired devices
> # once - Pair once and deny successive attempts
> pairing multi;
>=20
> # PIN helper
> pin_helper /usr/bin/bluepin;
>=20
> # D-Bus PIN helper
> #dbus_pin_helper;
> }
>=20
> # Default settings for HCI devices
> device {
> # Local device name
> # %d - device id
> # %h - host name
> name "BlueZ (%d)";
>=20
> # Local device class
> class 0x3e0100;
>=20
> # Default packet type
> #pkt_type DH1,DM1,HV1;
>=20
> # Inquiry and Page scan
> iscan enable; pscan enable;
>=20
> # Default link mode
> # none - no specific policy
> # accept - always accept incoming connections
> # master - become master on incoming connections,
> # deny role switch on outgoing connections
> lm accept;
>=20
> # Default link policy
> # none - no specific policy
> # rswitch - allow role switch
> # hold - allow hold mode
> # sniff - allow sniff mode
> # park - allow park mode
> lp rswitch,hold,sniff,park;
>=20
> # Authentication and Encryption (Security Mode 3)
> #auth enable;
> #encrypt enable;
> }
> cat /etc/bluetooth/rfcomm.conf
> #
> # RFCOMM configuration file.
> #
> # $Id: rfcomm.conf,v 1.1 2002/10/07 05:58:18 maxk Exp $
> #
>=20
> rfcomm0 {
> # Automatically bind the device at startup
> bind no;
>=20
> # Bluetooth address of the device
> device 11:22:33:44:55:66;
>=20
> # RFCOMM channel for the connection
> channel 1;
>=20
> # Description of the connection
> comment "Example Bluetooth device";
> }
>=20
>=20
> Jacky Cheung <jackycheung@e28.com.hk> <mailto:jackycheung@e28.com.hk>
> Software Engineer
> E28 Hong Kong Limited
> Tel: 3105 0493 Fax: 3105 0495
> Unit 1003, Millennium City 3,
> 370 Kwun Tong Road,
> Hong Kong
>=20
>=20
> Michael McConnell wrote:
>=20
> >On Thu, 23 Jun 2005, Jacky Cheung wrote:
> >
> >
> >
> >>my mobile device is on.. and had tried hcitool scan., but no device=20
found
> >>
> >>
> >
> >With most mobile phones, you can have Bluetooth enabled with it set=20
"hidden",
> >that is, it won't respond to scans.
> >
> >Depending on the phone, you may have an option to toggle it visible or=
=20
hidden
> >(like the Nokia 6310i), or a "Find Me" option (like most Motorolas) that
> >makes the phone respond to scans for the next 60 seconds, after which it=
=20
will
> >revert to being hidden.
> >
> >
> >
> >>Joel - JFX wrote:
> >>
> >>
> >>
> >>>the bluetooth option like "visible" on your mobile are ON??
> >>>
> >>>you can scan using "hcitool scan"
> >>>
> >>>2005/6/23, Jacky Cheung <jackycheung@e28.com.hk>:
> >>>
> >>>
> >>>
> >>>
> >>>>Hi all,
> >>>>
> >>>>I am new to linux Bluetooth. I've got a question in paging other
> >>>>bluetooth device, says Bluetooth support phone.
> >>>>
> >>>>My PC is running in Redhat9.0, and I got a USB Bluetooth device. When=
=20
I
> >>>>plugin the Bluetooth device, I've got the following message from
> >>>>/var/log/message
> >>>>
> >>>>Jun 23 18:03:48 localhost kernel: hub.c: new USB device 00:1d.2-1,
> >>>>assigned address 5
> >>>>Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 registered
> >>>>Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 registered
> >>>>Jun 23 18:03:49 localhost hcid[2611]: HCI dev 0 up
> >>>>Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 up
> >>>>Jun 23 18:03:49 localhost hcid[2579]: Starting security manager 0
> >>>>Jun 23 18:03:49 localhost hcid[2611]: Starting security manager 0
> >>>>Jun 23 18:03:49 localhost /sbin/hotplug: no runnable
> >>>>/etc/hotplug/bluetooth.agent is installed
> >>>>Jun 23 18:03:52 localhost /etc/hotplug/usb.agent: Setup hci_usb for=
=20
USB
> >>>>product a12/1/1120
> >>>>
> >>>>Actually, I can see the Bluetooth device from hciconfig, and the phon=
e
> >>>>can scan the USB BT. However, I fail to scan the phone device in PC.=
=20
Is
> >>>>that I have missed some settings?
> >>>>
> >>>>Thanks
> >>>>
> >>>>Regards,
> >>>>Jacky Cheung
> >>>>
> >>>>-------------------------------------------------------
> >>>>SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
Migration Strategies
> >>>>
> >>>>
> >>>>from IBM. Find simple to follow Roadmaps, straightforward articles,
> >>>
> >>>
> >>>>informative Webcasts and more! Get everything you need to get up to
> >>>>speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3D=
click
> >>>>_______________________________________________
> >>>>Bluez-users mailing list
> >>>>Bluez-users@lists.sourceforge.net
> >>>>https://lists.sourceforge.net/lists/listinfo/bluez-users
> >>>>
> >>>>
> >>>>
> >>>>
> >>>>
> >>>-------------------------------------------------------
> >>>SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
Migration Strategies
> >>>
> >>>
> >>>from IBM. Find simple to follow Roadmaps, straightforward articles,
> >>
> >>
> >>>informative Webcasts and more! Get everything you need to get up to
> >>>speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=3Dclick
> >>>_______________________________________________
> >>>Bluez-users mailing list
> >>>Bluez-users@lists.sourceforge.net
> >>>https://lists.sourceforge.net/lists/listinfo/bluez-users
> >>>
> >>>
> >>>
> >>>
> >>>
> >>
> >>-------------------------------------------------------
> >>SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
Migration Strategies
> >>from IBM. Find simple to follow Roadmaps, straightforward articles,
> >>informative Webcasts and more! Get everything you need to get up to
> >>speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> >>_______________________________________________
> >>Bluez-users mailing list
> >>Bluez-users@lists.sourceforge.net
> >>https://lists.sourceforge.net/lists/listinfo/bluez-users
> >>
> >>
> >>
> >
> >-- Michael "Soruk" McConnell
> > Eridani Star System
> >
> > MailStripper - "The easy spam filter."
> > http://mailstripper.eridani.co.uk/
> >
> >
> >
> >-------------------------------------------------------
> >SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
Migration Strategies
> >from IBM. Find simple to follow Roadmaps, straightforward articles,
> >informative Webcasts and more! Get everything you need to get up to
> >speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcli=
ck
> >_______________________________________________
> >Bluez-users mailing list
> >Bluez-users@lists.sourceforge.net
> >https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
> >
> >
>=20
> -------------------------------------------------------
> SF.Net <http://SF.Net> email is sponsored by: Discover Easy Linux=20
Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

------=_Part_15100_2974870.1119612166455
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,<br><br>try this config on your hcid.conf<br><br>options {<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;autoinit yes;<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;security user;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;pairing multi;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;pin_helper /usr/bin/bluepin;<br>}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<br><br>device {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;name &q=
uot;(%d)&quot;;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;class 0x=
120104;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;iscan enable;<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;pscan enable;<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;lm accept;<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;lp hold,sniff,park;<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;auth enable;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;encrypt enable;
<br>}<br><br>if the hcitool scan works, you need to add your device address=
 on rfcomm.conf like this:<br><br>rfcomm0 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;bind yes;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;device <span style=3D"font-weight: bold; color: rgb(255, 0, 0);">01:0=
7:E0:41:DD:62
</span>;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;channel 3;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;comment &quot;my Palm&quot;;=
<br>}<br><br>if you need more devices, you can add a new rfcomm &quot;conec=
tion&quot; on your rfcomm.conf:<br><br>rfcomm0 {<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;bind yes;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;device=20
<span style=3D"color: rgb(255, 0, 0); font-weight: bold;">01:07:E0:41:DD:62=
</span>;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;channel 3;<br>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;comment &quot;my Palm&quot;;=
<br>}<br>rfcomm1 {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;bind =
yes;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;device 02:08:E1:42:=
DE:63;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;channel 3;<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;comment &quot;my Mobile&quot;;<br>}<br><=
br>
best regards,<br>
<br>
Joel<br><br><br>2005/6/23, Jacky Cheung &lt;<a href=3D"mailto:jackycheung@e=
28.com.hk">jackycheung@e28.com.hk</a>&gt;:<br>&gt; Hi all,<br>&gt; <br>&gt;=
 My mobile device is MOTO A760. And set it is &quot;Find Me&quot;<br>&gt;=
=20
<br>&gt; in the PC, here are my steps:<br>&gt; <br>&gt; # hciconfig hci0 up=
<br>&gt; # hcitool scan<br>&gt; <br>&gt; Sometimes I saw it scanning from f=
ew seconds, sometimes it returns quickly<br>&gt; <br>&gt; Thanks a lot<br>
&gt; <br>&gt; Jacky Cheung<br>&gt; cat /etc/bluetooth/hcid.conf<br>&gt; #<b=
r>&gt; # HCI daemon configuration file.<br>&gt; #<br>&gt; # $Id: hcid.conf,=
v 1.7 2004/12/13 14:16:03 holtmann Exp $<br>&gt; #<br>&gt; <br>&gt; # HCId =
options
<br>&gt; options {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
# Automatically initialize new devices<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; autoinit yes;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; # Security Manager mode<br>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none - Security manager disabled=
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; auto=
 - Use local PIN for incoming connections
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; user=
 - Always ask user for a PIN<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; #<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; securit=
y auto;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # =
Pairing mode<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp=
;&nbsp; none&nbsp;&nbsp;- Pairing disabled<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; multi - Allow pairing with already pa=
ired devices
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; once=
&nbsp;&nbsp;- Pair once and deny successive attempts<br>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pairing multi;<br>&gt; <br>&gt;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # PIN helper<br>&gt;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_helper /usr/bin/bluepin;<br>&gt; <br>&=
gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # D-Bus PIN helper
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #dbus_pin_helper;<=
br>&gt; }<br>&gt; <br>&gt; # Default settings for HCI devices<br>&gt; devic=
e {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Local device =
name<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; =
%d - device id<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nb=
sp;&nbsp; %h - host name<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name &quot;BlueZ (%d)&=
quot;;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # L=
ocal device class<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c=
lass 0x3e0100;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; # Default packet type<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; #pkt_type DH1,DM1,HV1;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; # Inquiry and Page scan
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; psca=
n enable;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
# Default link mode<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 #&nbsp;&nbsp; none&nbsp;&nbsp; - no specific policy<br>&gt;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; accept - always accept inco=
ming connections<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&=
nbsp;&nbsp; master - become master on incoming connections,
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;de=
ny
role switch on outgoing connections<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; lm accept;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; # Default link policy<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp;&nbsp;&nbsp;- no specifi=
c policy<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nb=
sp; rswitch - allow role switch<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; #&nbsp;&nbsp; hold&nbsp;&nbsp;&nbsp;&nbsp;- allow hold mode
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; snif=
f&nbsp;&nbsp; - allow sniff mode<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; #&nbsp;&nbsp; park&nbsp;&nbsp;&nbsp;&nbsp;- allow park mode<b=
r>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lp rswitch,hold,snif=
f,park;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # =
Authentication and Encryption (Security Mode 3)<br>&gt;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp; #auth enable;
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #encrypt enable;<b=
r>&gt; }<br>&gt; cat /etc/bluetooth/rfcomm.conf<br>&gt; #<br>&gt; # RFCOMM =
configuration file.<br>&gt; #<br>&gt; # $Id: rfcomm.conf,v 1.1 2002/10/07 0=
5:58:18 maxk Exp $<br>&gt; #<br>&gt;=20
<br>&gt; rfcomm0 {<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
# Automatically bind the device at startup<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; bind no;<br>&gt; <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; # Bluetooth address of the device<br>&gt;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device 11:22:33:44:55:66;<br>&gt; <br=
>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # RFCOMM channel for =
the connection
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; channel 1;<br>&gt;=
 <br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Description of =
the connection<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; comm=
ent &quot;Example Bluetooth device&quot;;<br>&gt; }<br>&gt; <br>&gt; <br>&g=
t; Jacky Cheung &lt;<a href=3D"mailto:jackycheung@e28.com.hk">
jackycheung@e28.com.hk</a>&gt; &lt;mailto:<a href=3D"mailto:jackycheung@e28=
.com.hk">jackycheung@e28.com.hk</a>&gt;<br>&gt; Software Engineer<br>&gt; E=
28 Hong Kong Limited<br>&gt; Tel: 3105 0493 Fax: 3105 0495<br>&gt; Unit 100=
3, Millennium City 3,
<br>&gt; 370 Kwun Tong Road,<br>&gt; Hong Kong<br>&gt; <br>&gt; <br>&gt; Mi=
chael McConnell wrote:<br>&gt; <br>&gt; &gt;On Thu, 23 Jun 2005, Jacky Cheu=
ng wrote:<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;&gt;my mobile =
device is on.. and had tried hcitool scan., but no device found
<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;<br>&gt; &gt;With most mobil=
e phones, you can have Bluetooth enabled with it set &quot;hidden&quot;,<br=
>&gt; &gt;that is, it won't respond to scans.<br>&gt; &gt;<br>&gt; &gt;Depe=
nding on the phone, you may have an option to toggle it visible or hidden
<br>&gt; &gt;(like the Nokia 6310i), or a &quot;Find Me&quot; option (like =
most Motorolas) that<br>&gt; &gt;makes the phone respond to scans for the n=
ext 60 seconds, after which it will<br>&gt; &gt;revert to being hidden.
<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;&gt;Joel - JFX wrote:<b=
r>&gt; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;&gt;the b=
luetooth option like &quot;visible&quot; on your mobile are ON??<br>&gt; &g=
t;&gt;&gt;
<br>&gt; &gt;&gt;&gt;you can scan using &quot;hcitool scan&quot;<br>&gt; &g=
t;&gt;&gt;<br>&gt; &gt;&gt;&gt;2005/6/23, Jacky Cheung &lt;<a href=3D"mailt=
o:jackycheung@e28.com.hk">jackycheung@e28.com.hk</a>&gt;:<br>&gt; &gt;&gt;&=
gt;
<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;<br>&gt; &gt=
;&gt;&gt;&gt;Hi all,<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;I am =
new to linux Bluetooth. I've got a question in paging other<br>&gt; &gt;&gt=
;&gt;&gt;bluetooth device, says Bluetooth support phone.
<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;My PC is running in Redha=
t9.0, and I got a USB Bluetooth device. When I<br>&gt; &gt;&gt;&gt;&gt;plug=
in the Bluetooth device, I've got the following message from<br>&gt; &gt;&g=
t;&gt;&gt;/var/log/message
<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:48 localhost=
 kernel: hub.c: new USB device 00:1d.2-1,<br>&gt; &gt;&gt;&gt;&gt;assigned =
address 5<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 localhost hcid[2611]: HCI=
 dev 0 registered
<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 localhost hcid[2579]: HCI dev 0 re=
gistered<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 localhost hcid[2611]: HCI =
dev 0 up<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 localhost hcid[2579]: HCI =
dev 0 up
<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 localhost hcid[2579]: Starting sec=
urity manager 0<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 localhost hcid[2611=
]: Starting security manager 0<br>&gt; &gt;&gt;&gt;&gt;Jun 23 18:03:49 loca=
lhost /sbin/hotplug: no runnable
<br>&gt; &gt;&gt;&gt;&gt;/etc/hotplug/bluetooth.agent is installed<br>&gt; =
&gt;&gt;&gt;&gt;Jun 23 18:03:52 localhost /etc/hotplug/usb.agent: Setup hci=
_usb for USB<br>&gt; &gt;&gt;&gt;&gt;product a12/1/1120<br>&gt; &gt;&gt;&gt=
;&gt;
<br>&gt; &gt;&gt;&gt;&gt;Actually, I can see the Bluetooth device from hcic=
onfig, and the phone<br>&gt; &gt;&gt;&gt;&gt;can scan the USB BT. However, =
I fail to scan the phone device in PC. Is<br>&gt; &gt;&gt;&gt;&gt;that I ha=
ve missed some settings?
<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;Thanks<br>&gt; &gt;&gt;&g=
t;&gt;<br>&gt; &gt;&gt;&gt;&gt;Regards,<br>&gt; &gt;&gt;&gt;&gt;Jacky Cheun=
g<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;------------------------=
-------------------------------
<br>&gt; &gt;&gt;&gt;&gt;<a href=3D"http://SF.Net">SF.Net</a> email is spon=
sored by: Discover Easy Linux Migration Strategies<br>&gt; &gt;&gt;&gt;&gt;=
<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;from IBM. Find simple to =
follow Roadmaps, straightforward articles,
<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;informat=
ive Webcasts and more! Get everything you need to get up to<br>&gt; &gt;&gt=
;&gt;&gt;speed, fast. <a href=3D"http://ads.osdn.com/?ad_id=3D7477&amp;allo=
c_id=3D16492&amp;op=3Dclick">
http://ads.osdn.com/?ad_id=3D7477&amp;alloc_id=3D16492&amp;op=3Dclick</a><b=
r>&gt; &gt;&gt;&gt;&gt;_______________________________________________<br>&=
gt; &gt;&gt;&gt;&gt;Bluez-users mailing list<br>&gt; &gt;&gt;&gt;&gt;<a hre=
f=3D"mailto:Bluez-users@lists.sourceforge.net">
Bluez-users@lists.sourceforge.net</a><br>&gt; &gt;&gt;&gt;&gt;<a href=3D"ht=
tps://lists.sourceforge.net/lists/listinfo/bluez-users">https://lists.sourc=
eforge.net/lists/listinfo/bluez-users</a><br>&gt; &gt;&gt;&gt;&gt;<br>&gt; =
&gt;&gt;&gt;&gt;
<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;&gt;=
<br>&gt; &gt;&gt;&gt;------------------------------------------------------=
-<br>&gt; &gt;&gt;&gt;<a href=3D"http://SF.Net">SF.Net</a> email is sponsor=
ed by: Discover Easy Linux Migration Strategies
<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;from IBM. Fi=
nd simple to follow Roadmaps, straightforward articles,<br>&gt; &gt;&gt;<br=
>&gt; &gt;&gt;<br>&gt; &gt;&gt;&gt;informative Webcasts and more! Get every=
thing you need to get up to
<br>&gt; &gt;&gt;&gt;speed, fast. <a href=3D"http://ads.osdn.com/?ad_idt77&=
amp;alloc_id=16492&amp;op=3Dclick">http://ads.osdn.com/?ad_idt77&amp;alloc_=
id=16492&amp;op=3Dclick</a><br>&gt; &gt;&gt;&gt;___________________________=
____________________
<br>&gt; &gt;&gt;&gt;Bluez-users mailing list<br>&gt; &gt;&gt;&gt;<a href=
=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge=
.net</a><br>&gt; &gt;&gt;&gt;<a href=3D"https://lists.sourceforge.net/lists=
/listinfo/bluez-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt; &gt;&g=
t;&gt;<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;<br>&gt; &gt;&gt;&gt;<br>&g=
t; &gt;&gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;--------------------------=
-----------------------------
<br>&gt; &gt;&gt;<a href=3D"http://SF.Net">SF.Net</a> email is sponsored by=
: Discover Easy Linux Migration Strategies<br>&gt; &gt;&gt;from IBM. Find s=
imple to follow Roadmaps, straightforward articles,<br>&gt; &gt;&gt;informa=
tive Webcasts and more! Get everything you need to get up to
<br>&gt; &gt;&gt;speed, fast. <a href=3D"http://ads.osdn.com/?ad_id=3D7477&=
amp;alloc_id=3D16492&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7477&amp;=
alloc_id=3D16492&amp;op=3Dclick</a><br>&gt; &gt;&gt;_______________________=
________________________
<br>&gt; &gt;&gt;Bluez-users mailing list<br>&gt; &gt;&gt;<a href=3D"mailto=
:Bluez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><b=
r>&gt; &gt;&gt;<a href=3D"https://lists.sourceforge.net/lists/listinfo/blue=
z-users">
https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt; &gt;&g=
t;<br>&gt; &gt;&gt;<br>&gt; &gt;&gt;<br>&gt; &gt;<br>&gt; &gt;-- Michael &q=
uot;Soruk&quot; McConnell<br>&gt; &gt;&nbsp;&nbsp; Eridani Star System<br>&=
gt; &gt;
<br>&gt; &gt;&nbsp;&nbsp; MailStripper - &quot;The easy spam filter.&quot;<=
br>&gt; &gt;&nbsp;&nbsp; <a href=3D"http://mailstripper.eridani.co.uk/">htt=
p://mailstripper.eridani.co.uk/</a><br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<=
br>&gt; &gt;-------------------------------------------------------
<br>&gt; &gt;<a href=3D"http://SF.Net">SF.Net</a> email is sponsored by: Di=
scover Easy Linux Migration Strategies<br>&gt; &gt;from IBM. Find simple to=
 follow Roadmaps, straightforward articles,<br>&gt; &gt;informative Webcast=
s and more! Get everything you need to get up to
<br>&gt; &gt;speed, fast. <a href=3D"http://ads.osdn.com/?ad_id=3D7477&amp;=
alloc_id=3D16492&amp;op=3Dclick">http://ads.osdn.com/?ad_id=3D7477&amp;allo=
c_id=3D16492&amp;op=3Dclick</a><br>&gt; &gt;_______________________________=
________________
<br>&gt; &gt;Bluez-users mailing list<br>&gt; &gt;<a href=3D"mailto:Bluez-u=
sers@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>&gt; &=
gt;<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users">htt=
ps://lists.sourceforge.net/lists/listinfo/bluez-users
</a><br>&gt; &gt;<br>&gt; &gt;<br>&gt; &gt;<br>&gt; <br>&gt; --------------=
-----------------------------------------<br>&gt; <a href=3D"http://SF.Net"=
>SF.Net</a> email is sponsored by: Discover Easy Linux Migration Strategies
<br>&gt; from IBM. Find simple to follow Roadmaps, straightforward articles=
,<br>&gt; informative Webcasts and more! Get everything you need to get up =
to<br>&gt; speed, fast. <a href=3D"http://ads.osdn.com/?ad_id=3D7477&amp;al=
loc_id=3D16492&amp;op=3Dclick">
http://ads.osdn.com/?ad_id=3D7477&amp;alloc_id=3D16492&amp;op=3Dclick</a><b=
r>&gt; _______________________________________________<br>&gt; Bluez-users =
mailing list<br>&gt; <a href=3D"mailto:Bluez-users@lists.sourceforge.net">B=
luez-users@lists.sourceforge.net
</a><br>&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-=
users">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br>&gt;=
 <br>

------=_Part_15100_2974870.1119612166455--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
