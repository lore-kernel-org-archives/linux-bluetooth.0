Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B14E545;
	Thu, 27 Feb 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740667067; cv=none; b=buR6/BwJcE4Lm3xzmMAAQuXyIUG+ftW1o5WRBs3scOfgQdsPDGoL4hLxKByvkAhlZ79Ch7Bt6Vhvhq4x/w4WSkmQsELg8STsX4DneF2AVmt6aNTPI/l0h938msxg1Ygso2m1UohEcwa2K+x12ndlH+hFIvWaqh4p0vcsaIfu2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740667067; c=relaxed/simple;
	bh=vn5C2r+aZ+xpvJI6yJuTpRgPVaBIjP3Oy1M6JW6YsKQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bw9WzNWpiWbdfbHGci5vPi9FqZdZObaORj1i8gctylqk4MjA91pTe5KRZJHST4NSKUsX4LIeAA6wLO/NPjTQUMqK6aklewHZMoa6AxCf/juZELoW3619lNONnA22OmbESeqXPN+3wjrcTX4xEYJMHOe/ol7lC/oIKmDa7AwH8QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuFJKCu6; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuFJKCu6"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-30a440effcfso23046971fa.0;
        Thu, 27 Feb 2025 06:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740667062; x=1741271862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ImxLy1MOg3k3Qztfs1yXlUdMX6UMvSo4Arah4/7gd7c=;
        b=MuFJKCu6bspb+bm0FaKWf8V5+OosjTnCmhnrCFdtN2ED76T6k/mA520x245RPTqETZ
         T1sIl2Tc3nKGAkgO5WfFQ6iRrf3KZS5we1etTLHJmFiSuf3IUQ5ZmIdTvnDi0AvwUoeR
         gAahTlGwOZ/2mnLkr5ib6ov0kKvKVRFIn4zyxel2lpYyL+BGp/kw2ADIesFVtinj3o0w
         HQeII9VkOQ9BuOVMcf+wNB/vWpEvfb2GNG7fO9MlsrcSYOL99L/prrSI9IPW52MEnFrm
         dK0SE/iGyWPW+75x4/EX06LaAKuYC8koy607zGqiPlj/kON/8UiQiiQdytKUnF0MJEPf
         y/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740667062; x=1741271862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ImxLy1MOg3k3Qztfs1yXlUdMX6UMvSo4Arah4/7gd7c=;
        b=F3COcDbqMsN0Lb1ECdsi551S1G6wU2o99/XfyOL+Z6qEwJ6GXjAR4poXcAql6Nxr2D
         H2X/0gWvdGXzzr0eurdwt9imK61f2UamWjRgstyCw3DwwZ9xoV/lFQXsS3YxMDZdP1M9
         VoNYNwjtWGxkWwl8CUQ4nXZl7cz7Gu9xtokkp/kZY1eMaUT/p4DO3rFE7IFI6pWJyhjB
         LKGQSDVrvgV9JF9JyvTL86eYnDS8YbnrnIoE3RXXo1zV0kcrdzcM+hPYE8emEqYC9Q/4
         XscY3FzkAkKhVntfKr68vsd7lz2xyu3AxjPOp5TrOW1n75ytS1syb+W/BMitFWax/GNv
         iuRg==
X-Forwarded-Encrypted: i=1; AJvYcCVX0feyAlo4hOoc6l6EiN6n/LM+gUvhJQoSbTH0sQHI+DXkFIyd8j4iYqI3cew3kNXdNmt+O53Omut/C9qi@vger.kernel.org, AJvYcCWBTlVkNjDOFKEkZgirrm9MYMvn+YU5tQ6W4+H55ZxTdTQpc+IykD1TvDRMZDQJyekFC9NSMyetz8uwb/6popw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWBsw8Y/5BIrmCRI86khojw785wSRQcj95259JawBPFJQj9poH
	mZk3lhVGr3znhIAHy3LnD9+aVxG043o21MhP/JoJ0uR1FxpKrA2qRhWgzJgaDqH6L2XkOLas2QV
	STO1wL3r7bRogPrSe4Zk73e7XEDg=
X-Gm-Gg: ASbGnctpI2lYR3QNG0Pqnk1z8NH9OWpsQj5dgNquavWHp1R+Nzfzvj5kdsJJtH+ocN0
	A9MEq9vO8kB9sWqe2dkTI72YhQW/rS30mQmBaw8/mJb+id7UAMJCC+MRhsn8sx5zKBY6bEcg2yA
	Du5jzvHQ==
