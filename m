Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E4EC7618A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Mar 2023 14:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjCTOgq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjCTOgp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 10:36:45 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2062.outbound.protection.outlook.com [40.107.22.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A903124702
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 07:36:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8ZwUbDOMNhb3DXQ58Erw05/8hwM0wRBBdkPlrkw0syzlUONLVcMfaHZH/WDbrzHUXTeS59A3j5rNT0PBfnnUvqFfHclwnS5Ok8zWOpxSyEBtGS8+8cLsWt4t25IoLnRu//TB/MiDPAUR1JWpQplYnd9hI9ARxqAtI70LjbEI0vs+La8h9fs3lbNgdPZGdi9FRKhhxc+ZIfLjoa4U4qR8aZ3J8CLTZFT9LvBEiRB4UEmquQEjiyLOZ20MRvI/n++GYuerLPkacDNiunjLcHT0VKHV2v7r6A+1/xKHr8gvRXKGSmAWtZ+Lyd5sdGq3hlW0Y6aSDil5gfBA5IhqvlN3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPVHQryT3eF6stglogvuSyJmgDD952purZnYGyXJwQY=;
 b=GKZlW61+1yXMtI/V4PRl7siI9hyZ/7/Ww6B9W6ThD4KC3PZqNN6nwwK4PnLxfDK+B8jkNb+dKyq6c5voo3Djt+PzVdBHJ9JVdKg7Tclj387gp8HjNsgonuPalc+dOO9NQwb7pMcc3NaBV6eufmeiMUdZ1q2E0++taMZPFOLIn0yea6PTCvjbVVIC8yE2VUgtbvzFLp6AHI/UNfVaXEb85rAfV+YeK3VThQU93e9IRbgOGrFkSJyshY3eUlJyfAh9We/jx2rVpGcIzJgiLm1NFgH07yN7M1n+jZr+XdPBNAY8nx2zhllNrABOOBrpNjPXv/+Q6CYQrArzgESRbx6PNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPVHQryT3eF6stglogvuSyJmgDD952purZnYGyXJwQY=;
 b=g9cH8tTCwwu2GQM1Wo19ULfM75tXmutKrYoV33UgOfAB9UZ3rurUg7cUl4HhD1SlcwaMVuBfNYFG0B1emPdAzsU4ZghuZWbnRoEpNkK1zGmGheNopZrx13tpxJHHS2ZC/TNd8SdVZwcGxnUvUE9Rne0bRhttT5LGNanwaGBGmZY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by DB8PR04MB6954.eurprd04.prod.outlook.com (2603:10a6:10:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Mon, 20 Mar
 2023 14:36:41 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Mon, 20 Mar 2023
 14:36:41 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH 0/1] Split bt_iso_qos into dedicated structures
Date:   Mon, 20 Mar 2023 16:36:07 +0200
Message-Id: <20230320143608.25399-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR04CA0065.eurprd04.prod.outlook.com
 (2603:10a6:208:1::42) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|DB8PR04MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 16c3c91d-a039-4d48-9384-08db29508521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pa2N+izuph9BavntUp/YGrX78CrpMCDjRBoWm7QhD5k27PKtJjHHYVmKrBZ23DCd5cvcLT4FbVHqMP45evgfBZt9hRQ95M+sBYQV98vKi7QmsjuzrZqO95bKUeC+cEq1JjlNOr0XVR1LxmCWI+3CgWlWsgwjG0gdVYhWLyq4kLEURYO87y9mMgqHGl56bUzKVzXqmu5ADFx+3QqCr00CsvsDRQ7NwWQP/Mir24j/J+ynY/6p7G4Pl5pvb0z0rRekWEAFNKQoJZC/vh19q5nSA16IkeS5G3p79rFe9Z4GlQf9rJCWQXwDCPEwPE/ZTD6I1+u0J/pUqdJqaf+J/+QHUxxG4AhI+XBVpVr+H9oEVsnb3H1SoEL1k38sEOb1kVgUNpbRhtNLOrsd1Lfcnzkzzl8TN3W5q4fVZDtVEGEGKZ/ZaA/oypfMYgUcKgudvd50dVN6tLhiD+bxOTaJijJ4A4ugPD/yR1zp4ZuLeC5hfikmyWa/gvzTe2AXdYkyoIHJToyOovHcnJbSw44p/fSMQ5IsDDLauMuD9+SfMlnbux/u/64578+bDZXp3wcqsnn3AA9AS3QvVKRzZkwU6R0arq/+eV4L/01BElC458mtPzdLmQLsDrGyiE78lgAsrakeICGWNesImJ1SkQDumUunUdBd7K0BxDH8bijXw4m5GjKS9jShroOUMuOgCAt5kiavQHqdQaGfQpI1XqJfA6XDdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(451199018)(2616005)(41300700001)(52116002)(186003)(6486002)(4326008)(6666004)(83380400001)(478600001)(316002)(66476007)(66556008)(6916009)(66946007)(8676002)(55236004)(6506007)(1076003)(6512007)(26005)(44832011)(8936002)(4744005)(5660300002)(38350700002)(38100700002)(2906002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vozO4BICX1QsoBHLL83YtVFrCAyVWLHanTZsLH/7FcjRSNyunt+xGoFLMI/Z?=
 =?us-ascii?Q?mPYlqQP9ugv4mtekFzXx1+DtwNoUVUccjn/lidldOBnDVOSoRKnBb8cxVy+U?=
 =?us-ascii?Q?2W7yogu9SaAWFXK9nX5bl1ISxA4dtC/dBQkjbeAbgItfciHoVgTI69SeC5ZG?=
 =?us-ascii?Q?b0WxcSx3izWp9F/mXrooVAde8AUULyB//HHOlWxvnVSho45fW1nuEzoLRQvI?=
 =?us-ascii?Q?fE46arwJP/EvneQ1ewddHBYWqdermkv5FcCEm0GLydmBrwiBiBYvCbQa9uv6?=
 =?us-ascii?Q?7k42psxd9f9UMfYGsw3JC6LyzzgBTkhTPAGONQoNwO8b79HXCKsuFF+DrJ+z?=
 =?us-ascii?Q?zFpjpZjQ9BpFZR4z9roH/TkXla6VltWxl6uW0iYVRDqnaPyRWz/40jKB+aaS?=
 =?us-ascii?Q?doW1i+BY7TSjNxVQgI7pDFobiLGWBJ89GcZDHMem4NrWV5MaxVVRXGF5LS+U?=
 =?us-ascii?Q?gVsAQ4loOwK7JxQOLBGTjaVWmdD+IOZ/frEwB5xhLWrCQ8PlOU+k+pzRaAHA?=
 =?us-ascii?Q?mzVGLMr0qzmlIKkkyz60nDin2wJJqeCOim4bPy4QPppRxrbzuowS1HrVGeHo?=
 =?us-ascii?Q?IMNx6tAtRLSnOUH6Z3wIORYLvoNoFwdeoIKyrxQTAwjkAH7bY5OuDuLHUcUv?=
 =?us-ascii?Q?jBRtFNXcWYnDAlb+sl1I0/PuZkdcTpZaZuB3xDbAe82rhE5lPuKflmJdT7DM?=
 =?us-ascii?Q?vkaAU5Tgi/HFaE77YMUa+Sx34xnqAJqfDtGWG+VjB3iK5YoXDFlUx6FgiKbG?=
 =?us-ascii?Q?e/1YNVg2+Y2+W0xM+AknXNyYHwd/hEGFCY8MOP7yKNbGg+rZv1bC5QY1Uucs?=
 =?us-ascii?Q?GAsB9r9fIP3ml5rt3CLg8VrRHSbFYp5wcyIfbWSwgzq/BDqEUmjj1o5+rHtD?=
 =?us-ascii?Q?iTZj93xy+mn6MarLngEcQ9k7UfwB5H23aCY968yvWlsyaVQa3J3PKZSahMEf?=
 =?us-ascii?Q?ejk3GRnGDkytnTDAhUYCC+QO+aZq4XGIhTZv9JGbaQ9v4ULqNJFRfg4kEdZ7?=
 =?us-ascii?Q?PlfAiuTtszPWBVoOTHNGDX5EI0DyDh2W1kjryqn7pbDCCDbYwRm+3bcA1sya?=
 =?us-ascii?Q?t+cTtf83YR7rnf9J6IaZs+2r2UmASR/ip0B9czXLk4RieEufwcGz/uc7Krke?=
 =?us-ascii?Q?o+rC+ONheKKAIp4sFfhfwm3r309WNtV/7nJhM0wh50IXI8bwY8qLow+cyb9Z?=
 =?us-ascii?Q?uD4rdl2h3WObAmNt1Y7IDUFp2LxZMy9qRB/5+XXtg+jnv7K6ugCc+tGIutUi?=
 =?us-ascii?Q?EMb8ATImKqZ4GOwdNYSgS3K/Jg+wZScpEkpHoHgm2mlc45uiyvM9zKCZFeKm?=
 =?us-ascii?Q?UWChY/QQZG6NElTJKZWrxiIMcppeyNx9FxOqhF6MqvzPhd0VSbk37ECoPxnA?=
 =?us-ascii?Q?kyGk9fDXrOhqo3pt2wcpZLiu5hkesJqnLT4OySv0JN0kOf6FPPzuO4Cp1W0p?=
 =?us-ascii?Q?qw2sgXPULa7i+QxHFYXFwVU7Lf6hDqzNu5E3fgtBifmprT26OANIPK50IVaJ?=
 =?us-ascii?Q?Up6vFNUylhS9sLTOQ3Z5FiWvQ2BTmBJzKnUkgP/Q44PLgdO3iSapiPjPsccV?=
 =?us-ascii?Q?D+L5b3lihZU/7ryPkL+CfWgjaXQbeEVbf2m2TvtAgHbPGhEFe4v0ssVT0SJR?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16c3c91d-a039-4d48-9384-08db29508521
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2023 14:36:41.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vdqktEIeONbybivc+6bfmGAFhzO6kX2YewOj1C8no5kKjUPBa2Rro6M2VE88q74mgLpZMUm0/0tSX1nf6J31oQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6954
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch splits the "bt_iso_qos" structure into dedicated
unicast and broadcast structures, so that ISO sockets
can be configured with dedicated QoS options.

This patch also adds some missing broadcast parameters
to the Sink and Source bt_iso_qos structures, so that
the parameters of the ISO Broadcast procedures that
take place in the Bluetooth kernel can be controlled
from the user space.

This patch depends on the BlueZ patch series
[PATCH BlueZ] Split bt_iso_qos into dedicated structures.

Iulia Tanasescu (1):
  Split bt_iso_qos into dedicated structures

 include/net/bluetooth/bluetooth.h |  47 ++++--
 include/net/bluetooth/hci_core.h  |  21 +--
 net/bluetooth/hci_conn.c          | 104 ++++++++-----
 net/bluetooth/hci_event.c         |  38 +++--
 net/bluetooth/iso.c               | 247 ++++++++++++++++++++++++++----
 5 files changed, 346 insertions(+), 111 deletions(-)


base-commit: dd41882582a9ab19938598179386b81b793b4a5c
-- 
2.34.1

