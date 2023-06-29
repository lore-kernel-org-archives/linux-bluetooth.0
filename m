Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC55EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jun 2023 13:46:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbjF2NqL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jun 2023 09:46:11 -0400
Received: from mail-db5eur01on2081.outbound.protection.outlook.com ([40.107.15.81]:30299
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230119AbjF2NqK (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jun 2023 09:46:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dR0L2QmFBoJbgyDdp4/D/Q0eat/ZD0kYazLBIdLbIuJK3hV3/rhoQF1Vl+FXiuF4FMsy+h/uqHUfLWOWvLrdM6SyaGMjDhkclz9Qh/XPbTXHBPbBF4CyQvGNWcS7N3iEses/VFRvt6KvXrgBIEm4PUg6BD/mMP6chaK2rjUrYdT5sKAE2GwMxgoV77WJebVrwMjsl1kvq3GAipMMUY086uogZBQYBRUJU9r9Ux8uSnh2uAKNFC/ZB53JhI8X+Qjapke3aUDmWuKUUw5NYiCCTb6Qxc0xaf7wrygdMIzycZQFThpHGu5+drla6BHe2uLhqqoL1VL+LJmQb2M36+DHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TDl9Q4OdvNOgDckQ44scyVKLg0irwowR4dGMu++XoWg=;
 b=DHzAXwV8j+YlgxGQzY+UDoPnhedwK9Gg6pZ4I/3aDweSstA2b8T2rpsUUuVbYp+pC87F5vQU5+1HNS80LV7TUnXeb1d2v12aMRwOnmIdvpGtHYF0kLt8YXoJyurQeEf4nbT+59XULfXwYVcz9qZfeRPgwAeAiW8dmnyBsOgEHCF/mC6eynWBYtbfdCIRXm7+hmuK/hVmohVlChSJ5NzKEn3jt9Tg821ttETqDMB8+yzcYLiJsIRmAmNyH1oEzEAzm8wB/lwUisuLqsEQM419odgerbEvTNKaZOLobwe0XGsHDuUzubIGFea88xJhbi9maaNpCkCws48ySI/HrlWKGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TDl9Q4OdvNOgDckQ44scyVKLg0irwowR4dGMu++XoWg=;
 b=g869y0EoXic5i012obPAST9j2B5jFmo26dC6RyJ3iOcfcnHxbiawUIvLaxi4hI96y8cMmo1rjNV0QnSrThUachCWSC6LirM0jg2uUby5nm+7AVU7pxYGuFP9MCFjcErsZOvs1zFvBZNJtwkF3BAgMdZlON5VWecpfK1hrfGkt+A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB8957.eurprd04.prod.outlook.com (2603:10a6:102:20c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Thu, 29 Jun
 2023 13:46:08 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::2cc8:4c5d:9b6f:5cab%7]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 13:46:08 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     iulia.tanasescu@nxp.com, Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v3 0/1] Bluetooth: hci_sync: Enable events for BIS capable device
Date:   Thu, 29 Jun 2023 16:45:17 +0300
Message-Id: <20230629134518.5574-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P191CA0018.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::14) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB8957:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef919e4-4eb1-4672-c8fb-08db78a730ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Im60xj41VHp+wdX8/oscSlbZ5heaVg+AQFZaoc2FvrCJlKEL0ZS594YmlvJLu2bMc4FtqEtRqaon8N12lMH5tRx+rKhcaUOOwCKE1cQhQF2raGLLZCeklobYtP3pnZ1J+luMS0HBC+lBrET4yXUJUSklbzxxMg2WqLGECUv92PjlTTLrghWy+1eCHveinSOVS/BWl0S/B/+BP+IgwFwQGYt4MvCnBfewhZpot5G/QpLnmdXCfQaHW7VK6+3/UgAwRG+LHGExfbUnlGxUpkZdTj+9eDv2HYFmi8pdSmar/yTw2yhlyvPgEqIgmlvlcCZCkY55zOZuAYdkOfB4rLB6SYwhPh7WS/YE8E7tEFaHs4h3Ei0SB5i8Gknp0oh0uTVGg+ECOxyi5I+jtwNsVhAEx7LVPtLqnr/LEYplqEc1zMPM9zSUpJXUbxQkTk+XnYy5QVp9/3WcsujxjDYC4N210o7vYkPArhZ2GPMEuTRq1jIVirwAHBpjypZtV+lC1LrxxOC8AgL5bBlYbpnojmD4NAA50wjh7RdCCPRu/ikLc6yeOV3rnV7qo0uHKcTlLnEfG6rsSKeGWP1/0DLQFxO0P3v0z9CMRcoHi4ngH0WcdV26KJOkwijcJasPU9sxprZm
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(396003)(39860400002)(376002)(366004)(451199021)(66556008)(36756003)(86362001)(55236004)(26005)(8936002)(66476007)(8676002)(6916009)(38100700002)(66946007)(316002)(41300700001)(38350700002)(4326008)(5660300002)(6486002)(4744005)(2906002)(6512007)(6506007)(186003)(6666004)(2616005)(1076003)(52116002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBZglV92mQgOrWlrPx//o4xEX4dyXcAjx/tO4vBlOHfwF/6yyne2pORzXzN1?=
 =?us-ascii?Q?XXP75EqYH5rtviij0FFqNLAgQPynsJklRwGy8HYqb5+XndZ2oRsfD+gEHUFM?=
 =?us-ascii?Q?rP2HKcUIiyYOGEK0AwkjiL+ywabFjKaWizFrSVLgm1Y+H9z/giySUX/F71ct?=
 =?us-ascii?Q?+1JtG0qlyTgV35CyximygYrqwsg2TsDahFqV66HfLs4pGc2TgXtR87i4WAuX?=
 =?us-ascii?Q?nQrS6ujmlSaRMGEHyiJPKanNkm76llmeKqFabvvebszEiAQ5sXe4pVq305aG?=
 =?us-ascii?Q?ang6cisOh+WcSl0Gxmuf1x2Z8FmzIqo7u+0szs2sNNhWFYnAuRH2iOy5TnKr?=
 =?us-ascii?Q?FmlVSS990rtaVhjLpKpPhuuISOKZMtC1NjgPDz1Ng/3eI23gFXUnPFEwgqCm?=
 =?us-ascii?Q?aZuuCH7+Q9KL6Boq09UZlzHY4TEuAFiSWw6aWL9H8+ZGVz3P9ff4R36XOAWJ?=
 =?us-ascii?Q?3Zj/Q6ER9ZQ7zur02IJ2Mmf5euLDg99flPSuaO8OUnUtVA/QKE619PTjE+5g?=
 =?us-ascii?Q?nl0NGHxxwGHlW2wSaI26XVBoCVSPD/Fij2coU2sqYgSj+iZBKsrjVIrzNuiv?=
 =?us-ascii?Q?Cwj5UuVsDNNQSKXsecO60cWj2ADR7/0pYlTqi98yEN4rsQYBWnI3AOmMbxd0?=
 =?us-ascii?Q?Ke/ntuL+JOFiWzYJ/FHeZs1PN6pTu+YIAklDF2lmpH7ycdk8Om0FWxinW9zc?=
 =?us-ascii?Q?C6u4evlgzDKj7AoRMM3qBAYFvx+hAVcvKYvPL749N8x81DqU/oRIxChHMVG5?=
 =?us-ascii?Q?wNhS3Gh59/X10NCjUwbFuhsSz//I9lADgzcjw2RPpEOzCIgaydjiEHMPi/JC?=
 =?us-ascii?Q?KEcUb3qU56dvSRp5JpPPMeoiR1MPyDUkNP1FotDthz9VcPeOAQwCYGmzR9v5?=
 =?us-ascii?Q?lZSiNxQd1M0Pb3TJlsqV+CsQSQbgzBUS001P7LBcbL+E+lLM64fSuJPgl9HV?=
 =?us-ascii?Q?DoWw6CVcluA66dBk7gokqhwUNt4LG1qPKzfXbjzxgDZq1RlTxMsjF59ornN1?=
 =?us-ascii?Q?lsHBpHsKHoroCXWqd1SQavXPtgvtY3I0oTcwVX+YupdEEhcTysuFBD1nrKgE?=
 =?us-ascii?Q?XeLvtBm2Az2wsczQE6TcE5NOBMGRtcPCST16gKnWD8b8GinZ8mthHelZbmRw?=
 =?us-ascii?Q?lP7Tst38+dSANuNAHSoWsKS2joqh2t6Y2U7sBYAco8xYxk+smSVpY1coJtYa?=
 =?us-ascii?Q?xVk6N84eCsoUV3rplIWUiwKPFKuSN0SXMq3k7zOUGLmiYW4VpXVSDe4MwsHL?=
 =?us-ascii?Q?JiV33x3RTFuC+DwTz91mkDhKYcMUtYcadQs+qa3uMc+YN6hY4JiTFzi1oLq8?=
 =?us-ascii?Q?ms9i+dP5sVT2Fo+9Ca1xb+z1d/VuPInrHxmAh84dTxp7kUZYT9lhkaCTE0YP?=
 =?us-ascii?Q?8dWEegycizEr57RVGoAaDo21PoLUaOOUj702ryGg8Ip67FGvsS6wGRdW79Fp?=
 =?us-ascii?Q?z8IBh4wxk8KG4bv3F3rfXZwuX+o5OdThaNTb0L07CQW8YbHwcmOfPX4Lu38N?=
 =?us-ascii?Q?hGKU1GgcpUkszEqiPOM6/EIT3mw0ZXVnkpE8+Keit3ODozrrqTQQGhdr7ka+?=
 =?us-ascii?Q?8ega7QBIh586p4X+5ACxkzXk81nZpSOLunij3p3t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef919e4-4eb1-4672-c8fb-08db78a730ec
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 13:46:08.1840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnPbsal8mGWLnGfTe3LM2yqqGCYRNWt8A69+wRNtk7nEogM3WVFpejgQf9S6yrJnTAzBLzOdKPr/DeJtEAR+HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8957
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In the case of a Synchronized Receiver capable device, enable at start-up the
events for PA reports, PA Sync Established and Big Info Adv reports.

Claudia Draghicescu (1):
  Bluetooth: hci_sync: Enable events for BIS capable devices

 net/bluetooth/hci_sync.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: e63d8ed98082395ca509163f386f5b04f53872b3
-- 
2.34.1

