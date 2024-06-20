Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9871AB35E
	for <linux-bluetooth@vger.kernel.org>; Thu, 20 Jun 2024 14:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893359; cv=fail; b=VgY5z0pIU27BcW3vRlpY14V9J7Km9sx0RjeN6k4wQwe60ybSQdGmbTz2qzM4k7o/V3bDpu1ZcHAX0lbrmM9ndFJ936VXYsSB7srHOj0+X4oQntzJN+tjolxBcpReHki6CyrLVGmLYkP8gF9PYbaS/DAqqlrmsVBBhdFWvKPd0pQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893359; c=relaxed/simple;
	bh=mzHPEzcLd/AUrD9R5sCVbw+jc83bSlfNHWCR4FjjJBE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t3NRZbRaLi23D/skuMgnHi1tUR7JhUa2e6cT7wwJOV15Z1zpbwi83nmnk4wsOt34rPSPmUCFexZRYN3WwfY313MmRrVISUnk+eyy0JvpA2RY0FaYXGgoHzEe0mA6IKlZ8ktlqsPR7pim7qMNBjtJ+Gf7vY7LUA/G+w0aDTM+8yQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=izNS3dB9; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="izNS3dB9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bl5SoNAFEDQNfojWRaT89R7CrLVp6mu4q4Rgycbwpu4X2OQzQlMyNQ4nvlnCDvU2L3CkyM3FLz32NZuPFb+9rZOKQAoH9AOboG3Se7r5PcZcw/TdBICgQYHU4Su5TSsCsoL7ue4z6nItNBJH4hXl4qNd9fMOk3l7uvx6QG6mOZRheeZz9CdzC2C3FN8JWhrFQqzKHATDy2PLkkb41uytGsLjVJXkbtiLqaslvyacf4PNFgNKJePZl/tlualw8BBeSRSEFte6P3u+mBWW5Vog5D02aF/6iAgNPFQRkgnzEFb2HkSHqp02D79hzxJjj5p+RH15iBNm2FRyK+wUR8tZFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7guLVWVFttt/8JmgIy2f3j5QVRzFJ09KbukfxwoDYo=;
 b=Z8nuE1ic0BOq2b2W9fJYaoSdRxjoEgdM0H3wGsehG00vRS1xiD0u1ObN1UHwVMKq5G5Ptx1ev3+MvTDSM2YiOfGFE7HMiVdHnaSgGkdTnHqmriV+kXe1mhddfplrsnOKqtIT7Bm5Abj6iC8e/3Opy4dPpnukPlm8hi/SJ2ZkPY67x/rHqgmi8qfvoPd9Gql2MuNpLLpMvHcwGulNsm1SH0ZEQnScF26VpXxJoMmWaPe0sAVHbEv/bUwPLEiZjKx0EU8K7mZXBJVl9Ml2q+Pqcxsy4CYbyfHHIxkb0jKe1g+bglK27VQAKBlQuSmBpySLFewKsIDetNDe7R32xR1sBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7guLVWVFttt/8JmgIy2f3j5QVRzFJ09KbukfxwoDYo=;
 b=izNS3dB9yzISQ0cr8WkNhQznNA3dgwTyT1EeitLUyDQmzbkpFu+ftjKhC7s/kUNwluGMwuk1aDdubKZNq1sy0XckU2Mw5W2oj9mGqe7tcPK3TQUT0uVlb104CVPi9mzjX4aIj5j+fAy6UDV/KsePm5Jau651gSkPGSDVbcjkHTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9708.eurprd04.prod.outlook.com (2603:10a6:102:24e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 14:22:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.017; Thu, 20 Jun 2024
 14:22:32 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: luiz.dentz@gmail.com
Cc: andrei.istodorescu@nxp.com,
	claudia.rosu@nxp.com,
	iulia.tanasescu@nxp.com,
	linux-bluetooth@vger.kernel.org,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com
Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS tests
Date: Thu, 20 Jun 2024 17:22:29 +0300
Message-Id: <20240620142229.21889-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CABBYNZL5zp9+ieeVCSsaWQFVw_7qMM21yPNSjH1wV-ANV6Fd8A@mail.gmail.com>
References: <CABBYNZL5zp9+ieeVCSsaWQFVw_7qMM21yPNSjH1wV-ANV6Fd8A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0209.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::16) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: eabeea31-2be0-4c17-0ccc-08dc91346c17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WlLT1koyP6jdehzLAIjXMgKArSVb3SIuB2tUJTyMWXHnf0hVyVL5d7Lv7XX/?=
 =?us-ascii?Q?sGHIsGV6tk2KQfIMka3oTxNQoIiBZlYAhMX8iZ1rkQifmnKQze3sEkMUehYF?=
 =?us-ascii?Q?P0HlQjIZe0n8R+ZZB358DLCnjBMkpJIo1Br7yEeSWMfvkWno9a123ZJvvxNT?=
 =?us-ascii?Q?aGYywdyICwwszlcxj7M91sb8NiwnEwI6A8FSDZUzA1UIUlmCONLCOMV2hn4q?=
 =?us-ascii?Q?m/0DS3IQI5Ja5FE/lrB3GEcR8kg9JI8ggc4Sq4sLvTeZ3fNEEANyMtrcnqYK?=
 =?us-ascii?Q?2Pfz5/LLbJDzl7ggCpXJ41/c7e2Xjm3jv/eV9UZhbMJ8Jzv5Fvu2UKWnI+vh?=
 =?us-ascii?Q?q24XZYntyVV/aYDKKFhuJ5r84/NYGM9KbWetguevRMg+2o1bA4oQaWaH5NK+?=
 =?us-ascii?Q?kBMW2ODB8bnB5nHRhkZcTfgcFQVej6gnnI3uo7T4jx0YP6ph3kH1STkAJzUj?=
 =?us-ascii?Q?Wm1NaAdOT6XTmu1S/d2QqyuAZ8CUGZ5M2ERgIfApwPFn1eqyp0CSy5aM6c05?=
 =?us-ascii?Q?LXVtGN6qCzS4/IN/Tr9nSNAVncaBi92sILmLCUQ0AZFqobg3EoLKUXdmfF7+?=
 =?us-ascii?Q?RHIeE3He2HGbVeaCX5bk/e/DY8kwgpYWWTZN1wzMoj0lbXQ51Z6/XElUXdO9?=
 =?us-ascii?Q?EvLOxe3z00thBm7yi8mXodmzNrNnDikHax81a3mRk4qeKpLjnyCX6OMd4UoK?=
 =?us-ascii?Q?uj8opimH8e4+OeNrIqIxS0Bux3fl3Ai9+j7Dr3RJw4hW5uJ/ZFCpw+7Y3rpx?=
 =?us-ascii?Q?8I9/1kWF8GpgTwwnqfs3BQWgHhwLrq7zhDHv2Iqjq7iO0xfgMZCRKhdRcdM2?=
 =?us-ascii?Q?Ik0+ut8ghDJVU9pz7MFh0msWzxURNDdifhpPbGyMQEO4LdXt8M46rrIYMfZY?=
 =?us-ascii?Q?yTmnwCuC/7wIrQAYxrNyr8rQdF/j3OmUpzHqGPWxrRSmZjBqsLjZBiHrbfIB?=
 =?us-ascii?Q?pIxS068jb7QbSgL94uX9yQyADVChKac9dU7u9dK0PSDznAb3iFm/I717Cimb?=
 =?us-ascii?Q?wp7fy3hjSSQw6aqI6FaFlWIsew0Uv/QU0wAg/Cp1Y3hr67HY7CyvdY2Oy9ff?=
 =?us-ascii?Q?aicMK+kESl2RzRjNMSpj6sZ5+7RicXN0srVnTZm2lCsjKIvpdPY6dMU1t3IW?=
 =?us-ascii?Q?xxVoBz456EbLT4YOYTq7vZDOUvkzLSdW3/jGT2S3T4LpT8rlBypeMC2szkrD?=
 =?us-ascii?Q?o8tx6/IKG8wgm+DaFqXK2DKm+kZ8cW/jEFKiw3GY/FQRLJzL5hVa9P3usFb9?=
 =?us-ascii?Q?aWvKAC4Ddj+A3jyKoxVeJ49lWYsvrW8GGLGIJIFqbs8yOZKqv8o0H1/m/w5O?=
 =?us-ascii?Q?i7Z/qmEP3jLkGaXf2UYvbUM8?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?or2MQ9IMCog8f1V13yHkTOc6HFTkQxCMfNqmUi/d2RejOvVy0/6YK74wiaA6?=
 =?us-ascii?Q?OeFibJAFFCKho4b3snfZfzT5G1CDpWc/jd41x3v/h590hLCiBI8Ai7+SiPbb?=
 =?us-ascii?Q?WDO/fsrS90ShiY2Swb/HvqweihC6C6rHV+BEt3ZhLv+/OnE7dfV2amd6yEQX?=
 =?us-ascii?Q?BN0AurfcsoanWdDvwogI6NWo7iZ522V8pBr5UTHpg62xdJ53doqYoRTYfOOs?=
 =?us-ascii?Q?xAoDNXleVnmrhocXgB+TjUlB7jYtgWnUuYvwuY1UXblej+6d6jYWmiyQ1OyX?=
 =?us-ascii?Q?ityXEmCPS81WSaziK7V77Bj5YRoX9GhPR7WjhpeoZssZ+nuMUY9VWTOmYFym?=
 =?us-ascii?Q?MT9FDFXVwHcHJZ0/WjRzTn3ZJCJUvck/7O/bKRM5moJYthP6gd8QYr1hkRGs?=
 =?us-ascii?Q?v/Pzxy9UXylog8idVcqLvgLpyHyLN3b/1T+39yFF56fC0G8USoO8QT1Zca/Z?=
 =?us-ascii?Q?F0NG1qCePPY6MzQx5hcuxPo9rBR9bjI+LDHQiTYmfy3YbLl/Tt3JPxWFqoH5?=
 =?us-ascii?Q?SolnRUK6E6V/fU+JJrtegjTlaE2X6RWfWLH8uUKS4uQP2flVYexB5A7y+Vyg?=
 =?us-ascii?Q?Q4etMcAtpBnFPP1s5YfEUaFGXN14st6zYWoR7FNici+jt+MMPxDiuPV5AsqB?=
 =?us-ascii?Q?S39aPof3tr/mi6JhJ5Y9gQw/gvxVY88w1S2dkATDku2Ear/xi8LZyv8R89th?=
 =?us-ascii?Q?GU/qF6Q39sNn28t9nRjdkFme2gPriVT7eFvLxsn5jErve4V4XqJ4QKkWImZL?=
 =?us-ascii?Q?S6aKryZo9MU4ZTrSUfejCJc1Rf7BQYi0y98gxTpPX1v+BoZbKds3LzEc6ugd?=
 =?us-ascii?Q?1B4n36PYl1YQWUqqvfGswC04mfmpHN0x0QZBNVPiXBytfvIAZYOlTB0DVcTy?=
 =?us-ascii?Q?RQ5FLFN4Hs5v9m71u03Mp3tP4ki2Nb0V0A4mKT7r0BUTjz7ZgcpmsWmtsJv9?=
 =?us-ascii?Q?aJ28WUjBLOALPLBD2qsK5jzh2rhFbIguNa/cGjNmQTNDZk3osJjpBhLDEKKX?=
 =?us-ascii?Q?vekGE+2Hz2RmlQfPREggX8mqYvELMiQh73TUuRx8aUiECYJYg2C45BnnQKUc?=
 =?us-ascii?Q?0zQXZ1tQt34ZnhvHoRAoGkFeFxp79dRykoBvY2AkFjxvf1memFf2H6rVi1Pl?=
 =?us-ascii?Q?pjt+0xvN04picnMvFE2kVsZ5u8ZXAf0Mt9KYj7TKeSvhjbvgOUxFfwtyDdUI?=
 =?us-ascii?Q?8VTjOD9LqGPGVkOKHYWqLlTCgmtgqwsLcg/vpImV4lPRB47oZ2USuIzRO5zQ?=
 =?us-ascii?Q?+1Zm5gywH/GU1f1bkoa4R1ACZXPYUysQc3vKIg/iBAEtDvzRtYFuahCwpg3z?=
 =?us-ascii?Q?1H5oZVhQ/wz3pDuTgAN0fMFqR+4lvwZLDFhjXr6RVQr/HtVXKEa2JZvlNQEk?=
 =?us-ascii?Q?6d99eKwHvp5FD+CM+WWfhzFkfLPCXdh/IMr2/5gh0PZFK6qZ9liAKt2LKxnS?=
 =?us-ascii?Q?W91dZ3HtmbVm4aLXDAa4xNybJbJcAQtDAGQ4LLNBf6ArPN6Nz1zTqlREhnrD?=
 =?us-ascii?Q?NsrPlnBMqlQMYxY6HVcXW54i3wsRV42RZbhnfDyu5vleZp9fnEKQQNcK4zCK?=
 =?us-ascii?Q?uc00JJExyze1yrWR80Yb32dbaXXfgSMtSJ0yiJ69Tp7/MBEOPseq8PzUf4Kp?=
 =?us-ascii?Q?vQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eabeea31-2be0-4c17-0ccc-08dc91346c17
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 14:22:31.9598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wu5/XQGKDxN1+uv/vMxEKgAK0VdiVO4UrMsgxfQhwHLEPvjdKj93seUqCIr8k3fP8WC04nhFEh77T6YwtMBOoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9708

