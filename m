Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44621C83F17
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245612AbjH3Sxp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbjH3N3i (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 09:29:38 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A06198
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 06:29:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXEjyTgHkr5JpYRW4/GurrscoBNEY7udEZt7E3dyE+938rW3aNNV8MIMuZHEyBCuP/uzUrymx5sDohQkQFuSub8DjQAd9AT5l2SI7WcX+AEtOJ+Qcqi4CxJpfns7wGUPJKufjMpZUwXccqu+4jeLLQ9aqBOg9spVT0EyamWNzd4c6hDdd77FqgXWFMrfmVi5nbNo+QLGXiE5ngYpjzHlwvsk1myRCMn0ZYXMUcgEw776FPTVvnfnjfFRtk9lyycTgGKGqVgirx+kAlcRCX3shJbsqVoELDNvEkR41FezqMRVGKYY01tSj2ZzQxTLGhZl/ryW5zi3xC6oJFjQUY99gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPHBw3tUDplRgQ1rA/ev4YoSYJfFWiipUvJRCAN+ijQ=;
 b=CSsQmFx5yVu7e9bACOGPaX14p3NPFVJV9i0a8D351oIltbGbNoRsdd2H25pvc7ZMkPwi+7FkVmAOdzA616e49Rhg2yHeNhzrcWsUCLjKDWT8SlkxoEaJU5FTCc8H5nSl6TAjP3beeTIWYGGJ8KcklBQ8boydE1xkw19fM0nyOcJJUVOMGtYZAX4XqUnUT6d+EuOSRWX2E42Skc7+OjK6TGNO4C45d2IVAfOh+bF0z57ddeoFkWB3/61zKX0vQ6cnbDlOH3fvMs7dSxgVhF3sdEDfyBeBzCjN77a/AkwCuQqQYS8+nWNaoJtJyD0d4Ndpez7A5Y8h+uxC5/gcj2c31g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cPHBw3tUDplRgQ1rA/ev4YoSYJfFWiipUvJRCAN+ijQ=;
 b=odA9jJbngAPs69JJ5sC/dG+tlbuXOTca0J/oUucf7dgwlye5+INnzBaXUjoAmO49dIs40dlZq7ZU7oPJaIIc/3kD8vfXlUnuUzbNVsHgvCQd6CeYXRXh2CJUgiYGspK+k3JL7TD4F1xug2ZKMThUx4PDqDPuLisBCSpUwUkfIGQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 13:29:33 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::6831:19af:f6c0:5512]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::6831:19af:f6c0:5512%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 13:29:33 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH 2/2] Set the device temp false when sync with a bcast source
