Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011044.outbound.protection.outlook.com [52.101.70.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63AD1CACDD
	for <linux-bluetooth@vger.kernel.org>; Thu, 24 Oct 2024 11:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729767798; cv=fail; b=pvT+gtxY/OQ+ahKA438/QCuideaX8t+Twx7oSYFuSrDq3mRu6IUNm5lCiA19xmHdsXDmUihbxUf81ms1bhhrv25E+o/t0vwsM1A/bI0cC+lybmXuZMq+G8XlKar9ggfEx8fL8uNMrnQYID6uyj/pUTO2m/oV1/V9AtGCpBpGwik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729767798; c=relaxed/simple;
	bh=DgyPv53iHdnTPOrLt2LwIbzrvEY19ZYNPyeIZR3Sbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qa3fixYBj0MhJJhPPRtF48AtEgcHwyR/uv8Dm+kgzeijBvK50EOeiQ/QGE2L9Kj50CQ+nssdyNC1tX5D9M9MUs9kHrKjAhpfsM/LDcUWdaQCMXjB74NO2oWEaUUIsXrhimCUBQY9pxLz63TVIlyu+kpvPIeDEsRCGh839G1DBxc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NWxRIVfM; arc=fail smtp.client-ip=52.101.70.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NWxRIVfM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LzVAHerqfJmtjMetaksexsRoOuvOHiTG1N4ZZUeMpwIv1N0NzfAOnJQK7KTR6RPlA3CQ9EnZGWURjxTY/Y8pRtO2bJvwsR3m1x0buuVTKZ+0qTBpu51mVAE2fEn75gtaA9p5h8wIOAU1QjgrMiFFi/YWwGEXcrPQ/D9UHeX0gYo3vdYQY+f8wRUbEgm5HCcDCljdv5YH7jcFKwUUVHkMT0dwHVmXv5DR4W+MFzO3XcW/3cHW7wxuJrFwCtlsAWsXfvHmOPXcGmNQhsC4k4aMMtDoSGVsmlQg25DHMpk7U8vMYy5J+SWDYLhc559mC2TbSTuC+MDTPF3joUINxTs29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StK26AHiMKpFaYLOHxcQCIgxucrxIA3twyNPzY8kVIM=;
 b=wQaMDigr/Yznr2gA8RqYJ52PzzAbD2prTSkVLxNg+v2LkVS2SAGgaf8kj//VhJFIb6Y9YmRIKJTqqJ0dakUyfF2wviooJVnexccTEnqJWKU6rD99ycu43qMQe/bzxLNthzAvDv8rKbkSUBrCexqNXyxWoDhwYbERJX5qNsmZhC24kqlqKv+wa2qmGTWqkLS9pCoSkiQj8p7JEYTc2Ee1Hsg/k6CSsXfvaVcMwsf1dnuuAdRbrekj/UMfFXdCXVcZoxo4qou3n5qGacgOkXj0DExOpUtnwbsv4KVEHC4zgl7my0lv/5EHZvPZkkCab0ieQeTXaqRzDkVps9mmByo9JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StK26AHiMKpFaYLOHxcQCIgxucrxIA3twyNPzY8kVIM=;
 b=NWxRIVfMnbNG71ZZecQ0cMPAS81we9pTSMEfoKAWHvM5z96dzDizNkYbLhzCvaoRq75u74A3iotTw+upZ+G9sUdQmo/d909RFjAcnkX7RtDpx1A8No/kfNlwC0jPFweAcpxMb80DEIep4uvYiL/az5T9TES4wM6DFvllyoM7ZXc11KWuvrDENUjq6TDltb/bbNw8HA2nDMmbw7/bQysoC9c01KES3hxA97dtZdp+tSx7hCdvZQZRoq8ALRRk004fZE+XSxunVMMyUBu0sB26O/cvqIRUh2Crgb2VWEKhj9And/KNzf7OFJO8cSi/AmcV1u6AJmTVwurqUXNBX9cV8g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB9PR04MB9964.eurprd04.prod.outlook.com (2603:10a6:10:4c1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 11:03:09 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 11:03:09 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 11/14] transport: Make transport_bap_set_state part of BAP_OPS
Date: Thu, 24 Oct 2024 14:02:20 +0300
Message-ID: <20241024110223.77254-12-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
References: <20241024110223.77254-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0018.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB9PR04MB9964:EE_
X-MS-Office365-Filtering-Correlation-Id: fc14cf3f-f16a-4607-18aa-08dcf41b71c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|366016|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZkQd8p7DIou4YyYNjpV/VBGh1BDLuVXEmsK4p1xjSWG2xMrbEwzdRYmptP0n?=
 =?us-ascii?Q?xULSH8YAVcG4thfnUwsZt79LcQsURY593c9Amu6DG8y9Qzcvb4zgyz2kqFYn?=
 =?us-ascii?Q?VXV/N3Dzc3pcxuzot1SrCzmZjlUL2sgl5Dk1yuGlk8uM9xY0MV+hgPrt2zT1?=
 =?us-ascii?Q?18552cl5JgKNuZaV4E9QnhrWgQ8Hu7ntgdjTKlJjgROboXV08qPy1t+cb+0D?=
 =?us-ascii?Q?PrEkxcVJtey3eC59agCjCCOehFfnTGvWGGojmVOyBM7GWNzfgz5lR5ED+ycw?=
 =?us-ascii?Q?GovA/dTny2tqqUnFsTb3Hw4+L+uR02plSgn3BraJcWDxd8qWJz6hJbXU6jRk?=
 =?us-ascii?Q?UJfPT3k3e5ifQ0BSXuFLBryuY9yI3NDag88I73Zr1o/rMGdpeah1Rgv8aMxC?=
 =?us-ascii?Q?hmbky0bow5MPD2nEhocmbo1mmKZhddiOeR/8fs3aZEAtvyXmEJbtlrOzL5iD?=
 =?us-ascii?Q?3e4yN/52ja93tCwLHBRPCftUW2D0aHAfg9HDBqCyAi55MAzNLSzHY/7Ddg+n?=
 =?us-ascii?Q?AiBjE0T2x5bF08wH89ESZn08Rj45dM8A9zO30KSKQT6ddHKWtpe1sBDjxhDw?=
 =?us-ascii?Q?qwM2rzpUXwq8WZF/zEiv9Ir+M0MBfRh1mTQoF1vdSL8GOw4LMzit3kzyHvfr?=
 =?us-ascii?Q?YFPAysRFO6BqzWNpRtt14cWKQZLQ3ZaNvgQxZeX9YXgNW3UD6vHZpVX4UYS9?=
 =?us-ascii?Q?z9HLB4kilCfZ0OSA4rgzKxhRWATqzbmA8Z5W+KMOdSAm9M5ANgk5B2lrdH88?=
 =?us-ascii?Q?oafPCEdsfC0qV3gY4OHxOoWxkESGtqXu2ZKYJEg5FXliNrLSj0ugKx3Bbo9E?=
 =?us-ascii?Q?85c5SsQMGS4ClfxY8Avvf97GyAY950t9GZneWMzPTqOMPFIzbdHFtmhCf+Cn?=
 =?us-ascii?Q?X4ENKQGU+D3vcE18xtfHyl4BdIpp6DsSUxprH0zRDiqvt+To+6wt4HdUS+04?=
 =?us-ascii?Q?llOPHOIxckdVtXMVDwSZ5AHJaqIx9yhIy6EzgjmZGO/xTQQqn1Cgia2qTrRA?=
 =?us-ascii?Q?ZLBrU7yP+4dNb+IL7NstuvkKtouy7FXBmC+hP3en5NozOXQLH5fbXjX/lpUA?=
 =?us-ascii?Q?SOyoH5JpEzHzqoLY3kevLj+IQVJ69EwZPwzQ9UoKH+JyVMpw8Lluk038+zJv?=
 =?us-ascii?Q?vc0+PDJcKqL6NyE0AzunZ26lsO0h8vZrod+hACpi5rM8dxpJKhWQyx1ShPGZ?=
 =?us-ascii?Q?RtBwzIIiipASYhWxeJddqbMpWPrpSvLv/0fZRIMwPD8e2WXZ52im/hAkAptc?=
 =?us-ascii?Q?EAcqXONE2B03Ah5+IRhL/CebDmE/8nOTS0tVfeKJ9xclTeZDUzsTpet1Ca0W?=
 =?us-ascii?Q?2VHkFoRkovHRSMN41W09QMcEJwmsKMI2nVfcE2UDFKcfsY95Ynd04+K8P2o+?=
 =?us-ascii?Q?gyFP/K0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(366016)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rV5Xkmo5yV0VpBjdhqISUr8CXJ8UahcS02FqJD6/lbPC5+VvlfVn98AUrZu0?=
 =?us-ascii?Q?jwx5cOgveEhezTL/5u5uQAS+Kbx4/6wc3ACYdeJLG0vE5B2zUjBSE/Yrq0q5?=
 =?us-ascii?Q?3zzIxrv9ZiRE2V6ri7u7Vk0T04wvNMygqLNohXK3Wzp1UZcnBlS+cDnLBbk6?=
 =?us-ascii?Q?bW49Eg9k7zgxJnFB3ZARVT9l7xR4nfKasZdEFrtGa7IUhrFQVnwKRJ3wAIr8?=
 =?us-ascii?Q?DHO6BH1O1u/yBCZOOE3NBYVw20QesAdzumMgXjjG2sWeFWsaniz0WAduzFqr?=
 =?us-ascii?Q?sbAUFdPPPs1P/G7lLpuBeQGypz9pEykdbN1WBU4/JtwzMHKHzEszv70yQaA6?=
 =?us-ascii?Q?4QthGVYCMpqNVQ9mLsliQ6Nyt50EvQy1CVCsbRyHaN+6UZgX8XJG3Oq9Qvdb?=
 =?us-ascii?Q?Dxrh4RIK93smUN8R3h3weUXkt7kromamAKqrmj5nyQBmSh68TY5EDlEyYDWL?=
 =?us-ascii?Q?wr7Yjxk+aCWIOMJ5n87uiL+hB5JOQ1HQya63Q1s/6xpBDyiX7dFXQg4SzV+G?=
 =?us-ascii?Q?kS0JaITtTvcX2pNgWJjf+N3MwLMJTR9UTm3ftb9gB/wa3jUrhr9P2Eg4uTYA?=
 =?us-ascii?Q?bINf1ArswQCXDaICKK9lwH3573B5b4ez1e59KjL+vf1pojAxIbT2YEzFSo/3?=
 =?us-ascii?Q?9S2zPz/iq/9kr2Fh72mY4jZFFxWUC2PYBQO4rLgen+dUZ5WfuLcJ0o7ZOenE?=
 =?us-ascii?Q?TKWRSbf+RETN4QXIku/tLh8WdXXZ3raxf0fc1Dfdo3epC2Pi0wyqVPHPAtQS?=
 =?us-ascii?Q?OAEpse8isfldis9vWykrM8qkygiKZa+aULZNGstcD8lTSsutscCUyfUpKgJ9?=
 =?us-ascii?Q?LHHI/CQlNK39OJu5HEnWJY1Cshc/xJKZgi0rc0KZD3vY+YmSRmhPzaY7eDmA?=
 =?us-ascii?Q?nSuTljb4nZcTbVlGoIP8nz4iADYI+xf88qQDKbDn8DXQfe1FNn8ff8mR6esn?=
 =?us-ascii?Q?+1VizL00+09qbtYkFA0HvGtZPai0T0BUUuT6qxXPatMJ6+BPxtyBbh3mkxlt?=
 =?us-ascii?Q?QY1AHYjBIhWfW9useQqLOOuP4bOtXzayqFhcZiwRhwwUp9URDKDckIJnpcVW?=
 =?us-ascii?Q?0zllPwZC/FnRMzwKFFw1kG7ZO55lC/J6uM0mNKWRPeSSDngcUgEgGsm9LZ9B?=
 =?us-ascii?Q?fLc3WCZJ/9SEh+uVmZzOcqJ9UdX35pe+I3JTTz6Xy3d/QlBe+Kb5Z/66K8Nf?=
 =?us-ascii?Q?1kB5smG9++OY0WBgj1/Xn8J9kPnkrumwhRZqpWOsjuAatoN7VlSsGTE6BR14?=
 =?us-ascii?Q?duMqAOPmkOOhbHwa9u+N77F+3V/IaZWd4o86OjN5Iz6YQR9YXCUT/G7tVg/l?=
 =?us-ascii?Q?M3dAIhUi7ZMZIIe/KG4750FOnYNp2sGn3ytf8Jc19d3Nezcx9BpyeLQ1Nvte?=
 =?us-ascii?Q?0afqGPh4CTTZM1BMwJOge9o6JkJIQihuuWbxkTuZ8cs35weAc88VsVWzEu1L?=
 =?us-ascii?Q?ZIq1o6WacWS4Nfg5RSPwyIUtLfUIzhEjAb5p9/NMsbit3tmNI73y4U35EiYd?=
 =?us-ascii?Q?6SLqrTXo4SpZKkwwJ6RyMxVER2WPUec/FIJ2BTe5HArKc9JCSycXz/GAlIky?=
 =?us-ascii?Q?EHXxU9B02cuqzLlwtDT2xU47GBFftn2f1FaF/CetusEOrNR0hrDDfXr1YLL5?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc14cf3f-f16a-4607-18aa-08dcf41b71c5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 11:03:09.1108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fLVJtUquOwPGWO2qQBcxwCsk3Y5FY0cQI8ez5qxDYpX9KITQ2tPR9eEkFmWDb7IIDlPLymia3nW1BJGOLdVMpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9964

This splits the transport set_state operation for unicast and broadcast,
by implementing it as a transport op. Unlike unicast, broadcast transports
need to be acquired/released separately, so changes in a transport state
should not affect its links.
---
 profiles/audio/transport.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 2f5ff6de0..bb2ce8a4a 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -2156,22 +2156,23 @@ static void *transport_asha_init(struct media_transport *transport, void *data)
 			transport_a2dp_get_stream, transport_a2dp_get_volume, \
 			_set_volume, NULL, _destroy)
 
-#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links) \
+#define BAP_OPS(_uuid, _props, _set_owner, _remove_owner, _update_links, \
+		_set_state) \
 	TRANSPORT_OPS(_uuid, _props, _set_owner, _remove_owner,\
 			transport_bap_init, \
 			transport_bap_resume, transport_bap_suspend, \
-			transport_bap_cancel, transport_bap_set_state, \
+			transport_bap_cancel, _set_state, \
 			transport_bap_get_stream, NULL, NULL, _update_links, \
 			transport_bap_destroy)
 
 #define BAP_UC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_uc_properties, \
 			transport_bap_set_owner, transport_bap_remove_owner, \
-			transport_bap_update_links_uc)
+			transport_bap_update_links_uc, transport_bap_set_state)
 
 #define BAP_BC_OPS(_uuid) \
 	BAP_OPS(_uuid, transport_bap_bc_properties, NULL, NULL, \
-			transport_bap_update_links_bc)
+			transport_bap_update_links_bc, NULL)
 
 #define ASHA_OPS(_uuid) \
 	TRANSPORT_OPS(_uuid, transport_asha_properties, NULL, NULL, \
-- 
2.43.0

