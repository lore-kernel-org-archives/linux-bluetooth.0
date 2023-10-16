Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0544FCDB465
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Oct 2023 15:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjJPPsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233909AbjJPPsA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 11:48:00 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2058.outbound.protection.outlook.com [40.107.14.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E32BFA
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 08:47:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOV+Z8mZqOVe0OUlvJdAiSkojldwLfH6K8cdqnajvhy3MYMoiQD0Y7ExBsBn409Hbb/M42o4DHz8BFiZi04dgvvIVYjqFsMATTvAZvvBUqY7i8S3hXmiu8oci9knOAw7WTskTCBG5beYR8qeSGuImDkjbROmsktBujkuUEmopmMm9hYp9U9xEMvA8TP/Vb/aMG1G+str3IB8uQ5n8rIJqhPVg41cbyZLxXjCG90wpWwcyRN8IjL6QupC83vL8mD/FY7T+ECAQvDXpQJ9RRCuzPRXQgdPKNs+IgSodoYJD6kjLXNSzYjHB0vaIWs0dbwbh/MQ61lTmDEdH7ufcv13mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9SkFRst2Wjpg8lWqRn/A8opawXC+Ng0+6UCUMUBwSk=;
 b=TSRJfzxbNXverQvpDLR7hxgNifvl9IAvjGl5LtujWk4tRpjylU5ECYd6EZX0L3XsXtsR6weGMjPOya4umE6sy7G7jL4arRpbPct52r9cI+tM2PQmyIo8Y1Czy8++pt6BtKknnIYnN+u3gFoBDbMzEpb0BtPdEMc6scVxp9/p87HlIb/pehJmgYw/DHDPuU1j3gIE5gIpLldS+HAg7ITXLWMybhfbqj1LiKJhLXHomc9hQ2ht7QAX0mQ0bp8DpY5k3PQfMsjR+ro9YzrFIOE7rNmyFczM7mYhkqGGOEdpQAWSBtqMqkkEPavj5OU7Z/0GbdQqgi0dvy0wKi3ssqNrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9SkFRst2Wjpg8lWqRn/A8opawXC+Ng0+6UCUMUBwSk=;
 b=G8w9zPG5d41g57o3Wv9QYRCuC31Np2yONIfdvB/vnkpsqwh9U81Pyf33KD1KBfPoRM9Ad2wgB4wB1NrpQQ1QhOCvEFM7+OQoul1ESBtOBKwVw+F/LQLKfW/6GwjFgU20kZl+pJW4GYhFASpjynvTBprLh6zhQXZ88PEUxXsTSnk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Mon, 16 Oct
 2023 15:47:56 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::7763:779b:1a89:47da%3]) with mapi id 15.20.6863.046; Mon, 16 Oct 2023
 15:47:56 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     claudia.rosu@nxp.com, mihai-octavian.urzica@nxp.com,
        silviu.barbulescu@nxp.com, vlad.pruteanu@nxp.com,
        andrei.istodorescu@nxp.com, luiz.dentz@gmail.com,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: [PATCH BlueZ 0/1] iso-tester: Add test for bcast receiver PA bind
Date:   Mon, 16 Oct 2023 18:47:48 +0300
Message-Id: <20231016154749.3016-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0297.eurprd07.prod.outlook.com
 (2603:10a6:800:130::25) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|VE1PR04MB7423:EE_
