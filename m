Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1014130DEAC
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Dec 2025 20:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765570374; cv=pass; b=mylKcD8XIEt3J3sciuMcszdDixsj8gElyRmtSQ96repOzh1r0oFdsD3B1H45Rozi6llulj9Vf6zW+zLuYaJGG09aZ+7k56IMQT/z9/nZBohCUU64jbG/l86R80cKXdYKLbKnhBIDbB3mA/1wZPLSBHHZoEu8k/IL4R432GMkOVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765570374; c=relaxed/simple;
	bh=eutJ2ZAajbgulJW8xv3liPaW9voEZgRxV/kM1Xx84y8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aO+d0xU5VSQaenSLXyYc9U3BxeyrNQl9FpKDFi9vm+kxJ1oz0lSRgeQt6UndMt7DZWMmGMh8mqIy+uQBWzQpNNkyIiouRer7Wx4utHSV4TlJGtZ9K3s1QPLC7Ef12dB0qvwj9MGGb/TK4nkSeZ8FKK1DjbrzOxSgxVHQN/ee7D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=O3oPVQQf; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="O3oPVQQf"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a02d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dSgcC5xGQz10Gt;
	Fri, 12 Dec 2025 22:12:43 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1765570364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnfZyKNtpagHUkw21Cp3OrKOd3hg0ygvCrq9DUdub/U=;
	b=O3oPVQQfJPKglNYwyp81PJGIwIjG4WUHPTmKFwTPWVk+uqHzkI0QOoAypR7qf0SN7JEJD9
	PeZX/G1Uf0XU+n4JFUgwxZUcaN8H+InPbr4rjHFZI15qDgd3YSWWMde1XSaTSeGf0QYuOR
	dWnG/8zqzavaXHQsSfIZTPzpPu8Gm20=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1765570364;
	b=EzUbdV2OCSQDZgCwARihnpM1y6GY6MYJlAl0AMoG1GwXm+YN0kjn1KrvCTpCHM4ItpilSp
	4ltFOhbWhER/W3Uc+VGd6dZl0W4ZdkfaNu7NnvlJOg9S52mS+sqYY2mYWXam0Xmp6N8Oz9
	fdUoFmKmyOu2VcvDJgLryIpZ8uC01to=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1765570364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BnfZyKNtpagHUkw21Cp3OrKOd3hg0ygvCrq9DUdub/U=;
	b=YlbY++X3oYGXrAysVzgPLaryAve59uhWepQfhij1x5EuVHlB/A9yXGFu4OUQFSluhuxZ83
	ia3BI8DjzmxW6du5sHzG9iXMbwUpwWeSlu9YJBNoTwjwvWhuLYe08g3kV8PLlbeGMH7GjD
	q0H0zSPpGRt9jUibYZ6viEkYTk5zWM0=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v6 7/9] shared/mcp: on track changed, re-read values if notify not available
Date: Fri, 12 Dec 2025 22:12:29 +0200
Message-ID: <8e0ead8e18dd199b502d57764b414290e385f23a.1765570334.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1765570334.git.pav@iki.fi>
References: <cover.1765570334.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Notify is optional for some MCS attributes. To get new track titles etc.
re-read values on track change, if remote does not have notify on them.
---
 src/shared/mcp.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/shared/mcp.c b/src/shared/mcp.c
index 97970c495..4916289e1 100644
--- a/src/shared/mcp.c
+++ b/src/shared/mcp.c
@@ -979,7 +979,8 @@ void bt_mcs_unregister_all(struct gatt_db *db)
  */
 
 static void mcp_service_reread(struct bt_mcp_service *service,
-					struct gatt_db_attribute *attrib);
+					struct gatt_db_attribute *attrib,
+					bool skip_notify);
 
 static void mcp_debug_func(const char *str, void *user_data)
 {
@@ -1074,7 +1075,6 @@ static void mcp_pending_write_cb(bool success, uint8_t att_ecode,
 								void *user_data)
 {
 	struct bt_mcp_pending *pending = user_data;
-	uint8_t props;
 
 	if (!success) {
 		pending->write.result = BT_MCS_RESULT_COMMAND_CANNOT_COMPLETE;
@@ -1083,14 +1083,8 @@ static void mcp_pending_write_cb(bool success, uint8_t att_ecode,
 
 	pending->write.result = BT_MCS_RESULT_SUCCESS;
 
-	if (!gatt_db_attribute_get_char_data(pending->write.attrib, NULL,
-						NULL, &props, NULL, NULL))
-		return;
-	if (props & BT_GATT_CHRC_PROP_NOTIFY)
-		return;
-
 	/* If the attribute doesn't have notify, reread to get the new value */
-	mcp_service_reread(pending->service, pending->write.attrib);
+	mcp_service_reread(pending->service, pending->write.attrib, true);
 }
 
 static void mcp_pending_write_done(void *user_data)
@@ -1389,6 +1383,8 @@ static void update_track_changed(bool success, uint8_t att_ecode,
 		return;
 	}
 
+	mcp_service_reread(service, NULL, true);
+
 	DBG_SVC(service, "Track Changed");
 
 	LISTENER_CB(service, track_changed);
@@ -1626,7 +1622,7 @@ static void update_ccid(bool success, uint8_t att_ecode,
 	uint8_t v;
 
 	if (!success || !util_iov_pull_u8(&iov, &v)) {
-		DBG_SVC(service, "Unable to read Media State: error 0x%02x",
+		DBG_SVC(service, "Unable to read CCID: error 0x%02x",
 								att_ecode);
 		return;
 	}
@@ -1639,7 +1635,8 @@ static void update_ccid(bool success, uint8_t att_ecode,
 }
 
 static void mcp_service_reread(struct bt_mcp_service *service,
-					struct gatt_db_attribute *attrib)
+					struct gatt_db_attribute *attrib,
+					bool skip_notify)
 {
 	const struct {
 		struct gatt_db_attribute *attr;
@@ -1659,6 +1656,7 @@ static void mcp_service_reread(struct bt_mcp_service *service,
 	};
 	struct bt_gatt_client *client = service->mcp->client;
 	uint16_t value_handle;
+	uint8_t props;
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(attrs); ++i) {
@@ -1668,8 +1666,10 @@ static void mcp_service_reread(struct bt_mcp_service *service,
 			continue;
 
 		if (!gatt_db_attribute_get_char_data(attrs[i].attr, NULL,
-					&value_handle, NULL, NULL, NULL))
-			return;
+					&value_handle, &props, NULL, NULL))
+			continue;
+		if (skip_notify && (props & BT_GATT_CHRC_PROP_NOTIFY))
+			continue;
 
 		DBG_SVC(service, "re-read handle 0x%04x", value_handle);
 
@@ -1681,7 +1681,7 @@ static void mcp_service_reread(struct bt_mcp_service *service,
 static void notify_media_player_name(struct bt_mcp_service *service)
 {
 	/* On player name change, re-read all attributes */
-	mcp_service_reread(service, NULL);
+	mcp_service_reread(service, NULL, false);
 }
 
 static void mcp_idle(void *data)
-- 
2.51.1

