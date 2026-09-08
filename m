Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606B550DBE
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Sep 2026 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882446; cv=pass; b=MvBtnDb+sgUbVMlyXVJSFICSqXEXWxCUH0KfZ+/PcpAW3mqVyE+sV5LDG0h/GP1FPV8Eba0TM3NrGJkLBS67DisxWIrcL2j5srSIeWcUtaspyqLIvKKl9w5Blxco2uUTeGL1fwT4vvl0aE/CSm29RYhaInpjIJZ4Wtl5pp5vvRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882446; c=relaxed/simple;
	bh=/gsnZQcsbiXQbrVg5jm8zjgIYcac93sU5h0gQJ8gm6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MJ/dYjQrVImu8vmEu2yfOneAHKccXsL7yRUe3QS1A5B0ZXHzPea4mdP90CAJYVArCd/6IP/q7n1un0YYCWLMuoMUB08zDqXI5fyrgHSlCHjc1dKEXShXW5oW2MdrieXAGdodUBj2kXKPnXt3Uu24tPvdHjp2cO3lU67tVfc643E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REqqusUE; arc=pass smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REqqusUE"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7dbcb505578so46890657b3.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Sep 2026 08:47:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882443; cv=none;
        d=google.com; s=arc-20260327;
        b=FW6Lm5Sx9zAb32o1yxa1BOkEZH2U70EYX3Ia51wWoTiteOPsL1Qlqep9xq2/y1IAIU
         o8MP4ubimfHTFxmLwAIZCq99wVp9vgfLoU5RvZxmnU933zL5axs8k4RQ0gMCNtUDaKDQ
         JtpQWXtmJK7RxhBUA5YXwy01MtTau4Lja26ql6W7QtcSV9wMPrNuZEZp/hacyzCkiWZ4
         Ms028199hKpMQ5p8R8l0Z934ePWCNM6SSGH3bMAwT5axYwJjmV1dQPYYoWdCZmMcrnqu
         SH1CCsuYjdSuLLzF5DoZgGBiMFtx1yO13VPI5gZ65FHA92+z+HTb3+JTFxeMXlde1i8l
         2Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oLshI+8aYbyGh7S/ZjJf7W8M+Vq4mxSjxpZV6utkZX8=;
        fh=Hiqq6nRyM8P5McgF5lx50nGu8WZOtBCqRDUv9KT47jI=;
        b=Wphs3joM+n8Avl30KCOAorVbMnLsZSDPBaeYS0/TKseffGxyX09jwn6ZiCHLTWVjyB
         kVQXlF9n0ZQ0n/X3EgzvlVOGsLjsg8MG6WzYIzT8RS1Npgvxk2kPvjDE/rJ311v0S7Xh
         RIo2GGUnlvsDToX9SBkt5sh3BnfJUXgFrO9idTL3uH/9xcvznGyvH6iAdN1f5x0tEthN
         hLgEnuBe52My4SR6YdPCDbFfVxBuob78QdGqR+bQcTGUpBkc2oaMY9wxr23hYNntwSbF
         bp48V3u4+pP3hpGr+5fKthVACi6qo2Ukickc592J6OkhX0p1ItMV/5sf3W1dkIt7Dmbu
         yPfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882443; x=1789487243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oLshI+8aYbyGh7S/ZjJf7W8M+Vq4mxSjxpZV6utkZX8=;
        b=REqqusUEeskwGd+LEKzhBh1ImPb6DL5KbhYncIBsghAjLBfIfc+EJWwYHuvNaxXcl/
         3Ocmr26b1uzGxNm++mfJ0PV7sWM+MY9Sx4azx3BZe/zl77HGi4A2ild33Uu6O7QBusve
         WBstiaaHUOKbUfd33bHMB03nccN7Ywmsgn4VNxFwGJ2YB9IOJ8RHZ6NgkGV7rnlM51Rw
         uq+eTt0Czp/v3Xz0vTRnB1hxsvOlx7P6PwvY5DLJ4ftEy3UE/Z0V1kyQJHDPLrJ3oeLi
         KgIE2RTH81WLg6bohLHjdTe3POGxi92OIix/K29czbgaqoer3EknXJYKSYYYwFo9mWfg
         nReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882443; x=1789487243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLshI+8aYbyGh7S/ZjJf7W8M+Vq4mxSjxpZV6utkZX8=;
        b=mu7bckv3MkszjCTn0N/e1pnSIsgC1HFqqV5piYaVYjYnBF+lIVRrPE/JQzR4yhR3DL
         72iCbuleHEMxHu8scvs8R7X48Sz0OG6E2t6LRn6Pd1EkN3su6/SC+3WZ76+K6SFQxZs6
         Q1MhvXzf1xgN3vuHqAUlfGeO85XY3ZyGw3pX43xAOqxJLn9EGMuv9l7j9atCE3tuTety
         Pvav+DsAoiIRGyOEialRAf6z+w4B7zRKzo6kzb8Pf/Q/f7ZAIstXglbw2poZZUb8vIEJ
         uxUn3FIaUwRUtKMSOMaElX1PPmil5EguK0v8ZZKRIaN+dz5duOuBDCCtCht5Q5x5w/bA
         R6EA==
