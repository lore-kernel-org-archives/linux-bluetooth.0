Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D413C001E0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Aug 2023 14:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234350AbjHBOpU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Aug 2023 10:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbjHBOpS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Aug 2023 10:45:18 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2048.outbound.protection.outlook.com [40.107.249.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD0E1BE7
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Aug 2023 07:45:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WrF+thU/QfTi+1Nscavk79wefmSK0MEGIEMKQ5U5RwwtjHzi8DxlWfx+UgULpLnRiRKy/Dlso49iSQsy31h5i5b4UT087Zvct86wHAV2XjrLEFzHmf2+GekmKLJrq9RMEu/kJWbIvpbvZHujk8hDXFZGGpoS7OZcKC+HSDRY3acB/YxB1q3mMh8dkhf21VTe05gcFWY+JwgLk+jRrVI+niPK0LLJq4QUQEIEmiyrA5qXOdTyCWMpF7EpnDGnJ9+daZgpRsnucOLVttiWazPpTl/kieTIZ5VV6Py0qx9raH48K0rFgEM1asGEFoAc4ErKW0Fj7Z3HGqLc1M5f/xZPNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9SVBv8nt4wIB0sM50s26xw7QTERLOmgGXiYJjxOj9I=;
 b=P6jiAnu10jUCvOUgz4Oe5+W3blSKlNU38gd9oyRag9dS/o80CrwSsECd06lZWkc6U5r90aeR/G0rok7Ei7ZOGlST4mQmzOSPZroEZHffA83iR9z/BE3oexVIEUOD7aT7e/+4AnWP6t2rR7gQUMShMtJ6BN3BXtrPmnnIc97J/dTWFqjpnZ5Q070fNWmOoiD4coi5bjsX+YYz1jV8ttJBTvmziFGcs/9OTIwpSTk67jsk37UeouxOodohk7eLjoZWGAQ8pEUVD/0S7iiWKU1ns4OFpGwZq4nogI6pVfSofZAyYKPbYMFAT4PXxdfnl0sD0orBpgnd66/18h6YIzZBVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L9SVBv8nt4wIB0sM50s26xw7QTERLOmgGXiYJjxOj9I=;
 b=n/ZXR/TE4Npx5SGTRjF8tcVq2JDxvYlPUJay97RdCJmFXMXQesUk7H7cjbdnjIlsAzQR6e2PlmsA0MrhUg73Ph0D2Cgz8tsxRjNSk4CpLfkqVcTf0eRNks+aPlTfCByeWOcF74/ZopuW61lE5t5Yy2ahO4mk81uCSNqESVqjcbI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM0PR04MB6787.eurprd04.prod.outlook.com (2603:10a6:208:18a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 14:45:14 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::6e75:56f3:fc37:277b%7]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 14:45:14 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] isotest: Add defer setup support for Broadcast Receiver
