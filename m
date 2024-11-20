Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2088.outbound.protection.outlook.com [40.107.241.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA48198E69
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Nov 2024 10:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732098387; cv=fail; b=PDNLy8gPLeX+2U9bP399am1mFs9G/UWYdeHi2ACBktfIJK1Co3I1eMYGbwrgKcRUwEqHac6Z5UGdgKPmx0eMIPqROJjTnTrttX/Qs6lMIEPNnVjR/1EQliw+h/nWoUm+huIIY/VG3cR8ROrxd2L4r6JaY0KEtYmkO3OnGjD4Yic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732098387; c=relaxed/simple;
	bh=8D4+T/Iz8nvPchRe//YkWZcB+4y5I1fVh6dktN8qVoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XQnaCnGtrSV2TZv/n4vuS7/1971AVQNZ2URi7sUDjBfMZxGX1fdMl/UAdxSjjHclEfWv0n8OCNLPiAqgGIDhlVAv/u0q+xTNZOXmfqPoUKSKawAjFFEsB2tVGo9PpvDqhN0hiasrOCgBXKZ34bWNUGsYR95K6oM+GWf38ZLA/JM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W1iB1hZS; arc=fail smtp.client-ip=40.107.241.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W1iB1hZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaFPdJFsjHfzEBa/Z6iLRFqVivGo9S7xmyn2R4iPTLs/Vwe5k2l2jqoHkZ551pnfilY5Cw2t2Dbo5qKionQ2yv6irQGc2DEQp9TQYIko+HNhFgZBE4pAT/CdC3Y2eS0AM6Benz5JxqzsALuxm9hatbqWLvp14ryQNPqz/kKTGLc4f3+hUh08hMjY75HHRYtpWtdwV1rkyB3q5u7J305aczlmvXV8EkHTYJBkKroReLdTfWC4uDH0GVP4ltWCBG/5Jfhqx/fmW2LFMp5x4ZuuNMuQqxB6FfVuL3ckxkvDas+u+ZfVhl7T56zgaMzwOt8mQaKesd4a26+xoYmXvif0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7CCuEdhvRAy8h2vTX1QWI2klzZVTr9TMvz09+SHnZ8=;
 b=Zrt/xzwODWX9II8Iq10bYGJg6EksKKvyCpFcuYClQbakxTnzUIAgb7M8mtLLwX87w3OQyJfw46uvwLH2SYoXqlu4o0SVJVf0w04QA/pWXHYNGxmE1/i7BtZ6tnRIbOJZgJKCz3kO9lXVSromUQ+qkIyAWi4UkzyD3nSEVp5qUkjAQTKjhza+eouhkzfQTOLwMTldbMAXBZKTTxnRm7wDAuy510vjwI+90QMZ+rfv5Ojo8rPOj4iN6SGPrDYSv9gDPDvoe0ExZICPNepqd/vYFNryuQCkLH+r3c9GP/t/o7b9Ix45YWmGGUXFZ6mfe4jHFKxH+TfFP3aNVtSteyNsaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7CCuEdhvRAy8h2vTX1QWI2klzZVTr9TMvz09+SHnZ8=;
 b=W1iB1hZSNveSIcpGCbgcVyKHvUSWlJLCgit9LnJ/4KCwS1uh64K8AscYem46nPOR5Zb595fDEOHmhy9cpiR8IrucI4AenwZSH3wcbEkafJl1vtz7PP+s0qYIWck4IAFNKoK7qYuiS5OodEbiwNMhpaBhFfJf6CfqXGqDIuCnVQkDRIEpo/jVvizP9b33Ck323i7t2uru1g3hdGGrkbL8zzwhB2LNsZlMWQR54lRAzC4aoxfFt1BR+xETW6cqYiSDy7XvgZdJ7Y0vQgvJVqJQIfpeCHeF4PkwmKhliINGIHuV/uq5rXsW25bNK34g+2DmMXdkDwzyN2KswCHqj0v3Hg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8904.eurprd04.prod.outlook.com (2603:10a6:10:2e3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 10:26:18 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8158.023; Wed, 20 Nov 2024
 10:26:18 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 2/7] bap: Add helpers to convert iso_qos to/from bap_qos
Date: Wed, 20 Nov 2024 12:25:56 +0200
Message-ID: <20241120102601.38415-3-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
References: <20241120102601.38415-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR10CA0004.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::14) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8904:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a46f631-68fa-4a85-2d3c-08dd094dc565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?a8SlE/i+NV06Pbm69lAwxR8lpFiYyAc0G2pgPiah1qbMQW5wc7gjM2WeZUny?=
 =?us-ascii?Q?MW1/SONf0eZGuSHc/KG0GapoMAUVu8vzn54csftjwmID/Ap+ylhFgTSjVrNt?=
 =?us-ascii?Q?HiMwq2378CDhcX6R+I02ph0dnKpgz1qPQ07jOjI5sYce1rmzNGtg9AUhUkwG?=
 =?us-ascii?Q?MWr7T/VXqE+Cy0ZdBVPPodcIldg0dQFbzC48j4kDZC2XoW7AVFSPoap+JFTj?=
 =?us-ascii?Q?9P7icyQP/0SROsaISxFG5v/NdSfYujcx6ZcJLckw4iAVVahI7aN8IewMoKHU?=
 =?us-ascii?Q?JPTRyV49SKPLE5yXMO6zx2ViFOOcNQg/JOV2AN+tnLNwb20GKaxLh1RvIVpw?=
 =?us-ascii?Q?DHlCTkFxjF2eujBQopCoQRbAXcdh9JLSQ8zBOKwJey8UCkx5pEFVX+ZnQMJq?=
 =?us-ascii?Q?9o48tZsOS6fcC1gPCxoWJKbaEtQIvZmeUblSeDQ47RTMrjR2bo0Ln9FzxNaE?=
 =?us-ascii?Q?S7/YT65Ba8LdlcdJ5kLqI3NtWAlnxDVeSiybc7lwAswrm8cqkld5zrH+J9+Y?=
 =?us-ascii?Q?BOBMsW0MfnUmEqk3Qs1notyvUM7UTpY4emXy/xWSJakvZ7JhkIxxfUpXds+2?=
 =?us-ascii?Q?hEukCl2AyN9YllAE+5ShVcpKxXPLgEzfOnRX4UyjfTEysQw+Stk14MWylVyH?=
 =?us-ascii?Q?sqfSyQU/LSt1lpodr3JZsUEETq9/2v+Wom8CIEkkpQuu52YmYul06mUyh5Og?=
 =?us-ascii?Q?BuvjCVNGKZyl/3BPQHCW6XyDNxGDOkzh3Yf46V4HxZFC4iWw5wlikqEVk60w?=
 =?us-ascii?Q?73BblMEu6BEoVP33X0CaRKNYDOvxwz7AXCQj/6HoxQ8/gn3bXl6960N5tmu8?=
 =?us-ascii?Q?2wlIG+SHpskVh8vSxeEE4vf0jwvsnX0YBsBXjBOwN0MrbJ+GJFhuCHRxK6M4?=
 =?us-ascii?Q?WMLnbK+Vv3xpvc1FjFMNVMZGJItlNDc7NOFQinefEWe0sb+nhrZk+Q+1pK2j?=
 =?us-ascii?Q?pPOU+AiPgy5o5j5qdP6U5rljBl9yC3ttlkmmk1em3bIpbYvU5siW7htQGkNc?=
 =?us-ascii?Q?S4/31+/WoJUslnTJoMe63pXDfDCW6EMaf11VG/9kH8alJ/x0PpEqQWNUXSXR?=
 =?us-ascii?Q?6jPPe0Z8H8eIF3mpbVd5ryWg7TltZwenzqEiky+zucXI3c97GN5j3H2oHvBm?=
 =?us-ascii?Q?/MDUbDR2nyPHUIPnKqYl1hyCE3a64GwAJ2LX5gqq7iax0lXqNvgD2VXyVjqr?=
 =?us-ascii?Q?qw9TuuSCWgx65f247M8tg0BBzkGG3/gqgjRR4iljz15WDZiP9hN4AqCYOTpE?=
 =?us-ascii?Q?/RlD1+/xOCFtFYF/6kcCng4lkD5L0TXBx0QLX9f5i0ypv+0I8f04gjr9A0pu?=
 =?us-ascii?Q?3YIiTF1N18y/jbFPXP3Gs+1N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DfxO3D/holKoo4Yoph7iiosJpR85fkE7U3F0PSlBE6jv30DaL0I506gg5d1b?=
 =?us-ascii?Q?0E2okHhOvJrKDnBOFfPz1uB8OBHWTi2B0iQY/0DS6uJVWSQ1XGwTilf+Iwbd?=
 =?us-ascii?Q?kXcfSABw2gWEFUNkkws/wPJxj0mXzZY299azKRYZ2OJjlOADvGUZDKszya0E?=
 =?us-ascii?Q?c630rLnvJYnktsNBXRDRO4WiHA0NXZMXqBoatT4pafY70dpEbtxoAIE1WLgE?=
 =?us-ascii?Q?6fus9AfI12Q6zR3B0WHepjnOnhCqYBU+NK6lSOHLbOUd5eja6KifpTVSlOAI?=
 =?us-ascii?Q?DXAJPIJol2WKhqRls4eJG1s/t1qhAO+TUTyh0kW9InTJMpdGxB7tY+l/1JhX?=
 =?us-ascii?Q?k1IIhcXYodMb+4vndgP36A2OjOaAm6UHMYVQ13VFi+BDjxGOVSddT6WCWFbk?=
 =?us-ascii?Q?YwJKroZ7knNF6hZckge1ZfCys8f6qsk+a88ANdzWyRY5m520wZp5rWvPvqU1?=
 =?us-ascii?Q?9opg8ykWDLH0nQuzxAukIw9UKDCYHkXi4J8ZWXaXTgG+ntZQ9zcjvBL/AgUf?=
 =?us-ascii?Q?mxyIzRg8sQj9UPxFf3xODi1Tf+PE2XSC1rt/ysSX3b9PFE9506BP3ojEFI6M?=
 =?us-ascii?Q?x45PHJX9oRIMApAbO9nJ06WV7+fL3lEBLtQtfF50XFoQXype8882fgkdPSxV?=
 =?us-ascii?Q?tt4Svi5+lFsCsdH78upHSPatqmrYN3lUoMvizxorATbhkyjkNgwmOL/6dO6c?=
 =?us-ascii?Q?aZ25DewC2iGzgJGI7GBhq4ME/rnKgdqB2WuFjwg1vzgUdKzrANvvkytCDf+E?=
 =?us-ascii?Q?ABteahONoCZq8yCfV2yAUvcRmpJdjl3/iWP3EhHux1HjD/JP6Ja5c1SSq4dv?=
 =?us-ascii?Q?+jbdHV1p27PMJgT7CN6D2GBQFtJfU+TUAQuqUnQ3RmDGPOvV94CifRj6iblu?=
 =?us-ascii?Q?lVIq/ALgSdkO3pwg7+BlYxKWHTaDAuH9Tk7GshkXolkgyYgOqk85yDjQptb2?=
 =?us-ascii?Q?94T0VWJKfdqhfj8PNvCM8tcUPiet7J5XYY2P8HyR8J6fGA4xNkR+JxTBxCVV?=
 =?us-ascii?Q?ldDf2sa6dZuIRbM0ja9CRWnpKB+rq1HWdeysJZdYrGmvlYgkW8FovnZBWDuz?=
 =?us-ascii?Q?iA4ZUpJzOg+IAHiPMa/qPWcF5DAqhGKYvNKVo2Hwk0JOBwLN4T+S9Y7I1Fn0?=
 =?us-ascii?Q?N4JPwqLBFUkpHs5Oo3goFscABe16oyMCnBb5cP3uoanHP+PyX/0p0SqsfAei?=
 =?us-ascii?Q?L/eagDVKzvSvnagR2nqGV6en0h3Usanu1F9+ZUHxnI0lWbdB24aOIwFRnSTU?=
 =?us-ascii?Q?er7UL9bCF021G06EJmHgp8SXASfE6yzbNB94uoUlhC9qZ/7JfioH5zAEdM4k?=
 =?us-ascii?Q?HL8p6IU60+NA8tcEfIA9lbq7rr7JhbyM1Fgnh7lIBDX3LgywfCiQPAtXNmTh?=
 =?us-ascii?Q?NEcBQrgKo5EdmJYjK7teHHF/xTxhvLuwV3RlKWnWHIygDXT35M+5iiPE7X13?=
 =?us-ascii?Q?stCjJDMBUSTbhdVXqJCSpoSHOZ3nkVc8vQwh5ojV5gnZUuch03HqOS7QQ/pC?=
 =?us-ascii?Q?88bjpTXKcAE1HSNPpnYwreMEJYz5HgYhygyU1j7SIaHdKz09UQy5BHukA985?=
 =?us-ascii?Q?IPzSC73z+jYsyXwZYgQHonE6YWfHrJVzsb0quUrZbbXvwKNbHh+K2iCZQFBB?=
 =?us-ascii?Q?EA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a46f631-68fa-4a85-2d3c-08dd094dc565
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 10:26:18.7185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSfDC/5hK3j1UvRwRE4Kv9nA+FUFCFk/PJ+DSY2M91JWv+bRx3PoUaHEaNRDSYPArJVDTGSSaDpKCeY61qjUeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8904

