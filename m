Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E9A200A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 09:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320681; cv=fail; b=msnEpg2iz/5jX4FhCtB72GJKry1PrmYqIKXmh8KY5jjYbEePiH1yk0I+XhmtLKNUpYShWQfyC4XhA/Efmpf7Qye4/FplGBz6+hZwZwb8sNTqKT5Kq1VUy8BT0XxeR27dBrhH1Y4DuT2Y+q9YbbO/NZb9ldMNW+xEAZsor5b8khE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320681; c=relaxed/simple;
	bh=8upZHiFvwePeuJcXLZ1mZeouJGY2ButdYMHKRCSkYbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XVVfULAyoySKs6Jw7i4lmKXFD0Bndq2Udq7I2m+NhUXoCcOlRPAAtIHYfxy4Zm+TZKW8aZo++7pOxPE/bY79jD8cv+3MpvECJQRwCucXk63plqRb33+/tE16N2DoW3EaE0ivA/ifVLfgN5ro2B0No+HGjkZt07RyVZWL5La7Yg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VPVPyV1D; arc=fail smtp.client-ip=40.107.6.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VPVPyV1D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iQ64ah+zG0tDh3SbA2h0Swt0ikYMgyYV/YSEhFXqF3MCRQ4ijkdop4cEnWaP/OGPs/DpF7ne8PMwJfFkR/s2d3H5DcwI9tMeT3aEIgXgH2CnAYHKLiGvN6Li7f6uKXdZyB0RzdPUgu/Hvut58bc4vECzQymVjGgniVAlqCKS0sFWwMH5HDxhCTb2pj3ewOfiPkcw4rlxIbXDzzsw2ptcYFLlgCBmkTbR3ESVZXKBwHgQyNt1aTkegGstzWHS5G+y5uaxk4GJ+2MVGHbSBhIGeDy73Abepa6YZzu2l+j6OvHMwo5tJ0vWe3mwXY8Q6pbeQMqK9inWGmx/U7AFG1cOjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0iDtdA+jJAQcIUwzguJdJsMc8XIqDhmtoGaDiTfXlM=;
 b=oRUmWGfbb/zPww73SLnJGplI+ekcDR+dj+N+5BIpJbSBHWKpYOb5/crq89vG/uTyF+A+gkx9gXyl2/ToixxC6hlEALohFgQtxhWALU1LYfPu35uBop7DzefmkegyNzpsfmECLej1VZIkc0IKAxbzB6w2aR7V1UzWrmAhmbrxSP4bynvzphBGULuko+cVAo8Gv+PgkgwQmZfNLlPWvAGbdSU1m2PHNAIzbQEnaUXu2zX7OnQwgPdR+QMdjJw6hfkCqKuGXz3C1ND53gghUdikDWAu3rvFKmjxOY4ybWUZiS7AVRvOBkRUI3zpsz6SoJKKj7GclXeeix7yMDhlXfZLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0iDtdA+jJAQcIUwzguJdJsMc8XIqDhmtoGaDiTfXlM=;
 b=VPVPyV1DuYw0CsckFl2mqPECRTgN9DHDFpmGA5eln9MvJji5AnIJIYzLKxkCivbj7cV4/b4aDIpXpwbMxcr4UURcG96GtqdSB/v8f3i/RKyPJvs2K+lf0x5IVE8c8r8a2445aXKnA/imWX+iASJd8J0C57AXBSbo7gs6PB7lIFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com (2603:10a6:803:d8::12)
 by VI1PR04MB9762.eurprd04.prod.outlook.com (2603:10a6:800:1d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Wed, 13 Mar
 2024 09:04:36 +0000
Received: from VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707]) by VI1PR04MB5389.eurprd04.prod.outlook.com
 ([fe80::8699:585c:e709:d707%4]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:36 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/1] client/player: Update minimum LC3 SDU size to accommodate 8_1 config
