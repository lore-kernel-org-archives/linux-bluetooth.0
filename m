Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E953213B795
	for <linux-bluetooth@vger.kernel.org>; Thu, 15 Feb 2024 21:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708032253; cv=fail; b=qVdYvLfCCzvMJrvze6/WcX1mOFU4YEEE9+X5JTJKftdnqp+ZpY/StdhbR/syjefXhLKX6ybss+Fg7FXClbhppRVds6GQyfZ0TDeGa+zfp/gjqqzf6fjl0t0W7Us2Ty5vLwwZihyXxozEVg3/AWmDPRblF/5zHAQkDBH3/PW1G8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708032253; c=relaxed/simple;
	bh=OC85jasOIE5LsWNQBFoX1vYMBw+FJiyAA/rfdA2EWYw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k70zdcZpUgF6F/vcUV8ccbyCyHOph5Ogb1PEYKP5h0hVvZcsaKJ9793sv0/4+JkZyXRL4MwbsTgC8qWrSYwTvA6u2ltwKalapFIgHUJW4v3a04OSRilH1vZGbqyCMbHXGZyv46SThd58vO97zM8fVpCQP5QuUluOtd+AHscf1Dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cv3Rad+X; arc=fail smtp.client-ip=40.107.7.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cv3Rad+X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSKElSexYKuwccz6QUvgy5vjWC7f9E39ns2yXuTwnyKAlxZ+CaAYFajbuyPONaxFx9q+YIlqldovpNPixp9JI8x/OerxPayaGTrPMXqmhUjL8G0Of57DjK5+MRkBGl19TJGEdOgoztIysBUiZxK1/2foeM+E8ctu3HkOdTKbM4uyP6o88SfaMwm4TkIMxC7oej4zuAraQAi+vtIYYVrdhe8dPCnxi4QrJqgJwF+mIFL54WqnYlf4p8vtsGZVkhn0OeiPKI012SudadNLe1UtMOhXnDaia17bo8hajeQ4fDvbxvvzOnPPtGIztni+0a1llzCyIVgTXySLXFPebmCyLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2ApdJOnI5t/qG2qRJb+7kMs5u1ujioxiNWvX8YsKvo=;
 b=IrSkNsWKWpxTrFP9g01n/gXH2MqEPF7VDxyPN3ISljyZxikJhKM3noHE/sedODXLmPdVZJogUnZd11rjYN77RIc7a5MrJ/VvL7MsO69YC63sumQJNgy+Mw0c1Oe7TkJkXFq8LWQIW+nkri14ow7erl56W7d0gWoc28+NbpImKqu4fxcYbOCO8MbcN9HClzdC9VrwHbyTgIOUV60izuhi2r1GRh+Za5rGQOtrWXTS0pU4Utz+jGhrodrw5c+ljvNW9lQThdjxc8K2pNQE8fgS7jLZ306resyLuwLzsN2bmPj1K/JsaAKzqiJFmqH6KtKMm1uL2aXjxiln+nWQprhRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2ApdJOnI5t/qG2qRJb+7kMs5u1ujioxiNWvX8YsKvo=;
 b=cv3Rad+X0suJTphy6vx47H4ZM9p4xXuFS6OsgilYQHsDgImk1ODTMvySlCB8RYIZlm17Td756QbZgkkEkChlGj8SfBLQ8y9zaPYc8yW5DJrHHcVNYmFEYvJhrdja97tLWz4pd67n/DwOWo0JVCqgPTyd8RTIQ2FUOd+3ariKIts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AS8PR04MB9128.eurprd04.prod.outlook.com (2603:10a6:20b:44b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Thu, 15 Feb
 2024 21:24:10 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::c5e1:5be0:c78e:5d81%7]) with mapi id 15.20.7270.036; Thu, 15 Feb 2024
 21:24:10 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 3/7] shared/bap: Generate one BIS BASE for
