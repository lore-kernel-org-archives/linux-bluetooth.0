Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C74F46.5444CF2D"
Date: Tue, 13 Feb 2007 09:09:48 +0100
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF471@mplex01.mpl.access-company.com>
References: <9da483cb0702121756l3541cc58u690e518940035b11@mail.gmail.com>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : Successes and failures with btsco/bluez
	respectively
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

------_=_NextPart_001_01C74F46.5444CF2D
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, thank you for reports.

When did you do all that? Latest submit was last friday.

> i ofcourse tried xmms. =20
Which version? Can you try 1.2.10?

> After a while, i decided to try mplayer, vlc, and even audacious.
Which version? Can you try 1.0rc1?

> Then i read that there was a newer plugin, a2dpd2.
Should be broken I will remove it.

> btsco-0.5 from sf.net.
Should work well, but would be better fix plugz a2dpd.

> What do you think is happening with plugz / alsa plugins that cause
> the errors I have listed?
Bad luck!

> Also, one thing I have noticed about my headset: The avrcp controls
> seem to be sent twice when I press the joystick buttons. Hitting the
Press and release.

> However, stopping the playback (ctrl-c on say, mplayer) only causes
> the headset to emit 1 avrcp_stop command.
The headset should not send command if you stop from the computer. is it =
avrcp_stop or AVDTP_STOP?

> Do you need any sort of logs from hcidump when the a2dpd2 plugin
> causes disconnects?
set your plugin as this :
pcm.a2dpd {
type a2dpd
debug 1
}
Then give us full player log, and a2dpd log. Use plugz latest cvs.

Thank you,
Fr=E9d=E9ric.

