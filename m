Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="foYNBptZ"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2050.outbound.protection.outlook.com [40.107.15.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF34D41
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Nov 2023 07:10:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0LNe5H63kqN+HLmmbdJYVtuZHA6tF+scK1HHi40lUReB+DA7bGWz4RWaaJfEm9GrdyEs4eOlpBkJFczagmo1XSrlG/fuAsVwiIMKS6bBo/viQPmfJWiEXrnr3GnApHhisLHBMB4V6ApqbPtFyWXFhQAlyP5ijhDI6FDflRbT+0j6/VWnyb6sxVK+dSU6IB2Pd5wposhuOQvtFBLuXQ2Nh6EBqcYenGWNMpVoxbXBmP817kJZif8ztXYtWzceefGqrxpGr5EYnv3lxj2togf5BY3tDqjmmmU9uWxgNFatQ09KBibKFwwQLA1c4aMZ724A2BDezqGEC8gV8wGbTkwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LaTFKUHmkhlZhwaP6k/DHvxuC8v64MOV7GuieLs7WPU=;
 b=dF7HK2oBtiN/Db4Z5Jk00UlE9bZoDM62GfPjdZidIdD6aOAk6fLqvQZ2OYployTG3xXUzNLqjCUwJHYVz5hE+GKTq/85EQq6tJwW8HDbpDna9S5sE7nWr8GQNIyWSy0DTBjeYC3eEtUy/jJXK4qFC4etjEofTq1M/zfQTgbee/dHmNLxhGUsbq8zBU6DKG1MhTYJg2AE3L29Qi8JssIC0FCZpjcYIivnxRX19nc70MPnR6zOO83let+FJId+XCyDLDmckRdWvBeIz7aRf38Wsttuk1nWSO2lup0esfH1s2pPAriGGJYZOt/8UYopYooa8L8UyB3n6DcX8claVGn7ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaTFKUHmkhlZhwaP6k/DHvxuC8v64MOV7GuieLs7WPU=;
 b=foYNBptZJ+FeSSIpRNjCxr7D8/1dq57VBmwmoC6Qt0GQvpxfzuS/P3dT4hVX6Xy6+E/cTKxoGwMOrLCHsTumumysun7UB72v+kbnzVYZKts93cmta0GonHpw1vFVTp7q5nknTHEBqvt8L59AltnDoF9ZgEtPE51EJnoTqXa7QQo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6928.eurprd04.prod.outlook.com (2603:10a6:803:12e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 15:10:43 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c38d:98a0:a823:d88a%6]) with mapi id 15.20.7046.012; Thu, 23 Nov 2023
 15:10:43 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v5 2/5] audio/bap: Fix source+sink endpoint registration
