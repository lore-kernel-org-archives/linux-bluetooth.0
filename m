Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6CECB.4ABC5952"
Date: Sat, 2 Sep 2006 22:06:35 +0200
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E91@eumonex01.palmsource.com>
References: <44EC8877.8050200@palmsource.com> <44F5A472.30003@xmission.com>
	<44F7088F.6090606@palmsource.com> <44F9ABCF.1020706@xmission.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Big patch to a2dpd
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

------_=_NextPart_001_01C6CECB.4ABC5952
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Brad,

> It only works if the bdaddr is specified in .asoundrc (the old way) as
> well as in .a2dprc. Specifying it on the a2dpd command line does not
> seem to help.
Now that you tell it, as the .a2dprc is reread for address changes it =
will overwrite the value set by command line. You can use, =
enablerereadconfig=3D0. The .asoundrc is ignored.

> Audio only came out the left speaker using my itech r35 black set. (My
> other sets are up at work)
I have a reversed stereo. It may be related. I haven't found where but =
it's one of the main problems. Try enablereversestereo=3D1 and see if =
audio comes from the right speaker. This would mean the failure came =
before compression and transmission.
Also try playing with sound balance on xmms and look at alsamixer -D =
ctl.a2dpd to see if both internal channel values are the same.
Does the standard a2dp plugin work well with that headset?
I have a faulty headset that does that too. When I shoot it it goes ok =
:D

> How do you switch on the fly to wired audio?
Modify the .a2dprc file, write enablealsaredirect=3D1 instead of 0 and =
save. Yes, file ipc :D

> Could we contribute this stuff to a wiki?=20
Man is to my eyes the standard unix doc format. Even gnu info is nothing =
:D Why not a manpage stored in cvs, there are certainly php scripts that =
can render a man page in html.

The wiki is good for writing but having some docs in the project is =
better. The wiki needs to be watched over and there would be no way to =
automatically provide docs to a distro... The manpage can be installed =
with unbuntu packages.

