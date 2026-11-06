Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794000875;
	b=Td/ABNquWlBXNmWOO9GB8IWO6V5ipX79h3uUya+fjXON6wbuGimw2plGgaL0dpv0HS4Z
	 lxbli3W7UmfF0AGPExOy4OffZzTbm27QXNKqT+hq7wZdazQU9V13/LpxF3uwG8g1IxFzg
	 412ug/aHYh3lO/4w+cOHFGeWH3bvgsg2b6rdLoKYy00DoNKvfxdhQOnRAnRIMTt623yPi
	 Ibj8NLN+YuVUv/1fRElRAG0Q+ukxxWUHlC8h7s2xuIN6FDQwjS+j2wvYweHMotPivSn3L
	 +8ieFSEsZ/AkPSyWGWOdlBJLh5CmdJXsSE9J0Yloe6AxNUlNQBDJGnYEIY9Ks/YApXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794000875;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=ooC4OTXs+2O7ScOKESZ7MxuN5UuAn8QGbuugclC7nqo=;
	b=GxaqKIiXbB4CYPhnq+EVT5PhtKHfRIicmqBSUkzFEP2NrClRQGwgp6D74PpA8bv0RkSU
	 GeRL0WRKBiXsMQw8+Q0RXwiVUKuOwZ46LfzhDtJz/wocsO6XIIQtDsJSlNjLtdb8jLEG9
	 zYoUFDX5JvCKwVCos18lwoyfXW3PxqRSytNG8ocQSq9S0Vcqb7PgfU4HKYLmE2Sv1qSDv
	 RIaSBd1TvkONJV2SpTbv/gS4PCyr3hBeYwrOepUz7fRzczQi/d3jvpnqQZZolG5sYzejZ
	 t+WRXCIbj/Rplk9T44B922Ey4Hu8FapsrR/ZN6bKWkmY5Cz++pCW7WM9E4+8FZRA0Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=proton.me;
	spf=pass smtp.mailfrom=proton.me;
	dkim=pass header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=H9nRBTKQ;
	arc=none smtp.remote-ip=185.70.43.101
Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E209D606A32F
	for <linux-bluetooth@vger.kernel.org>; Fri,  6 Nov 2026 21:34:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E209D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=proton.me header.i=@proton.me header.a=rsa-sha256 header.s=protonmail2 header.b=H9nRBTKQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1794000871; x=1794260071;
	bh=ooC4OTXs+2O7ScOKESZ7MxuN5UuAn8QGbuugclC7nqo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=H9nRBTKQiWKnqs6XMWJHL4gFEKgYtwliywzKS2n8W/GKuz/28mg6ICl6+Fxjg8qzv
	 hIUwKHHdWtDwCTlY59eZf7RvZZyqxVZIa5AD8vUabLIIPAVW+vBu2kcZ8qRIXD+2R4
	 d8gDNQvdc2al7J5m6c5n+FBPWOG8GGH9QJrhykbuzPFYRvAhPLCPcgHiL+OZ+PG1T8
	 z+PSHxA6sPcno9SCY+Dp1r9JZrv0Bb3XB9dDngLfAuuw9HGOD5jszhzexL7em7TRrG
	 4qmgXLEf5p4DXbhze7cfWFn1/WvKEOecl86mJ33VzLMYc1hxj/W37mTQlYOQXN4zTb
	 rpwKiCG1mWIYw==
Date: Fri, 06 Nov 2026 21:34:26 +0000
To: linux-bluetooth@vger.kernel.org
From: cochcoder <cochcoder@proton.me>
Cc: linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org
Subject: Re: [PATCH v5 1/1] Bluetooth: btusb: support larger LE packets on TP-Link UB500
Message-ID: <WioHtJe5UoBDypyj0zDKYKksSKYCyTLi_RJLX-8uaxbN9WWssCjald6Lc6_MDAaw0Owixufqc4h_JnPMwFBVGzgtMmXMfJD3jIDh_0UHxZ4=@proton.me>
In-Reply-To: <5a7311d6f4cc94931fd753e5fe0d54a2a65f631a.1793315289.git.cochcoder@proton.me>
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029023235.1280321-1-cochcoder@proton.me> <20261029023235.1280321-2-cochcoder@proton.me> <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me> <5a7311d6f4cc94931fd753e5fe0d54a2a65f631a.1793315289.git.cochcoder@proton.me>
Feedback-ID: 97716137:user:proton
X-Pm-Message-ID: 9a5b7e09ef60babff6ad5da84afb976484f06888
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

