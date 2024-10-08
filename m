Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2054.outbound.protection.outlook.com [40.107.105.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2201E9081
	for <linux-bluetooth@vger.kernel.org>; Tue,  8 Oct 2024 08:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728374534; cv=fail; b=CYQyGm7FaJ9z3L6yJW8t87dUVfGelGHr+MvL8vhCI9mUdRMtW7F6ey4ysVWBnLmg3lxAsbNqeVXgtT3dpwuMC1GoqH5ftpOrqE7Tygn89jXJaTKb6REniBkizb5ifsuit8Z1iXNVV6LxzyUYZgKOLlVAg6cKZ8BLgUyYXxNGu9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728374534; c=relaxed/simple;
	bh=A6IOMRJooGNNGDR/RQDKucsOMgtNDO6tz9FrtGYYiDY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t1NTHmo9nw3inxrLvtEJ1agkO0D/eyL172zFWQp32z1R0skgk/rcsrXDil19rkEPAWZbZtfKR66+otj4YQoIJF1XIMQfo1LNOo0nlcQEsrCQ3MH3SKZLtT7ZvMTGvhH5wqE5jroTXoiOgaWKN40IbN/i1esTs1lKjvjHRZ/00gg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KnIZPbQt; arc=fail smtp.client-ip=40.107.105.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KnIZPbQt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fl6uYGpyFzn9avZQfvfprlRP2F7Nj9gbBkZPBY78GsCLJD6HRnq0vjfZuhC+pOhWsf9rJ4TGRaFqlwkEcyLVz0NaP+/MXxXDYi6ct0nAaA73OIUa9XTzty9LnK8i88VLwJC7I/YrRyNBfreuI6pRIJUlftLQsUjEVj6Iyg7fIhbWCfYPP1rzuruRWWObYf1p39WPx8CgUZbtD+GuNEKI9FrOavGamJnaj84/eHyZBral7HU0JcyEDGk1B5YZD9PcEEf73zDUwEyn+wz4Wo455KP2ehdmLUlsmfEDa4DU/26+addssAAvr58sm3glSPPYkI6h5sJ999ZTMargTU9Oew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pqy6fqiYHSurIGz6JjOnLqVJ5/TqLxCfBZPYD9vuJwU=;
 b=UJyqRvHI20eK2LmJlcbZiwpFlz2aaCOHWHKzF3b++T1UBZ+59/AU8yKAs/QuKLVpXXFGYdRI1SMRHVSixa3zwSJ1gFonHn1ncvqVprungkD2OQiSSgHhqZ8Nx5DKNA2CQRB7VPaOYNoA/iFXrygWSa/iTUL9HoJlkV2iJf6WNtccsnR2yYCnxIHK3DZEC3BOwQBsWuSciTgNkhJTKxMjv7Wi8qaBBE/abJEt0xt+EGSmKIDqz0wAePaUmTydxq0Q9LNbQ7Wkl5E9jhJsATvTgAwK28u1rKJrCeExtz1ChyTumvisNxI/q2tMCS5wXYqxH0cATHblikxYS4+ffmrxXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pqy6fqiYHSurIGz6JjOnLqVJ5/TqLxCfBZPYD9vuJwU=;
 b=KnIZPbQtE+E/sdt10Pb1QEXwPK3buyEWdYda40kV7POIwOwegEFSYUE3uwqikq/1Cs2vWiWms2sZov/TSlugMidQ/Odg4JplygwQS8eTvXUC03XGjlZkF5c284JvjIXd6tkvz1sxCZYGXgzw54Zd9aiYM41fheK9J2oWg999TZWlbEzWbTGhi4yacCdIZP9pZLcdFnzJ6qu4qIzGh3Qk4gMu+IW5H4GYgf5kndoFgfjQlrdYUiUc8b6vsnbDz1N3VSDt4qfFcYgQhc+ER+GKQysKOG547iB1H+P+v2jbfU+XWH288rknw4KgLuM5gdXrEvv7TPsqLv3OZaAtb6uUQA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB9343.eurprd04.prod.outlook.com (2603:10a6:102:2a7::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Tue, 8 Oct
 2024 08:02:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8026.020; Tue, 8 Oct 2024
 08:02:00 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 5/7] shared/bass: Set correct BIG enc state after sync
Date: Tue,  8 Oct 2024 11:01:24 +0300
Message-ID: <20241008080126.48703-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
References: <20241008080126.48703-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0087.eurprd05.prod.outlook.com
 (2603:10a6:208:136::27) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB9343:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a38020-978a-4d7e-6d55-08dce76f7cdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5ASZC8d2yjKSdFizSuvq5b3xzb35pCAfIa65hMyecp4/A7cs2mYZxg8ciTJb?=
 =?us-ascii?Q?NAef9s2gz94wKMGGu9tUQFh0ffjdNoR7JlVhIneFmejzQtCtm6Dowi/WahMj?=
 =?us-ascii?Q?tBKjCG6gHpIZrB6OsD+ciZjuRm4mLqB0jTQydPP/5RhLjNbb1pW3HYWPYZD8?=
 =?us-ascii?Q?cUmPzf4tBOFKvKaxXSMDXfAtmOhWhuiCq0s84AQcw7d8YuYb2dkpR0xewkq9?=
 =?us-ascii?Q?indqErFxLMjqowwxSerZ3W1HI/BXhrP+ClE1AVUepX+CVslVPq7V6mpLo+pT?=
 =?us-ascii?Q?WuCaKjMFF1weslA0TwtNux5EmySnHXZT1v94xx+OOMKn80x6nl2jurWjCfqm?=
 =?us-ascii?Q?nO6QOOA8zuHaPXTEYxP4qeRNkHCz7ujFHvYZ5zJxjDb85b70W+ZSPYb3cTe1?=
 =?us-ascii?Q?TjxF3hqx9zlue1KghOLFBpNqa8sNs+2tn1Q55Ztu9++W1zN1VwNwXOwwPgyL?=
 =?us-ascii?Q?phAesKdB41WfvwYd4bVse4rDBsyeUgg7tpnB3curQQ4ippDM4Hm+aXrffBKK?=
 =?us-ascii?Q?8+R5YGfYRbUjntbQkNOsC8Ij4gsupKDPflFzmp40fY3UqbsDM/ilDZJIhZ2T?=
 =?us-ascii?Q?pEWXYt2B9PlhMUuVGbSl8HDZhnqoggxUvAI1BsHG3/dPk07EctpCZ6mdZ2wT?=
 =?us-ascii?Q?6D7Gzi+klSQbR5O9b8WcRJF0cGpnGJ5hQviJz8tivVLDGf4EYua2QVmQ7+BT?=
 =?us-ascii?Q?QtCDrh7HualM2HM3srmzKj5VC+x4zb8Drhsjc4laJXkpfzUHpoS17ClO/uhp?=
 =?us-ascii?Q?NmlnJzpRw6B+02tzI/FxrNONqn4uGHOp2o9KcgUYm4NNJrrqdsaay7q5VU8F?=
 =?us-ascii?Q?7NJccZ2tLkD5nO0VTLPH3+Fw3XEmUo2cC2as7xWFmUSpCEylglhCLXZGkmdB?=
 =?us-ascii?Q?ITs96ymu7MtW0ainCgTxeZIkTzmXBrt5gc4GMtaBFEqk9tLTcwbj8/6j7ja1?=
 =?us-ascii?Q?/Q5Orlzidq88akJmP4uhIxscVHR3GzOzoRldihyJOma+5Xt+0fHA7vFMXGSu?=
 =?us-ascii?Q?LpRgHXi8udTWJC+wiJmeijuYXQdRgHOVqZIfETPD8ALVFcrt0fgRNb5dgJ71?=
 =?us-ascii?Q?LvqmMzh3Xnw5XtqFayS077VnIkPSTIPJ6uLTbiYBL5XaChV22hG+wg9vKA8P?=
 =?us-ascii?Q?kGzu21IP3oFQh3c9gYOuiT4RYssuldvK1Z+EFAHYmpGn8BzXWSr5gAvkPMzK?=
 =?us-ascii?Q?wM3ZEe9zRlBG1IIVaC1Go0BfbDggPXTnoEaUTIMvkQmG0LzFPokXAgykcIxn?=
 =?us-ascii?Q?zN1LcTuJBrRCjjqe3ylXLRyTg/89SntOhx2D9e9tSbZnqDrK/tdOcZnqVSFM?=
 =?us-ascii?Q?WvGeghhdXvR/bJtvBz/c9bbnXgyG4Plv9g6dIpxT2OXT3Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OsaLdT1ssb4C7zKQpaUSYSEFMHLTMQwE/g+KqB5ucvdIWB/zdWYtkD2J1zVH?=
 =?us-ascii?Q?zA1p8nlYOU3/wjCFVvxTiaTq5fibKaMrKMIPvkipL1CiGrpbezz2/6WFt56A?=
 =?us-ascii?Q?Hd4RaIC5pB30jLyqx3z17xBGTwJcVFh09BBUVTIgpPjZN1kOehU4lenQp0Kp?=
 =?us-ascii?Q?Bv4nSBMENNong0Ov6VY9RW2dzHEBT9NaaBbaGs4uKkUV1mssy8YHDxX60n8r?=
 =?us-ascii?Q?4UHe462u8PHmhSFw+70XO0v5W7d0ug90Z/WVxHq/r2wmyEwET9v1ebpk5nts?=
 =?us-ascii?Q?gMzcPfxHX8gQznamlag3lV1seYjE6OvlIw9+2jAnrEVMUNXFhIIFAaPI2/e+?=
 =?us-ascii?Q?lkrPM7p8cWfvdNsQ6tYhdz1X/nlc2pBJCjMcNeEneKjeeDxad2ohifmk0VgT?=
 =?us-ascii?Q?RYuNiOnm0FC+UdD/ITPziMpbDfrXhz9KU9o+STUhWsrX6zREq6RGXo9ZVeSz?=
 =?us-ascii?Q?a0s41hCl+Jed6rj3MblPVkmpnWK5w89L4Vv/arQ5AD4uNwQ5yyaDSvdCSH13?=
 =?us-ascii?Q?uFQqS9FMTQaME/QuLiKf9Y+5bo1To1QsujBKMJvbBunt2lXhneo+VQrtro1E?=
 =?us-ascii?Q?sDSsEsjRjnNHY8HMeBZc0Po0/spfXFWeOxYwu5dhakMiwbA4cnrlutqK07dx?=
 =?us-ascii?Q?VVuDeLVGO9iSlwYL3b68Xldybom0XWhSEYekHqFJ64aB2oWh6YTt1D++CGDv?=
 =?us-ascii?Q?YZa2MEA9Wd86FOCXQuPCkbYLlEg5hmSzN1U12AMWi/KDsvkV6aJ+ce6fs+H4?=
 =?us-ascii?Q?rC1PEp/4iuENKC1ARhAkI5WmHyFnUiPrgTYKI3Pl3+oLPOKBEPJb+piBMW6E?=
 =?us-ascii?Q?EBm1hd06SAMy1ZGcRpe7TRbeo4U549w/sr38+SIiL5fhua+XD0ZtvsD86WrL?=
 =?us-ascii?Q?f368p6CXcOMUIbQAsvWc1JpIZ2MAaj19ZlmrYnH+uuE6ys2Az8G4bBLJT1oD?=
 =?us-ascii?Q?XHKR1uBWp7Vao+iJEFejPAoJ4ZUDvq+Y0NgR65qY2mDJayM5pADeR68L8n+H?=
 =?us-ascii?Q?IQf0kNBUh1zeeBIfUnZAtJ7Qe1WrxURSXhm4DrvX1t0SC2Ck8D2Mjkp9d6Np?=
 =?us-ascii?Q?Ar+/zMlqdy6k2Kdue8kvVs1AR3prMH/Xqcim/GUmDbOaVmZ2ahBfSZ99Mi8c?=
 =?us-ascii?Q?cSn3p+KN651obuz0UMHU2pUuHaMkJq9LcpFDAjWxZM2veYqRHpP9jbpe6OfA?=
 =?us-ascii?Q?b58/v6GPs2RqMWkhUJfU/d5IE1GeFe/ACxUw2JUDFBYFdegCuOvY+kIcbqNb?=
 =?us-ascii?Q?OoMryUKbV1OnJz9eeb43WELXzPZyOdFAqTFbkPNcfBcLnjWAcfbxTTaaBnKY?=
 =?us-ascii?Q?6/sCEAjHAqgqhxXGE6f4fQIRgVz0mD+Qx/KImIgJ8ObRXIiZ1c0s9iCl19R9?=
 =?us-ascii?Q?vl9vwMk7mq4b7tgh6YUzD6HjWNUHQxUstrreAccD8PZaUciJx5vqwssy8mkr?=
 =?us-ascii?Q?f/Az8IhySaqKIvYF/Ny17nXFWfL/OW9cx2VHZ3f8IJuaV2skXv4AYmmi8Daq?=
 =?us-ascii?Q?WOSFuLJFTGkN5oZCxkc/RTz9P/u3zr05fDa8diSTlZJkbVZBKtGMTHuQtP0N?=
 =?us-ascii?Q?KFuoR2M5my/HnzeOVhkfvMyKDJP75N4e35wZzcwyIwXmw+R36QuH9iTKn/XO?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a38020-978a-4d7e-6d55-08dce76f7cdd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 08:02:00.4039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nUQMfndJVWpyygKQ/t3IUEGmS5GRgTvnmO+c9CjfTma2xJ1PfvhwlWFH++hS/7BRWfXYnzcTSeGOlvoj2Tmi1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9343

A Scan Delegator might set the BIG encryption state of a Broadcast
Receive State characteristic to "Broadcast Code Required", to notify
Broadcast Assistants that the value is needed to decrypt the streams.

If the Broadcast Code was received and BIG sync was established, the
BIG encryption state must be transitioned to "Decrypting" state, to
inform Assistants that BIG sync was successfully established with the
correct Code.
---
 src/shared/bass.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/bass.c b/src/shared/bass.c
index 6efacb2da..d99a140a1 100644
--- a/src/shared/bass.c
+++ b/src/shared/bass.c
@@ -1793,6 +1793,9 @@ int bt_bass_set_bis_sync(struct bt_bcast_src *bcast_src, uint8_t bis)
 		if (sgrp->pending_bis_sync & bitmask) {
 			sgrp->bis_sync |= bitmask;
 
+			if (bcast_src->enc == BT_BASS_BIG_ENC_STATE_BCODE_REQ)
+				bcast_src->enc = BT_BASS_BIG_ENC_STATE_DEC;
+
 			iov = bass_parse_bcast_src(bcast_src);
 			if (!iov)
 				return -ENOMEM;
-- 
2.43.0

