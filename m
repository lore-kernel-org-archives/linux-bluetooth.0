Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E34FEECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Sep 2022 00:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiIHARq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 20:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiIHARp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 20:17:45 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF69AA3D8
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 17:17:44 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1280590722dso6713634fac.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 17:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=fs214b6fifRBJMBCdqOHgR2IrPphOUbHr3/QeVjU8uQ=;
        b=NdkVw0I8L7t0djhA+tdNW5gA/tDHNgJ7bBYwZvSX6IM0syiAjcz2ZQNvqcy0vYq0+3
         4Hib/mVsfJ5x9RKiV2C60SBCHU02kc4qB7qmJiL8KCRxZwk2HFRXd0Sf1sjrR8bqMhHA
         H57/uNz4p8eaRFniT2xPZmXggpg4S/zC/JPUuXs5/sjI37S2P03VowA/nlwLyXKQOnmn
         dHs+cvkdXLDwP5GvPcimQkkIP9jUozs+qXkrrZo6eKMecrbYaAeuVrwtAWLkSKMUNlEB
         yXJ4xC9mQyvHfr8NoOIlnYjbWpwGGKUtjSymwQlxTswtDNceC36K0gI2Xe7C5Ix1zerk
         Jyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=fs214b6fifRBJMBCdqOHgR2IrPphOUbHr3/QeVjU8uQ=;
        b=hrLNrDuO0hlS9NgBAEo6LQmjXcbwp054HiuaifEd6OoXbAjwOdwVDJPAEriOXOChnS
         yONjw2T0D6LSo3O2sSlXiNuQbSnn51+DctmJ1k3nundRpGbzsM2aMgirY/cuBy8Y2hMg
         ZVHHa6nyz+r8NAeaBwb8QxfBQCfFMU6N+pXMjD2AU3et/EGAYykDAu+2dGBj8Ia7SKa2
         Z9K8jeWXbthSN+W/5QuKEWRWracRM1fh2q7hFZadCv6WU2vNEEfAiAKmPxDL6OsHWQf4
         Vlu1w6eXMulKwzjLn8Aoc7JsTloVJQmQSxgAlpDLHMsNavtdq1pWorIVu+4l6ynCqoBJ
         V3Rw==
X-Gm-Message-State: ACgBeo1iWQhDvZp2C0ROtPYUm4+5ET9yoZNH5csSZlFh4m/366iXdPZx
        UvQ4TPrabsSaSuNZwbBqSPXTSg5ovuIb0A==
X-Google-Smtp-Source: AA6agR7XicCfShfRgAAgz37rziqv1w78cMWVuYlIecNudFf+kYiXEwoYCI/lCqTUtY/EmWZTKh9N8g==
X-Received: by 2002:a05:6808:181e:b0:344:c78e:7e86 with SMTP id bh30-20020a056808181e00b00344c78e7e86mr391697oib.223.1662596263634;
        Wed, 07 Sep 2022 17:17:43 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.190.230])
        by smtp.gmail.com with ESMTPSA id x14-20020a056870a78e00b0011bde9f5745sm8553240oao.23.2022.09.07.17.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 17:17:43 -0700 (PDT)
Message-ID: <631934a7.050a0220.d2d76.fb33@mx.google.com>
Date:   Wed, 07 Sep 2022 17:17:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4117941793654988831=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: MGMT: Fix Set PHY Configuration command
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220907232232.3248525-1-luiz.dentz@gmail.com>
References: <20220907232232.3248525-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4117941793654988831==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=675023

---Test result---

Test Summary:
CheckPatch                    PASS      3.90 seconds
GitLint                       PASS      1.73 seconds
SubjectPrefix                 PASS      1.33 seconds
BuildKernel                   PASS      48.30 seconds
BuildKernel32                 PASS      43.32 seconds
Incremental Build with patchesPASS      103.45 seconds
TestRunner: Setup             PASS      716.81 seconds
TestRunner: l2cap-tester      PASS      21.36 seconds
TestRunner: iso-tester        PASS      22.48 seconds
TestRunner: bnep-tester       PASS      8.75 seconds
TestRunner: mgmt-tester       FAIL      140.53 seconds
TestRunner: rfcomm-tester     PASS      13.52 seconds
TestRunner: sco-tester        PASS      12.75 seconds
TestRunner: smp-tester        PASS      12.71 seconds
TestRunner: userchan-tester   PASS      9.03 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 140.53 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 491 (99.4%), Failed: 3, Not Run: 0

Failed Test Cases
Get PHY Success                                      Failed       0.164 seconds
Set PHY 1m 2m coded Succcess                         Timed out    2.716 seconds
Start Discovery LE - (Ext Scan Param)                Failed       0.188 seconds



---
Regards,
Linux Bluetooth


--===============4117941793654988831==--
