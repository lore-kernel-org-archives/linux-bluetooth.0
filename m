Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793291283;
	b=Kp6IkBlUE1gRJsPQ2SAlEAJYjdk/AaeLkcfBDJbd3L39pcmCsyL+F9eLfsusWhdz6tIZ
	 X3IpfhF0S1Wlv5YvNs6ElWA3E6keO6+Or4HHZCnIE7uWPU6atSpHLIGjQkRhAGnMcaj1A
	 BRCa3NzgyzS3b3VNJTO4DrUfQkGm69K2M15mCmg7B1xeLLx/6Ev0BIWlYWQmww5NB7Ald
	 525cN2FFZNIiFCd2jTs4CTqi0MXcWhbguvvmWDeIXn47uBZiU9cH7JnHFLV/gTKVlRhWL
	 IzmSDMtiZm04A2TmYOI5G3ctifi449uLO93VlbGJJr6VhdEhJQDdHpobzSYTLeCzGMw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793291283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=LQ37hPvquQn330cxCo8SGW3/WEute1UfVq1UF21kzCw=;
	b=miaEvx51wJnw2xch2Lai6erU6XVNt/FQMpp7LVODKksI3U7MJuMI1kO1fXH++dd/jL12
	 SNtQTzhKCbTmI7LXnTxlOmw9JWkY0yHtKkj+sAUMKWlZW2NWsXgkzeEp2O3C8StggLIy6
	 J/hGWPPqu4dj/iXpyIqSJaODytcCJsEnOEuEdJjWaMP6GpAzzVGD/+vRb/M7j+BGVtXuk
	 wG4F7lxk4aO4zOvGrX79si6GMBSuSq6n7vZ6clR5C7iPSwG8Ji2Lu9B2Qn8XNbFMTaaLk
	 V7pPl9s13EesXI7l3eO8TTRBRktfzHJZHTzEEHVUFwWP3QY7XNQzsDv2wGfNSrv3xLg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="HjoSan8/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A33D606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 16:28:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A33D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HjoSan8/
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b0e21048f8so21282517b3.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 09:28:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793291282; cv=none;
        d=google.com; s=arc-20260327;
        b=R3V4HP2+kyNqR9uk+ycJTrfYuO/Qw/tnUPoKr4DrvwATReTd9aOcpZ0WomX3zzBf/8
         +i1QfbobdB/QklFHNeHmm+t0yHHP8UD31vEaPYM7zoUNbFKoWLuAyzw1RYdL4HhCpbSw
         mjvcknQU9s5KFGe5ogulxhG/URfCnZ/Ak//ITRiLsW6DsHoOQsR6xIJ2S1bf3pZ199aO
         NxL7NqLuLyTQKxURqscKEKRq6/ovVAxOaKKTQGKuEGuHtnJifmSmSsHGXYeGKhQXZwnP
         c+PiiU2Pzr1Y4/mjMuxj83ElalK6bbHo7Ea2tE75nWkQfu77n8/TxkWfHwaQh8CZLNa1
         r+Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LQ37hPvquQn330cxCo8SGW3/WEute1UfVq1UF21kzCw=;
        fh=7rHMuD/zzN5a2+uVPCwhQxE33SKbG+1zfKojbK79O0c=;
        b=QP6GcGaoItxiXwwzbpfEMmHaORPrLvHFm0LAcBttQ4cfGFBpN94Q/2acl4DPz20kko
         4nCFkW7nUrs7EOGKiNeL1K9KXtUMn+RgyMmbn3EeWca/4ZFW3HhD/F9pntAiC4Z2jZVb
         mlvQYh1O1AGaAR1+lWHGNVQtYR+RwHNpcOm/IE7JjpxwAMpZUkeQadoMdBMOpB6/TBHc
         HIq9BBVxi2mEyMp3BBlWDygVDFiitlA9eK878RA/Z1T53SojlyPqigV+0AZP43AVDRD8
         8R0C+t/eAYdstgDuUaEJMgnjEBY1piC5mgBTnhBAhGKw8odHR1wNYFUK4a9Eooc1wj89
         xFbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793291282; x=1793896082; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LQ37hPvquQn330cxCo8SGW3/WEute1UfVq1UF21kzCw=;
        b=HjoSan8/zv52FMl4OuQXuVzj8JTJSp6j9wKD5+65byXrynFR74lCdsAoDxVmdJnPR8
         WxAUUtKnd+gjNA5sOV5pXkj2by7gF3+iblhP61asLLJB4/4+wts9YTkkdCV4957ZeCHt
         E1enKaP20QMf6OfBEz7aqGsjn6T9AdjP4v9YDb6oNq3Gp+uplfQGUq15z4L4F045nPbJ
         jeJDzp+zVlw+MTCCUI1sdxUPw615ahw2d+Oc0ET/gwIaRcihtqmjObXsEOrGgrXZaFgD
         yWkl9C+5I8nmx2S6p1XpuIFLMFlAJXB7vNcRcDi7hj0dWi4DdrWXmIVigfIFxDmjodIS
         OTzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793291282; x=1793896082;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LQ37hPvquQn330cxCo8SGW3/WEute1UfVq1UF21kzCw=;
        b=TuHKrmk6XIA6VcXLTCpTKl49wXlG8DoeOVKXL73g0JK9TxFmkS/osbi3fRWcXsm5xJ
         1sxH/VCXXHSTxDB7nFZoKeYqxSyOhWNVElcgGNN/OWD2c5HVVmTzNpCobBhJrt8GBeq+
         dRWOsw1K+vTS2nTc9dyU8WdowSompXN66yH+9dwSaBLk5UWN3Dl/QbjGPU4s1hI9s5WV
         eFGvCm5chZkzMqYHic/k3cekQLpfwSPehsnd4CuPW8eCUMKuugXg+guKoj0xDZjzQrQF
         Hl6Sj2pd+2kdHhmJHCdzSvsi7d0AHAPhiDoTK/ltXmNBVogqxntT6RfPDm74ePm0EXt1
         cpPQ==
