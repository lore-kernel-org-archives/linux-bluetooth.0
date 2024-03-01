Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2077.outbound.protection.outlook.com [40.107.7.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCA5C2C2
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Mar 2024 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709311196; cv=fail; b=roc8YebtWJxu2l3kutSUUQrCPKKBL5KrLIa2PTu3l5eu0wm4BDRvJyX8Q/fUF4rf99HNv37BXThHYnpM4LmOdkDQEEG8fuJtEmXVk7HI1IEaFaTClrxwjFcbZ1CByrTPFpO3Mr+/GACRbNlJCioEKAOmc3MBAgk4sSBOu0BxsbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709311196; c=relaxed/simple;
	bh=rs9eUwBej0+k+juZa6HZTQ6+FvNGrosoq97tZe1ePM0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JScaImdtah+O5e4aNO3r2b2u0PnitDuxCi3ujHvYES2hmsgsVnI5sgqwpeJqpFKuxLQVEzDoDh5/8iCgF6CVESbExEuvGiVG4xlb2Pec7FzZdWVrDIHrVtTD/8mTgkDlzkwCwRikqftFzPUeUw16DMwJuOkasO6zaPT43/vt/pM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=VEXObhWI; arc=fail smtp.client-ip=40.107.7.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="VEXObhWI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=areRxX/1mwyoG0jVxz8jumGiKY+kLU7ibu50HkTF8RJz9et2WXohES93C+XlKOaEUJ93Ntz8kdy/KYsefqpuPWr43StiWtLDWzWn7uUPzwynP5OTmra2ext0dAvnQD2hdSkaQ7/0HEdBw2nBRRMHcsriXuSrkuA2PO6P3frI9lThpA5l5L77OHReOltEsoyDH3+pb2wjswo7KHljjvw91aLQKWLvJIY/2rBjtUwQvBbkevmbrb57wAg5niRtls6DTkrGIRxC2Wv/8zmmIu7S2XSA3YATaqlfgLTGKvtWbKWvpeR91GBqV5v5YV/O4ZRz/wnDo2wzMn4JS0NVq2YyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbLu1Ed+fZB/FYjJlUIwKbmqXZ40cKvSU5XAKiPmo9U=;
 b=e8Y4O9DQ9fIPhii6wnJvKUbQLGeKeI7Qk9qPd4yoLEtNYHI/lfsIUfNrE6Wmla47O5ngBd/uYqCVj3lHnTmpplw+e4T+roqxYZ5VBrNe7t4WV7GftzSa5g+F4igPYNp5Gf12HAfodDyJXvmsDfx91JzWH9rYAVxM5GVCZ6R2ryWyvCJDf0p7paZLc3Q0D/felAKG+Oz9IHVx9CCwxMKRs93fDRE0IYQ9JW2TZXyEnIl+HAHG/ngxUKaoL88c9zMxTinieAY7kmz2CyQmMT+9k33YiO34E9UACeYRiPPYJABqYmB0msXwXHT3ORpOxM9ifqhIze5Rb0w498CEdPnKMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbLu1Ed+fZB/FYjJlUIwKbmqXZ40cKvSU5XAKiPmo9U=;
 b=VEXObhWIKTVpsx9HdQwmSQrQMph5aUum3FXkgFSCaXeeU9N58ci+D0cvGvqlLSefJ+RYPX2786tmFImr6gRTrGmyU1yoplS3NCQxaYi91b6ZOEJxZyM1Qohyr1kTuzRBdxHykbOc67eP09uEouWcDVAN6mgW3cns+nk6qdALABQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by DB8PR04MB7179.eurprd04.prod.outlook.com (2603:10a6:10:124::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Fri, 1 Mar
 2024 16:39:51 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%4]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 16:39:51 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 1/1] Add command to create local endpoint in bluetoothctl
