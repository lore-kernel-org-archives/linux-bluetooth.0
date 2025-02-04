Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11021093.outbound.protection.outlook.com [52.101.70.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D20F207A1D
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738664225; cv=fail; b=K7WHaIoiRpgBh3B5d51a5dcL4PSgge06q5ENCtJ7bszi3H/YqpSE+JjDMC1xgQ3bk11yNQ28VzBabAHUl6/B4uQDsK5455gK1ZkDZMTVglvZ1Hbso2EldM+vu6o6dDWzDYfsbw3imhKH6z4oY7/LvF6QMJvgoxPzna2azoH7GD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738664225; c=relaxed/simple;
	bh=Bqjp6EhttPP0HaYWc8YkN0OVoJB7+cTOj5+8LG0kZ6g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCWJm5C9o9oBXtV/ksQyWoo3edhI3nAku7F3mn0ybqd21OVSoG3tHzHN8hwTtx7QG6wJ32PLu3PpTLfe/K2jug3L8NRA9YieXTSkHihTO3S3gPI0EJfXQlq5hM+I+L4mMIwfbYTa0hroerdXe5nBWOwVXD2g3OMRzJdePlLtM/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shsconsultores.es; spf=pass smtp.mailfrom=shsconsultores.es; dkim=pass (1024-bit key) header.d=acshsconsultores.onmicrosoft.com header.i=@acshsconsultores.onmicrosoft.com header.b=CYeTOzf9; arc=fail smtp.client-ip=52.101.70.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shsconsultores.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shsconsultores.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=acshsconsultores.onmicrosoft.com header.i=@acshsconsultores.onmicrosoft.com header.b="CYeTOzf9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfctZnBlyTl9XJFepEDbUO7PE6V2G4uf5rr/VH58Lrv6JsABPpFxHzjsq/rSYBVwbvxy69YznnlXtMd6879ZCRa+XMzGCeiCxXvgGIUGCpY8kJpY0cw7TYFBrbdQ0tY5NpIzPJRlwCqpzOODh39aZIdKlCBH8Z9PyXyJOBrw3sWE0/zq+PgdvbB+q4OxdyyszlVXVrVmF83rKLFopLbeQtIbhQyWvPp9aiWqfuA4ogteh8R0GzPfIQ2b3CcCuUnYjBvJiWnsBvZi4e8T52g9KrO9ASHrJihhma3vOpSpzVUUPSrD7EpJtLH6k0eTcuUA3Rbj6svoG3c7aWyU/oydmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7VGcKg2EG4qboOXZPFSgIvzAcZDCc6fHFWuOKzc1H9w=;
 b=AtTEbD7PsEdCC/x1eULRMDnusv5C4rEQod4imaM30HN7NUUNPLAMoc8kENtmlAcNT5gFES2VNlX07Ns/NOxubKkHzE3J4JmLQC499bd1/NAu4fa1z+Sz0144i9LiqgM8q3KKxZ1rtyz2QCiGzb05+ucqOYDN3dOWHILWyWTHjFjUUoczX4GZXQxvSEDHaLdViLM0fGauXX45ZMl2Cr3FheAYd2OvQlp5dOJ+o4MbB76kKm4s9zPrzGz7hooaUrZgFaUtq4pbKmNJT+NMvgP6VtKwwgopwg/2pHWoMHXOGtzhb8Eowt7+Nut1+TusRzY+OoQm03PFu9vF13snpYJj6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=shsconsultores.es; dmarc=pass action=none
 header.from=shsconsultores.es; dkim=pass header.d=shsconsultores.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=acshsconsultores.onmicrosoft.com;
 s=selector2-acshsconsultores-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7VGcKg2EG4qboOXZPFSgIvzAcZDCc6fHFWuOKzc1H9w=;
 b=CYeTOzf9bZnOef9VOeerjNMwbfD2Tala6j+JZ+FDsqKhiG/g/jE88MMhv1ceq4XdN/fzAsOOrKIu3olOgSzydCGz3j/hdMZmvq49WFfu4W4kCHvKunCR/W4JUMcIb5o2XEXPKv12NxJ4C3mloHVLm1CPeySS0l4I+6u9I27P5RE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=shsconsultores.es;
Received: from AS4PR08MB7653.eurprd08.prod.outlook.com (2603:10a6:20b:4cf::5)
 by PA4PR08MB6240.eurprd08.prod.outlook.com (2603:10a6:102:ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 10:16:59 +0000
Received: from AS4PR08MB7653.eurprd08.prod.outlook.com
 ([fe80::fbf2:7802:4c0c:8197]) by AS4PR08MB7653.eurprd08.prod.outlook.com
 ([fe80::fbf2:7802:4c0c:8197%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 10:16:59 +0000
From: Pablo Montes <pmontes@shsconsultores.es>
To: linux-bluetooth@vger.kernel.org
Cc: Pablo Montes <pmontes@shsconsultores.es>
Subject: [PATCH BlueZ 2/2] tools: print error on mkdir
Date: Tue,  4 Feb 2025 11:16:12 +0100
Message-ID: <20250204101612.66823-3-pmontes@shsconsultores.es>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250204101612.66823-1-pmontes@shsconsultores.es>
References: <20250204101612.66823-1-pmontes@shsconsultores.es>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:2b::13) To AS4PR08MB7653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4cf::5)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR08MB7653:EE_|PA4PR08MB6240:EE_
X-MS-Office365-Filtering-Correlation-Id: 883c7770-dac1-4d5d-4e14-08dd45050fb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uvIBw840eVtccmDBec0lcIyWb45ZQZVHGpTQOgSaClnnjkGkI1aCK1su8foq?=
 =?us-ascii?Q?b3IzBir6YHcj9qNEP2vduV2V0LsSXy0Q3YO9Z8eZud+I0ZftehfjVe1gRWsW?=
 =?us-ascii?Q?++BkQ/mT5qlifjqKcnvEj16YCRnDVqRInBttqtgl8OqIkWaOqqldy4s2pMF8?=
 =?us-ascii?Q?WKdRZF10cGj3Y+Jw9tXmUr9G73c5r4K89Vz2HpgEZIFZTjgGZgoUwiUqtI9b?=
 =?us-ascii?Q?2FMaY2kEEa+nm0+eeZbJ6navCu0ZyTEss3GqSdbPKOXikxUdc1xCL5oqui2P?=
 =?us-ascii?Q?1qAUYDkMxDp/NUgJGvX/MfgQJuQQ/1QhbKpVIZuz7ufqmNxSkl1Ihi+k0IKt?=
 =?us-ascii?Q?vvu0nHJUqWyioa35+Ygb7rYU8NqiQAtyHU5Q8vNyG0JWaZrxs/uFYimGLEpe?=
 =?us-ascii?Q?zJVscRYuNNWadZOImnDKqLKzWUm5bBeFD1BhUpRQEXoylRNw6IjYZigmUJjP?=
 =?us-ascii?Q?oiYlVTYEFQpNAGcBJLMvCdqqs/ra7wpKiZxBZQ5HShXIDN6PriqsHBNqFfnl?=
 =?us-ascii?Q?Tt8lLNP4CllUpe2zienmPV5ZXYgZx3FrL7wacekCYRRT0ArY+W0gZuWgv393?=
 =?us-ascii?Q?D2hC21a/QlEqiWm06K+5zmu5n0XUfLBLAmOxigmB4/8Jx5tPM4FMjIBEVNjc?=
 =?us-ascii?Q?z64Lrmdm9oEJX9sgkr765FzBML2SHu10LINS6u+BOlbZ07WrD6TeR95Zt29I?=
 =?us-ascii?Q?vPbWNyB3XkU2sA7D5zp3U76FHiOZVyexDGgm6cX7XkRpjdGWxJwdB69z5Ps9?=
 =?us-ascii?Q?g/vtB8VKdQRlE5PTbSLyC+/R1C/orJAkA9aFSowIxYFhmNFQA3Dv//5JdCPK?=
 =?us-ascii?Q?/uUmp7VApTXkgAEza8Ti9vbVmAQGThNcBiEEMM1KU7Z1eSZkrSaylDs1hFee?=
 =?us-ascii?Q?dmY9sxohJEYFc6ecrCCeEDyetU2L3J6E4ux5vPWkt/WAzENo9zCHqodd35/v?=
 =?us-ascii?Q?/+HyY2HO0LvkhXEtpy9ZqGxtG5eTcSik5HO5wyJZwm1O3mGOb86O70LntJjU?=
 =?us-ascii?Q?vYMqPLMiU1+hvI0LZtj7jHfouFujiPWHUkNLvNakAKW5VBorpRmwAZ/osvNa?=
 =?us-ascii?Q?5G5EFQKtY87WLY4bmKwxwPwQCqZEBqFGhvNPBR98Vwz203kPqArVJbve/3iV?=
 =?us-ascii?Q?duswA0SF9EYnw++1ZB3DGAlBWylepn+Lz17uxUSfBl8FmsT5dVB0KAJJrJt6?=
 =?us-ascii?Q?32OqjRvcxzWhAQwinj2r/FRwVW0nm+YL7F+OttD+sP3r8btX86oEqepVcm1+?=
 =?us-ascii?Q?Osrebl/1dPwJGq44vSopGPYun3oG14BE8U03DD0M9yJjulCmkEGa88XfHalZ?=
 =?us-ascii?Q?1ttPtfbUmMNTsUhEn+Sw1Vg5rzXYbN5x2eHMifBI+8nW2Tg4DkEXjf8NLHoj?=
 =?us-ascii?Q?UHTA9ApC+f0XK1+F3IXJRzMmRu25JOjE1MAD5yovX/lEmgpva3gVeOgr0cGM?=
 =?us-ascii?Q?Hud+YaKT1qwCUfSb62F3YqSpMJRrPdjk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eZaAHYfoPcbkDRTk3VnWUs4eDw7gcRI++Xybg0sQfLOgwapPZcHMWd+Ob5Xz?=
 =?us-ascii?Q?u/9PK0Bg/GM45PAdy2kIlnrHMWspSiIER/tfsaG8JcuKcVQN0YUwZyZ8QwAX?=
 =?us-ascii?Q?3NyeFev4yLKdc0tr3F1/zErAVwo4zUKQC7wyfFL80nvfnyZNntdk9qp+ibga?=
 =?us-ascii?Q?HP0M3sUunMcL5Jk5PPsZkCsXbG3BmiqAkx9ZGAXSMHTv9VwjXucMEJV532c7?=
 =?us-ascii?Q?3o5KtUKxxX7+gIMHHLXFZpnFdmLFFmRVMaAVtMIVTRR/Bnlw8agq0Qz3eiu7?=
 =?us-ascii?Q?U4hwSjXsM+HliFN/qGtBYepJ/ujJD/olhgF/84XM+7GhCkWicrFjK1qw2VfI?=
 =?us-ascii?Q?McwnGoZi+zkaH0LVAfaqpHd85gWYN9p65qZQD2nFgM4QTqaOUNYB6nsvXGtI?=
 =?us-ascii?Q?pJ0DplIxDzaDtS606UM8Nop1oY7XuloRQ0WAGWuM5kQSlCDCgXTmq3Y63kUf?=
 =?us-ascii?Q?ranewKBDS9ZW59WntB/bHVvFbQba8stRhVB3WqZBnE3m9gXdOxRu7dfR9Pxo?=
 =?us-ascii?Q?x6L1LFCHD9cj06saoDczW2RSMpIq5WpE+1VhLltO4lWtuWAJjKXO3vo+Z8pJ?=
 =?us-ascii?Q?O2XPIPP+oKo978ref0PjXoUB255g83iKsI10P4pBvf7F5gLDcsVHWAsF6iOE?=
 =?us-ascii?Q?1bMuOGpaxVSBXqV23+FtsJMm7Rm++JarvxW1E7Wkp29HoJR525kSbiNGAHle?=
 =?us-ascii?Q?SWvDQ6fnlRVAbmciDsrAMuutPbHuAL3B6evCJArafTI7pg58/8nC3uV2cNoX?=
 =?us-ascii?Q?Oq+86vQWNGhQy7ELwllVmacU1xU26OJF3h8hI8HhfDOCXQ0RUuM0RIk0v9GU?=
 =?us-ascii?Q?CTVmz7qgsGKDltYc4zrKOVKtEV18LfkOHsONVKB90udtamfHiPCETEUztPTK?=
 =?us-ascii?Q?jUnyPAre2ieBaOfU89EwINC+svCXxt1f6BT2bjPiMuN8AVhlDStsBpZEYsTV?=
 =?us-ascii?Q?Nqqis9ocHye+PFTx651gIqGv7m1fUVqQmfYoeuhlhnQU88oObZrAW0rN0dT3?=
 =?us-ascii?Q?dNHQBuQwqqH3jdStsw/l7cLm7ZQwrlgEAQwFIZHIFexNYwZTzy40yYCc3IEk?=
 =?us-ascii?Q?qjZKl7Qc42FG2Gt5KWQpB+NxbbZ625k6djsS01XgNuzUulQOXSpIHsfXa0j4?=
 =?us-ascii?Q?jDSjYJRRoudVEpLiMk9RqLrTvgmWUtvIw2xzlKEEtSH8j3gFvTLxD84jo/25?=
 =?us-ascii?Q?ekkk4akdBddXI9ITseITSkDcAj4fo0vQS9wHP7q80Gl5lQiZlmQ8K5RE2tIF?=
 =?us-ascii?Q?2HUY2P0i8yGiORMobJ29D3/0j00GSTpf9aDP6vpCadZBMMQkn+INoFoIo/Q8?=
 =?us-ascii?Q?GJIs0+oGBWQkSOq89C9gYtHCOncuPNHh3BTTfJfCuU0OhuQ2PWpl+B9L6EbE?=
 =?us-ascii?Q?EGekeyZcBFI8OiNuTLU7HZnne15tt2w3TG7uojPZPqvpvEYNC5qbSeNeb4lR?=
 =?us-ascii?Q?L6wfb5lwW8QP7ZKyGoTS39eavkqnf1ol8j2NCtwhRP3LXqEPvCbNGSa754cb?=
 =?us-ascii?Q?LEWF0Q/WyZc5Gi99S56FySuKXxrbSPmlf+JvxKT72xZdo66zLAQmWZncXTl1?=
 =?us-ascii?Q?yDlD1QrK7PNsXWLAHIT9v1GV/u/4aFoRD7sAMfRqOqhJ4QB5VvRFHoYNRNh/?=
 =?us-ascii?Q?QQ=3D=3D?=
X-OriginatorOrg: shsconsultores.es
X-MS-Exchange-CrossTenant-Network-Message-Id: 883c7770-dac1-4d5d-4e14-08dd45050fb2
X-MS-Exchange-CrossTenant-AuthSource: AS4PR08MB7653.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 10:16:59.8651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: daf9f132-b852-43ef-bd93-64da5b8621ee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TmhHV7yp5tvgkek6vbfSqC9R17MSkkVTRUKPduOLLZ0Vl7wgv0oTMpFqydjbJQ+q5lAlOnflkh11Nt6Q5/S4EWNa7N8q//G454Dy+RhDGJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6240

On some fresh installations where XDG_CONFIG_SESSION is not defined, and $HOME/.config is not created yet, mesh-cfgclient failed with no hints
---
 tools/mesh-cfgclient.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/mesh-cfgclient.c b/tools/mesh-cfgclient.c
index 3bd2b673a..b1d091be7 100644
--- a/tools/mesh-cfgclient.c
+++ b/tools/mesh-cfgclient.c
@@ -2529,8 +2529,10 @@ static bool setup_cfg_storage(void)
 				return false;
 			}
 		} else if (errno == ENOENT) {
-			if (mkdir(mesh_dir, 0700) != 0)
+			if (mkdir(mesh_dir, 0700) != 0) {
+				l_error("Cannot create %s", mesh_dir);
 				return false;
+			}
 		} else {
 			perror("Cannot open config directory");
 			return false;
-- 
2.43.0

