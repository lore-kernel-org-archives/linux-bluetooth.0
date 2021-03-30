Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98E8C433C1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB8B61957
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Mar 2021 18:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhC3Syh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Mar 2021 14:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbhC3Syb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Mar 2021 14:54:31 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8651C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:54:31 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id c6so12718073qtc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Mar 2021 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=axPvWXbQeD5+pWcdSeEjBEY1A+X0I/hhy5obUhmEoOk=;
        b=Dwcjl3R4lzqalLoOtjsGjxlKQFHSVvjCGrkJTWwfBspDvkiJT134oi7DAsPsEAEhxE
         dpTTHUgHYM/F8aSIGmFuUen2qgHsWfrUUFGCONHSOt8mXaebEJjOsKlgHhs+zYmwGP6I
         DcFb09tC/lu2Mxm/xTI8hmGznBMX36k4wjyo+ejcYXBAX2R0H+tOS/ttsrwBHJODLvIu
         jBorX1Tx3Fznv0Yw1GZnCWdkBCG74Idkq0tI6+OhCU16LWlwC8Lai/h3AtaGMZ5jjdfX
         W6u4lvJmeba4wj1g9Z4aqM9vIWBNH4KA32LbSpuNf8Vmz5KL/3wk1qTyXLGpIk+dYoZ1
         GJmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=axPvWXbQeD5+pWcdSeEjBEY1A+X0I/hhy5obUhmEoOk=;
        b=G+q8oIA5XGLi67NLIAjW8xxEYDUXFflfB9ywp7Ns5xPjd9umuKi9IFmzV3+8EcMl30
         DCtuskm7Loa9R7E/DSHdfE3M0EifrZXSq31oc4UY/w5OCWt4aD6bL4h1KvUceIiK+jZR
         j8xpWWBgMGxmzG3nVuVHQFl8+qdSO/VvxJVJr4GcRcXxow9FGPedbMPvyBm1WWqzjRbM
         1wXDdH8mQO4phfwAfwifeq5O50jx2Fnq/RprH0YhsV5pEeIUMaqCLUZNq9tRKnQZzWGL
         SjMi/jcxAVUve4wvC6jdGuf3sjbis/JJzpybkEMFcr7Gte0KDgWNsXbi4BcNTijIhA6x
         lG9Q==
X-Gm-Message-State: AOAM533mfz/4oEYGzpoL505D/g5cxv8DfvLqRgElf4cIIorFZbtjkFVX
        kRwgJM7/NSq3hRNBkjUm+wsHGmfTjwaVrA==
X-Google-Smtp-Source: ABdhPJw3trgXDWllXxGy1JoDZH3wE9xW4iqWx2ovHQTBxpvdxxh5cd+iR9uEVV6OLiAVLo9AVVs1Ag==
X-Received: by 2002:a05:622a:3cf:: with SMTP id k15mr27876605qtx.282.1617130470843;
        Tue, 30 Mar 2021 11:54:30 -0700 (PDT)
Received: from [172.17.0.2] ([40.70.242.180])
        by smtp.gmail.com with ESMTPSA id n140sm16196838qka.124.2021.03.30.11.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 11:54:30 -0700 (PDT)
Message-ID: <606373e6.1c69fb81.3c9a6.4c1f@mx.google.com>
Date:   Tue, 30 Mar 2021 11:54:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7735562584340476745=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sonnysasaka@chromium.org
Subject: RE: [BlueZ] profiles/battery: Reset battery value cache on disconnect
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210330183835.17714-1-sonnysasaka@chromium.org>
References: <20210330183835.17714-1-sonnysasaka@chromium.org>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7735562584340476745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=458277

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild: Setup ELL - PASS

##############################
Test: CheckBuild: Setup - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS

##############################
Test: CheckBuild w/external ell - PASS



---
Regards,
Linux Bluetooth


--===============7735562584340476745==--
