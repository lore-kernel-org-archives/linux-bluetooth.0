Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B5EC7EE26
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 May 2023 14:36:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbjEWOgP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 10:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237280AbjEWOgO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 10:36:14 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2089.outbound.protection.outlook.com [40.107.247.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122BB189
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 07:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=es15UsQGKvaR49HPYrJA8oXrJRcMVuPhNBXFn8QqM0RpvAedDBIQfVBWCRUAdC2XQRPehDPhnlZaOasEcfRji4vEr8z0rCFkFXDui4yvQsdjB+dnCph5g1kP0BYkiwH9Umg1QYhD6TMN4iimQ8UW+ICd+CGgOqh5/IJH6/kBZuxr17cqlDozjQ9P2s9V9ofT94MepivEUgtFGHioucQ7cHfnTsixPQb2NRF8+q1IzijbaIhvSGViklowX4PQFF3KEUKz4U92bfftgJrOEKmEL3prkrHn4jr6qdJaTjIPEghu6wzXJzJjaLcsLglglkazXKKPjTPBtMLyHbMS/Y8Htw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mnn3B48Jte5YG4K5ULAOsgxpgZB2fgijlMiKNf6oUwI=;
 b=fmyFTnp8G4tx3WUy89A3YiUQ3HKbg4xPSz60f2Q+gbhUPZBpk2z5K0cngfw1r5EyWyx4fjctLaMT1/vd1nWKjQME7QU4lwHOVXALYTrzPmqpgxzkOYJavFd/HFQnpx2QkBIoo1Kh28M8GbKrbbwyxcdL3JC86ftObIaWdfrgoT2lw6YNUNvWeadOf9YqvAzDKKiulkrPk6p9qirOxJMFsPN0kstxTwreghYPjhjYL15JYC+HR+zQZCIdEdX58SvXWvRPcfotKgojd58AQLluEpC26Jo8L/G1jpX8HDigvSx7Y/qMkChPxlggOFDk3W2ZnDCOuJtsS18or/6UUX/Nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mnn3B48Jte5YG4K5ULAOsgxpgZB2fgijlMiKNf6oUwI=;
 b=qw7jWABmvtL4yX2bcTdLXLYg954ZBAz2sXmdQVN24j5GfOKMyjiFIA8nV6OJkxqcRYuJZrCvmkCocgj1hnQXXWJ4i6ESJfSmwEQQdxP9PzuV3rTqt9UyK2HAIf+016Ndqo2H5Ve6lcZ4kmw9Jd+qlN1F5ZLGfPoX3xmBX1SUmHU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DUZPR04MB9784.eurprd04.prod.outlook.com (2603:10a6:10:4e0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Tue, 23 May
 2023 14:35:30 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%4]) with mapi id 15.20.6411.029; Tue, 23 May 2023
 14:35:30 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH BlueZ 4/6] btio: Add support for setsockopt (BT_IO_OPT_BASE)
