Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE2EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 23:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229994AbjF1Xhx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 19:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF1Xhw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 19:37:52 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8311BDF
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 16:37:51 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-765a5f7abc6so8879085a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 16:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687995471; x=1690587471;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tquq7rKQr2CBRfrz6GGZpGZDFPorzoJKN3Y+nsNfknk=;
        b=TFmhvh/t3nSotxoNaAi8GO7ryTJ643/kqiw22lowURdnR9MCsZ3empBwYLQzXCm7SN
         aKTXEND6Vx17PNJIU3EeGxHRFKeim/mj67ccq9fGHCasfG8VxwwtmiWvVBMm/xR2dLl4
         YdQ5kMumzPlBZhnQj/wlnnrCBuLkNwprtn+FqsHqiR8CF5Ax9AxiQ1814853+o+yn3DG
         ZyCbWg4t1wlQxXdlxjyejryzSL8Ll/CS/pycW0BIHJs0o+reQ7IHY2SkaztSkYxk5exO
         v4Qg89vmWYfr6CZ2uQicSaAoLl8TqPiJEBQVMEW1YcTKSGtvCNdglIEdHinzHQGnS7ns
         JGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995471; x=1690587471;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tquq7rKQr2CBRfrz6GGZpGZDFPorzoJKN3Y+nsNfknk=;
        b=Ek0+HS/u+JpeJEvAMiYYI+6xRQMZ3RIw3nBPAWJiwexTk9F+JnBf9xm354RW2jYyEO
         MNFUa1AE53INZ7KI87OHWL9CBGYmlljKYkgFEFsQuV74M4MHnYpKQMshd1xPudnZVshl
         3ZrTRWQYBEiiih2KLAFIt0ZfIXABZWj0HU/CzTXjVQffZOA9NbLfjUb7AC/1KTisKpNc
         t6D9vLruoy1l07brG5p678rJcCsBMfz5jT0KDj92t7FO6E/F8NrBiz/puDShOw81xGgd
         WIJBc9aGLdROvUn55Vc0+MxiU0HQXof8SxkuV6S7MJq8fhiF4Mt+C3TfhfZH+U0Dwe+8
         ZU+A==
X-Gm-Message-State: AC+VfDxelI4oXSM/6TEhm9ZxB6zZBIy8q7GlWahxLtf8Y7ef0cHky5m7
        QL5ccw9utdno/Y+zgk/8f24eTmSZlQs=
X-Google-Smtp-Source: ACHHUZ57rGl2pd7VuHfhEY6pNqf5kAV2nwXW8GBunepxD0HNoDunFzmYoUGkhCWLkvE2COcU+eZ0CA==
X-Received: by 2002:ad4:5aa9:0:b0:635:f6a6:b6c with SMTP id u9-20020ad45aa9000000b00635f6a60b6cmr5822405qvg.5.1687995470761;
        Wed, 28 Jun 2023 16:37:50 -0700 (PDT)
Received: from [172.17.0.2] ([52.190.17.173])
        by smtp.gmail.com with ESMTPSA id lw15-20020a05621457cf00b00626161ea7a3sm6367282qvb.2.2023.06.28.16.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:37:50 -0700 (PDT)
Message-ID: <649cc44e.050a0220.64049.f910@mx.google.com>
Date:   Wed, 28 Jun 2023 16:37:50 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5690922543636516938=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, sean.wang@mediatek.com
Subject: RE: [v8,1/3] Bluetooth: btusb: mediatek: readx_poll_timeout replaces open coding
In-Reply-To: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
References: <80efe66b16d933e3457bd38b1a60a5d51d4dee9e.1687991820.git.objelf@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5690922543636516938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761063

---Test result---

Test Summary:
CheckPatch                    PASS      3.64 seconds
GitLint                       PASS      1.09 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      40.35 seconds
CheckAllWarning               PASS      45.14 seconds
CheckSparse                   PASS      48.92 seconds
CheckSmatch                   PASS      131.41 seconds
BuildKernel32                 PASS      37.59 seconds
TestRunnerSetup               PASS      550.92 seconds
TestRunner_l2cap-tester       PASS      19.57 seconds
TestRunner_iso-tester         PASS      29.10 seconds
TestRunner_bnep-tester        PASS      6.53 seconds
TestRunner_mgmt-tester        PASS      148.01 seconds
TestRunner_rfcomm-tester      PASS      10.65 seconds
TestRunner_sco-tester         PASS      9.74 seconds
TestRunner_ioctl-tester       PASS      11.31 seconds
TestRunner_mesh-tester        PASS      8.35 seconds
TestRunner_smp-tester         PASS      9.46 seconds
TestRunner_userchan-tester    PASS      6.88 seconds
IncrementalBuild              PASS      48.56 seconds



---
Regards,
Linux Bluetooth


--===============5690922543636516938==--
