Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C94DC433E1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54AEB208B8
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jY12Z7/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgE0WrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 18:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgE0WrK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 18:47:10 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D14C05BD1E
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 15:47:08 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id m67so12881886oif.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2020 15:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rILXpdjeVnudyMp2rje2mFX4vwduI4W4avBjyCDktm8=;
        b=jY12Z7/ur70KGr+3RbZu/qNTjQprU75Z7AhhTTRrr00YjgtQbJDzytWCBOMcZ7ydUa
         z0QhbwSu17KyXIvn/5yMOT5C4Dbs4sbDe/rg8C7mc7q0VNxyT0dF4kZVv6GJ01aBwRni
         D98sa7WouF+jZHLaXKgYdC+GOj5JTsrtdZfJR2ECfBRbBEzQvuiuT25eFrYcYc2mBPyi
         mMW0iSEGvRI47P/Ug1O9vJxsfbIDBCGH9qaST5nWnzcyajzSIOXALnXq5jdqvIAq1GcY
         YzEFPyNfQNdd5rQjtqgiLQD11s/n6eGYm65Xc0R5hna3yU4byvnETVsa1M+Hj2N2tvjg
         xRKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rILXpdjeVnudyMp2rje2mFX4vwduI4W4avBjyCDktm8=;
        b=f8t8WW329Eonf6YzqnwCApEOgR6yAJKigR+LuePpkJ0NYstsu+Q1QGGcuqcuwRTzqp
         xLGoEwt5i28gLdXQ0Y8jR/UNQTQaW7ea10xGMwhae5pfE7oy5wMdN/xJb2Z/tUlKj12s
         0jO1Cq5E+FbPIjKwupuj2pir4DZnbAZXJt/RMABHgerReQA1twtTtxatiouGUX71+uuF
         moW2lT22Hf67E1dn8oWdiNCTqS7KX4HBaJO6v6HTRn0SbLsht5XReizf50Hr32+Ol6vu
         bl7t0RxbFxPoE/Ab3xiPpvMM8NE6ptHi3L1kRANWGP46IIKW55WEg1YyTRfu44Ttn4El
         pd4Q==
X-Gm-Message-State: AOAM5321GOrtJetXOYdzweQfED1Kl8eZKT0ttCoWjfkbMBBgdM2/Sfo4
        Te2wS+RujzAk1cvk9HFHgrfokOeS2jdWGgAiQdLnXA==
X-Google-Smtp-Source: ABdhPJzekfI6yd/hBRcDCah2MrLaJZeiN0GtO4L660Yey6eBHEh7Ez9dJvQ8uWZHXN4KA0PenNw4Jo/xkQcSgJ48eeo=
X-Received: by 2002:aca:550e:: with SMTP id j14mr329171oib.82.1590619627550;
 Wed, 27 May 2020 15:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200527224343.182610-1-luiz.dentz@gmail.com>
In-Reply-To: <20200527224343.182610-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 27 May 2020 15:46:56 -0700
Message-ID: <CABBYNZ+yYU=FOq8-xTVzv+jLufkOFgs_0UmJZnhW8XkvFCU3TA@mail.gmail.com>
Subject: Re: [PATCH BlueZ] avrcp: Fix always requesting player settings for
 category 1
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Rinaldo Bergamini <rbergami@redhat.com>,
        Andrey Semashev <andrey.semashev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Wed, May 27, 2020 at 3:43 PM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Player Application settings is not mandatory for category 1 so instead
> of always listing the settings the code now checks if
> AVRCP_FEATURE_PLAYER_SETTINGS is enabled.
> ---
>  profiles/audio/avrcp.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index 773ccdb60..75811bf98 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3814,7 +3814,8 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
>         if (!session->controller || !session->controller->player)
>                 return FALSE;
>
> -       if (!(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
> +       if ((session->controller->features & AVRCP_FEATURE_PLAYER_SETTINGS) &&
> +                       !(events & (1 << AVRCP_EVENT_SETTINGS_CHANGED)))
>                 avrcp_list_player_attributes(session);
>
>         if (!(events & (1 << AVRCP_EVENT_STATUS_CHANGED)))
> --
> 2.25.3

Please let me know if you are able to test the above patch, it should
fix the problem with Senheisers headsets if the are not setting the
Player Settings bits this would prevent the command to be send so it
doesn't crash.

-- 
Luiz Augusto von Dentz
