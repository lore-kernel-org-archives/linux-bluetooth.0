Return-Path: <bluez-users-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C69940.66551C00"
Date: Mon, 26 Jun 2006 17:48:50 +0100
Message-ID: <BED9D15F73EDDE48BF480604236A456001DE40F7@ex1.ad.dcs.gla.ac.uk>
References: <1151066205.6247.19.camel@addu><1151324247.7694.10.camel@localhost>
	<1151334192.29221.7.camel@addu>
	<1151336865.7694.37.camel@localhost>
From: "Stephen D. Strowes" <sds@dcs.gla.ac.uk>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] L2CAP MTU and packet fragmentation?
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

------_=_NextPart_001_01C69940.66551C00
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

> If you actually use L2CAP data channel with SOCK_SEQPACKET then you
> won't see a loss at all. It is a reliable channel.

Yeah, this is what I'm doing, but I'm seeing loss.

I'm following the code from =
http://people.csail.mit.edu/albert/bluez-intro/x556.html, but not =
fiddling with anything related to unreliability in section 4.3.2.

Trying the same between two different machines gets me the reliable data =
transfer.

Am I dealing with bad hardware here? Hardware with bad drivers (I'm =
dealing with Bluetooth built into a HP iPaq running Familiar Linux, =
kernel version 2.6.12)? Or an out of date bluez-utils =
(bluez-utils-nodbus package is version 2.14-r4)?


Cheers,
S.

