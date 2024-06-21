Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB6AFBF3
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Jun 2024 05:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718948070; cv=fail; b=VSqRpg1Mcu1ooBETbCfRPvQZH/juQVkXOe/htPkdxcXC3WgoAGblJZxktbm5nm4Q10juIkmSSdPkTpLtdQAKY2ul2OgMbQialzkUSphzhKN0swXGC+J4sN5vcV0t3ahvARHWZSq7rt7mJ/VjZtVLzH3teE8fSGpxk8xkDxCBoGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718948070; c=relaxed/simple;
	bh=1jZjxlyJt8nNuRqVpMsn712JLuL+dGYdgpWOA1qLfZU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aJtXFqGDaSh+/zof2L4o9aCtEJIWinYdyYBdBm26ZU8+/JtsF2IbZPXMKxvjIli20d/x44eYGjWVO1PBBeJq6vqHyEHEaluRhS45Hv6swhF22IrFMVUwYGOtQfILy2wcr/kgj88KBQH0uTuMgCg16Y6eI3Dn8HdZK/Lv2bmfoag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=gbyPmu5O; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="gbyPmu5O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P551h7N/K02v/SaioNNYkvrkU6wgvkcI2OIAz0mr34PoykeAIU7xlitTgao+Sn0OGMtq4bUGdd8reOqzcGe+kn05yb43SUTFWNwAtWUTZVTiwgfg7daPHO/EB/oetWNYl6xrO8T6K2l3SbQzwVNkFzMnSz1bUF06i/l2pQjkzwGUwT83FtDbOVqWnCDUbvjMUDWbFdnTET8JlTjrVl/Tj71I7ifWbpVdZ/x0Q8BiminaLZxQ48FWAYJ04j6Ml5v3EoI/YpsoG9RcnP/HHp/s+Rt21lRHqpjoYDH6nR6Qrrxvpyn6lHU3DDS6ggmB6/fY9pdg5Rt8UHzIJi+mB0BDpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynShA9fzGrP+uXVKN8iy4CF08fMfLAlHHjwlSPAU3T8=;
 b=Swkmq4G2deoabcBtq8j8pQ22b+wAcIDetJqQA1j+yzmvpzR7QV0StZJ3oT0/OmDb25CnKH11EQ5lrvNuxcaq3j13dZCzhXiujiu+krXr1yxfP/KBidDObPuZGAJXgubU3yXsVhmJvsIceDewoJlUoNeO4ezM4AwA8j2hvl00Tq/2a6WN1ZS735pfjTNuw5kcaFinFUCjB+WKrv0AsopyWWUkVs8ovIMxCREhqAhzM0UVxCktaBCMkFJtoZl/bQj/zzad+pi3rPzDoUv0MNlLjFRUZT86FK8VIHqYvDfXK7NeqLbpIJ0C0ioGWeROPCsB2RS2DPzCd8kpzRAi6t94Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynShA9fzGrP+uXVKN8iy4CF08fMfLAlHHjwlSPAU3T8=;
 b=gbyPmu5O35iRHABpSbLC4sHzdPkYiH5GVIsmS62UZWYhBreTdhAnf6N5UYEG2V5ph7f6/KQuFyTJPtdB86rSLnfgNyrGtS4wUkd6Aq4cU/Lp0yVEM7+ZgatQOxW4k3Bw5p/JpY05cOpR+ppLhs88pwRhajCfbLRtrpVFnhEph2k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by AS8PR04MB7749.eurprd04.prod.outlook.com (2603:10a6:20b:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 05:34:25 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::b627:61b5:39c1:91c0%5]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:34:25 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.von.dentz@intel.com,
	vinit.mehta@nxp.com,
	mahesh.talewad@nxp.com,
	devyani.godbole@nxp.com
