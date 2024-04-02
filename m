Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2114.outbound.protection.outlook.com [40.107.8.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B65133401
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712073008; cv=fail; b=YoT/czwVch8SJ1x7JiSBC2Gbqmd9rbzulAmK5GxgtLB0iz5CPG+7GOqeZL6Xy0pYsd4mNdTEGIzjStg9al+oVieB7ZlHWd6xDz9Cl2FdDIUo8lkYOBcvAPy4JI1Vai0kIqk9h2rLALKs8PHvPJauOVWYSPFxI+vFQZlqnGiDCMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712073008; c=relaxed/simple;
	bh=swDMMHmTaGxHO1IemxQ4ipJWjGBLe/Puml12kK4CfKo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TmpNMKqkjdWrTs85ODw3TyTFtv+kmJ9aSFlAOnP41lATU/tg3xUJvKtJpYAAw/SEQtzaAiARV3e5A6ft9u8wOQufi5Zh9JdxiaFVJxAyKiLtDXp8irn3Nfv5NzloECld0CMmxCsQzYqlzq6aFAeTpwY5tBKRKZTP6d7rYBW1Ka4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=K/Eg5m4N; arc=fail smtp.client-ip=40.107.8.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="K/Eg5m4N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PBz543wUj84nZjKagVqUKprCQK/u2wkpU0ynwCPAz3P95vSNCam4LYqRBS3JX3f4v4XIofJNb2sS7b/rqwvsD15iJfzuVyxZAokg2AhHeHiaUKwPxY1Tjsp2U/KRfbHU+WamoEtWix3X62qHPNO/b48cV/58lB5WrSSZ3CPm68nUEFBk+5357DuV07VDaH3cHybAsT7U9mtxq61LhW9oSbgT2XdvrfjUxxIKiXXK/aNWlKFxuO+Beu237fTiwd4O5H+VyxNrWvOoR42RH8t0I9JzPV5h27Xu15piOx/ZbG5W4ipSvQibDm8PD+HhuWkyxxJCe9Zzkbrb8MTuZ7Awjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gN8P41+A1llq0zoqkXi+RtLEhXcLdm1inuMfXyu69OI=;
 b=M3TXZaO2J48Y4aoRJrVy6zdPNffii1L2e59l3+Y/jv67VEhjnr1NDjw5iBQBFqBfj5DDFBMPMkzWZW/XRc81DiwnCrbGH4vums0S+BrhYZCYGtlKwQK+IoAjV3ERCKbJ1uwyCV0LKiunAItgtEIGDjGOx9qRWmF5ZQThlHy6nsFkWkyjzDCLj9i/yevhlJ5zDGIOepuKJ4j6ng6udn1oZ6jgFxCfX0PUMuWEqE8ClFQmAfcTESd3bg1rW1RiKpW/Xp+hljkEPoxkPqgSQgBdGv73ZJTG70iurb14vHob36B4F6B6awBCXFO5OMr8gpgZExHp6HT4JxkU303gXsmIlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gN8P41+A1llq0zoqkXi+RtLEhXcLdm1inuMfXyu69OI=;
 b=K/Eg5m4N7BhMh5TTdS5jvFM6ZfZFngBkKAWmUWqBfkYRWHY2qrHym5htCjv/RQ8ORa575U+m2mMQUSj74K+U0YlPsMw4EGWCveWt2NsP+1dz/O8OdoOsP0ndPOlPJ7zgqMYqasVWzWiYhJ2xCeiEU2ZZ7z/IOJs80rnwfed5ZSE=
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by GV1PR04MB9198.eurprd04.prod.outlook.com (2603:10a6:150:29::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 15:50:01 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 15:50:01 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 1/1] bap: Fix endpoint unregister for BAP broadcast source
Date: Tue,  2 Apr 2024 18:49:55 +0300
Message-Id: <20240402154955.45229-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240402154955.45229-1-silviu.barbulescu@nxp.com>
References: <20240402154955.45229-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0002.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|GV1PR04MB9198:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B1y2REVBZIFrN/LKiXRrKaG2wa4kgA84/oVTxIWwLLQY870/lemjEdDqTerJC0jFZNNV5t0QH9V0YtdXWSyEFlX3WU7Q9vr+QOifW67bS2sr2E/Yo6HjWXpIForSWudunCpQXp2naHjDDOyak3alRvvM5bnyx7yTJlASqV5t4XPqi8VpEEcEA4t5w01V+4Iuo7oTv4fl59jMY7Zk5WfwHxDx2Tw6rWo5s6ekW76CzdJ32vqxPtW5YqLYoQVYyVn9WcwJ46S1Hcl+3jhO5WfEG+qnwNHIfV/Xq5t2IXF2JhBktJvoFzUafD42F8xVRgXD9y509uYWl1Sc3YA5KKV9WPlX0ThliAAUB+YrwoW7GPccelkudLIlBA9B23/icmEhb5exXee7yI3rxaU/TgykQJyzL5713RtwUGhCEdFGToFrULrrTGSjJqnpicUy16V/D21Sz35STmjXaE+Res/A+CvaBnQ3jSOIqbhL8erShNBW7Ywexwfo1uqPaxoc7KooiaXYoDLdTF7gnr/CYm0OKIuji9VNLdWOoKa9c5Sjj7KdTD/QjcIH4gf+rp98bJaYDKMHc/3BqPQ9rle27OUylzpxr1/Ey2l+Z2/NKdFtCqr8mWaR6HqJYiEjEniDvDhAGmkdgPoSm9eBNapDtj9GfNxbbYRUCWKp7+R+5zcWaGc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WVzTpS6QOXv/Hb4cs25ifzARbPYWjI48qVRVVGEb1aRQRW9QEMfnkULLzALD?=
 =?us-ascii?Q?IZkyg+NGIVMjvEDDPT5vdbrECGkx49FQ6a6v2okTr2a3Epe155Wi1oWBPUuq?=
 =?us-ascii?Q?NP6iLw8BpTsOz+Ftj13y5FttsQd/mvnleJQqBNyZIe5uC/DXHU6rt/s1dfg9?=
 =?us-ascii?Q?1RgJq6S5oULcS3rJKPyan+cJzVEhOISYzfMuVbcHg8zLz9/Qz+Fg+MhgBLMs?=
 =?us-ascii?Q?k9jl3IIhPx98WUDroQy+BMuiEbotGoS8l9+kHgThPA1qZZhKJKbSPnvu06wX?=
 =?us-ascii?Q?4el/B5somfHkPzAgSYkjHnsvoq4gQW9pEhlJnuOYOzmYQLFL0CbnB+SBWVuy?=
 =?us-ascii?Q?ZlHFQ9KK5fzOXG3upw33L3R4fJn/AtBX+WKHvsUwsNEpwyYsuIWtLxW3QAVk?=
 =?us-ascii?Q?+z7sAw7q3inIVGxVzDY1gdfm3k+q/9336aCr9ySTZK0ZdbPE3vQaQNEC+Br9?=
 =?us-ascii?Q?onFeJMa4EDvbJp0IWEyP6BE+DtLbhMG78nEmxE/uw2B8y02MDs90ByLEGGfA?=
 =?us-ascii?Q?SBIStgC9pJNVm/lwfCaWRs9TUIAb9HFf3pms5/0jlrsz8Sz6NLlF9ZHCV6dV?=
 =?us-ascii?Q?6wmGdeaCjymwyzE9XhntZy/uppSdFJZ+nh5O5Qng54wPV/gr5H6kqTFjUSTl?=
 =?us-ascii?Q?QFIsmewNzTQIyUneMJ5v/xqa4cpbQcUKJgC0K+n4HmueSbBeO1qR8fNnh0kw?=
 =?us-ascii?Q?G1urk4V6PlYydpqn26fuGudO8pM9Tc1QDKJFL3a0li0MBu/FvbDzOa3bfVAe?=
 =?us-ascii?Q?vX4fX4ZDT1bB35Sgh5EEYiAtdnB7IgIauPmNwnUD5Ia/CbqZzOCLCF6Czf5e?=
 =?us-ascii?Q?tNc0Sz3XIbwswzs1c7G3V+c5fpZXz5y0R0sWV6PpSa75NXdWCY0cvuYEMuX9?=
 =?us-ascii?Q?iUmIh4F773NE9rNXRLBTzx9v9tw9ABNcJg+gkYc8lADH4AYI8ihw1KUzAhy8?=
 =?us-ascii?Q?lXChf9y1cvgGTpuDnoHcN7tJIRZx70Y05HFfuiXN3IxCWRhm2u6gG19dbMlt?=
 =?us-ascii?Q?hODSFU5MX4wyPnUQwfCe1+457jQJbjD9f9bCswFQrni00LIpIFT0jx1Gye/y?=
 =?us-ascii?Q?ya9w6w3S9VJo805yzfZmOuQxNwmbU6NlSONqVhVmV4bomlcHb2VGqnb0MMM2?=
 =?us-ascii?Q?6zTTJ79BYP7WWBdfmnLmHvEYAoPmwCekqK+5f9oTIdaiuGDGIgwyyIWmG5R6?=
 =?us-ascii?Q?14XdreeP4JYB+HNYtdOoSPOoYMAGHGoECwt4xRybOrVSp3lbK1WQhJmcfJHd?=
 =?us-ascii?Q?rZa/jxaT7O+bGisNVf+PQ1SFc2Fxi2urLleoi4D69G5Tr8YPZvHRZBRa3OBy?=
 =?us-ascii?Q?iIUcYnXOOBCM2QG3xYqU0ijAlCZvrW8t65O6QeQ7PTNFHZt8EPGaxebBV1v5?=
 =?us-ascii?Q?davBzg6wIYK2Xwr37igLPY3Q5lJzkbgCpBchuzzw0LWenszb0MjWmVkB7NnQ?=
 =?us-ascii?Q?9d2iuIUGBKeG0YMuZVkJbOHagIDK/yChLXaykeAo//FCuEMOiuAGRIOxlDXb?=
 =?us-ascii?Q?9KT5VDSRnOGpOLIiqDdyB0YvVu2aCENbN1qezyQl7v69OgrlnRABDiMWBtbm?=
 =?us-ascii?Q?XhRuFJouXxAFaxDnWV4ibMbQWXIj5UjLmv1HMpjmRT9vCJ4QMGo4QW7wCF+R?=
 =?us-ascii?Q?iQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 805bbda7-451b-4630-2244-08dc532c8e2e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 15:50:01.0152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ubSpcy96Ri659fQJZdA9wwp5qQmPPUu0qfU5g0fc9aTfAR7TWcQK7EbnUBeOFZklN7obHM3zuHvxcpXoNDrWaLEYsfNhfmkifRAwgQcdZk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9198

Fix endpoint not being removed when endpoint unregister
 is called for BAP broadcast source

---
 profiles/audio/bap.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 52a9f5e00..db0af7e7c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -2490,15 +2490,12 @@ static void pac_removed(struct bt_bap_pac *pac, void *user_data)
 
 static void pac_removed_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
-	struct btd_service *service = user_data;
-	struct bap_data *data;
+	struct bap_data *data = user_data;
 	struct queue *queue;
 	struct bap_ep *ep;
 
 	DBG("pac %p", pac);
 
-	data = btd_service_get_user_data(service);
-
 	switch (bt_bap_pac_get_type(pac)) {
 	case BT_BAP_SINK:
 		queue = data->srcs;
-- 
2.40.1

