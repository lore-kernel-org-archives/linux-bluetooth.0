Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9694CCA0EC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjILGeI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjILGeI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:34:08 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE730E75
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFeQ+DIDGD18gIN7RZeYEridgUFfMR1iX3M4C7xtv1TFk5KRFoGqMSA4J7rjzNYu+YWR0310d26xB5GL+bMzOWRWw2imuqSiLzvudB1gIAxDebFPvJy0SkbIOLC4CuS/bspRTCTA8ePSshezXHcP/Wn9Gbm6pSZ/BRqirQmxZw7GJzePVgdtGpZ4DsZanjeHAtOT8hMzBscOwMKPkgJ/lgplKpl7mCFZ0/uJ6C9Dl5l/ng7QpF1ZaoIdN3MFAZZQXx3YnSd3BcRVOdTYbjJTSdrRzcPXBidB29YvuxkFakC9PhdSBS45Cpy62aYkWDgvzFCsM7y5DS3zn67ARMFTKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6+y7VBHxAZCZtp6BqXnkIj4HHdTWk1FclT/nykdLURw=;
 b=HxSSjZTlek+p9Nku5g6UW5CD4Fdtu7/n34eDdKXxp1/MWXmp6pHbaAUQATl/w8v8+/Dp1xczg6nQ+noWH4+2jPsV/fTarTJl2rnNebdmb/oM93Lz26iwzEcbh0sAXgwGY/r5tCLqZM+F5wQbB68wy0p+tBfqESmqPwTGQm6qmllfXkN6V6XGgen+KL5v+YpCjtcSyR1yfVhNHXBy/M+2gx47M5ARTl4EB0rLcvXKKEe9Y0NCiBWiz1ZoTwHem8fM8V6rB0rpa2yu36UgQZHJJzTSiNHgLtszAwQ/cF/7G607R448pUEZu25Og74Jv+HiJlGcyhcLW005bIfmyFXruw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6+y7VBHxAZCZtp6BqXnkIj4HHdTWk1FclT/nykdLURw=;
 b=JKt7nHcNoSSBikRZlLLEkVjEXILBYGc3eVSxR6qqi6FRlDhvI0Zk5AZJ3xjpuMbDN9q5F8dBACa6EiVCvLyYxiSa3HTF243rJFmqHVvzF8Wdq3YTPgFAkOP0CTpA3F4WbnAa8RUIgDV0O3mRKoQB07BeiF3Y+H5WBphb2lZ5QeI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:34:00 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:33:59 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v4 0/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Tue, 12 Sep 2023 09:33:28 +0300
