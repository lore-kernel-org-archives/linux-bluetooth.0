Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEECBC61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Feb 2023 20:49:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjBWUtI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Feb 2023 15:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjBWUtH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Feb 2023 15:49:07 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D252427D44
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 12:49:05 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id t14so9394705ljd.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Feb 2023 12:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y+FlQShCvBOasq3jJ1fNn62thC/WTGVbXfPL9AvuLOk=;
        b=XnP3XGvTAA1+JTnKMZCFB3RmBw27apWwEDAO83GXOb+ZNxkXsLa6/NYGQ+kL4h4v0b
         QEFoNsEaKPE6Wb+TU1F+BuHGtZ9Qx9Q2IxtmrTliWDKS0WY4mvwe7I0UK0vj6KNHX8/M
         RD05CvD+TCB6gQgr9DNrCqQrpAjABvXLYoB4ZzgZKpbmCNOBh3qR3hFLx3mC4tsDfvQG
         CBMZG8Ng2HGjT1jp+GCmAgdFOfba38HwNLhjbD1aJtRo6N32mbpOi+Q1JowL/7PBVEga
         AJD+42WAmW3bNxnj+f7cUL8idPaXsa3ItjZdltHmHUXml3hJvyiJffdycg0X2XXjZps3
         UFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y+FlQShCvBOasq3jJ1fNn62thC/WTGVbXfPL9AvuLOk=;
        b=CIzwXxdQRih8FacUvDf4hUPHEQbPgFjXDJmQ5U4CcYPAZfFHUwo3Dtlp2aAOfeXtEM
         8Wqopb2ChJR3eOKHYv+MwQhLMmnR7q7tu0uJTYrdR2ixuh8goU41NWyt+JfS6S9GuDtz
         2PJ/1JTMwe+GpOpBuU95sOXIq67P3MFBvbfGkfHCJiOM/4ZNRPlPHxI2ocWTl7jKK2Ib
         FXn+QPOOZIx9H/MtKmcdjhMWbAor6NaL3YkrSayZ2wv2d6XuQQLKV/P60e0S8WDS2vpf
         Ll2WV9IzbCbSx0qT3Xi9CpvW95+mGdVA6/na9cjBzpw9r+Vp+roONhABFAdZCmOyMTop
         R4Rw==
X-Gm-Message-State: AO0yUKUjmBNoSEysfFgDaCdsTt0qoqoedWC7w4dsWSpJJnXoRBNO2SF6
        vG7SzKv4bFfEyDe26l7NxOg5hHWTBL3MAI1iYBp+UpoDw2c=
X-Google-Smtp-Source: AK7set8LyBX9+gDsbWiDBsthnpbmBy1xolBxlia64yQn049q9hzbWXfD/Z9H2fsn5+IeM3FLnicqFge9qK/bIhMCZ2Y=
X-Received: by 2002:a2e:b74a:0:b0:295:9a96:a5cc with SMTP id
 k10-20020a2eb74a000000b002959a96a5ccmr1844009ljo.9.1677185343808; Thu, 23 Feb
 2023 12:49:03 -0800 (PST)
MIME-Version: 1.0
References: <52b90e261de4afaabcec561122c0880b3bc7b608.1677172391.git.pav@iki.fi>
In-Reply-To: <52b90e261de4afaabcec561122c0880b3bc7b608.1677172391.git.pav@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Feb 2023 12:48:52 -0800
Message-ID: <CABBYNZLahb=_9BEP37wod71LVMHOPDY7RrMkj3fHJhwjPcD4tA@mail.gmail.com>
Subject: Re: [RESEND PATCH BlueZ] shared/bap: fix crash unregistering media
 endpoint while streaming
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Thu, Feb 23, 2023 at 9:29 AM Pauli Virtanen <pav@iki.fi> wrote:
>
> The following ASAN crash is observed when media endpoint is unregistered
> (stopping sound server) while streaming from remote BAP client:
>
> ERROR: AddressSanitizer: heap-use-after-free on address 0x60b0000474d8
> READ of size 8 at 0x60b0000474d8 thread T0
>     #0 0x7a27c6 in stream_set_state src/shared/bap.c:1227
>     #1 0x7aff61 in remove_streams src/shared/bap.c:2483
>     #2 0x71d2d0 in queue_foreach src/shared/queue.c:207
>     #3 0x7b0152 in bt_bap_remove_pac src/shared/bap.c:2501
>     #4 0x463cda in media_endpoint_destroy profiles/audio/media.c:179
>     ...
> 0x60b0000474d8 is located 8 bytes inside of 112-byte region
> freed by thread T0 here:
>     #0 0x7f93b12b9388 in __interceptor_free.part.0 (/lib64/libasan.so.8+0xb9388)
>     #1 0x7a0504 in bap_stream_free src/shared/bap.c:972
>     #2 0x7a0800 in bap_stream_detach src/shared/bap.c:989
>     #3 0x7a26d1 in bap_stream_state_changed src/shared/bap.c:1208
>     #4 0x7a2ab4 in stream_set_state src/shared/bap.c:1252
>     #5 0x7ab18a in stream_release src/shared/bap.c:1985
>     #6 0x7c6919 in bt_bap_stream_release src/shared/bap.c:4572
>     #7 0x7aff50 in remove_streams src/shared/bap.c:2482
>     ...
> previously allocated by thread T0 here:
>     #0 0x7f93b12ba6af in __interceptor_malloc (/lib64/libasan.so.8+0xba6af)
>     #1 0x71e9ae in util_malloc src/shared/util.c:43
>     #2 0x79c2f5 in bap_stream_new src/shared/bap.c:766
>     #3 0x7a4863 in ep_config src/shared/bap.c:1446
>     #4 0x7a4f22 in ascs_config src/shared/bap.c:1481
>     ...
>
> When stream->client is false, bt_bap_stream_release already sets the
> stream to idle and frees it.
>
> Fix the crash by not setting the state to idle for the second time,
> in this case.
> ---
>
> Notes:
>     Resend, in case this was missed.
>
>     Crash seen when testing BlueZ at commit 67395a3b357d.
>     Also occurs on current BlueZ master branch.
>
>  src/shared/bap.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/src/shared/bap.c b/src/shared/bap.c
> index f16ba1832..5601accde 100644
> --- a/src/shared/bap.c
> +++ b/src/shared/bap.c
> @@ -2480,8 +2480,11 @@ static void remove_streams(void *data, void *user_data)
>
>         stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
>         if (stream) {
> +               bool client = stream->client;
> +
>                 bt_bap_stream_release(stream, NULL, NULL);
> -               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> +               if (client)
> +                       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>         }
>  }
>
> --
> 2.39.2


How about we do this inside bt_bap_stream_release:

diff --git a/src/shared/bap.c b/src/shared/bap.c
index f16ba1832aaa..49c521b1d9eb 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2479,10 +2479,8 @@ static void remove_streams(void *data, void *user_data)
        struct bt_bap_stream *stream;

        stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-       if (stream) {
+       if (stream)
                bt_bap_stream_release(stream, NULL, NULL);
-               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
-       }
 }

 bool bt_bap_remove_pac(struct bt_bap_pac *pac)
@@ -4590,6 +4588,10 @@ unsigned int bt_bap_stream_release(struct
bt_bap_stream *stream,
                return 0;
        }

+       /* Check if stream still attached, otherwise consider it released */
+       if (!queue_find(stream->bap, NULL, stream))
+               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
+
        return req->id;
 }



-- 
Luiz Augusto von Dentz
