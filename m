Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A350AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 22:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbiCCWtS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbiCCWtR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 17:49:17 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1B7652C7
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 14:48:31 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id n185so5156060qke.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Mar 2022 14:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=6S6SsOwQ1dNz9Us/GiKbsUfcGmIcrDMe0zTpbwqU9MA=;
        b=XqNo8tp83YedbK5CGFRlikhNzmF4+zksQ0EnPUcFWwT+oTP17OOaRZDBZZWR9NT8Rt
         BXd5A1sJVyexPtikLQ6KslI3e5HGEnqtcytLQCBdHqld3grIXS//AxeiGDDgnFZY/Mto
         u2CUbxmKdZRRBQtjrmtCIAlD9bIOr7CxPbrHjUdpNFXtftPyoav5o0FZoJ3sHt22h7Rg
         Cqt7DeqjO5LNoHZc/j+lsjtpPGFwOCDMtTo8gSWnYiynL2X2UfyCB0lMGlCzU9h1DPis
         pMJqV9kmE7cpI199zfvO5bJk62+pkfDW4kiRxMuoXTRHt1aCtsDIskIgIEP7X/tDtcis
         aTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=6S6SsOwQ1dNz9Us/GiKbsUfcGmIcrDMe0zTpbwqU9MA=;
        b=P/gI0B8nPtPhyix4JMUOSCrO3Ib1Mhj731kqYIBTlElrRY1UThVXELMnvUVyi4/SIN
         nAFTDdzIBJuOTyvBMDsamlhlYmRmmA7gBgQjE/u/Jk2JmRGjioZdfQdGwgnfOwh9zLrw
         KVvSt8ndH8qGx809E5si3KXqu1MJNDpGgsmr9dWYdZzo+2QiAzFa4Al8+f/v6Ae4+ma6
         wZ/XNLpuCBQIqWaEaUtYhM3PhM0SXACVFP9G19PljRwdK1XwGU4OVsfxrKmpOE5IUlmU
         drpN0mR7UUB57B/BY5t00wl79t52Mt5yQRrOR8J7mOElBpKtPkLlLRQaKQiA68UzPBwL
         lhaA==
X-Gm-Message-State: AOAM531WWm63cfjduIr+VP4CkbqqqRa3CZzY9l+TAGyQ/6JdioYHR5BG
        O8afbS08FnX0M9zM35FbpQm7pMHWYeg=
X-Google-Smtp-Source: ABdhPJynYOD1yZFf+OJy0DFslfV3TiN1sKLwepEqjwjSksJoq7Zr4qXVW8FlQObPBkcSnmnU8okZrQ==
X-Received: by 2002:a05:620a:a82:b0:508:b41b:c44b with SMTP id v2-20020a05620a0a8200b00508b41bc44bmr941277qkg.100.1646347710242;
        Thu, 03 Mar 2022 14:48:30 -0800 (PST)
Received: from [172.17.0.2] ([20.114.226.2])
        by smtp.gmail.com with ESMTPSA id c7-20020ac85a87000000b002dff4c183ecsm2435004qtc.29.2022.03.03.14.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:48:30 -0800 (PST)
Message-ID: <622145be.1c69fb81.32a86.e294@mx.google.com>
Date:   Thu, 03 Mar 2022 14:48:30 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1952141483379228124=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: Fix not checking for valid hdev on bt_dev_{info,warn,err,dbg}
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220303211157.334337-1-luiz.dentz@gmail.com>
References: <20220303211157.334337-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1952141483379228124==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=620122

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      1.02 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      38.27 seconds
BuildKernel32                 PASS      33.54 seconds
Incremental Build with patchesPASS      45.38 seconds
TestRunner: Setup             PASS      584.82 seconds
TestRunner: l2cap-tester      PASS      16.89 seconds
TestRunner: bnep-tester       PASS      7.49 seconds
TestRunner: mgmt-tester       PASS      124.54 seconds
TestRunner: rfcomm-tester     FAIL      9.73 seconds
TestRunner: sco-tester        PASS      9.52 seconds
TestRunner: smp-tester        PASS      9.56 seconds
TestRunner: userchan-tester   PASS      7.99 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 9.73 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.196 seconds



---
Regards,
Linux Bluetooth


--===============1952141483379228124==--
