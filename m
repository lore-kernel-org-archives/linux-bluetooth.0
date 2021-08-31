Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,
	CHARSET_FARAWAY_HEADER,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF979C432BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 09:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFF7460F46
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 Aug 2021 09:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbhHaJng (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 Aug 2021 05:43:36 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:35718 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233015AbhHaJnf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 Aug 2021 05:43:35 -0400
X-UUID: 2cf168c16cd442fbb7b075d098f2c34f-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=3BNGQD/aW7rW1rGVQycKCaaOggRDvxrkUIhKwXz1U7Y=;
        b=chB7f7lmaOCbZfXgM/BLJMHAtRyFk7kS8Ac7hZ0ed5ZquYQqMykci8w51163D9Cwe0gLqKNPsIUqOUsCYVKoMtscex3hbYAIL0VzQiPpD0oxfWKYouHA9PuZPts5Fs+yMff7/0uMYC92CMtQX6Xh0GZGBuVnlGwIHkxmfOrFJwA=;
X-UUID: 2cf168c16cd442fbb7b075d098f2c34f-20210831
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <mark-yw.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1523911956; Tue, 31 Aug 2021 17:42:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 31 Aug 2021 17:42:35 +0800
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Aug 2021 17:42:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P29q74admkQ2LVLWv9mGXConjgIoDCdHk/9/MZNs5Ld+cDN5juUIQVCixQyiG3qKV2tsiDxMcEbMpDlZ/H9JcbxDjtn82+15dCnCGs5HMKt+PhBk5taC90+IgQIpKV1wiNHEQNMGWt21WdbVek3Ybqz8C0HEk5vbBfSFL+Nbj4GU1183en93rnywYpcAjjnIWhstthhWnOJBHyw1USg+A7sMRrql0ThlRPjwuPVfsMCI34aSgVWNxEnPeUOxsWewqBUrdSIJUI6pZWnwN2y17zWGDK7SLOqCsuv+1lMUkaip1UXIcgWW3JUKOZh0FwXm2oS25qMj3mXRtoZTTeGbmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3BNGQD/aW7rW1rGVQycKCaaOggRDvxrkUIhKwXz1U7Y=;
 b=Xx/7nKkV8G9uOSbIs2U2wbsopsbFe071KlnEdmApuUX6rMUnc5q+oHZQO+HvHB8PWENFTxvDGRr/9hhxpqthlHwPnJg9RAVQux/EOOM3EZVCjMnbZPKs64QkxaGZSlSG6RYq5jqrLxujGwDLR2156TljPvpp9+FiwxaZZviBuovQrM1ad0SEQ1UYXTs628ioeHMH1r4Piuq4GDmkRxh0yGQqqRR8xeKfRQxv0sDpp4rZf3QPfblEOS7KwMbZidFrkk+7UP49fBqr6VXPtQVqkJiWxXYfGZfv4SlYdcMo2RJYjg0trPKGyBMSnP3DqehYpGkc932fneZempsXB5Cpgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BNGQD/aW7rW1rGVQycKCaaOggRDvxrkUIhKwXz1U7Y=;
 b=soEzTuyLJn7uDxfrl+IJFWKzKJTTdZ0BVGwsiBWrQd41ucjinUmTdA+dDOlQRHQs41l4laL4ybmcrnAowQAPoqnyryZexK9oCBgPRNzhDVFzZxNcz1S/u6kRvCgfLagtNEKoqK8oktdHfqRX4bl7dYGetaQlLh25X3Bn+1Snp9Y=
Received: from SL2PR03MB4457.apcprd03.prod.outlook.com (2603:1096:100:5b::16)
 by SL2PR03MB4491.apcprd03.prod.outlook.com (2603:1096:100:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.14; Tue, 31 Aug
 2021 09:42:16 +0000
Received: from SL2PR03MB4457.apcprd03.prod.outlook.com
 ([fe80::ed51:65b7:60ec:37ea]) by SL2PR03MB4457.apcprd03.prod.outlook.com
 ([fe80::ed51:65b7:60ec:37ea%5]) with mapi id 15.20.4478.017; Tue, 31 Aug 2021
 09:42:16 +0000
From:   =?big5?B?TWFyay1ZVyBDaGVuICizr7StpOUp?= <Mark-YW.Chen@mediatek.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michaelfsun@google.com" <michaelfsun@google.com>,
        "mcchou@chromium.org" <mcchou@chromium.org>
Subject: RE: [PATCH 1/2] Bluetooth: btusb: Support public address
 configuration for MediaTek Chip.
Thread-Topic: [PATCH 1/2] Bluetooth: btusb: Support public address
 configuration for MediaTek Chip.
Thread-Index: AQHXmP72/FqZfGDmjkeSjrSolMS5o6uMLoeAgAE1qSA=
Date:   Tue, 31 Aug 2021 09:42:15 +0000
Message-ID: <SL2PR03MB4457513693916CBA07BE450BB3CC9@SL2PR03MB4457.apcprd03.prod.outlook.com>
References: <20210824154430.27689-1-mark-yw.chen@mediatek.com>
 <CF258C9C-BB3C-4C10-88B0-F6F3A03303D5@holtmann.org>
In-Reply-To: <CF258C9C-BB3C-4C10-88B0-F6F3A03303D5@holtmann.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMTM2NzhcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1iODUzNTk2NC0wYTNmLTExZWMtOTFhYS0yY2YwNWQ0NmQzNzBcYW1lLXRlc3RcYjg1MzU5NjUtMGEzZi0xMWVjLTkxYWEtMmNmMDVkNDZkMzcwYm9keS50eHQiIHN6PSIxNTEyIiB0PSIxMzI3NDg3NjUzNDM2NDI3MDkiIGg9IlNwOEpXQStZSW9STTJVWGNCdTFvYWVtWEZKQT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8ebc0b3-a09d-4891-24b7-08d96c639e35
x-ms-traffictypediagnostic: SL2PR03MB4491:
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SL2PR03MB4491F432C5492CC182AE3092B3CC9@SL2PR03MB4491.apcprd03.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jrU72MS2h3Vs7r4MScTcj0n3ozIq5+fBCEpRkV+KatshLUlZuqEUBxTnK5prBb2CNHEHkaAIEmA3bXJT2tVKiCfx4IgdaPdcavmwFA7GJ/SrAzM6f3TjhfyyGcC0ZlQuiRG+am7n4Kcr7nutWArZBnACaXsfSxvkjX5w1sIKkRiDpPrq+trYze7QOEYC3PW1la53jOyy9yOj22K1umD12PU3a+zr6/EM4wydX81AuIpA3y0rsfo5Mb+4YST+3ErUKZ4iIgZ63iqoAtPqHnuDkAE5VJzHAxqut0HhJwTotAZ/0Cv4MB2up55z92wNMUzsF4ZvZefWvfZrNZ4rYEs5TE4IRnoYuxZo1rKr/pe4277mOHgRGPl1TMaT+Y0fYdjiqcNKjDvISCA2pVXbJqJFyX2i9PnU2nxgXq2nWHiWwOWvS3QhCgeQiU2NvISdqUIfNrRO/7ZunX1MXq8jjVKsK+Jaa5DXv7P8DyT1Dm05kxxqnYb0xwFCM9FqO1zy//yRqrWXltVY+MaCDPCipEfFCKsKFWoK1RMPXLsqP8Rt/+SXoTP5+0DZnYbE/gkH2GjLFDCINU3pfpV1ylUw/4jjmtt9ROidjBzNSd8S6jQ6rE+G5gd1YXFZWAyadnzNfI2WP72RH4hgI3R76eb67R/7c5+fy01Ney28uQcwlSAJArijU2AvAy+Hk6vEIavwsuPjUw6+9DhLG+oOzHx1vVuHqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR03MB4457.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(54906003)(6916009)(26005)(64756008)(76116006)(2906002)(85182001)(55016002)(186003)(8936002)(5660300002)(66446008)(122000001)(9686003)(38100700002)(66476007)(6506007)(7696005)(316002)(71200400001)(66946007)(508600001)(52536014)(86362001)(38070700005)(66556008)(33656002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?big5?B?K1NJV24xU0dPODE3UG1taktlaFQyVkp1bUFsMVNUZmYya1J1U1FGNVJsVWZGRnBv?=
 =?big5?B?bE4rZEo5cnFiUXBPRUJzYkl3djhQRm0rQ3dFdjVNY0ZTclUvRGZZSXM3ak94dHZG?=
 =?big5?B?b2dHdXV6Zm5QdDBMSzh2QnNlM0RBRzlMemlQbXYwdE5CMVdqNjNsWXZvdVpVdkI4?=
 =?big5?B?MTZMaTZJbDJ0SEtSN05zcEw1QkNDTmZVYjlya1hxeUxHUTl6R0g4YUprY1pJYnZu?=
 =?big5?B?UkFqZ2lLbVFUUGVGT05uckJNZ0VjdmpRWWN0Ulpad2c3VWdRWFNITzhSaEZucXp4?=
 =?big5?B?alpqOUpjTEV1RlhHUG1lbmZvdFBrRGFVTENWYTNVNzYzREk3NDlUOU5iOXJhMmJq?=
 =?big5?B?ZWFndU42LzZFNUxMTmFsRW1PT3M5NGtBUXA4ZGREWXlxc05FSWlRQWpnK1h4S3Jx?=
 =?big5?B?UTFpc3VmdWdhaGVrSHdwNEh5RkpEaFFUWWpJeHhJWXBMSU05b0I0OHg2bVN3dGRx?=
 =?big5?B?N3NBM1N0SmVpb2ZTU3FkeklIaWdIcHcyMDdpZUZRdUlDZXRzTUNiMm9pRFl4N1Mz?=
 =?big5?B?T0QvQUxGQlp6T0ZIL0VqMEJyOVZTUHVkVFEySmRQWTdpblVHOWplNkc4dDg5cTBq?=
 =?big5?B?Q2VLcXAzbmQwN0M4cW1xUm1zRUJXOVdEdStzVkZ6NkRpYVQxSGdVYkQ2N3MwdHlJ?=
 =?big5?B?ZFZhYVMrYnl0T1BqYTFORk94VWc4UGFadUo2Qk1PV1pXbzlvSXBXbDhMbEttVlRr?=
 =?big5?B?OFBoNGVBY2pnTzgxRUxvK2hNLzA1RW9FVS9MVTZ2M3pkR0RPRSswU1ZuMUVhcWM5?=
 =?big5?B?dlVKVnFGb3VrbjVUbDNzZmo2RmwyWmZCb2lHaHhHUVNCZ3pXUXVCN250Z0RENmFj?=
 =?big5?B?djlOZ1BNWkxOUkpwUWdPdXl6LzBOVHV1dHZsUUt3NG1aMnEveW1xYW1XUGVHYWN4?=
 =?big5?B?ekVnNnYvY2lrdmk2QTVEbzV5YmJJMXJNOXZTZ1JUVTBjZVdxQVN4MXJoaytQNWpv?=
 =?big5?B?WktrQWdkNEFaL1B1Zm5RQUt6S0ZVdnEzOTNualU5aUFENXF6Vk9WZ3V6Q2FuMkla?=
 =?big5?B?aFJpd2R6TjZKaXBwODRBaGdNZEMrZ0VaUFpLMjZ5UG5EcHdWZU5URm5LMExBVEVO?=
 =?big5?B?MDl4dGs3NDZMaE9BTTl6SnhTaENtS2c2NW8vWGRsbG12dkdsd2xoa0hHMEVnOWpW?=
 =?big5?B?MXRJU1htcDNrSDFmZVBKM1hhcUlrM1dwaEZ1cy9MTFFCcms2a2drd3N2bXR4VXpT?=
 =?big5?B?V2NvZUJNS2ljMzlVbnRLKzRzbE5GK2MrSEkzNy8wd2I0ZWhINnNtUkNLQUZKOHZs?=
 =?big5?B?L0F5b056S1k0NkgyQ1NiMml2R1N0MXVkZDBhcTFJbXFXbG4wQ3VwK1dJVzBTOHpJ?=
 =?big5?B?bjdJRHVOc2p3TWdWck1WbXNwM0ZVU09MVDBYZldQNFFScVVIWEFRWFFGMUd0SG5U?=
 =?big5?B?SnZoSUV1YlJXZ3czNjVyaGtTN0taMC9ocndJTEdzQ1F6K2U3NklJeTU0clc1ZEhC?=
 =?big5?B?ZTBxeDVIYW9qdGNQWWNaVXdpMlJEMStma3JYREJYdmZXSzFjMStCU1FJKzlsR08y?=
 =?big5?B?Y1AzUDFLY1hYTnFHd05qL1dmdjlqc1RiZXRTS0poVmRzb3hxTUxwNURqV3B5V1hL?=
 =?big5?B?S3R3cHJmZjlBZUlBdS9tbG9ZNFZTOTR4RldFRkJ4YVdPcUMwSzQ4MkxYSC9mQzdk?=
 =?big5?Q?nddshoqLdcMltR4gB7PJEnLK99WnXq+DDM4VkGrRySXKMss/?=
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR03MB4457.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8ebc0b3-a09d-4891-24b7-08d96c639e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2021 09:42:15.9961
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVZJQgMU6V0g4jJla/yoF3RmItemMRNPxVUVofHbMFE+0pxT2kHadyWp5dnkMNl8aUUQnAlh/Rv70+Q5fCDfDWYpjt0Ry6xz/4c33rfbVc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR03MB4491
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+ID4gVGhlIE1lZGlhVGVrIGNoaXAgc3VwcG9ydCB2ZW5kb3Igc3BlY2lm
aWMgSENJIGNvbW1hbmQoMHhmYzFhKSB0bw0KPiA+IGNoYW5nZSB0aGUgcHVibGljIGFkZHJlc3Mu
IEFkZCBoZGV2LT5zZXRfYmRhZGRyIGhhbmRsZXIgZm9yIE1lZGlhVGVrDQo+ID4gQ2hpcC4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IG1hcmsteXcuY2hlbiA8bWFyay15dy5jaGVuQG1lZGlhdGVr
LmNvbT4NCj4gPiAtLS0NCj4gPiBkcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIHwgMTggKysrKysr
KysrKysrKysrKysrDQo+ID4gMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykNCj4gPg0K
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idHVzYi5jIGIvZHJpdmVycy9ibHVl
dG9vdGgvYnR1c2IuYw0KPiA+IGluZGV4IDYwZDJmY2U1OWE3MS4uNDFlN2M5ZjI4ZDgyIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0dXNiLmMNCj4gPiArKysgYi9kcml2ZXJz
L2JsdWV0b290aC9idHVzYi5jDQo+ID4gQEAgLTIyMDAsNiArMjIwMCwyMyBAQCBzdHJ1Y3QgYnRt
dGtfc2VjdGlvbl9tYXAgew0KPiA+IAl9Ow0KPiA+IH0gX19wYWNrZWQ7DQo+ID4NCj4gPiArc3Rh
dGljIGludCBidHVzYl9zZXRfYmRhZGRyX210ayhzdHJ1Y3QgaGNpX2RldiAqaGRldiwgY29uc3Qg
YmRhZGRyX3QNCj4gPiArKmJkYWRkcikgew0KPiA+ICsJc3RydWN0IHNrX2J1ZmYgKnNrYjsNCj4g
PiArCWxvbmcgcmV0Ow0KPiA+ICsNCj4gPiArCXNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIDB4
ZmMxYSwgc2l6ZW9mKGJkYWRkciksIGJkYWRkciwNCj4gSENJX0lOSVRfVElNRU9VVCk7DQo+ID4g
KwlpZiAoSVNfRVJSKHNrYikpIHsNCj4gPiArCQlyZXQgPSBQVFJfRVJSKHNrYik7DQo+ID4gKwkJ
YnRfZGV2X2VycihoZGV2LCAiY2hhbmdpbmcgTWVkaWF0ZWsgZGV2aWNlIGFkZHJlc3MgZmFpbGVk
DQo+ICglbGQpIiwNCj4gPiArCQkJICAgcmV0KTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0KPiA+ICsJ
fQ0KPiA+ICsJa2ZyZWVfc2tiKHNrYik7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30N
Cj4gPiArDQo+IA0KPiB0aGlzIGlzIG5vdCBhIHBlcm1hbmVudCBjaGFuZ2UsIGNvcnJlY3Q/IE1l
YW5pbmcgYSBwb3dlciBjeWNsZSB3aWxsIGJyaW5nIGJhY2sNCj4gdGhlIG9yaWdpbmFsIEJEX0FE
RFI/DQo+IA0KDQpZZXMsIGl0J3Mgbm90IGEgcGVybWFuZW50IGNoYW5nZS4NCkFmdGVyIGRvaW5n
IGEgcG93ZXIgY3ljbGUgb3IgTWVkaWF0ZWsgc3BlY2lmaWMgQmx1ZXRvb3RoIHJlc2V0LCBNZWRp
YXRlayBDaGlwcyB3aWxsIGJyaW5nIGJhY2sgdGhlIG9yaWdpbmFsICBCRF9BRERSRVNTLg0KDQpX
aXRoIGJlc3QgcmVnYXJkcywNCk1hcmsNCg==
