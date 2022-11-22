Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AB9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Nov 2022 20:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234530AbiKVUD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiKVUDy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 22 Nov 2022 15:03:54 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7C2A316F
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:03:50 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id h12so19134759ljg.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Nov 2022 12:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Asm5OopmpIdXZ9qc1WO4SzpTmy8LRlqo9U5uNin861c=;
        b=npmIREdFFL+m2BHj71J8wom5YW1wAq0xpReLbEryf8pSyIhz7hKHDJPJAlZGD8CxXW
         jkWqONgrlqjT55KpW00iWf/d1otR9GTti6dLBg9NZK/CjFTGdvzGj7luck0wi/6rQLPc
         JS53r0OG+tCwq10w1LL1Q3Dwd4KFCaY7ZkVz7/WxK7pT+OtwDILICkA//Np3KMxKIeW4
         4376MPbhxJ66N+f/YD5/iaUgaoLo/BQJWJqh7/fu/xnmWFjTOiIax8k0YhhcKmQuoS5z
         aKAtAaSF/j0G12wAQ3wijEBkbCV/YvvGHRfeRlSySayL8erusKMwj8Gook3QqO6oOJhg
         Ns8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Asm5OopmpIdXZ9qc1WO4SzpTmy8LRlqo9U5uNin861c=;
        b=pxVp85pFaClFdoOpUTyHPh4lKy7K0YGx7y5Ohd368geLSoSKZi2yJn4V6S/za0dmRu
         bZlhrpb9sNF3+wSuHnDPHHXNM9tn5fN+gNIUffSbxu6mswXxcsT5ouq3pzm+Q4nHBjwU
         yAjOwJNA+LOodtQk+U8yRhrTvW4pCJGLlkDv6AXdjJroKsVap7OmDdwl17kCEWFEZTRw
         bTp40Btueh9nSar9i3+2h6G9pXDMlFF9k/g3o1omlESZ2YhB8sXWVJaapsSNg+zfaDih
         8xrwDA4aF5Z5qwopS/Wlptlav+zOffzNFcvP5fDKETl8NmuOU56Btym37EbkVWZAureq
         mrqw==
X-Gm-Message-State: ANoB5pne/4BXFMCh7YbkDGV+btdEcmIrrKBv0j3RgwLMxFnvE98q6mzX
        F0UOmfoXicEwoRtJM0it1ZA5gsjHGzk+diFFoffQE3jp
X-Google-Smtp-Source: AA0mqf71ARwuJ/+03FgyU5wNY7PuM0Kkf+xrYXQW84OkzBxUujIMsS3aiDm7unsJTyDVFK13nhw23ahQmJHzSvUztew=
X-Received: by 2002:a05:651c:2c6:b0:279:7617:cfb2 with SMTP id
 f6-20020a05651c02c600b002797617cfb2mr402321ljo.423.1669147428819; Tue, 22 Nov
 2022 12:03:48 -0800 (PST)
MIME-Version: 1.0
References: <20221122101232.45320-1-sathish.narasimman@intel.com> <20221122101232.45320-2-sathish.narasimman@intel.com>
In-Reply-To: <20221122101232.45320-2-sathish.narasimman@intel.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 22 Nov 2022 12:03:37 -0800
Message-ID: <CABBYNZJ3jKn6aqP1Lq5izk21fB4mwaphEgsAXcnPAFybfBexbw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v3 1/7] shared/util: Update UUID database for Csip services
To:     Sathish Narasimman <sathish.narasimman@intel.com>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Tue, Nov 22, 2022 at 2:16 AM Sathish Narasimman
<sathish.narasimman@intel.com> wrote:
>
> This updates UUID database with the values from assigned numbers for
> co-ordinated set identification services.
> ---
>  src/shared/util.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/src/shared/util.c b/src/shared/util.c
> index 333023e0dcac..d7fbd2322f7b 100644
> --- a/src/shared/util.c
> +++ b/src/shared/util.c
> @@ -695,6 +695,9 @@ static const struct {
>         { 0x2b82, "Volume Offset Control Point"                 },
>         { 0x2b83, "Audio Output Description"                    },
>         { 0x2b84, "Set Identity Resolving Key"                  },
> +       { 0x2b85, "Csis Size"                                   },
> +       { 0x2b86, "Csis Lock"                                   },
> +       { 0x2b87, "Csis Rank"                                   },

Use the actual attribute name rather than its services e.g:
Coordinated Set Size, etc.

>         { 0x2b93, "Media Player Name"                           },
>         { 0x2b94, "Media Player Icon Object ID"                 },
>         { 0x2b95, "Media Player Icon URL"                       },
> --
> 2.25.1
>


-- 
Luiz Augusto von Dentz
