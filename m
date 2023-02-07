Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BB5C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Feb 2023 01:12:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjBGBMX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Feb 2023 20:12:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjBGBMW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Feb 2023 20:12:22 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D901287B
        for <linux-bluetooth@vger.kernel.org>; Mon,  6 Feb 2023 17:12:15 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id y19so13957772ljq.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 Feb 2023 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XVl4dxs1qgZyrHoPZPbZlUO/4Uup0PsXEgiDlFzM1zA=;
        b=inw0wWR2MmrlJvvxPes78/5uMhSQrIDBYJX6KbeXVYN2HX5LqbrwBsLcMBFGKMNo9y
         7kYWQt3v3vIZm9k0cN/iqjMYt344oRL7L0/qH+uY/qunGzNKVa9y9QcBj4yFcLFGamPC
         Z15cmOwnj+0hk1uqUgJMgcMlYm1vZY2MfKPLUUSl1FNZ7ZgEnfcRYcZmPSuZZIUjGXMe
         ELb1hKX1XhR7RmfTh1CPbwkLYNCUeEtmG8cU/ij9zzFlJMHqo2UU+8T+3PrTniH/dLhx
         x4frack1WXG2AY24Zc0/KBNkso62rjMPoftG4PdcpCqjgVk1ER9JJPKpGIQhBd1QvZlS
         wERQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XVl4dxs1qgZyrHoPZPbZlUO/4Uup0PsXEgiDlFzM1zA=;
        b=RBk4cGnOdOGrKeebv1E2D73j6RicsAmph2Z3KH/TFB6Jf2XAszs7ECLODYWmFpx9Lf
         fuFBf28/Q0Fm0h+Y0UCutzOvtlpcfgewyd5+T/IuryudlZNvSKqophSu5+ka/HXN9Cdi
         ZvtoYqvOSSQKC1jtgIvkV8eK/AsR1hxKvMLCC0TGqGGRIjBzlHZ6AG9I1i/VKcZ/yvbQ
         FbqT0w4vJFeN1d4zrlbHjoBhXUlyeA5HtyyqwkDzzwM/dH4qyWxjQScHqOArdrneJmWf
         UKT7M3KOfvn99qclQx9tucGZUw1gZmLZty2O9XCenBu6vzNsMJXz/gLEHSuOd7qo7PdG
         y/Eg==
X-Gm-Message-State: AO0yUKVnz3uMSHmCn6tkk7ntaJxQ9xW0p7r6FY1r5CSxOuYdK+pt9WmQ
        oyFS4zdfTK+z9vPQ+Lm3Nqj2kowwmod70Pbv9qAC09YM
X-Google-Smtp-Source: AK7set/7bkNBK1l9Tj1w48YEnFZAtqkM36NOMvF/b31/o/YtNKtJHxcCn/MCkQ6P9CUT66Pa07enE3coq03jPbQNeAo=
X-Received: by 2002:a2e:8410:0:b0:290:5166:7c37 with SMTP id
 z16-20020a2e8410000000b0029051667c37mr209744ljg.191.1675732333920; Mon, 06
 Feb 2023 17:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20230127205205.20235-1-pav@iki.fi> <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
 <6752660792aa222640025a08ba9d95bcf9cf70b6.1675103676.git.pav@iki.fi>
In-Reply-To: <6752660792aa222640025a08ba9d95bcf9cf70b6.1675103676.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 6 Feb 2023 17:12:02 -0800
Message-ID: <CABBYNZJKZ_=xqODdgY0B=TDDP4mm63s_DwgTgoE0bEceaneFjQ@mail.gmail.com>
Subject: Re: [PATCH BlueZ 3/8] monitor: add names for MGMT setting bits for
 CIS feature support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, Jan 30, 2023 at 10:48 AM Pauli Virtanen <pav@iki.fi> wrote:

Let's have the btmon output in the description to make it easier to
visualize how this changes affect it.

> ---
>  monitor/packet.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/monitor/packet.c b/monitor/packet.c
> index 44f1941bd..d9e8abf41 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -12649,6 +12649,8 @@ static const struct bitfield_data mgmt_settings_table[] = {
>         { 15, "Static Address"          },
>         { 16, "PHY Configuration"       },
>         { 17, "Wideband Speech"         },
> +       { 18, "CIS Central"             },
> +       { 19, "CIS Peripheral"          },
>         { }
>  };
>
> --
> 2.39.1
>


-- 
Luiz Augusto von Dentz
