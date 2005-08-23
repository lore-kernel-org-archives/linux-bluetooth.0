Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A7F3.557DB2CA"
Subject: RE: [Bluez-devel] sbc and fixed-point progress
Message-ID: <C70061B183DE09419568AB2060C52A950E4490@arion.intra.local>
From: "Victor Shcherbatyuk" <Victor.Shcherbatyuk@tomtom.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 23 Aug 2005 17:00:00 +0200

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A7F3.557DB2CA
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello Brad,

I did some test runs on ARM9@400MHz, general fixed point encoder eats up =
~40% of CPU time, while arm specific version  - ~20%. And in both cases =
it runs quite smooth. So the drops you had should have been caused by =
something else (unless you run some othe applications cuncurently).


Victor.


-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net on behalf of Brad Midgley
Sent: Mon 8/22/2005 9:22 AM
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] sbc and fixed-point progress
=20
Victor

>> I do not have HW to test arm specific version real time, hope no=20
>> suprises there, but I could have missed something when integrating it =

>> into sbc code (it decodes well, but how fast, I will try only monday=20
>> evening).
>=20
>=20
> Ok, I'll load it on gumstix now and give it a try.

This is almost perfect. On a 400mhz gumstix (pxa255), I'm able to send a =

5-minute audio stream with only about three breaks in the audio (about 5 =

seconds each).

I think it will work flawlessly in 4 subbands or if we can shorten a few =

of the ops from 64 to 32 bit.

I committed what's there and used __arm__ for the conditional asm code.

>> Using a2play needs to tweak 87 magic number, otherwise it drops =
samples?
>=20
>=20
> yes, this is disappointing. We may need to find another way to get=20
> reliable timing than setitimer.
>=20
> I did change the first usleep(10) to usleep(1000) and that *may* help=20
> with this problem by ensuring that we always interrupt the usleep=20
> syscall consistently. I don't have my hp headphones (the set that's =
very=20
> sensitive to timing) handy to test.

fwiw, I had to use the -n flag to a2play so it wouldn't use itimer at=20
all. This flag tells a2play to just send the audio as fast as it can=20
encode it.

Brad


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle =
Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & =
QA
Security * Process Improvement & Measurement * =
http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C5A7F3.557DB2CA
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgEPAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALwAAAFJFOiBbQmx1ZXotZGV2ZWxd
IHNiYyBhbmQgZml4ZWQtcG9pbnQgcHJvZ3Jlc3MArxABBYADAA4AAADVBwgAFwARAAAAAAACAA4B
ASCAAwAOAAAA1QcIABcAEQAAAAAAAgAOAQEJgAEAIQAAAEU0NzA4MTk0OTNBOTg5NDFBNkQwOTU1
NjhDNUZEOTdGACYHAQOQBgB8DgAAOAAAAAMAJgAAAAAAAwA2AAAAAABAADkAyrJ9VfOnxQEeAD0A
AQAAAAUAAABSRTogAAAAAAIBRwABAAAAJQAAAGM9Tkw7YT0gO2w9QVJJT04tMDUwODIzMTUwMDAw
Wi00MzczNgAAAAAeAEkAAQAAAC8AAABSZTogW0JsdWV6LWRldmVsXSBzYmMgYW5kIGZpeGVkLXBv
aW50IHByb2dyZXNzAABAAE4AgDm1M+qmxQEeAFoAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQAAgFbAAEAAABtAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAA
Ymx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1ZXotZGV2ZWwt
YWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALQAAAFNNVFA6QkxVRVotREVW
RUwtQURNSU5ATElTVFMuU09VUkNFRk9SR0UuTkVUAAAAAB4AXQABAAAADQAAAEJyYWQgTWlkZ2xl
eQAAAAACAV4AAQAAAEAAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABCcmFkIE1pZGdsZXkAU01U
UABibWlkZ2xleUB4bWlzc2lvbi5jb20AAgFfAAEAAAAbAAAAU01UUDpCTUlER0xFWUBYTUlTU0lP
Ti5DT00AAB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAoAAAAYmx1ZXotZGV2ZWwtYWRtaW5A
bGlzdHMuc291cmNlZm9yZ2UubmV0AB4AaAABAAAABQAAAFNNVFAAAAAAHgBpAAEAAAAWAAAAYm1p
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
KMEBgHoQbJEIUA5uWVAvgTbQICYgRXhYUE85JgUwhABzESD4MTktOkAgkDpzgiAGEV4gNLAAcCTg
BPBvIJBDekGlgUQ1gilgB4AhwUzTBpAFkHljJEFQHWAxQHcN4AeQHaRBMzAkQaNwUPELYG4tRAUQ
UlGm64Ig3k0AcHKRLEGoUG8+cgQg/aNwVF5BBCCCIKygVcEsQfmjcFFBOSYvYSdwK7CCIPer8aix
BCBJdLADYCVAp2Nfo3AzkCcgL3Gq9WgCQHCwOi8vd7GgNoBxNzAJa1EvYgTwZTVzZv8dpG1Qs0+0
X7UZmiU1KHJxfwMQLDI8krYvPI89mbEyc/+xcbkvN0K7RLtDC4ACELJQCzUoHap9vyAAAAAeADUQ
AQAAADsAAAA8QzcwMDYxQjE4M0RFMDk0MTk1NjhBQjIwNjBDNTJBOTUwRTQ0OTBAYXJpb24uaW50
cmEubG9jYWw+AAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAACwDyEAEAAAAfAPMQAQAAAGoA
AABSAEUAJQAzAEEAIABbAEIAbAB1AGUAegAtAGQAZQB2AGUAbABdACAAcwBiAGMAIABhAG4AZAAg
AGYAaQB4AGUAZAAtAHAAbwBpAG4AdAAgAHAAcgBvAGcAcgBlAHMAcwAuAEUATQBMAAAAAAALAPYQ
AAAAAEAABzAoCYoz8qfFAUAACDBOipVV86fFAQMA3j+vbwAAAwDxPwkEAAAeAPg/AQAAABQAAABW
aWN0b3IgU2hjaGVyYmF0eXVrAAIB+T8BAAAAaAAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAA
AAAvTz1FWENIQU5HRSBPUkdBTklaQVRJT04vT1U9RklSU1QgQURNSU5JU1RSQVRJVkUgR1JPVVAv
Q049UkVDSVBJRU5UUy9DTj1WU0gAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWluaXN0cmF0b3IAAAAA
AgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAADAP0/5AQAAAMAGUAA
AAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAAEAAAAVlNIAB4AMUABAAAABAAAAFZT
SAAeADJAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAHgAz
QAEAAAAWAAAAYm1pZGdsZXlAeG1pc3Npb24uY29tAAAAHgA4QAEAAAAEAAAAVlNIAB4AOUABAAAA
AgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQ5R5TuQMABxDzBgAAAwAQEAAAAAAD
ABEQAAAAAB4ACBABAAAAZQAAAEhFTExPQlJBRCxJRElEU09NRVRFU1RSVU5TT05BUk05QDQwME1I
WixHRU5FUkFMRklYRURQT0lOVEVOQ09ERVJFQVRTVVA0MCVPRkNQVVRJTUUsV0hJTEVBUk1TUEVD
SUZJQ1YAAAAAAgF/AAEAAAA7AAAAPEM3MDA2MUIxODNERTA5NDE5NTY4QUIyMDYwQzUyQTk1MEU0
NDkwQGFyaW9uLmludHJhLmxvY2FsPgAA/h4=

------_=_NextPart_001_01C5A7F3.557DB2CA--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
