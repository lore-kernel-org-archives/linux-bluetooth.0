Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 465EAC7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Jun 2023 12:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbjFGMQI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Jun 2023 08:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240525AbjFGMPz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Jun 2023 08:15:55 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506381BDD
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Jun 2023 05:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRLzb/mZZ1259bak9jGJ6dARiEGLJTQaIRmm4/ZgEav3vH8PAwWrxF80K/89T9sLrtFM0rJ4/CbMdeaj8pTVTCq6bmG3TGsZAqn6PqNF56PT1os/qjMb7x3ZEEG/Yc+qj9Mzr56Rzd6HR4+rCPdS+8drjt/kBkUV6xzZnfGJthRy7MSGHDtlk6rhHB1Py2qIsY45VE1SozXsrGANhu7z9AGtS3vQJ/gqx0yihklRl1lalWBwkVTPYHYXAz/YWimRtUoft9o6aM3DuC7nNqyPUsnoJIchS8wj3kZTK+vffFUiCOadTU8o/AU0eO91OrTY90fM8XaNYg/d2AognYdQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AgUMfC3QvQasLSEn5Mj30s4yvDhD9Tva53d7rWd7qY=;
 b=CXmlm9EYQQAyXOnnWOlmNsmjYFS4ElAv+awxmHj19kPy6EjR+eQAjanNlIpj7SrJkF3rjzbmyFzgEritCF9YZCAdyXTPmBBXBqdJHxV5HWMrDMHBZ+EhiSIQ+NTfub4I+7ReApPqPiKctOGtd1i4ZD49i+1F0m+NOiv1f2xbc2M53+1aNbeqBEdejitZvTNH52met3ZcLMRPAlZievn/0GcNxTHz1AJjnO2Ed/WyIXw8rhikNimzHBGCdLV2XFqvtMJS9IxLo8zHsG8HwsXnGayPsbJvbvhCXAGJhcUmdDX8fBzSoUHqPze23VeLfZSEscYtWIz5X02PYEcZZXauWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AgUMfC3QvQasLSEn5Mj30s4yvDhD9Tva53d7rWd7qY=;
 b=bZLVv9hQBQ8Gm7Uti8Ad/lWYau5M/FOS9VlBMv1OAH3vwk2nxMend1fmdwtps37QTmki7fULfI0NoyoqBXLc3OSP9n4m8uuoginWMQuMYfGBfVPedIreiPFaVIDu16PDCYqD83NMgt3KDIXLuM3JoTX+rvutjlGbN0NauLvOFMs=
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com (2603:10a6:20b:449::16)
 by AM0PR04MB7122.eurprd04.prod.outlook.com (2603:10a6:208:19c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:15:49 +0000
Received: from AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4]) by AS8PR04MB9126.eurprd04.prod.outlook.com
 ([fe80::ad2c:857b:a144:9af4%3]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 12:15:49 +0000
From:   Nitin Jadhav <nitin.jadhav@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Devyani Godbole <devyani.godbole@nxp.com>,
        Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>,
        Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 0/2] Code handling for VOCS service
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 0/2] Code handling for VOCS service
Thread-Index: AQHZmG+0QJjfSUXkbEKhBLYzdpZbDq9+aGWAgADHXQA=
Date:   Wed, 7 Jun 2023 12:15:49 +0000
Message-ID: <AS8PR04MB912690BDD8A3D01AC0913C429953A@AS8PR04MB9126.eurprd04.prod.outlook.com>
References: <20230606120824.4705-1-nitin.jadhav@nxp.com>
 <CABBYNZJZJTSpm4MNpBq-Q2gUozLz2S9c4p-Zya6CwnWWv=QfxA@mail.gmail.com>
