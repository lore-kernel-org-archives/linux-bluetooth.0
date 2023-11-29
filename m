Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="a4VzV1yk"
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 02:17:47 PST
Received: from aer-iport-2.cisco.com (aer-iport-2.cisco.com [173.38.203.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2AA619BB
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Nov 2023 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1673; q=dns/txt; s=iport;
  t=1701253068; x=1702462668;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=azuRch+ty4GbnhjoW5vaRLF5YbSYGRYMJbc2P04cDqs=;
  b=a4VzV1ykX+FGYSoPEZJEyR7N+/lx/SzUhD5X3Fy1zJLxo6Xqkd9VSq3t
   5E7q/9JqUcTluhij60fz5kkmEPpWanZjDdtehXhWAHGj0FDA2bNUqluZt
   ImEGuLny6yOfXizNS7t6rAxy0RcI61f0VYI3oZTKF68t3CMhKN5OzDSvi
   E=;
X-CSE-ConnectionGUID: cJ2fvtKGT+Gg7ZdfloZufA==
X-CSE-MsgGUID: nwtWPhITR2+4UqRUMiZDvQ==
X-IronPort-AV: E=Sophos;i="6.04,235,1695686400"; 
   d="scan'208";a="9768502"
Received: from aer-iport-nat.cisco.com (HELO aer-core-7.cisco.com) ([173.38.203.22])
  by aer-iport-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 10:16:42 +0000
Received: from pwaago-threadripper.rd.cisco.com ([10.47.29.164])
	by aer-core-7.cisco.com (8.15.2/8.15.2) with ESMTP id 3ATAGgAp070729;
	Wed, 29 Nov 2023 10:16:42 GMT
From: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Per=20Waag=C3=B8?= <pwaago@cisco.com>
Subject: [PATCH BlueZ] adapter: Enable SSP after enabling BREDR
Date: Wed, 29 Nov 2023 11:16:27 +0100
Message-ID: <20231129101627.1742015-1-pwaago@cisco.com>
X-Mailer: git-send-email 2.42.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.29.164, [10.47.29.164]
X-Outbound-Node: aer-core-7.cisco.com

When enabling Secure Simple Pairing, the kernel first checks if
BREDR is enabled. If it's not, enabling SSP fails. Therefore, it
is necessary to make sure that BREDR is enabled before enabling
SSP.

Without this fix, bluetoothd would start without SSP enabled if
started in dual or bredr mode after it had been run in le mode.
---
 src/adapter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2c3cf7600..86fff72bc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10229,12 +10229,12 @@ static void read_info_complete(uint8_t status, uint16_t length,
 
 	switch (btd_opts.mode) {
 	case BT_MODE_DUAL:
-		if (missing_settings & MGMT_SETTING_SSP)
-			set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
 		if (missing_settings & MGMT_SETTING_LE)
 			set_mode(adapter, MGMT_OP_SET_LE, 0x01);
 		if (missing_settings & MGMT_SETTING_BREDR)
 			set_mode(adapter, MGMT_OP_SET_BREDR, 0x01);
+		if (missing_settings & MGMT_SETTING_SSP)
+			set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
 		break;
 	case BT_MODE_BREDR:
 		if (!(adapter->supported_settings & MGMT_SETTING_BREDR)) {
@@ -10243,10 +10243,10 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			goto failed;
 		}
 
-		if (missing_settings & MGMT_SETTING_SSP)
-			set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
 		if (missing_settings & MGMT_SETTING_BREDR)
 			set_mode(adapter, MGMT_OP_SET_BREDR, 0x01);
+		if (missing_settings & MGMT_SETTING_SSP)
+			set_mode(adapter, MGMT_OP_SET_SSP, 0x01);
 		if (adapter->current_settings & MGMT_SETTING_LE)
 			set_mode(adapter, MGMT_OP_SET_LE, 0x00);
 		break;
-- 
2.42.1

