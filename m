Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA969C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Apr 2022 16:44:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355924AbiDOQqi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Apr 2022 12:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355916AbiDOQqf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Apr 2022 12:46:35 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-oln040092074063.outbound.protection.outlook.com [40.92.74.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC63DCE21
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Apr 2022 09:44:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EH8g7TKbpQzkwPJFL3OtS4ZYwSRU0gjgf23NhXEc9iLcY/ZOoKuQtlebP77f6vXPLBOfhzWVuER0qIWAOoAvXSpyXQ4s4+GX2RfmWfZ7RZzMEScGlSt3VG3BPZN6Thj2pNJIFW4nreNZxBcijWqMcSgLOYRX1VIpzJseMv+PAk7WJ7p4hVF/F466wjyyN/o6qP68I7zzqe8HVKvkVfiJX+E571jyao4E0JEGdrrvov6bjWz1VZSSPANLAlgeDeA3eIpAaJIo97J2+EFE9tsDv/qsKyIfq4NLjl0HVzOi7ErPz+QL+oft7G3e1Yl8Tl7UPGNd3TtXOxR7sV7nMzbLSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9l2x6iNzwxrKvaY7rqNsjt/pw5D+s+cfYK5WHfIwNc=;
 b=j3Uxipg9KNum229zWiIc+nUs2UHHIiq52MuAEstJ/Bky7IAX/LbSqEN81Wt3ILlIURQSzKdeGWn7T1SJGS3lLadwFyA2CFn2MrYuz2Azipgslm0+CGLN4e8FN4l7cmrh9OlFOb82FRNDvHUHZ8nPIJ2MajknbDU5JDBD1E5Hm4k0fDwiF1YLcSH8rGrV4eXg0z0Dt5WGL3K70YY+lqfo9Q8eOJQoLT/IC0bXWbCMxi5NKtAo2iEF0UORzmuV42quQxebuolxv7A4GJKw0hU6ZE0hLZZqasaPmXLWMRpDPSzLR5/i3id2P2G+UrQBoiDt26SgpIQ05cWaB6G7Jzq2jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9l2x6iNzwxrKvaY7rqNsjt/pw5D+s+cfYK5WHfIwNc=;
 b=iyrLxmqoWSLNvp0uYNUkRhVYCXhyAGO3l1yBE1jh56oRqehNumw/84xWhRZjWww/vRmnS25EhoMYInmGxDsRRp9NMi21TZqaXKVw1RXkGFWNbkuX0Fw7bzTFOyDc37yWP7Lai8u00ZG/Pm5fOT1gLIHwbSLDe4OgdSi7xoj470HEL77lWTPdQyMC+vUnFZWgeAYbEbJnPT7tJbnlmuTljVJUBteMGxDghTiQk4P/429wVVeVCnHsNDArn8+4tRydHP2C/wZjyv15/7lWn2NOTjoA9llXE7pbqLjHixlXfcIgDfAdcg37yoMtX8G5flAH15Tknnb07IF995z8+F1y1Q==
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com (2603:10a6:800:12f::23)
 by DBBPR09MB3029.eurprd09.prod.outlook.com (2603:10a6:10:f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Fri, 15 Apr
 2022 16:44:03 +0000
Received: from VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::dcb2:a4a2:335a:98ec]) by VI1PR09MB4239.eurprd09.prod.outlook.com
 ([fe80::dcb2:a4a2:335a:98ec%3]) with mapi id 15.20.5164.020; Fri, 15 Apr 2022
 16:44:03 +0000
From:   Isak Westin <isak.westin@hotmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Isak Westin <isak.westin@hotmail.com>
Subject: [PATCH BlueZ 1/1] mesh: Use correct net_id for received CTL messages
Date:   Fri, 15 Apr 2022 18:43:35 +0200
Message-ID: <VI1PR09MB4239579EE5A795C707FBE075E3EE9@VI1PR09MB4239.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220415164335.24808-1-isak.westin@hotmail.com>
References: <20220415164335.24808-1-isak.westin@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [GKRZWpYf7D8LxUh1BkKQ51NYWC5OD2eM]
X-ClientProxiedBy: ZR0P278CA0135.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::14) To VI1PR09MB4239.eurprd09.prod.outlook.com
 (2603:10a6:800:12f::23)
