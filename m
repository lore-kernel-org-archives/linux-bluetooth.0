Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2046.outbound.protection.outlook.com [40.107.103.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79302146A9B
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jun 2024 07:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719300457; cv=fail; b=M8kaavmOU6ECsz9/gwXkdtFwRQPFaYn1Ve4xU0t0Ie15nTNJ7Boq9FPtjM22miULl9GB+6f0yK3aeKriakv5v5qv4TtpwGoCGzKVqVYi19VdvM4Eql/sAVgUvdycfxx/PHRo9D5/2xjzp+5cnhgEsMnHT0ky0ViSyjRdNw/ehT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719300457; c=relaxed/simple;
	bh=R03emi2npQ/n9BN4+32VMWAZCDN+jSnpaVTL4vHGu7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nb9CTinlwFK5Sbr/WF3eZvxwd7pJK+5PoD0WpMekeIjqnhZCQ3McmVnHViKwlvtknN1OLcleEd6JDebEPo6093rhKTutp78HoVKI5qTq0cR6wYgAsLVx8hGW3RhoqYtBzFlqzC29ezfJ50PuXHS+wgWjnbmTOrj0MBT8WbOLB68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=BFRoJNsw; arc=fail smtp.client-ip=40.107.103.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BFRoJNsw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfLgqUkw6cNiVURWrHaRBc3zmzdYH5nmpM2H2Z6KX8lrbbGtEysPpgRfTGSTWKqJIvLRQ08V2eVYYC5Ph4NHWCD9d9QwUwbjR0lIlAZRFsyBbCBtdEmGGdEiECXDRyPoBLHjoSZiYKrhD5fopjn09/O6Uq08e+aptH47lIorLbazSy3vPB1yzcb7jOYyeTfdwn5v/qUk4aW3TMWurQLScbLNIEd0RlA43W8g/B3DnWMqIQbwKLb4NLFdZciJWOSqKPcw9sUfJiAyRIorkLcfZDzFxNZyw9gxcRP/IvS7QMbLgW7/m2qK8g1xIz1Rf1U2wVLwpXmZCw4WuVJ55Qh5TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYgMK2At+kR0dnCGqhhs5xIw7Z29uvGARpQ65kqeC2g=;
 b=mFDrOFpAYoXes6kL/Hx7HNBei1KL176ZU7LSABfi2+y/qr5PuSXUbD7JHPQCGUH2bbXy61M1Cl1Z56yAmQPX/6aJtv8tr+J8bc4t7B1v5bvguFeqPfuAxzd/Hz99YrGzNoMK2p/mTHq03ppL52jbRcOQniuWXcQcIEK/FwFsn7TExHC+DCmD6c+0NrukDkf3HSFfE+mDJDMu0GMOtDj/B95ZDrcT+Uxxck6NkofZ8zFS9aSQpxHrhy8B9NY1XWT8CMjUgFRzXrYDMRjvruwOEsnFpf1tmQ1ozWRFg24sXoIX/+TkSQQ+ND2HDgz32pbTfM4xD6PxOKQNUQikqPNI4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYgMK2At+kR0dnCGqhhs5xIw7Z29uvGARpQ65kqeC2g=;
 b=BFRoJNswnXbD56F2mcy4yD+bN52r5L+cLRvknR0o5KA/ysfoqEuI7YQz7uo41gXjbNu5qp57CTD/hvGCmy2Us4+OHIBh6oZyhIjUNsbiUtfPs0eWhkqSNl5s1SAVSAMJNMIy3AN0N7xF70/2guFRHFR0euZctkuXoQoCrTs0SzU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU4PR04MB10362.eurprd04.prod.outlook.com (2603:10a6:10:563::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.30; Tue, 25 Jun
 2024 07:27:32 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 07:27:32 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 5/5] test-bap: Add Broadcast Source STR MBIS tests
Date: Tue, 25 Jun 2024 10:27:11 +0300
Message-Id: <20240625072711.7011-6-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
References: <20240625072711.7011-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU4PR04MB10362:EE_
X-MS-Office365-Filtering-Correlation-Id: f8ab12d0-54f0-4e8e-809c-08dc94e84722
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lTvaS8cOVKpy59a0Sh/LAREdQbpXgqfPWtYRTRMqlhTVZDO5x0VZS8DO7hMY?=
 =?us-ascii?Q?WvYvifPnn6vGmx4j/2/oEJg5ExrlDDcFHpHfV/bj3PRL2KDZj2UeRUOkXGV6?=
 =?us-ascii?Q?0eJlJfp3bIDk6KuoUq0ooNHgVdv1L19yj2zwBqcDSNGDjAB7MACN2U/5vWKf?=
 =?us-ascii?Q?qMIAR66WmAthY+mO66k9CAurx8Yglak7oXarelB9wo/pzyP+Pvl8NR33QgBg?=
 =?us-ascii?Q?MfYeXR2zUA0MrMqmNpS2moKb7B+m6EtETziwDECPRBXE4O7N3wyH99TvUwH1?=
 =?us-ascii?Q?PjxzWGm4ObV0XU1Dsx/bbI1TVbHyoMBpl2vQngY7/7eG00rxM9iqIJuf9sCa?=
 =?us-ascii?Q?h8qTiZRK+ujpes7MSkuAH99fvdAGAauLajKZmI/VgB8GlBixN8PfPl3hnqYT?=
 =?us-ascii?Q?WomGPfpqzS+tSAkP7YW62rxPuMxuCnwpUicoqgzwlV90+OsYgk59YvbiowCh?=
 =?us-ascii?Q?dBN/34Fhhl2V3pz79Xm0D3SazjYoqcLHyzRLetWHTcN7hSL2e4Sho30fuYmS?=
 =?us-ascii?Q?mEcFHVOGYtvnYsFciepFs2bGf9DRC176os1685c9oiahyRFsVrvmOWjMvA5Q?=
 =?us-ascii?Q?QN+qylFQ/owwHgQWr1VzOosq27n4wvrV7umwKLHLLobbmIbOClM4RRPLToZN?=
 =?us-ascii?Q?y3H8O84YZoIZr724IDOtMEWqpFUzucBaGonLQQnROtS/GJgV/BSY+Ee/PRyQ?=
 =?us-ascii?Q?LVT5xcFbmO4D+h8ZRu83PfB4VKtxMaNVXwNO5JLw1XTZgpHJvCqowA3Q5D0j?=
 =?us-ascii?Q?t9ZcCMTH/5NjE11Te5v/wG0VjhEBdrdGg3bNCqrWddhAtwL0ROtjP+pOmDuk?=
 =?us-ascii?Q?cI3HuC3psWjYwSlaqtVzqKpaxqb9VeqGspykgUMLBaOLne0Km32yQCtLCQP/?=
 =?us-ascii?Q?9ivLTvcrW41Dwuds/1XwU4eL394Bq1WJYAaV174y5pHzZMQwWn9gXlpCQ1oi?=
 =?us-ascii?Q?TY8Lb1QDT/2q67WWHP7dBEAI35cZX4pIoHvJy30NQX2xaki9+N9cGCWDUKBs?=
 =?us-ascii?Q?436d1JgO0806MFVN4Pdic5WT585vJPljjbH0PDYFOm3934tZOsMrZ0nwFjk4?=
 =?us-ascii?Q?W5PmkBZtA7LTXkJ+cCylWrP5JQpdXlvtHcdwdDUA0S9EVpMhqXFMEQOq1RNc?=
 =?us-ascii?Q?GGEheRSQUA1o2swpKTgL3XklIni+BvsBeSnTB7r3RNXhbcP4w1DOrO8FrtIu?=
 =?us-ascii?Q?X26ndgAue0hvsy0zH5CvPh8LaSnLeYRsLCeee70OyfwQb91wyMw7B51xpKWc?=
 =?us-ascii?Q?p318ALUz2QexduvYI5FRRPqbGDINSaniMzr340FWoGw7ErJPokbOY3SRss3Z?=
 =?us-ascii?Q?9lMWzrp9CsNJi+nn5EmW2Rc2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rmxtBGObFJ/t+R9/a8CvD2xLuiojxUQg0/NeJBfQomEP2A8yaKCnmT+Xxtby?=
 =?us-ascii?Q?yIgplR44Tyjm+M1cud+N1qrHyKbCBe3wHseks+Bo7mdALJmczE0ZWcEOUKvA?=
 =?us-ascii?Q?jsYLXjkkTr3lKvL7ADsLmtXybJcHgq53RndxE6PE/dC+W6py8eKcjemkaAbX?=
 =?us-ascii?Q?RYneW+fHayI0uw3qphkIPTVm1Sj5hC6bQdb+/hHL5O2TRUGJ7ahu31pF531O?=
 =?us-ascii?Q?Wwu6G/f9dUKjfNDMg9RU0585Nzq4acSc0WyLfRcqAnFBe/gdIiWjdoEiAEq7?=
 =?us-ascii?Q?mMUYjUsYWFZuQ7A2/07nMdc7cL/iWVpmUOJvIReUwDLYBLSip+mKu/W28uMg?=
 =?us-ascii?Q?RWAWJ+2a9536bCRhCLfnSdLULdoNv9gQch2rdy6241gXloOpFHwZ8F2G1MCg?=
 =?us-ascii?Q?2GnzkDZX/PpX4sG62fX8tiaGR/jq/t91Ern9g4UlCDUKVJj84JQ8BYzz+LAt?=
 =?us-ascii?Q?bx/PFchFjj/TGlW3Ai9uTJk3yrIovygO8tjVvqTTCJcsfxYVeNHOnXnzVIae?=
 =?us-ascii?Q?I4zRbqTcLxQ0OQ127z940AZ2PZyq890T7+Q558/kq+9p9TM/TMR4cP4czLgF?=
 =?us-ascii?Q?wfDEzqDkziAGKOFymhL9R2EyA6WvBNJM9bqN+3D7lmJyunf3xAB8mSp8OEHf?=
 =?us-ascii?Q?EyfMqn+MM/3fbLHbkaCcvh3uR+oIO3rnkhcY/u7lMHXjhKu+nnGGQ58OJMJ5?=
 =?us-ascii?Q?w+CnV8KnA+6NfMbnS55bV8VCZSxxq/r4s/rIEqxbD3/CUJhZhf3QpY2GhZaD?=
 =?us-ascii?Q?OWhepIIeIwpM3jcEHZH8F1p9IAq9Kad+wBvGCBArYGTOsY6uzFR8pi093/eU?=
 =?us-ascii?Q?iILPXCHOFXD1YYvMzGdD4y57n7sWbgafRXXScaY25op8n+xSQVVtnqF7/Thh?=
 =?us-ascii?Q?h/eLSdWh0ap2s9hFzNH0dOHlrQhB/UrvFmtyL1EiQsn249cT7LkZZCxhUgIN?=
 =?us-ascii?Q?KSPg9Qu9duNl8zLdfsm7QnPpK5tKvagFn2YBTm8jlyUADznZCOJz8JYI39yg?=
 =?us-ascii?Q?1z8nBCpSb6rgzDxv3rfs4pEmdOSo+K5YLl0uOFr7NceTEGcAS2/E+rNiMAW+?=
 =?us-ascii?Q?vBUJsnxqf5sHa+MxKToChbaT7MaIN57X767xLLKbcfC7l/wJG87JyP6EgE/d?=
 =?us-ascii?Q?foV95HbpTrhKkxBraiE6kC5Y0N/cOOqlxE//q1YWZgTcmJ1jsUGiv6FikTZD?=
 =?us-ascii?Q?gWcxJTMZ88T2BzMWsKSIRKEr5VquOVz9jV7gtfC6oyZA+ttoZaS9RORqRdBD?=
 =?us-ascii?Q?5lMrfrY5RX0CvrR7dhX3Lu+V+cTzgN+Va3DrSA8M7BDZ3cNgFB9PYIflFBtg?=
 =?us-ascii?Q?6gL+MJ1N3M9L4OAHczxBEm7h80leQxYCUcBy54yBnMqZQkN2Uzk5zPkMxvoC?=
 =?us-ascii?Q?dor5T+RGY6sCY9B/5eiL43NN1cZ1hT6bF/7S5Ph2R6YAVlqRefkpJ5xIPWRv?=
 =?us-ascii?Q?AUcxDvRwAx/d5eeT4zWeTL80Sxn5FDFjU6JewUA84sHyzgHzRwuveqaI1K6i?=
 =?us-ascii?Q?6CKa9/m7w0lY45toa7eZyNzoxcvVaE8CzaDiFIIzKXj37HeLnxoWtU+46Rnw?=
 =?us-ascii?Q?5P2UtIZcBEnhVaJnJga8NpvHjH9Kn6oaw0d7wE1dVNxKCgadrrwjegi0X09O?=
 =?us-ascii?Q?cA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8ab12d0-54f0-4e8e-809c-08dc94e84722
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 07:27:32.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hO1LutAL1m6r0PHj3VeRG8x4XeVAr81zBzbe9uwqyHw1ZJyWU+1DnJx79+v741XGUwAX3GuszR3rirQ5zJCh1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10362

4.14.3 Broadcast Audio Stream with Multiple BISes - Source

     Test Purpose:
     Verify that a Broadcast Source IUT can stream multiple
     BISes to a Broadcast Sink.

     Test Case Configuration:
     BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]
     BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]
     BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]
     BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]
     BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]
     BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]
     BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]
     BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]
     BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]
     BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]
     BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]
     BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]
     BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]
     BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]
     BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]
     BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]
     BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]

     Pass verdict:
     If the Codec ID is LC3, the IUT sends encoded LC3 audio
     data in BIS Data PDUs on each synchronized BIS.

     If the Codec ID is a vendor-specific Codec ID, the IUT
     sends BIS Data PDUs on each synchronized BIS. The parameters
     included in the Codec_Specific_Configuration data are as
     defined in TSPX_VS_Codec_Specific_Configuration.

     If the Codec ID is LC3, each parameter included in
     Codec_Specific_Configuration data is formatted in an LTV
     structure with the length, type, and value specified in
     Table 4.83.

