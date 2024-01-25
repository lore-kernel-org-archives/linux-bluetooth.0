Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8A130E25
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706209698; cv=none; b=RJhKV2Hc9VfuD91lEzdbGo9IybIsJlEIy35QiJ+4Oa/ZECR4DGAv21yp0gFz/Ehv5UNatGCqMXNntYSGouJ9ZQvn+8KUjUjTia0C5k06kRJW0ivlkODBZCyT4UbzHNBG8COjzuw9J1nOvzansgx/HqNrSunaIvO7M86Ti7RFoyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706209698; c=relaxed/simple;
	bh=WdBUdqcKOux8RTVoIpwaJ5u983v55MMB+x+pK+1qM9Q=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZAl5WDRIXr67OCDMK9AQvB1qF/EiJLv9C6x4vdhUrTnUC/sfNRNRgmZEktT+bCqGowDe6iZKosvbupPkyyUWKSkW27m7jocs99EvLpbez4DfIcdj6OyzcihSpe/FlMz39QowSzlaf3TCWB4SGBYKBZX224zfMZ7P1hHdbgOHuv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ty1aywMT; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ty1aywMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706209694;
	bh=WdBUdqcKOux8RTVoIpwaJ5u983v55MMB+x+pK+1qM9Q=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Ty1aywMThFWY7HxOozT3KwxYr/ohfW679OoejYdvFNdCS7gxIwjUsqAzbOiL8u9OA
	 koPTOofyx+kZfOCo4W5qZXLO0CiwUPJ6gw8f1a8NTENEqK0kNbSk/MG1rEJcMjn5nF
	 L92WvXkxM3KFcuXO38Q24M0pPVVaZ3P2itOljbdbSvkygdyD3WFt1R1WXGYcWXmeNR
	 n4v/i9wKjohOclFZhf0pHRPuh5dKHWux43NjB6FAKjlxXrGpD7FIezRdh/Q7RrnXDQ
	 GwSiaiJ9Nrgh5Ux3NfvDCopKMxaBMTnYwuLd45Uu/6m057p82zradFj/x3810Fi9g9
	 +mkIgzbsP4sAA==
Received: from fdanis-XPS-13-9370.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4FCCB3781F89
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 19:08:14 +0000 (UTC)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/5] shared/gatt: Prevent security level change for PTS GATT tests
Date: Thu, 25 Jan 2024 20:08:01 +0100
Message-Id: <20240125190805.1244787-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125190805.1244787-1-frederic.danis@collabora.com>
References: <20240125190805.1244787-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Some PTS GATT tests like GATT/CL/GAR/BI-04-C request to be able to get the
security error and do not try to change the security level.

This commit adds the ability to prevent to change the security level for
an operation.
---
 src/shared/att.c         | 26 ++++++++++++++++++++++++++
 src/shared/att.h         |  1 +
 src/shared/gatt-client.c | 19 +++++++++++++++++++
 src/shared/gatt-client.h |  3 +++
 4 files changed, 49 insertions(+)

diff --git a/src/shared/att.c b/src/shared/att.c
index 62c884b65..485ef071b 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -2042,3 +2042,29 @@ bool bt_att_has_crypto(struct bt_att *att)
 
 	return att->crypto ? true : false;
 }
+
+bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry)
+{
+	struct att_send_op *op;
+
+	if (!id)
+		return false;
+
+	op = queue_find(att->req_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_find(att->ind_queue, match_op_id, UINT_TO_PTR(id));
+	if (op)
+		goto done;
+
+	op = queue_find(att->write_queue, match_op_id, UINT_TO_PTR(id));
+
+done:
+	if (!op)
+		return false;
+
+	op->retry = !retry;
+
+	return true;
+}
diff --git a/src/shared/att.h b/src/shared/att.h
index 4aa3de87b..6fd78636e 100644
--- a/src/shared/att.h
+++ b/src/shared/att.h
@@ -110,3 +110,4 @@ bool bt_att_set_local_key(struct bt_att *att, uint8_t sign_key[16],
 bool bt_att_set_remote_key(struct bt_att *att, uint8_t sign_key[16],
 			bt_att_counter_func_t func, void *user_data);
 bool bt_att_has_crypto(struct bt_att *att);
+bool bt_att_set_retry(struct bt_att *att, unsigned int id, bool retry);
diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 5de679c9b..6340bcd85 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -3818,3 +3818,22 @@ bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 
 	return false;
 }
+
+bool bt_gatt_client_set_retry(struct bt_gatt_client *client,
+					unsigned int id,
+					bool retry)
+{
+	struct request *req;
+
+	if (!client || !id)
+		return false;
+
+	req = queue_find(client->pending_requests, match_req_id,
+							UINT_TO_PTR(id));
+	if (!req)
+		return false;
+
+	bt_att_set_retry(client->att, req->att_id, retry);
+
+	return true;
+}
diff --git a/src/shared/gatt-client.h b/src/shared/gatt-client.h
index bccd04a62..63cf99500 100644
--- a/src/shared/gatt-client.h
+++ b/src/shared/gatt-client.h
@@ -134,3 +134,6 @@ unsigned int bt_gatt_client_idle_register(struct bt_gatt_client *client,
 					bt_gatt_client_destroy_func_t destroy);
 bool bt_gatt_client_idle_unregister(struct bt_gatt_client *client,
 						unsigned int id);
+bool bt_gatt_client_set_retry(struct bt_gatt_client *client,
+					unsigned int id,
+					bool retry);
-- 
2.34.1

