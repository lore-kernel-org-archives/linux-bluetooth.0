Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2044.outbound.protection.outlook.com [40.107.117.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C213AD3D;
	Thu, 22 Aug 2024 06:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724309029; cv=fail; b=NpllBqEsv+QLpyqn2Iz+OKNHusVPTZDsU/qIXuCYeZugNrAzqYR8c/JREtWkGNG1G/4+hGN7S9aOo03negzUUwSUmkq229xwM7g1HgYZHzQbdsdBRurvQKyI25XQYTJIUw6WdJVDrJvfb0IfzKh+8VyhCfaTmUDF5X2x9Trk6ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724309029; c=relaxed/simple;
	bh=bU0h7JolrKBjzJBs1oX69KaVFie+lH/LOxB/vv5QCdo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=o7/E1fe7vvCkEb2/cqBgs40VhIsDaZAVhptJILyi9/T6czgZ3zvGjIieGi5rEw5YKwkqvaSia7wpCWh/zDQBETpm38Y59lsx7hCN8lLz8R/7+IZCxYLAany+7P3oa/VuwLUCPjeCAMChORKTa6+pwac1wRucofSFCReI1++HNjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=LkPUR+RM; arc=fail smtp.client-ip=40.107.117.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="LkPUR+RM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDvZcw+grxeainkSUmREhGoKCZX5vWWaXg24L2txz9K0jO3hNktOsVH0y9Jqpyw4fkfLMfv/D73lhysLbUVMXaoWNe92R/GwU67u9bKIRVvmsrfQwA3W70eWwT+UlWLjipgg1lnj1Rn2HYhSofJMFaLTlY34/JeTKptDy2aUvdly2Wx1MXPID/VP4/Hw5eG2qDdiAG4qIqqGgaFv0zcBkwLGvzWoy36zsauqczRdT4i711JCcekepofnYrx1k6C2M9g3t1GuljwIWvyiWKJNH0j7Gx6gEWhMkn7yyaUv/KlKgBJHpxeRZX0ZXzc82XJBGGHpENJ227/O2xe/8/M5Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZXyzoe/M8gtYV09ydkQ+cFPH6fUijh/hpMUeqJKiJ78=;
 b=ShgYnvXTZcLPx9aARuE78yxMGJtYxEe6qP2k1svTS27rCo6lvdJn1ikJxNzvIcJQ6YKBsPjfw+u/ioTgAJ/720kNagQ0blKo471iT9+KhR9R1XnmxToO/9Pw+SzL/u1OUw0pUmzGLcaMLVM1nbEcZ4CPt7B0x1yj2LJw2g7Pi33eZanSXQiGMdsND9sQO75Oxfn5GyTSyTKCBD62QDedvY2NGMBy/92l015ymuAO9z1Q1akZDLOQjGVXudUR7Pzy5YoYVlgGoJEuAQhhZu2+d90+UzHx3KgAb+ME50x7jnTKSui0/GWwdWL46w77riLfPpdUwMrUt+20cJ6Sx2K1Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZXyzoe/M8gtYV09ydkQ+cFPH6fUijh/hpMUeqJKiJ78=;
 b=LkPUR+RMm7QRlwHvoj/SIvFpl28/fSVDrR/S2QH36o4IflMx5V4MFXTm3prSt7DB0OE33W4siRrtDHHbihTfKs0tFzb7VWL2nTg9J0hmKiUxeL0bzJNLDkNrXFL/EFRkbTvsJybe+DJrPGCUctEMRhJlGYJKsC1PLJTcNFRzCzTxx/KyNyKkBUQDN4Z20gv6eUjqDyCqw8GulpRcOHGVuhkiFlFpqFgEAd3Te8oaVY0LIdmLluDhJmXbukEUC6ycYCKLB8rfyl/hxV5KdD4CGXJO13CCGyYADnsboDhJg9H22cbBwb+m6ViCoKzY86cvGq9s29o0AU9Q7oUgzH8XYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com (2603:1096:301:f4::9)
 by OSQPR06MB7279.apcprd06.prod.outlook.com (2603:1096:604:294::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Thu, 22 Aug
 2024 06:43:43 +0000
Received: from PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6]) by PUZPR06MB5724.apcprd06.prod.outlook.com
 ([fe80::459b:70d3:1f01:e1d6%3]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 06:43:43 +0000
From: Yuesong Li <liyuesong@vivo.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Yuesong Li <liyuesong@vivo.com>
Subject: [PATCH v1] net:bluetooth:hci_conn: Remove duplicate assignments in hci_bind_bis()
Date: Thu, 22 Aug 2024 14:43:33 +0800
Message-Id: <20240822064333.1325793-1-liyuesong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0002.apcprd04.prod.outlook.com
 (2603:1096:4:197::17) To PUZPR06MB5724.apcprd06.prod.outlook.com
 (2603:1096:301:f4::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR06MB5724:EE_|OSQPR06MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa6df1c-2676-49cd-cd57-08dcc275c3e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rL4AI/nDeFKS8Lg/E/hmdVzk1qq+d3H4hfAbLqyoA2Q5iUPgfOkpJTU3Y2fT?=
 =?us-ascii?Q?wd8gAiMJ1Ap4F3I5tI7S7vCuT8t3p4D/p2kLAwTg49FhcfsVCtmkxTM2satw?=
 =?us-ascii?Q?FII+xdlSYUOnI1tWJ9n2W3m+Y9vzaInON+SsipgYbY9NF1s+eIcpwbZ3zm0P?=
 =?us-ascii?Q?A4vdqKRQAtfIVfbg6JRqaCd8zyii51Vv0Wz6T4C5jCcFhPcmDUi9qy17J2Px?=
 =?us-ascii?Q?y22i/KV6W/BFTy0RP//w66yVI0ob31lj6ZpMY3ETD4R+x1CYy+wZQffK7o5F?=
 =?us-ascii?Q?ODLuUX83LS7QUAoJqFCJySS6Hxx8bQguvX3p2UiRbMU/Fw2G74xpdIY9XILK?=
 =?us-ascii?Q?B09FlZpex/ibxIHQHOLvEtlDG/bo1DV7gZNctnrLH9w32sQbOjwo611Gp+ts?=
 =?us-ascii?Q?zcZlVjOI33lPSbD4cHY0NNMHr8eFOVazg56j5zOaqeQIehm19Gx/S4i+hVqc?=
 =?us-ascii?Q?z+zdJoNCnYhAYqnUQLM6plJCS6mizT1/HQZH1o+rrdDjRyAoHudPnuoKgxvl?=
 =?us-ascii?Q?96+wXtjHAHsY1PL1tBO1KGwQ1yi8z6kFYWhPsFLeHFeNuKfZ11VmbyML4ovM?=
 =?us-ascii?Q?1SSujqhH/QnkfKiqYMt2KQirkFUsiF4VeXWlvGySMEijBWZs4vdA3Jt5wSS/?=
 =?us-ascii?Q?alFEzp4UDXA+iAMAYrtT3MyeQzvTkkGhmLABKazYtE0HlU2EunXfVFMela/h?=
 =?us-ascii?Q?3nW2qdco1C+JzyEZQZLnOgb7VJ6yxVZHprJ38G6n19tt2LfJw2KncST4MvWI?=
 =?us-ascii?Q?3XhFcwprejvQh6IKcLFhyjsaoEFz/2bOc01tEd8S+8V5c3709T+FGy/qpeh6?=
 =?us-ascii?Q?TKB9rXY8iIBboeKPbl7m8DX1Fp0YE+cn/4p+/WVQ9R0sZIwYEFhDHs8IB4Mz?=
 =?us-ascii?Q?Dqa2SZmrcIl14Y4hyLwJp5wtJRH5eWNBDAFLxLS4b2EUcHbOoiPZKbe21Sv7?=
 =?us-ascii?Q?eebfHSRxgnN63ED90jqRuoEI1Wv2E3vKgbVZtWqJxd+4VVzXX22IHILvnMWe?=
 =?us-ascii?Q?fz1IYXGmcoliKCBdX1BTwyyIYjy3P2QU0FLxffHfaqgLUut7wABQykHA+fQi?=
 =?us-ascii?Q?ttFnundTGFRcFIB5MqVBHMahz0cM8dh4yVVA2PszpXC3YyIKV3atGrX2/t6q?=
 =?us-ascii?Q?FOH/thM/5Q6iVGvCseXVSDxN2CPD16Dk896VEIALoEhi+ctJ+9EFtidelUc5?=
 =?us-ascii?Q?A0IIsnkl624riV3UfYCWYOxgcFRa5ybrq88HbiwjSP7u9f8ztejmHlPsx7xE?=
 =?us-ascii?Q?TFjOgq2HCcXqYLI9MoiVFXlkoLajbpyBY1JnYiRd4A7JigKw+GtzYORoYFSb?=
 =?us-ascii?Q?mBm3UXlNHZPE15GTAg2E+z1bbc9jWHV0WF9GLZlZ0xlUTMS8KTCJOkwioxXe?=
 =?us-ascii?Q?Pcl6D6MYZY4JuSo0JpjZwhtHUX3+qLvt2vNkxLhVfU/jpH5Efw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5724.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l0zjz8/0L46AL3B4sEkPnxpCE9dBr87thwV5ZFTWCcKMI/WQaraJWblWU8Q1?=
 =?us-ascii?Q?ZhlDf96zJ26P9LaYQBq8RRrk63xs8jqrs/gayOP+skUwML2kzdCbmJdiPSxv?=
 =?us-ascii?Q?d92fWkFRKOSJOh9QwnlWmVaHtYhwWJ9zWKgAR5ccA5/NJ3Z1T0FeIo5t4et3?=
 =?us-ascii?Q?mNWdNUXeJSGXOyEZ/B8f0yrrelbBNN0lIdVVY4XWhpepaLxFO/2MD8BgvCma?=
 =?us-ascii?Q?vYwrt23teFsWVLbSVDJJokAFE/AWPb49NuP2O8VtgTfnt9nabDUcUDFQ6Xqa?=
 =?us-ascii?Q?s/cny/RstepuvemDwAcMMq4oHpwr0pL5LKXvvOYg41HhDnUAD9y76hHTzJeq?=
 =?us-ascii?Q?g6vqnV07hdRkq4IK0RWrnKodsuW7Zbp2Mf3oEKpuMYv2lRH9EB/6PqVala6o?=
 =?us-ascii?Q?DkiVisvVUiaegN/qsWNQi1qGlJwIJ8WWfsxmkdWHePetZwerPZO+yG6vcmZW?=
 =?us-ascii?Q?Cdm93XAWArH6SviOfBUft1otLJwBM/qGzAWQGSfwd/Ub3vdF288ON4EtRrBj?=
 =?us-ascii?Q?BQuq1sbQ+y4K2tA/0o/95qQpxEheoEjJiItqsAUQfmX/Gff9ZxA8JK9x2kIb?=
 =?us-ascii?Q?LjassIWOFWwrEFI0oTWGbPlIBqsK3TsOMYZ4JwwKg3qiIbrylLwh5WvHeua/?=
 =?us-ascii?Q?tXgdQzIcVgE5Fy5CZqipAIWaMOBph47/NMKT0n0A9RnEV2xV1HRjMdUCAhV8?=
 =?us-ascii?Q?qlOdti3dE12wlQje4dukrBR2c10XKL9gFCc1y2ZmYQ3Nds3+3IWoM63qKmi4?=
 =?us-ascii?Q?ClHeBxYa1SP2slxO2Hj8nd4vfgNfWl7l5OCRWheKOE6XIozJL7uMqJ1uoKro?=
 =?us-ascii?Q?Jc/vt23ibEk/phSZNtTqmvvW8NrOZw8wJzBhh8Fyvl3bvVHZ3/tioVMSH9VS?=
 =?us-ascii?Q?zkCZQ8IZAtGxDFg7o5GsMKsccvjwp0Ya6WSu754JKOVSzlhg8Ho73Zhuwh3e?=
 =?us-ascii?Q?QodT7w2ea5cNoyekYM0N2s4CnZOAo5UHqj38O7IYFZiVL2tN70d8Rgfk80Ue?=
 =?us-ascii?Q?sLzR9Bm5O+ohVDdUfyMYmjhwiY33JxXgraR/GETfq34+gq0iJIwgJgM/e6j4?=
 =?us-ascii?Q?nCrPtLYE9URItb1eWfkxK1fs2MGArH8xhl/WbuJinMmhT5gQyd9gA9VTiDUr?=
 =?us-ascii?Q?Lqa1T82FEpY6l75IJS2UBQUXXxYBag4S7sPV+Y0Kz7Q0MutnJAPAa6+qz3It?=
 =?us-ascii?Q?S2Q7VUYjnnX8lUJzJ8Kpsu8LfpEZG03ZIoVnKqQzgnNUSIrGkgaJh3VtsBr3?=
 =?us-ascii?Q?k0Swys54TXIP4hItG7/0sTyZZQHB3fpu9fFhtw15jtx9drz991lzY5DVRIzR?=
 =?us-ascii?Q?hMpkBhk0NujduSgtJFSO2uh1REC6xvShprKAzlzwlRi/O6gxBpmA66s02a22?=
 =?us-ascii?Q?ZWPXjbJamxoaqE3/ntS8KtQhVL3/Ka13DIfalQYbFY5T/ZDGFdsvZ2gKQ6OM?=
 =?us-ascii?Q?Sb7UXXmc4MK1isONQmA2xoyEuaC+FBLO5OPnVOMwlKjv/Y5T55H4LAXxnsD3?=
 =?us-ascii?Q?yyKprwUkEcDsfuDQ+sNZxEIFC2ecyx57ZNCt2Tsf/FZYu5BIyUsWtjtOH+Kg?=
 =?us-ascii?Q?gyOLiRwBHTkik9ZGoBIKYAq5/ZilZJjzprVNoQ3F?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa6df1c-2676-49cd-cd57-08dcc275c3e0
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5724.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 06:43:43.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p2lsc74aBtjeY/9EzejNG8k2Hm1euAPI9QN5Qnf85h9rThrxXijjUQ3JvgnwLuiXii1MdHcpI/cjVDGCd6a7Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7279

Remove double assignment for conn->le_tx_phy in hci_bind_bis().
Reported by cocci.

Signed-off-by: Yuesong Li <liyuesong@vivo.com>
---
 net/bluetooth/hci_conn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 8e48ccd2af30..50ff32f0f96d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2204,7 +2204,6 @@ struct hci_conn *hci_bind_bis(struct hci_dev *hdev, bdaddr_t *dst,
 
 	/* Update LINK PHYs according to QoS preference */
 	conn->le_tx_phy = qos->bcast.out.phy;
-	conn->le_tx_phy = qos->bcast.out.phy;
 
 	/* Add Basic Announcement into Peridic Adv Data if BASE is set */
 	if (base_len && base) {
-- 
2.34.1

