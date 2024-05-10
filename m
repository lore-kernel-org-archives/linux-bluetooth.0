Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2044.outbound.protection.outlook.com [40.107.105.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E6612C467
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 13:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715348124; cv=fail; b=OXmidTxpxmc/dE3pXp2ZKtf2ChG6weVBYLhycBAeyGjtGQhMOqdlPttAvlsarbEgBSxawwxjQ0R7pgDWGbmec/51aNbE5mPykR9QvMEzLc7Vb0KcX3bjIJoWi1WRcF081ZWrsfruqIHleZAFVes+GwsNOKyNx1KB6J1KVs3Y724=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715348124; c=relaxed/simple;
	bh=QAu08GzU7GPNLO9VNNVx45LuAE7hqqmGoxytz4WILOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pAnjjxqv0mwHkBD7MXMmYbjoXN+ZHxWwF+Vpl69UPSdoUslhQ06V/w2FXff/oIi8Qwm4knroc3BsamlzkaQq3orR956Q8s0DBSmnEVH5mDKV9arNn9xKmm6WtOboXsYCRSHKk0Gckwl7PHpvyTZCeEP6NhRADi4/aEJplXeQvt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H+QanduJ; arc=fail smtp.client-ip=40.107.105.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H+QanduJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRTthDvyoUQWnbNChs6AYvKExaTegsm2c0nR6BB8WZiMe4cUox/1ilUhqy1eSa8L86hBpwi0PRiHXF0fOv37+U9YjFvMj+QnseZW7dD7bpaYxPCJRdGR/J9EIZcGcbqKDe2CTeaMC+sZ3C5MyiOrvxzTb3nh95ZFBgOi3bzjqOhtMPNSyLThLXZUD9+KVzlGEvP2EEbVbmcINJH1S8gWnavlQA2lGp4+taJV3DEIdA0EyXBT5XINFQqOHjWBt2fzKz8YYFQHf5scKsbAmJjE80VS1JDwZNjxysYwT3TD8YF2F1Uz7/8FqxMCtj9xhA37vHBNOWw2pQvQHrh+JJa3qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+f2TTeXHftxO0nVpOTCYwNHRZssxZ32vz+tW3xdOvgE=;
 b=HBOS1GYom5egfGQVbYzUZNC//PKuVSFQzcV9Pqx92fMoTvzc7RMBQYiwVHe77f7OVIRbYAHRc4AwL41shW87SpST/rv6Fe2gKitSTNWGr4geNDV7V0YN87tA4ovXEXkIv9t1fiQPR1BGCYuNzjGIH8lt3yZkUlB6k76UTFd9vr8D8p7HrR8nm+CmUjUEXyecOqlhyvl8UYowu7dTHjqqHNQ3WnRIljNU2VWNPb3uqxTBbVp1yp/2iRVecmIz7gsNUBAtAE7Z4FdIX8f2JuZTYsD8yoNucXtw1GEQ8C2xK/xU9jY3yHchsjmIDiVKlEpgVtJiv1pdi+++c5h8IyOb8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+f2TTeXHftxO0nVpOTCYwNHRZssxZ32vz+tW3xdOvgE=;
 b=H+QanduJGYg9t16GQz4JETYsvPt8kKzSFfuSBEPXGJMWqrtcLbM9+rY9braQkUJGGH9LCsm0igmbnZrBtYHzlUa79DXdI12fv1Le5Z3kVZcDJeBTHrEmmY6MqmfwcVeDouohuuL7XFIN4DO18ymnBzfoxiOARNDIUyD72XetuXQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by AS8PR04MB9192.eurprd04.prod.outlook.com (2603:10a6:20b:44f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Fri, 10 May
 2024 13:35:13 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:35:13 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 2/2] bap: Create transports for matching BISes
Date: Fri, 10 May 2024 16:35:04 +0300
Message-Id: <20240510133504.26047-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240510133504.26047-1-andrei.istodorescu@nxp.com>
References: <20240510133504.26047-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR10CA0026.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d8::20) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|AS8PR04MB9192:EE_
X-MS-Office365-Filtering-Correlation-Id: 47acee8f-78b3-4c34-8f65-08dc70f604d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQpvqLUlGsj62wzXfAtrEYNilxdM7TrwcxZilz/tV4Hd1IPg5R4OdgENCT6w?=
 =?us-ascii?Q?2RHkw37tYC6ABBY+KDHXuU4oJadd2vA/hxU1bgKD3DY156JLwfZdy/WAbw51?=
 =?us-ascii?Q?+ESN0HJQop3e0covEiVuOA/wP3NxN9ebtnjmq2wL9SFkNPpg5Ul3s3p9dwp4?=
 =?us-ascii?Q?pfkXmGn8UB/AAK2XRBr0n6Cnf67/Qfp7Mr96hpTcKnDqmBEstkMAEkWB2isT?=
 =?us-ascii?Q?tZjRMIKcKst2fUu++k2Qhsl43G66x58M5Q4f9wr5novc+da+ZL1MIHSzWnMB?=
 =?us-ascii?Q?259/xV0/oCn3/CWNPZzH6jIFCvv5rFca8o64gmlkaSZ6BXZ4Orr3vJCcO8fB?=
 =?us-ascii?Q?5M4GrgAIIowHHV87RzgPjd149Fj1PCYTFj2k02VkkET2Qzm0AlGtyGsZTvYK?=
 =?us-ascii?Q?VLbkeWtczlvoXDItsaxj+VulBXnjv/gywKYGC9lLiP1ltdAcOxhSKnBgUCmW?=
 =?us-ascii?Q?zWWfjBRP3chNE+XMnBpB8JSbXOjhMOcdj2K87VKftxSlkX/gY5KuPdjzbltW?=
 =?us-ascii?Q?ZcHkayQcttesBQXZpUL6/Qc7yfUuCybTDNUwsUvUdJlcaabywsB6TekV2Vmx?=
 =?us-ascii?Q?deKz2BhTuZhFrSCYmC0/HIBFpxkzrTc/gZyoOzPg0bhMJbQ+5aajE4jP5jKz?=
 =?us-ascii?Q?fXyELi6SMYyBC1XVKXjMoha7B7wHir5xrEcw3Nw8UkGWJrpFOcoI0ErYBJc0?=
 =?us-ascii?Q?L9YyzC4FGhxKWqmdBWzvn8KhA94VdQkyfgNSekJDVLyZAnec/d0f9bSeCgQe?=
 =?us-ascii?Q?zatvf/LTaIaMI5w4tvpOYMwj2cEYlIO1kstKiI1NVXX7VEHZ0BerKzohWBTw?=
 =?us-ascii?Q?j0u+H3wyraFMCYLwjlaUUXg2QtDJufEKR2UdrXOqR1Rampi03h4J3B2auzBN?=
 =?us-ascii?Q?xKSjBf0OZ9xbeYIsrQFfC9iab/8npxCI/MgjGyvvTP1QLMOCxke3s4H2kdBB?=
 =?us-ascii?Q?eEE3/6nG3y/ZMsJeEUfkxi7z33lbx+fBPxHsSviDyyrjWMPU+5wWkdm8UaN5?=
 =?us-ascii?Q?FWJQvv1uKv02px5XWBkL7EW/M8ZCYspH08AEDpkijYiaUITpuXz1TLmo5m8v?=
 =?us-ascii?Q?8YF7JVThwNq1IozfUX3AvAeaLd6IozwaiMlbFlMP8zqx3nlxrX8d+3pY2dap?=
 =?us-ascii?Q?BvYnyB2k7YNC2Z4I6DevrfRgJOeSXSGJuAUooT0asw9jwauWPBv/x+w5Vot/?=
 =?us-ascii?Q?El9deCyS8b70KH8W4bGPZkwvx92iXmI35hcP1qM4vij5elBRblz78ATCNMqq?=
 =?us-ascii?Q?J5NfppA+zqFa1NH7cE6e89kay2JqZ3uOvvAqX+sJsA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?L+7m5eh8Ci+WTM6HtV/pLkDX6VaAPlSOBgg2kcspxIcItmrNF+0lRf8CyyPQ?=
 =?us-ascii?Q?vGW9JbZYRy/Y1Z0u12CZDa96fspf7QOAbY5YA4lx0rBXoSuOZssLCDn7tTrC?=
 =?us-ascii?Q?Wo4IMeMjgD26CvNJ1dw6+05TBcScTaMo2crAS4WXRuQq0sgMMliweVfe14gN?=
 =?us-ascii?Q?k/84/AcvKqhAY2vok3GdGkEVKlJclDhqSkM58PclxLcrMZXsuxxIF/3fNUZj?=
 =?us-ascii?Q?BrXfX/IQf6OKSeRuQH4MpBoOpmEDpsyCExwPtGObdjmF7/hA/esMFJC0lKpf?=
 =?us-ascii?Q?nTcGB2mZo5+b2JWzEK/dTDEPUAxHPhy7TLHLudhm/yUU7G9nhMxqlxFtXM4N?=
 =?us-ascii?Q?TKSgMQ/S7BKNhLbT+BxACDZntOT93jo8ZCZcu9CqjD53tgnIa3iTEmcYbvbc?=
 =?us-ascii?Q?s1nORpFaxymJi4f4WU0gxaimIYBWzR9xQAMXvy+hhc+OCMIQviBMYTJx7DZa?=
 =?us-ascii?Q?tF91aCwojJw5HjHbHece1crVeS5+LYeaQKoP2RjGJaiQ88KPMKbvFvlioSYe?=
 =?us-ascii?Q?I+O7cyJ8G+sBC2llV1ZJ1pu5ynrX+5D7fWbgnIsSDHEm6IMGWIl+q+iJJnmz?=
 =?us-ascii?Q?oipzRv5AndC7bOcGlu8RMvrX4toaQfo/r5qgYmh3mefVGzzUtiyUaQqc9+dp?=
 =?us-ascii?Q?HPza1kMUseMQmQt4828bXKrieZAaemui4YaQxjdeWCfjK4hZIMjG1VC154vA?=
 =?us-ascii?Q?LOEHaib1yC5jZ5W8QRzWV75dTQdpPXVTTqW91Qg76a+mKeD0uhg5QhYQdwTs?=
 =?us-ascii?Q?+Y2cn1+XSO22hL/BUgsCkhnIVw5+8O0t1WPSXmWTXiA0F4LeRLWi4umWvwrp?=
 =?us-ascii?Q?IB2yblEaIsJMwAbp1v6wVsU63Fp2f1wi6+XcIdnVBshWeN+gPmid5IjdLAUF?=
 =?us-ascii?Q?cFZGTTeTg2QIu1L0XCsBsqANP3VHQqGqEaIfWf46Z2yjpotDQqesKo/GgbY2?=
 =?us-ascii?Q?wGdgtYmGHJ7/H7gZKrz0lKWd2qjk4Zew5wzUwFa2AzEtE7TMEMOXODxV5Obr?=
 =?us-ascii?Q?VBhYxitRSdD/O9tusKBBN8DDp6DV6L2cYBY29TnfBVtq519hry9fr5FijjgL?=
 =?us-ascii?Q?wzEEu+/jgMuUUnQwgOWxJXPqlx+3lsvvLg0iVtv7YvIOOClHI1VDSoGPhtYt?=
 =?us-ascii?Q?/9MgirpGhHHM8vYlZk1l+bGa8u2yD7DXWHImIHl4YJJNg6ILYzssIeIDWXM2?=
 =?us-ascii?Q?p3JsoZvJQJxdafP3kVH0pQioIehUiiab3TCa9cwl16VMXg/eOtiuBM/OD2ip?=
 =?us-ascii?Q?dz5KUE1qcHb/7TQQ/cPvnYsxASmAs2en5xL3Bd5AksegamedHda6hxaR2MAZ?=
 =?us-ascii?Q?NOk2T5tGbMzxH2+YlwvC+LRupUp6X1brexdWZMiYNfCbAl8W6Y484A/U6nMO?=
 =?us-ascii?Q?ZhaCg6Iv3wHZYOBm7EirIMwFO0ENhk5NWlEodER5LZJTY5S4fVNAlEHWmYBY?=
 =?us-ascii?Q?WM9vasw7lPGVKXZTQb9yJczD4NDNVBVxaVr62EWWiiHn6IYIRvm4T5lHktO8?=
 =?us-ascii?Q?BX5gwGXPe2ES9zaqx6x3n4xFQv25kLLXq7nJe1CiCBDFyv/BMKCXa8ee4rT+?=
 =?us-ascii?Q?NfNd//b+JwN245+w3S/x0F9Z3f1XJmYxfJxXXF87ghf7MUaXQiA1rbnA/o5m?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47acee8f-78b3-4c34-8f65-08dc70f604d7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 13:35:12.9933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RBcTaTE4ibZaiqOylE6Mu5Uvh3PoFTeaVFQDDrj1Od8VR2o5I47Qo/A/33ryOonEHoU6P10RkbYQR+RHr5oeQfBAnRvjK1QgqCDRKmhnNpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9192

