Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0288719ABB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Feb 2025 07:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740381227; cv=none; b=o9qjaa3lbGTk2FhJ6gjKAIfQdMYh7Q4zHig2LZurxa91WYV6QN1SsKiTagVkimWxyd5F2TVBdkxAVtTfali0eg2iKLUbMN9yUHrTiUGdPjQCkQtBmxjIXg+8i/jwz8/4psInscKjxNALVNMf7gzTcyx3ZhrkUq9MUw3WVVnpHoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740381227; c=relaxed/simple;
	bh=ptAje5SiDVEq7xxyOAtG4fwOQmV0CrpzXKDFEFCBgo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4+R+moMY3pokV4yeY8vRlmu5qlw8p43hXQmx2D6+B6pOKna3wgF5MDkj1A3gN3/mXTmBiNyA3DgLpcwbPb2v4BCqvYiOaybBQmzUJADib2+XXlFNgxSyA57CxZWUV1/TvxV5fHHcT4+oaaxZpYRJRDHnFZTpOgZQs13+CfgbYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qk+BW5ie; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qk+BW5ie"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e5df8468d6eso3161202276.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 23 Feb 2025 23:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740381225; x=1740986025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Semc5mMpQsWkD1sVkCsLdhfdCNCpbBhtUCrwzr2j3F8=;
        b=qk+BW5iezKqzWpx2NJq9SuBagfOzgkXYrjz0XRj5niege8b5NHSYxrCAZVot7AxStj
         utHjc8+9MfkipHrRFHWdbu/BE2PYk9kqi7GMeQKKw+cOZDrsZDGA3mk6lHj1NONK3gJa
         n3abzjBIZyYMhXEknNtX/k/oLeqcmyQYo9eQdTJiP+l9XqjS+WlkWUwNszfQr+Gj7bXk
         t4Ai4klET+63/3Pe3GGkxvj/WGk6KrsVIqhKJHe9C2nV1ob77JetygNow3q6tAxrGu2G
         64MMJYlMuNbH0XL0RzoWHRylr7lJMzkc2lBAL2CIeZKfjFRrfNkhDHRDAm+Ye/4dClEY
         zuhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740381225; x=1740986025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Semc5mMpQsWkD1sVkCsLdhfdCNCpbBhtUCrwzr2j3F8=;
        b=aQSGxhZccvAeaOXbiYyjJYco+7WBAhp0UfXBhw8Q28ePsWzvBm3V69WbdFIoRqwra0
         07l2jtnqYTuGdUi25kTJ8bi1iR81CoBpHWCfdmLGENbaPd9GyIKh9laFsXrksHYQ3x+P
         Z5uMjJ4GDqaLsv+VukVfc0xykGm/Em5jdgGXWxi7TgkqGzYAcqHlMpfPrbpqsE5GqpDD
         aAJsR3FtcdCufKvSvQRdNz9ePANz0zdemGIwD4YPLrQw3NWp70itxRpYZwUB7QyMhKCA
         LHjco0JHrHonR+lxZLPWQoJmBRrqkXFIsd+GOXiYuH9qKVcW8WckAiVncZUYZU95RvCY
         XDBg==
X-Gm-Message-State: AOJu0YxjM9ZkQx3fiztrnwKAP5xohdf8y8zik3ip8zEyloUBDrvoUAqf
	e8MjiaX1tHF2aiCV29eNN65FLgwV36BjYUzUqeqiRsqrSV+Fcmn5r4cmkc/7WuyvnV9NKhdgw27
	RuIX0Fb4u5yEhoLOJrtL4zBQZhRTCS/3CLjYm
X-Gm-Gg: ASbGncsEH4hyIKQF34WJvbGKL+ZWrSV3jhCoxY5gOAsb3hMlhZr157Naq5lkv38OiTc
	lUSBTqR0OvEFpteqlcltwiKKfW+M2LmIL2C8SOWW7evxEMM5f+zdq2QBInDgaSmw5MpoA6t7VqK
	2bLsmNF0oh
X-Google-Smtp-Source: AGHT+IEZrbBxm1LF/NEV8MZgFjYkpaICrfTfY23T8mXdJKPIdn+h6eA2w91MUwKAQjYZVvwQ3NYaXFLF5bTvlaUNkco=
X-Received: by 2002:a05:6902:168e:b0:e5b:42c7:8f21 with SMTP id
 3f1490d57ef6-e5e245b784dmr9327159276.7.1740381224723; Sun, 23 Feb 2025
 23:13:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
 <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com> <2025022407-polo-disgrace-9655@gregkh>
