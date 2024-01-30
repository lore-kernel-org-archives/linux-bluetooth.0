Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF8A60DC9
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706610329; cv=none; b=Ovn/W6RJqgcwns3PqW604odn+LrZIx5FxiOV53AYkyATxfYED3APo0ncBmyYvBqwAoXwufVQT14OSlR8xP19rRSVMwGOvBFrzgy/zsddgO2NCOPMI6Kx0ala/wRBaEYyAV2Usw1+HHANDmpuFy1i+um4QaIkwvLJRwA0xNUnlgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706610329; c=relaxed/simple;
	bh=jjXmPztiKxLEZlVKgA8booWJDOPlrpHDWajOKvKblsY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qc5lxMp99eMGjSz95GHuVWLgZMKhiv+unDLlKxU0J6/acnO2BqM38IYSD+utkpCQ534RAIjtt3gE7pEt2UvqaH1el9PRzNBuEnk4xtAL4yRwid7d0U8tIV9oX/60TaXUoU8wchJLyJQHmF3WU/A4hJiXAEBtQqHFjHwXdc1P5sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IO418wDV; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--apusaka.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IO418wDV"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5fffb2798bfso63838697b3.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 02:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706610327; x=1707215127; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z5aYxWZ/Gi+TpsFow2E8Zho0jfBd+6KmqtWyoKQ+m4o=;
        b=IO418wDVmijnPaxl+SNNSXzTHVKtSK6iO2xbBjcepdrd4UUy0tPwtX3Yp5rhhP9V80
         len34iv/i5KyxZJ0JAQyGYGbmdt+muUO82ypJjAZeam7fn0p/1E1Z7ttOUcbanBiQBjz
         2bO1FeFxQQShhxhblxHP0QBkKmSps5QALmXisj98ooPSWP0+7CWZDYJ655zx5r9VmA1M
         kvW4NImRkQeB9P5RDGhFUGBqD9tjmkgLK2o3jE701HcUtHV0SPxTMoTrrC63loey79OA
         LOogc2PurqIrMwTYxs3///2fURv7Q0fs8r84xVUU/UkjlrYYWKBg/61eclKdiYgEX1D2
         Tspw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706610327; x=1707215127;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5aYxWZ/Gi+TpsFow2E8Zho0jfBd+6KmqtWyoKQ+m4o=;
        b=uX3oLFW3N6Mf1gIFwdR/f9bxsuePUI6uwX2UrSbcZGhlHAPa9DyCFhgNxsGW7LYOPY
         ODYGBKanyi+CWOvf6IuAVvPBqXafq1P6B4l3otC0pEA5Ba+zM4AME5Fw00DvB/IYoFzj
         C+mBFU4lF+PuhuEVJ9K9UAFwlCE5SCgGuSaIm7Dtoyl0Q9aO3BoUvDlZckEIw8Io2HSq
         ATILQv5yvNPdFtWzrCLbHKpWlC8cq76lxfeP8KkCQZ9kd160FAVT6jsNZAxY23UieMWK
         OopG96CzdgEGOnJ7wxQx6v1AT6H4wDvy+LAAlv1epqYybD6z7NB9L84iMfDmEuNB8kba
         zHNA==
X-Gm-Message-State: AOJu0YzF3SgyfnHN2n+m7+W/clVgdNulf7ehsm2odRYSu0E79rbWK9l4
	gh6OIx3bb75e188XjpQd47H9PCKPNpnQR8D4+/Pl9kwQwNKz1Uo8p3Y89EaRiuihxzAdkrc0m4D
	mbYob3NUCj7YBjBYf3C20jq6w46FIsuRo/9zR+dwLryR2EEk18CpnbX/Ud00jbUBAcEQX3MISd3
	1alX+5CAi6lV/LvQH70jDkTUCxnph10pTdclcU3i8DDoAGUwG+mQ==
X-Google-Smtp-Source: AGHT+IFXAVrE0rQ0Myo1uKPbcvJCZfgjoYasPEc+Qugo3IIIhYv0PC+RBfCCASHDpm8LZf5D/OVsqIbVxMy4
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:683d:ac9b:1d63:b3ff])
 (user=apusaka job=sendgmr) by 2002:a05:6902:2611:b0:dc2:4ab7:3d89 with SMTP
 id dw17-20020a056902261100b00dc24ab73d89mr2899354ybb.1.1706610326688; Tue, 30
 Jan 2024 02:25:26 -0800 (PST)
