Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482516D318
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406671; cv=fail; b=aXuZfuTyPr44iRlugwOM4ZOF77PcsvafkE1CZkqDagNALBI/ow7F8ULFf7YVJYDfXCyQjXTDmbgIInIp4KZC2niD6XIRnMAumOtuG475fSUVrXVJVk6vcXEII/9ntpV0kAKA5aFqZwGgRqMmpJ9rEief7UyM5AIJwIdqjklAIaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406671; c=relaxed/simple;
	bh=8T8yI4uS81JTh8OojwU3eX7+Fi4f8/nPHQCU/zEVqU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMJ+56B/UjcaSkupbLqoPrukU+J7MCLrGkSqGeNXNrsLaAG/2Q9oF22qST6h1/SJ3/w65R6GW2m11lKEqk5Kta53aHCXh7XaRM3a8YZWHuIrzxx1TbuJEBFv/rI9FiHKy3DtdPjHHXWSzRG0dNTB3hOPOiXKNTUagbAsox4Sg30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RA5ISShy; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RA5ISShy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jT+SMiUOOOXNierYI102DWn6VfSqUtTBNNAK2BXDpMAJbA3RJpy4IdJx7JX1yU/FnR1Q95Kr9uMU2POyNR6rCprF7s59xpPjCNcpDIrrDXTBxqCpScMYjDNrOnc0cAtpsNyaReYkPOjWz910mOGxDHQJQlifeCZeCPCrZjIbqptYUEqEdTNMNcJnpMtJOy1jGokdy2wxfriNC4gfCam7w7ZrKogGpKpIFPhHl6x/aWTDyvDgwyesxDAPre7DujhKo6W6l3Uk17t70YUw445UPihoe/rDTq237IwyNIddDlyoozm/dYf0+LPk07gfXZLEdFCfgytWKqVqrVTpkQy1Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UcjMaOO6euH+vV2m5AvNknGUhOfxSXyCI+D/4nN4jsc=;
 b=GqhSbqDEGMdD9QKvBN2BIa5KRztnVUHR6SL0bMZcv95yifSHBwWl49JRP4u/DQ5GXTNBjrtlt5QTDLppQQN0qGEuij093jkJce/h19rEtL9oTncC5w58MJSEYIkxy7WWCyva/FZsFf7GypcZHOMF1RZxCA97Cd5OUl0awQk5dtB0hlGx2g9SU6y13aD1ZXlTqH3/Uv7O6cM1FEk+Lf9Pm+c7AIL1wEG7CkRPmyxO2NQZ1Wh0RJTc2pF3Ve9xka2Hnl4k0IstY0j+dQaebFKh2pzzDc9A6WI2nOCmDeLlqFjDvCwURk/8AOeUbDwv251P4KHJUm2y7WK0FrV6J1YrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UcjMaOO6euH+vV2m5AvNknGUhOfxSXyCI+D/4nN4jsc=;
 b=RA5ISShyY/72PvHDlFQAONLqpfQZIlR7PFqhG7FtFLS374mCBeAB1yJcyevX36iX4kyRotJRn3qwgj6R0KCnZlQcrdbiKNYCdTXVFe4qVHGNtXwhagWEKwNCA4GjDCaNuS80WDQPoOuD7aPgI/IiHXDeN0BIn6D0Alo2wjyRlU9RBwFq9cSEujBus7ivbpgd1W9L+d6OcdbnNXipravgNbZFeq4ajnEQgogomgx0XjUh9cw+YO/AOFOeRkfuz2hr0rTPwe+z1hbka40WD5JAp+mPcbZLJm/WYJozeYwGH4cYwazic44vAV/F+Xc0V1Wu2rGRgfeaKl55OSTurYwHYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:42 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:42 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 7/8] transport: Add 'Unselect' method
