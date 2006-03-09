Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C6431D.514A84F8"
Subject: RE: [Bluez-users] ISSC USB dongle can't ping with size 1000
Message-ID: <E64BAD5A8AD46740828069A678D9DD73011B1A@netbe01.net.unimis>
From: "Al" <Al_chane@issc.com.tw>
To: <bluez-users@lists.sourceforge.net>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 9 Mar 2006 10:01:02 +0800

This is a multi-part message in MIME format.

------_=_NextPart_001_01C6431D.514A84F8
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi, Marcel:

     I think the problem may not be the buffer size (678) that ISSC =
device
has. When I ping with size 1400 bytes, hcidump shows host breaks 1400 =
bytes
into serveal 678 byte packets and sends them to device. Both ping =
request and ping reply from the other side can be captured in air.

     Most likely the problem is occured when ISSC device trys to send
packets with large size to host. From the hcidump, I observe that if =
devices
like CSR receiving packets with size 1400, it breaks 1400 into serveral =
300 (something) packets and sends to host. On the other hand, when ISSC =
device receives packet with size 900, it sends 900 byte packet to host =
without breaking. But when the size is more than 1000, hcidump shows =
ISSC device does not send any packet to host.

     I have tried to send HCI_Host_Buffer_Size for ALC link (300 byte =
for example) to ISSC device:

-------------------------------------------------------------------------=
----------------------------
   int dd =3D hci_open_dev(di.dev_id);
   host_buffer_size_cp cp;
   struct hci_request rq;

   memset(&rq, 0, sizeof(rq));

   rq.ogf    =3D OGF_HOST_CTL;

   rq.ocf    =3D OCF_HOST_BUFFER_SIZE;

        cp.acl_mtu =3D 300;
        cp.sco_mtu =3D 30;
        cp.acl_max_pkt =3D 5;
        cp.sco_max_pkt =3D 5;
        rq.rparam =3D &cp;
        rq.rlen   =3D HOST_BUFFER_SIZE_CP_SIZE;

  if (hci_send_req(dd, &rq, 1000) < 0)
                return -1;

  hci_close_dev(dd);

   return 0;

--------------------------------------------------------

         After sending HCI_Host_Buffer_Size command, hcidump shows ISSC
device sends max size of 256 byte to host. Ping with 1500 bytes and =
Internet
access work  so far. I only try this with PAN to implement NAP.

Best Regards,

Al=20


-----Original Message-----
From:	bluez-users-admin@lists.sourceforge.net =A5N=B2z Marcel Holtmann
Sent:	2006/2/23 [=ACP=B4=C1=A5|] =A4U=A4=C8 07:23
To:	bluez-users@lists.sourceforge.net
Cc:=09
Subject:	Re: [Bluez-users] ISSC USB dongle can't ping with size 1000
Hi Al,

> >     I have the same problem as below which was posted last month.
> >=20
> > >   I started to play with the ping size. 'ping -s 900' works, 'ping =
-s 1000'
> > > kills the PAN connection. There was hope! Then I played with MTU =
(on both
> > > sides): 'ifconfig bnep0 mtu 1000' solves all my problems (default =
is
> > > 1500)!!! With this setting I've a rock solid 75 kByte/s transfer =
rate over
> > > ftp. A mtu of 1017 still works, 1018 definitely kills the =
connection.=20
> >=20
> >      I wonder if there is other solutions to this problem cause the =
above solution needs to set MTU to 1000 on both sides.=20
> >=20
> >      I try ISSC dongle with IVT software as NAP on Windows XP. Ping =
with size
> > 1500 works fine. It seems ISSC chip has some problems to work with =
BlueZ, in
> > addition to adding HCI_RESET.
>=20
> I am pretty sure that your chip is at fault here. I have no internals
> about your chip, but whatever buffer size you tell us, we will use. =
And
> BlueZ will use it as fast as possible. The latency is very low and the
> HCI flow control works fine. So I assume there exists a race condition
> in your side of the HCI flow control implementation which triggers a
> problem. You can verify with hcidump that we do everything right. The
> faulty application is actually not BNEP here. I think you can =
reproduce
> it with any program sending big L2CAP packets. So a test setup with
> l2test and different MTU might trigger it more easily.

