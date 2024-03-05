Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2051.outbound.protection.outlook.com [40.107.8.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDF78615A
	for <linux-bluetooth@vger.kernel.org>; Tue,  5 Mar 2024 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647808; cv=fail; b=qpEgow1xtGa0IQj6eTf09jPwcHPV6rP/jOycrgDrlseit3jZndYBp9d00Lfls/cWNzQBX9nja5E7oJSyUCTIGiHpY/J/GRNSZw/3PQLwigaEZZTQ9zwIbj1LZ838sxXAHOaHYZ3MB0VcG6LhpBPaB02P2WBOrnyaFfDIthqUe3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647808; c=relaxed/simple;
	bh=CW1qi/4FX90EmE0+ML18xZ9n/uk0cttZ2GhZ//t7kMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mgBIpMSST0+9fRJXCeJgZpFmE0LXgtrMp9d0Mknk9k6Ha/+CdKTYIw4cK2gqoHgBzbLMAzAwD4WJr8vVM6mzVX+hhFRY6cBO47EUJHHm9LXtTkN+mE8pmYJkObSygOd+EYoPRrjqFUp7UqVd1/KBBQc03ojX7MdTNEC1z5Lnxko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=kFFD1aao; arc=fail smtp.client-ip=40.107.8.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="kFFD1aao"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsH2vJbsXT8kAxqjuuk88QTzc7kAgGpO2BgHq+A2B0lS+gB4BVEeg9BSF4zby2eE5SqpdaxvjJORQlshPzO+olxD6nMhh/r1Mzu/pVUSnxZVVuOCAgy/LeEe2x/OYu8Tu6m/Rtd4gpRHsMbnrxVFo5A3Tm2YnZpjOEIJS4Dd06B1NHWB/McGbDCsuMPEPG46cRyh9VxzBIju/F2rUy3zNpoFR9XRyEATniEjRMWu2cXraWAXXbZpyNxQ+vrPaao1KUHPVFWxH3BywtdlhRm3s0o/qcmULl/wLMDsg3DenWNvX0CRHrPoqW87YUYnu87Z2Z0ospkl592KxG9duyCUPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9s9kCEbDFisvcTOMvxfI9WEpwDB2cBJj70G5Uv4MYo=;
 b=SEoBqdpRcUZoJ920iJvTzpeqobix9igjgXBoTUC/xEDBWcO+zu0BcsocuNmgVOTE4ulucQuxUn55qQdqJzrUuFRfkNKN0+/llT8E3dVyihhe2/XLU0HIb+ZmTRyo39WLrc7Sl1+7U/XE8z3lF8UldZvnrc3YRaGR/PWpk4WgcCTg0/VLb6PDsAiHhRbDfvMZyZnhB0PfBnYZEmkSx7tCy/33OME9h0mTD5GzUqPsZFaigZwU2vGc253nbnNOjjFYr7+6VfBXEyCcH4FFx8/lXGIFowQuCiMaTpdoD0+wH9fsyj3tK7MLhyvkEhA9t1Y1RzUVBlGFEkZYbNqYeeib8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9s9kCEbDFisvcTOMvxfI9WEpwDB2cBJj70G5Uv4MYo=;
 b=kFFD1aaogDGm8a2ZK/Rlv1wMb74md4i3I6ZKNx2sALnRVdgiQr4dW3cMLHh4nLfYSVWw+px3YDz/acU8ceTBSkSmv5Y0cmbwGwK2pyL2gWDptVB9sD/YlOXM85NGfn/+IL+KmkemnhLNL7dTtaJtU+kJEK7hcbmDxDTUeV+Eb/s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM8PR04MB7410.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 14:10:02 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::c65:a818:c6c3:679f%6]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 14:10:02 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 2/2] Bluetooth: ISO: Always release hdev at the end of iso_listen_bis