Rename bt_bap_add_bis to bt_bap_check_bis. This function is now an
utilitary for checking if the information from a BIS is matching the
capabilities in bt_bap. This utilitary is used when parsing the BASE
data so that we can decide if we create a new setup/stream/transport for
it, or advance to the next BIS.
When checking in local PACS for a BIS match, return also the local PAC,
along with the status of the operation. This information is required
later when we create the stream.

Use the BIS index received in the BASE to synchronize to the BIG.
Allow bt_bap_endpoint to be NULL.
Remove the Broadcast Sink code from set_configuration.
Update BASE parsing so that it creates streams and transports, without a
remote PAC and endpoint.
Update bap_find_setup_by_stream to find the setup in case the stream does
not contain an endpoint.
---
 profiles/audio/bap.c | 323 ++++++++++++++++++++++++++++++-------------
 src/shared/bap.c     | 227 ++++++++++++++++--------------
 src/shared/bap.h     |   6 +-
 3 files changed, 357 insertions(+), 199 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8e4f4b311fba..c3b8209a0a0a 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -115,6 +115,7 @@ struct bap_data {
 	struct queue *srcs;
 	struct queue *snks;
 	struct queue *bcast;
+	struct queue *bcast_snks;
 	struct queue *streams;
 	GIOChannel *listen_io;
 	int selecting;
@@ -131,7 +132,10 @@ struct bap_bcast_pa_req {
 	bool in_progress;
 	union {
 		struct btd_service *service;
-		struct bap_setup *setup;
+		struct bap_accept {
+			struct bap_setup *setup;
+			struct bap_data *bap_data;
+		} accept_data;
 	} data;
 };
 
@@ -202,6 +206,8 @@ static void ep_unregister(void *data)
 						MEDIA_ENDPOINT_INTERFACE);
 }
 
