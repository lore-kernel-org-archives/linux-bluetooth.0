Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510E81C3314
	for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 13:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756215969; cv=none; b=iiqV7irAdjyHZIEeCmUbsxkcY5bF2otHagAVvSMFSPR/aCRcoEfBwDYU6Hs/MnOwjfHdTOncCpd455BpbmmkpJyUoB484KdSv5//7IhPu+xOs+7w63NrOiIBqkYDx/7skhh3c6RiwVxGLWadteor9LGmhYR+Zss+LLFEVKm9PnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756215969; c=relaxed/simple;
	bh=jcvQExH1eso9p1ubVgULY9L127aewsx+QwdxebD73RU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b6+1tgAzYpGUEFroAlojWj3Jqce0HQwykgkIHeQ5XjM07EGm+GfPfy7S85Lfl0bJlSBqUyx0U139NzlESnU3GO0HqZrX0YdcJDDytgU1N/6C6gd+e/3heH88MWRkuUsaNRTZ6REPE+qv5ZgvV6z7bdZOfexLQ9RaMp8KA0qAXkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRv1c/+R; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRv1c/+R"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3366be380e9so20006551fa.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Aug 2025 06:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756215965; x=1756820765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCIvSpgImKFfqVd+jt7WSYxtNMdxb8MP35aSjCgmFQA=;
        b=lRv1c/+RwpqV5St5YjMl5419KV97sny8dI1QcS43APYj/UsimKqTTQ0/efN49bwo1U
         7fPlS4vEqhBE9y0+uZLc+eCT6lfy0d2yItLOosaEbg+MLsB6RIRuitfUREI47q/SwqZM
         XushXvk0/T81//i3xmIYGmZkkuwzvWsdbnNwsGGTDp3ikZCnbhgYfwA9jJIFOqn+isiT
         KxFeaBoSue4/vJPvWlnNcuhGoU4yCZsocVNOYpngGso1I4dOhy+R6HaetrDe2p9Ls8pu
         PXouHjts8nJ44vmucNLuxXd6es2SRD493ahYduyZq82J4yqXT6OMJNmqbZJlddkF2q1z
         wF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756215965; x=1756820765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MCIvSpgImKFfqVd+jt7WSYxtNMdxb8MP35aSjCgmFQA=;
        b=AgA6+Ya6CBrS7On3fBnqeKN4CLpamHmPs9pf261w+fgbcjMV8KhmS5yv6gEAAgqmL6
         DL18Mq6o6+StdR/EY2/W/j2WPixJ2gY83jEn6BCa/Q6ClsQwgX540V4qQfsGpur9mv7q
         izjX0A5j4TXMfYlQb5W+2joWa8h0OIhfDsesTQ7Mx3F44JajUZjqWy4UKPkJFWa6t1+m
         B1+UgF5QG7J3wpXGbLAcsaFzFuoiv0QCw0qllD5LDHBbUDAM06jgrzgHrXCXqvLk0Axw
         bvsitsMVMCiQP+zMAui3tjDl8pwAEct+uVt0KUttK3Ftf4rn6lgnPC5FkfTk2HEIdmR3
         EWUQ==
X-Gm-Message-State: AOJu0YxBID5xsVgIM/3BvPRjGvvZ0Ms7n6iN6p30C1huByg23WFPHGAm
	Jisf0rEUti3o4jgsOnVSeDLtUqFWt6fDOT5eIwZobHi1YKWpBhzR6SANqzs4BlHxqJLHtD0AIml
	Wnj1kY/IRcMX6RwQu3QigRHMOS+2B6sAcO0ZE1bg=
X-Gm-Gg: ASbGncvrIEgFindCtYFqToQJH1FIh0unB798QD0unHFVqhMrsc+zw7rjoxaglDGaJIi
	MS8P26kLs134jx3r2bB8VEY147nTlL8/tArNsQLUu5LeFrkes8ZXeCjsPHmOpg2oq0Tyb4RGLwD
	vZbrlpPaeubdHb24x8p4Kq3K2dfj6QQFSTIAlLX86qW3nCFNg7eqBMGgZCH8TaLNLlZnVfvk3i+
	F4bFyUWrCzAIZ7dbWNw0ROQeu3PnZEIO7HsCjwHCWbMTa7luWIx8IeN
