Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D33D713B5A1
	for <linux-bluetooth@vger.kernel.org>; Fri, 19 Apr 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550089; cv=fail; b=b8G7Eh7VW3i9+WGTMxC1O0Y5D/SCMA6RyJxlAaLbBRlgKPSpmBDsULalG6LOOA0xIrMWOfq65gmvwi5dJh+FEpnH59I+ZvViyQH0pB3EKJM7RTrUiCb3txh5IC06VYts+LKK8WXbgQfS5BwjtzWSGb8MgLGixQ3ip5p4zlt2Hzc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550089; c=relaxed/simple;
	bh=jkbwJi2SQc17Rw1eLoH2X08k9wXWrLtYgXmVtB7UnHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D67MT1fh47/fV+eQoPeBe572YXRKMap9Tkle2v3wJjr/4DfTFXxeODd6PCFCz8fronDIzvwC9jRdoV/MevtJGomEwFYMYqaEc3VHTIK24FoweMJH25zaLNjvASkklYVzbQrq8IFEQr1hFaERuez9gciJ4RiDTjbfhyq74IdsGBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DpHJH63V; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DpHJH63V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoYsb55ZlzpqEXO92ORqwyVyG+BP2ZhL2FdGSzMy/TZiRfSz9UIQc/9V4Rpv1iPtNWc6K/Z7cXBZd6X5XegSMWr4RbbBGJZGKQxfXK7oLE446IZNZlOeU6P5bfQNEDUQjOtIB+eqY6h2uTQaI6xzZ/HAdaTIc0kv0tsEGA8WzTfKI2ud+E/lbqXtpcYPH0hJrbHqviXyu1+9QAxS/giIBN2D038SJRAz1p4CNoX6vqkcwUnOTBzR4UxIPSRDQj67wa483VARbUjB5D10FKPC4VVhYohOWGWxKf1vx6HxqWnKsIeFCjTS74npR+hqNYW+v/2wJsVfZAOaVIOY4KOxlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n9dRVVUaxw0rUVqyqZIPgVHskNDy5ki8Bj4YJ0bSl3g=;
 b=UNm77vgGPg0vpukQJi51nFMqf25s4p7TfAifNpzMmRULN2FQhfN+bxVX0T9ooN/rhD/dw5yoxSmJHJ44QRJLx3lLI1DxPt96zF5kYVSaXTqwXRJ0SwTJtMveoNgjRYwFNEi+Acwa5TJMom1kqb7+ZUPP2HyskcToS+k5wVBT/cFIZZ03WybWqVQ0GazcEcZ/VrJ62Pi5rjL/3MQ6jbhDh0uPNwfBzKWSHvM7ICtnPnct/G9S4jF6Xhic8+XoqHYJhSlYsX2oYQ4ormpOt06EwZzSqbDRtw3yxJ0W2AuzTyG9gqotQb12l31GnMYBJe61rYeEgUl4x/Ew0Rlh7hUk6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n9dRVVUaxw0rUVqyqZIPgVHskNDy5ki8Bj4YJ0bSl3g=;
 b=DpHJH63VCOfLotgInxway2p0/8YItqjCgVrEsWcMsBaryXz9I7Q5ewjePV6ZtKeszT5TqoVAAomgOomnPyDqtLreLbr5niZspnuEwAK4hI0FC2RAdaZtmSUWSzNBrvx8ewYMjP2ObCJPUkY5AC94J3cbya/x9aQgBEXv7/8YJrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DBAPR04MB7381.eurprd04.prod.outlook.com (2603:10a6:10:1a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 18:08:03 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::fa84:407b:3889:82a2%5]) with mapi id 15.20.7472.042; Fri, 19 Apr 2024
 18:08:03 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 2/5] shared/bap: Get broadcast channel location from stream capabilities
