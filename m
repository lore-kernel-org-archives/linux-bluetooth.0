Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB41F60A
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740367265; cv=none; b=AXnghz6LJVWb3my75UEm5KP+qUK7/Iid2xiY+j9TUwaQSxBBb4ND0XK648vN5zB0hxyQeau0WpvtFm3iLWNf4KmfWDSPiYpRTFV/p07fyVv2pyT+bLp5DoGFj7IaEp2Vqlo96zGmqGEwPf2Pf6WAa2fyvIg3kS1XilbOb96JLdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740367265; c=relaxed/simple;
	bh=12UbkbL3ozhmpAXcWhDiB6a+27sLxl6aSj4n9qWN8hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=af5Gk5UEdxXEz6vC0rKyGr7CLeDhIANz4xx8lhGg/YbNwt7jxekZR+lqNmgw54dG/8vcErwICrjtVJfus0YX5a7W6Xtm7XdZr88j888vbsP3biBO2OZS/SW2UXXUps1OffXRMX0DT4CXBXFEfJz2ylgTMWheFoSO9/Kt3JFI49k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fS/B//x2; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fS/B//x2"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e589c258663so4247495276.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 19:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740367263; x=1740972063; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jj056RohTndyRUjZE+5/HofNr1PVX5M2m/PLSiWGtqU=;
        b=fS/B//x2U0Khu1SXSzw/En7lGTsLOs2RynmWlZRSoEEW6Kc10xjF932sWCdAVQE1Gu
         ogdLAeF+eJsLNXaOoEYqchP+FbVjFgYjvPJ7F1qVan6Umd1Qe0hkhVsGwg2594AoZNST
         E8FIuL9iLZWB/+paqGqxFUUMkCggWmgZio5LyyVhLJSkgwGAW4VPkIHgHr9VfwdNdfbo
         WsiNRABMe66qoVzDttF5vFqlTJCkAQdVz1mdSKMX7R95KqyZETmZNplYrlPTxtknZWQN
         uPiqJrmeYlVAUgx1BBiSJWfSATznEa938KMvJZRv3AVTYbQizGBgqaUILEJqOCossIr5
         UjCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740367263; x=1740972063;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jj056RohTndyRUjZE+5/HofNr1PVX5M2m/PLSiWGtqU=;
        b=dR5l5Sq2mY2kNTcUjLbKGQy4guhXFCwkkyoalVipbttzk4fMMsL3gNY8PFqGBYS4VK
         tCbcV+tDeS/alc5c1IVZfgcYH89yX0dSplV3hCMb2+IdpYeKXBzT4H7+8A+gs08Cy3hO
         byT6+SG26M9jNStdxyqJVqQRfc67GA6uf6ug3XOGlp9DPU1SY655EcZFT1dUlakzyXuL
         s/0cv7tuIe2YzkTYBkYGne22/3yJg1kwRiKDIXU/+DJ/ekcYUycM0839mp6tFbuNKbrT
         huxeMZlHO/khRDrtqWJmgm5tu2UHs5p+lI+dueBe/dBXAxoHyshoENDGVC+WEAL/hCEA
         0FCQ==
X-Gm-Message-State: AOJu0YzUGRiqhllIgKNO2r/tJN/YOASJ34JPpCjPRVIFto7BKydto4gz
	ygrFyRUJeFOcZTVXOrM0W9n7qZbtuOLQtwAuRku9B9aKv6LL/c3JtW1pwk39T6yJg5kKPDXIjwr
	VrEAn5bb+3rmXGSoKySy5P8Mp+DKAUDj/IFV4
X-Gm-Gg: ASbGncvJEwdV6vTA2/TxR1NZ+LZ/LKy+4egqO+CksSS3l0qr2JN+hSppvbNbOI/g63m
	9mdbGawBqu5P+y1obBw0XSokQiKN9/UH4zCjLNYgWfLvAoGcUCbnfj9Lg05DlkzjXA1IQ2YiJxu
	qRfH2RWh1u
