Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE486F510;
	Mon, 24 Feb 2025 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740368207; cv=none; b=Y5EESh0xPQ+PO6LCH5oCp1eT2Qw5MbLpjKK6RLSnsBl0jjm/4dsM1m5XwJKYVlr0IiL2uxm+/OqUwZ80xsr6Z6Iu33FNzI/VGGYmuxfu6AARK1Nv4eWaq4QldpVuC/yfF9VnqHVlNyhXondCOfhcg/ftgX99Bh/wOENXKZ4UsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740368207; c=relaxed/simple;
	bh=ZsObla6Jva62zXXLtf13cZBKHiusfILSsRmqXyQvVjM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qlkNZrfGyITPDdZxTSMxDENsDLB0CdD64egUHu0jGsGfu5n+UXy34bXWc8iVgIRrllwl3/nPGddxqlfDlENKc8oaEurDH49WvMgPsXvVWEqTbzbxpMHN6JZY6YDwZ8SQRzaiHCt+b5clLyde/QMaAAgnsBSQ+T/nQ1oyeKNmTFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=URb7otmT; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URb7otmT"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-548409cd2a8so2013274e87.3;
        Sun, 23 Feb 2025 19:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740368204; x=1740973004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lqnw4Wlb490d8/d3r4TDAk62AC/ZkgM17lp6NF3gT8g=;
        b=URb7otmTr2nDqvEGFXg6dNX5TSsmvf53wd5pPe0MxtmKjkCbCtdVLlQZzgjvXDEB4/
         REslzMncdFGdGMKNDAznR+AE2mpkbBieCFv92V1EchFkb0icNKgdj/3RXR8mP2KTvYZW
         ttIqQ0ra7Asl1obkgyMyV4TN4hGy8BG2eTcC7ag4KXDtuCP95RmfmL1ppgtjne62fMvD
         eF5RZ+MSW13gAqvhvj2Q/ORuij80yRgglGFeiPZP7jMvT6f/uTelDw71G+jZHcYlCAdn
         IKBz1jml6bWlu/A1pNcvKH8bWxWf4yYi9IYe0Gt4V26fI5RUbabviF3X+R2l8Fhkxusm
         RXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740368204; x=1740973004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lqnw4Wlb490d8/d3r4TDAk62AC/ZkgM17lp6NF3gT8g=;
        b=Kzp+yYPdZKgAc1XfQYPj4+L6+cY76ZeqlwtZgPBKE7E7QROyo1CNlo/Egfws+ImPla
         0TpFm344N1lbr61af2J9P9ioclwuIs5DFio5xnZpZKfNzYazM5jrBUkxyO29Di6kOQnO
         3EigS+L3RCqQqOVBi00oxAkppehPn8w3rbuh1RdEd0XgmFZpGM9EHltFtZtQ55FsIlWs
         k5I4k8Z00Ya0yAiNeYgy2cniv40CixOr131UgJB0f4zDr/ux7tzZLKnyMyBuIy1p0skf
         NU0P4qLyroQnxGv1F/8OMqEKELk7tlOFQBp8t6IRYI/HHJuLOrp+dnD4n8ljvB1N9Fft
         9V/A==
X-Forwarded-Encrypted: i=1; AJvYcCUuNuxyrt3UFMGoP4GEfJxaZKz6xLymtf1MoElf/+FKS9AiWtIM49Vk2namZq1DKXXDl780t8Br4OJrbD0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm75CuirmvB2VI+QsT47uh8MMz2/SIvL3hlC6dya4gCDPheavM
	qdZnQLs1dPO9w0166lw0bPf2zXqH2jLHFlfWDfa7e4UqAm6goW3g5OQFjcw5WsiLGoLagswUJSf
	Muka9WxGgtw1nlYonRS3c9F9jPXw=
X-Gm-Gg: ASbGncuGBkqyZgr+alag9Mz/Dm9evj4+m8eMlUnPxlyu/vEzcUNuIScguKe7QloZhAC
	sT3TdFE6B88YFbFKBeN6TrLJ5T7n8hPkrI8sonmOW6YtpSanQbfpNKNyV61EZbkluJvCz1/JlP0
	iidm2FyVv5
X-Google-Smtp-Source: AGHT+IGKoinPclxeXP+Nh1wyai0mN5Sv/ObuGUMhzdcAkeRySEV73jvalLdKnCbgpmGF+4hum7ZSTr2uaPJeH9LO+VQ=
X-Received: by 2002:a05:6512:3e23:b0:545:60b:f38c with SMTP id
 2adb3069b0e04-54838f59bafmr4468339e87.41.1740368203497; Sun, 23 Feb 2025
 19:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224022447.1141413-1-chharry@google.com> <CABBYNZJUd1wU0wyPugz4E_WNQsg9qTJmWdu4k2GvvvgVFG8GPQ@mail.gmail.com>
 <CADg1FFfMRwrGjWkhqbiZsfwV5p3axz0bqvPu-vNSSFJyObaN5w@mail.gmail.com>
