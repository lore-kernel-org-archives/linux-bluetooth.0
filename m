Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE666C2BA19
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B46F20732
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586795146;
	bh=blYamwkQ3jtD5fZD4JKrWUYh8MlY3zYYDPawuIR/ZBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PzewGFiHhnkXndYpspBpEsOfR0clc4Ed4VC28NHM4SYJialHTni/NKYxO/4jkgSPI
	 Ou/6qA9RXGQah3L+TcCP4cTUzTExkus2ptYYwYJglEivu720ih/i2ezzNBaiSzJ6AN
	 I/sFeWD1zruHtmXpJ0roS9ExQyJ7wLdKVGlsWdWI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbgDMQZq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731515AbgDMQZn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:25:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE13B20692;
        Mon, 13 Apr 2020 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586795143;
        bh=blYamwkQ3jtD5fZD4JKrWUYh8MlY3zYYDPawuIR/ZBA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKa3fNh5iUns7ho/DlDexcaBK/jk90dLbeaVHh32lUaZSWXTdWG/8u33+FZrMaG3r
         fokFw9CsRkBstHlBucpWAPmAMJTgMjBSyvD4xtZmgUiXAUoGvQrFLhXdabIITaYC8d
         74D04+njLtt025piKulubW0b/WnDLdAwALYCX3k8=
Received: by pali.im (Postfix)
        id 45937895; Mon, 13 Apr 2020 18:25:41 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH 1/3] src/profile: Distinguish between zero-set HFP AG features and unset HFP AG features
Date:   Mon, 13 Apr 2020 18:25:11 +0200
Message-Id: <20200413162513.2221-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200413162513.2221-1-pali@kernel.org>
References: <20200321195404.fvyku5hmcuqxt7sg@pali>
 <20200413162513.2221-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

When HFP AG features are not set then according to HFP 1.7.2 specification
it has value 0b001001. But when HFP AG features were explicitly set to
zero, bluez did not propagated this value via NewConnection() DBus call, so
callee used default value 0b001001 (according to HFP 1.7.2 specification)
as bluez did not provided explicit zero value.

To fix this problem add a new boolean variable have_features which
indicates if SDP features were provided (with possible zero value) or not
(when default value needs to be used). Code for generating SDP XML records
were also updated to handle this fact.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 src/profile.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 192fd0245..884440408 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -647,6 +647,7 @@ struct ext_profile {
 
 	uint16_t version;
 	uint16_t features;
+	bool have_features;
 
 	GSList *records;
 	GSList *servers;
@@ -669,6 +670,7 @@ struct ext_io {
 
 	uint16_t version;
 	uint16_t features;
+	bool have_features;
 
 	uint16_t psm;
 	uint8_t chan;
@@ -920,14 +922,18 @@ static void append_prop(gpointer a, gpointer b)
 	dbus_message_iter_close_container(dict, &entry);
 }
 
-static uint16_t get_supported_features(const sdp_record_t *rec)
+static uint16_t get_supported_features(const sdp_record_t *rec,
+					bool *have_features)
 {
 	sdp_data_t *data;
 
 	data = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES);
-	if (!data || data->dtd != SDP_UINT16)
+	if (!data || data->dtd != SDP_UINT16) {
+		*have_features = false;
 		return 0;
+	}
 
+	*have_features = true;
 	return data->val.uint16;
 }
 
@@ -972,7 +978,8 @@ static bool send_new_connection(struct ext_profile *ext, struct ext_io *conn)
 	if (remote_uuid) {
 		rec = btd_device_get_record(conn->device, remote_uuid);
 		if (rec) {
-			conn->features = get_supported_features(rec);
+			conn->features = get_supported_features(rec,
+							&conn->have_features);
 			conn->version = get_profile_version(rec);
 		}
 	}
@@ -991,7 +998,7 @@ static bool send_new_connection(struct ext_profile *ext, struct ext_io *conn)
 		dict_append_entry(&dict, "Version", DBUS_TYPE_UINT16,
 							&conn->version);
 
-	if (conn->features)
+	if (conn->have_features)
 		dict_append_entry(&dict, "Features", DBUS_TYPE_UINT16,
 							&conn->features);
 
@@ -1589,7 +1596,8 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		if (conn->psm == 0 && sdp_get_proto_desc(protos, OBEX_UUID))
 			conn->psm = get_goep_l2cap_psm(rec);
 
-		conn->features = get_supported_features(rec);
+		conn->features = get_supported_features(rec,
+							&conn->have_features);
 		conn->version = get_profile_version(rec);
 
 		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free,
@@ -1750,15 +1758,19 @@ static int ext_disconnect_dev(struct btd_service *service)
 static char *get_hfp_hf_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
+	/* HFP 1.7.2: By default features bitfield is 0b000000 */
 	return g_strdup_printf(HFP_HF_RECORD, rfcomm->chan, ext->version,
-						ext->name, ext->features);
+				ext->name,
+				ext->have_features ? ext->features : 0x0);
 }
 
 static char *get_hfp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
 							struct ext_io *rfcomm)
 {
+	/* HFP 1.7.2: By default features bitfield is 0b001001 */
 	return g_strdup_printf(HFP_AG_RECORD, rfcomm->chan, ext->version,
-						ext->name, ext->features);
+				ext->name,
+				ext->have_features ? ext->features : 0x9);
 }
 
 static char *get_hsp_ag_record(struct ext_profile *ext, struct ext_io *l2cap,
@@ -1948,6 +1960,7 @@ static struct default_settings {
 					struct ext_io *rfcomm);
 	uint16_t	version;
 	uint16_t	features;
+	bool		have_features;
 } defaults[] = {
 	{
 		.uuid		= SPP_UUID,
@@ -2107,8 +2120,10 @@ static void ext_set_defaults(struct ext_profile *ext)
 		if (settings->version)
 			ext->version = settings->version;
 
-		if (settings->features)
+		if (settings->have_features) {
 			ext->features = settings->features;
+			ext->have_features = true;
+		}
 
 		if (settings->name)
 			ext->name = g_strdup(settings->name);
@@ -2198,6 +2213,7 @@ static int parse_ext_opt(struct ext_profile *ext, const char *key,
 
 		dbus_message_iter_get_basic(value, &feat);
 		ext->features = feat;
+		ext->have_features = true;
 	} else if (strcasecmp(key, "Service") == 0) {
 		if (type != DBUS_TYPE_STRING)
 			return -EINVAL;
-- 
2.20.1

