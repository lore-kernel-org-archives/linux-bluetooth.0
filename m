Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087CAC6FD19
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjCKAoi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjCKAof (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:44:35 -0500
X-Greylist: delayed 333 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 16:44:33 PST
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [IPv6:2001:4b7a:2000:18::162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C319134AD7
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:44:32 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 3994C2008D;
        Sat, 11 Mar 2023 01:39:00 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v3 2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers
Date:   Sat, 11 Mar 2023 01:38:25 +0100
Message-Id: <20230311003826.454858-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311003826.454858-1-marijn.suijten@somainline.org>
References: <20230311003826.454858-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Restrict the use of SetAbsoluteVolume and EVENT_VOLUME_CHANGED to peers
with at least AVRCP version 1.4 and AVRCP_FEATURE_CATEGORY_2 on their
respective target or controller profiles.
---
 profiles/audio/avrcp.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 5e6322916..c16f9cfef 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1757,6 +1757,16 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	if (len != 1)
 		goto err;
 
+	/**
+	 * The controller on the remote end is only allowed to call SetAbsoluteVolume
+	 * on our target if it's at least version 1.4 and a category-2 device.
+	 */
+	if (!session->target || session->target->version < 0x0104 ||
+			!(session->target->features & AVRCP_FEATURE_CATEGORY_2)) {
+		error("Remote SetAbsoluteVolume rejected from non-category-2 peer");
+		goto err;
+	}
+
 	volume = pdu->params[0] & 0x7F;
 
 	media_transport_update_device_volume(session->dev, volume);
@@ -3728,6 +3738,16 @@ static void avrcp_volume_changed(struct avrcp *session,
 	struct avrcp_player *player = target_get_player(session);
 	int8_t volume;
 
+	/**
+	 * The target on the remote end is only allowed to reply to EVENT_VOLUME_CHANGED
+	 * on our controller if it's at least version 1.4 and a category-2 device.
+	 */
+	if (!session->controller || session->controller->version < 0x0104 ||
+			!(session->controller->features & AVRCP_FEATURE_CATEGORY_2)) {
+		error("Remote EVENT_VOLUME_CHANGED rejected from non-category-2 peer");
+		return;
+	}
+
 	volume = pdu->params[1] & 0x7F;
 
 	/* Always attempt to update the transport volume */
@@ -3981,7 +4001,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
 		case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
-			/* These events above requires a player */
+			/* These events above require a player */
 			if (!session->controller ||
 						!session->controller->player)
 				break;
@@ -4154,10 +4174,13 @@ static void target_init(struct avrcp *session)
 	if (target->version < 0x0104)
 		return;
 
+	if (target->features & AVRCP_FEATURE_CATEGORY_2)
+		session->supported_events |=
+				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
-				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
-				(1 << AVRCP_EVENT_VOLUME_CHANGED);
+				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
 
 	/* Only check capabilities if controller is not supported */
 	if (session->controller == NULL)
@@ -4572,8 +4595,11 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		return -ENOTCONN;
 
 	if (notify) {
-		if (!session->target)
+		if (!session->target || session->target->version < 0x0104 ||
+				!(session->target->features & AVRCP_FEATURE_CATEGORY_2)) {
+			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 peer");
 			return -ENOTSUP;
+		}
 		return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
 								&volume);
 	}
@@ -4583,8 +4609,11 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 						AVRCP_EVENT_VOLUME_CHANGED))
 			return -ENOTSUP;
 	} else {
-		if (!session->controller || session->controller->version < 0x0104)
+		if (!session->controller || session->controller->version < 0x0104 ||
+				!(session->controller->features & AVRCP_FEATURE_CATEGORY_2)) {
+			error("Can't send SetAbsoluteVolume to non-category-2 peer");
 			return -ENOTSUP;
+		}
 	}
 
 	memset(buf, 0, sizeof(buf));
-- 
2.39.2

