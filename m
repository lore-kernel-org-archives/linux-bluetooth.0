Return-Path: <SRS0=wTyq=D2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18261C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 20:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA0BC223FB
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Oct 2020 20:18:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vEFlqqO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbgJSUSV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Oct 2020 16:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgJSUSV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Oct 2020 16:18:21 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26760C0613CE
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 13:18:21 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id u17so1415332oie.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Oct 2020 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xqLU4oOK29Elmk+yTbDCjjGVCmjyNqMveIRrbZ5FjlU=;
        b=vEFlqqO0dzL/BD4R+dRT1SO7KroOYcqvwGwxFzKVlxlR7BB0drqs24wtKwJKvEedCC
         fgVwhWKbsjIHu485Ao0P2cZ3lBf4LZJjCk5DFbrhBMuhzXzCMORpLZyPETDG3bd+SJh9
         F7gUJBOUFY8oATD2r5+YE67XUOS0vHlJTOQnNxWKG8XyNBC8UtV5Y75u4hf/3kE1o1wp
         yW7d10FRzjS1XDszq6qzy8h5ISnFDAjRoVbxTTlwYXkJRrJVvzNNpLsWHLHdLifsQbYz
         PdbMWG52BngLwoIc23i3FCxJKlQCLKENuyh2ye6PTmsooTwnGzv6xNuF17Orm+5xBg2T
         H6Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqLU4oOK29Elmk+yTbDCjjGVCmjyNqMveIRrbZ5FjlU=;
        b=tE1RwKm00qPrztWDRM49n2u8GsKe1OAQvKkHK9xLS5HF+gEryBNvXP6zTrIbMNONnq
         QafZSSBuxw42oUu99unYxNG9riDkJMJwV4YcLuL5dY2PR4xs1N074mD7G0TvITO9LXyT
         JNXoAC827yfLD1CKYoqmYj5IDmcMi4EzL6SqdQKgwb1rVfylUOGvPZpPm8+YBcZ/0N3m
         zpVQBZEYgeailCtzGFUwwllzS8YwdNrK3uDVJ0MyU6LKk9mW6HNw4B1BKwr8cPBMPIGk
         JV5oYybR4rE06GKOm/rGtNPW2cago7kobpvHHD9qDuaU9Pvt9m6qUDdxDN0hVWDegKSN
         Dfsg==
X-Gm-Message-State: AOAM532WFR1Zu0KIj+mdt/BUEXj200rEo/nybngSsL6ONvbfGLoA1RSk
        P6gtLO3H9usuDLQ7kbJPM7U9SkZZFDmCNsvw0n8=
X-Google-Smtp-Source: ABdhPJyYQ24WiJ2unNeII/eWus5ksXWbl/Rnzx4TrA/l+GhSvlq3Zw0d3QHx4ALLnYGOb3xu2cBO/KrHnTlC1N7Fzts=
X-Received: by 2002:aca:4c7:: with SMTP id 190mr827796oie.58.1603138700480;
 Mon, 19 Oct 2020 13:18:20 -0700 (PDT)
MIME-Version: 1.0
References: <20201005041932.99783-1-inga.stotland@intel.com>
 <38633edb6423eabcd54c3b7559117e7ee64cb51b.camel@intel.com> <34814d0a7ad0f0ba19bb85e596f5a47843d2da39.camel@intel.com>
In-Reply-To: <34814d0a7ad0f0ba19bb85e596f5a47843d2da39.camel@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 19 Oct 2020 13:18:09 -0700
Message-ID: <CABBYNZ+4G-5CRLwcDX+BJa30K_umaJtoi7bBhXjbD=4Jpjj8nw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] shared/timeout-ell: Fix timeout wrapper implementation
To:     "Stotland, Inga" <inga.stotland@intel.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Inga,

