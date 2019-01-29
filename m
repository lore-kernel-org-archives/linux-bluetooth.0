Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B14C169C4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A4F2147A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2CmiM/I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfA2N0l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:41 -0500
Received: from mail-ed1-f51.google.com ([209.85.208.51]:43302 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfA2N0l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:41 -0500
Received: by mail-ed1-f51.google.com with SMTP id f9so15922852eds.10
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=mX4rlndXGHoskbbnDBD9XOOEU72dH9VtPCmZr/s+T0E=;
        b=J2CmiM/ImM15dejl0XI+UI2WKob33dgNAlenpeb+ee+VNTOH73SGDIRHtv0P6DjAm9
         L47PnDHBHtezGdCZX9gi/vGRQ/4eNRctdVY+OSaysGDwgtlOvO0b5I+0ItFzuBZM0hYB
         EQQBuvOAcHekDk25g9wEkZ1+5fy2Q2/RRzkSMX0f0J43rUQKwpbidwLi5bUJ54+OibO1
         AXIPrKqyKAVEq15JRGdNEH7RmeHBI0+0AMgnkUeRn9TJZwRZOSOtSHXFEiDX4ZQN1nY6
         a2UoIKRjczd+JaK6PWARNbMmiF5BboFcikQJdbEbgmBNKCam1Cxnpp9/8hSaDY3nPHJm
         tiVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=mX4rlndXGHoskbbnDBD9XOOEU72dH9VtPCmZr/s+T0E=;
        b=LXqdWONtYYHoNA4z+UBWTDQVdOhItOOrT6q5SNW5h8XGbB6hxcUKcI9tKzsH2oxHYD
         HtgerzJeBJ7Z9ZsvuOxwumThRwlK4QDkkVlgheNNdyTW5Adxgn+Q9cVs13FVkWJbaXR2
         uWfJxvtQmw1Mp3rvRQ4GR2tHk4d2BYawoaC0Oy890qOwQ2uhgpmpSaq1Q55WBovVKcGV
         +nehnd+CzUdhfKT2fDfMROPqNe4COwJdmlZHsUYdxwIlo8wtzuKsEpXlHgv+vO321QX7
         iT/iXkmzHSXAVS3TpLHIYrRChMg0gLbPjYltIoozkNa3awMz+wBAespWXR9fGP7TriHz
         Zz4A==
X-Gm-Message-State: AJcUukf+PcQsAAF7b7FG4pqgVF3xn7hoz4Dga6t5eS+bsxUDLaAeeW6U
        Si1spUEYgpf3Ts1UC9G2WfFpzJKP
X-Google-Smtp-Source: ALg8bN68AQErNz0lsJs++B/W0utyWcogftWojmMhiSvmBGWztBBdcGlKtBZ/oz3emKJenfcQz0A+6A==
X-Received: by 2002:a50:f5af:: with SMTP id u44mr26266657edm.172.1548768398864;
        Tue, 29 Jan 2019 05:26:38 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:38 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 02/15] unit/test-crypto: Add test for bt_crypto_gatt_hash
Date:   Tue, 29 Jan 2019 15:26:21 +0200
Message-Id: <20190129132634.28786-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds test case base on the example given in the spec.
---
 unit/test-crypto.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index bc37abb51..5a938c09e 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -208,6 +208,54 @@ static void test_sign(gconstpointer data)
 	tester_test_passed();
 }
 
+static void test_gatt_hash(gconstpointer data)
+{
+	struct iovec iov;
+	const uint8_t m[] = {
+			0x01, 0x00, 0x00, 0x28, 0x00, 0x18, 0x02, 0x00,
+			0x03, 0x28, 0x0A, 0x03, 0x00, 0x00, 0x2A, 0x04,
+			0x00, 0x03, 0x28, 0x02, 0x05, 0x00, 0x01, 0x2A,
+			0x06, 0x00, 0x00, 0x28, 0x01, 0x18, 0x07, 0x00,
+			0x03, 0x28, 0x20, 0x08, 0x00, 0x05, 0x2A, 0x09,
+			0x00, 0x02, 0x29, 0x0A, 0x00, 0x03, 0x28, 0x02,
+			0x0B, 0x00, 0xFF, 0xFF, 0x0C, 0x00, 0x03, 0x28,
+			0x02, 0x0D, 0x00, 0xFF, 0xFF, 0x0E, 0x00, 0x00,
+			0x28, 0x08, 0x18, 0x0F, 0x00, 0x02, 0x28, 0x14,
+			0x00, 0x16, 0x00, 0x0F, 0x18, 0x10, 0x00, 0x03,
+			0x28, 0xA2, 0x11, 0x00, 0x18, 0x2A, 0x12, 0x00,
+			0x02, 0x29, 0x13, 0x00, 0x00, 0x29, 0x00, 0x00,
+			0x14, 0x00, 0x01, 0x28, 0x0F, 0x18, 0x15, 0x00,
+			0x03, 0x28, 0x02, 0x16, 0x00, 0x19, 0x2A };
+	const uint8_t exp[16] = {
+			0x22, 0x7C, 0xE3, 0x34, 0x22, 0xBA, 0xA5, 0xDD,
+			0x6F, 0xA0, 0x82, 0x2A, 0xC1, 0xAD, 0x94, 0x19 };
+	uint8_t res[16];
+
+	tester_debug("M:");
+	util_hexdump(' ', m, sizeof(m), print_debug, NULL);
+
+	iov.iov_base = (void *) m;
+	iov.iov_len = sizeof(m);
+
+	if (!bt_crypto_gatt_hash(crypto, &iov, 1, res)) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_debug("Expected:");
+	util_hexdump(' ', exp, 16, print_debug, NULL);
+
+	tester_debug("Result:");
+	util_hexdump(' ', res, 16, print_debug, NULL);
+
+	if (memcmp(res, exp, 16)) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_test_passed();
+}
+
 int main(int argc, char *argv[])
 {
 	int exit_status;
@@ -226,6 +274,8 @@ int main(int argc, char *argv[])
 	tester_add("/crypto/sign_att_4", &test_data_4, NULL, test_sign, NULL);
 	tester_add("/crypto/sign_att_5", &test_data_5, NULL, test_sign, NULL);
 
+	tester_add("/crypto/gatt_hash", NULL, NULL, test_gatt_hash, NULL);
+
 	exit_status = tester_run();
 
 	bt_crypto_unref(crypto);
-- 
2.17.2

