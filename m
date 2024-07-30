Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D531A2C28
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348614; cv=fail; b=dK8mVcMSFwCc49oQmkU2f4LcMvy1If5coOKNxOO0+3EJ3f2JkKkB7v2Z7pBlBSe4rk9umr/3s7MQR8jExl5A88Ed+FBdKNVkd3LCVdK5N+lLVAR9ALFvZ4sUQ9H4M61nL9kcv+R3sfvOLpFHHkyu5bivIVRNlGk5iPFrmYnDaSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348614; c=relaxed/simple;
	bh=czaSDfnJVKCrrkGXMQAvEltIA7s3kIsEDsFBSbxx2B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KpDQ0NCToTfXDPVWZp9KXIyaDk25nJK6Z4mSo78/2qw23BLgjum7OcM19yYRqBc7p/OGdikqYUNoxPChslIezGslbiWnCaxWvpg1aF5lMSQPYFir/Oeg7IkotKdy/9oio1nISohEXuUfUAyjhmqwoPUszuRMDC9Myn1jXLdB05U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=GndSF2dE; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="GndSF2dE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nrwj+spFX39xHbkwMHnJvOZnoPRmUd0RAK2UfTOSTqgVrqkpLjj0Tw7xBjKM6Q3ReBA9W9OXTKz7flW0DMkA5K56iMb1zEd/lLUWEjHQ9f2bX4mmR1w0okmjhnEUDc2mZ946k0xetVw6Ydzw5Ts+CncBJ4pDqCCuoAXvRNuJ+K/gz4lSsGL0aqwoiO+fU62u9KdSCowARkH8ZPRGET789WfUBCERiiOUiPEAG9sGM7a6xqiXlrbA0dGApJRoPRdyWtiqgc7gmKcce+SpPHgE3HW0jr6BeX+91CyXsCIVzP0QNwIrW4kf54wmGyQ1Scd6o+X8YN1SX4W1Gc7okxeOMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=bpUQSSuVd34C5wZlIAUG+75CVh/4JUZaw6l/S5uiS/Qzf1dbCBtZSjD0jxhMQn120n/vgn0DVupoedyoWnHAj5+8RZ7M2tuf3/nuo/UZy4GyM8nOaQqFFB0Jbj0TymtNmE0TNvRYM/qkOCrRue+oydnhmbBSc6NIagIs54FC3oiATKeFhdl9aLXvaKxeVYNGSlaAsY7/XvgCEK8Y+N+N7cjc50OGJVtAbZgr6VWWwtYzbKRiuEjV3Pf1brs9gxd3pQXN+kQZL3RoJY2urB3psZvY3CVCoCDfQhXCGqtWDxnC1mAVDpWp0gHgChWlISXBOVogVSQCaZ2BaISK+BeNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=GndSF2dEmdipHyIzxN1Y5JI1ix/IiKkR6ngmQKZOqA+o3U1Rp/thQLYOKoJ13odjniVw7s4WIww7NFMagNcEi/8a28z1WawyagfM/hBLEOVEjPuOO7O1ObkT+h4bfBNFDAC74apR2sFkbZmmee+OvBFXalulgBG0V0U/oOExezkAnkOpLfX0fPlXG8rXZ+BUyJ8MpziZmE9hEUVzUPm3PBrsEPdbPlundiHHLmJgjpmyMC502Yv3+mqnQBLwqjR0kT+w3pxqXpA2LV7ozu0x7H+5VmBFTmm5irFPDziuZmQcRKYiAWPesTQRK2lk0ACELJ+mHwU2FrxrXTg8aDmlmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DBBPR04MB8026.eurprd04.prod.outlook.com (2603:10a6:10:1ed::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Tue, 30 Jul
 2024 14:10:07 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 14:10:07 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v4 2/8] transport: Add 'broadcasting' state
