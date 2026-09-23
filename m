Received: from mx5.sberdevices.ru (mx5.sberdevices.ru [95.181.183.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FB03F23C0
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 09:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.181.183.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790155125; cv=none; b=Ykuqt6RjwzhPevHn3F4jksQt9v5zeFTBJUsSlySITEGsclNKShSZO2rusptQk8nCYfSxsqerBbSbmBXxg6OmifIdDesnrAnjp1qwBOnApzRSEyjITItS5rLIz2/sSbT8QOiiT8IF2k87LAou0KSqbEmB9zfa+g8dU/7VxFyk5M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790155125; c=relaxed/simple;
	bh=9OBxz+ktt0sYaysaX+EM0Vpur97l4M6wKwc1qmI9C4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QHXvIdIexwYLGFx5A4iysNrBa9G6mmZpFrb8SwEl9uoyM2Nlkp/KijZhCijmknXen30ltKgkd0h3z4PQgEZmy/3fzoMPm+2alSsMCu7+mPlK3ib/dGppplBlu/LAUmAYLBwqBmZra/Jh+ylA9n5JdVHYm36KGCOThCKqNYD5wO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=ACT+sHaJ; arc=none smtp.client-ip=95.181.183.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="ACT+sHaJ"
Received: from p-antispam-ksmg-gc-msk01.sberdevices.ru (localhost [127.0.0.1])
	by mx5.sberdevices.ru (Postfix) with ESMTP id F2CB1240033
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:18:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx5.sberdevices.ru F2CB1240033
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=post; t=1790155119;
	bh=jNJEesT9DJJFQK2d8T1eLiJwhXAo6VxV7iJjA9h47UE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=ACT+sHaJqBups9KuEKVTbfIDHfd55qyfXPjv8qxQRS18OywpA83TVo/roWkH4rD9d
	 loqcNc3nAUnVlysozDdbVzT7qHrkKnw+iay/yuXBi9VIku8LmcYj3hfmCqPte/sLL9
	 RjkeLMwxgYl74YXG4WobwBScIl59q7CfQJhuVR6tJh+ti/wVgRRgyOQfeN2b1eFqep
	 B+pkph2+9CMWoj6Dx5TGLmmGNW4NghB+18Jexl+toadIH1Ycfkukcticfax+VSCQuM
	 UUaEoODiuSSAcIAE39sJioossvUsaodQbTMgnvqVZ2MSBzmsQ1GRFD9dXRMw/0A4eS
	 ha+8ElUXICVOQ==
Received: from smtp.sberdevices.ru (p-exch-cas-s-m1.sberdevices.ru [172.16.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "sberdevices.ru", Issuer "YR2" (not verified))
	by mx5.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Wed, 23 Sep 2026 12:18:39 +0300 (MSK)
From: Pavel Bozhko <pvbozhko@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Pavel Bozhko <pvbozhko@salutedevices.com>
Subject: [PATCH BlueZ v2 1/1] audio/avrcp: Add AvrcpVersion config option
Date: Wed, 23 Sep 2026 12:18:27 +0300
Message-ID: <20260923091827.4496-2-pvbozhko@salutedevices.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260923091827.4496-1-pvbozhko@salutedevices.com>
References: <20260923091827.4496-1-pvbozhko@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-exch-cas-s-m2.sberdevices.ru (172.16.210.3) To
 p-exch-cas-s-m1.sberdevices.ru (172.16.210.2)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Envelope-From: pvbozhko@salutedevices.com
X-KSMG-AntiSpam-Info: LuaCore: 123 0.3.123 0a3d77c148601a24a80cc37b49c8995c1e141098, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;salutedevices.com:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:7.1.1,5.0.1, FromAlignment: s
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 206187 [Sep 23 2026]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.27
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2026/09/23 06:24:00 #28613519
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-KATA-Status: Not Scanned
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5

Some devices advertise AVRCP 1.3 in SDP but still support absolute
volume (SetAbsoluteVolume and EVENT_VOLUME_CHANGED), which the
specification introduced in version 1.4.  Examples include certain
TVs such as LG webOS UM7450PLA and Xiaomi Mi TV 4A 43 when acting
as the audio source.

Add an AvrcpVersion option under [AVRCP] and apply it to the target
in target_init(), so the version check in avrcp_volume_supported()
can succeed for such peers.
---
v2: wrap DBG() arguments to stay within 80 columns

 profiles/audio/avrcp.c |  7 +++++++
 src/btd.h              |  1 +
 src/main.c             | 32 ++++++++++++++++++++++++++++++++
 src/main.conf          |  8 ++++++++
 4 files changed, 48 insertions(+)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index df5f97eaf..79fe0c04e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -4304,6 +4304,13 @@ static void target_init(struct avrcp *session)
 	target = data_init(session, AVRCP_REMOTE_UUID);
 	session->target = target;
 
+	if (btd_opts.avrcp.version &&
+			target->version < btd_opts.avrcp.version) {
+		DBG("Forcing AVRCP version 0x%04x (SDP 0x%04x)",
+				btd_opts.avrcp.version, target->version);
+		target->version = btd_opts.avrcp.version;
+	}
+
 	DBG("%p version 0x%04x", target, target->version);
 
 	btd_service_connecting_complete(service, 0);
diff --git a/src/btd.h b/src/btd.h
index d70276b1d..4ae46100d 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -124,6 +124,7 @@ struct btd_avdtp_opts {
 struct btd_avrcp_opts {
 	bool		volume_without_target;
 	bool		volume_category;
+	uint16_t	version;
 };
 
 struct btd_advmon_opts {
diff --git a/src/main.c b/src/main.c
index c7a55d30f..763fd2c8d 100644
--- a/src/main.c
+++ b/src/main.c
@@ -181,6 +181,7 @@ static const char *avdtp_options[] = {
 static const char *avrcp_options[] = {
 	"VolumeWithoutTarget",
 	"VolumeCategory",
+	"AvrcpVersion",
 	NULL
 };
 
@@ -1350,6 +1351,35 @@ static void parse_avdtp(GKeyFile *config)
 	parse_avdtp_stream_mode(config);
 }
 
+static void parse_avrcp_version(GKeyFile *config)
+{
+	char *str = NULL;
+	char *endptr = NULL;
+	unsigned int major, minor;
+	unsigned long val;
+	int n = 0;
+
+	if (!parse_config_string(config, "AVRCP", "AvrcpVersion", &str))
+		return;
+
+	if (sscanf(str, "%u.%u%n", &major, &minor, &n) == 2 && !str[n] &&
+					major <= 0xff && minor <= 0xff) {
+		btd_opts.avrcp.version = (major << 8) | minor;
+		g_free(str);
+		return;
+	}
+
+	val = strtoul(str, &endptr, 0);
+	if (endptr && *endptr == '\0' && val > 0 && val <= 0xffff) {
+		btd_opts.avrcp.version = val;
+		g_free(str);
+		return;
+	}
+
+	error("Invalid AVRCP version \"%s\"", str);
+	g_free(str);
+}
+
 static void parse_avrcp(GKeyFile *config)
 {
 	parse_config_bool(config, "AVRCP",
@@ -1358,6 +1388,7 @@ static void parse_avrcp(GKeyFile *config)
 	parse_config_bool(config, "AVRCP",
 		"VolumeCategory",
 		&btd_opts.avrcp.volume_category);
+	parse_avrcp_version(config);
 }
 
 static void parse_advmon(GKeyFile *config)
@@ -1433,6 +1464,7 @@ static void init_defaults(void)
 
 	btd_opts.avrcp.volume_without_target = false;
 	btd_opts.avrcp.volume_category = true;
+	btd_opts.avrcp.version = 0;
 
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
diff --git a/src/main.conf b/src/main.conf
index 1d8e97dc6..79048ea25 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -380,6 +380,14 @@
 # notifications.
 #VolumeCategory = true
 
+# Override the AVRCP version used for the local Target role.  Some peers
+# report an older profile version (e.g. 1.3) while still supporting features
+# introduced later, such as absolute volume (SetAbsoluteVolume and
+# EVENT_VOLUME_CHANGED, AVRCP 1.4).
+# Possible values: 1.3, 1.4, 1.5, 1.6 or hexadecimal (e.g. 0x0104).
+# Defaults to using the version from the remote SDP record.
+#AvrcpVersion = 1.4
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.50.1 (Apple Git-155)
