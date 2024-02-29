Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A516065A
	for <linux-bluetooth@vger.kernel.org>; Thu, 29 Feb 2024 16:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709223697; cv=fail; b=ixurQ9W39mZVT34xS9GZBtGV+1esPgqHH5x5k6sVYKLPwkg72wpSQcsUCFSfsY/BS98c7WFXXfiIJcMe3wsnUBaYbSB7XA2c8KiGMZGFMYb5P99qJB2l1rZvaF6FMJ2t+QuADWvgM9gPgKEDGHXFAj0kQRY0m0A96n8s2JUrMKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709223697; c=relaxed/simple;
	bh=MYZ5biLEu3I/cZnYCO/3zh3tqxSVT7P+r3Fg5S5ZUbw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=lY86PHRfidjLvhNOIQSDdvNTADI5iEXDHMHWuFtNC17uy/wvDpHaIJAQIhJZ5SlYd8prY4uDADcWsqWqYHIrPduI5eauTnFf8F8jfsat3NPbV1zmB3jereEp+RnVO+aUnvrL8Iq+/gdmCVj90/rV7nHEMMhifKDisnJVu1YaHW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWKlIOTc; arc=fail smtp.client-ip=40.107.7.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWKlIOTc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jDoO+JUd5GgQfviT1ituEQ6/VYpeY8z25uMA5LFmV0h+JKW27mW/4CPXo9mLq5opxYFYTV3+qcaZJp0uw3dGdruYqvVM2oeIHLUr2aZH/83WeEa3ZB45FfquK9LhRVkbdiAogTsYsZ9IzeDJSQLq6GRKDo/LD+XFGWLQ9s97/kUUrWRuTkzXf9PawEvfnaNsTAp/C63hIMQUxAFnvPsqXWlBPdiYrBWW8pRtgbIohdMnb9dVOuUKusAEUFSUvb4FLxzfiS+LxNvJru+mZrXTnIQ/Z0xJAuMq00z2n6dLqDOMw6ZG2re+PAyo8PgAtaYZ4R94+24IBOOXRgc/gd4YBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wy8DDSbP97EZrX+g5eIpkX+E2RlQ375NRt6j7U7srXc=;
 b=eOmHw1GJOo3L2JK718B26MTYVF5T0wmacbWJhYPqumD3sX3XtSGFWEfBUaMz2g+48rVc9sSYZJyGKxm15qnQGUECTgoz7ySO+zXJurHtM3/lH5t2NVpPbrs514HbU1JrNMuwp7wDABndDPOV1PvLAFyGIdQqjcZ2YotUzpUMZmIypkDaUXb8+5XeRWkXmhHc3bJ5FUmKNxpW05mC5BND9DhIody9JqLPTbNq9snbKErJn8IN22HXKRubyecug4i9h3RNcYANNZQ/WGu7t5X1xOv4jfQ8aDk0NN0yxzj+XO95EbiPunCsmkOF3k6N07rSD5c2fE/IFFD9ZEfEuFjQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy8DDSbP97EZrX+g5eIpkX+E2RlQ375NRt6j7U7srXc=;
 b=LWKlIOTcOhgxq8BUfltyZi8uo+xbBdcKiqAFVKcKi73qo4ZAj2nC/I/i+jv9X9MgPIG8njrJDYa6HDefGTKCQl1YHBS4W3IS4qIwErTI7wKQShi9qtHIptEjk2BQ+dF5jBzMwRnT4SzgFR1IKGcn0pk0bJUxFMy1ZXCPG4hc7Zo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by VI1PR04MB6927.eurprd04.prod.outlook.com (2603:10a6:803:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 16:21:30 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%4]) with mapi id 15.20.7316.039; Thu, 29 Feb 2024
 16:21:30 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Add command to create local endpoint in bluetoolct
