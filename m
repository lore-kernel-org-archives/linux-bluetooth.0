Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7C213EFED
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883054; cv=fail; b=EJvsMPc5qnaDbXovlYRFK0mRgh9PBTBDUOIGorez3n7774cTGVM/eLzuAUedOyHTjIiL2d2bhNugVpWp0LVvD+XT71KlJg2uUpTmCBH3Lx8KU8GFR6+MtgSDP6gsNFTg3xqjwY7Pg3a/xqAseiZUmcfMCmt+EeS1VJiTab+QbJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883054; c=relaxed/simple;
	bh=+RZlqB6i5/HVJmLZ4hdvi/Aq6pZdaVhy8I34kTH0Xwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L+AhuPcz2R1w8GuileE+CbpkQMUYsOV3xy2ZVH8ypvaLkNb3ptQ/ifg4OF45CIWC3cRdPYT9WSCiTosmcN38jO0fLw4IQu5lzkdb0Kz2hwOF7rllpBrPuW7+DaJIKy1GnPiJD7zooobLQiED1dp0F1HzsvHIQibNwiSqS92tl14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bmrJrYxE; arc=fail smtp.client-ip=40.107.7.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bmrJrYxE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTPxRJ8Yep2rzgxQFc4alesGu5H1HKIhAgFYJhYgupwpl0tg0GYq0lyWA+RxfPk1zzBdQLxKbsPIcZiHceHr+Q/X7yc8HKSaVDQpojahPsDZCk4X9SUdSVXIQhAMdsFxP8CijlO86aZnDVFn+dCY3GdSJ015tC1lD7OaKlZtfp+7dHW2qubWGx4zVph2S4uow3TmD8jOmfPzTuRSRC0WpGet1CGFCcMvAp0lfVNKunhAv0boxN2LlpQQTkxJo3VOIEewuvaWHbfR+EydGokEYt9YjHGtBu161kbw4pHAPQTsMMYKOSf/z/qZY/u3x1F9P515ip7N/3j+o3FBrASRmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlNihasu5zZcuSm6JGbLwq+Hs+xJ6zkpy70O5Zblmiw=;
 b=aphHXhFiMSYpjgRqTIDy+izFXCdiQ83VQXqyLW1Rvu59TmxAbfnlNSavLVHwphXmK7duP6KTRuWT/jyG/FIGcUCD3WYSTiC+khF7LbxYladIAHunvAZRziDZoWPTG/hMlmkU7nOuTre9gNw58xLyaFpceGtnkPu+KdoYcKImXwP0eTMNpwIdygvioIs4oMIPRH+E/AvYajG4HV53otFsu5ZA44NCVDZkvyJjj9s86Ny1LLZ6Fs9PNAeCnyXAuyCK3o6/kkV23LGfaA4WnVmQqfxGgTgit6U1OI2moO92pPW7kofAJ+m29HSmoZxxKPhADwiIf0ynJrHMv4PXHrJzrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlNihasu5zZcuSm6JGbLwq+Hs+xJ6zkpy70O5Zblmiw=;
 b=bmrJrYxEuut6SkdyDSgPFY9ax3YBMSu4wgFMHQZkMlWqIrkn65FypzxtoXqCBFnIhYx9tlN4SV1i/+qHbC4MESK+nUmoDRVFXS7TCgbjmRIACwGfETZb7SCI+s9l9hIlubl3Ijx4qSWs7wcrz9PrfawiMZ9QDoHnMaeQxww2DdE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:10:49 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:10:49 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 2/3] bap: Fix incorrect parsing of caps and meta in parse_base
