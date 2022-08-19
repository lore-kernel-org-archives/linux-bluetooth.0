Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFBCC32771
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Aug 2022 19:13:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349895AbiHSTNA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349775AbiHSTM7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Aug 2022 15:12:59 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5510B538
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 12:12:57 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id 10so4015498iou.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 19 Aug 2022 12:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=3Kd38tI9Gopb0klFcMAiQHKb9Nv4Dbu5IhLuz9fZjI0=;
        b=YRWALYiAt5/DQuDu3PMG5jWSoywg7UoTFEDb+TvS8zmARmQxscOdPXBuvBbQR+U9RK
         k2wxMhG4s5MVEoSUbAKyeWbDGDeSGDu7aF5Ejab8N/VR0Tn+SOAvwraK0D3jrCb+e+B4
         FFKsKWJ6aEtyZJcCn7SO6x0zxnUXUVElJtBg942J/5cn8rkINKghENUmRb+ZOSjik5af
         6997R4RVer7gZmG04daGCti+ffftqOTKW60COAjT3MuKKizQs2DzHbUwuuhAeXF1lbaa
         AQF/iXzqYTIV8vYXOt8zPB3MpCZ65rALsjRMIwnIHkHNoWhowvwXdXEWOQss+C8wawqC
         81zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=3Kd38tI9Gopb0klFcMAiQHKb9Nv4Dbu5IhLuz9fZjI0=;
        b=cVjn3eBcoSUaD7gXG3mAXAmmFMKE6LBVc0s3rRn+It8SkrwZFK3+ugbNL1Js/TxD7O
         /cI82LE5NHON4aG6k+Stlf8aS/36aqvDSFu/n4hIhGB8yCXWF44m8jB4vU5kq0Wlw5IL
         2jb8qXuGQ0/M1E8EPnSlwUk0evTQQ3qye5IjZ6NX6/vlJZ720TOenkuNqC/elHbkz6Rj
         Jmrnn04PcvnkzsJPjmNheFyzIzpfLJ5E+RDuayvNc5qA6wR1INzwmZc3Y0N01q+ZNeDS
         IQoc8Wj5GuYAwVwYDXF6gVHZEQ6nIUxErwXJ8jbw4etHlHD0NabdjBwYXSwcEv+3/VPa
         ReVA==
X-Gm-Message-State: ACgBeo2JCEtuHz2SRueri9irXJDEiMs0/p7g2NQweVHKPLBe+gVwYKAO
        wBPXR+r9hFcYNXjiGa/G+X7e4vTNj5k=
X-Google-Smtp-Source: AA6agR59z14yKi5DNE3FCJJcbuQT56V3LdQiXsBoL13zoeI6P7wU7tUG8KMPo3I+iIJHOpOwaWdT8w==
X-Received: by 2002:a05:6638:12c9:b0:343:5dee:27dc with SMTP id v9-20020a05663812c900b003435dee27dcmr4295731jas.309.1660936376369;
        Fri, 19 Aug 2022 12:12:56 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.179.29])
        by smtp.gmail.com with ESMTPSA id x5-20020a029705000000b0034783965634sm1652157jai.136.2022.08.19.12.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 12:12:56 -0700 (PDT)
Message-ID: <62ffe0b8.020a0220.c8c65.2f7f@mx.google.com>
Date:   Fri, 19 Aug 2022 12:12:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1302338617596719492=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix not handling shutdown condition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220819184633.19437-1-luiz.dentz@gmail.com>
References: <20220819184633.19437-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1302338617596719492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=669308

---Test result---

Test Summary:
CheckPatch                    FAIL      1.87 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.74 seconds
BuildKernel                   PASS      32.56 seconds
BuildKernel32                 PASS      28.57 seconds
Incremental Build with patchesPASS      42.90 seconds
TestRunner: Setup             PASS      478.43 seconds
TestRunner: l2cap-tester      PASS      16.66 seconds
TestRunner: bnep-tester       PASS      6.19 seconds
TestRunner: mgmt-tester       PASS      98.28 seconds
TestRunner: rfcomm-tester     PASS      9.50 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.25 seconds
TestRunner: userchan-tester   PASS      6.44 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.87 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: ISO: Fix not handling shutdown condition\WARNING:TYPO_SPELLING: 'immediatelly' may be misspelled - perhaps 'immediately'?
#82: 
that would result in poll to immediatelly report EPOLLHUP instead of
                             ^^^^^^^^^^^^

total: 0 errors, 1 warnings, 0 checks, 41 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12949086.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1302338617596719492==--
