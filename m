Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F15CE7B1E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 19:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjI1TNx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 15:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1TNw (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 15:13:52 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23198194
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 12:13:51 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 5614622812f47-3af6bd48093so281609b6e.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 12:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695928430; x=1696533230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=G7n1MMetRWMiDVlP8bztrbYv7/3piwCnbkbnF7yATs0=;
        b=VDpDmregI3tMOzgjCjUJaxYJ9EL2i0WPKMblbI8RQMyRH7d8BjRULLCuL43pquZMaT
         eO9/HQEji0SKzXDFUt2ah2bLxGqqhRq9TAlYntBwOTBG1UX2vegwERHNrIAQAF2ZM4h5
         A63jZd2oCoBTUrQkMv11DR8D7xoVfogKbQj6l/z11UbWFoMTNZA8mnlSlUacfELVcdFs
         x/UWocS/uqqrB760LWkYyv8zIqDZMxiqv7bkSECvCuIeukz4ibZfh/c42bBVIXM0hbB7
         +QVmPCvsuoXzPMrvWOZ/xomYdqDgu9F2FWNS0OK8OIWAaHlJtVNzp5O9D8h08B3wPgD1
         AJEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695928430; x=1696533230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G7n1MMetRWMiDVlP8bztrbYv7/3piwCnbkbnF7yATs0=;
        b=B4gyXCB1w4Y8tEQqhtG9EGh5ZkpcirzFLYsWzCb/NqQpjHi90uYCs9aJqRUaVLdBT9
         p5j9V9Jv9ngc6Ss4mbSppq0cy0f1lpvGFDOljckpdBsF5ByMJOuSJN0nJ30oYwjrCrFC
         2Xmoi3CrsXq1ZvghFsp15J+WO4UZuMgNDSOCPsqvKkxCKxoImqGmevyEzKJ8IwxqjLlB
         KLCSyiNn+Q25vXAxY8aBJDnzTJHZlGz/Arahn+I78W+PBkWM/lq60jRSVQG23Jp0o6kb
         NDs/cGQtmSIXMdHvJpMPytcRb9BOGlWBY8a/GEvj2EUPtNPpGvFdmxqMCERB/RBoWQ3E
         JDmw==
X-Gm-Message-State: AOJu0YzeskTKBryt/w1HME9EtbApfikCXdmGTzvO2ZB07mOdqOe/Mv+S
        Gf+VZc4ekKaP+xWpBRJ9xIWq4JPl8MyBTpUy
X-Google-Smtp-Source: AGHT+IHBBup1P/OJe0eVe1bIeJIseNGgt4J5qZIYdz88bK6YdFlWg3uh0OgVTGKYQHWgVcx9uHyAuw==
X-Received: by 2002:a05:6870:c6a2:b0:1c8:bca6:1f2a with SMTP id cv34-20020a056870c6a200b001c8bca61f2amr2207172oab.3.1695928429642;
        Thu, 28 Sep 2023 12:13:49 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id w16-20020a637b10000000b0057c44503835sm11643370pgc.65.2023.09.28.12.13.48
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 12:13:48 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] csip: Fix not registering CSIS service
Date:   Thu, 28 Sep 2023 12:13:46 -0700
Message-ID: <20230928191347.2086937-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

adapter_probe callback shall register service the plugin wants to
expose which was not the case for csip since it depended on a device to
register the bt_csip instance which is then responsible to register its
attributes, so this change it so there is a dedicated driver for CSIS
which takes care of creating the necessary attributes and associate it
with the adapter so it can be cleanup properly.
---
 profiles/audio/csip.c | 150 +++++++++++++++++++++++++++++++++---------
 1 file changed, 119 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/csip.c b/profiles/audio/csip.c
index ec042afd54eb..05bf588d8d6f 100644
--- a/profiles/audio/csip.c
+++ b/profiles/audio/csip.c
@@ -54,7 +54,13 @@
 
 #define CSIS_UUID_STR "00001846-0000-1000-8000-00805f9b34fb"
 
