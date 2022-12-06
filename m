Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CF4C352A1
	for <linux-bluetooth@archiver.kernel.org>; Tue,  6 Dec 2022 13:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234173AbiLFNpf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 6 Dec 2022 08:45:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234265AbiLFNpZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 6 Dec 2022 08:45:25 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570A129C82
        for <linux-bluetooth@vger.kernel.org>; Tue,  6 Dec 2022 05:45:21 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id p12so10380713qvu.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 06 Dec 2022 05:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O5HCTN0S4c5Yu/70glWSHknlwS4NFcaOTz1+d9xbeAY=;
        b=AEn4UFNe0JK8xaT5PzYZCQG6TL80KoRFrqYxjYQ393jVEhWB2tPpH2+fkxpPL4xPK4
         wS+ylFtEL56BNEZjP6t/KKwRwa9JRFVO7LzHB+MsnC6zP4TI6fwtD1SWd8848g85DRMw
         83VUXc9KsaFtoRxM3nHSzpGF3yrQT5jd/bjtlpCWXF8nt6cvs+RmOyOSgRivVv4AMfLn
         hyuWPsQfgJ3Jw7WuCGe/tHUfpExD5/L2vyT0RecoCNFanpPuNSiymaBKhmKVvGhq7SEf
         HcuFoekvHIr9tqvQPvjje5nxGRf4yBNPB1mHffC0/2fywvFuOmoV3/vq81yXNSUNac0N
         g4UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5HCTN0S4c5Yu/70glWSHknlwS4NFcaOTz1+d9xbeAY=;
        b=BAbMfm7PxGlgdYsflh1FzqcgHjufNYjWARaUj6Qgnj5tJ4E1rbKCOl9EiC3hmErfWY
         RHP00vSqIGWLlK8HdLB4gub3NWI33BWHKgi7OGhu635vHA3UOTMyIATAgFYoguFS3dCl
         tyeA6udqa1Ym3G4Qhhqc6yjfxOiQqaNfTcCnnMaPsjJt5n9QcGav7L+FHP+AS83L/zRb
         HV0HHeGBfyi5RKNFb/HBli1JaWa0OJmjEWvRSTdn0iVPQO77ggDVZ+BtZwF/gDaazNy2
         44aXEJg75Kn5sQn4ix+tlA8PEwj/hOEAE3dw5pnaYhOWIJLyPwx22UvfVdaQ8nB5ReKt
         3hXw==
X-Gm-Message-State: ANoB5pkP16TRZL2xeTl6S0iT/vMmMjuIpQyjP2T7nyct39t95kmbJOaB
        qJ67XzEl4Wn37yqeaP3f1vSKiCcs6CkxRw==
X-Google-Smtp-Source: AA0mqf5Dawpg8Sc+BzffNb/PwuCWhV/rKZdJcDs7CcQRe72WKvgeBS1itzq9tecYirh/g6dDd/2aTw==
X-Received: by 2002:a05:6214:3002:b0:4c7:14b:18a3 with SMTP id ke2-20020a056214300200b004c7014b18a3mr36291247qvb.41.1670334320353;
        Tue, 06 Dec 2022 05:45:20 -0800 (PST)
Received: from [172.17.0.2] ([172.174.26.86])
        by smtp.gmail.com with ESMTPSA id br8-20020a05620a460800b006faf76e7c9asm14781391qkb.115.2022.12.06.05.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:45:20 -0800 (PST)
Message-ID: <638f4770.050a0220.d0660.c5cb@mx.google.com>
Date:   Tue, 06 Dec 2022 05:45:20 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============3811104520343975490=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yangyingliang@huawei.com
Subject: RE: Bluetooth: btusb: don't call kfree_skb() under spin_lock_irqsave()
In-Reply-To: <20221206125910.2170554-1-yangyingliang@huawei.com>
References: <20221206125910.2170554-1-yangyingliang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3811104520343975490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=702185

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.08 seconds
BuildKernel32                 PASS      29.90 seconds
TestRunnerSetup               PASS      427.20 seconds
TestRunner_l2cap-tester       PASS      16.35 seconds
TestRunner_iso-tester         PASS      16.22 seconds
TestRunner_bnep-tester        PASS      5.55 seconds
TestRunner_mgmt-tester        PASS      107.08 seconds
TestRunner_rfcomm-tester      PASS      9.52 seconds
TestRunner_sco-tester         PASS      8.95 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        PASS      6.96 seconds
TestRunner_smp-tester         PASS      8.74 seconds
TestRunner_userchan-tester    PASS      5.80 seconds
IncrementalBuild              PASS      30.85 seconds



---
Regards,
Linux Bluetooth


--===============3811104520343975490==--
