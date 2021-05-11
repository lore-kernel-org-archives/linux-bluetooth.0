Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6EE1C433ED
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B558E61625
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 May 2021 18:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhEKSF4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 May 2021 14:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhEKSF4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 May 2021 14:05:56 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826BCC061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:04:48 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 15so27545204ybc.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 May 2021 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zdDJxG9IGj/xdsLMmHFEAKBlvZKxaTVxkJYJhr2qjI0=;
        b=Z0KIryTf5PYZFuKEBdhQwWMoxZBKsU6p7apMJtSYlGxlNqO1L3TQcrYVyB1c8rHj/h
         xCvtIPQaOgDztU23Z3XoAVLeqVXo5uMMRa/syd9pclv8Lp70U9ANAfNoaXlsEzEFFvMj
         VGw9pc0PBBMU7UwjiiUI5B3hyJUwf+b5TdzttpeMT0USOERhWHSYujlVbaX+HutrR1vX
         CfvVp/FF+61VxifdBiiH6/7yo3VdXW3rX+G+YVDFqR+zyvkBnardgENO7CsRgzCsbyoE
         kkeptsjYRTXGU7vNVMashrSXnXyYHfpfnOGljD3s8gYsL/wPDySVikBaV+U0bAmYVdO3
         IfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zdDJxG9IGj/xdsLMmHFEAKBlvZKxaTVxkJYJhr2qjI0=;
        b=NNT7sX5+xqCEbQdBx5ZKqkOfermtKJ73EKt3rTdMIuiOuTs57MSy4QExPm2GhNARU1
         yMeMOS9nmOpB6QyKbNvr/1H9wirBVXezBq9Zv3cRiy9SE+O6mB11yByoV5wNB1QjQ1sK
         buv9A2et7S9xAAuWIBWXl2Kwgu7Iwr7MbSOSo+Yc82ULY2do8cMJKvZzOnvJuhiWLj7E
         Xnh4AsKlJ3W/LgpWQuHEWuK/GVUU7QFE0z0/7vNpeYbCYgT9IZeAAqE0w/JoYwBChLrK
         FKQgjMozEChDIwl1DsrqeR0dFZCEyDAkY2j/nIfhUqHRjZrOFbjnMA56xzxG+jYqpeaA
         O4ow==
X-Gm-Message-State: AOAM530v80MvkB3FeusWkXdtamBTihX+e2PGuZbbyZHTaggwMqMbldMt
        7HbhZGVbHXiSyAJ6bHxAl6FzizOVdCUFSTdinNGzG6y9
X-Google-Smtp-Source: ABdhPJy4HYghnQe98dMkBYQoTrazk42mR4ME9HWEjUPlbNKvegzIk955APpJ3rYGL3cyprwWu5uonpPVMJoS3SKuabo=
X-Received: by 2002:a25:9a04:: with SMTP id x4mr26758873ybn.440.1620756287718;
 Tue, 11 May 2021 11:04:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210511152807.Bluez.v1.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
In-Reply-To: <20210511152807.Bluez.v1.1.I6d2ab6907d9a84fa62ac8a39daef5bef7ff545d5@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 11 May 2021 11:04:36 -0700
Message-ID: <CABBYNZ+JiqjRR0p6LSFr8MZ6i2pojDDjmh5X5n8MCRih06WEUQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] monitor: Fix possible crash of rfcomm packet
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Tue, May 11, 2021 at 12:28 AM Howard Chung <howardchung@google.com> wrote:
>
> From: Yun-Hao Chung <howardchung@chromium.org>
>
> When RFCOMM_TEST_EA returns false, btmon assumes packet data has at
> least 5 bytes long. If that assumption fails, btmon could crash when
> trying to read the next byte.
> This patch fix it by checking the remaining size before reading the last
> byte.
>
> Reviewed-by: apusaka@chromium.org
> ---
>
>  monitor/rfcomm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/monitor/rfcomm.c b/monitor/rfcomm.c
> index 9b88a3440e31..76b1123bb23d 100644
> --- a/monitor/rfcomm.c
> +++ b/monitor/rfcomm.c
> @@ -452,6 +452,9 @@ void rfcomm_packet(const struct l2cap_frame *frame)
>                 hdr.length = GET_LEN16(hdr.length);
>         }
>
> +       if (l2cap_frame->size == 0)
> +               goto fail;
> +

if (!l2cap_frame->size)

>         l2cap_frame_pull(&tmp_frame, l2cap_frame, l2cap_frame->size-1);

Or perhaps we can make l2cap_frame_pull check if it can really pull
the frame and return false if it doesn't just as get_*.

>         if (!l2cap_frame_get_u8(&tmp_frame, &hdr.fcs))
> --
> 2.31.1.607.g51e8a6a459-goog
>


-- 
Luiz Augusto von Dentz
