Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859C318DF7C
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150608; cv=fail; b=NmRQNBEIyuTz/v8n7mR1lCG9RPHg3GRTY+l5xKz1IkomUR7ISDcYm8p/rH0WtZuUrQ4EjmryDEci/x4ony4Fx2xCzqcYjwoyUhE3XnLo0S+elqPvtmylKERyYmEEduCeFA03U4Szf0oHWjfM2YWcqFHnP5v3OwqasG1TuqJ6b0U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150608; c=relaxed/simple;
	bh=cBh8JA3exI/pu4B6FF0fELAZEPkTKtmCGbNWIFp9sWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IXd93V4Q+aLUrHWfqYIwbmE1cAkfPIAy0+lU5Jl+cU6bHM9ZeWefuMWLBvu+ANL6Xro9RdyLNUBkDoWAmdtv2QJWjdf3nyuOoWp8eDiH+edZQm1qsw86eY5Vo19o1VjdUMKPnYcSNlnfyiLm8O/EnD2g/t0TPmKU+A0S4+7FiOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y9yyOGQc; arc=fail smtp.client-ip=40.107.22.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y9yyOGQc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bolNmsrNI+wObC6yM3/q7PP0xC8oKgmYS4zdq8f2oTf4zNRmqUx6h7a1N88eWvyLzDTJmSbdMnfJ0kTxXi9TPV1099yaHtvet0rvGuLRSylgCQ4Bqg9dNRtHLYz3CbVTyP8vxo6rLkZmanGsVOA2U8lVzWdzPS/Nm2jQb0vbYRtVdKNvlhbrbJQBmSC2WfufH2Z6c0SgnTSSWOmbk3YB7DsjMq92I0f5Sr6X00hvr9jO93j9/VNX0meyeCVHWtImpkv0vpEdQPonlT4FMHrlkIHDv1JmfN3f9a6Mc5hOR8K2torjGZKwIsbki+0k0dlQVRwt3/R04jzlnMKrLGpaUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0OFVizNoRRLM7UYnGeILsQoFo2SDruFPXAMdnn6wNk=;
 b=bK0pVVZBtPB1ET2SnF/O2Po0g6HFsaNdmYYKLQ5IMIGucx1QXgarteTKwIL6nAp402cJ3uiN6YDpbiIjmPjKZNchefaB1ZdYofYEbYuESD8vLpJzgGOVdAe4fJVrb+mVc8jFUFd/7vfKZ6WuWcxOTughgcAyaAqbkpYNpaoU0Kc+TkxV5czkWcLhT3xgK1LZogo2sbRS+IenRbLczFIS2l6R2O/9vXoHiYNuiq5u+QJGcVe8h3sUP+VbWbav/Us061JnC67DvkMSy+14xHj/GDpyY+Y0gFfLTv/ptKhvlgDj40aUeeLvOgL756oD/QKUxnXUZl8yqBRBSMcQ8zIRjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0OFVizNoRRLM7UYnGeILsQoFo2SDruFPXAMdnn6wNk=;
 b=Y9yyOGQcooHEDZoS6NWfpptFyruVtFzu3tB9kxw9DqFUNWr6e64SoXPHQj4uGrLZvrurMNEziqp+C31rG9F9AYzXM7dWimB66p5yilKBOgomUrb/Zpv/AlQGsjvDtljr0WG48lhGVYttxBEF7/ZSMQGC3ybJftOq8AYhltsMfCNMvbtDKQSiPRAp+aWbrYvfrrm4/iIRbvUBHlIZ9Ha6sZgCKthkJ2LqLwzo3bh/W5jfDzkpVbKgSQhATiD1t2DT6/Cd68EuF/icVkB0PGY4V/gTkIoF53JT8QKJC5mk+arptAgfaLhaW49auBnNB6bfXHy6cfk5tSLMv87vgGcyVQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB9641.eurprd04.prod.outlook.com (2603:10a6:102:23f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Tue, 20 Aug
 2024 10:43:21 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:21 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 6/8] shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
