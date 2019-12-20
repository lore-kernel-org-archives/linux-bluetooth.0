Return-Path: <SRS0=msWm=2K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C577C43603
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 08:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0683024679
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Dec 2019 08:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbfLTITR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Dec 2019 03:19:17 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:33275 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfLTITR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Dec 2019 03:19:17 -0500
Received: from Exchange.peiker-cee.de ([82.119.189.133]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1My6xz-1hkVDR1qjn-00zTfT; Fri, 20 Dec 2019 09:19:14 +0100
Received: from Exchange.peiker-cee.de (10.0.2.22) by Exchange.peiker-cee.de
 (10.0.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1591.10; Fri, 20
 Dec 2019 09:19:01 +0100
Received: from Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17]) by
 Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17%13]) with mapi id
 15.01.1591.012; Fri, 20 Dec 2019 09:18:56 +0100
From:   Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT server does not handle "Invalid Offset" and "Invalid
 Attribute Value Length" errors properly
Thread-Topic: GATT server does not handle "Invalid Offset" and "Invalid
 Attribute Value Length" errors properly
Thread-Index: AQHVtkcTjp5T3C28jE+fxYVHguuZTKfB9YQAgACpZ4A=
Date:   Fri, 20 Dec 2019 08:18:55 +0000
Message-ID: <8b4b0031b0715b9b95b57b24a31f3aa2f55e4497.camel@peiker-cee.de>
References: <a3757dc933d70f4f23b85d8a152d21dd54f6d2ff.camel@peiker-cee.de>
         <CABBYNZ+xSJn9ba1w8h_hk+RoHPCb-TWDM7syTpKVUt34Rja3Pw@mail.gmail.com>
