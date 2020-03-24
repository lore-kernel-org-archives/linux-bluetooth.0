Return-Path: <SRS0=2tab=5J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B14AC2BAEE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 06:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2BF2074D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Mar 2020 06:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaQWbVZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727253AbgCXGFA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Mar 2020 02:05:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40949 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgCXGFA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Mar 2020 02:05:00 -0400
Received: by mail-ot1-f66.google.com with SMTP id e19so15981223otj.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Mar 2020 23:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vc2PCHKZB1JY/EQw3WjMqKCNYwRxM0w2FAoFej563Wc=;
        b=MaQWbVZjsAF18y4zTbp3+MQg2i9/sjJjOrLsnJ1rKEjiYcQtemr19xu48gmCXWcQoQ
         RvwJrOKyrEiuLi8Na40ixcmBE1Gxr+fArGZQOBcFztUE+KsRfR7r0k68Hk2LCukpu9QK
         us05jQZRztiIgitoDs0ULFVKS7dp1XwOFjRGMD0Y9otr8lQLbcrIPWuu3VBjPfMI1oMT
         9GFo3G9IUPW74DVGtXl76hvJarpTfFXq9An7f/cZ7N+FU/9iCXWDZCyBIYh/LzpPi8dk
         rv6H/vZBAEGwubEV6b4k9MAgYRHCxsa2tJWlQ+5qBqJe1phmBdHvAORjVH3qmqqD9pFF
         pubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vc2PCHKZB1JY/EQw3WjMqKCNYwRxM0w2FAoFej563Wc=;
        b=t2D64xX2yy43M6ZgJsZn5VlvNtL96UN8n/ckTv5BRo1u/kQkTvbnFrsCxxqhQhvIKK
         WZ63G9pYJEo8TbnChN5UoN0RxukcGy/eTV29GrMXM/ID7OMJbnXUk7nUZxiKpuImJzuc
         rp4ypqsPMqvYdziT20/qAKvAMwz1uBBAMr8pvVJdHlW2qaY1OTcZ6+XZVPtdSvLKaZLH
         CdkefH6c70O13H+zbXqXkn8QYVbYmW9NpulvlMD7+OqHXLPACZpaU4+eKpxrtTcxbNUM
         k8yXGsZPBuXGlvRXf+qAZyemT/e2HD8HT6HpjrhsV7IplhGGCVgBkDmL/RrQ85EqwEVv
         hm9w==
X-Gm-Message-State: ANhLgQ3l0TasvvSHGoWgn9/HKmIylGuOqwsKj7x8VBJJkEbzALHAdzrw
        Af/09kwg5ckUNd6atudgbBiwh+1dZtZZIT1oSfw=
X-Google-Smtp-Source: ADFU+vtfmQyqFY9INrcAdfiODz62vaMUDfGrA+a0hgZ7AN8i5esQs8uOFEQy9EfEmL2dIKq8s198WoazruyS09kv4rM=
X-Received: by 2002:a9d:67c6:: with SMTP id c6mr533834otn.11.1585029899539;
 Mon, 23 Mar 2020 23:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200324112129.Bluez.v2.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
In-Reply-To: <20200324112129.Bluez.v2.1.I6c78c0eb9826eb17c944c4903132ee75c1324136@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 23 Mar 2020 23:04:48 -0700
Message-ID: <CABBYNZL+trgHt2V_iKGSyZhUoOxht_Z2jdzD8jJwo1ki-exP0A@mail.gmail.com>
Subject: Re: [Bluez PATCH v2] avdtp: Fix crashes in avdtp_abort
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto Von Dentz <luiz.von.dentz@intel.com>,
        ChromeOS Bluetooth Upstreaming 
        <chromeos-bluetooth-upstreaming@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Mon, Mar 23, 2020 at 8:28 PM Howard Chung <howardchung@google.com> wrote:
>
> In avdtp_abort, if setup->stream is NULL, trying to access
> stream->lsep will crash.
> ---
>
> Changes in v2:
> - Remove variable 'sep'
>
>  profiles/audio/avdtp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index 0e075f9ff..aabc5ce51 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -3566,7 +3566,6 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>  {
>         struct seid_req req;
>         int ret;
> -       struct avdtp_local_sep *sep = stream->lsep;
>
>         if (!stream && session->discover) {
>                 /* Don't call cb since it being aborted */
> @@ -3581,7 +3580,7 @@ int avdtp_abort(struct avdtp *session, struct avdtp_stream *stream)
>         if (stream->lsep->state == AVDTP_STATE_ABORTING)
>                 return -EINVAL;
>
> -       avdtp_sep_set_state(session, sep, AVDTP_STATE_ABORTING);
> +       avdtp_sep_set_state(session, stream->lsep, AVDTP_STATE_ABORTING);
>
>         if (session->req && stream == session->req->stream)
>                 return cancel_request(session, ECANCELED);
> --
> 2.25.1.696.g5e7596f4ac-goog

Applied, thanks.

-- 
Luiz Augusto von Dentz
