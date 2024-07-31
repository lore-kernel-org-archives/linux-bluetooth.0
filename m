Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010028.outbound.protection.outlook.com [52.101.69.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C33B16CD3C
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 06:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722406659; cv=fail; b=J3gj49dXDUUe8FzZc1Fhugao6S9ncDrfyPHQ7lzGHLb5C1Y2n21BeqHF8gQqUNbOesS67uQiVajuEgamj2eRjL4Bhkyb1vvLTfFbcPQMe+f+2/924St4BeLGWRRnoQxGeyoarUh/EZLW7VhsEjm/HwBdvp62g2JYanEwZsPcjiA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722406659; c=relaxed/simple;
	bh=czaSDfnJVKCrrkGXMQAvEltIA7s3kIsEDsFBSbxx2B0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQmsg9Qm41YJklpOvoaUFPiZzIx8TRRqWgmDSYyS6L1S7jM8ywuXHWqCuk6vYDkb6iyJ4uBJxyk2hc5G4NdiGRYT7uGLikpEBpVNnxRg4JMSqy1IB7SpPbW8wgpHodUtILEAcQz7Jeze5J3dvKJJGf2yYf+Hs7xpnH7APIdIkGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZafCGcOj; arc=fail smtp.client-ip=52.101.69.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZafCGcOj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6xoP9lywF0F4U7gv8alSGzSOly1gKglWPmJHy4kx8TSRk9NmFDxLLz4ms/l4DGdqhvHv/Jqut/iA6pzkUJV+9rBuY1fb7Ig+Oyf6tfxBswW/QIXrUBTMKpLvUuwe1bS8A3NgEI/oeRtroycrwt9TY7lKpMnTJjamAfArTcs++eXoeF2OAY90Ph4EIiDWLtVnsR/f1iHf2U1TQerkJnUPyH4gizzadqjTLr8zQ0k5Tc3XEsK/oXRs3k+Q2+1CM3Gl6+878Mw6RUQZRSumKdIrgLCkDnHJ5Z+de3vsu5X8L1SpGeSkI1BJLljP17qrh3vsNxgpV11xBIrUsshhcohtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=cevWUHCuoaoeG0WKbFX6vQ8o/sRSspP2ryubt4qkiWRhT2gOiCaatsFaS4naAl9MkBBwriu1lSolH7d9HNZl3oc0hYiAEZWlTNXE/HK4B0U2oBPG7TbEtSx5kZ/d5ayuq/3ubZZCY9vGN7h+zHB99HK5zc90T9gbNnZofEvhaAINqsXqB3+79ZMTGNM/WsjkwNIPQjYZNUWLsgvG/Hh+0t4e6HK1Ln4VuoCo2ukiBk1jYgmqU42hGC3v+m+SakWMUY+SU8LhiJ9CeIwJayM1bpNpD4MaiDY+qHWaVci7e1Lsq/2fWHEWp1Fnja/7UNcjf7v2QqIsZjtRtErLQnUT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzzAhPYXwU0UJNjZ/EMvu71JfpR/pRsC1GViYxA2wdI=;
 b=ZafCGcOjjJeNOL4JLnwqYBcExX+Ng80PFfAlxtPwxbLdEt8ypeO6UcI1xSw019BfHpUfghAwVPvotbTOXODbhVOfxykDY7bVcZSs+gtUP/fR24E/mJzJEiN1Xi1H0EY+0iIkI5Kxn85nuMaEp+HTdOQKZpImfPG2rTamJFLZcxmaofnSSqkwVwLGKZ7WIFIo/GAlWwMwxmrZn+pibmb7VtozautWT8tRCWuVinlIy8HbZOM718X8cQPKyrf8GjjhVv4ljOh3hv48bqHnO0YZafCJMfhpZl37kYydv5cA3KsxF86gDr+at5csk98egx2bzTD8Bc8LVedzjdu+eW6fRA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by DB8PR04MB6924.eurprd04.prod.outlook.com (2603:10a6:10:11e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.32; Wed, 31 Jul
 2024 06:17:34 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 06:17:34 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ v5 2/8] transport: Add 'broadcasting' state
Date: Wed, 31 Jul 2024 09:17:07 +0300
Message-Id: <20240731061713.435586-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
References: <20240731061713.435586-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI0P293CA0006.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:44::17) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|DB8PR04MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a93669-0f03-4f7d-fbc8-08dcb1287767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yzf6HPWc+AZ0NUeNYFbOv2gg5OcQaWB3p/IzjgxKRrywFYfUKOVNF7nfIlIp?=
 =?us-ascii?Q?Y2F9X44TIbULqZh+Fs9bT423GeofzlrW/CJxBGEHe9D4IPCo15+vbZUR5wh7?=
 =?us-ascii?Q?72EdhyfpYHrx8YQxUMXgiDKiwi/2uX8crqSdVe/Frj3AEfbSS4lU5wZaNDE5?=
 =?us-ascii?Q?K2cm0Yw8mkn9NuekeMuuhzRiEr3iKr+xMsFJ8r7mdguTmP2vXhCTcHxHWbAA?=
 =?us-ascii?Q?2st8qq1euUddCOug+9SYHGzH785KBU8YwGigvkVrKia67uTF6Nfv6X3lCulJ?=
 =?us-ascii?Q?UG+otz2dpl4E5jsMM+5E9w+mMtfiOiDQbJO6u0XjGXa6/9ieJpYpTMaL7jaB?=
 =?us-ascii?Q?v2qpxElpHFqF8qYzX8cy/rTuUAVkdITtfFINSr0ZfVVz42JsnCvQw7JQe84b?=
 =?us-ascii?Q?8yDD4uITyS6hCk5TVnm/rClzE/8XUEJ8dYgaFxHuKzR3nMF3rIUE4e9SuumK?=
 =?us-ascii?Q?ZPxZ+LB8Hw5DbrQdM7Smsf6kj4Sdo9YpPRIu3/Grq2rdZaL1KGygRxchNWR5?=
 =?us-ascii?Q?IqZYjaTFgPGH8bsLj5eiq96kaw0U3WArbEQk6yTGyYzbMkpoPRyNihINBYGg?=
 =?us-ascii?Q?QbXajn5tKD3CH+rXeSNPNywqeD5H9VUcCXnemy0n/KYKwS/LxYK8M+EiIxLV?=
 =?us-ascii?Q?1lgWmSxwYfReecc4QoQntEmTOXPzvo1U9GgREbMP9pK8KN4IkQCsnYpCEklH?=
 =?us-ascii?Q?pTNMlAyzViF0/CtpO/srgVWee0ckxhppr4/rNiFIMUztYACi327WbnnC/mOk?=
 =?us-ascii?Q?ff9SoC13bY9jj6n8rgZtvjqHLDJT+6JL1gn75BxP0kE+zZ5oWBDIIoLph10R?=
 =?us-ascii?Q?JwIxzYngnQY6rwF0KZ0hXW9mjPTP6Wghos37cQRaJkQYbZzrOk+hZlbNxasT?=
 =?us-ascii?Q?+305TaLT+mxwUrskJZZ/4mbawOgz0YSlhkd4Do6Y4ocbxLFakpPSrQ+Xgzfd?=
 =?us-ascii?Q?IqF+esJLynXPICrVm6XHbne/mFPTdcouExKzg1/fjM+huhSOuLr40m9MmNmg?=
 =?us-ascii?Q?sf8Ouf0COzpB60iVEFWQaIYYsmjEuEjmz85mrpj4ig4QBXKOyks7pMA5lZcl?=
 =?us-ascii?Q?yboJo93w67W/gMNXhd8zZdMvk/kk8zKDQIpDSEpbQmwwgGfaea3Pfq4lbzoJ?=
 =?us-ascii?Q?pdX/sE6RSw2vqhtuTtKGFPFFk7nxiCT4gEsSWb6PkC9xqWmPp51tElTz0uu7?=
 =?us-ascii?Q?OQ2fb9nH2MV8qnePmJPFit5S0bToY4ryf+VZSo9gtXWO8gbiKOsyD2mVz+5x?=
 =?us-ascii?Q?N1Mp/Fs9d+Lp0+3ZzuOZda8EqGmmwl3lWhZnMRKkPaGGoKBSy8/e7GslJFfj?=
 =?us-ascii?Q?TB3bbp4+la8QOM8sZhG/7H+Zayw1ud0SECuTPOa2XTwva15PNksSxuR+GeMC?=
 =?us-ascii?Q?70e+ELaiNAW1l9NwQxBbh+9LhmTwrfpMjQCKwJilza/TTfXORA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(366016)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T4SeowVCYpB2wH+NN6E8uaAWd2nx5lFJLdW5CZW838+2hmn6u2uWGVjeS7VI?=
 =?us-ascii?Q?4285kUPQ1TPqDPbAP+K5dGfK2uwP8QF6XyeywHco5LyWkVBux5rxFZsg5txH?=
 =?us-ascii?Q?vIy2REI9iJhlrsU6lMiPjgbKhhLdpQ1fe0s+FdvfOWcPjduk5H7v7lW+qXdr?=
 =?us-ascii?Q?mtkrQrm7g8YOivwXVAfoBm6uJxB+MXg3pHtowUHe+CZorXmQEEFsjHqtzyIR?=
 =?us-ascii?Q?bWVyjn5W3oJTJs1HaNrDHrcnpAQqBxxW8zktXgql8TmakHP57ynP3/4lK6Pz?=
 =?us-ascii?Q?a8Jwhq+lskQTwwhfuv10T1P4uwv5mYVXiufUnECS5qBcjQ97wYWM63WDNy4R?=
 =?us-ascii?Q?uRulwUd+yhU3ooaSISxsPu6GfxSOFMK7X351NdoXr1+0DQ88XQaW20dZQJ6p?=
 =?us-ascii?Q?glJgb5liuiI9LLiODqSuMHbNNUhOKE2j81pyVNrR7aTEN8rN0KYoVutikTEk?=
 =?us-ascii?Q?aa+Cw2Up9zas0QrjeSxgAOYbxxym/Ug/OihJmxVQocj8NFOzmB6Xul+2WFej?=
 =?us-ascii?Q?rCr4rboF5/41ezKsqzOgUOYOyWV9ZqIM07aP80xrcnRId2ZgFhUfL3s+KuBn?=
 =?us-ascii?Q?b/Da6/sQF8Gs7S3Y4crv24iV5BmUdlZP78zgrKISvCWDylCtiRbq5k7iIAJp?=
 =?us-ascii?Q?fMGVyQE6RPyiv2WDD/qYww4V1AnEfJW2UKRyIqGl1J7qIoQvkNm1ZrBa3mKz?=
 =?us-ascii?Q?0qiDsb+i9nxMBTgRbG7Y2kV+WaXmBi2+n7buNMJ0MXgBM3n4Ja/TR3BGHk1x?=
 =?us-ascii?Q?PNy0No7uGn2JvtkDCemmaeM1mMkR/dw4im9HR4iFYGCtLsE/3EaWEBy6JdMZ?=
 =?us-ascii?Q?229u26dMw7uKUAqHejp+3IqGLhu4WF0PcAhNUs0r2bF6l8W80HTLDdIh1BjH?=
 =?us-ascii?Q?rly0vSfSUxP8w5uHJ8ntqYUZezSXNfRXG+dEw6auf12TknqXAk901sE9yQ6O?=
 =?us-ascii?Q?m8LQGL4WOz65Yva6mIT+9ZsDHSuSDAveMj7EpkEkVArb5MUq1daf6CAZkxBu?=
 =?us-ascii?Q?moXsEhClp4yd7EHXgncwOXCx1bVTYmH8BqtbV37X8OXAFq1Yli5RYKbF8jBI?=
 =?us-ascii?Q?011nt3ocB7R5BrNz4P0Ecjay/TnokecUELTiamHHG99MUulipkWRXWGCSuOb?=
 =?us-ascii?Q?Aw8thIRQkNIwgiac9DC8tUHy3s6kJsQgGJkDkxvk1bamvGZM9syLW6Iyci7Q?=
 =?us-ascii?Q?d+JdRY/mjpsPTHwnt+DxclZayTlMCSfiJTjZuXURlQ8wQisaDkK+ricadKRL?=
 =?us-ascii?Q?H+OyNHammGdTP18Ykjf7eYfhjRFrXuOo1jFQ8PCAE/6yFmVPpfbYdCK8BJnb?=
 =?us-ascii?Q?9vkcmc2EyKI1UJlCso898JUdUflYpsBQte0TSNmGIhhR9BEUuH5++dF1G+FT?=
 =?us-ascii?Q?eBadFYqePFv/LuNTnSz1Y5FOODOmLZ8rLR3ZR71I6CnQLW5MptLcEuwEOqxD?=
 =?us-ascii?Q?USeSb+Xo/IIx4SSahUV926e9HuLGlegP8hpXansFEvQvefIr6CT7wYjua88u?=
 =?us-ascii?Q?22J7lVyiySb1ITq7gvFNDuHcpT2cWGFzpY4mjzt2mV7ZpKKqfHrVlY0vEaAA?=
 =?us-ascii?Q?Qhs4Ff5xyMT9T1lBB8uDCv4tBbxwsOPEhLins3xA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a93669-0f03-4f7d-fbc8-08dcb1287767
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 06:17:34.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CZAA3Skv+SkPTn3UgrQTP7+1HGUr+3+JCzuhLGfKpkirMAT146clI6Hesah1hUsxw0nK7xLQA9BYywn78JiNpA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6924

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

