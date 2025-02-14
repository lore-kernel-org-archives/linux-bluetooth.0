Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E0225B66C
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739532294; cv=none; b=JMYOI1pXU694bW9XmtmFiy7KIDbl1TLXes20hnS9Af1n5tLm2UxV+DTlaa0luZUybAqvPllvHSr4RCGsp1+jt4q5A1MTghzK+LfcUcEZBn8h8H5i6gLjHDHJHCPHMK6kEfqXqKCRoyhieXb9MJpEilB9D+HyvM8KGcFXz53ONqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739532294; c=relaxed/simple;
	bh=EmuaClIwsfnx5jc6JHN43wPeKcIb9ebxeANMYQgM4tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZbvYEVkN9TgSVWwoQxJEVN2qCHJKz03x78SKM66fpT8GS/dzEur7B1bUuYj3xHmk+N7Y+M2cJIw/f7qqGBMUuW/qMUCnO+07BMvo+KDRFurdzyXLc2ifRvraRfM49751dynU5CgKoB2gR00TxRhX5tEHfcsGXh+EkSS4HK6Luk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjXVkMYa; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjXVkMYa"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-6ef60e500d7so17285947b3.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Feb 2025 03:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739532290; x=1740137090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmplaivp4oINZl1YCs+lBq6U5w1N/DQ6P+FaLCl0MJU=;
        b=OjXVkMYaHGucl9AlNM76MQu8hwUygcDNft8vQyUxPF10BcMrktjk8zRzhRAzn9pIuO
         Pd0WE39OhDyfnse1w/E5dWpvK/8rrmSqcxejun78hTYPykdAT1+25zGpNcy8c5+7KNnn
         BuLhrHIf/xQeUyEBxf8bfsLzt9j/qkrDMec4E7K5wf6F3huClEzHI6WbV481FW2OXXBK
         U49WlQLta/zfAsv25w+44DzVOu+QetTwxS9xntvdp55pvNmXTGmIr+IUtFvsZ3Xq3E2S
         BvbtiGJxAbXhw5B/99EqFRy2kWHHZtR2YEw0O8cTc0Yk6PpOeG2vzjTN0+Na7JIXvopf
         J/3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739532290; x=1740137090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kmplaivp4oINZl1YCs+lBq6U5w1N/DQ6P+FaLCl0MJU=;
        b=LLke7M8BnXqDBLCbTiz/ccx1Dz38qV1U9fWnlN0UCRnCxivz7Yqc7V0VVIcQLomCaz
         /UWSMV0XyKsPebfMchXiSLoyvDbgVLH2wLqYyOsVDNtlyQqzQwrvMHgmEWwA5vpx4MKX
         kJIO3HfU2WvPDxAy/YOCOKpGeoAg6NRhbmezacRktWC8qvAqmkPOMGBjBFwozT2gTLPk
         XBSSoj3oMx2NcII3o8LTxQeG/DEx5OBjM7RdXNmeSXc8GPgEz4L4XH4L+MRW/fGgzJ3W
         2CfIj2fnuQ3+NTvI48y6dUG/X6l+YXiCsXFv1YI+rh4z2fbKqC8Z/vfpyT/f9jtMHHuF
         GvRw==
X-Gm-Message-State: AOJu0YwUFAdY8OtwfADfrliy0WHJhoNFktxLua0+rFwMZ5I5t/oG3U1i
	+PtA75xGAsOWqYPi9f3zPzFeRFqUoiAgIKxzeyF8+dQ4m3wXZ29uyGMBcyUD9bJbkCoWKnNxBHY
	aL5QEQ3ptICbfyFPBTyouavfG3OBzAJxj0qGIKIWzMJ35cE11hkV0
X-Gm-Gg: ASbGncs5jemNUZuzWK0EIEhIEJe72zXzkSvbv64/RcPNANYafdZHTTytgOLzGnPS5E7
	TRokXCWS6VBbZfCFeLaPdV1ZkON3HZglzLmsZO/WX548MsTaFua41VTaITL6vf5Al3KMJuxjMYg
	==
