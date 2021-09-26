Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A55A7C433F5
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 17:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 885B76103B
	for <linux-bluetooth@archiver.kernel.org>; Sun, 26 Sep 2021 17:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhIZRE0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 26 Sep 2021 13:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhIZREZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 26 Sep 2021 13:04:25 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E1C061570
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 10:02:49 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id c20so14577418qtb.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 26 Sep 2021 10:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wpJCeFJJXG7/1pngPh3RfvVwB+Sa9Wm6xSLxWGAAyCI=;
        b=BQ9QhhMBzT2pCHcedJ8XIZo5mlEZTMEWG2/6ZEQoRC1NgFwPMQmPu5Dp/HOcAlyIJ6
         eMCmtH8svi2wR51Ht+goLl9B89SKzlXWIFIa31zxTBsCZUFLcJWbizgERoeA0dRV3N8G
         5KpyVFkOtc/sn7wC5pSOd/RnZSxOos/m8K4cThwBNzvex/gBXMiy8opUA2QuJizXjOUz
         PGp8G1N6Ben9AXlaUOhECDqqa6ouiz/npNYwb83OMwNKr/1xRaqjrmNZBrMRFArRoZPU
         uU6ahlUwgTMEA1AvAgD7oatxttHp+7Z9HbrsEj5itmlhxcItC5PIbIZy5U5dOe1pDcQP
         3Qhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wpJCeFJJXG7/1pngPh3RfvVwB+Sa9Wm6xSLxWGAAyCI=;
        b=gBozwzKR+J+Scx/erCMrh+CvNVOx1f3wlYuQfo79qK3uDe3iPQVQFN0nQ1ZMALy/7x
         sN2Y0TcJnGjw8Gqv9F77Z+kDGcRH2nveXBda7d/Cyawb9WJe2+FIWtcQ5eQ4aDUANS/k
         +NYZ52MzeMeu7iKzdoxgmyKFnCybAb0Vr07ECDVY+wcEYcVQqcm2tBRAitxkN4qK6LBu
         G7E57aUF1QWuAFuqo11+gm6pyXJuzgXTDeKHx3hdPQD1X0a3bfG8A7PjzfrecuUCMdGY
         Ct5+xPaOC9MX9sY+5K6l2mw7T8MWHZHD+nr542DFydh11Z+TUhN7vvbk2eARabHC7BYh
         A34w==
X-Gm-Message-State: AOAM530pU0j6jjtnCz7aztOSZYzv76h8vQDTNWJYGYt6yYG2/880EmQd
        z/5478b2laFgPwOz6yem/5tqLXFS4lPlOA==
X-Google-Smtp-Source: ABdhPJwxGrEdXloMptNIm6iJFhEroOzFRXy43qIl3gCYya0fZoTcUP5mGxZo7TxcW36mLmRDV613YA==
X-Received: by 2002:ac8:7765:: with SMTP id h5mr14479058qtu.328.1632675768261;
        Sun, 26 Sep 2021 10:02:48 -0700 (PDT)
Received: from localhost.localdomain (38-13-8-207.starry-inc.net. [38.13.8.207])
        by smtp.gmail.com with ESMTPSA id g22sm10803833qkk.87.2021.09.26.10.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Sep 2021 10:02:48 -0700 (PDT)
From:   Dagan Martinez <martinez.dagan@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Dagan Martinez <martinez.dagan@gmail.com>
Subject: [PATCH BlueZ 1/1] gatt: remove superfluous extended properties
Date:   Sun, 26 Sep 2021 13:00:39 -0400
Message-Id: <20210926170039.49865-2-martinez.dagan@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210926170039.49865-1-martinez.dagan@gmail.com>
References: <20210926170039.49865-1-martinez.dagan@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

BlueZ contained superfluous properties that not only did nothing of
value, but needlessly created CEP descriptors for any characteristic
with a secure/encrypted/authenticated flag applied to it.

This actually deviated from the spec(Bluetooth core 5.3, 3.3.3.1) by
setting the reserved bits in the CEPD.
---
 src/gatt-database.c    | 6 ------
 src/shared/att-types.h | 8 --------
 2 files changed, 14 deletions(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index 99c95f2d6..1f7ce5f02 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1656,27 +1656,21 @@ static bool parse_chrc_flags(DBusMessageIter *array, uint8_t *props,
 			*ext_props |= BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX;
 		} else if (!strcmp("encrypt-read", flag)) {
 			*props |= BT_GATT_CHRC_PROP_READ;
-			*ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_READ;
 			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_ENCRYPT;
 		} else if (!strcmp("encrypt-write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
-			*ext_props |= BT_GATT_CHRC_EXT_PROP_ENC_WRITE;
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_ENCRYPT;
 		} else if (!strcmp("encrypt-authenticated-read", flag)) {
 			*props |= BT_GATT_CHRC_PROP_READ;
-			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_READ;
 			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_AUTHEN;
 		} else if (!strcmp("encrypt-authenticated-write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
-			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_WRITE;
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_AUTHEN;
 		} else if (!strcmp("secure-read", flag)) {
 			*props |= BT_GATT_CHRC_PROP_READ;
-			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_READ;
 			*perm |= BT_ATT_PERM_READ | BT_ATT_PERM_READ_SECURE;
 		} else if (!strcmp("secure-write", flag)) {
 			*props |= BT_GATT_CHRC_PROP_WRITE;
-			*ext_props |= BT_GATT_CHRC_EXT_PROP_AUTH_WRITE;
 			*perm |= BT_ATT_PERM_WRITE | BT_ATT_PERM_WRITE_SECURE;
 		} else if (!strcmp("authorize", flag)) {
 			*req_prep_authorization = true;
diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 3adc05d9e..a08b24155 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -151,14 +151,6 @@ struct bt_att_pdu_error_rsp {
 /* GATT Characteristic Extended Properties Bitfield values */
 #define BT_GATT_CHRC_EXT_PROP_RELIABLE_WRITE		0x01
 #define BT_GATT_CHRC_EXT_PROP_WRITABLE_AUX		0x02
-#define BT_GATT_CHRC_EXT_PROP_ENC_READ			0x04
-#define BT_GATT_CHRC_EXT_PROP_ENC_WRITE			0x08
-#define BT_GATT_CHRC_EXT_PROP_ENC	(BT_GATT_CHRC_EXT_PROP_ENC_READ | \
-					BT_GATT_CHRC_EXT_PROP_ENC_WRITE)
-#define BT_GATT_CHRC_EXT_PROP_AUTH_READ			0x10
-#define BT_GATT_CHRC_EXT_PROP_AUTH_WRITE		0x20
-#define BT_GATT_CHRC_EXT_PROP_AUTH	(BT_GATT_CHRC_EXT_PROP_AUTH_READ | \
-					BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
 
 /* GATT Characteristic Client Features Bitfield values */
 #define BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING		0x01
-- 
2.31.1

