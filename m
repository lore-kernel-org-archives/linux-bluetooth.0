Return-Path: <SRS0=nKc5=7J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17544C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 13:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1453207CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 May 2020 13:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=BluetoothSIG.onmicrosoft.com header.i=@BluetoothSIG.onmicrosoft.com header.b="dLziFg0L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388544AbgE0NlQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 May 2020 09:41:16 -0400
Received: from mail-bn7nam10on2069.outbound.protection.outlook.com ([40.107.92.69]:24128
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387627AbgE0NlP (ORCPT <rfc822;Linux-bluetooth@vger.kernel.org>);
        Wed, 27 May 2020 09:41:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fj83YsC7z6M4vTPHSrUTn2oW4AqzbNJQYPmH+ZTXoFfIRbVTkbrXC9enpLWrmgdtg+W7jWNHKsHrQbThOPR9zb05B187xv4e4kOGDybRaV7Rb9gClDOfEAZKJWSSXNmQXsVJ17+MZZ1u7m72RrqqRJqXiYv/jpUMmBB2QrCutj72goersfxHMoqeGbh9b/wuCdYWCNW6PejBUGU4W6htTG5orPKqyA7Z4KnahcHOiY89vxX5PF9gW9K76EV+STcOsZQoBPs8NNWHhgcRQTVb7CqQXzqA22L62Q2LzxiK5uRQz0FJcCgeXMpcYybpxW8GhY4yUCIMXZULlbjCBIENig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2k+wl050eO5VT28d9GbB115OXXcg/Rp4zPIIHpMtso=;
 b=Ax0ohtL1j59JisIWsKcmmhYao9nR/RyabnYCWKOpdqoxkhDAL+htX0kHEU1s8C3IyDseW1GVhfZSF/qZdEnCgBfng8lB7XhvadpwWZME9IR8Ss0KlcLi6bVFGs9OvSuDOS2cQy6Qwg3anrIumMrsK0tCMr2ZM9nIFrk5uXiHC27+MAMwDvrIcOGIc9Cpu0qS0WT/32wPNl67kjpgnB9VnoulsL4idX0RldSUw/CurPEHN0uB/beAieIYasNXbrftwq1BFWvX/+eWcU56rgv5BiJzHSGlnRYty6BH9SsT3m+R6Vwv2m3iyh/6tSS24ngvgQvjeIsnv4W6eVAMXpeV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bluetooth.com; dmarc=pass action=none
 header.from=bluetooth.com; dkim=pass header.d=bluetooth.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=BluetoothSIG.onmicrosoft.com; s=selector2-BluetoothSIG-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2k+wl050eO5VT28d9GbB115OXXcg/Rp4zPIIHpMtso=;
 b=dLziFg0LiekaTlsR+x3ym7aZPBkvFa5mpp0rdxZ4G/FCKSzE4SCM1tSg/N551bnB7peymfD2Oa14PonU2P6E81Q/e0vH3ZnB4b/Mt6rbQaJAy9fMOadEBdN7MjJoNFmBOv2rJV8YeN64FHXsrA1TmBCCDTrHHm6KOvzpeFXyFXw=
Received: from DM5PR17MB1963.namprd17.prod.outlook.com (2603:10b6:3:84::9) by
 DM5PR17MB0921.namprd17.prod.outlook.com (2603:10b6:3:26::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3021.24; Wed, 27 May 2020 13:41:12 +0000
Received: from DM5PR17MB1963.namprd17.prod.outlook.com
 ([fe80::89d4:7215:b5e0:9190]) by DM5PR17MB1963.namprd17.prod.outlook.com
 ([fe80::89d4:7215:b5e0:9190%3]) with mapi id 15.20.3021.030; Wed, 27 May 2020
 13:41:12 +0000
From:   Martin Woolley <mwoolley@bluetooth.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "Linux-bluetooth@vger.kernel.org" <Linux-bluetooth@vger.kernel.org>
Subject: RE: Comments on the ConnectDevice API function
Thread-Topic: Comments on the ConnectDevice API function
Thread-Index: AdYwEgyeeFpEUtO5S3yfGGFiF3wWKwATy/wAAPJSTdA=
Date:   Wed, 27 May 2020 13:41:12 +0000
Message-ID: <DM5PR17MB1963CCA502759CB08EB9FFE1C5B10@DM5PR17MB1963.namprd17.prod.outlook.com>
References: <MWHPR17MB19671EAD4D74EA7BC5915CA7C5B40@MWHPR17MB1967.namprd17.prod.outlook.com>
 <CABBYNZKonvHxnabQsu84rVQEPpou45UgqVUECZ2HoTdd7pWT+A@mail.gmail.com>
In-Reply-To: <CABBYNZKonvHxnabQsu84rVQEPpou45UgqVUECZ2HoTdd7pWT+A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=bluetooth.com;
x-originating-ip: [82.35.96.178]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a8f9d1-21ce-4dc4-ddca-08d802439ed2
x-ms-traffictypediagnostic: DM5PR17MB0921:
x-microsoft-antispam-prvs: <DM5PR17MB09218D7168587A10FD5EFA36C5B10@DM5PR17MB0921.namprd17.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dt5O1Kb5Jajb4LN83qAKHCu35qzRUPNmdcaU7fgTB7wKvIegvdoENgQaJW4OXFTsGO9zEK7qwrrXPz0rE+lTKq/Tz5STc7BqbA2MFx/o5sLrSKaKmH/ti0RKMbz01yd5BJcnQjmv+JPA1ML0mpTZtGQImx2H/5Hnmc76QZ251AxxmFsnrHgepmEag6cNdGpHlwDGvqqkVKRODOTyP3MMbswA9HSmhZc+4+Q0IYLnxSRukFVwzkzLDUjuXJdUEYYsvOCE3dGQ/22Vgx79AXoTrnmd3t8JQ2KES7OWSkZhgFuX3GN5dV0NI90M1WDkOQRqNjkks3zYFy/OyKo1QGCoqeQefajzcE+G16u33CG4RY27SjcUw4QlsuSRmxGt7TFCUEYSlUhLuy4NnuTuzbIfTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR17MB1963.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(136003)(39840400004)(346002)(376002)(66946007)(64756008)(66476007)(71200400001)(76116006)(6916009)(8936002)(9686003)(55236004)(5660300002)(4326008)(33656002)(66446008)(53546011)(26005)(83380400001)(186003)(6506007)(86362001)(52536014)(66556008)(2906002)(7696005)(45080400002)(8676002)(966005)(508600001)(316002)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: sOvSOVAEgubA2nSloWsBLqmeTKsXAUlFDygfnP8s8h6/zn03LYY9bIGjK95s8UXs8jYMz+mFhWE6dd3z2Tl/ns+dz4+KGZliHKroDGj/mTiVr0TBbUW3GSPNjKigBp1T1yyf4q+8pKmjUUndH07KfnvLxbKn5rkMta1gBTz8rKserEvUWw4ZGpSDPhHj0to1zbbBjlhwy7Qf2oxbWXGLekXc4k4zTY5rHqnF7y/UHfnOO99Rje+JmBm6xh9+5bS+UhVQfenp63cPdwaojfAIMwBfUptcFeixeiP0/Lga+kpXRnx0ChAoNm7KDgt9n7SJENsyYxzhj5QyFMlU4ma3x3MlhZlAwnVacY9FOcv1e6BxkImTipFHKFg6+92UUBp7qMDGqITiYnaO+NM/Vk+82VUewbQXqBkKhE7345kF+cgu6RQb3cGVwMr5RD4Vh7D0JtWiEwNGLbayX/6kq0yvj2+8RD4TZFJSLFwVmdVTyq8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Bluetooth.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a8f9d1-21ce-4dc4-ddca-08d802439ed2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 13:41:12.1370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e4e0fec5-fc6c-4dd6-ae37-4bdb30e156b9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8FRRjDP2xGat4vTjqQtXweOZEn8n4LXSeTOg/Pd8/3ynjAW8Zl2E6/MfI8ttlqYONJXwWePKCm4qmbDHAMfuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR17MB0921
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeg0KDQp0aGFua3MgZm9yIHlvdXIgcmVzcG9uc2UuIE11Y2ggYXBwcmVjaWF0ZWQuIEkg
bXVzdCBjb25mZXNzIHRoaXMgaXMgdGhlIGZpcnN0IHRpbWUgSSd2ZSB1c2VkIHRoZSBCbHVlWiBB
UElzIGRpcmVjdGx5ICh2aWEgRC1CdXMpLiANCg0KSSdtIGFsbCBmb3IgaGlkaW5nIGltcGxlbWVu
dGF0aW9uIGRldGFpbHMgd2hlcmUgcG9zc2libGUgaW4gQVBJcyBhbmQgbWFraW5nIHRoZSBBUEkg
aXRzZWxmIHRha2UgY2FyZSBvZiBjb25kaXRpb25hbCBhc3BlY3RzIGlmIHBvc3NpYmxlLCBidXQg
dGhlc2Ugd2VyZSBqdXN0IG15ICQwLjAyLCBubyBtb3JlIHRoYW4gdGhhdC4gSSB3YXNuJ3QgYXdh
cmUgb2YgdGhlIGJhY2tncm91bmQgb3IgdGhlIHBoaWxvc29waHksIHNvIHRoYW5rcyBmb3IgdGhh
dCBpbnNpZ2h0IGFzIHdlbGwuDQoNCkhhdmluZyB0aGUgQVBJIHRha2UgY2FyZSBvZiB0aGUgQWxy
ZWFkeUV4aXN0cyBlcnJvciBieSBwcm92aWRpbmcgYSBjb25uZWN0aW9uIHRvIHRoZSBhbHJlYWR5
IGRpc2NvdmVyZWQgZGV2aWNlLCB0cmFuc3BhcmVudGx5IGRvZXMgc2VlbSBhIG5pY2UgdG91Y2gg
Zm9yIHRoZSBhcHBsaWNhdGlvbiBkZXZlbG9wZXIgYnV0IGNlcnRhaW5seSBub3QgZXNzZW50aWFs
Lg0KDQpBbGwgdGhlIGJlc3QNCg0KTWFydGluDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0t
DQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4gDQpT
ZW50OiAyMiBNYXkgMjAyMCAxODo0OQ0KVG86IE1hcnRpbiBXb29sbGV5IDxtd29vbGxleUBibHVl
dG9vdGguY29tPg0KQ2M6IExpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6
IFJlOiBDb21tZW50cyBvbiB0aGUgQ29ubmVjdERldmljZSBBUEkgZnVuY3Rpb24NCg0KSGkgTWFy
dGluLA0KDQpPbiBGcmksIE1heSAyMiwgMjAyMCBhdCAxOjI1IEFNIE1hcnRpbiBXb29sbGV5IDxt
d29vbGxleUBibHVldG9vdGguY29tPiB3cm90ZToNCj4NCj4gSGVsbG8NCj4NCj4gSSd2ZSByZWNl
bnRseSBiZWVuIHdvcmtpbmcgd2l0aCBCbHVlWiB2aWEgRC1CdXMgYW5kIGhhdmUgYSBzaXR1YXRp
b24gd2hpY2ggcmVxdWlyZXMgbWUgdG8gYmUgYWJsZSB0byBjb25uZWN0IHRvIGEgZGV2aWNlIHdo
b3NlIEJsdWV0b290aCBkZXZpY2UgYWRkcmVzcyBpcyBrbm93biwgYnV0IHdpdGhvdXQgZmlyc3Qg
c2Nhbm5pbmcuIFRoaXMgaXMgYSBsaW5rIGxheWVyIHN0YXRlIHRyYW5zaXRpb24gd2l0aCB0aGUg
c3BlY2lmaWNhdGlvbiBhbGxvd3MuDQo+DQo+IEJsdWVaIGN1cnJlbnRseSBzdXBwb3J0cyB0aGlz
IHZpYSBhbiBBUEkgYWRhcHRlciBmdW5jdGlvbiBjYWxsZWQgQ29ubmVjdERldmljZSwgd2hvc2Ug
c3RhdHVzIGlzIGN1cnJlbnRseSAiZXhwZXJpbWVudGFsIi4gRnJvbSBteSBleHBlcmllbmNlIG9m
IHVzaW5nIHRoaXMgZnVuY3Rpb24sIGl0IHNlZW1zIHRvIGJlaGF2ZSBsaWtlIHRoaXM6DQo+DQo+
IElmIHRoZSBCbHVlWiBpbnN0YW5jZSBoYXMgbm90IHNjYW5uZWQgeWV0LCBzbyB0aGF0IHRoZSB0
YXJnZXQgZGV2aWNlIGlzIG5vdCBrbm93biB0byBpdCwgdGhlIENvbm5lY3REZXZpY2UgY2FsbCBy
ZXN1bHRzIGluIHNjYW5uaW5nIHRha2luZyBwbGFjZSBhbmQgdGhlbiBpZiB0aGUgdGFyZ2V0IGRl
dmljZSBpcyBmb3VuZCwgaXQgaXMgY29ubmVjdGVkIHRvLiBTdWNjZXNzIQ0KPg0KPiBCdXQgaWYg
c2Nhbm5pbmcgaGFzIHByZXZpb3VzbHkgYmVlbiBwZXJmb3JtZWQsIHJlZ2FyZGxlc3Mgb2YgdGhl
IHN0YXRlIG9mIHRoZSBhY3R1YWwgZGV2aWNlIChlLmcuIGFkdmVydGlzaW5nIGFuZCByZWFkeSB0
byBhY2NlcHQgY29ubmVjdGlvbnMpLCBhbiBleGNlcHRpb24gaXMgdGhyb3duIHdpdGggYSBtZXNz
YWdlIHdob3NlIHRleHQgdmFsdWUgaXMgIkFscmVhZHkgRXhpc3RzIi4NCj4NCj4gSSB3YXMgd29u
ZGVyaW5nIGlmIEkgY291bGQgaW5mbHVlbmNlIHRoZSBkZXNpZ24gb2YgdGhlIEFQSSBiZWZvcmUg
dGhlIENvbm5lY3REZXZpY2UgZXhwZXJpbWVudGFsIHN0YXR1cyBpcyByZW1vdmVkPw0KPg0KPiBJ
IHdvdWxkIGxpa2UgdG8gc3VnZ2VzdCB0aGF0IHRoZXJlIHNob3VsZCBiZSBubyBuZWVkIGZvciBh
IHNwZWNpYWwgQVBJIHRvIGNvbm5lY3QgZGlyZWN0bHkgdG8gYSBkZXZpY2Ugd2l0aG91dCBmaXJz
dCBzY2FubmluZy4gV2h5IGJ1cmRlbiB0aGUgYXBwbGljYXRpb24gZGV2ZWxvcGVyIG5lZWRpbmcg
dG8gY2FsbCBpdCBqdXN0IGluIGNhc2UgdGhpcyBjb25kaXRpb24gYXBwbGllcywgY2F0Y2hpbmcg
dGhlIEJsdWVaIGV4Y2VwdGlvbiAoIkFscmVhZHkgRXhpc3RzIikgYW5kIHJlc3BvbmRpbmcgYnkg
dGhlbiBjYWxsaW5nIHRoZSBub3JtYWwgQ29ubmVjdCBBUEk/DQoNCkkgZ3Vlc3MgdGhlIGludGVu
dGlvbiB3YXMgdG8gaGF2ZSB0aGUgYXBwbGljYXRpb24gdXNlIHRoZSBpbnRlbmRlZCBBUEkgZm9y
IGRldmljZXMgYWxyZWFkeSBwcmVzZW50IF9iZWZvcmVfIGNhbGxpbmcgQ29ubmVjdERldmljZSwg
c28gYmVmb3JlIGVudGVyaW5nIHRoZSBhZGRyZXNzIG1hbnVhbGx5IHRoZSBhcHBsaWNhdGlvbiB3
b3VsZCBlbnVtZXJhdGUgdGhlIGV4aXN0aW5nIGRldmljZXMgYW5kIGZpZ3VyZSBvdXQgaWYgdGhh
dCB3YXMgYWxyZWFkeSBwcmVzZW50Lg0KDQo+IEFuIGFsdGVybmF0aXZlIHdvdWxkIGJlIHRvIGFj
Y29tbW9kYXRlIHRoaXMgc3BlY2lhbCBjYXNlIChub3Qgc2Nhbm5lZCBiZWZvcmUpIGluIHRoZSBp
bXBsZW1lbnRhdGlvbiBvZiB0aGUgc3RhbmRhcmQgZGV2aWNlIENvbm5lY3QoYmRhZGRyKSBmdW5j
dGlvbiBvciBpZiB0aGF0IG1ha2VzIG5vIHNlbnNlIGJlY2F1c2UgRGV2aWNlIG9iamVjdHMgbXVz
dCBjb3JyZXNwb25kIHRvIHByZXZpb3VzbHkgZGlzY292ZXJlZCwgcGh5c2ljYWwgZGV2aWNlcywg
dGhlbiBhdCBsZWFzdCB0aGUgYWRhcHRlciBDb25uZWN0RGV2aWNlIGZ1bmN0aW9uIGNvdWxkIHRh
a2UgY2FyZSBvZiB0aGUgdHdvIHBvc3NpYmxlIHBhdGhzIGFuZCBzaW1wbGlmeSBtYXR0ZXJzIGZv
ciB0aGUgYXBwbGljYXRpb24gZGV2ZWxvcGVyLg0KDQpJIGd1ZXNzIHlvdSBwcm9iYWJseSBrbm93
IHRoaXMgYnV0IGp1c3QgaW4gY2FzZSBzb21lb25lIGxvb2sgYXQgdGhlIGFyY2hpdmVzIGl0IGlz
IGJldHRlciB0aGF0IHdlIG1ha2Ugc29tZSB0aGluZ3MgY2xlYXJlciwgd2hpbGUgdGhlIGNvcmUg
c3BlYyBhbGxvd3MgY29ubmVjdGluZyB3aXRob3V0IHNjYW5uaW5nIEQtQnVzIGFyZSBpbnRlbmQg
dG8gYmUgYSBoaWdoZXIgbGV2ZWwgQVBJIHRodXMgd2h5IENvbm5lY3REZXZpY2Ugd2FzIG5vdCBy
ZWFsbHkgbmVjZXNzYXJ5IGZvciBhIGxvbmcgdGltZSBhbmQgd2UganVzdCBpbnRyb2R1Y2VkIGl0
IGZvciBxdWFsaWZpY2F0aW9uIHB1cnBvc2Ugb3Igd2hlbiB0aGVyZSBhcmUgbXVsdGlwbGUgYWRh
cHRlciB3aGVyZSBvbmUgYWN0cyBhcyBzY2FubmVyLiBBbHNvIGV2ZXIgc2luY2UgdGhlIGludHJv
ZHVjdGlvbiBvZiBwcml2YWN5IChyYW5kb20gYWRkcmVzc2VzKSBBUElzIHRoYXQgdGFrZXMgYWRk
cmVzc2VzIGJlY29tZXMgcmF0aGVyIGNvbXBsaWNhdGVkIHRvIGJlIHVzZWQgZGlyZWN0bHksIGFu
ZCB0aGVyZSBleGlzdHMgd2F5cyB0byBzY2FuIGZvciBhIHNwZWNpZmljIGFkZHJlc3Mgd2l0aCBw
YXR0ZXJuIGZpbHRlcmluZzoNCmh0dHBzOi8vbmFtMTIuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0
bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmdpdC5rZXJuZWwub3JnJTJGcHViJTJGc2NtJTJG
Ymx1ZXRvb3RoJTJGYmx1ZXouZ2l0JTJGdHJlZSUyRmRvYyUyRmFkYXB0ZXItYXBpLnR4dCUyM24x
MjImYW1wO2RhdGE9MDIlN0MwMSU3QyU3Q2ZhZmNiMGY5NDAwNTQ4Njc2MTI1MDhkN2ZlNzg2NmZi
JTdDZTRlMGZlYzVmYzZjNGRkNmFlMzc0YmRiMzBlMTU2YjklN0MwJTdDMCU3QzYzNzI1NzY2NTQw
MDc4NzEyNSZhbXA7c2RhdGE9SXklMkZ3V2t4cyUyRnlXM2dMMjM5RkxXZG9EUkdhMGFwYjYzV3hN
aFl3Um9uZU0lM0QmYW1wO3Jlc2VydmVkPTANCg0KVGhhdCBzYWlkIEkgZG9uJ3Qgb3Bwb3NlIHRv
IHJlbW92ZSBBbHJlYWR5IEV4aXN0cyBlcnJvciwgYnV0IHdlIHNob3VsZCBiZSB2ZXJ5IGNsZWFy
IHRoYXQgdGhlIHVzZSBvZiBzdWNoIEFQSSBzaG91bGQgb25seSBiZSByZWNvbW1lbmRlZCB3aXRo
IHVzZXJzIGlucHV0IGFuZCBkb2VzIG5vdCBzdWJzdGl0dXRlIHRoZSBsaWtlcyBvZiBEZXZpY2Uu
Q29ubmVjdC4NCg0KLS0NCkx1aXogQXVndXN0byB2b24gRGVudHoNCg==
