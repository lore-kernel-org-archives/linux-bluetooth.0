Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B1AC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:58:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiKRF6U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235132AbiKRF6T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:58:19 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A8A8CB97
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:58:16 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id s20so2811864qkg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DpqBOvc9+GlSLLx7h9GdXbx2ilZofHdsAjYOSBDXE7Y=;
        b=ZMWPXSBxopUUTTZk5IAtWb/P5P+Tsj+ngLGgeVBDxrDCb9zkchVYDFxTUS2qbCIIRX
         RVjrBVN22KT+LsYkX6Eomsi6VXp6sepAwlE9USTRKlvhniX9TrHp05b3O0Z63EnC9g7h
         IPCzwWSFI8/NBUcSiCuJ1NXzxjRriWugH5dccFNmSHJj3WMhXRzt5MLpJwz2p9ZHc7Fc
         i5VHjsOtQ1VCBPs6aVwA9CR7p0q1dpRBtWsZqIXpFQDCeMTOn9h+l68cIk5ip6G6P1Cb
         1v1arnTl2c4l2cl4EqCClShCGYGTWGVFszFhYDJLJCNMInHluf3tUh1iQ689FA9sYr15
         6teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DpqBOvc9+GlSLLx7h9GdXbx2ilZofHdsAjYOSBDXE7Y=;
        b=dO2R8jDGs9+0rLao4vUzTm6W8x2Sdd46zxaMEEIdcA6gsJS6UaPWdV1whYYhWDmgkP
         qcaiiJbxSax+NQ4gBMFP30jmweCfVw02JcpWS7s1t1xf/kGv6kUowhiTCG38Dz0XnC8T
         05iLxysu4zNeAzq0QVl9kCSmgKz502H9FZdp4RX2wloBeUuxa+lcFGBLdOuSnyUvCtn6
         LnvY4FoWS/A4XMnIAD7fmdEwDmqZLUwhxXH1jRvoczE8NwsOdf2A97/1hdmnxZZch/6Y
         jH+XnDJ0PYIZNAbT0u3kE8ItF9MzAR8Ou9mt7T4bzCQF+/sIzTbzAY50Gmy3t4YzwgLG
         UQ7Q==
X-Gm-Message-State: ANoB5plPctJl9tx6+ddSjomi+L9IA84ITF1IlOjgtyqJ4kJrbjYrEl97
        Rj4zfjeljyL1pMnaAEh9ZXVr8k043kpeGg==
X-Google-Smtp-Source: AA0mqf5+6vu1DvIml/bVZdPvGJYhcdSG1BgT3c2XvUl/w3zT/FacyNypyXq6TqcmUw4ARF7REfB6TQ==
X-Received: by 2002:a05:620a:1905:b0:6fa:6636:a7b0 with SMTP id bj5-20020a05620a190500b006fa6636a7b0mr4687691qkb.55.1668751095393;
        Thu, 17 Nov 2022 21:58:15 -0800 (PST)
Received: from [172.17.0.2] ([172.173.177.202])
        by smtp.gmail.com with ESMTPSA id fb13-20020a05622a480d00b003999d25e772sm1552074qtb.71.2022.11.17.21.58.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:58:15 -0800 (PST)
Message-ID: <63771ef7.050a0220.87913.8018@mx.google.com>
Date:   Thu, 17 Nov 2022 21:58:15 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0522791954830556031=="
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

--===============0522791954830556031==
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
CheckPatch                    PASS      2.88 seconds
GitLint                       FAIL      0.57 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      38.75 seconds
BuildKernel32                 PASS      34.66 seconds
TestRunnerSetup               PASS      492.50 seconds
TestRunner_l2cap-tester       PASS      18.22 seconds
TestRunner_iso-tester         PASS      18.13 seconds
TestRunner_bnep-tester        PASS      6.60 seconds
TestRunner_mgmt-tester        PASS      119.29 seconds
TestRunner_rfcomm-tester      PASS      10.84 seconds
TestRunner_sco-tester         PASS      10.05 seconds
TestRunner_ioctl-tester       PASS      11.63 seconds
TestRunner_mesh-tester        PASS      8.09 seconds
TestRunner_smp-tester         PASS      9.86 seconds
TestRunner_userchan-tester    PASS      7.00 seconds
IncrementalBuild              PASS      37.13 seconds

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


--===============0522791954830556031==--
