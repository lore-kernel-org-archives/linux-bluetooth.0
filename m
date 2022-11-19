Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2346C4332F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 19 Nov 2022 05:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiKSFcj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 19 Nov 2022 00:32:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiKSFcf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 19 Nov 2022 00:32:35 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5DB56711B
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:32:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id i12so4763146qvs.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Nov 2022 21:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SH/G9cdKw3YN+7HI+S/QlspqGpBzzkpp+0LcV67abYU=;
        b=G3iyiJ3aZeWqF3+JIDvDVQO8WzHSSqVHjIEZFMCPb+bPLbnhxCtuTcc+33yU6sApJ8
         b5Vc+YpdcvKFVOI/5do1Jkk/Ko0NfF3NaWyBi+GyKBEuQQGtH48ckAeB4OIDzZTbNKWf
         uL4Ab2jtvYmCVFVXXW3WvhvljxB1fXbECxLNYKLVAILUXJ+5r4kJ/tVsBpww2MPU3EM7
         0V+np7FOes3t3kDLWbH2JUmEjXgmZtGXhd3CzI5Fp1xzxLBte3JRena9qUwtJlPbGyeL
         U81dpZhmUmZZ4Gu9xT9Kc/OaTo+5oTJxMH2w8WHvR/JpgTGhw5YPXnN/CfGDNodHe9C1
         YMeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SH/G9cdKw3YN+7HI+S/QlspqGpBzzkpp+0LcV67abYU=;
        b=YymzOoblkjWZEVlT7YK0LZ3YKAHhfqhVVWKm1h8KYPIPWQaeDaPewLdLWL2klvBtty
         94iru+cJydpDseEw9FUfSZPqSJxvMf77rXos1Ut0+wyOPCeha1K2o9dYEmqhmJ+1jH+X
         wqhbHFdegtviPB0P0+ZT0ZoePkBzCRnp7QjunIr/+wIpU8IYjp7x7cjtCHqn6vJoy1F0
         L/Aembm5JaP+beANPjw65P1ZIrUdfbDlmxAptJ4EKgugBjDN64yynp0cuj5QDaKFAKbm
         4NHKe3hA4gJJQzxEGnH+7TWm0XzH8ACng9wsMTcWJugOPytyPNCVnBYoVsATPrpwZf+N
         SPKQ==
X-Gm-Message-State: ANoB5pkumRQEhAssvDr6MQwW79PR8k8xexIX9sUZtStWXG3ONnALgi0o
        Ysru4bhDtSZgOUKyrUHautV88qiH47Z+UQ==
X-Google-Smtp-Source: AA0mqf5/O7G1ggFInQoiBsj1Hf8RdO8RuCnTDRjRS/mrdiqcwJbG/pnJhD6iiZ/SKkAee8p4ZYGPvQ==
X-Received: by 2002:a05:6214:3712:b0:4bb:9358:2a1e with SMTP id np18-20020a056214371200b004bb93582a1emr410598qvb.97.1668835953737;
        Fri, 18 Nov 2022 21:32:33 -0800 (PST)
Received: from [172.17.0.2] ([172.176.70.85])
        by smtp.gmail.com with ESMTPSA id h9-20020a05620a244900b006fbdeecad51sm1429366qkn.48.2022.11.18.21.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 21:32:33 -0800 (PST)
Message-ID: <63786a71.050a0220.6b763.6446@mx.google.com>
Date:   Fri, 18 Nov 2022 21:32:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4612574334106123683=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hadess@hadess.net
Subject: RE: [BlueZ] main.conf: Add comment about LA Audio BAP UUIDs
In-Reply-To: <20221102101224.1463549-1-hadess@hadess.net>
References: <20221102101224.1463549-1-hadess@hadess.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4612574334106123683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=691153

---Test result---

Test Summary:
CheckPatch                    PASS      0.44 seconds
GitLint                       PASS      0.34 seconds
BuildEll                      PASS      26.05 seconds
BluezMake                     PASS      738.01 seconds
MakeCheck                     PASS      11.24 seconds
MakeDistcheck                 PASS      142.98 seconds
CheckValgrind                 PASS      236.49 seconds
bluezmakeextell               PASS      92.32 seconds
IncrementalBuild              PASS      597.05 seconds
ScanBuild                     PASS      921.92 seconds



---
Regards,
Linux Bluetooth


--===============4612574334106123683==--