+static void setup_free(void *data);
+
 static void bap_data_free(struct bap_data *data)
 {
 	if (data->listen_io) {
@@ -218,6 +224,7 @@ static void bap_data_free(struct bap_data *data)
 	queue_destroy(data->srcs, ep_unregister);
 	queue_destroy(data->bcast, ep_unregister);
 	queue_destroy(data->streams, NULL);
+	queue_destroy(data->bcast_snks, setup_free);
 	bt_bap_ready_unregister(data->bap, data->ready_id);
 	bt_bap_state_unregister(data->bap, data->state_id);
 	bt_bap_pac_unregister(data->bap, data->pac_id);
@@ -855,7 +862,11 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 	setup = new0(struct bap_setup, 1);
 	setup->ep = ep;
 
-	if (queue_find(ep->data->bcast, NULL, ep)) {
+	/* Broadcast Source has endpoints in bcast list, Broadcast Sink
+	 * does not have endpoints
+	 */
+	if (((ep != NULL) && queue_find(ep->data->bcast, NULL, ep)) ||
+			(ep == NULL)) {
 		/* Mark BIG and BIS to be auto assigned */
 		setup->qos.bcast.big = BT_ISO_QOS_BIG_UNSET;
 		setup->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
@@ -871,12 +882,14 @@ static struct bap_setup *setup_new(struct bap_ep *ep)
 		setup->qos_parser = setup_parse_ucast_qos;
 	}
 
-	if (!ep->setups)
-		ep->setups = queue_new();
+	if (ep) {
+		if (!ep->setups)
+			ep->setups = queue_new();
 
-	queue_push_tail(ep->setups, setup);
+		queue_push_tail(ep->setups, setup);
 
-	DBG("ep %p setup %p", ep, setup);
+		DBG("ep %p setup %p", ep, setup);
+	}
 
 	return setup;
 }
@@ -947,17 +960,6 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		return btd_error_invalid_args(msg);
 	}
 
-	/* For BAP Broadcast Sink, the capabilities and metadata are coming
-	 * from the source's BIS, which are present in the remote PAC
-	 */
-	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK) {
-		util_iov_free(setup->caps, 1);
-		setup->caps = util_iov_dup(bt_bap_pac_get_data(ep->rpac), 1);
-		util_iov_free(setup->metadata, 1);
-		setup->metadata = util_iov_dup(
-				bt_bap_pac_get_metadata(ep->rpac), 1);
-	}
-
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
 						&setup->qos, setup->caps);
 	bt_bap_stream_set_user_data(setup->stream, ep->path);
