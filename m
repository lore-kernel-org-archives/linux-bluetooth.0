Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620D1B0108
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935788; cv=fail; b=M5Sz5dLCNmDiALquMcJTRy/cm53R7UoGPouXJJX98dk9SxjmzZtZWbbtIboGyfAP1n9E9W1+Bj/KRmH+9gCAxe+YFCDGXTbJb5ZKtiDFYyuIMmeDM1lo3XhL/ej66Yy+0A+uR64a3V2buh9fZN6XWogm7fxMwCQoyy7WjSA6VgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935788; c=relaxed/simple;
	bh=ERxG2IDhETKOPb5e7H5IcZXTpeNUeKrSBEgCkSQJI0M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NHzu+nJ0CnNs1rqFRpO1rT/IX88ocneQicQIwLMcNtVuE/375XIatE4cRDbxrEamGCg4APVXBwlpf5EOVkyoAIp6a/UvE4LBbFr0SQKgQXS22Fg6yii0Fo42+9ha87ksCzO53ZkAgnNhtIhWGU4MqnCyii54oF8/RZW6mniQX6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qq8g6V+h; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qq8g6V+h"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXpuOZRobwz4rAsJX6eipN+9Fkf2cyO+DvkPBL2aRO+13Bgqn11A9RxM5sciB+H1OHeuO0K9pj21XRufKi2QfEE2T6Yk5DkE5J5uKMPCMxvRcP5lS64QGv/ldYFn+CVpfnead1G2QQuDPakAgJ6HqKInROHwD/1s2hvHMrSYWs+T9CE76GXmM2rVwX0DVq2sTks3QLWG0AJTb3b+EGFvED4Dk43uafpsS7Ud0kReqgXNPQitU4YDNTDoWIKOz9Mk2AWJlPugmZiCnUARF0K0oqm4e0nyZWO3QmWkTJK+scn/szdV29f0hTnx5cK7CmZDaW5gZKMmNEC87k8TsvEh5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v+TXB8Kqtf7gWb8IYxE1d5u4Txz4gzc4GMY7zCPjP4k=;
 b=kVwtyEfORV/aTTsx4EOtQ0BnwaUMHYL0OUhApWHUaXpL1hH93CLsK4hsSxtzCr/gVfJYOgV2Rljy2ghGokz7f1wcmp2s49CpYyqxPNR9HbLeuQsAjDdWPVd+x39kBI+NIlYyz8GLUpdj4e/KoN0iMXo7hYQvNlpV2dptxZJrJzYOJclJEIv5S64w/dowMUWwqqqmLPllXk+kW+I43qURX5L4kKgx/QMEN2xBcA3KAZa2zZBaBiE/zFrNP3dM/aNYay9YSeZ1gD9Ox2nXVxuT8ez5pTqNWK1AuAIXKSnLMpi0qTtn8S3HljWyjQk88P2YHPbRbQSBtiF3SWDorw8tLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+TXB8Kqtf7gWb8IYxE1d5u4Txz4gzc4GMY7zCPjP4k=;
 b=Qq8g6V+hwXmLJfTVLSNfwVl12wOIDB7MFy6QPmG9Kc6JhE1hMX9b5hV8by8DYnyMJQKGqBjv8U6H7OQo+JyV+bvuNGpNpAoFo6MyMCAZG+rWWpPQpFT4FjEP0J9fizXhJ4UddXIyKc4fgv0QGXAJgkpWvePwlgqEdNBRZhVaem+798YmsBnymGYCah4u6oM+TYIN7+PJOZ+D2HI1WFUZXTC38nZzq661+nOFlvPeWk5itczVtTfW8u+Q6Y3nsocvq3vdYWmRRZFi1WgzFit3HP1xPewKliX1JwfI/b5Dqwwe0TcgEEiremGYkJppSurYXCzjxgfqMt1LCyBh8BEV0g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:42 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:42 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 06/16] bap: Add support for long-lived PA sync
