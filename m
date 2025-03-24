Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB4F25D544
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 10:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813035; cv=none; b=Wd6MBpAWjzK84Yd0L3HEyD1kSWKE4edQGOGKKDQzZkqluUd/6XZooQtlFx8YCKn6DFO1i9gH8oa/3aspLIWqN2/2qJH4dGx3FWPoIGFl0vdM2MUrCNVlde7xzJY6Hpw2DqElU1u7mkXdJx8MBV8yfqWIcAGo9d/juoHXrWKy/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813035; c=relaxed/simple;
	bh=KJHLU8TmCzVj6ngBS1n2z77EbpIdgkGtrgiFycESaQo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=oiNtY/pgOQpRiMXktWw2pt0nT5uyqO7/vjkmT6YDdjXLnwEgNryno49xQlT+wLmBD9z8vjaeMFKutsBkdOBX84jsVdbPQIH3Ha+flFwzaTdeG1mHKH0RP7Ip9xAM2AA3B1SB0Yu7gSj3a2cAs0fokv5qSRCPD1pHlrJNxiIhDMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VwANKScb; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VwANKScb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1742813032;
	bh=KJHLU8TmCzVj6ngBS1n2z77EbpIdgkGtrgiFycESaQo=;
	h=From:To:Subject:Date:From;
	b=VwANKScbHPKhBWXoMys+H7eDp5ZoGqg1WR8pb8F1UwyQC2dnGOzQ7Zn/SthK/bp9l
	 3ChlaEea7AJRu8SsyMmoiFKDfGkIbdpAkMJgkdoyOtzDJ1oxCGmryIdHRSSG3wWaxX
	 zdcoMgmVJXfYHxBMP53sW25okZf25m+3MqY6wbaluC1KwyWCMnZ1hmDon2lCwa2mP0
	 bNudx71F44kMl6pbEwCl2JR+xZgxGCLFy0MQBDo1uPnNQpjI19WdsGqUrinlNgoNDi
	 Q28JvekJzynBYP1oFdO0D8iKYXm+UIfybPOB79q/z9tkCHTy2j3N06XIOVZPn+KAFs
	 LwHYJFqHeHIcA==
Received: from fdanis-XPS-13-9370.. (2a02-8428-Af44-1001-EdC7-2366-cd4a-E59d.rev.sfr.net [IPv6:2a02:8428:af44:1001:edc7:2366:cd4a:e59d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DBE6817E0385
	for <linux-bluetooth@vger.kernel.org>; Mon, 24 Mar 2025 11:43:51 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] obex: MAP MCE Publish supported features during connect
Date: Mon, 24 Mar 2025 11:43:46 +0100
Message-ID: <20250324104346.64309-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is required for passing MAP/MCE/MFB/BV-06-C PTS test case:
Verify that the MCE sends its MapSupportedFeatures in the OBEX
Connect request if the MSE declares support for the feature
MapSupportedFeatures in Connect Request in its SDP record.
---
 obexd/client/map.c | 57 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/obexd/client/map.c b/obexd/client/map.c
index 7ca33cfe0..19125ac56 100644
--- a/obexd/client/map.c
+++ b/obexd/client/map.c
@@ -57,6 +57,33 @@
 #define SDP_MESSAGE_TYPE_MMS		0x08
 #define SDP_MESSAGE_TYPE_IM		0x10
 
+#define SDP_MCE_MAP_SUPPORTED_FEATURES_IN_CONNECT	0x00080000
+
+#define MAP_SUPPORTED_FEATURES_TAG  	0x29
+
+#define NOTIFICATION_REGISTRATION_FEATURE	0x00000001
+#define NOTIFICATION_FEATURE			0x00000002
+#define BROWSING_FEATURE			0x00000004
+#define UPLOADING_FEATURE			0x00000008
+#define DELETE_FEATURE				0x00000010
+#define INSTANCE_INFORMATION_FEATURE		0x00000020
+#define EXTENDED_EVENT_REPORT_1_1		0x00000040
+#define EVENT_REPORT_1_2			0x00000080
+#define MESSAGE_FORMAT_1_1			0x00000100
+#define MESSAGE_LISTING_FORMAT_1_1		0x00000200
+#define PERSISTENT_MESSAGE_HANDLES		0x00000400
+#define DATABASE_IDENTIFIER			0x00000800
+#define FOLDER_VERSION_COUNTER			0x00001000
+#define CONVERSATION_VERSION_COUNTERS		0x00002000
+#define PARTICIPANT_PRESENCE_CHANGE		0x00004000
+#define PARTICIPANT_CHAT_STATE_CHANGE		0x00008000
+#define PBAP_CONTACT_CROSS_REFERENCE		0x00010000
+#define NOTIFICATION_FILTERING			0x00020000
+#define UTC_OFFSET_TIMESTAMP_FORMAT		0x00040000
+#define RESERVED				0x00080000
+#define CONVERSATION_LISTING			0x00100000
+#define OWNER_STATUS				0x00200000
+
 static const char * const filter_list[] = {
 	"subject",
 	"timestamp",
@@ -2224,6 +2251,35 @@ static void parse_service_record(struct map_data *map)
 		map->supported_features = 0x0000001f;
 }
 
+static void *map_supported_features(struct obc_session *session)
+{
+	const void *data;
+	uint32_t features;
+
+	/* Supported Feature Bits */
+	data = obc_session_get_attribute(session,
+		SDP_ATTR_MAP_SUPPORTED_FEATURES);
+
+	if (!data)
+		return NULL;
+
+	features = *(uint32_t *) data;
+	if (!(features & SDP_MCE_MAP_SUPPORTED_FEATURES_IN_CONNECT))
+		return NULL;
+
+	return g_obex_apparam_set_uint32(NULL, MAP_SUPPORTED_FEATURES_TAG,
+		NOTIFICATION_REGISTRATION_FEATURE |
+		NOTIFICATION_FEATURE |
+		BROWSING_FEATURE |
+		UPLOADING_FEATURE |
+		DELETE_FEATURE |
+		INSTANCE_INFORMATION_FEATURE |
+		EXTENDED_EVENT_REPORT_1_1 |
+		MESSAGE_FORMAT_1_1 |
+		MESSAGE_LISTING_FORMAT_1_1 |
+		PERSISTENT_MESSAGE_HANDLES);
+}
+
 static int map_probe(struct obc_session *session)
 {
 	struct map_data *map;
@@ -2269,6 +2325,7 @@ static struct obc_driver map = {
 	.uuid = MAS_UUID,
 	.target = OBEX_MAS_UUID,
 	.target_len = OBEX_MAS_UUID_LEN,
+	.supported_features = map_supported_features,
 	.probe = map_probe,
 	.remove = map_remove
 };
-- 
2.43.0

