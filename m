Return-Path: <SRS0=/G8r=ZT=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F4C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2587C20835
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Nov 2019 19:43:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmEkHRjj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfK0TnI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:43:08 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:43817 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbfK0TnI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Nov 2019 14:43:08 -0500
Received: by mail-oi1-f194.google.com with SMTP id l20so21159566oie.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Nov 2019 11:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YYz/gCoGT38qxY+p3lh6FY7qd9aw4rrLjx5dV/OK/jo=;
        b=AmEkHRjju49Oh7wPe0NZBnH5oNz57q3KI12pCLkpQXTOM6Y4zoM88vpzXvj35+US3b
         5xJMWeplMyvwM00pnVoOJvuz5p+uwgEndhX5Dg0yHX5mtNGVNyFfRh0MZRDGtn0bvOX2
         wx953gcQPgOBTvQ6A5EeRzjAjrK/Zs+LKu/eSU9pdeU28T/frfCIsFHPVVtaNLPyqr5q
         zQauQvDqUVVhHmdgOYheDnI5tBf4dJVvE0P96sv02ZMNUgczUTElq4zhfB9EeoPfYuYx
         842YfDT3tCNoJBOgsJdkyNh6fDyKaUhtd1nZoVoMENyMOyYZ2haEc503u4d7GLexM3bX
         cWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YYz/gCoGT38qxY+p3lh6FY7qd9aw4rrLjx5dV/OK/jo=;
        b=TsJYCIVyDGt6PIECUfppIpM+6okMkpZolZtkQqvKH2Du92Z0Acmrxm6bxt2BifrHRS
         psIZ9K0x1b0APtx4wGGPb7zV/xVaSykT9i9KOU3rt74GqyaEcxxTFHzgwzifBZhVYZYM
         54vLX3sCv02Jc3R1D/T3mrZno26aqKD1Wg2dpBeQOkBUW57kzzMqmWvYB4rYgJPvGRx5
         0cHP6rxccF7Z1Yd7TuD3hpSUPg6XsxOu2017wtQuCAr6y4DEDl8GluqBAGh0oykuUSni
         c3hFkU2NDwsCTMcUgn6oj9Eg+YaD4KWV3pKPXyzIMqVuTuimPM+Z4ZFUFno4NCh0LcST
         544g==
X-Gm-Message-State: APjAAAX5ffjEoMnisAQglgg12wFcZlLFuRPguI+XlrYDHrMrzQFJIYh8
        p4mCSpxwUSfYRis9ZyrSAUBQYuaFaNaJkwz3uQs=
X-Google-Smtp-Source: APXvYqzg2xfa+4oskaGWWcp5FIMr0d7CU31MyIrFRmKAg3hAuhG5CGL/ZU6Nq0Z0xONVC4fTj9om7Sp7DxjSCCmLVX0=
X-Received: by 2002:a05:6808:117:: with SMTP id b23mr1231679oie.8.1574883787071;
 Wed, 27 Nov 2019 11:43:07 -0800 (PST)
MIME-Version: 1.0
References: <20191127110905.BlueZ.1.I95600043ffb5b2b6c4782497ff735ab5d3e37c13@changeid>
 <20191127190941.90789-1-abhishekpandit@chromium.org>
In-Reply-To: <20191127190941.90789-1-abhishekpandit@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 Nov 2019 21:42:54 +0200
Message-ID: <CABBYNZJk0=x4j4tgmsZUJmnqK74V4+hy9iciJB6N5doHsB5baQ@mail.gmail.com>
Subject: Re: [BlueZ PATCH 2/2] input: Change uinput name and set uniq attribute
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

On Wed, Nov 27, 2019 at 9:09 PM Abhishek Pandit-Subedi
<abhishekpandit@chromium.org> wrote:
>
> When creating the uinput device, change the name to the peer device
> name. Set the peer device address to the uniq attribute instead of the
> name.
>
> The resulting uinput device will look like this:
>
> $ udevadm info -a -p /sys/devices/virtual/input/input17
> ...
>   looking at device '/devices/virtual/input/input17':
>     KERNEL=="input17"
>     SUBSYSTEM=="input"
>     DRIVER==""
>     ATTR{inhibited}=="0"
>     ATTR{name}=="BeatsStudio Wireless"
>     ATTR{phys}=="00:00:00:6e:d0:74"
>     ATTR{properties}=="0"
>     ATTR{uniq}=="00:00:00:cc:1c:f3"
>
> ---
>
> This change requires an accompanying change in the kernel that adds the
> set uniq ioctl. The change is available here:
>
> https://lore.kernel.org/linux-bluetooth/20191127185139.65048-1-abhishekpandit@chromium.org/T/#u
>
> If this change looks ok, I would like to merge it with the previous
> change before merging since they're related.

