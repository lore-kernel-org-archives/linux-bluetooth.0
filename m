Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6B515B15D
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 17:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714151057; cv=none; b=VvIm4uOgnKPttEV6MYSytJbYqTt6AnCybDRc9wLJHeqxXDJYMu0I3ycv+OHCx5kMFw4hEyH2aHLar/1Fm/NZ0fa5v1RWzX1uJm1xrSw0L4A8gDM06mnnjRIxOx+of1XYbbUZev0umcLDF4WYDArFC7XxZ95rV28k0g1vBF0p7Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714151057; c=relaxed/simple;
	bh=FJjXIczJaw2fI8RrGmhS8e8S0A1Jj3c6aMXGB/NNg+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ofjyTRbYxBgd4cF545ttOA6NGXwlGd2GIIvB4HTdaBdU2EFaI7ThIhOBxm0QPn4US3PjUxii1oZtt6UitIgFpR8inC0egr52UWXZNj674IFSEhq6D+1lSBnAqOcccZ8G205O/drNAMmWnj3g0YQOTQON5MXKRoqiSCHYkTtEg3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RZCu09z0; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RZCu09z0"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-5aa20adda1dso1545529eaf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 10:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714151055; x=1714755855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O73neaw7snadd4AQtFov3VpyQLi3ArC1cYm4eGifaug=;
        b=RZCu09z0Pr95xc53EWSwLi7OhsgEpMbL0adykk2b7pZPCTbax6p0m90huwZtUY/mgH
         uaqx/CNG/3uR7doMSkc7jPvioNqrQJIAQ7eUxQAuGYpm0Fr8qtg27F3w3Dx1SKMQGfDf
         zulRdJhijtEJblCwJ7eT4iTfRp4Yypwlp9zJo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714151055; x=1714755855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O73neaw7snadd4AQtFov3VpyQLi3ArC1cYm4eGifaug=;
        b=eNsrbqHOTjPwk9NvO0A0eiZ0YEasHtlsHd7gORBpbDxk/uOOT9Y7SjLvz57fapxzui
         Gbtv227tiIu0xq332x0sZ+iPHs6OqoplEiDBPMWfu3VB3/xF3CKct/3sWdiMxVGluzqn
         YGvjBTp8z9rtjzic0il7QdB+5m9jw6RpX2bMtILO4+pUG6g1ZCnmLjjs9sfuOwTl1NN5
         sUc+4RoFUcrwhOHlxD2yTT0QcpUOdB1nsgXmX1PdASPQdBxbwJTaiIyEYavOeh1LND1i
         olPQVOhXXOyUw0Ovh74R4xsVH+baB+axsc8UxFCVqBpz+Khm4KC2wMxrsxAbxEg/QIaH
         6xuw==
X-Forwarded-Encrypted: i=1; AJvYcCWrRXycsKSo/5D7v/wjUpUTZh/fH52EJIfCtr9FlDr12pgaAX7N1pkCejNUQPokjBDmA0pNr3IxXqYizpuBfsKQrfk3LBBMGE2r9ul4GiFF
X-Gm-Message-State: AOJu0YySF6z5v28TPN1Q+UOoXPadUzDBiZjRO9ltUPR62yfbCohrUyDw
	frPV0YVgBkjOLcwShIZLCtwKwEVbr2+uABlU+TFPerNdx/XOJd3YBE3nQ54t7OC4HvySCCwNSwc
	eIBLb08784ySZENksaU4BXJNI3V9U5YDZdKXZ
X-Google-Smtp-Source: AGHT+IGmZO33lhd0TFRW/gwmhL8E9MhvWFP+CEAyGcd/vM+I6/+F5+SQRa3XzoMo99SWkPpL0km9zlT/kylxrCwpaX4=
X-Received: by 2002:a05:6358:438e:b0:17f:56be:8c95 with SMTP id
 x14-20020a056358438e00b0017f56be8c95mr3840486rwc.25.1714151054780; Fri, 26
 Apr 2024 10:04:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
 <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com> <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com>
