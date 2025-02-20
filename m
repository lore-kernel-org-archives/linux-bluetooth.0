Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013024.outbound.protection.outlook.com [40.107.159.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740461E990E
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Feb 2025 08:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740041910; cv=fail; b=fgawI3gA7gAmHURsGUXW4DnP8aK/QfgiO3yenSlPTr3D2vbVq+xtplmRO5WA+a/rh54SBsb5vlk8581Rw9SJb9H2Rl515kFu2V+ysz5scT7IX/lEOlGfIm6YgwnoQm93Z1vp82sigfe0WrSIKBkY0WZK1RNKSyBzUKDSa3wUSL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740041910; c=relaxed/simple;
	bh=4A+VKbMGNgWHY5V7lkZm//fGlknqLk4Yl6JwU9NjlEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GekvYz5e8sMjHBxbdhkAEDZwBrnDbpyZODH4pAdf/JWBODQVz8t7w50+YOXN13qwMPZMh5X17+XsUQhsrQXMrt5gCOZsfLxSUJ/EGZvmxD2hIaTNfXX3AdMOXp2zjvrIPMuyUPVHAfSGc1e+tPgCG9DsxyxOSLpVeJIi9lzCIYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hd7NshTX; arc=fail smtp.client-ip=40.107.159.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hd7NshTX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WslDayERlxwuycjBmRwFs8hUKFWz1SiIgilEj1pyhE2p/kNGgtIQcuWCMifmmCk5FMkDDwiRBVmDVFDC4Nts/lUN6no+Y1Qm7gpYUh/+GcmttjM3mfoXTiaGmShtZ3k3iJiUxcGIHa7O6hkylMTjqoZTji9QyQ7cjqF3B2OQ40zzcBWWvndSAdnpS3VLq/IF4RT8VhNl135nwZBYD0x3YqjMtv4YnYntEWcaRJ+1vNR4krYGWVBOgRPxwGRU+095LJZy9yV0RbrugpYihCjvR6Cmo22zK38lm4vGb/hut0RfrWwpCqMm5R3T2TRWbQ5g9tCdcz0GCkDLoE8+P/UQvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWKWMi3azpkefpKfUE1QNYHqJybLXV12BaE1gY3fIvs=;
 b=qBVLmBeTcIIb8z9xNWEzK3f/XyHmDXCJT/In3yFcnPCCMjwm2FYY0UfvmOSmb/3OfcATcqPO5jq9anp5aUgIC1Eso9VbH5EVGFbDzeIGU2Eivq6lpA5iVK8n/tskLcOayTPhBnqxGiFNjMOFMRh4cJjLCpcNpJJxHPiw5GOjyGifJS9UrV9nyQHn+U2MEvxgftpesHmyPMg+GYfWggIwAXzLNv/JWdhc9KKZdZrXAMA1+PYVZJHKl/dTY1FzwlHmVPCBtI9PRvehMekWAEVx481oNlgXq6JPOdMDiyCWsTMhKQaKpYvKuPK/5FSwB+A1GTyCFvOyDhJvAaIsI6nqUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWKWMi3azpkefpKfUE1QNYHqJybLXV12BaE1gY3fIvs=;
 b=hd7NshTXzNJKlv+NjpICucmkhuKROW7XP6qc6zAfaYvA4ROovr11gs28mPhOsLIgX9/0pnTtsMLtMiSc4JTyj5uIrN5Wr31s2kLLH/2GpXPtVF6lENigxew4vY/3xJ4inJFQD6Ag98FJTf9coaOIOpoGMMjIRtAvrHTFMIH7+XzUshUpvWC/X2d60bTTVsRuLVZ8lN1RcTKTnimYPpEChShZ0eRjWjsWBvqGFNNjBUpxMQ2Om4ObH0yR+bqMwMcpGGM2CUlBmDQAuUeh5vhcFt+qvWNBdQ+UPCQ8OXLuPRWxq0Fb75igKnF9ZGZeyJqzRa8quSoPw1Y7qNVv098I8A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9121.eurprd04.prod.outlook.com (2603:10a6:102:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:58:25 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8445.016; Thu, 20 Feb 2025
 08:58:25 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] bap: Do not set adapter as bt_bap user_data
Date: Thu, 20 Feb 2025 10:58:10 +0200
Message-ID: <20250220085811.5033-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
References: <20250220085811.5033-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9121:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcae76f-3cd7-4056-9739-08dd518cbc63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UmVZnjyt2jPJpGJX0qyOMP3vbuUMCMZqhj4Qtjd57N1AqGoBImWFhU8O+/XH?=
 =?us-ascii?Q?yV40Nlm34jxqXE1CuTruMmeZGNqrKY1ccyZZ3lTbntCKB8XaDUSy8+DbSjGG?=
 =?us-ascii?Q?TnucqTya2lKHXVDPimXXOEq1kX/MdKydHo5MaEHAwBfhfy0hNT+xtUbZ+ero?=
 =?us-ascii?Q?GWFH2VacSPCK0uGwLR/y5lt1UzGrmirxCfisUMU/3Iaai5JuWRD6RihOHjCC?=
 =?us-ascii?Q?/4NFXm0dbAk59WPBi2gAw/lQ5i9TCOg5d/dQb58TwERu+Sb/8cstBIdVhxBx?=
 =?us-ascii?Q?aMYhB4XTNvrN7pjGguLKG0pWpZFd/Cg2v3i3YiNYS1zGKjbk0ULCqHSaZQ/V?=
 =?us-ascii?Q?6uMZKtmFXo39fPQ9Pb2N7Ywyb3h+Rq5xADyOPRrSRu8y/WJTERatLopFMbZU?=
 =?us-ascii?Q?UOZXFYvDUZh8gkhSeUzkxpqbvUVJHIuq5xpXTbSX/xrxMDcMtwJ5HnE/BC2t?=
 =?us-ascii?Q?74iWKQN3gisZHIwZ8GqrCw7VpdRwyWj2rgLqvlDcEWhkeWm3Dvede8c1VMPJ?=
 =?us-ascii?Q?ZAMYSuYLUsSkzB94MNpv4aCaWor6Rs8qi2PhrSv3XUFy8DW5tMGnAVJ0pyG9?=
 =?us-ascii?Q?UKdslh89HprrOMNLrf9koUxXSyflltAHG8A4AtIk+9ywwEmgx7ec8s6Z7ebW?=
 =?us-ascii?Q?/jXk3OxxE8xV9qqzhSKkO4YWDLRmsDq7VlYcupXwa1J2qFPIC7J5CptQSY5a?=
 =?us-ascii?Q?vZM8hyJ6RYgiw/CnZsGNawYAfwn9itibr1fd+fj4ghel1v18Wu/SOWNqCc6y?=
 =?us-ascii?Q?vSjut6oHsfqliMrmHMLkN8hnjs2qnMFn2xG+8b34uJR9ustEWhe24V5Y1pQy?=
 =?us-ascii?Q?op8iVaFGCr54QO165XmQWj9IR339e4i3gRkqbngf92n6CwjSxlV64qBKanbh?=
 =?us-ascii?Q?/C8MHNc/N2A1xcajyFpkv0XW/oMnP90PHlJdOY8rbtLGOg47HtWL/H8J0Dql?=
 =?us-ascii?Q?/ninbhCdw2GaEA3P1IRX3PxDxi+JGQ1GZcxTznsiNYEdfI2PEPoEr+CBQdPX?=
 =?us-ascii?Q?BuhGc/wUtN11WFEuPh85TNJGMwsg1CQMg5C42K8Yj0BbnWOwRgkNRq6arrHC?=
 =?us-ascii?Q?nVQ+516xrHLpp6dIZpJQrk1A2rhLx1AuJzkpXdsMz1itZqT/a1aqrGXFQSZO?=
 =?us-ascii?Q?k6S4mDXjdddWnQ1vR3RvUHTsCk6xououo/BseqmS/1O7TO0WiGiKX+spvt8s?=
 =?us-ascii?Q?US/av0/sg1RmcKPT/Xozj7+9iZAO8AR6z0v7Bd2Gg5cg4kh9x6H7fR3GjZxt?=
 =?us-ascii?Q?4tuqWO8Efnk8ThXq5ioH3FsFuF5Ko3gCaRn4+RKyEUUCMQIuewfOwwvD9SON?=
 =?us-ascii?Q?sCakOk3HtuSvpCCzoUwyuLDkz/ie61KD2K1LMh75LQKmKpLoC8l1vL3HOW/z?=
 =?us-ascii?Q?uw7RrkZS65GpIMhg8bVRjlg9O1GG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xkRefQILM+D9/18Dpz0pxOistSZZQgwv5Sh7ju9gHhNMPUSgjyt2yrRE9K7G?=
 =?us-ascii?Q?b47RGWCWviSpI0H17/yGRHgfVyJP7k810sE7icSh5Ufc5UciH1huSpUK1CZh?=
 =?us-ascii?Q?mCK68obMZNvyVFzEpO3Yl8TtZ4uNkU94vsdWAtqEGsaIFpzZHcoLpvnh3avG?=
 =?us-ascii?Q?wuLFL8km6lpfSGlkfLqRYgIYceWPBThjcFBIvrD5r8IS5yQoOixY0oAX2ctR?=
 =?us-ascii?Q?9vmddbfTfAQsjFDQZnUMzlIsbD9tTqJMP8ZPvDycmnSbxnqiLbrnLstUF5ws?=
 =?us-ascii?Q?chkA8EI/k0TVumcB7G2ago72u9NceacKl6VIgQntIZCXeeJ6tW9+Al3bwhol?=
 =?us-ascii?Q?abQZsJRWPeqiO/T13CGie5YqFgv5c8cvsdaFA6b2LojNyW7rbrm/8uqkLNyH?=
 =?us-ascii?Q?whzy6EIl148fos63A10bpCuXhJl3qMsDJoecYGZXnOg90R4K6JseDjzkHiCA?=
 =?us-ascii?Q?GkvAhG7wRN8VspaXD5kTwf2Bytb9f5rKkcIzgKU419pptem9k74m29H+IHVp?=
 =?us-ascii?Q?2X5SIOUO3FeUz4awai4ukrqN6wMMvXjq9+CqjfGcEqO7Shu73LI6qW/Nh9NP?=
 =?us-ascii?Q?pkuXSk/0cb3x9NDNDU12QDzSE8jx+NB1Syp705BygxlMWDd7HVO2sj/kbcKG?=
 =?us-ascii?Q?IX72HaHREDHthGJjcToiNop1A+vPakhH3K9XpmiCaLGFcq+kdFytR/4hB9i8?=
 =?us-ascii?Q?boRj2pb8RGxJZmyn9VR5qveAOGGsihnSTEiRrKOPwoJoZ+HjKb3saHfzy266?=
 =?us-ascii?Q?yR7tdTX1WYeZtb3uRnaHmnrUDQVWnFQ1pg084FA+J7Zqxva3qL11fnxMsFzH?=
 =?us-ascii?Q?Qxgd3g/+0hH1bkIGQkDtyewjq/iKWIV4Qa8hnd97Gc9MvJpQka/FItKG9N8K?=
 =?us-ascii?Q?j7Jalcl1JRy08ErZR1NqMXoC4GE/MeHQown7VWx5hV2+0joltcZQa8/shbo6?=
 =?us-ascii?Q?rvap8yHCp9o+mcd/uIjpmwgn5Zw16yxgfTH3nInNKSDkEcuWHEsywfC+zecf?=
 =?us-ascii?Q?yQq1ecAyx9Z/ZlBMnwCjkRym8Xe8uhWS1jkGBj4oZJymf+JuitpJSWV6sB22?=
 =?us-ascii?Q?/Hb8EamoFxu2n3NlQ88Gm4ES9+Ea+58w2yRF6Mc4/gy4kRU3xBOvUP+W6Y7w?=
 =?us-ascii?Q?2nT2Rb1g8aRvKjig0L7hOg0rILjM38WInFIublYbt4f9o0xJ3QL+qAMbhcyB?=
 =?us-ascii?Q?XFAEXHO8ixrx/c4nSJ04ZcbAOrec4EIDLaKbURz/tf9WzuzaTlwAHMA+ghJJ?=
 =?us-ascii?Q?hrc3cPoXcp9XfUtLqz5MStfezh041j3+7ThPVMesxi7Ee0BQHyMLrsEBl38n?=
 =?us-ascii?Q?oivIy7l9H1bjkad9GPOKxGM6wAo0a6KgMAxNGIHRamXEkMDd6eVhEV+RrqoU?=
 =?us-ascii?Q?qiR3Z56Wy7N0090T7Y9CqNN36Mth6VNdlynJk8p2sTx2HgcLCyUD2sVvXNKe?=
 =?us-ascii?Q?IGw/WEw/XaI0G5shcM8XiGMUJuedS6xI8bctiLLExofze9Y8VRoyiX/CCpBH?=
 =?us-ascii?Q?n7n9xL4wnE06qQQW+OgrwTZqZ+iZ/AivSWK0MVXKa3qhP3Ov50KkBBnNatZQ?=
 =?us-ascii?Q?YCU4+9P6jzudTwbGnkPucz+c8/QgyBnz7Cez3JZHAutR4E+Huln2SkYwQVm/?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcae76f-3cd7-4056-9739-08dd518cbc63
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:58:25.5725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TSQWH5z6F44XI3//6KtsJqGCYBCN5W9xXRHqmfV6EZOeRem3IPsSs269yAo202hKI5N0VT5Y8Tc3MRgqMQFHMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9121

In case of a BAP Broadcast Source session, it is not necessary to set the
adapter as bt_bap user data. Plus, setting it makes it confusing for
plugins to know the type of pointer to parse, distinguishing between
Broadcast Source sessions and other types of sessions that hold a service
reference as user data.

For a BAP Broadcast Source, the bt_bap user data can remain unset, since
the session is not associated with any remote device/service.
---
 profiles/audio/bap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 6d2afa2c0..b36e45ea4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3280,7 +3280,6 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
 
-	bt_bap_set_user_data(data->bap, adapter);
 	bap_data_set_user_data(data, adapter);
 
 	data->adapter = adapter;
-- 
2.43.0

