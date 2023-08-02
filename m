Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFBFC00528
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 13:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbjHBNZZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjHBNZX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 09:25:23 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA5E1996
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 06:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqy3ViMvum7JjT0ahbKhGQcS09B2LqAVmVyBpz3wqk5KkiVo+riP4SSP8d7C1vrwyZvdHbNZl5EZERqCQn+paPMpRY9ceSw9WfgLNuum7pU6g84yG6gXyOrkDEqK639B8pZPqjpO7s8yUV6wyc5QAtHzWyeF9WDvZFYeWb2kyh/3w/1N1w156+2/iKni0/k1Tmp3ibwA/YgGRtpMSKwAmCTU1mc+tXSSmK7Bf8Agnpe19hlx9WGkLND2EbipRQD/9E2SNxJCO1MT5TUhPl9+Q9pXxKBjL78YjRLh5+PjbLjAtjCLa9SigyqBxscq3R+2Jnc0XcJAN86RH/BDEkPuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=GfYfr2TDV2nMO2FRsSmv4KnPUZkg48oA6Ryx1DxpjMk7XdsF1phkkZ0bYKU8xsiR7d3/wiszDJPH/dVVWU5YLpcdzl9UW50tFhU1x970YbOy1GQsQSQ40E2F8ty7pv1XKlAGaBVTaMNdHKR/VIO7pNT3w91p9iZzPW21/IKVHhazZxg948lo8kYkp/Rp/bEijT5xN1r6aiGSzZMCkyAwqjsb9CsxlCNOpyQZ/RrDKQ2SwGalqusZ7Ca/nmVc0fXj/QxdQ5qXPkzHBUBJ5z5jSuLN15NuoNbTWSjMo5ugV1+Gj9gEntZBHwcREVskivindrdT0edBRodm6IYZ6lUD+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrxBLncj+ZstmuJpGTINckKfaoffvLT9Zud2iiwClqg=;
 b=TfVlwiYU+iq3tXJrikboGXrXM5dyrmbe6fgCHWiCg7f8JgAkCGntABXLP1j5+bBX3IzN09sgMQgbpuCjrD5xbDEQQ0w61cA7xsZAGrmW5cx+ku4+qpW35OP3/vYP5wcbxzcwqwEyK7wscZLaRz++4/zBm8V823sTW0934NgcpYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by DU2PR04MB8613.eurprd04.prod.outlook.com (2603:10a6:10:2d8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 13:25:19 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 13:25:19 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v4 2/6] btio: Add support for getsockopt(BT_ISO_BASE)
