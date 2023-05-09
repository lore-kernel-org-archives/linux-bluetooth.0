Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B326C77B7F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  9 May 2023 01:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEIBNL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 8 May 2023 21:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjEIBNL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 8 May 2023 21:13:11 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7166E9E
        for <linux-bluetooth@vger.kernel.org>; Mon,  8 May 2023 18:13:10 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3ef32014101so55410361cf.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 08 May 2023 18:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683594789; x=1686186789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPlrzMVkbl7fIy0ExOoAZPS/ZU9UCaz/BLL3y+CIeAI=;
        b=puMe0ahsYHmBpe1nVsEC/vkQ2DshYVxbuxt9V4rUk6+daQLSN9YY/U3goYeTU94VSr
         Qb5QsgaQ+dUBnmfyGxZW2AR0Rnr7lBXPwjkI7sDrqjQmUlTrnLL/EtUdN2tEA8QWTr+Y
         virKUrnh012cjnS1aLij/qM8Qr0G92TGEhx7GSX8JZDzpwsaYhg3Q59b5KFi6dyICBk3
         7NhTfGNAi5jbvK/P5ebcfetOh6Hny8GZsDihqoNTxtviQSYCjOjiSckjQIkOFUUac3H5
         GQdB7qMy+tN0hlrSBSgxqXNn+BWWZPeAdLuaHcjo4xZ3FW12i6FeF/vTTkGCleCaoBQK
         VsRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683594789; x=1686186789;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPlrzMVkbl7fIy0ExOoAZPS/ZU9UCaz/BLL3y+CIeAI=;
        b=OUVfYjS0KhAesPmmOxTC0Yrnet/hFxD3lZa0Goda4V+DXiUV5tHF0erhQWtqWFVirZ
         l8p5qmqHLxOy0CnVYqxIUaBDbno92rrVSonsrpXpBaQ7Uu0PPweskAvnPC3r8ke50lBj
         ouKNNhi5IwItdFeINwUEB0hAGGJWAKhwFSas6pDmyCdptVf5577gAIqzeFOBQ/ig2QYs
         VBFhDwcm1JRt5jJ/IitqNKre1cS7Upjfgo0dJS63dwffky9tw0f3bsytl8QB0V39yHiA
         W87RomSm0mDvmmhMUrd4Gcn8xPMun3E8li8kCSo4ZdzNnjQVY4fcE/hMJG4Q5W8tN4/y
         lMfg==
X-Gm-Message-State: AC+VfDzx/PtEx3mtOqLzjM4qBbpkSTfyacBLQuCHs1RQT323gRC7eZya
        ZxbEkOBS6KyTGhHDTFe7IT8pNLD7p+s=
X-Google-Smtp-Source: ACHHUZ552LnX9XSt6pbTYBABsscc6768KEODQDnUkOp82RMoijol7DpOJ3e647Qf/Qbbm4zgx+TPqg==
X-Received: by 2002:ac8:59d4:0:b0:3e6:9847:661 with SMTP id f20-20020ac859d4000000b003e698470661mr18440160qtf.38.1683594789059;
        Mon, 08 May 2023 18:13:09 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.255.8])
        by smtp.gmail.com with ESMTPSA id x6-20020ac86b46000000b003ee4b5a2dd3sm100579qts.21.2023.05.08.18.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 18:13:08 -0700 (PDT)
Message-ID: <64599e24.c80a0220.4355f.04fc@mx.google.com>
Date:   Mon, 08 May 2023 18:13:08 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8632890813522540323=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: btintel: Cleanup code related to btintel_set_quality_report
In-Reply-To: <20230509001455.3111623-1-luiz.dentz@gmail.com>
References: <20230509001455.3111623-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8632890813522540323==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=745955

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      32.55 seconds
CheckAllWarning               PASS      35.23 seconds
CheckSparse                   PASS      40.23 seconds
CheckSmatch                   PASS      110.33 seconds
BuildKernel32                 PASS      31.46 seconds
TestRunnerSetup               PASS      446.58 seconds
TestRunner_l2cap-tester       PASS      17.25 seconds
TestRunner_iso-tester         PASS      21.70 seconds
TestRunner_bnep-tester        PASS      5.67 seconds
TestRunner_mgmt-tester        PASS      117.36 seconds
TestRunner_rfcomm-tester      PASS      9.14 seconds
TestRunner_sco-tester         PASS      8.39 seconds
TestRunner_ioctl-tester       PASS      9.77 seconds
TestRunner_mesh-tester        PASS      7.14 seconds
TestRunner_smp-tester         PASS      8.21 seconds
TestRunner_userchan-tester    PASS      5.95 seconds
IncrementalBuild              PASS      30.04 seconds



---
Regards,
Linux Bluetooth


--===============8632890813522540323==--
