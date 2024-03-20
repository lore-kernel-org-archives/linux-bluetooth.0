Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794FC224F2
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 21:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710968641; cv=fail; b=iTcxeqTSvvada2Bjl99bgqL6w7EnZxYJCaud85tTmFbrdqU5w6gQ588KQ4nXTeL2mYIXHAe6VtWgUMmUsucgSbEEnzSIl3eLcnUN/kN0AQ6C6vIFognSB0X/e9bo6JBF4z6K+Wtlm59IxZ4eBX8vbPgDq+XihhkCIj/kpQZCayQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710968641; c=relaxed/simple;
	bh=Ghoms8gMuyBfjr3IW+Uu+yEfAUzJt6HrAgcuw5kFU2I=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kTSclbWoouS3U1iabOPIBXzwIcJ+CROQPtMPlLyYQuj0vAQJlgLmtJSjastRmlCBF+HwWowytF+f2pFx4PrV8/BvR43m6AMhOHBijAv8vUAhWJJWuyxqV+faky8CRutgwgfvFoQ6samAOsALio/U0UYAtEf5wrFxSTaTUYkClw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fA9pc/XW; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fA9pc/XW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BXgUQOL29r2sjoAlw8U67JmUOuxv5TNDFDQ08AbNOMmTJIwFyyTIjSi/i8ps2WRbP1kY0os4AyDYHLxjNZJO4JtVMrhqzo17hTWflh8LvWytQFPlk93VvTzn2fhBXEzLiKCcqLgRege/kvTZNvHQfq/0iBN4WMXCNReHSBKr8MbZzWmQtHF1QCJEoYM50DwdXkoRYThKEOv2510vorM639PXSvlBfPlSkBcnFQUxaLY7FSFGSCXQ0rAPfK0oJHVh+J31gFerlEO2YrtKlz/gBy47HDoJMRyhOYGS70WHsaElPVTTDtYlbAH4iA55orOhRgg5scIHfIO1RZhYUCTdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uvx1ZAVwcG5bPPVm3tMVncoP/E0CIZKTy5DGjQKj5PY=;
 b=B1WfbjEfflQIHNn6MLfZCehULh3VwVIepgNWT3CBGNvfTOuOyeyhlRNz6IfPdFRzRJL2la9QJD1VkpgKncqUBHNCeLgOci7rUjNFQHCHdt2LWCR4nt/EREyUYzVlgViky6L7HJNh+0n1iKc/ux7RcDGxLkjSXTG6jzNs+xBbZYuk7dJeEwiT1GW5tiyB5HM/i6SgITyehk7w39mxmG4D74qpGdMI5CjnZETRSisoFcz+eEcg3J8iDAhSeISAaWXdf6Z+dxcfFofS65mXqQyLFz60DRlLJoqUI+Bu3deQ+TjWpJL1Vu8UUhcXXg27XB/+6SiI65nPW6h8jLHRxhcj+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uvx1ZAVwcG5bPPVm3tMVncoP/E0CIZKTy5DGjQKj5PY=;
 b=fA9pc/XW4ozxKDn22pTMWj5Vpowomv8I6JSS3qjGQQ/fOcs6PghHIKHos75erBZ1b9NXFdOTIljw42J7smjOKJkLsE1s3bslG+rYdRn31W7DL/nzHn+8NQ8W0VXFGMGGdnV3InzXquPIKU32+fxM4pct/N1gKf6nhQ7JRDL5JJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM0PR04MB6931.eurprd04.prod.outlook.com (2603:10a6:208:17e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Wed, 20 Mar
 2024 21:03:55 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7386.025; Wed, 20 Mar 2024
 21:03:55 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Fix crash in iov_append_ltv function
Date: Wed, 20 Mar 2024 23:03:49 +0200
Message-Id: <20240320210350.101941-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0006.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM0PR04MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: d5990eda-9329-4f5b-1ab3-08dc492140d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7NQ83/jERXX9ExduaHzBAExusx08wC3HnpXWW089duPEWh3WmzCcXceh5VB3sjT0QX27YEylr+oZoqznJTl/Q0dcyvP/yDEyIS78m9k4ZmB5hx1en8BIjdnI5A4Mj3cUvOddHwU706lyUhaNMLuAN+3GfKSvaxriwkvI9dYhs0J2KUm3MBrclzAtTwsNrA4fKbOS/X+YdN5bphhsgvQSfbCPqyMDWvyZsyj29VG9o0ndnthdyAeOsFAO5lkb0u2NfJ0+yuQCvgo1SJq77TEL856XUxdQW2EZWT+/U3CXnHzpmnJuJWp1M9DiaXDp4PhLtWvQePvWW5EIjmaorhZmPYW/4shOVpE/DiPjKytvfV+iy0Urg+2QT/Fi4xe2Bi67aI/f6Rl97NXJbJz11L/6Cq76W/e9O/w+SEuvL1uJEuzyc12Jks8htBVgz/zNtCrzlr/sJByF2NkhsC13o0lUUVenO6RiPsDDLdsEjOgWojc82tsIbMb7Ep2dJxyiPJLP1hQIGaiWU9RGBV39mS+tMwr6ZUTtV1vJUBTiVBz7UCOc71tCNQuoCManI9peGRS2o0m3XEXpAXwVo8bV+k3CB2OEB2sxIOBVSwGCcHCbgko/LvfjBoa5NwkrpdlCUkH/2a6HY8WdL/rbkLmOIcCsn032HC6nxs3gUNkSoYc7Zxs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZutAqePN6G8OWSAns/jvo7kHS42GUqK5hP8lxpbWg45NrJKBXCnAyjg++7xC?=
 =?us-ascii?Q?d8gCVmB09rpmojRfvqooL38t0EgA9bHdwHc65EgMe44JoFp7EFiWSrl5P3bg?=
 =?us-ascii?Q?yvT3XTxZn+257GT192misrYtTwSt+1k0V68m4dXuCW+xV+UYnnj5YgYId9jt?=
 =?us-ascii?Q?JWstSJwLz4huDZB5K04b13eAy7KvJ9MvllX4TL+28x+dLLEaZCHnCmbzTp6T?=
 =?us-ascii?Q?hKx9mzEdWJ9cutY8cthgE0pl9skmt9Lja5IcugacMR9rU+6JmrSkH+iPc4Tp?=
 =?us-ascii?Q?hYbWstWN81cNfsJ6R2mawm874dj8kEIH0vLlhfW454o/MK0l7osBvEH91RJP?=
 =?us-ascii?Q?P0pkzZx5SD+oiSc/DaIoBVTtJHH/70/pFUmBNMURHR/+rZF8Hf2pf9syhNC1?=
 =?us-ascii?Q?ztW8EG7rSusN7awdG3XKscNvcaOHj8KKoZi0KOGNMC5PozMO9bPRjoUe9iOE?=
 =?us-ascii?Q?90KxmySJ3VB7USBRoGDvENAw815/gAYV8swK/DFbazmcMH1v9ec6ysVQ9XDw?=
 =?us-ascii?Q?fvcjVOKjjOB6N3LqYiZYFA3GHNsI5MyDsPJK55VUILX6NaADnjH+btnE22PU?=
 =?us-ascii?Q?Fe3eSSJnDvIrlHnWvh3LjWuug60laDVPhnn2VuCCD7MkhQt6JQWwou4oCIhp?=
 =?us-ascii?Q?6nTTytMJm0K8D4gsdtF7sRVW2StcOBMXOD1m4wdrY1PAwIBVuxoxGXZYF/y5?=
 =?us-ascii?Q?ouzwLdfXsc2/1QOAndJmcE6OWglhbd7Ii5jQ5ffzhr1FzvMBEzKFa77F8TBs?=
 =?us-ascii?Q?uobu65Ywtehw4YlTez0b3Qt5u9Kubp99z5bvR6Xf/vsppuJagycSOnxb3194?=
 =?us-ascii?Q?uLpJaaEhE1TYgFfjKuPnQyb0O7C0FqLHEwKDR4MxhWRMA/YTPfuryBrz3ZtM?=
 =?us-ascii?Q?Uf4hapfrDEHJU43v3sJlZwkxEreKwZzGz+2EiYaxtWU8KAa6pFHso70zT+RE?=
 =?us-ascii?Q?Wd7TCw3JCBDYS/qkxSw1G/ZkpjgFCbUXrfQFpJDSGgojXs+mgXL71JQ9hm7D?=
 =?us-ascii?Q?ffd3Y1AtW5P84uXDRDdRe/HCWeMhS7cDQAdmtP8A50M1QFHJ/Wdc6lHokGw4?=
 =?us-ascii?Q?Epc/6UM7/7APrqY2QNj932iR7iFlo5FfKwruuP7Fac61/uHj02xafFxFczK6?=
 =?us-ascii?Q?F3TO65899orVlBoGjNThtOhKoCKxZFR7/kUu/1bgT1BSmFw6qdcOCEfBkThS?=
 =?us-ascii?Q?Nhcou/RHijDlSdUBJtGdBIgTmOZd6NXghKWdnQPxcrBHNjkNKMZZRofeknes?=
 =?us-ascii?Q?EcGAwPmYR+M3RL2QqSpeUdAGWYwa921yhoydONfVhUzfOJnaXkMYdck2yHKz?=
 =?us-ascii?Q?uhqxPXqelH4rgXCrU8oCDalIfTIgOSa5NG20UoF8ovKhMnvq948sTiroBB/N?=
 =?us-ascii?Q?HGOnbPzYW8h4ICXx+3j2fh2spsQx03FgVHe3fh9HOcwlCx3Nxj9fshp5y5aZ?=
 =?us-ascii?Q?GgLiGnV8KPV0VjPQesjVg1OiGfT6FgHLQ0b7N35KPZ2AJENiuwXYBR6EaXuG?=
 =?us-ascii?Q?uZmAv5purcTmAJ4Tbfcemja1wEAzV5REdcL0bNUYxLWcKM+p80pVKh0OByUF?=
 =?us-ascii?Q?fjE6mhFJ595Ukob1PCwSKL2l9Zxwnu36lgPMCaqqgOAm0I2+LTmUN0YWfaYI?=
 =?us-ascii?Q?pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5990eda-9329-4f5b-1ab3-08dc492140d6
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 21:03:55.1343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GdQ5xnyrgczgjZEfD289g5jPPvEruG94lVcVhkS4B7YxpIqkEskfw33ah3qomXxumj4YiujuI4HIRI1Pow7+tCAllO+BaDbL/0wcfql5Zpk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6931

Fix function iov_append_ltv crashes because is not reallocating memory
Use util_ltv_push from util.c

[bluetooth]# [NEW] Endpoint /org/bluez/hci0/pac_bcast0
[bluetooth]# Endpoint /local/endpoint/ep0 registered
endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep0 48_4_1
[/local/endpoint/ep0] BIG (auto/value): 0
[/local/endpoint/ep0] Enter channel location (value/no): 3
==80806==ERROR: AddressSanitizer: heap-buffer-overflow on
address 0x60200000a8ba at pc 0x561971611e0e bp 0x7ffd45ab1f00
sp 0x7ffd45ab1ef0 WRITE of size 1 at 0x60200000a8ba thread T0
0x561971611e0d in put_u8 src/shared/util.h:254
0x561971611e0d in util_iov_push_u8 src/shared/util.c:534
0x5619715c28f0 in iov_append_ltv client/player.c:3565
0x5619715c28f0 in config_endpoint_channel_location client/player.c:3593
0x5619716226ce in bt_shell_release_prompt src/shared/shell.c:744
0x561971623087 in rl_handler src/shared/shell.c:769

Silviu Florian Barbulescu (1):
  Fix crash in iov_append_ltv function

 client/player.c | 18 +-----------------
 1 file changed, 1 insertion(+), 17 deletions(-)


base-commit: b8ad3490a3507476844d6c6a87b2cb336f7d4eb9
-- 
2.39.2

