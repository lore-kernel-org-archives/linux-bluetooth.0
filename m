Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C228119B593
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jul 2024 14:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721139745; cv=fail; b=gHYadJbAoEv6c8IGRdsmLlSKyElMthCfCObGxl28zMxiLhRCl+wsKDw0p1Himikf81kThoEyNrVn9jSLbQKwofDGK8dgcQLNa+bZdfdhRL8mV/vEj6UQ9hIfYfTpoj27rmU5kTYnhc/WfM5+96jg0DBBdY4ZOYArrKe5KM7GLGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721139745; c=relaxed/simple;
	bh=WFzIkxDniR497VH/kmzdXQz9vy1Bn6Xgc2BsmxVES5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rjAzY8l3ZHdWj+BrE4VikfpPziLssItAlZY5ZnjwcXmF1vwPfVGvjdBWYBfM8n/1XiK2SVLKNIOvUO2EAxs7nCPV8Ek31b8AfFe1t+K4nSei+EzAsvXN/l3iE513uUXLOOagHoPkp3t1FtNl5E3aVwm5wzwnAbLXkSX3KpxMWdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mfAKdE88; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfAKdE88"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKtBPjWHEThBVMZK5OjbtfGx08zXiQWSS/l3h412/4MnSpJSSZlie4ZFx7iJljWuoQM5aI7ncZFoEzRuwZGqNtKiHvDNnj/gwdYSTKQ4wexSJq+ZbZQrT88qzn1ksHYrBHKRMk0lEfzEm1dTd3doa7qaFiPU1fA6zv5Mxu05ItSdX3k6eABBZrzyF0JefQp9iKJdkAILGffdR18zq4lhBCOCqzzs/4/RE0S3obTjD/zY/ObfL/FHKVyMV9zJVf930aTCVQydZHg8tlI+Y103cniWakl95wRQq36etLSQ4HLwY4dMS9FMDMY/x/Eal828+Osq08ck0uQqjyo18NGkaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AjQdyF9qsp8SunTTN/0pInmxGPJwSSavOLx3UARl1y0=;
 b=rhpR/i3rPqK4SWNgZdpvuY7r3OSbZ2J2tgDFEJlvfFpVJx/yWrTJDXyExnJKhLOvCMqDK3pVzopPXVRZAd4AwZTo1AN6241E8RRA+nEAyJifw5wyC+adhCp7VPI5LJdtZkyjs12p7V766s6w1WDL1jl37yzLDcislFHpPEkymOgdqyF7hgim4abxEJ6cvkSL776/TxoLtS0HiVaJRhkvUgz9nt+MIOpv7whQcVSW0FBU+0qJnzhDk2XCaeZobsyo1/Gb4yO6l/wcLi+CURYJGYaES9eBcV0Z80VsJjDo6LOmjLjU1wYtlL182xsaam3WwzaN5zdEDSf+DCTg/4Wyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjQdyF9qsp8SunTTN/0pInmxGPJwSSavOLx3UARl1y0=;
 b=mfAKdE88q3YRtioTB0YpNyySLZg621GenVO4cRD17CbJxcz0i2UjVVA8pMeYNdlHy7JtiFJ67YcA4QeIrURpK0O5+Ez/DFkRGS01IZpfRMygZweHz8ET3Z0o73pND9w5SjA/I4UVM6LJpegGfKh21JQ7ddLEvlaDn6tQZKqjJLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6789.eurprd04.prod.outlook.com (2603:10a6:20b:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 14:22:20 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 14:22:20 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 01/10] shared/bap: Add separate API to merge caps
