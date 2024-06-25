Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4CE146A9D
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300455; cv=fail; b=SRSC/eMfa/UbL+4vS1/X+54mQ4EZPVcWd1dGVEcW2oT8Rw8lR60CyHdkzHJXMZd/GI6+gSHaz//kEQJvNVLsUepmfjR/Ou+Jj62EmEnaQABpNMWKHTpvQT8v8q1q+hGqYgWNFBRYQZ1LOywEMNo4WYN0dNrJhuM5hzJDgcivsMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300455; c=relaxed/simple;
	bh=gwfpp9sxHDiUvLKmL9FVbsAhzovsKhIwr8Hj24Y9icg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dAh9LDlkCcZz9LwhrIorpH6+5q2DwxtejGZkYxLVHRvcz9K9JCbq+T641dRFEp4O0DVpXXr6q0VSdV1w1lNwR9MojODwDB4rmbQc3ENWMTXHvbuMY6p+HxyK4gEztBCEXCaE1L2TSAwa/aBuy3v38JNU90ToOckITkqE/1dqkc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=mak5tfpI; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mak5tfpI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiQjqCbSyBeXtXhDzc0+3bB2wSSTxNsUGnp0/qjgNOQypBCr3lPQBqzeFLtMT3bNWBZlMuWSM2jw2aVYklP8wja8bWAGJRrsp5ZflH9jcv2fFcGYFlrCWz8gtT9yy3ETbpIpkBJuXrc8xIh5BWwjfQepIWV3Bu9p8fR3e29AT8Uip1xSMNhtpTEHe8ypbhvv5ych8XLEB0Cld5wpksS+L9ByPztYUtXH4mpnW+asLktAHy720OvN9wDemD+A9sEOLcFTQTNJkm+M+5ziPqWHpnf+31vua0AGPjzScjKvOOH3QYrbpr1bZnGcpLBN5Cgx5YrD0b3sCnvbxq6akzoIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYJH4tc9GlenC8hERXSm58H0qSTkORS5W0Nvet+JFd4=;
 b=gfU/bNxfUANHGWJVh+L6L7fWsQgJA3Krf1gmT3kA1AbwbmZDsXjGic7rD78MxyH3QJa8Jv8oMkMKoxCuOqWh+TNBdq+QU3vuINpGL0bTwc6SfA7TfJZf0sEgnNO8OVTFc8SviRzxaRmNTI6ZzWFrdcbANxQfM0GDcIP2fpZq4h2IhV7a/ncyp1MlLUlXNbznE09JqEWQShWkgRgLNfLkZ+PzQBbPpRyQs9PCW/dRhESLePY9Z8e//iMdtBK3u/Rsq5mEWa95voSfXJtp+HnEw2qoFLgC4jBSARPLOphY1hXLIH7RsYbVDETRS7oVbV3WUVfGviYekQdTcVqWVRg5gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYJH4tc9GlenC8hERXSm58H0qSTkORS5W0Nvet+JFd4=;
 b=mak5tfpIN2W1zU4IP7uIRDX/ZoaFIKDesMM4nQcVmpi2hNqE+pbm6ZisTt6a3JT6RMD8IXSn4TBX+P4lwPP/Ncnue+6fwub+9CekEXD9yXb8ESbGtjd2CaY0eoIh0RPNEG/jZ+/aZPNVjMpQEcYkbZfVhNIJhARzzpbMfpnjtX0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10362.eurprd04.prod.outlook.com (2603:10a6:10:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:27:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:27:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 4/5] shared/lc3: Add defines for BASE with multiple BISes
