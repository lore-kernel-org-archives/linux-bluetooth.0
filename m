Return-Path: <SRS0=B7Pc=3G=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6454C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 21:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EA152072E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jan 2020 21:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kla/Id63"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgAQV2R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:28:17 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33953 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgAQV2Q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jan 2020 16:28:16 -0500
Received: by mail-pg1-f196.google.com with SMTP id r11so12266618pgf.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2020 13:28:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyLKxSm3z4lodk2y8b0SMRfV63tn/BTGECAtn31C4jQ=;
        b=kla/Id63jFH//nPi+jowrJDUg7xJt3AajXZOrZM3vTS83leWLYbroi+UuChBJMmPjs
         6TPnQztp//LsF8K5EcoYyuIZtR7RPLSXYof9DOllN1oBXsIOMdQQ1YxMbbJAJhDfJU8P
         6f60QumB9WuqsF8lCb5CMG6tQv5yVKskTII0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EyLKxSm3z4lodk2y8b0SMRfV63tn/BTGECAtn31C4jQ=;
        b=N0/6HIIyZvRLVaXYY6YdkWHBDxY+td62Et1bH6Kx1UpTy11y+K6JlrNvV5ngHVF6sS
         G4PNnlzrtDGR4LmSASwn1RrVtne7lDueXKIiltJSMCzoLMWSGFhgwZOx1c5KdOQJdNQz
         h9JyvYpgrt8VlmXYMsVLT26dUkfSMngd8eQH7WboG+TNXIVrxpXknmwr3LZJlUDdC2m2
         9e3BQSqsosnC9oWAPMk7MH/WhQWI5bhWYLChH+30TmlKAhnUvK5vWrWveQn2sxKkjSL+
         My7QMxK154qOMa67oRWm6dIAycJjxDnhWyqJQ7BjQOIEOZ9LnLoehVsmsh2YBkqzgVqB
         psvg==
X-Gm-Message-State: APjAAAWJwmXfSjChUuxMYqNlzQJ687DIjXmGs+GIFIIb6t23rZyMhzxh
        Czmhu8xdnEv9+0Me3JdYVEAtuexXdThf46EZ
X-Google-Smtp-Source: APXvYqxw4jX3VzJPR5wGmGuMnzYbABO0URkOTRpctgh1PlBs+H7RBAGLy3sbGP1vLti7Yg8YgQOEag==
X-Received: by 2002:a63:fe50:: with SMTP id x16mr46809026pgj.31.1579296496119;
        Fri, 17 Jan 2020 13:28:16 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id j20sm29938790pfe.168.2020.01.17.13.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:28:15 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     luiz.dentz@gmail.com, marcel@holtmann.org, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Subject: [BlueZ PATCH 1/2] adapter: Add set wake capable operation
Date:   Fri, 17 Jan 2020 13:28:12 -0800
Message-Id: <20200117132754.BlueZ.1.I56a225147d9cabef55f94b57129a5e37ea79d165@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

If a device is capable of waking the host system from suspend, it should
be marked as wake capable. We introduce a new management operation here
to set this property and implement the API needed to call it.

---

 doc/mgmt-api.txt | 19 +++++++++++++++
 lib/mgmt.h       |  8 +++++++
 src/adapter.c    | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h    |  2 ++
 src/device.c     | 15 ++++++++++++
 src/device.h     |  2 ++
 6 files changed, 108 insertions(+)

diff --git a/doc/mgmt-api.txt b/doc/mgmt-api.txt
index 1e59acc54..8a73a9bb9 100644
--- a/doc/mgmt-api.txt
+++ b/doc/mgmt-api.txt
@@ -3047,6 +3047,25 @@ Load Blocked Keys Command
 	Possible errors:	Invalid Parameters
 				Invalid Index
 
+Set Wake Capable Command
+===========================
+
+	Command Code:		0x0047
+	Controller Index:	<controller id>
+	Command Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Wake Capable (1 Octet)
+	Return Parameters:	Address (6 Octets)
+				Address_Type (1 Octet)
+				Wake Capable (1 Octet)
+
+	This command sets whether a bluetooth device is capable of waking the
+	system from suspend. This property is used to set the event filter and
+	LE whitelist when the system enters suspend.
+
+	Possible errors:	Failed
+				Invalid Parameters
+				Invalid Index
 
 Command Complete Event
 ======================