Date:   Wed,  2 Aug 2023 17:44:46 +0300
Message-Id: <20230802144447.59985-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0197.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::34) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM0PR04MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: 9414cb90-df48-4bd3-cbf5-08db93671504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5U6UUDSx6241/YW1fE52cXiLVqDFbFmoVGZTVvtmTTGVFXmuLNzhcGxO24zg/o+rQQwFzpw+YIjbIaqvNjLXW9fkpudRTJpuXZf/9f56vAmd2e6+cDnYPYTwKFBq7rZIoDD1tuhmzl4odYpo3iVhSfLCyr/Jkn7Zgh/ZAGgXLHLYBaIpSg+lb7XETmUOqVvr/ilQa+228KcrfPVj+r+PdyNpxlhlPvHLRqkUA8BZa9zx2MKCEKoYwXf+p3GZL2/Twbv7CqJ5kGzETLkYBUIzX7KGku+ArNgzVMRRubnaHj+/SuSZHoDrdNLOCcvGWdMQVM8ak4/66eaW2jXnup2iJBL1Aw2nvdXcfJfAa3xSEKESSMKMjzIGxRruBZmugLV8jC7LjDn7GLkrWToT+IL2kNqdLZPVtfDM3yEnOFHUZPY2WAazHD0e6G0LBjSI8xZZW99/ZrZkO91knmTwgsxbiQyZwuj5wC5J0b5owR9pDS1ajpk8RQ+PJOtwHw3lkUDRWw1ot4Wwh3qhQ4KCOQGVIXyumSdxL/Q1Od5NINYZWCQcrrV7BxSAoLaJhzOm9eu8ULCiW1j1UGS0qPYrep3hJO7e8LI6ETetsFeOUMptWLk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(376002)(39860400002)(451199021)(186003)(8936002)(83380400001)(8676002)(26005)(41300700001)(4744005)(2906002)(5660300002)(44832011)(2616005)(86362001)(478600001)(38350700002)(316002)(38100700002)(1076003)(6506007)(6486002)(52116002)(66946007)(66476007)(6666004)(66556008)(6916009)(4326008)(6512007)(966005)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9LFjFoJ6tH+D5AFr5nQNX8FGhW1sjDIrYl3T2lPWfasv2TU572p0LCBNr+M4?=
 =?us-ascii?Q?4t872EbVA4jvSxWjg4xdb56+R6mskLbgm2PnZfHgwu9uoDDlKSxH+mcaWniU?=
 =?us-ascii?Q?j4OLX8m7UBVBCl8OGubmAK2V2RcEkFK09G5M6qMp3yzH8eWc20wU8sX1yCMb?=
 =?us-ascii?Q?I9y5I/K6AtQkkEBG2+FfuvVtNWOUsuzTj3E21/LlbXVLgE/7FK4BxQDmjAyZ?=
 =?us-ascii?Q?Y6buudLZItN+PZwhDEboHrj/MXYnXvdV/boWvQF8FiErRgQUX346UXFoxPoN?=
 =?us-ascii?Q?TGTtpswhAUnG6mb9S2YPy8+XCCFixcYgDDrJc5dTyRhgx6Zy6vL2YH0HnJwd?=
 =?us-ascii?Q?usL1KbfFC13JXcbddxqnwRKYEJvkTlX63WocrvL6PU5oA5UhRHt5LPG4cAMa?=
 =?us-ascii?Q?dwDlvcV0JrwZfioAmZEzyktFwod5gXBto1H7ZqIik5QoOzE0jCYXEoueddnX?=
 =?us-ascii?Q?s25D6+gCs130w3EbjYN9bYxIPLyHQ3bsl1OEbrG1ffI8t265l4dFBNg6Zoyi?=
 =?us-ascii?Q?XKoEmiA/+nXHFohk72djg7DmrXbpXlXRgJ01weSP/nuoA1bZ1ygWz3HAwoUa?=
 =?us-ascii?Q?nkn6/W5EddEU0N83SEFKlkIzYnE0GGDtcaArNIESx9Kdx5L8TJuNcTWskyZh?=
 =?us-ascii?Q?WE2WKJkDwfC4+NS0rSTSZ8c7OQEjUvRiMUKc7wZENvQahfsAYyq1sQOlL2Eb?=
 =?us-ascii?Q?k+zcQG8mBwvdFhK1uxHp94NquQqhSZb5tzYhuYCm4yybOA+WBN+wddiERPcu?=
 =?us-ascii?Q?1hothtw2AAMmrIRmIhXi1hlLjpeIxv2++nqONlH/cnmLSiv2jEiaohPB8MYq?=
 =?us-ascii?Q?qz+EeZzFPfavuswbMcNMieaqmLNSJnlF4p3bYBSg6GMF6uDtUXjPe/U4fIgn?=
 =?us-ascii?Q?8if9ymfnMjQBSKqSbyMwOk30eTsxVyfevtTuyo/Tt2UYn0QlyqB+FTr6jpyE?=
 =?us-ascii?Q?DHLKWTQqUQ+fwvd8bG83e60CPKyA1QVsQM7ZqAkeNXAVDQBUTUeLzjVOJmC4?=
 =?us-ascii?Q?msmMCZ+qOjP0Aw69YEoXfDsaew67wEPB3V3tH7FefkIDMqFQ4WZr8+Bwnpgb?=
 =?us-ascii?Q?DtQymMNmqWO5qwVOLMA/NdeoMoqq6UXpKjzs2D7QXSBpfKj5kIN/dXRvaXDA?=
 =?us-ascii?Q?0SHnyer0ECfTcP9ArjnMdp24ekz83R+nVrQggZRQSlNLRJbzHkfXyxqw7u6M?=
 =?us-ascii?Q?juRADY6T78pwhCAnSpHmz70H2TnSRCuJZgro1c8Ne+4KZjCusO6oB847lV6u?=
 =?us-ascii?Q?BNx3TDO3/bhXBXezEW5CaRWJC/PrJN/ElmqNtNqbBoMrYGh7wFzd6UUTzKWu?=
 =?us-ascii?Q?Y9AYnScjwISaWbrCn6710fPNXVD2+6zIlj/zuxpvaemczN18x7whNz3d1sQ4?=
 =?us-ascii?Q?TianD6z3X2TnrAbb3TX7PPu/OBrM3xSN2JzMgfVzonxfXIGBc5K2NHtx4tQ4?=
 =?us-ascii?Q?+fkCjBqrMzgD/etg3J+Ovkb3lLP+Y3GEsUV8d18QTMzXUnNwTxcdPGsfmuV2?=
 =?us-ascii?Q?nnvw7l6xbgumfCO2p5kkAiebER8ARBNFlRS9Qs2wrnHACg2teRRFCzzx2usp?=
 =?us-ascii?Q?EB6mopLwy6rWSu9dlyKVlNLLdbll6ukhDBQBnobkjrGhIEuRSQz+xJ7nudeI?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9414cb90-df48-4bd3-cbf5-08db93671504
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 14:45:14.7962
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WcZyiYA9k+z6jaJMF66qbcMAwvVF6lvLDtSaduuBEBAu9jLKS+ACB+5dYh4yzoLzhsLR//UrDyWk5fn8K0UgAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6787
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds defer setup support for the Broadcast Receiver scenario.

In order to create a Broadcast Receiver with the defer setup option,
the -W command line parameter should be used, as described in
isotest.rst.

This implementation requires the kernel support introduced by
https://patchwork.kernel.org/project/bluetooth/patch/20230802143638.59945-2-iulia.tanasescu@nxp.com/

Iulia Tanasescu (1):
  isotest: Add defer setup support for Broadcast Receiver

 tools/isotest.c | 122 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 80 insertions(+), 42 deletions(-)


base-commit: 8eb1dee87e019f29b6c8233dfe0f9aef8ee44461
-- 
2.34.1

