Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1737CC433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 13:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E68852311A
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Jan 2021 13:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbhAFNlO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Jan 2021 08:41:14 -0500
Received: from mail-eopbgr60060.outbound.protection.outlook.com ([40.107.6.60]:34211
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726073AbhAFNlN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Jan 2021 08:41:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMofPgUhwmKHbGc7yOtuDSQc1OM09ja9N44VqgeabKZU4qfVH+PbUGH7vN0JaZDej3PW9YEDjTV1ceyE8Y59YK38Z/uCXKffkigtxYZg2dLXK+DOsnlUub1xlQIF1TAWGMkyuEMEBHCPDY+8zo3j6S9abtIqHCwzMvdeDdJyKfUm6z8tduGe1uPqNKMiwur5dqHCYUEH23XKH/wzL6DXc2l72kjyAEeKYedSb4Z4GjYR8WFljCiF6ZEy+tNvbVqF5n4cWisQoCe1+rMrnu/r3lM1XD5YT3hFY/f1BxPQbyWcXNAUv/lW1bz0hlTKqgfEV8xYglrsljTmCaXOc815OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enydneVYtQFlqHohhfrC1oWJDdta6GKUtH+G/bj/x38=;
 b=MA+AIQY3T0Infy+r71TPJvACSfBhDw7ovZ/6BamhajbdipjEzFWyZhq4hg8ax3ASWEYCxB7p4R6aqDtVuSWVS6GEJ8e4DpsXGqUU1AygwigJvTJR4/pO/7pq/Vk+O/BR196ZsCbSpbP/qD2ehaf3Xb4P99wDVjAAfABKq9lSGTKzY2qy8pAQp3tTuTyrQGhi0Nu0t0nWtuuhYv2QIzrNCI2uXQiwD3w82Bs2rLWar4ao2xUpTLbJtbgJbQXJVUY32cLZ58H7pFj2uyCAtIm3tPismUkbAqtsRMsY+6SXR/1w9HSyQBvhbg5Wx+YrAFUrYJ26Fq0F+4fC54NrXTYyNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=enydneVYtQFlqHohhfrC1oWJDdta6GKUtH+G/bj/x38=;
 b=NXtOMMpZPf3JVqi08l1xjbyM9Wj8W424RJxIOXZLaa7k7qikFjYDC5Ijy2hxC6+J7C529ONG0moqLIqQoWQlVDBX6UPHZNGIazm20y7mZbEWihGZusEyrai6p0QlY0i/r4dB7TGAIyVcnZfO29NLcRBLJgB8mpMWo1Ujtzdl55Q=
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR0402MB3360.eurprd04.prod.outlook.com (2603:10a6:803:2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.21; Wed, 6 Jan
 2021 13:40:24 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::28e2:4285:5d7f:7a82]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::28e2:4285:5d7f:7a82%6]) with mapi id 15.20.3721.024; Wed, 6 Jan 2021
 13:40:24 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: BT large file transfer failed when do suspend/resume test 
Thread-Topic: BT large file transfer failed when do suspend/resume test 
Thread-Index: AdbkLWygZS16CF8vSlqlxcAFRAOtGQ==
Date:   Wed, 6 Jan 2021 13:40:23 +0000
Message-ID: <VI1PR04MB496003E449FB10B12959ADC292D00@VI1PR04MB4960.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: chromium.org; dkim=none (message not signed)
 header.d=none;chromium.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.71]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 71037d42-89d5-4007-9126-08d8b2489e97
