Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D19DCE7B0A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Sep 2023 07:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjI1HxN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Sep 2023 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjI1HxI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Sep 2023 03:53:08 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2074.outbound.protection.outlook.com [40.107.241.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C55D8F
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Sep 2023 00:53:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMaJraJaeK+hLYIlsnnrWXX0GCV5rJdb8+44sFbXrg6RdOJEz4Plpz0G3c34Klq0LkmqdAwEhq7QFw43eQz5vExA0DGnDqIwp+8gSNnlDiDePLbDNnTex9nS0G5YRlbhe+PXsvasUhoT3KbtyeUt88/sfcZx4+AhIiPUiaR3ZNDbSTMWBrJ5blVz76k1T2kTJO/rXJqlDvl4pTRLqP2LSwDusPOYg83fPoKwVpPZyAyLUPvQ1+uwsRpvdWXeWE7WM98bbD/H/uU/y49QTU49Ikx/7qYtIJXOT/W1wKXDcWAiF4mxMwVYNxgksFAIpxm0UndvaZmq/FBTMVqlP1QMqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=otyqqJ+FDk8RqwyL0jOlK/QMLwfhpKkQ4AKoj2KKgBU=;
 b=IWwYxlFQ1H9K1Io0bg5lARoxyBigZ8XA+q3BZnPIuBwSIrPAExhWNsbTJg/2t2m2oq9BmJY67ZrVeO0fPzPXZgOiS8j2omU+X7U4XYiItpdcIGRHQBc0wd/0bZIaqS0dxaoLMqAqOw3WQXIfeJj4Gq9pROUqltcwIpShuup3Zn84thyDcGB+ZK6a8TViNZWnr/dBp7RFkC206/mMHb7n2tSSGs2lGBUtJEcnwdm/8g2RUWLlThEJi08iONU34butszWpoOe5ZTV4xiSHS4f8e98BCCWFzUoswhGAM9nhTLkts/Ls6o/TFpeOoHOv0o49LnEa3v7fTXZHbU0m+z2e1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=otyqqJ+FDk8RqwyL0jOlK/QMLwfhpKkQ4AKoj2KKgBU=;
 b=G9ce7uOpT5imhBX1cjmbQ0C2lpOQ9LDKXHBIWWNxBnITY+oV+HM80jiIX6Ux6VCftzbrWRlZn9mA5mZujMeB4xT5K2YusnXsGeihXbRs2eySNNT1K6DlMtfomFvx/YNYt+1MMqu2L/r9TrLN3YnhZe/oEHzbZ8SFX0e7Z8gpX0k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB7027.eurprd04.prod.outlook.com (2603:10a6:208:191::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Thu, 28 Sep
 2023 07:53:03 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6813.027; Thu, 28 Sep 2023
 07:53:03 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: ISO: Fix invalid context error
Date:   Thu, 28 Sep 2023 10:52:56 +0300
Message-Id: <20230928075257.3123-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0220.eurprd07.prod.outlook.com
 (2603:10a6:802:58::23) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e0420a-0971-4137-3030-08dbbff7f19c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i0rMROu/yvI5zJMTE6yWY/BDHsOOTwFcyPVgi7NavOEK140A4i9m552gCEZXK6rFxpINeL7yuumHpxAwPDd98aaIkusynKGeXpEUyzIAlHnCtIK/RzmSaGN+CKkp4lki9lqAVVyET/wJHBySDU7GXTw11b9H7vpydj+Y/8hjpVwpGu5kyANlSY/kGmsQU2K7QA+gVHzX5YlaRTCXQ+t8w1r3jFEMNNWaQh5jkQtLWLYO7/KU98sHRxA+kxjNNP3ltyP4UVRPubujN61DZzcMw+ZSCzu7j+IjJU/MzfEPf7k+/g4p8IUUY0gAAvbxhs0Tgbne4OVKC6h17LcUQuEBt8ZJr6argIMGICSpo2/15cErpP6VVPDa5KIwnndrSTghX2DzzJiXTo1H01eXMX8Q4xvR1vdksN4RIl8QdmS3fNLxAypzJrNJG+PkruWNDrg5Wayfoycr7NSOY+1wkThwgnMjNrkhLtOmCiBtY2ke0h0jryBjb1T7cxlYF+YSkOdOubZQOgw/sx3xEQqQ/H76zO/tDKQ9d5kw7yJLCvU2T0lhS/M4NNj4fKXtOXZjoP/t
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(136003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(26005)(6512007)(6486002)(6506007)(6666004)(478600001)(83380400001)(2616005)(2906002)(4744005)(316002)(6916009)(1076003)(66556008)(66476007)(66946007)(8936002)(41300700001)(8676002)(5660300002)(44832011)(4326008)(36756003)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wqa4WweXSy9zuWgWBv8N6Wn587FcDzwwl1qQ9ilpAUs3YjKy3YqZgWKOy+q0?=
 =?us-ascii?Q?YlmFLJRL4GY+cZbSudQZXu9v3wTW7KRODthXBR8O1LZVPIqxYo7XldgmuYCr?=
 =?us-ascii?Q?67lVxGUKSl/OpqDIP9CC1jKGDSuVpPL7l2qq/YFpwa8/o/c+LtELO6BNQ1mK?=
 =?us-ascii?Q?1Ad0+162I9RE4asiTWSCydognCTbmeSTrZb8bb8p+LvA80zb7BttfxByfYBF?=
 =?us-ascii?Q?dM37WufHmXaRh12VEfUNpR7KHuv5/GP+fQEOG0HbsXCYdTryoDCtr9PTj4Y+?=
 =?us-ascii?Q?NpEfD9tPLJlqvLuSHxCu2WXAMZ+/gTE3l5U4A4XZK2MbHWwCo3RO+DEo/SaG?=
 =?us-ascii?Q?McUx8k5hKUTnKvSIDuuQw3XMYgD0EJ6YiEI9Nc3e26/eShp5VxIBctSyE+tD?=
 =?us-ascii?Q?hqIx2t/VvF41NvgoOTq6P6IrzsdlO1kbeGws3Pc+L0Tsomui1w9yJnwCOjI1?=
 =?us-ascii?Q?EeWYMgkkUEKS1ZOu61eTPB7HMDxfT/Q9C7Ys2R83D7Jo4VEYmVxJ5WT1T4Xm?=
 =?us-ascii?Q?9dohlp4E4kT+rcDy32oYJ/xZIZoOWkGlZV88esw2FK8mzCqjj267RbWP3ICA?=
 =?us-ascii?Q?6vDYV3JIXoa4rwh7rrDkYOC6USFziiLetA7dSCkabwz0mydJCJN8WIQNM8fi?=
 =?us-ascii?Q?nKFsEqFkAtlQFrzUl2S8MO91Zu3yopV3yBERIQQ8I2Ww8dYLmYAToRJE/8R9?=
 =?us-ascii?Q?OioakGD4ckpfR346KLIN6YF4vDRsaDKomjVXUfpmmLyot///W4/tvRl4j30G?=
 =?us-ascii?Q?Xqmimp2tbOBfgTNvCJlI86ByEEtEM3QwXJuMDU0kVWkKmLglMGaZ8uw9OzC+?=
 =?us-ascii?Q?DuLs2CfXiuGYNUni9QQInjLC8iOIpEyLNGabNJFKRGsvmTfY9mFzch+a1eCk?=
 =?us-ascii?Q?e5FROzc3467IwVMYNFoCoJr/kSoOiL8VEbwP96Rp0A7yzkybIGcRCiu9fNqK?=
 =?us-ascii?Q?idKbAqoUhmxfgzuhLDSQItaUOLlAgaRKzgtj5usozFqcIXsvZru4bWQymcM6?=
 =?us-ascii?Q?8Fh38fIFfCLAn51DDXiRmxWUsXDzGnzv0w08n15HuKlZ+JgZmS2r5GWiN55N?=
 =?us-ascii?Q?YfctauSf/a7wc1vfin2vxccutaHKoBz6XVXUum9pSZGowzY8jItccOwirmnb?=
 =?us-ascii?Q?ZFBOyNkILDrjtXDrO8/ph26iabyzM8Ca763994rgMRcGhf9/hQc0d3moezra?=
 =?us-ascii?Q?uPCoXB01oK7ZTfLFbVuEE4Kbht06BbHq5KqIIwADZsWNoSCBf0/1eRhLqcFM?=
 =?us-ascii?Q?bMjaibG3dDtBpNScahMEyaGbK0RyhcRU5UFEs33XdCqs578EHZgGdWSu+sDP?=
 =?us-ascii?Q?PQAgGMROdoAebw/PbOfg8Mc2SJUL+kFSmCz5awzOvgqmr1eqf4QwOFg3O14y?=
 =?us-ascii?Q?X8mK4NrPpXqdA/VuukLiSTH0zIJ6VPeg71TNiIVOcuyKHmnW5PldkFMFqesb?=
 =?us-ascii?Q?eUQjGXcFxOjRqEALFpSV9Q7u5WKeV6DynlN82qZF6qOJNIjHKrk0HrBYtgBC?=
 =?us-ascii?Q?a/dEPfqdR3hONNReHjOhWrm/hyfVKUvmAgJ1bQl6yB5g9UoERefaC0P7gGtC?=
 =?us-ascii?Q?LzXqBM2HZkxD9/WuCvEB+EFkmTniQmjuvyq3oavVBXQzojbBDt8OFp8D0dCe?=
 =?us-ascii?Q?rA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e0420a-0971-4137-3030-08dbbff7f19c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 07:53:03.6640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 54P3O4XDAktmiYixwSOnZVL6vMJLB3IrUbdjOnW4wMX7DTYjlp77I+3wOLvkA1MxZN5kTkxcfjSkdwMAkOgJNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7027
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the error introduced by commit a0bfde167b50
("Bluetooth: ISO: Add support for connecting multiple BISes"):

BUG: sleeping function called from invalid context in __hci_cmd_sync_sk

When handling the Create BIG Complete event, in case no bound BISes
have been found for the BIG handle, the hci_le_terminate_big_sync
call should be made from the cmd_sync_work, not from the rx_work.

This patch version addresses review comments.

Iulia Tanasescu (1):
  Bluetooth: ISO: Fix invalid context error

 net/bluetooth/hci_event.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)


base-commit: 091e25d6b54992d1d702ae91cbac139d4c243251
-- 
2.39.2

