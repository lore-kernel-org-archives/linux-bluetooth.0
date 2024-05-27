Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC8536120
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716796472; cv=fail; b=G7iwYEF68sqaZjqgjgxzB3yVSuCbuge4SxUZHP6fyioybQ9Bie5tnbXpFv8emEtNcVMRM31qTKOLVNpjTjNPH4PL6H88u6XZC5Rtr9Y767oAQZeAyf4oy4NV6Et3NtHBsQQyMZbr+lbRh5VWDwJpQU7/HBrolts9GwmtXpInPRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716796472; c=relaxed/simple;
	bh=DN4xheHs508SLv6tLThjGAWNfLk+CQLdxNqa8qNQkaE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GnAxdntsOmAxBSbbsgTNmbo7tzD6vy7Zl//bBiJvgNnXxiWal11AAah7xJobh1MEykD/aESQPd9pP2kXw5VqFmWW7J+2TbyYE2wRvaTWdn8dvB3X56fjllNDVRyuwlM0/YDYlXrlGo12YhnX9TqCA3J7t/BElK37zfH9uRn2HaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=htjJCrpK; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="htjJCrpK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P48CYoA8sLV3Z2AlNxMd6lsWcJDGY0nCFfW6L7Zv4Iu1uuYx//OjSusfcLvXPzcOr+UD5G3SieUeoHabtAn6ktvEUHZ55EKS5kY9Mc0zfwHfI9K7lGNOslazX7e7JKXUAahSgBJrT8/vQQoXp/no0yxFfFqpYlq+cYkQRljDyrg5MCrPbuxqBeNG4mAJzdHFGlYfyPUSnI6rnbVKfUlHkQJGRuLHZJPDewG1SHUIsIIpk2gJSHhgqa3SkAdMYAhkP1NLXZUCFCvTY+9wkiGjEwg9o7CAHQDFSHRvVGMMyRjfJF76AMi0w6lyHyonS3KCwJq9zmat2Wxf2iHzRVMWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QZQAxeHd4BRdcPkJLGogr3ZC6FaAjOlS3ayjo6LP7Q=;
 b=cnFPnIi9SMisFmE9N4e19grm3D9C7oappzb33VfAcpXZfBgO4bEZy2fL1uvxOeg/GL881OLvuC8UwWjgeYoCF90XihnoJ2zrA3VYfLHrXmjbtgBAD4dHboty3IZhaQqNRALYlsIKaK+tp5TgqWyOkvzEGLhRnF9mcgPVYulBNTu6xjiHoYFXaicWriHLpYJ9/P08IkI0eL5RCIPmFDe3/MtyesfDeGMApd6LX3jbOxlTk4WHXipJeY1eCCwygH/3pBOEv/qyxpF7hwmNh8osEi6yxniptFHALsUA1AvffQmROr/1JyNbuZafnlQ1bmyFpbjbI2HfivveWOw3B6OyWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QZQAxeHd4BRdcPkJLGogr3ZC6FaAjOlS3ayjo6LP7Q=;
 b=htjJCrpK8oiwItju9uf6ylfZ9xCnsd3DXM0V2RnZ9Tq3QvRK2VR+PPn6MNch/iVRb0EckJtqARyqoKC7AIlhp/GBaQas1jlva82VgIo7Kqkoca+C4AT17c44F4Hy0t2TxP2jKnB6WO3DAnWKvwj9bruPXoqzv8MxmUANSOx3uN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 07:54:28 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 07:54:27 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/6] Add new BAP BSRC/SCC tests
