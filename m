Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BAADE80A93
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Sep 2023 06:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjI0GYz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Sep 2023 02:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjI0GYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Sep 2023 02:24:53 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2054.outbound.protection.outlook.com [40.107.6.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826059C
        for <linux-bluetooth@vger.kernel.org>; Tue, 26 Sep 2023 23:24:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPf6MYxju1g1xD6vzQgT3fsBWxM7+bcCtzfx/ZvyPLRtjaA2MgpCAhEFWpp5OuzDjgPK3ydDV8m/5P26GpuesoS3XlvtfF4NIdjJt/q8USUJ3OUCPQ30lJ/WNedD8uXr7Witbg+e8VlaIPRXEax/nRo1m9uG8lDWuXSs7OlNKzCkXgIrUj1yzVZ7qLhv7jSJTgORMD/1Hh4M0g0YtAlvQ1Nk97wv4jrGya/gflfScMENA9IpzVCtNRDy/dL2iiVLQxWQBC+WhctQaqzqaHvF0GTxE0G1JzQSsXRrOuwzQISIuxsFblO5dy9RIEgImdvLuXeUXflOZR7AzexpqqqElw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N4kxkbiA1P8RApEctRA9+r0VtLfWKEj2k6WAE6pMMdw=;
 b=fF8gm67LYFFG/ZAiNvLc5Jrfz0yaWkWyo9PCrWylIBj48jlJY4MKmVJp3jhOEN3y4XqqyT8Rkt84GamNxQ4DOuyRtEghtybkwEYrS8LMbBXfjHqiyCgRWwappBVxYQfjBejA652shFzAppmzJrTZzoMc7Rn5RYhAzcG8Bw4sJzlQxuOdZOT2HLT4jwPeoTdRAzijVDv8jr/Br9bKVQZUiX61wNlRabW4KkhDgsBs0nofuhzZaa1FSFHO/bp4izeE3A6qocvVOxyb3o1Yk9Oree4fTRXvmzjailF5grB99MdkwqqYb7tyik0mhBP3WydjDEZWU4PgJsotzmBG6vEVRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N4kxkbiA1P8RApEctRA9+r0VtLfWKEj2k6WAE6pMMdw=;
 b=Pl1/XekV9+XSzkWAqTs9fx7CZm7mqBVGEBsMeGWbA1WyDkkUsqzt0HdSlbwx4rYZ/R3xHkSI2Sitx4xue7l8HmKG/IkmYYUZYW54SqcILUeIhozHpCBOesyjmXv7IG/6DJpP2P23oyMujHy75eW8ll/eYOvYB7wBXhvOiPZGqfs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com (2603:10a6:20b:409::20)
 by VI1PR04MB6910.eurprd04.prod.outlook.com (2603:10a6:803:135::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 06:24:51 +0000
Received: from AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4]) by AM9PR04MB8938.eurprd04.prod.outlook.com
 ([fe80::20ce:af06:5cc:a1a4%4]) with mapi id 15.20.6813.027; Wed, 27 Sep 2023
 06:24:51 +0000
