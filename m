Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062.outbound.protection.outlook.com [40.107.21.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253A11BC20
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Dec 2024 14:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735050294; cv=fail; b=OjS0MPgenouLvSqpFxZEdYXrTAO02CuORycsx0KLfS1+DcQEipJd/++11H6f4MJAcY/zLTPqGQCuHIDtmW3Cm85v5TK0dG0gWqbYR3jzGSh7CsEeoH2ps6N+9ItJBP5R+RkbgHsRkaDeR0kZwIjr7TwpC3o9jVPv/pY7DXolZ2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735050294; c=relaxed/simple;
	bh=kxhiHN0Ce4Q8AGvy7plCHtEU+dAJqYjPWNj3ld5rbX0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kqxaIeJ4DaRP0rd11G6otEk/YcyFRz1Dgy1QY8xZojS39SrBMvzYJeAdYjFHSSw3aIf4yHMNHlb9dIeyIZlkeO66RYS0lCX1p3NiU2NPQ55otAKtnJodYiYF8hdbqDzZGFssBfwQlPS4ustNSCLd/aFuhheHa+coazim4xoeCIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HsSKlTzd; arc=fail smtp.client-ip=40.107.21.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HsSKlTzd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHF4z5aq/nXYiML1tEtGD6SQUWh1Hd0p+A99JiLTAbYQNP3YULIP5V6CUKFsLk7rnWP8xr+i7KBsjnIfz8cMvDu8j4TeBY7NiV/Zq3RU2ioI8RlF+L4J+knSxcyPbY2bxRTzLH5P8Bo45dvLM4/duUIGvmH3UIt1R4/dpHZG03lO5sDd3oKFhYwMSZuJF02NuvvNLHkUZS/4zYwu7t10llv3EAqU2/8lHp0E8df1WBvxRK2DSsBwtJ6SmUwOTiKfiiKLZsiMg7m5erSaCslL2CtAhpuYJllPnV8KWSzaeIl5+XUdqwVg4EAA5+9uHMxZ/MH2p8//0aw5ZofIk1nLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18XjSYvUN3dYPM6BgzyWbgZ85p+00pTjA57OEP01kP4=;
 b=lYibRxewcmJCuQE2GBovMfyG9VhqBUx/1bZ1zulhgKsTtqAXmxAbqFcFHGa1OQWNtaryrAmUrKTlqv57xrlH+2PvyK842BPp9MvnQQG6MK0lMHNPEBAmun+GENRAv8a/1MKdIZ7FbHNVEfJ0RADZzMcTq/jTxNp0A05Ay76Zu4VVZ3AaBvlpNPqGc5RZSFw+SJb/RalH3NbC/X+3qsN+m/PA8dXq99XyN2/+VUK8Oous8D4i5aI0pbhgxvZ8JviDSY6NMt8ZYTBh6OfpvcxqN6/c3ChEx2yTMZxlZILm9kMYZsk9lRcYLjGVNbsYlvkavOQyeurCLbwyRCdU05PEUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=18XjSYvUN3dYPM6BgzyWbgZ85p+00pTjA57OEP01kP4=;
 b=HsSKlTzdvTQu5K1fhUXyw/sTv2HSiopQQ7L3UJPniQy4qr6EU/yEUNqs1iL6s5h4qDuZAnHjJ5vzB+M+Eqdk/hb8WqBPgxSRuMUmnfL+yE//h0KP76WDJHd/RYkW3069hKlysvWAzlzfnL99C5MRZ7Ap8IWaNnTqdBHtvmzzPuI6A8uSCBUgclY2mOFsiP+mplNdsENeke8DMQYClpvij/BBCNs9hA7bC18BB4V3hot4lGxMORfaZtU6BYqguK+i1p2HmUODaWPV3BY/raxd/Pv2BL2SFnE77YSyWrbm/2rMF/wntNSTKRivSvdS5iXezMgFDbs12hxEDgZqdHAO4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by DU4PR04MB10816.eurprd04.prod.outlook.com (2603:10a6:10:582::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Tue, 24 Dec
 2024 14:24:45 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%5]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 14:24:45 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com,
	vinit.mehta@nxp.com
