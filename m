Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42829183098
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 02:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740622968; cv=none; b=sySxvvaeNF2ocjNH98vwyMhkiS1W1CQesoUGX6Vt+A5Ja5eDzwK4RHdoqtQR0tbNyG9giGVO0amz/+/mqXAkm2qp542qHZs6KfdzqgrLOJp27X+D+u86C0bVIOSSArXTiNnJLKqpGxwUk2O07h6LiKTHtuIAj7bkwcUuzdyTgcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740622968; c=relaxed/simple;
	bh=amn0AAMAJ9OUAwODEd6WHVij94pctxdh5CpVJcnSY8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uKng4fufZ/HpH/cWrjnGvM6UfT8MSCkmq29Q+XPQd73Cvjdlsirwm509DZ0df1eGYoD7vdzCl0VYlf14zZpHkQCXMmzSKf6MFkhW02dUfmmCM0r2Vd+D8iCf5km73WbUCGuaEiMGbcojroHhQnTu0kKENhB6AQy+Ms9Wiv6Uk6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fXeU9IiL; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fXeU9IiL"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e549be93d5eso463029276.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 18:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740622965; x=1741227765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3MWRcNWI09IZPcVKllS0Tgx1fepUOzUdrtIZArS3Ko=;
        b=fXeU9IiL3Ru5/pVxKvuQB3N9GGqx3BrAwDZCFp7il/MMtviO12xAAYYpFPMvBWQPCR
         wzVn8fmpWicxj6xrZOr/CWa6upEK83CeHWOnAqUuQ5PuTueNV5OsVQOKiOD1EjTibYMK
         s7u+Zuj5em6qKHGoKapVQdPYBJ/NSTeAitrVQLaeGKBLslVyHdjf++gpTMaUINTuOP3b
         4pmacXjrimiF4E5b+YFwc6apeUKXS6OweOADR/bTPSmtJ6kRcLvUgO+8owqKn2+S1+ts
         WzxTQb5lvHD43KMUInIagnvFPivLqTIHOWRoEqiF1f1eH0MS+7glfUDVYeIQF3XnhN0l
         eDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740622965; x=1741227765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3MWRcNWI09IZPcVKllS0Tgx1fepUOzUdrtIZArS3Ko=;
        b=c7Ps7sf2Tbmnvl8t1leLZctFLFGeY2b7n8rU8ZU0phH17pOLWyz/CK7sLLVfzx7bVp
         ioPoForA2Amk+SwDnq1x1R6WBg7f41FPd0X0pZDDe3yNnOhT39XMqogH+g6Ose0hFGxG
         frCt7YTtszgrFiDM9AhWEFpWeyvzE0CfilZu4KkJpNeoVHMLj9hXF6n1Kr3MxcwdqiZM
         j1lCb6PSVJvd9Y6v4gW+3i3bs849+QeHi9pd5IimoqIKrI2gnu2YUi8/w1GAUTg37hjV
         lI7XYVdyglw9QhdMMUMKQp19nPAko/6Rj+J6PRXKeBtyfLYv1bUGpw4miZTKgUJeJVlZ
         bZsg==
X-Forwarded-Encrypted: i=1; AJvYcCXKSy6A+5lIWv6C5VD1Zyf3JveynHKuscJsfaRRQ8PYrOfnNAgxylDzHTq/JCTYltVTPG+CJxa2liJRntGdGsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkhrviQG51foNgvou+3voQLOQyfuSrvOLh7G9prDzKamtt+q7X
	7Wee6XFy5jbbbtbiHPxqqeeDKdeL54O/QznKNJ4JaxpX7LZ+poO5yP5OKAEzxKgMOM3vweGxe0Q
	a6KEOZ1SvU4Xnb9BuxTCHy4rI9YK7CBnktmcw
X-Gm-Gg: ASbGnctlFGyCHpUbg6h2I1rb7VU9F60NuzZlmBcUgjfleznpSMQvDimqaKNMsaiHIN8
	ZozjbhQnBPcIi+fXIWc/2m5wUZXgwIHR6Zw/oUXjzEmXZBAhmZpv6e+HPxwPRcIIX3rFjTcr9fD
	0Dhxilt1+S
X-Google-Smtp-Source: AGHT+IFnY0zvAKqxAj3i0oWKJG6BQPRyz8bYwFfTJn2hQdUfBoQYlUi4gYnyeqcwqBmkrVKaByi7IuRgKh+++eUSatk=
X-Received: by 2002:a05:6902:1a42:b0:e57:3872:c374 with SMTP id
 3f1490d57ef6-e607a55318emr8471880276.33.1740622964900; Wed, 26 Feb 2025
 18:22:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
 <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com>
 <2025022407-polo-disgrace-9655@gregkh> <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
 <CABBYNZLhR+OJQnYZ5vN5HjgiWwKrXvOse-pXhCcTdFpJrrzsNg@mail.gmail.com>
