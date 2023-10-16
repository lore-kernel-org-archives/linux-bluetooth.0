Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13588CDB482
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233738AbjJPPtM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232365AbjJPPtL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:49:11 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2044.outbound.protection.outlook.com [40.107.7.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C895B4
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:49:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWrlycm1UQWfDJ98dIn5oJt2ekyoQfREvE1Jywix/OoQbDwXETuXq/M94S2OyCd5RfxbQ7/iu2gJ+mbUq42XcnLt7bGy/Y6ZOa9SvK7zG/ii50a+hwpcCRnrvxDeaQVrFoqpVjY2msQ0tDonCnKCDeEdkNNTBB7V5NOH8Gj5VXo5j+hb/y9LKJcPF6amnIe29ICunjpkHhnMIkdvy+vdXKKoljYgAvQIPuHmY0E6HJZMWhMN6l1LZ5laCkhah/eoLV7LAy+ZRDmZyUtAS6jTOyy39eW1aDOLkIYDOh3J63a6cmnhQfYD4PRQAWLxLihyrCiovjVz5+Q/IRuB3t0E9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KvpuIe5aJ9RVF9G0DwbGSJ2TlVIbdHtoiLU3aVlwy8g=;
 b=lv/efXvSysCJdq6cdmRxzsI4/LDpnJl5R2Ku2cDihPbxmGN39qZp4sqohb+Rxh7a5PnX5TBJBC1DMeF+Z3twsrtBNjChjnYq0o+Y3pdIrxmI2yjl3qPZ6fVpKNKSo7+vzfwEti6KEgSX9l+SVRArwgN5CvjBhN2qJNijm8HqWxQ4wqGKGPuwGkWCMlhoRXjklUkj3f58pfSFsqg41wqGZERzVLXsv1qBhclftyTktVUo7qdkFzd5b5aFaU/sclQA7PRq+19sfsfCxw557ZciH46H0vaQNois6vvXpdenG/vF297VsYnnC90N5CY6eh6guSo3c+sbQ68KoTSRDZ02Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KvpuIe5aJ9RVF9G0DwbGSJ2TlVIbdHtoiLU3aVlwy8g=;
 b=m692f8BzobK2v1i3QZCdUw1MPWrxDuP2ccsCvEtXFSFWtu9E6orpRqga6AI9mmS9bKZFpoK76u6qmDVF8BDP24VG2+HQsQK+87lY4/HhWcRzU3QxkuI3BKz02Qxj2GpyI9kO4UAPcIFCHXJ+Cv0BPppQAAeoFkPBFxgbB3fws/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:49:06 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:49:06 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/4] Add Modify Source initial implementation
