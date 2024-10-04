Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470071D3647
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045350; cv=fail; b=CayUumILztjxw8WRLHG9rn6H7/sWBcgVZb7YlossBNzoqApvEwuEsJk57TX5qyPZ11pO8dlikl32PLV1Zh6o56yFq4UIQJGTsCVyXbjB70p+RdWmtC6T2L5CmKswc5VoEM985hzvLUc/qIfJ7oS+cl5bZscs5/g8xzzjeymBBFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045350; c=relaxed/simple;
	bh=IogroUYM13qKV15iZAHl8EpbiS7ZmuCiWiKxF6TCM8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BQsd9aGzTQimNTjOKlik3k2o2Retz2/GPjUCxEIliG/lk5KsfN1mrpEr35TND0xXNlENIXMPtn7966iighidvWfhTgto4WvMnPIbIy6u/xd835CfBQw2eZRlXUfqflgMH71k0lmmFw+W3w7pDPfIX+NoOGX20i/eIMlN9honJME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MQFQ35oB; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MQFQ35oB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A9jbjUqQUROpg5wraUSSbaOFt2l8ioeI7Ai3ankh9iE/bVKhnu/dkx+C7h+mp4e/KaYVOO+zysXxGMq9w7lbZx2eZWuAn+ejLZppK8jUT42mvb3esil5FwxveQncW6Mc+xSOXszN99sEsj1Vd+IrHrtx0As09xIiyW2jSCxWzffiW59zHSwOggdxOWqOeRo9KnGsFA+3XHytzpnc7xlJgdvAJQNj2k3AhKmBe92IWWyFGwkaYTxB4zh/OkmwdeUf5vG/fr+9E+qMnIljZCVWAjPUXY+4oNv7ZqHZNvIE7AiX/3O0+S2caFHuXXgvdsv+nDOrbDpS+GsDDU8rgAEklA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SR3sEy1WDkj+oVFjgtGoAcQ1aecYjfOjX3lJVMacNho=;
 b=q+n8BdxWa9gu4S7uYskvotOk6fsWB53tWxE5OmjZLIAfv2E7rBblztOILrYcYEg3gBBf/c+Js/UzJU4LsW4A4Jtw8oLZ12o10O+o4xbJd7X/fYOlvmsckKLf2If6ZJsGQ5SFsIIanDbj50MoZpMWnEFSXEFpaNUZ4DWmEh5y+6Mt4rQ+cW/n5ZXcgIZH39Sy002Mq4pDW5HSXsRm86TE1dyLU5W4lVGF3g3pZA+RPLKcsgJmbO3svQTd0AHMn+soNLJtFcGLS1eiTNfqFDFhBtxHyRX3kGr5i1caqUgdghYgHGGatpsUoZxlii5pazCY3UeDakB4Os4K2HuqBfF4ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SR3sEy1WDkj+oVFjgtGoAcQ1aecYjfOjX3lJVMacNho=;
 b=MQFQ35oBSYObztwh86+hQFkq3RCm9TdFcLQCGqEsWIPDZ4UBfUOKokAsuwSqqdkSrJsqUg/8VU1t8vBFi9UEugSvV8HepBKl4yq2/Gzi7pA1JdfBX9Ua8t227UY1lPrp69cqkcrZQcC3F012RQGofGXzTfJeNzaAJHOZKFGCoqhN36cqWhvBHzuTbaY3aw/WU19DPQdXzmj9hV3tWfIWdjMFD53BHM+Vj1l7xvmAhLDNWhhXYgRT9I7F9eN/kWeKvsRXlVNs9sJDbJ/7Yn1wknWLGUsLg3WZMciOHkc7YL/WdtPJhw1zS3xE2NctdMacY3TRg5Plh+LUzaSm1ZSSMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB9963.eurprd04.prod.outlook.com (2603:10a6:10:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:44 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:44 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 3/9] bap: Store sockaddr_iso_bc in bap_bcast_pa_req
