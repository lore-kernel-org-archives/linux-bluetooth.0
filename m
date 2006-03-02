Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <f64f4e8a0603020708l52623141x5d77d53f90825801@mail.gmail.com>
From: "zhu yong" <zhuyong0003@gmail.com>
To: bluez-users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_7327_18215039.1141312136414"
Subject: [Bluez-users] Re: Re: Help me! hciattach have no error msg, but hciconfig don't find the device.
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
Date: Thu, 2 Mar 2006 23:08:56 +0800

------=_Part_7327_18215039.1141312136414
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,Erwin
my board use Samsung 44B0x chip of ATM7TDMI. I use bluez-utils-2.24 and
bluez-libs-2.24.
Do I need patchs for non-mmu systems?
Is 'startup script'  /etc/hcid.conf?
I have no ides how to change the file, I use default config.
hcid.conf content As follows:

#
# HCI daemon configuration file.
#

# HCId options
options {
 # Automatically initialize new devices
 autoinit yes;

 # Security Manager mode
 #   none - Security manager disabled
 #   auto - Use local PIN for incoming connections
 #   user - Always ask user for a PIN
 #
 security auto;

 # Pairing mode
 #   none  - Pairing disabled
 #   multi - Allow pairing with already paired devices
 #   once  - Pair once and deny successive attempts
 pairing multi;

 # PIN helper
 pin_helper /usr/bin/bluepin;

 # D-Bus PIN helper
 #dbus_pin_helper;
}

# Default settings for HCI devices
device {
 # Local device name
 #   %d - device id
 #   %h - host name
 name "BlueZ (%d)";

 # Local device class
 class 0x3e0100;

 # Default packet type
 #pkt_type DH1,DM1,HV1;

 # Inquiry and Page scan
 iscan enable; pscan enable;

 # Default link mode
 #   none   - no specific policy
 #   accept - always accept incoming connections
 #   master - become master on incoming connections,
 #            deny role switch on outgoing connections
 lm accept;

 # Default link policy
 #   none    - no specific policy
 #   rswitch - allow role switch
 #   hold    - allow hold mode
 #   sniff   - allow sniff mode
 #   park    - allow park mode
 lp rswitch,hold,sniff,park;

 # Authentication and Encryption (Security Mode 3)
 #auth enable;
 #encrypt enable;
}


 Regards
yong Zhu


> Hi,
> is it the AT91M40800 that you are using? Which version of hcitools do
> you use? There are a few patches required for non-mmu systems. How does
> your startup script look like?

> Regards,
> Erwin

Am Dienstag, den 28.02.2006, 23:51 +0800 schrieb zhu yong:
> Hi, everyone
>   I use one uare bluetooth device on my arm board. operation system is
> uclinux, kernel is linux-2.4.24.
>   I use hciattach cmd. There have no error msg.but I use hciconfig to
> display devices, there have no devices info.
>   I don't know why don't find device, any advice will help me!
>
>   In addition, I use the same hciattach cmd on my pc, hciconfig can
> find the device.
>

