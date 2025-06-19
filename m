Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F0421C184
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Jun 2025 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750343109; cv=fail; b=aBqyCGnyIIWAOUvhC3a2yxtuFLGr70+1vR348KmzwLDAAiydLfWtLIih2VGlg80nE1w9PPngS6sr0yfsYlbt0RKthLi8g/v2DRGCRof8RxsevI9BNQ6USPssJ9H6RGdgB4TsS/BUOHaYMBN2yN29K5o5ZnGPOEbsUy/nABxypCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750343109; c=relaxed/simple;
	bh=wfMw09lK5oTzjoLMnkoHxr2UJnnqDHh5nLE6CQ/gHK0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cKrh96Fc5o3YavGDR/Oblf9mJF7MzsydLsLMgomCNbeCex5pQxYfO+59hhORqL1T5Lo+a3aIAyYXAItxfA+aMkkfS+hX2k5tHhWX7JTX8/HuawLjsmP2FPSV4EfzTSqMFCq0fBOaKtOnAX30fi5Xnivx7pbUiWu3hGCRKHppc7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bHMT7VCG; arc=fail smtp.client-ip=52.101.66.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bHMT7VCG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pz1ccnHdrdAuFwj2UHXyqvjN5jG7TkGp+cB3UZcgIiLZEswM2icJjJXKfXt+cl7sgIqxzJcnJP6uZWY3MvMBpvT/DahVCMqwbEgUu3xBQU7ooMtxhrdFkL7vhwy4ZOicke8tOmYdmGshJwjLItCUnOdmhT7pjGVtGqKIX/GTrG3y7U9Ogw/3XCAvBl093dl4ego9Wbkr2BrTfW4qUuRLbMq8gPWrAGg4P39Q40a1mQgeE6F9iTv7/PJahlYMCizWfxuatfadxdjf97Xvbh2kUtc8Th6jQoMcBsDqNaFroIS9WvRs953iHG86/EQ8G4laDQQRdftnVGWT1up4OIUlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTGp0K/WD0TYBf+ouFaSu45eoH7qfE9RlSYTtaRxZ+4=;
 b=MgE7YgavdpF4MHBEruPkDMyMs+DUd4a2rh3DFAtW2oyHFtPvhxr2rXFKpO4RIYyD+3hMQrC9/DYQ+h/ApVDZ5inVza5qdBypoDI14hE7NmjDnuGj6Beuh9HYsnCSrJEBHcv6PbyaGF93fb4GMn++ks3ZnYpl4aaMXQeOljvT+Z1lkGUa07hyQth9SvaEv9ZOjuvI4klHGqPJvcaNixQ1GmfLYBR0nBX3KpupPKBYKGPgy9sn8dyDRaRVADZ1yev2AmNixF6t+pXTKP4iYauhsyzO9R9Ul80j+GkmoWAFL53Lx3oqxLjHTb0oQxkwLXcYFGc6dd30azU6t9Y92zzbjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTGp0K/WD0TYBf+ouFaSu45eoH7qfE9RlSYTtaRxZ+4=;
 b=bHMT7VCGXbpXqIfm5JWz8t8ZQUE8lECgxBly+8DKpZDiHHuWqnEsUZouID3+78KEbAgZjIcn8LKltEsgzI9p3gbJAfR1anMLxrXI8PbuUgqQT1lMtmywpy8UNPiWdopoevo5zsJxSqKkHX+pcYCg5P6iQ9VbM+Hx/ZRzD4Bprwv7PKQSGyEQMc64pYvO6uR6XWx2vaIdrtbgxvAghLG+KYhWWtU/ARDWSj6InxHEsKGNQRTOWHOzmPXkrNOxUAEhW26nufApic14mRmDOO7qaQrMCcugtkVtBMYHcnTFJ8Y+afIvIeC3mlTn4RMCEzG7SWE0re4kX5dZ5U/39dvkNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com (2603:10a6:10:372::12)
 by AM7PR04MB6904.eurprd04.prod.outlook.com (2603:10a6:20b:106::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 14:25:03 +0000
Received: from DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82]) by DB9PR04MB9258.eurprd04.prod.outlook.com
 ([fe80::f9d9:da31:4f20:cb82%4]) with mapi id 15.20.8835.027; Thu, 19 Jun 2025
 14:25:03 +0000