Date: Tue, 25 Jun 2024 10:27:10 +0300
Message-Id: <20240625072711.7011-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
References: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::13) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10362:EE_
X-MS-Office365-Filtering-Correlation-Id: ab2e3459-9f01-4ced-d9d9-08dc94e84575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P97M2li+3LfSbAkmWx/zHkRq3hi98+UA42npM1N8JAGMHphL8lpR6NNk0Tyu?=
 =?us-ascii?Q?riGFXgW96E9OsYuzWFq2+yJOoHKGb6vhKOrklJTTaxfnxyOwL9qwFojy+cHj?=
 =?us-ascii?Q?wib8qdIlN1bnS0Bmc75iRhcR5PysH976dhIBctMeept6Ft3n2L8KurxdsyQL?=
 =?us-ascii?Q?tCiCzfLuZ3YDh/gPcUVd8Hrd84ff/hNlV8at34+hpM7ZoCcn1mJaCZrf4DEg?=
 =?us-ascii?Q?SxxaO6yfdhjMcKbkM6X5Hlr+CL8TbsXtDnerrAsVrdvpvXBZ/Ltsjz9noPFO?=
 =?us-ascii?Q?dPNU4FTxxcrMlv+iCsUuTHmzt2KhHoqLYnb9JU0AHK2GspY8ItnQtDUFNtL7?=
 =?us-ascii?Q?4IFJXGolgjbBayA5dzpTMea91+BpuaV+j3N3Lu6vfyVJFBmks3nrn7oY3gcD?=
 =?us-ascii?Q?krPUzi38kiHbN0meRJK60yJxeKBQskOTFDyN8Cg0XWUaNjxvR7a/Wohtn6cw?=
 =?us-ascii?Q?6Z31g8Fv87k4LC+geLCzfmI31VelIp5Qcp6SF6Hb5PKWOAq6GCyccnAKA6yt?=
 =?us-ascii?Q?v1ZZ5p0LUo4wYlBzBhIoyMgRNiYRFJP8mnLtT3P6AriZEMbR7hOFTmIB/gr1?=
 =?us-ascii?Q?BqODqCbCFmhAOUY5r+rEh7Q7DSSXuNfuRSbe7GNn5pxyxMCL85ziBWvmvSt5?=
 =?us-ascii?Q?2ztppU+p9LlOnOYyUyr8hmCMfOa7r6BuAREUZjnDalTCufvo/Zk7VA2IyzNg?=
 =?us-ascii?Q?gGK27T6Lu+1P5UJs/hbN2d2B/U1UmSovbDi7jbpZM5EiFXtFVLSDJwjN7BG8?=
 =?us-ascii?Q?wRyNR0QMcqFvCaDNDy6vujpgLptm3Qg+dKjSM9PAAUmnYl7AOKWXLv2RHBXj?=
 =?us-ascii?Q?UHYyF9Jfne3Gr4oT2O/K3FwgkQ8oEw55kv+zheFHSsMtkltgKnybJP3qemb5?=
 =?us-ascii?Q?+BdelvFfEvZzWlaWt2eB54Rel74UjPGaeKSh5+p6QN9EM+NkAkSC6hZOjHrG?=
 =?us-ascii?Q?kswFokZij/tR+rbgWaMpH7yRH4Qa7srZv8tiPEsdfGCbjsfeL6Di97xy8SJ6?=
 =?us-ascii?Q?cD/wC0ddHN5HoZWTu0jWK9tObuyi0b3dqjN2/Z1fq8xoDf0Cev6wuBJz3rmw?=
 =?us-ascii?Q?flQooKtD5I7F04qXn2MKBQYv1TFdDLMMnSpAleP7ghHT0OtO1V1pKix3qapB?=
 =?us-ascii?Q?UaRP3l+naQBzml2OXzTg85xIXpX5YSiKPUn9l2tGB4CXbW6h0WC/Kq1ZeNEg?=
 =?us-ascii?Q?MPCvbRxLlpp4BhMaDF1AbrkxsqTY9eiT5ETEDTWsvk3hhVrKQzhOfBssz6fD?=
 =?us-ascii?Q?gwV+C+qrId1D5IKbheyenTTW5FneWrKYEAJZ+9N+HnfSu7xrOQm14Bo+SLi1?=
 =?us-ascii?Q?Df+3UbxUML3M2Eqs+SX7EfFk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOS8iA8Z7MXGHSpkWjewEiNKGXnSwx7PWj7Z1myAN2kB9IkmCxloVpnKWgQx?=
 =?us-ascii?Q?FmefjlCwWcTpqokosKhGOcp1dbV90IYAgTIoj9y4lEbZEOLJW8k69fIrd3Ts?=
 =?us-ascii?Q?66/wtIVXa7SiOmREmb3TZtgzjVOzA+YGqnayYHe4MYoXVy7acUjD/lBrcCbd?=
 =?us-ascii?Q?A2L1wDAN2zlKt39fbBoHOpyGA/ZDJkG6N8lN33F0/MHe20lwoWssNSx33BNr?=
 =?us-ascii?Q?uqk/Y6p1qNGm2YEj7rr9OU/Lgd2SfGnimqgSmTSWWoQT4Owl3DxCNRWpxYxm?=
 =?us-ascii?Q?8B5J86ed/xmzVGuu7/dpB0M63NCgLgm9pkVlLqdOkvg+JmnM6jyPnu4fDsuB?=
 =?us-ascii?Q?hk/PY8ZWfLXwam6jb8T17fJNHwuZC2G28cluo2XWOx0UfLW/wOC/tZGZKJJf?=
 =?us-ascii?Q?sqVDJwwaO10MwU+bRz79Cn+0CZFMLEoI+hofEDBUNsw+acIOG/E+7wT1XInf?=
 =?us-ascii?Q?UJqf0uK6JjU4dueMjbWplFPOidoLSfp2YzaruL6cEcr5HlCrdDQgcb5FjSwS?=
 =?us-ascii?Q?ZzjVIKIsT/8jksXWb5S5MIKJmfdV5DstVS3syoASncfb7xrrTwMGnF0gJcD7?=
 =?us-ascii?Q?2v2w/fCaCGz6myNXcbmYroOE6r1xBv4WztZO+bvhjRtz7RHh4lzgjHdM0QFE?=
 =?us-ascii?Q?btabFMLxlRl2hv63E9T6MRd6hudYzVkEep/AAhiEcBVFfZRFE+QtRwFi2BVw?=
 =?us-ascii?Q?SG53rBrz88tTvRHBsUTgKZsVC8bY9TBkPcJY5qcqtnQl6F9/+6VXK0qup4jX?=
 =?us-ascii?Q?MuCX5kOUVraLQHIxKW88TCjfS95PvK1k+HCql7VYfcN6RbzePYtGRhg/OYWJ?=
 =?us-ascii?Q?OWStwYYj9GimLfP6lYDZ0sgVDDbMl9iKsi6Mw9uU/MRF7NtiV/jYbsG4NBSf?=
 =?us-ascii?Q?OX8hwN35HSCWsWN5IuSh+KOL0+t+U/X23fW+ARwGs0TF4v0Sb7tEFelLoUF0?=
 =?us-ascii?Q?z2ZV36aoFB7xi4+QP66aF7hJBvUrj1Ye09zIjYjOeVtlFDvcXnhuBfy6Fl8E?=
 =?us-ascii?Q?oOAqyrXwWc7rEQe5wlXpPyfFrkMmn3nL4IYSatJI1czpoF6ifMqYkyOATYP6?=
 =?us-ascii?Q?mN0y4SLA+xLS0e+2eQIEqIhC1uK9yhaft4bc0Vmhu8Bx725r/7YZR87SpgqR?=
 =?us-ascii?Q?G+dzmutWTcMODXP/bzErGZMBtg8FbwjMMQB/ienZsPQwGVGhyV4UURP6BxQ9?=
 =?us-ascii?Q?52lU2A+TlCIk9hGhn+rIqf1lOVi/uxEXcX3YSZoJd+NqxQzmoS4h1wX9jWpr?=
 =?us-ascii?Q?Qxcb/hsXLdki+O5zJmeeFTYHtiPquVtdXx0zQTi8SyAaktq+BsVy6awD7F1w?=
 =?us-ascii?Q?dIunZPfzLNQqu8K+pA+OdWYTbgV3J9V5krWR641wnbh/S50gcAS+rhW7Nttu?=
 =?us-ascii?Q?ywSD9nfYfDRSByM757VF0bIrIDobCccWOpbMRPcuHDQpNGf4ty7WUgzJjBcY?=
 =?us-ascii?Q?nobMesW85wbU3nlu2cFtfXqzrrHUICiV4s0sfJoXTeGCKHXhUExhCegZ0haD?=
 =?us-ascii?Q?K6WqGvVMnwvqTrQG0vvs1OA35+eWmSNVxc485JR+m5CBtzkgbZrOcpvDv6CT?=
 =?us-ascii?Q?rmq/cI92TSh7YQuvkNrFmsb1hQPrQVUfzG6N2A4tCWW6V1vm/Ux4G9msQqUE?=
 =?us-ascii?Q?oQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab2e3459-9f01-4ced-d9d9-08dc94e84575
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:27:29.9541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rHffy3FliBQxl7Bt4GVhyHFNjVsGmm9hGkWKa03QMM3VO3AH2j0peYr39LGrtfhGcYnpOPDPj7jzYUJMj5750Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10362

