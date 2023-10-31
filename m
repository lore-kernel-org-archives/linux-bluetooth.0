Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6C1C4167D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Oct 2023 12:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344118AbjJaMKz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Oct 2023 08:10:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344223AbjJaMKh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Oct 2023 08:10:37 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B78ED6E
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 Oct 2023 05:10:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVAFpVX3ifr3J7z7IZTyHutMkCqsqIPeJWbgCKaiUCUhZ4RLnqh9Ej1ufsntHU87dP3xWzs1qwRxuK0wTXXz05X+qaYIATKB9fu6SQPBBVzu/vRuvZ89uZIgfRdcYpExkvVrJlPeazH5SH2WWddG/Geh1QR8ATE5Mh2gdHjXD5/7SDns/whtwRMixR72lZtDzygFlHKB0moFb/8jBSw0Qw9fzGyA0P7px/8Sgjbd8sOJOApdgCBlkOgqU8iFGgWbAHJOoBquZIB+vnd7bv5REntLsKjB1RPzDoH6Ro4ezvPWRsWxH8a5LX7qngGqeKjv51+or7kWfDPsIX7t0s/qGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+XW7UIo7rtG7oEoGDl12EgZbEOlEzDBUsv3inRg7TQ=;
 b=E4vEEiU+AQ3WtdyjD3UFidgNPSp/cGcXWloOBBHQsOzw8gtzaLQHLCAziNpgy/GQBED7MFWrWwPmO5zelMOuP2OhUOmeqGd2b6FbVrdnbbLl8Hn6LcAK9EkH1Tn9p0oK6ehOvA6Egu3JESN/SRLBlkCh2jUHG8yGhIHsmmXR9nDT3ElsO+6GzgOJuaE+dz9dYRa4th+RcRB7cLDHWZ33LesWnVb7AFRCo6AgSI0kinrq27IzB3+Hc9dvVEyoN55OEE59p4IgcKITWyF7NFU2G6FEFzVLE7x24GCHFJzB+Vj7V7/DvGdVZLRtmIHUxMA3//4nlHAWU6Qp/OubZEP9mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+XW7UIo7rtG7oEoGDl12EgZbEOlEzDBUsv3inRg7TQ=;
 b=Jc4xKqig1cCDpg+fdoOo2AjapmQVq9tCqoChriLoTnxvz8y6n4oRbMtjF5O5LAJM847V70OLGfB7fQ5CvTXHgL2fNmNlzluBRylSNZcfNp+e3TLhNAykIrzAhi2XriEf8fSkV3ztz/WdOKeQrz/6YEf0/lxG8bO+pKyyGm+3+i4=
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com (2603:10a6:102:cb::10)
 by DB8PR04MB6986.eurprd04.prod.outlook.com (2603:10a6:10:116::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Tue, 31 Oct
 2023 12:10:17 +0000
Received: from PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::f08f:9a04:3d33:7e49]) by PA4PR04MB8016.eurprd04.prod.outlook.com
 ([fe80::f08f:9a04:3d33:7e49%3]) with mapi id 15.20.6954.017; Tue, 31 Oct 2023
 12:10:17 +0000
From:   Purendra Singh <purendra.singh@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Devyani Godbole <devyani.godbole@nxp.com>,
        Nitin Jadhav <nitin.jadhav@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v2 1/1] gobex/gobex.c : Increase default
 obex timeout from 10 sec to 500 sec
Thread-Topic: [EXT] Re: [PATCH BlueZ v2 1/1] gobex/gobex.c : Increase default
 obex timeout from 10 sec to 500 sec
Thread-Index: AQHaAzkSicHPwNnXcEe3qgRIT0b3tLBSbY6AgACHgwCAEOmGQA==
Date:   Tue, 31 Oct 2023 12:10:17 +0000
Message-ID: <PA4PR04MB801647DD41F1D7222C9FD6518DA0A@PA4PR04MB8016.eurprd04.prod.outlook.com>
References: <20231020093716.9654-1-purendra.singh@nxp.com>
 <20231020093716.9654-2-purendra.singh@nxp.com>
 <4cf2cb28-b334-487b-96d6-6318961035e1@molgen.mpg.de>
 <CABBYNZKhBp=qw9aB+0CVLu0U1YeYwt2qC80+2fqgwH-sgbWf3A@mail.gmail.com>
