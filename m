Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D25D5C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 03:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiKSD7Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 22:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbiKSD7G (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 22:59:06 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B6A75DBF
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:55:58 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k2so4776799qkk.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 19:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AhyhrwEAE0d2zj4kI5yHxKBDCaf8Hw5B8Ep9ePCBTGA=;
        b=VofyMQIVqWYuGeIDphTD/DbrTgiOsnFv9IWKoj3O/xFjkPy7u7IN4AKD2Qys9ft87z
         1t6+6RbWNFxSxDYihzczvUWpdnjXklWuyET3NY//Qwl9p+CvYrIKKF8sEhWcHKCzK+V5
         zO6h2UsJp3Oeyn2ggUZ6oV47fa5j9hB99YL8G0fmV89QIl38fjBKIOD0YdVpBU8VjmvC
         nRnVo1CuPIARYQrWA86larHDcgzjX8jl2VJxdzknwwPPwElLhyLp/iqkWqBfRbnMnPW0
         j2P4UgytcfLqaaNHKJpOcecQtLluxyTjsTs5FwVUOColLiamON70UGoUydOfvrkYwy4b
         0Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AhyhrwEAE0d2zj4kI5yHxKBDCaf8Hw5B8Ep9ePCBTGA=;
        b=vKZ4fntugP0rRG35WmsOkJqkZRcVAaXk7SuM5LGY46Muv9lj1blJEEqgeS1KDBHN/G
         rZ8tvm7kccFBs4a0VSFJ69e60M11j2n58PHJ8+IfIN1LzWni97C2RuXrhKvpKJJmKwT0
         jv2k34RhzUTElOmcK405K55D+Bfw50uMgt9HiaW0w2tK21IMg1QIghUox3oRqh9MIePR
         XPyaiT+bwwG4TcHU8hNpB5lew1jlXURV0JU9kabnGuI5RQKgdFd21ZXcLfkKg4AaTEJN
         uWGJlBRMWmH3uVHL1FEKz8qIXvbzdUusKk46Bbkw5OePW3f5wagWAqKMqXesdpEVvxJx
         loWQ==
X-Gm-Message-State: ANoB5pk3p3ctAJLgblUigkmGYv0xRrIpMFkRbFHbC8Rcz4l5C7F7qgz2
        SkMeeCHIGh3CAEnCbJNz23jF8bQiGiWvug==
X-Google-Smtp-Source: AA0mqf4qTp8lzEaR6FV1Y/Zu/yBHaAAGxPJzfqqDhkk/9QmCfEFEw5xuy55Ld60J8GhR+YMYCN7B4A==
X-Received: by 2002:a37:ac11:0:b0:6fa:546e:52c2 with SMTP id e17-20020a37ac11000000b006fa546e52c2mr8454984qkm.382.1668830157883;
        Fri, 18 Nov 2022 19:55:57 -0800 (PST)
Received: from [172.17.0.2] ([20.14.198.10])
        by smtp.gmail.com with ESMTPSA id u12-20020a37ab0c000000b006bb29d932e1sm3624692qke.105.2022.11.18.19.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 19:55:57 -0800 (PST)
Message-ID: <637853cd.370a0220.212eb.19cf@mx.google.com>
Date:   Fri, 18 Nov 2022 19:55:57 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1652734116114630727=="
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

--===============1652734116114630727==
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
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.10 seconds
BuildKernel32                 PASS      30.01 seconds
TestRunnerSetup               PASS      425.14 seconds
TestRunner_l2cap-tester       PASS      15.70 seconds
TestRunner_iso-tester         PASS      14.97 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      104.21 seconds
TestRunner_rfcomm-tester      PASS      9.08 seconds
TestRunner_sco-tester         PASS      8.54 seconds
TestRunner_ioctl-tester       PASS      9.76 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      5.57 seconds
IncrementalBuild              PASS      31.21 seconds



---
Regards,
Linux Bluetooth


--===============1652734116114630727==--
