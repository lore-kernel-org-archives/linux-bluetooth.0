Return-Path: <SRS0=KN4I=5X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC7ABC2BA1B
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFB5D20748
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Apr 2020 08:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kTq8XMV2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgDGI4c (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:56:32 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:39799 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGI4c (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Apr 2020 04:56:32 -0400
Received: by mail-pl1-f202.google.com with SMTP id d11so1864424pll.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2020 01:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=k1OfTEDDWoKD1wyJgxjBcp+qqrvnEMjWFoVpDUtkU1M=;
        b=kTq8XMV2/n/Ie4gFML0a1XRufILkC6etTcwexxWnsdZcIRv2aksd7U0NOBuIORE+2D
         UBdxisYCl9vxt8S0RmylrcZ2/QqfdlWsPR62O4dh6dAY8bw9n7IWDtcwsqeoRCmQGpfJ
         ui2/WohJIHh97ei9HmpoTWyh6akFnhybKZAZLQFKv7zfdUPwRYMQaT4kOckSE/6B+QBl
         pgn796RcxSY4+Q7tMrUvI3bQihjRtMK4WUFp3LsCVAfOGLxeXE+RhYst3bvfVW96o7ex
         Y3e2q8FU9WHH8uCRl8vFnDOEY1XO6R5uAVYFeGpoWAqmRcJ81bO7aBXkYxRnStDUVZE+
         bDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=k1OfTEDDWoKD1wyJgxjBcp+qqrvnEMjWFoVpDUtkU1M=;
        b=LycMn2TPaX49EyZrEPurPUbIq5aHLBIc7O4D3i7hJ1e6RUCdIMomBErhF5ttnqQuab
         oJXEPB7CXmnTJg0oWf+jMbkDvuAMEnKf2Mm8QYqIf2fVfIJ0fq4iA/DrSziSY4VQx20M
         8lUEtqOdEYPwwBjym0EVfF+W/NDkYjPQPhhk8CANXrwKnJceNYI4lfnrFLsG3wrnu0h5
         FnJpmQgJMF/h21IFONADMuLFG2/hEgdn9+dowDO14S9lR8JD4p1oVEFM6H8Fuxjps6yc
         tQ8Mp2YZYTe31VnsI/PV8qytmFUqr7Toniyh9JMgJBEBA5ufJkqUaRrMlKRbWvhMOuy1
         kiDw==
X-Gm-Message-State: AGi0PubnjzY02mSJn6W8GV8jCwcO+ENemGFhInjPf+iisYuEBSGsLtyG
        edcwKi3y2UqbmJtbVp6wmXEDDb6jU2H8yRqMvldlnhTrQHFtHapld7KXcWWzW9ajPvBZ68p1Ocw
        fVV5ppKjyDl0CL4QATo6kAnAxRYrvF6vfL4skUOwI+6Vlfl4B5RNbAa1YSQ5noiBPLmYmNZm+IU
        zT
X-Google-Smtp-Source: APiQypKaOToMHUyYMrCBtqArjbNqDITE/aiYoubfZtAvS2U/HubcaIIPBspq6HElEhHIU+ucWVCVMy+JoxTO
X-Received: by 2002:a17:90b:4d09:: with SMTP id mw9mr1539484pjb.101.1586249789501;
 Tue, 07 Apr 2020 01:56:29 -0700 (PDT)
Date:   Tue,  7 Apr 2020 16:56:08 +0800
In-Reply-To: <20200407085610.231013-1-apusaka@google.com>
Message-Id: <20200407165521.Bluez.v4.2.Ieda68013af7fbafbf53fbf7c8fd85ea295153e5e@changeid>
Mime-Version: 1.0
References: <20200407085610.231013-1-apusaka@google.com>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
Subject: [Bluez PATCH v4 2/4] unit/test-crypto: test for bt_crypto_verify_att_sign
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

Adding tests for verifying att signature
---

Changes in v4:
- Fix wrong variable assignment

Changes in v3:
- Add unit test

Changes in v2: None

 unit/test-crypto.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index e20b2fa66..46c7c0e5c 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -272,6 +272,58 @@ static void test_gatt_hash(gconstpointer data)
 	tester_test_passed();
 }
 
+struct verify_sign_test_data {
+	const uint8_t *msg;
+	uint16_t msg_len;
+	const uint8_t *key;
+	bool match;
+};
+
+static const uint8_t msg_to_verify_pass[] = {
+	0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
+	0x93, 0x3C, 0x90, 0x0F, 0xf2
+};
+
+static const struct verify_sign_test_data verify_sign_pass_data = {
+	.msg = msg_to_verify_pass,
+	.msg_len = sizeof(msg_to_verify_pass),
+	.key = key_5,
+	.match = true,
+};
+
+static const uint8_t msg_to_verify_bad_sign[] = {
+	0xd2, 0x12, 0x00, 0x13, 0x37, 0x01, 0x00, 0x00, 0x00, 0xF1, 0x87, 0x1E,
+	0x93, 0x3C, 0x90, 0x0F, 0xf1
+};
+
+static const struct verify_sign_test_data verify_sign_bad_sign_data = {
+	.msg = msg_to_verify_bad_sign,
+	.msg_len = sizeof(msg_to_verify_bad_sign),
+	.key = key_5,
+	.match = false,
+};
+
+static const uint8_t msg_to_verify_too_short[] = {
+	0xd2, 0x12, 0x00, 0x13, 0x37
+};
+
+static const struct verify_sign_test_data verify_sign_too_short_data = {
+	.msg = msg_to_verify_too_short,
+	.msg_len = sizeof(msg_to_verify_too_short),
+	.key = key_5,
+	.match = false,
+};
+
+static void test_verify_sign(gconstpointer data)
+{
+	const struct verify_sign_test_data *d = data;
+	bool result = bt_crypto_verify_att_sign(crypto, d->key, d->msg,
+						d->msg_len);
+	g_assert(result == d->match);
+
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	int exit_status;
@@ -292,6 +344,13 @@ int main(int argc, char *argv[])
 
 	tester_add("/crypto/gatt_hash", NULL, NULL, test_gatt_hash, NULL);
 
+	tester_add("/crypto/verify_sign_pass", &verify_sign_pass_data,
+						NULL, test_verify_sign, NULL);
+	tester_add("/crypto/verify_sign_bad_sign", &verify_sign_bad_sign_data,
+						NULL, test_verify_sign, NULL);
+	tester_add("/crypto/verify_sign_too_short", &verify_sign_too_short_data,
+						NULL, test_verify_sign, NULL);
+
 	exit_status = tester_run();
 
 	bt_crypto_unref(crypto);
-- 
2.26.0.292.g33ef6b2f38-goog

