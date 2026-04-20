Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB052D97BD;
	Mon, 20 Apr 2026 09:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676148; cv=none; b=uLpi4ATa8y8c7dQ3zyI3PtqhVFOdzyqixxdpPNimW+XxxjWMvvfeKN7tP1DWUNQe7Ln3b15DX9WIPTFLkrJ72RAd5D+IMx8GL8rKEgyGmenTjBrNU4lcvywca67noEgcY9PEDGQwUHu9sKzkfZFges1hjHfeqc3Q5MoAMBjap30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676148; c=relaxed/simple;
	bh=Jm9cR7dzN38Q8HkixLFksZmcRuhFqODxDackMYKvry4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bZnsxEXMhRfQk9vy/i2Rfu+00LK4Ll3gUViHoLDq3eO3ML+oPrroOtTl9tcBJ2ueb/oZWO2MIfsXwIPEj8zjNU9eZQJQMRWCAREIPkf8uQGDOogKxE5yBdiF+QIWLhFyFkKsQBhzXTj+WhwjYi1c5zLSGxIVzzsiQKyL1IMvYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net; spf=pass smtp.mailfrom=hadess.net; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hadess.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hadess.net
Received: by mail.gandi.net (Postfix) with ESMTPSA id EB17E3E9F5;
	Mon, 20 Apr 2026 09:08:57 +0000 (UTC)
Message-ID: <c4593a49ef6ed7151eceebfd22d602a0d018e9f5.camel@hadess.net>
Subject: Re: [PATCH] Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for
 combo chips
From: Bastien Nocera <hadess@hadess.net>
To: Pauli Virtanen <pav@iki.fi>, StefanCondorache <condorachest@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Date: Mon, 20 Apr 2026 11:08:57 +0200
In-Reply-To: <8961a9ba3e4a48eaa33060114366573439bbf73f.camel@iki.fi>
References: <20260419072433.55976-1-condorachest@gmail.com>
	 <8961a9ba3e4a48eaa33060114366573439bbf73f.camel@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-GND-Sasl: hadess@hadess.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTEzkoAZ3xmQ1tAn+qL5GyOPlHGXJrqTzYJp9KHDd/8Z8hAZfX6yQnvvUR3CnifHSRYcilwqeWHOVM908GakEZ9H7zBYlR5tsBH6VL6rA7S0iMe4rG7z+l6gAE5N5yQLNrWEm5DBQA+CAbq2e7txjkvZVgLx5b0Dh16yHHP+K/9x/YX758P2K0aCym4rWIy3tUCQXZ/0pfWXptw3KfKnpnCZROSNdm+7KIXjkn+Gbkzga8DjDiQR7FkdsuxN3+IMjTJAP8Z7gyEbr9sZFARrTBW9hfebvq4FCd5TyTPJytCiLTp7C4H66EPiNVL2NJHxtV1r0t6zwaIvskv7ZxlA6NnmGslkG5NjIPkFAQqcKPEziaUAuBMh8LIbb76IyPrkjbRGxGwTVJ63FFjNYi0d61zRcJe0I03tvaYdH78NiHgUkChMIMWainHtQycfqVXg29kvQdMqtUEd3Qshf951mrI2i73hP5eHZ5qhbxqxt6vc+gBhARqMVhDGiv8vg+cWwG2WucnKvZS1Km4G2/oAayAjkJNcQ0a0X8MZl+G3x+wScTmFn3b9uy0ar6l6ijaGyV98FWV4rJAEHc4ogqAMmw+rztQsZZ1FpKnhSMPgWH/vyjJyMjbni9M6sxjZrebUch3+8nxw7kTEJP/gUorNqirBWOTIH9nDV+uiSC8BmGhhNg

On Sun, 2026-04-19 at 13:35 +0300, Pauli Virtanen wrote:
> Hi,
>=20
> su, 2026-04-19 kello 10:24 +0300, StefanCondorache kirjoitti:
> > Realtek combo chips share a single antenna between Wi-Fi and
> > Bluetooth.
> > Background LE passive scanning while an active connection exists
> > causes
> > antenna multiplexing conflicts via Packet Traffic Arbitration
> > (PTA),
> > resulting in audio stuttering and Wi-Fi packet loss.
> >=20
> > Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED to suppress passive scanning
> > in
> > hci_update_passive_scan_sync() when active connections are present.
> > Set this quirk for all Realtek devices in btrtl_set_quirks().
>=20
> Some general questions on this, which are not immediately apparent
> from
> the commit message:
>=20
> How is it know which Realtek models have this bug?
>=20
> Which ones were tested?
>=20
> Is it better to set the quirk for all Realtek devices than do it per
> USB id / chipset for each known bad device?

I worked on the rtl8723bs Wi-Fi driver in a previous life (so much so
that I can spell out the model number on top of my head), and I
remember it having code for BT/Wi-Fi coexistence.

Is this only a problem with the lack of BT/Wi-Fi coexistence support in
the upstream Linux drivers (eg. not in the Realtek vendor drivers)

How do you actually test this in a reliable and reproducible way? How
will we know to remove this quirk?

