Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5397ECA0ECA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Sep 2023 06:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjILGeL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Sep 2023 02:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjILGeK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Sep 2023 02:34:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2064.outbound.protection.outlook.com [40.107.20.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5540DAF
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Sep 2023 23:34:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLp2GN+wNKqwRxe6GB2pJeLtruFNmoJ7yn7rqixDo21JVegHoEWS57hJfmNSFOTnfsO7D0mXZtRPcspOtqrjtGi5PU9DOhS+rELwnGPO5LCisjhIxTn8wGM4cMi8TAOKDJw/nOd22GZ/op3kRthVrRbj3ApJ8ezGr8z/nJAtzqZILoimMfbkOPia4JcY3+nhX4kR6x2paF7+yQmzBuhNoZU5cXgiUeYrRp3dh5NB1sjXlNeZNL5vyDEaEsb9KGDtVEv83f910BhkiLtR5iIIHzNuSeSrshuiJgAhxYwy4sYdoF+Ov98imMQQolqcVOAalF+Tqo6vBTxZ4o5QT4ckcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=51gd6tb6gh0ly6kz0uCN/nV1sD+67IEEG1ULi2pBJ7g=;
 b=US0i/VtQIjJ27rUppfrXE+M+iYju6Z3k+OT0VDU8JD8ie+Z1VbNMspEOdJ9yXVb/k8Ky+NBpNVNE+dcGx8wSzwTV6jB2+dcZgB4MKGc8+r74qP8dgoJvZq/X6zz52/R0GwbEhXPiO9iKSG1ubixLMX3yhbi78B3hfMs2xP44ICwPVE02WjxM6/XPoLviAZ/7vS6JQT1kuF8enfaLFrzJx6NPgtgIzUZDg7CzKOryrwMykoMJp68EuhSMRf/FgUOK1SYf1nVQyymqqFlI5N8FqvYxO2O+Huz4TyVrAbuy6uTDVtPooJGewHmiiq2iBO54CLFf2lfWxWOmWFNTjGwUKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=51gd6tb6gh0ly6kz0uCN/nV1sD+67IEEG1ULi2pBJ7g=;
 b=pn82CZVXqdFAy9fY7w3pMlfTJdCJr1I6dNVFQJRei9c2Wp+gX5dtI0gxB14HMT/2htnMv6pW1D0lNhRgX2M0hI+A6vwFxXbdWbKBGBVYJGIqpe2XVVyj/r6v4mqHWJKKNCz1uep7FR6+atUwa5RVyRp04w+dyL3fcT6rqTCXc/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com (2603:10a6:102:2b4::19)
 by AS8PR04MB8359.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 06:34:04 +0000
Received: from PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636]) by PAXPR04MB9398.eurprd04.prod.outlook.com
 ([fe80::4131:3e13:f138:f636%4]) with mapi id 15.20.6745.034; Tue, 12 Sep 2023
 06:34:04 +0000
From:   Vlad Pruteanu <vlad.pruteanu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, iulia.tanasescu@nxp.com,
        andrei.istodorescu@nxp.com, Vlad Pruteanu <vlad.pruteanu@nxp.com>