X-Google-Smtp-Source: AGHT+IGnpdeKq2mo7hAEXDBjgVX9tl9uUGDpTCVsHdsl0G227e7Jqs4YHua8P9eDNAop3fdhmDQOHcglbkMATWuYg98=
X-Received: by 2002:a05:6902:330e:b0:e5d:d78d:e973 with SMTP id
 3f1490d57ef6-e5e24603d97mr7300604276.26.1740367262652; Sun, 23 Feb 2025
 19:21:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224022447.1141413-1-chharry@google.com> <CABBYNZJUd1wU0wyPugz4E_WNQsg9qTJmWdu4k2GvvvgVFG8GPQ@mail.gmail.com>
In-Reply-To: <CABBYNZJUd1wU0wyPugz4E_WNQsg9qTJmWdu4k2GvvvgVFG8GPQ@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 24 Feb 2025 11:20:36 +0800
X-Gm-Features: AWEUYZl51rPOFQXi2SPqEUmqy9Trb-3m1-BiRtYrOmoEmVRAKatwV-oaYNfl08M
Message-ID: <CADg1FFfMRwrGjWkhqbiZsfwV5p3axz0bqvPu-vNSSFJyObaN5w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Mon, Feb 24, 2025 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Sun, Feb 23, 2025 at 9:26=E2=80=AFPM Hsin-chen Chuang <chharry@google.=
com> wrote:
> >
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Automatically configure the altsetting for USER_CHANNEL when a SCO is
> > connected or disconnected. This adds support for the USER_CHANNEL to
> > transfer SCO data over USB transport.
>
> I guess the tracking of handles is about handling disconnections,
> right? I wonder if we can get away without doing that, I didn't intend
> to add a whole bunch of changes in order to switch to the right mode,
> I get that you may want to disable the isochronous endpoint in case
> there is no connection, but I guess that only matters if we are
> talking about power but the impact is probably small so I don't think
> it is worth it. There is an alternative to match the SCO/eSCO handle
> via mask, like we do with ISO handles, that is probably a lot cheaper
> than attempting to add a whole list for tracking handles, but it has
> the downside that it is vendor/model specific.

Yes, that's for handling disconnection. What do you think if we keep
only one handle in the driver data? That is, assume there's at most
one SCO connection. Then we don't need a list but just a u16.