------_=_NextPart_001_01C69940.66551C00
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IjMQAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAA5AQAAAAAAADoAAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEANgAAAFJFOiBbQmx1ZXotdXNlcnNd
IEwyQ0FQIE1UVSBhbmQgcGFja2V0IGZyYWdtZW50YXRpb24/AEsSAQWAAwAOAAAA1gcGABoAEQAw
ADIAAQBxAQEggAMADgAAANYHBgAaABEAMAAyAAEAcQEBCYABACEAAAA4MkRCNTYzNTQ1MDM4OTQw
ODIzMDU0NjFGRDdGQUJEQQAQBwEDkAYAvAoAADkAAAADACYAAAAAAAMANgAAAAAAQAA5AAAcVWZA
mcYBHgA9AAEAAAAFAAAAUkU6IAAAAAACAUcAAQAAACgAAABjPUdCO2E9IDtwPURDUztsPUVYMS0w
NjA2MjYxNjQ4NTBaLTI5ODIAHgBJAAEAAAA2AAAAUmU6IFtCbHVlei11c2Vyc10gTDJDQVAgTVRV
IGFuZCBwYWNrZXQgZnJhZ21lbnRhdGlvbj8AAABAAE4AgKbL3TeZxgEeAFoAAQAAACoAAABibHVl
ei11c2Vycy1ib3VuY2VzQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAAAAIBWwABAAAAcQAAAAAAAACB
Kx+kvqMQGZ1uAN0BD1QCAAAAAGJsdWV6LXVzZXJzLWJvdW5jZXNAbGlzdHMuc291cmNlZm9yZ2Uu
bmV0AFNNVFAAYmx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAAAgFc
AAEAAAAvAAAAU01UUDpCTFVFWi1VU0VSUy1CT1VOQ0VTQExJU1RTLlNPVVJDRUZPUkdFLk5FVAAA
HgBdAAEAAAAQAAAATWFyY2VsIEhvbHRtYW5uAAIBXgABAAAAQQAAAAAAAACBKx+kvqMQGZ1uAN0B
D1QCAAAAAE1hcmNlbCBIb2x0bWFubgBTTVRQAG1hcmNlbEBob2x0bWFubi5vcmcAAAAAAgFfAAEA
AAAZAAAAU01UUDpNQVJDRUxASE9MVE1BTk4uT1JHAAAAAB4AZgABAAAABQAAAFNNVFAAAAAAHgBn
AAEAAAAqAAAAYmx1ZXotdXNlcnMtYm91bmNlc0BsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAAAeAGgA
AQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFAAAAG1hcmNlbEBob2x0bWFubi5vcmcAHgBwAAEAAAAy
AAAAW0JsdWV6LXVzZXJzXSBMMkNBUCBNVFUgYW5kIHBhY2tldCBmcmFnbWVudGF0aW9uPwAAAAIB
cQABAAAAGwAAAAHGmTfoE7cKj4i+FEQMoDZ6NgbAlM8AAacrgAAeAHQAAQAAAAwAAABCbHVlWiB1
c2VycwAeABoMAQAAABMAAABTdGVwaGVuIEQuIFN0cm93ZXMAAB4AHQ4BAAAAMgAAAFtCbHVlei11
c2Vyc10gTDJDQVAgTVRVIGFuZCBwYWNrZXQgZnJhZ21lbnRhdGlvbj8AAAACAQkQAQAAAMICAAC+
AgAA9wMAAExaRnUi7UbFAwAKAHJjcGcxMjXiMgNDdGV4BUEBAwH3/wqAAqQD5AcTAoAP8wBQBFY/
CFUHshElDlEDAQIAY2jhCsBzZXQyBgAGwxEl9jMERhO3MBIsETMI7wn3tjsYHw4wNREiDGBjAFAz
CwkBZDM2FlALpiBIHGksCqIKhAqAPiBJKGYgeQhgIADQdHUhB0BseSB1FBAgTIAyQ0FQIGRhAZBi
IBPRbm5lAyAD8HQCaAYAT0NLX1NFiFFQQSDgRVQgIJDXCfAeIh2GdwIgJwVAFBB/HyAf0BewBBEf
sB5gHsAu3x3wBUAEACNBGCBsBzACYAsfIB/1Lh0qWWVhaG4sIaEkcSRxdxPgBUBJVCdtH5BvC4Bn
JtBi/nUnpCMRKCEjYyXLJ8ICEP0ewG8D8CkxIbEf4ARxKqAJA2EgaAJAcDovLwhwZW8LUGUuY3Mr
C3AkEG0ggC4JgHUvJQdAYgSQdC8KMnotJQuAdANgL3gaYDYuSSwwbWwoVG5vBUBmeGlkZCTgKTEg
cwBweb8m8SkxJMEfsAmAIaBvHvD+biTEAxAggB7gC4AjAR6AAmkCICA0LjMuMvEly1RyeSsWLSAH
gChgfRQgdwnhIaAisB+QBpBmvwSQCfAFQADBMXEHkWcUIP8EIDXxK1Ikxx+jLuAAcTcRdSXLQSfg
SR+QJqAwmGLmYTIgE+FkdwrAHyAhwF0YID8c4Dx2O9dkBRB22wSQBCAoJ8M7akIKQTJA+zAgPAF1
AxAkUQIwMlAf0MJIH4BpUGFxJLAycLsDACkxRjXgMvEKwUwLgPR1eCbQawSRIEE+ojPC1zRAL1AO
ICk9ME8FwAOR+whgBUBvHhAfoTYBLnMogNcDED7RRiktMBBkKHAEIHEKsGNrYTgQJGJD+DFwNC1y
NETQHSodJENXIcA+sR0VUyXFfUxgAAAeADUQAQAAAEAAAAA8QkVEOUQxNUY3M0VEREU0OEJGNDgw
NjA0MjM2QTQ1NjAwMURFNDBGN0BleDEuYWQuZGNzLmdsYS5hYy51az4AHgA5EAEAAACKAAAAPDEx
NTEwNjYyMDUuNjI0Ny4xOS5jYW1lbEBhZGR1PjwxMTUxMzI0MjQ3Ljc2OTQuMTAuY2FtZWxAbG9j
YWxob3N0PiAgPDExNTEzMzQxOTIuMjkyMjEuNy5jYW1lbEBhZGR1PiA8MTE1MTMzNjg2NS43Njk0
LjM3LmNhbWVsQGxvY2FsaG9zdD4AAAAeAEcQAQAAAA8AAABtZXNzYWdlL3JmYzgyMgAACwDyEAEA
AAAfAPMQAQAAAHwAAABSAEUAJQAzAEEAIABbAEIAbAB1AGUAegAtAHUAcwBlAHIAcwBdACAATAAy
AEMAQQBQACAATQBUAFUAIABhAG4AZAAgAHAAYQBjAGsAZQB0ACAAZgByAGEAZwBtAGUAbgB0AGEA
dABpAG8AbgAlADMARgAuAEUATQBMAAAACwD2EAAAAABAAAcwVqK/hD6ZxgFAAAgwCLhxZkCZxgED
AN4/r28AAAMA8T8JBAAAHgD4PwEAAAATAAAAU3RlcGhlbiBELiBTdHJvd2VzAAACAfk/AQAAAFYA
AAAAAAAA3KdAyMBCEBq0uQgAKy/hggEAAAAAAAAAL089RENTL09VPUZJUlNUIEFETUlOSVNUUkFU
SVZFIEdST1VQL0NOPVJFQ0lQSUVOVFMvQ049U0RTAAAAHgD6PwEAAAAVAAAAU3lzdGVtIEFkbWlu
aXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC4AAAAD
AP0/5AQAAAMAGUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAwQAEAAAAEAAAAU0RTAB4A
MUABAAAABAAAAFNEUwAeADJAAQAAACoAAABibHVlei11c2Vycy1ib3VuY2VzQGxpc3RzLnNvdXJj
ZWZvcmdlLm5ldAAAAB4AM0ABAAAAFAAAAG1hcmNlbEBob2x0bWFubi5vcmcAHgA4QAEAAAAEAAAA
U0RTAB4AOUABAAAAAgAAAC4AAAADAHZA/////wsAKQAAAAAACwAjAAAAAAADAAYQbBcBTgMABxAg
AgAAAwAQEAAAAAADABEQAQAAAB4ACBABAAAAZQAAAEhJLElGWU9VQUNUVUFMTFlVU0VMMkNBUERB
VEFDSEFOTkVMV0lUSFNPQ0tTRVFQQUNLRVRUSEVOWU9VV09OVFNFRUFMT1NTQVRBTExJVElTQVJF
TElBQkxFQ0hBTk5FTFlFQUgAAAAAAgF/AAEAAABAAAAAPEJFRDlEMTVGNzNFRERFNDhCRjQ4MDYw
NDIzNkE0NTYwMDFERTQwRjdAZXgxLmFkLmRjcy5nbGEuYWMudWs+APOp

------_=_NextPart_001_01C69940.66551C00
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
------_=_NextPart_001_01C69940.66551C00
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

------_=_NextPart_001_01C69940.66551C00--
