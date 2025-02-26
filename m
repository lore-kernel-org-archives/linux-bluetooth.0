Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10091222586;
	Wed, 26 Feb 2025 20:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740603315; cv=none; b=lEeO5MMwGg0f91jZarEP8Co134h/U+QiLyeR2nia7fiBwnHabc6L7EGMD+qVq+y7FzszWMRU1q1ksJ5vefddg4qV+rkaftTBUcKqBIYatKhLkAPaX96lCc6yf6qCphVqazh8GReveFdbari+0wkTcgNuxu22diOd+w/EW8Bzd5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740603315; c=relaxed/simple;
	bh=8oqUoVbYJXkNii15KFVbUHxU2lO/RXEGujdm1d/EcZg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l8J61yOvSLkblIUOwLlFnlDyEm+u3So0VQrb09s7xPIkNORTxUivWdtaPmavzfc9cTyJAUefMxjHXKALHDoZt84SPDmsmYdd+J4AuXSoPXcibXS3pbGEMWwdEo8xZTALmJ4Li/WGtyhTw7DrWFpzf0vKh/zUnpr5mwhq/yBfOSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCv0WMmb; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCv0WMmb"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30930b0b420so2199471fa.2;
        Wed, 26 Feb 2025 12:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740603311; x=1741208111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wZFd1cWG8HSTfrYbFkIhhI/LdLxVUxChyJ0UB1bfsQU=;
        b=KCv0WMmbhb5omCWHnPHqWoIIsT0ydXIUGq26joi5oNAJNZkGhBQr3XX2T6el2GdkdL
         wWQ3YRXK6yNuA7G8s0iiHpm9TUVX+h7lMmh+toViyVlPLa92utJV6lfQTVmOLvJ1QB/i
         XMqTNDfo/OhkTEIrF1zCsACq08ABoIoLJhK+aJkhfJ2rjxiSd0/D26Dttj2HGBzhK7Va
         XGvfslVhd0cdHZVqEIiN/9SDP4jEaJWHU4JfE/p5E2VATXna8OMr5uyqJF1IiIFzegle
         Rou3CnplD26NVtY1ApiMe6PcKLE3I2112wR3iblvSMM8Y+kBPK1sNebcduylW93f8zxX
         hnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740603311; x=1741208111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wZFd1cWG8HSTfrYbFkIhhI/LdLxVUxChyJ0UB1bfsQU=;
        b=TC1m82PY1G6jgKirMGAKX9d2uXH2/3Jt0/9oXrmThBDHzQ0P1Y978R/GJWiasZJXGt
         M8MsiEc/GhwG1LLt54VZLVQcMnLURA9xQUm/0SP6Uw5FUYWiE0CUVOjQmTOOlX5wPiUw
         8danrppQUcbUU4s3BQcXdB+EeQg1hDBrD/Xoax+IrpQ21a/MGxfQP/bT3uDOSxugyNxU
         DR1I3nbiYQyD9oDJxu/UofmxJTr5raTRWkzb6ypYT7yQrWzRGQbgSn3Tq59sHPJ7FLmu
         Jt7adq7dt1GUQlWAKDnsjssT7iMxq7UoZs8pfVCRsw4ZvCf9NdS7QhSZMb/d9CisgEgm
         Ip2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUX/e+eLEwbEb5uNidyX5tGEBCU9thMb/IbaFwGghNzLJ4kYLmrenbkqZHm6aM3gE/z816vmyYBl1ariZKpFbo=@vger.kernel.org, AJvYcCXIWxUU+PSgFBuon44Xv5Ry6BJ8b48/41hMvuXkwO143VH2LovteNpzm1skE3i/6NCf3Sy5wD43SV6dxdy5@vger.kernel.org
X-Gm-Message-State: AOJu0YxPkCKSMsFTerr1U/wCLRoKvk3DC2RwpRdU2JzlJKJPdAPgisMx
	/HxloBqlL+QusxLeuLs08xLt9ujCMEt1ephtufEbzXfW6vrKD+N/j3RmThOCfSFTnE7/gc4PtIQ
	2cgWCpnAyvdS6E3iLDE2BsyrXcBY=
X-Gm-Gg: ASbGncsznjAOLNmTZk0Y/ZM17DVu12NI41PIz/QB5CSlx2Z8TPWeP4GovA27YwD/0V4
	986K5moHe6iNKFsES4tnR4lIrBnRjhwygZ54Hag987XirOdddMPdWgIzzW4q+XDx+N0CPow9zrk
	Y7sbIlTg==
X-Google-Smtp-Source: AGHT+IGvxKlNxIZKR1vSFthzrYv0K+6B/OqQVHzGOvPWnu1MQxE8ywH3QU1kBZ/Xlo3au+KYYCijiF1aOHyplTPLt7w=
X-Received: by 2002:a2e:8616:0:b0:300:26bc:4311 with SMTP id
 38308e7fff4ca-30b7918c228mr30288801fa.18.1740603310766; Wed, 26 Feb 2025
 12:55:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
 <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com>
 <2025022407-polo-disgrace-9655@gregkh> <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
