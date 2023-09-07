Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5D0EE14D4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 04:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236799AbjIGElD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 00:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjIGElD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 00:41:03 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E3B19B5
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 21:40:59 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id 006d021491bc7-57325fcd970so319587eaf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Sep 2023 21:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694061659; x=1694666459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=35GLpkIt6mujWl2+I1O0caFVu8TQ+zMPTz0lRmKFElM=;
        b=l1TLFqK5GZajrbOHJ2aXXs4Xy18hnKABDqZrS4CuyoRkYY/sc/1NWAn+d1gRwGniy7
         Bz8GWJR4l00mSeH6moXkkckVfReyLLumMj49LRY3sV6Q4ospEBalKOKDno7rJwF+d54y
         9tp/WtXTcGSNjxAJpgTjvV05uxnqChNAZ/Ehk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694061659; x=1694666459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=35GLpkIt6mujWl2+I1O0caFVu8TQ+zMPTz0lRmKFElM=;
        b=fiWhs6VHNYImzBlMGe/Z0E6kl/uctj55BK3oxtkfoqxC9apvYIkNvc/00V5ESdyQtd
         Te7SnD5eu3W0N47KsiS9vL3iwIri3E+s1iu3DLPkMWSoHTp/Ytdwqy9QDYvlwYAOFpCs
         kwoywAxVcT/OtptUN2kt9xGA6A4GyUBJ+ZG1UQp16ie7w3vHCagDwhEV9vA27Z4ic/So
         31+REKdNPBDzb9WqMHkApHrRqb7iJekXGrCKzuD7CDGTILacuYpKSrcFIgTqae7bKRKZ
         67z2vwWms5bUizi3lVowqOgIhmv31eRWwdlEr19QYudkNGlwnGlVCLsjSiZPKyzeKgy8
         4LnQ==
X-Gm-Message-State: AOJu0YzAKKKMLtCQ2sIcDHMsBD3pmlbV3gKfX5xTlB4hTQ7ATbDouWZh
        M5mt5woeU5oF5we+8/6vknnWq+LoQR3I55SwTjs=
X-Google-Smtp-Source: AGHT+IFzlyg5QKlborvgxPU5wcPBCq1yrMAJZ+wHVqZ38R8CH4HjCjK/s1z+xHunn8lCvKhoiGGU2A==
X-Received: by 2002:a05:6358:787:b0:132:d333:4a5c with SMTP id n7-20020a056358078700b00132d3334a5cmr5937699rwj.10.1694061658905;
        Wed, 06 Sep 2023 21:40:58 -0700 (PDT)
Received: from localhost (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with UTF8SMTPSA id j17-20020a62b611000000b0066a2e8431a0sm11518344pff.183.2023.09.06.21.40.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 21:40:58 -0700 (PDT)
From:   Ying Hsu <yinghsu@chromium.org>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Ying Hsu <yinghsu@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Avoid redundant authentication
Date:   Thu,  7 Sep 2023 04:39:34 +0000
Message-ID: <20230907043933.v2.1.I0cd65c6ecb991a13b224614c32c1946f9eecea3d@changeid>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

While executing the Android 13 CTS Verifier Secure Server test on a
ChromeOS device, it was observed that the Bluetooth host initiates
authentication for an RFCOMM connection after SSP completes.
When this happens, some Intel Bluetooth controllers, like AC9560, would
disconnect with "Connection Rejected due to Security Reasons (0x0e)".

Historically, BlueZ did not mandate this authentication while an
authenticated combination key was already in use for the connection.
This behavior was changed since commit 7b5a9241b780
("Bluetooth: Introduce requirements for security level 4").
So, this patch addresses the aforementioned disconnection issue by
restoring the previous behavior.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
---
- Tested CTS Verifier 13 Secure Server test on a chromebook with AC9560.
- Manual tests on classic mouse/keyboard/headset, BLE keyboard/mouse.

Changes in v2:
- Transitioned from multiple 'if' blocks to a 'switch-case' structure
  for clarity and maintainability.

 net/bluetooth/hci_conn.c | 63 ++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 28 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9d5057cef30a..7a6f20338db8 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2413,34 +2413,41 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
 	if (!test_bit(HCI_CONN_AUTH, &conn->flags))
 		goto auth;
 
-	/* An authenticated FIPS approved combination key has sufficient
-	 * security for security level 4. */
-	if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256 &&
-	    sec_level == BT_SECURITY_FIPS)
-		goto encrypt;
-
-	/* An authenticated combination key has sufficient security for
-	   security level 3. */
-	if ((conn->key_type == HCI_LK_AUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_AUTH_COMBINATION_P256) &&
-	    sec_level == BT_SECURITY_HIGH)
-		goto encrypt;
-
-	/* An unauthenticated combination key has sufficient security for
-	   security level 1 and 2. */
-	if ((conn->key_type == HCI_LK_UNAUTH_COMBINATION_P192 ||
-	     conn->key_type == HCI_LK_UNAUTH_COMBINATION_P256) &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
-		goto encrypt;
-
-	/* A combination key has always sufficient security for the security
-	   levels 1 or 2. High security level requires the combination key
-	   is generated using maximum PIN code length (16).
-	   For pre 2.1 units. */
-	if (conn->key_type == HCI_LK_COMBINATION &&
-	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW ||
-	     conn->pin_length == 16))
-		goto encrypt;
+	switch (conn->key_type) {
+	case HCI_LK_AUTH_COMBINATION_P256:
+		/* An authenticated FIPS approved combination key has
+		 * sufficient security for security level 4 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_FIPS)
+			goto encrypt;
+		break;
+	case HCI_LK_AUTH_COMBINATION_P192:
+		/* An authenticated combination key has sufficient security for
+		 * security level 3 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_HIGH)
+			goto encrypt;
+		break;
+	case HCI_LK_UNAUTH_COMBINATION_P192:
+	case HCI_LK_UNAUTH_COMBINATION_P256:
+		/* An unauthenticated combination key has sufficient security
+		 * for security level 2 or lower.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM)
+			goto encrypt;
+		break;
+	case HCI_LK_COMBINATION:
+		/* A combination key has always sufficient security for the
+		 * security levels 2 or lower. High security level requires the
+		 * combination key is generated using maximum PIN code length
+		 * (16). For pre 2.1 units.
+		 */
+		if (sec_level <= BT_SECURITY_MEDIUM || conn->pin_length == 16)
+			goto encrypt;
+		break;
+	default:
+		break;
+	}
 
 auth:
 	if (test_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags))
-- 
2.42.0.283.g2d96d420d3-goog

