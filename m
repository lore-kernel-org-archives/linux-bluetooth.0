Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12A64D4862
	for <linux-bluetooth@vger.kernel.org>; Thu,  8 Oct 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791472389; cv=none; b=mRA+4iWDqb8M7smytQ6ljJsb0UACt6fk3nW5Uc7QBvfbYsYkSZHQH1WYUmg7hliQhvQbhUnJjMI0tSkM6yUgmGniIpzAteE4j10XZXBffmQ7gw1DGCPh4ZRQkUFUOX2ejHcbFotMmVYWEDeb9v9fjtv9E160Dj/luphdyUiVCfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791472389; c=relaxed/simple;
	bh=P2AJlJENPvJS7GPy0iCZJp6A75CwIyadtSbULF4M3cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y34JvqV4wMqRFKW8UGoodRZZqIRRkp1upw4c9W9a4RV5Fa70HGvUh9eQ3pvra5UkyghJT2tZ2BQo70tDI99hH/KCtsjiTFtgQqjMottgEpxFvReStIfLUHaZt79sbIV2k0+gvEeqRwU2ARV0C0RJ0s0e0y1xXHsAU852IBbDqBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jEeOmqEn; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEeOmqEn"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-3530a44737cso61362eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 08 Oct 2026 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791472382; x=1792077182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j9ooXR6Y09KtjeY/pkwXIKyVeGH6jcslX5LxHatrik0=;
        b=jEeOmqEnN/JyLxeHItlA7pKIBfTZC4nhEYWFxUnIoVuZh7IgpKdb18E+N7Q1iM4YAa
         UolFITi7Me7iiVye8C9xd6tDzvMvmE2zw8O5A3a7tZ/VPpMfNBrRKB9FCTto70KS6JB1
         c4Mu/OCS+ocD7GX3DBWvAkVYixQQPefGZGKbbITWVtMj4yTq51VDIqqqOgM/U73MKMI9
         1+UUY3Gfy/yJ7W7+g5sBrZiu7AtTWj8FUEG9rTCZXk4LtFPjImDWwTxqPozbMSCMn83a
         DeizJZsQ9vGgA1ylYZZYgJ6+nNh+WXff/NR9xmDe8N4PGLrs0YW/3OHRFh1Y23b2mdE8
         RYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791472382; x=1792077182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j9ooXR6Y09KtjeY/pkwXIKyVeGH6jcslX5LxHatrik0=;
        b=DhkQSLFfUMVzUfRHU1fz5NjolX9fqhrJXauXMoQR3+lLqOnFelUOnCxlNHx1GM7qqS
         W/Ij3AQMrx2i2VYZAJf0MBU3YeBC7oSFVpmPogNumy9ySG9j0YJy3EqdAhymqJAjSww0
         zL/l8Qi/tRv8fpuRM7ZGSv7eVRlk7b0xmaRN+TbcR8ukV6Itr0UeK5wuNW+Ksbew2iM2
         +xToFngYni+Me3VDgefbYBe3F39dQLWtgu0LcHhCcSSG1B20z1bSUGlbnDHDeIGSTI00
         3WfNciCKkPXzUksamM58nF04TbhHaQ83LPF+j8zh6rqQrT6B8TV1VQ6baA1599XeJEZK
         oAFQ==
X-Gm-Message-State: AFq9FYKtoppXKGm1MddbtR1rJTZH5Z0GpVr8YuHiiAYUT10ZBR2gPon1
	QvoB9ACfsXXa6VGlV8P/EYB4Y/MQJCrFXqfkFA6vThYRryIHeoLxXIwsgnXyuzIFkb4=
X-Gm-Gg: AYBFou2G9YBh9SyMoXVCsd8V0wqWmB41+g5XiXjSY1yxigs6VBDsya4WkJlhKvGyx1/
	VUGzR9rgZVC6LV4qHloPxVtF0KM5CXjRwGXVCGteV0cEnR2uftnMBI/1ttNwo2TQrcVTdBRbNp3
	a8cTBFNjtEuc7Pv5wAxCdUTMsVJRvFutFEIroEjkr0LjojoeQRFmgXPXyNIPaKlOq4wC/UPy//A
	Ed4vgDZlQmg8LZe/pl//uLnh3PBKQIuzCLQ32gAVLM6klu6jrEOLjJa5wDQlXxRFLhInnWDbqNF
	bdWJIj58+pwATMtYX5oLQB5i94Pjodehn7yPuv6l4Wp7FThebBuVfEYjGR6/9AtsMR+GnqHBeO2
	Kk3050HVwmPqTCxK8Iz11MKV1X7X6leuEpErr5ayF4c2mL275w1KZN8Tb7qoQw65LZsj93oy/Sp
	QWQn5+L+iyoVf04HqecXOgObYrmux2T9sGZHoWFf5KfDiQ4+/htOgSgri9d9pjkGBEqB+YmUcoL
	EOPZPHDGauX39DXv+XBnyExq1nMF/88boC/DbDJ2tUFsxaNilI=
