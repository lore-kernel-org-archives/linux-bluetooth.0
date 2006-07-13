Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C6A645.6A05514C"
Date: Thu, 13 Jul 2006 08:27:28 +0200
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE4E6E84@eumonex01.palmsource.com>
From: "Frederic Dalleau" <Frederic.Dalleau@palmsource.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] RE :  Alsa plugin for A2DP daemon
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

------_=_NextPart_001_01C6A645.6A05514C
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi brad,

> Do you have something in mind for routing audio to the speakers when =
the
> bluetooth headset is not available or if the user chooses to disable =
it?

I think it is possible to open alsa hw device. Alsa claims to be =
multithreaded...

> Is a2dpd starting the connection to the headset on demand? If you do =
go
> that route, make sure it holds the connection open for a few seconds
> after the last client closes it.

The connection is on demand.
There a minimal delay before closing the device, but it's not as long as =
a second, I will try to increase it.

> these ticks are the sound you usually get when packets are sent too
> quickly. so the audio using gxine has a bit of a delay and the pitches
> of everybody's voices are too low. seems like a straightforward timing
> issue.

For historical reasons ;) , timing is not done the same way between a2dp =
and a2dpd. I will try to restore it, but there are two timing to take =
into account : one is in the plugin, so if the daemon is not started, it =
prevent xmms become crasy and send all audio in one second. The other =
one in the daemon, to send data to the headset, and to keep multiple =
plugins in sync in order to mix audio.
In the end, there should be the same audio quality between the two =
plugins.

Fr=E9d=E9ric

