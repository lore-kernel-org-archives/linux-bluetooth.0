Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A563EE49A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 09:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbjHWJeb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjHWJdg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 05:33:36 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01olkn2090.outbound.protection.outlook.com [40.92.65.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB8A1BCA
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Aug 2023 02:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sux7D1gnUDRI7rOqfsX+HZRm7knikYghx3GvZGC6+5m6SGBnufeGIbVCwTdQPudJskNN3bgf2PFW8s7E4nLiEWpS2VYaR5UGgi4bSqs8UdSixkZCKcJTbN0FPnD+6O5n0Vp9jHgmlubO5VNqBhYfDvT/GrsZa4Vj2v48cTQwk+WMmD2YjZg8COrpSbuOBvf66bqfyQl/Et+kuj6Y4Lflpj41GrA2FsHFM18McUm5vHsyS/EqlMq6kkhiFNktcrvBzzxgr9EHo26wYGPklQFLaetL0g07+tTHbUSKDtHPF70id7nd2rzAujiSoeVRHWB1Bxj4zYM6RSlZbHDz2Iz42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPYoYz8iYcVnYRCwMybr40zoW3PmtKBepeOgB6Gsg6E=;
 b=VBsgctVe58f/837Z96waHShqjiPNk71CHT3dyBcnibbleEt4Vs0WH0ramPbBZWFiGZk6591Nr4r5ZPFlf9hYZJRxZJS41LQKCrIFBJ4t7uk1zn140y9q8QWxkI91jcknQVk/l8OU5uBWHpe/zTpuqYzE9bBI+gli/nj/yn2QgwPpbG5wCY/+O49Yskmi8I7IC2ALRFqeSyD+jTWVfl5pazUzYPGLyi/uHvKpdz/lfP4EefpqkI0oUedX5y7wesuCcoKgsjh2KKClFKwnie2O8lW5QHGnMb3HS9E5Gt3aOF/64xgWoXtb5T3O/X1JLwJvYuwuNje4wxu78yuRzjI8XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPYoYz8iYcVnYRCwMybr40zoW3PmtKBepeOgB6Gsg6E=;
 b=fXkcNIwYFiHu2VFGaTSQ0NcKevIYCpe1a0TrSsj7X0VDhdhuUHtCEvKZPU+6KKkwf2XwCMpooU83i9n0Nj8adFXpEX4ux48H5+sPapwS6SIEpjZgC7Il7xGyEmBxKu6TFYlOY36tKUyBwxgAu4yVUwxqVJUs2uL8gMRQJax6AWPTfCah8ey1cKmig+eLUN6OfDDLBRc3DKGZy+7L5Nz1ju9ucHU+WTU2gBhYsXoK3BRw3uY3b8UHfTNhTxf7T3vKld1c5aRdu5tKoQ+VT+R1F6Ypz7n1CoTm2hxz+yYeQYcAUtEtqG+yitna3KzERWuqN1IkVto20GuhfUSLIZ+9vg==
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:30::18)
 by AM7P191MB0678.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:135::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 09:21:42 +0000
