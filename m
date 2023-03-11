Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8899C74A4B
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:44:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCKAoj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjCKAof (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:44:35 -0500
X-Greylist: delayed 330 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Mar 2023 16:44:32 PST
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E3110CEAF
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:44:32 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8D1E22008F;
        Sat, 11 Mar 2023 01:39:00 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v3 3/3] audio/avrcp: Determine Absolute Volume support from feature category 2
Date:   Sat, 11 Mar 2023 01:38:26 +0100
Message-Id: <20230311003826.454858-4-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311003826.454858-1-marijn.suijten@somainline.org>
References: <20230311003826.454858-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

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

[1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761
[2]: https://marc.info/?l=linux-bluetooth&m=163463497503113&w=2
---
 profiles/audio/avrcp.c | 16 ++++++++++------
 src/btd.h              |  1 +
 src/main.c             |  8 ++++++++
 src/main.conf          |  6 ++++++
 4 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index c16f9cfef..11f18f25d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -1761,7 +1761,8 @@ static uint8_t avrcp_handle_set_absolute_volume(struct avrcp *session,
 	 * The controller on the remote end is only allowed to call SetAbsoluteVolume
 	 * on our target if it's at least version 1.4 and a category-2 device.
 	 */
-	if (!session->target || session->target->version < 0x0104 ||
+	if (!session->target ||
+			(session->target->version < 0x0104 && !btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) ||
 			!(session->target->features & AVRCP_FEATURE_CATEGORY_2)) {
 		error("Remote SetAbsoluteVolume rejected from non-category-2 peer");
 		goto err;
@@ -4171,13 +4172,15 @@ static void target_init(struct avrcp *session)
 				(1 << AVRCP_EVENT_TRACK_REACHED_END) |
 				(1 << AVRCP_EVENT_SETTINGS_CHANGED);
 
-	if (target->version < 0x0104)
-		return;
-
-	if (target->features & AVRCP_FEATURE_CATEGORY_2)
+	/* Remote device supports receiving volume notifications */
+	if ((target->version >= 0x0104 || btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) &&
+			target->features & AVRCP_FEATURE_CATEGORY_2)
 		session->supported_events |=
 				(1 << AVRCP_EVENT_VOLUME_CHANGED);
 
+	if (target->version < 0x0104)
+		return;
+
 	session->supported_events |=
 				(1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
 				(1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
@@ -4595,7 +4598,8 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 		return -ENOTCONN;
 
 	if (notify) {
-		if (!session->target || session->target->version < 0x0104 ||
+		if (!session->target ||
+				(session->target->version < 0x0104 && !btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct) ||
 				!(session->target->features & AVRCP_FEATURE_CATEGORY_2)) {
 			error("Can't send EVENT_VOLUME_CHANGED to non-category-2 peer");
 			return -ENOTSUP;
diff --git a/src/btd.h b/src/btd.h
index 31c04a990..07d1d961f 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -99,6 +99,7 @@ struct btd_avdtp_opts {
 
 struct btd_avrcp_opts {
 	gboolean set_absolute_volume_without_target;
+	gboolean allow_volume_changed_on_pre_1_4_ct;
 };
 
 struct btd_advmon_opts {
diff --git a/src/main.c b/src/main.c
index 92f74e381..a2b81f940 100644
--- a/src/main.c
+++ b/src/main.c
@@ -154,6 +154,7 @@ static const char *avdtp_options[] = {
 
 static const char *avrcp_options[] = {
 	"SetAbsoluteVolumeWithoutTarget",
+	"AllowVolumeChangedOnPre1_4Controller",
 	NULL
 };
 
@@ -988,6 +989,13 @@ static void parse_config(GKeyFile *config)
 	else
 		btd_opts.avrcp.set_absolute_volume_without_target = boolean;
 
+	boolean = g_key_file_get_boolean(config, "AVRCP",
+						"AllowVolumeChangedOnPre1_4Controller", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		btd_opts.avrcp.allow_volume_changed_on_pre_1_4_ct = boolean;
+
 	val = g_key_file_get_integer(config, "AdvMon", "RSSISamplingPeriod",
 									&err);
 	if (err) {
diff --git a/src/main.conf b/src/main.conf
index ca00ed03e..286d092bf 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -277,6 +277,12 @@
 # profile.
 #SetAbsoluteVolumeWithoutTarget = false
 
+# Allow peer AVRCP controller with version 1.3 access to category-2 (absolute volume) features.
+# This is common for AOSP to not signal the desired minimum version of 1.4 while still supporting
+# absolute volume based on the feature category bit, as mentioned in the comment:
+# https://android.googlesource.com/platform/system/bt/+/android-12.0.0_r1/bta/av/bta_av_main.cc#621
+AllowVolumeChangedOnPre1_4Controller = true
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.39.2

