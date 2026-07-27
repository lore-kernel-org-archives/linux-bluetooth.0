Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443741A785
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 17:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785172905; cv=pass; b=PxaZrHws2wUPSztvpZaARtWDTDN306TiVr76K4mR/NFD0Jr7Lavg+MHbPLbMWHqr6qqmRiZ4gWDPCPSSNsKRTQE2xHwQivWuZaFOLzS9VxjJowjxpjK5f8NIIxwojXRJZvu595bxUMMfftgFCOandvXIdpyzCNFaCuZU7ixqkRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785172905; c=relaxed/simple;
	bh=/OlJHkWfYF/y6FdxbbaVaSNSpk3suWi9b8n+8YLmdiE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OPNL4b2QBgxDlniIZMyPo8bmVB9Fd3pX1CoheK8I7sO7JBqHVZXG/wViWjrBo8THJ6JVda1qeyNgojSCbuMjM+Kx/9Ly6cEoCGRet4lF1JnDAV1kXQNMGmMn+oMRdUyjnhUKr20U1/i9Hb45nc/uANb9MDpPjSMdy1S7CbvKEBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lK02m2yx; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lK02m2yx"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ea0b7d137so15270387b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jul 2026 10:21:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785172894; cv=none;
        d=google.com; s=arc-20260327;
        b=oeGjqcr/MsB9I3myR4mMPambXsglS83J0uyPRK666l+FpfmFYDuJo/FaACGsZuiJ2c
         sBHgmYTCCZ0F+wlEFLDIlIIF9N0vEQ2G6qv1PNAw1zI+qhQlPkOnGyNeWppy84oW9q4K
         VlSSuLntDpvZRKAzd6hgASHhL2384Ckl0Q7G4bFCX3OYGHxpUyudqquGq7uUt0Cd3Pz+
         giDF5ngDC98jsFTZjb2EijjXOatO94gbFf4J/MxdIIg+mZ5davhwVKyG5Dk8tFiLcrQr
         ffzNqijDiLpVGLDZ7+ULyP9YG17s1sjN5SFyMcDktFq4TYhUTboVs5dzhR3XjHIcB7oy
         3JIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IWagZ1KbZeimnW0//U8jwkw9b7RdjVqStQQ+1lOm89Y=;
        fh=LDhnYwYJwGDKDdSgfq9SOmOV6jOo8bx4Qddmo8lE9ko=;
        b=Nn0viHYV8feOLJs64j+VO8T+QGhbPdBcC+nCuuYZpX46LKVm9S9lUEJR4sAvqMc0ei
         JfhukKpWwm+pdR87Rpb5dw2hcit87Uht1m63Mw2S2DaGzRAqRibJ9KKACjRkKcvTEV7f
         UcLJd143E2iuz4tJJq264HZWufjeS253pnBaJuCci84tJAGfluu8qy/dc30kvErrOZJ6
         NWxOJVe6Q68iXs01nIoZJDP74iYicd/E6w+RnjGDgepv1Z2KrYWP9CA4LpBpWgbTn1iK
         F2W2/4SZj5iCXRxEbHtJsd9TIv6Asd7ayiTVqDzSWwHYAju8g4yDnNfOzxXL0DcSdJHd
         5lzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785172894; x=1785777694; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IWagZ1KbZeimnW0//U8jwkw9b7RdjVqStQQ+1lOm89Y=;
        b=lK02m2yxe06mJ1xjEG1oBnSa8aT9Dc1D7bZ2QPoysO6rfGRkHJPCdho2b8tTrpYEEy
         ZFEEj2S7uBGvwxircCu87lmkmh6+KeUkZgiCywMepSxIkPSNv1Gb0N0KalDJ/wWGgJF+
         Pp4gPgpy20FoJPB87X89ZfLPyjip1XLvrMXuasmI33g36vZWwO0Z/4yG9E0hpfjrATK6
         hyfPAmUub3kdeAT9DZffRm8xlXJ02JNh8unmVibftYRziz76n020q90IPlbrNNgPnsxs
         IYquFs54gSuXefwDYoAbGuUQ4ha66/L+JtfWaCNauKq8Ceo2vA2A80mcNK3+KnISAj3E
         O2wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785172894; x=1785777694;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IWagZ1KbZeimnW0//U8jwkw9b7RdjVqStQQ+1lOm89Y=;
        b=PWdZL8IKWZL+iCqds3mJald06LkXg7khhYViDdfqD5RF1VbGoNrMQYzyh72kwN0pGG
         I0a04EfJ/+9ztU40HZgyQ7ZZD6Bfi9NIBtwfT531wUTXf78TTWpVsSW625Uag02w7Zw4
         tgOAp1+No36aHjVF7QeIxnqojA9YgzdCsk9hkNzQPyUXeHz1gHamS4V7ncx+ExTTmQ4P
         UEbDnF1G4TI6HfHzaLMrbmKBPAdod1Aohuh6VMZ6LVwX6n1e4r00P7zB9hgiSAZ3DcmO
         adg+KvxYEi5zNlT6Y10cgmehaIRTkJK/6qLqCpxSKlaTTnNA+Qcgjg8WtcomeXlZZaCh
         xdvw==
