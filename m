Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8574D2BE7C6
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Feb 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202803; cv=fail; b=hRgfIac4PIN9apuEqgP0EDJD+bnxzeyWmeqaNeCXA8B/16BEU8MbXPx3sfsOfvo12JkuozVzjyeBH+EPSKcCY6HSIBLGIJvOwoaInV0z0E2WNEpxSPP8ByHNS3EmimmgwcVmxKKmV41DZRQ4kI2wJGs7gnK9Qc+aYNBx5on2Uys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202803; c=relaxed/simple;
	bh=zt9dobdch5G+C8qfFfeyKZMF6J859hvCc1Afx4eS19Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mBeKz5mAkomX6bgskdt5m5SjpNwJnI8bY/Upi8o2jBfHa7XIvpscu9XV2Kg3yOwywSD/w+R019kirormd16D4peMXX/mHo9tQ2vd/zg/8JXQgf8v+PdBDZ2MGkd+QO09DG9V3f+val6EAfWSr51tyCR8xmquVhmExZBA/3LOnzk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de; spf=pass smtp.mailfrom=arri.de; dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b=XYqrxcbG; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arri.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arri.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arri.de header.i=@arri.de header.b="XYqrxcbG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhdPI/6euwlXWFr7b6+5QGHMg7cgAXv5eP7NTQhN14B+khgbpUVMFTEh3upeZeDk/9CfMzoeE9FIO0hAcAByNPHiR2uW5PTI5tW6K4cppxr74TIhjj1yi0ELfUbtsX9gm2tV96DXJrxMJkbhDTIEhdjibvokhsRNZJzdXLD/iDwxadQKS3vubXcHcDuQoTV1MiswsRpahxoQRYmGA4ndn5xtlACD8K5r1wQ1XWewU5R2JsJt9VmkvorEYvhDKY2oaPvS8KN79CcYEuwLqLgVm6z4o8TIRlx/PakvPrZH//pNj9yW7Erk5sfv7Iiw2+6rAtiHBr1OnTOiUcWgyVl3wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rjgstw0GoyyQ07Qgyrqac0+f5z2giJD+gYJ40bS4wr0=;
 b=jxkWmC/P2OobqIKUTzxGxL1gL2gTtbQuoe4kzDfQYspoVbR+Hy4ixTJDgbc+gVyqlK8nQbAyiXun4jaGYsj31DCa9Lv5bYsx2m7W68wDWB4+xGg/3U1u1XhFao19ZgYvmfX7bDq4p933e/o0kDk8Jqc6kMfm80H6/puu4LfuNb0RncDd+ih7v4pz0z+LZQ57VIW0z9VwWCo9bkTo4B3TLg086hpJ962sBypS5weq0iX6eu9S+6U58aUlxgUigASVh3wSQthAAW4TQ/JMuhRvFTdacE20GJ7hFOOfZU+GOCPwB/ArbUYULslmtNo4iXfcSAkM58NQ+ia9NfcOZV7ofA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 217.111.95.7) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arri.de;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=arri.de;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arri.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rjgstw0GoyyQ07Qgyrqac0+f5z2giJD+gYJ40bS4wr0=;
 b=XYqrxcbGSwnXX4CmObcTMRvAAgBqkXbVdbJBcovVqIh6l2aP0sNB8qmpQDNAxrVGWlLZUsgCkTwozNog8VuM4UwdaPhAwMk8TSHFlWns4e+uKfFSZioVUXWIDO0RgHfhY8fixNXaZcq5ithPGhfVWXCu/gj5RkqcpfjZDK1pcZo=
Received: from AS4P190CA0021.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::6)
 by DU7PR03MB10993.eurprd03.prod.outlook.com (2603:10a6:10:5b0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.15; Fri, 27 Feb
 2026 14:33:15 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::b5) by AS4P190CA0021.outlook.office365.com
 (2603:10a6:20b:5d0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 14:33:06 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 217.111.95.7)
 smtp.mailfrom=arri.de; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=arri.de;
