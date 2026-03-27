Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619113FA5D8
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774634320; cv=pass; b=gvg0tMUefI8N3WdkJ+4XPFLfo0x9T6IYC5KA6OVyERwXeleFd3TtGB3AiTQeQy41PtjSQlGY+zh9L04E11MS2Hpks/PZ8IlGEbDruahu0bfl3LWc8uuNHzscAMV/+75NeM3/yxDxtY3/OXc0jP7tQxvQiNlchKAcWNrIUoa5Ssg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774634320; c=relaxed/simple;
	bh=/mU1q47f8eVdI/7z0VGqJabC7b3I9M3JfGXAurzgc+8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UJmvwyw/tS6R5wSmVv7Zkv1yqqDMi5ZgUMYSZm+qzou5JuhkSTwXJd1fnWz2BhVOOl8mzSEOarb13Z+MvnP2TEx1CgcqeGWYdn796bCPfQXpsnb9u6+qRWrzidOJ5tQPdlZ9/ww3pCNrnVwcNcR5yM4SDgVv6neH2S0dV/ix3hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ0E87to; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ0E87to"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64eaf8aa893so2486663d50.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Mar 2026 10:58:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774634318; cv=none;
        d=google.com; s=arc-20240605;
        b=N5+G5PA9Vwmb8PT1VfLEYl2TptoeDtzzjRcU6MBdxpi3B+6CiWzsr5AyNCjWXNyHj8
         yUbGjtkzVV/pRjdhqGvez410SbVSSYytNKw2NLkotj60PqdUfQ05DxN3upw3VSN8jZG1
         x/tgzPNuYViVRNJKubqnEyYu4R7TeaGGnyZjOf5xdyPixb3UxHGvTZ+UFKa6vN9vtcbn
         3eKrBVKhwtpd7R6AYU40ZPhzv35HiESMFcMPcmkvwT4ZtRZrRG9ZT7RviziCojqy4ROp
         GCOry9eHmQMt8tvNaigUwV/frmDj3PbQ23aNZPp/iiHz9orDOFRoRCfe8YEVi0Di4sCc
         8g9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LslZTbQuCgzCpaXkkqU/ikNfkg2VIP9zaNKZdPAylrs=;
        fh=z4nbtH7tdF2NkznruD/kN4bMtxs2C5QyfcwWaza6nlc=;
        b=DcjF274L7WGouXsyuAHQX8/dVNkW+RK1vWFx8zox+8XXUS2J2jVG9EvH7XSy4dcTyw
         f8FL3a0rzFUaJO31Me3d+lNATXlaCX/IktmuoBf+E4uFslOzwDWS2DtbtgwMYTYH/l5a
         ZuZ4v523j944oV0CsVVWXpTJZXdDN94cDt9v3sLOd5yx7DifaI4BT46ETFFbfCDufWY3
         oFNp/FaZYM/LQ2HeJnVXD3htMo4I9xR01UOOUmjqOop56O2T2ppIdu+fW9uHFnW9v7Io
         I4oEEMTpGV5EP5y13g65Kei6IpWtMsgupQRd8W0/VpFKT4JUowhVBxjaNcjJd51C3wrf
         8HwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774634318; x=1775239118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LslZTbQuCgzCpaXkkqU/ikNfkg2VIP9zaNKZdPAylrs=;
        b=EZ0E87toiweqbvysACy5E24qFXldVvBPBvuN/4Go150hgrJexzFw9d9vBAweiEEcoD
         ZGUaDcRs3yGmGicYEM/Kh4ubwtYQkH1Mwdxew7jNjqwM0DmJtOaFVMVMo2tTHkAWuXTk
         /j2Y+yOEDLNMbOuf7B5epGqjkqHOfBSfSk+D7ppXakP7S9M4GN2sHIlscqmvT3adHjl3
         cmD0vJgZGaqqBU4qEC8TFA8SLBF02dg2gLAZ/qQ5CpD/PusXFolwL8KVYopptzeKXsHk
         3lW0boTFGNleRUJ/pJObuDHWYg8NAj0003qo3PC/n2o5GTph27LyZUiokbCL4zqkcR8e
         vDxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774634318; x=1775239118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LslZTbQuCgzCpaXkkqU/ikNfkg2VIP9zaNKZdPAylrs=;
        b=X5kv+jtlOThjr8J0kk33dK8ILTGLzQw0aBNdA6RifP7K+dyH1D+XyLq4r1nmdH+JC1
         jsPISISDPekaU7sNQFXVlXcu0k9MVrhjWnJLby/xsYfGlTPcN4QpWawfGd0WET6gpXGi
         rhedqLhEqGvBXCdCuWla0HrTRQmoN17FInFebeL/32klxomj4GNnNALCZs+z/0Ql4hUZ
         aQuyyPmVx7wgHD1GE+V6l+HGBMcR2DIAnuAeoHqpq/xnQ5EHbMOFHEJAittBHEjveMVi
         YzcGEGhqk8ZoQNj9NfiUin1+WB/VyyZQUeBR8smar57hzJfIAOUXHDZOCv+205lMcz9Z
         PMsw==