Hi Luiz,

> -----Original Message-----
> From: Iulia Tanasescu
> Sent: Monday, June 10, 2024 10:24 AM
> To: luiz.dentz@gmail.com
> Cc: Andrei Istodorescu <andrei.istodorescu@nxp.com>; Claudia Cristina
> Draghicescu <claudia.rosu@nxp.com>; Iulia Tanasescu
> <iulia.tanasescu@nxp.com>; linux-bluetooth@vger.kernel.org; Mihai-
> Octavian Urzica <mihai-octavian.urzica@nxp.com>; Vlad Pruteanu
> <vlad.pruteanu@nxp.com>
> Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS
> tests
> 
> Hi Luiz,
> 
> > -----Original Message-----
> > From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> > Sent: Thursday, June 6, 2024 11:29 PM
> > To: Iulia Tanasescu <iulia.tanasescu@nxp.com>
> > Cc: linux-bluetooth@vger.kernel.org; Claudia Cristina Draghicescu
> > <claudia.rosu@nxp.com>; Mihai-Octavian Urzica <mihai-
> > octavian.urzica@nxp.com>; Vlad Pruteanu <vlad.pruteanu@nxp.com>;
> > Andrei Istodorescu <andrei.istodorescu@nxp.com>
> > Subject: Re: [PATCH BlueZ 2/2] test-bap: Add Broadcast Source STR MBIS
> > tests
> >
> > Hi Iulia,
> >
> > On Thu, Jun 6, 2024 at 6:26 AM Iulia Tanasescu
> > <iulia.tanasescu@nxp.com>
> > wrote:
> > >
> > > 4.14.3 Broadcast Audio Stream with Multiple BISes - Source
> > >
> > >      Test Purpose:
> > >      Verify that a Broadcast Source IUT can stream multiple
> > >      BISes to a Broadcast Sink.
> > >
> > >      Test Case Configuration:
> > >      BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]
> > >      BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]
> > >      BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]
> > >      BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]
> > >      BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]
> > >      BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]
> > >      BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]
> > >      BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]
> > >      BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]
> > >      BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]
> > >      BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]
> > >      BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]
> > >      BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]
> > >      BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]
> > >      BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]
> > >      BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]
> > >      BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]
> > >
> > >      Pass verdict:
> > >      If the Codec ID is LC3, the IUT sends encoded LC3 audio
> > >      data in BIS Data PDUs on each synchronized BIS.
> > >
> > >      If the Codec ID is a vendor-specific Codec ID, the IUT
> > >      sends BIS Data PDUs on each synchronized BIS. The parameters
> > >      included in the Codec_Specific_Configuration data are as
> > >      defined in TSPX_VS_Codec_Specific_Configuration.
> > >
> > >      If the Codec ID is LC3, each parameter included in
> > >      Codec_Specific_Configuration data is formatted in an LTV
> > >      structure with the length, type, and value specified in
> > >      Table 4.83.
> > >
> > > Test Summary
> > > ------------
> > > BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1] Passed
> > > BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2] Passed
> > > BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1] Passed
> > > BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2] Passed
> > > BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1] Passed
> > > BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2] Passed
> > > BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1] Passed
> > > BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2] Passed
> > > BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1] Passed
> > > BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2] Passed
> > > BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1] Passed
> > > BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2] Passed
> > > BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3] Passed
> > > BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4] Passed
> > > BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5] Passed
> > > BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6] Passed
> > > BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]      Passed
> > > ---
> > >  unit/test-bap.c | 354
> > > ++++++++++++++++++++++++++++++++++++++++++++++--
> > >  1 file changed, 346 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/unit/test-bap.c b/unit/test-bap.c index
> > > c37f7676f..30c223d16 100644
> > > --- a/unit/test-bap.c
> > > +++ b/unit/test-bap.c
> > > @@ -6972,27 +6972,86 @@ static void test_bsnk_str(void)
> > >                 NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);
> > > }
> > >
> > > +static void stream_count_config(void *data, void *user_data) {
> > > +       struct bt_bap_stream *stream = data;
> > > +       uint8_t *streams = user_data;
> > > +
> > > +       if (bt_bap_stream_get_state(stream) ==
> > BT_BAP_STREAM_STATE_CONFIG)
> > > +               (*streams)++;
> > > +}
> > > +
> > > +static void stream_count_enabling(void *data, void *user_data) {
> > > +       struct bt_bap_stream *stream = data;
> > > +       uint8_t *streams = user_data;
> > > +
> > > +       if (bt_bap_stream_get_state(stream) ==
> > BT_BAP_STREAM_STATE_ENABLING)
> > > +               (*streams)++;
> > > +}
> > > +
> > > +static void stream_enable(void *data, void *user_data) {
> > > +       struct bt_bap_stream *stream = data;
> > > +
> > > +       bt_bap_stream_enable(stream, true, NULL, NULL, NULL); }
> > > +
> > > +static void stream_start(void *data, void *user_data) {
> > > +       struct bt_bap_stream *stream = data;
> > > +
> > > +       bt_bap_stream_start(stream, NULL, NULL); }
> > > +
> > >  static void bsrc_state_str(struct bt_bap_stream *stream, uint8_t
> old_state,
> > >                                 uint8_t new_state, void *user_data)  {
> > >         struct test_data *data = user_data;
> > > +       uint8_t streams = 0;
> > >
> > >         switch (new_state) {
> > >         case BT_BAP_STREAM_STATE_CONFIG:
> > > -               bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
> > > +               queue_foreach(data->streams, stream_count_config,
> > > + &streams);
> > > +
> > > +               if (streams == data->cfg->streams)
> > > +                       /* After all streams have transitioned to CONFIG
> > > +                        * state, enable each one.
> > > +                        */
> > > +                       queue_foreach(data->streams, stream_enable,
> > > + NULL);
> > >                 break;
> > >         case BT_BAP_STREAM_STATE_ENABLING:
> > > -               data->base = bt_bap_stream_get_base(stream);
> > > +               queue_foreach(data->streams, stream_count_enabling,
> > &streams);
> > >
> > > -               g_assert(data->base);
> > > -               g_assert(data->base->iov_len == data->cfg->base.iov_len);
> > > -               g_assert(memcmp(data->base->iov_base, data->cfg-
> > >base.iov_base,
> > > -                               data->base->iov_len) == 0);
> > > +               if (streams == 1) {
> > > +                       /* After the first stream has transitioned to ENABLING
> > > +                        * state, bt_bap_stream_get_base will generate the
> > > +                        * BASE from all previously configured streams.
> > > +                        */
> > > +                       data->base = bt_bap_stream_get_base(stream);
> > > +
> > > +                       g_assert(data->base);
> > > +                       g_assert(data->base->iov_len ==
> > > +                                       data->cfg->base.iov_len);
> > > +                       g_assert(memcmp(data->base->iov_base,
> > > +                                       data->cfg->base.iov_base,
> > > +                                       data->base->iov_len) == 0);
> > > +               }
> > >
> > > -               bt_bap_stream_start(stream, NULL, NULL);
> > > +               if (streams == data->cfg->streams)
> > > +                       /* After all streams have transitioned to ENABLING
> > > +                        * state, start each one.
> > > +                        */
> > > +                       queue_foreach(data->streams, stream_start,
> > > + NULL);
> > >                 break;
> > >         case BT_BAP_STREAM_STATE_STREAMING:
> > > -               tester_test_passed();
> > > +               queue_foreach(data->streams, stream_count_streaming,
> > &streams);
> > > +
> > > +               if (streams == data->cfg->streams)
> > > +                       /* Test is completed after all streams have transitioned
> > > +                        * to STREAMING state.
> > > +                        */
> > > +                       tester_test_passed();
> > >                 break;
> > >         }
> > >  }
> > > @@ -7225,9 +7284,288 @@ static void test_bsrc_str_1b(void)
> > >                 NULL, test_bcast, &cfg_bsrc_str_vs, IOV_NULL);  }
> > >
> > > +#define BASE_LC3_8_1_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_8_1, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> >
> > I wonder if we couldn't define these as part of lc3.h, in fact the
> > LC3_CFG looks awful similar to LC3_CONFIG from lc3.h, so perhaps we
> > could do just s/LC3_CFG/LC3_CONFIG and add something like LC3_BASE
> for
> > example then rename the existing LC3_BASE to LC3_TYPE(_id), anyway I
> > can probably do that myself later after merging this just wanted to
> > check first if you thought about that already.
> 
> I added LC3_CFG because LC3_CONFIG from lc3.h defines a iovec struct,
> while I needed some byte array to include in BASE_LC3. But I do think it
> would be useful to add the BASE defines to lc3.h, and they could be used
> for iso-tester as well.
>

