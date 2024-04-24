Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2076.outbound.protection.outlook.com [40.107.105.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C9415B986
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967693; cv=fail; b=RPhVP/N2JbTFqrqlmpphNiOFg5ykHEOKsYyGgWWNaEtmvkJx40PiNjEuI4Zh9ymYnQ4yjsRr/AlCs4HM4PiqfwLjQCPhrky/HEZnYsG7InHyZ+xFCKSPEqw0oEfz2shvbursmjn6lMSWdPBGqvf7AuB0CoZKyulFycq6Lsp0co4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967693; c=relaxed/simple;
	bh=JvvG4CU40e3ldfeTSs8j1C5BYI4tHfib12wMV5Svlzg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eMWLbCLs+UvZwpFf5JiTuSuLngvZRK7xYggbu0bc6cLH8X0ILQyk+LutEm2qRXVpcA8ugH+rnVFmcUWyGnVxS+14jo6xVEqOLyUuN8n+Og8e+CWH5+/QM9DSPQlLM45TT3N/R/b81clyTxihWuejV1+MBLR25+KdjCcbvsd8cX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=tAXz4gH4; arc=fail smtp.client-ip=40.107.105.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="tAXz4gH4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AWTS53QuVsb4NpYraIPWIq6dxT33Iq57uFcLVyha8F5vL5XlSjOnuYKI1amf4v1zfon3VyKpvesR6ihOdI7BkrP9X8Uj1G7ihw7sVRbhNAu4BvPkIj3Nttv4aYROJOJtjlzebyGdmMS13dvIoHttKeenUmsxRh7xKgh2NmPOOpNpq2OreSYklOXIOSfbJkkwrialUF5cvXYFaC1mNz+/n5RDcSNnX0gmQ9u/Z/k6q8wh6fLpGRpepaf/lHw0H44W1M22kANzS/Xf+uqXsvLd8mmzw8Y51Jb2IEcdYi9MhCmyVt1hnWCSvUZ3VmO5qkbtAhGSeuKjewwl0J2ls9XD7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah1qdlhwIRAfKrdXvwMq+RXqgeeS4Ss7tDXnkwt4G3o=;
 b=oPNTaHrpU22DHkCsA1meaTvWoSyG0wl/32Gog82uqibpDUaTx/C+peCyE46y8I2GvmTDmK8cnWV8reM9NJIJ0zaN+GP4i+HE3PDEIrmoG/+ETsQJMWGruRy9nwd6iFgf6/U34+eHqnR9x/DGSHUSKTrOyTppNGE81IRdEsVemAulVFoDLxhfCBrRg/VSKuClGF/tDTlvpCkL3RXmcUSNIL2p8PL7mSQ3/zmyK6lMkerAW92o501ntyAT9IM7DoEiI2Cxz5fXtyLGJABggGoHnhVg64PPkWwmz2yEBKOAYuOiCkj5ACYPQ0qo9mYLum0HN+J63PqbsxVO3T7aOST4AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah1qdlhwIRAfKrdXvwMq+RXqgeeS4Ss7tDXnkwt4G3o=;
 b=tAXz4gH4elnMrJnzK8L4YkkIBtPkE6u3fAOvcBa5hQ/+pZXBLzH+N0zxN6KYRIgLU4riRSkFTd3RHrUVE8dCl6Bb06bmn+ridws+TLFBRffADm3pcyKMWsUiiwnEnNPBX2URHNuBMlxBjQtluMRdXgmvefyg1Xp72r6MrIcVDHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:08:08 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:08:08 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 1/4] bap: Initialize bap_data for scanned device in bap_bcast_probe
