Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F246346AECF
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 09:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787303381; cv=none; b=Vd8HUY+12sRKYv2pl0W+6lz+ao/k070BnLh/zr3lmIAJefKA8u3saNTBB7aaJSOQvyf4SEd3yhhulM/2PHybEO0QgQD76HfZkvB1wpDWnlS1jAxNbgYq/U+qtF5kDlvtm6v44mz/REXjIvHiBV/yeBBXkB4pqHWycvUU6doJRjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787303381; c=relaxed/simple;
	bh=6/qcLggBB0dkRlFyHz2dMAeRCm4AXzVADm3ZnQbF7a8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u3I+RY+kr5vXlF0N0wXZTpXrh1cxFworcBvUeykUOVvg9ouD8Z3wKOLHaZAXKwhvyIVl+S3CEPMzwittfzvkDroC6kIQEvjARyBVxfvkrrBY5xY7KZHhshSyG1FVq7TZ8H3D2cX5dDEl9FjcL0DjH9dogz3dMvE00s1qt+qC6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FcCCb63N; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FcCCb63N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787303353;
	bh=6/qcLggBB0dkRlFyHz2dMAeRCm4AXzVADm3ZnQbF7a8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=FcCCb63N9ObQ4ZBQoQ2zh8Z4v4KnZ9bgrBXcHiaF+zPvT0CMkiDehbRRFCsBh2KWb
	 dT66t1x3rVlB87hdvpz+Y4txfdyiE3fGUdcQgQUkps/xNJ/cWtwHGMvP78WFB3rPL/
	 JIKO3PJK2s/eRiOW3nDTHoGG6foftNAigZczQnibQChG5wN5lRW+o76zTAc5p2QBV4
	 5SWkZvG/C52EfgJbOUTGryacLJPahvU28pHd0/WmENFlEbLE2kUOB9E19Y2OoRHQyP
	 U4IEkvyDDuxgJ6aCpr6o3hyHN1/7gyuRibjIJi7gus+YDunlTJf8/J3n7r2B8kDFt2
	 MJj31GiGL6G/w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C7C8A17E0C8D
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 11:09:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/6] monitor: Add support for Mgmt Security Level changed event
Date: Fri, 21 Aug 2026 11:09:05 +0200
Message-ID: <20260821090908.1546451-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821090908.1546451-1-frederic.danis@collabora.com>
References: <20260821090908.1546451-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

@ MGMT Event: Security Level Changed (0x0034) plen 16
        BR/EDR Address: 00:AA:01:01:00:00 (Intel Corporation)
        Count: 2
        Security Level: No security (0x00000000)
        Encryption Type: No encryption (0x00000000)
---
 monitor/packet.c | 117 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/monitor/packet.c b/monitor/packet.c
index 0d3b23cc3..217fcdad1 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -17680,6 +17680,121 @@ static void mgmt_conn_subrate_evt(const void *data, uint16_t size)
 	print_field("Supervision timeout: %u", supv_timeout);
 }
 
+static void mgmt_print_security_level(const char *desc, uint32_t value)
+{
+	const char *level;
+
+	switch (value) {
+	case BT_SECURITY_SDP:
+		level = "No security";
+		break;
+	case BT_SECURITY_LOW:
+		level = "Unauthenticated pairing with encryption not required";
+		break;
+	case BT_SECURITY_MEDIUM:
+		level = "Unauthenticated pairing with encryption desired";
+		break;
+	case BT_SECURITY_HIGH:
+		level = "Authenticated pairing with encryption";
+		break;
+	case BT_SECURITY_FIPS:
+		level = "FIPS authenticated pairing with encryption";
+		break;
+	default:
+		level = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%8.8x)", desc, level, value);
+}
+
+static void mgmt_print_encryption_type(const char *desc, uint32_t value)
+{
+	const char *type;
+
+	switch (value) {
+	case MGMT_CONN_SEC_ENCRYPT_NONE:
+		type = "No encryption";
+		break;
+	case MGMT_CONN_SEC_ENCRYPT_E0:
+		type = "E0";
+		break;
+	case MGMT_CONN_SEC_ENCRYPT_AES_CCM:
+		type = "AES-CCM";
+		break;
+	default:
+		type = "Reserved";
+		break;
+	}
+
+	print_field("%s: %s (0x%8.8x)", desc, type, value);
+}
+
+static void mgmt_print_sec_level_tlv(void *data, void *user_data)
+{
+	const struct mgmt_tlv *entry = data;
+	uint16_t type = get_le16(&entry->type);
+	const char *desc = default_system_config(type);
+	uint32_t value;
+	char buf[8];
+
+	switch (type) {
+	case MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL:
+		desc = "Security Level";
+		break;
+	case MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE:
+		desc = "Encryption Type";
+		break;
+	default:
+		snprintf(buf, sizeof(buf), "0x%4.4x", entry->type);
+		desc = buf;
+		break;
+	}
+
+	if (entry->length == 1 || entry->length == 2 || entry->length == 4) {
+		if (entry->length == 1)
+			value = get_u8(entry->value);
+		else if (entry->length == 2)
+			value = get_le16(entry->value);
+		else
+			value = get_le32(entry->value);
+
+		switch (type) {
+		case MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL:
+			mgmt_print_security_level(desc, value);
+			break;
+		case MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE:
+			mgmt_print_encryption_type(desc, value);
+			break;
+		default:
+			print_field("%s: %u", desc, value);
+			break;
+		}
+	} else {
+		print_hex_field(desc, entry->value, entry->length);
+	}
+}
+
+static void mgmt_security_level_changed_evt(const void *data, uint16_t size)
+{
+	const uint8_t *addr = data;
+	uint8_t addr_type = get_u8(data + 6);
+	uint8_t count = get_u8(data + 7);
+	struct mgmt_tlv_list *tlv_list;
+
+	mgmt_print_address(addr, addr_type);
+	print_field("Count: %d", count);
+
+	tlv_list = mgmt_tlv_list_load_from_buf(data + 8, size - 8);
+	if (!tlv_list) {
+		print_text(COLOR_ERROR, "  Unable to parse security level "
+					"changed event");
+		return;
+	}
+	mgmt_tlv_list_foreach(tlv_list, mgmt_print_sec_level_tlv, NULL);
+	mgmt_tlv_list_free(tlv_list);
+}
+
 static const struct mgmt_data mgmt_event_table[] = {
 	{ 0x0001, "Command Complete",
 			mgmt_command_complete_evt, 3, false },
@@ -17779,6 +17894,8 @@ static const struct mgmt_data mgmt_event_table[] = {
 			mgmt_mesh_packet_cmplt_evt, 1, true },
 	{ 0x0033, "Connection Subrate",
 			mgmt_conn_subrate_evt, 18, true },
+	{ 0x0034, "Security Level Changed",
+			mgmt_security_level_changed_evt, 8, false },
 	{ }
 };
 
-- 
2.43.0

