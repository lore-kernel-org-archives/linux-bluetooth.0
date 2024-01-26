Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6500917BAE
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jan 2024 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706251360; cv=none; b=QipxH9g71uu7SqEgCcpRAVFdD5gTJH+qy6ryBCfLomfmk9SLiVrAwOZs0Vz8QYK3pplDQMoR03WKOEQT4/zwYemY5XrX/tNdZB07rcXJYPJ+Vl13LK395a54y9UnbBHksH84dtbLVK6B77LC5ht+UgdeH/Dn8MTFiaul0HaorWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706251360; c=relaxed/simple;
	bh=lvVhfTreY0kg1t8ABLNmkd4izh/oGy3dNOuXjNBtD28=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=bI/ABi0+w3kC2VgZMyU5idPkCODlfncEGLbvAEsgxusVCtQwhrMZz8vkyb1I5lfAIp+zjqeeqNAN/ecK5OurFNuiL1xMbmoPCSfbNDz3kmt06MGJuj0uGA6BBSYuqot2YQCLEQQbvgt8/daxonTuCmHhsUjpM+rqb9Q7Q+khRA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U3r+7TT/; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U3r+7TT/"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc2629d180fso797991276.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jan 2024 22:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706251357; x=1706856157; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p99EHBRZllVQ+I/UFUuFLhuTfAlCNeiDolSEaa7EKwk=;
        b=U3r+7TT/HS7SGV4zcCGDvGTK9rBeNODkJ0MmMYHp1trpVI8BlXA0c831FkQ6QZfMe7
         CJsqbblZLrw9A9uacn82Y/XuVozP3YZN928gRIECoNSQ1J/awL8jnfDesMXcuO/NTc33
         M/C38mVLzq+s/TQyKz8gJuEAGukolHBt4OMC7pieLdl7XzJS1a/Phch+0ejiHtd0SLiR
         FLARN3wOkhwDDKLxPpm5XqvVeKu9ew/+skjnu+tP8j8LMnSscqLmLc4IyWZ+oxldKLL8
         +8feXjUty2RNaqc8/RaODd13lUGbsnVbf/N/R2cTwMtYUgp9UXIozITotiTjoqlBYCUm
         cI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706251357; x=1706856157;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p99EHBRZllVQ+I/UFUuFLhuTfAlCNeiDolSEaa7EKwk=;
        b=eOuSxZFMXcQGNKTukHyog/Rmpjy+TLYwEYxozS/289vEWae4XIU5bLHtQXzTiBZVay
         ORHK4KxfDbmW6hEJhT/aKGlRwLeOwwv+FhwFG3WQhuS0SAiH9Wd+wI9HWxVSC+8xUUgg
         X3tBKlulClPVlIkRlogYcOgYTxCfRUACHxXf7CwPP/2mvA8MmuAXihKgBcHjzWKK63y0
         nFdsEcoAmRtKZbjGf1go9jexoYDGxgJvFq3y5yGj124wnesy6QH0K2Nougo1syTvgIFZ
         wQhfWP5V5D6jxR/8zuGQU6+Ll1dFQKWq5w65Z1wKq/f8k39Lee6bLSFd6pTyRUiQ1+by
         rTeQ==
X-Gm-Message-State: AOJu0YyhSjXHj9IIFmRX/O7NrjUf5P4uucSHeZZyhZIQ7XOMKgcZJ7kO
	sX3jj8awGS02v5guPTXPoXXgVz9bZZFRb/lz/AaCvmWvHJOOT4HkF7OBb/I61oGz8H3yrOkjPsz
	GeCruULecY+/Kzgd/s4ct1c2iIbDvC7DDWSS7OLT9Ptaom62/Jq4mQgW3ATplHc20No6cNw1+e9
	qKCQzYch7aYE6bI/AFlkyZAer9040aulzmLyXgsj0pzbf+vFHSYQ==
