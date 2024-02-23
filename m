Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2060.outbound.protection.outlook.com [40.107.241.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD3B1272C5
	for <linux-bluetooth@vger.kernel.org>; Fri, 23 Feb 2024 16:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706903; cv=fail; b=Hlg1qc9NO/uvDP5aDeRyy73k6dleUeskLtlpU5DGJnloZ7zJOphoNiiHu7RTS2asAIwyIALcYnVywLQ/qyM9yyJp+xEUTnvKbdTu+jpE70xU3ACfiCSXTOiYxCb3ShdFDz35U8H0oSsZuAqDJY3w87cGFiJuESyTZPQ5zbzVrmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706903; c=relaxed/simple;
	bh=e9zndTgxsrySeQBGz73yu7p7Wk2G/ahmu2fKkt/WC/s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qD1mYC8e7eQRdOQfz1NvA6ADQQ0+VANUGrIUZh6/iVRsiatlDCxDzU2VJQq/PZU+KjHQtRn5jPUCQtvMtuP3RBR2AodFopn79vkVKsb9C/3yQS9rMGratt+BBKC8XUunGs+DoFfEEK4E1vOLcb6xmPrRrFNlIeShQlrBNKF3BtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=d9zbDd2c; arc=fail smtp.client-ip=40.107.241.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="d9zbDd2c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IwImXD1wLBQv/dP3uwKKhpJyukhn840cqjQ2v0dTsQ+z5NOqUmrzt0curl0ER4RL/l4TalIIasSriTOLXrWZuy5JO/zTk2SKE7x8ZlI/H8mY5qpVOgx8QjokWhsscaddCabk5PvW5j88OFMfjKunFaRQcO1S3I8SSCCM6SV2PFq3XAyLxjgHDiwk2kvi6u59t+qd+8ddAejwBB6ie2YKtQqlqC86/rnaax0Bi7R+xHDvpsNYASqeKE+5EWLPj0x8PRquBkmvgsT8oXPwfqSWK8Zkyhge096crrC3WaCqXyhPEg1BYcrUFCnldvLC4CIJufspnsbd1w4jCmGQVNkGHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3XcdqB4CfMF1Y8TbacLE3tUuIXEHh2xCv0nMO4qmwg=;
 b=hioJHIAGkoUGy91flamWE2+rRfWztjZd4nnXhxeIb5YfWNSHCuL/Z2GpdG1mDsTMnKHtwVep0RvCQ+aJCpogPiR8eIoUjqYgqQ8sdcitTXpOFxX0l2rVBJCX+is5XHBItSawZgeoHP+kirToZxCHaWOijGTYF+QriXp21xL5R3sZH5uG/uxVkjxrA2qVJrV6BqJ2Qdc9Q74DQeXs128hyN0tyz5aC+3lSw26pb4xI0Xn9nxSN1sLyP2+kb5K1hgt45wo+k50jr/RvXNzjQKXq2rxPRuWKbULEBD6dEPUY3oYvEQwwhuwQLhuv68ms/ta+PWTneyYm/8ztVZP5VtH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3XcdqB4CfMF1Y8TbacLE3tUuIXEHh2xCv0nMO4qmwg=;
 b=d9zbDd2cM3X9Aur4O77CBRpYSxMbPquNa2DH/CfFcSQyWrRFB2vQoDbp3Rp3fEylZJEZbRfBc3UYgkPp+XzGT8GW8ss3gT1NWfqG151s1fGIgjMkWwZoqan71Z+A4OwoqmWWp6BSpMnk28jhDM7vpZ1rvIUT971LY1LDghIVopQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 16:48:18 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 16:48:18 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 1/5] shared/bap: Fix endpoint dir for the bcast source