------_=_NextPart_001_01C74F46.5444CF2D
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjEIAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEASAAAAFJFIDogW0JsdWV6LWRldmVs
XSBTdWNjZXNzZXMgYW5kIGZhaWx1cmVzIHdpdGggYnRzY28vYmx1ZXogcmVzcGVjdGl2ZWx5AE4a
AQWAAwAOAAAA1wcCAA0ACQAJADAAAgAxAQEggAMADgAAANcHAgANAAkACQAwAAIAMQEBCYABACEA
AABEMkE4NERFOURDNUE4RDRGODcxMjFFMUNCQjAxM0YyOABcBwEDkAYAbAwAADkAAAADACYAAAAA
AAMANgAAAAAAQAA5AC3PRFRGT8cBHgA9AAEAAAABAAAAAAAAAAIBRwABAAAANwAAAGM9VVM7YT0g
O3A9QWNjZXNzLUNvbXBhbnk7bD1NUExFWDAxLTA3MDIxMzA4MDk0OFotNzExMAAAHgBJAAEAAABD
AAAAW0JsdWV6LWRldmVsXSBTdWNjZXNzZXMgYW5kIGZhaWx1cmVzIHdpdGggYnRzY28vYmx1ZXog
cmVzcGVjdGl2ZWx5AABAAE4AgF6aLxJPxwEeAFoAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2Vz
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAIBWwABAAAAcQAAAAAAAACBKx+kvqMQGZ1uAN0BD1QC
AAAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1ZXot
ZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFcAAEAAAAvAAAAU01UUDpC
TFVFWi1ERVZFTC1CT1VOQ0VTQExJU1RTLlNPVVJDRUZPUkdFLk5FVAAAHgBdAAEAAAAMAAAATWlr
ZSBIb2Rzb24AAgFeAAEAAAA7AAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAATWlrZSBIb2Rzb24A
U01UUABteXN0aWNhQGdtYWlsLmNvbQAAAgFfAAEAAAAXAAAAU01UUDpNWVNUSUNBQEdNQUlMLkNP
TQAAHgBmAAEAAAAFAAAAU01UUAAAAAAeAGcAAQAAACoAAABibHVlei1kZXZlbC1ib3VuY2VzQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEAAAASAAAAbXlz
dGljYUBnbWFpbC5jb20AAAAeAHAAAQAAAEgAAABSRSA6IFtCbHVlei1kZXZlbF0gU3VjY2Vzc2Vz
IGFuZCBmYWlsdXJlcyB3aXRoIGJ0c2NvL2JsdWV6IHJlc3BlY3RpdmVseQACAXEAAQAAABsAAAAB
x08Sb2sHDjDsjnNJRpHaiszDi85cAAyCnaQAHgB0AAEAAAAiAAAAYmx1ZXotZGV2ZWxAbGlzdHMu
c291cmNlZm9yZ2UubmV0AAAAHgAaDAEAAAARAAAARnJlZGVyaWMgRGFsbGVhdQAAAAAeAB0OAQAA
AEgAAABSRSA6IFtCbHVlei1kZXZlbF0gU3VjY2Vzc2VzIGFuZCBmYWlsdXJlcyB3aXRoIGJ0c2Nv
L2JsdWV6IHJlc3BlY3RpdmVseQACAQkQAQAAAA8EAAALBAAATgYAAExaRnU7Bv5uAwAKAHJjcGcx
MjXiMgNDdGV4BUEBAwH3TwqAAqQD4wIAY2gKwHPwZXQwIAcTAoAP8wBQfwRWCFUHshHFDlEDARDH
MvcGAAbDEcUzBEYQyRLbEdPbCO8J9zsYvw4wNRHCDGDOYwBQCwkBZDM2EVALpkAgSGksIHQQ8G7o
ayB5CGAgAhAFwBjAcnAYYXMuCqIKhAqAV0JoCfAgZGlkHiNkHG8gB0ADIB3RdD8gDkwhUAeQBUBz
dWJt8mkFQHdhBCALYCHRA1AJIFBheR8rPiBpIH5vENAIYREgHcAIgSBgeHRtbR8QIArjH9IN4Gi8
IHYEkACQAiAhcEMDkQMeMiUAeSAxLjIuaDEwPyN8QQGAEyFh8yJgJkBsZR2wJFAFgSBQrSUxdCDQ
J6JtC1F5BJBxHbB2bGMdsABwIGBl8yaQA6BhdSMwKmAIYB8WsyY/J0owchuAKE1UIAL7JFAYwGEq
oSFBHcEEkCTgOyJyKZBuB9ATIQtQdWfDC4Ar8TJkcGQoAB80VFNoCGBsIGBiJOBi9QNgayARSSJg
AxADIBjA1wRgLgAkQHQjbWIfAAWgcC0wLjUi8QNwIfBm7i4ycDYmNCV3BbAeEDKQ8yEAHbBidSJR
NEcRMClS6GZpeDLDejNEI20f8L8xgSDBJ2MtsB4BBAAgEPDscHAJ8AuAZzVBHdA7dXovIOFzKZAy
1AQgMWNj3yygESAj1jGxLEByA2ARELc1IRDwNeFsBAAOsGQoRcZCMTEKQGNrIShdP/B+bx2wAiAk
4T3xPvBChW58b3QN4CUxAaAIYAVAbW8nwCAAMTARITowkiDgdv0vgHBA8AIhA2A/8CPWESD/NbAq
sjSRESACMB3AA/BG4DspoTUDcBjABBFB0mpv/nkh0A3gHhA6ASrAAIAloN8dkAJAPtIxsR80UEvD
LBKXGMAp4CKAZSNtSG8ykPcuAR2wIdBvPpBNtTLBI0AmYgDQHhAoYyUAbC2+Y0WBIfAjQB2wKzUp
RYH+bCfAQQNJV0HSR7UqsjWw9SJBMUh0X1ESSNElcCwR9x8lSEJVdnM0NEahSoIgYPtXRSRAZh4j
VvM3w0HSV0H+cDoQBJAloD5BIkFWmQWxAEFWRFRQX1NUdE9QKE1EPYQycEbybp8nwEVQACAkYSKg
b2cEIPU3w2gqYXUrMEs0QdIzVN8yxSPWVFQgMTdBbjJwUoD+cyhFVbIeMTK2IOBAkj5BwjofNHBj
bS4zUwMw8wAAH0N0eT6gM0QfNAEA7zoAPvAbkwqBfVfHA6AzAP814S0QHmA0UAMgK0Rgkiv092dk
YKEloFUk0TuEC2Ahs1xjdh8cMKAd9SwfNEbgclwnZTkLMHChBRAKYx8lfXHQAB4ANRABAAAASAAA
ADxDRTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjQ3MUBtcGxleDAxLm1wbC5hY2Nl
c3MtY29tcGFueS5jb20+AB4AORABAAAAPgAAADw5ZGE0ODNjYjA3MDIxMjE3NTZsMzU0MWNjNTh1
NjkwZTUxODk0MDAzNWIxMUBtYWlsLmdtYWlsLmNvbT4AAAAeAEcQAQAAAA8AAABtZXNzYWdlL3Jm
YzgyMgAACwDyEAEAAAAfAPMQAQAAAJwAAABSAEUAIAAlADMAQQAgAFsAQgBsAHUAZQB6AC0AZABl
AHYAZQBsAF0AIABTAHUAYwBjAGUAcwBzAGUAcwAgAGEAbgBkACAAZgBhAGkAbAB1AHIAZQBzACAA
dwBpAHQAaAAgAGIAdABzAGMAbwD/+GIAbAB1AGUAegAgAHIAZQBzAHAAZQBjAHQAaQB2AGUAbAB5
AC4ARQBNAEwAAAALAPYQAAAAAEAABzBD7t95RE/HAUAACDDqulBURk/HAQMA3j+vbwAAAwDxPwwE
AAAeAPg/AQAAABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAAIB+T8BAAAAXwAAAAAAAADcp0DIwEIQ
GrS5CAArL+GCAQAAAAAAAAAvTz1BQ0NFU1MtQ09NUEFOWS9PVT1NT05UUEVMTElFUi9DTj1SRUNJ
UElFTlRTL0NOPUZSRURFUklDLkRBTExFQVUAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJh
dG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QE
AAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklDLkRB
TExFQVUAAAAAHgAxQAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABibHVl
ei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AM0ABAAAAEgAAAG15c3Rp
Y2FAZ21haWwuY29tAAAAHgA4QAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADlAAQAAAAIA
AAAuAAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAGEL0vREcDAAcQcQMAAAMAEBAAAAAAAwAR
EAEAAAAeAAgQAQAAAGUAAABISSxUSEFOS1lPVUZPUlJFUE9SVFNXSEVORElEWU9VRE9BTExUSEFU
P0xBVEVTVFNVQk1JVFdBU0xBU1RGUklEQVlJT0ZDT1VSU0VUUklFRFhNTVNXSElDSFZFUlNJT04/
Q0FOAAAAAAIBfwABAAAASAAAADxDRTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjQ3
MUBtcGxleDAxLm1wbC5hY2Nlc3MtY29tcGFueS5jb20+AINT

------_=_NextPart_001_01C74F46.5444CF2D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------_=_NextPart_001_01C74F46.5444CF2D
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C74F46.5444CF2D--