X-Google-Smtp-Source: AGHT+IGDZ/gyBNCdLlDRoTyIGm/ix19v7rOtSFV/9OZJOyCecR5FgOvBSMB6wv2vOTn1EasUZVHOXWEP/W70
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:b27f:9766:7459:4899])
 (user=apusaka job=sendgmr) by 2002:a05:6902:e09:b0:dc2:550b:a4f4 with SMTP id
 df9-20020a0569020e0900b00dc2550ba4f4mr520080ybb.1.1706251357244; Thu, 25 Jan
 2024 22:42:37 -0800 (PST)
Date: Fri, 26 Jan 2024 14:41:21 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240126144120.Bluez.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
Subject: [Bluez PATCH] Monitor: Remove handle before assigning
From: Archie Pusaka <apusaka@google.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>
Cc: CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>, 
	Archie Pusaka <apusaka@chromium.org>, Zhengping Jiang <jiangzp@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Archie Pusaka <apusaka@chromium.org>

It is possible to have some handles not removed, for example the host
may decide not to wait for disconnection complete event when it is
suspending. In this case, when the peer device reconnected, we might
have two of the same handle assigned and create problem down the road.

This patch solves the issue by always removing any previous handles
when assigning a new handle if they are the same.

Reviewed-by: Zhengping Jiang <jiangzp@google.com>

---

 monitor/packet.c | 50 +++++++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 24 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 42e711cafa..b5dea6384a 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -189,11 +189,33 @@ static struct packet_conn_data *lookup_parent(uint16_t handle)
 	return NULL;
 }
 
+static void release_handle(uint16_t handle)
+{
+	int i;
+
+	for (i = 0; i < MAX_CONN; i++) {
+		struct packet_conn_data *conn = &conn_list[i];
+
+		if (conn->handle == handle) {
+			if (conn->destroy)
+				conn->destroy(conn->data);
+
+			queue_destroy(conn->tx_q, free);
+			queue_destroy(conn->chan_q, free);
+			memset(conn, 0, sizeof(*conn));
+			conn->handle = 0xffff;
+			break;
+		}
+	}
+}
+
 static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 					uint8_t *dst, uint8_t dst_type)
 {
 	int i;
 
+	release_handle(handle);
+
 	for (i = 0; i < MAX_CONN; i++) {
 		if (conn_list[i].handle == 0xffff) {
 			hci_devba(index, (bdaddr_t *)conn_list[i].src);
@@ -225,26 +247,6 @@ static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
 	}
 }
 
-static void release_handle(uint16_t handle)
-{
-	int i;
-
-	for (i = 0; i < MAX_CONN; i++) {
-		struct packet_conn_data *conn = &conn_list[i];
-
-		if (conn->handle == handle) {
-			if (conn->destroy)
-				conn->destroy(conn->data);
-
-			queue_destroy(conn->tx_q, free);
-			queue_destroy(conn->chan_q, free);
-			memset(conn, 0, sizeof(*conn));
-			conn->handle = 0xffff;
-			break;
-		}
-	}
-}
-
 struct packet_conn_data *packet_get_conn_data(uint16_t handle)
 {
 	int i;
@@ -10076,7 +10078,7 @@ static void conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_bdaddr(evt->bdaddr);
 	print_link_type(evt->link_type);
 	print_enable("Encryption", evt->encr_mode);
@@ -10648,7 +10650,7 @@ static void sync_conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_sync_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_bdaddr(evt->bdaddr);
 	print_link_type(evt->link_type);
 	print_field("Transmission interval: 0x%2.2x", evt->tx_interval);
@@ -11077,7 +11079,7 @@ static void le_conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_role(evt->role);
 	print_peer_addr_type("Peer address type", evt->peer_addr_type);
 	print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
@@ -11206,7 +11208,7 @@ static void le_enhanced_conn_complete_evt(struct timeval *tv, uint16_t index,
 	const struct bt_hci_evt_le_enhanced_conn_complete *evt = data;
 
 	print_status(evt->status);
-	print_handle(evt->handle);
+	print_field("Handle: %d", le16_to_cpu(evt->handle));
 	print_role(evt->role);
 	print_peer_addr_type("Peer address type", evt->peer_addr_type);
 	print_addr("Peer address", evt->peer_addr, evt->peer_addr_type);
-- 
2.43.0.429.g432eaa2c6b-goog