X-MS-Office365-Filtering-Correlation-Id: 21f3820a-01ea-468b-4906-08dbce5f43e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ObmZd7MUfvGpNlb35pQ4xuqM2HDsWI4Lb1k5Ds55VtjdDXU+8rCpFikiz/HTazEFpy7EnZbTP2/OHpXjQC/bTWHQCRutHmU2MnrxrCyqSHuKOKBSEeY2FSazQbgHlR320eG1y9tPCWaL9Pn578KS6EtSqAnJUODpVBVZoDaqCmskCvR7ufqo9DNwkqTkh0gu+VYu4P4K0MhAnYZ1krxq0HWN1Zue5VdDkvsUCbzZ4DUFvArUcfWYfVzBRHTfVjXb+u+VIwTKT8rxGlTjkRYqoLXD9EmVOLbi4F/VLFJSUj8k5yKYJffDYw6zDTY+ZxwEobK5F9MV/59DDxa5N2sTAqDNYrYQpmvw58lc6vQDGxGyorctk9FkkskHXzenVIXWwdiDtow9BAG0juA234jnNwpzXbwMuGODTrQ5auJGAL/m7E5dbL7DyGpO0e30oE7rgpqFAngVk+i6v+Y17VLKFCzKws0csN+0Wcn1+begnMUWft47qNZbZo/9fJ4VHJF5ikfnCFhyUkNo25k9ehpHULxmQ/uur3wIO9T+q4+RBIaS+aDek7Ld/ARv9wLLjehf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(36756003)(66946007)(66556008)(6916009)(316002)(66476007)(86362001)(38100700002)(5660300002)(44832011)(8676002)(8936002)(2906002)(4744005)(41300700001)(6512007)(6666004)(6506007)(4326008)(2616005)(26005)(1076003)(83380400001)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pi1/6xiNVYY2NuqW13ptscLlGv30BOTUsfjPdapChjMcdoUAWzntN/fZFt5V?=
 =?us-ascii?Q?Stq186mrd0Uxop3tgWe4RcspBZGVXoPbgf8pdxjeutwcC6ygGRLw+IOjimEv?=
 =?us-ascii?Q?g9OxbFCEbY7nVCf1nAGixMIQC9lIKigv7UTe7C7w0Vw63zrOILgL5aHL35Ae?=
 =?us-ascii?Q?Mp1gEsqArPBhu9TJJZwnXoMLnMROsG0osjPQiWTTh/EuWCs+wUy/V6ObPKbn?=
 =?us-ascii?Q?Q+Q+RNV/v0GoHfM6QcfU9jG+6EH4zanT1xrsol4s5EYOtw3sdnb5o3wOK19X?=
 =?us-ascii?Q?mndTGycvDpJ7Lg5E8NeXM0uVyICS/GXeSrQKAurL2e8/b0zfvrz9alr3UaGd?=
 =?us-ascii?Q?FvgaN2766PbPsE4z06VtabRuyKWRnSBPprJ7x4++kLmnwmCd5VHhpVM0ws+9?=
 =?us-ascii?Q?oBZQDR1c4/H99mYVYV9O1L1Ww7N+eMKdAOrzBNiokw9WlskO25pJaTmv/rkA?=
 =?us-ascii?Q?xy4AM46gsrPA9G7F89JOcHg7IR6VOwE8Tb6jiy+gfbkba19ODr/ZCLkFGtdk?=
 =?us-ascii?Q?KSZNYkkeipz0LUKbLkDR0bpWLztGzwqeAhHW0Um8U2eLVdlmM+SDg8HM2rKn?=
 =?us-ascii?Q?tHNWzDjoFHMAE3+ybiFGDWlrJHKQM8Ap3ea774cPkoZJsUwnZMWoeGcQW+p6?=
 =?us-ascii?Q?I/OtIEz7a1Fwsf+8I9kIBOZ9+XM2jOLh/hjGf742nl6+MGuJAl+w5rc8Q9ET?=
 =?us-ascii?Q?JAYlbTbK5vwyM4xIpXy24JzVzbiaJTX89MeDt/AQBJ14EEso8kGblk/f2JKy?=
 =?us-ascii?Q?kmS9JRCGBW1rEmiJGBxQSGTXiA/eelFekMSu0LiW9nmQPwiZVCTXjTF76OrN?=
 =?us-ascii?Q?NsX0jXfI/ouW7D5bKW3OZtc3fO6fkvDNh3UBQSdpDQ6inpKeAxN2lmfMP01q?=
 =?us-ascii?Q?C7sV6OckFBhtT7u5/PueyREYUW0QrSTeIOXL7FWxcf/FED3EdBKBYFQvelDY?=
 =?us-ascii?Q?DjBaQF1UcL5vZ5dxnB5DBH3PE/bJHlL5GFw8/5NHBlwYre6MFQaMG3jhFy5H?=
 =?us-ascii?Q?CSuUED+V5zb18mbBZa31g+/H+NZmwHMNA6zNv75DosxPFt/ATTfcAFTh6HNo?=
 =?us-ascii?Q?3FiUfjijez/Bu4a/qSSnWw7ocvAfnOwwxVnqF7LTX8PqDnobl3jroQ6a4Okq?=
 =?us-ascii?Q?5Qef0h1ht9nUYevRT6PsHEuddv7ZUEIXeCCusRsGCV7RqP7bQabbhX5lemux?=
 =?us-ascii?Q?0IxEKbPibwxGsBLiAzlnnghJK5biKrsfvSxdpbQtjdpmKAN68M/dQ0e25TBw?=
 =?us-ascii?Q?5p3yPVQ6YsgX1ssmAFEcPAUWsOPGe/YrBMY71SY0IyS4rrJ97aceEecRGn+a?=
 =?us-ascii?Q?2bYehdVYAf/9d4jUjZhoKCKqKV81gmEGmSA86dNb237zzarjlsO6uHPVMyPo?=
 =?us-ascii?Q?I97cNalFsBl1SY8lyW0WPkIVdJ7O/5ZKgp8fvMK56MuIoCYPZ8lweJO7+KGB?=
 =?us-ascii?Q?jBoXoqO4Yi0EMCLiV/1NFU1YWxc84V7+jb6odx+xVNgKL7q8c58PHWUt/VZO?=
 =?us-ascii?Q?hdEufAc61OkA9D0yQE2uYuKLfmyj6+6QV+cnT+sHd56E3vQPjQhYW0laI6WI?=
 =?us-ascii?Q?4wORuQJ22p5h5gYqUTN/2R6wAAfbbmIPyVWjUN58G4ms4QUa6xLbuji1tzVM?=
 =?us-ascii?Q?fg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21f3820a-01ea-468b-4906-08dbce5f43e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 15:47:56.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ro5erMig/4t8Ng8c/1OhtI74PlVBqHaZc/Np9Vun5SVWaAA9pmzwnhA7MLQrw6XdLLGXMCw8vLLi66ykasDVNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds a test for binding a Broadcast Receiver to a number of
BISes after PA sync has been established.

This test depends on the kernel update introduced by
Bluetooth: ISO: Allow binding a PA sync socket

Iulia Tanasescu (1):
  iso-tester: Add test for bcast receiver PA bind

 tools/iso-tester.c | 70 +++++++++++++++++++++++++++++++++-------------
 1 file changed, 51 insertions(+), 19 deletions(-)


base-commit: e347792f41a8ab2cf4f789b6544a4f8ec8464a53
-- 
2.39.2

