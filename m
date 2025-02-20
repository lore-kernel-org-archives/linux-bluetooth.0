Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013066.outbound.protection.outlook.com [40.107.159.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053B51B3927
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041903; cv=fail; b=FfxR01WPyPc20VyzF3jqbiO8e3M3mhw/krXDoA+HLahATmuD3mv9jzxAXLwmuXLs2vix4VfKZAtQXEl4U+XgLe33PHJQ1IJco0aAyRSuMRP0kjVSLdsbD9JBXE964fToNX0UHgfCEDi+zFK/M4D75ntZWhjUYHoLNyg9KUO4c1g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041903; c=relaxed/simple;
	bh=RW9UMtTYZ9eqcHhZJMuVHtEGCQxfx8fKJNdIvhc0D6o=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=j0KUFWXXVIu79qYsb5dwplUMHDu5tYifIo4/VuxUc31luFO9myQLNEkKC0hJPGss3KX20S+9xT2+RcG6l14slU6QtPGD/uIE4kY0UjmUyBkv78gbSv/S0NulJppjf5l02YUjcb6nf7L/MB7vLDTBfi7+Uk15I3vR1h+UoQY7oqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=OlcCeReV; arc=fail smtp.client-ip=40.107.159.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="OlcCeReV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJmOJSq5kSfc9hR7RlvJt/SY/vGwSzSsHg3mDiEB4asIzUKRL6Mq5eRiEtYwIqdafciZcMp0S5F8x9qxuMWshnFU2IxdCj+K3pTRzcje6kxyBl4at+Jpw0BzBnlizxtb798EXodCAqhBXtAi3kqFNbTAeTSTndBlWF4X420HX/O+l/ESrERVnBZecFtg4gRVpvOSjIcW6deM9yWZ5hStYUK8Sd52xHNIhKmdWBP0L+wB0uP2VMfKf7py9wD5ZIGC3kjpZjqpvB3z76WdnGKK7JmIBiyhmA/4/ZD9MntVCxT8uFizHGwQKuIb33vDsjwuNZKH2GyugZ9pLKqCtqoZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kLCU8uCrxePb1drU4XiymzbRlOhHmKHf/QDRkv8P+PI=;
 b=TGv3JVrEHqKp5euSZ+0b5Jh28Rod0cDfWDpag3eF8pFJbP8hRDrBkCWM1VduH+SiqN7aUd8fqQpMdwFOuTSdDj3Ak7pz0i3of/9UH8iiZx087CTP4vKdzRlFF2SHUG1WsdRYhF7eq5eylw1vv8D/s/6Nc/T7JO4TG9XOGj0ZRO600zJwu7L6r4XoXjGT43BiczkB4g1gcgQu7z02TbRJk1D51RP01xUfjdy15JdGv6b2nkbD2NX1k3ZNGcAbKLhZgwy+0BV8m/f2AOnhPnKjKovNhegDhUPgeDyorLHs8hum5Ex775O5hX7y/Cdma93Cn0rFEEOYra43u6Cxyte33w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kLCU8uCrxePb1drU4XiymzbRlOhHmKHf/QDRkv8P+PI=;
 b=OlcCeReVgt3F960YGtP+uNL47noSVFmSU91GOs44ViBfM52lvs8wHAzJvLF0CqjBuGhPnVJQU6EoAy4fstRiL6fRPx0Zy9P6FLywu/VlnoMa3SkoNPAsaeZ1KesIizbirYqpbjKruy14wDU3yB8xazrt3Tj2ybsVVIzKpLhwhG/idTGQTbzfmObDT/HwivEtSSaezt+gwjB71oshPyh7UikDE1hIFF+DurwFzjsluFdxtNFbd8nyWyl9uvvoSNfmYEfp3k7Db1RmQxEalMxGxq05hmezG2QjToG6hGDdg8I05Ugo+KXBbyjzCAJcrYgEurPxcdq4VsjiZXuWuMmwtw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9121.eurprd04.prod.outlook.com (2603:10a6:102:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:58:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 08:58:18 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/3] bap: Update bt_bap user data handling
Date: Thu, 20 Feb 2025 10:58:08 +0200
Message-ID: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR08CA0021.eurprd08.prod.outlook.com
 (2603:10a6:208:d2::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a8e140f-37ae-448e-a7d8-08dd518cb867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sg3fQwa4EqrQ6acg4pOcJTbyN9RoioGpACuBDMhFQSMJlNHW093WnDbzYNY6?=
 =?us-ascii?Q?3rMQ+ls9DTOj7gT7A8MaY+F/K4fDLcDpktAwg7mLw0yO3LlycXRID0iRj//a?=
 =?us-ascii?Q?gc4LHlpzF0JxcWhUq07qRxda/7Ef74eIpc5mvvNXn8s+w7Z4A9fT6ZUQWtDm?=
 =?us-ascii?Q?DWA2nc1k7W7pIcq6r46FqT+g9hpm3vWs0r6p4c4L79P18Ff6ZaEZQ3T+QI/t?=
 =?us-ascii?Q?e2ipFTMde9L7/F/6WccNzuntyRnzKCThe348IreUUKjRIuBZE3tkS1RBYPcy?=
 =?us-ascii?Q?Si10g1l0Mzi9mfMUTadihx4r3mp4fVR0xFPnPhl5vJWz2U0LmvUBOJJf4jTL?=
 =?us-ascii?Q?rNctRdKFj2wKX4c2LPc+Gr7kI7a9FSymCqpLgH1NjJ6YNERvQwOaV1IXdOHY?=
 =?us-ascii?Q?FYt2YZZYyciAB3DVuNBEVGmVIsYFzJcjwPMXs+vu+Th3C5/o6SfTIIRtOzko?=
 =?us-ascii?Q?qRFKXNBSqxncnws6vj9GlP6ix+IFL34rnFPiylw8sjH/WrGkyjt1br5ZPVNS?=
 =?us-ascii?Q?FuzS9JOuiS6BanQ0dTGMqAi1aunHovzFJYhDX/5gv5UpIXhfIRZRr3kuWfl2?=
 =?us-ascii?Q?26N3byd8l32N3QhmuocMuEPNOgcMjZjtucRBVGvHF+Ld8DdZKzoUrB2oWgsd?=
 =?us-ascii?Q?VcbZs0cC3/xEGZ/UjcbmyKrnFVglByCRZOYhjCMRmtJnxMHA+ud3TVJscbvq?=
 =?us-ascii?Q?PtKUUbTM5oTeSgHwPDPXHXOIkT/3nqK6RhK6Z1v4ZCDa6zNjCdSAZTcM+h+5?=
 =?us-ascii?Q?xziWZhlPOJQy+Qc6QxMLQYLvLwkLc/9tlnsS7nUT98RR4xA15F9KdKP975W1?=
 =?us-ascii?Q?3ZyRe3cLBLgJKH7jwXRvSLeAN6qGGrM3FuzgmujeNXiN0FTCCcbBi5IPtm+G?=
 =?us-ascii?Q?qbGf9Eou0XFvPSJIv0Mfeb6M74tuDclCJZdUGaF2GfY6V5yrL/6vEvkQ5Dto?=
 =?us-ascii?Q?WCMbmc3SaSLx0VnuXY+LKEFDUVkKkN+6jQdan7hZ93yEgS/5iT0w7M2O5fj8?=
 =?us-ascii?Q?IiknuFq+1ODo9YGr8f/bLjIswyamF9v4i6V96xqlnxks0O2aMThJl7QHau7P?=
 =?us-ascii?Q?P4DKueFzvkmmwt9gfXK8uDOfndON2aQD3MMy9I11mEBAl4Av0haYDOxXau/H?=
 =?us-ascii?Q?HAS4vzIltaWrpEZfKWjKbVprBz8+31ikudOWZUyZacIr1QdYsxQFlYnu6PuH?=
 =?us-ascii?Q?c0JTsmTBdMz4OkJr7J310GdL3hUFJ53pMqpuSf42DlMSvR0x0JY0MuR3gMF2?=
 =?us-ascii?Q?+3fdTZS27tfdTmuta5EDFfKBmiGvu/dUJObc2pH5odPQbVJot+biw/OlvTKx?=
 =?us-ascii?Q?+NpIJMaTpFxcugUNDWzXyMlsq3dbyG2LvkU/jhKOkoy16wJ5qqh5okfekWWn?=
 =?us-ascii?Q?hPy7vKKDwf5iclcZJloN9ATXwchm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nfZl8tEkG6z6yB5HPf2PjPbKKa+W6A0cfXod+dlTqDjrLfLjAprvlY5Jgk9S?=
 =?us-ascii?Q?anhJhR6aUvTSPoFsQVqe5pPv8XPpBCISfh/vHcwqGtzir0vk/4pXD5phPsqS?=
 =?us-ascii?Q?2qcoCliygreqmvSQOKQIZKNTwmVr4N6/lb6yOiUp6xhm+6C/kUDCS++v48KC?=
 =?us-ascii?Q?LoMIw5Mbu95r6i95ItwguPcV3G066oYrmxV8O2EHDmff00RHv6ybnbD9W2ps?=
 =?us-ascii?Q?nTWLushDjr3h5MLF3bHlhfu1DvSlFgl6p+dEOnqTPVnAkemFoigRW2dd/EMD?=
 =?us-ascii?Q?nq3v9vvMF3cvnJkyKrxYWXS1geT1ZBYyX7OPs7wo75mFpWXq7EE5rekM/KQA?=
 =?us-ascii?Q?C1yke7f80pdeNhagsLnJ0m/ZIDcwPm0S9vXX5n8nTFw8N2YWAnpOUFU4AWPP?=
 =?us-ascii?Q?lV1S0wp9Rmr8QqKQhl7WUgA9mtGauIaulWdBEonbvXnT1MeroXoIhAi+x7XN?=
 =?us-ascii?Q?wy06yLxT5IRVgCc147AxXuDWD1s7zIrn1qI2h91bLJvSz9DDYWE7O1tOIujA?=
 =?us-ascii?Q?/Rm7oBCeeWR4gsy9DZeSP9Fpl1UCHQQN4tzxgQINIqRBqzLXCj0D1+nZIYPD?=
 =?us-ascii?Q?3jvGzfGqDJPUkWd5X02qvt0P4u/6PezsaKufa7hhHt952FvLWu6femcpxetO?=
 =?us-ascii?Q?Y1ypvBl5Qo4HTFRmwyImieHKV6/wcdEDnB622Kq/5USjvIm7i2fwicbYDbBK?=
 =?us-ascii?Q?nDSJWmHPscrQ+V7bVegK01kWe2Cl/bcRBWb41kYzqPCspKEYTSpcEA7C5YZk?=
 =?us-ascii?Q?QcJZFUHDqswJbQFFCazu/G9tDh+t/tZX3i+f45cWBcmGqTCyI9/FVSnODhFK?=
 =?us-ascii?Q?zx3G8F8QZ6I4fGWqNYYjaSz5hmaWNG5P5UddjlRgF7JHaBQtp43Y9GMAag4H?=
 =?us-ascii?Q?BAleohE7k71Ghy9ngWkIl6v0xB/7frkcjVgK/YAcxGFQAKfqBZm73s51l7ir?=
 =?us-ascii?Q?ub6/TUfPD0204Y4mAIkGZWQiMCoXIb7n2k5Jz+DtMVAcEpYI/oi87MUJhPIF?=
 =?us-ascii?Q?MhddwSOGkPNsFqZlVshkKFcPQwI2PBdF9HeCY/5Ym91YJG8RhJ74WSyK2ULF?=
 =?us-ascii?Q?F9vkRySFOzOVu3hOsH3vQ+WFoogYK48c43B9sPVVs2R4Zw8oK7JVkP4nTpkX?=
 =?us-ascii?Q?8t0HDQQbXHchUpr5pBT+5L+GVnRR5M+Td5UoBjs/0Gpjl+7K4n68OyrKQrq9?=
 =?us-ascii?Q?wIcFvaJsETZMSmMd81wCI1d1UxM2ztiosStlFIk1zxuz2xGg/knMTFxQwGhG?=
 =?us-ascii?Q?EDGe+BbQDTsuebHcOKUPjGfR50L/jXhPYjFVYp1FkCwEEeGGBq1gwKa9VcNe?=
 =?us-ascii?Q?B64rc8kmVQ1Om6U/rhFUcuXMn26Bm9dY7t6z2Jq2LCP5/uGLpTHtCAXi7FUA?=
 =?us-ascii?Q?29Rh7WXoy29hYdt4uGCPiX3cZIPtRPmcqamRe5XvAPt1AqegCsdCYRHd4nxa?=
 =?us-ascii?Q?6UQRIwdiWivOAAY1gV3cleL+L/PBDeJx/8uD5OiBQi8Z844M25XS7YHGuD8k?=
 =?us-ascii?Q?fKD4kNAnQiJd1GzMk0HTRk4tEvvbQdgdsb6/Jzy83zfSN4jQCuQ97lDpIHRg?=
 =?us-ascii?Q?DL372Bhpchja9E8K/wnW8geDM91A7IVJgOxMRBASiaVA51mHW1pHpwKpSGeY?=
 =?us-ascii?Q?Lw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a8e140f-37ae-448e-a7d8-08dd518cb867
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:58:18.8833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f668suwpYIdnVISPt3pSY2UhlsI/HarOBbrWMSorUd/8VPfXainoP/m22l5ouq/04PxPyiU7e+7+pJVKIXWyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9121

For the BAP Broadcast Assistant/Scan Delegator implementation
(BASS Client/Server), BAP sessions with Broadcasters are notified
in the bap_attached/bap_detached callbacks registered by BASS.
The associated btd_service must be available in the bt_bap
user data, to match the session with the Broadcaster device.

This patch updates the way bt_bap user data is handled, to ensure
the above.

Iulia Tanasescu (3):
  bap: Do not clear user_data before detaching bt_bap
  bap: Do not set adapter as bt_bap user_data
  bass: Add checks for bap user data

 profiles/audio/bap.c  |  5 +----
 profiles/audio/bass.c | 23 ++++++++++++++++++-----
 2 files changed, 19 insertions(+), 9 deletions(-)


base-commit: 264bf951f2d687f520898fa3e182291f1261e3a7
-- 
2.43.0

