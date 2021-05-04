Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2017C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 17:43:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A2261166
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 17:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbhEDRoh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhEDRog (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 13:44:36 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FE9C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 10:43:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id l7so13245010ybf.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 10:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u9ky2l6v3+xWMtzmEy0YX54RrNOCdS+5KFj5NYNL8Eo=;
        b=m1C+KSzul/ClcnJgFlvLwlSFLKy8Ho7TBmNGnmkqAVbXlD0eEio7+gQ21uDVOQToxJ
         NXe3xvp/0S4WdvckgtlAIcmaiKflePfOhaVpaRt0Z+UjxEp7dRN3Ez7EOm1lYl+lMBYV
         NfXsvvbLgfmY5gdyoF90mKnepsWXvaDImSuKJaluitCfFrTML7R7BQQJv3IlzjTItQbb
         LwTqPa9pB11ToIwB3UUAg/iZFZwdCV5A0wqM5FVwi1Aj5yPtFYzP+zlwzPcKkhkNwKaG
         qIUaHT9x3N/sPzTZ44CTmv1SdecfY7vAUlZ1FG7c7vyFMtk0/LGv3n71yZS4lPSnlr3s
         K69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u9ky2l6v3+xWMtzmEy0YX54RrNOCdS+5KFj5NYNL8Eo=;
        b=bLIwTA6T3bl+UeeH/dCspf/olw19MOcep9iUkjIpdX+sYOkqGfWOyJEqQRhOd2jc1h
         Z/sHuHe/wDVQrl+jH4hftA9oUl6KfNbn7guTiC5Xp3703CriLS0HUG4eOZOapwX2V6zu
         IQmeXdppnrHER9klvLH0/kYnC/9iuTiNnVH3dUwnIy/+Wt0M2ST9QqOaQGMTGc5/Tcpy
         3c7ZdC1Iod4saC3amWoT+k5vadXxnE8zFcvd/s6yKWp5d+hDYS7EaboSfMYLALIe0XQg
         0A548SiPSo1jbQ90WH1L0cc08cCiSj4D/nEWjNWhLLPQrUovEeUeyV+ELDQ8+Hy+c+5W
         VvTA==
X-Gm-Message-State: AOAM533ksUZFL+Vs8772Lmquyvq7cUuF75jd1LasiiFp/jgzITNW/o72
        M0cGeMpD9HyE/UmJeXRhdPY3y+WVCa408Vsj5eM=
X-Google-Smtp-Source: ABdhPJxwh4/t05+Xjs4s18iUlLfX0RCYa0rZRtHIkAgVTKpq7jM7rLQ8LHHJbTAX8qxE0eULDlAu9UjLfqVy0CbH4xU=
X-Received: by 2002:a25:ac94:: with SMTP id x20mr694975ybi.432.1620150221130;
 Tue, 04 May 2021 10:43:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210504111454.29697-1-sathish.narasimman@intel.com>
In-Reply-To: <20210504111454.29697-1-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 May 2021 10:43:30 -0700
Message-ID: <CABBYNZJX+YrpFyDotc5uZUQLc5P6LiR_F-7AmOa3bPq1m97L=w@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] btmgmt: Fix enable adding irk when turining
 privacy on
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, May 4, 2021 at 4:09 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> Unable to add the IRK in btmgmt when need to be updated. The option is
> enabled now.
>
> Signed-off-by: Sathish Narasimman <sathish.narasimman@intel.com>
> ---
>  tools/btmgmt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/btmgmt.c b/tools/btmgmt.c
> index 02fec1dca184..bf3b460d0f04 100644
> --- a/tools/btmgmt.c
> +++ b/tools/btmgmt.c
> @@ -5277,7 +5277,7 @@ static const struct bt_shell_menu main_menu = {
>         cmd_advertising,                "Toggle LE advertising",        },
>         { "bredr",              "<on/off>",
>                 cmd_bredr,              "Toggle BR/EDR support",        },
> -       { "privacy",            "<on/off>",
> +       { "privacy",            "<on/off> [irk]",
>                 cmd_privacy,            "Toggle privacy support"        },

I wonder why you didn't incorporate in the first parameter though
given that things like privacy off [irk] makes no send, or perhaps
have a dedicated command for setting the irk so it would persist
between privacy on/off.

>         { "class",              "<major> <minor>",
>                 cmd_class,              "Set device major/minor class"  },
> --
> 2.17.1
>


-- 
Luiz Augusto von Dentz
