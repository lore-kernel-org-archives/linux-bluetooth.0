Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA4128DB3
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 06:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740378382; cv=none; b=Rl2rgLtSxnVUs1BlAi0EZ3iOhFRYMqL6PAFvgYZ9tx6S3vl+S90EIMeOejOXTOTBcZo0RNiHFOks4mV3gemXqpDCuz4cD0czsBEKhmdyB2BuuZUCaBgyz+AfwM6r+EfvkH1kVXCGkqNh9SHyTLXtnAUt6RKv7U2dRzjEJEoTfRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740378382; c=relaxed/simple;
	bh=ISGq84rJvoyYqIsdx7zDGIicfuN1bdkWrSnYXDQRLZc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XCFkTPWCrrzfrkLvFRUS493yf6T/bvBh0oSfl4vjfEWTEFsNF5ZOdjRNV2u6ABxVVtB1wSRrXNQmhnLbvM1Q74bklIXwZtZoUETlmTSpOqpcpDsieaKTj0G4ANOT9tx8XEBm7uOBsVvMp3JDSGdwRzQ9h95L9b9ZtaVbhzj+NnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2S+lU71d; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2S+lU71d"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e5dcc411189so3431336276.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 22:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740378379; x=1740983179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NwzNRglY46K34R17r5HRAlfXS/RkjlxB4ERRC1Aepk=;
        b=2S+lU71dctGmHsTVlbvrCivg672NEvA8sZLkj7gkr6jvUCQcUv7rPxZXbK5/IoHdU8
         wPSWurLHXeEkPJoBpgbcL4aMBPuIAOxia8HafNrQgabg9tkfSkkXcNmjxnHZxTW3kRW2
         ENEBHjFp8uirFM8f4192KhIAkBgJ4xPUSoOjELpWnF9y+KZbx8D0j/h306sXXSzIj2ZE
         PUJkFr06a6UkZY8zG2QRm+hbZbDus3I/cM9CV5iFcwiwtfKgr6w4pX5uoEX40dfBwjVJ
         vH9o4TIgKQZe6dXIk3NZsAmCV2OyIqOwDnBQmkeET6yQoKyOOwXkvS6Wn59ZoNMTFwud
         Rq5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740378379; x=1740983179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+NwzNRglY46K34R17r5HRAlfXS/RkjlxB4ERRC1Aepk=;
        b=go5hHxcPylwDDGgR0NKJVs2SFkT+DyegPzeZW5sUvvI20nzuj7/fy2PMdlwAHrJuOI
         AA60cyyNlK5nJLFuu0CQXvUgWqO92RrvJQ+w9kGksj4zxT4oS9XID3VvZQxYbqmR0nnO
         IFb6qVnO3tvzrvTI/4yUY53pQDod2t9Ls6IbK+PHGUKGxbcj4WDOJlrIf/oey9DrBa/g
         QVwt3Kyt1CnVDxNpIklSvpmtWxYYVDx20dZPgP2sV34WLk+8mNiaTzfuvNz4abq+g7dr
         UYJWOGKqzDYynWtNgy+OPdYyg5MQjuTkgLt1HMvPQkAHi7GlHvOnJA2IrJopY+bGVbUY
         210g==
X-Gm-Message-State: AOJu0YzjDfpgOQ0HjNiI7CMhxtECCMy7JBSRxrNNeQPH0GQ3HsyhKos5
	jb2KUFR/Ck9v4XFGIcJo1yxoNbpgepMM/EaTrSEOz3HWMJjMfLDdbxsC1e9SVCUumjOFbIhs5DI
	4ADNdNh01aoXN98zBZTl6DmMYgoooxl+6fnWN
X-Gm-Gg: ASbGncum6Sg2U/ukFBI744P4DTkW/YLChVJ76EPTMKnpIg4nxYvJ5VWeftOs/zJ2pjv
	/MJPMOyHgX3gc4x4xNOFm9F8BLOxiRmHXrvaFTk2nGLFgmlWSVISfXBGEOOACpGVmIR/Udu6PTZ
	VpXyg8HRfv
X-Google-Smtp-Source: AGHT+IHggJKg4MgM2/B3JME5BqfYToOp6W/GqFkYoysCFL37Qz+M6MsNASnN+ZWiDd0BEQ1UUoF6XjCdfkAuXUzKDjc=
X-Received: by 2002:a05:6902:200d:b0:e5d:bfdf:b1b2 with SMTP id
 3f1490d57ef6-e5e245ba012mr9021390276.8.1740378379113; Sun, 23 Feb 2025
 22:26:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
