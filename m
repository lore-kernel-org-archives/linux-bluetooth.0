Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C73873.4B955556"
Date: Mon, 15 Jan 2007 08:03:44 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EBD@eumonex01.palmsource.com>
References: <200701150257.21542.bluez-devel@huitl.de>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : a2dpd: audio connection breaks every 300 seconds
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

------_=_NextPart_001_01C73873.4B955556
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Robert,

> A2DPD[155.135]: a2dp_transfer_raw: Wrote -1 not 603 bytes.

The write call returned EAGAIN, so we should resend the data after a =
while.

> I attached the complete logfile. It was created by a slightly modified =
version=20
> of a2dpd that tries to resend the data several times (with 1/10/20 us=20
> delay) - to no avail.

It should succeed if you wait long enough. Set the delay to 2000 and do =
more tries (like 1000). Unfortunately, waiting too much will lead to =
gaps in the sound when this happen.

I think the cause is elsewhere, could you send us the hcidump -V log?
Do you have another program using BlueZ? Another headset to try?
You could try a shorter bitpool (say 32) if your headset supports it to =
save some bandwith.

Fr=E9d=E9ric

------_=_NextPart_001_01C73873.4B955556
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ii0HAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEARAAAAFJFIDogW0JsdWV6LWRldmVs
XSBhMmRwZDogYXVkaW8gY29ubmVjdGlvbiBicmVha3MgZXZlcnkgMzAwIHNlY29uZHMAVBcBBYAD
AA4AAADXBwEADwAIAAMALAABACYBASCAAwAOAAAA1wcBAA8ACAADACwAAQAmAQEJgAEAIQAAADE2
QjQxMjJEQTAwQjFENDlCNDRBNEFBODAxMkRDMEExABAHAQOQBgBYCwAAOQAAAAMAJgAAAAAAAwA2
AAAAAABAADkAVlWVS3M4xwEeAD0AAQAAAAEAAAAAAAAAAgFHAAEAAAA1AAAAYz11czthPSA7cD1Q
YWxtU291cmNlO2w9RVVNT05FWDAxLTA3MDExNTA3MDM0NFotODUxNgAAAAAeAEkAAQAAAD8AAABb
Qmx1ZXotZGV2ZWxdIGEyZHBkOiBhdWRpbyBjb25uZWN0aW9uIGJyZWFrcyBldmVyeSAzMDAgc2Vj
b25kcwAAQABOAABAo31IOMcBHgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVl
ei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJv
dW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVW
RUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAADQAAAFJvYmVydCBIdWl0
bAAAAAACAV4AAQAAAD8AAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABSb2JlcnQgSHVpdGwAU01U
UABibHVlei1kZXZlbEBodWl0bC5kZQAAAgFfAAEAAAAaAAAAU01UUDpCTFVFWi1ERVZFTEBIVUlU
TC5ERQAAAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNl
c0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFQAA
AGJsdWV6LWRldmVsQGh1aXRsLmRlAAAAAB4AcAABAAAARAAAAFJFIDogW0JsdWV6LWRldmVsXSBh
MmRwZDogYXVkaW8gY29ubmVjdGlvbiBicmVha3MgZXZlcnkgMzAwIHNlY29uZHMAAgFxAAEAAAAb
AAAAAcc4a42Qu/H2mbABQlSGo7xy/viv8QABYx1aAB4AdAABAAAAIgAAAGJsdWV6LWRldmVsQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAHgAd
DgEAAABEAAAAUkUgOiBbQmx1ZXotZGV2ZWxdIGEyZHBkOiBhdWRpbyBjb25uZWN0aW9uIGJyZWFr
cyBldmVyeSAzMDAgc2Vjb25kcwACAQkQAQAAABYDAAASAwAATQQAAExaRnXIejgnAwAKAHJjcGcx
MjXiMgNDdGV4BUEBAwH3TwqAAqQD4wIAY2gKwHPwZXQwIAcTAoAP8wBQfwRWCFUHshHFDlEDARDH
MvcGAAbDEcUzBEYQyRLbEdPbCO8J9zsYvw4wNRHCDGDOYwBQCwkBZDM2EVALpuUH8WIEkHQsCqIK
hAqAAj4RYDJEUERbMQEbAC4xMzVdOiCAYTJkcF90cgBxqmYEkF8gQHcfwFcDYEEOsCAtMSBuITAg
IRzQMyBieQ6wcy5pHgpUaCFQdwUQIUFjVwdAAyAYwHQIcG4JgCAARUFHQUlOLCBMc28jcCFQc2gI
YGxXJKAYwBEgbiSgdCNRZD5hAZAf0AGAEyEm8Hdo7QMQZSJ7HsBJH9ACQADQ9yNQJmQFoG0LUBEw
IVAYUJxnZieyKMAFQHdhBCA9BQBlJtAkkSIgJ2FzbOBpZ2h0bCvgBGEGkPsIkCSgdgSQAJACIArj
HqL8b2Yf0yZiJtAmcAiBBCD+dCVQJh4RIC1BB0AmcAdzBigD8CaAIDEvMTB6Lx1hdQQhHnUBAAtg
eV4pIWAvciGgH9B2C3Bs1yJ7KuElpXMbcGMJ4CSgeQaQIHkIYCsBI6AqQW78ZyAJ8AhgLFAqwAZg
LwF/JpIzMi9yAdA5AB/QJlFkryVQBGAYwC8VKCwwayFQyzIQOQApKsBVbgIQACD8dW4rgSyAJSA2
wguAN0B/L4A5kRtwMdAD8CQBJ8Bh4yZhJVBnYXAEIAuAJnN/JUA7kCSgJ5AJ8CZxBAAgORDwcHAJ
8DRsP2Jua/0pdGEycCFQP5EzMBEgPyH/GMAlIAWgJdI2giYzMnEmgmBoY2lkdSngIWBW9SpCPx4E
RCVQNoIQ8C1AZzkxITBCkSBwA2AJwGGWbTJhPGJCCkFaPxFgv0Z1I1A9oBEhL3IgMHlFNf5ZNpFC
9ElhK/IlsAAgEyGaYiOgcDywAyAocziR/DMyM3A2VEiYNdA/4Bhh/z4xSRNMEEYxJUAHgCIQOUED
MaIie0ZyXCdlOV8LMFChBRAA4B4TfVHAAAAeADUQAQAAAEIAAAA8N0E2REE1NDVEN0ZEQ0M0Qjkz
REI2NTFGREJDMUVEREU0RTZFQkRAZXVtb25leDAxLnBhbG1zb3VyY2UuY29tPgAAAB4AORABAAAA
KgAAADwyMDA3MDExNTAyNTcuMjE1NDIuYmx1ZXotZGV2ZWxAaHVpdGwuZGU+AAAAHgBHEAEAAAAP
AAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAACYAAAAUgBFACAAJQAzAEEAIABbAEIA
bAB1AGUAegAtAGQAZQB2AGUAbABdACAAYQAyAGQAcABkACUAMwBBACAAYQB1AGQAaQBvACAAYwBv
AG4AbgBlAGMAdABpAG8AbgAgAGIAcgBlAGEAawBzACAAZQB2AGUAcgB5ACAAMwAwADAAIABzAGUA
YwBvAG4AZABzAC4ARQBNAEwAAAALAPYQAAAAAEAABzC1AAcacTjHAUAACDC63p5LczjHAQMA3j+v
bwAAAwDxPwwEAAAeAPg/AQAAABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAAIB+T8BAAAAWwAAAAAA
AADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAvTz1QQUxNU09VUkNFL09VPU1PTlRQRUxMSUVSL0NO
PVJFQ0lQSUVOVFMvQ049RlJFREVSSUMuREFMTEVBVQAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWlu
aXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAAD
AP0/5AQAAAMAGUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAARAAAARlJFREVS
SUMuREFMTEVBVQAAAAAeADFAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMkABAAAAKgAA
AGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgAzQAEAAAAVAAAA
Ymx1ZXotZGV2ZWxAaHVpdGwuZGUAAAAAHgA4QAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAe
ADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAGEBAbkAkDAAcQSQIAAAMA
EBAAAAAAAwAREAAAAAAeAAgQAQAAAGUAAABST0JFUlQsQTJEUEQxNTUxMzU6QTJEUFRSQU5TRkVS
UkFXOldST1RFLTFOT1Q2MDNCWVRFU1RIRVdSSVRFQ0FMTFJFVFVSTkVERUFHQUlOLFNPV0VTSE9V
TERSRVNFTkRUSEVEAAAAAAIBfwABAAAAQgAAADw3QTZEQTU0NUQ3RkRDQzRCOTNEQjY1MUZEQkMx
RURERTRFNkVCREBldW1vbmV4MDEucGFsbXNvdXJjZS5jb20+AAAAFN4=

------_=_NextPart_001_01C73873.4B955556
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C73873.4B955556
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C73873.4B955556--
