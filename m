Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B891A2F744F
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Dec 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764708491; cv=pass; b=tyP/A//nWhn6tK5+v9qubGJMDftMvW4dd/acuhWa4BzIIZ72wXOSm0vwgyZDZV1fQVFvpMqTvH5ez0KIJqvUYYvjPQUyeaP0MeuMyJIP+ZJ8frb5tuwPHZ5QPVRWUABv2R6S0JZsrjhHK7lFlqNoZQxx9tGZn+0Oeag1fFjRMQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764708491; c=relaxed/simple;
	bh=BCeD8ePDtuI3Bt8pG8J2vyprYPBlHPFZJaEz/7rVzeM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGK/lE55rpYyGggXuyfkDaLX8GR2OiSn/QpUBKAT44XuFZFRAXJV7y5RCib5uARi8E+Ph2YXAPlhecdByJjb8v2EYk0/8dKVjG4tL4NJx56Zfj9+rHXX/bJU6INHMVi5RQLafe0wRrWoxQo71RkhK7RCYI8k++lhlxa3gLVGTkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=jjZ1IATD; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="jjZ1IATD"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:3::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4dLXsR6PlYz10M6;
	Tue,  2 Dec 2025 22:47:55 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj2npiU1/k95aPJZ/6YCDbrZrDQwx0KVSVzGSgkE+T8=;
	b=jjZ1IATDe99fwi/FLo1pheLq+khEKvC/KBjtspz9tUE+OI28sZSbaXQDuNLziR3PnA8Kd7
	+hmoF+x/LIsAQ+ODmZ0V1fL2Y20/wQ0YojWeDCOg0yflWMunWqr+ywy6ZVgM2id42z6XC5
	kKU/tQ0kIejBK4Kffvl7oK6dh143JFs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1764708475;
	b=XArYexAvB+xnKO9BBv0Gi/8FmBi2SAzWmOCwDSt8bfLS02ttQ82s2DYNZfncuuS8gBnzuv
	WxIUGlJM6K8RW05BnHpngzmlyPKDus3LVQRUc41sW5AIqmJ0Tlx+KDFXzRbh4d4Jf6vpzl
	gGXfXua7S7XmkRHotz0CDcgDK5yR/+0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1764708475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yj2npiU1/k95aPJZ/6YCDbrZrDQwx0KVSVzGSgkE+T8=;
	b=hnY1CUpPM2QaUD5mlHil8WQSO85X2xSWHGDb/NnSCXtBe3A3+QjpBBZaIi2mIO9BAeIFGi
	tNYaMlsJjn1+CXhYQ0XCWkPCijeO0X4t8cmtFWViYg3zuDzQTWhLMK7N/xhbJXj7hZo/jL
	XwrDTQ5xtzChWwt7nKcRBdqYRNZJIp4=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v3 6/7] shared/vcp: add ready callback to bt_vcp_attach()
Date: Tue,  2 Dec 2025 22:47:51 +0200
Message-ID: <2df6144985b594eb07f379a6b9f831c07205f36d.1764708372.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1764708372.git.pav@iki.fi>
References: <cover.1764708372.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add callback that is called when VCP client has finished attaching, so
that caller can know when it can be used.
---

Notes:
    v3:
    - new commit

 src/shared/vcp.c | 29 ++++++++++++++++++++++++++++-
 src/shared/vcp.h |  3 ++-
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/src/shared/vcp.c b/src/shared/vcp.c
index b766faef6..c7f74956e 100644
--- a/src/shared/vcp.c
+++ b/src/shared/vcp.c
@@ -203,6 +203,10 @@ struct bt_vcp {
 	unsigned int aics_ip_status_id;
 	unsigned int aics_ip_descr_id;
 
+	unsigned int idle_id;
+	bt_vcp_func_t ready_func;
+	void *ready_data;
+
 	struct queue *notify;
 	struct queue *pending;
 
@@ -427,6 +431,11 @@ void bt_vcp_detach(struct bt_vcp *vcp)
 	if (!queue_remove(sessions, vcp))
 		return;
 
+	if (vcp->idle_id) {
+		bt_gatt_client_idle_unregister(vcp->client, vcp->idle_id);
+		vcp->idle_id = 0;
+	}
+
 	if (vcp->client) {
 		bt_gatt_client_unref(vcp->client);
 		vcp->client = NULL;
@@ -2976,7 +2985,18 @@ static void foreach_aics_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(attr, foreach_aics_char, vcp);
 }
 
-bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
+static void vcp_idle(void *data)
+{
+	struct bt_vcp *vcp = data;
+
+	vcp->idle_id = 0;
+
+	if (vcp->ready_func)
+		vcp->ready_func(vcp, vcp->ready_data);
+}
+
+bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client,
+				bt_vcp_func_t ready, void *ready_user_data)
 {
 	bt_uuid_t uuid;
 
@@ -3004,5 +3024,12 @@ bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client)
 	bt_uuid16_create(&uuid, AUDIO_INPUT_CS_UUID);
 	gatt_db_foreach_service(vcp->rdb->db, &uuid, foreach_aics_service, vcp);
 
+	vcp->ready_func = ready;
+	vcp->ready_data = ready_user_data;
+
+	if (!vcp->idle_id)
+		vcp->idle_id = bt_gatt_client_idle_register(vcp->client,
+							vcp_idle, vcp, NULL);
+
 	return true;
 }
diff --git a/src/shared/vcp.h b/src/shared/vcp.h
index 705b6f301..89efaa09c 100644
--- a/src/shared/vcp.h
+++ b/src/shared/vcp.h
@@ -43,7 +43,8 @@ void bt_vcp_unref(struct bt_vcp *vcp);
 
 void bt_vcp_add_db(struct gatt_db *db);
 
-bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client);
+bool bt_vcp_attach(struct bt_vcp *vcp, struct bt_gatt_client *client,
+				bt_vcp_func_t ready, void *ready_user_data);
 void bt_vcp_detach(struct bt_vcp *vcp);
 
 uint8_t bt_vcp_get_volume(struct bt_vcp *vcp);
-- 
2.51.1

