Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54DED1BBBFC
	for <linux-bluetooth@vger.kernel.org>; Thu, 28 Nov 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732809687; cv=fail; b=A7UgidqXURN0uNiL6wXPIPElHO8ARJp6/kl96Vk8KeX2PsEme8HYMkA7BTf9pwJh0xJl7esGmtqEYjT+pOpnE1WIs5CVtwft/r/YXmPnFoflnfDx5+2mXPBl1e60zEFMDXXJ5gLRKeBCyot7Dopwb5AFmESdMpJl4vyfXb1AUPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732809687; c=relaxed/simple;
	bh=8WAgU+1wp8MTWmz93PXZWyOF9hd5WM70Ev+wRT2gdl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o9sMiSL0Eg+vCErMdCFkYz5tojw3jSwCgH+1lJ88ec/veNUiEREs0xex6nVGQZKGTeAbs7UOYQ3UDxpHlC35+M+3n3s+B76L9GdygrD247tMCXiNdNEgMWERiiE2uJ5HNLAnFvKlcOJ58h//mFAW5G3T4RL7elodMH69Zk3iTmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=fbx84JiP; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="fbx84JiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4LqL7Ao+JTMpj/n45TVOmk7nAiQlnXRsxkiRaAgEm+V6ZVX9N5jlId8E6mJy1jLjLzXRik2Tx4AG8sTxE2lg/0mDA/F1+RjWgpmTyPGIHwo6VQJc5fhGr0mwp9MaxUkIajalawQaSf7IBUYFtnSGIvHScrkhwq2jJiQjNPQk0MZrqQX6cVv9gI10YK1R2/wADn64EiM+Xu2GvNHt9Ybvj7+WJaz3O2MgGkZiBy9wzYHEN8TClVoT9EcKXsoImjTsOUvtUPXTlfPyj5o6d1L9SyGeetnV5G0rE7OxJcPKTDZkI4Ptf8qtl2axWAlu1jiksb8orzvMfCzaiLC+gHyDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZXNggogADe6BhYQz1XU0g396QUSFYw2Kdn5IRdaVsM=;
 b=YA9fx9z9aa775wFN58Qh2s14MNZH5tlFwEM+cahGtrx/CKWr4w2Pm8q9heyDmrY+CrAALPseDg+92xX2IgbGymLZ4g2KyaNMYsOCPzo6pxFW4oIqeLmbgPgmENQTx9wUKJu7g5AW6mE0854UNotIf30aPdgNdjbvTncQknvRWb26BdutmU+pJc5Rno7edthvTlFAsc6AcYa+6ag5H2kZIf6EhSEHdkvx+NGQYh/vvdg7HUw9pmX1MuO67VMRecr1eFcDsh4YPZdqC3Ii80B2o+9AviG6zssLwhiPmepu1PVk+yBFgZoP6etXQHoSM9pUfHKwd0e+eU9jtPjuvEDl1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZXNggogADe6BhYQz1XU0g396QUSFYw2Kdn5IRdaVsM=;
 b=fbx84JiPqSQoAsez8YCB0GLv4InYR+2MlndWeJT2wrrPh58DhkLLfJ+JmVlgFmz/iT58DfgiHbvkoek8+yheAP90IVzCMeNjBvsxFTaNbeVzg0BB+PyruPIx+Gq17Qd+vtJLKmjlhZepDVU5KdDBXytupwhKjVTJGWx8115T9yWTvfROk7wXg1PWkvdlCKy2eaFowKtUrrxopTwCk/pr3/bNzvupOeZJddLkvaU45z3BA5IkqDPCzx/DQomh37BbcUAK3+W99LC8Y+XVAnfqNVdn5gteF/+/gzI4ST+BNUjfKA2FliIwI/VpcKFK06nou2YGL6CX/SRZYwZsFrstdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB7191.eurprd04.prod.outlook.com (2603:10a6:20b:11c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Thu, 28 Nov
 2024 16:01:23 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 16:01:23 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 1/2] btdev: Unlink local BIS before removing