+struct csis_data {
+	struct btd_adapter *adapter;
+	struct bt_csip *csip;
+};
+
 struct csip_data {
+	struct btd_adapter *adapter;
 	struct btd_device *device;
 	struct btd_service *service;
 	struct bt_csip *csip;
@@ -62,6 +68,7 @@ struct csip_data {
 };
 
 static struct queue *sessions;
+static struct queue *servers;
 
 static void csip_debug(const char *str, void *user_data)
 {
@@ -78,12 +85,6 @@ static struct csip_data *csip_data_new(struct btd_device *device)
 	return data;
 }
 
-static bool csip_ltk_read(struct bt_csip *csip, uint8_t k[16], void *user_data)
-{
-	/* TODO: Retrieve LTK using device object */
-	return false;
-}
-
 static void csip_data_add(struct csip_data *data)
 {
 	DBG("data %p", data);
@@ -95,10 +96,6 @@ static void csip_data_add(struct csip_data *data)
 
 	bt_csip_set_debug(data->csip, csip_debug, NULL, NULL);
 
-	bt_csip_set_sirk(data->csip, btd_opts.csis.encrypt, btd_opts.csis.sirk,
-				btd_opts.csis.size, btd_opts.csis.rank,
-				csip_ltk_read, data);
-
 	if (!sessions)
 		sessions = queue_new();
 
@@ -201,25 +198,6 @@ static void csip_attached(struct bt_csip *csip, void *user_data)
 	data->csip = csip;
 
 	csip_data_add(data);
-
-}
-
-static int csip_server_probe(struct btd_profile *p,
-				struct btd_adapter *adapter)
-{
-	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
-
-	DBG("CSIP path %s", adapter_get_path(adapter));
-
-	bt_csip_add_db(btd_gatt_database_get_db(database));
-
-	return 0;
-}
-
-static void csip_server_remove(struct btd_profile *p,
-					struct btd_adapter *adapter)
-{
-	DBG("CSIP remove Adapter");
 }
 
 static int csip_accept(struct btd_service *service)
@@ -332,9 +310,114 @@ static struct btd_profile csip_profile = {
 	.accept		= csip_accept,
 	.disconnect	= csip_disconnect,
 
-	.adapter_probe	= csip_server_probe,
-	.adapter_remove	= csip_server_remove,
+	.experimental	= true,
+};
 
+static bool csis_ltk_read(struct bt_csip *csip, uint8_t k[16], void *user_data)
+{
+	/* TODO: Retrieve LTK using device object */
+	return false;
+}
+
+static void csis_data_add(struct csis_data *data)
+{
+	DBG("data %p", data);
+
+	if (queue_find(servers, NULL, data)) {
+		error("data %p already added", data);
+		return;
+	}
+
+	bt_csip_set_debug(data->csip, csip_debug, NULL, NULL);
+
+	bt_csip_set_sirk(data->csip, btd_opts.csis.encrypt, btd_opts.csis.sirk,
+				btd_opts.csis.size, btd_opts.csis.rank,
+				csis_ltk_read, data);
+
+	if (!servers)
+		servers = queue_new();
+
+	queue_push_tail(servers, data);
+}
+
+static struct csis_data *csis_data_new(struct btd_adapter *adapter)
+{
+	struct csis_data *data;
+
+	data = new0(struct csis_data, 1);
+	data->adapter = adapter;
+
+	return data;
+}
+
+static int csis_server_probe(struct btd_profile *p, struct btd_adapter *adapter)
+{
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct csis_data *data;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	data = csis_data_new(adapter);
+
+	data->csip = bt_csip_new(btd_gatt_database_get_db(database), NULL);
+	if (!data->csip) {
+		error("Unable to create CSIP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	csis_data_add(data);
+
+	return 0;
+}
+
+static bool match_csis(const void *data, const void *match_data)
+{
+	const struct csis_data *csis = data;
+	const struct btd_adapter *adapter = match_data;
+
+	return csis->adapter == adapter;
+}
+
+static void csis_data_free(struct csis_data *data)
+{
+	bt_csip_unref(data->csip);
+	free(data);
+}
+
+static void csis_data_remove(struct csis_data *data)
+{
+	DBG("data %p", data);
+
+	csis_data_free(data);
+
+	if (queue_isempty(servers)) {
+		queue_destroy(servers, NULL);
+		servers = NULL;
+	}
+}
+
+static void csis_server_remove(struct btd_profile *p,
+					struct btd_adapter *adapter)
+{
+	struct csis_data *data;
+
+	DBG("path %s", adapter_get_path(adapter));
+
+	data = queue_remove_if(servers, match_csis, adapter);
+	if (!data)
+		return;
+
+	csis_data_remove(data);
+}
+
+static struct btd_profile csis_profile = {
+	.name		= "csis",
+	.priority	= BTD_PROFILE_PRIORITY_MEDIUM,
+	.local_uuid	= CSIS_UUID_STR,
+
+	.adapter_probe	= csis_server_probe,
+	.adapter_remove	= csis_server_remove,
 	.experimental	= true,
 };
 
@@ -344,6 +427,10 @@ static int csip_init(void)
 {
 	int err;
 
+	err = btd_profile_register(&csis_profile);
+	if (err)
+		return err;
+
 	err = btd_profile_register(&csip_profile);
 	if (err)
 		return err;
@@ -355,6 +442,7 @@ static int csip_init(void)
 
 static void csip_exit(void)
 {
+	btd_profile_unregister(&csis_profile);
 	btd_profile_unregister(&csip_profile);
 	bt_csip_unregister(csip_id);
 }
-- 
2.41.0

