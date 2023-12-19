Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B575E18629
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Dec 2023 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FliUPHrq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoX9pak3aDC0s2av7ATFI3aB7fsQYHJj/8hkP6utDoKRGgYQ7ziMhWFyus5UUWC3LecdMS4rfVjnbcp5nLYRIMqtHrpneacBGG9LTM/ejZVYRVAfER9Yp1ij/Lm+LLXs5Qv19tQbROE5ZGqGR5mPFiHWK5GsDafbSys+/J/AeOi5Qcrx4xWgjblk8OsgvJUtmg+SqRsMBrWjhBuhpQ08pGaZPHP6KXGiJFXLk+peuzH0yhKGurCabWjmv3QOv7efk/pIjw24ycaSCZxkmDYGtQBHXjJRccnQ/yGcfCXToiNtOXhXlOfrwo7WliwM4mIk7WOL2rq+/mi70yeB585beg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVBHxrSbQzCp8ALuJzyoQ+D5hThsVt0OWQvTc5mEgPg=;
 b=m97xnZGg/OGclIuHYb0+/Vcb0vDJRIRHSb73UFmXTe3driDsubt/oKm5qi+LbRkgN/Qf/9bLbKLiazOGPd2k4f23obIDf1vCPwmd5Xd6H4YqPiA2M9tU415Ao0Iho8nE8mRT+qWUolbz7a0Kl+IrJg4oua0+iKDABTs1qenUb03i8wk1NqfQtZJ1RHVHLTWm4To724vuPcsrjBm35/5/lT+Y8MaK7YvixXzltcBJocDEQedGcsEiS0hc5PL7f7rm2yDnvDWTSBRKUHBo+l1O0Cs89RjzBC2jkXLl31wnm6G+Kzsn/OIdOrF1CWyAowq9tew0wAfQswabk2l46mzAyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVBHxrSbQzCp8ALuJzyoQ+D5hThsVt0OWQvTc5mEgPg=;
 b=FliUPHrqHUtTBy4T7CSSRpZYseBzyu/XacU0v6a14Y/iHjzT6oWQmcNfltg60WBIcx1N5fVOcDWQvGsBHwHO0UUfLGJkaVwNkwbioP6voPt/n7lo7fZwnMuIgCibz+a2qVGV0SXuJo49eUPcHCPcWNq0oFjuNDUEc26rWrvGWa4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com (2603:10a6:803:62::21)
 by AM7PR04MB7110.eurprd04.prod.outlook.com (2603:10a6:20b:119::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38; Tue, 19 Dec
 2023 12:49:48 +0000
Received: from VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280]) by VI1PR04MB5214.eurprd04.prod.outlook.com
 ([fe80::396c:f971:9798:7280%5]) with mapi id 15.20.7091.034; Tue, 19 Dec 2023
 12:49:48 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 1/1] transport: Check if transport is bcast before it's cast to bap_transport
