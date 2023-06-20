Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54A2EB64D8
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 20:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjFTUlD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 16:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjFTUlC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 16:41:02 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C29219B
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:41:01 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-666ecf9a081so3773466b3a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 13:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687293660; x=1689885660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vE59iMryp+2CqxkFipmcCXYV1qT1f0qpk3v5TZ5fwYM=;
        b=bESCpCmXetLozv/1hBidGdra5CwO2OreECZ/wDZOUrJklj2WLxsBe+cRUa7EuyRiWQ
         B+fBrW9t2PUOxz88m9ffVrbuTPtEqqGi9238Kf1U4JAkD6PGBqO66UbH0oiNlp5mB83R
         jTGQdtnq9ZJkmqZN1nn4V7P+omApiE2OxInuiLYA6CXwFYeJLryOn2imTuJMsYpoUWbd
         yVQwArCf5Bgy7t4vimoWM5uOAH9II4LyziYScJJu7/IMBvQgr4LZRoP6HFiCDyTwdXg+
         YM2QMr/dW0qcAjGWi8uIDypCksG9JJrWHPbRcxHFx5cTfBIkqe5Vl/CaqEbgDj9E/Nbn
         6uUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687293660; x=1689885660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vE59iMryp+2CqxkFipmcCXYV1qT1f0qpk3v5TZ5fwYM=;
        b=I5nVwUUGncO5j9heEeXv9/IIZrIzMCyTRRgHBwMsTVL7vTH6RKp/zylUlKH0J77nec
         RSA9wKzjwB1Xn41hWItRLXgXPIdQIQ2pqWJvUt17M/XpZyUPztdjCzJjcl1pIX1XrNCi
         7PuMLSmareFu27lmezRlnN14NUr1U1Et/zf0W4hZXXnGF9oBCdarnXsIEDgn59rhMyvA
         Vu3Z8hIPBpIx+T/FdANyFDKaMHohTy3p9ZfhMZMOvJVgV3UjDch7OpwUN4Cjf8yNRebt
         JPQULWwP4UNZM6yGKFH+OI4KhUZ9GNP4Yb+ec+XUl2y70fvAGU83UoafB1IpgVvcwd8k
         4xDQ==
X-Gm-Message-State: AC+VfDyHj7RwyrqebW4n/nK8HqeSX3idcz7x3cnfj/y0s5WppUEKrMoy
        Ma1yhfAjsH/icYzyS7jX2QW5tyEoXAq94w==
X-Google-Smtp-Source: ACHHUZ7aB+uDaKmEsP0BdtJQWogT9LpAxzEqXl5lQX/0VhQiVJel1Wrt6ELtGWmA49SJLn+dlIze4Q==
X-Received: by 2002:a05:6a20:734f:b0:10c:3cf3:ef7e with SMTP id v15-20020a056a20734f00b0010c3cf3ef7emr18054793pzc.42.1687293659608;
        Tue, 20 Jun 2023 13:40:59 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id x21-20020aa79195000000b0063a04905379sm1691596pfa.137.2023.06.20.13.40.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 13:40:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] adapter: Handle Device Found Event with Scan Response flag
