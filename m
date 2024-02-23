Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A13510A3E
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 15:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702197; cv=none; b=GJVQtq1jA8hElOsTrJQqIhyd2ymRDA4lYC8ZBzxxmMnlcnOCnNr3jts4Za4f7Fwm+Zu4VR/FvpqpXm0R5m9wve7270rtf2aTdhaYylPH06VSev/ruOlflet/g3GaI+eCEtNRUcEfZnAU3/zeT5OffO4NngYsj/BWBY0EC6zPmgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702197; c=relaxed/simple;
	bh=RmSFB7vsvoy4BSKSc7VgOe/HEezrLFHG1NqESxIuDas=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BqLFag26aXK/OCyYTh1VDAQvD/u/uotyyd6e2mWiQ1cEdEsAZxmeZ4bdsn9xXOmYASEiqydk0R7wuaZVNcLMLkk+9Kv4EEDS36ILkq+P926xIx9p5+zTCuHbT1GYC06XEnnMnWYwoKZodXyKME7qWfgYFO6U1EQEemP3CG+nC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=BKyuI0Vq; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="BKyuI0Vq"
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id 4E98F100004
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 18:29:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 4E98F100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1708702190;
	bh=EwPpgCxAu91N/TpmHrnX5/ujbe8jUxn7Yr1qVZVj0qo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=BKyuI0VqLfSMqSR+usjMeAIFCp36uK/7+LsK237gRhs5/G0Ej+PRwD1ubsg3ugtjz
	 trfkCTnMGtcsM340Tejq39nPFtxZhUqZOuZwUKB5WEeuYgI36En5e5XYfjxmagYH5X
	 UrzKrNZJVdF2ReQibhp2JRVtw94ehoti9qoX5rdQ5DOcfTVU4Fx48pKmigr+y0Xjsx
	 YdWqn5T14vNSjQ7Z7+h/7UVhxF/XQiY5JGrFX44WBjhccw3zxmncypz69fnQcgOGxo
	 LKOM10g049X3EGs4JkkNPj2k2an/DWMKccPc59Z+74MsBjt8AYQhmzp/IiISaq73ce
	 vvyImyv2x5BhQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 18:29:49 +0300 (MSK)
Received: from nibiru.lan (100.64.160.123) by p-i-exch-sc-m01.sberdevices.ru
 (172.16.192.107) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 23 Feb
 2024 18:29:49 +0300
From: Sergey Bobrenok <sibobrenok@salutedevices.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Sergey Bobrenok <sibobrenok@salutedevices.com>
Subject: [PATCH] main.conf: Introduce GATT.ReverseClient option
Date: Fri, 23 Feb 2024 18:29:40 +0300
Message-ID: <20240223152940.40099-1-sibobrenok@salutedevices.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183695 [Feb 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: sibobrenok@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2;smtp.sberdevices.ru:5.0.1,7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/23 13:07:00 #23766132
X-KSMG-AntiVirus-Status: Clean, skipped

General.ReverseServiceDiscovery option is responsible for two
different things:
 1. It disables SDP reverse discovering. As a side effect, some BR/EDR
 profiles cannot operate properly. E.g. AVRCP-target profile needs SDP
 results to determine the peer's AVRCP version.
 2. It disables GATT-client creation back to the GATT connection
 initiator. It may be useful for peripheral devices, especially if the
 peer doesn't expect them to connect back (and currently some IOS
 versions don't). This behavior was introduced in
 8de73cd12 ("main.conf: Make ReverseServiceDiscovery work with LE")

For peripheral devices implementing only A2DP-sink, AVRCP-target, and
GATT profiles (e.g. BT loudspeakers), it may be useful to disable
GATT-client functionality, but still have SDP reverse discovering.

Unfortunately, splitting the General.ReverseServiceDiscovery option
into two different options will break backward compatibility on the
configuration file level. So a new configuration option has been
introduced in addition to the old one.

Signed-off-by: Sergey Bobrenok <sibobrenok@salutedevices.com>
---
 src/btd.h     | 1 +
 src/device.c  | 4 ++++
 src/main.c    | 4 ++++
 src/main.conf | 7 ++++++-
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/btd.h b/src/btd.h
index 7166e2168..f85b119b7 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -140,6 +140,7 @@ struct btd_opts {
 	bt_gatt_cache_t gatt_cache;
 	uint16_t	gatt_mtu;
 	uint8_t		gatt_channels;
+	gboolean	gatt_reverse_client;
 	enum mps_mode_t	mps;
 
 	struct btd_avdtp_opts avdtp;
diff --git a/src/device.c b/src/device.c
index 1db96d9a6..e8d66ffe4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5452,6 +5452,10 @@ static void gatt_client_init(struct btd_device *device)
 		DBG("Reverse service discovery disabled: skipping GATT client");
 		return;
 	}
+	if (!device->connect && !btd_opts.gatt_reverse_client) {
+		DBG("Reverse gatt client disabled: skipping GATT client");
+		return;
+	}
 
 	device->client = bt_gatt_client_new(device->db, device->att,
 							device->att_mtu, 0);
diff --git a/src/main.c b/src/main.c
index b1339c230..f0c2c4311 100644
--- a/src/main.c
+++ b/src/main.c
@@ -145,6 +145,7 @@ static const char *gatt_options[] = {
 	"KeySize",
 	"ExchangeMTU",
 	"Channels",
+	"ReverseClient",
 	NULL
 };
 
@@ -1058,6 +1059,8 @@ static void parse_gatt(GKeyFile *config)
 				BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU);
 	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
 				1, 5);
+	parse_config_bool(config, "GATT", "ReverseClient",
+				&btd_opts.gatt_reverse_client);
 }
 
 static void parse_csis_sirk(GKeyFile *config)
@@ -1190,6 +1193,7 @@ static void init_defaults(void)
 	btd_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
 	btd_opts.gatt_channels = 1;
+	btd_opts.gatt_reverse_client = TRUE;
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
diff --git a/src/main.conf b/src/main.conf
index 085c81a46..a617eec6b 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -33,7 +33,7 @@
 # us. For BR/EDR this option is really only needed for qualification since the
 # BITE tester doesn't like us doing reverse SDP for some test cases, for LE
 # this disables the GATT client functionally so it can be used in system which
-# can only operate as peripheral.
+# can only operate as peripheral (see also GATT ReverseClient).
 # Defaults to 'true'.
 #ReverseServiceDiscovery = true
 
@@ -283,6 +283,11 @@
 # Defaults to 0
 #Rank = 0
 
+# This disables the GATT client functionally so it can be used in system which
+# can only operate as peripheral.
+# Defaults to 'true'.
+#ReverseClient = true
+
 [AVDTP]
 # AVDTP L2CAP Signalling Channel Mode.
 # Possible values:

base-commit: a16c2ccf9c256285188f4549b7b767cf31b100eb
-- 
2.43.2