------_=_NextPart_001_01C6A645.6A05514C
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+Ih0GAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEALwAAAFJFIDogW0JsdWV6LWRldmVs
XSBBbHNhIHBsdWdpbiBmb3IgQTJEUCBkYWVtb24Aeg8BBYADAA4AAADWBwcADQAIABsAHAAEADQB
ASCAAwAOAAAA1gcHAA0ACAAbABwABAA0AQEJgAEAIQAAADBCNUJFNkMyNThBRUMzNDA5QzY0MzM1
MEYyM0I3QkJEAEMHAQOQBgC0CwAAOAAAAAMAJgAAAAAAAwA2AAAAAABAADkATFEFakWmxgEeAD0A
AQAAAAEAAAAAAAAAAgFHAAEAAAA0AAAAYz11czthPSA7cD1QYWxtU291cmNlO2w9RVVNT05FWDAx
LTA2MDcxMzA2MjcyOFotMzI3AB4ASQABAAAALgAAAFJlOiBbQmx1ZXotZGV2ZWxdIEFsc2EgcGx1
Z2luIGZvciBBMkRQIGRhZW1vbgAAAEAATgAAozH1d6XGAR4AWgABAAAAKgAAAGJsdWV6LWRldmVs
LWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAAgFbAAEAAABxAAAAAAAAAIErH6S+oxAZ
nW4A3QEPVAIAAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAU01U
UABibHVlei1kZXZlbC1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAACAVwAAQAAAC8A
AABTTVRQOkJMVUVaLURFVkVMLUJPVU5DRVNATElTVFMuU09VUkNFRk9SR0UuTkVUAAAeAF0AAQAA
AA0AAABCcmFkIE1pZGdsZXkAAAAAAgFeAAEAAABAAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAA
QnJhZCBNaWRnbGV5AFNNVFAAYm1pZGdsZXlAeG1pc3Npb24uY29tAAIBXwABAAAAGwAAAFNNVFA6
Qk1JREdMRVlAWE1JU1NJT04uQ09NAAAeAGYAAQAAAAUAAABTTVRQAAAAAB4AZwABAAAAKgAAAGJs
dWV6LWRldmVsLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgBoAAEAAAAFAAAAU01U
UAAAAAAeAGkAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5jb20AAAAeAHAAAQAAAC8AAABSRSA6
IFtCbHVlei1kZXZlbF0gQWxzYSBwbHVnaW4gZm9yIEEyRFAgZGFlbW9uAAACAXEAAQAAABsAAAAB
xqV4AaviQYLT35ZNaqWsilLr2IreADKxJjcAHgB0AAEAAAASAAAAQmx1ZVogZGV2ZWxvcG1lbnQA
AAAeABoMAQAAABEAAABGcmVkZXJpYyBEYWxsZWF1AAAAAB4AHQ4BAAAALwAAAFJFIDogW0JsdWV6
LWRldmVsXSBBbHNhIHBsdWdpbiBmb3IgQTJEUCBkYWVtb24AAAIBCRABAAAAIwQAAB8EAAB7BgAA
TFpGdZ4kzEwDAAoAcmNwZzEyNeIyA0N0ZXgFQQEDAfdPCoACpAPjAgBjaArAc/BldDAgBxMCgA/z
AFB/BFYIVQeyEcUOUQMBEMcy9wYABsMRxTMERhDJEtsR09sI7wn3Oxi/DjA1EcIMYM5jAFALCQFk
MzYRUAumACBIaSBicmFkDiwKogqECoA+IERvFCB5CGAgEPB2ZSCWcwNwETBoC4BnIAuA5CBtC4Bk
IAIQBcADYIR1dCASYXVkaR8ACnQh0WgfkXBlYWv7BJAEIHciMAOgIiEedgoy3SHwbx/wH1AigGQR
ISBA7QQgbiRQIYB2C3ALYAJg7x+QBbEGkCITdREgBcAQ4F8kQBEgBCAh8SGwcyXTabR0Px4aSSIR
C4BrKDG9JQJwJ0AAkCXiIfFvInC/A6AHQCfgH1AH4AEAdg3grGUuEWArMmMLYW0nc+JiH5BtdWwh
QB/wGMBbHeAJgC4uEB4cSQQgYegyZHAgsHMBkAAgIBLzIiIFoG5uBZAhQAIgIebPJJYxAQEAA4Fk
Py8QJmBlHyJkHwBnbx52H/Bh8wVAIRJlLCBwIpEfoAhw/ygiH1AG8CTAMD4q0yDSK1C+ZgfRESAw
gSTAHnZhAYD/EyEiIgtgL7AsYQiQAjAsYfcnQyhALjtUMFwlETInLjX/O5E1QStQIIEHcAdAK5EL
YP55LQEg0TBhOkEwBiukNLD2YiEwKDEnJSUEIBhQIWJfLzE31TSwKTAD8GwDIHT+cj7wIfELgAUA
IoARIDqe7zPyB5AqgQ3gay8xNUEiI68IYCChHyImwHUHQGw+8P5nJOEi8wqwReARMEYEESDnOgEk
MR52cXVF0UeQLACfH7AiEyGUJsAgEmd4C4DrMYFCE2IpsW8mYCtQPrT7MoEiE3AoQBDgB5AedkzR
SyuwBJB5BuBkeUEhdt5vK9FGBSRAQbF3SoEJ4D8ssTnQNPFCQUNQC3BnaLsAMAWwdwsRRbEggWce
dvcEAQpQLjtGBbEgAC+wBbAfDeA+gUPyAiAEIDspIL80sFL0JQYzQEwBIiNhB4DzIuA+43R3CeEv
Q01zL1P/LABC7BjAVVIoIkCkIiE94v1GMnch0VbEIfI04guAIfHvANAFoEbABUA6MhEoITqB9yMj
KgAKQGcLgDSwSqEmVfxkYTJgPFQlQi+zCYA0sJ0psXAYwB+AOgF4bSyx/y0QBaBYQQUAOYBNZEkR
WaH/QyEhlCBRV6I35CwAO5IkUf8TIV7TX1Rg1FaRHwBkU2DQvwGQMS00sE2DHwAioGVZYP8tQwtQ
X5ZfI2PgQ9BlMwsgtzkCHwAggHghhC41SV9U92RhVpE9w3MnIC1QILAtEf9X5yGUShAHQChAWJgi
Ilyyg2slVCxyXCdlOQswF3OBVYEeFH10oAAeADUQAQAAAEIAAAA8N0E2REE1NDVEN0ZEQ0M0Qjkz
REI2NTFGREJDMUVEREU0RTZFODRAZXVtb25leDAxLnBhbG1zb3VyY2UuY29tPgAAAB4ARxABAAAA
DwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAAAB8A8xABAAAAagAAAFIARQAgACUAMwBBACAAWwBC
AGwAdQBlAHoALQBkAGUAdgBlAGwAXQAgAEEAbABzAGEAIABwAGwAdQBnAGkAbgAgAGYAbwByACAA
QQAyAEQAUAAgAGQAYQBlAG0AbwBuAC4ARQBNAEwAAAAAAAsA9hAAAAAAQAAHMLVJRMZCpsYBQAAI
MAk9EWpFpsYBAwDeP69vAAADAPE/DAQAAB4A+D8BAAAAEQAAAEZyZWRlcmljIERhbGxlYXUAAAAA
AgH5PwEAAABbAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVBBTE1TT1VSQ0UvT1U9
TU9OVFBFTExJRVIvQ049UkVDSVBJRU5UUy9DTj1GUkVERVJJQy5EQUxMRUFVAAAeAPo/AQAAABUA
AABTeXN0ZW0gQWRtaW5pc3RyYXRvcgAAAAACAfs/AQAAAB4AAAAAAAAA3KdAyMBCEBq0uQgAKy/h
ggEAAAAAAAAALgAAAAMA/T/kBAAAAwAZQAAAAAADABpAAAAAAAMAHUAAAAAAAwAeQAAAAAAeADBA
AQAAABEAAABGUkVERVJJQy5EQUxMRUFVAAAAAB4AMUABAAAAEQAAAEZSRURFUklDLkRBTExFQVUA
AAAAHgAyQAEAAAAqAAAAYmx1ZXotZGV2ZWwtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQA
AAAeADNAAQAAABYAAABibWlkZ2xleUB4bWlzc2lvbi5jb20AAAAeADhAAQAAABEAAABGUkVERVJJ
Qy5EQUxMRUFVAAAAAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQ
zPHxswMABxDfAwAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJQlJBRCxET1lPVUhBVkVT
T01FVEhJTkdJTk1JTkRGT1JST1VUSU5HQVVESU9UT1RIRVNQRUFLRVJTV0hFTlRIRUJMVUVUT09U
SEhFQURTRVRJU05PVEFWQUlMQUJMRU9SSUYAAAAAAgF/AAEAAABCAAAAPDdBNkRBNTQ1RDdGREND
NEI5M0RCNjUxRkRCQzFFRERFNEU2RTg0QGV1bW9uZXgwMS5wYWxtc291cmNlLmNvbT4AAAAsGQ==

------_=_NextPart_001_01C6A645.6A05514C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

------_=_NextPart_001_01C6A645.6A05514C
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C6A645.6A05514C--
