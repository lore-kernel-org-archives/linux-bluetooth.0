Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1621CC16B;
	Thu, 31 Oct 2024 20:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407657; cv=none; b=X4LREVP/ZycnycY7VJFDT3Q+aw+DnDegkp7i7K6u4za7wbqBqaUZ//+u9sDi3BssiRykU2BOXUwZo3b+jLWWSwnBjj5UVkW4ZQami79s06a6gx2HYo49Ye6TLJ7LpTKPtDZsU2I71iaBF/S06ZO+sYsPEaHO78KHJUEdJhL0xII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407657; c=relaxed/simple;
	bh=bW3r1GOUjnmEEut23Zy60HfbXPwBmvZhv/Bh41WLJqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uDxDGqguejc1C4dbDQvTqzc2USjchVNPV2frhayzq0X9ptxKjcsfSVBXL11pIlELj0AhqbkQAgIPWmwz6/FHHbEvxMeAG8v+V6iO+Bso8pZFeT9h9oGsyLXbfdMRNf4Z2slgY7Ta7jl1u446+Fz0uuyXGRQmT5q9el1KMcwZ7hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPWzQuY8; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPWzQuY8"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb3c3d5513so13015241fa.1;
        Thu, 31 Oct 2024 13:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730407649; x=1731012449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Db2U4domOiBP4WMLgKckjIoAtbkP3qo2IgLmobbYplg=;
        b=dPWzQuY8vma9gHsg2vXPQk+29NwQffnQqp88GMmsZRjh2GzvLLaxOeT0tlXbBfVUOC
         Q2lCYN7OnxGBQ+TPCul20MGGe1wduj1wYc8LaS2D9g0mcfhUrYl2BaDiY4HBsYgj0qNe
         kX7huGgSC0oJ4ie6Y5YsNIOJ18bSX40tBCxHqLoRXehD7WsQvtsd0DvA+yk27OwzN/IM
         tVDzzfv89t26ejkXHpU21e9nyfGgu6aaA9idpOw8m3tmcJH+jJgWt80oycQoJTs833mQ
         k+irszooYwLXb4o1M6UP3GVD9teVsLt3szhPj2RtpRrfJ/d422HFuVE0QoCOTCYRxaoV
         7iSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730407649; x=1731012449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Db2U4domOiBP4WMLgKckjIoAtbkP3qo2IgLmobbYplg=;
        b=n3t+lvExCjRhAIvSTmEGSXOw0Ffrh6dy+sEEZzMcGSO/9qPViw6P5D0N60+uilw/9F
         JU42NJfyH7aSMyy3kD2dFJImqVDuLBoHYCKqLb9fox5pjqndPE2tYaeJX15ERQR/rw20
         CIKFd0/hVpO9xdm++efv25WAMxLVB3T0+4w4VH5PH7VD/5ZYli9F7gLpNn6HKGyoDl1d
         rfcR04aYJ5QWq/2ZU7FzqJKd/C5SkbXvb4/L1guVqD5JGHaOFirJjFjooyEGv9P1K8Fy
         LkgUed14gucZsVaM7A+pNyRbGqY7k37m9Jvlw0SYncWRoNlsuwEkTZIZy2IY8QAh55+T
         5VXg==
X-Forwarded-Encrypted: i=1; AJvYcCUyhcz/ctunfmauF8LOKual/T69Cdcl5uvfzDH+lQfCmXSj1iYnXLvO0zntDD0eMQ5W7Ab4Y6e6skY13LV6Vw8=@vger.kernel.org, AJvYcCWrfIwJlFqGQ7QM+iPAoh0aUdVv81C32tQOlbpXjLBUn3l111jS2Z1Ki8ITB6lN3qRdOtyLy6qTvVRAe5Gi@vger.kernel.org
X-Gm-Message-State: AOJu0YxS01mx8jovNkfmIEJlOCCdL3SyGMQCRAfjXL7V8JDtyB51uIuw
	wH8DOVIbs7H1jxhFbwW+8Vja8ppe12tTL0YEVAKnEXoMnqoOXOkoKUtLiSQaBmVFJs3Yr3estyT
	KezYzlC+d7zPpgY4AFSr+0FDypRCTgkhE