>
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> >  drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-------
> >  1 file changed, 186 insertions(+), 38 deletions(-)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index de3fa725d210..dfb0918dfe98 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -854,6 +854,11 @@ struct qca_dump_info {
> >  #define BTUSB_ALT6_CONTINUOUS_TX       16
> >  #define BTUSB_HW_SSR_ACTIVE    17
> >
> > +struct sco_handle_list {
> > +       struct list_head list;
> > +       u16 handle;
> > +};
> > +
> >  struct btusb_data {
> >         struct hci_dev       *hdev;
> >         struct usb_device    *udev;
> > @@ -920,6 +925,9 @@ struct btusb_data {
> >         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> >
> >         struct qca_dump_info qca_dump;
> > +
> > +       /* Records the exsiting SCO handles for HCI_USER_CHANNEL */
> > +       struct list_head sco_handle_list;
> >  };
> >
> >  static void btusb_reset(struct hci_dev *hdev)
> > @@ -1113,6 +1121,131 @@ static inline void btusb_free_frags(struct btus=
b_data *data)
> >         spin_unlock_irqrestore(&data->rxlock, flags);
> >  }
> >
> > +static void btusb_sco_handle_list_clear(struct list_head *list)
> > +{
> > +       struct sco_handle_list *entry, *n;
> > +
> > +       list_for_each_entry_safe(entry, n, list, list) {
> > +               list_del(&entry->list);
> > +               kfree(entry);
> > +       }
> > +}
> > +
> > +static struct sco_handle_list *btusb_sco_handle_list_find(
> > +       struct list_head *list,
> > +       u16 handle)
> > +{
> > +       struct sco_handle_list *entry;
> > +
> > +       list_for_each_entry(entry, list, list)
> > +               if (entry->handle =3D=3D handle)
> > +                       return entry;
> > +
> > +       return NULL;
> > +}
> > +
> > +static int btusb_sco_handle_list_add(struct list_head *list, u16 handl=
e)
> > +{
> > +       struct sco_handle_list *entry;
> > +
> > +       if (btusb_sco_handle_list_find(list, handle))
> > +               return -EEXIST;
> > +
> > +       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > +       if (!entry)
> > +               return -ENOMEM;
> > +
> > +       entry->handle =3D handle;
> > +       list_add(&entry->list, list);
> > +
> > +       return 0;
> > +}
> > +
> > +static int btusb_sco_handle_list_del(struct list_head *list, u16 handl=
e)
> > +{
> > +       struct sco_handle_list *entry;
> > +
> > +       entry =3D btusb_sco_handle_list_find(list, handle);
> > +       if (!entry)
> > +               return -ENOENT;
> > +
> > +       list_del(&entry->list);
> > +       kfree(entry);
> > +
> > +       return 0;
> > +}
> > +
> > +static void btusb_sco_conn_change(struct btusb_data *data, struct sk_b=
uff *skb)
> > +{
> > +       struct hci_event_hdr *hdr =3D (void *) skb->data;
> > +       struct hci_dev *hdev =3D data->hdev;
> > +
> > +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT || skb->len < size=
of(*hdr))
> > +               return;
> > +
> > +       switch (hdr->evt) {
> > +       case HCI_EV_DISCONN_COMPLETE: {
> > +               struct hci_ev_disconn_complete *ev =3D
> > +                       (void *) skb->data + sizeof(*hdr);
> > +               u16 handle;
> > +
> > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->sta=
tus)
> > +                       return;
> > +
> > +               handle =3D __le16_to_cpu(ev->handle);
> > +               if (btusb_sco_handle_list_del(&data->sco_handle_list,
> > +                                             handle) < 0)
> > +                       return;
> > +
> > +               bt_dev_info(hdev, "disabling SCO");
> > +               data->sco_num--;
> > +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> > +               schedule_work(&data->work);
> > +
> > +               break;
> > +       }
> > +       case HCI_EV_SYNC_CONN_COMPLETE: {
> > +               struct hci_ev_sync_conn_complete *ev =3D
> > +                       (void *) skb->data + sizeof(*hdr);
> > +               unsigned int notify_air_mode;
> > +               u16 handle;
> > +
> > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->sta=
tus)
> > +                       return;
> > +
> > +               switch (ev->air_mode) {
> > +               case BT_CODEC_CVSD:
> > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > +                       break;
> > +
> > +               case BT_CODEC_TRANSPARENT:
> > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANS=
P;
> > +                       break;
> > +
> > +               default:
> > +                       return;
> > +               }
> > +
> > +               handle =3D __le16_to_cpu(ev->handle);
> > +               if (btusb_sco_handle_list_add(&data->sco_handle_list,
> > +                                             handle) < 0) {
> > +                       bt_dev_err(hdev, "failed to add the new SCO han=
dle");
> > +                       return;
> > +               }
> > +
> > +               bt_dev_info(hdev, "enabling SCO with air mode %u",
> > +                           ev->air_mode);
> > +               data->sco_num++;
> > +               data->air_mode =3D notify_air_mode;
> > +               schedule_work(&data->work);
> > +
> > +               break;
> > +       }
> > +       default:
> > +               break;
> > +       }
> > +}
> > +
> >  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *s=
kb)
> >  {
> >         if (data->intr_interval) {
> > @@ -1120,6 +1253,10 @@ static int btusb_recv_event(struct btusb_data *d=
ata, struct sk_buff *skb)
> >                 schedule_delayed_work(&data->rx_work, 0);
> >         }
> >
> > +       /* Configure altsetting for HCI_USER_CHANNEL on SCO dis/connect=
ed */
> > +       if (hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > +               btusb_sco_conn_change(data, skb);
>
> I'd recommend adding a check for Kconfig/module parameter in the if
> statement so btusb_sco_conn_change only runs on distros with it
> enabled so we don't risk something not working as expected just
> because someone decided to open the user channel.

Sure will add it in the next patch.

>
> >         return data->recv_event(data->hdev, skb);
> >  }
> >
> > @@ -1919,44 +2056,6 @@ static void btusb_stop_traffic(struct btusb_data=
 *data)
> >         usb_kill_anchored_urbs(&data->ctrl_anchor);
> >  }
> >
> > -static int btusb_close(struct hci_dev *hdev)
> > -{
> > -       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > -       int err;
> > -
> > -       BT_DBG("%s", hdev->name);
> > -
> > -       cancel_delayed_work(&data->rx_work);
> > -       cancel_work_sync(&data->work);
> > -       cancel_work_sync(&data->waker);
> > -
> > -       skb_queue_purge(&data->acl_q);
> > -
> > -       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > -       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > -       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > -       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> > -
> > -       btusb_stop_traffic(data);
> > -       btusb_free_frags(data);
> > -
> > -       err =3D usb_autopm_get_interface(data->intf);
> > -       if (err < 0)
> > -               goto failed;
> > -
> > -       data->intf->needs_remote_wakeup =3D 0;
> > -
> > -       /* Enable remote wake up for auto-suspend */
> > -       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> > -               data->intf->needs_remote_wakeup =3D 1;
> > -
> > -       usb_autopm_put_interface(data->intf);
> > -
> > -failed:
> > -       usb_scuttle_anchored_urbs(&data->deferred);
> > -       return 0;
> > -}
> > -
> >  static int btusb_flush(struct hci_dev *hdev)
> >  {
> >         struct btusb_data *data =3D hci_get_drvdata(hdev);
> > @@ -2327,6 +2426,51 @@ static void btusb_work(struct work_struct *work)
> >         }
> >  }
> >
> > +static int btusb_close(struct hci_dev *hdev)
> > +{
> > +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > +       int err;
> > +
> > +       BT_DBG("%s", hdev->name);
> > +
> > +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> > +               btusb_sco_handle_list_clear(&data->sco_handle_list);
> > +               data->sco_num =3D 0;
> > +               if (data->isoc_altsetting !=3D 0)
> > +                       btusb_switch_alt_setting(hdev, 0);
> > +       }
> > +
> > +       cancel_delayed_work(&data->rx_work);
> > +       cancel_work_sync(&data->work);
> > +       cancel_work_sync(&data->waker);
> > +
> > +       skb_queue_purge(&data->acl_q);
> > +
> > +       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > +       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > +       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > +       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> > +
> > +       btusb_stop_traffic(data);
> > +       btusb_free_frags(data);
> > +
> > +       err =3D usb_autopm_get_interface(data->intf);
> > +       if (err < 0)
> > +               goto failed;
> > +
> > +       data->intf->needs_remote_wakeup =3D 0;
> > +
> > +       /* Enable remote wake up for auto-suspend */
> > +       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> > +               data->intf->needs_remote_wakeup =3D 1;
> > +
> > +       usb_autopm_put_interface(data->intf);
> > +
> > +failed:
> > +       usb_scuttle_anchored_urbs(&data->deferred);
> > +       return 0;
> > +}
> > +
> >  static void btusb_waker(struct work_struct *work)
> >  {
> >         struct btusb_data *data =3D container_of(work, struct btusb_dat=
a, waker);
> > @@ -3782,6 +3926,8 @@ static int btusb_probe(struct usb_interface *intf=
,
> >         data->udev =3D interface_to_usbdev(intf);
> >         data->intf =3D intf;
> >
> > +       INIT_LIST_HEAD(&data->sco_handle_list);
> > +
> >         INIT_WORK(&data->work, btusb_work);
> >         INIT_WORK(&data->waker, btusb_waker);
> >         INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> > @@ -4117,6 +4263,8 @@ static void btusb_disconnect(struct usb_interface=
 *intf)
> >         hdev =3D data->hdev;
> >         usb_set_intfdata(data->intf, NULL);
> >
> > +       btusb_sco_handle_list_clear(&data->sco_handle_list);
> > +
> >         if (data->isoc) {
> >                 device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> >                 usb_set_intfdata(data->isoc, NULL);
> > --
> > 2.48.1.601.g30ceb7b040-goog
> >
>
>
> --
> Luiz Augusto von Dentz

--=20
Best Regards,
Hsin-chen
