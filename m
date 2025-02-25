Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2070.outbound.protection.outlook.com [40.107.21.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1681260A2D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 08:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740473073; cv=fail; b=hOVH2V+EHd0+1XuIMyK/VlW0KY7qL7e1FUFP/K4lVSYJ1xkAysDovrNYawNkDnwSBUkzwOHnm6cm4Q4XEcyzqQnsuPuwu71Hr38EBpCm3NEnRmeNUDExVJ/1+LwVjw7bp+eUhHNVgmDTvijZ9uEygMsl1KgZDFfyPSBRiUHJJBA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740473073; c=relaxed/simple;
	bh=PKfL2qj4SQcOtIgIGD16MGrMCJrZIp5qsf9bKTGRRsg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AiZIHBQEpAbPnxExTvHt7xueCHautoK6p+nFLYFLDL0ScOrsqhgy0j6fewVV43zf38U8xgeu/kVunL5/akd+3r+11ETAo1yMhatLkogSzo1YWLSEYEyT+S3M9ujqPmgoJPpqv0hAmAuEccl0wwoeRTmECwUTsFv9dYzdQZslsyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gh9xvDU5; arc=fail smtp.client-ip=40.107.21.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gh9xvDU5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=he6blR8X79vjAVPc8aiNlmCFID3k2lEXw0cewHdS2YBto91W5FQaxeQqEpP9CY9+AsTVIUQGTzrTo/aQKSCkG1dLfg360M5bRbOnvY1trV869Yr8ehNPGOD5PrOArgpVE80c4B7DAneQO4QtSnPtCNxeMaXy9s+aUC0t6/OT8UyLWwHnnQufQ4Cgh/WX9VxRS6W7aD4iZMvudKMnQHBvvyELcs6dJu5lLYsdeXYcBWu4oi4BVmZ5ANjBS910GeVmdeJ11KrhFhHbpZC3k4WjjwcnVr1sB78rkHaYnrb3zY9vjd2ZFq6IO+ANZ4XyWZ2x0ASFhiVNpPYGaGhlNxhK0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AhznEPCvN+MCgMYJhMeEw4i7RXI5fNyAO9yPXDXrQgk=;
 b=wu3tMI1B4C59EYhJ5O5kM/5P1u4O9mRu6Td4zY6dMQlHuqBzFxgTR7mNOzcdMNS3QIklcQJNIn68sW56ueq7foAavufoW2wNQNnXCtbAeS25FKdIxi8YgeyAGBHXB5HDxkTvP310tQ2SLmKA6UDt58no/TtNUc/F9/xuKzXqDJjbe/Nn5dRItiJagA953MX+Ny4LyIxhGL0EK9cpFWOLhmZifRSJYQM19WKbPrjySW1KK0lmh5K3WHaeEZbf88l/0LKkSvvOLhH+yQEFDaHXx/IZAHYJsf4UA5+4HvXzKVLHACaL7ubzWQ6Y65bhoVYZgfwk8lVVny6L0YbnkGklTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AhznEPCvN+MCgMYJhMeEw4i7RXI5fNyAO9yPXDXrQgk=;
 b=Gh9xvDU5CJFqMLbiOj5St8XUg8ArZzTR3N5x00XukX1mHQKa77Al945tAVDmwz1nZdAdgdU2C7BT/uVBAhTc1j9LfDMN/z2ze7i6hIXoIinL1numtMXnBXsWf7y01iK5yhaMaRMgb/6HUudoAaCW7ylFpuqxtx5UhWXjjSfIaN5errcdyGO8NSgPntXGiQSUGqzxiib/rGp0+CZtj4ov+SsGCOYPJXVWVluGa5OkupHLpFV71ZAm4rTqhIAw0R14TmkkaqY5lsG32J04KHBzBXhSf/35/7hGXGmMEfdHHVri2BgfHTBiPTT47cZWDvhxspCfVEy53WI9YEWtgTYYVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9570.eurprd04.prod.outlook.com (2603:10a6:102:24d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Tue, 25 Feb
 2025 08:44:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8489.018; Tue, 25 Feb 2025
 08:44:28 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] shared/bap: Add support to register bis callbacks
Date: Tue, 25 Feb 2025 10:44:12 +0200
Message-ID: <20250225084414.28677-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
References: <20250225084414.28677-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR07CA0025.eurprd07.prod.outlook.com
 (2603:10a6:205:1::38) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9570:EE_
X-MS-Office365-Filtering-Correlation-Id: d94e4e37-8aa5-4416-857c-08dd55789d9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fr4I3vfZQEk31sM6lphFNDkf6D0vC8UjKhQ4RkduiPYPVOiP7HzXLpZVydKn?=
 =?us-ascii?Q?fsvw2Mjoenv/aKUkwaPVkSi+YbSiZWTIC8OI0oXOws5+Wmm9sQZ8QwtXdl4q?=
 =?us-ascii?Q?9kUs7ZOMxdvNAvgfOcRVbXGaYfzdYj1lPoR1TTSW/56hl4zbl7NJWcMiZatx?=
 =?us-ascii?Q?9H+PYfEXWbFgCd6pueyB/gWAr7gpueWvpRKTABhdwbA7Qtftle/TIiRlkyy/?=
 =?us-ascii?Q?RUs9p/VncjksEXstnfKIFDbDvVQ8nzu1zF2TBVX5A1U+7gdD/1uWEHrDGwF0?=
 =?us-ascii?Q?25S5LXkjM+5VLxkIoHjTX7hzK6on8y1Qb2pA8limdYQZcxdy67dhb8VqLANM?=
 =?us-ascii?Q?6flZXxjVtK5FpU2hVVARJ/q9BdZzDOMKM0RS+7XMg4VG51K21nJWS0HMmCz7?=
 =?us-ascii?Q?p2g3HH2ZJdJg/+U5paFHtIB9iJQN4z8IXxx3fOVoiI+JKWQEJQe8vUDiX/uN?=
 =?us-ascii?Q?w8pElpbT6DqS9nvvfM06Oih8c4brMlymrA3N3rXMxwPdypm6lKFDnud8KPIH?=
 =?us-ascii?Q?HWeRs0V9YpJV6MeEATezmT2TVVh5z/iDJ7cVtNmlY+OSqnDd3m2OKk0F86zy?=
 =?us-ascii?Q?tOzVy1Q5MJe8HWWOvQpjLwv+axh4AdgiRMhZzq+dv1JSUibf+Z0vwcHXsfiC?=
 =?us-ascii?Q?UKZUp3fjsF7YQVFRObSJPzyjLHtxLuXbjhOri2XLJ6qhvfF9jv3YgYkpxEiW?=
 =?us-ascii?Q?8k/5daUqUh2h0mImrPi+Dg3q6PZDQiFaiAGkl+tsyvOtef0eRmtiVBW4CnVS?=
 =?us-ascii?Q?m9tqwNF31AXUnD2hAtdtn3j2tXdTA+i8MTsDKDNrd071QmfMOzcg8n8Mwss8?=
 =?us-ascii?Q?ewXFSgR06YYU74jfnFBsqOBMJIW7SJ9pvx8Wq7bw5wO8uxJFUVmjVr4U+cLV?=
 =?us-ascii?Q?7zlWKWhZEsb/I0ylpEaQEpWSKP8G7QTaBmLYKqctau+EejEZENcKy6Dh8+A8?=
 =?us-ascii?Q?vV9oBw4vtBRbWHqzIiJsNpzsDEc42tKBdpebtfQ3FF64snalSM8BTjiJYadR?=
 =?us-ascii?Q?GIVv/lvOaYHoy2LSLm7ZHRKsSnfMYVzsc+fzqetCVX6jvPpEke8R0xL42gyZ?=
 =?us-ascii?Q?p5Ijk5OaYaoA5LSxgxh5sPLj+vcFdOMb9k8dBp4yLytYHgbDI9AwO5cJ/x1u?=
 =?us-ascii?Q?LKbd7+LzftCeZHGW9HXLmrU0jSEscF83HAEd5RcTwp9U3xbDy4GZttyzP2bd?=
 =?us-ascii?Q?OvQhqr/gUzxmz5i8fm0UOELObu0JIJjsonXfyJuaxT1TvdiaUkwS3Yqscud0?=
 =?us-ascii?Q?sYLd/aq55Ah3Yd5P49hVuAX9KgOVxvnvzE6FxYBIRkbKrTau2OvHI1QCdwBM?=
 =?us-ascii?Q?wejXwJXEzBeqaE4ij6VF8Px6+r0ZxLnRw8fTuSnKSWoSjxYBANHP1LFhfNci?=
 =?us-ascii?Q?bAXBUt1FkihppLAGoLM5fGPOUR+0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HzpwLCPdoGnEFL3gdphfyU38jVTITBnKclCLQtPJ4/1dtU/0T8s+l4WXyt9q?=
 =?us-ascii?Q?SgyKl4UXUUOZLXoC70ZpmA+xDGnBkXpQjMG866SmO0d3fI1abkcA2YNBikHV?=
 =?us-ascii?Q?0FV/2vXIP8ElpyWwEvWHSNYiRiFPpLFdiFjZzu4G+r6CUI0zOBi7I8/2kSVm?=
 =?us-ascii?Q?jZpqj2koWBv+Yf8btlRpTbdyErFR5oGiqHfLeK1NWY8dL8R0DhZ8xY/H3lIt?=
 =?us-ascii?Q?dEC+7hJNdKceyCRANzb1mRo1Cey+pV6eQClbC9P+NC+b+BcOFdPtwh+zkLx9?=
 =?us-ascii?Q?Gu3iDJ4K2xb/8XcM/Qf4SlSTXy6hqCiet0+BYpIhcqU5kQxA/wWKOIxLF0+b?=
 =?us-ascii?Q?IjBrRb/pnxZppKeHWbtdmGXm1zSO/xfVONeI6eqzeQJV+Po6UHATMCmxlDQB?=
 =?us-ascii?Q?u640Hga8G6PvgmPqIk4mR+VpQ47EX3JIFApNPZOEPH35NVwu2Ob7QRrFhIRl?=
 =?us-ascii?Q?2SBv+mq96PTypIQEHLHvVoVn+kSs9tF/AFEuHLgUeMTsTwRQ+EDzv+hLKMFy?=
 =?us-ascii?Q?d8chEkmTy6EAw9/g7gWBRRyeAX2bibXW6UT2XbidSX2tcOaUWRKkYbMrlV6O?=
 =?us-ascii?Q?LMFH4jnoSVaVEy92ensJ2GnjDsGtNPDbpOS+cEzSz68ETfaqZ6FHSEi5EqVf?=
 =?us-ascii?Q?r3ezS8kq1mJer0miEZyCmptT4XlHTJYEWWw8+TkPfO/umwLtUdPMQJUTTW74?=
 =?us-ascii?Q?yj8Ah5yrMKhqiFgcY8zpuBasLhe1CXIcoRhUrBIjv7UkDg7TtFCdQDaore9L?=
 =?us-ascii?Q?sFy6FpjiArYcVd2Qr/hdOcOXxhbaTDBQSzWN/1L2pzxMkCRK+sXfDL2+8ZGh?=
 =?us-ascii?Q?jn7QvshOKRJatwfp+BIrA7tMepnJu9O4yjMOAyubj4Vf6Io9Iz3XCG5Pj+5K?=
 =?us-ascii?Q?NJ0ViHiH1TJ2iHcOiPQmQRDna1z2qhg4RtHTwgI3tnib8Al3Ywa3upIYD/qE?=
 =?us-ascii?Q?xwRPwmMpPmimmsvO9Bc7pxqX4RzU2cdviFO6iS6bvCUMZ995jrDvewSICzYW?=
 =?us-ascii?Q?oKg4QYedjkQ3TIA6ptAJkV37/gL15fl7pyHGCcmLp5oYZ3yoYpFZu0dkS2Zc?=
 =?us-ascii?Q?9bN94bFVctpxRU9iCWsW407mgJjO3u7kHt2ABcfM0DBVtOPQxBKloO/sBIZz?=
 =?us-ascii?Q?2E8XZQEwg04Am523fE8//h04QjUG4++h+dUPFozq9YT9jE70+C94yDrrMRGt?=
 =?us-ascii?Q?Lg8fjt9LmGsrJdDTU5dmxspZxqmZkS18hrU1ECe+kZHtT8Fuzd/fXNI/APCz?=
 =?us-ascii?Q?fs/EXsW403BFvH01UKYkQzHVlTJvfHl6KZfQEEoK0cqTN0JtsMO549A1Lkgg?=
 =?us-ascii?Q?4v9KMRTdW4L8mgtfPBZpSMWqxb0xmvspFiVTZnwAE0FbDRhBxXjuuH54rAbN?=
 =?us-ascii?Q?FbQcykLrBq/E5Ury0fXMA2FZC92+SmqS9KIWPGz3UWY1ika4ShaYpN2JBu1U?=
 =?us-ascii?Q?wncBne79pgS7wMMngtyMd1lqtqmofhECrrnrv+LqN0moFM5/ZmrDdf8AnCni?=
 =?us-ascii?Q?5MaSLpa3u40OoCkPlhM5Tuat3U3vVbCKyPcIgSRDOxvnvhG6A2pWUsGYvZBI?=
 =?us-ascii?Q?45BFJxCynEAmpLUrTZLgk9gy9EWeGz3ZjcHzhNv7vZUMIYtdkZkJcktOLsQr?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94e4e37-8aa5-4416-857c-08dd55789d9e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 08:44:28.6662
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWIazuAFCZcMIxHoxjQ7uQxfcw2TkUFr/Oi1fiLhl+6DfYUFNh2QGpK9QDON8jzJ4KDnBSlN7dXu5TfjN37ftg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9570

This adds support for registering BIS probe/remove calllbacks with
shared/bap. This is needed by the BAP Broadcast Assistant (BASS Client)
implementation, so that the BAP plugin can notify BISes discovered
after parsing the BASE to BASS, avoiding direct function calls
between plugins.
---
 src/shared/bap.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h | 12 +++++-
 2 files changed, 108 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6ffeefa41..76df7f4e4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -80,6 +80,14 @@ struct bt_bap_state {
 	void *data;
 };
 
+struct bt_bap_bis_cb {
+	unsigned int id;
+	bt_bap_bis_func_t probe;
+	bt_bap_func_t remove;
+	bt_bap_destroy_func_t destroy;
+	void *data;
+};
+
 struct bt_bap_cb {
 	unsigned int id;
 	bt_bap_func_t attached;
@@ -180,6 +188,7 @@ struct bt_bap {
 	struct queue *pac_cbs;
 	struct queue *ready_cbs;
 	struct queue *state_cbs;
+	struct queue *bis_cbs;
 
 	bt_bap_debug_func_t debug_func;
 	bt_bap_destroy_func_t debug_destroy;
@@ -4190,6 +4199,16 @@ static void bap_state_free(void *data)
 	free(state);
 }
 
+static void bap_bis_cb_free(void *data)
+{
+	struct bt_bap_bis_cb *bis_cb = data;
+
+	if (bis_cb->destroy)
+		bis_cb->destroy(bis_cb->data);
+
+	free(bis_cb);
+}
+
 static void bap_ep_free(void *data)
 {
 	struct bt_bap_endpoint *ep = data;
@@ -4228,6 +4247,7 @@ static void bap_free(void *data)
 	queue_destroy(bap->pac_cbs, pac_changed_free);
 	queue_destroy(bap->ready_cbs, bap_ready_free);
 	queue_destroy(bap->state_cbs, bap_state_free);
+	queue_destroy(bap->bis_cbs, bap_bis_cb_free);
 	queue_destroy(bap->local_eps, free);
 	queue_destroy(bap->remote_eps, bap_ep_free);
 
@@ -4310,6 +4330,7 @@ struct bt_bap *bt_bap_new(struct gatt_db *ldb, struct gatt_db *rdb)
 	bap->ready_cbs = queue_new();
 	bap->streams = queue_new();
 	bap->state_cbs = queue_new();
+	bap->bis_cbs = queue_new();
 	bap->local_eps = queue_new();
 
 	if (!rdb)
@@ -5519,6 +5540,82 @@ bool bt_bap_state_unregister(struct bt_bap *bap, unsigned int id)
 	return false;
 }
 
+unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
+				bt_bap_bis_func_t probe,
+				bt_bap_func_t remove,
+				void *user_data,
+				bt_bap_destroy_func_t destroy)
+{
+	struct bt_bap_bis_cb *bis_cb;
+	static unsigned int id;
+
+	if (!bap)
+		return 0;
+
+	bis_cb = new0(struct bt_bap_bis_cb, 1);
+	bis_cb->id = ++id ? id : ++id;
+	bis_cb->probe = probe;
+	bis_cb->remove = remove;
+	bis_cb->destroy = destroy;
+	bis_cb->data = user_data;
+
+	queue_push_tail(bap->bis_cbs, bis_cb);
+
+	return bis_cb->id;
+}
+
+static bool match_bis_cb_id(const void *data, const void *match_data)
+{
+	const struct bt_bap_bis_cb *bis_cb = data;
+	unsigned int id = PTR_TO_UINT(match_data);
+
+	return (bis_cb->id == id);
+}
+
+bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id)
+{
+	struct bt_bap_bis_cb *bis_cb;
+
+	if (!bap)
+		return false;
+
+	bis_cb = queue_remove_if(bap->bis_cbs, match_bis_cb_id,
+						UINT_TO_PTR(id));
+	if (!bis_cb)
+		return false;
+
+	bap_bis_cb_free(bis_cb);
+
+	return false;
+}
+
+void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
+	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(bap->bis_cbs); entry;
+							entry = entry->next) {
+		struct bt_bap_bis_cb *cb = entry->data;
+
+		if (cb->probe)
+			cb->probe(bis, sgrp, caps, meta, qos, cb->data);
+	}
+}
+
+void bt_bap_bis_remove(struct bt_bap *bap)
+{
+	const struct queue_entry *entry;
+
+	for (entry = queue_get_entries(bap->bis_cbs); entry;
+							entry = entry->next) {
+		struct bt_bap_bis_cb *cb = entry->data;
+
+		if (cb->remove)
+			cb->remove(bap, cb->data);
+	}
+}
+
 const char *bt_bap_stream_statestr(uint8_t state)
 {
 	switch (state) {
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 200dc8f13..adb531b4c 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -4,7 +4,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2022  Intel Corporation. All rights reserved.
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  */
 
@@ -269,3 +269,13 @@ bool bt_bap_parse_base(struct iovec *base,
 			bt_bap_bis_func_t handler,
 			void *user_data);
 
+unsigned int bt_bap_bis_cb_register(struct bt_bap *bap,
+				bt_bap_bis_func_t probe,
+				bt_bap_func_t remove,
+				void *user_data,
+				bt_bap_destroy_func_t destroy);
+bool bt_bap_bis_cb_unregister(struct bt_bap *bap, unsigned int id);
+
+void bt_bap_bis_probe(struct bt_bap *bap, uint8_t bis, uint8_t sgrp,
+	struct iovec *caps, struct iovec *meta, struct bt_bap_qos *qos);
+void bt_bap_bis_remove(struct bt_bap *bap);
-- 
2.43.0

