Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 850A4C3DA7A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 22:43:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiLVWnl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 17:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiLVWnh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 17:43:37 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED76D5F98
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 78so2224587pgb.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Dec 2022 14:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dM8sGE2SjkciM3MF8nF0v27r3EhD5DXOeLpZ9kBJUOI=;
        b=mu2Rxt0mPoOL01DX59tW3gutonzvUw+Lb7wzJvRBzI1mPGncviHmZrkH++s1H2AHUc
         usJQnlLf+6TJENOqUlSMaO3Lh4Rp8GPTPreH9ytkvxJqQNh7zuIKHrar+8sQvXSGlz+t
         WUX/HjXmJSiVnIGS2HeM+ukC30j4x/9CAYKToZx7wzafgUP/y9NGr6BQ4atWJqag2Ve8
         mwbs8NVkURWbR63ZCgnTi3zBYpWbwHFTiXNPIJG4dHjInxM2YYrC2O4dRtKe6P/c4yhn
         d8fLRv0ww4uhM4XHSogvxryeE9iQqXIXkmQ1ATMKyt4u0KldxexHiKO3nT87yxfEIv5s
         7Ozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dM8sGE2SjkciM3MF8nF0v27r3EhD5DXOeLpZ9kBJUOI=;
        b=lh/efZ9Jy0QI71iY+jHlCjMJT11Jlhmwn/kkH3XAS63XnlQ9TqoWTFmPLZG3OUv1oI
         35aXnjHW3N6q8uoW6x4CA9De9g3DsG6uQzkWf5hVl9KLlpfVtkdSNSqwtrwtfKfVvUDB
         eNK6JiVDS05F6Nx69te9bw3vmCjiM9RMyNlCvPNRsmIJvBF1+7yxnQkyiz/6LilfMphp
         yMMkEwPVIcc/0cTBmbcQP5K1gnBXF25NABZMqZDpXahewoNJdQmlT0MATbZrFgk75VV7
         7NPJAx5JXFz+AAoj/pz3v4lwsE56D7+SOk9n3soPJcqq8vUZ/cQSjLj3foFTzTtCtNHJ
         0gdQ==
X-Gm-Message-State: AFqh2kpwlPZ3kUCGQzmGEbHhZMwFWmMAl3ZSA2LKL0Z5WLcml2jhD0Su
        VbeWOZ9PXMA21FyxvScMRGf1Fhq0TJdBKQ==
X-Google-Smtp-Source: AMrXdXtoFWKkz55s6OZiVM2N1MBJHcwjUEzHecTpV4PDtu+cDz7WU7i1TD5bVRzxCiAj0fFOibj62g==
X-Received: by 2002:a62:1456:0:b0:566:900d:466c with SMTP id 83-20020a621456000000b00566900d466cmr7926310pfu.6.1671749015384;
        Thu, 22 Dec 2022 14:43:35 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id f6-20020aa79d86000000b0056bbeaa82b9sm1187546pfq.113.2022.12.22.14.43.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 14:43:34 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] test-crypto: Add /crypto/sef test
Date:   Thu, 22 Dec 2022 14:43:28 -0800
Message-Id: <20221222224329.685837-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221222224329.685837-1-luiz.dentz@gmail.com>
References: <20221222224329.685837-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds test /crypto/sef which validas the implementation of
bt_crypto_sef using the sample data from CSIS[1] spec:

 A.2. sef SIRK Encryption Function

> unit/test-crypto -s "/crypto/sef"
  SIRK:
    cd cc 72 dd 86 8c cd ce 22 fd a1 21 09 7d 7d 45  ..r....."..!.}}E
  K:
    d9 ce e5 3c 22 c6 1e 06 6f 69 48 d4 9b 1b 6e 67  ...<"...oiH...ng
  Expected:
    46 d3 5f f2 d5 62 25 7e a0 24 35 e1 35 38 0a 17  F._..b%~.$5.58..
  Result:
    46 d3 5f f2 d5 62 25 7e a0 24 35 e1 35 38 0a 17  F._..b%~.$5.58..

[1]https://www.bluetooth.com/specifications/csis-1-0-1/
---
 unit/test-crypto.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/unit/test-crypto.c b/unit/test-crypto.c
index b5404d542af3..8fd7bec8ea83 100644
--- a/unit/test-crypto.c
+++ b/unit/test-crypto.c
@@ -311,6 +311,44 @@ static void test_verify_sign(gconstpointer data)
 	tester_test_passed();
 }
 
+static void test_sef(const void *data)
+{
+	const uint8_t sirk[16] = {
+			0xcd, 0xcc, 0x72, 0xdd, 0x86, 0x8c, 0xcd, 0xce,
+			0x22, 0xfd, 0xa1, 0x21, 0x09, 0x7d, 0x7d, 0x45 };
+	const uint8_t k[16] = {
+			0xd9, 0xce, 0xe5, 0x3c, 0x22, 0xc6, 0x1e, 0x06,
+			0x6f, 0x69, 0x48, 0xd4, 0x9b, 0x1b, 0x6e, 0x67 };
+	const uint8_t exp[16] = {
+			0x46, 0xd3, 0x5f, 0xf2, 0xd5, 0x62, 0x25, 0x7e,
+			0xa0, 0x24, 0x35, 0xe1, 0x35, 0x38, 0x0a, 0x17 };
+	uint8_t res[16];
+
+	tester_debug("SIRK:");
+	util_hexdump(' ', sirk, 16, print_debug, NULL);
+
+	tester_debug("K:");
+	util_hexdump(' ', k, 16, print_debug, NULL);
+
+	if (!bt_crypto_sef(crypto, k, sirk, res)) {
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
 static void test_sih(const void *data)
 {
 	const uint8_t k[16] = {
@@ -371,6 +409,7 @@ int main(int argc, char *argv[])
 						NULL, test_verify_sign, NULL);
 	tester_add("/crypto/verify_sign_too_short", &verify_sign_too_short_data,
 						NULL, test_verify_sign, NULL);
+	tester_add("/crypto/sef", NULL, NULL, test_sef, NULL);
 	tester_add("/crypto/sih", NULL, NULL, test_sih, NULL);
 
 	exit_status = tester_run();
-- 
2.37.3

