Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611FEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Jul 2023 06:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjGDGCG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Jul 2023 02:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGDGCE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Jul 2023 02:02:04 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2057.outbound.protection.outlook.com [40.107.249.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F67E52
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Jul 2023 23:02:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVuBlkjfGO+QixrnFl84xGNcqpNgr5sPLJpUrZt+b8Z+49/+fTqk01S+tlsmzLCx2JCZHUE0xFn88ft6UHMjnZQ+WHogmMf59Bis0PUFblopFRCSbpyRZgamUozzcq2RVFKZhqsRjECreCf08jvOgMn6G+4MIrrnD/uQ3aFE/L0HhMcMm14oJGZBa0xX0Je08+0X6SJKfzD2Lwo9TQUo6RIV9Aowb3OXYeEVoTDQuEZMq/gKGGYSLUXKaMxVla13g8vPHCy6H2vRGdqDFyRl9VfNFSL6B8kTS3Cao0exbAL6+DRLrIMKzRe+RSsXsJkLtYVyFuPrCHg7itmm6tkFaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPWsLr0EVaEvR18JPv3WOyyGPhXYrUxNnPsXuvolA9o=;
 b=UepaK6e68NFZ2jm/8ZQfQdhPUQQ8DrxdHBAysO6F/mtp7J185DyuJQ9sosiZwcyzZdPwzYbRWDvSrPq93zSaQKlNW2tkqE9VCiRN8+rqoRfEKZVMTitq7/paIf5n1gErnfqXrHLSCnueD0Xzm94hnD14gGsrGR+Na+9jtLVr6kSAtqrG+92LZPTyC8AQt5dm4Qll1MsfIijt11Bw/GXUS4z53lMDuQaNzPBaV5mfQ1oB5Gx2ewNJoInf4QE73ZeKIm8aby1F7J3I9ThCt2c+WBP/JEu4bxHO8FljtbmMhbv+biiawAzmAbrSVEX0YLmlNTnbThC2QmReN+Rm+3Ds4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TPWsLr0EVaEvR18JPv3WOyyGPhXYrUxNnPsXuvolA9o=;
 b=XYki0nMIUX0FbClS4vbuWAssrJGMPp6H9722lDj27/nLSPJBNkNOdhwhCvxynNkXdIRXtARCUtGOiYkScd77cqLLcwx+8JcGb4QhBvMKk3cKwWY9fqDLfhM7oE35dmdDAseWlX/enx/n/B3XL4RT/STMrHPJTpbK2CNJZzdoVr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB6PR0402MB2919.eurprd04.prod.outlook.com (2603:10a6:4:9b::14)
 by PR3PR04MB7452.eurprd04.prod.outlook.com (2603:10a6:102:80::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 06:02:00 +0000
Received: from DB6PR0402MB2919.eurprd04.prod.outlook.com
 ([fe80::dc24:7fb0:d2f4:6be6]) by DB6PR0402MB2919.eurprd04.prod.outlook.com
 ([fe80::dc24:7fb0:d2f4:6be6%8]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 06:02:00 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] plugins/admin: Fix heap-use-after-free when using 2 controllers
Date:   Tue,  4 Jul 2023 08:56:42 +0300
Message-Id: <20230704055643.296260-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P195CA0007.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:21f::12) To DB6PR0402MB2919.eurprd04.prod.outlook.com
 (2603:10a6:4:9b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2919:EE_|PR3PR04MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 627468f7-cd1d-495c-6415-08db7c542e0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCJjqfF1Y54U7joQmpnH9m2NtcMgqeEjm2xanPgtRynREa06tpGqKY88Ng+/J1dfGhU9w7cjKIGUes7fRlAE+1S+SwoDbOvSAb/kGafJ9q2gk0RusL+MKLCsXV5L0RnlrASpCuBdmw2mgx55F9H2NK3YN5IMRIn1hRPIm1jykHmNeR8h6yBe7DzDaaOus0+Ne1h2jE+U0W8pn8ZMNdJgByVujPri/BsZl4aFaA4TrJpVsABFhlsXzFYPaqFBgW8Tek6gfBaPn0OtvVycxXbrdWFnG73kpXo3JkD7SVUzk5WEp5EWdJBR0a2zkC3Q0xg9yBGX8T3xhsaRErlfUjYVr4ISL3el+1dV4JmpP8X5G0KMWBTN/No7xk14h9kMOV1R39dJU9NcQpPGE0CkBfzMBgRoAw/41krmz+QYa6hefe6n/igoPKASGu4v+yiBw1eKMRlSVcrvvwev4utRxcKaQzPdQB+AjKj1LDNE0iH6b9Uscti6xQRze7rC5rIhGKgNp5D2z8t96s3uzt8Wie+VnUUtdeUZHT3tUkHu1ZHXeRF6gu7jbildN0I1zGOlTHc3o6JESl5h0oTcsc7nOWO6znaxnL1ZSUrwCevrtjVdoAlqtH794mpRbPI3OrdSz2ls
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR0402MB2919.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(316002)(41300700001)(6486002)(52116002)(6512007)(26005)(83380400001)(186003)(6506007)(1076003)(2616005)(38350700002)(6666004)(478600001)(38100700002)(44832011)(66946007)(66556008)(66476007)(4326008)(6916009)(5660300002)(86362001)(4744005)(2906002)(8676002)(8936002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+VxxgvkWis9g2QH1xBFhOPHuV9pwqzb1IEz8YmuBb2kPnqLbHsDQbRBEWhs1?=
 =?us-ascii?Q?P7ZzX00CQwPmOvTpVPHC2eHzCGAtjOLfysuJDMulk1k0jpalhK6Ni05Jf7ey?=
 =?us-ascii?Q?6L1LFWgK5m6JStuK6cWP53SOYu2C4oK1jpDNS3Q6994LJMpI13ZW1OUm6bbT?=
 =?us-ascii?Q?dmb7pX+YAOZqUqX5SJG6y2nBxLbYrj3fSLA/nGqA1jonrEIIDTXIgp/N5EPT?=
 =?us-ascii?Q?vdFOG8W5/53GfcTazusKBn+OAvIXcE+pWs0XcnyJs7lvp0ehkxJvaIWJIPdX?=
 =?us-ascii?Q?Qkp94/XAhd9rmk5iuJ3gRbtftA+JkwpPVar3kxqLZVoqK3rp7B0DzQoA9AKU?=
 =?us-ascii?Q?b8dCPR1AwXP2hcvJSy4pmOl1qLVdCQ+oOAQhO8cWWfULKzC36KCRDpzBzDrf?=
 =?us-ascii?Q?uqMrzpkiwT+TK7Ps1v0ArnIOSRR/TqYJ5t0tjO4Um0anmpA8EgV3+PyV5STC?=
 =?us-ascii?Q?6yfXb8Iq+5Qa2F7eVEOwMl1h02sberacUdORjBK4Tv3xeYVGqZCRPl4Di1y1?=
 =?us-ascii?Q?bwGaIXc3pZCLwU8GwJPvXqIXbvZInl4q75Ig5+O5XbFq44u2TbvJbZZyEzYH?=
 =?us-ascii?Q?LkQ+fng+NfgLhC+484BMKYBv1ysncjeWWjq05dTlOBvpJKluRRIawZbWwPbE?=
 =?us-ascii?Q?M3O4fSwUl664rBo8WtPiLmrO//HQbS8LPmFMUwCzJudFkEuUQU2PY3/eSZZ+?=
 =?us-ascii?Q?PUwI5+lhMPmwPO4C6ylYR77jJqAa5Gh30QOoCxATOtPFMKMO/NK6S6cBLJ/I?=
 =?us-ascii?Q?y71xiXxuOAeC4LmhNFxaLVJwAPFDkEslMF2b4qWRIlNMrTqcq+fxotGYKa2A?=
 =?us-ascii?Q?iYDkuGEZlabo9zBhfRwFL+hI2hCo/z4Cn6RxVjIf3OKzRgrrSdTFxJ7aLGNP?=
 =?us-ascii?Q?SVOO9AB71U1w4dqbDcImtrp07zZNWNU/7VE/+6RUfqyOjc/5zhi7qAQFyAQU?=
 =?us-ascii?Q?Tg2l9xLEAkDO5vTexIaooMrxd3UUm4uNIUSRgtJadGX0/fgSmT4bRc2N020/?=
 =?us-ascii?Q?YPA0ZSpV7HDtqv54evHGgfwtCko21vr3Mu42xUADbD985yRDS2/H+B2KxSt1?=
 =?us-ascii?Q?UcZ2U3DxG8VYS/6rgec6n/QLaFxGhxnP1qFprRbm5xBI8zN+ZeKT9Ez7hAdn?=
 =?us-ascii?Q?RfjbMaiPUcz2Gjh6CyA+BuS7RLFCSLIMvcSITKK/W+DX2najybsYykVhLu/b?=
 =?us-ascii?Q?WmdGk6gEYq6+XFbQNwOInbbPC5VRvV4s/qzqIPSoaQI5WOLBzZZ2XZJ7rwnb?=
 =?us-ascii?Q?RevbLA3U2sFCthCmUtjQJinw417ujTJ7h4H3pi5Y6IRc9mH2nQkFkPDsLpBV?=
 =?us-ascii?Q?ix+aHRM2cpMSxFTtjpRavdNAsx5XdnpBptYE6vH6cE2F3LbrZsDqIcCE+2kM?=
 =?us-ascii?Q?wJ4TnDnDP8UZBdxCrt5fL3z9hNgDYwycJx/Ktvz6QgAv3p8lONP1gPtC484B?=
 =?us-ascii?Q?1iG5adtTSE3ZDHoU3m4hbI3F97Xtp732rvaPmJfeQbaPPSG2dbGJOZKT533i?=
 =?us-ascii?Q?WuYEYWMUrKQYufx/CYlL4EiY08RUp3YaZSskjxdoultSKEczlj7TNPnrOBZZ?=
 =?us-ascii?Q?POD4mlQXEm/IjrHtiPHN7z99/Ja4CqU4yzwQfTkC?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 627468f7-cd1d-495c-6415-08db7c542e0b
X-MS-Exchange-CrossTenant-AuthSource: DB6PR0402MB2919.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 06:01:59.9228
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7HKKz4K1XIUWDKoU98lxmWzhSjjmB+AkrpWxz3Ih4nuuQpxpp4WBrdS+MXIMatCKlNdGA0bN5EX/1QyIA5o/Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7452
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit fixes the heap-use-after-free error when connecting 2
controllers. When a controller is connected
admin_policy_adapter_probe is called. If policy_data was already
allocated it gets freed, if not, it only gets allocated. Eventually
add_interface is called. Here policy_data is put in the "data" variable
(specific for each controller) and the process_changes task is called
with idle priority. This function ultimately accesses policy_data from
the "data" variable.

When Bluez crashes the flow is:
1)first controller is attached
2)admin_policy_adapter_probe is called and policy_data is allocated
4)second controller is attached
5)admin_policy_adapter_probe is called and policy_data is freed, then
allocated again
6)process_changes runs and the policy_data for the first controller is
read, but it was already freed, thus the crash

Vlad Pruteanu (1):
  plugins/admin.c: Fix heap-use-after-free error when connecting 2
    controllers

 plugins/admin.c | 1 -
 1 file changed, 1 deletion(-)

-- 
2.34.1

