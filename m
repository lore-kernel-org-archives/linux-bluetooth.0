Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941F715624C
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 06:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718952253; cv=fail; b=tvgS9hDo8tnsBYLA6ZTEf7iDTaOOFVmHQadue6SHlCdftE7BwCUR1KRaAx0zpxGXz/3teNdZIbX26TdLxtoYCQ9mjED7ELFQMXYhdTfr6gUI461wgGopQynJgBBLQK3mQUznLu1zBZOIBhSji0JrGEGwLsOYSC6BETRMHGMxYr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718952253; c=relaxed/simple;
	bh=siKsHVabz+6r8/lr6NR2Bkfz4d+IgNYjEPAZA5I/5a0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEGtoaudY18ANKDAA1JY7wbiT6xdKTVjzk6VHLxipWsFQikv9GplQ22zqAVOL533FX9Hmf7wSHVoQ8op9r69WmTidkN34ZfPpue1iovH5ZOUj4kL94CWUy6OABJ2cbHDGarhWvWWWU932VD0hXPLVW2HDULWiRo0OpQqesmOfcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IKOVJAbo; arc=fail smtp.client-ip=40.107.20.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IKOVJAbo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K05p5+MRrW5ISpP4WJwUB4MmFXZfwWWZggZG24KOO0AEXbgcbwT9lCB3OMQyD6izguo1WVZkd1BVKSHeZzf3Ob06m9I1LRWyTd/U1lie9zLYeYqjVO+sFrLDcAD9oNea93GuEoGkeZN2zrX3fj1MFbS0KZR5bHk9oQcE275C9ozqAmmvPZamp5W1x/fr2jnY+Qmv3YP2ansVtj216SK3jVlNjV0WeX2Ig1r1/d33W/m/sAYYykX1FRUDwEzn7a7IpF7MHh9Z7Dvu0TZb8jJxhmRrNoCSDK3MuutSCUEVseZp/MMHxys+kgdjzJaBmDQFQJN10FAW+q8f6QeB2KlnaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qc5p9th/J4JM+IKCZ7P2AW46cC3V6lmIneYwTIAiQHI=;
 b=T2IFSLn9bfSOJ5EoIq0CKFolSkTqMisuippJjTeC/HIrnie+kuJf1PlIxCYd8vWio4lz0IoPLQMWYiJ8IoEdIlZqaozOiaBpDpLsqEC/WemRCCCY31+TDPhdAjOlpdhl3s0ZNsFtZZDdtS4+OgZP1Yd46QuS44WqAHNX6ex47BeyF7XOGEFNF78m0FJ+kNztVmOpuxkAgrDOKhZXkEYE3g02tHI6jz3GqvKJk889V6j5Bp77dBePtPgKk+URtt1sFiOLxIBbVjY8QiSNwNHdn+Y+kT2sFzeFyNRLXVAv65u2odz+qTzCMBU+GrGnhQLzkChJiB+bm2zJ4uT6nLif3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qc5p9th/J4JM+IKCZ7P2AW46cC3V6lmIneYwTIAiQHI=;
 b=IKOVJAboJ1T7l6auz97CjcoL9Vv3sTLZu1kc+Tv1wf2DlyoUCLQJtxU1IJz5LWbUeMVkHNOjneSpKOtZKixc5fS137PQq8SbhAETb2l425o1K6OtHoX9oqLrHfRGMrDy8NLWrf6V0L+CyHHRFwBAWZKv6rStC/FxzZWM/ro/fBg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by PA4PR04MB9461.eurprd04.prod.outlook.com (2603:10a6:102:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Fri, 21 Jun
 2024 06:44:08 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 06:44:08 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v2 1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
Date: Fri, 21 Jun 2024 12:13:42 +0530
Message-Id: <20240621064342.33664-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240621064342.33664-1-sarveshwar.bajaj@nxp.com>
References: <20240621064342.33664-1-sarveshwar.bajaj@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0015.apcprd04.prod.outlook.com
 (2603:1096:4:197::21) To AS1PR04MB9630.eurprd04.prod.outlook.com
 (2603:10a6:20b:475::16)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9630:EE_|PA4PR04MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e64213b-2584-4e29-7ef5-08dc91bd8d4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0DVq6V08O2OPvZm83980wld3KTMn2KLhax2HiFmrN983CjgSm1KpVVqHNYFA?=
 =?us-ascii?Q?rk094MsQ2R2mio5gfL70nm6RQyYaGhAlDCnayFUzf+Agnu7HbJ7iBLRanh6I?=
 =?us-ascii?Q?6KYYFkBj2YMPGHbXbgrmLG0XmatC9U2iDd7cDmjf0S/FNlvX/0yLRzaL3Zrd?=
 =?us-ascii?Q?4lc2hquOvBj5IVAzjIfOUgnFxagBfJF714czdG/opgO7WKej34+JEi/nPWz0?=
 =?us-ascii?Q?YXvOVOyKIMnkUCtRHyNJbWoCIjqCWcdrd3H3l84szEbuPUGAJ1dH2MsL3lzH?=
 =?us-ascii?Q?OXfedzAUgW6sm+HMdQvx3E0n+/9024e1sbaTZnlI6gse+nSC+ChIu4IEYRLz?=
 =?us-ascii?Q?uFGnpyDRZcad6Brv5TFSfFZz3O9IJDWwQgQ6m48p2+HS/2JsAhI/xRWck9c9?=
 =?us-ascii?Q?H0K1QCxWcgTH1TVjDVr3tSBvBLwLFEkROnkNo8iMGPiSmHminhSmd231jQ/w?=
 =?us-ascii?Q?wPxiw4GxRjpe1jt1MDstFjeXZv0loGWcuOHNwXmejzHw+kN/RRG23/wKUVKG?=
 =?us-ascii?Q?5Y26q2cr5ZLTt8lpdwe9WpGdk4jLS/Fko/uZxN3EXC7GhxM6WPG5zqgZ+yMX?=
 =?us-ascii?Q?IIEhtKt5faz6BpydkmaQ8S7QLDYYWr/b88PJqe++CPZapfcZpNqbGtee6KDB?=
 =?us-ascii?Q?4m3mKTqGK0E+z9YgT3hFEH1f82dTgRJlrMkdFjvmjMdDSken8MbyyONds8os?=
 =?us-ascii?Q?uv/jVja9+PjZtp+bmgFS0KOuFQyYpb8F/AnspelxiP+BeU4uyDgtZm5bjuO9?=
 =?us-ascii?Q?9SY0ckvLh3+kVQfDxYyzhRcvgsZ6/1J2+txjMdIXSdbAuXyh0HcTUbIWXUOb?=
 =?us-ascii?Q?dOAdj6Zdge0CDN4aLzIq0XzB8fgXA6DYTJqvOtB9zLjq8o0sgiD5PjoMLe6k?=
 =?us-ascii?Q?rNBrV6R/v7pFC5JSwRKdngwukmhtyEMGqgv1WzBxycMetjB6vwHpbDT+r5lh?=
 =?us-ascii?Q?YrbQbI9G2747Kw8U+KMlBm4WHKBND7T5H3c9y4oze971pdUFJuv/YvENtBvq?=
 =?us-ascii?Q?V0yqHNYeXTqB3ShWYvxXPtTb+GVHqZ6XkxRMh/IqOxp3XCwlNRK0WdF+BB2H?=
 =?us-ascii?Q?Krlx+VTEihLNj8QaHkd/WGBQQvT+f3Tl6+D0+1rUOXmGw4HEZJapRcWqCnyD?=
 =?us-ascii?Q?XCCq5cOpjQCnPc+qIRje67UjCjSzPtuwhxlSc5AcfH5o2bXeW2RJgDVo/fAa?=
 =?us-ascii?Q?aZSv4lqFguYERQ9pUear9IRFkYgBf3TwlIIhxyn4Nl0JnWUfkYHC8Ja5ehcV?=
 =?us-ascii?Q?BeLhGqEO0DF1WOoV0tMXsUCLJvi9Mx1rdkWIXGJb/CCdYpjFZfTV8xXpZemk?=
 =?us-ascii?Q?MrY0UJu8EpN59juvsSF7HevxPlAurbx/Dn2F+8hhAMQBiqvwlFgf4b8lUEIM?=
 =?us-ascii?Q?lgL1Wyc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wCxl0ql7kn3KI5Oee8rl4YoRfAHCkpAulB1zCBtNZhfsOJ2JmbmIOQepP2xd?=
 =?us-ascii?Q?HOtThckcRpgddW1I/+7YdjWkXucwdsDIFqlzeRl/0+Y/LVSJNJdONjx1S0hi?=
 =?us-ascii?Q?dR4qxLc0MtMSA6wRaV5embbR6Quc1yUOUzKzkH5W0Py9JLOvAS7YSGFjDCmL?=
 =?us-ascii?Q?6SMMyD4+CIDsQTc5WcdfTfOocVGL6w3AREZkYRCWNRBxZE9XxadIutiYDV8E?=
 =?us-ascii?Q?Jh3JgGz8MVS9VUqismCbY9McgzZvTVN5HpiOwY2OSaT1wWIqGnLZjaQvyPa7?=
 =?us-ascii?Q?U72VdsccWspt/PscO5FiEhJ78l1RipQ6udeBz2sTTtL/aQ7M82sN+eQe0DMM?=
 =?us-ascii?Q?1c0Fx2Y2bvVHRrl7YlD3Q7pb4RXT1jZ9GlyAIPtkTgVY/Km3qo3pBkhQk2TC?=
 =?us-ascii?Q?teAbF7ssGfr8QO2Z4Q+Sy2hl6/0M+Nr0BBSD3umSBjogDOKXMYXdgkggliQi?=
 =?us-ascii?Q?Mw23aMECORWYxDZvpGf8NY0qarg0Fr3T40xIpQdM7y/Ej49YNkL2k6HO7WyK?=
 =?us-ascii?Q?pTjDJh2hEMx5E0q1ke9NXyYoHPa441bg8wdGk9xVZrciVRxYc1AnZrTepdcG?=
 =?us-ascii?Q?JfkLs0Pj6z9UB/br7+dMR6xd4mi0ucdienqsrEfIhhpljO5latXYeIgoWcix?=
 =?us-ascii?Q?MQkdKMjfUnwnaM/4Qt1tit04+cEEERnyycMSbK3jqCQOZI54PZTIZrsZAOvM?=
 =?us-ascii?Q?gaCD7XH40prrwk9DzfxoYzoRM9LHlohxvU1vod8UztkD3sk7aLVToGg3zEZs?=
 =?us-ascii?Q?vCxmqEWKo4FK1Nm6rgedL1OGYz5v1JuwVrj8Y0o6vF0RYOL91OjxfEI8HmHN?=
 =?us-ascii?Q?QzV1l1+I7SoMAePXHxvQhUt+YpxT7/RVwgH1C0p/m9zTmHIiiHyKH3aSmgwm?=
 =?us-ascii?Q?C3Z2OI3U8ygTAej05r7jnfrU+Ba7UygrwOOJjpO1Vlxck1FCjOY8qOJ4JV8S?=
 =?us-ascii?Q?BnDzusihxrX3oKnNInZtdSgIqGhQX5SbiG+WHQ4XDT+VyzZPXLgSi8e4VDPK?=
 =?us-ascii?Q?viJxR2hYVk1PSGRIjhIYftOZ2SRa0JANOr0VZ3MN+3zlycXkTK5s78yDuloo?=
 =?us-ascii?Q?lbNLyvYX5HMe+W00Dm9O7O4PILCzNFSPOc/3G9+fvjZAVB2OzEjlsFnKusqS?=
 =?us-ascii?Q?+r7Upvorllo/7kt4bP1/OExeJu+8lCh/WtQvtHGyPQRQDhXmVfk5/qb6Hi5n?=
 =?us-ascii?Q?t8Sk+3PthY9ydFhVhcRcNOWwWxpcvAtpbGpIznEjZsvY+57jYN22+FfV3Qme?=
 =?us-ascii?Q?EeMGCpsaVA3hg2uS+F8w4zc9KvFuryQAauN1WrMpgpCyUF/4dSEEPMaY4tfL?=
 =?us-ascii?Q?WPwIfPGHTlONWee4MNeEWUC538SXLiur2mrUaEXkfPGVpBillUiC0vx4GDA4?=
 =?us-ascii?Q?928o4pLLgKxqMqJA+Yx2m4HLyHo66nO1s7V5zLuulk8rkMTuUBhsHrbSN4nq?=
 =?us-ascii?Q?+KZQyDiVS/uFoU/N/jcnNQTOATyc/7nf76I3tC8TQtfcO70FmEaCpmUlwkre?=
 =?us-ascii?Q?1s2HhIxRTO7lb9SM8IZgPFwh8o5JoKq4aWivFQAUwSYWpOfI3Jnrzva6MRbc?=
 =?us-ascii?Q?sd/UzNSvg5S1sUgffaIE1SOBGcnED1TP9qKwAUxKL5ujVjNc7NcTzb+npogT?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e64213b-2584-4e29-7ef5-08dc91bd8d4b
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 06:44:08.8975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0LUwXxIkKLlcJRfI7JLK7FDYrs0RqxG70yKw9JEB6ROQQr5zUYesKi56IE+LRkuD2Jbql3DEc1oU/XpsV8clJhKlZeA/VqNFfmm0k/eGtk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9461

In the existing code, iov.iov_base is initialized with (void *) data,assuming
data is always valid. However, if "data" happens to be NULL,dereferencing
iov.iov_base in util_iov_pull_u8(&iov, &l) leading to segmentation fault.

To address this issue added explicit checks for data at the beginning of the
function to ensure its not NULL before proceeding with any operations.

The following log was captured while running Broadcast Sink setup:

==79178==ERROR: AddressSanitizer: SEGV on unknown address 0x000000000000
(pc 0x5631fc6550b1 bp 0x7ffedd247450 sp 0x7ffedd2473a0 T0)
==79178==The signal is caused by a READ memory access.
==79178==Hint: address points to the zero page.
    #0 0x5631fc6550b1 in get_u8 src/shared/util.h:206
    #1 0x5631fc6550b1 in util_iov_pull_u8 src/shared/util.c:680
    #2 0x5631fc6552f7 in util_ltv_foreach src/shared/util.c:194
    #3 0x5631fc4b57eb in parse_base profiles/audio/bap.c:1189
    #4 0x5631fc4b57eb in iso_pa_sync_confirm_cb profiles/audio/bap.c:1253
    #5 0x5631fc4d5990 in server_cb btio/btio.c:265
    #6 0x5631fc4d5990 in server_cb btio/btio.c:242
    #7 0x71d33511bc43 in g_main_context_dispatch
    (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
    #8 0x71d3351712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
    #9 0x71d33511b2b2 in g_main_loop_run
    (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
    #10 0x5631fc738ea8 in mainloop_run src/shared/mainloop-glib.c:66
    #11 0x5631fc7397b6 in mainloop_run_with_signal
    src/shared/mainloop-notify.c:189
    #12 0x5631fc355c3a in main src/main.c:1467
    #13 0x71d334429d8f in __libc_start_call_main
    ../sysdeps/nptl/libc_start_call_main.h:58
    #14 0x71d334429e3f in __libc_start_main_impl ../csu/libc-start.c:392
---
 src/shared/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/util.c b/src/shared/util.c
index 30f054a5e..6e7634ad1 100644
--- a/src/shared/util.c
+++ b/src/shared/util.c
@@ -182,7 +182,7 @@ bool util_ltv_foreach(const uint8_t *data, uint8_t len, uint8_t *type,
 	struct iovec iov;
 	int i;
 
-	if (!func)
+	if (!func || !data)
 		return false;
 
 	iov.iov_base = (void *) data;
-- 
2.21.0.windows.1

