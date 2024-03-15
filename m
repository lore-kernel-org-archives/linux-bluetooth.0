Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2053.outbound.protection.outlook.com [40.107.14.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07C3613B
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Mar 2024 15:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710514940; cv=fail; b=CdaS/fFTrEiOhje17096Fb4ry+DF+hVYLHelCJDSynXGamhOYhg3uPHDOT4vIj/F0nkrOGcX6ups6dZlB71nhQOAdZLFSlIyI0EsGkXS/cFYajDU+G8UuCeA3gt7s1hSXxnD84nTaY+FYggln9heUc0rGqCQ1d7NVHCMK744AoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710514940; c=relaxed/simple;
	bh=eAgKjABbhwqNWH+UaGnCnRqpEndnR5qT1kGZAalTP1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yq2J381e9D852TwHAJk1eaPPp6a8f9aXSCvhxn3j0+Xyunui7Fqv+fNLBiXVhMmC+A0kw/Fu1OoC1v2r8zIoelsqIFH18puyoIlRKooFAtevZDpKkAehP6+nfXb6E4mHSP12PfSa5OcpBiyaiZAOXyQm9Jro8oWsSXgqPfMbp8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rPzl9+ri; arc=fail smtp.client-ip=40.107.14.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rPzl9+ri"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3N77P/ulyqmnfCFj+0qZAieKmdGjkAHQ9HIJ2cy2gDRmT9ITRAcfKv4TYSBgFUEAAfg0p6I+tF0c6O5eSEH0Wvn5dTv91lj7hx74Xpox+LeU9WtY6Su8mx8mtoFX5DWEZXk5lojSRuKUUvbvNE5zvAC2YAPgfSMvKNlo4N4cPLKCjCwNKJAdInFXj6KBmtiBQT/SI0+wNywFNFq59kEJON5HVlrQT0xxup8HFpnSRkffoRgmdM9GUcH/AEhOhNyy6yOxsfbc2+SX5LfqYBOVSZhdhcbUvFBwJWveImMO2ojxpchzBCaUMJCcU5YBrjXAEBkjcicHWRvTCUcvsjmJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUri8zYSJLUizV/zO1hj8hGHu0uOBbun70T/K9Phfkw=;
 b=Phf9O/MYIzC2amqf/EucGYukR9odptLsLx+PEsCe4VILQxtXzh+/+mSprk74QupEKo5iOdlHnKhnuvmxfs2HRqb0okfjoOd2u9GvRsGIxvPE7/qh/HkMsoqPcSQ6b44fDylKG1HLRbXx5G7h2FiATdzT3EnIvgpt8Ro02esZMSZNwulxZ3f8Z4pzGcvdyA6lVVBdryinQzXGl1dDk9+GVdM5iRvavJ6phNpldwARYjSPJSjj9A3gc5TCrcuv7NcdrKtlDr0v0mOirqS01xyKacIKz+ffRU3JfVqqsJzzJr7ISNoOimMdMfuH7SEhXRkXd9Qyiko+Ig0sVGhaGGaAvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUri8zYSJLUizV/zO1hj8hGHu0uOBbun70T/K9Phfkw=;
 b=rPzl9+riRIX91LIls/xXKkHQ0yRpIKSLcng0rMj9dSjzI7GjYL8/svY4qvNB/qy99zMtSr/MVp2zQ9Wt0fEHiYlgEdIlh3CgCeECV9uJgs9+a+bRxveL/5X4uLG0wZ125v/i5cropm+vqc36vlvPwXQtC4efmy/CwjC+JYlKV+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com (2603:10a6:800:1dd::8)
 by AM8PR04MB7937.eurprd04.prod.outlook.com (2603:10a6:20b:248::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 15:02:13 +0000
Received: from VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf]) by VI1PR04MB10073.eurprd04.prod.outlook.com
 ([fe80::7bc8:c6eb:cb72:91cf%5]) with mapi id 15.20.7362.035; Fri, 15 Mar 2024
 15:02:13 +0000
