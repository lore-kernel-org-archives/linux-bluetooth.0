Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD5B3C25B67
	for <linux-bluetooth@archiver.kernel.org>; Thu, 26 Oct 2023 14:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbjJZOvZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 26 Oct 2023 10:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjJZOvX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 26 Oct 2023 10:51:23 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2042.outbound.protection.outlook.com [40.107.7.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C1C1B9
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Oct 2023 07:51:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1kop7+ai/o5901VKRAQ7uDU0Gb3kF2K7Dv7AKXtPYhT3SM6InAj05d0KeeENZTvlwQQT0hmTOdJ4/CEb+5f5KNSKwAs42j8g/5iCuvudKP2Kzov4O+i2u3sleEpDfHeXQftCTu8iXCkS7dbFln/ZwtUjEQjoTnGsdR7mIFoJKpWpI2RSBNDAXGlpHKoXma0PXnG0AtAN74TKf4wE2IjclHDYEh2D03e+YQXfiDLuPZoTCfZfxMWT3fhUE9o/KHrFIlb8Wc16dVzsACTRnGjc+ozFHsvLJYo11TePM0Ag9oLxfHZeNckzTT938KIgp1bgfHxIGXa34fspI4+DnCs6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0xisGD6BvHBMp8NuW6IS3MMUI1rVYg7+s7Oe9UZUYU=;
 b=IKEeruvaCZR+9VSbPcnUeukuhARfmSYvnux/FOtLfHfYvdQ+au1lq8zzDcXbBUxQxX8dV2qsbJVbeFJo8ESHKrhVR2v70blVk701BUsE7T8c96Er82x6HoHtuXBqBqM9oMjauPMzLDbCpIk53kdhBMW9qZKbZDzIrqHdg7TBgtIQrS3NG/bpaRj9KohqK9t1J1ZWiICf0YHW1ldyts7ihDkZNlQ/IXEqH/n80aHr4q37A1VX6GQvjNMYRdRgu+kY3V0x2kOfMIVGPTbC5lJKlxvFnkkJp2USxKmGR4hptsBx9gbH5uSiFYc2c0GiwpnqDNT2tOLDPrZjC02T3lKspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0xisGD6BvHBMp8NuW6IS3MMUI1rVYg7+s7Oe9UZUYU=;
 b=FNikXaz7+J+jIwn4fP1zH1HyujLUaDzkL8L0UaNQ7LsOljpJBKza2JKzN2pUll0yGfk2IbT5fxg1zk7B6sfLX+ycWHNQm5hgn1CORtk7c6fxYC0oOUzSb7/K8OAASuRh7rv2Zzf7+Uqgp5YUF8ndr/hxJR15T9WarJhnCGPA48w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com (2603:10a6:10:ca::21)
 by DB9PR04MB9939.eurprd04.prod.outlook.com (2603:10a6:10:4c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 26 Oct
 2023 14:51:10 +0000
Received: from DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a]) by DBBPR04MB6331.eurprd04.prod.outlook.com
 ([fe80::7c8a:c8da:e6a5:8a4a%7]) with mapi id 15.20.6933.009; Thu, 26 Oct 2023
 14:51:10 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        iulia.tanasescu@nxp.com