In-Reply-To: <CABBYNZJZJTSpm4MNpBq-Q2gUozLz2S9c4p-Zya6CwnWWv=QfxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB9126:EE_|AM0PR04MB7122:EE_
x-ms-office365-filtering-correlation-id: 25ed8e17-ba3b-44e3-dae5-08db6750ee2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYeKaQH+61RhTZjqw8ilsLFnVWua+BZUKM+/vZGS9SU5nTQzGf9hJ+lF/yxilbKjJHQaJf8z/jQy6x8a6UX2KR/Zbq+QEYsvdK+ARTM8v0ZjyA7mFvaNqBtaj7rXtVBU1fPsrdUTOnF2pG8caMf3Iol7u3IAdh2XOu+6S23lbWjeN0XFlgT1cjILlTnIoa2A/hJMR9zLsCXY9BbKNaV02E8yXWk69x0QDauBj0jJPJFbGp0JICikQ+e124nhnTjY/pkgZwobI5ux9dbNLgO4pUSIUEo4IxkG5zwdPTGM3V3Ykusp6TDbEadlUftbfQmV7nkesrEA0MDlK7apedWSyEgYsFURIIi64m71JguV5b4aZUe4pQeY+rApw9MixaocbUQ7QPpU+faFHrVzhQsQqRleoZJB7iI5HfZcRfGQErzChflHlItrbbrA0QCLOzvr0YkZXqOg60toGiFEmJr53ELbJFc9+Mye7mS1/hEywFB53iEtlVp3kEcC+qY+vD/a86ae4GI+zT5gXg/IjICfeJZS3s+wJg12yS8c7c4uMv/mshQc00Gu7ZrMrfF6AJXhpFaNl/cDy1apiOsV1pwgpuMa+79uosvCBV4hXd9CaUnYEG0AyulV43s4SriWPGde
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB9126.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(83380400001)(478600001)(6506007)(186003)(55236004)(26005)(53546011)(9686003)(54906003)(55016003)(41300700001)(122000001)(4326008)(64756008)(66556008)(76116006)(66446008)(66476007)(66946007)(2906002)(44832011)(38100700002)(6916009)(316002)(8936002)(7696005)(71200400001)(8676002)(52536014)(38070700005)(33656002)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K3pOWlhldEVEbCt3cGNKbFVwR3ZmY0NxdGxZYU5Ockw3NUVTcVVoa2JHNzIy?=
 =?utf-8?B?U2pGSUdZN0IwbGhCY0tBYXhyNEF0R3plekRRUVlydC8vRUJwNGlUYXZGREZ0?=
 =?utf-8?B?NUhzcEw0MndBZm1qa2pTbExINGZFVGdnaTZ6RmtKYTlMY0VLVlp3d0JxcjBB?=
 =?utf-8?B?SzE2enBLVWkyZ1QyU1hpRUJoVHU0QTBvc3d0NktPdVhXNno0Rm1KRXVJblZV?=
 =?utf-8?B?WlFFbFAyNEx4emNNOE5oV25hd25RN05scW1CR3RGWVFNSUtkWlcvbERuOCsr?=
 =?utf-8?B?ZlZwN0FZdm15YklxSURNUUpRUDFWaC9TOC9JZzZoUHhTbzZqWkM4ejg1ekdh?=
 =?utf-8?B?VmpmTFFuRGlWcWhGT3NLSlNlZWlQb0V1RjRKblg1YWFLdEhSZ2pYMGoveW91?=
 =?utf-8?B?ZjM3d1JNNVd3VDhJNVNXYjZKSXlLaG1UTlhySUlFMk9ER1BaaUd6UDBwNjRM?=
 =?utf-8?B?ZmVwM05qTUtJY0VMcEd4NmZ4c2NpTHJCNWFPNDhSWk9TMnUybVNqM3dTZ3hH?=
 =?utf-8?B?Q3JLQjFsYk9iS1V1VC8xWUFrS1pZQzFrK1k1ek00RExRdHpIVko4MzhuRmZY?=
 =?utf-8?B?aEZraEhLV2w5UjFHL2g0dXZ5dHVnaThhOFJUKzdmK3JBSlp1cHlaVU9peFU3?=
 =?utf-8?B?NzlqbjB4a25pbVZmTWpOWjdIdDdJZ0l5dkd1UllKcmpuR0tmRW5OYVZsbW9X?=
 =?utf-8?B?ZzFJb0VxR0kxRG0rQWpQYS83a3hnWHgzZGFwVkxtRmRmVFN6UUppanUyQ2cw?=
 =?utf-8?B?MjJlbnNpa3ZjS0UxQ1FuUFMxREJFM2IvYUZ4dDBHRFg1bm5hMW8vWTQ3Mm1O?=
 =?utf-8?B?d3ZmSVFubTh6aGE4b1B5ZS9UbU1KVnJ4Z1ZqakR5c0RoSjNVZTVqNjB1SjRU?=
 =?utf-8?B?cjVaSVNnbEJaSUJnV0JXOHpHdzJ6alIyZlpHM1N3WXpTUWdNaTVNWWVmRThF?=
 =?utf-8?B?K2FnUVo1dWp0SkE1MHZuTUtjMkJ6b0k4d3NHYWp5enAxYWo4eXhlLzBnbFZL?=
 =?utf-8?B?bEs4RUhiWEh6TUl2SXE2OU51c1hLUUExZ1AreXlKcUNnWlAyQ3F3TGhSODNk?=
 =?utf-8?B?L09jZlYzS0VYRkYyeEFmbUdTOW4zcHYvMitUMUcwb2EyL1pydWVWeUhaa0ZB?=
 =?utf-8?B?bXYzZWVSSCtwNURDeGxpQm1nNHVRcGtVSGYvcEpQVGVMbVkzQUZkeGhsdUJ4?=
 =?utf-8?B?LzVITkxNUDloUUwyZnZ0RW9DWHJraFpJcG1ERVhueTlWNWJLVkVWbFY4RXdy?=
 =?utf-8?B?SGNraXdLNGJqTDRmR09sOFVRNkcycGxJM0grSEZLdVhyWUJZRno2dG84Y0Jw?=
 =?utf-8?B?d0crNThyOSt0K0xaRjNCUlVYaGhBUzJPbDBRMUpnb2dWbWNjVDdYRmx4eDRW?=
 =?utf-8?B?SEQ3ZDlyaXFoaGxRdGw1dEN0OTlob1hQZ2FQejZjU2hKUXZ0OVFXQi9DMWc3?=
 =?utf-8?B?cDNvWlIzMCt4VUJCQU4vM1NvbGlBa3ZLNjFtOXZYQlF3UjI2dGpKQ2tWU1RX?=
 =?utf-8?B?V1VUNWVLc2tTQmZOOC94NmN5aklKQS9CY3BYblllOEpQNjRZM3NJTjZaL09z?=
 =?utf-8?B?cFBYcmxkdFZiYWxjOG5Rbyt1MkVsMG9vL2RPcmczQ3dUN1FGUHFCN3NnVEw4?=
 =?utf-8?B?QnpaNE9RM2NKTFhZNko1UDFNOEhjc1RTYlpudk0yL0tBMnFtOHZhUDd5K2Zw?=
 =?utf-8?B?aHhYKzdnVUNvanhvWFcvQU5HM3B4eHRqUysyTWw0Z01Ca3hGQXVYZUppZ1k5?=
 =?utf-8?B?VkdOK2JRS1U5MkEvbmcrS2VhR3RWeVFOS2dxMlhnK0tJNXdtOHdmU1U5bGFT?=
 =?utf-8?B?bUxFYkpWUjZtK05hY1U0RWh1RjhrdWVQYkt0R1BlZUtzRE05ZWwrR252RGcy?=
 =?utf-8?B?dklpTE1pNUVCeHdSRU8vVUwzZUVzVjZKNFhyR1YxZ3RieEprZkkzOFVNUWR2?=
 =?utf-8?B?eWZjWXdIYkw2VmYrVzRMSDRQaHhPVFY1TlEzZkZnM2Vud1FiRjFDMUo3cUtF?=
 =?utf-8?B?bG5EeExRRE03ZEVoclpVTXUyajVnWEZmY1dGVm4vdC9JZWI3RWwzMXZrdlRi?=
 =?utf-8?B?Qll1YnBKVGtQTFRvbnZabVcyTlRxbzY1WTRRMkZXZ2V1UnhURUc1TlJHOWFr?=
 =?utf-8?Q?NKHneqnP/6OwDa2ppBMgPWxio?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB9126.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ed8e17-ba3b-44e3-dae5-08db6750ee2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 12:15:49.3358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7cLE2IycSr6knlToYbGgdO6HaGw5RzLSRgvHNUQ/aXkALGrsu16cp+t2DpGLAYUV3MR2nxyL8UV0E69ZcyCbTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7122
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGVsbG8gTHVpeiwNClRoYW5rcyBmb3IgdGhlIG1lc3NhZ2UuIEFzIHBlciB5b3VyIHN1Z2dlc3Rp
b24gd2Ugd2lsbCBjaGVjayBvbiBpbXBsZW1lbnRpbmcgb2YgdW5pdCB0ZXN0ZXIgZm9yIHRoZSBi
dF92Y3AgYW5kIHJhaXNlIGEgc2VwYXJhdGUgcGF0Y2ggZm9yIGl0LiANClJpZ2h0IG5vdyB3ZSBh
cmUgYWJsZSB0byBmaXggdGhlIG90aGVyIHJldmlldyBjb21tZW50cyBmb3IgVk9DUyBtZW50aW9u
ZWQgaW4gdjEqLnBhdGNoLiBQbGVhc2UgaGVscCB0byByZXZpZXcgcHJvY2VzcyBhaGVhZC4NCg0K
VGhhbmtzLA0KV2FybSBSZWdhcmRzLA0KTml0aW4gSmFkaGF2DQoNCj4gLS0tLS1PcmlnaW5hbCBN
ZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBn
bWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgSnVuZSA3LCAyMDIzIDQ6NDQgQU0NCj4gVG86
IE5pdGluIEphZGhhdiA8bml0aW4uamFkaGF2QG54cC5jb20+DQo+IENjOiBsaW51eC1ibHVldG9v
dGhAdmdlci5rZXJuZWwub3JnOyBEZXZ5YW5pIEdvZGJvbGUNCj4gPGRldnlhbmkuZ29kYm9sZUBu
eHAuY29tPjsgTWloYWktT2N0YXZpYW4gVXJ6aWNhIDxtaWhhaS0NCj4gb2N0YXZpYW4udXJ6aWNh
QG54cC5jb20+OyBTaWx2aXUgRmxvcmlhbiBCYXJidWxlc2N1DQo+IDxzaWx2aXUuYmFyYnVsZXNj
dUBueHAuY29tPg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIEJsdWVaIHYxIDAvMl0gQ29k
ZSBoYW5kbGluZyBmb3IgVk9DUyBzZXJ2aWNlDQo+IA0KPiBDYXV0aW9uOiBUaGlzIGlzIGFuIGV4
dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3INCj4g
b3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVz
aW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPiANCj4gDQo+IEhpIE5pdGlu
LA0KPiANCj4gT24gVHVlLCBKdW4gNiwgMjAyMyBhdCA1OjA54oCvQU0gTkpOWFAgPG5pdGluLmph
ZGhhdkBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhlbGxvIE1haW50YWluZXJzDQo+ID4NCj4g
PiBUaGlzIHBhdGNoIHNlcmllcyBoYW5kbGVzIGNvZGUgaW1wbGVtZW50YXRpb24gZm9yIG1hbmRh
dG9yeSBmZWF0dXJlcw0KPiA+IG9mIFZvbHVtZSBPZmZzZXQgQ29udHJvbCBTZXJ2aWNlLg0KPiA+
DQo+ID4gSW1wbGVtZW50YXRpb24gb2YgZm9sbG93aW5nIGZlYXR1cmVzIGhhdmUgYmVlbiBoYW5k
bGVkIGluIHRoaXMgcGF0Y2gNCj4gPiBzZXJpZXMNCj4gPiAtIFZvbHVtZSBPZmZzZXQgQ29udHJv
bCBTZXJ2aWNlDQo+ID4gLSBWb2x1bWUgT2Zmc2V0IFN0YXRlIENoYXJhY3RlcmlzdGljIChSZWFk
LCBOb3RpZnkpDQo+ID4gLSBBdWRpbyBMb2NhdGlvbiBDaGFyYWN0ZXJpc3RpYyAoUmVhZCkNCj4g
PiAtIFZvbHVtZSBPZmZzZXQgQ29udHJvbCBQb2ludCBDaGFyYWN0ZXJpc3RpYyAoV3JpdGUpDQo+
ID4gLSBBdWRpbyBPdXRwdXQgRGVzY3JpcHRpb24gQ2hhcmFjdGVyaXN0aWMgKFJlYWQpDQo+ID4g
LSBTZXQgVm9sdW1lIE9mZnNldA0KPiA+DQo+ID4gQWxsIHRoZSBjb2RlIGltcGxlbWVudGF0aW9u
IGhhcyBiZWVuIHRlc3RlZCB1c2luZyBQVFMgdGVzdGluZyB0aGUNCj4gPiB2ZXJkaWN0IGlzIFBB
U1MgZm9yIGFsbCBtYW5kYXRvcnkgdGVzdCBjYXNlcy4NCj4gDQo+IEdyZWF0LCB0aG91Z2ggYXQg
dGhpcyBzdGFnZSBJIHRoaW5rIGl0IHdvdWxkIGJlIGV2ZW4gbW9yZSBpbXBvcnRhbnQgdG8gaGF2
ZSBhDQo+IHVuaXQgdGVzdGVyIGZvciB0aGUgYnRfdmNwIGluc3RhbmNlLCBqdXN0IGFzIHdlIGRv
IGhhdmUgZm9yIGJ0X2JhcCBhbmQgYnRfYmFzcw0KPiBpbiB1bml0L3Rlc3QtYmFwLmMgYW5kIHVu
aXQvdGVzdC1iYXNzLmMgcmVzcGVjdGl2ZWx5LCB0aGlzIHdvdWxkIGhlbHAgdXMNCj4gbWFraW5n
IHN1cmUgdGhlcmUgYXJlIG5vIG1lbW9yeSBpc3N1ZXMgYW5kIGF2b2lkIGludHJvZHVjaW5nIHJl
Z3Jlc3Npb25zDQo+IGdvaW5nIGZvcndhcmQuDQo+IA0KPiA+IFRoYW5rIHlvdSBpbiBhZHZhbmNl
IGZvciB5b3VyIHJldmlldy4NCj4gPg0KPiA+IFdhcm0gUmVnYXJkcw0KPiA+IE5pdGluIEphZGhh
dg0KPiA+DQo+ID4gTkpOWFAgKDIpOg0KPiA+ICAgQWRkZWQgaW5pdGlhbCBjb2RlIGZvciBoYW5k
bGluZyBWT0NTDQo+ID4gICBGaXhlZCB0aGUgZm9sbG93aW5nIGlzc3VlIG9ic2VydmVkIGR1cmlu
ZyBQVFMgdGVzdGluZyBmb3IgbWFuZGF0b3J5DQo+ID4gICAgIHRlc3QgY2FzZXMgLSBTcGVjaWZp
ZWQgVXBwZXIgYW5kIExvd2VyIExpbWl0IGZvciBWb2x1bWUgb2Zmc2V0IC0NCj4gPiAgICAgQ29y
cmVjdGVkIHRoZSBudW1iZXIgb2YgaGFuZGxlcyBmb3IgVk9DUyAtIFZPQ1MgaXMgbWFkZSBhcyBp
bmNsdWRlZA0KPiA+ICAgICBzZXJ2aWNlIG9mIFZDUyBiZWNhdXNlIFZPQ1MgaXMgc2Vjb25kYXJ5
IHNlcnZpY2UgYW5kIFZTQyBpcyBwcmltYXJ5DQo+ID4gICAgIHNlcnZpY2UNCj4gPg0KPiA+ICBs
aWIvdXVpZC5oICAgICAgIHwgICA1ICsNCj4gPiAgc3JjL3NoYXJlZC92Y3AuYyB8IDU0Nw0KPiA+
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgNTUwIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4NCj4g
PiAtLQ0KPiA+IDIuMzQuMQ0KPiA+DQo+IA0KPiANCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBE
ZW50eg0K
