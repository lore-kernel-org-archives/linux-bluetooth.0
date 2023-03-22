Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D647C6FD1F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 15:24:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjCVPYF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 11:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjCVPYE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 11:24:04 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2045.outbound.protection.outlook.com [40.107.20.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8C72BF18
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 08:24:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F976FuiDfzflKVzdh7wqwiqDT8ObJ0p4Fk6Sy0gUU0GzHTklVcllcEN9aHBE5LQ8ax3U0Zr7VHUGpywJ6DJ1G/td2fseehqw4SoXWzNJ9rPuDo2IH5f+G/+sVD56klIOP/S9xaI5MQcM0LVkHHWLJLmwxIJUxz5iry0L1pgfNd/quithKYr2Pfc2B6JJML0Z5vZHWmOy/L7Nm9W3t0x/M9txFHysy/y45T5QkK9lIY2bheai37SZu9mwAjUZ8k7W2vJV7sgDinI3x7bmb2Txn6kox+8P8M6JGcYrFFuSG+NsD0ZE5H/eCQG//9PhWjST/q7aYYZKgPxfcTf5DuQA4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4DF02x+Ki1XWi0mqMs1qUYid4XEEhOzQnrpPql0htw=;
 b=j/uxKt7r7Y0ssMl6GYlbppmIUyyqjZh2JoiW7wDVcjWdeGQGzknhJGzYY+HmDuksjL5aNPfDaqJh9nrUaN/nJHSO4qcAwU76nyT50xbhsI26XL2WrFDwYjZj4mdEJkHK+QjRWhM77ejwOF2TVVhNNSBi4/CMEMWpEOo3SJ6NJ6MfxMrsoRP89kfOXazEkZ5j0/MQsHifMpYKuGoF+s7LruBDMp9JJMMhp5ohu5qF2ZDbFoVGu2eQeCUx09ScmDlHrZ9w7CdOL46rAwmCuZi88FAzOVDySjbxiw1F8dvPdUrj4fyfGF7w5jkpar37MpZ98oR5lYJHUjDruMpkDhMBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4DF02x+Ki1XWi0mqMs1qUYid4XEEhOzQnrpPql0htw=;
 b=STnlW644fsxDFjpHz2ldOQEBR7OR28hPLeknChSxvqSzoTuxWbpIWGlKA7XOqNpiTbraXeQJYEJCJ8eSlqeBrkZkqGvSrv5Mq8YSxTJOppfcGcEQCYVOUXTPmxbNYTeJ5ftfdEdwBAwWCYxNqEkYGd1HWISzZTDBOO9ASH5x1AA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com (2603:10a6:20b:42d::15)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 15:24:00 +0000
Received: from AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98]) by AS8PR04MB8898.eurprd04.prod.outlook.com
 ([fe80::e463:bd8b:f1cf:9a98%8]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 15:24:00 +0000
From:   Iulia Tanasescu <iulia.tanasescu@nxp.com>
To:     luiz.dentz@gmail.com
Cc:     iulia.tanasescu@nxp.com, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/1] Bluetooth: Split bt_iso_qos into dedicated structures
Date:   Wed, 22 Mar 2023 17:23:47 +0200
Message-Id: <20230322152347.42109-1-iulia.tanasescu@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABBYNZJTvEFAESfLqebuUrq6mUAw1ZcQbSMqpfgbMLkGbH_k8A@mail.gmail.com>
References: <CABBYNZJTvEFAESfLqebuUrq6mUAw1ZcQbSMqpfgbMLkGbH_k8A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0025.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::20) To AS8PR04MB8898.eurprd04.prod.outlook.com
 (2603:10a6:20b:42d::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8898:EE_|AM7PR04MB6952:EE_
X-MS-Office365-Filtering-Correlation-Id: 179db44f-5011-4009-d747-08db2ae97683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: txkV++dQsPq3RTVwplRCzPvikXqvOSSd+C1HEx7sQO7mIKlYnfsVzH3hsQbQqAT9kp5MasuKXB230WWRz6msXJvujjKyZCskaPaKz+JJ1FRd56+abmKnijjpZE0KtY2twyMVTdmaVFNTJZhPt2wAc4tATYEXYBiwKGcSxHU3cHO5ew21ejLg5cB+R+t1wf7LNI2qj92jsYJeOumvfPDKEpydUioaQROWlX80UXbkh7+j1gBzSsvk0ntmMNdx3HByo87fMVz+C3Hs8Igx10THS+cBlVZbSmaXII7o54GmvL8ierP6EIZJjSd+v0sUnxcKIOa/EslgC3ZweGCDw0OfQ/wWgoqjNHAmkhgeZ/17NEfrUyb5+cTibpYRKRPdLwhHPcpnvjolm6pMRG8yf/EdjpGexm+qWTZgllfSfD6uQtVKoMVAEnc/OAo1e+7LQeKra4E+S1roa073Nt2zIvQ2Eh26SbWULFoveLliQUES1PepGxO7+4M/pgsN+82+l4nnFwNLif5mm1+WLvJXFvx4k5nOCwOWEsebMhW+1t4i/USXUFwlDFt4VUjCnEPOrau62qg75RP8AKj7auJyYuUDGgSYJVMjBiejvjxFCOPqQ2LLjdFqrVb79FeCkryZr2xWm5blO6BJZdwuIo2L6qKLmtdeRmP771aUwQamN6YMDFCNO0mcstX0+UCfYWl0KM9MAjYnfA7mEiZ+icoV4bqjaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8898.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199018)(8936002)(44832011)(5660300002)(41300700001)(86362001)(38100700002)(38350700002)(2906002)(36756003)(186003)(4326008)(83380400001)(478600001)(6666004)(2616005)(52116002)(6486002)(6506007)(26005)(6512007)(1076003)(316002)(8676002)(6916009)(66476007)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G9GEvMP0vvRO7ErC87uzV9mDJZFURFszjrMC5PvZaiVH10YLBdVFuVq8XOO+?=
 =?us-ascii?Q?MhVIIGl7e2VoDlnOkg1Qm4kJEbM9IdlxiWkqJFyhqZ1BcqYKf2y9uNZcw4cX?=
 =?us-ascii?Q?eOy7sieQ36gPaAeBuSe15U+tcs2xo1btUjpcE/v8iitgjgX9fnMeEGtE0BF7?=
 =?us-ascii?Q?1LnF86Myx35vzIPsaj1hdBSSFhWs+RuONW9/YO5l8F0jnKyl8l+wH7N4gk1C?=
 =?us-ascii?Q?hxmfu6Tm4TepMCb7ARLhh0CpVcKATKy1UJ1aAlLsKtrlPCr43pkraxozosvB?=
 =?us-ascii?Q?B8mfEqWGeV30gQlJR83Oqz+ELyvTTgEwNvpoTvpvAA4PHjSpBEeboUK2FPRi?=
 =?us-ascii?Q?InmWbpezHYP+5w+N4M/BYSvhXtU9xuhQmcLJIEAOcf8/RPvsyK00VQOCA2n7?=
 =?us-ascii?Q?rMzH3qK3V0EOVVFQQBo7oVj5Rj3oPsW6jMnC/hqLHqISVoLO4bDnLgXsBQ1d?=
 =?us-ascii?Q?aLEJ2p0i8Xu1rFi7ZZWUirXhkJvyBAgAKfMoPyA2+qcZKGwOAgTww9S3nrW8?=
 =?us-ascii?Q?EApt6WiwAdNjGVQM+d78pte25ZUwbmgQwEu7TrnpfHGGHFHhznrqEzrSoLds?=
 =?us-ascii?Q?8FEoOYvh7YWj0DaQmAvu9F2N8Zq8F2czU/sQPZ5l8trjT6O/Uu8bzW1wHHjn?=
 =?us-ascii?Q?5jqqVQmIvUYiBFfNnVXm/uTanEtXX3gbb00i95o8xn3xspEu04cn1S1K1moq?=
 =?us-ascii?Q?XPRgsuqpWFFSrPXplNTYTBM5tAYmBENE4AgiH5zzJChfTvUxqu6EcMa0A8wP?=
 =?us-ascii?Q?D5bhKorwclzb1uFLkUGatV3pV4l+LCha1iv1+nmhjlp0SlEC0g9Xu2mcJvdE?=
 =?us-ascii?Q?1Ch7PVS3Z5/zWhm78GsIyt7j2cxlnvGsS8sVOFCrfQkuFpd622ZyaqLBTuj+?=
 =?us-ascii?Q?UJSj6Y94kasslhQLNp0iT6PXeyPDDe7vRTb0dFuplXDaUmboFnMwZdo/CvFE?=
 =?us-ascii?Q?vU2WmFU1rcQiMGxnzEtSShLx7UFelKi7HxLadlWCuh1faLRiSXDPQHzsisQS?=
 =?us-ascii?Q?Xifu3KCDXmptJoTwMZQq0ag80yalTp/Sb8ytd2mY8Yo8lq5mmq5Ry7eQn7P6?=
 =?us-ascii?Q?3xoElL6b6EMEv+gSykg1EiMCnh9vxZ7Kg7X+/Z+ItVxNTFRSC9+YIIp4fTT0?=
 =?us-ascii?Q?x4vUkMUX0dylDvjFQ+6bc+FF1QlrlGCXzAsXzbhB+JGsPote6zxa9aVY4G7B?=
 =?us-ascii?Q?FjP4uOkJn+yesWrH9u9A5yyv6bzM8mxmlNm3QGuCOIx6Tp8BE1kWFy7Kd+Jg?=
 =?us-ascii?Q?J3hCSAY/wNeQhluuKmuzqKJ8LgoFdrABpUGs60XNKkT2pnuZk2ygXBNPrfYI?=
 =?us-ascii?Q?QJN63oc1MDw1zz4+Ec6KGFvebRozdGX8iKy69peeyeOqB4MJxwV+5iEzyEnQ?=
 =?us-ascii?Q?+e4cJN9MaJ+Qu5gmyuYw1eXJLnavPqNCBnsoGaeKnzoS2WnvSTnkk5mJdlXb?=
 =?us-ascii?Q?WpygIQP4426It/G+nCg+Ths4IpWkAxzWGKLbmbXb9pbg2CpQ0jRIwj5Xb3ik?=
 =?us-ascii?Q?ldPPgT8se+xOSAeTgUtgh87agL1+HmKIxVt5JUI9HKV9Uyivk5/zuNdJoZU3?=
 =?us-ascii?Q?/lA8c/M4BzjDzvVwV4SW192vgvaT32fmPxvLJkktQkzqtHyDSDwo+UyAxLxC?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 179db44f-5011-4009-d747-08db2ae97683
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8898.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 15:24:00.8249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JP+VfIE1zqVG4kGIMD9OKUG4/pu/di2tVwdrVZtoa5Ro39I7WZwFsorkx64q7j727MxS1RWId60rYJNGM1bdPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

