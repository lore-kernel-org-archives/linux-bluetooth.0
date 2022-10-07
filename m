Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D353C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 06:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiJGGLd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 02:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJGGLc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 02:11:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627B9B97B6
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665123091; x=1696659091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Ul5rN+cUjKv49XK3Z0TXqDvLqwQsUVcwp1r9xEzuoo=;
  b=BeKdsv3IEOQpuzYBVPjp8qk4OsiuCpgr0Q+qwv656ZbjEBwGcdMUCOgj
   2aOHoXKQtvC2EOh8muze6/ftQqjWT4xgzPU67tX4oU3V0+C8cvS8LeiUg
   Oh7AdXDF/0QQhhVKolKnmD10ajXa5OvPHEjmQgdSBozWOkPNAiCHSG2Ob
   1Mzu3i2WAol0DImncof9+l8yt3kbQZ9eRpYmiMtRCptbriFUh8DvRnrgH
   uZr1s4vlyQhufsT3A/Ng+cFwltDFYQG+1Tb+66FV6c7X1la0zjzMAHxE8
   7BkoMPG1FX8C1nCvfYhawROS/NtaJ9CM5nESAgQbwObmOTSQWbijmaw0D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="284027965"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="284027965"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 23:11:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="714135115"
X-IronPort-AV: E=Sophos;i="5.95,166,1661842800"; 
   d="scan'208";a="714135115"
Received: from intel-latitude-e5450.iind.intel.com ([10.224.186.32])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2022 23:11:29 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ v2 1/3] audio/transport: Add volume callback to BAP transport
Date:   Fri,  7 Oct 2022 11:42:21 +0530
Message-Id: <20221007061223.46114-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Initialize set_volume and get_volume to BAP transport and update the
volume when media_transport_update_device_volume is called.
---
 profiles/audio/transport.c | 98 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 41339da51e17..46b936c965bf 100644
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
+	void			(*set_vol)(struct media_transport *transport,
+						int8_t volume);
+	int8_t			(*get_vol)(struct media_transport *transport);
 	GDestroyNotify		destroy;
 	void			*data;
 };
@@ -717,6 +721,7 @@ static gboolean volume_exists(const GDBusPropertyTable *property, void *data)
 	return a2dp->volume >= 0;
 }
 
+
 static gboolean get_volume(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
@@ -769,6 +774,58 @@ error:
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
@@ -970,6 +1027,7 @@ static const GDBusPropertyTable bap_properties[] = {
 	{ "Retransmissions", "y", get_retransmissions },
 	{ "Latency", "q", get_latency },
 	{ "Delay", "u", get_delay },
+	{ "Volume", "q", get_bap_volume, set_bap_volume, volume_bap_exists },
 	{ "Endpoint", "o", get_endpoint, NULL, endpoint_exists },
 	{ "Location", "u", get_location },
 	{ "Metadata", "ay", get_metadata },
@@ -1387,6 +1445,31 @@ static void free_bap(void *data)
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
@@ -1403,6 +1486,7 @@ static int media_transport_init_bap(struct media_transport *transport,
 	bap->rtn = qos->rtn;
 	bap->latency = qos->latency;
 	bap->delay = qos->delay;
+	bap->volume = 127;
 	bap->state_id = bt_bap_state_register(bt_bap_stream_get_session(stream),
 						bap_state_changed,
 						bap_connecting,
@@ -1413,6 +1497,8 @@ static int media_transport_init_bap(struct media_transport *transport,
 	transport->suspend = suspend_bap;
 	transport->cancel = cancel_bap;
 	transport->set_state = set_state_bap;
+	transport->set_vol = set_volume_bap;
+	transport->get_vol = get_volume_bap;
 	transport->destroy = free_bap;
 
 	return 0;
@@ -1537,6 +1623,11 @@ int8_t media_transport_get_device_volume(struct btd_device *dev)
 	/* Attempt to locate the transport to get its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
+
+		/* Get BAP transport volume */
+		if (transport->get_vol)
+			return transport->get_vol(transport);
+
 		if (transport->device != dev)
 			continue;
 
@@ -1560,6 +1651,13 @@ void media_transport_update_device_volume(struct btd_device *dev,
 	/* Attempt to locate the transport to set its volume */
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
+
+		/* Set BAP transport volume */
+		if (transport->set_vol) {
+			transport->set_vol(transport, volume);
+			return;
+		}
+
 		if (transport->device != dev)
 			continue;
 
-- 
2.25.1

