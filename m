Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793296340;
	b=eVA5FYOnBgfY5KGOEE7gBQO2iNs+M76MZrfl30BA82QJB3MMmKeZe8Bbis1SDVeAytmO
	 KTK0PrTuv92bafaLsiuTW2LLNfMB5o838Omx3WH991InMxXBicw3m1BFBnnyJITr6FMrX
	 9J6Zc441ShnRweliJK3XrZkjWUHzHoX5rpJCFLrTjDZEw3fzXAEQ/rHLJtvwwWtypwFke
	 tc7BGH88HjmOSYhV33yxXfXS7px4U12IIV411ShgY43T60nRmvDf7xweSji9m0wDzb41d
	 bCOEvNwDsaRZ2mr+UOeKkQ3gkZMKZ4pf4dWhKsWvoZkxQcjbpZhK19MReDE9WYlN5ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793296340;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=eHP3lvMyfxaZ/g2zhWAD3Ce4Z32+Q1vfa0Q0vH3pw04=;
	b=afExW1AkJCV6rYHEIB9nx+js5ckxmTCVC8zQMdcoxU7cpjFbJ4cn/PjB18u15B/5RCiG
	 QYSTuQxfARSdP5WLX4JfsPflu6QHxZaOmxM7FR+xJTr0e2NBZBCcTGCUXGrdFlcM/NnZV
	 hEroQyLstIavukbYGvLSE/26c+YCdB/YIrp9ALez/Xl/f8RFB+v3Ix15XzUgHuZM+cwxY
	 dT2MoXhsvyzSgxex4R8jASyQ0LOt1J5DCi59VCIIPyZps/eYgMQWAlKyaWPP8j8HjqQi8
	 /PRPp39S4QYhBl8eiuKA9gZ9o9pvwOiSvFTGv1gBp2W5FeDNk/ytqwMYjv5Zph8GiVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rGWzaHLh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1CC606A31A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 17:52:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC1CC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rGWzaHLh
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8ab43af5e97so13275707b3.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 10:52:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793296339; cv=none;
        d=google.com; s=arc-20260327;
        b=EWqIl9TibwBl2cu3FoVR//u9BVMfL2JTswLLu5kA4p2iQ2s/OqIpCflPajTM9GXQKi
         y6+NiHA/iiMtfXNiS5QKUIVnLDKGcFio/iYtmDETqbww16W9xxwFDVlqFhXfXjRTh57H
         S0qooBhVhJyQXycHS3KaSWTmahrm06Pr3pLi1ESN5NgZeZ9AZHZjgCx9MJbq1pu/SRGb
         SlS0xkXKBwxEz8/WGurgru++XuEiKWj9D7jsEmP3un39zh66vVODath+dYnLXA05EHvS
         EMAdgkn9NGKZ3AnOQRrgznjxKil8KQBnCIoLbxQ8cIs/n78wr3MWyMWMB3jV1QFy3BXz
         geUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eHP3lvMyfxaZ/g2zhWAD3Ce4Z32+Q1vfa0Q0vH3pw04=;
        fh=7rHMuD/zzN5a2+uVPCwhQxE33SKbG+1zfKojbK79O0c=;
        b=GAVc118iMfPnp+q9J/otx06QFcYe+3Ib+nSEvcjyOF/oq0Vqhobm3K9CI2eGxKK/YA
         FzZ+o3mlK7updfX1GUzNhtioqUvLPLZbDH47lfrZAlG2pLp8Jaxt45fAv+gu0M1IZrmV
         1V0aiQd7I2XvBng8yWVoUre1uexZoHna2UgtKKaFIVugoUXR/vCFu+0a1GMKfr+dzhBN
         h0VnTYvYW4Xck0hrMWorkuvtF5sqKPL05TH4GFwFkKZLMd9jbARun66kNqEBJGmECMNU
         bZBApj17sN04sIzKwI0fhZ25eCd4eEfvAFUvJXSe7BC8vgjeeexw+1j4RLYV/20qYBlx
         d+mA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793296339; x=1793901139; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eHP3lvMyfxaZ/g2zhWAD3Ce4Z32+Q1vfa0Q0vH3pw04=;
        b=rGWzaHLhZ+uZelfho7rPr2TNRWspkDvfbqXDyKACwdP7zzXuHyyhCz8IQw/vO5rUW/
         QIg+lN6dl8+izCHFwmzKsXAIJ+9ZrE/ziz1DnNZWcg3muFkJCSOy3z0UJg2sskvAIYnd
         h1LNejdmKI9b13MzKV6OHsEKtkUrKw6A8PcB/rGXMjGwl+T+ZrMK98fXb0VPIMetLqu3
         Uq7Q7rOv3qP1LfC3sd5Pi40Ua5rqfjS9NhVM8Z5IJ7gyylvIaJKmACaq090qKt7qCfHu
         2FnXq+toQwW8C2yGXJ6qICrg3yOXwEtiwA/+JXCzVsnCVzRm324vbMVcPZVejsG7auNE
         lE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793296339; x=1793901139;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eHP3lvMyfxaZ/g2zhWAD3Ce4Z32+Q1vfa0Q0vH3pw04=;
        b=AcE6//2mmf+li9Z4enAwD9VQGrvwazY67+eQauilum4H3oMKtmyMbbnJB3XTmmK0i+
         UaO0Qj/y08aq+qesrj7lwN09W6uX28N2zZNXgLsPvuUHkefIqQ7WGDm+Wv9czlSpzcDL
         wI1jc/yljtudHrhNagA1b9YMx9ItFMz4Ks+pyS0xTVEszgX8ulm3Ffbak37gYXBooLxe
         8BvezutbiBHxZ0M2huONaWZIlIRs5vFYKiOqLQh0+xCWj6y8Ge+J+fz3DHjSTs8MrGnD
         AcFWiXaUoS3zli2ICxwA0TjoPFu6gXEH6aZzPnmdr3LGbmIO9IZh5FlapayyAgswnW9S
         14Jw==