X-Google-Smtp-Source: AGHT+IHsUr/DNAdmQCIknS2S/u7lhrVaZNdQYO4mhVofV8UcsuCwyyvpmg9M4/FQF0X0BMZ+zwFHg2vnhcnEbXu8qlc=
X-Received: by 2002:a2e:d1a:0:b0:2fa:fc3f:d603 with SMTP id
 38308e7fff4ca-2fdecc2f1b2mr20662631fa.43.1730407648915; Thu, 31 Oct 2024
 13:47:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030100804.2743115-1-hildawu@realtek.com>
In-Reply-To: <20241030100804.2743115-1-hildawu@realtek.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 31 Oct 2024 16:47:16 -0400
Message-ID: <CABBYNZ+PtSR-b1gpxdeDCV7qdDFP2ZxqBDS1ic4i=H1LUGBdWA@mail.gmail.com>
Subject: Re: [PATCH] bluetooth: add quirk using packet size 60
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, max.chou@realtek.com, alex_lu@realsil.com.cn, 
	kidman@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hilda,

On Wed, Oct 30, 2024 at 6:08=E2=80=AFAM Hilda Wu <hildawu@realtek.com> wrot=
e:
>
> The RTL8852BE-VT supports USB alternate setting 6.
> However, its descriptor does not report this capability to the host.
> Therefore, a quirk is needed to bypass the RTL8852BE-VT's descriptor
> and allow it to use USB ALT 6 directly.

It is getting very hackish trying to fixup the descriptor in software,
isn't it possible to update the USB descriptors via firmware update?
Not to mention you didn't include any logs of how this was tested, I
suppose this is for HFP/SCO wideband (using msbc), is that just plain
broken right now?

> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
>  drivers/bluetooth/btrtl.c |  3 ++
>  drivers/bluetooth/btrtl.h |  1 +
>  drivers/bluetooth/btusb.c | 89 ++++++++++++++++++++++++++++++---------
>  3 files changed, 73 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 0bcb44cf7b31..b75f0b36a09b 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1312,6 +1312,9 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct =
btrtl_device_info *btrtl_dev)
>                     btrtl_dev->project_id =3D=3D CHIP_ID_8852C)
>                         set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &h=
dev->quirks);
>
> +               if (btrtl_dev->project_id =3D=3D CHIP_ID_8852BT)
> +                       btrealtek_set_flag(hdev, REALTEK_ALT6_FORCE);
> +
>                 hci_set_aosp_capable(hdev);
>                 break;
>         default:
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..ffec2fca88ec 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
>
>  enum {
>         REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +       REALTEK_ALT6_FORCE,
>
>         __REALTEK_NUM_FLAGS,
>  };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 514d593923ad..eca0b173232e 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -804,6 +804,7 @@ struct qca_dump_info {
>  #define BTUSB_USE_ALT3_FOR_WBS 15
>  #define BTUSB_ALT6_CONTINUOUS_TX       16
>  #define BTUSB_HW_SSR_ACTIVE    17
> +#define BTUSB_ALT_CHANGED      18
>
>  struct btusb_data {
>         struct hci_dev       *hdev;
> @@ -2130,16 +2131,61 @@ static void btusb_notify(struct hci_dev *hdev, un=
signed int evt)
>         }
>  }
>
> +static struct usb_host_interface *btusb_find_altsetting(struct btusb_dat=
a *data,
> +                                                       int alt)
> +{
> +       struct usb_interface *intf =3D data->isoc;
> +       int i;
> +
> +       BT_DBG("Looking for Alt no :%d", alt);
> +
> +       if (!intf)
> +               return NULL;
> +
> +       for (i =3D 0; i < intf->num_altsetting; i++) {
> +               if (intf->altsetting[i].desc.bAlternateSetting =3D=3D alt=
)
> +                       return &intf->altsetting[i];
> +       }
> +
> +       return NULL;
> +}
> +
>  static inline int __set_isoc_interface(struct hci_dev *hdev, int altsett=
ing)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
>         struct usb_interface *intf =3D data->isoc;
>         struct usb_endpoint_descriptor *ep_desc;
> +       struct usb_host_interface *alt;
>         int i, err;
>
>         if (!data->isoc)
>                 return -ENODEV;
>
> +       /* For some Realtek chips, they actually have the altsetting 6, b=
ut its
> +        * altsetting descriptor is not exposed. We can activate altsetti=
ng 6 by
> +        * replacing the altsetting 5.
> +        */
> +       if (altsetting =3D=3D 6 && !btusb_find_altsetting(data, 6) &&
> +           btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE)) {
> +               alt =3D NULL;
> +               for (i =3D 0; i < intf->num_altsetting; i++) {
> +                       if (intf->altsetting[i].desc.bAlternateSetting =
=3D=3D 5) {
> +                               alt =3D &intf->altsetting[i];
> +                               break;
> +                       }
> +               }

I believe you can replace the code above with btusb_find_altsetting so
please use that instead of duplicating its logic.

> +               if (alt) {
> +                       for (i =3D 0; i < alt->desc.bNumEndpoints; i++) {
> +                               ep_desc =3D &alt->endpoint[i].desc;
> +                               if (usb_endpoint_is_isoc_out(ep_desc) ||
> +                                   usb_endpoint_is_isoc_in(ep_desc))
> +                                       ep_desc->wMaxPacketSize =3D 63;
> +                       }
> +                       alt->desc.bAlternateSetting =3D 6;
> +                       set_bit(BTUSB_ALT_CHANGED, &data->flags);
> +               }
> +       }
> +
>         err =3D usb_set_interface(data->udev, data->isoc_ifnum, altsettin=
g);
>         if (err < 0) {
>                 bt_dev_err(hdev, "setting interface failed (%d)", -err);
> @@ -2151,6 +2197,27 @@ static inline int __set_isoc_interface(struct hci_=
dev *hdev, int altsetting)
>         data->isoc_tx_ep =3D NULL;
>         data->isoc_rx_ep =3D NULL;
>
> +       /* Recover alt 5 desc if alt 0 is set. */
> +       if (!altsetting && test_bit(BTUSB_ALT_CHANGED, &data->flags)) {
> +               alt =3D NULL;
> +               for (i =3D 0; i < intf->num_altsetting; i++) {
> +                       if (intf->altsetting[i].desc.bAlternateSetting =
=3D=3D 6) {
> +                               alt =3D &intf->altsetting[i];
> +                               break;
> +                       }
> +               }

Ditto.

> +               if (alt) {
> +                       for (i =3D 0; i < alt->desc.bNumEndpoints; i++) {
> +                               ep_desc =3D &alt->endpoint[i].desc;
> +                               if (usb_endpoint_is_isoc_out(ep_desc) ||
> +                                   usb_endpoint_is_isoc_in(ep_desc))
> +                                       ep_desc->wMaxPacketSize =3D 49;
> +                       }
> +                       alt->desc.bAlternateSetting =3D 5;
> +                       clear_bit(BTUSB_ALT_CHANGED, &data->flags);
> +               }
> +       }
> +
>         for (i =3D 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) =
{
>                 ep_desc =3D &intf->cur_altsetting->endpoint[i].desc;
>
> @@ -2213,25 +2280,6 @@ static int btusb_switch_alt_setting(struct hci_dev=
 *hdev, int new_alts)
>         return 0;
>  }
>
> -static struct usb_host_interface *btusb_find_altsetting(struct btusb_dat=
a *data,
> -                                                       int alt)
> -{
> -       struct usb_interface *intf =3D data->isoc;
> -       int i;
> -
> -       BT_DBG("Looking for Alt no :%d", alt);
> -
> -       if (!intf)
> -               return NULL;
> -
> -       for (i =3D 0; i < intf->num_altsetting; i++) {
> -               if (intf->altsetting[i].desc.bAlternateSetting =3D=3D alt=
)
> -                       return &intf->altsetting[i];
> -       }
> -
> -       return NULL;
> -}
> -
>  static void btusb_work(struct work_struct *work)
>  {
>         struct btusb_data *data =3D container_of(work, struct btusb_data,=
 work);
> @@ -2269,7 +2317,8 @@ static void btusb_work(struct work_struct *work)
>                          * MTU >=3D 3 (packets) * 25 (size) - 3 (headers)=
 =3D 72
>                          * see also Core spec 5, vol 4, B 2.1.1 & Table 2=
.1.
>                          */
> -                       if (btusb_find_altsetting(data, 6))
> +                       if (btusb_find_altsetting(data, 6) ||
> +                           btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE)=
)
>                                 new_alts =3D 6;
>                         else if (btusb_find_altsetting(data, 3) &&
>                                  hdev->sco_mtu >=3D 72 &&
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz
