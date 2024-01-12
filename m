Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2257E6DD09
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Jan 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="P4ADJvZ7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MoIIsMgDnsSXM2pwNGB6VxupdEErDSSeLUoAHYfZtvBPDSDQKL1673SKD0l+RvVWEVX6Nh6+RHeLUyHX+68ggn8K8Gmo1x7F0ZA6t4FyrHM9UYQ6YxGXtB1PsBG42kPKrh69FdWLp5rX2ETN6PSO8G+IJ16uKOT4YJJ8kziiTGamOwjO+m0L+XDBRudZso+Iu6bj5QBmIzsJndkrqkcuGbPJtTXnsKv3Rd6/CJPFdC4XoCh9dUhR+LTy4bEW1MyuVGhv6I7d9ye2SkixNRj3FwCZeUDFOPSN26b+Mqn9LFp4h6X5oqQOVvE1DpkiqXjGM+QPaBGP7NmBQqIbTlqcqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR05v0kQF41+rCgfz/ZMr2sRKif2K23uzDFe4XCpVfQ=;
 b=TfjCZZxQ9ntx52NAgdZksBdHE6cbF0c0OIFhSUsBnZzhXvxkOpK8uN9IDm8f3R0KGKJXGsIdjAmzhfwDinR3u+1g/0daFSKMf68ojtt7J6StXChPKY3cx4EmhkSGfv4ktTYZT6X/8gl7WIxwrWK85eBvvwq/yLxmPB6Mx8V0hCv683aez8bsjVbB7LZxHBcFcZVci+lLnll8jJe4n+3QwJbEKB/HMxKSLOgPAWiB+/x8m2fXSTw5LYbj7o8flzQdFy1WrortO06tV1WkspMcQ8WBc87XvR2dP0jeIuvc6AWz+rtR79uOW4msKBtg5ippIuo9HrSLGAAz/sXs9cNKsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR05v0kQF41+rCgfz/ZMr2sRKif2K23uzDFe4XCpVfQ=;
 b=P4ADJvZ7etYhCL1IYjs0O7nyrIvvO3cH5bJpk/DoqGT+mI3Y9EpLU/5pXPfSLLvFHZr4pHlsKXApXD1ZaypRSBuLf+RTUEpq+yDWnBHkN/fUmZL4AmMtnW8yhU/sdafM1iPF1Ubi15LlTnGj4weRJw7h5MO3aNZKCM1SV5TR2G0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DUZPR04MB9781.eurprd04.prod.outlook.com (2603:10a6:10:4e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 14:40:48 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7181.019; Fri, 12 Jan 2024
 14:40:48 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 0/1] Add code to support dynamically generated BASE