Test Summary
------------
BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1] Passed
BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2] Passed
BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1] Passed
BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2] Passed
BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1] Passed
BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2] Passed
BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1] Passed
BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2] Passed
BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1] Passed
BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2] Passed
BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1] Passed
BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2] Passed
BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3] Passed
BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4] Passed
BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5] Passed
BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6] Passed
BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]      Passed
---
 unit/test-bap.c | 302 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 294 insertions(+), 8 deletions(-)

diff --git a/unit/test-bap.c b/unit/test-bap.c
index 9b75cfc80..9dd7a45e8 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -6825,27 +6825,86 @@ static void test_bsnk_str(void)
 		NULL, test_bcast, &cfg_bsnk_str_vs_mbis, IOV_NULL);
 }
 
+static void stream_count_config(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *streams = user_data;
+
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_CONFIG)
+		(*streams)++;
+}
+
+static void stream_count_enabling(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+	uint8_t *streams = user_data;
+
+	if (bt_bap_stream_get_state(stream) == BT_BAP_STREAM_STATE_ENABLING)
+		(*streams)++;
+}
+
+static void stream_enable(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+}
+
+static void stream_start(void *data, void *user_data)
+{
+	struct bt_bap_stream *stream = data;
+
+	bt_bap_stream_start(stream, NULL, NULL);
+}
+
 static void bsrc_state_str(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct test_data *data = user_data;
+	uint8_t streams = 0;
 
 	switch (new_state) {
 	case BT_BAP_STREAM_STATE_CONFIG:
-		bt_bap_stream_enable(stream, true, NULL, NULL, NULL);
+		queue_foreach(data->streams, stream_count_config, &streams);
+
+		if (streams == data->cfg->streams)
+			/* After all streams have transitioned to CONFIG
+			 * state, enable each one.
+			 */
+			queue_foreach(data->streams, stream_enable, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_ENABLING:
-		data->base = bt_bap_stream_get_base(stream);
+		queue_foreach(data->streams, stream_count_enabling, &streams);
 
-		g_assert(data->base);
-		g_assert(data->base->iov_len == data->cfg->base.iov_len);
-		g_assert(memcmp(data->base->iov_base, data->cfg->base.iov_base,
-				data->base->iov_len) == 0);
+		if (streams == 1) {
+			/* After the first stream has transitioned to ENABLING
+			 * state, bt_bap_stream_get_base will generate the
+			 * BASE from all previously configured streams.
+			 */
+			data->base = bt_bap_stream_get_base(stream);
+
+			g_assert(data->base);
+			g_assert(data->base->iov_len ==
+					data->cfg->base.iov_len);
+			g_assert(memcmp(data->base->iov_base,
+					data->cfg->base.iov_base,
+					data->base->iov_len) == 0);
+		}
 
-		bt_bap_stream_start(stream, NULL, NULL);
+		if (streams == data->cfg->streams)
+			/* After all streams have transitioned to ENABLING
+			 * state, start each one.
+			 */
+			queue_foreach(data->streams, stream_start, NULL);
 		break;
 	case BT_BAP_STREAM_STATE_STREAMING:
-		tester_test_passed();
+		queue_foreach(data->streams, stream_count_streaming, &streams);
+
+		if (streams == data->cfg->streams)
+			/* Test is completed after all streams have transitioned
+			 * to STREAMING state.
+			 */
+			tester_test_passed();
 		break;
 	}
 }
@@ -7078,9 +7137,236 @@ static void test_bsrc_str_1b(void)
 		NULL, test_bcast, &cfg_bsrc_str_vs, IOV_NULL);
 }
 
