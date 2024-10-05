Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B7517108A
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Oct 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165010; cv=none; b=iZoVZsOP+wWH0SbWt/laiKz9TxrcRietPQH6OBYi6cOBCntKP7fTEZkh4nScMcGG9J00C/CPVlduaPmNZPweeeUbzaTzxKazXTYD2dg6dnUE/ZC1RAErvh43NVwXtug0NEwsbe/16OQNQ5FNDocsmNL3ReOVDRXhjbAObkO6wi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165010; c=relaxed/simple;
	bh=8RAxEDBmCwfMfXTHgbe16yv22rJr0MSYHi0ycZdApns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIth1nK84clRVWo2Wk/dcC6EnTCQJZRSPrj4Bjle+Z4+UR9ZDThTXRRf1Y8qelCcRkxdNRTSkbKb/AWujIc4dAf+zMtrlVfd5uJABprFJrSL7lZqv9ckBKrm6tYB+iDM8RFA0A94FOhNxy/Bu8TbNx7myyRjFc0DjbuezLE3klg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id C13A91F92B;
	Sat,  5 Oct 2024 23:43:23 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Yu Liu <yudiliu@google.com>,
	Bartosz Fabianowski <bartosz@fabianowski.eu>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v4 3/3] audio/avrcp: Determine Absolute Volume support from feature category 2
Date: Sat,  5 Oct 2024 23:43:08 +0200
Message-ID: <20241005214321.84250-4-marijn.suijten@somainline.org>
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

The AVRCP spec (1.6.2) does not mention anything about a version
requirement for Absolute Volume, despite this feature only existing
since spec version 1.4.  Android reports a version of 1.3 [1] for its
"AVRCP remote" (CT) service and mentions in the comment above it itself
relies on feature bits rather than the exposed version.  As it stands
BlueZ requires at least version 1.4 making it unable to communicate
absolute volume levels with even the most recent Android phones running
Fluoride (have not checked the version on Gabeldorsche).

The spec states that supporting SetAbsoluteVolume and
EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
excluded otherwise.  This feature bit is set on Android and, when used
by this patch, allows for successfully communicating volume back and
forth despite the version theoretically being too low.

In order to not affect spec tests too much (which I doubt would catch
this, and should have otherwise pointed out that Android itself is out
of spec) this behaviour is guarded behind a config option in main.conf,
as discussed in [2].

Note that this workaround is deliberately omitted for the "AVRCP
target" profile version, since Android already signals that to be 1.4
(which allows receiving SetAbsoluteVolume calls or registration for
EVENT_VOLUME_CHANGED notifications) for other reasons [3].

[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761
[2]: https://marc.info/?l=linux-bluetooth&m=163463497503113&w=2
[3]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#755
---
 profiles/audio/avrcp.c | 20 ++++++++++++--------
 src/btd.h              |  1 +
 src/main.c             |  5 +++++
 src/main.conf          |  9 +++++++++
 4 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 005c3e306..84172a6f6 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1779,9 +1779,10 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	 * The controller on the remote end is only allowed to call SetAbsoluteVolume
 	 * on our target if it's at least version 1.4 and a category-2 device.
 	 */
-	if (!session->target || session->target->version < 0x0104 ||
+	if (!session->target ||
+			(btd_opts.avrcp.volume_version && session->target->version < 0x0104) ||
 			(btd_opts.avrcp.volume_category && !(session->target->features & AVRCP_FEATURE_CATEGORY_2))) {
-		error("Remote SetAbsoluteVolume rejected from non-category-2 peer");
+		error("Remote SetAbsoluteVolume rejected from non-category-2 or non-AVRCP-1.4 peer");
 		goto err;
 	}
 
@@ -4262,13 +4263,15 @@ static void target_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
-	if (target->version < 0x0104)
-		return;
-
-	if (!btd_opts.avrcp.volume_category || target->features & AVRCP_FEATURE_CATEGORY_2)
+	/* Remote device supports receiving volume notifications */
+	if ((!btd_opts.avrcp.volume_version || target->version >= 0x0104) &&
+			(!btd_opts.avrcp.volume_category || target->features & AVRCP_FEATURE_CATEGORY_2))
 		session->supported_events |=
 				(1 << AVRCP_EVENT_VOLUME_CHANGED);
 
+	if (target->version < 0x0104)
+		return;
+
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
 				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
@@ -4688,9 +4691,10 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		return -ENOTCONN;
 
 	if (notify) {
-		if (!session->target || session->target->version < 0x0104 ||
+		if (!session->target ||
+				(btd_opts.avrcp.volume_version && session->target->version < 0x0104) ||
 				(btd_opts.avrcp.volume_category && !(session->target->features & AVRCP_FEATURE_CATEGORY_2))) {
-			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 peer");
+			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 or non-AVRCP-1.4 peer");
 			return -ENOTSUP;
 		}
 		return avrcp_event(session, AVRCP_EVENT_VOLUME_CHANGED,
diff --git a/src/btd.h b/src/btd.h
index 07205aa69..61e4d309d 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -107,6 +107,7 @@ struct btd_avdtp_opts {
 struct btd_avrcp_opts {
 	bool		volume_without_target;
 	bool		volume_category;
+	bool		volume_version;
 };
 
 struct btd_advmon_opts {
diff --git a/src/main.c b/src/main.c
index 89ee6897c..e8504cbe3 100644
--- a/src/main.c
+++ b/src/main.c
@@ -168,6 +168,7 @@ static const char *avdtp_options[] = {
 static const char *avrcp_options[] = {
 	"VolumeWithoutTarget",
 	"VolumeCategory",
+	"VolumeVersion",
 	NULL
 };
 
@@ -1155,6 +1156,9 @@ static void parse_avrcp(GKeyFile *config)
 	parse_config_bool(config, "AVRCP",
 		"VolumeCategory",
 		&btd_opts.avrcp.volume_category);
+	parse_config_bool(config, "AVRCP",
+		"VolumeVersion",
+		&btd_opts.avrcp.volume_version);
 }
 
 static void parse_advmon(GKeyFile *config)
@@ -1225,6 +1229,7 @@ static void init_defaults(void)
 
 	btd_opts.avrcp.volume_without_target = false;
 	btd_opts.avrcp.volume_category = true;
+	btd_opts.avrcp.volume_version = false;
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
diff --git a/src/main.conf b/src/main.conf
index fff13ed2f..b6b32a720 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -316,6 +316,15 @@
 # notifications.
 #VolumeCategory = true
 
+# Require peer AVRCP controllers to have at least version 1.4 before
+# accessing category-2 (absolute volume) features (depending on the value
+# of VolumeCategory above).  It is common for Android-powered devices to not
+# signal the desired minimum version of 1.4 while still supporting absolute
+# volume based on the feature category bit, as mentioned in this comment:
+# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r1/bta/
+# av/bta_av_main.cc#621
+#VolumeVersion = false
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.46.2

