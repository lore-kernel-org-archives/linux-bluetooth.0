Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793195731;
	b=I0NqvhalaefFEjIjbhaAe2JbRuW/klJdhxR2RDHI5tQmJQKdgj7dskBrLEuL0StA2ElJ
	 AVXr+hjsRn/DVOZe22DPz37B0mr1j2Ug4XjZgpTGNHrjiaVWV9uw/0IlW3K9RjVhmOiw2
	 q54W402GOhPgpRmReS4VKmTm0GBG7AOAHhguGbg9PaEFE0TtQXgB093B5KgSM3dNYhTFN
	 bZ6mihNwigRWIL8nduy1Ryj2Xf8JdWfDQhQsMRxSzZfEYSvaU82VaUV2sEAFA+lXK82ge
	 eDysEG7Ret7hnd/RCVbZvrHiAJBj5TMFmuoF7dqAcv8hEgYMsIHz6ZmFXj+58S2BSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793195731;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=badHVBhsL5jZ9da8fDTUYVvpKCcdiMSyLbCr2ns/gYI=;
	b=f//3Oy0LlYBULCvVPFy85S76+YxFgv8pFP4Hu7+GJPQqiZg6jfWFHcFSw9uLf5RUOSgO
	 SpYN58mi/dADlzzdmbN5PMoR1lOOVsmHmHG8/yKUDThxy79VOcw9U5moiyw+Xf+RTbq2b
	 SBDWAKguQPyW4oi/trtE1DgdijFu7aZTueuzzyXXeWHxH8XBz65Gsg6iw+a4yppHDiSm0
	 +4Hn+hJtRMkYtbJiPttZZeJfL/O+mojDvsHtvAUtmEQArRh6Tls86xE/fyEUZlk9Zf60R
	 8oWHNH6s6ATsN+1Eks2XNkISMHvYQSWtRcqzyu/jUO/ph2ej6z54kaJkPPpoo4Rk9qw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xp4jtAfP;
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C291F606A31D
	for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C291F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xp4jtAfP
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaf34452a9so739898e0c.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Oct 2026 06:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793195730; x=1793800530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=badHVBhsL5jZ9da8fDTUYVvpKCcdiMSyLbCr2ns/gYI=;
        b=Xp4jtAfPvD8Ip8kTOKnpPVoR5LwlAKogLyUK0HV4o7vlwc+XkbanmZ30TDgDQclBvV
         3LtRBeUyRMpqWJ4qHY2my6ZgmVG4uPA5oT4eAf9MmMPgh5BGGxavR+qnowFKDvfaUZ7F
         NHVA0918y2Fju0rm+R8eDitG7iP61JPYEwiEZk7Rr+8TUbt2Yxpq6PnRfmcRPtUDASr/
         GSTGhQGQ5VD0tW9hrqVZE8L4ugNE6O+Tc8BMHJVXNboVpiehI9XpxFtKwMETwd44sBwx
         Jb3LQHth3K+KY5txYx1sjx8dLXb/2nZEf2QtIky1SMxZ/+BlrXlZYOJ9Dtofh3MXVO4Y
         EqGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793195730; x=1793800530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=badHVBhsL5jZ9da8fDTUYVvpKCcdiMSyLbCr2ns/gYI=;
        b=GLOAmPlmbUqgB0eIT66v2XYtHNCUtoS1LxLaQ4GKYuQ9dz6hWjPcnEo0/NG42+JQ3l
         oIDazRdsseD+nqk6Zu+LFOplfzIMXhWohN2/jHzLA94gxdE178A84rZ8TTHLMgZ938Pt
         ezkQSgGOKaoQwJ/ObfewAMkuY2vWuMr7uU4/Tn6xa0qNAm7wwBnPRyGhhumvxUXR3cIA
         NNRv5HT6ghC1ZWeHOPGnxm7bZehHCT2gDmrFONS+uryooIAyb/j0Qq2rl8kpUE0vVIQW
         nu7jNmAkwq6I2pMP9UeofpgtfrmkD79FM7RTUCRSp2SdvpjYcKmXpy9aYX9FwDRKfORw
         gRCg==
X-Gm-Message-State: AFq9FYJI7TIw5hbFyhXN8eq5SHcnRQuuVKrITn8rE1zqCRAUOZPgYm5S
	gAmmJ4GowNU6i1bvO5WcmQEHBKmsKP0fUNWZeze0TOJYhEJeKRwOBCf3iUbiFskOZUQ=
