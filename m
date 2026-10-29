Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793236894;
	b=5UnLr2yIS54woJxFGMKUYlGM7mHegs09XFSBQwXejNb5CWRb1CZTiEl78aFBidTkXdof
	 HXbhhu0kM/E+IKyMqmkgdFb1AxYK8wePaYgCDo6nJ9v7oxgVIE2FYtbbIWZ/ozoPTDY6a
	 r9cV/t1fGy5RNmgq0f8tBM8o4hUUcLtkwK4vO0h6gzsmhiOeitx436IFIGLXUZFbNfMHM
	 ahzJNb94IND8VepCWPMeg2HgeDOoaApR4g7ZEYYVjvBsHTt5XJbyqgXqfVIqwxpsaHI52
	 FNGE0FSZNZ6gZhzLrTGAMdB4OXMUhIwI02RZMsaaqa7WBuRBQ/gkk5BD53q8yAPJiUQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793236894;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=Rnnlnm9QbOzUFhPGhE2nJOVIwlLBGc5RigKMKLFD+10=;
	b=gLiMlMTQzW/SIfobCNiUbZELsQ4LWn7gD3IqTDiLSBigni+PXfpQEMi/HNpFWIfMHJr+
	 QaufjFZn14XZ8OILnlbH/4lt4A6mO94w9XnL8xBRTf1Ne5ODLpDjDZt1TTKIJ0tSjDD4t
	 zUd9x0cra0+gnXYudYVxRFxdLnTgjKPPYfoVD6JfyIoS8qh7YIBLYgqD/jw1EOI9nBCsG
	 uay6JeJrO0wOAzQXL4/PoCzAMquFofiFtD56DB7cGl2Fnumdr0P6lg/cSgJ7jXPqs2S66
	 vkeS2rx0fkYSNw8EYmiLP4RwCjjUcw04bFnIUgX0oVExbsCUK39DoGOJxcOE3hqsbvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RzE7wKCZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2376C606A31C
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Oct 2026 01:21:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2376C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RzE7wKCZ
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8ab43af5e97so3125087b3.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 18:21:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793236893; cv=none;
        d=google.com; s=arc-20260327;
        b=q5e0SDhn3+Q0SZMM/BHA4OiUesaGxrzyMkzMSlYqCNfF79yC4MVDpMHj7GpScwTqRP
         Iab6U5huDVlIVLc+8+oA12rpzg6rDfCVFqKtzGcGlfNuQ5l7pXUn19FH+fKqsdAfMpyu
         UICpknTsAVlpMvJCXNgjDw93bzM+sIt1zikDg7VldyrQ4NuAwI/x149nv0tQZ2f4tQ8j
         trBl4OQyNAmxZCuuI5uchRq6NtZXQ2Sxsc/fYcYmBtWecATQ13oJhxpPq7btQ2CDabqm
         P07OsGAPQKf3A8poxUG+FUsJNXxP8KKyVJlJuogsSi9xHJC6l6mjYpXl+WbGWpmNlZFl
         dg6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rnnlnm9QbOzUFhPGhE2nJOVIwlLBGc5RigKMKLFD+10=;
        fh=7rHMuD/zzN5a2+uVPCwhQxE33SKbG+1zfKojbK79O0c=;
        b=hMGcO7rF5o3CfE4YBiGGpCGdnfTo8K1rugSyIN/uwJL0BFPIxcqTgyyz8Gdw4Uxthc
         taDJaqFRa+uzKyWeWnyiNJUSU7sHo+V9kxCTl/jju0YEvgsrZeJG7GGS6nklH//NDarw
         Dyy1pR/Bd37nN03shUpe+PVW7NA1F3KEqBLHMHvP3rfNd8WOi3kDTgW0TC8zl9YQQN6R
         4STVfT431Slj5MzvYQj8EpQtcgevpcqj6vRHty9zSqbLN8RbVhFWI1GFnjXFspab7aXP
         v1/CarXkkLKy49s9GFJuCCGrUOADP1+OSNv1ouxEIKPr/i5VvzrtOxc9hBFs6F3tE5Xo
         bjbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793236893; x=1793841693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rnnlnm9QbOzUFhPGhE2nJOVIwlLBGc5RigKMKLFD+10=;
        b=RzE7wKCZFfIARIPFFqduXiJ/xtizECR9afk/A4x3sLYn8gOYpQy6b/LIP+Fk+IBgIO
         1eu9mn4cXgM7Pt1uiNikgwIfE5cUa89qAAHkUF4A4vXXr4kGxnqyBaxyquNAc/s4+5Tk
         FnBfIwSwExMD1F429Yfq6yVcDAE6mrAnAclRHpPYltXmpqoEACOKp2YctjSmq78cZsHe
         g3DYmOGfaQf8QC8EjICAXSo9eJZPTyyhVuyoVVgKESoY/cu8JbnJj0pqcsswjbcAcdSG
         wOg56dLEtokkpmdBSZMv4vdBxlmyoEc+8m1ZmsLTNIyqn6xEUw6IaJpAaisU5vdWt6sg
         CGPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793236893; x=1793841693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rnnlnm9QbOzUFhPGhE2nJOVIwlLBGc5RigKMKLFD+10=;
        b=03NvgJjrXPMK1feAIFokJuwW5Bl8m9U2XOX3hQ/nyxNzbIXLJ6avEtLWieR5iKniI1
         XrXubJfK8/vqHqy3mMfTsIBZiw08S+Wf9C83dYC71fFKG31ltPQB3ehZPUsEmbQ2OqRq
         f+N39QKM4fQgWstwrIIZLnG8gDhOwWwX3FE+cDVAE98yOCsk4syLQdL8bPvfNUpGp2UX
         8CMcdmcMjoIHG77+20IQ672eOcaLeypEp+NbKU/3x6c1hSkBYE+skIbOYmVh4uzZaW6L
         27Xud2TFJ2VHLiq2VCLOc9hN/xt8HMBhTFCkb8XG49QEFEBpwjeJ+EiiUoF5P93HozVr
         y76w==
