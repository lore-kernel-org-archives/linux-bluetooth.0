Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <BAY126-W15B9AAACF1805D075C232EA5AC0@phx.gbl>
From: Lane Shields <laneshields@hotmail.com>
To: <bluez-users@lists.sourceforge.net>
Date: Tue, 23 Jan 2007 20:43:43 -0500
MIME-Version: 1.0
Subject: [Bluez-users] Attempt to setup BlueZ on Playstation 3 running Linux
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1024645934=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1024645934==
Content-Type: multipart/alternative;
	boundary="_b046904c-12e4-4efd-aade-95ba35afeca3_"

--_b046904c-12e4-4efd-aade-95ba35afeca3_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,I am new to this list, but I couldn't find anything in the archives t=
o answer my questions.  I installed Yellow Dog Linux 5.0 on my PlayStation =
3 a little while ago, and I've been struggling to get the bluetooth PS3 Six=
Axis controllers to work with the Linux system.  I am not very experienced =
with Bluetooth, so please forgive me if I ask any noob questions.When I pre=
ss the PlayStation button on my controller, the controller appears to attem=
pt to pair.  From hcidump, I see:> HCI Event: Role Change (0x12) plen 8    =
status 0x00 bdaddr 00:16:FE:6F:3B:6B role 0x00    Role: Master> HCI Event: =
Link Key Request (0x17) plen 6    bdaddr 00:16:FE:6F:3B:6B< HCI Command: Li=
nk Key Request Negative Reply (0x01|0x000c) plen 6    bdaddr 00:16:FE:6F:3B=
:6B> HCI Event: Command Complete (0x0e) plen 10    Link Key Request Negativ=
e Reply (0x01|0x000c) ncmd 1    status 0x00 bdaddr 00:16:FE:6F:3B:6B> HCI E=
vent: PIN Code Request (0x16) plen 6    bdaddr 00:16:FE:6F:3B:6B< HCI Comma=
nd: PIN Code Request Negative Reply (0x01|0x000e) plen 6    bdaddr 00:16:FE=
:6F:3B:6B> HCI Event: Command Complete (0x0e) plen 10    PIN Code Request N=
egative Reply (0x01|0x000e) ncmd 1    status 0x00 bdaddr 00:16:FE:6F:3B:6B>=
 HCI Event: Connect Complete (0x03) plen 11    status 0x06 handle 43 bdaddr=
 00:16:FE:6F:3B:6B type ACL encrypt 0x00    Error: PIN or Key MissingAnd th=
is is repeated several times until the controller eventually gives up and t=
urns itself off.  If my understanding is correct, hcid should be offering t=
he controller a key to use somewhere in there, but it is not doing this.  C=
orrelating to this, I get the following lines in my /var/log/messages file:=
Jan 23 18:30:01 localhost hcid[2649]: link_key_request (sba=3D00:13:A9:54:D=
A:72, dba=3D00:16:FE:6F:3B:6B)Jan 23 18:30:01 localhost hcid[2649]: pin_cod=
e_request (sba=3D00:13:A9:54:DA:72, dba=3D00:16:FE:6F:3B:6B)Jan 23 18:30:01=
 localhost hcid[2649]: Can't get conn info: No such file or directory (2)To=
 me it looks like BlueZ is possibly looking for a file that would contain t=
he key, but I'm not sure what file it's talking about.  Does anyone have an=
y ideas?  I'll copy my /etc/bluetooth/hcid.conf file blow for reference.  I=
 am using the following versions of bluez:bluez-hcidump.ppc                =
        1.30-1                 installed       bluez-libs.ppc              =
             2.25-1                 installed       bluez-pin.ppc          =
                  0.30-2                 installed       bluez-utils.ppc   =
                       2.25-4                 installed       # HCI daemon =
configuration file.## HCId optionsoptions {        # Automatically initiali=
ze new devices        autoinit yes;        # Security Manager mode        #=
   none - Security manager disabled        #   auto - Use local PIN for inc=