Date: Fri,  2 Feb 2024 16:10:35 +0200
Message-Id: <20240202141036.9797-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
References: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0044.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:800:1bb::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 4793feb4-704c-499c-900e-08dc23f8c21a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xBCkHQvi69TiJKYftLLu0JBX4hermIFDYfO1GpM3fb7lS6gHJZ1qDlWVRSM3oDsXDvjfSDtmzLdvqpRfd4R8Gwv6JYh6cUrW841/t2QmzqsDKwvCp+rCsGeuPsDnQJ7/HZfbw7icAUm0lcSuGJH0UW6Wer60+HgyYkLywrzJxrCxKVqkNJpA5ng/bH1vwtb4AbnpVSrNTXkDF5MPvjKhgBadH+Z5dyGJ6WVCHjM3g481d2WZSuUwqVweB0qE3Fj5H1LtaYCvFwTARq4HT4VLYgAfrBcF23XJFuTznjWeC1YHehR21aXP3rIwO+TzIAoG8jcGcntjD0r1eP5jpkBhAuoOa5Q67Ao0fHMGeSOwoeqlB81QMzNcZ/S9En4IT9wSkegLIXKmKtzA+/Y9K+lP8aq4T0ALy6NANPHb7/b2MLItLEsHsuHnmLsrsM+Yop88GVOi4W2+0ijkaqwBfgTsNPCXhAPd31uSOLv8xoGYzxJ220NLcyFMo57iXMWuLZko7uBEPl7KfchMuzGn4/wOouGD4nR8w6ZHeAL5dp/E4Vx8QwAIw7gNxQg2YzTiX/wD
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(1076003)(2616005)(6512007)(26005)(38100700002)(44832011)(5660300002)(4326008)(8936002)(8676002)(66556008)(2906002)(478600001)(6506007)(6486002)(6666004)(66476007)(6916009)(316002)(66946007)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lf3p1YjZpVUHAR5d8kkLgH+ZxxqBLFF6oNsofNadx8P2SF0FxnTvwm6JJCeS?=
 =?us-ascii?Q?boEHH8aXzwuEsveETFYAQWjignd2Epzxd33Lli3wirkObnFYCX2tyOWw1iEb?=
 =?us-ascii?Q?AEEznTeme6OxWRhk9O9ZL2Dq0lnJ8P07Cy9ZabsVs3RMyNP/hp/IqU1LLU08?=
 =?us-ascii?Q?5SzkQEhPy7RwMCv8wP86YUiUfrb9H5NOb4EUp21Uin4v66uAECNqcIxTsTkx?=
 =?us-ascii?Q?i8XhMMi3jXQynPK6Vv0uc1h2l2MlkwH/sXHChGDmzSaC+UCV8u0VvzqigELm?=
 =?us-ascii?Q?CIHhDK2T2v0uJAOEDc1U2JAV7nRmrLh4OmJWoI34xBynhKUc72B05P+PPa//?=
 =?us-ascii?Q?AeTrAHr3Jr8Ax57u3t5mrrdywfKtd5Meaweg1JTs++/HkJnzSG1jCwSuQs7Z?=
 =?us-ascii?Q?mKKAPEcIGR/8dLxY7ANupBVh3uSbA6SwjefNo7ZJ8YKjsj0sPrnFWoR23Qm8?=
 =?us-ascii?Q?kFQQYSEiAkyFT8QFj2z8EGCush159DRwLZxF0zAfT+EUDVjxV3mXlsd13ENx?=
 =?us-ascii?Q?dg76n0ffdBT82bDQY061wWtfeehv7vGBViaf1+xSuQKm2vz9D8IgY9NGZ0X3?=
 =?us-ascii?Q?FRiusAd+Bu/OE5miTkNqRir4VN2vgIEnJZt1bLV8em/QMzGwEBNlOQLz9dnw?=
 =?us-ascii?Q?9bI656+HAftce37J9el0+PSfncH7P0U1UaaiOAPhXaToaVyGbGeN/FmORpUs?=
 =?us-ascii?Q?3ULtLoGwtoDjw9vtH5UDhfBiInqNbqKVI+ezAP1d2HBg2ZJM+gEHaXI4h3xl?=
 =?us-ascii?Q?V+sSc5YlD8QvOSQFAMw88Qt/KyAxX4EOfJXxff7T4iGip3EIr1I0/U+BDJcl?=
 =?us-ascii?Q?uj7jyuRKbiH5KZpH535RzxKDaIKZ66VsYf+owbvfQs+gJlGA7at9Zi8H8K1d?=
 =?us-ascii?Q?awSxHTEpaNCImzC3VY662rwc0uWkziihaRPGd2PFmf7kafBTtxW72gSy3uTX?=
 =?us-ascii?Q?C8IvTXlqrfLDJ406RsvtOc2ziwsj77DDhqu/I+/Qs4DFQBXt7D5I/RWGAavK?=
 =?us-ascii?Q?GmE4jX+lBNmnfZExyPF9cMqrv22k4KeU7vdH69xA1/CvjBmowa9kt9/D80K3?=
 =?us-ascii?Q?etDmXCy9RW7aFKueiuI5n2Io2UD1u94AGnJ00NL4fQEjhokzbi86tvMaamCX?=
 =?us-ascii?Q?TYIjLPTDI1EvlUouoXy+gzvCDj8SN/0jZ2UfdL18D55KFFQum+9enCwArzfI?=
 =?us-ascii?Q?t9r2J0M/Kn/Qr/nRUjXPS83naz6yJQX+hjRubRgdehQubhJ3CGA20RMhbnvL?=
 =?us-ascii?Q?vtVUjCMtW9op29yAsThdGd+EJh2eWopor8ygJJB2qnX3tpOMuviWvIIp+QV/?=
 =?us-ascii?Q?s6XnEcsvW/oFeW2eaMEVQgXVSdYeoHkkHBuXSPPoGuPCLWBSlMiXCrO7CAGi?=
 =?us-ascii?Q?l9o5TVATV76t6LWtmEsmt/xagVVxmBECAF1v+SlkSiSZspEZn9bB3g5ZryE3?=
 =?us-ascii?Q?NQgrxpVt2RRd6SnSTJpT5Hvk3ucuzXxOPKWaihasD62ltcZVqcb8f1Wu+QI9?=
 =?us-ascii?Q?0WjEUuoR5/Rz7bkmKktAL/2DRcoKtNBAqYMVMlDQ70E0A1RcT1G6/V6nVdmH?=
 =?us-ascii?Q?Sg+/rrcg4EZPJYtBQoRz6iBtU7sH4QZ6XsZ1bt6fFZyJGEWmWyVGXV5HztiL?=
 =?us-ascii?Q?lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4793feb4-704c-499c-900e-08dc23f8c21a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:10:49.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ZvptsVsPnY7S2WJZJIBOxX7MauE9EkHyX5Aj1qSnbbzuH3vCGwdqk3LBZw4NiWftIl0ApuThQ2sNjaspkDUtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999

