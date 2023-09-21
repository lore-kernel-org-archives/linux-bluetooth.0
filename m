Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D5EE7109A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Sep 2023 17:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjIURJY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Sep 2023 13:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjIURJL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Sep 2023 13:09:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on060a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0d::60a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F17B6A69
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 10:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGguiPEojqL9h7A2i5kK4l3OvEydsaOzqt6tu9xOO32aJ10/VEDV9D19ao91hqZ5OlSFXA12NrQ8oaTXq1fUOq03H6iXdR07RWZqjUs5Qr2BrKJbpk7QRy9zrPapBeH5T1L1u1FSr6kPMwyRpHBVznfzcio4J6A5NO+qxM8s/w+WkrlukfkjDYG0y3leidWdb6fWm+1JU39leIVCeeJAfP0RvcrQ2ChLP8BahhGDCfYERWWIeQXmH/uZ1Ya82FpyPxSKxgCxN9qJQ46Rb1F7qtrIS9bFeCTP+1vFwFEnq11a3QfVXPx596ce5ultw4ZjxwpI7L+jHK/wQlUSxz/nEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YLqYUDT0g3sKUHnPKZ2RVdLWDWQB1qg5HLvBvvTWVvY=;
 b=dPXfv41h/+IsrvJ3v2bwjLDooZ5oPn8y574DGv6rJJT5QCSLpeeU+Ijr1n93y1trabS4zYFUzGlU9YCiAxwpu3aMMWwNMc7P1vcVrP+WCLpf01arsD3WhwSkfEstnBTvywP9DncBgkPQ7EoS/HhsLzGcQj2nR0FZ/G11dMcxsvmRhyvyPyxAtkChTby469boEOTo1YiDxNiB0zAHC+2FW4IhTTaXAHclLYAzzxdQeMioRSxcuDj8L3MkghkkLNElBqLUFpSKcWPNRPKOBfp/EPMBu4XLoJFELGFsz6Fseat2LiQFPbUiBiWr/yj6GYzS/QEQqY/eqW99SRbeHVYMgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YLqYUDT0g3sKUHnPKZ2RVdLWDWQB1qg5HLvBvvTWVvY=;
 b=FW868Tj+wPoQkJLZSPlZrJCRYyvLYINYOoHuFt4BRAejWJyxk3WlWlpQJKU3Euy/Y265R3yyqIz3KrHD87nFEwmUC30tefGxvA204WI0bQu9T+vmV79lInWHAhZEwHmC8LciYPII7udLN+QuSi/CB+zAiaTSXWLtXKSvsZNyO4A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB7653.eurprd04.prod.outlook.com (2603:10a6:20b:299::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Thu, 21 Sep
 2023 10:40:09 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 10:40:09 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, silviu.barbulescu@nxp.com,
        iulia.tanasescu@nxp.com, andrei.istodorescu@nxp.com,
        mihai-octavian.urzica@nxp.com,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH BlueZ 0/1] client/player: Allow the user to control BIG encryption