Date: Fri, 19 Apr 2024 21:07:49 +0300
Message-Id: <20240419180752.96699-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
References: <20240419180752.96699-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0302CA0019.eurprd03.prod.outlook.com
 (2603:10a6:205:2::32) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DBAPR04MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa0f8ca-5128-446d-c713-08dc609ba7af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QDA36O5RdJO+g9H/8l9i/UwlkRIZGJyZ8kTNFWWNd+mHSxhjBlOk35AkabxZl03KEwPfsQ822yqNvtcIWu9O+aBWmN3hcVVL8V9R7H4UbWo3aXiuuelq9wUXk6UmCrDWvbz23op3ZVmilxMaz0QNzknS1Ixc/K4svxlgPXsSNVHjG0Jcx33Ps2NjOyh0gMpr6NqMXGWF2/KFZxOwLI5QCQoTyu2tNVG6tH64erd18cjFmhmeGP5s4c6uajzydw+MgKuvCDLlbQp07S4Jgg/dXYYUSpHmEIpOCLbqf8pYJa+rIUDnL0HRs1vYecBekTcEXsJlDSrG4f039uVJwYFDXQzP+R/ctDylVYNUsL6MyX9ToqJkADCKHumjwVwTJqiYUG3DMY88HKsleJly2A9+4JIdsDAjvbKDbcWgtvmLL1d/oKH5GMvYYL65xy4jJ9WfNPkzlrq555oio+CZUA05yjEwjScTYhWcOk/SQpmbBBTLq+PWKRGTPw96AzzxX+ApWDDryNkvYaGvSt6tyWoYr2xzDeKSu8YZ40YDajgOdro6BQNu+4ysDdBXH25AzmAPpvGPGj1KG/ojBQNUn2ED7Y4BS0IkvFUQNXa4lJKZG//Mq0beVBVkzUt+sOYDLpEtuXDyWZ2c/oR4/7WINv1ylCW/hBix9xyqtUwhXczKoeg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8z2IOJkrVTfs7vsmokUOObkM5FPLsNCCw5jnwsHmKC3IGe9ClfjHfLvjN33U?=
 =?us-ascii?Q?sKFReCIEXSF2IOQawaPGEoxL2AGqNfEVYyXROnwlckd2hL9Qmb8WsOqd4MkI?=
 =?us-ascii?Q?8+r5Akh2aUWz3d/2BUI/TNuYc/vMdeX37jCuwXzMKHPKu91h7E0KVLbrFYzr?=
 =?us-ascii?Q?acu1oy0/91Otmq9WM249LlJgXY//r9NCFHswAM4RcSqkcWCLqiNaoTcNVOeG?=
 =?us-ascii?Q?WAI63eUgdhnrq8xBZXGFBoi+sT2LckZKoBT86GYhMrBd0UPow++4BRa6L84K?=
 =?us-ascii?Q?LLwGg2ILWZpO1d7Qq7cRaLCpo3ufiyeskAbNsfEWFNhraI/dA8E+qPd0YfPi?=
 =?us-ascii?Q?erCkgmTLw5WgzmWAfmItddqhOkntQFLGOQ8ubgtu/ZYPP4QQXEZ8+E8mFuTc?=
 =?us-ascii?Q?3qZbpsu6VsiD9CUYHtQJMOIDXRkFdYjJ+h5IW5QVyO3og6pXpJeG2TL8oKjb?=
 =?us-ascii?Q?YJH2TUtZDWTgaGETrokeFucJrgFQjOI4PbVjvDNmDfx8M1Tvsj83re3qVO1l?=
 =?us-ascii?Q?NokSNOsCotqhKcbBhbLbdjvXPkDSX3cvN34h0VsJ3NYgpD7Z7KecsZyC3S3s?=
 =?us-ascii?Q?MTQdOXJLf+fR/MRX47fuW3dxKB5Z6PQ+KHzLHWVYf2mOiAo3ibQbCyCYyzgT?=
 =?us-ascii?Q?NQF+r6nHY+NuEAudr1Z1ajYXHX4bf/NNj4f6u0ehqDbctqsnmF5GWdq/ZD/n?=
 =?us-ascii?Q?1apn3NyMsTf31KFwOL2h79Tdy21ST0fAt1N2TOC1ajFwfqJvm5K8ESm/q5RR?=
 =?us-ascii?Q?E0t3SYlIYgca4c7uXfAGTmsbTMl74PxfsbTEKdmsTg7BR11SbdY4v4OFvWuu?=
 =?us-ascii?Q?FJ+XtUx+13+jjHu5R8yDph6gNOtNCFW+TvSzrkLc79vYHpaPQa4HX57SWuR9?=
 =?us-ascii?Q?kqu/V9P2dhcZA69AsfvoACqP7Ir+jj2/3oT1AyOUIC6diuaNjkElgX85PG+4?=
 =?us-ascii?Q?dhj9peLqFyV1isKG3Jv41ZymvGMafvgNHYHbOZC/LtOp9hIFTYJ+gfFA+0+z?=
 =?us-ascii?Q?47mQbM3hXvfutTA7xa2y4A89Bmqdb+VZ0PL2bQJVige1vWDWnquecppBFjXr?=
 =?us-ascii?Q?n9qjknzzxt1VLAWF2+Ln/dZjXHC8fCjYDStkFxxqOv+Gl9hXqbQyvbN1qyJ/?=
 =?us-ascii?Q?o6t35DiRd5oeGcfoSyX2ty6u04SXdOXMuH0Geo2fASJm1sS353fhXXyQr8sH?=
 =?us-ascii?Q?a8gWGpRAplILwY6vklVrC6k8a4bTBC7/flv/FqdKfOoKCICcAvXp+ZyPYbZk?=
 =?us-ascii?Q?zxk7zdM4XMkSEzBC350gc3sool4m3gogVbxBVqYswYE+73YuNFcGxk/9zo2R?=
 =?us-ascii?Q?oGgKa6tjbgs/YRN+qUb21OfXOXXPqlEE8l3keifs2EKAtaIhQPICk+VbdIek?=
 =?us-ascii?Q?iM6XOebbrXzDhtuWl0mu16brpKvVbe7+dhCZ4jPiS/tCtbCuU3Wy7FvPU3Up?=
 =?us-ascii?Q?gqAQ4vBkBM7mWhoEMKhTxX/q9fo+xNm0o01KxaSMsu6pd+jM2k4claXraCYC?=
 =?us-ascii?Q?mwRycgI7RqCP3y1tKKP52DyKuFkbGs7mzZOaB/Ygm0CbuCBZkIXzfazD9U67?=
 =?us-ascii?Q?+XR2WfzPPPMveX5xPvqiNWFZW7NPgbQON4XjrBL3ruefM7QOFnviCqnGGwya?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa0f8ca-5128-446d-c713-08dc609ba7af
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 18:08:03.0482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OoLPd8xUJ3bM5twWhxKIrxzU334oxHXMI4i07qGmW8HugTl1dveBYSg1bUC86k4MPM1KVUsYbvsXpbo+ubrqw/ie/mbTAo8q5gUIN9BR7IU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7381