Date:   Wed,  2 Aug 2023 16:23:51 +0300
Message-Id: <20230802132355.4953-3-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230802132355.4953-1-claudia.rosu@nxp.com>
References: <20230802132355.4953-1-claudia.rosu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::19) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|DU2PR04MB8613:EE_
X-MS-Office365-Filtering-Correlation-Id: 20585fde-fae2-4734-c4ea-08db935beaa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R2mkxfuP0nPC1WIhwkfkXRpknYlHMhxxx2qcN5rIVAa5K7FcQHZPk3ijqFi/WZQnJySFjbhhOuFibvnTnxrl30Nkv+kuwBsKxIuXCQl71LnGLc/+B6DPLC+7ET23aOm94ew/txW42nLF+62jEd1XggyAE1foSwMc89JNGPzwhtQ76zoIu1yJb7z4AiMl1ledF6CDgJ8hCS0DDUEb+Zfc10tVQL7Iyaq5RgTLBGE8tJmJi1H5BMDhAK9z306Yy7Nsx5KuRa/wTHL7sXZE641vs0RtpRNqdSymRgrwzzRuS2L31SyDXWyFQwrHH13FsPKm2wDJvYAmRQtlrZhB49GWnjK4FaY5KtNzALSWk2xCpTI7EFq+0C8Un9MbxKWf1YjFwjLimTVCKfHgRZOYGURe08abm+3G3lNqU8Tkf6ZqUKCEHHccImA4iIovx1jQZBN5nVbYN8aepIWhAU9XWfGC0aQBdqCeYj0/x0CyyB03eTWWl1txlQqeFqhSnzyVMHZMIo21TROZ2fZwmlHGu55KfGLp+DNNyVU+mc8TISAwh5fsa9v0bazFSwjhHd8MhVPG8NGiQQGh38cIiAJPxkBLx27Z6FdA1t3RdXzyDlC4ndb2pjjY5ODHgIJAUBR/Jwzu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199021)(86362001)(36756003)(66556008)(52116002)(478600001)(38350700002)(38100700002)(83380400001)(186003)(2616005)(1076003)(6506007)(26005)(8676002)(8936002)(41300700001)(6666004)(6512007)(6486002)(316002)(5660300002)(6916009)(4326008)(66946007)(2906002)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D0JXPupgvFkCnNp2ivhSiUizC35PNUn2WRnHYGzq9QU3J7esU8xpYqv14zE+?=
 =?us-ascii?Q?r+2RyBflCw2Wi8mOljyb80ruPcGuva7t/RDdEjHhP2EU7SUC6l/QZTkku9MI?=
 =?us-ascii?Q?a8SB9zX81outH6mJUVXZa1DXuIJ1026fbOlaAgafzQIPaMnXEOCDl1X/6d8R?=
 =?us-ascii?Q?bCIBMrpG7yUi+rwPAmurdeOGN8KwfXSph22uGuXRpb3JvAmOaIH4HsiOkH31?=
 =?us-ascii?Q?qR+DXCF6ENjq9JrCITVmlN+/z/u69lWtlo+8S1Dh4LayygMCtfm7/0vSwKcF?=
 =?us-ascii?Q?1GEm4esGxsL4zxgz1jX/YFbLhCx1e3YZUAaIANRyxDnYMoEFxxNfqp/C4yw+?=
 =?us-ascii?Q?TQIH6oZLclrShyfHhXcriUcl+RMQ8f8hfbgd3dkk5+6erCwqeb//ChsSaWfy?=
 =?us-ascii?Q?gv56XA2YQ0jwbxsuVxxMHR0k9xCoPSCwzWmvqoZinAr5tYpzuu0V+E3CPy+b?=
 =?us-ascii?Q?IrSLhEWevQIcxjs053iU74U2tp1rmGUtve6K8MTyMTAoalSfp7e/1goqxKvk?=
 =?us-ascii?Q?kGMqvX7SHcuAEMpYqkv0+5rFwHxPk/qqTy0gQiJ9eUjid7SCHzaZ7F8FQ9J9?=
 =?us-ascii?Q?EXMPV+4pgR453WkTl6IwY25X6oUQuxcspQ5LX39yoBgVArNznqy9zsL37YH8?=
 =?us-ascii?Q?1TGQ4t0i4Wsj/AteB4LFAnyYWilmLwyI3L3fZs3fDo5oU+MLM8b5eyMmZ0Og?=
 =?us-ascii?Q?nam9619BJXoNULacl2pDFmMbsi4WwAhjjKmjZ14vJ+CLcvd4lSJ0n/ZeLNSx?=
 =?us-ascii?Q?GmDxcSFanU6oiV2Onbcd2ay6tnBELc5pEYWG0G7HZ3YxeKu19dXe6AYHXv6z?=
 =?us-ascii?Q?LsgBePj3f2qYGuwK3IMQEgRUXs6uy+qrHfOranYuKdmAyZryze61c0Jnhxzt?=
 =?us-ascii?Q?lkylWkGUXcoHY4S1O0vxwF/eWYHPsPowaPRvXs7bprSFALYNXESaNt2l5wNa?=
 =?us-ascii?Q?npB0YPyU6EkVJ+QrEMOYTjg7XlopEgZRYxqO+ruhPoq3El2kFXYkJjSnIrbb?=
 =?us-ascii?Q?ftaWJeLzxf6H61YNGqjwCEnHCZzsqonzhyxzQ4ie4c5fTKrD6AEUubvINoV2?=
 =?us-ascii?Q?hVL44ov1NTixZjV82dnHi2V7ix1d9xNixqd0hDyiKgATP/vmHj3yThumN3nf?=
 =?us-ascii?Q?Zbmg2NAm7Joq4EWoJjPZqTZXNcD0DK/4mlXDcKBlUN7J+6VtBihq1/qDqfHX?=
 =?us-ascii?Q?Dy3jvTNsUJ4imVpZhqBC8aWQz5fKYeela+d43DMp3P+LT6wPWqdgN++f/6N0?=
 =?us-ascii?Q?84xGHzEQpAOOQuycW82rgeIubyhF2MqtvwsNFFny0xTwcNgbd41B7HiGqPEy?=
 =?us-ascii?Q?BHf2xi9Tq/iLPSBr+rGzIJOJU6gd4QaIhMJRXi43JaKKR+rV4fHi4J166/cr?=
 =?us-ascii?Q?gfD5Rzh8Q/vmmQ8e1shUNbFXynueVCx83fXLI/1wn9ksq9rfhcnHdiUbQ9F5?=
 =?us-ascii?Q?dSeJWuNZhN3bgyq5WJ0MbuQMlYGshp8hsFfT0LiXV6e0ptbTiudbPi0zxiNg?=
 =?us-ascii?Q?vzG/RVI02pmRfBoeG2pFHPfjLaZN0jvw4KZdZ+WTca39aUU5MBlRqsWJpmGZ?=
 =?us-ascii?Q?C8mpMAbLzWUp/4NiUQ4UiKj8WIlnL8gjM93BlLdm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20585fde-fae2-4734-c4ea-08db935beaa7
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 13:25:19.2584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hosz1NzNY3sNEJHLS+q8vLar+9iIFb8dzyMe/OWZ37HCJ75/KXSLK8+VR5j0FzsRo8hZ0vKVIS291BLlSEMcgA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8613
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds the posibility for a broadcast sink to retrieve the
BASE information received from a source afeter a PA synchronization,
using the getsockopt(BT_ISO_BASE) function.
This needs the patch from bluetooth-next:
Bluetooth: ISO: Add support for periodic adv reports processing