+static struct test_config cfg_bsrc_str_8_1_mbis = {
+	.cc = LC3_CONFIG_8_1,
+	.qos = LC3_QOS_8_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_8_2_mbis = {
+	.cc = LC3_CONFIG_8_2,
+	.qos = LC3_QOS_8_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_8_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_16_1_mbis = {
+	.cc = LC3_CONFIG_16_1,
+	.qos = LC3_QOS_16_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_16_2_mbis = {
+	.cc = LC3_CONFIG_16_2,
+	.qos = LC3_QOS_16_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_16_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_24_1_mbis = {
+	.cc = LC3_CONFIG_24_1,
+	.qos = LC3_QOS_24_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_24_2_mbis = {
+	.cc = LC3_CONFIG_24_2,
+	.qos = LC3_QOS_24_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_24_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_32_1_mbis = {
+	.cc = LC3_CONFIG_32_1,
+	.qos = LC3_QOS_32_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_32_2_mbis = {
+	.cc = LC3_CONFIG_32_2,
+	.qos = LC3_QOS_32_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_32_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_44_1_mbis = {
+	.cc = LC3_CONFIG_44_1,
+	.qos = LC3_QOS_44_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_44_2_mbis = {
+	.cc = LC3_CONFIG_44_2,
+	.qos = LC3_QOS_44_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_44_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_48_1_mbis = {
+	.cc = LC3_CONFIG_48_1,
+	.qos = LC3_QOS_48_1_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_1_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_48_2_mbis = {
+	.cc = LC3_CONFIG_48_2,
+	.qos = LC3_QOS_48_2_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_2_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_48_3_mbis = {
+	.cc = LC3_CONFIG_48_3,
+	.qos = LC3_QOS_48_3_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_3_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_48_4_mbis = {
+	.cc = LC3_CONFIG_48_4,
+	.qos = LC3_QOS_48_4_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_4_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_48_5_mbis = {
+	.cc = LC3_CONFIG_48_5,
+	.qos = LC3_QOS_48_5_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_5_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_48_6_mbis = {
+	.cc = LC3_CONFIG_48_6,
+	.qos = LC3_QOS_48_6_1_B,
+	.base = UTIL_IOV_INIT(BASE_LC3_48_6_MBIS),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.streams = 2,
+};
+
+static struct test_config cfg_bsrc_str_vs_mbis = {
+	.cc = UTIL_IOV_INIT(VS_CC),
+	.qos = QOS_BCAST,
+	.base = UTIL_IOV_INIT(BASE_VS_MBIS(VS_CFG)),
+	.src = true,
+	.state_func = bsrc_state_str,
+	.vs = true,
+	.streams = 2,
+};
+
+/* Test Purpose:
+ * Verify that a Broadcast Source IUT can stream multiple BISes to
+ * a Broadcast Sink. The verification is performed for each set of
+ * parameters in turn, as specified in Table 4.82.
+ *
+ * Pass verdict:
+ * If the Codec ID is LC3, the IUT sends encoded LC3 audio data in
+ * BIS Data PDUs on each synchronized BIS.
+ *
+ * If the Codec ID is a vendor-specific Codec ID, the IUT sends BIS
+ * Data PDUs on each synchronized BIS. The parameters included in the
+ * Codec_Specific_Configuration data are as defined in
+ * TSPX_VS_Codec_Specific_Configuration.
+ *
+ * If the Codec ID is LC3, each parameter included in
+ * Codec_Specific_Configuration data is formatted in an LTV structure
+ * with the length, type, and value specified in Table 4.83.
+ */
+static void test_bsrc_str_2b(void)
+{
+	define_test("BAP/BSRC/STR/BV-18-C [BSRC, Multiple BISes, LC3 8_1]",
+		NULL, test_bcast, &cfg_bsrc_str_8_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-19-C [BSRC, Multiple BISes, LC3 8_2]",
+		NULL, test_bcast, &cfg_bsrc_str_8_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-20-C [BSRC, Multiple BISes, LC3 16_1]",
+		NULL, test_bcast, &cfg_bsrc_str_16_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-21-C [BSRC, Multiple BISes, LC3 16_2]",
+		NULL, test_bcast, &cfg_bsrc_str_16_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-22-C [BSRC, Multiple BISes, LC3 24_1]",
+		NULL, test_bcast, &cfg_bsrc_str_24_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-23-C [BSRC, Multiple BISes, LC3 24_2]",
+		NULL, test_bcast, &cfg_bsrc_str_24_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-24-C [BSRC, Multiple BISes, LC3 32_1]",
+		NULL, test_bcast, &cfg_bsrc_str_32_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-25-C [BSRC, Multiple BISes, LC3 32_2]",
+		NULL, test_bcast, &cfg_bsrc_str_32_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-26-C [BSRC, Multiple BISes, LC3 44.1_1]",
+		NULL, test_bcast, &cfg_bsrc_str_44_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-27-C [BSRC, Multiple BISes, LC3 44.1_2]",
+		NULL, test_bcast, &cfg_bsrc_str_44_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-28-C [BSRC, Multiple BISes, LC3 48_1]",
+		NULL, test_bcast, &cfg_bsrc_str_48_1_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-29-C [BSRC, Multiple BISes, LC3 48_2]",
+		NULL, test_bcast, &cfg_bsrc_str_48_2_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-30-C [BSRC, Multiple BISes, LC3 48_3]",
+		NULL, test_bcast, &cfg_bsrc_str_48_3_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-31-C [BSRC, Multiple BISes, LC3 48_4]",
+		NULL, test_bcast, &cfg_bsrc_str_48_4_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-32-C [BSRC, Multiple BISes, LC3 48_5]",
+		NULL, test_bcast, &cfg_bsrc_str_48_5_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-33-C [BSRC, Multiple BISes, LC3 48_6]",
+		NULL, test_bcast, &cfg_bsrc_str_48_6_mbis, IOV_NULL);
+
+	define_test("BAP/BSRC/STR/BV-34-C [BSRC, Multiple BISes, VS]",
+		NULL, test_bcast, &cfg_bsrc_str_vs_mbis, IOV_NULL);
+}
+
 static void test_bsrc_str(void)
 {
 	test_bsrc_str_1b();
+	test_bsrc_str_2b();
 }
 
 int main(int argc, char *argv[])
-- 
2.39.2

