Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70949.37585421"
Date: Thu, 16 Nov 2006 07:32:56 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA6@eumonex01.palmsource.com>
References: <455B6987.3070703@gmail.com> <455B8696.2010405@xmission.com>
	<360bc8300611151339y65320ab4o1c6a1ab4905ee638@mail.gmail.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] RE :  Low quality audio on Bluetooth Headset
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C70949.37585421
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,
Can you send us the output of the dameon and your .a2dprc file?
As usual, which player are you using?
Thanks,
Frederic.


-------- Message d'origine--------
De: bluez-users-bounces@lists.sourceforge.net de la part de Naranjo =
Manuel Francisco
Date: mer. 15/11/2006 22:39
=C0: BlueZ users
Objet : Re: [Bluez-users] Low quality audio on Bluetooth Headset
=20
>
> what kind of quality problem? Is it only the low sampling rate or is =
it
> one of the other problems? (low volume... popping sounds... played too
> fast or slow... static...)

Very low sampling rate, it must be working about 10kHz. And I also get
disconnection problems, but this can be due to problems on my usb
connectors, they aren't working very well lately.


>
> a2dp headsets are required to support 44.1khz btw.
Mhh damn, this can be the cause. They are supposed to support 22-24kHz.

Again, if I use windows with Widcomm I get a very high rate, it must
be about 22 khz. If I use the usb-dongle that comes with it, I get a
very good rate, under linux or windows.

I will try again, and see if I can improve it.

Thanks,
Manuel.

-------------------------------------------------------------------------=

Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share =
your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3D=
DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users