Subject: [PATCH BlueZ v1 1/1] shared/util: Fix null pointer dereference in util_ltv_foreach()
Date: Fri, 21 Jun 2024 11:04:04 +0530
Message-Id: <20240621053404.13984-2-sarveshwar.bajaj@nxp.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20240621053404.13984-1-sarveshwar.bajaj@nxp.com>
References: <20240621053404.13984-1-sarveshwar.bajaj@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 918dad9c-0203-47be-5794-08dc91b3d00e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|52116011|376011|1800799021|366013|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MBboinabt8NOtlr4EtxEmZO+Uva/nnQYJnuRb80+HLGzE+P3B+cou78fhark?=
 =?us-ascii?Q?8BI3VhW+wD1Jt1udUGmQfveTOFD3zLney7YiIH49WH5Xf22Pa/FUHKjnaTSS?=
 =?us-ascii?Q?rX5qU/Dc/hZu9IfbhFh0HSg+YMwYNU0iOe5zzk8wO97iZyawQwIO3eH/ec5X?=
 =?us-ascii?Q?Rd/5kyO+UC5FFbR+UicT8VXXbCKMh9LpKijbm7fQmWG+Qj7EIuxZtGS0QosV?=
 =?us-ascii?Q?Bera0UQc542Nj88NCAIblr96ZkeOzRxZe4Vd40M9HH18opzUhst/2sF9umv9?=
 =?us-ascii?Q?91xhLwtD099Av7YfeTuaJzf8G5y5NRBTxdv5u16X5RSDdXe+zSJdzrtCtzGn?=
 =?us-ascii?Q?0M5V/gCSI6us+f//SD4DVE6DHvs6LjHUZkpDuA8kirbLxGexRuE79PEHy0AE?=
 =?us-ascii?Q?GNrvgt5Re+AbrUxiP3sSMuHn6oMpBTMkraxZiphwjr8Pc78u/M1wZDbDH1gv?=
 =?us-ascii?Q?bbORRsiBCJpF59ulHscYcHCsWjBPZbBVu85D2NcdROdMED68DWLGLbU3MTK4?=
 =?us-ascii?Q?3/J62Pi/0RezS6+c8AVBS/mXpt86LHWn1nmlETa5L1G4zX4Ea3uwVnnCQwwn?=
 =?us-ascii?Q?dCoDLzHDCfmSMf2L1YThuzIkqO2IHI+YPrg9KRsxXA08xSf5wOsXVMjQ1oTk?=
 =?us-ascii?Q?05FIlzY2cLWFChnTXJA2o/0ieriHw/uVVfBDRSfpZTpczgUwv4jfHnOtO7UY?=
 =?us-ascii?Q?8b3EvgICM8tOdEtqj5k3Pe3ECFOeSUIu0OHQ3L5YxaCEBWHuIW5ECVSTLNnv?=
 =?us-ascii?Q?SOby5p2HVNfSIjwUJS6WUAhafpV9PcZN8yI/a66Mp8U1To2dBqB2xhLPip3x?=
 =?us-ascii?Q?/WdE0qYLExzZOwEF//WaMJJnWLLBujZXQ+DkmD2UrApbufd7oXgZ0d/X/f26?=
 =?us-ascii?Q?1Q2fY4j1uwihDPgrDl+8sTGKVBMTSPF/0zeE1tXnVnf7m4x9/7OLx5i9rkfh?=
 =?us-ascii?Q?/IjLdD4TBFecYlg93g13FAk4gx+47+cmK9QINcG92id6/0ohqkkY+HpxdPc8?=
 =?us-ascii?Q?wZT3DeSrnIbNlCbGOT/OT/Eu+tzWBticyXldTJMOyaWHbhxgoEoAm9oBql3M?=
 =?us-ascii?Q?rYhIy2PmMlvrvtnOWLA2z2nYH1Eigoki84AxA5KkyaJ+6+ITgJ3hBaWO3ftg?=
 =?us-ascii?Q?ZtGnw+uJB84b8sIgwUTzihPRqZPLo7pCdGflQewKvv5M+dc6UCYv7zuG5AdU?=
 =?us-ascii?Q?ZrUMQ/QLaqfnym1kOJqgSHzpW85POLLpmdWiUCzwiqXzRxSB8amlFKmbB0eM?=
 =?us-ascii?Q?MqFOuqABKdDUhd6E6rE0+c0HNDjVBaF4zeV/zE2iUCgIr8ss8xPFJkUfPvtQ?=
 =?us-ascii?Q?5z9jKFM036TnCdwic6n9bpPQoica7uNRWnyctDgaTMN5U3bGCzy9s0PJYdPx?=
 =?us-ascii?Q?tOgwEYM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(1800799021)(366013)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q/AYt+9uy3wRfEhT/UW9W6mJu/uc8XHbZ+xGzb8nLwbIWMVHKp+ojlLhN2xq?=
 =?us-ascii?Q?GC7//neaicZxN+fG1CBkn9Wkb3ZKOo2PSMOkxyp++BELcz/GKbnC2qb5eOha?=
 =?us-ascii?Q?AWSMFK9/c0b6D+3ZTpazBNFKMtIZPekAm0+zf46amvDLgmnkAdw/jtE48KBE?=
 =?us-ascii?Q?2XMFstbUAz+/bMPztlQhVN8lICjkYVRADAQVcst+rorh7sO7JQ2lXUB8Uik1?=
 =?us-ascii?Q?09VlI5Ey1J3YOYavuLuUOZKLSfGzSAOdKsVzTWQZz2krYvLm2+n+VVHPEAhG?=
 =?us-ascii?Q?VI+aUTUusESOng8ihVZAt8JNuI8MXl5j5EKQMWC+Z1epyyM1SQV8A4AQdXwF?=
 =?us-ascii?Q?tJoklFWFB8PqZk7KDa6GjKGo7SNjr6DYfocGsRMbSjufpB1dgJcNFjRSXEZn?=
 =?us-ascii?Q?XdIv+6cu0ywpaSh0HceuA22Ay9q/dNSUyCpfn11LM1YCgym/XiwmTfAFfly7?=
 =?us-ascii?Q?s1tT2cQQ0ma+6Bdag+eQsTFTRjwplHovCij4+jEQ3MjOsR7mb2Cib8odfNHZ?=
 =?us-ascii?Q?k5mKT0bgJ0w1k6zeHK/GoOm/4DjzsGpReKhezzjtZOu7mGTnH1jhhOuX2MES?=
 =?us-ascii?Q?3Hml4qAKASG/Lrg7btfbZNqgTSb9+TMlvYM4NMYMLnqf9rESdiPfhPDCkMk0?=
 =?us-ascii?Q?BovBZYh0xUgTkvzvoCKq+CZ1K//vJI9KterqarXQq3YqWcMXKW7BLSliEOFn?=
 =?us-ascii?Q?vj5n+2gU7SoGKsvKxWu7+DMvLyCcQgeGZvd3q72cQiWSpbyJnRAY8uSSQUrF?=
 =?us-ascii?Q?IBgMpqnv5wuc0SMSUV4s2CxhBewGQz5xpTrq1v/D901vKKjQiZOncu/WOETC?=
 =?us-ascii?Q?h7i64LEXJCv3L0KaxyDH3466oEjVv8Y4v/0yXW4EEwNly0+1BA7XrcKDGrX3?=
 =?us-ascii?Q?exB6q5WQZTQqEoSVX3E7qV4WJ7Z5wOtyL4M6zxeRdRvDvIyrgKsYL3Rvufo1?=
 =?us-ascii?Q?+jxeMjmlL6GcxWIIjWjk9w7Ft0e+fWorItIVggyM5CUqOyATqT1n6Tduldqk?=
 =?us-ascii?Q?ZQgvpu/WGSN/T6k6ZS5l8Ft/XUtQ70cvlTZlohyPBRcwX3IhWZALV7Z3JsGI?=
 =?us-ascii?Q?gopkNjKf065kU43BXqydnLkjFrk7o2mnm5y/JeguIfx1Dpz8vWbY0Mx3J0O+?=
 =?us-ascii?Q?a1+LJynbMAtQD0iT6tApTNYT9zzxni/TUiyVhgFPOAt9+MLJTkfF8RUvh+jl?=
 =?us-ascii?Q?TtHtIOvvfyqDTuaPssK28I0p+gXEE6zT7QlTgUo5CW9IFsGbrpWWD9+5jm7e?=
 =?us-ascii?Q?2Ula5U7IpEcgXKBhokQJc24YOu6OiaN8C/OHodSaUpnBT92gW3+3sM37kLyt?=
 =?us-ascii?Q?BaDI380Z339lMerwczgHbhddUCcicCazUHluybDeVrGcbwc7ahcJ9Z97SSy9?=
 =?us-ascii?Q?A68oN8XRMaPko8zyTo/6+jma7FZyzyWqQjekuztT2+sAJVMQlL5LkrJm4xxy?=
 =?us-ascii?Q?tmdKHk092r2wGm1Q/fCjb7GYJ6QMG2Jt2Q5h51yO8fl41QPfzWARC0R6SyQe?=
 =?us-ascii?Q?Luaru6v0ZqSXcO/Gbih1bCMNrrQoiyv68wl2rkS8CtcFaGNCvRFgHgzvpcTE?=
 =?us-ascii?Q?d5ZsPBLzPA5PFJOb6nUmZEPVql/1BgfpEQiB7SHij1CJ53T/xa8/eZbTPj6T?=
 =?us-ascii?Q?hw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918dad9c-0203-47be-5794-08dc91b3d00e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:34:25.8302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YuxiOJ9g44fv/x1qqGF+yTQls9xPXudMidBJr80E/VH7GVRBFOb2d4OZbgn94TXGXsKDETlFOpkpVTzlb3CJHVW8pD95vXDybjK6nV0kRLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7749

In the existing code, iov.iov_base is initialized with (void *) data,
assuming data is always valid. However, if "data" happens to be NULL,
dereferencing iov.iov_base in util_iov_pull_u8(&iov, &l) leading to
segmentation fault.

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
    #7 0x71d33511bc43 in g_main_context_dispatch (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x55c43)
    #8 0x71d3351712b7  (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0xab2b7)
    #9 0x71d33511b2b2 in g_main_loop_run (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x552b2)
    #10 0x5631fc738ea8 in mainloop_run src/shared/mainloop-glib.c:66
    #11 0x5631fc7397b6 in mainloop_run_with_signal src/shared/mainloop-notify.c:189
    #12 0x5631fc355c3a in main src/main.c:1467
    #13 0x71d334429d8f in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
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

