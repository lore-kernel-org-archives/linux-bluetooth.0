Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2072.outbound.protection.outlook.com [40.107.6.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43321B59B
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320674; cv=fail; b=oJKvNqWWaTlMtzzO/gF4bZzhe9Xyer9eLjAd7c9ydFeLMpwCJ5EDfMHucUg3mKuC9qB6lPLFtNvo3DyG+lUTlyHV6nLxTVkxzdXt5FQzNsa41YpFuIiYlztWdzDGqD/WgYCTLYHO9PtML+7Ia8iw9h86gAEg28a75S8qQpt+F2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320674; c=relaxed/simple;
	bh=MIuf2HSexk0KQKrR9TCwUdN6JKcaFOfXDqc3DTunBTU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=YbD+ZeDIE7L6udFjH+I6cvucTI5UBeljyeGQO8FCgWaqH1JIbt1WQueIe3jDg+u0k935Xaj2bXqQuWjt4Mm4gXr2lyhPT74rOmxgg3tzXtCihSMb38qzsbtMk3mNp1uR5ZM27lxa0DXMTd+VOCrDEaMF240/cOOk7+PD0pViztM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o0u4yJSW; arc=fail smtp.client-ip=40.107.6.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o0u4yJSW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnPJXdkoZbBngzauTinapRQsj0vn5KrK+oWKExobsawJ+VBXXGbmWFYsh0Sy6wJstWkZ0oCPCjmqrdrJBR+X9lozHj5bFVl9Mdv/xMv2XABZAYQdGDm4XjFmcQ1UAxe29O3cW7WoAoJ5tbA+u3OFnkRuFykbV7gnkxbMz3tNbs88dxB9uwXUyHR7NmacLm0yNKqmHR78QPoYL3gITNgVfXIe/r9z+THbiWptXGAv8mKBpCruNNGtbArFZpThfgdQ88ufnZ3K+18UgCxfS3puF6Wbobj0KZpppXWxvFdRjycyxDy13ooS4Z0ukH1N5z0+sneL68s8rEB8fA4Ye4u9gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCoGM2VhYAFfHV1fGpRkSD+2kVJDz6wbJkSzss0IkCI=;
 b=SYYa00Z2eu5KC3FI+z/eZU8jYvXQI7yqo3UZz3trqx6n+cPwDpCnTNG5Veg6GKHZkN7ZzuMYWsZmK8H1vKjdnnZnv3VHl5jrtJPGZkHAoppJfIbEcDSl9wYZ+crcyzGdrfPvjk/1whwNQNUUXAtxIWW1JaL6HDjIjauplivJ18CmAeE2v8HiOEgiV/hqNNcQRFVWu7SD7RYWtoHKn8DiQESYZa5m1yVHRUKcVZ3Uv2GYUiJnewk+MbPDClne1xT3gCBVrqPV4k2KQ1i2NstJfVVLY106nJv35YKQBd/pNA0z0FB9Yx2EHd2t6ViXXfdXlKxKFJgqoUcj8fv0w1AYng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCoGM2VhYAFfHV1fGpRkSD+2kVJDz6wbJkSzss0IkCI=;
 b=o0u4yJSWk6HIWFCjwJaEY90UsgCqV7/KWERz/iGc7i4R1CQZfyuFUfsU7BfCVg0K+bXoRWICmELT+ksEc4dzY1gui+LTNPxaP12nICQn0zsIl3Qt8kz0/54eZAClM+k2xEKfFrweBGJ+d3mSn+qk2ZtQFLOl86MciHM++7xtzzk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 09:04:29 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:28 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Update minimum LC3 SDU size to accommodate 8_1 config
Date: Wed, 13 Mar 2024 11:03:58 +0200
Message-Id: <20240313090359.164196-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|VI1PR04MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fa22773-806d-4684-ba04-08dc433c968d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XXuTUpqP9vxmActSCzA6t/3AlxSpRPpbpffHex/TCZHHKwhMwCMFm6BIOmdWw0WVdAtj/XYY9NjEun3Q+vqp1eirOptJJldKe83bSsasWo19+w8jisrqVoxiQ2N6c4XzN2ss9Ty3za/7BdnuX23k0b58iUf4vP6CQkbI9YwKiCVmmET9fxXzOIncpalPT4aPh6xC09NaBRry4/J5hHD96cjTe8eVbGfImiZ1amuf5Nzibx2SBG54x1SpvRRh8hLeL6duuxR7ME8odwV9q1Ban6eI37vNIY5duQVlJi+BVFchI9EA0YdzgIozgjcIw+VodJw1hZ6CF3MjKuwhiPSgKHJc33H2OwcLW3MmIgzDDUmppn8kceXLb0JYd3lsiOEfrUJTPEXw+4txUaeFRNWe1QdWegiUfdPpdhH6hbgTZpbpSP5FjZjJ5nuRwbilpJ26EKZ8Sh0hT+6ygF5hZP96qvSjKIdToj9XU+SUrnplnb++goYXZosJdNCOLQWQW762cPNXYudGkyMOOL9n0HLVPw9GIy/vZpneZiNxXfDW+rojmgTv6b2gbElpAi6eLSKk5LZ5FEAuBoj+dGne2e9vctQ/VwTDnYX4fdcOADrcCVEf5C1BHxUo5NS/IGX4eyFwnNqgwIliFEb202pGAqswlnfAwhjXfRrUyB+uj0cnZXUJkEfcX/+OHuK5tnrZAeIoBr4fdvlK2ljmekD724BG68R1R0oummWEfrtdvcIudyY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?W9uPVvUo1jtDoGfHiReAigbITWdQI9UYOqigZGUdkmFcgCur4lkSpsgo1V5R?=
 =?us-ascii?Q?4iIqdILKWdvJ86SWW1Wh4UXBEB1bNcB1VZmRvaWeFia/WjevlV4v2IR/g2vH?=
 =?us-ascii?Q?Dcy45IOmcf4LJVJdz5Cwqq54iF2waudH4G61xu8Z9veywQMDQ1tmpscOoyiy?=
 =?us-ascii?Q?hlR7Rkf1+PBrSatSTyXVVNanRm9vR+2JKAS4aLpENAnTsCE8X3H2YTILiOlT?=
 =?us-ascii?Q?c87jYvRQ5GAYTvkApVHnUKGAcfUGqPCIHNCiKKQa/cTg85KxNpvEccImKrD6?=
 =?us-ascii?Q?4a+jhgGU3eqHtgYXQPj5W0a+qiHcfkRgQimsi+vjShfS77LK40yNLkoU5NJD?=
 =?us-ascii?Q?IsUz0yeNfSWGlbb2yQchOtk+2r7KyeStiMi5RnBSA+VECHPY0ZKeTdLFfz7m?=
 =?us-ascii?Q?o7iYh5lixWrugvwOdP4ozBPIev4u/JCO9YaD1eebycOO1PmhzluWqQq25MQ8?=
 =?us-ascii?Q?yrbwGatqco44gcjjr3D1otofZNtsGlxaNoy1zPlwpemAu17TQ9HL0mdUKmEU?=
 =?us-ascii?Q?IINOSfA6a9Ix5KWIoHqApBDPkB+Jnu7+pv0gg8MRh3sxwBaT+h6VYoFzyb4r?=
 =?us-ascii?Q?bXPvYVs92asLwPrRMKyRAUrr6oUg5+03QPuktXRZhMz8uO6LPLmb7EehxPiX?=
 =?us-ascii?Q?fgBp8wbgaJvlaP85lLm8QdawhXESBSbzowK9c9hk9YJfvta96jTx+HsxDFYN?=
 =?us-ascii?Q?qx8iuvFVJLFB6ZmzH8ZzdH9VABfwshK9dL51efSGbzemLgiUwWvLcpQnN1NU?=
 =?us-ascii?Q?AgU7jcWyfxZ2omk4CKq5Z9GVG/1ZXKP3ofKuD3x3YaSnrCF/rPFyLfO+cDJN?=
 =?us-ascii?Q?dEHJfAKc9ur3UM2F5INq+dkH+HFdpYSbzeVra5wRWmH6wHMJJJSubibLoFBs?=
 =?us-ascii?Q?cxyxIQl1//Z7YM4oqB/qB7X+U9GF1r2oFPm+Et1wPiuDpD8vjP8Z8BLtCKov?=
 =?us-ascii?Q?L+iNgpj5wMAV5XgV+MlmjGnhXicXpYqAbDrwcDVkaSF25jwF4VVZJVDlUBis?=
 =?us-ascii?Q?3dOapisOG+kzocn93if/I4OS8O4YTxn6esm9kZrQCi9k4kLm40vA4I8EpbVI?=
 =?us-ascii?Q?YJK4thC2gF3canfgF3zmSaosbaL3A9x6AwtHyvfmmfyriToFwLDThmApbX6o?=
 =?us-ascii?Q?HyW0abenSCxLxhYzzajtFkr1Nr45qZEHxX0z4Nv+gOKAfg7Qv9P8EpFpxR9x?=
 =?us-ascii?Q?k49i2CzrUIHOa5qs1Ll8EHJnJW7n6MG/NzTotclAJepZ+ZrScyLVSb76RIWv?=
 =?us-ascii?Q?vEY8h5rWH+AQmSy2jzwZsyn8Yq3MI++C38r1A8nBmnh0mjX/GQMBv5ypBR6J?=
 =?us-ascii?Q?0zUCmxtIHbX+U3LM8V2hPWKrxNyvldaXnFIoFSiC0I8J00BzvHL5l0wHxhal?=
 =?us-ascii?Q?QYtLvt/1DJNNEWqrqtrhC0SQBRFGwC6yERAX+kXFX1GSuetOM+eb1eUic7G4?=
 =?us-ascii?Q?/OmDnh/xRyQNIuM3RYq29ELNyeqgi0gStQ/Bkmm8Tu8WeuYPypfE/GhnoBb8?=
 =?us-ascii?Q?Rf7gbIHut86RFw+nV6T+vvDIwrFPhE4Tx0Spg1u5lZrCva/VlkUTC55arTvQ?=
 =?us-ascii?Q?qU0e3d4InocupC5z15v/cVpfeONHnu4KCZ5q2FoR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa22773-806d-4684-ba04-08dc433c968d
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:04:28.4881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: In0aholAfkEUmtMmR8xs/nNopDutzoLyqldSmuCHtOEghV3PjXcybxkzfJPlslKLjgdOH9wZCAop1GrvG2Gyuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762

Currently the minimum LC3 SDU size is set to 30B. Thus, if a source
uses the 8_1_1 config which has a SDU size of 26 the sink's capabilities
won't match and the appropriate endpoint won't be created.

Vlad Pruteanu (1):
  client/player: Update minimum LC3 SDU size to accommodate 8_1 config

 client/player.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

-- 
2.39.2

