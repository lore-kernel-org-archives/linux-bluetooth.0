Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73A09.5B45DBBD"
Date: Wed, 17 Jan 2007 08:30:26 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EC0@eumonex01.palmsource.com>
References: <D8CE9CFA707C894180BAC8CDD154F8460AD538BE@msiexch01.marvell.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  plugz issues (Quinton)
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

This is a multi-part message in MIME format.

------_=_NextPart_001_01C73A09.5B45DBBD
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Quinton,

> 1. with plugin-rate=3D44100 and enable flags=3D1 on head version plugz
> audio playback speed is still not correct, didn't give me the
> bandwidth display neither.

Strange, as plugz is a newer btsco, I would expect to see flags working.

> 2. btsco-0.5 package
> 3. head version btsco (checked out from cvs)

I suggest you get back to plugz, rewrite the ~/.a2dprc from the cvs and =
try the tim chick trick.
Any chance another program is using bluez, mouse or whatever?
Last is to post a hcidump -V log?

Fr=E9d=E9ric


------_=_NextPart_001_01C73A09.5B45DBBD
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhsHAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAKgAAAFJFIDogW0JsdWV6LWRldmVs
XSBwbHVneiBpc3N1ZXMgKFF1aW50b24pAHUOAQWAAwAOAAAA1wcBABEACAAeABoAAwAzAQEggAMA
DgAAANcHAQARAAgAHgAaAAMAMwEBCYABACEAAAAxNEIzMUVBNDI1NkJBODREQUI1MTQ1REU1QzYy
NEQyOQAzBwEDkAYAPAoAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AL3bRVsJOscBHgA9AAEAAAAB
AAAAAAAAAAIBRwABAAAANQAAAGM9dXM7YT0gO3A9UGFsbVNvdXJjZTtsPUVVTU9ORVgwMS0wNzAx
MTcwNzMwMjZaLTk3MjUAAAAAHgBJAAEAAAApAAAAUmU6IFtCbHVlei1kZXZlbF0gcGx1Z3ogaXNz
dWVzIChRdWludG9uKQAAAABAAE4AAHwt4eE4xwEeAFoAAQAAACoAAABibHVlei1kZXZlbC1ib3Vu
Y2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAIBWwABAAAAcQAAAAAAAACBKx+kvqMQGZ1uAN0B
D1QCAAAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1
ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFcAAEAAAAvAAAAU01U
UDpCTFVFWi1ERVZFTC1CT1VOQ0VTQExJU1RTLlNPVVJDRUZPUkdFLk5FVAAAHgBdAAEAAAANAAAA
UXVpbnRvbiBZdWFuAAAAAAIBXgABAAAAPAAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAFF1aW50
b24gWXVhbgBTTVRQAHF5dWFuQG1hcnZlbGwuY29tAAIBXwABAAAAFwAAAFNNVFA6UVlVQU5ATUFS
VkVMTC5DT00AAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91
bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAA
EgAAAHF5dWFuQG1hcnZlbGwuY29tAAAAHgBwAAEAAAAqAAAAUkUgOiBbQmx1ZXotZGV2ZWxdIHBs
dWd6IGlzc3VlcyAoUXVpbnRvbikAAAACAXEAAQAAACAAAAABxzis6MS3NkHPaXVCI6Wl7XYlyekv
AAr5nYAAS4E8Vx4AdAABAAAAIgAAAGJsdWV6LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAA
AB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAHgAdDgEAAAAqAAAAUkUgOiBbQmx1ZXot
ZGV2ZWxdIHBsdWd6IGlzc3VlcyAoUXVpbnRvbikAAAACAQkQAQAAAGwCAABoAgAAcAMAAExaRnUA
ImV7AwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3TwqAAqQD4wIAY2gKwHPwZXQwIAcTAoAP8wBQfwRW
CFUHshHFDlEDARDHMvcGAAbDEcUzBEYQyRLbEdPbCO8J9zsYvw4wNRHCDGDOYwBQCwkBZDM2EVAL
pqggUXULgHQCICwKooMKhAqAPiAxLiAD8Eh0aCALUHVnC4AtBHJhDrA9NDQxMDMRUABwZCAJ8AGg
bGUEIGYLYGdzPTEgoQIgIGhlYSCwdgSQFwCQIcEfcnoedmF1ZCMigB9hYXliANBrILxzcAngILAE
ACRwdAMQOQMgbm8FQAWhGMBjdMQsICOwZG4nBUAfoNUiQCAHgCAfQGUediQw+yCgA/BkH0EjsCSA
JAElYJZlHzEEkC4eGlN0H+DobmdlJiBhBCAiwyTSSmEo8XcTIWJ0BPBvrSYgSR8QCGBsILF4JJA/
JgAnICPQESAhJSyRcmttC4BnKXse0DIfACwTLXgwLjUfYCRBIWAnVzNnHwAh+ywTICgQ4AWQax8k
sQhgBUADUiWgdnMpOx4aLIBzH5AqkCUQIHn/CGAmoBEwJ9EkUS1xIsMmIB0YwHcFEA6wJyIgfi+A
LmEyZHByYzOE/zdyM+EggypQKOA3ciUgM8E+aA3gNjEFECRQKXVBbvMo4BDhbmMhIABwJYApQbcf
YANgCcBhM8Ak4XUAkP8qgCfQCkE2wQRgPSAhIAWxrncQ8A6wIkE/HhRMKtA3BUAk4TZSbzVRK5Bo
YwEmUHVtcCAtViANGFBnPwUeFEZyXCe8ZTkLMEJxOpEeGn1D8B4ANRABAAAAQgAAADw3QTZEQTU0
NUQ3RkRDQzRCOTNEQjY1MUZEQkMxRURERTRFNkVDMEBldW1vbmV4MDEucGFsbXNvdXJjZS5jb20+
AAAAHgA5EAEAAABBAAAAPEQ4Q0U5Q0ZBNzA3Qzg5NDE4MEJBQzhDREQxNTRGODQ2MEFENTM4QkVA
bXNpZXhjaDAxLm1hcnZlbGwuY29tPgAAAAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAACwDy
EAEAAAAfAPMQAQAAAGAAAABSAEUAIAAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABlAHYAZQBsAF0A
IABwAGwAdQBnAHoAIABpAHMAcwB1AGUAcwAgACgAUQB1AGkAbgB0AG8AbgApAC4ARQBNAEwAAAAL
APYQAAAAAEAABzAxJyjUBjrHAUAACDAhZU9bCTrHAQMA3j+vbwAAAwDxPwwEAAAeAPg/AQAAABEA
AABGcmVkZXJpYyBEYWxsZWF1AAAAAAIB+T8BAAAAWwAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAA
AAAAAAAvTz1QQUxNU09VUkNFL09VPU1PTlRQRUxMSUVSL0NOPVJFQ0lQSUVOVFMvQ049RlJFREVS
SUMuREFMTEVBVQAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWluaXN0cmF0b3IAAAAAAgH7PwEAAAAe
AAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAADAP0/5AQAAAMAGUAAAAAAAwAaQAAA
AAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADFAAQAA
ABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMkABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNA
bGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgAzQAEAAAASAAAAcXl1YW5AbWFydmVsbC5jb20AAAAe
ADhAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsA
KQAAAAAACwAjAAAAAAADAAYQRsrHigMABxCYAQAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAA
AFFVSU5UT04sMVdJVEhQTFVHSU4tUkFURT00NDEwMEFOREVOQUJMRUZMQUdTPTFPTkhFQURWRVJT
SU9OUExVR1pBVURJT1BMQVlCQUNLU1BFRURJU1NUSUxMTk9UQ09SUkVDVCwAAAAAAgF/AAEAAABC
AAAAPDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUMwQGV1bW9uZXgwMS5wYWxt
c291cmNlLmNvbT4AAAC9hw==

------_=_NextPart_001_01C73A09.5B45DBBD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C73A09.5B45DBBD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C73A09.5B45DBBD--
