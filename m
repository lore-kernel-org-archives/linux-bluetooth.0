Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281C34F898
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774366; cv=none; b=KpmGUF9AFQSLT33Ght1TJP/2jY/KKnGw50fCEIyqmTAhM3oMi9gy9re82P9k4z8lmJPaKAZ2iI/cIdx/7eYUuJD1lfqrlaaLtebtv/EZw3YluGils79bOzdx3oVQqB4C03a/1SAhh/7sy/zn31Rye1Og63SEwU7/M5ZP41nIGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774366; c=relaxed/simple;
	bh=DbFpvgChbGfxdw8xDIiDIqs8RFoQ4LVzYkB5IMnBeEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eGHAMbMJFB3fPbJL+mEM2gOP//7uon1xG6X2JYO+++B/7MB7Yd+QEj6YFnZCT6T0ltozu3TXzO1ykf0xM/kNfW5zUP9CApCee2BfGErcVNZ+4QZtF5tForI5LDziUc1VqADK/JRlQXUywd4+S2GUJ0p0vGn72vp8A2IlIsRTQns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uEkk1mSz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEkk1mSz"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-571e13cd856so14847a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 01:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713774362; x=1714379162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dIjSpFzc6wuUUvRoNAvf010gfUriOwpE+vCiO0BYwFY=;
        b=uEkk1mSzSpNVdzXHyFwgbuIMXRE0sy+kjwxRaIwbDUjn16p/VXiXThc+eEPwMO0yM5
         SQyDhBOaLzD/y3R5q25jbXUC59xHCKCY0dLEmVLKIsyPSZ7en9A72kx8JHMXdAfIUam3
         cxbRoAJw2u/x4nH/ReAryNbKIHfI6G5Tg5TzkrPmNAqyK9bgtXxAfYvhlUshhrFSiSS2
         gHaNoDXhBnuMzuSQNHx7YW3FmBC1EHjpIYxQvwGmpeGPgkuTy2RPmgjKPhw7ziM943Fk
         g2prbiWky23Zlv/kcSOlnlLYXh6qMt07oK3YonHGes2DB6X0Q34dEKCrKlNRqfvIgQrm
         wlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774362; x=1714379162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dIjSpFzc6wuUUvRoNAvf010gfUriOwpE+vCiO0BYwFY=;
        b=NIalJ5tIFFc3kOQV15vTj0dnk42t6SWzDQiTshZxiOfdm6d7M6XPiNNLzZ0Br/sS2V
         iRKb5Qt7Y0OvhyJPAA/z64bdh+6N6g4RBV5mqQAQd3ss2L8oqa8x0G7wBoBKiFI2aD06
         4ugMzmFZdjrpBvfxOBoB2br281FNZR7v5oypI6ovQewoXMGSuZlOwJU/uuyV+4QrnCKo
         G/yE4VAsFTqLIcLTbbrKlrM82C6xI450iIjncLFYIIk7i6EJC7oLn44wL7Ewmu4Q+1dp
         N7tWCwej8pwtq0G7dBbf+mCqZC69e6FXMckMcasmqoCTFLT8oDaLUYScQZjr+Ymcu2tS
         y3YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYYQ451kM5tZUagJ60sXDzjhXI9vrxS6H8Tz5wM6IH1F5XouPmaTx0sUfq8ZdJAuWAmXKarnB7TI9GV+eO0+Pbt0ynyGWNkjmHWTfHoGA1
X-Gm-Message-State: AOJu0Ywf9Ie7s+eOFXsnRpWXoBNeRMZFD1fI2ZH0n2MBHLZiJ7ze7vzo
	Kgix0cj19S2QPD8I/+guyGF2IUZFUB/OhI1NFl090CYOJBDID3CqJEBpFElv+fyxcsaYeCxNZu7
	8c64iX3a+tpvgQTTSrVpIlJtRN6WFXRJk2xZi