Date: Thu, 29 Aug 2024 15:49:08 +0300
Message-Id: <20240829124918.84809-7-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0046.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: c132e0ed-ac6d-4fa9-043d-08dcc8290d6d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KGoK6KKdZn/qUig7XJinj3gerA9tALxF9TGF+vwCu2lIaDVpMfHQtdJKDBMb?=
 =?us-ascii?Q?uDm9cp3TykTqDxinM6iFcRqV+Wz1sm/8GvCfGAMNMbaYKt8X0oc4DsQKBLFW?=
 =?us-ascii?Q?snAMj8mzzlOSHfiyBvZICklCfWGDM0ptF/JxpDAaEhdTGQsLN8T2/8s5sNSC?=
 =?us-ascii?Q?jsQET9gi92gqBH5WG/SmwKrB8wpoCI3sV3lyIat/tjCEIbFQkQ3YDZRQWPEj?=
 =?us-ascii?Q?QA6424UIfEkTZuj+hljBNP/N+59Hg7OUNk8bRLtj7tGTlHiEuLy5taIIv7l1?=
 =?us-ascii?Q?02GhK3uTEkUFAP9Q95vqGKUgro1FfNoWs0x1maAu100tY1UTPXn5KemnZqWY?=
 =?us-ascii?Q?MDZyUVGCVQ5GJqA6HA4ZAE87aH8kjHi9Wc/M4zEvZW5LQN0iDenchaZK93V1?=
 =?us-ascii?Q?ClRPMNcK/rwxo/Nmn85UzRBlylBG8zpOHGuOGKEvF0P1DVQPh9e8VgNyX7cB?=
 =?us-ascii?Q?Cd0K1uzJzdP145RXVZ3J/qd5TdneTn1LDy/ljcZWBAlGR2JZfIhK2mPHnCol?=
 =?us-ascii?Q?j8Z6WbNPnRWAYGmc6A0eHQpPwVX/P8kX30cP/xLp3SnzT+s2mJfjdcHT4Rgv?=
 =?us-ascii?Q?wVW52e+rsZT0LkvAvUDP4Lzu1wAUAeFloAruGllBhyQHD5gixrE+3o6p7IMx?=
 =?us-ascii?Q?AEIFhuzx1a82huQ/v3NpCxuyFwpK7wV+g4a1gdbdVU507TNeMk6Sds0DXaJK?=
 =?us-ascii?Q?oaGyP+J9A4oc8t6LmSUPSd+phDGD5K2x5Fryy6R+mv1qyMwR1LnMaDNwuB8y?=
 =?us-ascii?Q?nwWiPI3/45sT9lCQSe9kIcRYCDigRYF5JMxjygJCd2BHfmW2RPiIbYDyfeav?=
 =?us-ascii?Q?34EMTPHq5/XJfyqm/xEh0OHYseh1S/GUXXJC8Gcn0C5rdc7aCZZDquF0aUvd?=
 =?us-ascii?Q?teRXC5XTrlxHyki8Md6NzKUOTVEfl/+gNG68L7+yYD4HYofJRLZ6TtdZL23x?=
 =?us-ascii?Q?BBxJu5zSBqM+3E51+bXHK9GLeHiQtn7VnAWP5yK3z2UtpIRdY/tZIq3eY5ou?=
 =?us-ascii?Q?VG5hQQDZ9hdJGW9+g2P3pQDm3B2W/a6zFKkn/M0rPKkAbHg6CM/SqlzX+ZJg?=
 =?us-ascii?Q?9IWyCd1jxKHer4E8HsP0kfcdZj0QgOMo2PnCL2Ala+GCSShAv63dq8W2PDHy?=
 =?us-ascii?Q?kyBYeCoqRMwFZ/5NrdRLqXl37OYG0MXtC+tIBH7zchUSDiPf9U791dIBdM4W?=
 =?us-ascii?Q?r6SSamBsb5PF/LjHRfXWgHOkKNfSNqB/zFQQIKIIlpApbbOoj7BnZBM1hw33?=
 =?us-ascii?Q?Nq/ktX+t2GKeI9OzP8EalCgkqhFH9Dlujq/8dztQWQoPEQFDFqnOQO0+A455?=
 =?us-ascii?Q?9pSTC+4vOF8y5bigH51EYRJxPTsjyZM0DMAufYDC+RAdLQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ur0Fu5yyrK2oDAfsJOwqSW5BR5lqm87uROQ3WiskZ4bcTuM+WKMJpQ7iCTAF?=
 =?us-ascii?Q?I27byCVV18QeWnW1Nj4IXP7PG5wv36Uw834HBUYjBkAuNaOsJ54K+zXCH34s?=
 =?us-ascii?Q?p2O1pe5ii/3WOCnMrEg0vAJlzL8smTD/dx18lRid9HO5uLKKiAtA5V765E8D?=
 =?us-ascii?Q?/ylvEs+AheludNOYTraKtsjeZe1QB0lavbdJN2SZiEK+urSJQpdy9qCqDdQL?=
 =?us-ascii?Q?sGKlVqUcRtodFa8iRdUCLS0wcQiKynyF6Fgt9deyo4qWMyvco2e1y5ZUzrnR?=
 =?us-ascii?Q?dsUZ/pVLAdsneVvLlZbwvWGDf8YR2FmhvSKXqHhGDEarSTXGNXItJc2+d/aS?=
 =?us-ascii?Q?7MQfbGO05jAPbLAcsfWwe9jgNTnxfrNnl0l9yB46xCFkLE6l+6TSnowPKvB+?=
 =?us-ascii?Q?SFw7OMlNAme+5BDGSC8NHXnOtHDCmEp4U8rKbikkarAV7lZfvtdVaGT8F0PN?=
 =?us-ascii?Q?y+zO3BImz/EjVS1NUxubT/PCTWKSK1A1T9U5V92Wa8KJMI0TQV23tTFsxPz3?=
 =?us-ascii?Q?zBbxdgPXTyOSeIsxBlvcxxJGHvV49puDBStGXovVj66rlIY40+KdKz80pAB5?=
 =?us-ascii?Q?K8DdvJFEtLbE5apemPPg6smN4D0FyFA37SOly31A0MgTBbeYCKD53HioRPTN?=
 =?us-ascii?Q?0yxHe8y19A+HqcpvWOYXgwYmPMFqE5w1buplHZgzyYKt1a3myQVWQHeBEfMN?=
 =?us-ascii?Q?kQwgw7F03A/mfWzXRaYkqx10ZKliUaaF5yse+tKBqAGMv3ak0zGdy9cV7CP8?=
 =?us-ascii?Q?Eo7p5RKeRRSxjMOBF9b7YNS3WqiYpEEAhA//a8vCqi4BnedUOWeQ0uFR74qM?=
 =?us-ascii?Q?Zm13BnWhFE6ZP1oYtCmuxI5FlvJQeJMoCRpeCYE7I7JZxHuJ66w914bGPuua?=
 =?us-ascii?Q?dMOvrFtVYyWeL5Xn1ZBQ409JjZxBIb9eSso1mhq7yMNzdb5N9JuVt7PoPpun?=
 =?us-ascii?Q?tSvWoBbYCFy4Rc/lazG4F1td9Bic/QxHtfOyKwpl0eBDZtEShOvaVtFAIsFm?=
 =?us-ascii?Q?kLbiGbsmrnXYN/OOx1VoDyoaXjaWzCSN8xddaN6iuy7GKpBald2NYJW8ZG87?=
 =?us-ascii?Q?2ukHn5WN0ceXUuZ2TjzPTjjDUazapfrpA74xg4s8UCKzDpFce7xCvfB4sdLh?=
 =?us-ascii?Q?/+eenmV7O3cUllRiLFYYyVCV9fUbbkM8lmwhpgq3GYckDNwE/LFdEpp6Q0I/?=
 =?us-ascii?Q?/D7DgD4bJIEihuF2vv5kekwU3+cqA1WylzqYx8ZUNK+4MkuD+/16rlANEL8m?=
 =?us-ascii?Q?dJff+Sr4zDdKPsPTXLUygflzw89f+t2M38LgG3byXnBXmrWhf4oH8qmDPE4i?=
 =?us-ascii?Q?P0uyU9QWTUdRiAMeofsjvKzsnZK6x6mxGwESjVTgOziwxEOr1evAofBcG5iS?=
 =?us-ascii?Q?X63zXp6u7/zDrbxQ935YaFhVnG/FJ6FeI8k709v+yOyiAKhz9nBl2EQQF6ov?=
 =?us-ascii?Q?bP4sL1WvLrrk9C7Hg8Lh2bH0oMmS5XtF3iOjmEX3NsXcNGUqedF4O/RJUnec?=
 =?us-ascii?Q?cv+L4f1iB00UImvTECv4k/Ck1+dFFwKx043/Ao6e2SGH/Wzn/0tvT+rCfS14?=
 =?us-ascii?Q?RNniR/XYzt+ZKAjOaUtJxORXlX2mchHrvswTyBLlUNsO9s/jxEHg+JVB0ezV?=
 =?us-ascii?Q?Vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c132e0ed-ac6d-4fa9-043d-08dcc8290d6d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:42.6279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0Zxj0gE7HR7biCoyvlGYsgGHmuYDhmzrslpzAWbTIttERqRI0cHG+MJpiaeW8V6boYPuvoAA/VuczNXTzbkhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

