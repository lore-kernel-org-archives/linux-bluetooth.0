Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2071.outbound.protection.outlook.com [40.107.7.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F713E214
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Feb 2024 14:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706883052; cv=fail; b=biNestCe1MXLdvJgg9MVwws4nZaDv02faUSMbua+YyH2iCHOS2Pz0PN6rt8J8HlbwglJcFZvg82/VQV6GkR/7HNE3t5yPhHa0lNj2hSyYbmltE/dzpCgkw6w22h0pPJk/8ezyRdZeOu4xWorVWEN0Q/KHBbBrDelOuwZeDU31bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706883052; c=relaxed/simple;
	bh=A5x9o9ot6HvMA1ylNKWgwvQYCZcf6lG3imIuT1o+SH4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e153k5IoZwbW4DT+RQeSamDaeiCR7RzDzJLbcu3Dv7s4MOyWDe5Z0tGtsgPew0/H/Mu28DSxYF3nEsOl8ok9U6KtVIlQ9kDnkF6Ii21CIDpmk+SY0lA5yh1qvF+/un15N2FZmNEcGxzhXsC+QWB7jEc6/SS/jmWXk/3HdZteLEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OZaFqI96; arc=fail smtp.client-ip=40.107.7.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OZaFqI96"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2TYLerIlbsTBM3KW3evjxsu+Pp23AftBez/9y8dy9zmn3IkaMjmCNtTiZqZyZ/sMlVLH3TEmYzOVcVO8+u6qUYg9EwMA72nDLMwNrG+Mvej0emW0qZY0kDRKwajntTcQpaEvAUCcHdj6HVy/cPBSpXRwniFKb7cdHiGk5N6DsjyGyh6THTXthCtpajyV8wwRIU8pTi4mdJL1ZmbrOtmI2nEEhG3eGZ/+15tf39xOMi7iAAnbWKH6fQpLHn0XrHEzeOporNBTCpOZ3+ARd1ZZ+BvoIyr37sX7cAFqxNW3NlLG3f9dtf+axyrZfx52trRK/kmOpmrGOto84hacQki+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xXqrS2DOAbosEZO+DWDZnjhl9idB8ICy0/R0ISH48bQ=;
 b=nvPHDVTsMsZRjGQlyxHzAdGx0hxIKhXxavVDk7WbJmahNWr/pTZWvNEHwo1ij94qQyIDEauyIfnjyIBeg8Kez6jTsm+vHi2wgOF7eaevegzLlhyvY75oCM+0ZXRf9fF6pK3ZwEeEs4cVdNi8LaCg2Ww+1ZAcH0MGU6xvcTOhS0AGhTmZu00l5SjfG7tLLSYDCGcjotGHHlUVJQKg9LjDW2qw7MnCbWhw5sKAelv9cnm1eS0Obj5aoATiJ9Fm1i89Ov3/ZBOUmeCZajmO5RLrofPxsH6qtKcd3nh71aONeDNu1cr0QcVyeh0IPMZZ0UsOqSl7wGPiLqiPbpXrE/JfDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xXqrS2DOAbosEZO+DWDZnjhl9idB8ICy0/R0ISH48bQ=;
 b=OZaFqI968AwJRVe72uS2BmDgvwoY8Mp2e0ZEI9tVsxNTYqm/v6X3kIVLyQfsYZNNwdpfiWH75vVxkannRcRM0q4I9+NcGzcSECiqPUXBYdWu5Tp4ZT9jSobljwnutlGmRdugPxdV9LoPUFiq8mNgEgacpF/ehdVT+Emm1p2EREs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PA4PR04MB7999.eurprd04.prod.outlook.com (2603:10a6:102:c0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 14:10:46 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::40f:c80d:7049:8213%5]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 14:10:46 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/3] shared/bap: Properly cleanup bap remote endpoints