Received: from AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33]) by AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
 ([fe80::9f66:6cda:606:fa33%4]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 09:21:42 +0000
From:   Bruno Pitrus <brunopitrus@hotmail.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Thread-Topic: [PATCH] Bluetooth: HCI: Introduce HCI_QUIRK_BROKEN_LE_CODED
Thread-Index: AQHZ1TNtniBhsdYoPEWV9bmXCdZt4q/2wccAgADK24CAAA9pAA==
Date:   Wed, 23 Aug 2023 09:21:41 +0000
Message-ID: <5704690.DvuYhMxLoT@bruno-beit>
References: <20230822191444.3741307-1-luiz.dentz@gmail.com>
 <CABBYNZ+2yrD3R+x2GeCdG+J25KkWoQX_FJuPNLMm9Fr7Tvab1A@mail.gmail.com>
 <8c395313-5e2d-4c27-969c-019eabacd6cf@molgen.mpg.de>
In-Reply-To: <8c395313-5e2d-4c27-969c-019eabacd6cf@molgen.mpg.de>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [WedJ13Y3R4E5FRBjCG9yVghr6MEilXfq]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6P191MB0501:EE_|AM7P191MB0678:EE_
x-ms-office365-filtering-correlation-id: 5c2599c3-4332-47cc-b990-08dba3ba5cd8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SPSbwMIBdnpT0mDtnJquvqB2y2ahPq2GHdxRWHHSs+XhSt8cfMNH8kny9OaZpHzWX8IhQiKcTD07YTdP1HlHT816Vl80mpxAGz0kC2WsavGo0Kdh/NzcNjmZgytB32zAffg4GkijXkB99Oi6/6jADDotXIZlyqz6z6GKNJBY4j8KdrGhgEYEhn1EZRe2oKfgb54s4j2UzCIekZg2BZJbLBxEBMQE5IMhwosIpd1uexFsnRfbG3DMkyI3kM/AvmhNxHvhJgSHpp1qkw8+zwzJAwXI65oOzogzIIkDHfQ/WA6SxrMbgwnKL8XmIQeZDFM+7OWyHOdH3B0ZN3eFLoaD8LODUrmxKD1BD9B9dgOIZ71yV8UVmtlcpqfw0oYUUkUrad45Yob2Vb7PjyVs3B0/XOQLWjuKPh2gpdIStWuIbP3MDZ9WjLpKsc9Q4DqpvHNbE52n3x4PuDUtgA6SEBGRCku8pqZdIHgH4o3q41nj1L0VGPt1J1Xzk2SELCikL053sT7mBW4vZ13nTDTPi2A5F2eQq7XAPDiAN91TQyi6DGOjAI36ySMWTwKj+dordn5J5IcqA9X4ocAslsfBMTHg5g==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b3JoV3lxSXJLQVVwYks1WWZ6Y3FYNUVqejA1VEFCUHkySzhDTitUTW55TVV1?=
 =?utf-8?B?bGJTaUpDSExpVnNGSndOcjM5Mk11VEVHMTJ5TlNNbWJYNXQwcGFvSlZ3Zks4?=
 =?utf-8?B?UC91OFl4SWd2NXI0bzR4T00vU01aOFpXS2JuTTFwdGRFeXUxMWVFVjlPa2x2?=
 =?utf-8?B?T0VYUnoyY2J6cHY0R0xjMDlXQlhjNVZna3FFWGRDcXdrcGw3eWpqUGdYdGtN?=
 =?utf-8?B?em54UCtRY3V0M0d4WjU1L2pzZWFkMHFYQUtkeVZRVW1rVCtJT2hRWGJQS1ZJ?=
 =?utf-8?B?a0FFWWRHQ2hxSWpESUpOaXRkVFRwY1RnM3NLWlkvOWY3WllTNnJlY2FRWnJD?=
 =?utf-8?B?Mm1jOWpWQ3BGYThjcWYrUEhrM08yQ3B4K0ZqT2xzaHg3YStUT0d2aEx6TkdB?=
 =?utf-8?B?SlJHWnFxekpTOTlOTHhqNGE5RjFJSGdzVXZhS203V0pTZGRWN1lmM0pyV2Jr?=
 =?utf-8?B?TE1KN1NINmkxeW5sNW5HeWpDRzVjeVdabmRpWndlVTh3SFh1WVIya3dMOVMy?=
 =?utf-8?B?d1V2cFMxUWJZa3kxZkdyUHdEL1ZiN1M3czJOanRqZjBWbXg5cjdzajZFZnpR?=
 =?utf-8?B?VVNwMGRDNndwWjRoMlRlTTB1TTgwQ3dwM3AxVGRBZ20vUjhKZUY0NVNyakxF?=
 =?utf-8?B?SURNQnhocUVtMVo3UXdpUkhkOHlMam1EbTAvc0lXajdtYXpWeUk2QzFPbzM3?=
 =?utf-8?B?ZWpmUVZvU3FxMVpKbHdMSDNRUGhRd1RnQWlIU0VTNjkyY3BxQlEwWUpXSzJz?=
 =?utf-8?B?Q3VUc3FXTUtlQjBwa3IrQ0gyYkEwcGZpZTBSOEVMaWJ2eWMrUzRDWU9Jb1lD?=
 =?utf-8?B?SlFLbTRyOGVBLzBSREFQNDV5TFlzOEZCQ29lWGpibnJvUGNSdFQxZjVzTkoz?=
 =?utf-8?B?cFdJWnBOZXEzYWg4MXc1TVl5ZmtQRlhQMC9DVE0rQ3RValZmT24wU2djSVo3?=
 =?utf-8?B?R2s2YnRQNlYxNUk3TUxCL2ZKRG5XN2xQZmJ0enkvRlVJYjUrbG4zRWN0RjI4?=
 =?utf-8?B?OEhSY1ZBVHN0ZmVQeUFESlA2MnVQd29zSVI1QzN5WFNFaWhqSVhjUlBFc0Mw?=
 =?utf-8?B?d1JEcUxySXhyQlg4YWl0V1NDVE1Hb3h4QjF5ckVmRHhXT2dnU0d6bmt3Rnhj?=
 =?utf-8?B?T1hlVThPbEJsWGdyWFZ4NWd0ZjZFc1VpTC83ZWhSM1RBZzhSUi93MzE2SWNF?=
 =?utf-8?B?K2JIYXg2YnFaTlNpclFONXRBeERySktzaFNsaEZ2cSs3ckhTRmhFWERQQmlV?=
 =?utf-8?B?SGtQTXB2aUdQV1pJUm9tN2cxRWllMzhuOHJjeDJJdkF1YUZDYXJsUTlvVG55?=
 =?utf-8?B?NWZBc0cxNVdvT0xQWDBTWE9IbHFSTEhjYjlCOEZzMnkybnRmZDdwWmgxSGJC?=
 =?utf-8?B?L3RmTGYvblVZQW0xZi9LdmE1SDg2bjVjbWlVN0tCeUtwR2dsZFFyaDhRNTdR?=
 =?utf-8?B?QW1pOFBiRUlKRWh0aHA1c2R2TkdiRXdHNnlQUkpYbjBNNXZzK09keVJmOTQy?=
 =?utf-8?B?WElOeGZja21TQzNrRmV2RGpCVEorYmpxM1FuRlVBeis3RGZxM0NDeFAzWmJl?=
 =?utf-8?B?VlM2WXRFTTFTZjViSVJEOUVqVURVQ096TXNBbVNkSFliSEljckNsNDRxVnVl?=
 =?utf-8?Q?xh6MX/27Oik4r/xXNuwBd7AjjeH3ahlC3lZvNAXHURik=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C5574B9BE0F60847A908CA5B173CE084@EURP191.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-50200.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6P191MB0501.EURP191.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2599c3-4332-47cc-b990-08dba3ba5cd8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2023 09:21:41.9796
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P191MB0678
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

RG5pYSDFm3JvZGEsIDIzIHNpZXJwbmlhIDIwMjMgMTA6MjY6MzEgQ0VTVCBQYXVsIE1lbnplbCBw
aXN6ZToKPiBEZWFyIEx1aXosCj4gCj4gCj4gVGhhbmsgeW91IGZvciB5b3VyIGFuc3dlci4KPiAK
PiBBbSAyMi4wOC4yMyB1bSAyMjoyMCBzY2hyaWViIEx1aXogQXVndXN0byB2b24gRGVudHo6Cj4g
PiBIaSBQYXVsLAo+ID4gCj4gPiBPbiBUdWUsIEF1ZyAyMiwgMjAyMyBhdCAxOjAx4oCvUE0gUGF1
bCBNZW56ZWwgPHBtZW56ZWxAbW9sZ2VuLm1wZy5kZT4gd3JvdGU6Cj4gPj4KPiA+PiBbQ0M6ICtC
cnVub10KPiA+Pgo+ID4+IERlYXIgTHVpeiwKPiA+Pgo+ID4+Cj4gPj4gVGhhbmsgeW91IGZvciB0
aGUgcGF0Y2guCj4gPj4KPiA+PiBBbSAyMi4wOC4yMyB1bSAyMToxNCBzY2hyaWViIEx1aXogQXVn
dXN0byB2b24gRGVudHo6Cj4gPj4+IEZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXou
dm9uLmRlbnR6QGludGVsLmNvbT4KPiA+Pj4KPiA+Pj4gVGhpcyBpbnRyb2R1Y2VzIEhDSV9RVUlS
S19CUk9LRU5fTEVfQ09ERUQgaXMgaXMgdXNlZCB0byBpbmRpY2F0ZSB0aGF0Cj4gPj4KPiA+PiDi
gKYuIEl0IGlzIHVzZWQg4oCmCj4gPj4KPiA+Pj4gTEUgQ29kZWQgUEhZIHNoYWxsIG5vdCBiZSB1
c2VkLCBpdCBpcyB0aGVuIHNldCBmb3Igc29tZSBJbnRlbCBtb2RlbHMKPiA+Pj4gdGhhdCBjbGFp
bXMgdG8gc3VwcG9ydCBpdCBidXQgd2hlbiB1c2VkIGNhdXNlcyBtYW55IHByb2JsZW1zLgo+ID4+
Cj4gPj4gdGhhdCBjbGFpbSB0byDigKYKPiA+Pgo+ID4+PiBMaW5rOiBodHRwczovL2dpdGh1Yi5j
b20vYmx1ZXovYmx1ZXovaXNzdWVzLzU3Nwo+ID4+PiBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20v
Ymx1ZXovYmx1ZXovaXNzdWVzLzU4Mgo+ID4+PiBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9saW51eC1ibHVldG9vdGgvQ0FCQllOWktjby12N3drakhIZXh4UWJnd3dTei1TPUdaPWRaS2JS
RTFxeFQxaDRmRmJRQG1haWwuZ21haWwuY29tL1QvIwo+ID4+PiBGaXhlczogMjg4YzkwMjI0ZWVj
ICgiQmx1ZXRvb3RoOiBFbmFibGUgYWxsIHN1cHBvcnRlZCBMRSBQSFkgYnkgZGVmYXVsdCIpCj4g
Pj4+IFNpZ25lZC1vZmYtYnk6IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXoudm9uLmRlbnR6
QGludGVsLmNvbT4KPiA+Pj4gLS0tCj4gPj4+ICAgIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwu
YyAgICAgIHwgIDIgKysKPiA+Pj4gICAgaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oICAgICAg
fCAxMCArKysrKysrKysrCj4gPj4+ICAgIGluY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5o
IHwgIDQgKysrLQo+ID4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkKPiA+Pj4KPiA+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0
aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYwo+ID4+PiBpbmRleCA5YjIzOWNl
OTZmYTQuLjNlZDYwYjJiMDM0MCAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbC5jCj4gPj4+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYwo+ID4+PiBA
QCAtMjc3Niw2ICsyNzc2LDggQEAgc3RhdGljIGludCBidGludGVsX3NldHVwX2NvbWJpbmVkKHN0
cnVjdCBoY2lfZGV2ICpoZGV2KQo+ID4+PiAgICAgICAgICAgICAgICBjYXNlIDB4MTE6ICAgICAg
LyogSmZQICovCj4gPj4+ICAgICAgICAgICAgICAgIGNhc2UgMHgxMjogICAgICAvKiBUaFAgKi8K
PiA+Pj4gICAgICAgICAgICAgICAgY2FzZSAweDEzOiAgICAgIC8qIEhyUCAqLwo+ID4+PiArICAg
ICAgICAgICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfQlJPS0VOX0xFX0NPREVELCAmaGRl
di0+cXVpcmtzKTsKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGZhbGx0aHJvdWdoOwo+ID4+
PiAgICAgICAgICAgICAgICBjYXNlIDB4MTQ6ICAgICAgLyogQ2NQICovCj4gPj4+ICAgICAgICAg
ICAgICAgICAgICAgICAgc2V0X2JpdChIQ0lfUVVJUktfVkFMSURfTEVfU1RBVEVTLCAmaGRldi0+
cXVpcmtzKTsKPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICBmYWxsdGhyb3VnaDsKPiA+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2kuaCBiL2luY2x1ZGUvbmV0L2Js
dWV0b290aC9oY2kuaAo+ID4+PiBpbmRleCBjNTg0MjVkNGM1OTIuLjc2NzkyMWQ3ZjVjMSAxMDA2
NDQKPiA+Pj4gLS0tIGEvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oCj4gPj4+ICsrKyBiL2lu
Y2x1ZGUvbmV0L2JsdWV0b290aC9oY2kuaAo+ID4+PiBAQCAtMzE5LDYgKzMxOSwxNiBAQCBlbnVt
IHsKPiA+Pj4gICAgICAgICAqIFRoaXMgcXVpcmsgbXVzdCBiZSBzZXQgYmVmb3JlIGhjaV9yZWdp
c3Rlcl9kZXYgaXMgY2FsbGVkLgo+ID4+PiAgICAgICAgICovCj4gPj4+ICAgICAgICBIQ0lfUVVJ
UktfVVNFX01TRlRfRVhUX0FERFJFU1NfRklMVEVSLAo+ID4+PiArCj4gPj4+ICsgICAgIC8qCj4g
Pj4+ICsgICAgICAqIFdoZW4gdGhpcyBxdWlyayBpcyBzZXQsIExFIENvZGVkIFBIWSBpcyBzaGFs
bCBub3QgYmUgdXNlZC4gVGhpcyBpcwo+ID4+Cj4gPj4gcy9pcyBzaGFsbC9zaGFsbC8KPiA+Pgo+
ID4+PiArICAgICAgKiByZXF1aXJlZCBmb3Igc29tZSBJbnRlbCBjb250cm9sbGVycyB3aGljaCBl
cnJvbmVvdXNseSBjbGFpbSB0bwo+ID4+PiArICAgICAgKiBzdXBwb3J0IGl0IGJ1dCBpdCBjYXVz
ZXMgcHJvYmxlbXMgd2l0aCBleHRlbmRlZCBzY2FubmluZy4KPiA+Pj4gKyAgICAgICoKPiA+Pj4g
KyAgICAgICogVGhpcyBxdWlyayBjYW4gYmUgc2V0IGJlZm9yZSBoY2lfcmVnaXN0ZXJfZGV2IGlz
IGNhbGxlZCBvcgo+ID4+PiArICAgICAgKiBkdXJpbmcgdGhlIGhkZXYtPnNldHVwIHZlbmRvciBj
YWxsYmFjay4KPiA+Pj4gKyAgICAgICovCj4gPj4+ICsgICAgIEhDSV9RVUlSS19CUk9LRU5fTEVf
Q09ERUQsCj4gPj4+ICAgIH07Cj4gPj4+Cj4gPj4+ICAgIC8qIEhDSSBkZXZpY2UgZmxhZ3MgKi8K
PiA+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oIGIvaW5j
bHVkZS9uZXQvYmx1ZXRvb3RoL2hjaV9jb3JlLmgKPiA+Pj4gaW5kZXggNmUyOTg4YjExZjk5Li5l
NjM1OWY3MzQ2ZjEgMTAwNjQ0Cj4gPj4+IC0tLSBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lf
Y29yZS5oCj4gPj4+ICsrKyBiL2luY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oCj4gPj4+
IEBAIC0xODE3LDcgKzE4MTcsOSBAQCB2b2lkIGhjaV9jb25uX2RlbF9zeXNmcyhzdHJ1Y3QgaGNp
X2Nvbm4gKmNvbm4pOwo+ID4+PiAgICAjZGVmaW5lIHNjYW5fMm0oZGV2KSAoKChkZXYpLT5sZV90
eF9kZWZfcGh5cyAmIEhDSV9MRV9TRVRfUEhZXzJNKSB8fCBcCj4gPj4+ICAgICAgICAgICAgICAg
ICAgICAgICgoZGV2KS0+bGVfcnhfZGVmX3BoeXMgJiBIQ0lfTEVfU0VUX1BIWV8yTSkpCj4gPj4+
Cj4gPj4+IC0jZGVmaW5lIGxlX2NvZGVkX2NhcGFibGUoZGV2KSAoKChkZXYpLT5sZV9mZWF0dXJl
c1sxXSAmIEhDSV9MRV9QSFlfQ09ERUQpKQo+ID4+PiArI2RlZmluZSBsZV9jb2RlZF9jYXBhYmxl
KGRldikgKCgoZGV2KS0+bGVfZmVhdHVyZXNbMV0gJiBIQ0lfTEVfUEhZX0NPREVEKSAmJiBcCj4g
Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIXRlc3RfYml0KEhDSV9RVUlSS19CUk9L
RU5fTEVfQ09ERUQsIFwKPiA+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJihkZXYpLT5xdWlya3MpKQo+ID4+Pgo+ID4+PiAgICAjZGVmaW5lIHNjYW5fY29kZWQoZGV2
KSAoKChkZXYpLT5sZV90eF9kZWZfcGh5cyAmIEhDSV9MRV9TRVRfUEhZX0NPREVEKSB8fCBcCj4g
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICgoZGV2KS0+bGVfcnhfZGVmX3BoeXMgJiBIQ0lf
TEVfU0VUX1BIWV9DT0RFRCkpCj4gPj4KPiA+PiBXaWxsIHRoaXMgYmUgZnV0dXJlIHByb29mLCBv
bmNlIGZpcm13YXJlIGZvciB0aGUgYnJva2VuIGNvbnRyb2xsZXJzIGFyZQo+ID4+IGZpeGVkPwo+
ID4gCj4gPiBZZXMsIGl0IHdvbid0IGNhdXNlIGFueSByZWdyZXNzaW9ucyBpZiB0aGUgZmlybXdh
cmUgaXMgZml4ZWQgaW4gdGhlCj4gPiBmdXR1cmUsIGJ1dCBMRSBjb2RlZCBQSFkgd2lsbCBuZWVk
IHRvIGJlIHJlLWVuYWJsZWQgYnkgcmVtb3ZpbmcgdGhlCj4gPiBxdWlya3MsIHRoaXMgaXMgd2h5
IHdlIHNheSBpdCBpcyBicm9rZW4gYnV0IHdlIGNhbid0IGRlcGVuZCBvbiBydW50aW1lCj4gPiBk
ZXRlY3Rpb24gYW5kIHNob3VsZCBwcm9iYWJseSBwcmludCBhIHdhcm5pbmcgdW50aWwgd2UgaGF2
ZSBhIHByb3Blcgo+ID4gZml4IGZvciBpdCBsYW5kcyBhdCB0aGUgZmlybXdhcmUgc2lkZS4gV2Ug
Y291bGQgaW4gdGhlb3J5IHNldAo+ID4gSENJX1FVSVJLX0JST0tFTl9MRV9DT0RFRCBiYXNlZCBv
biB0aGUgZmlybXdhcmUgdmVyc2lvbiBidXQgZmlybXdhcmUKPiA+IHZlcnNpb25pbmcgc2NoZW1l
cyB0ZW5kIHRvIGNoYW5nZSBzbyBJJ20gYWZyYWlkIHRoYXQgY291bGQgYWxzbyBjYXVzZQo+ID4g
cmVncmVzc2lvbiBsaWtlIHRoaXMgaW4gdGhlIGZ1dHVyZS4KPiAKPiBVbmRlcnN0b29kLiBNYXli
ZSB5b3UgY291bGQgYWRkIHRoZSBrbm93biBicm9rZW4gZmlybXdhcmUgdmVyc2lvbnMgdG8gCj4g
dGhlIGNvbW1pdCBtZXNzYWdlIGZvciBwb3N0ZXJpdHkgdGhvdWdoLgo+IAo+IAo+IEtpbmQgcmVn
YXJkcywKPiAKPiBQYXVsCj4gClRoYW5rcywKVGhpcyBwYXRjaCBwYXJ0bHkgd29ya3MgZm9yIG1l
LiBUaGUgbW91c2Ugbm93IHRha2VzIHNldmVyYWwgZG96ZW4gc2Vjb25kcyB0byBkZXRlY3Qgd2hl
cmUgdGhlIGNvbXB1dGVyIGRpZCBub3QgZmluZCBpdCBhdCBhbGwgYmVmb3JlLgpCdXQgbm90ZSB0
aGF0IGluIGtlcm5lbCA2LjMueCBpdCB3YXMgYWx3YXlzIGRldGVjdGVkIGltbWVkaWF0ZWx5Lgo=