---
 btio/btio.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/btio/btio.c b/btio/btio.c
index 179be6289..8178250d2 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1638,6 +1638,7 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 	BtIOOption opt = opt1;
 	struct sockaddr_iso src, dst;
 	struct bt_iso_qos qos;
+	struct bt_iso_base base;
 	socklen_t len;
 	uint32_t phy;
 
@@ -1648,6 +1649,11 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 		return FALSE;
 	}
 
+	if (getsockopt(sock, SOL_BLUETOOTH, BT_ISO_BASE, &base, &len) < 0) {
+		ERROR_FAILED(err, "getsockopt(BT_ISO_BASE)", errno);
+		return FALSE;
+	}
+
 	if (!get_src(sock, &src, sizeof(src), err))
 		return FALSE;
 
@@ -1694,6 +1700,8 @@ static gboolean iso_get(int sock, GError **err, BtIOOption opt1, va_list args)
 			*(va_arg(args, struct bt_iso_qos *)) = qos;
 			break;
 		case BT_IO_OPT_BASE:
+			*(va_arg(args, struct bt_iso_base *)) = base;
+			break;
 		case BT_IO_OPT_HANDLE:
 		case BT_IO_OPT_CLASS:
 		case BT_IO_OPT_DEFER_TIMEOUT:
@@ -1896,8 +1904,9 @@ static GIOChannel *create_io(gboolean server, struct set_opts *opts,
 			goto failed;
 		if (!iso_set_qos(sock, &opts->qos, err))
 			goto failed;
-		if (!iso_set_base(sock, &opts->base, err))
-			goto failed;
+		if (opts->base.base_len)
+			if (!iso_set_base(sock, &opts->base, err))
+				goto failed;
 		break;
 	case BT_IO_INVALID:
 	default:
-- 
2.34.1