Date: Thu, 28 Nov 2024 18:01:00 +0200
Message-ID: <20241128160101.15187-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
References: <20241128160101.15187-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P189CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:218::12) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB7191:EE_
X-MS-Office365-Filtering-Correlation-Id: fbf6b49c-4c4a-43e8-ea3a-08dd0fc5e7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bu0A+LJKhcD736jevyhknV2h99kIq7GEGdcBSeNIiafywglC3XXT5KoyMJJB?=
 =?us-ascii?Q?eAxPLGa4pu3z2ZETPfavIgIUpAnVWGP4oc2UkVX1sGWWe5o7TqVz7Z8cKnfW?=
 =?us-ascii?Q?5MhOGFNNfckbk9EFL3gnBGPdIIgAhaCL+AS22m9iCKTvEdidOo8R3V5lWqM7?=
 =?us-ascii?Q?xqbpSayNfg6QIGMXyqk9MBvI1XHAO4hyFRmcMjekg13O7frqCkqMRKg8z3Gw?=
 =?us-ascii?Q?XZppk/oSAaK6bWOeovnTITeYFsNDL0dF0yzdM8YaUgu0nGn3XVmHzsRpDl/Q?=
 =?us-ascii?Q?wq1nQybKI7snD1ANO4OiuTx6tlbbxfWrLiS3c8383ymfX+YoJIHIGvglDkuv?=
 =?us-ascii?Q?gyZP5thH/L6OW8Tv6PBESGBEPj+2qy5v/q9RihAGrETDaRXqmUzV/aSJ2fiw?=
 =?us-ascii?Q?I71Js1D53D7kFLSbbLiUsY96RaPpIwxRRjioDJzGVaryFPOZQz7cgogWjWaE?=
 =?us-ascii?Q?63P0L1z75sAI6/R9T6cNaTJfOZ7il6JSFKztKU56+nonEO1Ly2EdOZZ6xkjq?=
 =?us-ascii?Q?rc8YjWIIATMK8Ug/4CsHbz8iCQHLRGPNraV8JZLhFlOVryqdoS++Tz4qGuQa?=
 =?us-ascii?Q?5Vw8QPxJDC888FZ8uYVp6lmUJlfrLOysyW/khjGU8l5anJnhFJx29x/ExMaf?=
 =?us-ascii?Q?GeEDAqqDl2wxqdYW1cqpf09LPacIOfjpknAh797vmZMFxBopslAL1Y6mMklJ?=
 =?us-ascii?Q?meoZZB1goOl3ktf7QVytJYqrcF7W2G/7nzgJYv2ncKCo+LmIB3U5zm02YSo4?=
 =?us-ascii?Q?qyqoBgJ3ybPkyVlB7IEqqWFsL9mURZbbWGRkiQ8vUDPtCHPpC56FOkA/hMU6?=
 =?us-ascii?Q?skFUp6JxgCNq+4TJPNSE7AkM0drxtNY7lAf0tkWbpEZA37nEh0RA0oeteiOr?=
 =?us-ascii?Q?3A8yV7U9WY6wqK/tSjoHNxko5b4FqzfUGHg7yiHKJvh7Gz5IR/fkelj/HVRQ?=
 =?us-ascii?Q?2bpnGOXzauNtGK+gE7YuSfkybwnECs2kLe43T68wbRRQbIJO4S44p2VESPlb?=
 =?us-ascii?Q?HCtEmMuv1Ks+D0PbOmZ2FBYb92co9amw7gxvbae8m7ScOZHkp39gFl0adTvy?=
 =?us-ascii?Q?KTOPMLf+CEPWtQ/TF+309CAyg8Ih1yDraxbOurNxjMNHHxIwL0EhDSivIZDD?=
 =?us-ascii?Q?CE+VT6R2pemUGu4UyCUmqEDtTuM5YEIzmX0nytxS6219eZaXK0sgmzu2cpUQ?=
 =?us-ascii?Q?v0Y4zCFDgtMASHQujUHSKn9Vxe1rxTvyR4JC+WlQWlXH3hdQnM25w3CI6wX5?=
 =?us-ascii?Q?8aVYcI5BOed+/ZDUsP5JQvcfeDSEqVCDLoI+EI/XU/ANrDyViKz4css2QeLv?=
 =?us-ascii?Q?BC5jqS+FiANd0ixPl4j+nMr/J1rA0G3BnvzXewzWEySTJg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zyZPj+1w4YCikAr56pRgRc+cw2IihWfhAXFSpy82+EYvYU7XYQwVJqb8yEqF?=
 =?us-ascii?Q?KU05sMKmixT0t3p0U5tmbzaQLRkzsD5a2zHxgVz1u4s6OEl7Er3c9t4FctTx?=
 =?us-ascii?Q?K5O2pU5tqnrAVEYwjt8F6jay6lzDbee+kNDnfgjuNk4nvwzTd/d1ypqHxjxH?=
 =?us-ascii?Q?ik8BKC4oKq+lLF4XKhilyc6rDWlZWFHxzUDs8ZxZmRLzPgYXDU9Ogrkq1PTY?=
 =?us-ascii?Q?VE/QJEw3OqFmetlDSURO2swBjeEa7fyO328GeeiVm2GNBD4wNzRetjQyCpqH?=
 =?us-ascii?Q?w85ab399c5ZAJFz1hPc6Hh80dl9imc4iYjpuCYxHVt95obFnIdsH+2MbBxMY?=
 =?us-ascii?Q?LBoobQVfpNbHUrwSL1+o5ATH72r7dvn+1zmcL3dK04Q0qQJ8qBCNi5c6nikb?=
 =?us-ascii?Q?MlUW1bkV/VvoP5jBYzdJYGtbDM4rJquUqXrwMaM6z+aXMreNGiyXR0vE859y?=
 =?us-ascii?Q?NnvgVW8ZwAEC3i5d+KitTIcmCuZcT7dD4nKLKxQg3ETw5b9gpJqBVlud92tF?=
 =?us-ascii?Q?hgh5sl2n/FGrJsCIEjgAdzF3Q44bfZjZPubI7MhGXf+j64zep+v6o0wZAau/?=
 =?us-ascii?Q?r1JfrewgXXgnaawVXZkNwIK509Gb9L4O0TbcBItEOAsUwapvcXJg8DwtN5cf?=
 =?us-ascii?Q?CPTOTLwVsPQRFIc0SLrZYU4Od0quwsz4t6Gg4rJouq4uNVha1INNR3+J0Bxa?=
 =?us-ascii?Q?bzA+AHUjZ71QUcfXHGorOZ1eWzV2RPZ8QcCuhhKBBAu2b5WewJuFo8HEqw3m?=
 =?us-ascii?Q?RSmDdA2rAUe85xPcYaJldiCdsnweV3iKKHnxdvxXNerg0FNoUQjr+bpAd8bp?=
 =?us-ascii?Q?kpjx1ZEihq5rHXFTxj2AlHrpPk5Dn9orbgfw78dS46IBHcLHZb7O9MjnM7mR?=
 =?us-ascii?Q?i6ZHgIWwAbwGSfG0sNc/G0BRDogLEofIf91ywv+1RuIbzf7bZCKw47MPInS1?=
 =?us-ascii?Q?/GGAVzO2EgFrNUU1V7YLOHl6Py2+pP9RJ+EuOrEAxoA1YBVbMi+eOng8xPBB?=
 =?us-ascii?Q?hyfViTANaxxrHdpErKjKCC5sHWzoUkoVpPRFkn5tBqvCOm4Vl+1RpOt/ypUy?=
 =?us-ascii?Q?kAunf5VsfVrU7QfNutt0se9PQfSYgapN56VXSg/5Qozg6ciYgAtBlfeYOeJv?=
 =?us-ascii?Q?8UtrA62Jv73kNl13CxyhjgQwgK3Kh2AMUpDZAndoOfiP1xz4exPAeNL77X1G?=
 =?us-ascii?Q?PnVkjurA1ttxKPWzi4++pytphKrmJbhf1XdnW3+dMODkpCHsQhYYzMPdB7Oi?=
 =?us-ascii?Q?hx9A8BSqLvIj/sLp1w/0RjMnTTZhZWPaM4G2HxDiemXCBbTXg/GycEFUxNZK?=
 =?us-ascii?Q?oq3okXaY+hFYQIRyvSWXZk/JCis6emx754WCGnr17OdcKuhFrukGombMhyaf?=
 =?us-ascii?Q?+LowpYLg0BLFTdiHm8gsPvd5u/2LlHYQjhs2VeJoBPTiAn6VQqVpCAg3A89o?=
 =?us-ascii?Q?Ora7Eml0BVxyjq2AMT0Qhq1Suy8vGPpbI2/NJUNpeK9euByUnUNzvRcTP04V?=
 =?us-ascii?Q?Ht0/VCK+gtQ7WgiJW5AUTp51bPJTxBrsH2zHCePRQMPCHM/kndt2XeZnIJXV?=
 =?us-ascii?Q?fgS8zxfM2j+HkpqB/V0dh0ipyvw5TUc3rhfMq2Q9vjvR9wKRcg3Krqouj7g9?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbf6b49c-4c4a-43e8-ea3a-08dd0fc5e7fc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 16:01:23.3728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2Bwe/YrivyxzHWLrb2p/0a2dW3YxtGObAky6igq93AH2SOc5qewb2vIj3lBpCSCLSr6IxHqebiKP+rdqH6mpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7191

This unlinks the local BISes from the remote ones before removing them
in the handler for the LE BIG Terminate Sync command, because, otherwise,
the remote BISes will also be removed.
---
 emulator/btdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 08af873a2..70229d9ee 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -6604,6 +6604,9 @@ static int cmd_big_term_sync(struct btdev *dev, const void *data, uint8_t len)
 	/* Cleanup existing connections */
 	while ((conn = queue_pop_head(big->bis))) {
 		rsp.status = BT_HCI_ERR_SUCCESS;
+
+		/* Unlink conn from remote BIS */
+		conn_unlink(conn, conn->link);
 		conn_remove(conn);
 	}
 
-- 
2.43.0

