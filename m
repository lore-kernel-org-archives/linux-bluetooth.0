Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ABDC001DF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  4 Aug 2023 14:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjHDOLs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjHDOLq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 4 Aug 2023 10:11:46 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2057.outbound.protection.outlook.com [40.107.15.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2351BC3
        for <linux-bluetooth@vger.kernel.org>; Fri,  4 Aug 2023 07:11:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gj0sgnudVwAQhvpMoMSANFhMnV3eYeG4Fya+M6w/3x1qtBDXyugCJkrYl2v86l9oXBsn8l/wsiQV9xmK+1BzBF5yvFo/NOVTJjj/Gcup3Ud0Mc1ffnEpiNfHlTTf6MRY9rMfrnBphV62qh4Q6SKXZkff1EplC4zpqf7wUN6rBW77vt7OvOJJxtPyuRJoCbhejB14I6HPZywfeUWNXB4/KAo3TqEC9WXbq7ziSJ6ubv7+62gukT+ZUG/lGlgdgFWT9nUO12wJD/fQyLKIiVgJQRCIrjl6tLq/mSwaCm/snR77bY9Jkg5145vg74InviuXr2QvocJU5B1jfvXdtyme0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VjQziBAdm18KBh1onKTXcfYV04bncbVpIWqcIhzjf8=;
 b=CvrSMzfayU4xBQ/QKjvojLG4vIvMKdhmWs/kUBWWhzmA1itkBfrY41U+2GLRFpyRGK4rv488M070rHo5S6Q7jSDkUudREHJ7rXODN7z7Okwcw+zReNXv+iUuT98odhnNHH7q6m2Rtq7crlLAngB/UnRhhbDG+fSE56n/T3RPW0c0x2yTKwxuAVe1STBnFfp5XZe7D7LTOfXeAMZv1+lSKcnrjMd1E66GVhIfXHMGKo6E1MseMxWm0yRMyUsc0qmK+gEo9KEv6GLy5fjfoyKNg6fYpZl4XXsPi27bNjmJcOqT+vTn/JqJXaOa6qAqB6r+zvu75iVe3R4STmqZ3rT4nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8VjQziBAdm18KBh1onKTXcfYV04bncbVpIWqcIhzjf8=;
 b=NnmuBz7qql9AqNvWTcFqqBWpANNY7KqmBX5Q35BsL6Pf/Iwn1ntQGaJeYyEiFGmdrnoYVQHnVH8RFkfLX92nWMELLM9F0nSglOwfWiXuGpteM9GAhUmjc63RO5R/IjzSrUAk0RSn/vPjJ+gGDzjYaB3MWvaiDcb/Wso/56S3cEk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:11:42 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e67c:9548:36f2:ef3a%6]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:11:42 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH 2/2] bap: Use the BASE structure received from upper layer
Date:   Fri,  4 Aug 2023 17:10:59 +0300
Message-Id: <20230804141059.24352-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804141059.24352-1-silviu.barbulescu@nxp.com>
References: <20230804141059.24352-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0092.eurprd03.prod.outlook.com
 (2603:10a6:208:69::33) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|AS1PR04MB9287:EE_
