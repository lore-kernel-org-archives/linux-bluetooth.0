Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DD4EC8740
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 15:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbjIGPm2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235484AbjIGPXM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 11:23:12 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2071.outbound.protection.outlook.com [40.107.105.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C22CDE
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 08:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nw3Br1BTb/urw7M2K81Eh2AZy7OaM/77fcEnLVS7tRQ65kantJG5qlljHggvHMZ6PE/Y0x0fOUhgIiGJyZBswrDoYvqJeKhmxAMLToE6PBYo2Blhi06V/vmLl05JBUFboE0Z6KvPHuDhmgmdgtaRacT8dT6L7s6tG6xsXAloRtYuUWbitVBabUaFIsgGnuMEuwZo7JWTl/swI+db0oXJtoYNPayS+QDoeMd75Uczy7LasbN1rfBdBWX3NQuJUj8jg5iBCbxmlK1XGl96sF9Uexk+Y2he2n8Az5OE6LB3XN5LHUQeApPEK4nOZ2AK1uwh0951nq7VIENUR66GVcas2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=GF4LmL1W+c8cidmqvDEz/zqF0qrHgB1RuR5FwTRYJUTe//UfaqecdNy4FX1XMOJtmrvTK55pw4CsTDPLBKu3A/MPErynGo/5mhCMUeSaH1VaVZddm1qhKpKMPj6W3yqP07c8R8n+3iO1HvUBP1/hItYHD7DLfTQDrK5Q3RDcZRKvaflSwEAG34IXFySgzBHL7DJ+w8fPbAOxp2JosexulXTUNZBWO/+xyvtC5mMhK1qiKiHXwG2hoiu6DSpmb3iUCweI6ODo9Ml3FcDUFym/USSJh2066g9llyvUrfLlGeulV0geHJlSn7dA70FFbjjL+ngpaZIPfkk3UBuMzeQHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=OQvvNczaIxVi4w7od0NAtBmDdVA9MwT7OTBzwpmKkPS3o7rJTlQNSmBKv0c42S33Dh2ZCYp2nVNZCoyZB/XhsN4DkQT1nWCcRtu4JW2mAr+paJspvq/7B5g8BnPqlV8laz0UxjgcauuaLfO/Zxu47xvv8Pfyq1AJZ9FCdnQdpws=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by PAXPR04MB9140.eurprd04.prod.outlook.com (2603:10a6:102:22f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Thu, 7 Sep
 2023 09:30:54 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Thu, 7 Sep 2023
 09:30:54 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Thu,  7 Sep 2023 12:30:04 +0300
Message-Id: <20230907093005.58439-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0025.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e1::19) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|PAXPR04MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9a90eb-f23a-44d9-5b23-08dbaf8521f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hvLTxCJpPsnDui2xO1PLPk+5QP5L0vh83xWDtnK17PmHfBbTFmd637jKMJ+7iOFazi1rf6glF2Dk6bEoxNdfwauKeJ1PDOvkVrLs3xCIAgyaeb/WYuvLMGPwCbWZaduTel7rNF8MouSLIiBQD//itadbWlmmdUYMR7tpvMTk0oAtYPth1GAnR3oBwApP7yCBbh2bV/j0cHW4OpsL1lGiF/+hopdgv31EB4CprIXs5hx/ciLEHVs/LsPk8JGTrnmEPrKVenZc5e/soTBuGQC4jSZgSLY6f+bic4LMEdu9ymoB6T28MpEHDUVh/G7n+jS2h1a+4rRvGjep3UR654dTqXWpYpnCp9JP4P8s3h/tDJv9lhxgnFej26agfq8TSDEl4aLoENFudQ+Z1UDJmoKwYGiWbkzDygGcZYbr3Sal6zESKtbmnDZ4J4JFeoEdZmM6mE8Knsjpt8C0oIlZQ89+dVojWFl8PZwMTg+pJvm0R6H81zUWfgwKgJKA+3A+LA1YFS5ybXKomSGvCeQzJ5JyGis1A7bUrkIJ0SRJRognyKGIIyHpRsZvQsuySzD/TFW4+0Sxe83y9d5qNbaeuqtq93FDTd/ZfFrgof858jomlLnM3GMUnHf5Uge0nOAFR4up
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(4744005)(41300700001)(44832011)(5660300002)(86362001)(6666004)(478600001)(4326008)(2906002)(8936002)(8676002)(66556008)(6916009)(316002)(66476007)(66946007)(1076003)(26005)(6486002)(6506007)(52116002)(2616005)(38350700002)(38100700002)(36756003)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rl7D6QYWb0wjrqvpnycXfWVejK8FSdZV5u8pbVE3UY9b4a7T4gnjoQbp1AWz?=
 =?us-ascii?Q?yNHee0VAxuJUCON6hPuvY+GOgOYo+m9v4hr6q4FfZ75QAHd5J8qvlGOTtxVJ?=
 =?us-ascii?Q?7AMcHKo9l+NLQC44gqVTV3dZ51cM7lmeR+xhNflPdTSlj4CmsVrqWZsmOeou?=
 =?us-ascii?Q?6lC1hfSFXMlV82HAsvKfk6aCEmeziF3XhGQv5ZOeimsmcpb9gZB2Xpgz+9i3?=
 =?us-ascii?Q?RaBgOLuJCvjjeM7f08MZKaiuvzj2wD4hAyOktJNITyiiA9IhfFjyb9S+qKr5?=
 =?us-ascii?Q?pFD6+XSFxjFLNPq7/Sc66y4FHGg5a5teAHfB1u5mZvQxyT6RnQBYSfyc/O90?=
 =?us-ascii?Q?rE1qTdG+3ncR1wUcrD1WyLfUAAJLMHCcSWTyuJCrE2SoS1wvz8lLHtNMsazy?=
 =?us-ascii?Q?GZY7wTVgwTURQm3KbNDQqaryq7ytrNDY8tRyrf6VloGuZBwOrvQCj+EabvG1?=
 =?us-ascii?Q?flVtPHQS6xsFRZi/YOPrpbv6+LIYa14HHSI5ekKpoiPQ21bFCcS3iwf5JAnO?=
 =?us-ascii?Q?ZmO5CKOlTF86X9ohmFK1j+OKOBvZJwCiIhLN8CJ+qZYHwniccPuK/C3sDDeh?=
 =?us-ascii?Q?XN1tdvPs3+1uUhErxtH4356kTHIjEQGd+vDX5Q98ybG43G/YSEK7/f4IZV2j?=
 =?us-ascii?Q?h0dhAELNyMneSrJUh4duu/bGPzytFAIEgdCc9iI7pQJ4TqEuFprW8Iu4cV6y?=
 =?us-ascii?Q?uSiTJkjkWsgxmHNh8zp0J3iCdkv7P5WMSLqliU3GxuCLdsRCia4/UZy3zcHD?=
 =?us-ascii?Q?bck0Pixm+oguBFSDne9o3mt2oym1a+bMe2YOAP8y6TPdOKXxMHwhBBUhv78B?=
 =?us-ascii?Q?XXFCktFR6EiWNhiFADeTRlMaypkPz9xYxwunxerthSNBrTMPE7/k2Tcea14i?=
 =?us-ascii?Q?JoPJddEFfwFwoG4BWXKUIzOIJK9xkqAKvgaDe0Kuj7ATFoP3hUTf+ZrTJjDS?=
 =?us-ascii?Q?s3hULxv4UltHfNY7oAF37aJMTZ9Ml8N7GxTpHuIvugPk4MStZgTr+s17oYTZ?=
 =?us-ascii?Q?MNEhAIBXoHEk5+A4WpOcUTEaXRgOtY8lvxFeo0DIxXVlS9RichdP+ZAtBIKK?=
 =?us-ascii?Q?lWdR3NiQ0GhfN2XT5OVKswlJ35TQsel3fRC4EgFcnCN25OvzNwujx+UJCHL/?=
 =?us-ascii?Q?/3uKj/7cSrEieSLYfo+f7Fx2EdQfNZ7qCF20IU2IDSJ5trLRKaFYLaTMMLHb?=
 =?us-ascii?Q?4SHabLdzVHmTn9iEyW6wHyLYLzUSZbrjcu/cJO6XsiAmESj4S73YV5OrZ2Fv?=
 =?us-ascii?Q?6ImELpC8gE9zdjdsNCvzhWV1Gh21bmtqrPenJZMbRhQYbFykE5NC07B6vKbe?=
 =?us-ascii?Q?ZYnTLPiZPYS+/7xioIbB4TqtXNRs4IejwU1EM2hNAPttrWZ4hpaFjuLvToU/?=
 =?us-ascii?Q?zXTy+sO/xsLFso3ad3E0NPD2LmeBf4vDj+H4RYOH0W2Gon1e7BnzqkuHjvjG?=
 =?us-ascii?Q?36XDc3wTXLCDE6iPnbIvpTnvfZEk4jT12cV8Av9aw8dS+s7zyxV+ZrV0Rlrk?=
 =?us-ascii?Q?iSyysvBM6DNYycwRS5x9D/1T5zw4y9x7sgWeYvRAD4vJegXTqLkBf3NO/4MY?=
 =?us-ascii?Q?PmcbDmizgCp8Pcp1LskKU10Fv4zjeVLvQqUsvbRDMHkFfUquzWwLsjwBK+Rl?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a90eb-f23a-44d9-5b23-08dbaf8521f7
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 09:30:53.9907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kFNf7Fq0DQ3my3bp7ym08tWAkHT1DHDTj3QzjKiE1qxJTWrqOo1a+XwjsZLHQXtss2GvtCDSFMW2l+1jikaXrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9140
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Vlad Pruteanu (1):
  Bluetooth: ISO: Set CIS bit only for devices with CIS support

 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.34.1

