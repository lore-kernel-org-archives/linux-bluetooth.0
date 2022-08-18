Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE057C00140
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 Aug 2022 22:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344694AbiHRWBS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 Aug 2022 18:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243593AbiHRWBO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 Aug 2022 18:01:14 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD3AD1E1A
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 15:01:14 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id c9so1027070qkk.6
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Aug 2022 15:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=3fSzFOu9W3yGA9qiG6X05K/3a9VVZPIabE5qL764QxM=;
        b=bcUg5KxlPjgn0xoRXVY9Jr6Y9c0/NZXuY9F+9AYJS7D7sMovKjpPaWvV0yEu4DAlBy
         /KjM6wKA4ziKEdVnZHXIOI3kDbsjJcs7vPklloxPj4LjjGVa/xfdTZqQqKT44RdcbB8K
         MlR+eALiAiHIAIDDR+s8jIuxiOi9JuDgYtZi4YWe9teat2dMmkAz5JrMst9rissgxZUm
         5dhP/XMf13tqReSFkCMh7IdKeflQPzo5PXYxF0Y8c7EPxGIy73rOHuMOhYaG72DO7OXL
         5GpfPtfjO6H5e70Mvm5u22uDkuWVZ0fNIhMSkm8QHGwRRbyzkNnujiZaBbx3UtVE6fn4
         zGPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3fSzFOu9W3yGA9qiG6X05K/3a9VVZPIabE5qL764QxM=;
        b=ZsNS83IIWO/01eLSVleHkqGfVCPN5stSLFOxA7BFfukmHGjetmb47NvwP/zCluXIab
         elwvJBFbVjzNPvRenob1icm4H5vS0GU03Kk/6hK3SLZz8BYye4K+uyQAOq/TzEFn/RAQ
         QI+vkL0XLhCC+J1KPx2muozgin9I+s8lgOVpj8wppxF3yOEjjQRRI9/WApb2+h5qwgiR
         NaTkAFmsYXsgU3YP8xHM28uXpoG4NXTy/3XGD0GlSH9zyEHzYbVsHKmAc7PcgooBCgN4
         JTJi5JOs9EAIiCui+GeUTQPzIskkbo0Auv/KZ4LcoQzs0UTdxP2WMgUuDTRCrvBhoZ/J
         ay0Q==
X-Gm-Message-State: ACgBeo1VS+pGgoqm+bDF9CwlxeUlEVMYn3WOyJmRTi8CvLjF2/iUGjgw
        RrIT6x1MNCEPDlzMREmD/AyaDF2ieC5itA==
X-Google-Smtp-Source: AA6agR6ZhYqFRdVZni6BtUU3DU8BnjGj0ocjW2PprTxZO79rJkxUYE2rreSlk3mSvVs4j3Y/np0Paw==
X-Received: by 2002:a05:620a:2994:b0:6bb:4692:2406 with SMTP id r20-20020a05620a299400b006bb46922406mr3657919qkp.9.1660860073129;
        Thu, 18 Aug 2022 15:01:13 -0700 (PDT)
Received: from [172.17.0.2] ([20.62.122.72])
        by smtp.gmail.com with ESMTPSA id i12-20020ac85c0c000000b0031eb393aa45sm1867673qti.40.2022.08.18.15.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 15:01:12 -0700 (PDT)
Message-ID: <62feb6a8.c80a0220.d0075.5df0@mx.google.com>
Date:   Thu, 18 Aug 2022 15:01:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3741144773825880577=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wsa+renesas@sang-engineering.com
Subject: RE: Bluetooth: move from strlcpy with unused retval to strscpy
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220818210207.8323-1-wsa+renesas@sang-engineering.com>
References: <20220818210207.8323-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3741144773825880577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=668973

---Test result---

Test Summary:
CheckPatch                    PASS      1.57 seconds
GitLint                       FAIL      0.97 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      33.52 seconds
BuildKernel32                 PASS      29.27 seconds
Incremental Build with patchesPASS      42.62 seconds
TestRunner: Setup             PASS      488.32 seconds
TestRunner: l2cap-tester      PASS      17.56 seconds
TestRunner: bnep-tester       PASS      6.84 seconds
TestRunner: mgmt-tester       PASS      104.32 seconds
TestRunner: rfcomm-tester     PASS      10.07 seconds
TestRunner: sco-tester        PASS      9.98 seconds
TestRunner: smp-tester        PASS      9.98 seconds
TestRunner: userchan-tester   PASS      6.99 seconds

Details
##############################
Test: GitLint - FAIL - 0.97 seconds
Run gitlint with rule in .gitlint
Bluetooth: move from strlcpy with unused retval to strscpy
7: B1 Line exceeds max length (99>80): "Link: https://lore.kernel.org/r/CAHk-=wgfRnXz0W3D37d01q3JFkr_i_uTL=V6A6G1oUZcprmknw@mail.gmail.com/"




---
Regards,
Linux Bluetooth


--===============3741144773825880577==--
