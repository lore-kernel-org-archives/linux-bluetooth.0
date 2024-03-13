Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2071.outbound.protection.outlook.com [40.107.6.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC70150422
	for <linux-bluetooth@vger.kernel.org>; Wed, 13 Mar 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349396; cv=fail; b=jyzbm85khKXxp38pLQZ/oAgqpmWw5qh6bHa1A7fncwtqXuXb9Vd3JCO1nAQay27Tw+gaoqgLglyQ4KOH7CQsBUwaQknkKKaZiT0FlmeSse4wnJuAuSMdFpmxbBZhUk6WGltN5tbjx0aiiw7P/qWXE44Klq54B7jZ7XKHbxxzNQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349396; c=relaxed/simple;
	bh=Xr5zMGxrfWDhMwJO2dseuZp5Qgp3JzCB67J1E165uIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XZDGrqozfjO+gG+YBvZ1uxeV1hMRHsjwZLmfa6gj47yj83AHN2hZ5+lYxo84b4NOHc43Zvl1kvgqFNWnvrdKWDplXU89bpnNydcxkX+a+G/5CZcSWJC3VyBGxqXbXzsaHsR2AsN/ZkjuhbYh2mgBX0jXtRApENKSwszjdMk8k3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XDcX+P3w; arc=fail smtp.client-ip=40.107.6.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XDcX+P3w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jA2nzS2scpN7R/aE91GapR35yi9PYBpOOB8nbwjGvNZXt7EGaOUlQIdrRbMhXFlE0WEuf38iHCJn/x8d3sv3lrokBVkeOJTTBEJvwtk0FhJcBCNbdvOf8++5DWGwzzCIUKa22Lw9sLMJDT7lqm/KQD4oDLjTxbncMaMsJ87oonF75PBomcThkqIx6BDRg3dwh559AKhKLEV8R0RVf8sXBrPbCClM6oMR9BiXL3zyPf9pTC4MnLhw0OCycbm4qsuYLgQngAMVLCRKDwzyaio1dXBb98Ay2EcSRYzyrL6OKQRWq5vyvjEzK2SydyBfwgQoLB5bMQF3LqopweGvDoui0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpfH9HIOXAIKxkd4aJqBTl2Q4rvpz+zsFkQqtr9x0NM=;
 b=bqCoooAntzOINqZ101spDSC6YE19ksXc/TP3rj2gBw/yOmB1LAbm3xaKBe0jIZe3m/CMC45DWP4QBXrZPtoh5P5cCGFnD1QBgroFrN1/EQvAst0116ZNIn2rlu8C+3hK100EaECLOljt1L5yLD8cXoIOCuel2qqauj/k+ofI1QdWimcYmXu+FjsQoA2Dos78jMoNca71B0Jyvx+VLtIIiya+/f29/fH+miH55bUNa1wNYS0yARhuuv0LahHv1LFDXNTadZsRFtk2CDZcv6NlcYtlYm9ddv0Oxpemu7FHgOEEidUWKPkVZjaR0Zlaj7N+n8/szRpbJJe97iDNEX3i/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpfH9HIOXAIKxkd4aJqBTl2Q4rvpz+zsFkQqtr9x0NM=;
 b=XDcX+P3wFJ0OepqZcZtOdcfaPs25+rzCLGOLeRunIA2c98NUgwecSqlOPtJAHKbPTLG0OdVRYDTVJuGTLeSftyanqc2wZX3IJJdanhfCj6GTK+B/wAOTqidBBjC/grG89w9VESD7fszVRO6w/el56arNNM7rqy/xCh7f3yzhnPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by PA4PR04MB7517.eurprd04.prod.outlook.com (2603:10a6:102:e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 13 Mar
 2024 17:03:11 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Wed, 13 Mar 2024
 17:03:11 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v2 3/3] bap: Broadcast source reconfiguration support added
Date: Wed, 13 Mar 2024 19:03:00 +0200
Message-Id: <20240313170300.40974-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
References: <20240313170300.40974-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0001.eurprd05.prod.outlook.com (2603:10a6:205::14)
 To VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|PA4PR04MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 3499c1f8-dde1-45b9-12f7-08dc437f76c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3GTo+NVX2/p805jLPzXYSMChVE0AkcOlbGlNcPOHQ/Xd7HIVrvTCG23/WIsyQMiW8+WK7TPJI74lN03TSyrtslM5AvEiCENovVNGj9PXWeqcRd3dIifrD43lwjlPUehscUGoLbVVIidLCysQ3AR2J9Acmbdxiga7H6FQMtgPfuncNQR4TcsK0GC5rjWFA2YnMKqnYqNrjTaDnG0641LjlWhQABV3N//XP7eV5h/eYT0sIswsGDaL/3TdMTR7QfCxPSB3XUCTT1IGvywTRgl01iwMVLjQpUBNqDTrbGhHUj6pkvW8BXPbkj8ji3oC8sNLfk6sJhvEvJww62H+AEXJq9wkOuinHlGUQwgq30QpMkif0ORO0i6BrMOQ+eU0F7EJ47HcX2o4vxysNqaY69DZsYpImXEDKZQnPHmwiiYEckWYPqsttc82c+lv/lAn9tt9eHP2D69CCwGIGiOn0RrCw6maQzd2xuBaPjjX2Al+kbSyZvATJO46mSGiVgIO5D/ixlMZWL1NpWpcOTWMMsa2d/iX34inymcEPrF4VszurNI0gX5BWajOLbNKnaP+EMkXxamkrKRiRqEd6G8ArHYc/6CoEL6KLsKKbnIfywIBgiGGs6RU0RYasXb+5av11yCLQyEa1yqeijirqcLlQvX/VyznzOiNd1t21nUbmG/TKqk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fF9Tr5UkjastGpFH+1dqt53oNk4snW9xerBh2jk9Nn7M2oc64CZypQgt+p+N?=
 =?us-ascii?Q?8OoGxggaIFA78g4cFLlxtwIN168u+y+GWpNDt1PUkTHufDXi31iMiBaIJ0Qw?=
 =?us-ascii?Q?akbMNz886wcYokmd34i6aj9DR75brPl/irnr4clCE/YDuflSzzTyoo/WD5UV?=
 =?us-ascii?Q?/a9c5eYVGFsc2h4uKbwI0hprSFw3lKqiGU+hRcHZRZdYnRrUhti1acP4acPL?=
 =?us-ascii?Q?73waQKJRfoFAPvui2/L1XqM9QACirpwFfEgvJcWaDeR8gQYZMarv0wmAv1yA?=
 =?us-ascii?Q?uquGGrk/9dD5hPzzrBr1tDTNuBBMEWdtovTZAe5Afy5v6BKaCG8UObgCwZ4B?=
 =?us-ascii?Q?YPhiQu+YgoCm4tWimwtkQ4G2Bf/6Sg9pbXmz2VFCl3dgLrAaTBLUadxSY4FB?=
 =?us-ascii?Q?abxPUrKdcbU3B1MuJ3Fnu7SHjWR38jA3RcikNsMSbF4iC3iI2gy4DLGIe9ot?=
 =?us-ascii?Q?KgLWaV+E2FgitlSLBhIRJU/teQ6+MHgXu1e+oC8H6zTdPZGA2OaTQGcAZ2kg?=
 =?us-ascii?Q?CPjy8mZVGk+ChgmZt4lUag9mxAcHW5dQ/6MksZFNCTMbL3vVTptF+Hw1istq?=
 =?us-ascii?Q?WbaLwk9p6EyxATY/lSHYdHeLo0gv0DAO3UZCUIFtO7XIcFAL/bvSzsJio/0x?=
 =?us-ascii?Q?im4ZEVYHrjs6BSH51V8Veu9Ur8fP+IjiKW2SU6kjS6DghJpVbRaMPKbZdxT9?=
 =?us-ascii?Q?+HtjVyEEyzeBwcfipFfAWJLVdY4Oyzc66hXdSW2lDJDaJBLRECHuqtC7hWv9?=
 =?us-ascii?Q?Bt55Um9xOl0qI9Uq1H7B4O2Q7JtCBMf/uJkvKuE3XpYmI2ZTIy6imkP7VoUD?=
 =?us-ascii?Q?ze/DB5soyMoge139waLQ4cWMrDaq6bNLmiUs1bnygCFsuCB2RKMHX0wabbZU?=
 =?us-ascii?Q?FHEWvAeCz6Suz+wDWgH43z3sCMfzGfYzU+LOTdjiL/qgBgF3vBaxbFvb6E0D?=
 =?us-ascii?Q?nhwrZL5IcSDWiXvPVeJKZgAa0Y2RxxyDWVDSJ88luRx6GA4LwHmTWopajm7+?=
 =?us-ascii?Q?NdzbMN/E3oWG8Xk/P56/UjAZCv+XYc4xByxb1/qxCNvAwnVBXxe7tX9uS10W?=
 =?us-ascii?Q?O/WE9yaCLVpB2R2Gi7Wmt8tLfRWVcDsV6yqTqU1qPsL/hxEZt4jLD7GjZCgs?=
 =?us-ascii?Q?/CD3uB9FkvzSZIESoIgAU7Gi2vq6PBV5Qc9RQShKu5W7Uly8k5uVhLf2yt7L?=
 =?us-ascii?Q?pmaANBHPIsdASUcI3JUMSkv9y01uyk/C3t5rHN3c4S0n85Aa2gZLWUC/QCv9?=
 =?us-ascii?Q?s/DHwS993a8Kn41vAiwG1t90KJuNNnA4VVU+F2G4yYIMnB1HAqgPITFJbqsh?=
 =?us-ascii?Q?PLurKSdEB4j9KQ9yGGc94phTHrvMWjwEnQFVT3ZeA5cc2585z/s98P2fNIz4?=
 =?us-ascii?Q?nEfB/zd2fhAG96lkKC7yyiTlf6K7Eo+8Cu+g5LZSnkBjITHlstwmpQTkM5md?=
 =?us-ascii?Q?ETsiUDvYQaL0BuvxggXH3xYGBxUR9HhwdVXnRRYvLpoqrU3wwK/PzlmOzeXm?=
 =?us-ascii?Q?HsEh0TLWCiHGetot8OnVN7CNpLKWOZJdXuleXKhK9HowJnviSJJtFER9VHKa?=
 =?us-ascii?Q?WEy4Fr2kV82iwBlP+Q7OUuDsL4oZKHesSuEd8brZj/sEk7u02K54Uqy+QS5H?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3499c1f8-dde1-45b9-12f7-08dc437f76c8
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2024 17:03:11.3614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J2OZjc905cpqqgd+t7GZODsc7J/7b6RSTVj8365vS4M8gXD3+BhLB4Q7OkdWs6XzpBI6QOv/Mjy3pn90jv4GOa4J8WQhgJ4jTSL9DBbGUI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7517

Broadcast source reconfiguration BIS support added

---
 profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.c |  6 ++-
 src/shared/bap.c           | 11 +++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 1034202cb..a67e0ee94 100644
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
@@ -881,6 +886,53 @@ static void setup_free(void *data)
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
@@ -922,6 +974,30 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 122c3339e..a060f8c61 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -1643,8 +1643,12 @@ static void bap_state_changed(struct bt_bap_stream *stream, uint8_t old_state,
 		bap_update_links(transport);
 		if (!media_endpoint_is_broadcast(transport->endpoint))
 			bap_update_qos(transport);
-		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE)
+		else if (bt_bap_stream_io_dir(stream) != BT_BAP_BCAST_SOURCE) {
 			bap_update_bcast_qos(transport);
+			if (old_state == BT_BAP_STREAM_STATE_QOS)
+				bap_update_bcast_config(transport);
+		}
+
 		transport_update_playing(transport, FALSE);
 		return;
 	case BT_BAP_STREAM_STATE_DISABLING:
diff --git a/src/shared/bap.c b/src/shared/bap.c
index fd99cbbca..603d6d646 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1701,7 +1701,16 @@ static unsigned int bap_bcast_config(struct bt_bap_stream *stream,
 				     struct bt_bap_qos *qos, struct iovec *data,
 				     bt_bap_stream_func_t func, void *user_data)
 {
-	stream->qos = *qos;
+	if (qos) {
+		stream->qos = *qos;
+		stream->qos.bcast.bcode = util_iov_dup(qos->bcast.bcode, 1);
+	}
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