Subject: [PATCH 4/6] Add support for multiple BISes
Date:   Thu, 26 Oct 2023 17:50:45 +0300
Message-Id: <20231026145047.4637-5-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
References: <20231026145047.4637-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1P195CA0059.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::48) To DBBPR04MB6331.eurprd04.prod.outlook.com
 (2603:10a6:10:ca::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB6331:EE_|DB9PR04MB9939:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d8928ac-ecd5-4db4-2e6b-08dbd632fe10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ydr+uoSsy5/DfzWEmCz2JXs+GqAn2nQQ4Kcuo4OrjBj8gTrVqs4TlCl4tcNwaaUMIjD0WuysiAxzpEQxc3MeRKTW3MRKkxIiSXmXHPPxvpYA5uwVzMGjMT4Et3LjC1I4Zpo8sxdDwX7ZWostbg7CWN8edCPpDym5rNbp/sxU6vovFx/A6s7rEtrkkZnbP5Q3g5zUy5GjQ7ZUmuP7NV5UslNxM8df0MHY3FlJXNZRcCBmhLWthANDAume2jCaFb7bJBFytiQOvlcrjvdKCEZPasZ44A6Vu7Y38hRdcau8Nu9SXlThoyPTncVy0suMg9nE4AzgOXjWAhq/XWlTD0Gcylxosv5Hc2qbP1GlIXS1bXb1f+vTmAmLdGp4wPYzCh+mXdy/yUH/qFGJA79kHeU+wOLFFmm9293CCffiPW5KJTARGkQfD9BxP1EZoG+9uECB72z0lehIApxEvmA7d5/MiSjzviaeQMeQAxR4CuCXSBFLlB8YZDStEfAYqmmQlejYj6sUemwR1sOU/i8YGbsqVin7IYF+7AS13hYqGls69KnZvvgaEE0k7I3TTfHt3HqO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6331.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(66556008)(66946007)(316002)(41300700001)(66476007)(478600001)(6916009)(4326008)(6506007)(6512007)(6666004)(8676002)(8936002)(6486002)(1076003)(26005)(5660300002)(2616005)(83380400001)(2906002)(30864003)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Kqag1Ppux2loeNYKL/25gJAoB27rqB0CfhItbfwEwiZfPcaS3FmH2GT/89BQ?=
 =?us-ascii?Q?SDb+/ZH3e4EzmpZkD0XyhmRXnd2ahpz6MZWGVzgxWp1e7BW7mFXSzLyyTl8j?=
 =?us-ascii?Q?Sc3RfeOZElnBgSYVgKhlc1wkCE+qaF7FSSqGZfKz9t0LcJKWgcVwucdGsahJ?=
 =?us-ascii?Q?v3iKckxwMbf9dKGX96j7A8sSyR/Cm4S1VsYW0FAJcMJazHVBtrQi6kOqY2CW?=
 =?us-ascii?Q?HjBvCKInfroBTwJ9iZA2eSaz6BdpojyLmEMpmcy65fBeYykxcE+5LfG1ErBj?=
 =?us-ascii?Q?SVXhdz6XY3vmGwI7W1hjvNeiMVXYAGJ+DB9h9saSnN5OpVRCaVPzDIfWChrJ?=
 =?us-ascii?Q?T6OJNJXAZmtrTrvKaw4E5LAWAfzzyoCrip1PslFnn1Pf+9nxHoIi9NiNJqaw?=
 =?us-ascii?Q?1HOs0uTShSCKyfTKfZ/tny1QmjSUzADdoRqBFns2dEfuKbOLmZroZ4jsuFXn?=
 =?us-ascii?Q?oHkwEiyhbhZ7R6qN2xB1MMkbuxNb092B2lT7X5k8uHsEfaMGLJ4yezL2//Bk?=
 =?us-ascii?Q?vkBPYnY+VHD7vInTaNO5BqvPlJ4Ag976wdFF78UmR709HUOSdrq/onMkEVnW?=
 =?us-ascii?Q?zebaSE2mMkgHw4AbgA1x973JVouMEadhdO/wNp6vicaWMX8eZni3WcAMiESV?=
 =?us-ascii?Q?0tI4OMzUG0+lbN3BMOrYzALxi7SlPL9dh5sznsbRlm5WAP9ryNjpHsgj8SME?=
 =?us-ascii?Q?poFunPzUOHUxLJ3s7k70TGmSrg0qJxMdhSMfpHYgDtP4XH2bccwqv1bATX5S?=
 =?us-ascii?Q?iKhaKJE5XG1RGhi7FRp5Pzw1iYDQlzRuIV/bpZVg4+Jv/y1viq/QgabMWhs0?=
 =?us-ascii?Q?NNOAOTcNYheduDnJGRPqmiJexJUw39S6+xedw6ifFAeKcoOfIzcAhF3QONK/?=
 =?us-ascii?Q?+Rir+gcNExNilec6YRSBeuHZAcQVn5Kx1U2jlvVYQ7nLUDwzALLb48c0MkUr?=
 =?us-ascii?Q?vNp1nOz9AmcnSXVyzjlpYEuy9VZu9fwn8W9GTNJHO0Vja4ZL5AQ+i+B0NKWd?=
 =?us-ascii?Q?5MYjwBS2hryWxD3/Qwmxs8Lfp/NDDUcfOlMn9U8GfaDZVji5MANK0asj0qis?=
 =?us-ascii?Q?IX4XZm2UIJAz19bXT3o39EpiYmpikjWpLmkDEuMPjTE91VDG1AP8r2H4mgo7?=
 =?us-ascii?Q?DZOq7QYTW6Nkthh8s0WNMZtFa1bLDAr7dsLUZkgBigDW2CjWamj/LLT5W294?=
 =?us-ascii?Q?BqwW6dN9TckiRKXmF+C7BFY6c/4cfELeEAE7LgiHXUfwfYl+PYvRT/NjttSP?=
 =?us-ascii?Q?Oo7pWmlWp2mxvlqZ0QxKgBVRtGy+KDBh8pdIyyWRE7jNNhNnuLLRVVn9tC0s?=
 =?us-ascii?Q?dyAiaJ6b3NGVn2fzS+Al+ZXmvaklxarQ1pNpMrSyn5thnNMcNqx3ojMJOZs9?=
 =?us-ascii?Q?D3IXPx+Y29ChoC118UvRFsD/HPYvvH9CG3Bs1XHyy8JZPodRcU8AOT7UIfiB?=
 =?us-ascii?Q?cWAKrn23tFKY2TpeFB9Z88RAH54p0is0Rcpw1ENEvgXkGxnHRZ3fybaeJ6Qs?=
 =?us-ascii?Q?8Nz6lKx3zrWI+skr0sAdObhA4E4rl33xaBtCDDYPMg3pOYBGe6B1l2Mf+OPR?=
 =?us-ascii?Q?sY4ExjJbUG3x/mui6Dmt+6GoSybiPHN3OIbJVUvS362jSpjHGAQcnaGpM9OK?=
 =?us-ascii?Q?mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8928ac-ecd5-4db4-2e6b-08dbd632fe10
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6331.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 14:51:10.4647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: haHtYZbKtYZUHRALxJpffnUb4RJIdP7nl5DW3M+qmRFhzfjU7GuOKAnyKqYJMU3J5NNYP3DAh4UIYx55tbV4lMdITXXSVOlevDbOjCWKXv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9939
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add support for multiple BISes in broadcast source and sink

---
 btio/btio.c            |   4 +-
 profiles/audio/bap.c   | 458 ++++++++++++++++++++++++++++-------------
 profiles/audio/media.c |   3 +-
 src/shared/bap.c       | 191 ++++++++++++++---
 src/shared/bap.h       |  36 +++-
 unit/test-bap.c        |  12 +-
 6 files changed, 521 insertions(+), 183 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index d30cfcac7..ec6b6c4ab 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -247,7 +247,8 @@ static gboolean server_cb(GIOChannel *io, GIOCondition cond,
 	GIOChannel *cli_io;
 
 	/* If the user closed the server */
-	if ((cond & G_IO_NVAL) || check_nval(io))
+	if ((cond & (G_IO_NVAL | G_IO_ERR | G_IO_HUP)) ||
+			check_nval(io))
 		return FALSE;
 
 	srv_sock = g_io_channel_unix_get_fd(io);
@@ -1654,6 +1655,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		return FALSE;
 	}
 
+	len = BASE_MAX_LENGTH;
 	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE,
 			&base.base, &len) < 0) {
 		ERROR_FAILED(err, "getsockopt(BT_ISO_BASE)", errno);
diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index a84181e1a..8dabd06b6 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -97,6 +97,35 @@ struct bap_data {
 	void *user_data;
 };
 
+#define DEFAULT_IO_QOS \
+{ \
+	.interval	= 10000, \
+	.latency	= 10, \
+	.sdu		= 40, \
+	.phy		= 0x02, \
+	.rtn		= 2, \
+}
+
+static struct bt_iso_qos default_qos = {
+	.bcast = {
+		.big			= BT_ISO_QOS_BIG_UNSET,
+		.bis			= BT_ISO_QOS_BIS_UNSET,
+		.sync_factor	= 0x07,
+		.packing		= 0x00,
+		.framing		= 0x00,
+		.in			= DEFAULT_IO_QOS,
+		.out			= DEFAULT_IO_QOS,
+		.encryption		= 0x00,
+		.bcode			= {0x00},
+		.options		= 0x00,
+		.skip			= 0x0000,
+		.sync_timeout		= 0x4000,
+		.sync_cte_type		= 0x00,
+		.mse			= 0x00,
+		.timeout		= 0x4000,
+	}
+};
+
 static struct queue *sessions;
 
 static bool bap_data_set_user_data(struct bap_data *data, void *user_data)
@@ -254,7 +283,11 @@ static gboolean get_device(const GDBusPropertyTable *property,
 	const char *path;
 
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		path = adapter_get_path(ep->data->adapter);
+		/*
+		 *Use remote endpoint path as fake device path
+		 *for the remote broadcast source endpoint
+		 */
+		path = ep->path;
 	else
 		path = device_get_path(ep->data->device);
 
@@ -379,100 +412,150 @@ static int parse_array(DBusMessageIter *iter, struct iovec *iov)
 	return 0;
 }
 
-static bool parse_base(void *data, size_t len, util_debug_func_t func,
-		uint32_t *presDelay, uint8_t *numSubgroups, uint8_t *numBis,
-		struct bt_bap_codec *codec, struct iovec **caps,
-		struct iovec **meta)
+static bool parse_base(struct bt_bap *bap, void *data, size_t len,
+		util_debug_func_t func, struct bt_bap_base *base)
 {
+	uint8_t numSubgroups;
+	uint8_t numBis;
+
 	struct iovec iov = {
 		.iov_base = data,
 		.iov_len = len,
 	};
+	util_debug(func, NULL, "BASE len %ld", len);
+	if (!base)
+		return false;
 
-	uint8_t capsLen, metaLen;
-	uint8_t *hexstream;
+	if (!util_iov_pull_le24(&iov, &base->presDelay))
+		return false;
+	util_debug(func, NULL, "PresentationDelay %d", base->presDelay);
 
-	if (presDelay) {
-		if (!util_iov_pull_le24(&iov, presDelay))
-			return false;
-		util_debug(func, NULL, "PresentationDelay %d", *presDelay);
-	}
+	if (!util_iov_pull_u8(&iov, &base->numSubgroups))
+		return false;
+	util_debug(func, NULL, "NumSubgroups %d", base->numSubgroups);
+	numSubgroups = base->numSubgroups;
 
-	if (numSubgroups) {
-		if (!util_iov_pull_u8(&iov, numSubgroups))
-			return false;
-		util_debug(func, NULL, "NumSubgroups %d", *numSubgroups);
-	}
+	for (int sg = 0; sg < numSubgroups; sg++) {
+		struct bt_bap_subgroup *subGroup = new0(
+						struct bt_bap_subgroup, 1);
+		uint8_t capsLen, metaLen;
+		uint8_t *hexstream;
 
-	if (numBis) {
-		if (!util_iov_pull_u8(&iov, numBis))
-			return false;
-		util_debug(func, NULL, "NumBis %d", *numBis);
-	}
+		subGroup->subGroupIndex = sg;
 
-	if (codec) {
-		codec = util_iov_pull_mem(&iov, sizeof(*codec));
-		if (!codec)
+		util_debug(func, NULL, "Subgroup #%d", sg);
+		subGroup->bap = bap;
+		subGroup->bises = queue_new();
+
+		if (!util_iov_pull_u8(&iov, &numBis))
 			return false;
+		util_debug(func, NULL, "NumBis %d", numBis);
+		subGroup->numBises = numBis;
+
+		memcpy(&subGroup->codec, util_iov_pull_mem(&iov,
+		sizeof(struct bt_bap_codec)), sizeof(struct bt_bap_codec));
 		util_debug(func, NULL, "%s: ID %d CID 0x%2.2x VID 0x%2.2x",
-				"Codec", codec->id, codec->cid, codec->vid);
-	}
+			"Codec", subGroup->codec.id, subGroup->codec.cid,
+				subGroup->codec.vid);
+		if (!util_iov_pull_u8(&iov, &capsLen))
+			return false;
+		util_debug(func, NULL, "CC Len %d", capsLen);
+
+		subGroup->caps = new0(struct iovec, 1);
+		subGroup->caps->iov_len = capsLen;
+		util_iov_memcpy(subGroup->caps, iov.iov_base, capsLen);
+		DBG("subgroup caps len %ld", subGroup->caps->iov_len);
+
+		for (int i = 0; capsLen > 1; i++) {
+			struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+			uint8_t *caps;
+
+			if (!ltv) {
+				util_debug(func, NULL, "Unable to parse %s",
+							"Capabilities");
+				return false;
+			}
 
-	if (!util_iov_pull_u8(&iov, &capsLen))
-		return false;
-	util_debug(func, NULL, "CC Len %d", capsLen);
+			util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
 
-	if (!capsLen)
-		return false;
-	if (caps) {
-		if (!(*caps))
-			*caps = new0(struct iovec, 1);
-		(*caps)->iov_len = capsLen;
-		(*caps)->iov_base = iov.iov_base;
-	}
+			caps = util_iov_pull_mem(&iov, ltv->len - 1);
+			if (!caps) {
+				util_debug(func, NULL, "Unable to parse %s",
+									"CC");
+				return false;
+			}
+			util_hexdump(' ', caps, ltv->len - 1, func, NULL);
 
-	for (int i = 0; capsLen > 1; i++) {
-		struct bt_ltv *ltv = util_iov_pull_mem(&iov, sizeof(*ltv));
-		uint8_t *caps;
+			capsLen -= (ltv->len + 1);
+		}
 
-		if (!ltv) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"Capabilities");
+		if (!util_iov_pull_u8(&iov, &metaLen))
 			return false;
-		}
+		util_debug(func, NULL, "Metadata Len %d", metaLen);
 
-		util_debug(func, NULL, "%s #%u: len %u type %u",
-					"CC", i, ltv->len, ltv->type);
+		subGroup->meta = new0(struct iovec, 1);
+		subGroup->meta->iov_len = metaLen;
+		subGroup->meta->iov_base = iov.iov_base;
 
-		caps = util_iov_pull_mem(&iov, ltv->len - 1);
-		if (!caps) {
-			util_debug(func, NULL, "Unable to parse %s",
-								"CC");
+		hexstream = util_iov_pull_mem(&iov, metaLen);
+		if (!hexstream)
 			return false;
-		}
-		util_hexdump(' ', caps, ltv->len - 1, func, NULL);
+		util_hexdump(' ', hexstream, metaLen, func, NULL);
 
-		capsLen -= (ltv->len + 1);
-	}
+		for (int bis_sg = 0; bis_sg < subGroup->numBises; bis_sg++) {
+			struct bt_bap_bis *bis;
+			uint8_t capsLen;
+			uint8_t crtBis;
 
-	if (!util_iov_pull_u8(&iov, &metaLen))
-		return false;
-	util_debug(func, NULL, "Metadata Len %d", metaLen);
+			if (!util_iov_pull_u8(&iov, &crtBis))
+				return false;
+			util_debug(func, NULL, "BIS #%d", crtBis);
 
-	if (!metaLen)
-		return false;
-	if (meta) {
-		if (!(*meta))
-			*meta = new0(struct iovec, 1);
-		(*meta)->iov_len = metaLen;
-		(*meta)->iov_base = iov.iov_base;
-	}
+			bis = new0(struct bt_bap_bis, 1);
+			bis->bisIndex = crtBis;
 
-	hexstream = util_iov_pull_mem(&iov, metaLen);
-	if (!hexstream)
-		return false;
-	util_hexdump(' ', hexstream, metaLen, func, NULL);
+			if (!util_iov_pull_u8(&iov, &capsLen))
+				return false;
+			util_debug(func, NULL, "CC Len %d", capsLen);
+
+			bis->caps = new0(struct iovec, 1);
+			bis->caps->iov_len = capsLen;
+			util_iov_memcpy(bis->caps, iov.iov_base, capsLen);
+			DBG("bis caps len %ld", bis->caps->iov_len);
+
+			for (int i = 0; capsLen > 1; i++) {
+				struct bt_ltv *ltv = util_iov_pull_mem(&iov,
+								sizeof(*ltv));
+				uint8_t *caps;
+
+				if (!ltv) {
+					util_debug(func, NULL, "Unable to parse %s",
+								"Capabilities");
+					return false;
+				}
+
+				util_debug(func, NULL, "%s #%u: len %u type %u",
+						"CC", i, ltv->len, ltv->type);
+
+				caps = util_iov_pull_mem(&iov, ltv->len - 1);
+				if (!caps) {
+					util_debug(func, NULL,
+						"Unable to parse %s", "CC");
+					return false;
+				}
+				util_hexdump(' ', caps, ltv->len - 1, func,
+									NULL);
+
+				capsLen -= (ltv->len + 1);
+			}
+
+			queue_push_tail(subGroup->bises, bis);
+		}
 
