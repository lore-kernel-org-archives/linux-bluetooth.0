Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B779443179
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 10:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724150594; cv=fail; b=a6UKwjqb7lerPLaPxdX0F1Yulh/mM5eaTwtVW5NyLpCuPUJn5h9RA29TecBFNxFwu2p4U1AINErxEAvNnJwOM4gmatPx+q4nXuuukeYpZIPDgC3fRw4dTv96YbHyPpQz7cosu+cLxTuLI577j8FMbrw/JeeTJzHo2xwRbWWJTSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724150594; c=relaxed/simple;
	bh=ebFKHY0irvHMQz3c9UugeEt0sKtV9y76P1agaWuX8KY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=k5/b9fv3dJm+IHyBA9bw95eV+wpK9mV0SVQxj6NbhXDk5HSGyluxXyNF6kUVvkh+lrD2rwwPLVqYKCkI8X2Ds8kPcni7hgXPchubz/5GtGwtiTcRmyv98uIBHjf0ZIUPht5lXKmvGwlYykVaxnVK/FiILLdQ82N32FS1FJB3ajA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Koga86jC; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Koga86jC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSE1V7k0H2ll188+OQq2h8RAxeZLlURNwCAE4Wg6Zaw65B6PknlykYJhmJgfZYqbTcyO64DQ+XFuvuH7r5KM5SLfENtXReJw9JbyrQCOMeKR02OWKyZpxZV6cy17PNHm/BXcNUe4bXK1/V+VMSCEJxRuoPCtE1cafU/uEAGl31AoeN6ZVPtFLI1p2ZLgu9ih8kQHdCSpjOWEWCNHr2aRV88kN4yXp4DGUgi5aQq+jq6CoDZ3lWA3Rz8zVICIS3iI83sVRcZ0b/69Ag+/FgtmQFvhrR6k+TnAbcQaF2PyeMju+PGpx643EuanWSPoNSN8PW4bturI+KIRfSErrwuEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z4VwTezrSiljrdUthR1BHY0fb5vVP80Xwnf7OcL3qsg=;
 b=cUCjZbg+zF1mqlfPKdOH3axVpCC9GTmS5u0G2m2Op+pZ3vZiTB0Jebucy4ZYf2Bsyx8Qy1ZDXU+SwuUqgX6tgbAr3TzWirTX3p3Sm/2+Esl20SyDou1YZ1MEQJ20JO5/Kyue5nOwHm7NMaivO9MMGnOx293dCe7gauep2u5q2s5z5222PDFvRtPcavPgTkTUokxz5K5fn22yjw7EAOSmWfqumgK1fHpA9vkL8ZqUpoRzipdqA3ZvuI60g9sTBVsxDwRXawy302/U4Zuuc1BuMWqcFjtKqFh98PFQaCwRXeZvDhJtbFtSs/EJdLKtx+rAOmXvoI/Cy/e8RRQ/jo2Jcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4VwTezrSiljrdUthR1BHY0fb5vVP80Xwnf7OcL3qsg=;
 b=Koga86jCyNEZltQYzZXawfodAaDaISKsXGdA/G3JLnlXYMeBJXH9Bdaz0PiZI2F2SroUM4iYoDiigyliIZTxgMtXSbkOroY0oH5zCTSpMQ4QdiX5ZWe7lYyy54iegF6m0l/gZTywy84SMAdYdHavuxsJts73tMEbDMoYBC5E1hL11fzqk6bfccPH9ElDNGsn47v19yXDYenKWT6WkfL/UoOdb42LORKmiDFKvWnZGJeqDMT+4SwQfaApJmBGrEzWaYssmtNOBN284iwg0+kzKaiwZ/d2OigxpZXSN9QEgJBwlV+jvw+66IOnS8+mcYXwDpNXii2pvLU5o5ruaJNDLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 10:43:09 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 10:43:08 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/8] Add support for setting bcode on bcast sink
