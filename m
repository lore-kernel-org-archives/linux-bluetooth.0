Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3353C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 May 2023 09:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbjE3Jgf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 May 2023 05:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjE3JgQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 May 2023 05:36:16 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06961123
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 02:36:15 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6af74ca9f4aso4045794a34.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 May 2023 02:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685439374; x=1688031374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u8VY6JcgKUjNU0+3HFTJs6ldrakoS04hvyjo+ha2rdw=;
        b=NxAXlelmoG58QS1cmmmVbEDlt6ElBBLBVPF2shKz30YE3LXRQ/D2S41VkuK5EDXg0E
         051poGCpucOs+zFqIKsoTda3SfTs4mlR8M2T5e/tGC35YF2sZJszX93qaA7Yqf7zA2Bd
         OrfXgiqKJQq8lUxzDwAx2Qkbxytol/O9qPujJqUYHlaJkVvdduuUdzINbAN82cDHbqcq
         Jm26SHdOOeqpjy/qF5TsJHn3qGOkhFl3nmxB8aEs82anNpWpc6FWhKvUxNKoMpqvy+PQ
         O4M0yXVAinFBPgcznmHyGbLqfUlqQi/0c7WwG+lkrU7eZsQ8zU74ImpuVMw5ShAvyE/B
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685439374; x=1688031374;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8VY6JcgKUjNU0+3HFTJs6ldrakoS04hvyjo+ha2rdw=;
        b=VfqZ6kKhLfdrdB/FX5TipY03YJ9okRsRPMni5xhjgfwlpH8Lh3nS4LqUC44YLrhsyq
         jaE34+wdoJkI62X7G8/4EKATMYxuGMJy5/MbXt+UNEc8SHIyxYwlfnp6/9GN76sEDCWg
         o6wZ3u6v1e2Zpz9x3Bs14YrQ3W9bMF82/iYGz7SRrEVURnecI2WpmTqQ9+PRq9/fvuES
         SOTxBvHDf1cDLLVX68esYYieKb/roYsp34wrY2j0PvBAO4/Vsnf5MOxo9VYsRYbks2tR
         3tPj2FKedhpNzuJndJtvZGcEef6QIq1Yz2T3Tdlhu/cQet/iYC5wvrCCUTSLhDi8n5JS
         TM9w==
X-Gm-Message-State: AC+VfDw/vl6jCFZMmf6OF7Cehlm9bnN2H9edPujfV2PBFw9drkcVEOyN
        pNrZEfneKNaDK+peBW55jCbi3rZoAfE=
X-Google-Smtp-Source: ACHHUZ7yJBVUAeK5fyxlXCwiXQOF7Sbxxhgl343i8ZNe3ZUNsT10xe9DG5coVtbXma6XGzzF/88/IQ==
X-Received: by 2002:a9d:61d6:0:b0:6ab:30f3:6e69 with SMTP id h22-20020a9d61d6000000b006ab30f36e69mr969341otk.15.1685439374158;
        Tue, 30 May 2023 02:36:14 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.8])
        by smtp.gmail.com with ESMTPSA id y23-20020a0568301d9700b006a662e9f074sm5381161oti.58.2023.05.30.02.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 02:36:13 -0700 (PDT)
Message-ID: <6475c38d.050a0220.647b6.8487@mx.google.com>
Date:   Tue, 30 May 2023 02:36:13 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8862698790808227890=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, max.chou@realtek.com
Subject: RE: Bluetooth: btrtl: Correct the length of the HCI command for drop fw
In-Reply-To: <20230530083420.6876-1-max.chou@realtek.com>
References: <20230530083420.6876-1-max.chou@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8862698790808227890==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=752085

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      39.19 seconds
CheckAllWarning               PASS      41.75 seconds
CheckSparse                   PASS      47.01 seconds
CheckSmatch                   PASS      128.01 seconds
BuildKernel32                 PASS      37.57 seconds
TestRunnerSetup               PASS      528.54 seconds
TestRunner_l2cap-tester       PASS      19.53 seconds
TestRunner_iso-tester         PASS      25.48 seconds
TestRunner_bnep-tester        PASS      6.89 seconds
TestRunner_mgmt-tester        PASS      130.99 seconds
TestRunner_rfcomm-tester      PASS      10.87 seconds
TestRunner_sco-tester         PASS      10.03 seconds
TestRunner_ioctl-tester       PASS      11.38 seconds
TestRunner_mesh-tester        PASS      8.57 seconds
TestRunner_smp-tester         PASS      9.49 seconds
TestRunner_userchan-tester    PASS      7.19 seconds
IncrementalBuild              PASS      34.76 seconds



---
Regards,
Linux Bluetooth


--===============8862698790808227890==--
