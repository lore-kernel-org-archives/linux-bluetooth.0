Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BB6C001B2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 10:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiLPKcf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 05:32:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiLPKcV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 05:32:21 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320782BB09
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 02:32:18 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id pp21so1371525qvb.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 02:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pwtbJYQR5XXzDAPEHX65/metP6/9LZJSdetxJVW4Stc=;
        b=dhihot6pdonEQDDZjBuygp2ewpFiw+E1Bj6TnuTNtZaAzP65Sijo8aDbKHJyf2beds
         TZ6ylohabMBqi7wcjmUOmIncpbva7aVGLYM1P4beA/D07CfOuCXfiMPSURKJlBihnA9N
         15NblTZV8RQtlcaHiTWbcYUKAP5Jh9Zh6OB+1ne4q0YHvUZcfd2HBSdtijZCTzEL9QJG
         O7a9cZPSx1Kh+ESaIqyWufWjqoPfkfjhdTQPnATDBr++uqT5HMWcFIbYapZJtx3LyzHh
         j3S0153LwDVpyioTvAwidgqiTNtix58I45r4CEPC48Gdd+wMJiI3pyqKlLUR2iWNe1z3
         19FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwtbJYQR5XXzDAPEHX65/metP6/9LZJSdetxJVW4Stc=;
        b=K69dibbGDmh8I3pojLg8k78h3gzmCPTFEtAWvm2Okky7+08z0RRk5IGRoZIaKQePfP
         p5JEZ1Wz2mi4f8S0Vtj8rvKsl59H2SWhS2IgmRJUeumCMl2fXcSJ1iAPUmWEX6PmHcKv
         PqSyGbGB71TP3Rp6sHqhFE2ExFT36KN9NiTIELfl60wiurtF1QOSMRpFJHkCsbBD0obZ
         2K1zp+Tuqv1DIaYk5I5aCibvq51OO/xgV7HEt67Zi74AhfzexUFTPZ+CkzbPHqbVitac
         /T9xo2t05Nmn8DC9OYvnoU3dWXODCykiMEt2krezwqnnWFS9mpu127ON9BBPP4jEad24
         nKkQ==
X-Gm-Message-State: ANoB5pmShYuGj4Euj+bJzwWFKWOR2SYs0P7AfPP5iBQ93kEQ6608s2YT
        JNrT8NloXxmLvonDUo4ny4L+Ds4WqzMyJw==
X-Google-Smtp-Source: AA0mqf6Q0i3ROeT371def/UzCHPTStOCDODkDiQpctWv24YDNnbZrbR9a8dW0t32P/dydT814gGTuA==
X-Received: by 2002:a0c:fde3:0:b0:4bc:176f:a516 with SMTP id m3-20020a0cfde3000000b004bc176fa516mr37391438qvu.8.1671186737719;
        Fri, 16 Dec 2022 02:32:17 -0800 (PST)
Received: from [172.17.0.2] ([172.174.39.71])
        by smtp.gmail.com with ESMTPSA id x21-20020a05620a0b5500b006ee8874f5fasm1176175qkg.53.2022.12.16.02.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 02:32:17 -0800 (PST)
Message-ID: <639c4931.050a0220.fc5d7.247c@mx.google.com>
Date:   Fri, 16 Dec 2022 02:32:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3741794221033308891=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v5] Bluetooth: Add hci_nxp to hci_uart module to support NXP BT chipsets
In-Reply-To: <20221216094350.1121354-1-neeraj.sanjaykale@nxp.com>
References: <20221216094350.1121354-1-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3741794221033308891==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705040

---Test result---

Test Summary:
CheckPatch                    PASS      2.62 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      31.99 seconds
CheckAllWarning               PASS      35.21 seconds
CheckSparse                   PASS      40.06 seconds
BuildKernel32                 PASS      30.93 seconds
TestRunnerSetup               PASS      441.15 seconds
TestRunner_l2cap-tester       PASS      16.67 seconds
TestRunner_iso-tester         PASS      17.18 seconds
TestRunner_bnep-tester        PASS      5.81 seconds
TestRunner_mgmt-tester        PASS      110.64 seconds
TestRunner_rfcomm-tester      PASS      9.21 seconds
TestRunner_sco-tester         PASS      8.40 seconds
TestRunner_ioctl-tester       PASS      9.93 seconds
TestRunner_mesh-tester        PASS      7.36 seconds
TestRunner_smp-tester         PASS      8.22 seconds
TestRunner_userchan-tester    PASS      6.12 seconds
IncrementalBuild              PASS      29.63 seconds



---
Regards,
Linux Bluetooth


--===============3741794221033308891==--