+		queue_push_tail(base->subgroups, subGroup);
+	}
 	return true;
 }
 
@@ -556,6 +639,16 @@ static int parse_bcast_qos(const char *key, int var, DBusMessageIter *iter,
 			return -EINVAL;
 
 		dbus_message_iter_get_basic(iter, &qos->bcast.encryption);
+	} else if (!strcasecmp(key, "BIG")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.big);
+	}  else if (!strcasecmp(key, "BIS")) {
+		if (var != DBUS_TYPE_BYTE)
+			return -EINVAL;
+
+		dbus_message_iter_get_basic(iter, &qos->bcast.bis);
 	} else if (!strcasecmp(key, "Options")) {
 		if (var != DBUS_TYPE_BYTE)
 			return -EINVAL;
@@ -653,7 +746,8 @@ static int parse_qos(DBusMessageIter *iter, struct bt_bap_qos *qos,
 
 static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 				struct iovec **metadata, struct iovec **base,
-				struct bt_bap_qos *qos)
+				struct bt_bap_qos *qos,
+				struct bt_bap_base *base_s)
 {
 	const char *key;
 	struct iovec iov;
@@ -702,14 +796,10 @@ static int parse_configuration(DBusMessageIter *props, struct iovec **caps,
 	}
 
 	if (*base) {
-		uint32_t presDelay;
-		uint8_t numSubgroups, numBis;
-		struct bt_bap_codec codec;
-
 		util_iov_memcpy(*base, (*caps)->iov_base, (*caps)->iov_len);
-		parse_base((*caps)->iov_base, (*caps)->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis, &codec,
-			caps, NULL);
+		base_s->subgroups = queue_new();
+		parse_base(NULL, (*caps)->iov_base, (*caps)->iov_len,
+							bap_debug, base_s);
 	}
 
 	return 0;
@@ -796,12 +886,23 @@ static void bap_io_close(struct bap_ep *ep)
 	ep->cig_active = false;
 }
 