X-Forwarded-Encrypted: i=1; AJvYcCXMxdAr2kgRUTwQngiyyjeNrPlOHIC6BzXm3ovDCVYld1IY7DxJcOAtdp6xa2MzP7IRHQhwA7yka6s9OHYpOgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1PB0VzpU+5REsajDRZaBtSaDvBphlcfZAzPJZDcpmgM0NGv0m
	AwKCpaCTLmMkEZkh2DFfw2H/aBFfE/hfoNCAIIC+KDnBaFj8NpA7tW7/CuJmNhweSjBirbAM1xM
	p+pXzKdu5/f9ZiGsDyqd/5cWgOubAcOc=
X-Gm-Gg: ATEYQzxuOiXAsKwenb10/yQ8ZTzFb7uGq1qv98hKzH4HX6Red/14o6LS/++MfOLuedV
	pVt1dS70whVfVrAl2QyF4SzBg9DiEb6mEu0IZu6uEgZaIjcSQO//fQgJ0UrDBK9WxaPK+OUzSvj
	8R918Ab0R81ngIobMBLdWRti3f9wHfEGKKJ8PTPA3kjn810IFDRfUSGrDzAkfUHexQWhBUMtAZO
	hLvTmbV1JzS4062cA47XUxtuC27EPTsd40ioI00AdjL+nWLJhzGKe6n6si4aqchf15n0HQ9P0S5
	YydaJhb1VePue0C7jyMUlE2in0eFCR5Z9lnYFmKxf3mEfqk/gEsw0pcjTtnw3X9/sUuaDhS2LfS
	a+aJq
X-Received: by 2002:a05:690e:d42:b0:650:509:1b07 with SMTP id
 956f58d0204a3-650050923b4mr1392484d50.0.1774634318385; Fri, 27 Mar 2026
 10:58:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177272816248.352280.12453518046823439297@jetm.me> <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
In-Reply-To: <20260326-mt7927-bt-support-v3-0-fa7ebd424323@jetm.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 27 Mar 2026 13:58:27 -0400
X-Gm-Features: AQROBzBLmQGFzRqmnDnZOf06xEI8m2lMtSggZgTni-ORGhpk4NTmt_2iIVVyT1k
Message-ID: <CABBYNZJLQ99727+3vnKscsDwgTnuP0NijWr9T=YWBpdq7giv7A@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
To: Javier Tia <floss@jetm.me>
Cc: Marcel Holtmann <marcel@holtmann.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, Ryan Gilbert <xelnaga@gmail.com>, 
	Jose Tiburcio Ribeiro Netto <jnetto@mineiro.io>, Llewellyn Curran <melinko2003@gmail.com>, 
	Chapuis Dario <chapuisdario4@gmail.com>, Evgeny Kapusta <3193631@gmail.com>, 
	Nitin Gurram <nitin.reddy88@gmail.com>, Thibaut FRANCOIS <tibo@humeurlibre.fr>, 
	Ivan Lubnin <lubnin.ivan@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Javier,

