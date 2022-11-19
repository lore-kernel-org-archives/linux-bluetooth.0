Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D8EC4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:32:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiKSFcI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSFcH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:32:07 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB85A6711B
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:32:05 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l2so4436745qtq.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=TTTsuF/xIXYf6mJXwY7rUXCPfCTL4sGI6/l3k4/af+Y=;
        b=QZcvqdILP5c4POvIhhnc4vqAXmeQ8srIoWTtfhmnW7qjw+CFX+TD/Qj8Zsvwi5TmvA
         jiHmfLxSS67E1CZU7oMRlobi3i4K147013t25cgGvptU9m73O+YTGK6mJSwsrONibj+w
         JDilTw3wqk0N+kW2HzPODfQh6xBrD49FO43irbwEgH3g7TqNBEh9e0CdShoZkCPeEPnE
         Q908EagmvBFmCU7FlGFy5R7jHYrvxag0NnHjEqbA4Rs0LUcNSEzTcoJ/szvm5S+Tv164
         QtgKP3Tjm52sLXZFcIFCgf9/EYg0/qvfJ7LNvki8zZnSBy/Xd+Qup+ENTO7axIILOoqI
         VZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TTTsuF/xIXYf6mJXwY7rUXCPfCTL4sGI6/l3k4/af+Y=;
        b=SH2h5xOdiczJpK8jbjFIFtt+j9Iy+liuUUieyAqExrnzngFSzDywVGBgNa0zIoYPPg
         hJvTdMF3alN0HNJ/qWSB+eOpw7NMYOGTY1OlWOypTIBmYCIYh+XToktC1St+qIvA4r4h
         bxOR5wfBz4nP9Los3BVDwSwxJTdODcD3+vsPY2u79tJTdev2oaRSuAWeXnYBf/MHekjo
         NJ8lrxxWMBb/ACcHVOLH8gvM6EbLxHS1WYccojEj7reW6kLYbRyzM+WDGjNObEprERg7
         LVcLdsJNGcPUYKp8+OFmXrb8TmAqYzJpTCgoxmfio8q7RqD/hLkMpx3ZcFhiV38rdMEs
         BAdw==
X-Gm-Message-State: ANoB5plBC7TT2YoXCjPNnTKtu7Jigqv0ouqBHEsBUhmqVE/S8IteD6Zv
        CFc9n1Z0Uw/QHCQ3u33o/KWdkXxr+P1XQA==
X-Google-Smtp-Source: AA0mqf6M1liZRkGU+McRZoqSUyzxutL/muXEmFpKJrf4UYy5qEygsIcXZ4NaF5T983SKvURtsgA/+Q==
X-Received: by 2002:ac8:4e0a:0:b0:3a5:3134:cc67 with SMTP id c10-20020ac84e0a000000b003a53134cc67mr9678208qtw.475.1668835925008;
        Fri, 18 Nov 2022 21:32:05 -0800 (PST)
Received: from [172.17.0.2] ([23.96.81.116])
        by smtp.gmail.com with ESMTPSA id s19-20020a05620a29d300b006cfc9846594sm3959286qkp.93.2022.11.18.21.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:32:04 -0800 (PST)
Message-ID: <63786a54.050a0220.e8c8b.24d7@mx.google.com>
Date:   Fri, 18 Nov 2022 21:32:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8947577419809978096=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8947577419809978096==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.39 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      41.91 seconds
BuildKernel32                 PASS      36.92 seconds
TestRunnerSetup               PASS      512.21 seconds
TestRunner_l2cap-tester       PASS      18.61 seconds
TestRunner_iso-tester         PASS      18.91 seconds
TestRunner_bnep-tester        PASS      6.83 seconds
TestRunner_mgmt-tester        PASS      123.42 seconds
TestRunner_rfcomm-tester      PASS      11.42 seconds
TestRunner_sco-tester         PASS      10.99 seconds
TestRunner_ioctl-tester       PASS      11.99 seconds
TestRunner_mesh-tester        PASS      8.55 seconds
TestRunner_smp-tester         PASS      10.39 seconds
TestRunner_userchan-tester    PASS      7.01 seconds
IncrementalBuild              PASS      39.21 seconds



---
Regards,
Linux Bluetooth


--===============8947577419809978096==--