In-Reply-To: <2025022431-ditto-shy-c62f@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 24 Feb 2025 14:25:52 +0800
X-Gm-Features: AWEUYZmFVTw4DbZDnA2ykK2hKeC47a0eip9l_bRMeKj-YW5OF8I8H5V2435_HW8
Message-ID: <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang wrote:
> > From: Hsin-chen Chuang <chharry@chromium.org>
> >
> > Automatically configure the altsetting for USER_CHANNEL when a SCO is
> > connected. This adds support for the USER_CHANNEL to transfer SCO data
> > over USB transport.
> >
> > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to control =
USB alt setting")
> > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > ---
> >
> > Changes in v2:
> > - Give up tracking the SCO handles. Only configure the altsetting when
> >   SCO connected.
> > - Put the change behind Kconfig/module parameter
> >
> >  drivers/bluetooth/Kconfig | 11 ++++++++++
> >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > index 4ab32abf0f48..7c497f878732 100644
> > --- a/drivers/bluetooth/Kconfig
> > +++ b/drivers/bluetooth/Kconfig
> > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> >         Say Y here to enable USB poll_sync for Bluetooth USB devices by
> >         default.
> >
> > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > +     bool "Auto set isoc_altsetting for USER_CHANNEL when SCO connecte=
d"
> > +     depends on BT_HCIBTUSB
> > +     default n
> > +     help
> > +       Say Y here to enable auto set isoc_altsetting for USER_CHANNEL
> > +       when SCO connected
> > +
> > +       This can be overridden by passing btusb.auto_set_isoc_alt=3D[y|=
n]
> > +       on the kernel commandline.
> > +
> >  config BT_HCIBTUSB_BCM
> >       bool "Broadcom protocol support"
> >       depends on BT_HCIBTUSB
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index de3fa725d210..af93d757911b 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -34,6 +34,8 @@ static bool force_scofix;
> >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTOS=
USPEND);
> >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POLL_SY=
NC);
> >  static bool reset =3D true;
> > +static bool auto_set_isoc_alt =3D
> > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> >
> >  static struct usb_driver btusb_driver;
> >
> > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct btusb=
_data *data)
> >       spin_unlock_irqrestore(&data->rxlock, flags);
> >  }
> >
> > +static void btusb_sco_connected(struct btusb_data *data, struct sk_buf=
f *skb)
> > +{
> > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > +     struct hci_ev_sync_conn_complete *ev =3D
> > +             (void *) skb->data + sizeof(*hdr);
> > +     struct hci_dev *hdev =3D data->hdev;
> > +     unsigned int notify_air_mode;
> > +
> > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > +             return;
> > +
> > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CONN_COM=
PLETE)
> > +             return;
> > +
> > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> > +             return;
> > +
> > +     switch (ev->air_mode) {
> > +     case BT_CODEC_CVSD:
> > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > +             break;
> > +
> > +     case BT_CODEC_TRANSPARENT:
> > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> > +             break;
> > +
> > +     default:
> > +             return;
> > +     }
> > +
> > +     bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mode);
> > +     data->sco_num =3D 1;
> > +     data->air_mode =3D notify_air_mode;
> > +     schedule_work(&data->work);
> > +}
> > +
> >  static int btusb_recv_event(struct btusb_data *data, struct sk_buff *s=
kb)
> >  {
> >       if (data->intr_interval) {
> > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_data *d=
ata, struct sk_buff *skb)
> >               schedule_delayed_work(&data->rx_work, 0);
> >       }
> >
> > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO connected */
> > +     if (auto_set_isoc_alt &&
> > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > +             btusb_sco_connected(data, skb);
> > +
> >       return data->recv_event(data->hdev, skb);
> >  }
> >
> > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Enable USB =
autosuspend by default");
> >  module_param(reset, bool, 0644);
> >  MODULE_PARM_DESC(reset, "Send HCI reset command on initialization");
> >
> > +module_param(auto_set_isoc_alt, bool, 0644);
> > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsetting for USER=
_CHANNEL when SCO connected");
>
> This is not the 1990's, why are you adding new module parameters when we
> have so many other more proper ways to do this?  And really, this would

Sorry but could you please provide an example to guard a feature like this.

> not work at all for multiple controllers in teh same system, right?

Do you mean we can't have separate parameters for different
controllers? Yes that's true, but why would a user want the different
behavior on the same machine?

> That should cause it to not even be considered at all as a viable
> solution.
>
> confused,
>
> greg k-h

--=20
Best Regards,
Hsin-chen
