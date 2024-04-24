Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2060.outbound.protection.outlook.com [40.107.105.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3515D5A9
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 14:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713967699; cv=fail; b=rZfrqsO/b0mUyxjWXFI50RqHMuK0A+DWIjW74lH9I9XQWpmEzQW+dRtRNOMcPhBgO5Nd1+MQgBAYVd7/l+DUsSv8pceZZ8KFt0Q0x7EcVIT/lh3DvaNc6HdR20Fm8SwiyyHN8gRuYkAHDAKhcSC7SFqn91y+cLF5zW8xSvBn344=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713967699; c=relaxed/simple;
	bh=VT+0fp2831OFSK4cycQi12UqEOX20k8srZn1wGpCQjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwWhTqtmUKmD1o+ckamaGIGJJ5ka6QGorM+fXBuV6EaOXakpiSeuI1Ua9kBgJi7OUdIj/8NXF3wImEHYgDC5tn+Z7jAIh7IJS0+Qwh/HtSJJceqDQ2n2xofjAxC6r+O+PuTxAKgWDhbB97avkMWlK0EoXz3b40+hIG9a4qssF0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DjkaVfR0; arc=fail smtp.client-ip=40.107.105.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DjkaVfR0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXDLoJBBcEEIg44/xkOq7L8PPHZhuocczSQlqMlj2cRRGMlpMjyKaOwOmnJg876UkW1zDi5SR0PKDpR2/9uyjfq9Bgm1vg5CB+JQONEN8MDvlxjgp7JgZ22tsek7G73wHoahcLuv8XCdcJsF/5aW4eDp6P+miIpCeG5kqKQtUbeoVOjU5BapM8XF9WdmmMfdQyTadv9VcRkxIT0rx74Ol5bsQ+4dR6Z9LCrNsHP0Ffk3qhbWqce5sBrkPgeAFooU4Fb0/dhUTmDmylINjdnhIM4INeOC9nCZBUy9E6qVwrroBiEk3P9tODZ0HIn3RAwzpPYvcrXtXnK1n1GYh1IDdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZtCB9nZStQlg2zOfCk6e+4CLYGlUEDVCz+gJaZ/HGJI=;
 b=HP4MUsX1Bd3Pa9XM89CUWvYz3oV+D/VXtlOgqOUtUOvTvjS1btWYzsSletxSpjr0eWjf5k0EvsUhB2XSHrQZ3k2e0sVSmnVczuY5ohGS0z3YfyAD9CxQ5XlywaHbuFSKQojNJrw7amiuC23fROyp0dokiV1mQoUOJIITo+QSQanueD0qY6x12YTB5xtwVeF43QRb31xRBlPqlDqmkRE+BD6pPVXdvGbxexTAvo5Vk6OfdvCeqnyzOPLwME2DN1eEzqIa0+dm+ob38p9fRrc8oKWU8mdOlnCUkyBDhl0mIjD+4AbuTHLVpNesXdlJezjv6XmF2MX3Dg37azGbSJdxMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtCB9nZStQlg2zOfCk6e+4CLYGlUEDVCz+gJaZ/HGJI=;
 b=DjkaVfR0QRJsxhpQQxGBLgefTRCRDPEhkvS8hhKSBSzzpEFInB5pbl1QHqhaqEzhJzUOuTSjZvvUMoxhq4JdOLeA9DK33EaVs0elcwgRRoF26c82LyYcj07AbfBG88T8vHIAlYFZD+hL4DqYhrk+baDPMxUF4DW6HPtZdmVAoW0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com (2603:10a6:20b:2b::17)
 by DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 14:08:13 +0000
Received: from AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439]) by AM6PR04MB5384.eurprd04.prod.outlook.com
 ([fe80::ab73:5047:a22:9439%4]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 14:08:13 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: claudia.rosu@nxp.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v2 2/4] bap: Replace adapter in bap_data with bap_adapter
Date: Wed, 24 Apr 2024 17:07:39 +0300
Message-Id: <20240424140741.73899-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
References: <20240424140741.73899-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0026.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::9) To AM6PR04MB5384.eurprd04.prod.outlook.com
 (2603:10a6:20b:2b::17)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5384:EE_|DU2PR04MB8582:EE_
