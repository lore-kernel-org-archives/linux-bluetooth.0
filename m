Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55546C433E2
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15744208E4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 19:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgisvXfI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgINTsE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 15:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 15:48:02 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE31C06174A
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 12:48:02 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n61so980489ota.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Sep 2020 12:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Et2xm/t5C3XsheatROAc6iQ3qXz0y/UpsJtU8kvodnE=;
        b=BgisvXfIeMj8Z+EqvbV/F0KKMhKPVQjRmHMLdzbaX4jAZjNZQj2cV3icwToNmZPNyp
         KKQ6EJ5S7D6haLBgeMMdgu10hX+bd02UHs7lCC2eA1XJRFRGH7ChRNLrgQerbxSRJpV5
         Ob5vsE7/Z7NwNsFYYmZr/8zh1zeBj+E1OyWpu8oEmbAFpKO0AYDnrN7spFZs6k1NrDzd
         QI1366Qv1YKoVAcWKTGbNJKCrwqJ+XmXgK/rKsxoeUYGPxZvARU1Q2VO4UVer2fXysNO
         U7K8JhUXLgMuYIlhfZu0dpKfq/XnldfTMOsBSu1zxp4LlgWKS38sKdKnzdG4nk06Ha62
         5erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Et2xm/t5C3XsheatROAc6iQ3qXz0y/UpsJtU8kvodnE=;
        b=gMVnUhssnsa4woPWJ1uvts4h+N5d3VcnVzQTPvt49H69Sks4FVo6M78FDpZmMf/2Aw
         t4dijSuHeAQIUEBHXh+yTISLiICvVcu/2m4WbZG2MN2dZn/nrDTpBaTyA1jcfObwF+CH
         EF1BjZVhRr1dS18Hz+/LiNW2m9axsLTId2LL3yP8YdCVx1nfYkxcOjTG0jHz0AQHwEx0
         rrCt5qj6qGoTk1RePJx1hJL98bJcPvaVQadN6VjrXhbb+KYZo6pGmjUnxgi5ik78onsv
         ALys9chmJfnmcMnBcSDZijkcIwNbH8yEqd906rhWgJvAEBQfu0tgoMgGAaHW7Hty4ie2
         5DdA==
X-Gm-Message-State: AOAM530v6PSkqvuPRMjbQvXxmvDjaUHXMsV0cm2nQ2gMFbMyF1HBzIvd
        MPRy9UCOVP1fE+WJT2n8ZHRqSPJuXFu/8GN8kXA=
X-Google-Smtp-Source: ABdhPJy+uMm43Lf54YVFeWtj+gBddmRwp0ixvotw+h6luorijEqjuQU4JDvMNhdNw5F+2V98ggZrbxSD9+nUiYjTQz0=
X-Received: by 2002:a9d:4695:: with SMTP id z21mr10409735ote.91.1600112881654;
 Mon, 14 Sep 2020 12:48:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
In-Reply-To: <20200911235104.BlueZ.v5.1.Iaa9dc2a66de5fbfa97627e1dbeb800116d3aa91e@changeid>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Sep 2020 12:47:50 -0700
Message-ID: <CABBYNZJeXkqmx1h85bxFBqJ4eDVfaPQJ9P1m_HApbJj48zT+_A@mail.gmail.com>
Subject: Re: [BlueZ PATCH v5 1/8] adapter: Remove indirect dependency of headers
To:     Miao-chen Chou <mcchou@chromium.org>
Cc:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>,
        Manish Mandlik <mmandlik@chromium.org>,
        Howard Chung <howardchung@google.com>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Alain Michaud <alainm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Miao,

On Fri, Sep 11, 2020 at 11:53 PM Miao-chen Chou <mcchou@chromium.org> wrote:
>
> Given that adapter.h refers symbols from lib/bluetooth.h and lib/sdp.h,
> these two headers should be included directly in adapter.h.
>
> Reviewed-by: Manish Mandlik <mmandlik@chromium.org>
> ---
>
> (no changes since v1)
>
>  src/adapter.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/adapter.h b/src/adapter.h
> index f8ac20261..c70a7b0da 100644
> --- a/src/adapter.h
> +++ b/src/adapter.h
> @@ -26,6 +26,9 @@
>  #include <dbus/dbus.h>
>  #include <glib.h>
>
> +#include <lib/bluetooth.h>
> +#include <lib/sdp.h>
> +
>  #define MAX_NAME_LENGTH                248
>
>  /* Invalid SSP passkey value used to indicate negative replies */
> --
> 2.26.2

Applied, thanks. Note that I did introduce a path to fix the build
problem with  g_dbus_proxy_get_path.

-- 
Luiz Augusto von Dentz