Subject: [PATCH v4 1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
Date:   Tue, 12 Sep 2023 09:33:29 +0300
Message-Id: <20230912063329.1196184-2-vlad.pruteanu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230912063329.1196184-1-vlad.pruteanu@nxp.com>
References: <20230912063329.1196184-1-vlad.pruteanu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0151.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::18) To PAXPR04MB9398.eurprd04.prod.outlook.com
 (2603:10a6:102:2b4::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9398:EE_|AS8PR04MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: 03ef54ac-c447-43f0-d1b2-08dbb35a4202
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pEJaJSUEc/4TDNfdbedkJbL/l0tcC4rG2gmBc4hTipAnEtqJZqNOa9AlesvCnOMGJyrmz6qIHrkHTLJMCDkHSxmtEiUFukTHkc25Q9kCmuAWR/dZeIno1G4L8NPCto0SOEgRccpLHnno/soCa/Pcq5Lh7NhakvipoS2kzpKQ94EbRv5FifFz9MBwQvoTKCTM5H5wBUVr4ZKwvk8STVNkYW0u3OCbwS0pHb96tpmPhiDhkRcQy/GRIQ6rQtq41hxsuFLKAwUM7/nOnDbWhY+rO5V8k8hsT9SoXpl15bzFriOrmnHNLpQ7rPPzZ3kPY6sr5TznlpnDCHq8xuz+kxZaNxNrB3XTVwJhunY6foF6/t2m90HEFn2KjVuW9s93Nxp2oCoUd3eu7iWyB1Zl8YcbzSpU28oy0Eee0e63CmOBVnKwEnrY3+118FmYQgFjyRcS38XefgFoz9sCbetkeZPBHM/x60aPKBVddbSVgUUy6xTpnMx8alAeNGhwsW9gyJ5CWPwDnfLCsSLiiWJqQ7O2uZwFU2zlJBDNPeAluLVJ5nQ5U53EZ6oTN+t2xJEjSTYtnF8Rb/Pvm+sHKlNAkD6xaoSC/CkKtnHjfaEV3LWcbZoQjgMboWSfOF21bbdBdD5k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9398.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(136003)(376002)(346002)(186009)(451199024)(1800799009)(478600001)(83380400001)(2616005)(1076003)(26005)(6666004)(6512007)(52116002)(6506007)(6486002)(86362001)(2906002)(4744005)(8676002)(4326008)(44832011)(8936002)(5660300002)(316002)(66476007)(66556008)(6916009)(41300700001)(36756003)(38350700002)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCPaUskuUrYSJ6D8EAsr158l9DfuS/W312PEV7zgIbVqJ2fatr5aDC/9zUbl?=
 =?us-ascii?Q?5COXVYXhgxRctr5mAFO7Yi7QhZOQTnV9M0zt44Th65F7gaTNBwj50M5TE0kq?=
 =?us-ascii?Q?BCflffWu9tpTfEsCZvOrRYXedR4Xwc8UXofXbuW8rU5Qz3CvlrugBhOh32rz?=
 =?us-ascii?Q?XNcABMJ2Qu18sKqF8wk9JKNNcGxoYCSZerTL4lnvThjBxXcCwZG7dETQ2epW?=
 =?us-ascii?Q?orTqgqADq1rNvu8XPxYJNBFtaCtp41eASGl/UaZ4QdIY+U46NAxUaabsXgUK?=
 =?us-ascii?Q?BmrnUaRzj4EQoiwzx6xTSWg6hfr3lU72DwhfwFbeCimFYrbfZ+8aYb3R1S25?=
 =?us-ascii?Q?FOL81YVYcPVv1pshdUc1jSjjdLOR+pPznpCpUCbPf5NL5GOOgJBvxCL8X6Lh?=
 =?us-ascii?Q?90MKLFzSXXJ5aGGbsnmVpxH23sTmPCE3qZV10WkOVSp1vLcMwjaDUEjdu7B7?=
 =?us-ascii?Q?h5bdPWgO0CXp5zuOATPUv4poGQpyVhB8CO2sr2dwdeu2jd4lErG03Ffy+m8Q?=
 =?us-ascii?Q?3ISX/2PdjHtiS01GSTVfsBbZUCXtF3yjspwGUdkjkS36sgjQIq2jf09P1BNI?=
 =?us-ascii?Q?KdDaxZnygP3N0hdc8BIQj7BXci1nVJL1rT0oSBpx0fnfEPDRsWhlxxew74Py?=
 =?us-ascii?Q?9Scl4dTMTJq0TK/QdnOMhizK/lJ3afUl1r0UlIWVy9NCCjr331Szjbonf5AG?=
 =?us-ascii?Q?RP91nwtUoVwzcnQcGbgyxg8AIYgOBek5T33SL4Xe5h53nu6UsTqPYwvD73Zk?=
 =?us-ascii?Q?KC6WIRo+5Qz9N2rhi19U0zJlHbAM2JMbAdxU6lNcQZ4fmvKgL5SxCTAPP5n8?=
 =?us-ascii?Q?2pnEqclNw0ArJ4tfxLMwd2MMBjhcmOJvrB/4HAdYroGwJACRTmHJNfuUmSm7?=
 =?us-ascii?Q?W5GBKFy18Frea1EgDwgHflOSG/RB0YGd5BFbsvsKjjTMY4aoRwVTFV6b47Ga?=
 =?us-ascii?Q?DfHSh05rWfzyqiotJobmxa+4Sc4ICgt2N5C7a9GzBOHwLjHdGtQVEqkIh5OE?=
 =?us-ascii?Q?0rG/tVZ7H9l29CPYM8JKfS/TU/Y5IrJhCRpbD+2sQoS6dgalPnD2OYx7I7IH?=
 =?us-ascii?Q?47icuyUe0Ot9f5khgnoxTZfmz6qjv5INiWmqqKis0U5QKVMjcn87YIi31eKN?=
 =?us-ascii?Q?oxBesydnEszH+VHKWFqxomP+v2pHVez6JOKy7b6XRLqEcn5J5r/FLrlpd2oi?=
 =?us-ascii?Q?rhVcwNTHpUiq4hVaXftfSyDkCvWaz/Sj7xM3mqZiHfItJoXN7qmjFQv4rmHY?=
 =?us-ascii?Q?vuaKc+gQJG27uFZPOt18VptrVcT2e7RV4QCiEoJL1/qUJ9KBCgBLBjkYEFxg?=
 =?us-ascii?Q?214wfQcA+QmHaCP/nJPY6KC3lSJXzyC9fnY/gLVxMQ+MFH+xvP/QN8+mxlcQ?=
 =?us-ascii?Q?DE4Md4jTFAJSgbWi7gTnVYtm43/yRMIcwNjXVDfQbt96SEsVl5y+POuXPcyo?=
 =?us-ascii?Q?m6hry2nRLW+K3S0ZFVdG6IhDlH601AR89lj4yl9KDuZBO7A9koeXyyoJ1fxu?=
 =?us-ascii?Q?tg5TKvPiL1AOLmebJwK70BjpEPMLqoXF52mwGPaGqgs1wNZL0egyLqP3R3QE?=
 =?us-ascii?Q?tnYRL224+fDWcEZwb4mmicJ3uEaFwIySzH+WhzmeOJkzVjlBmPeP7Rw+3iD4?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ef54ac-c447-43f0-d1b2-08dbb35a4202
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9398.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 06:34:04.0909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZkHhHL2L8c9H9do+tnvFmDPIDBOOca9wSyhawUeU3rZFgLCmgYH9NHcaC6iEr365OXL4nQ7sZStt4DneJo5sMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8359
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Currently the CIS bit that can be set by the host is set for any device
that has CIS or BIS support. In reality, devices that support BIS may not
allow that bit to be set and so, the HCI bring up fails for them.

This commit fixes this by only setting the bit for CIS capable devices.

Signed-off-by: Vlad Pruteanu <vlad.pruteanu@nxp.com>
---
 net/bluetooth/hci_sync.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ec4dfc4c5749..1be5763c261c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -4264,12 +4264,12 @@ static int hci_le_set_host_feature_sync(struct hci_dev *hdev)
 {
 	struct hci_cp_le_set_host_feature cp;
 
-	if (!iso_capable(hdev))
+	if (!cis_capable(hdev))
 		return 0;
 
 	memset(&cp, 0, sizeof(cp));
 
-	/* Isochronous Channels (Host Support) */
+	/* Connected Isochronous Channels (Host Support) */
 	cp.bit_number = 32;
 	cp.bit_value = 1;
 
-- 
2.34.1