Date: Wed, 13 Mar 2024 11:03:59 +0200
Message-Id: <20240313090359.164196-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313090359.164196-1-vlad.pruteanu@nxp.com>
References: <20240313090359.164196-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::12) To VI1PR04MB5389.eurprd04.prod.outlook.com
 (2603:10a6:803:d8::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5389:EE_|VI1PR04MB9762:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a9d421-b78f-458f-33b2-08dc433c9b81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jbYciT/6muUf1ooSIMY/+ZryogNdPBrhHSWMHEViC9jY3nZI4ai/plQPyux37A6mVsOQzWf0s4EwF0nW07G4olrz3AKbolVJJ1yiG8MUDmGrQfuoBeE2QAg3oyOd+4xB/hFVdo+H7JCUUgSwgIpaYMSebJCZ1Koae4DjJHWPI9fkpf2fbAAPtbuKpU2mO04HRdMQrqIZ4qiLdabP/zwfS76KiPYLa25qG97ZtPRQSh1TUzRrWCLdBb6B+xc5tLmF6gkJXrpmLi8Ezwz42yXb5E8PsBZEPxrmmoD8stMgEgv2S2RIaiJXy7FsSBKQbXHnCm9G8GDIdK0Bn1n4wsozewPpuZ5p1WDdrnHMnmUKB7nebnE2nbQmGsZ8Ik+mJzY9NakN+dQVPM2ZzkqzEjHv5tn/4M1PaDX00fGlkeh/wLKrThPXtc7tbJvu4+anFkwbNFstz0XM9cO879xLOXdIP1dpkku3xbPbrEB33zrlzdQ6f3fpl425OVp6altG3PVS97PeuKdlAK1EefEoy2lyWpf1FgQN7DOtETqwUt0E9nSBXafDVTws4lEeLl8HEXf/x7MjxeGR+dsOu/KX+tkkjTHPowO1Rcb+8HKsSE2D+syETnfBFHUP8QBbB55Z4as+fKBxwAqm4rn6oXBRyp7g5s4ne3Ir6zRVGwh2cw2Irr0BHcPZODHl3BvFHxZ6W7DHytYYB8l1xkKD8UZJBYc2EIKsljbcksVJloxmMiJuU7U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5389.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1q5Ph16jpBDYEI+YjKr5sByAbIVzBfRlYoiRXtwiXa7eKdjpg8X3kMSS77K?=
 =?us-ascii?Q?kLm1bucKKtnBEcHSCC5L/fiP7syRczIr8/cm7ld83CSpHwpGsy2xaNiw4l6F?=
 =?us-ascii?Q?AxbVz4+sZf4BfIVN8XayDgj+INZ8b3BD9KgumYP2wKE4bZvp14CYvji4/xv2?=
 =?us-ascii?Q?6xOvi2DrEdvp89wdZfq1XnE5bgeQPxymqlYsK9SutIcSD4IJ5BcW1vNpoH7d?=
 =?us-ascii?Q?JzUbQlzhmd88rFVTSQX34CxUX5So3QUuxq3yXb+9w8FxpaWouE3stJf9tYc5?=
 =?us-ascii?Q?XRj4XdfyZQn9FfMR24/cQ4i7/XvalrK+NVQFKE9RLtJSBi5q4Fn71tYbZdJy?=
 =?us-ascii?Q?Mg0z5UmcdCFJGLPK8U5p7ZKEm1mLdpwVRV4/U/DLGX+2O9R03O047KOns0Vw?=
 =?us-ascii?Q?jv2s8zaAY7LToRoMceQxKJp6HHGex0MNZUkFvNjU09mwsv/dYNPZMYkuyojG?=
 =?us-ascii?Q?zg9PnxtKD4Cqt/cZB4Pw1xWVcNfhrd7F5uWzXWp8YwxdcN6+wPxW5JmvXetG?=
 =?us-ascii?Q?XyhvppEPZnSzmuVDfBG2jG0Xu36KuhMVeBZLFBliSm4I5SMY5uINmd4GFz22?=
 =?us-ascii?Q?23KSaWp2REU3EzawTXt5loe8DcY7483i+Mjwu4sEb+3H70vi5i/ve1vSlR4m?=
 =?us-ascii?Q?qTbl0Hr+LghKtKug9NIdDKb2cNlQ/tsYMaeNkcJff6pZxN+2oLD/IR01XpgD?=
 =?us-ascii?Q?XesaUontJCKFYiDt15CkXUkbnF7QxfwU55TRyR8gesk/waBb64I8Lptp0HZ+?=
 =?us-ascii?Q?SvcpBDDsKHmK2sSIeUdkpFyOdSUwDUh1ldan/OJsle+y0UfwjWiGmk3EWCQO?=
 =?us-ascii?Q?sKgHUi7W0TuKlEn6W5PC2OjjfrAZUiU/xJV2S3skMLGGVnfmN2NZm1egqaXn?=
 =?us-ascii?Q?4FpuaVXUgpgsIFxbt6lUsRLEj1TzpArQK+WmwUO0aXeuRRuVEVd0Whwebjid?=
 =?us-ascii?Q?7zcMFG9IKukUr1Vjb5Mh0zlxiO39iXDyE3xJXaZdaZwa2xuVD8W06Vi2ZnAb?=
 =?us-ascii?Q?aLXwdLCQxBSWzZ1fDri3nNvJ4SfTstCfWDvoBQiN8boiuQvCe+DVydY/O1SW?=
 =?us-ascii?Q?KfvczoRaIIbG+H7yIU2NycC56ZQV++tLSvmASi9juv7+NFZ4w2IFQfSGs4vQ?=
 =?us-ascii?Q?nl7UVgmN+UCqB8WtNW2YS4a99PeUDHJkqnwvQhZDz+dTCMXRrvgiiVxTgatz?=
 =?us-ascii?Q?SWaTMmxqp3ajZlWyiEZpmM0nB8hnTfbA2YQWxcDuo9ywrRLizPTV9OKHv9mu?=
 =?us-ascii?Q?739Gf7O2y1KtmlbqUGmpGp2O1p3yuIhtf0HDYRvRGk8Jk0S/GgE5CT6pWNkG?=
 =?us-ascii?Q?wmTjeGM0dwek4HAr7EjmZxnU9ZF4AZ2kQwU3qbY8zIIsSmgIZfXrQy4tR63x?=
 =?us-ascii?Q?jNeUp4FbcdgD5zihS2rngXysFWAqxiyhiotj1DmG/jPbcS9R5sWyPAnIkqsC?=
 =?us-ascii?Q?AW0CYALAWv/NyOuhQWjQu+v9eKAqJ3w2S6vYo0uuv4iWeuu9/R9ubpeFjLCN?=
 =?us-ascii?Q?cm5PlIhE8ufJdTSZx4csMMbFB0uLYPHGPw+x6xRFn5PqC0mjJzHohuh4hWcA?=
 =?us-ascii?Q?B0dKqNperosl1kozYPytezSvQ57ky/dVoXh2b5T3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a9d421-b78f-458f-33b2-08dc433c9b81
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5389.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 09:04:36.8159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VCEAXNZwd/k04EY2eA7/nlolJQwKMJKk/RlEtcdKoUOt7IDb/5y9jX4BTn1+8328EHQi+2S+2jgSxh1usvT5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9762

Currently the minimum LC3 SDU size is set to 30B. Thus, if a source
uses the 8_1_1 config which has a SDU size of 26 the sink's capabilities
won't match and the appropriate endpoint won't be created.
---
 client/player.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/client/player.c b/client/player.c
index a40bf66e3..30bcfb95d 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1188,10 +1188,10 @@ static const struct capabilities {
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
 	 * Duration: 7.5 ms 10 ms
 	 * Channel count: 3
-	 * Frame length: 30-240
+	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("pac_snk/lc3", PAC_SINK_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1200,10 +1200,10 @@ static const struct capabilities {
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
 	 * Duration: 7.5 ms 10 ms
 	 * Channel count: 3
-	 * Frame length: 30-240
+	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("pac_src/lc3", PAC_SOURCE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1212,10 +1212,10 @@ static const struct capabilities {
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
 	 * Duration: 7.5 ms 10 ms
 	 * Channel count: 3
-	 * Frame length: 30-240
+	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("bcaa/lc3", BCAA_SERVICE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
 					240),
 				UTIL_IOV_INIT()),
 
@@ -1224,10 +1224,10 @@ static const struct capabilities {
 	 * Frequencies: 8Khz 11Khz 16Khz 22Khz 24Khz 32Khz 44.1Khz 48Khz
 	 * Duration: 7.5 ms 10 ms
 	 * Channel count: 3
-	 * Frame length: 30-240
+	 * Frame length: 26-240
 	 */
 	CODEC_CAPABILITIES("baa/lc3", BAA_SERVICE_UUID, LC3_ID,
-				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 30,
+				LC3_DATA(LC3_FREQ_ANY, LC3_DURATION_ANY, 3u, 26,
 					240),
 				UTIL_IOV_INIT()),
 };
-- 
2.39.2