Date:   Tue, 23 May 2023 17:35:02 +0300
Message-Id: <20230523143504.3319-5-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
References: <20230523143504.3319-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0019.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::6) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DUZPR04MB9784:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e275eca-3f40-4ed0-c644-08db5b9af57b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QLEOezjpLKY+AtMvot4xC77Spj+GoZhofmGJhqTxFDkX0IyGA+7WkRWHSyD9oa2fn97xEqk+kwpgmbgxnpHjVyzm9V5G6fY9X4IRB3mzl2dewpGw4yAgpUcu77HgyKKg/9rMkgNn45TXyb1tHuBkwQcJwPDWe3yoFGCxrFeKMpL72zbgr/j/YQ/8mfD6JF8SbpI7yKZ4u2BF9E5IG5MO6JlbBipMVmxqKq6PCiIMSO777fKfKabEuW3Bw71trR/FiNUTjufpCumRFuBEGfFwiGliT4mkX3RcZUM4X+NTTZgay6lVYXZdDhqXUlfXY6RqZfzK2YJ/0LaENJnKE21E7l2W5nJbAxFpr6UUHy+iBUEbSIN6luTscElapc6cB2ja3ykJtDHl5pmC1Nt5m0C+ws9PifyGHgnvXR+7h1m2haBje8ZI9EpTAoTDj3AESm1aKvfE5PGLJLiq0JGRoMHG4GJS6UVuqf/arXr67VQWvyS4jMsI4SK66NV2eQe3CtltIv6wWdwjoH38NLeuuf7Q1KbB6EDB3sniILtIWHsJ8c78nlvU9HBf4aCax7L67tCwuTz0Cj32EuJEqNgQ1VBhl27I6H/M5Op/IwTj0ZwEY2WEvN5iQu+BER31foAPAeqP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(346002)(136003)(451199021)(83380400001)(86362001)(478600001)(38100700002)(38350700002)(2616005)(66556008)(66476007)(66946007)(2906002)(186003)(4326008)(6916009)(26005)(316002)(1076003)(6666004)(6506007)(6512007)(6486002)(52116002)(44832011)(41300700001)(5660300002)(36756003)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FSyCdxwpQQCx1/sOoBKvirSj295HHjvucj9HmOa3XUpV/9DytXP5cFqyNr4I?=
 =?us-ascii?Q?TDUU9/OTnCCq5NDAkiB1MWq4gaoXjOE0lTJ2LflLWLiRtSTnvJXmlzvSgg/b?=
 =?us-ascii?Q?EiRFBFPX8juMB1CHyjCtSCA/iBNn0Mukc6UrQDpi4R2EkpVZq5XLcnsE4+Fh?=
 =?us-ascii?Q?KUt7BZRHiad6VbCmhk6+8oNZ2U5Hx8/dIpsXXmHBToiHQNPf3d8OAcQLyYm0?=
 =?us-ascii?Q?1c+qoMKofWuCTxD6NOj6j+GmmP7fKfiG8i9f9vRoii8TXgGF8SE3mOv5OTbX?=
 =?us-ascii?Q?xed/xriucYvhFGWgK0lrov7HRHW87LT53J/XOfPyZv86cpCcbkZvC7hBDyuO?=
 =?us-ascii?Q?VlT1zD4sY/bnhM5FjYjzzywN8fFRaT2oBuL0pFuI2IaXiP7U0jIxNPS+5hbW?=
 =?us-ascii?Q?VdvMZV3sewLS7EpbbBsxzF5vYHXuemGzxy8uc357nS9VSvGdFGjqNWJ/A9FJ?=
 =?us-ascii?Q?NpEewJdqxM8IdXq4yCDmxuQyZEZ3kIyp4RS7JZVr64m6ZJDVypoAaWNa6Zr6?=
 =?us-ascii?Q?t/zl7EbpkCu0XeVJVVN9LDJ4i9Fi94jCzHtRE+8S1ycmIEFyFiE9q6QhL6z0?=
 =?us-ascii?Q?VN9z7HXLTkZR8Tj7uZYs5OtSZaHmxlETvTmxa9dD2aPn+iVRp18U1J55e8VO?=
 =?us-ascii?Q?focz90tB5gs60YdpOAWRMTmB1Bbc0HLfjVOLL1mwI/ooccKpKRHrXuctvHzJ?=
 =?us-ascii?Q?JtEuUd5kaJ/2qL8faXLrWJsgaq/XyadwfJziePBDVkrWZlWW9SepUKxsrjK2?=
 =?us-ascii?Q?sRMXuofLnH8R+SIi1XOorUelNg56srOJeGC0pH2SnZPoa6sMaA6a8yXt5G13?=
 =?us-ascii?Q?FyEXkCjAuItWsCDF73JLmqm7BdIgYIewZiN5q98TUbJvhbkQx28CnWDmHcWQ?=
 =?us-ascii?Q?y+QVsGHVCA3va8pqxxpqSeuHWTptqHQ9MHEcd3U5ev/G8SDv31wYX1qZS7j1?=
 =?us-ascii?Q?7F9p93dt8FCLTEW6Up0TJEj4SjmA3WDbm3PXdo5++LKmJr2qlhG8W/81X5cs?=
 =?us-ascii?Q?UOzd6bwQDTcutiYSCr8rxoWJffOHLQMGDY7LWsUews0XsV5YsSo90tGPWsR1?=
 =?us-ascii?Q?pkahLP+Gd2IPEanlW2lGzMUFGJ3azqtqbcMmzety8UZidDUeSuaFl6mSc8W3?=
 =?us-ascii?Q?4PCogGN295roJ8cp8YXwgDKBVHxIKKIE58oe1f7rG6rwJL1XtBl8K7dCaEnh?=
 =?us-ascii?Q?wP+HKqxFEhO0rsSXxvp7TjFJ6XKB+/WudbnieDAgqW65S5+RA+DU5szLqgQS?=
 =?us-ascii?Q?NUcwXFYyL65O0JdM3YXuhX5MwJmgYUT+tTpQvWmwoufZ1Vad8E2ouWHObGys?=
 =?us-ascii?Q?h5fSeTALLG/QHVPSNSI5p4RFwhK8hcMqzx+Cycg9DftCKHz1Ipx67AQqiaro?=
 =?us-ascii?Q?hwefthjwI4AAEslyVOCbb729y5ZB+KojQJTgci8Nk7SvQLa6ZWewUis6w7fg?=
 =?us-ascii?Q?2f32RC6AMdFkeWTYjewIKxj061HjMerox+vSlb+r3fvWJBVW6comV/MaJPOS?=
 =?us-ascii?Q?pC8kDpfT6mYQHN64xpqLelr7ISoqb8CSjq7vqTPuVz5eG0EiqxbKLTCeL/Vu?=
 =?us-ascii?Q?ZXXfk/W44JD+q5pnQD5Lsyp+z50RNEvq0nWRHX8d3DpNQswSNcwhJvqKCHTv?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e275eca-3f40-4ed0-c644-08db5b9af57b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 14:35:30.6251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve3Omd+BvQTjkzwvN5IHE9W5GHMchw4l5mJFDwiK27Yr4Fh8yqNW+qpB8qnSh9mnZ+tmx0Val813V5XI0rZERw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9784
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>

