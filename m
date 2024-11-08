Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2083.outbound.protection.outlook.com [40.107.241.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C08A41
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Nov 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731082056; cv=fail; b=UqLBldfyScCNj6hfRS1/n0Q56xSrsY5xjr9azkY3JqTfkqVcSwUpo5GhDf4IDbyBQHaf3GEEsJ7pMFat7FYfh6JqE5BmuapbL0ZG8DZrsbGiwEP0XBqqx6fyoL4OpagHBHV9eQtZNd74mfx4qwLO2l+TPyU4dc8eqbTVpi5W9Bw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731082056; c=relaxed/simple;
	bh=+DnTrZAIcwHkYETleQmNuJ6Sd3Ei9J7fkU067Dmbg6k=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qjtp0smW7mCEZoeV76G3HoSBrayBfT3r0EjNCX89YnVqJbqxXz6N6DPH+fI3e4zPt7HdqIU8L4m5Ittl2fpYNMFi0bIFIrEjRUKoxL6qoWDlqmWSPNVk3ENfdGAlNk5SLtxyFlaLtjwgSw71AbqD3qIF2D0L/akvJagK3xuCrLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Toxq6rie; arc=fail smtp.client-ip=40.107.241.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Toxq6rie"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHtzX0QvVTZwueK1roSoKPrZeumo1e6tHjzBtdFyYqU1sXi8gtQ67l2DjVpThUoe2MJp30f85AN+ELSj97oFNDFREcw204bqdr/ij/GaaIEkPpGtTElcxg15A2TfVs1LaLBET1kxeITLC9W9f1jzVyJsqbYpXYu5CFbHvsThDyvLJC977IzFy0mlLapuFyZfRkgufsGrrvRSA/THkGYZA/RczZDgcr8527BAtvcBqnjAn/krMlDbskIGMfV5Sd8OgOeh0G1BhMnd+fiTbJ6lqx2HHCwlBjzuu4iFJNz+mX88h5NnxPp5FedCCCtbJ3Zr1yPpV7AzdrVvw+3R2vwlKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nrDt2nME6sE9rAONKdUWKV26wuFKJMRqrmlpx8W7lmM=;
 b=X+ljEZc8DP0E7mSmJ+EYPs5Qmv6l1FzSzp4t9gw1WlBeUGIzi8y7F+5VtDowhZXTx6UdIqQcfrwH/SKPESP8kT35Dnakb2bQNHHArO1JI6Ky13boR/Lu6zCRDDTPzKpVumCa+49wmL8W3oIDfWJeeQtm6zf4X20Px6Q2pQzK5u5ilZdFolT8ynpsVHTiWaIB3rrBWa98Hjb1RgohRqKx0iztlpSpRM5xWqUuMgUrNozKEJOVSMvr+WNXzcz4Lpz06td3/mZb0p46LfptaPxbHkm2sgV85GSWj73Q2XE9S7EKXWHl20XsdGQX8o3KlSkfGTZlY/ZuAVIjAUmC3BN8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nrDt2nME6sE9rAONKdUWKV26wuFKJMRqrmlpx8W7lmM=;
 b=Toxq6rieQucUJDhGPtWCq5AHe8/g74UUQ8wL0Oo112sIRFby46LI7mv8TnhYqZ0bwQhqTaJ69Gb/Vau/9U+LQXF/RBpFBnfwTXmAh2y8ntxLRYpgFpgmOfZ8wtIEnEclDStmvK8eAlonsgACJVGZxQWZy6O9HQDViR2uV5uU1/pDf5C33zRCXIHLlsBoKV1R21oUnnpFaSL9VD3taAFH18jfHjudeAN34xBtS3bH1QA0oD96mqgZO483WI7QpPIEs+BvDQy1lJtDczx85qBCg1MRjDdyoxoq3jsTgS1sYxQQbuhjVePafhiDVI2QT/5tvDIEc4/HkWSEjQyYt1lmvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI1PR04MB6829.eurprd04.prod.outlook.com (2603:10a6:803:13b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 16:07:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 16:07:30 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/2] Bluetooth: ISO: PA/BIG sync fixes
Date: Fri,  8 Nov 2024 18:07:20 +0200
Message-ID: <20241108160723.3399-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P189CA0013.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:802:2a::26) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI1PR04MB6829:EE_
X-MS-Office365-Filtering-Correlation-Id: 35de3fa9-df11-4bf4-723d-08dd000f72a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?otnerK0lomL5fg5RmAKg58TM3ihbM2pe6opXR3yZNggCA6dIK+ngowze2+n9?=
 =?us-ascii?Q?4Ep9WHbQT5x4nbnqpWjqlFF0or4zjmoH+8PDKw03juE6XFEr4GJyegtt1ln8?=
 =?us-ascii?Q?T0Zst6WqCr119uvzmylAko4144cq/hHP2boHpH2kEhaHd2We47J7Ew7pzNYs?=
 =?us-ascii?Q?QR2EsVkdAQCQu17y94GQhacBGltbo+cS/3ONelIMeNVtQAjQkKmh9flyavgD?=
 =?us-ascii?Q?NKzlTWfdCw1SVPgFRsGWonQyZXoEk4kofp9QMm7BqTf4atD0oYAdBZC8Tb+n?=
 =?us-ascii?Q?WmHKI0wSlG5MFo4wLSmqSMOsqq9PcYrDQtjsCXfn1Xz+PgSHA1HpO7IgJhAS?=
 =?us-ascii?Q?aH8uZuMJluMBYKoxOM79pg03bitgn+fE/Bp8gLeXvxNS1B18kDzzSy1uph/d?=
 =?us-ascii?Q?uTY8SeCdP7SFY8shaCvzG983TIQ+wkpohWkKb782/fdHus+vUBC7kZsZu63y?=
 =?us-ascii?Q?XRrCeK6HDPZsTvPqFvruenRb/5oQJcZuIPeL+o9SnUkAH1tUuetviYXunmke?=
 =?us-ascii?Q?K2K0A33UgrPUhfaVtQlc15mkZSUyA7WRxGGUA7kk099KEZ9FdRiQOSpQ+W/m?=
 =?us-ascii?Q?aPxm/O8S4LocQx3jKILurvot96YJNxDgUmdB8XEI0OdTXgso7/G28xpFhE6f?=
 =?us-ascii?Q?3qPtcgypWCVSfOMy48PXPD1ooreKIux77wolphJtGG04KZ056Yj0KB2YwzSM?=
 =?us-ascii?Q?pRBooOb3U8B9jBSpQVMLBW2YAOFJr6GbJ1DJVvDibxmgOc99tDqn8FhdzDiY?=
 =?us-ascii?Q?RCSfG7NOm9nx2KzdGq+u+iEzY0WaJqssW6X7PswEJFIPVkAEonczpXrASo+I?=
 =?us-ascii?Q?tONzF9bynli+Mrotqco1fE3v0la+6gJ3wjMk3ya8P0YEpeGH0DLnaQNY4Ne2?=
 =?us-ascii?Q?wzryamu5ze1cEd/O2zvA58fM9IZCCvAKVRT4Lu0oSP1YJTs8dxQE/tBQdROD?=
 =?us-ascii?Q?0HXULf7d/8lFQ+WJWcrXNCM8h2TLKDCqk6IS6c7qEmYUQ+NePRXYHnKhFNut?=
 =?us-ascii?Q?aMhGW81CDNk0L6U7znqU6mCDlkXx4QwXOrCDB3xA0Ek0Ky08gHhNRVRtQTeY?=
 =?us-ascii?Q?WISSTBjtf5lVsk0Ei40FBIDJ7FaMP4IWSn0ym1uX8HwPGZrmZC9UtGYrd1Hr?=
 =?us-ascii?Q?m341nBMt8vN7t2XWV0JVhmYzXRIbQpRzs0bdhBDiqFhR1OvF/M462fkrQAJX?=
 =?us-ascii?Q?BL21YHLZaFuMjYO0xJH0vtjtQxP6MyK2GbkWhiis+XfrpRpteqAom8YnRvLz?=
 =?us-ascii?Q?Z5kl+g6CTpu8VEkoShdX72DwJK39+lsV1TqufuOH9HuDDe6ddPS8BISWLtYx?=
 =?us-ascii?Q?95A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s+zhgs34w2FExp3zNGAzyypF/tFuo9Iwn6IcHnCs0mqoV7C1CDX3gJu2tlXl?=
 =?us-ascii?Q?WRUdy6QsffKJgwf4o2Bwy1BiFRx5vAUTznmMuBvROu+c7JmSh8fncNJ6nTAd?=
 =?us-ascii?Q?VHr8Ej7bd3t9DtzYczBL8PviVhKGtFsugRWS2bzFwASOLo3Jd45BmIi05vmU?=
 =?us-ascii?Q?2iCY1mfzDBia97SKprhVQn2GfPbkN7+BSWBhH4/0yr/y3zBIh0BbXdQGrOHm?=
 =?us-ascii?Q?sNIirPleRlQ8yQadMpPfSeDP+vvv60rfq/jcCmDFSfLX1Qx58mSGkT4nu06Q?=
 =?us-ascii?Q?+OesggZQ9d0W248QIWCoyRN1fS40zf3bM8EpMeIdShE0DgUEPFGhpMkNV7A6?=
 =?us-ascii?Q?x/Yc02PcMpXjYcLJTD0439A4j4D99BvGctMBZdNrO9d7xALG5ujuUQVnNlyn?=
 =?us-ascii?Q?z0NOh+kgxi2ax/QhAbCfnw/UeF43Q7AanJnvAJBgpFyYgQqhbGmDGNbu8u5T?=
 =?us-ascii?Q?lXK7cYqTGjo+JSfq606LxmoZV9u0wLmfmyooSaMoknDUNHQVReiSjZ1aOIyN?=
 =?us-ascii?Q?G4fwtctqXpc18CpBhQKuIONtqjNDyd4Vg5D0wJnnY0YY23BAeO8C0Pfk+/h6?=
 =?us-ascii?Q?e6/0AONvNW+jIO78NVqa9WHYxnfZkX7A7taiJXt+FvPfR7w37UL0WClfezk5?=
 =?us-ascii?Q?WJdBrLnHxK2v67L533fs9cDd+P088IbXpchxjB9VeMi5VXjhvCqZk9MTVnl7?=
 =?us-ascii?Q?rX0QfSd+WQ8TN2IVo2O5SJTY+7z/BxKBmwQBb3oPLdzv2ISno0/DoGGq4stm?=
 =?us-ascii?Q?Wq33VZbiIqaNG5rwybHOuB+73DuDYA8w+2TDQwaSzyiHyDjIYWFjYmr5DgNz?=
 =?us-ascii?Q?omyAk1vtaHzgmNnuG6RVLvcA/d64KuNUnaoIYKZ3DfXtr/8NurRjSsInlCmq?=
 =?us-ascii?Q?yrENDP5+I3QD1KmONyD0voSZo45AEn489E8HXH9SY5C0K0kcNPQxfsZDsWnU?=
 =?us-ascii?Q?ubkjoPfNrq4yQILq6VF3YrkUONYUoF+VKMBT85J1fAjwgJnxCPhEKf+8Vmlz?=
 =?us-ascii?Q?67WhQvIDVlnfYlx78ppTTBc115YalS75NS5DBcpdXyCYw+nvcDpy2IKQ7I92?=
 =?us-ascii?Q?abUmfitucrjRSvg8y4f9oi1CYVdeN8cb6kSAlBiMIauYmupKrIZgvy4D7rng?=
 =?us-ascii?Q?YaT0+bzLAyY/QOQjLLPrp/7qfMUfAcMJ1zQoNTcowu1fVCQPz1nnuLA0+A0F?=
 =?us-ascii?Q?Ae+NziwE6rJ0A1DpeTv2RdHHc7Xz6RrZeRE/7k8YUrSvhlFXX2v6N/z/eeYf?=
 =?us-ascii?Q?tnqYKDB6ajotJGbF155iu4xh8IzbzGdOhzmj6h1xzOZt9k6S5OtoUlkma1sh?=
 =?us-ascii?Q?cfMjqdd7T+2VpmqYvwuQV2t+yhoWkgnAS39rWP8/Pfnw7EBIe+Qg/oNxYvBV?=
 =?us-ascii?Q?z92VVZvKl02xJ9CZkcS9oSm6qWPQtKKl9RKKpjASsf70WM4RvHF1t9yeGV0i?=
 =?us-ascii?Q?AzlhEpmTgca/LACgLDsowX3ldHP6L3HfBTGEvOFLXZeu/zD3PW7xUTKWgq4C?=
 =?us-ascii?Q?wq0MGGWL9kxIQYcZKuqupXUcj9JaG9UNhY+60Mx6lCTip46H96DLTcPsKz2x?=
 =?us-ascii?Q?fxzZcjyOEngmO/BICKQS36M3IrzsMsFaL3COgeHj7TmmakWF6cllqJU0bDW6?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35de3fa9-df11-4bf4-723d-08dd000f72a4
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 16:07:30.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y6pWfRFdhdm8EThHxPMYjd0BfVkFt5pxq0NWplJ2FwBPHENftScXvio+sTbfwidWYuKSBcZ/H26ItSUVerwtDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6829

This adds a fix for the following BUG message, caused by alloc
inside critical section in create_pa_sync:

BUG: sleeping function called from invalid context at
include/linux/sched/mm.h:321

This also adds a fix for the LE BIG create sync command, which
is sent dirrectly via hci_send_cmd, instead of being submitted
to the cmd_sync_work, causing ordering issues with other
commands.

Iulia Tanasescu (2):
  Bluetooth: hci_conn: Remove alloc from critical section
  Bluetooth: ISO: Send BIG Create Sync via hci_sync

 net/bluetooth/hci_conn.c | 47 ++++++++++++++++++++++++----------------
 net/bluetooth/iso.c      |  4 ++++
 2 files changed, 32 insertions(+), 19 deletions(-)


base-commit: 2336a5b48954512198205ea38a73ca50c6714446
-- 
2.43.0

