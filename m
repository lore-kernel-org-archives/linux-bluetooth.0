Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010059.outbound.protection.outlook.com [52.101.69.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3499198A2C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Sep 2024 08:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726734065; cv=fail; b=fvzYd7aEOF4c91QCswTuiMTkpXGfaFKEwRwtk9qVfL4gj0y2OV+mLhnHrhEbb/uByu7upxr909OIR1SQ96G7PfnDOCkNGjXQZhchsjAXqnX5SHdlbztxo+/5PPDLgnpfyfGnijrTwBU81LqA6LmIo1KpQ8OWGUXetIdrFTi0yxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726734065; c=relaxed/simple;
	bh=NDktjNorpWZ/XIKamoaLr8t4CV2qeBe7LaLHR1YPtGg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gJKlAchj3CIUi5mFjODalu2n1TtInbml0UknAFsDBQ3Bu9vDU+mlMF8bT9HuuioPS4/dHCqPGtrQpERsfl3jZLTsclHuO/3AqdqH9NbVd5Ye43dTP/+uE1sMaKK1lHEAhRRkiOt7HZLeQS0n7sGWhayQHj+AHb9yergroa4hrQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=JlEr9zk9; arc=fail smtp.client-ip=52.101.69.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="JlEr9zk9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xhY9lhxc1VJI7KkTzoAhvDGJb3e6SIdr8MhQ/UYa6lvS1/sq8EXc9ELrtjoaMW9NtM3KHg6mdsXtWtBJ/gNmSaCvy1OrQ09yrCKTldiU9O3BMvx2x/nEfSx5moWwVDGdcvsoJvqZtTGGF2TMkOAD9fkm3TBXskVSs8hSaWCcnD4BQPC00e7ExAh7TbNVPAbfKZPrEsV+hPz6CeHpAiKZRENK1De8Qrs4RpZI6xtjHvkZiMlka/GzyleE7D67YsMOE2uqH6ruMffSGVM+SlzwFNIQMrg1KEsDIHi+Ev0v7MdiZ4M2kxqOgGkGn0PLVwtydC+6qsBNg/K1czvsrD1/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yh3gPkg+7jlnZ/pLXESRzXAUJQ1mcH03IkEJiG4EbuI=;
 b=DdYn7iw+KhqpB9Nfa+/3KtK9tY/YI5SwCF7tE8nllEdU+VyAyqdE0a+iVfbnhR5q/k6kC9N7mfUiuqLKbYYGhsq5np2Z+PfQMnBEmcMnrZMfTiOrT0szQIqEXHzZOuSBYfDrvoTB6lmuMs3CKBVGeRZM0QbHMx8PczRO8vrB11yZqOQiatetEYeNENAmDGPlMwado3nnhXKx+uj4R7MR26QjfFJSvxZBgOFXpLhz/strG+WK39jqbtYFLxulFJ/ggD83QrHaO+5ONG34VvCTETt0pkOUB1RsAWu1VxaJtT85Sp7ZkdHlAe8uiMNkSPyVs9KTkh/7kuZfnl85FBEFmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yh3gPkg+7jlnZ/pLXESRzXAUJQ1mcH03IkEJiG4EbuI=;
 b=JlEr9zk9LTJRJNCucQMY8v1vMF9Yjbi8EzKFzbeZm1D6E9JvBuDMA/KsorBLGD0dkCU0O7PPbYopUIoo7PEVOF+XMZIdCOtHraxWhuJTXgoGlAMAB0CQfdsZwToGjXSS6mAJijW4dHXMf6n4O76SzjCuiSZnoTb9D+lYWmr6c0m9GSz/OgSEZzNwLVPg+2mpng6rtxrYoQ9STw0DSsbFq1tzWmRs17Y0HenCHHNYWWER8LxLYdDBIdq1LhxVs6VNB3xo/UU9F7PNFaUm/5XG4S5XrdP/LUHqtUM49EILGphj53ekgvuejetSVm+ctYj5lkttyIEUYve90zGBhD4WSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9842.eurprd04.prod.outlook.com (2603:10a6:10:4ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 08:20:59 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%5]) with mapi id 15.20.7918.024; Thu, 19 Sep 2024
 08:20:59 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/1] bap: Set bap debug func at broadcast probe
