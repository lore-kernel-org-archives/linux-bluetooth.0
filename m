Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B7B31A9B5B
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740674694; cv=none; b=ikYk7jQWZNvic3RRVj1j+duPqQ0uLn2Htomdn4JeH//nAheLNV5zeMorPc5z/irVsG8GgNpgz8pXZq7/b3e12ZAqx46SxwMx/42bFSAG2gA65jIV59Mek2uKZL7JdWAKIOnlyeCiZtHA/T4K20o2ZqImthqrsQokKajDBRZmZHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740674694; c=relaxed/simple;
	bh=Gnz/+LHAB6bsemzEyV4nSZ8VVYR+RDdf130Jbnzn15M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ubTBcMDva5Lt57F5ZkdRGQzaJIR/rXtDB1tw9yac3P2W7t3WCQNq9iNrWVhBiD+AZnxtXT9I83fLacQZ5FhHtskQsNviQLKLf29+I1X86ipYV+LZjmT0BiU4SOjTOMZ1QUUYhhJmn/+hhciX3UpYF1mzz+zMO9NJ35QBVkLNYFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ny2KBNl1; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ny2KBNl1"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e609faa982dso886313276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Feb 2025 08:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740674691; x=1741279491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gIPfZwcC1KE89ezBAI/1+q/Oe9muqgD+Xl4IQv6p9io=;
        b=Ny2KBNl1C8OHhs2Ty6jly0jsqVKDGBLVkKzZEgEN49XqNThTtOwMJ+kZYGqvk33Rvk
         yT96CtxQV/BP6MQLEWcE9BiRKFsFbhOeESeTMXKQAZfU9U9DHACOXGyz+0vDwzlUDbck
         XYjEMzaCqcG889uLJbmtUB0S6H64IQx1dGTc/yAxM8V4pKVw5fOlwyRA2JrOpMZUkKah
         Zvux8BVlqyALUqDOf0KF2PmMDJnCt3jYvmP/9hEDf8IQHhw9O2KQD6J0vTRWHt9adEp4
         rpdDXY4WPYX268NmZU2somfm8AYAkPz/PqKt0aEGSOrtGCcU5n2e+4dY3FUPuOVrHNmu
         UTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740674691; x=1741279491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gIPfZwcC1KE89ezBAI/1+q/Oe9muqgD+Xl4IQv6p9io=;
        b=PBFZGiF+mJWi7wMDkjFepzFCfdNnvCeiq8xm3ipR327XzWpn+0MqtVwNub6qWH4u/p
         Libew5yj0UIywiu6wWztVr+xISqkCdCRej/QX2rbYWTR3WCpwpdUt3AoykV4RUKOQy+/
         gjbfsYXyZw6LgYCLw9L9+vjFQd0pFAibhbyixSC7ivs2oWtsMP87ByXN9DyX95WMtWCO
         t/TYsZivnOWDntZTP0+euqtpQpLBYY3QCUTgyiTP/Muvi8XUSAyReYJZj/WDq6nL1hL/
         lUMjci1WQcVLX03L/ury3ljrUMahYHanUHDyEtUSZS7dWL6jjRwOvMO8IRCkDxs0Q1fO
         c4CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUU06VGxdFlFZK7y3PEEAY1awdEYR47MmAW7ywIJv2vV2PWzSLNZrpravN45McsWSVfR4b+sSl3ZOvsuGhi6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQg8p6Z9hnswTMogyGDvEit9MkXFYmMk1aP7Ub2bIULaX7RDlF
	nEx+Cp4u59IbijAER3V5PmW8ZR/vuo31FObtDfna6cFAFY0vTLn/FA111YzJWRtrsze6ukSn6vJ
	A5tm3qHUehSu3IuYM/eMkBiUx6tCaSzyohxGp
X-Gm-Gg: ASbGncsgn3AhGOnELEQBG5govo6x9NRmqCcIKJfoc+xBY9XoPKT3mtiGH75yOReEd2/
	dBWbN1u/TereyUBDA16RWStlbVH9GLq8YqyLV9xseQgKrKBm/1vXwNXDuxODmmL/rpt1amZyJUR
	9Zi6pQHJM=
X-Google-Smtp-Source: AGHT+IHwI0YwgfZMVeqXIK/zECoiiG+fDiH7Ql+Xx+YNa9HqYfL4pVIDEINmB7XuvVbdgauJvayQhGj2jcE1kzGGCGA=
X-Received: by 2002:a05:6902:1b05:b0:e5a:cece:f37a with SMTP id
 3f1490d57ef6-e5e8afc4479mr22595069276.13.1740674691120; Thu, 27 Feb 2025
 08:44:51 -0800 (PST)
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
 <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com>
 <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com>
 <CADg1FFdKfoJLxD+0A=j=kSLtMPLL-JptcWP1qH0Oo0SttN8k2g@mail.gmail.com> <CABBYNZKJUnhGXJEsExCdWNaE448QhCeiymLm9yS80k18AeWqoQ@mail.gmail.com>