------_=_NextPart_001_01C70949.37585421
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IggGAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAOgAAAFJFIDogW0JsdWV6LXVzZXJz
XSBMb3cgcXVhbGl0eSBhdWRpbyBvbiBCbHVldG9vdGggSGVhZHNldACIFAEFgAMADgAAANYHCwAQ
AAcAIAA4AAQAWwEBIIADAA4AAADWBwsAEAAHACIABgAEACsBAQmAAQAhAAAAQ0U5ODQ1NjNCQUZG
QTc0MkJFMTc5RTMzMUIzNjEwOUIAQwcBA5AGAIwNAAA5AAAAAwAmAAAAAAADADYAAAAAAEAAOQCh
KnkNSQnHAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADYAAABjPXVzO2E9IDtwPVBhbG1Tb3VyY2U7
bD1FVU1PTkVYMDEtMDYxMTE2MDYzNDA2Wi0xMjc1OAAAAB4ASQABAAAAOQAAAFJlOiBbQmx1ZXot
dXNlcnNdIExvdyBxdWFsaXR5IGF1ZGlvIG9uIEJsdWV0b290aCBIZWFkc2V0AAAAAEAATgCA0TmG
/gjHAR4AWgABAAAAKgAAAGJsdWV6LXVzZXJzLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0
AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotdXNlcnMtYm91bmNl
c0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei11c2Vycy1ib3VuY2VzQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVaLVVTRVJTLUJPVU5DRVNATElT
VFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAAABkAAABOYXJhbmpvIE1hbnVlbCBGcmFuY2lzY28A
AAAAAgFeAAEAAABPAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAATmFyYW5qbyBNYW51ZWwgRnJh
bmNpc2NvAFNNVFAAbmFyYW5qby5tYW51ZWxAZ21haWwuY29tAAACAV8AAQAAAB4AAABTTVRQOk5B
UkFOSk8uTUFOVUVMQEdNQUlMLkNPTQAAAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAA
Ymx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgAAQAAAAUAAABT
TVRQAAAAAB4AaQABAAAAGQAAAG5hcmFuam8ubWFudWVsQGdtYWlsLmNvbQAAAAAeAHAAAQAAADoA
AABSRSA6IFtCbHVlei11c2Vyc10gTG93IHF1YWxpdHkgYXVkaW8gb24gQmx1ZXRvb3RoIEhlYWRz
ZXQAAAACAXEAAQAAABsAAAABxwj+mRnwl7FsSBdBOJJpxtiwlTEdABKdGMsAHgB0AAEAAAAMAAAA
Qmx1ZVogdXNlcnMAHgAaDAEAAAARAAAARnJlZGVyaWMgRGFsbGVhdQAAAAAeAB0OAQAAADoAAABS
RSA6IFtCbHVlei11c2Vyc10gTG93IHF1YWxpdHkgYXVkaW8gb24gQmx1ZXRvb3RoIEhlYWRzZXQA
AAACAQkQAQAAABgFAAAUBQAAPQgAAExaRnUymvJRAwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3TwqA
AqQD4wIAY2gKwHPwZXQwIAcTAoAP8wBQfwRWCFUHshHFDlEDARDHMvcGAAbDEcUzBEYQyRLbEdPb
CO8J9zsYvw4wNRHCDGDOYwBQCwkBZDM2EVALprAgSGksCqIKgEMDkQp5CGAgESBuZCB1IQQgdGhl
IAhgdHDLH3AfUGYfE2RhB4ACIB4gAHAe0B5hBcAuYTJAZHByYyBmAxBlWj8dxEEEIB7wdQdALEgg
d2gN4GggC1F5vxMhCsAfQB5iHvALgGciBaJUEPBua3MdtUYYwdkGcWMuHcQmii0npQXQUQeQc2Fn
ICEnBbBpGmcLgGUnph3ERGU6MiAKMnotHvAEkHMtkQbgdW5jB5BAbAQAcHRzLnMIYStgAhBy3SiA
LikgBUABACALYCNgmwrALONOCsAAcGpvBdDfAHAKUAMgJfAAcGMEAAWgHSnFYQ6wKkAHgHIuIEAx
NS8xMS8B0DCANiAyMjozOSaFqCdjMCpAQgpBWh7hYyrhHcRPYmos0SpAUg0qMVsyMiqlXSBMb0UH
4HEiwWl0eSCgdRxkaS5AIIEyMnRvb+MfIB2AZWFkESEdxArjnQqAPje1IwEv0CBrC4AvHtAf0TUm
IYBvAmBlbbg/IEkEIDVgNfFsNYBvHyIYUAfgKGBtC1AkgSD/LgAOsB9QBcAEADqhOCYCIF8fQR/k
NpETITn1czpgKNU7cnYG8HUHgC4/8CNg+G9wcDwCLAEewCvgQALPI4Ie0DZxOCZmYSvAPIJ+cztx
P/IrwC/QJlE/8Cl9JopWBJA1gDt/IvA6sW3rHvAFQGIfQHcFsDjxPCCHAaAfYTBgMGtIejBQqkEe
wUkgoGwsACAogNc3NTXALzFuKSBjQ6Aggbs+piLwYh+hHyA8wWMDkb1G0WQKUEGxPpc18m01gP8e
8AwwHdNJxQWwSuEfITWBWRjAbicFQEcGdkTid/8uoAMgC2AOsDsAJn83+SFSfiAfMDbzBCAj4hjA
NSBpHxjBTEIisEBQGGEgNDSgLjFraHoqUHRDINkdxE1oI1AgQW5Ookt4/x8iS6AqwTBQJSBO5FSU
ESBjVFsxIC0yNEgCURpB/mcLcUYxH+BIkCrBIwA5AY808AQgA/A2oVdpZAWgfG1tSIFJASCgT/Qj
IGf/I1BF+x3ERtFHhDEgOOBVcN0wUElb9h8iTXEtXKAkkP8h4B8ROMFdcQeRXPM1YCLw913FHcRQ
A2c2gB7QRfRA0fMTITvxdXg8glx1UQtIkPsD8FBxdETxKHBbkyCyESD/H0Bb40uiB3A58VAAOqFR
C/8lKy5kUQsnpm3/bw9wH3EMaWslYWsfQFMIcFAAebkr4CBFCsASsUKAaGEB3G5mCkErUR8TRh9w
CHDJPbNJVB3ESm8LgAYAVSwTRix2JwQgVAWQaN8oYDnRAHAuoSC1J1BxXeK/V6MlMXRyVIEQ8SQD
ch3En0BAC4BKMUzzdYAgJksBbyRxKEFBsUBgYx8CA2B1vV6xYgiBH+AisHLjICgQvyCyNuAEoUug
c8AdxGgCQKBwOi8vd4BQLg6wtXeTLl1xLwEBNaBsaqCwcGhwPwqwKIA9LjAjC4CBwiZwPSwJJkPA
SUQ9REVWhBEdxP5fhN+F74a6HcQ0GTAQC3C/O/MroofPK58so3+Ic4Ahv4rPLLKM5IzjC4ACEC8q
aQVRGn2QwB4ANRABAAAAQgAAADw3QTZEQTU0NUQ3RkRDQzRCOTNEQjY1MUZEQkMxRURERTRFNkVB
NkBldW1vbmV4MDEucGFsbXNvdXJjZS5jb20+AAAAHgA5EAEAAAB7AAAAPDQ1NUI2OTg3LjMwNzA3
MDNAZ21haWwuY29tPiA8NDU1Qjg2OTYuMjAxMDQwNUB4bWlzc2lvbi5jb20+IDwzNjBiYzgzMDA2
MTExNTEzMzl5NjUzMjBhYjRvMWM2YTFhYjQ5MDVlZTYzOEBtYWlsLmdtYWlsLmNvbT4AAB4ARxAB
AAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAgAAAAFIARQAgACUAMwBBACAA
WwBCAGwAdQBlAHoALQB1AHMAZQByAHMAXQAgAEwAbwB3ACAAcQB1AGEAbABpAHQAeQAgAGEAdQBk
AGkAbwAgAG8AbgAgAEIAbAB1AGUAdABvAG8AdABoACAASABlAGEAZABzAGUAdAAuAEUATQBMAAAA
CwD2EAAAAABAAAcwSch2DUkJxwFAAAgw2T9kN0kJxwEDAN4/r28AAAMA8T8MBAAAHgD4PwEAAAAR
AAAARnJlZGVyaWMgRGFsbGVhdQAAAAACAfk/AQAAAFsAAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEA
AAAAAAAAL089UEFMTVNPVVJDRS9PVT1NT05UUEVMTElFUi9DTj1SRUNJUElFTlRTL0NOPUZSRURF
UklDLkRBTExFQVUAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAAAAIB+z8BAAAA
HgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlAAAAAAAMAGkAA
AAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAxQAEA
AAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABibHVlei11c2Vycy1ib3VuY2Vz
QGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AM0ABAAAAGQAAAG5hcmFuam8ubWFudWVsQGdtYWls
LmNvbQAAAAAeADhAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAAD
AHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQa5D8LgMABxDxBAAAAwAQEAAAAAADABEQAAAAAB4A
CBABAAAAZQAAAEhJLENBTllPVVNFTkRVU1RIRU9VVFBVVE9GVEhFREFNRU9OQU5EWU9VUkEyRFBS
Q0ZJTEU/QVNVU1VBTCxXSElDSFBMQVlFUkFSRVlPVVVTSU5HP1RIQU5LUyxGUkVERVJJQy0AAAAA
AgF/AAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUE2QGV1bW9u
ZXgwMS5wYWxtc291cmNlLmNvbT4AAADkvA==

------_=_NextPart_001_01C70949.37585421
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C70949.37585421
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C70949.37585421--
