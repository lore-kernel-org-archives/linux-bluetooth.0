Return-Path: <cyrus@holtmann.org>
Date: Fri, 9 Jan 2009 12:50:18 +0100
From: Steffen Pankratz <kratz00@gmx.de>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: hci_usb problem after rmmod/modprobe
Message-ID: <20090109125018.74e43c96@hermes>
In-Reply-To: <1230800341.4530.4.camel@californication>
References: <20081230211526.5136a798@hermes>
 <1230668540.30789.1.camel@californication>
 <20081231104354.1bf8f381@hermes>
 <1230800341.4530.4.camel@californication>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tZs9ym6=dIDKB27nuMFLExf";
 protocol="application/pgp-signature"; micalg=PGP-SHA1
List-ID: <linux-bluetooth.vger.kernel.org>

--Sig_/tZs9ym6=dIDKB27nuMFLExf
Content-Type: multipart/mixed; boundary="MP_/hj.bCnO9Z.MooCviEY1c7lE"

--MP_/hj.bCnO9Z.MooCviEY1c7lE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, 01 Jan 2009 09:59:01 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi Steffen,
>=20
> > > > everything is fine until I unload and reload hci_usb:
> > > >=20
> > > > hciconfig hci0 up
> > > > Can't init device hci0: Input/output error (5)
> > > >=20
> > > > from dmesg:
> > > > hci_usb_intr_rx_submit: hci0 intr rx submit failed urb f406cf54 err=
 -2
> > > >=20
> > > > I tried 'modprobe hci_usb reset=3D1' which did not solve the proble=
m.
> > > >=20
> > > > To get it working again I have to do:
> > > >=20
> > > > rmmod hci_usb bluetooth uhci_hcd
> > > > modprobe uhci_hcd
> > > > modprobe hci_usb
> > > >=20
> > > > Not sure what information could be helpful:
> > > >=20
> > > > Linux hermes 2.6.28 #2 PREEMPT Tue Dec 30 16:30:47 CET 2008 i686 i6=
86
> > > > i386 GNU/Linux
> > >=20
> > > if you are using 2.6.28 kernel, then just use the btusb driver instead
> > > of hci_usb. The hci_usb will be removed with 2.6.29 anyway.
> >=20
> > thanks for your suggestion.
> > I am now using the btusb driver but the problem remains,
> > except the kernel message has changed:
> >=20
> > btusb_submit_intr_urb: hci0 urb f61e37c0 submission failed (2)
>=20
> run "hcidump -X -V" and see what is going on and what exactly fails.

Hi,

this topic is gotten quiet,
is there anything else I can do to help?


Regards
-Steffen

--=20
Hermes powered by LFS SVN-20070420 (Linux 2.6.28)

Best regards, Steffen Pankratz.

--MP_/hj.bCnO9Z.MooCviEY1c7lE
Content-Type: application/octet-stream; name=log
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=log

