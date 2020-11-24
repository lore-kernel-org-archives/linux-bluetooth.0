Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F0C3C63777
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:19:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94CC720757
	for <linux-bluetooth@archiver.kernel.org>; Tue, 24 Nov 2020 18:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ru9OPmuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390865AbgKXSTB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 24 Nov 2020 13:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390831AbgKXSTA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 24 Nov 2020 13:19:00 -0500
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5F3C0613D6
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:18:58 -0800 (PST)
Received: by mail-qt1-x84a.google.com with SMTP id 7so16755307qtw.23
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Nov 2020 10:18:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=i2m7YDYOT5uHHaISPqBHjtLwegG4QjUHbJNmnHdHOu8=;
        b=ru9OPmuTsJDBYf11/Qg2/bJIXPEL506HmWRYJh9rPy1A1QjsJgEHcvAHU558Anz61D
         NpE1Ms469g/yN2u2sNH6CydsXoqqmL8WaQ39IwAXdcbxDLN/fOmN7F7a8X3nf+sM+Dcs
         W7JKCGL6F/Z8OFjJ3SNdxPR8UmJB6dc0GVyeTak+GgQUbRUv293lm8H79xd1PLkHJ8N6
         ryXYzbBW+bt0KxyOK1X5ksnFf0ikgd4SEUNF0FuNtB6NodOJTleL5QEcDxqx3HYI5+L3
         sevaN573Wrz7zxfsK02Qt3mpOCZL/M5dim+m9CPqwTvThEMt4vs/74vAJuyqWx45wm9F
         H9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=i2m7YDYOT5uHHaISPqBHjtLwegG4QjUHbJNmnHdHOu8=;
        b=IKqlfekOkhgikJ4NhiW8Vatc3AWXcEw9RxVLtlAXm27vJFByspU1aUp0LCHyjGSK/q
         wu+Vt6LcHSc6j8NfLJOOITvZLlqbN4Yo1riTuj9EyVHdToBzq1/LaQr4gSpetTRgMYIi
         RtrA9miO++YO08SKMKHygGqUkzFd0V/5e91GWOqW+KISqL3c/cV2UtvgRuErhiQxvdov
         pLJYRC0n6Q1z2C5Qe5AroTv8HaKxn3gcIqColIv02adN78Uji8Tmsc7cSv4SE91P3Rn1
         t23Go9u4V+LgkAH6iCyvplxfcSLnJVJOlh8Ky92oHWIdkm5ffJfVvFhKQnpNrawkqWOc
         dNzw==
X-Gm-Message-State: AOAM531jCsdBL3maIgvbeJd1E+MULveL2ccpzbP+NhGCLoygjS6fb3sS
        UlrHL4v71geZHKaTRpaxXt8Ap5DeaKO2PXrYNr2z
X-Google-Smtp-Source: ABdhPJxCiCT7/frdaDfBa0Z9aFi7TjqpLsKLD+Lz49HleMqPUPQixk6APU2dF14Xcxr+wfO3elC2y/7+pX1kABWrgqag
Sender: "danielwinkler via sendgmr" 
        <danielwinkler@danielwinkler-linux.mtv.corp.google.com>
X-Received: from danielwinkler-linux.mtv.corp.google.com ([2620:15c:202:201:f693:9fff:fef4:4e59])
 (user=danielwinkler job=sendgmr) by 2002:a5b:389:: with SMTP id
 k9mr7215470ybp.75.1606241937969; Tue, 24 Nov 2020 10:18:57 -0800 (PST)
Date:   Tue, 24 Nov 2020 10:18:50 -0800
Message-Id: <20201124101832.Bluez.1.I3f5d0cd1842ec756731360d5ef1a6c5eb8543336@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [Bluez PATCH] doc/mgmt-api: Minor reword for Supported Min/Max Tx
 Power doc entry
From:   Daniel Winkler <danielwinkler@google.com>
To:     luiz.von.dentz@intel.com
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Daniel Winkler <danielwinkler@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch corrects a minor wording issue in mgmt-api that didn't align
with the implementation.

Supported Tx Power -> Supported Min/Max TX Power

---

 doc/mgmt-api.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1aa43d6c3..cce6d0c64 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3131,7 +3131,7 @@ Read Controller Capabilities Command
 		0x01		Flags
 		0x02		Max Encryption Key Size (BR/EDR)
 		0x03		Max Encryption Key Size (LE)
-		0x04		Supported Tx Power (LE)
+		0x04		Supported Min/Max TX Power (LE)
 
 	Flags (data type 0x01)
 
-- 
2.29.2.454.gaff20da3a2-goog