> > Also add device ID 0x0bda:0xc829 to the btusb Realtek device table.
>=20
> Patches adding USB device ids usually have USB info from
> /sys/kernel/debug/usb/devices in the commit message, see other
> patches
> add these. Probably should be separate patch?
>=20
> > Signed-off-by: StefanCondorache <condorachest@gmail.com>
> > ---
> > =C2=A0drivers/bluetooth/btrtl.c=C2=A0=C2=A0 |=C2=A0 6 ++++++
> > =C2=A0drivers/bluetooth/btusb.c=C2=A0=C2=A0 |=C2=A0 2 ++
> > =C2=A0include/net/bluetooth/hci.h | 11 +++++++++++
> > =C2=A0net/bluetooth/hci_sync.c=C2=A0=C2=A0=C2=A0 |=C2=A0 7 +++++++
> > =C2=A04 files changed, 26 insertions(+)
> >=20
> > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > index 62f9d4df3a4f..00dfba656970 100644
> > --- a/drivers/bluetooth/btrtl.c
> > +++ b/drivers/bluetooth/btrtl.c
> > @@ -1299,6 +1299,12 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> > =C2=A0
> > =C2=A0void btrtl_set_quirks(struct hci_dev *hdev, struct
> > btrtl_device_info *btrtl_dev)
> > =C2=A0{
> > +	/* Realtek combo chips share the antenna between Wi-Fi and
> > +	 * Bluetooth. Suppress passive scanning while connected to
> > +	 * prevent coexistence issues.
> > +	 */
> > +	hci_set_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED);
>=20
> This sets the quirk for all Realtek chips.
>=20
> Realtek chips are also in stuff like Bluetooth USB dongles that are
> not
> combo wifi ones. Can they be identified?
>=20
> > +
> > =C2=A0	/* Enable controller to do both LE scan and BR/EDR inquiry
> > =C2=A0	 * simultaneously.
> > =C2=A0	 */
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 5f57953393be..87972f5fc567 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -516,6 +516,8 @@ static const struct usb_device_id
> > quirks_table[] =3D {
> > =C2=A0	/* Realtek 8822CU Bluetooth devices */
> > =C2=A0	{ USB_DEVICE(0x13d3, 0x3549), .driver_info =3D BTUSB_REALTEK
> > |
> > =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0
> > BTUSB_WIDEBAND_SPEECH },
> > +	{ USB_DEVICE(0x0bda, 0xc829), .driver_info =3D BTUSB_REALTEK
> > |
> > +						=09
> > BTUSB_WIDEBAND_SPEECH },
> > =C2=A0
> > =C2=A0	/* Realtek 8851BE Bluetooth devices */
> > =C2=A0	{ USB_DEVICE(0x0bda, 0xb850), .driver_info =3D BTUSB_REALTEK
> > },
> > diff --git a/include/net/bluetooth/hci.h
> > b/include/net/bluetooth/hci.h
> > index 572b1c620c5d..8466dc52aeca 100644
> > --- a/include/net/bluetooth/hci.h
> > +++ b/include/net/bluetooth/hci.h
> > @@ -378,6 +378,17 @@ enum {
> > =C2=A0	 */
> > =C2=A0	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> > =C2=A0
> > +	/* When this quirk is set, the controller suppresses
> > passive LE
> > +	 * background scanning while an active connection exists.
> > +	 * This is required for combo chips with shared Wi-
> > Fi/Bluetooth
> > +	 * antennas to prevent coexistence issues causing audio
> > drops
> > +	 * and Wi-Fi packet loss.
> > +	 *
> > +	 * This quirk can be set before hci_register_dev is called
> > or
> > +	 * during the hdev->setup vendor callback.
> > +	 */
> > +	HCI_QUIRK_NO_SCAN_WHILE_CONNECTED,
> > +
> > =C2=A0	__HCI_NUM_QUIRKS,
> > =C2=A0};
> > =C2=A0
> > diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> > index fd3aacdea512..5e30e725efa2 100644
> > --- a/net/bluetooth/hci_sync.c
> > +++ b/net/bluetooth/hci_sync.c
> > @@ -3194,6 +3194,13 @@ int hci_update_passive_scan_sync(struct
> > hci_dev *hdev)
> > =C2=A0	if (hdev->discovery.state !=3D DISCOVERY_STOPPED)
> > =C2=A0		return 0;
> > =C2=A0
> > +	/* If the controller requires no scanning while connected,
> > +	 * suppress passive scanning when an active connection
> > exists.
> > +	 */
> > +	if (hci_test_quirk(hdev,
> > HCI_QUIRK_NO_SCAN_WHILE_CONNECTED) &&
> > +	=C2=A0=C2=A0=C2=A0 !list_empty(&hdev->conn_hash.list))
> > +		return 0;
> > +
>=20
> Does this break initiating connections via hci_connect_le_scan() if
> another connection is active?
>=20
> Is it possible to make more than one LE connection simultaneously?
>=20
> > =C2=A0	/* Reset RSSI and UUID filters when starting background
> > scanning
> > =C2=A0	 * since these filters are meant for service discovery
> > only.
> > =C2=A0	 *
