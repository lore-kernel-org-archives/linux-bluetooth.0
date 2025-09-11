Received: from aer-iport-1.cisco.com (aer-iport-1.cisco.com [173.38.203.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D51E3451B5
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 15:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757604066; cv=none; b=PAkl6e10kg9eL4eLEEhcoCnAoy3k2NjuLkPw/3PxsdZt8axmmKiLg+iXAtjqVv8F7+5T5/CzqMIcg5xKSPzS81kenp/kXk+VuwVlRS0YpC44RZLBY03DEFDhef3nATGuYimGt35JyhRu2/ZTq9HTgISHrZf4Za0c9ZAR3oJnwgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757604066; c=relaxed/simple;
	bh=GmWQ2cC78k8dBm9WhtyeuPj+/2u1zlCxHsqH36CT3AU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qi0e2SjZyQyeIBfOTQhkNCl00eit0D4TDxr7x8dbfZP8PbGJ/uOuPZMi6XZPKYSEyuzDKPHJooJMUXuMj8kD8hS5jPrhL0kI/QpJGg26eGEdFSRTqqV6v5OwUVTFc7P0Myet61oc7YS3Kz9hx8p/kh/b00QqWyvDrRCA5TQIh9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=j2EtNV0X; arc=none smtp.client-ip=173.38.203.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="j2EtNV0X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=10327; q=dns/txt;
  s=iport01; t=1757604064; x=1758813664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fdoiArv54gby7xNila4/x8HcMX9RRt5YEnYl8gs1ivs=;
  b=j2EtNV0XIstoILwVzrcwQIHMISXZ+9mRNYvjdbMgYwUe5GlpYOx0uIyW
   HqWRN4kAbJRU16VTBWvftFkKeqhMf0Ju+BberPtHqrplpy9flNbBzuMnA
   BnyUd9/TZi+Ykn+X9e3xGrItMuDmDTYTeKnXG5G56jrjb18MTkpm/oFxD
   PiU3k32gm5HD5hIADEEDpO7eOihxVqYbt7/hAJtCSRATYGJ3pOyauqvNl
   q3AB4yKTya16rRivDvHoalbb5njl5j1r5VWcqHyHar3jTMGjBKakrutNd
   jqPamLH43ilu5tbjxSV4BC3PKwGRB5t9Kq6Mzht9bPxK7g0ijUX98jYwS
   g==;
X-CSE-ConnectionGUID: wsniuqfZQN6a+cXgjjK2YQ==
X-CSE-MsgGUID: 197kjqbVTE+ktspAi38cNw==
X-IPAS-Result: =?us-ascii?q?A0AaAADy58Jo/9NK/pBaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBggAEAQEBAQsBgkZsaEOXDp4dgX8PAQEBD1EEAQGFB4wxAiY1C?=
 =?us-ascii?q?A4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBYEOE4Zchl0rCwFGg?=
 =?us-ascii?q?SaDLIJzA7BqgXkzgQGEfNoBgSmBSQGNTHCEdycbgg2BFYE7gT5viwcEgziIF?=
 =?us-ascii?q?4gZg3qHWkiBHgNZLAFVEw0KCwcFgWMDNQwLLhUyPDIdgSeFDYQdK0+FAoRqJ?=
 =?us-ascii?q?GsPBoEVg1sGhHxAAwsYDUgRLDcUGwY+bgeYPgEtThSCExoxBwOTAiQBkBuDV?=
 =?us-ascii?q?p9ZhCahVxozhASmZ5kGglihMFCEaYFqATmBWXAVgyNRGQ+OLRYcvWtEbgIHC?=
 =?us-ascii?q?wEBAwmCOY8xBIF5AQE?=
IronPort-Data: A9a23:bNYJtaD+tqLT0hVW/2riw5YqxClBgxIJ4kV8jS/XYbTApGkkhGQHn
 DEWCGjSPPnZZWv2etx1btu28EwE6MODzNUwOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZuCCaF/H9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gU2thh
 fuo+5eCYA78gmYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TE3O5oDVwvM78h3Lh+Qmp++
 v4aC2o8V0XW7w626OrTpuhEj8k5ac2uN4QFtzQ5lXfSDO0tRtbIRKCiCd1whWtswJoTQbCBO
 4xDMGMHgBfoO3WjPn8PF5s3k+CAjXjkeDoeo1WQzUYyyzOIk1Isi+SzWDbTUoXbGsZXh0ymm
 k+F/HjiGjgbb4yU7yXQpxpAgceKx0sXQrk6ELy+6+4vilmOy3AUDwEWfUW0rOP/iUOkXd9bb
 UsO9UITQbMa/UGxC924VBqirTvd5lgXWsFbFKsx7wTlJrfo3jt1z1MsFlZpAOHKfudvLdD2/
 jdlR+/UOAE=
IronPort-HdrOrdr: A9a23:1i+UOK/oDetoIRcY3nBuk+DRI+orL9Y04lQ7vn2ZhyY4TiX+rb
 HNoB1173HJYVoqMk3I+urwW5VoI0m8yXcd2+B4VotKNzOIhILHFuxfBPPZowEJ30bFh4pgPW
 AKSdkaNOHN
X-Talos-CUID: =?us-ascii?q?9a23=3A+PD1XGttrLkiHiXosfwR/OOw6Is6aXvc0W7eEXa?=
 =?us-ascii?q?eV28qQ42aS12zopJdxp8=3D?=
X-Talos-MUID: 9a23:mmzuQwUuB4zSJInq/Ga92zJgLc1W34ntC1wWibwH4JmPEzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="33765346"
Received: from aer-l-core-10.cisco.com ([144.254.74.211])
  by aer-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2025 15:19:53 +0000
Received: from pwaago-l-systems.rd.cisco.com (unknown [10.47.92.97])
	by aer-l-core-10.cisco.com (Postfix) with ESMTP id 721CF180001DC;
	Thu, 11 Sep 2025 15:19:53 +0000 (GMT)
From: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
Subject: [PATCH BlueZ v2 1/2] audio: Add support for specific error codes for A2DP configuration
Date: Thu, 11 Sep 2025 17:19:29 +0200
Message-ID: <20250911151930.1632922-1-pwaago@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.92.97, [10.47.92.97]
X-Outbound-Node: aer-l-core-10.cisco.com

The A2DP specification defines error codes that shall be used if
the codec capabilities contain improper settings. This change allows
clients to trigger the sending of these specific error codes by
returning the corresponding error messages from
MediaEndpoint1.SetConfiguration.

This update is fully backwards compatible: clients passing other error
messages will continue to receive the default error code as before. On
older BlueZ versions, these new errors will also result in the default
error code, enabling clients to implement support for the new errors
without breaking compatibility.

This change enables passing A2DP/SNK/AVP/* and A2DP/SRC/AVP/*
qualification tests.
---
 profiles/audio/a2dp.c  | 78 ++++++++++++++++++++++++++++++++++++++----
 profiles/audio/a2dp.h  | 43 ++++++++++++++++++++++-
 profiles/audio/avdtp.c |  4 +--
 profiles/audio/media.c | 20 ++++++-----
 4 files changed, 128 insertions(+), 17 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index c0a53eae9..661843a89 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -157,6 +157,73 @@ static GSList *servers = NULL;
 static GSList *setups = NULL;
 static unsigned int cb_id = 0;
 
+struct a2dp_error {
+	const char *error_name;
+	uint8_t error_code;
+};
+
+#define A2DP_ERROR_PREFIX ERROR_INTERFACE ".A2DP."
+
+static struct a2dp_error config_errors[] = {
+	{"InvalidCodecType", A2DP_INVALID_CODEC_TYPE},
+	{"NotSupportedCodecType", A2DP_NOT_SUPPORTED_CODEC_TYPE},
+	{"InvalidSamplingFrequency", A2DP_INVALID_SAMPLING_FREQUENCY},
+	{"NotSupportedSamplingFrequency",
+				A2DP_NOT_SUPPORTED_SAMPLING_FREQUENCY},
+	{"InvalidChannelMode", A2DP_INVALID_CHANNEL_MODE},
+	{"NotSupportedChannelMode", A2DP_NOT_SUPPORTED_CHANNEL_MODE},
+	{"InvalidSubbands", A2DP_INVALID_SUBBANDS},
+	{"NotSupportedSubbands", A2DP_NOT_SUPPORTED_SUBBANDS},
+	{"InvalidAllocationMethod", A2DP_INVALID_ALLOCATION_METHOD},
+	{"NotSupportedAllocationMethod", A2DP_NOT_SUPPORTED_ALLOCATION_METHOD},
+	{"InvalidMinimumBitpoolValue",
+				A2DP_INVALID_MINIMUM_BITPOOL_VALUE},
+	{"NotSupportedMinimumBitpoolValue",
+				A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALUE},
+	{"InvalidMaximumBitpoolValue", A2DP_INVALID_MAXIMUM_BITPOOL_VALUE},
+	{"NotSupportedMaximumBitpoolValue",
+				A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE},
+	{"InvalidInvalidLayer", A2DP_INVALID_INVALID_LAYER},
+	{"NotSupportedLayer", A2DP_NOT_SUPPORTED_LAYER},
+	{"NotSupporterdCRC", A2DP_NOT_SUPPORTERD_CRC},
+	{"NotSupporterdMPF", A2DP_NOT_SUPPORTERD_MPF},
+	{"NotSupporterdVBR", A2DP_NOT_SUPPORTERD_VBR},
+	{"InvalidBitRate", A2DP_INVALID_BIT_RATE},
+	{"NotSupportedBitRate", A2DP_NOT_SUPPORTED_BIT_RATE},
+	{"InvalidObjectType", A2DP_INVALID_OBJECT_TYPE},
+	{"NotSupportedObjectType", A2DP_NOT_SUPPORTED_OBJECT_TYPE},
+	{"InvalidChannels", A2DP_INVALID_CHANNELS},
+	{"NotSupportedChannels", A2DP_NOT_SUPPORTED_CHANNELS},
+	{"InvalidVersion", A2DP_INVALID_VERSION},
+	{"NotSupportedVersion", A2DP_NOT_SUPPORTED_VERSION},
+	{"NotSupportedMaximumSUL", A2DP_NOT_SUPPORTED_MAXIMUM_SUL},
+	{"InvalidBlockLength", A2DP_INVALID_BLOCK_LENGTH},
+	{"InvalidCPType", A2DP_INVALID_CP_TYPE},
+	{"InvalidCPFormat", A2DP_INVALID_CP_FORMAT},
+	{"InvalidCodecParameter", A2DP_INVALID_CODEC_PARAMETER},
+	{"NotSupportedCodecParameter", A2DP_NOT_SUPPORTED_CODEC_PARAMETER},
+	{"InvalidDRC", A2DP_INVALID_DRC},
+	{"NotSupportedDRC", A2DP_NOT_SUPPORTED_DRC}
+};
+
+uint8_t a2dp_parse_config_error(const char *error_name)
+{
+	size_t prefix_length;
+	size_t i;
+
+	prefix_length = strlen(A2DP_ERROR_PREFIX);
+	if (strncmp(A2DP_ERROR_PREFIX, error_name, prefix_length))
+		return AVDTP_UNSUPPORTED_CONFIGURATION;
+
+	error_name += prefix_length;
+	for (i = 0; i < ARRAY_SIZE(config_errors); i++) {
+		if (strcmp(config_errors[i].error_name, error_name) == 0)
+			return config_errors[i].error_code;
+	}
+
+	return AVDTP_UNSUPPORTED_CONFIGURATION;
+}
+
 static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
 {
 	setup->ref++;
@@ -688,11 +755,10 @@ done:
 	return FALSE;
 }
 
-static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
+static void endpoint_setconf_cb(struct a2dp_setup *setup, uint8_t error_code)
 {
-	if (ret == FALSE)
-		setup_error_init(setup, AVDTP_MEDIA_CODEC,
-					AVDTP_UNSUPPORTED_CONFIGURATION);
+	if (error_code != 0)
+		setup_error_init(setup, AVDTP_MEDIA_CODEC, error_code);
 
 	auto_config(setup);
 	setup_unref(setup);
@@ -865,11 +931,11 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static void endpoint_open_cb(struct a2dp_setup *setup, gboolean ret)
+static void endpoint_open_cb(struct a2dp_setup *setup, uint8_t error_code)
 {
 	int err = error_to_errno(setup->err);
 
-	if (ret == FALSE) {
+	if (error_code != 0) {
 		setup->stream = NULL;
 		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
 		goto done;
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index c698bc983..bcdb4d43f 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -15,7 +15,8 @@ struct a2dp_setup;
 
 typedef void (*a2dp_endpoint_select_t) (struct a2dp_setup *setup, void *ret,
 					int size);
-typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup, gboolean ret);
+typedef void (*a2dp_endpoint_config_t) (struct a2dp_setup *setup,
+					uint8_t error_code);
 
 struct a2dp_endpoint {
 	const char *(*get_name) (struct a2dp_sep *sep, void *user_data);
@@ -70,6 +71,8 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_config_cb_t cb, GSList *caps,
 				void *user_data);
+uint8_t a2dp_parse_config_error(const char *error_name);
+
 unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
 unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
@@ -83,3 +86,41 @@ struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep,
 struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup);
 const char *a2dp_setup_remote_path(struct a2dp_setup *setup);
 struct avdtp *a2dp_avdtp_get(struct btd_device *device);
+
+enum a2dp_error_codes {
+	A2DP_INVALID_CODEC_TYPE = 0xc1,
+	A2DP_NOT_SUPPORTED_CODEC_TYPE = 0xc2,
+	A2DP_INVALID_SAMPLING_FREQUENCY = 0xc3,
+	A2DP_NOT_SUPPORTED_SAMPLING_FREQUENCY = 0xc4,
+	A2DP_INVALID_CHANNEL_MODE = 0xc5,
+	A2DP_NOT_SUPPORTED_CHANNEL_MODE = 0xc6,
+	A2DP_INVALID_SUBBANDS = 0xc7,
+	A2DP_NOT_SUPPORTED_SUBBANDS = 0xc8,
+	A2DP_INVALID_ALLOCATION_METHOD = 0xc9,
+	A2DP_NOT_SUPPORTED_ALLOCATION_METHOD = 0xca,
+	A2DP_INVALID_MINIMUM_BITPOOL_VALUE = 0xcb,
+	A2DP_NOT_SUPPORTED_MINIMUM_BITPOOL_VALUE = 0xcc,
+	A2DP_INVALID_MAXIMUM_BITPOOL_VALUE = 0xcd,
+	A2DP_NOT_SUPPORTED_MAXIMUM_BITPOOL_VALUE = 0xce,
+	A2DP_INVALID_INVALID_LAYER = 0xcf,
+	A2DP_NOT_SUPPORTED_LAYER = 0xd0,
+	A2DP_NOT_SUPPORTERD_CRC = 0xd1,
+	A2DP_NOT_SUPPORTERD_MPF = 0xd2,
+	A2DP_NOT_SUPPORTERD_VBR = 0xd3,
+	A2DP_INVALID_BIT_RATE = 0xd4,
+	A2DP_NOT_SUPPORTED_BIT_RATE = 0xd5,
+	A2DP_INVALID_OBJECT_TYPE = 0xd6,
+	A2DP_NOT_SUPPORTED_OBJECT_TYPE = 0xd7,
+	A2DP_INVALID_CHANNELS = 0xd8,
+	A2DP_NOT_SUPPORTED_CHANNELS = 0xd9,
+	A2DP_INVALID_VERSION = 0xda,
+	A2DP_NOT_SUPPORTED_VERSION = 0xdb,
+	A2DP_NOT_SUPPORTED_MAXIMUM_SUL = 0xdc,
+	A2DP_INVALID_BLOCK_LENGTH = 0xdd,
+	A2DP_INVALID_CP_TYPE = 0xe0,
+	A2DP_INVALID_CP_FORMAT = 0xe1,
+	A2DP_INVALID_CODEC_PARAMETER = 0xe2,
+	A2DP_NOT_SUPPORTED_CODEC_PARAMETER = 0xe3,
+	A2DP_INVALID_DRC = 0xe4,
+	A2DP_NOT_SUPPORTED_DRC = 0xe5,
+};
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index 30648251f..ed4e22b26 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1494,8 +1494,8 @@ static void setconf_cb(struct avdtp *session, struct avdtp_stream *stream,
 	struct conf_rej rej;
 
 	if (err != NULL) {
-		rej.error = AVDTP_UNSUPPORTED_CONFIGURATION;
-		rej.category = err->err.error_code;
+		rej.error = err->err.error_code;
+		rej.category = AVDTP_UNSUPPORTED_CONFIGURATION;
 		avdtp_send(session, session->in_cmd.transaction,
 			   AVDTP_MSG_TYPE_REJECT, AVDTP_SET_CONFIGURATION,
 			   &rej, sizeof(rej));
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 9b3042c18..332f643bb 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -333,7 +333,7 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 	DBusMessage *reply;
 	DBusMessageIter args, props;
 	DBusError err;
-	gboolean value;
+	uint8_t error_code;
 	void *ret = NULL;
 	int size = -1;
 
@@ -356,8 +356,12 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 
 		if (dbus_message_is_method_call(request->msg,
 					MEDIA_ENDPOINT_INTERFACE,
-					"SetConfiguration"))
+					"SetConfiguration")) {
 			endpoint_remove_transport(endpoint, request->transport);
+			error_code = a2dp_parse_config_error(err.name);
+			ret = &error_code;
+			size = 1;
+		}
 
 		dbus_error_free(&err);
 		goto done;
@@ -390,8 +394,8 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 	}
 
 	size = 1;
-	value = TRUE;
-	ret = &value;
+	error_code = 0;
+	ret = &error_code;
 
 done:
 	dbus_message_unref(reply);
@@ -634,9 +638,9 @@ static void config_cb(struct media_endpoint *endpoint, void *ret, int size,
 							void *user_data)
 {
 	struct a2dp_config_data *data = user_data;
-	gboolean *ret_value = ret;
+	uint8_t *ret_value = ret;
 
-	data->cb(data->setup, ret_value ? *ret_value : FALSE);
+	data->cb(data->setup, ret_value ? *ret_value : 1);
 }
 
 static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
@@ -1098,7 +1102,7 @@ static void pac_config_cb(struct media_endpoint *endpoint, void *ret, int size,
 							void *user_data)
 {
 	struct pac_config_data *data = user_data;
-	gboolean *ret_value = ret;
+	uint8_t *error_code = ret;
 	struct media_transport *transport;
 
 	/* If transport was cleared, configuration was cancelled */
@@ -1106,7 +1110,7 @@ static void pac_config_cb(struct media_endpoint *endpoint, void *ret, int size,
 	if (!transport)
 		return;
 
-	data->cb(data->stream, ret_value ? 0 : -EINVAL);
+	data->cb(data->stream, error_code == 0 ? 0 : -EINVAL);
 }
 
 static struct media_transport *pac_ucast_config(struct bt_bap_stream *stream,
-- 
2.43.0

