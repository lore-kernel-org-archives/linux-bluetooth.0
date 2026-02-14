Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013036.outbound.protection.outlook.com [40.107.162.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055FC27146A
	for <linux-bluetooth@vger.kernel.org>; Sat, 14 Feb 2026 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771083412; cv=fail; b=cQNo/32aMl6B5HvJoPNmhhUikpA/P88sCOQD1doUbJiNwUPuFZN0JtYjUwxPGMhhs0U2SW4vvLHR29VhtnOQoKES/EZ5dB230gK2JVhlN6yejN+sCiVyha6IBMnKvRYSsdivfU0xzTyYfup8ujZyCBSVBOprAmn/g2Ig4mdImzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771083412; c=relaxed/simple;
	bh=2T3gQT4y1b3U7eq3R+6nghjAvX141oeQPqjottSB/Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=s+/3nEgITuEJtieR7pip/9JFoRpIIlaDM5kHKy7wF2FyjqDSPcM9s8fi8zOWVA6tBoUpQniCtjRrFG+nubqPl81tF2J5RY1rvpB6hWCYF/P7ZY2PJ0CK+uyRd1952EKk498lDZtK//6d8PdW82bPFbvNtgW+9LWPJJ90+FDuLEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jb72UUEC; arc=fail smtp.client-ip=40.107.162.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jb72UUEC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZpufj/Zy7GJXsht401Y12UisPU7eD8hrrxnSN2Wm3he7SQ1wHVekukylFaRxzmaCrBeoBLyXkfR/PD2OhSLIasL30Wc4lN6HmSgopIvLUGp/IRvlEJ/eMrCD5uwwR+7vjryvMbpdjNkX8pxFAo16hb89oxhqNrBsSWuGYw1eYVsAD9VXGO8+I3dKml7Ja9RnswVy2ImC+Mkaifh+jzpMgVRvivl7Ndpi6wAeJJMslyEX1MCBxhXnqBJ7UGPs6QXVJk41MzHQ0O0AheN1+Dac4Bj+E4kcgCazMPx8bpZnnx3SjQIRrrtLZQM97d/ua2myqyQz6PdDKIQ617BwB4uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3iuwRU1+KS/NVWssW79dWKSBoETcg2x+W5dgp/PFxw=;
 b=rl3kBYhQXK8xnfFp6mq6ELqINFWfvNjRG6nQPi6SRmdIBAuunDlPMZ1vNuC0R8t5jVAn1oxq4HKUzjER+U/hn4rDoE3fYmabys++xoszeLE9GqOymxTYf0P+PDu10ilBFAXxZM9kQFUQlB4cTB3oTimPF4F1u6VfE6cZhpZi/p6g6FXNfjAEzVbUiQFYFz7NChP3uzfUe48sP/k4aL3FaM/S67f775AQK6/qTIWgC4L1zwFAfDx74itVsiG1i8At3fRcpdYQYG1cP/bU2DsFKN634SxwzrOS/jolIjJiBZOht8kupK1eUkAZmTVrftBsgDewKkulat4MIP2qYJX8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3iuwRU1+KS/NVWssW79dWKSBoETcg2x+W5dgp/PFxw=;
 b=Jb72UUECHDy7o7sMEYEiC5SJrrh8M9JYgors5FHwOCtqb+q8I7NbkOHKJQqFaMzY0OEs4Dq8m2thikuaEcfe2o3VtYJ3hf7pRDZLRSBuSzkDmKeNCub4LVPAbI+ScvxxvE3eBjukrmno0WSeqRpzjtq2QviGqM39P1Am1J/L4Iquxz4Rt24tiDhZUoXngEVrEA4q4pAn5uhJps7HBHx/JD9942t/dHnS4OdEdcoJiv1Rbhk0GgRlXGsBUu/UlTuxnDRDqAHAokUCO05xYNgHzhZxVvDtt5JgzseFnh7L+x2weA5BOulZhqw/ThScJZJNuQZ49xlLZLdew61aULSPLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15) by AM0PR04MB6898.eurprd04.prod.outlook.com
 (2603:10a6:208:185::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Sat, 14 Feb
 2026 15:36:48 +0000
Received: from GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8]) by GV2PR04MB12191.eurprd04.prod.outlook.com
 ([fe80::c8ab:7d35:91ea:38b8%5]) with mapi id 15.20.9611.013; Sat, 14 Feb 2026
 15:36:47 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org,
	luiz.dentz@gmail.com