Date: Thu, 29 Feb 2024 18:21:18 +0200
Message-Id: <20240229162119.57523-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0025.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::30) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|VI1PR04MB6927:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c98f0d6-42f0-43d2-9113-08dc39427cf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uvNo4lLviIqGlkdtPdQvsag8m+i+bdviuEDJE22JedUqQAv1J642nZWVmeOSd589rCHLtXlKL2HJU5bQM8hVqRHJEcg0gn+8ZG+zktVvF9npTU/PAoroVYsWfUfwCWw7KkVLFX3W4vMYPxpbs4O3BavjImlKKeqAIZCNP+WEHrqdsVyhrxuoLSRl28rsKqMOBN9s9tG0jtJmUNK2WZyUsCWVEoDof2QIbsxZaezXukyqMqxsi/fSGG6cuiBXJpfnMIj+Mj7WihwVAQgEabkU1OqYiOR+CsS63L60Y7D4sA+Vvo4I4RyAndvnh9xfz/lItwREBFTC1qLEeDY8s5JUEmkAWdNrjqf/n83B0JRHIY8wS6prw4cyBZ1Lz0PTPvtlLtDpLYjxUur+F4qT+jiRg4daefbcP2OYe0MS8/RLRyb+vGfIKH7LrMy8B5Ns/ahNNQV/yY9JSjphbm/tFD1fqi7ED4+nGWoKaD+XmtLDB+G8uSO669USnPz/cZ6hHK6olo6JnfFcCANBegs0Jldj4BA/aScHIH7W0MzuqXAlqwexbSDYt8UzhmBJ2UflADlc2U6fHhgv1kpuKT6f8D/mxM5I+9Rh5imfRkp+oPlBmRIrc/BR3OJojx2wh29d+PHP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r8hW4BBswGu1J6pDEHLTWxRYEgrJGKRnFdH1U9+PN5nbqns+QGpzXdLsJIwl?=
 =?us-ascii?Q?keNQZ/eDhlClvyJTgZaNSWiSZZm0s8DQM5R5+JeFSaqFTBam979GEFXgW+Ev?=
 =?us-ascii?Q?aNKeaxvsR0t3zLQZL/3pk3W92R0eWkjWugAI9Lvawoxe827UzSpMTamVwnqM?=
 =?us-ascii?Q?wmezSq8XnZ6aZ4KmifTJSADppTpkYcs3av12YFr3KM3IkWyTSrathx+8vtMC?=
 =?us-ascii?Q?3uDTvc8xy6cx2so4Arx+CGTjzgnVyhU9wQdzBPgBQm3qPbq4W/7AczXUK1BA?=
 =?us-ascii?Q?GXLWE299xWkfaD91Cq8+pmSRZsYwWqTYlvQ6VIK65QOvN6WS1cxEVm/yYyvy?=
 =?us-ascii?Q?MkiPv/I8OcPjUg+R6HsjUHQeKiOHWX03MjfIE/jxMfRLmCvopVknIsx/rgUM?=
 =?us-ascii?Q?+TWERDEMeU80xbEujNDaPocarbYnuMZoa4/papyAVux/CqcY5mOR+p4PZo0x?=
 =?us-ascii?Q?SyUZcw8mSRSFK7HJHUo8qIDjOoKZbN5c3QCJr6vMD9m4YIPAWgQs2yJ06QF4?=
 =?us-ascii?Q?FkG4rR6SdW1pwTzQlac8oEu3yaBJ2RwCW99tvhtU8yfNxC9m5SK4o8WrYYYs?=
 =?us-ascii?Q?fKzEENztXAnllFFY8uEN4WGsbJhyNNrNAqCS8fFdnVpYVfKenf+PMge+UAOG?=
 =?us-ascii?Q?sf2QGCarUOi6zxt7vSeuDa1ye92x3Mxjz8l3gjq80fC+/V7TPTwXkQFWBIa7?=
 =?us-ascii?Q?j6mjNyt+Ryskm4Y93etBURsz5K/0Z7TrCIEGbiSo7Z52DrYf46+3GPdMX9jm?=
 =?us-ascii?Q?J5xKuyscNQ8ALTyHvJdhVanLiHHCgJBOoUEyJm7Or8kj/tazZnEJvyyhEUzJ?=
 =?us-ascii?Q?Th3yx2jaYupP9Mjyty4ZUIL/KrAADR4g3Z4vPr/WypmUf8m5GByuSFrA0uaZ?=
 =?us-ascii?Q?u6GX7n3bkeJpWyeEYnZocWil7kEutHpCgpB4yABzhkLhDFOholzo/FEmBWwM?=
 =?us-ascii?Q?Ohzv8Y83MWpJsDNz/75DYW1DL/ptFTbxAv4waDsE20ikW3tgynSBHIiPJs0N?=
 =?us-ascii?Q?kqgmtfncC9u5EHkl7JlpZR2z0MXbe8RKr+XjEtXw8GwUAzpkoG7wFdpKD792?=
 =?us-ascii?Q?5PnvCiwS2Kjexbvz4BivqaXVPEtScwvZ/He8N3EVDm+PkEspRtMbbMetAIe8?=
 =?us-ascii?Q?4h4Rrr9gyOXQpSpPx7bf0cArNxkX9pdvJq5YpR+U2wgQVXwH7L01gdidJru0?=
 =?us-ascii?Q?NPViX326h+4gmjWTMGmXGxx93g3D4HmY6WE9emvCjWOkjdFUc7flGjJuhwCP?=
 =?us-ascii?Q?GqhUQ3Zd8oMWTPWZu1x7T7VxDovczriYsN9HYhFYWnbL/gVEAD4kgMnZu7yp?=
 =?us-ascii?Q?f88gJ1OnooWkFnesloUT65zGOibR0YCdmEEZRmiqu7HJZypo4/sWYfQ3N10z?=
 =?us-ascii?Q?JREEakuWIQ3NyhswIz/ZGCGCbDBGTHyzdtcE8Z/V+8j9GTW67fIJF1Y6RUkB?=
 =?us-ascii?Q?5aX4yaUnj6G2qp3GQiY4k1UZw1X13oZOAnLUirucDNY0YhP8oO7Dy7wU75iM?=
 =?us-ascii?Q?V/U5/bVcQVWa3nQ1ILfManyyrCKcCIN8NgWs4mWUgai9DEzVzER912z3WzRi?=
 =?us-ascii?Q?2pkHf3UT10H3fcewZmQzR5yZAze9IsYrtX+B7l/gZFxYZd14ttxtZRY5158D?=
 =?us-ascii?Q?Dg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c98f0d6-42f0-43d2-9113-08dc39427cf7
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 16:21:30.8054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0bRcrIn8IUVpwuExRopqdiJbbPJpepRg54AB/L58BycF8alG/nr9zw5wHBpOJAGSjdzUOArUwjkMRovvqawq8/9h/uJKxAEmFeaU6/BvGyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6927

In the case of using BlueZ with Pipewire to start a BAP broadcast source,
Pipewire will do the register endpoint but bluetoothctl is still required
to configure the broadcast streams, but no local broadcast endpoint is defined
in bluetoothctl.
To resolve this problem I added the new_local_ep that will create a local
 endpoint that can be used to configure the Bap broadcast source\sink.
Example how to configure a BAP broadcast source:

endpoint.new_local_ep 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1

Silviu Florian Barbulescu (1):
  Add new command to create loal endpoint in bluetoolct

 client/player.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)


base-commit: 92f3ed1879042b43033241049b334404229df88d
-- 
2.39.2

