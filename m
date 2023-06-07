Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F408FC77B7A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 08:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjFGIXU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 04:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234009AbjFGIXS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 04:23:18 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2040.outbound.protection.outlook.com [40.107.14.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A83184
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 01:23:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us10OU92FHhYXOrurf8ZZTCbbryq0y0+Z3jkI9YuGcoowsBurhWfxv2RSlcCwmHzTWVCLUSORkl4WhtveujuzoneqntFeJbUk5z32NWtgFqY0/Vt+/qTwchXyz9Xkr2RDMi00bW4E2TNhyCg/Fv1xbl0MEe0e3+l9qrA3Ewm2gPYkd6GBQVHhWxldzJVNFl7EWKiwx8EFnEpHbNuQmrXFintAAf+1RVIKpXSczvuJlYDKH/+ol+16Yyx/ZdPfEuHzGRk62/1+lSDjjQ/e2FxVnaw0T9diX2jOXkI6tOipf2y6dHpQPHMHcdLFRl0dWEDVZ4htD1j+GKHomL9Krn+Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rt+f8QUVqbuY2OjcvJaQ4NxAfqdzgatdUj6gCGgRDog=;
 b=EKHx7Xh5wAYHXAR6MIvBjYIrRuNCivFkowTIS0pUOILKjUrMwow29GY+CHoq92w7jV6zmDuqW2OriWvNvAuZwxj8gXL1Ykw58tXo+FMhhdOnPfS3qMDsDbw8HMyIDasa9A39QJ/NMwmPX52LvC+z9RZ9Nxfj9osZPdNhB93ybmXVax1iags2Nnl8IYLfP3yCbHGXY7iOG8i1hk+cQaWuGK30xpmwlGo/F5moq4C/e9Q9iVfcs3kcmkhTUPCGvE9DvGlCLG3Wn0ZYevBdKwBJe8QOUwf5T30k6gljH9L8KCyB0OY5CDmUsm3E6V5SOJ1JhYlupLaC8CZRSV3cVlLbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rt+f8QUVqbuY2OjcvJaQ4NxAfqdzgatdUj6gCGgRDog=;
 b=k6wgngo2GAKjD5cQpa8xNuIA0RDKhUy4i35xqk1JVnMvlCNLm15ELzRarOP//35yQIAgBr5+IzhgXiSmr4o5wHxFLq5LmQO9eKZz2btHz2dny50wXf9pVVYXsuGL4Hx0FgBcoma8xlxZAXiIz7mAE0Kl0Qv4x7oj8URB9sZOSjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DB8PR04MB7114.eurprd04.prod.outlook.com (2603:10a6:10:fe::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Wed, 7 Jun
 2023 08:23:15 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::e8eb:cac:f3e3:1085%4]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 08:23:14 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: [PATCH v4 0/4] Add initial support for BAP broadcast source
