Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2066.outbound.protection.outlook.com [40.107.249.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE37B1F9431
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729858963; cv=fail; b=BE/RoXHLUjVQ4cQ46icn/TIYG6yc/OVgMw8OxShDLz7ep4pON8uWB98ENx3K6ZL6fkRmRC/8BJ2UuhluKLGgJGJCO4sgyIs/qofwXoEqyGeKfSXUeXzUJrJGCUo27RCADqq1G8A2BzmWyXmOvFdYHBUjIQbtr+6UENE9EPfFt1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729858963; c=relaxed/simple;
	bh=DgyPv53iHdnTPOrLt2LwIbzrvEY19ZYNPyeIZR3Sbas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Prhm+KQRdARslre6spyRVSZPyxAJ7o9g0/4sea6PTBII3gnPqqq8P8+X7QKHrBfvK8tjPUaMpY58rzrRsNPWR0TW2rcF2h2OFolj2NmVVScj7RBuzQkgr47BK+zl6gjdwO0/A3hdUO0BBsELJX3B+NFLDjyFYMFKRYnOepgcPQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bZ28z84n; arc=fail smtp.client-ip=40.107.249.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bZ28z84n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=as+k3WK/Q0t/sESu2PkRSBXgzFctihyFD1CYC0Jv2tajASez+PP6K3iraSjS/FgXUPVbehvoNk+srG2lXs5LoFjsNfUUcyYlrG+SJnXC8WI1TawKsEvSKWlsURNe9rXchnesHj471QVmrHA1Qb1hrRitSjBnUAkciHHUQRiau0AHDwouqDxMnaI8XSojz6oaaf2OmIE5iWbanyNv2qydwYZeGQZWq8vXUNPZi7knTPZEkYLqbJJHgCAAq+aNj7rEkxnNNvEVZDGnXoX9m6+/PGA1jU8KR1tfmZQ3IJHjKMacvOvbHaeWtdhQXMSN9jAlGpHuZvoZ619LMSm5/5US+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StK26AHiMKpFaYLOHxcQCIgxucrxIA3twyNPzY8kVIM=;
 b=gBWUssjzjJ7Y16PvlO5WOqgoLG9oOdVYT7XZ/9eCPkeNwhBzykkF8XUtxP9JPmhRVytEzwKr+Ysgqv8bIAip23CvmHoJoy+3nWQs6v82vTv0n3LM3WFAqyG1k34Fw2KMa5iSexhAQMKoWu4KUv22m2pJdG4G65kcdYDwuy8Tic/W1UcsaDgUcFRbQ/f0bXvWcLyuoifjUGosPvTpWJI6FapW3ow+THy4fH/J0SmYGZeevxwIDXDn5TBoverGer8DiQxOI0NHwmi7cx0JlWR+TuEG7d53DnqnHPpG4Ey0VVqw4MvaQO19cfYYsuWZ/uY8TsBOjoz7Whxz48MDOWA7Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StK26AHiMKpFaYLOHxcQCIgxucrxIA3twyNPzY8kVIM=;
 b=bZ28z84nHXu3jGWhacWGtKHByr9NygbBuvaBuePxPylnvHdGL31w09WjEvT0vEj7dcSU3gXHkA5gWzYpbJKjbu5mGngYZSPIiKCt1AfZAZRKTBbKaZl4BIOiPNFGWj5/fy3wcyOgObPmuT/XEN5Flro0/jpw8PSZB27AjPEGsVNLMkXm807GbiTzbrzftgWqjDv/aXaPXHPPrY8i1+zRCQY6smwbWuGz4jCNS0i3V168bkIjffAwo7mKwe7MPvbUCekEZZqDXssd0bLWnnh21T9aklTfNWHrWLJTr0Z/is7BRYfOMXYlls7ENvkyah7PTXDRbqWvZoNrcdaiaQN+7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VI2PR04MB11052.eurprd04.prod.outlook.com (2603:10a6:800:272::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Fri, 25 Oct
 2024 12:22:33 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::5e22:869c:33c:9654%4]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 12:22:33 +0000
From: Iulia Tanasescu <iulia.tanasescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ v2 11/14] transport: Make transport_bap_set_state part of BAP_OPS
Date: Fri, 25 Oct 2024 15:21:43 +0300
Message-ID: <20241025122146.17925-12-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
References: <20241025122146.17925-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0006.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::11) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VI2PR04MB11052:EE_
X-MS-Office365-Filtering-Correlation-Id: 3522a52e-04d4-4eaf-919b-08dcf4efb3e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R3HSlg3yYDdN2W/4VXr7HV7s2Mk0E16xHxgNHvNEoFazN6+OaY5gD35Lma1b?=
 =?us-ascii?Q?/5g3GmyNxRal+ws8UhgBg3zHcxuvMfoS+Hkg1V3V9Ek50nhkS5ghf0QT3iWK?=
 =?us-ascii?Q?UFC07T0nUWo+EUNXXcnjnGBo2rzzZa/z1EpL4Pm/eJSzDJpkBaVgM1NqZa4w?=
 =?us-ascii?Q?9j7hYhdP+vh5GJH5ytKbqDf/2+yTcniB+33Hjjn4KK7u4TT1C6IIYEKvLXxN?=
 =?us-ascii?Q?urnxNYaU+lDnA13stfNb9tgabXCgvbC8t2t/aadrO2XyAwUpkOJ7EWqwTcH6?=
 =?us-ascii?Q?TyszmTuXHnPl4UPzCzg3LFyYuUVmFc0E+8lXDWtaF4peL05ZpgcEl4xmOo8y?=
 =?us-ascii?Q?kymdxGMkqsdjOhvk5J9xDM/3+tsNLz4NyGFrGL/eglh24GYCkacE7DRit1Ho?=
 =?us-ascii?Q?VNuf+7Ak7963z3mWVk22FKRUQ4nvCjBQVZ0ayHkTbGtmkOiWVSxG+Cbp/Dkk?=
 =?us-ascii?Q?Yq2YzAuabXVU09ve8d7YY/OWZZFy42YBPEyTTKf96gXCtBTZbrk+GlmyOH2v?=
 =?us-ascii?Q?rHjmcpEwj1tDEcRMyFmdOZ1l/tydiGFDf2vM/X8+Cdzxbg+yN9KIGyU0thI4?=
 =?us-ascii?Q?KV+DRh6JcJRsV4GjRFesQqpXwuN7C3PN+BmLtZKEMvCVCmLa48Df3Wcur8v3?=
 =?us-ascii?Q?1pltAaBLDdlJwlL04SiTU8v/CcYrXF/8gdkXb8qW6sQtiqjNOzot3D8+yIWT?=
 =?us-ascii?Q?UPT3CuXrfiT7SbBXQ1vGSXMj5J8anhPQ52nRMe69MQWfaXEzP+DRHiYOi/e0?=
 =?us-ascii?Q?iXNGhYKR3GyRI7F/qn7yHRQO7zjoYIzDIZNOFmvRkoQoACes/AHSg/3uNXVY?=
 =?us-ascii?Q?nXCg5opuhTqqaz6X+jUXgzy+YOCI+qq3A4jdFUqL1XE2vDzIzhTPso4WNSgx?=
 =?us-ascii?Q?6cGDjzdvOdYBXa1eMD/JD9LxoNef3E/fDmYg76R2SrL4+045ITO321VatJ+D?=
 =?us-ascii?Q?7gnAAOX+neJdDQ52pbvP5yYylf+gZUzJgYUUuUnlWS7Yc8PbrKyv19uGAIFW?=
 =?us-ascii?Q?kln4fWC6PN33lHUUTzDpV+FhwXrP/bWWAP6VnwPaEZ9X195DZI2G2kS5GRy6?=
 =?us-ascii?Q?gjUJYTySKjItMxKpVG7jixS7VJxGOEQ+lbfjcIazhLk4bg3vs5lEhQ8dx9d5?=
 =?us-ascii?Q?+/ebQlmWAqGIzyVp8P9h5llwbSEdk/lDjNHT8Yo7ChP1BHJFg98HUNYMU5X4?=
 =?us-ascii?Q?wX3JQzALtUcxUFJsouk0F3jkaSeYbt00Bkm/he8B4DtAKIaEzXiHww3RzoQn?=
 =?us-ascii?Q?KHSb+YB46sLJHznJ/K8YD4+IItEePlg09GzKWCtyWDp/sfVDcF+OcI1gSjwL?=
 =?us-ascii?Q?mJC8fpwDxc0hLbpZsQghgl8x08B+e27DrmrnW6/OGzPrNxPRNo5uzw4fwYn4?=
 =?us-ascii?Q?MIFOUjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5D5GcmFJCoBVmMTIT6vzavlFylrx+tX/wbBmoaK0RW2DnFvVwx7+4Ae4zvzK?=
 =?us-ascii?Q?U+iQ7/h4NOmDeZkyfhZvchxRFT7VVOL1hGPBls/BoEoGCXn5gJeDVjgikWfh?=
 =?us-ascii?Q?RL02pCU0ulUeA7skUJ9XhaBcrZ4Ynq2FjgaNJqanFkGNBDcLcCW1AEyvdOeY?=
 =?us-ascii?Q?00M/y2kNF6KAvVrSPMHibzWxqpkgP+xUmXVXmaRZmQkW7TEmBFE8yuDuri4/?=
 =?us-ascii?Q?DO/+g5r4QfGNID2Jn1lDXGVL/nujiGb0BfJGBs7usW8loZYfS0Yld1BjVfNP?=
 =?us-ascii?Q?H0SRn/pyNkT49jEfZ0wNJOyWLZ22xS//hJtl0EAzPoxpeHBhsM7VGFUQWX0g?=
 =?us-ascii?Q?uGTzrZeCzOQzt+wHjmIyg2zPYJ1P8Ybo3eT4fOoe6Win9SjBY0aw6PP6RfYi?=
 =?us-ascii?Q?jJFCYTgzoSh5JscQ95bGIZkbmD5iZMfqHCgFSjQjiSNnVwgqO2YKSywIefnf?=
 =?us-ascii?Q?2jxc5siUFAtFCOx7eOZPOxmOx+1WYkAIoEjejaicSj4tMOwG3yWj0veJdRYM?=
 =?us-ascii?Q?S4MAOxbd3Vi0HbFGO28eyOywXkNny2stAksLyOoyRWMz0/7W9byD/Wg40ROT?=
 =?us-ascii?Q?U5P3WEGmNUDWowdZw1eKo4LfVCrkXA0D2UMm1FIJXpHXisjGSg3zVq+8bSu5?=
 =?us-ascii?Q?ift9j3zy7DmIpFkbsAJeQl2kXcNn/Vum7y5PYNicnpUIoIFb6N9pQx38lG4N?=
 =?us-ascii?Q?Pi6ID013s287tWXVKHCg94i8j1PflTKSFe0Sf7QD5B7XtYdooxBmnC96jqH+?=
 =?us-ascii?Q?tIRFq6gBq2yugCijxxhvhPse8ydO/wXnhmurE8ykQ87FAxnOlSo2XbgQU3rL?=
 =?us-ascii?Q?BcHPfYRNY2zMumXCOwccGJD2eSDxCL/bnnUNgqLlJHQimI5yUBa/3ChFRm7V?=
 =?us-ascii?Q?nazYLONrLVwQ7g2BV3Oma4aaoImK1ORlv1qz7B/DfQvRvX3nNMCYkcVpQVAr?=
 =?us-ascii?Q?frEJ7tgfDL4eoLEWxL8e/duCbUq8cFk844UtGEvZDRTlc9i4J5YOAgw7BirR?=
 =?us-ascii?Q?7+ptBp3wodZpDwbclOxUDVaNkg0uoni0ltNwtQF9+fux1jeGifgD36pfDiuJ?=
 =?us-ascii?Q?QuYeP08FQBB/EjXyQjJD2A2tRNF4AWUjER3Asg9kj9XTHxNtoZ3m6OMe1F/s?=
 =?us-ascii?Q?PXsGtp6rOMaKwAtPmj6am3KA1d1Z1HYlJOMFnZ35/9FDbJY+oiqiiCZFKuOy?=
 =?us-ascii?Q?1i77am7r2FzH0EbQmwFkXH9yxMQYzmsCq4E3y3SwgVcpzFuLMlOMf8h35O4D?=
 =?us-ascii?Q?jO2JVCatYcHgns8O0ZjTobFcAJuZnJi/PlkX2VHSA+yhxEZvsbdhEVsdi5jn?=
 =?us-ascii?Q?/PVCEJh2l8yzqIp2lEpGI3J1+oPEvrVn7v1MG/f5+akkFCEOvsH2nEa3y7gG?=
 =?us-ascii?Q?fVla9t+RNa6ANFh7TwA+WPSs/C6KY9nHm+VVmVzB2+Wc89tX0AIcvy+jLTTv?=
 =?us-ascii?Q?pNjNuxMsFFOyxN5eP/CHgFqxD1ZnEK6Mwd9ZI8VtCbqmX8YiiTF2qrWwz2lu?=
 =?us-ascii?Q?x1b1QcPrDlXwrgV8M9MiD/BANaEDiVgfJccJMgSwwTabIlM/wsS/+UDYzyi9?=
 =?us-ascii?Q?PLcVfgcrmeVFringGV39YESJ2qJVdmc8pDmFwljz72NxJAWWcTYxwwHuRVt6?=
 =?us-ascii?Q?5A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3522a52e-04d4-4eaf-919b-08dcf4efb3e7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 12:22:33.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sj9goLR6DISRaNpKtdy8XweLDRJ/GokHgrugzj3gDvUsn6C/3FCqa5roQKmkdlACYJqYLD7gwoA0cZ8z5FuSYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB11052

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

