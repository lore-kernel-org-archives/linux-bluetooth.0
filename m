Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CFEC4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 06:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiLPGIH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 01:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLPGIG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 01:08:06 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5FBA2EF5B
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Dec 2022 22:08:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fijfLkViynpvhqAI6HixmT/HsIK0aD5aLIZe4peNrf7+05X24kfA6Kv/dlpTewQEVlSFEzs2CEICQ62hOH+l5tHKwXauIGG84nBs602vN6wbiDtHMPtunT5q1zxBTHpVk5TnzM2E7ztsn14yDRHqxXz2iRj5D5ZYDUiXyxQ06SHyg9N1KMpsHmLbEBKFebOS97ePRX/dqE+QFdAmC9VPVenLBm7QKRHJG0Z/BqhdQiVkOT80kXleihPtJaHD0QnqfxjDDPCkny+6t1iu076IqA1UOTkqlgqkua/Tlq0/7nnNB/uB89JNytAIf4Fruoh53tPDdfIvdLQLYAEhTmeCoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8717RcjJlh9SViVxRz+POmFPaBxe0Trtx5MLXOtRSf0=;
 b=GKFwKDdCEiTglJRVP5jd1qjn2C1y2WmnQhldt5m3auAayxxq8qJzaJS3IKdxFD86GO3wDGtZGa844/tLKjm4SR0nGIS8Cg9lhHW92gh/sCi6WkGwI+QJhgeDhZsVF6zr0qzDQe2n43RJgahf+hbl8bZf718d6Ogjoi/vQgLk9tLM1RUVntnFft09mMYNj1Jf7bVwb1o4ANHeVZM+YNI1iTHM7PLInUD/wLFfTCIs6p0j8do/gtlc9cD7IYECwt0TEIXc61UfKzDqlDFxH6YZH1aNBWak2O7X75kF4ZHCQBwBAx9Kqpvjx9PfmHrEt6gV5EipEaewYGtkdiYGf1u3dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8717RcjJlh9SViVxRz+POmFPaBxe0Trtx5MLXOtRSf0=;
 b=Yz/GDzB+kH/SIJ1iltm1dGWKBEo7GCxHzxwd4iEmpG13zn0h2Fn3DHndXO0QXjvtZpBAgaE+liURkZb07B+Dk8YffawAD3GKZOUBqSRapCKcF6F4KBJkzqJXrhAcj6DuPlmK5LkTgi1FupctUceW5GPqwFn8Br3AQ0UzIYIVfRo=
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com (2603:10a6:20b:43a::10)
 by DU0PR04MB9345.eurprd04.prod.outlook.com (2603:10a6:10:355::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15; Fri, 16 Dec
 2022 06:07:58 +0000
Received: from AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de]) by AM9PR04MB8603.eurprd04.prod.outlook.com
 ([fe80::7686:5382:16d5:c6de%8]) with mapi id 15.20.5880.019; Fri, 16 Dec 2022
 06:07:58 +0000
From:   Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Amitkumar Karwar <amitkumar.karwar@nxp.com>,
        Rohit Fule <rohit.fule@nxp.com>,
        Sherry Sun <sherry.sun@nxp.com>
Subject: Re: [v5,1/2] Bluetooth: Add hci_nxp to hci_uart module to support NXP
 BT chipsets
Thread-Topic: [v5,1/2] Bluetooth: Add hci_nxp to hci_uart module to support
 NXP BT chipsets
Thread-Index: AQHZERS+/zcyDrvzPUisOAXT7Jy2EA==
Date:   Fri, 16 Dec 2022 06:07:58 +0000
Message-ID: <AM9PR04MB860367B24D3866515C206953E7E69@AM9PR04MB8603.eurprd04.prod.outlook.com>
References: <20221215142150.240712-1-neeraj.sanjaykale@nxp.com>
 <639b31a8.c80a0220.85898.f5be@mx.google.com>
 <CABBYNZKpJCT3VhRgc-a58utFOm7mFz6uOQayzW_+pEbfhbfGqQ@mail.gmail.com>
