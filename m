Received: from mail.discnull.de (mail.discnull.de [46.224.56.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E71B49E5C7
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Sep 2026 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.224.56.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790263488; cv=none; b=YJE1Rics0TiSIFCP6NdSuwAso4v57OA14uMMLW0Ah9yJzCOYSFwLkXtdmZZqZ7Z0WUjQ2n8fpTwl8R5TBkh+Ci/9LONlIt/oHb1S8splALYOB4l97RPIKywhtQGh7BxNL59hYdMIbKx+jESP7DcYU8hcjbCtpdJpYEXN83vKcIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790263488; c=relaxed/simple;
	bh=NrfJf+Pswx6dMtGBs0GSwp7hDLbR43Jd0wjYvsRPbf8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iQI8/YZm4ptKKtHbD6FMhb6dh5eRGmIr4Ua90jUn7bf9MJHi+8gqyMjsSXaFTvdkSge4k14N3NmqCkyBq18hq+WIKSdh4vOK7N/Cga+2BxcVWWlPLrWWp6utMJ7AazkM8DCGv2MtHHwT+kQ64dxIWCLoCLtOAY2DycFjtm7oJt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de; spf=pass smtp.mailfrom=discnull.de; dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b=bcdqiIus; arc=none smtp.client-ip=46.224.56.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=discnull.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=discnull.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=discnull.de header.i=@discnull.de header.b="bcdqiIus"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6B5137D78A;
	Thu, 24 Sep 2026 17:17:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=discnull.de; s=dkim;
	t=1790263077; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=irFtxq//IFwu6Un/QYr9zk2mxaa77l/bIpajyhPkJTQ=;
	b=bcdqiIusRKJs7YuwoF0zkxk9JWEEjwHU87LkpCoD0TQ4YXeUTBxdtq8dgRFIiUeO19IFOE
	9rQl4FRCZEnh2LN5RBTGljB0hQwuRwyAaJ6Zob2Lq9m0Ejuddk/zWu497ThcCFhgUu9oJ0
	BQiJqYkvMINRD5+PUdFbjstvKsr//DMuss4sGIHsKO6X1lIEvuvCUaHUK5wAUpUjaFiPdo
	j+JdpkDDK2QkXvbhmkgdFIZ5SMxHJVzS5is1UcpoQy7EiHK6MF6X391HKi+QGv4YqOul58
	VE1Nk04evha2Oy5qrnbhQ8I438MhfQJIX4PJXbaU52MO1x9VX+WREp0JEn2Hpg==
From: Alexander Sarmanow <as@discnull.de>
To: linux-bluetooth@vger.kernel.org
Cc: Alexander Sarmanow <as@discnull.de>
Subject: [PATCH BlueZ 2/2] advertising: Add broadcast name property support
Date: Thu, 24 Sep 2026 17:17:20 +0200
Message-Id: <20260924151720.1769259-3-as@discnull.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260924151720.1769259-1-as@discnull.de>
References: <20260924151720.1769259-1-as@discnull.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

This update enables setting the BROADCAST_NAME property via the
LEAdvertisement1 object.
---
 src/advertising.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 src/shared/ad.h   |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/src/advertising.c b/src/advertising.c
index 1ed09c902..e1b7ce97a 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -69,6 +69,7 @@ struct btd_adv_client {
 	char *owner;
 	char *path;
 	char *name;
+	char *bcast_name;
 	uint16_t appearance;
 	uint16_t duration;
 	uint16_t timeout;
@@ -153,6 +154,7 @@ static void client_free(void *data)
 		g_free(client->path);
 
 	free(client->name);
+	free(client->bcast_name);
 	free(client);
 }
 
@@ -674,6 +676,42 @@ static bool parse_local_name(DBusMessageIter *iter,
 	return true;
 }
 
+static bool parse_bcast_name(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	const char *bcast_name;
+	size_t len;
+
+	if (!iter) {
+		free(client->bcast_name);
+		client->bcast_name = NULL;
+		return true;
+	}
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_STRING)
+		return false;
+
+	dbus_message_iter_get_basic(iter, &bcast_name);
+
+	len = strlen(bcast_name);
+	if (len < BT_AD_BC_NAME_MIN_LEN) {
+		error("Broacast name %s too short", bcast_name);
+		return false;
+	}
+
+	if (len > BT_AD_BC_NAME_MAX_LEN) {
+		warn("Broacast name %s too long. Truncating...", bcast_name);
+		len = BT_AD_BC_NAME_MAX_LEN;
+	}
+
+	free(client->bcast_name);
+	client->bcast_name = strndup(bcast_name, len);
+
+	DBG("Adding Broadcast Name %s to adv data", client->bcast_name);
+
+	return true;
+}
+
 static bool parse_appearance(DBusMessageIter *iter,
 					struct btd_adv_client *client)
 {
@@ -934,6 +972,11 @@ static uint8_t *generate_adv_data(struct btd_adv_client *client,
 		bt_ad_add_name(client->data, client->name);
 	}
 
+	if ((client->type == AD_TYPE_BROADCAST) && client->bcast_name) {
+		bt_ad_add_data(client->data, BT_AD_BC_NAME, client->bcast_name,
+				strlen(client->bcast_name));
+	}
+
 	return bt_ad_generate(client->data, len);
 }
 
@@ -1329,6 +1372,7 @@ static struct adv_parser {
 	{ "ServiceData", parse_service_data_ad },
 	{ "ScanResponseServiceData", parse_service_data_sr, true },
 	{ "Includes", parse_includes },
+	{ "BroadcastName", parse_bcast_name },
 	{ "LocalName", parse_local_name },
 	{ "Appearance", parse_appearance },
 	{ "Duration", parse_duration },
diff --git a/src/shared/ad.h b/src/shared/ad.h
index 71be8727b..f2843b5d6 100644
--- a/src/shared/ad.h
+++ b/src/shared/ad.h
@@ -15,6 +15,8 @@
 #include "bluetooth/uuid.h"
 
 #define BT_AD_MAX_DATA_LEN		31
+#define BT_AD_BC_NAME_MIN_LEN		4
+#define BT_AD_BC_NAME_MAX_LEN		32
 #define BT_EA_MAX_DATA_LEN		251
 #define BT_PA_MAX_DATA_LEN		252
 
@@ -60,6 +62,7 @@
 #define BT_AD_MESH_DATA			0x2a
 #define BT_AD_MESH_BEACON		0x2b
 #define BT_AD_CSIP_RSI			0x2e
+#define BT_AD_BC_NAME			0x30
 #define BT_AD_3D_INFO_DATA		0x3d
 #define BT_AD_MANUFACTURER_DATA		0xff
 
-- 
2.30.2