This adds public BAP helpers to convert iso_qos to bap_qos and reversed.
This is needed for the BASS plugin to handle the Scan Delegator (BASS
Server) role internally (to create/handle BAP streams when receiving the
Add Source command from a Broadcast Assistant).
---
 profiles/audio/bap.c | 93 +++++++++++++++++++++++++-------------------
 profiles/audio/bap.h |  5 +++
 2 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index df685c6d3..6acb0895c 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -1041,6 +1041,57 @@ static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	util_hexdump(' ', v, l, user_data, NULL);
 }
 
+void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
+				struct bt_iso_qos *iso_qos)
+{
+	memset(iso_qos, 0, sizeof(*iso_qos));
+
+	iso_qos->bcast.big = bap_qos->bcast.big;
+	iso_qos->bcast.bis = bap_qos->bcast.bis;
+	iso_qos->bcast.sync_factor = bap_qos->bcast.sync_factor;
+	iso_qos->bcast.packing = bap_qos->bcast.packing;
+	iso_qos->bcast.framing = bap_qos->bcast.framing;
+	iso_qos->bcast.encryption = bap_qos->bcast.encryption;
+	if (bap_qos->bcast.bcode && bap_qos->bcast.bcode->iov_base)
+		memcpy(iso_qos->bcast.bcode, bap_qos->bcast.bcode->iov_base,
+				bap_qos->bcast.bcode->iov_len);
+	iso_qos->bcast.options = bap_qos->bcast.options;
+	iso_qos->bcast.skip = bap_qos->bcast.skip;
+	iso_qos->bcast.sync_timeout = bap_qos->bcast.sync_timeout;
+	iso_qos->bcast.sync_cte_type = bap_qos->bcast.sync_cte_type;
+	iso_qos->bcast.mse = bap_qos->bcast.mse;
+	iso_qos->bcast.timeout = bap_qos->bcast.timeout;
+	memcpy(&iso_qos->bcast.out, &bap_qos->bcast.io_qos,
+			sizeof(struct bt_iso_io_qos));
+}
+
+void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
+				struct bt_bap_qos *bap_qos)
+{
+	bap_qos->bcast.big = iso_qos->bcast.big;
+	bap_qos->bcast.bis = iso_qos->bcast.bis;
+	bap_qos->bcast.sync_factor = iso_qos->bcast.sync_factor;
+	bap_qos->bcast.packing = iso_qos->bcast.packing;
+	bap_qos->bcast.framing = iso_qos->bcast.framing;
+	bap_qos->bcast.encryption = iso_qos->bcast.encryption;
+	if (bap_qos->bcast.encryption)
+		bap_qos->bcast.bcode = util_iov_new(iso_qos->bcast.bcode,
+						sizeof(iso_qos->bcast.bcode));
+	bap_qos->bcast.options = iso_qos->bcast.options;
+	bap_qos->bcast.skip = iso_qos->bcast.skip;
+	bap_qos->bcast.sync_timeout = iso_qos->bcast.sync_timeout;
+	bap_qos->bcast.sync_cte_type =
+			iso_qos->bcast.sync_cte_type;
+	bap_qos->bcast.mse = iso_qos->bcast.mse;
+	bap_qos->bcast.timeout = iso_qos->bcast.timeout;
+	bap_qos->bcast.io_qos.interval =
+			iso_qos->bcast.in.interval;
+	bap_qos->bcast.io_qos.latency = iso_qos->bcast.in.latency;
+	bap_qos->bcast.io_qos.phy = iso_qos->bcast.in.phy;
+	bap_qos->bcast.io_qos.rtn = iso_qos->bcast.in.rtn;
+	bap_qos->bcast.io_qos.sdu = iso_qos->bcast.in.sdu;
+}
+
 static void create_stream_for_bis(struct bap_data *bap_data,
 		struct bt_bap_pac *lpac, struct bt_iso_qos *qos,
 		struct iovec *caps, struct iovec *meta, char *path)
