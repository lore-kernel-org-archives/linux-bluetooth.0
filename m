Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B07EEB8FA5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Sep 2023 11:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240111AbjIFLsD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Sep 2023 07:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbjIFLsC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Sep 2023 07:48:02 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B8F1709
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Sep 2023 04:47:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fh1k3ECco8rAL1rkFQrD2VDCrrj4PVhcBWePqnX7RUN3PU3ewxBCQ/ugdLiwWymzGqFd1f4PP+pUwqh5Lc6H5ed8LdY5L7fCX/kjollW3mjwMzXo4D3U1XDAyT6e5V716PMgzVvvzEXsrhqLsI3inSflm/jOge9szJ0MDi+ZWuiU5Y71Kv4D3Q8+CAyWB+SjQTOQJlYeyQqnjDFqXSZ3wid2TwHeOE73B4Qo0w5UL2MO1eKCCIGo+ZGREsa8pdmBVpFmtz8KagooElClhWLqxKNUP16bRX1DH7YhpwPWe5NlQKd4uYiZiZrlk70sbdoS3R8prreTcdgRa/I9HxCpdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FAh8/u3NcoYVi+HTHkQ/1JvAmFjUHaYSHwWwJDvALLE=;
 b=YJrlpFTW3zaVn58fQ9wR0hUPulk1ahj3wJQ8HsJTCtqjkhgET8+ZHeMpY/dCBZeOHeDCfvutC8aBPqNWJrpfzL5VKYbODisMPMjP/1RGQ9q5Mg6mqurTKs5JuaWbSQUSM3RAKT3CCDrdRstDTIG/S7+CIwINTkNS3/equ5DwtQmhHYrmHHrc+q+NjlVBvoJPyRHAAjO4D7hK/3zTkhy4IYZED/1Ywcajx9akkD+l4ndisR0LXKEXFVw2xG3XFvrsaf6n63B4frEWmN7PgleQsOkbrIbWT/L0NoZyzfstX8LhTouFyqBrV09GOfOggIUgHeYMJHdZTB0HIDNq9IY0ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FAh8/u3NcoYVi+HTHkQ/1JvAmFjUHaYSHwWwJDvALLE=;
 b=JOkdUTKj3DL3OBbiML5oQ2hNmXv9dd72lHaQlteVCLdgVuJPG3jZCPjRZco9dkqOOeSdsZx7rJJBeXQc17FlewnyJZnXxFvlXP8nWRvYxFIe7+tK/9a3bhywePE9rsMpCivqu2d8wF4pcMhvQ0W6RPALkYXcrtlRR/S1m7YxxYo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by AM9PR04MB8353.eurprd04.prod.outlook.com (2603:10a6:20b:3ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 11:47:48 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6745.034; Wed, 6 Sep 2023
 11:47:48 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ 0/1] btio: Fix BASE copy from getsockopt()
