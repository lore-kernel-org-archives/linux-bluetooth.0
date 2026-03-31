Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9C11C3F0C
	for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774963284; cv=pass; b=HlGY+N87eLawbqN6Iwrzm+OSRNx+5yc1k5q6Pel3Gk1Qn8LKIRCEeXBa0pc1HS9kRnBFOWBZrlBFcwYvmk09VJkqZ73ISt6BUMx35AWAerdEuZcS9iMosCCiSdvqG3r7c+KtVMKSmT4Lpr6k4ObivDWIOpRZBPcPo3Nm/Dkh5/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774963284; c=relaxed/simple;
	bh=OcJ2z1I0FdBraHt/Yo8tDtm4sHf0iv5J4Z/+hW9Qqws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MVc64/D1lKH796o60kbb+4dVVmW6qvMrQhtj2RHMZ2Kq51Duj/W2ErHu53ykp3YIHuzaFEZoYvY3m98Kn4JAOYGmISZoXlFTDdVuEK1C1Q0mGH0p4fQrEdRKg9IhjT7qWGANhyOsrjX7mn1932dr82OI5/3EcOCG/uZgd9fQQyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6KLY4j7; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6KLY4j7"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6501d242e2fso3815986d50.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Mar 2026 06:21:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774963281; cv=none;
        d=google.com; s=arc-20240605;
        b=SAX9RhNONUr2moAa3lPSfTPKrH3lsEH3CZ9xXW01qIdxgfEjqsDEFU2bZZPnl2m2vk
         9gzr2TxAE/9160Exb90jRHjbXnHwxDdVSUlleh/GmAah1amxaF/idj19spwDtAqf4/Gs
         4d/uCrCdhF3YqiQgfMgXLL1Z24KR51ILINlgiZe3vI0lR3iA1GfPojY7NISr2CJD6Ske
         vaoho+gjeTkwpifm7jAa4zT8QujGywvFeuOTXVBUiX10mUTr4hCX555JRYOUiZ4qFHU5
         VN9OjWHjh6PJdXhWLftCJAE/9wrxSo1578UTN2KhFOiFNg3sce0Dq8U8zIXmu3xSrIW1
         sQHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TsHouUjM/sX6MNpZdJ+2Xl09xrG1oeKuiE+2byGWXSQ=;
        fh=ZPHikjy9mqRBq/1/vIvd42WIHIwI1wpzUMVi0am17mM=;
        b=DZDfCDayqJUez9Fx4Xfe7xZ+3Lg8OFTAr8+/zdY++0FdinAS2Ik3PjNbPkysHBwIdq
         kTE2YhZ8UnmOvUgQVQtzBDW+xwda9LLmcioMcTGyQLOuYxNDh5gsVHqYJIcKQyAv+ZzA
         Uie9UaHZBGk1u3Sh/Dk1+i/v9mb+sGUsGAATFgK6UCMNf0fcR8sSq1F7B7eGkrnT9f0Q
         RYjo4XOCAaBzhE/P2KvvStqZG7U2ldDL4wIHM5VvLbLqy5L99uBuEvD9fkcaXHlT4nad
         49Cqi8o1eFSQvJ7BoOIeBuKi52pg2V6DQAz3sURqUvW3Tv6/IZEmQc9X0XZh4k3K8Kib
         s6ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774963281; x=1775568081; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsHouUjM/sX6MNpZdJ+2Xl09xrG1oeKuiE+2byGWXSQ=;
        b=o6KLY4j799qbzhmTj3tF1esXA5SwzcTgVSWOlw2OZvQHOkasb4qk/H427FxoSYeEB0
         3K7RbTiGdi1pDk48Y5Qe1yjNilAm6OmMQ6zOztH40ek4Fs40IPC6jFCRzW0aSyFSZ7W7
         kLaNxIN0OMjAFTw0U0PR9PIcuE2IU3xbzfcHF7QK73jMI8AoV1WjzvplVOZEysHS0hn0
         IreEyJ+z9mnt2oEZz4vvcCm3B4D4VotlUzYTnkwLM08GOCBmzHMP+ueY+u5t5cfSIpCn
         0uqF6VLccZ60nAFy7+Z4sx74QlxCcI6nMz+GXsNDox3RzabjeC9gA7IbFI9pnGqIRRia
         xpCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774963281; x=1775568081;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TsHouUjM/sX6MNpZdJ+2Xl09xrG1oeKuiE+2byGWXSQ=;
        b=K1K/wtL4uDQ6h92T+JKPD/hkXpLY0O5ogYxGht6EFvH0IF55d43dnLMD74axKvgiVN
         zpNan/Rtbq0jxAOukdyuRJJis/uCqMVmLCLT46riqtn6oVOdzr+6k4TZiXYLCCe1R/m5
         8zPThE0DK5mwhShJ4OyXhB6FKyxIesXKjJ2xBFcsJpLcHtZui7Q9ZYFkHbkmXJl0WTnv
         T0j/057QZcU0RA2AQbXIY08Qs55KuyHqTNGNc1O3j+z1rDDCLCKvOD1Kzk5C6xKSQT06
         +mPOIBWX3n2YBxFE6Wo/jvxJnJLQiSTX8xijrzbjql9Mj4ikkDuBSzHKbsG3ggsg1yej
         VIsA==
