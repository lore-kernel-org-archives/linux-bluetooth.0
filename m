Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6D14D704
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 May 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715601028; cv=fail; b=OMqEALCIByTqGttlE2xaGOgVejJKXvbmD5iQzJFX55/zahtoAfHiiOkIMfm2qVYUjCZv1QQIJN24uZeq8xP3yoEld7hgooLq6z6APMRTirs0gFyKxTXfREn3q9xt/Vcq+i0nOZZva6NLz8FHq2boLWeutf0pjFPJ+KNe/Xhb0zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715601028; c=relaxed/simple;
	bh=rGHXUF6HXzm2DejVTpexuIg2rt7QOxRnM2F8LLnm+NQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JGJKAXRjHiHtBQvnQ77Gu/PZNVdfG2NLB0B0dURE/ZK7Tc/iYBM6FvhvBQsppBC4dYm1WaSLMToVeNSeAN5ml35IIN2Kb4mDicPd2Yfl6D5z09tx0noozo/FaJYxm/ER0rFEz0FrGlF9VltRDXtAEKUESKbyAeoSMo0LAyoHjCY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UzySRYsv; arc=fail smtp.client-ip=40.107.20.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UzySRYsv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IStSrOIge1BGpYScOQGoT10U0nNubSWrk/9fLyB5QEV6fyKbA+4/rV7wxA101zR8tnJPGH02ydhk8Lw19lU8bJVrNHNnhjVVlFZAPZo3DE6hLtQ7r0Y6Lo9joeK6EMDoOtCs1aEo6NKPg/JfjN7Xcpy3GMnRz/eF+zdrl41vKnnAuYaXVe5KWs4JUuLkVVZ4dmpNxsveTuD8dRo3uRtK3pYQOCvYLc6V+U/kY0OQ5ljz5WvItYyAdniXbvZ64n1pNPZB1ucaDdxRlvWA+PzIhlL7EhCC1D+e3PjJIBvUP5Okujoi8o0pdQ/rwx7W+PCCeVdAS18ds5kv+xa8BZFI5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hth9E24ASpOH8lm+j5D0wuoj6JPt7ht6aWN2QLtoFJw=;
 b=V4MNvSeNqTkGQxM2HOd14xGuBsWkmYAiovQK3IiKf+HYZIvd0GoJg/yBkMLcyNYLrnfx8eggIKQUWAh9C2pbUQvFVs6ejLm8uQb1B4P2G535ktA5ygcHHlmt7xHg2y/x+9fe3KDQ3vwQDRZ6jN8i+YiRYKFWa2okaowjxinnXrYGhFybbjLbzIIafSvRcpwgiVav1LgHzkKPjerUxkGEaFJicVpr0iBX7fM0uZ59VFshiEHjmBK4fNxWxQ5bprHJWmyR67nKS0OMCXwbGrZK9WIZ5ifH5zEoFUPjl3OR+LzojNZjx5KP+eQVRRXTVa/jTwpjkc1IVS4r3EMP+FOlIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hth9E24ASpOH8lm+j5D0wuoj6JPt7ht6aWN2QLtoFJw=;
 b=UzySRYsvES98qivbJyctiQCCGbDfm/Z1x2+PsQRdcHOGPsokwJNe0nylWDdDJprAH4nSek1lc87b8nFfHnZ4m+B8Ti6chbsBmp/FdQaiRLf1Vjt8rFKwFYGiNt6+Y0hYgsNcvyWlND2V7+IdnQMVBA1P0ViusPyNegbR5MYz6PU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by DB9PR04MB8430.eurprd04.prod.outlook.com (2603:10a6:10:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 11:50:23 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::b7d3:ac7a:a87b:5fbd%7]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 11:50:23 +0000
From: Andrei Istodorescu <andrei.istodorescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	iulia.tanasescu@nxp.com,
	Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ v3 2/2] bap: Create transports for matching BISes
