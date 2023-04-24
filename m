Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05C39C77B61
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Apr 2023 15:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbjDXPZ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Apr 2023 11:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjDXPZ0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Apr 2023 11:25:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2074.outbound.protection.outlook.com [40.107.7.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75BB19D
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Apr 2023 08:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0yX9JiK9GBEwq+iPe6hezNQTt8YLEVbSHtDY7cfOTJ9/IeZK4iP0T61OM6nZiP2qwsGh0h9IkN9iz6t76/ZsMh+I5e4WX9xE4GPUBIg/Ba+lhTpTbuHxScl/Gs2vDUy9oDMZKOICFih95Sm5in+KPaW3IM/pB/rBPlm2MNiW48PpyFXHjR2uKDTQ8FVlU5QVKV7goFs9QuZUBEfT7SbB/1Cn0F9RJLRcUbUoopW85MLVvL9Z2aZFuGqFfdbQxbQ+KLjxCqCTlaiEmAPAOh2ryxUESMw6cZ/32GqIav0eueacsrGO2UxjX/vE+hfvd9D1YQ/TASgdw0bs3tzKHTiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UWLz/POK1u4bY6s439QZU7KLF0opKnlNdO3rRjxCmXc=;
 b=hbKvuesnZIBtOZdyF0j3qdbyWh0qtTdkywOBff/GTfdr81CmJt143LeEXnvVkBvDqCpGXIoIa8DhY1u8uTwS3w0jLBJwy073ARJZ7Kfkz0h4x6DegkIqiSmDm882pqBmDW6kUMJ/kt5vOpyH2PPt6RzHyUndQ2Ts0dWdj78+g+1HEVHXQT9MP4YcsKuCSojvQWrQv+DvkkyBdVnE/R5B15FTciytNx7Mady7moKubH8KWeA+jeTDzAFtnCG0ITYw4jZ1rzGe+W6h84tKyqUE3vDkEHVMlC1aVucL+kli8b6PXl8kYE9NLh1F/LdgERnEvN456+27vMFS5MDoCLaiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWLz/POK1u4bY6s439QZU7KLF0opKnlNdO3rRjxCmXc=;
 b=DhekM15DvzhrEz9mP7hAvWJYXRCq4Wr/HAO9WryyTL7Q2j9waYRX74P1Vlfk+wQI+MNfhjYxfoU+v/QdJXXid+k9DXU0B5AqWOVJikmNTuput33aLi8uXGaVUILWfQe+KQF7UYZwhdnhiTRukiYEgezuIHtKepxC1DTd4QGiSPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by PAXPR04MB9572.eurprd04.prod.outlook.com (2603:10a6:102:24f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Mon, 24 Apr
 2023 15:25:19 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::afb8:bb33:948f:d1e1%8]) with mapi id 15.20.6319.033; Mon, 24 Apr 2023
 15:25:19 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/2] Add initial code for handling BASS