Date: Tue, 20 Aug 2024 13:39:16 +0300
Message-Id: <20240820103918.24246-7-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
References: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB9641:EE_
X-MS-Office365-Filtering-Correlation-Id: cf901aac-c432-4f31-9dcb-08dcc104e939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dHG4ZS6KrOzHuC2wIKbRFWaQSsz02ee4Er5ylVJN3y3L4xqhUmK6yZ6mZ+rA?=
 =?us-ascii?Q?llBB+u378hq8cLFXqFZ6crNCOEL3DeWKrCMjICpjq12ULr/WqpBnj8A9hLwP?=
 =?us-ascii?Q?G+iOtOTxCR0VLTk8Jb7ov+JfZlbp7H6udynK4SMur7uWEVXTUWm5TJOJTrJ1?=
 =?us-ascii?Q?RHLTa/YJULiHMCQh3dnAKo+p2VsdptBHg3N6fxWoCzx6jX0a19XTpBB7Yrk+?=
 =?us-ascii?Q?Fp21+9UD+anwH7b2+6btp8JrQnanzE++49ePnsv+MUc5MOLqBtrxw7ajY02Z?=
 =?us-ascii?Q?6plk7I552o0ANvHn9ndP2648I8RszyhcbXzoDX6qH1wFvIVzYNQMldjeT3lc?=
 =?us-ascii?Q?Ztt/qMZ41ik2ZoNQ+B6rorrGinPxcP+jqI+VZ4evCCkUeL9YNk26cjWHYQ/f?=
 =?us-ascii?Q?t73jr65P9S+poO0V8w1LHUrhf0oAtpBFD4iluwOu8hv28oZ/DJ00LcOq4bSI?=
 =?us-ascii?Q?mD0nWuOaboW4NSrLrQl2y+U5B/Bvuj8Q+oNn8n/N+K2i7Xb6WqfD8iS3JzW9?=
 =?us-ascii?Q?IMaf2NDFvRJyoke6+mfhs19iQxsZGCnGLUbIIHQbO/GSFOLZT1DamkuG1U02?=
 =?us-ascii?Q?qnra7BBdTB2xy6vjBTG8zCohLXa3+5tL11Q1m8E5weTDcnOh0KPHtnixc4QG?=
 =?us-ascii?Q?FS42RhUcJ/xUqHzFUMFKI52/oOJ6Lh2CN1e2SERwnIjvYEKDAYWQ7Xmh77u4?=
 =?us-ascii?Q?C4bO1TzjN3/jHGeGqY2nT3GiXsEKkpBsA4zmZF7vrlEjrLGRQSizd1bX2Lv4?=
 =?us-ascii?Q?Lc1FqcIOGyllN0N4cVB8tMucpr58cyGh6BW9VOmSKr0015PmQaAP3wtbfDcn?=
 =?us-ascii?Q?gbPhkQ3vSsWFIBS0t+DosGP58JOJS2YSDM2Bts0rYP6HG0OjcuhvjLemBQt0?=
 =?us-ascii?Q?sV7DzdIKUVr0SnL9/BLCAPjctaxQzdvhIpm8rJ3oErwehlnaMgJZHLOOLWVl?=
 =?us-ascii?Q?pU9WHXeXk1BcMp4+r2pyTKC2btxbH1/TZy/mqKR0fkGQMHS2PAUwzYebwhVB?=
 =?us-ascii?Q?LIkKr3FTHwSTTQYTxxJY/e5l5LEs/55sWloTedYLKuX2pwNvC70NMlHlfTHZ?=
 =?us-ascii?Q?rZm48vf7+YgzrOqvnJvP1xWAexw0yn0Qp2BWWM2kcWdDKF/dr1zAzvNDeRMR?=
 =?us-ascii?Q?qVyGJB73lGzTmXbEwMfNhTCpDYejzEWMwHpgBFctNfT3sQIhN7p9gwo5jqo8?=
 =?us-ascii?Q?spIAlxWVMD1VAVym2nW1Q7p4wETrEzhYd6+klIBBPCmLzebHv7oRkZvupuor?=
 =?us-ascii?Q?DmvErWB89pwDmpfkDmvmj2Oh8WUF/9frGFDwlpEVrmGkwodJg61FZyKYsF1Y?=
 =?us-ascii?Q?iOGoIVwr3aczZr1Rlbrh/8mfJ6zneyVcFIVJFXaWBzslxnnuRp7F9Pjzf6V+?=
 =?us-ascii?Q?0O6ZBnXX78KONJbeEHsvxEccX+eXNAHYI5EEdB8yRJ9dy0c9Hw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yoo7aMY3JkM5CBcQVyVEjJNl51gz15/SREmkMZPk2Y59sLrUHhg02vRv8TCz?=
 =?us-ascii?Q?xFTo8jiOXZHrk1vr/epcYDQCR5HSwfBNpMh2UJsOFMRbMq4en1wUpjS2PKaI?=
 =?us-ascii?Q?tr7c1vcTdc9FJqUNW4ODiF2RWRjPQYujhrZDqp9dZ3mtpjTxpAmoi90n4/In?=
 =?us-ascii?Q?YxTfuCuK8QEa33PAVreW8cWkl13LiSH3drWPW+V0pVUL9xNvICxwgUarg7r8?=
 =?us-ascii?Q?ZupGzpVwsJcofwrMbCnmHQ63c/6S9hnxOcAbee5dyZHskl1iELnQ4txqWYhv?=
 =?us-ascii?Q?Wwk/PRzyoJKiDNmHpz2+ApCOEq1qkzgWBWFS3/7NVlioU6/AkKbdcEkM3mHX?=
 =?us-ascii?Q?v9L8PeUck5DtjK0RwrPGDlcC+nT5U38QdFg41Mg4pYGX8Eoh1+sJAYGrSyP1?=
 =?us-ascii?Q?vIkbo6BSzSGZmX8/CBHGK8nER3msZXnKLas+0BhRfiw/LcpVb7Mq3fskxhXG?=
 =?us-ascii?Q?m48bb5rK5WnnZ8Br8Is/IyA6/qVCcj2Rt1W3Yd8yulEc3wVRTsD1PnPiJtmn?=
 =?us-ascii?Q?OjAE4Ham0ZkD3m/pHE/JZ0cBfVfwnWrngHhxREM3OLYTgaGKd4N/CmVk7oUL?=
 =?us-ascii?Q?1+WMJctzbjVWau0w4yQjyLfKtUwDg1ok6od909NuGy4LpybCdVNexAgnI7Jj?=
 =?us-ascii?Q?XO6o2Ub+DuUV9nUJxqalLM1t+hRfATIosOuHZ55prJpAGGVjQ5hufevf67ke?=
 =?us-ascii?Q?9/DloQaaLwy8aOPHRkpMplEZ1Qbz7co1GRgDrW1X0Yx3zenQV1Ek5I0f2lms?=
 =?us-ascii?Q?9Nt7LVYnfcqLyWxAPa+1Hurlh8taBpJEAgANjvnr2BRyErE3SAX5RJaoSqUE?=
 =?us-ascii?Q?CuewdP0lFHHXSWPCkGGyBVT7y/3B9D80zXh+b+hh0dvr+zMWjuSV71LhCcSs?=
 =?us-ascii?Q?t31/PdoVDd/Em3aDdFcbi8KoGI9oV9/VzzJeG9qLcDwFF1W+ywkuTCCEdte9?=
 =?us-ascii?Q?7q9HmsDDGU1R06AkcvZgyBvk1fRaDgTJcWl7kKRIMCsOJWJaqCo/PYqMfq0g?=
 =?us-ascii?Q?lJqtjjF1aLRuM181l6q2rOXyJp8CmycR9HwiJ0z9ELOaKS+3FPn+zuS22B3Y?=
 =?us-ascii?Q?qqSP5lfXLDSAXf//pgqUCLL9Viv5JtFa2+5W5NsFoyFDSF5zAko40dd504E5?=
 =?us-ascii?Q?UxVisGMDkIKfVwoMGKXioC2noONeYTgs7ZyHU3we7ErqFTPfSkJjYy/bcDsj?=
 =?us-ascii?Q?5D8nlbf/GXw5KL6Zwl9rrt9BxqS1humPsn7454uMNnAK0b5YlcmwW+PjwCE9?=
 =?us-ascii?Q?GShFfra4AwGHfvLM8Nd3vJxF6MefbUknnvufOa+T4A7fRZK4gvy42b2WespY?=
 =?us-ascii?Q?4/wJpTwATBCNT5PL0a11p5BDE+wE1VkDcDN1yhAx4z8zBNYmY9EJ0XtV8xp2?=
 =?us-ascii?Q?Mn5hSpE8fQtcgvpS+Yhk0hLloYhp56BxuBrOfvDx/tfe+oD7acCsGGcREoCA?=
 =?us-ascii?Q?YQh9QpxeR4EJLNMkeky/0sSl8caRbWNTetayHnfDpb5yaYG6SIIbPlC2Uz3R?=
 =?us-ascii?Q?Fm5WuPEnbG3Xab1UW9Nh3oHSHU/0CLfBNAXrLz00XMP17pm0SYHfAd/XXAFv?=
 =?us-ascii?Q?NCgLtXAZZyn4gqeiIzDdrvmZsvWquyXkkXfxZcdJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf901aac-c432-4f31-9dcb-08dcc104e939
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:21.8428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiloTtQq48Vc49vwL5Vc3aThQ4H0vl9wdR/eqikpEBJ2jVcyOEP/ei7nQwnzrc+Cq0ypVSSZL69CC+pXLthqew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9641

This enables the set qos method, bap_bcast_qos, for the bcast sink
streams as well.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a7217b417..97b96e49f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2243,7 +2243,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_sink_enable,
+			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
-- 
2.40.1

