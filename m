Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C78893.E3BDE0AC"
Date: Fri, 27 Apr 2007 08:18:36 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4CD@mplex01.mpl.access-company.com>
References: <463151D2.1040805@jlab.org> <4631762B.9060704@xmission.com>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Plugz, a2dpd, and a2dpd2 strangeness
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

------_=_NextPart_001_01C78893.E3BDE0AC
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Brad,
> I guess he is talking about sending sound from plugins to alsa instead =
of bt=20
> enablealsaredirect=3D1

Chris
> hcidump -X -V shows no traffic except briefly when those chirps occur.
I understand you have sound through alsa but not through a2dp, and only =
occasional chirps?
What headset/adapter is it? Did you start hcidump before a2dpd?
Make sure to use 44100hz 16bits samples.
I need the full a2dpd -g output or enabledebug=3D1 in a2dprc to help =
more.
Use pcm_a2dpd if it gives good result through alsa.

Frederic

-------- Message d'origine--------
De: bluez-devel-bounces@lists.sourceforge.net de la part de Brad Midgley
Date: ven. 27/04/2007 06:03
=C0: BlueZ development
Objet : Re: [Bluez-devel] Plugz, a2dpd, and a2dpd2 strangeness
=20
Chris

> With pcm_a2dpd2 I have jumpy, very sped up sound from the headphones =
and=20
> plenty of traffic through hcidump. Alsa redirect sounds about the same =

> as the headphones, but the daemon gives the following errors:

I'm not following you here. What's the difference between using
pcm_a2dpd2 and the "alsa redirect"? I didn't catch what "same as the
headphones" was referring to either.

Brad



-------------------------------------------------------------------------=

This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel


