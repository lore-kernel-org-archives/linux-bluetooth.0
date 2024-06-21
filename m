Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2063.outbound.protection.outlook.com [40.107.6.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C43FBF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 05:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948065; cv=fail; b=WyUHKspYt9MVCWL1kPkqj5Q5oPfO9JkGuOq3HPaGYWRkZGfdaO94vhCyOnP1bbaRRei3M5GPZWshWla/mvvo+NYXhygjYlCXh2Ga3cEok3UyC3B1GT5d1Ty9n7Ol9E2tzuud4EL/uL1iq41qDBLCOFRbB597nMGupYWu8M29cRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948065; c=relaxed/simple;
	bh=cMVUmvq21xK041gYDusLQoocTWC89U2SO/rQPeQ0G58=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=VyhURvYWzrvZF7Oxkpw+sBWCFGmtA90WtLiV2zmalF4hhlEwdIsMaOxhzGg+4R/ZzPTF6j5TsCI52qyhHLAZmHOjKSF9lpaqnlqgV9vE07UIEboH5H7+56P8XVMrfX+9S7a8pLqJ3ZEowbD90Ovlq3mFhDdE9gPUyiiwVHzP11Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ymbx3HmO; arc=fail smtp.client-ip=40.107.6.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ymbx3HmO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i92Gr+98CBgXfHukKUcCU72uqifZxuuz7OCW6sni0MdvAAwzK6NN9eGanZTBYTVB6nSXglRCeN8zXelre5U45TJL94Cs4EAOC7Kk4SEOb5xkxVQ4PZW9Ryx4ZtGHHdeDcvbL1wjoyBzvcLF/DHRPeDsIf3LnisTPUTvi4QF7lWq2IGWxf6/UyGUPL0KFHWwriACbjEWm+9xNWd/jN92Qf4m/zlrB1DczefECky5JHN5tiyZsEKzy190mfGmwvTV6ukotjPmlfaUpMDJFD8SlnYaO7G1CGaPgYKUqqGfGpUnM4JNKR7pLNrZx2Iyng/qKDwsu7EPiCldqgeUVzIdpsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tNbUdEPyRB8LW4Vg68rH0igOWq7CqSj75eR1N4earw8=;
 b=WG3KyGame2yHIQILB80P9Oc1+HSyOmL82CdHf2rZkacsJsuoXWVtcCuK2Agz/dMcqKss0bfoXd8epqeaM6swkitqnbTZXxXvBqhtx8dPDOrhlQetZARvCucXs7//Ak6ubwVJFaAb5UtJBydpw9GCTyQTxvG0nVhWApT2qZE+X9MuWbbxMs0Hy9+2ndmSZ3hObEsE4vpdCGVjXO9IVwtWB3yhSFZyKKKmV1XHQOjm8GjyKK/nqwpfVTzWDHF52o+uHJCB/eQpgIWMdv5Y+9B8BQKCfN4h5CfeL3wsuTq8wwUKpNFV8oUMuh/ybrgd1pW/+S/h8K3s6FX2pFxyKrVvrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tNbUdEPyRB8LW4Vg68rH0igOWq7CqSj75eR1N4earw8=;
 b=Ymbx3HmOMXVma7MvLD1ekApJaREnUSipzlFcp9xvq7JW7Yb8JI/4sDPx/PYqRRB6YGbQUZbmsHPF85v5d7uqId4nwyLdw+U+DXH7sTkdf9rseVz91YlXJu5oORlIpmOGPdQmYzvjOvPwZ2cvabRfF5a2X7mYoG3kW/AjCL4AfGo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by AS8PR04MB7749.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:34:21 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:34:21 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 0/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
Date: Fri, 21 Jun 2024 11:04:03 +0530
Message-Id: <20240621053404.13984-1-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0004.apcprd06.prod.outlook.com
 (2603:1096:4:186::20) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|AS8PR04MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f4edc3c-f42a-45c3-7071-08dc91b3cd51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZGkUA/bKKQOBPWIjwlrQtszrT7+NU4pJ9GmMi/alfVT3f1G1NU1XSBLWuuU5?=
 =?us-ascii?Q?B3KCErOV8pR/VB7v6wMWuutlPqs3XvJEbS2xajqS0sc2RuP4BjUibleem/ND?=
 =?us-ascii?Q?4DivrnfqxrHfSy7E7QEgyqxPDGYgIHbq8wKZNYbDkGE7mjwj9uYOw0J86uZL?=
 =?us-ascii?Q?TC8bL83/GNGFtBHqVsUvdiriWPfeEMx2wqLNs3MziMFdxmX/2/ZXw+R+yzTl?=
 =?us-ascii?Q?sCOln8D+WykBMoa5N08qYQ95SViz935Pw9aVOwWvW641Gws7dVQGxe3g4J1o?=
 =?us-ascii?Q?hQwLoFbbIMTcRhRVO0C9P3Jl52jWCKOr4NP8nMuC9O4iFrInec16TVypnQ9Q?=
 =?us-ascii?Q?1pCVcpa+WmN22oiOsdSYY9EdWBbumblHImPDqxF585PhgX6SqrL5dkDOoVlB?=
 =?us-ascii?Q?wdRw7wsbfRtQOjZ5AZZqgDYpufxjRXhxJoZCs9ZCdxy5uP3BSc2owPmn7kow?=
 =?us-ascii?Q?5h4K7yxtzBUsHEUEOoLuoMGUWRrHnep9JIZ2YHmZZh8mstQme9kkoXl1XYGH?=
 =?us-ascii?Q?1jkmGBg5CzhJtD/8DsU6frEc8uzPppVNPO13FO78tl0uDiscLhSG+m+c6yIy?=
 =?us-ascii?Q?/L42FCkaKl66hb1QjhNyBMAObOlvqJK62SzIHRmE+PRpBr0GogNFpmgOfB25?=
 =?us-ascii?Q?EaeUstHbInMTC0UBh3zO8qK1+XEpTqlrcI7xcVtADR+QzatXBz65MOIO8nPh?=
 =?us-ascii?Q?YQgzFhITQJdTIufJX0+U0FsAuMyGVrSxUMXF03ATrtvzaEuFQIDakAIz5Slc?=
 =?us-ascii?Q?TMIc1W9iFFDZRgm1tagtMf6v7UwBsx5voTW2yJ91pQ84VvqISEZ6aILdjdxY?=
 =?us-ascii?Q?+gRFQHW7nS7X60XVJ32gLSh1eBvcjSzqcfLw/490GUjub8Fd0QxNZpd/FAAM?=
 =?us-ascii?Q?HeGRoQvQ86fdDbpDyyc7cHSPGJylt/Mb9sl+g57GIOsO4CYWt6rJq4GXdzAQ?=
 =?us-ascii?Q?Y3tmYNoPkUPno8PF0rI2MM+RdBzINoP9wzt2hvZvsfKV5T0Zp2wxvLY5E+ef?=
 =?us-ascii?Q?eqR0COua0nJ04Cdtp2syLVOzEKzoVf5SR0ZMaG9N56HPwreX4hschRW6K8Ri?=
 =?us-ascii?Q?Jce8xuPHfaQ+WmULms0IxrOTO0JJX35PGA1slq/7w8T1VotLaZ+s56Jmex4C?=
 =?us-ascii?Q?B5jfVRWqTbI8WYDx4bWWVfFd7PB3Ojp3TOb0vDZ328PK+Pnk+OZeGWTzVm3y?=
 =?us-ascii?Q?U8E/5QErtsBNWOXvqCeVVWQC0ghwu+CUJPpR2nA9DY++F2oCf7LVZkdlHkRc?=
 =?us-ascii?Q?nK1a/LGChtToHgGY5gXHvvc8k2YhSs5k4IUDhuzB9aiOYkjLcVxLccI7pZBe?=
 =?us-ascii?Q?+7quAnn4VlfSvZjiGO6utEbUsA30C9oC3C+vAJ4o/HvLE+Gf+HjPGgShv+ly?=
 =?us-ascii?Q?tC914W0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XdDTBDPZN/X1ry73Jk/aBIenEd2GROvhIu43eX3qxhk0qMuLCkaatUVli21o?=
 =?us-ascii?Q?uuVlY2OuQKQbgU3iYItWjFiT3AORZlzCn1BedQrGj17RKl3mEHmIUzXTZEQZ?=
 =?us-ascii?Q?kZBt7Gz5qHx49unFeBwjypfyjK/kMf2lqYfJcgzMMSf/BvGZx8tnhg2b72y9?=
 =?us-ascii?Q?8Xn8suDDktdKGAhU6PoEae/Dx2CsrCv7spIrlQJSxueTsYNseWAsO9lAKZ5W?=
 =?us-ascii?Q?9W5igTFmwUz+nyD62XiImHSvqba56+V8mjTBpt9FBknl0znugQ3q5G+bV5Hu?=
 =?us-ascii?Q?CofWzCdO8GMzDU1gBaR4CgyGJ+W3ry5oOeUxsKp9Es/MxM2mdYCxocR2temv?=
 =?us-ascii?Q?/ptlq8iYsjQpwnfK+ebxIgrK2N9sBjm/mq8+JfnIVdt56t4/DPBVeC05ogxy?=
 =?us-ascii?Q?qKYkm6EAv+zOKZxiDRe2uRJXz8I1bjBvBMGK4QAvJZF2pvx5L1N8pTwx1fWP?=
 =?us-ascii?Q?8Fik5wcXESKaV+F7gqXYRMmr8qEZR0SmsdOwfLpeddir4gWgmMHhq/pf2civ?=
 =?us-ascii?Q?JW735FEFdePGjJU6yOq+pO0zA1hv+vPUFsNDi3G3RErKqK9TPMaxCrBoUm1B?=
 =?us-ascii?Q?fQF0vwjBW42XSg7iaUTaeuMXqQ1KkICKgdwQDgN1cDRJTD9scCqZetw0fw0p?=
 =?us-ascii?Q?SC1n6D9qsqdkxUT3VaZRjngJyyiEIy1UvFw0/QgzH0tZaWg0PaGa0bk1eZYl?=
 =?us-ascii?Q?yoKfIyHgD01APb+u+Qib+/YIWczC/wDUImuOhX7YZIR+t3JFw+mhkaraNJFW?=
 =?us-ascii?Q?Ftq7YUUf+SMqRMIizw5bRaL6Kkv2FkHsckvMnMQT9wxw28ptq4QIeIFZAEWm?=
 =?us-ascii?Q?Aul2j31DjWEgUEOodrg1RwCTNyvenpHJKnfJJDqfMAn2/qr8rJw8ZVtuhqd+?=
 =?us-ascii?Q?cqwqm/nP+aVOVtJ+wYVYMNpP+1cfgLoh1nKI2YuVeybHCfepjMHzsLtUFxDI?=
 =?us-ascii?Q?hS2IUWRQ5mzPt/zlDL1RvVfc5wSC1yY1unrnRHfA4J03tik9HhQIdmEF+L8V?=
 =?us-ascii?Q?/n8fPdEe2OjomGZYb8tJOZefH3pmxNlxJzSe1TT+cHQo3/5see6L0Z2xyKVV?=
 =?us-ascii?Q?aahFnMEPAcVPUaUAUEPfQlpvC8OLdvpijNeznwpEZEHm7GhljLCCmADa2hZT?=
 =?us-ascii?Q?QBd82/stOZ/xTAbuBTcydLHETJdIE9gXvetyY4oYO73lZwCYQZO2Nec8iGQ/?=
 =?us-ascii?Q?H8MpdEY0kkv4rnjnnfIOXq2pkJVkd2qcVuzr7VDiCxdgcz1/1Rews117gziq?=
 =?us-ascii?Q?QOAYgKmE1Y55lU16ZipEaTCSYBu274LAKEDEANterM+/dEuhSiqPwLB5oGOR?=
 =?us-ascii?Q?c5kc29NxgJGN0cnnjEmWQvmIHeemcQ8u9x/8Axeycxhn6epf1FiWXbuGas+m?=
 =?us-ascii?Q?OgIG43RreLQN09xv87pely9Zz6Jigm8BwykJdi71E+09PmIGHp5KNAiN+XhT?=
 =?us-ascii?Q?DZi+YoCOrTRgHfK0nr/OXdvTc0BYLqqBtgmzT8HX37dMQtbuull/6y1AEha+?=
 =?us-ascii?Q?LHLuF8DKWmERWiT6aUTJxlKdVc7ga/Y9TCLTo7BAOoQZ3pH4OhpEURvebCO2?=
 =?us-ascii?Q?GszK9LToZE7VcAk2NujnMkIdbMqSPGTcTgULd9awGCb2NtzHdVCQHDs91H2C?=
 =?us-ascii?Q?Cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f4edc3c-f42a-45c3-7071-08dc91b3cd51
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:34:21.2926
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z/KIZ+IrueCFR4ZumJRyAxirVNjUgS5LnWUiQlvJm9DWospYrCaVwa5HcZp7FkiWaqJn+i3LTYIRQnOIDlHL8bdRoywAXhri9noDJ6AipUg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7749

In the existing code, iov structure is initialized with iov.iov_base = (void *) data.
If data is NULL,casting (void *) NULL to iov_base results in a null pointer dereference.
Inside the loop of util_ltv_foreach, util_iov_pull_u8(&iov, &l) is called to pull uint8_t
values from iov. If iov.iov_base (derived from data) is NULL,attempting to dereference
it in util_iov_pull_u8 will cause a segmentation fault.

Added NULL pointer check for data so it will presvent null pointer dereferncing 

Sarveshwar Bajaj (1):
  shared/util: Fix null pointer dereference in util_ltv_foreach()

 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.21.0.windows.1

