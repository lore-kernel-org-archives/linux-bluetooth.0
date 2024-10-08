Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8741DF966
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728394765; cv=none; b=eAolhcSSl6ufK5vu+Emou5BESzyDYni2U+2Kgd7pWoCieZtsC+fOCtCbnjcGxDWu//ZlXPR3at2xTlPmjadi65EsOsfm9SeYpyzHzmCgIhQfty5a7tLyS58dnVTB46ydnFmkUeLjg+TQnl+5VL6oDfqb9BKscp/6pm336RJZzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728394765; c=relaxed/simple;
	bh=J7cUaiYgFzkw/eeV9y0YYoAQfyozATulIOzucz2bj40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UsMJTFFUrATklIYXqlPZMz9iDfajobx528u6OQImHz52VjrEXgIJ4tkWWn46sFm0bx/kaTKxLo1uxbVDX1ilwHzl4bcohBEbgeNMlRSyWiYZxuwdAESNdptknSSUKsg6n40YfwnVUGos0CFXHxO1YBHw2pEr0UNEl/uWrfX5ES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QMzobFN3; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMzobFN3"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2fad5024b8dso64031221fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Oct 2024 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728394761; x=1728999561; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6aGEcuVZw3m3YXpk5HhLAFOUMtHT0mCLFSBTmYzosXQ=;
        b=QMzobFN3aoilSJg3krYs6o73fIn3PqpEHxB4dsnMIRmCngsypcY7vaz790OpDjRUf8
         8ErO84TDCHx1o4XDBB8508i8U9uZMmvqP+QzPeOQnWVcVmNZBwUkJYGaZ1pq2nJT5Thu
         bvtRliiUcA+V/YcEgQvHwp9RtEdCtKNkItjX/yxN8k5HvIVRewUxnuzNCl40UPcVmgoF
         5MEZOXx/6yrSeDryXbBHySnuH/eBRS0S9sxJCxZlB6F7SRcUOC/Ss0SeHBURQr999/w+
         ux0/exAj8BSB4OoACJVMcU6Zgn78KtkSF81mqw4Ci+WUmfrNXSK6cFYATYcL7hi//UyN
         h1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728394761; x=1728999561;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6aGEcuVZw3m3YXpk5HhLAFOUMtHT0mCLFSBTmYzosXQ=;
        b=econexeax8FeI6IK0vQ/vkyJTgrntKuppbybm+vUJ6ORdluwPNildqw75pQr5l3r8f
         sDjumlkftn/U+FT3OvBic3n/yRI1niTgcJyINz6ZzEKywqDfy+maNdxCS21mpgY85+oz
         PIsI13ws4YbSJvVjU1FlkQO+NBBMcBhefG27QKMcsdetNoY0c6//UHWCJjR7Yz3JXOPl
         Z8hHZw4J/iFFCydZZKU4n3U7RdnMU1DJA3ACfd+FF3g23BZOQKQIGRia/DTwy3mHH00u
         T5uAlALHVkKmiexAZMBc0E3yB4+Fh/00DDlsmN4e1t2zJKrdQEM/u6qNeP15TqLruItB
         Kb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUhIV6NR5c/tsPfO5GlogBAfG9BQ1jGRJhe6FHlUzrWw7j4jKNrQ38jqRtF5MgDqKJ/OOcS5aZ0kzdAQ4huxKg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzn4fFfqbxxRx4I/md8hhXAnnwaZ9x7msndU+TlK0R77z5uv6Y7
	18+xSO/CcnOsHlxJlYiOnRWcAh/b/pNXIidYnT/nQs9y3xx3fTghpkp97pywvO/HBq3vA0EMqdG
	fW9gqhJwowXB4zrAR9tIsGTHnTejHMw==
X-Google-Smtp-Source: AGHT+IFRuFdiSaQmQPTm/iVOtBf4fHkAXNvgRlJA+uLxnNsq4xXy9ylkWdSDqJ6NdnkIL3gVC/tdOMK8VDVsrWaHGDA=
X-Received: by 2002:a05:651c:1502:b0:2fa:e03a:bee7 with SMTP id
 38308e7fff4ca-2faf3c64dffmr83701601fa.28.1728394761050; Tue, 08 Oct 2024
 06:39:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008082721.4004100-1-wenst@chromium.org>
In-Reply-To: <20241008082721.4004100-1-wenst@chromium.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Oct 2024 09:39:05 -0400
Message-ID: <CABBYNZ+UGx8TtW+aXZer_j=L79NYEP28+FcSeRqT3BKN7L+CGw@mail.gmail.com>
Subject: Re: [PATCH RESEND] Bluetooth: btmtksdio: Lookup device node only as fallback
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Sean Wang <sean.wang@kernel.org>, 
	linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 8, 2024 at 4:27=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> wr=
ote:
>
> If the device tree is properly written, the SDIO function device node
> should be correctly defined, and the mmc core in Linux should correctly
> tie it to the device being probed.
>
> Only fall back to searching for the device node by compatible if the
> original device node tied to the device is incorrect, as seen in older
> device trees.
>
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I was hoping to see some Reviewed-by/Tested-by here, were the mediatek
made aware of these changes?

> ---
> Resending after three and a half months.
>
> This follows up on the MT7921S bluetooth binding and DT fixup patches [1]=
.
> This should not be backported.
>
> [1] https://lore.kernel.org/linux-bluetooth/20240412073046.1192744-1-wens=
t@chromium.org/
>
>  drivers/bluetooth/btmtksdio.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.=
c
> index cc097aedc1e1..a1dfcfe43d3a 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1328,6 +1328,8 @@ static int btmtksdio_probe(struct sdio_func *func,
>  {
>         struct btmtksdio_dev *bdev;
>         struct hci_dev *hdev;
> +       struct device_node *old_node;
> +       bool restore_node;
>         int err;
>
>         bdev =3D devm_kzalloc(&func->dev, sizeof(*bdev), GFP_KERNEL);
> @@ -1411,13 +1413,24 @@ static int btmtksdio_probe(struct sdio_func *func=
,
>         if (err)
>                 bt_dev_err(hdev, "failed to initialize device wakeup");
>
> -       bdev->dev->of_node =3D of_find_compatible_node(NULL, NULL,
> -                                                    "mediatek,mt7921s-bl=
uetooth");
> +       restore_node =3D false;
> +       if (!of_device_is_compatible(bdev->dev->of_node, "mediatek,mt7921=
s-bluetooth")) {
> +               restore_node =3D true;
> +               old_node =3D bdev->dev->of_node;
> +               bdev->dev->of_node =3D of_find_compatible_node(NULL, NULL=
,
> +                                                            "mediatek,mt=
7921s-bluetooth");
> +       }
> +
>         bdev->reset =3D devm_gpiod_get_optional(bdev->dev, "reset",
>                                               GPIOD_OUT_LOW);
>         if (IS_ERR(bdev->reset))
>                 err =3D PTR_ERR(bdev->reset);
>
> +       if (restore_node) {
> +               of_node_put(bdev->dev->of_node);
> +               bdev->dev->of_node =3D old_node;
> +       }
> +
>         return err;
>  }
>
> --
> 2.47.0.rc0.187.ge670bccf7e-goog
>


--=20
Luiz Augusto von Dentz
