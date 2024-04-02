Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2092.outbound.protection.outlook.com [40.107.247.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5467C46
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 11:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058227; cv=fail; b=EEVfBKRJ2IthtOAXVMjN53yJb+C+c/3xZXu11ZAveWCuLfs3qdWF7zTAopzQ9gujbKQzwMFg12WrsHIDkp2HaJquJZ0dScjhgw+7FNU2FQDqBhB1d32WLd2d89Xv1McknjJnR6im3WoWHzfKYllCDfiUwALnatgoXg2SPEtW0Uw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058227; c=relaxed/simple;
	bh=vCR98MttEt42OxbDPUI6wxQ27gbVTiauNfDkljuaeP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxAikrtoz8tC22/+KVmEVu8bXXpBj0zgjpQYZ/RvvLkc+05bUcbgATerrnCO7ZAVu5TGO+qDL83Id4cc6wXzPEsFCL9eg3Cj9/WMgR+NUY1SG8u4xMQk7QYVG/TUOaazMM+Z1yStebuKXFAUkBfRaJnHjY/AsM/SHfrroD4ujKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WVP8oCwq; arc=fail smtp.client-ip=40.107.247.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WVP8oCwq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c2h9LJvj/hADgkqNbe78LPQe4cXhj+kk6EaJbgpDSR8lbxzp6tHO7n31wedAIYZWE+c3vHxAz5bisslPScKPX/t5R38hszFQb7b1QGivcpCrs/+96CslW7palvRVTuG7zujrAVDiHesBGVYEzmRsMCUP6ynnW37At5iX0szQqeB/3t/YQu8j+vI9PFXinmvUxHiXdmxm86336XhnFimMf8xaaRZtl8hS7z5FEoXRGsc3EN28kiwDYvNOcxyb9nqQ+ii40O4wPDs+AzkIF/6PJJmDBke2R3mmhmXgXjksLr9a3bTqeRTL39YrR1CUE6HPgF0A8Dm44/s0VGkok23iqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M+i8hAXMZgEjGG3OA3zVNSwriMWalUVbfMEzi+e+BmE=;
 b=lOf5ehqEf5EV+kJxznzW4pUtBnGBOgi0CC/uMbWzjoNOsyT3EJRo2nKbwlp7++U6yxO/6iW4GBloQiCpXJsmEa0Nxju2hvZmNViJzpFLZB0ufxwm4BZoSGOwM35Suc9Fv3RKEaiGJkTwfg5zTJi/nPEdEZaoitgz1E7fU6HUKplGyyrghpjdGtXBWsEA1DBFN4HAoWXzc2LrFVS6x4D+BbIIr6ncDcvUAGDmy4jfrWbJ0HglPgmNS+Iu/QZBjnmsMf9gdv5ATB+RqnK2838QXciaX0sw8EnYBpAHoTnM1pg46GNOQK5l8LO7ZpctrcdxywrCgKbnUiRIkgA+UtTBHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M+i8hAXMZgEjGG3OA3zVNSwriMWalUVbfMEzi+e+BmE=;
 b=WVP8oCwqO02Fe68Jj7G5sdvbwS7E26rc65oZN+q43Z62LsBVybUOZ+Xlvn5lqGbhkCHinT4pK4INfoZ9Mq0tkNobtkmsTQ2nzyHKgB8I17cnv7N2+tgdB9ludVEXBLqZxMrms6PolqiHyEQUl65v13iMkRpKPmQRYABCmiH7XpA=
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DBAPR04MB7271.eurprd04.prod.outlook.com (2603:10a6:10:1a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:43:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:43:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 3/3] iso-tester: Add test for Broadcast Receiver Get BASE
Date: Tue,  2 Apr 2024 14:43:26 +0300
Message-Id: <20240402114326.3330-4-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
References: <20240402114326.3330-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0012.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DBAPR04MB7271:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W9ceR1rseNFeEGVIfbpmyc4Ho+207RybnF2WSr7+ZwuH8Wuyst9axiM2rqECGHUMWr16Dr/ChOmyUlb0QvA2/GNFfcDLIVMQiGr0mvb3lUWu1CbOIDdZCd/D7IKGG6ZDlveJ723mjyeMXX73fFAMFdWYYMp47+f1+SK/pohSxCceU1Pegw5QYtcFFbjXPhjBwQLqHcSHBTIbb19aP5iUGnaubiLEThWeqBx4QQ49tpJ7u7HXpBdLiBQqmGitUC5kEHdJCSQ+D72T21P1ENgZ5OwKmjPMWKxp4GA1ZtnDCUeIeXSlMr25UQg40kcW/qJCEbOjnjDprVSqjU2kJFZ74K5tMSNknim0arzvM9A4qyaAjq89dUJqzOdBQDCsQrrnSjCjTrZw7FAN7AdGrbVxT2yRF2gQ59f4I89G+TOP6kthbcnzu39sfSekA+EgNuKRlgd+pgXl+L3OfTcfKZajkJlgxhBSgKNIG1lMNU7NCq+xNtWyDnK0T1X/xyCSpakVrrtjLienfR/zicz8CU/LWK3P0+waq1TIHdBi6eJ2Oq8FSULePHv/bxGLElPs95HUU8SOLJw/ihRkvS7sd+aWzHB8uS+p4YV8zHldqbW3L+l8hezGz8rYdfnZWnTzZl9xlzmAW9yiDHxqqyjwVY5VhncOPIq2fCk5JRgig1RJomw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T0ops0xvYlDyITdBMZy3ZSwXECj0ICec3h1cDmTwUmC542sLG1Kww+8RVrzs?=
 =?us-ascii?Q?9rNvsWG2TOKUNlNQ4KZz1h+wPepuZJf94aGcdwEOXnqCZDo+pRI3rnM0AaGP?=
 =?us-ascii?Q?3Ypv45WS4XYmZc7TCfwVajF1kKEDxo++DHD5Ht3HSvwfleaE9gJuHxt9X7Zv?=
 =?us-ascii?Q?yBTy5niNTGNDpGqqHFnDjAFA5BBbsGBaLHgwxpJTVprtblDUt6K2RGLAdHFG?=
 =?us-ascii?Q?HzcEJB9cDgVi3UMvFmUqIGH70iteUdxcVU93XBlY+Jcos0oB2kJgE+qYOROZ?=
 =?us-ascii?Q?1YvnGfHkSfCZhD+wBJS5rqux/eJXccLy37ndSreTnZpd9FFy3S7ZGYeDUtJM?=
 =?us-ascii?Q?n4/tdRsiz9znUb0KFP77ckXT2mmByh2Pwy30zY2shJ2wswPg/zkRHqKl9Z1e?=
 =?us-ascii?Q?P4j072EzaPHuwPKTIK2EMzluEzMFY3s+ZS+Tmz7cSa3galU0PU55uGKdX+R6?=
 =?us-ascii?Q?RZEfkASk4kvSuB5UiZIC6/SAZo9iEShrVpR+bzJMzPBsk5cE0AiQX85qKsNP?=
 =?us-ascii?Q?79MqoZhwRT2LYLxJ/8/AO8wvRA9nvIVCUs698qBKE/qI6rL5aPIPa4fSk6xi?=
 =?us-ascii?Q?9U3MnjxKpgQ4eOmRTMCqnbW5n68poZQ8lWZws/8QKUTxQrf0mU1z4Ej18nZX?=
 =?us-ascii?Q?nd5xzmbJToNc3tz9QuxHKjNWWPYTftEsOfPSCXTTq7+WwiltPe/WVWindIKN?=
 =?us-ascii?Q?qELFQJXOCPjE1lXFXeGPWgjsOKAVXT3FhF3QyUTy5W+lWoOLCn9EpPTBcmu/?=
 =?us-ascii?Q?A8Abj8U8u5obiC7jyHkiWkLIll3rDEsRURq0rMJZk+HqhuoF0W0pCBh3lytg?=
 =?us-ascii?Q?TtG9AsB3t23SOoSR761Kc/piKgSw9EEyxszbRL6N2OE+BcMGzCB6SaE86F39?=
 =?us-ascii?Q?nEqeScPC/jM5kehwHX4GNXgxVe4ambHltVGnTBcXwNr+fmQ6NvJLe7B2xqML?=
 =?us-ascii?Q?pweIdW9PcGCtSdFxBvXHbMmPAHDbN/SBPso6shrDfBu6kO8UT0Z+P9FzoLZe?=
 =?us-ascii?Q?vr9dQl5pcGT/yqG9Az/i9t9gKCfHdvvhDtwqCh0Uj5NZhdpUqWTtPW5vCZhV?=
 =?us-ascii?Q?a91O8LG962gYnfIwCtohvFR6fes/h3DbQkA6KTJIo+gGCK/AUYkwXMpmzKmZ?=
 =?us-ascii?Q?lifkPaFPIlWScyt/liI7fUISQFO6AjPR+c1jAjhJowf1qO6tLpEqWVxt71tG?=
 =?us-ascii?Q?iMv6TcBeo9qIKNJx1u2x3qRtUyRcqzA88J9l3YG/gqshg41vLJyiLKrTI5kd?=
 =?us-ascii?Q?lwgz5tLXkal8ZMhO49UxpJf4BJx2Sx51KvMNbhlf10f3sswWWf6tORpzZLqY?=
 =?us-ascii?Q?ad8YPP/+Es+22IzUACAwt0IAsZ5HaCH3yVa294uRhIDUNSekQ79q3txBRyK1?=
 =?us-ascii?Q?AIo6KQKJRVHmUIM5EptO+obC/AhruYW5g0Fz4GBeIJAv7w2+SfAIH8lTA4Pa?=
 =?us-ascii?Q?oQbs6XzhrF15EbQlGsGCcYR9oWh8MYwRFpdLtgzUXukgzl4gSQqrFUqPEYaq?=
 =?us-ascii?Q?qmzB60USQjjCkO2B2EPIkhxAfKskmvuHkS/Z+j2G6pRIp2ILBuKxoqI84UyC?=
 =?us-ascii?Q?TWvBGTqfT5C5iIlnDoD90QzhvG3IBmePsz/NT63Pl+lQynPTTK33zGkRZp6/?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e3ff491-8f95-4acc-82f8-08dc530a2539
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:43:42.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja9RCyR/LeWNFxwgImXOzU2d2wdOkdpFrBCiwanjmFI14+tDDSlFp+zHcFlcLmOuRH+4dGKKzM+O3bKA6LrLvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7271

This adds a new Broadcast Receiver test, to validate that a Broadcast
Sink is able to sync to the PA transmitted by a Source (when no BIG
is active) and is able to successfully detect the BASE:

ISO Broadcaster Receiver Defer Get BASE - Success
---
 tools/iso-tester.c | 70 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 67 insertions(+), 3 deletions(-)

diff --git a/tools/iso-tester.c b/tools/iso-tester.c
index 60afef301..67d698291 100644
--- a/tools/iso-tester.c
+++ b/tools/iso-tester.c
@@ -23,6 +23,7 @@
 #include "lib/bluetooth.h"
 #include "lib/iso.h"
 #include "lib/mgmt.h"
+#include "lib/uuid.h"
 
 #include "monitor/bt.h"
 #include "emulator/vhci.h"
@@ -34,6 +35,8 @@
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 
+#define EIR_SERVICE_DATA_16	0x16
+
 #define QOS_IO(_interval, _latency, _sdu, _phy, _rtn) \
 { \
 	.interval = _interval, \
@@ -487,6 +490,7 @@ struct iso_client_data {
 	size_t base_len;
 	bool listen_bind;
 	bool pa_bind;
+	bool big;
 };
 
 typedef bool (*iso_defer_accept_t)(struct test_data *data, GIOChannel *io);
@@ -1301,6 +1305,7 @@ static const struct iso_client_data bcast_16_2_1_recv = {
 	.recv = &send_16_2_1,
 	.bcast = true,
 	.server = true,
+	.big = true,
 };
 
 static const struct iso_client_data bcast_enc_16_2_1_recv = {
@@ -1309,6 +1314,7 @@ static const struct iso_client_data bcast_enc_16_2_1_recv = {
 	.recv = &send_16_2_1,
 	.bcast = true,
 	.server = true,
+	.big = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_recv_defer = {
@@ -1319,6 +1325,7 @@ static const struct iso_client_data bcast_16_2_1_recv_defer = {
 	.bcast = true,
 	.server = true,
 	.listen_bind = true,
+	.big = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
@@ -1327,6 +1334,7 @@ static const struct iso_client_data bcast_16_2_1_recv_defer_no_bis = {
 	.defer = true,
 	.bcast = true,
 	.server = true,
+	.big = true,
 };
 
 static const struct iso_client_data bcast_16_2_1_recv_defer_pa_bind = {
@@ -1336,6 +1344,17 @@ static const struct iso_client_data bcast_16_2_1_recv_defer_pa_bind = {
 	.bcast = true,
 	.server = true,
 	.pa_bind = true,
+	.big = true,
+};
+
+static const struct iso_client_data bcast_16_2_1_recv_defer_get_base = {
+	.qos = QOS_IN_16_2_1,
+	.expect_err = 0,
+	.defer = true,
+	.bcast = true,
+	.server = true,
+	.base = base_lc3_ac_12,
+	.base_len = sizeof(base_lc3_ac_12),
 };
 
 static const struct iso_client_data bcast_ac_12 = {
@@ -1498,9 +1517,28 @@ static void setup_powered_callback(uint8_t status, uint16_t length,
 		if (isodata->bcast) {
 			bthost_set_pa_params(host);
 			bthost_set_pa_enable(host, 0x01);
-			bthost_create_big(host, 1,
-					isodata->qos.bcast.encryption,
-					isodata->qos.bcast.bcode);
+
+			if (isodata->base) {
+				uint8_t eir[HCI_MAX_PER_AD_LENGTH] = {0};
+				uint16_t eir_len = 0;
+
+				eir[eir_len++] = EIR_SERVICE_DATA_LENGTH - 1 +
+							isodata->base_len;
+				eir[eir_len++] = EIR_SERVICE_DATA_16;
+				put_le16(BAA_SERVICE, &eir[eir_len]);
+				eir_len += 2;
+				memcpy(&eir[eir_len], isodata->base,
+							isodata->base_len);
+				eir_len += isodata->base_len;
+
+				bthost_set_pa_data(host, eir, eir_len);
+			}
+
+			if (isodata->big)
+				bthost_create_big(host, 1,
+						isodata->qos.bcast.encryption,
+						isodata->qos.bcast.bcode);
+
 		} else if (!isodata->send && isodata->recv) {
 			const uint8_t *bdaddr;
 
@@ -2183,6 +2221,7 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 	socklen_t len;
 	struct bt_iso_qos qos;
 	bool ret = true;
+	uint8_t base[BASE_MAX_LENGTH] = {0};
 
 	sk = g_io_channel_unix_get_fd(io);
 
@@ -2211,6 +2250,27 @@ static gboolean iso_connect(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
+	if (isodata->bcast && isodata->server && isodata->base) {
+		len = BASE_MAX_LENGTH;
+
+		if (getsockopt(sk, SOL_BLUETOOTH, BT_ISO_BASE,
+				base, &len) < 0) {
+			tester_warn("Can't get socket option : %s (%d)",
+						strerror(errno), errno);
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+
+		if (len != isodata->base_len ||
+				memcmp(base, isodata->base, len)) {
+			tester_warn("Unexpected BASE");
+			data->step = 0;
+			tester_test_failed();
+			return FALSE;
+		}
+	}
+
 	len = sizeof(sk_err);
 
 	if (getsockopt(sk, SOL_SOCKET, SO_ERROR, &sk_err, &len) < 0)
@@ -3383,6 +3443,10 @@ int main(int argc, char *argv[])
 					&bcast_16_2_1_recv_defer_pa_bind,
 					setup_powered,
 					test_bcast_recv_defer);
+	test_iso("ISO Broadcaster Receiver Defer Get BASE - Success",
+					&bcast_16_2_1_recv_defer_get_base,
+					setup_powered,
+					test_bcast_recv);
 
 	test_iso("ISO Broadcaster AC 12 - Success", &bcast_ac_12, setup_powered,
 							test_bcast);
-- 
2.39.2

