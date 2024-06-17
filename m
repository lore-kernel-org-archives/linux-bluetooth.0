Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC529190670
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 08:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614338; cv=fail; b=F7p3G+X5Ug9DYIOZbTYuDhNoAtc6ZYzdepEi2WkPNyhgHZcQ8F+RShvKWwd9EAeAqORf3aNgwVfcteO2tGghtemzzu4bZ7atnclxHo+9LhB3Tm0I2ymMIIvcNafV4XBmlZo+EyUiRl4pWT/R3fpa1oo2NMnMZ2CSWPqhkQLrUoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614338; c=relaxed/simple;
	bh=QGG/207yL/aPzm0MKeukuSuO8eHDTE0eV+uivdzi/E0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qZtsTYdslX/8coE6AF/7wgEsoLLpSP++MzYIHx7w3g/5pcAaXnOht1iVf+sEtxF5ji3cOLKzjnOe4CtSCbpkhsz2L8mzo2YuNjzAGpy7dfeJmK3WU1eg54EwI/0aQyQxVgo4+wX4m6Jgvdxb95DlxRmJNORLHJe/64WEtK/JPKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ka1aeqoS; arc=fail smtp.client-ip=40.107.15.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ka1aeqoS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jHeLwsZuI8PNXO6umQ4vfMG6MJ3p5m3zPezLr6JbZsJyHbb32K6CXsl1byGFTkbKHQa2z46DjOPMFmDi9L/X8eieb2fub6BK4F87F94E3dKprwoYS93sX9yVP9tBeJntY5t1Qxnf2W1qZ1XY82fuekvs4Wqpo7bj4Rag5sMSf1SoCmBGHcdkFTzKPBiFFzS8A9QiKiN0EXxRjKNdybhBQShzr09hSO59cJDkgWy0fG2dkOt94kurMP2iXI1UVGnzi16ulnJReHoTjrspTkWm/OrS/Kcg3q17MjYzXUfbc5FKDg+YqggCyHYVw0x8LpOc75K22eQlnHOpmyolu0JRQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cOFo3suiXX1j7mHWwvb81xg7pc84+9XojxXEBG382SA=;
 b=IC0NLWv56G7NMCgZic1/9NFbo1hLH4tN0LQyxobR0t+dbB9MzKxUW0xedwNiaCsEQdCd1dFVN3IVWxKSAnSLkfsUiAon916bABV5zjWAP9tGLYBuPRvUE3GKoeLY7G6euCNhIyB2sPCp62H44k0tM6IKBmmT8wf/f3BcKuZtH3202Wsgx7dyS19aG3wZZzAe3b7CmtpLSgiG2jtnstPvN193O8Vp4j0LeTTdKjuTrDSKFy9hOgHsGkOmIxo3Lw1EWinDMPq1LgNwGisST5Ea785PKNLd1ShvBM9h6lxMA+/3b7fBjCWxr0lpkPd7wsXlksHRniNwOngv9YEgP1qSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cOFo3suiXX1j7mHWwvb81xg7pc84+9XojxXEBG382SA=;
 b=ka1aeqoSqG7P/tb43nWYz+X3HZeCG8a/FrzPW5IUyn2tdwn4NKrk2P/Y3C+3UvNlCNNeNqTXWuYE/pT54iu+/kSJiZrSI1tdVq1Pw+Vf/GlON9M3sm0noBakJa8/zO6gy+MeNKgjI1XcD1WTn7Z8UxROMRlHCwC9dInt65+jT3Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10659.eurprd04.prod.outlook.com (2603:10a6:150:214::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 08:52:12 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 08:52:12 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: hci_event: Set QoS encryption from BIGInfo report
Date: Mon, 17 Jun 2024 11:52:05 +0300
Message-Id: <20240617085206.5750-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0214.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::21) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: 98ff8cea-be46-4e27-dbd6-08dc8eaac7c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0qqqX+YMMBSqyg8MHGbxFpvNU+zJnXwWt+wEe91wM/veDESiphmQO3zeOnei?=
 =?us-ascii?Q?zHcmukMX9ROfipVMjNNHk8XG1LtGW6iWTswXdDJr23dI2HPhPvcaQHqoloIJ?=
 =?us-ascii?Q?vRxr3DggT40DrIwdMIfR+N41i/XxxDQy0DeUXdXb+JBpHfXMyZJ4EteXY02M?=
 =?us-ascii?Q?7gnnq1ki0wxRS1F04vCvnu5ouvcRBWpyfiKy9skObX4K/sIIlRXYwvmgFCgP?=
 =?us-ascii?Q?BqicUtSl1Ht+CWU/BiQuT5eAIwwOOSW2SOsvogqIhkG2DuqRltVYYQCWUTAV?=
 =?us-ascii?Q?cV9JuUbozRALa6BnfWBV+rsrtcBEzdO8e9SxUE5dOpHRMVDbRLZvmFIGJuBt?=
 =?us-ascii?Q?I3zu6whb5chzNHRzA8AqcvwBT0GfMrkiFabC62ZpnEjA2AoRBLZhhHVoTeoL?=
 =?us-ascii?Q?0LNTCBVQmudAR4P9CO5a4BSKtqJG6ebrw3mTAteslot9UNdLTGZUDXhekVd5?=
 =?us-ascii?Q?v1mdwVOAfkgSe18r48ZJ7a94Mvh8eajUEdLQBNJxfJzBO2dswLA9Tf5OpmYS?=
 =?us-ascii?Q?5MiJTAqCAunkYot2kP/+gLmdrq/Ts4hzIvCc80sMVM9/AXX6QCnFzaWoavdc?=
 =?us-ascii?Q?shuq/XrfWWHw28v38UKyRNzn38njKQKZYPsuyOqeUO6lazpJ+Hc0QKF7GO4F?=
 =?us-ascii?Q?XKpPDhsJdYctlYpKjSzvkb8YunVcbFvH+um4cgZUqXqhvRNZQ88SllhUDh++?=
 =?us-ascii?Q?G/Q1kqBxvrkftj0d4c3u6KyJMG4iabw/ZsRjw4T5AhICi+xMJhPx6Hk0lP3+?=
 =?us-ascii?Q?2i24juNWi44lolVtNbUzletnnZhlbR1DcGIEiJxgOto1UcfCUEoaeW5o0jDa?=
 =?us-ascii?Q?aNdHPUfQHwnnq9m1m1E1dOXQHCQlLjjxnQTVlQUYVVo4lW4zEBfNq3YM4eEs?=
 =?us-ascii?Q?w0gjHt2J8cw3FIiJIptu/t+N22jDasttwtaWFj7uJZ9kUrwPbmN7BHm+Nfj4?=
 =?us-ascii?Q?G51d8RZ+VMF0jTqYGSFIvNcVLEgDicED8Xrlrlj7TtvBrXqiRT0vZXoTiK9A?=
 =?us-ascii?Q?nkm4p3KSE2jnwgzaOrqvFjGmz7lW2geYVLT1kfv/2q7kFqQ1IApJLIb/sZUv?=
 =?us-ascii?Q?ZyRY2rn1s9vw2bGc8Lv2K0iRaTFlC+sDxfmz56A/tNXbEh41jmkI0qanDq78?=
 =?us-ascii?Q?LCNK8qCoGyq34wJ4eZdR6hHBzEiyi3fQ6nYPQ/tWNiUdz8jh82H0HL7gjBOb?=
 =?us-ascii?Q?ZN0l3gUkT8/cGWzFX0SBWAQ7Zw3xBOGpnZ1fpDW534dAr/Giux/SA8Jnrf95?=
 =?us-ascii?Q?nL4iMyWIt7ZMXrDLUKetSYCHhPtEPGpxnWzlb4oOZvLzQVYE4+bqgThhfjQh?=
 =?us-ascii?Q?dP9xHzNQ3pC8qUu2X8eyD/NX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zKzsxy56VywkGgh6CbzbyNJdvY19MLoPEuBFPbC9IFi0ZKa9jkmUMHrUcWcb?=
 =?us-ascii?Q?SRxPwbivnuBlcHanM4qx7+o84LT6MOZdM9zgWFlM134t2G6kXzT+36/+sOIP?=
 =?us-ascii?Q?zWjQl5384zmmGUcuyWYvzti5hIdYsKnp2HV50rYZH8JmdIVowlol13cXpoK+?=
 =?us-ascii?Q?UGK4tRF68abeNVbTx5CACS1P8EwDmN6sm4ySMcvGdi5gsJvvTnzjNykw+xO0?=
 =?us-ascii?Q?6Iotg/slmi+hc9lWSuK0YzMMAQI0//6RXfodMbJDmWGhxDeyI1SOtooFrWY6?=
 =?us-ascii?Q?EjA2OCE+3SP2bFKc9Vim3LJM/ejSelvLbx3YrF1WllZezPhdtrwpuEz0z18W?=
 =?us-ascii?Q?05s0yhLNawkWu+oO+CYjlFUdLXE8dOwQnY9vk/rczMGIImYjThUGZBhKhKSW?=
 =?us-ascii?Q?9DLvzRfQaSeshy4it4M8ZMwW84JTY5W6zxDL0U5+Ty7f7/WirQvanrW6Lvuu?=
 =?us-ascii?Q?UZA+as9Y2QCOmH0EMA2+CfYyiI2Obau8MmikCr0z+EEJbS/IDVVEBcR6ZTyY?=
 =?us-ascii?Q?IvzC06tvLr17qjmma1qmn0KSYsPMEL8QCozP5l1CURWWL9B4mnUbSgMCq1f5?=
 =?us-ascii?Q?LntL3yEjv2jBC83jEHQ78yOZ8vaAZvrMN7PBvMIE5RQj0xqKfhLNa7Dxzv76?=
 =?us-ascii?Q?CgYHWfcSMbdkNmDDCDubJiZaUSljk7OUnWoDChnyfWuFMBwyjp+MHmyKB10H?=
 =?us-ascii?Q?cMm4tzyQFQyFZqd9Y5xrvbatapZMKmWkk+V4k+SOHPSrDwH28d0bRstMi5S8?=
 =?us-ascii?Q?3ZpsKY8ez9lkqe99phpG86BLTwnOMzW5oYHI2zC3sb4vFjBKJENQGWZkK8lM?=
 =?us-ascii?Q?v1eXBvcQAHcWaX/jiNm/GGZ7uulH8FD1zzmbpNXOIWAL3x+onW2fLskqmPml?=
 =?us-ascii?Q?3NvQ8oGdYy2jTkIoWF8I2tVwIqnBe67xZbXdzFmt71NAXpnyXnbq5alSglt2?=
 =?us-ascii?Q?NNxqWgm/Fd+ZOdWgTnwgMzzXeDzqJVmFCkfb2YLzDN9z3mE25iIhP/0kUWNb?=
 =?us-ascii?Q?VCnY2ma1oGoYwcXb2vnI0qrmNSYMa7zhc9kGvkFR+xKwwq2DcAy4yK0P6fnp?=
 =?us-ascii?Q?Ky//4+XywQkkPI6WyuKpLNfmCwkxCXwZniTx7lBVdVOlFwDZlfc3FQLGp4tn?=
 =?us-ascii?Q?2L+YUnlxQq8Q9CXrUhrnLztu36/A7PvN0DGLYkrHb/xtfhbzyZ0oRRUzQUSc?=
 =?us-ascii?Q?Da1eLlKiTiLt6dneln2LVkRcJqV45xWh25wXMzRMwPoVw6aqFi847Qojz4Cy?=
 =?us-ascii?Q?x/a26rsPOonE2LYwIrjXesn76t3OWfGH+CLZmSOlEOGEqsldsKmovWdj9GcI?=
 =?us-ascii?Q?C4KZ9HAXIWLT320eL8XfIisRiZcV1C99ssdFyFRpMWhlS8/RcrHxLkvkhLcC?=
 =?us-ascii?Q?cIOPPTvR/KBOv7kTckTRPPvLJLe2Rp29h4qklrAKTFl0YYxuNXirIJHkU6cY?=
 =?us-ascii?Q?nPUg0cGwrNYF5oqNmGi6zcn9UfU93rU97MDCESA5FrL0IgnI/rY0/nHnvScv?=
 =?us-ascii?Q?U2zCyfhjp8k8urAKwR9RVNjFkLoCpHU3hjRSWoBN32TkyAE0v3M5P8Xxf3CX?=
 =?us-ascii?Q?pY6QaQSQKfj/9IsplCnXfPQMvuTWUX5eUDvkHgrcEWY+VRkVrv4K9glIJl3G?=
 =?us-ascii?Q?JQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98ff8cea-be46-4e27-dbd6-08dc8eaac7c9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 08:52:12.8120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeGEGEOjkD0Pl6W2d3UNbfiZrsn0HFuX1zIeBKMINXJ/erS5ku4XAmJoWAGdSe/Zu8eCT1Akn8JD4tL3b1hO8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10659

On a Broadcast Sink, after synchronizing to the PA transimitted by a
Broadcast Source, the BIGInfo advertising reports emitted by the
Controller hold the encryption field, which indicates whether the
Broadcast Source is transmitting encrypted streams.

This updates the PA sync hcon QoS with the encryption value reported
in the BIGInfo report, so that this information is accurate if the
userspace tries to access the QoS struct via getsockopt.

Iulia Tanasescu (1):
  Bluetooth: hci_event: Set QoS encryption from BIGInfo report

 net/bluetooth/hci_event.c | 2 ++
 1 file changed, 2 insertions(+)


base-commit: 1db01d15e2dace241998151499ee9b986ff135e3
-- 
2.39.2

