Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66020C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 06:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235089AbiKRGew (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 01:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240996AbiKRGen (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 01:34:43 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544596455C
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:42 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id k4so2828737qkj.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MTi6t5Dfl2LsEAyQuxqzUtV68wX+wF7CqygYrxk6pGc=;
        b=ZffhYBZhnsERckagSibgbVVCk5SbsUL4SBSayBcz8GpoZV/FtovvsAW8c6ybuVO2pv
         wjzlSA8KDl5vWr6jdcPGxRe3BSxfBhdhDANqZE/m0EUqxERvVKTQR2FmbVomf0Gp1+l0
         FQp+jjYR9hACjcAijLkYYOuQ6XCfeCsj8pB0dXnW/fXIsgTUslDXznc/sNVrXOQR1hfs
         d8HxYraczqve3UFN4UXV40TWCmQhdytWIoEozZJ46RM5Z14TecdMo/hpBhqUBk3GQLaG
         00b7yLzbSYJh+4WTe7SpuQLnBS/sYDl69iW0rR9XOjDydSemv2moDiPZyng6miWQeGv6
         hBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTi6t5Dfl2LsEAyQuxqzUtV68wX+wF7CqygYrxk6pGc=;
        b=o2Vt53rWiuAEv/Kc/tcViDDoX5M/GEgXrp3BRZlVgan/zTJ+EUFqy2+DQRCCoit7xT
         u7upp2equoY3FtHkqaUDWJ8oXxM6J7zqMYjsf/RaGWltcxcXKTZVOVFl3zuV5ZIJMmNb
         80+UWPcFD1VHQJKTkpC3P9Khll4ocKr5/LzOfoV0ewKtyvw+WRkoMEZhp8Zv9a/hwAdp
         Mmu5qA/+IhraRMxihf8zL7c28NloziWv+U8i0gB6zM7hPdizJ5n7IsTK+ZAxFkwmsZHk
         R0FWwTrT7jlVFUWQHPSthlkLA9OZJxT0GcHxr1kMTM3F+JSYSwEqjzEsi9RDV4ol7rNQ
         JFHQ==
X-Gm-Message-State: ANoB5pn/of0hlqOhA+1pgFNle2CenS5X0zNAymouMGPdLKnWQOamxjS9
        pWuLlrVu98Dh/B/pc5TLXuRAyCKD27WW/w==
X-Google-Smtp-Source: AA0mqf5/6E6NawxgBlbzeDK2JevWwEAdcnIzex+ffqzmSFNzJaPJ1v0Fjdoc1WEF/qm5M+RpjDYhQA==
X-Received: by 2002:a05:620a:1185:b0:6fa:4af5:701c with SMTP id b5-20020a05620a118500b006fa4af5701cmr4860271qkk.13.1668753281372;
        Thu, 17 Nov 2022 22:34:41 -0800 (PST)
Received: from [172.17.0.2] ([20.1.130.88])
        by smtp.gmail.com with ESMTPSA id ay34-20020a05620a17a200b006b929a56a2bsm1929939qkb.3.2022.11.17.22.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:34:41 -0800 (PST)
Message-ID: <63772781.050a0220.7ec03.961c@mx.google.com>
Date:   Thu, 17 Nov 2022 22:34:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8832919031077058908=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8832919031077058908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=695798

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.95 seconds
BuildKernel32                 PASS      30.18 seconds
TestRunnerSetup               PASS      423.43 seconds
TestRunner_l2cap-tester       PASS      16.07 seconds
TestRunner_iso-tester         PASS      15.75 seconds
TestRunner_bnep-tester        PASS      5.59 seconds
TestRunner_mgmt-tester        PASS      107.26 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         PASS      8.98 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        PASS      6.97 seconds
TestRunner_smp-tester         PASS      8.71 seconds
TestRunner_userchan-tester    PASS      5.80 seconds
IncrementalBuild              PASS      31.37 seconds



---
Regards,
Linux Bluetooth


--===============8832919031077058908==--