@@ -993,20 +995,27 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
+	struct bap_setup *setup = req->data.accept_data.setup;
 	int fd;
 
 	DBG("BIG Sync completed");
 
-	queue_remove(setup->ep->data->adapter->bcast_pa_requests, req);
+	g_io_channel_unref(setup->io);
+	g_io_channel_shutdown(setup->io, TRUE, NULL);
+	setup->io = NULL;
 
 	/* This device is no longer needed */
-	btd_service_connecting_complete(setup->ep->data->service, 0);
+	btd_service_connecting_complete(req->data.accept_data.bap_data->service,
+			0);
 
 	fd = g_io_channel_unix_get_fd(io);
 
+	queue_remove(req->data.accept_data.bap_data->adapter->bcast_pa_requests,
+				req);
+	free(req);
+
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
-		bt_bap_stream_enable(setup->stream, true, NULL, NULL, NULL);
+		bt_bap_stream_start(setup->stream, NULL, NULL);
 		g_io_channel_set_close_on_unref(io, FALSE);
 		return;
 	}
@@ -1019,8 +1028,54 @@ static void print_ltv(size_t i, uint8_t l, uint8_t t, uint8_t *v,
 	util_hexdump(' ', v, l, user_data, NULL);
 }
 
-static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
-		util_debug_func_t func)
+static void create_stream_for_bis(struct bap_data *bap_data,
+		struct bt_bap_pac *lpac, struct bt_iso_qos *qos,
+		struct iovec *caps, struct iovec *meta, char *path)
+{
+	struct bap_setup *setup;
+
+	setup = setup_new(NULL);
+
+	/* Create BAP QoS structure */
+	setup->qos.bcast.big = qos->bcast.big;
+	setup->qos.bcast.bis = qos->bcast.bis;
+	setup->qos.bcast.sync_factor = qos->bcast.sync_factor;
+	setup->qos.bcast.packing = qos->bcast.packing;
+	setup->qos.bcast.framing = qos->bcast.framing;
+	setup->qos.bcast.encryption = qos->bcast.encryption;
+	if (setup->qos.bcast.encryption)
+		util_iov_append(setup->qos.bcast.bcode,
+				qos->bcast.bcode,
+				sizeof(qos->bcast.bcode));
+	setup->qos.bcast.options = qos->bcast.options;
+	setup->qos.bcast.skip = qos->bcast.skip;
+	setup->qos.bcast.sync_timeout = qos->bcast.sync_timeout;
+	setup->qos.bcast.sync_cte_type =
+			qos->bcast.sync_cte_type;
+	setup->qos.bcast.mse = qos->bcast.mse;
+	setup->qos.bcast.timeout = qos->bcast.timeout;
+	setup->qos.bcast.io_qos.interval =
+			qos->bcast.in.interval;
+	setup->qos.bcast.io_qos.latency = qos->bcast.in.latency;
+	setup->qos.bcast.io_qos.phy = qos->bcast.in.phy;
+	setup->qos.bcast.io_qos.rtn = qos->bcast.in.rtn;
+	setup->qos.bcast.io_qos.sdu = qos->bcast.in.sdu;
+
+	queue_push_tail(bap_data->bcast_snks, setup);
+
+	/* Create and configure stream */
+	setup->stream = bt_bap_stream_new(bap_data->bap,
+			lpac, NULL, &setup->qos, caps);
+
+	bt_bap_stream_set_user_data(setup->stream, path);
+	bt_bap_stream_config(setup->stream, &setup->qos,
+			caps, NULL, NULL);
+	bt_bap_stream_metadata(setup->stream, meta,
+			NULL, NULL);
+}
+
+static bool parse_base(struct bap_data *bap_data, struct bt_iso_base *base,
+		struct bt_iso_qos *qos, util_debug_func_t func)
 {
 	struct iovec iov = {
 		.iov_base = base->base,
@@ -1092,11 +1147,20 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 		for (; num_bis; num_bis--) {
 			uint8_t bis_index;
 			struct iovec *l3_caps;
+			struct iovec *merged_caps;
+			struct bt_bap_pac *matched_lpac;
+			char *path;
+			int err;
 
 			if (!util_iov_pull_u8(&iov, &bis_index))
 				goto fail;
 
 			util_debug(func, NULL, "BIS #%d", bis_index);
+			err = asprintf(&path, "%s/bis%d",
+					device_get_path(bap_data->device),
+					bis_index);
+			if (err < 0)
+				continue;
 
 			/* Read Codec Specific Configuration */
 			l3_caps = new0(struct iovec, 1);
@@ -1115,9 +1179,16 @@ static bool parse_base(struct bt_bap *bap, struct bt_iso_base *base,
 					l3_caps->iov_len, NULL, print_ltv,
 					func);
 
-			/* Try to create a PAC using this BIS information */
-			bt_bap_add_bis(bap, bis_index, &codec, l2_caps, l3_caps,
-					meta);
+			/* Check if this BIS matches any local PAC */
+			bt_bap_verify_bis(bap_data->bap, bis_index, &codec,
+					l2_caps, l3_caps, &matched_lpac,
+					&merged_caps);
+
+			if (matched_lpac == NULL || merged_caps == NULL)
+				continue;
+
+			create_stream_for_bis(bap_data, matched_lpac, qos,
+					merged_caps, meta, path);
 		}
 
 	}
@@ -1155,12 +1226,16 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
-	queue_remove(data->adapter->bcast_pa_requests, req);
-	free(req);
+
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
-	parse_base(data->bap, &base, bap_debug);
+	parse_base(data, &base, &qos, bap_debug);
+
+	service_set_connecting(req->data.service);
+
+	queue_remove(data->adapter->bcast_pa_requests, req);
+	free(req);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1563,6 +1638,7 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 					struct bt_bap_stream *stream)
 {
 	struct bap_ep *ep = NULL;
+	struct queue *queue = NULL;
 
 	switch (bt_bap_stream_get_type(stream)) {
 	case BT_BAP_STREAM_TYPE_UCAST:
@@ -1577,9 +1653,11 @@ static struct bap_setup *bap_find_setup_by_stream(struct bap_data *data,
 	}
 
 	if (ep)
-		return queue_find(ep->setups, match_setup_stream, stream);
+		queue = ep->setups;
+	else
+		queue = data->bcast_snks;
 
-	return NULL;
+	return queue_find(queue, match_setup_stream, stream);
 }
 
 static void iso_connect_bcast_cb(GIOChannel *chan, GError *err,
@@ -2121,7 +2199,8 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	 */
 	req->type = BAP_PA_BIG_SYNC_REQ;
 	req->in_progress = FALSE;
-	req->data.setup = setup;
+	req->data.accept_data.setup = setup;
+	req->data.accept_data.bap_data = data;
 	queue_push_tail(adapter->bcast_pa_requests, req);
 }
 
@@ -2181,7 +2260,7 @@ static void setup_create_bcast_io(struct bap_data *data,
 	memcpy(&iso_qos.bcast.out, &setup->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
 
-	if (bt_bap_pac_get_type(setup->ep->lpac) == BT_BAP_BCAST_SOURCE)
+	if (bt_bap_stream_get_dir(stream) == BT_BAP_BCAST_SINK)
 		setup_connect_io_broadcast(data, setup, stream, &iso_qos,
 			defer);
 	else
@@ -2393,7 +2472,7 @@ static uint8_t get_streams_nb_by_state(struct bap_setup *setup)
 	return stream_cnt;
 }
 
-static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
+static void bap_state_bcast_src(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
 {
 	struct bap_data *data = user_data;
@@ -2422,66 +2501,96 @@ static void bap_state_bcast(struct bt_bap_stream *stream, uint8_t old_state,
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (!setup || setup->id)
 			break;
-		if (bt_bap_stream_io_dir(stream) ==
-				BT_BAP_BCAST_SOURCE)
-			/* If the stream is attached to a
-			 * broadcast sink endpoint.
-			 */
-			setup_create_io(data, setup, stream, defer);
-		else {
-			/* If the stream attached to a broadcast
-			 * source endpoint generate the base.
-			 */
-			if (setup->base == NULL) {
-				setup->base = bt_bap_stream_get_base(
-						setup->stream);
-				/* Set the generated BASE on all setups
-				 * from the same BIG.
-				 */
-				queue_foreach(setup->ep->setups,
-					iterate_setup_update_base, setup);
-			}
-			/* The kernel has 2 requirements when handling
-			 * multiple BIS connections for the same BIG:
-			 * 1 - setup_create_io for all but the last BIS
-			 * must be with defer true so we can inform the
-			 * kernel when to start the BIG.
-			 * 2 - The order in which the setup_create_io
-			 * are called must be in the order of BIS
-			 * indexes in BASE from first to last.
-			 * To address this requirement we will call
-			 * setup_create_io on all BISes only when all
-			 * transport acquire have been received and will
-			 * send it in the order of the BIS index
-			 * from BASE.
+		/* If the stream attached to a broadcast
+		 * source endpoint generate the base.
+		 */
+		if (setup->base == NULL) {
+			setup->base = bt_bap_stream_get_base(
+					setup->stream);
+			/* Set the generated BASE on all setups
+			 * from the same BIG.
 			 */
-			nb_bises = get_streams_nb_by_state(setup);
-
-			if (nb_bises == 1) {
-				setup_create_io(data, setup,
-				stream, defer);
-				if (!setup->io) {
-					error("Unable to create io");
-					if (old_state !=
-						BT_BAP_STREAM_STATE_RELEASING)
-						bt_bap_stream_release(stream,
-								NULL, NULL);
-				}
-				break;
-			} else if (nb_bises == 0)
-				break;
+			queue_foreach(setup->ep->setups,
+				iterate_setup_update_base, setup);
+		}
+		/* The kernel has 2 requirements when handling
+		 * multiple BIS connections for the same BIG:
+		 * 1 - setup_create_io for all but the last BIS
+		 * must be with defer true so we can inform the
+		 * kernel when to start the BIG.
+		 * 2 - The order in which the setup_create_io
+		 * are called must be in the order of BIS
+		 * indexes in BASE from first to last.
+		 * To address this requirement we will call
+		 * setup_create_io on all BISes only when all
+		 * transport acquire have been received and will
+		 * send it in the order of the BIS index
+		 * from BASE.
+		 */
+		nb_bises = get_streams_nb_by_state(setup);
 
-			if (!create_io_bises(setup, nb_bises, data)) {
+		if (nb_bises == 1) {
+			setup_create_io(data, setup,
+			stream, defer);
+			if (!setup->io) {
+				error("Unable to create io");
 				if (old_state !=
 					BT_BAP_STREAM_STATE_RELEASING)
 					bt_bap_stream_release(stream,
-						NULL, NULL);
+							NULL, NULL);
 			}
+			break;
+		} else if (nb_bises == 0)
+			break;
+
+		if (!create_io_bises(setup, nb_bises, data)) {
+			if (old_state !=
+				BT_BAP_STREAM_STATE_RELEASING)
+				bt_bap_stream_release(stream,
+					NULL, NULL);
 		}
 		break;
 	}
 }
 
+static void bap_state_bcast_sink(struct bt_bap_stream *stream,
+				uint8_t old_state, uint8_t new_state,
+				void *user_data)
+{
+	struct bap_data *data = user_data;
+	struct bap_setup *setup;
+	bool defer = false;
+
+	DBG("stream %p: %s(%u) -> %s(%u)", stream,
+			bt_bap_stream_statestr(old_state), old_state,
+			bt_bap_stream_statestr(new_state), new_state);
+
+	if (new_state == old_state && new_state != BT_BAP_STREAM_STATE_CONFIG)
+		return;
+
+	setup = bap_find_setup_by_stream(data, stream);
+
+	switch (new_state) {
+	case BT_BAP_STREAM_STATE_IDLE:
+		/* Release stream if idle */
+		if (setup)
+			setup_free(setup);
+		else
+			queue_remove(data->streams, stream);
+		break;
+	case BT_BAP_STREAM_STATE_CONFIG:
+		if (!setup)
+			break;
+		if (old_state ==
+				BT_BAP_STREAM_STATE_CONFIG)
+			setup_create_io(data, setup, stream, defer);
+		if (old_state ==
+				BT_BAP_STREAM_STATE_STREAMING)
+			setup_io_close(setup, NULL);
+		break;
+	}
+}
+
 static void pac_added(struct bt_bap_pac *pac, void *user_data)
 {
 	struct btd_service *service = user_data;
@@ -2827,29 +2936,50 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bap_setup *setup = req->data.accept_data.setup;
+	struct bap_data *data = req->data.accept_data.bap_data;
 	struct sockaddr_iso_bc iso_bc_addr;
 	struct bt_iso_qos qos;
+	char *path;
+	int bis_index = 1;
+	int s_err;
+	const char *strbis = NULL;
 
-	DBG("PA Sync done, do BIG Sync");
+	DBG("PA Sync done");
 	g_io_channel_unref(setup->io);
-	setup->io = NULL;
-
+	g_io_channel_shutdown(setup->io, TRUE, NULL);
 	setup->io = io;
 	g_io_channel_ref(setup->io);
 
 	/* TODO
 	 * We can only synchronize with a single BIS to a BIG.
 	 * In order to have multiple BISes targeting this BIG we need to have
-	 * all the BISes before doing this request. This request is triggered
-	 * by an endpoint "SetConfiguration" command. For multiple BISes
-	 * we need another way to specify which BISes user is requesting
+	 * all the BISes before doing bt_io_bcast_accept.
+	 * This request comes from a transport "Acquire" call.
+	 * For multiple BISes in the same BIG we need to either wait for all
+	 * transports in the same BIG to be acquired or tell when to do the
+	 * bt_io_bcast_accept by other means
 	 */
+	path = bt_bap_stream_get_user_data(setup->stream);
+
+	strbis = strstr(path, "/bis");
+	if (strbis == NULL) {
+		DBG("bis index cannot be found");
+		return;
+	}
+
+	s_err = sscanf(strbis, "/bis%d", &bis_index);
+	if (s_err == -1) {
+		DBG("sscanf error");
+		return;
+	}
+
+	DBG("Do BIG Sync with BIS %d", bis_index);
+
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_bis[0] = bis_index;
 	iso_bc_addr.bc_num_bis = 1;
 
 	/* Set the user requested QOS */
@@ -2893,8 +3023,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
-	struct bap_setup *setup = req->data.setup;
-	struct bap_data *data = setup->ep->data;
+	struct bap_setup *setup = req->data.accept_data.setup;
+	struct bap_data *data = req->data.accept_data.bap_data;
 
 	req->in_progress = TRUE;
 
@@ -2947,6 +3077,7 @@ static int bap_bcast_probe(struct btd_service *service)
 		free(data);
 		return -EINVAL;
 	}
+	data->bcast_snks = queue_new();
 
 	if (!bt_bap_attach(data->bap, NULL)) {
 		error("BAP unable to attach");
@@ -2957,7 +3088,7 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	data->ready_id = bt_bap_ready_register(data->bap, bap_ready, service,
 								NULL);
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_sink,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 				pac_removed_broadcast, data, NULL);
@@ -3140,7 +3271,7 @@ static int bap_adapter_probe(struct btd_profile *p, struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast,
+	data->state_id = bt_bap_state_register(data->bap, bap_state_bcast_src,
 					bap_connecting_bcast, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
 					pac_removed_broadcast, data, NULL);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index ff3e36a6fbc2..067c701d24ff 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -226,6 +226,7 @@ struct bt_bap_stream_io {
 struct bt_bap_stream_ops {
 	uint8_t type;
 	void (*set_state)(struct bt_bap_stream *stream, uint8_t state);
+	unsigned int (*get_state)(struct bt_bap_stream *stream);
 	unsigned int (*config)(struct bt_bap_stream *stream,
 				struct bt_bap_qos *qos, struct iovec *data,
 				bt_bap_stream_func_t func, void *user_data);
@@ -245,6 +246,8 @@ struct bt_bap_stream_ops {
 	unsigned int (*metadata)(struct bt_bap_stream *stream,
 				struct iovec *data, bt_bap_stream_func_t func,
 				void *user_data);
+	unsigned int (*get_dir)(struct bt_bap_stream *stream);
+	unsigned int (*get_loc)(struct bt_bap_stream *stream);
 	unsigned int (*release)(struct bt_bap_stream *stream,
 				bt_bap_stream_func_t func, void *user_data);
 };
@@ -1578,6 +1581,11 @@ done:
 	bap_stream_state_changed(stream);
 }
 
+static unsigned int bap_ucast_get_state(struct bt_bap_stream *stream)
+{
+	return stream->ep->state;
+}
+
 static unsigned int bap_ucast_config(struct bt_bap_stream *stream,
 					struct bt_bap_qos *qos,
 					struct iovec *data,
@@ -1923,6 +1931,27 @@ static bool bap_stream_valid(struct bt_bap_stream *stream)
 	return queue_find(stream->bap->streams, NULL, stream);
 }
 
+static unsigned int bap_ucast_get_dir(struct bt_bap_stream *stream)
+{
+	return stream->ep->dir;
+}
+
+static unsigned int bap_ucast_get_location(struct bt_bap_stream *stream)
+{
+	struct bt_pacs *pacs;
+
+	if (!stream)
+		return 0x00000000;
+
+	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
+
+	if (stream->ep->dir == BT_BAP_SOURCE)
+		return pacs->source_loc_value;
+	else if (stream->ep->dir == BT_BAP_SINK)
+		return pacs->sink_loc_value;
+	return 0x00000000;
+}
+
 static unsigned int bap_ucast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2000,6 +2029,11 @@ static void bap_bcast_set_state(struct bt_bap_stream *stream, uint8_t state)
 	}
 }
 
+static unsigned int bap_bcast_get_state(struct bt_bap_stream *stream)
+{
+	return stream->state;
+}
+
 static unsigned int bap_bcast_enable(struct bt_bap_stream *stream,
 					bool enable_links, struct iovec *data,
 					bt_bap_stream_func_t func,
@@ -2019,6 +2053,17 @@ static unsigned int bap_bcast_start(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_sink_disable(struct bt_bap_stream *stream,
+					bool disable_links,
+					bt_bap_stream_func_t func,
+					void *user_data)
+{
+	bap_stream_io_detach(stream);
+	stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
+
+	return 1;
+}
+
 static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
 					bool disable_links,
 					bt_bap_stream_func_t func,
@@ -2040,6 +2085,43 @@ static unsigned int bap_bcast_metadata(struct bt_bap_stream *stream,
 	return 1;
 }
 
+static unsigned int bap_bcast_src_get_dir(struct bt_bap_stream *stream)
+{
+	return BT_BAP_BCAST_SINK;
+}
+
+static unsigned int bap_bcast_sink_get_dir(struct bt_bap_stream *stream)
+{
+	return BT_BAP_BCAST_SOURCE;
+}
+
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
+static unsigned int bap_bcast_get_location(struct bt_bap_stream *stream)
+{
+	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
+	uint32_t allocation = 0;
+	struct iovec *caps;
+
+	caps = bt_bap_stream_get_config(stream);
+
+	/* Get stream allocation from capabilities */
+	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
+			bap_sink_get_allocation, &allocation);
+
+	return allocation;
+}
+
 static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 					bt_bap_stream_func_t func,
 					void *user_data)
@@ -2049,11 +2131,12 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	return 1;
 }
 
-#define STREAM_OPS(_type, _set_state, _config, _qos, _enable, _start, \
-			_disable, _stop, _metadata, _release) \
+#define STREAM_OPS(_type, _set_state, _get_state, _config, _qos, _enable, \
+	_start, _disable, _stop, _metadata, _get_dir, _get_loc, _release) \
 { \
 	.type = _type, \
 	.set_state = _set_state, \
+	.get_state = _get_state, \
 	.config = _config, \
 	.qos = _qos, \
 	.enable = _enable, \
@@ -2061,26 +2144,40 @@ static unsigned int bap_bcast_release(struct bt_bap_stream *stream,
 	.disable = _disable, \
 	.stop = _stop, \
 	.metadata = _metadata, \
+	.get_dir = _get_dir,\
+	.get_loc = _get_loc, \
 	.release = _release, \
 }
 
 static const struct bt_bap_stream_ops stream_ops[] = {
 	STREAM_OPS(BT_BAP_SINK, bap_ucast_set_state,
+			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
-			bap_ucast_metadata, bap_ucast_release),
+			bap_ucast_metadata, bap_ucast_get_dir,
+			bap_ucast_get_location,
+			bap_ucast_release),
 	STREAM_OPS(BT_BAP_SOURCE, bap_ucast_set_state,
+			bap_ucast_get_state,
 			bap_ucast_config, bap_ucast_qos, bap_ucast_enable,
 			bap_ucast_start, bap_ucast_disable, bap_ucast_stop,
-			bap_ucast_metadata, bap_ucast_release),
+			bap_ucast_metadata, bap_ucast_get_dir,
+			bap_ucast_get_location,
+			bap_ucast_release),
 	STREAM_OPS(BT_BAP_BCAST_SINK, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
-			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_start, bap_bcast_sink_disable, NULL,
+			bap_bcast_metadata, bap_bcast_sink_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 	STREAM_OPS(BT_BAP_BCAST_SOURCE, bap_bcast_set_state,
+			bap_bcast_get_state,
 			bap_bcast_config, NULL, bap_bcast_enable,
 			bap_bcast_start, bap_bcast_disable, NULL,
-			bap_bcast_metadata, bap_bcast_release),
+			bap_bcast_metadata, bap_bcast_src_get_dir,
+			bap_bcast_get_location,
+			bap_bcast_release),
 };
 
 static const struct bt_bap_stream_ops *
