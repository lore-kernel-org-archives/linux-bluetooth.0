Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F8AC33C9E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 22:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0746D21D56
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 22:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwzAwujY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAQWRB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 17:17:01 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:43261 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726861AbgAQWRB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 17:17:01 -0500
Received: by mail-oi1-f193.google.com with SMTP id p125so23594075oif.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LTFauwtTN3iGYR5phr6guMn0cT10jUJQWz4BVaib5VY=;
        b=OwzAwujYWjp7dKBJAvVZ8gsvD+AQSN0RNuXDjkH2V4KeJxt81HHknLiBCgsJg6sDKe
         JUD4bnJQUOVuQBu7lmU3lKUQhg2+c9aHFbpbC1mUc2ml22iniKp7XMxAmIJonDnzZF65
         2YmEDVFnJuH0KSli4bbDBPf+AW2l/JaRQmCEKr3l9t2Zp+QXjtmjerDyI+VlCqY8Pl40
         1mYMC0zP0ckobsu/FYTYB9TOtGR39LPEkf6ckwUEfvBCaAAAV70bXi0u160nDTZR/H8o
         mlrUz4UZu3CwmuCgtT3ePEAW23Nx3VwdCt1Uya95dd0CDuwD0cwYHgeS9AZniejI4gkk
         JABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTFauwtTN3iGYR5phr6guMn0cT10jUJQWz4BVaib5VY=;
        b=D1o8oq6A/+EnqHY9pBxA+IZYlcWfcDr1Wvfa5cVRZaDugLEatQrT12gh1sWzVhnTFY
         lvuVimc4sSgOBk7W5cbCKMALGF8vVuFMRt7+abpfrL6nsV8lMXmcqgxafZpnL3sL8mhM
         mX3Q91OlwczITak4N4tF3t7PjXJ5BjI/wih/XBdug+e+xAqVqHuw7ffX/5NPa+2PF4FE
         0AlngkGl10OAyMQGhdExFPLPLpswPBCT240/XuQoqv2SoAH3Ees/OZU3jJCYY/SJmIIY
         LDHYXk9aWyWRkz+hKSX9X+IO+sYfG9F2sBUxf8i1JB/Zkaar4zdFjjIjSHlDgmqasDpP
         4/Vw==
X-Gm-Message-State: APjAAAWoGcV8C6/+qJgVN8zlDjNWuX3LpvqYEzj2KckYRjGGa1fkMw+8
        y5YevY7ymOoYJbtGumTK1ob17nFtSvDBV5cqEWp0cwhf
X-Google-Smtp-Source: APXvYqxk9toKMEnG6FXUMqN5uhmreDirmf2vh7n2Mn5oG/UyiK5BwJZoIde3g1Mz/3EPvaZ3A5HQrdoUpzbfaZYIf88=
X-Received: by 2002:aca:af54:: with SMTP id y81mr5134917oie.21.1579299420607;
 Fri, 17 Jan 2020 14:17:00 -0800 (PST)
MIME-Version: 1.0
References: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
 <20200117132754.BlueZ.2.Ie24be91b472c0a274606191bc4d14df030fe3598@changeid>
In-Reply-To: <20200117132754.BlueZ.2.Ie24be91b472c0a274606191bc4d14df030fe3598@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 17 Jan 2020 14:16:48 -0800
Message-ID: <CABBYNZJBf_FxO-=nVRqtC9MPEsD8dyXoGhFQPRYg0SB4wQG51Q@mail.gmail.com>
Subject: Re: [BlueZ PATCH 2/2] input: Make HID devices wake capable
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        chromeos-bluetooth-upstreaming@chromium.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Fri, Jan 17, 2020 at 1:28 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> HID devices can wake the host from a suspended state. Mark them as wake
> capable when they are accepted.

My suggestion is that we do this via application so we let the user
decide if he wants or not to wake up the system, you may still opt-in
to always enable to wake up in your system setting if you choose to,
going this route actually means the user can select not to wake up if
the device is somewhat broken or misbehaving in some respect which is
not that uncommon nowadays.

> ---
>
>  profiles/input/device.c | 1 +
>  profiles/input/hog.c    | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/profiles/input/device.c b/profiles/input/device.c
> index 2cb3811c8..a6b0e8053 100644
> --- a/profiles/input/device.c
> +++ b/profiles/input/device.c
> @@ -1381,6 +1381,7 @@ int input_device_register(struct btd_service *service)
>         }
>
>         btd_service_set_user_data(service, idev);
> +       device_set_wake_capable(device, true);
>
>         return 0;
>  }
> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
> index 83c017dcb..8627f3557 100644
> --- a/profiles/input/hog.c
> +++ b/profiles/input/hog.c
> @@ -159,6 +159,7 @@ static int hog_probe(struct btd_service *service)
>                 return -EINVAL;
>
>         btd_service_set_user_data(service, dev);
> +       device_set_wake_capable(device, true);
>         return 0;
>  }
>
> --
> 2.25.0.341.g760bfbb309-goog
>


-- 
Luiz Augusto von Dentz
