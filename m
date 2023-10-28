Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 577E5C27C4A
	for <linux-bluetooth@archiver.kernel.org>; Sat, 28 Oct 2023 14:39:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjJ1Ojl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 28 Oct 2023 10:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjJ1Ojk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 28 Oct 2023 10:39:40 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181EDF0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Oct 2023 07:39:37 -0700 (PDT)
Received: from monolith.lan (unknown [185.77.218.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4SHhxy4tWZz49Q4M;
        Sat, 28 Oct 2023 17:39:34 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1698503974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82Pvx/CWmqLa+M7kmnpR+VTuTlcjdGYixQptc74mRdU=;
        b=URVJ95tNWCvXW+5ag3BHIuVjQ38pwrWrTq69zgk+2lfHmA7cZu6OUdDPEb8h9O1tj1DpSn
        Gn+McweMjJGC0ubF/IkpyA4iU0Lvuz1lULVSSJqxvCLjkDSPVS39WI+RjjCyqpcS2FhNyI
        hxiIUY/4i/gn0u0Vpldvf5iqng0K4SzuLkh6lOWBDf9QyBRhjIIThJ4s6BTO4hlyJWrZ6k
        eteizI3FiXxKlM5UsLJjN9bPFQdBp7X2GMHrGEQqT71MYz/Np64H3M2ciojWJd1EZja2Hh
        Gp75YY52GvTqVKRxn6Cpi4MPjF4mqTv5qMUiJZIh3CjhsE/DauVVZnU8C3og/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1698503974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=82Pvx/CWmqLa+M7kmnpR+VTuTlcjdGYixQptc74mRdU=;
        b=Gyu1vecPlH6MXDhmNq7+TzNmkgU1cvlWmFy68KpLOmMsVLyCo86tc1DVPOh9e+0kvTeVVq
        LJWNvTNj4IwimBUKhYKAFke8Y5kakqvtpOX3Sh/4cwPlrDdBgoZkdmvISqcZCzJ+LCZE3h
        33HKtRvZsxTIABJ/ndgAGGyH48kQq9hKif7JL/kwe0bx2iYbJesbps1rTQiGioET/hdzIR
        DCsrZjZjRNeDk02aXiG6rcm7KTI/tesO3JF5cCsw9UuE9uenegj7q/MA0z5TJjN0/mU2sn
        X6ayVf0+lXOTd3c70E87cW2jX/s+jJVekoNWjhHcHuVywG7KedvQc5LAzlqHsg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1698503974; a=rsa-sha256;
        cv=none;
        b=MsLxW2hjE4ZKUCHNlXciHC7rUSFG8VWp8AH5JvKFqbGeFCzANaYrIB3n9bjXsnNs9OEmQZ
        dNunanRj8Vr6Pp6VVjzkIzqePYfaDNFkC6UNxt6XqNvUuRoy/BedORcALIfdftkKJ9SO8v
        ijzWU7wLyVfHUc/4Ix6J2alozVZQQRZN/ZXoUodkCPGcvrDspdieKzcQ2plYN++UYKd/Ll
        0JirbZ1s7vaG4vL+rmBRQO7xpxtg3F3CnkIBzAoTFhTbev5tHVsikF1tDJOjqzXoN7VSzS
        4kzjvak4rAtFsCflF6HV6XHCi/BDrSJSFAgTRuCydRoviCXTWz6w8c9+z6VaJA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 2/4] shared/bap: rename PAC op select -> select_codec, add select_qos
Date:   Sat, 28 Oct 2023 17:39:27 +0300
Message-ID: <2cbda517f3818b68bc3e2e44328116e76b9bb3b7.1698503903.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
References: <6f03ad1eaaa00f84db8cd6a4a4b88ee83078951d.1698503903.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The BAP Unicast Client stream configuration flow has two steps,
Config Codec and Config QoS.

Previously both the ASE Codec & QoS configuration was obtained from the
local PAC via bt_bap_pac_ops.select, but the information what the BAP
Server supports becomes available only after Config Codec completes
successfully.  So the single-step configuration doesn't work out
correctly in the API.

Split out the QoS configuration to a separate PAC operation.

Rename "select" to "select_codec", and add select_qos and
bt_bap_stream_select_qos for the QoS configuration step.

Also add bt_bap_stream_get_lpac/rpac, which will be needed in the QoS
configuration callback.
---
 src/shared/bap.c | 37 ++++++++++++++++++++++++++++++++-----
 src/shared/bap.h | 23 +++++++++++++++++------
 2 files changed, 49 insertions(+), 11 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 13bbcf793..6155b8640 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4617,17 +4617,34 @@ static bool match_pac(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 	return false;
 }
 
-int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			bt_bap_pac_select_t func, void *user_data)
+int bt_bap_select_codec(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			bt_bap_pac_select_codec_t func, void *user_data)
 {
 	if (!lpac || !rpac || !func)
 		return -EINVAL;
 
-	if (!lpac->ops || !lpac->ops->select)
+	if (!lpac->ops || !lpac->ops->select_codec)
 		return -EOPNOTSUPP;
 
-	lpac->ops->select(lpac, rpac, &rpac->qos,
-					func, user_data, lpac->user_data);
+	lpac->ops->select_codec(lpac, rpac, func, user_data, lpac->user_data);
+
+	return 0;
+}
+
+int bt_bap_stream_select_qos(struct bt_bap_stream *stream,
+				bt_bap_pac_select_qos_t func, void *user_data)
+{
+	struct bt_bap_pac *lpac = stream->lpac;
+	struct bt_bap_pac *rpac = stream->rpac;
+
+	if (!lpac || !rpac || !func)
+		return -EINVAL;
+
+	if (!lpac->ops || !lpac->ops->select_qos)
+		return -EOPNOTSUPP;
+
+	lpac->ops->select_qos(stream, &rpac->qos, func, user_data,
+							lpac->user_data);
 
 	return 0;
 }
