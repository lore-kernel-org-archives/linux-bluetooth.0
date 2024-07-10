Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB231190074;
	Wed, 10 Jul 2024 12:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720614034; cv=none; b=KA0p6tQaIve206YIlNFlK9UnfeAehwQIB4aVxUpfFT0HaiczyLbGYKsXQf0lwcwTN6K0EyxR/yBLOQBMjgg2gMMjvLwyqz6CU44iMPFOdGEjkhJoPMs+FvEsfbTF2dLHbiXkvgaIOUaXGDccPEeV1T8ZPdMqfn5O2gHQ9l/M5c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720614034; c=relaxed/simple;
	bh=GA97M7Skw6Z5xG4aEkaYhA7E0iwKejxbW3njXe0jTeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YrJXBqw9+11N44OCjYRLric7rZ6MTDxOl/0DIgSsMJ/i5skEhiu6S62SxKkQ0IcZmpGhAUg4nv5PI+0AFFvBHDk/on23u4GDB4ycQowQOL+MfWkUqAPUKTZcvhqEvPvqbX0/ANLiVd9V053AoIp9zh4szPHd2GyCJgeXG+SOeR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HUIDmKWH; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUIDmKWH"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-75ee39f1ffbso4457394a12.2;
        Wed, 10 Jul 2024 05:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720614032; x=1721218832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvQpnoDjoDpI50LV+48+mtvnut3O6+hbvKZt5JaS7n4=;
        b=HUIDmKWHwk3diVKR5lzbZp1zZE+B8gXw8fUG5nwRHMRIxiT/zRLeH5StFoRHp0L7HL
         TdOilam82W+CPFBlEmxdKHAfRMLHpLhOz/64KmZgfo2sQMRgWrTPzneuSDaASsbqbs7G
         IPogOKsWBttjt9N5IR1DKmGo0DETx+PRgjqVV5aXmMTOy2+e29AZKAvEzKm8zIldpK6R
         KmPDhgjdXP7Z9SVVWWIDPARYCcXqZ9m0oOiLgjUyyHhoclOx1erzdnbh6KPk0BnuO7iX
         eJSK4voT5frQhUeFuu/SGYoQ6XFwWHEF+ymbBe7pBS7gi0rxWqZmd4uaS9NC7b2pQYjB
         Zumg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720614032; x=1721218832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HvQpnoDjoDpI50LV+48+mtvnut3O6+hbvKZt5JaS7n4=;
        b=hgIjqejQ885gglBQUgJ+V4eWAEgcEkpGR0159BNmIbei6GHj4AtqCKSL1airNa2ZdY
         pPwjk8aJQbJwmJNSUzTzLa0srHSccgkCg/yC8zQqGqrM6MmaP+feT4lan8mrswtAYxSU
         9Sf7jgzRp33dS9MJnN7Nnwovb/fiWyZks6NKhroicusomyzhe1wGgxjbY993+9ePEvth
         Kku5Rl7Zm1o38vLTqYS1SsCGNdi8TG0y7RLZ0ciVizqDeg1VULQeupn1DUYnTQWV3eB3
         Do9YDIlWuUgAuRtJLjfXiVhE3uhG6BFUtAiyTCF/0FN4tHLvtTbtX7aTPHC9kUw4cRbz
         6Lgw==
X-Forwarded-Encrypted: i=1; AJvYcCWDutMDeScy+Rjg0N4clIXrgBvhtZFsIIxgMF7cj4s1RT6lK055+a9vtYkt2fwo2dhio1yMe+XhI5905d84M3bVAIgHqKjBn+Nh8cvNzeqf6MCKqzRGKJVejfOD8P4R4W0BsdrPSAO+KPQpvkPn
X-Gm-Message-State: AOJu0YwIvdp63G0LCcp3g4dP00KKb9CgzoqfoMgRhJzjrt9Ltk98Fgkw
	HM351zYUtnwQU+kf2wn0Qi7K/bnXlqNWovKh9DcxW2ucZ4FWU2RmWPjrwGAuDOcTW9950RjYOtA
	mdBpPha5c3E3kb+z8qXo0DknyFEInvw==
