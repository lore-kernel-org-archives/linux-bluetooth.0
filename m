Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1503E6BFCA
	for <linux-bluetooth@vger.kernel.org>; Thu, 14 Mar 2024 10:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.18.73.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411532; cv=none; b=h6xt+Ucb0IDXsU/V+ehuV9mTlvANopXzbH8xH5wNRiSmKMNt4YJuKycuc+X1+1WhjuSnIi9wUDa2D1eamuX37RSU9DvUGIUxi02OLwSLeQynyOM90NdtSuljUQvltYUK0eZS0X3V+nD9XSfqyOU31xlPZWms2PQJ+t9/1/N6YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411532; c=relaxed/simple;
	bh=JzOa1BfdqdOpsxeOVUI8c/fsUp5MriZUDOPaicIGh3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DH6q4EX2t0DT5oS3GTH3B8/2TdrpVpc4uZOASjq/fRRs0LsJXoPA6C7cn/C5vE3wGILWwyAABpLG17VQ4Dut3LMXEQo9TjWg+aO71V/w97CoS8vh2OFjBykjO4E88RH0wz1Go6E3jAd8oH3gLbmwP9ESPCDeHDaS7Z2OgR+nU/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com; spf=pass smtp.mailfrom=salutedevices.com; dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b=IvX/n8Ml; arc=none smtp.client-ip=37.18.73.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salutedevices.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salutedevices.com header.i=@salutedevices.com header.b="IvX/n8Ml"
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
	by mx1.sberdevices.ru (Postfix) with ESMTP id CBF04100007;
	Thu, 14 Mar 2024 13:18:45 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru CBF04100007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
	s=mail; t=1710411525;
	bh=hikIJxXZMaoQLbCjmy7a7ejg/o7C3Fi9pG2w4+Lauxc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=IvX/n8MlQZReQMhMMK1+FzSN3xD8+HB2VZNVoX+3n1OyqqvBkCLD2oM7cblTUqPOQ
	 w2pgSuotxnHIDQQTbTrqN11dpSn8w/C0hst7/Tvaza5lBi8Lq719hl47CpRvkCSCzF
	 P/ucLety37VRBN+2dZYDythS5UfsntFZBXs9MAPGKBAnaP51099mPCbU9Ba9DZkzx1
	 hdCDGEdEwxomA3u3Q+duC5ev6f7/9PoEFIuLenPUUdF+BtnZmDg8qlatFSRRl7dAj2
	 Di6NxAj6l1MhdSmSPZJ4dmsFqcP9QRGsDtQ3K+73RugYn21uBB2KjVhL5Hp6+tNeRy
	 y11o+Uamje6yQ==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru [172.16.192.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.sberdevices.ru (Postfix) with ESMTPS;
	Thu, 14 Mar 2024 13:18:45 +0300 (MSK)
Received: from a520m-ds3h-601005.sberdevices.ru (100.64.160.123) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Mar 2024 13:18:44 +0300
From: Sergey Bobrenok <sibobrenok@salutedevices.com>
To: <luiz.dentz@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>, <sibobrenok@salutedevices.com>
Subject: [PATCH v2] main.conf: Introduce GATT.Client option
Date: Thu, 14 Mar 2024 13:17:08 +0300
Message-ID: <20240314101708.144166-1-sibobrenok@salutedevices.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJYd-6f3qq6S-Km6M2Wr-QOc2UydKx26hR=A8n-375HQw@mail.gmail.com>
References: <CABBYNZJYd-6f3qq6S-Km6M2Wr-QOc2UydKx26hR=A8n-375HQw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 183875 [Feb 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: sibobrenok@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2024/02/29 19:21:00 #23899999
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
Changes v1 -> v2:
  - replace gboolean with bool
  - rename ReverseClient option to Client
---
 src/btd.h     | 1 +
 src/device.c  | 4 ++++
 src/main.c    | 3 +++
 src/main.conf | 7 ++++++-
 4 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/src/btd.h b/src/btd.h
index 7166e2168..8c80059ac 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -140,6 +140,7 @@ struct btd_opts {
 	bt_gatt_cache_t gatt_cache;
 	uint16_t	gatt_mtu;
 	uint8_t		gatt_channels;
+	bool		gatt_client;
 	enum mps_mode_t	mps;
 
 	struct btd_avdtp_opts avdtp;
diff --git a/src/device.c b/src/device.c
index aecceb100..294869aac 100644
--- a/src/device.c
+++ b/src/device.c
@@ -5511,6 +5511,10 @@ static void gatt_client_init(struct btd_device *device)
 		DBG("Reverse service discovery disabled: skipping GATT client");
 		return;
 	}
+	if (!device->connect && !btd_opts.gatt_client) {
+		DBG("GATT client disabled: skipping GATT client");
+		return;
+	}
 
 	device->client = bt_gatt_client_new(device->db, device->att,
 							device->att_mtu, 0);
diff --git a/src/main.c b/src/main.c
index b1339c230..f774670e4 100644
--- a/src/main.c
+++ b/src/main.c
@@ -145,6 +145,7 @@ static const char *gatt_options[] = {
 	"KeySize",
 	"ExchangeMTU",
 	"Channels",
+	"Client",
 	NULL
 };
 
@@ -1058,6 +1059,7 @@ static void parse_gatt(GKeyFile *config)
 				BT_ATT_DEFAULT_LE_MTU, BT_ATT_MAX_LE_MTU);
 	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
 				1, 5);
+	parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client);
 }
 
 static void parse_csis_sirk(GKeyFile *config)
@@ -1190,6 +1192,7 @@ static void init_defaults(void)
 	btd_opts.gatt_cache = BT_GATT_CACHE_ALWAYS;
 	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
 	btd_opts.gatt_channels = 1;
+	btd_opts.gatt_client = true;
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
diff --git a/src/main.conf b/src/main.conf
index 085c81a46..815f1c0f8 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -33,7 +33,7 @@
 # us. For BR/EDR this option is really only needed for qualification since the
 # BITE tester doesn't like us doing reverse SDP for some test cases, for LE
 # this disables the GATT client functionally so it can be used in system which
-# can only operate as peripheral.
+# can only operate as peripheral (see also GATT Client option).
 # Defaults to 'true'.
 #ReverseServiceDiscovery = true
 
@@ -283,6 +283,11 @@
 # Defaults to 0
 #Rank = 0
 
+# This enables the GATT client functionally, so it can be disabled in system
+# which can only operate as a peripheral.
+# Defaults to 'true'.
+#Client = true
+
 [AVDTP]
 # AVDTP L2CAP Signalling Channel Mode.
 # Possible values:

base-commit: 3ad367874630bb62719ea02184a473cb1efeca34
-- 
2.34.1