X-MS-Office365-Filtering-Correlation-Id: 340be216-253e-4d65-9a6d-08db94f4ba67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVE1eQDEJb9NmF/NccTh3UyPKf7ZenndSpycjCv8jeQFMRYRSwEar7yUYFcsrJDTWlPfyX5Hv9m8n/k28hYIQ5KD47BCuAxYBSQV+UgbI0AlFrQwSNHISihmwD1Hmsf+cCdKsyrgQrl7+7Yi1lnvrkuJCKpKblI701mx0TzRcXtZPc5ftr22Qb0wqGmF5IFUfsvTc73mgqq4vZUchEEd87YsNddJYHO52VcVW58dI+4zDPQlWh+VR53IB7wZrjMFa5d2kdqnXkRZWhpTuiskpWdEW3Tj7kR/zIcCsNqf+Su/aQoIt2Qa6PqeuECvUE7HleJk1QnDsz5qUFIR+l186kYocZYGSM6GOhLsqjFuoy0Ghw5XZBDi7f/4KNMiRoHglQGI/TiObwDXAT19laIOZKlB/Go8UqJXZwMpVmqSp7YvLqINn2tG9D3idEJ8E+VfcBVS17Lu7NBUjFXBJL17xBuvvVVuS5LrI3eup90bm71bDJF5Vf4DE08KitRdW/L5QlIZIkJn43JmXkAxsr/y1lcJMlBl2XxJE1DZ323HQtxUzI/4KVJ4ZKaL7aqrO5sXuHZbysHcu5R9MsM6OMQC8niVzPHvt2zzP/7AlW/EzEfmC+kTMqAGuzHXs5H4T5UJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(451199021)(186006)(1800799003)(6486002)(52116002)(6666004)(6512007)(86362001)(26005)(1076003)(6506007)(36756003)(2616005)(83380400001)(38100700002)(38350700002)(66556008)(66476007)(66946007)(4326008)(6916009)(2906002)(316002)(5660300002)(41300700001)(8936002)(8676002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?T9xLK0ndq1jCSnHKO5ieTUsQPEe8xNJlDY7+TBRkY52oCv7hLvFmKzERsAFl?=
 =?us-ascii?Q?weadCCZo4CVblsq7zdF8LqZCpqd1Z0U3V7C8iGzkWopkQMOOtJ51qf5iDz4y?=
 =?us-ascii?Q?eMuxsrmnIthvm1Tk48HGhlc9FupZjvqP3RRPuOegXXNPEG9vl0C52MH9drNE?=
 =?us-ascii?Q?GeFc1RFEMxRC8h34iKxdAlaZW//Q/Goc8l6LvTaGxQo7+bKMBjFgBleoX4a8?=
 =?us-ascii?Q?QEu9S2R49hKuXHi9HE80/Nwlk7zSioLb9LBwp4SnrdFD2JToNYlETaGBrxDv?=
 =?us-ascii?Q?L0SA5tJDzwGNO/fQooJCTFnTzL3FemB3XYX9GNN4CK89U66o85ikIjY4ydKs?=
 =?us-ascii?Q?gT4q3ugolPqJMzyDgvb/yKTcrKZSGSnrQMrx5UF/gJOylZKdKAn8+xHp4298?=
 =?us-ascii?Q?I3CUsEwm2p68XNLjufaxWDRtJWmJWcOMX8xTa9tIAp3rgBk0OKjbKVDNUSle?=
 =?us-ascii?Q?JLJDMCspGZyT0ZAYOwi0wHe53pCU0ELnqj25SP4U6W4UCKb7QlCg/ikDGQl+?=
 =?us-ascii?Q?hyerRJDZKgBlZk1kjZ6Rp22tT8Jc29nmDGMC+UikqwUQn3GvrtIVN5TcjXxB?=
 =?us-ascii?Q?tEFSgYpAUUHE0dTgVPLN2RWs2joF/d4Bb5Q8ZBGjWn64vcgbuxmmNpwVf6vA?=
 =?us-ascii?Q?legb+WFFrRTZMJgw5aId+iqTtdVflNzhuFhuMpbk8coov0cW2cbHwBs44INh?=
 =?us-ascii?Q?eAiGRCjtEndwb9H6BIb2tIlns8Dvpc5YVv/mgG1qmgfxFi3iHWJ4K2yAqycV?=
 =?us-ascii?Q?ieVgaaNYKSoJTbcXrWL6oQbScj63/T5z1Fzkizi/8rcgaBHdYZ56A2+K4dxB?=
 =?us-ascii?Q?2j8JVW4CV34FkBrGfmsnyCeN+WbxNbrIQM1kbD0O3a6S4b//cikVV9LFJBtL?=
 =?us-ascii?Q?HqtWa3/2/MFL+ibmv0jlxGhw6jdlKK76lg81nK8XC34hw1ZIDvmZ3ZUM+Wdc?=
 =?us-ascii?Q?yJK4kN/gVznAax+K0q13uiCPkMqDeqCqE7yFr6L4/a4c5BbkYzv7hoDCcd3R?=
 =?us-ascii?Q?pwe8UE/oxkDD1em2Vb/xk61Kv4gba+9yR7rWhRyH45Cry7iCLc6g4oOGl8Lj?=
 =?us-ascii?Q?Hace1zGMOrJvUIeYlfREeJFFDEnybcDt5CGsi8pAAwEff28/bJASyTgXVZcE?=
 =?us-ascii?Q?/AI73MVP4SLfcLFYEuVttK9b6H2qN9Hl6O9gq49xqPIhuoTbT6AYe6Jjzr+P?=
 =?us-ascii?Q?/7UqislRsEsANp0sNK4L/WsrKLQIZqXB2U62CXBjkUtU3HQpjImL93fPH8uN?=
 =?us-ascii?Q?KKbhU48NF5erPzZBGDJUzf47UKf3kgYdIt5hUksVaDQGPEgwriUM8I30GA2Y?=
 =?us-ascii?Q?MNOgUMOG+gCUQG8Q+HcqdvYVtAD6CyIRT917/OXevH8O+dN5pVW7N0FYx+Fj?=
 =?us-ascii?Q?ro8br5+fWo+/awjZHtnSHhcFIQFflhW9a1Zq8L99RwxYQ584WjEksxBvxjKy?=
 =?us-ascii?Q?dvRdwg6WHERoPYnPZOPTcAPnsmxQjpkd0RYsreimGoM85dMkbziDFwTrFXpr?=
 =?us-ascii?Q?w9b0F8ffkdGm8wzp1B+c921soKG+eqi1WxtP+ZA4DCLnHxYCLTKeESNft4qr?=
 =?us-ascii?Q?yI+M4wwryKIy1zz3muQKyFVQ1lCSBWsSkgySaI7vlj82l/nHRq4D1buGlt6S?=
 =?us-ascii?Q?wA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 340be216-253e-4d65-9a6d-08db94f4ba67
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:11:42.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NH5twAMFxuz+/KnYto8ZChDKuHHIs7x+ICCJXiIZ3vnBSfHmiPhpvhEIC/jacDrwjXxHdvhWnFPg/UEdCxnrWIC72UwxSP/vryxE/V6T1tQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9287
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

