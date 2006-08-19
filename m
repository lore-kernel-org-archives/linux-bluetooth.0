Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6C36F.92655396"
Date: Sat, 19 Aug 2006 11:12:19 +0200
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E8F@eumonex01.palmsource.com>
References: <1155918829.6708.16.camel@localhost>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : a2pdbtsco won'tcompile (FIX) plus
	xmmserror(trialsandtribulations) howcool is this!!! new patch
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

------_=_NextPart_001_01C6C36F.92655396
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I really don't know about the internals of bluez. The only thing is, try =
to update your bluez if you do not already use the latest. Only someone =
really in the deep could help.
Advice anyone?

Fr=E9d=E9ric


-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Andrew =
Waldram
Date: ven. 18/08/2006 18:33
=C0: BlueZ development
Objet : [Bluez-devel] a2pdbtsco won'tcompile (FIX) plus =
xmmserror(trialsandtribulations) howcool is this!!! new patch
=20
Fr=E9d=E9ric


Ok thought I'd start from scratch

ensure a2dpd has only 1 session=20
first attempt it all worked ??????
next attempt and subsequent

sudo hcidump =3D

andy@sidney:/etc/apanel$ sudo hcidump
HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3

a2dpd
andy@sidney:~$ a2dpd
a2dpd [Aug 17 2006 21:24:09] starting ...a2dpd addr=3D00:0D:44:2A:5C:12
timer=3D4000 us [Aug 17 2006 21:24:09]
setscheduler returns 0 (errno=3D0:Success)
Accepting incoming tcp stream connection
New connection to bluetooth [44100 hz]
avrcp: Accepting incoming connection
avdtp: Accepting incoming connection


And now when it works.

HCI sniffer - Bluetooth packet analyzer ver 1.28
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Connect Request (0x04) plen 10
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 25 scid 0x0040
< ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
      Connection successful
> HCI Event: Command Complete (0x0e) plen 6
< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Connection Packet Type Changed (0x1d) plen 5
> HCI Event: Max Slots Change (0x1b) plen 3
> ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      FlushTO 65535
< ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
< ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0
> ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
> HCI Event: Encrypt Change (0x08) plen 4
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover cmd: transaction 0
< ACL data: handle 11 flags 0x02 dlen 6
    L2CAP(d): cid 0x0040 len 2 [psm 25]
      AVDTP(s): Discover rej: transaction 0
        Error code 6
< ACL data: handle 11 flags 0x02 dlen 12

a2dpd

andy@sidney:~$ a2dpd
a2dpd [Aug 17 2006 21:24:09] starting ...a2dpd addr=3D00:0D:44:2A:5C:12
timer=3D4000 us [Aug 17 2006 21:24:09]
setscheduler returns 0 (errno=3D0:Success)
Accepting incoming tcp stream connection
New connection to bluetooth [44100 hz]
avrcp: Accepting incoming connection
avdtp: Accepting incoming connection
avdtp: socket 7: Connection from 12:5C:2A:44:0D:00, mtu=3D672
avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
temporarily unavailable)
avdtp: socket 7: Received failed result=3D-1 (errno=3D11:Resource
temporarily unavailable)
socket 7: Received 2 bytes
00000: 00 01
DEBUG: a2dp_handle_avdtp_message: (errno=3D11:Resource temporarily
unavailable)Unexpected headset directive 1
DEBUG: a2dp_handle_avdtp_message: Answering command packet
(msgtype=3DMESSAGE_TYPE_REJECT,signal=3D1)
avdtp: socket 7: Received frame, start xmms --play


so it looks to my simple mind that l2cap never completes properly.

Not sure why when running both as forground tasks appear to get
different result to what I've posted previously but possibly I'm an
idiot ;-), Or maybe there is more than one problem, or to many changes
invalidating findings.

At least I can see why its not working now but don't know what todo
about it

maybe I should never have looked at each log in isolation so think we
should go from here as I can reproduce this easily.



-------------------------------------------------------------------------=

Using Tomcat but need to do more? Need to support web services, =
security?
Get stuff done quickly with pre-integrated technology to make your job =
easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache =
Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C6C36F.92655396
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhQJAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAcwAAAFJFIDogW0JsdWV6LWRldmVs
XSBhMnBkYnRzY28gd29uJ3Rjb21waWxlIChGSVgpIHBsdXMgeG1tc2Vycm9yKHRyaWFsc2FuZHRy
aWJ1bGF0aW9ucykgaG93Y29vbCBpcyB0aGlzISEhIG5ldyBwYXRjaAAMKQEFgAMADgAAANYHCAAT
AAsADAATAAYAKAEBIIADAA4AAADWBwgAEwALAAwAEwAGACgBAQmAAQAhAAAANUZCNjY1QzdDRTA2
NzM0Mzk2MzAwODU5RDFDODA3Q0EAGgcBA5AGAIgUAAA5AAAAAwAmAAAAAAADADYAAAAAAEAAOQCW
U2WSb8PGAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADQAAABjPXVzO2E9IDtwPVBhbG1Tb3VyY2U7
bD1FVU1PTkVYMDEtMDYwODE5MDkxMjE5Wi0xNjMAHgBJAAEAAABuAAAAW0JsdWV6LWRldmVsXSBh
MnBkYnRzY28gd29uJ3Rjb21waWxlIChGSVgpIHBsdXMgeG1tc2Vycm9yKHRyaWFsc2FuZHRyaWJ1
bGF0aW9ucykgaG93Y29vbCBpcyB0aGlzISEhIG5ldyBwYXRjaAAAAEAATgAAvpAU5MLGAR4AWgAB
AAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAgFbAAEA
AABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVaLURFVkVMLUJPVU5DRVNATElTVFMuU09VUkNF
Rk9SR0UuTkVUAAAeAF0AAQAAAA8AAABBbmRyZXcgV2FsZHJhbQAAAgFeAAEAAABEAAAAAAAAAIEr
H6S+oxAZnW4A3QEPVAIAAAAAQW5kcmV3IFdhbGRyYW0AU01UUABhbmR5QHNhbXVyaS5kZW1vbi5j
by51awACAV8AAQAAAB0AAABTTVRQOkFORFlAU0FNVVJJLkRFTU9OLkNPLlVLAAAAAB4AZgABAAAA
BQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQAAAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAGAAAAGFuZHlAc2FtdXJpLmRl
bW9uLmNvLnVrAB4AcAABAAAAcwAAAFJFIDogW0JsdWV6LWRldmVsXSBhMnBkYnRzY28gd29uJ3Rj
b21waWxlIChGSVgpIHBsdXMgeG1tc2Vycm9yKHRyaWFsc2FuZHRyaWJ1bGF0aW9ucykgaG93Y29v
bCBpcyB0aGlzISEhIG5ldyBwYXRjaAAAAgFxAAEAAAAbAAAAAcbC5CPFXtcfWse8Q8O/uMSLGVYa
EgAihbZlAB4AdAABAAAAEgAAAEJsdWVaIGRldmVsb3BtZW50AAAAHgAaDAEAAAARAAAARnJlZGVy
aWMgRGFsbGVhdQAAAAAeAB0OAQAAAHMAAABSRSA6IFtCbHVlei1kZXZlbF0gYTJwZGJ0c2NvIHdv
bid0Y29tcGlsZSAoRklYKSBwbHVzIHhtbXNlcnJvcih0cmlhbHNhbmR0cmlidWxhdGlvbnMpIGhv
d2Nvb2wgaXMgdGhpcyEhISBuZXcgcGF0Y2gAAAIBCRABAAAAagsAAGYLAAD2GQAATFpGdVvPnzsD
AAoAcmNwZzEyNeIyA0N0ZXgFQQEDAfdPCoACpAPjAgBjaArAc/BldDAgBxMCgA/zAFB/BFYIVQey
EcUOUQMBEMcy9wYABsMRxTMERhDJEtsR09sI7wn3Oxi/DjA1EcIMYM5jAFALCQFkMzYRUAumcCBI
aSwKogqECoBJhiAYwAdAbHkgZAIg4icFQGtubwfgAaAIYOEFQHRoZSALgA6wBKAjB0AEIG9mIAoy
ei58IFQgMQIgHuEgIAuAZykgUHMsIBByIhFvIJB1cGRhDrAgeQhh3yEkIFAhECOxHwEgH4AFQOsH
QB6hZB7wdREgIBMLYKkOsHN0IYBPIfJzA3B+ZQIgIEAepQuAIBMBAGWEcCAFoHVsZCAgMIhscC4d
xEFkdg3gLyBAAHAjsCdgPx3KRnLwXCdlOQswK6EFEADgOx3ZHcQtLXUF0AeQc2FKZyhRJwWwaWcL
gGWjLXYdxERlOiEkLQEAKnYpMC0f0W4qEHNA4mwEAHRzLicQCHAqEPUCEHIuUC4nYAVAAQAmMcYg
CrEys0FuZBjAB+DmVwdAM9BhbS+VI3EwEIUwsG4hgDE4LzA1sMkB0DA2NZE6MxXQHdSoJ2MwMBBC
CkFaKGE5MLFvcAeAAjAdxE9itmoyoTAQWzdiMHVdH7CaMiNQYjGgBaAgdx8iGQWgbXADECBAKEZJ
HFgpMyAKQAQgeG1t5REgcgNgcigi0AcxLjBbM8A88WIo4CNwaQIgc3074GgfkAWgBvAigSIic74h
P1Ak8AfRCrA7EGgdxGcK4ytfLG9PayARCGBn8mgFQEknKQAmgDNCA1LfJwAFAD/oHcQJ8HMIcCoh
bDJkI1ApEGEg4SHyMc8nAC4RPgFAhWZpERAlIe0CQGU7QAVAaSUiAyA60ORyawmAID9J4x3EJ2BP
DtFIhj1RJwB1YhEgcR8KUDhWHcRF4CTRaGNpZGR1O0AgPR3KPVF5ikAAkGQnYHk6LxEwmGMvYQqw
J2BsJEuh0004HcRIQx6AcwMAASBfEyEt4DdiIxAlEGgzIWPnSaBLUgdAeXoTITCwBcDwMS4yOB3E
MJEqATAQr01hEVBRoE/AXztwbjAQfDEwVEBEMAMQIIEwEDBueAEgVyQdxD4dgFFxRa01UXQwEAhQ
bidgYwVAllJL8khRKFcAMDQ74vcJ8FYhHcQ8WBMIUDxgPVH5MBBBYyoQBTFY1UeCWVqsMXxZ4TYQ
OVolN1evb1iyW5MGAAGQdDwhWdJmbVolNF7vMBBMC4BDAEvTT0BZSjE3WiU2Wr9bwl9jD1lQC1Ae
8F2pYlolMn8OUGHvYAdbcVpBI4FZ0mVjWi1YAEFDTB8AI3BhV1UhPVE7cTFHIGYLYGe/BCBZ4RTg
bWFacWjlIG9RwEwyQ0FQKD4wWLjlGMBxMBBwc0RwDjBEgX9NgG4iWgBsB1gvXFJqyTN3WiYbk2Uv
VwUQI4FmM1B/BvAN4B7wBmACQCJRYOQyfV30ZGFfaY9qn2SPW2hDF20xLlFceVBS9FR5cP9rFF3l
YU96D2B/gL9YbH7Ob33kKQBkEnj2NYP/MBBN/GF4BgAYUDGgfdZkEmhWzzaWTmRGQk5fOn5QIIu6
2UZDW0FDUDWQN2jANhLAMjE6MjQ6XkA6EHtD4yJSLpBgRjQlgDPQPSM2EI+ARDo0j3AyQfA6NUM6
btY98AeAkSD/cgA2ECWxjl+PZEy1ETAE8P8gME2QO3AFwBjAguAEoG4RzzuQPJEfgJEwOlMbcDEx
/z4wKXVcEyJTMSADcCJSOxD/KKAmgB6hRHAFoFyWHcQHwu+aGCMCCjJShFuRoFYwEVCkaHqU5WF2
MgBwW+b/mJuaHp3QPXCeH58vLH4zsfsk8QfgdyAwA6BJAUlyMbD/HcpRb1J/U49Un1WvVr+ID/9Y
31nvfN9cD10fXi+BX4Jv/4N/Ym9jf3w/ZZ9mr2e/aM//em97f2v4rL9zv3TPdd927/93/7XubJ9t
r26/b89w33Hof6+gyI/Jn68BuWXLT8xUc/2gsWRxiM1aHpFF4KswlpH/Q+G1Uq810VLRULEJReCX
c/5mKODAr76fe6/D733Pft//f++2X7R/tY/fX9yPhk+HX/+Ib4l/iovIb8+P0J/Rqkgg3yJwzKPT
CurXEVBj4cnV9GJGPBFoVE/akBsAM//l9c5/6o+u4++57J/Ss9PK/+651IfvY9WLl1XxX/Jvyi//
9I/tX+5v+Enpf/s/89/9X9/1//cP+B/5LuJ7RTEgIuBfsNLn5zXQ4Z/iqE5NoGK/EyEhAdlWKQDd
JMajMcMm/+X3AP8CD9qHA7jHcDAQ0xkfvSM5QMz0lOXV9EFWRDpUy8REMYAowKhyY23/sGEi0CpA
LjCxVM4PEJ8Rr98SvxPPFN8V75Xzahdf1bj91fBFPKIosTLR2qcYzxnf//xoi1+MD40fji+PP5BP
kV//km+Tf5SPlZ+Wr5e/mM+Z3/+a75v/nQ+gv6HPoD85jzqf9QUxb6eTN+MrREP8gCzSjyyxLIEs
USnQLCBt4QB4PTY3/JU9/63gqZBpc9hwo/BmYasgSbHUhD3uLSQwMaUkIDqt4D5gMTB/qZAtNUsh
SYAq0KsgvBB19afwdkOxYTcQwABBr0K/f0PPRN9F70b/MCBInx0xYv55DgD5tbKxLCGrgDGAsmDB
HeRERUJVR6twKOLqXyO0XztTXy2wMoD/gL+poUrP5JBMSR3kTQpVwgD+eN2wwiAOETCAK9AwMfwg
/mn+ULFR2HCooFDvUf9TBPmj0HN3MbA8tOB0p3Qd5CAobXNndN2hPU0ARVNTQUdFX1QEWVBdkFJF
SkVD9FQsJ5Bnp/FLIEevSL/PIDAtsEEQKrMgeLAgLlD0LS2u0GFVNWKKPmCkku3ngG+lADbSbbwQ
J5DCcj9BIDxgo/A3gODwHPAyY7+qQKQAqWAW8sJlLlBwIfDt3bByqBClK043cNbx/lB3pEG8EKRT
ck0ApkA0EWLVN3JhLlBmpOBnIfBNAP9lYWpwZDGqQN2wKtA20grQ/1w1V5CmYq0R1HY24aRQZaH8
SSdYAUxwKrAOEWcwqWHlS5BzvAFidbIQbrEnkP83ELwQbmDNEKfgHeQnoBfw0bIQOy0pQRBPFwDZ
AL55DTBlcW0RpJAuUG2k4L9ygqfgDWDCAGciR3FtQRD/IgFkYqfgvBAwcNwi+bU8YP9HIMXgI1E0
AqsQJ1DGcqUrfkFj4TSwrjGv4GXw1uFl/2j0pKAuUKQQpLQ0AqQSb9LqZNzwJ7IQa6QUZaE3UP97
MCiFaiBv4aSgYopyRKYR+mhLkGyj8WZDI7BYAWQC/w4RZaE0sDBwY/EzknLxxdD/dpHW0jbwN4C3
olrwL9V+pP5nNvA/s3KzanF41P5QZzH/MKBUYoHwLlB4gUzBpSuGWn9iIIePiJ+Jr4q/ivEd5FX7
J5A0EVQ8kGXwshBv0sIA7w4RNuF7MHMjPwzwjYXXAKdrsKTgpLFlYnkhcqlynnNhUcIQMTCkoHk/
HeT2R91hKrB1rBB7IuSQsdB1qYBrvAF3pKCnUf5QLb88YA4AatDg8I2SwhBopBBPgKG8EHTTPpAg
eUuRIL5qdDCFczGwWEWkIG7ngDMr0G5QQk3FAI+QU3D9crNBa7DF4YFUxjCP4KhC+i6osDCZMDcA
anAOEdzx/5fwgGHkkJFQIfCmQHMwHeSmaMZQO5AvLzAwbCtglHMt8KAuSbBsa/+AKi7CAHSb4j8X
IT1snbewJnpgnaD8gDA3stAEJmKeETI2MzA1XDcmI1GeMevQNPyVX5+gb6F/okod5KbSei2pUX+c
AHIxqyA0AsXgKrCjX0BvpPKccEuEaqJlnPKbKHN/m8GmX5zzqIOoczxgaqAvFzcSo/WGWn2sUAAA
HgA1EAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RThGQGV1bW9u
ZXgwMS5wYWxtc291cmNlLmNvbT4AAAAeADkQAQAAACUAAAA8MTE1NTkxODgyOS42NzA4LjE2LmNh
bWVsQGxvY2FsaG9zdD4AAAAAHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hABAAAAHwDz
EAEAAADyAAAAUgBFACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAAYQAyAHAA
ZABiAHQAcwBjAG8AIAB3AG8AbgAnAHQAYwBvAG0AcABpAGwAZQAgACgARgBJAFgAKQAgAHAAbAB1
AHMAIAB4AG0AbQBzAGUAcgByAG8AcgAoAHQAcgBpAGEAbABzAGEAbgBkAHQAcgBpAGIAdQBsAGEA
dABpAG8AbgBzACkAIABoAG8AdwBjAG8AbwBsACAAaQBzACAAdABoAGkAcwAhACEAIQAgAG4AZQB3
ACAAcABhAHQAYwBoAC4ARQBNAEwAAAAAAAsA9hAAAAAAQAAHMOMPnjpuw8YBQAAIMArdbpJvw8YB
AwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAAgH5PwEAAABb
AAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9TU9OVFBFTExJ
RVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABTeXN0ZW0g
QWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAA
LgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAABEAAABG
UkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAyQAEA
AAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAA
ABgAAABhbmR5QHNhbXVyaS5kZW1vbi5jby51awAeADhAAQAAABEAAABGUkVERVJJQy5EQUxMRUFV
AAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQs8eWYAMABxC0
EQAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJLElSRUFMTFlET05US05PV0FCT1VUVEhF
SU5URVJOQUxTT0ZCTFVFWlRIRU9OTFlUSElOR0lTLFRSWVRPVVBEQVRFWU9VUkJMVUVaSUZZT1VE
T05PVEFMUkVBRFlVU0VUSEUAAAAAAgF/AAEAAABCAAAAPDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUx
RkRCQzFFRERFNEU2RThGQGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4AAABi7A==

------_=_NextPart_001_01C6C36F.92655396
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------_=_NextPart_001_01C6C36F.92655396
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C6C36F.92655396--
