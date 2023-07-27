Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8ABFC001E0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 Jul 2023 05:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232274AbjG0Fid (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jul 2023 01:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232359AbjG0FiF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jul 2023 01:38:05 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5835BF
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 22:37:18 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6bb0cadd3ccso490543a34.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Jul 2023 22:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690436171; x=1691040971;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns3Nv3ytgyfDKxEMvh8kXMMW25LYN7Nf/tl0mB0i3jE=;
        b=UyVLLLWzTxY+lj3C+2VxAWf88vqRU+k1LQF6W6N5KwV/kKonGZf8OLDksJXjsrXKkW
         9QfU/xBNTG5HTxn5GnCqgatu1XILeXuAkdXEknMN5sezMEutZsh5M3uYGjzIKrtvoTW7
         BZFB1q2R0LWiAES8RvJLqGd4RwMGaDLBs1l/SdQTH/23gRMKn38XSgJjnhy4xPwzOWzH
         5zuXNbAhMVqNfa+NGpap8PPgRuE29dIMiN8HlXUGcQxB7XBJGy62LaUpj4GAYNoXCtbb
         klh13yEIKuwdRheKkzXLyu0KC6AHQUuAgFakY02EMw0EA/9gWbNAHqYnvKpEBgTlz82u
         FzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690436171; x=1691040971;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ns3Nv3ytgyfDKxEMvh8kXMMW25LYN7Nf/tl0mB0i3jE=;
        b=BRGqraqMunBq4NWcGFwSgwpOSL0UStGuBjryIN7rLAI8KG/4KgdXytVPsZmrqvxezm
         YSbAUImKhPcS/uI/qFrdOCDawuTzKgtBIDAtPlTDf9m5t1niGxTYF3cdX+TAbBV0I+0E
         wz2ycagFEL4n65G8muDzRjt/a7cssCNk+2SN/oGH4qkhRcyj5KijPhqBKylTxG7Sz8Uc
         FK1EWCSG8goTg1aleabojlZLUrwb/P2+iNrUT5njImIVZohl7bzyqMruHCpNzceO/HOw
         Xr8DZeSUzXM57x9m2O83T1XlUqrtqv16tSWb0vxl8nsPXee8umcW0mtsfdkKSX9lfwYX
         9lsw==
X-Gm-Message-State: ABy/qLZIr0TcxGZX6IReQgY0GFo4VRdDY8IWbnYBLAxRbRmgEBtdMOCu
        GBiGwfGJ4F2HaVJ+2O/Wprf9ENUG8qI=
X-Google-Smtp-Source: APBJJlEcdAfiJy3xmu3+7Mnt/k6XgiKFRiwExGVFgnlFlb+yAZOJcHG/mAKmTNO2yt5C2ndahguvNg==
X-Received: by 2002:a05:6830:22db:b0:6b9:b1a7:1f92 with SMTP id q27-20020a05683022db00b006b9b1a71f92mr4734887otc.8.1690436171567;
        Wed, 26 Jul 2023 22:36:11 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.171.29])
        by smtp.gmail.com with ESMTPSA id do23-20020a0568300e1700b006b9a9bc7773sm355220otb.56.2023.07.26.22.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 22:36:11 -0700 (PDT)
Message-ID: <64c2024b.050a0220.4998d.1ccc@mx.google.com>
Date:   Wed, 26 Jul 2023 22:36:11 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4999710946965341010=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_tjiang@quicinc.com
Subject: RE: Bluetooth: hci_qca: Add support for Qualcomm Bluetooth SoC QCA2066
In-Reply-To: <20230727044011.965205-2-quic_tjiang@quicinc.com>
References: <20230727044011.965205-2-quic_tjiang@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4999710946965341010==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=769935

---Test result---

Test Summary:
CheckPatch                    PASS      1.65 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      34.31 seconds
CheckAllWarning               PASS      37.18 seconds
CheckSparse                   PASS      42.75 seconds
CheckSmatch                   PASS      114.13 seconds
BuildKernel32                 PASS      33.11 seconds
TestRunnerSetup               PASS      500.76 seconds
TestRunner_l2cap-tester       PASS      23.65 seconds
TestRunner_iso-tester         PASS      43.09 seconds
TestRunner_bnep-tester        PASS      10.88 seconds
TestRunner_mgmt-tester        PASS      223.21 seconds
TestRunner_rfcomm-tester      PASS      16.32 seconds
TestRunner_sco-tester         PASS      17.24 seconds
TestRunner_ioctl-tester       PASS      18.42 seconds
TestRunner_mesh-tester        PASS      13.68 seconds
TestRunner_smp-tester         PASS      14.57 seconds
TestRunner_userchan-tester    PASS      11.33 seconds
IncrementalBuild              PASS      36.64 seconds



---
Regards,
Linux Bluetooth


--===============4999710946965341010==--
