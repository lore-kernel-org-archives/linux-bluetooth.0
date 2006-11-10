Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C704A3.F91EF7E1"
Date: Fri, 10 Nov 2006 09:41:10 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA3@eumonex01.palmsource.com>
References: <200611091102.54282.marcel@hilzinger.hu><20061109104245.GB7085@physik.fu-berlin.de><1163066853.5983.24.camel@grappa>
	<200611100901.16410.mhilzinger@linuxnewmedia.de>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Quality of a2dp sound
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

------_=_NextPart_001_01C704A3.F91EF7E1
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

> a2dpd produces some noise in the background. If there is silence, you =
can hear=20
> it. With a2play there is no noise. I will checkout cvs again and have =
a look.

I believe this comes from a difference in the sbc encoder (floating vs =
fixed).
If you have the latest patch, I would first suggest you increase =
sbcbitpool=3D64 in .a2dprc.
If it doesn't work, then the dirty way is to swap all files from sbc/lib =
with the corresponding in btsco/sbc and then rebuild sbc library and =
reinstall of course.

BTW, do you have choppy sound like Adrian? Which player is it?

BR, Frederic

------_=_NextPart_001_01C704A3.F91EF7E1
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgsIAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAKQAAAFJFIDogW0JsdWV6LWRldmVs
XSBRdWFsaXR5IG9mIGEyZHAgc291bmQA1g0BBYADAA4AAADWBwsACgAJACkACgAFADMBASCAAwAO
AAAA1gcLAAoACQApAAoABQAzAQEJgAEAIQAAADkxMTYzRTQ2QTAwQTgyNDE4NzFCRjhFQTk4QTk1
NDhFABsHAQOQBgDICgAAOQAAAAMAJgAAAAAAAwA2AAAAAABAADkA4fce+aMExwEeAD0AAQAAAAEA
AAAAAAAAAgFHAAEAAAA2AAAAYz11czthPSA7cD1QYWxtU291cmNlO2w9RVVNT05FWDAxLTA2MTEx
MDA4NDExMFotMTAzNjYAAAAeAEkAAQAAACgAAABSZTogW0JsdWV6LWRldmVsXSBRdWFsaXR5IG9m
IGEyZHAgc291bmQAQABOAADupGWeBMcBHgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0Bs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAA
AABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRl
dmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxV
RVotREVWRUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAAEQAAAE1hcmNl
bCBIaWx6aW5nZXIAAAAAAgFeAAEAAABKAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAATWFyY2Vs
IEhpbHppbmdlcgBTTVRQAG1oaWx6aW5nZXJAbGludXhuZXdtZWRpYS5kZQAAAAIBXwABAAAAIQAA
AFNNVFA6TUhJTFpJTkdFUkBMSU5VWE5FV01FRElBLkRFAAAAAB4AZgABAAAABQAAAFNNVFAAAAAA
HgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAe
AGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAHAAAAG1oaWx6aW5nZXJAbGludXhuZXdtZWRpYS5k
ZQAeAHAAAQAAACkAAABSRSA6IFtCbHVlei1kZXZlbF0gUXVhbGl0eSBvZiBhMmRwIHNvdW5kAAAA
AAIBcQABAAAAGwAAAAHHBJ9EJ98psj3GVUr+kP9hk6aVeh0AAKBpZQAeAHQAAQAAABIAAABCbHVl
WiBkZXZlbG9wbWVudAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAHgAdDgEAAAAp
AAAAUkUgOiBbQmx1ZXotZGV2ZWxdIFF1YWxpdHkgb2YgYTJkcCBzb3VuZAAAAAACAQkQAQAAAHkC
AAB1AgAAgAMAAExaRnWoPBM9AwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP8wBQ
BFY/CFUHshElDlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREiDGBj
AFAzCwkBZDM2FlALpiBIHGksCqIKhAqAPiBhQDJkcGQgcANgZAsa0AeRcwNwZSBub0cEAB8gC4Ag
dGgfIGINANBrCcAIYG5kLiD8SWYfwhggH5Ae0QMQCfCRHrAsIHkIYCBjA5GnH+AKxR3CaXQgsFcj
cPZoHfELUXkg+B9AHzQgsbogA/BsAyAT0AWQawhgyQVAY3YEIGFnC3Ed8JMgkCKQYXYfIGEgF7AY
b2suHSoloGJlbP8IkCehH9AhYQWgB4IDUifBOmQGkGYhISHRH5ZzYoxjICHBBHIgKGYXsCRhdAuA
ZyAmsWZp+ngJgCkoNSDRIiIngx/S2wtgDrBzBUAKsHQT0CIAeyWhCGBsHkAtcBQABUBz+HVnZy9y
IiILgAUAIrArH3Er4WIjcHAoAGw9lDY0H5IuHgJyYy3YyyNwKrBvB5BuJwVAMED8cmsiAB/RH7Qq
wAAgJFA2dyRBIWF0JRAD4GFwvx3wJeEtcCGwKjUr4S8pQL5iJbEj0R/SBaEYIHMysCcgkC0CH6Fi
dATwby/PK+InQjWDGCBidQMQHkD7K+I4kXIKwCRQJ0IYIAuA+y+AN2JvIOAFoAhwJWEdKnhCVFci
ADSgLmgT0G+8cHAkUB7wIIE8UWsfIORBZAchbj8joCmwE9BfHlAkMRKBIWEjcD8+a1K9IgBGGCEG
cQDgHTN9RPAAAAAeADUQAQAAAEIAAAA8N0E2REE1NDVEN0ZEQ0M0QjkzREI2NTFGREJDMUVEREU0
RTZFQTNAZXVtb25leDAxLnBhbG1zb3VyY2UuY29tPgAAAB4AORABAAAApgAAADwyMDA2MTEwOTEx
MDIuNTQyODIubWFyY2VsQGhpbHppbmdlci5odT48MjAwNjExMDkxMDQyNDUuR0I3MDg1QHBoeXNp
ay5mdS1iZXJsaW4uZGU+PDExNjMwNjY4NTMuNTk4My4yNC5jYW1lbEBncmFwcGE+IDwyMDA2MTEx
MDA5MDEuMTY0MTAubWhpbHppbmdlckBsaW51eG5ld21lZGlhLmRlPgAAAB4ARxABAAAADwAAAG1l
c3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAXgAAAFIARQAgACUAMwBBACAAWwBCAGwAdQBl
AHoALQBkAGUAdgBlAGwAXQAgAFEAdQBhAGwAaQB0AHkAIABvAGYAIABhADIAZABwACAAcwBvAHUA
bgBkAC4ARQBNAEwAAAAAAAsA9hAAAAAAQAAHMHmRzMWhBMcBQAAIMJnjKvmjBMcBAwDeP69vAAAD
APE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5PwEAAABbAAAAAAAAANyn
QMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9TU9OVFBFTExJRVIvQ049UkVD
SVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3Ry
YXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/k
BAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5E
QUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1
ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABwAAABtaGls
emluZ2VyQGxpbnV4bmV3bWVkaWEuZGUAHgA4QAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAe
ADlAAQAAAAIAAAAuAAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAGEJ9k0TcDAAcQygEAAAMA
EBAAAAAAAwAREAAAAAAeAAgQAQAAAGUAAABISSxBMkRQRFBST0RVQ0VTU09NRU5PSVNFSU5USEVC
QUNLR1JPVU5ESUZUSEVSRUlTU0lMRU5DRSxZT1VDQU5IRUFSSVRXSVRIQTJQTEFZVEhFUkVJU05P
Tk9JU0VJV0lMTENIAAAAAAIBfwABAAAAQgAAADw3QTZEQTU0NUQ3RkRDQzRCOTNEQjY1MUZEQkMx
RURERTRFNkVBM0BldW1vbmV4MDEucGFsbXNvdXJjZS5jb20+AAAAv7w=

------_=_NextPart_001_01C704A3.F91EF7E1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------_=_NextPart_001_01C704A3.F91EF7E1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C704A3.F91EF7E1--