Message-Id: <20230912063329.1196184-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0151.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::18) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 50019464-a6fc-4ceb-47f4-08dbb35a3f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AxH9qA8zhts5UvCcOKv9zKVv+pBPrq3TUhQtjDUFMWkJp2S/ztV9m7HpFLBOUKn6mPnlUdZhlScKsoXmKvxDJe72NaNEBKCX/KGvQgP9yTDvYy+KXDk59R4FVE8zo9iweZq4JDCOaFbWGqw6BEH7NuiJenff1iG2e2PpTa7/9SMuRpa78AMoZ5tZs7QpFrNIvpS3kEAjGZNuWlu/H4sohwPS70CSBlrck79wDkr+jNHzVwiuP847MEeJdPD8k1acN/bvWqKKjSCQ1odDn9BSNCvhEAejCnDvmAQXoPohRvZGk0GRxFLeHhQGVq6Rj/uTUqQaM4lVmviH9ZS28Ibi70Fv1Mmsayly7vNZoTKN9J/dIVLYREVUpAtrgfGCzdoHSILNRjHzZT8zlkIxOv4dfBy3WUC2Sgianclf4bcoQuG/HYCpvAbl2Nj7yTeYtraATEzMBSLG8ievPxawM5hJVIR4yeYAYwi4uUWhsmvdce5g4IuEJcd5nc8vMxVyREScajl91t3sJawTwHeoIctwgZuNytLSU4nYArw0NlLn15oG6LGzCT+496e+hjyKeOYWY2Po0da99/A5YFOfN9sOl5BEgJloeiDxcedP2tw/fcwC63bEoU4n8vGNFS7B/W3g
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(478600001)(83380400001)(2616005)(1076003)(26005)(6666004)(6512007)(52116002)(6506007)(6486002)(86362001)(2906002)(4744005)(8676002)(4326008)(44832011)(8936002)(5660300002)(316002)(66476007)(66556008)(6916009)(41300700001)(36756003)(38350700002)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FeKcVCKEDP3E3iyvZagbKOu5m4yJZN7+IcLMiQAwjJXEv/M3lBw7YJUH7bM8?=
 =?us-ascii?Q?Rgf6PBXV14P8iXqabA0c/ctUc20BsNMXZXWNnK+gefNJ6yII6p74HX6PPgUX?=
 =?us-ascii?Q?LINfSDLqu+V5Fa25ZvyZ5341aTXpPgkDxoOjMJHfh1bJhEacX8ZCdnK29sbS?=
 =?us-ascii?Q?LWfNbLfTHF1KWGPVuMe9nLdgaZ1K4nj/Kx/PNcmAlZupcdi5+APWotna0HOd?=
 =?us-ascii?Q?5h5U/U/fGPVksl44HmGW+IQyXUvFSVNx/KRlCv1Zxnc7s493bGAv+D99QRH+?=
 =?us-ascii?Q?iJ0nSIVXlGt/xDC2WTe79aL1+ZgWaAWx4WpKHxivsY35N5h1L9GJpKm6dCFp?=
 =?us-ascii?Q?WZbr0igE1XOXq4UBJQl+LMQLnW8ET9yJi/rYpJdkouLnxUjhGBsISS0AK+fj?=
 =?us-ascii?Q?yUBoht5kjFYoE+UrecC9rn56KXySQpJi3lY23C9aOXdypMeLMRAesFTmqR/r?=
 =?us-ascii?Q?wuIcNyCUE2WiSu9AGp9F0fnBVfstNVwXWOhhtm1MGQ+WD3CO3smlnlCllwwh?=
 =?us-ascii?Q?5kSR7yisbeVz+qE9k1ph0Tp+aT9zSrMbDhF9eULVaOC/GZPrJI6ce8ipLHXK?=
 =?us-ascii?Q?Px6BCB7LJCQBuvtQJF7zx+t6CYW1IVkMkBuNjCcXGftzURaQ7l0TFSccNV7y?=
 =?us-ascii?Q?zJ0jqPra33QwskrB2cJdl/hQQAEU/Wf7v98VNa8WLFsVkiY3EFgwSgEu7VUg?=
 =?us-ascii?Q?dON0NGSq2VTVz8wIkOYa1aawj6LdH9nI0SasY5nd9Zp0AlmYeePW9WvP4ZQp?=
 =?us-ascii?Q?4er/RdPNVOjIIRZHwiy3Hq+Ee1YRp8kw+UN90LbJfV2S1JiWZ1IcbZEb9FCL?=
 =?us-ascii?Q?c82l5viOU/xuOVKMK3a1tgx61R2qwVF2EwQl/oo40o4A99sFLpeMaQuusE+8?=
 =?us-ascii?Q?Nz9gnVwmL6OxtfV4pEUYG4Fehe4BShY0UEXqy9EUZLYTwUXqoaIpx856tPci?=
 =?us-ascii?Q?gHjmFPra82fC9h85hF4VHptTkY+1oUMFrAi1S8xQgYsj+kdJW+KwWDbT1jEv?=
 =?us-ascii?Q?WSOgObvYgQq2/Z9YOOi3WFQj9jHZOKCStUb4tHBbYaQMLKMhwNc2YBeIlP8z?=
 =?us-ascii?Q?kuNQmY3NXZgxEoGIRxF5w/WDe0/K2Ttb9SDkUQCMHaYbdM2SAyiSS2Lea82m?=
 =?us-ascii?Q?yttVQke0AdKceM7D8JngXABLyslYEIaJVoU/+INQPe0kaDEEoWs7YOM7qzcy?=
 =?us-ascii?Q?ccmYoNlHwdBZq40hST7IWyCr3JS4AchpIUJ6CwaJYYh1pjIOG1NXoV3EsI+b?=
 =?us-ascii?Q?74flKC6kfk4i8PrsfPjtj6xEBk94KDC3flaV7YfNjq+pD/3Zb3X7BAokUxN9?=
 =?us-ascii?Q?+zVYgadCIZ/3fYrAjXuGUaxsUyShd5vNG3RYCxFL+GPZ1idrOIvqXrYFDSc6?=
 =?us-ascii?Q?dhd+cEKuL67ax75iaDDo3BJ69KJn5YXXUPTB2s5o7e9dJopnPP90Vc8lG8vm?=
 =?us-ascii?Q?NnhfGD9UCzIXmz7G2Tv+0225kPxA4NcLNxm6IBLGeISa7aWjTOL/vFGPd2P7?=
 =?us-ascii?Q?FF5lGEA4q39LZEqYafa8wXEcIq7s5t0e/QWd5fR03iXG++s2ygU8m6h5iXpD?=
 =?us-ascii?Q?N3oJv4De41TrqGAfkqM+aK9YOChxGZn7Gqbf+u2aPmqb3T6+fHTNmmuHVxon?=
 =?us-ascii?Q?Aw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50019464-a6fc-4ceb-47f4-08dbb35a3f73
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:33:59.7841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhLDyJFf3txNM9PccFkXo6I86R7meFn/020niSNaxdWzE9C7a628sO8CgY1WzJelzu9uOgYKrxc9J3Ea3vhjOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Vlad Pruteanu (1):
  Bluetooth: ISO: Set CIS bit only for devices with CIS support

 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