In-Reply-To: <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Fri, 26 Apr 2024 10:04:03 -0700
Message-ID: <CANFp7mU2Chj_cZ_26kfM8TE1OToZzUeFKz61D7j-0ykMBQeG4A@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
To: Archie Pusaka <apusaka@google.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:08=E2=80=AFAM 'Archie Pusaka' via ChromeOS Blueto=
oth
Upstreaming <chromeos-bluetooth-upstreaming@chromium.org> wrote:
>
> Hi Luiz,
>
> On Thu, 25 Apr 2024 at 03:05, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> >
> > Hi Archie,
> >
> > On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusaka@google.c=
om> wrote:
> > >
> > > From: Archie Pusaka <apusaka@chromium.org>
> > >
> > > Sometimes we want the controller to not wake the host up, e.g. to
> > > save the battery. Add some debugfs knobs to force the wake by BT
> > > behavior.
> > >
> > > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> > >
> > > ---
> > >
> > >  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> > >  1 file changed, 19 insertions(+)
> > >
> > > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > > index 8bede0a335668..846b15fc3c04c 100644
> > > --- a/drivers/bluetooth/btusb.c
> > > +++ b/drivers/bluetooth/btusb.c
> > > @@ -873,6 +873,9 @@ struct btusb_data {
> > >         unsigned cmd_timeout_cnt;
> > >
> > >         struct qca_dump_info qca_dump;
> > > +
> > > +       bool force_enable_remote_wake;
> > > +       bool force_disable_remote_wake;
> > >  };
> > >
> > >  static void btusb_reset(struct hci_dev *hdev)
> > > @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interface *i=
ntf,
> > >
> > >         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, d=
ata,
> > >                             &force_poll_sync_fops);
> > > +       debugfs_create_bool("force_enable_remote_wake", 0644, hdev->d=
ebugfs,
> > > +                           &data->force_enable_remote_wake);
> > > +       debugfs_create_bool("force_disable_remote_wake", 0644, hdev->=
debugfs,
> > > +                           &data->force_disable_remote_wake);
> > >
> > >         return 0;
> > >
> > > @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interface =
*intf, pm_message_t message)
> > >                 }
> > >         }
> > >
> > > +       if (!PMSG_IS_AUTO(message)) {
> > > +               if (data->force_enable_remote_wake) {
> > > +                       data->udev->do_remote_wakeup =3D 1;
> > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data-=
>flags))
> > > +                               data->udev->reset_resume =3D 0;
> > > +               } else if (data->force_disable_remote_wake) {
> > > +                       data->udev->do_remote_wakeup =3D 0;
> > > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data-=
>flags))
> > > +                               data->udev->reset_resume =3D 1;
> > > +               }
> > > +       }
> > > +
> > >         return 0;
> > >  }
> > >
> > > --
> > > 2.44.0.769.g3c40516874-goog
> >
> > There is a D-Bus interface available to overwrite the wakeup setting:
> >
> > https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#boo=
lean-wakeallowed-readwrite
> >
> > Or do you want a master switch for it? On the other hand aren't we
> > getting into the rfkill area if you really want to switch off radio
> > activity while suspended? That seems like a better idea then just
> > disable remote wakeup.

This DBUS api is different from the quirk this is introducing.

The `Wake Allowed` field in D-bus controls whether we add the address
to the Classic Event Filter (HIDP) or LE Filter Accept List (HOGP) but
not whether we allow wake at the transport level (which is why
hdev->wakeup exists).

This change specifically addresses a quirk with Realtek chipsets:
RTL8822/RTL8852 will do "global shutdown" and power off Bluetooth if
USB Remote Wake bit is not set. The USB remote_wake bit is normally
set by the USB stack based on whether device_may_wakeup(udev) =3D=3D true.
This means that RTL88x2 will lose power around suspend/resume if there
are no wake capable devices connected.

ChromeOS decided to use idle power and resume-time to determine
whether to allow remote wake or not for these chipsets and we want to
move this control to userspace so that we don't have to hold CHROMIUM
patches in the kernel applying this policy (we want udev rules
instead). RTL8852 gets force enabled remote wake because the
RESET_RESUME behavior of this chip would otherwise increase our resume
time >1s which breaks one of our platform requirements.

The end-goal of these changes:
* We detect RTL8822 or RTL8852 with udev and apply the right policy.
* RTL8822 gets force_disable_remote_wake (idle power consumption too
high otherwise)
* RTL8852 gets force_enable_remote_wake (resume time too long otherwise)

Hope this provides enough context for why this change is necessary.

>
> Yes, the initial idea was a master switch.
> Thanks for your suggestions.
> Let me discuss it with Abhishek.
> >
> > --
> > Luiz Augusto von Dentz
>
> Thanks,
> Archie
>
> --
> You received this message because you are subscribed to the Google Groups=
 "ChromeOS Bluetooth Upstreaming" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to chromeos-bluetooth-upstreaming+unsubscribe@chromium.org.
> To post to this group, send email to chromeos-bluetooth-upstreaming@chrom=
ium.org.
> To view this discussion on the web visit https://groups.google.com/a/chro=
mium.org/d/msgid/chromeos-bluetooth-upstreaming/CAJQfnxHUW%2BMdJUp9VCrF2Nq_=
-JZrd7mKBR9NdDoo0SOvgH5WUQ%40mail.gmail.com.
