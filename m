Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013002.outbound.protection.outlook.com [52.101.72.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B55427A45C
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Feb 2026 16:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772036425; cv=fail; b=MlVi21LvAD2lepTckLiYf6SqFsvuWudxHNX157JNqwglQjPEcsXmJMzOtZHWBBjvijGJMchVJiAczk9rpcAd/0Q06iOBXVpyETRKdpkZx2NJ9aRF0iNpOoDvug06LrNqTJpOtR5UoXd6khE++rhEYwKRPWtgz4zp51KPKebguVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772036425; c=relaxed/simple;
	bh=YK4wUMySraDUM8PKPJC0KbKBA3LWBmrmamt51GmP79c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FB9nE23Mx0sZptPOG3HjZcbSY+SIgj474mLKYOoVNpPjO/XLLOm0o5G58Vmo+JrO1ike3ljWuiQ9m9rEt1tZvxP7mU6WVxnBplSUIEPy2HbQOzalr/j+xJJBVyxdE7NSqwvWCY6ylzyktcSFkoQBB/aqSj+ZizKA5couBhx3nr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=ME6MC/wn; arc=fail smtp.client-ip=52.101.72.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="ME6MC/wn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a7lhrwgq3xmIIfdVqEYADuV4VEiO8W0nz0I20paFY1pcSqjg8HMSCtBVeoNBSEtJ+OQMSLeLGWnMEEOQKQbZeQZ2Z3nZIaKU+0H3tHx+GjFbG7l8tuwtpmyL8pnST81r1lgwlmMReFzMVHjqSAogCStKQPBlkDYY0CF5DErw890OB5hrndQlSllHDI6OW8or9uT4RBMRiDVhzLLW64/0Vmpw/isUW2IvWMz8lUBzlmmsdAqpgDrIMGQww9ChiSzAQuZE64AxCvZSJ+M9QU0i50xIANb8eTvx9ll7IKYojyNosEBUULFCF9fjgaTSfsV69vf9CenZBvb7TXo/YbAvuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL93dUyCXC8dfMnmJzD/ArTBjCiB+wIR/kfTmgXwGWU=;
 b=BLofLHgkWmvSqfWvOHcooDH0hq4l2w6/ggT6Tb/KWq/FyJpzxyWgd7LFNKN4K2K07bDMVAIMiaBX5WyEcGdOE+Ln9Bnt40QrWbggddFfJDaM0hFGhjSjcufPVr4Y4jg2kAYks1yySwlc7ZWuxjGwCm6OEEoa63Mj3jmnI2iEfX+UB5I5aHf7ic/iMNx74FIPaKY4e2GmnnGvaLWGjQVulXTWhMpSfGNYoTtGHKDugPRloj6SwgkHH1PcDzqKKpw+wke0gcRp94lSGZbEMlu7gIGShd8wlZMJJaw5s+INKFv8Kay7cby7kiWFJC8s4PwtCTayVmsQZcGfFzIIhu/bBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kL93dUyCXC8dfMnmJzD/ArTBjCiB+wIR/kfTmgXwGWU=;
 b=ME6MC/wn2EAg8fPO31hbgzdyEo2f7Dlzwrp2QTglcVd5RfI7eUMVzQk47Gx4vQ95m+YcH8SYrphE4QtjYOPNN0g5zgnwzaU7YXTka83oOTjH684y0C4EFntRb9V/KDy8wkFvcbCTGVcbbl3m+4F41b2d9dDGNimsXHmGLwCuEBc=
Received: from DB3PR06CA0032.eurprd06.prod.outlook.com (2603:10a6:8:1::45) by
 DU5PR03MB10372.eurprd03.prod.outlook.com (2603:10a6:10:521::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 16:20:17 +0000
Received: from DB1PEPF000509F9.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::47) by DB3PR06CA0032.outlook.office365.com
 (2603:10a6:8:1::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 16:20:20 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 DB1PEPF000509F9.mail.protection.outlook.com (10.167.242.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 16:20:17 +0000
Received: from N9W6SW14.arri.de (10.30.5.38) by mta.arri.de (10.10.18.5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 25 Feb
 2026 17:20:16 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: Christian Eggers <ceggers@arri.de>
Subject: [PATCH BlueZ 11/12] agent: move defines and parsing for I/O capability to shared/mgnt
Date: Wed, 25 Feb 2026 17:17:14 +0100
Message-ID: <20260225161715.20394-11-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260225161715.20394-1-ceggers@arri.de>
References: <20260225161715.20394-1-ceggers@arri.de>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F9:EE_|DU5PR03MB10372:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d52200-ccc4-4dbb-a95e-08de7489c376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	EsPQS6d3VthVUPIF5DDpRagZvOTu+7U7CYLc4G3aCJxxmXZApzHisVkfugXixtMZpR4/fRcsQ3gvM2H38Wa5GgPcXYq7FkMLO/LbcRvZODBwHFe1QXbdV2gvpdvvQ9WiAaFVzrBSQlerR2LnlwIse7PhHvwf31mRrfid1TwESqKbgubErjl/jBC2qRQk0qDTQgjxIYO161u9md0uS6uC5Kr2peV0d66cYmGkkE13/+EPZDBq7FIt1CyA87xT7nOjkmOixZeTpqRZAbK9g0ASITCI/M78upLNeE+P6KROAsWy772mNiC6w4fL+cVCOKDmsxmvicixPjCUVMobDJlInUlQ8OAkLjNTW9sCAXSLI6Rb7toulAGTo3gJp1SNr+N0EChBtG2E+SUTQ1kDw6DFbm342lN2M2bqyuZECCNsGtlCCDkgOpPug8dhLb60NB1NgJF8EQjJsuN7jatjRUtp2+R6KggGVmemVy2xI5eaN5Ay0/CCPke14gsFiUMcW97uXVA1Q4ncDGAqfqk6H5yYw/cjovzRdr2OkwaiYo/sT9BLxGbrtujWUxMR0yQwdL5t72QFmnMixm8z+GO8ftiOpIT7BPLAZLWv+cUpweMeTC6+EusDhNhZhoy+43GOIxq9UDV7NB2TI41iAl6Z/W3xparI/y/z66OCiyCItKuACOM+TjyKV+Arbr7md2GX0rUQaS1KS47SzjgqddsCbPXfSLlJxHOUvYYkRkWKBGqq+AncypqGBU4CYHusVDq3K1jzmCeulCedvNPBnRpKMcIw1AlZ49qk02oSWmDWikrxC5uZs3bgYATN7mgrZk5WMziN7zt+3gBNlBTeaX/AyS5KIQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JUN2AV7Hq8hM2jKUw8xEwpWEgBWVlO0Y++ymcLG6k8mUkcF9L6p6cTQzI6nhap3NfQeyQC4SGkugYmzn6Q1NP/keR56ec28+3bFooDmh3w+B/SuzWGokGTQyshYCNhnrjo669S1+zHHKgKrylMe7Z3PhufZ7/mpyzs4sautKY/ZrvnciU4B21WKqDbJ1LfwYCPDJH7UVbu915zMi1pumBubsnGDcN7+eJSgwnCXaBszntNUPPvk8bdQgw3/1QaiW3wMzsqwgqysFqzh1J4eSO8SXa7ok1S8uo5k32bISnL15S7dNebppHQQEGX+FjnmIOcqesrakgEtXJLpUmV/yTjJh5GUTwKBVj2idu3tWx32qhp9uCvgembOQQwOY+AkUJ63DJHtGf3lfuW1FFZq2PHTf0AZJCXcnMNpqYrxwZPfPsIBmOcrc0FzEshQGAYWT
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 16:20:17.1145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d52200-ccc4-4dbb-a95e-08de7489c376
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F9.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU5PR03MB10372

Allow reusing in client/mgmt.c (next commit)
---
 src/adapter.c     |  6 +++---
 src/agent.c       | 24 ++++--------------------
 src/agent.h       |  7 -------
 src/device.c      |  7 ++++---
 src/shared/mgmt.c | 32 ++++++++++++++++++++++++++++++++
 src/shared/mgmt.h | 10 ++++++++++
 6 files changed, 53 insertions(+), 33 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9bb1950a9f7d..bfabdf9a62ef 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9156,7 +9156,7 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 	struct mgmt_cp_set_io_capability cp;
 
 	if (!btd_opts.pairable) {
-		if (io_cap == IO_CAPABILITY_INVALID) {
+		if (io_cap == MGMT_IO_CAPABILITY_INVALID) {
 			if (adapter->current_settings & MGMT_SETTING_BONDABLE)
 				set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x00);
 
@@ -9165,8 +9165,8 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 
 		if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 			set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
-	} else if (io_cap == IO_CAPABILITY_INVALID)
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+	} else if (io_cap == MGMT_IO_CAPABILITY_INVALID)
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.io_capability = io_cap;
diff --git a/src/agent.c b/src/agent.c
index 3696575b83e6..794f81ebf18a 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -35,6 +35,7 @@
 #include "adapter.h"
 #include "device.h"
 #include "agent.h"
+#include "shared/mgmt.h"
 #include "shared/queue.h"
 
 #define REQUEST_TIMEOUT (60 * 1000)		/* 60 seconds */
@@ -131,7 +132,7 @@ static void set_io_cap(struct btd_adapter *adapter, gpointer user_data)
 	if (agent)
 		io_cap = agent->capability;
 	else
-		io_cap = IO_CAPABILITY_INVALID;
+		io_cap = MGMT_IO_CAPABILITY_INVALID;
 
 	adapter_set_io_capability(adapter, io_cap);
 }
@@ -944,23 +945,6 @@ static void agent_destroy(gpointer data)
 	agent_unref(agent);
 }
 
-static uint8_t parse_io_capability(const char *capability)
-{
-	if (g_str_equal(capability, ""))
-		return IO_CAPABILITY_KEYBOARDDISPLAY;
-	if (g_str_equal(capability, "DisplayOnly"))
-		return IO_CAPABILITY_DISPLAYONLY;
-	if (g_str_equal(capability, "DisplayYesNo"))
-		return IO_CAPABILITY_DISPLAYYESNO;
-	if (g_str_equal(capability, "KeyboardOnly"))
-		return IO_CAPABILITY_KEYBOARDONLY;
-	if (g_str_equal(capability, "NoInputNoOutput"))
-		return IO_CAPABILITY_NOINPUTNOOUTPUT;
-	if (g_str_equal(capability, "KeyboardDisplay"))
-		return IO_CAPABILITY_KEYBOARDDISPLAY;
-	return IO_CAPABILITY_INVALID;
-}
-
 static DBusMessage *register_agent(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -979,8 +963,8 @@ static DBusMessage *register_agent(DBusConnection *conn,
 						DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
-	cap = parse_io_capability(capability);
-	if (cap == IO_CAPABILITY_INVALID)
+	cap = mgmt_parse_io_capability(capability);
+	if (cap == MGMT_IO_CAPABILITY_INVALID)
 		return btd_error_invalid_args(msg);
 
 	agent = agent_create(sender, path, cap);
diff --git a/src/agent.h b/src/agent.h
index bd0502030fa0..03731756849c 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -9,13 +9,6 @@
  *
  */
 
-#define IO_CAPABILITY_DISPLAYONLY	0x00
-#define IO_CAPABILITY_DISPLAYYESNO	0x01
-#define IO_CAPABILITY_KEYBOARDONLY	0x02
-#define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
-#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
-#define IO_CAPABILITY_INVALID		0xFF
-
 struct agent;
 
 typedef void (*agent_cb) (struct agent *agent, DBusError *err,
diff --git a/src/device.c b/src/device.c
index 0ef7dcc244d2..f7a84b807878 100644
--- a/src/device.c
+++ b/src/device.c
@@ -43,6 +43,7 @@
 #include "src/shared/gatt-client.h"
 #include "src/shared/gatt-server.h"
 #include "src/shared/ad.h"
+#include "src/shared/mgmt.h"
 #include "src/shared/timeout.h"
 #include "btio/btio.h"
 #include "bluetooth/mgmt.h"
@@ -3375,7 +3376,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	if (agent)
 		io_cap = agent_get_io_capability(agent);
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	bonding = bonding_request_new(msg, device, bdaddr_type, agent);
 
@@ -6544,7 +6545,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (device->bonding->agent)
 		io_cap = agent_get_io_capability(device->bonding->agent);
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	err = adapter_create_bonding(device->adapter, &device->bdaddr,
 					device->bdaddr_type, io_cap);
@@ -7452,7 +7453,7 @@ static gboolean device_bonding_retry(gpointer data)
 	if (bonding->agent)
 		io_cap = agent_get_io_capability(bonding->agent);
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	err = adapter_bonding_attempt(adapter, &device->bdaddr,
 				device->bdaddr_type, io_cap);
diff --git a/src/shared/mgmt.c b/src/shared/mgmt.c
index 6a7eb5798cb8..300abbae1c50 100644
--- a/src/shared/mgmt.c
+++ b/src/shared/mgmt.c
@@ -81,6 +81,20 @@ struct mgmt_tlv_list {
 	uint16_t size;
 };
 
+struct arg_table {
+	const char *name;
+	unsigned value;
+};
+
+static const struct arg_table iocap_arguments[] = {
+	{ "DisplayOnly", MGMT_IO_CAPABILITY_DISPLAYONLY },
+	{ "DisplayYesNo", MGMT_IO_CAPABILITY_DISPLAYYESNO },
+	{ "KeyboardOnly", MGMT_IO_CAPABILITY_KEYBOARDONLY },
+	{ "NoInputNoOutput", MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT },
+	{ "KeyboardDisplay", MGMT_IO_CAPABILITY_KEYBOARDDISPLAY },
+	{ NULL, 0}
+};
+
 static void destroy_request(void *data)
 {
 	struct mgmt_request *request = data;
@@ -1039,3 +1053,21 @@ uint16_t mgmt_get_mtu(struct mgmt *mgmt)
 
 	return mgmt->mtu;
 }
+
+uint8_t mgmt_parse_io_capability(const char *capability)
+{
+	const char *arg;
+	int index = 0;
+
+	if (!strcmp(capability, ""))
+		return MGMT_IO_CAPABILITY_KEYBOARDDISPLAY;
+
+	while ((arg = iocap_arguments[index].name)) {
+		if (!strncmp(arg, capability, strlen(capability)))
+			return iocap_arguments[index].value;
+
+		index++;
+	}
+
+	return MGMT_IO_CAPABILITY_INVALID;
+}
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index 2629fbd59cf6..a4c30075f7b7 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -13,6 +13,14 @@
 
 #define MGMT_VERSION(v, r) (((v) << 16) + (r))
 
+#define MGMT_IO_CAPABILITY_DISPLAYONLY		0x00
+#define MGMT_IO_CAPABILITY_DISPLAYYESNO		0x01
+#define MGMT_IO_CAPABILITY_KEYBOARDONLY		0x02
+#define MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
+#define MGMT_IO_CAPABILITY_KEYBOARDDISPLAY	0x04
+#define MGMT_IO_CAPABILITY_INVALID		0xFF
+
+
 typedef void (*mgmt_destroy_func_t)(void *user_data);
 
 struct mgmt;
@@ -89,3 +97,5 @@ bool mgmt_unregister_index(struct mgmt *mgmt, uint16_t index);
 bool mgmt_unregister_all(struct mgmt *mgmt);
 
 uint16_t mgmt_get_mtu(struct mgmt *mgmt);
+
+uint8_t mgmt_parse_io_capability(const char *capability);
-- 
2.51.0