Date:   Thu, 21 Sep 2023 13:39:44 +0300
Message-Id: <20230921103945.36180-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR1P264CA0194.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:57::9) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 668e2673-e0c7-4a7e-124f-08dbba8f2077
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhGKQlf0KKFJXOllHCLOkvfJNENYlwmT0ZOJNacHvtUdzLZtAObcTV5EydlMBSg3fGT0nmMo+LjyRWYN2vf4wqKtmE127upJVApX4KpiqxKxkoTFlww+qgDRRyNoFb66nWhgRcYbkT6oupid2UMT4wGCmMb9516pVByvEZzuJzC4FZoFNPzAqX7fKefB1oEASpcofpmuo6mNMIW8tEH/rmNtaU0nbVQPeRJqP0zvN7JRg1/7k33AojgU7JpCEC38c8Sj8X4jJwLRLPSDjOMcNifrt/FsgoRKPJdH2EJY+OuX2JZQrRdGUDDLtFtLAr8iuNLtoLd7G7iptsBszSbUCXaFW5+ac3xyaWwOhpkwGWf8AVLToLf9Jo36h850HLy2OntyJuOfLSxEU3cNg7amwKtfPoOM0Cju/3s+r8Hx313TcVcMMTDNvJPAnSiQcFcQH9OLEC26ovmbnApmKUUnk9L+CokYmB3mT5PsYf+OLq8RZyofvPWB1FHw4kIBC9aWiGFfc26Oxdu0rZPK3r4Bew/xnogugbT4nB+GLxuk9fJccra5k6wTQxvak0Dedmvn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(366004)(376002)(396003)(136003)(186009)(451199024)(1800799009)(2906002)(6916009)(66946007)(66476007)(66556008)(41300700001)(316002)(4326008)(5660300002)(4744005)(8676002)(8936002)(44832011)(86362001)(36756003)(1076003)(83380400001)(26005)(2616005)(38100700002)(478600001)(6506007)(6666004)(6486002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u5REe4bAB8puNHt2wHfKqND78Zxr0naGh1k9Wji1aPUpweOsk/IQ5bKqyQrH?=
 =?us-ascii?Q?VJ96XzBv1mMajbTAzNRQhVW6I08hPH6RTAwS6nUAcjod4RXbQ1kUaCnKg3ev?=
 =?us-ascii?Q?+hhcH8O+iCqEEuaeBrjEs/i85tj88tOKcgq+GQ3OUs7EWoi+U67JgYFm0NUT?=
 =?us-ascii?Q?IlCVN0gQTmgrJzwmp7zJRYtYBtuBV/1jikkEpgaeBCQ2rr9igIfVPtv97Mw+?=
 =?us-ascii?Q?RzggugIRlwfzOE9SPitpQZOsqIuSpHmLH9RzolbluARdADp+srSoqO0wLH51?=
 =?us-ascii?Q?+3E+EPWURXv7h1uP22+JKMDhqJg7XTQD17HmwGM24DSIKp0aU06CVG1w1FOi?=
 =?us-ascii?Q?LwoqU/cXDAKzJBnrraReDtqrC3hajs+7KfSONaBNTH8Ftolmbssjy9fSLUSg?=
 =?us-ascii?Q?VEHYuU8bfTRJ9OwCyE1zusrYYenKuQkEgNpi5z1rLTgDFo9Q27tUJcVxflnQ?=
 =?us-ascii?Q?DO8PYsFJyz+NUCIbdKEdOyxExvBJ6sRSbbi8E7lYpYLT4OBEPdMP1dtLNvza?=
 =?us-ascii?Q?RHDeBdlHULiXNz/Hr8P2YJjzMbZ6CKvleE/ZmtV6YdYV6aGqIq4CTjqLbAEy?=
 =?us-ascii?Q?GT1qmOPeF3xRPNSMQwVFEQHGCpefc564zmMfEBTkt0AO/DNaf/JqAhVrPvVE?=
 =?us-ascii?Q?aDf+9HgFJxHhCrRGCfgGg9qHDy+kG+pDDv4zoNMB9LDAE3+jF3Wo5NAwaLE0?=
 =?us-ascii?Q?iEugV/o4QqVjkhkwTcwsJlc4nAtLqCM4gqMQvmbRpTF1Wezlh/p5KhQi05I2?=
 =?us-ascii?Q?OYVhegCA0faKlYQ2WttEleDD4Czky+fo5omIl3epvWacZqGExe8a8Np2M3Uo?=
 =?us-ascii?Q?I/2+Wq+9MlIFFiPZNw/2keUy2FMV0CMt13PfbDhD4g0TimZ+jGCr5VjcSPEX?=
 =?us-ascii?Q?oyh4wWycme5jIcM/CGsYzhJHNTq06KDkBS9gBtpmpo4GpD8KQYK1ZXoWvA5C?=
 =?us-ascii?Q?Uo9gK/YaDz3M+N7gNYdZJI+AOA6CtIwlB76aPHT0MPx48VobElUkw16O2EO2?=
 =?us-ascii?Q?7yzBYiuZw2ng+hSHMt9j0vzF0+IcjyONQs4GeGuRnptgEaj7y/lvUSGUzzsU?=
 =?us-ascii?Q?6nBkMiAxiZeS5JauhmvjiQ4wBudGmVQ7jFi5ovLcrD41GRw5o6wbFiq1z1tM?=
 =?us-ascii?Q?h7C+PTaZ9R7bzMoy7ZBqZXl5gnd7DSyR6jqhXvjTjICj3RbCpEPeAxVtOynS?=
 =?us-ascii?Q?Bc/5aqjy4CTvT5NjfvlCbI4z5QJmwvb6q6oAocuXdCm1D1ZHCVd8EmwpLKGj?=
 =?us-ascii?Q?UxOGPByFJjZqjMrCgd4LrFitQTHgEnr8TFgUlRuoB+7t435KkPggOEU++tFH?=
 =?us-ascii?Q?zqSiI+HSK/UDnrXPByUUFR/rxq5zDMv86slsykzBYlydZF6mzfXQEiOb350Y?=
 =?us-ascii?Q?oUkLWHPReKTF96H4dLXwA7s85kLk/neBrgCZVM4ZjBSIVRubtWX56WcBjUPU?=
 =?us-ascii?Q?4ExKphubwR1Lo53+ZW4gQ/c0pcihGc8bmyOUa7o7ojTe6C2Vyfo1k7YbZMQe?=
 =?us-ascii?Q?7oCzYh+1v40DjaJzc0LPZASHx8jMYwOCtFLW9pZYcBA00y63TiFkuTa0fdvV?=
 =?us-ascii?Q?qFYWUWFHcP08iT88E43HO9IalG9Wac5Bb+6bWX6Y?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 668e2673-e0c7-4a7e-124f-08dbba8f2077
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 10:40:09.2534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yl5oqSs8QIMSci9+1F5Blh/g2TvjZdxoc0psvY1Heymrmy7ZsOmQvtLEsi4X/SUlXYIMV7jbfHHid7MUhKxVuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7653
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This commit adds support for controling the use of encryption and
setting the broadcast code. This is done as part of the endpoint.config
command. For source endpoints the encryption flag and broadcast code can
be set, while the sink supports only broadcast code setting. If no custom
broadcast code is provided, the default one will be used.

Vlad Pruteanu (1):
  client/player: Allow the user to control the use of encryption

 client/player.c | 50 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 7 deletions(-)

-- 
2.39.2

