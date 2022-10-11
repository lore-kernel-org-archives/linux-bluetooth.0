Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 996B7C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 11 Oct 2022 11:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiJKLa3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 11 Oct 2022 07:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiJKLaY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 11 Oct 2022 07:30:24 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4AC5F99D
        for <linux-bluetooth@vger.kernel.org>; Tue, 11 Oct 2022 04:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665487823; x=1697023823;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=m2R/8BS8Njxpd2e62wIs7c+AOoIgxDK9tSc7Kjq66Tw=;
  b=Z/AdQdnlHWg3OImO0w0ZwJm3jw5Vf5O97jpQrahxajOH2/6nKmig1y9R
   W0ssdwcxKa0PPG9W3tDIvkQoBcvuzIy3t6K7409k6GbY2Es5LFJH3B8Y4
   RS51wpTqIwAboRDCLVXEjbO9QCJigtWJtmoyEWFj7mrw8CFF05IzM83Wi
   gBEClyflZrR4mOMIaM0tSOFUF+o+6Hzhaw/bsPtfTVTpmiS74+JQ5gMBc
   LymXXoU9jwb00SScYJIulS5gTdTXhjBHRGEhVFVST7X/O26Dzndaa8xuu
   w8Ret0hNNfewWmh2oZ7XzYzMgbXsFrirdmvM3gPEctwM9bp86kmzy8Wvo
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="366469725"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="366469725"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2022 04:30:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="577406178"
X-IronPort-AV: E=Sophos;i="5.95,176,1661842800"; 
   d="scan'208";a="577406178"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by orsmga003.jf.intel.com with ESMTP; 11 Oct 2022 04:30:15 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v3 1/3] audio/transport: Adding volume callback to media transport
Date:   Tue, 11 Oct 2022 17:01:14 +0530
Message-Id: <20221011113116.70514-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Initialize set_volume and get_volume to media transport and update the
volume when media_transport_update_device_volume is called.
---
 profiles/audio/transport.c | 126 +++++++++++++++++++++++++++++++++++--
 1 file changed, 120 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 41339da51e17..a1445cba7993 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -91,6 +91,7 @@ struct bap_transport {
 	uint8_t			rtn;
 	uint16_t		latency;
 	uint32_t		delay;
+	int8_t			volume;
 };
 
 struct media_transport {
@@ -116,6 +117,9 @@ struct media_transport {
 								guint id);
 	void			(*set_state) (struct media_transport *transport,
 						transport_state_t state);
+	void			(*set_volume) (struct media_transport *transp,
+						int8_t volume);
+	int8_t			(*get_volume) (struct media_transport *transp);
 	GDestroyNotify		destroy;
 	void			*data;
 };
@@ -769,6 +773,58 @@ error:
 					"Invalid arguments in method call");
 }
 