@@ -5380,11 +5477,7 @@ uint8_t bt_bap_stream_get_state(struct bt_bap_stream *stream)
 	if (!stream)
 		return BT_BAP_STREAM_STATE_IDLE;
 
-	if (stream->lpac->type != BT_BAP_BCAST_SOURCE &&
-			stream->lpac->type != BT_BAP_BCAST_SINK)
-		return stream->ep->state;
-	else
-		return stream->state;
+	return stream->ops->get_state(stream);
 }
 
 bool bt_bap_stream_set_user_data(struct bt_bap_stream *stream, void *user_data)
@@ -5568,53 +5661,15 @@ uint8_t bt_bap_stream_get_dir(struct bt_bap_stream *stream)
 	if (!stream)
 		return 0x00;
 
-	if (stream->ep)
-		return stream->ep->dir;
-
-	if (bt_bap_pac_get_type(stream->lpac) == BT_BAP_BCAST_SINK)
-		return BT_BAP_BCAST_SOURCE;
-	else
-		return BT_BAP_BCAST_SINK;
-}
-
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
+	return stream->ops->get_dir(stream);
 }
 
 uint32_t bt_bap_stream_get_location(struct bt_bap_stream *stream)
 {
-	struct bt_pacs *pacs;
-	uint8_t type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
-	uint32_t allocation = 0;
-	struct iovec *caps;
-
 	if (!stream)
 		return 0x00000000;
 
-	pacs = stream->client ? stream->bap->rdb->pacs : stream->bap->ldb->pacs;
-
-	if (stream->ep) {
-		if (stream->ep->dir == BT_BAP_SOURCE)
-			return pacs->source_loc_value;
-		else if (stream->ep->dir == BT_BAP_SINK)
-			return pacs->sink_loc_value;
-	}
-
-	caps = bt_bap_stream_get_config(stream);
-
-	/* Get stream allocation from capabilities */
-	util_ltv_foreach(caps->iov_base, caps->iov_len, &type,
-			bap_sink_get_allocation, &allocation);
-
-	return allocation;
+	return stream->ops->get_loc(stream);
 }
 
 struct iovec *bt_bap_stream_get_config(struct bt_bap_stream *stream)