Date: Fri,  1 Mar 2024 18:39:46 +0200
Message-Id: <20240301163946.5484-2-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240301163946.5484-1-silviu.barbulescu@nxp.com>
References: <20240301163946.5484-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0312.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::19) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|DB8PR04MB7179:EE_
X-MS-Office365-Filtering-Correlation-Id: 071dfc7b-0b6f-469b-4070-08dc3a0e379b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ddHxw4MnjpXd4sm0CT0mtH2T5WhXYTTcTYblI9CMAKVP2h8zNh5YXJxa4SZYLQx1mVVzuCBEw/a0WuyMpBmzdD3egZB2yhregfYo35A8KZTwUgtBw92JfX2ZV+VxbssoW5/vVNn/e+gbylPz4Wn1JWifvX12Xal0TEIOD6bO28PbUA06QPOXv4Aswd3tVovzAE2FFKFKHrv34vAPkHL954nl8DVmE/8IFcnWdf7FzV9hUntfPR6uD9C8+xPbl/cHov6FD2fb6ZWNqSIgGmNEk1aASFs/lltEi5rDLrCrHxSa2Jz/xJGjr+CkpPx+OBlMPGl2lxwx+aN1gl+LWQMh4PZKnj79E2C8kKsR5pOYwi0DqZRFjrzbiyHjHtf9I7n4ySkl5H9uM5fXeUsZUkILWSv9zaMVFC5/buGcaUzZ4l9ZVzEcul0DVfi/9vaf5ixGBIT2Bzp56ydEEK3BH7i9XCDJOBfbkQHvfQS0EMFrSuUymce0qd6tB94L5/9Fg6X7K0O0D3ifRsA8ReY9OvHROC01k3SuzOlCNXcBOTZrY2NV5BWRWbVV/qTDpkoKffVc2WtgmVXYIWKDXPEVtUyJX0ZhbDp4Rp7PT7/wfqi055POsLpdQgbwxdgLoMqvvSVLVGldCZnNfZ4fbn+L1FR5nw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k5QJkzeTXFWvqzXFQT4F4Ko6nEL+BdNXDxII61br6CsWnasd8Dh2S4liBSGF?=
 =?us-ascii?Q?X34Lbi7kudjPVdrS8tQuetVnh44TfB8Ne4EkEiALgT/hGUyEMFFSPo7KdhdK?=
 =?us-ascii?Q?ApGgFWyTBweOmZgtZKCGkxilFRaMcnJyNrR9YbN60dN21F8QCMb0QQH3i0z5?=
 =?us-ascii?Q?PEYgaj/4nmKVneBANmLAknMLld7mHLdwxbn5nHY1TlLHrzSgU7q5k1b++8lb?=
 =?us-ascii?Q?w6DsVDa9AQLvB5yFT1gItYBmMIdpkwhYQyLvTXS/60QFDXyK9v9wAGTVkrgs?=
 =?us-ascii?Q?x29bz9X24ihfrnhQepRSNRXJE2hIRT58YDxwzepi+v26KJ2AFEMOSdwTg9ba?=
 =?us-ascii?Q?U99i3AejaVuopFTUTZ04rBJmOLJ48cDeCjQo54QeQrsSaaaWCfB+yZvJr2Fh?=
 =?us-ascii?Q?HrVxXkDtNfD1I4IfSPWV/P2Z+R0IQ5a0GZ5ojf3Y3GEqiP7Pwg0KnKjDzQwg?=
 =?us-ascii?Q?zuUxlNJxzRjyIbGNWLC0E1ghwnG/GlOoNNePsNzOjpX3oaA68PJDObybcCaq?=
 =?us-ascii?Q?V50y8x/grdvGfhcw+Y/6L5PKhxBrSeFAKfNgUqXCRN5dgLWtfT9859qEGk+5?=
 =?us-ascii?Q?IHyr8mG9jgwVrNDvArhza9fuvh5fgMWaa0C6F9e+812/xBnayaxcj+Cudf5R?=
 =?us-ascii?Q?oYOJ88AoVPn9IRHHI+QPi6BbqjAaG94QSQhr1N+nTUe+3Bfkd1Joj7pVxuv0?=
 =?us-ascii?Q?YNoyt1FHBl97Rh7KvSQ+As6zWDOlb0z5c/LAAFPUQcNrHHZKQ+WFqN5egQJe?=
 =?us-ascii?Q?fGeuXFGF3vWe50tOJtygI5xoL9yAeCO0OcxSrG1hBDImE4cYhmObGAzj8Mvz?=
 =?us-ascii?Q?XM2s38uhs2+/N7hxwu9Z+g/XQ3QbTOwj1ZjK6TCIHlGLStzfU1g4DADAwy8G?=
 =?us-ascii?Q?pgJKo2GcBzHXUcBC/joP4hpGWL9Wx/DdPn0NeHTJ8umAQxV3Fm2ivNSd2alp?=
 =?us-ascii?Q?IwxRkNQob5XekJG5DQcsw5Hm5ApcM5mc0m/ZjyCqwbfnnrr9NfrlH9DNXAGE?=
 =?us-ascii?Q?4avSf3eNVvLIq58n5vyNoln2tim/Uq2r3QXz0k937OcDcXF1yi8vdqYnsDUp?=
 =?us-ascii?Q?fTCKsKOqWwv/KHD/QFFGbz4TW4gq5DZtyFmq5kEnEWxp5K7WpxLUauVARdVR?=
 =?us-ascii?Q?7eFtqbkyod+K5K/fd1iRSZQt17kPYxzRNLIJmHmfNDo5m3vgnycOEP0ddGX4?=
 =?us-ascii?Q?3sIWLPple9XGl3R7Nk/WcKD+e2drXaS15N09fHi0vIwtHES2jpk/x/y1zYyt?=
 =?us-ascii?Q?rZWgUMzj4HD/EcLqQHtleM7xNpDqoY+qpq7r7XybisdTSEA/mavdbSkj0ev4?=
 =?us-ascii?Q?NndRdUY76UDaMj3/NBRAlTAczSOqgl+K3t9W6fnpcTylQg6vycF/gTRwT3jC?=
 =?us-ascii?Q?/GYTnm29oK1fIfoij0+ZS4oQXGvA60KSAeC/CQt9oqvdesI9XhTGmo8UjJ+U?=
 =?us-ascii?Q?pSszPp105YFumOGo9RtgI6m1O7Ia5FdCIpCKD6YtBrhOtqtC1MCLDgJLbZpN?=
 =?us-ascii?Q?DFjdGYcwe33XSV1gcPyO3G2vwkwz77oh25sGiPDEIHQG9X5agacT1AHUvQN3?=
 =?us-ascii?Q?E08DUWdn+XsroB4hfvwwElyGcDPgxTDvAC98nhuFlSs61I22gErLTQ3aNG+v?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 071dfc7b-0b6f-469b-4070-08dc3a0e379b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 16:39:51.7845
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDw9McSn8adKn1zRUec0KGIijWUZWsgU92qejA8H9kA1yYSxV1EuYpoDJPah93qPXYePk4N8JtMFu4f9OokfeH60kj+P/l+ja4eVELFatLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7179