Date:   Wed,  7 Jun 2023 11:22:56 +0300
Message-Id: <20230607082300.4970-1-silviu.barbulescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To VI1PR04MB5344.eurprd04.prod.outlook.com
 (2603:10a6:803:4b::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1PR04MB5344:EE_|DB8PR04MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f139c6-4cb5-42ef-c15d-08db67307051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vU8PAeXs/tWah3uL/uSsVPU2LTDtIm2pVpiVMhZLxO24TFQlGQgyOYrY2IiINWhAHd1Vc5ULGC8K0V28plvc/L+ZaE76Jx0nWGQ5T1ym5I2BBxHKHWjIglPkOcf8S+SlU/153eMjPmKdejg9NrfVxDznaLZhJxjrNP1fzBzdv7W/Mv6mXC+08KBRGXfZ1mLWKIclzI9ZjqbvZ2ol3JxNsFE/MD5wnuTAIPjaq+j6/6f5gUMiqQq12OGJLLsCABuDVQb7lN4Z2SyHVcGzKjYGw30DAHL1rdngMI+Kyzb9ua7NJcJSs7fHSSuc7B7f4ixk++a1qJHWjL52o3sfxf8gCTbYi5ri9GsYPUgCjmWJJhBJEwj0Ewa+BNLtdqZT2vuX+FYkXpJHxkBHlAmm7NaIYGTBf49a/EfQxZrCeNvtVo5VVA6/ACqrPOYNBVUIrCOozPqsSVtHAyU/Kug0o+J6Ui2HDPDNWOfZGHfy9PnX3PP9MFFHVTBzrW532jSQ3eGz4Jbln+vOjvSa3Ie3zkgagdxHx9SMrel4IiHY3uDkzQZ5jDkdA2uDwj6tvvyE34mI3wlUZ2uRV2WtTdnA/h7EdNy68j3GIdfDBP2PxQEjVFY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(55236004)(1076003)(6512007)(6506007)(38100700002)(2616005)(41300700001)(38350700002)(6486002)(52116002)(6666004)(186003)(26005)(83380400001)(478600001)(66556008)(6916009)(66476007)(66946007)(316002)(2906002)(8676002)(8936002)(5660300002)(4326008)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AC8FPLNODLFOF6vdwiShKMdHFaS/9zMTEk7lHqA9Ed+XXW4GAp+GYP72G4TA?=
 =?us-ascii?Q?rhQJ4DNW4M2JkrOgCeNlvLoq2aeOCII0deqewr8AGvlF4OiQtBXHJ/oANmQL?=
 =?us-ascii?Q?YCpJWHME50rN4arQXnRaMHtFR851VFldWnln2oBiKZXusKCkaegJnrbhChvZ?=
 =?us-ascii?Q?RxIJKA/TDoezXv3R2eJD2phRrrJyjWG0i/OqZ42+ZAiaXMzJBQ+DkP+pvPyE?=
 =?us-ascii?Q?ZMcWKMH8gKfHuTqh0LLpTNHJ736d/vw7IUTu7G/v3fmI1Z5orVd8RAK7ei/e?=
 =?us-ascii?Q?F6zTdmJ6UKmh4Z1+9OMG+DzJvDHwRCAo+MDRJfydQJyOUAq8gv968ODaRBCs?=
 =?us-ascii?Q?UIVzQ3Tv6DKNkXYlLqYaAosioIjiUDgzARHUNfcyNUNOI03ncAxU7QLI2nCM?=
 =?us-ascii?Q?66CLQBkg0P0LEIZJjOEiGmZFgsuPt5vXq3rpJOvpO//85Qw2VsNHb57JeuLl?=
 =?us-ascii?Q?olU0Tz7ri7Q/wOnZ+K/N3I1y11nIL27RIkzP11Ej5BzLj1P4wrTNyKsHn3TK?=
 =?us-ascii?Q?kc54cPEeUnueUYQvpb+QAv2bhPJwfCqk4tSvS71vDzXaiM+/uSTIMXqjD2uj?=
 =?us-ascii?Q?3n855YdLMH93CBjoriFzUL59SK0QCxUMTDhkkQHtsQyxvakMuU5SMHF0vSzD?=
 =?us-ascii?Q?rZ8YkZOX633aYcHdMU3mNcVHq1StYGGsr14qFDTtbrYk9rVypwpl8QqjomXj?=
 =?us-ascii?Q?fUcNq4CmEiTC2fiAkSCjIOiFgwQMg8sXg79x4OuO7GwFKiKzL5QuH8Qf/BMG?=
 =?us-ascii?Q?BzfhQe9CpC5AeRc8ntzAa4ggUs+oCDuVDzVSJMZSNEvuayy7xRbm7dwVScud?=
 =?us-ascii?Q?aGqlOi6dtGxu5U5K2DVpXQ2Z6xX6pguEJ95ObFtbcOitbBbS319AyjeWkFr9?=
 =?us-ascii?Q?sHew/NpEZueNGvOvsiY+3hhkQ4T+8rq9OJKbTKk8IT8knS2K42ulZeSY7L6b?=
 =?us-ascii?Q?gu/2FQGzJQC1rmj0Ao3zREwxY/lLzqMseVxsv0PRN9/5MZNKWBsvxBcCR3+b?=
 =?us-ascii?Q?j1py42Dv9AnlZfMETuoPnVDVCjatMDY7yvXNO10oNWqSnCB3PoA5fyaNJ/2o?=
 =?us-ascii?Q?V3TYrKk2T7SvjMi+tMWpO52jmEy2EoiYrlxjecuLH0XbmHYOuiSstTke6jnj?=
 =?us-ascii?Q?qUQN94LGob+Hqk7cqftl366y6rU6meHaaNY8SZ7JYIPJ/RihibVToMjvHp5i?=
 =?us-ascii?Q?h6cEL+UAqUgJBbTr6dV8mrsqM6NoQoWd72RjmML11h4jTuqlnMm5cYKqN/Qz?=
 =?us-ascii?Q?u528ndOMzRZFKtvUJ8kDZdsgdZUyitD4P+kHpuNmNdQQudaiJ2pvxvJQJnSj?=
 =?us-ascii?Q?ENQ6rTDDwv3RGYA2woK6KwaX8lO6iMeIB0iHrVeVslGnJqwH4iN/he2Cbj0q?=
 =?us-ascii?Q?GaDnki97iUDwtYApjPXoAsRGmBQUFDjkR9pa4xA2FiRNyPxX2BV+3Bk/I71Q?=
 =?us-ascii?Q?V1chsXNrJnvqEP4UjKiNYJ9o11C1WvfaI67wgXpdLRWskjBoOWg8r485hNKg?=
 =?us-ascii?Q?yxZ7tJvY70GsUsYVXZa+GxOqmnkvbSTZhamSg2tvxpxrQiTr2Lj1IaGsZMkU?=
 =?us-ascii?Q?9uKtyw6qQuLzkNIoqZsTaOoljAIQcYO/ddq6IG/EvBOHPwo493fopKgoZ2jz?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f139c6-4cb5-42ef-c15d-08db67307051
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 08:23:14.5734
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gw3OmoUy7mdNUL7WAFwyfcVKmN6IVi8FEaAojQbl+uTkO1H1fyaj3YArUQZCv2sAwMzECPYp/tH20qOQbl6BI9jQ0GqGFyDiUsvmWxK84cE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7114
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds initial support for BAP broadcast source.

The current implementation allows BAP source endpoint registration,
media transport creation, transport acquiring and sending broadcast ISO data.

Currently, one BIG containing one BIS is supported.

To test the current implementation use bluetoothctl with the commands:
endpoint.register 00001852-0000-1000-8000-00805f9b34fb 0x06
endpoint.config <created endpoint> <local endpoint> 16_2_1
transport.acquire <created transport>
transport.send <created transport> <file.wav>

The curent implementation checks that ISO_BROADCASTER is suported on the board so
"Check for ISO support in controller" patch is required
(https://patchwork.kernel.org/project/bluetooth/patch/20230510134557.11486-2-claudia.rosu@nxp.com/)

Silviu Florian Barbulescu (4):
  Split bt_bap_qos structure into unicast and broadcast structures
  Update bluetoothctl with support for broadcast source
  This adds the initial code for BAP broadcast source
  Update BAP plugin with broadcast source support

 client/player.c            | 226 +++++++++++++--
 profiles/audio/bap.c       | 551 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     | 115 +++++---
 profiles/audio/media.h     |   2 +
 profiles/audio/transport.c |  84 ++++--
 src/shared/bap.c           | 329 ++++++++++++++++------
 src/shared/bap.h           |  51 +++-
 unit/test-bap.c            |  75 ++---
 8 files changed, 1171 insertions(+), 262 deletions(-)


base-commit: 52477e80fc892bdd2ac250e932ceacda59f90b1c
-- 
2.34.1

