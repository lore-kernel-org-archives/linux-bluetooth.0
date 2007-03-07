Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Wed, 7 Mar 2007 14:43:12 -0000
Message-ID: <FF11924F0CDB2942BF2AA160F1FE33A10743D1@rocsrv01.Rococo.local>
From: "Michael Nairn" <michael.nairn@rococosoft.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Proposed additions to D-Bus API
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0107784502=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0107784502==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C760C6.EEB58BC7"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C760C6.EEB58BC7
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
I am currently in the process of writing a JSR82 implementation that
uses the Bluez D-Bus API. However, there is some functionality missing
from the API which we would require in order to write a full JSR82
compliant implementation.
=20
We require that the D-Bus API allow us to do the following:
=20
 * Return the integer value of the class of dev (hci_read_class_of_dev)
 * Set the service classes of the device
 * Return if role switching is supported
 * Return is inquiry scanning allowed during a connection
 * Return is page scanning allowed during connection
 * Update the service record
=20
Acl link related:
 * Check link is authenticated
 * Authenticate Link
 * Check link is encrypted
 * Encrypt link
 * Is master
=20
=20
For some of the above, they can be easily implemented by adding
additional functions to dbus-adapter.c and dbus-database.c. Something
along the following lines:
=20
 * Add additional functions to dbus-adapter.c:
adapter_get_inquiry_scan; adapter_get_page_scan;
adapter_get_role_switch; adapter_get_device_class and
adapter_set_service_classes
 * Add additional functions to dbus-database.c: update_service_record =20
=20
Regarding authentication and encryption, I noticed that this has been
mentioned on previous posts. Is there current work going on into this?
=20
Any feedback/suggestions on the above would be appreciated. I have
already had a go at implementing some of the above, what is the process
for submitting changes to Bluez? Is it just a matter of posting it to
this mailing list?
=20
Thanks,
Michael
=20
=20
=20

------_=_NextPart_001_01C760C6.EEB58BC7
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.6000.16414" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007>Hi,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007>I =
am&nbsp;currently=20
in the process of writing a JSR82 implementation that&nbsp;uses the =
Bluez D-Bus=20
API. However, there is some functionality missing from the =
API&nbsp;which we=20
would&nbsp;require in order to write a full JSR82 compliant=20
implementation.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007>We =
require that the=20
D-Bus API allow us to do the following:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Return the=20
integer value of the class of dev =
(hci_read_class_of_dev)</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Set the=20
service classes of the device</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Return if=20
role switching is supported</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Return is=20
inquiry scanning allowed during a connection</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Return is=20
page scanning allowed during connection</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Update the=20
service record</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007>Acl =
link=20
related:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Check link=20
is authenticated</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Authenticate=20
Link</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Check link=20
is encrypted</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Encrypt=20
link</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Is=20
master</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007>For =
some of the=20
above, they can be easily implemented by adding additional functions to=20
dbus-adapter.c and dbus-database.c. Something along the following=20
lines:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D773501311-07032007>&nbsp;* Add=20
additional functions to dbus-adapter.c:&nbsp;<FONT face=3D"Times New =
Roman"=20
size=3D3> <FONT face=3DArial size=3D2>adapter_get_inquiry_scan; =
adapter_get_page_scan;=20
adapter_get_role_switch; adapter_get_device_class and=20
adapter_set_service_classes</FONT></FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007>&nbsp;* Add additional functions to =
dbus-database.c:=20
update_service_record&nbsp;<FONT face=3D"Times New Roman" size=3D3>=20
</FONT></SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007>Regarding authentication and encryption, I =
noticed that=20
this has been mentioned&nbsp;on previous posts. Is there current work =
going on=20
into this?</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007>Any feedback/suggestions on the above would =
be=20
appreciated. I have already had a go at implementing some of the above, =
what is=20
the process for submitting changes to&nbsp;Bluez? Is it just a matter of =
posting=20
it to this mailing list?</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007></SPAN></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007>Thanks,</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D773501311-07032007><SPAN=20
class=3D773501311-07032007>Michael</SPAN></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007>&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D773501311-07032007></SPAN></FONT>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C760C6.EEB58BC7--


--===============0107784502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0107784502==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0107784502==--
