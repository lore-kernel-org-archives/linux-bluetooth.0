Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011011.outbound.protection.outlook.com [52.101.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7D915A4B0
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Jul 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831721; cv=fail; b=s/DXBO2TAVOYFGjG0iUtT8q9nLQYM7mdBNge5/KqBQF+3C2Y6do/moG8FGiCFeOWlbiOrNZ3jpB4jJ0jTAzwYyfmTAQnREWtvuhtDMOU56lBAxRDs+FeTw+I9HD/e202YZS5DgU0VYARPu5Sn5LjxWansWg1ZjrcPyFanuN45ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831721; c=relaxed/simple;
	bh=RMFoeR8JeQh+bbAmGcoASloJYULXAlNy4AYD9iqJ1/o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GfEX8iuTi3ymZWUAsQMweqRVpoiYgPrA3F6J2kbZLl9Jk54v/H7h9UAUJtRBd5UfD7R0SeG5ZJrlAS2py9BRJBHmJPPSMLqGMl6weaWSJiO1pCaAvx2zDnd+rDuHHDEydk0L4tiLA4DVMDSmlcBquEu6Jw/cbmNEW+zDh+QdEWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BAzpDczu; arc=fail smtp.client-ip=52.101.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BAzpDczu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TpZ9EaVnryytg+vtqj5SwgqUNvU0f5Vb9oDaPDEufupLPvvd9knZ8rxo2ZW+icKIXeDIDD3IGiv95PWd/pZlCayLo7+p/iQrjZ06KdgM4oXi/1Rtgf0YqqtlQN9MA7au0olEUvuAYb5Gjr9Qto04rRucP+75sCvsJSCtA7ihZoU521ZZEDwQ3cvECEgOF/Q3/mIDdNkyn3kTRQT99m7uv7JPh0CsYsiWymplnTdaR6Dqb9Rg2X13Y4Ugnz9KvoID92eGtXUTFa01fNtgX2FQLEVa6GEOHDK4B11O09z0wjKF8CbxPHFMxgHAYtPOns6wmUoL2Zq3RGKCy+ORLqPWmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joLU0J1DSC+cyP+DARdkFe+1sptMD8S/UV8lf/xgTmE=;
 b=rv/dHjBvFtlP+iYRsztJqc+wIPm2yqPTGRO49wQGDFGFWNpvcG6PYqYfLIfiBW2JtFx9HUjomBmlW1MUQzNyz7EEgyWrLeVaPsDf3JzbSD46/fBS8HjtXtmfOiHerwyBzanyl0ipjmFpKXtLU6POi2HMMVdOTRlGWxpd4lM8QGCq7fuRJ4tWI4mHi7nx1tNOfTBqvZzidnV2FcXelreCQW/heMBp0KtirwvGxSXm7lwuleD+CE+XmBrHvYltAIaFccizwTJwthH6payzO7gtaAnebbZ2qDfO2SYANhnndLrrDHxnklipFuXrxvtFJUeaCn7Qy7lrzyy2MQe8dmYigg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joLU0J1DSC+cyP+DARdkFe+1sptMD8S/UV8lf/xgTmE=;
 b=BAzpDczuUt4gr+AdV6P50ddYO94klk2FvGLBUo2dn7XbRPqEZ5XyqDAgb9pYEB0oMAyofmzCLku7L6zI1OfLphzYtvhA8M+6E6vaQj1x4TxNM62KCCNWoUyOz7vBS1VgT4R8/SRw1FggItLWAa/vondgv1k0SQdR0Qu0zDqUcxR14cffBdTNohd9d2K1Q8evj8o75DmQKpQY+fOfLb31luK7aJhcg91yOR4LBZ0nR0jXCknTfDCJyHfESt/AZiPhdUEuZ8Ms5ohI4jhyPJe+DZOT8mfFne0st3NROY6MkMLGYLNa6ZnfYAYX0T2FrRDwbZ7G8kIboEhJ823tntjPqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by AS8PR04MB8024.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20; Wed, 24 Jul
 2024 14:35:17 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%2]) with mapi id 15.20.7784.017; Wed, 24 Jul 2024
 14:35:17 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	pav@iki.fi,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 2/4] transport: Add "select" method