@@ -5124,6 +5141,16 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 		return stream->bap->ldb->pacs->source_loc_value;
 }
 
+struct bt_bap_pac *bt_bap_stream_get_lpac(struct bt_bap_stream *stream)
+{
+	return stream->lpac;
+}
+
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream)
+{
+	return stream->rpac;
+}
+
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
 {
 	if (!stream)
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 23edbf4c6..d8fae0ef8 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -104,12 +104,15 @@ typedef void (*bt_bap_pac_func_t)(struct bt_bap_pac *pac, void *user_data);
 typedef bool (*bt_bap_pac_foreach_t)(struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac,
 					void *user_data);
-typedef void (*bt_bap_pac_select_t)(struct bt_bap_pac *pac, int err,
+typedef void (*bt_bap_pac_select_codec_t)(struct bt_bap_pac *pac, int err,
 					struct iovec *caps,
 					struct iovec *metadata,
 					struct bt_bap_qos *qos,
 					void *user_data);
 typedef void (*bt_bap_pac_config_t)(struct bt_bap_stream *stream, int err);
+typedef void (*bt_bap_pac_select_qos_t)(struct bt_bap_stream *stream,
+					int err, struct bt_bap_qos *qos,
+					void *user_data);
 typedef void (*bt_bap_state_func_t)(struct bt_bap_stream *stream,
 					uint8_t old_state, uint8_t new_state,
 					void *user_data);
@@ -150,9 +153,12 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					struct iovec *metadata);
 
 struct bt_bap_pac_ops {
-	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			struct bt_bap_pac_qos *qos,
-			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
+	int (*select_codec)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			bt_bap_pac_select_codec_t cb, void *cb_data,
+			void *user_data);
+	int (*select_qos)(struct bt_bap_stream *stream,
+			struct bt_bap_pac_qos *qos, bt_bap_pac_select_qos_t cb,
+			void *cb_data, void *user_data);
 	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
 			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
 			void *user_data);
@@ -233,8 +239,8 @@ void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
 void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
 
 /* Stream related functions */
-int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
-			bt_bap_pac_select_t func, void *user_data);
+int bt_bap_select_codec(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
+			bt_bap_pac_select_codec_t func, void *user_data);
 
 struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 					struct bt_bap_pac *lpac,
@@ -249,6 +255,9 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data);
 
 void *bt_bap_stream_get_user_data(struct bt_bap_stream *stream);
 
+int bt_bap_stream_select_qos(struct bt_bap_stream *stream,
+				bt_bap_pac_select_qos_t func, void *user_data);
+
 unsigned int bt_bap_stream_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *pqos,
 					struct iovec *data,
@@ -293,6 +302,8 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream);
 struct bt_bap_qos *bt_bap_stream_get_qos(struct bt_bap_stream *stream);
 struct iovec *bt_bap_stream_get_metadata(struct bt_bap_stream *stream);
+struct bt_bap_pac *bt_bap_stream_get_lpac(struct bt_bap_stream *stream);
+struct bt_bap_pac *bt_bap_stream_get_rpac(struct bt_bap_stream *stream);
 
 struct io *bt_bap_stream_get_io(struct bt_bap_stream *stream);
 bool bt_bap_match_bcast_sink_stream(const void *data, const void *user_data);
-- 
2.41.0

