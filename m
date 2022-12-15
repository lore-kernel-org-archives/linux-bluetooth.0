Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20202C4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Dec 2022 02:41:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiLOClT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Dec 2022 21:41:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLOClR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Dec 2022 21:41:17 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0DC55A84
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Dec 2022 18:41:16 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id z12so4166899qtv.5
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Dec 2022 18:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XSiKV+zMWIz5/wU+WNTlnxpOdkQuS+fMdCKl2LuWhm8=;
        b=eiyINm6NwEGQmXR6dIrLrb+zULb8uo6/Zsb+llfERfYQWOfe2MelbAHCKUfZdz5FWk
         kylN4IXBLVbVHqxNiLwkMPBMBp8TuX1zqiYZ1hoOkPRVQcvDsAgDFgavSuwlimhG4BXX
         e6wRiFwk6VXw342EPH1WaKVPAhMobSC2u5O9RE5hxAuK/nlJmri2gPnLGbtR1d0o1JqW
         I77csAoZyEhmOrVPuWMQ7job5sgquJw0QexgR/fNxuk/ywqI79NCf1rQhZUQqAnB2vj+
         kZ4wOCmMrCzeNaY0BG7H7aRTHCtbGmA4yHGljy2eD55OnRFjEgOJ7zqqZ+5g8nMoxd4a
         4XNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XSiKV+zMWIz5/wU+WNTlnxpOdkQuS+fMdCKl2LuWhm8=;
        b=rz1cXik6XTZEK0URjSgtyqsvmk9Lk1H0nHBiaeuzFTabRcavpMkzE0IZJyeSHnfd5o
         3wfPUCOOfNl+lKGssUvd8SbGGVykvaSiJ+t7Twank5yTu3Ju1HaUzoSW9UZt1cgR0fCb
         VsZCgisVMfrLMqwKjh9m5TzL4jh6UO5j4k6FEoG1lJM4Kb7Hc/D2NPJIi+djRSkAmz5k
         jt7ruB2uQ1c7LMRNC1B+ApO85KhHXkGMExuWvZ+Kob2joUVGh6+rMzgwB6xMIWvslkrf
         LZDoZxDHPIhmUuwS9Aof/vtcFiGmmUM/eBB7DSSdGy0xEGGO2DB5gemMtcmsycTTNexx
         8N1Q==
X-Gm-Message-State: ANoB5plhXa8koiL11cWZ3dGDdVrUy602YAptV0wf29ur9t0NkNU2yP2k
        YhxFa9+I0QVry5jBrTfvFGCLsawZQ2cZuw==
X-Google-Smtp-Source: AA0mqf6oQZeUNFNdRbLZBDFSgdnh8n2/xI8A07naq7jb5OLeI4FiabMfpRBSabORqU/SavH3TTEcFQ==
X-Received: by 2002:a05:622a:58b:b0:3a4:472e:bd6d with SMTP id c11-20020a05622a058b00b003a4472ebd6dmr52582595qtb.23.1671072075618;
        Wed, 14 Dec 2022 18:41:15 -0800 (PST)
Received: from [172.17.0.2] ([20.114.209.119])
        by smtp.gmail.com with ESMTPSA id br35-20020a05620a462300b006f3e6933bacsm10980189qkb.113.2022.12.14.18.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 18:41:15 -0800 (PST)
Message-ID: <639a894b.050a0220.43c2a.4c5e@mx.google.com>
Date:   Wed, 14 Dec 2022 18:41:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5146871828133142512=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, Mario.Limonciello@amd.com
Subject: RE: Bluetooth: btusb: Add new PID/VID 0489:e0f2 for MT7921
In-Reply-To: <20221215021854.1429-1-mario.limonciello@amd.com>
References: <20221215021854.1429-1-mario.limonciello@amd.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5146871828133142512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=704649

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      32.90 seconds
CheckAllWarning               PASS      35.19 seconds
CheckSparse                   PASS      40.13 seconds
BuildKernel32                 PASS      30.81 seconds
TestRunnerSetup               PASS      432.78 seconds
TestRunner_l2cap-tester       PASS      16.26 seconds
TestRunner_iso-tester         PASS      16.63 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      107.32 seconds
TestRunner_rfcomm-tester      PASS      8.78 seconds
TestRunner_sco-tester         PASS      8.10 seconds
TestRunner_ioctl-tester       PASS      9.44 seconds
TestRunner_mesh-tester        PASS      7.02 seconds
TestRunner_smp-tester         PASS      8.01 seconds
TestRunner_userchan-tester    PASS      5.82 seconds
IncrementalBuild              PASS      28.46 seconds



---
Regards,
Linux Bluetooth


--===============5146871828133142512==--
