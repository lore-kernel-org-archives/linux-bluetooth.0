Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011060.outbound.protection.outlook.com [52.101.65.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2123584E14
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 08:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599251; cv=fail; b=S1V3eZWTf4XxVSEuZ+xeX2QfOrze4KgVvWGMh0qFf3a9M0tfzD513NXqMuoazlbzheiDdGWItDeswQ8M1tPf5TbFa81eoAufkgAycBapQbpalmhCifnhbhFgV4sCMLlatunVmWVRwBU5sQRgEd01/tCK53OznYdBP4FMvoiU+xs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599251; c=relaxed/simple;
	bh=eBtmy9j3dGHeijz7Y8XkaQtZ0cN3gMvL47bhW0MGN9E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ihVXjZOI+goIepA8UWHkDOCph14ubIbsi4DVkVhBi5HKdJSti+oud0s9NBmnEXFZqS33ZlnR2i7VMUSzJiWFj02S6Cxpw4WDcWmI8VvWa2JW+jqNLgKVI2S6P8i/OrrTokFIgdh0HhKh1CbCGjPhnY/pKU9gmgiejDYIl79x32U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RG3N4dN1; arc=fail smtp.client-ip=52.101.65.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RG3N4dN1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eik5XlrzGfjKJoTD3yyYPjgZ+Za1oB2in6njNCS5kqoDlL9k84ppS6r1PezNVDVfhD/YuUo3rN/DPKPOOpb0Ir9uNoqY3F4R9uK2RhAetZmmo3IGPnVmYvuNGQeD5LGGD5qmVlf7zDSr5qZHrIcJbTIEB3QvbiW5/XvdX6aOct7FR1ajj+TRIPfRdS7MsEkG8Y7HeeHOubxqBucIK2qHaC3BTGNz5YAhxEsFtXP5NvGKP3iIffE3GdRKR2qPzxSZ+LjiXtlUlvM6d1gszNxTyuSQUWXPZIksJUYaCS6jcFgkgEbAdFZ1TCgBzVFDz24ej7s7XnxRMbBPZun+TfLyUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89hWNjLddTjxcFqVJAIg1kRWESB2OGZtFWk9D9m3/gM=;
 b=H1jjPv+7xsQ7z0aUSA84NBlgl74AHGr6Iv2dtvD3amfOv1RMQxjFphUwCE1DceM/JiR0YDH/AxckLDSckR1tlGXDtWsR5h2jGe1CoZbujX8Ww0UO9+2QKB6kMgiZ7DWjKBP2lcSAPlfYGVyP+IERompY37G4t9CWDl0q6fPJBQqr6DWNMPJrMfPMer6w76FlIajTNSfqf2sM0iL1pJUTiEXVleTEvzT1w/LP5ITzgt6aeZktaqpbTY7ilTrsfosmAx69JwSnCfALAhf60EZR/ofj/8ujhmeRgw6oM1umiZQbhSSsBC4rjCghSh5UI+6m1YS8qiqcM2/lLjENNA3NHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89hWNjLddTjxcFqVJAIg1kRWESB2OGZtFWk9D9m3/gM=;
 b=RG3N4dN1N9WbrSvkat3Sm+P64WhoZK20KsJntp2b3Gt3wzAzXqCJAH2O0XAMAPXXk4zDudvvPcVbnRVcAOh6GsuZq1SUYUUmYVkHyMx18s3OVDWXXAIHn5wzpQ0WqQcX7np2s/TVnezye3Ybbn9W/r46Q17aEj4vDpGxBb8wkc8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB7817.eurprd04.prod.outlook.com (2603:10a6:10:1ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:14:07 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:14:07 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 3/3] transport: Broadcast sink: wait for user to select transport
Date: Wed, 10 Jul 2024 11:13:38 +0300
Message-Id: <20240710081338.17262-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DBBPR04MB7817:EE_
X-MS-Office365-Filtering-Correlation-Id: 66b8438f-8cfe-4add-c359-08dca0b844e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cFT2xZT5tr0jRA3xb1WqXEIYPqzpRde8sDpsatU0S9Ep77UW3GouhHZo1rcO?=
 =?us-ascii?Q?TSWCSYXV6lvldRETbBOW0En25BwlXM+9r+2qWH/yzE3M/1Jz7oIzTsia1wG8?=
 =?us-ascii?Q?Zw/xJbpK4fqAguupAXreH1NyamkB3SnnqdXmItmtJzWlzYy+EfgaFOeonCGW?=
 =?us-ascii?Q?rOmoJQYwhRnmsJH7mryQ5fDXzIE0GWy4CwkdKChxfACIWAd0ETRtoMm/yCMK?=
 =?us-ascii?Q?lORwuo3pJNimtpLHr2aDvjU8wMGvxB1W44KV7i+4PZy2x/quY39kGOJPVT56?=
 =?us-ascii?Q?53gGwvpq8fG6EoZ/JuNM5StSKQqq12K+gTQGwMjLuIE6W3bRLcSyI1EZv6aW?=
 =?us-ascii?Q?CWfeYYlQbeQGKB8EEWh2cOclkvPfnM0PLpq4Ym02KQNNriDraAFzhH0gsfct?=
 =?us-ascii?Q?XYSohu749fAf1HLPD4VHKA+TXNZhJTFqi7+QsUcZh8oW+AL5nrWiwWhJV/WI?=
 =?us-ascii?Q?DDsK8bGJcPtBTCHdA0L8ovPLfwXxZ1b/vOHQ21VWAO2Rn1lDpRVzNBdNTyGq?=
 =?us-ascii?Q?ma4HKPMsWBT5yniFutxEpPuG+82lMqUw49r4smkjNa2xFZQJ8Udw7W2bItQr?=
 =?us-ascii?Q?UYUb/kGTA0zKPQRgOEn/5rvf4QTjw/q6XHoZJf4pp995+HMcvfdYKLsnLhvd?=
 =?us-ascii?Q?faBTGYWfRHoGX+tuNApbxuSSegYuIEF7g7Bp8tGXY1pb4sXxBZJThVtQ038V?=
 =?us-ascii?Q?g6bjpAH40oG7+LpI37DDXYDgKsjy5fa3L0GINmafT+zOl+RKFqgab8Pki/f9?=
 =?us-ascii?Q?aZIHcelDP/WLGcpJphFnmIAGX1TKY3iTMac5r8LQTEONFPJzuChFMcKX3lHf?=
 =?us-ascii?Q?GTFd1Lq0pfF75Kj43kdJtekktDvUMmXH/maCyd0Ef2s1C5SV06fBS4b5iDgJ?=
 =?us-ascii?Q?lD6bROq4nbGa4oH5tGc/icyBZCe/N3cuiEikFfkg+dhZK+64L5pBsum0EOqo?=
 =?us-ascii?Q?E+f8pGWiYbXIjlJ9M0TvSF//wLKf5JzwemymkKOquJmPvFV5mbnpPfdus3IF?=
 =?us-ascii?Q?C8sZ/2yAfttpjIAGq/toVJBxTUZHpzRWOEKgSHXSJZzG0y4+YPDQOx2M5AVr?=
 =?us-ascii?Q?2Wki4hrN3WekAN9d0J7XqUhbRhe7c1kAL68F4P/s9ZMKquqc2Ju2bSuP7BiJ?=
 =?us-ascii?Q?vBJGyz5h2plJRVphLQZyCFxYkvQux0N+lDlhVx+43v/+jxJnbyZszk0q2wed?=
 =?us-ascii?Q?Kxw0GC+UD8AyhAX978gApf0eaxbMCEgK7p3vwhfGG4Knfk/E86sqM8fBE+5o?=
 =?us-ascii?Q?eO/U5CvZagCYLAZkEo97TWgnlCUGHjR7vO78/wpaSUbm2f8q8RLOsKp7siJE?=
 =?us-ascii?Q?prNN5vCV2aDm/EmgkysrzOwGIeL/LYyCtSSnns9y4GxzYDK0/Rmj69g7zLd0?=
 =?us-ascii?Q?UiZrTzgLyndT4YbicsB7lfKqOzjSETDfUzU3BzydKA73otAoTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50BbuNxshQ/f+64ULoorb8zBoMlzafRYmsuVU0CCs/6vQGhkUxlNvFQkeiGi?=
 =?us-ascii?Q?Hia+3w58ZEVjv/idgT53AOvPo9l9IpAKqo5pR6OZte/gUZszsRBArOWxFdo7?=
 =?us-ascii?Q?imDdM5zwcU6EEbxSmOZDIiP9EQ5/zoDXYTOQeIcNBKI/Z7JJUpHefGPVkT0l?=
 =?us-ascii?Q?QKBV/DZAwx52oWKxHLHUgD6NH5KzMMxxuEyI471q/F7QcrMT9KR++reTwPuX?=
 =?us-ascii?Q?AVJFVfMKiFDktjqIa0qtrVo/6w5VNZgl2xT9DqlmV9Z5o8ixU0faeEcPEMUZ?=
 =?us-ascii?Q?Ta3GoUlOV3haTS9BCe3Vlcb7//bUW/nZeYmBx5TEnr4tIqJdYicmvoi3zVNR?=
 =?us-ascii?Q?3aKbV5H94CDFtmybNJ+3wxlhRzCI/YsZg6yeX3c4iRVZvu9tKuIshrRrAHh2?=
 =?us-ascii?Q?IOhPCtUvw50Th2bSZ8imGGMUAUF/07tlkvsVgG4PkZTt1crrsSJ5+OuANl01?=
 =?us-ascii?Q?om7rDRnMUAbi05jRIHsi/pzSomTFxsM0v6JhDZxTj4+Roc3Q4J34Cpc9LhQU?=
 =?us-ascii?Q?1v0icIq1C5llbw3RSmSjx2QUKP9D9bFI6PIUtSnKRG+4t3D62Clz30Sf29Fy?=
 =?us-ascii?Q?V/UjsLAAmtx1lp9U9mmpw5CEopvFq4T8lPSVmwoQb87OlZ2GURvvxUJTu8j7?=
 =?us-ascii?Q?NyD82dfbOH0NWKSBxduST0AzOj9PiimMGCUz14bjtSLBAEw72jPNM8/Veec5?=
 =?us-ascii?Q?Cxwx1BPN0jTKWDc1/a/4mR8KNny43cnB4AQU/9r79hJ8tl6dMjENQ6gXW78d?=
 =?us-ascii?Q?uoAVsmh/zrBy6OsrSPiWcNifYnWHpCKchJWjtZvVZRHUPc1rRD0lPs5h4PA1?=
 =?us-ascii?Q?BaMMYrQfuiI4ATjf8kzsC2nEK6JrTF0g/uXEIROAe/jzYozp682tO+LF3D5q?=
 =?us-ascii?Q?KVSvyd5s5YP2b/Vqx8GxUnJyyYzKkjG0dnV8BFHov+ASclr+s40OAjKCq1aW?=
 =?us-ascii?Q?DhWDHnnJW6sI12J61Bb9chxuIuagXgfyQ58xTAkFEQw2pnl2/Go0LopgUmqS?=
 =?us-ascii?Q?k6SF4UGVEC9vGfcUVPsMJfbYR1Iopaq40vJ9IJ+I4BhX+XkiEQbLOmC5AIx6?=
 =?us-ascii?Q?xohjSka0fwOF8qF5obQLFCOh1p00nCAbJADbqfZVL4ynOzKDdoxjfFQbgTxx?=
 =?us-ascii?Q?3g4btp7lblzGIOH937LEgX+Annf5wdFmY856RRZI20lDH4n0IOK5sneTlzBN?=
 =?us-ascii?Q?dnhznap4dlDlsNVblV+T97C1zbHtPFaL72XLteuyeLM5T4Ic79ct238ZTu7F?=
 =?us-ascii?Q?N9+3NeRKj6lJbEXqqkEyeXcU2qLoyrjJn+NRAETFnuOjK4rVC8zkS2ECCmXb?=
 =?us-ascii?Q?38SYwrWdpvaCEmhDnPDhT5sUsFulPTGgRLxXscZGaXk7Ulz3fpldVu74Al/T?=
 =?us-ascii?Q?st0/FnfqH9gmDMlnQCbE02/aWXSiiymO7agcBTgSiKkAlzyvcnx11kLwW1cr?=
 =?us-ascii?Q?m/kU7e4EgkCBrrslrxJVVMpthuv3MJxZGhHZmrR9D+0zlsAtcXkDukq9vd7i?=
 =?us-ascii?Q?77EzM7eyqm1UHr7Kvhsue228kal2rCSy6B5oRj/7ini7N3co/UuE8aZY6Knh?=
 =?us-ascii?Q?mfibG2Ihe4hSfh79tBNU1efLAuyhdsHNYyI51iIH?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b8438f-8cfe-4add-c359-08dca0b844e0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:14:07.1774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e+zQCa154bPwuzYizVJitwArCcvvmow5c/YIgWX+33U9ziIupmJHDCu2FswXRZr9uToU0gbJkVyjfnvYoEyYuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7817

This changes the flow for transports created on broadcast sink side.
Transports are not automatically changed to pending anymore, instead
the user must first run transport.select on them. This allows for the
selection of the desired stream when running the setup with PipeWire,
which acquires any transport that is pending.
---
 profiles/audio/transport.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index d6493edd0..5ad1499b9 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1676,10 +1676,7 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 			bap_update_qos(transport);
 		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
 			bap_update_bcast_qos(transport);
-		if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
-			transport_update_playing(transport, TRUE);
-		else
-			transport_update_playing(transport, FALSE);
+		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
 		return;
-- 
2.40.1