In-Reply-To: <CABBYNZKpJCT3VhRgc-a58utFOm7mFz6uOQayzW_+pEbfhbfGqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8603:EE_|DU0PR04MB9345:EE_
x-ms-office365-filtering-correlation-id: fe0f0232-4f44-4904-b5c4-08dadf2be154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /uuG5W5YnjpaSzB06wKWx5fLaIXsqMz13WCpxJ9qMHW12F3gNlOczT8MukG9zOwr9THHVhFvQRA/CG+T/mMHaTdLwvlpKPDpAj6TwGKlmjMv7BIb6yMYX7JJr/A55/dDuRmusD9IMnUErDyrAWOVL993dENfmhlyQLwWrjFIUyxtAdH/aZg50xODbqcLakSwGAR/J516pQyEimT4Qd5xbNwrtJWuVaDt/SQqCPsz+pMfwXToYJiIydS+oGnaj6F/Qe3D7JsBeRpqH7p73UjDMo+xmODtxObPpkKXb4kUABcRD/eKP4HWNCt2t7Fc1PQgdY0Kp7UwQA44Z9/TGnuz7Y0CwM/20pry8hAbppOAfMaegG2x3KUyUm0eijNtRqp1QxtmLZ2KvMm5sm9Fwj0JdQoDKkzImM6wgFbhXL/aHqxxL5x+oVi17Str+4Q8otFPbVCjOi6fL+eaqYEEVkYo43iKefNOyyVdzD5Bnb0hwjuIguakQ1zAvR8RdmtNZd4urPhrm9HAKXIauq8B4cmcXNuYort/kMZouDhj4wB9flUDkhN7osJyU/sHEdsUlQdIudYoCR74i4bwjDZavZAct+a3ycjRkNyaPBiI/j3W+0hLsemJPk+pjCUXoZU6bh6HBwpFH3ReauGSel4ghUCSAdTzoPVzM6VwysdAgCe1DtDA2Fwkxi09PBJ+cJr7xBcvesQQ2WTsh0o7vB/9DjwpUYoU1bLtkA8AuqmDiVLQL2Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8603.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199015)(478600001)(966005)(71200400001)(26005)(186003)(9686003)(8676002)(4326008)(66446008)(64756008)(53546011)(7696005)(6506007)(45080400002)(2906002)(33656002)(316002)(54906003)(83380400001)(6916009)(76116006)(38100700002)(8936002)(5660300002)(66946007)(66556008)(66476007)(52536014)(38070700005)(55016003)(86362001)(122000001)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JBKjFaP3wfAWzwwssxv2pzK5xJTMf3cKZddcBXxdLIa3EKzURFGh/JpaSbJi?=
 =?us-ascii?Q?m+KH+uiW/I1OE3ZdIr3jYeF2Xvi2xbgvhdnNmK/WchyuW3xKELPEeww0u/QI?=
 =?us-ascii?Q?CEKwk3xwAIUjx+ShhBYhZjLGnsn6NA0ydjdsdFOpi6wiFU3bKNwojZ42DBiu?=
 =?us-ascii?Q?uCu4+81AhlAB3LPSDG/O683VDUGQIM+n5W00n0JxyYtTKIDlnO4p5UT7g81B?=
 =?us-ascii?Q?2nb8NcvRwSoann/mOO9KRbWUwhxZuefLvGnTezwEjbEmXASNUAxVIDR2Vyjp?=
 =?us-ascii?Q?5FZo0Zh3FvXNKhfwYPZwK2bpEE9xHf7B4PLk0YZdxb5nnd82raf0UIikJBet?=
 =?us-ascii?Q?qEm8szzNI7YqWg9zbySXXa6GytrdNzUbp2X9LlmLiTw29C02EVV+pSWTTkVJ?=
 =?us-ascii?Q?AVqGvTc2CwM04t37RywkxmNRLVp3PV5KME0ExKhCUxXLhZxdL/hD997zdlgA?=
 =?us-ascii?Q?qNI8B/ePLG1xpvuFekUJ0kvOKgjpd9pBf+Y89o5yHJL2qYXHE8+GW+E0NLzk?=
 =?us-ascii?Q?zqgi0pvb8CNloDuNPCFgmotqz8kNqs6j+Im7cvjTX0xargTRRKzdfEaurpfA?=
 =?us-ascii?Q?SVqPrcjStbeGP98FYVxI0PbTebP6QYR+2oh7+S2aDkooPqMoWBvmnEe0dTZf?=
 =?us-ascii?Q?pYvTtPL5iXM4XmuKQFzedv7Q+u8qLwYKkqER8SOtzJihqPUuctLM3PJAu0ib?=
 =?us-ascii?Q?4VlJLLJgfYQxTzGF2Rz8dlnAwt2QuuDpmSRPzmA6y69W7zt7xVZpDuvzbHtc?=
 =?us-ascii?Q?2lV+EXA9A8dfda23oHvg5ocxl4COzFwIkc5JhygWV4KqSUtW3IILExJfHmWc?=
 =?us-ascii?Q?Cyf32EDTXySvqBUsN1VX888I9z4c0LOGl+Jrwf7jCw69H2LxldbZsJrC535I?=
 =?us-ascii?Q?Rj7HlMyCrLh+nVMdnd3FudxnwFMwZZCK7QX3iLnMjU4r4wrUKCIapxZzoObu?=
 =?us-ascii?Q?M4JzBnBvQ/xhTmV2DEZgo9Uj2sLVIe0dODXj6OLEx959+WzLqOQ8O/dSGPvi?=
 =?us-ascii?Q?xu3mgN+jufzO+nt6PwGkcmomrhVoQu1hYi/f5h/kuYgxOVSHHNP1HFtDfXx0?=
 =?us-ascii?Q?6XynGKaMGXsx5DiqlDawOGH06CW6z3Pa9LtrbUH9fDraAGRUNteJdmq2F/Ks?=
 =?us-ascii?Q?iF+G3ZH56YQF+dMvuILN7hkqkeVtfDBBX6hgh4vYaSOmmhiLfABzuFMJo6+h?=
 =?us-ascii?Q?u35IqzHgq8xc2CEBn7Sotb1AUjwtIhjaQbr0VJmLODVcwidxuWP4r03qw6nx?=
 =?us-ascii?Q?kFO/nH3TPZMn4mCe7YCh2Ea7MPbGgwXKVG56DXCWjd039FwI2fk51pL6gOji?=
 =?us-ascii?Q?wkfD9/mkrr2wiTsv3Y9PQF5YCm0BFvkX8DKCjx7QwPxmO6KsIk4k6J8wC4LI?=
 =?us-ascii?Q?iv0TB71hUrz9r/kV6I6aRNrm7Kf1+RPz7Xh7JynnNkJ0QSl6nz0vH1T+rAYv?=
 =?us-ascii?Q?tsYbMsVq0bGOUAa/xVbp3itH2FqLZ8EqNPmoZnMq3tHvca/+DRnFnL+Fa225?=
 =?us-ascii?Q?L2czV+8kU4y7NlftORr6+XxwhxKvPaDT0/LfRbjbOvBKDwDTyKTHHGSgVMOU?=
 =?us-ascii?Q?Zk4pg9KytWr+XQ2dg6GImYkke8Em6G6mInM7bVGD?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8603.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe0f0232-4f44-4904-b5c4-08dadf2be154
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2022 06:07:58.3047
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Bf096dJ8VX3CUUCNB4TlIq+mFL7NXId+MRun/KFNggYTWEduNbh9ewttDCtkpR2wATpCLANTOn183P0/8L6VM0haYjOR3qpMoWB4GKi9CM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9345
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

