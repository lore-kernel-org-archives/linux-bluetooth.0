Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2046.outbound.protection.outlook.com [40.107.21.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8FE54BC1
	for <linux-bluetooth@vger.kernel.org>; Mon, 18 Mar 2024 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710779954; cv=fail; b=pjbLrEtHUWD10Bj+t16RIlNPVI7ans1zpLPqKE64ssixKnya+QpMZCjsTezrrqMyvo0FC+su2nI0Mea74UBMwbMVCjlSvBAbUqT2a4zVpvhuO2L+wbSUqa6xCzvfOq/HsuutIvWiIl2DggwRGDut3hCCTsLj6S1ooBe+qVb1uGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710779954; c=relaxed/simple;
	bh=diZcbe/4DVTmrhAcDKRHpJ85BKSl7dS5TNNAlUnXjQg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lS/P6/L3yvWRWmi3Hj6JtORPGwA4C4pnXDA5x284iaXwJubyvJrw0Si9RnYoi62xxgdkwBo3gSp05M3BelKbjAZdPSRMkFIfdsz13igKTYEkskNFg5Jh+HYwVsisZN+37eNu9Fnlr3nNN/Q8iPUixGln0dJrc1j00za4ikGetvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rpCVQP8C; arc=fail smtp.client-ip=40.107.21.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rpCVQP8C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i1c23JTB2aCSMfPTDFzY+Dbqn2vflfeoH2QVUyaPHHeHAxy/jw+hAxgFCLAA7ltcMiKZpkDsfyhDE69L876+66vdSkOCbrHB9BJrcH51hAdnkgYivM1r/+MpawP+tRNLD0H0bYo6CP2qQykn/9yVCqewBFQcZJmT2BIEGBwRWkXeZChKWoew5kKlTVinVu03vx9bHF8GFwv2yv6ZXhQqUjizDvbWWBQsTjkbeeVLvEx1IqG9nrl3vdj4piwiuJ1t/LVawunFDdAhCyI5yiZKrMY0KBKc4qi9k2xbatYz27nKdZC39f/2/1Mh9na65X1zU4uFv8fuuqImNg4lu7ntJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NdPRj07V4Nvi0AXGlCGhhGqk0UM3AgixBMBG/fYMU44=;
 b=BFjJ1v4AnOHkjAo7qKxdpovgqGfPhokwyloYMbsduAVL2OI56rmMprpxh7T7sXTvWz8tPBzauyfULXRk/vlQVcoC+jpvl2w8kX74ZxH6Abl+il4snWOLDOyr3DJSGeDzmCC5PETw65cRkOkhJxVUbNGn3dPFjrDO+G+bQZUZWAJUeO3ZL9/WwJTj161a3S0R47XTtikBubijsAM1GeQUANJDiTTADIlsu2MNaepWZt6owswF8GJ8rjX4DwTxzyDSt838rwV1Fsh2P0nCCCZFQxaRi1J+Yj0Yfr9vk1daosQcHvixged1PZY4/dV6XjegINlSVA/FYjoFncU6vvJ24A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NdPRj07V4Nvi0AXGlCGhhGqk0UM3AgixBMBG/fYMU44=;
 b=rpCVQP8CTFW6ngQ+RD/kquwQNQCGvAt21qvhxf/OED1jQ9irUZMZbJCakutVg6R2u5NfI2ydsYRc1LFlHRUIavbZIVfTIJ5hjWYVn+2JjzzImQKt7uggTolT7nM/Qrd10UsO48j1KT5ZqubE+9QKtShqlyHg7HBddOtJAQ1K/v0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DU2PR04MB9132.eurprd04.prod.outlook.com (2603:10a6:10:2f7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:39:10 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:39:10 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v4 5/5] client: update bcast source script to support BIS reconfig
Date: Mon, 18 Mar 2024 18:38:53 +0200
Message-Id: <20240318163853.68598-6-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
References: <20240318163853.68598-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::18) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DU2PR04MB9132:EE_
X-MS-Office365-Filtering-Correlation-Id: 676a414c-f9a9-4dca-e31f-08dc4769eff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8HiAh54MKMohmfJCpsMxu23hbipZYqyRxPqLffksqpLM67vAUD8A2vxGrK/zQo4sODlceHew8U4abvlsjx85ezhoYPndLjaPCKJkeqsXWgLrcw+HXANtNeA47EPckHx5wa/mJq03Iaa/77k41fEKGvuCOHRlTUSFwjFEayEpcWEW+uonn60lYteA9VC91cQYUw6UTrdfasN/AZtmCojdHtypp7bb/FDp39HFAlIt+QKXN0Xwi09HOf2YmiTwJ+7deSPCA0ZAquCdG37NViRl/nxL5Vzg3UVEY+F7/diSQavnmqzNkUmg0Q62wyTas3hjKS5Q2mH1DmuGoJk3I+BmkBASr/25BZmxhuMjkvfbfhFOvos4X6tnyG7UObC3JnQjS1aYWqCAEKXCymZ8B2x9s5nBe9L5SDTbiCq/Y/gfVkGoVEqZw06yo+3VlrY2VH67OBdS8NE2VxYvmKoAk9hr3U6TxMrhH6B6o/mryA+p4igfRxm6LPK58oGgeSMpK2drxSMWU51BNb8RYgccuGWqX67y3LEsHgdBJDwHy9f53rxVCQMaxkDzHDo2QNS0SYD3USdEUAiqvCHzgFmNDXzd3z7uk4BYtXNofgKykeTVg0raOH2S6mq4MYsl3s7T1SoUzp5cek8T/VBTVE0SG9V4IqM6zYZH3I4goATVbQO+ACM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?15hrRseMgFEYYF+8dmB6KYzfEgURE3uQ8OCpCp+W66gVOgRX5mk1qPFq/R9N?=
 =?us-ascii?Q?zTyHxnhBlpV1WBC3jRSlehq/tz1gh+CI/zI+MvZPf2bUP8bpEkiWQ9BWtB9y?=
 =?us-ascii?Q?OWI9+Kt783UmnDFSkjL4uz+6MThmwYFlz/nx7zrIVc3GuvMqEQ+0vLBqKVKP?=
 =?us-ascii?Q?otQKgAgQbyC+696mK4H/z+LAGyOFz3thReJadCBZYmqemAo2Eg3VAMqy7UwS?=
 =?us-ascii?Q?vRQOomnKPm9mPoOcIM37MZd29Ikt6BOqfpHuu5RUK3OObG3Ts/uggYKJ2tMP?=
 =?us-ascii?Q?sh/Y1TTtL5nG+nE20QZOkSp8ug+VQiaGttfsoHJecgK+49SIjcV4K0bTxOkR?=
 =?us-ascii?Q?EJp6BLJQxapL1PVKJEF0Kzd0ISgl90KuMCYQv6ftHSGSStm2Hlx1yIlWd9+A?=
 =?us-ascii?Q?2wxuR8AtD+ZOhgRgfFrcUHs3+Usf/4Pa5WufcIdfWq5rtq2PgmepG1DcJ1Us?=
 =?us-ascii?Q?yDMCUZF3eUi18JPPPmy02O+WSIrEr7P48w93phjVcL2qXCJtjHg+5FEOWzX5?=
 =?us-ascii?Q?Qi4OUATjIGLswNayTu4/TBoF4zVF6USE+PoE9JJBnAPLK8zZT2N5xx0tQDoW?=
 =?us-ascii?Q?x5OOkri+aLu4LwtI1ujc50P85KctmeX+LbiphrtV6uD5deNL/ll8URAN17Fp?=
 =?us-ascii?Q?pBKF6tQfHn6mVxfBXGDymecSmrA6suid8aSEPlbasP8pVwsIhkTqOVtX35os?=
 =?us-ascii?Q?YMKyyxo3U1R1h5bmwWv9vX/RMDcs8/IhPXcG7X+DiYpRHUM/OzDnrfTcRjot?=
 =?us-ascii?Q?vC6TF+umaUiUpJNPnkxZ+EaWh6dUdEamMARWs5yXPb0dKboklJyM3VvwF3Jt?=
 =?us-ascii?Q?zDpw3jmRIvJ6v00b1hzy7SJdqLJNjaEHkiVoZJuN8aQ2wmO9TDvg+UHhlp6H?=
 =?us-ascii?Q?0gamCToUrBnRDD36QAQmlnguNKbk09UaofsUJEyo3ehIC21btur6GRFiT+kr?=
 =?us-ascii?Q?GeWQGOujPKyKMjlJLb/snis1N7LRrgV91o3ue7TZ+zBDm0Hri2nBc5INCTZR?=
 =?us-ascii?Q?BCsSNLnPhlloZEqb9hrb3YgrNXHYFfUwo5iB41OfPbALZYUpJMM2QC07pHZB?=
 =?us-ascii?Q?H3/W2ACgOhnOWbj604e17RAb+xvv9LSY0Qx1N98OpyYpoFMC4KMmLskiSMwt?=
 =?us-ascii?Q?65Wjy4zNIaxAUwcu2RO5YwRIJePaw11vfdboreYc7X/6Lh20pdlju1pd0gwQ?=
 =?us-ascii?Q?L+upUd86f3yKPSCJ2Fyl0tqfeQESJ4mqWjQuESbiSuLqHD57QX6by+XxVAuQ?=
 =?us-ascii?Q?V7lKM139DciTw/xKw+XpTupb+ZKKXnhv8oIVAsQEO4jlQdhZvP464RMnX7sp?=
 =?us-ascii?Q?RvItH2cDsQjPqlW4NkmFL/sCZ0V9Z82kVBSuakAT4QYSrf4UsuSCHxf6Cb5j?=
 =?us-ascii?Q?3f4GgqU3PzEZR7+HcG7guNuI/RTVC4Qk0Tfr7EIBinUrARp4Xxkuuho65Nuk?=
 =?us-ascii?Q?zwoqTPDWJZijcoBimUAYGSPQsSDNZLFDIgXwVbBt6DS068yaTDJZWq8G9ikL?=
 =?us-ascii?Q?97PudFoYowK1/kPz5xuJwOFpWJI1OYF/LJJfdVcymoy6FrK1g67xmVDTHCAi?=
 =?us-ascii?Q?39Ei3Yh414JtuQeROq3YMkQSk8107Mt2AHCVjb2CjKOBVVsmOMPRRO69CkEP?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676a414c-f9a9-4dca-e31f-08dc4769eff4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:39:10.3913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RsLTaWYP5BBAUjFCB3USHupsjagYdmDpE+Z4Fdj6nRgwFW6snl3RotajGozqZ8ahxx17PoM39vw3GiduRgHccfLzDOT7rEITa5O126vKadc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9132

update broadcast source script to support the BIS reconfiguration

---
 client/scripts/broadcast-source.bt | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/client/scripts/broadcast-source.bt b/client/scripts/broadcast-source.bt
index 6da9e23e2..4fb0c3920 100644
--- a/client/scripts/broadcast-source.bt
+++ b/client/scripts/broadcast-source.bt
@@ -5,7 +5,15 @@ a
 3
 4
 endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+0
+1
 1
-3
 0x03 0x02 0x04 0x00
-transport.acquire /org/bluez/hci0/pac_bcast0/fd0
\ No newline at end of file
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0
+transport.release /org/bluez/hci0/pac_bcast0/fd0
+endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 16_2_1
+1
+1
+2
+0x03 0x02 0x04 0x01
+transport.acquire /org/bluez/hci0/pac_bcast0/fd0
-- 
2.39.2

