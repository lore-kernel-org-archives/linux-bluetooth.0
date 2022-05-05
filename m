Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77AF2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 21:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349431AbiEEVP4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 17:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiEEVPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 17:15:55 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D9B53709
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 14:12:15 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id w3so4118502qkb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 14:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Eti6FCKeTb/6cQpLMdwlH52Q4U0zmaIQYXg2w+TW9A0=;
        b=lNzou+UtknSjDxCZfDfHJiD/g0Z9rOEDWX4pz++yUM02+1IujhqGKyhZIuzA5Gsyya
         mrgnP0Dmr/Qh9sXD9kYRnO2KQI1m/qoa9CkWNvtzrnFmfjMkP8QEAyghqFm+xrR32hsX
         K1oCA13cplyDhcPIP2QWoYPgU6DvHHBEmrZqTmNFrXADrhgrXP5PTfhukLT7hceMQiTz
         Y/MKFYMTXIQZ4ASOODisbk5Z6aS/Z0r/O0jaisboPBxb227zKbxd+fFyfbHfaUNMbI2d
         g0li6IuheC5BSOvrJNMKl2S3k2rY5j73U+4PveRhcXibFGnbgAHhc7wUT9a7NqBqNz4F
         WUCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Eti6FCKeTb/6cQpLMdwlH52Q4U0zmaIQYXg2w+TW9A0=;
        b=WETDfElFUCD/ff+uPdjwXpm9LxHEmsQnahSPcLqNzK3rPcL564YXV/78EReS2H1E6a
         wqKYMnNFRHM9E/NGtfLL1Ok26wY1GoDrp1TgevJCv4A5d+CjLwOQrhfs5kQ3mzUblxq9
         971DGPXRgQ26tUKtGGhdIfoDaLOTOgTwbLlUw9hqqZYwr3hzBwqnmNbyQ18/nJmmNbJg
         SbakjvMzElDcCkQztAeTnO//sdL06/gat7VcxprIT3P9F0PuHAPzXBk5zWknLKHqufHZ
         7fEswuIQuHOdlDjABcW/mUOV6v2BjM0pWwTLV42rXjiJYK5LFltz3U4kVolZYSKV81ub
         Ue5w==
X-Gm-Message-State: AOAM532cWyVSdR2VFExiBQT66AFpoU0Umsawrv8vIZ/kLfGt94PE7JNC
        k3kE9wPg578/id13xja2X3TQ6hFJPsylQw==
X-Google-Smtp-Source: ABdhPJwWzIyYcjxknOFT8cN3tScPmy9I3cSTScybM/wnAgNsuQ43uC4uZlRu2QF5DW8RiOCoxUMYRQ==
X-Received: by 2002:a05:620a:1929:b0:69f:4378:f94e with SMTP id bj41-20020a05620a192900b0069f4378f94emr220319qkb.47.1651785133606;
        Thu, 05 May 2022 14:12:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.167.60.43])
        by smtp.gmail.com with ESMTPSA id z6-20020ac84546000000b002f39b99f6b4sm1430732qtn.78.2022.05.05.14.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 14:12:13 -0700 (PDT)
Message-ID: <62743dad.1c69fb81.94594.8204@mx.google.com>
Date:   Thu, 05 May 2022 14:12:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1452702257090552402=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tharvey@gateworks.com
Subject: RE: Bluetooth: btbcm: Add entry for BCM4373A0 UART Bluetooth
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220505195010.31329-1-tharvey@gateworks.com>
References: <20220505195010.31329-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1452702257090552402==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=638873

---Test result---

Test Summary:
CheckPatch                    PASS      1.58 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      31.53 seconds
BuildKernel32                 PASS      27.98 seconds
Incremental Build with patchesPASS      37.93 seconds
TestRunner: Setup             PASS      468.04 seconds
TestRunner: l2cap-tester      PASS      17.14 seconds
TestRunner: bnep-tester       PASS      6.10 seconds
TestRunner: mgmt-tester       PASS      101.18 seconds
TestRunner: rfcomm-tester     PASS      9.68 seconds
TestRunner: sco-tester        PASS      9.34 seconds
TestRunner: smp-tester        PASS      9.47 seconds
TestRunner: userchan-tester   PASS      6.33 seconds



---
Regards,
Linux Bluetooth


--===============1452702257090552402==--