Date: Wed, 24 Apr 2024 17:07:38 +0300
Message-Id: <20240424140741.73899-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
References: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To AM6PR04MB5384.eurprd04.prod.outlook.com
 (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: c099fa30-8806-4a9b-a4f5-08dc6467f81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yj1bgMBEpV53qdY7IC51fcNVj1t0NLKXOt/r96AwVAirDzBlJGb+0CkPq6Ss?=
 =?us-ascii?Q?e4B0rumQldbzE4ZierRp9wpCzJMp6fJek1T+8AkME56vF5scW9j8reJLEiHW?=
 =?us-ascii?Q?bE1ZBkD2uVJjmo6nCaGhSieDwOoGvj5HQeNewJqwyyRuY3cQFNS6lVgsHg/p?=
 =?us-ascii?Q?HWrP4fIHscFITZ06LiQbNSbS9Q1X+ilRD6bObBD1cRHcwo+k3fim363WR8s2?=
 =?us-ascii?Q?YVfbkQONCPEd4k3Koc2JOSt7+KhxigOWRJFIPhcaYvpH5MvyBneAkAeKsmiD?=
 =?us-ascii?Q?9xVStXG4o6/79rELU0z8ptvDHCekBf7OoQrU0JT73p0u9IFIzkudXDo+tg0G?=
 =?us-ascii?Q?qMAWrYwsCWBJUgvoj510xbWFZXyIlH8ts9xEkwpuJhOWUrjlvR8KhTtqtzW3?=
 =?us-ascii?Q?BMbngcimBBh8NosUAHn0k91sqQr/x9JUYEH5CFhNpDl041OXObjvmp6NV0bZ?=
 =?us-ascii?Q?HCPmdYyLHzO3jwpqTEThxuf7sWx4pHGBBcT2/5uaYS1k38BerzAHM41figbx?=
 =?us-ascii?Q?r8oRKr5AsX5XHMpj8SkTxPuzqjOkqt+elsWhYfYf+0ZxXi/ofTTEhyqSSgV6?=
 =?us-ascii?Q?HYNASJQVLsB211bDAfh55lcD4VCOcZAiZ3zynDtiJuMWxVqlDLYDTHaxvoRi?=
 =?us-ascii?Q?I4BWS2UbBx66bLjqYVohs7PxWWe0Hyj/mXXyETlEEZeEtwEbbC7RoQ3XL1Bx?=
 =?us-ascii?Q?wW0xyedLZWWR71uh7sdOfxMNZWOAuZ3l8LY7oDgBSnss5OMbPrBztExJJhfn?=
 =?us-ascii?Q?1ow6XAD2EARqNOoJggFRH/+BDyIm15QSEZ5iLnHpFYTkWkAvOHTrQVIwGMbH?=
 =?us-ascii?Q?yA1Vk+EgtvrsVaaNobwji4waqcD+M0PDmbFfstYhvcveQM9UHX1DhRKDBziO?=
 =?us-ascii?Q?clOTVZn/rbQ4wUoixvhUmcZEFIeq/YQ1ld9IHiR/cZxPkPKsIHNMX9jNAQm4?=
 =?us-ascii?Q?LhSGSVRwGwfDoj/cTjdhhGWfuwZq5xc2VA+7BNaoAnPmZQ7x0F0mxLV1C92f?=
 =?us-ascii?Q?yhQb/jxUeIP1uvBjY1UWRS7/M7fF0pohCORJuLsWBeOPyCKFaAxGIuwrfwa0?=
 =?us-ascii?Q?JhOMBa7ro2d2MgazMcosYhdp3o7n9CXrZuKb6rr3OU634QvzG5Vt9MVbBZ+O?=
 =?us-ascii?Q?2Pknco+EThyoEqiWNUSRk8kudIXNDcn6kU708E8qvixm0pTdgm5dejEIROUn?=
 =?us-ascii?Q?dGyFL+vPXFPCShAkg3tMr2iJtWh2QETi+96JU0uvIAj2c1h49fUQLx3oA7P2?=
 =?us-ascii?Q?tHxYAWpheA5eW0skO/dgo2t6+sjOQVFFrOWWz2aB41Rj8xwBSW/+29syoUsw?=
 =?us-ascii?Q?FDWIILRdppJ7wGI7/WjASaDnEjuXLC8yx3xyaHz/69WM8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dhfp+G7rw2hMODpPi/78Nn5qZsUf3UWLwfFIF3fseGcWLFzaIuaOi61N2h9j?=
 =?us-ascii?Q?RW3OEezwKKYTMCOspwtp90tjg6oZmnQv/Oj4mqUNEdfVBhQtq9yGvL+DvuSO?=
 =?us-ascii?Q?5Bq0KG9vyOm6JoU/cl3ECHyuRgyKsJNjqJES+PYi9ivRYe+PmSgpFWzmF9FV?=
 =?us-ascii?Q?lKhaKo/CfccnM4Bo3psj1EQN6NtPkWP8IpmnpX3Ht1e1JvE+mJLLhlXzCcvf?=
 =?us-ascii?Q?8BWQHQ7ppy1r8Dhpha475Km1jSw96zVT2RlxT5SFu7HF2maGD0RXg2grol8N?=
 =?us-ascii?Q?aY/uf7593VnbQ1EPuotf4L2VmrhO2MEguHW7GYYLFynW0MBUdFcB64oMPV67?=
 =?us-ascii?Q?tInMBNoh90F1nKeL/Drc01rACOwwINnwplFrTKC0CugR1JlUE1eDBbq9yQpL?=
 =?us-ascii?Q?ZynK8htXHIA5h43MO1HGNczuL+p845huUeUNf6siNWzAwjrPGiCT4lf6QftA?=
 =?us-ascii?Q?0D1gegNQB7M/gzjJsSu1YwT87frhIk5NMv0U4l1IavXNevgTrbAg/kGDHTXS?=
 =?us-ascii?Q?gZNIg8cvtkfQzc8Ot7OXZMYnwsQGBFrwWOCSiRyoSz1/XcFOQkda3nENsd8J?=
 =?us-ascii?Q?VGelBgUC9ZBoVgbQ+47mBOkYySq+h+8SmjgvtkvaKgueIzMrGtDpQmr+6pRa?=
 =?us-ascii?Q?b46TbdoZJ6JIyahRta7Q1vUdc0CDkEviYz63KVNHTZKzXZA/+q/4B4m3mSW7?=
 =?us-ascii?Q?LglZ5NBhC4qf7ai/PjhddHf1YoXYb4HpOzpFKuBXDaxeWDsK4g40jisL7i9d?=
 =?us-ascii?Q?zAMKbetHUyrivUvrL7aBbHGMB5UTabQu2wZOVpcIPIN70dodAiyX4gLIFMsi?=
 =?us-ascii?Q?AzXJj8HTXZ7E2ymGExIDhf3CStEwpGEkVT8mPPV7Vx0XzW+1XLLZhJw6oOZI?=
 =?us-ascii?Q?emgFLwvZkl1HYJ1y9QdpvlsmqXP+TH/1GE0+2QegxLikEaqJKPQwDxmWOgLc?=
 =?us-ascii?Q?Tc4Qpe0iFSh5gRVWzaWA9a9+xo92Rfc+tmMIFydHSdd75PVzQQjQbSPWSIqu?=
 =?us-ascii?Q?tVKP91FqsMx6YdswPoppzFvqZqYjua+W0w1/Tg4BNMd0OHEHHIlPnA7zi1vM?=
 =?us-ascii?Q?HP4DwoPng+1+d/JluUFWLFwvr2THut29Xyj6pBRBbvvowSGJGLMwn8WqXgG2?=
 =?us-ascii?Q?Cdu7VZqY9QopQKAgZB+b/yIchPy9bR+8i8L76fo6oOfQNcox6ERvXWLM/kF5?=
 =?us-ascii?Q?J8jri+MFc7RICeisEnyqBDFjxiEtNJO3zYdP5dGnESzIava/dX54tO+rBL7H?=
 =?us-ascii?Q?eh7auqzguG61eaWAdFxC9f/eSmT3mBhlgmp5iGbuOMxIWzDx3bNgU3hPA4Sn?=
 =?us-ascii?Q?NZBrSBpv4UanfhrIxnt5lBB3+S1p3ozwWm3I6i1qIwMUplfJ/nyHD48rBQH0?=
 =?us-ascii?Q?FrREjt9BYIGDp9+BH5V+//+Jy3J3XFntfyCPrsugunR7S/848mrWNlgEnpny?=
 =?us-ascii?Q?sR45oX1jy4f3Y/nCnRZ3GeLCoLT759O+ZJDtGGAZZMgjDZt645bj4XLGdCVl?=
 =?us-ascii?Q?6nZpP4BXwo1dBpPmPRFNBIfUTZrsdXbxiO8oC/H5ERnioTLpHmZTshuYxQIh?=
 =?us-ascii?Q?LIpWv7BPEIn1QpjVR4l7sTyyT8FK/WOxS7fM/OYr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c099fa30-8806-4a9b-a4f5-08dc6467f81a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:08:08.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /E0htAGBbVdaD1qceMRoXPvGUOAOfXykcpEQ8jldWomp5cSUD/A4Zu++DpM3rAR6LpvLvxODcyurozYZaRYDCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

By moving the bap_data initialization for a scanned device to
bap_adapter_probe() the adapter field of bap_data will already be set when
short_lived_pa_sync is called. When adapter will be changed for
bap_adapter, this will help eliminate an additional queue search (in
short_lived_pa_sync).
---
 profiles/audio/bap.c | 62 ++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ff6d6d881..9e93906ca 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2768,43 +2768,13 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
 {
 	struct btd_service *service = req->data.service;
-	struct btd_device *device = btd_service_get_device(service);
-	struct btd_adapter *adapter = device_get_adapter(device);
-	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	GError *err = NULL;
 
-	if (data) {
+	if (data->listen_io) {
 		DBG("Already probed");
 		return -1;
 	}
-	data = bap_data_new(device);
-	data->service = service;
-	data->adapter = adapter;
-	data->device = device;
-	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
-			btd_gatt_database_get_db(database));
-	if (!data->bap) {
-		error("Unable to create BAP instance");
-		free(data);
-		return -EINVAL;
-	}
-
-	if (!bt_bap_attach(data->bap, NULL)) {
-		error("BAP unable to attach");
-		return -EINVAL;
-	}
-
-	bap_data_add(data);
-
-	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
-								NULL);
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
-					bap_connecting_bcast, data, NULL);
-	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
-				pac_removed_broadcast, data, NULL);
-
-	bt_bap_set_user_data(data->bap, service);
 
 	DBG("Create PA sync with this source");
 	req->in_progress = TRUE;
@@ -2925,14 +2895,44 @@ static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
+	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_bcast_pa_req *pa_req =
 			new0(struct bap_bcast_pa_req, 1);
+	struct bap_data *data;
 
 	if (!btd_adapter_has_exp_feature(adapter, EXP_FEAT_ISO_SOCKET)) {
 		error("BAP requires ISO Socket which is not enabled");
 		return -ENOTSUP;
 	}
 
+	data = bap_data_new(device);
+	data->service = service;
+	data->adapter = adapter;
+	data->device = device;
+	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
+			btd_gatt_database_get_db(database));
+	if (!data->bap) {
+		error("Unable to create BAP instance");
+		free(data);
+		return -EINVAL;
+	}
+
+	if (!bt_bap_attach(data->bap, NULL)) {
+		error("BAP unable to attach");
+		return -EINVAL;
+	}
+
+	bap_data_add(data);
+
+	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
+								NULL);
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+					bap_connecting_bcast, data, NULL);
+	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
+				pac_removed_broadcast, data, NULL);
+
+	bt_bap_set_user_data(data->bap, service);
+
 	/* First time initialize the queue and start the idle timer */
 	if (bcast_pa_requests == NULL) {
 		bcast_pa_requests = queue_new();
-- 
2.40.1

