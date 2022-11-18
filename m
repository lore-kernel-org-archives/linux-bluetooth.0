Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF0C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 04:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240758AbiKREP1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Nov 2022 23:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235025AbiKREPW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Nov 2022 23:15:22 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8843F61519
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:15:06 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h21so2487673qtu.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 20:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5ub8AeLNqSlmEQNIGyq/3dARpdR1OqwGD6uBEc1fE3w=;
        b=B3+4+jUqvKXT7kko2yJOgqP65/yHGniJRQDxJW9yyJG50hBjG3YSXJpD7aIXZJyn90
         IXAoCGEpqIxJcL+giwO025Vm5kEV1sTkFPH1D3GSqeIki/Vcs4uO8el/cT2by+r/VCZu
         GjzWukE6fxBwziqonJWQE5zSzgCqm1yMu9g9FDNByiUiuHkv86qFcxTXPhO1hxmpEer2
         zOX5sEfQmGCEykoVyC932+bNBNksfamZ6QChcJ+R15tZMMCORLaRd4xFLtTOxGTikkqG
         Eu7+0FAs5U5/DjJFBpbN6sKu0D3HvOfkzR9YU4ab9MeIEf3LjYlk5hwmow3ijDaqyqWp
         9q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ub8AeLNqSlmEQNIGyq/3dARpdR1OqwGD6uBEc1fE3w=;
        b=resqyFBIxp9NFODTQYa4vn2sH3WDevVAaly8sPOG2yRO75+5ZYBVwz6psRMI+lCwcB
         5OOmi8Hbz+h1GUaVgSjM2cAfcXk1qT/XaVDQKWRBzV0molAYHnc/esGH2lk1BWBvDXLm
         fXJHRkTp5bcq6shb5JGIyhH3Vkv3cDjswamzXvPwMtiMS/NobIbsmB4RRXnezxM62rp8
         1vqiIIZZ0WHGJSzzuTgpaWF/YaVOJXatWtdI5eQbY/9CVqmDHAJmTOndE5W+anRAVHbs
         mLbsJ42i0/Hk1qpFH86oVtbi+0wSc/pzAhIdITgmMluY7X5kb76XBIJAd2NBUufJN9Ze
         h1gQ==
X-Gm-Message-State: ANoB5pkep/RxtxwnC85xgAEkCVxFetXZfzsZUcocFNG75x+nXzCdboFe
        l/Tuh86CgZBpO187MX6JDMuJ2h/RPFGRSA==
X-Google-Smtp-Source: AA0mqf4yUNH2DjxhyFGPFuDFapcxGqZcVI9+HEe7ZQ+nK/bt5nojGgJgXBEUqGGmIaeomWYvcdRsaA==
X-Received: by 2002:ac8:66d4:0:b0:3a5:3388:4093 with SMTP id m20-20020ac866d4000000b003a533884093mr5242554qtp.262.1668744905422;
        Thu, 17 Nov 2022 20:15:05 -0800 (PST)
Received: from [172.17.0.2] ([20.7.4.241])
        by smtp.gmail.com with ESMTPSA id cm5-20020a05622a250500b0039853b7b771sm1450831qtb.80.2022.11.17.20.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 20:15:05 -0800 (PST)
Message-ID: <637706c9.050a0220.6e5e9.7af1@mx.google.com>
Date:   Thu, 17 Nov 2022 20:15:05 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6267572113287917150=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.
In-Reply-To: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
References: <1668616931-21987-1-git-send-email-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6267572113287917150==
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
CheckPatch                    PASS      2.55 seconds
GitLint                       FAIL      0.53 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.37 seconds
BuildKernel32                 PASS      30.18 seconds
TestRunnerSetup               PASS      419.61 seconds
TestRunner_l2cap-tester       PASS      15.73 seconds
TestRunner_iso-tester         PASS      15.03 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      102.99 seconds
TestRunner_rfcomm-tester      PASS      9.15 seconds
TestRunner_sco-tester         PASS      8.56 seconds
TestRunner_ioctl-tester       PASS      9.78 seconds
TestRunner_mesh-tester        PASS      6.63 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      5.60 seconds
IncrementalBuild              PASS      31.44 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets.

1: T1 Title exceeds max length (96>80): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."
1: T3 Title has trailing punctuation (.): "[v1] Bluetooth: Add hci_nxp BT submodule with controller Power Save feature for NXP BT chipsets."


---
Regards,
Linux Bluetooth


--===============6267572113287917150==--