Date:   Tue, 20 Jun 2023 13:40:53 -0700
Message-Id: <20230620204053.643608-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230620204053.643608-1-luiz.dentz@gmail.com>
References: <20230620204053.643608-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This handles recently introduced Scan Response flag since that
shouldn't affect connectable flag the device would be considered
connectable but it shall not create a new device by itself.
---
 lib/mgmt.h        |  1 +
 src/adapter.c     | 44 +++++++++++++++++++++++++-------------------
 src/adapter.h     |  8 +++-----
 src/adv_monitor.c | 17 +++--------------
 4 files changed, 32 insertions(+), 38 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index c3c9052320bb..062fa027127c 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -902,6 +902,7 @@ struct mgmt_ev_auth_failed {
 #define MGMT_DEV_FOUND_NOT_CONNECTABLE		BIT(2)
 #define MGMT_DEV_FOUND_INITIATED_CONN		BIT(3)
 #define MGMT_DEV_FOUND_NAME_REQUEST_FAILED	BIT(4)
+#define MGMT_DEV_FOUND_SCAN_RSP			BIT(5)
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
diff --git a/src/adapter.c b/src/adapter.c
index 74ed52468b81..2679d4302307 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7088,12 +7088,10 @@ static bool device_is_discoverable(struct btd_adapter *adapter,
 	return discoverable;
 }
 
-void btd_adapter_update_found_device(struct btd_adapter *adapter,
+void btd_adapter_device_found(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					bool confirm, bool legacy,
-					bool not_connectable,
-					bool name_resolve_failed,
+					uint32_t flags,
 					const uint8_t *data, uint8_t data_len,
 					bool monitoring)
 {
@@ -7102,9 +7100,20 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 	struct eir_data eir_data;
 	bool name_known, discoverable;
 	char addr[18];
+	bool confirm;
+	bool legacy;
+	bool not_connectable;
+	bool name_resolve_failed;
+	bool scan_rsp;
 	bool duplicate = false;
 	struct queue *matched_monitors = NULL;
 
+	confirm = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
+	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
+	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
+	name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
+	scan_rsp = (flags & MGMT_DEV_FOUND_SCAN_RSP);
+
 	if (!btd_adv_monitor_offload_enabled(adapter->adv_monitor_manager) ||
 				(MGMT_VERSION(mgmt_version, mgmt_revision) <
 							MGMT_VERSION(1, 22))) {
@@ -7137,6 +7146,14 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 
 	dev = btd_adapter_find_device(adapter, bdaddr, bdaddr_type);
 	if (!dev) {
+		/* In case of being just a scan response don't attempt to create
+		 * the device.
+		 */
+		if (scan_rsp) {
+			eir_data_free(&eir_data);
+			return;
+		}
+
 		if (!discoverable && !monitoring && !eir_data.rsi) {
 			eir_data_free(&eir_data);
 			return;
@@ -7317,10 +7334,6 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	const uint8_t *eir;
 	uint16_t eir_len;
 	uint32_t flags;
-	bool confirm_name;
-	bool legacy;
-	bool not_connectable;
-	bool name_resolve_failed;
 	char addr[18];
 
 	if (length < sizeof(*ev)) {
@@ -7342,22 +7355,15 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	else
 		eir = ev->eir;
 
-	flags = btohl(ev->flags);
+	flags = le32_to_cpu(ev->flags);
 
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u addr %s, rssi %d flags 0x%04x eir_len %u",
 			index, addr, ev->rssi, flags, eir_len);
 
-	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
-	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
-	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
-	name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
-
-	btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
-					ev->addr.type, ev->rssi, confirm_name,
-					legacy, not_connectable,
-					name_resolve_failed, eir, eir_len,
-					false);
+	btd_adapter_device_found(adapter, &ev->addr.bdaddr,
+					ev->addr.type, ev->rssi, flags,
+					eir, eir_len, false);
 }
 
 struct agent *adapter_get_agent(struct btd_adapter *adapter)
diff --git a/src/adapter.h b/src/adapter.h
index 32e49a933b13..ca96c1f6575f 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -88,14 +88,12 @@ struct btd_device *btd_adapter_find_device_by_path(struct btd_adapter *adapter,
 						   const char *path);
 struct btd_device *btd_adapter_find_device_by_fd(int fd);
 
-void btd_adapter_update_found_device(struct btd_adapter *adapter,
+void btd_adapter_device_found(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
 					uint8_t bdaddr_type, int8_t rssi,
-					bool confirm, bool legacy,
-					bool not_connectable,
-					bool name_resolve_failed,
+					uint32_t flags,
 					const uint8_t *data, uint8_t data_len,
-					bool monitored);
+					bool monitoring);
 
 const char *adapter_get_path(struct btd_adapter *adapter);
 const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter);
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index 33f4d9619c1c..cb38916fc28b 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1583,10 +1583,6 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 	const uint8_t *ad_data = NULL;
 	uint16_t ad_data_len;
 	uint32_t flags;
-	bool confirm_name;
-	bool legacy;
-	bool not_connectable;
-	bool name_resolve_failed;
 	char addr[18];
 
 	if (length < sizeof(*ev)) {
@@ -1605,21 +1601,14 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 	if (ad_data_len > 0)
 		ad_data = ev->ad_data;
 
-	flags = btohl(ev->flags);
+	flags = le32_to_cpu(ev->flags);
 
 	ba2str(&ev->addr.bdaddr, addr);
 	DBG("hci%u addr %s, rssi %d flags 0x%04x ad_data_len %u",
 			index, addr, ev->rssi, flags, ad_data_len);
 
-	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
-	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
-	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
-	name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
-
-	btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
-					ev->addr.type, ev->rssi, confirm_name,
-					legacy, not_connectable,
-					name_resolve_failed, ad_data,
+	btd_adapter_device_found(adapter, &ev->addr.bdaddr,
+					ev->addr.type, ev->rssi, flags, ad_data,
 					ad_data_len, true);
 
 	if (handle) {
-- 
2.40.1