Date: Tue,  5 Mar 2024 16:09:39 +0200
Message-Id: <20240305140939.5090-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240305140939.5090-1-iulia.tanasescu@nxp.com>
References: <20240305140939.5090-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM8PR04MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 20eab53e-0251-4c64-4826-08dc3d1df357
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6uk2ODog/RhX1JBuKEsFda860CHN5GO0FQS+4TV68SU0PwMldnJvXVf87q02AOzg2gDSci2jTUkMB9bHwY2kaUvx7ewyHdTff91JT5D5is20+2hkwh1tMWdZWoq6UfcWgeCSASZoZRPl4k2h/tKUrR/EKTpK3DMFXLajJ1rbAoTIs+KMKKtbCBLNs3Ucl93rwXyFDcgDGf1+3ntXI81DjXBUjL0rI6bLDjoSjsv58r3ObNPo1LhtVF2vWs+O0yYj1Ib59HyvURGX7RLa/o7G+T4xUaPnVg0h81uwibmFqUAlQ69JXg/Yii6oAH+ozQne/xs6Lpq2R5d2y4PrhFhShagpuCjGVvBPdeobvbGzuk/J8bx+YfGRNs5Jn8g/yMp2/9L3KbHbhPuzvnB1RIfFg0aaZ1EnMSVdDwzRMBFW5n7a8+Zg7yWAt/YMh3UnITccYRYopHmemS6uRlItdsL641fT1g3dcQtUEW5glLX2LIxx8NReS+mNiljkz39uIp6ZdjjV+1QEUzKQT5wds44j+jsZ0caV3g+DwtCuV848PtCkaN8yB3hCqJbkjQkcC8YeqX6k/ZU1hRAJyAqMq/8Z9nBdmZ7yQQgBG8/RbpQpokVuwX8LCqdLDZBTGyG+ZzN/3XtLlDO17X9Nv9CzeRSftk4sIuqH0SCNTV4XhWjRzoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?du1mGbZ79f4n6Nu/lcctr0HceBUsU4unfkEzc9aN4dA1oaG5GxBkriJAJ9+D?=
 =?us-ascii?Q?q5YfzKzO269+jaEeucjPXlYNLwUpi+KaGFT0ggmuVE4knfaM0cu/sE9qmqRo?=
 =?us-ascii?Q?jXv8NHisO8RA15DcJZcR2jOzcnRWn5vihr1wadb25z64kfsH3jl7jybSEf2+?=
 =?us-ascii?Q?j1+3Bg8UjT4J//7DeLvTDYGvKO4aasL+sfonC1GO6klaU+MCypDLsgYPLhFl?=
 =?us-ascii?Q?6iIRHcAYNi3H1MfgEYH6puzSpcodT2/1Om6DSYm/y82ZpgTjVK5BhIUfeIvm?=
 =?us-ascii?Q?sOVyiA22H4K5DXJYF3wmpDcGP7ixX9X7lEyQsOxHO3spcA8S3zynEBk+2kOx?=
 =?us-ascii?Q?viNJADoy7AO8XlM7RvK/ms+ERzKTgXPzba6OPuVdRDiTvZ75O0xqoPCis11V?=
 =?us-ascii?Q?8fMDhY6y3FC8UttuX8FQwTMh2wqo2Jr420uQTVAN70O+lr1cukE4F8St96SY?=
 =?us-ascii?Q?hMCz8FOMt9/RUkt7ipTFEAXy8+lvk4OhsDVDVNScxNnebGAgg1PE+qLDTyVk?=
 =?us-ascii?Q?6FGbTPRW2PDpwhv//ZSYawxBJfBVv5BNiL6JrGCh39lHbh6dbkOSywRHZFm/?=
 =?us-ascii?Q?CX9/X0rghOa2U4RfLLqvQ5VHhVpSrZxNkdArOYyv2aEE+nji4XneAfEiBCKu?=
 =?us-ascii?Q?yyNEM0wi6kISgwqCIteS4OS37UtXVggyuxyCpjJQyBH6sqKrQDXteZ1iRQXl?=
 =?us-ascii?Q?7P3Xrcx12vM8hY0i4raa6VBRcHihA0mwgevyw7y3h7dHjvvsx8L7GlA1QL0z?=
 =?us-ascii?Q?l3gPpejppJR1bPPHq93ihwE2+t9xp7nSNJkNgbB+Pi2jcVIf+lhR3WFvZ/ma?=
 =?us-ascii?Q?nLR65FrnA6vZNyzZRzkNcJp+RNk5pdqmZudKhy0igVaCBuz/d3IQfabnM4FI?=
 =?us-ascii?Q?lNjF++8jpPueLxv5JrCICpVWW+uZ04S6kR1/vC6fn/6YzaGShXwU7gl5twU1?=
 =?us-ascii?Q?P53e11hYvvCJAFFidYqsjj9IsIsQtBiRvOjKBDwVdM303u1XkRMrk4N3EjN4?=
 =?us-ascii?Q?xZMzyy4HAhrrDGFdqYG6amvLGP+EF6fVJIxWGVAktqv9iBFPU/zdap9Ys0U1?=
 =?us-ascii?Q?75hG9zsNfzBMI5s+cgcnjwJjRe6WE2MVhDDeUii4TKzC2vCUpB5+qcqKT/OS?=
 =?us-ascii?Q?naIDylYn28jH+g3QH7C+q1l1rWRALMDgwHEvlyZJUSFdykitsH4s7DE0ssup?=
 =?us-ascii?Q?SKB+xKF2zwP8mkieg2gfXCYqzlhXW7ltwOERhghuzkSDP0to8Bmf+cJGsKTu?=
 =?us-ascii?Q?AUEgaDnMPAc+122EqcKb3q6aGp42rfTwV8H3nWwxegi5AaRAAvmsgFRl6+M1?=
 =?us-ascii?Q?4oe1mWT4X1K7NhvxDOA+2t117jGfb5k5ZQQddbsZcTOW+bVBfA8R+PtQko7H?=
 =?us-ascii?Q?wH4m6f3DdAQOTRsb/wS4E6WxJvF+MyoV6Znfd5FCvCy2kH7nv4e7v5Sq3dc7?=
 =?us-ascii?Q?Ds1/UX3DSGT/jLyD0g5JW7bFBbgq0fq8G72gGaFTAxrOoRxnwg0dR+F6ac5j?=
 =?us-ascii?Q?lBeggiDcS3b9grjSap8MPjKWESudhrMB+K8l24VlRV30siU1UHYgIf0BEATY?=
 =?us-ascii?Q?U/Se1tZCyFyuUtqgkYtPO9eH7MyyrfPIk8jFDgLgUbeM2H+t1mgftcD7kELK?=
 =?us-ascii?Q?YA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20eab53e-0251-4c64-4826-08dc3d1df357
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 14:10:02.7501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q3o4cgrUVLG4acW1mykeR5JvblZtb9o3faL4n8YTxWKgbhxHxf2faxH4YPVI0mG00RRUCvuGTX981YkNCgqQ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7410

Since hci_get_route holds the device before returning, the hdev
should be released with hci_dev_put at the end of iso_listen_bis
even if the function returns with an error.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/iso.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 5ca7bb0806b0..336c28cea3f7 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1128,10 +1128,10 @@ static int iso_listen_bis(struct sock *sk)
 		goto unlock;
 	}
 
-	hci_dev_put(hdev);
-
 unlock:
 	hci_dev_unlock(hdev);
+	hci_dev_put(hdev);
+
 	return err;
 }
 
-- 
2.39.2

