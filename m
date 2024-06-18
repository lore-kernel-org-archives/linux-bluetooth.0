Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2043.outbound.protection.outlook.com [40.107.6.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49687153821
	for <linux-bluetooth@vger.kernel.org>; Tue, 18 Jun 2024 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718701130; cv=fail; b=csOIKm3hDuRZvPTBGiL7VUYtlzK6bKjsyG8shHRXpA3MygfsgWic88Halh7GyEWQSeSb5UUim0si8gY9K31yzY/t+0qoPZOTR7Seip++glbten91TLqfkdLbsxhfiRg2fXTSfjRVPjQ9WzqphPWIT4SugPO9dLAt9S4lVpDofcA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718701130; c=relaxed/simple;
	bh=RJRfxSlQeo8e0ZgFbaO4GUsIXX6mTqpiwfSmb4zK348=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=bCt9tvJfaDXQpnb2NFxcA8vm8+n/XVLDorfBJXAaLcWdECRboYB2b5SvP7zZMjpYVGhwGgTvCBvATQ5BFzYRb+2Y9nMCgbl63CCYmIeVgUP1lTumHa1TlYOF7Yd7W5iYvk06nimaqDvsit233+HlKLNllQQwkFohdy6I9ZM3xNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=aMmTUqgg; arc=fail smtp.client-ip=40.107.6.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="aMmTUqgg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RG7BnfL4hDWXwGus/z4UXl7QVkyiPbUAtjtba5lQ5D7YiQl2A2JBCjAd4na85MMrxzwjDImkweZpMxr5qRw3XnJsciRS9Q+G5cJZJj+0Cz0FAwS7E6vdQ4vZbiWoEFZoSPkkvq5lF8ZeJ5tXJjneZklGfbaMmyNt6bWRWor2Wnfr9zh67hOqOs853du2ByMMZKQ6Bl7ySUzesgCjod9oWMZVgx1fJrjdu8fL9uyC0O0581YqGidt/3g+63gc9sFbiTkIYXVnIdCpgLw3FcO8alAwev3YnxNCDPLGFtTDgXEa9qz7H51/ZHDbVecsZixThAZht/P8ClxDw/b46zsxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JstMCs/bWokzyoH9zViUD9X69qgp/x3PTukkXQXvHsw=;
 b=XJLQ69MTE22HcE3CikoSl2iB2OeRGgfv/mJnxQeT7FFmoSp2/D0bbxLxODURYut00iMz0d8K6INZbXlU1UOwFbNvlTx0VC0gqx/A0zWWOPo474wgIvP+/RALAeFGbhU7YJ1ELWMpaVuWwH56SSyMrYCER+qVystbXTF8Vue9lMjfb4k5ZBOoPSBBPNwQmm6JKyk0Ba8XgZaqC2ZJ6CqPcAO6u4LU/TqV3Jp1oG2jlSTd74VYlvnT7PAfoPwKEfPm9qgGQ6dPkDzA9E8LJ/KIvofI21H4fMD123dPN70AgxERgMYPWUJX9erzAe8QR3FlK6o57M1kFlpipJ88COuNWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JstMCs/bWokzyoH9zViUD9X69qgp/x3PTukkXQXvHsw=;
 b=aMmTUqgglMBioGZbYjwH2GNrUaSTbdsi+PncKeyuR1v4BbtoskoAv3tyJs5RKq63YrJiTO41D3j+v9SlP/yb4Yfcp/qWYyhdhiMuBgHYhZmtvaIUaUZNaDtj+1g6zMMazlEzGDy9g3wXj9vlN1tlKFr3v2ohTzRqu+4NBZ5KgN4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AS4PR04MB9411.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Tue, 18 Jun
 2024 08:58:45 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::2dc5:1126:ca5b:bf27%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 08:58:45 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Allocate memory for broadcast code
Date: Tue, 18 Jun 2024 11:58:22 +0300
Message-Id: <20240618085823.30798-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0026.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::12) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AS4PR04MB9411:EE_
X-MS-Office365-Filtering-Correlation-Id: d5b34552-215e-4895-b646-08dc8f74dbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|376011|1800799021|52116011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eihnJLYECnQOb6uvyAdgjqzpX7IcQDotcXZ9pkdBh8RYC57LM5riQuSEIrp8?=
 =?us-ascii?Q?gXu8X25aG0506ZCoK6k+6SdWgVgUQt58aiRFy5itBQE1xqyy8/BOGgQA5ba2?=
 =?us-ascii?Q?Aum15sVBri0TeefBFMyMgpglqB9VqRYnUBrWhIWmMZ3MQN9ZqNg+seKd0Fem?=
 =?us-ascii?Q?wDuqF7fwwStvl7PZEG6W9tTU80v24iFGHs+nvI9MsWTIlYsb3rHkkQB+HM8V?=
 =?us-ascii?Q?XdncUm3566C+zvrxctoiGb9dwBBPKSDpPQlvrNb1+oY2NhdX81GDCThLNgzO?=
 =?us-ascii?Q?xEhAQQr/ws/3Kea65K1gmEMBzKzriAd6yNHmfzr6bHOXDgbQvExA1wlu4ONj?=
 =?us-ascii?Q?HO6w7pTKdqJv68skqfKHLiBoJoLtLO0ohbu+EcEgJRMaPp+o2EzXmwMPA7Gq?=
 =?us-ascii?Q?4js0KpsjpQXOV/Gyd5TvoMfXz9flx5zf4Tb9xc/7tgu5Fhtdd+DahVjdwL7r?=
 =?us-ascii?Q?ay2DdxykMgVVp3X013QHc3jMHeX2/bESNOe1VW16WTr2fhZXbyzZO+pAmwig?=
 =?us-ascii?Q?qpVuv5NAU6d/4OmPM83chu30EG6Pz72a1cfXbM5uFxidx04AzwxWgPfg5nti?=
 =?us-ascii?Q?/C6JFxnvFDy7A0b1t4gc0l5j0SEo08/uXM0rTgpmqbr2JxclCRPxTorflwRW?=
 =?us-ascii?Q?WytaoHd92kwpBybr0hv9t8SxZ5cQHLKm9b9wlZKu6mKZd8YS9fItr+uZbWxn?=
 =?us-ascii?Q?L9Ly62B2OEPhVffH8YCBA270Ou3YXolujFY45Pg4TrrYNONXeu289I/oksdX?=
 =?us-ascii?Q?ZW8/+g+3cj0IdyAkY/1LdBziLuk7jA69GoQmiceRA8I3ya94xPbmR6TOMPzx?=
 =?us-ascii?Q?Wa3BNarLhkuwm6c3xBYqxERW4bUlhVSzw6GnhrGX+EgNxajgsGlKW0TZPX5s?=
 =?us-ascii?Q?41gjsmv1dlRD/rXSUWr2Kn7xBeXT7MV6op66VpO/Y3c6666P/JUCeAdJsLwR?=
 =?us-ascii?Q?PKUVJKtDXHrvvg8rnan4ALIZ6k0LMsyHKdnwmPVKiF+Gpiucij5roixxoFQv?=
 =?us-ascii?Q?2A2uvCb8nFcBIwnHGMo9OVePSb+6tSg487iPcBZsPQStfnP5BnLsh6lU+439?=
 =?us-ascii?Q?aDoLVNR2L0E1aRbLQo1SteDGW6xl50K0ss48ujrwmdFgaMdplUuajw2yMCz6?=
 =?us-ascii?Q?XQl6kZ7t4RHwgsO+JtsKl3jS8zsVdVailja92lYnyZmeD+f+WKFvz7IxPt1J?=
 =?us-ascii?Q?ZxyRQk9vrxi54iYMn0zz1So//yIntaB2H6fODmVeOJlHBTdVX92YpjB+CxHI?=
 =?us-ascii?Q?TuY4ZEfy8niy1cUpyQW7egY8dbK8+57o+CVwZKMk8OM0AaO9GqE1KDUP0I2Z?=
 =?us-ascii?Q?6XsYXHkFIyYjDUzvuXxGFXp9sMXvmUGB6j6y4z5IHUSXa6cE2EFSW/z52bXa?=
 =?us-ascii?Q?qz/1E9g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(52116011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?n4PaSAHxiEBECZkngFJacSRlLM8FL9MBKJGq578HDhf5EeKIOvZOLlgdjLmv?=
 =?us-ascii?Q?2hB3pfRYzcnDwqDIh+2IoskX1RMX5lRDGemQHt2WQNYo2yjwTontTv4st0yR?=
 =?us-ascii?Q?IP1EvOV/4ZxfApmH9kAbV2TwnH+Un/0DXMqlLHjA8BfXiaMRGYVJp2RokHSi?=
 =?us-ascii?Q?LIDp6BZ3Y/IoiJPmEvLcVofhQLThkc7Du5VkKS3b/WXmwI1zBUnCzOQup/ny?=
 =?us-ascii?Q?F37J9Rc+XDWpc+cyv7dkjw4JIrOplkcK9gza0yfCr8oEEykp9avtZZE2tCmR?=
 =?us-ascii?Q?bFeKYPyaRN8K/856yghQxreKHWZMq4/7JMc+zIefj/Bhdykb52E98o0v7BdX?=
 =?us-ascii?Q?DiT6ImJPDX7KQDpzQh8eTmZcqfXgCAewwe0hr7CnvKdnPQqrbYr1Pg1Xh9V9?=
 =?us-ascii?Q?/QlmDd5HQRsKifrO9EDRdWemVUkkqLByIIXgh9NE/htO8KU9LCRDqTG4FQM8?=
 =?us-ascii?Q?62xq18cUxs9w8LkxLIoSGu9o+pE5wzyzwyGXUEMfnv2v7mGZFG8O1MecQSae?=
 =?us-ascii?Q?ERF3uFwyy9b5GAykBCclCgemdkHTHV+HIrIYQ0N3FisVvFSDLSnnSi8OFSCq?=
 =?us-ascii?Q?K5u0KUpPMhrQjpf8Hpk4qvYAFLwILhkg9r3mNN87WBicCqetthEnyIGiAK40?=
 =?us-ascii?Q?0UPpc2ViOW4Q/yd6iSOiXDl4VxVwg39YVcGNnPlLBYdfJ1n4jGwMYj4aOxYQ?=
 =?us-ascii?Q?aTd46lx2ZwxfOOcUr42kbxh5OVCLNXNxCnhcw/EwzwIOWW8xlXLiNbZM9Yqd?=
 =?us-ascii?Q?D3nyYuiCHnwEphcj02J5j6xCaBcuaj6hcdljn0RPCFyO171EwoQA1b+PTnhi?=
 =?us-ascii?Q?qAQoDdVvvvYbkw/CJLfrWEhM0mvNCdFyLzr4Uoy9bv0W9O88IgOCCqFzvSwn?=
 =?us-ascii?Q?R8TUUq6AHYpjZ6DJbltEGEpmlEVNuWQorFdgbCh/Uc0OQAQdCA1VZXmCj6EH?=
 =?us-ascii?Q?FvML4l5XMBWNsHHeovIyQE9pwdbVXADF+Og/ZtEono97BCBRB6G3UHs2aO7/?=
 =?us-ascii?Q?smY13m2ix8HCel1OANhZqgW4UwZWeM6wW3mXphxXLbGQwqV1v9edB6N1lwv6?=
 =?us-ascii?Q?2h6sY3zdzCoA/JCyFPvWKgGBRydGdWGNZxBewY5/cEdfEC0hxqgxuWOlqIRs?=
 =?us-ascii?Q?Ma4zznj9UctdKQuHsWvEzDnfvtB46/o5ILVY2P3Dm4hO4DkYryEacd029qQp?=
 =?us-ascii?Q?jo5iKOaKZ54HRRdgpvTo8mMsEEmd3TKI1hnEFZqnQrTbs0ns8i3kzIk+cCxx?=
 =?us-ascii?Q?BTnO/OqJELQiZJcGxFIw5O6+zFGeg/76Bz/5MiHRdFnOivkbLsE25w9n8WKm?=
 =?us-ascii?Q?n9EYxZ1x1Abpb8Zao2uJKnZavxPPh9dfEvC0kks2WCYoT8Kz4avK897VVwQp?=
 =?us-ascii?Q?VQjPhgBgqUrng1DfSQjiwA9cpsNEGIcJGJEWQKbjX4mkuxtEcrZlo+UJaqF4?=
 =?us-ascii?Q?1c5ogadZp3UHBuZdzT603wbPThIaZLcxbdmYkjeObBYfxR1GQ4CcVcgqCdjY?=
 =?us-ascii?Q?5wothvjQDHWBoHNiRSQLaukm4hLF0ibguUXQRH9bTYBhWObs4OFrL3YXM9lo?=
 =?us-ascii?Q?PlRRGsrPh+Mrzc/+/CkxOGXzctnnTKAqX2K/VBGt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5b34552-215e-4895-b646-08dc8f74dbd4
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 08:58:45.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UHmgptCp5vrlRV3tlqRuf8w8vn8PRzGhAOg+3boZEcrX45IJ2o14IZd3K29wYCyu7iuBRdaeUjw2ocItizVRcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9411

This fixes segmentation fault caused by trying to write to
unallocated memory.

Vlad Pruteanu (1):
  bap: Allocate memory for broadcast code

 profiles/audio/bap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.40.1