X-Google-Smtp-Source: AGHT+IHuPmDhkLaIVHYupCg69sbvN+YVg1RHKBoI33YR9lNZpCgSi714NbLho8KVivwRVUs7aCn2uPtKEt09zoVcf+Q=
X-Received: by 2002:a05:651c:e13:b0:308:e956:66e with SMTP id
 38308e7fff4ca-30b84585759mr10530491fa.0.1740667061418; Thu, 27 Feb 2025
 06:37:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224045237.1290971-1-chharry@google.com> <2025022431-ditto-shy-c62f@gregkh>
 <CADg1FFeW5EXOJTqTS+jwBphGnDSCreNwM8hcFOhB1Tatdti6QA@mail.gmail.com>
 <2025022407-polo-disgrace-9655@gregkh> <CADg1FFehoZr3DmDhV_ri69+XBHLQcpKjoxLMaVhQUdzRuhST9A@mail.gmail.com>
 <CABBYNZLhR+OJQnYZ5vN5HjgiWwKrXvOse-pXhCcTdFpJrrzsNg@mail.gmail.com> <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com>
In-Reply-To: <CADg1FFdtr2gnKy5VfFoCm4+0cGRJkvsOBRXtrcLSaMJwGjhBUQ@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 27 Feb 2025 19:37:28 +0500
X-Gm-Features: AQ5f1JptFhTylsgNLZrs7QfSJ8srxVJ3Zrmms9a3mGRGvspmeIvbXZGayg0n610
Message-ID: <CABBYNZJX2hA8D++hb9d3nvCz4M1rfFrzpMPMQ8p0Bq8FTHZhig@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: btusb: Configure altsetting for USER_CHANNEL
To: Hsin-chen Chuang <chharry@google.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-bluetooth@vger.kernel.org, 
	chromeos-bluetooth-upstreaming@chromium.org, 
	Hsin-chen Chuang <chharry@chromium.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hsin-chen,

On Wed, Feb 26, 2025 at 9:22=E2=80=AFPM Hsin-chen Chuang <chharry@google.co=
m> wrote:
>
> Hi Luiz,
>
> On Thu, Feb 27, 2025 at 4:55=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Hsin-chen,
> >
> > On Mon, Feb 24, 2025 at 2:13=E2=80=AFAM Hsin-chen Chuang <chharry@googl=
e.com> wrote:
> > >
> > > On Mon, Feb 24, 2025 at 2:44=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 02:25:52PM +0800, Hsin-chen Chuang wrote:
> > > > > Hi Greg,
> > > > >
> > > > > On Mon, Feb 24, 2025 at 2:10=E2=80=AFPM Greg KH <gregkh@linuxfoun=
dation.org> wrote:
> > > > > >
> > > > > > On Mon, Feb 24, 2025 at 12:52:32PM +0800, Hsin-chen Chuang wrot=
e:
> > > > > > > From: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > >
> > > > > > > Automatically configure the altsetting for USER_CHANNEL when =
a SCO is
> > > > > > > connected. This adds support for the USER_CHANNEL to transfer=
 SCO data