Should I update this patch to move the BASE defines in lc3.h? Or should
it be done in a separate patch?

> >
> > > +static struct test_config cfg_bsrc_str_8_1_mbis = {
> > > +       .cc = LC3_CONFIG_8_1,
> > > +       .qos = LC3_QOS_8_1_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_8_1_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_8_2_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_8_2, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_8_2_mbis = {
> > > +       .cc = LC3_CONFIG_8_2,
> > > +       .qos = LC3_QOS_8_2_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_8_2_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_16_1_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_16_1, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_16_1_mbis = {
> > > +       .cc = LC3_CONFIG_16_1,
> > > +       .qos = LC3_QOS_16_1_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_16_1_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_16_2_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_16_2, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_16_2_mbis = {
> > > +       .cc = LC3_CONFIG_16_2,
> > > +       .qos = LC3_QOS_16_2_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_16_2_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_24_1_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_24_1, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_24_1_mbis = {
> > > +       .cc = LC3_CONFIG_24_1,
> > > +       .qos = LC3_QOS_24_1_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_24_1_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_24_2_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_24_2, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_24_2_mbis = {
> > > +       .cc = LC3_CONFIG_24_2,
> > > +       .qos = LC3_QOS_24_2_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_24_2_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_32_1_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_32_1, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_32_1_mbis = {
> > > +       .cc = LC3_CONFIG_32_1,
> > > +       .qos = LC3_QOS_32_1_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_32_1_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_32_2_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_32_2, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_32_2_mbis = {
> > > +       .cc = LC3_CONFIG_32_2,
> > > +       .qos = LC3_QOS_32_2_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_32_2_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_44_1_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_44_1, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_44_1_mbis = {
> > > +       .cc = LC3_CONFIG_44_1,
> > > +       .qos = LC3_QOS_44_1_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_44_1_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_44_2_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_44_2, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_44_2_mbis = {
> > > +       .cc = LC3_CONFIG_44_2,
> > > +       .qos = LC3_QOS_44_2_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_44_2_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_48_1_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_1, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_48_1_mbis = {
> > > +       .cc = LC3_CONFIG_48_1,
> > > +       .qos = LC3_QOS_48_1_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_48_1_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_48_2_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_2, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_48_2_mbis = {
> > > +       .cc = LC3_CONFIG_48_2,
> > > +       .qos = LC3_QOS_48_2_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_48_2_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_48_3_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_3, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_48_3_mbis = {
> > > +       .cc = LC3_CONFIG_48_3,
> > > +       .qos = LC3_QOS_48_3_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_48_3_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_48_4_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_4, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_48_4_mbis = {
> > > +       .cc = LC3_CONFIG_48_4,
> > > +       .qos = LC3_QOS_48_4_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_48_4_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_48_5_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_5, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_48_5_mbis = {
> > > +       .cc = LC3_CONFIG_48_5,
> > > +       .qos = LC3_QOS_48_5_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_48_5_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_LC3_48_6_MBIS \
> > > +       BASE_LC3(40000, 1, 2, LC3_CFG_48_6, 0x00, 0x01, 0x00, 0x02,
> > > +0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_48_6_mbis = {
> > > +       .cc = LC3_CONFIG_48_6,
> > > +       .qos = LC3_QOS_48_6_1_B,
> > > +       .base = UTIL_IOV_INIT(BASE_LC3_48_6_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +#define BASE_VS_MBIS \
> > > +       BASE(40000, 1, 2, 0xFF, 0x00, 0x00, 0x00, 0x00, \
> > > +       VS_CFG, 0x00, 0x01, 0x00, 0x02, 0x00)
> > > +
> > > +static struct test_config cfg_bsrc_str_vs_mbis = {
> > > +       .cc = UTIL_IOV_INIT(VS_CC),
> > > +       .qos = QOS_BCAST,
> > > +       .base = UTIL_IOV_INIT(BASE_VS_MBIS),
> > > +       .src = true,
> > > +       .state_func = bsrc_state_str,
> > > +       .vs = true,
> > > +       .streams = 2,
> > > +};
> > > +
> > > +/* Test Purpose:
> > > + * Verify that a Broadcast Source IUT can stream multiple BISes to
> > > + * a Broadcast Sink. The verification is performed for each set of
> > > + * parameters in turn, as specified in Table 4.82.
> > > + *
> > > + * Pass verdict:
> > > + * If the Codec ID is LC3, the IUT sends encoded LC3 audio data in
> > > + * BIS Data PDUs on each synchronized BIS.
> > > + *
> > > + * If the Codec ID is a vendor-specific Codec ID, the IUT sends BIS
> > > + * Data PDUs on each synchronized BIS. The parameters included in
> > > +the
> > > + * Codec_Specific_Configuration data are as defined in
> > > + * TSPX_VS_Codec_Specific_Configuration.
> > > + *
> > > + * If the Codec ID is LC3, each parameter included in
> > > + * Codec_Specific_Configuration data is formatted in an LTV
> > > +structure
> > > + * with the length, type, and value specified in Table 4.83.
> > > + */
> > > +static void test_bsrc_str_2b(void)
> > > +{
> > > +       define_test("BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3
> 8_1]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_8_1_mbis, IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3
> 8_2]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_8_2_mbis, IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3
> > 16_1]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_16_1_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3
> > 16_2]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_16_2_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3
> > 24_1]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_24_1_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3
> > 24_2]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_24_2_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3
> > 32_1]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_32_1_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3
> > 32_2]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_32_2_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3
> > 44.1_1]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_44_1_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3
> > 44.1_2]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_44_2_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3
> > 48_1]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_48_1_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3
> > 48_2]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_48_2_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3
> > 48_3]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_48_3_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3
> > 48_4]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_48_4_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3
> > 48_5]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_48_5_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3
> > 48_6]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_48_6_mbis,
> > > + IOV_NULL);
> > > +
> > > +       define_test("BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]",
> > > +               NULL, test_bcast, &cfg_bsrc_str_vs_mbis, IOV_NULL);
> > > +}
> > > +
> > >  static void test_bsrc_str(void)
> > >  {
> > >         test_bsrc_str_1b();
> > > +       test_bsrc_str_2b();
> > >  }
> > >
> > >  int main(int argc, char *argv[])
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz
> 
> 
> Regards,
> Iulia

Regards,
Iulia