X-Forwarded-Encrypted: i=1; AHgh+RrodjVZGJ2JOs/LsbtiPuLA+TlVR36bzdUY4Abc1x4ZDaQozSzL9lUf7LuXB/+AFTBxsI0350CFVXxT2ErA9LM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBl0slugqvPQf69s0/PZ0NL02oZRWfDe2FS1UfqKTUzn21YE/n
	BPPNNlydejYqTWrdSISQi8pErCrXoREjSM/fLzmwbgdaJW8EbXYPVkO/oe31EUb9QYzUp7SxTby
	ka2KyFJJPE3R/QZgBUs/+Zrq3ERBoDgQ=
X-Gm-Gg: AR+sD12dujnPE453O5PIOy1ds9wwfGfm7npdl9tM4XVNDmvXsbEd9Dq4pFrIXACExxk
	0SjnCC7QvWnqkiQZeJMvdQ2iZhgl5WANpKRlRbWQl27htVTsei5UI10ODJc5DM1oGooznMDtXMh
	chD8q92GdDj7xAtiAqiXQqG5eHmOE55Tnu9RCGbiGSRypoIiJ9uTrvgRa+FVxHzOu3HiuGI9166
	IZ3S8uCBczPlhinJXT9k92At3DmCzD8ih7sp1t9uwUVCPOIUNYkepLC+6FJlj+rie4tcxDIOFoG
	IVBQVFiHeBuZjq08w/yUy5Y0Sxhu0Vu0BNkMH97QnTi5AdahIiH0
X-Received: by 2002:a05:690c:620d:b0:81f:64e8:d86a with SMTP id
 00721157ae682-81f69d399c0mr31522467b3.30.1785172894127; Mon, 27 Jul 2026
 10:21:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260725-generic_fix-v1-0-305aec261a19@oss.qualcomm.com> <20260725-generic_fix-v1-1-305aec261a19@oss.qualcomm.com>
In-Reply-To: <20260725-generic_fix-v1-1-305aec261a19@oss.qualcomm.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 27 Jul 2026 13:21:21 -0400
X-Gm-Features: AUfX_mwJcOFOXqeHADZJ9m4hcmLxtRdT7-NOb1xYl6rPEzPxu-MDrJO1mE1SbxU
Message-ID: <CABBYNZJEn7iF6jrdM1tWpGd4eQQYx2qvKF9SQ5W9MhCFfQ2eGg@mail.gmail.com>
Subject: Re: [PATCH 01/11] Bluetooth: btintel: Fix diagnostics event detection
To: Zijun Hu <zijun.hu@oss.qualcomm.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, 
	Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>, Manish Mandlik <mmandlik@google.com>, 
	Zijun Hu <zijun_hu@icloud.com>, Luiz Augusto von Dentz <luiz.von.dentz@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Zijun,

On Sat, Jul 25, 2026 at 4:54=E2=80=AFAM Zijun Hu <zijun.hu@oss.qualcomm.com=
> wrote:
>
> For a diagnostics VSE, diagnostics_hdr[] sits at the start of the event
> payload, skb->data[2], but btintel_recv_event() wrongly guards its
> memcmp with @len, which is measured from skb->data[3] for the earlier
> INTEL_BOOTLOADER check.
>
> Fix by using @hdr->plen, which is the event payload length, instead.
>
> Fixes: af395330abed ("Bluetooth: btintel: Add Intel devcoredump support")
> Signed-off-by: Zijun Hu <zijun.hu@oss.qualcomm.com>
> ---
>  drivers/bluetooth/btintel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index 5e9cac090bd8..d7baf1b9d852 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -3826,17 +3826,17 @@ int btintel_recv_event(struct hci_dev *hdev, stru=
ct sk_buff *skb)
>                                 kfree_skb(skb);
>                                 return 0;
>                         }
>                 }
>
>                 /* Handle all diagnostics events separately. May still ca=
ll
>                  * hci_recv_frame.
>                  */
> -               if (len >=3D sizeof(diagnostics_hdr) &&
> +               if (hdr->plen >=3D sizeof(diagnostics_hdr) &&
>                     memcmp(&skb->data[2], diagnostics_hdr,
>                            sizeof(diagnostics_hdr)) =3D=3D 0) {
>                         return btintel_diagnostics(hdev, skb);
>                 }
>         }

While this seems correct the hdr->plen could also be wrong and don't
actually match skb content so Id prefer to use len - 1 or something
else that actually evaluate against skb->len.

>         return hci_recv_frame(hdev, skb);
>  }
>
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
