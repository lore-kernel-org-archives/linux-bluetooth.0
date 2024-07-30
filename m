Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1711A38D8
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348625; cv=fail; b=eJgITXiZmC1dOY+JY3JM+l1DkCkUAFRakMuXCH7nOBWVpem9qU4If9pxA001achYbFzQ/aKGSIYZnbEL0gXXMXDrDQtgnrv9vtkfSV2VjiQVl5h425vSt/iRNJFkG7lG1GfvqUY8k+89FjutXAbwVETRZRiiOY6XIFktt7DdGbE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348625; c=relaxed/simple;
	bh=8T8yI4uS81JTh8OojwU3eX7+Fi4f8/nPHQCU/zEVqU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tNrVLyhCSn95dZ3T4fiAM7t2VGU0vOfJzoxJsiCqWK1Lt9ANqj9qTMdIFVzzszbywMLkKsZ4sQJ18C9RlEOdpNljikdBpj3qjiMHfCyaC4lv1mgz+YAVhI1woloQLTgqaXTkxorUjefZz9fT/lHHxG0/jMlmmiCm6c6ocfwRtcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IFuGEf58; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IFuGEf58"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l3T+IR+2aGMCH5rcRjGFIfS2mYJutrFiJ56zVoN1M783qsHa7zdJPBEZqh4DFH2NlqFV/jxgwMCqnvZ24vNtAWLlrwXkyvU9HfIOLMRxYgUt532vKRMLXkFy5biAA+gbhMPmUE1vVNEQQP8CNuNIutIJzQShb89uTaRZqzFxXQnr9M+LrWkiN43NyokTozfHW7T8pLC+pqxRI6T2zV6R1RXFaL67VUIM/Z2DBU2gUdTxVo/U3kfKu3+2eJQOT4x5QdsxoSOVwp0PBE4S3lsMCowY2aDfeyoXgfQHVRxnT+PNsMsMOkQShRDJ6ocY9dfDN0W3Br75H+G4tKHtU3cplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcjMaOO6euH+vV2m5AvNknGUhOfxSXyCI+D/4nN4jsc=;
 b=WRShpypmbsAnXYRfnMJy8OofeHM7ouYv4Uj8uYhWlpeRLm+r+M5vtIa7UlFy5XWqXWSAVDWpSbQz/AcXedsc9DC6B3xY/llHt7ZntvDPhxNWDh83EDpBYyKVmmkZVT17yB5ynFzA8Db0ZYa6UFlpboPXndPFIF2Qtl6UcUCF0QSsMMiLa9SL4k1Cg8yc+hPf8mgDu1+9fO/Q8BPH9iZHKja1b1qyCIVVJJGLYh2AnvtCDBpDEQyBnPNgbMScURDI9sOvRXQB7yHNyKVecuv+gvn4yiEfFrkQkTnpjibeq5N5uCJI/Sx9rRUMhd9pmey8U1eUpR+UKshJijmRZYjoiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcjMaOO6euH+vV2m5AvNknGUhOfxSXyCI+D/4nN4jsc=;
 b=IFuGEf58dHT1mIOS6G9eC1hoX+NxYjavhTsaaDaxJE/BTsSPR+xH8uwK5XF3/7nmaXEg4DhP+Y+OqevBMrr7WmoydqW0hxbpC/M5Lkiiduft/JIuPz2L/nG14FFjJYvRVgjNvZTiqa0r5V+CBPkVYNwPkx7GvCbeSWITxhkX3h19PyOgs7kh2Fj7mHpg1735NxJyTecbs5MVulvS5hfpufTWBiRHRQygobxcBmnLET/OHB/uBl55S9WuwAuOChpK8Mek+f6R8XMDa3SzSDm2ikMeMjtv0inUiM+Mh8ZsZgJwfZnSg4FmIt2utRIghSJG6fK96bwx9yANwg3fmZBpwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:16 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:16 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 7/8] transport: Add "unselect" method
