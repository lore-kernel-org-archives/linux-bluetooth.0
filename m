Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D3A1B0107
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Aug 2024 12:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935785; cv=fail; b=Iz74L4X0OlEbaSlmexqZ26YST8Ugo7e8AvX7efBTrBsTlMjetSOsjPxy2Xirg/XfoI51bCUPtYmRPab5EDzb41jiwY95aMdUcTtq0QtmjeT6Ycchza/LinJjfMFVpyjxSp7srvj77T2O5lujz1wJ+WNwBmCVb2WdDCoKLRTfp4c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935785; c=relaxed/simple;
	bh=qVwvPqEVtmoByQIKYqZz3r/i4zD018A9/KGme+KSlF4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rCfeQ0JBvESdR+Fb59uYDYkFPULkY+k3TYf3E0haeub+mjmSLZBqpis9GFk74w8HGTUm/A5eJBKt1d0T7tJxVGn0mv9C/WW06sTgxFzGdih1qtJ1Uw3lL2SLOBPuhLPA0sCDmjsyd8LJai8lSi9iZunfbYVh9P8XKZxC9ecqp/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LOjjz2L2; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LOjjz2L2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CsmIZKGUCNd7G+67UvPQRuQr0YH8Z5drI+6DOdf1FTvAy0mHeEAAlg4vhHkefsywaBJQVKS10/V+tY2I+D8nwNenwvexJ1msVHKZtebP7kOz03WPEQOnUScnWSL0IfNUULnLPFh0qzxCknJkAkItq6PzggUHFh4Q28RkRilBuHgFPvcYuahUxfSB0MHyfQtZag3izP2c6fIBNGc3M8EUqHVofRFSdpt8tZYcnvvtjDObSmGmNEzJrlBOd8KfRgGqW5t+vuLQ9rKAPcjReF0lZl7xV6lmKsKBN0dWVtHa5W42Bggwvd+kzkhcr2MIrECBUn2QD9Mq8eeWvLrjO9SYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjRfIlvAnFlE6NSEczbE4Xh26b3Wp/YThy/UvFlIwMs=;
 b=DLQSRp81FE2XkLfbpnpWEzexv3AP4LUxC++NCcu7/cRe+0pZ/tDnkGapbzZTRBESoGCquzAFOhSpL2iAcAlQI5hRpN4L2uV+lTtj5rhHO1+kNJWZNi8qSC9kP/ryjhVANL9c/t+PtHfR82a5OPzJPgv4bGV95j980pD6cdigtFxVBFA3BYdGqhDgl0P4QyNRdd83bMBOpvu8BQ3EWabinu/I91cO4FgEA84MHXqVfKlYsB+YT2P8IKRJWBzwPK70wCnBqf5yOjg9Lq23f153rVNne9KCYoA+2RlIu6GtumGpIZwcNjLIS2hiMGsSaUhCziISFOrBfzseDatISOiDug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjRfIlvAnFlE6NSEczbE4Xh26b3Wp/YThy/UvFlIwMs=;
 b=LOjjz2L2KIDnnIRRCCoeVp0nfhyHUaqInNQutNTn/dtwBp2dsfdTggkILfXsXrxfmYgrPC0ctv0gk0qDRkqVWzJwI7LBgCR1XudbM1d8D32yFgGwDJ/Rc502sBHID+tVXoZzgGNsr+B1I+Ns6AhO2PBrZw2luH/nHzlW+ifcmTI+YLLKCfajEswPTlrTrqP+RivUtoZ8whD2tvs0//ACRNtpWi55DgRelRqyQytVlr0RJ4QYSa8IcknJh4IhFrBZCo0/zWuP4gTC8kO7RCI1IiukDQwK/lIIdQGaToy6IgSTAbUo0wAiEKZ6IfGTScr6lkoRs35VG9OkaT90O9alMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7425.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.27; Thu, 29 Aug
 2024 12:49:40 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7897.027; Thu, 29 Aug 2024
 12:49:39 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 05/16] shared/bass: Call cp handler for the Add Source cmd