> > > > > > > over USB transport.
> > > > > > >
> > > > > > > Fixes: b16b327edb4d ("Bluetooth: btusb: add sysfs attribute t=
o control USB alt setting")
> > > > > > > Signed-off-by: Hsin-chen Chuang <chharry@chromium.org>
> > > > > > > ---
> > > > > > >
> > > > > > > Changes in v2:
> > > > > > > - Give up tracking the SCO handles. Only configure the altset=
ting when
> > > > > > >   SCO connected.
> > > > > > > - Put the change behind Kconfig/module parameter
> > > > > > >
> > > > > > >  drivers/bluetooth/Kconfig | 11 ++++++++++
> > > > > > >  drivers/bluetooth/btusb.c | 46 +++++++++++++++++++++++++++++=
++++++++++
> > > > > > >  2 files changed, 57 insertions(+)
> > > > > > >
> > > > > > > diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kc=
onfig
> > > > > > > index 4ab32abf0f48..7c497f878732 100644
> > > > > > > --- a/drivers/bluetooth/Kconfig
> > > > > > > +++ b/drivers/bluetooth/Kconfig
> > > > > > > @@ -56,6 +56,17 @@ config BT_HCIBTUSB_POLL_SYNC
> > > > > > >         Say Y here to enable USB poll_sync for Bluetooth USB =
devices by
> > > > > > >         default.
> > > > > > >
> > > > > > > +config BT_HCIBTUSB_AUTO_SET_ISOC_ALT
> > > > > > > +     bool "Auto set isoc_altsetting for USER_CHANNEL when SC=
O connected"
> > > > > > > +     depends on BT_HCIBTUSB
> > > > > > > +     default n
> >
> > Maybe we can do just:
> >
> >  default y if CHROME_PLATFORMS
> >
> > > > > > > +     help
> > > > > > > +       Say Y here to enable auto set isoc_altsetting for USE=
R_CHANNEL
> > > > > > > +       when SCO connected
> > > > > > > +
> > > > > > > +       This can be overridden by passing btusb.auto_set_isoc=
_alt=3D[y|n]
> > > > > > > +       on the kernel commandline.
> > > > > > > +
> > > > > > >  config BT_HCIBTUSB_BCM
> > > > > > >       bool "Broadcom protocol support"
> > > > > > >       depends on BT_HCIBTUSB
> > > > > > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/bt=
usb.c
> > > > > > > index de3fa725d210..af93d757911b 100644
> > > > > > > --- a/drivers/bluetooth/btusb.c
> > > > > > > +++ b/drivers/bluetooth/btusb.c
> > > > > > > @@ -34,6 +34,8 @@ static bool force_scofix;
> > > > > > >  static bool enable_autosuspend =3D IS_ENABLED(CONFIG_BT_HCIB=
TUSB_AUTOSUSPEND);
> > > > > > >  static bool enable_poll_sync =3D IS_ENABLED(CONFIG_BT_HCIBTU=
SB_POLL_SYNC);
> > > > > > >  static bool reset =3D true;
> > > > > > > +static bool auto_set_isoc_alt =3D
> > > > > > > +     IS_ENABLED(CONFIG_BT_HCIBTUSB_AUTO_SET_ISOC_ALT);
> > > > > > >
> > > > > > >  static struct usb_driver btusb_driver;
> > > > > > >
> > > > > > > @@ -1113,6 +1115,42 @@ static inline void btusb_free_frags(st=
ruct btusb_data *data)
> > > > > > >       spin_unlock_irqrestore(&data->rxlock, flags);
> > > > > > >  }
> > > > > > >
> > > > > > > +static void btusb_sco_connected(struct btusb_data *data, str=
uct sk_buff *skb)
> > > > > > > +{
> > > > > > > +     struct hci_event_hdr *hdr =3D (void *) skb->data;
> > > > > > > +     struct hci_ev_sync_conn_complete *ev =3D
> > > > > > > +             (void *) skb->data + sizeof(*hdr);
> > > > > > > +     struct hci_dev *hdev =3D data->hdev;
> > > > > > > +     unsigned int notify_air_mode;
> > > > > > > +
> > > > > > > +     if (hci_skb_pkt_type(skb) !=3D HCI_EVENT_PKT)
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     if (skb->len < sizeof(*hdr) || hdr->evt !=3D HCI_EV_SYN=
C_CONN_COMPLETE)
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     if (skb->len !=3D sizeof(*hdr) + sizeof(*ev) || ev->sta=
tus)
> > > > > > > +             return;
> > > > > > > +
> > > > > > > +     switch (ev->air_mode) {
> > > > > > > +     case BT_CODEC_CVSD:
> > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_CVSD;
> > > > > > > +             break;
> > > > > > > +
> > > > > > > +     case BT_CODEC_TRANSPARENT:
> > > > > > > +             notify_air_mode =3D HCI_NOTIFY_ENABLE_SCO_TRANS=
P;
> > > > > > > +             break;
> > > > > > > +
> > > > > > > +     default:
> > > > > > > +             return;
> > > > > > > +     }
> > > > > > > +
> > > > > > > +     bt_dev_info(hdev, "enabling SCO with air mode %u", ev->=
air_mode);
> > > > > > > +     data->sco_num =3D 1;
> > > > > > > +     data->air_mode =3D notify_air_mode;
> > > > > > > +     schedule_work(&data->work);
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int btusb_recv_event(struct btusb_data *data, struct =
sk_buff *skb)
> > > > > > >  {
> > > > > > >       if (data->intr_interval) {
> > > > > > > @@ -1120,6 +1158,11 @@ static int btusb_recv_event(struct btu=
sb_data *data, struct sk_buff *skb)
> > > > > > >               schedule_delayed_work(&data->rx_work, 0);
> > > > > > >       }
> > > > > > >
> > > > > > > +     /* Configure altsetting for HCI_USER_CHANNEL on SCO con=
nected */
> > > > > > > +     if (auto_set_isoc_alt &&
> > > > > > > +         hci_dev_test_flag(data->hdev, HCI_USER_CHANNEL))
> > > > > > > +             btusb_sco_connected(data, skb);
> > > > > > > +
> > > > > > >       return data->recv_event(data->hdev, skb);
> > > > > > >  }
> > > > > > >
> > > > > > > @@ -4354,6 +4397,9 @@ MODULE_PARM_DESC(enable_autosuspend, "E=
nable USB autosuspend by default");
> > > > > > >  module_param(reset, bool, 0644);
> > > > > > >  MODULE_PARM_DESC(reset, "Send HCI reset command on initializ=
ation");
> > > > > > >
> > > > > > > +module_param(auto_set_isoc_alt, bool, 0644);
> > > > > > > +MODULE_PARM_DESC(auto_set_isoc_alt, "Auto set isoc_altsettin=
g for USER_CHANNEL when SCO connected");
> > > > > >
> > > > > > This is not the 1990's, why are you adding new module parameter=
s when we
> > > > > > have so many other more proper ways to do this?  And really, th=
is would
> > > > >
> > > > > Sorry but could you please provide an example to guard a feature =
like this.
> > > >
> > > > Depends on what you want to do with this configuration.  Why is it =
an
> > > > option at all?  Why can't it "just work"?  Module parameters are a =
pain
> > >
> > > I would like to hand this question to Luiz. I believe this patch just
> > > works because this configuration is defined in the spec.
> > > I think Luiz's point is to project the potential existing user, but
> > > there's probably no User channel user sending SCO data with the lates=
t
> > > btusb driver because:
> > > a) There's no way to configure alt setting from userspace
> > > b) Before eafcfcfca97d, SCO data would be rejected since User channel
> > > shouldn't be able to modify hci_conn_num
> >
> > Perhaps you can just use CHROME_PLATFORMS (suggested above) in Kconfig
> > to enable intercepting of the events, etc, so we don't need any
> > runtime parameters.
>
> I'm afraid that this doesn't resolve Greg's comment below because the
> multiple controllers are still bonded to the same config.

Well that would be enabled for every controller plugged into the system.

> Also I would hesitate to put this Chrome devices specific because
> project Floss shall be able to run on a general Linux environment.

It can be enabled for Linux in general, it just not enabled by default
which can be changed later if someone decides to use Floss outside of
Chrome OS, that said I very much doubt Google would be supporting
anything other then Chrome based platforms or Floss don't depend on
Android vendor HCI commands? At least the Android documentation seems
to suggest a bunch of vendor commands are required:

https://source.android.com/docs/core/connect/bluetooth/hci_requirements

> If you have a strong opinion to guard this behind a flag, perhaps we
> could try other options suggested by Greg (configfs or maybe back to
> sysfs).

I think those would be more complicated then handling this via
Kconfig, besides I think this works best since there is no new API
introduced, just a new Kconfig option which can be enabled in any
platform/distro.

> >
> > > > to configure, we have loads of other ways to do this now (configfs,
> > > > debugfs for debugging stuff, sysfs for device-specific things, etc.=
)
> > > >
> > > > > > not work at all for multiple controllers in teh same system, ri=
ght?
> > > > >
> > > > > Do you mean we can't have separate parameters for different
> > > > > controllers? Yes that's true, but why would a user want the diffe=
rent
> > > > > behavior on the same machine?
> > > >
> > > > Why would you prevent them from allowing this to happen for a
> > > > device-specific option?
> > > >
> > > > thanks,
> > > >
> > > > greg k-h
> > >
> > > --
> > > Best Regards,
> > > Hsin-chen
> >
> >
> >
> > --
> > Luiz Augusto von Dentz
>
>
> Best Regards,
>
> Hsin-chen



--=20
Luiz Augusto von Dentz
