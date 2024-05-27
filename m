Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2080.outbound.protection.outlook.com [40.107.241.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672D3B1AB
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 May 2024 08:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716797345; cv=fail; b=r4Z3/5yZFxlfjnixTPEVu1kq7J13qwkPGQK6VYBAth/Xv3CJDnHFHoFSpWhlgNnsmwFiQURMLSFqM5h+BYiFOXPIDWtok3AwrQtrSRRQWI2UkAKbcJF43UEuJFJrpCL3UL6FMUDkCYgWaN9qz/ku2q8+Iz0UFL+JyyANmEEIRcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716797345; c=relaxed/simple;
	bh=q0x8TmXZr2F7JlMr07MmYwUAHJAD6vwC3rT5WkzERpU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RudL58kHKZADk6SHDqMtDPEPsimOevQEnsFwgHR7V0pc4FOym9TME1sB38qpX6sqG9+1aL1DtdCzOStdIvvemb9Z5op6uiwmhUSfg627n226Meb6uTVzYw2pKggXNKLokYCCYQ/nZFme2bgCiSwpukFLuQHEMqwzm6JDea1xQs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HZ9xMkzE; arc=fail smtp.client-ip=40.107.241.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HZ9xMkzE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kXrGqSHshxWWJ6LCwB/nT9qUclAP8/xSUAorv1vdH/Oz1pVhFMXh5dAOsueEPCrp4GebnybXnqc+oudQQqgQTyAcXy5IZ/uqt0xrJM1aWDRc6NzBnp9IQFhQ785ivhTl6lAYss6vrBiSuAnIiT6tOtznmLf93oKdjh8aYIAH62lhC1f3jb1uLM3buYEF7jSaeSWKLZ5SyvrxCmDxFbUqL0AALe5ZXVz/596lrI9PssiM10P18iUIAACPJELF+fGzFS8XLhsXSPNJUCdkgvRwk9R9ds20Kdo7WQV0+svPuTtcuou3oQED2eajM15hwAfi2QPC3UO9jqZXhobdrXG6lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0x8TmXZr2F7JlMr07MmYwUAHJAD6vwC3rT5WkzERpU=;
 b=dv03IfFOuHWDfPvwOu7AvokQ9DDi3BopXX78i7rEaGji2v5EJxVq8SDsFsvE+cywHK/xonDRl6CPvo1XBbG8Tne7VuzkgOzVyq40vdWZsfrU0ndrbR7qv1D1FB8Y7iqSJVJHTIOrKhD6v2H/DB+w5lY7PLvISO/Y2txBxib3/Bk4r1vttqMaEO+uydpuvE0GQkFFKD/LGmQg9V5mqfPc8pQGnfTyGx9PQ+HhjvhqMZeZ32RpTNDoWZWJ6QO5g51wXnVUspsfk+mnUzhP1zDQkXHQqevrmS1BnlYL4MUx8Eil+gVPCLfyUs3r9VldSFRDzuleN0Ks7gS8kkACwJOkGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0x8TmXZr2F7JlMr07MmYwUAHJAD6vwC3rT5WkzERpU=;
 b=HZ9xMkzE3AiTC4xs61lCsryfbhfG245hc56Ra0wFgTNofvlToZRu9u8ynGGUKGJkmMjgBNyux/uxlhW1z7+PPl1N1mZXjMiDBhcOh9BvpdlpkSWSPwq3S1BjDY/lbkGfRZ3psEoJHEaSj6IV8xtteyYwTrB2aA8oQDNWr9LzaRg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS1PR04MB9560.eurprd04.prod.outlook.com (2603:10a6:20b:470::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Mon, 27 May
 2024 08:09:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7611.025; Mon, 27 May 2024
 08:08:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com
Subject: CAP Commander Broadcast Assistant discussion
Date: Mon, 27 May 2024 11:08:57 +0300
Message-Id: <20240527080857.19187-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0090.eurprd05.prod.outlook.com
 (2603:10a6:208:136::30) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS1PR04MB9560:EE_
X-MS-Office365-Filtering-Correlation-Id: 980ead01-283a-4065-439e-08dc7e24439b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L2ITJA1U+zbtYrPJJG5jIXVHqALb+9xGnY+SwqI97icKLUHtga1ns+U1K6Pp?=
 =?us-ascii?Q?NuIn+7CWEDNvPQFey1JwxL0TgnvUmIsxCbtVEDXSPks5kBggbafhXPIBNAIu?=
 =?us-ascii?Q?Lb4ChCV5ZZp781ioA9kwbr8BEGjcWj/h7wxvzEKwD+D/l4n3kf1pkEA46Kxh?=
 =?us-ascii?Q?zAX/cewBN+TlS0jBmB5FtJzyLh04CtjSm0bbj+2ok+CdSJz9y+tyd8FCneIU?=
 =?us-ascii?Q?HA8UuNWNVL89KshmQ7yXg03VBOqNOGwj7QaljNhVrddL+ovKZG/KfXtEbasJ?=
 =?us-ascii?Q?H10Ogm1dLdZlQlOEfJZmW9SRK0eUWBRMd/doTlkvPRmBXnBJDLz1mFzKz7lt?=
 =?us-ascii?Q?ajqMuHkSTAJ5bWSYm/3P8EE8ex3nJUGwY06AV8M0MTfwseONVpNlj1MCnV2O?=
 =?us-ascii?Q?MTob4YV6Gc2YXD9Tf0XRGYTSMqQ2oN90+rtxkWMe+5NI53Ng9HKFit89ooPr?=
 =?us-ascii?Q?U9JXEc1DfT5X2nubyFk37no0fHXePqxDlA8Z6aG44JU61foUwdQDu7JdGjUa?=
 =?us-ascii?Q?nPMmYMgXskq/z0bGsbBa0of7cGJ/i4XZZMYYt0twsfdXcQHKps14ST3zpWyQ?=
 =?us-ascii?Q?XlMWIG7wmhmTL9gzHOwqffZcjrklNGzej4nCKUW3Sbwgiiw9ZrEVWLMeERRY?=
 =?us-ascii?Q?+yrSXNyVJQNK5vW37xYiiKqPnpKN8UNl8+nRY+Cawnv8m2JXeIqAbVDsRUSt?=
 =?us-ascii?Q?g9FIBzFytMcQmRjMrcodIQvPeMHGjsDUny2ucMczvWiZNjpL7dMwfef49tNe?=
 =?us-ascii?Q?7bbN6MVrixZ6NdbFYErl8xJRteT9GgR1byzeQ2hcMYX3zjTh1UbaMp9nyoC5?=
 =?us-ascii?Q?MdxH1KbfoEDI5kaKL0bDf+2NZLhTiQUC9q7TBoyQmUiJtziMugkGFuRJqcs9?=
 =?us-ascii?Q?t3OvM52GF0kJ6KnASbR2FQgB1GvTvqzDC7sTZvHsKxnhjW1etywCh3lgrRyw?=
 =?us-ascii?Q?he2P4boSNGW4oMYrGkMgmT7kl9N6WWUgRhOuo5beYw+iCcKGbcjhFk12y7EL?=
 =?us-ascii?Q?ZA1jIbYQtYswDI1DDHsMsVOwpClRRsLy+LAfQdqZTwxxQEovIqrn5ZGkoXCz?=
 =?us-ascii?Q?aUsivjJdx0T9YMp8fAFWmBAmvhiLzJ+i8B04ivmrbMAN+iiLrZAiq8QNLGo3?=
 =?us-ascii?Q?r0aJF27eHpgJUJ0+lx7TgxvYcSgWzY/2QSadLMcTFOVJQq/7THvJqyH2cEoy?=
 =?us-ascii?Q?97IgDoIA0xcaW3QOQS4TJiGOdQFD4e4jXt/kGRwslMWokRdlk8OJRf4ZsBM?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qTGyoXzArXKQRftHgKtqI5fZA/wzGn1apyekOnKX/t7BSxJoTPsLQEgmsZax?=
 =?us-ascii?Q?rcrWqPkax3LXzDMAMTBzKaX9MxnHSgt+8x6zdkOBLIAAKAvpS/sCOY9zreg9?=
 =?us-ascii?Q?NahI+1eAlZOkiyI1gGNEjOWoXGs05+0N+UX/9wmHKQEg1nbUguz/iW/1oCWZ?=
 =?us-ascii?Q?FAhRPGTw6DDnutua2Xv9+Fjze4GeBhonT0WHaGjFRIyNylKmuOZHjTQggcit?=
 =?us-ascii?Q?/aPeq53V86tTfb/BxFGutnquNad8YZotybzsnRcB/EtZ8/MUD78RxNb9qNAr?=
 =?us-ascii?Q?xNldyVYI7tj7GSVK4gdgw55bgZzxXd49HmvAXk8NHVMCLxuyqfXSvL47mb/v?=
 =?us-ascii?Q?Dzkj7EvDvxbED69ZjdCjasneiVgEQjIupJWMz6uAJ449N5P8B10dQKpr4EKD?=
 =?us-ascii?Q?2nKLLOPtbY0jkZy6FD0WqOtfQILJPbMnA5DryBO3IjiJDGTeUqpXHaBSUtGW?=
 =?us-ascii?Q?32/kSffK5yyT596YqWnoHKpuKNmvulIgNSgIg1X5nIxjeGuc5fzNit9yNuId?=
 =?us-ascii?Q?4hON9Z75MLZ0pPdXNoYBwPqqx5hS8yPaUMUewfKFN+TZN5eXxuKKud0zjgGD?=
 =?us-ascii?Q?83Aas9osrAzdD+DDV0v65WQ6S/Fq+argiDx3JpHBVHgLcidUEZTUIssdG44+?=
 =?us-ascii?Q?YZ5p6uVxT7L8n3ObTE/DP6Xp7Xyra+2gA6QTQLEgx4LKEhmb35Gz2DOWlYlt?=
 =?us-ascii?Q?hMcQagiWH5Ua+h5QNwrSCvFwAR/gunbtGz8oclyfXCUcsCAJ9VoqnqoYLTaX?=
 =?us-ascii?Q?hrdSyPxFiwKjVt6xtqETrTdl9ZnqprFwI4Xn2dbzGKgUhEIXkBrlOLmZQwxF?=
 =?us-ascii?Q?4DoO0Bl5A162zA8PacERGgVmf4eH8I1NuSgfXzCw+I4SiRp2GVsxwN2iEvJR?=
 =?us-ascii?Q?lj93iGKG37OmiICm9GDMGuijVxlMZV89/xkryiAn9lxl56j22TSzqJnUrtxs?=
 =?us-ascii?Q?6/Rp2mjA4Q5TZSvhjkjipBkEei6FIke+qZWhRjZ/1hlqc1PKKtRJortmkBUv?=
 =?us-ascii?Q?FK3meAKIadcVBv2LCV5qvMVqdRiO/nb3ZxU57HuzyHrEfrHCXO0kAcWIZyxi?=
 =?us-ascii?Q?aEzXF1TgzIzgv+3wfZJB8v4pd4gu7+LC/y7r/horJ6ZfplrdD/wotHkNeGNt?=
 =?us-ascii?Q?iE5jT1MYZ84NYiEoYofnanffo1gAAcBvqAj98HIs5ExuKwOpaM54Y+gU2/XC?=
 =?us-ascii?Q?4XAIxWi4+Y1043QfQj4ngyMMev/tekAonqYEZsCts0bt/th7UtLFYJbdDF7D?=
 =?us-ascii?Q?M8/xnQON5zze6at3v+rhiizJJI3teNrocP5plXDcfKGQjUYOdSiXM8GMvZD7?=
 =?us-ascii?Q?1XzvwBg2gDzxJEb3dIsK5CiuI4wNddTtsIg7YMZ0+gT9AiL0+2Mp/MWuLSlH?=
 =?us-ascii?Q?w0370sw8j3MCl8dsp9nhv/AbikPwbhJnpgAP4PHxaDqS5BCV+nz/xJq9UG4P?=
 =?us-ascii?Q?f/Ioke6ZN68L4N8fgBFr3pJcFl5DRHmSFRFomVgoJXO1UQ2HVwryxomIuH5l?=
 =?us-ascii?Q?HBF0Bab6RbLcWpnSxv7pTCzPohwf1VThcAz+gAdVOYb/8SIO9w6iCJ4dUe/F?=
 =?us-ascii?Q?1K8CPDhK9+TCoAqTcKwov1fFBEo3Y6/hDYcESLuC3dx9zmfsCdmtmZ4NT+zH?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980ead01-283a-4065-439e-08dc7e24439b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2024 08:08:59.9038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kgQolqHlPhXRpWw+1JPLedCrjTYdkCDj7SV8qimCrG9x8QgVbc08gpkDrg8e93SkyLCfWwGmO2llLxY9MfciRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9560

Hello,

I am working on adding CAP support in BlueZ, for the CAP Commander Role
pertaining to the BAP Broadcast Assistant role.

I opened a GitHub discussion with some design ideas:

https://github.com/orgs/bluez/discussions/822

Any input is welcome.

Thank you in advance,
Iulia