This adds BAP support for long-lived PA sync.

A BAP Broadcast Sink might probe Broadcasters autonomoulsy (by performing
short-lived PA sync to parse the BASE and discover streams), or it might
act as a Scan Delegator, probing Broadcasters added by a Broadcast
Assistant. If the Assistant requested the Delegator to establish PA sync
with a Broadcaster, the PA sync should be long-lived (it should remain
active until requested otherwise by the Assistant).
---
 profiles/audio/bap.c | 64 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 48 insertions(+), 16 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a2c5a546d..76171eae7 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -127,6 +127,7 @@ struct bap_data {
 
 enum {
 	BAP_PA_SHORT_REQ = 0,	/* Request for short PA sync */
+	BAP_PA_LONG_REQ,	/* Request for long PA sync */
 	BAP_PA_BIG_SYNC_REQ,	/* Request for PA Sync and BIG Sync */
 };
 
@@ -1004,9 +1005,11 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 	DBG("BIG Sync completed");
 
-	g_io_channel_unref(setup->io);
-	g_io_channel_shutdown(setup->io, TRUE, NULL);
-	setup->io = NULL;
+	if (setup->io) {
+		g_io_channel_unref(setup->io);
+		g_io_channel_shutdown(setup->io, TRUE, NULL);
+		setup->io = NULL;
+	}
 
 	/* This device is no longer needed */
 	btd_service_connecting_complete(bap_data->service, 0);
@@ -1255,12 +1258,24 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 		return FALSE;
 	}
 
