Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795DF25605
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 09:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714122536; cv=none; b=KMikuWpKZhc97bKJQl60l50LWt4FyG2D6xyVqCfGQxfNvsP49hHkvpC2QUMwJZZ2tiU3OO9f/lEv3FurwJB1KAa62WoG3KVEhwkxtypHODJsDBuCBo02KAXhb8zuAetpYnGncyAqCbz/208gNHjtD6/4n8MuyR3D4AfCS916U2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714122536; c=relaxed/simple;
	bh=PwJip2bI3d8w1d8xY7szIeXVyb2xY9y6x9ioLdBZf+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W42D6vPY4H/HcueEBg/KckOZx8rjPhzQEkYPx6ywtR2iNfXTELx6YLJLdbXACqB7Ea4sc6Li9wf1abj2jyNzGn/QJDvylYKKq5+BcakRcC0LmQICEWIhRIdZHgvCL35nNFpfXix6D/A4XwSDfJd3c76vfX/I7H5WZq+Mc6g2MDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4Wr1jHtE; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4Wr1jHtE"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso5821a12.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Apr 2024 02:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714122533; x=1714727333; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ja2hNeJD5lpzreFTljFzef74K+wsxiiyhKIsFU5oS/c=;
        b=4Wr1jHtE5ZUeI4hAwB/3/w+vHyhPBxN8zJK6cxhevx94lHoZbN0Qwna2OiAPhhaiAe
         5v6c0X5toAedPZE+eF1GPggKgB0PDKgvWQjXOrOAR/TS9YsZbV3G9EtOLLMgS0g49W3T
         SMFTfv4erAZC1JnuKZKCCfCcxAZlQctUxu81V3PLcIRqKiup1KiZMcwx45p3KAIaCmut
         EXvi+fNLYFzbbfCVkAwQUF3T83OBY5WLBais42PosFl6OFgZD4z7MIYMQss0pB/aCjhg
         mAhe9hza0D0CgwlZa9r++boN0y5VNpvoNkcDK+s15XmWsZ+nik+v7VN9jHLa9GfpyxML
         ZC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714122533; x=1714727333;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ja2hNeJD5lpzreFTljFzef74K+wsxiiyhKIsFU5oS/c=;
        b=qDzVWOb2jFUo/5Tg0c4nn1J1HCSdkJ0p+FegTOeaa2c+Xaj5U8kcRaaAhxQf7yPApu
         mFOudRfTssFI5LlholCw3qvzs63oQrgPPpx8DBfnQk6KhkGgTa7PQtQ8Wy2kPC8X1pM1
         ZOLby7THsjr4p8Y8xUl3lf+w46gGXKn3AmgHW5hYGIylbPKkgZpR+aU4iDXOs9KlA37p
         m9qGcbWU/8GVVtIkmwzNyy7mznFlVwiA+9dSaHFUDrNzVnTaw1kkSdT55ovdu50xAUd/
         XVLkqfxf1ch3TlAN41Cmi+mf1X9Ix/EknsGhNWF/7TIUSeQeWaP97ycuxNRoyTPk0weS
         viYA==
X-Gm-Message-State: AOJu0YxZMC+iLMhMVbOptiF7JLO8Na0mflSxBwOclWmhdBSKclwgav+B
	9IpFTTFCy3RcHpkIO2kWWgTIhFkTDNieJIzvzbVvLLuciV0NPINVn8i32jvQlzuzcvcBaR+yeyA
	I4edOcNpnKvRdx6rbRdyFWdfy7mNjwWlkMN31
X-Google-Smtp-Source: AGHT+IHujQYAqx2B45GLqCBKPuCqaju6NcYLIyZHXLX5p+QiGBrNWGqmIC64DsOoSSioYGIh1X5ZSdiYL+9ZdcrEV/w=
X-Received: by 2002:aa7:c512:0:b0:572:5d62:7971 with SMTP id
 o18-20020aa7c512000000b005725d627971mr16853edq.0.1714122532540; Fri, 26 Apr
 2024 02:08:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152500.1.I8939e49084a6fef78496eb73edafdf3c2c4afbf4@changeid>
 <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
In-Reply-To: <CABBYNZLCjrJUiVzNf53XYM-ZHWL6TZD4yFNtNGOuYi=6s5Q+OA@mail.gmail.com>
From: Archie Pusaka <apusaka@google.com>
Date: Fri, 26 Apr 2024 17:08:40 +0800
Message-ID: <CAJQfnxHUW+MdJUp9VCrF2Nq_-JZrd7mKBR9NdDoo0SOvgH5WUQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Add debugfs to force toggling remote wakeup
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Johan Hedberg <johan.hedberg@gmail.com>, Marcel Holtmann <marcel@holtmann.org>, 
	CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

On Thu, 25 Apr 2024 at 03:05, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Archie,
>
> On Mon, Apr 22, 2024 at 3:25=E2=80=AFAM Archie Pusaka <apusaka@google.com=
> wrote:
> >
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > Sometimes we want the controller to not wake the host up, e.g. to
> > save the battery. Add some debugfs knobs to force the wake by BT
> > behavior.
> >
> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> >
> > ---
> >
> >  drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 8bede0a335668..846b15fc3c04c 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -873,6 +873,9 @@ struct btusb_data {
> >         unsigned cmd_timeout_cnt;
> >
> >         struct qca_dump_info qca_dump;
> > +
> > +       bool force_enable_remote_wake;
> > +       bool force_disable_remote_wake;
> >  };
> >
> >  static void btusb_reset(struct hci_dev *hdev)
> > @@ -4596,6 +4599,10 @@ static int btusb_probe(struct usb_interface *int=
f,
> >
> >         debugfs_create_file("force_poll_sync", 0644, hdev->debugfs, dat=
a,
> >                             &force_poll_sync_fops);
> > +       debugfs_create_bool("force_enable_remote_wake", 0644, hdev->deb=
ugfs,
> > +                           &data->force_enable_remote_wake);
> > +       debugfs_create_bool("force_disable_remote_wake", 0644, hdev->de=
bugfs,
> > +                           &data->force_disable_remote_wake);
> >
> >         return 0;
> >
> > @@ -4702,6 +4709,18 @@ static int btusb_suspend(struct usb_interface *i=
ntf, pm_message_t message)
> >                 }
> >         }
> >
> > +       if (!PMSG_IS_AUTO(message)) {
> > +               if (data->force_enable_remote_wake) {
> > +                       data->udev->do_remote_wakeup =3D 1;
> > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->f=
lags))
> > +                               data->udev->reset_resume =3D 0;
> > +               } else if (data->force_disable_remote_wake) {
> > +                       data->udev->do_remote_wakeup =3D 0;
> > +                       if (test_bit(BTUSB_WAKEUP_AUTOSUSPEND, &data->f=
lags))
> > +                               data->udev->reset_resume =3D 1;
> > +               }
> > +       }
> > +
> >         return 0;
> >  }
> >
> > --
> > 2.44.0.769.g3c40516874-goog
>
> There is a D-Bus interface available to overwrite the wakeup setting:
>
> https://github.com/bluez/bluez/blob/master/doc/org.bluez.Device.rst#boole=
an-wakeallowed-readwrite
>
> Or do you want a master switch for it? On the other hand aren't we
> getting into the rfkill area if you really want to switch off radio
> activity while suspended? That seems like a better idea then just
> disable remote wakeup.

Yes, the initial idea was a master switch.
Thanks for your suggestions.
Let me discuss it with Abhishek.
>
> --
> Luiz Augusto von Dentz

Thanks,
Archie