X-Gm-Message-State: AFq9FYIQ9UDwLcmR6r2JTQa4zbK4vhLoLYJBIwnNKsc7SGSiZadncgpb
	KshcCyLZFjiOiVam3JLpIg1KMaeshqRhqT2cJ7N0UipcC+yRViUJs6MjpWo5U3orQqvWsEAp2JX
	TSAO5mCBqN6gQWhHz3paRwOwvXfDwJrA=
X-Gm-Gg: AYBFou3Pl6cMZOUVURnpJW70q/IUZV5vRxgBZ7WGC8za7aRRgCkUCPevj+MdypyzvA5
	zTnwxmsj0lbXU5PFR8E4P9jxT8nWS+qGgjNlkF+9YSf4+LWObbkwgH+XFlQPFQ777vky/EjisDo
	r+XJaONDmlrQ929O5ZsaZYHrXk4bzqi/fWN2Y355n9Yb8CQoHWCJBTTav1EYaA1VF70M9bcpgG1
	3kaenYdm/z9pbY2ZKcpMHrDrpdeYIzW+uWjndCKP1ptsOMHHNZ2Vk07kHl3Z9lL1h9FB/rU5O55
	0Nx+hLYglpSOJnab0f4f+uT++2Dr0+c4WdfkuQ1EcAhB5UQC14iH2IdYVb/yKIPu3HrB5DDoXD+
	AwUkWbZEbqFDfQ2GeTYhzYmGmNu1G/yNGWDNlXDguldnAlW66RObea3HSxH24FgIXTx08Lcd79b
	d/nr0ZNLPKyQ3xBUU2mp2MpRbJIM4K9HQ5agcbv8/3qA==
