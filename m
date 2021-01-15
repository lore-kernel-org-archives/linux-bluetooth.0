Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A23C433DB
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F7F123A5E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 19:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbhAOTDM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 14:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbhAOTDM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 14:03:12 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06639C061757
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:02:32 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id m5so5731085pjv.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 11:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjvBFssmeont608t6ctJ3wMgKudazNhucp1oQMK34ds=;
        b=rJZEGhoDSb32xKDMfGOULCNV/964hg5jHJMMy7wJlKG735mLPhZC9A7ryaXXDRqtFD
         NkqmAgvzG7wblhOSXmreR7RIJ68BfS91hFHCwhgbWdHzPtCbeF4FvemmbCK3ta7p3TBp
         Fw0WvvBco6KKLUHLv8nhWAJW3fk/WtuvhR6CjF74c4CJGDD8+8f0lCTJjV9Ee8ebWBYO
         2myifnkRbLnw6upaspOze/byJpSdri0k6S6re5tf4INFa5Na4loxEV2qxK5edxCZKom2
         +ZbZ+ukZlkYG73gQhYiVamg77YYCthwBg3ZDqzxPEzRVHyxgPIHvPI8xd9+/wmrmYS8s
         wJCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jjvBFssmeont608t6ctJ3wMgKudazNhucp1oQMK34ds=;
        b=qA0rUHj9un/bKu+9xPaEQrC+wjtHjs18wltAkSj0uKoz3YQXSUPIPegZeKAOe+iQme
         SV00Cdg4DbMO28iVAo7nv9XGLyl/ZI8bNs2R9P5lHBxvLYl6j/XVXUVwzRh+1rmvhJco
         bhBtIlGVd4hQ6Ln8ggJbnVKiihjuUUCS0daZ3gqmGOvySPzPUM4ciP+THlNoA9jcpZZg
         U6XjshaCrfX5YZfJ8GZN0XyvAgIwBcGwqMb4JzYeW5Bb+R3vujaT6yRH7pkMYH5SXhll
         HUd1WY0OsfPLtADeKkiSFm1eFxwHk+WbTiQpVDZpJPiX1AekPIMgRI7VzzPcmuaIkgCu
         zIrA==
X-Gm-Message-State: AOAM53280Ll4fEELLHJaS8sz9axbD1MqIKKjBJoE20S8DQn9Ruvtq9kz
        OiVOONAh7D0qKxLlFmTobepfICtR6QY=
X-Google-Smtp-Source: ABdhPJwLmXjiIG8B1L3sNwPTgKKGc6nurO0zI8XE+uS+AOjiRcupx9SjyIRWcvip8kh3NWSLs/3zLw==
X-Received: by 2002:a17:902:8bc8:b029:dc:36d4:fba8 with SMTP id r8-20020a1709028bc8b02900dc36d4fba8mr13890072plo.82.1610737351297;
        Fri, 15 Jan 2021 11:02:31 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id l3sm5008491pjz.27.2021.01.15.11.02.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 11:02:30 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/crypto: Transform bt_cryto in a singleton
Date:   Fri, 15 Jan 2021 11:02:29 -0800
Message-Id: <20210115190229.186479-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes bt_crypto always return the same instance thus avoiding the
problem of having multiple PF sockets opened which may hit the file
descriptor limit.
---
 src/shared/crypto.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/src/shared/crypto.c b/src/shared/crypto.c
index 6d14903e4..d5efa416d 100644
--- a/src/shared/crypto.c
+++ b/src/shared/crypto.c
@@ -126,34 +126,40 @@ static int cmac_aes_setup(void)
 	return fd;
 }
 
+static struct bt_crypto *singleton;
+
 struct bt_crypto *bt_crypto_new(void)
 {
-	struct bt_crypto *crypto;
+	if (singleton)
+		return bt_crypto_ref(singleton);
 
-	crypto = new0(struct bt_crypto, 1);
+	singleton = new0(struct bt_crypto, 1);
 
-	crypto->ecb_aes = ecb_aes_setup();
-	if (crypto->ecb_aes < 0) {
-		free(crypto);
+	singleton->ecb_aes = ecb_aes_setup();
+	if (singleton->ecb_aes < 0) {
+		free(singleton);
+		singleton = NULL;
 		return NULL;
 	}
 
-	crypto->urandom = urandom_setup();
-	if (crypto->urandom < 0) {
-		close(crypto->ecb_aes);
-		free(crypto);
+	singleton->urandom = urandom_setup();
+	if (singleton->urandom < 0) {
+		close(singleton->ecb_aes);
+		free(singleton);
+		singleton = NULL;
 		return NULL;
 	}
 
-	crypto->cmac_aes = cmac_aes_setup();
-	if (crypto->cmac_aes < 0) {
-		close(crypto->urandom);
-		close(crypto->ecb_aes);
-		free(crypto);
+	singleton->cmac_aes = cmac_aes_setup();
+	if (singleton->cmac_aes < 0) {
+		close(singleton->urandom);
+		close(singleton->ecb_aes);
+		free(singleton);
+		singleton = NULL;
 		return NULL;
 	}
 
-	return bt_crypto_ref(crypto);
+	return bt_crypto_ref(singleton);
 }
 
 struct bt_crypto *bt_crypto_ref(struct bt_crypto *crypto)
@@ -179,6 +185,7 @@ void bt_crypto_unref(struct bt_crypto *crypto)
 	close(crypto->cmac_aes);
 
 	free(crypto);
+	singleton = NULL;
 }
 
 bool bt_crypto_random_bytes(struct bt_crypto *crypto,
-- 
2.26.2