-	/* Close the io and remove the queue request for another PA Sync */
+	/* Close the listen io */
 	g_io_channel_shutdown(data->listen_io, TRUE, NULL);
 	g_io_channel_unref(data->listen_io);
-	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
 
+	if (req->type == BAP_PA_LONG_REQ) {
+		/* If long-lived PA sync was requested, keep a reference
+		 * to the PA sync io to keep the sync active.
+		 */
+		data->listen_io = io;
+		g_io_channel_ref(io);
+	} else {
+		/* For short-lived PA, the sync is no longer needed at
+		 * this point, so the io can be closed.
+		 */
+		g_io_channel_shutdown(io, TRUE, NULL);
+	}
+
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -2192,7 +2207,7 @@ static void check_pa_req_in_progress(void *data, void *user_data)
 		*((bool *)user_data) = TRUE;
 }
 
-static int short_lived_pa_sync(struct bap_bcast_pa_req *req);
+static int pa_sync(struct bap_bcast_pa_req *req);
 static void pa_and_big_sync(struct bap_bcast_pa_req *req);
 
 static gboolean pa_idle_timer(gpointer user_data)
@@ -2210,7 +2225,11 @@ static gboolean pa_idle_timer(gpointer user_data)
 			switch (req->type) {
 			case BAP_PA_SHORT_REQ:
 				DBG("do short lived PA Sync");
-				short_lived_pa_sync(req);
+				pa_sync(req);
+				break;
+			case BAP_PA_LONG_REQ:
+				DBG("do long lived PA Sync");
+				pa_sync(req);
 				break;
 			case BAP_PA_BIG_SYNC_REQ:
 				DBG("do PA Sync and BIG Sync");
@@ -2236,8 +2255,8 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
 	struct bap_adapter *adapter = data->adapter;
 
-	/* Timer could be stopped if all the short lived requests were treated.
-	 * Check the state of the timer and turn it on so that this requests
+	/* Timer could be stopped if all other requests were treated.
+	 * Check the state of the timer and turn it on so that this request
 	 * can also be treated.
 	 */
 	if (adapter->pa_timer_id == 0)
@@ -2980,7 +2999,7 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 	bap_data_remove(data);
 }
 
-static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
+static int pa_sync(struct bap_bcast_pa_req *req)
 {
 	struct btd_service *service = req->data.service;
 	struct bap_data *data = btd_service_get_user_data(service);
@@ -3030,10 +3049,13 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	const char *strbis = NULL;
 
 	DBG("PA Sync done");
-	g_io_channel_unref(setup->io);
-	g_io_channel_shutdown(setup->io, TRUE, NULL);
-	setup->io = io;
-	g_io_channel_ref(setup->io);
+
+	if (setup->io) {
+		g_io_channel_unref(setup->io);
+		g_io_channel_shutdown(setup->io, TRUE, NULL);
+		setup->io = io;
+		g_io_channel_ref(setup->io);
+	}
 
 	/* TODO
 	 * We can only synchronize with a single BIS to a BIG.
@@ -3086,14 +3108,14 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	memcpy(&qos.bcast.out, &setup->qos.bcast.io_qos,
 			sizeof(struct bt_iso_io_qos));
 
-	if (!bt_io_set(setup->io, &err,
+	if (!bt_io_set(io, &err,
 			BT_IO_OPT_QOS, &qos,
 			BT_IO_OPT_INVALID)) {
 		error("bt_io_set: %s", err->message);
 		g_error_free(err);
 	}
 
-	if (!bt_io_bcast_accept(setup->io,
+	if (!bt_io_bcast_accept(io,
 			iso_bcast_confirm_cb,
 			req, NULL, &err,
 			BT_IO_OPT_ISO_BC_NUM_BIS,
@@ -3114,6 +3136,16 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 
 	req->in_progress = TRUE;
 
+	if (bap_data->listen_io) {
+		/* If there is an active listen io for the BAP session
+		 * with the Broadcast Source, it means that PA sync is
+		 * already established. Go straight to establishing BIG
+		 * sync.
+		 */
+		iso_do_big_sync(bap_data->listen_io, req);
+		return;
+	}
+
 	DBG("Create PA sync with this source");
 	setup->io = bt_io_listen(NULL, iso_do_big_sync, req,
 			NULL, &err,
-- 
2.39.2

