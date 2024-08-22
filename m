Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330361C9ECE
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332385; cv=fail; b=GkdALx3ioReBhgqQfKCZMVgp3o/bZQepYeHL5cRJvXUdWPhc5mdDiJuJKHisVR4Ms8HTR/rTerCzAz3gvqO/uR7MKvA8tpgTnNtuEonMGkuzv2yyeE1WKCP1kK5oQil9AmXNNzTdyeUSWuk0iNH0qIMfQ2cOeU9SNu4Dh7MlRXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332385; c=relaxed/simple;
	bh=Pzu+gROpzRbssfrGnlhWMqASjJFJFEjMo3gTgOVB/ok=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KYwxBdAzSW4SBw+695w//tsX7Iik3hpg3zw8J3W7dVjbum6RDg1WW2GbgkWuxovzAopFFYW41GP6Dc45o/JUjwpc67jTlorLHAjXW3TOtiFp0Y6V+wLpTKPDSGtv2fQHDVUvZZE9oroBP/uI/bXCImW/p+64KumVhxBFyoc7X80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ceSlgEIQ; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ceSlgEIQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPrkSnwq/Xy1iOGmr57mlnBw/DYHRZjc6Vn1ISrmfpeoRanXrGjZnTgJ7xzhbroENNAIkCnUkUF7bY7kblkECmrqS7oPvrtNfRCugsOIT7eGfosS2/1ORtVom5Mvywrc9e7CyiBylvT2yA571OrLvOnLjiK4DTs5paY3E/69MDlj5VlLVpm4IpndSeWNOJzoscQZQPjlrYYt09YG1d0ChkxGzvSb2uYIGpL7ztjI5aiCk5U4DMPeGbuUxXASx2yOUwa7TfEVLtOR14B5eiCk7C0LZkBKGuu8QQD29ZblZYCht8iGjdjsK6EMgjTmh0lUF8O+jx54Pl5NeHLgV7eyeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/NjdNHeOpBYHMjUGREWAFxeLGDEAPTXZnS8eJbUT9Q=;
 b=qhBzSSL9wmUTTtz9FjbN+6Y9iZK4awAibEXFr8MZDy1msNqsjCS6yn13sKwEfO22o2DK3MnhIp0mFDFbraboj/HGIXJuAajx+1Mk1Q0rERdVruCorqc0WQHIoCOarOkMbhlPy481ikwhGH9/n8+3QxwFi07s2XelVbrvstLSPoTdJ5O6fn23CbxMeXnZ+gs9z8m0Ei9IaCA/0eofK55iU0tGGFjEcMug4dLN7qh1ITJR7xNNyt87T4YUZ1ZAJN3fwo8GvPXrMUp47tdMEvbPnCMBsemmt0EqD1EfJ7hAtPPwOhLoLYnHlTxNXdsobp4zxUcbRSHDQUPiC+h25E1hLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/NjdNHeOpBYHMjUGREWAFxeLGDEAPTXZnS8eJbUT9Q=;
 b=ceSlgEIQbkp1yeNmJxBcav18jYra+fgqTURS54msLnjToy8ZEy+XC/TzLZXg5lSKN+RBFb7PNOH8GyYIgE8Pr4Q6SnkYCUM/9kU3wAp3D8wUt4QW4d3EpE2XPXhq9rDyj7Mwi/cf/udGTTgjWR9eFu9Ynm1jwF3vg2bK/wwiPrC1ICg5zJ5Wu6+RFK+f+OrFdGF4rASy03ApBqU3QoEMiD7jvds0/z7+bk7hKpT0QjIhzmsH0yzUhImIqV7wRWZry9DNr5JBzeaPCcq2BL9KFs3GVOW2l60bjcBfke3Uff7/PoiPB/Bhkl8OefDbjKZnnxAMdVLj9ZT06b/lCUgLfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:13:00 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:12:59 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 4/8] doc/media: Make QoS property readwrite