This adds defines for BASE configurations with multiple BISes.
---
 src/shared/lc3.h | 53 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/src/shared/lc3.h b/src/shared/lc3.h
index 944f574b0..e7a9277ec 100644
--- a/src/shared/lc3.h
+++ b/src/shared/lc3.h
@@ -425,6 +425,59 @@
 		0xFF, 0x00, 0x00, 0x00, 0x00, \
 		_cc, 0x00, 0x01, 0x00)
 
+#define BASE_LC3_8_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_8_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_8_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_8_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_16_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_16_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_16_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_16_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_24_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_24_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_24_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_24_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_32_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_32_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_32_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_32_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_44_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_44_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_44_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_44_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_48_1_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_1, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_48_2_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_2, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_48_3_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_3, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_48_4_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_4, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_48_5_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_5, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_LC3_48_6_MBIS \
+	BASE_LC3(40000, 1, 2, LC3_CFG_48_6, 0x00, 0x01, 0x00, 0x02, 0x00)
+
+#define BASE_VS_MBIS(_cc) \
+	BASE(40000, 1, 2, \
+		0xFF, 0x00, 0x00, 0x00, 0x00, \
+		_cc, 0x00, 0x01, 0x00, 0x02, 0x00)
+
 #define LC3_QOS_UNFRAMED	0x00
 #define LC3_QOS_FRAMED		0x01
 
-- 
2.39.2

