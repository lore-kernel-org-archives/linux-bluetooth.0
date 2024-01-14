Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B652C1B3
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jan 2024 22:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UZbGl4ZZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vy1xsHXyPtPlPopEIpv+VsfovIAhYCIXmoRNi26g6AXAPH1Z+9/r1Ek64ZqlR8zfyRzrMug/lwL9FXIKprDDeo3Wy9Pe+cxiykBOAO4eedlAjraHKFEO32OcoNHY7aJaXOgghkPcV3H8Ku3Niy9VYnMgn9qcNe8rkEjzXOuVBuFWzEcRlIdYlm6wIM9ERHsPxdnpx6mY9E2lHH3UEUaCMlXTHajB6IN9S1Y9qFc9wMJzlUkfKUFtAeMR3ORAu0sYWb3Xquwd2ZitTfJP2ta7ywNK+LTHP7vAdXSQBs5DVa9wkXaiwpJQO/HntgJbLSMl3nydoLb8oi7ytAmyl29oWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj48a92fpgR0u52Q1i43rWBmSnlZU8b2Xgz2ZEHifh8=;
 b=Xb3Wkr8z7drZjZZUt29Rp+AVX4u/hEOTOBWa7uEKsvJijCsz2qHfEUiuJoZBn9qjQo+8+/CwvhlDxZNmC3UD3CKfP8zpt75D/b6Mc+RR9SqngZZHq2+N+ERWRqbGNJ3DWBCslu3QqCo28UE8407N0yswV9LJIemTRKM/Q1kZ7tgpW3b5v9hXOSBg/pHJpI+0zmD1Gv7spzfppSVlSdCanOtvB7xIs3SCijLceKepqtYX/tm77cJHFsPhExw0vYP2JGt49ZNlYcX5/PW1Ii8kxMolkdGdhSTQezuyRoSNsgfStO9J0Iu7WZiMSClNrnoFjJ5r1DTKOhQ/+i8xeVYrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj48a92fpgR0u52Q1i43rWBmSnlZU8b2Xgz2ZEHifh8=;
 b=UZbGl4ZZ5a/GfqlbJENEg7dLWCcFLVYGnBehNlq+I+3wZ5IcfXFMKsjWHenM/gkJp9twNSExnilmkvf9F+1B6HRlGcSsLvIAwjVbm3vUG8ZSalLXY829vWctpMDbP4GMLVxahcg2B+4Eovv9DzBmzFUxqiovPdn2E77tR2D6RFQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Sun, 14 Jan
 2024 22:41:10 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Sun, 14 Jan 2024
 22:41:10 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v3 1/2] shared/bap: Fix dereference of null pointer