Date: Thu, 15 Feb 2024 23:23:52 +0200
Message-Id: <20240215212356.310301-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
References: <20240215212356.310301-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0020.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::8) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AS8PR04MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 878efb70-1c78-4c4e-514c-08dc2e6c7312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LAAWQu6MZCCLhaR9eCOq0PzTUJGa85kRGTjNcGJOFZLi5s2CgKlIJb7Y3P1/Z/3gssbiJ1TFfycoQMD/Oucfo7dN2Nqxy6WltOhBEl2LRHp+Wmv0POo61JsgIDrBDi7vUIXFokTVvkPUIG7rFdOXO5nMhhplKNxNa5mrluTLVM/vZOqSASVN7TK8Ho50uDknJ9O0DEAxdlRZdv4ZmISbQJUKjflzIEvNpmC0XcwUjrGa33t6HiuGiznYpZRnTSIDEinUsu5ZKRQutX3Z5eKm8St/d3cEyGnFC1jwF79VO9+DSEtrHfk+o3BJmbZAxspQr61PT1WKz9AmYjx73K/pDeFS93Tmr8CFyxodwbj1kb0W6JSQfJDVgUA0I1lgtt9JcNFhSrrGd15udd//j+xvH01TvxTjU1mfnfHNxa0rSnpvhYpDd3zTPTpz47J3ginx7oQkWv+tHEDdcIjjIBR2k4SuilfDaIP7+e9SSsUX5f5gBgwg6r/00t6152ADuAmyLY9g4z4mYzqWfXoG3CvPhoKwsOjWf6hj3Ndj2o0AbchMm9Ow2nyL0A9b9mV1uSyV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6666004)(316002)(66946007)(2906002)(5660300002)(66556008)(4326008)(66476007)(86362001)(478600001)(41300700001)(8936002)(6916009)(8676002)(6512007)(6506007)(6486002)(26005)(1076003)(36756003)(2616005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6iHvqfFCiyFs+VQmXlw8BRkjrcoT7qMS0yzB5djspA4b1ykh0tZIQ5kgnBe?=
 =?us-ascii?Q?3ZINg35I0Ef043LygziWcKjNnnov9fVWY6uZHf2RrNExDicDd7KhSYyHcxom?=
 =?us-ascii?Q?xtyqutUQViNOcrcNOOXgbsBlsuxGybabCoeXQSBMKRS34yI/9AhfKoeV0Dwc?=
 =?us-ascii?Q?8EYBizV+VSphkpj/mHxO2OD9GvkOVKCALCt6pGOP6snJbDbXufIyucPSRTGg?=
 =?us-ascii?Q?ZZRNHtTSNtfMwkShAIEQ/ciTmbpwAnLbIFrRJlYBIMRaNNy9iO34D8TCcEGn?=
 =?us-ascii?Q?g7mikVorYlVcN55gH2S8bIcvZcGMJ45OkeOfkr7s04I/+bdNfUAi3AW++CQI?=
 =?us-ascii?Q?dUjJNmUnfitpvbFPJs0UZwM2JPArjSNIO5/3ywCEe046BqzR6SpWmEMwmakN?=
 =?us-ascii?Q?fcPxU1idun2shnD03vIRHIZP6qx/YfomSHNj2unm3oOPW6157lPxuXIvrzEF?=
 =?us-ascii?Q?acFYkBEDW0V3aJbAvbKq3wOQ0Fdz5JaV6b1r/7VBODwsbEteBa4np5MPUBtH?=
 =?us-ascii?Q?Xm4oj3OBZmtodVPyVaao6YxmiVyTBiKv7T4MYJdKtPUNk0WNDojr7f+A7XrN?=
 =?us-ascii?Q?s1ghlH0z4jfqrtTT0IYoFGK2xEmutMhejhJ9t/P3aEHiR8lBN5+/8etm9vHR?=
 =?us-ascii?Q?3eIBZq0QWJ/yt2Xkzt2//tySM1m/Gd3FsQoLcpk8zqlS3X09GDfhs2MOocee?=
 =?us-ascii?Q?DW69TbMnF7E9Jq0PjJnD7b3DuWTn11XgMJlpCU4fWItAtK+GKRtvIq1p3knd?=
 =?us-ascii?Q?L19A7eM2KUrJWyRvdFReWcziIHa6w08prug5rr+FVjebEv3engRq+zEKUsby?=
 =?us-ascii?Q?8KYuBWBLSzyCQ+6DncY5vme5u922dEkpOiJzdxXoFoA1cSFritPMkEXPpauM?=
 =?us-ascii?Q?7ZZ7Thfb3IUBXNs3N9DX52wE0eT9+0i04j5wL3GgCJa6LNIuelSpcJXsMhMU?=
 =?us-ascii?Q?/7P3r1fExyCsXQg1zIhX2fG0LZDsQZ0Z2+QEVOQZsUg5b/baZa2mnhC62x5o?=
 =?us-ascii?Q?Xh4Nz6DL4XmLYq6UxOpdF8wd7uRQFfYys+hjTAbLoYJHLmI035P8zf1PagKR?=
 =?us-ascii?Q?NTE3Vi81RlWYYlw6uMqbCOTwv3UfFT4PDJv9k2X/NLNGegSjrdgc5E4MgceN?=
 =?us-ascii?Q?wqJ1frrss/aMgdHqBNhFnPeRgVna2Nb+VDeouuglOZuU5/Kgx0UCntMg6nN0?=
 =?us-ascii?Q?Si4iX/jtIpIZEyea1bHzpGelBtR7+WyY9yjJm/4T+u3EWUVM1UQdyGFA+HqB?=
 =?us-ascii?Q?Atzz0kjH6/Wzlc5KXTL/gnR7QIR55y/RH/iSY/Lv4IaOEtuL9nfnzi+tY4fY?=
 =?us-ascii?Q?lUiGwqyptX4xfeMsbeEFN8H05tVNQ9ODW56kbWLZ6ZbNzYTz8miTcrqN0MrD?=
 =?us-ascii?Q?0wYlgAP5ObdeDdqQAJiSHFFWBDjuOnGm95gUpwKljMF3ewxvQuCcvcvzHjBR?=
 =?us-ascii?Q?ELL67VX40sJEnML83dgoyjqMg1lRuZ4xBIe9V9K+7qZVnP82ZHVI4TYNlgVK?=
 =?us-ascii?Q?X5hUrghy2QedGpYM6CvkhsnzdViIgXHsdcD/24ziVEXfS364w8GTauBZrz4E?=
 =?us-ascii?Q?4S5D/BSaeyUr+i2bXdhqCansYorVxcXSCtJuTVgCxV6zQl+SH6Ffm9DAaAif?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 878efb70-1c78-4c4e-514c-08dc2e6c7312
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 21:24:10.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ijvf0foymbmwrnWHH0oSsUEToNxJXHCyAJxsesUb7JWjQgWgnCUTJzZaRdyBuQj6VQI2e+VLPnmBJKbzx7RuiaCD6TypDTMm4EyePqKvrtI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9128

Generate single BIS BASE for a config with BIG ID 0xFF

---
 src/shared/bap.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index e26dbf944..a39b95407 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -6094,11 +6094,16 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 	base.next_bis_index = 1;
 	base.big_id = stream->qos.bcast.big;
 
-	/*
-	 * Create subgroups with each different Metadata and Codec
-	 * Specific Configuration from all streams having the same BIG ID.
+	/* If the BIG ID was explicitly set, create a BASE with information
+	 * from all streams belonging to this BIG. Otherwise, create a BASE
+	 * with only this BIS.
 	 */
-	queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+	if (stream->qos.bcast.big != 0xFF)
+		queue_foreach(stream->bap->streams, set_base_subgroup, &base);
+	else {
+		base.pres_delay = stream->qos.bcast.delay;
+		set_base_subgroup(stream, &base);
+	}
 
 	base_iov = generate_base(&base);
 
-- 
2.39.2