X-Google-Smtp-Source: AGHT+IHQCUU/xG4IWtOZT0rUW4fKzZ3bMGdJcwMI9q9h10ZPoKu5P9eeURFkukNUex0PSzsol9UbabrRwbNxagwf1TY=
X-Received: by 2002:a05:6902:2787:b0:e5d:babf:a8ff with SMTP id
 3f1490d57ef6-e5dbabfaaa2mr2446089276.48.1739532290119; Fri, 14 Feb 2025
 03:24:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
In-Reply-To: <20250214191615.v5.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
From: Hsin-chen Chuang <chharry@google.com>
Date: Fri, 14 Feb 2025 19:24:22 +0800
X-Gm-Features: AWEUYZmCaizkzoJJRU7GbLwIhNCDGYvWm6Wksp-nrI6IpNyF6HpPWFLhjDq0Efg
Message-ID: <CADg1FFfUP_hOMV5HKnUcX9ajO5DXP_cX2W_k7bHmZxkKqZU8uQ@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: Fix possible race with userspace of sysfs isoc_alt
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	gregkh@linuxfoundation.org
Cc: chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ying Hsu <yinghsu@chromium.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 14, 2025 at 7:16=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Expose the isoc_alt attr with device group to avoid the racing.
>
> Now we create a dev node for btusb. The isoc_alt attr belongs to it and
> it also becomes the parent device of hci dev.
>
> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
> Changes in v5:
> - Merge the ABI doc into this patch
> - Manage the driver data with device
>
> Changes in v4:
> - Create a dev node for btusb. It's now hci dev's parent and the
>   isoc_alt now belongs to it.
> - Since the changes is almost limitted in btusb, no need to add the
>   callbacks in hdev anymore.
>
> Changes in v3:
> - Make the attribute exported only when the isoc_alt is available.
> - In btusb_probe, determine data->isoc before calling hci_alloc_dev_priv
>   (which calls hci_init_sysfs).
> - Since hci_init_sysfs is called before btusb could modify the hdev,
>   add new argument add_isoc_alt_attr for btusb to inform hci_init_sysfs.
>
> Changes in v2:
> - The patch has been removed from series
>
>  .../ABI/stable/sysfs-class-bluetooth          |  13 ++
>  drivers/bluetooth/btusb.c                     | 111 ++++++++++++++----
>  include/net/bluetooth/hci_core.h              |   1 +
>  net/bluetooth/hci_sysfs.c                     |   3 +-
>  4 files changed, 102 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/ABI/stable/sysfs-class-bluetooth b/Documentati=
on/ABI/stable/sysfs-class-bluetooth
> index 36be02471174..c1024c7c4634 100644
> --- a/Documentation/ABI/stable/sysfs-class-bluetooth
> +++ b/Documentation/ABI/stable/sysfs-class-bluetooth
> @@ -7,3 +7,16 @@ Description:   This write-only attribute allows users to=
 trigger the vendor reset