Date: Tue, 30 Jul 2024 17:09:41 +0300
Message-Id: <20240730140947.411655-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
References: <20240730140947.411655-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0014.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::14) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DBBPR04MB8026:EE_
X-MS-Office365-Filtering-Correlation-Id: a7c3e390-5a4b-4df6-0fb6-08dcb0a1510a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?x7lkZ1hwvn6WYaKhaB7X7Qy1aifFENxYSNx6GP/DkKbwYPmwdhYfsSboVFcW?=
 =?us-ascii?Q?dws7sKgCoWjzFHjs7PpjSooMDB5UFL9cru3Ao9H7tnAxfgdYboZBhO7cDvvQ?=
 =?us-ascii?Q?mIHUtCQMQwQNcPEGeLIRV1FRVk+CCJfZp05CEYKCUDFjtIbsGUavDmXqlaxr?=
 =?us-ascii?Q?DwoBIzNtDiKZFe0y5O58sX4FGoiG5OXzlPZIoZqjmpehM0x5EAwCld5zRvfj?=
 =?us-ascii?Q?A3Dgzb7rxU+gfdy9cLdkSuneQ1G7fmznvLbjs5ftb2OsEOhOf6PTIdJhnIfd?=
 =?us-ascii?Q?SVj0AtxgvxoVu245ADyAtNWX1nCpgEacvgDVKkTAeyPlXDbEqNWK/v3FtEhz?=
 =?us-ascii?Q?urAl9iV60w+Fk1ZxvZMa6p8Z/Vqy8BDv9er7BehC/czJbBmr7Iz4VhSoGWYw?=
 =?us-ascii?Q?tw1AmcAngBgvy7z84ZmqFoj5/KumkDElE4QMTdlaZfDNWk85uJuaRVPacPal?=
 =?us-ascii?Q?hEJAucDdJAQikjGr8zSXUVQc11Q/7qiFgLepiiRED5T24wJht45Zq+VeFQOi?=
 =?us-ascii?Q?pm+qzXBjeToRx3zdWlMqDncj5empMjkJULgtbrywjhdZ6EqTm65HVwGTiNhj?=
 =?us-ascii?Q?go4sN0fftrGS9z+5VD6YVJNRzzKJGoBIDqQIivmF9xMUE0Vsl+q+dabzQCjk?=
 =?us-ascii?Q?lDzHAAmbsuwOnwyPWCSLJZjC5UsUEuGhooRqPYQsi0q7ZE3AZxWAP2jLT61d?=
 =?us-ascii?Q?kBxOvIsw8wSgG9JbsI7DyAs+tGQ3q0zorQAr1od8+wMU3rL7heXQyK1q0YOk?=
 =?us-ascii?Q?54T1yPBUzLqgTZL+Y1RFqDCFqTELeDmLab61Ie1WjUvXRXrs2arfk0bO8yFS?=
 =?us-ascii?Q?g4KffrX+Wg8avFPBu1vhxZddNcRz1FOYnn0UZWOlLuLbqg7FvNvvvGI+g5e5?=
 =?us-ascii?Q?F41HanxXXaOfiUcVbBikVv/zj33u9XNT4I+BYSJZIbAX5vAlg1aCooLSBAhe?=
 =?us-ascii?Q?GaRfUECiKGxySLc02nZ0lbDsq40CXQFI5EI3tx5c2ewuekQ52HxtfccH6qJO?=
 =?us-ascii?Q?eziAEeT/qmZiAc2KRUULUTi5jbu/9f8zTzNP05OtVA/F+9CiBMLKQsvdakV0?=
 =?us-ascii?Q?Eyissp4BBgnkvZQBw8+5Pqq+DFTzb++wjp29YQACs7yPAgymFDSNyyxlzI9h?=
 =?us-ascii?Q?zalzx20/dyamYnApZDAe4NR3MBMSb2wIlRlXlwjdsCcrJY9B9mRd27KUl5cs?=
 =?us-ascii?Q?Oqk6WrapHjhnP8IYutepgsrDNUYaqKQWU8EMSsBkHAiDIuB0ScWEyAZZ6Toa?=
 =?us-ascii?Q?UErADuUqOvTDPm+FjjIPMOowFVwUZ//6A0EwTD/LMcM4knjCnrbBnAGL/SsH?=
 =?us-ascii?Q?5R3RaxHk9uLkGEXV+S0/L25/SgJsSsr2ytcycsMZ1EvPIKgW+u3N+4FdLeXZ?=
 =?us-ascii?Q?Fy3sK4IF8IrfrX867zgLuST7j4hPZtfNm67FdPYTEJrtUcPnWA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Y0s8kUZl0IzNcO8p8AtvJSML/TmOtia0xhY1Hwjp1s6Hkd3Gqsf8fdBFX+pM?=
 =?us-ascii?Q?efyvnRkjD4co0hE/s7ip3f0R56yVpOv9ZeKkeCBfwxulMfM7Oszw40YVuZSk?=
 =?us-ascii?Q?MsEiUSrqMM7CvWCzkJSgKuKrrTz/gPpvdY7Rfa7NQmJ0URiBa3AUWDYE1B6s?=
 =?us-ascii?Q?Ds1fvwDxdYAfnXBc9SkAttmiIMHTgskhB3rSDRmHZCZYJZp4YBh89Q8LP7TM?=
 =?us-ascii?Q?y72cQR3HirsdN57JGuW90jQnEcwIlhuatz82irmvhCDhlDmhaiwQJ4FAELm5?=
 =?us-ascii?Q?xEl2AokGoYm8S7w/rpA3hTpMxOzLzkhTIKu65fL+Ilck8hHRywwZs/MLr/eB?=
 =?us-ascii?Q?IsGkRhpzDAUudx5vW0MvfE7YvC2K04x8o7wxCLWYV61RVHyH6V4Y0HKtuWKJ?=
 =?us-ascii?Q?Pu3OL8LcN0DuKXm3Wijgnae4Y5F1JGz3+IpfTcslQwapXwjI01ilRALSvdj9?=
 =?us-ascii?Q?A1+JlZgEboLksNnzwJfWSXFrfkLnuRn3wNrOzKUk9dP8BoDG7P3QWffVm3oO?=
 =?us-ascii?Q?ZSLX7DLxBGd/DvS+dgDIErz1jaDmAfbiP7U1VWkJsJffteFgfs2yww3zV8Co?=
 =?us-ascii?Q?1BKvIb7Oy3BmMMnB9D4WQtvK5RB5eFQb++VJrmf4oyBLjCvHuXwhvfbLBbHb?=
 =?us-ascii?Q?YzvVEbxBd52551g25DwNrbrXDto372Z7+ZH4m26B/Crz2xqNZ52OCGLQq/Wi?=
 =?us-ascii?Q?gX4HN9IQaeujuaLhW6WX+t+zPkp8t2Xm/Y+6kJV66nQWR2/aRkJ4aD6JxqrJ?=
 =?us-ascii?Q?qd/icfKHlaaqdCKFVzI7mgoXWi4qm+YTSuT6qymZHFxXV823zJvf0OTW/bpI?=
 =?us-ascii?Q?d7GBMwk1vFPdbPI3zSwsoytX8u/9oX3IUPjZOtB6fB1dn91nvLzmIV4Yd0vU?=
 =?us-ascii?Q?xTVAQRyNU8oQ8CKjnzEPzB4FgeNx9e9EHMkmibVrs6cwB3qeLei531N+Uokc?=
 =?us-ascii?Q?FKdqcgvPWAfUO2aIT2eb/n/n1szyRw10XEsniLk517ienxopoxkyppIMfnEh?=
 =?us-ascii?Q?tH7FTeMrBoA9tDlHvDRQ4V5YmYVama5GXJGPce7Mbc3+3Kt3JLU6tn9o3dUK?=
 =?us-ascii?Q?+VGCrN1p2VRWUdcFe1vaf8ySlbZ2koqYsGHc7yDQMziFjHs+6xCJ931QtBDN?=
 =?us-ascii?Q?dGKLhXPf7E2yosUmvRO5zkOH5tpLIWO3Nps7h2moHoFVFhg/tVbmT2I5yh1F?=
 =?us-ascii?Q?/b2xABb4z7NN1hDoZ/U/c8kxhzcJzG6QF8HdmIjDFuSc4BqbKMaIFyMIsfCt?=
 =?us-ascii?Q?dOUrBcc17gp0O3dnJ/81mRlQOcXx+gCCCQmzod+WWzx6KtuCsv7B1itvuJP2?=
 =?us-ascii?Q?rTt4YfNn3yhaAWJfJ7DqmFcZRzggsg3ba8OJ7BZOBlcUUIDiqh2r86RCuUwb?=
 =?us-ascii?Q?wHuWkxPmvKhnEXyMf1+n/7Ql5hhNthSKEbmYi47cpGDj7oKDa2/v5G5EP2tC?=
 =?us-ascii?Q?rxIN4CBUD448rF9PjA2B7nHZYlAwWblSCw8m0O91aO0tqvDES/5qnqdXt29B?=
 =?us-ascii?Q?1MM5Fkj8l6evrh1M6Cq4D0WM42TJHN9gmM4gdy7zRhH8we3LYrBinSrsBity?=
 =?us-ascii?Q?Ftuj7inoNINNUYHQxWMTW47ZRJW+OkIHgBDBRQ9c?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c3e390-5a4b-4df6-0fb6-08dcb0a1510a
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:10:07.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvQqG6+2LY53tikufnvUJiZrsmUvs0uSHROWYDVvg75eSJWwaNJyejCWhFyMAjPXE6EmVoolu2gzZvok/X9+EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8026

