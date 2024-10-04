Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010043.outbound.protection.outlook.com [52.101.69.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1499C1D359F
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Oct 2024 12:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728045348; cv=fail; b=RCu5ZReGdyFEiehi20wcs12F6+U7JYECbEbdFq5z8DX17vOYIaLRKIuhi+seeMxbibEBsla5O6zSejaWTwt423mJd2jdC1MbrLdpbeSiVtTDr24Do18J4hd6z0UvOSDnLAYCXJL7lhjD7IPbPRwFCVekjxrPAvDapoTMFwO/ImY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728045348; c=relaxed/simple;
	bh=PxND3jv0E4h02kPQYqG/eW3ZLTtmW2BmxwisxFyiVnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PcKVAHZrVYLXbW/SISnj41VdWTSxbcgdmbxwaxQp3+VjJ2TPrvmHcRLKAUtR4IS7iM/ISCySRuc78wXBCiDfGqN/knny9eFqiYiiA8W7jaHG64Ehugi6EbxD0R81vcljUDSXVp1ECwINoTozrpjhMXGvco7p9HuD8UvelaNPSiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=iI53L9rC; arc=fail smtp.client-ip=52.101.69.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="iI53L9rC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bfVYi/KoHzBDSW6gd9YObKTlQ01fH8/WdXe3uyhFmDgP/yxOlQMhJvE38dCpEtf6QSDeqTKxZZJ6dfpWK/+dexf5xmo09Rn1cHJQ7xilBML2yK9L+1yKGZEBY2RQKBcduquHLznYhB4b1HZ/flA97p3v3J6niXZgYpMOvsburplf2Yh8bbfrYnyalS+VsELtFjp0KOYFtuD+pxYswNkiaHUjHPQWquGkK4iPgDSOxjS6EJhieSgtLEcdawVm0EhLMzbjFtdvinnCGv/Ah7801sfq/9JZNtaqT5+kr0XLbPl1dIZDMz/Zsf0NBZdm22gYZvLPecB+MiFqUekOljdVEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7jTBQpSnhsG7XQlCby6cFZyurqF5+a5KfC0jxy9qdk=;
 b=Z/Oo3yHANzGCGDMDzjKC2eMpNVYUPpTugIlqsBlWeCVcyaAXEGmFqlUkPfdwYaZFsixUCCwp/xNwzuAm8VABF8p0p4WLbxHgC5LPRCqaulFHEu17++mbnNpSWRq+P0aGYD8HU57zVVRnsTn2mawR6RsjfQ/DARm2PDhlsJMMMWleENngfd5UvVSH38G8OLtRhqOg0siA195/XXlSWkluHk25YRKomlXeC7jF7C1Yqv486s2VCiWePTY7xVdF+re5Rvdg9QH6z2WSerArjx3sjR4mvSgV1W1tfGb+ELHUoA7mcXWDvR6TrSjxylp+eNtkg2HUTCMQmOrX6gC6uBcTlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7jTBQpSnhsG7XQlCby6cFZyurqF5+a5KfC0jxy9qdk=;
 b=iI53L9rCFkZ16I5gv1yJvtCbWrpWHdwbEte/TwGVAw7q2kOSbxCAPikZx5BmgjkGmCNUFGh0CAcM59/fPTrL3iufS3XF1HBl8GFSx4NIPt81rqMVKh6NBL7kgJqjcv5DBuinwKEyawymrGErjURtcEafJrcQAV/Gdaq6dnysHm6Z6xSP/cz/43pvM8RpbZnHENt7xsLd9pRzckIOq1dvzb986TRU/JDJoMq+ux3IPaL9+n0tayKVrNMyKv8O1jkh9hYS3b4SJju87U82clJyswiFCIhLt5FKUn1NiQl7f12iI8In7rOGYgbjW7v/TnOcVmImvD73mlr1vqcpTxKFYQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB9PR04MB9963.eurprd04.prod.outlook.com (2603:10a6:10:4ec::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 12:35:43 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%3]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:35:42 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 2/9] bap: Drop union from bap_bcast_pa_req and add setups queue