Date: Tue, 20 Aug 2024 13:39:10 +0300
Message-Id: <20240820103918.24246-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0011.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::11) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AM9PR04MB7555:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e86abcf-5f5b-4a6a-aa47-08dcc104e179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7NYu/MjycfQX6oij+KaXkn79yCYL2x2ZazJm9//Tlunap/xAz/6MD4ZwPX4N?=
 =?us-ascii?Q?sVOjNFkTkxWcCJPObHDVGio8xYX7RoLP2bYWR4GuAChe33XFKzVgkhH4IA8b?=
 =?us-ascii?Q?QoFzLmtibaJBcYMCa5xk/fZYBV6DpgsJHRPQtjVO1WLYqR4Jus4FERwa/7Pq?=
 =?us-ascii?Q?cGJzA8FRbKjhZY672js8mPtePzW4V1puMJ1wBFdghjWXXC4bMK77X5PoTNUZ?=
 =?us-ascii?Q?B1SASbOErrohJXX9Uh5XsvcIiDdwXmkVsoGxhQlS1VMXM7FuPSmrVHMlH/b2?=
 =?us-ascii?Q?Gd+fyp/BkA8PdC0Zoizn/rSKopQNkqitGZtXxPTNgFvQ2F8qSVfQLkJiPFRu?=
 =?us-ascii?Q?M1TW+OBsM4hDNhujQlOaiBTWOc/UKJJzb19lLzzgc+BiUJA2zn/1W5h/+RGU?=
 =?us-ascii?Q?SkfP9fm1pPYuuQWgV4nKc05ciE+VdmFuFq6YULW89U1nBmJLXzt9PRu7HIhz?=
 =?us-ascii?Q?iP+haLKJkaRazqxGNRkHq9BJpdVRqOz0bhb7PEyCbyC/HRhfeKP1NX1uluES?=
 =?us-ascii?Q?2/l2Z5/38ctlbPUuTNf90bm4P91x/oFKN+KY0UjtBj76o06Wu6Ltq9HhnJHU?=
 =?us-ascii?Q?+/0kTT3gc2Cfxurl3AfE4t4J43ukcNn20PITFWv86SJvQCVzeGMMbjYg0SUD?=
 =?us-ascii?Q?B1npxo6hezW0E+0uHuKWrsz3twqZoJ1Jh0r0wJ4zFLTLv5TcQl8tJ8QpKhtd?=
 =?us-ascii?Q?wwqMnIw7LJVUsR3LytPV7Kt744tSAA2r/inXVthofk0amlFl/2MzHO17OhCx?=
 =?us-ascii?Q?UylVXusQZ6jDyDxtn6SF9V56rFeVeFvSvQD+/KPspyORu+Jom+1Zfln5wM6b?=
 =?us-ascii?Q?i6iYCxz6HK3RFp6LYG6aOywNrYhlKKBXRPE1RekcoVWkOetGWbK2bqaJmoAR?=
 =?us-ascii?Q?BEDxmwZYI1/GcLmZ3evwKGleebalBKmBpKSndh9OMmhvw7z61E0IPewnHMCT?=
 =?us-ascii?Q?PXCiieUlUFAJItjBuN/8GQX5DAqnAfshqsVJ5oSGXLExEuqXzpPQcP5Q31ZD?=
 =?us-ascii?Q?sn2HmQOj3PLFgsGmdalZgTQdGz37M1ottdNBWEC73wwr4Ola1k2mqsYrRQKi?=
 =?us-ascii?Q?dW0rnCdNZggkWBj51/ZC1vbLeWi4REM1R8Fkkov4Aa4ZwyVzkRiHCIEJbMAF?=
 =?us-ascii?Q?MtK4kyEyqw3IHxh/nmutQx2H1pt/wO+Z106dS9zrnSlGzpL67Mvs4QTYSogI?=
 =?us-ascii?Q?fhBJ9yr2n/aalfcEiK/dQeiQ7Ub+6W3xDhB1LVgES/zDuhfhiCeWwcaeF/xd?=
 =?us-ascii?Q?X/u194Axku/mB9WpbnRSx6m4I3ybztlrjwUaKQnFPylxj6vzkmG+2mkfUvA5?=
 =?us-ascii?Q?6RAL8zdmQMIi0EgUE35CcPnThO2S1gScOcI4X7k7QdRg6WtRcDfHWO/00dVH?=
 =?us-ascii?Q?tuKqi0hfjvd6DbTx+q67FtRTnInKjJ+/3HP8U/BdEZvLILc+hg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uRmn7x00FImJqpi3R6/4o/71EJwt39eRWLfm+d2htgrh32fOyukBcREZwNH6?=
 =?us-ascii?Q?TYWPNYMoFG3GUW8DuXt+bhFgjYnDqw94IGxJHQxnRLpRrfPPniyIbFgVeX8n?=
 =?us-ascii?Q?oV0Y6l6XuPieaERVyis1g3pdDkggt5v6AuS1UGAYYpFfYKskMduXitRMqBER?=
 =?us-ascii?Q?BKqxLrVGgdsKRm4E4E3DFF00mpysSK0GOrS3irO32j6EgGS4yWbpksLngPcl?=
 =?us-ascii?Q?YtX8RK4PQzWikcBHol/xNSa0AoS22owiwY8wFhDtw9oKF40woEJztsxe6elk?=
 =?us-ascii?Q?0n+JI2SouTOSY1tp/SVyR2aLy1lz+a87Sedfx9GKkE70ZGfyzBbTBG0z2QbT?=
 =?us-ascii?Q?Gt6j9AHFxZQJELG8vu1ppF4D2mlsUgzxenFZl/p2KAuiXSGnG9QJZjtAORXZ?=
 =?us-ascii?Q?5WXWvWOy08XJpFXmqwIYweCMYPsmGwSV41c+/Bfqr+X3QLRzozAN7YcTprf0?=
 =?us-ascii?Q?Mhs7zvtbBCR5LvhROF1IpIBxicqBXotPlcbK/xZkPwhnR7DEx4xN60fzzRkb?=
 =?us-ascii?Q?zxFgnCQlwFtK0E584xmbbyNNe9BUPKLKgUH6xtXTD6XNuoY93++HA5Szd3ZK?=
 =?us-ascii?Q?eZl6LZRkl6WtSO+EGUbWbkI73eeEXCB6V0SPIhgIQUzCI3jNh0C5UNLTQHtF?=
 =?us-ascii?Q?+lS0Qv6kPkMrYXBtsKUewPVHrMWfAFd7i3+oQg21ydTacXZcdxdsRfjmQzo0?=
 =?us-ascii?Q?Il2e8iJfuiYdcAXUfK7SFxVlDYO5RrWi70kSPv7H0Gb1dITs1HFcasFkLyiq?=
 =?us-ascii?Q?DaIYDJ1M4n6puTf9PuGSIJEhlQHP0aZAPb0kVoj6/lU1aCjSUy6JFtVeMz0w?=
 =?us-ascii?Q?K2+tNs9QB5YzhWqRHPP7sdQQASNeT+rDQtxpaZXl47daq4tKsjg33a+axgg2?=
 =?us-ascii?Q?4/rT4JxdxsmpNO89i0QOcuKSVrAX0V75WYriSLVJzP94IZHIJ6eJYn/dIerk?=
 =?us-ascii?Q?DlDGRm0P1aJnrvtDLbeg1KSpUgbxOZ5aQO/qP9ireWn6AZlPD7at6S1u9UOy?=
 =?us-ascii?Q?zyKxwWag4TX06EiCQcei4PKQy4FsLbt0PjTnFWCw+RFdkcu7qtST7teoqfjW?=
 =?us-ascii?Q?sy3nS9aYzvBBcVtB39jYoh2NDdHuuGj4yOYxJXVSuAdYNvLdBQXngCZcqrtp?=
 =?us-ascii?Q?8SxDuKcbr8u/TxIuTIJKJPWBgHJsSpWPMT3vl2mFKNKnfDgvwoDOkbDaaA2M?=
 =?us-ascii?Q?qTy4fgXcBOcPiHy50SUIavdiJwltQeNH9TtwKRmL1sIsGWj7hEnTNMYc2B17?=
 =?us-ascii?Q?Spld8Fw1ccUccbo4h2FHWo2ukleKfSKiyYtj+D5W0xxHWBzoAcjVdepGxi9Z?=
 =?us-ascii?Q?MlZ/9L5V35ulW6NlwDGYGc+VBUibK7NsBavQPZIRf3+sy6MDVpwnDGlD7fR6?=
 =?us-ascii?Q?xKV0j3ON6QK+NeNjxP4nYPIyrDZ+SH0SHLfP9HRTR9ssIb37vVPkoY3LQ5qj?=
 =?us-ascii?Q?HZWnFzQXKXx/WkRpKKjhJKf32+j8/I29y5UbEtPR7+C++0a5CFXPc7y+3NXi?=
 =?us-ascii?Q?H6r3LtHflC/4jaBwsEX0BFapTkVGmWS3peKoaGJKehVR3wnV7h97uzeNSrMR?=
 =?us-ascii?Q?noWXFeS72nmqPXHF/OyDhpshTz9fpO9hTi1H4STF?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e86abcf-5f5b-4a6a-aa47-08dcc104e179
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 10:43:08.8778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZEFUlIBkMUSapBVmxtoC2uht1Fx9AGBmHX9QizHqfYPqf3DD9eR3CiUF1wkFhJ1yZ5A8eVwhUHta86BtE0v/bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555

This series allows the user to set the broadcast code before syncing
to a broadcast source. Upon calling transport.select if the source is
encrypted the user will be prompted to enter the broadcast code. Then,
the code is set in the associated stream's QoS. From here it can be
accessed by iso_do_big_sync, which will pass it to the kernel.

Vlad Pruteanu (8):
  doc/media: Add Encryption and BCode fields to QoS property
  transport: Make get_bcast_qos return the encryption flag
  gdbus: Add g_dbus_proxy_set_property_dict
  doc/media: Make QoS property readwrite
  transport: Add set_bcast_qos method
  shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
  client/player: Prompt the user to enter the bcode
  bap: Refresh qos stored in setup before doing BIG sync

 client/player.c                  | 57 +++++++++++++++++++++
 doc/org.bluez.MediaTransport.rst | 12 ++++-
 gdbus/client.c                   | 86 ++++++++++++++++++++++++++++++++
 gdbus/gdbus.h                    |  6 +++
 profiles/audio/bap.c             |  2 +
 profiles/audio/transport.c       | 35 ++++++++++++-
 src/shared/bap.c                 |  2 +-
 7 files changed, 195 insertions(+), 5 deletions(-)

-- 
2.40.1

