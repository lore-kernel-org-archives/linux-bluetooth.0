Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6701EC77B7C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 10 May 2023 13:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237265AbjEJNrK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 May 2023 09:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237166AbjEJNrB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 May 2023 09:47:01 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on0614.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::614])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E8AD046
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 May 2023 06:46:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr14XD6elM0bzgmV5zkRsu73AUZFiAJ/QkFThO3oyUE/+JRMbcVkYLj9IMBr2pQeHH9zQ6BZx5Tcuqc45HKPXigtM6tPMTqP+ylyVoZeVscrb2TZX4F8DZxDUfdBj9ewWS4d6iV4tLN0ePZbCFf9hODgh8220nUN+QaziOZ6dwj2M7nIfbDZwfz7a2D1zImDMbMTL6OdHPD3j2uQ/ORmev9yLAo921UfeAfk8i1YaoaymJdviAtQp2/AihqdAA+EXSs9puIpwQbrhIi168mljjJkDsnS6ECUvBxzPdO4vvFfwRJE30mbuVl3DWvCf9AfR7JqKdduRwLzs9aZjfuK9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0JC6cWWHtXuEo98GE7TYM3cnfIkTXrka07m9aMyUFU=;
 b=RmzmJHNvsKAQGw+FH92s8I6Yl8S0wtXOzzKHuvC7FbNySXhF2Ei385nXUZ78QhYjRhtlNwzR7Rlg19uIYC+WuluCsEzmNWeG08zbbTge0vwSsT/jBfbTnCanjvnGGCM7VGP9NFhXcw94AamS+pt4Vp4pDF189OlbSrzZGywJi4knknSV1l6ND9+69TY+dJ5C175APu47CmseXh2GXr0StAfrvqIQSkYnVHLNsxkEHlNeIrugn+L2k2FV3x0Tt8EttRYQiAPcItxq0pG2U4MY6YkACeQRwLrJZtmTaWEaOLwU/kfBbysNla2VEY6r06Tz/+AjZM5SG/TMwdDBZbIM0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0JC6cWWHtXuEo98GE7TYM3cnfIkTXrka07m9aMyUFU=;
 b=Pn4MhKF5MpRTNfupfgpT1DoGrapp1drIiu5ZHycrGoI/J/G622aQ88TpBj9nN4JW+oFpv9qzDGO7VQGJZeOWJR+uItOU8QSCD8xYHhVl+zWIJf2UyU8Jw64TI9+mClo2nc9V8IP8lVYKOFWyxC1QC7SBSnHUT4YP6JCVzz6z8/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com (2603:10a6:150:26::9)
 by PAXPR04MB9593.eurprd04.prod.outlook.com (2603:10a6:102:24f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.32; Wed, 10 May
 2023 13:46:15 +0000
Received: from GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a]) by GV1PR04MB9151.eurprd04.prod.outlook.com
 ([fe80::54d4:ce9b:c49a:d46a%7]) with mapi id 15.20.6363.033; Wed, 10 May 2023
 13:46:14 +0000
