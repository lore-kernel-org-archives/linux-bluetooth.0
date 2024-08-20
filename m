Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011049.outbound.protection.outlook.com [52.101.70.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F243518E370
	for <linux-bluetooth@vger.kernel.org>; Tue, 20 Aug 2024 11:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724153521; cv=fail; b=oUfpbPk/h4wa1AngCEYTGsyeYN0T1ot/GW5jpcgcK2HlTHvdkqPc31UFa1w3JUZQzYECMYcRn/f+TjlzBhvbQ4ND0CNhs79XZcezjz2SCMlkDdWHU5qN8cQc8EpV8eQTmY5cVCPckt05PLkDe5XdTTNC4/6MjddmbcKx+xCygF4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724153521; c=relaxed/simple;
	bh=XliIKhSdPp8+fjDPwPI6/tqG1XtIMuaJswL9KoLxa98=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SbRFvONVbD6Cylo95Dh/dm6hPgRtt2JEN0At+LI8/aglyDtYOjiTx+3fYIkAuwKjl/UOe8BwgkCm1fa8CANtmCtbXWGkx8Sy8i42VLszaCM3Lc8ADkyBH1ZwPSQwisgrieVhaUZ/4UJQjCRQZffX5qlQlh/vWG3OTcng3hR2kG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WMxVE1xD; arc=fail smtp.client-ip=52.101.70.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WMxVE1xD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V/rvGd8V9H084nLZ6v+aevKWK8tX2u5QWOQSMCCp95ZWGR4v8fzTdHFD3l9YwCtxtGvukXoc0+vEY7nEnAO7YG6MOk2A/kagxF00AF/9448cU4atAeFW0+RJdIRgJAddu6AbJhb6cFZvfgIgzc/RIhdMw0e/oCwa9m+YLeRTrRSft7WhAKrMCO/22Gog6OP3JIMjogSc7Vc/zERke2km+QZUHSI5JTPxMR/tgmvGr6DEZmGQ6x1xa+Qp31/2Uh2jXPZ6uCR+lHTnY3rgKSzK0fL0qFyk8+Ov2Y15RwZZStLP1viF6S3iB6RXUnkVsQMuZ0qGMNINkJzSkBdfZgAHbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ifvNvo/V6XUKSSDB60NaqMS/bOqLWU+Hfg+o+yVZJY=;
 b=kRNh9QwS8o/zYt/yEAKLLLmXLJ3l2ozokL19quw96r5Nih/9PAN/G3Gk0F2mLaaUtriJXb19t+GjkSBq5f3VM7zat17+FJtrKSC9nBah8Y2olRRQUVoqLI3jNGWci6tZyemJNG9/TyHbIiZoX77z2yLvRDn3a/jXtYKDziqjiLf0y3/trAv3ZTQbsumiUqL1CeDpcs0bsYm/FwqA/FAE1kPPJDqgtDe0JrAnBx/Jlh5Oh/bbG/dM/j92UuC+GTeT58hSz5XxaOr1QNidEPTGlQtQXVOmEMWk+5nYO3+eY0e6hCXiOxc0vs/twPckeRLOIosXsK14L3Bp//sR547z3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ifvNvo/V6XUKSSDB60NaqMS/bOqLWU+Hfg+o+yVZJY=;
 b=WMxVE1xDTxCSSOy4gjna9UhephgjHJyjcFKGguAK1E4HK11GrlFSqjYAN9zqChBzWd9WZvnUznFpjJkFyyZ8sWiG/RJm0PyjAmEujjOYP2EsEwb14jgW/fPtayxNKSly3z1eIkUnib4A1eM+cJO/ZrBzMPlciVNPTdhTmCT9Cs3rgU+Cap81vqyGV3qbL9SdKvKtl/kVvW/FIdtYLz4acv2+4Gywion5ao/ZJPG8At11oVzvMoN8hmMFTuXrCr1lPhserMYbvNxaW03ebE9c9ycysKgWuprzu5+GOaWJxtPNV4u/8DLN+Rk+xlYCi+w4OYnXDwYb1qAMqeJ6kA/e+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by GVXPR04MB9993.eurprd04.prod.outlook.com (2603:10a6:150:112::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 11:31:57 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7875.019; Tue, 20 Aug 2024
 11:31:57 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] client: Add bluetoothctl-assistant.1 man page
Date: Tue, 20 Aug 2024 14:31:52 +0300
Message-Id: <20240820113153.25708-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::35) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|GVXPR04MB9993:EE_
X-MS-Office365-Filtering-Correlation-Id: c04801ca-313b-4d2e-598f-08dcc10bb2d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APfzlIlf9TLHQT0BeztYBpyD859voCTIiGMYZckCDxyOA9JTV9g7zbQrvVPL?=
 =?us-ascii?Q?UOjqv0uIsbhbr/dp226OKTcUXtNo8B93AouVt+qtlcV9UFHg1sc1sjrBVthV?=
 =?us-ascii?Q?mUL9BEt95H8oLdzlJwHu9Kegs3/okVSAmHCV+gd32HMb1+gEthZYUdla/LN5?=
 =?us-ascii?Q?c1hyLYnYiqaSiQ85o4SxV+rYN3/zS0Hgt92Rrdoa2B0aJBnusa9ff65DyZ6W?=
 =?us-ascii?Q?O6/ePqh1aZrrXmrhzR7Z1oSYcr1TGbmoQV1N/Z9mRYp+nM3ISkNXkY8A1z56?=
 =?us-ascii?Q?wLtTEGvzNpNhoR7NQb+/ms1lebiCNzPZehbl1CORqJ37hqWFo3aa/vCroqze?=
 =?us-ascii?Q?iKWGNEjy8oD3cOiCoUpLa4oJmVf/ijHwBRpqdmwNQ8b1Jp+NVu+cZoIUKarw?=
 =?us-ascii?Q?3NHVjHnEIzEwdVWNv2d0kPAOkVnWRpCMQrjXN/7hrg4H2eiGGJx0BuVQ3OGc?=
 =?us-ascii?Q?Q8YoIN2UuOBNnCoXdunzFFRPqkBEboriZcRqhHs0rVHUXFDXTwZ4ijlD8nEG?=
 =?us-ascii?Q?hKQf/q0QABVAf/kRUU+/riP8pi0/tEdoAOQcT+J+tHhBxLWL/VKIu2DXCea4?=
 =?us-ascii?Q?ruSEsxN5cCxouIEaTuhzBlw2/rjlQH6+ZqWXK7d5ETMZl/Q188KlAmviUUcI?=
 =?us-ascii?Q?3PoEP1RB6WICqoLG3r8Pi3QCSOhItIjavYsDFsAF/DSZ08gJhzuP86ajRR5f?=
 =?us-ascii?Q?O3taxVcUnLtWcAz4CRfHYTCHQqKZUt61UwkDE5VKluel8e6lfJ5oJ02YbsuN?=
 =?us-ascii?Q?0XH5bCfq9UuFDd9AyfSOmmKclyYUW1zJYR6Vwahz/0VfVOdW45ueIiEa8FNx?=
 =?us-ascii?Q?Cnj2KxYxMUtO25YhOQ8kPJRyLtiXHC9Cy6dHhcb6Q2Z7/qnbRUH8oQPj03Cr?=
 =?us-ascii?Q?lncak3qsGsNtkIHHwmpIlsLIcMqxcoHeSYwICb6DY9gqwYVaMXTShKPXN0lu?=
 =?us-ascii?Q?/32n6BQq/La336Mg34yAt3qsfjEv7Y4grud5+8TCV0U7pkRZBSZaQ50Wg3pg?=
 =?us-ascii?Q?LdJuzcelOC1hUlLA8YuNsaeJ7yeCThQYommRpdMrPDdsgT05rvQ9+6foBznN?=
 =?us-ascii?Q?Ay6efWARApwOEhlq1MT1bDZmL/RfUKFwI2iH2XrwL6trZILSjfRfS3VnyvoC?=
 =?us-ascii?Q?PfdhgMlLwPNXlhZCqT5unWVSKC8FHGSB8DNE/ZlA60c159R1TCao+af+hzag?=
 =?us-ascii?Q?MnPlOMmxtZVxBQrH23imOz0nNDqBPJZP0kGwGQD9TYDwZH8pMF84lLKHP2bt?=
 =?us-ascii?Q?MtiOCRaJjubkD2a59SrjNVCmOuo25+hNXp3sqsRObJmrHPfcPWuxHYQDzQfe?=
 =?us-ascii?Q?1K1E1US/veB94M/6v+t5ELUAmYfEHzgTWJM++xNavlookg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?b4DEqIND2orYawvSn/ob4OqJujhJa10AhWF1LHOppM8do9TeDTzdm7nG6hbE?=
 =?us-ascii?Q?qNFYz/sCq9aojWZIUbgcQ/6DMGL2u7dH6GnFnfM2WJxLMpra+UQvkUBiM47S?=
 =?us-ascii?Q?dmCUbgl1c4U51URRuRaKBh+33ZY+/ZHkNyG8SQMgUbFvRMWXJyWAfxfX+Ad1?=
 =?us-ascii?Q?n85Pd3aIVfFqnAEfybCcRnSr73frwJHWcINoP22gQoT1rU6mr0907teF1K0b?=
 =?us-ascii?Q?PDvYt35ePp2TMgViGdRCPiYCbROM0D4r1ziLypGSXS8IHEV7dtd7ZRauPvi6?=
 =?us-ascii?Q?+KO6CSuhFwHeG2tRFak2aFdrHg6yD1soHVrPrdfG80kPbcZDmuqqwdN2cAiQ?=
 =?us-ascii?Q?dkBTfe2Etnk7/bDQkytZfVzh85qaSrmnMuCUx96xFfPuex2nSnzGzeGVPyRe?=
 =?us-ascii?Q?plzV+PEKyv2G4eWeeNbbjW0x5uRF8iVnNOxj0r0PfVWLVVSN6MY6LFNVl3qT?=
 =?us-ascii?Q?yRetIpt4UmZvXe0tLxr60FKcIQSmIMS+9fCOW2Nn4wL3yRw/wYt3htqRHs+H?=
 =?us-ascii?Q?ObVo3jPAIffljrA9j/YxbQetvDDr1HSLI7NZGodIKxwbHgqZ/Orer0GGTA7x?=
 =?us-ascii?Q?XDbhpGDCkY/dVkcMLs/VLR/fMO4emrEFqJkBYKR0p0mh+UfrLPsLnbtHW191?=
 =?us-ascii?Q?2ql4sUqwiz/F4BuZbAURtIeGdTW03cfr2YJuINbNay1uP5pkYtz94D2IZlMf?=
 =?us-ascii?Q?Ai/xaIXFsXkI5xdnSVa6g0I74y4TjzaFn1/Puqzlsi+idwDT3eczn6AZs4rt?=
 =?us-ascii?Q?jFLaQ1Arf0dR3N0abvNvCIQ0k0gqsH9HFOnKDhOoWACF5ePVqLJoznBNeLRp?=
 =?us-ascii?Q?Iyd0a4IXYVLtJeIQBa5wNsiV7FWm8qCxZCBaXevkfRw3yvymcPCSfbpsT8Db?=
 =?us-ascii?Q?VGLkgikldyQ1IJvAnH0Yl0HIIDYGdSPyXmgIxjtAWU0moA7Mhjj5UeyTOEhl?=
 =?us-ascii?Q?aD7MremCsFhMSg/HVcpUcmIVVJkvsMcVXivHyFIixb+QNeCWWusem/gAXauF?=
 =?us-ascii?Q?wOys6lFzyIx18Cg7H97tcNUgzBC8m2VS09PZnLyYIltiIyMyW+AVo8ILJlgy?=
 =?us-ascii?Q?tNwa2hOKLZT8a6uoMRk7F4qXehOqa3vkhGTe7htKlRo7Ow8KW4SZ3WG468HJ?=
 =?us-ascii?Q?Kshmscl63mToVTNNrfSOg10brKwrcrLVisvNxXczRmqXtHSxE4IGFchLEynl?=
 =?us-ascii?Q?HuoHBJ7JP2bjV/pr6CCsI34PFjVZffss599uV0PDUhm2PmEphcUMJtfzIUnT?=
 =?us-ascii?Q?tJVGcDcDPSgowEdfr/GnLotuhRZqBBjHT3bOPsLvXlcB4s/uo2uGTRxVIcag?=
 =?us-ascii?Q?A0dalDgFPkQZ2I18CxitEJJVnU/SI+vlCPSAJezYtsWbIJL9/8a9hKfPSbE/?=
 =?us-ascii?Q?C8ZP6rlcp5I+lcR2iWm2O3jKu5cwGzdm1cb+tTBGPf6M5B8KZIv/3pJRzTrb?=
 =?us-ascii?Q?jR1stmlTS/k8RLdgA5NkWilwegKQm7BtfAAET1+JkfSBIeV56ak6kQzW67Sm?=
 =?us-ascii?Q?AyroFFAvS3rJHqhJ8V3b7TgRMyLPa3OmuDULEHM8bSA0rBTUJPW008SYCfO2?=
 =?us-ascii?Q?Nidd6XgYvNVzaWhPegQjLSmXn8j5jyC6GYBUeXgLK+0i9cUhyrER89aLBkde?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04801ca-313b-4d2e-598f-08dcc10bb2d7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 11:31:56.9822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yABKaoGDWsKqgP6ta3Xc+y03LYAuz8lpz00pAhVbKGPCBS/tUp/XqawiuedHhBINllubWS7kbcvNbZedfMhLOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9993

This adds bluetoothctl-assistant.rst which is then converted to
bluetoothctl-assistant.1 using rst2man.

Iulia Tanasescu (1):
  client: Add bluetoothctl-assistant.1 man page

 Makefile.tools                    |  6 ++-
 client/bluetoothctl-assistant.rst | 63 +++++++++++++++++++++++++++++++
 client/bluetoothctl.rst           |  5 +++
 3 files changed, 72 insertions(+), 2 deletions(-)
 create mode 100644 client/bluetoothctl-assistant.rst


base-commit: 29d4540828a10148881dbb5c09acaebf1469dfb2
-- 
2.39.2