Date:   Mon, 24 Apr 2023 18:24:55 +0300
Message-Id: <20230424152457.28000-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM9P192CA0002.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::7) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|PAXPR04MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: f4b024cd-20bf-40d0-3e34-08db44d81ca2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hv/oJpO/ZCz+bmtY+bUs88+D5UmnjjRTYeUAJQgZMOCoVo3r5tzi+R59DYv0uovYYZ8qxcmmKsolJAzpQhtK3tDmUZ4b/l4A6MWW5X6HXyBp3vgEgKFekuN712o56WEiYuaQKaF97Sww65wnrbp2u1nMnnSVmlBhJXqtGVPKMwu+hhOQga3j02KuB39BriN9BOPnXavtVm5vO6bYvYQVtmaioqvEiIOtZy+z1NWfaJ3iHW3Nzg5SGzB6Cu2ZSDSHmFd59f240p1UBP1vMitwrOHNgcWVoE8lwQs6h5QIyholsw6kVRhPgECHE0Uzdqzwq/i5kcyO/ZlzzLP1QGgFR6KEbCZ8Tk2QoXVHX4B/XnO3/CKj1GSRc62o2xTgjVeGf284l5nMpUXSActa8h3H++UijYTo52rm0qI/ET+RK23QPZEodArYwOLRK2+MCwGjnt0l6gCcZxNZva9MKiaGNzIhvK/q/c/UjKES5GnFzWga8hCNeT6f4EFrHAtPhZm6GQnet8hLKgbQIA4NRq3EhhogjbOWjOZVgCuRbo7lh/cV0N9kueou6WkLqb6LBc5TjDpKlPgSy8gLiE8vbF5jFEl/QGTwKjcxhL6lmP4SC1NGpeyOUM+rOfKq/KGBt9HbSKeDkrbS9+ydSUGpd9Vq/duBAemnmaPGDAYdU6lqjuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(52116002)(186003)(6506007)(26005)(6512007)(55236004)(1076003)(6486002)(6666004)(4744005)(38100700002)(66946007)(5660300002)(2616005)(66556008)(41300700001)(6916009)(4326008)(8676002)(8936002)(66476007)(38350700002)(478600001)(2906002)(44832011)(316002)(86362001)(83380400001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lwsjplu2rqhcRafgwJdmVYkNNlmLVXgSIOhE1Vo+GARviin4mKYW0VitPE6O?=
 =?us-ascii?Q?2VBYAHhjJCE/DX0JaCYWuJSXkVxUJS7p/tvP2aB3DSvaU4ZHCZifxH0WbWb2?=
 =?us-ascii?Q?0yi/cqmFE+Pkdew7QdTk1uUAYkdNePLJDrWjFHJ5b9soWlGFORI3hmW+IYGG?=
 =?us-ascii?Q?oJ1mjiiCCSPx4fUsfqCHoRo5Rr7pgWbmPwXkudd5BchWbyrBsh5gSdgMHqSj?=
 =?us-ascii?Q?PpcDWCAh2PZlKr5zcFWx0rySBvGQLDONMSk8EWq+5wH1xg9yadUuD/9rb0qQ?=
 =?us-ascii?Q?Q1HSAhJVTcwaNCdgiL+boooplty1q0E6Qoiy4hJFA7SjmjyCqjr5RxVUfdxE?=
 =?us-ascii?Q?eOob6tWN0MwPKm/uLJ+3vcO8944Nn1XMU4aX5ilIEAzFpCMpgYylqG+0cZga?=
 =?us-ascii?Q?VqIx4Pt9u5EP12TdY0MuNJkCYKdTcOBrErWrdZMuIk+fpgmCAcUYOIjf6aIt?=
 =?us-ascii?Q?axxXHa718dhd6pEuj4AapIMK2fSu4/rCaff2C6KO5mxmB4zsProSQxRv3slY?=
 =?us-ascii?Q?SBWzuxoB5TiGCetJvbh7/9hIFv99frVoRzdaf7WXBqSqXxrHZRHEsNqwBZ8E?=
 =?us-ascii?Q?RBPnLv5FyzMh5aNKhOveqIoj57HeXAuwoj9aYCrzf97Z0gyxpCQs9ISB6XWK?=
 =?us-ascii?Q?W0uLDp7ohuOS5+2NiIu11gBBjqs2Me36vTTSgZsE3+mXdra2r6drbM7W8Kjo?=
 =?us-ascii?Q?s2pb4IAv+qEQ6QSgM6R4+0sOAHeed+xng/AhoFPAWX3phErga0L9m/9uVPv8?=
 =?us-ascii?Q?Py2TU/Snwio2UWakJ42/vuPXCm+D4kuJs+LTGeyh5iMZpbw3eAyZ0V75Zi/E?=
 =?us-ascii?Q?4fDC9Q9aGwtoZqZxuPKZPq+31vebq3GtOD5o87iuzis0TgbZA1XLpvRxqgtL?=
 =?us-ascii?Q?CFZNzHtW7w2QU14bRteDFV7bz5Gv9wk0ymzm4nd00LxjLcmr8O5Jzb4LaHRR?=
 =?us-ascii?Q?G2CV+i5fkc4gqRVaAOMMgZUHfmwkn5yZJB40jcZTc8cKzviHepKl8Nvz61kf?=
 =?us-ascii?Q?D+gJ5eSnFXLWaNOy4GTD9zIU75oi0RcoMhoLCkLrsSEUKXNvnZVHztwaAZWq?=
 =?us-ascii?Q?7xTHyRzYcriLSKZOcv7cgiF7jZHw38iWqOG5fGWZA+EVPGZ9S/+4OOamJb6q?=
 =?us-ascii?Q?iuSR74DtdL2He75n9BggapIUjokvXybp6vJEYtZtjoM30eHMUKx63w8jgOFR?=
 =?us-ascii?Q?8yesJI8BSXi8pfGR6EehMVgRgymVXJ8b94CeUAgryNOh8msOD00YwTCEjFAq?=
 =?us-ascii?Q?5L+5zWTr0bL98nMFAp787O/ZG8rxH9KEZFYx5GjvMxPaUbae8HqoUlbzQf8H?=
 =?us-ascii?Q?vf4yEhs9jvl35fKZIMEdOtw4r7b3pi1dsT5mZUErFo5G9AypOIlfjyMl2Rfu?=
 =?us-ascii?Q?ILFfWWu80/s10BVm2eHu/R/9UDE7on9lUV8QzrqUtVLIkr4+wPp6iG9wOdNn?=
 =?us-ascii?Q?sgNFpJdW5d3/YA+qlJXXsRysT/M79HuTu1WRSOlKaXQ8DqPMuYtsU5ROBiy6?=
 =?us-ascii?Q?MRyrG/Xgikpm3TXCjxwDxM4o4YDs1uF2J9flgLNk0ucJ0DJUbhulIuZLpjDl?=
 =?us-ascii?Q?2qROo0jwvwExuLEv2icQ7bZaEFHBFw05iwgvlvUIw3yEkvh7r5+iGshk/Rhr?=
 =?us-ascii?Q?cg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4b024cd-20bf-40d0-3e34-08db44d81ca2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 15:25:18.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DUlwZ/3lM67wVMG1kYd0eSvla3Q6gMYKNMqhEnrwpfn9POJpx1vSNGGogQUwuPi9r9z9abpNC5EYZKvTbFRVzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9572
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch series adds initial code for handling Broadcast Audio Scan Service.

Iulia Tanasescu (2):
  lib/uuid: Add BASS UUIDs
  shared/bass: Add initial code for handling BASS

 Makefile.am            |   1 +
 lib/uuid.h             |   5 +
 src/shared/att-types.h |   4 +-
 src/shared/bap.c       |  57 +---
 src/shared/bap.h       |  51 +++
 src/shared/bass.c      | 703 +++++++++++++++++++++++++++++++++++++++++
 src/shared/bass.h      | 124 ++++++++
 7 files changed, 901 insertions(+), 44 deletions(-)
 create mode 100644 src/shared/bass.c
 create mode 100644 src/shared/bass.h


base-commit: d361604594048b1a4df370b969f9d5140c832d30
-- 
2.34.1