In-Reply-To: <CABBYNZKJUnhGXJEsExCdWNaE448QhCeiymLm9yS80k18AeWqoQ@mail.gmail.com>
From: Hsin-chen Chuang <chharry@google.com>
Date: Fri, 28 Feb 2025 00:44:14 +0800
X-Gm-Features: AQ5f1JqK01ZvnP-L8U4QvS1hDgJeej74F_rIGE49YUE7A3c-OeCnVRBo_E8erI0
Message-ID: <CADg1FFeyRa8rGkJXb+4Ymeqn+3XLJ3ZEpBnQ_F3WvwrS+u1KfQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, Feb 27, 2025 at 11:59=E2=80=AFPM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Hsin-chen,
>
> On Thu, Feb 27, 2025 at 10:37=E2=80=AFAM Hsin-chen Chuang <chharry@google=
.com> wrote:
> >
> > Hi Luiz,
> >
> > On Thu, Feb 27, 2025 at 10:37=E2=80=AFPM Luiz Augusto von Dentz
> > <luiz.dentz@gmail.com> wrote:
> > >
> > > Hi Hsin-chen,
> > >
> > > On Wed, Feb 26, 2025 at 9:22=E2=80=AFPM Hsin-chen Chuang <chharry@goo=
gle.com> wrote:
> > > >
> > > > Hi Luiz,
> > > >
> > > > On Thu, Feb 27, 2025 at 4:55=E2=80=AFAM Luiz Augusto von Dentz
> > > > <luiz.dentz@gmail.com> wrote:
> > > > >
> > > > > Hi Hsin-chen,
> > > > >
> > > > > On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chharry=
@google.com> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfo=
undation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wr=
ote:
> > > > > > > > Hi Greg,
> > > > > > > >
> > > > > > > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@lin=
uxfoundation.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuan=
g wrote:
> > > > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > > >
> > > > > > > > > > Automatically configure the altsetting for USER_CHANNEL=
 when a SCO is
