Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71F3C54EBD
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Jan 2023 21:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbjAIVrv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Jan 2023 16:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237692AbjAIVrs (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Jan 2023 16:47:48 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D711CFF6
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Jan 2023 13:47:47 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id fa5so3901004qtb.11
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Jan 2023 13:47:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u02X3BWlF//BTGshGEQLQp4yByiWot3UB26qxY+L3dU=;
        b=Yh1l/Pk6DQhwzB29+ax3TNsJGEhuh6uVirZkmv0M4bsVk7T3ez/bDMUo4Q8Gphk20k
         i/zYNN4oSuN9linufeh8UXCl4edYhLaClHExFIgPTGKWWfYhciQH7BHYne8NWrjksljF
         6f3xHXtq3S3E14cRhL0SN2HxpEM0q1kk2Sbwq8C8mw63EDHW4Tv9wuL0WVkjTaSp6fBW
         unqHUqUJCowbpxvPlVEZme3YaJDu9DBcrBr91uHjcEPKpS1+bKNc3+MdJtPKUPyawkTD
         N2RrotBe7VrWFDIwqKzf9wz0tWVlyzlKlC1MsMDmfRahq14wsMyFOtYhDbsuqgbxS1I2
         eIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u02X3BWlF//BTGshGEQLQp4yByiWot3UB26qxY+L3dU=;
        b=0SxsLPT+wEXyQDBTAYOiW4Z0nmQjCiJ6PKXzFC05wFDXUxvm39bfrgRt6M9WP5zKwa
         g8aHXw1sXvKy7KAxrw/JUXHESxs/zf4MKrz5RtO8NJQE3qaCBnMVAp7q0Twt2oa2GYxy
         L5tEVub0r08dPZIXJ63OZZwqJWCVIi/Ll4OZGngRaObS68JiO/TxOwldXfTw6qhQR+jt
         /wrOR4iV3yrQS/3qiL0PQBHLXCvMwlDQoot3qHRdR942rA2FA4My+j7AoOXlanJmgoxs
         /7dOGlKBcXuhShjzeLm4mYmPYCyxBT6dSwKyuyjwwV1qh25VD+mSx39QI30/i2gAFWyn
         PZBw==
X-Gm-Message-State: AFqh2kpKq+In7QcebzCdTFSDSDM/H0uschx4GTYqWt569UYwaqzdpQj+
        OVRKNX7ThM+TDBzaBM8XQ+mVGDP6TFcvjg==
X-Google-Smtp-Source: AMrXdXtTdlvSE3Fc5jSnzBFNPhzLrG+PT633RcoW2IzklfxaLSWl4hZwnqw6WkI85HIPLbe7E5WeSA==
X-Received: by 2002:ac8:7351:0:b0:3a7:e9dc:699d with SMTP id q17-20020ac87351000000b003a7e9dc699dmr88462661qtp.20.1673300866646;
        Mon, 09 Jan 2023 13:47:46 -0800 (PST)
Received: from [172.17.0.2] ([172.176.205.115])
        by smtp.gmail.com with ESMTPSA id d6-20020a37b406000000b007049f19c736sm5973665qkf.7.2023.01.09.13.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 13:47:46 -0800 (PST)
Message-ID: <63bc8b82.370a0220.f84ff.2eb7@mx.google.com>
Date:   Mon, 09 Jan 2023 13:47:46 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0246705885255552185=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: hci_sync: fix memory leak in hci_update_adv_data()
In-Reply-To: <20230109212237.3209300-1-luiz.dentz@gmail.com>
References: <20230109212237.3209300-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0246705885255552185==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=710258

---Test result---

Test Summary:
CheckPatch                    PASS      0.67 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.67 seconds
CheckAllWarning               PASS      35.17 seconds
CheckSparse                   PASS      39.31 seconds
CheckSmatch                   PASS      108.95 seconds
BuildKernel32                 PASS      30.51 seconds
TestRunnerSetup               PASS      441.76 seconds
TestRunner_l2cap-tester       PASS      16.00 seconds
TestRunner_iso-tester         PASS      16.45 seconds
TestRunner_bnep-tester        PASS      5.54 seconds
TestRunner_mgmt-tester        PASS      107.57 seconds
TestRunner_rfcomm-tester      PASS      8.77 seconds
TestRunner_sco-tester         PASS      8.04 seconds
TestRunner_ioctl-tester       PASS      9.25 seconds
TestRunner_mesh-tester        PASS      6.85 seconds
TestRunner_smp-tester         PASS      7.98 seconds
TestRunner_userchan-tester    PASS      5.75 seconds
IncrementalBuild              PASS      28.72 seconds



---
Regards,
Linux Bluetooth


--===============0246705885255552185==--
