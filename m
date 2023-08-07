Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6807C001DB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  7 Aug 2023 11:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbjHGLD6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 7 Aug 2023 07:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjHGLDn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 7 Aug 2023 07:03:43 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2079.outbound.protection.outlook.com [40.107.22.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3381993
        for <linux-bluetooth@vger.kernel.org>; Mon,  7 Aug 2023 04:03:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYFDObwsfTIUX5JpbOULNCqq5YITRFVAEcV29/4Gnx4Eq7WopnBiHjT8GWJaPiilnqjEI/jDykeFVhDd3a7Yn0C3XmSM9XfImmwK3sgxYX/Nml7IpDR3zS0nDP9DOvuYuCyX7fjaWr7O00SW1BBj4AtpWqTmr5NrchYW2vrTTHrYjELlxl5VPSzCUwMr7EwRwd25lFcBrdAkSy56d4Hs7wr3sAzW5AmDXecKd0h+HDUqlMbeo3vTBLKt3tb3Ejks+gw/SVdlhYc3hDzn6/vEH1RC6wepLin2/utf7ff36Jnri5wy3VPBLEq3YfpCka4HXGW1lRYmvPCl41+LcQrOgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VjQziBAdm18KBh1onKTXcfYV04bncbVpIWqcIhzjf8=;
 b=UWK41ebsP7usLk2YWI9FyJFvHw6KsryBxN/tkflgoYeWQncrwXcbMdqzapggwXL3nC5+Ao4Ms4f9TdPdtU8Ln5EWewCVrYEIGHqXDn0k7qbmgJQUGNWTDtFHTgCgdMcp9sRJ6w4CYYKT7dbcMJj2yNH/eG8lbbh0C7/HBxRSCdxjbqO9qmZJrSkGLuUy/fCPPVhiABywGmysqaQQxkmy8ZYZtq1bL6AHqdFc9Dzlb1/Q81JgjILIwRfWSnllt1XYJIkSBLz+dcgDH3JxJROlxJcMssRp33gYy83gsSs6mwMVWCPI9TMR9bTwXRx4BN1pRU7IWnHffhTH6RaJK1Bn9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VjQziBAdm18KBh1onKTXcfYV04bncbVpIWqcIhzjf8=;
 b=JFYt7F1NsS88MbDVwKfQ7j2sVRDtRONCcMQIxO93fJMKvD471qJXW+XzmOaXinihHwfLnxzlBGswiyFzrgngKbuek46FmygyZW+X6x6y58uHyB019Kt6N33bbD6njMTVoAFBCAXdFW3UoO06BmUi0d7zi6+R476iHtjhSCPIx18=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB8028.eurprd04.prod.outlook.com (2603:10a6:10:1e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Mon, 7 Aug
 2023 11:02:51 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 11:02:51 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH v2 2/2] bap: Use the BASE structure received from upper layer
Date:   Mon,  7 Aug 2023 14:02:24 +0300
Message-Id: <20230807110224.6024-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
References: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0001.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::14) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBBPR04MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 016055b2-469f-4d15-165f-08db9735d7ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kwoHUkGQmG8lEldADoMfofT8QwPHRMYTM+NewnGLN8R7Gs5FKn/umcUYM0Hyw6Wf/9g6qZjpOQX4Gc/IIN6QkF1WmlQTB6M//GL23q5o9lqMOzT7kWHKssNTcbfshxEeYcpbEvpuXiJAmhvMjamGvVr7EXxSY1azpTmBcYAqSwTQ+6WiOtbHBteBs3zDc6M+X8JOi4Fu0wRNE7gUAJ1y7ruE/Y/mUfl57Au7hanu7cdSKlsPr4hPp4fRZ6GhdimltrH2V2ZLY8WANGJzrRB+wPjmdJ0MszHo3RKH57aHJ7fvdytTqMWIVudbgdLIrtRArWLj9ELtmPMmMnjD4AqkAUVRs+O6+lQwlSZlU8RmKo0GoKAQpGak27wUNAK7gO0rjdfAhUBMk92sOA+BTsALAlIs5RTu8BvfxhF/QAwjDa8KNHYpcJWLkda8lGPeV8ecyccXR78ol3IuZtsIzmTTr2oCOO+MpcT4NsLu/L4EXObtDwPZ9TwqwXpvxmYQLZX9VskvZVj/ExQuuvGWN4FCuFbvXH1jk8aBiKcXATh6otMNMCogl0t3XWgJbK684TFwF12MXCLDMUdsTWpp0ku41d6C0HExsCJzNy32OGN7yhy9Y8KV6u5vj4RSWud/DdmS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(1800799003)(186006)(451199021)(1076003)(41300700001)(26005)(2906002)(5660300002)(83380400001)(8676002)(8936002)(2616005)(6916009)(86362001)(316002)(6506007)(38350700002)(38100700002)(6486002)(66556008)(66476007)(52116002)(66946007)(6666004)(478600001)(6512007)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?esXHpsZALhVR8GksN4vd4Gk4l6Zq3YqNaSrZX75Jno4HrjUwwW+EeOyAG9qA?=
 =?us-ascii?Q?mOOV0zCyxhGBK0Mz3j1kawqP3ihvzpYBltFk6lWC61QMIiML+AE2/OhYLk/h?=
 =?us-ascii?Q?RGpY+8vx5xF5bWqBqlfEEh3WG4UncgQeHw7iqXKMTv3UtEIW8p9Jatdy3tsI?=
 =?us-ascii?Q?chcKHf9vAzb/PwV8Zo061J9ZEKCKMXRwawGiW6n5jf/rWSfoBYYHzjTzn8qa?=
 =?us-ascii?Q?ju0j79lnp0XMRgNXRJasyLyf/vwTa6A5jBkhvalpbX4G4JGraflp6ihKuWyY?=
 =?us-ascii?Q?bWWi6KxIurs25asDmAb1KevFMZpXo3fVfrLyD4U5xunXqJ1Y0EX83rYUxgBR?=
 =?us-ascii?Q?vD1FkZwlQPSlCTGkgguPEtXO7M6AAMTgblimzICxcRrHNO6dN9EeRwg3vBmn?=
 =?us-ascii?Q?fopQgqrsLjpCXj9O6P0kqoKj5GnXWKQF6OYt3pXTaC+hCeFLHk/GEMwVb98j?=
 =?us-ascii?Q?1HweS2+P0Ci0xCEn7l8fH2KDgDjnIcOesRwTAc0E4CeWOLokOqYKrpH0O5RZ?=
 =?us-ascii?Q?Zlwy1RymBgk+c3GVIG/OmkCBRvBZPp0Px8hmqnX+DM84y8GcvUkI2ieJYQ/I?=
 =?us-ascii?Q?hzlR5me94SKoj8eD+6qmtagv7m3VNR6R2a/gLYshZqzlesDLZtaNIeiU1xgJ?=
 =?us-ascii?Q?6GEFKN52qEPOyyWBGPKMTrQcwFoMPJQSkIVbIiDIK0cSft8igwJnrl7nCzQD?=
 =?us-ascii?Q?KCS+Qd2EzyU+TGg+AEF0Y/sL6pnDbuG1cY3TaTcx0CjzM9BITQx2KY+LKnCV?=
 =?us-ascii?Q?UExHKlvnyp6SbGBZ/nZG8KiKGM41NI5MqQM8uSFIpNnBl6QlROUJF5xNSUjW?=
 =?us-ascii?Q?PXbCB7TT3cftHf1J940mCTiyYDZWwh3zLqzHwsBI3ego80wLyyrCBfpsJlvt?=
 =?us-ascii?Q?Ne7uUvP/rs4Wgk8Zk+pbRmh0X5qPXouaFNAas3Jme55BloKHg2xP9yEA4rM4?=
 =?us-ascii?Q?zy0mYvTbM2SQg8MZY86jlMfu4JJlc41A7kPdgDZcgZ6/yK0kb3UyYP9CLuHg?=
 =?us-ascii?Q?E5UrooKupUfy+w7XvqClAsCqFRMZ4jYRxt2SxgwO67X+qUytbxxWWfMNMLY6?=
 =?us-ascii?Q?DuLOIRjuxiNlJes6KpGly0ByrBwKLxJXinKqDTzlRywk4VNmugg5zAo3GAKS?=
 =?us-ascii?Q?pdi4/D88CGLutP30eMiUWk+9Of8UmmiPVuqo5VQO/nkc8rhJ+V3XCpHhxeEC?=
 =?us-ascii?Q?sf7gAEG0yWWXtx84CFzVhD0dgolfvlCvzfUIhmIW2qk8v8lu+BBf8KbPBpv/?=
 =?us-ascii?Q?9VHhe+SUqr+NVNjig9fivJVa9l4ePy5LWyxuOxLyWGh3vPcWlvQJ6Bw5YHPB?=
 =?us-ascii?Q?EzZQm+hRVF7kaNIWmAZmQHZy0gOaevPCJaK2tfUWQWfWPksuxJjQ+haaKpj/?=
 =?us-ascii?Q?6aA67CnsEc21klhXesTNHmL1kMS4TTEq+w0rDzMNXxMRteLyGiUqGwyRYNBE?=
 =?us-ascii?Q?znsVnfPyuX475/aoerSHGMQ09BF+5UIi3yNzRajmA1crcKIZVcndAX32XPuN?=
 =?us-ascii?Q?AfBDsJboA4MnAYY6MctuX45jJyKaYbOTfZquYtzClZExPVQHUFmj08mK9O6U?=
 =?us-ascii?Q?L/KZKFaCQqg8FD65OtZ4MSjGyvwS2SlYjMXHxvb9J4jX91aAHwirPf/FKint?=
 =?us-ascii?Q?4g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016055b2-469f-4d15-165f-08db9735d7ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 11:02:51.6049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YaprZxMTluHIGbEBuRfBh7Nv+jL7Vyz3qj+k3l5ZXpueZBPgis7qvG0p/vGQGN1q/jyK4Wq+4tdVNiWrRxe7lIs+dLwIFzv/fZ9RlchSSfk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8028
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Claudia Draghicescu <claudia.rosu@nxp.com>

