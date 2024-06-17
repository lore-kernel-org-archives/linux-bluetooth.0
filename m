Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6471E190691
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Jun 2024 08:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614340; cv=fail; b=Ix3V6zfppoG+6haNZNW0PV7hEp6RH7YQL2RW9o1ml9ro1RHGrhzeJK0z0NvExCg1F+Qc0+LjsvFhqo7MLgHhrEfZbrPItKO2X82WEQz2TnbIYePBag2ZVCJLSXns+zoc5qjlErVVFYPuJm4a1PMLoUqfWNXQiRMUjKdbHaKl7Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614340; c=relaxed/simple;
	bh=FImjvgL2WvU5MAFHrzUdzGEtOqQTEd0K5mS056BqpBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cU6EZAEhB1JNI1UHmeBSOGkFsp2LEWyMvpP5K/g9FIz3P3PLsVn9wzVbJmWJIEA+R/TU3imbtOcApg59A+8SIld3gGWXIeKIUsIjCViWoasGqYznW+fTXNkQUElv799+sXtSOaOJSGUyCAVypS404yf0YBgy0+XivqTaOdJKDGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NEIOLnSv; arc=fail smtp.client-ip=40.107.15.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NEIOLnSv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjnS4xb+0CuYo60IRrTK9/PvNhMwOLAl0edi27mObi8OlPzzy2DR+yCz8joe+io+Kn3WPHozpS/z2+OTm0KMcIkkAGPQEby0i8pt78db1ozhSubGCuYZuCHm2OyAMcUr3nWQLvvv4BYjZ4RV2rMKYVvKeguAO0tS5CIUvN89WtIe4t0ArZjh1H3phgKAHhERQDUvwKRM5AXrN0LdSW2Su3sELSJuSnLnRKdAurNZm7tMLOe7+u5GwjGH60/fUGDIcu4h4K1IpSgSmtKkLi61AVWsy+QquZPFSMqQWiCslMezM5JvlSc7Uw45jUjcs0asFKAd5pKERoYzDJqjrB9ljA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mXBSJVTfbvlFeFdCcLE2/BCiykqiKEeQCd0gN0x5rSQ=;
 b=JfB6Xj6mKm35ryCoHDS2E6vhkP8BdFFL4nE3MXNZjP+jHy04lBK+sCewbi3eYaHIvaTNoKhZRO4hhGBBGHzb7RfP4kmbypjirA/JcNEYJ56QtLT1zPGlzS6CXGYk6TkTGWgWXF7mKFLlEup0ghNj9kSbGq2RhwvSBgnGb1BwoLcvhLtRTlGHboCgRzG/cHDBMbOALaovd2aSjBpvUPkdzrE0t6sb8O0yy27wzbRug1ykqyg1qGz56FcdyBoLhdBWHWrA/FQyXo4r4/2A21J5bVFNfKAR1a3ZzIZrun3UFLZeub7jN/4kufuvs8xlS5bnDGOnVQa3O/ggmm1sC9Uzcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mXBSJVTfbvlFeFdCcLE2/BCiykqiKEeQCd0gN0x5rSQ=;
 b=NEIOLnSvl5AgUTzTXMnXKXmPY+HIpNX3j3pYxpF4Cw1ioW2v00RhvcOmKItuaV5MKy8RUHmBhFvoktRLpZWYG/dBxTGUZmufSDLwe9QYjJ+1VAf3CjFAxVYXWnAq0hJiBswpJAiWdX2MjGAHLIs01OKDzmtyx+UWtNSZ8LOtCgA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB10659.eurprd04.prod.outlook.com (2603:10a6:150:214::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 08:52:15 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 08:52:15 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: hci_event: Set QoS encryption from BIGInfo report
Date: Mon, 17 Jun 2024 11:52:06 +0300
Message-Id: <20240617085206.5750-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240617085206.5750-1-iulia.tanasescu@nxp.com>
References: <20240617085206.5750-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0225.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::32) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB10659:EE_
X-MS-Office365-Filtering-Correlation-Id: 136c4731-f7b1-486f-9db3-08dc8eaac95d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEOZyjaWgLod0H+6C/+GQSJrAckmjHKSPZtuf6SHixb3kT2AXnTwdCiTrPNp?=
 =?us-ascii?Q?n/35KvNPcbVGsBjW44uHSLyTNhHKmweie+YECi85GrSTSzzlR0G5++k3dG6J?=
 =?us-ascii?Q?L0yznO19ELjhWtBHi21dBR+BlLEYRmvCxA7QD5gk1Zgr+2VSIWq0zoEcca2a?=
 =?us-ascii?Q?FafuNiV4bCLTjkOQ0bpju224113DdOEw1LFNFTGslbKtl6FTpX6xv+gVUO6n?=
 =?us-ascii?Q?FqmJLqhHavTbFxb714W4DasikIbRmuHymKcDelnna8iKsLTYuCzokeFlZleK?=
 =?us-ascii?Q?Ma9dQ0qZqYWJlOOEEtJxyTLoxkKwgIHzUBLM44WVdlepDmBR++s0fdGWF250?=
 =?us-ascii?Q?ZDHkHYBgS3E8L1JnEKLuR4xb/HWtys1v/ifD1YDF1L3JPUdplbJfGmklM70Z?=
 =?us-ascii?Q?+hKaH4e8O6Sxcz1XkzH42c0O5HcQtcHUPMkiP3YYSjcilqheU4t6k/TSXqP3?=
 =?us-ascii?Q?O+t5q92m056AM3LmwXvRpRGvNjBWBaiQ1iDk/0OM/Evud4UbUkDr0voZK64F?=
 =?us-ascii?Q?qBbYnIS7Zd41iVlhpJDC7hgBd/TGaykXSO8xGibm00E5tjxDIL0Je5vj0WsF?=
 =?us-ascii?Q?otT59JM1morVr2smtbW3/fB+GvpA64LT/obBmrNjBPE4GPLnO5lBtAt8oR+F?=
 =?us-ascii?Q?81H/64JpBytQ5JvsMlcPEc81j7GGMtSC/Kt1KDcpJkC++gTcdiFj6n2WDPBD?=
 =?us-ascii?Q?g5VvXIbsun+Q3uOiI4PHi5mnPNhMdYixNBV/pQzTqaoYizb2cj+IvrTdXiYN?=
 =?us-ascii?Q?RutrgxDT5Hof4XpaIxwCLt8GNAImdjKbzGmdVtmhLv6Z1GhaH6Yu2yBGSfO9?=
 =?us-ascii?Q?bdk7hgWXWWf1q2klHqXa/SV3dXd/gfe22N1/J5WbzZqWAUjsz6oT/yQEN6eU?=
 =?us-ascii?Q?o2iAD4THBMydPzvR+SL5ECoaJ5YO/h6ZZyfYrc8evNwdRKr7MB1ur3oEXLuc?=
 =?us-ascii?Q?r75JtnahubPKGuggADRgQ2NJ6cJluhxVr3Mt4PvitaM7GxI44Bmltwjei9N6?=
 =?us-ascii?Q?xZllo1cEJPmX75Q/LYQyCxOhL0fMEA5lzgIzEHtfmtVw36YWJhFNrmZKcHlk?=
 =?us-ascii?Q?0y6X8AWYTHgc8Km28klL2Z8f9XMGVtvlQ9dSpqY6ihE+Cs8ylGdlVO/vW+hJ?=
 =?us-ascii?Q?etUCU1J/bopp5WTlKxMSH06VHfavyg04JkyA9obC0YA4EK8PBR3qFSce52yQ?=
 =?us-ascii?Q?jM/KzbRnpYjdV+35BYqc8g+1bqN9j8md+/QQvGH2NYGXvtk07Qnca6disBB/?=
 =?us-ascii?Q?U8ruTP6zmMjJ4xqIzUA1aK4PbCikfPgcBysSSQNSbJhD0LM1Ksxr8fBaRpe+?=
 =?us-ascii?Q?/h81QnBeoPJU6NOkKUOH2LHy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tP1xZIVjcNihgttE8Kfg8R3ggRp0UsKzZ0ImSQbutAvRVPiqA2dW/xzG1o5G?=
 =?us-ascii?Q?oK+hGH91RsL16Rls2foCt3s9FAhPrKp4j7b4C8giGxkCqrrqj4M80rGT6x7g?=
 =?us-ascii?Q?F6y7XS3VJFTEmv8Ec5N8cGhUyuTzueRjJFqj7PH2izYA8zvIXIO+N7i/6Vxy?=
 =?us-ascii?Q?qEY9J8/fmguWh2fZxttGctvedcobyZWM6qOt7ppPR3p7cx8wjsbeR09HmYyQ?=
 =?us-ascii?Q?gW35mlpAj8pvQBDVCSss6ZMRLuipfx09BXU2TOGV2tyoevmgc1Nbg22mtLxx?=
 =?us-ascii?Q?f/fVHoyDxUJH3H+vUcaRkDMjAk1nLS/Q3LRLEbG3SMUJ4gEafE96HkVDNN8F?=
 =?us-ascii?Q?Y/pe4w27BJLJpuMD3Rdk+M2ZPXG7GZ40bnysFCBZbLzJlgnqvddHqvTCjTQR?=
 =?us-ascii?Q?e1PJnfKJ+FPP2ehWzcbj2DIbMcrgy20cpQEllNrj8xIStcqAbi57MyCOGHVI?=
 =?us-ascii?Q?Yf2QDJ7nn48To4gUcNexj5kUseY13hxxQAqTrfy3mVkTytGr3X80Nyb7+3SA?=
 =?us-ascii?Q?SX70UdhGixnk/KfGNE9RIvgYd2UzTyxPNYEEJKSv2XqWHbrVQMqQDpgI5tzl?=
 =?us-ascii?Q?MH99Zt4adac+uSfs0WLaAiRHEnrVn5rr/iT763F2Q6gsyXB14udzTBoFOuUr?=
 =?us-ascii?Q?UF7MrFT16C4MkgMMmhHR8ZZDVBAnAvHme9sOpcTAZ57pakVNzgvn5zBRX1VN?=
 =?us-ascii?Q?lwj1nspC5gF24bYz+kWUktsTQmrjjVwy7Q3j6PYz+qSGJ3MJmfJjCW0fUL9h?=
 =?us-ascii?Q?tH0fU48mYWZIEdZWDyPdYpvw6ctxU9pasUIf6flrHOmlKKsuwz2vSwbeE6hN?=
 =?us-ascii?Q?QtyDBwtYxnaOxQkXmecH2hqExMHmPCKSWq4QJZP6d4ARChTM/uYavou9H6A6?=
 =?us-ascii?Q?AOa5LCiTli1IYwvRTKINmbCywPqpCvfQNn/27KMLPwAxLbh2rJwxXIwAOm+A?=
 =?us-ascii?Q?06jl7nBWVVP1bMd6dDEoXV+S4mgcE+SlVPMLTIp5s6viFflLqlKz0Q1Azn7U?=
 =?us-ascii?Q?bIHWuP6l7tkt07liWCWV0QnP2bOuiirS2OAMoSIOxNKCk0Vmt0zf24j9tvJr?=
 =?us-ascii?Q?4r88Un0Zh9LavfXjQ4krsx0lM3cprSm+AWmggUAx4Tg1xeZ2jBUIPrs2NTnd?=
 =?us-ascii?Q?9sCE/FVpsQJF2m2AwopOW6h7CmX7mU06+rB01uXjMnSlOaYrLfJV1hEHHrpI?=
 =?us-ascii?Q?KXnZFPletSnLj8nOtOlou3mJJ1OrpdmZGapErHMw1J2/ThkCEfofuwAJ1jPt?=
 =?us-ascii?Q?5N5LFQprm23hXMoB0L/AZ5HQfrXzfT2nEF5lizsvmrtk3dy2r3xGrfct59l4?=
 =?us-ascii?Q?7i2VGMca/+pbpKDDA0iqWDMgUm5lYKt86z6DXX6cYQB8WAW9Bx3vlv4DGTBD?=
 =?us-ascii?Q?fEtJCzjPqSLEtFGa5XVLAeuByerhSejTM3G33rb+csSg6F4tiMrCzj2mjWOZ?=
 =?us-ascii?Q?cDVQng2gOIoMT4my/iFTN6vkPPtEo3MwTN/asku3ap+gRRX2LvBAvwtKz3+R?=
 =?us-ascii?Q?Q1XhYIiSTJWOiK6dCer4CKXCRilXxY1GhQOZjP6rVnPxprVyjEf86QSCrM15?=
 =?us-ascii?Q?S5uRW6P8pxzGf1VHBSuTqB0gYBN53usLVrjczOi2mqSZZ+XoaU1YJ1cDG8Z/?=
 =?us-ascii?Q?gQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 136c4731-f7b1-486f-9db3-08dc8eaac95d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 08:52:15.4636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7Qe1kfSwr0nTTLpnRcfifUDkYbeK+6yvIZyuN3tH9Nv/7cfcq5rRLInWw6M6JhPc6TIgyzGauWd5If845MZQJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10659

On a Broadcast Sink, after synchronizing to the PA transimitted by a
Broadcast Source, the BIGInfo advertising reports emitted by the
Controller hold the encryption field, which indicates whether the
Broadcast Source is transmitting encrypted streams.

This updates the PA sync hcon QoS with the encryption value reported
in the BIGInfo report, so that this information is accurate if the
userspace tries to access the QoS struct via getsockopt.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_event.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5d23bcf18716..2908a503deea 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6984,6 +6984,8 @@ static void hci_le_big_info_adv_report_evt(struct hci_dev *hdev, void *data,
 	if (!pa_sync)
 		goto unlock;
 
+	pa_sync->iso_qos.bcast.encryption = ev->encryption;
+
 	/* Notify iso layer */
 	hci_connect_cfm(pa_sync, 0);
 
-- 
2.39.2