Date: Mon, 15 Jan 2024 00:41:03 +0200
Message-Id: <20240114224104.37716-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
References: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0022.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::35) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 894c3d19-e235-42b0-d089-08dc1551e77e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PzL1G6jbtDSV2rrEW06WfDn/yEfmaJTj9lkgzmHnCezoOqrFOG2DdGOwnxWOZdMadd+LlkQlLLwdZ7VH6zA53vHG/gp7qFkdACa3IvTkGIF0Q41K8tgNdWeFpjKIMEdE67Nh/IktY8tmnrswToC++gORqCW8QP+wvdzYMCHhYBolveI5jQ3UgSg9OMn3tekpsCGXn9c5tUQsaHdocDeh3oZ+nPis2F4WtNIf8wgEj66+uwsi9zlBSOh7E2wBQ8Je5/60dmiY0dHBVB5RDftR6l13H/s+PoQC6tGwcHv3pMSBcp2w0WkQwhsSwaBSByaLJ429M/RlOrj7sgJ/9Nwlv+UONVKLXl/xqac1bH/4ukJB/yiwj2fiPsbYLeJkwysx/WphnznNYanxsr6MkvemOaW36C8D3GUMl2uoEakgXZLUl0aYFTPywgI7DZ2kEiyiMGmmiUHUeJvvBHXsBWLnN7fKuUGjKVN6IzH2hw2ROON77lD3EfCl/JZmSEzhzTSf6PjaUuCziYsmvcBLCT+5tu5fXJl+vOPCfTWKXtG5Qe+RFQqH1S+eBpe4uQL/T7Ve
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(4326008)(8936002)(2906002)(6916009)(4744005)(316002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(6486002)(478600001)(83380400001)(2616005)(26005)(1076003)(36756003)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rel1ExUKHQn4xS/DuEb3hZ3kFAhgHJxWo9+1TKsNeAc1TzVd01sw9/xHNq8/?=
 =?us-ascii?Q?MBcm85DrN9tj76SvLlnUfO2H8boraNsE4pPyZKvTHwaisiCoMh/jjNL6u9cw?=
 =?us-ascii?Q?0O729R9i7An9J4WV7uTwMOUr/UYgw0f/fy2ZoD3QqolOkXyvkelmSRqcQad+?=
 =?us-ascii?Q?i+j/k4O1RN52jWjL2M0YixB6m7tYSXPuyirhd28PgZGXENe0CSkjZQtQoLEf?=
 =?us-ascii?Q?kgNqUv0jicQLCY6zg3Bmn4LpryoUPLbfiHHPncTlV6BXe0ywEgYhyK51TDfX?=
 =?us-ascii?Q?0X3Pu+BuL6r96r8po6GpKs4RNcYMQPuJni50tVt+LGzbmxHFB/G2ynaN8A17?=
 =?us-ascii?Q?KW2Qs8Pg6bD5QpgRdn+tOxTKzOqCLbFLezWhqPmqq7jb4oUr94q4/nK5my4b?=
 =?us-ascii?Q?84NGXOEsZf+3A+khk+g0yURKMwa7q0+kS1BjH7A+DZQJ051qZ0qhuS4r4tDh?=
 =?us-ascii?Q?GCggexRfbY4+jDC8iMS8wQio1+8MyrGmJJxvSXcZ8AaOfqXMBDipWT2WWunj?=
 =?us-ascii?Q?lWYQarQWiUHiw2tijsWGsj/LHQR07EvP5uli+Hg6FfVuIPpJZxwUDtPCS0Ms?=
 =?us-ascii?Q?cYdsGguIMaBlIbPMwsTQ+zSk5RIYdCmQoNaGdOiaTCV2ypb+t5fXJCDx7/JQ?=
 =?us-ascii?Q?6Q8znpnlG08qiWcfs1TRQ9z3xHEk4v3s3/WnnDHtwi8vUfsn+BGHxq92SmYw?=
 =?us-ascii?Q?IHlCBmv8/QVapb4Ha35wBWUzwfF0/30jrU/W0T/CYmpNPKcBXzWQ2e0fSrYa?=
 =?us-ascii?Q?ZMglU/YwJkfghbSjcwfWYtIuzUTE30iA8qIwTKtInjctnIhqHsB/tT+mTBuE?=
 =?us-ascii?Q?vQo/XTv9IlqNh9KpJ+B9clWkPXd5HeFrBUS6zeISBk4H2G4bUlqzPOeJCSyI?=
 =?us-ascii?Q?W8017l+a3nYWN8ufBrBdruD2UYP5+wZGeC7XoFyoqmL5vAel603oOsuV2yY0?=
 =?us-ascii?Q?WOt/XzbBRHcV+v/ZVGzZbaXy6Cd3veTn85MkzzTczFwjzEXA2tq4WKjnaG0T?=
 =?us-ascii?Q?W6MdjFDNUkyLMw8J0wTb7mQ5yNAnLzZdy5jTkpTHbIfQWMLMi8zMmmzRjyuN?=
 =?us-ascii?Q?zB2xDijtUgMGmF7vVyKY/YkH0FpYakvCGR44vfbiTtwqaI6w8yE9UR3Payqt?=
 =?us-ascii?Q?hfvfUCh7f+U1/lcWfqHXGibNLUfi8u++ovoTG8ufo1dSeHoAHJJGVCFwxdd7?=
 =?us-ascii?Q?qDqteYPEf/Yvpo22D3BXcAJeM9vuFnL7K45+zhvYNzyztsgy02xG2WbcxHjK?=
 =?us-ascii?Q?y24Ndr/A4tfHAtdNymrrHmWUVAqGofMSusDwCBljYJdGFm1A18G6vxO/09i+?=
 =?us-ascii?Q?uggnD9/n6oarwLIMfVJ7boE+lkcTVKFJPM6Bh/QFkZH6o6oxl1hKU9n0hZry?=
 =?us-ascii?Q?tTr+7iD84bmLjBTaeffanEV2bgOfIqWpjIYaRX8rtV3Jn8CkjaBvJZXcMoJb?=
 =?us-ascii?Q?oly+BVLUXgWUW7Th+zi/jibM/+ea3NDg0XLojVMLUqfXBFb7j1EYkbiSCgAS?=
 =?us-ascii?Q?ZUihJ0ZhH9PTMuU9pmcgjCzld7/s6BQIG3uOVQEG4jSTgdSC/XUvs8YNsGUP?=
 =?us-ascii?Q?8mc5WR2h0/IACAUWJ4vP+3vT75+Q7ebyldqVH9UACodW4/YfKBbDtAqO7XFx?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c3d19-e235-42b0-d089-08dc1551e77e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 22:41:10.1491
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ackifmN1XLcQ5+QCiBH0OmHEYUkMZull366NadRMDHh4zkvBKdSO+384ft2yn7HTzpOWq/pHaxVsLFcW4kHvJBpZhMnGjAbrnwgqEos9YRE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

shared/bap: Fix ScanBuild error: Dereference of null pointer

---
 src/shared/bap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 078d308dc..49eb8d057 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -4763,7 +4763,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
-- 
2.39.2