Date: Tue, 16 Jul 2024 17:21:58 +0300
Message-Id: <20240716142207.4298-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
References: <20240716142207.4298-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0029.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::19) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6789:EE_
X-MS-Office365-Filtering-Correlation-Id: 30d72e6e-05d6-4b1b-4d99-08dca5a2b3f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j7G8tQMEAficscT5L7syKzLfyj3na9y67hc6AR12m7TKByifWVbVsUKp3aYi?=
 =?us-ascii?Q?chEMutjllqGm0quATaAM8IuHLuTZYxTinWMR565xSvlsJne+ABSs9E0yRJU5?=
 =?us-ascii?Q?ybJv8QCWCPhw4pZNJkRb4Bv2OuQr7RF9f+LEn6w0uYbCcwA1dtWtjE4HUpSY?=
 =?us-ascii?Q?3kFCDLK4iXwj31kHG1zcWgyDSDzAEo6xPxZeh1kAgvFsJR2RsG1gfJ0a7AgY?=
 =?us-ascii?Q?PkxZe9ALd5l3ektDks6xU9aMSrKPOxSoxa1a1EkrWwvERsGOFrozM007TWKV?=
 =?us-ascii?Q?zz4nIjyBGlanh/VrywBXZT+UcX2Kom+mcBCCOPNmBYqTrQv425JHQOiMie8t?=
 =?us-ascii?Q?33RYFvInYrGewjfq5PWdHq5J3omZd5HTjpaMS3qX+yqdGAI+HNY9Ekp6fzqD?=
 =?us-ascii?Q?wlePRDB10o3oQYZmk8bHDX6eAUlx4051NkZcYFuKl+VS4xLbJKQ3ERcq3WGj?=
 =?us-ascii?Q?CqN+bWUWkKizZCq6A43SplwFE5+oCqBweBuNZWzBY3r0ilg1Tn6C3lHHlbhm?=
 =?us-ascii?Q?Hi8z6Dy0J6IpxtPDzxsDBL5PTbUI+BpcJysoYFP2lptjS5Q0cQbAEg7u2rFa?=
 =?us-ascii?Q?Z9n2vXeYW2MGIez/2XnQKk+UDzNJ8hC2UoQw9KsEo6C8aNwXf4/zC1NAiKyN?=
 =?us-ascii?Q?JUZ0R1GIPb5dAeFMwEdCEg2IFStu7C+q/WZLV1/B4DnZ2ZoBRs8/aY2FXM6i?=
 =?us-ascii?Q?6Dxm92lAxSR9D/34ydKB4tePiM3ZB0d90Tn+duAOlVI75tHMHqxT/vMf8zob?=
 =?us-ascii?Q?ircPXxEK84GisWLvfVldOb8w9CLU5Ltpf6Qbod2GJ3Nokz8v7xqDfwWonc2e?=
 =?us-ascii?Q?Btm4MqbEJqNVGQCjhhObl6vFCSdYVAfUIEEF8tFQPY2dS2YRwxusrznS2xuX?=
 =?us-ascii?Q?XAz+9Rs4TrC/sGXFjEhseUv5+z6zCCf7VqIhoQtaQUQ4NyEtiZhpmC4YJ6FT?=
 =?us-ascii?Q?GeikgM8PtsQ3aFIjhLIqiahYUPnNPxteTCATaZm5XoS/WAKEsEZrM8EK6SzN?=
 =?us-ascii?Q?2m7B3aYAnaugpw+KIbFhMtpttRg2I8GfM3ALPrwC2mwCAPIlMm/8Ww4Z8jYu?=
 =?us-ascii?Q?KYaZCW1EVTzcoEZDwTFyy3vY2C9JBhRWtAmFSxrVVKOarfUqKcIV58sbj3c+?=
 =?us-ascii?Q?hXl7CGOADB624LybAjP/VSHY2t5Zgchf1z+Igy1Vf/nLglUimd8ig6vk0DRQ?=
 =?us-ascii?Q?vIBP3ntz2+3Wcur1X+onhBimcDkDf17J7LzPV1Jfzz6qyJy9HitBnn7WBGg/?=
 =?us-ascii?Q?CQfFdbwc9xhpxRexvQtBl54ezEhmHZRbrlRke+3tj9Val4lzfA6WCTjdxW2r?=
 =?us-ascii?Q?VKvUHcQP7KknfXyEplMYqUfGHIje6kXc6QQtQm8PE7rktw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QeKeStlIEVIiibD8oxDK0CcjQw4traPymofh0FEAz1iLA0oQVNy2t1F/qzRT?=
 =?us-ascii?Q?3VsH8SR81sg1ufFdWa1MyIEehyEdE4d7bF6V+BMK63bi+IsVlHfS/2rCpwSh?=
 =?us-ascii?Q?2hFB2x6dx9LMOfvFni+olgLadLqxdRnMe7Xt65eHOcExFJ0PFnfDbyKZKqMQ?=
 =?us-ascii?Q?8QkU/PSxiPqoin4qoXnWcW9EXDH368fa/DSb/4FCczXiLbtNcAN4Q1VKKQ5J?=
 =?us-ascii?Q?d6JDgOed2MEUIsbmoir1Nf99qLMlkOuITC2BUOrpyFVtdIfFg/TLndaFUkXb?=
 =?us-ascii?Q?Fdh4JqAl8jkKbC/mE6I/Rd03Jb+tmRHbK5wb/HkFHWO+nm0VQ3uqyP7keikG?=
 =?us-ascii?Q?t2CFEHqcGfvGlkCtozzREzq5Oiemqu7KInGX4surU3Xq+DvNJmGnbE3y5h9w?=
 =?us-ascii?Q?w6VkW9kJQzNACq4xKY8Lqmdot2xgJk7iBkkPcSFLI+NydkGd+TBy5nEm+LDl?=
 =?us-ascii?Q?f+68mmMAhQYNeiG/cfsat6hfpKOXIqyvOcxhImF6sYSKqMJuRHHCwz0wEwQG?=
 =?us-ascii?Q?VNOgLhkz4C0Ztli8i4xZS9zxLYudVDamx0ZsDe6iCCUnCEHrUw3f1iLrIaWy?=
 =?us-ascii?Q?nc6XXU0tE5nbHGl/o5CbEe2mOUnR9kq3C7vFopS/hTG2LNIjH0w3wdZkYdsO?=
 =?us-ascii?Q?bSN4ZxukRf74ZNqLzg48dnbOjckar/YpG9xlUPZ4Rpy+QeozuXuTU+A99t7f?=
 =?us-ascii?Q?6GR37MCOTP8J+k1bDcMBnlNIHepRosNo24OdVvzarTO45/ruQHmaS+cCq+x1?=
 =?us-ascii?Q?p17/S3578BjKkUrJvuCbj74PgFDv/Wonk5h+zEpR7zLpb1QCxdEQQoF472N5?=
 =?us-ascii?Q?11hfqZlNeYoYLRcBvwYnLqIlRJAHa1Yqp6JIPkqM36tkuaBNaMI7L0+fKBdy?=
 =?us-ascii?Q?RJn46n5L+Q61qkHtxxVOwe8LAGAN2pIHKg1RV030B+Xp2xMKMt3d+Pwdr0f3?=
 =?us-ascii?Q?x3Q7oEGH6ZCQ4ZTq3GmzkOtgANqsZKfdQrCuF4+uAKtFKMKUPMAqlw62pz76?=
 =?us-ascii?Q?UdV8V6GvtQWeEhMInbABsZ7eUjXS+AnGMklAeNM+Mvsym7XOy8MSqJC20ADG?=
 =?us-ascii?Q?In9vMqr5mN08gZNHquB6O+8tkPCp19ogMIrMlkrliNUj1nWmoRIsdp96KkfD?=
 =?us-ascii?Q?DaYGWXuoFVAR/J5X2JzYiWMnmyPnNObaY+yWcR+M0sMXk7oZxNLMAwS8ybfH?=
 =?us-ascii?Q?hTjvpcPu8WLE9LhD2WxlYtztLH15XoTB8Mhivq186X1Kfn1XdMCe/w/9nZDV?=
 =?us-ascii?Q?klbwlcXUfanCzAB82DE9N1ffRpF3LkDRG/VbOW+c/1aS22Mxlvyt3mJWCmyI?=
 =?us-ascii?Q?srRMCcwiQ18Xngh4BF/E2/SGinYT8TA0TitZR31LHR9A+FuVeDq+MEcq1UaJ?=
 =?us-ascii?Q?rCWQzDBdpStpVeNKQtwrt5ZPVsLgLpiP2NrIhqV36wuxgkQ2sRY6ZFm4lB5U?=
 =?us-ascii?Q?LqatKQiMbkL3QslY0DNgNK9kunzeU+jqWq3mhGWuOutIUvIP+QpdA/9Njpcs?=
 =?us-ascii?Q?3bOaEAbZM+MSTPlMsVESObs3+ttdJf9qFhMi/fc5rfDbA6iJJmk7f69GQjw1?=
 =?us-ascii?Q?K0fs8NMh9TXF8yWze548HSdP0P/Rw5v/7HcWT8FQdAFLr1TrHSlSsA88h450?=
 =?us-ascii?Q?0A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30d72e6e-05d6-4b1b-4d99-08dca5a2b3f3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 14:22:20.3040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPkZbPcedl6LCBVZWE1MbpMVZ/cmDQrjl5Wf8FsgZnYPv4f1xCFHuHkvX8hpYPVNlQBWbcat6R43LXMDRS5ldQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6789