+static gboolean volume_bap_exists(const GDBusPropertyTable *property,
+					void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+
+	return bap->volume >= 0;
+}
+
+static gboolean get_bap_volume(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	uint16_t volume = (uint16_t)bap->volume;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT16, &volume);
+
+	return TRUE;
+}
+
+static void set_bap_volume(const GDBusPropertyTable *property,
+			   DBusMessageIter *iter, GDBusPendingPropertySet id,
+			   void *data)
+{
+	struct media_transport *transport = data;
+	struct bap_transport *bap = transport->data;
+	uint16_t arg;
+	int8_t volume;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16)
+		goto error;
+
+	dbus_message_iter_get_basic(iter, &arg);
+	if (arg > INT8_MAX)
+		goto error;
+
+	g_dbus_pending_property_success(id);
+
+	volume = (int8_t)arg;
+	if (bap->volume == volume)
+		return;
+
+	/*TODO vcp_send_volume */
+	return;
+
+error:
+	g_dbus_pending_property_error(id, ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+}
+
+
 static gboolean endpoint_exists(const GDBusPropertyTable *property, void *data)
 {
 	struct media_transport *transport = data;
@@ -970,6 +1026,7 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Retransmissions", "y", get_retransmissions },
 	{ "Latency", "q", get_latency },
 	{ "Delay", "u", get_delay },
+	{ "Volume", "q", get_bap_volume, set_bap_volume, volume_bap_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
@@ -1048,6 +1105,31 @@ static void source_state_changed(struct btd_service *service,
 		transport_update_playing(transport, FALSE);
 }
 
+static int8_t get_volume_a2dp(struct media_transport *transport)
+{
+	struct a2dp_transport *a2dp = transport->data;
+
+	return a2dp->volume;
+}
+
+static void set_volume_a2dp(struct media_transport *transport, int8_t volume)
+{
+	struct a2dp_transport *a2dp = transport->data;
+
+	if (volume < 0)
+		return;
+
+	/* Check if volume really changed */
+	if (a2dp->volume == volume)
+		return;
+
+	a2dp->volume = volume;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "Volume");
+}
+
 static int media_transport_init_source(struct media_transport *transport)
 {
 	struct btd_service *service;
@@ -1061,6 +1143,8 @@ static int media_transport_init_source(struct media_transport *transport)
 
 	transport->resume = resume_a2dp;
 	transport->suspend = suspend_a2dp;
+	transport->set_volume = set_volume_a2dp;
+	transport->get_volume = get_volume_a2dp;
 	transport->cancel = cancel_a2dp;
 	transport->data = a2dp;
 	transport->destroy = destroy_a2dp;
@@ -1387,6 +1471,31 @@ static void free_bap(void *data)
 	free(bap);
 }
 
+static void set_volume_bap(struct media_transport *transport, int8_t volume)
+{
+	struct bap_transport *bap = transport->data;
+
+	if (volume < 0)
+		return;
+
+	/* Check if volume really changed */
+	if (bap->volume == volume)
+		return;
+
+	bap->volume = volume;
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+					transport->path,
+					MEDIA_TRANSPORT_INTERFACE, "Volume");
+}
+
+static int8_t get_volume_bap(struct media_transport *transport)
+{
+	struct bap_transport *bap = transport->data;
+
+	return bap->volume;
+}
+
 static int media_transport_init_bap(struct media_transport *transport,
 							void *stream)
 {
@@ -1403,6 +1512,7 @@ static int media_transport_init_bap(struct media_transport *transport,
 	bap->rtn = qos->rtn;
 	bap->latency = qos->latency;
 	bap->delay = qos->delay;
+	bap->volume = 127;
 	bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
 						bap_state_changed,
 						bap_connecting,
@@ -1413,6 +1523,8 @@ static int media_transport_init_bap(struct media_transport *transport,
 	transport->suspend = suspend_bap;
 	transport->cancel = cancel_bap;
 	transport->set_state = set_state_bap;
+	transport->set_volume = set_volume_bap;
+	transport->get_volume = get_volume_bap;
 	transport->destroy = free_bap;
 
 	return 0;
@@ -1537,12 +1649,13 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 	/* Attempt to locate the transport to get its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
+
 		if (transport->device != dev)
 			continue;
 
-		/* Volume is A2DP only */
-		if (media_endpoint_get_sep(transport->endpoint))
-			return media_transport_get_volume(transport);
+		/* Get transport volume */
+		if (transport->get_volume)
+			return transport->get_volume(transport);
 	}
 
 	/* If transport volume doesn't exists use device_volume */
@@ -1560,12 +1673,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
 	/* Attempt to locate the transport to set its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
+
 		if (transport->device != dev)
 			continue;
 
-		/* Volume is A2DP only */
-		if (media_endpoint_get_sep(transport->endpoint)) {
-			media_transport_update_volume(transport, volume);
+		/* Set transport volume */
+		if (transport->set_volume) {
+			transport->set_volume(transport, volume);
 			return;
 		}
 	}
-- 
2.25.1