oming connections        #   user - Always ask user for a PIN        #     =
   security user;        # Pairing mode        #   none  - Pairing disabled=
        #   multi - Allow pairing with already paired devices        #   on=
ce  - Pair once and deny successive attempts        pairing multi;        #=
 PIN helper        #pin_helper /usr/bin/bluepin;        pin_helper /etc/blu=
etooth/givepin;        # D-Bus PIN helper        #dbus_pin_helper;}# Defaul=
t settings for HCI devicesdevice {        # Local device name        #   %d=
 - device id        #   %h - host name        name "%h-%d";        # Local =
device class        #class 0x120104;        class 0x100        # Default pa=
cket type        #pkt_type DH1,DM1,HV1;        # Inquiry and Page scan     =
   iscan enable; pscan enable;        # Default link mode        #   none  =
 - no specific policy         #   accept - always accept incoming connectio=
ns        #   master - become master on incoming connections,        #     =
       deny role switch on outgoing connections        lm accept;        # =
Default link policy        #   none    - no specific policy        #   rswi=
tch - allow role switch        #   hold    - allow hold mode        #   sni=
ff   - allow sniff mode        #   park    - allow park mode        lp rswi=
tch,hold,sniff,park;        # Authentication and Encryption (Security Mode =
3)        auth enable;        encrypt enable;}
_________________________________________________________________
Fixing up the home? Live Search can help.
http://imagine-windowslive.com/search/kits/default.aspx?kit=3Dimprove&local=
e=3Den-US&source=3Dwlmemailtaglinenov06=

--_b046904c-12e4-4efd-aade-95ba35afeca3_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<style>
P
{
margin:0px;
padding:0px
}
body
{
FONT-SIZE: 10pt;
FONT-FAMILY:Tahoma
}
</style>
</head>
<body><div style=3D"text-align: left;">Hello,<br><br>I am new to this list,=
 but I couldn't find anything in the archives to answer my questions.&nbsp;=
 I installed Yellow Dog Linux 5.0 on my PlayStation 3 a little while ago, a=
nd I've been struggling to get the bluetooth PS3 SixAxis controllers to wor=
k with the Linux system.&nbsp; I am not very experienced with Bluetooth, so=
 please forgive me if I ask any noob questions.<br><br>When I press the Pla=
yStation button on my controller, the controller appears to attempt to pair=
.&nbsp; From hcidump, I see:<br><br>&gt; HCI Event: Role Change (0x12) plen=
 8<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:FE:6F:3B:6B role 0x00<br>=
&nbsp;&nbsp;&nbsp; Role: Master<br>&gt; HCI Event: Link Key Request (0x17) =
plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:FE:6F:3B:6B<br>&lt; HCI Command: =
Link Key Request Negative Reply (0x01|0x000c) plen 6<br>&nbsp;&nbsp;&nbsp; =
bdaddr 00:16:FE:6F:3B:6B<br>&gt; HCI Event: Command Complete (0x0e) plen 10=
<br>&nbsp;&nbsp;&nbsp; Link Key Request Negative Reply (0x01|0x000c) ncmd 1=
<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16:FE:6F:3B:6B<br>&gt; HCI Eve=
nt: PIN Code Request (0x16) plen 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:FE:6F=
:3B:6B<br>&lt; HCI Command: PIN Code Request Negative Reply (0x01|0x000e) p=
len 6<br>&nbsp;&nbsp;&nbsp; bdaddr 00:16:FE:6F:3B:6B<br>&gt; HCI Event: Com=
mand Complete (0x0e) plen 10<br>&nbsp;&nbsp;&nbsp; PIN Code Request Negativ=
e Reply (0x01|0x000e) ncmd 1<br>&nbsp;&nbsp;&nbsp; status 0x00 bdaddr 00:16=
:FE:6F:3B:6B<br>&gt; HCI Event: Connect Complete (0x03) plen 11<br>&nbsp;&n=
bsp;&nbsp; status 0x06 handle 43 bdaddr 00:16:FE:6F:3B:6B type ACL encrypt =
0x00<br>&nbsp;&nbsp;&nbsp; Error: PIN or Key Missing<br><br>And this is rep=
eated several times until the controller eventually gives up and turns itse=
lf off.&nbsp; If my understanding is correct, hcid should be offering the c=
ontroller a key to use somewhere in there, but it is not doing this.&nbsp; =
Correlating to this, I get the following lines in my /var/log/messages file=
:<br><br>Jan 23 18:30:01 localhost hcid[2649]: link_key_request (sba=3D00:1=
3:A9:54:DA:72, dba=3D00:16:FE:6F:3B:6B)<br>Jan 23 18:30:01 localhost hcid[2=
649]: pin_code_request (sba=3D00:13:A9:54:DA:72, dba=3D00:16:FE:6F:3B:6B)<b=
r>Jan 23 18:30:01 localhost hcid[2649]: Can't get conn info: No such file o=
r directory (2)<br><br>To me it looks like BlueZ is possibly looking for a =
file that would contain the key, but I'm not sure what file it's talking ab=
out.&nbsp; Does anyone have any ideas?&nbsp; I'll copy my /etc/bluetooth/hc=
id.conf file blow for reference.&nbsp; I am using the following versions of=
 bluez:<br><br>bluez-hcidump.ppc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 1.30-1&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; installed&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; <br>bluez-libs.ppc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 2.25-1&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; in=