------=_Part_7327_18215039.1141312136414
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hi,Erwin</div>
<div>my board use Samsung 44B0x chip of ATM7TDMI. I use bluez-utils-2.24 an=
d bluez-libs-2.24.</div>
<div>Do&nbsp;I need patchs for non-mmu systems?</div>
<div>Is&nbsp;'startup script'&nbsp;&nbsp;/etc/hcid.conf?&nbsp;</div>
<div>I have no ides how to change the file, I use default config.</div>
<div>hcid.conf content As follows:</div>
<p>#<br># HCI daemon configuration file.<br>#</p>
<p># HCId options<br>options {<br>&nbsp;# Automatically initialize new devi=
ces<br>&nbsp;autoinit yes;</p>
<p>&nbsp;# Security Manager mode<br>&nbsp;#&nbsp;&nbsp; none - Security man=
ager disabled<br>&nbsp;#&nbsp;&nbsp; auto - Use local PIN for incoming conn=
ections<br>&nbsp;#&nbsp;&nbsp; user - Always ask user for a PIN<br>&nbsp;#<=
br>&nbsp;security auto;</p>
<p>&nbsp;# Pairing mode<br>&nbsp;#&nbsp;&nbsp; none&nbsp; - Pairing disable=
d<br>&nbsp;#&nbsp;&nbsp; multi - Allow pairing with already paired devices<=
br>&nbsp;#&nbsp;&nbsp; once&nbsp; - Pair once and deny successive attempts<=
br>&nbsp;pairing multi;</p>
<p>&nbsp;# PIN helper<br>&nbsp;pin_helper /usr/bin/bluepin;</p>
<p>&nbsp;# D-Bus PIN helper<br>&nbsp;#dbus_pin_helper;<br>}</p>
<p># Default settings for HCI devices<br>device {<br>&nbsp;# Local device n=
ame<br>&nbsp;#&nbsp;&nbsp; %d - device id<br>&nbsp;#&nbsp;&nbsp; %h - host =
name<br>&nbsp;name &quot;BlueZ (%d)&quot;;</p>
<p>&nbsp;# Local device class<br>&nbsp;class 0x3e0100;</p>
<p>&nbsp;# Default packet type<br>&nbsp;#pkt_type DH1,DM1,HV1;</p>
<p>&nbsp;# Inquiry and Page scan<br>&nbsp;iscan enable; pscan enable;</p>
<p>&nbsp;# Default link mode<br>&nbsp;#&nbsp;&nbsp; none&nbsp;&nbsp; - no s=
pecific policy <br>&nbsp;#&nbsp;&nbsp; accept - always accept incoming conn=
ections<br>&nbsp;#&nbsp;&nbsp; master - become master on incoming connectio=
ns,<br>&nbsp;#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; deny role switch on outgoing connections=20
<br>&nbsp;lm accept;</p>
<p>&nbsp;# Default link policy<br>&nbsp;#&nbsp;&nbsp; none&nbsp;&nbsp;&nbsp=
; - no specific policy<br>&nbsp;#&nbsp;&nbsp; rswitch - allow role switch<b=
r>&nbsp;#&nbsp;&nbsp; hold&nbsp;&nbsp;&nbsp; - allow hold mode<br>&nbsp;#&n=
bsp;&nbsp; sniff&nbsp;&nbsp; - allow sniff mode<br>&nbsp;#&nbsp;&nbsp; park=
&nbsp;&nbsp;&nbsp; - allow park mode<br>&nbsp;lp rswitch,hold,sniff,park;=
=20
</p>
<p>&nbsp;# Authentication and Encryption (Security Mode 3)<br>&nbsp;#auth e=
nable;<br>&nbsp;#encrypt enable;<br>}<br></p>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>
<div>Regards</div>
<div>yong Zhu</div><br><br>&gt; Hi,<br>&gt; is it the AT91M40800 that you a=
re using? Which version of hcitools do<br>&gt; you use? There are a few pat=
ches required for non-mmu systems. How does<br>&gt; your startup script loo=
k like?=20
<br><br>&gt; Regards,<br>&gt; Erwin<br><br>Am Dienstag, den 28.02.2006, 23:=
51 +0800 schrieb zhu yong:<br>&gt; Hi, everyone<br>&gt; &nbsp; I use one ua=
re bluetooth device on my arm board. operation system is<br>&gt; uclinux, k=
ernel is=20
linux-2.4.24.<br>&gt; &nbsp; I use hciattach cmd. There have no error msg.b=
ut I use hciconfig to<br>&gt; display devices, there have no devices info.<=
br>&gt; &nbsp; I don't know why don't find device, any advice will help me!=
<br>&gt;=20
<br>&gt; &nbsp; In addition, I use the same hciattach cmd on my pc, hciconf=
ig can<br>&gt; find the device.<br>&gt;<br>&nbsp;</div>

------=_Part_7327_18215039.1141312136414--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
