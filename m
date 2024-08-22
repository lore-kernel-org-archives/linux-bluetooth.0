Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED561CB302
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Aug 2024 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724332390; cv=fail; b=BzguJmW+CWMlinmZMHK4k0j4OTIHzGP+b2w4/y6wPpZ6L7zxkrz1yXZBdsypPFn0hbOOFUmEJbg+2In6f30EVQvQGF9m09TXzMMEbFvjZ2qHViGJ0DEW5Z6pXXvhayj0jezXV8DcnyxaZtDFEKZC3ebOItThmu8wTwUJVieY1GU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724332390; c=relaxed/simple;
	bh=cBh8JA3exI/pu4B6FF0fELAZEPkTKtmCGbNWIFp9sWk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JdVY8mhIdCxpUWTqahBhHNgICdnaFmIppKHqV0jiSKcwkpa9pYUA9v9XxjUqwxSW+0aSrioh1nALbAU3RA2HNXc24EjJb0R9QjkLNLYDAGhtWsO5lpBc0AfSxKymP0zMcaZBA2v71KMjxwLKLJxaRCATSLr1hzzO+OXTzeDiXOQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a/Tq9gNc; arc=fail smtp.client-ip=52.101.66.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a/Tq9gNc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mkUOWuPB9sUMie89gzn+KgL8xdOlIjtlqPSEcH8cGLZJipHZa8o86faWquxpOdYIsxfZdM+z2POMzykyIe2+BA/MJiyUvUi5XiEz1DTW3NZ3a08jGLsHzN3ipGyUstywLzKS+rFS7HNWiBmKIOIvXgDCdIRtrR+xw+6HITg5rZjSx4+ZB8iTTpookjKxpMDfVsM6zkxspxox3NfRZimSuk66unJ3HHKIa+FbnL5RbV8+4huh61E0upQIM89dSbdfmqIGXKMjIBmBFBmqjcV4TZ1/Nchd0FLMg16tvyHqc0fDnQS15B2NRYWWDgm/M3Jir70SK5gGqzMV/uUx5zkP3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0OFVizNoRRLM7UYnGeILsQoFo2SDruFPXAMdnn6wNk=;
 b=FbWH6cTNZH7xDZKQGBe8AdzbjdP3UmZIUzJ7bhdTAOtlu3fLW0BQ6qGKf8bkCuBG/zCVBqhBQwbYLH26zI+llkkQt4CvZoV+WmGnl+XLeDQdKpyzw4knJEFlPB0z7SBIqM/IV2oAb6FFd6hguMZWoL1Gy6t7FvrQN5F2qnDTtibpFvJfqT0FBCfnDYcywIEyFq9xErQSbsw/j60qHZy5nEgH2I76XpTG2Rtkf5D7o85KthxoTf1k/eFT+8PAy4qA9bN/Q84x27DRbGuQJ9VI/d4vDide883Zo0mKmtHlSQKx0DwGN64Fi1CtFfIUj8yqlzdEYwvfYnpwoVhDWvW/dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0OFVizNoRRLM7UYnGeILsQoFo2SDruFPXAMdnn6wNk=;
 b=a/Tq9gNcyhfkeO3WOgyOK/y7HsShJ7rwJGAHI8VIhq8sDuI5dXdxSmKK31AyiyBWgkeDtLs5t7DOYfMRkXEF58VOmkqaaF1J8ZQ7BaTGcnWFsHHabCDINzd+6vb6mZMeZwvWKSd1v3OASD6wqy1d27ig5AYV1zg8d23Z7xmP/9bGl33zRstZpSqH9ubfty6nQjbgi2guwD2j5BJcIPPR2/SzcIp0yCmw4XooHVNbpLb8uSqG3G/WOM1nLsiAg20IAoFJc0uLHwR8jVQQCMgLNlnovynOBt5iW6ezfSODWa6Hq4DxK+6kBYJVdaIvLINVFvz4NDEIQLejygDNWR+6rA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by VI0PR04MB10565.eurprd04.prod.outlook.com (2603:10a6:800:25b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 13:13:02 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 13:13:02 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 6/8] shared/bap: Enable set qos method for BT_BAP_BCAST_SINK stream
