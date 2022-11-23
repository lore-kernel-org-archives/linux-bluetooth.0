Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1F0C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Nov 2022 09:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbiKWJA3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Nov 2022 04:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiKWJA1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Nov 2022 04:00:27 -0500
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E13FFAA7
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 01:00:25 -0800 (PST)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-142306beb9aso20073768fac.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Nov 2022 01:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zCyrFB2zuxHn9K17yQBh8wNGJKg8KQfpKd3VOPDXQZs=;
        b=bs09XflHvCucav/+mJ2ghAsT6oRL5lZTLMP/6UOWmfqkx+1xIvCKbuQtciv10uRySn
         6+pwZgSPeecDS97Bb3nuLzJMwDRnWpwSvCVASr9kcX4ZmN7SGt9yjJBHfvEp02HO7qCk
         ummNqew+OdglF6OPOJP2yvejSazjqH67SWEGEsIcDs79StC2XeVnq96mB/oejEm8vDE2
         B+RZ7ifgl6FXuAXEJnNHqyzDyqxxT90mhsogltO7XImrdA7Nfcg2wHstZ1hhE/qfj0K5
         5pdQjDKVHFhJEmgASpLpoVqOzZRWs5qTQDEPM43B98XsVFAGYJMKDhMtahW7Pxs9807S
         Scxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zCyrFB2zuxHn9K17yQBh8wNGJKg8KQfpKd3VOPDXQZs=;
        b=YLDsen0gawrdCgff9eGAjMRk+iqqyvwXmz8z6+3nKyShOypO/950Jo8rsPuSNfngwv
         vhZspe6BtTdiZZ/J/MX/9xH+T1EXiLkDQTv5bEoVZCU0j8O2Mo6LrwXS//UeRYSAja0f
         U/yvsO2t/UNqEZLW3Ec9Kbqr09Q7XGCruzL/jJKCBr2edSe18fD5fYqhIXFT4lvgR8rL
         jD9PsmsRneP73ZTZ33JepKx693Q90WdXuDgGsVfJ9dzGGzfXtn0PIO4BOOg7s9ggSym+
         O1D+WJlgU131DD30UEPG/xWzJIAdpu1GEcQjdXiAckebZkI0ONQn/YquLc4c5B9ZaRce
         e9Nw==
X-Gm-Message-State: ANoB5pljHRX2oFTDNYV31EslPukVru0OC2z/nSOgyGGFbHWBPKK6ci+s
        bSLGxnRS96J7SHgjHVqvrkzVGDOBS7Y=
X-Google-Smtp-Source: AA0mqf6luT6gVhQvxuqwW3Wz7NzKc8ZHCK+1y2IGzjsgU9lmuSQOZrSHoELlRRKtNmMx07/32MIy2A==
X-Received: by 2002:a05:6870:ab14:b0:13b:8760:5f2b with SMTP id gu20-20020a056870ab1400b0013b87605f2bmr7282803oab.251.1669194024415;
        Wed, 23 Nov 2022 01:00:24 -0800 (PST)
Received: from [172.17.0.2] ([13.66.10.164])
        by smtp.gmail.com with ESMTPSA id l16-20020a056830269000b00655ca9a109bsm7015650otu.36.2022.11.23.01.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 01:00:24 -0800 (PST)
Message-ID: <637de128.050a0220.1488f.a4c5@mx.google.com>
Date:   Wed, 23 Nov 2022 01:00:24 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============6014675261776983545=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dukzcry@ya.ru
Subject: RE: Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0cb8:0xc559
In-Reply-To: <20221123081005.70536-1-dukzcry@ya.ru>
References: <20221123081005.70536-1-dukzcry@ya.ru>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6014675261776983545==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=698361

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.28 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      33.44 seconds
BuildKernel32                 PASS      31.03 seconds
TestRunnerSetup               PASS      418.59 seconds
TestRunner_l2cap-tester       PASS      15.72 seconds
TestRunner_iso-tester         PASS      15.01 seconds
TestRunner_bnep-tester        PASS      5.23 seconds
TestRunner_mgmt-tester        PASS      107.58 seconds
TestRunner_rfcomm-tester      PASS      9.18 seconds
TestRunner_sco-tester         PASS      8.51 seconds
TestRunner_ioctl-tester       PASS      9.82 seconds
TestRunner_mesh-tester        PASS      6.60 seconds
TestRunner_smp-tester         PASS      8.43 seconds
TestRunner_userchan-tester    PASS      5.53 seconds
IncrementalBuild              PASS      30.94 seconds



---
Regards,
Linux Bluetooth


--===============6014675261776983545==--
