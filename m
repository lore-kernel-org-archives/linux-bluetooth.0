Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDCFCCA0EC9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjILGSp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjILGSo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:18:44 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2071.outbound.protection.outlook.com [40.107.20.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC3AAF
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:18:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhzgVVS/tRoUQNI2pfmm/tYBh2MdhmfwbPqGk2b4MoQhvRqPDtodo9Z+NiWPzAOyKgCQVHB90WNjw9BxEsP3OkgrSkfg5mdCZFT+R3qpHHBcBsk6D2H2bCRiRup7Tjqo4Va7GLpMVdf3Bea1PQWlyBfDngV5k5hGS6ZwWdZHjqOyQKrUWkl1ltJlgdBdGaM8CSZB5rHSLP9UOxaOW6gCj7KYtzl93V91jHiMYRKjQdzuIRdrieF6BSTYTeuCVI6Y0JoexhccEj4HDsMkjOhf8jWFRgC6qK9ZoUUClRtNtEfSqKQDKaD0Rf5F+OVFLWIZb0yvlviMadIBUNbvYwZu7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aB/iWmy/aow7f7F3boKOSJ2dg5pO0zRy1z3W5ylHRQg=;
 b=DzWgWupEF1HmltULwwiWdUNTE7YUpPP2MaeP8DdjkOeOwRzmZ4NDqtMRjydts7JwAkr501ofDbvZ46nF5jrgeNxDz9s1Sc8pWmIaG4BonRONlVNW1fCRRzGs6e71HirmNkgh5Pb8ANLHugJD+2G6l2KTMwSJ9Q5//zdqVt57W2iu4WpnJ0WJFq8IbFediOkzFF4UmcY4p5EzgXy+/J7id1Ri0xI+vIJlt0u2r3e9wIkKSBKgYzTlXRJFL4H1+UgutEwCdBhV+po7YMM2SjOewDAAvbU4cWoCRMlimVacrGGfi7d2ITgdC99t67kgg7vo4AqqXb3KmsYN7roiE4/O0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aB/iWmy/aow7f7F3boKOSJ2dg5pO0zRy1z3W5ylHRQg=;
 b=V24ecFTmOObfT6U89DhiydqoEpAnAuMZxPFpeMAH2fl2uVj5VRFqiNaVHkvITqxS6v8Lma7W3UQlF89hLCV9RKJy+dTdgD4h08vDmv3penAX4hOtxfgwkVmPfOzzUKSOIPkXOqN3Y0UIBl5GGbOfaV9M/xLk6RDybZeGur+t+rs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.31; Tue, 12 Sep
 2023 06:18:38 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:18:38 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v3 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS
Date:   Tue, 12 Sep 2023 09:17:35 +0300
Message-Id: <20230912061736.1181699-1-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0032.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::6) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AM0PR04MB7092:EE_
X-MS-Office365-Filtering-Correlation-Id: 22c6ddf2-52ee-4090-b9cb-08dbb3581a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w0jf5LmKauxSaRTHtP9oEj9l34zE01CJOhqC2rSPCqnzmFQYJjjRyta3KWh38Pjc1RdkMMAkP/IEBLxlCDq9ctO9/nP01fIoWAvO3iFNB53MuXUmnC33L75lymxjbl1dxrTkHXrUd2D3kYGN5snbCg27k9cDfZByPlGFr5AAKYGy8DrJBE8rwNypC/6/HEqDgUl7cNjNAiVYRKW7KntYqhfpFOpOT+xVLGLNsQre1IwSP5aLud3rTRbOsHRleWdUuiBvB5iRdvBPBcia+kMY3Sd2ebug0GcnPKPmIralcKxa1LDHaaYTrdFkAChCaJnnq237zEd/GVjbjBGRnG5CTGx+A3CXznuqp9+GxP0tmeStEYADcGnEIKhoUkbK31u43F9A5vA7ppgJftQGtFYT8JEEYoQGIwCi5AIlImZ5U/YzuLbvb54WzVJ0JWQ0rsxm+CosW/RJLXX/mGS1xJH59DuVxJK11tWZ7lPB0nMF9wNEhoV1sxJSE2SqWoqL5P+gAEu1z6GabJ0zPIGMehV7P0x7t+5+jXI/K5PG3IpPY6475F2rLwPg3lzsoxN/Lw+52XghfD7EQt0IbkiVkJ1XCxEFaarxDtQVgB8x5pubTdCsOd+4YLsCeDbirXHtH1WC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(136003)(376002)(1800799009)(186009)(451199024)(6916009)(66556008)(66946007)(6512007)(66476007)(316002)(4326008)(8676002)(8936002)(41300700001)(36756003)(1076003)(478600001)(2616005)(38100700002)(26005)(6506007)(6486002)(52116002)(38350700002)(6666004)(4744005)(83380400001)(2906002)(86362001)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DycRe4PechnS5XpKBgWu7XiAEZvS+NHcmECfeHeS/dH2Lt1B2Ja/9e3nXRRn?=
 =?us-ascii?Q?vkAqC8XhKziGaEKru31QLm/APrH1zjejvvxU1rlR3wAfDvfrqT8tJriZuUjh?=
 =?us-ascii?Q?VSzCkxr1tN2VY6En0JON3BshcYMEumHg9zkyBS8Ns8RMDBIUcXUgge1BYzqN?=
 =?us-ascii?Q?YKnh3t0B8urLAis3wfvXNXm91IfAuzuRMzKEvTjfkLLIekkjXc7TwhK89Ipd?=
 =?us-ascii?Q?qU/yzNPR29xISGNIK4C7g/zUW05Qne7fU+ggDpVou1ztO3rG3rPgLGcaCToy?=
 =?us-ascii?Q?LOylHMXS2p72vDvCPL/U/yL8pAdwm1Os+22ItmicusF8brzyOsCB94Gq7zq1?=
 =?us-ascii?Q?AwQPhXYjwbz7xVBtq9V8o5K8NwaH/tBAoOkGyHRalejEAXuip8xZ9Agugmaz?=
 =?us-ascii?Q?UcPjGLUX25dc/h2aEUX7loMDVc1TaTsXWoqEJ5JTR1/qO9lkU2fWz1m2hYyF?=
 =?us-ascii?Q?uG+iIoxiwVENXIg/a/QcsDhjMaWW6zbuez+rWFKqvr3Qt//8kcTX6HPigvDN?=
 =?us-ascii?Q?RmHSvxGoThLPCyjePMmCO/+3d/PsnPNDoXQL6jis8UlKFvI1Vv7Dp3ofM0xC?=
 =?us-ascii?Q?1vwlZjnRyn9xl5P8RRgiJIdgnXfWy7eexgRCqBoKBzNrtpzAXyFjl/TzQz4d?=
 =?us-ascii?Q?I3NiiiFyd9V9ASESRlbxflFgBrncPbBAiMkSBkWAEiAlUF8KtSaibQ0ktyH+?=
 =?us-ascii?Q?jMkvndlT3JTyj6oBtlUDJhzTTNNtKH7JqJ1+S4/GtQlLT9R8Fb7kOg8gr+5h?=
 =?us-ascii?Q?lTcAc8Rf277t2VrQFoSebdCSnG3Nqef53od2sR+zoYM7G6D74NPEGdx8UcGE?=
 =?us-ascii?Q?edNsiCCzx4etGLCy0XQCG68IhHR0YpyXu3THR9oh63Pq2YvprbDaLyVa82zW?=
 =?us-ascii?Q?MuJmxSi90SmLSBJFEms0TU3t4C537iExy72+IxfA9K5SSqqbfIwrtaJOJpOE?=
 =?us-ascii?Q?qPR3GrBsQGz9w/zTstaRV9QyX0VvsACCuKvu5wUcwt12LvIF7VOCjQcfXh27?=
 =?us-ascii?Q?8uYGC0s3LgAaFCSH/vW5qQ4Sz86kWYmxvkirSXCNrXQ9Kh63gzZ+vo0czKAa?=
 =?us-ascii?Q?U0nYF0uj9NdS8dIvSnHJWePAn6XQ9xExevSHhOrh3hthjWsBxnAorVbVpzZW?=
 =?us-ascii?Q?UQvBR+xK02FIBZNL1ig1za3P+Th7C/zp8QmJHTEzBnOAGDXCX7i+O2up8Mwz?=
 =?us-ascii?Q?0xkA44I0MGnt8JS3D4V4lE3FMm11iTKa4vmrGY8Lia3AiVGvqh++TlOhfom8?=
 =?us-ascii?Q?EE29z/OpSDVCq9PFJ2gtuvjO724D1pjy0DXFag55Gr65LOftRW9NyK2uWAyv?=
 =?us-ascii?Q?tIaw5VZGbdQCuTOKNiOfXfnN9eA24bHr6QmH7blompKTFsHwQFRxcxMWuSiz?=
 =?us-ascii?Q?O/s0it+H3mr8dXSTNXHDCgOsMMPKL+yogV9KQ2HdHd0wnEz0i19qpVThJCjV?=
 =?us-ascii?Q?LylWCdzIKKKSvVpSPBiVJr3iLPJQ96EXjlPl1Y9dagHi0156Trg+n5iSBCLQ?=
 =?us-ascii?Q?tQ9UAApfPcJUyE8nFtCxNzPx5+76/FmtUqzyBK9jNOHZvQS1NoCYRZqRMRpX?=
 =?us-ascii?Q?G/gHkF6qs3oPdPdyIaRd/kCCuYZIsk6R8OJWPxvSPNs3jowb/Zuf4aWCLAvU?=
 =?us-ascii?Q?ZA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22c6ddf2-52ee-4090-b9cb-08dbb3581a28
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:18:38.2265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T42QM34AGfk2G/j371GzUj6187G12w3g0GE1idTVL96IJ3lx8iQjxNV1m2lJoDSCAZ/C2wtvQTa7DCINgEX9cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

As mentioned in the Bluetooth Specification the full name of this bit is
"Connected Isochronous Stream (Host Support)", thus it should be set only
for CIS capable devices. Currently, it is set for any device that has CIS
or BIS support. In reality, devices that support BIS may not allow that 
bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.s

Vlad Pruteanu (1):
  Bluetooth: ISO: Set CIS bit only for devices with CIS support

 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

-- 
2.34.1