This adds a new state for transports created by the Broadcast
Sink device as a result of scanning a Broadcast Source. Such
transports will remain  in the 'idle' state until the user
selects them using 'transport.select', at which point they will
be moved to 'broadcasting'.
---
 profiles/audio/transport.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 922911cf3..0a890c0ac 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -51,6 +51,10 @@
 typedef enum {
 	TRANSPORT_STATE_IDLE,		/* Not acquired and suspended */
 	TRANSPORT_STATE_PENDING,	/* Playing but not acquired */
+	/* Playing but not acquired, applicable only for transports
+	 * created by a broadcast sink
+	 */
+	TRANSPORT_STATE_BROADCASTING,
 	TRANSPORT_STATE_REQUESTING,	/* Acquire in progress */
 	TRANSPORT_STATE_ACTIVE,		/* Acquired and playing */
 	TRANSPORT_STATE_SUSPENDING,     /* Release in progress */
@@ -59,6 +63,7 @@ typedef enum {
 static const char *str_state[] = {
 	"TRANSPORT_STATE_IDLE",
 	"TRANSPORT_STATE_PENDING",
+	"TRANSPORT_STATE_BROADCASTING",
 	"TRANSPORT_STATE_REQUESTING",
 	"TRANSPORT_STATE_ACTIVE",
 	"TRANSPORT_STATE_SUSPENDING",
@@ -139,6 +144,8 @@ static const char *state2str(transport_state_t state)
 		return "idle";
 	case TRANSPORT_STATE_PENDING:
 		return "pending";
+	case TRANSPORT_STATE_BROADCASTING:
+		return "broadcasting";
 	case TRANSPORT_STATE_ACTIVE:
 	case TRANSPORT_STATE_SUSPENDING:
 		return "active";
@@ -152,6 +159,7 @@ static gboolean state_in_use(transport_state_t state)
 	switch (state) {
 	case TRANSPORT_STATE_IDLE:
 	case TRANSPORT_STATE_PENDING:
+	case TRANSPORT_STATE_BROADCASTING:
 		return FALSE;
 	case TRANSPORT_STATE_REQUESTING:
 	case TRANSPORT_STATE_ACTIVE:
@@ -679,7 +687,8 @@ static DBusMessage *try_acquire(DBusConnection *conn, DBusMessage *msg,
 	if (transport->state >= TRANSPORT_STATE_REQUESTING)
 		return btd_error_not_authorized(msg);
 
-	if (transport->state != TRANSPORT_STATE_PENDING)
+	if ((transport->state != TRANSPORT_STATE_PENDING) &&
+		(transport->state != TRANSPORT_STATE_BROADCASTING))
 		return btd_error_not_available(msg);
 
 	owner = media_owner_create(msg);
@@ -1281,7 +1290,8 @@ static void transport_update_playing(struct media_transport *transport,
 					str_state[transport->state], playing);
 
 	if (playing == FALSE) {
-		if (transport->state == TRANSPORT_STATE_PENDING)
+		if ((transport->state == TRANSPORT_STATE_PENDING) ||
+			(transport->state == TRANSPORT_STATE_BROADCASTING))
 			transport_set_state(transport, TRANSPORT_STATE_IDLE);
 		else if (transport->state == TRANSPORT_STATE_ACTIVE) {
 			/* Remove owner */
-- 
2.40.1