Get the channel location from the stream's configured capabilities,
rather than from the local PACS database capabilities.
---
 src/shared/bap.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 6328ff35f3c3..36f0b0a3b50a 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -5628,9 +5628,24 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
 		return BT_BAP_BCAST_SINK;
 }
 
+static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
+		uint8_t *v, void *user_data)
+{
+	uint32_t location32;
+
+	if (!v)
+		return;
+
+	memcpy(&location32, v, l);
+	*((uint32_t *)user_data) = le32_to_cpu(location32);
+}
+
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 {
 	struct bt_pacs *pacs;
+	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+	uint32_t allocation = 0;
+	struct iovec *caps;
 
 	if (!stream)
 		return 0x00000000;
@@ -5644,10 +5659,13 @@ uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 			return pacs->sink_loc_value;
 	}
 
-	/* TO DO get the location values from metadata
-	 * for brodcast source and sink
-	 */
-	return stream->bap->ldb->pacs->source_loc_value;
+	caps = bt_bap_stream_get_config(stream);
+
+	/* Get stream allocation from capabilities */
+	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
+			bap_sink_get_allocation, &allocation);
+
+	return allocation;
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
@@ -6322,18 +6340,6 @@ struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream)
 	return base_iov;
 }
 
-static void bap_sink_get_allocation(size_t i, uint8_t l, uint8_t t,
-		uint8_t *v, void *user_data)
-{
-	uint32_t location32;
-
-	if (!v)
-		return;
-
-	memcpy(&location32, v, l);
-	*((uint32_t *)user_data) = le32_to_cpu(location32);
-}
-
 /*
  * This function compares PAC Codec Specific Capabilities, with the Codec
  * Specific Configuration LTVs received in the BASE of the BAP Source. The
-- 
2.40.1

