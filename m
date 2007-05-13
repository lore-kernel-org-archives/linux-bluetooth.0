Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7951D.E5D8C887"
Date: Sun, 13 May 2007 07:12:30 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4D3@mplex01.mpl.access-company.com>
References: <432beae0705121846x7b181d3fm180205dfa783e975@mail.gmail.com>
	<432beae0705121900q237f835ahf6d2ac63c619415@mail.gmail.com>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: <papercrane@reversefold.com>,
        "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Problems connecting to a bluetooth headset
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

------_=_NextPart_001_01C7951D.E5D8C887
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> A2DPD[18:45:01.312]: a2dp_new: 00:03:89:C4:04:6F, 44100
> A2DPD[18:45:01.312]: a2dp_new: State AVDTP_STATE_DISCONNECTED

Hi,

The default is not to connect until there is an audio stream.
As long as a2dpd do not connect, the pairing wil not be requested.
Start your media player with pcm.a2dpd as output and=20
or try the following commands :
a2dpd_ctl Connect

But nothing will be heard if no media is sent.

Frederic

------_=_NextPart_001_01C7951D.E5D8C887
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ii0FAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAPgAAAFJFIDogW0JsdWV6LWRldmVs
XSBQcm9ibGVtcyBjb25uZWN0aW5nIHRvIGEgYmx1ZXRvb3RoIGhlYWRzZXQALBYBBYADAA4AAADX
BwUADQAHAAwAHgAAACEBASCAAwAOAAAA1wcFAA0ABwAQACwAAAAzAQEJgAEAIQAAADhBN0U2Mzky
OTQ3QkYzNERCNTFDRjc5NENEODAwNTc1ADUHAQOQBgB8CgAAOQAAAAMAJgAAAAAAAwA2AAAAAABA
ADkA8WZlTh2VxwEeAD0AAQAAAAEAAAAAAAAAAgFHAAEAAAA4AAAAYz1VUzthPSA7cD1BY2Nlc3Mt
Q29tcGFueTtsPU1QTEVYMDEtMDcwNTEzMDUxNjQ0Wi00MTY4NwAeAEkAAQAAAD0AAABSZTogW0Js
dWV6LWRldmVsXSBQcm9ibGVtcyBjb25uZWN0aW5nIHRvIGEgYmx1ZXRvb3RoIGhlYWRzZXQAAAAA
QABOAIDAumwClccBHgBaAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vm
b3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZl
bC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNA
bGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIBXAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9V
TkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQAAB4AXQABAAAADgAAAEp1c3RpbiBQYXRyaW4AAAAC
AV4AAQAAAEAAAAAAAAAAgSsfpL6jEBmdbgDdAQ9UAgAAAABKdXN0aW4gUGF0cmluAFNNVFAAcGFw
ZXJjcmFuZUBnbWFpbC5jb20AAgFfAAEAAAAaAAAAU01UUDpQQVBFUkNSQU5FQEdNQUlMLkNPTQAA
AB4AZgABAAAABQAAAFNNVFAAAAAAHgBnAAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFQAAAHBhcGVy
Y3JhbmVAZ21haWwuY29tAAAAAB4AcAABAAAAPgAAAFJFIDogW0JsdWV6LWRldmVsXSBQcm9ibGVt
cyBjb25uZWN0aW5nIHRvIGEgYmx1ZXRvb3RoIGhlYWRzZXQAAAACAXEAAQAAABsAAAABx5UCfuNo
cwykYz1HX4kLx3tAQ2yfAAaz4KcAHgB0AAEAAAAiAAAAYmx1ZXotZGV2ZWxAbGlzdHMuc291cmNl
Zm9yZ2UubmV0AAAAHgAaDAEAAAARAAAARnJlZGVyaWMgRGFsbGVhdQAAAAAeAB0OAQAAAD4AAABS
RSA6IFtCbHVlei1kZXZlbF0gUHJvYmxlbXMgY29ubmVjdGluZyB0byBhIGJsdWV0b290aCBoZWFk
c2V0AAAAAgEJEAEAAAD3AQAA8wEAAPACAABMWkZ1s1bf+QMACgByY3BnMTI14jIDQ3RleAVBAQMB
9/8KgAKkA+QHEwKAD/MAUARWPwhVB7IRJQ5RAwECAGNo4QrAc2V0MgYABsMRJfYzBEYTtzASLBEz
CO8J97Y7GB8OMDURIgxgYwBQ8wsJAWQzNhZQC6YK4wqAAj4QwDJEUERbMQA4OjQ1OjAxLgIzDiBd
OiBhMmSYcF9uB9AeoDAwHiCAMzo4OTpDNB4gASAANkYsIDQ0Me8fYBz/Hg8fE1MBkA6wEMAAVkRU
UF9TVEEAVEVfRElTQ0/QTk5FQyRARCDkIOTISGksJTpUaCOQAQEYYXVsBUAEACBub1EFQHRvIAWg
bh8QY+0FQHUCMAMRdCbwGCAnkpMDkSdQZGkoIHN0GCBoYW0uIORBBCAXsG7uZx6wKZEe0WQnECgg
J9LXKEUgcCkhIAqwaQUQK2G3A/ADICfSYiOQGCBxClCfKkAJgCqlI1EAICB5CGG2IAeAKgBhLVAL
YHkSgfcD8CkgLVBjKpArxCuRCGD8dHAyQCmhLAAg5AWxKlD2eS0TAhBsF7AD8CthBaBqbQOBZAQg
OiDkK8Nf3yiQAyAIUChjJTpCMnEn0X5oLaUDIC5hJvALESeQZn8nwTA1J6EUEAIwKqUg5EYvGCEG
cQDgIPN9O/AAHgA1EAEAAABIAAAAPENFNTIxNkMxMEM4Mzk0NEQ5RkQzN0I2NUNEMzNGMzk3MENG
NEQzQG1wbGV4MDEubXBsLmFjY2Vzcy1jb21wYW55LmNvbT4AHgA5EAEAAAB5AAAAPDQzMmJlYWUw
NzA1MTIxODQ2eDdiMTgxZDNmbTE4MDIwNWRmYTc4M2U5NzVAbWFpbC5nbWFpbC5jb20+IDw0MzJi
ZWFlMDcwNTEyMTkwMHEyMzdmODM1YWhmNmQyYWM2M2M2MTk0MTVAbWFpbC5nbWFpbC5jb20+AAAA
AB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAiAAAAFIARQAgACUA
MwBBACAAWwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAFAAcgBvAGIAbABlAG0AcwAgAGMAbwBu
AG4AZQBjAHQAaQBuAGcAIAB0AG8AIABhACAAYgBsAHUAZQB0AG8AbwB0AGgAIABoAGUAYQBkAHMA
ZQB0AC4ARQBNAEwAAAALAPYQAAAAAEAABzCYBGNOHZXHAUAACDBEtOTlHZXHAQMA3j+vbwAAAwDx
PwwEAAAeAPg/AQAAABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAAIB+T8BAAAAXwAAAAAAAADcp0DI
wEIQGrS5CAArL+GCAQAAAAAAAAAvTz1BQ0NFU1MtQ09NUEFOWS9PVT1NT05UUEVMTElFUi9DTj1S
RUNJUElFTlRTL0NOPUZSRURFUklDLkRBTExFQVUAAB4A+j8BAAAAFQAAAFN5c3RlbSBBZG1pbmlz
dHJhdG9yAAAAAAIB+z8BAAAAHgAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAAAAAuAAAAAwD9
P+QEAAADABlAAAAAAAMAGkAAAAAAAwAdQAAAAAADAB5AAAAAAB4AMEABAAAAEQAAAEZSRURFUklD
LkRBTExFQVUAAAAAHgAxQAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADJAAQAAACoAAABi
bHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAB4AM0ABAAAAFQAAAHBh
cGVyY3JhbmVAZ21haWwuY29tAAAAAB4AOEABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgA5
QAEAAAACAAAALgAAAAMAdkD/////CwApAAAAAAALACMAAAAAAAMABhDLkhMAAwAHEE0BAAADABAQ
AQAAAAMAERAAAAAAHgAIEAEAAABlAAAAQTJEUEQxODo0NTowMTMxMjpBMkRQTkVXOjAwOjAzOjg5
OkM0OjA0OjZGLDQ0MTAwQTJEUEQxODo0NTowMTMxMjpBMkRQTkVXOlNUQVRFQVZEVFBTVEFURURJ
U0NPTk5FQ1RFRAAAAAACAX8AAQAAAEgAAAA8Q0U1MjE2QzEwQzgzOTQ0RDlGRDM3QjY1Q0QzM0Yz
OTcwQ0Y0RDNAbXBsZXgwMS5tcGwuYWNjZXNzLWNvbXBhbnkuY29tPgDNlA==

------_=_NextPart_001_01C7951D.E5D8C887
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C7951D.E5D8C887
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C7951D.E5D8C887--
