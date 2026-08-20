Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A19D43BDC0
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787230695; cv=none; b=OueVsyufnzfrSdpwowNbix2o3RVRsy2mIp2psgdl4DXhNxYu8qrYajlJI1pd+mAfW42+WzJc0jB3LBDfwkOygUqkDoPZ1sKv6n/HSrcUXlpav5oTQuzVnk78dnNZc/bjHRWQwOWCW5vv3BnBkr724vI0VSWIKfp4C1GHCVgyyyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787230695; c=relaxed/simple;
	bh=IFTb+qDtD73CbuS+NFu459MmFhUFwvVIjKeNCnaSNUE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ba+IOPYFPC235HCJixd0cyb3eeV33429k1aaWZae2AsrtgNaeSbnyC9LjtMl06C7XD4KLWtvjo7jrt14Nc5kKRrEzDKGQLEF0DnMwC7/2G7X+hLu6ENF+qtm1AglmxhQLHbKkFE7i7wewpHL/s0ATO4bQXsr4Hf+T1cZIPQvICc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=KlWR9jcn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="KlWR9jcn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787230692;
	bh=IFTb+qDtD73CbuS+NFu459MmFhUFwvVIjKeNCnaSNUE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KlWR9jcnV8XcIOq6ewDOmE5oEH8PFpJA6H1z7O49DDwI+QGViHK6wz47RH7mBt35X
	 tqaCcGlItDdlO+ZAM1iO5NkCqk3UyawG9ARpMr+bQADHg5G8Cevb5OsOaNkK5Bj6K8
	 PGPwZW6mUi4cJKsbnSsePSIFxEUg7LUOyXpfKcKtpvZVB749EKkW/13lNMkRCZ2rp+
	 4SBFa1yBKteIeoZiHcIIp1f8KFMu75tCYpRwN17KY7fB0MFy5cVumMsd+R2tqAeess
	 YXrvKRcNNC65MpKb6hvAES0tjiMYjOiTYTWCCnZyKO+s9OQ/cafPkucUpnBJ4U+ckH
	 04uJPLV2SqAFg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2A38D17E0860
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 14:58:12 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/6] mgmt: Add Security Level Changed event
Date: Thu, 20 Aug 2026 14:58:01 +0200
Message-ID: <20260820125806.1253547-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820125806.1253547-1-frederic.danis@collabora.com>
References: <20260820125806.1253547-1-frederic.danis@collabora.com>
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
v1->v2: Fix struct mgmt_ev_security_level_changed definition

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
index 9df0c1ba2..7b98ff8a9 100644
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
+	uint8_t	tlv_data[];
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