Date: Fri, 12 Jan 2024 16:40:43 +0200
Message-Id: <20240112144044.58051-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P190CA0023.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d0::9) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DUZPR04MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: f99fa598-e50b-406c-4592-08dc137c777b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	orbKReCmR1NXcX/1VZA80NMP0G5e2NVefNDYYdEtohMmTVhcjWsQq3Dvfhs3VVpmE2z0w3OhlQubwAvnea9mTYzuYKhB2xFgjjKElq2mfdgwue0B5B0u9wn++CRCNI2czCzWd+NOTTsPLAm1j+I/wD2xDaGY8qKOeyfc+l1/KDNx7CePfh7fs3AOKtS7zdXZyykSSnNrWDsQotHLbRCTA/0noieB4imtImPRfMjz3aRqVO3hfO0Rw6NEtbWPnjAqAdY+Eb3Tqhuo49d83tqrY2o40Y/vF6RvEMFyNINLTzyt6ZXDDqvGyHv8HTCTMSM5q/h3cfNsJFFwRoJPHwLrcVS1XILJQYL+GJg7rcHIWYxEPjeqVni3F5x7zRFW4mOj2ojHPu7lfTH32aXP/Vfoi+QuzL3KbP6YFVSgD4a0W3Ko4IhR5a5Cc3FCHs5nJK3j+jKVKm/Ppms0o4r9Z7nk1X3u+9s5bsel87TdWYtBTtERl8zI/eZ1X+Vs+ypiNHHPlW3k2OTaBXIn2RbEi93TnkEMj5t9vi+IxA0LkTH5ik35eP2orr9PQtJwrTOYzxVt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2616005)(26005)(1076003)(6512007)(5660300002)(478600001)(6666004)(2906002)(6916009)(66476007)(66946007)(8676002)(8936002)(316002)(66556008)(6506007)(4744005)(6486002)(38100700002)(4326008)(36756003)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZszypHv//Zpgxo4E346ISrYf8NBD4AReMsi3qI5x+scHc2sn7UzFDBB45Zpi?=
 =?us-ascii?Q?lPTqZjo5JvY0xK8mhl6Gyr5Ha5DLAOCQ2XygVSJzakrMkWP9ryMySREXTYFl?=
 =?us-ascii?Q?2YMXQ1ZF1bpB7OhWQQDOd10iZFe0dfKKE9BLeNZpLsas9vhiQtxGgmqOpz7l?=
 =?us-ascii?Q?YIQcohP4TgDeI1VUFG/dwXer/4F+KAWJ21NzDd7lklSIIciyDx94LwyZJRgN?=
 =?us-ascii?Q?Snxl4dzXiRPZ9AC6Hss5VvmQzbVPsSPZJhqXe+hxqilVPBw0J+aDweYgtpgw?=
 =?us-ascii?Q?K/t/wq4DNw4KSEQan1M+dKfszwyiic1fZZADF739vx4DK1dq6KDnIExsafI0?=
 =?us-ascii?Q?rh5+Rb1UudtGnrRosXP9QNonWOOQ/KaPk4ejZqyVQFYH/4oqAvP193T/fdS3?=
 =?us-ascii?Q?XFdFfqOcP1dQwJiBbXxsTxOtneREbmrttK1eDanqyahIYjVCglf12hsiHDOa?=
 =?us-ascii?Q?LEuEMZhWg2QtxnI1O2+bSWFPQnR/MmrJJX23ZM2cuJq4nr+8mUXgOWYT6Gax?=
 =?us-ascii?Q?2zR9XS4lraO6xSAfdHfON1ZVHKCG0f15HqMHSwO1o8bpv5P+fDdjGMg8rnmE?=
 =?us-ascii?Q?IYgWyFyMAf8Z8vbryMQB1j6FgUSyoer5noCXfPv3NbdhV9KsECizpDfkweYE?=
 =?us-ascii?Q?XRbk8FLi8EpXSvnJ75AKxOapOHZtZjjWbgmx9eCNllbLBbO8s7R5xjKGm2I2?=
 =?us-ascii?Q?PHN3nbiGgutxzVQuT+mL3k3qGAX/aSY4iLaSsX8A3feQWoDyj3EK/t/GgcHl?=
 =?us-ascii?Q?23ya074VnqEAHLzMhjBY9fkFvPT5YPLghyQfNUtFAS1gJFV9K8oQWrG4OVM6?=
 =?us-ascii?Q?kU2TqIPjeSi/mr8xC9OnlPjyW4lOKUvXGt5fQ91/DoMzdqb8bz26gnIXL+87?=
 =?us-ascii?Q?rAp1Vf/QyTElLEUzgFghbnXJEoklB8j2h4syykml5C8dpKc7gDYkcFF2OgLR?=
 =?us-ascii?Q?CaJGDzegKoo4kGemqHjUpdL/5Dy4slIOjdHJy7RENR2zkXKTwaGu/+m4b4S/?=
 =?us-ascii?Q?2K11mwnsFhNG7s4pT4Tl4O0njKDTbwuTh1EtcbOnpmTqFBzLo9vPvLfYhy8P?=
 =?us-ascii?Q?+fFKDa/Ek+1AYba7A8PYIQEJ/Nby7ffqnaKE31tOOY7n5TCwqd1DmzHdiYXU?=
 =?us-ascii?Q?/XkHsUNvOy+GcnkBdcK5WImoEzIkwY9IlMXrmInukVq51QAgGWxrug+MHRqS?=
 =?us-ascii?Q?20uy55o2xltqBJQG6yfdjynxoYKM5ql99onLuki7sJNyZtLfHNbcjKtWrGm4?=
 =?us-ascii?Q?oPkhlYRoOkisX7L31bMa7hSRdV8o9T857KtRRreelTtUWM+5IpvNdz9y3fuH?=
 =?us-ascii?Q?UEdQ62zvix9VvPwCElXKsRpovpAqbqnFEuDEOSDosmWWo6UoLx/fmvcJlZj9?=
 =?us-ascii?Q?yOFTaVW1TrIifGdvrzW8WPZoBK2UTacvHPcy+QRE20frePsxPvtX+UeH23Wt?=
 =?us-ascii?Q?LZRn9zMVIW4E6j/IW2ygDOYdc/jzRHHJpEFasLEtK6I5h18Oy60sHDqJsvIG?=
 =?us-ascii?Q?X1+6/zN+dBBPpeXMvH5yFCi+TVvkm2lPTSt0fLDCzt3ukoT2xIZJKcs5hNiu?=
 =?us-ascii?Q?CHXRb2XI4KJf6rABxJHOUimPjdkvF1z+e0YJxknVDlD3g+MP7fAYXKahmi3L?=
 =?us-ascii?Q?fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f99fa598-e50b-406c-4592-08dc137c777b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 14:40:48.2326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwlzefsg2sdoPdYPLokIOCoLKEtaVeR+S6X592J6MeHcxOky1AGT0I/v17iE086NMklcWMpU/pE4fU2qsq05oSSAyeDxC0Tlb5A1Z9SVu1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9781

Added code that will be used to generate the BASE dynamically in Bluez.
This code will help when will remove the base_lc3_16_2_1 from player.c
so we can use the preset from the endpoint.config command.

Silviu Florian Barbulescu (1):
  shared/bap: Add code to support dynamically generated BASE from
    presets

 src/shared/bap.c | 492 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/bap.h |   2 +
 2 files changed, 494 insertions(+)


base-commit: c85546cba715afee020e61bd0a44499e618d0371
-- 
2.39.2

