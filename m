Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C51CC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 07:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234786AbiKRHH4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 02:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiKRHHz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 02:07:55 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BBC5D689
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:07:54 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id w4so2666261qts.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 23:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=NO8dmI5qcxpNPX3QsPND8XVTJg6Nl9EEnPc6W5ZlrT8=;
        b=qRyh56+9h1J8lYBhpTNnOtNlQaxoxveERs9a4urUD1eby+wUl6FEl7a+u8m54xvqF5
         2yYnmC6jcWYYnc31Whzx73FfnxF6YCXBDs/fzP4PDcUiuABfMbNfoC+XPsffteLBfRt+
         eGrRlC4PtYgxbWJR+6SH8xvf4PFOgj0SXb/XOmQyxVwNnrJKhwqz4mK//afkJ7jzIpJ2
         qToJ5rZmez1VQPzlyHRVWUpDS1NLj9nOfg66OMAE4I83DAXwBOF+q/jSn1yaztK3/8pP
         8wHvKqh8i7xQA+hUKJ3NY/rrNydYLOa/sYDst+LcspS3uG8CvssHT04Z9yVbf+y5R9aI
         elNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NO8dmI5qcxpNPX3QsPND8XVTJg6Nl9EEnPc6W5ZlrT8=;
        b=flOKHzhjotHQgnYqg+NeDPLvUD7/KyI/44zI2TKs/Mb6MiMZS6uMc30sJgNspzV3fb
         4ey0CJydIt12+X4iGADJvowoCHbjTBx8erjEx1soA+K+VO/9YhyPocDiB7byLiZWz1H3
         TH74e5Yyv53+LgGdRS9rsrWuSWDpoQMkPtLGqvRPwL4WcSsfJjG3LPjXM5sLrRyDnDcm
         eEwVRhus+1cPco/jPxtTwNIoqQhUHMXE4hOguCKqwNp0OKbRW388dNQwGBHXgq2Gz03q
         ptbFSeSmmst+JhNSyK/7ij3lgctCt5S0Y2vnr61wGtp7x3CAA+yUKYK3Lak1CeG3Bk3G
         NcOg==
X-Gm-Message-State: ANoB5pmuZQp/5AsU/m2tW5D51UWEfOpRlstS1+qI/usgFGm4ffH+wpRD
        61l6646ARdQvtLGCUFNHLDVKfPPkKfQEew==
X-Google-Smtp-Source: AA0mqf49etfmhE+aYwec340USaRBMpXuG0yg520szCYesmQRkxDWbnZQiYSt4z8YbqOsV+iSUisciQ==
X-Received: by 2002:ac8:5986:0:b0:3a5:1ab4:7817 with SMTP id e6-20020ac85986000000b003a51ab47817mr5536745qte.628.1668755273342;
        Thu, 17 Nov 2022 23:07:53 -0800 (PST)
Received: from [172.17.0.2] ([4.227.251.125])
        by smtp.gmail.com with ESMTPSA id cf11-20020a05622a400b00b0039ee562799csm1589521qtb.59.2022.11.17.23.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 23:07:53 -0800 (PST)
Message-ID: <63772f49.050a0220.114cc.7b67@mx.google.com>
Date:   Thu, 17 Nov 2022 23:07:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3531087074020266784=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: hci_event: handling CIS QoS
In-Reply-To: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
References: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3531087074020266784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696036

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.37 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      46.01 seconds
BuildKernel32                 PASS      40.41 seconds
TestRunnerSetup               PASS      574.85 seconds
TestRunner_l2cap-tester       PASS      19.84 seconds
TestRunner_iso-tester         FAIL      22.36 seconds
TestRunner_bnep-tester        PASS      7.26 seconds
TestRunner_mgmt-tester        PASS      137.53 seconds
TestRunner_rfcomm-tester      PASS      12.26 seconds
TestRunner_sco-tester         PASS      11.39 seconds
TestRunner_ioctl-tester       PASS      13.43 seconds
TestRunner_mesh-tester        PASS      9.43 seconds
TestRunner_smp-tester         PASS      10.92 seconds
TestRunner_userchan-tester    PASS      7.34 seconds
IncrementalBuild              PASS      41.80 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 55, Passed: 11 (20.0%), Failed: 44, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       2.104 seconds
ISO QoS 8_2_1 - Success                              Failed       0.232 seconds
ISO QoS 16_1_1 - Success                             Failed       0.236 seconds
ISO QoS 16_2_1 - Success                             Failed       0.232 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.240 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.232 seconds
ISO QoS 24_1_1 - Success                             Failed       0.244 seconds
ISO QoS 24_2_1 - Success                             Failed       0.232 seconds
ISO QoS 32_1_1 - Success                             Failed       0.236 seconds
ISO QoS 32_2_1 - Success                             Failed       0.240 seconds
ISO QoS 44_1_1 - Success                             Failed       0.232 seconds
ISO QoS 44_2_1 - Success                             Failed       0.232 seconds
ISO QoS 48_1_1 - Success                             Failed       0.224 seconds
ISO QoS 48_2_1 - Success                             Failed       0.232 seconds
ISO QoS 48_3_1 - Success                             Failed       0.232 seconds
ISO QoS 48_4_1 - Success                             Failed       0.240 seconds
ISO QoS 48_5_1 - Success                             Failed       0.232 seconds
ISO QoS 48_6_1 - Success                             Failed       0.236 seconds
ISO QoS 8_1_2 - Success                              Failed       0.232 seconds
ISO QoS 8_2_2 - Success                              Failed       0.236 seconds
ISO QoS 16_1_2 - Success                             Failed       0.232 seconds
ISO QoS 16_2_2 - Success                             Failed       0.224 seconds
ISO QoS 24_1_2 - Success                             Failed       0.244 seconds
ISO QoS 24_2_2 - Success                             Failed       0.232 seconds
ISO QoS 32_1_2 - Success                             Failed       0.240 seconds
ISO QoS 32_2_2 - Success                             Failed       0.228 seconds
ISO QoS 44_1_2 - Success                             Failed       0.236 seconds
ISO QoS 44_2_2 - Success                             Failed       0.228 seconds
ISO QoS 48_1_2 - Success                             Failed       0.228 seconds
ISO QoS 48_2_2 - Success                             Failed       0.240 seconds
ISO QoS 48_3_2 - Success                             Failed       0.232 seconds
ISO QoS 48_4_2 - Success                             Failed       0.236 seconds
ISO QoS 48_5_2 - Success                             Failed       0.240 seconds
ISO QoS 48_6_2 - Success                             Failed       0.236 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.308 seconds
ISO Send - Success                                   Failed       0.244 seconds
ISO Receive - Success                                Failed       0.244 seconds
ISO Defer Send - Success                             Failed       0.244 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.244 seconds
ISO Defer Receive - Success                          Failed       0.228 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.236 seconds
ISO Send and Receive - Success                       Failed       0.240 seconds
ISO Disconnect - Success                             Failed       0.240 seconds
ISO Reconnect - Success                              Failed       0.244 seconds


---
Regards,
Linux Bluetooth


--===============3531087074020266784==--