>                 The reset may or may not be done through the device trans=
port
>                 (e.g., UART/USB), and can also be done through an out-of-=
band
>                 approach such as GPIO.
> +
> +What:          /sys/class/bluetooth/btusb<usb-intf>/isoc_alt
> +Date:          13-Feb-2025
> +KernelVersion: 6.13
> +Contact:       linux-bluetooth@vger.kernel.org
> +Description:   This attribute allows users to configure the USB Alternat=
e setting
> +               for the specific HCI device. Reading this attribute retur=
ns the
> +               current setting, and writing any supported numbers would =
change
> +               the setting. See the USB Alternate setting definition in =
Bluetooth
> +               core spec 5, vol 4, part B, table 2.1.
> +               If the HCI device is not yet init-ed, the write fails wit=
h -ENODEV.
> +               If the data is not a valid number, the write fails with -=
EINVAL.
> +               The other failures are vendor specific.
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 1caf7a071a73..e2fb3d08a5ed 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -920,6 +920,8 @@ struct btusb_data {
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>
>         struct qca_dump_info qca_dump;
> +
> +       struct device dev;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -3693,6 +3695,9 @@ static ssize_t isoc_alt_store(struct device *dev,
>         int alt;
>         int ret;
>
> +       if (!data->hdev)
> +               return -ENODEV;
> +
>         if (kstrtoint(buf, 10, &alt))
>                 return -EINVAL;
>
> @@ -3702,6 +3707,36 @@ static ssize_t isoc_alt_store(struct device *dev,
>
>  static DEVICE_ATTR_RW(isoc_alt);
>
> +static struct attribute *btusb_sysfs_attrs[] =3D {
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(btusb_sysfs);
> +
> +static void btusb_sysfs_release(struct device *dev)
> +{
> +       struct btusb_data *data =3D dev_get_drvdata(dev);
> +
> +       kfree(data);
> +}
> +
> +static const struct device_type btusb_sysfs =3D {
> +       .name    =3D "btusb",
> +       .release =3D btusb_sysfs_release,
> +       .groups  =3D btusb_sysfs_groups,
> +};
> +
> +static struct attribute *btusb_sysfs_isoc_alt_attrs[] =3D {
> +       &dev_attr_isoc_alt.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(btusb_sysfs_isoc_alt);
> +
> +static const struct device_type btusb_sysfs_isoc_alt =3D {
> +       .name    =3D "btusb",
> +       .release =3D btusb_sysfs_release,
> +       .groups  =3D btusb_sysfs_isoc_alt_groups,
> +};
> +
>  static int btusb_probe(struct usb_interface *intf,
>                        const struct usb_device_id *id)
>  {
> @@ -3743,7 +3778,7 @@ static int btusb_probe(struct usb_interface *intf,
>                         return -ENODEV;
>         }
>
> -       data =3D devm_kzalloc(&intf->dev, sizeof(*data), GFP_KERNEL);
> +       data =3D kzalloc(sizeof(*data), GFP_KERNEL);
>         if (!data)
>                 return -ENOMEM;
>
> @@ -3766,8 +3801,10 @@ static int btusb_probe(struct usb_interface *intf,
>                 }
>         }
>
> -       if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep)
> -               return -ENODEV;
> +       if (!data->intr_ep || !data->bulk_tx_ep || !data->bulk_rx_ep) {
> +               err =3D -ENODEV;
> +               goto out_free_data;
> +       }
>
>         if (id->driver_info & BTUSB_AMP) {
>                 data->cmdreq_type =3D USB_TYPE_CLASS | 0x01;
> @@ -3821,16 +3858,47 @@ static int btusb_probe(struct usb_interface *intf=
,
>
>         data->recv_acl =3D hci_recv_frame;
>
> +       if (id->driver_info & BTUSB_AMP) {
> +               /* AMP controllers do not support SCO packets */
> +               data->isoc =3D NULL;
> +       } else {
> +               /* Interface orders are hardcoded in the specification */
> +               data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> +               data->isoc_ifnum =3D ifnum_base + 1;
> +       }
> +
> +       if (id->driver_info & BTUSB_BROKEN_ISOC)
> +               data->isoc =3D NULL;
> +
> +       /* Init a dev for btusb. The attr depends on the support of isoc.=
 */
> +       if (data->isoc)
> +               data->dev.type =3D &btusb_sysfs_isoc_alt;
> +       else
> +               data->dev.type =3D &btusb_sysfs;
> +       data->dev.class =3D &bt_class;
> +       data->dev.parent =3D &intf->dev;
> +
> +       err =3D dev_set_name(&data->dev, "btusb%s", dev_name(&intf->dev))=
;
> +       if (err)
> +               goto out_free_data;
> +
> +       dev_set_drvdata(&data->dev, data);
> +       err =3D device_register(&data->dev);
> +       if (err < 0)
> +               goto out_put_sysfs;
> +
>         hdev =3D hci_alloc_dev_priv(priv_size);
> -       if (!hdev)
> -               return -ENOMEM;
> +       if (!hdev) {
> +               err =3D -ENOMEM;
> +               goto out_free_sysfs;
> +       }
>
>         hdev->bus =3D HCI_USB;
>         hci_set_drvdata(hdev, data);
>
>         data->hdev =3D hdev;
>
> -       SET_HCIDEV_DEV(hdev, &intf->dev);
> +       SET_HCIDEV_DEV(hdev, &data->dev);
>
>         reset_gpio =3D gpiod_get_optional(&data->udev->dev, "reset",
>                                         GPIOD_OUT_LOW);
> @@ -3969,15 +4037,6 @@ static int btusb_probe(struct usb_interface *intf,
>                 hci_set_msft_opcode(hdev, 0xFD70);
>         }
>
> -       if (id->driver_info & BTUSB_AMP) {
> -               /* AMP controllers do not support SCO packets */
> -               data->isoc =3D NULL;
> -       } else {
> -               /* Interface orders are hardcoded in the specification */
> -               data->isoc =3D usb_ifnum_to_if(data->udev, ifnum_base + 1=
);
> -               data->isoc_ifnum =3D ifnum_base + 1;
> -       }
> -
>         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
>             (id->driver_info & BTUSB_REALTEK)) {
>                 btrtl_set_driver_name(hdev, btusb_driver.name);
> @@ -4010,9 +4069,6 @@ static int btusb_probe(struct usb_interface *intf,
>                         set_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirk=
s);
>         }
>
> -       if (id->driver_info & BTUSB_BROKEN_ISOC)
> -               data->isoc =3D NULL;
> -
>         if (id->driver_info & BTUSB_WIDEBAND_SPEECH)
>                 set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirk=
s);
>
> @@ -4065,10 +4121,6 @@ static int btusb_probe(struct usb_interface *intf,
>                                                  data->isoc, data);
>                 if (err < 0)
>                         goto out_free_dev;
> -
> -               err =3D device_create_file(&intf->dev, &dev_attr_isoc_alt=
);
> -               if (err)
> -                       goto out_free_dev;
>         }
>
>         if (IS_ENABLED(CONFIG_BT_HCIBTUSB_BCM) && data->diag) {
> @@ -4099,6 +4151,16 @@ static int btusb_probe(struct usb_interface *intf,
>         if (data->reset_gpio)
>                 gpiod_put(data->reset_gpio);
>         hci_free_dev(hdev);
> +
> +out_free_sysfs:
> +       device_del(&data->dev);
> +
> +out_put_sysfs:
> +       put_device(&data->dev);
> +       return err;
> +
> +out_free_data:
> +       kfree(data);
>         return err;
>  }
>
> @@ -4115,10 +4177,8 @@ static void btusb_disconnect(struct usb_interface =
*intf)
>         hdev =3D data->hdev;
>         usb_set_intfdata(data->intf, NULL);
>
> -       if (data->isoc) {
> -               device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> +       if (data->isoc)
>                 usb_set_intfdata(data->isoc, NULL);
> -       }
>
>         if (data->diag)
>                 usb_set_intfdata(data->diag, NULL);
> @@ -4150,6 +4210,7 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>                 gpiod_put(data->reset_gpio);
>
>         hci_free_dev(hdev);
> +       device_unregister(&data->dev);
>  }
>
>  #ifdef CONFIG_PM
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 05919848ea95..776dd6183509 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -1843,6 +1843,7 @@ int hci_get_adv_monitor_offload_ext(struct hci_dev =
*hdev);
>
>  void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
>
> +extern const struct class bt_class;
>  void hci_init_sysfs(struct hci_dev *hdev);
>  void hci_conn_init_sysfs(struct hci_conn *conn);
>  void hci_conn_add_sysfs(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 041ce9adc378..aab3ffaa264c 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -6,9 +6,10 @@
>  #include <net/bluetooth/bluetooth.h>
>  #include <net/bluetooth/hci_core.h>
>
> -static const struct class bt_class =3D {
> +const struct class bt_class =3D {
>         .name =3D "bluetooth",
>  };
> +EXPORT_SYMBOL(bt_class);
>
>  static void bt_link_release(struct device *dev)
>  {
> --
> 2.48.1.601.g30ceb7b040-goog
>

Ouch, please kindly ignore this patch. I missed some discussion in V4

--=20
Best Regards,
Hsin-chen
