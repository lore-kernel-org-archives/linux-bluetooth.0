Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E4DC48BC2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 18:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1DFC611AD
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 18:45:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhFWSr5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbhFWSr5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 14:47:57 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E5BC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 11:45:39 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c138so7788664qkg.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Jun 2021 11:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=e6P3kraw0EI11wZ+HhoLdtIBp/esKySiKV8q26GFR8E=;
        b=sOqvYkM8YYDd84uvKWyF5clfE7A8uHPSGul61OH4g6N0KR0T0GoFDxeK+dLLjX72p4
         Y1OLWb8JjqqMu+o92lasM8ofk7OBJRYTd9Hc2t5saRNhin6hLS/BDxtzcW0P/Akg5XAa
         efdSq0RcynzxGbWBbxotbE1R1qr5E8EL7XGWM7lTR/mwZUYPpd7CLgEef3kBFmrDTAbD
         YRYgLsc4AJXSESBqvssOtAeW28ryFRHqrz5nydNx1GRgjG0WUpcykMtoB1KMwDOLibWn
         NFYKACTp2/RoKC6OBIsQI1Ks93mtqAXq+saM0Dfpsi02EylTfY6kYRg8llmFbzdY5RsM
         VfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=e6P3kraw0EI11wZ+HhoLdtIBp/esKySiKV8q26GFR8E=;
        b=pLHIl5b/7+pdE1xBCOyCTIgXHGYeS/vX5vcFE9fB8j33K5aOKi6CRvS7mkobvP4I5t
         IQBhzSENYuSfMkJn8PcE3RsflNARNf5qBkuT5G8YTdmDebnIOk2fE0lsT4asqJ6KYNfT
         kq1A80HVIr1h55CCBW9+UaqdxUJWDw8eiGcUYmk1fbig91uW8W4CdDcZ9BZk3GJ+0dMs
         hIBrit+vlf61jVFvtbTriy2ZoWIkpObUgi1YjNdy5ul9ft1nNo/PF1Rr6+ejiyW4WNfH
         aNqUsi98VnQJpVbe0OszGv0IpEhiMmbZDGse4kLn5Rvxvp59XsMBoRRac0w19uwohgD0
         pXVg==
X-Gm-Message-State: AOAM532WR61Z1yAbSosJwvBdfWMwgZnlDWe4OfTCBt71f7N0xbd5KBWp
        66tCPImFJFBMM13KNaYMFVKBRyUq1elbQJN3B157gDgUa9Q=
X-Google-Smtp-Source: ABdhPJwzhoUa8HY4XnYkpm6vbIkUeiZJXoC8xHfpr6qzhxBZ7xU+pq04+aStiAFVyq3HfSyipZUV7OT/Vx7RoOCO9fE=
X-Received: by 2002:a25:68cc:: with SMTP id d195mr1214615ybc.264.1624473938542;
 Wed, 23 Jun 2021 11:45:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210623184355.3685859-1-luiz.dentz@gmail.com>
In-Reply-To: <20210623184355.3685859-1-luiz.dentz@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 23 Jun 2021 11:45:27 -0700
Message-ID: <CABBYNZKuRM6_=fACHqRNhyDnmEOZfnMHufHWeZCsvn4bN9=1ow@mail.gmail.com>
Subject: Re: [PATCH BlueZ] doc/agent-api: Add AuthenticationFailed method
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Jun 23, 2021 at 11:43 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> This introduces AuthenticationFailed method which is used to indicate
> when there was an authentication failure with a remote device which is
> recommended by the core spec:
>
> BLUETOOTH CORE SPECIFICATION Version 5.2 | Vol 3, Part C page 1314:
>  '5.2.2.3 Simple Pairing after authentication failure
>  When the link key is stored, subsequent connections to the same device
>  will use authentication but this may fail if the remote device has
>  deleted the link key. Table 5.2 defines what shall be done depending
>  on the type of the link key and whether bonding was performed or not.'
>
> So following Table 5.2 recommendation the AuthenticationFailed method
> would be called when authentication fails with a bonded device.

This was intended to be an RFC.

> ---
>  doc/agent-api.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/doc/agent-api.txt b/doc/agent-api.txt
> index 0d9347cab..91d752b0a 100644
> --- a/doc/agent-api.txt
> +++ b/doc/agent-api.txt
> @@ -183,3 +183,8 @@ Methods             void Release()
>
>                         This method gets called to indicate that the agent
>                         request failed before a reply was returned.
> +
> +               void AuthenticationFailed(object device, byte status)
> +
> +                       This method indicates that there was an authentication
> +                       failure with a remote device.
> --
> 2.31.1
>


-- 
Luiz Augusto von Dentz