This moves the logic to merge L2 and L3 capabilities discovered
inside a BASE structure in a public API.
---
 src/shared/bap.c | 40 ++++++++++++++++++++++++----------------
 src/shared/bap.h |  2 ++
 2 files changed, 26 insertions(+), 16 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index d59eac8cc..1259ee3c9 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6607,29 +6607,21 @@ static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
 	return compare_data;
 }
 
-void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
-		struct bt_bap_codec *codec,
-		struct iovec *l2_caps,
-		struct iovec *l3_caps,
-		struct bt_bap_pac **lpac,
-		struct iovec **caps)
+struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps)
 {
 	struct bt_ltv_extract merge_data = {0};
-	struct bt_ltv_match match_data;
 
 	if (!l2_caps)
 		/* Codec_Specific_Configuration parameters shall
 		 * be present at Level 2.
 		 */
-		return;
+		return NULL;
 
-	if (!l3_caps) {
+	if (!l3_caps)
 		/* Codec_Specific_Configuration parameters may
 		 * be present at Level 3.
 		 */
-		merge_data.result = util_iov_dup(l2_caps, 1);
-		goto done;
-	}
+		return util_iov_dup(l2_caps, 1);
 
 	merge_data.src = l3_caps;
 	merge_data.result = new0(struct iovec, 1);
@@ -6642,17 +6634,33 @@ void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 			NULL,
 			bap_sink_check_level2_ltv, &merge_data);
 
