Return-Path: <SRS0=BOlL=2Y=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F765C00523
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 07:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F37E2464E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Jan 2020 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=RFPros.onmicrosoft.com header.i=@RFPros.onmicrosoft.com header.b="hJ2JE/Zm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgACHWc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 3 Jan 2020 02:22:32 -0500
Received: from mail-bn8nam11on2062.outbound.protection.outlook.com ([40.107.236.62]:5600
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725890AbgACHWc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 3 Jan 2020 02:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nll1L3L4w2mNwJX5YTzZ/0YMqTdt9ywqvGJJtSeR1R1Mk549WCesoRS5ICeChiZpXpRFXHpz1FSHOh2k64iTve6vW/yWqImWcXaVHM7Y3mOA/XZscbk1twSSUhpGOxJZ2F2Azyd/JFIv819soF7DBPOjUN3K473XrWEJzNA4+g6HnQL6rBBdKuGQL9fdnqiLEwRpPLRtXzl3r5JtOBkmsJ2H6YqQLZ4NyTezDVwloywdvOQtBIZE+vCH1mZAAzQR9+m7LTJLDZigkHOC3KuGraW+VLSVdUDYjbnC/1cyFsfHFIx7T9all53y7Mn67ZlE3rUDD3ILt9i8FJ9KuCbPlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym9Y9nKRAGs+oh2hVluEAK+5tq+phxDY1qKoNRafZPI=;
 b=TwJcANw8IL2z+wZKiBoiyEK3O2PekOK/2iuBuaUxPe15KTjrzstVydwCjSk+hUpQYsT7QMyCOoANTJVBdiNqmOS7r0lGDnmYgPBz8BFGs6KKaFXhhm8OKIba4q0ccXTMbfYjkUk6oGzfYCRKY0Eau4RYdjMSBNM+XyO1sgepUw9a1n1NwnksBpaEHdZBcneNcFT87dBsGMi/+Ld9b9wEMFQ09DoMRymy0ZwVHIr0P7XrUoe/B+96ciTj7b4epFhhL3/u/k7MXNVqbKRr2ED8c7cVDy1Yd9XgIblm5pABibOx9f5/H9LWb0sFmuz1HrIoM7cI2yV53j7FcM0HFwek1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lairdconnect.com; dmarc=pass action=none
 header.from=lairdconnect.com; dkim=pass header.d=lairdconnect.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=RFPros.onmicrosoft.com; s=selector1-RFPros-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ym9Y9nKRAGs+oh2hVluEAK+5tq+phxDY1qKoNRafZPI=;
 b=hJ2JE/ZmupNIeyU0+pPzAQZsh4vnuVH9QdXQR+CeoK+YCjfPszvTdoGaB9dPi6OBMZyz0GIQNwKoN3KAh94mg34lfMx6JlSKgdDJK4Qwz8qxaaEca1ogRUlH/cZ48lNLMgylJYzf82BDD4tpOjytzQm3w5AayAvFhbZocCwTPsw=
Received: from DM5PR14MB1385.namprd14.prod.outlook.com (10.173.223.13) by
 DM5PR14MB1468.namprd14.prod.outlook.com (10.173.223.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2581.12; Fri, 3 Jan 2020 07:22:29 +0000
Received: from DM5PR14MB1385.namprd14.prod.outlook.com
 ([fe80::95a:5934:c7a4:d915]) by DM5PR14MB1385.namprd14.prod.outlook.com
 ([fe80::95a:5934:c7a4:d915%6]) with mapi id 15.20.2602.010; Fri, 3 Jan 2020
 07:22:29 +0000
From:   Jamie Mccrae <Jamie.Mccrae@lairdconnect.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
Thread-Topic: [RFC 2/2] Bluetooth: Add BT_PHYS socket option
Thread-Index: AQHVwZGPa63zSU1M/UaBS0dpx7czZ6fYiSdg
Date:   Fri, 3 Jan 2020 07:22:29 +0000
Message-ID: <DM5PR14MB1385EC175428FE2F702258FEE6230@DM5PR14MB1385.namprd14.prod.outlook.com>
References: <20200102172447.18574-1-luiz.dentz@gmail.com>
 <20200102172447.18574-2-luiz.dentz@gmail.com>
In-Reply-To: <20200102172447.18574-2-luiz.dentz@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jamie.Mccrae@lairdconnect.com; 
x-originating-ip: [81.148.185.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9f778e7-369b-412a-761d-08d7901db0ed
x-ms-traffictypediagnostic: DM5PR14MB1468:
x-microsoft-antispam-prvs: <DM5PR14MB146830ABCEAFE6B0928B4501E6230@DM5PR14MB1468.namprd14.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0271483E06
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39850400004)(366004)(136003)(189003)(199004)(5660300002)(478600001)(52536014)(9686003)(55016002)(86362001)(71200400001)(2906002)(76116006)(316002)(6506007)(26005)(81166006)(64756008)(66556008)(66946007)(66476007)(66446008)(7696005)(110136005)(33656002)(8676002)(81156014)(8936002)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR14MB1468;H:DM5PR14MB1385.namprd14.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: lairdconnect.com does not
 designate permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ePPW1fMrwozKZT6o+iaqSTdqUnliTFvGU0v6NGGUsbaeu1eGbNyzkeMuJnrVoKEZ/rgO03w0k80sLuxZVXUSkZvf6rEM9ftuPF17pOTFG5ZvYn5JhlUcfr/fazBEkTUCmlSk1mUpcGfSTwCjJlX6795ENAFUYl7ZQuSRCz5Ujq8cnRRi/+eE7S3uSNYx1pU20RnWmOIdojbKdgzP/JH8x7kZvVrab0pvYk1bsA8fE0pXdyDz9MOex3cTYA3qhI909t0qI3dQim/FqU9IzmviA84vppHd2VfNT/JVz9ylDfVm6x/AIZ9CV5Dz6EiJ4aqJgdIAEbCAaQXnzVVMAsLtot+Hjgon0Vn/WueGfscXsvqggnFbxT0E9d4+qK6irWlz8eR9dUr/B4CrHotGXMi2Vv2ywWuxC6MjCm6dXkxsvwx3/kdkBNuZ+gYKJ/jJxgwR
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: lairdconnect.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9f778e7-369b-412a-761d-08d7901db0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2020 07:22:29.2128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a67ad7fe-2b14-4d12-b58f-bb509b58f338
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: udAKqpV57oYRbjrteX2y21JTCkeJi0ox6Jg9K5mYk5ALW64ZXEe77Q01MOKKNweVrbqV/elP474f8eJB4dr+8GT/tXgbk+GM8O8xNk4Oz9A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR14MB1468
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bl=
uetooth.h
> index e42bb8e03c09..69c0e7eb26d9 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -121,6 +121,23 @@ struct bt_voice {
>
>  #define BT_SNDMTU              12
>  #define BT_RCVMTU              13
> +#define BT_PHYS                        14
> +
> +#define BT_PHY_BR_1M_1SLOT     0x00000001
> +#define BT_PHY_BR_1M_3SLOT     0x00000002
> +#define BT_PHY_BR_1M_5SLOT     0x00000004
> +#define BT_PHY_EDR_2M_1SLOT    0x00000008
> +#define BT_PHY_EDR_2M_3SLOT    0x00000010
> +#define BT_PHY_EDR_2M_5SLOT    0x00000020
> +#define BT_PHY_EDR_3M_1SLOT    0x00000040
> +#define BT_PHY_EDR_3M_3SLOT    0x00000080
> +#define BT_PHY_EDR_3M_5SLOT    0x00000100
> +#define BT_PHY_LE_1M_TX                0x00000200
> +#define BT_PHY_LE_1M_RX                0x00000400
> +#define BT_PHY_LE_2M_TX                0x00000800
> +#define BT_PHY_LE_2M_RX                0x00001000
> +#define BT_PHY_LE_CODED_TX     0x00002000
> +#define BT_PHY_LE_CODED_RX     0x00004000

My query about this is there is an option for LE Coded, but LE coded can ha=
ve a data rate of 125Kbps or 500Kbps, is there no need to differentiate bet=
ween the two rates in applications?
THIS MESSAGE, ANY ATTACHMENT(S), AND THE INFORMATION CONTAINED HEREIN MAY B=
E PROPRIETARY TO LAIRD CONNECTIVITY, INC. AND/OR ANOTHER PARTY, AND MAY FUR=
THER BE INTENDED TO BE KEPT CONFIDENTIAL. IF YOU ARE NOT THE INTENDED RECIP=
IENT, PLEASE DELETE THE EMAIL AND ANY ATTACHMENTS, AND IMMEDIATELY NOTIFY T=
HE SENDER BY RETURN EMAIL. THIS MESSAGE AND ITS CONTENTS ARE THE PROPERTY O=
F LAIRD CONNECTIVITY, INC. AND MAY NOT BE REPRODUCED OR USED WITHOUT THE EX=
PRESS WRITTEN CONSENT OF LAIRD CONNECTIVITY, INC.
