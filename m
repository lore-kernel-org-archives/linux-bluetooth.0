Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC654C7D;
	Mon, 24 Feb 2025 02:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365627; cv=none; b=BxcMfqhtdug8pCTWzxmbgv21cp0q+RZdTtXdT+4M3Wr3/t0QZ2Ni4o6zbiq4u/zmOh5hXlozpdzU117qwtRHQGUDHIjMQP2Pk4h7YfNKZXN2u9idVCcfaXHCbQhyWyGzWPznBXJdGGTBaGw4lLeJETIPXSTRBOt6BRgDjo+XHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365627; c=relaxed/simple;
	bh=foijeL5Itsh9S+L85UT7/IAoZ6MDUM4hQeHzc7LG7Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZLhkTIDi0JY9emi48sG+K6XGMTXyRYzYhfl4GhPNn+dvxrTh4gpjDqZh+QLwCqTJ0C9FCiFoSlNaKXw+lmb7YRkueB5t3lk6iNao0ZLLzjDnBh/iu5vzyzaTj5ZECZFKLv7XpArwoB4skDluFFTk81+74UqDMf5IL+lS36NVilc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7/MPFk3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7/MPFk3"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-307c13298eeso45735131fa.0;
        Sun, 23 Feb 2025 18:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740365623; x=1740970423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzTyM5TX4Isho0QNHdXsuq7CrMUhrffDZoeBkIIsq2I=;
        b=l7/MPFk3dwSWwLQ/lTP4jQ4Cfa5hReCbG69Xi/1jSn6EJuFnB44Wudj/rIRNxdhmgo
         2GQu7x3C0ER/MbgGWfyCDHqdhzVNcyYgwNuCzmVSMyQHrj5bGnYIy1bv1hNbT45kSJrn
         iFraTwHBSaPBfCT71YMOGozBSzWSoBpS/omsRVqjz7Bfw75k87EQKLaJEE2BrzOtuAZI
         F3l2u902Pyt+Mlq1ek8TpqLISvGZvv07hYZNsg75DUiS4v8aiHRruk9VdiNax/8Wsm0l
         M3crw1d8DjNZSR3neLYloshJad0hNPwex4E4VNYl7/Kn+fLCIIInLDaVLxdC9wN8f5nF
         LeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740365623; x=1740970423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CzTyM5TX4Isho0QNHdXsuq7CrMUhrffDZoeBkIIsq2I=;
        b=hFErsFYLZYGtRBrud210gLnb2wX+t8n4/j6nIbtaIEDBatnAlSPF1f04DRtVyfpNbE
         VmGVcFty8KshWE46OsNrAhjqdI5G76pcYQljMZNqWbRbiCOGqXrOAu3tPTiBEXU8rkFF
         JSP1E9i2ImJbCu7mjkZIwU7Vta+TBqoCJ34nk4p/DeX0Zpwup2EH/rkQVGn504j+LpuB
         c2YkEx4UhMO5p2zdivC34AJESObz4MZXHa9Kc2cGiDEATQbFV+FrY//70blZtYkIDDDV
         EE5KNPypDn/JMW06OgCTFkj9dXekf/PmbdB+61Z2+48qd5QynA/wdPddWtX0hMyzSeQX
         gjeg==
X-Forwarded-Encrypted: i=1; AJvYcCUKJ8wSD8Qs31p4sRb7RrQJmr3RI/xElD75adfIw2LmSARmLRMKKSG8KRLvpDXrDm2YOgNdMwcu/U34QtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ+wMaB52wCGMonFm2V9oa+xOPV6aNHcO+Kv3oWDsxhGE24a9E
	xBL9ITV4/UsYzrn/xjv87TmizEb3iRPuz4/iBcDZVbsa+yPEjTA7HW9i8swsIk85RFnYqPwupuC
	phxmzWS1LM4W2tF1UHbke/g79bb8=
X-Gm-Gg: ASbGnctvawZVMzHtk7qMnV8BOWG/CzRSpATPZThLAaLZudVLxk0Ah548kapbDGKewgS
	qGkRaPXijab26ti2smrWFr1MTKXMXb4NTrmKJLV3NS4du2qfaHpXrB3Va5+7iyG1M8nnEQBOsWO
	WBKgUPYWsE
X-Google-Smtp-Source: AGHT+IEOx/eylnXhvhD90oQhCfOgz4Sw/IZohmH0LqS23uWAJioZj91bMDhQXN43VG/mxStFdEBCd5gsCU82MoL7BgI=
X-Received: by 2002:a2e:b4a3:0:b0:30a:24bf:898d with SMTP id
 38308e7fff4ca-30a5065136bmr61687971fa.18.1740365622708; Sun, 23 Feb 2025
 18:53:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224022447.1141413-1-chharry@google.com>