+static bool match_bis_by_id(const void *data, const void *user_data)
+{
+	int32_t bis_id = PTR_TO_INT(user_data);
+	const struct bt_bap_bis *bis = data;
+
+	return bis->bisIndex == bis_id;
+}
+
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct bap_ep *ep = data;
 	const char *path;
 	DBusMessageIter args, props;
+	struct bt_bap_base *base_s = new0(struct bt_bap_base, 1);
+	struct bt_bap_bis *curent_bis;
+	struct bt_bap_subgroup *subgroup;
 
 	if (ep->msg)
 		return btd_error_busy(msg);
@@ -832,11 +933,36 @@ static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
 	}
 
 	if (parse_configuration(&props, &ep->caps, &ep->metadata,
-				&ep->base, &ep->qos) < 0) {
+				&ep->base, &ep->qos, base_s) < 0) {
 		DBG("Unable to parse configuration");
 		return btd_error_invalid_args(msg);
 	}
 
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE) {
+		subgroup = queue_peek_head(base_s->subgroups);
+		curent_bis = queue_find(subgroup->bises, match_bis_by_id,
+						INT_TO_PTR(ep->qos.bcast.bis));
+		if (curent_bis == NULL) {
+			DBG("Unable to find BIS");
+			return btd_error_invalid_args(msg);
+		}
+		util_iov_free(ep->caps, 1);
+		ep->caps = new0(struct iovec, 1);
+		ltv_merge(ep->caps, subgroup->caps, false);
+		ltv_merge(ep->caps, curent_bis->caps, false);
+	} else if ((bt_bap_pac_get_type(ep->rpac) == BT_BAP_BCAST_SOURCE) &&
+			(bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)) {
+		util_iov_free(ep->caps, 1);
+		ep->caps = new0(struct iovec, 1);
+		ltv_merge(ep->caps, bt_bap_pac_get_data(ep->rpac), false);
+	}
+	/*
+	 * Kernel uses bis id as advertising handler. To open all BISes from
+	 * a big on the same advertisng handler set the bis
+	 * to BT_ISO_QOS_BIS_UNSET
+	 */
+	ep->qos.bcast.bis = BT_ISO_QOS_BIS_UNSET;
+
 	/* TODO: Check if stream capabilities match add support for Latency
 	 * and PHY.
 	 */
@@ -916,11 +1042,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 	char address[18];
 	struct bap_ep *ep;
 	int fd;
-	struct iovec *base_io;
-	uint32_t presDelay;
-	uint8_t numSubgroups;
-	uint8_t numBis;
-	struct bt_bap_codec codec;
 
 	bt_io_get(io, &err,
 			BT_IO_OPT_DEST, address,
@@ -945,15 +1066,6 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 
 	update_bcast_qos(&qos, &ep->qos);
 
-	base_io = new0(struct iovec, 1);
-	util_iov_memcpy(base_io, base.base, base.base_len);
-
-	parse_base(base_io->iov_base, base_io->iov_len, bap_debug,
-			&presDelay, &numSubgroups, &numBis,
-			&codec, &ep->caps, &ep->metadata);
-
-	/* Update pac with BASE information */
-	bt_bap_update_bcast_source(ep->rpac, &codec, ep->caps, ep->metadata);
 	ep->id = bt_bap_stream_config(ep->stream, &ep->qos,
 					ep->caps, NULL, NULL);
 	data->listen_io = io;
@@ -968,25 +1080,42 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		return;
 	}
 
-
 	return;
 
 drop:
 	g_io_channel_shutdown(io, TRUE, NULL);
