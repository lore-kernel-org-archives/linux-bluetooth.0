Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EA1C04A68
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 21:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbiG1VGl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 17:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiG1VGk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 17:06:40 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992071D0F3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 14:06:39 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g12so2963985pfb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 14:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nup+sDUrag1UxeVmw5iPb/qIk0UhAAZ3ZOvdUSQG8Vg=;
        b=DiIzJnSp7SeXKCJtA6xSsonVgVRuQfv73wIEaamNaAH0V6SfwBdZznI0gId7eZPLIo
         t5/+pBsYlBQe9Ni3X8uO9iB2iw0Ka4IZfLWL1fJoCjX49oCWsgrQVk9X0KoGS2aS1ABd
         2+pXh8GABeXBo1PRYDeMTPxO89w3C4S/4jWrxes8bbWxJIg8YnNg5pCzu7ndah9lYI25
         vDbSpDh/Muuj9AGglUoPa3hsNf+3ii1gPT9cQPPyRv/EWhMSft8vc1tVt/Ap3BKAngql
         EuSvZLCo3xM/bfuYPZRPw5Lh8xxmsWIx8Ek5yqdTlIoW5MSWF9a1C6dTljl/ILMNO6Pl
         o4gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nup+sDUrag1UxeVmw5iPb/qIk0UhAAZ3ZOvdUSQG8Vg=;
        b=i7P2sz1s2dbJZrx9d415UPJA3ZUQWBCNETz1oebHKPtdFVAJE5qNUZpKrClgzxBac5
         nlOreG0lfgyyEV0vhy9oMsIKZw9Mm0Jf128+aCphFRsjPUxNLP0+HQMouWwnIMSTYKuM
         LYU/YasCOB7RN0ftT+Ht5xAlwBoGTAoUbItmpHG77/pI0GY94l/oP4TEZk7DG1S8yiUX
         mKhbDjE1b3H70A+uOhjM2Cm7ipjGBEY4qiSxtUu8KqoFH1oZuaVprvZkf8W39MwwuFzy
         ab/2EXFqsYoVkedq+/smHAqXd7KMNjP60tSyCwYJzTMgiXDYHHemxKiCeAKPlR2Y4zxr
         rqAA==
X-Gm-Message-State: AJIora8PN+azn4LGXPIipn/L4/ZrfYV+jvKhSxZhrMM1IzWjSkt0hXdJ
        n9KOIu3Zj9+Mg5opMlwEh1r1xbeNwGEkyg==
X-Google-Smtp-Source: AGRyM1sPGrTqpchgv7IWB4kJfiPWHcL7l637cy3BX7wj97mHrMaEgAgMnfnFbfp+WIIV4yT8wbgkNA==
X-Received: by 2002:a63:e109:0:b0:419:c3bc:b89 with SMTP id z9-20020a63e109000000b00419c3bc0b89mr491193pgh.176.1659042398620;
        Thu, 28 Jul 2022 14:06:38 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902710f00b0016d9468bb20sm1782483pll.129.2022.07.28.14.06.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 14:06:38 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] iso-test: Add ISO 48_2_1 Defer Send
Date:   Thu, 28 Jul 2022 14:06:37 -0700
Message-Id: <20220728210637.1247789-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds ISO 48_2_1 Defer Send test which enables just output instead
of both.
---
 tools/iso-tester.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 8010c0a36..cae5fb4b7 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -567,6 +567,13 @@ static const struct iso_client_data connect_16_2_1_defer_send = {
 	.defer = true,
 };
 
+static const struct iso_client_data connect_48_2_1_defer_send = {
+	.qos = QOS_48_2_1,
+	.expect_err = 0,
+	.send = &send_16_2_1,
+	.defer = true,
+};
+
 static const struct iso_client_data listen_16_2_1_defer_recv = {
 	.qos = QOS_16_2_1,
 	.expect_err = 0,
@@ -1674,6 +1681,10 @@ int main(int argc, char *argv[])
 							setup_powered,
 							test_connect);
 
+	test_iso("ISO 48_2_1 Defer Send - Success", &connect_48_2_1_defer_send,
+							setup_powered,
+							test_connect);
+
 	test_iso("ISO Defer Receive - Success", &listen_16_2_1_defer_recv,
 						setup_powered, test_listen);
 
-- 
2.37.1