Yes, looks like I was mixing the 2 patches with [Patch v5 1/2] and [Patch v=
5 2/2], since they seemed related to each other.
I have re-sent the 2 patches again, this time with the subject [Patch v5] f=
or kernel changes and [Patch BlueZ] for userspace changes.
Please discard or ignore previous patches and consider these 2 new patches =
for further process.

Let me know if any concerns or suggestions.

Thanks,
Neeraj

> -----Original Message-----
> From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Sent: Friday, December 16, 2022 2:18 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Neeraj sanjay kale <neeraj.sanjaykale@nxp.com>
> Subject: [EXT] Re: [v5,1/2] Bluetooth: Add hci_nxp to hci_uart module to
> support NXP BT chipsets
>=20
> Caution: EXT Email
>=20
> Hi Neeraj,
>=20
> On Thu, Dec 15, 2022 at 6:46 AM <bluez.test.bot@gmail.com> wrote:
> >
> > This is an automated email and please do not reply to this email.
> >
> > Dear Submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing lis=
t.
> > While preparing the CI tests, the patches you submitted couldn't be app=
lied
> to the current HEAD of the repository.
> >
> > ----- Output -----
> >
> > error: tools/btattach.c: does not exist in index
> > error: tools/hciattach.h: does not exist in index
> > hint: Use 'git am --show-current-patch' to see the failed patch
> >
> > Please resolve the issue and submit the patches again.
>=20
> Looks like you are mixing up userspace and kernel changes in the same set=
,
> please don't do that since they are for different trees and our CI get co=
nfused
> when you do that, for the userspace please follow the instructions below:
>=20
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
er
> nel.org%2Fpub%2Fscm%2Fbluetooth%2Fbluez.git%2Ftree%2FHACKING%23n
> 98&amp;data=3D05%7C01%7Cneeraj.sanjaykale%40nxp.com%7Cc3b4bb8a07e
> d425c542208dadeddb69e%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C638067341083595400%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wL
> jAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%
> 7C%7C&amp;sdata=3DoBUSpMYxr%2FlbbcAxWRK6IdB%2BGAMNX5n1u1khGGx
> JqwU%3D&amp;reserved=3D0
>=20
> --
> Luiz Augusto von Dentz