SENJIHNuaWZmZXIgLSBCbHVldG9vdGggcGFja2V0IGFuYWx5emVyIHZlciAxLjQyCmRldmljZTog
aGNpMCBzbmFwX2xlbjogMTAyOCBmaWx0ZXI6IDB4ZmZmZmZmZmYKPCBIQ0kgQ29tbWFuZDogUmVz
ZXQgKDB4MDN8MHgwMDAzKSBwbGVuIDAKPiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4
MGUpIHBsZW4gNAogICAgUmVzZXQgKDB4MDN8MHgwMDAzKSBuY21kIDEKICAgIHN0YXR1cyAweDAw
CjwgSENJIENvbW1hbmQ6IFJlYWQgTG9jYWwgU3VwcG9ydGVkIEZlYXR1cmVzICgweDA0fDB4MDAw
MykgcGxlbiAwCj4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgweDBlKSBwbGVuIDEyCiAg
ICBSZWFkIExvY2FsIFN1cHBvcnRlZCBGZWF0dXJlcyAoMHgwNHwweDAwMDMpIG5jbWQgMQogICAg
c3RhdHVzIDB4MDAKICAgIEZlYXR1cmVzOiAweGZmIDB4ZmUgMHgwZCAweDM4IDB4MDggMHgwOCAw
eDAwIDB4MDAKPCBIQ0kgQ29tbWFuZDogUmVhZCBMb2NhbCBWZXJzaW9uIEluZm9ybWF0aW9uICgw
eDA0fDB4MDAwMSkgcGxlbiAwCj4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBsZXRlICgweDBlKSBw
bGVuIDEyCiAgICBSZWFkIExvY2FsIFZlcnNpb24gSW5mb3JtYXRpb24gKDB4MDR8MHgwMDAxKSBu
Y21kIDEKICAgIHN0YXR1cyAweDAwCiAgICBIQ0kgVmVyc2lvbjogMS4yICgweDIpIEhDSSBSZXZp
c2lvbjogMHgyCiAgICBMTVAgVmVyc2lvbjogMS4yICgweDIpIExNUCBTdWJ2ZXJzaW9uOiAweDY5
NjUKICAgIE1hbnVmYWN0dXJlcjogQnJvYWRjb20gQ29ycG9yYXRpb24gKDE1KQo8IEhDSSBDb21t
YW5kOiBSZWFkIEJ1ZmZlciBTaXplICgweDA0fDB4MDAwNSkgcGxlbiAwCj4gSENJIEV2ZW50OiBD
b21tYW5kIENvbXBsZXRlICgweDBlKSBwbGVuIDExCiAgICBSZWFkIEJ1ZmZlciBTaXplICgweDA0
fDB4MDAwNSkgbmNtZCAxCiAgICBzdGF0dXMgMHgwMAogICAgQUNMIE1UVSAzNzc6MTAgU0NPIE1U
VSAxNjowCjwgSENJIENvbW1hbmQ6IFJlYWQgQkQgQUREUiAoMHgwNHwweDAwMDkpIHBsZW4gMAo+
IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbiAxMAogICAgUmVhZCBCRCBB
RERSICgweDA0fDB4MDAwOSkgbmNtZCAxCiAgICBzdGF0dXMgMHgwMCBiZGFkZHIgMDA6MTA6QzY6
ODE6QTQ6N0MKPCBIQ0kgQ29tbWFuZDogUmVhZCBDbGFzcyBvZiBEZXZpY2UgKDB4MDN8MHgwMDIz
KSBwbGVuIDAKPiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxldGUgKDB4MGUpIHBsZW4gNwogICAg
UmVhZCBDbGFzcyBvZiBEZXZpY2UgKDB4MDN8MHgwMDIzKSBuY21kIDEKICAgIHN0YXR1cyAweDAw
IGNsYXNzIDB4MDAwMDAwCjwgSENJIENvbW1hbmQ6IFJlYWQgTG9jYWwgTmFtZSAoMHgwM3wweDAw
MTQpIHBsZW4gMAo+IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbiAyNTIK
ICAgIFJlYWQgTG9jYWwgTmFtZSAoMHgwM3wweDAwMTQpIG5jbWQgMQogICAgc3RhdHVzIDB4MDAg
bmFtZSAnQnJvYWRjb20gQmx1ZXRvb3RoIE1vZHVsZScKPCBIQ0kgQ29tbWFuZDogUmVhZCBWb2lj
ZSBTZXR0aW5nICgweDAzfDB4MDAyNSkgcGxlbiAwCj4gSENJIEV2ZW50OiBDb21tYW5kIENvbXBs
ZXRlICgweDBlKSBwbGVuIDYKICAgIFJlYWQgVm9pY2UgU2V0dGluZyAoMHgwM3wweDAwMjUpIG5j
bWQgMQogICAgc3RhdHVzIDB4MDAgdm9pY2Ugc2V0dGluZyAweDAwNjAKPCBIQ0kgQ29tbWFuZDog
U2V0IEV2ZW50IEZpbHRlciAoMHgwM3wweDAwMDUpIHBsZW4gMQogICAgdHlwZSAwIGNvbmRpdGlv
biAwCiAgICBDbGVhciBhbGwgZmlsdGVycwo+IEhDSSBFdmVudDogQ29tbWFuZCBDb21wbGV0ZSAo
MHgwZSkgcGxlbiA0CiAgICBTZXQgRXZlbnQgRmlsdGVyICgweDAzfDB4MDAwNSkgbmNtZCAxCiAg
ICBzdGF0dXMgMHgwMAo8IEhDSSBDb21tYW5kOiBXcml0ZSBQYWdlIFRpbWVvdXQgKDB4MDN8MHgw
MDE4KSBwbGVuIDIKICAgIHRpbWVvdXQgMzI3NjgKPiBIQ0kgRXZlbnQ6IENvbW1hbmQgQ29tcGxl
dGUgKDB4MGUpIHBsZW4gNAogICAgV3JpdGUgUGFnZSBUaW1lb3V0ICgweDAzfDB4MDAxOCkgbmNt
ZCAxCiAgICBzdGF0dXMgMHgwMAo8IEhDSSBDb21tYW5kOiBXcml0ZSBDb25uZWN0aW9uIEFjY2Vw
dCBUaW1lb3V0ICgweDAzfDB4MDAxNikgcGxlbiAyCiAgICB0aW1lb3V0IDMyMDAwCj4gSENJIEV2
ZW50OiBDb21tYW5kIENvbXBsZXRlICgweDBlKSBwbGVuIDQKICAgIFdyaXRlIENvbm5lY3Rpb24g
QWNjZXB0IFRpbWVvdXQgKDB4MDN8MHgwMDE2KSBuY21kIDEKICAgIHN0YXR1cyAweDAwCg==

--MP_/hj.bCnO9Z.MooCviEY1c7lE--

--Sig_/tZs9ym6=dIDKB27nuMFLExf
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklnOfoACgkQqmIF0LCII9vTmACbBHzCR4Sq7LpV5f67BUl5+M8T
5dEAn1cp2y1wNFcqfMCVE5dNr0WskIQs
=tLeO
-----END PGP SIGNATURE-----

--Sig_/tZs9ym6=dIDKB27nuMFLExf--