X-Forwarded-Encrypted: i=1; AJvYcCUOC3rI+cANFRHTx80+GcBp7gcypiXiaO/phU12pb1UUjMtk/ZHXCx5rWH0kkNrld1QnKOaaUY2/51KfhkJ5e8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR6DcCSaoD4PCValHUPaOHbi2SumKjdPtBufD6oAXk5mWyqECd
	GkzGbZWvYqj7PW6zLhDAuBiMrUCGS+cIFl2aH/VMnBeZGyN2Z3+mKBF9NqAWHZ6a+yinv3iNSYI
	Cn4Iinuqj3NUBr9rH7uL3wPZbSPPPJz4=
X-Gm-Gg: ATEYQzzpCpsnzHYJAMHVe2uAFQEXgOYMBK8Mv6akLNUcma83GjDem1UjW+3kArvgzdK
	SZLGDUnkWlJ8FZYkscK11fvE5dyt5N5LKVXvN7gUENDU84vTWP4c65Znbuc+gTg8g8j6VejljKb
	Ey0W1hdGdR78T/d7AkdfuXvCaQAfleV89j/pZ6S4A5nlIa70PKS/bM9wHLTDNBfFi+M9QBU23t0
	1S2vtPyp4OWMhxcYwe4Utz7b3WsN5Uc8Yal7GvT0hIACZREpFXq0Tr4szFHhyUiM33ViWDX/CuZ
	hvRb2HbkiEcl53azHkAafdbT2Ux3bgCEx1YohQweWLqOUZTBB+E5aFwaXybbulNVW7QYIg==
X-Received: by 2002:a05:690e:4106:b0:650:1203:b18e with SMTP id
 956f58d0204a3-6501203b3a5mr10132128d50.73.1774963281252; Tue, 31 Mar 2026
 06:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
In-Reply-To: <20260330-mt7927-bt-support-v4-0-cecc025e7062@jetm.me>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 31 Mar 2026 09:21:09 -0400
X-Gm-Features: AQROBzA8Gvb6W-nwoEVCHeIegRAguGDmKStqgZKVOgir3Am0LgLVxEFaOOAfJvw
Message-ID: <CABBYNZ+MFJU=LLEaizYEt1b-7VzosErkav7dyneZExr_rLUnRA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Bluetooth: Add MediaTek MT7927 (MT6639) support
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

On Mon, Mar 30, 2026 at 4:39=E2=80=AFPM Javier Tia <floss@jetm.me> wrote:
>
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

Ok, but on 8/8 it seem to suggest the problem still exists which
trigger the following review:

https://sashiko.dev/#/patchset/20260330-mt7927-bt-support-v4-0-cecc025e7062=
%40jetm.me

Perhaps we should ajust the commit description if the 19 seconds
doesn't really occurs when 2/8 is applied.

> WBS (Wideband Speech) was verified on MT7927 hardware. The controller
> reports LMP_TRANSPARENT, LMP_ERR_DATA_REPORTING, and mSBC codec support.
> A btmon capture confirms eSCO links establish with Transparent air mode
> (mSBC) and 60-byte frames. BTUSB_WIDEBAND_SPEECH is correct for this
> controller family.
>
> Tested on:
> - ASUS ROG Crosshair X870E Hero (USB 0489:e13a)
> - ASUS ROG STRIX X870E-E (USB 13d3:3588)
> - ASUS ROG STRIX B850-E GAMING WIFI (USB 0489:e13a)
> - Gigabyte Z790 AORUS MASTER X (USB 0489:e10f)
> - Lenovo Legion Pro 7 16ARX9 (USB 0489:e0fa)
>
> Changes in v4:
> - Pass dev_id as parameter to btmtk_setup_firmware_79xx instead of
>   using hci_get_priv, which is not available in btmtksdio
>   (suggested by Luiz Augusto von Dentz)
> - Skip post-reset CHIPID validation for 0x6639 in
>   btmtk_usb_subsys_reset since the register always returns 0x0000
>   on affected boards
>
> Link to v3: https://lore.kernel.org/linux-bluetooth/20260326-mt7927-bt-su=
pport-v3-0-fa7ebd424323@jetm.me/
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
>  drivers/bluetooth/btmtk.c     | 63 +++++++++++++++++++++++++++++++++++++=
+-----
>  drivers/bluetooth/btmtk.h     |  7 +++--
>  drivers/bluetooth/btmtksdio.c |  2 +-
>  drivers/bluetooth/btusb.c     | 12 +++++++++
>  4 files changed, 75 insertions(+), 9 deletions(-)
> ---
> base-commit: 7f9446b23ac77f46d356b354ea8da49113e8000d
> change-id: 20260305-mt7927-bt-support-6589a50c961f
>
> Best regards,
> --
> Javier Tia <floss@jetm.me>
>


--=20
Luiz Augusto von Dentz
