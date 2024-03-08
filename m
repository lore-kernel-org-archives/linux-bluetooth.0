Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2087.outbound.protection.outlook.com [40.107.8.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087791CD0A
	for <linux-bluetooth@vger.kernel.org>; Fri,  8 Mar 2024 16:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709916766; cv=fail; b=ARLDqYti6cdG7nL4vq4G35XgdEF0quNhnBapI67OR0hRv/b5TH9D+AHsVySscVhrYntm2BHM5/tzlED3QkDENCdss+Plr2Kk8Ipud0PoF2U1B8VVMqP8iQ4Hn1YBScWtEX6/s9NteWpMA3joVCfMpOBTA8SumKUMXlP5eswSfIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709916766; c=relaxed/simple;
	bh=ddpS0CDXa5snMYVQNxtR3boIurEljaQkfSWLHDdRhP0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EELGWGCiOXRmI43XWupe26Q3myTdcUiJfnd/nNehWIzv61ao5ln5NTrQqyzrRIJTue8n2mNuZy0Y8Jhcoivo3DzP4G92U/sOKMZiNtBRILNGgVg4ho5a2rox0CwxM8ii0UIIxIQpVbC6r5D04uKE52CeuIZsuw8kkAcFCzTrHLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hNjzws0O; arc=fail smtp.client-ip=40.107.8.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hNjzws0O"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kuJiSgYB0eR8H6yHkRWacDiA3D2U00FXBweTJN++2axljoJSYFGo8kBXFgvaA1yPrW/V36b8vAYf6u1KXmGhYyl3vhfpWwHM/34W1QTZNYU+KCMg9gIzUTSV5VZtSIps4H0Fuw+l7wo3S4aTdOwXG+z753VxiIaWM/kq92ocR627y0K+94BILeAXGchjymuaUBCO30lZxRl+NOSDTvBYGeEijhXsXOF30RaLKQMkSpuXYWvxD0D8fiXBhLTUDaZ9r7oAldQEQNWuQ4zZy6o7MVKRJQ06An33aJZon+O8UKgy6NVx4rkMwSeDrWCCe5cuL/w/9TLzbKzntYQ8S4YY7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1HQ0ZMjXy/SkPauEQxTBZpdnlHWZBY6Heo4LSyxwYtU=;
 b=VYB79iDprZ3wKoANVm8llxQkjStpyxrCAGUZ8S+s0Vlo3JxeUdYQqtwGaxj7j+bj/juLEezDbQi/mpNeVpu6zw4tU5Qa2mbQTXoziW6+tWABe6jw2boHiPA1tA0VQKQYqlNTOl/j9guCwNhXAyrffYqL02MhQWYNLtFokew0npVEm9f1Z8zjR+Dpb/UIfACqN4G1zLHs8k3TOLvTEoOEJgrJf8U0qidQJ/juzJT6Ex4bcu+yEk0jKnXiUj/j6CP7Vzo//1k3T1J4tSyuhGSi3xYHlx/6mzyxZXs3HyOhN07v8sUlBcgzK5L7MlP4T87FqtL/q0Mq4JS75eh26/6alQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1HQ0ZMjXy/SkPauEQxTBZpdnlHWZBY6Heo4LSyxwYtU=;
 b=hNjzws0OK5Zps8Awy9PcpC71+eK5VeOoSy3P8ctH7A7Q0nNGkN3mJgEZqb0e+RyFU/ObXY9pQFPK5/ebPExvoenEHCNHCBTFX1nKU8jIk9ExUI/kPvYtIWZ6JHhbMmod+YjQZUXKyBPMpMkAprrDiiugk87W7g5Lcv//yiQtvmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM9PR04MB7572.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 16:52:42 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 16:52:42 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ 3/3] bap: Broadcast source reconfiguration support added
Date: Fri,  8 Mar 2024 18:52:32 +0200
Message-Id: <20240308165232.53906-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
References: <20240308165232.53906-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0099.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::40) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM9PR04MB7572:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c008717-7b16-4ccb-aab2-08dc3f902be3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9J/q0k9uynIguHmeZ7BSSjR2/94gzZ+PE1S/TNiY83ewL/kF4yIo1RJAJkYRvs3Z7OKGoyBtMGndAVpLgBmhmmFGEKct/6HOOoCrVuv51opnJdmX1fOhWG1swnFQ2l6zT7FXa9+o3SIzMqIRS0ynKYcGeX9hS39EgjyjGHoFL/HWCUAz4X+uSk2R0Vv6bi263loog0cSqrKXMaz92fl95/9+k357F+4NCt9pBpK+5i1175kldqB9z9H4J4NSeNti9GuuGvAGVo7wPNrLY+zs2jyjBx/a2NACR9y8Bgp3sQoYquqNySzpWyjYqX2HSid6lVpRd12KBrQ5NbQYZE2Xy2NAz9J2gVCVRrZ/FuIaiN6BeHh2kpr71fTwacwBFHGr6F/ZWWLNPVmFOY+Ssy+m6V9v5viWSCHOSfN6YZYB7mhtcp4oAZMvU3qkchLOTjnBdi3FR2Aq/xefhFH9eMMAZU+Ij2hYIDKtoVnG+Hx0qwW9v7whMGtEM99IgnU3whwOZsvWpArdw8oWWOJr27LMg/wZsCqy8/Pm0P3FxcKSYjWyY4amJJBj4XDAfcS7idAMdywJibR2Nq78zx1yc1fc8x2ZZ6FSQUF7qpIeC5hHgoJFlO/O29MFZxPldjAgW125QqK0hNkUv2KKfN/evPrFt463qqhBsd7mJ7KZhELCqlQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9PHfpwPOdjh8A0zn2YnVxlp/tOMb/UJEtnL0Rcrsjr7DjOSgOjIugrAreWKO?=
 =?us-ascii?Q?6PFMuR5hqciDdxBImicE9g5dTkRTYm1TUO/puQc/Ya+JkQkzeJEIgkB7dOed?=
 =?us-ascii?Q?HKAM04I3EcSqfWJCw5rwcF2PzWUDnhUJ2ZlPuoVY36l8BaLpWTBozUuPKt5B?=
 =?us-ascii?Q?VGP5k0+nnoLezD+ylQIvAM5Z62wdTwv1hQbHLdZitt/4N27sEdwgclT4BQil?=
 =?us-ascii?Q?Yn+UBMoN7B5E1MgRRufaDYmS5CRioztLpcf157yLFCSo03ACnGbXGD+VF28O?=
 =?us-ascii?Q?DuOlq4H/n6newC9Ho41gYsFtPWUf+0306foiC25NfUBn/dJORIdSY0L3KiFP?=
 =?us-ascii?Q?lnDIGKehDizw71xljm3c7aqqLpX+aD1nFgU2S9SYJir2lwOFPk4BLYNzoy23?=
 =?us-ascii?Q?EUhi5gLjc+l/OjSoGtqcpSe/6bNx51hmVY7jioZ9+TCs8gdkC+Ad2aBMw1/4?=
 =?us-ascii?Q?xevIagsQEZLwJA2s3xXBvWxkKaUciEDbf/x7q3/eTQeRgQ3JO1iGNer68Q/m?=
 =?us-ascii?Q?XP7L4Jn4YYZYYRhhZ7zwuNWF43RKi4t6TVkPuf1AK6QRsBFKs1iF94aRc/yc?=
 =?us-ascii?Q?EYYyfdQtQfv556TaEbAyspOF5Zm6Gp8APLut+yoY/LMZdBXU7nkZAlT2Kswi?=
 =?us-ascii?Q?Gv5kGWUYZrn03xx53xUPO9oBN7IxDmoPQo7RYazYwO1s4oIcEj+0/vtSQnI1?=
 =?us-ascii?Q?rfgwm0f423y4Hx/Gb+Mlqn5cl5ZBEqJkHGYUayJm+6g9f+8gHMG4amm4sYiD?=
 =?us-ascii?Q?+cgYmsvUSdyoNOBG8Zx6RFSgw/rYHlWo37aqF7mrwGMO8aZWUnmO/LU/I6MR?=
 =?us-ascii?Q?1FbmzUsCJsQIU7RBCpSr/MYpCKzwKv/7m40cvRYb8/gVXVO5wvHzjFYnfRe3?=
 =?us-ascii?Q?mM90hmaClLzlIKGvYJrBCkqUaqjd1/CNtYOhrZ3tCU1s4reLtDHtbGME8TaQ?=
 =?us-ascii?Q?iFviDvM/AKcd0ylV1b/bgVP2SlbqlNmoI9f1STr/bAJ3eCfEdcCLllj4RPHJ?=
 =?us-ascii?Q?S+R7rIfbmfggblDli7Iq/Wm+AC5kpb3WDOzvEWzS1upkFZL3wR6qJtTxsU/t?=
 =?us-ascii?Q?qU6efamjUPMT3UG97R4OVzwEE1EA6xVWxm4ZOsxoRnHIAs0yLSrc26A4GKN6?=
 =?us-ascii?Q?fYVz/uGKg0OrSJ/VWjQt6IdkQuAy8eGlaZ8EUtEzL5JqTlleFJN9MwU0iouL?=
 =?us-ascii?Q?t95a4CEntlno4W7pmkR4gnk66FgdNpx0WWuQrtBeE9OSgenjXbaQS56atVco?=
 =?us-ascii?Q?13BhscWSdr5R6Arb9OT0v1GnexiofiwS8YhzM3LISVgk0CLn7fS7buQ+mlLI?=
 =?us-ascii?Q?5fwJf7F9HzjllJVe91asn1KXxUjQ0wJRZ1es9EqnJaQ7p4k7C6C1EFx52e+C?=
 =?us-ascii?Q?WYVS0OFQGXeyLBm3DYohRWEYxdjQKinvsIBlkbXqItpdYhV5WUHq8IuZZuO5?=
 =?us-ascii?Q?sOTPQD7YmZu322D4avgtFkITXfL19zpOws2rliHDkMo88qlyD4/XreErnzCd?=
 =?us-ascii?Q?ndFGZh6QJqYqYeyfB6wVzmKCpID/xKoR4Xp419l6uonTVPufLgUMO+ibn5ll?=
 =?us-ascii?Q?ycwK+XaJcWi7AN8ljBNXNSvU5SY42os50ucUWhzyWxSslVDr7MrbhepiMIqv?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c008717-7b16-4ccb-aab2-08dc3f902be3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 16:52:42.4993
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Br4EiSvbseTdnnu8jGkd6TnyOAfw9ullmC/mR3LqyRxNXd0q5d9WA0W1PWiLeZaDa5lyW/wE6wQAwbTVIcSTUhOtchDMu5/9oo7b2+zKXCI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7572