Example:
endpoint.new_local_ep 00001852-0000-1000-8000-00805f9b34fb 0x06
Endpoint /local/endpoint/bcaa/lc3 registered

---
 client/player.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/client/player.c b/client/player.c
index a40bf66e3..e297bb615 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4263,6 +4263,8 @@ done:
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
+static void cmd_new_local_endpoint(int argc, char *argv[]);
+
 static const struct bt_shell_menu endpoint_menu = {
 	.name = "endpoint",
 	.desc = "Media Endpoint Submenu",
@@ -4287,6 +4289,10 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_presets_endpoint,
 						"List available presets",
 						uuid_generator },
+	{ "new_local_ep",  "<UUID> <codec[:company]>",
+						cmd_new_local_endpoint,
+						"Create local endpoint",
+						uuid_generator },
 	{} },
 };
 
@@ -4372,6 +4378,27 @@ static void register_endpoints(GDBusProxy *proxy)
 	}
 }
 
+static void cmd_new_local_endpoint(int argc, char *argv[])
+{
+	struct endpoint *ep = NULL;
+	size_t i;
+	char *uuid = g_strdup(argv[1]);
+
+	for (i = 0; i < ARRAY_SIZE(caps); i++) {
+		const struct capabilities *cap = &caps[i];
+
+		if (strcasecmp(cap->uuid, uuid))
+			continue;
+
+		ep = endpoint_new(cap);
+		endpoint_init_defaults(ep);
+		break;
+	}
+
+	if (ep)
+		bt_shell_printf("Endpoint %s registered\n", ep->path);
+}
+
 static void media_added(GDBusProxy *proxy)
 {
 	medias = g_list_append(medias, proxy);
-- 
2.39.2

