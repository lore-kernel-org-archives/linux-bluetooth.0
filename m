Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59600C433B4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EAB76109E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 May 2021 16:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhEEQHj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 May 2021 12:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhEEQHi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 May 2021 12:07:38 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE51C061574
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 May 2021 09:06:42 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id z1so1481607qvo.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 May 2021 09:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=NmaGYkGi/ld3pgjq7y1oDumN5k3dGVPD9wubZoQ0E9o=;
        b=wPrO+wz/GsAvuZu/a7/oSBQWq3zQots2gsvu4ZJ9V2zgrFAUPdanYFd75r/PifSIlk
         Uadn04Q9ot59LEraunsqimMQqad6w82zLpRpn8tfgF7m9qb7jZYe0shTgQz4sr09r4VW
         N+Nc285kygE0aAutbfb5v8bNszKaEikRrptP4a6OMTXmZmqZiWL09p4WS/QV8S6Elnde
         uSTSiOLMtvwJrrjD/lw7oaBYFIe7RlKWOGNMlpG7WjSqwRpdqtC0rhNC2AHZtU5kQXWH
         m/FuFmolGoGURrm2Bo93GwVDUCUJs5bKlRMT3SiuzSKf/zGXi1bsYAN0KvppWUsf5mlz
         +NlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=NmaGYkGi/ld3pgjq7y1oDumN5k3dGVPD9wubZoQ0E9o=;
        b=lObt9s7oVl41ERa73hshyvJoFlQFXjKMljydGm4yxJtRX0tk71Mw6fSZt44HI6yGqa
         Zwet+yb/sm21U12k+AT1RH7qDnl9EJQTlRngANbd5ZgqwTlc98bvPwiHR8sQGUSA6ijs
         /WsS7fp3pavNEI8RTbFDTA3iBQ4TjvQCbl4MbXSAVAfOkDRUB5cOORr7dwaQvqgkMKJu
         e4QxXNrmTsuo4KVQMjQLZ4H3tvphY1O8773TPPLBFWgaWWlqkrOzk+TzlAby7WP4bpdf
         GVXg0EF+s4WzlSs9axHhE1galvPdt93koTIR0HikWVElJ4Tz8EvwiIEg6AJ8v6NFhWv4
         H6Vw==
X-Gm-Message-State: AOAM5316t/HpKF6vLALrUFue8wUBWXxnUfck5l49dlQwIH00o0mz45n4
        Ubp+hH5UvzWWrtvFFBNBVVIQ0WKqzGuRuvz/inPS6FChgWY=
X-Google-Smtp-Source: ABdhPJxfx8GU4E9CqvDmCQhuyHIbeQ1V/VY2TIA7XmwFvyEKE1S7ouGY3w9tNsgqG5353J7PkghbPEILSEegJvs5LJk=
X-Received: by 2002:a05:6214:9aa:: with SMTP id du10mr32197149qvb.37.1620230800947;
 Wed, 05 May 2021 09:06:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
In-Reply-To: <20210429111523.Bluez.v1.1.Ic00ed950add081b346d6c8ced590bb7b2eb6e9f7@changeid>
From:   Yu Liu <yudiliu@google.com>
Date:   Wed, 5 May 2021 09:06:04 -0700
Message-ID: <CAHC-ybyEk+0HbXBNv+df8bCUQnpgG7w101jxYPJ5YTU67=pTYA@mail.gmail.com>
Subject: Re: [Bluez PATCH v1] doc/mgmt-api - Add a new error code for HCI
 status 0x3e
To:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

ping for attention.


On Thu, Apr 29, 2021 at 11:15 AM Yu Liu <yudiliu@google.com> wrote:
>
> We want to retry the pairing when HCI status 0x3e (Connection failed to
> established/Synchronization timeout) is returned from the controller.
> This is to add a new MGMT error code so that we can catch this 0x3e
> failure and issue a retry in the user space.
>
> Reviewed-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
>
> Changes in v1:
> - Initial change
>
>  doc/mgmt-api.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
> index 5355fedb0..f7cbf7ab2 100644
> --- a/doc/mgmt-api.txt
> +++ b/doc/mgmt-api.txt
> @@ -200,6 +200,7 @@ and Command Complete events:
>  0x12   RFKilled
>  0x13   Already Paired
>  0x14   Permission Denied
> +0x15   Connection Not Established
>
>  As a general rule all commands generate the events as specified below,
>  however invalid lengths or unknown commands will always generate a
> @@ -1112,6 +1113,7 @@ Pair Device Command
>                                 Not Powered
>                                 Invalid Index
>                                 Already Paired
> +                               Connection Not Established
>
>
>  Cancel Pair Device Command
> --
> 2.31.1.527.g47e6f16901-goog
>