X-Gm-Message-State: AFq9FYLzl9i6hj3CdVivLw7mPVzeewEck4U/eTaaDSaTE9rEx4OI3SZ/
	1XMp78CXngrMkA/5GlElWZARCx2OTryNFJYC/PIA+WlCDMd5eI9EIPXmkKC/vFmhY96XHBQGEMF
	deL1frq2twcxt/LW5+P+7NMVzDQHZPLY=
X-Gm-Gg: AYBFou0Niazmss4NLa8n+n3UAKNcAkvSSavMnHCtYLwtVi/Wp5oR7fmxROcl5LI6cJC
	pyU3Juz0sP1vggD6oIV3957CjGQu1RiBBKg3vYR+cC+98zLZtI29SiFdbSGwg916WWtAQzBg7JF
	ArOR8DNP2fM4PhxGQcN1fTMn4kiu4BHUfQpiCfabZayrpkikyX5jnvgsu1QlyHCw76N4wrjITyW
	OJHjygRUgE+6DHiASsk34BpbDJDS5WbcM4zI0JAphn4QG9UA1COjLJvyD4zW4kR9wAN9FvkfLkO
	QKO2JGRipNRJ1IOmp3bTQhrGtlNLfnpEGO1mFcFf1bYcBb4GKcs1SmrzB+iOE7ClGjwDOWJvfPf
	SzTfU2INCaJ34Vu08YhhefnKvfYT6NocTzP9e/I4ZUC8AA9ZjHDOZARukoaoMRcfhqnH4ryLPx3
	z02w5+1zWHcd/JaTXaz8IpVaqhTyfZ+LVC2ErDl53KMM0=
X-Received: by 2002:a05:690c:e3c9:b0:8b0:e680:6157 with SMTP id
 00721157ae682-8b1b5d0f2acmr47617697b3.39.1793291281718; Thu, 29 Oct 2026
 09:28:01 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029023235.1280321-1-cochcoder@proton.me>
 <20261029023235.1280321-2-cochcoder@proton.me>
