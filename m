Return-Path: <SRS0=UWae=OV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2055EC65BAF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 16:32:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4F2420849
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Dec 2018 16:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0Zm9NYv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F2420849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbeLLQcL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Dec 2018 11:32:11 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:39571 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbeLLQcL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Dec 2018 11:32:11 -0500
Received: by mail-ot1-f65.google.com with SMTP id n8so18210405otl.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Dec 2018 08:32:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=fkMc76UcXqdlwD9naZwiEBpm1OdJS26AN3+Hz8KIbng=;
        b=s0Zm9NYvj1B9M3GyEczIWuAXaM+CJSi9LKgOE0VSjM0IFvk4hP6vgdMi1L3IluI80G
         oPQpxBb0GcFFJPxW3kc7zDpjCQVRCXxS/uZGc/Rjzzs085Yod7JrapcwPA+nWL7cYe/A
         ZyW0kXkB7tISlXPxL4K+6aM7vNoiEzFftJK2oovhA543yb5rJMb4PObvpu7TvyVSLxKm
         qJaAZH595+GqDcTnyY5jhQTOmNQ5cCldIoHAxPBK85fwsE0oy32VOSISKkhl+tIfJxVZ
         mORyz3luu0OZR+Uw2Rx+1AA6Utmzh39yBKHp7iTPzvv4xMrSmJI5tPwyA5z14nMkAG/F
         OUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=fkMc76UcXqdlwD9naZwiEBpm1OdJS26AN3+Hz8KIbng=;
        b=RsnSniEuDqHvTqYxi61cslMfdTecAynGjjrF8NmuBAjtay4gO+aNvjd7wg7iqxZ6hK
         Jo/Lld79yEy9lpDsHpOomTUaUTksiZIgxdxfN1o/CMxjaUcEhXrN7+Ey/XcRM6b4fBRb
         tRQRQzg4v3HujUzTljIMjMJ/AkT0dsfeiw0CVYq9FhWGRLAWSrdpJLyuN82COI4UB0aA
         WaTGeLc/gPBp/NPlQMcaJg16G4NrCAFhE48wVQHvjuxB7+UQM4o5r8HHU3MDrKGQczJz
         tYgbuZUXaXozs9OLwlKzIwimHh3yX+jGcDgg8xZk6Xl3pmu+4HRxUMgyg546SNGPZ03/
         xoRw==
X-Gm-Message-State: AA+aEWaBNj3w0353gGzPFhWtDO/AHI3lZwqGoMniHCTTpUXLWCx7xWam
        fiDpJ5FCMpkzuwvp/rHnY+n9UtVwbGSomqD3ARYb813z
X-Google-Smtp-Source: AFSGD/Ueq/Yvfl81IU8MNFzUw9Ra1tvn1qHdI2sBFV+ZDpWCBWql75GIjBChh1MJZ+P7lRU14jLkfgTyfkFdkWavwVI=
X-Received: by 2002:a05:6830:1004:: with SMTP id a4mr14163077otp.254.1544632330221;
 Wed, 12 Dec 2018 08:32:10 -0800 (PST)
MIME-Version: 1.0
References: <20181206000033.14963-1-luiz.dentz@gmail.com>
In-Reply-To: <20181206000033.14963-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 12 Dec 2018 18:31:56 +0200
Message-ID: <CABBYNZJ7o7TmZO+s8HQfvjK_YBB+hNXNPGuSqWxLU3GFK4DP8w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/2] avrcp: Fix error creating media items
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,
On Thu, Dec 6, 2018 at 2:00 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> Don't use item name in the object since it would need to be properly
> escaped if the remote stack uses UID 0, instead just create the path
> using the object pointer even  though it is invalid to have 0 as UID:
>
> AVRCP 1.6.1, page 84:
>
>   'The value of UID=0x0 is a special value used only to request
>    the metadata for the currently playing media using the
>    GetElementAttributes command and shall not be used for any item
>    in a folder.'
> ---
>  profiles/audio/player.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/profiles/audio/player.c b/profiles/audio/player.c
> index 048f98f96..ac23f720b 100644
> --- a/profiles/audio/player.c
> +++ b/profiles/audio/player.c
> @@ -1800,11 +1800,11 @@ static struct media_item *media_folder_create_item(struct media_player *mp,
>         item->player = mp;
>         item->uid = uid;
>
> -       if (uid > 0)
> +       if (!uid && name[0] == '/')
> +               item->path = g_strdup_printf("%s%s", mp->path, name);
> +       else
>                 item->path = g_strdup_printf("%s/item%" PRIu64 "",
>                                                 folder->item->path, uid);
> -       else
> -               item->path = g_strdup_printf("%s%s", mp->path, name);
>
>         item->name = g_strdup(name);
>         item->type = type;
> --
> 2.17.2

Applied.


-- 
Luiz Augusto von Dentz