From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To: linux-bluetooth@vger.kernel.org
Cc: mihai-octavian.urzica@nxp.com,
	silviu.barbulescu@nxp.com,
	vlad.pruteanu@nxp.com,
	andrei.istodorescu@nxp.com,
	luiz.dentz@gmail.com,
	iulia.tanasescu@nxp.com
Subject: [PATCH BlueZ v3 3/5] bap: Broadcast source reconfiguration support added
Date: Fri, 15 Mar 2024 17:01:56 +0200
Message-Id: <20240315150158.79715-4-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
References: <20240315150158.79715-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0040.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::28) To VI1PR04MB10073.eurprd04.prod.outlook.com
 (2603:10a6:800:1dd::8)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB10073:EE_|AM8PR04MB7937:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b3ebe6-85da-4905-3904-08dc4500e59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mKIFpPIXUCLYgyawGB5ISLIZRTM0OnjtVRvcCoZOVq1a7dC/f88u1AI/w/XIycfj/ElvYlHfyATvtgv/SYnN0M44mnoaWsGAHn7auqO+1zf/T43oy9kbVfmhLeVDHeHbLerF4okjNuimz4q8CMRI9N8NEv828m4uaRNSM79a1qFm80z0RNT7QOMUiBQ1goNuVw/lgxXbyI+0oGDS1q6Sm5UOBKWC9sKoTpz6HS4HvN+iou97Z+zxlPKcOwipiyvCQRcF0VT+0HWbYKfFDo3LZjwGmzCb5PmZq+UVHDpXj7jOH+t4l0ZAygRkmXB9WNC8EzjymjXk3BYfFRzy0t0grfCkvfyKtYDSnptrXXz/1aluhYqMLkkVhF0m3Rs1n1jGciNr6xdsJKJZLv07/Odoaf55ElhM308IqNT5hgg9H4mykiFfjSe7dkb7WG30rSchWuam2IhEkdiwi6EHbblaKJPkD3RqDN/PePOf9LNA0IQ7uvGnDozX8qRmoWHbjB7yfAGeqsg/Lq/LUDjJ7LPuxvHvmyuAlnx7c5pC8ib3zTXH/SgXDMYQACrK+aEJ2sOIffnMpVOIK4rtOEY1xWLS9OpTtBoCxx6dbKFNJRVrTyqufWG8Ik6txXOG8HkmdkqyTpyJ/zMMTvJkUvJEK4hp52+OsLs97APCrVPrZ+kzHEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB10073.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QBfY6qhJQOPa4w958jmg95NEH3l0DpF9hthxeM5oLgld4VoIBNB28D1QVwyB?=
 =?us-ascii?Q?NnnEzhk+I2wpQY41xplvIlHf3//FEKanBv8i8htTavDPQmPTaPNIodSIrrYC?=
 =?us-ascii?Q?iF1GXImOPOJrKohPpEC5qyaxLPn8m33IVpOoB8zqkaRh+8o5Iq0r04PNvjd1?=
 =?us-ascii?Q?DsfJ+wJm1HV4FdCWQLK5xSMHRFdVFKeJ3w8XqVZmBUaA91zBchJ/t3VEtBq5?=
 =?us-ascii?Q?TlWbveKZxtxHeDk5BN23N21sZpybVSfTFGRljxnc9ULGnGR4P7tb8XAHDhZv?=
 =?us-ascii?Q?q2n0DJqjp3mMoa0GSrgStKT442WsPTpWykFyfgb+4YMBkA3SoL6pvPXXZmKs?=
 =?us-ascii?Q?+71pPvKXT/+aGPCR1niOW3ngiRUaIOy2sWh1Pw7jPtSlNqJ0qQFm6MuYNQ8w?=
 =?us-ascii?Q?agQx5SyE5m/W/tMi38ZsPiMB7XZE6M+IMG8Qi0gSbAYY1NUfdP8qYudGmU6A?=
 =?us-ascii?Q?VKHZlEI//p6IxM6LmnPbuz4ZyRtcbnXj7kIslConzlkXMeBWPSY3ZqwtN6S9?=
 =?us-ascii?Q?Pz8JycGoEGXpcDbp3VCew+JpaqIDSS32RkKsOlTcUcxRGZ+NXu0SU2TDgSHR?=
 =?us-ascii?Q?DkFISvEUv7IqjbT31QPIzJ+3ZuiRgHdm2fUPJPjnYvxo13WxzRU+XpKbjDgg?=
 =?us-ascii?Q?KBPQ2TZtXL7AmDBv7ZDPZaV+OZ+BaHTkopk1awf+pUBlsTPgIS7tARvkmSTf?=
 =?us-ascii?Q?jXq8BesuKWO/ZfAtEbO0VYlPH9UmBc1NI4kmwtQM78lcf2jOyvsIWohJoGGH?=
 =?us-ascii?Q?/6rb7JFCI5in6KpnAL2FNGsOH4br5zL7FJi47yGfS2++zNAtub/iGZJTcw5s?=
 =?us-ascii?Q?TkfbNRzu+hBTos+gxYxAflnUOHeIMKDLm6XM1cEUS6xYRzia0KTQ73Fx3LRg?=
 =?us-ascii?Q?TGpgf0qc2ZV3hWtVuTECM9Uk+Nhlsa1El6W9qe3/6u2awBGBCo85B4vR4wPK?=
 =?us-ascii?Q?9e7R7mHQOHWYVF3AfzVul82Qi6uK7xr5qvhh99YuvT3gexDCLT2UBP4amsRb?=
 =?us-ascii?Q?jxylsBVNanfN9b9HHSHKpxnPCQ9WJo79S1qBkHEx0ZWIlgQUQCYJB3h/tfv+?=
 =?us-ascii?Q?enmxa+0ajnYXb+D0WgtH6UkpOkCw2UcetR4whxYKHDzjlr6FGb8/mnpZ7Ccc?=
 =?us-ascii?Q?dpeZ9kvPXOC823w9lqbNdVubQHS7sKEbPENOWEpr5JrxQ0TCroD6vW0fVNlp?=
 =?us-ascii?Q?jQL2kR9YzoK9pJhGyX1BqDz5VCT8aE5HvjWVDz13XAvWGL2c1TfDfEi61iXs?=
 =?us-ascii?Q?tk2zo5ntQso+yGrXuOfl7p6Ik5vdNeYepVu3mnH2ARwHrNN+DinKT/HFMfT6?=
 =?us-ascii?Q?YSmCe19FXrH9m56Rm0jWcbozFCOrO+/DaYn/1IrXnQMGVUzAneexzR4W6aUA?=
 =?us-ascii?Q?eet8DcP25nfuwJHFizYlkVPnaYN30BrJU2Df2+5I8oX2PNa946Nx45xE2Wza?=
 =?us-ascii?Q?Eq3U6hQxNxTvlhHllbzlVzCNm/5yAaBZZzggo7fYWyMte0uSJFG5xsF9iMeZ?=
 =?us-ascii?Q?wkFS/b6JOa6ZXnkm96QypV4laptKnu7mmzLxPBhBfzUBm6olWR5VdKX2oWRF?=
 =?us-ascii?Q?0oPIZPr4M3Ch+6rjqUF82e7lTKiMyFjTqT3FvYHF6wycWg0StfdpYIj+kEGG?=
 =?us-ascii?Q?RQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b3ebe6-85da-4905-3904-08dc4500e59b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB10073.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 15:02:13.5854
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMajN+lZIr6Z1lu+ptSgjdnZZoOtAvWvAVynxUZ8OHl9qWmatIpoO3aWl81cQZXuVuQ06uZCYyzArmHMcNQ2T1QAz+zEACdcwOG+p5YG5HY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7937

If a BIS is reconfigured, the metadata and codec capabilities are updated.
Also, the BASE is updated to reflect the update.

---
 profiles/audio/bap.c       | 76 ++++++++++++++++++++++++++++++++++++++
 profiles/audio/transport.c |  6 ++-
 src/shared/bap.c           | 11 +++++-
 3 files changed, 91 insertions(+), 2 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 964ba9c21..e508e03ba 100644
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
@@ -884,6 +889,53 @@ static void setup_free(void *data)
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
+		util_iov_free(ent_setup->base, 1);
+		ent_setup->base = NULL;
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
@@ -925,6 +977,30 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
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
+			/* Find and update the BIS specified in
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