From: Adrian Dudau <adrian-constantin.dudau@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	Adrian Dudau <adrian-constantin.dudau@nxp.com>
Subject: [PATCH 0/1] tools: Expose the raw advertising data available on D-bus to PTS tester
Date: Thu, 19 Jun 2025 17:24:56 +0300
Message-ID: <20250619142459.7979-1-adrian-constantin.dudau@nxp.com>
X-Mailer: git-send-email 2.45.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR01CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::37) To DB9PR04MB9258.eurprd04.prod.outlook.com
 (2603:10a6:10:372::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9258:EE_|AM7PR04MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d36fd1-3185-410b-6f38-08ddaf3d14dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1tjfLbAmmUkHTqCiDJrr3p0/vSNOtl/zNbtdwYbaTNdeXP5ORUy7r9LljOlR?=
 =?us-ascii?Q?kwzsK0+r5GDndGlXIfKbhEqNw22kUACGSd4tXXGQE2LDJC+vz78UNG/zO5XL?=
 =?us-ascii?Q?Ya5b8UeM8pGIuUyOuwk6NaAPv9hLC8gFIGBRlpDEglMv441I3G2uLb54fONi?=
 =?us-ascii?Q?fpBwRzPozF1D55/XR8Bl4bZYvE+4V+9Z84WJZMUkPUixwxF6ETK6xVnJZhYB?=
 =?us-ascii?Q?yVeMstoNv7NtTVkrTTgMVnmROPCuIyQt15CdvRXDsr0UmJqLh93P/MaZYrtA?=
 =?us-ascii?Q?TdDMFouDzMEBPCjAx1z5WNIPd+D2M9aMjO3ChNAwpWq44+swe22OYDsaqJcM?=
 =?us-ascii?Q?inlGAmSoKvFvzK51wFT0L4EYCGl7ZCEa5g0fniwqDNpVKshmogPad5yMKs6o?=
 =?us-ascii?Q?H8pdrc8gjsmXxgDDSjzVBkjprcnke3dyOqIjNT4ag/Jb0sBaW8jR2uKN5cvs?=
 =?us-ascii?Q?Kg4w35nTMSfOoV5E0asrl5FHmYkTnhD/Dq9YkszZQf7gTMJL4BOPYP1Abl6m?=
 =?us-ascii?Q?v5g0vYj0UoT/jyBSSomX2fd7eokVwFnG2/qk/XWAE+Rw1VIf4jxoF225nrEd?=
 =?us-ascii?Q?gZ8SxdNxK5Nm6iLGGIjIG4Yn7F52yi1oGVqg+J/qqVP2UbARC30WvbiX24JQ?=
 =?us-ascii?Q?gDSYGPfXiJaUjeYKg2Um2/qnFBAZV/jneH9MAhgbJVlVZDaaNKRqqXPYBh+9?=
 =?us-ascii?Q?r/ZdlaQ3cWAk9eYXHThUYhfO0mmIcJwvg1kRfCzql4Q2EbQiNCQccKf87kHQ?=
 =?us-ascii?Q?rgi+BSWP51dxLBi+V7znBAa6bs24KAo9MnlbIo9ctQ8rAzVXmD9ILZmGwQLb?=
 =?us-ascii?Q?X3ryVvzusCbcae8ZDlAuPvkmAFDynfkFxFo2Rvffi/1myOFVro17RCY2jssv?=
 =?us-ascii?Q?YaKnLCmHwSGcvNkDSrZh4JIlAWBxahTNE0wDFcVH6lYTBs3ipZ99Q5cW3JAW?=
 =?us-ascii?Q?DIVwWEDGcF2K8wjRVKaPWB/jYuoyI8hZoEGaFb2EXv7M8MfWsSnfevTR/Dhp?=
 =?us-ascii?Q?BUBee7z9dlFvNUUqrB4Q2k5CbsFCjAjK3sTpiD06pZgmWmlm9jBJEATLWEq7?=
 =?us-ascii?Q?b9ROy2lGGLasbdye5Fwjco7/0ZQ85eEJ/4pToj5h74roNPJLExDakIJCnWfX?=
 =?us-ascii?Q?jXjbISnK+eKG0vvaQdHjn3+ugw51TTKvt9spJ2mrPjUhkqIbtTjSXtVqvPUS?=
 =?us-ascii?Q?fBJMKtLTJq7gD+YOUeK53MzjIgH+zH+V/9wyxKxAwk9xHZPVqTD2THZHSYbe?=
 =?us-ascii?Q?9NFHJIC+gzE0WRej00eb8XI3+FVDQHDmyztax1vpkpTxEI4xjM5iLBbLyj8M?=
 =?us-ascii?Q?fupa9jrAe66tJkcVZiBOO6KqxfRGA9wU6WqmzzBxbU5fPtz+jHQvdgg9ImSR?=
 =?us-ascii?Q?DFBuVtWDXMWXGkyF8i0JHsDB8qS69j3hWcPgNz4lRV9C50FRRH0WpYj54S3T?=
 =?us-ascii?Q?jiK4t9NeOBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9258.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g0tvgzeRtazuyjf0LqOAr3ODwPBqO0J5RpykADxfY9/G9kXlthd+Tvmh8NKg?=
 =?us-ascii?Q?6kkJdCYeEWNIj/k98Sm9tSk6azUn/VPgeB8dF8ZU0zPBDC7F31XmylzY0JzR?=
 =?us-ascii?Q?uTswUoOIemfA2c1W+8Xv0JeTY1eS2HetWkK8nBD8ciWIOTYoR10mmRqdvGJy?=
 =?us-ascii?Q?bjIDSCiXiFfuLFQXYarnmJUDxG+rj5huyeLIuyTRtWTm7QKI6+t5ohD68Fol?=
 =?us-ascii?Q?Pi3qyq/4cVgdpb+L5A5Zmm6dTesQH8hfBosTSiffGKBFo7knmb0zYXxlIgWl?=
 =?us-ascii?Q?WNLt9kngYJCjrbNjsNfrpmvy47PkMuz5ayRntuJHOACaZsjazVigegkUqXwL?=
 =?us-ascii?Q?oRnTcXo9kW4HOHQJf36IcpKVfa1sZkGglQcsaAHqhIF7Exrq+uSzOGPzJhW/?=
 =?us-ascii?Q?QoMhPlL1N4bOS9+jGt+bSuvujHe/0Jv1YrS1ltbR2nodZJuBWyU/N5TcJIHJ?=
 =?us-ascii?Q?C56sgB+0KTJiCvEmZy0W+2c0X0e/TVMQgSCaJKKVus/GvdH1DTyAu53TszcK?=
 =?us-ascii?Q?Ah0lprBjZJvopHSoRKluzvOIa9smdDOFgXvuFImIGTRKqtDDqmKKiEFfR8DG?=
 =?us-ascii?Q?1qEgOPiVZG7LtD+bO4MJmWfzLWWRhnWJ8zYbc29iDuSamqWvHo8YEkbua9r4?=
 =?us-ascii?Q?m68Nd33X5Hwa5EmtTPtiw0RMx4RrX2dCAtIB2wmpgpp3so7/l+fOqIfo0krE?=
 =?us-ascii?Q?tTThoKJ8aFqkFlQNuWJVbI3QEJOLUyRL2YCto9JjoQhu/hzNIM+zAy8Tm7n3?=
 =?us-ascii?Q?WZoFPDvZlCxsIRYradFb4vpus3km8n2ugHa5xShanZljvqG6xL0QGYYpEfS6?=
 =?us-ascii?Q?xU97Ft2Cv530iPNEYpBvzw1W4kGP7nHVxGZWwzQGcew+Qrx44FG4YaPCFJKy?=
 =?us-ascii?Q?wFXbCDUXEHGF0o/F+/zSfV29sAd5IUiFJaSQNPg5GTQ9JRtibqMsyl6Gwc9n?=
 =?us-ascii?Q?qp92V4NrTU3AOSDKkYCeO8U7zhySXW2nvMdJbyJXPsGwiOAaBAS+H9rWeOC7?=
 =?us-ascii?Q?h+4wQCRpaAV+SA4E0pERE5Cm3KggEa4xdsJTNAGe7n6xREdAFQq1b7dgEfOL?=
 =?us-ascii?Q?DbuYHL91Pm1rZkwZeY8N6EopJ1dV71Sf83CvuAKA3U45LrudKFCSqtDlRV3t?=
 =?us-ascii?Q?ApelYcwZMPG+fUFERk44orMeXlMQ+wctQN/94yOgfppHuNprMXS1BH2RGVuJ?=
 =?us-ascii?Q?LFTTxLcQrF+QPW0OzEqyy3zbKGNLBcoRkjpiFWvPW94BD5iAomuP3CaENLtk?=
 =?us-ascii?Q?JE2sIwZ/KMdLIBbR/X+VQl4jjmAlo5qshYjvog0UUeZH0G9eVZ9tvDAV4Gg9?=
 =?us-ascii?Q?mRD1V8+0Zxu5nsJ7Y0v31zEmH4aOtcS/ey+DVvsFHdK255PxfHmgHHzQ79Dg?=
 =?us-ascii?Q?cehs0WBSd4FPBu3pAwxBL7puZ7ctLBThicgqQXv4LNvoI95a9wGt5XboqINd?=
 =?us-ascii?Q?+TLbF8zf7N92ylAySGGBj2i7OvGzy7o2McapB+k6WbC/7DjpT0RQAhNhMRCQ?=
 =?us-ascii?Q?NKchqw//6oPGvYZZTcO7Syq5IqS5U6tlv3zG7VllSeiCoJLNFe0fe4imT95+?=
 =?us-ascii?Q?4WDy4N2C5icWXxCFA9xnIsIJJHv8/gB+RVmjXrbJFt8DvvhaYPPiGTDuomIb?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d36fd1-3185-410b-6f38-08ddaf3d14dc
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9258.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 14:25:03.6268
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: obiohjcY0XlFqwf1Liv+SAzwXXDtV+u/zkBFHjlzCntY5Xk+IsBE+4x5v81XRlsAQMQL9q43Ha1bXnIH20v3zH2j7zP48hv723YCwAyO0so=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6904

This patch extracts the AdvertisingData property exposed by
bluetoothd on D-Bus. It will iterate the variable message structure
and will construct the eir buffer in the format described in
BLUETOOTH CORE SPECIFICATION Version 6.1 | Vol 3, Part C.

Adrian Dudau (1):
  tools: Expose the raw advertising data available on D-bus to PTS
    tester

 tools/btpclient.c | 80 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 76 insertions(+), 4 deletions(-)


base-commit: 5df9521ce4d50ffa48153503bc5156c11e6ed26b
-- 
2.45.2