Date:   Mon, 16 Oct 2023 18:48:56 +0300
Message-Id: <20231016154900.3094-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0105.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::46) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1abc51-f583-4b05-e8c5-08dbce5f6db1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nKuTgsStp4jOV3k0KNoTSRDusrLaVno1o4wpKVMNyaiKXLKDSf8zKk+n/Qlor0ud+nzyCbMv3b7u0EnGwWKNb7qh+PgE3JDQyqIS+pCQBpVO3vYElJXYCEdxvUENl7/Sd204hcCZ8rQVq0okq2hmBJfWxOdJ3SPbc/5Bu1ywCbU82blN1oNrYe2kIQDN+SNIbm1RWwjmUh94RLWSH/BIC3TckYe92d44VNDH+sHpmv6BEysWhMnMsMjJa3Do1TI7vYBJy7ogGZWcHiBZZ9OUBzIs91OKGJSkieou5jUhnLzrvOAZwlgWtcrDnGi9973kdy3gUKKISWCv7N32j8vB3LtKewJ2AvEK0i9X9/4f0ecwn2lAshS8z+FTTl5SNrS7+2U1w8KMpjFplA+hsb7SzYZWwqxPIB5G27AkJ2WZ1hXKuTNIWy37dq0VdNUyoCmCBk143aEFOv6dqp0SuAWM4EMr3bI1wSg5g8NqQna2yboYb/shUS//tMsrXpYrUUtPbQpmAjvBRh+mQvdDQG+v0UVBDlSWoCqprYRmWKo0neACrWctsKqsTBBQbuCONCWl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(4744005)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I9blhaTVKRSPO4Chzp7k0VJtfllaC/Pw+U+AKpZ6GTvXCqGIwTBxFO5sBVwu?=
 =?us-ascii?Q?vAyUyUI1aAAyxSXWPQcRXMkc7YXif5puNpR83fuEyfhJsMtSQDYH+IdEzCxk?=
 =?us-ascii?Q?X9h/JNjLIvA7ap9AnEMd3j7xLnt8wVo3GhBVrejc62doQYL0LsaSq0xCjQcr?=
 =?us-ascii?Q?UIQyeNzDy7yowpt4/VMkmZWfLs8E9tKWB9pVw/5Ft1KmQ6Z2jNmW62xpl4HF?=
 =?us-ascii?Q?Bep3wVKbDXLhrDsur+r147RGHW1BYmuPIPAQov1LwXXPNX3g0yOcPdhHjEtM?=
 =?us-ascii?Q?cPIkQ4g+6y1dd1jx0LAqSselQ4qbPR/M9nEI1vF+Y1Gnza/XASfsnyJL0NSS?=
 =?us-ascii?Q?sGBeOBWb041XncDLx8h47HusxM+s/BcDqJPJnc/t/azLcphdmVHcU6Rgq6IR?=
 =?us-ascii?Q?QyBio0sGMsXP4w6w96xJUjIrs3X/6wWh/vbBJPIbHPmBvSihO+qxo6qDp470?=
 =?us-ascii?Q?QtKtbj02nMpWFUYRTvl/hOv+u7FOYrAjo56qzqf9gxyaJZL6Bz+Q2sAJ/vLn?=
 =?us-ascii?Q?HraM9srmZXkyUflHjCVowxIELXqy0LYKlY0h91AJS+6EDPzJXpNFB/RKgIMB?=
 =?us-ascii?Q?7YE1rkLIRbJh/9BKQCCBa9MyXPrDBKDXJ3GTfP+9d5AbUIur1g8SO4gwqUrx?=
 =?us-ascii?Q?QoKOGbq55djwrLuSFVUvnEvSjJgM9QuUtpAnFSuUtE0vVKKuZ5Ixb0WmG0Tt?=
 =?us-ascii?Q?1ujAtBwvtMemC6cCTrNWVFHytTp426MiOtfHpvyQMnBbIX8HH3+N1WmZdSR4?=
 =?us-ascii?Q?w442Mtgndqj7xbCx3v65LTtQBlZyF0V8qcj7R5BGiJ+AAiJtf0M/3e7VVVOb?=
 =?us-ascii?Q?HEJgQdCFVz/mebpPiclQhR8Fhl2mO1ZOt7DAp1uS+JNysyQZKCu4OJc08KWb?=
 =?us-ascii?Q?QORJMmhJMVqYfmNPpRIhRYtc/AapcMRp/SDdIRUtu7auydy5qz4SzHbiFoDW?=
 =?us-ascii?Q?LmYUFnDvjRmckPaY0kApS8OCQTWmgAHURMw0X+N4MU/Hhd55Y7rGE7DlkRnJ?=
 =?us-ascii?Q?zFy9vFE/d9wXZILB2oKCIv6fgHrLXhZYSEIzqTkzNcNutERT/SohkDa94qyt?=
 =?us-ascii?Q?JI8A9dzPln0sEReEsRhSWfeOpBE371V/8rYfl/yCEbRV9FFhMpzgtV2xZxMv?=
 =?us-ascii?Q?CJc9XFJLKQrCRnLAZOanhXkxQICxTcNTTqQcfgqIWtTqj3d8dwnYQspOAqGY?=
 =?us-ascii?Q?aJk72RKDuo1vOpSPsKym/zcBktkiMrybQw6DXdJlU6pG/iM/BLzmzMwtI7Jk?=
 =?us-ascii?Q?2XnEMzSfu7vmAcrJ/sblGHwJE6YHKwpofmzzrrbF6ORu5Bq9gV5+W2DwlQWM?=
 =?us-ascii?Q?DrC9mjO7fzYUvu4gO9ugIRJr4HenMk5cMfNcqWW9C986aqCLAkV8f3Fl/ztg?=
 =?us-ascii?Q?V+lhDAS0sWdPTiqVLP3roj2gcDV30mQmSRczHBtzZCBg8A6gI/ZXkzKEuj2e?=
 =?us-ascii?Q?5AYcx7ybRpBENbmHlsV2apTaEZTiwXZ3BldGZ1HhisWWR3AXf4X9sQK5IjtT?=
 =?us-ascii?Q?Mc5HPNK/6zaV+91yq5HuuS+ssorEky4EB7qF8xD48PXHPImVQsdLHxquzlDq?=
 =?us-ascii?Q?Fp2pyScMR0QFF4BH86CbhJ+33ABPvrDyJI2CVtmdSwN7ebqDHBFKklLig5MK?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1abc51-f583-4b05-e8c5-08dbce5f6db1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:49:06.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjU1Z9OzepzPxXfo1Xi+7Vu3urn1fBbNN0/02GaI4tSMrKCAv+w+qMDVtkV9iK3ZR3K1YJoZSfOkNMZcuJ1cOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch implements a BASS fix for adding watches for closed
channels, adds btio support for binding a PA sync channel to
a number of BISes and adds an initial implementation for the
BASS Modify Source procedure.

This patch series depends on the kernel support added by
Bluetooth: ISO: Allow binding a PA sync socket

Iulia Tanasescu (4):
  btio: Handle closed channel in server_cb
  shared/bass: Handle G_IO_HUP on io channels
  btio: Allow binding a bcast listener before accept
  shared/bass: Add Modify Source initial implementation

 btio/btio.c          |  54 ++++++-
 btio/btio.h          |   2 +-
 profiles/audio/bap.c |   2 +-
 src/shared/bass.c    | 333 ++++++++++++++++++++++++++++++++++++++++---
 src/shared/bass.h    |   4 +
 5 files changed, 371 insertions(+), 24 deletions(-)


base-commit: e347792f41a8ab2cf4f789b6544a4f8ec8464a53
-- 
2.39.2

