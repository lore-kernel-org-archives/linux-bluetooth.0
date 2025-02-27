Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9314619D07C;
	Thu, 27 Feb 2025 15:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740671955; cv=none; b=DMxwd4JIzYRQp8VIRIAlnY++dY5QenRc7YHXMKR5NqFdpZhIbmNYCa8ydz+gI0Udlerc6+wj15AX2FuwFLOyaRr/l2HfFoJRv78QUBdcroJL+0baelRw3ts6QSphECRbF4r0eLheAaiyyQeiEWjMEVfjFIRBmdS3B6t+UYIl/gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740671955; c=relaxed/simple;
	bh=DIIiVd0wrt5gmhRBay/JBDdPnVQIO2N87BqJlYs1YNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pb3PZFpWdNxvkuvYSn7xhj7QFjIvtY+yg/RSMR3UH0ImfmeAI7PzVkoYz5CVRmzX+cPhG5pHypfpfmwL28nO4YqteXFoE0FOBCezbiIs8cNIUfx0huwTov0LBjfAHMvoCZBwEyOz2jvG5nS3m6pAfT6mzeDEt2GS4xRLXeqb65A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGYKEvzD; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGYKEvzD"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30613802a59so12593691fa.0;
        Thu, 27 Feb 2025 07:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740671951; x=1741276751; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLwCLGXc7dk9a77ISsWMj9W6Kwu72Jc0n+DhZCKs7mI=;
        b=AGYKEvzDapLf21YBjojXcMVuVRogYR4CAUrgHhI1qJVU8Ks3+LzY2sQYoFzu+tRi3L
         ZOIAoki5v3rmyHodh62kI5MWfYSL4x9zgJybdBaLufBUVfagWRJJImcesHZ9AI7wkU0N
         linOw/P80I+aflUDTKeyms273FEJdHs+9cl6KR5mNLeH+38h7yOUDZTfQBrLs3zOtkOJ
         GHi8RMfI9/wqckhcHZqxvNb16/HqBAP6iRyXJOG8GYk22fmc1J48f2F/D4x482XyZh1I
         HLfpRaOY4k9Tkcemo6sOvUTerhMhH7DtReDL6jabG2dXKQG/6XONsJMYVnc8archd3Hf
         c12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740671951; x=1741276751;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLwCLGXc7dk9a77ISsWMj9W6Kwu72Jc0n+DhZCKs7mI=;
        b=S4PuVBrXF4U/wTeUwD7WZWbOCJw04kt9p6lVHR0K5PZtK71fDSbTWEQS1pi3GMR90B
         AHYR7pOOQm8Eu6MgjQ7Dvh+5G+lLruKm+mJUYJwnsfYSdYyWDVaymZ8OrUmSwWRB4Wmv
         VtpTq7LRrjlhYIGafFO0NGSHcRs58qxv3B4sDI+QHJ+2NrOBYSElbjrKVpbboI6fMw7A
         Y4WVSJ7I02SWnFe8jMAty2ceshXUVTamyMES8EGT2VKB3oEnIDM4b/KUduLRQFV3CsyU
         WIU1jNUjN3I1a1CqX3grRCNWuql35XqoauiCLkvb7E7azb9Y43a0CI+V4GDyot0/UvKd
         5FRw==
X-Forwarded-Encrypted: i=1; AJvYcCVi1XbclsE1Zqovnuhtqxq4l+WWXctQ47UC8y6OBr9pO8Gk3PLAaxoO1ahsd7ZaPScuhQhmM//+5KQdJEuk2tA=@vger.kernel.org, AJvYcCWpFucfNnBno+XOXS2c2oKgWugkynQQjXjBprHzKhtAQGLgpMiT8l/D5l/VIxCYdEZNUzm4oq3aFBg5rvdx@vger.kernel.org
X-Gm-Message-State: AOJu0YxE9I8kTAxzvGkszd3CcgZYlzEat9+KgsaNlUG58n8Bn11GBEmQ
	09xIav+5G79p5fj+wFxqPEkYr/b/Th4yuoo6b895f5iLdBJWEwYm9iumvv/dEVy4tIm/OkjxleC
	X3V27qls/WGKSa6atYi7c6q+ZRjU=
X-Gm-Gg: ASbGncu5JHcFi9XD4xiKbdECzpcMHuOsifTdJoo2Z4rmUmBUgTQTiFtAp2nA3YNoGuN
	8UHDc3PYJYHiJ5flTrP0OQiyCCje62XIHmuVCUJfNScTaas80F+l+pLl3V32tca9rD9lDZEZctQ
	snavlUGQ==
