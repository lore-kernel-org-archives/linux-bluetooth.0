Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 109DDC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 21:27:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379727AbiDDV2k (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Apr 2022 17:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380666AbiDDUxx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Apr 2022 16:53:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872932D1F3
        for <linux-bluetooth@vger.kernel.org>; Mon,  4 Apr 2022 13:51:56 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2eb888cf7e7so26248277b3.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 04 Apr 2022 13:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=iW69SAcVB27e5hZHnVV5J2SFFjF3daE6twYBTwITpwY=;
        b=MxjGa6fbQ6Q3GzQmShz40aGd5O4IA2OFa7jG6dLrh0HvM3mCtEnmJVfQnhzotPQ1dw
         vJZtiul9Ug2p7czaWfK4JJh77/m6E7v6bLNy7NGVDHq3+bZiWuAB97Wj7fMy4rCu69+y
         3WiGLm/a4JKRQnrNA4l58tBXtphC+GhABz2R4bDzDpoKqZCisVPlwZFGLnvA5dmodSDe
         R+yl1tUTtwBYwL+cbzV5coHEIbO6Ud6BYA/cZ5H54QuMl+IiNWIz7BbMWBvHaadbeeiw
         90QvmtLJoRBFMr+DWG4nRtai+ALcbiJbGchPg7vSnT87iClP5OhZr1WE6l9goZHLkyHc
         ufmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=iW69SAcVB27e5hZHnVV5J2SFFjF3daE6twYBTwITpwY=;
        b=R4hOVNhMkK8Qgc4InHfBCXHZ6RPqjofkBl1MCq5a6fU7oGd5G3PzyzOoHXkTFDIbql
         oohzoRUj6bokJ9CUZxU1FbXTGkCeOuwr4P3Hjxz3+G9ahXhZnhkRVoh/YdEh3Ndl+V8x
         pzCg2mYoDpQZeDzVRHdKqzmx0VW+0GebTSFknB4wNNQpTn271JSwbHOnUS7qYw0L463A
         ZAbTxGZXicdSNG9kqQeY23ZXAgzKDsagqZ1nOnHaE3PRllz/XLLxfVMcIfWzFJ0UwfW+
         uWOdmh8wjqlr4Zvcf8BKC2+9+DM8dhvb0KjNjZfP+QDoOQ6PgQn7uqCEI+02IoQy1AU9
         e/Iw==
X-Gm-Message-State: AOAM5324Jjm9xY/3yXumUgcKY/NHZXoZpFZv+4rGI1ld5KPxDGY+d45F
        cZr7pD2G7SlWIuRjl7QYOiz1zGambzBcLbYgXMmDxQPK
X-Google-Smtp-Source: ABdhPJxaaXv1ekKnKCV3JOyoK/7qyjskrLlX5WAQ5kqKYN/QIkBaVoj68GR1GEA+z5QYPSS6KbEkt9ZFFdDQvFhB9Sw=
X-Received: by 2002:a81:c305:0:b0:2eb:9875:76fd with SMTP id
 r5-20020a81c305000000b002eb987576fdmr1759246ywk.317.1649105515646; Mon, 04
 Apr 2022 13:51:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220404201750.1082470-1-luiz.dentz@gmail.com>
In-Reply-To: <20220404201750.1082470-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 4 Apr 2022 13:51:45 -0700
Message-ID: <CABBYNZK9PSUTMeKEdPFp16cGBtGyNC3V1LAYD5x0AVmpRYT_wA@mail.gmail.com>
Subject: Re: [RFC BlueZ] gap: Don't attempt to read the appearance if already set
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Adam,

On Mon, Apr 4, 2022 at 1:17 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Devices are unlikely to change appearance over time which is the reason
> why we cache then on the storage so this skips reading it on every
> reconnection.
> ---
>  profiles/gap/gas.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/profiles/gap/gas.c b/profiles/gap/gas.c
> index ea3249be9..400818d67 100644
> --- a/profiles/gap/gas.c
> +++ b/profiles/gap/gas.c
> @@ -142,6 +142,11 @@ static void read_appearance_cb(bool success, uint8_t att_ecode,
>
>  static void handle_appearance(struct gas *gas, uint16_t value_handle)
>  {
> +       uint16_t value;
> +
> +       if (!device_get_appearance(gas->device, &value))
> +               return;
> +
>         if (!bt_gatt_client_read_value(gas->client, value_handle,
>                                                 read_appearance_cb, gas, NULL))
>                 DBG("Failed to send request to read appearance");
> --
> 2.35.1

Check if the above works for you.

-- 
Luiz Augusto von Dentz
