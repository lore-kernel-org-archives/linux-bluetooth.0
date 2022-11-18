Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24265C43217
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:34:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiKRGex (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:34:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241129AbiKRGeo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:34:44 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020E674CD5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:44 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id a27so2584633qtw.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sj4PAGH8D6Bk8ghBIbGfuh5jBCx915zAZaSpJfKYxkw=;
        b=izKf0QdnPXoxvop9QKRXbPJ1URd2UagcEfa4OiiGaWi4XagdYgMNtvOlIEJA9akXdL
         Dka2RV30NR1mS9ouPc4SCacx+V0okWCoU5JNZq0LLwti4HcYPUNjyZwx7iOTwuDprbV9
         G9z9hVgVLGNuW8mY2Gh/WxCILRg+SmKFqMCsysi/Wap+mM4THScJLAcgfEticpIWLeT8
         LTiMe9sKY9WeFeJTkNqQBK7iktaiDNkFMPKMiKrcNBPSg3Ap+2Yv9md4qt+F2tQaISf6
         czloDmtuh0KGQzRH2WJAlPcYTm+k+pTGs5Pq9S04QZ80OrAf6milbcNEBpBG7cvWGpoO
         OJiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sj4PAGH8D6Bk8ghBIbGfuh5jBCx915zAZaSpJfKYxkw=;
        b=SWj3wQ3zCLsYhM47V7J7dNH837imEyroLYCdUzCreE8xzIXZaVkkdvfATnz1pII1NZ
         5qJZR+CI1Qo9st1Lj5wpiuqZSyeoi1flXqwGOFd9kaaFPPsWLphsDrzTmGVtfOaAHgQt
         qPKkzoYajnrYeg52jrpU3aP3o7lRStnUDL8YM6Jpw+UGcUH8qGP5zxf52DISbLhu/ofk
         Lv39AZAd6P4vMkMaaSJDWqocKg2JP2Av8IOFjxETsxvLgmtTSKdgIPPd38yF614ivZVZ
         LrEN5LLLEOpfp2PfEBmN60DO4mBOufik3EOAQkA0fpZ7Ig5hEzDB2CFRG+MxlZztDOus
         Kf1A==
X-Gm-Message-State: ANoB5plVV1nj/qi2uyiqo0N3pY43Z/6rGjeHwHl3tlu+hnzl8+wOR/xe
        HzQfxDZMwUyRN+/RACVWYzdsoXEOn+jj+w==
X-Google-Smtp-Source: AA0mqf4vZRrtlCFlHvEnxvblnZmN+rJW5a6qvjh25ETAapzPELp5HeARfQXg+bTuEkO/VqkfQ/dLrg==
X-Received: by 2002:ac8:44b5:0:b0:3a4:e32b:2f7e with SMTP id a21-20020ac844b5000000b003a4e32b2f7emr5447360qto.320.1668753283081;
        Thu, 17 Nov 2022 22:34:43 -0800 (PST)
Received: from [172.17.0.2] ([20.7.154.51])
        by smtp.gmail.com with ESMTPSA id i23-20020ac87657000000b0038d9555b580sm1551899qtr.44.2022.11.17.22.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:34:42 -0800 (PST)
Message-ID: <63772782.c80a0220.d8a91.7fea@mx.google.com>
Date:   Thu, 17 Nov 2022 22:34:42 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2472426396744446584=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v1,1/2] bluetooth: Remove codec id field in vendor codec definition
In-Reply-To: <20221104071810.22720-1-kiran.k@intel.com>
References: <20221104071810.22720-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2472426396744446584==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691972

---Test result---

Test Summary:
CheckPatch                    PASS      1.49 seconds
GitLint                       PASS      0.70 seconds
SubjectPrefix                 FAIL      0.43 seconds
BuildKernel                   PASS      34.98 seconds
BuildKernel32                 PASS      30.76 seconds
TestRunnerSetup               PASS      432.61 seconds
TestRunner_l2cap-tester       PASS      15.77 seconds
TestRunner_iso-tester         PASS      15.47 seconds
TestRunner_bnep-tester        PASS      5.34 seconds
TestRunner_mgmt-tester        PASS      108.91 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      8.67 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        PASS      6.78 seconds
TestRunner_smp-tester         PASS      8.48 seconds
TestRunner_userchan-tester    PASS      5.66 seconds
IncrementalBuild              PASS      38.60 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============2472426396744446584==--