X-Gm-Message-State: AFq9FYJqDTHck/WnQqdLBhg6TtmijZsfTLLbVnRBsgSAeZwshfH3XV4M
	LoXGq1bs9Cjmy3zQFnxtqS8o3f7C8LRTuvMZNbaOcPBCVWpU41by0/pjYZy7tPwnAmbfV0h+JjD
	KejRzDowzxPp1bOdA6zGOdl61xNvLIHJ6LYe1
X-Gm-Gg: AYBFou00+BrMw1v3dRZ5XSiNsP7neGGBel5M87iIDn6r5coLTnGFspwO/OMLPTL7lse
	LKiSqS54gK9yVyh8ldfo4h6sloeDNxP0NkiBY5EAaLs0iE8la090EDMsMKv5UbGESj7OaTx49qx
	tzW+M4A6p6OAAJx8DibDZ+MyeHL1IskcRffY+c2O9BbZApT3YvhR08PhUe3ubtUi+i47szF9j6+
	53CxrsFYSPz1RyOFo0zeVSmpgMgP7Lu3XMRKa/xcxfvPxXSR/ky1buO0DRbC0JrbEc1vMCNAUzu
	Mj+X7GTvYlP8skIVBTeO7sOeOkdpQCbdkm3VB5/RfPo8PbkXJ1H28uWnDVaOkOTzBIwZvq2Ucbq
	z4HgZnsa9d4S8J8FsFAHwP8zLdDfkpfz2NTV8HsaKGq9ho2ONvEykkkkSe0868XNTsMLSreneea
	ZCN6wIBdERUSP76/w4hZwZ
X-Received: by 2002:a05:690c:5886:b0:8b0:dadd:e578 with SMTP id
 00721157ae682-8b1c666e70cmr20250337b3.30.1793296338953; Thu, 29 Oct 2026
 10:52:18 -0700 (PDT)
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
 <20261029023235.1280321-2-cochcoder@proton.me> <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
