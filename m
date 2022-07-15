Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44D86C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jul 2022 07:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbiGOHJx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jul 2022 03:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiGOHJY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jul 2022 03:09:24 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845E63AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jul 2022 00:08:35 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 72so3694158pge.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jul 2022 00:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sJu6zL/TOXa9k83Nl9Vc5sDRAXJsMdA4DRbnjdbCCgI=;
        b=mPl1Q+NHzG9tlz6mu3Ze9KzYgKHgjBSLldkYqRnxTG5Ng/PSPDIPK3sxm62YAMJm+4
         kd9/vI7FkcBOZ0lOK11PhwUM2RFeHmdWJmNQuxSUAUj/EXxsOM6F7xRikzAWpHlo28wX
         SKmPHqmRfe5zkgLlSaLzeWvCEkWddU8odtJwbp/+P8flfyasIkDpI7nSo5qXsPLKLN2T
         duISxDpeMs5UHKz70CoJQ4vUC2Ti0pDgMglFe7mWimw8YEsmBZTjJp7kKxCA7oe6Dtcu
         iosUJn7i/6WxQgQI6ENBQrrIsgEcYEdwTlaiQIuzlP45bMklhGZIZ6PoXvGrzsnWNzK5
         vzKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sJu6zL/TOXa9k83Nl9Vc5sDRAXJsMdA4DRbnjdbCCgI=;
        b=xsBHPKaaidGavIR+z3M0DDfm4v0YADYTcHKIa3KnbJzU2po69clI6rqKA9rckZafOI
         YrWrmJcfmDOTidx6+kDNbGF0rtD1moFMLpahe7gagx7nwUaUSbcypSbtTCMWTpm9qxv7
         1qwyS/RYd6inFbxPSl0vCU5fkjQQ0+nS48CD4tw5nU1tNnhCFdXx47Ujy+qHCxs4c5Kt
         JbXFH9YRZ5n77qon7/aeASliuZmEbNo1rtCw5UMG2ikE7Ru2PRx33hqlaF7E3TQ8zHbk
         WqyfrA7Xu6JN9j6utpJPyPxtXsqaGoiS77qzmbkUOFPoa8cXBRnoPTicEUxt4btTMAz6
         L6qQ==
X-Gm-Message-State: AJIora+rnNMLH4reEiOcGbnV7QjsIaS3lnLPvAp4zxN3B3a6PhYNQax2
        H8EQ3ME//pjXQYdSoR1Kksmia4/Jv3E=
X-Google-Smtp-Source: AGRyM1u+yF8On2qtNcZyTJp+SGnV+B38YyPCYBK54m0oSEAv3Fj7PWH7pS7yeow4GPH1FIwIxgYFWQ==
X-Received: by 2002:a05:6a00:224b:b0:52a:b918:e757 with SMTP id i11-20020a056a00224b00b0052ab918e757mr12562613pfu.38.1657868914196;
        Fri, 15 Jul 2022 00:08:34 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.132.216])
        by smtp.gmail.com with ESMTPSA id z12-20020a170902cccc00b0016c1f05a8fasm2673476ple.182.2022.07.15.00.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 00:08:33 -0700 (PDT)
Message-ID: <62d11271.1c69fb81.6525f.4562@mx.google.com>
Date:   Fri, 15 Jul 2022 00:08:33 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3357424191766806228=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v3] Bluetooth: hci_sync: Remove redundant func definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1657866641-16668-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1657866641-16668-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3357424191766806228==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659950

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       PASS      0.58 seconds
SubjectPrefix                 PASS      0.50 seconds
BuildKernel                   PASS      34.86 seconds
BuildKernel32                 PASS      30.74 seconds
Incremental Build with patchesPASS      42.15 seconds
TestRunner: Setup             PASS      516.15 seconds
TestRunner: l2cap-tester      PASS      17.07 seconds
TestRunner: bnep-tester       PASS      5.80 seconds
TestRunner: mgmt-tester       PASS      100.43 seconds
TestRunner: rfcomm-tester     PASS      9.21 seconds
TestRunner: sco-tester        PASS      9.00 seconds
TestRunner: smp-tester        PASS      9.17 seconds
TestRunner: userchan-tester   PASS      6.03 seconds



---
Regards,
Linux Bluetooth


--===============3357424191766806228==--
