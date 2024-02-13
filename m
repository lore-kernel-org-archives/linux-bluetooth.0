Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823551DFD1
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707840634; cv=none; b=V25JSe3uAfEvRMLOhvrN1t4OGM0T6SHKwrJ4JIBoktGdPXhtuN3s8ZvOCAgalpVWm+M8IgEgGFky/dv1D+sguwl12ysqHpIIZi/q+7LXuxGxdXmbkp1BeX9T1aIBxcE1ll8soaTFLtjXvbFzmCWkwLxyAmwQLUTs7mY63C5fSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707840634; c=relaxed/simple;
	bh=OhhwRCv8MhvyVlgGeC5j0+3yYXAOyd1dt4kOS6TUVNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l9CzT6If8HugsamvryR0nCEnz8v7vWhKC2fIO3iY69uweyrn7YtxyI5GB6GYVL4EvuI7IIkBy1g31zsPk1DMhTjDZFoM9pKld22was53P8OZauEcmIhsc9+6BUtWMxwDtgAUa+RiPnuH9Qkh60Na7tLp4gKLIVOcUCpGM/1z+2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MVP56EHE; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVP56EHE"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d0e521de4eso38949041fa.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 08:10:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707840630; x=1708445430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Thkr4ulePWZpIkHitjCRIdr6F5Q9Qk++Hg60SDF62FA=;
        b=MVP56EHEeJUVifETQfCys8q1fH/1gnRgXfQNfQUc7mnPeoB0+R7h2A8OXPWg6ESm34
         v7ZOg/HIJ/IDdD23B0ARlD4MrL7r+LSR7y1FTTmCuNWwHTei9HAvZnDMVMQFrYCLEhAV
         r6C8WmWvodShUy20NGoqCaKJrmhR+9iT2sudjjD3nNs8Ald7fcm9OZnoR6BBp8TrcC2B
         keXfyzipRC56FCJC+loqn0li+CoGHUiFD8LeOpooywaW8ZXHaRlRT1ujscD2lzfG2Z4m
         NbJ1xoyD1b7iaVj+9i04lw/8Xm/f+cZ9TI3vu7JwRJ0CGVW2EDrVWTHOoXoZr6xtVfu9
         vTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707840630; x=1708445430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Thkr4ulePWZpIkHitjCRIdr6F5Q9Qk++Hg60SDF62FA=;
        b=nvR3xhiu5wpdgblxnKCP33ywVk9t/PDwN1R/WQMJELT/kUGDxXKwF/79hk4aqedbuR
         fEvy+OK8a7CUpqFvhgTrpeK7C1OMdaBLFr2iVlb7+4qaeOhTOUZNXb675RUurtN4nCYM
         TJPK3MN1LMR0WS6ppLGsVHGABhd+iH9V2CsAPDj65idgkQzlO9FrDhvR80bUcyf5Amf1
         trR6uVCT+rWLHeoM/m/mYxA2aFEQqgmHb+ba77fh9KAbzFXksXyCy2rrx0Ee6YyzPh4l
         aFjL1gg4DhzG0Ebd1EU4og+TgjAMSgSDDCrwJu7lYGdWO2M907bVCXRxaTKvjmmmV18Y
         5YiQ==
X-Gm-Message-State: AOJu0YxckNfkGB2N1FXvqiTMHOluAJv6wvsORsn8wt+4K2Jer8hb96oC
	iOQ5sZQ1RiUqEgTvWzwUJCTQhIKPaVsvgxqOGId+czjKDTfgHR+EHfKqaJH+rTl6LPGUtYf6lqw
	QPJJMvtBtsQhmTHAjtuGEf//sdMDdth63
X-Google-Smtp-Source: AGHT+IHuuEMbk0uAR9F+jVFxjZZgEm7+75F318D3Xu1WcuzQGIXpNioJznVm//QvdqRfaHU9lCjRmd3Du5eIXW4oSO0=
X-Received: by 2002:a2e:be25:0:b0:2d0:8a78:9e69 with SMTP id
 z37-20020a2ebe25000000b002d08a789e69mr87566ljq.52.1707840630121; Tue, 13 Feb
 2024 08:10:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213160152.2836131-1-kiran.k@intel.com>
In-Reply-To: <20240213160152.2836131-1-kiran.k@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 13 Feb 2024 11:10:17 -0500
Message-ID: <CABBYNZJL9FKuWU_4c1KrskzjAtBVxtW9PDqP==MAYGOc+NZB5Q@mail.gmail.com>
Subject: Re: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer information
To: Kiran K <kiran.k@intel.com>
Cc: linux-bluetooth@vger.kernel.org, ravishankar.srivatsa@intel.com, 
	chethan.tumkur.narayan@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kiran,

