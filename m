Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2062.outbound.protection.outlook.com [40.107.6.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FD63A1DD
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709305249; cv=fail; b=sf6gb6rA3kvmzj2kUfc1H69xEr3AGolsJyBjaoU2zRNI2Im6n6n065BrUMLg170ZqPRdn2w/YTbhfwn1P3pIiobuSDTMDwtJoulmaRxBjCABKRxCLdL7FUoIoUPomsB/SfRk62AyWgxzNq6tncVIDFpt8yikwdYES45+MqjhzPk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709305249; c=relaxed/simple;
	bh=RDkTpM2gwI9Fbz1IDzazKlMdyV/wLgsDSEciXbi3czI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p+9+872ZnPEOd4LJjTuAT/ZFaYxyFz7KRTQYbBAPUrzZezZKXXvQd/gidk8hYoeZ3FmVjMkflgImdIBJQQAOJOIarJ+mu7R1z+enGR6jN3KQrtuk00MfQK2aoxz9MfCkwyWyLmU0ey/1ygBFkuLZjZN8a5yU/hlZFXPIz4WhuSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mh+h7lmR; arc=fail smtp.client-ip=40.107.6.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mh+h7lmR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqnLpCZAPZ7QAOM4SVagbg/m3qFB4F/9Sg5q9xYeUU6unZzekzzFQlgyNUl63sImT2MqzWQzrOjvW6u57xT6NZjcOZ1V6r/Q1xKXEhjqSlstCqrGc00zZIJ0TkLZus6/GyFiOIre6+swhHx8TlquErvRSMgMHJ69C00LxdR8Q1h4DOKkQ+eCI7Jhf0Ft9i2ngZ7B6tsSlaepLGzcYsdhuZj2GqSDv0ICYWt7KtIrnuZOEZUlP3fBJVEJqkmkZUFe2jlS3nWfP5a8RRFCFILgq6uLNc0mxlpxhLyp+iLZpb+YG6muknIAn8WRYm3Zdi3O1Z2v4L4+szAWjpaMeRd1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xA/z1w52hREgpfJFCJJhX3SJcqWvgdEuALg1eX1zhuo=;
 b=JXPvrXxxZvySj/4PLi0A/kfwbYap1FVxnafd48CizXQlpFqXh++Wl8aeh6JkcoRJy2lyenccIRdtTT8wnXQj0t79BxHGwIniVHVop0AzhoDBmlQXEuDaV04EKUYxD28xW73ZUy4aHG1yuM9jCGhoy+NRxoAsQUiuZ4Cj6P0buoFZMAELmhgyVk8u+He3IwfhsPX1GVxY2YDj7O34dQOe3mU0x1txax/vKlRzNaVsAP+mfr4SlK03NPixxxMntZHLB+kTLqiZKA0Ys75xJbIZokZz4z31axjJNblKrPGKu62j/GMlnpiwIQz7r6U8Z8F+SQ4Jh+fRrGGxgVgfail6DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xA/z1w52hREgpfJFCJJhX3SJcqWvgdEuALg1eX1zhuo=;
 b=mh+h7lmRZipr9U1j30WTQ2paFYjpmmMyywc4OEY3iv6ErFl+hhFb5fF1Ok7FJR82XS2csrdJ9G/LAxbJ5ergEhYlE+NdV6h9YSa4X1Nr1qDWBeB553emBUxs7W4wYCCHQUjcJi/V0XZPXxTXKIkRXZpuBfmYZ5zBnfFiIAKGldw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by PAWPR04MB9837.eurprd04.prod.outlook.com (2603:10a6:102:385::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 15:00:43 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::83af:c10f:9f30:43f%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 15:00:43 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v5 4/6] shared/bap: Do stream configuration in bap_bcast_config
Date: Fri,  1 Mar 2024 17:00:27 +0200
Message-Id: <20240301150029.14386-5-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
References: <20240301150029.14386-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P251CA0017.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::6) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|PAWPR04MB9837:EE_
X-MS-Office365-Filtering-Correlation-Id: 8113ee48-1e30-42fd-7d7a-08dc3a005e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DX3uQHsEwAUmc18rQoo1w//KIC60eWg+K1CewHsCVwbU9kZYlFnqI38wVrECoTkEWGo1w7JagDXXMAlABSAVLY5dQE+MQhOXAIadAhAaHVkno8cdlyOCLWnRlcWbCap4+f4NVlrwRSMKSr6n4Q3KT67yHDG2NJSQiDe4CjSMNTpFRvM3/WviF1HjxbybIv0v2P34YQ+ED5GFdlydjNfytbYpitpKquy67wsBnQTCp6oD+97FszDGIKndsGD1jM/dsHg+UviXuYi9t1T+omH4aFOqe/4g2nyk9X71TmcR56BfqD0rgUd8MxhIsjVZHgG63tLMxZz6Jm+STC0I/1WjWLoRgZHnL/w4+BBda5XQoKPITppgrti5JpAkSHVd3hCWAnF+3sm0BPX8v68i+s8MnOrr77ban7N0f39Pj7hul4q3FO0q0GyI/ZX6Al/ymSj/ZIeU9A8LJRxMg+cWTUvoCOuqp2oNZvM3Ob6Vhg8nhRFkV7Ea9nvJw0cQVbXNTtnYyxS2AsC1cG9CJ6r7ti45eJNTUswWrhkd1PLWANfFpTqTyLg8LMmFO3Gdhd0uR0BirIRUVwOf+5nzoc8JYrnZOi5VQtEIQ0m4s0M825ulKZrJCWgCqoxVV31z+8Mdb5zlv5qYjFfsl9Y0+8TkSblAiQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SX+1iuyVNbc2WOWqpmemvSVUEhSeOx2fN2iRuoak3aKtdLnyTaXCppDl2RX/?=
 =?us-ascii?Q?QnmTbKhweh342KM7xumlACA6wCr94SdhTcxn7etT53t/TFlcqNQUZl9kK55w?=
 =?us-ascii?Q?qJpLaxXoRs5r+WqZ/VvGqi5FidGtr3xWwqABn61SQjDhFv1o2e6WmDFDRz7A?=
 =?us-ascii?Q?x2qJpXvrlAlbyOmT48z4mJix5mdoEuIJkAazA/VGHfrtH3mqseenWWiqgBCn?=
 =?us-ascii?Q?2LEGxYCXB4muyisA1GJtzCoB0v1RmU3jp+g5qA/FR+7Xe/Znp+MEIV0gY+OJ?=
 =?us-ascii?Q?Q6SSDtZxlWKqYep1ACqWTtu88yB27pjSbqmuuOp5X+jj8Xpxao/JvP/6wqs7?=
 =?us-ascii?Q?Z3f8NwSSwkKnm5EFEZcibELPZRAehFbpReVDlnEKiYbWm/bJDAp4H5SrRLLa?=
 =?us-ascii?Q?9frJMKD2wvwHxRXMy73mFnffNl84KH84y2nX8zFgCpEI0MRUJrg6M592i8Fp?=
 =?us-ascii?Q?MGrV2doUONkqK5XPeXyRWcm5cKbMji9GFUv7T+J5ePx4SKIipQHdTmD7UHKT?=
 =?us-ascii?Q?Yi74ySPl8oz0mVw+bME0kpSXtQoNUxm8hSwU9ymH0HPDsmmnixKnhMcTyqAE?=
 =?us-ascii?Q?Kgh0M/waWiOXxOkw+Hyha2M2hjv6hsq8KqXItDuH7N9HeP9OhOMEjmGzkZ2N?=
 =?us-ascii?Q?UhR422HrXDn1oHZfLKhBEa/cC3ZOTibyKM6gC5p82NUn4JWiJp+MhuX4rOCS?=
 =?us-ascii?Q?+yDiFj1ApydFeiLCxktsog/kisLo7mTJONOc/+x6bbhyOYslpSzWb+FVnZMo?=
 =?us-ascii?Q?Fygm1Y4hvf/FUnLUYnjQHl6jTTbDDiTS2QABeVDfNEaEXqG/rb6sqguZloXf?=
 =?us-ascii?Q?IM7ChmqiAPD+vCr0RFgSAGEK3wRwKKnbq1W8dbXEyABgvAoo8R2FfNJMSoCk?=
 =?us-ascii?Q?2aXhuJV/TVvnGkODWeIDcP9cegBFSAjtLNSJ+TO3puNInbgy4mn3MXQjj1P/?=
 =?us-ascii?Q?+Y0SgXxDD+KvSTul3gmx5rwtmLeenl27diFW9W9yvW1YZASVOaWxle6v5LH7?=
 =?us-ascii?Q?bUOOKygAI3WHHzJoF5mglVtuqbExL3G6+nA9oKzYDQdqVZbmE6nUuB3hdnSu?=
 =?us-ascii?Q?ZaMjssZYFRyjkIW5cjNkDZ5CiV9XWgZryPn/REnLVbgHehcnOhm6+LP0b2LD?=
 =?us-ascii?Q?6hJcbK3j34qFbeD+WjJQC8p1XUEhQRHbjmZ99sb+L8Qm63DozagpXUVewICI?=
 =?us-ascii?Q?cYJk39qqMx3s48LacTb+fbWuOPJNngG9sKhL7ZiPYBoOMnTPRocsO9Z25Yck?=
 =?us-ascii?Q?KnO7/lUG100WhDUdrsUhUeK1lzHnrAN2jOgfHIK3P6oOcsJpPUWDu6ycDj+H?=
 =?us-ascii?Q?SQhIXKW30glBuPUP0AMCuT37eXkHzqxNHF0dUbswBHFOcCC31sKVY8GBruaq?=
 =?us-ascii?Q?PSOciFQAx71kIA6hDQKoEOBsbDfgYOFpQTyfBuAM11Vh0bQhZbo74aKHFQVB?=
 =?us-ascii?Q?fpeUny2W8srZPwWJSgCyvpOvB70O6dozi5dxVs6WVEvfmnTOq93Pwvdra8CP?=
 =?us-ascii?Q?V86DESAF9DIMKu5+0An7NfGioBSiKlqV4x6KRwbeyMVm4sh3mfgU4WtXViUM?=
 =?us-ascii?Q?els1aDme9g/7tXTIvL9T2IIANvU7oQbZq/Qpicw8cMBsFYQnNeiCUWf9JKjP?=
 =?us-ascii?Q?WA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8113ee48-1e30-42fd-7d7a-08dc3a005e0a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 15:00:43.3011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXITEvptE7TIbEawdCJK1DYCkY7FbO++alw0ro3Uhik35WeAdzkL93Vlmk8brzCfmEjbrTNtey7HD1KCf20Np4XCoOhlh//jpVKXPGfZUW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9837

Stream configuration for BAP broadcast streams should be done inside
bap_bcast_config and not when setting the user data.
---
 src/shared/bap.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 638c6f8a4947..50d03456e6cd 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1693,11 +1693,8 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     bt_bap_stream_func_t func, void *user_data)
 {
 	stream->qos = *qos;
-	if (stream->lpac->type == BT_BAP_BCAST_SINK) {
-		if (data)
-			stream_config(stream, data, NULL);
-		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
-	}
+	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
+			ep_config_cb, stream->lpac->user_data);
 
 	return 1;
 }
@@ -5369,10 +5366,6 @@ bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
 
 	stream->user_data = user_data;
 
-	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST)
-		stream->lpac->ops->config(stream, stream->cc, &stream->qos,
-					ep_config_cb, stream->lpac->user_data);
-
 	return true;
 }
 
-- 
2.40.1

