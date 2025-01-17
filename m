Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013045.outbound.protection.outlook.com [40.107.162.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9F842AA6
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737122821; cv=fail; b=beoU/SEQBHci352BNzmEhS43B7pup2fLDEP7+mJgqJUVq0WydZqvdrUX0fsgRh3x4n7Zb2iuX4HZskSk58yg7H+sbhLUJDO08+jK176Z8IEmI4GqqlDJ5vDOkJqjIop2hQUi9n/SVontcpl/s5ZMatuzBoDWIgXjyUOKrU+uUv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737122821; c=relaxed/simple;
	bh=yLI/EnB83faayDZI4XTB90R+3krSh9ood25f6Vxb/Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dWptQ+OX/+xZoF6BYnY1R/Bjs60aSxKhMhk7QKALPkMNEfRdrFYmIezPbdeMnuRXlWLwHPC4V9viQKtY1fb/On0wRmpq2GOSfb34tNV2Kfi9uZDHjRUnh25j6MsAZkgPysNG475wsgkRBxZVc5VJTbore61CrhUkwlFZnBDeEOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=HdC92K5c; arc=fail smtp.client-ip=40.107.162.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="HdC92K5c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQiwmN65JY4C3hTNSZewqRUqeortv7UEccAT1hq3l3wrqh98Jmx3DUI4Q17t+P9z+xMNkcjyzFFgclhIIlGBGUPJLZ/GEFqAqHKWPIR6hwnm6s4ThDO2EEPXUDN8Meba+CWeo4HzW5L03lU6o4xG8lT6nkAG8qd7KIcm3ZrB2ni/sxRS5Lvj9WibPKu49wOZ9tHFSpxapk/83zKknG98rWkFP/209APvBxErzTHd4lBE7CWh6SpV301b9pOorgMhmE3U4nkJSgZKg+0aKv3JaCYvSdUSw5EzVl/UIJW2aD/BblQgbUEzWQjVGTxpuZtULdO53kncRRrWOf0PbXrwhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJjQAJyT6SIDopFjxSTSa/cAyI7tQPGHK97mL6TR9JQ=;
 b=Egoq4NoX10k0EN+fPRKKGKX0pacLYxdzOjND5p5gyZZLyZI1z7+NMMVwVKZfENQyvSMua0QEUZDI5ubRGtBEq4E+Vl7oVfIMsRCO8W5IR3un6L5U0ucoSoChbM3hqSwWK4CI7eiXCJ4Dnou88cYgsmCmPGnkANV/ko51k4HYMlDEeasxItkl7wVbaUzMcQj65yZX9cLd7/tupwIzMUSZD5t0A0KAuj4x190yiarzeDMia8zQpImi8TNTX1qx7JsKmjOQgo4EOIm+i9UGUHTkIRITAEIY49EsU3hkgUab5zRtcYHQhX9VcfntYJgVwci+OLSowpeP1Y/4PT8WgnWvxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJjQAJyT6SIDopFjxSTSa/cAyI7tQPGHK97mL6TR9JQ=;
 b=HdC92K5cTZqb4W1r4F/ELWoAMAE+E7wG8g+LPOPAsYfCF1HOCdMEleSHVCdBDd96kHdtjYIB2JHFoi/qYueFATJxCPwA59m5w1/geZBVNVHPMuAPMHNvOFELlUmA5e9ItU8r6u3UKWp5qSMdLp8ANFGV/Hef0X0otXxVE4frv/W58z3ZReHfuBqgvPFPBA6R4D7EXcaNHmQMByLrb2SQG0GL99UP32G3wq8YY1/PubO+KJcypGS7316GDrmCs/HDbB3bzDPJazVUbDp9DTzVzMSWZBVz9gWLv9BsBD4yC+VeyZE0synG9KDz/Muehxi2qh9h1eUL6dwtg8zkArMZ5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com (2603:10a6:102:20c::19)
 by GVXPR04MB10201.eurprd04.prod.outlook.com (2603:10a6:150:1b7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 14:06:56 +0000
Received: from PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30]) by PAXPR04MB8909.eurprd04.prod.outlook.com
 ([fe80::d39b:a5b:8f24:ae30%6]) with mapi id 15.20.8335.017; Fri, 17 Jan 2025
 14:06:55 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] btio: Set correct length for getsockopt
Date: Fri, 17 Jan 2025 16:06:31 +0200
Message-ID: <20250117140632.120501-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
References: <20250117140632.120501-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0004.eurprd03.prod.outlook.com
 (2603:10a6:205:2::17) To PAXPR04MB8909.eurprd04.prod.outlook.com
 (2603:10a6:102:20c::19)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8909:EE_|GVXPR04MB10201:EE_
