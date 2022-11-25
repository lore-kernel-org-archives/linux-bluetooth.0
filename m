Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FB9C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Nov 2022 04:32:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKYEcc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Nov 2022 23:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiKYEca (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Nov 2022 23:32:30 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66F1009
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Nov 2022 20:32:28 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id x18so2020374qki.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Nov 2022 20:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rptwOqcNcMxt+9zzl8e3cnNhteTgbFllLfRNM4iO4j8=;
        b=DZKe3+D62+pJXxTfPZUmvnw2j03A5fpRRCKeLD1ckafGZ7ZhNKgjFsNgMc57ZG/dIw
         FyedRPTgmw/pJdnubUPwGSzrAlW60gi+GEsbwQggT33V7u09prZ/IOQ+WQlXNagjbvr9
         s3tVz2hI0MaIxHA6hUQKs77EBH3SJCO5tFDibpWtZ2Fdq8b8Cf9TlxcDSI4bt5S184nc
         CMLrj6LylLK1iDE4C1/MuVLyxd3+WQXpVhug7hVCY52bkUSmKhXIMnhQCTm22fvZhPVM
         yqTmfgcKpK1y00aRcps4F04XnL45LT7V0ylNpQXts4ApZ4NcqEfVgEzGBD5hC9aIs/xQ
         /JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rptwOqcNcMxt+9zzl8e3cnNhteTgbFllLfRNM4iO4j8=;
        b=nN5/2aaCXYvv5+LEIJWepHc9Qnzjwbgo49+rrPsbPuRjXrgrwemYRv/04CyF+IvmBp
         M3lLASwha1cSq3wBssqhNK6x0vPRynsL7Whdy+yWFEKwuo5Pr+sSfQNbt0TGlXELVJ7d
         JNxP5xf2XbVCSCV5gnAJAmJC1OQ66qbjgE9kDcarby3M/DAnD8VpHwele5C6KhhD6dUF
         AUKc1EQhF+0Gy9ZCkmEBycugBIzdKyCgfom1xLTYmbC1yF/bRTZCyB7+mLOF+NySu74w
         2wTs3B/Kv2uexrEe2rcZOH/rNe8IMI4X5R8jo1J0Vtx+0UB28ZA/K7GuMXjObEPrve+x
         UnvA==
X-Gm-Message-State: ANoB5pk7GlSL4SiF2pcYp/cBNN2/WqpNoSaLIW2N9RRazL8flcTNHcEF
        8eDzcQTk7HeOTwPmdwIcylGG05m9fZLz+w==
X-Google-Smtp-Source: AA0mqf6f+Pwl7TlLfgH9Mt0DZGaVDPv5DZVprh2kciOnLUrLuapfUOqbR6DT4JLs9IzlP+HzY/dPcg==
X-Received: by 2002:a05:620a:1a16:b0:6f9:5ebe:aa7 with SMTP id bk22-20020a05620a1a1600b006f95ebe0aa7mr16879467qkb.509.1669350747568;
        Thu, 24 Nov 2022 20:32:27 -0800 (PST)
Received: from [172.17.0.2] ([20.185.27.191])
        by smtp.gmail.com with ESMTPSA id u8-20020a05620a454800b006ecf030ef15sm2104735qkp.65.2022.11.24.20.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Nov 2022 20:32:27 -0800 (PST)
Message-ID: <6380455b.050a0220.b56c5.4729@mx.google.com>
Date:   Thu, 24 Nov 2022 20:32:27 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8184739207068065203=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, samuel@sholland.org
Subject: RE: [v2] dt-bindings: net: realtek-bluetooth: Add RTL8723DS
In-Reply-To: <20221125040956.18648-1-samuel@sholland.org>
References: <20221125040956.18648-1-samuel@sholland.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8184739207068065203==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=699014

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 FAIL      0.32 seconds
BuildKernel                   PASS      33.78 seconds
BuildKernel32                 PASS      30.27 seconds
TestRunnerSetup               PASS      419.21 seconds
TestRunner_l2cap-tester       PASS      15.65 seconds
TestRunner_iso-tester         PASS      15.19 seconds
TestRunner_bnep-tester        PASS      5.31 seconds
TestRunner_mgmt-tester        PASS      103.24 seconds
TestRunner_rfcomm-tester      PASS      9.17 seconds
TestRunner_sco-tester         PASS      8.54 seconds
TestRunner_ioctl-tester       PASS      9.87 seconds
TestRunner_mesh-tester        PASS      6.61 seconds
TestRunner_smp-tester         PASS      8.42 seconds
TestRunner_userchan-tester    PASS      5.56 seconds
IncrementalBuild              PASS      31.00 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============8184739207068065203==--
