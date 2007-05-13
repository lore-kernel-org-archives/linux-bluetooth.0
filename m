Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C79520.A5A9519B"
Date: Sun, 13 May 2007 07:36:25 +0200
Message-ID: <CE5216C10C83944D9FD37B65CD33F3970CF4D4@mplex01.mpl.access-company.com>
References: <46465CE6.8090407@jlab.org>
From: "Frederic Dalleau" <Frederic.Dalleau@access-company.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  A2DP reconnections and scanning
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

------_=_NextPart_001_01C79520.A5A9519B
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable


> Everything seems to work as expected except that every four seconds =
A2DP=20
> gives the following error message, disconnects from the headphones,=20
> reconnects, and continues playing.
> a2dp_transfer_raw: Wrote -1 not 613 bytes (sbc.len=3D100)

What bitpool are you using? Try a smaller value.
Are you still using rate=3D32000?

> An earlier post at =
http://thread.gmane.org/gmane.linux.bluez.devel/10682=20
> seemed to describe this closely

I don't think it's a scanning: a scan takes can take longer than that.
Unfortunately, this sounds a2dpd only.

Frederic

------_=_NextPart_001_01C79520.A5A9519B
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IhoFAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAMwAAAFJFIDogW0JsdWV6LWRldmVs
XSBBMkRQIHJlY29ubmVjdGlvbnMgYW5kIHNjYW5uaW5nAI0RAQWAAwAOAAAA1wcFAA0ABwAkABkA
AAA0AQEggAMADgAAANcHBQANAAcAJAAZAAAANAEBCYABACEAAAAwNkEyQjYwRTFBOTU0NzQ3QUQ2
OEQxNTRBMjAyNDMwRgD/BgEDkAYARAoAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AJtRqaUglccB
HgA9AAEAAAABAAAAAAAAAAIBRwABAAAAOAAAAGM9VVM7YT0gO3A9QWNjZXNzLUNvbXBhbnk7bD1N
UExFWDAxLTA3MDUxMzA1MzYyNVotNDE2ODgAHgBJAAEAAAAuAAAAW0JsdWV6LWRldmVsXSBBMkRQ
IHJlY29ubmVjdGlvbnMgYW5kIHNjYW5uaW5nAAAAQABOAAC3a1v2lMcBHgBaAAEAAAAqAAAAYmx1
ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAACAVsAAQAAAHEAAAAAAAAA
gSsfpL6jEBmdbgDdAQ9UAgAAAABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdl
Lm5ldABTTVRQAGJsdWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAAIB
XAABAAAALwAAAFNNVFA6QkxVRVotREVWRUwtQk9VTkNFU0BMSVNUUy5TT1VSQ0VGT1JHRS5ORVQA
AB4AXQABAAAADQAAAENocmlzIENhcmxpbgAAAAACAV4AAQAAADoAAAAAAAAAgSsfpL6jEBmdbgDd
AQ9UAgAAAABDaHJpcyBDYXJsaW4AU01UUABjYXJsaW5AamxhYi5vcmcAAAACAV8AAQAAABUAAABT
TVRQOkNBUkxJTkBKTEFCLk9SRwAAAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKgAAAGJs
dWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgBoAAEAAAAFAAAAU01U
UAAAAAAeAGkAAQAAABAAAABjYXJsaW5AamxhYi5vcmcAHgBwAAEAAAAzAAAAUkUgOiBbQmx1ZXot
ZGV2ZWxdIEEyRFAgcmVjb25uZWN0aW9ucyBhbmQgc2Nhbm5pbmcAAAIBcQABAAAAGwAAAAHHlPZi
Oqm8BDbbhkCQl42RlHdFMWcACien8QAeAHQAAQAAABIAAABCbHVlWiBkZXZlbG9wbWVudAAAAB4A
GgwBAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAAHgAdDgEAAAAzAAAAUkUgOiBbQmx1ZXotZGV2
ZWxdIEEyRFAgcmVjb25uZWN0aW9ucyBhbmQgc2Nhbm5pbmcAAAIBCRABAAAAgwIAAH8CAAB+AwAA
TFpGdbAloOUDAAoAcmNwZzEyNeIyA0N0ZXgFQQEDAff/CoACpAPkBxMCgA/zAFAEVj8IVQeyESUO
UQMBAgBjaOEKwHNldDIGAAbDESX2MwRGE7cwEiwRMwjvCfe2OxgfDjA1ESIMYGMAUPMLCQFkMzYW
UAumCuMKgBA+IEV2BJB5dGhJC4BnIBQQZW0EIHSIbyB3BbBrIGEEIC0OwHAFkA6wZB8hY2WrBTEd
wGEFQGUdgiACECcIcB4RBaBuZBCxMkQyUBznZ2kdgB5haGX9INFsF7AD8B3xBJADYAXAAQeBc2Fn
ZSwgZPsEACFRbh9hBCADUiLTIvDwYWRwaAIgB5AkkBz2vxggJOYkkABwH6AhUXQLgFcKUAQgC1F5
HeEuHPZhojImMF90cgBxZgSQwl8qQHc6IFcDYA6wICAtMSBuKzAgNjAxMyBiHbAHkShzEGJjLmwJ
8D0xMCwwKRz0HPRXIEJiaTh0cG8G8B7wGCAgeRkIYCB1AJAd8D8gVL0gsWEeEADAI0ASgXYHQO8K
UClVBxAvBHMocCNAL1RjJzAgUGU9MwHQLSA/my1aHVBBA6AmEHJsEnIvLpAx8B7wBUBoAkBwOpwv
Lx3AGCAmIC5nA4FzMPAFsGcvNlQ0oCiQeDIuCjJ6LgEAHYBsL/ktEDY4FEAc9h4iH5EegbsBAATy
YiMAHcEEIGMXsGkUEGx5LVpJJKACICdvIBILgB7gLnAnBCAwEWM/AHADAB3wKvA9NB5wYWv7B5E+
JiAXsB3wEoEgMT5BMyBBKVVVbgIQACB1bu8ywTsgJJA6g3MIYCFyKeLfH6ACIDsgKVUc9EYYIQZx
CwDgHQN9RNAAHgA1EAEAAABIAAAAPENFNTIxNkMxMEM4Mzk0NEQ5RkQzN0I2NUNEMzNGMzk3MENG
NEQ0QG1wbGV4MDEubXBsLmFjY2Vzcy1jb21wYW55LmNvbT4AHgA5EAEAAAAcAAAAPDQ2NDY1Q0U2
LjgwOTA0MDdAamxhYi5vcmc+AB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A
8xABAAAAcgAAAFIARQAgACUAMwBBACAAWwBCAGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAEEAMgBE
AFAAIAByAGUAYwBvAG4AbgBlAGMAdABpAG8AbgBzACAAYQBuAGQAIABzAGMAYQBuAG4AaQBuAGcA
LgBFAE0ATAAAAAAACwD2EAAAAABAAAcwaTDWAB+VxwFAAAgw/9qypSCVxwEDAN4/r28AAAMA8T8M
BAAAHgD4PwEAAAARAAAARnJlZGVyaWMgRGFsbGVhdQAAAAACAfk/AQAAAF8AAAAAAAAA3KdAyMBC
EBq0uQgAKy/hggEAAAAAAAAAL089QUNDRVNTLUNPTVBBTlkvT1U9TU9OVFBFTExJRVIvQ049UkVD
SVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUAAABTeXN0ZW0gQWRtaW5pc3Ry
YXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAALgAAAAMA/T/k
BAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBAAQAAABEAAABGUkVERVJJQy5E
QUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUAAAAAHgAyQAEAAAAqAAAAYmx1
ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeADNAAQAAABAAAABjYXJs
aW5AamxhYi5vcmcAHgA4QAEAAAARAAAARlJFREVSSUMuREFMTEVBVQAAAAAeADlAAQAAAAIAAAAu
AAAAAwB2QP////8LACkAAAAAAAsAIwAAAAAAAwAGEBm0LI0DAAcQvwEAAAMAEBABAAAAAwAREAAA
AAAeAAgQAQAAAGUAAABFVkVSWVRISU5HU0VFTVNUT1dPUktBU0VYUEVDVEVERVhDRVBUVEhBVEVW
RVJZRk9VUlNFQ09ORFNBMkRQR0lWRVNUSEVGT0xMT1dJTkdFUlJPUk1FU1NBR0UsRElTQ09OTkVD
AAAAAAIBfwABAAAASAAAADxDRTUyMTZDMTBDODM5NDREOUZEMzdCNjVDRDMzRjM5NzBDRjRENEBt
cGxleDAxLm1wbC5hY2Nlc3MtY29tcGFueS5jb20+AE6G

------_=_NextPart_001_01C79520.A5A9519B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
------_=_NextPart_001_01C79520.A5A9519B
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C79520.A5A9519B--