I have investigated some possible ways to update my patch using your
suggestions.

I think the most convenient method would be to implement the structure
as an union of dedicated parameters and to add an additional parameter
that would indicate the type of QoS the structure is holding.

It would be something like this:

struct bt_iso_bcast_qos {
    union {
        struct bt_iso_bcast_src_qos bsrc;
        struct bt_iso_bcast_snk_qos bsnk;
    };
};

enum {
    BT_ISO_UCAST_QOS,
    BT_ISO_BCAST_SRC_QOS,
    BT_ISO_BCAST_SNK_QOS,
};

struct bt_iso_qos {
    int qos_type;
    union {
        struct bt_iso_ucast_qos ucast;
        struct bt_iso_bcast_qos bcast;
    };
};

The flow would be something like this:

At socket creation, some default unicast QoS parameters are loaded
in the qos field of the socket structure.

When the "setsockopt" function is called on an ISO socket from user
space, the user will provide a bt_iso_qos structure as defined above,
containing the type of QoS to set and the desired parameters.
The kernel will validate the parameters depending on their type, and
it will overwrite the unicast defaults if the check is succesful.

When the user calls other ISO socket APIs, like connect or listen,
and the procedures to execute are broadcast related, the kernel will
either use the QoS options that had been previously set by the user,
or, if the user did not set any options, the unicast defaults will
be replaced with broadcast defaults, and the procedures will start
this way.

Do you think this is a good design? Please let me know if I should
proceed with this implementation.

Regards,
Iulia