X-MS-Office365-Filtering-Correlation-Id: 87bde5e4-45e8-4ef3-780e-08dc6467fada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zpH54ZhK6vLBI6J+QPRSsfj8+3NIZc84vov/tiMpHiR/bQcSsOM10/N454K0?=
 =?us-ascii?Q?25uuR1FcxitUfD9RbF13oYvQyCjpFC7t3bk7n8WanYLBQB8us1u1xDpVkW/c?=
 =?us-ascii?Q?idt7l2/nWOS4We2mH3vQGBNZROkSQcw4ZgUiTrEopYHvMrGsH3Qm1WIYNZax?=
 =?us-ascii?Q?hU+PMaZ3f6T4OdaCOrsirYp/T6pa2Vqw+YJgORtjRqLou6Y0kuFIrEIlEtQc?=
 =?us-ascii?Q?BPn7XwBUYIyGc9j7DkYbdbOYTMbK3h7Vro/ZMHu6iqTKbkegMElWO7hcIJBo?=
 =?us-ascii?Q?/93oD0h/gI6nWND4y2v0u+xuD5v8ctFW191QmHzRMgVK3wqiXCMQ+LKp33i9?=
 =?us-ascii?Q?vxaRqNOrzglXYq94URY3VskMkTyAcrZzacGLmE1/WcRxzWWDXXC9DF4bPYB3?=
 =?us-ascii?Q?WJjxFKqtWgMIwgJjXHZUhSuvRtZl6hsj8kK7G8B4KI3uW4FOGB40pEn301gv?=
 =?us-ascii?Q?rSgBtrFdjzrcZsRTFP50oXfEtEJ74+eXpVjha77+owwAHidbjGS3PMPFXWtq?=
 =?us-ascii?Q?JbLh9NbsVBahIuaVaHVwctYSc4tMD7fvs3VDgXmQPynSuyrAmnJ+NZbI5vnl?=
 =?us-ascii?Q?7gI+k377N5SyfkG68LN4YYzxchlMr5+d7jpnh3IDDu3VejniDBMr81awzpAp?=
 =?us-ascii?Q?84IhVVzDbcWQfqmPAVXc+1pnrsPpTBp3cto5mGFyKaPAs8wnNQnqGgENUZDP?=
 =?us-ascii?Q?QtmU9KfMpcFgeB2fW7HuNPFfxL0ZOnsUqFEO0PZXcwaTaiQiOj8TV9uarsch?=
 =?us-ascii?Q?Tcui6k7aOafXcMAD+IKHgOUGwuGxL07cmaAdmZLkSjQ5eWU9Pm+d9Ifjvhzb?=
 =?us-ascii?Q?tWHlp4rvyA469FF652gsOEWFSJAq0IHVXemfhKQenEqm+/+RS9K1KOIbsfev?=
 =?us-ascii?Q?sIBGgQRsDyQXdtXUYdWS8lnUVo5yWPQXSZL01/cndX1KfYxCrGgeCJ/hGtX6?=
 =?us-ascii?Q?fRZvQWXEHaSnwg8PvmNdj10LaicyBb0QWaonBH7srJh9w4b9WgTNq1Z737Tn?=
 =?us-ascii?Q?EjcTJ71qhSqOEKQY4ERvYgnmY1Uyhn9WSJGEfJigXEvYfvpm7P5eygbieLYQ?=
 =?us-ascii?Q?alkx6aOfDUIu6Y5yyVqcgzPH4slDlFCFwhejqKUPr7ycHWXLt9YSUBb/jxtL?=
 =?us-ascii?Q?Gy04gnniVHPWW2uGTp0o0VMaZ1crCcoMQxrmC7csG6GMZ4X2JeAaiR4QSWts?=
 =?us-ascii?Q?apjR+J6xOZD9qfecakxe4YvcxBlT3/993jePR+swDu7h0fdUKbDdsLwomhk8?=
 =?us-ascii?Q?P/UTDLaWq4Ja9TU3GguUq2foYtYCaJ0wevd18ZNGM5512cJOVuOVAEIw49il?=
 =?us-ascii?Q?sd22p/Knf8Jmp1Y4DtsmUwOaG/chQPhF4ivqz/KF4aa3Yg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5384.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+GY/5WaNv/SfyWQmkVytzBhvwxfh+756GfxbZOTyGO30RbzvNHHfoqVwqTy?=
 =?us-ascii?Q?/aNfLJJpdabgB00f2PZ0JE2qLePF8PeVrUpPGdvzhlwXAb3HXGo0dwwil67d?=
 =?us-ascii?Q?XEbMvXd2v3sf35PC5Z/Nkkw9/Oi+UWAkEqIKuilIUHMcrz7buLDToG/UiIr7?=
 =?us-ascii?Q?LsO2far2f1d3KXV9qXq9cELZLxN5ryw9eESMXkdAUnw/85aTvuA5KgA7dP0r?=
 =?us-ascii?Q?1ZMxQAoTnt5LzjVlUgZuPUVxyK7y5X9LKXzILiIRPsZsse4dCxgqviDT6qe5?=
 =?us-ascii?Q?RC8vMD9+sL0DCYrQxus9QHYy2Yf5T5Di8m+WyPFn8Q/aSYwLuyBJRIV1IuB5?=
 =?us-ascii?Q?kcT5hWaT/qdhUQcwher95JwKwZMKhOMUZz16oqyEpmi1/OWfbaDJjY0593tK?=
 =?us-ascii?Q?Em987C60Ip+Njx3omeHiZnDTjk8CPzIJWRJfPEwEs5+3d4YMOAsPGo8j8DCF?=
 =?us-ascii?Q?j+EEPZjsG5+KOzOxUYY1T721uyKNidmvKFFOhMkDuZxuyE15Itwn2pNDS+L3?=
 =?us-ascii?Q?hkP/gmAGh5vJZ8UAXy8kY/W/No5xHg2msg0XFlzrlDah41MbtVag3I0Q9JAM?=
 =?us-ascii?Q?GXqk0ZxlnWEwPOIbG88/lfaYppNS4YStvqRrDiNPhza6yEcPiWIIJ61vNxh+?=
 =?us-ascii?Q?z7EXXVrDWMGU+f2G62nOJE3RrdNBc4KgD5uB0kuFC7DKqzL8F4/lYJ+13gfL?=
 =?us-ascii?Q?4pmrOuRnXfU0V+RMd9wKi7UjOAVA2+e7ZtfCveqdhn9osj7B16myFVMxWdFb?=
 =?us-ascii?Q?1zMmgWHH5jukrJKIkpfXQ925bLaWiBSTt5O949Bj5HZLlW4gsJqWMMIYMPxy?=
 =?us-ascii?Q?RHrw7GlfJa1NhFlWoUySCMwB02v/qFfpHzBFsd1VHjiuw137RP+WRFN+0vEt?=
 =?us-ascii?Q?XMkKfv4V0qxNvYatUZDmQQNeZCZ7z7u5Sj+N4DvE98nNsydXQWB1XgV0txW9?=
 =?us-ascii?Q?yg+Q1ZW+5V/z2+qdYXQhsqVB6NNLh3JpVLjx18brclOCP6KcmLgPPfOK1KP7?=
 =?us-ascii?Q?9/wXxgteunhzXm6e44JbjvNnG96xgk+ZbDOt40j4jJPK3CfHC4sKrmJgoiTB?=
 =?us-ascii?Q?pdf7UdsXVW0Y3kKSlvtv/0yjh15967t7i4wIuZy1vOf5RNXSD9hkufPnED+h?=
 =?us-ascii?Q?P7GBkh1ajpWfvMhyUh+U/2cC3XP2frK5kPpYyZnYBWt9Q4tHwfPEwB4c9pNN?=
 =?us-ascii?Q?1lfTTGN50yU6yzTOSWlj5c3L6ZAEIEqXpq0Lz/4jKdP29SbykDfqwsHV1B27?=
 =?us-ascii?Q?DPFK3aJEsdqS1FRoo0T+I6KYRcnxdXDWgftxELPQxwnhn7f+aHButxMPiIZO?=
 =?us-ascii?Q?lwskQhFIqJVRnZr6eIvfVgUvwKP1A1G8IRcINQrgMLqWh7xK/4U1LwI00OUH?=
 =?us-ascii?Q?/E5M+jCJQPKOeyZioK4UfXzhZQnywXKgk/+mJ17XDtMiO0D9D5ic6c/1edDu?=
 =?us-ascii?Q?uwS5d7ltBue/jsxuos2r6rFXbbJf/thbA12KjLxx9si420ptoLXkW2UQjiyk?=
 =?us-ascii?Q?pPi2ZdTDMArZVpd6m4BG22JSoaF5PnZSNAlRNzYuIqASUIX655AFxGzt6qnA?=
 =?us-ascii?Q?Ky3Y84uNYn7veQwfn4HYW0aG4AgBX8YIOd6W4d2q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87bde5e4-45e8-4ef3-780e-08dc6467fada
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5384.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 14:08:13.4379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfKdWyRvRClpWJaamr9exAQCmvV20Qe8kVF9XBQxlmp4H4nJmJgDtcBC3tG8ZhpSQmr9QCXq4E96s15zx8niZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8582