In-Reply-To: <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Feb 2025 01:54:58 +0500
X-Gm-Features: AQ5f1Jq3pflrBGIS-gvgXR9Xpvr8spar-GwjqM5CkaYMvvHbsWUshuRMq_NNKYQ
Message-ID: <CABBYNZLhR+OJQnYZ5vN5HjgiWwKrXvOse-pXhCcTdFpJrrzsNg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.o=
rg> wrote:
> >
> > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wrote:
> > > Hi Greg,
> > >
> > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang wrote:
> > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > >
> > > > > Automatically configure the altsetting for USER_CHANNEL when a SC=
O is
> > > > > connected. This adds support for the USER_CHANNEL to transfer SCO=
 data
> > > > > over USB transport.
> > > > >
> > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to co=
ntrol USB alt setting")
> > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Give up tracking the SCO handles. Only configure the altsetting=
 when
> > > > >   SCO connected.
> > > > > - Put the change behind Kconfig/module parameter
> > > > >
> > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++=
++++++
> > > > >  2 files changed, 57 insertions(+)
> > > > >
> > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfi=
g
> > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > --- a/drivers/bluetooth/Kconfig
> > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > >         Say Y here to enable USB poll_sync for Bluetooth USB devi=
ces by
> > > > >         default.
> > > > >
> > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL when SCO co=
nnected"
> > > > > +     depends on BT_HCIBTUSB
> > > > > +     default n

Maybe we can do just:

 default y if CHROME_PLATFORMS

> > > > > +     help
> > > > > +       Say Y here to enable auto set isoc_altsetting for USER_CH=
ANNEL
> > > > > +       when SCO connected
> > > > > +
> > > > > +       This can be overridden by passing btusb.auto_set_isoc_alt=
=3D[y|n]
> > > > > +       on the kernel commandline.
> > > > > +
> > > > >  config BT_HCIBTUSB_BCM
> > > > >       bool "Broadcom protocol support"
> > > > >       depends on BT_HCIBTUSB
> > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.=
c
> > > > > index de3fa725d210..af93d757911b 100644
> > > > > --- a/drivers/bluetooth/btusb.c
> > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB=
_AUTOSUSPEND);
> > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_P=
OLL_SYNC);
> > > > >  static bool reset =3D true;
> > > > > +static bool auto_set_isoc_alt =3D
> > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > > >
> > > > >  static struct usb_driver btusb_driver;
> > > > >
> > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct=
 btusb_data *data)
> > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > >  }
> > > > >
> > > > > +static void btusb_sco_connected(struct btusb_data *data, struct =
sk_buff *skb)
> > > > > +{
> > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > +     unsigned int notify_air_mode;
> > > > > +
> > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > +             return;
> > > > > +
> > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CO=
NN_COMPLETE)
> > > > > +             return;
> > > > > +
> > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> > > > > +             return;
> > > > > +
> > > > > +     switch (ev->air_mode) {
> > > > > +     case BT_CODEC_CVSD:
> > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > > > > +             break;
> > > > > +
> > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> > > > > +             break;
> > > > > +
> > > > > +     default:
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_=
mode);
> > > > > +     data->sco_num =3D 1;
> > > > > +     data->air_mode =3D notify_air_mode;
> > > > > +     schedule_work(&data->work);
> > > > > +}
> > > > > +
> > > > >  static int btusb_recv_event(struct btusb_data *data, struct sk_b=
uff *skb)
> > > > >  {
> > > > >       if (data->intr_interval) {
> > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_d=
ata *data, struct sk_buff *skb)
> > > > >               schedule_delayed_work(&data->rx_work, 0);
> > > > >       }
> > > > >
> > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO connect=
ed */
> > > > > +     if (auto_set_isoc_alt &&
> > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > > > +             btusb_sco_connected(data, skb);
> > > > > +
> > > > >       return data->recv_event(data->hdev, skb);
> > > > >  }
> > > > >
> > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Enabl=
e USB autosuspend by default");
> > > > >  module_param(reset, bool, 0644);
> > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on initializatio=
n");
> > > > >
> > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsetting fo=
r USER_CHANNEL when SCO connected");
> > > >
> > > > This is not the 1990's, why are you adding new module parameters wh=
en we
> > > > have so many other more proper ways to do this?  And really, this w=
ould
> > >
> > > Sorry but could you please provide an example to guard a feature like=
 this.
> >
> > Depends on what you want to do with this configuration.  Why is it an
> > option at all?  Why can't it "just work"?  Module parameters are a pain
>
> I would like to hand this question to Luiz. I believe this patch just
> works because this configuration is defined in the spec.
> I think Luiz's point is to project the potential existing user, but
> there's probably no User channel user sending SCO data with the latest
> btusb driver because:
> a) There's no way to configure alt setting from userspace
> b) Before eafcfcfca97d, SCO data would be rejected since User channel
> shouldn't be able to modify hci_conn_num

Perhaps you can just use CHROME_PLATFORMS (suggested above) in Kconfig
to enable intercepting of the events, etc, so we don't need any
runtime parameters.

> > to configure, we have loads of other ways to do this now (configfs,
> > debugfs for debugging stuff, sysfs for device-specific things, etc.)
> >
> > > > not work at all for multiple controllers in teh same system, right?
> > >
> > > Do you mean we can't have separate parameters for different
> > > controllers? Yes that's true, but why would a user want the different
> > > behavior on the same machine?
> >
> > Why would you prevent them from allowing this to happen for a
> > device-specific option?
> >
> > thanks,
> >
> > greg k-h
>
> --
> Best Regards,
> Hsin-chen



--=20
Luiz Augusto von Dentz
