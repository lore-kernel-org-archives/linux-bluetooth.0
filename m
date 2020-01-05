Return-Path: <SRS0=fbEC=22=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9266C33C8C
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jan 2020 14:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7892077B
	for <linux-bluetooth@archiver.kernel.org>; Sun,  5 Jan 2020 14:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stV7/J0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgAEOSz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jan 2020 09:18:55 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:38418 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726192AbgAEOSz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jan 2020 09:18:55 -0500
Received: by mail-ua1-f68.google.com with SMTP id c7so13265332uaf.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jan 2020 06:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=90l/1B5Pj4QdVF9Vy1kJY3GLcEHfMZU5OspqrX3R0uI=;
        b=stV7/J0mO2sCDhlkb1xhmKIrJPA81jkMnjVYMCzITTKc2Ks4mzWB3ZIbzpnmtpcNH/
         GPswxc/5HYVfsy87yufNhi2o+cwsfspXQqw2wgOdufK8qubvS/TibpjSgDQpsyAixFoO
         SqyunyUxo+Cqq4fDdnP3wOLp7p7fG9diSAuErhN0Ll7d20la+nMrhxrK1gLxd9ir1628
         1occhJEB9TDDcowK6fymCmqFSq7sqtwjjKjy05oOXLWmOoBKpxZBex3kHpJOa/BVBQIj
         Nipv/Q6hPJictzT8ZF/veES6XuL5sfWsPvGgWnVZkvJCjOmGL42wdKPYG5++0AoABj3q
         7acg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=90l/1B5Pj4QdVF9Vy1kJY3GLcEHfMZU5OspqrX3R0uI=;
        b=RjLQ5V4cgok4p+C7L5XQhW/Fvlw2uYMka7Q0KvtPQYpCcyW8q5GIKdvoByUhjKPWOT
         mpl6WGpX+tVAcwDpm7WuruvRTOLIawSqsw+xUEzIaD/GQS3EoT6uzb18Vk1fOkF4K6fx
         kS+NUUfXON0qUCXZOY4Q1uhj1uGw+qCkG9kedqknq5DUeTGYAkOam0QDHnX53kNdIV4a
         gl1W26AhCkwlr6vc3zKBv2d6GGGU1TshGWvE6/EFGCrX+fX3ScbGCiDrRWfTmDzWtML1
         XYT4Y4bpJJrTEHWgOZHRlkKGlMBo2j4D+ijIUoIjVVTRELMS6noe4tSPwHyuYMaRk4yv
         S6ZQ==
X-Gm-Message-State: APjAAAXmRCvg4NNS9QoiLjDeRiCRs8g5ixt5HvUh46h2bS3hQvXHDh92
        ttAyCUiAXzIuMIhvSTqYVroBLPgBhGXAFdEfPLU=
X-Google-Smtp-Source: APXvYqzOEstF/irDj7UXj+ADhXQAxN7/v6F1MSj+91VKv4sq23y1aN6q66A84Y2YDO4z5zd1mvfANlKP+vVvlzsF7HE=
X-Received: by 2002:ab0:69c9:: with SMTP id u9mr35293147uaq.80.1578233934581;
 Sun, 05 Jan 2020 06:18:54 -0800 (PST)
MIME-Version: 1.0
References: <CGME20191206041341epcas5p4eb1504144abc74f3f25352e63eccf0bd@epcas5p4.samsung.com>
 <1575605616-787-1-git-send-email-biradar.a@samsung.com>
In-Reply-To: <1575605616-787-1-git-send-email-biradar.a@samsung.com>
From:   anurag biradar <anuragbiradar@gmail.com>
Date:   Sun, 5 Jan 2020 19:48:42 +0530
Message-ID: <CAP1EGUKw5E6xBTcYSpi3kMZEWBkKWyPpjL4qNhPi4EmMp4zDHw@mail.gmail.com>
Subject: Re: [PATCH 1/1] meshctl: Fix meshctl crash
To:     Anurag Biradar <biradar.a@samsung.com>
Cc:     linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, Dec 6, 2019 at 9:44 AM Anurag Biradar <biradar.a@samsung.com> wrote:
>
> list entry was not updated properly during flushing of packets
>
> <call stack>
> flush_pkt_list (list=0x638b40 <net+64>) at tools/mesh-gatt/net.c:1199
> net_session_close (data_in=<optimized out>) at tools/mesh-gatt/net.c:1979
> disconnect_device (cb=cb@entry=0x0, user_data=user_data@entry=0x0)
>   at tools/meshctl.c:791
> cmd_start_prov (argc=<optimized out>, argv=0x6a9fb0)
>   at tools/meshctl.c:1789
> ---
>  tools/mesh-gatt/net.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/mesh-gatt/net.c b/tools/mesh-gatt/net.c
> index e8171c6..d74e1f5 100644
> --- a/tools/mesh-gatt/net.c
> +++ b/tools/mesh-gatt/net.c
> @@ -1197,6 +1197,7 @@ static void flush_pkt_list(GList **list)
>                 pkt = l->data;
>                 *list = g_list_remove(*list, pkt);
>                 g_free(pkt);
> +               l = g_list_first(*list);
>         }
>  }
>
> --
> 2.7.4
>

Gentle Ping.

Thanks
Anurag