On Thu, Mar 26, 2026 at 6:13=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
> This series adds Bluetooth support for the MediaTek MT7927 (Filogic 380)
> combo WiFi 7 + BT 5.4 module. The BT subsystem uses hardware variant
> 0x6639 and connects via USB.
>
> The MT7927 is shipping in motherboards and PCIe add-in cards from ASUS,
> Gigabyte, Lenovo, MSI, and TP-Link since mid-2024. Without these patches,
> users see "Unsupported hardware variant (00006639)" or the BT subsystem
> hangs during firmware download.
>
> The series consists of eight patches:
>
>   [1/8] Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
>   [2/8] Bluetooth: btmtk: fix ISO interface setup for single alt setting
>   [3/8] Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
>   [4/8] Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
>   [5/8] Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
>   [6/8] Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
>   [7/8] Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
>   [8/8] Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Cre=
ator
>
> Three driver changes are needed for MT6639 (patch 1):
>
> 1. CHIPID workaround: On some boards the BT USB MMIO register reads
>    0x0000 for dev_id. Force dev_id to 0x6639 only when the USB VID/PID
>    matches a known MT6639 device, avoiding misdetection if a future
>    chip also reads zero. This follows the WiFi-side pattern.
>
> 2. Firmware naming: MT6639 uses firmware version prefix "2_1" instead of
>    "1_1" used by MT7925 and other variants. The firmware path is
>    mediatek/mt7927/BT_RAM_CODE_MT6639_2_1_hdr.bin, using the mt7927
>    directory to match the WiFi firmware convention. The filename will
>    likely change to use MT7927 once MediaTek submits a dedicated
>    Linux firmware binary.
>
> 3. Section filtering: The firmware binary contains 9 sections, but only
>    sections with (dlmodecrctype & 0xff) =3D=3D 0x01 are Bluetooth-related=
.
>    Sending WiFi/other sections causes an irreversible BT subsystem hang.
>
> Patch 2 fixes the ISO interface setup for devices that expose only a
> single alternate setting (alt 0) on the ISO endpoint. Without this fix,
> btmtk_usb_claim_iso_intf() fails with EINVAL, causing ~20 second
> initialization delays on 13d3:3588 devices.
>
> Tested on:
> - ASUS ROG Crosshair X870E Hero (USB 0489:e13a)
> - ASUS ROG STRIX X870E-E (USB 13d3:3588)
> - ASUS ROG STRIX B850-E GAMING WIFI (USB 0489:e13a)
> - Gigabyte Z790 AORUS MASTER X (USB 0489:e10f)
> - Lenovo Legion Pro 7 16ARX9 (USB 0489:e0fa)
> - MSI MEG X870E ACE MAX (USB 0489:e110)
> - TP-Link Archer TBE550E PCIe (USB 0489:e116)
>
> The firmware blob is being submitted separately to linux-firmware via
> GitLab MR !946. The firmware path has been updated to mediatek/mt7927/
> per maintainer feedback.
>
> Changes in v3 (suggested by Sean Wang):
> - Scoped CHIPID workaround to a static VID/PID table of known MT6639
>   USB devices instead of mapping all zero-CHIPID cases to 0x6639
> - Changed firmware path from mediatek/mt6639/ to mediatek/mt7927/ to
>   match the WiFi firmware convention and avoid confusion
> - Added MODULE_FIRMWARE(FIRMWARE_MT7927) for initramfs firmware discovery
> - Added Tested-by for 0489:e110 (Nitin Gurram)
>
> Changes in v2:
> - Split USB device IDs into per-device commits as requested (Luiz)
> - Added 0489:e110 (MSI X870E Ace Max, new hardware report)
> - Added ISO interface fix for single alt setting (13d3:3588 devices)
> - Added Tested-by trailers for all USB IDs
> - Added USB descriptor output to all per-device commits
> - Removed BTMTK_FIRMWARE_LOADED skip logic (Sean Wang)
>
> Link to v2: https://lore.kernel.org/linux-bluetooth/20260325-mt7927-bt-su=
pport-v2-0-b892a3252880@jetm.me/T/#t
> Link to v1: https://lore.kernel.org/linux-bluetooth/177272816248.352280.1=
2453518046823439297@jetm.me/
>
> Signed-off-by: Javier Tia <floss@jetm.me>
> ---
> Javier Tia (8):
>       Bluetooth: btmtk: Add MT6639 (MT7927) Bluetooth support
>       Bluetooth: btmtk: fix ISO interface setup for single alt setting
>       Bluetooth: btusb: Add MT7927 ID for ASUS ROG Crosshair X870E Hero
>       Bluetooth: btusb: Add MT7927 ID for Lenovo Legion Pro 7 16ARX9
>       Bluetooth: btusb: Add MT7927 ID for Gigabyte Z790 AORUS MASTER X
>       Bluetooth: btusb: Add MT7927 ID for MSI X870E Ace Max
>       Bluetooth: btusb: Add MT7927 ID for TP-Link Archer TBE550E
>       Bluetooth: btusb: Add MT7927 ID for ASUS X870E / ProArt X870E-Creat=
or
>
>  drivers/bluetooth/btmtk.c | 56 +++++++++++++++++++++++++++++++++++++++++=
+++---
>  drivers/bluetooth/btmtk.h |  1 +
>  drivers/bluetooth/btusb.c | 12 ++++++++++
>  3 files changed, 66 insertions(+), 3 deletions(-)
> ---
> base-commit: 50003ce2085a7f7dacf2426065d1a69c84b5b963
> change-id: 20260305-mt7927-bt-support-6589a50c961f
>
> Best regards,
> --
> Javier Tia <floss@jetm.me>

https://sashiko.dev/#/patchset/20260326-mt7927-bt-support-v3-0-fa7ebd424323=
%40jetm.me

First one is more concerning since it may mean it can lead to crashes
with SDIO driver, the other comment may actually need to be addressed
separately, perhaps WBS handling needs to be fixed on this family of
controllers.

--=20
Luiz Augusto von Dentz
