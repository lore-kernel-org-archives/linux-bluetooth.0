Return-Path: <SRS0=qzAF=55=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738A4C2BBFD
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5247820735
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Apr 2020 16:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586795147;
	bh=KA9JqUSkIVZR20ZIJ8nmwFuRrBx6hlCxjpYK9LdmC3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=COq9hpkcvV8Xd50oUwaaHeQ5h2NRUGNnfpfnlMcllQLI8GOs9ICzVi4A7U4mHzYIU
	 olvln55NBb1pml7pwlHBDsue4LgQQKpICo0m+znJhz02/KvKdVEUJoRIt3kl2dXDEn
	 NOpnxmytymYStNdhYDlqKGLWIYfsxQpDNkwSryiQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgDMQZq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:25:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:52076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731525AbgDMQZo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Apr 2020 12:25:44 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6706A20732;
        Mon, 13 Apr 2020 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586795144;
        bh=KA9JqUSkIVZR20ZIJ8nmwFuRrBx6hlCxjpYK9LdmC3M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dvUXlrRlqdxvqR560uP8Rullx9LUMWaDEBs+06w1zBf8ix/aPePBfNbvvQPZrpCA7
         7WmKP7RPDBpwhGdxqPCPYJbmUPBdUh+I7GwafoOjaeDPLNq3i56UD42GQMuTXeExtP
         0jlJ5kz4NOkK2lkcAbGGCbJefFssCNHU/GKNS96g=
Received: by pali.im (Postfix)
        id 828E7EC3; Mon, 13 Apr 2020 18:25:42 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, David Heidelberg <david@ixit.cz>
Subject: [PATCH 2/3] src/profile: Export Remote Audio Volume Control SDP value for HSP HS role via first bit in features value
Date:   Mon, 13 Apr 2020 18:25:12 +0200
Message-Id: <20200413162513.2221-3-pali@kernel.org>
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

Remote Audio Volume Control property in SDP record for HSP HS role
indicates if device supports volume control.

It is required for DBus agents which implements audio part of HSP
profile to know if remote device supports volume control or not.

With this change bluez exports status of this SDP property via firt bit
in Features entry in NewConnection() DBus callback method, like for HFP
profile.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 src/profile.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/src/profile.c b/src/profile.c
index 884440408..3b7e08f26 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -923,10 +923,26 @@ static void append_prop(gpointer a, gpointer b)
 }
 
 static uint16_t get_supported_features(const sdp_record_t *rec,
-					bool *have_features)
+					const char *uuid, bool *have_features)
 {
 	sdp_data_t *data;
 
+	if (strcasecmp(uuid, HSP_AG_UUID) == 0) {
+		/* HSP AG role does not provide any features */
+		*have_features = false;
+		return 0;
+	} else if (strcasecmp(uuid, HSP_HS_UUID) == 0) {
+		/* HSP HS role provides Remote Audio Volume Control */
+		data = sdp_data_get(rec, SDP_ATTR_REMOTE_AUDIO_VOLUME_CONTROL);
+		if (!data || data->dtd != SDP_BOOL) {
+			*have_features = false;
+			return 0;
+		} else {
+			*have_features = true;
+			return data->val.int8 ? 0x1 : 0x0;
+		}
+	}
+
 	data = sdp_data_get(rec, SDP_ATTR_SUPPORTED_FEATURES);
 	if (!data || data->dtd != SDP_UINT16) {
 		*have_features = false;
@@ -979,7 +995,7 @@ static bool send_new_connection(struct ext_profile *ext, struct ext_io *conn)
 		rec = btd_device_get_record(conn->device, remote_uuid);
 		if (rec) {
 			conn->features = get_supported_features(rec,
-							&conn->have_features);
+					remote_uuid, &conn->have_features);
 			conn->version = get_profile_version(rec);
 		}
 	}
@@ -1596,7 +1612,7 @@ static void record_cb(sdp_list_t *recs, int err, gpointer user_data)
 		if (conn->psm == 0 && sdp_get_proto_desc(protos, OBEX_UUID))
 			conn->psm = get_goep_l2cap_psm(rec);
 
-		conn->features = get_supported_features(rec,
+		conn->features = get_supported_features(rec, ext->remote_uuid,
 							&conn->have_features);
 		conn->version = get_profile_version(rec);
 
-- 
2.20.1