Date: Tue, 30 Jul 2024 17:09:46 +0300
Message-Id: <20240730140947.411655-8-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e8773c8-df1f-4851-b07c-08dcb0a15620
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9PGpkxYYZMrGy/ajNWa3b42yzAxZP60xGtVvnkR2sQsvRGYmaHlQ9G+EYXHZ?=
 =?us-ascii?Q?RIFSAmaUegXVJOrwEq6L/LrfGIl/koDDmknLhi59EHgLvBipNGWeYuGoiuST?=
 =?us-ascii?Q?npIPdidWyxaNkj+cmgUoHwt/+I2b4nt6oeeBFTQsOwb1SFMtYXGSRXNiQHun?=
 =?us-ascii?Q?mP+twOB264XcObc/d2NCx82EEt88zwIKreEVY63pE8Pdqw65cit9/0JKqEtm?=
 =?us-ascii?Q?5tdcNT+z9Qu0n36hjt+WRz2MeFWl2k3QdgmW+wuFklVxrPuiwe/JdoWtX4V/?=
 =?us-ascii?Q?79Oit2jqpgdx29wMKMtspxi4oLxBnxRE7fXbep+tL2iWFVZZNdAAUxNybPVJ?=
 =?us-ascii?Q?2kZ0OiW0YavglcsEN/a8UQtTt8zIzXNxyJCL/n0ATx5Gndhw71kmGPHMJhD4?=
 =?us-ascii?Q?bd0x21IEo7YAZdS0XO315lQWOrCy7/I8OA9bNs2Tog3ZjsbAWbz1yauHDXkU?=
 =?us-ascii?Q?6qQViXi5NCHAVwe57leNyB8DLyjZRR6n8jPJ6PXM6Bneakwh0e9APOPE/wcn?=
 =?us-ascii?Q?/4ekGx6JApzOGF8Pl06RJuYxHz8yvU9833zac74+K/dh4tU8D3cYggti8ocF?=
 =?us-ascii?Q?aOYg1F4vzNwU/stOnq3f5mi3QFm7eZIyg5ymWFnfIZ3psPXbWVYBbQNaVv/Y?=
 =?us-ascii?Q?Yq8f0UQVeAmcFwaTNVkJYIBkhdZPqnsKsDUSD7wmjivEA0eLZdnSYg+uRn3n?=
 =?us-ascii?Q?KUAWDzDUokHejbAmocjjJdn/ANOPTKZ6a78+292EiRnzafnPlsmKVEAAi1GZ?=
 =?us-ascii?Q?4FTW1vg4ii1YZu2cswh65DaSAynmxsiiYeWynA7z4/Gela8pzh9KQIqtaQtV?=
 =?us-ascii?Q?UtIKj+rGWrgdDqWo9XS7b801R0T8suIXAWHL8drgsWJB4d1FgtnDWxX/QeC4?=
 =?us-ascii?Q?znxkLS+GVOktQebmI2UUstfRiZ9paAh0qq5ow05Es50dlNz/trGO5ff0X/Xk?=
 =?us-ascii?Q?0io9ArkvSY2yLideIFHFjCHlpZ+CPeN6ugNyM72SfY9qfzAS/3WAAL/q5klU?=
 =?us-ascii?Q?4mJf2CD7OD4tavWxzLEzU1sX1Kek23JLDn2y1QjCVehTOWH17on/C5V+7EY1?=
 =?us-ascii?Q?ms+O+YboaAQvs3qS7PUXGnFltxSHta5nqrNETV6KX8P/AHT6ZwHvxlZL0kX0?=
 =?us-ascii?Q?2PjoO4oZL3ohbqERKE0Qg0B3fY1BBjTePjABse27mmI2IiWRxYav6J6H3mxz?=
 =?us-ascii?Q?5Hi4FzX1EgADyEdQ1AIpdWeS/dwSm/B5/oeG6on66bw2u4ku9YFtphkGiwlt?=
 =?us-ascii?Q?nRGqynxdn0tEcamhXbBkiy8IeEbkpJ3RHv3zyUBAC3Ul582yNGJs1jOkBw5Z?=
 =?us-ascii?Q?eQ+Wes2UGyKTR/TaXdccZBjsDGAFJhpl5JIXHdaxnzFvyLQSMV4o5/FBWyKg?=
 =?us-ascii?Q?R//alakEZvkWaIvs/llVafpd/Wawcffibr7Cjul4G7ZHhofjmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nBkT7seIA/bWU5WYkzoHDNOskg95uUecDDXVkkTRiy1W4q6ey+dkQzUMElz5?=
 =?us-ascii?Q?l2JLwENoBBAghLZNPnAHnMjIyTVpUetEOG5SbcZT/WJHAHhL1JJbZjL06IL3?=
 =?us-ascii?Q?Ll34XLEftk6xedJ+CgKDEix82dz+qcK9gNPo7771UHbMjEJXj+fCMcLMF3Qt?=
 =?us-ascii?Q?cGtacv4umnHzw6C0hITsBqaBGGYpqtkRhH5h0UpXclGo1Or3M0GThzRhSTQQ?=
 =?us-ascii?Q?SvDym+va+jeH5/hPcg7zg7Hui62E4k2R9vIyY+h/bH48TfzHxmm5cKVGQeZh?=
 =?us-ascii?Q?9bLUD/HyEhY+zEMkSPWhhwv9h/YAgQlUkyBB4hk/gnCt4QtWJHy2WT5FOuZ5?=
 =?us-ascii?Q?VXx2m6Ibj75Son5UJ9DhpU6bmWJFf0IsTq6rPp+pjgdNz8EZ2H86B9RGCltb?=
 =?us-ascii?Q?VouS1yUkCS9Zt8Kt2z7QkGNVShZ8RBZXbhcXVUD3htlaHRIgETbp+nH0YNha?=
 =?us-ascii?Q?sJ4O5nHfuQgXIqOERnBsRxUTM7psBjNd5pXHLRVJ1cT/UdahjErBKBwbV0f/?=
 =?us-ascii?Q?yw8M9bKY6/DWE1xobwU6j4GunrzYytIwCapXVwdvvwEXg1Uv+2QD5mjx2Myv?=
 =?us-ascii?Q?EIZThk0GOuTFLRpeYe+Jw7zNGQgwp2F6Z9WDM6krT8CVu4YhIYZJlINXmqQt?=
 =?us-ascii?Q?oGlbJ5sTkv8VHb4v5bqfnk+3/k1SqEPsKGCiOA55XVi/lT1jrnFuwqPv4Ips?=
 =?us-ascii?Q?vTl+igFKwuooDO1DefrQQk3MLopxJ77dOJo+GE8yinhdNrQOh1HUa+Stzykl?=
 =?us-ascii?Q?OgYlSXnAHcbDqx+yfDfZ5R2JozWwSdjSec2IAo41C1C2XL8g+fhHJwypNS+E?=
 =?us-ascii?Q?o1Yhs/MVwEqBIrZOh8h0l4fWb1eDrkDHK8MCSjjAC5cBNBWTjV3dy2VJ89QM?=
 =?us-ascii?Q?ZT2QpO3VHJ5VK7u8KcBXyMLeWWCCs7Vi6ggZOAFYqM183zixN9ggsNXrUXW6?=
 =?us-ascii?Q?0PiEoOrbAUiBUu3E15nGtR2vU6c3jnvFFn1YHLPOaknELkdCIAteJdpf7zLA?=
 =?us-ascii?Q?L1hPh9WnO7Ok3tAhCJmXQ57Kv4OE1OQjOj4aizjWrDt6uiQfyLadNygjMJop?=
 =?us-ascii?Q?1FKPDjYec+Y9MMTtAmDEHE77DN5J6OJj38C3nrG2Fx23xkCQ9HNeMH9YDZQu?=
 =?us-ascii?Q?oFpU+f75myqFL9Ey6uWZac7kK19JcIfX1vvv23swtdpmfDZPt7MR6egaOofJ?=
 =?us-ascii?Q?vNlfA+eE9kC9ydPfY8YWzcqDhV4Tg81ueNgsJ0qdXHhBKxvYlS4TglQITxxo?=
 =?us-ascii?Q?ZjYgesuRQhQYobHW7Jm1fCocttRphR57vlGFpSH0lbaSHemJCeaFwsxenpWN?=
 =?us-ascii?Q?F/w2ZLfhp5Y5RH2b2FSwaKteBeat6tTXxwXsjxbv1//3sPC/xrMsefNTuSZk?=
 =?us-ascii?Q?SzzwTaf7l6jgkHrbkVw9YwFCtkSNACqMWWBJ9HsLeFCOAP9IEtfe/oRVC/lm?=
 =?us-ascii?Q?tIZHdbtymbV/0uVG3yS0wsw90cNahyHLtAN0j7ji1GX1gjhDZBQyjuC/0hif?=
 =?us-ascii?Q?ZYC3IONSumY6bCa7xbqd8t15aqeKiNa3urng1uRxoMJEToCW1PGhIj0tLH2I?=
 =?us-ascii?Q?bQhc5dxNK0kbPbI2FiRFLq5uc+Gxg5YvGTiQ3Kv0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e8773c8-df1f-4851-b07c-08dcb0a15620
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:16.2722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tVoci60VjEh4xewE0MsJsxZTuOpQojb3ngr1GAgGdi1OE5zmkE6Kk0YWBLmiiXT4kft7hTSTMS7jMuJfG2nBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This adds a new method, exclusive to transports created by the Broadcast
Sink. It allows the user to terminate the sync to a BIS, via a 2 step
process. The first step is the call to this method, which changes the
transport's state to idle, with the second step being done by the audio
server which detects this change and releases the transport.
---
 profiles/audio/transport.c | 41 +++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 80e4f564c..300145794 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -975,6 +975,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 					void *data);
 
