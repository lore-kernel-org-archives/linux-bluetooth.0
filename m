Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26376C83F1E
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Aug 2023 18:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245651AbjH3Sxx (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244613AbjH3N3e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Aug 2023 09:29:34 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2071.outbound.protection.outlook.com [40.107.8.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26A5198
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Aug 2023 06:29:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVtaocUZcX/z0Ym6HJxMYE4ZfUlh7K5h9AVKrvdjjt0OaZqPNVEe2FrQDpznrtQF/2lS3wWHD9jle9ScFF65v11qAbx/slPd2RHpMJd3h0w4YORUWDFAQYTDab5JIzzfNyXf9nPWjJJYpPi8BigDN7Mim3AjDDPpqo9mkzQ+psC95NJQn52L6Y3Se1aVaHx4N5sp6tcjlfSUnS5KmTNzkUqm/dgwqIN8c7s4LbPqy6Vh7c6nwnITxVG6GwpZD4z29it/659X0dBgdCfuR2Z9p9XL24TcQx6e0tvfTZiDBmft5XvqN0dOCUxh97IduU6TKoQssLr3Xw4M+3BD25WVrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lwSsqfNZXJxZCHPdoI06VZcLf/1WudT/XbrH56zFXf0=;
 b=XZ17z14bIkumbHfXC4gUy5GfFmrn7PWmZB9/tpE6+CO0Mipg8P5radN6HoykXrBjU8WwUcPVJMxqLnmUQa3GUDCyZMZ4qCG4Gt/L9pXKVlnTtTQSNIeMWT/PeEmcbiH/aNwKyNcLlljL0m81xnkU1g9KoI6LOV30+naXpDVsi2fUEkjrgS5KVFrWVtplkRhW3DDWbBJTuuRpcEjXzMw4rybeCQtSn3awGu9ROEEoWZwQlS1hGFfkN+T3BAH4BapU1/F8EEK7JgbJdjqtzxRDmXULbJPsenxg/5XznPBkEI6XfpQDkFp24SvQ5L+/8k682q56PR5B8LS85geWsowroA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lwSsqfNZXJxZCHPdoI06VZcLf/1WudT/XbrH56zFXf0=;
 b=TxgA81Lzyg/H/SrXk0h2rWO9ajr34P2icG5ay1Ga3TgGRCjqT7fLuqasP3I3VynBRuJYywuoG9NGXhcr8I69FVuQ826zL1ZL6HGuoL+L7Rwfz4g4UhOqjmU6HZkkTUOecW8yMyJFVmwRsIaPuJmiJPUfu5nGE0HpqEIbXmj1lrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBAPR04MB7334.eurprd04.prod.outlook.com (2603:10a6:10:1aa::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.35; Wed, 30 Aug
 2023 13:29:29 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::6831:19af:f6c0:5512]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::6831:19af:f6c0:5512%3]) with mapi id 15.20.6745.020; Wed, 30 Aug 2023
 13:29:28 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, iulia.tanasescu@nxp.com