On Mon, Oct 19, 2020 at 1:00 PM Stotland, Inga <inga.stotland@intel.com> wrote:
>
> Another ping
>
> On Fri, 2020-10-09 at 21:03 -0700, Inga Stotland wrote:
>
> Gentle ping
>
> On Sun, 2020-10-04 at 21:19 -0700, Inga Stotland wrote:
>
> This fixes the following issues:
>
> - Correct user data is passed around to l_timeout_create():
>
>   locally allocated timeout data is a valid "user data" to
>
>   associate with a newly created timeout. Previously, user_data
>
>   passed as an argument to timeout_add() was incorrectly used as
>
>   an argument to l_timeout_create()
>
> - To maintain common API and work around the issue when the conversion
>
>   of a pointer to an unsigned int truncates the initial value, a queue
>
>   of active timeouts is maintained where pointer each l_timeout structure
>
>   is associate with a unique id. This id is returned when timeout_create()
>
>   API is called and can be subsequently used with timeout_remove().
>
> ---
>
>  src/shared/timeout-ell.c | 50 ++++++++++++++++++++++++++++++++++++----
>
>  1 file changed, 45 insertions(+), 5 deletions(-)
>
>
> diff --git a/src/shared/timeout-ell.c b/src/shared/timeout-ell.c
>
> index c2da387e2..023364069 100644
>
> --- a/src/shared/timeout-ell.c
>
> +++ b/src/shared/timeout-ell.c
>
> @@ -12,13 +12,23 @@
>
>
>
>  #include "timeout.h"
>
>
>
> +static struct l_queue *timeout_q;
>
> +
>
>  struct timeout_data {
>
>   timeout_func_t func;
>
>   timeout_destroy_func_t destroy;
>
> - unsigned int timeout;
>
>   void *user_data;
>
> + unsigned int timeout;
>
>  };
>
>
>
> +static bool match_id(const void *a, const void *b)
>
> +{
>
> + unsigned int to_id = L_PTR_TO_UINT(a);
>
> + unsigned int id = L_PTR_TO_UINT(b);
>
> +
>
> + return (to_id == id);
>
> +}
>
> +
>
>  static void timeout_callback(struct l_timeout *timeout, void *user_data)
>
>  {
>
>   struct timeout_data *data = user_data;
>
> @@ -43,7 +53,12 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
>
>   void *user_data, timeout_destroy_func_t destroy)
>
>  {
>
>   struct timeout_data *data;
>
> - uint32_t id;
>
> + unsigned int id = 0;
>
> + struct l_timeout *to;
>
> + int tries = 0;
>
> +
>
> + if (!timeout_q)
>
> + timeout_q = l_queue_new();
>
>
>
>   data = l_new(struct timeout_data, 1);
>
>
>
> @@ -52,12 +67,37 @@ unsigned int timeout_add(unsigned int timeout, timeout_func_t func,
>
>   data->user_data = user_data;
>
>   data->timeout = timeout;
>
>
>
> - id = L_PTR_TO_UINT(l_timeout_create(timeout, timeout_callback,
>
> - user_data, timeout_destroy));
>
> + while (id == 0 && tries < 3) {
>
> + to = l_timeout_create(timeout, timeout_callback,
>
> + data, timeout_destroy);
>
> + if (!to)
>
> + break;
>
> +
>
> + tries++;
>
> + id = L_PTR_TO_UINT(to);
>
> +
>
> + if (id == 0 ||
>
> + l_queue_find(timeout_q, match_id, L_UINT_TO_PTR(id))) {
>
> +
>
> + l_timeout_remove(to);
>
> + continue;
>
> + }
>
> +
>
> + l_queue_push_tail(timeout_q, to);
>
> + }
>
> +
>
> + if (id == 0)
>
> + l_free(data);
>
> +
>
>   return id;
>
>  }
>
>
>
>  void timeout_remove(unsigned int id)
>
>  {
>
> - l_timeout_remove(L_UINT_TO_PTR(id));
>
> + struct l_timeout *to;
>
> +
>
> + to = l_queue_remove_if(timeout_q, match_id, L_UINT_TO_PTR(id));
>
> +
>
> + if (to)
>
> + l_timeout_remove(to);
>
>  }

Applied, thanks.

-- 
Luiz Augusto von Dentz