In-Reply-To: <20250224022447.1141413-1-chharry@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 23 Feb 2025 21:53:28 -0500
X-Gm-Features: AWEUYZmE6u5kkTElQlu4aoa5HMerPruPeV8ap1kBStDn-Js-u-QqfPtjTbK7NKI
Message-ID: <CABBYNZJUd1wU0wyPugz4E_WNQsg9qTJmWdu4k2GvvvgVFG8GPQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Sun, Feb 23, 2025 at 9:26=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> From: Hsin-chen Chuang <chharry@chromium.org>
>
> Automatically configure the altsetting for USER_CHANNEL when a SCO is
> connected or disconnected. This adds support for the USER_CHANNEL to
> transfer SCO data over USB transport.

I guess the tracking of handles is about handling disconnections,
right? I wonder if we can get away without doing that, I didn't intend
to add a whole bunch of changes in order to switch to the right mode,
I get that you may want to disable the isochronous endpoint in case
there is no connection, but I guess that only matters if we are
talking about power but the impact is probably small so I don't think
it is worth it. There is an alternative to match the SCO/eSCO handle
via mask, like we do with ISO handles, that is probably a lot cheaper
than attempting to add a whole list for tracking handles, but it has
the downside that it is vendor/model specific.

> Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control US=
B alt setting")
> Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> ---
>
>  drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-------
>  1 file changed, 186 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index de3fa725d210..dfb0918dfe98 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -854,6 +854,11 @@ struct qca_dump_info {
>  #define BTUSB_ALT6_CONTINUOUS_TX       16
>  #define BTUSB_HW_SSR_ACTIVE    17
>
> +struct sco_handle_list {
> +       struct list_head list;
> +       u16 handle;
> +};
> +
>  struct btusb_data {
>         struct hci_dev       *hdev;
>         struct usb_device    *udev;
> @@ -920,6 +925,9 @@ struct btusb_data {
>         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
>
>         struct qca_dump_info qca_dump;
> +
> +       /* Records the exsiting SCO handles for HCI_USER_CHANNEL */
> +       struct list_head sco_handle_list;
>  };
>
>  static void btusb_reset(struct hci_dev *hdev)
> @@ -1113,6 +1121,131 @@ static inline void btusb_free_frags(struct btusb_=
data *data)
>         spin_unlock_irqrestore(&data->rxlock, flags);
>  }
>
> +static void btusb_sco_handle_list_clear(struct list_head *list)
> +{
> +       struct sco_handle_list *entry, *n;
> +
> +       list_for_each_entry_safe(entry, n, list, list) {
> +               list_del(&entry->list);
> +               kfree(entry);
> +       }
> +}
> +
> +static struct sco_handle_list *btusb_sco_handle_list_find(
> +       struct list_head *list,
> +       u16 handle)
> +{
> +       struct sco_handle_list *entry;
> +
> +       list_for_each_entry(entry, list, list)
> +               if (entry->handle =3D=3D handle)
> +                       return entry;
> +
> +       return NULL;
> +}
> +
> +static int btusb_sco_handle_list_add(struct list_head *list, u16 handle)
> +{
> +       struct sco_handle_list *entry;
> +
> +       if (btusb_sco_handle_list_find(list, handle))
> +               return -EEXIST;
> +
> +       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> +       if (!entry)
> +               return -ENOMEM;
> +
> +       entry->handle =3D handle;
> +       list_add(&entry->list, list);
> +
> +       return 0;
> +}
> +
> +static int btusb_sco_handle_list_del(struct list_head *list, u16 handle)
> +{
> +       struct sco_handle_list *entry;
> +
> +       entry =3D btusb_sco_handle_list_find(list, handle);
> +       if (!entry)
> +               return -ENOENT;
> +
> +       list_del(&entry->list);
> +       kfree(entry);
> +
> +       return 0;
> +}
> +
> +static void btusb_sco_conn_change(struct btusb_data *data, struct sk_buf=
f *skb)
> +{
> +       struct hci_event_hdr *hdr =3D (void *) skb->data;
> +       struct hci_dev *hdev =3D data->hdev;
> +
> +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT || skb->len < sizeof=
(*hdr))
> +               return;
> +
> +       switch (hdr->evt) {
> +       case HCI_EV_DISCONN_COMPLETE: {
> +               struct hci_ev_disconn_complete *ev =3D
> +                       (void *) skb->data + sizeof(*hdr);
> +               u16 handle;
> +
> +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->statu=
s)
> +                       return;
> +
> +               handle =3D __le16_to_cpu(ev->handle);
> +               if (btusb_sco_handle_list_del(&data->sco_handle_list,
> +                                             handle) < 0)
> +                       return;
> +
> +               bt_dev_info(hdev, "disabling SCO");
> +               data->sco_num--;
> +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> +               schedule_work(&data->work);
> +
> +               break;
> +       }
> +       case HCI_EV_SYNC_CONN_COMPLETE: {
> +               struct hci_ev_sync_conn_complete *ev =3D
> +                       (void *) skb->data + sizeof(*hdr);
> +               unsigned int notify_air_mode;
> +               u16 handle;
> +
> +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->statu=
s)
> +                       return;
> +
> +               switch (ev->air_mode) {
> +               case BT_CODEC_CVSD:
> +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> +                       break;
> +
> +               case BT_CODEC_TRANSPARENT:
> +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> +                       break;
> +
> +               default:
> +                       return;
> +               }
> +
> +               handle =3D __le16_to_cpu(ev->handle);
> +               if (btusb_sco_handle_list_add(&data->sco_handle_list,
> +                                             handle) < 0) {
> +                       bt_dev_err(hdev, "failed to add the new SCO handl=
e");
> +                       return;
> +               }
> +
> +               bt_dev_info(hdev, "enabling SCO with air mode %u",
> +                           ev->air_mode);
> +               data->sco_num++;
> +               data->air_mode =3D notify_air_mode;
> +               schedule_work(&data->work);
> +
> +               break;
> +       }
> +       default:
> +               break;
> +       }
> +}
> +
>  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *skb=
)
>  {
>         if (data->intr_interval) {
> @@ -1120,6 +1253,10 @@ static int btusb_recv_event(struct btusb_data *dat=
a, struct sk_buff *skb)
>                 schedule_delayed_work(&data->rx_work, 0);
>         }
>
> +       /* Configure altsetting for HCI_USER_CHANNEL on SCO dis/connected=
 */
> +       if (hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> +               btusb_sco_conn_change(data, skb);

I'd recommend adding a check for Kconfig/module parameter in the if
statement so btusb_sco_conn_change only runs on distros with it
enabled so we don't risk something not working as expected just
because someone decided to open the user channel.

>         return data->recv_event(data->hdev, skb);
>  }
>
> @@ -1919,44 +2056,6 @@ static void btusb_stop_traffic(struct btusb_data *=
data)
>         usb_kill_anchored_urbs(&data->ctrl_anchor);
>  }
>
> -static int btusb_close(struct hci_dev *hdev)
> -{
> -       struct btusb_data *data =3D hci_get_drvdata(hdev);
> -       int err;
> -
> -       BT_DBG("%s", hdev->name);
> -
> -       cancel_delayed_work(&data->rx_work);
> -       cancel_work_sync(&data->work);
> -       cancel_work_sync(&data->waker);
> -
> -       skb_queue_purge(&data->acl_q);
> -
> -       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> -       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> -       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> -       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> -
> -       btusb_stop_traffic(data);
> -       btusb_free_frags(data);
> -
> -       err =3D usb_autopm_get_interface(data->intf);
> -       if (err < 0)
> -               goto failed;
> -
> -       data->intf->needs_remote_wakeup =3D 0;
> -
> -       /* Enable remote wake up for auto-suspend */
> -       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> -               data->intf->needs_remote_wakeup =3D 1;
> -
> -       usb_autopm_put_interface(data->intf);
> -
> -failed:
> -       usb_scuttle_anchored_urbs(&data->deferred);
> -       return 0;
> -}
> -
>  static int btusb_flush(struct hci_dev *hdev)
>  {
>         struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -2327,6 +2426,51 @@ static void btusb_work(struct work_struct *work)
>         }
>  }
>
> +static int btusb_close(struct hci_dev *hdev)
> +{
> +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> +       int err;
> +
> +       BT_DBG("%s", hdev->name);
> +
> +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> +               btusb_sco_handle_list_clear(&data->sco_handle_list);
> +               data->sco_num =3D 0;
> +               if (data->isoc_altsetting !=3D 0)
> +                       btusb_switch_alt_setting(hdev, 0);
> +       }
> +
> +       cancel_delayed_work(&data->rx_work);
> +       cancel_work_sync(&data->work);
> +       cancel_work_sync(&data->waker);
> +
> +       skb_queue_purge(&data->acl_q);
> +
> +       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> +       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> +       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> +       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> +
> +       btusb_stop_traffic(data);
> +       btusb_free_frags(data);
> +
> +       err =3D usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               goto failed;
> +
> +       data->intf->needs_remote_wakeup =3D 0;
> +
> +       /* Enable remote wake up for auto-suspend */
> +       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> +               data->intf->needs_remote_wakeup =3D 1;
> +
> +       usb_autopm_put_interface(data->intf);
> +
> +failed:
> +       usb_scuttle_anchored_urbs(&data->deferred);
> +       return 0;
> +}
> +
>  static void btusb_waker(struct work_struct *work)
>  {
>         struct btusb_data *data =3D container_of(work, struct btusb_data,=
 waker);
> @@ -3782,6 +3926,8 @@ static int btusb_probe(struct usb_interface *intf,
>         data->udev =3D interface_to_usbdev(intf);
>         data->intf =3D intf;
>
> +       INIT_LIST_HEAD(&data->sco_handle_list);
> +
>         INIT_WORK(&data->work, btusb_work);
>         INIT_WORK(&data->waker, btusb_waker);
>         INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> @@ -4117,6 +4263,8 @@ static void btusb_disconnect(struct usb_interface *=
intf)
>         hdev =3D data->hdev;
>         usb_set_intfdata(data->intf, NULL);
>
> +       btusb_sco_handle_list_clear(&data->sco_handle_list);
> +
>         if (data->isoc) {
>                 device_remove_file(&intf->dev, &dev_attr_isoc_alt);
>                 usb_set_intfdata(data->isoc, NULL);
> --
> 2.48.1.601.g30ceb7b040-goog
>


--=20
Luiz Augusto von Dentz