Subject: [PATCH BlueZ v1 0/1] HID device connection issue fixed.
Date: Tue, 24 Dec 2024 16:24:23 +0200
Message-Id: <20241224142424.10572-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|DU4PR04MB10816:EE_
X-MS-Office365-Filtering-Correlation-Id: 45c4745f-c119-4923-a9e0-08dd2426b6b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?69qrVSISVhf9TSpjg9tZQ2zCNe7d/0Hq94MMjIP1Zrdjz697+zo/nT7cZpoc?=
 =?us-ascii?Q?uJpv0yhRh4YZhIy12OvhSH9FNXho2y1lyuRvwjoZuimXvjG++TeX/XJmcMLq?=
 =?us-ascii?Q?BlAE2kAAN9/EVFhnpveYk8pWvgcTQvYXLtmoRVTJ9ISHTceFYfYlV/NTE9L3?=
 =?us-ascii?Q?HWtuAujT7IRKhgd0O2ZyXfNHwTk13XU7wEA+1O1esHiiIasgnI/h/Ceptgi+?=
 =?us-ascii?Q?7532yAQsF+UldYBAKZHT6c0dhWSJeveeSYnoLcD0WvA5isnFMmTM+2UvGdrz?=
 =?us-ascii?Q?limBSE99LwSwEhXPmhfVeID1KmcEiXL06WVpNBf+cyuSKmU6wFq7cPupEasB?=
 =?us-ascii?Q?IFHl1XKWKP0d4LHm+9PGYeevRTbOBglQm2x+ONbmxaUXB9P5pMLwait3jlp9?=
 =?us-ascii?Q?iS8cJghtRSDe6+WPKeDFupyxgho48fn5BAB3iO17u7SiQvBDjpcvSyx+X7mq?=
 =?us-ascii?Q?pUyjn3sxHblfLwWt9EeMahzxN4GOWUm63cGZr4BSp+MrVzjiIx7J0ogG5zcS?=
 =?us-ascii?Q?L1DdM686POMM/2fS4WDAdueNCxgvc3hQFRnTO64Evux9qVW4YVDt/vOaPZj+?=
 =?us-ascii?Q?e80euzttMQViqj9jhIOmWYJLuEdFqKmd2hQggQqga2pNbvqV0b/lcYPI4sg0?=
 =?us-ascii?Q?MfAYK3h2KPq/+I1yX7C1JD+KV3QlPEmo0uavRNXEzUdEyA1VYuwDR2khMWcx?=
 =?us-ascii?Q?IIINnzO/zzzPUsYjw8qfdgxKvcFXoDvHE99KmA9Xxo2qC3lGrRLZbsWPjEX1?=
 =?us-ascii?Q?4TZQbZ4jEyfta4rrqWDISulGFjMpkN4tSNw+vG0ZZCjYa2G6Edptj1/se8+5?=
 =?us-ascii?Q?5poH17PyX9ElElJWN9m4uL6ynTjtyNmbr6OD+WpMlixRdbjrWlpx26ME+liH?=
 =?us-ascii?Q?7B420EHxu2dL1utznQfQFADj2vkgonHpnWdtIY7OdIxa39Xys+/ceTEgAyr6?=
 =?us-ascii?Q?V+38Ortf86QvzHUnlPv+JWTafwDU02sBvv26RdDz95SYy0zERG1+xsJ/sT8Y?=
 =?us-ascii?Q?0SIb507OYobp+CJYO2Q2hUs6e67W1dz4H2hW0dgewLkMAAKBoAuZMIwy+1gK?=
 =?us-ascii?Q?W1cuW5yowGK4gWxekpy6ksucrkIG5e636dNzNtqfCfCLmOsAnKg1eYmJ59ld?=
 =?us-ascii?Q?GRRhZWg5qdNos4CNV8mlP0wY4FvLLsMP8gweXx9BU7cCBPbSDoYxwyl2lcXT?=
 =?us-ascii?Q?nBi4+zRxPhEM7tgViylCfLVr+oDo/6jKXLkZ56eMjH/Q7Qxukb9RnBWya3Zi?=
 =?us-ascii?Q?nQTjUGVv9CIPVbEa0kxh0TnGyQts2j7ZdCtK+XIpPDCAH2Q9RJZA9S4p2meL?=
 =?us-ascii?Q?RufS9exKHXlt0hKetY+2kHwvpUJSnDgKqU6d4DQhPQEt9vmcfX9ym2uFPBj4?=
 =?us-ascii?Q?xnOZVnVliEdzOCffuGdyu30zHnzwCL7C/vm9DW5l/M/IXQUb1PsfH5ouaAoQ?=
 =?us-ascii?Q?FBFvMmcRc1oKz66RgoUcPbVXL3b1hxm0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o+uTx+A/dvTIc6XO0har5C3UkPLXeS8n2fPaLdJTnpZBc88ZNbIv1IOiZHlf?=
 =?us-ascii?Q?rI+8jcOyO0hDPDTToaZEnKM8MlKJWSWzfodw0KXpVqqMtq2lvSGGlq74Pq5D?=
 =?us-ascii?Q?Nkmf8oQX3cOUeCGSsWS267bgOSpYU65OtPgrKHm5Hb3D0qZ/aqL2dyRpHTrc?=
 =?us-ascii?Q?e0SGmw3jpmkdzh5VZn1kUc55pRk5PItV6zzLnJe+wpRWowlO3Wf3vsZR23Oi?=
 =?us-ascii?Q?KSuZqC1NhKTCje7i8rNxN2oC2OiR/WnuPYlV7wvrrCs58e4UYAQRxFmqTzZI?=
 =?us-ascii?Q?kMvkIJVjVrP3TLG0QXzygR5wDsHehGxgFAc/Q6SjY9a3dH2/DZrR1ZKWNbsV?=
 =?us-ascii?Q?BwrRNmk+F5gJ/WWY7zxjooldSLIqoO6n+LP7/5YXnX/8WzXWophZSJ7k3XFA?=
 =?us-ascii?Q?deB9nvDT933ygVRJUoTCWkJlD+A8PCNqknKTOdzYzsE0UbX04qVt5BwYr/y9?=
 =?us-ascii?Q?Ttu5YCUh+Y7CD9Tx0UKhbJA0/2mPp9K5GyEnSInVzAWof/49YRTberxWOsN+?=
 =?us-ascii?Q?LqVATA1X0F0GcAYrmVVsGaAdXZmQomuS2kncJL7YlkT2Y8vY/aRND5vfzAyt?=
 =?us-ascii?Q?ntWNh6itGcAqT+ZN4vlxKya4SDuE01kzyVa3CaLT8miwVaHuQCVk1Dv2Euz2?=
 =?us-ascii?Q?FArgYzetUT/4vFcfueF+640R0NxO+DU/agvxYVY3bHy8xrEDYi2HM8Ux7Iq8?=
 =?us-ascii?Q?LzXXp0lrQBTVeDEg+yrmRj/k+a9lV9hzjWrum5p0TyQMGlNeJubPBnQAW57w?=
 =?us-ascii?Q?CqHcAk3YUt+YetdT3uDUHnDXjGoNqaYHJBiMsXmrrIkWiAO9ffSnVQ3NtAV/?=
 =?us-ascii?Q?his3/+eZT6VvisVPAKPhHc8kGDA9UcH3GGNiiZIyDmADg3BcLIb0shuGXOKW?=
 =?us-ascii?Q?Cu7mzS+E7TherZjx5/4fsVjLDMUGOoaXUbRicqjmQvcavj8TY+tAFGGSX0xa?=
 =?us-ascii?Q?sEaXccDGypKS+GF7bdYAc89Xx7phPVgtSK1RaYp7taZnZQhzdkyjHBYV9YRj?=
 =?us-ascii?Q?1fFCdVSJjHhrTQPG8x/SmjvI/j6Bg1Cm99gwXALH6NJXw9iQNSDOVwLcHzQh?=
 =?us-ascii?Q?/YlSLPgR8PhatO+Bl/IzAQX9rMWpck5A/hV3qh1Meu4lbtU6BMoOWO3Od2bN?=
 =?us-ascii?Q?ehaosAuEa1/gFg9ZvO2tUAXh/4v9bs7AuRTP0of8PU4uBeoEJDNWODnt7s4e?=
 =?us-ascii?Q?GH90jxTt75lkV9ePAdE5FPSwhSEr75jjK9CMujCpqyY86ijusExrwHcM4L5Q?=
 =?us-ascii?Q?hTOP5MIJJ0AVpzDmuGXtIMqcb/CxXhE9V9uSjxJ0EkIDw7UTBnj41DPmXUIw?=
 =?us-ascii?Q?Jcnv+LnrcefSTwfH9ncjNf2TyOHVdRxK7Fd3ktL1y/c1s3shZlskfO6O2ldR?=
 =?us-ascii?Q?Qo//XC6DHb+rGIAMSLnwSsGrpYOJKjqRsr50SUKntTSvLoxHu83JM9Dy5EIx?=
 =?us-ascii?Q?ar533wRFXwutmorbL3B8e/I3iIT6S7vQnk5AdvqkAfpwZSFSyQn3q/eLpsd3?=
 =?us-ascii?Q?aBtL9VMR+DCDBUEYhdSztXRheZh2pIvkrWzhZ+ICfY732wuSCPDdFVc9NlD+?=
 =?us-ascii?Q?9ixKJd1iVNdND7gUEdv3Vzhvkmaxi2t/MHWZM3HrmpTl16cdeVFjxVAOdwXx?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c4745f-c119-4923-a9e0-08dd2426b6b3
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 14:24:45.1858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3oqETWn3vXm/PiOOeNIHfrnWDgF4fL6CJVF0QqUIpwUv6D572qxmZQGwtvi+aL2BXTt3Rhg/L5bE8PwkIOJCqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10816


Hello Maintainers,

While connecting BT-HID device showing br-profile unavailable and 
connection did not happen.
Steps followed:
	1. Pair Ref device
	2. Connect Ref device
This patch fixes HID device connection issue and with this patch
HID device is able to connect and HID traffic can be observed 
in btmon.

Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  HID device not connecting issue fixed.

 profiles/input/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