This adds a fix to properly parse the stream capabilities and
metadata in parse base.
---
 profiles/audio/bap.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 7faa6be7f..909d57121 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -433,7 +433,8 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 	};
 
 	uint8_t capsLen, metaLen;
-	uint8_t *hexstream;
+	struct iovec cc;
+	struct iovec metadata;
 
 	if (presDelay) {
 		if (!util_iov_pull_le24(&iov, presDelay))
@@ -467,15 +468,21 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 
 	if (!capsLen)
 		return false;
+
+	cc.iov_len = capsLen;
+	cc.iov_base = util_iov_pull_mem(&iov, capsLen);
+	if (!cc.iov_base)
+		return false;
+
 	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
+		if (*caps)
+			util_iov_free(*caps, 1);
+
+		*caps = util_iov_dup(&cc, 1);
 	}
 
 	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
+		struct bt_ltv *ltv = util_iov_pull_mem(&cc, sizeof(*ltv));
 		uint8_t *caps;
 
 		if (!ltv) {
@@ -487,7 +494,7 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 		util_debug(func, NULL, "%s #%u: len %u type %u",
 					"CC", i, ltv->len, ltv->type);
 
-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
+		caps = util_iov_pull_mem(&cc, ltv->len - 1);
 		if (!caps) {
 			util_debug(func, NULL, "Unable to parse %s",
 								"CC");
@@ -504,17 +511,20 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 
 	if (!metaLen)
 		return false;
+
+	metadata.iov_len = metaLen;
+	metadata.iov_base = util_iov_pull_mem(&iov, metaLen);
+	if (!metadata.iov_base)
+		return false;
+
 	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
+		if (*meta)
+			util_iov_free(*meta, 1);
+
+		*meta = util_iov_dup(&metadata, 1);
 	}
 
-	hexstream = util_iov_pull_mem(&iov, metaLen);
-	if (!hexstream)
-		return false;
-	util_hexdump(' ', hexstream, metaLen, func, NULL);
+	util_hexdump(' ', metadata.iov_base, metaLen, func, NULL);
 
 	return true;
 }
-- 
2.39.2