X-Google-Smtp-Source: AGHT+IE9JeQQLCu7nhMNKaiTfyP6ZF0+xEA3lJHdLbUAa1gOV9ye6P3FZco1GiciGNvgewufb05FgG/qwPJgdjvVuxg=
X-Received: by 2002:a05:6402:430a:b0:572:10ff:50b1 with SMTP id
 m10-20020a056402430a00b0057210ff50b1mr50373edc.2.1713774362161; Mon, 22 Apr
 2024 01:26:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422152413.1.Ib96985e197f3db620a127a84aa20f3f3017aaf57@changeid>
 <687c8f6a-d5d6-4918-bfd5-93d4b04da086@molgen.mpg.de>
In-Reply-To: <687c8f6a-d5d6-4918-bfd5-93d4b04da086@molgen.mpg.de>
From: Archie Pusaka <apusaka@google.com>
Date: Mon, 22 Apr 2024 16:25:49 +0800
Message-ID: <CAJQfnxGz9dJCU2YwwKYZLpZ73L5YS6=8yac8K5BUfPBjeeM4rg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Populate hci_set_hw_info for Intel and Realtek
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Archie Pusaka <apusaka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, chromeos-bluetooth-upstreaming@chromium.org, 
	Abhishek Pandit-Subedi <abhishekpandit@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Paul,

On Mon, 22 Apr 2024 at 15:32, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> Dear Archie,
>
>
> Thank you for your patch.
>
> Am 22.04.24 um 09:24 schrieb Archie Pusaka:
> > From: Archie Pusaka <apusaka@chromium.org>
> >
> > The hardware information surfaced via debugfs might be usable by the
> > userspace to set some configuration knobs. This patch sets the hw_info
> > for Intel and Realtek chipsets.
>
> Could you please add an example paste to the commit message?
>
Sure, I will add those.

> > Signed-off-by: Archie Pusaka <apusaka@chromium.org>
> > Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@google.com>
> >
> > ---
> >
> >   drivers/bluetooth/btintel.c | 9 +++++++++
> >   drivers/bluetooth/btrtl.c   | 7 +++++++
> >   2 files changed, 16 insertions(+)
> >
> > diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> > index a19ebe47bd951..dc48352166a52 100644
> > --- a/drivers/bluetooth/btintel.c
> > +++ b/drivers/bluetooth/btintel.c
> > @@ -2956,6 +2956,11 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> >                       err = -EINVAL;
> >               }
> >
> > +             hci_set_hw_info(hdev,
> > +                             "INTEL platform=%u variant=%u revision=%u",
> > +                             ver.hw_platform, ver.hw_variant,
> > +                             ver.hw_revision);
> > +
> >               goto exit_error;
> >       }
> >
> > @@ -3060,6 +3065,10 @@ static int btintel_setup_combined(struct hci_dev *hdev)
> >               break;
> >       }
> >
> > +     hci_set_hw_info(hdev, "INTEL platform=%u variant=%u",
> > +                     INTEL_HW_PLATFORM(ver_tlv.cnvi_bt),
> > +                     INTEL_HW_VARIANT(ver_tlv.cnvi_bt));
> > +
>
> Why does it need to be added at two places?
>
Intel put the HW information into two structs, the "intel_version ver"
and "intel_version_tlv ver_tlv".
I don't know the history of the two structs, but that requires us to
have the hw info set in two places.
At most only one of them is executed though.

> >   exit_error:
> >       kfree_skb(skb);
> >
> > diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> > index cc50de69e8dc9..4f1e37b4f7802 100644
> > --- a/drivers/bluetooth/btrtl.c
> > +++ b/drivers/bluetooth/btrtl.c
> > @@ -1339,6 +1339,13 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
> >
> >       btrtl_set_quirks(hdev, btrtl_dev);
> >
> > +     hci_set_hw_info(hdev,
> > +                     "RTL lmp_subver=%u hci_rev=%u hci_ver=%u hci_bus=%u",
> > +                     btrtl_dev->ic_info->lmp_subver,
> > +                     btrtl_dev->ic_info->hci_rev,
> > +                     btrtl_dev->ic_info->hci_ver,
> > +                     btrtl_dev->ic_info->hci_bus);
> > +
> >       btrtl_free(btrtl_dev);
> >       return ret;
> >   }
>
>
> Kind regards,
>
> Paul

Thanks!

Archie