On Tue, Feb 13, 2024 at 10:51=E2=80=AFAM Kiran K <kiran.k@intel.com> wrote:
>
> Firmware sequencer(FSEQ) is a common code shared across Bluetooth
> and Wifi. Printing FSEQ will help to debug if there is any mismatch
> between Bluetooth and Wifi FSEQ.
>
> Signed-off-by: Kiran K <kiran.k@intel.com>
> ---
>  drivers/bluetooth/btintel.c | 106 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 106 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index e5b043d96207..0d067ee39408 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2670,6 +2670,111 @@ static void btintel_set_msft_opcode(struct hci_de=
v *hdev, u8 hw_variant)
>         }
>  }
>
> +static void btintel_print_fseq_info(struct hci_dev *hdev)
> +{
> +       struct sk_buff *skb;
> +       u8 *p;
> +       const char *str;
> +
> +       skb =3D __hci_cmd_sync(hdev, 0xfcb3, 0, NULL, HCI_CMD_TIMEOUT);
> +       if (IS_ERR(skb)) {
> +               bt_dev_dbg(hdev, "Reading fseq status command failed (%ld=
)",
> +                          PTR_ERR(skb));
> +               return;
> +       }
> +
> +       if (skb->len < (sizeof(u32) * 16 + 2)) {
> +               bt_dev_dbg(hdev, "Malformed packet");
> +               kfree_skb(skb);
> +               return;
> +       }
> +
> +       if (skb->data[0]) {
> +               bt_dev_dbg(hdev, "Failed to get fseq status (0x%2.2x)",
> +                          skb->data[0]);
> +               kfree_skb(skb);
> +               return;
> +       }
> +
> +       p =3D skb->data;
> +       /* skip status */
> +       p =3D p + 1;

How about we use skb_pull_data instead of accessing these fields with
a pointer cursor?

> +       switch (*p) {
> +       case 0:
> +               str =3D "Success";
> +               break;
> +       case 1:
> +               str =3D "Fatal error";
> +               break;
> +       case 2:
> +               str =3D "Sem acq error";
> +               break;
> +       default:
> +               str =3D "Unknown error";
> +               break;
> +       }
> +
> +       bt_dev_info(hdev, "Fseq status: %s (0x%2.2x)", str, *p);
> +       if (*p)
> +               return;
> +       p =3D p + 1;
> +       bt_dev_dbg(hdev, "Reason: 0x%8.8x", get_unaligned_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Global version: 0x%8.8x", get_unaligned_le32(p)=
);
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Installed version: 0x%8.8x", get_unaligned_le32=
(p));
> +
> +       p =3D p + 4;
> +       bt_dev_info(hdev, "Fseq executed: %2.2u.%2.2u.%2.2u.%2.2u", p[0],=
 p[1],
> +                   p[2], p[3]);
> +
> +       p =3D p + 4;
> +       bt_dev_info(hdev, "Fseq BT Top: %2.2u.%2.2u.%2.2u.%2.2u", p[0], p=
[1],
> +                   p[2], p[3]);
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq Top init version: 0x%8.8x", get_unaligned_=
le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq Cnvio init version: 0x%8.8x", get_unaligne=
d_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq MBX Wifi file version: 0x%8.8x", get_unali=
gned_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq BT version: 0x%8.8x", get_unaligned_le32(p=
));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq Top reset address: 0x%8.8x", get_unaligned=
_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq MBX timeout: 0x%8.8x", get_unaligned_le32(=
p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq MBX ack: 0x%8.8x", get_unaligned_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq CNVi id: 0x%8.8x", get_unaligned_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq CNVr id: 0x%8.8x", get_unaligned_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq Error handle: 0x%8.8x", get_unaligned_le32=
(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq Magic noalive indication: 0x%8.8x", get_un=
aligned_le32(p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq OTP version: 0x%8.8x", get_unaligned_le32(=
p));
> +
> +       p =3D p + 4;
> +       bt_dev_dbg(hdev, "Fseq MBX otp version: 0x%8.8x", get_unaligned_l=
e32(p));
> +}
> +
>  static int btintel_setup_combined(struct hci_dev *hdev)
>  {
>         const u8 param[1] =3D { 0xFF };
> @@ -2902,6 +3007,7 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>
>                 err =3D btintel_bootloader_setup_tlv(hdev, &ver_tlv);
>                 btintel_register_devcoredump_support(hdev);
> +               btintel_print_fseq_info(hdev);
>                 break;
>         default:
>                 bt_dev_err(hdev, "Unsupported Intel hw variant (%u)",
> --
> 2.34.1
>
>


--=20
Luiz Augusto von Dentz