-
 }
 
 static void iso_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
 {
 	GError *err = NULL;
+	struct bt_iso_base base;
+	char address[18];
+	struct bt_bap_base *base_s;
+	struct bap_data *data = user_data;
+	struct bt_iso_qos qos;
 
-	if (!bt_io_bcast_accept(io, iso_bcast_confirm_cb,
-				user_data, NULL, &err, BT_IO_OPT_INVALID)) {
-		error("bt_io_bcast_accept: %s", err->message);
+	bt_io_get(io, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_QOS, &qos,
+			BT_IO_OPT_BASE, &base,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("%s", err->message);
 		g_error_free(err);
-		g_io_channel_shutdown(io, TRUE, NULL);
+		return;
 	}
+	g_io_channel_ref(io);
+	data->listen_io = io;
+	btd_service_connecting_complete(data->service, 0);
+
+	DBG("BCAST ISO: PA sync with %s", address);
+	DBG("BASE len received from source %d", base.base_len);
+	base_s = new0(struct bt_bap_base, 1);
+	base_s->subgroups = queue_new();
+	parse_base(data->bap, base.base, base.base_len, bap_debug, base_s);
 
+	bt_bap_update_bcast_source(NULL, base_s);
 }
 
 static bool match_data_bap_data(const void *data, const void *match_data)
@@ -1082,6 +1211,7 @@ static struct bap_ep *ep_register_bcast(struct bap_data *data,
 	case BT_BAP_BCAST_SINK:
 		err = asprintf(&ep->path, "%s/pac_%s%d",
 				device_get_path(device), suffix, i);
+		ep->io = data->listen_io;
 		ep->base = new0(struct iovec, 1);
 		break;
 	}
@@ -1582,9 +1712,12 @@ static gboolean bap_io_disconnected(GIOChannel *io, GIOCondition cond,
 
 	bap_io_close(ep);
 
-	/* Check if connecting recreate IO */
-	if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
-		recreate_cig(ep);
+	if (bt_bap_stream_get_type(ep->stream) ==
+					BT_BAP_STREAM_TYPE_UCAST) {
+		/* Check if connecting recreate IO */
+		if (!is_cig_busy(ep->data, ep->qos.ucast.cig_id))
+			recreate_cig(ep);
+	}
 
 	return FALSE;
 }
@@ -1675,7 +1808,7 @@ static void bap_connect_io(struct bap_data *data, struct bap_ep *ep,
 
 static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream,
-				struct bt_iso_qos *qos)
+				struct bt_iso_qos *qos, int defer)
 {
 	struct btd_adapter *adapter = data->user_data;
 	GIOChannel *io = NULL;
@@ -1711,7 +1844,7 @@ static void bap_connect_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
 			BT_IO_OPT_QOS, qos,
 			BT_IO_OPT_BASE, &base,
-			BT_IO_OPT_DEFER_TIMEOUT, false,
+			BT_IO_OPT_DEFER_TIMEOUT, defer,
 			BT_IO_OPT_INVALID);
 
 	if (!io) {
@@ -1763,42 +1896,28 @@ static void bap_listen_io(struct bap_data *data, struct bt_bap_stream *stream,
 static void bap_listen_io_broadcast(struct bap_data *data, struct bap_ep *ep,
 			struct bt_bap_stream *stream, struct bt_iso_qos *qos)
 {
-	GIOChannel *io;
 	GError *err = NULL;
 	struct sockaddr_iso_bc iso_bc_addr;
 
 	iso_bc_addr.bc_bdaddr_type = btd_device_get_bdaddr_type(data->device);
 	memcpy(&iso_bc_addr.bc_bdaddr, device_get_address(data->device),
 			sizeof(bdaddr_t));
-	iso_bc_addr.bc_bis[0] = 1;
 	iso_bc_addr.bc_num_bis = 1;
+	iso_bc_addr.bc_bis[0] = strtol(bt_bap_pac_get_name(ep->rpac), NULL, 10);
 
 	DBG("stream %p", stream);
 
-	/* If IO already set skip creating it again */
-	if (bt_bap_stream_get_io(stream) || data->listen_io)
-		return;
-
-	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, ep->data, NULL, &err,
-			BT_IO_OPT_SOURCE_BDADDR,
-			btd_adapter_get_address(ep->data->adapter),
-			BT_IO_OPT_DEST_BDADDR,
-			device_get_address(data->device),
-			BT_IO_OPT_DEST_TYPE,
-			btd_device_get_bdaddr_type(data->device),
-			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
-			BT_IO_OPT_QOS, &qos->bcast,
-			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
-			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
-			BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
+	if (!bt_io_bcast_accept(ep->data->listen_io, iso_bcast_confirm_cb,
+				data, NULL, &err,
+				BT_IO_OPT_ISO_BC_NUM_BIS,
+				iso_bc_addr.bc_num_bis, BT_IO_OPT_ISO_BC_BIS,
+				iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
+		error("bt_io_bcast_accept: %s", err->message);
 		g_error_free(err);
+		g_io_channel_shutdown(ep->data->listen_io, TRUE, NULL);
 	}
-	ep->io = io;
-	ep->data->listen_io = io;
-
 }
+
 static void bap_create_ucast_io(struct bap_data *data, struct bap_ep *ep,
 				struct bt_bap_stream *stream, int defer)
 {
@@ -1833,9 +1952,6 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 
 	memset(&iso_qos, 0, sizeof(iso_qos));
 
-	if (!defer)
-		goto done;
-
 	iso_qos.bcast.big = ep->qos.bcast.big;
 	iso_qos.bcast.bis = ep->qos.bcast.bis;
 	iso_qos.bcast.sync_factor = ep->qos.bcast.sync_factor;
@@ -1852,9 +1968,9 @@ static void bap_create_bcast_io(struct bap_data *data, struct bap_ep *ep,
 	iso_qos.bcast.timeout = ep->qos.bcast.timeout;
 	memcpy(&iso_qos.bcast.out, &ep->qos.bcast.io_qos,
 				sizeof(struct bt_iso_io_qos));
-done:
+
 	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SOURCE)
-		bap_connect_io_broadcast(data, ep, stream, &iso_qos);
+		bap_connect_io_broadcast(data, ep, stream, &iso_qos, defer);
 	else
 		bap_listen_io_broadcast(data, ep, stream, &iso_qos);
 }
@@ -1879,6 +1995,31 @@ static void bap_create_io(struct bap_data *data, struct bap_ep *ep,
 		break;
 	}
 }
+/*
+ * Function  test_linked_streams_state will check if all linked streams
+ * have the test state.
+ * If all streams are in test_state returns true; Else returns false
+ */
+static bool test_linked_streams_state(struct bt_bap_stream *stream,
+						uint8_t test_state)
+{
+	const struct queue_entry *entry;
+	struct bt_bap_stream *linked_stream;
+	struct queue *links;
+
+	links = bt_bap_stream_io_get_links(stream);
+
+	if (!links)
+		return true;
+
+	for (entry = queue_get_entries(links); entry; entry = entry->next) {
+		linked_stream = entry->data;
+		if (bt_bap_stream_get_state(linked_stream) != test_state)
+			return false;
+	}
+
+	return true;
+}
 
 static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 				uint8_t new_state, void *user_data)
@@ -1906,15 +2047,26 @@ static void bap_state(struct bt_bap_stream *stream, uint8_t old_state,
 		break;
 	case BT_BAP_STREAM_STATE_CONFIG:
 		if (ep && !ep->id) {
-			bap_create_io(data, ep, stream, true);
-			if (!ep->io) {
-				error("Unable to create io");
-				bt_bap_stream_release(stream, NULL, NULL);
-				return;
-			}
-
 			if (bt_bap_stream_get_type(stream) ==
+					BT_BAP_STREAM_TYPE_BCAST) {
+				bool defer = !test_linked_streams_state(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+				bap_create_io(data, ep, stream, defer);
+				if (!ep->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
+			} else if (bt_bap_stream_get_type(stream) ==
 					BT_BAP_STREAM_TYPE_UCAST) {
+				bap_create_io(data, ep, stream, true);
+				if (!ep->io) {
+					error("Unable to create io");
+					bt_bap_stream_release(stream,
+								NULL, NULL);
+					return;
+				}
 				/* Wait QoS response to respond */
 				ep->id = bt_bap_stream_qos(stream, &ep->qos,
 								qos_cb,	ep);
@@ -2222,6 +2374,12 @@ static int bap_bcast_probe(struct btd_service *service)
 	struct btd_gatt_database *database = btd_adapter_get_database(adapter);
 	struct bap_data *data = btd_service_get_user_data(service);
 	char addr[18];
+	GIOChannel *io;
+	GError *err = NULL;
+	struct sockaddr_iso_bc iso_bc_addr;
+
+	iso_bc_addr.bc_bis[0] = 1;
+	iso_bc_addr.bc_num_bis = 1;
 
 	ba2str(device_get_address(device), addr);
 
@@ -2260,7 +2418,24 @@ static int bap_bcast_probe(struct btd_service *service)
 
 	bt_bap_set_user_data(data->bap, service);
 
-	bt_bap_new_bcast_source(data->bap, device_get_path(device));
+	DBG("Create PA sync with source");
+	io = bt_io_listen(NULL, iso_pa_sync_confirm_cb, data, NULL, &err,
+			BT_IO_OPT_SOURCE_BDADDR,
+			btd_adapter_get_address(data->adapter),
+			BT_IO_OPT_DEST_BDADDR,
+			device_get_address(data->device),
+			BT_IO_OPT_DEST_TYPE,
+			btd_device_get_bdaddr_type(data->device),
+			BT_IO_OPT_MODE, BT_IO_MODE_ISO,
+			BT_IO_OPT_QOS, &default_qos,
+			BT_IO_OPT_ISO_BC_NUM_BIS, iso_bc_addr.bc_num_bis,
+			BT_IO_OPT_ISO_BC_BIS, iso_bc_addr.bc_bis,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		error("%s", err->message);
+		g_error_free(err);
+	}
+
 	return 0;
 }
 
@@ -2406,6 +2581,9 @@ static int bap_adapter_probe(struct btd_profile *p,
 		return -EINVAL;
 	}
 
+	for (uint8_t i = 0; i < btd_opts.bcast.nb_bises-1; i++)
+		bt_bap_new_bcast_sink(data->bap);
+
 	data->state_id = bt_bap_state_register(data->bap, bap_state,
 						bap_connecting, data, NULL);
 	data->pac_id = bt_bap_pac_register(data->bap, pac_added_broadcast,
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 4d9a6aa03..30658ebaf 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -37,6 +37,7 @@
 #include "src/uuid-helper.h"
 #include "src/log.h"
 #include "src/error.h"
+#include "src/btd.h"
 #include "src/gatt-database.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
@@ -1250,7 +1251,7 @@ static bool endpoint_init_pac(struct media_endpoint *endpoint, uint8_t type,
 
 	endpoint->pac = bt_bap_add_vendor_pac(db, name, type, endpoint->codec,
 				endpoint->cid, endpoint->vid, &endpoint->qos,
-				&data, metadata);
+				&data, metadata, btd_opts.bcast.nb_bises);
 	if (!endpoint->pac) {
 		error("Unable to create PAC");
 		free(metadata);
diff --git a/src/shared/bap.c b/src/shared/bap.c
index 54ad713f2..45fd6df59 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -1111,7 +1111,8 @@ static struct bt_bap_stream_io *stream_get_io(struct bt_bap_stream *stream)
 		return stream->io;
 
 	io = NULL;
-	queue_foreach(stream->links, stream_find_io, &io);
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, stream_find_io, &io);
 
 	return io;
 }
@@ -1323,6 +1324,12 @@ static void stream_set_state_broadcast(struct bt_bap_stream *stream,
 
 	bt_bap_ref(bap);
 
+	switch (stream->ep->state) {
+	case BT_ASCS_ASE_STATE_QOS:
+		bap_stream_update_io_links(stream);
+		break;
+	}
+
 	for (entry = queue_get_entries(bap->state_cbs); entry;
 							entry = entry->next) {
 		struct bt_bap_state *state = entry->data;
@@ -2357,7 +2364,7 @@ static struct bt_bap_pac *bap_pac_find(struct bt_bap_db *bdb, uint8_t type,
 	return NULL;
 }
 
-static void *ltv_merge(struct iovec *data, struct iovec *cont)
+void *ltv_merge(struct iovec *data, struct iovec *cont, bool add_delimiter)
 {
 	uint8_t delimiter = 0;
 
@@ -2367,7 +2374,8 @@ static void *ltv_merge(struct iovec *data, struct iovec *cont)
 	if (!cont || !cont->iov_len || !cont->iov_base)
 		return data->iov_base;
 
-	iov_append(data, sizeof(delimiter), &delimiter);
+	if (add_delimiter)
+		iov_append(data, sizeof(delimiter), &delimiter);
 
 	return iov_append(data, cont->iov_len, cont->iov_base);
 }
@@ -2377,13 +2385,13 @@ static void bap_pac_merge(struct bt_bap_pac *pac, struct iovec *data,
 {
 	/* Merge data into existing record */
 	if (pac->data)
-		ltv_merge(pac->data, data);
+		ltv_merge(pac->data, data, true);
 	else
 		pac->data = util_iov_dup(data, 1);
 
 	/* Merge metadata into existing record */
 	if (pac->metadata)
-		ltv_merge(pac->metadata, metadata);
+		ltv_merge(pac->metadata, metadata, true);
 	else
 		pac->metadata = util_iov_dup(metadata, 1);
 }
@@ -2619,7 +2627,8 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					uint8_t nb_bises)
 {
 	struct bt_bap_db *bdb;
 	struct bt_bap_pac *pac;
@@ -2650,7 +2659,17 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 		break;
 	case BT_BAP_BCAST_SOURCE:
 		bap_add_broadcast_source(pac);
-		break;
+		queue_foreach(sessions, notify_session_pac_added, pac);
+		/*
+		 * Add a new broadcast source pac for each for each new BIS
+		 */
+		for (uint8_t i = 0; i < nb_bises-1; i++) {
+			pac = bap_pac_new(bdb, name, type, &codec, qos,
+							data, metadata);
+			bap_add_broadcast_source(pac);
+			queue_foreach(sessions, notify_session_pac_added, pac);
+		}
+		return pac;
 	case BT_BAP_BCAST_SINK:
 		bap_add_broadcast_sink(pac);
 		break;
@@ -2668,10 +2687,11 @@ struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata)
+					struct iovec *metadata,
+					uint8_t nb_bises)
 {
 	return bt_bap_add_vendor_pac(db, name, type, id, 0x0000, 0x0000, qos,
-							data, metadata);
+						    data, metadata, nb_bises);
 }
 
 uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac)
@@ -2701,6 +2721,14 @@ uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac)
 	}
 }
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac)
+{
+	if (!pac)
+		return 0x00;
+
+	return pac->data;
+}
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac)
 {
 	struct bt_pacs *pacs;
@@ -2783,12 +2811,26 @@ static void notify_session_pac_removed(void *data, void *user_data)
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
 					void *user_data)
 {
+	const struct queue_entry *entry = NULL;
+	struct bt_bap_pac *pac_entry;
+
 	if (!pac)
 		return false;
 
 	pac->ops = ops;
 	pac->user_data = user_data;
 
+	if (pac->type == BT_BAP_BCAST_SOURCE) {
+		for (entry = queue_get_entries(pac->bdb->broadcast_sources);
+					entry != NULL; entry = entry->next) {
+			pac_entry = entry->data;
+			if (pac_entry != pac) {
+				pac_entry->ops = ops;
+				pac_entry->user_data = user_data;
+			}
+		}
+	}
+
 	return true;
 }
 
