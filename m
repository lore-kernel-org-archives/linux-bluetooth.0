Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751C1EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 13:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjGLNvp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 09:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGLNvi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 09:51:38 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDD61BEA
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 06:51:33 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b72c4038b6so5814385a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 06:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689169893; x=1691761893;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vRoubrQfWLxXxldbPlKNEI/3SX7r/YWPC5h9Dm9FEuc=;
        b=ehU/j1pPLk1IIZ4uMF7RpIh9zrKcD89ItdQYeKgHCeujVQvZA0Z9Va7nuZcpK76o4/
         H1tASCgVra9aBagwO0/XYxuRNdRJx68UvFVwoyTntLVY3S+S2qFvaImPTgl0rSo/PmNA
         a+vNQLpjCKs+GlMcbBSOQ7KuUKBtPTYqbTkXUmqAGt4g7s3sXTmOu39JxNtVaiYR+W1E
         9fV+0f52XELc0uSjwZ527K6dCF4tf2cDWOFNI7lxE/JRMvrhomF1eJ0GRnFaJiFA4ZWA
         YV52ggI2n4gPYg3q/dxQN+d4htCLZG7kGvl2WfxQjlE0LNcKThPeQgi9HtIf4vk5LPKW
         Blkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689169893; x=1691761893;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRoubrQfWLxXxldbPlKNEI/3SX7r/YWPC5h9Dm9FEuc=;
        b=CFWu9SaNz+yCCSbgWnAP0MNdZpGZIwpehv+eDPILu1wZIUN2myWV6/N/PXYq4eOeSt
         Qsjz4AqOl9A3sh2dXmY2G9mUPFaMmYaWtZhUZaqMYfWWrejuqmIUpv0ByU6u7Gt0hI5f
         b0moYHh+2FdrY3PtyDozP57C5UkXbTZIt7hfSX3M/6cTZq1NbABwb1e8vJYUA4s5nRWm
         w/UNUDjzgtttNyXFqcwIXXvE1Jb9NIePl4zTGNhOpb4IfGv+op/sq8FiUP9on/TX2cuA
         sUM3nJihkLs881FwJoMBTOs1zqZ3gECXyyj1eK/fzLbHd/ooRYZ33lVLbly/tAnPnZqz
         pu/Q==
X-Gm-Message-State: ABy/qLafGKdVZVXibFwc8eLX6NlFBt7Ya8X7/yuIvXb3+ybI3qdNxUpj
        6piyIuBNoIhgIM4WDeCppeezCmHdAuQ=
X-Google-Smtp-Source: APBJJlFiG0yc3p/3KUVjSAalta46cG/ROAhxtoLRHk9ok0oax+JrcRv2gviiK6SkWymXhjJVJDJEoA==
X-Received: by 2002:a05:6830:14d3:b0:6b9:9e4f:5f4c with SMTP id t19-20020a05683014d300b006b99e4f5f4cmr1658289otq.29.1689169893020;
        Wed, 12 Jul 2023 06:51:33 -0700 (PDT)
Received: from [172.17.0.2] ([23.102.140.54])
        by smtp.gmail.com with ESMTPSA id e13-20020a0568301e4d00b006b87f593877sm1898844otj.37.2023.07.12.06.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 06:51:32 -0700 (PDT)
Message-ID: <64aeafe4.050a0220.43c97.c40d@mx.google.com>
Date:   Wed, 12 Jul 2023 06:51:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0497013771041925637=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, chris.lu@mediatek.com
Subject: RE: [v4] Bluetooth: btmtk: Fix null pointer when processing coredump
In-Reply-To: <20230712130218.376-1-chris.lu@mediatek.com>
References: <20230712130218.376-1-chris.lu@mediatek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0497013771041925637==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=764864

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.72 seconds
CheckAllWarning               PASS      35.67 seconds
CheckSparse                   PASS      40.50 seconds
CheckSmatch                   PASS      113.44 seconds
BuildKernel32                 PASS      31.76 seconds
TestRunnerSetup               PASS      477.48 seconds
TestRunner_l2cap-tester       PASS      22.23 seconds
TestRunner_iso-tester         PASS      39.87 seconds
TestRunner_bnep-tester        PASS      10.26 seconds
TestRunner_mgmt-tester        PASS      212.08 seconds
TestRunner_rfcomm-tester      PASS      15.16 seconds
TestRunner_sco-tester         PASS      15.95 seconds
TestRunner_ioctl-tester       PASS      17.20 seconds
TestRunner_mesh-tester        PASS      12.71 seconds
TestRunner_smp-tester         PASS      13.75 seconds
TestRunner_userchan-tester    PASS      10.54 seconds
IncrementalBuild              PASS      29.52 seconds



---
Regards,
Linux Bluetooth


--===============0497013771041925637==--
