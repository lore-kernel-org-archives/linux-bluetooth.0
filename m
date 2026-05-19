Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66633A71B
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 10:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779188132; cv=none; b=nmNL/kBzn8hjs4KaDVxHpXnzVxLRE2INUZd8D5hkmhy7xP7LH7/2jdxmlGwXDChZlLkCvkRe1ipJ8BhOaRpZSWTUXhzPIoiTAsp9vruFPMiYojDEnb2v+nj1K5GpkXkYEwhVNKqtcF2qhMEf5FjcL0GjUTXVW32w8tf7zFOP8z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779188132; c=relaxed/simple;
	bh=mqYU1/u9xpUS3JkYozdyc1AecTYMIk5VO0WWxONmTBs=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOzW6CyQhTsqfPShNQMP2IMozRBFCwfy3enomPXkUS1i0EuC84RLvyFgWP9GSsYWHUf1GGxRkr55jLsyQF6IkcHDVq2+JpT8TH6AIKPM8x9jmneIx9XU8j4lnq/1fz2xnEYnrqHaTcKKD2qHNJtxHakkia5BnUshSEzUp1qfd/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cVy37XpP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cVy37XpP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779188125;
	bh=mqYU1/u9xpUS3JkYozdyc1AecTYMIk5VO0WWxONmTBs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=cVy37XpPb1NPQk3Jk5Etf4uJqMGNjB+py0fAUTc57rQTnpz5n7wIBoQgqVSq1mUk1
	 prNi4rUlsvtmnj6JSFwQjFCFAXzSPN9l/kg2r3rtv3OJmZ8wt2DavCzn5D9X31jEiN
	 SIE+Z44czzp/LV+A9SrRrGzmdBoclKeWh2/k0L6PDIO6AhS7EQyV8XCjKtxjeaJjj9
	 5DPCmR5FL+5cjxVFR6uiM3wARWWxblSSPdjx+qWTeoXQdyID9YR4g0+Bnybl5XjX+O
	 +92Vyks8RB3s24/cvoT2GU2xbIaeoh+GpFSLe+uUY9x7uS9AXXZ46sJVBUPLBsnBMG
	 y4axehCRpfr1w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0008217E1305
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 May 2026 12:55:24 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] client/btpclient: Replace advertising defines by shared ones
Date: Tue, 19 May 2026 12:55:18 +0200
Message-ID: <20260519105519.226648-3-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519105519.226648-1-frederic.danis@collabora.com>
References: <20260519105519.226648-1-frederic.danis@collabora.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The advertisement types are already defined in src/shared/ad.h
---
 client/btpclient/gap.c | 44 ++++++++++++++++--------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

diff --git a/client/btpclient/gap.c b/client/btpclient/gap.c
index 916626f1d..2d393dd4d 100644
--- a/client/btpclient/gap.c
+++ b/client/btpclient/gap.c
@@ -17,6 +17,7 @@
 
 #include "bluetooth/bluetooth.h"
 #include "bluetooth/uuid.h"
+#include "src/shared/ad.h"
 #include "src/shared/btp.h"
 #include "btpclient.h"
 #include "core.h"
@@ -27,17 +28,6 @@
 #define AD_IFACE "org.bluez.LEAdvertisement1"
 #define AG_IFACE "org.bluez.Agent1"
 
-/* List of assigned numbers for advertising data and scan response */
-#define AD_TYPE_FLAGS				0x01
-#define AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST	0x02
-#define AD_TYPE_SHORT_NAME			0x08
-#define AD_TYPE_COMPLETE_NAME			0x09
-#define AD_TYPE_TX_POWER			0x0a
-#define AD_TYPE_SOLICIT_UUID16_SERVICE_LIST	0x14
-#define AD_TYPE_SERVICE_DATA_UUID16		0x16
-#define AD_TYPE_APPEARANCE			0x19
-#define AD_TYPE_MANUFACTURER_DATA		0xff
-
 static void register_gap_service(void);
 
 static struct l_dbus *dbus;
@@ -899,7 +889,7 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 		ad_data = &data[adv_data_len - remaining_data_len + 2];
 
 		switch (ad_type) {
-		case AD_TYPE_INCOMPLETE_UUID16_SERVICE_LIST:
+		case BT_AD_UUID16_SOME:
 		{
 			char *uuid = dupuuid2str(ad_data, 16);
 
@@ -907,20 +897,28 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 
 			break;
 		}
-		case AD_TYPE_SHORT_NAME:
-		case AD_TYPE_COMPLETE_NAME:
+		case BT_AD_NAME_SHORT:
+		case BT_AD_NAME_COMPLETE:
 			ad.local_name = malloc(ad_len + 1);
 			memcpy(ad.local_name, ad_data, ad_len);
 			ad.local_name[ad_len] = '\0';
 
 			break;
-		case AD_TYPE_TX_POWER:
+		case BT_AD_TX_POWER:
 			ad.tx_power = true;
 
 			/* XXX Value is omitted cause, stack fills it */
 
 			break;
-		case AD_TYPE_SERVICE_DATA_UUID16:
+		case BT_AD_SOLICIT16:
+		{
+			char *uuid = dupuuid2str(ad_data, 16);
+
+			l_queue_push_tail(ad.solicits, uuid);
+
+			break;
+		}
+		case BT_AD_SERVICE_DATA16:
 		{
 			struct service_data *sd;
 
@@ -933,11 +931,11 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 
 			break;
 		}
-		case AD_TYPE_APPEARANCE:
+		case BT_AD_GAP_APPEARANCE:
 			memcpy(&ad.local_appearance, ad_data, ad_len);
 
 			break;
-		case AD_TYPE_MANUFACTURER_DATA:
+		case BT_AD_MANUFACTURER_DATA:
 		{
 			struct manufacturer_data *md;
 
@@ -954,14 +952,6 @@ static void create_advertising_data(uint8_t adv_data_len, const uint8_t *data)
 
 			break;
 		}
-		case AD_TYPE_SOLICIT_UUID16_SERVICE_LIST:
-		{
-			char *uuid = dupuuid2str(ad_data, 16);
-
-			l_queue_push_tail(ad.solicits, uuid);
-
-			break;
-		}
 		default:
 			l_info("Unsupported advertising data type");
 
@@ -2455,7 +2445,7 @@ static void btp_gap_device_found_ev(struct l_dbus_proxy *proxy)
 				ev->eir_len);
 			eir = &ev->eir[ev->eir_len - n - 4];
 			eir[0] = n + 3;
-			eir[1] = AD_TYPE_MANUFACTURER_DATA;
+			eir[1] = BT_AD_MANUFACTURER_DATA;
 			eir[2] = key >> 8;
 			eir[3] = key & 0xFF;
 			memcpy(&eir[4], data, n);
-- 
2.43.0