Date: Fri,  4 Oct 2024 15:35:17 +0300
Message-Id: <20241004123523.1012743-4-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
References: <20241004123523.1012743-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0056.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::7) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB9PR04MB9963:EE_
X-MS-Office365-Filtering-Correlation-Id: 5914f0b4-5339-4879-4da7-08dce47110c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9KQ/Xad1vndTcYkDWvWiCJP751wo0zqW7t2P6X1y8MyctHGWE/dy5wkXaeX2?=
 =?us-ascii?Q?Izl1S4UUAMBr1EqmhGMbn1yYMZJKT+xaRMTyafmiYg+bo2/BxvmjaT6Tz1L6?=
 =?us-ascii?Q?zfTIik9Gqu4foXRWKhkCs+V30xbzDvtOSzP9x5/aJ77H5QHtFazaCDde5M0I?=
 =?us-ascii?Q?Fm/1C9Ck3R9N2/SNM08MaYKJBVdtwv2n8oMz8opL8tay2MdQlT6hJOV0a9M9?=
 =?us-ascii?Q?ieoHwM2KOQin1Txxq3QW3ooo5ixvtCXtbog5LKCQBHm6GiVuVSs8sV5Ziu0D?=
 =?us-ascii?Q?H3sc+mNMzaiCO0c79c6FF4+46j6rEydebDBx727EjpSPQVp+NATAEBywSYnP?=
 =?us-ascii?Q?m7FHS3FJS9Vwb3se0R2KAup3CCtwlr1/CXmQoTQ8GPGopj+sgjKjjUqQ3O2D?=
 =?us-ascii?Q?YcStkwBLBemI9WZzTlWaaj5p9K3C/Le95nCJu/+0b8j8Oy3F/ltPwJ1q1f6w?=
 =?us-ascii?Q?wV9v/50rX9u0/K/sbAcpTqbnUQTIfQ+hmdC6mODjvo2RaUsI3p4+YZCUrxhd?=
 =?us-ascii?Q?s/+o31szmTTZHi6S5Cy3zKFDUqXTR3mtExSrtSDgVcfguiYKwb73baLF1MuS?=
 =?us-ascii?Q?60f0FJHUaDmHfGhETMF3aCCRo7kPpUh54jRrCAd3yMd01TabeUX9yM/0BQeJ?=
 =?us-ascii?Q?Zj02haLSkRK/CyD5QE1qL3F37/eQN8oLSNyYc6DK0vSyy+szB9tKMSI1oPT/?=
 =?us-ascii?Q?Cousxfs8ACjyh/RLFjUEd0uqEke5X46Dx4KnFDgfuNeoRb6fs9jYPFaDdo+z?=
 =?us-ascii?Q?NpKkDgoMxsNuCxhIdnFcGezbUBeLibpy/hC2QMD4gDGUh5EiJIiiZwB+IKX6?=
 =?us-ascii?Q?z1FFfQYsnE5oOjPB4f8lUEeTKCbHpPUE2EXb5BmcVRNCLiqIBNziSX3mBRPp?=
 =?us-ascii?Q?9tWM5VeYZWnBlbpi7D/Fbt5QjJbv3yc5HUVJzcw9nkZwUisaoQKLyyGK7+9T?=
 =?us-ascii?Q?f391uqoXIVuU9viI4OdMBwCGWn3hKOw3SLW7xYLvbos3zxpRvYndRobksp3Z?=
 =?us-ascii?Q?gxX9WL06sAT9KIflHOkXpxXOryuB42UlZegaHbGLN3gJKtMTXgJaf1A0H0pc?=
 =?us-ascii?Q?2FaEbxBM8Z74u4Jxga9eqPEDt0GT19wkp9lihdM6p93biPjdmN5E3CNhuU4n?=
 =?us-ascii?Q?crM7JEf5IbLH66eD9MQ0ooG1fIRXNfX2YPYTSFr1PCvSShm7A/TvRd81hV9s?=
 =?us-ascii?Q?wUdeRn7WFwv1VrPjO/R9e3tqOBD0UN/MFuHgeHUybUi+ydzm2kQOp8arkQE8?=
 =?us-ascii?Q?XzTAFp2lAp5d7+wwj63wM6wlzhY3Y8FhAujVv2JWwwb1TMXGIfM+oiZgmvMf?=
 =?us-ascii?Q?9gS+C3X9JfB+C91/L9IjF7d7yO7EfVY81wW5nQT+N7Hf+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwuCLe1Vs7++CO9wCI6s1oH782Qbwdq9TBXD3HPAMFEkJdXAOQX/RAoUfXQf?=
 =?us-ascii?Q?vnWH6BMXtPPfLfIzGvZ54dy6Jw/rjtZAQIk/wkigGXDuUOETXbrAAHk4XbkL?=
 =?us-ascii?Q?V3H960jBgH4NnwGi1EVZtmnuaccAaH8fTYjSRCQ9vvURjuG75XPnz1suI0jc?=
 =?us-ascii?Q?d9zC3vVaBC9+/93QgXKzZY6QellT5UB4P3SddYCYeZ8dgvz8MuSEJxG6QqKE?=
 =?us-ascii?Q?6n6L1cGB4u3DdM6jy0+XFR22znmj6yoa7DMURI2yNaCjKLl7SxaUfzyWuoiB?=
 =?us-ascii?Q?KKvvDCe0mE5xiMEdYgFtkgpIUPlH1jAP2d6CYkkTcvvPQN/5sy4iRm0reIRE?=
 =?us-ascii?Q?1B/vtJV7klS3JP9dtbsA3V4VBYpXBcKkeCzdyMELAIhYD8dzZFB27EUMTSnV?=
 =?us-ascii?Q?eQfyvtivGa8o6LhvPSAzgZfcd3Bz5EY0pZu1fGcMU1BJwdAp95CKM+5oNVdW?=
 =?us-ascii?Q?+kPtwNSeyDeDBPWmIBIN9ioiqlK0pbwY50AcBx8sJiY9MmNEGIlmvyPHY0/Z?=
 =?us-ascii?Q?41artykS43qynHdatSEm3IW5hjvsAxjcecZTSV7HEKwWvXm4SzUgcA/lTtuy?=
 =?us-ascii?Q?GFxdk82Mm3HPfa08rN1ymAyF2zBDbDGaQeBofeaRsbEoG4+Td5vCymwCOfl5?=
 =?us-ascii?Q?qKWiQmoMUjWayM5DNSi9IwhKTxH3UtWIh3CYinbYhCc1SjSEvgpOsvLkmQdR?=
 =?us-ascii?Q?pXu0Lm0ZYHLJ9WEaPi0qnCARlMsWT2IlPJNda2GZb1fjBvpoZu08HMQN0oHY?=
 =?us-ascii?Q?FOzDY0zTLoAp6gwQZj+k1wFp3EVzgHaW7RdMoImn4TYi9lyeKILP6R0fY4mV?=
 =?us-ascii?Q?UXiUdx+5rJsCT4eO9K9lu7s8kub8NGkiWIJEzC9DebEvG2UZPyt4f0Oq0jIT?=
 =?us-ascii?Q?B64VmVOM4NyEAT5IjbpVQjPfKXXq33Vp8F8yuJuD/urSt0GD5kwDptA0u9q3?=
 =?us-ascii?Q?K0OrNgPTTGdrtMs2y3dKabMgYTdRmbakJcdohrxEkWuqKsFfTD2T4+hizE3M?=
 =?us-ascii?Q?5DCLqkcru3eJ7WJqH27YGeVhbcjE5+YXMES0LhH8uU/8NWXDDzXSccTYTBfJ?=
 =?us-ascii?Q?hOq2gjbBdpmVswBzqOiFRuoQmGZINqVqCFAKoSjKbla2NbECoWqPyVM7jEu3?=
 =?us-ascii?Q?ezG+YLJC83IRaRL7Ic7lytp4rreWlR0FDYgX0iU0Ds6dIA+gxLYk0OGce4f8?=
 =?us-ascii?Q?I30gbZnlMpS29ARpEG0qEkeBoAxF2OsmIbIkenC4eLLsqCYsi1IpEBodyZDM?=
 =?us-ascii?Q?ylyMV49uu4W2f+2kRmupmlyRjrlqXSiP5yljFVoJcwzAlb0lEaIN/G+mLtdO?=
 =?us-ascii?Q?RCm6pt1TajAxhnNHLcVNlRZpyDf4GZu0W7Izbokmvo3oQIB9fUcHW+hBptgX?=
 =?us-ascii?Q?jop5fqDTb0LjizpgDcSe2KSEubKlu7VgsW4kQ3Bl21epymZ8IgaX2auEPyOf?=
 =?us-ascii?Q?niL0t3lKrrMQdg+7v37a4/mnRpD5kdjWfgrUfAtOcjIjAX/kxNAF8kUlP0qb?=
 =?us-ascii?Q?+CY80lVP1v7EH1/glzIbsRfTtELJbsJNuKzWOnoQEKEs/wQAr4d7n5rraseH?=
 =?us-ascii?Q?tf8QFOh2jm89r/gkdQeRfx46gVeu65bBVJ4otnpN?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5914f0b4-5339-4879-4da7-08dce47110c6
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:44.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NV7vfMiRVM2RsElZISy1HK05DDb7XmEqWVGjTEA8PBf7CtKnvKxWYA4+1vqRlSIOoETuI6Ddh9yd+polweSuJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9963