------_=_NextPart_001_01C6CECB.4ABC5952
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IiQUAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAJgAAAFJFIDogW0JsdWV6LWRldmVs
XSBCaWcgcGF0Y2ggdG8gYTJkcGQAWAwBBYADAA4AAADWBwkAAgAWAAYAIwAGAC0BASCAAwAOAAAA
1gcJAAIAFgAGACMABgAtAQEJgAEAIQAAAEQ2MzIxNTVGN0M5MDQ5NDI5RjYyRDk4MUQyRTBBRTNB
ACgHAQOQBgAQDQAAOQAAAAMAJgAAAAAAAwA2AAAAAABAADkAUlm8SsvOxgEeAD0AAQAAAAEAAAAA
AAAAAgFHAAEAAAA1AAAAYz11czthPSA7cD1QYWxtU291cmNlO2w9RVVNT05FWDAxLTA2MDkwMjIw
MDYzNVotNTA0NwAAAAAeAEkAAQAAACUAAABSZTogW0JsdWV6LWRldmVsXSBCaWcgcGF0Y2ggdG8g
YTJkcGQAAAAAQABOAICxp5+pzsYBHgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABi
bHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVs
LWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVot
REVWRUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAADQAAAEJyYWQgTWlk
Z2xleQAAAAACAV4AAQAAAEAAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABCcmFkIE1pZGdsZXkA
U01UUABibWlkZ2xleUB4bWlzc2lvbi5jb20AAgFfAAEAAAAbAAAAU01UUDpCTUlER0xFWUBYTUlT
U0lPTi5DT00AAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91
bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAA
FgAAAGJtaWRnbGV5QHhtaXNzaW9uLmNvbQAAAB4AcAABAAAAJgAAAFJFIDogW0JsdWV6LWRldmVs
XSBCaWcgcGF0Y2ggdG8gYTJkcGQAAAACAXEAAQAAABsAAAABxs6pt8Isp+TJ/ARAD7kXdqoIkpom
AAdx3lQAHgB0AAEAAAASAAAAQmx1ZVogZGV2ZWxvcG1lbnQAAAAeABoMAQAAABEAAABGcmVkZXJp
YyBEYWxsZWF1AAAAAB4AHQ4BAAAAJgAAAFJFIDogW0JsdWV6LWRldmVsXSBCaWcgcGF0Y2ggdG8g
YTJkcGQAAAACAQkQAQAAABYFAAASBQAAfwcAAExaRnV1Y8ClAwAKAHJjcGcxMjXiMgNDdGV4BUEB
AwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshElDlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIs
ETMI7wn3tjsYHw4wNREiDGBjAFAzCwkBZDM2FlALpiBIgGkgQnJhZCwKomMKhAqAPiBJBUACIGxo
eSB3BbBrBCAGkCBAdGhlIGJkHUBk4wXABAAgc3AFkAaQCJBGZB8gA6AuYXMIYG5xH+BjICgfYgbw
IMB3MGF5KSAhIB3Wd2WObAMgISAg1DJkcCGA1i4GACBTeQuAZx8gHmJvH1Mj8iDABaBtA4EgwGwT
C4AfgGRvB5Fub3STHdYUEGVtH1BvIB9wyGxwLh10Tm8H4B9gemEFQHkIYB9QI0IlICx/I3IfYiPl
IAIYIBggHUAg/wIQBcAfwgeQBCAT0STwB5GnJSED8CNRb3YEkHcFEHsOsB9TdgdAClAn4QVAYlce
sCYqJFBZKcFjA5F17xQQKmAJ8AGgbCuxK8IFoKJuIJBnPTAkUFQqw38hNiARMjAnQBghKLUd1kH4
dWRpKFAegzCgB4AecD51BUAfYjFwAYAgMmFr9xKBMOAk4m0esC4xE9ArkMwzNR+QC2Bjay8CJFD4
KE15HdYnUB9wBcAUEecEIArAH4B1cCKALWEe4eopHXRJKGBhLeAigCuRty3hFBAgwHMOsBggbyRQ
9x5RAMAesGIfgBggC2AOsOc0AB5AO/NuJwVAAhAhUd8ewDoBH4E2ESUgJwQgAiBfIeEfRADAIOEk
IG8xYW16czJxch6wMTY8kz0EPd4xIoAmcSfxHyJhNRMmIc8HkQNSH1MFEGdoNrcycnsgER7QdSIR
B4ADkR9iZv8LcApAOqE1sz3wLBFIcQNw3yQgLJE1MAOgJmJ0HTAAgM5tBAFJ0Si1QWwhMEpBfx6w
C1Ek0wPwH2AgMD9jYtsHQABwYyHhA6B4JkA6cbkmcm9vOMApgQdAczXAJGl4EoEtRCYQdGz/I+NK
MShQRCUG4EyxC4A9Ef8xQAMgLNImwAMgLrM6dB9i908hMDAddEQnAlMjAZAhYOcLESWzTAF1ZyDh
HtIjJN9MkyljH3AdQBQRPzuNSBD9R0B0HrBXNSlUJvMpYyhAnT1RVx9wA6A74HNoTpCbQDIlEmcn
Ak6hOkQdfN5IKTEm8CmjA+F0OBElVX5mHqEoQQPwGCFEhFelTf8EcCSxKqsgkDFwKmAuFDE0/08C
GCFfkU/QQ7ELgD0BK+H/QOEWUEPjPBEwQQeQKmBh0v0fIHAhkFyOCFEiEkkyAjDPBRBAES5SIBJ0
dQEgKDLjPFAD8GtpPwrjYIEDkecgEShBN7FleVQ+IVBPUN8m4WGxBbAAwDkBRT7xW/D+binQC4AC
ECACJ0FG4CTx/1yAWsEesCdBPEEDgQqwLRDnPPEz0iDSY3ZlcTnyJaGfSGIEkAGQC4AeoXBoOuD/
BPRaFTCiGCAhYBKBb3NBkPdv0iDhRhBtT/AdejKSaXL/IAJcAARwLAMuEiTiQBI8AX8k4iEwNdFs
cSOTH2JBoWr/Y4EgAj3wAkBGlHYVJsAJgP9qgz3xIkBeYSCxLdJKBD/D/0ckPfEnQCIyaRM2EANx
d3D/MKAjUEvxA2B4IAEAeLRpI/c1ID0AA2AugQAyg2+WMKL/PfFj4n8xILFMkyFQQBACML8p0Aqw
OLBv0UIQHXR9hOAAAB4ANRABAAAAQgAAADw3QTZEQTU0NUQ3RkRDQzRCOTNEQjY1MUZEQkMxRURE
RTRFNkU5MUBldW1vbmV4MDEucGFsbXNvdXJjZS5jb20+AAAAHgA5EAEAAACCAAAAPDQ0RUM4ODc3
LjgwNTAyMDBAcGFsbXNvdXJjZS5jb20+IDw0NEY1QTQ3Mi4zMDAwM0B4bWlzc2lvbi5jb20+IDw0
NEY3MDg4Ri42MDkwNjA2QHBhbG1zb3VyY2UuY29tPiA8NDRGOUFCQ0YuMTAyMDcwNkB4bWlzc2lv
bi5jb20+AAAAHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDzEAEAAABYAAAA
UgBFACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAAQgBpAGcAIABwAGEAdABj
AGgAIAB0AG8AIABhADIAZABwAGQALgBFAE0ATAAAAAsA9hAAAAAAQAAHMKr9PX/HzsYBQAAIMABF
yErLzsYBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5
PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9TU9O
VFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABT
eXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEA
AAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAA
ABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAA
HgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAe
ADNAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5jb20AAAAeADhAAQAAABEAAABGUkVERVJJQy5E
QUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQQtbF
7wMABxDGBAAAAwAQEAAAAAADABEQAQAAAB4ACBABAAAAZQAAAEhJQlJBRCxJVE9OTFlXT1JLU0lG
VEhFQkRBRERSSVNTUEVDSUZJRURJTkFTT1VORFJDKFRIRU9MRFdBWSlBU1dFTExBU0lOQTJEUFJD
U1BFQ0lGWUlOR0lUT05USEVBMkRQREMAAAAAAgF/AAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5
M0RCNjUxRkRCQzFFRERFNEU2RTkxQGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4AAACEhw==

------_=_NextPart_001_01C6CECB.4ABC5952
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------_=_NextPart_001_01C6CECB.4ABC5952
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C6CECB.4ABC5952--