stalled&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <br>bluez-pin.ppc&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0=
.30-2&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; installed&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <b=
r>bluez-utils.ppc&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; 2.25-4&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; installed&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; <br><br><br># HCI daemon configuration file.<br>#<br><br>#=
 HCId options<br>options {<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # =
Automatically initialize new devices<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; autoinit yes;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # S=
ecurity Manager mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&=
nbsp; none - Security manager disabled<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; #&nbsp;&nbsp; auto - Use local PIN for incoming connections<br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; user - Always ask us=
er for a PIN<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #<br>&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; security user;<br><br>&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; # Pairing mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; #&nbsp;&nbsp; none&nbsp; - Pairing disabled<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; multi - Allow pairing with already pai=
red devices<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; onc=
e&nbsp; - Pair once and deny successive attempts<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; pairing multi;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; # PIN helper<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #pin_h=
elper /usr/bin/bluepin;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pin_h=
elper /etc/bluetooth/givepin;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; # D-Bus PIN helper<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #dbus=
_pin_helper;<br>}<br><br># Default settings for HCI devices<br>device {<br>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Local device name<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %d - device id<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; %h - host name<br>&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; name "%h-%d";<br><br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; # Local device class<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; #class 0x120104;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; class 0x100<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default =
packet type<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #pkt_type DH1,DM1=
,HV1;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Inquiry and Page =
scan<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; iscan enable; pscan enab=
le;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link mode<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp;=
 - no specific policy <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp=
;&nbsp; accept - always accept incoming connections<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; master - become master on incoming con=
nections,<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; deny role switch on outgoi=
ng connections<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lm accept;<br>=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; # Default link policy<br>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; none&nbsp;&nbsp;&nbsp=
; - no specific policy<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp=
;&nbsp; rswitch - allow role switch<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; #&nbsp;&nbsp; hold&nbsp;&nbsp;&nbsp; - allow hold mode<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; sniff&nbsp;&nbsp; - allow sn=
iff mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; #&nbsp;&nbsp; park&n=
bsp;&nbsp;&nbsp; - allow park mode<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; lp rswitch,hold,sniff,park;<br><br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; # Authentication and Encryption (Security Mode 3)<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; auth enable;<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; encrypt enable;<br>}<br><br></div><br /><hr />View Athletes' =
Collections with Live Search. <a href=3D'http://sportmaps.live.com/index.ht=
ml?source=3Dwlmemailtaglinenov06' target=3D'_new'>See it!</a></body>
</html>=

--_b046904c-12e4-4efd-aade-95ba35afeca3_--


--===============1024645934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1024645934==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1024645934==--