From:   Andrei Istodorescu <andrei.istodorescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        iulia.tanasescu@nxp.com, luiz.dentz@gmail.com,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>
Subject: [PATCH BlueZ 1/2] bap: Remove memory leaks and buffer usage after free.
Date:   Wed, 27 Sep 2023 09:24:35 +0300
Message-Id: <20230927062436.6306-2-andrei.istodorescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230927062436.6306-1-andrei.istodorescu@nxp.com>
References: <20230927062436.6306-1-andrei.istodorescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8938.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8938:EE_|VI1PR04MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: fdd06300-d7e5-4ffc-e233-08dbbf2274bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zC7s/Mr2n8HF+fvVwPm4ltnUYRuLgiGJ94z5oXWDTcCSdUe2t9eA1O01cQ+WONEa9TqiBk/NuyNVIHlhTwUyJerzADHaSMwCXNnvLEijbeHhXxFb/mp5zqct5UFme5A+MKRbH6QyG3QbKlcodEu4vwpDwxaYYbcKdMXGQS9+YmYVJkPe6230PFh8RwmiNCExJgfyyw6CM/np2Y2B8WWO437E1C8I44u84m6ETGu3Zxzg10Q5ylJ4tB9g90055eDVduJ+TAwFnctshjbLtYIrVzcfezzRxgjW90CTc1UiIN+x4ODHV+3L8DtuKbOoZ6lA1v4cPaJajQgcV9kwUjkRQCwhWC1HwVr6AoZNl1ostgs+jIDQsVTZKuCMNTjFkUeUT26TMyTtep/ArYYYQDSluUdCJR6wvFfY8KwoWSkeyrPCDo4Nml4qP0vf+iS7P0MzSCxPwDPjrq66IChAncydc14konALYVPIzNCMt+SViTdiri4t9475kut6xcVLGxECwiTTKvveZoT3G+bSaQm9dk9aaf08IWA4DsDyEyfC4/sIB+NrmjcWuDOuh7PEc+88
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8938.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(1800799009)(316002)(5660300002)(83380400001)(6916009)(41300700001)(44832011)(8676002)(8936002)(36756003)(2616005)(4326008)(66946007)(1076003)(6666004)(6486002)(6512007)(6506007)(66476007)(66556008)(26005)(86362001)(2906002)(38100700002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UtmjILCdgG9OSFJ3TjQT2ShDSk8OQUPh+jU+kgS6OBti3OOHfG9tkPzK27My?=
 =?us-ascii?Q?yh3me2vKPNjVRwhs89Fpy8DD6uGse0isFiUFcaRO52W5aJ5YWbD8PdOZOwtc?=
 =?us-ascii?Q?f43pGKdFyLAj3jah1vzTgloUJin+a3KXb7MG6s5OHS4RQ1uOdV916ZBh60Tq?=
 =?us-ascii?Q?D1tTln5327MwbRD9llwrnQGA6YRc5P+/OtdqbBgrBL5NKT+AFhqXIZFkGA5w?=
 =?us-ascii?Q?XlY+W+j0neCjhv3p9V9du83ksDsS9b5QQ96JAnEjpghdo0EHiYNJ1yMxZ6QK?=
 =?us-ascii?Q?tn6npuKIH2GPrhd7DU/D4qwDLAT75P8A8z55QF3fry17wYeeNQkikZeFL3sn?=
 =?us-ascii?Q?tmKShJ9luyFEiGO1r/iX17RVf85Zfq3eu+fj/LTDOWqARVHcTCPgevuMj4A4?=
 =?us-ascii?Q?Q/prhDFCHjGlHBVcH8AkJKAZAvBhW2BDE1aSUCxnUjKMVm2FQ61XGxt5+It2?=
 =?us-ascii?Q?+hY62U1c5Rdv6Iwi8W6VYTf1CSjnjFQg/Z0WHhXSoY5hz5pVATIpOckRvMUF?=
 =?us-ascii?Q?JJvcY3le+TSWotVbTbXCk60hbHjuZAMszg+XB4psKR8MmZLYCuvst/B/OMwC?=
 =?us-ascii?Q?I/LVIU3abmZHDsc4zyMIVv9c1ViGz6AFROS+pPT1PysSlT+vE8aNWSicQ4+A?=
 =?us-ascii?Q?ipkXiUCOkrhmqKUzQJg0nxXouLX/9FudJgmvjzyTbqr+LyQHf9idNBTRQDZ9?=
 =?us-ascii?Q?8N92sWZWa93aYpiQkCiks0g4xMLlZeNVLB+qP6hchmdBot9olhe7m6rNt1Kz?=
 =?us-ascii?Q?MXRfBD/eyl2QV/wjIkfVbvvf5+F9w/cHYZ5ohWpskWzbYjSCpSfpJXHOX+QY?=
 =?us-ascii?Q?3/3bmJc/Pus4arLXcYu3hjlfPH6b4v65tXeDbPXpR/lH6BZnvGpdlweq7+B9?=
 =?us-ascii?Q?PbzymHpQjj05/drRg13EhMdjee9jjX9Oy9iyY0KnoPMUbOeeoMuuT5GZFVPo?=
 =?us-ascii?Q?wTaxkjCBnVv7DJ5Fl4HlcK9FT7WJWwf3EkzuuPAqbMunsfYn3aiSU5lNpOUQ?=
 =?us-ascii?Q?9g2SQXfPiGpZBBW98zHFCYQgO6AVGK9/a/Fy+Hm+cpB7VUxegsw+y4OWE4S9?=
 =?us-ascii?Q?yxukj3cP4GgVo3+VUKynS0OhxcBeMnxtnJtvNNtRRzvX1zVOGTvlldI0h5xc?=
 =?us-ascii?Q?24ylZlgHtFrnuJY3+0lji9YpZArhojrLEINCLdC9s/bUrxLLfb1aFmEwIUfa?=
 =?us-ascii?Q?v/0fz/pRptodGx760TntmxqK5qHO+xNM2L9wDbdJXJ3IA2mCuigsSdpDCurt?=
 =?us-ascii?Q?l+jJbODsyav9DOk6jn4084waL4hXRAHnW8DHLN5A48o52zg6lhMOuiEr8lwj?=
 =?us-ascii?Q?WELQcxx7zA0xAf57A2+RFhA7pvGQqoCCvmXB7bhmlduOPMHjkjhQVbo449ee?=
 =?us-ascii?Q?i1LEbNRaK7zN0N3teBBo5RCnQ6P+IQwJf3m0TGqUoT3GGn/ogOgqPevn9zki?=
 =?us-ascii?Q?Yu6/tDKK5ObWFpTF6PHpH/ocM9S/IwrIuyjPGqyjDLxmGSn3a2Kzz/bbzHY+?=
 =?us-ascii?Q?nYHTDBNtvXEbFSHvCGCzv3Cx5YoZGWoyV7uB4bg5nEljbNLO578arribi9Al?=
 =?us-ascii?Q?LN++ApcBLVsoVeFsjymmpA2L43Y5Az2eRUHZxIFmdsJ60CC2+ldgEr0dpWQ5?=
 =?us-ascii?Q?UA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd06300-d7e5-4ffc-e233-08dbbf2274bf
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8938.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 06:24:51.2571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z5Fw3l8q67MUD6Kez27nUKP83PF60s7+r3BQecyCMvZcEmraZaF8DH17L/SSmAEiGpunIIogSbvtf7fteo6MUlbk1yNMlMwNPCgpwzTNhkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6910
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Make sure the endpoint does not contain uninitialized pointers after
creation. Rework parse_base and parse_array. Add missing unregister in
bap_exit.
---
 profiles/audio/bap.c | 66 ++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index ee90426b9812..b164f68d3187 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -278,16 +278,17 @@ static const GDBusPropertyTable ep_properties[] = {
 static int parse_array(DBusMessageIter *iter, struct iovec **iov)
 {
 	DBusMessageIter array;
+	struct iovec tmp_iov = {0};

 	if (!iov)
 		return 0;

-	if (!(*iov))
-		*iov = new0(struct iovec, 1);
-
 	dbus_message_iter_recurse(iter, &array);
-	dbus_message_iter_get_fixed_array(&array, &(*iov)->iov_base,
-						(int *)&(*iov)->iov_len);
+	dbus_message_iter_get_fixed_array(&array, &(tmp_iov).iov_base,
+						(int *)&(tmp_iov).iov_len);
+
+	*iov = util_iov_dup(&tmp_iov, 1);
+
 	return 0;
 }

@@ -300,7 +301,8 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 		.iov_base = data,
 		.iov_len = len,
 	};
-
+	struct iovec *csc_iov = NULL;
+	struct iovec *meta_iov = NULL;
 	uint8_t capsLen, metaLen;
 	uint8_t *hexstream;

@@ -330,22 +332,21 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 				"Codec", codec->id, codec->cid, codec->vid);
 	}

