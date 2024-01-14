Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2052.outbound.protection.outlook.com [40.107.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1476B14010
	for <linux-bluetooth@vger.kernel.org>; Sun, 14 Jan 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7Lhy353"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRHpBJu2CE5phm/Pi+wPvkqgj59dg8wKcsQVxDApy3vFW3q345sRHTs+UQGWblB6sfojVFolRaKd7IxOjITYdvN1rCbgvA/lMWeMLildEyeARAp2IVDMawCo/fS02/F6pGNgrM0fbjQYHnk5Kxsq/AB8LM+HMJ73iZr/DrAst6/7YAR3QeNDwOCzssWBGkP9ZooZkbKiagxMGbIghJL8Yvt5dLEagvejcFMcrsisYZL2nPc7lk1cDH9aj+IJUzeVy13m4MMN8I9hTJaDAPWwt9otkAssQlz+cLKRStCcHH8ivZ0rEep9hzDKLpHjTrJVEQcYQToyhO2PqjyHVzKtDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0jZhE8S0+4ety6uJGrF4VfVve6jr6kHwvYqwlNmCHE=;
 b=kSIV9cLi2edhujcWuRdIcgjBGXo/4Hc00labZ5yAu8wvqQpyr8VcpcnHXj/WfmiOnfQ3O3JnS9QyNKErd23+2GM0E2skmvnssIpqEL57+poDY2B7gDV1vTa5MEGOH3eD2unvLG1rWeYaK2QY/KfN/V2+JpJ484E1QA2wyCzZSg22NdEQYaEteMvu+cIR7uXQnQOhOhNet2dkhTwgHHMHrna6VA7M8LIRP15OKytpwcxKKUkAjM1wZMUgiSjvpZ1hwwukoMNNf5eB0V+opVXWCGFPAZfn/+rMZe9IZw955kVqUgijLriS00tfDICWHKOKbKoIhpnxXrM+6A6zIb5fDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0jZhE8S0+4ety6uJGrF4VfVve6jr6kHwvYqwlNmCHE=;
 b=A7Lhy353LipIxUZ3iAosSgp02Os2/6/Jmpy4zYagTzwR5C9YJLCE3qMnImI53Ix+Hp4HMuiSWqv2dXVtakXJfNj4QsJBPQivCSaKfAmh0UX/PHJybSHmdzdeRSDs43Gx5PWr9lGrWkI6gBPbqZFjHIAIzhUKnM63kggTLOFx7yw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB8961.eurprd04.prod.outlook.com (2603:10a6:20b:42c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Sun, 14 Jan
 2024 22:41:07 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Sun, 14 Jan 2024
 22:41:07 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH v3 0/2] Add code to support dynamically generated BASE
Date: Mon, 15 Jan 2024 00:41:02 +0200
Message-Id: <20240114224104.37716-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P190CA0032.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::45) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c43dad9-f6ff-426e-0d85-08dc1551e5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Vbz6fBgFbBAXjC1lPS7uXN2X9Qsq8KanIQT35yx4RKGQbnXIPcC0QpFgB/HKEPN3wC2jFkCximm/c23NZnkiBpcDMiWkNHsHI/mY3uZgBPWUhIjZDb3eQu3HzLqu3/jpvzFLOuk//n9OAu2Bg315TOeoL1KR6lDr5yQgJMW78E9tml6ye1fnFie8Z0r4DcdY2rOyn1lhSdIdiu3subEDA+ttGti9WUpI+88yGBm2YX+Glnp+L8h5TbQ8myVh/2kGRwoRxwh+WLJ3m9opyNOTAWvD6KrmI2o0TRi0OgJ9YFk04UGB76cg3slj39zbQIzLOPdvfJIsoPokdF8u57KRMPa/rDJCAqvKH8JU+4/cied7WefVOR/M8M09OvQwp1O8R0EQZJsyWLrMBCJ+4KeWwopMDpPvQkhhubNMCGl+IUZiyeQkn/Y5YT/YzZNx/YMuw2lpPgd+kOqMyhbFqqPrGQelWFX+ePWib+JJDkR8S6epC+lId1Hd9225QKWNL1zO+hnuwJZKDTZ/KZkFX++r48tWktigQ6BU3y+x6pbnaSbXBKx0D5O3F2yPBB9DGf4u
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(5660300002)(8676002)(4326008)(8936002)(2906002)(6916009)(4744005)(316002)(66476007)(66946007)(66556008)(6666004)(6512007)(6506007)(6486002)(478600001)(83380400001)(2616005)(26005)(1076003)(36756003)(41300700001)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ywRH3nKovI2OKwpcbDg6vVq0fGeMZm3ioqkjEcyL/ZEBnUgqln75F6YaJIBI?=
 =?us-ascii?Q?vdq2jc67tv2/f3sWtgReXBmV+A5LWx88/Vr2UZKohR97X2q8WbHy44+OcXck?=
 =?us-ascii?Q?RlOeCQn3fA15nno3tFJPWEyelBAFB2C1ALFhYHnzVKD/wRJ4ByGok4wHs8q6?=
 =?us-ascii?Q?7iHG8VcYHz+e4T7R1tgm2Iryk2Xhwho2DXJa/1xpTcwN6gbQvkGsrvXCoB1o?=
 =?us-ascii?Q?ICIanz2zfEfjnqp4JlryQSjOM2IQXsRKJjoLMAz1M5Ipv593ZoaA42ecS/Q8?=
 =?us-ascii?Q?39lzno3yE7TdCb2LjqXOJxdhOF9XLr1Cw+3OmIK9ACUkAc815/JBbWu61kh9?=
 =?us-ascii?Q?ewlnLG3xYjzhsYHdeAdsTpOkL0n4OThO6Y0+LT1T/gBKVq71cti7Bt0Fa6bu?=
 =?us-ascii?Q?o2z+iMAd98lcCzcADdB4TuRgMp7XF3E4aRJaLhTzHUn+XVNqK/FiseEa0YYr?=
 =?us-ascii?Q?gk146tUl9aRGg6iIRQLejP3EuR6oQ5ExNpFDqlJtES0XhwdAL1/DE9unDXaH?=
 =?us-ascii?Q?ctf5B+uUhmVtCKKV/pkLzNC3vWoFe86YW+Et/mTiykv5i03RnIyuL2wd/w2f?=
 =?us-ascii?Q?FxRBpDdfzcNVtSFSRcrGJmPHMFfapnkFlpLBirYoHQS1NaW8HEkNKBX2X02a?=
 =?us-ascii?Q?KsvILizGGsdelJenW1T6wn2CJ0K2y3hweNqq9T3YftE67966orNTceXlBFgs?=
 =?us-ascii?Q?sYEoa3PJ52vo23AsiHzwOCCebX/3cBSNTRvOolvj1Zk4CMMvtcLt9Ow+V+VH?=
 =?us-ascii?Q?cCMTXhQVnFj81YEB0dxtfVV8cAqrMUJkPgSGD95wM14iMxUKirk/Vg8TL0Xv?=
 =?us-ascii?Q?jTOHvvwC9+9Kb+EOJYI+SvciLmaAws5EpOY1kv0BL5OoQioWxjSvcUg6c5dK?=
 =?us-ascii?Q?8oUd6W1EeV+zjpYlrHja/H7arvBHG/H3lkygIdaRVSFa/D4h6KjXpsbvw7Pd?=
 =?us-ascii?Q?a91B35XDObfwLpN/ubiefMmFHCp9tCDHN+Fnqk0/Ta9Q2mUZcCaIwYJxfmYy?=
 =?us-ascii?Q?ZDzm2a/QCr1fuVf0xUe/5+Px5HFLMtYPsByabsp1PnmIbWx0Zj85ECs/xofV?=
 =?us-ascii?Q?Xae9IVj14ctF8aHPxoiiiaRIja/dsN75gkFO2Dj3ai6c2E1vCXBumEpVOseT?=
 =?us-ascii?Q?dciFZnNYIxcELz0mUiZVPuBw3sv8RYAhmA3UIu6HKLb1H0ZpTkZpZZuTppQ+?=
 =?us-ascii?Q?eq5pelQYpq3og/Pc5XYlTu3gP1RDRNH80+bGYqeS3qTneGHyXu+/vn1ygx7q?=
 =?us-ascii?Q?gDl5Q310CXB53roeaoMK6Fe9Zi2ijw1ScBUvgm6/rksDgOclJ4XjTK5c/0Cu?=
 =?us-ascii?Q?jjmSZVGppOpQUwhodLo90vtk/qd7lLnoK2h3qs3D29E/dBl2mrlVJPy+OBie?=
 =?us-ascii?Q?3nEDY9vMte1Xs94j6sTC0pIVoLl0jXTtRNwS8SyMt4HS2P7auI33XEnuRkhd?=
 =?us-ascii?Q?6k7SH+Jl2gA4v9OG9evhBS0kmgNrTBdsoEE+dZUlBd25Z9wpb3rIofNgZRUF?=
 =?us-ascii?Q?pIZ5LrJ2ouc/IbpOvSWK0DaPucizUX4w5e9CNJlVM8lk6Moj1VCPEcldDmob?=
 =?us-ascii?Q?pvat/AJj3yr/mezpEjoA4deDfpO8qmFNgmiOoMyZy9gs4QPEKIZQqE21prQZ?=
 =?us-ascii?Q?lA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c43dad9-f6ff-426e-0d85-08dc1551e5b5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2024 22:41:07.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agVNYSSqMJ7IEFvhr/3I6HoAIkilaGCWs4JhAD9dT+Ucj6OoX9At7nqJXP+cGj/EokSol5n3xr6pRFH2ZR7lCwRIJUESN58gXh8dWgyf2tg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8961

Added code that will be used to generate the BASE dynamically in Bluez.
This code will help when will remove the base_lc3_16_2_1 from player.c
so we can use the preset from the endpoint.config command.

Added fix for ScanBuild error: Dereference of null pointer

Silviu Florian Barbulescu (2):
  shared/bap: Fix ScanBuild error: Dereference of null pointer
  shared/bap: Add code to support dynamically generated BASE from
    presets

 src/shared/bap.c | 494 ++++++++++++++++++++++++++++++++++++++++++++++-
 src/shared/bap.h |   2 +
 2 files changed, 495 insertions(+), 1 deletion(-)


base-commit: 770ad5614e7e8074133e6f563495ce4822f63fe4
-- 
2.39.2

