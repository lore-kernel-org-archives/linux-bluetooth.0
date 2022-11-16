Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A5FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 06:08:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiKPGIT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 01:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiKPGIR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 01:08:17 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54A7E21251
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 22:08:17 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-13bef14ea06so18977940fac.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 22:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr7MXKKtvZTwmXQfGQnH9EWTa2R2cx01u8fwNJcybV0=;
        b=SX5c+mULfyZes6XBhfUB1JNjmcNL65UFOzZZXZYwzO1dDhc+hLoTADCeYzrpbgyriY
         PhU26oMqm3dINAL/DiKT1KACCMOPgKlCd6F/kfFUvM2X/NUDzcU1/lK+uP4RcN8boArK
         ZQD/Y9y56pTTzeU1lqbkFnNMlhitRGoP6emLsyvKEqoj+mwRzh+mJ/XW7G1PTrOm75KS
         LqsYZC4JH16uimqC/Yr3wKlQaAyz+smGF2mINH82m5B6wi5ZXgtIb7iAKkEzfVzh0Vvq
         fct1dLUHHfKWcgDgAWh24I5zG7hybKD7J2mMjHLIJkbMUdLSvJixZq/RojsWQUjlyzS9
         KI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cr7MXKKtvZTwmXQfGQnH9EWTa2R2cx01u8fwNJcybV0=;
        b=F0uYD/EL0smNfmjd+90rHVkjYTR2qWizn6SyjfbDuax0L9j59pmqJ69cOTMeGaF2k5
         qty5IYm4dwY8sr6NrlyhPaZCyVIGk0giyrBnTcxMyz6UaTlfy3LFg6LHv7H03qQDTHEr
         mM3VGpBzdtiP89PJ2AhTatbZjlKCjcVSUU16HLQ2KVbPZ2YDkjfILBfCT1f0j2WxLseU
         dWHiyFZ1Rvn0lX5AKlHmVUi5VwT70M/d9QQW2Ud/Nob+Kbqzq1YHTO3B9eOTvzPGWf6G
         F31umDhlGmN9FRV+9tY233SW5BQYtVNXysxrHawXvovm9jdeVDsor/B3SPlmOsc+LNkt
         D7MQ==
X-Gm-Message-State: ANoB5pnpKQHu63lzWNJprU41zZXy0+RG+yuufPn8BeXdKoKjugfvsV0h
        g4cAIVN5Xc5yWrsKQjMfvHbnrgyXkEw=
X-Google-Smtp-Source: AA0mqf47aegQTyJxWR5H+/fW2cQGWexA3ajVLj+7r2YCTG82PtsYgt/F5kqR7DfKZAwV/j1PMsSRSw==
X-Received: by 2002:a05:6870:b93:b0:136:425a:fd27 with SMTP id lg19-20020a0568700b9300b00136425afd27mr962626oab.64.1668578896464;
        Tue, 15 Nov 2022 22:08:16 -0800 (PST)
Received: from [172.17.0.2] ([20.165.24.5])
        by smtp.gmail.com with ESMTPSA id g26-20020a9d619a000000b0063696cbb6bdsm6122584otk.62.2022.11.15.22.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 22:08:16 -0800 (PST)
Message-ID: <63747e50.9d0a0220.9d52c.660f@mx.google.com>
Date:   Tue, 15 Nov 2022 22:08:16 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4353424343445154793=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com
Subject: RE: [DNM,v3] Bluetooth: doc: test patch - DO NOT MERGE
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221116052716.57521-1-hj.tedd.an@gmail.com>
References: <20221116052716.57521-1-hj.tedd.an@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4353424343445154793==
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
CheckPatch                    PASS      1.28 seconds
GitLint                       PASS      0.76 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      43.90 seconds
BuildKernel32                 PASS      39.89 seconds
Incremental Build with patchesPASS      59.38 seconds
TestRunner: Setup             PASS      656.06 seconds
TestRunner: l2cap-tester      PASS      20.52 seconds
TestRunner: iso-tester        PASS      20.25 seconds
TestRunner: bnep-tester       PASS      7.80 seconds
TestRunner: mgmt-tester       PASS      127.93 seconds
TestRunner: rfcomm-tester     PASS      12.69 seconds
TestRunner: sco-tester        PASS      11.61 seconds
TestRunner: ioctl-tester      PASS      13.51 seconds
TestRunner: mesh-tester       PASS      9.67 seconds
TestRunner: smp-tester        PASS      11.51 seconds
TestRunner: userchan-tester   PASS      8.64 seconds



---
Regards,
Linux Bluetooth


--===============4353424343445154793==--
