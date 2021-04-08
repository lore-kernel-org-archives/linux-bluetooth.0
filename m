Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD53C433B4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 19:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02BE961008
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Apr 2021 19:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbhDHTge (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbhDHTge (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Apr 2021 15:36:34 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414A7C061760
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Apr 2021 12:36:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id u8so2349597qtq.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Apr 2021 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=vOaN6y183sjiKJ7/BgerTpPdasoafFqmSv8H+tS+nKw=;
        b=QXNUFlZMuPppbDwJjzXbhc+h7xXNeX/b7sSqBLVxT0aJV+i9E4CE1ZD/th82ACUU6I
         qC09FpS+a4W3NAZFFt8ZFEKZylLrbZb0oUAoAp7YXPKw/meCqWZLG47PrX8bEYhECjfP
         yL4pPFmVMcVCGxWunilaSNXPFLsh852F6RuDi101Mi+2rpCIA4/qVbWCtWKsK3hhFEzS
         v42jYIwGkeng9+2cUR2tlHu4mRQ6BZHqSoNrBGkIv+68vJFNjJbT0vD2sJeam21KBulo
         ss+WQBiDQGbW2gjnl8Dd/+MCxYn1WGv5w10ETbtH2gCaAriNxHCGziWOzhvB3s4zRMzs
         NUcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=vOaN6y183sjiKJ7/BgerTpPdasoafFqmSv8H+tS+nKw=;
        b=D9XQC196lA2QU3pZkwNalms+KZb3Gyp27uNsbkUw8KlieLZmf9vk1rhZJv+DRlzXwQ
         /258Dv6YDF8zhhZe2tr7v4xxlKzWNxmg2UHzVKc8O9m2z8LTCtfZ9xtFTxQwveyr6GZf
         96yuzANRuHpkcJqn0DvjS3jgg9En1CJrZpaa/r1mX+AMj2ZuyLl/v3YJhn2dLAo4m6tJ
         CYprvLEQe+0yELB2p9MjjXrJsx/jdCBvHwnvmk4kNG9i+X6FeO2Dg68z7ptTebaK/Ytg
         w9fK9uiugp8SbyvbVxENg7XK4romjeZ/1X8flCe6haiJkSmlEfncvvVbSwa5zzGKT3Ca
         /FIQ==
X-Gm-Message-State: AOAM532gl+6uiq3fikWKSyTYBTXcGz80CBncvwYcWxJe56jdJZTdzgBm
        +/NPs581MqFC6xdrWyky49DLaNSiEcHOrw==
X-Google-Smtp-Source: ABdhPJyuPcAAbnmgsUBzZfNwRcYg7pBKrwj3tZtsGdO1IgtKK7pPlmGS9vgHotg23Lg2yARj1AXKjA==
X-Received: by 2002:a05:622a:14c6:: with SMTP id u6mr9017324qtx.125.1617910581382;
        Thu, 08 Apr 2021 12:36:21 -0700 (PDT)
Received: from [172.17.0.2] ([52.254.23.199])
        by smtp.gmail.com with ESMTPSA id g2sm364463qtu.0.2021.04.08.12.36.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:36:21 -0700 (PDT)
Message-ID: <606f5b35.1c69fb81.6d8b8.308d@mx.google.com>
Date:   Thu, 08 Apr 2021 12:36:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7535776486551353737=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [BlueZ] mesh: Add Provisioning Confirmation validity check
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210408190928.1645427-1-brian.gix@intel.com>
References: <20210408190928.1645427-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7535776486551353737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=463665

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


--===============7535776486551353737==--
