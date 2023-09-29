Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D794E728C1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 15:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjI2Phn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 11:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2Phm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 11:37:42 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2041.outbound.protection.outlook.com [40.107.21.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75048B4
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 08:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkZaub3OBVtKp0oLXP1tTED5NCZstlfKq93OaKgLCk4R5OibjT+qsiAoPN0LSBaekjNK769QTRm2p5m1oEpgNISI26dpNbKvHggoU6zSExsGJuIHh3SSxydpMdO0nt4w4VTGm6csuUc/AoE1xPObVXM7N5bscY053ZevjGwJ7dd7fgidolckiuOsYosdWDkN6IGCugyC4hvE538AbcrRMfcLpD1RX7qbEdAgj58dIxS86MItgNM4VB9fuOsyXEo/MFYl4SxFwBREsBWjLD6/Ua32I5Ii+LQmRd/HjqjKEAX+1yT2xhIMbiBnjHC6JmmsoGyYQzSrzSj+MtVwbamLzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=17SPUyvtHlFN7eSR/SdGzcvd+XbJQcSrexU17oOEc+o=;
 b=CLCYTYJC3Q6walgxNTh7dVm18VGrtlfeGyL/0z8ArsEdSovyOElz/tKcSG2UWRVjX47yzbz/GjSz9zyG1EjxOY65x/yRGFMiNxdvT7J4o9RsnH8aQqb+ATKSAJC/mv96oKX8RRuYC5PArOJPfRmksHjS1e/o49IZf08DRQXeMPvj5xavcw68m7y3zN3zqgAvAb+0GkTPO09/TfVe2Wyf1Q9T9qTggBzHM0W80LaEioE2gydd6qik5SI3q1Hd9P4XaeIPgIiSzO3z1GbgetFxfy2rUAaAtESKHDNe9KOTzEPSbZLjmJmxHr1pNAa4C+iO/ZOmpsJNEF6SiQvYLjotJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=17SPUyvtHlFN7eSR/SdGzcvd+XbJQcSrexU17oOEc+o=;
 b=E36O5PLFKVG8Uh/HcfK5xJrg700Bf5RlvmRcLv8pReK2TiZtvJf4YDOC0pEchwoSI9lO0JwTmRuwV6aZpP539gj+ooqMLCS3VAmPbFANJDbVd1HqRStS71ZOQAW+SYcJ6v4NzIDtMQrkJa0vjzrZuITQNIVuANRRJkZFlQMqtdA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DU2PR04MB8661.eurprd04.prod.outlook.com (2603:10a6:10:2dc::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 15:37:38 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 15:37:38 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 1/1] Bluetooth: ISO: Match QoS adv handle with BIG handle
Date:   Fri, 29 Sep 2023 18:37:27 +0300
Message-Id: <20230929153727.3728-2-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230929153727.3728-1-iulia.tanasescu@nxp.com>
References: <20230929153727.3728-1-iulia.tanasescu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR09CA0186.eurprd09.prod.outlook.com
 (2603:10a6:800:120::40) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DU2PR04MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a615786-99ef-4c15-03d1-08dbc1020284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTADHG6ejZqwk/fNiVuAfSMcKM4LcvfkmarMTMKPOuLTzhfxmxskF9qCFGoRJJ05LSVaAHd2rEdzC4DRnUfHh1G4qQynesou+1xElqn6Ivt3F/F+QY7LECoSJY1nYkpaJW8n3SP9GUhjB6v8VR1xY1jyQQSudmfU8xJ/cVLs+PJ/jd2v1sguYS5EhS2WcRMAjC/GK31R0p3EdLthMuLmtyhMrXyabhUxb+iVNWkw1mBbxQOJQlaYAk6NlP95T0VCZCmOkeQBWjSGP38KGmjAmv+NSifRiiYcOUyMURfmGwc/O8Mk20VgZS6odQpmPtislxpedLeC28SBm6l3y/Tz5G63NuOOcjO03REWHh53qUemfZdNmdHo+qM0Wfy0KLaJqhq7f3z8E5w+uIeOdEu5y+fB/QMiID+xI4wHZhIgOZgi0NzAVT2ZYcI/jAB2TDsr6LYQqjUnmSoAnOQVRhO1vDL4h7r/Ckoq+6v2HKTZBZrE0yXoRRXo3NpTMkUUUb3XwNmKUHpMlfnZ1YXs0fF4r5WqYdJD9Qt9co0RdUEbWbdrkj96WPmFnhyK0xJINVsc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(136003)(39860400002)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(316002)(66556008)(66946007)(66476007)(6916009)(8676002)(4326008)(8936002)(1076003)(41300700001)(36756003)(26005)(2616005)(6486002)(478600001)(6506007)(6666004)(6512007)(86362001)(38100700002)(2906002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8w9ykzYEi8dcMrxOfWjdMOr2VjDeHCX2BvidonB7aLkuQIe1wxTwH09iQO8+?=
 =?us-ascii?Q?yZcuWYAF741oLJgYhMLTGybHRjr9s4oo1c992t8ITjKnfKRvDFt7tabMsmQW?=
 =?us-ascii?Q?8uZFm8oxRClGCPVBTPepxtsY4/H5sRzF2p08wL8zExVqJL5QnaY18JVeneIf?=
 =?us-ascii?Q?iMvRbOWiVzGy0XxIpoS3/Yig1BxC8gVkIaKMSme1z9he81DEnT6zCa6jjdih?=
 =?us-ascii?Q?P5RXtOp6HksCPZi6yY3DaA1NSfpsVp0dt0LEFFCBpa/m9qhFffk0a4YDs1Fj?=
 =?us-ascii?Q?HthxokwvO8FAaObESRypmpeZJBxrATCxnx8D+HAhj8XQsUw38hP3XHkfCWRe?=
 =?us-ascii?Q?esvyiP1vSwl2ycjAGC8v4lE84ixfa+Hd6E24TmqboW74L8ljFyfYqUy60mmt?=
 =?us-ascii?Q?govhDT2nyMllO0dFcmyzOMVOftSwGGNOcmPo7T2pohmIM9mAPecwmdVstI2Z?=
 =?us-ascii?Q?zpdSyLO1/bGE1V199Sx5ZeHxRvMjUlTnLHjMxR8FzsDEGnNDK/3hQO4nJjWg?=
 =?us-ascii?Q?RWnD+bnKCWk+9pIGQa9hWjaeijvfuOV9yYOyeuWTnGMTew0AcMAmSMKmWutX?=
 =?us-ascii?Q?EPNa8j1sQu4u/cz5jATuOzP0Y7/6xbm76ry3phZuNR/L94sWbziyR/71qIeF?=
 =?us-ascii?Q?5c73P6UQi9LGyyyAhI6vxr4SLMfXt2mNxENpA5kJrtMpGCPLyMlhABI28kDu?=
 =?us-ascii?Q?IDqWwt7+nd1q2xpb++JVJLSnjOTSMUUAfKh/6zhlZ3bZY0EtN2UVIJoptVxO?=
 =?us-ascii?Q?AqkZLxdvzj6BbdV7CCDfGRKK92DIz1ysWhcDGRJFjdXPDbRFLgyJW1cIvnzm?=
 =?us-ascii?Q?ctASDrMqmW/pHSyfcBf/NPzqpzyMvmRfNAHwoPQW4FzGP2uHVHXX1+P0qGdu?=
 =?us-ascii?Q?4fRNbHV73WCZ0/TqNYvqjuVXFM7z0A+oVEAgoirfHgPlvlFvyC5s3Q0xy8vE?=
 =?us-ascii?Q?TZiS0HXuyF/6FfGqlG8V9sMXtcV0O4lTdDkWKuiZSGZsmhSyZiTuqOSu4M9l?=
 =?us-ascii?Q?1DGvHHf/rxjXzeakZ6Y68OFk4jmtgtUihY1j+7DaDpGTgZ776+3rT7GO0Lgq?=
 =?us-ascii?Q?LEQeZo9XoJMphKGIEWqYZiy2cjTpGSrw1AZSwGsSsalGP2KyAdczIeT3Ira1?=
 =?us-ascii?Q?OIHw4CVRrgAOrx7gn5p7iVwdMBacUbiICKC1larqhUdUbidO9fbGbTtc7506?=
 =?us-ascii?Q?PFgkyMKq5R4WE/jKwkQM/mMGWnIogDQHoWzqI2h92m5stQHK+8uqmplKGCWb?=
 =?us-ascii?Q?/7duI0y3Khr0AHAcToSlk4LO04X2C+sNgl4GwR6I/YlnZjhgH10MoUmY2TLO?=
 =?us-ascii?Q?xb9Pqdscw1Y4v8xA2mBej7YRCKvebC+rl2vNwOumfLCl7LFNbdFlyS6BlkD9?=
 =?us-ascii?Q?Renqm/Y8/X31wzvqIma7v/FNgVguNfpzU8VL0TTnZqsXe68IBkkpO4L0RsMS?=
 =?us-ascii?Q?19/Xtn6YTTnlwO9IWl8fM2aB2QGuexd+B6tdW4AX1OFaofHhvhrt508c2ak4?=
 =?us-ascii?Q?5+8usaiX38vfC509ErQasu1orSMbXR23XmuZ//Zj0yhCIooyGw/qaDT3HQke?=
 =?us-ascii?Q?/1SAvu/VqwYwFHjAunpVUbnrbkhVrjKvhNX489rtzpOiI3jmnxuSQwjIYEuF?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a615786-99ef-4c15-03d1-08dbc1020284
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 15:37:38.0214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MHqHm+8Mty3D5GvGCIadnUm/Fhlk4sWQDjBuyfuUQkgyUT3E93dKHyi8J+9DO9uk0buEMcR27VNXnqb4dO8e5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8661
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In case the user binds multiple sockets for the same BIG, the BIG
handle should be matched with the associated adv handle, if it has
already been allocated previously.

Signed-off-by: Iulia Tanasescu <iulia.tanasescu@nxp.com>
---
 net/bluetooth/hci_conn.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e62a5f368a51..7890ec449a7b 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1494,6 +1494,18 @@ static int qos_set_bis(struct hci_dev *hdev, struct bt_iso_qos *qos)
 
 	/* Allocate BIS if not set */
 	if (qos->bcast.bis == BT_ISO_QOS_BIS_UNSET) {
+		if (qos->bcast.big != BT_ISO_QOS_BIG_UNSET) {
+			conn = hci_conn_hash_lookup_big(hdev, qos->bcast.big);
+
+			if (conn) {
+				/* If the BIG handle is already matched to an advertising
+				 * handle, do not allocate a new one.
+				 */
+				qos->bcast.bis = conn->iso_qos.bcast.bis;
+				return 0;
+			}
+		}
+
 		/* Find an unused adv set to advertise BIS, skip instance 0x00
 		 * since it is reserved as general purpose set.
 		 */
-- 
2.39.2