Date: Thu, 23 Nov 2023 17:10:30 +0200
Message-Id: <20231123151033.22898-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
References: <20231123151033.22898-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0157.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::26) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a146a66-0610-4b6b-6fe9-08dbec365c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QtcrW8URn98H1qZ+Q4SpWGZGfic7zD9zSCYSpVFnWjaQ4xEN5WP2ygDPURQYZY8UenlZAQBUsS+F+GEMwhpZ98OUYsdn80NSvVitfpeQWWIALurvtGkuYruZgf7pSKNbqgZn29T0rkdR0ZVRi93brIqTCvVe51PS/m5t+6bn9SEXJ7sQ5cZXLySOa6aprrPz7KBcU+BnWzh0lZGZkel+D/3JIoBV6+ngXSO7V39jNhoIRVz0r2bETVyyB63Xgjs4b7wtqeGPPdXuKo41RQCHZs2H813Tn1fzAXjum6+QgLY0HOmaRPo1IPjwpohr2RFGaLyKqiKiJjE0aBypXfLg9unnoxmVcWkqkWn0GXoiF8tXUZEX5IpnONH97JaF5i6qREelAvIDt5n8lKModtS42ZjNJUNnpQEl6vDdM3CbYwawci0sBOV9Lvj67n6CVzRupQtzHrSCiJPvXs3mfyOLL4xAeZ9JAQ+OUMdqfEz2fAdLNfqt576eLwEEWedPlmVtBkuf9OnktR/a+SQ0GrQv0JiItTLZNwdEmVm8Od0upvFH0EdKjyMcowfxx9xiovxc0X31GKBH4ryB34dPjpZAVIHexqbTNfuPZ9Qj1SYaZqY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(2616005)(6512007)(6506007)(26005)(6486002)(1076003)(2013699003)(8676002)(8936002)(2906002)(5660300002)(36756003)(4326008)(41300700001)(66556008)(86362001)(66476007)(66946007)(316002)(6916009)(478600001)(6666004)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Trd2JPQUap4LTIQWQIKo3SdWjcXNXdS4LNMkR9tL54+9k5mDRZKh3IHqdfzb?=
 =?us-ascii?Q?fB04ws7zTFqKCcYVU+Vio5mevu5FDDE/Kv/zNJusPO70L+7X3TWUHySHO3PH?=
 =?us-ascii?Q?n63e5ZSd9kMVbh+vSYoMDo505I/bZEMdIdy/62IskFIPsajpPE/bdAa/ELDK?=
 =?us-ascii?Q?hlUAphvuYExTq4UITcsRXQICttSxMWfqFkpEc/J1jXX3f2lyBiCkGSQUbQIK?=
 =?us-ascii?Q?IsOrMmBT8qKEorYkbR7xRKDpu30TEMJ56Uty1c04W2wWwdVZSMnqaZ1JwDd3?=
 =?us-ascii?Q?AmCbmDmwDmB8d437yzCy+/brZfFWa1lv6c14pS74x0+LceG59beHLxNfekvv?=
 =?us-ascii?Q?5l1LDsID3s1z1/m3nIfrxTCM66UYmjEwwKMmsuwPjIqE3AGpnr74yMzSPHbQ?=
 =?us-ascii?Q?4Dg/CeTXXUTyEOFaJtL+ALHymKdXfjAV8qLIsW9P2iRkTwU97kKOJg9lu15J?=
 =?us-ascii?Q?Tmbo4QURDqy+pvzPS80eYyX4H6BVR7GAJsxfHHtmnFBH19Z5QnKJ20Byy21r?=
 =?us-ascii?Q?ZE/kE8xnG1GB3v6YFAJnSfWrmC0YwqZi6AB9fhKXKZsKZyIFCY8nV+Ih4cn8?=
 =?us-ascii?Q?j8tzMKgQ6DMXglyoJVcuwfVKEtsE+SVK5rh0U0c6zw6ijzoE+Hk/br19drN7?=
 =?us-ascii?Q?mNpcXtvtGe6x67dUFEJFUXuASJa6WqeXlJN9ue+c+NedIcejWgxLEuI9159t?=
 =?us-ascii?Q?E8Bqcw6sE+6BcqDjS6+vAjrc1fA5BCiSKIvdc9rSK3plCs8Q5V0Eez6UcQI6?=
 =?us-ascii?Q?ppuomScf8txnDYkj0MswBbIw6dzaNSKYxzDEzcpZmlsFdzD25yYUeJCLPSWo?=
 =?us-ascii?Q?6FOTnukdAk2SsEMDXUmU750UofTzPP1EoV/md1S2vXcqMP0UjmOHvWU6nXKr?=
 =?us-ascii?Q?VeNOT6e61bRxtoUYcYlMh75AI49nwRcLh02Wh0fJ8vL1j5b6/wPj+hLIdO/h?=
 =?us-ascii?Q?Of62IZdHfmfnkOVUWep1OQM1A/q4dkpERm1qS6SWSX5jkF12iBtM+n4ZiAkL?=
 =?us-ascii?Q?u6ZeTamR4dXMrjofX5h2HkEn3IJk3kJHC72GB7efDx1tIw4wbAXlSi/o2sew?=
 =?us-ascii?Q?KK4R28cSomxoNkN9iG3F8hVII1s46XpQDhccTXzBWqgY7tW/bZYvaCZI57Gj?=
 =?us-ascii?Q?otcnMkAIaTZsFLA6/gMtlDNyAGq3Fn9EtxzGfi3T325u4GeKzXr9DXQ9ZOCJ?=
 =?us-ascii?Q?M6yIoHL8tJFBXymIMV1FpNaZCqdQDVM9tLb9HLqD69tWGekt/i9UPfrFpUW2?=
 =?us-ascii?Q?DOwP2fM9CRPTj8kd/OLqFcAL1qVKNtMHsVOHBbId1uvGrpJKrrxT5uR9bT+u?=
 =?us-ascii?Q?pKTBKUjEEtvqs85LJg4P6YzX7sbtFSa1h5DsfcKqqfWgIQtjz0dt7X8JiAN+?=
 =?us-ascii?Q?N2UVXcFApRWxDKCJ7tnK6lFkih0ZVxACeBZoQqEj3OrPzXfh8WcdqnUPmqE1?=
 =?us-ascii?Q?kjCR3mBG4OxHCU1kYcDAU4j0qq0UFbyVDnh60EY0096qge+YyJfdy6G+aV7D?=
 =?us-ascii?Q?m5lDLudOGhW/U44LQeCmKoqj3wftWPKixZ/oz7pXX+yzwLfgB5rNBwPt8dXN?=
 =?us-ascii?Q?HdcQ/XXO0l0gzo36Wu+k8d06DDW7PYVvRvw+DbO88cw1TC1lm1N7hV76Jvox?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a146a66-0610-4b6b-6fe9-08dbec365c94
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:10:43.0132
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2okkM+g1oLnC1bwQzRFkWS4s4vO+OvqeZdIbwDgtItkXBilyY94lKFuBCn4oeMq9lsyujrWnqtirE2vXJEYT4hfbWDJCQfra+tWPqlNn21Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6928

