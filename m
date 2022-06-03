Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A4C9C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jun 2022 22:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349402AbiFCWdD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jun 2022 18:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349416AbiFCWdA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jun 2022 18:33:00 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA402EA05
        for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jun 2022 15:32:59 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id f4so7053402iov.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jun 2022 15:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qkJe4GPv4e24ma7x1T2GA6j79xu4hzazpcnaEOzF628=;
        b=NcYZgjwgVrIFi2HJe6mfNZTZemi2+krSUcbzmFzdzQd96N6AafTu78X+f1tttBFZyW
         rGcH3chkKb47LSrEeCZvpvd341UaKkgtqD6kbH9ILGMRd2n8O98Xba+8JfMgo4tzxHUf
         as0G8Wkqd+9L7MisxdPGLZV2o9S4iQXRO3SjagwCMsiQPnbQRRJ74PsuTymkLzmIsFuD
         FADE0LmOQH4mtOmYe1sqfUMT42XG9cGq+vTZFYpsJky6rtrq8TmwBKjfzbzM8REV6n/y
         0kxSi7HmKDHimhnpJsnc0S4Fnd23dil0IldSnCrEZio6fwOah+rjx56z7QHenpUdZieL
         FwmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qkJe4GPv4e24ma7x1T2GA6j79xu4hzazpcnaEOzF628=;
        b=7yMyAdWTiD1p8gYyIXzBCtK6gVTHfvxNrjV7oqePxIRpAsmdI+8yBI/okexPlTCPNS
         AlI4pbNT+/XQzZg2d642v04XcOcB7yfDlfa6KALlsMXlxlvZW0kmU2udYqiAcV+zEXdN
         PIlwHz5S2tUFiZbTuVjJhaBuqHFALJw6pZvVc0T0EcafMqe5Ke/6d0XXbh9SRe7DK3lZ
         4WL/AguoKgsgJEphykcbO38VKoemvy7spKseUau5fRb0uxeBhMZ2nQ+KeJg14H8KFMKB
         SP4POZKZgt9SrJcw8nY0hj0s6w/tz+YNrPxCbJpWtzVNEtxKrJbXtqbTyTsqOhKEomvy
         MEMw==
X-Gm-Message-State: AOAM533G0MX11eqJtOeorrGGyrqLerrNbn/ciPjJV06TZue7XUGJm7PS
        F96LLZVvK5jNPNkWzZFyH2oPG7cDLYs=
X-Google-Smtp-Source: ABdhPJxf6PhkFXc61+Z54vMbEry8uw7xICMNSjd9r5cZTT4nSHiQdpLIw2DpPBp0w9rXe91ubd4W0Q==
X-Received: by 2002:a02:c6cf:0:b0:331:617f:ce6c with SMTP id r15-20020a02c6cf000000b00331617fce6cmr6778030jan.203.1654295578484;
        Fri, 03 Jun 2022 15:32:58 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id f2-20020a02b782000000b003315c00e885sm2825352jam.0.2022.06.03.15.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 15:32:58 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH 2/3] Accept LE formatted EIR data with neard plugin
Date:   Fri,  3 Jun 2022 17:32:24 -0500
Message-Id: <20220603223225.20296-3-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220603223225.20296-1-puffy.taco@gmail.com>
References: <20220603223225.20296-1-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

LE EIR differs from BREDR EIR in that it does not start with the device
address. Add ability to handle this data and send the correct address type
when adding remote OOB.