Date: Mon, 13 May 2024 14:50:14 +0300
Message-Id: <20240513115014.36484-3-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240513115014.36484-1-andrei.istodorescu@nxp.com>
References: <20240513115014.36484-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0039.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:658::20) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|DB9PR04MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 77855326-4a92-4d8c-6386-08dc7342df0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TjOh+aL92c7eqR+unbytBmmukxMSQBfIN+FrKxcowHjxkb55AFPx9GrG1peA?=
 =?us-ascii?Q?3wFJfpzod4a3JXkssHkRSyRv6jxUFlXfOwVPAmjeWnVXwDFyf4NkuJJJMbG3?=
 =?us-ascii?Q?tGa6WnMai1xJ1yFyLMHsagtepyTP90az5WSVN8CEpGmjJXTuk+zxwn8t/ptv?=
 =?us-ascii?Q?xHyKZ2nSjXlJBmkGhQUPkj05CIWVH0U0D3Pxvwtr3XDtedILcc/Shrg7nXwb?=
 =?us-ascii?Q?om/clNzYMzpMrQOkzoBy89iMEHQZdSGhVxvB+h0VsknBQEBFHGvBOkhGwGe4?=
 =?us-ascii?Q?Ni25pq+VPV8Ph8kfEieGCR7ljDCSno7R/rwULcnjjwfWtFyl0Qc8QMrFiG3D?=
 =?us-ascii?Q?wcOnRG1VKuCOTWFpmJl5h6RqgXOSTo6ON3hC7cjjG1YjS9nboE6mSXZzCPbR?=
 =?us-ascii?Q?+/xL4SnLRkc7OgOkSMzbcXNIWa08v/Xw3ihv7mXlKgeBZUpmb5lBtQHP5PgQ?=
 =?us-ascii?Q?cNe/FAyFDfIGlaa2m1ZYJBvNhnOOLH68f5WgOoeJCn06CU4oujqVLH/ss3f9?=
 =?us-ascii?Q?j+DFXRFLtGUSWNqNqaA3p0q+EWSST4OnAVj+mpNb3BMCNbEgESjuqOF4JgQL?=
 =?us-ascii?Q?/TS1YxwjhKCpfAu/0wKJOjgMB9nNrKnKHsD44aezpYAHmvJ6VrebqW+vANrd?=
 =?us-ascii?Q?aWkYrLVunjVJ0mIHh/1pTeCYxaiTyHgCXLGZMpKxHgIgztmsInHOP7knHI1H?=
 =?us-ascii?Q?zWLzORWHJwae3+eqTxMN/qiwIfVALUKNaIBaExJ6ZJQNpe418jfXO37N+rcw?=
 =?us-ascii?Q?qSpO07BIePKPP3iURaOKShIzA92S0xhDdpDbcrgmLwgkkO0IXhEjhg/sM4k3?=
 =?us-ascii?Q?JyMPMpOcMY/baTwzLeESE/oNyZGVMTETMsGzriHQnQ7T9WVMfSc2Srh33KV8?=
 =?us-ascii?Q?oUMRrzoLGiw8gqIXJT1FXte+JEZJ424OEvMEKQKHQPS932oKjscXFU2+mwj/?=
 =?us-ascii?Q?6CkP42XgLJE1NxDxArbE12cuD505+HKQSxjktuqW3meUBo0ikTkod09Q8Y+G?=
 =?us-ascii?Q?Y/nNror60X+MtJrdDmrEkP7uj0CWoxkojm/Xw/4HlYL7QRtrw9erNczQMpcC?=
 =?us-ascii?Q?PmBPTuj5blmu9JCaQzXHmdiEzaJ1HtAF4g4FltQ1jrEb+lkGXYmcnjbydC2S?=
 =?us-ascii?Q?E1bYQFKQRyvBdOcgTDVER+bWJZNrPlYS76TAGer7gc0qTepEdLe5dQ6igJ5J?=
 =?us-ascii?Q?UStPBAJJobWc8d0FRGUuOCH51NjXPtbIqrf8d3A0WosuJ8A8ZC/0AOof6bR/?=
 =?us-ascii?Q?7g/ryrPeP7B26sjlGAtqtbfiRPMjJ3bQvbI3JVpiTQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UxDYsCA6Cp2li4kSj7oR3nRhRYCxTYn6tE8lb3kyblej+/rA7hP7opEL2Luj?=
 =?us-ascii?Q?oOHf0xq4+tRcbrRkZahdOFOUb6ry+ABW0DU7UpAw1ca8FoyJoarK1hURU5KS?=
 =?us-ascii?Q?DVPikNiB1RrSxoNRFp714AQnAbHqIgaWxLwgjtP3ejqS4eVWcBi9gZeGnF14?=
 =?us-ascii?Q?WC4He3VXUY7zyXb7vFH1M12kiGEj6MGJ6SKbvxwIqemP2v8N99gvstppgRhA?=
 =?us-ascii?Q?T9hVB0fd5vpLpyPJfY/SEX5qebi0V5XjytG0JY8Kuqv9M+SZWXS0VqpovF8h?=
 =?us-ascii?Q?DhbHYL6xwaArIlwI5s5XpVDqWxGV0WLfNnJRexQg/Ia16Sq5wM8217cvO7S/?=
 =?us-ascii?Q?luGruqc73qmlPrWo8kypD52zC4ipaVzS7XUUEkb/uC+guERTfXdoAbbJze0e?=
 =?us-ascii?Q?MeilnV95EKrHPf6yKZV/8d9aAcDa+oTvgBnji6BxBvH47jOwPnxLgTwDK6rB?=
 =?us-ascii?Q?jLWMHhc0Wa95lsDF3N9JyeE6oxf5OhwKeYlmtKMnOBzqDw1QSuIq8jhL4m/l?=
 =?us-ascii?Q?V05hdVbBCYYryac+CIOLO/Di7Vo9/m35tgb8Sy4K8ov68fxuWUMYQ81mJaHi?=
 =?us-ascii?Q?0jut9FvJS0j8TFn+U40lVh912GD4GxViyGVDphAAZn7AvZb6x8a0OB6v12zU?=
 =?us-ascii?Q?CQzJk/CdWRDL0z5KVobAwrfHbqCFK4hhaJmnn56tfd1x1IzA5QM3c2RsHz9i?=
 =?us-ascii?Q?Yoc+0QC4MU/TG1fWDjAC5ji6Ub4NSpowfLjTi9pedQLOxlEik1KdnTmWG1IT?=
 =?us-ascii?Q?hU+oQ/gJ+c6Nodo6QDGR471Mhc2Bjhi193KP2SdTiKejKk+ZCibWKnJ676NO?=
 =?us-ascii?Q?uaPP/cKLAjegeFkKntu0xsk+jlNuSNTqdeNs+ucqE1dVkgw/DGD26ztk+f9r?=
 =?us-ascii?Q?oNJwvxzlnITYqdbugYUlegzDJLYupBI4keB5PpC+aSPHGn50RvFBHKD4310A?=
 =?us-ascii?Q?TU9MO19PVjIyoM+VYi8lCOCDraOKEFHFXghSUR93l9eGHcbpM55alnF1LUze?=
 =?us-ascii?Q?YmRG6f/34tJ+bURFLFem08e3jqvGX0481edzXS3YHIAP9TfbRxHWCw8Bskz8?=
 =?us-ascii?Q?gmbNbyoB/1gYH2mNtQRj/LL6eBYzR9z8qVs6MaBGc9hDrNqz11g0MkEpzIrD?=
 =?us-ascii?Q?w0iMsFku80hRnITfcA28fcWSfuWZ5pLAt3rQ3RJPcqytJ1SSrEqkmer2mLpc?=
 =?us-ascii?Q?YksmTgjZBHag1FTYVNuz8kO3yJjsj7ZpqRa9o8jQvj1lDnqT+UdWTzqpLCyo?=
 =?us-ascii?Q?mkZvMb/9f0mjrHwkC63ak02U4SF2RDPPxwWrTuXbPj+vm/C9zLTS9urQwFD3?=
 =?us-ascii?Q?W7DC/nSRh93WGTsn2ev/d2Y3x55yRlcPPM1AEfPMjeF+ZvrQP3bBO9yMXZVN?=
 =?us-ascii?Q?Uu8uRMignDlg15rAdstnCfK6oEIS4ts2tFbs3xZZjx+5huHkyXHamiWKdA1j?=
 =?us-ascii?Q?foubaZuh+JuLwmRAaJDtiSX6bsWH312X7pycFhQcKuzhdHfgLK+0cNuoFDlM?=
 =?us-ascii?Q?2wt7zjC9qn8a2WIEKwQvCHQ3eyG19kDRGTqV33E6Uo0sg+Z7ilOSZ1S5zv57?=
 =?us-ascii?Q?O+9bbSqnm+qMoPjsSiyyZbKk+AaCseinOnn4bFB9G16KW19u6Fi918zg/qvb?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77855326-4a92-4d8c-6386-08dc7342df0c
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 11:50:22.9239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hargMIHHHA7ev70CQaLFBwxWyPduVpYniJloAB9+GfhfVXuClKA9VVN8W7K4Jr0wH1mgi4C31tXdUTurUK9FW1LU7moN9wQ5js0bY2CsCo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8430

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
index ff3e36a6fbc2..b943392c96f5 100644
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
+	struct bt_ltv_match match_data;
 
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