This adds btio support for setting the BT_IO_OPT_BASE socket option.

---
 btio/btio.c | 26 +++++++++++++++++++++++---
 btio/btio.h |  2 ++
 2 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 6f6d76dc8..b68bfb14c 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -70,6 +70,7 @@ struct set_opts {
 	uint32_t priority;
 	uint16_t voice;
 	struct bt_iso_qos qos;
+	struct bt_iso_base base;
 };
 
 struct connect {
@@ -858,7 +859,7 @@ voice:
 	return TRUE;
 }
 
-static gboolean iso_set(int sock, struct bt_iso_qos *qos, GError **err)
+static gboolean iso_set_qos(int sock, struct bt_iso_qos *qos, GError **err)
 {
 	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_QOS, qos,
 				sizeof(*qos)) < 0) {
@@ -869,6 +870,16 @@ static gboolean iso_set(int sock, struct bt_iso_qos *qos, GError **err)
 	return TRUE;
 }
 
+static gboolean iso_set_base(int sock, struct bt_iso_base *base, GError **err)
+{
+	if (setsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE, base->base,
+			base->base_len) < 0) {
+		ERROR_FAILED(err, "setsockopt(BT_ISO_BASE)", errno);
+		return FALSE;
+	}
+
+	return TRUE;
+}
 static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 						BtIOOption opt1, va_list args)
 {
@@ -966,6 +977,9 @@ static gboolean parse_set_opts(struct set_opts *opts, GError **err,
 		case BT_IO_OPT_QOS:
 			opts->qos = *va_arg(args, struct bt_iso_qos *);
 			break;
+		case BT_IO_OPT_BASE:
+			opts->base = *va_arg(args, struct bt_iso_base *);
+			break;
 		case BT_IO_OPT_INVALID:
 		case BT_IO_OPT_KEY_SIZE:
 		case BT_IO_OPT_SOURCE_CHANNEL:
@@ -1290,6 +1304,7 @@ parse_opts:
 		case BT_IO_OPT_MTU:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_BASE:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
 					"Unknown option %d", opt);
@@ -1444,6 +1459,7 @@ static gboolean rfcomm_get(int sock, GError **err, BtIOOption opt1,
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_BASE:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1554,6 +1570,7 @@ static gboolean sco_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_PRIORITY:
 		case BT_IO_OPT_VOICE:
 		case BT_IO_OPT_QOS:
+		case BT_IO_OPT_BASE:
 		case BT_IO_OPT_INVALID:
 		default:
 			g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1627,6 +1644,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		case BT_IO_OPT_QOS:
 			*(va_arg(args, struct bt_iso_qos *)) = qos;
 			break;
+		case BT_IO_OPT_BASE:
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -1740,7 +1758,7 @@ gboolean bt_io_set(GIOChannel *io, GError **err, BtIOOption opt1, ...)
 	case BT_IO_SCO:
 		return sco_set(sock, opts.mtu, opts.voice, err);
 	case BT_IO_ISO:
-		return iso_set(sock, &opts.qos, err);
+		return iso_set_qos(sock, &opts.qos, err);
 	case BT_IO_INVALID:
 	default:
 		g_set_error(err, BT_IO_ERROR, EINVAL,
@@ -1820,7 +1838,9 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 		}
 		if (iso_bind(sock, &opts->src, opts->src_type, err) < 0)
 			goto failed;
-		if (!iso_set(sock, &opts->qos, err))
+		if (!iso_set_qos(sock, &opts->qos, err))
+			goto failed;
+		if (!iso_set_base(sock, &opts->base, err))
 			goto failed;
 		break;
 	case BT_IO_INVALID:
diff --git a/btio/btio.h b/btio/btio.h
index 9636fd467..e9a8a01a3 100644
--- a/btio/btio.h
+++ b/btio/btio.h
@@ -5,6 +5,7 @@
  *
  *  Copyright (C) 2009-2010  Marcel Holtmann <marcel@holtmann.org>
  *  Copyright (C) 2009-2010  Nokia Corporation
+ *  Copyright 2023 NXP
  *
  *
  */
@@ -45,6 +46,7 @@ typedef enum {
 	BT_IO_OPT_VOICE,
 	BT_IO_OPT_PHY,
 	BT_IO_OPT_QOS,
+	BT_IO_OPT_BASE
 } BtIOOption;
 
 typedef enum {
-- 
2.34.1

