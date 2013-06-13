Return-Path: <cyrus@holtmann.org>
Date: Thu, 13 Jun 2013 12:25:57 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org, pavel@ucw.cz
Subject: Re: [PATCH] Bluetooth: Fix conditions for HCI_Delete_Stored_Link_Key
Message-ID: <20130613112557.GC17870@joana>
References: <1371110473-15072-1-git-send-email-johan.hedberg@gmail.com>
 <5B6FB8F0-A31D-4C86-B15A-3FA04CB237FF@holtmann.org>
 <20130613104216.GA17870@joana>
 <C40E0870-3699-41E2-8764-AD5DB1344927@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
In-Reply-To: <C40E0870-3699-41E2-8764-AD5DB1344927@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

* Marcel Holtmann <marcel@holtmann.org> [2013-06-13 12:48:51 +0200]:

> Hi Gustavo,
>=20
> >>> Even though the HCI_Delete_Stored_Link_Key command is mandatory for 1=
=2E1
> >>> and later controllers some controllers do not seem to support it
> >>> properly as was witnessed by one Broadcom based controller:
> >>>=20
> >>> < HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7
> >>>   bdaddr 00:00:00:00:00:00 all 1
> >>>> HCI Event: Command Complete (0x0e) plen 4
> >>>   Delete Stored Link Key (0x03|0x0012) ncmd 1
> >>>   status 0x11 deleted 0
> >>>   Error: Unsupported Feature or Parameter Value
> >>>=20
> >>> Luckily this same controller also doesn't list the command in its
> >>> supported commands bit mask (counting from 0 bit 7 of octet 6):
> >>>=20
> >>> < HCI Command: Read Local Supported Commands (0x04|0x0002) plen 0
> >>>> HCI Event: Command Complete (0x0e) plen 68
> >>>   Read Local Supported Commands (0x04|0x0002) ncmd 1
> >>>   status 0x00
> >>>   Commands: ffffffffffff1ffffffffffff30fffff3f
> >>>=20
> >>> Therefore, it makes sense to move sending of HCI_Delete_Stored_Link_K=
ey
> >>> to after receiving the supported commands response and to only send it
> >>> if its respective bit in the mask is set. The downside of this is that
> >>> we no longer send the HCI_Delete_Stored_Link_Key command for Bluetooth
> >>> 1.1 controllers since HCI_Read_Local_Supported_Command was introduced=
 in
> >>> version 1.2, but this is an acceptable penalty as the command in
> >>> question shouldn't affect critical behavior.
> >>>=20
> >>> Reported-by: Pavel Machek <pavel@ucw.cz>
> >>> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> >>> ---
> >>> net/bluetooth/hci_core.c |   14 +++++++++-----
> >>> 1 file changed, 9 insertions(+), 5 deletions(-)
> >>>=20
> >>> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> >>> index d817c93..d68425c 100644
> >>> --- a/net/bluetooth/hci_core.c
> >>> +++ b/net/bluetooth/hci_core.c
> >>> @@ -341,7 +341,6 @@ static void hci_init1_req(struct hci_request *req=
, unsigned long opt)
> >>>=20
> >>> static void bredr_setup(struct hci_request *req)
> >>> {
> >>> -	struct hci_cp_delete_stored_link_key cp;
> >>> 	__le16 param;
> >>> 	__u8 flt_type;
> >>>=20
> >>> @@ -365,10 +364,6 @@ static void bredr_setup(struct hci_request *req)
> >>> 	param =3D __constant_cpu_to_le16(0x7d00);
> >>> 	hci_req_add(req, HCI_OP_WRITE_CA_TIMEOUT, 2, &param);
> >>>=20
> >>> -	bacpy(&cp.bdaddr, BDADDR_ANY);
> >>> -	cp.delete_all =3D 0x01;
> >>> -	hci_req_add(req, HCI_OP_DELETE_STORED_LINK_KEY, sizeof(cp), &cp);
> >>> -
> >>> 	/* Read page scan parameters */
> >>> 	if (req->hdev->hci_ver > BLUETOOTH_VER_1_1) {
> >>> 		hci_req_add(req, HCI_OP_READ_PAGE_SCAN_ACTIVITY, 0, NULL);
> >>> @@ -602,6 +597,15 @@ static void hci_init3_req(struct hci_request *re=
q, unsigned long opt)
> >>> 	struct hci_dev *hdev =3D req->hdev;
> >>> 	u8 p;
> >>=20
> >> I would have added here a comment to explain what bit we are checking =
for.
> >=20
> > I just added:
> >=20
> > /* Only send HCI_Delete_Stored_Link_Key if it is supported */
>=20
> that is the super cheap way out. There is no harm in going into details.
>=20
> 	/* Some Broadcom based Bluetooth controllers do not support the
> 	 * Delete Stored Link Key command. They are clearly indicating its
> 	 * absence in the bit mask of supported commands.
> 	 *
> 	 * Check the supported commands and only if the the command is marked as
> 	 * supported send it. If not supported assume that the controller does n=
ot
> 	 * have actual support for stored link keys which makes this command
> 	 * redundant anyway.
> 	 */

Too late, I just sent out the pull request, I'll queue a patch here just to
add this comment and apply it once this lands on bluetooth-next.

	Gustavo

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (GNU/Linux)

iQIcBAEBAgAGBQJRuaxEAAoJEPs3PUX4s20ov9IP/AtzQUfTGIpiNn5UGdLJw/+l
MiaEZGfjmcEp7du7k+746focpKp0YrPS2u/eYXXGVRNE0NQ6BqX/W33dx4qxTWUk
+Gw8AZ7IpO7kg6PdjwFBMKsoisE6XUps8BkKRQ/kcmqR66L3wf8xZGxsIBtcskW4
oKN0LI+OK4pyJxJMNbztPICAfFLec3hYtHgSDTr1fEQHpgtrRrj89Q3N+kAasiVb
Piwvwu1xVmw3hD5Tzfw8NOLaHOwMjy7y+g2aQSODV4LuU9beCj+XRV6qF+sLSiIg
Y9HStvQlGjKgNhhVbQqzeVShxegVTLe/zLf73j0Gcx3U8EYx9wfQATc1UhGwvWcj
ugG/Ufdh/EJPm3OFIPJtpoKGa8xuKONZ3FlPTF5rFEacQ+A/H/UVpySTyra+AsHD
80bhah3xiUlSD07orwvebnNJg6pv2gz6naw4WI1kEePcMLXHHJWA8R43RItnXQkc
yKyQh4pCEhsbDq/6d9+0jK/R+YcomYHId7tJQBVcCVg0YnM9+14RAVji0VAOR4aT
XPIQK/ROVMaD+RepqHeq8wkBr8elxG0NZSF5UxdIUGwia8oKt3gdmZwa4g+wHmmf
LzuArPOAL4g8JH6JsybjbJn4GpQqI94FiVE4Lso851ZiiV0fb69rnEqui8Vt/+lP
xXgqxrAsFA/VKzSq39+K
=T2cz
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
