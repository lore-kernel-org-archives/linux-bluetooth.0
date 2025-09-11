Received: from aer-iport-7.cisco.com (aer-iport-7.cisco.com [173.38.203.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD853375B1
	for <linux-bluetooth@vger.kernel.org>; Thu, 11 Sep 2025 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.38.203.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598860; cv=none; b=tQpOxqbq2isterCF5/fvzhgEFQ7StdE8pSl3XWQJ1moHLtEDPOj0AAnNlteXK5GL273zjm7vgRU2fpz4DfA0ic/Wr8L9Qzek1BTb357pea59dOgQkJVnU7YjIaqVN7kXAT+/q95Zpq/fklKtam2gh0Rljy/4k/pSdyDQl2JkpSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598860; c=relaxed/simple;
	bh=Sae9JR2qhcRmswAaY3y+4cq0QwEdgpvCztJIMEY2oAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uvxRrhlpZZRO7Mk2yrITSpa5QeKVVg/nGOj/xiBREFpW3AmmewrQZTkrfgHf1BIhkDmV7LYQOHjsA1MH8SgoPOOdbxgLKAbTRU1jXa6qAtTUtm1ls/QSjCKtNLWotf4N1iE2qu6IF/IiZgqu/XW9N3GfNy8WqNqjNzVwntLxSSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=JoFCNtuD; arc=none smtp.client-ip=173.38.203.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="JoFCNtuD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=12636; q=dns/txt;
  s=iport01; t=1757598857; x=1758808457;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BDdsw0CEzr/gA8kMtaBbcsVLzTOB8kWfO74ckAJuXiE=;
  b=JoFCNtuDIrzmCATDmrh7eBCssPb+EBKOZBKjdZvOKDp2bpdDnUooakHa
   8b7ZXmvDt0l+2fmhBzUAGzLJ3F5w9snFwPnOt91oVwXEU+jBExwNI5FmH
   +c7Gy/Qc02Gqw8gpDGZxiTJgOfa6V3/1dKWy7MgdaAya/GyDa2PPPjJxy
   YAA3mdBgEkXdgx0zHTacqk2A10eKOgDtXHw1VxqSysHrKkw0VPuB2G5+P
   nD4YXFZ9YVx6j0mtSg3TJ34hqNIE/fFB+Fp1gpdxDkR0IluUyo/hDFh+/
   CQ3GcyVAg8/dXoSnIC1xt/4Re3z8DwO7F7MNb1BnMFlG2EKgLUOcs1OYg
   A==;
X-CSE-ConnectionGUID: 8forBrnlSGeQzHQQCW7HBQ==
X-CSE-MsgGUID: h3B08TsORsm0xNwM1VITgg==
X-IPAS-Result: =?us-ascii?q?A0ARAACC08Jo/9NK/pBaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgX8FAQEBAQsBgkZsaEONOYlVnh2Bfw8BAQEPUQQBAYUHjDECJ?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBAQECAQcFgQ4ThlyGXSsLA?=
 =?us-ascii?q?UaBJoMsgnMDsEWBeTOBAYR82gGBKYFJAY1McIR3JxuCDYEVgTuBPm+LBwSDO?=
 =?us-ascii?q?IgXiBmDeodaSIEeA1ksAVUTDQoLBwWBYwM1DAsuFTI8Mh2BJ4UNhB0rT4UCh?=
 =?us-ascii?q?Gokaw8GgRWDWwaEfEADCxgNSBEsNxQbBj5uB5g+AS1OFIITGjEHA5MCJAGQG?=
 =?us-ascii?q?4NWn1mEJqFXGjOEBKZnmQaCWKEwUIRpgWg8gVlwFYMjURkPji0WvglEbgIHC?=
 =?us-ascii?q?wEBAwmCOY8xBIF5AQE?=
IronPort-Data: A9a23:soaPFqAvGuIR1xVW/2riw5YqxClBgxIJ4kV8jS/XYbTApD8hhDIFy
 WEaWDqHM62CNGqgKNp3aI62oB8BupfWn9ZmOVdlrnsFo1CmBibm6XV1Cm+qYkt+++WaFBoPA
 /02M4eGdIZuCCaF/H9BC5C5xVFkz6aEW7HgP+DNPyF1VGdMRTwo4f5Zs7ZRbrVA357gU2thh
 fuo+5eCYA78gmYuWo4pw/vrRC1H7ayaVAww5jTSVdgT1HfCmn8cCo4oJK3ZBxPQXolOE+emc
 P3Ixbe/83mx109F5gSNy+uTnuUiG9Y+DCDW4pZkc/HKbitq+kTe5p0G2M80Mi+7vdkmc+dZk
 72hvbToIesg0zaldO41C3G0GAkmVUFKFSOuzXWX6aSuI0P6n3TEk/tpFmssO4kj1etOE0F3z
 NcndxAnV0XW7w626OrTpuhEj8k5ac2uN4QFtzQ5lXfSDO0tRtbIRKCiCd1whWtswJoTQbCBO
 4xDMGMHgBfoO3WjPn8PF5s3k+CAjXjkeDoeo1WQzUYyyzOPkFIqgeK3WDbTUtzRb50Fol2/n
 HnDp3TfHTRDCv2jxjXQpxpAgceKx0sXQrk6ELy+6+4vilmOy3AUDwEWfUW0rOP/iUOkXd9bb
 UsO9UITQbMa/UGxC924VBqirTvd5lgXWsFbFKsx7wTlJrfo3jt1z1MsFlZpAOHKfudvLdD2/
 jdlR+/UOAE=
IronPort-HdrOrdr: A9a23:WHa/GqCPKqWF+TLlHeml55DYdb4zR+YMi2TDGXocdfUzSL37qy
 nAppomPHPP4gr5O0tQ+uxoWpPgfZq0z/ccirX5Vo3MYOCJggaVxflZjbcLB1bbaknDHik379
 YET5RD
X-Talos-CUID: 9a23:cj3DEmyknRdlcZ7HlKq+BgVEFMc/WGfbyEz/LnaqKV9QY4LKaXWprfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AmeENdQz7fK/qgLXMoPTviSNYGxyaqKT1IhhdrY4?=
 =?us-ascii?q?hgdKBbTxWJBLEshWLTYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.18,257,1751241600"; 
   d="scan'208";a="34463922"
Received: from aer-l-core-10.cisco.com ([144.254.74.211])
  by aer-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 11 Sep 2025 13:53:05 +0000
Received: from pwaago-l-systems.rd.cisco.com (unknown [10.47.92.97])
	by aer-l-core-10.cisco.com (Postfix) with ESMTP id 78D3218000330;
	Thu, 11 Sep 2025 13:53:05 +0000 (GMT)
From: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
Subject: [PATCH BlueZ] audio: Add support for specific error codes for A2DP configuration
Date: Thu, 11 Sep 2025 15:53:01 +0200
Message-ID: <20250911135301.1538126-1-pwaago@cisco.com>
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
 doc/org.bluez.MediaEndpoint.rst | 37 ++++++++++++++++
 profiles/audio/a2dp.c           | 78 ++++++++++++++++++++++++++++++---
 profiles/audio/a2dp.h           |  5 ++-
 profiles/audio/avdtp.c          |  4 +-
 profiles/audio/media.c          | 20 +++++----
 src/error.h                     | 38 ++++++++++++++++
 6 files changed, 165 insertions(+), 17 deletions(-)

diff --git a/doc/org.bluez.MediaEndpoint.rst b/doc/org.bluez.MediaEndpoint.rst
index 474cc1160..2721d473e 100644
--- a/doc/org.bluez.MediaEndpoint.rst
+++ b/doc/org.bluez.MediaEndpoint.rst
@@ -54,6 +54,43 @@ be configured and the properties must contain the following properties:
 
 	See **org.bluez.MediaTransport(5)** QoS property.
 
+	Possible errors:
+		:org.bluez.Error.A2DP.InvalidCodecType:
+		:org.bluez.Error.A2DP.NotSupportedCodecType:
+		:org.bluez.Error.A2DP.InvalidSamplingFrequency:
+		:org.bluez.Error.A2DP.NotSupportedSamplingFrequency:
+		:org.bluez.Error.A2DP.InvalidChannelMode:
+		:org.bluez.Error.A2DP.NotSupportedChannelMode:
+		:org.bluez.Error.A2DP.InvalidSubbands:
+		:org.bluez.Error.A2DP.NotSupportedSubbands:
+		:org.bluez.Error.A2DP.InvalidAllocationMethod:
+		:org.bluez.Error.A2DP.NotSupportedAllocationMethod:
+		:org.bluez.Error.A2DP.InvalidMinimumBitpoolValue:
+		:org.bluez.Error.A2DP.NotSupportedMinimumBitpoolValue:
+		:org.bluez.Error.A2DP.InvalidMaximumBitpoolValue:
+		:org.bluez.Error.A2DP.NotSupportedMaximumBitpoolValue:
+		:org.bluez.Error.A2DP.InvalidInvalidLayer:
+		:org.bluez.Error.A2DP.NotSupportedLayer:
+		:org.bluez.Error.A2DP.NotSupporterdCRC:
+		:org.bluez.Error.A2DP.NotSupporterdMPF:
+		:org.bluez.Error.A2DP.NotSupporterdVBR:
+		:org.bluez.Error.A2DP.InvalidBitRate:
+		:org.bluez.Error.A2DP.NotSupportedBitRate:
+		:org.bluez.Error.A2DP.InvalidObjectType:
+		:org.bluez.Error.A2DP.NotSupportedObjectType:
+		:org.bluez.Error.A2DP.InvalidChannels:
+		:org.bluez.Error.A2DP.NotSupportedChannels:
+		:org.bluez.Error.A2DP.InvalidVersion:
+		:org.bluez.Error.A2DP.NotSupportedVersion:
+		:org.bluez.Error.A2DP.NotSupportedMaximumSUL:
+		:org.bluez.Error.A2DP.InvalidBlockLength:
+		:org.bluez.Error.A2DP.InvalidCPType:
+		:org.bluez.Error.A2DP.InvalidCPFormat:
+		:org.bluez.Error.A2DP.InvalidCodecParameter:
+		:org.bluez.Error.A2DP.NotSupportedCodecParameter:
+		:org.bluez.Error.A2DP.InvalidDRC:
+		:org.bluez.Error.A2DP.NotSupportedDRC:
+
 array{byte} SelectConfiguration(array{byte} capabilities)
 `````````````````````````````````````````````````````````
 
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
index c698bc983..afa02c12d 100644
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
diff --git a/src/error.h b/src/error.h
index 47602d39b..8157795c2 100644
--- a/src/error.h
+++ b/src/error.h
@@ -88,3 +88,41 @@ DBusMessage *btd_error_profile_unavailable(DBusMessage *msg);
 DBusMessage *btd_error_failed(DBusMessage *msg, const char *str);
 DBusMessage *btd_error_bredr_errno(DBusMessage *msg, int err);
 DBusMessage *btd_error_le_errno(DBusMessage *msg, int err);
+
+enum a2dp_error_codes : uint8_t {
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
-- 
2.43.0