Hi,=20

I've been using this patch for the past couple of days and haven't noticed =
any issues with it in that time. I'm unsure if I've managed to use all 8 cr=
edits however.=20

Kyle Pepper



On Thursday, October 29th, 2026 at 7:08 PM, Kyle Pepper <cochcoder@proton.m=
e> wrote:

> The TP-Link UB500 (2357:0604) reports a 27-byte LE ACL packet length and
> eight LE packets, although its reported maximum LE TX data length is
> 251 bytes. The small HCI packet length fragments ASHA audio packets.
> Direct controller testing received 251-byte LE HCI packets intact.
>=20
> Set the host LE ACL MTU to the reported maximum after initialization for
> the observed 27/eight/eight-available/251 reports. Skip other reports
> without failing controller initialization.
>=20
> Keep the controller-reported packet count and available credits unchanged
> so transfers can use all eight credits. Leave BR/EDR accounting unchanged=
.
>=20
> Assisted-by: LLM
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> v5:
> - Keep the reported eight LE packet credits instead of reducing them to
>   one, addressing Luiz's throughput concern.
> - Keep automatic MTU selection and nonfatal handling of mismatched report=
s.
>=20
> Matched 60-second single-N8 playback tests on the UB500 passed at host MT=
U
> 167/eight and 251/eight, with CLEAR listening and verified stock restorat=
ion
> between tests. The control had 3,236 complete audio SDUs and 3,262/3,262 =
HCI
> completions; the 251-byte setting had 3,234 SDUs and 3,260/3,260 completi=
ons.
> Both used whole 167-byte HCI audio packets, reached three outstanding pac=
kets,
> returned all credits and had no socket EAGAIN or disconnection. PipeWire'=
s
> actual SO_SNDBUF stayed 4608. Tests used the exact callback ported to the
> Arch-based ASHA 7.2.9 kernel; fresh upstream object builds run before sen=
ding.
>=20
> An earlier 251/eight trial sounded clear but stalled after about 40 secon=
ds
> of audio transmission and ended with HCI Connection Timeout (0x08), with =
seven
> completions pending. Restoration succeeded. Its cause remains unexplained=
;
> the successful comparison does not erase that failure.
>=20
> These are normal single-CI playback results. They do not establish eight
> physical 251-byte slots, mixed BR/EDR+LE capacity, bilateral recovery,
> exceptional congestion behavior, other firmware or long-duration reliabil=
ity.
>=20
>  drivers/bluetooth/btusb_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 92a78a7e6..9cc3dd240 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -2972,6 +2972,19 @@ static int btusb_setup_realtek(struct hci_dev *hde=
v)
>  =09return ret;
>  }
> =20
> +static int btusb_ub500_post_init(struct hci_dev *hdev)
> +{
> +=09if (hdev->le_mtu !=3D 27 ||
> +=09    hdev->le_pkts !=3D 8 || hdev->le_cnt !=3D 8 ||
> +=09    hdev->le_max_tx_len !=3D 251)
> +=09=09return 0;
> +
> +=09bt_dev_info(hdev, "LE ACL MTU 27 -> %u; LE packets 8 unchanged",
> +=09=09    hdev->le_max_tx_len);
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
> +=09=09=09hdev->post_init =3D btusb_ub500_post_init;
>  =09=09hdev->shutdown =3D btrtl_shutdown_realtek;
>  =09=09hdev->reset =3D btusb_rtl_reset;
>  =09=09hdev->hw_error =3D btusb_rtl_hw_error;
>=20
> base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
> --=20
> 2.56.0
>=20
> 