In-Reply-To: <CABBYNZKhBp=qw9aB+0CVLu0U1YeYwt2qC80+2fqgwH-sgbWf3A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB8016:EE_|DB8PR04MB6986:EE_
x-ms-office365-filtering-correlation-id: 91a4e825-54d7-4766-05d1-08dbda0a58a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: em/EmXvI2jLMOFtWarfl9GtLbIzc86UgFbsM7Hxj3OKv7eESS4ivDc8/tsdNDlWnYFU4hdw1rd1QGrUX/Y5xtf1KRVC7Rp+p0QUTk5diuIOMrZr5wV0DBNXm3lR+Ahxrx7B5T3x0wYEwWpVY9l5P+15yGe5VBk13wZ1bwpnTaNXU/XZv6M2nD4lhDUjanaEnZyhTK3ABUB5ZsOLB/R2dhzDo7l8tqjR6W9HhCkWEwJb3Ivf6F2VrtXcO7C36O39WlmqcvkE0gJG0voamiKWuRFTVggsfOHw/h8Q5aw8vMM+OegV8DuyeXoB6FvOJnShJsuMXusgZXGamIOMcN+spJzzZVflm2OoPp4VozkiBLIGxrlbw3tDXSk+CNLPl5VJaEDw5wndEsokTI+/lNiiNxk1a2K2VxnXgvbWCtkKqc5aQHONBFfAEHUquKJretkP5o1bwnEeAAP9C2g/TsEHmZUXJ6ltKg9vVBWQwupNMZYAnMkqWYQ57V9XKRwdsUvT4tMza3RZBi4kcfSSV2al4J3O4hOv7Y/DP5REG43lBezQ3ryRI8RgLHfVwvUVit9gfYKoMP6z+pQkCqKqfY2I8cwcYJvih+fcEkgRBS7nOZlAwdrEsklIzvaWXoX3x2zQYFNO34NDT7iBo7vD50tCoUeMRm9bAwe2JWrWApH14I7I=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB8016.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230273577357003)(230173577357003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(55016003)(86362001)(66946007)(44832011)(38100700002)(6506007)(110136005)(41300700001)(66556008)(66476007)(122000001)(64756008)(66446008)(7696005)(71200400001)(54906003)(478600001)(53546011)(9686003)(83380400001)(5660300002)(8676002)(33656002)(52536014)(4326008)(76116006)(8936002)(2906002)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QkZobnAxSFVRRWhmSEtMa0ZtMHI4M1VvTm1vQzBpOWF6UE9GS08vaGswbm1o?=
 =?utf-8?B?clZZMFdxa1gxbmJGeWFwRjR1K1J5c1FyVUV4QzRJNk1SU2FrVTBRU0JTb0Ju?=
 =?utf-8?B?M3QwUzhjMnNnL3lCMldpck5Oa21RYnM1dmNPUGRoL1VGV0VBRnhhZkE4cGNj?=
 =?utf-8?B?UGtOR3NMb2x2Mi8yZHdHUnp3UDh1eUV4VERaZURoNWFBZ3ZMZFRKYkdIc3NR?=
 =?utf-8?B?eGpnd1pMZllBWkhCTEZqeWY5eUVOOW4zZ1Z5bXBWbFdaeGYyMjl5cVhlV0h2?=
 =?utf-8?B?Tmxnckdvc3RhYnh3dU1NVGtSQk1mS0h4TGY1MVNmTVBYSnVaSGE4VmdqYjQ0?=
 =?utf-8?B?eW0xN3dQUStQUjVsWnEvYVdyaWJuN3ZsUDRCb2Y1R3JINzd2Vjc0Mnh1MGl5?=
 =?utf-8?B?WjcvRmttVTBvTkJTNTJJNnVOZFk2Y1FPdU1oZGhVdmtXRU1WVVZERXh3NnJV?=
 =?utf-8?B?czdtWHFWWEpUVGNqcTRMYnBwb2FxQmJJd3c3eC9TRFg5WEhqeFRVeEhsT1ZK?=
 =?utf-8?B?ZnBIUC9KUm1VR21TcndSSXVVNzE3ZGE2cUdHc1pFeE5VUzY1RTkxVVlqOW5L?=
 =?utf-8?B?VkpZS3AxanBTcFFyblVmUkhIWW5XVTNNTzVCbUtGazRmeU9IdjMya2FkSy9O?=
 =?utf-8?B?Z3EyNWFucExDRXl2bWJDek02Y3FwQlhjYzZ2Y1JPeEtGelZoa2MzblptaGk1?=
 =?utf-8?B?eFUzOUxHaXU1a2czQ2ExZWgvQjh6eFhZcmRtaXJ2aEZFeVpiZDUzVGJteU96?=
 =?utf-8?B?U1BOL3lSVmw1bzRzYlZuNlJnRGtZQXQ4K1VLUHpsV3JRLzZzNkVHWHZJZE9H?=
 =?utf-8?B?ODlPaGljWkk4WE9ZUldwaUJ1RmRmR3BIUWc2Z3d2QVN5WFRmanlpZEFBZWx3?=
 =?utf-8?B?SytqSVlpQjd1T0gvdmozNFJqQXhYYTAzMHl2bFY0TjR3Qm4xakN4RlFDTkgz?=
 =?utf-8?B?alNwYlJiMlpUR2xGd25wVEtNWGR4aVVEeGVPTGNUUXVFSTB0YU5yZmttVmVZ?=
 =?utf-8?B?UEdiWU5yaWFCSUthZGQxdHVHMFVsQWNUK1Yzencwa080VGYxV0c1SHEyM2ZE?=
 =?utf-8?B?UURBZHpmWkJlS2hTbTZRb3RVWlNqNEdPUG8xTy9WSEs4TG5vUWhtQStYK0VS?=
 =?utf-8?B?bTdPbGUrYUdvTWY4a1NubWVsRTcxOTdjTS9lRk1mWmUzUUIzSGZWc0ZzYmcv?=
 =?utf-8?B?WjBETGt5akk4d3BFZVJudnBNYmJWR2hMYWNvOFd1NU1kNDNUazFsV0FYb2lq?=
 =?utf-8?B?V2lhSTlNREtqYzBpUit2NkRwaW9ac3BtYnBsYkllb0lXaVVnWHhWY09zbml0?=
 =?utf-8?B?bi9QME5MYTVQQ0p0NzVIdjlNaldaWGRlQ2Y3Y3NwRVNSekJzdlI2Y0ZJVnQx?=
 =?utf-8?B?OXhxQ2NINE8xWlR5Y3dVVlRnaGE3QkRxbyt4cGhOVCtab0gwN2ZKeUVIemF4?=
 =?utf-8?B?cWNSbXNmYmtHeWhGTlk5VGsyelNCUXVqVlJSQXIveXNSWEQ5NHNWaWhIUXlY?=
 =?utf-8?B?ODBOM0w3YTB5VlFLaitJaVJaSW1RS3FldFUrT3N6SVFpMlVVdWJJQ043OEhD?=
 =?utf-8?B?VGRyQ0dJU0lTRFBZRFMyS01jZnlod004M2xKOXd2VU9PSVlPQkhacEpYQ1pm?=
 =?utf-8?B?NUdoSkhZcitMM05mQXBPTXNPdlY3VEdOeTk0TUErc1BsZ3Rac1NLaGVIVG9R?=
 =?utf-8?B?SmFPcXlWc3dOaG5obGdTN3BERmVhalhVQzFnaGxaYTJCa1BLMGFVU0ZIQ0ND?=
 =?utf-8?B?bGFvSXhMUlpYK0xKNDNLR09HOXI3NFRxQ0xPaWZNanpvV04vRU5pMyt5UG9R?=
 =?utf-8?B?OWlZM0hRaXh0WDBrQ09xOWQ2TGE3bzg2TVlvM2hSMEVDTzJjWGpuZ3lUUHhL?=
 =?utf-8?B?RnpCM1NZWXZCZTVZS2h4WWRJV0VRdWp0Q1lQcFFFT3Q0OWc2YWxSOStHWXpw?=
 =?utf-8?B?NzZtNjYrb0ppd1BvZng4M3pSa2pPNkF4RGFkUkNBSUJ4Nmo2Y2cwZTA5dWU4?=
 =?utf-8?B?MndCMkFQVnNUZ1hSZUMyR2FzT2xDaUhxYjE5QUUrdllPajYyQ1VLWGZUU2Yy?=
 =?utf-8?B?MENyeEJ3RlJhNWJKU09EK2xNd2FrbXF3ekc5eFpQZTN5WHpuRy9GVUNvT3FU?=
 =?utf-8?Q?7IeIVEVvULryw+6rYEAF8VMFN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB8016.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a4e825-54d7-4766-05d1-08dbda0a58a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2023 12:10:17.4519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vmZ1YCTnKBUEEAehROeITzOsU1Z6f5j9rrPtaJN/Bkt+924N44214kxukxcHcvgxDaFyKHFIVfEvPTonBgpKzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6986
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGVsbG8gTHVpeiBhbmQgUGF1bCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBG
cm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2Vu
dDogRnJpZGF5LCBPY3RvYmVyIDIwLCAyMDIzIDExOjE5IFBNDQo+IFRvOiBQYXVsIE1lbnplbCA8
cG1lbnplbEBtb2xnZW4ubXBnLmRlPg0KPiBDYzogUHVyZW5kcmEgU2luZ2ggPHB1cmVuZHJhLnNp
bmdoQG54cC5jb20+OyBsaW51eC0NCj4gYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgRGV2eWFu
aSBHb2Rib2xlIDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNvbT47DQo+IE5pdGluIEphZGhhdiA8bml0
aW4uamFkaGF2QG54cC5jb20+DQo+IFN1YmplY3Q6IFtFWFRdIFJlOiBbUEFUQ0ggQmx1ZVogdjIg
MS8xXSBnb2JleC9nb2JleC5jIDogSW5jcmVhc2UgZGVmYXVsdA0KPiBvYmV4IHRpbWVvdXQgZnJv
bSAxMCBzZWMgdG8gNTAwIHNlYw0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcg
YXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUg
J1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24NCj4gDQo+IA0KPiBIaSwNCj4gDQo+IE9uIEZy
aSwgT2N0IDIwLCAyMDIzIGF0IDI6NDTigK9BTSBQYXVsIE1lbnplbCA8cG1lbnplbEBtb2xnZW4u
bXBnLmRlPg0KPiB3cm90ZToNCj4gPg0KPiA+IERlYXIgUHVyZW5kcmEsDQo+ID4NCj4gPg0KPiA+
IFRoYW5rIHlvdSBmb3Igc2VuZGluZyB2ZXJzaW9uIDIuIChObyBzcGFjZSBpcyBuZWNlc3Nhcnkg
aW4gdGhlIHByZWZpeA0KPiA+IGJlZm9yZSB0aGUgY29sb24uKQ0KPiA+DQo+ID4NCj4gPiBBbSAy
MC4xMC4yMyB1bSAxMTozNyBzY2hyaWViIFB1cmVuZHJhIFNpbmdoOg0KPiA+ID4gVGhpcyBpc3N1
ZSBpcyBvYnNlcnZlZCB3aGVuIG11bHRpcGxlIHByb2ZpbGVzIGFyZSBhY3RpdmUgZnJvbQ0KPiA+
ID4gbXVsdGlwbGUgY29ubmVjdGVkIGRldmljZXM6IEEyRFAgKyBISUQgKyBPQmV4IEZpbGUgdHJh
bnNmZXINCj4gPiA+DQo+ID4gPiBGaWxlIHJlY2VpdmVkIHN0YXR1cyBvZiBzb21lIHJlZmVyZW5j
ZSBkZXZpY2VzIGlzIGRlbGF5ZWQsIHRoYXQNCj4gPiA+IGNhdXNlcyB0aW1lb3V0IGFuZCBmaWxl
IHRyYW5zZmVyIHN0YXR1cyBlcnJvciAoVmFyaWF0aW9uIG9mIHRpbWVvdXQNCj4gPiA+IGlzIGJl
dHdlZW4gfjEwMCBzZWNvbmRzIHRvIH40NTAgc2Vjb25kcykuDQo+ID4gPg0KPiA+ID4gV2UgdGVz
dGVkIHdpdGggTW90b3JvbGEgRWRnZSwgU2Ftc3VuZyBNMzMsIE9uZVBsdXMgNlQuDQo+ID4gPg0K
PiA+ID4gRXhwZXJpbWVudGFseSB3ZSBpbmNyZWFzZWQgdGhlIHRpbWVvdXQgYW5kIGF0IDUwMCBz
ZWNvbmRzIG5vIGlzc3VlDQo+ID4gPiB3YXMNCj4gPg0KPiA+IEV4cGVyaW1lbnRhbGx5DQo+ID4N
Cj4gPiA+IG9ic2VydmVkLg0KPiA+DQo+ID4gT2gsIGl04oCZcyByZWFsbHkgc2Vjb25kcy4gSXNu
4oCZdCBncmVhdGVyIHRoYW4gOCBtaW51dGUgdGltZW91dCAqbm90Kg0KPiA+IHZlcnkgdXNlciBm
cmllbmRseT8NCj4gDQo+IFllYWgsIHNvbWV0aGluZyBsaWtlIHRoYXQgd291bGQgcHJvYmFibHkg
Y2F1c2UgdGhlIHVzZXIgdG8gIGFzc3VtZSB0aGUNCj4gb3BlcmF0aW9uIGRpZG4ndCB3b3JrLg0K
DQpUaGlzIGlzIHRoZSBtYXhpbXVtIHRpbWVvdXQgd2UgaGF2ZSBzZXQgYmFzZWQgb24gZXhwZXJp
bWVudGluZw0KZGlmZmVyZW50IHJlZmVyZW5jZSBkZXZpY2VzIG1lbnRpb25lZCBpbiBlYXJsaWVy
IGNvbW1lbnQuDQpUaGlzIHdpbGwgb25seSBjb21lIGludG8gcGljdHVyZSBpZiB0aGUgcmVmZXJl
bmNlIGRldmljZXMgc2xvdyBpbiANCnJlc3BvbmRpbmcgdGhlIGZpbGUgcmVjZWl2ZWQgc3RhdHVz
Lg0KPiANCj4gPiA+IC0tLQ0KPiA+ID4gICBnb2JleC9nb2JleC5jIHwgMiArLQ0KPiA+ID4gICAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvZ29iZXgvZ29iZXguYyBiL2dvYmV4L2dvYmV4LmMgaW5kZXgNCj4gPiA+
IGU5Yjg5Y2VhZC4uZjBlMWMyYzgzIDEwMDY0NA0KPiA+ID4gLS0tIGEvZ29iZXgvZ29iZXguYw0K
PiA+ID4gKysrIGIvZ29iZXgvZ29iZXguYw0KPiA+ID4gQEAgLTIyLDcgKzIyLDcgQEANCj4gPiA+
ICAgI2RlZmluZSBHX09CRVhfTUlOSU1VTV9NVFUgIDI1NQ0KPiA+ID4gICAjZGVmaW5lIEdfT0JF
WF9NQVhJTVVNX01UVSAgNjU1MzUNCj4gPiA+DQo+ID4gPiAtI2RlZmluZSBHX09CRVhfREVGQVVM
VF9USU1FT1VUICAgICAgIDEwDQo+ID4gPiArI2RlZmluZSBHX09CRVhfREVGQVVMVF9USU1FT1VU
ICAgICAgIDUwMA0KPiA+ID4gICAjZGVmaW5lIEdfT0JFWF9BQk9SVF9USU1FT1VUICAgICAgICA1
DQo+ID4gPg0KPiA+ID4gICAjZGVmaW5lIEdfT0JFWF9PUF9OT05FICAgICAgICAgICAgICAweGZm
DQo+ID4NCj4gPg0KPiA+IEtpbmQgcmVnYXJkcywNCj4gPg0KPiA+IFBhdWwNCj4gDQo+IA0KPiAN
Cj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQpUaGFua3MgDQpQdXJlbmRyYQ0K