and I just did a quick search through the mailing list archive and
actually I found these four version:

ACL MTU: 678:12  SCO MTU: 48:5   LMP Ver: 1.1  LMP Subver: 0x172
ACL MTU: 678:8   SCO MTU: 48:5   LMP Ver: 1.1  LMP Subver: 0x1a4
ACL MTU: 678:8   SCO MTU: 48:10  LMP Ver: 1.2  LMP Subver: 0x1ae
ACL MTU: 678:8   SCO MTU: 48:10  LMP Ver: 1.2  LMP Subver: 0x1f4

The LMP Subver must somehow decode into the version number of your
firmware, but I have no idea how. However you see the different ACL MTU
sizes the chip offers and BlueZ is simply using them.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting =
language
that extends applications into web and mobile media. Attend the live =
webcast
and join the prime developer group breaking into this new coding =
territory!
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=3D=
121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users




------_=_NextPart_001_01C6431D.514A84F8
Content-Type: application/ms-tnef;
	name="winmail.dat"
Content-Transfer-Encoding: base64

eJ8+IgQCAQaQCAAEAAAAAAABAAEAAQeQBgAIAAAAtgMAAAAAAAC5AAEIgAcAGAAAAElQTS5NaWNy
b3NvZnQgTWFpbC5Ob3RlADEIAQ2ABAACAAAAAgACAAEEgAEAPAAAAFJFOiBbQmx1ZXotdXNlcnNd
IElTU0MgVVNCIGRvbmdsZSBjYW4ndCBwaW5nIHdpdGggc2l6ZSAxMDAwAFITAQWAAwAOAAAA1gcD
AAkACgABAAIABAD6AAEggAMADgAAANYHAwAJAAoAAQACAAQA+gABCYABACEAAABCNUQwNzlGQTcy
MjFFMDRBOUU4MUE3OUU5QTlCMEMzQgBSBwEDkAYAjBIAADkAAAADACYAAAAAAAMANgAAAAAAQAA5
APiESlEdQ8YBHgA9AAEAAAAFAAAAUkU6IAAAAAACAUcAAQAAAC8AAABjPXVzO2E9IDtwPXVuaW1p
cztsPU5FVEJFMDEtMDYwMzA5MDIwMTAyWi04OTUwAAAeAEkAAQAAADwAAABSZTogW0JsdWV6LXVz
ZXJzXSBJU1NDIFVTQiBkb25nbGUgY2FuJ3QgcGluZyB3aXRoIHNpemUgMTAwMABAAE4AABlwl2s4
xgEeAFoAAQAAACgAAABibHVlei11c2Vycy1hZG1pbkBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQAAgFb
AAEAAABtAAAAAAAAAIErH6S+oxAZnW4A3QEPVAIAAAAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMu
c291cmNlZm9yZ2UubmV0AFNNVFAAYmx1ZXotdXNlcnMtYWRtaW5AbGlzdHMuc291cmNlZm9yZ2Uu
bmV0AAAAAAIBXAABAAAALQAAAFNNVFA6QkxVRVotVVNFUlMtQURNSU5ATElTVFMuU09VUkNFRk9S
R0UuTkVUAAAAAB4AXQABAAAAEAAAAE1hcmNlbCBIb2x0bWFubgACAV4AAQAAAEEAAAAAAAAAgSsf
pL6jEBmdbgDdAQ9UAgAAAABNYXJjZWwgSG9sdG1hbm4AU01UUABtYXJjZWxAaG9sdG1hbm4ub3Jn
AAAAAAIBXwABAAAAGQAAAFNNVFA6TUFSQ0VMQEhPTFRNQU5OLk9SRwAAAAAeAGYAAQAAAAUAAABT
TVRQAAAAAB4AZwABAAAAKAAAAGJsdWV6LXVzZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5l
dAAeAGgAAQAAAAUAAABTTVRQAAAAAB4AaQABAAAAFAAAAG1hcmNlbEBob2x0bWFubi5vcmcAHgBw
AAEAAAA4AAAAW0JsdWV6LXVzZXJzXSBJU1NDIFVTQiBkb25nbGUgY2FuJ3QgcGluZyB3aXRoIHNp
emUgMTAwMAACAXEAAQAAABsAAAABxjhrw3hJLjl9CLlCUqP2blc9VRt/AqxiByAAHgB0AAEAAAAi
AAAAYmx1ZXotdXNlcnNAbGlzdHMuc291cmNlZm9yZ2UubmV0AAAAHgAaDAEAAAADAAAAQWwAAB4A
HQ4BAAAAOAAAAFtCbHVlei11c2Vyc10gSVNTQyBVU0IgZG9uZ2xlIGNhbid0IHBpbmcgd2l0aCBz
aXplIDEwMDAAAgEJEAEAAAASCwAADgsAAC0VAABMWkZ1a3K9HYMACgByY3BnOTUC0fEDYXRleAVB
AQMB9wqAJwKkA+MCAGNoCsBzZTB0MTM2BdALgGdMfGl1AoAP4wBQBFYRjDK7AuMQtzIGAAbDEfUz
BEb5ELcwIAhVB7ICgBIDCO/FCfc7GK8yNTUR8gxgfmMAUAsJAWQRUBbgC6YgGEhpLAXQCsBjZWwu
OgqiCoQKgCAe8kkgFHRoC4BrH1FlIHAjA2ACYGVtIADAeSA0bm8FQGIf4B/CYnUXASAXUQCQeh/g
KDY3FDgpH1FhBUBJU1PUQyABAHYN4GUeNBDgcHMuIFcf0AOgH0BwHRGRIAPwH2Ah1DE0MCkW4GJ5
DqBzHaBoYyBpZHVtcCHQaG82dwQgJvBzIOEYsGFrzwQgJageNAuAdG8h0ASQfnYnsAMgIkEl4x/w
ANBr9xEgBCAAcGQpQSrwBCAfwe8gYCkhIzQkIEIg0CUwJLP9GLBxClAnYSriLNULUCCgnwNSH7Ms
kSGzAQAgYwOR3yEBL9AFMAhwCYAgC4Aq0Chpci4eP00nUmxpnyqQLmEfygQALxBjYzCDznckUyL4
H1ByeSthKTKfKvAxRCpmJQMLYHJnH+DvIeMpISdCJCBGLqYmZR2g/x9AICApUyKEBpAjJSiVMqLZ
FvBTUi0RHfBpI1Ak0b82uyVXHaAlECeLKQhyKaFyMyXBKHMDcBEgH3Fn9yJwKm84KE8DoC7oEOAq
8L8doDSPPGQHkUFUJPk5PkX/KyRG4SoKOCYk8whgJ3URkf8sYUmRRDMfwiHjM9EEYBiweyKCA6Ax
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
TUE68YrAL6E/c7ByF5VOkH8A0DAQ7RCOMefifYTA0HL+bdsi7ETpqcygn5BNQf8w/6Ag7sDs8u3y
35GwYw3oGNX/fYStcs2V4FJnAMjBQbTwRP/F8pUC2XCcgNzisHH/IIdK/5b1h0qftJhvmL87vzzP
Pd/DKlbRYVNGLk5GEf8QfxQBNfPyENJgS8H0UI6gIPB4UE1M7ECfkAlwFpLrScatYGP/8HDGU7Mg
rCD/BSCasH2EARNVwPMR1VEECf/4YCzj7sCcAJDSs3AKQKxB+7DQYEBhyoHGQE7ysHIUIJ+wQUZR
BFAR0BD4am/6Af+2w//wsNFW0bHBvQDtEEHy/wDwQlcs5dFh3yD1kokjiLF3//DVgAHwIX2EAqDK
YDq+L8hA7kBuYJzAnIAukvAcbGuaoJ5STvI/Y21oZD1sBsAmuqBQsDFh1mA5NDQmCkBQsDJiNByh
MCZk6LBRQDLoMTY0HMVfU39Uj1Vaf5ZFnDgT61Zvpu+n+U6Sc39O0VlvUANbk1uD4vCeAC8TnCk6
bwp9X8AAAB4ANRABAAAAPAAAADxFNjRCQUQ1QThBRDQ2NzQwODI4MDY5QTY3OEQ5REQ3MzAxMUIx
QUBuZXRiZTAxLm5ldC51bmltaXM+AB4ARxABAAAADwAAAG1lc3NhZ2UvcmZjODIyAAALAPIQAQAA
AB8A8xABAAAAhAAAAFIARQAlADMAQQAgAFsAQgBsAHUAZQB6AC0AdQBzAGUAcgBzAF0AIABJAFMA
UwBDACAAVQBTAEIAIABkAG8AbgBnAGwAZQAgAGMAYQBuACcAdAAgAHAAaQBuAGcAIAB3AGkAdABo
ACAAcwBpAHoAZQAgADEAMAAwADAALgBFAE0ATAAAAAsA9BAAAAAACwD1EAAAAAALAPYQAAAAAEAA
BzAKDZVLHUPGAUAACDBWg2lRHUPGAQMA3j+2AwAAAwDxPwQEAAAeAPg/AQAAAAMAAABBbAAAAgH5
PwEAAABdAAAAAAAAANynQMjAQhAatLkIACsv4YIBAAAAAAAAAC9PPVVOSU1JUy9PVT1GSVJTVCBB
RE1JTklTVFJBVElWRSBHUk9VUC9DTj1SRUNJUElFTlRTL0NOPUFMLklTU0MAAAAAHgD6PwEAAAAV
AAAAU3lzdGVtIEFkbWluaXN0cmF0b3IAAAAAAgH7PwEAAAAeAAAAAAAAANynQMjAQhAatLkIACsv
4YIBAAAAAAAAAC4AAAADAP0/tgMAAAMAGUAAAAAAAwAaQAAAAAADAB1AAAAAAAMAHkAAAAAAHgAw
QAEAAAAIAAAAQUwuSVNTQwAeADFAAQAAAAgAAABBTC5JU1NDAB4AMkABAAAAKAAAAGJsdWV6LXVz
ZXJzLWFkbWluQGxpc3RzLnNvdXJjZWZvcmdlLm5ldAAeADNAAQAAABQAAABtYXJjZWxAaG9sdG1h
bm4ub3JnAB4AOEABAAAACAAAAEFMLklTU0MAHgA5QAEAAAACAAAALgAAAAsAKQAAAAAACwAjAAAA
AAADAAYQ3KZrxwMABxB4DQAAAwAQEAAAAAADABEQAAAAAB4ACBABAAAAZQAAAEhJLE1BUkNFTDpJ
VEhJTktUSEVQUk9CTEVNTUFZTk9UQkVUSEVCVUZGRVJTSVpFKDY3OClUSEFUSVNTQ0RFVklDRUhB
U1dIRU5JUElOR1dJVEhTSVpFMTQwMEJZVEVTLEhDSUQAAAAAAgF/AAEAAAA8AAAAPEU2NEJBRDVB
OEFENDY3NDA4MjgwNjlBNjc4RDlERDczMDExQjFBQG5ldGJlMDEubmV0LnVuaW1pcz4A+zc=

------_=_NextPart_001_01C6431D.514A84F8--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