X-Received: by 2002:a05:7301:7307:b0:351:7e15:9c59 with SMTP id 5a478bee46e88-3517e15a574mr3527620eec.0.1791472376732;
        Thu, 08 Oct 2026 08:12:56 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515afd00e0sm18052389eec.23.2026.10.08.08.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 08:12:56 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH v2 3/6] Bluetooth: hci_event: Disconnect links that complete while being aborted
Date: Thu,  8 Oct 2026 11:12:35 -0400
Message-ID: <20261008151238.2138665-4-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008151238.2138665-1-enghitalo@gmail.com>
References: <20261008151238.2138665-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 16e3b6429159 ("Bluetooth: hci_conn: Fix modifying handle
while aborting"), and for LE since commit 181a42edddf5 ("Bluetooth: Make
handle of hci_conn be unique"), a connection that is being aborted
refuses the handle of its link when the link completes before the
connection is deleted, e.g. while the abort waits for its cancel
command. The link is up in the controller, though, and nothing
disconnects it: the event handler fails the connection or leaves it to
the abort, and the abort cancels the connect attempt and finds no handle
to disconnect. The handle then stays in use in the controller, e.g. a
SCO link left this way makes the controller reject every later setup
for the device until the ACL drops.

Disconnect the link when its connection refuses the handle, on
Connection Complete, Synchronous Connection Complete and LE (Enhanced)
Connection Complete, with the reason the connection was aborted for.
This is not done in hci_conn_set_handle() itself, as its other callers
set the handles of links that are not up yet.

Fixes: 16e3b6429159 ("Bluetooth: hci_conn: Fix modifying handle while aborting")
Fixes: 181a42edddf5 ("Bluetooth: Make handle of hci_conn be unique")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_event.c | 41 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cbe53e19e..1f9b47389 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3217,6 +3217,39 @@ static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
 	return hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
 }
 
+/* Disconnects a link that came up in the controller but that no connection
+ * takes: nothing else would, and its handle would stay in use there.
+ */
+static void hci_disconnect_unused(struct hci_dev *hdev, u16 handle, u8 reason)
+{
+	struct hci_cp_disconnect cp;
+
+	/* Never for an invalid handle or one that a connection uses */
+	if (handle > HCI_CONN_HANDLE_MAX ||
+	    hci_conn_hash_lookup_handle(hdev, handle))
+		return;
+
+	bt_dev_dbg(hdev, "handle 0x%4.4x reason 0x%2.2x", handle, reason);
+
+	cp.handle = cpu_to_le16(handle);
+	cp.reason = reason;
+	hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
+}
+
+/* Sets the handle of a connection whose link came up. A connection that is
+ * being aborted refuses it, so its link is disconnected: the abort only
+ * cancels the connect attempt, and finds no handle to disconnect.
+ */
+static u8 hci_conn_complete_set_handle(struct hci_conn *conn, u16 handle)
+{
+	u8 status = hci_conn_set_handle(conn, handle);
+
+	if (status && conn->abort_reason)
+		hci_disconnect_unused(conn->hdev, handle, conn->abort_reason);
+
+	return status;
+}
+
 static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
@@ -3292,7 +3325,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!status) {
-		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
+		status = hci_conn_complete_set_handle(conn,
+						      __le16_to_cpu(ev->handle));
 		if (status)
 			goto done;
 
@@ -5208,7 +5242,8 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	switch (status) {
 	case 0x00:
-		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
+		status = hci_conn_complete_set_handle(conn,
+						      __le16_to_cpu(ev->handle));
 		if (status) {
 			conn->state = BT_CLOSED;
 			break;
@@ -5974,7 +6009,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	 * hci_conn_failed function which is triggered by the HCI
 	 * request completion callbacks used for connecting.
 	 */
-	if (status || hci_conn_set_handle(conn, handle))
+	if (status || hci_conn_complete_set_handle(conn, handle))
 		goto unlock;
 
 	/* Drop the connection if it has been aborted */
-- 
2.55.0