From:   Claudia Draghicescu <claudia.rosu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Claudia Draghicescu <claudia.rosu@nxp.com>
Subject: [PATCH v2 0/1] Bluetooth: Check for ISO support in controller
Date:   Wed, 10 May 2023 16:45:56 +0300
Message-Id: <20230510134557.11486-1-claudia.rosu@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P192CA0012.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:5da::20) To GV1PR04MB9151.eurprd04.prod.outlook.com
 (2603:10a6:150:26::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9151:EE_|PAXPR04MB9593:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e11da38-4fd5-4989-a37e-08db515cec3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oCfYDOM2Ki5dsq6IzE8qmVz3m3Qx0WjeG/y/5cWRWS5piiWr+b3JiLNS8yNNxaH2JLMkXVEAsDMq7q8Erfkw63WNte0rFbxBjbgWnf28wnhuY5qyjTOixQRR0sE8cR1rgXa47DBAUQGAdZsURwGP+SK/eXPIAreqs6SSnn35Zo2JbaGHazgFkUnhH2RFa8IlDtvpFx5HB5pLUdiRP72Yo8CC4pDvbZE78/g3+0V52Uhjfu3ia0mRGvmq1X4rYirpMq99f16tfjWh+hYRfO/eIzcc9g62bbHTNhUP4254U4gvFDIDb7B3PFW20h+x7GDTpiUDuCaXTUMtkbBdMwwcUKJlHJ6pfSj4araY8d/caOZDhWVC6NmbTgGBLt4pzBLc3vHAREELeCCp3jmu6Zw+J1RUT/7BU9rRmQ8f0leyHi+tzl4wAkiXKWt3r1R5S8XO19F1K3Yd67QGFaNxWk5FPMd+wKIO66zk5ROxIvTtNWT5sOefrlAW/L2e3bgOzwkPDI3gSAInGvDRK6WEKqiGyifV/wTii6LLQANSY/FV3WdvR0FV7k892cVqAfkLJjiIoWv47HxOeYFtxL1DfOzT5zq4bWg7k74SDzPxMAvICpaFCtk8OdjwNyQFcVz/eWzC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(52116002)(4326008)(66946007)(316002)(6916009)(66556008)(6486002)(478600001)(66476007)(36756003)(86362001)(2616005)(26005)(6512007)(6506007)(1076003)(6666004)(8936002)(41300700001)(4744005)(8676002)(5660300002)(186003)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RTHEhX3boF8Nml0hQ0FMH+4D3Wgo8KaM1k58jkGFdgvweupDQk+8BizQhG3I?=
 =?us-ascii?Q?xbiAWZAiNCInkpydnLhsUJqKB7LXlyfRQzWX33FOZKJDCWwK/vDk3H8n0QIU?=
 =?us-ascii?Q?E/V+G4QxAYPSacRHwV1NReUvETuNOrFQolOwb+v0Q1mLvYkZBOpqr/2Wvu4x?=
 =?us-ascii?Q?xqt42OKlSWTjfF1YbRytrZcteiDaJUrOeoeBgiUz+O+CnDmbEIyQWJ5T7kLD?=
 =?us-ascii?Q?vozrfUK16QFlLnXGmblPkayTVVoJQjOco7m9sCmBI1MUMe267vfEk1W7PPq5?=
 =?us-ascii?Q?cMIN3cp5yYUSwLEbe+U9kOOT03tu+srGesMMeRRVelpPoMNj/A6BCfvHHLQ/?=
 =?us-ascii?Q?MtXfHr0Pdy57v0cB8ZMID3BeUtmEdbpNhsv7msg3+ykkqduxMvm+VM66xxAo?=
 =?us-ascii?Q?+DetvKsBHFoKnh/VXKLNrCdoF0RcrmDh0g5guiTMD8e9j5zVfQJ0b2PdTl53?=
 =?us-ascii?Q?3GVeYe7m2yQxp5IcXtfiD8xsnm35TrDhxHuCa3vgdt/W/VXDTAQhWpHRkN20?=
 =?us-ascii?Q?s45ncR2NIQkwC46ZS0Qwqov1seBLB/RzaUBkB395Jwi3FXzWFUvcdO6Wf1Ah?=
 =?us-ascii?Q?vTDWt6+Vut6DRwPcXF+9VNnUwN9E9qaLsgXUQebk5V/IgpU6KlmIizngUPud?=
 =?us-ascii?Q?imzQZaDG9uUTxhOX+2RbFEiXvuEp5gzliISuR9evFWiwa/fPg1GUcUcd2K48?=
 =?us-ascii?Q?wQXKJsgYNypugcjAF337ZWrmt0zEeZExF/CxFeY4e9UjwgV9BUaAv/8EqEdD?=
 =?us-ascii?Q?wwqKPf628P7GJZ1TcPPPmVQDisIc1HxhVHnNTGf9cYafRsd2QmnYJQw/6MjP?=
 =?us-ascii?Q?yfWfSpjKqljpJ5LcdHYX9N9/l6jqvFXiRjgyWNiI9UkPLvR6wr5ln38yoBdr?=
 =?us-ascii?Q?CMyLG3P668VGKc4ijhnjFez+Ngco32rs37SfvyaJv7U1KE/1G1iEtoLilX8C?=
 =?us-ascii?Q?pD/IPhoX9LOVyLE3OdvXlkBoFsJ5o9K4k6g9FARlvADQZp5rNJYakwRVM/NT?=
 =?us-ascii?Q?WA1avgxYYW7r9lDu1cA/NEMeQiMkQEm1cp0EUYA34CRwZ4nGl+En4rOl+Lpp?=
 =?us-ascii?Q?89+5kKsrWMvMK2f9jhNtEUhJs0RM0muOnoeWNsdlDRot2TSonIZwWLaBhWni?=
 =?us-ascii?Q?Wu3MKkZNacFTKUCRcGAejBR8LAnP+zVod1U00a7pTEyHxHy655k55kVAQWYG?=
 =?us-ascii?Q?fIwkL+KUV7WSpM2hQwAEi6q3qedWhcvcr/gstaIHg4kSXxK+G1LXdyB9Lf+F?=
 =?us-ascii?Q?q4ZOZlbDeBRznXdRSkHT0MRJ62gyzyOgvQLdEa2inwBioJY2baZ7zGPg7Yrp?=
 =?us-ascii?Q?tfNkWGbhGiDFlzdqCv6OSRoPZbr+44grG9VFJECRmEkoPAYj3pKipH/zBZJJ?=
 =?us-ascii?Q?53Ck8wLboAteBDVQMQ5jTj54dzZRgFY3CuLO2da9m3QsJH8tLwVSFCA9kL0X?=
 =?us-ascii?Q?jh6dQwczorKuqwMv6W/RJMwTYiNv1E1sQquQyhSg77DN09kyF4cEOIjNkdGg?=
 =?us-ascii?Q?qeL9dshAJPujM5b80g7ASZeSZz3EOdzee+W+eqb6taTgWJX8qW29Q0mYCm+2?=
 =?us-ascii?Q?jqjjTwDijNPnx6RNClKOgHhIz3z1L4cMPVIsy4ns?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e11da38-4fd5-4989-a37e-08db515cec3c
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:46:14.8742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m2TKOXnfbRCNPj+X2JO1XPeImjMZtx8lZ7uvXmE7bGskYklL089LXKpqUjbYD0DXaYaHql9ERN2qnP5ATODGBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9593
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch checks for ISO_BROADCASTER and ISO_SYNC_RECEIVER in controller.

Claudia Draghicescu (1):
  Check for ISO_BROADCASTER and ISO_SYNC_RECEIVER bits in adapter's
    supported features

 include/net/bluetooth/hci.h      | 1 +
 include/net/bluetooth/hci_core.h | 1 +
 include/net/bluetooth/mgmt.h     | 2 ++
 net/bluetooth/mgmt.c             | 6 ++++++
 4 files changed, 10 insertions(+)

-- 
2.34.1