In-Reply-To: <CADg1FFfMRwrGjWkhqbiZsfwV5p3axz0bqvPu-vNSSFJyObaN5w@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Sun, 23 Feb 2025 22:36:28 -0500
X-Gm-Features: AWEUYZkaSoG_vP2JUySCco_-BYSP0w0gqhXqDQshzl9ufsmdbObYkEXwTh4pMBM
Message-ID: <CABBYNZLFY0AcXJjaz5HQbB0SYu+N7JX_HKpLRfofDy_5ACD+2A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, gregkh@linuxfoundation.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Sun, Feb 23, 2025 at 10:21=E2=80=AFPM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> Hi Luiz,
>
> On Mon, Feb 24, 2025 at 10:53=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Sun, Feb 23, 2025 at 9:26=E2=80=AFPM Hsin-chen Chuang <chharry@googl=
e.com> wrote:
> > >
> > > From: Hsin-chen Chuang <chharry@chromium.org>
> > >
> > > Automatically configure the altsetting for USER_CHANNEL when a SCO is
> > > connected or disconnected. This adds support for the USER_CHANNEL to
> > > transfer SCO data over USB transport.
> >
> > I guess the tracking of handles is about handling disconnections,
> > right? I wonder if we can get away without doing that, I didn't intend
> > to add a whole bunch of changes in order to switch to the right mode,
> > I get that you may want to disable the isochronous endpoint in case
> > there is no connection, but I guess that only matters if we are
> > talking about power but the impact is probably small so I don't think
> > it is worth it. There is an alternative to match the SCO/eSCO handle
> > via mask, like we do with ISO handles, that is probably a lot cheaper
> > than attempting to add a whole list for tracking handles, but it has
> > the downside that it is vendor/model specific.
>
> Yes, that's for handling disconnection. What do you think if we keep
> only one handle in the driver data? That is, assume there's at most
> one SCO connection. Then we don't need a list but just a u16.

Hmm, if you can guarantee that it only support at most 1 SCO
connection that is fine, that said the user channel can be
opened/closed in between so we would have to monitor things like reset
as well, so I think we actually need to depend on the Kconfig/module
parameter to ensure that only user mode will be used so it is safe to
track the handle, that said I think you will need to intercept things
like reset anyway since it does affect any handles the driver would
have stored so you probably need to change the alt setting in case an
SCO connection was established.

Btw, if we really want to be safe here we should probably think about
ways to test loading the btusb on bluez CI and adding testing to it,
that said that would require emulation to USB vid/pid and possibly the
vendor commands necessary in order to set up the controller.