X-Google-Smtp-Source: AGHT+IFGd8/NaTt8bBK3q51jUrH0J0reuzi+z80yAos5DxqdigxYXohUYHVvXxa+g72Kmjli7ngIw45bHloBrJGAaPc=
X-Received: by 2002:a05:6a20:7fa4:b0:1c0:dd3d:ef3a with SMTP id
 adf61e73a8af0-1c29824acaemr6326902637.29.1720614031912; Wed, 10 Jul 2024
 05:20:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710073832.4381-1-chris.lu@mediatek.com>
In-Reply-To: <20240710073832.4381-1-chris.lu@mediatek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 10 Jul 2024 08:20:17 -0400
Message-ID: <CABBYNZLOn4pAnx70afymGWR=XRzeO4WshaX2Swew9GGp6CRnvw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Fix btmtk.c undefined reference build error
To: Chris Lu <chris.lu@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Sean Wang <sean.wang@mediatek.com>, Aaron Hou <aaron.hou@mediatek.com>, 
	Steve Lee <steve.lee@mediatek.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chris,

On Wed, Jul 10, 2024 at 3:38=E2=80=AFAM Chris Lu <chris.lu@mediatek.com> wr=
ote:
>
> MediaTek move some usb interface related function to btmtk.c which
> may cause build failed if BT USB Kconfig wasn't enabled.
> Fix undefined reference by adding config check.
>
> Fixes: 39a9e1c69e74 Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmt=
k.c
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202407091928.AH0aGZnx-lkp@i=
ntel.com/
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 2 ++
>  drivers/bluetooth/btmtk.h | 4 ++++
>  2 files changed, 6 insertions(+)
>
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index b7c348687a77..9789296ad4f6 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -437,6 +437,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, stru=
ct sk_buff *skb)
>  }
>  EXPORT_SYMBOL_GPL(btmtk_process_coredump);
>
> +#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
>  static void btmtk_usb_wmt_recv(struct urb *urb)
>  {
>         struct hci_dev *hdev =3D urb->context;
> @@ -1487,6 +1488,7 @@ int btmtk_usb_shutdown(struct hci_dev *hdev)
>         return 0;
>  }
>  EXPORT_SYMBOL_GPL(btmtk_usb_shutdown);
> +#endif
>
>  MODULE_AUTHOR("Sean Wang <sean.wang@mediatek.com>");
>  MODULE_AUTHOR("Mark Chen <mark-yw.chen@mediatek.com>");
> diff --git a/drivers/bluetooth/btmtk.h b/drivers/bluetooth/btmtk.h
> index 453ed5131a37..890dbe9beff8 100644
> --- a/drivers/bluetooth/btmtk.h
> +++ b/drivers/bluetooth/btmtk.h
> @@ -165,6 +165,7 @@ struct btmtk_data {
>         btmtk_reset_sync_func_t reset_sync;
>         struct btmtk_coredump_info cd_info;
>
> +#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
>         struct usb_device *udev;
>         struct usb_interface *intf;
>         struct usb_anchor *ctrl_anchor;
> @@ -177,6 +178,7 @@ struct btmtk_data {
>
>         /* spinlock for ISO data transmission */
>         spinlock_t isorxlock;
> +#endif

If I recall this correctly it is not a good practice to use #if inside
structs as it would change its overall size, memory layout, etc, and
it also makes it difficult to use if (IS_DEFINED) and let the compiler
eliminate dead code instead of using the preprocessor like you doing.

>  };
>
>  typedef int (*wmt_cmd_sync_func_t)(struct hci_dev *,
> @@ -202,6 +204,7 @@ int btmtk_process_coredump(struct hci_dev *hdev, stru=
ct sk_buff *skb);
>  void btmtk_fw_get_filename(char *buf, size_t size, u32 dev_id, u32 fw_ve=
r,
>                            u32 fw_flavor);
>
> +#if IS_ENABLED(CONFIG_BT_HCIBTUSB_MTK)
>  int btmtk_usb_subsys_reset(struct hci_dev *hdev, u32 dev_id);
>
>  int btmtk_usb_recv_acl(struct hci_dev *hdev, struct sk_buff *skb);
> @@ -216,6 +219,7 @@ int btmtk_usb_suspend(struct hci_dev *hdev);
>  int btmtk_usb_setup(struct hci_dev *hdev);
>
>  int btmtk_usb_shutdown(struct hci_dev *hdev);
> +#endif
>  #else
>
>  static inline int btmtk_set_bdaddr(struct hci_dev *hdev,
> --
> 2.18.0
>


--=20
Luiz Augusto von Dentz
