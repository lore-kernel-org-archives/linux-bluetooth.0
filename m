Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [5.144.164.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20114171088
	for <linux-bluetooth@vger.kernel.org>; Sat,  5 Oct 2024 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.144.164.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728165010; cv=none; b=IIA42YAGgt7UIhJxjOJTnw6JZ5wb38XY8Z9subR+bev87t17179eRTIzoIOIhtkJ+bG1j9VZNCY5slrMj7B9w/GZiRDPI+uNuztXBGBCiyRNppvkmAA8N2IPpgaWrsIY0jAAhCTDYeHV85u5Sjt6ptwxiAm5MFkPuSK0vFRHsB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728165010; c=relaxed/simple;
	bh=NQ8oHyAK5DK5N2JIoQO0q21RhpsMba9BN8GC+sW2UIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bR4fgfF4kfjzphnB+ZhUrymSHQKE6/L/DhU50v4breh5+F8w1095/FHncBkPqtkYnvBgU1P2PeYdSo27esA+qbAvcIhQh1cNMJJGDHot84NuR7f3y3gUB8lpIir5xOhDYDEIblpZ/IiSRXBCM0uhOlCaX2yo5tGQqh4yJRNS65w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org; spf=pass smtp.mailfrom=somainline.org; arc=none smtp.client-ip=5.144.164.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=somainline.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=somainline.org
Received: from Marijn-Arch-PC.localdomain (94-211-6-86.cable.dynamic.v4.ziggo.nl [94.211.6.86])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by m-r1.th.seeweb.it (Postfix) with ESMTPSA id DBCC11F925;
	Sat,  5 Oct 2024 23:43:22 +0200 (CEST)
From: Marijn Suijten <marijn.suijten@somainline.org>
To: linux-bluetooth@vger.kernel.org
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
	Yu Liu <yudiliu@google.com>,
	Bartosz Fabianowski <bartosz@fabianowski.eu>,
	Pauli Virtanen <pav@iki.fi>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Marek Czerski <ma.czerski@gmail.com>
Subject: [PATCH BlueZ v4 1/3] audio/avrcp: Guard SetAbsoluteVolume without target behind config value
Date: Sat,  5 Oct 2024 23:43:06 +0200
Message-ID: <20241005214321.84250-2-marijn.suijten@somainline.org>
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

Commit 179ccb936 ("avrcp: Set volume if volume changed event is
registered") invented a workaround that allows SetAbsoluteVolume to be
sent to a remote device that does _not_ implement the AVRCP TG profile,
as long as it previously registered for the EVENT_VOLUME_CHANGED
notification.  This is strange as the TG role is required to be able to
send commands to the peer, but the commit must have been applied to the
tree for a reason.

We discussed in [1] that workarounds for dubious peers and software
stacks should be guarded behind a config entry in main.conf, so this
starts out by introducing a new [AVRCP] category that will later be
extended with other workarounds.  It guards the changed functionality
behind a `VolumeWithoutTarget = false` boolean to disallow this obscure
check.

[1]: https://lore.kernel.org/linux-bluetooth/20211025210206.bkt5wovzmkmt6teg@SoMainline.org/
---
 profiles/audio/avrcp.c | 16 +++++++++++++---
 src/btd.h              |  5 +++++
 src/main.c             | 16 ++++++++++++++++
 src/main.conf          |  6 ++++++
 4 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 1622734b3..553673b19 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -48,6 +48,7 @@
 #include "src/dbus-common.h"
 #include "src/shared/timeout.h"
 #include "src/shared/util.h"
+#include "src/btd.h"
 
 #include "avctp.h"
 #include "avrcp.h"
@@ -4670,9 +4671,18 @@ int avrcp_set_volume(struct btd_device *dev, int8_t volume, bool notify)
 								&volume);
 	}
 
-	if (!session->controller && !avrcp_event_registered(session,
-					AVRCP_EVENT_VOLUME_CHANGED))
-		return -ENOTSUP;
+	if (btd_opts.avrcp.volume_without_target) {
+		/* If there is no target profile (we didn't create a controller for it),
+		 * allow the call to pass through if the remote controller registered
+		 * for a volume changed event.
+		 */
+		if (!session->controller && !avrcp_event_registered(session,
+						AVRCP_EVENT_VOLUME_CHANGED))
+			return -ENOTSUP;
+	} else {
+		if (!session->controller || session->controller->version < 0x0104)
+			return -ENOTSUP;
+	}
 
 	memset(buf, 0, sizeof(buf));
 
diff --git a/src/btd.h b/src/btd.h
index 383bd7c19..147b61f12 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -104,6 +104,10 @@ struct btd_avdtp_opts {
 	uint8_t  stream_mode;
 };
 
+struct btd_avrcp_opts {
+	bool		volume_without_target;
+};
+
 struct btd_advmon_opts {
 	uint8_t		rssi_sampling_period;
 };
@@ -145,6 +149,7 @@ struct btd_opts {
 	enum mps_mode_t	mps;
 
 	struct btd_avdtp_opts avdtp;
+	struct btd_avrcp_opts avrcp;
 
 	uint8_t		key_size;
 
diff --git a/src/main.c b/src/main.c
index 69ae1b1e3..5bd3a035d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -165,6 +165,11 @@ static const char *avdtp_options[] = {
 	NULL
 };
 
+static const char *avrcp_options[] = {
+	"VolumeWithoutTarget",
+	NULL
+};
+
 static const char *advmon_options[] = {
 	"RSSISamplingPeriod",
 	NULL
@@ -181,6 +186,7 @@ static const struct group_table {
 	{ "GATT",	gatt_options },
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
+	{ "AVRCP",	avrcp_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -1140,6 +1146,13 @@ static void parse_avdtp(GKeyFile *config)
 	parse_avdtp_stream_mode(config);
 }
 
+static void parse_avrcp(GKeyFile *config)
+{
+	parse_config_bool(config, "AVRCP",
+		"VolumeWithoutTarget",
+		&btd_opts.avrcp.volume_without_target);
+}
+
 static void parse_advmon(GKeyFile *config)
 {
 	parse_config_u8(config, "AdvMon", "RSSISamplingPeriod",
@@ -1163,6 +1176,7 @@ static void parse_config(GKeyFile *config)
 	parse_gatt(config);
 	parse_csis(config);
 	parse_avdtp(config);
+	parse_avrcp(config);
 	parse_advmon(config);
 }
 
@@ -1205,6 +1219,8 @@ static void init_defaults(void)
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
 
+	btd_opts.avrcp.volume_without_target = false;
+
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
 }
diff --git a/src/main.conf b/src/main.conf
index 82040b3fa..5d206b9ec 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -305,6 +305,12 @@
 # streaming: Use L2CAP Streaming Mode
 #StreamMode = basic
 
+[AVRCP]
+# Allow SetAbsoluteVolume calls to a peer device that does not advertise the
+# AVRCP remote control target profile.  If it does advertise this profile, the
+# version is ignored.
+#VolumeWithoutTarget = false
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.46.2