Date: Thu, 22 Aug 2024 16:12:30 +0300
Message-Id: <20240822131232.531952-7-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
References: <20240822131232.531952-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0034.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:47::15) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|VI0PR04MB10565:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd9bae8-71a8-4eb8-add2-08dcc2ac271c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ed3iKo8I7xGV9Ny+QpIm3HYpvw/VAFcH3j+ttqAYvkcUWKytxrNxGrvf3f1n?=
 =?us-ascii?Q?2XrZPJVKLaP/rQGQ32zEboOWwknHYH8T2o6S620F2fZ04rixw8aKOsAjIOl+?=
 =?us-ascii?Q?2Hxy8oFf0xVMg/F5QpuOk8nUplR3VFUH8gbXbDieYUsDahgmu7bm1RmTSCbl?=
 =?us-ascii?Q?XhyyDRtvecUAg7b5Uk4SQP5FuFPPjprr3jbY6OxCj1rOr9P5+IH51z6E/ZxL?=
 =?us-ascii?Q?qM+Yg/eePIOd4guivHe+YpBdBbXiyGStJ2WzQyLY6uJ/vTijlJO4FWQFZ1+u?=
 =?us-ascii?Q?IZqVs9hnCQKqMBXPEADqDir7hpUN0r5vDBr7Xy+oVFhA9II2lnc8QGa9g0J5?=
 =?us-ascii?Q?VeCt0xXlwktKD7KWEeCeeJeRVXrvqy8qjbWiVI/WY0rWjpYsFcOENq6rj+bd?=
 =?us-ascii?Q?crNamFNQWpJgB3zrE2sU33gAiCeJlCYrNWuyici5pYwVxTGkmGvgWVtVoeps?=
 =?us-ascii?Q?WNI/6S9OIm8McxYJsihdY/dWln85iLos5zH48DE6cmnZu0kOkSdofxtiBcv7?=
 =?us-ascii?Q?2pxskVIFeNMigME5RbLtPaBlsjA5+8zqEqI1DfKdi0+AW141VaQqnGNeoM0d?=
 =?us-ascii?Q?uN66zRW5XI02eLgiZ+pB7oT6IreKsoFqALvuJ0Vmy9M+5iELaHtTx6S8eqIq?=
 =?us-ascii?Q?JWzXzicDBgiK4e8Ab9NuwLeNIig/cNM9ZEOtJFXncmIFLFwjCctfSXxLToFn?=
 =?us-ascii?Q?XwLCiyuiHq4jGMoPU4cjNC4KHRhL82zdDjbFw/RQYl3fENb+PNrEcqLgLjLk?=
 =?us-ascii?Q?fdWgMK8y3aX8I42rhvAihwU11WSyLCiDZjCFuAjzqvz6b2nGnX6j2P4xJNb7?=
 =?us-ascii?Q?Q/Lvp83KO5kaLcFlU9bNfm+PSx4Ncl3ogZ2YoHMs1RW1YX8MGAnryt7nVquY?=
 =?us-ascii?Q?Z4vOfAEHtZIhi5+prJwu02piDJO/PdttzyHWR9iekHl2TWA1N7gmGRosZE5Q?=
 =?us-ascii?Q?diWElsyjX74JB3CBVUhX+rSCkhSnT20VT1M3pmwl3pqobWyntxCn/3x/tP95?=
 =?us-ascii?Q?mAqtHgvCSuYhLSBRT87LtYrueSMdGFLiz5tK/M0gLxbc0Bm8xa9wlWBN/6wH?=
 =?us-ascii?Q?glF18IDJmwXk2Cr2MNSyBIwN+nxROG+yzrY/fwjkk9Hi46wayPIXvJBmufaE?=
 =?us-ascii?Q?a9yHMGdlg2lAf2+fcM6N4lFheGfNKbthrFUEev1okiHlXWME/gNgnRP45wHX?=
 =?us-ascii?Q?0KpM1focFGFab+3dGkC6z7qNhrDjirxlBcZAoVvAZSGphjvgFfiP+/jZu/H7?=
 =?us-ascii?Q?zxIlZzvJvW4w669f/DyAAHu5GWwii9S3yqAnihbf71KvtWDdzaV0eC1V0pS3?=
 =?us-ascii?Q?HKWSOBcg8BImMlAIdCdIrTcdOl9b9A1FQTRQudIJNKZI5iTXvb7fR/dhBOjL?=
 =?us-ascii?Q?nmP/KedR0ejuef30x/n9tlnF3jsCCSF05YeNl4jQa5gcGA28Yw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jlFBCYXUR1K/l33+0TADW28DZxjycolTGhnhKpaVYMLlMBDYDMwALC2p0l7O?=
 =?us-ascii?Q?BkuZOLY9JHwLVhz5dTHBE4dR6Q0bynZMib+FfCSzaZNM4KNGqjg5NcypRXIa?=
 =?us-ascii?Q?7LyqnPkd7TXvrNkpRLsZTC94fwm9CVvEV+4xSRZljeWtvj7tZpH7QgTCKdk0?=
 =?us-ascii?Q?X4VQorJeJjOUed8Eu2wVVH8xmKwb+vjrn/v7G6K/gCb8ARGntUrHb1TuIldS?=
 =?us-ascii?Q?OLcQDmSGeJQzwJWVNQC3C6R+wPdqZsmSELCbS4dTCXSIUlhL/EqLGd7fOvnO?=
 =?us-ascii?Q?sZw8Gq7wOMdn1wvw/ywq+dFPngsD5CZ5hMfcHjBxGexZpW8PRPJ8uuLIb4q9?=
 =?us-ascii?Q?ZEH1JFi05/oxWHXpigChauMoy00A1w+ceJX62fI4JZ+/XCQS44uouk/D0P6/?=
 =?us-ascii?Q?ULu32K4+QP3Cv58GUFM1h5UGmH8fZKKbVx9WkAcRH7xKE3dvntFG1f9VPVb+?=
 =?us-ascii?Q?3DFUUmU/DyO6PcaMmgpxl3LPsbVoIbm9aUXpAyb5WZhqsaBY6Il43WyrxASv?=
 =?us-ascii?Q?Ke7/O/iSXUeXJX1airXRENTkMHNv0bj2UYLxAjnOJxbpTe6mE/OOwzvv13Q6?=
 =?us-ascii?Q?rf+wJAtYWeCX0oOixJG/RDalYJog/Udf26PaPNRb+/IJ17cSTPln0uLjndea?=
 =?us-ascii?Q?6ppTPq2J3OzrNO7y2a5490rmk4O4hgM3sObC0Mgg/jD6cmHGPeygrlpkhUia?=
 =?us-ascii?Q?jFFR9TNDFnXcMSrmtczTq/q+Ms8cuVDtGwo3IYEpVbBDQoRobDHan5NlZJrz?=
 =?us-ascii?Q?O4wYQxB+pjI26L65DzyruMj0XjU4/G31tetPsw8HaC2D/jfmVryQjcdE18us?=
 =?us-ascii?Q?/mvqp4D2EkRlaNgZ0F0lmmRUaadUtLdiWZOP4E75ChsY/FBRjKYius656oET?=
 =?us-ascii?Q?zVAYcvf80N9d1yG63++F6RzGsOqm2zM75TfGfamuMTGeEeAgyV4Guc0cNlNc?=
 =?us-ascii?Q?gWzG7lFvsIJPiuwbsrrjslbJsQEIm2Mg60UqyjrXTb5pldpPNHIJhrpLE0uW?=
 =?us-ascii?Q?fIGMaGd2Lwe6MYGuTNavH4ufo0nTi+ItRz5kNUEvvnhNdsLVZy/DFSzYn0Oc?=
 =?us-ascii?Q?5pfblPLxzNBbyQjGA5mz0bazMd+86eMAENf5p8VUS03+hVsD7dKFK+Cp2Obq?=
 =?us-ascii?Q?EC3uYxZRuKiGr0HJ7r7NwAIFrWzj9w8i+004WF8AMdMVZJMp34DhLEqkJOl1?=
 =?us-ascii?Q?Qg+MCP5keTOX2bQ3pdkdJelajSW0YMyRdIr0z2+R0yqW3PCATYqwXiBQFNs5?=
 =?us-ascii?Q?6HB/SQZKk2dcr9doisP5d1hFTiTx/7UpD2HQ8CPy5xTkarJnyMQ775HIsHWR?=
 =?us-ascii?Q?QTOJRzuFzSGY/EvoEUIpHDVUfoPsPcE3tBadqitnpZf61VM6GR3Im1LXhwlq?=
 =?us-ascii?Q?nOvcxqBKPud7B9LHglxJu2mRKIYuhJeR8cpJcTTQenGKC2P9MbwrPdFbDPGT?=
 =?us-ascii?Q?RBQPC+3vnks4UafKwy/0xFnevIjBj+NXo2VrWwPkmAliX4aR9v4cuDAWxmqh?=
 =?us-ascii?Q?55JjREXW4t88MGAMBoNzjmL/g/lRYfyJxB755HQ6475LYBJ7DvXXlhErDDW4?=
 =?us-ascii?Q?GYupSD670zhARvBloADjwKo++1GFGX3qY9yDCx6o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd9bae8-71a8-4eb8-add2-08dcc2ac271c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 13:13:02.7710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pCzs9i0/H/2CHTGL0J1t41+Xlcfg3SbzNH2cmCvdsl8ARYdpxbHEaI9fMPG3a1gPEG710wiGBppxhH0p3laYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10565

This enables the set qos method, bap_bcast_qos, for the bcast sink
streams as well.
---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index a7217b417..97b96e49f 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2243,7 +2243,7 @@ static const struct bt_bap_stream_ops stream_ops[] = {
 			bap_ucast_release, bap_ucast_detach),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
 			bap_bcast_get_state,
-			bap_bcast_config, NULL, bap_bcast_sink_enable,
+			bap_bcast_config, bap_bcast_qos, bap_bcast_sink_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
 			bap_bcast_metadata, bap_bcast_sink_get_dir,
 			bap_bcast_get_location,
-- 
2.40.1