Date: Wed, 24 Jul 2024 17:34:23 +0300
Message-Id: <20240724143425.165959-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
References: <20240724143425.165959-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MI2P293CA0010.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::20) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|AS8PR04MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: 75c3b316-56e7-4484-01b0-08dcabedd62f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kbqQtZfc5wWezhk6HHnBBBSngp1t9LoBUfuMR7cCQr5oF1g+JMhFbzmtYqqc?=
 =?us-ascii?Q?dShJ03O/Q3nHGL0c6EGH8R9wFk8qLgWWq3t1YeLffnkVguzcgdzoN8xNU84y?=
 =?us-ascii?Q?uZzi05mroixh4TXAVN9Q/KWZUH9uCFzRc7hHiqeWk08Zpq/mQ5bt0LDfSzH/?=
 =?us-ascii?Q?Ac5FGNRbyrJTliP3JTqSk2QMDQALBnhrMifnGoWXRWjMobsG2g/Zj2eAyP03?=
 =?us-ascii?Q?T/f6NxayJM8Ebnq8h8TI0wOPFgztULgriiyxlpoCAjPxEGMS+2px/JLwfQP/?=
 =?us-ascii?Q?0FhR9eV5KxA50xlYqE8SpZX1lAi98XUSCX8vm+QyKi7jg1TQyBdzfbwagJFk?=
 =?us-ascii?Q?Yod3IMl3vHOObZPMZo27Intx9fhhf1VRP5V6dPBN6kOAl4uvJv1tALuD8Oz4?=
 =?us-ascii?Q?CZbqYb9SSzZha7wF4EoeDSrMVOjpXZAi2F+Iw7JOWoHv3aBIrpaWVe92V93r?=
 =?us-ascii?Q?kgt/3kgbzjIvwQ/fF8F6RuktqEtMKsbAC2fBx2lI7oKhvm7i/j6eVVNVtDoN?=
 =?us-ascii?Q?/ckF4PBh6XpINNwXaV+tv7pMrunOpIq9b1uh7NOLvADMMMic2fyIamkuGaZR?=
 =?us-ascii?Q?S2i4Wefjw3hjmxfswKeYIkwOJG/orOtOQOnYokact8+Sptds3HTu0NNfz4F9?=
 =?us-ascii?Q?s+bfIn8Xz01keCjJ0ZNCJpiDJAtA0lh0fA1bbmn49zsfdBgirlWv23uMtBSt?=
 =?us-ascii?Q?ZkEa01uCVQpH4zT2imGd3Tz101hEcBMlQ7IIOgG200DJmIn/Gv0V/BtspLJd?=
 =?us-ascii?Q?BFs3Beifc7ymeHIolxNCAIewmdToLtiaAOTu/1CraEd/1+4k4N6vYWaVwNjJ?=
 =?us-ascii?Q?J+Su5Wh7aF9fZ9Ysc3gPlbs7jDGmkXCQZ/S5ZEESA98KifvmVrcI0IvJc3OX?=
 =?us-ascii?Q?po6SgH+n39YGPaESfvIcuzdTobBfcM2lfjgmasfundwzBROMbN+EhVgs/jg/?=
 =?us-ascii?Q?GdseydG8q4hBJpJaurPW5Y4/M2QfYJAz9d44t9EOaDx4iHUgEo15AfRIOKwR?=
 =?us-ascii?Q?2eEIS+Q1TukpZG6ynhha8/li5WIoTDIWhK/vO5UCjgba4kJB+64TfxQ9nqzj?=
 =?us-ascii?Q?p9lcyJ/PlPalPHudgoaC8GfxKIklADPtO3WPbQvsgM6FH+pzq6Hp5p5vMyy9?=
 =?us-ascii?Q?LekfeQ1ArrxziXPs59ENxFFh6gTE3Hp6BB8qFKw7DO7G9xQFES8/gDE1ajdH?=
 =?us-ascii?Q?I7hFFBocTPaPYLbx/SlzXqUxBB0RdDOLe9tTkO2jueIKKyR90anEB5UQlnPP?=
 =?us-ascii?Q?5iTlejIi+zHsf8MxUt0OBKJZYyRJlDRXANVbxUSov7aVC6fyfmJXEtCIcPZH?=
 =?us-ascii?Q?krB4t/9RTtZOZ+QO1Cj/1CXjh1r84rSkfAKTdNxTiXm9yA92nW+qtULchjoR?=
 =?us-ascii?Q?KnGsDItbgHs6mRxLOC+Ocw8mLV5PVFQ/rNZ7XOGfF9VYDSZa4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/FlGZLO08ptqDctsv0crDMPP9X6gj0raLY61+2blbRMpyIKINj4LG3aIQewU?=
 =?us-ascii?Q?ricXwwnqC3WwP3KH9hcdmxL1B/Aj3XENlxoNIhfu5X7N9Sa/Y8TG8Ox75dFu?=
 =?us-ascii?Q?kTbuoy1N7+NKyuGa0yTRXLbY6EEzVKHR7gBldDMCiG0dR8E3Hnz/Rv8DRnVg?=
 =?us-ascii?Q?omxNqi3hstMrReVNRT0V6FcoL4fvHIdvQB/HYHkhYfQ/xZ4iSs0Ha54JoqU2?=
 =?us-ascii?Q?T8z+sRTU10oScFWHWt0w0lFejKVIzSAO2URjWG+Eb6k4feZ+rXglY0vRLHNf?=
 =?us-ascii?Q?ar1n5r7ejk6sTw3cKOJPeto4ppOG3nfVhVQTLfElyE5K7TDGkd+qdU1Fju5T?=
 =?us-ascii?Q?AO/QIqBUlem1/y3f2Os5+wGr2ZeijOwB8Taa7JTwxyp2tDE1v1Yj9pE5TrFL?=
 =?us-ascii?Q?KCRYQQheJDDMrs68e8Oienp0lBJXpmQVoIUhI2s3OPYutFOy3+mipWLo2XRT?=
 =?us-ascii?Q?X/PcA11eEi1lwtzqid8j23/499w0DMjVCoEVoNDtbi6OBQcQxxtiyXCzH3Pv?=
 =?us-ascii?Q?Eb67cJAaxm/0tsBzvlJK9atQssVpZLYTKN7qHH+bMMKmsdu6Hpx8+ljszDxm?=
 =?us-ascii?Q?bERe1mCy5Nu/5sWA48m28l2GOZGOGMbJsLmVu0Pu/Z9Nyo4YRFxFN/Z8u6aK?=
 =?us-ascii?Q?2on8SxLpwhMDTJdqRdyXR38L0wNakS5kivGgZ9ljSM1wi5iwuBARZQqET+e+?=
 =?us-ascii?Q?IguCNJf4gw1uXVbMePRco8gKcFGYSG6T4H8oY421RcSNwVmkWrKFeMrB68Pm?=
 =?us-ascii?Q?HGv+tE9GDLu7ndZ4b+heZRrvTEn5/WAHNqXa9047BWJ90JBGy16Tdc7CURop?=
 =?us-ascii?Q?AMYy3BoaFD6AJkZGZb0gDlysDd3EZyTXVDegrjktwwLMpebV0jmRpmRBY/bQ?=
 =?us-ascii?Q?YVt4W+hxQGGOQSJCTqPoQBk6Wt1SrSYCZxXB9uOPZHsfw2Oj8vStnEOdX85w?=
 =?us-ascii?Q?Rzespx/pTAQwFqklHIC7m8tw+Ch1icxkJs2+bRZkNVzUwS7hhaggmyzyTV25?=
 =?us-ascii?Q?BtsZR+5Zj/VhCD/RE50HMIW9ALuGeRGV58GN17q2dhFxzaX3B6LWjYCW1wsU?=
 =?us-ascii?Q?1YyDlqf6mcDT5mm9J+wB2Zbprrwfwm1dghNI9ryZEYmb1Mtj/8Vgrqu7Pg8p?=
 =?us-ascii?Q?DQKYaLfOH6+NNeLezQ+By7nSj2W39ZvJW1rIMWpapiAZTGto6+692ss61Kn/?=
 =?us-ascii?Q?R4fhwimHckUGebjWRZwQhS2KC+Ava4IRmrM7rUIJkU1o5u+jFLA+NS970w1f?=
 =?us-ascii?Q?Yvk3sjCLhPw9O2KbVAp4fagFDbPsEfUP0gelNxTZ+W4/DBBS+5ERzpccJDhq?=
 =?us-ascii?Q?3B54Y33PJGpJG876m3e/x+nl3lQDYo2/v96rWA5YplaBINlglXYpuryiQKX6?=
 =?us-ascii?Q?nl0zlph2JGPnLRiPnY1b/KyPMI4yWUFLY76heg3kHO+JVYZBmUPhjOwHbFWM?=
 =?us-ascii?Q?p1SWE/Q+nNWWF/0ZajUEaUJPvCMhXuE3g6TAvMjaGzzQ6T6kRUhRAd2/gmKF?=
 =?us-ascii?Q?4AJgNGHbWe/SWPUQrOlpGsJXXfv6QFpUD8sUNw2khfDVZX3/eI9IHMhqGTe+?=
 =?us-ascii?Q?Yjj/Ruaxqb/5Z7zeYftcsqjadm0mGymbJw1cbcNi?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75c3b316-56e7-4484-01b0-08dcabedd62f
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 14:35:17.0741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvhXvyM+ZXPOcGdKd81lSFai2tyZp/qcuURxjnhPHD1GNDOhRQvHMiqELmC+ulu86UENcxNSU4fRbjR1G3TrFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8024

This adds the "select" method for Broadcast transports. It's role
is to change the transport's state from idle to broadcasting. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is broadcasting.
---
 profiles/audio/transport.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 017e60fe9..ce1edbf46 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -968,6 +968,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -980,6 +983,8 @@ static const GDBusMethodTable transport_methods[] = {
 							{ "mtu_w", "q" }),
 			try_acquire) },
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
+	{ GDBUS_ASYNC_METHOD("Select",
+			NULL, NULL, select_transport) },
 	{ },
 };
 
@@ -1298,6 +1303,25 @@ static void transport_update_playing(struct media_transport *transport,
 		transport_set_state(transport, TRANSPORT_STATE_PENDING);
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+
+	if (transport->owner != NULL)
+		return btd_error_not_authorized(msg);
+
+	if (transport->state >= TRANSPORT_STATE_REQUESTING)
+		return btd_error_not_authorized(msg);
+
+	if (!strcmp(media_endpoint_get_uuid(transport->endpoint),
+						BAA_SERVICE_UUID)) {
+		transport_update_playing(transport, TRUE);
+	}
+
+	return NULL;
+}
+
 static void sink_state_changed(struct btd_service *service,
 						sink_state_t old_state,
 						sink_state_t new_state,
-- 
2.40.1