Subject: [PATCH 0/2] Set device non temp when synchronized with bcast source
Date:   Wed, 30 Aug 2023 16:29:13 +0300
Message-Id: <20230830132915.72153-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0102.eurprd03.prod.outlook.com
 (2603:10a6:208:69::43) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DBAPR04MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: e390e933-7c94-4484-c4de-08dba95d22c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewSyPhIavNNgC+fC3T3t/bdqWjhFi047dczghR9EJae28j3Pea39I7LUVnmda3S+XWCdlh/kVwmk9SXbzbSRgywogeEMDnPMaw7M3op6TC0qqmX0cOduGSewYn4dsqZMJW+Z4GrMF7YY9dlca8yixibQ0LtikthWa1LeqET6bCON9WttDZ5qmJ+n+b35+Ewtz/yaoO21+VD4Um/CnyKK99BRO9lQ9intCmOG8VG+Kjptz6fp6c8mvAXOhwm5OaG9FqxROA0WcHeVrUUHisCoIpSEVe5kDRX5rOAJcoBJCP+MVxL+DsfcSLk2XjXITsKYDw3oLveCEXH2OTN3O3oqFQ2XT7mLFPfzavOvPc/hhlS6C4ahngc0URurR5vPUSxrChWERMO6fB8a+Ixq9aLOXeDMcqgrMWSHQp2S2bL9inQ5RTrYYTjheuPk7OLbHq1OePt9E9C8MH1IDEkuVI9jNYDWX6jJWhkxTIX8ha6Mu1nFPZxEBudAXZkMd5I88cJ2Cxn+lVm2C02TCCbWvaOYErqF3lkMTT8awsKetq8mtPulVfP1e8ykXdbSgNFWZn7DtTjFCmSgC1EfR+yAGS5FFKekCk8PApkHfYgR034WSlE18b0/j9OksWxrVNzczHny
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(39860400002)(366004)(1800799009)(186009)(451199024)(8936002)(6666004)(52116002)(66946007)(478600001)(6506007)(66556008)(66476007)(6486002)(316002)(38100700002)(41300700001)(38350700002)(6512007)(5660300002)(8676002)(26005)(36756003)(1076003)(2906002)(83380400001)(2616005)(6916009)(86362001)(4744005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OEFVz9d8UPq6GtlF9Y9jBsQT7pjmtQw0JIs3Bev3YuZC4L2EDmV7bJDJm2Sq?=
 =?us-ascii?Q?7BNguM9fWenIfv6Ggpq2XhZGCRUIJHCrjcWjuORgr0YSquWVxMy/ju66Ctvr?=
 =?us-ascii?Q?n01lvSHrfbZVE2sja/0xAMeFXA0Xbw0GVfzQTGjV4aLm1HZHiauW3zUVUBvx?=
 =?us-ascii?Q?KWljbQUPuyWMFEeFBJOqJQ1dCptR3l78N+pZPDhBKZOkofF2pfal6rDfFcHP?=
 =?us-ascii?Q?e2AHun0qfBTL0OKIX6EW4q6OPqfTd8SkkayMJQPPdg1/gjL/KuAqhPRKaJ5S?=
 =?us-ascii?Q?UCDULxKpnA8tao6H5nd8Kwxqidlyp1Zkc6WJuF2EXUYzULdKPEMghTeB/gK1?=
 =?us-ascii?Q?BQjnaXMSfNFQ/qwHo+NmnBiPIJDXl1CPVpIs/x32NvEk1cnTBBSO9ym+8n0K?=
 =?us-ascii?Q?7dbIZqFpwfc8NGffdJyLZtTsZ99AnW8F8bKAjJv4ZoGH0pyzxIVzO2BH30ID?=
 =?us-ascii?Q?6Bllz+LC3sKfPMlgTs+cedVl7z+vACrUz/bz0TWZqonSFa0hf6wXLNFgQPUs?=
 =?us-ascii?Q?0dcZtZtPOD5ukpOqdxBEfxySRu40OFLZFLfavDlTMRnVX6ENbbv2KxILv8ch?=
 =?us-ascii?Q?1OgQ2HABXz6ugSeWKVk0WqmnRm78l90tOGqD+UPs+FRPWHy9uoI62ONrzQ6b?=
 =?us-ascii?Q?86JQQuUAdn16CS0ZuaDzjK4oJ/TT6HFBO0tRmapy8EX1s1ZCUN/ZB3ef4FI3?=
 =?us-ascii?Q?7Iv67i+H+sNVUu1EG+v5mYYlteYzraUVg9nIr1l06owbxoUQ2j/YFRfhGIXq?=
 =?us-ascii?Q?FXgMd5c7P8bbI47B54rV3BDbBm209495/TlMQZLgOREv4p7vDi8xCbKL/SrD?=
 =?us-ascii?Q?hc2S5we2pnDflDbvTrYGKGYX1DSxD/KAiucyK//kd01Gah40ppIXS5AXe82q?=
 =?us-ascii?Q?wMtGAL2NaBstrTxjzw40yEJAmC2A7CIgVGL1cmx/fi7pyLT/MrIHojvcgtcV?=
 =?us-ascii?Q?kqvua7L8ALZQvruzKkI2LlfCoB4g5VAXC1A+NeDv2Mb4dAEi74Md5TdtsWQ6?=
 =?us-ascii?Q?0dl44RYwlDPKUd4h6EnArc+cjiHmKlNNvBlf6c9YPl9qIj6wLhrI2grlxzyy?=
 =?us-ascii?Q?GqBIXlmqtj68AMmY/4NZRWqApy+Xr75VK5tj3ZT7mrkf5T4GBFdQ97JNudpl?=
 =?us-ascii?Q?qBqqlMRcTOfC2QSqgh5wzBZ9uf4CebsaEE1VL6uYO55qtGpGWieQW9rfpIkd?=
 =?us-ascii?Q?nzVLNefOnmEnBf8SOC10jQyBnj0J3mD3QM58yLxrce8xbIO3ria6vE7Ba6oK?=
 =?us-ascii?Q?Z6EjsImtJu91EiN+RffCpI7pzbVEhLQry9pebDxV+6KQ15VbGmX0uTGao5mB?=
 =?us-ascii?Q?AJkAJCqW/K4LFiIVkBFo6/dIyMJMBnaJw8rcaengxulXoNFclU8yAHjufAyu?=
 =?us-ascii?Q?7CUZaLpKhEv/P7/DzH2taat3yVmyyUbS4cxndcRbfk/5Lw+UgECtnKDe5nCb?=
 =?us-ascii?Q?McvgVwFZ3WQrVz06KjzyJI5DoEsotdopL3DPjYLmIKK41QxPHDWDf43UGdH/?=
 =?us-ascii?Q?Lgv01W8scjXbmmV/WLTRZBE01RZwwgWnUgG79xH25p2fTUZilCl0FcO4HhP+?=
 =?us-ascii?Q?ji3HkXgovV97/gd/THiZJ6z7EX4F3+HdKDlFXSpnndMtTl9xROL5IeumM3Ha?=
 =?us-ascii?Q?KA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e390e933-7c94-4484-c4de-08dba95d22c3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 13:29:28.5143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPOuJNa2yeokSKMPHjKtgw2633ej+iniFem4ThtMImGf2O/Cigf6OXslPK1+1qcT+tlFa5VmPlxbPQAQOO0QUYnaxVLiwB4QWZA5As/8OlY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7334
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Set scanned broadcast source device as nontemporary when broadcast
sink synchronized with it

Silviu Florian Barbulescu (2):
  For the audio LE broadcast, we need to set the device's temporary flag
    even if the address is private.
  Set the device temporarily false when sync is done with a broadcast
    source so the device will not be removed on the temporary timer.

 profiles/audio/bap.c |  5 +++++
 src/device.c         | 13 +++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)


base-commit: 670f0d0f618d3f122e6d95c34de53f59a343a15f
-- 
2.34.1