Date: Tue, 19 Dec 2023 14:49:16 +0200
Message-Id: <20231219124916.44173-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219124916.44173-1-vlad.pruteanu@nxp.com>
References: <20231219124916.44173-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZRAP278CA0010.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:10::20) To VI1PR04MB5214.eurprd04.prod.outlook.com
 (2603:10a6:803:62::21)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5214:EE_|AM7PR04MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f991a21-dde6-402a-0a5a-08dc0090fc39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Y8Cx1/5NJjY+Y6mrlo/8ZXXRgqG70kO71m10PZadlorTEViiTq8ic4JYeXGfGty0wPBUs5Suxr7bTohQpgsc8+mISR3aw6DhtKwO7ZXZd33my9Cc92LyPsA83MJYkbn+RKAF+u/lIamCd+3akKcJsNUXxP47RMRa84AAtF/gRXYdPfkc4nAslyLDHhdi+imbrjLhntHwyp5u0NUQ76IcnRNZN+oMs/KpPnlPSE6HpWEjaE8pFHU9GBQN8nV7Mtgb6Tt8d9bLw2/J1dCvVcDIwlr/NptkS5t0WErStbXZmHCmNOGnPeANkiOtzS9ciKU4ifi+/UtO/xO8hz+AEkzoCwB1qlelNwOzcT/vrirtJzACBPf01z7Pj4hNzBmquSje+EpnE1uJoMyX/U6NTZSX3ppv2Om+u1oapM8Mn5v/fKrsLpJMymUcHEM47DutLPkONWWFtIKLaw+Y6IG3VhDMqEeg/ti1YUj2aoEQ+bdsA9VdMM71f5LRzu1a9EyPWy3co+VEpAQMXNJBP86hW8ZwaitTDQdHscXFY4qmQtmtNGMTuK7tAVK69UbROEqff4D8m5eFVIl8NfnHuEhyT3nx7NMBsYm0uknmrT1UZGftLI5iEQJMTL1V9TB50ZRaEJA4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5214.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(346002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(8676002)(8936002)(4326008)(86362001)(316002)(44832011)(6486002)(478600001)(66556008)(66476007)(66946007)(6916009)(41300700001)(2616005)(38350700005)(36756003)(5660300002)(38100700002)(2906002)(6512007)(26005)(1076003)(52116002)(6666004)(6506007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HqSKz7h8okUY4d4DR/63os7kPhHWGRxp/+R59JyR9aJ/3NEz5fCG0GWroRPO?=
 =?us-ascii?Q?YbCQIN3jOPymgP9PrPjbISEsWnVloI4e9AlvFznEqw2wQ+hboVPJkCr5GgA4?=
 =?us-ascii?Q?rnzOEK6GqGYT5TmgQVNC5qRxYSFD2G5++a2mqkYNPbM1eFU2Mmf+b3TF5353?=
 =?us-ascii?Q?R+qImOgR4U0MQi4Sii7D5Zgj+Bn8Z7g783JnhkXdKGuFWZcHS83P/YE5bJS4?=
 =?us-ascii?Q?wijacOILmZTGhwFRzCcc6DPsuyRFzEw6yv9kJiw0vlizYR3DXKvi1aKvprGs?=
 =?us-ascii?Q?RByr8IpnZKPeWS/blR3zE9vi83nVlE5OjI4zHCL/mecqeg8n7RjIkHhHjEXa?=
 =?us-ascii?Q?1vjUQXdfgKEmpH427eD0xaK3sOY+NWeNbR+Ewe13YnPihwu8oHF7KNcvVAki?=
 =?us-ascii?Q?cs5vGWnhq6DnrwOg6MXssNyOTd4QBk4OOlQufGFnTZ3Pdyil0zSmqnIRwfpM?=
 =?us-ascii?Q?0+MR30LYFFnuYLnU0yFTTYcM7UF/upYpDtNNwxGb5qTYOK6YAEeXJStsXlr3?=
 =?us-ascii?Q?47/vcaoP8L7aRMqquc83Oy+UrJ/BGHvn6+eQTDizh8nv3Xg+gdb5cCU0v0xr?=
 =?us-ascii?Q?EG6k8vVCZFnyTMsh7lkbs37fJPP4deF8Ktg/F9Dpp9G4U3hSxnkxEBmQeNri?=
 =?us-ascii?Q?wroieaRFFghKz2tppV+9I+s7g0OjDuAj4zi4knGJVpeWau8isf/cjVRTtSRq?=
 =?us-ascii?Q?IdBKdWqjZO0iuLDyG3heVeYTwdWa7c9tGidEQhghzDQox9k/Iq2/uMaWzrnD?=
 =?us-ascii?Q?v6oMwLhOFWM4Kj96VB41xg04KrS9vR6ISMVVL/CZ8CznwjtEZtQauveSxhyt?=
 =?us-ascii?Q?ZJJUxt/pTn9Jlvu7uSV/bRCOoqLzgi9uwP+2XpnaGVmhH/oJe7zYAc5Ay0Te?=
 =?us-ascii?Q?kGJAfzBw7P3XYdyHNXEs4l51IQFkVGa37J17pClLdJsr6CbD5jW6HhbGz6OF?=
 =?us-ascii?Q?QcA3GbK4b4wMYJXhM+q3LUl2pOxqG/GpZWCj3cYlRTWPv0ta9T/OpfqDZZD+?=
 =?us-ascii?Q?z/c/vP/ytFBWX5RS7co2/YxzDzo0CFbiMb+cDCFZwSJsNXNzNbIsAMtrt6Kx?=
 =?us-ascii?Q?2lkOoRHYMNyabDPhRSecyiinrZmZ8w1KaHcVo1CtGcRgLGxy1S7EIXvOxPrm?=
 =?us-ascii?Q?eaxHKQPlEdFg6GNZLkYNpGijbVXB8NdZ8Q/LiK0XA3EJmmC3Nd968CZKwnB7?=
 =?us-ascii?Q?gg251tFwhaBBuk34TCnoQ0GeG8iKipZWZcwDtCofmLi9M06xnxXLDjUGaDIe?=
 =?us-ascii?Q?GHM+3jxKaTWKebOu347VbIRoAkAkfZNLBHvbqrpRHQqG6H+UKROOd5xR2OHC?=
 =?us-ascii?Q?NZequJI3x0g4s4ofJLoL8XcWuAKjp+DQzZ5XqSs+QU07lFixrCIUPURRURfP?=
 =?us-ascii?Q?Eqyc+QQXYDTBpp3exqT9ggv8zVM0HYZ9UkKvyiFHEpoE3YZaFCaDtqfT/7BK?=
 =?us-ascii?Q?IGDYHXfd0uuOB38JCh9FDXd+iBAdJTFHbQBCDBkFiMLbejLPU24wg1aaCsiS?=
 =?us-ascii?Q?cMMOCyVlnvEl+NgGbvpATHnHDeSZNYym9xHQ+eeETAZEOBWXCQZ7WVfruCjU?=
 =?us-ascii?Q?fWNuPiKBjVFWs5sFpoSKbMjVmt9k0tOfx4nDn3t2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f991a21-dde6-402a-0a5a-08dc0090fc39
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5214.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 12:49:48.8519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EFRoHeFKNWHQn1Ercv/CVK0QOaybaDIiPMq4KZwkhvCHSB3WbLVVo7jlTDbMJza2L/p4LUU8+qVRiPytaJq/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7110

Currently, when a transport is released it is cast to bap_transport without
checking if the transport is actually a broadcast one. Then, based on this
cast it is released. Problems may occur with transports that are not
broadcast, but are still cast to bap_transport. This commit fixes this
problem.
---
 profiles/audio/transport.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index e2073451c..555da99a8 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -643,7 +643,6 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 {
 	struct media_transport *transport = data;
 	struct media_owner *owner = transport->owner;
-	struct bap_transport *bap = transport->data;
 	const char *sender;
 	struct media_request *req;
 	guint id;
@@ -675,9 +674,17 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	req = media_request_create(msg, id);
 	media_owner_add(owner, req);
 
-	if (bt_bap_stream_get_type(bap->stream) ==
-			BT_BAP_STREAM_TYPE_BCAST) {
-		bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+					BAA_SERVICE_UUID)
+		|| !strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BCAA_SERVICE_UUID)) {
+
+		struct bap_transport *bap = transport->data;
+
+		if (bt_bap_stream_get_type(bap->stream) ==
+				BT_BAP_STREAM_TYPE_BCAST) {
+			bap_disable_complete(bap->stream, 0x00, 0x00, owner);
+		}
 	}
 
 	return NULL;
-- 
2.39.2