Date:   Wed,  6 Sep 2023 14:42:33 +0300
Message-Id: <20230906114234.10617-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA0P291CA0010.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1::12) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|AM9PR04MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ced9dd-ff53-44e7-1d5d-08dbaecf1783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPdHJnsmUa8gQAqVq5HfvW+yZl4sg1fyoKgAYfhj6sf1EnET29S82pSppZKr0mhceS94jkKs+FHQdoaGI22RXd6ENdBuJ4ffJFeelNRNKtu1cWI1i2qFlCaKeAGAVkdpn9F404tb778qJPLOt9HuNTDR5257knPxrRFkZLaO9aEkqvKRfB3a6w8P7p4gA/3FSBqrGlYrAp/69Jb7EHrMdwBxPoujgb2Qsa5CXpyNgmah/DDhJp7nVdilSFntOdc3tfvgeTKPJGnLymPXbIjYPdBpC5BkHRLcZPdb7AkZ0Wp5b7I/2vaiRDrM9g7dDT3a4OALDM1fy3chiClD7R90tUiISeNzcbcdvvmHI70fuG8eq0eslBLlbWvzMF0YB1tXdhAmptLe85e5acItle3vAxB1x3Pse0BOoZumpqrRUgEWjGd+oowsfHVldQRaQm64MwBBiJoB01szo2Il/8UxCz/To8rsiVykAmdeCJGuByv8t1LM6b0L6Kie9kXLV9QjP2zDVLuWv5gaBgNkqVwJtztd1fYBsyNbQmu5bIHpeDHOEShcR1oIue24MeT2j6XJtgMeOvc0RHQhUuyUlEYj4wPL9fPzO/WqzigKCud48lBojXtcjOiHbwzQPkMOPgn5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(346002)(136003)(39860400002)(451199024)(186009)(1800799009)(558084003)(36756003)(38100700002)(86362001)(38350700002)(478600001)(6666004)(26005)(1076003)(5660300002)(52116002)(66946007)(66476007)(316002)(66556008)(6486002)(6506007)(6916009)(41300700001)(2616005)(6512007)(8676002)(4326008)(8936002)(2906002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AnikbbIF7159jjeHFb6JWLmECDAN7rpOjxR3hkJPiAqC+MDEgtqNoNxDUvPW?=
 =?us-ascii?Q?/hmIeX5CqLc1WMNu/bQ/9FUKiaC2LG/Sa3P5DmZdSfYuuCkuR9V2maUa1qbt?=
 =?us-ascii?Q?ALrpNLyUpVd0MYKndWed8xCo5siqa+Up5s2GCF7WhRXJoEtO2UKt9RTm0vv2?=
 =?us-ascii?Q?p+81L+p7b36pNydTM5GYTy4Qn/P1QPGuyqmhoOOsuvJkYoPj9lD0pAgB5Y0t?=
 =?us-ascii?Q?QxuSTnbJ26doNB3+e6TazB5drSQ2KuTAq8U6n+9N3kf0VnfGk6jxIpAdiKhZ?=
 =?us-ascii?Q?PW/aue3UoV+fhrI18ruWM7aaL4Y2MZpK8oRapNbe9bDJhFvZah2BrLoafKPL?=
 =?us-ascii?Q?PlDOzjmjd7aso9Foleu+VZBYUbIx1rFbMLU+7t/qNG8PW89FYIucultxnNJC?=
 =?us-ascii?Q?iCq/C2mKSFHXSnanKt42GNuK0bNIRaDvWx+ji0OOP309QCnSAz9ubioBP93Q?=
 =?us-ascii?Q?9GrBXHjkPAEOn8Ll9RXtJOzztoTW5gBXyXFxITdYiyS4HFmTRDTPHAi4o/Xs?=
 =?us-ascii?Q?MFSfLUB9bpDFIlxDBH2Q31ke9N3PyNW3JobzhadzsMxFdhL4Rks5jQAwACnR?=
 =?us-ascii?Q?DnUB5v8JdbbMpFoNz0mkpJwJeXBp3RipTfZ4Ad3tl0nMPAVJ7ck+fO8w0aUg?=
 =?us-ascii?Q?I8GkZcCZWMUodnIfl1wVbE2SB7vCbzxgTP7hBGxaX7LFm7nPrzc+1ruBcsuE?=
 =?us-ascii?Q?MNynvYVrBeZNwEzO0AYjHNNZbUIXc5Lnxhf9zoPf20PjyGmoHjI4gGEVEs/q?=
 =?us-ascii?Q?n9f0Z5yOiH8r3aJwxGF3TEs++zrDv/e/IB+gSKy2UAz2OYkM0wx4xqZ2Wk0d?=
 =?us-ascii?Q?1RubzVHqgOnxCZ2IUdRcM58KImCd/5TX4b11YMcMNorCo53u6kbAiN+sRqAZ?=
 =?us-ascii?Q?+NK5vJNX7FeubyMDKk+mc7yx7zo6vJnZeh4GgCqW5VWEYRERAHyddQH+1jgM?=
 =?us-ascii?Q?HXRB84vfzftGyQQXzIJ3rCPB3OIayEBVlRbuzlHt5hKBBCrJt3AnBal1oPyo?=
 =?us-ascii?Q?gFTCqA0pZuaORX37+eWNmIU8aGb0hd2E5qfwMzaULU3ZZNDRzugYhcinYlat?=
 =?us-ascii?Q?5hSZsCqS55znnfRHt0EaTCUZjC7J59oW3UkgNo8gHQrz2LXHFd9zFiYr31VC?=
 =?us-ascii?Q?26wHCfemkBKrWaY13OKbRfTjtsm6OI44wi0RNrFdqyET37YQtLj/ydr9JozW?=
 =?us-ascii?Q?ec78kBfIbuwDSEwx1lm6ti/SYw30KD1fILo49IyrnPx1332+j/pD87cboJUv?=
 =?us-ascii?Q?oPLIwL4nQcjc6bBAmEGJSVgH9CRHDZoMHw+3S2pPly6/0EYwHfIuzvgScqgp?=
 =?us-ascii?Q?GJitk+B7ZBbHyQIW6gVGGtJKkXpzH4nbqkHx0BHGBGJEOFacL7dGEmSkrBo4?=
 =?us-ascii?Q?iKbT8Fr1I9oeO39SqxPoErZTPVvKzgBdLZjVojHouCZpdPScSvhwU1qRW8aN?=
 =?us-ascii?Q?aDLFGeb3m9rVz95BhFZpEx6Q6m73673akqYkfzNwztQ10VjLUZ6X7XHD77Ro?=
 =?us-ascii?Q?1o+2uNFpjQPA0CgxOo+PpI71RYtHGr9WrVNmHVPSj4+cebHIV3yMEnkRFICY?=
 =?us-ascii?Q?2qNPDIJydb2zqmOqZDMGcXEDMTCk1daV2GhsJWzt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ced9dd-ff53-44e7-1d5d-08dbaecf1783
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 11:47:48.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBf33xu+w19UJzB3KOTcI+NFKsw1o1JVr2weeEGlmNxg6nQiIS9zexZkdUuzLJh16hNL72kmDd0QskbBYFPcjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8353
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fix copy of BASE from getsockopt() and update base length.

Claudia Draghicescu (1):
  btio: Fix BASE copy from getsockopt()

 btio/btio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)


base-commit: 2e47711d4d81d2a86751dc0403895b1d1554182c
-- 
2.34.1

