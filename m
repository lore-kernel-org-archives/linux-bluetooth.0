Return-Path: <SRS0=kIsL=7L=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EE6C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 20:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102F72075A
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 May 2020 20:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDvUAJ9s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727024AbgE2Uhl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 May 2020 16:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728071AbgE2Uhk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 May 2020 16:37:40 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E8AC08C5C9
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 13:30:08 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id g5so2456646otg.6
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2020 13:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=aqx0dQTYeoyJsNH7bitA3y/LToW3AUaUjDLuDHey93w=;
        b=DDvUAJ9snxdauPTDc8un/CwkOEw3AIv6zrfwveCTfOa0cz15D1Qow9/SyJyazc6mfK
         IyclCbOZhQSO6FHiZdLuAcM+zpPUlZz6CTn73vFKMWyjVxJNax/893mSGi+OBi/At4PK
         k7PJiabcxPL0ZLD4wdhfdRWoP1GoKywSOCH1p3V+jZLy+I4sls4oHZ7gcPgSNySt+MrN
         PtTgvdJC1hpx5hsJ0BsHYWuPAJGNpjHjgmQs0lU1uLfG3ZkNAjK34EfhgrJpDpxdUlg8
         S2yzAu3ZeBwOn1kFmqpAT5DK1DSiERKQcc4JMG2CRS6BlBBv8q3w7GSBsJCaZxegd5Tb
         S/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=aqx0dQTYeoyJsNH7bitA3y/LToW3AUaUjDLuDHey93w=;
        b=IPIH1UbEKwPN+hbHxbwygsVjc7kAzPLrR8GLGz/hxJpKu50v/yekaJPOrmTBXfHusv
         OcYT5gV3BXdSwuYVon2hQBB5tDQP7CX90d2xV5LDhb+mDVBc4Z1UHuOPdi3wkyJgrD/1
         C+RgL7Uf+zzXPKxo88Dvpxg8lcuHmZ+3ip5viM0Mq74yVBNsIokmfF1jTVcGkptAck77
         J9D8x5p1qP8uSZBhMAW8USMhrSeaAzIrCBjuVzlufnwFB0mi4WOH65vjgJu2dQhA2EAP
         zRnR1DdWErWPYSTxGXUJ4w5+tkHeTXhHizId22RR56uRFIJZtMo3c4DwFcofEmx9vzj+
         vLuA==
X-Gm-Message-State: AOAM530v4T9qV7r0Wufbq20SzRVmMtwZgR7EqRElr7d/lIlqO9mK187q
        5V7Gghu7safhW7nRHhjL9n7JAYbctOLgIYjkpRQHVA==
X-Google-Smtp-Source: ABdhPJz8W0ehAcbY+saMSnMbEHykXvb+ZAyC015qI6VqmkfVlLdhSkWFv9sZnWAeM6GxECeqHkF+fxrsKJPC/6SPVzs=
X-Received: by 2002:a9d:2049:: with SMTP id n67mr6891621ota.177.1590784207361;
 Fri, 29 May 2020 13:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200528215300.225894-1-luiz.dentz@gmail.com>
In-Reply-To: <20200528215300.225894-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 29 May 2020 13:29:56 -0700
Message-ID: <CABBYNZ+RQooYxKUYLd6TPL-o7vN6Xzeq0RN3E-ii_wbTfPyQtg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] avrcp: Fix always requesting player settings for
 category 1
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, May 28, 2020 at 2:53 PM Luiz Augusto von Dentz
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
>

Applied.

-- 
Luiz Augusto von Dentz
