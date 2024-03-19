Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2078.outbound.protection.outlook.com [40.107.7.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C162818
	for <linux-bluetooth@vger.kernel.org>; Tue, 19 Mar 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710861584; cv=fail; b=ArppnzVYfkH5w6D92fHfTemvO93C44QyMfDf47motlZUqoJHHb12DHh+vIrGhNh8dmnK4YmkASAyJbtaedWLZPF6+Z4Yt43W8BzzbywKnmt8rJq6IzPy/rXncqdEypp8T8uGZ+0WI/29xzHjExYg5jIuEvoYgi1OMgqGxtSc6zI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710861584; c=relaxed/simple;
	bh=5787AC1T/GDXBmVCMQno2LUal1q22B0DgEI4GfOamCg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=tl/lcPbiBnyLLJISF7bA+jdo4a8B8/W7xC2Q3++lbloIL+NT7GROUX+bWDeizldhfDMOXP5I2DgIGP0fSB7B2cTgqRDIYzAWuGOjB5cFY8TNwiAdT4FWCyNAVRcD0B4Lr9Q1cZZY6K+nNCdHVJ3aMI4cSG2lKEYjt6uu7TgitmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rueO/tQ9; arc=fail smtp.client-ip=40.107.7.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rueO/tQ9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AFWEBoat9bzh63gkHSTTJMOfgD8Um5aVWkEseYz1gtiycGuMXAVfUkuo872wXw4NcvjKoCOXE9IeXioW3FL1KL9puAQxObh3G4xY7yq+89sZV0SkKpdh6eAEGDjLFTxmNtv0Kst6o9xIqVUXb2tduMQ4b/B4Dr7I7J9su08CwN6krrU+g5scQw7cDknmPBg9iNqg/dH/lm+dtbE1RGdkeF6svYc6XHDpmmXDSuFjjNw7CB0lrbW6L4ta4CoqxsYC3rmAL8fLMVMB8GfChCkz/uYZ1Bc1nSlPp4PjOe5UhiSszn816YOZ5h9KKhW8IhJPuN19G2Y8QVU08ajqGlPk9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bN4YslNrVCa+4eugQdhBpbE7hy3ERvxBbwikm36Djc=;
 b=CDFvdhxVuiCf2uNVqKSibLkzEG/tlX15m52mLBeNo2pqrmPocrfh6YYfPhwlngXdcw8X9XyaMEbpPcRhsB5ClUEsw/UxOh01t2dP8Epjsev4WfmkRwykaEwvR/2ssg5nTX2E3wlm2nnL6uREJsG9btvXf9dxJ6ze4j1q1TZSWpNIASjxS2fMpxmPr8iy0jcP2ozrQnbU2m3YcbP+F96MFF82tBIO1ODUHV09GcIgMYsmit6ZEysCmyu9J/hI2f6+HEiZz9OzeICvf87ima2rMeLNgt2+3jYfmzg6NEPYX4zFK3eU4C30CNW/BRzo6pI8EJQikYh5d9w5L26BCQi4mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bN4YslNrVCa+4eugQdhBpbE7hy3ERvxBbwikm36Djc=;
 b=rueO/tQ9j04t4bhuzPpCMFT5TJirwmacA6DWk5Buer40XjL+KR96J9TB2w0We2zXGCiLWNbNY2zmH//aa5boQoXPe0LCG73sTXo0xlDIlhlcbnJuupxlCX+TMxQiAGP1X/hjK4MrYCMX4SDwbpCrJns2aR+rpclc44PHOzRY/UE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by DB8PR04MB7177.eurprd04.prod.outlook.com (2603:10a6:10:127::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 15:19:39 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::58a8:b333:c024:1077%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 15:19:39 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/3] shared/util: Add util_iov_append function
Date: Tue, 19 Mar 2024 17:19:14 +0200
Message-Id: <20240319151917.834974-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI1P293CA0024.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:3::6)
 To AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|DB8PR04MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: a8ca8a4c-8b25-4391-cbc8-08dc4827fe57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	erLl7BjNJHUhB85Jv9L5VaEIHriRJUUBHhygQMgUZjQPsn6PoeXA/WkVBjJSShH0wtq1F5T6W4Xcy9/WmwXq3wSmvUpyRZ7OMocd3I5cs7V4KJmHDPc+KpTZ3oYtSGeUyyk3xHKfI13H6gAw7eRmeTLDqzXIfZ+0xH/ICFckOgQkp/FZp59NxSgxF+g2lgYNxYNGSP7s6/pynv9FPyQ34878c33czzFH+A/D1K5pBqvgf4JBIFRVVza5sA0vYcQLHHp2x7Ypm3ZHLiO3EgOt1n/b27BEB12WJIDuEdhdNR2nyh8Y4u7zYPLMCXsAbkq2IM4QzeUJ2YpCp2nJRyPulmGB6CDiy1kw2AVczyFmVy8l8IgaXS1Vxv6omMz4DZMj14CIMpwREUghcnsT8HPGZDfkmm9cKftvpoSKY78r9bvwW0ycJus1IhofogbDz0k3HPC3CE2AVDGSJ0EYYAyZjVl0DHLYhjjHjqCL5piGDTu5Z+3j8tnOWjSRBF2BoADoqtyxt+7s8he8qepiC39D1KKvS7N+b6Q6CpxVDxUblbJGFh6D3EkqxaReEp181yS/MlwNsHOMakZLw7VcRpS50fOtp6q7bf8VasWtWWcitOuaOYiAf2EtuQpgcCgPNKraigtgJ1BPEdzJa7nze/oQiiOidiZZ3QPE3y5PrA3d3oOLKoUvMIBhneUwKXbf2HPn6leeij24fjSHDQEERTxpUmnMUq+yMyefhaeeALLRufM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(366007)(1800799015)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sO+9/KaZf9qx1I0ZWpJxwOnhKT3vMUUokGh/HCYkcphs/D+6A0G68hZgv6vd?=
 =?us-ascii?Q?m6WXFZ9XZ8TqtixsSEgzPRoiWthj+4zV5JseHiBBYqWiXXMf8MSb09KcuQCd?=
 =?us-ascii?Q?ekGzS9zNyi/z1afLwlGX1siC4WGICKgsJty1av7+gsRcEvEZZffq2CVWXhqF?=
 =?us-ascii?Q?AxTJKmK+PZuv6ZNVG6WXQG82uwDgs4rFq4bFsOLWXu4Gz9NUBSqsus1/Pp/v?=
 =?us-ascii?Q?dMUEb2vRPSvGi+0iGtjEkgIt9+1yaXXbzeOu9XVY06VA+9LC0tMWrGhbyYSO?=
 =?us-ascii?Q?oRF2nMf4oWPRNoKbAjSZ5V8d7xCSrc/KxfRz2LZAkTp70P65hvdWzms5+hmd?=
 =?us-ascii?Q?pogVEamKPiBopQWqp4BUk8UQjTb3SNTUPJBpzYlHkIvzkd5aCLki5442B6JY?=
 =?us-ascii?Q?3X5la1Rl2JJrsec5J4Abit9cqIeouLv5s6ZJO8UAuFgjiHOptuipkuDYEl5N?=
 =?us-ascii?Q?CwR4JHCFYawxTwxLnNGIL/vOBNgIrJb2vMdrf5hsEKb53vwtrqSOog7bUiRI?=
 =?us-ascii?Q?Oe+sLnEfrg0HOHR5eyQ1vlTLNn9zq75r9jn1ZKdykTJarK6kLz5rFyvxBVX0?=
 =?us-ascii?Q?u+Wtedl/lamHjIiDiTxdBAMJace58q2eG8NMLImQoof0KrXnjplgw9Lm/bio?=
 =?us-ascii?Q?bwKobn5rL/s1aAcvxNxIfZR0y7ezByDmHd9FQpqLe5oBsuc75ZUbyU7eesz3?=
 =?us-ascii?Q?9tBv0amRieK/YdVizreBK0cDfaHKm4GjM5bsXj07eTRqnEn0zBY3tMGmPHkk?=
 =?us-ascii?Q?Ybplq2jQcc26LWhxZEOfK6Q9uyLUj0DjIGgobjSCysIN+UsEmooy0XufdtPh?=
 =?us-ascii?Q?qreCrvspWmSp2h5fUSztdL4fpPYoawKZ8IrIi3a4PirF3ExgmJH8RenrnDNR?=
 =?us-ascii?Q?bTFbe6tFQvC0H6dzWAMGyLpiB2/HJcPSxz5GYFz6kb6H2+6Y6PeRmpkDlNah?=
 =?us-ascii?Q?DFYatD0+FfHInlixib77QT/jSj3uWFbd069+Eyh/Nx0kDiZrek7aCM7vHqqp?=
 =?us-ascii?Q?b9Qfqq1LKtNe85zb6xqh8GLlidV6IEDT+ulHjXrgej83C2ttGHshByx5reyE?=
 =?us-ascii?Q?gTfEbsqpnMVkjg4WI1FPxxwMS5KLU1cl//a2zh7lJ+H3huWqphkNbJOytHhK?=
 =?us-ascii?Q?G+9G0MReSEUR2QmBi6zLU8vl9zxZ/gtr8dFViN9QOwV0k14SzUcnIdh0GEf8?=
 =?us-ascii?Q?+L1eloLA8CPQ9urTbcqYmN9rSrgG1l7ZViDeZ5ZzmMnlrj3D7N58x68epd0x?=
 =?us-ascii?Q?lyTRV2FBBvj3a2h24h0rp3RYT0/Iqni+C3h+pJeIPSuZkFAPFCXAhZd48YWF?=
 =?us-ascii?Q?mXL7As9ICXB1MJTeWz3yLDsoND/x/rvWNZYC+nYzVL6qSoM2y+TTf8iZvD/M?=
 =?us-ascii?Q?a0tHJhc+JaOrpHAnUQPe2BNngQx/OYAr/rZx0F/corX2pOWHJOyWUYKp7G/Z?=
 =?us-ascii?Q?wWf/MHABv1/WUBTPSPMGPYCpUy3hIIS5fqDrqXBK48sPZgJVELvwWcAAAoFd?=
 =?us-ascii?Q?tzFK3HJ4OigCph03IKgmt9ooicplo6cUe0zs5ZROilkCmp7bgYzGC/WpWM/4?=
 =?us-ascii?Q?wKWixXnPVKhVo9LnfANWBkrXKc/1Un3j62CLv06O?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ca8a4c-8b25-4391-cbc8-08dc4827fe57
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 15:19:39.0130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+efyxVbOtjnEf4cQ2HDjRgiTZO6lCqWOev3ulliwxH20NyQWjmZLtlCh/tcuIXmUacoyKtIKGxlCkok0/56Lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7177

