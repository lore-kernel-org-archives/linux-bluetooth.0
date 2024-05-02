Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2069.outbound.protection.outlook.com [40.107.6.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697DA46B9F
	for <linux-bluetooth@vger.kernel.org>; Thu,  2 May 2024 09:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714640512; cv=fail; b=B4lfyuLPWWuWlDLdwJ3iVu6XLGFReftBoMsI2Fa4ep1DY9u5zMskQJgFnpjcFTimB6LMLBvm5KBDq3BFtz6bOanDgfQ6v8z1G17K3NBcX/hVmmgQ2/impAORSvpR1C6k8berAVwritGn2tAi4T3dFKNgI4S4DvKXnTP0FcWPgGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714640512; c=relaxed/simple;
	bh=Lg2+/YVeljaYey3rpXGT81Lk4TxCqIreWMrhMiOEzX8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RIcLnhOoyNFZC98puJYMm0UGqsjGUjhuM2H4NpCgYqmgWNECVYTifqlbQH0nSd6lBlzQkUC9zMbNnnrrwbc38xZj2wQUhq/R0IvP8MLxysXRSC03J4wLsrq6DDIGWSQ1/oq3PFfVNw2ontJaqfpY62mqOqOoCsz4Gk0Eld4DlpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=AtmXVep7; arc=fail smtp.client-ip=40.107.6.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="AtmXVep7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OGgU+5u1a03cd+enTnoVi2PSvULfS2igGb01cnEP68ZGtq7xQJBtPOGfQU/nViDnfCq9qV3fQskkHbL5GeASXfsfhwZpM6CtVMAazfMfxohqtFj5lA7sxlgpiO8zVaH0YYcrc+oyt0G2qqOhjz60e5GDP/ib6FPewq4fJi9iaU/APfflJoSXtMc3HPSfDxRZIApjNh1MODnDtGRrIdS+KOAnKMc6Qm44Gz1Nel/DoJ6UEgs3AL3F/I/gG3JTCa1G0JQ977W5wUUULbiFSZMx8EXbFZCzOmtXLW2ERm4EVjFfS6WyQ6XCmzxsFJ380gYGj9azCl145A3ACMlQDSCfDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mntbb0ZegCjTyGppmGSSQe8x3nd6Y843qHQhz9mfd6U=;
 b=AbyFhYV5bshbTVT/MUntAXBop0Odn8JfNOZuI5JyNsfNUx5l3PPkE7f9obT5I2UYq8pbivMlF3zyf891KBBOJID0qGDeTLN7KdJFaRcJCS29F+adtxicUy1E4aCoLlr+A07lToOCW/UMS211QdOfspjKRRl9yE3fGwxIZO0jaGFYvHoO2c2A4whZJN/Q2D+grpKy9pTfR9Ks3jaQtRdV3Kv2WWTthGrXdq5ZeXIbkOC8QuKU4y17iAobpmX+uiDnxP4l1bvB44U57SZHMytACqimDV7lZjaysh5T5lMX2jJ3bEZa/z4mJC+N0nKRVb5/TCneRWRBxqPycKVRLsPQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mntbb0ZegCjTyGppmGSSQe8x3nd6Y843qHQhz9mfd6U=;
 b=AtmXVep7/GKPFeo91CwfY41lxrwtwlBv6mCcVkkWyxcrR/jgpf7LtCSA9/6BqKUtCC1mbb+AvjZ0e9YKXfKH91lVGAmenNc5WwtO17R1OImPdTFuzUqKILPAL001aeCiHHO2nsMMe84Te6SzKp2ZqHX6PadTTC4HB4BPgzm74mc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by AS1PR04MB9655.eurprd04.prod.outlook.com (2603:10a6:20b:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 09:01:46 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%3]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 09:01:44 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: devyani.godbole@nxp.com,
	luiz.dentz@gmail.com,
	sarveshwar.bajaj@nxp.com,
	mahesh.talewad@nxp.com
Subject: [PATCH Bluetooth v2 0/1] LE Create Connection command timeout changed to 20 secs
Date: Thu,  2 May 2024 12:01:22 +0300
Message-Id: <20240502090123.5177-1-mahesh.talewad@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0032.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::45) To AS5PR04MB9754.eurprd04.prod.outlook.com
 (2603:10a6:20b:654::9)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS5PR04MB9754:EE_|AS1PR04MB9655:EE_
