Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E442C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 13:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjDCNNM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 09:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjDCNNK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 09:13:10 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC1C2105
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 06:13:09 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id mf5so3193547qvb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 06:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680527588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tAu2Pfan5D7m9tLn8t5xL6oL+KFMdWIMufg9U8MTI+U=;
        b=k7Acg7dRe2MiPvAs1TBbhTFMOMspUd/EyZQ90LgTrQMgoCDdkkMzoQKyvidY2ggMcP
         5R3Tj9IWhyXD8LsvQhbQbtD6EBKzUHa/pTX4vOVwEU9C0VNI+sFe57CFy/OWPhMPGiIB
         +RlEG6JNb4E+UafJmkJ9jFN/xYN6KDtFNsFQe3VfoEuhGDvTNP8tnQtbkUtWGNTVo1iq
         GqrHU/xBHfBHBi/bLiPG3V9EuYRpJD/8upADEypgZCXPFIXTiLd2ElK4F0J9NIomoYsc
         zFAo5GlszqlFylhPH2kazMbcmluPztQ8j8UF/mMeBcrzgw2hr1J/r0jIuxh5eOa22fKf
         YUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527588;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tAu2Pfan5D7m9tLn8t5xL6oL+KFMdWIMufg9U8MTI+U=;
        b=w1DvGNlrepaHbsCCJTS2IiJzs4xesCIG9YDVmmRnIYr1F8nY3NfnCeQzehuPeCN6ti
         be5jMsK5oEktkoGkT793gukaf92uaX+Jvbi+ifD8Z3WgxC6wEw5EzcEeeqoJQjjLSQo1
         x6nVLkQyd8iYm62IqNvHfuJw7uhglb1ILd2yFA+qOSK9eQpA+EYQHklhWLRAYXPsS7ek
         jDMBTTDkG5tP3HMNaviNSqeXBlj0CFEG+ac/AwVKjDWluQ8QfEOt+pFf9g5Ts7ih9xRi
         2PrdIUCNMJEdh4flUJPNGAzAu0ODqiAPht6iRRU0ucCXRiKqX9Ek63YOGiral5Jcl2JG
         Y46g==
X-Gm-Message-State: AAQBX9dl+Av4ANDAZLztXPS7zW8v7IWQ2Hlm3SA1Wke7zTFDS2Twg1//
        eY5tUGLErWpB3wHsdB1oYZwf6To5mCY=
X-Google-Smtp-Source: AKy350YaMdaJMdb91Nv4d/HI2JaWif3v1kitDJOPpLv+U6XXsNpv8xPWpxSYTE7HfHG1qAVKfMze2A==
X-Received: by 2002:a05:6214:1d09:b0:56e:9298:7a1a with SMTP id e9-20020a0562141d0900b0056e92987a1amr31275208qvd.9.1680527588417;
        Mon, 03 Apr 2023 06:13:08 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.214.56])
        by smtp.gmail.com with ESMTPSA id kh20-20020a056214515400b005dd8b9345ddsm2591211qvb.117.2023.04.03.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:13:08 -0700 (PDT)
Message-ID: <642ad0e4.050a0220.d37fe.9f11@mx.google.com>
Date:   Mon, 03 Apr 2023 06:13:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1966163989361126008=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Add support to download helper FW file for w8997
In-Reply-To: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1966163989361126008==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736374

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      31.18 seconds
CheckAllWarning               PASS      33.86 seconds
CheckSparse                   PASS      38.23 seconds
CheckSmatch                   PASS      108.06 seconds
BuildKernel32                 PASS      29.87 seconds
TestRunnerSetup               PASS      429.42 seconds
TestRunner_l2cap-tester       PASS      15.83 seconds
TestRunner_iso-tester         PASS      15.47 seconds
TestRunner_bnep-tester        PASS      5.07 seconds
TestRunner_mgmt-tester        PASS      106.22 seconds
TestRunner_rfcomm-tester      PASS      8.04 seconds
TestRunner_sco-tester         PASS      7.51 seconds
TestRunner_ioctl-tester       PASS      8.67 seconds
TestRunner_mesh-tester        PASS      6.30 seconds
TestRunner_smp-tester         PASS      7.43 seconds
TestRunner_userchan-tester    PASS      5.26 seconds
IncrementalBuild              PASS      28.25 seconds



---
Regards,
Linux Bluetooth


--===============1966163989361126008==--
