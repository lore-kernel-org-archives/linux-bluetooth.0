Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49E74189B9
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223164; cv=none; b=IHEsbU48oPYpzk5cTI4VRtp92rfC0CL7fFy2fNVuDgymd9+u/riD8SA8EznaIHez4xrIECOysct9lat78QhlSwh5UUncLBBy1lSlhm68w40SMGhhqQDRhGGKl4zLfu7Of+SRl9E1FFBEjhrJMvAuErn3nsFZOLPlY20n0BVouV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223164; c=relaxed/simple;
	bh=5ljN+nka6ubQQRmPq0JJmdxq6Kb4CCTbWGL+vkz1Jeo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LoOv1onXTZt4l0HScZ90WVTw+Nygc0hQcyeyIAKciyqVh3iOhCTWXMzPbIwWF/QicFrlniFne4Tfyzlf2Shreg63s/TCLpENtJyM4HfBop6otgW0Buv8eveOR+ePclFpQfsOqQdYdRRV5fzx57TYF06peTJfvv/ao+Xiar1xupQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nKBoV6eQ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nKBoV6eQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787223161;
	bh=5ljN+nka6ubQQRmPq0JJmdxq6Kb4CCTbWGL+vkz1Jeo=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=nKBoV6eQTw53RT9wu8bksNR3QnjXZMbSgXT4VvaMDOp3AnBz3sujXCS4l26Q+NOSF
	 MEqdUR9c4F2theryNqBETxRHPHsL6COmR7ZjH7f0TBJ8ismd01BSy9JgLsqEPzjOAm
	 WxWm49FJLpJXBCKqSJIBEJB9Pj8zvm17IqoKadzUZ8vNQPEYY6bBBe2b8sorfSD1UY
	 3IwNNb7+8H0b2NYcPzQvbV20H1z9Aay5655JanmrTeNqIG0kC/wUqnxs9+fglGYjZv
	 NZQCk1w+QAM0LS39q9wdIPgH6SXqZkYldmnhJC8Z7aMkYPDrakUuzL2HtfafpDuqu3
	 b3z/geAjzQSJg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 30E9617E0870
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:52:41 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] mgmt: Add Security Level Changed event
Date: Thu, 20 Aug 2026 12:52:29 +0200
Message-ID: <20260820105235.1190318-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820105235.1190318-1-frederic.danis@collabora.com>
References: <20260820105235.1190318-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This provides a TLV list of values related to the security level of
the connection to a remote device.

Currently Security Level and Encryption type are implemented.
---
 doc/mgmt-protocol.rst | 45 +++++++++++++++++++++++++++++++++++++++++++
 lib/bluetooth/mgmt.h  | 15 +++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index f0564075f..1693ff677 100644
--- a/doc/mgmt-protocol.rst
+++ b/doc/mgmt-protocol.rst
@@ -5521,3 +5521,48 @@ The Supervision_Timeout parameter specifies the supervision timeout in units
 of 10 ms.
 
 This event will be sent to all management sockets.
+
+Security Level Changed
+``````````````````````
+
+:Event Code:		0x0034
+:Controller Index:	<controller_id>
+:Event Parameters:	Address (6 Octets)
+:...:			Address_Type (1 Octet)
+:...:			Count (1 Octet)
+:...:			TLV_List (variable)
+
+This event indicates that the security level of a device has changed.
+
+Possible values for the TLV type parameter:
+
+.. csv-table::
+	:header: "Type", "Description"
+	:widths: auto
+
+	0x0000, Security Level
+	0x0001, Encryption type
+
+Possible values for the Security Level type:
+
+.. csv-table::
+	:header: "Value", "Description"
+	:widths: auto
+
+	0x00, No security
+	0x01, Unauthenticated pairing with encryption not required
+	0x02, Unauthenticated pairing with encryption desired
+	0x03, Authenticated pairing with encryption
+	0x04, FIPS authenticated pairing with encryption
+
+Possible values for the Encryption type:
+
+.. csv-table::
+	:header: "Value", "Description"
+	:widths: auto
+
+	0x00, No encryption
+	0x01, E0 encryption
+	0x02, AES-CCM encryption
+
+This event will be sent to all management sockets.
diff --git a/lib/bluetooth/mgmt.h b/lib/bluetooth/mgmt.h
index 9df0c1ba2..6e0494757 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1136,6 +1136,20 @@ struct mgmt_ev_conn_subrate {
 	uint16_t supv_timeout;
 } __packed;
 
+#define MGMT_CONN_SEC_ENCRYPT_NONE		0x00
+#define MGMT_CONN_SEC_ENCRYPT_E0		0x01
+#define MGMT_CONN_SEC_ENCRYPT_AES_CCM		0x02
+
+#define MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL	0x0000
+#define MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE	0x0001
+
+#define MGMT_EV_SECURITY_LEVEL_CHANGED		0x0034
+struct mgmt_ev_security_level_changed {
+	struct mgmt_addr_info addr;
+	uint8_t	tlv_count;
+	uint8_t	tlv_data[] __counted_by(tlv_count);
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1285,6 +1299,7 @@ static const char *mgmt_ev[] = {
 	"Mesh Packet Found",
 	"Mesh Packet Complete",
 	"Connection Subrate",
+	"Security Level Changed",
 };
 
 static const char *mgmt_status[] = {
-- 
2.43.0

