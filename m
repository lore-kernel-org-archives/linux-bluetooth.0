Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C70B06.EE11918F"
Date: Sat, 18 Nov 2006 12:44:39 +0100
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EAE@eumonex01.palmsource.com>
References: <455CCAF4.8020007@silicom.fr><7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6EA7@eumonex01.palmsource.com>
	<455EE00B.80504@free.fr>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  RE :  SCO on bluez : some architectural tips
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

------_=_NextPart_001_01C70B06.EE11918F
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Fabien,

We won't be able to use +/- in a game or system sound!

> Let' say you use a unix socket. Sco sockets have a fixed queue length
> (something like 1 kb if i remember : this should be checked). Each SCO
> packets is 48 bytes, with 'lasts' 3 msec. Which means we can fit
> 20 packets, or 60 ms data.
> Congratulations, we just added more delay that the network itself !! =
;-)

Did you mean Unix socket have a fixed queue length? If buffering takes =
place
inside the SCO socket, then work is due to the socket itself. In both =
cases,
I would be surprised if this wasn't tunable.

Nevertheless, there is no need to know the buffer size : if the buffer =
was
1 Mb long would you wait for it to be full before reading data?=20

Last, benchmarks on the net measure unix socket latency using =B5s unit.


Probably the best way to figure out the best architecture is to have =
both and
measure.

Regards,
Fr=E9d=E9ric