Date: Thu, 29 Aug 2024 15:49:07 +0300
Message-Id: <20240829124918.84809-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
References: <20240829124918.84809-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d5::18) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7425:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec72e6b-2d86-4e50-3ecd-08dcc8290be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zsRH2u6nKQGGaij19LWRkZrzFGFx4vB8njjtrgzHiraPa/8r3xe5kAh/JP9Z?=
 =?us-ascii?Q?zKwiCNaqTTaNsyAbWb+XT3NumaQSlSQQWFJuiAgucf6D0Js8VDBpapUtWliL?=
 =?us-ascii?Q?wdwgiciBBhu55Om3xo6BJSmBsHo2p8ZzimHFrargR9BHRMGlTvRDfSJ8pEEc?=
 =?us-ascii?Q?KdjsUm0dpeCoVelNAQNFpUeuvF+ngB7zw4tqOWSjtr2izhcAvvtPpFuqUn3K?=
 =?us-ascii?Q?+RzaCaLxaH1WRSkWTQO6Rg0Mv8qwVF9Fy5kGqMS5f/HZda1ogihVFV7oSIJ1?=
 =?us-ascii?Q?UoBwqmHAGEdWXsCRjnqDItJr4Y3SVrXMxAtRHPFQ2shKZtNB+IMnpfUAdKvu?=
 =?us-ascii?Q?xEf8t4J6MsEXZJKgotIlxi0rrlUWQYhn7DD1D+mwNfhmG/bMS8IsWrIAcMD4?=
 =?us-ascii?Q?AyFgp87q5Tw7ydQ30kuUWy6yVSzvJZuz9oHJLAzwj6S2X5t1OZBtz37mU2H/?=
 =?us-ascii?Q?5mhAP/w/b/ysCp3Qi4LZZ72swmV8wI3FIae1XGvAuTTxf35uQpRQ3XRZGMT0?=
 =?us-ascii?Q?c4f+Y+Rd7Vq2ScKOcagnfmD2LXOoK3e15sXSu0kaUW0TnlLZtgkWg0RiGocl?=
 =?us-ascii?Q?NNg173fKFAnyvy6RSuxyV1snIt6rYlliR1yXCVwcusUpwsB5gM/zvuYNvCBi?=
 =?us-ascii?Q?HhXEbTBFLjL9A3mDyG51CwBFfTIISm9V46W9e5dK5LjTA6SAMLFsLdxozqmf?=
 =?us-ascii?Q?FgXLHOy2JdkBUfxuwdjUQdByDmk4LWIv8VHEm3ErcT320aQQAFkqa6gNLF2C?=
 =?us-ascii?Q?VuO9XqiUS3taYJou6iBW2S66+uSf4AswwLUhTtsBuEGpjqLxp7U/7idrv72T?=
 =?us-ascii?Q?7edYNOhad4/wM65cQn1Q85zrVtk7d1eDomEhXvopOHAE/1uprLdelFc+PJkA?=
 =?us-ascii?Q?v14Qu7RRjusc1EPXPYEb2SKMtKIx+2aLXKgyqrSw3fzNUJtugwzmP1RbtwFp?=
 =?us-ascii?Q?s+z/NcIlw0BQO+7rayfeh4eytMXIMMq/TEFdq8LD2WsWmUvK8ejrlT1GqWd/?=
 =?us-ascii?Q?Lm1JsuRPoZ89OUvkTgKlch1cWIzx6oXcQ85Zn3Ds2scFtlJegNizJQNtIz9n?=
 =?us-ascii?Q?T93PTcv25DjFG0OSXvEYAQfbX532ZPso6ESztOVuBzgZ9F1GJAT+8pHvFKWB?=
 =?us-ascii?Q?iXbw/f/KJn2ZvXK9ji8zF7KzoAO7i0ofVZacait8fBM1+2iiC+m3325gafkN?=
 =?us-ascii?Q?WfcaB6nvE8uQujj7Z8SnIvtN+/8iHfC0RoMSCD4Hi9Y5dYn5jBQNUl6C7Hml?=
 =?us-ascii?Q?U75Qf4L+DZDSO+Zjs2uWKRW3CyKhChxpees3iZhpb/OssAdqg4VQfi99hfhV?=
 =?us-ascii?Q?nUWYSMUt9dTPp+VTb0Iow+t9gprYwqH/SrmTBl7IMeZOug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LJKSOhUHGY4gbyW98VHwjLyCBSvbZrulROsz+Y0r14iL/Esu0MB1EGB/DBiJ?=
 =?us-ascii?Q?OzGWbnw08klCDfs5g/M1MrJzwTcMNKcu4ebG4eYsqUU7BqmKJysUDPABAaAb?=
 =?us-ascii?Q?YV8hKnOz7WJlKZWAqY+h4TwHqa51LW/Rj+HcBZ06jCY7FuUgUUPGBqhIJHET?=
 =?us-ascii?Q?BGPNdDlwf19PUbSAFDlOF7ZQNK8HOZzR7gr1OlBi3Xq02K5tq+RvDyfbBBdW?=
 =?us-ascii?Q?8XBSp0WKXsWheug4ePE1x+f0rne53Jp5nm7AP5tHcW0sU8u/hayM+Erhcl+R?=
 =?us-ascii?Q?K2ygvsZhQncndpENRL+kWkbYqwNw2yZB8GMMfVeEmqy5m8hxxYfssKuD3UhS?=
 =?us-ascii?Q?DRyXAckdUL9kt03HdKprdWFcytUx4cwwoLwCPu1Oo+GVVen4uuIkz+vFage/?=
 =?us-ascii?Q?hrl0s/ltfvgfPNFDrhVBSNKLQcVhZV3+mC0jSPQg98myjJVm9g/wYIw0ZNbE?=
 =?us-ascii?Q?HDySaOMpWvhU8LHPLQC0DfkGbtU6chz7SLviDczMcdFXiHGeGtklkXUOfDmD?=
 =?us-ascii?Q?AUjBZk1duzrzIvhQXw8bzTQcbkF8MzHXK8SMcZwwKRe+8GGyCu/TIG80yNBH?=
 =?us-ascii?Q?ZtecCilYhOnfzyVoYIfmHtVluVVbxXoOsQN/n1HeAZfEYDT5lT6CVRUR/NOz?=
 =?us-ascii?Q?9YoUDRDZglB2cUmD419xxzjeX45MX5hIjHtzPq1eCyjiwrbCHJfrpbNINh+0?=
 =?us-ascii?Q?8YSIJOybzwjZRajNAcpIYVJAi5oJdgBSMBUUxDzt7E2MjqwaOTuO8pmd96Ch?=
 =?us-ascii?Q?Qp+EWfV+nkTd8ZKOuSR8Oq4ZnqXZiuImKSAviQr9GdjA2vhKM5Vmc0BGhkJ3?=
 =?us-ascii?Q?1kur15hXMCQnPJC+Oqbu0aIs5OOwoMyI02FkefhI48H8XF1rEhdtsWv3yxE7?=
 =?us-ascii?Q?K53dt7PTjhjCzE1lT+6wtfCqIuZNa369Rl4DUQ+sSoHmHKc7r9wd/BW9MVHy?=
 =?us-ascii?Q?nz+qYaEMxHR++aqzWQ9T+Pv6ojr/BCGjrI1LEGsG94HHqD4A5qhUyKRWZiQ+?=
 =?us-ascii?Q?MMPrLxp6aLK14LUIyO4FWbdrxhCsD/SM63rUSrtYcPwMLcxfHHiqYGThXy9Y?=
 =?us-ascii?Q?4n6Hu/dF8TahBPWW5kdhcS/rWLf8KPXnTSDG0jfyH98ElWjb+bvgyJkXhW7R?=
 =?us-ascii?Q?LDV294UQCLZA0hRkDHpvrJa9HwYOt9Y0MXV7peOihJlRBJCqUAboDqZ4lVkU?=
 =?us-ascii?Q?ZCw93W1yIajD7kgw9bJa/53Dc6456kI94qh7pFtxdlO2L92JFsSCay+Ekjvb?=
 =?us-ascii?Q?FBitJZWyj4GRD8KvF/MJBDu5aVYoztRM9hQWlNA5WZPN6OOK45YKD1+xcSF2?=
 =?us-ascii?Q?kCdXLcaN2G7t+uRMz184IOEYsp2Qoke3iCoJmaT+Mpz6eg1rD2nj7QY4q8K1?=
 =?us-ascii?Q?Z8uMky05IUrZsS3ksjRtnfoUEYn37hYjUb02Mlv62gs1r2TF7ymjKXE5mPCN?=
 =?us-ascii?Q?fPeSsTQrfbNS02eNkbaP/qgxuKFCO7qzGtl8VkJHK7jyqQSq3gD9L27hdUul?=
 =?us-ascii?Q?teVNTiqUdNiqwcLSJsMi0ba4G6uFNA4frzRjcIYA+n4bDLWfJEaBCHjKWOQi?=
 =?us-ascii?Q?g1hlZ8qYfiHI/kPyMZSyoT5qbb/MpPF5ZWT+eUo11dCxdaEJr9XmUnEgY4n7?=
 =?us-ascii?Q?vw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec72e6b-2d86-4e50-3ecd-08dcc8290be4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 12:49:39.9281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TtnYJAheSpSEGa9RajDNYieItkstldfS2JuueotMouqdUsMUM7hvHuUqw0Gt6oVxpIMtVHkRwEL3IQjiKPFn6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7425