X-Received: by 2002:a05:690c:e1cd:20b0:873:5c7b:c13a with SMTP id
 00721157ae682-8b1c68bc542mr6313507b3.34.1793236893060; Wed, 28 Oct 2026
 18:21:33 -0700 (PDT)
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261013032742.497402-1-cochcoder@proton.me> <20261029001349.1031535-1-cochcoder@proton.me>
 <20261029001349.1031535-2-cochcoder@proton.me>
In-Reply-To: <20261029001349.1031535-2-cochcoder@proton.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 28 Oct 2026 21:21:20 -0400
X-Gm-Features: AclHuK9OA0TxC5wJjdXKN1qLToHFtxzFnXDBFSFw4UfMSYDfsvibt7iWShSwHz0
Message-ID: <CABBYNZ+wc98wyH_rcuVZUTjy1neDb7tDr5mvCsn3_jvY9EPwug@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/1] Bluetooth: btusb: test larger LE packets on
 TP-Link UB500
To: Kyle Pepper <cochcoder@proton.me>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marcel@holtmann.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kyle,

On Wed, Oct 28, 2026 at 8:14=E2=80=AFPM Kyle Pepper <cochcoder@proton.me> w=
rote:
>
> The tested TP-Link UB500 (2357:0604, RTL8761BU firmware 0xdfc6d922)
> reports an LE ACL length of 27 bytes and eight packets. It accepts
> 167-byte LE HCI ACL packets during ASHA playback. A size-only test
> streams clearly with the eight reported LE credits retained, so the
> previous shared-buffer workaround does not establish shared pools.
>
> Use post_init to test a host LE ACL length of 167 for this USB ID,
> without changing LE packet/credit counts or BR/EDR fields. Refuse
> unexpected initialization values rather than applying this diagnostic
> to a different reported buffer configuration.
>
> This is an experimental RFC: 167 is a demonstrated working length,
> not a measured maximum. The appropriate general limit and firmware
> scope still need confirmation. Mixed BR/EDR and LE capacity and
> exceptional-congestion behavior have not been established.
>
> The ASHA 7.2.9 trial completes all 3269 HCI packets, including 3243
> whole audio SDUs, with a maximum of three outstanding packets. The
> human listening verdict is CLEAR. PipeWire and its actual 4608-byte
> socket send buffer are unchanged. Increasing only that socket buffer
> to 8192 with HCI length 27 previously crackled and underfed the stream.
>
> Prepared with AI assistance for source, evidence analysis and text;
> hardware playback and listening were performed by the submitter.
>
> Assisted-by: LLM
> Signed-off-by: Kyle Pepper <cochcoder@proton.me>
> ---
>  drivers/bluetooth/btusb_main.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_mai=
n.c
> index 92a78a7e6..2b955ed4b 100644
> --- a/drivers/bluetooth/btusb_main.c
> +++ b/drivers/bluetooth/btusb_main.c
> @@ -2972,6 +2972,18 @@ static int btusb_setup_realtek(struct hci_dev *hde=
v)
>         return ret;
>  }
>
> +/* Private diagnostic: test a known accepted packet size, not a pool cla=
im. */
> +static int btusb_ub500_test_post_init(struct hci_dev *hdev)
> +{
> +       if (hdev->le_mtu !=3D 27 || hdev->le_pkts !=3D 8)
> +               return -EINVAL;
> +
> +       bt_dev_info(hdev, "UB500 TEST ONLY: LE ACL MTU 27 -> 167; LE pack=
ets %u unchanged",
> +                   hdev->le_pkts);
> +       hdev->le_mtu =3D 167;

Try checking what is the maximun data length it supports, since that
is a strong indication of what the buffer size should be.

> +       return 0;
> +}
> +
>  static int btusb_recv_event_realtek(struct hci_dev *hdev, struct sk_buff=
 *skb)
>  {
>         if (skb->len >=3D HCI_EVENT_HDR_SIZE + 1 &&
> @@ -4715,6 +4727,9 @@ static int btusb_probe(struct usb_interface *intf,
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
>
>


--=20
Luiz Augusto von Dentz