> > > > > > > > > > connected. This adds support for the USER_CHANNEL to tr=
ansfer SCO data
> > > > > > > > > > over USB transport.
> > > > > > > > > >
> > > > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attri=
bute to control USB alt setting")
> > > > > > > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > > > ---
> > > > > > > > > >
> > > > > > > > > > Changes in v2:
> > > > > > > > > > - Give up tracking the SCO handles. Only configure the =
altsetting when
> > > > > > > > > >   SCO connected.
> > > > > > > > > > - Put the change behind Kconfig/module parameter
> > > > > > > > > >
> > > > > > > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > > > > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++=
++++++++++++++++
> > > > > > > > > >  2 files changed, 57 insertions(+)
> > > > > > > > > >
> > > > > > > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/blueto=
oth/Kconfig
> > > > > > > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > > > > > > --- a/drivers/bluetooth/Kconfig
> > > > > > > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > > > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > > > > > > >         Say Y here to enable USB poll_sync for Bluetoot=
h USB devices by
> > > > > > > > > >         default.
> > > > > > > > > >
> > > > > > > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > > > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL w=
hen SCO connected"
> > > > > > > > > > +     depends on BT_HCIBTUSB
> > > > > > > > > > +     default n
> > > > >
> > > > > Maybe we can do just:
> > > > >
> > > > >  default y if CHROME_PLATFORMS
> > > > >
> > > > > > > > > > +     help
> > > > > > > > > > +       Say Y here to enable auto set isoc_altsetting f=
or USER_CHANNEL
> > > > > > > > > > +       when SCO connected
> > > > > > > > > > +
> > > > > > > > > > +       This can be overridden by passing btusb.auto_se=
t_isoc_alt=3D[y|n]
> > > > > > > > > > +       on the kernel commandline.
> > > > > > > > > > +
> > > > > > > > > >  config BT_HCIBTUSB_BCM
> > > > > > > > > >       bool "Broadcom protocol support"
> > > > > > > > > >       depends on BT_HCIBTUSB
> > > > > > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/blueto=
oth/btusb.c
> > > > > > > > > > index de3fa725d210..af93d757911b 100644
> > > > > > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > > > > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_B=
T_HCIBTUSB_AUTOSUSPEND);
> > > > > > > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_=
HCIBTUSB_POLL_SYNC);
> > > > > > > > > >  static bool reset =3D true;
> > > > > > > > > > +static bool auto_set_isoc_alt =3D
> > > > > > > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > > > > > > > >
> > > > > > > > > >  static struct usb_driver btusb_driver;
> > > > > > > > > >
> > > > > > > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_fr=
ags(struct btusb_data *data)
> > > > > > > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > +static void btusb_sco_connected(struct btusb_data *dat=
a, struct sk_buff *skb)
> > > > > > > > > > +{
> > > > > > > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > > > > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > > > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > > > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > > > > > > +     unsigned int notify_air_mode;
> > > > > > > > > > +
> > > > > > > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > > > > > > +             return;
> > > > > > > > > > +
> > > > > > > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_=
EV_SYNC_CONN_COMPLETE)
> > > > > > > > > > +             return;
> > > > > > > > > > +
> > > > > > > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || e=
v->status)
> > > > > > > > > > +             return;
> > > > > > > > > > +
> > > > > > > > > > +     switch (ev->air_mode) {
> > > > > > > > > > +     case BT_CODEC_CVSD:
> > > > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO=
_CVSD;
> > > > > > > > > > +             break;
> > > > > > > > > > +
> > > > > > > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO=
_TRANSP;
> > > > > > > > > > +             break;
> > > > > > > > > > +
> > > > > > > > > > +     default:
> > > > > > > > > > +             return;
> > > > > > > > > > +     }
> > > > > > > > > > +
> > > > > > > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u"=
, ev->air_mode);
> > > > > > > > > > +     data->sco_num =3D 1;
> > > > > > > > > > +     data->air_mode =3D notify_air_mode;
> > > > > > > > > > +     schedule_work(&data->work);
> > > > > > > > > > +}
> > > > > > > > > > +
> > > > > > > > > >  static int btusb_recv_event(struct btusb_data *data, s=
truct sk_buff *skb)
> > > > > > > > > >  {
> > > > > > > > > >       if (data->intr_interval) {
> > > > > > > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(stru=
ct btusb_data *data, struct sk_buff *skb)
> > > > > > > > > >               schedule_delayed_work(&data->rx_work, 0);
> > > > > > > > > >       }
> > > > > > > > > >
> > > > > > > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on S=
CO connected */
> > > > > > > > > > +     if (auto_set_isoc_alt &&
> > > > > > > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNE=
L))
> > > > > > > > > > +             btusb_sco_connected(data, skb);
> > > > > > > > > > +
> > > > > > > > > >       return data->recv_event(data->hdev, skb);
> > > > > > > > > >  }
> > > > > > > > > >
> > > > > > > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspe=
nd, "Enable USB autosuspend by default");
> > > > > > > > > >  module_param(reset, bool, 0644);
> > > > > > > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on ini=
tialization");
> > > > > > > > > >
> > > > > > > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > > > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_alt=
setting for USER_CHANNEL when SCO connected");
> > > > > > > > >
> > > > > > > > > This is not the 1990's, why are you adding new module par=
ameters when we
> > > > > > > > > have so many other more proper ways to do this?  And real=
ly, this would
> > > > > > > >
> > > > > > > > Sorry but could you please provide an example to guard a fe=
ature like this.
> > > > > > >
> > > > > > > Depends on what you want to do with this configuration.  Why =
is it an
> > > > > > > option at all?  Why can't it "just work"?  Module parameters =
are a pain
> > > > > >
> > > > > > I would like to hand this question to Luiz. I believe this patc=
h just
> > > > > > works because this configuration is defined in the spec.
> > > > > > I think Luiz's point is to project the potential existing user,=
 but
> > > > > > there's probably no User channel user sending SCO data with the=
 latest
> > > > > > btusb driver because:
> > > > > > a) There's no way to configure alt setting from userspace
> > > > > > b) Before eafcfcfca97d, SCO data would be rejected since User c=
hannel
> > > > > > shouldn't be able to modify hci_conn_num
> > > > >
> > > > > Perhaps you can just use CHROME_PLATFORMS (suggested above) in Kc=
onfig
> > > > > to enable intercepting of the events, etc, so we don't need any
> > > > > runtime parameters.
> > > >
> > > > I'm afraid that this doesn't resolve Greg's comment below because t=
he
> > > > multiple controllers are still bonded to the same config.
> > >
> > > Well that would be enabled for every controller plugged into the syst=
em.
> >
> > To clarify, I'm totally fine with runtime parameters and/or any
> > Kconfig like CHROME_PLATFORMS, although I'd prefer the current patch
> > more.
> >
> > But I guess Greg's point is that the multiple controllers should be
> > able to have different configurations at the same time. I'd respect
> > your decision to accept this patch or another patch with
> > CHROME_PLATFORMS, but I guess it's better to convince Greg first.
>
> Perhaps I got Greg's response wrong, but I think he was suggesting
> that it should just work without any special configuration, which is
> what I'm suggesting here, the use of CHROME_PLATFORMS is more of a
> stopgap until proper test automation is introduced.
>
> You can already have different configurations with respect to
> HCI_CHANNEL_USER since that is done per controller, btw that is used
> by the likes of btproxy tool for example which is normally used to
> hook the controller into a VM.

Thanks for the explanation. I'll follow the suggestion in v3.


Best Regards,

Hsin-chen
