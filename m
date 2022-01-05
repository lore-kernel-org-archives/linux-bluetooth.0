Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606DBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Jan 2022 19:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243335AbiAETHd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Jan 2022 14:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243276AbiAETHc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Jan 2022 14:07:32 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A799EC061245
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Jan 2022 11:07:32 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d1so688738ybh.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Jan 2022 11:07:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BIMrLHTO+HuMEcxyTQBR/CbMZc/RqReG6W5nf+IpEFI=;
        b=k15/x8PpALajr3+PLvquaBcxkr0IWlvdU+aLi0Gridymi0+3i3m1+2xe4eH7ciLdFa
         ByTVX7VKUsoXVYtAyXabV1TN+8Fz40wHAy3l7FEZ5hv1Zifepb21sKeSJ6VU15FWzPcz
         l/waanztwkw/eDb+I6e1qQW0KjNRIqE/bHToDW6b6gCjUZmUBrhkwN8/BdgXqB+UFESj
         7O6ESNubkq5fwzUBiiEBkj3wS/WLDY4KNNYFZDK+xGDL9h+pNgzN3LqdUQm8pZyAyCMp
         R9jKZQhJkycCK3t+JCiR/jfKYDmWtjW4CNTfCHKHXf6XhDIZBV2HD9ErqS7uHpDlNSQv
         eSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BIMrLHTO+HuMEcxyTQBR/CbMZc/RqReG6W5nf+IpEFI=;
        b=fND+UjEPaYwzqXpDZpTwqQiPIN7E0+bdBpltgzNEUKMZObzOkQ7tCsxgA2BBdwXlTx
         BFYmvkWxlgAd3HUyVqZoTqVPuF+Cve40LTfMZd7+hSHDWq99Bb1Nb6SeuktfU1f6wQ9G
         s9pI49MwqN6n4Jg7SYLtAkkrQ9+I+trKa1wBErsWG4m7nCt5aUUET0F2U91HVirqreQB
         x4GdXLvs/N9aC6NphWBx5JkNwU2tso2/4okYUiWGNbMozzMkHRz5zcgDhTx/D4NKiscL
         SnO//uwCw0+NFHV7ma9S3pdwyssre3kQ+oVlCG9drwLHD+nMLU87aqQtW5O9dGtNzz12
         73rw==
X-Gm-Message-State: AOAM533F8sSUgZX7sAFYQbXYLp4NxekWb5JQuV2VQETrFCyZeY+N1de4
        inNbDir7IpCjrlW8qpUtQ4n0NLI114T/yJQRcrvFz3SxXqs=
X-Google-Smtp-Source: ABdhPJyQmrX9V6lFOd/ST9Uds0HU8CebK5z+mKWMteBQMvY/fqC7JTMgt9uBGrXag+OboMHvuSPuNO1FLPD3vTk/3aE=
X-Received: by 2002:a5b:14a:: with SMTP id c10mr68723698ybp.752.1641409650560;
 Wed, 05 Jan 2022 11:07:30 -0800 (PST)
MIME-Version: 1.0
References: <20211223175005.52976-1-nicolas.fella@gmx.de>
In-Reply-To: <20211223175005.52976-1-nicolas.fella@gmx.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 5 Jan 2022 11:07:19 -0800
Message-ID: <CABBYNZL4ftQ7PCMPywddoZvPcu_D9xkx21o=Bo=g9DtZ=vJStg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] Use audio-card-bluetooth icon
To:     Nicolas Fella <nicolas.fella@gmx.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Nicolas,

On Fri, Dec 24, 2021 at 5:06 PM Nicolas Fella <nicolas.fella@gmx.de> wrote:
>
> PulseAudio uses this icon for this kind of device
>
> Let's be consistent
>
> Users will gracefully fall back to audio-card if audio-card-bluetooth
> is not found
> ---
>  src/dbus-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/src/dbus-common.c b/src/dbus-common.c
> index 5e2c83d52..3611cb013 100644
> --- a/src/dbus-common.c
> +++ b/src/dbus-common.c
> @@ -80,7 +80,7 @@ const char *class_to_icon(uint32_t class)
>                 case 0x0d: /* Camcorder */
>                         return "camera-video";
>                 default:
> -                       return "audio-card";    /* Other audio device */
> +                       return "audio-card-bluetooth";  /* Other audio device */
>                 }
>                 break;
>         case 0x05:
> --
> 2.34.1

It doesn't seem to be part of
https://specifications.freedesktop.org/icon-naming-spec/latest/ar01s04.html,
does the icon themes really have such icon?


-- 
Luiz Augusto von Dentz