I would split the UNIQ handling just in case it causes a problems in
some platform so we can easily revert, Im fine merging other parts
though.

>
>  profiles/audio/avctp.c | 18 +++++++++---------
>  src/uinput.h           |  2 ++
>  2 files changed, 11 insertions(+), 9 deletions(-)
>
> diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
> index 42136f94b..05df57bd2 100644
> --- a/profiles/audio/avctp.c
> +++ b/profiles/audio/avctp.c
> @@ -1162,7 +1162,7 @@ failed:
>  }
>
>  static int uinput_create(struct btd_device *device, const char *name,
> -                        const char *phys)
> +                        const char *src, const char *dst)
>  {
>         struct uinput_dev dev;
>         int fd, err, i;
> @@ -1203,8 +1203,8 @@ static int uinput_create(struct btd_device *device, const char *name,
>         ioctl(fd, UI_SET_EVBIT, EV_REP);
>         ioctl(fd, UI_SET_EVBIT, EV_SYN);
>
> -       /* Also set the phys */
> -       ioctl(fd, UI_SET_PHYS, phys);
> +       ioctl(fd, UI_SET_PHYS, src);
> +       ioctl(fd, UI_SET_UNIQ, dst);
>
>         for (i = 0; key_map[i].name != NULL; i++)
>                 ioctl(fd, UI_SET_KEYBIT, key_map[i].uinput);
> @@ -1224,7 +1224,7 @@ static int uinput_create(struct btd_device *device, const char *name,
>
>  static void init_uinput(struct avctp *session)
>  {
> -       char address[18], phys[18], name[248 + 1];
> +       char dest[18], src[18], name[248 + 1];
>
>         device_get_name(session->device, name, sizeof(name));
>         if (g_str_equal(name, "Nokia CK-20W")) {
> @@ -1234,15 +1234,15 @@ static void init_uinput(struct avctp *session)
>                 session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
>         }
>
> -       ba2strlc(device_get_address(session->device), address);
> +       ba2strlc(device_get_address(session->device), dest);
>         ba2strlc(btd_adapter_get_address(device_get_adapter(session->device)),
> -                phys);
> +                src);
>
> -       session->uinput = uinput_create(session->device, address, phys);
> +       session->uinput = uinput_create(session->device, name, src, dest);
>         if (session->uinput < 0)
> -               error("AVRCP: failed to init uinput for %s", address);
> +               error("AVRCP: failed to init uinput for %s", dest);
>         else
> -               DBG("AVRCP: uinput initialized for %s", address);
> +               DBG("AVRCP: uinput initialized for %s", dest);
>  }
>
>  static struct avctp_queue *avctp_queue_create(struct avctp_channel *chan)
> diff --git a/src/uinput.h b/src/uinput.h
> index 20e0941d1..589c22528 100644
> --- a/src/uinput.h
> +++ b/src/uinput.h
> @@ -686,6 +686,8 @@ extern "C" {
>  #define UI_SET_FFBIT           _IOW(UINPUT_IOCTL_BASE, 107, int)
>  #define UI_SET_PHYS            _IOW(UINPUT_IOCTL_BASE, 108, char*)
>  #define UI_SET_SWBIT           _IOW(UINPUT_IOCTL_BASE, 109, int)
> +#define UI_SET_PROPBIT         _IOW(UINPUT_IOCTL_BASE, 110, int)
> +#define UI_SET_UNIQ            _IOW(UINPUT_IOCTL_BASE, 111, char*)
>
>  #ifndef NBITS
>  #define NBITS(x) ((((x) - 1) / (sizeof(long) * 8)) + 1)
> --
> 2.24.0.432.g9d3f5f5b63-goog
>


-- 
Luiz Augusto von Dentz