+static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -989,6 +992,8 @@ static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
 	{ GDBUS_ASYNC_METHOD("Select",
 			NULL, NULL, select_transport) },
+	{ GDBUS_ASYNC_METHOD("Unselect",
+			NULL, NULL, unselect_transport) },
 	{ },
 };
 
@@ -1295,13 +1300,22 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if ((transport->state == TRANSPORT_STATE_PENDING) ||
-			(transport->state == TRANSPORT_STATE_BROADCASTING))
-			transport_set_state(transport, TRANSPORT_STATE_IDLE);
-		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
-			/* Remove owner */
-			if (transport->owner != NULL)
-				media_transport_remove_owner(transport);
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BCAA_SERVICE_UUID)) {
+			if ((transport->state ==
+				TRANSPORT_STATE_BROADCASTING) ||
+				(transport->state == TRANSPORT_STATE_ACTIVE))
+				transport_set_state(transport,
+						TRANSPORT_STATE_IDLE);
+		} else {
+			if (transport->state == TRANSPORT_STATE_PENDING)
+				transport_set_state(transport,
+						TRANSPORT_STATE_IDLE);
+			else if (transport->state == TRANSPORT_STATE_ACTIVE) {
+				/* Remove owner */
+				if (transport->owner != NULL)
+					media_transport_remove_owner(transport);
+			}
 		}
 	} else if (transport->state == TRANSPORT_STATE_IDLE) {
 		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
@@ -1332,6 +1346,19 @@ static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
 	return NULL;
 }
 
+static DBusMessage *unselect_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
+		transport_update_playing(transport, FALSE);
+	}
+
+	return NULL;
+}
+
 static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
-- 
2.40.1

