Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42A7C636D3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 30 Jan 2023 18:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238359AbjA3Sje (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238164AbjA3SjP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 30 Jan 2023 13:39:15 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8F2144B6
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 10:38:34 -0800 (PST)
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id E7BEE1B001B0
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 Jan 2023 20:38:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675103912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQY/vLLWHWuYfplArOiVKIK/ngXRIxxDaTVrCQ9IXL8=;
        b=q8VocN5ymP3MmK3HY8TYbV9CIGqs9NaZVgKz6DmULXw2Ml5Rvsav4aQVVFTrF1vRqsFEFo
        ixdmcsHg9kxUK3wlmAumVZALWuUFfUy516H9Ie61enUAXSgGAzTbxW9j5U8BpELb6nOr5f
        IR6n2GGri6OASVij2EGnn9X8hz2VWTed/dc0sEE4ViIusSeTLd9Le+ptigsbvKl7quc4Zj
        GWepW7qky8TUUPaxlg+qBjBVznFLAovApmMwrTNpu2RqHP6L1jyLkmd5oCqTaJXzGp9IN+
        qIoCfHS8342sudwKJ9Wgjiox+HXevu8SCEk0dsGzkpCN4LJKNGhGwoLepErjAQ==
Received: from monolith.lan (91-152-121-187.elisa-laajakaista.fi [91.152.121.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 6513D2058D;
        Mon, 30 Jan 2023 20:37:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQY/vLLWHWuYfplArOiVKIK/ngXRIxxDaTVrCQ9IXL8=;
        b=LVabN6st0Qz4K/gixzbcSfoDNSWD9GOQ6S2cjEolQDl/bbY4JOT0ERWgsAYJ6nol2Ysf82
        kNJT1QLvLNNLxShBXTCw41cTUKkTT2iJm2h4oWtVow3nntpJ8VbI++NxH601FEAjFqNwUt
        nSDkGmT9a4HUJ93OPIfs4GWP9RZ1TgU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1675103875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KQY/vLLWHWuYfplArOiVKIK/ngXRIxxDaTVrCQ9IXL8=;
        b=Fm/p9thT0qFPbRyAXSNuBkNL0FjzAmZcDyvsp3GRwfpNziVXJBLxpIurSoCA2XtF5kyU6x
        /LIBFKDD+eCCjyn61VTzNMFkp8l1pEdbCBHqkjYzh5jB3WQFVIVtwVp3/9KAtiG2bwHA4s
        z+yEMAoXivV+RknWNW1ZKHPQwob+o9I=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1675103875; a=rsa-sha256; cv=none;
        b=YFuvvpYxqCbWmw/DJNSiX7x9xgX1c2FoGsRfw3Ob60Pme2XbSNeh92o85MqQ9jVobCtYec
        FLfHLYe5tTrrh0ySzcro+YQHQkWDsMX357U+XFFmNn7AgxNoPNs/fjHcK/gBm6uhlOYjMX
        ex39kcDnqLadoVnn8f64gdN/k/+E+JI=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 8/8] bap: handle adapters that are not CIS Central / Peripheral capable
Date:   Mon, 30 Jan 2023 20:37:39 +0200
Message-Id: <89c50cadaefa56c85346ad7f2cd86eab756f3987.1675103676.git.pav@iki.fi>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <a8aedc0f9a4c1e21d61694589c5b7a9f31cbedc1.1675103676.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When BT adapter is not CIS Peripheral capable, use the shared/bap code
in its central-only mode, and don't register anything in the local GATT
database.

When BT adapter is not CIS Central capable, ignore the remote device
GATT database, so that we work purely in peripheral mode.

If BT adapter supports neither feature, don't do anything with BAP.
---
 profiles/audio/bap.c   | 18 ++++++++++++++++--
 profiles/audio/media.c | 11 ++++++-----
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index e5ffb7230..28c0d139a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1254,6 +1254,8 @@ static int bap_probe(struct btd_service *service)
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
+	struct bt_bap_db *ldb;
+	struct gatt_db *device_db;
 	char addr[18];
 
 	ba2str(device_get_address(device), addr);
@@ -1264,17 +1266,29 @@ static int bap_probe(struct btd_service *service)
 		return -ENOTSUP;
 	}
 
+	if (!btd_adapter_cis_central_capable(adapter) &&
+	    !btd_adapter_cis_peripheral_capable(adapter)) {
+		DBG("BAP requires CIS features, unsupported by adapter");
+		return -ENOTSUP;
+	}
+
 	/* Ignore, if we were probed for this device already */
 	if (data) {
 		error("Profile probed twice for the same device!");
 		return -EINVAL;
 	}
 
+	if (btd_adapter_cis_central_capable(adapter))
+		device_db = btd_device_get_gatt_db(device);
+	else
+		device_db = NULL;
+
 	data = bap_data_new(device);
 	data->service = service;
 
-	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
-					btd_device_get_gatt_db(device));
+	ldb = bt_bap_get_local_db(btd_gatt_database_get_db(database),
+				btd_adapter_cis_peripheral_capable(adapter));
+	data->bap = bt_bap_new(ldb, device_db);
 	if (!data->bap) {
 		error("Unable to create BAP instance");
 		free(data);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d68085514..6f83b03b5 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1105,8 +1105,9 @@ static void bap_debug(const char *str, void *user_data)
 static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 								int *err)
 {
+	struct btd_adapter *adapter = endpoint->adapter->btd_adapter;
 	struct btd_gatt_database *database;
-	struct gatt_db *db;
+	struct bt_bap_db *ldb;
 	struct iovec data;
 	char *name;
 
@@ -1116,7 +1117,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	database = btd_adapter_get_database(endpoint->adapter->btd_adapter);
+	database = btd_adapter_get_database(adapter);
 	if (!database) {
 		error("Adapter database not found");
 		return false;
@@ -1128,8 +1129,6 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	db = btd_gatt_database_get_db(database);
-
 	data.iov_base = endpoint->capabilities;
 	data.iov_len = endpoint->size;
 
@@ -1141,7 +1140,9 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 		return false;
 	}
 
-	endpoint->pac = bt_bap_add_pac(db, name, type, endpoint->codec,
+	ldb = bt_bap_get_local_db(btd_gatt_database_get_db(database),
+				btd_adapter_cis_peripheral_capable(adapter));
+	endpoint->pac = bt_bap_add_pac(ldb, name, type, endpoint->codec,
 					&endpoint->qos, &data, NULL);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
-- 
2.39.1

