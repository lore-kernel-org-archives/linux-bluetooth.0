Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795429558;
	b=s0g7QyTqH9YOwzssBPZRSX1xmRaaqmAGvzC4GYZgYOUdHm34Od3w3H2MneazwITtd43m
	 Yvpk7fISp71YB5vfhpG3qIxYq33TEGU72uLzO9msZym6sarwnIIPmikVVs37kV+K8stO3
	 FapakW3vw15QWbmvxMlN0Px4j/QftGJ+DE/5OSXx8m0+hwcb7WqLmZ73XET32Tg0kvToX
	 GIjvhS16EzSSrBXk3l481t67iavQC29t+SsbY80+1N/s0My7myOLCEpA71jiwJI69M7JF
	 YCneEit9QTQJmt1ksoPms2RJTtmxCe7aig0hGuAxk2UgIb07BekDLp1B5jZma21nG7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795429558;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=aANZmmafEPCsA2D3Asv+uU7udoTJg15JVxDLrxz+9ZY=;
	b=TtpNPY4lcZvzGUiFlH14lJM/3It49lHQIiAEGqx4e0J4wDbQA3KqXRUk8GHqUARCT+QL
	 Km4LaEGpxW7nZfRVgFMLcEjY3jm3de1AMH2nrezeFFuFEVlTmhkwGE3JkuRg8NsMYvfTP
	 wCLk74wWuwieTT0I1r1CkK31BTfj/Jy+8b07215iCiUnemKEvghMdAI76Vr+ClpgBjpd3
	 E0DkIusrV3elay81eBFAuPBHraH1dCFhafHAikshLsWXmbp7oz1vbu94p4trqx7n+AhI3
	 kdOFMbyJeqaZtRnmdEiF2X1dElYoSEP4JNeHOhTVKRW0ycLK5dp39FVj4+c7iwBhGdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iaMV0TEV;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94EEE606A335
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 10:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94EEE606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=iaMV0TEV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795429556;
	bh=XoV5C8XP1zktVnSpx9GZKx2sgMo8SWgw4iUyt9DmdlM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=iaMV0TEVJeqPWPpV8ErgTp3X0ApHC1op/uzrHAa8fweDwYi6T3t01e+LKFkvVzr15
	 YmOgOMcl1OU+7xRLcxwNe8ZimToeLhvKGcBN6HdY7MbOgRPJGUsq2yaa4A/OdXdTjy
	 zom9VOgp1JWcsGe9SwqAvVVOnpVa8MvVcIUb/8RUk0bnGn1+zw8iIY6suAzzY/h9DM
	 7hPq4erx6aG4wlnaBFEx/0jv74Shr54n2pi+sfbAHjBeA5PMCWA8fIJYFUxDtikkl2
	 MhYSrzCKQz0KmHlWTqF3pYZntRbnvJY1S1GUfwfVtLU6mAfWUNpaa6OtAW0YjjiZXw
	 jIvgEm8Rbyb2Q==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 32EF817E0DB6
	for <linux-bluetooth@vger.kernel.org>; Mon, 23 Nov 2026 11:25:56 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] monitor: Decode PBAP/MAP/BIP Application Parameters tags
Date: Mon, 23 Nov 2026 11:25:47 +0100
Message-ID: <20261123102548.61362-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123102548.61362-1-frederic.danis@collabora.com>
References: <20261123102548.61362-1-frederic.danis@collabora.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Frédéric Danis <frederic.danis.oss@gmail.com>

Application Parameters (Tag/Len/Value) were only shown generically
as 'Tag 0xNN len N' plus a hexdump, with no knowledge of what each
tag means. Add per-profile tag tables (name + value type) for PBAP,
MAP and BIP, sourced from their respective specifications, and decode
known tag values as numbers/strings instead of a raw hexdump.

Since Application Parameters headers don't repeat which profile a
session belongs to, remember the profile classification learned from
a session's CONNECT Target/Who header (already decoded by the
existing Target/Who profile lookup) in a small per-session table,
keyed the same way as the existing last-request tracking. Sessions
with no recognized Target/Who (or none yet seen) keep today's
generic Tag/Len/Value dump.

Assisted-by: Claude:claude-sonnet-5
---
 monitor/obex.c | 323 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 310 insertions(+), 13 deletions(-)

