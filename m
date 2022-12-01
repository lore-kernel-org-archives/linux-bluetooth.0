Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8576C43217
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Dec 2022 17:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiLARQW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Dec 2022 12:16:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiLARQU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Dec 2022 12:16:20 -0500
Received: from mail-il1-x149.google.com (mail-il1-x149.google.com [IPv6:2607:f8b0:4864:20::149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D1DAD9AE
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Dec 2022 09:16:20 -0800 (PST)
Received: by mail-il1-x149.google.com with SMTP id y12-20020a056e021bec00b00302a7d5bc83so2558083ilv.16
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Dec 2022 09:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Psthd2nOor0WdtpRYrBH3/xYRZoSvRo+NzJMZoRjC+s=;
        b=R9BYYHAjDVbCl6OMJ0MX9iALLHfwkVgMZpe95zpa8MSOoIOw90cJhCDmSZsSPDCVQr
         g35DhAWitposo9LE6BfmjWzrPh3BIzwg1P1ARWsyMJLio+RLmGVmk6r1+tX8EieO48AI
         QQfMDpTR82lSAqPG7waHOiwPE4U2CI06gPf/BnELRXcDyXZBD025ViP80Rxav6pD4Fx8
         bvRRh3MkrKpMGky4tRyf1NPXxaYA+Lvah33DubxzT3dL5GboKT3aDBmLg2G1qR5cTqWX
         zxBKkFelTyNEtprGGmv3qKamy4BNqaLQOUcRSjs8CfM3PBDuLC4KsAeo9qfBV8JnQRrW
         cjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Psthd2nOor0WdtpRYrBH3/xYRZoSvRo+NzJMZoRjC+s=;
        b=2YhECvQ+J5pakzcJDHzMAUtv1BjDurFQUOiTvSG58e2U4LsyPMd+SSQ7M05N5KeD3B
         hi1VeBy9juHkVexv7mXAZo92/bkVGHq8wbG1q2UyDCaCJZP4eJvDxz5adQ3GHbNUHa/w
         AJzm1QeLH1Mw5u9LWvyy/JyHy+FIXTr6AdEd8rRF5AcHRhnlVdRV9v03S606Hcyl7fEM
         sNpFzKA3zvp2ebrMBYdC6HaWW9t2YpWp0upNTLShneFurxlBvinIZAqi9GwWN+bbq2Ky
         pHQKfUjnD3gB4CFzT2WE1yzypp4YOJr0nhNbl7pdTa40Ca9cpzU7uKbZTLOw3SSOpHmO
         ddvw==
X-Gm-Message-State: ANoB5pnO1PxOODSmVHnKezrmRwX0vDLLFxoR8b0ZPSP4M7XJDtCV/flz
        n3iuon4N7+mgNUeusYN9itmPaO1bVwbn6SL1GjBp4XwhXwSfTcNXY5HJFNzjfyRwenSr62FEVsN
        daC/Q+4hV/Rhc5us0qUr844h1B07bdg+xZE63Yz+SSH55+rZLmiGPxF9lhEHKDHnL8f+TbtaVDL
        ysQxMsiQ==
X-Google-Smtp-Source: AA0mqf504B+7KdP764ZuGg4iUnKJBQ8iJ6ygBjHjHqH/SHpmnyban2EiCbZ7H5J4ijGFbTBuq7+6DsoOkiZg/q8=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a02:5146:0:b0:371:1431:d4f2 with SMTP id
 s67-20020a025146000000b003711431d4f2mr32644725jaa.184.1669914979560; Thu, 01
 Dec 2022 09:16:19 -0800 (PST)
Date:   Thu,  1 Dec 2022 11:16:13 -0600
In-Reply-To: <6388e0a6.020a0220.7a53b.4ef2@mx.google.com>
Mime-Version: 1.0
References: <6388e0a6.020a0220.7a53b.4ef2@mx.google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221201171613.1819631-2-allenwebb@google.com>
Subject: [PATCH BlueZ v3 1/1] bluetooth.ver: Export sanitizer symbols
From:   Allen Webb <allenwebb@google.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix llvm sanitizer support by not hidding sanitizer related symbols.
---
 src/bluetooth.ver | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/bluetooth.ver b/src/bluetooth.ver
index 214fa8a61..a96fda2a1 100644
--- a/src/bluetooth.ver
+++ b/src/bluetooth.ver
@@ -7,6 +7,14 @@
 		debug;
 		baswap;
 		ba2str;
+		/* Don't break LLVM sanitizers */
+		__asan*;
+		__dfsan*;
+		__lsan*;
+		__msan*;
+		__sanitizer*;
+		__tsan*;
+		__ubsan*;
 	local:
 		*;
 };
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