From: Claudia Draghicescu <claudia.rosu@nxp.com>

When registering both sink and source endpoints,
the register endpoint method call results in 2 remote endpoints for each
scanned broadcast source

---
 profiles/audio/bap.c | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 780dff412..38a860c07 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1050,7 +1050,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	const char *suffix;
 	struct match_ep match = { lpac, rpac };
 
-	switch (bt_bap_pac_get_type(rpac)) {
+	switch (bt_bap_pac_get_type(lpac)) {
 	case BT_BAP_BCAST_SOURCE:
 	case BT_BAP_BCAST_SINK:
 		queue = data->bcast;
@@ -1073,13 +1073,13 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	if (device)
 		ep->data->device = device;
 
-	switch (bt_bap_pac_get_type(rpac)) {
-	case BT_BAP_BCAST_SINK:
+	switch (bt_bap_pac_get_type(lpac)) {
+	case BT_BAP_BCAST_SOURCE:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				adapter_get_path(adapter), suffix, i);
 		ep->base = new0(struct iovec, 1);
 		break;
-	case BT_BAP_BCAST_SOURCE:
+	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
 		ep->base = new0(struct iovec, 1);
@@ -1101,7 +1101,15 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		ep_free(ep);
 		return NULL;
 	}
-	bt_bap_pac_set_user_data(rpac, ep->path);
+
+	/*
+	 * The broadcast source local endpoint has only lpac and broadcast 
+	 * sink local endpoint has a rpac and a lpac
+	 */
+	if (rpac)
+		bt_bap_pac_set_user_data(rpac, ep->path);
+	else
+		bt_bap_pac_set_user_data(lpac, ep->path);
 
 	DBG("ep %p lpac %p rpac %p path %s", ep, ep->lpac, ep->rpac, ep->path);
 
@@ -1792,7 +1800,7 @@ static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 		error("%s", err->message);
 		g_error_free(err);
 	}
-
+	ep->io = io;
 	ep->data->listen_io = io;
 
 }
@@ -1962,12 +1970,18 @@ static void pac_added_broadcast(struct bt_bap_pac *pac, void *user_data)
 {
 	struct bap_data *data = user_data;
 
-	if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SOURCE,
-						pac_found_bcast, data);
-	else if (bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SINK)
-		bt_bap_foreach_pac(data->bap, BT_BAP_BCAST_SINK,
-						pac_found_bcast, data);
+	/*
+	 * If pac type is BT_BAP_BCAST_SOURCE locally create an endpoint
+	 * without a remote pac.
+	 * If pac type is BT_BAP_BCAST_SOURCE and remote then look for a
+	 * local broadcast sink pac locally before creating an endpoint.
+	 */
+	if (bt_bap_pac_bcast_is_local(data->bap, pac) &&
+		(bt_bap_pac_get_type(pac) == BT_BAP_BCAST_SOURCE))
+		pac_found_bcast(pac, NULL, user_data);
+	else
+		bt_bap_foreach_pac(data->bap, bt_bap_pac_get_type(pac),
+					pac_found_bcast, data);
 }
 
 static bool ep_match_pac(const void *data, const void *match_data)
-- 
2.39.2