In-Reply-To: <20261029023235.1280321-2-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Oct 2026 12:27:50 -0400
X-Gm-Features: AclHuK-NgM6Qw5Y3C2mGCjEAWYJbcX_bTgC3W0mleGrwBRXFkQrCU6Q6Z-A3hJw
Message-ID: <CABBYNZK7wGJwAsVLWNhLfLXqGLtA-gtj9ZLYww20FpVL0Kcobw@mail.gmail.com>
Subject: Re: [RFC PATCH v3 1/1] Bluetooth: btusb: test reported maximum LE
 length on TP-Link UB500
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Wed, Oct 28, 2026 at 10:33=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> =
wrote:
>
> The tested TP-Link UB500 (2357:0604, RTL8761BU firmware 0xdfc6d922)
> reports maximum TX and RX data lengths of 251 octets through LE Read
> Maximum Data Length, while LE Read Buffer Size reports 27 octets and
> eight packets. The previous RFC demonstrated 167-byte HCI packets
> with unchanged LE credits during ASHA playback.
>
> Use the reported maximum TX data length as the next experimental host
> LE ACL length instead of an ASHA-specific 167-byte constant. Require
> the observed 251-byte maximum and 27/eight buffer reply; preserve LE
> credits and BR/EDR fields. The maximum-data-length value describes
> Link Layer capability and is an indication to test, not proof of the
> physical HCI buffer size or pool layout.
>
> A direct HCI user-channel experiment sends sixteen whole packets at
> each HCI payload length of 27, 167 and 251 octets from UB500 to a
> MediaTek receiver. All 48 payloads are received byte-for-byte intact
> and all 48 HCI packets complete, with zero pending. This establishes
> 251-byte HCI acceptance separately from the reported Link Layer limit.
> Only one packet is outstanding at a time; the experiment neither
> installs the revised callback nor streams audio.
>
> Keep this a TEST ONLY RFC. Eight simultaneous large packets, larger
> HCI limits, mixed BR/EDR capacity, other firmware and sustained audio
> with the revised callback have not been established.
>
> Assisted-by: LLM
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
>  drivers/bluetooth/btusb_main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 92a78a7e6..b654cf5be 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -2972,6 +2972,19 @@ static int btusb_setup_realtek(struct hci_dev *hde=
v)
>         return ret;
>  }
>
> +/* Private diagnostic: test the reported Link Layer maximum as an HCI si=
ze. */
> +static int btusb_ub500_test_post_init(struct hci_dev *hdev)
> +{
> +       if (hdev->le_mtu !=3D 27 || hdev->le_pkts !=3D 8 ||
> +           hdev->le_max_tx_len !=3D 251)
> +               return -EINVAL;
> +
> +       bt_dev_info(hdev, "UB500 TEST ONLY: LE ACL MTU 27 -> %u; LE packe=
ts %u unchanged",
> +                   hdev->le_max_tx_len, hdev->le_pkts);
> +       hdev->le_mtu =3D hdev->le_max_tx_len;
> +       return 0;
> +}
> +
>  static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff=
 *skb)
>  {
>         if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
> @@ -4715,6 +4728,9 @@ static int btusb_probe(struct usb_interface *intf,
>             (id->driver_info & BTUSB_REALTEK)) {
>                 btrtl_set_driver_name(hdev, btusb_driver.name);
>                 hdev->setup =3D btusb_setup_realtek;
> +               if (le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0=
x2357 &&
> +                   le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D =
0x0604)
> +                       hdev->post_init =3D btusb_ub500_test_post_init;
>                 hdev->shutdown =3D btrtl_shutdown_realtek;
>                 hdev->reset =3D btusb_rtl_reset;
>                 hdev->hw_error =3D btusb_rtl_hw_error;
> --
> 2.56.0

Sashiko flagged 2 problem with these changes:

https://sashiko.dev/#/patchset/20261029023235.1280321-1-cochcoder%40proton.=
me

Both seem valid to me.

--=20
Luiz Augusto von Dentz
