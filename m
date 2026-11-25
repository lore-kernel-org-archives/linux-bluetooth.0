Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795613891;
	b=EM6ItsUMHyHMchywtkR0CWZ7ObhsCeKVpD01nYguZb60rgTZDF8a311StFGsBerwD+h3
	 h6SN55xhyD1xdmN4Xb7F2yJHhgjkjuPJsXx4sbld4Zfo2cG0iYoUqm9pdId0zinSy0vch
	 NjOdXvlrBK15AVPkbYHJi+PNffwQDYcbPu3nl/yOjiLEqseW4a7DX3evjNfaazYS15zZC
	 9JvfmG3iaM4AQ7pXgDVtrm0wuj5SeTyRZfNjd/RuZu6dLCA3j9rgURRv5NFXsWm1xmDVT
	 O1MSKAiIhYnyXsB3PIbgBLpbvaSgbfFnAbkadwFmoN2BjC9yGKYAK4t2WYssfb+/QTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795613891;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=At4h5phtOed/PlVHDnCI79PffmG1X1wQ7kLydXmiG5Y=;
	b=N3u/oav91XWo59OQoO/ce3rDkRLA8sx+kHskoQBVCN7sksOsEp+poWvCqPk4TFZjpV4X
	 o+r+6rinGTg6sp1F02p2TRv4rax/WMaB3oKq84pES9ZdXjyrLHr2woYyY5f9WFVj3UAej
	 uJf2SD0ILYLWFN5tnja8iUbNlpC05m5wAdh7qZ2+T6cbCDZbyI7WKFiZsaFWTOhvRMiqK
	 qV1e7XdihJ1T7+GY5rtgT0oNUzbRj0YkT0ymJZjOYXfg6KWWyOI8yr/2kjAMAzdu8OUgq
	 plbFbJCz8Bk9DGSUPxC2u5jc6YoqppDk7RfCLoHBlT5jXS4EBOrfBUouesN5Ns6Rt7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XYoOEZ6D;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85671606A326
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 13:38:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85671606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=XYoOEZ6D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1795613889;
	bh=DeMOKtDfEWFH/j0goJD6pXklsRQjJTmMEgJaDa3T3x8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XYoOEZ6DZixJfnZSYc17ixAYa2tNOewZso5ExqByxcbV9LFbn+OGXSWCmlP/rUknJ
	 hbjP3JDoU10FYGV7WQxV6kwQg4WQmNIvvXNDzC7neFxzxATubxMiL02wXbYCnF1SgL
	 d/sk9fUIj7bKl5Hxd3F1MJ4k3pzw9cah0f0HrfYjXgGuLP1jjuWUd5NnSYAiLJegB1
	 hRR5K2PxWG/vo34+pKAqT6F0h1WF4iYQmuQAtKefRtb/TsKibUpwFqh0A/oKxFlzbo
	 PouUAsj9UfJFWJ1VTtPD0/ggR/txb0ApGWthhYI8DGqL+460JWIUhyOgyYwMuAgANE
	 6Njo6tJgpq4jg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C28E17E08C6
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 14:38:09 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v5 3/6] monitor: Decode PBAP/MAP/BIP Application Parameters tags
Date: Wed, 25 Nov 2026 14:37:53 +0100
Message-ID: <20261125133756.551659-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125133756.551659-1-frederic.danis@collabora.com>
References: <20261125133756.551659-1-frederic.danis@collabora.com>
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

The matching obex_profile_list entries are cleared from
obex_remove_channel(), obex_remove_session() and
obex_disconnect_handle() whenever a session, channel, or handle goes
away, and on every CONNECT request, so a later session reusing the
same index/handle/channel triplet cannot inherit a profile learned by
an unrelated earlier session.

Assisted-by: Claude:claude-sonnet-5
---
v2->v3:
  - Clear the learned profile classification from
    obex_remove_channel(), obex_remove_session() and
    obex_disconnect_handle() on session/channel/handle teardown, and
    also reset it on every CONNECT, so a later session reusing the same
    index/handle/channel triplet can't inherit a stale profile from an
    unrelated earlier session.
v3->v4:
  - Explain in a comment above obex_remove_channel() why the
    SDP-learned obex_chan_list mapping itself is kept across RFCOMM
    teardown (a reconnect on the same ACL link must still resolve the
    channel), and bail out early when called with a zero channel.
  - Use a channel-zero check (!channel) instead of an explicit
    handle == 0x0000 comparison to detect free obex_profile_list
    slots.

 monitor/obex.c | 365 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 352 insertions(+), 13 deletions(-)