Received-SPF: Fail (protection.outlook.com: domain of arri.de does not
 designate 217.111.95.7 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.111.95.7; helo=mta.arri.de;
Received: from mta.arri.de (217.111.95.7) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 14:33:13 +0000
Received: from N9W6SW14.arri.de (192.168.54.16) by mta.arri.de (10.10.18.5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 27 Feb
 2026 15:33:13 +0100
From: Christian Eggers <ceggers@arri.de>
To: <linux-bluetooth@vger.kernel.org>
CC: <ceggers@arri.de>
Subject: [PATCH BlueZ 2/4] adapter/agent/device: migrate to shared enum/parser for IO capabilities
Date: Fri, 27 Feb 2026 15:24:23 +0100
Message-ID: <20260227143242.5204-3-ceggers@arri.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260227143242.5204-1-ceggers@arri.de>
References: <20260227143242.5204-1-ceggers@arri.de>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|DU7PR03MB10993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c43125b-8524-42b5-b6f2-08de760d23cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	t6/uledkicupDKWIo84u3S0XQZGFd53Oouj+Wk9ywH7nVyREF46EhkjnGcE9GbGr6LfasdavTaSnqi9mllP8c539qCqRGqz+VWyVkmJ2CAyHqlekMFt+/R7x8OJiucmRjeZQoRaYW/vuWtLVM2dQFrgofBWYCVAtsfoETZYVuXVoLvB8fZpAT45vix2jlrnOQV1gx6mKrB4X0GeQUQ5pbGcDJp5v/EaZqw7UR3eddCA+a8jO0hi0VlcG065qQ6TMS8Rbv/BC2NLXLp2N20u1oCYjZxwJCdZA+uZkUUMb/voHKPHM+6YX7THu8cLTY9+/XejPtSO3xmc2qRtbCCb8qAs7UKYWjHhQXeZ3Ht4IH+eeApmuwsgT1zUOoVbfKeABVojDt5WCS1mHNdCnYsgS/TeqUZFzM/FHGvAtnzE/jCBrte/psBLveNsdflHnfaGsx9vzuMpcLfCcHoSkjJdyexGBMEJDeV8yOfkZCWo3GIBcKkpiNpBIj5OxNjNswO57ZVt7xBBzcBR55NtupgCTPj2MQzVmQR7I19sBKBeQQ1NfQdRzLkTZaSnrvG9WbwjTTx/LMEf1J5QnNsYXrtUkdLgQ3zlBkdIJZ8s5AmqSFudc+DBfQ2+makfaX/tkSNY9jfjYyBOMUpEnsI2KfzM1ee7t0mI6du59PPlgoA2PhBRWX2Cmi4k1mVb/w75n0O0kfQ1baH2qenVJL4OHCsS06Pp8BnIpllj8O/Oi+YJmh0cEWsSXAAymO292Fcllw4iPg6adbOxRpTmFRKwW+qT3PJGHvYyTu0tHyhg8ACOqC5Oikku85uSGNg/k0ejjuUW+sehcoqRtITQmXLb0KCdqEQ==
X-Forefront-Antispam-Report:
	CIP:217.111.95.7;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mta.arri.de;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	EL53h/CJXPSLJfMMIMC9wAeXdH+AntRSIP5nIjcbgU2eHQRkLVFbSQJG8+y6NApGNMZj1RMM6VCG9MuxhbAReJeztuDfAc9a9LmeNGfkCRl2utHgSK7VANTBTwu0Gasxjp67IbbVvxkgUKgDSCgnndMMwWVVJ9kn8p/q7vKKSrgXKU4VGGx+ogyXrqc/LzgHWIEN4bucaVZFCSKIYARkDJSCj1Y4v+34tfAc72PwqU5caoGF0yl1oxu0PGxa1l+zm4EOtRZLEKLi3OxQ4QTA/863cnF7zJTMbrzieCde5+LigZoaeeqjrBzgVNVl00laeEaNlPMsgb+oDJm373AgOLBvgE0mQhHKrIEwu8q8ovrYYXxvisPNXA5B3Fq7WmnWzkMCr4yEEWIUjLaCRcib0nDS52iQQOtFVf1as8GBpBR2EWHODAmVnz9t5EbpXsXq
X-OriginatorOrg: arri.de
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 14:33:13.9944
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c43125b-8524-42b5-b6f2-08de760d23cb
X-MS-Exchange-CrossTenant-Id: e6a73a5a-614d-4c51-b3e3-53b660a9433a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e6a73a5a-614d-4c51-b3e3-53b660a9433a;Ip=[217.111.95.7];Helo=[mta.arri.de]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU7PR03MB10993

---
 src/adapter.c     | 18 ++++++++++--------
 src/adapter.h     | 11 ++++++++---
 src/agent.c       | 33 ++++++++-------------------------
 src/agent.h       |  9 ++-------
 src/device.c      | 12 ++++++------
 src/shared/mgmt.h |  2 ++
 6 files changed, 36 insertions(+), 49 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9bb1950a9f7d..4e5ff219fe8b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -42,7 +42,6 @@
 #include "log.h"
 #include "textfile.h"
 
-#include "src/shared/mgmt.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/att.h"
@@ -8548,7 +8547,8 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 }
 
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
-					uint8_t addr_type, uint8_t io_cap)
+					uint8_t addr_type,
+					enum mgmt_io_capability io_cap)
 {
 	suspend_discovery(adapter);
 
@@ -8557,7 +8557,8 @@ int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 
 /* Starts a new bonding attempt in a fresh new bonding_req or a retried one. */
 int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
-					uint8_t addr_type, uint8_t io_cap)
+						uint8_t addr_type,
+						enum mgmt_io_capability io_cap)
 {
 	struct mgmt_cp_pair_device cp;
 	char addr[18];
@@ -9151,12 +9152,13 @@ static void new_conn_param(uint16_t index, uint16_t length,
 					ev->latency, ev->timeout);
 }
 