-done:
+	return merge_data.result;
+}
+
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
+		struct bt_bap_codec *codec,
+		struct iovec *l2_caps,
+		struct iovec *l3_caps,
+		struct bt_bap_pac **lpac,
+		struct iovec **caps)
+{
+	struct iovec *merged_caps;
+	struct bt_ltv_match match_data;
+
+	merged_caps = bt_bap_merge_caps(l2_caps, l3_caps);
+	if (!merged_caps)
+		return;
+
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-	match_data = bap_check_bis(bap->ldb, merge_data.result);
+	match_data = bap_check_bis(bap->ldb, merged_caps);
 	if (match_data.found == true) {
-		*caps = merge_data.result;
+		*caps = merged_caps;
 		*lpac = match_data.data;
 		DBG(bap, "Matching BIS %i", bis_index);
 	} else {
-		util_iov_free(merge_data.result, 1);
+		util_iov_free(merged_caps, 1);
 		*caps = NULL;
 		*lpac = NULL;
 	}
diff --git a/src/shared/bap.h b/src/shared/bap.h
index b35b2711e..e63161dca 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -251,6 +251,8 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 
+struct iovec *bt_bap_merge_caps(struct iovec *l2_caps, struct iovec *l3_caps);
+
 void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
 		struct iovec *l2_caps,
-- 
2.39.2

