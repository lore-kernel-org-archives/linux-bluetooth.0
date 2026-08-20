Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544CD4189C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223164; cv=none; b=JEwyMXUwiPCy4ms8h0Rk7u6xCluaMvQAs9/uCkKpcR4jrHoRNXawj/yYaNK7+O2AUm/QvZSDq7So6AnX6/aOvRWCar0LyHCY2Acuu0LQHg1TH4cd3YkS+ET1pp5zDAzn6KPBX9Q0NGcTgdnK/HDy0VLIXNwY7r8h+W4o5Wn7xgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223164; c=relaxed/simple;
	bh=6/qcLggBB0dkRlFyHz2dMAeRCm4AXzVADm3ZnQbF7a8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z9BcNZv9QoprMTBGqJ3ZV3T409F/5OiS04t72BTj+qRBFVKRoEORm8jDmzsapJqtkCGhcGM9xJUv7o4Sqd6NhegCF9fNs7dz8Q7ReYgZD42/v8f1wOmPYmx64FhhJ6VHrUF3CUcGu/f7hdxuII9Op2P+hv+pKaUn2y7X9wKNhRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qe979zqB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qe979zqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1787223161;
	bh=6/qcLggBB0dkRlFyHz2dMAeRCm4AXzVADm3ZnQbF7a8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qe979zqBrMN4d1ZNMqGmb7gPoPmNJdBs3oM/1rXBQ3OuWVxwuUaYsvlwm2lxbgrPD
	 5eC7lYOWuX+W40nuGyZB8rjVwXF//9+5glKKKkRBJezD3p8LraC3DJ/g8KKCapN9fN
	 AlBJH1NIvtHpe8AU2ll69EKoudxfYvWxE3iVaTQ9nUSWR/JqkFnW0TSzTEZuyN0v2S
	 FOZGVey/dAJSwMq2OQzj4b8uZW6dmbE7qeIalGLlTWV8OGMeVh7yjxGdf7l/k9eJj4
	 oUhC8B+SXGi8OtliwFt8yVU8UdCZQXp1YS3Yh1Wdljfaj6Ck5zR5K1eijt7Gb7PD8F
	 zAAfg1b/zx/pw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id A62BF17E0D69
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Aug 2026 12:52:41 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] monitor: Add support for Mgmt Security Level changed event
Date: Thu, 20 Aug 2026 12:52:31 +0200
Message-ID: <20260820105235.1190318-4-frederic.danis@collabora.com>
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

