Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63030C07E99
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 05:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DEFC61431
	for <linux-bluetooth@archiver.kernel.org>; Fri,  9 Jul 2021 05:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhGIFwS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 01:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbhGIFwQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 01:52:16 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDA1C061574
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jul 2021 22:49:33 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id o139so12811202ybg.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Jul 2021 22:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MWZt7ebvFt+trFuo3qAsE2ikuwPnQLoGe+6rmdQay4o=;
        b=OFq+zN4dpOQk9GpKlvepghQRz1EAtqyB5rjNmoM+QyHP3r+v+VSxdY7EoUy/TjdGo6
         5/BmIPhPDtz1Y8a8SRhg7vlEZI4E3bOSoLMZIuekmoNVMBJebndyAgSLajNlezU1atpr
         t8S9WK1rHKLki7vO5n6kJifL6LJVTzDPPcQPyex/8RILwmitZwcM0Us0bcYkwqegZ12o
         8sfzAoIEDMS+jDvfj+ybsltkcWtrnp68fSfUxqjdemf4h2Qz0D64siZJ25IoOKOBujh+
         DeOL5Nh8n6Cwh164DRySlaQ9zzIPQhL4CN4EVkw7J16DcUiwRbslqG7cnbJZzV3ywWq1
         tARw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MWZt7ebvFt+trFuo3qAsE2ikuwPnQLoGe+6rmdQay4o=;
        b=JDgmVKYgfnHbK+CC+YZZuC/IVK70EhVZEHHk83IB/+doHWkW/uHalCoPWw3mPjwiFa
         ZpSLDw8qUNfKHt6OS6QNUOm9WoLDW1X5GDVpfC0NVrIEB7laaFV524nAIdl2REbIEB0p
         szU7gZzNdclXhltwpPsZ9lstMxXu6+H5jqY3BCl+ihw+W4dj/qfzCxmldBZ3hSFfFTxd
         HSS4fp/kXvy/ax55VqNUetTl1VE4u9YkuDMqXb607GCrctsyumtXn8sjahK71cNQJs1i
         PTKEv2Tcd0mOP9kOs0X4tvoJBeFXvVSoyd4XYOnrF+mFlp4F4svwQ+I6OUUwyfjdBo1m
         L+6Q==
X-Gm-Message-State: AOAM530LuRPACVQNz1b0FRDaCjkmA5JpXyGeMq7k0KvQvAExKJfKgQPJ
        UNjAxMAMmWq7M8W20WUmZALCK+ViMbG5aez9k/o=
X-Google-Smtp-Source: ABdhPJwODgtPDSMfDzC/T7rkSBfF9ykRUfVV7OCacGLT/r+R3GL0N3vDMIXzC3ciR47ppcmwayhdkDJ/k8qgzusEmjE=
X-Received: by 2002:a25:b741:: with SMTP id e1mr45767424ybm.347.1625809772302;
 Thu, 08 Jul 2021 22:49:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210708062314.245754-1-howardchung@google.com> <20210708142059.Bluez.v1.6.I123189fa93aad2c2d1be645d38dbc494aa15563c@changeid>
In-Reply-To: <20210708142059.Bluez.v1.6.I123189fa93aad2c2d1be645d38dbc494aa15563c@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 8 Jul 2021 22:49:21 -0700
Message-ID: <CABBYNZ+_hYCZX=QMbrYALK6QwVnxcT4-XM-aaFvNHxC06fR2vQ@mail.gmail.com>
Subject: Re: [Bluez PATCH v1 06/14] audio: Remove Media1 interface when a2dp
 source disallowed
To:     Howard Chung <howardchung@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Howard,

On Wed, Jul 7, 2021 at 11:23 PM Howard Chung <howardchung@google.com> wrote:
>
> When A2DP source profile is removed from adapter, a2dp_server and
> everything inside the object will be removed, which also releases all
> MediaEndpoints and MediaPlayer. When A2DP source profile is re-added,
> although a2dp_server will be created, clients are not able to know they
> can register their endpoints and player by then.
>
> This patch handles this case by unregistering Media1 interface
> when we remove a2dp_server, and register it back when a2dp_source is
> allowed.

This sounds more like a bug fix for a regression introduced by the
very set, so Id recommend fixup the original patch that introduced the
problem, also Im afraid there could other instances like this perhaps
it would have been better to propagate the allow/block to the profiles
that way they don't have to be reprobed, I also have my doubts clients
would react properly to Media1 disappearing and appearing again so Id
leave it up if there is any endpoint/player registered to avoid having
them to re-register.

>
> Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
> ---
> perform following steps
> 1. SetServiceAllowList to empty list
> 2. pair with an LE headset, then turn off the headset
> 3. SetServiceAllowList to "0x1234"
> 4. SetServiceAllowList to empty list
> 5. turn on the headset and check if it is reconnected.
>
>  profiles/audio/a2dp.c  | 2 ++
>  profiles/audio/avrcp.c | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index d31ed845cbe7..26d4f365207e 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -3275,6 +3275,7 @@ static int a2dp_source_server_probe(struct btd_profile *p,
>  {
>         struct a2dp_server *server;
>
> +       media_register(adapter);
>         DBG("path %s", adapter_get_path(adapter));
>
>         server = find_server(servers, adapter);
> @@ -3315,6 +3316,7 @@ static void a2dp_source_server_remove(struct btd_profile *p,
>                 return;
>
>         a2dp_server_unregister(server);
> +       media_unregister(adapter);
>  }
>
>  static int a2dp_sink_server_probe(struct btd_profile *p,
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index ccf34b2207a9..997a5be9a0f4 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -4751,6 +4751,8 @@ static void avrcp_controller_server_remove(struct btd_profile *p,
>
>         if (server->tg_record_id == 0)
>                 avrcp_server_unregister(server);
> +
> +       media_unregister(adapter);
>  }
>
>  static int avrcp_controller_server_probe(struct btd_profile *p,
> @@ -4761,6 +4763,7 @@ static int avrcp_controller_server_probe(struct btd_profile *p,
>
>         DBG("path %s", adapter_get_path(adapter));
>
> +       media_register(adapter);
>         server = find_server(servers, adapter);
>         if (server != NULL)
>                 goto done;
> --
> 2.32.0.93.g670b81a890-goog
>


-- 
Luiz Augusto von Dentz