-int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
+int adapter_set_io_capability(struct btd_adapter *adapter,
+						enum mgmt_io_capability io_cap)
 {
 	struct mgmt_cp_set_io_capability cp;
 
 	if (!btd_opts.pairable) {
-		if (io_cap == IO_CAPABILITY_INVALID) {
+		if (io_cap == MGMT_IO_CAPABILITY_INVALID) {
 			if (adapter->current_settings & MGMT_SETTING_BONDABLE)
 				set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x00);
 
@@ -9165,8 +9167,8 @@ int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap)
 
 		if (!(adapter->current_settings & MGMT_SETTING_BONDABLE))
 			set_mode(adapter, MGMT_OP_SET_BONDABLE, 0x01);
-	} else if (io_cap == IO_CAPABILITY_INVALID)
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+	} else if (io_cap == MGMT_IO_CAPABILITY_INVALID)
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.io_capability = io_cap;
@@ -9399,7 +9401,7 @@ static int adapter_register(struct btd_adapter *adapter)
 
 	agent = agent_get(NULL);
 	if (agent) {
-		uint8_t io_cap = agent_get_io_capability(agent);
+		enum mgmt_io_capability io_cap = agent_get_io_capability(agent);
 		adapter_set_io_capability(adapter, io_cap);
 		agent_unref(agent);
 	}
diff --git a/src/adapter.h b/src/adapter.h
index 7a7e5c8f9dfd..4e07f71ad130 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -16,6 +16,8 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
 
+#include "shared/mgmt.h"
+
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
 
 #define MAX_NAME_LENGTH		248
@@ -207,15 +209,18 @@ int btd_adapter_passkey_reply(struct btd_adapter *adapter,
 				uint32_t passkey);
 
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
-					uint8_t addr_type, uint8_t io_cap);
+						uint8_t addr_type,
+						enum mgmt_io_capability io_cap);
 
 int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
-					uint8_t addr_type, uint8_t io_cap);
+						uint8_t addr_type,
+						enum mgmt_io_capability io_cap);
 
 int adapter_cancel_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 							uint8_t addr_type);
 
-int adapter_set_io_capability(struct btd_adapter *adapter, uint8_t io_cap);
+int adapter_set_io_capability(struct btd_adapter *adapter,
+						enum mgmt_io_capability io_cap);
 
 int btd_adapter_read_local_oob_data(struct btd_adapter *adapter);
 
diff --git a/src/agent.c b/src/agent.c
index 3696575b83e6..caa719d90e7f 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -56,7 +56,7 @@ struct agent {
 	int ref;
 	char *owner;
 	char *path;
-	uint8_t capability;
+	enum mgmt_io_capability capability;
 	struct agent_request *request;
 	guint watch;
 };
@@ -126,12 +126,12 @@ static void agent_request_free(struct agent_request *req, gboolean destroy)
 static void set_io_cap(struct btd_adapter *adapter, gpointer user_data)
 {
 	struct agent *agent = user_data;
-	uint8_t io_cap;
+	enum mgmt_io_capability io_cap;
 
 	if (agent)
 		io_cap = agent->capability;
 	else
-		io_cap = IO_CAPABILITY_INVALID;
+		io_cap = MGMT_IO_CAPABILITY_INVALID;
 
 	adapter_set_io_capability(adapter, io_cap);
 }
@@ -261,7 +261,7 @@ struct agent *agent_get(const char *owner)
 }
 
 static struct agent *agent_create( const char *name, const char *path,
-							uint8_t capability)
+					enum mgmt_io_capability capability)
 {
 	struct agent *agent;
 
@@ -922,7 +922,7 @@ failed:
 	return err;
 }
 
