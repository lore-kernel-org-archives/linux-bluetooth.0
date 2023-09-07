Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48979EC8742
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 17:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbjIGRhE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 13:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241245AbjIGRhD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 13:37:03 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A53D10F6
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 10:36:36 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-76d9023c942so69832285a.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 10:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694108160; x=1694712960; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fdFyJtkCkLQ8Rqirx1Erw/MCqbSnf/TfcTW99NLuOP0=;
        b=kEegExx2ld9yIX9VAJneGh+ZEu8OZmDwnwiTl9oxNmqMUF4NwJk+wjlA7kx7vu45/w
         Xnep9Gw6aVjr1DSHTUj9uCQdW8ujz5udw4LuiEOXyapFwTUlTFDxqQMEjACGAgOXHKMp
         KdxYaIpfIRYZtiUMElDnda5zMlwv4qsesicY8XW2g7MnPJ8hqlSm8LV7gJ8yqMqrbFHF
         MnvRkaTwvZydAtSv+xh+HRPeGW/y5IyEWdh0kI1F2FvEunttAEG73ZXdBmN7ZCUhx+AR
         sWd22rWwqTgMoG1eAEaUZtDb+rgopG7h8ay3u8z7YyA2hXQQ52BNI9QlnU2f2U3XGa/4
         bRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694108160; x=1694712960;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdFyJtkCkLQ8Rqirx1Erw/MCqbSnf/TfcTW99NLuOP0=;
        b=Pkw9OBoDHvRod9HO41gzMT5QQIEWZ+tuDqthUZEhur543ZihqPjWVKZgWGJM7qFmY/
         0t5dnCzyWtKQS6FiQYg+5zbw8uk9MobaUmYlj2t89uvmB2aLgE6wpuJF/eVqwzqwFbOl
         kexE3XahxAnbW1E7kW+0MGtLNWwTPp660AR31IXnsgX/ip2d9YgJkvsuGOEDvjgkHg8r
         o4iWG5PtCP1KEXXM2eDFRcyfSHszRHT8dHrSOxoi6TwApB8cBBLhCrXThvUTqrGXYHV+
         1R2xBNLCQB5aY2zpX6wH45oA3dKW5c7lcEsFYP3SktopvExp2ifFK+u73x4VLuV//dyx
         MyvA==
X-Gm-Message-State: AOJu0Yx2UCXIFPNvpesOApJxrYGt2lXbrek6VuLVw1RpeqLvnu2j78lZ
        IEaq7vnJk3gxTEutPf6/phKCbVn3oQ54bQ==
X-Google-Smtp-Source: AGHT+IEr+Bo512IoMSu510pCv1WyVS55wAlvC69eboC6WBVF2RuYkBf3G1P2r8dpmNOh4pPm2DhHIQ==
X-Received: by 2002:a05:620a:c50:b0:76e:ff2e:44c5 with SMTP id u16-20020a05620a0c5000b0076eff2e44c5mr218210qki.37.1694108160303;
        Thu, 07 Sep 2023 10:36:00 -0700 (PDT)
Received: from [172.17.0.2] ([20.39.62.114])
        by smtp.gmail.com with ESMTPSA id s1-20020ae9f701000000b0076d25b11b62sm5958886qkg.38.2023.09.07.10.36.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 10:36:00 -0700 (PDT)
Message-ID: <64fa0a00.e90a0220.af582.6843@mx.google.com>
Date:   Thu, 07 Sep 2023 10:36:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3820332049206377963=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [v3] Bluetooth: Add support for Intel Misty Peak - 8087:0038
In-Reply-To: <20230907091550.1957138-1-kiran.k@intel.com>
References: <20230907091550.1957138-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3820332049206377963==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782271

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      33.59 seconds
CheckAllWarning               PASS      36.12 seconds
CheckSparse                   PASS      41.67 seconds
CheckSmatch                   PASS      113.38 seconds
BuildKernel32                 PASS      32.32 seconds
TestRunnerSetup               PASS      490.09 seconds
TestRunner_l2cap-tester       PASS      28.24 seconds
TestRunner_iso-tester         PASS      51.77 seconds
TestRunner_bnep-tester        PASS      11.12 seconds
TestRunner_mgmt-tester        PASS      222.44 seconds
TestRunner_rfcomm-tester      PASS      16.88 seconds
TestRunner_sco-tester         PASS      20.05 seconds
TestRunner_ioctl-tester       PASS      18.75 seconds
TestRunner_mesh-tester        PASS      14.05 seconds
TestRunner_smp-tester         PASS      14.98 seconds
TestRunner_userchan-tester    PASS      11.70 seconds
IncrementalBuild              PASS      30.42 seconds



---
Regards,
Linux Bluetooth


--===============3820332049206377963==--
