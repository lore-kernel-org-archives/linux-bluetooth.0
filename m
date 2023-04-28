Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 755A5C77B61
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Apr 2023 03:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344817AbjD1DO2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Apr 2023 23:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344642AbjD1DOZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Apr 2023 23:14:25 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0962EE75
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 20:14:24 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38e7ce73ca0so5154784b6e.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Apr 2023 20:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682651663; x=1685243663;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RMiYmztSue7YPhXlh1qHdJpIYyEYeSeMPYmEE+8TINY=;
        b=sX1iJx5ZsfkII0yyCspYDdO1ZUxi6UPpPUU1GLvbbsCqdF5xwhxio+VE9//1shzJOy
         dadGBgZ3c2ICLDMoOccCVGEr4py6cMKYKVbLRlkx3HTu8mty6EL23QF49Zt/gwEer7sS
         fdthazlb10G6GtKDx97oYFZFmck4l8DyKla08McBdELvbkRKfzbMOOnucEVIiVOLQXtg
         3gbyHu7e3Drmf9bIuBS7c06cznlTr3yHhdJwcouLpoHb3/2D261JBrqouruQMen24DoX
         KJLjKIDj0gqBCPg8dCHMC5G0JWeZ2gBQSvnFmyWQlVQoafSrNdMfsguT7ZnUnP19OcVH
         bxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682651663; x=1685243663;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMiYmztSue7YPhXlh1qHdJpIYyEYeSeMPYmEE+8TINY=;
        b=Fx8q/bI/hk9ckk+xkcs35wQMjVOf3vi2FE8ox7W+FrxMTcygqj5M2otJJ2RxenJfzc
         yNbXGdKvdFPddMZnpTSprDaC5IkWadRdmtvhrC30QCYCOR4WwhzHE2LKAeEuRphY2gDV
         hzzjIaAe3EZHibkKumscusOuFNIL5hfoT2Av3sdYl9AmDTH70lWFaKV2FEftAuEHj52/
         Iq9iG3vqoxHSzuwxqG8dun/Lhru2jo6toCIC5UhV0e/cD8IWtxqTO1JF9PovV3tJOeVL
         8EBMpykWSDD4gXhSo4v2cSyVeIe+OmPy+yr4cWHEKtxpgHpNArs0M//dG0BSSaj42X6G
         wjmQ==
X-Gm-Message-State: AC+VfDz5sxq69y7HNBPmqv3+EdER7KXUYgRxqUQBqW4QSZ1KaiEE1UEJ
        ZxeI0utZfwqQ7j/CNl+F7ZoPHphDV1U=
X-Google-Smtp-Source: ACHHUZ7UHyYQNnfgieOkSBi9kQwlCjsfeG9njsMAv+LSqrqxpbzlZNklZEvbJiNiAzdx/3SK9Bj/Ew==
X-Received: by 2002:a05:6808:3bb:b0:38e:76c8:39b with SMTP id n27-20020a05680803bb00b0038e76c8039bmr1966804oie.0.1682651663113;
        Thu, 27 Apr 2023 20:14:23 -0700 (PDT)
Received: from [172.17.0.2] ([70.37.167.49])
        by smtp.gmail.com with ESMTPSA id v132-20020acade8a000000b00383eaf88e75sm8488144oig.39.2023.04.27.20.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 20:14:22 -0700 (PDT)
Message-ID: <644b3a0e.ca0a0220.f1ba5.9942@mx.google.com>
Date:   Thu, 27 Apr 2023 20:14:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1810571956217509093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [BlueZ,v3,1/9] media: Fix not storing Preferred Delay properly
In-Reply-To: <20230427231352.576337-1-luiz.dentz@gmail.com>
References: <20230427231352.576337-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1810571956217509093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=743695

---Test result---

Test Summary:
CheckPatch                    PASS      5.30 seconds
GitLint                       PASS      2.94 seconds
BuildEll                      PASS      35.05 seconds
BluezMake                     PASS      1231.46 seconds
MakeCheck                     PASS      12.85 seconds
MakeDistcheck                 PASS      200.13 seconds
CheckValgrind                 PASS      330.53 seconds
CheckSmatch                   PASS      463.36 seconds
bluezmakeextell               PASS      135.14 seconds
IncrementalBuild              PASS      9235.45 seconds
ScanBuild                     PASS      1336.67 seconds



---
Regards,
Linux Bluetooth


--===============1810571956217509093==--
