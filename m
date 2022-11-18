Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62EFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 09:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233863AbiKRJdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 04:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241391AbiKRJdI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 04:33:08 -0500
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBB88CF1A
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:33:05 -0800 (PST)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-13ae8117023so5298334fac.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 01:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sUDZfXaekdpI+RNJh41vYLQiocYKB0CRlfe45MJwNus=;
        b=SfgFbNUXS9Rwk2lT53DuyqqTDECR4FQEcUR3WMReEweHmsCAQuROZXdbyq+vhHWmEY
         9YIJUZ+x0MM3F+Z7d+ADOrwPDgho+8c8q+6sjTA+49+yIu4OV2RRENH8ALjJzqRZtUZi
         SFOiLwBKfXfQmE7hsTmUrGfu0T/w8RD/XpgPsU3nvPnxV1GKDWHL3bSxEZbCtM+YWBO3
         1KJqzyabLxncpG9wz37qotsLoQkn5m/AiYNf/kAXjv9pOL/yOIIft3uy8u80jqQkrPI6
         udrMJjWG7DcSxTcDZRzSuLHgMAR3LNFtH+SNyLi3CSPQiDCOfE3pWi3BODMMN7cwfYa6
         9/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sUDZfXaekdpI+RNJh41vYLQiocYKB0CRlfe45MJwNus=;
        b=u/S9ylVBoMDWEfQeQtwZWjcjy7T7ldFleYen0B9fWewst8pTrJ6wCmBkU+smujivyj
         cCZHgnliVSsZkU83eKrAsH30f0dSeLi2mU546kP2c4sKxsXVCl/xfTBh/5AF3MuN08QB
         77NXYaajx4/XZVf9+6dJgmSdXxBsIuTRIGxVBGq/zDA00z0tZGglbon0Gv0mVR3YV3NK
         KOHBQSY1CFJ5dn66yQ556SFOGzHtRtFbjxFoqjsepYoVJueqKHMIWImWqVRL9Y+uLD8Z
         5DYIoEBftrJfp6m5/wqKbBDaC+NL4V9KDpERF2+2/BNCYD1DGHs3I2dtSNJoJHGIk+E5
         FvSA==
X-Gm-Message-State: ANoB5pnKarSWljwsxB8Tfe33eTrXCgiBEQjFDyicFzPtPnHI1BYcHfwN
        LqK98LXhHw0FimNVOSoxhc8P4mWSg50=
X-Google-Smtp-Source: AA0mqf6V+iZBUYU2oCZp2EvCT7Q3njI+4NsTpO7xWizN/GurK3OMkwil8ywWIEWJDUZINUvodMzsBQ==
X-Received: by 2002:a05:6871:4607:b0:13b:9bf2:25a8 with SMTP id nf7-20020a056871460700b0013b9bf225a8mr6547249oab.102.1668763984635;
        Fri, 18 Nov 2022 01:33:04 -0800 (PST)
Received: from [172.17.0.2] ([13.85.70.243])
        by smtp.gmail.com with ESMTPSA id 6-20020a9d0686000000b0066a9ba5094fsm1352307otx.1.2022.11.18.01.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 01:33:04 -0800 (PST)
Message-ID: <63775150.9d0a0220.8fd67.5ca0@mx.google.com>
Date:   Fri, 18 Nov 2022 01:33:04 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3678681905436885332=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v1] Bluetooth: btusb: Fix enable failure for a CSR BT dongle
In-Reply-To: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1666868760-4680-1-git-send-email-quic_zijuhu@quicinc.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3678681905436885332==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=689388

---Test result---

Test Summary:
CheckPatch                    PASS      0.64 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      40.94 seconds
BuildKernel32                 PASS      36.59 seconds
TestRunnerSetup               PASS      500.41 seconds
TestRunner_l2cap-tester       PASS      17.81 seconds
TestRunner_iso-tester         PASS      17.90 seconds
TestRunner_bnep-tester        PASS      6.42 seconds
TestRunner_mgmt-tester        PASS      124.83 seconds
TestRunner_rfcomm-tester      PASS      10.79 seconds
TestRunner_sco-tester         PASS      10.14 seconds
TestRunner_ioctl-tester       PASS      11.75 seconds
TestRunner_mesh-tester        PASS      8.10 seconds
TestRunner_smp-tester         PASS      9.92 seconds
TestRunner_userchan-tester    PASS      6.70 seconds
IncrementalBuild              PASS      36.98 seconds



---
Regards,
Linux Bluetooth


--===============3678681905436885332==--