X-Google-Smtp-Source: AGHT+IFvLm13qjfJHYhjewmNFOMMxE92XIWro4PV0JODHt+fl6LVwHxgOjPDtEVhDHNj8LZo8mkEFA7Ei6ZcM1R9KsY=
X-Received: by 2002:a2e:9a98:0:b0:307:5879:e7d8 with SMTP id
 38308e7fff4ca-30b792cb29cmr40453401fa.30.1740671950978; Thu, 27 Feb 2025
 07:59:10 -0800 (PST)
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
 <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com> <CADg1FFdKfoJLxD+0A=j=kSLtMPLL-JptcWP1qH0Oo0SttN8k2g@mail.gmail.com>
In-Reply-To: <CADg1FFdKfoJLxD+0A=j=kSLtMPLL-JptcWP1qH0Oo0SttN8k2g@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Feb 2025 20:58:58 +0500
X-Gm-Features: AQ5f1Jr_oowpH8_bpfSQleM01eAK6TxxmFSuEAeQsjJtuN2UHAoDQ5OoqD8fVo8
Message-ID: <CABBYNZKJUnhGXJEsExCdWNaE448QhCeiymLm9yS80k18AeWqoQ@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Thu, Feb 27, 2025 at 10:37=E2=80=AFAM Hsin-chen Chuang <chharry@google.c=
om> wrote:
>
> Hi Luiz,
>
> On Thu, Feb 27, 2025 at 10:37=E2=80=AFPM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Wed, Feb 26, 2025 at 9:22=E2=80=AFPM Hsin-chen Chuang <chharry@googl=
e.com> wrote:
> > >
> > > Hi Luiz,
> > >
> > > On Thu, Feb 27, 2025 at 4:55=E2=80=AFAM Luiz Augusto von Dentz
> > > <luiz.dentz@gmail.com> wrote:
> > > >
> > > > Hi Hsin-chen,
> > > >
> > > > On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chharry@g=
oogle.com> wrote:
> > > > >
> > > > > On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wrot=
e:
> > > > > > > Hi Greg,
> > > > > > >
> > > > > > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linux=
foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang =
wrote:
> > > > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > >
> > > > > > > > > Automatically configure the altsetting for USER_CHANNEL w=
hen a SCO is
> > > > > > > > > connected. This adds support for the USER_CHANNEL to tran=
sfer SCO data
> > > > > > > > > over USB transport.
> > > > > > > > >
> > > > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribu=
te to control USB alt setting")
> > > > > > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > > > ---
> > > > > > > > >
> > > > > > > > > Changes in v2:
> > > > > > > > > - Give up tracking the SCO handles. Only configure the al=
tsetting when
> > > > > > > > >   SCO connected.
> > > > > > > > > - Put the change behind Kconfig/module parameter
> > > > > > > > >
> > > > > > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > > > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++=
++++++++++++++
> > > > > > > > >  2 files changed, 57 insertions(+)
> > > > > > > > >
> > > > > > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetoot=
h/Kconfig
> > > > > > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > > > > > --- a/drivers/bluetooth/Kconfig
> > > > > > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > > > > > >         Say Y here to enable USB poll_sync for Bluetooth =
USB devices by
> > > > > > > > >         default.
> > > > > > > > >
> > > > > > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL whe=
n SCO connected"
> > > > > > > > > +     depends on BT_HCIBTUSB
> > > > > > > > > +     default n
> > > >
> > > > Maybe we can do just:
> > > >
> > > >  default y if CHROME_PLATFORMS
> > > >
> > > > > > > > > +     help
> > > > > > > > > +       Say Y here to enable auto set isoc_altsetting for=
 USER_CHANNEL
> > > > > > > > > +       when SCO connected
> > > > > > > > > +
> > > > > > > > > +       This can be overridden by passing btusb.auto_set_=
isoc_alt=3D[y|n]
> > > > > > > > > +       on the kernel commandline.
> > > > > > > > > +
> > > > > > > > >  config BT_HCIBTUSB_BCM
> > > > > > > > >       bool "Broadcom protocol support"
> > > > > > > > >       depends on BT_HCIBTUSB
> > > > > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetoot=
h/btusb.c
> > > > > > > > > index de3fa725d210..af93d757911b 100644
> > > > > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > > > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_=
HCIBTUSB_AUTOSUSPEND);
> > > > > > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HC=
IBTUSB_POLL_SYNC);
> > > > > > > > >  static bool reset =3D true;
> > > > > > > > > +static bool auto_set_isoc_alt =3D
> > > > > > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > > > > > > >
> > > > > > > > >  static struct usb_driver btusb_driver;
> > > > > > > > >
> > > > > > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frag=
s(struct btusb_data *data)
> > > > > > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > +static void btusb_sco_connected(struct btusb_data *data,=
 struct sk_buff *skb)