X-Gm-Gg: AYBFou1Tu+2OJIstQaSitQIu5JlS+5t5aDSDjZZ/SULVw/Z87nOwddMqhp/AjUG2Gki
	v1oqNlvKrZOm6QbuhV1HCXpPD52R69yFjXvb/nESRnp5FC4lSM9+OvqFdZSgLjAJZJ5tusedlDw
	XlssuIE1GqyJ/iyKuHXg3ND2E5ZmMO6vJEgVYp/oqJz/70wuqYybxWOz0nuVHUafGGLPzqveshk
	njvNFwqxIxe/BUmyqqbe/UyBhq2kw83gNRzKBFTcf1OiSjOg0LlIIGuyAwbEC2aliWQaHfgtoth
	2afVe+bgwKbNfCkSzEmWQoYWVfNhR6N8Rx07+K/4OWTGLD606/q5Cpmc+GYB+R+l1bPMmoeZQpI
	hzDVViPmhuQpoOgdkd4a5mu6jPJbsX4XPig6TF/93RRddkNmRDi4IDRuN9ZNRmIm55CVMBgAfwU
	zWGAkdGigvcwHZ8BG3a4xswF+K+xm0Tev28uW3ViZZEjzpcGfwYiehlHclMKsiG4Lb/ixZcm6ha
	zkyu/MHS06zrjK2zOFDQs6rx9FZF/Q5v82l1iITp+bc0Gvtg94G1PnJNMd0i5NM57igP147tLHo
	XtY4JRrWLGok03xvC6Rm3qmIG4PnswT0gTiKPuCR/W+2X3BQZf33DmrMQy7X2osQ6XbT5iubv0G
	VIdwECYlDpsrsjWO2T6A=
X-Received: by 2002:a05:6122:3a11:b0:5e9:5e79:aa5 with SMTP id 71dfb90a1353d-5ec4fffa0b3mr520845e0c.7.1793195729402;
        Wed, 28 Oct 2026 06:55:29 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec4f99442fsm1809767e0c.15.2026.10.28.06.55.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 06:55:28 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] shared/bap: Move LTV type defines to bap-defs.h
Date: Wed, 28 Oct 2026 09:55:16 -0400
Message-ID: <20261028135517.2395290-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028135517.2395290-1-luiz.dentz@gmail.com>
References: <20261028135517.2395290-1-luiz.dentz@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Replace the BAP_*_LTV_TYPE defines private to bap.c with BT_BAP_CAP_*,
BT_BAP_CC_* and BT_BAP_META_* in bap-defs.h, covering every type in
Assigned Numbers 6.12.4, 6.12.5 and 6.12.6, and use them in the
bap-debug.c LTV tables.

Add bap-debug.c decoders for the metadata types that had none: CCID_List,
Parental_Rating, Program_Info_URI, Audio_Active_State,
Broadcast_Audio_Immediate_Rendering_Flag, Assisted_Listening_Stream,
Broadcast_Name, Extended_Metadata and Vendor_Specific.

Assisted-by: OpenCode:claude-opus-5.5
---
 src/shared/bap-debug.c | 209 ++++++++++++++++++++++++++++++++++++++---
 src/shared/bap-defs.h  |  52 ++++++++++
 src/shared/bap.c       |  33 +++----
 3 files changed, 259 insertions(+), 35 deletions(-)

diff --git a/src/shared/bap-debug.c b/src/shared/bap-debug.c
index 495a22c44126..47a574d41d6c 100644
--- a/src/shared/bap-debug.c
+++ b/src/shared/bap-debug.c
@@ -15,6 +15,7 @@
 #include <errno.h>
 
 #include "src/shared/util.h"
