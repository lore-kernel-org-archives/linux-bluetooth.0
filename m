Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 607C2CCA47B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 10 Jun 2022 22:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348949AbiFJWMC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Jun 2022 18:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiFJWMB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Jun 2022 18:12:01 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125872E29A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 15:12:00 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id f12so339830ilj.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Jun 2022 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aJu4X1AfbG2KjMR6LUiax3lK7JMlrFmkj3HNPVMjbpM=;
        b=pAWtUuPX3JRUlcrUXWsK/nGcErDu6CPAyLfQEgXauYJs9b18ccBj9iLg3cVVPDZ+R1
         OycuAtLngOAViLr967KFDq1nmgJC7bft0DQNom9RKqMx939p0fmTQ67HQM6RfAI8nx0D
         tZm94J41YiICURrWYbdM3G7bKUZMvsdcsL9DhW478Rmc1h6LiR9DEGqwUaxVTyrZ4GgE
         Obg2Qz0NVjBOc0y60iQNprn4HuUAE5Asy2C1TJmz2Wu6MTfVp83a7XIzPt1s2qmKXe90
         gUGNlNCKBjth0iSK4Wxk2l6P4nGbel/garmziTIArezSvHquebn84A527p8e69JdzaAr
         W+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aJu4X1AfbG2KjMR6LUiax3lK7JMlrFmkj3HNPVMjbpM=;
        b=NbqvB1CGPnDGaeXj9vSrkt3Ts/f2ZoMDtF2ybohAw/uK7smjSAjf2Iuy9IdM/EFQIZ
         UdDqeuZatGvnweFgLAk7thlJGrhPJRZFbDKZKxaCz+adwSS0U0S3MSlyc5x4i8JUlweM
         vomYtO6UjB0yo3mFqv19sJhCTQUz9AEUK8MXIlLf1z6y55pnWQdtiarGa11GqVc4lqMp
         leFzlG89ovkad54flLajj1vloaSe+eSYBRgNXldCXU0HlmTp1iLiB4A7BdQv/F1HhiSg
         hd92j68lN1K1bbnIgm1Gqiig6hjqsC+hwgU6Tg8PU+5jD5RguQ07IDeQvrH1eGs3SNvm
         py+w==
X-Gm-Message-State: AOAM53069aoqquoqSRum73R7H8CkV8UM2Sjm671JzT9PvZ3Ut0zXpWnK
        0vA12N/mROBISrmuLng5T7cAHreaTbE=
X-Google-Smtp-Source: ABdhPJxr3iln4tpVZ6REUkmkevPK+qU8m28JB/u9kzwyFM0AboVdKzO9Ju/QzhfmippDT1ZXr5IOLQ==
X-Received: by 2002:a05:6e02:1b02:b0:2d2:f327:59c3 with SMTP id i2-20020a056e021b0200b002d2f32759c3mr26911061ilv.219.1654899119135;
        Fri, 10 Jun 2022 15:11:59 -0700 (PDT)
Received: from localhost.localdomain (c-68-47-51-143.hsd1.mn.comcast.net. [68.47.51.143])
        by smtp.gmail.com with ESMTPSA id k5-20020a026605000000b0032b3a7817b3sm117544jac.119.2022.06.10.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 15:11:58 -0700 (PDT)
From:   Michael Brudevold <puffy.taco@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Michael Brudevold <michael.brudevold@veranexsolutions.com>
Subject: [PATCH v2 2/3] Accept LE formatted EIR data with neard plugin
Date:   Fri, 10 Jun 2022 17:11:23 -0500
Message-Id: <20220610221124.18591-3-puffy.taco@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610221124.18591-1-puffy.taco@gmail.com>
References: <20220610221124.18591-1-puffy.taco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Michael Brudevold <michael.brudevold@veranexsolutions.com>

LE EIR differs from BREDR EIR in that it does not start with the device
address. Add ability to handle this data and send the correct address type
when adding remote OOB.

BREDR support remains for P-192; P-256 is not added.