Date: Mon, 27 May 2024 10:54:16 +0300
Message-Id: <20240527075422.18953-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0082.eurprd03.prod.outlook.com
 (2603:10a6:208:69::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS8PR04MB7990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd3f940-4ff7-4464-fede-08dc7e223bda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZMUxI0tbmAhw6BVbCkiHTNWeAQttUJxRKN+b+swuJdxS3KAmlXvnk4GQ+MPm?=
 =?us-ascii?Q?Pg9SG4zjcatgzKU6+joG8+Oa0xxEfeWqocO3U0FWtp9jHUWjVGfMRZacCP9z?=
 =?us-ascii?Q?xw1VEBXgrGKyoo8caFLuWU3xaPEO8Kknt538TdjA8mhn3IhrvXuC1DmDRF4L?=
 =?us-ascii?Q?2XrAD+ps4S7Lj+NC0YzNzYnqrTT3b9mJwCqAV8v0OQ2ZmFrNVblDKbA4VEkC?=
 =?us-ascii?Q?snNr4qgA4Gg0mkH9f7z5MLKtMZT4mgXqOy1M9SR+Ed6M0sRkA0HGdofbOaCT?=
 =?us-ascii?Q?U46ws+LZejqEIZNQrvoqfQDyD37Vsm3fys3yGBRenzOJp/pzPs5KIT7lr9SC?=
 =?us-ascii?Q?Y051XD1gcEblBDKvjwUxPpZngbdTLTXPr4PIrcRlmBZbzY0igfIYvb+KVuek?=
 =?us-ascii?Q?1ky5ImxXJPUEniKbgyHci3l7P21cuivP96BtQBFt61QGPKzi5UV+SOC1KAoY?=
 =?us-ascii?Q?MNnzjMFd39dmBrVpb54C7swVByOII4NDT9YjQzeUia5ZLDgN+BiF0XRl81Ff?=
 =?us-ascii?Q?kdICcMC1brywhwWNa1ApDI6RRgU6XGLmsh1DzwsSwNfWalmeAt7JF+qcY9ex?=
 =?us-ascii?Q?Lr6Q7FMkKh02xTnUGkIzGC/hFAyaY0siTqwniIfjQI1k+lZyNocsrKJ6NHyg?=
 =?us-ascii?Q?aSFUlMkvqnF4KnCNvc7MDzHJX2LXVBVsTa4ZThW2tGJzQwATBtKg2sK2ThCK?=
 =?us-ascii?Q?78yNvkjl8AB991sGb3zRWVfvWnhsydPTGPQWGJelFVZ1uLYVV/SLGGbf7oUd?=
 =?us-ascii?Q?Obpj9EkSvtaYxGjWXyIgKAtNL6VHyWHjvMCK72pmDUw1bZcQJf5ouLPLiL8l?=
 =?us-ascii?Q?b9aJeZa1g0Qn6qNZ5Lo/pwr1T+Dmg8WwwAsH8wU1ljKtmk77qkbCVqsVXTNT?=
 =?us-ascii?Q?H709dDzSax/YK9wBDaNOgXDtFJPPY5KQPeseKXMV1XeXFNW3e+MZZpDC885q?=
 =?us-ascii?Q?nrGhr5zCi8FMnekpUGaakVJ8TD/jfJFaFG1cp5nWk6pQYTID4bcKGu1IGSDZ?=
 =?us-ascii?Q?f4OMRLnDLsdqXRT7ZJu6Xh02IPYVc8i8nc4obErC1t8/f3HsIk+9JN0ab/sz?=
 =?us-ascii?Q?vfhUr+24Mz4hg2hJ9o7usCmNBk839VHGFMBqG6pxUwQxho5jUj9vTebyiDsL?=
 =?us-ascii?Q?S0pfMqpPIwOhgK7enYjmWcPNgAxBUuEIKwly3L32BUBb71/WnjEwfn6waml/?=
 =?us-ascii?Q?7Pj5Yahir/bXfp+YLZi5i3ARMwXGwhnEzFRcKImESPkyFwLVOFpSb6NfT2yr?=
 =?us-ascii?Q?XWPJPx4fJ8TpLPPRImTnAGaRJy4cG1kWl/nd1Zj7gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HK3f+lo3mZ8U/9sUHSHyKRHFUZAeeBXVzOYB4h7HMqPOsjVsKBcqNNphe/mu?=
 =?us-ascii?Q?U5kIZnizXkDTu/0ONwQeJBet75RgEbRBGsu2UInYYaOZukXddpuhbX6ef3eo?=
 =?us-ascii?Q?F7l70q3+N/XPF99MkqkqHVTwmAw5xpNGVMjra96avEtb5ofWUPn/QgEo1Xd+?=
 =?us-ascii?Q?0n2hfw75FiAW6+xZMCVrM6i9Kgcna9Ih70I6j+3Hq2cHEqgcuREjCtYbiKX1?=
 =?us-ascii?Q?v6UekKkV0P8ex0p/zB+SI+XbThFlbclUlTY+2oakcwU63mLLdH5aOuKOxIGA?=
 =?us-ascii?Q?cAd+OCiFjACNNpwP4fElG5bLIBavhQsZC8sSDpI/aEpgE1yKQj2d+0ytGfZz?=
 =?us-ascii?Q?oMTWK6aXorRsUGLR2LyUBXzJDadhulMl64jqSvacZlzTD7kth4NZulQbEdgm?=
 =?us-ascii?Q?EbQzCbbMwu/LBq1wi2XW6dAcJs0rxrVuNGHVCd+y1chxDJTskROqWpVbKo4o?=
 =?us-ascii?Q?oAXHLmfWY5yNJzDz6eNpdzwlXF0wuVFLFqVacv8EibAhJBj3/UcFZ+ODl+tw?=
 =?us-ascii?Q?iUQR3dfhuhJS7NKq8da6MvBn3N7c+kJ5FQL9TwU2/Zqh9Ri+QMjvZWAIWrQu?=
 =?us-ascii?Q?huHuCV13zKYwKUCZyCzTIcXsnWmg05tR23tXowszPW8YhBIZ05Cvw4nkXSsA?=
 =?us-ascii?Q?jN+OJrH6oQ6HSjQcJdZ+gyw4X4/IEIidQMfcKjeDWZNfT8BzS2aLbrGa4ySh?=
 =?us-ascii?Q?dXaudE9wr5xXIjK0qDslCQ6b65VfhiNrV+Cq95DDVXKh717DDku1sgM6des8?=
 =?us-ascii?Q?6CE7Kdi0caadaWkln0rRU4ugJkOwK5gWbAAaGJX0fMaj2Z2DGNFx5ycGADwv?=
 =?us-ascii?Q?F1elLzmr4uOW3UR1OOUocL7PORxORZCky6cBGE+i+gOl7Mcib+GW08ujAIjt?=
 =?us-ascii?Q?n0MA1sSeX/HRjhdcmWW/hahSNzYFq3yh8FyYv+XhfutNO9tdtULFqAbY4QZt?=
 =?us-ascii?Q?2GMHJYguf1ECCVOpgbkT8+r6hGiVh19hBiRt92RUwarAA5LbOQbyz3aIuoE0?=
 =?us-ascii?Q?Sdo9TZt3FBSV80pcbWh8QxA0Ovxo92xQdbVCTz/fAPQHDAB/+QLULkdhTpmp?=
 =?us-ascii?Q?LEx5lQXfWOMGiXl9NNqG9PrPdypydm5n7T/h1lQJQ6tUV/5dHD8FUVb3CFFh?=
 =?us-ascii?Q?g5sSbRZYNl1ERWZ3SHqsYrwrmmtOvKXIfuUDT4JGXeJacAReMWjdn51fpMdB?=
 =?us-ascii?Q?owm7eiRQWAxNSSSCAz21Z9Fvh0dhw2mjKDNQNbipPOTVFQUvZA+ISHA1HSxJ?=
 =?us-ascii?Q?h4EDFTWT3ksIFv2/Ftp6b7+PMwlSKgIEr0mibOdHnRJIYNxuG+HslCN8n9kx?=
 =?us-ascii?Q?8v3XK9o00UQHnz49UG2rVJlbh2ngDW8USSZWP6lca5pWjPFuqljOAzaHNAUR?=
 =?us-ascii?Q?1SwxZUEsSatHOTqkVuVLzz1BAFTyWofHox4v8esMMsl4WK0QiPEwaeZmT1Sv?=
 =?us-ascii?Q?d1WEqekX7cllABc742JSZEfBPCfnJ1A8EsvPsZdQ1OPcIH4SP0jSLyCZl5lt?=
 =?us-ascii?Q?oXs2lNzHHgghP+ox8es975j3diWLAS7Zs3aS7rJaqHdilGTulai5PqtM16Kh?=
 =?us-ascii?Q?ukiuDECpkJv/5DQuxARRJRwsTajAxZrOIGpti68IRK8caVjnS4PrLlytbc2p?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd3f940-4ff7-4464-fede-08dc7e223bda
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 07:54:27.8987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wO/pCMRvQ5DUJKCLwF57woe3Udqw8wcIvXU3iBCE2R+gGwe9KiFgvr2B8VkOT+E5R8Iai5+mSp8wDUS/MtKyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990

This patch adds BAP unit tests for Broadcast Source stream
establishment (BAP/BSRC/SCC/BV-35-C [Establishes Broadcast] - page 175),
stream disable (BAP/BSRC/SCC/BV-36-C [Disables Broadcast] - page 176) and
stream release (BAP/BSRC/SCC/BV-37-C [Releases Broadcast] - page 176).

This patch also adds shared/bap fixes regarding broadcast stream
management, required for successful test implementation.

Iulia Tanasescu (6):
  shared/bap: Remove DISABLING case from bcast state cb
  shared/bap: Fix potential stream access after free
  test-bap: Update bsrc_state to just handle CONFIG state
  test-bap: Add Broadcast Source Establish test
  test-bap: Add Broadcast Source Disable test
  test-bap: Add Broadcast Source Release test

 src/shared/bap.c |  26 ++++--
 unit/test-bap.c  | 210 ++++++++++++++++++++++++++++++++++++++---------
 2 files changed, 186 insertions(+), 50 deletions(-)


base-commit: 75893035705da57efd6f8a84bba77d596c463d34
-- 
2.39.2