X-MS-Office365-Filtering-Correlation-Id: 88879bb6-371c-464e-f5a7-08dd3700332d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9iXmedsZR2CZoy3bufSJsFpWzYYGJrTSkro4Z3UsnmDdHwawN7YdyvTG9+f5?=
 =?us-ascii?Q?wkMQMddI2yD8xXedy2m7dXMcLE7ggWRdroIfidASjvk2PskmCN5wgGWiSait?=
 =?us-ascii?Q?F0e7MSEj88iyd1wY7rWpv7S0WKD1uXBDYcm4anMWQfRM58bclumTnSBlfDsL?=
 =?us-ascii?Q?IBcnKmodkHxI/YxvCvUH9VNdOaWuHJrKHbYFDnU1X/fdwOePqL60wQUX/tVI?=
 =?us-ascii?Q?kdW7LsrxYKsMrYPrwm8BiSCuibBQl2yWus7Fn3ZONA/Km0qU6b+4ttGGyUYp?=
 =?us-ascii?Q?k1d8kklSzr+sEtvymaS/yKuLUCy3Pr8N4QKmEJxCizmzj2GE8XMzEpOPIHH0?=
 =?us-ascii?Q?3pQuG4/lXHcsGSmcTGNaSH9/2r+mBrZu7Pdqf60Rbsu4dLRS/QnWW69UK/9G?=
 =?us-ascii?Q?RXIGdOGjnsJXgX3YmVoPHvAzgDVwW3w1VXOH3e4yMpIJYMf985ePohthnQdB?=
 =?us-ascii?Q?rPmyIMEMBUUb1sXd1fBnKmj6gJI/4sBaxT2dw0IThhHOloP5rdR27qUspQpb?=
 =?us-ascii?Q?LiIEWCq7ZKOVrv4LITiczz3FkR8FKJWYyjAC9hHwmidPbuOEE/WuCUSdFBqs?=
 =?us-ascii?Q?kWeIexx08MPQE5DN3GNTrt+3I18F8PBWeytMPUmagVEw7/Jn2WxFdHbP0I2c?=
 =?us-ascii?Q?7VStsee85bnQ8Nueti2tngO2wzdanS9Lt3vvk1EhRFciLbGdMj8tL99s/w14?=
 =?us-ascii?Q?5N1b8sI50OfDVDvWCa6x5YCgjjsSVGMRNNtFo0ZyrHm7joEGgzjtjomP0+wE?=
 =?us-ascii?Q?kRfWAHjAnHIfAF6dMNFSVhIPuZqJruvJg6FDxvIG6C24PbhXBjWlYZQZF08t?=
 =?us-ascii?Q?vqTPfJx6nDKM7+ymVGE8hMvXdLZ1am99FfX+EF4KeatXY+/U41ABgutt+WmG?=
 =?us-ascii?Q?H9UTbhqljyhdPXM4PXXg3wnHAXd3IxbjlvWwEFNOUdy38784DYXjNHO8gfIQ?=
 =?us-ascii?Q?mc9C+R9pxglkggt+W58SKsMt5zXDBlh796pGpN76cne4+LPMkOMWhDCOOG5y?=
 =?us-ascii?Q?msTxhfpkAAqYFIS7cTvEzMdMFOQjqt8AWBbiRPQ0ID7NF5DrUYdUna4PYT2t?=
 =?us-ascii?Q?MAIybXB7btV+/NVk36JFKfWmBPTaddU4MHEqcdKzoOW3Ek9j7y5hGJpbGxFk?=
 =?us-ascii?Q?KSuFrQdWlu1+4OgTWdajaGTcmQVXiUwffKIU2TSTrBR2mz5cmPrrc8ZP3NU+?=
 =?us-ascii?Q?zKdNTSw3Q7IghRbF1QHTfkw7EXI+lvoDupCCyvZ4YoLn/mWTR/Kor+qKbiIz?=
 =?us-ascii?Q?FJQFoCiVqEeGWEx6lbJ8Hw07JdrXeLvH7Gf0B8CmtXQLsMZ7ijeF2V0aivRd?=
 =?us-ascii?Q?eL0vc4/wH5n9w4/XVfs3tVbDlVNXT972JadBXtHudQ/8HNzSXLu2ciRGsIRj?=
 =?us-ascii?Q?MdTgpMWrAE+iQUC7wtv6Oj1rchkh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8909.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WXPC+bpv7JmNAnVKFWn0EOc7wDU2ui/TedhIBv2ythebKpjTRh7KQc1POa4I?=
 =?us-ascii?Q?YHP8En2zZkAQETWDiPdgxJdzNnLxx5Yjf/CZBA1IdopkRBsbxicRJosRj7U6?=
 =?us-ascii?Q?rJx/hsX/oceajINyYqWSsEwDs8Azy2yc7E3MkGDo1TLEXNDn+uF1tYO2Ugoj?=
 =?us-ascii?Q?72ssWRPEn6YZMrM0vApZqcVUurCLaPAQ8Khqfv7Zg6QsYgf/NrNpGQKf6y0R?=
 =?us-ascii?Q?UbIZrtMN8JDZKwFE2VRtOV1FEGxAtI+RDP/brfZbrFzXpqqyRGs/s1LwpMMX?=
 =?us-ascii?Q?GIJuJKdiXr3l2PmGBbdZOb+6s4KOitEI8A0nebpcoNQXc1kmatFoeYzUempr?=
 =?us-ascii?Q?Q/ORlLirsvOWDHWZj8qQ6OK5QvihVLQlfJL3otVVDPC/HUoFkALMCXs9Wrd0?=
 =?us-ascii?Q?1yfAhtT4EeEafUBgJecGRZZkkI2LqXr95oquCrARlk/D/MPJdo7vnDxvoer8?=
 =?us-ascii?Q?TK8lufp/N556BDg7KWRd5gPRseU6njt8urWyD7nbCrud+cZaYGS6ZMD0NnTG?=
 =?us-ascii?Q?I4yjCumH5bru1q1HfxkvnBoVUWakavSo6gGYRhvk7MMnfVFEDj7ugjhyXvpL?=
 =?us-ascii?Q?U84STYUPaZIqZWisKrojx98cQ1cnPVSst6T3Ytyh4IPluUvhh7n1uMY4hX7s?=
 =?us-ascii?Q?Xs7EnLzz+QPM+di/YLJXaMK1EAh0rXnffLMwxwzCUwQmoWkMaDySEfwq43sW?=
 =?us-ascii?Q?NXytLQ1tTC4iB57o+D8hVL1XAax3jGfjcH+EM9wQyKka5KhdaWt/q+pgKcIY?=
 =?us-ascii?Q?nVIcJm+Nrn86LS0sF86tCnHmt+PwBftdPlKAtKeakgapzPrrt1qQHLJQreEj?=
 =?us-ascii?Q?7Y+MN6FJ+7WQsvfkPdhky4GnSq2SfpNa7cmQH62xYQjLKNLBCoW07QCnMjnr?=
 =?us-ascii?Q?HG1OXQJVjHc93YNfBlmCoMa73A/lYtApbBXiSbNgqk9o2dd2evmLteQjxwRR?=
 =?us-ascii?Q?PgUWK77OSShQIHzb5Sszb3R3FUNq3RGaINbRMrgNqUPZLDviMzYYVmTfYjfW?=
 =?us-ascii?Q?Gi095UF6dzaJET9aRufGHTQSIG0vqXi6sjhXMMvUHvvYZCjso44LlXu/octe?=
 =?us-ascii?Q?1yewUK1KwYZ6dGwCEIJvqL4IiWqQJfHOxLPwiJf+nn0RYcup1RNioff5D/xS?=
 =?us-ascii?Q?E3jefaH0hNDz3dlAZjoyxPrKbCboLBKY7ORAKmvYlY7YAU+VlGVWxAg2ns23?=
 =?us-ascii?Q?VROZI0ZZkvY3bhStQGK0MWBpUgJVj7QMaEai1kswkK6dkyhRLU/Am/5DJ90J?=
 =?us-ascii?Q?tf1W2c1weTJfGzveS0D2Ta7vt6AtCvIUy147MuKzNa9o7yNXCuQcP2K3ouGh?=
 =?us-ascii?Q?5iTxQAXpUoJqtpGok7qDfpqezUQvNDHzL7EOGlGa/ODXZrqczGc9Z/k02wqR?=
 =?us-ascii?Q?yrO7wQvwQofF+LukJrHdeimDDZr35i/QCw2n2+rFl7P9GpdwieLQebYnsTuy?=
 =?us-ascii?Q?vedXMInPYhPZrJzflmYOneO7LxfKDAXoR1Lv+denllrzMs5JtxDzSxiAG/D5?=
 =?us-ascii?Q?7TggXwMokQseDwUDBXrXPCCerQA+uBkgeFgYJ5JULJxpVigLip67dIAobn1I?=
 =?us-ascii?Q?NYHjxlRdVSUzg0R4b7bu8dpixy7Mw9snkpA+aAh/cSkKMc2bZH7owOkml/5y?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88879bb6-371c-464e-f5a7-08dd3700332d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8909.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 14:06:55.6855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FiuWi9TOxb613H2JG8zYKRu4NiD9T6hwBQdThkhJdWYHfQ2M0x3VhUSKP+7YO7aaKAeoUMpkwnbevb4+1jHPGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10201

When calling getsockopt for BT_ISO_BASE, this initializes the length
argument to the maximum size of the buffer where the bytes are placed.

This fixes the fact that, on a Broadcast Sink, if the BASE discovered
from a Broadcast Source exceeds a certain length, the bytes will be
incompletely read, causing issues when parsing the LTVs.
---
 btio/btio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 2d277e409..f32fbd509 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -5,7 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
- *  Copyright 2023-2024 NXP
+ *  Copyright 2023-2025 NXP
  *
  *
  */
@@ -1654,6 +1654,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		return FALSE;
 	}
 
+	len = BASE_MAX_LENGTH;
 	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE,
 			&base.base, &len) < 0) {
 		ERROR_FAILED(err, "getsockopt(BT_ISO_BASE)", errno);
-- 
2.43.0

