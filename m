Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196104;
	b=GblpeY+fzT5jDNGBOaBvDRKb+71uQq5Yk7elzyzkyyGeb1fwAeDG34QOR3RQb8/G6jDS
	 Z/Rho1uevXKCKOkqIkd6E2ZpqJsmO/ZrlQRaoLj1Hu7yw6k2OM8esbNYMecGfn58z5vIW
	 6HgCGueyh8guaDBYJxVmPYVczAU0tF3r1MfrcK/ZnO61d8M35TDQHJ1lJl0i/abXjIU/b
	 atyc71WO8aUNxjW5vsKDrC+teV3HB6xY3eo5QqU82zfTolL64phTP1kve1Q10VvQKx2XV
	 tckR3Zy//TqQnpiThGXlytpmtPvADwjBOLwKxqQTk5oHqhno7h0giirc7H6kkvVYAGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196104;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=URvNwBArbK+DIIhLGbBoBXGT5Jx0GevFLVlmjfRlhfg=;
	b=GB87iYG1/zJdSF4at3B4N2cedmujZfo8IQIDn0owGaeMMd4TlFSgxFS8540NiJxAa/Ex
	 CiOzlCA8N7vdlfXoApl2B6raCwUEIxjlnhDywHFazOKhYSnaVHdVh/PvpE2JZhe7+RIZv
	 rshpsDKw9NIVci7D5GdzolfYKaibQ1XH/vXxs7ui5v5rd8x4xEAginAggOlf2gWtfWH1X
	 uIl98YfN5I5vBpykA9d3om4UOT7IzYte3QKKVKm34hj3wK5jNddZ0exMDgd3kURIzKrP4
	 WIyTvY2W0rzIjEqQFuBj/i/vY9KWIx3dOIpAxp8N0VvbVSY44FTWhoIVSnecWP4JYmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iYR7ylgx;
	arc=none smtp.remote-ip=79.135.106.31
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E024606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 14:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E024606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iYR7ylgx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793196099; x=1793455299;
	bh=URvNwBArbK+DIIhLGbBoBXGT5Jx0GevFLVlmjfRlhfg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iYR7ylgxJ9WdXgI2g3KsDNRUDkAvg5dWRzWLLNsQtsYrcrIKYM2vlY9+T4VBmnvFb
	 IjnOMZj84R/oYZzPWmclrge5iWSFlvcFBqqZjTmcjaBMT1kIiHBoA89+KAcA/rqaSs
	 5UY8UiwuCoxNKuYUwBYVwjklsnUkK8SBnTQ//HACPcSnYwGyrNbU7YhMc2rj3ufnAW
	 cD/5FPA/o7RiYa+/cS095og2NvEKyf7QBMkMoyEOTuDtbEC90TN6zDB1W5eejX5rr+
	 xHh686dRJ+0CTHq41F4pW3PqoXC3nh4BXJIg5LPDtOKuxgSadOg8l/6cr9kfqQj77B
	 ZKB+8nv+GsCyw==
Date: Wed, 28 Oct 2026 14:01:34 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Bluetooth: btusb: use shared ACL buffers for TP-Link UB500
Message-ID: <zcGBYR2UrTkb3I_O3296MnmoOcoKIbmC4udwcPhXqgB9LpQvmYusp_Zmh9Bm5ELvzwywRXJ-yh5gaRcqmQe2WdA73p5E2-OddcKgKgce6VM=@proton.me>
In-Reply-To: <20261013032742.497402-1-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 4002498d3f11dad7be2831b0f5f8b9706dcf26e4
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Just checking in on this patch. Is there anything else I can do to help it =
move forward?


On Monday, October 12th, 2026 at 11:28 PM, Kyle Pepper <cochcoder@proton.me=
> wrote:

> The TP-Link UB500 (2357:0604) reports a dedicated LE ACL pool of 27
> bytes by eight packets and a BR/EDR ACL pool of 1021 bytes by six
> packets. Sustained large-SDU LE CoC traffic exhausts the small pool,
> although this controller accepts LE traffic through the larger ACL pool.
>=20
> Add an explicit HCI quirk and enable it only for the tested USB ID. When
> set, treat the LE buffer as shared so the existing HCI scheduler uses
> the ACL pool. Avoid inferring this from buffer sizes globally because
> other controllers may have legitimate separate pools.
>=20
> Assisted-by: OpenCode:gpt-6.1-sol
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> Submission review notes (not part of the commit message):
> October 12 N8/UB500 no-quirk trial opens CoC, completes START, DLE
> and 2M, but sends no audio frames and logs two watchdog stalls. The
> host advertises MPS 23 instead of the baseline 512; peer MPS remains
> 168. Firmware pool semantics and simultaneous BR/EDR/LE accounting are
> not established. Keep the quirk device-specific and this proposal RFC.
>=20
>  drivers/bluetooth/btusb_main.c |  7 ++++++-
>  include/net/bluetooth/hci.h    |  7 +++++++
>  net/bluetooth/hci_event.c      | 22 ++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 71d8dccb2..5e1fb26ab 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -70,6 +70,7 @@ static struct usb_driver btusb_driver;
>  #define BTUSB_INTEL_NO_WBS_SUPPORT=09BIT(26)
>  #define BTUSB_ACTIONS_SEMI=09=09BIT(27)
>  #define BTUSB_BARROT=09=09=09BIT(28)
> +#define BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE BIT(29)
>  #define BTUSB_QUALCOMM=09=09=09BIT(30)
> =20
>  static const struct usb_device_id btusb_table[] =3D {
> @@ -872,7 +873,8 @@ static const struct usb_device_id quirks_table[] =3D =
{
>  =09{ USB_DEVICE(0x2c4e, 0x0115), .driver_info =3D BTUSB_REALTEK |
>  =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
>  =09{ USB_DEVICE(0x2357, 0x0604), .driver_info =3D BTUSB_REALTEK |
> -=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
> +=09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH |
> +=09=09=09=09=09=09     BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE },
>  =09{ USB_DEVICE(0x2357, 0x0607), .driver_info =3D BTUSB_REALTEK |
>  =09=09=09=09=09=09     BTUSB_WIDEBAND_SPEECH },
>  =09{ USB_DEVICE(0x0b05, 0x190e), .driver_info =3D BTUSB_REALTEK |
> @@ -4748,6 +4750,9 @@ static int btusb_probe(struct usb_interface *intf,
>  =09if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
>  =09=09hci_set_quirk(hdev, HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED);
> =20
> +=09if (id->driver_info & BTUSB_USE_BREDR_ACL_BUFFERS_FOR_LE)
> +=09=09hci_set_quirk(hdev, HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE);
> +
>  =09if (id->driver_info & BTUSB_INVALID_LE_STATES)
>  =09=09hci_set_quirk(hdev, HCI_QUIRK_BROKEN_LE_STATES);
> =20
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 1641d879d..d39a64663 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -375,6 +375,13 @@ enum {
>  =09 */
>  =09HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> =20
> +=09/* When this quirk is set, LE connections use the BR/EDR ACL buffer
> +=09 * pool instead of the dedicated LE pool reported by the controller.
> +=09 * This is required for controllers that expose an unusably small LE
> +=09 * pool while accepting LE traffic through their shared ACL pool.
> +=09 */
> +=09HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE,
> +
>  =09__HCI_NUM_QUIRKS,
>  };
> =20
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index c055d16cf..9936f6365 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1227,6 +1227,24 @@ static u8 hci_cc_pin_code_neg_reply(struct hci_dev=
 *hdev, void *data,
>  =09return rp->status;
>  }
> =20
> +/* Use the shared ACL pool for controllers whose dedicated LE pool is kn=
own to
> + * be unusable for sustained large-SDU traffic.
> + */
> +static void hci_le_use_shared_acl_buffer(struct hci_dev *hdev)
> +{
> +=09if (hci_test_quirk(hdev, HCI_QUIRK_USE_BREDR_ACL_BUFFERS_FOR_LE) &&
> +=09    hdev->le_mtu =3D=3D HCI_MIN_LE_MTU &&
> +=09    hdev->acl_mtu > hdev->le_mtu && hdev->acl_pkts) {
> +=09=09bt_dev_dbg(hdev,
> +=09=09=09   "LE buffer at minimum (%u:%u), sharing ACL buffer %u:%u",
> +=09=09=09   hdev->le_mtu, hdev->le_pkts,
> +=09=09=09   hdev->acl_mtu, hdev->acl_pkts);
> +=09=09hdev->le_mtu =3D 0;
> +=09=09hdev->le_pkts =3D 0;
> +=09=09hdev->le_cnt =3D 0;
> +=09}
> +}
> +
>  static u8 hci_cc_le_read_buffer_size(struct hci_dev *hdev, void *data,
>  =09=09=09=09     struct sk_buff *skb)
>  {
> @@ -1247,6 +1265,8 @@ static u8 hci_cc_le_read_buffer_size(struct hci_dev=
 *hdev, void *data,
>  =09if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
>  =09=09return HCI_ERROR_INVALID_PARAMETERS;
> =20
> +=09hci_le_use_shared_acl_buffer(hdev);
> +
>  =09return rp->status;
>  }
> =20
> @@ -3939,6 +3959,8 @@ static u8 hci_cc_le_read_buffer_size_v2(struct hci_=
dev *hdev, void *data,
>  =09if (hdev->le_mtu && hdev->le_mtu < HCI_MIN_LE_MTU)
>  =09=09return HCI_ERROR_INVALID_PARAMETERS;
> =20
> +=09hci_le_use_shared_acl_buffer(hdev);
> +
>  =09return rp->status;
>  }
> =20
>=20
> base-commit: 964430c038967fd06643e866f68115664e1a1bd1
> 