+#include "src/shared/bap-defs.h"
 #include "src/shared/bap-debug.h"
 
 static const struct util_bit_debugger pac_freq_table[] = {
@@ -185,11 +186,11 @@ done:
 }
 
 static const struct util_ltv_debugger pac_cap_table[] = {
-	UTIL_LTV_DEBUG(0x01, pac_debug_freq),
-	UTIL_LTV_DEBUG(0x02, pac_debug_duration),
-	UTIL_LTV_DEBUG(0x03, pac_debug_channels),
-	UTIL_LTV_DEBUG(0x04, pac_debug_frame_length),
-	UTIL_LTV_DEBUG(0x05, pac_debug_sdu)
+	UTIL_LTV_DEBUG(BT_BAP_CAP_FREQ, pac_debug_freq),
+	UTIL_LTV_DEBUG(BT_BAP_CAP_DURATION, pac_debug_duration),
+	UTIL_LTV_DEBUG(BT_BAP_CAP_CHANNELS, pac_debug_channels),
+	UTIL_LTV_DEBUG(BT_BAP_CAP_FRAME_LENGTH, pac_debug_frame_length),
+	UTIL_LTV_DEBUG(BT_BAP_CAP_SDU, pac_debug_sdu)
 };
 
 bool bt_bap_debug_caps(void *data, size_t len, util_debug_func_t func,
@@ -414,11 +415,11 @@ done:
 }
 
 static const struct util_ltv_debugger ase_cc_table[] = {
-	UTIL_LTV_DEBUG(0x01, ase_debug_freq),
-	UTIL_LTV_DEBUG(0x02, ase_debug_duration),
-	UTIL_LTV_DEBUG(0x03, ase_debug_location),
-	UTIL_LTV_DEBUG(0x04, ase_debug_frame_length),
-	UTIL_LTV_DEBUG(0x05, ase_debug_blocks)
+	UTIL_LTV_DEBUG(BT_BAP_CC_FREQ, ase_debug_freq),
+	UTIL_LTV_DEBUG(BT_BAP_CC_DURATION, ase_debug_duration),
+	UTIL_LTV_DEBUG(BT_BAP_CC_LOCATION, ase_debug_location),
+	UTIL_LTV_DEBUG(BT_BAP_CC_FRAME_LENGTH, ase_debug_frame_length),
+	UTIL_LTV_DEBUG(BT_BAP_CC_SDU, ase_debug_blocks)
 };
 
 bool bt_bap_debug_config(void *data, size_t len, util_debug_func_t func,
@@ -527,11 +528,191 @@ done:
 				user_data);
 }
 
