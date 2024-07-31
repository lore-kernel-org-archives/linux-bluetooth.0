Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011023.outbound.protection.outlook.com [52.101.65.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF48A61FDF
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406667; cv=fail; b=hL1FqkqRIT36yF81LeQxYoqv3M3r7nvNAMqYwD7nxm+2Pt5nX2fhxfzv4O7kxyYpu3PWV2VvO6LL/jSL0QiCVnBFROK9nLgieEl0Msc8ZUZUPzBQTl9RTqBiEnO5uvcws7IPCJtJfJ7jH63wcDICbRhrwxsMbG3Rr2JmEMTYlGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406667; c=relaxed/simple;
	bh=Z7LX9XM2Amtl+uR4HYCOgsS/xgxyJD7PiV9dN5s3XWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p3DQatJqbNRJeoLzwYO8RhxkWcRlKdOxwTWqnv6gAO/YObmFdtyGLjjfkT3dZhFgDeAyERambxQIJ9LKD2TrekzHnwZm2x4HnaMV6dfNI4Ab58hZ5SDU9uhEBa6/svyIpioiOrozHbgIca/Zdd9DmngpiI9eeetYnpm271DIhuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XMEJVMkA; arc=fail smtp.client-ip=52.101.65.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XMEJVMkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KMOpe6bfNR0VetBXwq/xJcETClBCtTdCiKfAhiex6wdJ6UrINeeShtBYRVTAi5QuArQn8Yr7V+TOJrDGdPFn4zoerwZqMjX0BWZxOa8V2OMW6f1a+l5LCCOF5nIDrvD/HwIRhJiRPBjE/9elb/o2Jr7amWP8U74gtybxcodBg5woUZkdgLqx72qFcJjv2rfrD8i2DlbZeoCoWOl88TPVdZefhf8ypjzUV4JctpSHML9GApNP8zgWfTgMmwoU7ObRvXbUqGlqNpU8sKQmN9dyha/4m0xfaP2N2rD4wLNqhM0cARwj7xsruCHefMaN60xuZSZSRTr+GEtl/3W6z7Iofw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nnU9cuP1EYfbYCP2gx3b1ZGbqSXP4oI4fOsHemwom0=;
 b=nnSg9W1agzPG2lbIPB022QGOrjw+393VJocWPfYy7Zr11dprIb27/lAMJV7xUrOVBWwPiQYN622n47WeGB471zuzlTCLo1ynPHZ9YvIiRAufiN2H3jtV10qPWnec/pX2BBUB6GBq32ofiYYEuS75oaXsXP/0Ye2EFtxlcsGp62sG1K4p4mq1ZSvLVF6UnGdPJhe5gZUbmtcf4h83UFBPXaTG63xIJ+kdAF4aN4JAFFvB5SCpyPutsOW6/j1kn9s5YSE7f38fN+V3qwfDZ87QShHWNdtOJglyNNzeHftz4Ab/6LxrH8lRRuoFylYC1BWJVd9tCzSZ8pTgkYo9ufNp1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nnU9cuP1EYfbYCP2gx3b1ZGbqSXP4oI4fOsHemwom0=;
 b=XMEJVMkAtGkDtrA/qj8831YoIfGk8AqEqTG21/vuvsClgNztU2CqM+XH6tAXe5BJ0/2zey6DVS3RvQiU3DW0T1ozn34LYKGWngzP+TD4yQ0bdxIzG38ux/a/CokNv2vVbU+f4x9GhMtrgDyT4xnRYSZdMTOnZsxeH6kp27ZUhBVM3ur8ng/E0/ClSjI5BYXoZcmJJ3+dze4p5PbDJcHXXj95WwToj07aOZOtoF1SSHq9tB5+JDxjOGSfl8jQyHVIK6brDIdWxOBbDMbVoMUdCKA4FbyV5ivnkmcsMYUuRnp0h1reJ030NBB4n697NqEZ5Vsgd2as4+NKXacZLoe00w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:39 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:39 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 5/8] transport: Broadcast sink: wait for user to select transport