This updates the Add Source control point handler inside shared/bass to
call the handlers queued inside bt_bass, so the required sync operations
will be properly handled by the plugins that registered callbacks.
---
 src/shared/bass.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 635fe1054..70e747700 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -775,6 +775,9 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	struct gatt_db_attribute *attr;
 	uint8_t pa_sync;
 	struct iovec *notif;
+	int ret;
+	const struct queue_entry *entry;
+	struct bt_bass_add_src_params *params;
 
 	gatt_db_attribute_write_result(attrib, id, 0x00);
 
@@ -839,22 +842,25 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 
 	bcast_src->id = src_id;
 
+	params = util_iov_pull_mem(iov, sizeof(*params));
+
 	/* Populate broadcast source fields from command parameters */
-	util_iov_pull_u8(iov, &bcast_src->addr_type);
+	bcast_src->addr_type = params->addr_type;
 
-	bacpy(&bcast_src->addr, (bdaddr_t *)util_iov_pull_mem(iov,
-						sizeof(bdaddr_t)));
+	/* Convert to three-value type */
+	if (bcast_src->addr_type)
+		params->addr_type = BDADDR_LE_RANDOM;
+	else
+		params->addr_type = BDADDR_LE_PUBLIC;
 
-	util_iov_pull_u8(iov, &bcast_src->sid);
-	util_iov_pull_le24(iov, &bcast_src->bid);
+	bacpy(&bcast_src->addr, &params->addr);
+	bcast_src->sid = params->sid;
+	memcpy(&bcast_src->bid, params->bid, sizeof(params->bid));
 