This patch does not address requesting LE OOB data.
---
 plugins/neard.c | 86 ++++++++++++++++++++++++++++++++++++++++---------
 src/adapter.c   | 19 ++++++++---
 src/adapter.h   |  5 +--
 3 files changed, 88 insertions(+), 22 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 11d9e91c4..e03f981e0 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -56,11 +56,14 @@ enum cps {
 
 struct oob_params {
 	bdaddr_t address;
+	uint8_t address_type;
 	uint32_t class;
 	char *name;
 	GSList *services;
-	uint8_t *hash;
-	uint8_t *randomizer;
+	uint8_t *hash192;
+	uint8_t *randomizer192;
+	uint8_t *hash256;
+	uint8_t *randomizer256;
 	uint8_t *pin;
 	int pin_len;
 	enum cps power_state;
@@ -70,8 +73,10 @@ static void free_oob_params(struct oob_params *params)
 {
 	g_slist_free_full(params->services, free);
 	g_free(params->name);
-	g_free(params->hash);
-	g_free(params->randomizer);
+	g_free(params->hash192);
+	g_free(params->randomizer192);
+	g_free(params->hash256);
+	g_free(params->randomizer256);
 	free(params->pin);
 }
 
@@ -352,10 +357,10 @@ static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
 	remote->services = eir_data.services;
 	eir_data.services = NULL;
 
-	remote->hash = eir_data.hash192;
+	remote->hash192 = eir_data.hash192;
 	eir_data.hash192 = NULL;
 
-	remote->randomizer = eir_data.randomizer192;
+	remote->randomizer192 = eir_data.randomizer192;
 	eir_data.randomizer192 = NULL;
 
 	eir_data_free(&eir_data);
@@ -363,6 +368,36 @@ static int process_eir(uint8_t *eir, size_t size, struct oob_params *remote)
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
+	remote->hash256 = eir_data.hash256;
+	eir_data.hash256 = NULL;
+
+	remote->randomizer256 = eir_data.randomizer256;
+	eir_data.randomizer256 = NULL;
+
+	eir_data_free(&eir_data);
+}
+
 /*
  * This is (barely documented) Nokia extension format, most work was done by
  * reverse engineering.
@@ -543,7 +578,7 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 			uint8_t *eir;
 			int size;
 
-			/* nokia.com:bt and EIR should not be passed together */
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */
 			if (bacmp(&remote->address, BDADDR_ANY) != 0)
 				goto error;
 
@@ -561,7 +596,7 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 			uint8_t *data;
 			int size;
 
-			/* nokia.com:bt and EIR should not be passed together */
+			/* nokia.com:bt, EIR, and EIR.le should not be passed together */
 			if (bacmp(&remote->address, BDADDR_ANY) != 0)
 				goto error;
 
@@ -574,6 +609,23 @@ static int process_message(DBusMessage *msg, struct oob_params *remote)
 
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
 
@@ -635,10 +687,13 @@ static void store_params(struct btd_adapter *adapter, struct btd_device *device,
 	if (params->services)
 		device_add_eir_uuids(device, params->services);
 
-	if (params->hash) {
+	if (params->hash192 || params->hash256) {
 		btd_adapter_add_remote_oob_data(adapter, &params->address,
-							params->hash,
-							params->randomizer);
+							params->address_type,
+							params->hash192,
+							params->randomizer192,
+							params->hash256,
+							params->randomizer256);
 	} else if (params->pin_len) {
 		/* TODO
 		 * Handle PIN, for now only discovery mode and 'common' PINs
@@ -692,7 +747,7 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	}
 
 	device = btd_adapter_get_device(adapter, &remote.address,
-								BDADDR_BREDR);
+								remote.address_type);
 
 	err = check_device(device);
 	if (err < 0) {
@@ -716,7 +771,7 @@ static DBusMessage *push_oob(DBusConnection *conn, DBusMessage *msg, void *data)
 	free_oob_params(&remote);
 
 	err = adapter_create_bonding(adapter, device_get_address(device),
-							BDADDR_BREDR, io_cap);
+							remote.address_type, io_cap);
 	if (err < 0)
 		return error_reply(msg, -err);
 
@@ -764,7 +819,8 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 		goto done;
 	}
 
-	device = btd_adapter_get_device(adapter, &remote.address, BDADDR_BREDR);
+	device = btd_adapter_get_device(adapter, &remote.address,
+							   remote.address_type);
 
 	err = check_device(device);
 	if (err < 0)
@@ -777,7 +833,7 @@ static DBusMessage *request_oob(DBusConnection *conn, DBusMessage *msg,
 
 	store_params(adapter, device, &remote);
 
-	if (remote.hash && btd_adapter_get_powered(adapter))
+	if (remote.hash192 && btd_adapter_get_powered(adapter))
 		goto read_local;
 done:
 	free_oob_params(&remote);
diff --git a/src/adapter.c b/src/adapter.c
index f7faaa263..9cad36da8 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -8770,7 +8770,11 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 					const bdaddr_t *bdaddr,
-					uint8_t *hash, uint8_t *randomizer)
+					uint8_t bdaddr_type,
+					uint8_t *hash192,
+					uint8_t *randomizer192,
+					uint8_t *hash256,
+					uint8_t *randomizer256)
 {
 	struct mgmt_cp_add_remote_oob_data cp;
 	char addr[18];
@@ -8780,10 +8784,15 @@ int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
 
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
-	memcpy(cp.hash192, hash, 16);
-
-	if (randomizer)
-		memcpy(cp.rand192, randomizer, 16);
+	cp.addr.type = bdaddr_type;
+	if (hash192)
+		memcpy(cp.hash192, hash192, 16);
+	if (hash256)
+		memcpy(cp.hash256, hash256, 16);
+	if (randomizer192)
+		memcpy(cp.rand192, randomizer192, 16);
+	if (randomizer256)
+		memcpy(cp.rand256, randomizer256, 16);
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_ADD_REMOTE_OOB_DATA,
 				adapter->dev_id, sizeof(cp), &cp,
diff --git a/src/adapter.h b/src/adapter.h
index 688ed51c6..b0a324a78 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -213,8 +213,9 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap);
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
 
 int btd_adapter_add_remote_oob_data(struct btd_adapter *adapter,
-					const bdaddr_t *bdaddr,
-					uint8_t *hash, uint8_t *randomizer);
+					const bdaddr_t *bdaddr, uint8_t bdaddr_type,
+					uint8_t *hash192, uint8_t *randomizer192,
+					uint8_t *hash256, uint8_t *randomizer256);
 
 int btd_adapter_remove_remote_oob_data(struct btd_adapter *adapter,
 							const bdaddr_t *bdaddr);
-- 
2.25.1

