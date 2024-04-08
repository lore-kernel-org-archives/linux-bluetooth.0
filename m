Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2121.outbound.protection.outlook.com [40.107.105.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B53A1CD21
	for <linux-bluetooth@vger.kernel.org>; Mon,  8 Apr 2024 14:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586470; cv=fail; b=Wp3zNgKR/o02vCU7ZZwPfwt7UgJo2zV1nlx7gLBM4/Vz8wHcXYqwUwEHmEtGiVST9trXMKRDzX4HOeNCNMVydLRngTDV5Fl+XhtK807XTZUg49HBoz30uMi4/8L+trYut0g6Y/YhzS0xe2J846vDoNQS7rHNBeJtL/QoiuXfpjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586470; c=relaxed/simple;
	bh=cyWz7wCKxZmvg6vdcfaA3gn79utzb7AtVFkCfdwzRaw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kIZriy6oflgTyfXR08f9bJEhdSnnFnwzwgdS7a9dJopdvsgfE8F8FULFenmGfI8VL5si8QzTtdN5VzbdI5DNYuV+lRePYQUWUXa0n9tMzkc6Unv96guDj1mlbNJJal8Ocl/x/noF+/21wXEHU6K8Sze3XX7BBoVq4NWOoNDCajE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gnzb7E40; arc=fail smtp.client-ip=40.107.105.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gnzb7E40"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lvIx271+TAuW1EDoNLphWBxD1o/TNiwuQtfW3y7h5n7toouFTyIRTN8NZBOvNrf7HGlFEwtwVCZZ9fbq3TPJ0lljyPxe2qpsxHJV0hbMV1+KR5hqVgtnYGob5kYF+xVzZrpybhxzWwcd0IVzJuMwqsvH231r0SLsUjG5ohdAO6RBWzy56bdUs0v+/TwfP0N4bByD9arv2AK0ZwoNqCC5WADCdEJgykalT966J1+3mzzvDzXNdQ6Zjd01RJsDrio3hiQ0/9jEDsOe7oS5kqVZPxWalF5umX6R2Ce07tu9ISy2Ul8sZHlEkIvWNWqD0UA5OlOITa4gj6HNZ1FagN9UCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm/9Eyq/ApyzA/YHa1pobA72K6d1L7vaYem6ez9HteA=;
 b=ksiFhCb/JDPUfeV2X2X/7a7NR2T0yU9cJ2HOzjysA+XGfBGV44ZXoTHZnqntwykF9j50scGaE2hzli5H+PsldTy5TX/BRLW+oIydEphWfP+rm4LWfZGjsCEdXwkU9BH3+q6fiffFPtN28tBD48mt8LNTdz+Jsjxm7ZDvPOUTpAEmSKI0aJA7Xtcf5xyfFn40axxmpLDWQ2fAOdSbQrEFDB5wPyktIpXz+GzpPOZIFs53KombZtIaETTLY9nbqi3ZzO+bbzq1HygFMVBgkt/HOAnqMTMDgF1LVJ2a+mJCQsO/qMYOyWKjq3KmYZeuM69ruLRlfAReNqAtb5tKcJ/l/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm/9Eyq/ApyzA/YHa1pobA72K6d1L7vaYem6ez9HteA=;
 b=gnzb7E40fFRi5SiahIXx45YfUORpx7c1/ipBXVI7aAxYCuLdLR9kS41cQTjrQHwn6v+kw0tdzUfogrsV9jCYOvLSSfixvjsglfsBFEm0GHRIuueIa+S8OmO/PM7cV7KhBq7rr8vBXCQ9obfR9pCCOUPs+i9zeWTRIheHdChbJuM=
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by AM9PR04MB8924.eurprd04.prod.outlook.com (2603:10a6:20b:40b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 14:27:45 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 14:27:45 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] bap: Replace global bcast_pa_requests with a queue for each adapter
Date: Mon,  8 Apr 2024 17:27:23 +0300
Message-Id: <20240408142724.12511-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::20) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|AM9PR04MB8924:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xUKeGHvhVrG5R/B6hArqbyu20gQerQT5WdgVYtcWAb+hlMbcypLLBlPD256B0qy1T1qhOGkoVxzdg5yt6cB3BTSJ1scEB4584DQmmM7R7IJb3xe9AVdfzTIKCJbyqjVHWKi3N5IwQIF2CZUZ9k3akDW5hMTbaVui6fTaivivA4EtKWLQkOD2S7hGs67bqY1SX5nxetEN5WfvOSmZ3JgUCs64HxqxA7HkW/BKzKTolGz18ldQugr+I1fMAtHG2bkHsfpBDJ4vFwF+C7vqQbX6jd92/W5ngBb4ophuMvb8C7Dp9djjBSa2j6JjwvQWrn2IjhFympj6kGw1VMkhmBqXrBAhbYqJrh5oBgosbcUYCjOqBF+tTykPHhrSlGgm8EGuH5U1dGBPjRxSmn7mFNorTXyrD5nKaWrZyPb9pMrMeYTpzAXqh1SlJcUQCiGRXwIKxnMhz5yzuNvaut20kQdjLEZkmUwdSBIp3DX4prHwD9MrjzViKqtJy8y7hrF9kkj3j/QPVRMQzqkEkjsHjWs3rdw5UuugHa+DIzuCK52xe5XcDrKuxPMfooMwVYohGu5caw3rgDyTcYVV1UqR101YGbkVZo7vQQFgu5zBLwGwYUCLUks7tVMc25umevkHBS5vCNEQ7yTWxU/na0SG7GVyIvV0d4LpFmzI/OsHfuzgH8pclohHWs2y437rEXd9dpyAtXCDEtL3U6enUQgu52xDm7ivj9kqYA5lRZxZ/b5KrPI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EGNlyvBFBVJPQwQk2VICuULPxTAO6cYfHipP3EfHKllB8BLjGYOocOm7iQeF?=
 =?us-ascii?Q?bDNpW2SaDRhrFOMsyDP6f3g01DS8GZ+CXLtECpggfWif+41XdAHpDoyiEhZk?=
 =?us-ascii?Q?CpqdbMaBN3tcNi8CcWOBmya5bpnPb7No4FOMBLqt9SqRjNBAOcw3uBp2AiiR?=
 =?us-ascii?Q?x2/2ntmGxZoqmu+9Qaq9k2ameG4b95LAUAdN2wuz599UOx+O9S3La2zsPDBV?=
 =?us-ascii?Q?wysJ5tuulJc30aMl7jpMk1luhwGdzA9Ry6xSfKRAz8FLH1j2yz+cvX9Im/su?=
 =?us-ascii?Q?cAsoVHEu9rlMao6fN6BqjZNp2NDBQouPmMp2f831/r60ONF1tS7oV3M8dBWF?=
 =?us-ascii?Q?G7Dl3nNRoqpRTSx7S3HsrTgGV5eSsR+0mvqQKHEJ4RKkxF/236XWb89BTyPf?=
 =?us-ascii?Q?7eQY/XM+yC5L+HRFzUccW7f+fUD32RfU03qPaWsuRQin1pCy6wVXUB8P2odt?=
 =?us-ascii?Q?ofG6U67P+oFfCFqeliWbuGG+x9hEjlnrrHwQ7ZXzdtFVt+YPSH3JA2k3GbiQ?=
 =?us-ascii?Q?IfEu7OLBywn9kF67Ug2LHsNKAeWMix2ws4bz1OcpfCyZDo6qIbMy2GXgH6Oy?=
 =?us-ascii?Q?jgW1z8ed7zRBXLfw2rlsDKjVUjrgGYSc1tFmUEhhzMNYQEBTqSYbPVOO9oaX?=
 =?us-ascii?Q?+bfbDiKQMKS9pX3+SU5EYO+id01HHM3ZgkuF+vMZTf9YCr1AkwHX7fzgKuYr?=
 =?us-ascii?Q?ncP+krcui8glTV2RX6oSZevNMj4yXMCEDTrTszGosA7WMo/aYoKsTslmrlyB?=
 =?us-ascii?Q?o4UMldRmkj7+OuDtZdUKH1LP2xc7ogIYa38lp+6tSuiIodDZWWIsNz4EvwOD?=
 =?us-ascii?Q?oAZgh3jUoeEEOmoNMkXIGXDvwns10XFQf6F/xvQ+F37VAo34CdqpmO4QY3Sg?=
 =?us-ascii?Q?89xpG1FrhcsLEoUdtBSNW0L0jJ7Qj/5hCJ8naTwB8ZzuSIFRKH4gqGupH3g5?=
 =?us-ascii?Q?L6bB+lAJIxBA6ND83E45gFN8lvS7vlfydZE99+pwmKYRc1YcXYYxRH88YnXV?=
 =?us-ascii?Q?lOVw+n9bcrYyCMA+EZrxJN/0ognijkYAfUHy+gs9UgzQRE+H33DDCHBWd8bG?=
 =?us-ascii?Q?CPwhrfS55zQQO6d5qyMqT5RBCd+s2cc5KObiEquZcD1KlPLaIGm4zXazD459?=
 =?us-ascii?Q?LfoRhuHxR8cnA02Jp/LEh1+a48Yxu8WjIf1Z7Q7nnIc7RSe+3iD5b8HH5Saz?=
 =?us-ascii?Q?5OhxQuhTALZDOl8tvOp6vi7QIsbVLD8hY1O45Mh7iGlzsS+yvKF0OO7h12y2?=
 =?us-ascii?Q?2Zjujv4sk8DmSVgdyse/HGte4G6ljG8bjmCdpxoXK1nYEzJ6RUH+Yg1cVb1o?=
 =?us-ascii?Q?ktZIiFh4Up1p+aNUn/4vAbSFJZYiCdupdVZspiKaxfrlPg3bJFuVr+0e4LAy?=
 =?us-ascii?Q?5aAFsTqAKwyqKG1WOZf2OFxUXgdP0zxN9ZvRRWW/j7o3dMlPznis4OBGIgL0?=
 =?us-ascii?Q?TGpyZS9uTAZVfiOtAkUhjY05yejBPKQvKELmHWNSWXirUBnHBNC+GOGuNXi3?=
 =?us-ascii?Q?S/Aha0Vd/rJrSi1vxO7F6+FlahcmFD0/X/MfzJR8KKvpNxmW5sgywlgRNdMT?=
 =?us-ascii?Q?ev7P9N3nnMQlSFY1IK2JsnVPJRHvcIwtMXD9Pjia?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0ea7ec7-7b31-4f2a-b40f-08dc57d80e95
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 14:27:45.1253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yhBmv8RWf37UfHw3jEBPp7F30X8s3KOe+4EqN/Ue1AAyLs8Z+4VH7QxfwvzZBR1UJcQEBpIiDY7XeR+1Yo7Qsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8924

This patch replaces the old global implementation of the bcast_pa_requests
queue with one that stores the queue per adapter. The pa_timer has also
been modified to be per adapter. The timer is now stopped when the queue is
empty. The bcast_pa_requests queue, along with the pa_timer_id are now
stored in the bap_data structure. Each adapter already has a coresponding
entry in the sessions queue. Operations on the old bcast_pa_requests have
been modified to be made on the appropriate bap_data entry.

The bap_bcast_remove function has also been updated to remove from the
queue entries of devices that were freed.

Vlad Pruteanu (1):
  bap: Replace global bcast_pa_requests with a queue for each adapter

 profiles/audio/bap.c | 109 +++++++++++++++++++++++++++++++------------
 1 file changed, 79 insertions(+), 30 deletions(-)

-- 
2.40.1

