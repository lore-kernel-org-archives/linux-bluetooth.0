Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C955C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 10:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbiJRKWd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Oct 2022 06:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiJRKWc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Oct 2022 06:22:32 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C33ACA0B
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 03:22:30 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id o64so15026262oib.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 Oct 2022 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uo+AC3y8FTrhkUNmnsZFN8+WbTMjawYvqsP7icYN3YM=;
        b=Z6Ghz+/LbwtgBr9UmmIVJCjwK91/P+F6znttJkXBjYauHApPjm0inRt6JRTbYvx9Vw
         Q+q5+FB8j8TXvZjEIIf5g2eX4dnff7SzbUgSRHp0FrpHoUSNbxbVjXkCtlIsojzllHrx
         m9hN9uv/tyTfZtnnrFNyLM4PqcCuuLbr/S0Z9TwSETaSqTrFGwRHE8ihoYnvLhMr7V+i
         cibK4/Yk5zy0UkPfKfH1xR0NJK0zOGMZnNaZNZFhlTG13/FsSUr0U1Irp0DAtLTH+L06
         uWQKxVZTqkzUvrro1RQZUp0FqhOVN8DFFhdRYvKwBfcqGIWkokfCHY47abbxicvks0f9
         CL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uo+AC3y8FTrhkUNmnsZFN8+WbTMjawYvqsP7icYN3YM=;
        b=jnAcZCAf9xsa4yKOgADGKvHe7/dulITNzxrfSDdC50RmSjwilqlvgI0mNGf++u5dP1
         KYvhtn3qlWuUk1SsWR5U8IVPmTmCe53puXexpk+HfcMOJK7HE0LoIv3AL2E2YJj/FQrY
         E0BVuL2aMiCaDvsUojIoNmVYpKf0P/tIdvMZ2Cmf8OQlzjO2TTsv6pBt3KvPLzCKnRyf
         5EDFmbRjc3APQW4qP1r560XA8ZETcQgj9eYeuxG8dpdUwJszsTTOWX+66P5+tIRnvDkE
         XR59xKDBph40CXcuAlBpzXAQzkQ04rNc98kpoamYVmxpMQS3wNIpgjYo/+PjkjnlIDkM
         LpRA==
X-Gm-Message-State: ACrzQf3mfX9vT/xYf6BykDRJCfxHvFn/lVNmtCpDICqMSSWz4540FjMy
        Errr26wLsIRewvoI9wBpH/6y9LeUKxk=
X-Google-Smtp-Source: AMsMyM7guR3KJziz/fpUS+FNVaEfBIAl8eihxzr3dndax6fdrze7cYvPp+jIOK7FvlZeipki55rcYQ==
X-Received: by 2002:a05:6808:989:b0:354:fcc8:2b4d with SMTP id a9-20020a056808098900b00354fcc82b4dmr983357oic.157.1666088549168;
        Tue, 18 Oct 2022 03:22:29 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.230.0])
        by smtp.gmail.com with ESMTPSA id x27-20020a056870a79b00b001372c1902afsm5929092oao.52.2022.10.18.03.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 03:22:28 -0700 (PDT)
Message-ID: <634e7e64.050a0220.811b5.5e32@mx.google.com>
Date:   Tue, 18 Oct 2022 03:22:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8737781059785649956=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, stephan.gerhold@kernkonzept.com
Subject: RE: [RESEND,v2] Bluetooth: btqcomsmd: Fix command timeout after setting BD address
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221018085431.2913217-1-stephan.gerhold@kernkonzept.com>
References: <20221018085431.2913217-1-stephan.gerhold@kernkonzept.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8737781059785649956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686199

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.82 seconds
SubjectPrefix                 PASS      0.61 seconds
BuildKernel                   PASS      42.50 seconds
BuildKernel32                 PASS      38.50 seconds
Incremental Build with patchesPASS      58.24 seconds
TestRunner: Setup             PASS      623.73 seconds
TestRunner: l2cap-tester      PASS      19.58 seconds
TestRunner: iso-tester        PASS      19.77 seconds
TestRunner: bnep-tester       PASS      7.70 seconds
TestRunner: mgmt-tester       PASS      121.78 seconds
TestRunner: rfcomm-tester     PASS      11.94 seconds
TestRunner: sco-tester        PASS      11.57 seconds
TestRunner: ioctl-tester      PASS      12.95 seconds
TestRunner: mesh-tester       PASS      9.72 seconds
TestRunner: smp-tester        PASS      11.25 seconds
TestRunner: userchan-tester   PASS      7.99 seconds



---
Regards,
Linux Bluetooth


--===============8737781059785649956==--