Use the BASE structure received from upper layer

---
 profiles/audio/bap.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index 8cbb238ef..5dad748b4 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -74,6 +74,7 @@ struct bap_ep {
 	struct bt_bap_qos qos;
 	unsigned int id;
 	DBusMessage *msg;
+	struct iovec *base;
 };
 
 struct bap_data {
@@ -272,7 +273,8 @@ static int parse_array(DBusMessageIter *iter, struct iovec **iov)
 }
 
 static int parse_properties(DBusMessageIter *props, struct iovec **caps,
-				struct iovec **metadata, struct bt_bap_qos *qos)
+				struct iovec **metadata, struct iovec **base,
+				struct bt_bap_qos *qos)
 {
 	const char *key;
 	struct bt_bap_io_qos io_qos;
@@ -432,6 +434,10 @@ static int parse_properties(DBusMessageIter *props, struct iovec **caps,
 			if (var != DBUS_TYPE_ARRAY)
 				goto fail;
 			parse_array(&value, &qos->bcast.bcode);
+		} else if (!strcasecmp(key, "BASE")) {
+			if (var != DBUS_TYPE_ARRAY)
+				goto fail;
+			parse_array(&value, base);
 		}
 
 		dbus_message_iter_next(props);
@@ -565,7 +571,8 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 		ep->qos.ucast.cis_id = BT_ISO_QOS_CIS_UNSET;
 	}
 
-	if (parse_properties(&props, &ep->caps, &ep->metadata, &ep->qos) < 0) {
+	if (parse_properties(&props, &ep->caps, &ep->metadata,
+				&ep->base, &ep->qos) < 0) {
 		DBG("Unable to parse properties");
 		return btd_error_invalid_args(msg);
 	}
@@ -1247,7 +1254,7 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 	base.base_len = ep->caps->iov_len;
 
 	memset(base.base, 0, 248);
-	memcpy(base.base, ep->caps->iov_base, base.base_len);
+	memcpy(base.base, ep->base->iov_base, ep->base->iov_len);
 	DBG("ep %p stream %p ", ep, stream);
 	ba2str(btd_adapter_get_address(adapter), addr);
 
-- 
2.34.1

