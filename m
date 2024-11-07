Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47498216A32
	for <linux-bluetooth@vger.kernel.org>; Thu,  7 Nov 2024 22:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.89.224.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731017433; cv=none; b=FOtETt94DOrSzCwnBFdg1CFMijPc384buAMfp2tsDOLRvciXyG9s+OJb4zVcMCCkt2ooEr9M3N4v19YBEBMfWgvfk7gj6XazyNOvLtVE1c9ZAz7NPXs+8UKmgKxP4uYnHsEOM45RasSouvlMdnzpQSYNxOgc31XkLYKiej5bA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731017433; c=relaxed/simple;
	bh=Rn/BY28/ETQUFLWQfJ6nuJQOVRYy4ed4OPZqlCHCESM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dk5UHylAF+kBWvzZmNs7WE9RXpq+ZFNsHbTJLGPUCquDlzgSMtz/n06erxObsrdlsbkwJTxb5OltkFAqT76T4wNSCKUOsSgEIkHyu2c+dQIgGhoOsA1bO+WrEOnfm3KldQhLqo8judTWO7aUx6J+K0fXVCMND0kE/8smF4syY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=YuiLEwU8; arc=none smtp.client-ip=45.89.224.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="YuiLEwU8"
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4354C120031;
	Fri,  8 Nov 2024 01:01:46 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4354C120031
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1731016906;
	bh=n7SQcs1cKIWDl0CRKGv9rkGajvtlhngagBse4iZlLTY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=YuiLEwU80wdroM7bf2vI14zm9dtR1rBAbpzdtcChyVWUGzRSrGRDl34FhnBr1z/OY
	 RQLRAO5C4ckVEuTYc98wesOi64mBm5WD5F80XqykTZcGJQwzmx32itVaqexFosZa2e
	 E+148ehHH9Q9wfb1fxD/YgbXrLxGlA+A1tYr8p0TcbySZFA3MEyMEoGiLSf1ukuIlz
	 PuLCBWQC+LlmZr9mRKU5Q1atIObaqgBiQlAjPxoXTSQ4yclh//JNJUOTBR9yRZUIgx
	 MhlWT5duh1ijbZoeNgiUScN1q1o0IHZv9yWPKQiPx70Q2/mFZU3+U4KNu2QtLv+KTa
	 XF1fjo/oJ7u1A==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Fri,  8 Nov 2024 01:01:46 +0300 (MSK)
From: Victor Pushkarev <VAnPushkarev@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <sdfw_system_team@salutedevices.com>, <corvinus.v@gmail.com>, Victor
 Pushkarev <VAnPushkarev@salutedevices.com>
Subject: [PATCH BlueZ 1/2] main.conf: Introduce option to limit A2DP channels
Date: Fri, 8 Nov 2024 01:01:19 +0300
Message-ID: <20241107220121.97417-2-VAnPushkarev@salutedevices.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
In-Reply-To: <20241107220121.97417-1-VAnPushkarev@salutedevices.com>
References: <20241107220121.97417-1-VAnPushkarev@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-a-m2.sberdevices.ru (172.24.196.120) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 189034 [Nov 07 2024]
X-KSMG-AntiSpam-Version: 6.1.1.7
X-KSMG-AntiSpam-Envelope-From: vanpushkarev@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 41 0.3.41 623e98d5198769c015c72f45fabbb9f77bdb702b, {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;salutedevices.com:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/11/07 18:44:00 #26832432
X-KSMG-AntiVirus-Status: Clean, skipped

This introduces 'Channels' which can be used to
limit the number of A2DP channels.

For new option this also adds a new group A2DP to config.

---
 src/btd.h     |  6 ++++++
 src/main.c    | 15 +++++++++++++++
 src/main.conf |  5 +++++
 3 files changed, 26 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index 07205aa69..c2b6a456e 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -109,6 +109,10 @@ struct btd_avrcp_opts {
 	bool		volume_category;
 };
 
+struct btd_a2dp_opts {
+	uint8_t  channels;
+};
+
 struct btd_advmon_opts {
 	uint8_t		rssi_sampling_period;
 };
@@ -152,6 +156,8 @@ struct btd_opts {
 	struct btd_avdtp_opts avdtp;
 	struct btd_avrcp_opts avrcp;
 
+	struct btd_a2dp_opts a2dp;
+
 	uint8_t		key_size;
 
 	enum jw_repairing_t jw_repairing;
diff --git a/src/main.c b/src/main.c
index 41c3271a7..2c583e611 100644
--- a/src/main.c
+++ b/src/main.c
@@ -168,6 +168,10 @@ static const char *avdtp_options[] = {
 static const char *avrcp_options[] = {
 	"VolumeWithoutTarget",
 	"VolumeCategory",
+};
+
+static const char *a2dp_options[] = {
+	"Channels",
 	NULL
 };
 
@@ -188,6 +192,7 @@ static const struct group_table {
 	{ "CSIS",	csip_options },
 	{ "AVDTP",	avdtp_options },
 	{ "AVRCP",	avrcp_options },
+	{ "A2DP",	a2dp_options },
 	{ "AdvMon",	advmon_options },
 	{ }
 };
@@ -1157,6 +1162,13 @@ static void parse_avrcp(GKeyFile *config)
 		&btd_opts.avrcp.volume_category);
 }
 
+static void parse_a2dp(GKeyFile *config)
+{
+	parse_config_u8(config, "A2DP", "Channels",
+				&btd_opts.a2dp.channels,
+				0, UINT8_MAX);
+}
+
 static void parse_advmon(GKeyFile *config)
 {
 	parse_config_u8(config, "AdvMon", "RSSISamplingPeriod",
@@ -1181,6 +1193,7 @@ static void parse_config(GKeyFile *config)
 	parse_csis(config);
 	parse_avdtp(config);
 	parse_avrcp(config);
+	parse_a2dp(config);
 	parse_advmon(config);
 }
 
@@ -1226,6 +1239,8 @@ static void init_defaults(void)
 	btd_opts.avrcp.volume_without_target = false;
 	btd_opts.avrcp.volume_category = true;
 
+	btd_opts.a2dp.channels = 0;
+
 	btd_opts.advmon.rssi_sampling_period = 0xFF;
 	btd_opts.csis.encrypt = true;
 }
diff --git a/src/main.conf b/src/main.conf
index fff13ed2f..323a2fbbe 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -316,6 +316,11 @@
 # notifications.
 #VolumeCategory = true
 
+[A2DP]
+# Maximum number of A2DP channels
+# Defaults to 0 (unlimited)
+#Channels = 0
+
 [Policy]
 #
 # The ReconnectUUIDs defines the set of remote services that should try
-- 
2.39.3 (Apple Git-146)

