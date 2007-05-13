Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C79590.63EC4D1C"
Date: Sun, 13 May 2007 20:56:18 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4D9@mplex01.mpl.access-company.com>
References: <4646071D.6020303@gentoo.org> <464750FD.3080409@gentoo.org>
	<464756E9.4090307@gentoo.org>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE : a2dpd getting into an endless loop when it fails
	to get a socket and not dying on CTRL+c
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

------_=_NextPart_001_01C79590.63EC4D1C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

> Can someone explain why this code is in the main loop in the first
> place. I would think that the sockets need to be created only once.

This is mainly historical, as the main_loop wasn't called in loop first.
If the socket fails to create, a2dpd will retry until it is ok. This is =
useful when coding, if you forgot another process running.

Frederic




------_=_NextPart_001_01C79590.63EC4D1C
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhMSAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAbAAAAFJFIDogW0JsdWV6LWRldmVs
XSBhMmRwZCBnZXR0aW5nIGludG8gYW4gZW5kbGVzcyBsb29wIHdoZW4gaXQgZmFpbHMgdG8gZ2V0
IGEgc29ja2V0IGFuZCBub3QgZHlpbmcgb24gQ1RSTCtjACAlAQWAAwAOAAAA1wcFAA0AFAA4ABIA
AABOAQEggAMADgAAANcHBQANABQAOAASAAAATgEBCYABACEAAABDQTRBNkYxNDExQjVBQTQ0OEJF
MzI1MUFBQjg1RUJENwBaBwEDkAYA8AoAADkAAAADACYAAAAAAAMANgAAAAAAQAA5ABxN7GOQlccB
HgA9AAEAAAABAAAAAAAAAAIBRwABAAAAOAAAAGM9VVM7YT0gO3A9QWNjZXNzLUNvbXBhbnk7bD1N
UExFWDAxLTA3MDUxMzE4NTYxOFotNDE2OTcAHgBJAAEAAABrAAAAUmU6IFtCbHVlei1kZXZlbF0g
YTJkcGQgZ2V0dGluZyBpbnRvIGFuIGVuZGxlc3MgbG9vcCB3aGVuIGl0IGZhaWxzIHRvIGdldCBh
IHNvY2tldCBhbmQgbm90IGR5aW5nIG9uIENUUkwrYwAAQABOAIB6LmCLlccBHgBaAAEAAAAqAAAA
Ymx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAA
AAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAA
AAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5O
RVQAAB4AXQABAAAADQAAAFBldHRlcmkgUuR0eQAAAAACAV4AAQAAAEAAAAAAAAAAgSsfpL6jEBmd
bgDdAQ9UAgAAAABQZXR0ZXJpIFLkdHkAU01UUABiZXRlbGdldXNlQGdlbnRvby5vcmcAAgFfAAEA
AAAbAAAAU01UUDpCRVRFTEdFVVNFQEdFTlRPTy5PUkcAAB4AZgABAAAABQAAAFNNVFAAAAAAHgBn
AAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgA
AQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFgAAAGJldGVsZ2V1c2VAZ2VudG9vLm9yZwAAAB4AcAAB
AAAAbAAAAFJFIDogW0JsdWV6LWRldmVsXSBhMmRwZCBnZXR0aW5nIGludG8gYW4gZW5kbGVzcyBs
b29wIHdoZW4gaXQgZmFpbHMgdG8gZ2V0IGEgc29ja2V0IGFuZCBub3QgZHlpbmcgb24gQ1RSTCtj
AAIBcQABAAAAGwAAAAHHlYtopNl/ksWklknQi+RNyjab2ZEAAQyvtAAeAHQAAQAAABIAAABCbHVl
WiBkZXZlbG9wbWVudAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAHgAdDgEAAABs
AAAAUkUgOiBbQmx1ZXotZGV2ZWxdIGEyZHBkIGdldHRpbmcgaW50byBhbiBlbmRsZXNzIGxvb3Ag
d2hlbiBpdCBmYWlscyB0byBnZXQgYSBzb2NrZXQgYW5kIG5vdCBkeWluZyBvbiBDVFJMK2MAAgEJ
EAEAAAC1AQAAsQEAAJgCAABMWkZ1TMWK3gMACgByY3BnMTI14jIDQ3RleAVBAQMB9/8KgAKkA+QH
EwKAD/MAUARWPwhVB7IRJQ5RAwECAGNo4QrAc2V0MgYABsMRJfYzBEYTtzASLBEzCO8J97Y7GB8O
MDURIgxgYwBQMwsJAWQzNhZQC6YgPisSIAORcwNwZQIgZSADDsALUyB3aHkgdNpoBAAgBaABACAe
sR4hnx6QHbAAwB4hF7BvcB9W9GZpFAB0CqIKgBzwC1FgY2UuIEkeQAhgbNJkHoJuax6BYQVAH5L5
HVBjaxQgBCAdoAmAHoDYbyBiHbAFAGUjICQxfQIgbB5wAiAh4SE0ITRUfx6iHrEf0iVhHqEkYAUQ
Y7EHQCwgYQQgH5ZfICOydyhQbicFQCgBbCQx5x/2IOMl1UlmI0kg0AtwHmwoYSRwJMQoMTJkcJci
gAPwKfAgGCB0ch5wNnUCMAMRaQVAHrFva+siACamdRQQZiJgHkEJ8Jse0guAZygwBpAgeQhg8yDQ
BbBnbwVAAHAx8B+g3QXAcANgIeAEEXIugAMA+zEAJdtGGCEGcQDgJfkl6gJ9NnAAAAAeADUQAQAA
AEgAAAA8Q0U1MjE2QzEwQzgzOTQ0RDlGRDM3QjY1Q0QzM0YzOTcwQ0Y0RDlAbXBsZXgwMS5tcGwu
YWNjZXNzLWNvbXBhbnkuY29tPgAeADkQAQAAAFoAAAA8NDY0NjA3MUQuNjAyMDMwM0BnZW50b28u
b3JnPiA8NDY0NzUwRkQuMzA4MDQwOUBnZW50b28ub3JnPiA8NDY0NzU2RTkuNDA5MDMwN0BnZW50
b28ub3JnPgAAAB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAA6AAA
AFIARQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAGEAMgBkAHAAZAAgAGcA
ZQB0AHQAaQBuAGcAIABpAG4AdABvACAAYQBuACAAZQBuAGQAbABlAHMAcwAgAGwAbwBvAHAAIAB3
AGgAZQBuACAAaQB0ACAAZgBhAGkAbABzACAAdABvACAAZwBlAHQAIABhACAAcwBvAGMAawBlAHQA
IABhAG4AZAAgAG4AbwB0ACAAZAB5AGkAbgBnACAAbwBuACAAQwBUAFIATAAlADIAQgBjAC4ARQBN
AEwAAAALAPYQAAAAAEAABzAH9WGbj5XHAUAACDCA1vVjkJXHAQMA3j+vbwAAAwDxPwwEAAAeAPg/
AQAAABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAAIB+T8BAAAAXwAAAAAAAADcp0DIwEIQGrS5CAAr
L+GCAQAAAAAAAAAvTz1BQ0NFU1MtQ09NUEFOWS9PVT1NT05UUEVMTElFUi9DTj1SRUNJUElFTlRT
L0NOPUZSRURFUklDLkRBTExFQVUAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlzdHJhdG9yAAAA
AAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9P+QEAAADABlA
AAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUA
AAAAHgAxQAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABibHVlei1kZXZl
bC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AM0ABAAAAFgAAAGJldGVsZ2V1c2VA
Z2VudG9vLm9yZwAAAB4AOEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgA5QAEAAAACAAAA
LgAAAAMAdkD/////CwApAAAAAAALACMAAAAAAAMABhDC4SXeAwAHEBUBAAADABAQAQAAAAMAERAA
AAAAHgAIEAEAAABlAAAAQ0FOU09NRU9ORUVYUExBSU5XSFlUSElTQ09ERUlTSU5USEVNQUlOTE9P
UElOVEhFRklSU1RQTEFDRUlXT1VMRFRISU5LVEhBVFRIRVNPQ0tFVFNORUVEVE9CRUNSRUFURURP
TgAAAAACAX8AAQAAAEgAAAA8Q0U1MjE2QzEwQzgzOTQ0RDlGRDM3QjY1Q0QzM0YzOTcwQ0Y0RDlA
bXBsZXgwMS5tcGwuYWNjZXNzLWNvbXBhbnkuY29tPgAnug==

------_=_NextPart_001_01C79590.63EC4D1C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C79590.63EC4D1C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C79590.63EC4D1C--
