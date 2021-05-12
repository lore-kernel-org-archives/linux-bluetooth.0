Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E509C43618
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 17:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 84D4D61413
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 May 2021 17:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241221AbhELR44 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 May 2021 13:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345973AbhELRMg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 May 2021 13:12:36 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276C1C061347
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 10:04:13 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id v4so8909899qtp.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 May 2021 10:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaishome.de; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLi1mcmerH+rqfkJPQwkDVKMnOt9Ah8OQvO3USWjQEY=;
        b=bxVsfcaIReSLEU7C0MlvMrpMUN3lsMcxPHZ4Y1tW64aZFFDXsZFchQniUUWNorTwgx
         CDcsJwx/la2s5+Nd6B8khChsWyR7YiVWkF4b+NpcCsRUjt5XNHiHdCuVjT+8wwmMkYxK
         JGKFSxLuqScOGIicifpEGqwbuSlxhhbrDG3Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLi1mcmerH+rqfkJPQwkDVKMnOt9Ah8OQvO3USWjQEY=;
        b=WrXSwH3MvE1VHQXT5Bio+vyIde80obczMAd7plMlzqzeHmxxIvU9w9XlS7u4N/Ibe/
         UIqe/kjOAvV4fJh/y+sYgQZwXhidkV7YneIl4zyknh1O4xIqTvCHMsPYOGDVpuVnakaw
         L7aaGEuMf/dAsgZx9i1JpnVXbU4/Xv4vI/xxYxmvuyW1w+jYgZHk8BMJI6j0PVDtg3pF
         gEUgsywvMl2wA9JmZ5sa25bSbV3MkPeRNcNEhMOGnxGyBZCyBAnC8xv6pKCpvp5w4hht
         91zhx5ykB7KGGG1hLKljJg2Ck0MT7JM5yyeQ73Z/fLnF/jHywEScVGSruVaqhSYJdD5t
         Gb7g==
X-Gm-Message-State: AOAM530+4dhIxhDCs6EV84w5CuGM8BqY2wmR7JUpFXFRrjE3HXMDapd+
        zbq1DoAx2Ht14nMDpa7Wjfe7TQdgaTqkMQ+PJNKw8Q==
X-Google-Smtp-Source: ABdhPJw9nb/MeAp+Jm7n0y5TQPS2lxmyTSRTXUosZP4Su8i9T4smqd8Y6EjnoA5P5VMtMD+48iIVXpmE48uhAs6rSeM=
X-Received: by 2002:ac8:7355:: with SMTP id q21mr18042001qtp.383.1620839052362;
 Wed, 12 May 2021 10:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210512133407.52330-1-szymon.janc@codecoup.pl>
In-Reply-To: <20210512133407.52330-1-szymon.janc@codecoup.pl>
From:   Kai Krakow <kai@kaishome.de>
Date:   Wed, 12 May 2021 19:04:01 +0200
Message-ID: <CAC2ZOYvax0WGO7wMzbPXQMGb2NDouAF6XRgd5TH+h-f6uWvhtg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Remove spurious error message
To:     Szymon Janc <szymon.janc@codecoup.pl>
Cc:     linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Szymon!

Am Mi., 12. Mai 2021 um 15:34 Uhr schrieb Szymon Janc <szymon.janc@codecoup.pl>:
>
> Even with rate limited reporting this is very spammy and since
> it is remote device that is providing bogus data there is no
> need to report this as error.
>
[...]
> [72464.546319] Bluetooth: hci0: advertising data len corrected
> [72464.857318] Bluetooth: hci0: advertising data len corrected
> [72465.163332] Bluetooth: hci0: advertising data len corrected
> [72465.278331] Bluetooth: hci0: advertising data len corrected
> [72465.432323] Bluetooth: hci0: advertising data len corrected
> [72465.891334] Bluetooth: hci0: advertising data len corrected
> [72466.045334] Bluetooth: hci0: advertising data len corrected
> [72466.197321] Bluetooth: hci0: advertising data len corrected
> [72466.340318] Bluetooth: hci0: advertising data len corrected
> [72466.498335] Bluetooth: hci0: advertising data len corrected
> [72469.803299] bt_err_ratelimited: 10 callbacks suppressed
>
> Signed-off-by: Szymon Janc <szymon.janc@codecoup.pl>
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=203753
> Cc: stable@vger.kernel.org
> ---
>  net/bluetooth/hci_event.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 5e99968939ce..abdc44dc0b2f 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -5476,8 +5476,6 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
>
>         /* Adjust for actual length */
>         if (len != real_len) {
> -               bt_dev_err_ratelimited(hdev, "advertising data len corrected %u -> %u",
> -                                      len, real_len);
>                 len = real_len;
>         }

This renders the "if" quite useless since it now always ensures len =
real_len and nothing else. At this point, the "if" can be removed, and
len can be set unconditionally. Depending on the further context of
the patch, destinction between real_len and len may not be needed at
all and real_len could be renamed to len, ditching the unused original
which is potentially bogus data anyways according to your commit
description.

Regards,
Kai
