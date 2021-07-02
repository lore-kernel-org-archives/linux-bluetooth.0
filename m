Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5799C11F68
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jul 2021 13:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF236142C
	for <linux-bluetooth@archiver.kernel.org>; Fri,  2 Jul 2021 13:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbhGBNws (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:52:48 -0400
Received: from mail-eopbgr70051.outbound.protection.outlook.com ([40.107.7.51]:65212
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232754AbhGBNwr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 2 Jul 2021 09:52:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quamotion.onmicrosoft.com; s=selector2-quamotion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFLbFr3RWIeFPub/5Su+b3LcVCKpRgLeensH46lnVBc=;
 b=ggR6aDUBOWaqoHQ1uJpuRgpmcqekCrHkNxHrk+akr8hf9jFUUnX7rIm9yJ8YyOl0bNOznvBWZmgkn51doiSbgpUatfl8YzZI7bZm2Uz8+BaSkovtg0Ei8qnrTfYOjaQhk4i75w18Zfb8FIAFkMHMR0bGm6Prl1ZQ75b7/jhWgdE=
Received: from AM8PR05MB8292.eurprd05.prod.outlook.com (2603:10a6:20b:315::15)
 by AM0PR05MB5076.eurprd05.prod.outlook.com (2603:10a6:208:c6::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Fri, 2 Jul
 2021 13:50:13 +0000
Received: from AM8PR05MB8292.eurprd05.prod.outlook.com
 ([fe80::44f5:7c42:a1b7:cd77]) by AM8PR05MB8292.eurprd05.prod.outlook.com
 ([fe80::44f5:7c42:a1b7:cd77%6]) with mapi id 15.20.4264.023; Fri, 2 Jul 2021
 13:50:13 +0000
From:   Frederik Carlier <frederik.carlier@quamotion.mobi>
To:     "linux-bootooth@vger.kernel.org" <linux-bootooth@vger.kernel.org>
Subject: [PATCH] `SimAccessTest1.CardStatus`: Mark status as `uint`
Thread-Topic: [PATCH] `SimAccessTest1.CardStatus`: Mark status as `uint`
Thread-Index: AddvSPNeNQ2t4aC6RlCZANN/Hmwmgw==
Date:   Fri, 2 Jul 2021 13:50:13 +0000
Message-ID: <AM8PR05MB8292DD484EF2EE569F04BF2DEA1F9@AM8PR05MB8292.eurprd05.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-originating-ip: [194.78.96.162]
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1gE2RTfbnSC7KybKGlltG256hZRGKyoN4ZV067AG7G8fMHp4uHFeCmeAnvQSFZQNHPZRQv5TNtY0FQjXOy81INGs1JImrWVsf1iOAn/EMcP1HyRI74fMbkwhrN179j/7q4e72PjQDY8/L6fP2GUfgpwBpEK9rz2ODT8TZGev7Kp7lf8At2tk4tQIh+I+pRX4Mz5Zl79jNSHvW5stuvQHXaJzSDilSqTIK2cIPoIWYtShVDr2vdqQBAALKgYI9hG/m78mYv95a+QQwNtb8StLZC7F3bNGvcLrTcsZhpAlySo2YUE5ZJSrwGFF1KBH7GZ7LdCuVGnVSS06FFdWXYFPQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFLbFr3RWIeFPub/5Su+b3LcVCKpRgLeensH46lnVBc=;
 b=WfNThm6xjOT5vWlj8WxP/RRo/1v/vg/HbGSzvc4qsUXD2rO9EZjash3pFPEGDJALwHjhRFU2W5VNOaObV1P79PH0BF6Q/I6730pDYL+vqpmyqDmteTAyPIzYucB6HxvSu7HTL5DIOqV53nHXh0EVe7UENe/r15l0wqaP84EvPDVZdR2eapwXfIdA8Cv169XcOto640rOpigM1rflgeFIpoqVG7Nd4aEbgV8+lhV9xMYjmWx1qdubJCCkVNZ/m8pvlbi0r8A8Ut/UqWiYIQcs6TC174/3DGW/Girmuxv0sil8ara1oCPWw+lYZI1RlKsBe7Fka2ToAablCYIdHOi90w==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quamotion.mobi; dmarc=pass action=none
 header.from=quamotion.mobi; dkim=pass header.d=quamotion.mobi; arc=none
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=quamotion.mobi;
dkim-signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=quamotion.onmicrosoft.com; s=selector2-quamotion-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFLbFr3RWIeFPub/5Su+b3LcVCKpRgLeensH46lnVBc=;
 b=Wysxl2SVwoOsPhNOpz3vjkSWK3bev/HFbmlHTgpZS2x54hajVFpKHlAXIsdE0uSpozcKI0DZxHj32Kuq6zrm/c5b+EVNkHMOIWyj5ovEVx+evxmXKm2DzkbWSY14cIode8i2q9GSBgBNOeQqhVdrt/2LZEiBtemTrPv3R6LoZaQ=
x-microsoft-antispam-message-info: x7bKwB3DWCDZeFYdo1oF/UOGk4AoayffTq2PuvCzVYdctIm9BpbPpNQmwxBsAsUB4uVyyFo/59r5HOdIYKNxBxxBnGyiiKMZi4r6gIsITyBp3zvSvAsOlnrFV1SxwQVv6KOEKj7AbzDiKuNniK45ruC2Df9vHJf7FJYidGVJgsGlfrrveIefI7usPKk9neXnpc/b6N/Jp+JXx8qa9UU9vwKrZyoRA/SQNKguVzfdIBoZwp2NILJcERypUR5wOGFELItXPAUq8CJfY12VrqU3nZVu9R8uo7jVSJmoicygLwqE9pfYimWeKMhVFx+jzr6QWqQGQK66LlnWC0wgVFc1UFVDDFb3ncvcwZu/G/Ka0k1UWn1tdIupVG1OO+j3ILAia690Nvyd+69uDtzBryUn2943CqfdguOWUbrRA31pHeSSEtK0+0EPTuQnirWe8KyC8iV4lwACWe6wua4SfOmlHnOpLwVjg/P7lQimz1rDkR2FaoM2641R1xWZK8t2oGftHQVluw2mZ5GKosSbENiLbgP20QSSyJ4QTcAEQaekGa8svezY2Q36obq/2nbp1zgjotnBqWlk3KjDHzAyYs+swpGrcJTvtH0dX0PMVmTA5e7thCv9Yf9NEIX7QMoCdMrSWSTH0n33mczJggl/Y4uGYJfM6Zw1GnMECXYqhz0+nMpsWPHgSHEQF3nQQGH4LXhcumPHjQF6/0JUOkMqyN1lJw==
x-ms-office365-filtering-correlation-id: f816e47b-3d97-4d21-e937-08d93d60514a
x-ms-traffictypediagnostic: AM8PR05MB8305:|AM0PR05MB5076:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB50767FD321C93BDA553AAF28EA1F9@AM0PR05MB5076.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;OLM:2000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR05MB8292.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(346002)(366004)(396003)(39830400003)(8676002)(37630700001)(6862004)(44832011)(9686003)(38100700002)(55016002)(122000001)(86362001)(2906002)(8936002)(7696005)(316002)(478600001)(71200400001)(5660300002)(186003)(4744005)(52536014)(66556008)(64756008)(66446008)(66946007)(66476007)(33656002)(6506007)(26005)(83380400001)(76116006)(81973001);DIR:OUT;SFP:1101;
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: AM8PR05MB8292.eurprd05.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: e9b20bc2-9346-4c05-734d-08d93d6037e0
x-ms-exchange-crosstenant-originalarrivaltime: 02 Jul 2021 13:49:31.2191 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: dec92e2e-4ae5-40e9-bbcd-fb7fcb864229
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: eUlSP9T4VvVnQdBu133UC6sEZFAgknDOdLR63O4pXFN2BFxlXGruMhF1DPyTSpNbvDaTQPieFnEvZWL3VSeIe0F0LL18a8c2mmQrYVVxn0c=
x-ms-exchange-transport-crosstenantheadersstamped: AM8PR05MB8305
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IWH68jdgp78vzxpbCNCTySisOEPt24GPii8rOKCBjrTpyhE3gxSdA0Xm0axO?=
 =?us-ascii?Q?OKehHaWJmQJOHgT2sXNu0y8xtfaA4QcgZGTnj327aKPiUP9dGCFm9pJa1CoQ?=
 =?us-ascii?Q?LngGUxsH98ku01zHKN/X5kC4A7b7Qn63ERVe60Y1zcISp/n2K46u8tXH4C6n?=
 =?us-ascii?Q?8pTfIEXewZGY5Dd4m1l87GpHDJ0vj5qoQCrrykLEUXG1kAQHPMMg4YiRfRxM?=
 =?us-ascii?Q?GcWU9/DcFtqRjE3/Q/7fRinH73dHBc19ETaR/utOUGAetiUOniBz9mlGZ0sz?=
 =?us-ascii?Q?FnSBfrPX+w7N7OsLbretmQ/fo9weLMW3GW0XRyVedsodBnl1cx5crGUin9Qy?=
 =?us-ascii?Q?0uMztvnEoNxYnT2BYvwx/eOb8jb6FMWJAOc1oGG08eLjme7bULlYJV+M53qu?=
 =?us-ascii?Q?h3tg99SeGIemMBV4/+Y29TS4jRZ4lcT2suM3XbrTFHaAmSJ8CWDW4wVyc969?=
 =?us-ascii?Q?yI1iz6t080fBjkI7bIBwentz2WgomnuaxKMUUqWzcaX8MLnslfdooklSh1Pb?=
 =?us-ascii?Q?JvNrEUajDg/uUK3PoCpUcdBiuQObOuxCCypGYXruT5IF1Z+51r5mJbwjGzjf?=
 =?us-ascii?Q?go3+pVQm0iIsZO9Gztc9Ykk0VMOf09yAXNBxYl1kYkgMgbZOFtNkC5X2a4hk?=
 =?us-ascii?Q?YK0nbClMB1leCvYPhkpjwrPau/7ua+25ymtE1cnexGYhYALpiaTR5bIPuoOg?=
 =?us-ascii?Q?SQIkGYN/HKwcLgfCrrmHiUz5mdu2aWgFtRQb56FHTfugIx4yKCww8MUDXCTq?=
 =?us-ascii?Q?bMRZ5KiAuDY/2IqEVIeM71xFY4oB+Hog/l+MksGtACgNuh3+D35HhIPkFswE?=
 =?us-ascii?Q?V/6nrn1Er59dYqxMDYLJg0WAzgBG8AXyPuk8ZjgGWu8+BqmpG8O2k9T6E9vJ?=
 =?us-ascii?Q?TplSuu7C8sZtyY0FJbERCGsjIAamKJHIkxJuFrAvYbQU1c6k+Be5G46knMTd?=
 =?us-ascii?Q?C7O4MKcc0pbpQZeRcsJfs2FQnmZ2g8cVEFSrPxXICg76ZvEh7XDDCM6AEaXB?=
 =?us-ascii?Q?alLewAek+qOz6LpbgkjvvBqV+OqqHzxMOVA0Nnns0MYeZpa/gSoYIpoWqz7q?=
 =?us-ascii?Q?n/jZLbWN/FVOFC4mRPF0vPCpTI1EYcjU4Q+agsZ19zO3s8xaBGoNJhOhkkdM?=
 =?us-ascii?Q?p7jJG1Q33xS1wxdQFd6tVplWc7q5fK9M5mnXdZTRRKNvUcJPdkEq1/D2X+db?=
 =?us-ascii?Q?04U1sjH/CPiJWFlVxCTfk6zX6oEiRllAr5LvRr/QXl7wFVZvrFw4ilBs/kWo?=
 =?us-ascii?Q?ydHbgbiR2gUErXrPO2G+sFSaZaPLM9zMhAu9RMiSaxzwxDqcDLaVs2zg/JC+?=
 =?us-ascii?Q?dCQ=3D?=
x-ms-office365-filtering-correlation-id-prvs: e9b20bc2-9346-4c05-734d-08d93d6037e0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7A293BDA1EE0340A317189FADC41C11@eurprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quamotion.mobi
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM8PR05MB8292.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f816e47b-3d97-4d21-e937-08d93d60514a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2021 13:50:13.7593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dec92e2e-4ae5-40e9-bbcd-fb7fcb864229
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Tt9/OOdg2N9noU3iqRdp3OTCK9i7UdYa3N85VZfOg3kzt8vV+rxjoM8qZEKfpkuUNcUyQ37XyV3I4AMoiUNq7wWQQYEjyllAsyIBfwgR0ew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5076
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This brings the declaration of the status argument in the D-Bus method
table in line with how card_status reads its first and only argument.

Signed-off-by: Frederik Carlier <frederik.carlier@quamotion.mobi>
---
 profiles/sap/sap-dummy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index 92adea384..c81eba078 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -334,7 +334,7 @@ static const GDBusMethodTable dummy_methods[] =3D {
 	{ GDBUS_EXPERIMENTAL_METHOD("DisconnectImmediate", NULL, NULL,
 				disconnect_immediate) },
 	{ GDBUS_EXPERIMENTAL_METHOD("CardStatus",
-				GDBUS_ARGS({ "status", "" }), NULL,
+				GDBUS_ARGS({ "status", "u" }), NULL,
 				card_status) },
 	{ }
 };
--=20
2.32.0.windows.1