Date: Thu, 22 Aug 2024 16:12:28 +0300
Message-Id: <20240822131232.531952-5-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI0PR04MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: ec801d10-684e-4470-6130-08dcc2ac2566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Flsajj+XIKxmjXvfkLLSfiZ1nCf5QTwmR9h0VWCtriSckenFdGr55awQ9rgS?=
 =?us-ascii?Q?ehg7/Zyl8SPrTVqnWUOiJxJk6lpQfSSN+bOrrrJIvb8WhxqF3UNdmqqmocRD?=
 =?us-ascii?Q?5EYvxnnryi7SabhykXScslLhfoV69xVUg1h4tCcFPKRjJSiPzrRPl2/Kh5Js?=
 =?us-ascii?Q?/xG6k9DvRZgePJDIPqMNSquA78+BowbVjvI+ca0XqmPMxKOMaiu+lPLR3Gy5?=
 =?us-ascii?Q?MXHXFgvCcJB3Noii6xN11YrvZSe3gY/crUhFOXKvQ6EMvTijMi5XuDrd7gOA?=
 =?us-ascii?Q?320XYG5eXpzxqKX7j4IlePuyGeTUKmOR1+eZvc3rppLj0lW/Zd5KTePEptQa?=
 =?us-ascii?Q?s5JtK2ajju0ZojeMVn7wMc+562tytAMU2mGdLl8ZJ1LyEbnHS4EuVsgXZn31?=
 =?us-ascii?Q?+FXa8rCvxH+JUpABVGSCgeiPPdCM5vuaVd8kVvLLlz6DbXq1xwwNn3F4a9AR?=
 =?us-ascii?Q?C6K0xb5LRUWSfKvECiMVwULzvzm4Lj5VcnTOHtArJvR//8OTA6pJ47qe4mP/?=
 =?us-ascii?Q?Q1zzcGwoMMKDxgQtQVsGdUNQMOhEDvvCsBEn/gcOVk1JEaJWeCfCZSQiqVS/?=
 =?us-ascii?Q?QLQZgVMG3NM5M753v7WDkhMzaqhFJ+7pYcetvMHXrt6BHBitOxtesNtJ1W8x?=
 =?us-ascii?Q?TwnvqMWNOt2q51VIzARpyyw+ZZ7DBQLUGPnqNrA1eWN4dr8ydNQgltpkuGFe?=
 =?us-ascii?Q?UbRfPVL10V71/2UXBNKLZiz2abm/WlX6TilCQz/CGJkv/NC0dlsyNuuXV07i?=
 =?us-ascii?Q?XjverSkMggjBKYxFfg+T7/TwB1q5mJeWQ39EWY1bvolU58cWIvhD5RwyX8ys?=
 =?us-ascii?Q?OgmLP6SWRM+GBm9WA5I33NgKhWsIdYMJRU5dyBG7GMW5oYOfyWE/C//d5NWm?=
 =?us-ascii?Q?XTlhCPrgjGvN6NIUtxeVIzDKElIvsMsY3EnMDzBvjww+/tpsGJ/7/9K+xS2B?=
 =?us-ascii?Q?L9T5AX1w1Q0LnwucHtEb2GI5xjl/1NmDQnaWiIr4beb5TpoGM6rnDueYyalo?=
 =?us-ascii?Q?w8yZ6vHdFXzxKTaQSlYrlt6FTP4Qm6aawwsV7lem1cI61l9FpnyHuYA+anNj?=
 =?us-ascii?Q?LIIvmMAf0WtVWz9qLnLx/0I42R2ygWn8SBwAo+iIWJbXf6vDyimXe+++HyNV?=
 =?us-ascii?Q?QsCQqbau9FXUSyjU7CUbB4XdTu3pQSF+y7bIWc842ros/Cn3lgxqJkU/7QDZ?=
 =?us-ascii?Q?O+lT9FxC9u8tdtrcIbJuWdp0+6/eGfdyLpk/bTQwOpCXS3Kc7w5P3g0BpWwk?=
 =?us-ascii?Q?iuWVP/5Na88hqqp5/HnSt0vvkZAAVCdOlWY3+/PX9XtDDi2hxphE8GZ6pCRN?=
 =?us-ascii?Q?uz51FiXaF1sUNUfIJVIb2/P5GIScV28DJug4zOaMfnplrMYBh9FRnX4znRyQ?=
 =?us-ascii?Q?Neg3xY8rpJtQACVQe3EcaQkBgAkA5gSQvhVUumjEmW2LfGAWaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?80Nm5zFlT0Co7GTkNam/ur9pfdM3Tti9RXfucHf2HAPyCymy5NJhh9FzHMm8?=
 =?us-ascii?Q?45qTCfeHxLRoaLwEr3ZZO7D1bXOx2XGS8sCgc8aoXq3ydKvfinjrCWRjl47w?=
 =?us-ascii?Q?4HSgxn6sVoFLqJjgCpdBVfecdQdK+oeyKQ6NhPs/VEllts73qUd/3vP86k5i?=
 =?us-ascii?Q?lei1Xgu+jqLpXr2TZairwDPmh21416y6ErH4FtY9+DLdphxMmR24/2wQ4VBs?=
 =?us-ascii?Q?yJAv+83jnUAMhTaveMn/t0fNYnlD06frtE+S661Fr67HmwPfQQf2sedwXgDN?=
 =?us-ascii?Q?ONoZi/UHj/zbwiTXidDYgx7m3+tjNoB6sdqyk/jk9lxW2odFoBJ+Bh/Qsu+b?=
 =?us-ascii?Q?+Ln7Q6Kd1iV1T49FPE7+y50z2SywlGGerSVwyXdln1UnIJ22dh6aZ7/hFLHv?=
 =?us-ascii?Q?mN+Fz7zyljWz/PB4chEFzy4K0BFeRqnUiB4/kUNqrppCMb1vs6AFjA3i47CN?=
 =?us-ascii?Q?3LPyUFsBOYdQZmm4xIy1/TwrMFGDcjtv71zVLXadmFm/J6ODytME0vaELCVO?=
 =?us-ascii?Q?Rlk91zuRnLqnZOKZ+OShFbicu8eisGR/ngE/U7TIGUXASuyIUKAZjY2uRkVF?=
 =?us-ascii?Q?sk7k3y4WScPp+MQyhpIconMHNz91DLimtX0MS/gkBlJoTtOxmONHuY339vjn?=
 =?us-ascii?Q?UeWME8ITFyhe2wzCkissnyF94VG96hPPRmv1hRjTcfMOIUas1xamSKehjRpV?=
 =?us-ascii?Q?ezasLhJ7+GawKfPq0/nU0wZkY0tE9HhT7fTuKX4nwm1SUtufzPJljBF67gWp?=
 =?us-ascii?Q?tInpA62s/iNVCGdgrlQ5WvFP9p0kBTCuU8G7U12gfyet2KXwqHLglxU5Vqlq?=
 =?us-ascii?Q?XNmm5JRjEArtG+R1thqVqAF1JBcDwPpngZUhVAl6Rnc95wPAoRMvF6H/Hq5Z?=
 =?us-ascii?Q?sRU3oTCNtxer4Gz8dtObekibkyWgTx77SGWGzzVI4HX9iKOCqAKi7AK8QJsU?=
 =?us-ascii?Q?4VtT+eouPsHJH6ks+I0Iv/2N1hLu8/RrbMKcXmVGenoJ5ym/giuJeVur7Gze?=
 =?us-ascii?Q?3790NNmJ2PnIX6GfonQYaUiiXc2i1vi5Tx8YvSRoE1F2sEgUBMw4fUc8LhEk?=
 =?us-ascii?Q?2EJcHFX2QoJjrpuCnkFZcK54LWzJgsz1R2p7+Wsmvw+6xbOT99efC4VuBgyb?=
 =?us-ascii?Q?Ukdxd8E3DHp6tF5UOxTMjnmtr3OB+InflmEJekMjEWt2h8ucUyzk9gPabqBZ?=
 =?us-ascii?Q?CNarzdpVB4gtU6xA5J5RSTUTzOLUqlOq7xfb01fzfZP6wnZCo8Vx4JLklWwK?=
 =?us-ascii?Q?rv4jwCcjtky0uGsQmSy99RmCuspTCEGmwTrc9zssADItubXfk8lABVII+osY?=
 =?us-ascii?Q?6Z8J0eL37yjuacy945In6uBqplbbCW9ObbogH3f1k89iOAMF9WMZ/8oZZquh?=
 =?us-ascii?Q?AdmleJL0knH/gRF95Ugeh98+lxpYR2HrLC492RjGUWMwiYoy90RnBjpkTJCm?=
 =?us-ascii?Q?U5ImpAN1briyNt4zvs5ekQY/vq9ICUEGsx0ePpag/X/XdMsVv5NgEkWnwCw1?=
 =?us-ascii?Q?9xJR259nSVdY+1tdtVoIQPQpodTlPy9gmfXR4Tv8FX7zyQGiBZVuRA9homgq?=
 =?us-ascii?Q?/dg3/84/k7JTdYzH8UM5ShZLkyT/LECfa4kDsmFR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec801d10-684e-4470-6130-08dcc2ac2566
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:12:59.9013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: svRS6qqC0xxBEVfKKeH3USn2mOe7YSQ220wRMoEhVu7AhDQZDJC63IzJuhnN0aIQaaa1A41LZtSvukk5K84DAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

Update the QoS property to allow for write, so that fields such as
BCode can be updated.
---
 doc/org.bluez.MediaTransport.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/doc/org.bluez.MediaTransport.rst b/doc/org.bluez.MediaTransport.rst
index b53c0cd26..4d998b2a8 100644
--- a/doc/org.bluez.MediaTransport.rst
+++ b/doc/org.bluez.MediaTransport.rst
@@ -149,8 +149,8 @@ array{object} Links [readonly, optional, ISO only, experimental]
 
 	Linked transport objects which the transport is associated with.
 
-dict QoS [readonly, optional, ISO only, experimental]
-`````````````````````````````````````````````````````
+dict QoS [readwrite, optional, ISO only, experimental]
+``````````````````````````````````````````````````````
 
 	Only present when QoS is configured.
 
-- 
2.40.1