------_=_NextPart_001_01C78893.E3BDE0AC
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IiUGAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAOAAAAFJFIDogW0JsdWV6LWRldmVs
XSBQbHVneiwgYTJkcGQsIGFuZCBhMmRwZDIgc3RyYW5nZW5lc3MAuhIBBYADAA4AAADXBwQAGwAI
ABIAJAAFAEABASCAAwAOAAAA1wcEABsACAASACQABQBAAQEJgAEAIQAAADhBN0Y1QjlEOTlERDVC
NDVCQUIyQkFFMzRDMjU5OUI2AH4HAQOQBgAUDQAAOQAAAAMAJgAAAAAAAwA2AAAAAABAADkArOC9
45OIxwEeAD0AAQAAAAEAAAAAAAAAAgFHAAEAAAA4AAAAYz1VUzthPSA7cD1BY2Nlc3MtQ29tcGFu
eTtsPU1QTEVYMDEtMDcwNDI3MDYxODM2Wi0zNjg3MgAeAEkAAQAAADcAAABSZTogW0JsdWV6LWRl
dmVsXSBQbHVneiwgYTJkcGQsIGFuZCBhMmRwZDIgc3RyYW5nZW5lc3MAAEAATgCAx74SgYjHAR4A
WgABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAgFb
AAEAAABxAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0
cy5zb3VyY2Vmb3JnZS5uZXQAU01UUABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZv
cmdlLm5ldAAAAAACAVwAAQAAAC8AAABTTVRQOkJMVUVaLURFVkVMLUJPVU5DRVNATElTVFMuU09V
UkNFRk9SR0UuTkVUAAAeAF0AAQAAAA0AAABCcmFkIE1pZGdsZXkAAAAAAgFeAAEAAABAAAAAAAAA
AIErH6S+oxAZnW4A3QEPVAIAAAAAQnJhZCBNaWRnbGV5AFNNVFAAYm1pZGdsZXlAeG1pc3Npb24u
Y29tAAIBXwABAAAAGwAAAFNNVFA6Qk1JREdMRVlAWE1JU1NJT04uQ09NAAAeAGYAAQAAAAUAAABT
TVRQAAAAAB4AZwABAAAAKgAAAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0AAAAHgBoAAEAAAAFAAAAU01UUAAAAAAeAGkAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5j
b20AAAAeAHAAAQAAADgAAABSRSA6IFtCbHVlei1kZXZlbF0gUGx1Z3osIGEyZHBkLCBhbmQgYTJk
cGQyIHN0cmFuZ2VuZXNzAAIBcQABAAAAGwAAAAHHiIHjn5XJ2Ln4BU9djMgK4qLQZvgABBU4pAAe
AHQAAQAAABIAAABCbHVlWiBkZXZlbG9wbWVudAAAAB4AGgwBAAAAEQAAAEZyZWRlcmljIERhbGxl
YXUAAAAAHgAdDgEAAAA4AAAAUkUgOiBbQmx1ZXotZGV2ZWxdIFBsdWd6LCBhMmRwZCwgYW5kIGEy
ZHBkMiBzdHJhbmdlbmVzcwACAQkQAQAAAAQFAAAABQAAJggAAExaRnUTA64ZAwAKAHJjcGcxMjXi
MgNDdGV4BUEBAwH3TwqAAqQD4wIAY2gKwHPwZXQwIAcTAoAP8wBQfwRWCFUHshHFDlEDARDHMvcG
AAbDEcUzBEYQyRLbEdPbCO8J9zsYvw4wNRHCDGDOYwBQCwkBZDM2EVALpsAgQnJhZCwKogqAYD4g
SSBnClAEEWiUZSAEACABkGxrC4A8ZyABoAhgBUARIG5krR+CcwhgIEAgA1IgC1AsdWcLgB8hbx+w
bHMeYR8AAIAOsB2wIG9mvCBiBUEd9QnwAaBsIpCLIhEYwWkYwGN0PRuTcwqECoBDaAUQELAd9WgA
Y2lkdW1wIC2KWCbwViAQaG93BCB6biHgdB2gASAN4COgeBRjZQUxYgiBZmx5bCB3HuADoHQncBEg
IIsQ4CSAcAQgb2NjCHD+Lh3kHmAgwQSQInAAcCDg5nkIYB7QYXYe8CCkKbDrA2AhcGgh9GIf8SfA
BUDhLQcyZHAsH7Ag0QIgeykxKoFhAJACIAdAKgU/fR3kVxDwBUAe4B2wESEvHR2wYQUwEyEfEWl0
P3wgRCagLAMrsQAgJndiLwEQBbAe8C7SZDDVTWFeayyBCHAe8CHRdSnhNAA0MTAwaHogMXw2YjLA
BCAiICbQI/BzHSrXbgngLOIe8GZ1bN8DIDTTJvAfoB/hcB/xBbF3I7QBAC3QZyTQIkEuw3L3KFAh
0R7gbCbgBGAYwCrVwlUp4XBjbV85dAaQmzKxHnBpLHAEIGdvBHD2IBjANeBsLjkiESrVHeTeRhjB
BnEA4CUJLUKFBdBJHqFhZx7wZCcFsGmNIYFlQoYd5ERlOiLwmQpBei0BACxwbC0f0WJuKJBzQGwE
ADdgLu8goTvwNHJDYC44kAVAAQD+IAtgIUAzokfhHZIF0Cagemcj8HlEpTFgRREscG4ALiAyNy8w
NC8BAdAwNyAwNjowoxXQJQQnYzBFIEIKQeZaR9FFwW9wB4ACMB3kWE9iakexRSBSRRFbo0xSRYVd
IFAhYXovEf804i8UNNMU4CJwHaAfkAnw3x6hHeQjJSW5HeZXMsAtYK89lxTgHmAsU2omwXkvEKUs
cHIpQHNwOLF1JuD3IKk44jGScCdwUWEvIx3m/zfBAjAvoSLgJ/YtBiaFSnD+QSISJFYglFfRH9M4
4jeR/x7wHeYv8Fb9LxAt0jjiMiD+ZQRgA6A+lDjjBvAYUAPwLx+RBJADYBEQOiT6SSf/ITAuEmBo
LBMEkDzQU5AxUX4nXbQgUAEgY6FGMTRRdP53CeE2UR+BHeRT+SvSOOJ2IiIDJFYiMuAeYCBQZOxu
JwVAL+B0EOApUTFh3iJc012kHeRXSCIpUF2h3xjAZNEFEB+RIdFlU7EEkP9Aex2SJPpBz3AvcT9y
T3Nf7R3kVCogBkFGR5NfcAtw/wMgHxFV0AIgIKAYwSLwKUBkREIU4EV4O+BRd0T7J4AvgG8ioXb5
EsAm8DjT8EZSRUVVcjACIsJ28v8OwHj0ZzM1oR3kBaACMANgjwMgItEsEQXAWE1MSnC2TiHgRoBt
N1FKcEo2YJ9HwTFgQGASwEaAY2shwq9DYAVAPmEnwHcq1WgCQNBwOi8vRu0vdjBlgARyYgrAL2Ri
Mi/9HeRfg2+Ef4VKbcVFWDyQ/3WxH4JGgoZfRn9Hg4BoYVB/gRCJX4Hji4OLcwuAAhAvC0VJJPp9
j1AeADUQAQAAAEgAAAA8Q0U1MjE2QzEwQzgzOTQ0RDlGRDM3QjY1Q0QzM0YzOTcwQ0Y0Q0RAbXBs
ZXgwMS5tcGwuYWNjZXNzLWNvbXBhbnkuY29tPgAeADkQAQAAADwAAAA8NDYzMTUxRDIuMTA0MDgw
NUBqbGFiLm9yZz4gPDQ2MzE3NjJCLjkwNjA3MDRAeG1pc3Npb24uY29tPgAeAEcQAQAAAA8AAABt
ZXNzYWdlL3JmYzgyMgAACwDyEAEAAAAfAPMQAQAAAHwAAABSAEUAIAAlADMAQQAgAFsAQgBsAHUA
ZQB6AC0AZABlAHYAZQBsAF0AIABQAGwAdQBnAHoALAAgAGEAMgBkAHAAZAAsACAAYQBuAGQAIABh
ADIAZABwAGQAMgAgAHMAdAByAGEAbgBnAGUAbgBlAHMAcwAuAEUATQBMAAAACwD2EAAAAABAAAcw
8Q2AOJKIxwFAAAgwEGrH45OIxwEDAN4/r28AAAMA8T8MBAAAHgD4PwEAAAARAAAARnJlZGVyaWMg
RGFsbGVhdQAAAAACAfk/AQAAAF8AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089QUND
RVNTLUNPTVBBTlkvT1U9TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxM
RUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA
3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAA
AAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZS
RURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5z
b3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5jb20AAAAeADhA
AQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAA
AAAACwAjAAAAAAADAAYQP5ZVPAMABxD7BAAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEJS
QUQsSUdVRVNTSEVJU1RBTEtJTkdBQk9VVFNFTkRJTkdTT1VOREZST01QTFVHSU5TVE9BTFNBSU5T
VEVBRE9GQlRFTkFCTEVBTFNBUkVESVJFQ1Q9MUNIUklTSENJRFVNUC0AAAAAAgF/AAEAAABIAAAA
PENFNTIxNkMxMEM4Mzk0NEQ5RkQzN0I2NUNEMzNGMzk3MENGNENEQG1wbGV4MDEubXBsLmFjY2Vz
cy1jb21wYW55LmNvbT4Aiag=

------_=_NextPart_001_01C78893.E3BDE0AC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C78893.E3BDE0AC
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C78893.E3BDE0AC--