X-Microsoft-Original-Message-ID: <20220415164335.24808-2-isak.westin@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2f6a953f-18ab-4b1a-0dd2-08da1eff2624
X-MS-Exchange-SLBlob-MailProps: +LiGfBxqLEsiTQR6L2uA9gg60dIKieXwQ2CO+dSPIjhQim+Tk143QYFuLIBrDGJrKFaHtu2br+kO4Mhwf6vf5P4yUz/MLMm4AnBcDR4weOVI46+1FJEfOAG+w6JcnBer8X2YwEds5LripEvA0Szr9lyFbjqk/9NYEMOo6kj3nyTrKyXejifiiAF5To2xOz5LhpoX0MAVaV3yWzEkoeyTCU3jaVxrQdMwgMBXxK7t6eS4IzZlIJlGQGSpyjEMK5utG0xdB+CvrwgnQRNq7qsyWtJ6gVXdHVaF7CqPKydeLkfi4d1IVWnKBDlPi0Qqf2KZDYrWDmqzQ+6b5O7YtODSEOCzxhxPGwAPzSfSDsrtHU53mJGNV8EeGst7YXtCYdC4aDi62+nwx8q59c45vOdLedP+ARn3Qhj51wvCMFlkeeCl6TipTI6DhSzH7UNhLhuRY9+4ZZpJ2NaTYTjl4z0COgr7qP3370NtymozqvGqKjHgg4Cj02mHmAic4VY8yR3YasmgOwbJNqzrmPanFytw+psnJhtw+qU2dAA04jfjJlkgo3ANiwZygOnPcVJXdfpAGl2De27shzDN4w30uANONQGnOgVRLDfPeUbZdcyLob62I5OhzDCMv2yprrUySw7ARwteZpD1XauyEGgAg+cuGjnt4XzqPXjBOABAY+1//WUU3O9G1+qxy8J/pP2Tgacsqlw7Hz6JiO7PeJ7NwnkOmN64UO+vKSJkhdtq3W/FfFXmvoOeh22WQDbsI8tDT/8D9VCr3axbRz2ZSVcWvdX4I9EFOmp7pTHT
X-MS-TrafficTypeDiagnostic: DBBPR09MB3029:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LHvTkwJ7fVSTlaZVFF/uWvsNnX1P/uQBPRFJsoHaFpZx0rgSzY8N7f1eYQUOcz66cDKs26WEBPkjSFcLQOO3Fa/MMsnxX+6FAvS+V6gi3NchuqyopEvLZnwOEh9rAVP8H2fYV4N6a6JFiYaTfjWghgPgMsCTUT/Xy2ZPDti4i6K8N3cfrk46xb1ssQBTzFKC6iPuSc5iAMk8POLEdD5FAMhRy3nNjfJZk8gfbNwlDzzb2v+XpcXtX6tjmRQfQUBgZB71GwFHmR95JgH5+NfoLlkdaVIbJRsC+VTWz1OYR/1rnCXm+EYKK6Ht/C0W8YrgsD1a5WjVrbJnw1LxfbB7OXD+9x+50CKCUL8xI4JO4XnLZhhZVxE7fbip2ZEafp6tEHKfVbPuVIR0sdOfI1dha59teUfoPWEJGaz5k0Lv3mAgNTuQVjBxYo9dmRWE2mBXYVhe3rpTQxywU2wqBHBUS1Z/ijE9MSuj3/GhgZTEbu30TgSTkijrnO8tnmPT0k6+HYMKT6PLMx5YVqPGPGyOTZnB9K1TVX/T3fpVf6JOE6BS7UzIUxicXZtv/ppfRhe0rwSPrp7N5zFfCiiFxAXV2A==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?re9/EZa8heHvhkLtPIRze9tgvWpvBM5RoQPXWLqduTDVfhcrevrx41HbkQGJ?=
 =?us-ascii?Q?43+JBrjKQQGAVEfC+OZeAgyT93w5mQc2hqPmrfGZfosS0OYDP4tLEatll2ad?=
 =?us-ascii?Q?trCfcg+SfVAVs5KaLy6CV9A95ijQQ+Z3Nc/RJJ7BCvdKYoPS00n22tpEX+Qi?=
 =?us-ascii?Q?HOyYkyjDLB4brTEHob349ipG7uTZNsNmcDwG5qam51cQvBohCs5vXYTfXb7i?=
 =?us-ascii?Q?yU9Dv5PAaDvvz0DMGaBs9UamUQPa9OQhga4VOSRTh5i05vGD0yAg4O2dsQ8q?=
 =?us-ascii?Q?7+jY8ek5SSDne9lHA/gWfC0LMtskl/WuSHoxEXU+ZsXM5qTD2uRLyqEuXtHc?=
 =?us-ascii?Q?nef7xgzlzUFTyQwLK1nNMT7spuQfFaxnwyDaUtStyhxmTtlb49zfQJZUxBn2?=
 =?us-ascii?Q?CkYUCBdahvyJt01dYQHPJjjzO0C9jP5iWYnQjX+PehmayoDngCxnUrpFhLwC?=
 =?us-ascii?Q?rG9fr66DjS0e3noSXE+F9UEs55OgWN37hAt+iABRUlEhuQk72x1/FIabaC3p?=
 =?us-ascii?Q?4rHFe6Ui+VEi5/Whq4NHL7OiZ9LqHK02lN8vgijxgcC2UmoLfxPGvqnlRhgx?=
 =?us-ascii?Q?BcvaixIl7onfBHIGn8X+dS3Dq89dwe9za2zHS3yADT9LLhhLfyA7uSOlzQRk?=
 =?us-ascii?Q?fY7/n/+YvVFBIgDbGTGffBF7ewEbx7OXFpWmiokpeqYo1hFON8sft9QkV2P6?=
 =?us-ascii?Q?18xponabtWW/tOTj21y+5tKItr/Y+zFFixAT0ggJmCjNbcDwdkcTsM/SiOpk?=
 =?us-ascii?Q?/PxxaEvVs8DlYHFW8vqFx7/UIGEbk3lhIthl8FDme2V5CliZe8joLqPomEcO?=
 =?us-ascii?Q?b3A2j6tdLmNTvmkJvC1Aubh+WALzX7ORd4Oyyfd8v8PoWdzklmSTz+1y+WdU?=
 =?us-ascii?Q?Lui9yAyIbz04iXZGF8qvLb/D0jFEJBen2ylq03AtAZaIvZ8+rhZLb9Yf/Mw6?=
 =?us-ascii?Q?ItdJjq1Sry1U5rRCLPXQonAesMVESrhdJGr1KOGzbZxnlccphJngYm0gEpvA?=
 =?us-ascii?Q?uWPEKnxRzFcrckJs12nh0QM2tn3QahGXV0cHY0/J4xm9u17StHY8BSVvkxsz?=
 =?us-ascii?Q?XNDqsOlBelmUPedQwSh2lf4h31L5vDvqOQ+6oAC09YVEisVT9vPO21MJgxcA?=
 =?us-ascii?Q?RH4ffLCOBC0nms+U1Hpgtbh/P9gtauo07ipf/Idr0qJhfWsu6F1OnDfygcvN?=
 =?us-ascii?Q?wtuEfH0oZ5yBESpczakZWAcGwUleHu3PA6ffyxHhXuuJ3jJnptBFsb9MxVtP?=
 =?us-ascii?Q?POr322j/KIw6/WOI9Pt2JYtjj8o2v95d+rLybwOCa9Iu94qn6H93wJGae4nd?=
 =?us-ascii?Q?uxpVLUFUu7FEEEOCBEPq+pIy5SzGj+GU+d4O3uIHplcnaeD0yk3Togk3/uBr?=
 =?us-ascii?Q?UuQzxAaNl2BXFNfYVnUe4YojbLYaktCnAaKjLvubSaNlW2x88GLyl1IIA9kj?=
 =?us-ascii?Q?q6T1hLqBAELZ9+g7/dfdB6LWTFIBNG73?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6a953f-18ab-4b1a-0dd2-08da1eff2624
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB4239.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2022 16:44:03.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR09MB3029
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