This patch does not address requesting LE OOB data.
---
 plugins/neard.c | 60 ++++++++++++++++++++++++++++++++++++++++++++-----
 src/adapter.c   |  3 ++-
 src/adapter.h   |  2 +-
 3 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 99762482c..cc56f922f 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -56,6 +56,7 @@ enum cps {
 
 struct oob_params {
 	bdaddr_t address;
+	uint8_t address_type;
 	uint32_t class;
 	char *name;
 	GSList *services;
@@ -363,6 +364,36 @@ static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
 	return 0;
 }
 
+static void process_eir_le(uint8_t *eir, size_t size, struct oob_params *remote)
+{
+	struct eir_data eir_data;
+
+	DBG("size %zu", size);
+
+	memset(&eir_data, 0, sizeof(eir_data));
+
+	eir_parse(&eir_data, eir, size);
+
+	bacpy(&remote->address, &eir_data.addr);
+	remote->address_type = eir_data.addr_type;
+
+	remote->class = eir_data.class;
+
+	remote->name = eir_data.name;
+	eir_data.name = NULL;
+
+	remote->services = eir_data.services;
+	eir_data.services = NULL;
+
+	remote->hash = eir_data.hash;
+	eir_data.hash = NULL;
+
+	remote->randomizer = eir_data.randomizer;
+	eir_data.randomizer = NULL;
+
+	eir_data_free(&eir_data);
+}
+
 /*
  * This is (barely documented) Nokia extension format, most work was done by
  * reverse engineering.
@@ -543,7 +574,7 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 			uint8_t *eir;
 			int size;
 
-			/* nokia.com:bt and EIR should not be passed together */
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */
 			if (bacmp(&remote->address, BDADDR_ANY) != 0)
 				goto error;
 
@@ -561,7 +592,7 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 			uint8_t *data;
 			int size;
 
-			/* nokia.com:bt and EIR should not be passed together */
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */
 			if (bacmp(&remote->address, BDADDR_ANY) != 0)
 				goto error;
 
@@ -574,6 +605,23 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 
 			if (process_nokia_com_bt(data, size, remote))
 				goto error;
+		} else if (strcasecmp(key, "EIR.le") == 0) {
+			DBusMessageIter array;
+			uint8_t *eir;
+			int size;
+
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */
+			if (bacmp(&remote->address, BDADDR_ANY) != 0)
+				goto error;
+
+			if (dbus_message_iter_get_arg_type(&value) !=
+					DBUS_TYPE_ARRAY)
+				goto error;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, &eir, &size);
+
+			process_eir_le(eir, size, remote);
 		} else if (strcasecmp(key, "State") == 0) {
 			const char *state;
 
@@ -637,6 +685,7 @@ static void store_params(struct btd_adapter *adapter, struct btd_device *device,
 
 	if (params->hash) {
 		btd_adapter_add_remote_oob_data(adapter, &params->address,
+							params->address_type,
 							params->hash,
 							params->randomizer);
 	} else if (params->pin_len) {
@@ -692,7 +741,7 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	}
 
 	device = btd_adapter_get_device(adapter, &remote.address,
-								BDADDR_BREDR);
+								remote.address_type);
 
 	err = check_device(device);
 	if (err < 0) {
@@ -716,7 +765,7 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	free_oob_params(&remote);
 
 	err = adapter_create_bonding(adapter, device_get_address(device),
-							BDADDR_BREDR, io_cap);
+							remote.address_type, io_cap);
 	if (err < 0)
 		return error_reply(msg, -err);
 
@@ -764,7 +813,8 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 		goto done;
 	}
 
-	device = btd_adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
+	device = btd_adapter_get_device(adapter, &remote.address,
+							   remote.address_type);
 
 	err = check_device(device);
 	if (err < 0)
diff --git a/src/adapter.c b/src/adapter.c
index f7faaa263..d9823c48c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8769,7 +8769,7 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 }
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
-					const bdaddr_t *bdaddr,
+					const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					uint8_t *hash, uint8_t *randomizer)
 {
 	struct mgmt_cp_add_remote_oob_data cp;
@@ -8780,6 +8780,7 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
+	cp.addr.type = bdaddr_type;
 	memcpy(cp.hash192, hash, 16);
 
 	if (randomizer)
diff --git a/src/adapter.h b/src/adapter.h
index 688ed51c6..bbf8a42ee 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -213,7 +213,7 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap);
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
-					const bdaddr_t *bdaddr,
+					const bdaddr_t *bdaddr, uint8_t bdaddr_type,
 					uint8_t *hash, uint8_t *randomizer);
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
-- 
2.25.1

