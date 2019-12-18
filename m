Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF43DC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 00:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D978206D3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 00:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UlWsLQpI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfLRATT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Dec 2019 19:19:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40985 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfLRATS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Dec 2019 19:19:18 -0500
Received: by mail-ot1-f66.google.com with SMTP id r27so131256otc.8
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2019 16:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Gs5p6RAXHah0tAF7aD/AwmmJZDWMrzt+sjor2Mwx1o=;
        b=UlWsLQpIEapTTyTsVZMeW6k+oJCx4EMu5c0tPxZ4mN/5LTrb9NGNHRkni2Qmiu/rzH
         z9XxAtwtLL6GATn8Z2xw304V+1KUSc+9nQp9UjxAUSBiCVLzbNgNFjP5AlyhW1T4RYAE
         JVximIJHQgemHJGHb8hG9YhS/QJ6JVlkALOGBYz91YxNe2/JQQEXi02BfeE9S1Wlflmb
         JGR+HAoNwV283ztFrrQXWwOH9SxwxvTvQ839pE4hvuKWuViOjTsnCKvCGlHDILuENKrX
         lTJkaAUtlejPUcj6YJ23RDnL9b5zjXosVNmZ/aN0UvuntNhDrCkvXU3QPuy8D1Od483I
         RxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Gs5p6RAXHah0tAF7aD/AwmmJZDWMrzt+sjor2Mwx1o=;
        b=QrTW/KuK8GpFvnULAvKkUhRMvjmA2893Lgrb3eeTEA3iWwepr1xfX2yUuzNGckMwuM
         cXRSvBsEG9cPJF0EiC4BA//B4m5ecZM1MxKzqQ4HauH+DtoVwEbvtcpvH4yt+xp3XHif
         5djpGvryQBtK0OeQmWtMcv7pW93yJPpXXH/mzfBDm4NUEw+Vf+6bbLMVaQSEHMbzT1uY
         4zXEiEd37qILFbog8kQGbtSUiIejTDy579MWdNN0DLebZb0DE9Gx7IsQ/j1RcQn3Ook9
         d1tvGYkwZir+v+vGU3/Fk/Qk3/vl3Dqf2qjdlWfiZLVMFQBUNgYvF7NOMg/YqfPLhttk
         ko2w==
X-Gm-Message-State: APjAAAVGkcfveyShapPPwygDTKZAHymveoINrDaJxnAMMLH9uMewhX+x
        xOYuboFk7OGSV+8Zs23bFNHLDjV6qWq1lMirBL5qwdu2
X-Google-Smtp-Source: APXvYqwM8NynH5Hc9OfXndxxAHsYfTCwnpLWD+wnVUn6+NaNEuwYiCzzU9XZ9xEdchljMSNjkvt3r7q+vI3L+aHE9Cs=
X-Received: by 2002:a9d:eea:: with SMTP id 97mr225671otj.177.1576628357820;
 Tue, 17 Dec 2019 16:19:17 -0800 (PST)
MIME-Version: 1.0
References: <CAMH2TCooGyxiZbhersOCFMHLpjSAqKFq2_XswXx3nt200L-qBQ@mail.gmail.com>
In-Reply-To: <CAMH2TCooGyxiZbhersOCFMHLpjSAqKFq2_XswXx3nt200L-qBQ@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 17 Dec 2019 16:19:06 -0800
Message-ID: <CABBYNZLW7qe8ie-FLYaka7wKTeKAmBQYf0DG0ZZqbOu2eEOxPA@mail.gmail.com>
Subject: Re: L2CAP mtu preference set by user space clarification
To:     chethan tn <chethantn@gmail.com>
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Chethan T N <chethan.tumkur.narayan@intel.com>,
        Sathish N <nsathish41@gmail.com>,
        Sathish Narasimman <sathish.narasimman@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Chethan,

On Mon, Dec 16, 2019 at 10:40 PM chethan tn <chethantn@gmail.com> wrote:
>
> Hi,
>
> I would like to understand why the Source device L2CAP mtu is always
> set to the remote device mtu during L2CAP connection?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3370
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474
>
>
>
> I tried to set the specific MTU for specific profile connection( For
> Ex: A2DP connection - PSM  25) patch mentioned below, but the same is
> not reflected because of the below code.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git/tree/net/bluetooth/l2cap_core.c#n3474

The answer is pretty simple, we don't control the remote/output MTU,
so we cannot force the remote to use some arbitrary MTU if it doesn't
agree with.

> Here the patch to set the MTU from the use space bluez.
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 58e1534a4..7d8a718c0 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -1573,6 +1573,7 @@ static bool a2dp_server_listen(struct a2dp_server *server)
>                                 BT_IO_OPT_SOURCE_BDADDR,
>                                 btd_adapter_get_address(server->adapter),
>                                 BT_IO_OPT_PSM, AVDTP_PSM,
> +                               BT_IO_OPT_OMTU, AVDTP_MTU,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                 BT_IO_OPT_MASTER, true,
>                                 BT_IO_OPT_INVALID);
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 51ead684a..786702cec 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -2394,6 +2394,7 @@ static GIOChannel *l2cap_connect(struct avdtp *session)
>                                 BT_IO_OPT_DEST_BDADDR,
>                                 device_get_address(session->device),
>                                 BT_IO_OPT_PSM, AVDTP_PSM,
> +                               BT_IO_OPT_OMTU, AVDTP_MTU,
>                                 BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
>                                 BT_IO_OPT_INVALID);
>         if (!io) {
> diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
> index 621a6e3cf..372b2579d 100644
> --- a/profiles/audio/avdtp.h
> +++ b/profiles/audio/avdtp.h
>
>
>
> Can you please suggest what is the best way to set the L2CAP mtu as
> user defined.
>
>
> Thanks
>
> Chethan



-- 
Luiz Augusto von Dentz