+	/* Fetch Codec Specific Configuration */
 	if (!util_iov_pull_u8(&iov, &capsLen))
 		return false;
 	util_debug(func, NULL, "CC Len %d", capsLen);

 	if (!capsLen)
 		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
-	}

+	csc_iov = new0(struct iovec, 1);
+	util_iov_memcpy(csc_iov, iov.iov_base, capsLen);
+
+	/* Print Codec Specific Configuration */
 	for (int i = 0; capsLen > 1; i++) {
 		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+		uint8_t *csc;

 		if (!ltv) {
 			util_debug(func, NULL, "Unable to parse %s",
@@ -356,35 +357,46 @@ static bool parse_base(void *data, size_t len, util_debug_func_t func,
 		util_debug(func, NULL, "%s #%u: len %u type %u",
 					"CC", i, ltv->len, ltv->type);

-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
+		csc = util_iov_pull_mem(&iov, ltv->len - 1);
+		if (!csc) {
 			util_debug(func, NULL, "Unable to parse %s",
 								"CC");
 			return false;
 		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+		util_hexdump(' ', csc, ltv->len - 1, func, NULL);

 		capsLen -= (ltv->len + 1);
 	}

+	/* Fetch Metadata */
 	if (!util_iov_pull_u8(&iov, &metaLen))
 		return false;
 	util_debug(func, NULL, "Metadata Len %d", metaLen);

 	if (!metaLen)
 		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+
+	meta_iov = new0(struct iovec, 1);
+	util_iov_memcpy(meta_iov, iov.iov_base, metaLen);

 	hexstream = util_iov_pull_mem(&iov, metaLen);
 	if (!hexstream)
 		return false;
 	util_hexdump(' ', hexstream, metaLen, func, NULL);

+	/* Update caps and meta with received Codec Specific Configuration and Metadata */
+	if (caps) {
+		if (*caps)
+			util_iov_free(*caps, 1);
+		*caps = csc_iov;
+	}
+
+	if (meta) {
+		if (*meta)
+			util_iov_free(*meta, 1);
+		*meta = meta_iov;
+	}
+
 	return true;
 }

@@ -780,7 +792,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	char address[18];
 	struct bap_ep *ep;
 	int fd;
-	struct iovec *base_io;
 	uint32_t presDelay;
 	uint8_t numSubgroups;
 	uint8_t numBis;
@@ -807,12 +818,11 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	if (!ep)
 		return;

+	/* Update endpoint with the values of the peer's (BAP source) QOS */
 	update_bcast_qos(&qos, &ep->qos);

-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
-
-	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
+	/* Update endpoint with the value received from the peer's (BAP source) BASE */
+	parse_base(base.base, base.base_len, bap_debug,
 			&presDelay, &numSubgroups, &numBis,
 			&codec, &ep->caps, &ep->metadata);

@@ -917,6 +927,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 		return ep;

 	ep = new0(struct bap_ep, 1);
+	memset(ep, 0, sizeof(struct bap_ep));
 	ep->data = data;
 	ep->lpac = lpac;
 	ep->rpac = rpac;
@@ -2288,6 +2299,7 @@ static int bap_init(void)
 static void bap_exit(void)
 {
 	btd_profile_unregister(&bap_profile);
+	btd_profile_unregister(&bap_bcast_profile);
 	bt_bap_unregister(bap_id);
 }

--
2.39.2

