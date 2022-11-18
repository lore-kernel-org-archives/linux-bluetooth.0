Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F71BC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240873AbiKRFaZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiKRFaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:30:24 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A8487A49
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:30:23 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id e15so2551353qts.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xeTh5MFdLmcwny8mOj347aQHSAfk+5i77ka/rxeIp7s=;
        b=Hxhkp0Wtd1rfArQDdPaYxcGBYQ1XkOZFXL7ODeerQFq0yfvWiUIXdY3eTp3KIawbG9
         Hj8aTebpPMXtoIieioCiBdeJQBPVFgU9d/l+k8Wk/RAFStq+qfWjfo4OXqJ8uVKzJkMT
         QmGCjbzEGrfCVkNOLXPAaQZfdYnk6yOVw+vLYfcPh1oGkevJQc8WkOgaBKE9HIGD3WWU
         6O09g/D79rY7cDl59C5jbV5PxbTQPBj8pkW8NuLTV+d6Z2YXWuQveZslSO64HohXLlwA
         oBcMWsdpNmfSimDYcjOu8LV9QvVQxtrJCxrcdNK3aDyjWbeU1PQtOtA6pFbaGyh52U6L
         J8Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xeTh5MFdLmcwny8mOj347aQHSAfk+5i77ka/rxeIp7s=;
        b=TZwo2XwfAgJ+rCG8XD4RlkmUi0/8SAea7DXPf+xsxmd3sOKXEGMbIJef5BkQhBcgTL
         3FlbpUqcZYJTNIlVLBP130hLgCaV3Iu8pF2P9CnYdnA+bH+fOV2I9Y/9IsuLfjKZ/lF7
         0nCFreWtJIfBj/oN5kj//4cpBw0CMTncKfN8TklNJ0Wavs7ImmznCgm/but9zcE5MIgO
         azFqV35MLVg3FakCYS9rZSDDFZBnMeWvzrVWAEGbjpfodL5QZDwd51yFdqGewGR+3P4T
         qvElOcuUz5afc1Q6hvxvu23/2dXVAwfIecdYMBl52vh3KwMm4THtl5Au0CtUkSGt/yF/
         kKoQ==
X-Gm-Message-State: ANoB5pnFHAt5ZSy5zrQOEGqhNVT6fvMseCE5RFecIRsF4dO7RmFo0t0e
        55WEP7ueMGcjgAZ8K5JTaSM+4zVWx2GKkQ==
X-Google-Smtp-Source: AA0mqf7IjvvmL+4g24G/U2z1MNsLgO3BSyVvTfTiihMmlbObV6L57f8ZNtScnTX3YQLJQB1cD/Do7A==
X-Received: by 2002:ac8:7457:0:b0:3a5:2e28:b57b with SMTP id h23-20020ac87457000000b003a52e28b57bmr5371627qtr.106.1668749422437;
        Thu, 17 Nov 2022 21:30:22 -0800 (PST)
Received: from [172.17.0.2] ([20.169.188.55])
        by smtp.gmail.com with ESMTPSA id g24-20020ac87758000000b003a611cb2a95sm1518684qtu.9.2022.11.17.21.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:30:22 -0800 (PST)
Message-ID: <6377186e.c80a0220.19a17.7211@mx.google.com>
Date:   Thu, 17 Nov 2022 21:30:22 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5685311379767335521=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix MSFT filter enable
In-Reply-To: <20221102175927.401091-2-brian.gix@intel.com>
References: <20221102175927.401091-2-brian.gix@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5685311379767335521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691340

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.17 seconds
BuildKernel32                 PASS      30.44 seconds
TestRunnerSetup               PASS      427.34 seconds
TestRunner_l2cap-tester       PASS      16.09 seconds
TestRunner_iso-tester         PASS      15.83 seconds
TestRunner_bnep-tester        PASS      5.57 seconds
TestRunner_mgmt-tester        PASS      106.69 seconds
TestRunner_rfcomm-tester      PASS      9.46 seconds
TestRunner_sco-tester         PASS      9.01 seconds
TestRunner_ioctl-tester       PASS      10.16 seconds
TestRunner_mesh-tester        PASS      7.00 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      5.89 seconds
IncrementalBuild              PASS      31.65 seconds



---
Regards,
Linux Bluetooth


--===============5685311379767335521==--
