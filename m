Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012059.outbound.protection.outlook.com [52.101.66.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E925757
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jul 2024 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599245; cv=fail; b=Jf0ggidkY+Q8FUX6EhJFqUw08ywzpVGEUxF7f/+6leCJAv5/CDZJAYtvQI0Dpse2kgd9Jz8L7fXk0Q0/MYawodpJdtdq5+7QeUZ/tufUOBgPYdySRI7PnlzWPpKFy9suDsWWwT7kFGtznIeXxEL3Q67td3hucr3JP2d0e9Y9vSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599245; c=relaxed/simple;
	bh=P3v0BULcqErakIKoDkcgEOp0oRvuT9p5cnqnYWX7tfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YFuWlrADcuNpld2LPQYDN5wi8sI9flmIe2nUY+B0Z/Dok7GMiTEH3+yX1qKEOoukGUQMrHecY1hEc2UCdmzasLVrvaDyOItudTNex8z6dCqVfaT3PRNMuFFxdakj9/rcBPMyuX8qgHSZz+e78iUs5p5LtrE57qQyHYY5oZovdwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ipks7SrW; arc=fail smtp.client-ip=52.101.66.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ipks7SrW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z7jPFZmX3N7OvJXnDE0W8PvkkiFD0rkePN9X74PQorPQyJsheqYfCAnJtI3B1Gpdwm4BC5PR5XLbloKO+EBG9ygHDbWorsP3/GiaIoqUwKr/LNmfI8L+W/StJE/ySO2BWu5xtZJPpf1BVB5zWJASpbTW14EUQeN4ge0V7Fu/8Omt7F1dkbhRbUSOvB7jh9GAsf/UI/r/+NQl5t9FW6cvW7EDYY8cdgUy69XGXT2qjaj/KKBDVKWvAYDNMa+FOyfLpw8d1MftRUoVlDtS6rtCFZZCDHRgRc9dAtxBw8ctDBFylWPpbustHs60NP0deSFuT1y+PNm6tlH7SbP8LMmpsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mo2tnhFxcT8iWq8ce1IyrTHHQtHjVjq7J7adQYvuc6U=;
 b=XiDk7G0aYewsWWgRzbu8ylQY4EwyikDTUVSN9yv8557QKMbXXJiSe4Td27pay8fGyMgssUqVQd4BBREXQ9NQYnoSbs89D0pyU+f047YqBMExU+A5EbITkh8zGfSm31PB8CkP11vUlw8H5iW6DN3f3Fyo0+6myj+CBeouWY8q6nLcHGH/TomfJJUMq0vnJY8mysC0sIdM1MyYe/b9GGay6ZYxnyXoxX2xVaV5Mbclp0V060Xz+AZJoH4oDeRIL805W5GrlcoYqdWfwuxyAPFLJ/o9tgI8sX5T6ZB1fu8WNMynV/Xz3sEVh9bu4Cv/eW8Elq5w92dRZnrj+uc/8vrXkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mo2tnhFxcT8iWq8ce1IyrTHHQtHjVjq7J7adQYvuc6U=;
 b=Ipks7SrWM3aTtLX3xggD5bXyCdsOb1h/VjR/cZI/KVlfPIVS1t1sb08kMnbxGJD4rBr3Hs/6Uo9w55O2d3z7uEvBp0dGSKtOGP6k20N+7GKiKFf2/m90bFUg8C8u4sQh2U+3YTAFrx2AXVmUhqiHUa5SeOaMOg6Qv6JyiMKTIRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com (2603:10a6:150:23::20)
 by PAXPR04MB8864.eurprd04.prod.outlook.com (2603:10a6:102:20f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Wed, 10 Jul
 2024 08:14:00 +0000
Received: from GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277]) by GV1PR04MB9088.eurprd04.prod.outlook.com
 ([fe80::8775:dba3:39ac:3277%4]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 08:14:00 +0000
From: Vlad Pruteanu <vlad.pruteanu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	iulia.tanasescu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 1/3] transport: Add "select" method
Date: Wed, 10 Jul 2024 11:13:36 +0300
Message-Id: <20240710081338.17262-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
References: <20240710081338.17262-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0212.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::27) To GV1PR04MB9088.eurprd04.prod.outlook.com
 (2603:10a6:150:23::20)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9088:EE_|PAXPR04MB8864:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f14e9b1-e120-4132-7b54-08dca0b840f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uTGPP59CSwhLiif+ye/2pXfXaAUNzvYQhOoNNZhYfjeTTqe+6OEm9ERnqOpP?=
 =?us-ascii?Q?UkoMo2FUNOPS9J/LldxMOpGjVXETDmpPjQ12IdtMHzxLlWOpn2+ggrqjjdFY?=
 =?us-ascii?Q?UZE+5jqZbGhLihCQtLHSgsT1VumxhPxUL0EoBP/w4eVRQgcZYtAlu6Etg/vp?=
 =?us-ascii?Q?ubaZgNCzVgZrW3z3INlAD0A+ighwd+Z6N7lkYVNTE4BUdBpDmvJU6vUvJiCQ?=
 =?us-ascii?Q?fDm/Qz6yVltvSYgGGYcjdgQ94PS2KNvCeUxVxf0/i0jO4GyD1h45xpoW/AHN?=
 =?us-ascii?Q?kSxkHvps6vVdPUyNMFSR79j4Imf331BcJlqEYu4YR47x/HRDdJGOyfOgVSoY?=
 =?us-ascii?Q?F2yv6/ioXekceyKsjbIrutXJZw8GvXwF3iZg1cjtwfzEQUCTvYZAlpKAinPz?=
 =?us-ascii?Q?FgbnBJQ8KBMAlrK1AjQT/mKjJjI0MG21SkxFqgzre3/otQe2DYdQ0JWp2y/A?=
 =?us-ascii?Q?kcbuhii4r6ZBRgzEbmmc3rc1nhMjvGubIvvy0qoGPJ20q3XEJqL0C05cSI8x?=
 =?us-ascii?Q?AqGAJSlqhq7PXpPFCPIwMT16Hl3Fg/y3pWyzkEdpF1kixaWGSdIJv05/32Rs?=
 =?us-ascii?Q?dpqc3QpH/NjjV7xNpsBypzx/jtsV9f1C4zDI89APm3CDS5yZSQqhYSgus8uZ?=
 =?us-ascii?Q?bOqefr/es0ePezxiricLSSYsqJ33x94tvTG+Qjy+7GidMr2GtauC4TcCWoSk?=
 =?us-ascii?Q?o/hYtRLBEqUXJBExQ0S+IznnAFywZu6ryO7A5bSdzSRQLsw5gyINiVq3Te65?=
 =?us-ascii?Q?QvEdoGGrGCFlPUdhyYVKIMMkajIrgtYenJwGmGm/KNK+D82Ar1dG+gFfEbA7?=
 =?us-ascii?Q?23MXTSDYDFXDZLA47c+/0kgiQ6CIwzrysEmZv8TwBVuzbm6GIutZeEKepFGw?=
 =?us-ascii?Q?sCU1fiM4S+GRVYpCZDaJOfSXYX+i8c1pk6BMHfTS7WRbva/cx3+J23I5kljY?=
 =?us-ascii?Q?XIge5Vsc2hkea//fh5T5ZmAjBNhCzqbwNnRk8wsV/xeYa7066roMdxdW8Oz+?=
 =?us-ascii?Q?z+2k5oqydWGj3VyX8L7gLXuehB+l6bVaNQFOOa7rX5cVfFrvoGxn3OIJ2tM8?=
 =?us-ascii?Q?SMucuVdbX0QH2A6sAHKkW5y6OIwjYK7FcTF2TjP3z04sXJxValFUEoQxyCme?=
 =?us-ascii?Q?vOUN84+RPWcST1jjEn1n25Pqd9FwI3ksqEeayKlnaCdGU+7edJkP24scz9I5?=
 =?us-ascii?Q?7rj423qNuD4bzXw0n0KcBijaiGmmk+P2n4cycXq+E7AkoOzbh1eC0gyBzlTK?=
 =?us-ascii?Q?EUHu0zsx/WZ6ZhKJW6CustpOAhK8MSBNwX9atwCrDSwq3fhsKz/2O2HlQLNY?=
 =?us-ascii?Q?oPBlJZXAcbOPFVcwM3jVQ2W56CsEwjqq6JTp1P6iba2Eq4C8IhQVR48G8MMD?=
 =?us-ascii?Q?IerGGBlUatcidK1Ws8FWQnnTlPCPZuiwz5qGWKxl/nbY9ed1TQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9088.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7dzTFsbhgo/g6gIuN1uuu+8fgBFg7ZnI/0jqul1j1L5ct094mN15D8mmPaA5?=
 =?us-ascii?Q?y2+5GP2DnJP7/NHrStiFAhULbWbQuZmyh37xrZjoy1HVlEXmWvtzCrnKfrOc?=
 =?us-ascii?Q?v6oFXNQe1Pdnqt7RQLE3XJinkHhi48Gd++oYKJ46ZZI47qHlBrPq7IRTfsVK?=
 =?us-ascii?Q?Y/YGHuwaTD8NaCKpzdeYWydUDL557mxQ57j8m8WQy1ZEOI+SVV6lgGMbXdLf?=
 =?us-ascii?Q?zbdEz+ZLdUoGG0yDT+6nvV6/BRg3TAPjoOo7v+WnWl1UxHy0ZaWYAg625xkZ?=
 =?us-ascii?Q?192BdYI3YMeEviy6AK0IMngDJv4inhj2DHUwBL4fAk+6rS5+5B9AKg0o48dj?=
 =?us-ascii?Q?YBSVrgMnIRsKPDnI9rSIiwwYGU5mT1qa01stLq6FaZyGFmn0IFtLC0VrgARb?=
 =?us-ascii?Q?NwLCgLHYQyss3kK9zlhU2nKN9SeGttXmBZX3bIQSqVXQN6IfNT8NOMJGWOQy?=
 =?us-ascii?Q?kth5n3SLa1vzX4ZL9tMjEuaUT2qfujQ6JeVsIR+Xh1g7TpmNdB6HhMKoNX50?=
 =?us-ascii?Q?Qgn8h9QQdEMQ4HBYBdMfJLEWT5wh1oVUrFwVecbr0UFmBluuz12exMYcFd+5?=
 =?us-ascii?Q?UsT31YEhUDW6uDq5w+JKYGJ6GU1fo54moC60GYaaw5I4ISSTS0r8mfKOzmgr?=
 =?us-ascii?Q?wJjm8LxkH1np+mIQHz40a8ob4hvi/U+5BE3TueNP641k5ZAhIzFFQ+pbwqom?=
 =?us-ascii?Q?IcGr0HXyp4EAoBE+pgHlQm8y8Uh45ACq26T9Mf3eHEZILx9ZzCotx8dQxwbS?=
 =?us-ascii?Q?XZAsSTdb7ipnDWvvM1kpZo/fVv1ONK+q/1XhT1sq59YWS23UKXrdZ/cSHClr?=
 =?us-ascii?Q?7XSg9qGiA/5DeSrDKgf19qnInV03aHVDpJyvH5hqmdrm+sT1onrhS95Eligq?=
 =?us-ascii?Q?Ecexi22xH3w2t+2VL5KsNlnzGlGgl7RQzW6oHnV+KJLn1WYSM2gOkbz7EMCk?=
 =?us-ascii?Q?5qzo5WkBOIvorWwQy0ReshdKrcyOU2KxCF4Lx6jBdcAafX25b7QdaCUwaJlA?=
 =?us-ascii?Q?L9FSZmef+cezFap0QiDiNIIsPTyyATS/+FXGGHyswCd70pT4IOq7pb1QMJBR?=
 =?us-ascii?Q?akRzVj0DhKfwiqFzEZBlK4jRzx6kid+ZWbLQENll1b0XUd13i+5XjYUZsOfQ?=
 =?us-ascii?Q?EY6Wpn1Txiqfqbbv3FJ/b+VDi9laHi7WrcALRuUbfQS2bvLgrpHdPaTPOclX?=
 =?us-ascii?Q?kTwb12WrOlAMke5oQpWIuxWabQLNWSSu0ao3KvlYZryA3YnYodoUm/mislJB?=
 =?us-ascii?Q?m4xNFqKysWOB7DTZ/KimC9Fi9q+WkLsvrukzUKAiA20J4ieuON80/EV53xvr?=
 =?us-ascii?Q?oXFIm94fwZmOf9II+K6xxb2cFJgIICMCB2rCy/PKgY4KvTDp1T6cB8cSgqLK?=
 =?us-ascii?Q?jZBIJq3h+Ds2yD4hVfhJbyZsaaXfjCsxjANL8zCXsvDNjdqB9z1CN5hrVXzW?=
 =?us-ascii?Q?OQ+KdNxpCUHGzkRPkdxgYXPtcCa3uLiSe/kutw6EtalBozb2CuBrzViDjWav?=
 =?us-ascii?Q?T18GFP+d/8erXACulQupjrrI35M9jHumtkBwXjX0CYbV5dwXGSmA0QG6Hdp0?=
 =?us-ascii?Q?DYlw/EeMiCbOycpZb0C5o9cqXLCoQEeg+Qyz7s45?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f14e9b1-e120-4132-7b54-08dca0b840f0
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9088.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 08:14:00.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hSK124ebz2l6PLFhgqtFjPWDxZ0/kNsXSdxNCXpGK0xLNL/7HvFOjmvH7dZSfkvXgMwxSqge7zzjK3W0zeI7Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8864

This adds the "select" method for Broadcast transports. It's role
is to change the transport's state from idle to pending. This
allows the user to select the desired stream when running the setup
with PipeWire since it acquires any transport that is pending.
---
 profiles/audio/transport.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 922911cf3..d6493edd0 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -963,6 +963,9 @@ static gboolean get_endpoint(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static DBusMessage *select_transport(DBusConnection *conn, DBusMessage *msg,
+					void *data);
+
 static const GDBusMethodTable transport_methods[] = {
 	{ GDBUS_ASYNC_METHOD("Acquire",
 			NULL,
@@ -975,6 +978,8 @@ static const GDBusMethodTable transport_methods[] = {
 							{ "mtu_w", "q" }),
 			try_acquire) },
 	{ GDBUS_ASYNC_METHOD("Release", NULL, NULL, release) },
+	{ GDBUS_ASYNC_METHOD("Select",
+			NULL, NULL, select_transport) },
 	{ },
 };
 
@@ -1292,6 +1297,25 @@ static void transport_update_playing(struct media_transport *transport,
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

