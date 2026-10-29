Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.119
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241420;
	b=AfXQBIWXdFLvfqGrq8tuPqSgiNRvhMeZgvfpyZ9v+7o56E5kkyaLu//Uqjx9fNndgh2d
	 /bTsMRI6T6Hnrm+ujn7bLoz3ObXNQLEcMk0YhsLDFkwFHm19QtB+LCZFdYMKgzFfKZmp7
	 R4FaAbEa78ai6DjywSF1/GzG0hpAyVtQYWAJ5muZmoq6yt2OG7R9vjvLPQUBlCeCwEAYd
	 5z+V5j7HyTyMzSdyR3ThGaTuMOJaTineyarErLoSiOlYNpxV8E1wactwuDEzQIFjC+ywt
	 LLLB+Yxr8oP2VlCOfEjYrbAgCUIyXxBgyfXcWXNPJUDfWNS9ZC3zYvdWYKTPbI21COg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241420;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=TP/koneTdP9q99/N08kg5asZHhb7aicfFrLtli1TTdA=;
	b=yErzqfnPistvAXlMRpMhuXiDq3FeMIdCvfCTrb8J6uJsg12LfvC4yxeEutoWqEjRk3d+
	 2D8O7HH3bQov0bsFlmo2PLFPCejg1PoC3288sHklPQf2Jn7RVnE+UOyBuftZQRlFtIfw+
	 nc/Gqtygw3/yGgUeTSpVcL4knC7Cg9VwocVFOqJCiP0P4LH8R4VjPnfzLj9RiF7F70qeD
	 EzES0xxHEElI9qS6d0FyUemdrQucJV5XpBcHQrK22o73SM7MtT3FQE9DiZSBAT0Eb8X9U
	 fjqfYznGZ/KVRNgCw2dEzwErFa1BzMUA+VjI/Re21a2Mwof877VgSTZxKj3l+4rA4AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iSELxFai;
	arc=none smtp.remote-ip=79.135.106.119
Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99841606A323
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 02:36:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99841606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=iSELxFai
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1793241415; x=1793500615;
	bh=TP/koneTdP9q99/N08kg5asZHhb7aicfFrLtli1TTdA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iSELxFaiGE2bxcneYK0VnG/0eFSWoVXHGDL+86bPl9TzxXjwcmUgb8rxr3PcIdh56
	 iPgjUEZ3iRMBF59b2kz8972UdnGWDCb3OgEUXa+chQ8cjx5plwkTo2nIaJrBUx1v+a
	 GX8Ohhl83HjPMJQHbKduvZi0VJ2x6QjIwx4dnvQ9K20JsM8FdA4yz2tvtmSW256bf7
	 fvKIUoAgB7xz1ukd6yamCDYAuapZ10lSi5jI+rg55FYSKir2UtdpH0xtG1bFAmSZuo
	 Wv7LsOhnOPzCPHxd5hRBhxuDRmbAp69GpyZekizlDvPYmoXDRfKoiQA3uiJoRWFZ1z
	 s85MdfvcYsRPA==
Date: Thu, 29 Oct 2026 02:36:50 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: Re: [RFC PATCH v3 1/1] Bluetooth: btusb: test reported maximum LE length on TP-Link UB500
Message-ID: <mHG0oCxCI78VykqUdjQxfal8LQM9K0VX759HNPN8KH51ERQWLh38Bys9SSI0NUSCY8KE32SZa97O-9hsNqTanUn-n2x-EUopaBEEK20avn0=@proton.me>
In-Reply-To: <20261029023235.1280321-2-cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029023235.1280321-1-cochcoder@proton.me> <20261029023235.1280321-2-cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 1e56263b990b34ea99103c3a31b4eb96d62ef335
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

Accidentally left in the last comment to keep it as a test only RFC, I've t=
ested the changes and haven't noticed any regressions. Please ignore that.=
=20



On Wednesday, October 28th, 2026 at 10:32 PM, Kyle Pepper <cochcoder@proton=
.me> wrote:

> The tested TP-Link UB500 (2357:0604, RTL8761BU firmware 0xdfc6d922)
> reports maximum TX and RX data lengths of 251 octets through LE Read
> Maximum Data Length, while LE Read Buffer Size reports 27 octets and
> eight packets. The previous RFC demonstrated 167-byte HCI packets
> with unchanged LE credits during ASHA playback.
>=20
> Use the reported maximum TX data length as the next experimental host
> LE ACL length instead of an ASHA-specific 167-byte constant. Require
> the observed 251-byte maximum and 27/eight buffer reply; preserve LE
> credits and BR/EDR fields. The maximum-data-length value describes
> Link Layer capability and is an indication to test, not proof of the
> physical HCI buffer size or pool layout.
>=20
> A direct HCI user-channel experiment sends sixteen whole packets at
> each HCI payload length of 27, 167 and 251 octets from UB500 to a
> MediaTek receiver. All 48 payloads are received byte-for-byte intact
> and all 48 HCI packets complete, with zero pending. This establishes
> 251-byte HCI acceptance separately from the reported Link Layer limit.
> Only one packet is outstanding at a time; the experiment neither
> installs the revised callback nor streams audio.
>=20
> Keep this a TEST ONLY RFC. Eight simultaneous large packets, larger
> HCI limits, mixed BR/EDR capacity, other firmware and sustained audio
> with the revised callback have not been established.
>=20
> Assisted-by: LLM
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
>  drivers/bluetooth/btusb_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 92a78a7e6..b654cf5be 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -2972,6 +2972,19 @@ static int btusb_setup_realtek(struct hci_dev *hde=
v)
>  =09return ret;
>  }
> =20
> +/* Private diagnostic: test the reported Link Layer maximum as an HCI si=
ze. */
> +static int btusb_ub500_test_post_init(struct hci_dev *hdev)
> +{
> +=09if (hdev->le_mtu !=3D 27 || hdev->le_pkts !=3D 8 ||
> +=09    hdev->le_max_tx_len !=3D 251)
> +=09=09return -EINVAL;
> +
> +=09bt_dev_info(hdev, "UB500 TEST ONLY: LE ACL MTU 27 -> %u; LE packets %=
u unchanged",
> +=09=09    hdev->le_max_tx_len, hdev->le_pkts);
> +=09hdev->le_mtu =3D hdev->le_max_tx_len;
> +=09return 0;
> +}
> +
>  static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff=
 *skb)
>  {
>  =09if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
> @@ -4715,6 +4728,9 @@ static int btusb_probe(struct usb_interface *intf,
>  =09    (id->driver_info & BTUSB_REALTEK)) {
>  =09=09btrtl_set_driver_name(hdev, btusb_driver.name);
>  =09=09hdev->setup =3D btusb_setup_realtek;
> +=09=09if (le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0x2357 &&
> +=09=09    le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D 0x0604)
> +=09=09=09hdev->post_init =3D btusb_ub500_test_post_init;
>  =09=09hdev->shutdown =3D btrtl_shutdown_realtek;
>  =09=09hdev->reset =3D btusb_rtl_reset;
>  =09=09hdev->hw_error =3D btusb_rtl_hw_error;
> --=20
> 2.56.0
>=20
> 
