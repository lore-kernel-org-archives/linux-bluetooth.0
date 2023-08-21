Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CADE7EE4996
	for <linux-bluetooth@archiver.kernel.org>; Mon, 21 Aug 2023 15:51:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbjHUPvf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Aug 2023 11:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236193AbjHUPve (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Aug 2023 11:51:34 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2066.outbound.protection.outlook.com [40.107.241.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B682FE
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Aug 2023 08:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGfkIHHn1F98kgmWmY+IFCziv+2gL5WIA2K+Tykinzdca4zG7I/TvUPHD3b+/XSSB578GYSDA8a0FWJtoXKJlFult8nu70osiV+DB8+PqjCq4MZnO2MEwEf32/varPgzilt1HSyYMvujucfByA4R2KHnR0YAIMRsjk2VrgVJ/6+cJXs2CA2IOyCu//8VoYwgJt/xQrUYwY4qMhr6lU88So0kKckSzky8H5GSRj40D4ZWK3SRDExCK3Qm9JTwUoqkxUMN8k3vnKzOkTP2oyIuVWE7B3Nlr0bzWMNvNOV16xuxRIkQ/JM6P8X2p7/Ip40rCuleDSyxmW5RQMqnyvxCfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4H+vRnfdQNAaGmVoHIK6zUDpGoGb5JT0JRqR0q0q+hY=;
 b=JCbyCZXCfN/Z0eH90OzgvTZTDY5w/f6a2cE2otZRBpACZzuyyM8ff3yuMYsp03BBrl0dpw5tLmNOIhU6qpHbqVaHwV7AHX1wuP8ehLRlnj4qOpC9q9MHKfEtV5og7NAjSNpkT4uxDKry3wyW72OAb8D8U+kck/Ez54XphIBzfGmKuFm+mVU3N1ozV5Qj18X/EAoW78uoUxdjj6qaX2bznWBtVTiJ380raiy4ymD/BlelHOB758oZCbihvllnJpJVrapzi68ESAiQlDeWagmLiO25HKseq0TzFlCXabrdRJmGPcI0JMuhczDH1DGWui4u1tDF98o/zaEFpVD5ewqjfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4H+vRnfdQNAaGmVoHIK6zUDpGoGb5JT0JRqR0q0q+hY=;
 b=neA1w+xYHWNUOiZeEXvgcyXdnS0sT44KLG8tTNKyDjOGyhfDU1HCltaXqUE//w9Id6mXBYQjTDCMJtsKlL2Ltz9Qa5ERvmVyuw4jbyLP397lMCkY4oDy5728/Oy7SyvvXvQQDwbtOXGiiB4ntgbknrDuouYFY5658WxVnm1iU8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by GVXPR04MB9952.eurprd04.prod.outlook.com (2603:10a6:150:117::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Mon, 21 Aug
 2023 15:51:26 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::c2fe:9eef:61ea:36d9%7]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 15:51:26 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com,
        Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH BlueZ v7 0/6] Add support for BAP broadcast sink
Date:   Mon, 21 Aug 2023 18:50:58 +0300
Message-Id: <20230821155104.86954-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0127.eurprd04.prod.outlook.com
 (2603:10a6:208:55::32) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|GVXPR04MB9952:EE_