Date: Fri,  4 Oct 2024 15:35:16 +0300
Message-Id: <20241004123523.1012743-3-vlad.pruteanu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 05dd5f66-4617-47d7-25ec-08dce4710fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1FHan3i48XDCfFyNf2vjxDaDM95bm80qHpGcuK/J+OZjCd1ofnzQYaRAhzcW?=
 =?us-ascii?Q?ortxtWCj2QKu2GEycroK67XaSDIwJUHf1N4rl/Xwm9dAvTinLGX4p9JG/MaZ?=
 =?us-ascii?Q?5m0rTgHCuJkTVnGWBJxttZnX70nHkbLg/4ONNOcoESISjytwz1dSdt9fVNv0?=
 =?us-ascii?Q?hwHK/COBwM7KpdQpL2hRbkV08M1epqSsCfKp5FN/Kd68570+Y1/dd/xBCWGp?=
 =?us-ascii?Q?Ygq83jX5vRkHAb5xQKk+gG7pmp66RgXDVnUYgtRQra04kwgTxVKsUMMKqhzN?=
 =?us-ascii?Q?1SrHR9NF7QsGEmyh46j/OBlMDfHYOWVoNiqE1W6TnKqlOVrMD6Fy5zcKYKQX?=
 =?us-ascii?Q?jhGFX9ZqS6Wj94I0h0D3tUQG1Rq5DVo9e4LM6EOPyu6Irh71430Ct2l3BvlM?=
 =?us-ascii?Q?YdWqeU329vavAjLL5sSsvGrVt/b1teTvXjqvuBj/91lreQ39groTlRfC7q+Q?=
 =?us-ascii?Q?ICFX5Zh7i5oMvhM4rpL2VABh5KfqUgutaH/CujX1Cu++hs0cfC4ylMacUOvN?=
 =?us-ascii?Q?XELodvU6l5fTsXsbECYIaSYA0MchgILj/Cigx/YsaoyvOBn7peu4lLMQDXv1?=
 =?us-ascii?Q?3Uq2Y0rdOFhe/TvfH0JU9yc5IUc458f/H1CqrCJy9mEJSu9llcoqEP0ZsH19?=
 =?us-ascii?Q?D6q14b7cxtkBpVNeGJCOclDma9YnwK0V8JBSCZ+LCFOmBwUL8Wmj8VGySe4c?=
 =?us-ascii?Q?j/+Vo4LOatRmZjfxwPqe0z6QEBf/ftzwPTzqk/fQKOee/yCWyRc4jSLK7IvX?=
 =?us-ascii?Q?ybORLpwOSPybOXDYipbkBuhSWe9MHZ++cVnrV4EXxL91jTs/hH79X9xJ0iEE?=
 =?us-ascii?Q?UsujBXw/z11hy4KLfXwc0MmMokXTZGpzWvwlLeDjoWjizh6jc0AvVvKHRiYn?=
 =?us-ascii?Q?X/8NbTvY7qXpbhQQGQbljf282z6E/CFw09yld7gD1JKUggCiqEZVqt/xGvyq?=
 =?us-ascii?Q?eyunkkI2GXadnqG2quvibYRCzfMCXQKF5BMsQHYzVKWZEhDpRO9t05lRjkjf?=
 =?us-ascii?Q?R0QL0YOiWpV7QVwKHgOwQDMteQ9fwlaWMMhoLLINhdUCHtQ6IOUPPiwusMnX?=
 =?us-ascii?Q?C1mR+YubltTK1D1DJd3HTmWjUpqWE6DtH+7yydGMLgUg1WOugbU5gs9V0hI8?=
 =?us-ascii?Q?rEi3F2OtCn3oQRfjiX+NdV6OUZOFTq3mCJY7CSaYiP+IKNCSOG0FPGCEL7nD?=
 =?us-ascii?Q?JF8g1Yt9JF5FU8XvSkrDraHI5C5i6c+qiBbkoq1R2V6Y1XdzYQhvuTYRlf++?=
 =?us-ascii?Q?lNvaldwpkZkZoc0v+bSzOQWVVHn+ddnVUQlNNGlOvAbPQn9hjC3prxJ5Y5kN?=
 =?us-ascii?Q?1tUvPD8g3eqtzfXfcuUL5bILEM7JcW/RvXgFFCkq9Mu4Gg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rNKIXSCPfJCy/QJYpWiV9iY2gE4RqfUCUBfXmtzct+6nnbjHOTwmcq2e5nCP?=
 =?us-ascii?Q?f0i6HbAzMviT0a5ZCwrS1XC7D84LUp2qRidXPUGz3ez3AcBgS3R7A9f72bh1?=
 =?us-ascii?Q?2CPk9YwRqJzDoPb01OZfISZWKpWLyvBmBsUyWnNZ+guYjO83RFIv56Qx46L/?=
 =?us-ascii?Q?RvKLDzrU0NDF14iCWTjB2QZcq77AcY0z4wQ16sItmEYkWj5TcjUhOx6qxCKu?=
 =?us-ascii?Q?6/TRgl3AW+/+DaDgLoCaZJqHbiaARq0rauwXA5GjfEUE9OyHZ10WP/1xDXvG?=
 =?us-ascii?Q?8bR0vIsBVgjjwabXrV6BSpJYJZguZSf+Cgp26YxaErmEyDUjxLVof8nyoXyF?=
 =?us-ascii?Q?17ma41owhY7AmuG3g3QnngMkPvhMK5TFSgH71cQ0fDsQzURnxbPQjz0YG0k9?=
 =?us-ascii?Q?hrl9C2itRV+dRXckzwe/6x5iprrhETA77/SGBDPj893nNYA5VisoUh3j6loW?=
 =?us-ascii?Q?pZeCbXh+ob6BifyumGBOswsim0g/9Mux40Qo0J7iVanWKpAj8fKNmTdWekNh?=
 =?us-ascii?Q?LQzB0rxELIwranwXdldgCsd7Az+otI7vYb+2UD3F2Sm7EMLSe8+PPMAmCItA?=
 =?us-ascii?Q?wLWU47Lq9LNDgtHxNpa7TAapRV1YLWY9jCpHSTILamyJuRKBEehyOyECdMYr?=
 =?us-ascii?Q?CKit6vUTtoB6rRB7Q05sgn3DUaIDSgGvhJF7UEwan8InIH9Ef7ApbJ2krueo?=
 =?us-ascii?Q?mjFSpHf4qlduAxonyx7xcm6cpJMNGqd2qjTEYCBa549nk+SPLK7/aALdLYNk?=
 =?us-ascii?Q?6hdqknQaRFU544iLPKXOj4Klsv812X3PQIzWuCm7VD2f4gAi7l+bdXRtwPjR?=
 =?us-ascii?Q?lm0FtBOxpTsM9TsDHyNLGe8JjCZYuqK0zE2etuYFEfwIJ8pgNFiS2w5ezeOf?=
 =?us-ascii?Q?5WrCaoa8XG56cN1A61ynpUTFiZK8HmjlC8artWmEfwR7IzsFqGSGiImnU+mM?=
 =?us-ascii?Q?QAW1LFP0u8//Idfm2p01iGiRIFKC4EYg5rUklLU1F9ydpLJHKFzU55DFQgqn?=
 =?us-ascii?Q?qv4NId9e3Qag9Upd2Lcyt1E+EP6tfmruvsdURobMj4Fqz6UhWJAuio8fQsDS?=
 =?us-ascii?Q?wF0aU2d9uumYoyPnCmOoCNyTLar+I02a24h3Ig81vvXOI/RV/1xoEFrFc3Ks?=
 =?us-ascii?Q?oYYVOYBwngpCQhGIjtvIdG2h8TmoLQOSQDqfzC2oiq85Rz+USRj/AnudxYHz?=
 =?us-ascii?Q?FEZ8u9KUH5lhzqY5ZjmGiD/MaBQLeKmP9CPv/pJiXZIW4LHNHV0/w0vK3nG7?=
 =?us-ascii?Q?nyJv7LPHXtohQpt6ez6V28xx14qi6VqUpVP8QUIy3phKixjJs/0myiewLBCF?=
 =?us-ascii?Q?s9zx9ecUN+NrHsftXIGIflws1xcsYayZHJ7NfKNszEVRgEBhKDVJWblW4iGJ?=
 =?us-ascii?Q?UiLkhhjhfQ+A5gTgfDT4MyJnHZEES2xtHwE8J0k12IhL688cYxyeLx/F0USq?=
 =?us-ascii?Q?PslUuj9uvd2/XUAUPdROlCIIrDGkFcgtnNQz1qP44db0Hm0q1fZl5Aov3qTc?=
 =?us-ascii?Q?ndcZmxPbiPjtVGk5cB1olxG1rfdvDIbzowva3cWMn0K2Cdf1nb7zvudme4R2?=
 =?us-ascii?Q?y/cFpzkIc4SvhX8By1iOE/feuiCQlZyLrsto1a0J?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05dd5f66-4617-47d7-25ec-08dce4710fd4
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:35:42.9264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t1R0h659UWB8lSdcV3/QbOvVU4BnF2HBkCGLeROAjYZHoqHwCqJ+o1/VA/4i7DxHRxdKJfBQxccpl+jmiSXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9963

