Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2080.outbound.protection.outlook.com [40.107.6.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C194F16D4F1
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 07:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956542; cv=fail; b=kp3/VsM2k9FXNFvPv6QsK9yxcCsPWaK/vcxeddGBYpWdTsPQg25ewS0qV0wRVp6eLRYysSdudJAgL09a09IWVH05jXdw/neU7JEsZDrsEDrhwrQ1cgmLp6pIL0i6cT+ZOLvWUAGimtgyA+C0KLkls8n2OUxguhRvPcy7BZZiT0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956542; c=relaxed/simple;
	bh=7NZQWGJziq2oiOHuKt/OHj2fbrsXjQa1EwpScFzRnc0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RzmLg4jyHgmHv76dqlJ5eLcVbZt8laSYO3EK2ckRxCEc/iXAV9f3OtxBZf/pV4Jw0p6aT2l72F2lswLv4VHHNXIwj3K+ONkQ5Q7Imdi5oVgC5x+U1bV3sPTbNcsLpkYrYr7PiKYlhdb24sU24MRtg4Hyjovu+3hSixV9dmMm3Zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=R1EROcsU; arc=fail smtp.client-ip=40.107.6.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="R1EROcsU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lVVX/aLoHJMP3F+pStOhkg+5Q3PCZJBP1QCT6xIWLIB9B/4foELl93U9s1WvIsXofnJAH5xGh1bCyBRISg1IjMFOHhVDpfbn2t9YO1S45iTiYt/7F+LiOAQyy5F4KBmXw1m0WUUMpJhOWmvmTXszt1cm1pMC3/ZUuaduqB6S/BymgDWss8m3ZD3fVyWIIbndZr+VeToe666K1Ap2rcs/EgZdszweN9A8c9Edt6j3/lW+19SFIzXabOL91IcBxMeqmygyisuHUbBRr2glSsFqaTyfIop4PlBYQUYQMm+cj4VUGdMxDi8pXZFrI3CTUkAg4wUKIBFa7WMI+X04SzPpgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2jzXa5SaKXf+pqCSEWPbX1ul4i/0CUNkzTVJpgj6Jg=;
 b=cFQ6AM0ltHXZIFD/gNaLx6JvNX9Ywu0moLPWVrfFwV/o/EISar0u58Ek8TWndvPEzo6BTAfwDN3vUn61hSq94T63bVoGTOCcy0Vd+7+hzAKQUFPGgCfPCHHTXmjix+19QZIXypR+Htf5AVT36Tdhwq1WvYyiOTBBcH3VXL9vPnXXf9Kwi9Dq3Ocfq2NUDWdpOxK0TczstaxK1ZiBj7+RrckiBSCb7o6TNutpoZQcxv8EHh92iYXtPr7iCgr5tcLVB/LuVCiztBA4154Vk96htcLGZOw0/nyORSwt9zdCdmHa5GZWZziXXi1en89vmBmNRunvtEcaQuyda+YM75XbvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2jzXa5SaKXf+pqCSEWPbX1ul4i/0CUNkzTVJpgj6Jg=;
 b=R1EROcsUqXJLEroqpj7S7ns+u8dGW/OWQuKGePfqLDpc0uByRUEtb8aCshacWrQwMrjUoRi8/BxtpKwskj8WlHcfkdviyNOJujnsd59xpH8lBzE/LrAHxoQxfeVAtaOVxvgtinOreKGVqWrfW6eHGOmIyCM6J4lSGGQ8e+qsh8E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by GV1PR04MB10200.eurprd04.prod.outlook.com (2603:10a6:150:1ad::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.22; Fri, 21 Jun
 2024 07:55:37 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 07:55:37 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v2 0/1] Fix null pointer dereference in util_ltv_foreach
Date: Fri, 21 Jun 2024 13:25:16 +0530
Message-Id: <20240621075517.22576-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0003.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::15)
 To AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|GV1PR04MB10200:EE_
