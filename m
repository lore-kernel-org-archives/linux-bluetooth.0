Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E96BC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 08:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjCTIpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 04:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjCTIph (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 04:45:37 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2053.outbound.protection.outlook.com [40.107.15.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCEE2203E
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 01:45:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTtBIrfsO742XZsweXriWexdVEdOnpUyqZh+V54l7Ba4sm+f+/fg4xk3TrGdf/lQHCs2m/pYKn0xOOOd0uGTYB1jZ3RH/g+1ZC3JZ9GCZZAquIIBD2EEJfcLvzIHMSyz1lU9NbCd14QIXqPMyE9YewQkJPIfBQNVDqc4Z5DtrFaT/rHMfscNy2HU425zrbbQ+Tje3zo8Chj/lbgQxCvinwuNgLXKTf3Z6i0drXmDOXRBN7epMWTXo+HsYjFF5FuShOof65xIp5n/kqZ2829xoIan0haZJtT2kvHbK9gTR4nrdwqE8t0YlfJW1gtxcxjDzzdDCGlA+a77J7a4D4+f9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0N9eaQY2vDuZj9Mb2lkKH6eelcbbNcuVJbzCFDMpJE=;
 b=LXXSln4zn14Pmj72SLW5lywTzkuM0lvSXmKu78ikvscgF6NjweKG3yieHT9GwRqRSttIs/rBIY1lNfStlY+BLrYD5GO1/K0KwmuJzn1b8a4SFSRT+NoFAjkYoRP7KUHID85VbJhZLUFRyzrgSR8fNeczUVHwpQxu1Ls1jR+ksA+mzvrqXbBnLTB5Skyt7B49HxbuEUsjLwRzncDoDMEGFLN6l1nKlHrxEKm09ScWCQh432Q434iVPBjoED0kyva4ErrdSSCwSiZMLIMDLXnDWPMFL+Ii/tCn+y1HGw+SrgC+MIu9CIDOGDsMEi878af98w0EBcbox3BlavQZsFoEJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0N9eaQY2vDuZj9Mb2lkKH6eelcbbNcuVJbzCFDMpJE=;
 b=VQY1bXtquO0EYGpKznJLXOdKM9NpjBlgEtmL+OpkNh5GXFhjNCaTmC8FXbHTeH36NNEzf2IGsB22U/iOv4TDAWXo6IxaTNE34guCBjqHZz1NF+IsUvNYKVyw7zyUuwXoyRLhWm3TXKAQ1XpeY0mFYoQ/JIgygjBaEIp1Y8h4qP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AS4PR04MB9244.eurprd04.prod.outlook.com (2603:10a6:20b:4e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 08:45:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 08:45:18 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 2/2] shared: Add initial BASS code
Date:   Mon, 20 Mar 2023 10:45:02 +0200
Message-Id: <20230320084502.66630-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZLOe+MECyHsZOrH23E_1Q6cCZNXKHm3de4u6ErdGg5OyA@mail.gmail.com>
References: <CABBYNZLOe+MECyHsZOrH23E_1Q6cCZNXKHm3de4u6ErdGg5OyA@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0021.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::9) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AS4PR04MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 4aa67e61-f8d6-47d5-80ff-08db291f6ed3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jN8ruZkn3S1xFYeLkfb+ErShM/z6M4Rd/Dga/dh8E51x7chLnE60BgpZ7FeUkqksWhHlu7p/NV6h8ft5xn8XYBnh6GDXjdHYjFNqgR73mzSZY+KNAxslhrTIrFPt6rJHdt7hrU/Cdp6+N360xDu6+CAZXa+8Sm8os89jkAs5aB6vHk8UPpJzDQ4SLCurQgEqwIIMKKWYzZuoF0UC3zoZ9+vhg8T09cSQ0VMcn+UxS7MkcVVTpzSo0GtxskVqkkDvRLfqVo13/XbTok1mKsWZ3SOuYTSt7gGT65CrfCRawGeZmQIfYLBDKMM22ufaVrF62sy9Q9GdpoBnjtQO0LInd+B4xR8m6Eiz0WrlFTsDV2hLNZ6Zq2IK+3xoC4sP3udlrK0JLygB9m05f+A93gABZZgi3n6pOwXuPWBIeX5mK+x4eAUn6SaVCGvRqwtjrskq2NC5UANj4O3fvyTdzs9Ux4Q0NzYWz4NSt7zBbyKWlNrTBJIYQqQe9b1hxOhdGjzgHiHjFjidwbpV3T/ajDVm5ef7i7KmqP+HSTJgMg6npa0Sd1ndeT/vz6VevDDUKJ4qXmbP/PwZMqLvNtp9uzkH2LO7jzl0PuGuSJUOxUpGVEOduBw1pIdKhFZSIESAfil523XTLTfBc5RzjCcxlYU7XDs/Qu5UScutTqorFJBbKhVuoC6zxduwtDnnb+rveJhOAPocphL0957Y0+uH0T4cVw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199018)(2616005)(26005)(1076003)(55236004)(6506007)(6512007)(6666004)(6486002)(8676002)(4326008)(6916009)(316002)(83380400001)(52116002)(66556008)(66476007)(186003)(66946007)(478600001)(5660300002)(44832011)(4744005)(8936002)(2906002)(41300700001)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xuVXDhBWu1NUVxhKQgctyG4xd2VPj46n8M+tssBR2vyPIhzzVZqmWZSp6HMw?=
 =?us-ascii?Q?Snq2+FKvJ2MDkJKGgdZpr4o4S8/+MLDMRJ3ez9k7Mb3nlfgQwsmWjpZZ7NPa?=
 =?us-ascii?Q?8ICucKifNY+5e/KREi5XhKOh+pSNv86jtfqItsyuY7yZ9WZGuD2mfAO4TnuF?=
 =?us-ascii?Q?rc3DCTbq6xq2ANtkmvSO3WvufTEYGYWiF7gRH3yALVO1d1qLr/Wvy3LlxdW6?=
 =?us-ascii?Q?ouofNj2BEyLGTIozikWeSdWX0PY4wZEwfb7Pp/wBtY1A0CbLp8Wh9Jd5R4mj?=
 =?us-ascii?Q?E1LBLapXAl63YW0ctuCz7f0oNL2fomWx7bPtVU3oIkYC0Dr8ILGXpwgNBXwR?=
 =?us-ascii?Q?4/CZd47qPWpWG5RCJOtjtYXmNkNcGwzbbd3aBsHVmuf7Pb+6ng40hJyvta/5?=
 =?us-ascii?Q?dX8t6yxcGFdOTawYLE1KUZ1szjpJFuKyKufE737CbUG6YeA6snk0udDJYI4I?=
 =?us-ascii?Q?Wu7V7Vzu7QUxz4UoKx1urkBhnDASQy17H/gb9qM3ZVPi8ZrcMphPszXc9OFl?=
 =?us-ascii?Q?8smK41SW4V87FMzUVOWSqYuxTkyk/jx9sl+o2LDOTHzAY+uJFP7Yt/WwpYss?=
 =?us-ascii?Q?ub3OsMEWVWyjjAtP3EqSPLsJwPce2feKDLWrjj+51sO5EejSCdSeWr0CP2ZP?=
 =?us-ascii?Q?/Jv794U4zpJtc7m2ara3Gru4FkNtw2HUYiy40OB1W3J2c6G4U0mc8XL9pjki?=
 =?us-ascii?Q?TcWend9oI9gyAyX2c0+Xlhan3/SvOnR1siW/pUGnUyzLzA1ED2XYpLQeoUOS?=
 =?us-ascii?Q?n9owGoao5AcoGr3HT/HqvX/rJna0IDwIRWeItUJypP9jW3RAC2INQ9fNMg0j?=
 =?us-ascii?Q?Hc/9PSOh1r4M4Za91YgFXwrPe1hItVakdFaEkUX9TNntG23u2u9oKzOIM1fD?=
 =?us-ascii?Q?92nlPsjLlZQYWbKpaRKursrMTWKA4TTZLkL/wqAXAkInD/cblnLcQDIRGSHF?=
 =?us-ascii?Q?RSIHXOd7Jhp4fwj/98FcdXWerjeM8/xlRm2/gPmoquXw0T2QXQcz/q+2ZH6H?=
 =?us-ascii?Q?Y9VP/qJXKkk+5TWFwqwrzZ8gqrZ50yYW8141lSp/fiUREjzCSDC4Q8lf983m?=
 =?us-ascii?Q?3gm353ToV7ItM50Z3jHt5wQRx9RNOlfhdbpG9BcdpBjc6lxbzXJNfYsOmOHw?=
 =?us-ascii?Q?b42jiGvHOyIPxMZslrVbVWnKaJkm/mwASSAMF6aH6VxsRziebH5brjsWuzco?=
 =?us-ascii?Q?bdewwH4kkrqTxVYmph0WqnhpF+tQoxlitqI8K24QEoOWmNk7/LfB24YGDWir?=
 =?us-ascii?Q?viJVE3BEj/dSVnrQq93cmi5g6Z2ioF5tls1VvgP9fZf0VJCCcOCeqWIxHVJG?=
 =?us-ascii?Q?hyFTCVzhULGVn7cjJBnhUAMwWDrDrq2C1kBi4pLayVW3qk97uanmLrbH7VzA?=
 =?us-ascii?Q?HqE8t7expgt/cNOqefDC7QPKSCJucWqa7Urtq1iDwALcfyKNqrphaUsD+ino?=
 =?us-ascii?Q?0WDghikVibIJKBVMQVq5xJ+589VVVU2UEXo8P+71ieMZMdRnUIPCU8ZeVGqL?=
 =?us-ascii?Q?IHtGjfFUolVGf5rqzAGK/24TNWyxiR62UPRp2KGS7AmJwGubRA0of+ch4dks?=
 =?us-ascii?Q?7pwcYiSg/r5uWNaPhCpwWY1lrK1bXzAhf2OWgwMk3kTXQZK6qVNlZ/uP54Bt?=
 =?us-ascii?Q?wQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa67e61-f8d6-47d5-80ff-08db291f6ed3
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 08:45:18.4855
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOB4eXV0s5RHLeIFymd2n8MIeDJcnZUggtWYDx6+3I/bk2gaUkJ/cbWbLxHPdQtWlGZnqGg9sOboUFfgoJWOIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9244
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Thank you for your review. I found a way to update the BASS implementation to use ISO sockets instead of raw HCI sockets. However, in order for this solution to work, I had to make a few updates in the Bluetooth kernel, so that I can have the ISO Broadcast support that I need for BASS.

I split the "bt_iso_qos" structure into dedicated structures for unicast and broadcast, and I also added some more broadcast parameters in the broadcast structures so that I can provide the HCI parameters that I need from BlueZ to the Bluetooth kernel. These changes are currently in review internally, but I will submit two patches soon, one for bluetooth-next and one for bluez, containing the bt_iso_qos updates. After these patches will be integrated, I will resubmit the updated BASS patch.

Regards,
Iulia