------_=_NextPart_001_01C70B06.EE11918F
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IigLAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAQAAAAFJFIDogW0JsdWV6LWRldmVs
XSBSRSA6ICBTQ08gb24gYmx1ZXogOiBzb21lIGFyY2hpdGVjdHVyYWwgdGlwcwAWFQEFgAMADgAA
ANYHCwASAAwALAAnAAYAXwEBIIADAA4AAADWBwsAEgAMACwAJwAGAF8BAQmAAQAhAAAANjIwMDFF
REE5Qjc3OEM0Q0FCMTJEODZERTM4N0IzQzQATQcBA5AGACQMAAA5AAAAAwAmAAAAAAADADYAAAAA
AEAAOQCPkRHuBgvHAR4APQABAAAAAQAAAAAAAAACAUcAAQAAADIAAABjPXVzO2E9IDtwPVBhbG1T
b3VyY2U7bD1FVU1PTkVYMDEtMDYxMTE4MTE0NDM5Wi03AAAAHgBJAAEAAAA/AAAAUmU6IFtCbHVl
ei1kZXZlbF0gUkUgOiAgU0NPIG9uIGJsdWV6IDogc29tZSBhcmNoaXRlY3R1cmFsIHRpcHMAAEAA
TgCA93wi/ArHAR4AWgABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9y
Z2UubmV0AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotZGV2ZWwt
Ym91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei1kZXZlbC1ib3VuY2VzQGxp
c3RzLnNvdXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVaLURFVkVMLUJPVU5D
RVNATElTVFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAAABEAAABGYWJpZW4gQ2hldmFsaWVyAAAA
AAIBXgABAAAAQwAAAAAAAACBKx+kvqMQGZ1uAN0BD1QCAAAAAEZhYmllbiBDaGV2YWxpZXIAU01U
UABmYWJjaGV2YWxpZXJAZnJlZS5mcgAAAgFfAAEAAAAaAAAAU01UUDpGQUJDSEVWQUxJRVJARlJF
RS5GUgAAAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNl
c0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFQAA
AGZhYmNoZXZhbGllckBmcmVlLmZyAAAAAB4AcAABAAAAQAAAAFJFIDogW0JsdWV6LWRldmVsXSBS
RSA6ICBTQ08gb24gYmx1ZXogOiBzb21lIGFyY2hpdGVjdHVyYWwgdGlwcwACAXEAAQAAABsAAAAB
xwr8Jr/DKNcTCDNFw4mJHRNpESUgAAD4NBsAHgB0AAEAAAASAAAAQmx1ZVogZGV2ZWxvcG1lbnQA
AAAeABoMAQAAABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAB4AHQ4BAAAAQAAAAFJFIDogW0JsdWV6
LWRldmVsXSBSRSA6ICBTQ08gb24gYmx1ZXogOiBzb21lIGFyY2hpdGVjdHVyYWwgdGlwcwACAQkQ
AQAAAK4DAACqAwAAbwUAAExaRnWloPa/AwAKAHJjcGc5MzbxA0N0ZXgFQQEDAfcKgCcCpAPjAgBj
aArAc2UwdDEzNAYAB3BTdb5uAoAP4wBQBFYRizIC490QtzIGAAbDEeUzBEYQt9wwIAhVB7IR5TQQ
ThbAXwcTAoAR8wjvCfc7Gn8y7DU1EeIMYGMAUAsJAWQHDjAWwAumIEhpIEZzAaAIkG4sCqIKhAqA
V6hlIHcCICcFQGIgwIUBoGwgwHRvIHUREGAgKy8tIAuAIWAgFGdhB4AgBbFzeXONDqBtIzAIYG5k
IR/6KD4gTBEgJyMwYXk8IHkIYCHjIqARwGl46SOhY2sRIC4GAAWgJmVrBCAQ4HYl4mYmQAmAIBZx
ClAKUCAhkG5ndHpoJHYoI7AHgCkgC4BnBSjQaSagIDEga2L1ImBmImAgGoAHgAbQFzFOOiGwKiAE
IHNoCGBsnyhgIUEQ0AWQJqBkKSbQykUA0GgGAENPJHYKsFMnVCwxNDghMHkOoHPKLCDQaSkgICcL
YCNgonMlIDMgbREQYybQ3lcqIC3BB4AGIncs4QOR/SggdCR2HyEupS/QBbEekdEw4CBkYQGQLiR2
CFDdKQByNIAskDSAaQIgL8LNIMBqIfAFQGFkAQAoYPcEYBqANGBlC2AlYCkgNICbLAEgwG4RICDg
cmsiYAcngDeQKyAhISA7LXIpH/pEaShgJYIxoiCOVSY4J68otz8gSSsg/GJ1ASAGcSpBAZAmoAQg
+QtRY2Uf9AuAAJABADgj/y3xJmUv0DgxA6A4pDRRKLHfIcE4MjulOPQm0EkDoAbg3zARMjAREC/A
H/RJINEslfpzCHBwBRAREChgKxEsE+53MGAhAjWgbiFyNLUf9P8HwDwwACAtECGQBBBA8zdRvSwx
biHQOHAoUSHBa0mwzwfgODI99CMwaXogwCvw30YTStdGkR/0KsBNKvAaEP8qQUTkJYJGkDAAPHAF
sU6h+yHBIUFmLJADICFATtEgwD8agDbQKjI0cj2gH/pcaPh0bWwAIRfVDAFSFRbA7kwwYS/QIUBu
ENAAwDjA/wQgAiA4JjGSRXEgwCYpKNAfNIBUISVgIfAqMlwnYr41BCAmISbAUgYCsX1TGOtRSyAD
UANgYiFxN8JK0b8HkAVARpA3wSHQPIBnVbL/CGA4FFuTCsAQ0DAABZA1oP9JVCHBPBNDswBwCzEg
ElV1OUd7UmUiwAsgREZGculXkGE4YjE2CzBiRQUQCwDgIAN9Y+AAAB4ANRABAAAAQgAAADw3QTZE
QTU0NUQ3RkRDQzRCOTNEQjY1MUZEQkMxRURERTRFNkVBRUBldW1vbmV4MDEucGFsbXNvdXJjZS5j
b20+AAAAHgA5EAEAAAB4AAAAPDQ1NUNDQUY0LjgwMjAwMDdAc2lsaWNvbS5mcj48N0E2REE1NDVE
N0ZEQ0M0QjkzREI2NTFGREJDMUVEREU0RTZFQTdAZXVtb25leDAxLnBhbG1zb3VyY2UuY29tPiA8
NDU1RUUwMEIuODA1MDRAZnJlZS5mcj4AHgBHEAEAAAAPAAAAbWVzc2FnZS9yZmM4MjIAAAsA8hAB
AAAAHwDzEAEAAACUAAAAUgBFACAAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAA
UgBFACAAJQAzAEEAIAAgAFMAQwBPACAAbwBuACAAYgBsAHUAZQB6ACAAJQAzAEEAIABzAG8AbQBl
ACAAYQByAGMAaABpAHQAZQBjAHQAdQByAGEAbAAgAHQAaQBwAHMALgBFAE0ATAAAAAsA9hAAAAAA
QAAHMCp/kQcAC8cBQAAIMPMaG+4GC8cBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRl
cmljIERhbGxlYXUAAAAAAgH5PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9P
PVBBTE1TT1VSQ0UvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxM
RUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA
3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T+oAwAAAwAZQAAAAAADABpAAAAAAAMAHUAA
AAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZS
RURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABUAAABmYWJjaGV2YWxpZXJAZnJlZS5mcgAAAAAeADhA
AQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAA
AAAACwAjAAAAAAADAAYQymv72gMABxC8AgAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJ
RkFCSUVOLFdFV09OVEJFQUJMRVRPVVNFKy8tSU5BR0FNRU9SU1lTVEVNU09VTkRMRVRTQVlZT1VV
U0VBVU5JWFNPQ0tFVFNDT1NPQ0tFVFNIQVZFQUZJWEVEUVVFVUVMRU4AAAAAAgF/AAEAAABCAAAA
PDdBNkRBNTQ1RDdGRENDNEI5M0RCNjUxRkRCQzFFRERFNEU2RUFFQGV1bW9uZXgwMS5wYWxtc291
cmNlLmNvbT4AAAAlJQ==

------_=_NextPart_001_01C70B06.EE11918F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C70B06.EE11918F
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C70B06.EE11918F--