-uint8_t agent_get_io_capability(struct agent *agent)
+enum mgmt_io_capability agent_get_io_capability(struct agent *agent)
 {
 	return agent->capability;
 }
@@ -944,29 +944,12 @@ static void agent_destroy(gpointer data)
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
 	struct agent *agent;
 	const char *sender, *path, *capability;
-	uint8_t cap;
+	enum mgmt_io_capability cap;
 
 	sender = dbus_message_get_sender(msg);
 
@@ -979,8 +962,8 @@ static DBusMessage *register_agent(DBusConnection *conn,
 						DBUS_TYPE_INVALID) == FALSE)
 		return btd_error_invalid_args(msg);
 
-	cap = parse_io_capability(capability);
-	if (cap == IO_CAPABILITY_INVALID)
+	cap = mgmt_parse_io_capability(capability);
+	if (cap == MGMT_IO_CAPABILITY_INVALID)
 		return btd_error_invalid_args(msg);
 
 	agent = agent_create(sender, path, cap);
diff --git a/src/agent.h b/src/agent.h
index bd0502030fa0..63cd7e5ccc4d 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -9,12 +9,7 @@
  *
  */
 
-#define IO_CAPABILITY_DISPLAYONLY	0x00
-#define IO_CAPABILITY_DISPLAYYESNO	0x01
-#define IO_CAPABILITY_KEYBOARDONLY	0x02
-#define IO_CAPABILITY_NOINPUTNOOUTPUT	0x03
-#define IO_CAPABILITY_KEYBOARDDISPLAY	0x04
-#define IO_CAPABILITY_INVALID		0xFF
+#include "shared/mgmt.h"
 
 struct agent;
 
@@ -61,7 +56,7 @@ int agent_display_pincode(struct agent *agent, struct btd_device *device,
 
 int agent_cancel(struct agent *agent);
 
-uint8_t agent_get_io_capability(struct agent *agent);
+enum mgmt_io_capability agent_get_io_capability(struct agent *agent);
 
 void btd_agent_init(void);
 void btd_agent_cleanup(void);
diff --git a/src/device.c b/src/device.c
index fd7dc4eb7b7c..3ea683667bd8 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3333,7 +3333,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	const char *sender;
 	struct agent *agent;
 	struct bonding_req *bonding;
-	uint8_t io_cap;
+	enum mgmt_io_capability io_cap;
 	int err;
 
 	btd_device_set_temporary(device, false);
@@ -3375,7 +3375,7 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	if (agent)
 		io_cap = agent_get_io_capability(agent);
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	bonding = bonding_request_new(msg, device, bdaddr_type, agent);
 
@@ -6504,7 +6504,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 {
 	struct btd_device *device = user_data;
 	DBusMessage *reply;
-	uint8_t io_cap;
+	enum mgmt_io_capability io_cap;
 	int err = 0;
 
 	g_io_channel_unref(device->att_io);
@@ -6543,7 +6543,7 @@ static void att_connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
 	if (device->bonding->agent)
 		io_cap = agent_get_io_capability(device->bonding->agent);
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	err = adapter_create_bonding(device->adapter, &device->bdaddr,
 					device->bdaddr_type, io_cap);
@@ -7433,7 +7433,7 @@ static gboolean device_bonding_retry(gpointer data)
 	struct btd_device *device = data;
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct bonding_req *bonding = device->bonding;
-	uint8_t io_cap;
+	enum mgmt_io_capability io_cap;
 	int err;
 
 	if (!bonding)
@@ -7451,7 +7451,7 @@ static gboolean device_bonding_retry(gpointer data)
 	if (bonding->agent)
 		io_cap = agent_get_io_capability(bonding->agent);
 	else
-		io_cap = IO_CAPABILITY_NOINPUTNOOUTPUT;
+		io_cap = MGMT_IO_CAPABILITY_NOINPUTNOOUTPUT;
 
 	err = adapter_bonding_attempt(adapter, &device->bdaddr,
 				device->bdaddr_type, io_cap);
diff --git a/src/shared/mgmt.h b/src/shared/mgmt.h
index c99f2ff0620e..c1f62ebb9c9d 100644
--- a/src/shared/mgmt.h
+++ b/src/shared/mgmt.h
@@ -8,6 +8,8 @@
  *
  */
 
+#pragma once
+
 #include <stdbool.h>
 #include <stdint.h>
 
-- 
2.51.0