In-Reply-To: <CABBYNZ+xSJn9ba1w8h_hk+RoHPCb-TWDM7syTpKVUt34Rja3Pw@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.207]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A890F8C1035084CAD408F5DE3F4020D@peiker-cee.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Provags-ID: V03:K1:ncgp4yqw0uBxGpHRIIPeJSF20pvkId4TYFJ4L26tQZzeM3EYq3m
 EWWSAFwPkvfrEdVrdKgiIA9uwdvDDTbjADuwuG/DgcDQmH03ML4I194xHXPS7GKkmNwm223
 Ha+HW3r2OMnvv+v2gt3s3pffP+DyYdqDGfusJ7+tKQbvGl3IjnVZGTegxfUJKxzxEVuQQot
 n71Iy+5EmFiUIzIq6gKdQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cYtt45By6nc=:cDz3X/ErMuMDgRCL6wD+E5
 fFn3ZVpK3n1XSsU/uzb6MqFW2/oDrdapOJN2xdltKE+mck83ZYnPubN1qPWTuJ7vIF6VB2EjK
 lItaMaJKhU1B8Sk/dswF6eY0ZBJb2s942WsXT+w5sWQmvLq0q5nBzhSxWR/2njwSLpo6K86Nz
 aFTJqZaowH81tuZnjfOeDzXN9OUIf7zK/RtWXkSSIBVjWTCDDxmmy358tbKIE4xAEOYWYPjy4
 kIDMN+HjS5z7oyTmiXUnTbdCY5AC/JZQOHt+F6s/trQSqGKWA2SUb4+tr7qW9Fwo9aktXKlqk
 X8AJ7iHcbbuB2fIGrEn10Lpr4Ov2AsoZjteizqvCz4Pu0bNIcO0+BaiIgeiR26snig8MJGtk9
 cyIzplD59F1ic9kvt6YQn4yoVvuDED0nMfHyrA9fGKsuC2mXUNihcBvKoWlriCwUy3Ja7fA4x
 Tjh+cSc3wSktedBMSVIKoOxp7Vp9FXMafIoCITI9P4rFigcqZ+LyGlxrjNejn+3lC9Eap9kdh
 fop4aUCZSx26lfe6/b6c2GgVQ5ekxQlADAqY3/GeQczN118VnEsmcvkebKioaisV7hXvbnO12
 X20dHi2Sq1VzvTTV9BlQDKf+Q0582bub/EQ40wEaiKlgVpcSt7w6QSD8ONrH2kv0wpaBMJqTE
 wcBO3qFbV7VbkTmnOjrTL8rKomJxJZ7mGy4QM5a/xJzpdU7tQIKHdQXmQjmXBAh3FyLurWj7c
 NMzxO0lYc219eCn0JjsYHsljYN7Y8A0/9Fw7BhidINPp3y0ovRb+iczQshcxqr+Te0W38wjFQ
 hMh/619w7v724Ck2QmTttagHajWbNQhgSE3X880W46nZHqXlLa3iVKUT23ndaibVYAZAuWcXb
 iRzx03fKrknUOllL0hELuJQ80Q2G+yIoIhGBceW+i+X3F1j9DJmnbwB87XEdN5
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiBZZXAsIEkgcmVtZW1iZXIgdGhpcyBvbmUgYWN0dWFsbHkgc2luY2Ugd2Ug
ZGlkIGZpeCBzb21ldGhpbmcgc2ltaWxhcg0KPiBpbiBaZXBoeXIgd2Ugd291bGQgbmVlZCB0byBt
b3ZlIHRoZSBlcnJvciBjaGVja2luZyB0byBleGVjdXRlLCBidHcgaXMNClRoYW5rIHlvdSwgSSds
bCB0YWtlIGEgbG9vayBvbiB0aGF0Lg0KDQo+IHRoaXMgd2l0aCBibHVldG9vdGhkIG9yIGdhdHQt
c2VydmVyIHRvb2wsIA0KVGhpcyBpcyBpbiBibHVldG9vdGhkLg0KDQo+IGdhdHQtc2VydmVyIHRv
b2wsIHRoZSBsYXRlciBpcyBwcm9iYWJseSBub3QNCj4gcmVjb21tZW5kZWQgZm9yIHF1YWxpZmlj
YXRpb24gYXMgaXQgaXMgbW9yZSBvZiBhIHZhbGlkYXRpb24gdG9vbCBpdA0KPiBtYXkgbm90IGJl
IGZlYXR1cmUgY29tcGxldGUuDQpDb3VsZCB5b3UgcGxlYXNlIHRlbGwgbWUgd2hhdCBpcyByZWNv
bW1lbmRlZCBmb3IgcXVhbGlmaWNhdGlvbj8NCg0KVGhhbmsgeW91IGluIGFkdmFuY2UhDQpLb25z
dGFudGluDQoNCg0KT24gVGh1LCAyMDE5LTEyLTE5IGF0IDE0OjEyIC0wODAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSBLb25zdGFudGluLA0KPiANCj4gT24gVGh1LCBEZWMg
MTksIDIwMTkgYXQgMTI6MzYgQU0gS29uc3RhbnRpbiBGb3Jvc3R5YW4NCj4gPA0KPiBrb25zdGFu
dGluLmZvcm9zdHlhbkBwZWlrZXItY2VlLmRlDQo+ID4gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+
ID4gQWNjb3JkaW5nIHRvIEJsdWV0b290aCBzcGVjcyAoQkxVRVRPT1RIIENPUkUgU1BFQ0lGSUNB
VElPTiBWZXJzaW9uDQo+ID4gNS4xDQo+ID4gPiBWb2wgMywgUGFydCBGIDMuNC42LjEgUHJlcGFy
ZSBXcml0ZSBSZXF1ZXN0KToNCj4gPiANCj4gPiAiLi4uIFRoZSBBdHRyaWJ1dGUgVmFsdWUgdmFs
aWRhdGlvbiBpcyBkb25lIHdoZW4gYW4gRXhlY3V0ZSBXcml0ZQ0KPiA+IFJlcXVlc3QgaXMgcmVj
ZWl2ZWQuIEhlbmNlLCBhbnkgSW52YWxpZCBPZmZzZXQgb3IgSW52YWxpZCBBdHRyaWJ1dGUNCj4g
PiBWYWx1ZSBMZW5ndGggZXJyb3JzIGFyZSBnZW5lcmF0ZWQgd2hlbiBhbiBFeGVjdXRlIFdyaXRl
IFJlcXVlc3QgaXMNCj4gPiByZWNlaXZlZC4gLi4uIg0KPiA+IA0KPiA+IEluIGNvbnRyYXJ5IHRv
IHRoZSBzcGVjcywgJ2JsdWV0b290aGQnIGlzIHNlbmRpbmcgZXJyb3IgcmVzcG9uc2UNCj4gPiBk
dXJpbmcNCj4gPiBwcmVwYXJlIHdyaXRlLiBUaGUgZm9sbG93aW5nIHBhdGNoIGNoYW5nZXMgdGhp
cyBiZWhhdmlvdXI6DQo+ID4gDQo+ID4gDQo+ID4gLS0tIGEvc3JjL3NoYXJlZC9nYXR0LXNlcnZl
ci5jICAyMDE4LTA2LTAxIDEwOjM3OjM2LjAwMDAwMDAwMCArMDIwMA0KPiA+ICsrKyBiL3NyYy9z
aGFyZWQvZ2F0dC1zZXJ2ZXIuYyAgMjAxOS0xMi0xMyAxMjoyNToyMi4wMDAwMDAwMDAgKzAxMDAN
Cj4gPiBAQCAtMTIyMyw3ICsxMjIzLDE3IEBADQo+ID4gDQo+ID4gICAgICAgICBoYW5kbGUgPSBn
ZXRfbGUxNihwd2NkLT5wZHUpOw0KPiA+IA0KPiA+IC0gICAgICAgaWYgKGVycikgew0KPiA+ICsg
ICAgICAgaWYgKCgwICE9IGVycikgJiYgKEJUX0FUVF9FUlJPUl9JTlZBTElEX09GRlNFVCAhPSBl
cnIpDQo+ID4gKyAgICAgICAgICAgICAgICYmIChCVF9BVFRfRVJST1JfSU5WQUxJRF9BVFRSSUJV
VEVfVkFMVUVfTEVOICE9DQo+ID4gZXJyKSkgew0KPiA+ICAgICAgICAgICAgICAgICBidF9hdHRf
c2VuZF9lcnJvcl9yc3AocHdjZC0+c2VydmVyLT5hdHQsDQo+ID4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIEJUX0FUVF9PUF9QUkVQX1dSSVRFX1JFUSwNCj4gPiBoYW5k
bGUsIGVycik7DQo+ID4gICAgICAgICAgICAgICAgIGZyZWUocHdjZC0+cGR1KTsNCj4gDQo+IFll
cCwgSSByZW1lbWJlciB0aGlzIG9uZSBhY3R1YWxseSBzaW5jZSB3ZSBkaWQgZml4IHNvbWV0aGlu
ZyBzaW1pbGFyDQo+IGluIFplcGh5ciB3ZSB3b3VsZCBuZWVkIHRvIG1vdmUgdGhlIGVycm9yIGNo
ZWNraW5nIHRvIGV4ZWN1dGUsIGJ0dyBpcw0KPiB0aGlzIHdpdGggYmx1ZXRvb3RoZCBvciBnYXR0
LXNlcnZlciB0b29sLCB0aGUgbGF0ZXIgaXMgcHJvYmFibHkgbm90DQo+IHJlY29tbWVuZGVkIGZv
ciBxdWFsaWZpY2F0aW9uIGFzIGl0IGlzIG1vcmUgb2YgYSB2YWxpZGF0aW9uIHRvb2wgaXQNCj4g
bWF5IG5vdCBiZSBmZWF0dXJlIGNvbXBsZXRlLg0KPiANCj4gDQoNCg==