For each BIS that we need to sync to, a call to setup_accept_io_broadcast
will be made. BISes from the same BIG only one PA request will
actually be allocated. sockaddr_iso_bc needs to be stored in this
request, so that with each call, BISes can be added to it.
---
 profiles/audio/bap.c | 41 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 22 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 94c7b7401..666d3324e 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -136,6 +136,7 @@ struct bap_bcast_pa_req {
 	bool in_progress;
 	struct btd_service *service;
 	struct queue *setups;
+	struct sockaddr_iso_bc iso_bc_addr;
 	unsigned int io_id;	/* io_id for BIG Info watch */
 };
 
@@ -2295,6 +2296,13 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	struct bap_adapter *adapter = data->adapter;
 
 	req->setups = queue_new();
+	req->iso_bc_addr.bc_bdaddr_type =
+			btd_device_get_bdaddr_type(data->device);
+	memcpy(&req->iso_bc_addr.bc_bdaddr,
+			device_get_address(data->device), sizeof(bdaddr_t));
+	req->iso_bc_addr.bc_bis[req->iso_bc_addr.bc_num_bis] =
+			get_bis_from_stream(setup->stream);
+	req->iso_bc_addr.bc_num_bis++;
 	queue_push_tail(req->setups, setup);
 
 	/* Timer could be stopped if all other requests were treated.
@@ -3087,12 +3095,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	struct bap_bcast_pa_req *req = user_data;
 	/* Only the last setup in the queue will hold the listen io */
 	struct bap_setup *setup = queue_peek_tail(req->setups);