X-Forwarded-Encrypted: i=1; AKwUvBzpflti5Wue/aYHNb9nAssoHlDXB6JEZdySC3ew66IPKtsDZ8uZFYmC7ZFjUloGjkWMseMxBUK1j4FSSeYAdSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mFYP1NoCqUfEuKGhJk1lDq4SzjmZuFiMwoAd7wYKKpW/V7lc2o
	k+hvqVZpvJ3ACJsq4wR0OuUKah4hGXRu4NVrctAGm7eeDSUbxu7bNppV02oE4cdb8bB/Tk0ewSA
	Th0IVzfOR1ui/vO6Ow4Fm+d7T2nBnD/6ElDS1mpbe7A==
X-Gm-Gg: AYBFou3qMPP191kQjC49ow94HRGHREJXaXBuTRfKFyIyC4vwN8v/R+QKvvsLvl7nWZ6
	NKZrjLfw5mhxWrrNV4r/tIokxZpff5xNlAaaxmqyffDpgmzP5UbDgefL/xwTrNuIaUvT2pnRKEq
	ByYhT7nEPqU7L2vgTcI3lrZ51uQhXS2M5QWxm3Z8iv+qdkyDI8QiUx6jSu48oWYj4toAYA0Doih
	UgoBOjbTDN9DCJLuXvh1KseqpAXLkGDPelhHsDocjSW1OIK4XA1S6ywClQ08TtqlsfhCfEOuChY
	NcFZk0PkFjSr3G17MF5tk2uFimFdk5cEPJh9is0kSFZVfwTRFVWEWA+cmgtOZx1EhBMqTZv1MW6
	wkY+k9pl5KSc1Wn+bPOaSxnV+aRo7qKmYSimJIf0=
X-Received: by 2002:a05:690c:e3c1:b0:86f:c1db:14c7 with SMTP id
 00721157ae682-8712259664fmr96188427b3.7.1788882443248; Tue, 08 Sep 2026
 08:47:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905-btusb-skip-non-hci-ifaces-v1-1-32dda494122f@nordicsemi.no>
In-Reply-To: <20260905-btusb-skip-non-hci-ifaces-v1-1-32dda494122f@nordicsemi.no>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 8 Sep 2026 11:47:11 -0400
X-Gm-Features: AcwNN1Wm1DJTXl1SSHT0RevS3ilTVO2buaToGeTZYyevXQPtMnXLDkiRvgpGU78
Message-ID: <CABBYNZJ1FHSfrvLCVALdbYJ_Sn6xMZ1p-zbJdDbq=Exfa=xfWg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: do not probe non-HCI interfaces
To: johann.fischer@nordicsemi.no
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johann,

On Fri, Sep 4, 2026 at 6:24=E2=80=AFPM Johann Fischer via B4 Relay
<devnull+johann.fischer.nordicsemi.no@kernel.org> wrote:
>
> From: Johann Fischer <johann.fischer@nordicsemi.no>
>
> If the driver selects BTUSB_PROTO_H4, the second interface (voice
> channels) remains unclaimed. Then, the btusb_probe() is called for the
> second interface. It misidentifies the interface as one that supports
> legacy mode and fails with "failed to enumerate endpoints".
>
> Signed-off-by: Johann Fischer <johann.fischer@nordicsemi.no>
> ---
>  drivers/bluetooth/btusb.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index dfefb43fb792..44f0db347643 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4293,6 +4293,11 @@ static int btusb_probe(struct usb_interface *intf,
>                         return -ENODEV;
>         }
>
> +       /*  Skip interfaces that do not implement the HCI transport */
> +       if (usb_find_common_endpoints(intf->cur_altsetting,
> +                                     &bulk_rx_ep, &bulk_tx_ep, &intr_ep,=
 NULL))
> +               return -ENODEV;

https://sashiko.dev/#/patchset/20260905-btusb-skip-non-hci-ifaces-v1-1-32dd=
a494122f%40nordicsemi.no

Afaik it is possible to have devices implementing just H4
mode/altsetting. Perhaps we should claim both interfaces to avoid a
second probe?

>         data =3D kzalloc_obj(*data);
>         if (!data)
>                 return -ENOMEM;
>
> ---
> base-commit: 88a8184cb44c8952e6a6fd21e250445300d1c7aa
> change-id: 20260904-btusb-skip-non-hci-ifaces-b52ea298677b
>
> Best regards,
> --
> Johann
>
>


--=20
Luiz Augusto von Dentz
