Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D2BEC6FA99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Mar 2023 00:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjCKAog (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 10 Mar 2023 19:44:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjCKAof (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 10 Mar 2023 19:44:35 -0500
Received: from m-r1.th.seeweb.it (m-r1.th.seeweb.it [5.144.164.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C534134AE0
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 Mar 2023 16:44:32 -0800 (PST)
Received: from localhost.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DA57A20084;
        Sat, 11 Mar 2023 01:38:59 +0100 (CET)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     linux-bluetooth@vger.kernel.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Yu Liu <yudiliu@google.com>,
        Bartosz Fabianowski <bartosz@fabianowski.eu>,
        Pauli Virtanen <pav@iki.fi>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v3 1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value
Date:   Sat, 11 Mar 2023 01:38:24 +0100
Message-Id: <20230311003826.454858-2-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311003826.454858-1-marijn.suijten@somainline.org>
References: <20230311003826.454858-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Commit 179ccb936 ("avrcp: Set volume if volume changed event is
registered") introduced a catch that allows SetAbsoluteVolume to be sent
to a remote device that does _not_ implement the AVRCP TG profile.  This
is strange as the TG role is required to be able to send commands to the
peer, but the commit must have been applied to the tree for a reason.

We discussed in [1] that workarounds for dubious peers and software
stacks should be guarded behind a config entry in main.conf, so this
starts out by introducing a new [AVRCP] category to to it that will
later be extended with other workarounds.

[1]: https://marc.info/?l=linux-bluetooth&m=163519566912788&w=2
---
 profiles/audio/avrcp.c | 12 +++++++++---
 src/btd.h              |  5 +++++
 src/main.c             | 13 +++++++++++++
 src/main.conf          |  6 ++++++
 4 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 80f34c7a7..5e6322916 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -48,6 +48,7 @@
 #include "src/dbus-common.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
+#include "src/btd.h"
 
 #include "avctp.h"
 #include "avrcp.h"
@@ -4577,9 +4578,14 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 								&volume);
 	}
 
-	if (!session->controller && !avrcp_event_registered(session,
-					AVRCP_EVENT_VOLUME_CHANGED))
-		return -ENOTSUP;
+	if (btd_opts.avrcp.set_absolute_volume_without_target) {
+		if (!session->controller && !avrcp_event_registered(session,
+						AVRCP_EVENT_VOLUME_CHANGED))
+			return -ENOTSUP;
+	} else {
+		if (!session->controller || session->controller->version < 0x0104)
+			return -ENOTSUP;
+	}
 
 	memset(buf, 0, sizeof(buf));
 
diff --git a/src/btd.h b/src/btd.h
index 42cffcde4..31c04a990 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -97,6 +97,10 @@ struct btd_avdtp_opts {
 	uint8_t  stream_mode;
 };
 
+struct btd_avrcp_opts {
+	gboolean set_absolute_volume_without_target;
+};
+
 struct btd_advmon_opts {
 	uint8_t		rssi_sampling_period;
 };
@@ -136,6 +140,7 @@ struct btd_opts {
 	enum mps_mode_t	mps;
 
 	struct btd_avdtp_opts avdtp;
+	struct btd_avrcp_opts avrcp;
 
 	uint8_t		key_size;
 
diff --git a/src/main.c b/src/main.c
index 99d9c508f..92f74e381 100644
--- a/src/main.c
+++ b/src/main.c
@@ -152,6 +152,11 @@ static const char *avdtp_options[] = {
 	NULL
 };
 
+static const char *avrcp_options[] = {
+	"SetAbsoluteVolumeWithoutTarget",
+	NULL
+};
+
 static const char *advmon_options[] = {
 	"RSSISamplingPeriod",
 	NULL
@@ -167,6 +172,7 @@ static const struct group_table {
 	{ "Policy",	policy_options },
 	{ "GATT",	gatt_options },
 	{ "AVDTP",	avdtp_options },
+	{ "AVRCP",	avrcp_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -975,6 +981,13 @@ static void parse_config(GKeyFile *config)
 		g_free(str);
 	}
 
+	boolean = g_key_file_get_boolean(config, "AVRCP",
+						"SetAbsoluteVolumeWithoutTarget", &err);
+	if (err)
+		g_clear_error(&err);
+	else
+		btd_opts.avrcp.set_absolute_volume_without_target = boolean;
+
 	val = g_key_file_get_integer(config, "AdvMon", "RSSISamplingPeriod",
 									&err);
 	if (err) {
diff --git a/src/main.conf b/src/main.conf
index f187c9aaa..ca00ed03e 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -271,6 +271,12 @@
 # streaming: Use L2CAP Streaming Mode
 #StreamMode = basic
 
+[AVRCP]
+# Allow SetAbsoluteVolume calls to a peer device that
+# does not advertise the AVRCP remote control target
+# profile.
+#SetAbsoluteVolumeWithoutTarget = false
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.39.2