@@ -2807,8 +2849,13 @@ static void remove_streams(void *data, void *user_data)
 	struct bt_bap_stream *stream;
 
 	stream = queue_remove_if(bap->streams, match_stream_lpac, pac);
-	if (stream)
+	if (stream) {
+		/* Mark stream->lpac to NULL,
+		 * as it will be freed in bt_bap_remove_pac
+		 */
+		stream->lpac = NULL;
 		bt_bap_stream_release(stream, NULL, NULL);
+	}
 }
 
 static void bap_pac_sink_removed(void *data, void *user_data)
@@ -4471,6 +4518,11 @@ bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac)
 	return false;
 }
 
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac)
+{
+	return pac->name;
+}
+
 static bool find_ep_unused(const void *data, const void *user_data)
 {
 	const struct bt_bap_endpoint *ep = data;
@@ -4682,7 +4734,7 @@ struct bt_bap_stream *bt_bap_stream_new(struct bt_bap *bap,
 			return NULL;
 
 		bt_bap_foreach_pac(bap, type, match_pac, &match);
-		if (!match.lpac)
+		if ((!match.lpac) || (!lpac))
 			return NULL;
 		if (!match.rpac && (match.lpac->type != BT_BAP_BCAST_SOURCE))
 			return NULL;
@@ -4839,7 +4891,16 @@ static void bap_stream_enable_link(void *data, void *user_data)
 	struct bt_bap_stream *stream = data;
 	struct iovec *metadata = user_data;
 
-	bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata, NULL, NULL);
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		bap_stream_metadata(stream, BT_ASCS_ENABLE, metadata,
+								NULL, NULL);
+		break;
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+						BT_BAP_STREAM_STATE_CONFIG);
+		break;
+	}
 }
 
 unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