Date: Thu, 19 Sep 2024 11:20:46 +0300
Message-Id: <20240919082046.7208-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240919082046.7208-1-iulia.tanasescu@nxp.com>
References: <20240919082046.7208-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d7::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9842:EE_
X-MS-Office365-Filtering-Correlation-Id: 10464c70-0192-4cef-3d92-08dcd883fe01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EivMEi77KJysYWBAuk8FsP6g/7HBpZXnEb3FqqHfz4vDrv0tibYIHGS7z26M?=
 =?us-ascii?Q?IwdENL02va2HLpY4K+y7O0gEp53RhyN4nWTDF60ubXRX2SSM+Rb3QDKq6f1H?=
 =?us-ascii?Q?mKldoaR+ddHP0No0+MJJh16PXoaD4DLpN8w1NcTdyI+nbAZVfXGur64A/cOP?=
 =?us-ascii?Q?8S1KJF7Udi3t6mbrxmuhSkAqf19lR2oOuBcU6heBWSpdvdyGkxtUGKD1xEiq?=
 =?us-ascii?Q?X8O2h89couHhSMfG7nvjunlXi3wwYAH18ejPDV1zf81MIPRCv2o+WdqJTuQ7?=
 =?us-ascii?Q?Lo0F1Rrgx63gC6F283meUJHnfxz5vhwe9qbeckgSCwtJZ04Wi5b9d2nsH3y7?=
 =?us-ascii?Q?XdpNHrk9W+9SCTO04n8lFJA5U4GAiScJNYbZ+5Gh//xaQh/afOZktCXgxZr5?=
 =?us-ascii?Q?h3o7hVhNob5olf1RZ4X9KB+gI2WzmRUD9oCa+qzlBvkWeqGrlU9DCbZ7E0fG?=
 =?us-ascii?Q?uASyvAPLXle8rF2+8KeKNB69mS/df/8dNAe1g/h2fdQp3Bn5Qdw/3bjhqr3R?=
 =?us-ascii?Q?RtYW8ZstiWLcXT6+ik2REwaRlFtesP29RxAzsiU99d3UXNHuGuCjLdidS9El?=
 =?us-ascii?Q?MHCxTbzib6kr8gDORcXLlQctAFir34Ln1ktVJH/VWB2uxATlS3qJmkrxO6D7?=
 =?us-ascii?Q?PEDaxQPuwCiIjirHtMU7Mvcab9sKPMFMjagQrw6jOiTMH1tyG8cMTzLneMDc?=
 =?us-ascii?Q?bLkW84C4pR1xrR5pG1ncXrqMIVb6apMzQRLcF51EMEhFj7OZmgeHQgfyQAE/?=
 =?us-ascii?Q?D4PEgxmnvRZW1f6GSWBS0CAwhKHeGmkM+51gelfMj8CW5fE6geRviyXSR4VS?=
 =?us-ascii?Q?Q3hiS1fDs66eXoEl/+8MnZt8+Xi9wcebvAUld8LoDzG+Unh20BhtapNRvUS5?=
 =?us-ascii?Q?Id18CMYYNHMTIKn5QvSJ82+P9JoAmDIFaNaikhwvobItMwRSPHjlV3okQcqG?=
 =?us-ascii?Q?U6Qme7WRMkqGobcamBZ35ZyRvkaowFWUbS/g8+Tf5iV9krbyNOVkraftDhqw?=
 =?us-ascii?Q?aAh1czGN4rnhc8E70x5+GCjjOrHpwEFoyJAwFBHLCy+YYrz0tR1SN+FHfZPe?=
 =?us-ascii?Q?M2TWjNFX4dlmcB1/7swSiHvu7Ya+r+BPdidzUAsnMIeTWmHb1RpHzrVnikvx?=
 =?us-ascii?Q?8fUEzsMSUnpWqLaF9Q6+03cw8bdmbmIMeB9+KlnIfvcQIV48YCb0zRo43poD?=
 =?us-ascii?Q?QMEjDYwVwZLJ+0dLh5v+a1vojwVZf7gwzuEKhkaZjyqR0M1wh/EU+viATRkD?=
 =?us-ascii?Q?0QEgyfCOYunMOuYqwl1fwmCfSCsUUvQUcsanySrtySaaCVia4eENU5kJfoSa?=
 =?us-ascii?Q?cvWpdJjnXQ2Rk8zogG3OVZkxmDZn3ifRPkYqEhrkdiFVjQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iR2M8dD7t+vAwOEVeh7EklD1w9sW2qXgMwE2MebXsQKvguJP41+1sEMOBCWH?=
 =?us-ascii?Q?BG/EU4b/9IyRZ5XaMbmZoXs4Rn8IMGj+QpPHBz3YDOs6BXJSgsX2amBSQBZX?=
 =?us-ascii?Q?/czJYS4M7hPShOidcbvC8tQVU7piJ9fBzsoU9KAdmOoHyQR7cPZnw1Kw2sSp?=
 =?us-ascii?Q?Zj6NpTGHdSwkKTEQL90MBFJ9Or3jpB/VQsXqWF3hfTPDbYuEkXMTaj8TC6vJ?=
 =?us-ascii?Q?332H5mAJ4K1WjfKvUxP/rOezt8IS4Pfufx3SAOviJjD2yGrCRZR9EVGodB4y?=
 =?us-ascii?Q?DhkXWhHG65St4wEyp7UuPiJbGnD2S2wxQCH/nYmK/FyDdYQw+iTKF+Ol2TQe?=
 =?us-ascii?Q?6vkMy0jf79kaAwZa3zHThHHRJqIe3qhc/4oOcJ+iGlXQblORoiR+8jwieaca?=
 =?us-ascii?Q?Tm0A0gD/UEprXk8SDGv/pAfVU+9hyx/YRXLGlf/tKS5xAvgTCt+095XsVrOz?=
 =?us-ascii?Q?rS3/IvkR/6Ina4AAT+pcx6KDvXOlcROfe3UtO/+/5BPOGxlvLZc8edD6zExQ?=
 =?us-ascii?Q?8OhHGnzsDZZgjLyqf9vwTGql0RGZyf44ddlH6++vj7QjSp1beo8uoIuO4zJX?=
 =?us-ascii?Q?g4okQx9Vixh/ixi2LFRf2vVyJ4ral6pMi41ORSTmkVn2n0Hh6XaSNxyXhNzM?=
 =?us-ascii?Q?gyelfBWa/7U+lPQPE6aCRUncCAdny8s66v8eCdirs56y9/vsfhOZwSur0kiZ?=
 =?us-ascii?Q?a3r4tbY0Gu/TRbSn+zFmaObJe/WDbt8kleA6GQLs1wKwt6c6y593X7bDYgVq?=
 =?us-ascii?Q?386zB/r0Fa8lkBATpAIT2q/j6IJNarZTCPxtDT9DTJgzJleXOPABrokASUgU?=
 =?us-ascii?Q?QJd1YBdk3jS2DBw8A+NXim/7YtWJy3+PQCoRnU8A8NK7BPrzR3ypp+XMNOMi?=
 =?us-ascii?Q?AMBfLasprll6r0CFR264jP7zubUO4zmfmRl82WcgZj4C+yoWYB6u2Pi9/8LQ?=
 =?us-ascii?Q?+Idm1LuXOeXpgRLX1sNoU8RTuqAtJ++lmIRryTN9FiPZuuDa2cZKMz0WMEoQ?=
 =?us-ascii?Q?UbjlmY7WJkdgst8LFGpTeVN9hJ4dbFPro2E/rC1JmX+E6vCQ957jeGy1aunD?=
 =?us-ascii?Q?ddLjdmNUFKMjQiv4fDHApyukz+vsSYNojvYiuQXLJTOyHYB+cnm0ueNMiK4+?=
 =?us-ascii?Q?xXkGL/JHtJgK+T7NQPgimUIPkl0OV3rhfVQM9ILLlgNYZvydBb9KIMQhY7ST?=
 =?us-ascii?Q?b0Yn+LSNu7LzOPTQOfRvuzjvkcvzq0bJ1jKCXLcL1WXWXZ3J2dU2674v8+Zb?=
 =?us-ascii?Q?a2GVrVYoL0zsZzvaOFkGZTInbZp5I8FRW3eh5G8cJH2IgAW/6TTp8Ez2XXzS?=
 =?us-ascii?Q?CzKCweGr4efn2lb5rKLR9GR6xs7c6GxmfFSOU2wBwN/NoEAIKZAbmtq8TizL?=
 =?us-ascii?Q?qfx5FT9hJswUdEiCmDiCZxuHNusFcWoVYDqFqmWeOKEnGeUHgoIRkj+D2E9w?=
 =?us-ascii?Q?Kw5GtZbTE7dwPdTlQtZXZ5kLEIkoXEgmU7vKP30JwDLDuLAnwm21Jyx18Xz1?=
 =?us-ascii?Q?09PNz+CfaM8jiAVE2iJkHgxMcSbjWcNgvZPX4UQCqL2NGBdFV9lQNVu4BTY2?=
 =?us-ascii?Q?zox0eKkndBb5dXX/+sPMy/yaJSaMcZHEYCzJc+B2yW72AuBajWu7CtDZ8fCQ?=
 =?us-ascii?Q?3Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10464c70-0192-4cef-3d92-08dcd883fe01
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 08:20:59.4340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYM7Mv+TbuwbPbvICnekJ7I4LuZdVkvwFEN3JWGY44qdYmjxVgoLXufMVUmUG5tHMPSImYAZOjuDMGuJmVm8oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9842

When a Broadcast Sink acting as a Scan Delegator probes a Broadcaster with
the help of a Broadcast Assistant, a new BAP session is added for the
Broadcaster device before additional session information is initialized
(like the bt_bap session). This causes the bap debug func to not be set
in bap_data_add.

This commit adds an explicit call to set the function after the bt_bap
session is created.
---
 profiles/audio/bap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 100acca57..c45717ef2 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -3243,6 +3243,9 @@ static int bap_bcast_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
+
+	bt_bap_set_debug(data->bap, bap_debug, NULL, NULL);
+
 	data->bcast_snks = queue_new();
 
 	if (!bt_bap_attach(data->bap, NULL)) {
-- 
2.39.2