Date: Tue, 30 Jan 2024 18:24:59 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240130182459.Bluez.v2.1.If74ccbca4d541c5f576765a3a78cb8923b5f85b1@changeid>
Subject: [Bluez PATCH v2 1/2] Monitor: Remove handle before assigning
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
have two of the some handle assigned and create problem down the road.

This patch solves the issue by always removing any previous handles
when assigning a new handle if they are the same.

Reviewed-by: Zhengping Jiang <jiangzp@google.com>

---

Changes in v2:
* Return connection pointer when removing handle

 monitor/packet.c | 79 ++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 36 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index 42e711cafa..164cc82bb2 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -189,59 +189,66 @@ static struct packet_conn_data *lookup_parent(uint16_t handle)
 	return NULL;
 }
 
-static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
-					uint8_t *dst, uint8_t dst_type)
+static struct packet_conn_data *release_handle(uint16_t handle)
 {
 	int i;
 
 	for (i = 0; i < MAX_CONN; i++) {
-		if (conn_list[i].handle == 0xffff) {
-			hci_devba(index, (bdaddr_t *)conn_list[i].src);
+		struct packet_conn_data *conn = &conn_list[i];
+
+		if (conn->handle == handle) {
+			if (conn->destroy)
+				conn->destroy(conn->data);
 
-			conn_list[i].index = index;
-			conn_list[i].handle = handle;
-			conn_list[i].type = type;
+			queue_destroy(conn->tx_q, free);
+			queue_destroy(conn->chan_q, free);
+			memset(conn, 0, sizeof(*conn));
+			conn->handle = 0xffff;
+			return conn;
+		}
+	}
 
-			if (!dst) {
-				struct packet_conn_data *p;
+	return NULL;
+}
 
-				/* If destination is not set attempt to use the
-				 * parent one if that exists.
-				 */
-				p = lookup_parent(handle);
-				if (p) {
-					memcpy(conn_list[i].dst, p->dst,
-						sizeof(conn_list[i].dst));
-					conn_list[i].dst_type = p->dst_type;
-				}
+static void assign_handle(uint16_t index, uint16_t handle, uint8_t type,
+					uint8_t *dst, uint8_t dst_type)
+{
+	struct packet_conn_data *conn = release_handle(handle);
+	int i;
 
+	if (!conn) {
+		for (i = 0; i < MAX_CONN; i++) {
+			if (conn_list[i].handle == 0xffff) {
+				conn = &conn_list[i];
 				break;
 			}
-
-			memcpy(conn_list[i].dst, dst, sizeof(conn_list[i].dst));
-			conn_list[i].dst_type = dst_type;
-			break;
 		}
 	}
-}
 
-static void release_handle(uint16_t handle)
-{
-	int i;
+	if (!conn)
+		return;
 
-	for (i = 0; i < MAX_CONN; i++) {
-		struct packet_conn_data *conn = &conn_list[i];
+	hci_devba(index, (bdaddr_t *)conn->src);
 
-		if (conn->handle == handle) {
-			if (conn->destroy)
-				conn->destroy(conn->data);
+	conn->index = index;
+	conn->handle = handle;
+	conn->type = type;
 
-			queue_destroy(conn->tx_q, free);
-			queue_destroy(conn->chan_q, free);
-			memset(conn, 0, sizeof(*conn));
-			conn->handle = 0xffff;
-			break;
+	if (!dst) {
+		struct packet_conn_data *p;
+
+		/* If destination is not set attempt to use the parent one if
+		 * that exists.
+		 */
+		p = lookup_parent(handle);
+		if (p) {
+			memcpy(conn->dst, p->dst, sizeof(conn->dst));
+			conn->dst_type = p->dst_type;
 		}
+	} else {
+		memcpy(conn->dst, dst, sizeof(conn->dst));
+		conn->dst_type = dst_type;
 	}
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog

