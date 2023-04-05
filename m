Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE340C77B71
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Apr 2023 23:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjDEXLU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Apr 2023 19:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjDEXLT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Apr 2023 19:11:19 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C6A6E95
        for <linux-bluetooth@vger.kernel.org>; Wed,  5 Apr 2023 16:11:18 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso38850733pjb.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Apr 2023 16:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ft6avUwxhvv7WofQyTMsrSxsU+FGAMzJcVueT+bAcA=;
        b=INVwvdWjMQuR1t5qo6GIyNjOrplYzMeaCbQoiTAPNeGsqiVtsmZm3vV9xpLfBmKVc8
         +4icseBYalUejNW/6ZXbPo3ZvFX/fJQsg0+QXIEwUtZO8rqgctKrVpzO6Gl8aI+Nq1uQ
         /pb6/TO8Sf+XXgJ2D0XUjgUtGwOPGGKJaLTjUPBCCtLkWCcgfQkRaq5Z+MFQ+8l6URiQ
         jV8cUgSMEnRSh3FUvys8lDWaOFycVhaacKp1maNlc19M1H2Hrla4F6zMM1wXkUXoJR/+
         oFfzonPx5Tu28OGsEV4oxgI8QE6BxKBQXKF6+IfizKGhIsCHA6hZLKQbXHb0fcjQ3hs9
         fC5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736277;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ft6avUwxhvv7WofQyTMsrSxsU+FGAMzJcVueT+bAcA=;
        b=cdcJRvfMBpMZGdF9DW7ROqZ+YYwMkEdMn1UgIE8Xm1NW/0hZB6btRS2E3lHzo1cqX4
         xdlM+AZFgXyTHbkgNCdBwshtqMOdbe+n6SGmvIsAOlzypdnckQucmBYzbuJuDMMq5gxR
         A2zRs92zksKpM++AxUawY9Vc5yRao3XRWGLdt57Of3UZ1sk/vsPcJNdx1hDBBV+WDxyP
         YhBRuK7CbmdLqVEaUYeegJ6InQdY3N/8Wq+/M7gIHOCaeDIGxK3+oi5lVOQJmlTFRYzA
         iT4o4nyBv4nEB3KEI4oPty2zs/qo8r/bXIuJPIpCK6V0PgBnxc+kU+6kPfDwM85lJK6c
         ljrQ==
X-Gm-Message-State: AAQBX9e8NNwQ/cD5GpE+hEkN8Pr5RMI9SX4OSVUe2G5jE5KvGaWuxEOr
        +ZO98J1R/jg1xHd/mU24PO7aqMsCRLE=
X-Google-Smtp-Source: AKy350ZySVxAf4bF43IiGOO1IPm/OkuwnQOUs2a5U0eFsrFnBChLOdPJFRgZeSyrhyIIvjAmcVxFag==
X-Received: by 2002:a05:6a20:4da6:b0:d9:f69c:5349 with SMTP id gj38-20020a056a204da600b000d9f69c5349mr831788pzb.48.1680736277228;
        Wed, 05 Apr 2023 16:11:17 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7808c000000b006254794d5b2sm11537752pff.94.2023.04.05.16.11.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 16:11:16 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/5] advertising: Add support for rsi as Includes
Date:   Wed,  5 Apr 2023 16:11:10 -0700
Message-Id: <20230405231111.2636523-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405231111.2636523-1-luiz.dentz@gmail.com>
References: <20230405231111.2636523-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for "rsi" when a SIRK has been set on main.conf, the
clients can then enable it via Includes property which will make the
daemon to automatically generate an RSI (hash+random) and include it as
part of the advertising data:

< HCI Command: LE Set Extended Advertising Data (0x08|0x0037) plen 15
        Handle: 0x01
        Operation: Complete extended advertising data (0x03)
        Fragment preference: Minimize fragmentation (0x01)
        Data length: 0x0b
        Resolvable Set Identifier: E2-4E-AA-1B-2B-61
          Hash: 0x1b2b61
          Random: 0xe24eaa
        Flags: 0x06
          LE General Discoverable Mode
          BR/EDR Not Supported
---
 src/advertising.c | 47 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/src/advertising.c b/src/advertising.c
index f9748b1328bc..0dceb14c3be4 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -29,11 +29,13 @@
 #include "error.h"
 #include "log.h"
 #include "eir.h"
+#include "btd.h"
 #include "src/shared/ad.h"
 #include "src/shared/mgmt.h"
 #include "src/shared/queue.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
+#include "src/shared/crypto.h"
 #include "advertising.h"
 
 #define LE_ADVERTISING_MGR_IFACE "org.bluez.LEAdvertisingManager1"
@@ -459,13 +461,50 @@ fail:
 	return false;
 }
 
+static bool set_rsi(struct btd_adv_client *client)
+{
+	struct bt_crypto *crypto;
+	uint8_t zero[16] = {};
+	struct bt_ad_data rsi = { .type = BT_AD_CSIP_RSI };
+	uint8_t data[6];
+	bool ret;
+
+	/* Check if a valid SIRK has been set */
+	if (!memcmp(btd_opts.csis.sirk, zero, sizeof(zero)))
+		return false;
+
+	/* Check if RSI needs to be set or data already contains RSI data */
+	if (!client || bt_ad_has_data(client->data, &rsi))
+		return true;
+
+	crypto = bt_crypto_new();
+	if (!crypto)
+		return false;
+
+	ret = bt_crypto_random_bytes(crypto, data + 3, sizeof(data) - 3);
+	if (!ret)
+		goto done;
+
+	ret = bt_crypto_sih(crypto, btd_opts.csis.sirk, data + 3, data);
+	if (!ret)
+		goto done;
+
+	ret = bt_ad_add_data(client->data, BT_AD_CSIP_RSI, data, sizeof(data));
+
+done:
+	bt_crypto_unref(crypto);
+	return ret;
+}
+
 static struct adv_include {
 	uint8_t flag;
 	const char *name;
+	bool (*set)(struct btd_adv_client *client);
 } includes[] = {
 	{ MGMT_ADV_FLAG_TX_POWER, "tx-power" },
 	{ MGMT_ADV_FLAG_APPEARANCE, "appearance" },
 	{ MGMT_ADV_FLAG_LOCAL_NAME, "local-name" },
+	{ 0 , "rsi", set_rsi },
 	{ },
 };
 
@@ -497,6 +536,11 @@ static bool parse_includes(DBusMessageIter *iter,
 			if (strcmp(str, inc->name))
 				continue;
 
+			if (inc->set && inc->set(client)) {
+				DBG("Including Feature: %s", str);
+				continue;
+			}
+
 			if (!(client->manager->supported_flags & inc->flag))
 				continue;
 
@@ -1644,7 +1688,8 @@ static void append_include(struct btd_adv_manager *manager,
 	struct adv_include *inc;
 
 	for (inc = includes; inc && inc->name; inc++) {
-		if (manager->supported_flags & inc->flag)
+		if ((inc->set && inc->set(NULL)) ||
+				(manager->supported_flags & inc->flag))
 			dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING,
 								&inc->name);
 	}
-- 
2.39.2