Date: Fri,  2 Feb 2024 16:10:34 +0200
Message-Id: <20240202141036.9797-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
References: <20240202141036.9797-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR10CA0106.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:803:28::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PA4PR04MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d5af30-be27-40ca-51e3-08dc23f8bffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YKyvn5I8dQbcTAfpDQyWS7OszJnf6gJc6S5FH7yFZZHGGxLdcDfZJvmED+aP5Ja71ojvReyUN4mdNNk3IK1CGUO7iAd/I5W+A7WyY5vqR+56bSQsflucOuAkch0Bp8+E/SVp+yZUgcpbJ69gDwBhvtW9aWVN6Zr80FgNZnxz4UwOsiMEr10CtmjsZlXXhxoZ6V6cek4XOkZhQQcxsu6rRrycFR9qJjvmv7rJ98idrvwFs/xJS8U/Vj4ni3ic31XW7piBSavVGVGp81uuqjfYPA1pQK54cmdln1h3VBdSi/VojsK/Hx18bmOjOV14VywW8dMnopJuPCrvygCbH+q0cs6gtIEumbn6N3OODhzNDejCJd6FxOGYNvGyTXbZwrOKC/SmqtGDUA3zzMLAIYTKkztcYSO8hmOOgYF1BXk60AHOUx/bQGxWzOWUVgodjJ4dbwfbSfmKbnLvo8Mg9qnLjusbHEiPx8FnJ40ybLrujRnjjkq9OHsZ3aVK+ufkvHfbznmbBafWtlUE8nt58e5yETT5Z/o+YKj+iPFdXKevJlvDxEyunulyblfFllmog4h1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(396003)(39860400002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(83380400001)(1076003)(2616005)(6512007)(26005)(38100700002)(44832011)(5660300002)(4326008)(8936002)(8676002)(66556008)(2906002)(478600001)(6506007)(6486002)(6666004)(66476007)(6916009)(316002)(66946007)(86362001)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kP2yk8BRzm7C/bWEOIYBN15nVO+TaqS5Skfq//qS7LW4Mcfjw1EA8oeryo+b?=
 =?us-ascii?Q?PWKYeCIYuSrOnkaAUIZ7mlIRe16rDTTbRKXYR3w7K/IxasXV8mUYEU/s/msE?=
 =?us-ascii?Q?5kG4i4q2G5t7KPym/sffhVgS7ZtVmaXp7kZt4yZg0LM1rw9M6uOBubHHq2oS?=
 =?us-ascii?Q?MD0oFRhiicWFUDME/1IekoqWTVPlyGgUIdd8c822IEq+WQ4dg+dHepEJAMZE?=
 =?us-ascii?Q?HZlPpCJZbSodGqKgdUHiHDTc1BeFOupDEs4R/y1KJn/VKs8/3NvJU2zaVLh2?=
 =?us-ascii?Q?+QR+E4wlI5n66kU7lYkWjpRKFVlHa11oQ76/Ut+J5CPprzoPdw9QsSEle4yf?=
 =?us-ascii?Q?ZaSxdSiqoMk/YfCS73qRZCVvhEwFugsGUL93R3Kxw6oamEmaH3fbgPnR+YXl?=
 =?us-ascii?Q?pxaFlXi8Mxup8d60Gga2YjQ5N7oYm1fyE7G1AqE59MDQaULmej0pgA8z+7Ns?=
 =?us-ascii?Q?bdsdIzMo6kodOW55o8WeDhNjrKht+pgxuDExZiXHRChl363RJi/He2m3ll0B?=
 =?us-ascii?Q?87LUNC79YKjsBQXZsm6iAsH1GP8UMh9Le31YGomAt7dKS6vfligIYQSWxlb2?=
 =?us-ascii?Q?wydwA8d68JgOtch6xx2MX1GwT5ZP/ALTfM6snhQ1+gnHtUQWWs6WY50jTQdW?=
 =?us-ascii?Q?8gYuE+Kib59KPfnDIVZ3Z27YNWXU8P32zC8eOnP1EWm3FjDfInSvceZez0Lz?=
 =?us-ascii?Q?7shO7o4rWCIIZyqGb9zkmPYda85yftRrL5QgkSeBEkOLb9I3UfQVljkSnTKq?=
 =?us-ascii?Q?mZh+ZeaPsShKa2uV3F84f5tH7QYcfNXmy15jzqHI6R2SNgIE+WMt+TMjdEZm?=
 =?us-ascii?Q?nvtbkdlXgM6mmi4UjyZ9AddfROvRtdoIHAd4LkYWrw9MgtQ/UzELvzTf8rhS?=
 =?us-ascii?Q?2MXEvxCc9HelQ4BxakGEB/ws6OVlmSJVcJrVPtjF3Z+rtvx3Ymtal9pDuByK?=
 =?us-ascii?Q?KgYSK0G+DLnR8GrWn9IFZEq2CJK847xyzcXY42g+ByI/aoer5jTW9Z+CdbVW?=
 =?us-ascii?Q?S6/PaUDw24+xkBpL+WDz1myFoeU5JVwdk3uEtiPb/MxBx53E8Dkl1qJ6KZgL?=
 =?us-ascii?Q?SnApCqbrIYi0Lvl8fLDJ0GLHLKBP0R2dF/CWjlOjnu6ACVvBV6V/hpSbYooQ?=
 =?us-ascii?Q?5RTVv/QOgYlII/MuI2XZY7j3s7XCTYNFs39zl+7Bjq0ROxxoRX75PkGCg1uc?=
 =?us-ascii?Q?q4tp0XwkaDnf4eQXbeS4cyhLQ8g+5g5Ms91nTU471LURu7N6GcDYj3dKiGsL?=
 =?us-ascii?Q?sZi/BBcLhtVncJiLwi48PMQBd3BVcWPTP9ktD1lcOtR9dhDF6LswgcYf7VC3?=
 =?us-ascii?Q?YQRinekQsSWaWBuPwsAtypd44FxXKraXRkvpXg5PnQrQ018a9qcqtJNr6AMq?=
 =?us-ascii?Q?s+c0cULsJM7Rkm7u7KXG6/Q99d+g10xJcz9wR7tzWL/wB54yJZrN4myUSnAX?=
 =?us-ascii?Q?5GXLkH1aKYwnQXRMtTr4IDVAjaM/+kxNnPk3ilJDvT4LU+c2/q1ZSP2ulR70?=
 =?us-ascii?Q?ajWRE6w5/kq3V3gF0S8+JcxY++RnNy4i9OZAmfod7qbPR63EowqeZBt0L4ki?=
 =?us-ascii?Q?QFaG6Qf+gWTVd+U4xmgJ9LWrWhuoQ+H2ZF/wg5GM28+dxLhLDtglKUyc/wFm?=
 =?us-ascii?Q?DQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d5af30-be27-40ca-51e3-08dc23f8bffc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 14:10:46.0724
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ql+xvC4c4epyeCHlVf1mjmla/aVMiRlF+54C3aXbXKmwxNjNmiov3lICAWVhq/UQ1vVLuGK3iE04ai9YGnvFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7999

When freeing a remote bap endpoint, the endpoint reference inside the
stream should be set to NULL, to avoid later use after free errors.
---
 src/shared/bap.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 851d6a5fa..60fb826c3 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2979,6 +2979,16 @@ static void bap_state_free(void *data)
 	free(state);
 }
 
+static void bap_ep_free(void *data)
+{
+	struct bt_bap_endpoint *ep = data;
+
+	if (ep && ep->stream)
+		ep->stream->ep = NULL;
+
+	free(ep);
+}
+
 static void bap_detached(void *data, void *user_data)
 {
 	struct bt_bap_cb *cb = data;
@@ -3001,7 +3011,7 @@ static void bap_free(void *data)
 	queue_destroy(bap->ready_cbs, bap_ready_free);
 	queue_destroy(bap->state_cbs, bap_state_free);
 	queue_destroy(bap->local_eps, free);
-	queue_destroy(bap->remote_eps, free);
+	queue_destroy(bap->remote_eps, bap_ep_free);
 
 	queue_destroy(bap->reqs, bap_req_free);
 	queue_destroy(bap->notify, NULL);
-- 
2.39.2

