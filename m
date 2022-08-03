Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D0C19F29
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 23:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239462AbiHCXzd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 19:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239454AbiHCXz2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 19:55:28 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728A6AE49
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 16:55:26 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id uj29so20962563ejc.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 16:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UM7/D2EdsiCRDP5Tdb0POGSLbAaxSrRVZRtOEicAKDE=;
        b=qPiYkH7oFqxuIsIcucqkfIJOrmdKw1PC89Jb7jNy8VERdpY9uEgmQE3XJbWhdkHyb6
         1sD9tKs5L5F40YYmXK5oeLzTBw0np4Wcp0iW8gp6Ia63lrC+kQUv1UarcgOXnDaE+jqc
         mBTxGTdztDEhdZPrlJCccUOwy3QnUSIqEho2TumzftVXS+aiTk04lHGFLv3TjGrENhLQ
         ZDv+fBm35acHeJZef7yq74N+9H/iTd0BUSN0sLwGmRQB1WGtpCZ7dVLEqbWur09/9v4/
         UXmszZfSDPMsOcltQkewhTJzNo03Ebzq9xkMeRGhVI5SH2QUAWi+aKUqqd/rckFldl4y
         bsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UM7/D2EdsiCRDP5Tdb0POGSLbAaxSrRVZRtOEicAKDE=;
        b=dg6nUpoP4hzAzC2ngPyc8+HtVOYvtvw1zSnz/NmFBg74LnkXkbdximby+0iYpHoR8+
         ryI/JJMO22QF54Ok2T3SMTooUr+KYLAORpv740vGCXP5xlyves+mqEXXztf/i+Gbi48p
         aQwqgVBp/uI/jdxsxfNCTpTfbnkPDoIWeOmkf8TKspv0pssN3ifo7RBLNjyYM9ej1/QF
         VaZpo8ebLsGiLW0RLZZQxNx3GIlfcsYt+UX8sjJEvtSf3tai6Gl9y7LT38Cj4FUaGfum
         99rgsd2+p5a/Zx4P/gePjaGnMAP+gkuiGWRSYBl/HsByM0hvQvHlvhTv4VBRv2SZksCU
         pGOQ==
X-Gm-Message-State: AJIora+PvHyCcPgWOofrFUuWDVltaYm7pqv2rZBCv6CM/lHbsqCLaKW+
        PQGlbbfbKKpPxIXrixci/hTy+i6GxPu9g3V1M4LlJbjX8e2A9Q==
X-Google-Smtp-Source: AGRyM1uvZJy17W3EVRJm54uFOhRgdWEeDQb15f2d8BNPmvushYM2nP0/p+beIfzb0LCzcE/ZQhIkk6Fp20MvWqiCzxQ=
X-Received: by 2002:a17:906:29d:b0:6f0:18d8:7be0 with SMTP id
 29-20020a170906029d00b006f018d87be0mr20795863ejf.561.1659570924874; Wed, 03
 Aug 2022 16:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220803225716.1287921-1-vi@endrift.com>
In-Reply-To: <20220803225716.1287921-1-vi@endrift.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 3 Aug 2022 16:55:12 -0700
Message-ID: <CABBYNZKcAZeDqjeHzTfqmvKS3Tbur-rRi6+uPL4x4t8MnWp5ug@mail.gmail.com>
Subject: Re: [PATCH BlueZ] hog-lib: Increase maximum report map size
To:     Vicki Pfau <vi@endrift.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Vicki,

On Wed, Aug 3, 2022 at 4:07 PM Vicki Pfau <vi@endrift.com> wrote:
>
> Though a 512 byte report map size seems plenty large, there exist some devices
> (e.g. Brydge W-Touch) that send larger reports. There is no protocol-defined
> maximum size so doubling the maximum size is safe, and should hopefully fix
> most real-world failures.
> ---
>  profiles/input/hog-lib.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
> index 4a9c60185..9f3eb428c 100644
> --- a/profiles/input/hog-lib.c
> +++ b/profiles/input/hog-lib.c
> @@ -64,7 +64,7 @@
>  #define HOG_PROTO_MODE_BOOT    0
>  #define HOG_PROTO_MODE_REPORT  1
>
> -#define HOG_REPORT_MAP_MAX_SIZE        512
> +#define HOG_REPORT_MAP_MAX_SIZE        1024
>  #define HID_INFO_SIZE                  4
>  #define ATT_NOTIFICATION_HEADER_SIZE   3

Afaik 512 is the maximum length an attribute can have even when using
read long procedure:

BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 3, Part F
page 1416:

The maximum length of an attribute value shall be 512 octets.

And

BLUETOOTH SPECIFICATION
HID Service Specification
Page 16 of 26

2.6.1 Report Map Characteristic Behavior
The GATT Read Characteristic Value or Read Long Characteristic Values sub-
procedures are used to read the Report Map characteristic value.
The length of the Report Map characteristic value is limited to 512 octets.

So I believe the device is not compliant and very likely needs to have
multiple instances of HID Service instead of combining everything in a
single instance.

> --
> 2.37.1
>


-- 
Luiz Augusto von Dentz