Cc: vinit.mehta@nxp.com,
	sarveshwar.bajaj@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v2 0/1] Fix use-after-free in BAP broadcast cleanup
Date: Sat, 14 Feb 2026 21:06:14 +0530
Message-ID: <20260214153616.655-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.49.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0124.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::28) To GV2PR04MB12191.eurprd04.prod.outlook.com
 (2603:10a6:150:33a::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB12191:EE_|AM0PR04MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: d8de66e2-ac4b-4062-c3aa-08de6bdedd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|19092799006|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WCgBiFLHB6+W2ze+8/y14ioGH9uIef+/hK35goVmqslGEvhnCADmqAmpzmX9?=
 =?us-ascii?Q?KectR3TN4nryf+NswtAaSFk8LHjI2MM153tzhl+XyAoNIJX2QW+H9zRcVtds?=
 =?us-ascii?Q?p1G1ByHXx7IQugHgoA0njY56xkb1JTWodqNybtY2Awf2Ikb5/Wq/xbYvxEna?=
 =?us-ascii?Q?CN1gdLQHVdIpUaL1UxyCK9/9MCz+rxOONp7AMKqt6aLghvR5JIkyYYDudFJU?=
 =?us-ascii?Q?j5QscOBaGzOnSK1VK2iNabHdy59cZCx4lE52rlp7p6DSCO9Ei+vf8okYS5GO?=
 =?us-ascii?Q?zwjlO6Wz/JJBd+A99wS/j6C9Zpx+tjuo/2nnctQ8mX2eR/aYTD+rHI+RBvT2?=
 =?us-ascii?Q?iLYtRK56TaylITkKwJcfVoTwdpUbqp14lQd0I5ewznG2XIEKXlxHQXZTh9DF?=
 =?us-ascii?Q?X6vd+TUx9luiWU709Gv0O6vi6mCNTzJ/NuHzEIoCm9IrLgrClGrweRX2el17?=
 =?us-ascii?Q?NnhG/L+kJtY0x3cxkQ0YaoNg0iRDAxoR+cHr5GfwskQxa6JwE+v/xviUCH12?=
 =?us-ascii?Q?1PYVbYkjDPawTLhpUMhO6CNwCTxSIOJ2vQFM0zFDZheC5V4szEJ98isgL5++?=
 =?us-ascii?Q?gB0gd14A9SMF+IEn358vZ8JatUf+XrB8PSW0h6EVBvfbLghozaeWTiguAxPt?=
 =?us-ascii?Q?sY5ojCg+8cHDUJ6pV8g1qsVigN2zvXXE9Lg2di+GFZ0rxdY5LTilPFX/4C05?=
 =?us-ascii?Q?1Ejcgp9yw95nJlusjQwdQ8HyzeWOgWC+5ZF8pVysJW5M0QEsXg3dAdn8fqty?=
 =?us-ascii?Q?OmWWQBSC92mvzAsICvQb4BGdLUrJBfRu6+LJRs929xhtmmepGX7uEKXzkMFf?=
 =?us-ascii?Q?05czHn/Pbz2wGaaV0VXU487H8OVgHDxyfuqLdQTfq92o+/YgNEzTkSS5n58z?=
 =?us-ascii?Q?FXSdwR0z0yx8y+ZHu6JekMiMvv4Zi0qmcIpffO93RQA+E6+/Nqa2RZxf8HCB?=
 =?us-ascii?Q?qSB7F2VKCoGmvuc17mIpN3AYtLbm6j7d9AhwtsTYP1Ebuhq1SQ1Eo76txTkk?=
 =?us-ascii?Q?yIfNBLm+krLVolWX344K7JiYrp08h9mtXHT4DP0sCP1yhjL4Gj94X0tRO68K?=
 =?us-ascii?Q?tWwI5I53s/r/Gv77rjc30SbODWElhr6j1ZjQ25+fN9An50UDI3fSNfXiAXz1?=
 =?us-ascii?Q?LnNGU6EeZ0EIlPMntgN/k+/k68Gu8MQeNEOKueF796ZErTw7rY0X6uZeApNh?=
 =?us-ascii?Q?PWiMzC8kwWdr77qKnwHBanaXqan8iYaDgE0NeElGrvRfgjt+k5ul/2nn1yJU?=
 =?us-ascii?Q?LITLkw+Pn6sClc8mrPx3KakP+nUm/g4tQabjvVGHghmqeHhpGM51oOGF4bm1?=
 =?us-ascii?Q?KuG2KE5eTsZEyn0frLm1oYL/eHO6fEb0Sbeq23bHPmVpbJrbz0ZoKqVwiDrR?=
 =?us-ascii?Q?1qbDttauo6RlZf0ybu5wuviJPJFr/eYxcuJ6E46r5SuYCn6c8tgLOEb0nSBX?=
 =?us-ascii?Q?pYlTkFr8Th1rbBAvd0Ll1lm+oq3uWPMqdGMreMG7nSEQw8dU1vABXSEXnBlV?=
 =?us-ascii?Q?vps6VkDDcIBQVdsnFFY09vZnefEFCYgbaqyhFKR0mT0TOPOLkR6k4YOIEalU?=
 =?us-ascii?Q?FuuVJkz1KqlAIZyFGCtOpAfiakXMyEpbHXQfUTLN0a+RFlg+LkWg4Rnavu6P?=
 =?us-ascii?Q?cAh4uZXLDxxVhr2OFDtY8wY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB12191.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(19092799006)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VHWZM9ZBn2+2oHlt3srCRZ07UU3b+I1bajF4yVHxoIdHhVFaA5GlmFp8uWTU?=
 =?us-ascii?Q?EwP911hxfvSnZztdLcJPgVAK01fLKFN4u5QY9WGEFPxTN4LzeV9C/tmrFKkZ?=
 =?us-ascii?Q?g7XlBSdBEdliF5gIZ6FuOTSvF3Rs/Oo0BtTmLmaoQ9Eg34v8wqVr2AdwlAN1?=
 =?us-ascii?Q?nRsYvRmHm8mZ0KrjVGBsw4muj58c5QSkdTEZ4NLd9TidghjaHM397lVdZf2h?=
 =?us-ascii?Q?+vrO8cdpL5Y8A6RznjPLCAjRuuxZbWeD6COQCc8c9S+D6pECoi7TzDBc46Km?=
 =?us-ascii?Q?VtpU7BtAn62EvX+pOhYsbEDyEzucbb7V9bAa+Z+dZJ7jf7enAadIz4lLaX92?=
 =?us-ascii?Q?ZjDSg0zawxqBRIzQ+9BU5A9H1nxWzV3E8SgdPfoDBztrQK3wPbo/uMoB3TQe?=
 =?us-ascii?Q?iTFVF4wlgtgMKifbIHKULsBbeCVuxGDjSODMMJX32YO6JHY2SEmCUWjFh1lq?=
 =?us-ascii?Q?UVbcHE+o7OYjDlZG9w2KslwvH9eOlG6teSp9M25nNBbPnn63YT9mtuCrcwuz?=
 =?us-ascii?Q?4WJq5p4BiglyGw0AepHsMlca5LZwPepXhCQteNE7Xo5otPY6rZh8iYg6Nrgf?=
 =?us-ascii?Q?SSCA7tS0pUHydQ5qRM7tBB6tXmKYudZTnnkA1PBFlE1Hj7FEmLs2yqgxdnqi?=
 =?us-ascii?Q?T9mPYizdO1ki/Q75zVtpyMlB5LioOowqIbuicjz7uc6/2tG0NdIpb8c0pojn?=
 =?us-ascii?Q?Ywk7TUonC3uQoymTJ0WD/g0jYZPZMx8f7pcbUQdvwG6ibYrmzpj3YMxBLwnW?=
 =?us-ascii?Q?jblxitmkIOnpm5jQcAd9zbMxU1lpX64ocAkSh9U6Ijnd/BsyskLQau7mr6rN?=
 =?us-ascii?Q?LcFDivJ7dEu1W0D7/usdFgAiVlWCXjPwnK6wss5j5jHVfOadIcfzL75r0KOo?=
 =?us-ascii?Q?Vz5KO+mL0OXJgAmXaRQnlrq0Lk4JRJNIGN08iumB920Q58Lzhm9d3phQE+jJ?=
 =?us-ascii?Q?LaQ1i1FRiYbLyc3b2AgDLXcHMRjM3PbLcR7i01pA+VQoxQDF6ZBbumdOHWrb?=
 =?us-ascii?Q?26uRrh3OStUxA07aG3JgTUrxHBqb/vgMQeMg3HJRC21IsglfmGx1Q2VA3iHr?=
 =?us-ascii?Q?8IeV8OlJBWY3NBGI9aoD+3GyIpAg7FGyHEmqihX84huC+AV8wUhQZdZEQ81e?=
 =?us-ascii?Q?7L66VjxGrloO33WAR8dkl0Vu7wY2tux04fwEw0icQ8JJWHxtI9EfkSSWSycu?=
 =?us-ascii?Q?PK2H/c3oomMYzCSIExInnMGkVRmr99aYsIXcP5CIhQWksNYuO1D3+KAPGO0n?=
 =?us-ascii?Q?+bolp3fC8Gic2bUC2UgseKZtkw55bbwmq1wQVLNNDhFpEdlshuyUJ0CGhfES?=
 =?us-ascii?Q?WeHeXsqMoWddh+aAIXfNVx7OAP9P0Y5+HX9kQD97kRX+YNrNslA0uKUveiIH?=
 =?us-ascii?Q?lE7vJhOI+PNZAD6F1sv0ra5nKcHfkDWRbBZhAxyd+9sIAeAViZXqrN4VZfKm?=
 =?us-ascii?Q?S2yzOZruDCwlkecLLnsoccL9dI4aQGDylg6ySEYFvp1wIzfAQ3ArSNUyZ6Yx?=
 =?us-ascii?Q?2gv9T99Pnw+bMfnwlYP/b6WDo0OCH4bgY/xRZ0tDpTOZBcYR9hdYK15f8ZmG?=
 =?us-ascii?Q?aWEOAs4Vo5lox3uEdT0iUogPRtqg68EaNtaYxHrDccHvv1S4PZ7W9vHKfUWw?=
 =?us-ascii?Q?uOXqh8yelVWCi2a/scIWkqbiFLoi/OgOr1oGcJrDAf9pLzCUugvRC4UKtEUB?=
 =?us-ascii?Q?oev7kNyZaDfWem6Ruv2+N5IkhjV75gQTakCa/2fEnrfb7lQWMNIfoE1H5e+3?=
 =?us-ascii?Q?ss+JDjOeM7zuN3ngwjvmSUDW3WfXE7g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8de66e2-ac4b-4062-c3aa-08de6bdedd5d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB12191.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2026 15:36:47.7298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vnXl/uuqHdrphbn36Uwr13FspQDO+Ye+0XeSkaHRNsJfbHx56BxouU7SXjMIGF6Ix+uNeRfuUrx0K+431Nk0jRha1QFmJRYdcMV3MKXgFYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6898

This fixes a use-after-free crash when broadcast audio sources
disconnect or undergo RPA rotation as reported in issue #1866.

The crash occurs because bap_data_free() was freeing streams before
destroying the broadcast sink setups that still held references to them.

Tested with AddressSanitizer on latest 6.19 kernel with NXPs
controller as broadcast sink and Samsung S23 broadcast source.
No crashes observed with disconnect or RPA rotation after fix.

Changes in v2:
- Use safe cleanup pattern to avoid nested queue operations (Pauli Virtanen)
- Apply fix to both bap_bcast_remove() and bap_bcast_disconnect()

Sarveshwar Bajaj (1):
  bap: Fix use-after-free in broadcast sink cleanup

 profiles/audio/bap.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

-- 
2.51.0