X-MS-Office365-Filtering-Correlation-Id: b8f563d7-43bc-453a-309f-08dc6a867d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|52116005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Eme0CqeEWRnWqzjQ/EIGjK25I6fSZyavhFXSnSKi+g3Fbt1uFfPjo5HSDFf?=
 =?us-ascii?Q?chk5lUTs5G7rRoB7hdZ0VaW+KVdok7/4LbsMBFEkL7v7vuMKb4nHggJ4pOE9?=
 =?us-ascii?Q?NrPjMCuU0NCqvXa1WL7tPjnnoA8wfFmVrZ8yva8MnrNTjUKbkBnPcNZVgOo9?=
 =?us-ascii?Q?Cb7KR5g1/thIXYgDYLHX1X1XdY4ERgOLZsK7oaj/xFwSQfIiyYYVanJJ7KGI?=
 =?us-ascii?Q?fefseWp9Vbm8gtEP/mV9YS0vAvQ+V9WPjhj07ztsaPSQeTA3ljCPg6loiTFo?=
 =?us-ascii?Q?7HOxWTnDYfukD0XvD51m7UQFrrULtTcUQQ5KEMo4VlrLn5TYHn5+7QGbMfBi?=
 =?us-ascii?Q?lrtMfd67Vhk1y3PwhGVU0GnAHkSG+EWyjTo6UGWeW2AUfWmn7YuNPwFcgoKm?=
 =?us-ascii?Q?cpll1MgmIoPr9JfmPIJ/MeFuL+ZN1KxGbZjP2WHaNkN8OUC5BJQJX4WjuvkQ?=
 =?us-ascii?Q?81rcfb30wNCOMWUUCZxiD5WRRH7EcWcqDG4AjRjkpJ/lE+xQlnVBEo5Eiwx7?=
 =?us-ascii?Q?WrHXq11OOeUij5lMt70vJCtQSj1Vntx5PC/HXeUutR/2Szr7ojB7Pceea7L7?=
 =?us-ascii?Q?SvFS8R7kYdAlnIpgG6rd5H+Hvxb2mTsT+ED+SftbJtRvUzV5FHfh+UkPyLQE?=
 =?us-ascii?Q?CwAX+zmSOdaJDtny9BRdEPPEa7JFr2w2CTeFayG3yk1G5lMexPwchXdStFJd?=
 =?us-ascii?Q?3DAM24p5iiRlkzb6zCWee3C4gnZa7KJeCXV3AV6m8fVZfHzscQ7xwNrZSb9c?=
 =?us-ascii?Q?HzT9qORHlkpC2wbHjQUmDnxqIX81lhQ+9HFK+9ztBfty07lkg2uTqlhUC7HI?=
 =?us-ascii?Q?LZ0pIrAJG2J+LiyCmearmhjQdZujUEsTrbCVgGUNYTRdlAmuxwsheENwyaWh?=
 =?us-ascii?Q?4HuQq80JPHn00HyYZ4mkohq2t7B4u/mSUzXgdwOVmETUDdUpE/4TeJyDPoFj?=
 =?us-ascii?Q?bJP/joV53hFAW5I9HMUeHoasdCoYPZ5c2XZ3Nlkln/fMgRyjt5MwTyCZVjvL?=
 =?us-ascii?Q?QxgR+ja0kT8foktCAFJ7giJGfFWTYIx2Nqypx4x2vjF7fq759Uq9bOVfEYmq?=
 =?us-ascii?Q?4+7uHjXDne6eyIfRqs66spcVff7ojmilLhICnIA+c0+AhefLLL9Bp47yDBPZ?=
 =?us-ascii?Q?BOuhriS9HCgyOGNvB74XuW16n2uRZupic1/fMU1TuqcfK8Fgz/GSv4YeGq3D?=
 =?us-ascii?Q?L/IWCxSG8duG5uFZKFVt0hlgp8P2goVO5ptct0uvDyimIur4moI/wVhmu/iM?=
 =?us-ascii?Q?yeqE3obIeaZJglqazxU01NEgfxkA12/kOOWK7UGZwttH4Co6Y/1cxopEF/nD?=
 =?us-ascii?Q?a8bZBhnUXVRlJuIBX7X6twPuPmM1XG0MIX9954bFDPJm5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rC8esqCeZCgjEvD8FqqKFNLtr56Jd9r46hxk+8uziQpr+jpCXtuQG3umdpHb?=
 =?us-ascii?Q?ZDlBpNMq7VTzCyuptfKYtNUmdKHbJ6iuhVU6kkGPQm1Tpbzhm2vCLDP9uJ7z?=
 =?us-ascii?Q?DCtNUPvDjoYnZJacLk45SJQakzgiroMdRKmzKEdN4J4WzLXR7Jj9C6EnjMno?=
 =?us-ascii?Q?cxs4/pPrCPv1gNY1vnS6egBge13g9ActdMrhBrHzFpHmXVxN8b5qVaXr2q1e?=
 =?us-ascii?Q?xi8h9wfihtwfNK8JseGthwaaJ36mLVc7iwMlj2PnRcTbbpNU8fKZSzfC0Nfr?=
 =?us-ascii?Q?SGSimG9OgOQIUbX7IRUK4cWV8bvd6vrGKoXd40lIlUUaOGzt1vxqjsschyVr?=
 =?us-ascii?Q?ILNBmj+MidsnQzgZuCqFYWRLI329Udez0kYT9XXubBU+8xCXvDqv792zvUNo?=
 =?us-ascii?Q?CzxXwTTUy3McpGFwS+HLp5SCodjaFVPYARF1+fsETn7hEW7IBhd5DLWdjta7?=
 =?us-ascii?Q?IOsUteUHvMXhpRO/GZtaOGvZsfxslCk21qkHTXEH4I2Pq2iKlDKETPalrdwP?=
 =?us-ascii?Q?A6R/hF7HCA64yMO3fD/YD04YGVOsVBHrmMt9Ac/i0GFKLqcHPxM2/0/kEuMF?=
 =?us-ascii?Q?iZD/ZXoe8jN6QIO896/0EVX+uSUCc6pmS0SUcItpGEPnSXkc1xdBDVyg52lp?=
 =?us-ascii?Q?jnt4Y3EIQDJWtZR12lh7+wF15/lYatJ/v+1S6bxIXAO1U27rinniKrbIWb4w?=
 =?us-ascii?Q?ULcxEdvR2ygixwoFloqCdGUuwO1Hi0LwNqUQkMDVFA638EcnVqz2AHMLrGPW?=
 =?us-ascii?Q?b2aeF2CirjPp7SwpsQknnKjhF++YTidcN6fYXY+x9kyLjFQ4fsU6mXOEbabo?=
 =?us-ascii?Q?R4ZSOeOQDFVdhWToDF25PV5zLbRwbdxvUptfmVESObPf0b2oggr/9pedbtvQ?=
 =?us-ascii?Q?F9yfi06VGqmeJ4mfy1dlSEmkNhJaWE07zCmRhawCI5uAqfnjiN0BhhJCtxNi?=
 =?us-ascii?Q?1iQ7d8KTpgOyj1k3QOAeNzDrSTUrzTEKR5ERDuU/GKfRm4dzHd54lF0z4K7P?=
 =?us-ascii?Q?xRXhIY13ie1RG5gIzB/6oaZIP9JYGNi0iFABqKpqVhHowKrMCmb2RkzdoC8Y?=
 =?us-ascii?Q?rfzEzc25Ydcu9pd7RBSxFkWRQXnbfMooePLB9zLqPgxW2vjfS4QoM5ww+P7X?=
 =?us-ascii?Q?lhwkqnfVuR7MZize/wNVuHsZ+6XMLiewa8O5FJJs+Rk1dFkKj4twuIs1gtbb?=
 =?us-ascii?Q?lh3nT6fhvhYv6Si5Dt2rHlNHuD4LWkz4pgAUcMM4lN5nyf89HdtNAOikdAce?=
 =?us-ascii?Q?sdDQ3TJLPZgTcVV0+loQ2KkKbMKiOw9o0nKBNl4p1D3d1eHT2v7yla7mk7i3?=
 =?us-ascii?Q?RzJMhh5/eAJffcAAdFL/V2b/v5Ii9zkWCFH4KYCJSr3Kd0mkABHBQMwfLtxY?=
 =?us-ascii?Q?j5SK4Jq5VhQ8eyocP8PbcDCl+A3NRUt8Zk2MepUH+9zDpo97OyXzshVDtkdG?=
 =?us-ascii?Q?MoXwpocNdse7SPA43xyU08ndyeWMpYutFCa1cH+nG3gsRqUKe7dcJEvh0FCR?=
 =?us-ascii?Q?qEbxO7n/ClITbg1IPG7iySxWJ5A6y8R4FOQZrxJwmslQOTcWmRNpDF3Jtrhl?=
 =?us-ascii?Q?xsdZjy23J2TLCp/vlq9s6ZTWK7CO60i5i8+b3JPHWp5dQ/SBFECMkgyE38il?=
 =?us-ascii?Q?pA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8f563d7-43bc-453a-309f-08dc6a867d3d
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 09:01:44.0124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XKCtp3v2ciE4F6h6gEQEbxcVfciZU+ldzFUCEA5dyHhV8nhN2fveV9wAsSJDQGx4CasEEoBjNbQzhfuEN5XdKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9655

Hello Maintainers,

On our DUT, we can see that the host issues create connection cancel
command after 4-sec if there is no connection complete event for
LE create connection cmd.
As per core spec v5.3 section 7.8.5, advertisement interval range is-

Advertising_Interval_Min
Default : 0x0800(1.28s)
Time Range: 20ms to 10.24s

Advertising_Interval_Max
Default : 0x0800(1.28s)
Time Range: 20ms to 10.24s

If the remote device is using adv interval of > 4 sec, it is 
difficult to make a connection with the current timeout value.
Also, with the default interval of 1.28 sec, we will get only
3 chances to capture the adv packets with the 4 sec window.
Hence we want to increase this timeout to 20sec.

Thank you in advance for your review.

Thanks and regards,
Mahesh Vithal Talewad

Mahesh Talewad (1):
  LE Create Connection command timeout increased to 20 secs

 include/net/bluetooth/hci.h | 1 -
 net/bluetooth/hci_core.c    | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.34.1