In-Reply-To: <CABBYNZLhR+OJQnYZ5vN5HjgiWwKrXvOse-pXhCcTdFpJrrzsNg@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Thu, 27 Feb 2025 10:22:17 +0800
X-Gm-Features: AQ5f1JrxgnmifW-sMFYHQWe8yAXF3kZCnP2KGZpmQd0LTYVFZem0Dwd5Rb1IBKM
Message-ID: <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Feb 27, 2025 at 4:55=E2=80=AFAM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chharry@google.=
com> wrote:
> >
> > On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wrote:
> > > > Hi Greg,
> > > >
> > > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linuxfounda=
tion.org> wrote:
> > > > >
> > > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang wrote:
> > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > >
> > > > > > Automatically configure the altsetting for USER_CHANNEL when a =
SCO is
> > > > > > connected. This adds support for the USER_CHANNEL to transfer S=
CO data
> > > > > > over USB transport.
> > > > > >
> > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to =
control USB alt setting")
> > > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > ---
> > > > > >
> > > > > > Changes in v2:
> > > > > > - Give up tracking the SCO handles. Only configure the altsetti=
ng when
> > > > > >   SCO connected.
> > > > > > - Put the change behind Kconfig/module parameter
> > > > > >
> > > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++=
++++++++
> > > > > >  2 files changed, 57 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kcon=
fig
> > > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > > --- a/drivers/bluetooth/Kconfig
> > > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > > >         Say Y here to enable USB poll_sync for Bluetooth USB de=
vices by
> > > > > >         default.
> > > > > >
> > > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL when SCO =
connected"
> > > > > > +     depends on BT_HCIBTUSB
> > > > > > +     default n
>
> Maybe we can do just:
>
>  default y if CHROME_PLATFORMS
>
> > > > > > +     help
> > > > > > +       Say Y here to enable auto set isoc_altsetting for USER_=
CHANNEL
> > > > > > +       when SCO connected
> > > > > > +
> > > > > > +       This can be overridden by passing btusb.auto_set_isoc_a=
lt=3D[y|n]
> > > > > > +       on the kernel commandline.
> > > > > > +
> > > > > >  config BT_HCIBTUSB_BCM
> > > > > >       bool "Broadcom protocol support"
> > > > > >       depends on BT_HCIBTUSB
> > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btus=
b.c
> > > > > > index de3fa725d210..af93d757911b 100644
> > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTU=
SB_AUTOSUSPEND);
> > > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB=
_POLL_SYNC);
> > > > > >  static bool reset =3D true;
> > > > > > +static bool auto_set_isoc_alt =3D
> > > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > > > >
> > > > > >  static struct usb_driver btusb_driver;
> > > > > >
> > > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(stru=
ct btusb_data *data)
> > > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > > >  }
> > > > > >
> > > > > > +static void btusb_sco_connected(struct btusb_data *data, struc=
t sk_buff *skb)
> > > > > > +{
> > > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > > +     unsigned int notify_air_mode;
> > > > > > +
> > > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > > +             return;
> > > > > > +
> > > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_=
CONN_COMPLETE)
> > > > > > +             return;
> > > > > > +
> > > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->statu=
s)
> > > > > > +             return;
> > > > > > +
> > > > > > +     switch (ev->air_mode) {
> > > > > > +     case BT_CODEC_CVSD:
> > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > > > > > +             break;
> > > > > > +
> > > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> > > > > > +             break;
> > > > > > +
> > > > > > +     default:
> > > > > > +             return;
> > > > > > +     }
> > > > > > +
> > > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u", ev->ai=
r_mode);
> > > > > > +     data->sco_num =3D 1;
> > > > > > +     data->air_mode =3D notify_air_mode;
> > > > > > +     schedule_work(&data->work);
> > > > > > +}
> > > > > > +
> > > > > >  static int btusb_recv_event(struct btusb_data *data, struct sk=
_buff *skb)
> > > > > >  {
> > > > > >       if (data->intr_interval) {
> > > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb=
_data *data, struct sk_buff *skb)
> > > > > >               schedule_delayed_work(&data->rx_work, 0);
> > > > > >       }
> > > > > >
> > > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO conne=
cted */
> > > > > > +     if (auto_set_isoc_alt &&
> > > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > > > > +             btusb_sco_connected(data, skb);
> > > > > > +
> > > > > >       return data->recv_event(data->hdev, skb);
> > > > > >  }
> > > > > >
> > > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Ena=
ble USB autosuspend by default");
> > > > > >  module_param(reset, bool, 0644);
> > > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on initializat=
ion");
> > > > > >
> > > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsetting =
for USER_CHANNEL when SCO connected");
> > > > >
> > > > > This is not the 1990's, why are you adding new module parameters =
when we
> > > > > have so many other more proper ways to do this?  And really, this=
 would
> > > >
> > > > Sorry but could you please provide an example to guard a feature li=
ke this.
> > >
> > > Depends on what you want to do with this configuration.  Why is it an
> > > option at all?  Why can't it "just work"?  Module parameters are a pa=
in
> >
> > I would like to hand this question to Luiz. I believe this patch just
> > works because this configuration is defined in the spec.
> > I think Luiz's point is to project the potential existing user, but
> > there's probably no User channel user sending SCO data with the latest
> > btusb driver because:
> > a) There's no way to configure alt setting from userspace
> > b) Before eafcfcfca97d, SCO data would be rejected since User channel
> > shouldn't be able to modify hci_conn_num
>
> Perhaps you can just use CHROME_PLATFORMS (suggested above) in Kconfig
> to enable intercepting of the events, etc, so we don't need any
> runtime parameters.

I'm afraid that this doesn't resolve Greg's comment below because the
multiple controllers are still bonded to the same config.
Also I would hesitate to put this Chrome devices specific because
project Floss shall be able to run on a general Linux environment.
If you have a strong opinion to guard this behind a flag, perhaps we
could try other options suggested by Greg (configfs or maybe back to
sysfs).

>
> > > to configure, we have loads of other ways to do this now (configfs,
> > > debugfs for debugging stuff, sysfs for device-specific things, etc.)
> > >
> > > > > not work at all for multiple controllers in teh same system, righ=
t?
> > > >
> > > > Do you mean we can't have separate parameters for different
> > > > controllers? Yes that's true, but why would a user want the differe=
nt
> > > > behavior on the same machine?
> > >
> > > Why would you prevent them from allowing this to happen for a
> > > device-specific option?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > --
> > Best Regards,
> > Hsin-chen
>
>
>
> --
> Luiz Augusto von Dentz


Best Regards,

Hsin-chen
