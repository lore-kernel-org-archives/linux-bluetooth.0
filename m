Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC443DEB7
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790677207; cv=none; b=YIVHzB3SzDtq6iSSZCZoy0g01fRx31nJOPLZWXMlt6a0fCDvOyEpxzEq+WjZxLeLYtyap4B3q/9q5gdqNIfxC7HH3SnjoQkcWxKO+e3uuUweOZgeD3NpMSPMxCPxxNbyCviQHIVkQIsUJ/wgw0Pw9IY3p65UmYsiSdK5i1AXSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790677207; c=relaxed/simple;
	bh=VkJec4D+9C3+q5oJxyeL81DapCqzfWstdZQnmOEmZtA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=scv+QI6RcFMUAQROY9htwlyCvpURB2oMKj6PUw9qDD4BF0AiUhNv7o06fNGpKV8DwKtgBcoYgqbqUXaIAzHTtHbfGxzNQDXWoH68vDbZktGRmR92CaHF8dWXJxrPDJvPVnDiOxo1KDshz/Ty2GO1RoeQALVsg0a/M8RK+afQHs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BSMy7dUi; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BSMy7dUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790677200;
	bh=VkJec4D+9C3+q5oJxyeL81DapCqzfWstdZQnmOEmZtA=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=BSMy7dUi5Irxi3ZID1rfhjsUeNxzIck73yFMqbWZ513m83/n3lNO2PghG071ZbY/V
	 dWVNSXIg5yZ9RGReSuqIKukj9vohb8P4KjKvs0Qv3db4426W3kvBIgiW/DvEy9YEa7
	 2otx8nyNlbp8h7WIuG6bQzZEHtBR1T+WMMq3eBYb4IjZxTq3oGMgsSFOC3MWgZCCJF
	 Lr98LH8whV7oeqGDOsPhj15I9TU7rha6Mu5K/YA6nIuwdLyXRclDTUL28gpVtj0UU6
	 xcthU0Pax+dO35J0v4IlqD+cZsBzNc4npf5DmLnfn8FqC9krALngdpatb7Q94Kz+za
	 WFlxGY/CmpE3g==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 55BEC17E0803
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:20:00 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 1/6] mgmt: Add Security Level Changed event
Date: Tue, 29 Sep 2026 12:19:48 +0200
Message-ID: <20260929101953.254969-2-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929101953.254969-1-frederic.danis@collabora.com>
References: <20260929101953.254969-1-frederic.danis@collabora.com>
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
v2->v3: Re-work Security Level possible values in mgmt-protocol.rst to be in
        with other *-protocol.rst files
v3->v4: Following changes in kernel patch, replace tlv_count by tlv_length

 doc/mgmt-protocol.rst | 45 +++++++++++++++++++++++++++++++++++++++++++
 lib/bluetooth/mgmt.h  | 15 +++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/doc/mgmt-protocol.rst b/doc/mgmt-protocol.rst
index f0564075f..f4c6822bf 100644
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
+:...:			TLV_Length (1 Octet)
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
+	:header: "Value", "Security Level", "Link Key Type", "Encryption"
+	:widths: auto
+
+	**BT_SECURITY_SDP**, 0 (SDP Only), None, Not required
+	**BT_SECURITY_LOW**, 1 (Low), Unauthenticated, Not required
+	**BT_SECURITY_MEDIUM**, 2 (Medium - default), Unauthenticated, Desired
+	**BT_SECURITY_HIGH**, 3 (High), Authenticated, Required
+	**BT_SECURITY_FIPS** (since Linux 3.15), 4 (Secure Only), Authenticated (P-256 based Secure Simple Pairing and Secure Authentication), Required
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
index 098be2074..af71be828 100644
--- a/lib/bluetooth/mgmt.h
+++ b/lib/bluetooth/mgmt.h
@@ -1142,6 +1142,20 @@ struct mgmt_ev_conn_subrate {
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
+	uint8_t	tlv_length;
+	uint8_t	tlv_data[];
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1291,6 +1305,7 @@ static const char *mgmt_ev[] = {
 	"Mesh Packet Found",
 	"Mesh Packet Complete",
 	"Connection Subrate",
+	"Security Level Changed",
 };
 
 static const char *mgmt_status[] = {
-- 
2.43.0