In-Reply-To: <7136cfd8f427b90d6d931a836e93dad5ea6164a0.1793296023.git.cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 29 Oct 2026 13:52:07 -0400
X-Gm-Features: AclHuK_Z5kTgop7vkeCslSF8nnLPmWeBsUMQ__mEMwL9udeL-MYLK_9x5od5VpU
Message-ID: <CABBYNZ+HWvU354tNkZmaHSdYZ_OF5TXFjL-_u7k-7Scd8bRkFg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] Bluetooth: btusb: support larger LE packets on
 TP-Link UB500
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Thu, Oct 29, 2026 at 1:47=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> w=
rote:
>
> The TP-Link UB500 (2357:0604) with RTL8761BU firmware 0xdfc6d922
> reports an LE HCI packet length of 27 bytes and eight packets. It
> separately reports a maximum Link Layer TX data length of 251 bytes.
> Direct HCI user-channel transfers verified intact reception and
> completion of sixteen 251-byte packets, with one outstanding at a time.
>
> Use 251-byte LE HCI packets automatically on this device when its
> reported values match. Limit both the initial LE credits and their
> refill ceiling to one, matching the verified number of outstanding
> enlarged packets. Leave BR/EDR buffer fields unchanged.
>
> Skip the override when the reported values differ instead of failing
> controller initialization. A different firmware revision can continue
> using its reported HCI buffers.
>
> Assisted-by: LLM
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
> v4:
> - Skip mismatched buffer reports without failing controller bring-up.
> - Limit enlarged LE packets to one initial and refill credit.
> - Submit as PATCH v4 and shorten the source wording.
>
> The first two changes address Sashiko review 219856:
> https://sashiko.dev/#/patchset/20261029023235.1280321-1-cochcoder%40proto=
n.me
>
> Validation: baseline and revised btusb_main.o compile with W=3D1; strict
> checkpatch and compiled callback regression controls pass. The earlier
> raw-radio capture verifies 48 intact payloads and completions: sixteen
> each at 27, 167 and 251 bytes, with one outstanding packet at a time.
>
> The Link Layer maximum is not a measurement of HCI storage capacity.
> The revised callback has not been exercised on hardware. Sustained audio,
> mixed BR/EDR traffic, other firmware and exceptional congestion remain
> unverified. The override applies automatically only to the matching UB500
> device and the observed buffer reports.
>
>  drivers/bluetooth/btusb_main.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 92a78a7e6..b32d3acc6 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -2972,6 +2972,21 @@ static int btusb_setup_realtek(struct hci_dev *hde=
v)
>         return ret;
>  }
>
> +static int btusb_ub500_post_init(struct hci_dev *hdev)
> +{
> +       if (hdev->le_mtu !=3D 27 ||
> +           hdev->le_pkts !=3D 8 || hdev->le_cnt !=3D 8 ||
> +           hdev->le_max_tx_len !=3D 251)
> +               return 0;
> +
> +       bt_dev_info(hdev, "LE ACL MTU 27 -> %u; LE packets 8 -> 1",
> +                   hdev->le_max_tx_len);
> +       hdev->le_mtu =3D hdev->le_max_tx_len;
> +       hdev->le_pkts =3D 1;
> +       hdev->le_cnt =3D 1;

Setting this to 1 would make transfers awfully long, as you would only
be able to send one packet at a time.

> +       return 0;
> +}
> +
>  static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff=
 *skb)
>  {
>         if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
> @@ -4715,6 +4730,9 @@ static int btusb_probe(struct usb_interface *intf,
>             (id->driver_info & BTUSB_REALTEK)) {
>                 btrtl_set_driver_name(hdev, btusb_driver.name);
>                 hdev->setup =3D btusb_setup_realtek;
> +               if (le16_to_cpu(data->udev->descriptor.idVendor) =3D=3D 0=
x2357 &&
> +                   le16_to_cpu(data->udev->descriptor.idProduct) =3D=3D =
0x0604)
> +                       hdev->post_init =3D btusb_ub500_post_init;
>                 hdev->shutdown =3D btrtl_shutdown_realtek;
>                 hdev->reset =3D btusb_rtl_reset;
>                 hdev->hw_error =3D btusb_rtl_hw_error;
>
> base-commit: 1081a6ef8f1e0661fd52eb3f878691b0b96cdff9
> --
> 2.56.0
>
>


--=20
Luiz Augusto von Dentz
