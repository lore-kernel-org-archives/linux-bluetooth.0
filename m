Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <3e890f530605010828q1ca34bbfg4a0ed7ed466eee1@mail.gmail.com>
From: "=?ISO-8859-1?Q?Javier_Rodas_Gonz=E1lez?=" <javier.rodas@nomasystems.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7200_10128489.1146497296492"
Subject: [Bluez-users] Inquiry with RSSI on Broadcom BCM2035 - not supported ?
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
Date: Mon, 1 May 2006 17:28:16 +0200

------=_Part_7200_10128489.1146497296492
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have tested the D-Link DBT-122 dongle (BCM2035 chipset) with BlueZ-utils
and I find the following features:

# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:13:46:01:22:90 ACL MTU: 377:10 SCO MTU: 16:0
        Features: 0xff 0xfe 0x0d 0x38 0x08 0x08 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control=
>
                <transparent SCO> <enhanced iscan> <interlaced iscan>
                <interlaced pscan> <AFH cap. slave> <AFH cap. master>

Looking the manufactured specification page of BCM2035 chipset it says that
it implements the Bluetooth v1.2 specification. Nevertheless I found that
it's not true, because this dongle doesn't support the <Inquiry with RSSI>
feature, that belongs to that version and following.


I have also tested other usb dongles, for example CSR BlueCore4,
successfully with this feature:

# hciconfig hci0 features
hci0:   Type: USB
        BD Address: 00:80:5A:46:2D:51 ACL MTU: 384:8 SCO MTU: 64:8
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset=
>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2
packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme=
>
                <power control> <transparent SCO> <broadcast encrypt>
                <EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
<------------------
                <extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
                <AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
                <AFH cap. master> <AFH class. master> <EDR eSCO 2 Mbps>
                <EDR eSCO 3 Mbps> <3-slot EDR eSCO> <extended features>



Please, could you confirm me that it's impossible to make an "Inquiry with
RSSI" operation with the BCM2035 chipset from Broadcom ?
Do you know on existence of an firmware upgrade for this chipsets that
solves this lack ?


I have asked the same question on D-Link support page without response.
I use Ubuntu Dapper with Kernel v2.6.15 and BlueZ-utils v2.25.


Thanks for your attention.

Best regards.

------=_Part_7200_10128489.1146497296492
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

I have tested the D-Link DBT-122 dongle (BCM2035 chipset) with BlueZ-utils =
and I find the following features:<br>
<br>
# hciconfig hci0 features<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:13:46:01:22:90 AC=
L MTU: 377:10 SCO MTU: 16:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xfe 0x0d 0x38 0x=
08 0x08 0x00 0x00<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot offset&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff
mode&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO link&gt; &lt;HV2
packets&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;
&lt;power control&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;transparent SCO&gt; &lt;enhanced iscan&gt; &lt;interlaced iscan&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;interlaced pscan&gt; &lt;AFH cap. slave&gt; &lt;AFH cap. master&gt;<br>
<br>
Looking the manufactured specification page of BCM2035 chipset it says
that it implements the Bluetooth v1.2 specification. Nevertheless I
found that it's not true, because this dongle doesn't support the
&lt;Inquiry with RSSI&gt; feature, that belongs to that version and
following.<br>
<br>
<br>
I have also tested other usb dongles, for example CSR BlueCore4, successful=
ly with this feature:<br>
<br>
# hciconfig hci0 features<br>
hci0:&nbsp;&nbsp; Type: USB<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:5A:46:2D:51 AC=
L MTU: 384:8 SCO MTU: 64:8<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8f 0xfe 0x=
9b 0xf9 0x00 0x80<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;3-slot packets&gt; &lt;5-slot packets&gt; &lt;encryption&gt;
&lt;slot offset&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;timing accuracy&gt; &lt;role switch&gt; &lt;hold mode&gt; &lt;sniff
mode&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;park state&gt; &lt;RSSI&gt; &lt;channel quality&gt; &lt;SCO
link&gt; &lt;HV2 packets&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;HV3 packets&gt; &lt;u-law log&gt; &lt;A-law log&gt; &lt;CVSD&gt;
&lt;paging scheme&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;power control&gt; &lt;transparent SCO&gt; &lt;broadcast encrypt&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;EDR ACL 2 Mbps&gt; &lt;EDR ACL 3 Mbps&gt; &lt;enhanced iscan&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;interlaced iscan&gt; &lt;interlaced pscan&gt; &lt;inquiry with
RSSI&gt;&nbsp; &lt;------------------<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;extended SCO&gt; &lt;EV4 packets&gt; &lt;EV5 packets&gt; &lt;AFH
cap. slave&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;AFH class. slave&gt; &lt;3-slot EDR ACL&gt; &lt;5-slot EDR ACL&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;AFH cap. master&gt; &lt;AFH class. master&gt; &lt;EDR eSCO 2
Mbps&gt;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;
&lt;EDR eSCO 3 Mbps&gt; &lt;3-slot EDR eSCO&gt; &lt;extended
features&gt;<br>
<br>
<br>
<br>
Please, could you confirm me that it's impossible to make an &quot;Inquiry
with RSSI&quot; operation with the BCM2035 chipset from Broadcom ?<br>
Do you know on existence of an firmware upgrade for this chipsets that solv=
es this lack ?<br>
<br>
<br>
I have asked the same question on D-Link support page without response.<br>
I use Ubuntu Dapper with Kernel v2.6.15 and BlueZ-utils v2.25.<br>
<br>
<br>
Thanks for your attention.<br>
<br>
Best regards.<br>

------=_Part_7200_10128489.1146497296492--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
