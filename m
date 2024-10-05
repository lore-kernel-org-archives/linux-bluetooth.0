Received: from relay03.th.seeweb.it (relay03.th.seeweb.it [5.144.164.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278B7171099
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Oct 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165010; cv=none; b=N5FQO1O6AMqrGTdNay6qyPeDAMngDvM9OMnLwh6/Y2h/h86Vq99uR9J7Is5o6LevsCqdTDvYq0GokEOvhVtAcYIEnLrUiO7KHN0KqoFD4cySECV2JUGpdZ/2DFOoE0+wumUcMABZ0pwUURkoaiPCoSO7t1OSVY1PE12Vbg5xf/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165010; c=relaxed/simple;
	bh=h/QhMW4Jhi5jBjGR9cm/mVx/GG+1WBBiv8+Vo2XyMNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+0bFVujqP523YHNlh+/ihXHYg62/ua4CkEKlDCPrrUMAkBmNoHkTesc87vKvol3KECONZMeW/DZ6zTJ9E+t6LxV2EU1brrcbVptbGnEImxqLvnFevKB7MIsqT7eKM3AlmbV6TJo+rCOrM/zfR6fG1iYMzgp4vfEqpJuXNT2rys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 54D161F927;
	Sat,  5 Oct 2024 23:43:23 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Yu Liu <yudiliu@google.com>,
	Bartosz Fabianowski <bartosz@fabianowski.eu>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v4 2/3] audio/avrcp: Only allow absolute volume call/event on category-2 peers
Date: Sat,  5 Oct 2024 23:43:07 +0200
Message-ID: <20241005214321.84250-3-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005214321.84250-1-marijn.suijten@somainline.org>
References: <20241005214321.84250-1-marijn.suijten@somainline.org>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Restrict the use of SetAbsoluteVolume and EVENT_VOLUME_CHANGED to peers
with at least AVRCP version 1.4 and AVRCP_FEATURE_CATEGORY_2 on their
respective target or controller profiles.

For backwards-compatibility, add a (default-enabled) `VolumeCategory =
true` configuration option under `[AVRCP]` to allow optionally disabling
this new check.
---
 profiles/audio/avrcp.c | 39 ++++++++++++++++++++++++++++++++++-----
 src/btd.h              |  1 +
 src/main.c             |  5 +++++
 src/main.conf          |  5 +++++
 4 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 553673b19..005c3e306 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1775,6 +1775,16 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	if (len != 1)
 		goto err;
 
+	/**
+	 * The controller on the remote end is only allowed to call SetAbsoluteVolume
+	 * on our target if it's at least version 1.4 and a category-2 device.
+	 */
+	if (!session->target || session->target->version < 0x0104 ||
+			(btd_opts.avrcp.volume_category && !(session->target->features & AVRCP_FEATURE_CATEGORY_2))) {
+		error("Remote SetAbsoluteVolume rejected from non-category-2 peer");
+		goto err;
+	}
+
 	volume = pdu->params[0] & 0x7F;
 
 	media_transport_update_device_volume(session->dev, volume);
@@ -3767,6 +3777,16 @@ static void avrcp_volume_changed(struct avrcp *session,
 	struct avrcp_player *player = target_get_player(session);
 	int8_t volume;
 
+	/**
+	 * The target on the remote end is only allowed to reply to EVENT_VOLUME_CHANGED
+	 * on our controller if it's at least version 1.4 and a category-2 device.
+	 */
+	if (!session->controller || session->controller->version < 0x0104 ||
+			(btd_opts.avrcp.volume_category && !(session->controller->features & AVRCP_FEATURE_CATEGORY_2))) {
+		error("Remote EVENT_VOLUME_CHANGED rejected from non-category-2 peer");
+		return;
+	}
+
 	volume = pdu->params[1] & 0x7F;
 
 	/* Always attempt to update the transport volume */
@@ -4041,7 +4061,7 @@ static gboolean avrcp_get_capabilities_resp(struct avctp *conn, uint8_t code,
 		case AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED:
 		case AVRCP_EVENT_UIDS_CHANGED:
 		case AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED:
-			/* These events above requires a player */
+			/* These events above require a player */
 			if (!session->controller ||
 						!session->controller->player)
 				break;
@@ -4245,10 +4265,13 @@ static void target_init(struct avrcp *session)
 	if (target->version < 0x0104)
 		return;
 
+	if (!btd_opts.avrcp.volume_category || target->features & AVRCP_FEATURE_CATEGORY_2)
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
@@ -4665,8 +4688,11 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		return -ENOTCONN;
 
 	if (notify) {
-		if (!session->target)
+		if (!session->target || session->target->version < 0x0104 ||
+				(btd_opts.avrcp.volume_category && !(session->target->features & AVRCP_FEATURE_CATEGORY_2))) {
+			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 peer");
 			return -ENOTSUP;
+		}
 		return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
 								&volume);
 	}
@@ -4680,8 +4706,11 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 						AVRCP_EVENT_VOLUME_CHANGED))
 			return -ENOTSUP;
 	} else {
-		if (!session->controller || session->controller->version < 0x0104)
+		if (!session->controller || session->controller->version < 0x0104 ||
+				(btd_opts.avrcp.volume_category && !(session->controller->features & AVRCP_FEATURE_CATEGORY_2))) {
+			error("Can't send SetAbsoluteVolume to non-category-2 peer");
 			return -ENOTSUP;
+		}
 	}
 
 	memset(buf, 0, sizeof(buf));
diff --git a/src/btd.h b/src/btd.h
index 147b61f12..07205aa69 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -106,6 +106,7 @@ struct btd_avdtp_opts {
 
 struct btd_avrcp_opts {
 	bool		volume_without_target;
+	bool		volume_category;
 };
 
 struct btd_advmon_opts {
diff --git a/src/main.c b/src/main.c
index 5bd3a035d..89ee6897c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -167,6 +167,7 @@ static const char *avdtp_options[] = {
 
 static const char *avrcp_options[] = {
 	"VolumeWithoutTarget",
+	"VolumeCategory",
 	NULL
 };
 
@@ -1151,6 +1152,9 @@ static void parse_avrcp(GKeyFile *config)
 	parse_config_bool(config, "AVRCP",
 		"VolumeWithoutTarget",
 		&btd_opts.avrcp.volume_without_target);
+	parse_config_bool(config, "AVRCP",
+		"VolumeCategory",
+		&btd_opts.avrcp.volume_category);
 }
 
 static void parse_advmon(GKeyFile *config)
@@ -1220,6 +1224,7 @@ static void init_defaults(void)
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 
 	btd_opts.avrcp.volume_without_target = false;
+	btd_opts.avrcp.volume_category = true;
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
diff --git a/src/main.conf b/src/main.conf
index 5d206b9ec..fff13ed2f 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -311,6 +311,11 @@
 # version is ignored.
 #VolumeWithoutTarget = false
 
+# Validate that remote AVRCP profiles advertise the category-2 bit before
+# allowing SetAbsoluteVolume calls or registering for EVENT_VOLUME_CHANGED
+# notifications.
+#VolumeCategory = true
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.46.2

