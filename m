Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F29DC32772
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Aug 2022 07:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbiHPHKq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Aug 2022 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiHPHJv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Aug 2022 03:09:51 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CD38BDCC
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 21:40:06 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-11be650aaccso3054053fac.6
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Aug 2022 21:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=sxFolP9vB6hc0J99TgpLdaG+/0iP0iiYVcHL0f/yb0g=;
        b=aS6P3hzGYYKaFTJMGBlaBVjtFHlRgQkiqci56RehMNtBftXeZnf3oUyC4i6/3T6Ou4
         3upr8v4pspKy53R7s7keCDUB1lbVxtwhCQonW1UIsFQLoiW8NUszRr/hnyZzvHIaY0Mx
         sojcOPOmLfOJ2IsN7IZdJOerv7SR+7Y0PqmDN29TUt8tyaG5voSoMfer2jc4keW57f2W
         3PMhHs/f9pOSuCqUsRhTDXKymd7hA9vEVp34G8qP/9S26MZzC7TMjVS44Dl0HG8yQnD2
         HxcgzKzxVGAxVOC3xZ1LVJOQXHAPonTVQSKcmE5lOHMWWsl45hPpbKdgQguMc6X1ICCP
         cneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=sxFolP9vB6hc0J99TgpLdaG+/0iP0iiYVcHL0f/yb0g=;
        b=CsiqU4xx1BOzdsgYc6ienkxspRoaF24+q/siA8zXxPUZJbMNnDGk/oghtx0ZjCr+xi
         mU/pKhtIO7VGh8wWl5xivdS2cUhufs9U/2UJCFrPII3N6bhCtnWMo9V+ILLkbk12ALIw
         XXYoE1jZQ5QwgUKHPy0CAGx/i5Y3R7Evod6U8M0xPZQCXPCxn/Aj+RHr/C6rKz53SCqx
         59fPy1wK8nmwiPumjyrJlBirU2gt4vqVdbNfmLNZjeiEprreT4RGTwY148foly/j+ikQ
         hChm+C+3GWMxs71mlORdC27DdFSfMF1mDR3nJo5VBsma4w3ILdJzXttENyR4uEpdhsKU
         XCcQ==
X-Gm-Message-State: ACgBeo07HBwWzfHkw3G9xnMnPNXdp6TbXWYZhtdwFjLp4FcwGD2q5dwA
        cmxtm+f4qcZQ7318WgIHP+XGwikQoOw=
X-Google-Smtp-Source: AA6agR6ULTaoNdV3saXsmHtB0ZMCwmLPUPD9a0QKR9aiRscfdVB/sOsXYRPe9M1SdQtTlK3q98Wu7g==
X-Received: by 2002:a05:6870:3398:b0:113:7f43:d0e9 with SMTP id w24-20020a056870339800b001137f43d0e9mr8105727oae.33.1660624784919;
        Mon, 15 Aug 2022 21:39:44 -0700 (PDT)
Received: from [172.17.0.2] ([104.215.86.93])
        by smtp.gmail.com with ESMTPSA id t2-20020a4a8242000000b004357ccfc8bfsm2167853oog.7.2022.08.15.21.39.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 21:39:44 -0700 (PDT)
Message-ID: <62fb1f90.4a0a0220.4459a.7237@mx.google.com>
Date:   Mon, 15 Aug 2022 21:39:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5525930530405999517=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ] adapter: Check flags are supported
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220815232006.1252933-1-luiz.dentz@gmail.com>
References: <20220815232006.1252933-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5525930530405999517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=667831

---Test result---

Test Summary:
CheckPatch                    PASS      1.26 seconds
GitLint                       PASS      0.79 seconds
Prep - Setup ELL              PASS      33.08 seconds
Build - Prep                  PASS      0.89 seconds
Build - Configure             PASS      11.00 seconds
Build - Make                  PASS      991.11 seconds
Make Check                    PASS      12.79 seconds
Make Check w/Valgrind         PASS      345.61 seconds
Make Distcheck                PASS      294.13 seconds
Build w/ext ELL - Configure   PASS      10.60 seconds
Build w/ext ELL - Make        PASS      97.83 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    PASS      738.27 seconds



---
Regards,
Linux Bluetooth


--===============5525930530405999517==--