X-MS-Office365-Filtering-Correlation-Id: ccd2edef-f2c1-4e62-6897-08dba25e7a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1olwy2U7X0sMLwyaVnVR2uTGCxcu8Qya5UGZDtp9MTTNLsnSYxKOhyClTU9ciisXessHPv5uAKItgZh2ooJ/SblRoQWu7tLG9gfcsjxZK+NKzhUI2C6x7fZ4/wYCOeuewOHfiIs6YUZpbVCIsv5OT6KBDfUagqXKhMvCkyExjcPYSkJznu0OlSrgve7dehidtyqbD65zqJHHcJxne670n2u2Zd3bjWP2tQrFBHCmLVbTZzH6jJnp1sd0qcvCvY9Gk0hS9L2V/ywMq9hWlS++L0hW/Nn+0J2QJlbfqJHmjpH8gFfaoridjjPrjvCdoQYBfMRwvKkmcTZ4nCy57QEr5iT2WB4Jqh/XSt5wGe+TqYaqBA6cX6pyFK12SEsjUYjAs9e6NNvqhOwTyXqjFXumf+JIodc44G9C54Ffe02sn+JziP4B0uOhS+tLKhsCOwsQKT4HXocUNhpGHsiHc+zfD6gwQunwm4vW2PaOygoYKBV9tSQ3e558n9bcvSUcO4s76uCMrm0fIc3R8PLPFRrnB1dNNy9ar5f8EOO9sNWdrA2QHYz3svOehZ+mtwDBovHZDxQON/S95dig1RX5fLP1sjsxTwbJxcAD/BXzGEL1N/wB6u0GbEy+Mvlzx4PH0Zkx
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(2906002)(52116002)(38350700002)(38100700002)(6506007)(6486002)(83380400001)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(6666004)(36756003)(41300700001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zHKMQ0qtxLtEfEPToMvX8Z9PjEOcgt5+uZ2RVDCBF+WGywqencRvGHUD3ffQ?=
 =?us-ascii?Q?9J0DDWFXB29RneDPluBPPHxtjPkTyiZlpfBpXOqLLRX72yZnyWlZoPNauHfg?=
 =?us-ascii?Q?vRDVYT4feOZG3ctUywA0RGMN6lQnNvb8ODiRRNdZ4KFcHJP4NwAuWgLqaxP/?=
 =?us-ascii?Q?IM0fqooEb2SaBX3lnzbKjITiO0zmmiLIR5vDRDezZREyfcpWrf/Uii4i96kU?=
 =?us-ascii?Q?fFt7f2bppaeCgGnGISgMYS/ctyWt0s3sx2sE2wrqQQOYRveh2RDz+kdNquif?=
 =?us-ascii?Q?dEWi0fiOsfnR0VrDebTqQctk4D3wfoyV5VgtZSQQas72j+wsG+5pDhz2YSAX?=
 =?us-ascii?Q?cw1HnMcCtq3E2m9Pggi1fBJ+1E4EzYF+H6k37iNpXJfnBNI4pANTmXBnqBja?=
 =?us-ascii?Q?vdr4sZJQS4qc3OGAgc8a8t/OFngOQQkcj+Fw/pwd/7uq+bG/fRRJe304ArF4?=
 =?us-ascii?Q?bC1xeOFMUrMAsgsYCehAJvnvu6XHpgTORif//iqFJtARpzocI2EzwujarGij?=
 =?us-ascii?Q?qmmjyVSAYKV7Pwt0+K9UrHQUYpr0pdYjgrIm4tR0974SjFxfpwE9J/nuPPPc?=
 =?us-ascii?Q?IdY+xdlOmvCPP6rgmrpdAmTLX3oGFabGDj2MhLm7yGK4LLMeVSKIu5q02gQy?=
 =?us-ascii?Q?ZjFr019IZkRbipvK1tVQgCLfyIC9p2QnBu/lJffrEGWH/t+IEfYay3fTSfTK?=
 =?us-ascii?Q?K86JAydvNO94E4H1jYYceI+oorbq4ODDAVS39Liuy6hReQ5mydckEzs0NbNS?=
 =?us-ascii?Q?7rSJlGjt24CRtbZ5971XLLYwvxH6nzQIsoYiYVrqHiPgYp0zSZBesM5pBfRz?=
 =?us-ascii?Q?IyUgjr7kJ4aHfuNlkx/3unb7fh6NAah5VQKNiLeQetJNnB0EOkhKVUZ3WVLS?=
 =?us-ascii?Q?WOBDaWtdNcgTR28O2kf/zI8f5tx6/b30nNs1xz27nvyd347T6H2nYTsiH37N?=
 =?us-ascii?Q?tR7B4OY6CK0OdNDZ4Ktxsf7LRJzkor/eY6faO907HXl0nHr/liqW/cXlmeY5?=
 =?us-ascii?Q?/acQpO9OP+KcQzyVqi2WZetBsgA5RrsLpyGs/D6M/M8TblhSdlJkoUntk8Gj?=
 =?us-ascii?Q?JBErv2bEaO3zHozLv9nC4rSXK09ZPpCDog8/S5Amjzxfllbw+P+8/PbUD78d?=
 =?us-ascii?Q?LJ/41YxXmK9EGF0dYiZ/7jGk58lR5sUu+TFAFTlmjBGjsPWADShCstz+kt7h?=
 =?us-ascii?Q?6TWys5077nRW+HoRIh1/mCEGjhPH2zDrm4vhcEeibwu0RUuFxsnzp4/MM0Ln?=
 =?us-ascii?Q?JivKeVVBr5DHjVmwIzssV6tG3FUvVXLLAZsGSKeqwJLJblK6zV4i4NSe1WqL?=
 =?us-ascii?Q?UGOrSgbX8Yjvze3fJdP8rz9XrcSOEjUCVm+kCWMbqm/DvatHMNlBVU9dLq/I?=
 =?us-ascii?Q?RQ8oknF4h52CH0QQ2JM9ibvGx3xCUWo09RNXLs40tZW8kjJEG/tvSsloeRXG?=
 =?us-ascii?Q?8jdzby+m/f9uelT6kEm81d4rvqktISmAIXYr5NiKA4YNbFwB+fVV/rJhDYTe?=
 =?us-ascii?Q?pe1J5EuhQB0RNIi1/n/e1G95FQmfz59JstpS3GYy0kORWLYpCZWMUugha6SI?=
 =?us-ascii?Q?F/1ZOAof7AHjXZSZtOL48q9wnhHHO8rZFqNU7Kya?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd2edef-f2c1-4e62-6897-08dba25e7a29
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 15:51:26.4893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGvVpdafjRgW9qymK4Aek19m2rXqJ3kWM5u9aLkCCJDmaXl+EgTEPwWg4LEu4Mex/k/YdbwATDvMaE05LQYEQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9952
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This series of patches adds support for BAP broadcast sink.
It consists in registering a broadcastsink endpoint using the
Basic Audio Announcement Service UUID,
discovering of broadcast advertisers that announce the
Broadcast Audio Announcement Service, synchronizes to the Periodic
advertisements of the source and synchronizes to the BIG advertised
in the PA train.
To retrieve the BASE info advertised in the PA train, the patch
Bluetooth: ISO: Add support for periodic adv reports processing
was used.

This feature was tested using bluetoothctl with the following commands:

[bluetooth]# endpoint.register 00001851-0000-1000-8000-00805f9b34fb 0x06
[bluetooth]# scan on
[NEW] Endpoint /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
[bluetooth]# endpoint.config
/org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/pac_bcast0
/local/endpoint/ep0 16_2_1

Claudia Draghicescu (6):
  shared/bap: Add support for BAP broadcast sink
  bap: Add support for BAP broadcast sink
  media: Add broadcast sink media endpoint
  transport: Update transport properties for a broadcast stream
  client/player: Remove Broadcast parameter
  adapter: Fix UUID name advertised for bcast source

 client/player.c            |   3 -
 profiles/audio/bap.c       | 312 +++++++++++++++++++++++++++++++++----
 profiles/audio/media.c     |  42 ++++-
 profiles/audio/media.h     |   3 +-
 profiles/audio/transport.c | 251 ++++++++++++++++++++++++++++-
 src/adapter.c              |   2 +-
 src/shared/bap.c           | 266 +++++++++++++++++++++++++++----
 src/shared/bap.h           |  13 +-
 8 files changed, 826 insertions(+), 66 deletions(-)


base-commit: 0004eb06d5d9a2f27521d9ce3b206d6f3f82c61e
-- 
2.34.1

