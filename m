Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7AFEE57E0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Sep 2023 09:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241856AbjIHJQ4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Sep 2023 05:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236197AbjIHJQz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Sep 2023 05:16:55 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2078.outbound.protection.outlook.com [40.107.14.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28131997
        for <linux-bluetooth@vger.kernel.org>; Fri,  8 Sep 2023 02:16:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eeR3xqDb+PSk688RiPi89mUQVt/Qk3XxmxGH2xOvwX+t2uH++5UeBlPDoIJ/yQnWyyNFIIKNYr9fzEBvVaLbIHjmlRPSILwCC4jmEUjNuOhLIcsCVL/qf/Vh4p0lFcO+/156QXO+RG35nDZ0afBqkpr5hjE1oU1qz2mmTsvCFHMKj0QNw3VZKVe6q0WRWzpatdlDA6ld5NoYYc63eJzZ6uF/xSuKOwXgS1dFleOope1b5i2tlmehiAkkhW99TXv8WSXxDXdKrI5vK8kYQO4suURPj35b4pTnhLwLkt/C73COjJtCo/igBEC1hrdNDwBxKD66P4Yga1VhmzWNsSdrNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=dTD3Q2eMNElP6jtdf62hHBDpdZf9zP+d0Uv3PWjPxsapaea5trzFCgNNDhVuDyvy3Li/AhpUhVcS39hRlhT8di4SX+OIVakg+vS0Eu1WlnD0G/1PtxsINEnMb/E6vrL4oD45xvlF6bkJf4s5gbhT+B8rzKu8RUnBcDvnEWvBrTeay19OLKDRcBhssVJTP6rKWVMcPoXMr6Hr6gmSHP5AkieojdSHdICZZEY5VOtugOl/NFwgj0cMIhtIOPpHK0C7FNlC41/hr4Xhb+cS0nUpYm5AIxNm5jVGRVImAZ0oe/a+eDLpww9K8uptYUvynE/370pyp8pkmesJKw3WnAZlbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F/Cchi6Qpmfn46OO77oAu2s05v9yJPH0eJKrJ/2DDIk=;
 b=aVWDQNCOwQLzieH/e9M0EqcgiXlr01DwKDUtjs243gYO0zETja9ap63G0PMCBaZsAJnOfcm1RLnDWFtLGpyrfI7vl1D9Q8DWB66rFBzKWCNARmoU/qDbiV/MVYlo1AzWMVZZnSohExbZnfbYbMlit4ctPn480hdhh2nEapjZU+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by VE1PR04MB7327.eurprd04.prod.outlook.com (2603:10a6:800:1ac::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Fri, 8 Sep
 2023 09:16:49 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Fri, 8 Sep 2023
 09:16:49 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH 0/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Fri,  8 Sep 2023 12:16:23 +0300
Message-Id: <20230908091624.20040-3-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908091624.20040-1-vlad.pruteanu@nxp.com>
References: <20230908091624.20040-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P189CA0040.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::9) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|VE1PR04MB7327:EE_
X-MS-Office365-Filtering-Correlation-Id: b70834d6-8849-4207-d71c-08dbb04c5513
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXvd4cvFKJGRChpc7++QEZsuIF0sAvb2nF1Rc7pR1S9nqWxb+YZANK1GcTmmWfEEznoQhLMGadV/qoeQO9WAEEZgqCW9cKX5IF9hOJc37214LC5Kt4HQk0H3fB1SV0xsm+u/D+V6eKGy/tsBCauUDavEdZpaF3PlpaQgtEnA/t1GsdZegpP7zc7jEsG0fWigCaDckYRQtK7WGU6tzdRnuCSL9iSogGKdalR3fl9COis8W7nM9u0Ip07tKRxB9Cm0NxP0yv5jIMBajMUqV8iQw0AA9o4uSpDlZB3KufNvKbJQY4xMehqxrrkZixIdZ9Zef8vke3K3Nr/EWjmm5h1C6EeH7kSLKYLrhUln/gsY/+GqjTkX+TZwnnatfOo1jHXx/ryycXWPggXiy7IrjcRLl3xnrZXGReeB1E60cDG3OwvgGqxrxPnlN6s8c7eGIUP3UwfZ3TkW0gL2S9M6gGk/fiRPQpuzs0TtyArx+lH2WV6nG/71rpkg1bIBVVVF1cV3gEYz4uf2JiJq6oSLn4j+rEiCsT28c7ZG2wjCPF7cNu0m2SFdoWyBPdGrmLDaGOIHXBO1fBGx11xgoOpjnme/ohn4i8wf6wFYqu1x401HQSTvr2lqa+HMCQ8dBouGTIck
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(396003)(136003)(366004)(451199024)(1800799009)(186009)(1076003)(66476007)(66946007)(6916009)(316002)(66556008)(2906002)(4326008)(8936002)(44832011)(5660300002)(6666004)(83380400001)(8676002)(6506007)(52116002)(26005)(6486002)(41300700001)(6512007)(4744005)(478600001)(38350700002)(86362001)(2616005)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oPTs59+djZvCb3kSDzVOhbaHdjM0XsJt+oCfMB9Jxj7xe0SWw8NFI+Y26mWR?=
 =?us-ascii?Q?rWBnBh0CkaKupvUeuTvDRyuKbkzOBELppQegNrHWHCc9ChC9Uq0xcTLCmYHW?=
 =?us-ascii?Q?5+YQJKpYSi1deoPtkeU48KrNtDEkvGK8AjMBIfvgRFhG8bdPUyVjnRvt9pR7?=
 =?us-ascii?Q?CQ0NQfLZ1mhozDId8F7q2k/uN56zzObmXWWQg7O59ncfTrLeDvNFqyz/fElG?=
 =?us-ascii?Q?e8xUqctbtc0r41siGRmhgfpMugi009gn/F2yQqTopK7Rc5aTU32WYBjbai8r?=
 =?us-ascii?Q?oYkc0sncd8aNkRO+Z43UqjF3FwU+JLKTLH8nf0xHLIjH/AbXyrsuZlQ9TM1W?=
 =?us-ascii?Q?5DyjMltrH8Wkq5WSObVdhbfuRIcL8/dnXYJu5NBCPrWdpXUWsBFvdCsTE2wR?=
 =?us-ascii?Q?EKASmQJjR9uvwcUPaY01Y8E3qFE8jX85qYGHXu4o0C2kxfMJ0iNK1+Z4yZZ8?=
 =?us-ascii?Q?3b/zwO/4ipcet3Db86osymQGRKcA86XdSnwZ3yCibnqT64PBPREGSWnUL71u?=
 =?us-ascii?Q?Nb2FmDfl/plqByXuZpK7zW6K+IpKoizoXSXdYVh7lDkeQxhyJOX1yuPvn9bJ?=
 =?us-ascii?Q?cuFyT714ZwVl2JEGrQyGIF7iOXbLzG4dCvVXOsdX8koClCsNo1mwM3kM8FZK?=
 =?us-ascii?Q?75Q8Xrke6bL7el7qYptfinkz27cgxfX4D//HiTtglctNVKat0ymW6Wu3Io3A?=
 =?us-ascii?Q?xxjG0CNQTMXQA2oLgC8sonzGaT86DebJXuqGXf/8aYQyxnUJRZUNoyslcpst?=
 =?us-ascii?Q?hrc128tgwApCaTovqHCODJiNVMuQ3rEXwaaY68VmtXP71AJ4hr519dEyU0cw?=
 =?us-ascii?Q?QfKE8a+lJ1sDnSPWCU2JO2mYJqbbsUqANEXR8OGRfMnKyeaUdmEmMpgX4NZ9?=
 =?us-ascii?Q?SCcOFq+CBbyvNUPUZsYZvSlPWQBG7EgcBkrNbhrTkakhGXHzaYVeMAcjQIPL?=
 =?us-ascii?Q?e+fDaiEhweUVQwQKS2gARWWeehm20otZbjJL0hxuebgPDN/7xPIa/+jjoVcG?=
 =?us-ascii?Q?mNRBFDcbGIZyrPjK+cRERqa6da/YKUqg7yuvpu03LeemjWK7d7K3OraGK+Qf?=
 =?us-ascii?Q?z+zZ7aoOF0vMb404s+zbHjxIVbgYPDzx/nkX1kXBJZ4q3/dCieVYM65ORXve?=
 =?us-ascii?Q?nYxkoNSpdF7pdVTwzykfVTLjOP0y3/8yCZWJCcTh6qxslkuNrrU96m4ldbZ4?=
 =?us-ascii?Q?b1kFhr5c8drNA//61TsLDHViL56ZVFdctxU9IUp/s9D7gfqXDn/YxYiWvT7k?=
 =?us-ascii?Q?ePR27tLtQJ9PEx3FjhzbIHkYEjsCgwDbZ3zoQT753OvbtahXbtPWiFtefWSp?=
 =?us-ascii?Q?jUHhk7pCuGcGG3PQCullIgyRHLEF7StVSqSo+x874Pk9j3ZCSB27qIclUGfq?=
 =?us-ascii?Q?iOVYv6V3e/mSFi/AG7jrGQU4eaQV21BaNk4W7TW3XWU0rB7us1FcqKm0B1Zn?=
 =?us-ascii?Q?AoJ4DvOBViTSsvu3FDij7WmRWYK1NN4A+c1Pd+Sft4wx/HBOrhEcSK3ia9cI?=
 =?us-ascii?Q?PuBDNHeUoumz79nV1gN//fEPe/cOLpmvCDyLYm8KpBRLcG7BfweUKa+C5fSO?=
 =?us-ascii?Q?FsGfOZu0kuWbw2fyaklloCpQseTEQp18irrQjeqsKdtKiQQolDj8SoRBelfH?=
 =?us-ascii?Q?jw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b70834d6-8849-4207-d71c-08dbb04c5513
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2023 09:16:49.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcmdNXv+EliKeF3lrWoqxr+7PWM1C4qCnDAFEjLPYB/4d9WYxi+/LVKBRr173JP2R5mixzVQWd2CsxUNSdRexQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7327
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