@@ -4866,13 +4927,14 @@ unsigned int bt_bap_stream_enable(struct bt_bap_stream *stream,
 		queue_foreach(stream->links, bap_stream_enable_link, metadata);
 		break;
 	case BT_BAP_STREAM_TYPE_BCAST:
-		if (!bt_bap_stream_io_dir(stream))
+		if (!bt_bap_stream_io_dir(stream)) {
 			stream_set_state_broadcast(stream,
-				BT_BAP_STREAM_STATE_CONFIG);
-		else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
+						BT_BAP_STREAM_STATE_CONFIG);
+			queue_foreach(stream->links, bap_stream_enable_link,
+									NULL);
+		} else if (bt_bap_stream_io_dir(stream) == BT_BAP_BCAST_SOURCE)
 			stream_set_state_broadcast(stream,
 				 BT_BAP_STREAM_STATE_STREAMING);
-
 		return 1;
 	}
 
@@ -4933,17 +4995,27 @@ static void bap_stream_disable_link(void *data, void *user_data)
 	struct iovec iov;
 	struct bt_ascs_disable disable;
 
-	memset(&disable, 0, sizeof(disable));
+	switch (bt_bap_stream_get_type(stream)) {
+	case BT_BAP_STREAM_TYPE_UCAST:
+		memset(&disable, 0, sizeof(disable));
+
+		disable.ase = stream->ep->id;
 
-	disable.ase = stream->ep->id;
+		iov.iov_base = &disable;
+		iov.iov_len = sizeof(disable);
 
-	iov.iov_base = &disable;
-	iov.iov_len = sizeof(disable);
+		req = bap_req_new(stream, BT_ASCS_DISABLE, &iov,
+							1, NULL, NULL);
 
-	req = bap_req_new(stream, BT_ASCS_DISABLE, &iov, 1, NULL, NULL);
+		if (!bap_queue_req(stream->bap, req))
+			bap_req_free(req);
+	break;
 
-	if (!bap_queue_req(stream->bap, req))
-		bap_req_free(req);
+	case BT_BAP_STREAM_TYPE_BCAST:
+		stream_set_state_broadcast(stream,
+				BT_BAP_STREAM_STATE_RELEASING);
+	break;
+	}
 }
 
 unsigned int bt_bap_stream_disable(struct bt_bap_stream *stream,
@@ -5189,7 +5261,8 @@ bool bt_bap_stream_set_io(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_set_io(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, bap_stream_set_io, INT_TO_PTR(fd));
 
 	return true;
 }
@@ -5245,10 +5318,15 @@ int bt_bap_stream_io_link(struct bt_bap_stream *stream,
 	if (queue_find(stream->links, NULL, link))
 		return -EALREADY;
 
-	if (stream->client != link->client ||
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_BCAST) {
+		if (stream->qos.bcast.big != link->qos.bcast.big)
+			return -EINVAL;
+	} else {
+		if (stream->client != link->client ||
 			stream->qos.ucast.cig_id != link->qos.ucast.cig_id ||
 			stream->qos.ucast.cis_id != link->qos.ucast.cis_id)
-		return -EINVAL;
+			return -EINVAL;
+	}
 
 	if (!stream->links)
 		stream->links = queue_new();
@@ -5377,7 +5455,9 @@ int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd)
 
 	bap_stream_io_connecting(stream, INT_TO_PTR(fd));
 
-	queue_foreach(stream->links, bap_stream_io_connecting, INT_TO_PTR(fd));
+	if (bt_bap_stream_get_type(stream) == BT_BAP_STREAM_TYPE_UCAST)
+		queue_foreach(stream->links, bap_stream_io_connecting,
+						INT_TO_PTR(fd));
 
 	return 0;
 }