Date:   Wed, 30 Aug 2023 16:29:15 +0300
Message-Id: <20230830132915.72153-3-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230830132915.72153-1-silviu.barbulescu@nxp.com>
References: <20230830132915.72153-1-silviu.barbulescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0102.eurprd03.prod.outlook.com
 (2603:10a6:208:69::43) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBAPR04MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: 4683882f-252d-47d1-ac86-08dba95d2580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: muey+HB14LaxiNex5lJyG6pxQhaykJ18QFEIyE+X2JoSvFaYyGbzjG8AiNOaAIWb/Msaxvx5Hz5oQoc/5jA+Ys2WrPYtYKPNayM+QavHTiAuX9i2KPFGHdEv2VHb+1n6Yazwf+Hljkb22BErrTLdahPqYy09q5zZiTJDyyBdp2CNZt0VRZ0nd7k3EWlM7vJSqmEvq1X3QBd+8ES22dnqLaK+yRL04qh834eL0QdYr0NrG0zy8GHqj3JOnf2Y5cdeliXgPsAFWhOW9Z+bRRXhbKqn7GGpgXucsGNmSPNwWkenFcTDimsFjlqDRM9BmqkbDSw0Ur2rAtbWEE28JYwBF/ZsvgNQS9ykVxFX6bg5rIXl1BwNQPN4Hdm70pGQUUYODu1t+V22Z7odBnVEfBQ1Lz+2xd+KtROibqGvdQwK8eVGGNCJE1HH2u1qxmX5xMgGLGRQZEifGmwWyRHYkFoaMoXtPsF43qwhD1kuLdjfgbOHj7FRHl03rptyqpSe3F4n6IJf7auN8+gMkaf7BLUUXJPor2bXkPoSb+xwyhjmKDpmLSA4YBCHRip9uxeFkwY5z1bQToN5UnwrOXgYEYxWNTW6uPqPLYp4MEaN+0Ue6XO2IHwg+V4rvCOalZGnxZ+v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(6666004)(52116002)(66946007)(478600001)(6506007)(66556008)(66476007)(6486002)(316002)(38100700002)(41300700001)(38350700002)(6512007)(5660300002)(8676002)(26005)(36756003)(1076003)(2906002)(83380400001)(2616005)(6916009)(86362001)(4744005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z+uOVWLw08NpamSjvfSMtNGkPl8PjIwNtjvKr2Ljanc/uM3QTgVdsyRxbmSX?=
 =?us-ascii?Q?ai3CkrZYJdV3lDaOPcg0B6/qHII5JdroZUTTSTwUoynG19Fe5HH6otSOkktc?=
 =?us-ascii?Q?jUKcvPjZ6s+YRB1q/sQrwWpmiEECDAE5UmN5cDAPCCmTIs+v/eqA1zrZulqE?=
 =?us-ascii?Q?WghsBFfLmNo2YDKYmQez/sxTx/DuGTBlsSn3xag/nsmpPhIoeuZZ70EQ9uSM?=
 =?us-ascii?Q?S46ly9fZWehEov59wEZ6QusYwtoxhLArdMzZMfFKq6CdD42z/J+W2R84kxtY?=
 =?us-ascii?Q?C5zWhQBLvH6RKIE/YjzGiubo4MTMUlQngMM0a3v3BgQYFz6vVWicwYdmW0oU?=
 =?us-ascii?Q?S/Fb3jlcSnDB7k5Y5elVQb18sesx0Ce9J3zrLBdr/Hd0lrQFscNb9GvQ2u64?=
 =?us-ascii?Q?U3mz5If//9hVknFP5nk6jwH1lLxMUreehS/RLAT5B1J4y+Yv0swtscfAYg64?=
 =?us-ascii?Q?K4jbSj1T5hAPQHAm0mTpMJD2pXgkOWVhE7VhpZ7+w4g808PgCuOueCV+DtjV?=
 =?us-ascii?Q?GeMWVqWnu3nhKhfEVEaJM1k8CZd3GVvdsCNXMsy50D1WOdrJbd5OqpGYoYGy?=
 =?us-ascii?Q?PQeJMh6nK/DzdkvrWaZTpctlSrLEiaWd1+ClgeIG1ccQrMPAX6qs0sDsB99y?=
 =?us-ascii?Q?WsnXMzUZoUYHGSEzHx//y/fJ8JozoJcTuygwFcRJayTw2toBvDLAzvezIo7X?=
 =?us-ascii?Q?gtPNXTYOEQWMrM0j4SA4JdhsMyKkSJ550DJe2Y0miAyIcFq8I/x+eb5U0gXp?=
 =?us-ascii?Q?X/S3r79/3eeQHZCpIMP+uF0yCLJji8ocFTFBAfDqIgE0c2I8JXqVB8JDDxQq?=
 =?us-ascii?Q?x7VLgOMd8t2AujH9Bir0chlooTJFwm+ZbyYGJDhaqOMZzr6Wdl6FhwRaaiMU?=
 =?us-ascii?Q?3UNCbMSHS1G6TNC2k83ZXJR8FheW7k7K/EDDzM5S4P0vI8pMzea3nuo3BXyK?=
 =?us-ascii?Q?jbETnCRqm9VoDD39YICgVwszByhTRIBzv+GbcPYwxQfAZ45KEtC1x/IE/aI7?=
 =?us-ascii?Q?NQVVHzlBrHrv+cQuRggTARPIhVtoGW5Wu1bCvEJrh75AIdO96qcIAjhf/ezp?=
 =?us-ascii?Q?0Mhl/DpxYy1DDWfXZ7DKykZDg1r5QYfHGCWwJsYMTtiRyiO4ePMNGiAV79HF?=
 =?us-ascii?Q?xEx1ZbzCcDfWKGPlXLf8Rnm/hJFWQ2pcpMhfcDIK1jVYz/j/ra+pi4P4+x/V?=
 =?us-ascii?Q?NgDVSxNjpPw1IGN1FSu4ZdKv0ON/a182rYfJBcJbN8YXfkBEujl2I59Wh3Pq?=
 =?us-ascii?Q?oxobhMRcID61u3IU/zud8WdVeF4HMW7Oyqt7OHbPiEggie+f77qHU9oGUwed?=
 =?us-ascii?Q?1QumiTAJ+P4z49K9aC0n/TcuggwQJfq8RtfgY8A/laLGuYEnBthwCW5P6L4j?=
 =?us-ascii?Q?poISHZgmwhiVwWMxw10p7GB1Pys/9ui/PUrOITJNsDWASRY5epBaotBR1ILO?=
 =?us-ascii?Q?CP3A+p0eVoAeAZ3YUPZo6n/asWtroTOJnFx3l/nI4togspEwMfLvZPwx8+r5?=
 =?us-ascii?Q?VaLSAE1SZneeUXGs9HcFq9eZeKbJUptabaAAtIL3fr0+01feSogUkiEG11Do?=
 =?us-ascii?Q?VPIkj54sCJNPkT9SbVQhljBgDyoHosjkxmrzgSBFqPB4lA84LJmVHsiHO9Ud?=
 =?us-ascii?Q?aA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4683882f-252d-47d1-ac86-08dba95d2580
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:29:33.1204
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Do8k6hIKcb93ye+yBeysj7OB2KwR/x7YcGU76gGVQIiNCmnjFCDIvkhLuz2Y05JlGH31g0b99VuiIQNsiharXOLvaHL0sbjaogQzbSSCHzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set the device temporarily false when sync is done with a broadcast
source so the device will not be removed on the temporary timer

---
 profiles/audio/bap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
index dfc71edf6..ab0b2c22b 100644
--- a/profiles/audio/bap.c
+++ b/profiles/audio/bap.c
@@ -658,6 +658,9 @@ static void bap_io_close(struct bap_ep *ep)
 	g_io_channel_unref(ep->io);
 	ep->io = NULL;
 	ep->cig_active = false;
+
+	if (bt_bap_pac_get_type(ep->lpac) == BT_BAP_BCAST_SINK)
+		btd_device_set_temporary(ep->data->device, true);
 }
 
 static DBusMessage *set_configuration(DBusConnection *conn, DBusMessage *msg,
@@ -797,6 +800,8 @@ static void iso_bcast_confirm_cb(GIOChannel *io, GError *err, void *user_data)
 		goto drop;
 	}
 
+	btd_device_set_temporary(data->device, false);
+
 	g_io_channel_ref(io);
 	btd_service_connecting_complete(data->service, 0);
 	DBG("BCAST ISO: sync with %s (BIG 0x%02x BIS 0x%02x)",
-- 
2.34.1

