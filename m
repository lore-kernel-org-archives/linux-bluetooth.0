Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C5A8A6.9C219CDF"
Subject: RE: [Bluez-devel] sbc and fixed-point progress
Message-ID: <C70061B183DE09419568AB2060C52A950E4492@arion.intra.local>
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
Date: Wed, 24 Aug 2005 14:18:30 +0200

This is a multi-part message in MIME format.

------_=_NextPart_001_01C5A8A6.9C219CDF
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Brad,

I ran one more test and instead of -n flag for a2play I changed magic 87 =
to magic 50, CPU usage dropped >2 times to ~8% on ARM9@400Mhz and sound =
is still smooth. That's how it was tested in first place which is close =
to 30 MIPS I guess...

Regards,
    Victor.


-----Original Message-----
From: bluez-devel-admin@lists.sourceforge.net on behalf of Victor =
Shcherbatyuk
Sent: Tue 8/23/2005 5:00 PM
To: bluez-devel@lists.sourceforge.net
Subject: RE: [Bluez-devel] sbc and fixed-point progress
=20
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



------_=_NextPart_001_01C5A8A6.9C219CDF
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhQMAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALwAAAFJFOiBbQmx1ZXotZGV2ZWxd
IHNiYyBhbmQgZml4ZWQtcG9pbnQgcHJvZ3Jlc3MArxABBYADAA4AAADVBwgAGAAOABIAHgADAD0B
ASCAAwAOAAAA1QcIABgADgAXABIAAwA2AQEJgAEAIQAAADBGMkMyOTQ3QkE1MjUxNDg5QkIxRDE3
RERGMzNCOTcyAC8HAQOQBgCIDwAAOAAAAAMAJgAAAAAAAwA2AAAAAABAADkA57gz8KWoxQEeAD0A
AQAAAAUAAABSRTogAAAAAAIBRwABAAAAJQAAAGM9Tkw7YT0gO2w9QVJJT04tMDUwODI0MTIyMzE4
Wi00NTc1MQAAAAAeAEkAAQAAAC8AAABSRTogW0JsdWV6LWRldmVsXSBzYmMgYW5kIGZpeGVkLXBv
aW50IHByb2dyZXNzAABAAE4AyrJ9VfOnxQEeAFoAAQAAACgAAABibHVlei1kZXZlbC1hZG1pbkBs
aXN0cy5zb3VyY2Vmb3JnZS5uZXQAAgFbAAEAAABtAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAA
Ymx1ZXotZGV2ZWwtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AFNNVFAAYmx1ZXotZGV2ZWwt
YWRtaW5AbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALQAAAFNNVFA6QkxVRVotREVW
RUwtQURNSU5ATElTVFMuU09VUkNFRk9SR0UuTkVUAAAAAB4AXQABAAAAFAAAAFZpY3RvciBTaGNo
ZXJiYXR5dWsAAgFeAAEAAABQAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAVmljdG9yIFNoY2hl
cmJhdHl1awBTTVRQAFZpY3Rvci5TaGNoZXJiYXR5dWtAdG9tdG9tLmNvbQACAV8AAQAAACQAAABT
TVRQOlZJQ1RPUi5TSENIRVJCQVRZVUtAVE9NVE9NLkNPTQAeAGYAAQAAAAUAAABTTVRQAAAAAB4A
ZwABAAAAKAAAAGJsdWV6LWRldmVsLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAeAGgAAQAA
AAUAAABTTVRQAAAAAB4AaQABAAAAHwAAAFZpY3Rvci5TaGNoZXJiYXR5dWtAdG9tdG9tLmNvbQAA
HgBwAAEAAAArAAAAW0JsdWV6LWRldmVsXSBzYmMgYW5kIGZpeGVkLXBvaW50IHByb2dyZXNzAAAC
AXEAAQAAACAAAAABxabqPUGymL/Z9NpJMYyc5r1E0Y9cAEH9kjEALO8qsh4AdAABAAAAIgAAAGJs
dWV6LWRldmVsQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AGgwBAAAAFAAAAFZpY3RvciBTaGNo
ZXJiYXR5dWsAHgAdDgEAAAArAAAAW0JsdWV6LWRldmVsXSBzYmMgYW5kIGZpeGVkLXBvaW50IHBy
b2dyZXNzAAACAQkQAQAAAAkIAAAFCAAAYw0AAExaRnVlm3AIAwAKAHJjcGcxMjXiMgNDdGV4BUEB
AwH3/wqAAqQD5AcTAoAP8wBQBFY/CFUHshElDlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIs
ETMI7wn3tjsYHw4wNREiDGBjAFAzCwkBZDM2FlALpiBCcHJhZCwKogqECoBJziAdAAOgAiBlIARg
GCCaIA6wcwVAAHBkIAuAjR8QZR0QHlBmIC0DoJpmC2BnIFAFsWEyC1HMeSAeABPRbmcJgB6QoyCA
DeAgODce4G8h9Qg1MCwSIFBVIHWWcyCAHoBkA2BwcCHRGj4UQHQHcyKRfjglAx5REMBSTTlANDDQ
ME1oeh8zcwhgH1IvBCAfEAMQAyBzBGBvdJBoLiBUE+B0JwQglGhvB+BpBUB3YSTx7x8BIdELgCBQ
aRQABUALUVJjHoB3aA3gaCcCYxcXsBQQIoIzFlBNSVDbBfAeAGcKUAQQLiywHUqoUmVnCxFzHTUg
LoG2Vg3gIpByLNsdRC0wUvZPBRAiIG4HQAXQLIEjwUswUx1ERgNhOiAKMnpCLQEAdmVsLR0QbWkL
gEBsBAB0LKAmsXJ3KnAgsSHALh5wBUAlgWJ6ZRPgbCAQIAEuxAYAaIsT0ASQYihAeXVrHUQ3BmAC
MDKQVApQIlAvMlYzOEAmEDUjEDomECDkUE0dRFRvMpszzzTTMTc1dWJqBZA3wVJFqTKQW0IyyF0m
oGIiQIsfQingeAmALXBvC4C/KiEDYAnBBBAuJR1ESDNA5xewHO8d8WRpJpIHgB7kznIm0AQgJYpI
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
Ti9PVT1GSVJTVCBBRE1JTklTVFJBVElWRSBHUk9VUC9DTj1SRUNJUElFTlRTL0NOPVZTSAAeAPo/
AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0
uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAA
AAAeADBAAQAAAAQAAABWU0gAHgAxQAEAAAAEAAAAVlNIAB4AMkABAAAAKAAAAGJsdWV6LWRldmVs
LWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAeADNAAQAAAB8AAABWaWN0b3IuU2hjaGVyYmF0
eXVrQHRvbXRvbS5jb20AAB4AOEABAAAABAAAAFZTSAAeADlAAQAAAAIAAAAuAAAAAwB2QP////8L
ACkAAAAAAAsAIwAAAAAAAwAGEBLlEgQDAAcQhAgAAAMAEBAAAAAAAwAREAAAAAAeAAgQAQAAAGUA
AABCUkFELElSQU5PTkVNT1JFVEVTVEFORElOU1RFQURPRi1ORkxBR0ZPUkEyUExBWUlDSEFOR0VE
TUFHSUM4N1RPTUFHSUM1MCxDUFVVU0FHRURST1BQRUQyVElNRVNUTzglT05BAAAAAAIBfwABAAAA
OwAAADxDNzAwNjFCMTgzREUwOTQxOTU2OEFCMjA2MEM1MkE5NTBFNDQ5MkBhcmlvbi5pbnRyYS5s
b2NhbD4AAJG2

------_=_NextPart_001_01C5A8A6.9C219CDF--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