x-ms-traffictypediagnostic: VI1PR0402MB3360:
x-microsoft-antispam-prvs: <VI1PR0402MB3360A83F13C2E16724F9824692D00@VI1PR0402MB3360.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSBbb8IFYhs3i6FLWhJSD9/Yo7kHXJhjEt3sfltzweycpbjDr1I1c/Ci3Jiz6IyL/q+fSRrEtwD+zrpzYtJqph9uKUn5Cx75l7Dcc+C+SI9JsQDkh4Kzm2qwujZA+LXjlVjpEz89c3kTOgxJg4Nn3HqdhjzUDiWnD6XyzDbRvr8L6RbJYBnJsefuL7IGHE3aB+DRag4oG2wea8LYfgeM9ofyxU28s8Q+SGyn5E58zYGqV2kK6d0fDyBONf1JgzGHPe+r6oHd/2dTlHczZcp1hdTSU1kM0XQhJhurIrYE5CYBREZOiA7I7S0mi2CSPrmUCqEgi2kYVJdxri8KkrzyQMydqozsoSN7v2IeSr5oUMFL3jtM2umTEo09lD4zf87wUAqbgDOafZxxnHbSYg0Dgp7LLm7J0NqjcI9eqi76X2A1zD8Zek+peXnJlNhLp9JDeVPUhTS0T+hQ2WvRb8mNig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(39860400002)(396003)(346002)(136003)(4743002)(66946007)(66446008)(26005)(66556008)(64756008)(66476007)(478600001)(8936002)(71200400001)(5660300002)(8676002)(4326008)(52536014)(2906002)(76116006)(6916009)(6506007)(86362001)(33656002)(186003)(44832011)(316002)(83380400001)(55016002)(7696005)(15650500001)(54906003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?867X2zu189HI83ur0+pnGzceA4YOB8dDTwpLXyvMNlfED6rjxDOvKohucuaP?=
 =?us-ascii?Q?+CEQ+a/3/LNwHrMrHhPq3p1RnIbbsnLiWILRE+Eaw37D5KGDW3YnBFhJsBjm?=
 =?us-ascii?Q?nw8PdkLwrvUVd7GL67unaFQldA50hfl0sJT45WWL7rMHNFKkzJZFpGexScjW?=
 =?us-ascii?Q?HOhjj+hvAzhw+ugo28DHO95viBvTE6i0QGqEz1iLNKdqlZZ2yepJGibGyDYQ?=
 =?us-ascii?Q?2tj3H20Did0TVuDSoUa35jb2TjQ71G0t8s9kLv/ZVFOkuNbn41V2/MOZQL7e?=
 =?us-ascii?Q?HNN11HgGBujng3W2yNGrJ34gsVL+EpMPT1Uy/7goQU56tZpfakA+/h9/Uj1X?=
 =?us-ascii?Q?Z623YH6O0Ra2Q4+N/zAoFim/0fOxoJZzKye1enjfl0505QCiVYhhwf2qXOau?=
 =?us-ascii?Q?6YJizhUwiD+0O1SQ4yh6QP+/sq7S7JHuS0oUsW/e23VQ+RKvwZgi21VSSJIV?=
 =?us-ascii?Q?j01tkOV5vLZ6bJ6afGgQ7VzO0Qu8I74aKOGiCdjRrX+1AfljAHPnY+HyMa6O?=
 =?us-ascii?Q?Co4WCqQCjKwG6/V8Q7X1BhmxpIRVCeyhEXP/1f6co3qdoYy6gAR5mfiqIHa4?=
 =?us-ascii?Q?TjfQDhNOXCb7FGZasUdAburVBcyiOdRLEkiu/NSrnCn1S9ZnJpR4WYwCCFr5?=
 =?us-ascii?Q?wsRviQVT/ykjA6Cn4vqwwwYFkO7XP+8jZnK5EJGh9XEoPjRFywOmcpMkCzga?=
 =?us-ascii?Q?PzwgvGPb9uXc1HzuOTn5xbU9f26K8O8fdDfjY/lDEtHltR1xc9AGnKoi1OCJ?=
 =?us-ascii?Q?S3DjcN+f+GVGBc1gvS0fXPbWv7TO9/LEY8HjJeLCBfgOfXzOZMohWTRaLfe4?=
 =?us-ascii?Q?4v6Mf42RbkDzEaVG4L0OVl5XiHZDShl2LAmCs8xQofo/E0WvOO3SeBYZeijW?=
 =?us-ascii?Q?do1rnNd+ntsKKGbOOmFnhRDeaWLw6AMm4GIrFQCKKMcKhoXDdP38voO0uZQ7?=
 =?us-ascii?Q?mH7ckZ3aXAdvE0y/MQdcmrvhyt4rcJnVmPcLOgNbjVU=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71037d42-89d5-4007-9126-08d8b2489e97
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2021 13:40:24.0188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /LH8aG9h6CEuxyrp4Jtr0AcdVZIIf3VkGSas5Hu0KvpxMpk0n4XDoCirn6EP8LzRW9X/rPaf6wt9MsQvZWh3gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3360
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Abhishek,

I want to ask you some questions about your patch: Bluetooth: Handle BR/EDR=
 devices during suspend. (https://patchwork.kernel.org/project/bluetooth/pa=
tch/20200311085359.RFC.v6.2.Icc7c35e1cabf10f8a383a009694987520f1d1b35@chang=
eid/)

Platform: L5.10 + Bluez5.55 + Marvell BT chip

Background: Our test team usually try suspend/resume test when transferring=
 large file through BT, to see if the file transfer can be continued after =
suspend/resume. It can works well before L5.10
But we found on L5.10, the BT connection lost if we try to suspend/resume, =
so the file transfer(through OBEX Object Push) shows failed. Then we found =
your patches when debugging.

Questions:
1. Before L5.10, kernel always keep BT connected during suspend/resume. So =
why we need to disconnect all the BT devices when system suspend now?
2. I found that the device been disconnected due to suspend won't been auto=
-connected after resume, shouldn't we get the BT device auto-connected afte=
r resume like wifi devices done?
3. For the large file transfer, if the BT been disconnected during suspend,=
 the transfer will fail, do we have any methods to avoid this issue?

I'm new to Bluetooth, there are many things I don't understand, looking for=
ward to your answer, and thanks for now!

Best regards
Sherry sun