X-Google-Smtp-Source: AGHT+IGBkmVB/Ot86iBynXtScFk5NTDYUc72OSyKXOH6egDSL0v5jMQ98w9eLWM5yRDew+pDghJomZ/zvnJ8uU333jQ=
X-Received: by 2002:a05:651c:b11:b0:336:7589:27bd with SMTP id
 38308e7fff4ca-33675892c9amr24562551fa.5.1756215965062; Tue, 26 Aug 2025
 06:46:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825172504.339117-1-arkadiusz.bokowy@gmail.com>
 <CABBYNZKazQ0zROk1+gs5=U+zaZDwkMmD01MTYLuMZ3VUaoZZQg@mail.gmail.com>
 <CAGFh027fC8z3mx4zMm9Zu8GKFu7Ae7MKbze3Ef+4g0x90sRCag@mail.gmail.com>
 <CABBYNZL23GLaO0tQD9iYaG=OeUbxvbKrKCX1yOv7kfvM+L7W5Q@mail.gmail.com>
 <CAGFh025kOatLYjLrBMzrFQQG0oQHZQ-4=U-d0Nky780HrrOPhw@mail.gmail.com>
 <CABBYNZKN3PwV4XPM3=7t_1-+=m1nAmEVcZ9UB0yfgks45vnOXg@mail.gmail.com> <CAGFh026t_ba4x48ZQqhKnBxkQC=uLF5O8vHx--c_fxJTS1b=pg@mail.gmail.com>
In-Reply-To: <CAGFh026t_ba4x48ZQqhKnBxkQC=uLF5O8vHx--c_fxJTS1b=pg@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 26 Aug 2025 09:45:52 -0400
X-Gm-Features: Ac12FXw4G9ETD5WIhYeFE22A1T711W34KV8pSHyandtkMHR0jDJj9V8sEbnXPl8
Message-ID: <CABBYNZLHWsNXWRXn4CyK9yOQ6=TosuFMz=NQ6FPBk+_tu63shA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btusb: Fixup quirk for reading ext features on
 some Barrot controllers
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Arkadiusz,

On Tue, Aug 26, 2025 at 12:44=E2=80=AFAM Arkadiusz Bokowy
<arkadiusz.bokowy@gmail.com> wrote:
>
> > Could we solve this by doing:
> >
> > diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> > index 3595a8bad6bd..168b07041605 100644
> > --- a/drivers/bluetooth/btusb.c
> > +++ b/drivers/bluetooth/btusb.c
> > @@ -1194,6 +1194,17 @@ static int btusb_recv_intr(struct btusb_data
> > *data, void *buffer, int count)
> >                 }
> >
> >                 if (!hci_skb_expect(skb)) {
> > +                       /* Each chunk should correct to at least 1 or
> > more events
> > +                        * so if there are still bytes left that
> > doesn't constitute a new
> > +                         * event this is likely a bug in the controlle=
r.
> > +                        */
> > +                       if (count && count < HCI_EVENT_HDR_SIZE) {
> > +                               bt_dev_warn(data->hdev,
> > +                                           "Unexpected continuation: %=
d bytes",
> > +                                           count);
> > +                               count =3D 0;
> > +                       }
> > +
>
> I've just verified that this patch brings the Barrot dongle to live on
> Linux. Here is the output from dmesg:
>
> > [   43.329852] usb 1-1.4: new full-speed USB device number 4 using dwc_=
otg
> > [   43.446790] usb 1-1.4: New USB device found, idVendor=3D33fa, idProd=
uct=3D0012, bcdDevice=3D88.91
> > [   43.446813] usb 1-1.4: New USB device strings: Mfr=3D0, Product=3D2,=
 SerialNumber=3D0
> > [   43.446821] usb 1-1.4: Product: UGREEN BT6.0 Adapter
> > [   43.582024] Bluetooth: hci1: Unexpected continuation: 1 bytes
> > [   43.703025] Bluetooth: hci1: Unexpected continuation: 1 bytes
> > [   43.750141] Bluetooth: MGMT ver 1.23

Great, do you care to respin the patch with the above changes?

--=20
Luiz Augusto von Dentz