> > > > > > > > > +{
> > > > > > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > > > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > > > > > +     unsigned int notify_air_mode;
> > > > > > > > > +
> > > > > > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > > > > > +             return;
> > > > > > > > > +
> > > > > > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV=
_SYNC_CONN_COMPLETE)
> > > > > > > > > +             return;
> > > > > > > > > +
> > > > > > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev-=
>status)
> > > > > > > > > +             return;
> > > > > > > > > +
> > > > > > > > > +     switch (ev->air_mode) {
> > > > > > > > > +     case BT_CODEC_CVSD:
> > > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_C=
VSD;
> > > > > > > > > +             break;
> > > > > > > > > +
> > > > > > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_T=
RANSP;
> > > > > > > > > +             break;
> > > > > > > > > +
> > > > > > > > > +     default:
> > > > > > > > > +             return;
> > > > > > > > > +     }
> > > > > > > > > +
> > > > > > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u", =
ev->air_mode);
> > > > > > > > > +     data->sco_num =3D 1;
> > > > > > > > > +     data->air_mode =3D notify_air_mode;
> > > > > > > > > +     schedule_work(&data->work);
> > > > > > > > > +}
> > > > > > > > > +
> > > > > > > > >  static int btusb_recv_event(struct btusb_data *data, str=
uct sk_buff *skb)
> > > > > > > > >  {
> > > > > > > > >       if (data->intr_interval) {
> > > > > > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct=
 btusb_data *data, struct sk_buff *skb)
> > > > > > > > >               schedule_delayed_work(&data->rx_work, 0);
> > > > > > > > >       }
> > > > > > > > >
> > > > > > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO=
 connected */
> > > > > > > > > +     if (auto_set_isoc_alt &&
> > > > > > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL)=
)
> > > > > > > > > +             btusb_sco_connected(data, skb);
> > > > > > > > > +
> > > > > > > > >       return data->recv_event(data->hdev, skb);
> > > > > > > > >  }
> > > > > > > > >
> > > > > > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend=
, "Enable USB autosuspend by default");
> > > > > > > > >  module_param(reset, bool, 0644);
> > > > > > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on initi=
alization");
> > > > > > > > >
> > > > > > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altse=
tting for USER_CHANNEL when SCO connected");
> > > > > > > >
> > > > > > > > This is not the 1990's, why are you adding new module param=
eters when we
> > > > > > > > have so many other more proper ways to do this?  And really=
, this would
> > > > > > >
> > > > > > > Sorry but could you please provide an example to guard a feat=
ure like this.
> > > > > >
> > > > > > Depends on what you want to do with this configuration.  Why is=
 it an
> > > > > > option at all?  Why can't it "just work"?  Module parameters ar=
e a pain
> > > > >
> > > > > I would like to hand this question to Luiz. I believe this patch =
just
> > > > > works because this configuration is defined in the spec.
> > > > > I think Luiz's point is to project the potential existing user, b=
ut
> > > > > there's probably no User channel user sending SCO data with the l=
atest
> > > > > btusb driver because:
> > > > > a) There's no way to configure alt setting from userspace
> > > > > b) Before eafcfcfca97d, SCO data would be rejected since User cha=
nnel
> > > > > shouldn't be able to modify hci_conn_num
> > > >
> > > > Perhaps you can just use CHROME_PLATFORMS (suggested above) in Kcon=
fig
> > > > to enable intercepting of the events, etc, so we don't need any
> > > > runtime parameters.
> > >
> > > I'm afraid that this doesn't resolve Greg's comment below because the
> > > multiple controllers are still bonded to the same config.
> >
> > Well that would be enabled for every controller plugged into the system=
.
>
> To clarify, I'm totally fine with runtime parameters and/or any
> Kconfig like CHROME_PLATFORMS, although I'd prefer the current patch
> more.
>
> But I guess Greg's point is that the multiple controllers should be
> able to have different configurations at the same time. I'd respect
> your decision to accept this patch or another patch with
> CHROME_PLATFORMS, but I guess it's better to convince Greg first.

Perhaps I got Greg's response wrong, but I think he was suggesting
that it should just work without any special configuration, which is
what I'm suggesting here, the use of CHROME_PLATFORMS is more of a
stopgap until proper test automation is introduced.

You can already have different configurations with respect to
HCI_CHANNEL_USER since that is done per controller, btw that is used
by the likes of btproxy tool for example which is normally used to
hook the controller into a VM.