+static void debug_string(const char *label, const uint8_t *data,
+				uint8_t len, util_debug_func_t func,
+				void *user_data)
+{
+	util_debug(func, user_data, "%s: %.*s", label, len, (const char *)data);
+}
+
+static void ase_debug_ccid_list(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	uint8_t i;
+
+	util_debug(func, user_data, "CCID List: %u entries", len);
+
+	for (i = 0; i < len; i++)
+		util_debug(func, user_data, "\tCCID: %u", data[i]);
+}
+
+static void ase_debug_parental_rating(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	switch (value & 0x0f) {
+	case 0x00:
+		util_debug(func, user_data,
+				"Parental Rating: No rating (0x%2.2x)", value);
+		break;
+	case 0x01:
+		util_debug(func, user_data,
+				"Parental Rating: Any age (0x%2.2x)", value);
+		break;
+	default:
+		util_debug(func, user_data,
+				"Parental Rating: Age %u or older (0x%2.2x)",
+				(value & 0x0f) + 3, value);
+		break;
+	}
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_program_info_uri(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	debug_string("Program Info URI", data, len, func, user_data);
+}
+
+static void ase_debug_audio_active_state(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	switch (value) {
+	case 0x00:
+		util_debug(func, user_data,
+				"Audio Active State: No audio data (0x00)");
+		break;
+	case 0x01:
+		util_debug(func, user_data,
+				"Audio Active State: Audio data (0x01)");
+		break;
+	default:
+		util_debug(func, user_data,
+				"Audio Active State: RFU (0x%2.2x)", value);
+		break;
+	}
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_bcast_immediate(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	util_debug(func, user_data, "Broadcast Audio Immediate Rendering");
+
+	if (len)
+		util_hexdump(' ', data, len, func, user_data);
+}
+
+static void ase_debug_assisted_listening(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint8_t value;
+
+	if (!util_iov_pull_u8(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	if (value == 0x00)
+		util_debug(func, user_data, "Assisted Listening Stream: "
+				"Unspecified audio enhancement (0x00)");
+	else
+		util_debug(func, user_data,
+				"Assisted Listening Stream: RFU (0x%2.2x)",
+				value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_broadcast_name(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	debug_string("Broadcast Name", data, len, func, user_data);
+}
+
+static void ase_debug_extended(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint16_t value;
+
+	if (!util_iov_pull_le16(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Extended Metadata Type: 0x%4.4x", value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
+static void ase_debug_vendor(const uint8_t *data, uint8_t len,
+				util_debug_func_t func, void *user_data)
+{
+	struct iovec frame = { (void *)data, len };
+	uint16_t value;
+
+	if (!util_iov_pull_le16(&frame, &value)) {
+		util_debug(func, user_data, "value: invalid size");
+		goto done;
+	}
+
+	util_debug(func, user_data, "Company ID: 0x%4.4x", value);
+
+done:
+	if (frame.iov_len)
+		util_hexdump(' ', frame.iov_base, frame.iov_len, func,
+				user_data);
+}
+
 static const struct util_ltv_debugger ase_metadata_table[] = {
-	UTIL_LTV_DEBUG(0x01, ase_debug_preferred_context),
-	UTIL_LTV_DEBUG(0x02, ase_debug_context),
-	UTIL_LTV_DEBUG(0x03, ase_debug_program_info),
-	UTIL_LTV_DEBUG(0x04, ase_debug_language)
+	UTIL_LTV_DEBUG(BT_BAP_META_PREFERRED_CONTEXT,
+					ase_debug_preferred_context),
+	UTIL_LTV_DEBUG(BT_BAP_META_CONTEXT, ase_debug_context),
+	UTIL_LTV_DEBUG(BT_BAP_META_PROGRAM_INFO, ase_debug_program_info),
+	UTIL_LTV_DEBUG(BT_BAP_META_LANGUAGE, ase_debug_language),
+	UTIL_LTV_DEBUG(BT_BAP_META_CCID_LIST, ase_debug_ccid_list),
+	UTIL_LTV_DEBUG(BT_BAP_META_PARENTAL_RATING, ase_debug_parental_rating),
+	UTIL_LTV_DEBUG(BT_BAP_META_PROGRAM_INFO_URI,
+					ase_debug_program_info_uri),
+	UTIL_LTV_DEBUG(BT_BAP_META_AUDIO_ACTIVE_STATE,
+					ase_debug_audio_active_state),
+	UTIL_LTV_DEBUG(BT_BAP_META_BCAST_IMMEDIATE, ase_debug_bcast_immediate),
+	UTIL_LTV_DEBUG(BT_BAP_META_ASSISTED_LISTENING,
+					ase_debug_assisted_listening),
+	UTIL_LTV_DEBUG(BT_BAP_META_BROADCAST_NAME, ase_debug_broadcast_name),
+	UTIL_LTV_DEBUG(BT_BAP_META_EXTENDED, ase_debug_extended),
+	UTIL_LTV_DEBUG(BT_BAP_META_VENDOR, ase_debug_vendor)
 };
 
 bool bt_bap_debug_metadata(void *data, size_t len, util_debug_func_t func,
diff --git a/src/shared/bap-defs.h b/src/shared/bap-defs.h
index e5c2accb99f7..d232c21410c1 100644
--- a/src/shared/bap-defs.h
+++ b/src/shared/bap-defs.h
@@ -39,6 +39,58 @@
 #define BT_BAP_CONFIG_PHY_2M		BIT(1)
 #define BT_BAP_CONFIG_PHY_CODEC		BIT(2)
 
+/* Assigned Numbers 6.12.4 Codec_Specific_Capabilities LTV structures */
+/* Supported_Sampling_Frequencies */
+#define BT_BAP_CAP_FREQ			0x01
+/* Supported_Frame_Durations */
+#define BT_BAP_CAP_DURATION		0x02
+/* Supported_Audio_Channel_Counts */
+#define BT_BAP_CAP_CHANNELS		0x03
+/* Supported_Octets_Per_Codec_Frame */
+#define BT_BAP_CAP_FRAME_LENGTH		0x04
+/* Supported_Max_Codec_Frames_Per_SDU */
+#define BT_BAP_CAP_SDU			0x05
+
+/* Assigned Numbers 6.12.5 Codec_Specific_Configuration LTV structures */
+/* Sampling_Frequency */
+#define BT_BAP_CC_FREQ			0x01
+/* Frame_Duration */
+#define BT_BAP_CC_DURATION		0x02
+/* Audio_Channel_Allocation */
+#define BT_BAP_CC_LOCATION		0x03
+/* Octets_Per_Codec_Frame */
+#define BT_BAP_CC_FRAME_LENGTH		0x04
+/* Codec_Frame_Blocks_Per_SDU */
+#define BT_BAP_CC_SDU			0x05
+
+/* Assigned Numbers 6.12.6 Metadata LTV structures */
+/* Preferred_Audio_Contexts */
+#define BT_BAP_META_PREFERRED_CONTEXT	0x01
+/* Streaming_Audio_Contexts */
+#define BT_BAP_META_CONTEXT		0x02
+/* Program_Info */
+#define BT_BAP_META_PROGRAM_INFO	0x03
+/* Language */
+#define BT_BAP_META_LANGUAGE		0x04
+/* CCID_List */
+#define BT_BAP_META_CCID_LIST		0x05
+/* Parental_Rating */
+#define BT_BAP_META_PARENTAL_RATING	0x06
+/* Program_Info_URI */
+#define BT_BAP_META_PROGRAM_INFO_URI	0x07
+/* Audio_Active_State */
+#define BT_BAP_META_AUDIO_ACTIVE_STATE	0x08
+/* Broadcast_Audio_Immediate_Rendering_Flag */
+#define BT_BAP_META_BCAST_IMMEDIATE	0x09
+/* Assisted_Listening_Stream */
+#define BT_BAP_META_ASSISTED_LISTENING	0x0a
+/* Broadcast_Name */
+#define BT_BAP_META_BROADCAST_NAME	0x0b
+/* Extended_Metadata */
+#define BT_BAP_META_EXTENDED		0xfe
+/* Vendor_Specific */
+#define BT_BAP_META_VENDOR		0xff
+
 struct bt_bap_codec {
 	uint8_t  id;
 	uint16_t cid;
diff --git a/src/shared/bap.c b/src/shared/bap.c
index a6f5494e2985..d1836afc9ad2 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -49,19 +49,10 @@
 
 #define BAP_PROCESS_TIMEOUT 10
 
-#define BAP_FREQ_LTV_TYPE 1
-#define BAP_DURATION_LTV_TYPE 2
-#define BAP_CHANNEL_ALLOCATION_LTV_TYPE 3
-#define BAP_FRAME_LEN_LTV_TYPE 4
 #define CODEC_SPECIFIC_CONFIGURATION_MASK (\
-		(1<<BAP_FREQ_LTV_TYPE)|\
-		(1<<BAP_DURATION_LTV_TYPE)|\
-		(1<<BAP_FRAME_LEN_LTV_TYPE))
-
-#define BAP_METADATA_PREF_CONTEXT_LTV_TYPE	0x01
-#define BAP_METADATA_CONTEXT_LTV_TYPE		0x02
-#define BAP_METADATA_PROGRAM_INFO_LTV_TYPE	0x03
-#define BAP_METADATA_LANGUAGE_LTV_TYPE		0x04
+		(1<<BT_BAP_CC_FREQ)|\
+		(1<<BT_BAP_CC_DURATION)|\
+		(1<<BT_BAP_CC_FRAME_LENGTH))
 
 struct bt_bap_pac_changed {
 	unsigned int id;
@@ -2569,7 +2560,7 @@ static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
 
 static unsigned int bap_bcast_get_location(struct bt_bap_stream *stream)
 {
-	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+	uint8_t type = BT_BAP_CC_LOCATION;
 	uint32_t allocation = 0;
 	struct iovec *caps;
 
@@ -3432,9 +3423,9 @@ static void bap_metadata_process(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	uint16_t context;
 
 	switch (t) {
-	case BAP_METADATA_PREF_CONTEXT_LTV_TYPE:
+	case BT_BAP_META_PREFERRED_CONTEXT:
 		break;
-	case BAP_METADATA_CONTEXT_LTV_TYPE:
+	case BT_BAP_META_CONTEXT:
 		if (l != sizeof(context)) {
 			ascs_ase_rsp_add(data->rsp, data->ep->id,
 					BT_ASCS_RSP_METADATA_INVALID, t);
@@ -3450,8 +3441,8 @@ static void bap_metadata_process(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 		}
 
 		break;
-	case BAP_METADATA_PROGRAM_INFO_LTV_TYPE:
-	case BAP_METADATA_LANGUAGE_LTV_TYPE:
+	case BT_BAP_META_PROGRAM_INFO:
+	case BT_BAP_META_LANGUAGE:
 		break;
 	default:
 		ascs_ase_rsp_add(data->rsp, data->ep->id,
@@ -7649,17 +7640,17 @@ static void check_pac_caps_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	uint16_t frame_len;
 
 	switch (t) {
-	case BAP_FREQ_LTV_TYPE:
+	case BT_BAP_CAP_FREQ:
 		mask = get_le16(v);
 
 		if (mask & (1 << (bis_v[0] - 1)))
 			compare_data->data32 |= 1<<t;
 		break;
-	case BAP_DURATION_LTV_TYPE:
+	case BT_BAP_CAP_DURATION:
 		if ((v[0]) & (1 << bis_v[0]))
 			compare_data->data32 |= 1<<t;
 		break;
-	case BAP_FRAME_LEN_LTV_TYPE:
+	case BT_BAP_CAP_FRAME_LENGTH:
 		min = get_le16(v);
 		max = get_le16(v + 2);
 		frame_len = get_le16(bis_v);
@@ -7798,7 +7789,7 @@ static struct bt_ltv_match bap_check_bis(uint32_t sink_loc, struct queue *pacs,
 	compare_data.found = true;
 
 	if (sink_loc) {
-		uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+		uint8_t type = BT_BAP_CC_LOCATION;
 
 		compare_data.data32 = sink_loc;
 		util_ltv_foreach(bis_data->iov_base, bis_data->iov_len, &type,
-- 
2.56.0