diff --git a/monitor/obex.c b/monitor/obex.c
index c1ac76937..873e3b538 100644
--- a/monitor/obex.c
+++ b/monitor/obex.c
@@ -45,6 +45,18 @@
 #define MAX_OBEX_CHAN 64
 #define MAX_OBEX_REQ  32
 
+/* Profiles with a known Application Parameters tag set, used to
+ * select the right tag table when decoding the Application Parameters
+ * header. OBEX_PROFILE_UNKNOWN falls back to a generic Tag/Len/Value
+ * dump.
+ */
+enum obex_profile {
+	OBEX_PROFILE_UNKNOWN,
+	OBEX_PROFILE_PBAP,
+	OBEX_PROFILE_MAP,
+	OBEX_PROFILE_BIP,
+};
+
 struct obex_chan_data {
 	uint16_t index;
 	uint16_t handle;
@@ -303,6 +315,69 @@ static bool obex_last_request_is(uint16_t index, uint16_t handle,
 	return false;
 }
 
+/* Profile classification (PBAP/MAP/BIP/unknown) of an ongoing OBEX
+ * session, learned from a CONNECT's Target/Who header and remembered
+ * per session so that later Application Parameters headers (which
+ * don't repeat the Target/Who UUID) can be decoded using the right
+ * profile-specific tag table.
+ */
+#define MAX_OBEX_PROFILE 32
+
+struct obex_profile_data {
+	uint16_t index;
+	uint16_t handle;
+	uint16_t channel;
+	enum obex_profile profile;
+};
+
+static struct obex_profile_data obex_profile_list[MAX_OBEX_PROFILE];
+
+static void obex_set_profile(uint16_t index, uint16_t handle,
+					uint16_t channel,
+					enum obex_profile profile)
+{
+	int i, n = -1;
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (obex_profile_list[i].handle == 0x0000 && n < 0) {
+			n = i;
+			continue;
+		}
+
+		if (obex_profile_list[i].index == index &&
+				obex_profile_list[i].handle == handle &&
+				obex_profile_list[i].channel == channel) {
+			n = i;
+			break;
+		}
+	}
+
+	if (n < 0)
+		return;
+
+	obex_profile_list[n].index = index;
+	obex_profile_list[n].handle = handle;
+	obex_profile_list[n].channel = channel;
+	obex_profile_list[n].profile = profile;
+}
+
+static enum obex_profile obex_get_profile(uint16_t index, uint16_t handle,
+							uint16_t channel)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (obex_profile_list[i].handle != handle ||
+				obex_profile_list[i].index != index ||
+				obex_profile_list[i].channel != channel)
+			continue;
+
+		return obex_profile_list[i].profile;
+	}
+
+	return OBEX_PROFILE_UNKNOWN;
+}
+
 /*
  * Minimal SDP Data Element reader, mirroring monitor/sdp.c's
  * decode_data_elements() size/type decoding, but returning the decoded
@@ -739,24 +814,31 @@ static const struct {
 	const uint8_t uuid[16];
 	uint8_t len;
 	const char *str;
+	enum obex_profile profile;
 } obex_target_table[] = {
 	{ { 0x79, 0x61, 0x35, 0xf0, 0xf0, 0xc5, 0x11, 0xd8,
 	    0x09, 0x66, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66 }, 16,
-					"Phonebook Access (PBAP)" },
+					"Phonebook Access (PBAP)",
+					OBEX_PROFILE_PBAP },
 	{ { 0xf9, 0xec, 0x7b, 0xc4, 0x95, 0x3c, 0x11, 0xd2,
 	    0x98, 0x4e, 0x52, 0x54, 0x00, 0xdc, 0x9e, 0x09 }, 16,
-					"File Transfer (FTP)" },
+					"File Transfer (FTP)",
+					OBEX_PROFILE_UNKNOWN },
 	{ { 0xbb, 0x58, 0x2b, 0x40, 0x42, 0x0c, 0x11, 0xdb,
 	    0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66 }, 16,
-					"Message Access (MAP)" },
+					"Message Access (MAP)",
+					OBEX_PROFILE_MAP },
 	{ { 0xbb, 0x58, 0x2b, 0x41, 0x42, 0x0c, 0x11, 0xdb,
 	    0xb0, 0xde, 0x08, 0x00, 0x20, 0x0c, 0x9a, 0x66 }, 16,
-					"Message Notification (MNS)" },
+					"Message Notification (MNS)",
+					OBEX_PROFILE_MAP },
 	{ { 0x71, 0x63, 0xdd, 0x54, 0x4a, 0x7e, 0x11, 0xe2,
 	    0xb4, 0x7c, 0x00, 0x50, 0xc2, 0x49, 0x00, 0x48 }, 16,
-				"Basic Imaging (BIP, AVRCP Cover Art)" },
+				"Basic Imaging (BIP, AVRCP Cover Art)",
+					OBEX_PROFILE_BIP },
 	{ { 'I', 'R', 'M', 'C', '-', 'S', 'Y', 'N', 'C' }, 9,
-					"Synchronization (IrMC/SyncML)" },
+					"Synchronization (IrMC/SyncML)",
+					OBEX_PROFILE_UNKNOWN },
 	{ }
 };
 
@@ -775,6 +857,22 @@ static const char *obex_target_str(const uint8_t *data, uint16_t len)
 	return NULL;
 }
 
+static enum obex_profile obex_target_profile(const uint8_t *data,
+							uint16_t len)
+{
+	int i;
+
+	for (i = 0; obex_target_table[i].len; i++) {
+		if (obex_target_table[i].len != len)
+			continue;
+
+		if (!memcmp(obex_target_table[i].uuid, data, len))
+			return obex_target_table[i].profile;
+	}
+
+	return OBEX_PROFILE_UNKNOWN;
+}
+
 static void print_unicode_header(const char *label, const uint8_t *data,
 						uint16_t len, uint8_t indent)
 {
@@ -805,8 +903,200 @@ static void print_unicode_header(const char *label, const uint8_t *data,
 	print_field("%*c%s: %s", indent, ' ', label, buf);
 }
 
+/* Application Parameters (Tag/Len/Value) tag tables for profiles whose
+ * tag assignments are known. Tag IDs and names are taken from the
+ * PBAP/MAP/BIP specifications; types indicate how to decode a tag's
+ * value when its length matches what the spec defines for it.
+ */
+enum obex_aparam_type {
+	OBEX_APARAM_U8,
+	OBEX_APARAM_U16,
+	OBEX_APARAM_U32,
+	OBEX_APARAM_U64,
+	OBEX_APARAM_U128,
+	OBEX_APARAM_STR,
+	OBEX_APARAM_BYTES,
+};
+
+struct obex_aparam_tag {
+	uint8_t tag;
+	const char *str;
+	enum obex_aparam_type type;
+};
+
+static const struct obex_aparam_tag obex_pbap_aparam_table[] = {
+	{ 0x01, "Order",			OBEX_APARAM_U8	},
+	{ 0x02, "Search Value",			OBEX_APARAM_STR	},
+	{ 0x03, "Search Attribute",		OBEX_APARAM_U8	},
+	{ 0x04, "Max List Count",		OBEX_APARAM_U16	},
+	{ 0x05, "List Start Offset",		OBEX_APARAM_U16	},
+	{ 0x06, "Filter",			OBEX_APARAM_U64	},
+	{ 0x07, "Format",			OBEX_APARAM_U8	},
+	{ 0x08, "Phonebook Size",		OBEX_APARAM_U16	},
+	{ 0x09, "New Missed Calls",		OBEX_APARAM_U8	},
+	{ 0x0a, "Primary Folder Version",	OBEX_APARAM_U128 },
+	{ 0x0b, "Secondary Folder Version",	OBEX_APARAM_U128 },
+	{ 0x0c, "vCard Selector",		OBEX_APARAM_U64	},
+	{ 0x0d, "Database Identifier",		OBEX_APARAM_U128 },
+	{ 0x0e, "vCard Selector Operator",	OBEX_APARAM_U8	},
+	{ 0x0f, "Reset New Missed Calls",	OBEX_APARAM_U8	},
+	{ 0x10, "Supported Features",		OBEX_APARAM_U32	},
+	{ }
+};
+
+static const struct obex_aparam_tag obex_map_aparam_table[] = {
+	{ 0x01, "Max List Count",			OBEX_APARAM_U16	},
+	{ 0x02, "List Start Offset",			OBEX_APARAM_U16	},
+	{ 0x03, "Filter Message Type",			OBEX_APARAM_U8	},
+	{ 0x04, "Filter Period Begin",			OBEX_APARAM_STR	},
+	{ 0x05, "Filter Period End",			OBEX_APARAM_STR	},
+	{ 0x06, "Filter Read Status",			OBEX_APARAM_U8	},
+	{ 0x07, "Filter Recipient",			OBEX_APARAM_STR	},
+	{ 0x08, "Filter Originator",			OBEX_APARAM_STR	},
+	{ 0x09, "Filter Priority",			OBEX_APARAM_U8	},
+	{ 0x0a, "Attachment",				OBEX_APARAM_U8	},
+	{ 0x0b, "Transparent",				OBEX_APARAM_U8	},
+	{ 0x0c, "Retry",				OBEX_APARAM_U8	},
+	{ 0x0d, "New Message",				OBEX_APARAM_U8	},
+	{ 0x0e, "Notification Status",			OBEX_APARAM_U8	},
+	{ 0x0f, "MAS Instance ID",			OBEX_APARAM_U8	},
+	{ 0x10, "Parameter Mask",			OBEX_APARAM_U32	},
+	{ 0x11, "Folder Listing Size",			OBEX_APARAM_U16	},
+	{ 0x12, "Listing Size",				OBEX_APARAM_U16	},
+	{ 0x13, "Subject Length",			OBEX_APARAM_U8	},
+	{ 0x14, "Charset",				OBEX_APARAM_U8	},
+	{ 0x15, "Fraction Request",			OBEX_APARAM_U8	},
+	{ 0x16, "Fraction Deliver",			OBEX_APARAM_U8	},
+	{ 0x17, "Status Indicator",			OBEX_APARAM_U8	},
+	{ 0x18, "Status Value",				OBEX_APARAM_U8	},
+	{ 0x19, "MSE Time",				OBEX_APARAM_STR	},
+	{ 0x1a, "Database Identifier",			OBEX_APARAM_BYTES },
+	{ 0x1b, "Conversation Listing Version Counter", OBEX_APARAM_BYTES },
+	{ 0x1c, "Presence Availability",		OBEX_APARAM_U8	},
+	{ 0x1d, "Presence Text",			OBEX_APARAM_STR	},
+	{ 0x1e, "Last Activity",			OBEX_APARAM_STR	},
+	{ 0x1f, "Filter Last Activity Begin",		OBEX_APARAM_STR	},
+	{ 0x20, "Filter Last Activity End",		OBEX_APARAM_STR	},
+	{ 0x21, "Chat State",				OBEX_APARAM_U8	},
+	{ 0x22, "Conversation ID",			OBEX_APARAM_BYTES },
+	{ 0x23, "Folder Version Counter",		OBEX_APARAM_BYTES },
+	{ 0x24, "Filter Message Handle",		OBEX_APARAM_STR	},
+	{ 0x25, "Notification Filter Mask",		OBEX_APARAM_U32	},
+	{ 0x26, "Conversation Parameter Mask",		OBEX_APARAM_U32	},
+	{ 0x27, "Filter Message Source Type",		OBEX_APARAM_U8	},
+	{ 0x29, "MAP Supported Features",		OBEX_APARAM_U32	},
+	{ }
+};
+
+static const struct obex_aparam_tag obex_bip_aparam_table[] = {
+	{ 0x01, "Number of Returned Handles",	OBEX_APARAM_U16	},
+	{ 0x02, "List Start Offset",		OBEX_APARAM_U16	},
+	{ 0x03, "Latest Captured Images",	OBEX_APARAM_U8	},
+	{ 0x04, "Partial File Length",		OBEX_APARAM_U32	},
+	{ 0x05, "Partial File Start Offset",	OBEX_APARAM_U32	},
+	{ 0x06, "Total File Size",		OBEX_APARAM_U32	},
+	{ 0x07, "End Flag",			OBEX_APARAM_U8	},
+	{ 0x08, "Remote Display",		OBEX_APARAM_U8	},
+	{ }
+};
+
+static void obex_print_apparam_tag(enum obex_profile profile, uint8_t tag,
+				const uint8_t *data, uint8_t len,
+				uint8_t indent)
+{
+	const struct obex_aparam_tag *table;
+	int i;
+
+	switch (profile) {
+	case OBEX_PROFILE_PBAP:
+		table = obex_pbap_aparam_table;
+		break;
+	case OBEX_PROFILE_MAP:
+		table = obex_map_aparam_table;
+		break;
+	case OBEX_PROFILE_BIP:
+		table = obex_bip_aparam_table;
+		break;
+	case OBEX_PROFILE_UNKNOWN:
+	default:
+		table = NULL;
+		break;
+	}
+
+	for (i = 0; table && table[i].str; i++) {
+		if (table[i].tag != tag)
+			continue;
+
+		switch (table[i].type) {
+		case OBEX_APARAM_U8:
+			if (len == 1) {
+				print_field("%*c%s: %d (0x%02x)", indent, ' ',
+						table[i].str, data[0],
+						data[0]);
+				return;
+			}
+			break;
+		case OBEX_APARAM_U16:
+			if (len == 2) {
+				uint16_t val = get_be16(data);
+
+				print_field("%*c%s: %u (0x%04x)", indent, ' ',
+						table[i].str, val, val);
+				return;
+			}
+			break;
+		case OBEX_APARAM_U32:
+			if (len == 4) {
+				uint32_t val = get_be32(data);
+
+				print_field("%*c%s: %u (0x%08x)", indent, ' ',
+						table[i].str, val, val);
+				return;
+			}
+			break;
+		case OBEX_APARAM_U64:
+			if (len == 8) {
+				print_field("%*c%s: 0x%016" PRIx64, indent,
+						' ', table[i].str,
+						get_be64(data));
+				return;
+			}
+			break;
+		case OBEX_APARAM_U128:
+			if (len == 16) {
+				print_field("%*c%s: 0x%016" PRIx64 "%016"
+						PRIx64, indent, ' ',
+						table[i].str, get_be64(data),
+						get_be64(data + 8));
+				return;
+			}
+			break;
+		case OBEX_APARAM_STR:
+			print_field("%*c%s: %.*s", indent, ' ', table[i].str,
+							len, data);
+			return;
+		case OBEX_APARAM_BYTES:
+			break;
+		}
+
+		/* Known tag but unexpected length (or a raw-bytes type):
+		 * still show the tag's name, with a length + hexdump
+		 * instead of a decoded value.
+		 */
+		print_field("%*c%s: [len %d]", indent, ' ', table[i].str,
+									len);
+		if (len)
+			packet_hexdump(data, len);
+		return;
+	}
+
+	print_field("%*cTag 0x%02x len %d", indent, ' ', tag, len);
+	if (len)
+		packet_hexdump(data, len);
+}
+
 static void obex_print_apparam(const uint8_t *data, uint16_t size,
-								uint8_t indent)
+				uint8_t indent, enum obex_profile profile)
 {
 	uint16_t pos = 0;
 
@@ -819,15 +1109,15 @@ static void obex_print_apparam(const uint8_t *data, uint16_t size,
 			break;
 		}
 
-		print_field("%*cTag 0x%02x len %d", indent, ' ', tag, len);
-		if (len)
-			packet_hexdump(data + pos + 2, len);
+		obex_print_apparam_tag(profile, tag, data + pos + 2, len,
+								indent);
 
 		pos += 2 + len;
 	}
 }
 
-static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent)
+static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent,
+							uint16_t channel)
 {
 	while (frame->size > 0) {
 		uint8_t hdr_id;
@@ -868,6 +1158,10 @@ static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent)
 				if (profile) {
 					print_field("%*c%s: %s", indent, ' ',
 							label, profile);
+					obex_set_profile(frame->index,
+						frame->handle, channel,
+						obex_target_profile(data,
+								vlen));
 				} else {
 					print_field("%*c%s: [len %d]", indent,
 							' ', label, vlen);
@@ -888,7 +1182,10 @@ static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent)
 
 				if (hdr_id == OBEX_HDR_APPARAM)
 					obex_print_apparam(data, vlen,
-								indent + 2);
+						indent + 2,
+						obex_get_profile(frame->index,
+							frame->handle,
+							channel));
 				else if (vlen)
 					packet_hexdump(data, vlen);
 			}
@@ -1021,7 +1318,7 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 			goto fail;
 	}
 
-	if (!obex_print_headers(f, indent))
+	if (!obex_print_headers(f, indent, channel))
 		goto fail;
 
 	if (is_request)
-- 
2.43.0

