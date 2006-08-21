Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 21 Aug 2006 14:28:22 +0200 (MEST)
From: Markus Becker <mab@comnets.uni-bremen.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0608211349380.27134-200000@bugs.comnets.uni-bremen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="1720058267-1954946134-1156163302=:27134"
Subject: [Bluez-devel] [PATCH] bluez-libs UUID-128 support for Protocol
	Descriptor List
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1720058267-1954946134-1156163302=:27134
Content-Type: TEXT/PLAIN; charset=US-ASCII

Hello Marcel et al.,

I've created a patch for bluez-libs/src/sdp.c to support the finding of
UUID128 encoded protocols. So that also kdebluetooth and others can
recognize those protocols. It changes the display of the Protocol
Descriptor List for example from:

Service Name: ATEmulator
Service RecHandle: 0x10010
Service Class ID List:
  "Error: This is UUID-128" (0x7dd6b763-99a9-4a92-87b5-bc8efe565c37)
  "Error: This is UUID-128" (0x00001101-0000-1000-8000-00805f9b34fb)
Protocol Descriptor List:
  "Error: " (0x00000100-0000-1000-8000-00805f9b34fb)
  "Error: " (0x00000003-0000-1000-8000-00805f9b34fb)
    Channel: 25

to:

Service Name: ATEmulator
Service RecHandle: 0x10010
Service Class ID List:
  UUID 128: 7dd6b763-99a9-4a92-87b5-bc8efe565c37
  UUID 128: 00001101-0000-1000-8000-00805f9b34fb
Protocol Descriptor List:
  "L2CAP" (0x00000100-0000-1000-8000-00805f9b34fb)
  "RFCOMM" (0x00000003-0000-1000-8000-00805f9b34fb)
    Channel: 25

Please consider it for integration into mainline bluez-libs.

Best regards,
Markus Becker

P.S.: When replying please CC me, because I'm not subscribed to the list.

------------------------------------------------
| Dipl.-Ing. Markus Becker 
| Communication Networks
| University Bremen
| Germany
------------------------------------------------
| web: http://www.comnets.uni-bremen.de/~mab/
| mailto: mab@comnets.uni-bremen.de 
| telephone: +49 421 218 2287
| building: NW1 room: N2260
------------------------------------------------

--1720058267-1954946134-1156163302=:27134
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="sdp.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.21.0608211428220.27134@bugs.comnets.uni-bremen.de>
Content-Description: 
Content-Disposition: attachment; filename="sdp.patch"

ZGlmZiAtdSBibHVlei1saWJzLTMuMi9zcmMvc2RwLmMgYmx1ZXotbGlicy0z
LjIubW9kL3NyYy9zZHAuYw0KLS0tIGJsdWV6LWxpYnMtMy4yL3NyYy9zZHAu
YwkyMDA2LTA3LTI3IDA2OjM2OjU5LjAwMDAwMDAwMCArMDIwMA0KKysrIGJs
dWV6LWxpYnMtMy4yLm1vZC9zcmMvc2RwLmMJMjAwNi0wOC0yMSAxMzo0NTo0
Ni4wMDAwMDAwMDAgKzAyMDANCkBAIC0yMDgsNiArMjA4LDI1IEBADQogCXJl
dHVybiAiIjsNCiB9DQogDQorc3RhdGljIGNoYXIgKnN0cmluZ19sb29rdXAx
Mjgoc3RydWN0IHR1cGxhICpwdDAsIHVpbnQxMjhfdCBpbmRleCkNCit7DQor
ICAJc3RydWN0IHR1cGxhICpwdDsNCisNCisJaW50IGlfaW5kZXggPSBpbmRl
eC5kYXRhWzBdOw0KKwlpX2luZGV4ID0gaV9pbmRleCA8PDg7DQorCWlfaW5k
ZXggKz0gaW5kZXguZGF0YVsxXTsNCisJaV9pbmRleCA9IGlfaW5kZXggIDw8
ODsNCisJaV9pbmRleCArPSBpbmRleC5kYXRhWzJdOw0KKwlpX2luZGV4ID0g
aV9pbmRleCAgPDw4Ow0KKwlpX2luZGV4ICs9IGluZGV4LmRhdGFbM107DQor
DQorCWZvciAocHQgPSBwdDA7IHB0LT5pbmRleDsgcHQrKykgew0KKwkgIGlm
IChwdC0+aW5kZXggPT0gaV9pbmRleCkNCisJICAgIHJldHVybiBwdC0+c3Ry
Ow0KKwl9DQorCXJldHVybiAiIjsNCit9DQorDQogLyoNCiAgKiBQcmludHMg
aW50byBhIHN0cmluZyB0aGUgUHJvdG9jb2wgVVVJRA0KICAqIGNvcGluZyBh
IG1heGltdW0gb2YgbiBjaGFyYWN0ZXJzLg0KQEAgLTIzMSw3ICsyNTAsOCBA
QA0KIAkJc25wcmludGYoc3RyLCBuLCBzdHIyKTsNCiAJCWJyZWFrOw0KIAlj
YXNlIFNEUF9VVUlEMTI4Og0KLQkJc25wcmludGYoc3RyLCBuLCAiRXJyb3I6
IFRoaXMgaXMgVVVJRC0xMjgiKTsNCisJCXN0cjIgPSBzdHJpbmdfbG9va3Vw
MTI4KG1lc3NhZ2UsIHV1aWQtPnZhbHVlLnV1aWQxMjgpOw0KKwkJc25wcmlu
dGYoc3RyLCBuLCBzdHIyKTsNCiAJCXJldHVybiAtNDsNCiAJZGVmYXVsdDoN
CiAJCXNucHJpbnRmKHN0ciwgbiwgIlR5cGUgb2YgVVVJRCAoJXgpIHVua25v
d24uIiwgdXVpZC0+dHlwZSk7DQo=
--1720058267-1954946134-1156163302=:27134
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--1720058267-1954946134-1156163302=:27134
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--1720058267-1954946134-1156163302=:27134--
