Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE12C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 12:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbiKPMLq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 07:11:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbiKPMLR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 07:11:17 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4947DC6F
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 04:04:55 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so2108515pji.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Nov 2022 04:04:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I7Df5ZiULXk89+gsPujjTDzyqWoDqB6P3SqAfswqirw=;
        b=eXmfnoqnyPoGYxDa6i49aZP2zxSFr8i8FSWx1xTZJhvcdb83YFi1eJgaTDeTjs5/eo
         ZRHEOEcfRvslNfvcQND99pyqmtITgYm0dBS1UsjodGlzBrBksGl3lglAE22NXq029CAS
         uYSyZeIbyOzWBcMB6w2+mY5C39FkXV5ROB5YcXJHKZm1lLOBPiQXvluG0YRWsnhTVyBL
         9hyC12JaeIz9WKZvOCjnQNmwhJHVWTc7qqgSrJBHSw3Ex8aNO+1Yzr2WKFr52EVT0/pS
         DivknR/dW8GrrAskSr9sHKxgLn6HIK0WesONs2GTwXkdnWG0EgHZo7Oa22AqmUyhc6LN
         zRcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I7Df5ZiULXk89+gsPujjTDzyqWoDqB6P3SqAfswqirw=;
        b=qs5k6TFtcsnuDToLFy578YSWxUuunwHAqe8FYS9m2YinFiF2X87ny4hTzlvmDBj4rg
         ILxYfj1kHlxaLrYU1VruuEkH4SPb9G5TJzJf72jd2qKIhKoqhYtYb9Lv4D1rIe86JTOB
         BkIu2Mem/rK/qppBnKXIc9TmhAXRRHMEqd1V1Mtdj/L9juvdt8aH9u7jq2Sg5G5ct5zr
         fcpRsE1nnsUC3W/HXIq0GVWXzW/Tgon/aQqMFcNFazZ93RgLu7ND2gcmWfNM0Ad+4O1n
         GrnW9rJTvbgRzBZZTxvqllLovGOT7GVGkzUf+7wjT7PVkmAsrSl3pTkVHyqDoGPQk6Sp
         JlFg==
X-Gm-Message-State: ANoB5pmNY/s3achpEPIQFNEmG9rCVNEZ3BjjgJnRmAc+cGpH8YbWEg5B
        zC2I9Dbgel/4UiAQ+la0cCVxFToNbKg=
X-Google-Smtp-Source: AA0mqf7HCEnFewG99ZYCn4r16ZaQBRzJOK/70/Z2EgZ2RycFdgAGTT1JYuM7dZeFSFJ3t9u3xYJWYw==
X-Received: by 2002:a17:90a:8c07:b0:212:e2e9:4b1f with SMTP id a7-20020a17090a8c0700b00212e2e94b1fmr3366168pjo.20.1668600294444;
        Wed, 16 Nov 2022 04:04:54 -0800 (PST)
Received: from [172.17.0.2] ([13.64.119.92])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902dac800b0018725c2fc46sm12061516plx.303.2022.11.16.04.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:04:54 -0800 (PST)
Message-ID: <6374d1e6.170a0220.582f4.2989@mx.google.com>
Date:   Wed, 16 Nov 2022 04:04:54 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1117939794762147989=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1117939794762147989==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695943

---Test result---

Test Summary:
CheckPatch                    PASS      3.42 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      46.71 seconds
BuildKernel32                 PASS      42.04 seconds
Incremental Build with patchesPASS      62.78 seconds
TestRunner: Setup             PASS      696.11 seconds
TestRunner: l2cap-tester      PASS      21.62 seconds
TestRunner: iso-tester        PASS      22.45 seconds
TestRunner: bnep-tester       PASS      8.74 seconds
TestRunner: mgmt-tester       PASS      138.54 seconds
TestRunner: rfcomm-tester     PASS      13.16 seconds
TestRunner: sco-tester        PASS      12.09 seconds
TestRunner: ioctl-tester      PASS      14.39 seconds
TestRunner: mesh-tester       PASS      10.42 seconds
TestRunner: smp-tester        PASS      12.05 seconds
TestRunner: userchan-tester   PASS      8.76 seconds

Details
##############################
Test: GitLint - FAIL - 0.47 seconds
Run gitlint with rule in .gitlint
[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.
1: T1 Title exceeds max length (96>80): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."
1: T3 Title has trailing punctuation (.): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."




---
Regards,
Linux Bluetooth


--===============1117939794762147989==--
