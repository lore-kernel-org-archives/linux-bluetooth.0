Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE0AC433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6360F23358
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Jan 2021 00:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbhAVAkL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Jan 2021 19:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbhAVAkG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Jan 2021 19:40:06 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5064C06174A
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:39:25 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id i20so3547514otl.7
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Jan 2021 16:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrCWs6p7sfFnR8Fs9H6Rn+VoONvEvwZo5K4ULiJZakw=;
        b=igXFUyv6sFkTno7T2ojXMV/Idt9vqNKZU0UEGvVM/9dkmUcaBGykiRYQoC611PEsju
         YIU+ItDcUQ7zdhVr8qaaWDZpmxDKVH+0B/+EhVgiTmug2GXtvYtPJWys1Bzubs4gycjl
         4BrrnS5JSnsImdzLsgek97TiDf7akNRMUGG3j0sNchQdnm0/KtQZ5XvE20UAReb4efQZ
         1M29uAka1EQsDZNorrvJDo4YSHB72bGPnBYb87e9TwznKK9wEqJGgKRFPoVvTmE1cauN
         nayy18/eBv6eu7a1KSswpGqLmzaGek9YQZEAsFr8gddfC4juv22OCOnEZAtMkbrgqjIi
         NHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrCWs6p7sfFnR8Fs9H6Rn+VoONvEvwZo5K4ULiJZakw=;
        b=Id6UZyj3VK8Ekpv/SG5XoSUtKf+lQ5wqmprrWXtd+9Yvp3TgmbmBjLQl1p4/SRjMDd
         muOmrKyDjYGOgQL2ClE+hSDGTpKH5xCG/aYpaOQkKQGp68bjRQdVUEaMiqMNHW/arwX+
         aEs45E/FZkjj8j26Z/o8fSO6qGKHjwB+YPuImeW7BfSXtkqpAT2q7CikzeQBCXl74eoh
         5F3/9KUk+QkE8iIuKeW2QcspIWBELFxnbJjEzc8lXnKuGQcTS7LMx0FBqjklXqPl1E14
         Us4JyBEPG/Bau62lnP3H0fBYKYla6WvEsqw0mPn0WegEiOiOtllYh6a44ahJbrkos6+4
         ObEw==
X-Gm-Message-State: AOAM532z9xC4SBiuTk8V8ffi/rCePJtp1YFKiwQJxvSNDt9jnoIJ5dd2
        sCY4dirikOtCaJ88Zx6OEP7xikTIsao78ON6h1U3b6FPZ38=
X-Google-Smtp-Source: ABdhPJyJV3vNWTGa0Z+jd3eCYpgwJDVqWnJSdDz1ij3ZFlvRA9QM1BG4okuieSDqo4o0/FgIJMTrHiXyn/OK/0qaqI8=
X-Received: by 2002:a9d:6f17:: with SMTP id n23mr1370642otq.371.1611275965033;
 Thu, 21 Jan 2021 16:39:25 -0800 (PST)
MIME-Version: 1.0
References: <20210122001326.14263-1-sonnysasaka@chromium.org>
In-Reply-To: <20210122001326.14263-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 21 Jan 2021 16:39:14 -0800
Message-ID: <CABBYNZ+OPd_QnHnuhtf0eCx_Vvqy7BSanwjG4ifYVGGEUduHdg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2 1/2] input/hog: Fix double registering report
 value callbacks
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Thu, Jan 21, 2021 at 4:19 PM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> In commit 23b69ab3e484 ("input/hog: Cache the HID report map"), we
> optimized HOG reconnection by registering report value callbacks early,
> but there was a bug where we also re-register the same report value
> callbacks after at CCC write callback. We should handle this case by
> avoiding the second callback register if we know we have done it
> earlier.
>
> ---
>  profiles/input/hog-lib.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 1f132aa4c..089f42826 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -80,6 +80,7 @@ struct bt_hog {
>         struct bt_uhid          *uhid;
>         int                     uhid_fd;
>         bool                    uhid_created;
> +       bool                    report_value_cb_registered;
>         gboolean                has_report_id;
>         uint16_t                bcdhid;
>         uint8_t                 bcountrycode;
> @@ -336,6 +337,13 @@ static void report_ccc_written_cb(guint8 status, const guint8 *pdu,
>                 return;
>         }
>
> +       /* If we already had the report map cache, we must have registered UHID
> +        * and the report value callbacks. In that case, don't re-register the
> +        * report value callbacks here.
> +        */
> +       if (hog->report_value_cb_registered)
> +               return;
> +

Didn't I comment on this problem before? I do recall suggesting using
notifyid instead of adding yet another flag.

>         report->notifyid = g_attrib_register(hog->attrib,
>                                         ATT_OP_HANDLE_NOTIFY,
>                                         report->value_handle,
> @@ -1703,6 +1711,8 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
>                                         report_value_cb, r, NULL);
>         }
>
> +       hog->report_value_cb_registered = true;
> +
>         return true;
>  }
>
> @@ -1753,6 +1763,8 @@ void bt_hog_detach(struct bt_hog *hog)
>                 }
>         }
>
> +       hog->report_value_cb_registered = false;
> +
>         if (hog->scpp)
>                 bt_scpp_detach(hog->scpp);
>
> --
> 2.29.2
>


-- 
Luiz Augusto von Dentz