@@ -6397,9 +6452,11 @@ static void check_local_pac(void *data, void *user_data)
 
 		/* We have a match if all selected LTVs have a match */
 		if ((bis_compare_data.data32 &
-			CODEC_SPECIFIC_CONFIGURATION_MASK) ==
-			CODEC_SPECIFIC_CONFIGURATION_MASK)
+				CODEC_SPECIFIC_CONFIGURATION_MASK) ==
+				CODEC_SPECIFIC_CONFIGURATION_MASK) {
 			compare_data->found = true;
+			compare_data->data = data;
+		}
 	}
 }
 
@@ -6424,7 +6481,8 @@ static void bap_sink_match_allocation(size_t i, uint8_t l, uint8_t t,
 		data->found = false;
 }
 
-static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
+static struct bt_ltv_match bap_check_bis(struct bt_bap_db *ldb,
+	struct iovec *bis_data)
 {
 	struct bt_ltv_match compare_data = {};
 
@@ -6450,21 +6508,18 @@ static bool bap_check_bis(struct bt_bap_db *ldb, struct iovec *bis_data)
 				&compare_data);
 	}
 
-	return compare_data.found;
+	return compare_data;
 }
 
-void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
 		struct iovec *l2_caps,
 		struct iovec *l3_caps,
-		struct iovec *meta)
+		struct bt_bap_pac **lpac,
+		struct iovec **caps)
 {
-	struct bt_bap_pac *pac_source_bis;
-	struct bt_bap_endpoint *ep;
-	int err = 0;
-	struct bt_bap_pac_qos bis_qos = {0};
-	uint8_t type = 0;
 	struct bt_ltv_extract merge_data = {0};
+	struct bt_ltv_match match_data = {0};
 
 	merge_data.src = l3_caps;
 	merge_data.result = new0(struct iovec, 1);
@@ -6480,43 +6535,15 @@ void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
 	/* Check each BIS Codec Specific Configuration LTVs against our Codec
 	 * Specific Capabilities and if the BIS matches create a PAC with it
 	 */
-	if (bap_check_bis(bap->ldb, merge_data.result) == false)
-		goto cleanup;
-
-	DBG(bap, "Matching BIS %i", bis_index);
-
-	/* Create a QoS structure based on the received BIS information to
-	 * specify the desired channel for this BIS/PAC
-	 */
-	type = BAP_CHANNEL_ALLOCATION_LTV_TYPE;
-	util_ltv_foreach(merge_data.result->iov_base,
-			merge_data.result->iov_len, &type,
-			bap_sink_get_allocation, &bis_qos.location);
-
-	/* Create a remote PAC */
-	pac_source_bis = bap_pac_new(bap->rdb, NULL,
-				BT_BAP_BCAST_SOURCE, codec, &bis_qos,
-				merge_data.result, meta);
-
-	err = asprintf(&pac_source_bis->name, "%d", bis_index);
-
-	if (err < 0) {
-		DBG(bap, "error in asprintf");
-		goto cleanup;
+	match_data = bap_check_bis(bap->ldb, merge_data.result);
+	if (match_data.found == true) {
+		*caps = merge_data.result;
+		*lpac = match_data.data;
+		DBG(bap, "Matching BIS %i", bis_index);
+	} else {
+		util_iov_free(merge_data.result, 1);
+		*caps = NULL;
+		*lpac = NULL;
 	}
 
-	/* Add remote source endpoint */
-	if (!bap->rdb->broadcast_sources)
-		bap->rdb->broadcast_sources = queue_new();
-	queue_push_tail(bap->rdb->broadcast_sources, pac_source_bis);
-
-	queue_foreach(bap->pac_cbs, notify_pac_added, pac_source_bis);
-	/* Push remote endpoint with direction sink */
-	ep = bap_endpoint_new_broadcast(bap->rdb, BT_BAP_BCAST_SINK);
-
-	if (ep)
-		queue_push_tail(bap->remote_eps, ep);
-
-cleanup:
-	util_iov_free(merge_data.result, 1);
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 62e2104850c7..35524df0b451 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -251,9 +251,9 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
 struct iovec *bt_bap_stream_get_base(struct bt_bap_stream *stream);
 
-void bt_bap_add_bis(struct bt_bap *bap, uint8_t bis_index,
+void bt_bap_verify_bis(struct bt_bap *bap, uint8_t bis_index,
 		struct bt_bap_codec *codec,
 		struct iovec *l2_caps,
 		struct iovec *l3_caps,
-		struct iovec *meta);
-
+		struct bt_bap_pac **lpac,
+		struct iovec **caps);
-- 
2.40.1