-	util_iov_pull_u8(iov, &pa_sync);
+	pa_sync = params->pa_sync;
 	bcast_src->sync_state = BT_BASS_NOT_SYNCHRONIZED_TO_PA;
 
-	/* TODO: Use the pa_interval field for the sync transfer procedure */
-	util_iov_pull_mem(iov, sizeof(uint16_t));
-
-	util_iov_pull_u8(iov, &bcast_src->num_subgroups);
+	bcast_src->num_subgroups = params->num_subgroups;
 
 	if (!bcast_src->num_subgroups)
 		return;
@@ -886,7 +892,18 @@ static void bass_handle_add_src_op(struct bt_bass *bass,
 	}
 
 	if (pa_sync != PA_SYNC_NO_SYNC) {
-		/* TODO: call BASS plugin callback to establish PA/BIG sync */
+		for (entry = queue_get_entries(bass->cp_handlers); entry;
+							entry = entry->next) {
+			struct bt_bass_cp_handler *cb = entry->data;
+
+			if (cb->handler) {
+				ret = cb->handler(bcast_src,
+						BT_BASS_ADD_SRC,
+						params, cb->data);
+				if (ret)
+					goto err;
+			}
+		}
 	} else {
 		for (int i = 0; i < bcast_src->num_subgroups; i++)
 			bcast_src->subgroup_data[i].bis_sync =
-- 
2.39.2