> >
> > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to contro=
l USB alt setting")
> > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > ---
> > >
> > >  drivers/bluetooth/btusb.c | 224 +++++++++++++++++++++++++++++++-----=
--
> > >  1 file changed, 186 insertions(+), 38 deletions(-)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index de3fa725d210..dfb0918dfe98 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -854,6 +854,11 @@ struct qca_dump_info {
> > >  #define BTUSB_ALT6_CONTINUOUS_TX       16
> > >  #define BTUSB_HW_SSR_ACTIVE    17
> > >
> > > +struct sco_handle_list {
> > > +       struct list_head list;
> > > +       u16 handle;
> > > +};
> > > +
> > >  struct btusb_data {
> > >         struct hci_dev       *hdev;
> > >         struct usb_device    *udev;
> > > @@ -920,6 +925,9 @@ struct btusb_data {
> > >         int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
> > >
> > >         struct qca_dump_info qca_dump;
> > > +
> > > +       /* Records the exsiting SCO handles for HCI_USER_CHANNEL */
> > > +       struct list_head sco_handle_list;
> > >  };
> > >
> > >  static void btusb_reset(struct hci_dev *hdev)
> > > @@ -1113,6 +1121,131 @@ static inline void btusb_free_frags(struct bt=
usb_data *data)
> > >         spin_unlock_irqrestore(&data->rxlock, flags);
> > >  }
> > >
> > > +static void btusb_sco_handle_list_clear(struct list_head *list)
> > > +{
> > > +       struct sco_handle_list *entry, *n;
> > > +
> > > +       list_for_each_entry_safe(entry, n, list, list) {
> > > +               list_del(&entry->list);
> > > +               kfree(entry);
> > > +       }
> > > +}
> > > +
> > > +static struct sco_handle_list *btusb_sco_handle_list_find(
> > > +       struct list_head *list,
> > > +       u16 handle)
> > > +{
> > > +       struct sco_handle_list *entry;
> > > +
> > > +       list_for_each_entry(entry, list, list)
> > > +               if (entry->handle =3D=3D handle)
> > > +                       return entry;
> > > +
> > > +       return NULL;
> > > +}
> > > +
> > > +static int btusb_sco_handle_list_add(struct list_head *list, u16 han=
dle)
> > > +{
> > > +       struct sco_handle_list *entry;
> > > +
> > > +       if (btusb_sco_handle_list_find(list, handle))
> > > +               return -EEXIST;
> > > +
> > > +       entry =3D kzalloc(sizeof(*entry), GFP_KERNEL);
> > > +       if (!entry)
> > > +               return -ENOMEM;
> > > +
> > > +       entry->handle =3D handle;
> > > +       list_add(&entry->list, list);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static int btusb_sco_handle_list_del(struct list_head *list, u16 han=
dle)
> > > +{
> > > +       struct sco_handle_list *entry;
> > > +
> > > +       entry =3D btusb_sco_handle_list_find(list, handle);
> > > +       if (!entry)
> > > +               return -ENOENT;
> > > +
> > > +       list_del(&entry->list);
> > > +       kfree(entry);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static void btusb_sco_conn_change(struct btusb_data *data, struct sk=
_buff *skb)
> > > +{
> > > +       struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > +       struct hci_dev *hdev =3D data->hdev;
> > > +
> > > +       if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT || skb->len < si=
zeof(*hdr))
> > > +               return;
> > > +
> > > +       switch (hdr->evt) {
> > > +       case HCI_EV_DISCONN_COMPLETE: {
> > > +               struct hci_ev_disconn_complete *ev =3D
> > > +                       (void *) skb->data + sizeof(*hdr);
> > > +               u16 handle;
> > > +
> > > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->s=
tatus)
> > > +                       return;
> > > +
> > > +               handle =3D __le16_to_cpu(ev->handle);
> > > +               if (btusb_sco_handle_list_del(&data->sco_handle_list,
> > > +                                             handle) < 0)
> > > +                       return;
> > > +
> > > +               bt_dev_info(hdev, "disabling SCO");
> > > +               data->sco_num--;
> > > +               data->air_mode =3D HCI_NOTIFY_DISABLE_SCO;
> > > +               schedule_work(&data->work);
> > > +
> > > +               break;
> > > +       }
> > > +       case HCI_EV_SYNC_CONN_COMPLETE: {
> > > +               struct hci_ev_sync_conn_complete *ev =3D
> > > +                       (void *) skb->data + sizeof(*hdr);
> > > +               unsigned int notify_air_mode;
> > > +               u16 handle;
> > > +
> > > +               if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->s=
tatus)
> > > +                       return;
> > > +
> > > +               switch (ev->air_mode) {
> > > +               case BT_CODEC_CVSD:
> > > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVS=
D;
> > > +                       break;
> > > +
> > > +               case BT_CODEC_TRANSPARENT:
> > > +                       notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRA=
NSP;
> > > +                       break;
> > > +
> > > +               default:
> > > +                       return;
> > > +               }
> > > +
> > > +               handle =3D __le16_to_cpu(ev->handle);
> > > +               if (btusb_sco_handle_list_add(&data->sco_handle_list,
> > > +                                             handle) < 0) {
> > > +                       bt_dev_err(hdev, "failed to add the new SCO h=
andle");
> > > +                       return;
> > > +               }
> > > +
> > > +               bt_dev_info(hdev, "enabling SCO with air mode %u",
> > > +                           ev->air_mode);
> > > +               data->sco_num++;
> > > +               data->air_mode =3D notify_air_mode;
> > > +               schedule_work(&data->work);
> > > +
> > > +               break;
> > > +       }
> > > +       default:
> > > +               break;
> > > +       }
> > > +}
> > > +
> > >  static int btusb_recv_event(struct btusb_data *data, struct sk_buff =
*skb)
> > >  {
> > >         if (data->intr_interval) {
> > > @@ -1120,6 +1253,10 @@ static int btusb_recv_event(struct btusb_data =
*data, struct sk_buff *skb)
> > >                 schedule_delayed_work(&data->rx_work, 0);
> > >         }
> > >
> > > +       /* Configure altsetting for HCI_USER_CHANNEL on SCO dis/conne=
cted */
> > > +       if (hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > +               btusb_sco_conn_change(data, skb);
> >
> > I'd recommend adding a check for Kconfig/module parameter in the if
> > statement so btusb_sco_conn_change only runs on distros with it
> > enabled so we don't risk something not working as expected just
> > because someone decided to open the user channel.
>
> Sure will add it in the next patch.
>
> >
> > >         return data->recv_event(data->hdev, skb);
> > >  }
> > >
> > > @@ -1919,44 +2056,6 @@ static void btusb_stop_traffic(struct btusb_da=
ta *data)
> > >         usb_kill_anchored_urbs(&data->ctrl_anchor);
> > >  }
> > >
> > > -static int btusb_close(struct hci_dev *hdev)
> > > -{
> > > -       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > -       int err;
> > > -
> > > -       BT_DBG("%s", hdev->name);
> > > -
> > > -       cancel_delayed_work(&data->rx_work);
> > > -       cancel_work_sync(&data->work);
> > > -       cancel_work_sync(&data->waker);
> > > -
> > > -       skb_queue_purge(&data->acl_q);
> > > -
> > > -       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > > -       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > > -       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > > -       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> > > -
> > > -       btusb_stop_traffic(data);
> > > -       btusb_free_frags(data);
> > > -
> > > -       err =3D usb_autopm_get_interface(data->intf);
> > > -       if (err < 0)
> > > -               goto failed;
> > > -
> > > -       data->intf->needs_remote_wakeup =3D 0;
> > > -
> > > -       /* Enable remote wake up for auto-suspend */
> > > -       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> > > -               data->intf->needs_remote_wakeup =3D 1;
> > > -
> > > -       usb_autopm_put_interface(data->intf);
> > > -
> > > -failed:
> > > -       usb_scuttle_anchored_urbs(&data->deferred);
> > > -       return 0;
> > > -}
> > > -
> > >  static int btusb_flush(struct hci_dev *hdev)
> > >  {
> > >         struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > @@ -2327,6 +2426,51 @@ static void btusb_work(struct work_struct *wor=
k)
> > >         }
> > >  }
> > >
> > > +static int btusb_close(struct hci_dev *hdev)
> > > +{
> > > +       struct btusb_data *data =3D hci_get_drvdata(hdev);
> > > +       int err;
> > > +
> > > +       BT_DBG("%s", hdev->name);
> > > +
> > > +       if (hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
> > > +               btusb_sco_handle_list_clear(&data->sco_handle_list);
> > > +               data->sco_num =3D 0;
> > > +               if (data->isoc_altsetting !=3D 0)
> > > +                       btusb_switch_alt_setting(hdev, 0);
> > > +       }
> > > +
> > > +       cancel_delayed_work(&data->rx_work);
> > > +       cancel_work_sync(&data->work);
> > > +       cancel_work_sync(&data->waker);
> > > +
> > > +       skb_queue_purge(&data->acl_q);
> > > +
> > > +       clear_bit(BTUSB_ISOC_RUNNING, &data->flags);
> > > +       clear_bit(BTUSB_BULK_RUNNING, &data->flags);
> > > +       clear_bit(BTUSB_INTR_RUNNING, &data->flags);
> > > +       clear_bit(BTUSB_DIAG_RUNNING, &data->flags);
> > > +
> > > +       btusb_stop_traffic(data);
> > > +       btusb_free_frags(data);
> > > +
> > > +       err =3D usb_autopm_get_interface(data->intf);
> > > +       if (err < 0)
> > > +               goto failed;
> > > +
> > > +       data->intf->needs_remote_wakeup =3D 0;
> > > +
> > > +       /* Enable remote wake up for auto-suspend */
> > > +       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->flags))
> > > +               data->intf->needs_remote_wakeup =3D 1;
> > > +
> > > +       usb_autopm_put_interface(data->intf);
> > > +
> > > +failed:
> > > +       usb_scuttle_anchored_urbs(&data->deferred);
> > > +       return 0;
> > > +}
> > > +
> > >  static void btusb_waker(struct work_struct *work)
> > >  {
> > >         struct btusb_data *data =3D container_of(work, struct btusb_d=
ata, waker);
> > > @@ -3782,6 +3926,8 @@ static int btusb_probe(struct usb_interface *in=
tf,
> > >         data->udev =3D interface_to_usbdev(intf);
> > >         data->intf =3D intf;
> > >
> > > +       INIT_LIST_HEAD(&data->sco_handle_list);
> > > +
> > >         INIT_WORK(&data->work, btusb_work);
> > >         INIT_WORK(&data->waker, btusb_waker);
> > >         INIT_DELAYED_WORK(&data->rx_work, btusb_rx_work);
> > > @@ -4117,6 +4263,8 @@ static void btusb_disconnect(struct usb_interfa=
ce *intf)
> > >         hdev =3D data->hdev;
> > >         usb_set_intfdata(data->intf, NULL);
> > >
> > > +       btusb_sco_handle_list_clear(&data->sco_handle_list);
> > > +
> > >         if (data->isoc) {
> > >                 device_remove_file(&intf->dev, &dev_attr_isoc_alt);
> > >                 usb_set_intfdata(data->isoc, NULL);
> > > --
> > > 2.48.1.601.g30ceb7b040-goog
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
> --
> Best Regards,
> Hsin-chen



--=20
Luiz Augusto von Dentz