X-MS-Office365-Filtering-Correlation-Id: 74925ef3-a4ef-4783-5942-08dc91c789b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|376011|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6DxfhFZNXNBEpgeSEGikqN15+hId4nhjlQ/Wl2Ns+2gGa5tqie7aLA6KBxZ5?=
 =?us-ascii?Q?XPRm4lZBZNI+aO+cv2EX7b+EK/Q8b7hXOGyR2Got/isTSGXLXsQCj1pfRYoc?=
 =?us-ascii?Q?ja5nW0uSM3pV1Od35C633zkykfOfHHHMcy9LfK+uqPbbvP72D7kjk8fzCc9p?=
 =?us-ascii?Q?x/ndZJMKJw8iT2UyISTh8KL4TEsawyktGt8T18oJwMlO4cdfxr2p5mQhxNze?=
 =?us-ascii?Q?mYeAZas3yVT4amkDmbMUFT7cl9pOGH9CpdRyi8KkVRnGzK06xmTftjcDWWKq?=
 =?us-ascii?Q?lTHr0u0LPp5JhyRYYHiswS94iKSGdZbeNjto8WK6MY4IQVDyngw0jgAqukWn?=
 =?us-ascii?Q?fzTNA9jIf91Bku/XODGWfukHlgdeXMNl06A79z0V+7qYn20EUODVi62eQw9k?=
 =?us-ascii?Q?8+C4lAk61u6i8pXmFlw5G40wGqDlUiRvgV6O5818NpALAKF0xNkfxafMP9mM?=
 =?us-ascii?Q?Ag5Z5GgJgn1K2eYJMGlxmZKuJIrsTs8Oei5cU6GjSu4G2W72nda4xPBqsKm3?=
 =?us-ascii?Q?aJPWjfiy9kbmxkAGX5rlDXsV8/175GNAWMQhvT//ibcaIQnEfgxNinWZ5ZId?=
 =?us-ascii?Q?llti0dQ02HcuXYrIGSLvhOxOrWFQ73zWCMn6X7St1DwYTyTFDS8DFhccSbto?=
 =?us-ascii?Q?uHJkWLw4B+RKHiNjFcN+WwUCGYYmhhVfujGJSSoxtqXjJwfZuKdIgoAK2DbL?=
 =?us-ascii?Q?5E6moF7uHSdLdlmWTP1iOJNjgThP/XwJRth7nNR2OFoElZiCMBDBT9pEgVr8?=
 =?us-ascii?Q?X32s2E0W4j+8r98JN/eb3RhZYyHpOFGFZ8AGRxgaVHmIHFnmSnQopsKEcFIH?=
 =?us-ascii?Q?yYQq2gDhmXxCTPw5mWTiaf+LnDgo/7Wn81X80CqsiSIQWB1Kl153KJjbGJCE?=
 =?us-ascii?Q?tC2dilxAte6yylWm/HrvXTAKqiLkeO9IF3ks7DmXkikapSAlzY3R9okY5ziT?=
 =?us-ascii?Q?gZ/nOY0/EGO04g1/1r2dBv8wSkdd/L2IAkNqRlO0MOKX9xdQbtO192BaUhbl?=
 =?us-ascii?Q?bXt3LWlqZTcT8CgmVjNV0QEVExGwq/Xry44TJ6Qhq2BZEooGZZMV3TUIsn4R?=
 =?us-ascii?Q?UQKCzeeUi7IAwZOGwXX7Iz4CIvUKXk41jc0GLupi1qFa/Qvvr7OS6Q9Q8EXo?=
 =?us-ascii?Q?H5iA9dw5kPxjvyJdkTpwpOP2xBEcM94llegBmkqLtWv7giziAKasyLKNXT+e?=
 =?us-ascii?Q?/E2xS0SFr38PLROX1WNbW/h7rG3rqxZ+yQVYbFPsAbfffe0DaLe+FhWHQQjp?=
 =?us-ascii?Q?GW66AE4wMfSFl/OkRvfQGe+BMamc/qJC6VDq1Vy5gmfW/mrKmUU8D9zaJp/o?=
 =?us-ascii?Q?avNGpfBDFhGs2Uz/Bf/x/79H1LKcFBTgiE3XKSZqNDKrE1ZMlvwqBz3CW8Ay?=
 =?us-ascii?Q?3zP3FZo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(376011)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9o+VJcCt5z+6StZo8BuaLbSIrNn8z+kI2QJdvLT4Kc5KDCbnRbiFuNwpxBop?=
 =?us-ascii?Q?bHgeU4wvz22pQGyw1WuSdLHUNfQ3OfrkJuzDHXL5iJX2mN7cCoCtTgwBESU/?=
 =?us-ascii?Q?iroMHBB1wdyXdwaTII6ssbEn1Q2W6iQd8t8+gqQp1sfyJVar8F5U707aRMl3?=
 =?us-ascii?Q?lOstjPUA5DFzyGfviUMQCQbK8ledhHB0boKEB/Y+Dqa/+GkYsRef9G0RluXF?=
 =?us-ascii?Q?9Lx6e+GpTLQzOf6qi0HGh/pc5FymJ+6GyJFjGZJSbzA2ypYgB07JeJUFnUqj?=
 =?us-ascii?Q?Y64dKFKlA+bt8XN1QUtcPsQjwUBieDBN4LccOMjwAoYkadducDcdSxqjA2VK?=
 =?us-ascii?Q?QP70+HhisxRdtEQrDgA2L5m/XLD2e7thh7IVXVlYeA4B71KNYaIJWur0Ckyz?=
 =?us-ascii?Q?L8JcrPhOb6UbPUUcU/mA41w1mGTx15RyKRb5rGjUeCn6bzjaYkacBvc94Uvz?=
 =?us-ascii?Q?NYxZRQKbl9N4JwRQujVMh3l27zSVotVMmCQUlfigVrdPTfFX2Xfl8QvHwYHh?=
 =?us-ascii?Q?caPoUh5r/uEBD0i1SfcLnCpoXvTmmXwuzYFgjeyDKfhrbk1x8BK4TlRNwfI7?=
 =?us-ascii?Q?2eYbLFAl4i18vvDjgVoM0RdvHUZINfCk/3q242GgvMIb5P1TBlMnMKhJ/hUf?=
 =?us-ascii?Q?ad6ptv6p5anBeN0Zd9UIo+/bPdhHcqJmB6KF0TTrD4w0/e4wy585V0KF6Nft?=
 =?us-ascii?Q?ms83FcDgnXKrAHm24tKF5GKEd9easFZTXS5C9ka1NfzMmOS23ldHp61/lfxh?=
 =?us-ascii?Q?vR/kMIjcs7Q3G2oWB5HbKGnZizCYKU9APjvWfGzcnMgYk6uEJwNhl0SYnZL3?=
 =?us-ascii?Q?QZH7XOz9Pkg2VkUCKvifQtxOfMemx5ZT3k7lyTLwpGSQsubNHc7/Fm3PxBp1?=
 =?us-ascii?Q?5JgpAHRfqd3kEVV5gbsAqsHPMJ/meCkwfb+8+PdS9BIC7RDYQGeJfJwSrwME?=
 =?us-ascii?Q?s7G4HgUNx7G7J3TEImeH4YBQRIxihWIxJGAjGKEJHz4XgEsaQYiBFNoATARV?=
 =?us-ascii?Q?Jo3eETQPghNFSOwzzbnbfiC6C1drux5phnNQbcBgbdHdb858Y/gAc7iJXyDI?=
 =?us-ascii?Q?hrg/2BOlVWA+9WezFg7DH80L+6ZAFG4i1GYPxMI5QJpuod9UOZOy4Rn5GeHe?=
 =?us-ascii?Q?sBNRtJgQrs1qe1z0KUHwK+lnjppmVlTUWTpkzhrwQDbN5b2q8lWaBXsCmwEW?=
 =?us-ascii?Q?q6VBwnhlGDouZx2OZ9u4ZlSyDUeS6mAVWuwj6wufhCjflzjY6KuY4Cz0ywXI?=
 =?us-ascii?Q?/feiDJqb7J2tl7tkaH0LGRaEDfVQ7SGIaRn8DCDXkxIvtZ14pflmWJgHxINA?=
 =?us-ascii?Q?sqOwfjv4dsJJVtURXzP03Gei8jZgWjb2FySG/F/Sh//GFQiCXW3MKXm8pJ05?=
 =?us-ascii?Q?kRwecvRO3Zq4Q2UgZqOVdzgKbhHekoYLfnw2vhGX9jvaXHEKMg9lsIDS+B2h?=
 =?us-ascii?Q?u8x3gsgmNEUPuXf37JDeigGp1UGO9ZxuiVxSl0JZV3QRK3QzAOyTKd5d1tOl?=
 =?us-ascii?Q?n/dF+5qmzzq/Mu11JvRPGnlu/dnvDpBJUyIEvqbwqY7C4aCJNY9vHFaS+O8W?=
 =?us-ascii?Q?o6u5S9BjofkaPeXzM+hVP2u1tRmv1L9A+zGraXB23+seEfzCwjVrbECZL2N0?=
 =?us-ascii?Q?7A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74925ef3-a4ef-4783-5942-08dc91c789b3
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 07:55:37.8518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D1+c3qGPBSOQtlJJJNXx5ttit/HP3LbhqTm5KKy69JcNvGFQ/Foqbgr4PIlcNRfaE/0H9oHLQy/J5dgnPKDWomeaZBmJGoSTqUl0pQk2DVM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10200

In the existing code, iov structure is initialized with iov.iov_base = (void *)
data. If data is NULL,casting (void *) NULL to iov_base results in a null
pointer dereference.Inside the loop of util_ltv_foreach,
util_iov_pull_u8(&iov, &l) is called to pull uint8_t values from iov.
If iov.iov_base (derived from data) is NULL,attempting to dereference it in
util_iov_pull_u8 will cause a segmentation fault.

Added NULL pointer check for data so it will presvent null pointer dereference


Sarveshwar Bajaj (1):
  shared/util: Fix null pointer dereference in util_ltv_foreach()

 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0.windows.1

