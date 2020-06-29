Return-Path: <SRS0=UgXA=AK=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0BCC433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05178206A1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Jun 2020 19:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oVdw+9L7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733117AbgF2TjA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387438AbgF2Thn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Jun 2020 15:37:43 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FBCC031409
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 10:07:52 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id o4so9535538lfi.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2020 10:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qNx/RsQ/hx1F8kp3HJnLewdznf5IP/ZW/G1I/H7b9gE=;
        b=oVdw+9L7cSR/PvaRbhWcisFTB9Jw2uNfX656W/hJa9b2WM+V3PmyZvRxlc178rNY/a
         oPpXlX00xjo3LtLcX956/48V4wXJNkLabkhFWBNxQda/BI67WdT5N0oUvSdiYmDdSuof
         SiiC0ftYXZxDH2uZWSoBX3Am0YiFdTZHkMw3XrDze1USyJsrECdAFLN9bFq9T9mejtw/
         BwHh73aRfcnVyqex7eLgT0HA7G8WvACjj4v3HtWMDC+MsQAuaDt7tVBMnV8up2aGfQbg
         TjYan4JPaKEs29tvDx0dFXb32bM+zp51vOc2GGfbpBtpihVcTELAiyN1rdHRjpLmIcHd
         YsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qNx/RsQ/hx1F8kp3HJnLewdznf5IP/ZW/G1I/H7b9gE=;
        b=gCAtB8uNYbWDr4DlnEqS0TV4biQHyG5ffLmqjZOwo4w3+kkGAvHI+VBwQPGxBXdLro
         h13vRs6Od3JpJVGGnkU5HAN4i5cK92GO1XzaU4PIVtNr2lERIEj5mUPY1ZdZESswWNcx
         VXsg23DIY2FS3I4hHyFaGENcXSKILjuqLt4dNLUMnguDOGmswCue39jKET14024GY/+O
         nTvbtjquttoNAkb8UzRwa0SFERzyplO/4pGuEvANTYvttj0sYnDm3Zf51O7LWw32ceQF
         h8jH95I3iczv6kVQeHJqLrVF8pOJ+GqYb9TrUCDecrenewuLFQIjhIyoSuCvFDgXbDAe
         zk0A==
X-Gm-Message-State: AOAM530fZcpCtzyxHOIx/LAWcC5yzAU16XgSra2Jy4GpqFPVdLVFIuLD
        MsYc8EN1E1BB5kLZ9mHVxgyohcAIhpo5hDyirfi4hFCC
X-Google-Smtp-Source: ABdhPJzXygbeZco41Lhk+6cpVFdmInKkQNlTi69l716j3ZlkTkNDXeSXRyUyzAZko+Q7xEaHs0Ld5LQNcLqb663RwFs=
X-Received: by 2002:a19:7e09:: with SMTP id z9mr9689801lfc.69.1593450471173;
 Mon, 29 Jun 2020 10:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200601155858.156798-1-alainm@chromium.org>
In-Reply-To: <20200601155858.156798-1-alainm@chromium.org>
From:   Alain Michaud <alainmichaud@google.com>
Date:   Mon, 29 Jun 2020 13:07:40 -0400
Message-ID: <CALWDO_WDhOZigHU8SWtkTV1TcUeDRae910fiiHJmiyo8NPp6pg@mail.gmail.com>
Subject: Re: [BlueZ PATCH] a2dp:fixing typo in endpoint_setconf_ind
To:     Alain Michaud <alainm@chromium.org>
Cc:     BlueZ <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Just a friendly nudge, this is an easy one :)

Thanks,
Alain


On Mon, Jun 1, 2020 at 11:59 AM Alain Michaud <alainm@chromium.org> wrote:
>
> This patch simply fixes a typo in endpoint_setconf_ind.
>
> ---
>
>  profiles/audio/a2dp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
> index 6f46c92bf..e3d6cfc9e 100644
> --- a/profiles/audio/a2dp.c
> +++ b/profiles/audio/a2dp.c
> @@ -654,7 +654,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
>                                                 endpoint_setconf_cb,
>                                                 a2dp_sep->user_data);
>                 if (ret == 0) {
> -                       /* Attempt to reverve discover if there are no remote
> +                       /* Attempt to reverse discover if there are no remote
>                          * SEPs.
>                          */
>                         if (queue_isempty(setup->chan->seps))
> --
> 2.27.0.rc2.251.g90737beb825-goog
>