diff --git a/lib/mgmt.h b/lib/mgmt.h
index 276445d0a..da2cce8c5 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -597,6 +597,12 @@ struct mgmt_blocked_key_info {
 struct mgmt_cp_set_blocked_keys {
 	uint16_t key_count;
 	struct mgmt_blocked_key_info keys[0];
+
+#define MGMT_OP_SET_WAKE_CAPABLE			0x0047
+#define MGMT_SET_WAKE_CAPABLE_SIZE			8
+struct mgmt_cp_set_wake_capable {
+	struct mgmt_addr_info addr;
+	uint8_t wake_capable;
 } __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
@@ -893,6 +899,8 @@ static const char *mgmt_op[] = {
 	"Set Appearance",
 	"Get PHY Configuration",
 	"Set PHY Configuration",
+	"Set Blocked Keys",
+	"Set Wake Capable",
 };
 
 static const char *mgmt_ev[] = {
diff --git a/src/adapter.c b/src/adapter.c
index 329c3ae0b..a35cf1349 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4685,6 +4685,68 @@ void adapter_whitelist_add(struct btd_adapter *adapter, struct btd_device *dev)
 				add_whitelist_complete, adapter, NULL);
 }
 
+static void set_wake_capable_complete(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	const struct mgmt_cp_set_wake_capable *rp = param;
+	struct btd_adapter *adapter = user_data;
+	struct btd_device *dev;
+
+	char addr[18];
+
+	if (length < sizeof(*rp)) {
+		btd_error(adapter->dev_id,
+			  "Too small Set Wake Capable complete event");
+		return;
+        }
+
+	ba2str(&rp->addr.bdaddr, addr);
+
+	dev = btd_adapter_find_device(adapter, &rp->addr.bdaddr,
+				      rp->addr.type);
+	if (!dev) {
+		btd_error(adapter->dev_id,
+			  "Set Wake Capable complete for unknown device %s",
+			  addr);
+		return;
+	}
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		btd_error(adapter->dev_id,
+			  "Failed to set wake capable %s(%u) = %d: %s (0x%02x)",
+			  addr, rp->addr.type, rp->wake_capable,
+			  mgmt_errstr(status), status);
+		return;
+	}
+
+	DBG("Set wake capable complete %s (%u)", addr, rp->addr.type);
+}
+
+void adapter_set_wake_capable(struct btd_adapter* adapter,
+			      struct btd_device* dev)
+{
+	struct mgmt_cp_set_wake_capable cp;
+	char addr[18];
+
+	memset(&cp, 0, sizeof(cp));
+	bacpy(&cp.addr.bdaddr, device_get_address(dev));
+	cp.addr.type = btd_device_get_bdaddr_type(dev);
+	cp.wake_capable = device_get_wake_capable(dev);
+
+	ba2strlc(&cp.addr.bdaddr, addr);
+
+	if (!mgmt_send(adapter->mgmt, MGMT_OP_SET_WAKE_CAPABLE, adapter->dev_id,
+		       sizeof(cp), &cp, set_wake_capable_complete, adapter,
+		       NULL)) {
+		btd_warn(adapter->dev_id,
+			 "Could not set wake capable = %u on %s (%u)",
+			 cp.wake_capable, addr, cp.addr.type);
+	}
+
+	DBG("Setting %s (%u) to wake capable = %u", addr,
+	    cp.addr.type, cp.wake_capable);
+}
+
 static void remove_whitelist_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index d0a5253bd..bb63db574 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -221,6 +221,8 @@ void adapter_whitelist_add(struct btd_adapter *adapter,
 						struct btd_device *dev);
 void adapter_whitelist_remove(struct btd_adapter *adapter,
 						struct btd_device *dev);
+void adapter_set_wake_capable(struct btd_adapter* adapter,
+			      struct btd_device* dev);
 
 void btd_adapter_set_oob_handler(struct btd_adapter *adapter,
 						struct oob_handler *handler);
diff --git a/src/device.c b/src/device.c
index a4fe10980..221f23b09 100644
--- a/src/device.c
+++ b/src/device.c
@@ -189,6 +189,7 @@ struct btd_device {
 	bool		le;
 	bool		pending_paired;		/* "Paired" waiting for SDP */
 	bool		svc_refreshed;
+	bool		wake_capable;		/* Can wake from suspend */
 	GSList		*svc_callbacks;
 	GSList		*eir_uuids;
 	struct bt_ad	*ad;
@@ -1509,6 +1510,20 @@ void device_set_ltk_enc_size(struct btd_device *device, uint8_t enc_size)
 	bt_att_set_enc_key_size(device->att, device->ltk_enc_size);
 }
 
+bool device_get_wake_capable(struct btd_device *device)
+{
+	return device->wake_capable;
+}
+
+void device_set_wake_capable(struct btd_device *device, bool wake_capable)
+{
+	if (device->wake_capable == wake_capable)
+		return;
+
+	device->wake_capable = wake_capable;
+	adapter_set_wake_capable(device->adapter, device);
+}
+
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
diff --git a/src/device.h b/src/device.h
index 06b100499..44df8e22e 100644
--- a/src/device.h
+++ b/src/device.h
@@ -139,6 +139,8 @@ void device_store_svc_chng_ccc(struct btd_device *device, uint8_t bdaddr_type,
 								uint16_t value);
 void device_load_svc_chng_ccc(struct btd_device *device, uint16_t *ccc_le,
 							uint16_t *ccc_bredr);
+bool device_get_wake_capable(struct btd_device *device);
+void device_set_wake_capable(struct btd_device *device, bool wake_capable);
 
 typedef void (*disconnect_watch) (struct btd_device *device, gboolean removal,
 					void *user_data);
-- 
2.25.0.341.g760bfbb309-goog