This patch introduces the bap_adapter structure. In addition to btd_adapter
it also holds the pa_timer_id and the bcast_pa_requests queue associated
with that adapter. This enables convenient access to these variables since
the functions that need them already utilize bap_data.

For each adapter a new instance of bap_adapter is created and inserted into
the global queue, bap_adapters.

For each scanned source bap_bcast_probe searches the bap_adapters queue
based on the adapter and stores the result in the bap_data associated
with the source. Operations made on the old global queue are now made
on bap_data->bap_adapter->bcast_pa_requests queue.

While this commit sought to utilize the already existing bap_data in order
to avoid searching in queues, a lookup was still necessary in
bap_bcast_probe. Here, the bap_data for the scanned devices is created and
the bap_adapter field must be set to the appropriate value. There is no way
of getting the correct bap_adapter refference without searching the
bap_adapters queue.
---
 profiles/audio/bap.c | 100 ++++++++++++++++++++++++++++---------------
 1 file changed, 66 insertions(+), 34 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 9e93906ca..d8cd05f26 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -98,9 +98,15 @@ struct bap_ep {
 	struct queue *setups;
 };
 
+struct bap_adapter {
+	struct btd_adapter *adapter;
+	unsigned int pa_timer_id;
+	struct queue *bcast_pa_requests;
+};
+
 struct bap_data {
 	struct btd_device *device;
-	struct btd_adapter *adapter;
+	struct bap_adapter *bap_adapter;
 	struct btd_service *service;
 	struct bt_bap *bap;
 	unsigned int ready_id;
@@ -130,8 +136,7 @@ struct bap_bcast_pa_req {
 };
 
 static struct queue *sessions;
-static struct queue *bcast_pa_requests;
-static unsigned int pa_timer_id;
+static struct queue *bap_adapters;
 
 /* Structure holding the parameters for Periodic Advertisement create sync.
  * The full QOS is populated at the time the user selects and endpoint and
@@ -366,7 +371,7 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	const char *path;
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter);
+		path = adapter_get_path(ep->data->bap_adapter->adapter);
 	else
 		path = device_get_path(ep->data->device);
 
@@ -993,7 +998,7 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 	DBG("BIG Sync completed");
 
-	queue_remove(bcast_pa_requests, req);
+	queue_remove(setup->ep->data->bap_adapter->bcast_pa_requests, req);
 
 	/* This device is no longer needed */
 	btd_service_connecting_complete(setup->ep->data->service, 0);
@@ -1150,8 +1155,8 @@ static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 	g_io_channel_unref(data->listen_io);
 	g_io_channel_shutdown(io, TRUE, NULL);
 	data->listen_io = NULL;
-	queue_remove(bcast_pa_requests, pa_req);
-
+	queue_remove(data->bap_adapter->bcast_pa_requests, pa_req);
+	free(pa_req);
 	/* Analyze received BASE data and create remote media endpoints for each
 	 * BIS matching our capabilities
 	 */
@@ -1209,7 +1214,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 					struct bt_bap_pac *lpac,
 					struct bt_bap_pac *rpac)
 {
-	struct btd_adapter *adapter = data->adapter;
+	struct btd_adapter *adapter = data->bap_adapter->adapter;
 	struct btd_device *device = data->device;
 	struct bap_ep *ep;
 	struct queue *queue;
@@ -2062,14 +2067,15 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req);
 
 static gboolean pa_idle_timer(gpointer user_data)
 {
-	struct bap_bcast_pa_req *req = user_data;
+	struct bap_adapter *bap_adapter = user_data;
+	struct bap_bcast_pa_req *req;
 	bool in_progress = FALSE;
 
 	/* Handle timer if no request is in progress */
-	queue_foreach(bcast_pa_requests, check_pa_req_in_progress,
+	queue_foreach(bap_adapter->bcast_pa_requests, check_pa_req_in_progress,
 			&in_progress);
 	if (in_progress == FALSE) {
-		req = queue_peek_head(bcast_pa_requests);
+		req = queue_peek_head(bap_adapter->bcast_pa_requests);
 		if (req != NULL)
 			switch (req->type) {
 			case BAP_PA_SHORT_REQ:
@@ -2090,6 +2096,7 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 					struct bap_setup *setup)
 {
 	struct bap_bcast_pa_req *pa_req = new0(struct bap_bcast_pa_req, 1);
+	struct bap_adapter *bap_adapter = data->bap_adapter;
 
 	/* Add this request to the PA queue.
 	 * We don't need to check the queue here and the timer, as we cannot
@@ -2098,7 +2105,7 @@ static void setup_accept_io_broadcast(struct bap_data *data,
 	pa_req->type = BAP_PA_BIG_SYNC_REQ;
 	pa_req->in_progress = FALSE;
 	pa_req->data.setup = setup;
-	queue_push_tail(bcast_pa_requests, pa_req);
+	queue_push_tail(bap_adapter->bcast_pa_requests, pa_req);
 }
 
 static void setup_create_ucast_io(struct bap_data *data,
@@ -2779,18 +2786,18 @@ static int short_lived_pa_sync(struct bap_bcast_pa_req *req)
 	DBG("Create PA sync with this source");
 	req->in_progress = TRUE;
 	data->listen_io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, req,
-			NULL, &err,
-			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(data->adapter),
-			BT_IO_OPT_SOURCE_TYPE,
-			btd_adapter_get_address_type(data->adapter),
-			BT_IO_OPT_DEST_BDADDR,
-			device_get_address(data->device),
-			BT_IO_OPT_DEST_TYPE,
-			btd_device_get_bdaddr_type(data->device),
-			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-			BT_IO_OPT_QOS, &bap_sink_pa_qos,
-			BT_IO_OPT_INVALID);
+		NULL, &err,
+		BT_IO_OPT_SOURCE_BDADDR,
+		btd_adapter_get_address(data->bap_adapter->adapter),
+		BT_IO_OPT_SOURCE_TYPE,
+		btd_adapter_get_address_type(data->bap_adapter->adapter),
+		BT_IO_OPT_DEST_BDADDR,
+		device_get_address(data->device),
+		BT_IO_OPT_DEST_TYPE,
+		btd_device_get_bdaddr_type(data->device),
+		BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+		BT_IO_OPT_QOS, &bap_sink_pa_qos,
+		BT_IO_OPT_INVALID);
 	if (!data->listen_io) {
 		error("%s", err->message);
 		g_error_free(err);
@@ -2877,7 +2884,7 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 	setup->io = bt_io_listen(NULL, iso_do_big_sync, req,
 			NULL, &err,
 			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(data->adapter),
+			btd_adapter_get_address(data->bap_adapter->adapter),
 			BT_IO_OPT_DEST_BDADDR,
 			device_get_address(data->device),
 			BT_IO_OPT_DEST_TYPE,
@@ -2891,11 +2898,20 @@ static void pa_and_big_sync(struct bap_bcast_pa_req *req)
 	}
 }
 
+static bool match_bap_adapter(const void *data, const void *match_data)
+{
+	struct bap_adapter *bap_adapter = (struct bap_adapter *)data;
+
+	return bap_adapter->adapter == match_data;
+}
+
 static int bap_bcast_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct btd_adapter *adapter = device_get_adapter(device);
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
+	struct bap_adapter *bap_adapter = queue_find(bap_adapters,
+						match_bap_adapter, adapter);
 	struct bap_bcast_pa_req *pa_req =
 			new0(struct bap_bcast_pa_req, 1);
 	struct bap_data *data;
@@ -2907,7 +2923,7 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	data = bap_data_new(device);
 	data->service = service;
-	data->adapter = adapter;
+	data->bap_adapter = bap_adapter;
 	data->device = device;
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 			btd_gatt_database_get_db(database));
@@ -2933,12 +2949,10 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	/* First time initialize the queue and start the idle timer */
-	if (bcast_pa_requests == NULL) {
-		bcast_pa_requests = queue_new();
-		pa_timer_id = g_timeout_add_seconds(PA_IDLE_TIMEOUT,
-					pa_idle_timer, NULL);
-	}
+	/* Start the PA timer if it hasn't been started yet */
+	if (bap_adapter->pa_timer_id == 0)
+		bap_adapter->pa_timer_id = g_timeout_add_seconds(
+		PA_IDLE_TIMEOUT, pa_idle_timer, bap_adapter);
 
 	/* Enqueue this device advertisement so that we can do short-lived
 	 */
@@ -2946,7 +2960,7 @@ static int bap_bcast_probe(struct btd_service *service)
 	pa_req->type = BAP_PA_SHORT_REQ;
 	pa_req->in_progress = FALSE;
 	pa_req->data.service = service;
-	queue_push_tail(bcast_pa_requests, pa_req);
+	queue_push_tail(bap_adapter->bcast_pa_requests, pa_req);
 
 	return 0;
 }
@@ -3067,6 +3081,7 @@ static int bap_adapter_probe(struct btd_profile *p,
 {
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data;
+	struct bap_adapter *bap_adapter;
 	char addr[18];
 
 	ba2str(btd_adapter_get_address(adapter), addr);
@@ -3078,7 +3093,6 @@ static int bap_adapter_probe(struct btd_profile *p,
 	}
 
 	data = bap_data_new(NULL);
-	data->adapter = adapter;
 
 	data->bap = bt_bap_new(btd_gatt_database_get_db(database),
 					btd_gatt_database_get_db(database));
@@ -3102,6 +3116,15 @@ static int bap_adapter_probe(struct btd_profile *p,
 
 	bt_bap_set_user_data(data->bap, adapter);
 	bap_data_set_user_data(data, adapter);
+
+	bap_adapter = new0(struct bap_adapter, 1);
+	bap_adapter->adapter = adapter;
+	data->bap_adapter = bap_adapter;
+
+	if (bap_adapters == NULL)
+		bap_adapters = queue_new();
+	bap_adapter->bcast_pa_requests = queue_new();
+	queue_push_tail(bap_adapters, bap_adapter);
 	return 0;
 }
 
@@ -3115,6 +3138,15 @@ static void bap_adapter_remove(struct btd_profile *p,
 	ba2str(btd_adapter_get_address(adapter), addr);
 	DBG("%s", addr);
 
+	queue_destroy(data->bap_adapter->bcast_pa_requests, free);
+	queue_remove(bap_adapters, data->bap_adapter);
+	free(data->bap_adapter);
+
+	if (queue_isempty(bap_adapters)) {
+		queue_destroy(bap_adapters, NULL);
+		bap_adapters = NULL;
+	}
+
 	if (!data) {
 		error("BAP service not handled by profile");
 		return;
-- 
2.40.1

