Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD4C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 22:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbiLVWni (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 17:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbiLVWne (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 17:43:34 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065AE5F98
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:34 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id v3so2236493pgh.4
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iw+r5Narpa4DdlfzmvlvH1UwTk5c6dLIcrTnhMGzjKg=;
        b=laoumNqjvqBA1hlzPdTEjKaGoo3cZaxVcc/SvI6/TBMyxAluORt8L9/GG+bdIaBjss
         4voej20Te+XXrMFYnFXtN1cM0j28jL1tcXb8TH4nTcN032EAsDunsInVTZs9xbe9nSmo
         uzO3RTaDf7QD7gsHqviCviTPtr+fuQQGHiiHXA2WF5Ssgl54ckA/ANj41UoZiYxevajM
         768bb7Oe9uBtJanIBy/kR6ATE23UpRGNonlJuEWMFMGYXFRATKN1aDcAm5Xbk7EYTHGd
         XbZqpeY7FfthjmNNMk3YWdlHpCxeZTUIBStogDW4bjuhzb3aSI/ep6+us/tqyLxzqG6m
         ISmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iw+r5Narpa4DdlfzmvlvH1UwTk5c6dLIcrTnhMGzjKg=;
        b=crrFNHviRm+37GfuSjFygaRJ6tJXQI9YrEXgmPZObs04p42d+Lzhi10PwCg5FexN5w
         eGwpsZi27EPMIn0oCMu5s7DOWuhb2j2BT+1ccyURSEeoBRpQHDxbrQbQvl1glRyvAQ5n
         zYTUOc2DJxANO/j2f88dz3vVX/2EONrVBQZ2Xu8wpaFi+rNyxD+Ahjz2sFP+2tVKJ8wX
         TL/uOAE8zflmzzUiX0r7syHO2gOrrhCblXY/5ZsZ1NiSvZ5FgHSunG9VUtybxuCjO+h1
         2PCuVF7NJkNi0ZNAR2VPvZ8p1OZtGySdX7fCXZpnFqMZTldamUtkhhax0PpCrnk8tJzs
         /Iiw==
X-Gm-Message-State: AFqh2kr3hgxJTt1sY8pVWxXoTObbZzx6Tfj4JTq00esEigFYxHLtdBFA
        phY4uQ2x42EOJW+K6ria4C06KNONoofSDA==
X-Google-Smtp-Source: AMrXdXv+GkPPnHSQg878FRsf+t+Q6o8w0mjvR0djy7Hb2Qy6h70dVpLZLlzffLBjGC+A4A9aoq0eMA==
X-Received: by 2002:a62:1ec7:0:b0:56d:1e00:f078 with SMTP id e190-20020a621ec7000000b0056d1e00f078mr7419470pfe.32.1671749012881;
        Thu, 22 Dec 2022 14:43:32 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79d86000000b0056bbeaa82b9sm1187546pfq.113.2022.12.22.14.43.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:43:32 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/5] test-crypto: Add /crypto/sih test
Date:   Thu, 22 Dec 2022 14:43:26 -0800
Message-Id: <20221222224329.685837-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221222224329.685837-1-luiz.dentz@gmail.com>
References: <20221222224329.685837-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds test /crypto/sih which validas the implementation of
bt_crypto_sih using the sample data from CSIS[1] spec:

  A.1. sih Resolvable Set Identifier hash function

> unit/test-crypto -s "/crypto/sih"
  K:
    cd cc 72 dd 86 8c cd ce 22 fd a1 21 09 7d 7d 45  ..r....."..!.}}E
  R:
    63 f5 69                                         c.i
  Expected:
    da 48 19                                         .H.
  Result:
    da 48 19                                         .H.

[1] https://www.bluetooth.com/specifications/csis-1-0-1/
---
 unit/test-crypto.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index 3a88b4a52b47..b5404d542af3 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -311,6 +311,40 @@ static void test_verify_sign(gconstpointer data)
 	tester_test_passed();
 }
 
+static void test_sih(const void *data)
+{
+	const uint8_t k[16] = {
+			0xcd, 0xcc, 0x72, 0xdd, 0x86, 0x8c, 0xcd, 0xce,
+			0x22, 0xfd, 0xa1, 0x21, 0x09, 0x7d, 0x7d, 0x45 };
+	const uint8_t r[3] = { 0x63, 0xf5, 0x69 };
+	const uint8_t exp[3] = { 0xda, 0x48, 0x19 };
+	uint8_t hash[3];
+
+	tester_debug("K:");
+	util_hexdump(' ', k, 16, print_debug, NULL);
+
+	tester_debug("R:");
+	util_hexdump(' ', r, 3, print_debug, NULL);
+
+	if (!bt_crypto_sih(crypto, k, r, hash)) {
+		tester_test_failed();
+		return;
+	}
+
+	tester_debug("Expected:");
+	util_hexdump(' ', exp, 3, print_debug, NULL);
+
+	tester_debug("Result:");
+	util_hexdump(' ', hash, 3, print_debug, NULL);
+
+	if (memcmp(hash, exp, 3)) {
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
@@ -337,6 +371,7 @@ int main(int argc, char *argv[])
 						NULL, test_verify_sign, NULL);
 	tester_add("/crypto/verify_sign_too_short", &verify_sign_too_short_data,
 						NULL, test_verify_sign, NULL);
+	tester_add("/crypto/sih", NULL, NULL, test_sih, NULL);
 
 	exit_status = tester_run();
 
-- 
2.37.3