---
 profiles/audio/bap.c   | 85 ++++++++++++++++++++++++++++++++++++++++++
 profiles/audio/media.c |  3 +-
 src/shared/bap.c       |  9 ++++-
 3 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1b8a47c52..c07506c45 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -580,6 +580,11 @@ static int setup_parse_bcast_qos(struct bap_setup *setup, const char *key,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.big);
+	} else if (!strcasecmp(key, "BIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.bis);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -881,6 +886,62 @@ static void setup_free(void *data)
 	free(setup);
 }
 
+static void iterate_setups(struct bap_setup *setup)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+	uint8_t bis_cnt = 1;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (setup->qos.bcast.big != ent_setup->qos.bcast.big)
+			continue;
+
+		util_iov_free(setup->base, 1);
+		setup->base = NULL;
+
+		if (setup->qos.bcast.bis == bis_cnt) {
+			util_iov_free(ent_setup->caps, 1);
+			ent_setup->caps = util_iov_dup(setup->caps, 1);
+			util_iov_free(ent_setup->metadata, 1);
+			ent_setup->metadata = util_iov_dup(setup->metadata, 1);
+			memcpy(&ent_setup->qos, &setup->qos,
+				sizeof(struct bt_bap_bcast_qos));
+			ent_setup->qos.bcast.bcode = util_iov_dup(
+						setup->qos.bcast.bcode, 1);
+
+			bt_bap_stream_config(ent_setup->stream, &setup->qos,
+						setup->caps, NULL, NULL);
+			bt_bap_stream_metadata(ent_setup->stream,
+					setup->metadata, NULL, NULL);
+		}
+
+		bis_cnt++;
+	}
+}
+
+static bool verify_state(struct bap_setup *setup)
+{
+	const struct queue_entry *entry;
+	struct bap_setup *ent_setup;
+
+	for (entry = queue_get_entries(setup->ep->setups);
+				entry; entry = entry->next) {
+		ent_setup = entry->data;
+
+		if (setup->qos.bcast.big != ent_setup->qos.bcast.big)
+			continue;
+
+		if (bt_bap_stream_get_state(ent_setup->stream) ==
+				BT_BAP_STREAM_STATE_STREAMING)
+			return false;
+	}
+
+	return true;
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -922,6 +983,30 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		util_iov_free(setup->metadata, 1);
 		setup->metadata = util_iov_dup(
 				bt_bap_pac_get_metadata(ep->rpac), 1);
+	} else if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		if (setup->qos.bcast.bis != BT_ISO_QOS_BIS_UNSET) {
+			if ((setup->qos.bcast.bis > queue_length(ep->setups)) ||
+					(setup->qos.bcast.bis == 0)) {
+				setup_free(setup);
+				return btd_error_invalid_args(msg);
+			}
+
+			/* Verify that no BIS in the BIG is in streaming state
+			 */
+			if (!verify_state(setup)) {
+				setup_free(setup);
+				return btd_error_not_permitted(msg,
+						"Broadcast Audio Stream state is invalid");
+			}
+
+			/* Find and updated the BIS specified in
+			 * set_configuration command
+			 */
+			iterate_setups(setup);
+
+			setup_free(setup);
+			return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		}
 	}
 
 	setup->stream = bt_bap_stream_new(ep->data->bap, ep->lpac, ep->rpac,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index edaff7867..084c09fc7 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -1154,7 +1154,8 @@ static int pac_config(struct bt_bap_stream *stream, struct iovec *cfg,
 
 		endpoint->transports = g_slist_append(endpoint->transports,
 								transport);
-	}
+	} else if (bt_bap_stream_get_dir(stream) == BT_BAP_BCAST_SINK)
+		bap_update_bcast_config(transport);
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 37fc1de4e..07f5671e4 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1701,7 +1701,14 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     struct bt_bap_qos *qos, struct iovec *data,
 				     bt_bap_stream_func_t func, void *user_data)
 {
-	stream->qos = *qos;
+	if (qos)
+		stream->qos = *qos;
+
+	if (data) {
+		util_iov_free(stream->cc, 1);
+		stream->cc = util_iov_dup(data, 1);
+	}
+
 	stream->lpac->ops->config(stream, stream->cc, &stream->qos,
 			ep_config_cb, stream->lpac->user_data);
 
-- 
2.39.2