-	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
-	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
-	struct bap_data *data = btd_service_get_user_data(btd_service);
-	struct sockaddr_iso_bc iso_bc_addr;
 	struct bt_iso_qos qos;
-	int bis_index = get_bis_from_stream(setup->stream);
+	int i;
 
 	DBG("PA Sync done");
 
@@ -3103,23 +3107,16 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 		g_io_channel_ref(setup->io);
 	}
 
-	/* TODO
-	 * We can only synchronize with a single BIS to a BIG.
-	 * In order to have multiple BISes targeting this BIG we need to have
-	 * all the BISes before doing bt_io_bcast_accept.
-	 * This request comes from a transport "Acquire" call.
-	 * For multiple BISes in the same BIG we need to either wait for all
-	 * transports in the same BIG to be acquired or tell when to do the
-	 * bt_io_bcast_accept by other means
+	/* In order to synchronize to multiple BISes from this BIG their
+	 * index will be stored in the bc_bis field of iso_bc_addr. This
+	 * way,the kernel will receive all the required BISes via the
+	 * bt_io_bcast_accept call and will issue the LE_BIG_Create_Sync
+	 * with all the required BISes.
 	 */
 
-	DBG("Do BIG Sync with BIS %d", bis_index);
-
-	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
-	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
-			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = bis_index;
-	iso_bc_addr.bc_num_bis = 1;
+	DBG("Do BIG Sync with BIS:");
+	for (i = 0; i < req->iso_bc_addr.bc_num_bis; i++)
+		DBG("%d", req->iso_bc_addr.bc_bis[i]);
 
 	/* Refresh qos stored in setup */
 	queue_foreach(req->setups, setup_refresh_qos, NULL);
@@ -3154,8 +3151,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 			iso_bcast_confirm_cb,
 			req, NULL, &err,
 			BT_IO_OPT_ISO_BC_NUM_BIS,
-			iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
-			iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+			req->iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+			req->iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
 		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
 	}
-- 
2.40.1

