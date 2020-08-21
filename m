Return-Path: <SRS0=kmT4=B7=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4507C433E1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF13720702
	for <linux-bluetooth@archiver.kernel.org>; Fri, 21 Aug 2020 17:46:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EozGs8tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHURqG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 21 Aug 2020 13:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgHURqF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 21 Aug 2020 13:46:05 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FF4C061573
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:46:04 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id z10so516170ooi.10
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2020 10:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PEjL0dyRIMnvU+TEOondv6UZTt27vQTUxacVcxcjF5s=;
        b=EozGs8tjRWtICLn7RZ4+/hlE0wSJfoz8bzwrDJq3rc0UooK2p7XqPhQ+nCShO3WqOo
         d6U515KExmvgyjaILb9nuPtcu2GoPdsA1Qf853jfwnAFVg95k3FARzvGOPeRUnSJDDGX
         cbN8zNFCL0chYoJRdcIgbhxA32xDN19VsScIG9EFFPZXsZPhZ3F9akW7uI1LoCAvwhU5
         1KHRFCIdvKZ4TswLMryXUvwn8xGpkGnkq15ckac8OhFqTT39ayecuVn+tuvBJKAgY4Pc
         Tjy+DFxi0B6uQ7+YVOX6brFYUeEtyqX8jo3zhq6Hia/ZYlTioH0y5gNoec1VPnXcupFU
         D09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PEjL0dyRIMnvU+TEOondv6UZTt27vQTUxacVcxcjF5s=;
        b=Jhso988qH+tr9fWjJAGdbu93cthIv+bJ2/hNv4a5ie1d3XCOKeBzRMgAUn006JxLhJ
         1QduhXI+AyzbkdFMIxCsFgFgTejQ1TGKqgjm8Ja1IS8QmQsL1aLSXkt2yHsF57qccJae
         xdy6wzpZva+s8WGZkx1NwPhWuqPfs4txm0OB4bOFDd77FIk4TtTNy3GX8x9n+HF3DhPu
         CXAiCzxIAqI68ge39J7x0Z7bG7UZLHfA3LpORpLLsrjMhnAW/vv/iLPGBhfnsJWktI5o
         PiBdAhDBrGiiAHVd8kwIeriLOybsawOsraFdPKnq1sRTfdwHgVvnMLopvbr9LQ3Tpcn2
         BmTA==
X-Gm-Message-State: AOAM531i9UXHStb3RrggMAZljT897dglJOTvkHSmKy+JUvZGCkYNjTGe
        AwO00IkIhEynyeSEQAuNfZXCFABNNNE2dZ6OrhE=
X-Google-Smtp-Source: ABdhPJzUDng1n91jMDurRsvEbdLBfBCz8px3PaGx2/dFcwQ9O/q9TKll9w0bh7qV52DjUH+ELQvIAoXXaGNo5BiD/fM=
X-Received: by 2002:a4a:924b:: with SMTP id g11mr2992050ooh.9.1598031963473;
 Fri, 21 Aug 2020 10:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200821072155.18834-1-sonnysasaka@chromium.org>
In-Reply-To: <20200821072155.18834-1-sonnysasaka@chromium.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 21 Aug 2020 10:45:53 -0700
Message-ID: <CABBYNZ+OA96+WKNUNKuNHZB199zyUczBhGjLpyN4bYEAj3npkg@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/mgmt: Provide timeout in mgmt_send()
To:     Sonny Sasaka <sonnysasaka@chromium.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Fri, Aug 21, 2020 at 12:26 AM Sonny Sasaka <sonnysasaka@chromium.org> wrote:
>
> This patch adds mgmt_send_with_timeout() to help callers who want to use
> mgmt_send with timeout handling. Ideally, all mgmt_send() caller should
> use timeout, but in this patch only UNPAIR_DEVICE mgmt command is known
> to have no-reply problem in the kernel.
>
> This prevents bluetoothd from getting stuck in a state of waiting for
> kernel MGMT reply forever. We still need to fix the kernel side for the
> missing reply.
>
> ---
>  src/adapter.c     |  8 +++---
>  src/shared/mgmt.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---
>  src/shared/mgmt.h |  6 +++++
>  3 files changed, 69 insertions(+), 7 deletions(-)
>
> diff --git a/src/adapter.c b/src/adapter.c
> index 5e896a9f0..787d1bbb6 100644
> --- a/src/adapter.c
> +++ b/src/adapter.c
> @@ -114,6 +114,8 @@ static const struct mgmt_blocked_key_info blocked_keys[] = {
>                  0x22, 0x8e, 0x07, 0x56, 0xb4, 0xe8, 0x5f, 0x01}},
>  };
>
> +#define DEFAULT_MGMT_TIMEOUT   2       /* Timeout for MGMT commands (secs) */
> +
>  static DBusConnection *dbus_conn = NULL;
>
>  static bool kernel_conn_control = false;
> @@ -7217,9 +7219,9 @@ int btd_adapter_remove_bonding(struct btd_adapter *adapter,
>         cp.addr.type = bdaddr_type;
>         cp.disconnect = 1;
>
> -       if (mgmt_send(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
> -                               adapter->dev_id, sizeof(cp), &cp,
> -                               NULL, NULL, NULL) > 0)
> +       if (mgmt_send_with_timeout(adapter->mgmt, MGMT_OP_UNPAIR_DEVICE,
> +                                       adapter->dev_id, sizeof(cp), &cp, NULL,
> +                                       NULL, NULL, DEFAULT_MGMT_TIMEOUT) > 0)
>                 return 0;
>
>         return -EIO;
> diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
> index 277e361a6..7e70aba43 100644
> --- a/src/shared/mgmt.c
> +++ b/src/shared/mgmt.c
> @@ -38,6 +38,7 @@
>  #include "src/shared/queue.h"
>  #include "src/shared/util.h"
>  #include "src/shared/mgmt.h"
> +#include "src/shared/timeout.h"
>
>  struct mgmt {
>         int ref_count;
> @@ -60,6 +61,11 @@ struct mgmt {
>         void *debug_data;
>  };
>
> +struct mgmt_pending_request {
> +       unsigned int request_id;
> +       struct mgmt *mgmt;
> +};
> +
>  struct mgmt_request {
>         unsigned int id;
>         uint16_t opcode;
> @@ -69,6 +75,8 @@ struct mgmt_request {
>         mgmt_request_func_t callback;
>         mgmt_destroy_func_t destroy;
>         void *user_data;
> +       /* Timeout for the request if > zero, otherwise timer is not used. */
> +       int timeout_seconds;
>  };
>
>  struct mgmt_notify {
> @@ -157,6 +165,8 @@ static void write_watch_destroy(void *user_data)
>         mgmt->writer_active = false;
>  }
>
> +bool mgmt_pending_timeout(void *user_data);
> +
>  static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
>  {
>         struct iovec iov;
> @@ -184,6 +194,14 @@ static bool send_request(struct mgmt *mgmt, struct mgmt_request *request)
>                                                         mgmt->debug_data);
>
>         queue_push_tail(mgmt->pending_list, request);
> +       if (request->timeout_seconds > 0) {
> +               struct mgmt_pending_request *pending_request =
> +                       malloc(sizeof(struct mgmt_pending_request));

Use new0 instead of malloc.

> +               pending_request->request_id = request->id;
> +               pending_request->mgmt = mgmt;
> +               timeout_add(request->timeout_seconds * 1000,
> +                               mgmt_pending_timeout, pending_request, NULL);

You might need to attach the pending request to the request itself so
if it is cancel/complete you will need to free the pointer.

> +       }
>
>         return true;
>  }
> @@ -267,6 +285,29 @@ static void request_complete(struct mgmt *mgmt, uint8_t status,
>         wakeup_writer(mgmt);
>  }
>
> +bool mgmt_pending_timeout(void *user_data)
> +{
> +       struct mgmt_pending_request *pending_request = user_data;
> +       struct mgmt *mgmt = pending_request->mgmt;
> +       const struct mgmt_request *request =
> +                       queue_find(mgmt->pending_list,
> +                                       match_request_id,
> +                                       UINT_TO_PTR(
> +                                               pending_request->request_id));

Make the request aware of the timeout so it can cancel it when it is
cancelled/complete it just cancel the timeout.

> +       free(pending_request);
> +
> +       if (!request)
> +               return false;
> +
> +       /* Pretend that kernel has replied with TIMEOUT status. */
> +       request_complete(mgmt, MGMT_STATUS_TIMEOUT, request->opcode,
> +                               request->index, /* length */ 0,
> +                               /* param */ NULL);
> +
> +       return false;
> +}
> +
>  struct event_index {
>         uint16_t event;
>         uint16_t index;
> @@ -571,10 +612,12 @@ static struct mgmt_request *create_request(uint16_t opcode, uint16_t index,
>         return request;
>  }
>
> -unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> -                               uint16_t length, const void *param,
> -                               mgmt_request_func_t callback,
> -                               void *user_data, mgmt_destroy_func_t destroy)
> +unsigned int mgmt_send_with_timeout(
> +                       struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> +                       uint16_t length, const void *param,
> +                       mgmt_request_func_t callback,
> +                       void *user_data, mgmt_destroy_func_t destroy,
> +                       int timeout_seconds)
>  {
>         struct mgmt_request *request;
>
> @@ -590,6 +633,7 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>                 mgmt->next_request_id = 1;
>
>         request->id = mgmt->next_request_id++;
> +       request->timeout_seconds = timeout_seconds;
>
>         if (!queue_push_tail(mgmt->request_queue, request)) {
>                 free(request->buf);
> @@ -602,6 +646,16 @@ unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>         return request->id;
>  }
>
> +unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> +                               uint16_t length, const void *param,
> +                               mgmt_request_func_t callback,
> +                               void *user_data, mgmt_destroy_func_t destroy)
> +{
> +       return mgmt_send_with_timeout(
> +                       mgmt, opcode, index, length, param, callback, user_data,
> +                       destroy, /* timeout_seconds */ 0);
> +}
> +
>  unsigned int mgmt_send_nowait(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>                                 uint16_t length, const void *param,
>                                 mgmt_request_func_t callback,
> diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
> index 7caeb3844..9aea64010 100644
> --- a/src/shared/mgmt.h
> +++ b/src/shared/mgmt.h
> @@ -46,6 +46,12 @@ bool mgmt_set_close_on_unref(struct mgmt *mgmt, bool do_close);
>  typedef void (*mgmt_request_func_t)(uint8_t status, uint16_t length,
>                                         const void *param, void *user_data);
>
> +unsigned int mgmt_send_with_timeout(
> +                       struct mgmt *mgmt, uint16_t opcode, uint16_t index,
> +                       uint16_t length, const void *param,
> +                       mgmt_request_func_t callback,
> +                       void *user_data, mgmt_destroy_func_t destroy,
> +                       int timeout_seconds);
>  unsigned int mgmt_send(struct mgmt *mgmt, uint16_t opcode, uint16_t index,
>                                 uint16_t length, const void *param,
>                                 mgmt_request_func_t callback,
> --
> 2.26.2
>


-- 
Luiz Augusto von Dentz