Date: Wed, 31 Jul 2024 09:17:12 +0300
Message-Id: <20240731061713.435586-8-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: e8ac7454-2e93-4dd3-23e7-08dcb1287c9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6MsLtQd1onEYDjXvV5UOFIMHXF8CCEbSb3xG6t6UIgmmLlyu8hysWhu8Z5xZ?=
 =?us-ascii?Q?xRgrmhH2zqoow5CsM0nRyaPmYcgR+mbgD1+jw3bcI2WKR/cSHaoof8VdxPVc?=
 =?us-ascii?Q?bhcPUPQVviP07vmjar91CBg15/L371JtxZeT4YPZUvd4D+UZvijlQIdx8B07?=
 =?us-ascii?Q?G2hVUWEMSyuZM4Kc3qgHCyhxBRMYnBj+KFEmOEx8i2QuO/wkfiKvRgWi0WYR?=
 =?us-ascii?Q?Iz08qxGjeKzN/8I90z+nlurXnP2wc3pT2WTFrhlvWbUHxDL/pHviVCBjFWhY?=
 =?us-ascii?Q?MDxTyvrAdQc/6kf4A3KQPYYhESJTYl7Pg/TPSS//9xXwZBuXnIpsZ48S1tXy?=
 =?us-ascii?Q?aD8ccWT5DNGFrgIAv+wqxi/BuGD80fpdmwriSMgGxTbv8sm7OQP3qsWWc0TG?=
 =?us-ascii?Q?Jlgxx/jq5oWRbalP/ptqbqA2OPWTRuVG2B9UrSjTSAu8sMxqaz+L2cM80aci?=
 =?us-ascii?Q?ipCowrOQx5LBtNveysFlQHufOYudzJG7h8XJQrULjdXGRJS7GYuBZ3jXFJQG?=
 =?us-ascii?Q?oVHU6a2avrrMeVkC/Y4yRGKjx6jDhRxkw5P3w5umOjKUse8Z+y1ahZxlQmvG?=
 =?us-ascii?Q?rMWWN3rQr34yttti1f7YvCT5W/Bt3z4wdUqKwR75zaUAOQbuhjG88XYrs7M9?=
 =?us-ascii?Q?Fv1AhNMa3jHm3ACOBo4n4oOo3VK6fyA1MGp553ZQQ0rFgEzQe8TkkcbOfLlt?=
 =?us-ascii?Q?nzoHFgBiS0chayTIiIRYR8iFieoCUbvqh8UbNR/MXw8yfMSqJAmIRFJb83x9?=
 =?us-ascii?Q?N+Bq+zshSaeDQbXawbegznKQYuq8fEAzj/3bWRegJJKEphMhopCJUAyftYT2?=
 =?us-ascii?Q?uom206XHyNly6B/VwfVUkq3K37HeXcCq4aTDO4pzjCPyAbd/MT+6CBjc7jUN?=
 =?us-ascii?Q?cTGYSnsbL59TMeoOwqa3nYSGUPAk4Df72Cq8HLFMoRDVl+108E9Ea8RUOBEp?=
 =?us-ascii?Q?QY84ZBLZlpKXgYWuSMzPui1PUlGgn5RgD/IXOw/4tInN8T1j8JzgZcLXG+we?=
 =?us-ascii?Q?pifTc6kIVKuMLyj0v7+8r8KgFifYB8gZp2eRJ//Qo6eu4hrPMorlvCE5r8SN?=
 =?us-ascii?Q?SVM9Mow+8aVwsLFknv3ywF/FQr8dNdGDTafLqAj4GKwUQN+ygK8yTHol8GJm?=
 =?us-ascii?Q?xJ1917XJykEk0UpK58jYlGRH7oIRqiUi57Epze4Wkcv/hTarTWw4lFtZlZi9?=
 =?us-ascii?Q?L1FGIb0BIY8bMsf+uTjiOO2ZQKwCFSwVH2MgUWq9KXtaPwMnX50R4muf4vgT?=
 =?us-ascii?Q?UsA8vupXzvtataeL0ov7zPWC+0dTLBKNyd4F0a4uGMUTeQeMp5y9qzBaHvFt?=
 =?us-ascii?Q?l6Tl6pp5Hc+odzi9ICDujHau8khFqcPyuPP51GNZzShuBM7sCbsyB1u2AS8+?=
 =?us-ascii?Q?2YLfvzoJ+30+NmfZJS/yZP728j4QQxag3MK7fzAW0qaVxvwi1w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EtovBqlYoMrXqMQb+wljNQ1WEc4RPq9l7nFEwTrhK2mll7KU3CwHFKsEVtco?=
 =?us-ascii?Q?QVkvWU477og79e9dQnylFKzPTkyWofKHKlKgQfelzFB2CCKDDVeYdw0dL7pX?=
 =?us-ascii?Q?EOQQQVA+cJay8lu+9wilWGF1idqJcsZGKqyaRc4cv6Xdbb/y1cj8zsAu2RXc?=
 =?us-ascii?Q?noKcdD9hvX/MoOFXqYyo0ofL0buC9SU+uantlBklprdYm4O+E7UyYq3xZnse?=
 =?us-ascii?Q?FpC/+Yv9ZXF0podeWgQ5zZYJMfSqVXga+PItkXBQ3OZpj2jsawLXICG0p99h?=
 =?us-ascii?Q?PMNfwO6mA6Na08pv9LH9BMP+d7KdAV7BEHY5OJroGVPhpg55DtEZHhruO4ce?=
 =?us-ascii?Q?T5hE0nHZPOPhDsZbB5LY/8wGsMsx3CHe8LMpuNE14if+CE7hpPL592FCjgbM?=
 =?us-ascii?Q?JQR00NbRfA2C/PckYu5rWsf1u7TBTNpgpHgU8MbLi9ZucgUoD7tUS7ysMqzA?=
 =?us-ascii?Q?ODRBueSUGF+a6xDqh35el+1FEdKg54lXiOQdRYP1lQSmu3cr+aapidrHWvDp?=
 =?us-ascii?Q?ihNlfmU7miy8EBMSmQd863tfTkAZ/TnvXHgB2vzGlqd64H/j82DDy78rSO42?=
 =?us-ascii?Q?LKFwxVy+7yhvCbe7naRkuBPURkLg1+p1sv9BsKMNcko8ztasyFRwhwqug7+C?=
 =?us-ascii?Q?2AIVh/1t63wOFz6lXvHvUuG9eZrXGVF11LVZzvoN/edBJJ7YpLWkM3cBp6q0?=
 =?us-ascii?Q?X2Za/Y5RHAVc+NFwGCEu9gOwq5R4lwRGPWoBnQYaB4JEFkJfvwKNNrOKvrh+?=
 =?us-ascii?Q?LvgisvMkZu6RxGrrzrULuSrw2vvTyWoB37R2M4ADQ6xvepfZ4yyKhrqe8Bmz?=
 =?us-ascii?Q?nKTuO3YFffN2cyfNOKHItu7TYM+yXtQM1qChtdCJgMzUjYENxVrbTDIdYxrH?=
 =?us-ascii?Q?T8ICI6r763OSNveJy8gK3vcXNY6Oa+wHN7zMCMMJjz0usK4heik3RrGcC2/W?=
 =?us-ascii?Q?ageI3+qC5LzPAAiaxbZ+eUxhWDHMPIWA/jZO0qOb8VxA+7wqNbIPCQ4VGW/K?=
 =?us-ascii?Q?72O89TI5gsnqQZzphafm0iGkfZm1cFw1EllNfJWP8tLA3LjR5TBeJD/d3HHe?=
 =?us-ascii?Q?lnvCpRM6DdbqPHRVIqw0aRFuWRlp/eSds2dG4l2YL2W0sRGZx2yUwSasn0n7?=
 =?us-ascii?Q?2qgy+OzqyKWRIV57S/AuwH8pXAePpYOiCu2wySuojH8qvgpn2+FSF4bTfjey?=
 =?us-ascii?Q?2LWb+FpxDkDS3mrxCDHAO9FQLlZSE4L6UfbjdKkebxEnhLJdh+f8w7iXYrK0?=
 =?us-ascii?Q?zA7iHdAOksjLGW3lV/fN3CuImo4EDptBKy04icqyvIdBW8E4B4cTJmjlilb8?=
 =?us-ascii?Q?GpK19K/rn7wLjzyN4VtvUSqjXuPKJE/nKbOMfF4xuFxo+WeFcDnswEfUGDp9?=
 =?us-ascii?Q?ZWXhsVcFl7Kvl8JiAcCtS9n5PsQCcgFy0mHguOxd95L0zf0Np5mK8hY5d9pV?=
 =?us-ascii?Q?9aab6cRwN2211Jo/IUGafue26cRl4mMbUbx9lAIvTKpjqyr3dU90xeFLYhGD?=
 =?us-ascii?Q?qzaJCiD5jQc8hVwwpnzHXM1x5EvxZ+Z94MJEf5HDMjx3J4JqpUo6t0L33RDV?=
 =?us-ascii?Q?KLjPfvGBQQjJViDoQlaV151Nbzv0rMWsdakj7gEG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8ac7454-2e93-4dd3-23e7-08dcb1287c9b
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:42.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sNirFFcxTxOwdzrhVbDdg/O+i/KnqJfEVGyFnkgAj3jgOTPd0cZ2k+Hd3oRvjiN2L64DKECwi+KVsJjsOQd21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

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