For syncing to multiple BISes from the same BIG only one PA request
will be created and issued. But, for each stream (associated with a
BIS) there is a setup. To have all these setups in the PA request,
a queue of setups has been added to the structure. Thus, the old union
of setup and service has been removed.
---
 profiles/audio/bap.c | 43 +++++++++++++++++++++++++++++--------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index b48fe2c2f..94c7b7401 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -134,10 +134,8 @@ enum {
 struct bap_bcast_pa_req {
 	uint8_t type;
 	bool in_progress;
-	union {
-		struct btd_service *service;
-		struct bap_setup *setup;
-	} data;
+	struct btd_service *service;
+	struct queue *setups;
 	unsigned int io_id;	/* io_id for BIG Info watch */
 };
 
@@ -1021,7 +1019,10 @@ static int get_bis_from_stream(struct bt_bap_stream *stream)
 static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 {
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
+	/* All confirm callbacks will arrive in the same order as the
+	 * setups were enqueued.
+	 */
+	struct bap_setup *setup = queue_pop_head(req->setups);
 	int fd;
 	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
 	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
@@ -1041,6 +1042,7 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	fd = g_io_channel_unix_get_fd(io);
 
 	queue_remove(bap_data->adapter->bcast_pa_requests, req);
+	queue_destroy(req->setups, NULL);
 	free(req);
 
 	if (bt_bap_stream_set_io(setup->stream, fd)) {
@@ -1273,7 +1275,7 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 {
 	GError *err = NULL;
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_data *data = btd_service_get_user_data(req->data.service);
+	struct bap_data *data = btd_service_get_user_data(req->service);
 	struct bt_iso_base base;
 	struct bt_iso_qos qos;
 
@@ -1317,10 +1319,11 @@ static gboolean big_info_report_cb(GIOChannel *io, GIOCondition cond,
 	 */
 	parse_base(data, &base, &qos, bap_debug);
 
-	service_set_connecting(req->data.service);
+	service_set_connecting(req->service);
 
 	queue_remove(data->adapter->bcast_pa_requests, req);
 	req->io_id = 0;
+	queue_destroy(req->setups, NULL);
 	free(req);
 
 	return FALSE;
@@ -2291,6 +2294,9 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	struct bap_bcast_pa_req *req = new0(struct bap_bcast_pa_req, 1);
 	struct bap_adapter *adapter = data->adapter;
 
+	req->setups = queue_new();
+	queue_push_tail(req->setups, setup);
+
 	/* Timer could be stopped if all other requests were treated.
 	 * Check the state of the timer and turn it on so that this request
 	 * can also be treated.
@@ -2306,7 +2312,6 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	 */
 	req->type = BAP_PA_BIG_SYNC_REQ;
 	req->in_progress = FALSE;
-	req->data.setup = setup;
 	queue_push_tail(adapter->bcast_pa_requests, req);
 }
 
@@ -3037,7 +3042,7 @@ static void bap_detached(struct bt_bap *bap, void *user_data)
 
 static int pa_sync(struct bap_bcast_pa_req *req)
 {
-	struct btd_service *service = req->data.service;
+	struct btd_service *service = req->service;
 	struct bap_data *data = btd_service_get_user_data(service);
 	GError *err = NULL;
 
@@ -3069,11 +3074,19 @@ static int pa_sync(struct bap_bcast_pa_req *req)
 	return 0;
 }
 
+static void setup_refresh_qos(void *data, void *user_data)
+{
+	struct bap_setup *setup = data;
+
+	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+}
+
 static void iso_do_big_sync(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
 	struct bap_bcast_pa_req *req = user_data;
-	struct bap_setup *setup = req->data.setup;
+	/* Only the last setup in the queue will hold the listen io */
+	struct bap_setup *setup = queue_peek_tail(req->setups);
 	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
 	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
 	struct bap_data *data = btd_service_get_user_data(btd_service);
@@ -3109,7 +3122,7 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 	iso_bc_addr.bc_num_bis = 1;
 
 	/* Refresh qos stored in setup */
-	setup->qos = *bt_bap_stream_get_qos(setup->stream);
+	queue_foreach(req->setups, setup_refresh_qos, NULL);
 	/* Set the user requested QOS */
 	memset(&qos, 0, sizeof(qos));
 	qos.bcast.big = setup->qos.bcast.big;
@@ -3151,7 +3164,8 @@ static void iso_do_big_sync(GIOChannel *io, void *user_data)
 static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 {
 	GError *err = NULL;
-	struct bap_setup *setup = req->data.setup;
+	/* Only the last setup in the queue will hold the listen io */
+	struct bap_setup *setup = queue_peek_tail(req->setups);
 	struct bt_bap *bt_bap = bt_bap_stream_get_session(setup->stream);
 	struct btd_service *btd_service = bt_bap_get_user_data(bt_bap);
 	struct bap_data *bap_data = btd_service_get_user_data(btd_service);
@@ -3279,7 +3293,7 @@ static int bap_bcast_probe(struct btd_service *service)
 	req = new0(struct bap_bcast_pa_req, 1);
 	req->type = type;
 	req->in_progress = FALSE;
-	req->data.service = service;
+	req->service = service;
 	queue_push_tail(data->adapter->bcast_pa_requests, req);
 
 	return 0;
@@ -3289,7 +3303,7 @@ static bool match_service(const void *data, const void *match_data)
 {
 	struct bap_bcast_pa_req *req = (struct bap_bcast_pa_req *)data;
 
-	return req->data.service == match_data;
+	return req->service == match_data;
 }
 
 static void bap_bcast_remove(struct btd_service *service)
@@ -3317,6 +3331,7 @@ static void bap_bcast_remove(struct btd_service *service)
 		g_source_remove(req->io_id);
 		req->io_id = 0;
 	}
+	queue_destroy(req->setups, NULL);
 	free(req);
 
 	/* Notify the BASS plugin about the removed session. */
-- 
2.40.1