Date: Fri, 23 Feb 2024 18:48:09 +0200
Message-Id: <20240223164813.66484-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
References: <20240223164813.66484-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0010.eurprd05.prod.outlook.com (2603:10a6:205::23)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 043bc90b-73ef-429e-1320-08dc348f3caa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A+JPzW8teiy3J1ASSWJLccsAcQPHMLoUt0YFWvofV19NqO4WgJthZPqApTNkjKcOfmShYU6hZqAqe9Fw/hvijCiDiYx9SUJWy/gN9c3h4bE6YI12b6U48tI0iF5Yrpsiz6dS3lWKyck2nHHZXhDzyoZWw3ySrOLY4ubcyrZJqV5Wv+aFG+s2OCANh4emlUeqWGI3++81iRZlSPgUrClcuhEg06/4g3ptn41l612kBEIFECeC6iBo0dtpuAT4cO9PmkmLEYVWl11sEp8jnUGbYWpIXMzvV05LAAWrG0rVXNPUYQ7xARb0l4A7yRPe5guxTwj5p9tKsDWZVGnei4/QkJQ8f+yZmhl6/Kry429/aSXvglxTUghZIOuBdCZ218V+9SupCtkKnJCHe6qEbQKD3Ht2zDO0O693IF0FXtJvfvozBIQu/DOByvG/pDyIShXSgh0HeEcjnQRWB+gxYhb4S38D8rPY9X3ugDf8NENL4WmSELc8OvGTsRrZV36PKwDcJvx+xDA6mNlHmc6eoFdeIpxe5GNaRcS5Nhmt67zec5U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nhrQxP5SRq0FG17YaJVGJ2F1cs2+J8+IVjp2/1rlUqo/2H6jQmcFCEeb0P7v?=
 =?us-ascii?Q?BF9JiYF0nFFhnfDJd97h4ANRpF2ay3cbm7pfWUphTFFcTwdamC+Jbno6Y0V5?=
 =?us-ascii?Q?4X9++FZv4C57g0NwrXhCp0ratiUwZJeWiGqmYm0ElzdwaXJFq19b8t/Ryorp?=
 =?us-ascii?Q?Cn7yPKqi+1oSvM1mJA1N/ph0EHuzlxEnWRQ1dIHREm6rU28KduBSeguF/CLr?=
 =?us-ascii?Q?LtUuoy7wnzcVKwXpdhIuQlqXjbgpmH6UYlwAqhABhIHh2Nj4FI3gmhMgvCmi?=
 =?us-ascii?Q?JSZZ8PcMbwiHAwspb3SCWYgJKhBMENrPjo/GhTeQTlFvl4bf1O/hyt4BnYA4?=
 =?us-ascii?Q?/5W5tBdPFFomoGu+9FKvB5KWCGcQ2lWRwsHV7qWOsnQ3OJQDMIdLh0lVdYAg?=
 =?us-ascii?Q?NSDGw5FSbHXo2JD5DsoBNiw9N9YSBuQYXXxpB454fKRh3evfFng2TLbBW62Z?=
 =?us-ascii?Q?1qo3X4jFaO0hmGLvEhFjkXoykhxMH7VJAwgp3mKeV78BQOWlZ91qJxqNrf7c?=
 =?us-ascii?Q?VmecxhwmYZn1UnMUhdObg0NYxLW/LCBb3q1pAe55Nzem0GUTqZ/QaS413qfV?=
 =?us-ascii?Q?swfz2y2PyoTKGMTknRdxBpeocZRgkXV2S2TOyw+YC3UDMM4aJhwcr38RAn45?=
 =?us-ascii?Q?V8wYmfxxGDiWkoDTh8t77/cEvGqq1eH5Bq2Qgks9iTrehkHWyxJQcFNkJl1s?=
 =?us-ascii?Q?zmkfkYvgfOZiW5aA9Apjs/+6bRpeaZXeTuIfiiaMrFDOXtkFTzO/nN6t/CIJ?=
 =?us-ascii?Q?rVIJbVo1ldqR+D5yQOTd4pZi/ey8iAPwiTP1eeL3BOmt64+Coj21fkkiQylj?=
 =?us-ascii?Q?KXG4MQ4ibk0xC+BhA6/YK8jxn21BKSZfJnIGk8WR+213Px8pGfKW33yqg2qs?=
 =?us-ascii?Q?YoewoEpHoHiTe9HFbX+IdnqxE3ZZ/QGKyOdsxatuY2zpMvYqkPbheiy9q5tF?=
 =?us-ascii?Q?jC2895HK0sJ+SckPDHxxYI0ZGDtzqO1doHIC0SluPPwQpL9vozcZz/YgYlON?=
 =?us-ascii?Q?aGQTr3lAGugdeH4eM1mXxck7WpzLjoXwfankkWR6DBPQUgaTnnG0tWxXQx7d?=
 =?us-ascii?Q?fX32VfRckQUnvOmZHu8rxjQV7n5fkgIm9nW9I6mg1kSUVm4iDQwWhh4YNFUq?=
 =?us-ascii?Q?ClLM/fGZAgCoYs1eqzUzo56xlHNeIGoQoXLY5DSkYXiMs33s0rZOK2lrskcl?=
 =?us-ascii?Q?DTNPOJwz1QYh/K7aBerHXIr/yhCOTVpy60B+17/Rb537W6AQImyRG1rsC0H0?=
 =?us-ascii?Q?vLAtZE761CL9wwbPQMZkLvl4o235Bv8IU/RLwEy43SidNJpIr82KP5bI++F+?=
 =?us-ascii?Q?x3iZZfj+2YgI2r9EoVORUlFE5vRD/BaCXSDRG8KByhhBNczuRGDi4EWK3/LB?=
 =?us-ascii?Q?lFkwsb33D4tm4eu7UidpTSpsmOWoY2VAhogPVRiV22tRzD44sT+qyNW9aT06?=
 =?us-ascii?Q?1ds+KJ3++Th+3aG5ToB8vdOBAW2vdco7U/4Im884nOnQCWuBMebkCIGVKtQ5?=
 =?us-ascii?Q?UXHCp2tcOkde+hU5YbyH7nLleOl0WwixxhNfkOjtYoNid1fCRoqi6J4JOwk6?=
 =?us-ascii?Q?+OFM2WneymszJrfR13yKTwCW77Sat3Y9IfRFVrKTcpGKns97a1yMw6p35GoO?=
 =?us-ascii?Q?aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 043bc90b-73ef-429e-1320-08dc348f3caa
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 16:48:18.3501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPCL4EKlFFCqJ91k3nlH+5T8h7bUH85CTNQ0nrCjKRclwlPsERxu5pEEthXeS8OvE5JnjBunbcVfvw51VrFK3kJv1C5B0P8+XcOFaj8k8v4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

Fix endpoint direction for the broadcast source

---
 src/shared/bap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 626e8f127..fd29557b1 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -682,7 +682,7 @@ static struct bt_bap_endpoint *bap_endpoint_new_broadcast(struct bt_bap_db *bdb,
 	if (type == BT_BAP_BCAST_SINK)
 		ep->dir = BT_BAP_BCAST_SOURCE;
 	else
-		ep->dir = 0;
+		ep->dir = BT_BAP_BCAST_SINK;
 
 	return ep;
 }
@@ -1303,7 +1303,7 @@ static void ep_config_cb(struct bt_bap_stream *stream, int err)
 		return;
 
 	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
-		if (!bt_bap_stream_io_dir(stream))
+		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SINK)
 			stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
 		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-- 
2.39.2