diff --git a/monitor/obex.c b/monitor/obex.c
index 30efcbaae..6e69412ff 100644
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
@@ -202,17 +214,59 @@ static void obex_clear_request(uint16_t index, uint16_t handle,
 	}
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
+static void obex_clear_profile(uint16_t index, uint16_t handle,
+							uint16_t channel)
+{
+	int i;
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (obex_profile_list[i].index == index &&
+				obex_profile_list[i].handle == handle &&
+				obex_profile_list[i].channel == channel)
+			memset(&obex_profile_list[i], 0,
+					sizeof(obex_profile_list[i]));
+	}
+}
+
+/* The RFCOMM channel is being torn down (DISC/DM), but the SDP-learned
+ * service-to-channel mapping in obex_chan_list is kept: a peer can
+ * reopen the same RFCOMM service on the still-up ACL link without
+ * repeating SDP, and obex_channel() needs the mapping to still resolve
+ * for that reconnection. Only the per-session request/profile state is
+ * cleared here; the mapping itself is only dropped by a later SDP
+ * update (via obex_add_channel()) or when the ACL handle disconnects
+ * (obex_disconnect_handle()).
+ */
 void obex_remove_channel(uint16_t index, uint16_t handle, uint8_t channel)
 {
 	if (!channel)
 		return;
 
 	obex_clear_request(index, handle, channel);
+	obex_clear_profile(index, handle, channel);
 }
 
 void obex_remove_session(uint16_t index, uint16_t handle, uint16_t channel)
 {
 	obex_clear_request(index, handle, channel);
+	obex_clear_profile(index, handle, channel);
 }
 
 void obex_disconnect_handle(uint16_t index, uint16_t handle)
@@ -244,6 +298,16 @@ void obex_disconnect_handle(uint16_t index, uint16_t handle)
 			memset(&obex_psm_list[i], 0,
 						sizeof(obex_psm_list[i]));
 	}
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (!obex_profile_list[i].channel)
+			continue;
+
+		if (obex_profile_list[i].index == index &&
+				obex_profile_list[i].handle == handle)
+			memset(&obex_profile_list[i], 0,
+					sizeof(obex_profile_list[i]));
+	}
 }
 
 static void obex_set_last_request(uint16_t index, uint16_t handle,
@@ -291,6 +355,52 @@ static bool obex_last_request_is(uint16_t index, uint16_t handle,
 	return false;
 }
 
+static void obex_set_profile(uint16_t index, uint16_t handle,
+					uint16_t channel,
+					enum obex_profile profile)
+{
+	int i, n = -1;
+
+	for (i = 0; i < MAX_OBEX_PROFILE; i++) {
+		if (!obex_profile_list[i].channel && n < 0) {
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
@@ -788,24 +898,31 @@ static const struct {
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
 
@@ -824,6 +941,22 @@ static const char *obex_target_str(const uint8_t *data, uint16_t len)
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
@@ -885,8 +1018,200 @@ static void print_unicode_header(const char *label, const uint8_t *data,
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
 
@@ -899,15 +1224,15 @@ static void obex_print_apparam(const uint8_t *data, uint16_t size,
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
@@ -948,6 +1273,10 @@ static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent)
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
@@ -968,7 +1297,10 @@ static bool obex_print_headers(struct l2cap_frame *frame, uint8_t indent)
 
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
@@ -1089,6 +1421,13 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 			(opcode & OBEX_FINAL_BIT) ? 1 : 0, length);
 
 	if (is_request && code == OBEX_OP_CONNECT) {
+		/* A new CONNECT drops any profile classification learned
+		 * from a previous session reusing this index/handle/channel
+		 * key, in case this CONNECT's Target/Who header (if any)
+		 * doesn't repeat it.
+		 */
+		obex_clear_profile(frame->index, frame->handle, channel);
+
 		if (!obex_connect_fields(f, indent))
 			goto fail;
 	} else if (!is_request && obex_last_request_is(frame->index,
@@ -1101,7 +1440,7 @@ void obex_packet(const struct l2cap_frame *frame, uint16_t channel)
 			goto fail;
 	}
 
-	if (!obex_print_headers(f, indent))
+	if (!obex_print_headers(f, indent, channel))
 		goto fail;
 
 	if (is_request)
-- 
2.43.0