In-Reply-To: <2025022407-polo-disgrace-9655@gregkh>
From: Hsin-chen Chuang <chharry@google.com>
Date: Mon, 24 Feb 2025 15:13:17 +0800
X-Gm-Features: AWEUYZlT4OeXusnFgsZdXBLpnk2X21PFJOMgjPDL0SyEns4KFZ132qombPDpNzg
Message-ID: <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Greg KH <gregkh@linuxfoundation.org>, luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wrote:
> > Hi Greg,
> >
> > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang wrote:
> > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > >
> > > > Automatically configure the altsetting for USER_CHANNEL when a SCO =
is
> > > > connected. This adds support for the USER_CHANNEL to transfer SCO d=
ata
> > > > over USB transport.
> > > >
> > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute to cont=
rol USB alt setting")
> > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > ---
> > > >
> > > > Changes in v2:
> > > > - Give up tracking the SCO handles. Only configure the altsetting w=
hen
> > > >   SCO connected.
> > > > - Put the change behind Kconfig/module parameter
> > > >
> > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++++++++=
++++
> > > >  2 files changed, 57 insertions(+)
> > > >
> > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> > > > index 4ab32abf0f48..7c497f878732 100644
> > > > --- a/drivers/bluetooth/Kconfig
> > > > +++ b/drivers/bluetooth/Kconfig
> > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > >         Say Y here to enable USB poll_sync for Bluetooth USB device=
s by
> > > >         default.
> > > >
> > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL when SCO conn=
ected"
> > > > +     depends on BT_HCIBTUSB
> > > > +     default n
> > > > +     help
> > > > +       Say Y here to enable auto set isoc_altsetting for USER_CHAN=
NEL
> > > > +       when SCO connected
> > > > +
> > > > +       This can be overridden by passing btusb.auto_set_isoc_alt=
=3D[y|n]
> > > > +       on the kernel commandline.
> > > > +
> > > >  config BT_HCIBTUSB_BCM
> > > >       bool "Broadcom protocol support"
> > > >       depends on BT_HCIBTUSB
> > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > > index de3fa725d210..af93d757911b 100644
> > > > --- a/drivers/bluetooth/btusb.c
> > > > +++ b/drivers/bluetooth/btusb.c
> > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_A=
UTOSUSPEND);
> > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTUSB_POL=
L_SYNC);
> > > >  static bool reset =3D true;
> > > > +static bool auto_set_isoc_alt =3D
> > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > >
> > > >  static struct usb_driver btusb_driver;
> > > >
> > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(struct b=
tusb_data *data)
> > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > >  }
> > > >
> > > > +static void btusb_sco_connected(struct btusb_data *data, struct sk=
_buff *skb)
> > > > +{
> > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > +             (void *) skb->data + sizeof(*hdr);
> > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > +     unsigned int notify_air_mode;
> > > > +
> > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > +             return;
> > > > +
> > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYNC_CONN=
_COMPLETE)
> > > > +             return;
> > > > +
> > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->status)
> > > > +             return;
> > > > +
> > > > +     switch (ev->air_mode) {
> > > > +     case BT_CODEC_CVSD:
> > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > > > +             break;
> > > > +
> > > > +     case BT_CODEC_TRANSPARENT:
> > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANSP;
> > > > +             break;
> > > > +
> > > > +     default:
> > > > +             return;
> > > > +     }
> > > > +
> > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u", ev->air_mo=
de);
> > > > +     data->sco_num =3D 1;
> > > > +     data->air_mode =3D notify_air_mode;
> > > > +     schedule_work(&data->work);
> > > > +}
> > > > +
> > > >  static int btusb_recv_event(struct btusb_data *data, struct sk_buf=
f *skb)
> > > >  {
> > > >       if (data->intr_interval) {
> > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btusb_dat=
a *data, struct sk_buff *skb)
> > > >               schedule_delayed_work(&data->rx_work, 0);
> > > >       }
> > > >
> > > > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO connected=
 */
> > > > +     if (auto_set_isoc_alt &&
> > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > > +             btusb_sco_connected(data, skb);
> > > > +
> > > >       return data->recv_event(data->hdev, skb);
> > > >  }
> > > >
> > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "Enable =
USB autosuspend by default");
> > > >  module_param(reset, bool, 0644);
> > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on initialization"=
);
> > > >
> > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsetting for =
USER_CHANNEL when SCO connected");
> > >
> > > This is not the 1990's, why are you adding new module parameters when=
 we
> > > have so many other more proper ways to do this?  And really, this wou=
ld
> >
> > Sorry but could you please provide an example to guard a feature like t=
his.
>
> Depends on what you want to do with this configuration.  Why is it an
> option at all?  Why can't it "just work"?  Module parameters are a pain

I would like to hand this question to Luiz. I believe this patch just
works because this configuration is defined in the spec.
I think Luiz's point is to project the potential existing user, but
there's probably no User channel user sending SCO data with the latest
btusb driver because:
a) There's no way to configure alt setting from userspace
b) Before eafcfcfca97d, SCO data would be rejected since User channel
shouldn't be able to modify hci_conn_num

> to configure, we have loads of other ways to do this now (configfs,
> debugfs for debugging stuff, sysfs for device-specific things, etc.)
>
> > > not work at all for multiple controllers in teh same system, right?
> >
> > Do you mean we can't have separate parameters for different
> > controllers? Yes that's true, but why would a user want the different
> > behavior on the same machine?
>
> Why would you prevent them from allowing this to happen for a
> device-specific option?
>
> thanks,
>
> greg k-h

--=20
Best Regards,
Hsin-chen