Date: Wed, 31 Jul 2024 09:17:10 +0300
Message-Id: <20240731061713.435586-6-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bc8f97b7-ad44-4fa6-bf15-08dcb1287a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LtVtwuGr5+HPJD4GQC+MJKIcNhRm+eRFcaKIp+dY5+TU87hHN8IZNzygbMpU?=
 =?us-ascii?Q?O4YCAXZzDxhdp2gCHzusuhgMcpj9gJVwPcZNcNEkkkCKESIKQ7doybGGcsxN?=
 =?us-ascii?Q?yug5dSGD1UrYtlwEu/9j76nD+k0z6O77+GghYzquYDSvS8D7t9013Lw8vy96?=
 =?us-ascii?Q?ASTWOoXPdECst/l/4JtCPXeiVg3x97dubKCx77iFSggtWJr6Sf8y9aCRRZ0j?=
 =?us-ascii?Q?5yyXx0SNrl7237JQE3dCGppQ5mPJ+PgbYyqMsdwUJcWLhBpMa79SdymSJr1A?=
 =?us-ascii?Q?fd980BWDPZhBCAKqrEvxNrXlDICTaotRqT0hbtcMk3sYF948JKsxIEUp0yTW?=
 =?us-ascii?Q?QrL+vl2+XKGfexgjGeojWVGeBoCaD35EBR5cgukxcWOSCFkWBKTsZaaVhXYS?=
 =?us-ascii?Q?P5kujCsRsgENGuScBNgR6mMiBm02Pv5vStETtqgz+faU/0NzKf+L+TIAU8Pd?=
 =?us-ascii?Q?FK+JtfbDvP3r1CE55welf2bVf1hzinGcWFoU8AgEz7h75dN9KYWMxPME12GE?=
 =?us-ascii?Q?dwB2B9YyrQF9N3WiQlZKUHNsJUdJm5egZZfg6dQMhWmdJ7jUICJWnzkEH1HW?=
 =?us-ascii?Q?s/p5GJc4agdi3fRJI7wqURY1pybKUMJIv3Hy3WKRkoF9Z/p1nWV2uiiD5Ogi?=
 =?us-ascii?Q?QYXVnl/QnwPI35e0YVdQ3A78qZOHPQbulqUf657NZsycdo+BBTMvu2zfKgvd?=
 =?us-ascii?Q?B4364b6OoJAva96AFO54mUwDdnrSLt0riF/o/xeJhg+xksEmZn9iESLVBqpF?=
 =?us-ascii?Q?v8cw7FkKRiC5QwzJIpf0qncm0FrUHqB8H2/1Tu88n4kNblm5NQVdcUKNmY36?=
 =?us-ascii?Q?JvzKP0TzXhWFwua13jam1C3Q0c76dy/QcPrM317vWypRUsGuvDmzWY5X7csl?=
 =?us-ascii?Q?fyB52TA7mNITeP/ZwCKWkF+VwUNkjXaC+WjigEDl2oG/KWUkNtbxdvSktjR8?=
 =?us-ascii?Q?vzs5l981lYmNHoqLSVRlF9roAANCTO5NUJGoMYIMDTace4wYDROd3TPGOpMF?=
 =?us-ascii?Q?8ECU6bUcc7UY2MihPAcvwI+v7BuHGEWrdPQhHvMFEhQ6TnkhS/YVvPMWNgD7?=
 =?us-ascii?Q?87lXJWN3JHXR05oR5zN53o0d5rNGTZv6hrSBWFcN4H73WEfsx4q28gFpSMeI?=
 =?us-ascii?Q?9pP7lUysCVIgxWMVZS7ioRuLiK0VY6J/cwWL0bYJFL77fuxd5Fa9eSd4MNda?=
 =?us-ascii?Q?p8FQmfPAmTGBsnSGFfC5f6eugodHDNJ0u/maPrjFF3181uGhRUL5vpLlAnah?=
 =?us-ascii?Q?E6vNNKQgjy9fbz2yHG+QzV+ZyCjUKtan6A7UwoIY4rl/hc1d0GEaks5s+nXt?=
 =?us-ascii?Q?/7tDaqRwNBOGAtEDWDgkv/UmbqQGK0Nrz/BUxDtjMRdjUqcqZSCff/BKHATm?=
 =?us-ascii?Q?SCWCkbZGppq0X+vtGDO57mqfFiL6lAGUvbEP+9npJIeLJ0wzYw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4L/1NtLXcacO4Zkv7BYoFHSxcaXftsamjWq0vthCl0heMniqHijazlnyRFzL?=
 =?us-ascii?Q?kWxgRQA5m4MyNp27n0slMJQys8s7/FgNYcRuPkQUnPKD+G75iBPaZ8oThgry?=
 =?us-ascii?Q?T+AjNVmKwyxxB8cWjr35mOp9x51vMJXrGMe/VJIrM0UqUiq9Ypc/beGnp257?=
 =?us-ascii?Q?K4xNTlMCl8BxUkdPVK0nNEh5arnCgWF/NIUaHxeCiUgp1WtlEjO/ZiDXPV2K?=
 =?us-ascii?Q?VPyMCAkTQKkAbJHt1V9ctqGO8TeWDSET3olXNYPkO4rKkg9pVM0jxNNxwBz8?=
 =?us-ascii?Q?PFfz7qA3uup6ebgYugDTfTwCEVUT1iZxB8wu9KWRFEdArdxr12uSV5l83pMf?=
 =?us-ascii?Q?SEeVIZO7ZR3yaY/AGXaXlcwF0bQeDrfgIUhaJrcbv7uqC5jMrFxXkV7Zso28?=
 =?us-ascii?Q?UOUI5/eDiMRUqzbUj83DeOnLty/EvzMbDjJeNbMkeWY1NVhnYkbYiBitD9cb?=
 =?us-ascii?Q?2CrBxJH2/47w77uMq8wazKwHHy/kZOLt4YLfDfsX4AJ7tIhPw3F9uDO/9w5E?=
 =?us-ascii?Q?QujUQynx3Vb4yKwFWl4cXkk4VASpSW12+QYc8AvReFImQ6HYP8pnb92CqTrY?=
 =?us-ascii?Q?MyJ+12QQupD4FEzy0/obUYACheBZ/QeuBuPWUaT/jlFRoUG9iuNlwt6Rpu4O?=
 =?us-ascii?Q?edKrx+9ID3MZbIzOwFgdYHHoDF9JeEQrZyn32WMYT1wAQ5mzVZ30odLG5MZJ?=
 =?us-ascii?Q?d4q0URHYxCf+tTaaRP2A12NOnI+u3QpXl6cgtQ/zwmTYYpguZ7S+bb5R6bFB?=
 =?us-ascii?Q?4rZPofBcPc0vRnJcNPfYXv5C1eW3TG0ZRlua0QOjnpegCNcT2yIBUr/x3wbq?=
 =?us-ascii?Q?aWp5BMdOnSQyikm1bTeaybRrzI0hhXlgB0Y6E52vNPg8JQdg7xiZgj85l2CG?=
 =?us-ascii?Q?USM9zrXq3ZNmvluHT4D+gwr5OAKt78tcr2uZ0qc5xyFjkxzzfHeZCfdhtRls?=
 =?us-ascii?Q?njt523/zj3/SKbgE+OQTW+35ikYX2oXcunCYaBmH9FopsF0bqzPpf+SMtXHL?=
 =?us-ascii?Q?l8Vg8DKo/4B1NR2pLB3OWlbJ0jtsZGZb/OChWV9dNOxWLmqHwI8eoK3FeERe?=
 =?us-ascii?Q?55iipwpGl5WFRAcxi3ZoWlvTUdjQLy+j3S0R9WIVxH+jP18yczDW/AawjvQv?=
 =?us-ascii?Q?GZkPUMlCMtlnhSW/Bv5wsDWu97x905jxuXUjRIpVX+iL0k68U0aOHTV+MYXI?=
 =?us-ascii?Q?MehGvFs6tIl3S0IY/7FBHLhpC75LTbvBCjK8P/O9T85FACkgxz44U6nqaX/8?=
 =?us-ascii?Q?cc2lAZAIHDJ1/e271MUgqxLhG3TCLZft2kyzypBal41HxJUNEgA/wjDh0bBt?=
 =?us-ascii?Q?HGYkXxLhrRQdiNbZc6KyeSEgVAkKnE0PpBQsxve/3YKUmzb0fHZlP8LPB6Rg?=
 =?us-ascii?Q?yrQ/gANnrQFQrP0pfQjNNgmyWjJmeO8PC5YWelOajysE6tYATKvHcCS9+Ztv?=
 =?us-ascii?Q?RrM5BwjxWY1tK+MgzJGlrVdkdfk9XSp7puGfschM/ghOo2mjIQwe+EdPgUkB?=
 =?us-ascii?Q?fP7ymBLV40AMBEOFMxwVIB0culnrJPOoLr98zNcfXK2xCkNw4EeEbQEz82rS?=
 =?us-ascii?Q?JJlz/F4vnLM+5QPNckNRXvzxr8h6htMS/SyeMLGq?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8f97b7-ad44-4fa6-bf15-08dcb1287a91
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:39.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcuHM6lXIVJYCew7DwhkKPfmHC1OFa6JNPCdsTRWll9kM4NpZAo3G4RyBtugxe7NjSSrdkrC5MZCZWZ9IoZh/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them which updates the
state to 'broadcasting'. This allows for the selection of the desired
stream when running the setup with PipeWire, which acquires any transport
that is broadcasting.
---
 profiles/audio/transport.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index bf2215a0f..80e4f564c 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1303,8 +1303,14 @@ static void transport_update_playing(struct media_transport *transport,
 			if (transport->owner != NULL)
 				media_transport_remove_owner(transport);
 		}
-	} else if (transport->state == TRANSPORT_STATE_IDLE)
-		transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	} else if (transport->state == TRANSPORT_STATE_IDLE) {
+		if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID))
+			transport_set_state(transport,
+						TRANSPORT_STATE_BROADCASTING);
+		else
+			transport_set_state(transport, TRANSPORT_STATE_PENDING);
+	}
 }
 
 static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
@@ -1686,10 +1692,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			transport_update_playing(transport, TRUE);
-		else
-			transport_update_playing(transport, FALSE);
+		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
-- 
2.40.1