For received CTL mesh messages, the wrong network ID variable was
passed to ctl_received. This patch changes to the correct variable.

Also, changed type of net_key_id argument in ctl_received function
to be consistent wich the whole call chain.
---
 mesh/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mesh/net.c b/mesh/net.c
index 8ff3ef32e..e8e6d3a61 100644
--- a/mesh/net.c
+++ b/mesh/net.c
@@ -2028,7 +2028,7 @@ static bool seg_rxed(struct mesh_net *net, bool frnd, uint32_t iv_index,
 	return false;
 }
 
-static bool ctl_received(struct mesh_net *net, uint16_t net_key_id,
+static bool ctl_received(struct mesh_net *net, uint32_t net_key_id,
 						uint32_t iv_index, uint8_t ttl,
 						uint32_t seq,
 						uint16_t src, uint16_t dst,
@@ -2347,7 +2347,7 @@ static enum _relay_advice packet_received(void *user_data,
 							net_seqZero,
 							l_get_be32(msg + 3));
 			} else {
-				ctl_received(net, key_aid, iv_index, net_ttl,
+				ctl_received(net, net_key_id, iv_index, net_ttl,
 						net_seq, net_src, net_dst,
 						net_opcode, rssi, msg,
 								app_msg_len);
-- 
2.20.1