Currently iov_append is defined in 2 places, client/player.c and
src/shared/bap.c. The player.c implementation is faulty as it
does not allocate additional memory for the data that it appends
to the original iovec. This can cause buffer overflows such as
the one attached at the end of this message, which was discovered
while running an Unicast setup. Therefore, the implementation from
src/shared/bap.c was used to create util_iov_append as it allocates
new memory appropriately. The existing calls to iov_append from
src/shared/bap.c and client/player.c were replaced with the new
util_iov_append.

==131878==ERROR: AddressSanitizer: heap-buffer-overflow on address
0x602000059dda at pc 0x7feee2e70ea3 bp 0x7ffd415773f0 sp 0x7ffd41576b98
WRITE of size 6 at 0x602000059dda thread T0
0 0x7feee2e70ea2 in __interceptor_memcpy ../../../../src/libsanitizer
/sanitizer_common/sanitizer_common_interceptors.inc:899
1 0x5579661314aa in memcpy /usr/include/x86_64-linux-gnu/bits/
string_fortified.h:29
2 0x5579661314aa in iov_append client/player.c:2120
3 0x557966132169 in endpoint_select_properties_reply client/player.c:2191
4 0x557966132a6f in endpoint_select_properties client/player.c:2268
5 0x55796616e0b4 in process_message gdbus/object.c:246

Vlad Pruteanu (3):
  shared/util: Add util_iov_append function
  shared/bap: Use util_iov_append instead of iov_append
  client/player: Use util_iov_append instead of iov_append

 client/player.c   | 35 ++++++++++-------------------------
 src/shared/bap.c  | 16 +++++-----------
 src/shared/util.c |  6 ++++++
 src/shared/util.h |  1 +
 4 files changed, 22 insertions(+), 36 deletions(-)

-- 
2.39.2