@@ -5433,11 +5513,58 @@ bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name)
 	return true;
 }
 
+bool bt_bap_new_bcast_sink(struct bt_bap *bap)
+{
+	struct bt_bap_endpoint *ep;
+
+	/* Push remote endpoint with direction source */
+	ep = bap_endpoint_new_broadcast(bap->ldb, BT_BAP_BCAST_SOURCE);
+
+	if (ep)
+		queue_push_tail(bap->remote_eps, ep);
+
+	ep->bap = bap;
+	return true;
+}
+
+static void bis_to_pac(void *data, void *user_data)
+{
+	struct bt_bap_bis *bis = data;
+	struct bt_bap_subgroup *subgroup = user_data;
+	struct bt_bap_pac *pac_source_bis;
+	struct bt_bap_endpoint *ep;
+	int err = 0;
+
+	ltv_merge(bis->caps, subgroup->caps, false);
+	pac_source_bis = bap_pac_new(subgroup->bap->rdb, NULL,
+				BT_BAP_BCAST_SOURCE, &subgroup->codec, NULL,
+				bis->caps, subgroup->meta);
+
+	err = asprintf(&pac_source_bis->name, "%d", bis->bisIndex);
+
+	if (err < 0)
+		DBG(subgroup->bap, "error in asprintf");
+
+		/* Add remote source endpoint */
+	if (!subgroup->bap->rdb->broadcast_sources)
+		subgroup->bap->rdb->broadcast_sources = queue_new();
+	queue_push_tail(subgroup->bap->rdb->broadcast_sources, pac_source_bis);
+
+	queue_foreach(subgroup->bap->pac_cbs, notify_pac_added, pac_source_bis);
+	/* Push remote endpoint with direction sink */
+	ep = bap_endpoint_new_broadcast(subgroup->bap->rdb, BT_BAP_BCAST_SINK);
+
+	if (ep)
+		queue_push_tail(subgroup->bap->remote_eps, ep);
+}
+static void parse_bis(void *data, void *user_data)
+{
+	struct bt_bap_subgroup *subgroup = data;
+
+	queue_foreach(subgroup->bises, bis_to_pac, subgroup);
+}
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata)
+				struct bt_bap_base *base)
 {
-	bap_pac_merge(pac, data, metadata);
-	pac->codec = *codec;
+	queue_foreach(base->subgroups, parse_bis, NULL);
 }
diff --git a/src/shared/bap.h b/src/shared/bap.h
index 2c8f9208e..74f0effb0 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -97,6 +97,27 @@ struct bt_bap_qos {
 	};
 };
 
+struct bt_bap_base {
+	uint32_t presDelay;
+	uint8_t numSubgroups;
+	struct queue *subgroups;
+};
+
+struct bt_bap_subgroup {
+	uint8_t subGroupIndex;
+	struct bt_bap *bap;
+	uint8_t numBises;
+	struct bt_bap_codec codec;
+	struct iovec *caps;
+	struct iovec *meta;
+	struct queue *bises;
+};
+
+struct bt_bap_bis {
+	uint8_t bisIndex;
+	struct iovec *caps;
+};
+
 typedef void (*bt_bap_ready_func_t)(struct bt_bap *bap, void *user_data);
 typedef void (*bt_bap_destroy_func_t)(void *user_data);
 typedef void (*bt_bap_debug_func_t)(const char *str, void *user_data);
@@ -141,13 +162,15 @@ struct bt_bap_pac *bt_bap_add_vendor_pac(struct gatt_db *db,
 					uint8_t id, uint16_t cid, uint16_t vid,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata);
+					struct iovec *metadata,
+					uint8_t nb_bises);
 
 struct bt_bap_pac *bt_bap_add_pac(struct gatt_db *db, const char *name,
 					uint8_t type, uint8_t id,
 					struct bt_bap_pac_qos *qos,
 					struct iovec *data,
-					struct iovec *metadata);
+					struct iovec *metadata,
+					uint8_t nb_bises);
 
 struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -168,6 +191,8 @@ uint8_t bt_bap_pac_get_type(struct bt_bap_pac *pac);
 
 uint32_t bt_bap_pac_get_locations(struct bt_bap_pac *pac);
 
+struct iovec *bt_bap_pac_get_data(struct bt_bap_pac *pac);
+
 uint16_t bt_bap_pac_get_supported_context(struct bt_bap_pac *pac);
 
 uint16_t bt_bap_pac_get_context(struct bt_bap_pac *pac);
@@ -231,6 +256,7 @@ int bt_bap_pac_get_codec(struct bt_bap_pac *pac, uint8_t *id,
 
 void bt_bap_pac_set_user_data(struct bt_bap_pac *pac, void *user_data);
 void *bt_bap_pac_get_user_data(struct bt_bap_pac *pac);
+char *bt_bap_pac_get_name(struct bt_bap_pac *pac);
 
 /* Stream related functions */
 int bt_bap_select(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
@@ -312,11 +338,11 @@ uint8_t bt_bap_stream_io_dir(struct bt_bap_stream *stream);
 int bt_bap_stream_io_connecting(struct bt_bap_stream *stream, int fd);
 bool bt_bap_stream_io_is_connecting(struct bt_bap_stream *stream, int *fd);
 
+bool bt_bap_new_bcast_sink(struct bt_bap *bap);
 bool bt_bap_new_bcast_source(struct bt_bap *bap, const char *name);
 void bt_bap_update_bcast_source(struct bt_bap_pac *pac,
-					struct bt_bap_codec *codec,
-					struct iovec *data,
-					struct iovec *metadata);
+				struct bt_bap_base *base);
+void *ltv_merge(struct iovec *data, struct iovec *cont, bool add_delimiter);
 
 bool bt_bap_pac_bcast_is_local(struct bt_bap *bap, struct bt_bap_pac *pac);
 
diff --git a/unit/test-bap.c b/unit/test-bap.c
index adade07db..80838d813 100644
--- a/unit/test-bap.c
+++ b/unit/test-bap.c
@@ -377,11 +377,13 @@ static void test_client_config(struct test_data *data)
 							"test-bap-snk",
 							BT_BAP_SINK, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL, 0x0);
 		else
 			data->snk = bt_bap_add_pac(data->db, "test-bap-snk",
 							BT_BAP_SINK, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL, 0x0);
 		g_assert(data->snk);
 	}
 
@@ -391,11 +393,13 @@ static void test_client_config(struct test_data *data)
 							"test-bap-src",
 							BT_BAP_SOURCE, 0x0ff,
 							0x0001, 0x0001,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL, 0x0);
 		else
 			data->src = bt_bap_add_pac(data->db, "test-bap-src",
 							BT_BAP_SOURCE, LC3_ID,
-							NULL, data->caps, NULL);
+							NULL, data->caps,
+							NULL, 0x0);
 		g_assert(data->src);
 	}
 }
-- 
2.39.2