@@ -1050,28 +1101,7 @@ static void create_stream_for_bis(struct bap_data *bap_data,
 	setup = setup_new(NULL);
 
 	/* Create BAP QoS structure */
-	setup->qos.bcast.big = qos->bcast.big;
-	setup->qos.bcast.bis = qos->bcast.bis;
-	setup->qos.bcast.sync_factor = qos->bcast.sync_factor;
-	setup->qos.bcast.packing = qos->bcast.packing;
-	setup->qos.bcast.framing = qos->bcast.framing;
-	setup->qos.bcast.encryption = qos->bcast.encryption;
-	if (setup->qos.bcast.encryption)
-		setup->qos.bcast.bcode = util_iov_new(qos->bcast.bcode,
-						sizeof(qos->bcast.bcode));
-	setup->qos.bcast.options = qos->bcast.options;
-	setup->qos.bcast.skip = qos->bcast.skip;
-	setup->qos.bcast.sync_timeout = qos->bcast.sync_timeout;
-	setup->qos.bcast.sync_cte_type =
-			qos->bcast.sync_cte_type;
-	setup->qos.bcast.mse = qos->bcast.mse;
-	setup->qos.bcast.timeout = qos->bcast.timeout;
-	setup->qos.bcast.io_qos.interval =
-			qos->bcast.in.interval;
-	setup->qos.bcast.io_qos.latency = qos->bcast.in.latency;
-	setup->qos.bcast.io_qos.phy = qos->bcast.in.phy;
-	setup->qos.bcast.io_qos.rtn = qos->bcast.in.rtn;
-	setup->qos.bcast.io_qos.sdu = qos->bcast.in.sdu;
+	bap_iso_qos_to_bap_qos(qos, &setup->qos);
 
 	queue_push_tail(bap_data->bcast_snks, setup);
 
@@ -3158,24 +3188,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	queue_foreach(setups, setup_refresh_qos, NULL);
 
 	/* Set the user requested QOS */
-	memset(&qos, 0, sizeof(qos));
-	qos.bcast.big = setup->qos.bcast.big;
-	qos.bcast.bis = setup->qos.bcast.bis;
-	qos.bcast.sync_factor = setup->qos.bcast.sync_factor;
-	qos.bcast.packing = setup->qos.bcast.packing;
-	qos.bcast.framing = setup->qos.bcast.framing;
-	qos.bcast.encryption = setup->qos.bcast.encryption;
-	if (setup->qos.bcast.bcode && setup->qos.bcast.bcode->iov_base)
-		memcpy(qos.bcast.bcode, setup->qos.bcast.bcode->iov_base,
-				setup->qos.bcast.bcode->iov_len);
-	qos.bcast.options = setup->qos.bcast.options;
-	qos.bcast.skip = setup->qos.bcast.skip;
-	qos.bcast.sync_timeout = setup->qos.bcast.sync_timeout;
-	qos.bcast.sync_cte_type = setup->qos.bcast.sync_cte_type;
-	qos.bcast.mse = setup->qos.bcast.mse;
-	qos.bcast.timeout = setup->qos.bcast.timeout;
-	memcpy(&qos.bcast.out, &setup->qos.bcast.io_qos,
-			sizeof(struct bt_iso_io_qos));
+	bap_qos_to_iso_qos(&setup->qos, &qos);
 
 	if (!bt_io_set(io, &err,
 			BT_IO_OPT_QOS, &qos,
diff --git a/profiles/audio/bap.h b/profiles/audio/bap.h
index cfe633311..2968f6216 100644
--- a/profiles/audio/bap.h
+++ b/profiles/audio/bap.h
@@ -9,3 +9,8 @@
 
 struct bt_bap *bap_get_session(struct btd_device *device);
 void bap_scan_delegator_probe(struct btd_device *device);
+
+void bap_iso_qos_to_bap_qos(struct bt_iso_qos *iso_qos,
+				struct bt_bap_qos *bap_qos);
+void bap_qos_to_iso_qos(struct bt_bap_qos *bap_qos,
+				struct bt_iso_qos *iso_qos);
-- 
2.43.0

