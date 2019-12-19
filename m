Return-Path: <SRS0=Qms+=2J=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72610C43603
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 08:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4345321D7D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 19 Dec 2019 08:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfLSIWD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 19 Dec 2019 03:22:03 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:50335 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfLSIWD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 19 Dec 2019 03:22:03 -0500
Received: from Exchange.peiker-cee.de ([82.119.189.133]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N8XHV-1hdjqo3JBJ-014Q1g; Thu, 19 Dec 2019 09:21:59 +0100
Received: from Exchange.peiker-cee.de (10.0.2.22) by Exchange.peiker-cee.de
 (10.0.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1591.10; Thu, 19
 Dec 2019 09:21:59 +0100
Received: from Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17]) by
 Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17%13]) with mapi id
 15.01.1591.012; Thu, 19 Dec 2019 09:21:59 +0100
From:   Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
To:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: GATT server does not forward written attribute to application
Thread-Topic: GATT server does not forward written attribute to application
Thread-Index: AQHVtY65nC0fDfkvg06V6Un/LPntVqfAL4SAgADfXoA=
Date:   Thu, 19 Dec 2019 08:21:59 +0000
Message-ID: <715f232cc85eb157ffa1d6d01a8566dbd6beec92.camel@peiker-cee.de>
References: <e4a4844024f9c1fd4da044a6d837e2dba17e6ea6.camel@peiker-cee.de>
         <CABBYNZLpKQ8q7j0VjKKyyf4W8DuOnez2f35RYHj8p3SnmzenXg@mail.gmail.com>
In-Reply-To: <CABBYNZLpKQ8q7j0VjKKyyf4W8DuOnez2f35RYHj8p3SnmzenXg@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.207]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0517C660B2E4A24E9D5226275D3D3C4A@peiker-cee.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Provags-ID: V03:K1:8ma0h/IblBu+IhMjmIVf6p8IzUytWFbO178Jwe2GJhosYGUaR4U
 77RYLvOiXRQESRZrfI9BQZctoxWG5bq8XhbAIU32ksnGcrdqRfPCZZ2F39jul4TJmrV5Tm5
 UVA4OwdnxwPbUs36HQqo4tSC9MbguDF3RONoeoh2Cc1b1gr/NBwyEKMpEQct4SugtWaKgkr
 v2amh4KI/3I7A7hYETGZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RQymWv/ySco=:e4URIk3LhLWzqAUqMViurU
 3pfR5ohEWvn3hUqFnysxKjOVwt/vdFgi9IDBJNWEmRddoZhVEfgRTUS4WruflWCPNPXTKFHrz
 6r2qujVctkv0gAh2eKOtDvWP/a85N/gv0Z8hgpPIrekqsC9RXQslTrUFVKNDDi1DVaGqjqgV+
 SJ5QD0xan1Jjq8z+Yc4b4fB+sf0YdX12IjFHSN+8SWc1fcgmE8P7z+GDd8Uqex0x21d5pgBpi
 3dcisWIhXHz0FsX1VvvHc5r1Svy+UwuzDbiTJ3NG0bkzQaIaqzJYmUVE3f5F/ZRik4DBRPfko
 vcJYyeGv3XWuVYEMEyEQeHlhtv0J5GOLm2n2OP6JHi8OD7tG2/xGbi265leWczmPt5Pdi5CCP
 vYxJbuaWYUrOEcZJN0NaeK8/EjWHfWKFUPKXQPxSTgaRWRGIGjYPrBX3PSGE2BBjft73XFlG/
 f+2O8WSQIOXGRQa0bRvjzrMK0Ng1GtHOzUQFpuNLOaFvZZzikLbPP3KHETiQmHjQVddy4scEj
 Fa/fPNGd/uaJ2rVAFRWHZEuy93rU7ExpuFcB6SiiCsPnvd0xi41FgWUXKoWjFI+slCWAHS7As
 tU/0JT7B2af+tgC07SSg0KcCZKycS6tKVGWFZV6GZC1gYatME6N5A9IYiVzLD2ZioNfoCXsZf
 iR5HaJAZE+J6FF+gYPyjbPnPKTi5hD8LXh8CvgEVFkhehU/IL44hihLVaEPSRsFVr2XkBMko7
 VJviIQOIr/7EKFG9T2ogyps/nzKHGjxeypPIW5XLSX4x8403lC+KXP1dRrCvuRiRdnxfsMi17
 opA3Qwzw5izDyeQBPddZzjHY8pPsNj9xvj7oi1O4ImpXo2oD2Oy6WoDiyz4ehnid/BWNZXg6D
 w33auDvTIfPsA5MHauqfZVNMCfGlhiv/Zslk2GU/yq/1inX+3kwsqTkpSKO+dH
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KVGhhbmsgeW91IGZvciB0aGUgYW5zd2VyIGFuZCBzb3JyeSBmb3IgdXNpbmcg
d3JvbmcgdGVybSwgeWVzLCBpdCdzDQphYm91dCBwcmVwYXJlIHdyaXRlLg0KDQo+IGlzIHRoZSBj
b3JyZWN0IGJlaGF2aW91ciwgaWYgeW91IG5lZWQgdGhhdCBmb3IgYXV0aG9yaXppbmcgdGhlDQo+
IHByZXBhcmUNCkRvIHlvdSBtZWFuLCBJIGhhdmUgdG8gYWRkICJhdXRob3JpemUiIGZsYWcgdG8g
dGhlIGNoYXJhY3RlcmlzdGljJ3MNCnByb3BlcnRpZXMgaW4gb3JkZXIgdG8gZW5hYmxlIHdyaXRp
bmcsIGV2ZW4gaWYgSSdtIG5vdCB1c2luZyBhbnkNCnNlY3VyaXR5IG1lY2hhbmlzbXM/IFBsZWFz
ZSBub3RlIHRoYXQgJ2J0Z2F0dC1zZXJ2ZXInIGFwcGxpY2F0aW9uIGRvZXMNCm5vdCB1c2UgRC1C
dXMgQVBJLg0KDQpJJ20gc29ycnkgZm9yIG15IGNvbW1lbnRzIHRoYXQgbWF5IHNvdW5kIHN0dXBp
ZCwgSSdtIHF1aXRlIG5ldyB0bw0KQmx1ZXRvb3RoIExFLg0KDQpCZXN0IHJlZ2FyZHMsDQpLb25z
dGFudGluDQoNCg0KT24gV2VkLCAyMDE5LTEyLTE4IGF0IDExOjAyIC0wODAwLCBMdWl6IEF1Z3Vz
dG8gdm9uIERlbnR6IHdyb3RlOg0KPiBIaSBLb25zdGFudGluLA0KPiANCj4gT24gV2VkLCBEZWMg
MTgsIDIwMTkgYXQgMjozNiBBTSBLb25zdGFudGluIEZvcm9zdHlhbg0KPiA8DQo+IGtvbnN0YW50
aW4uZm9yb3N0eWFuQHBlaWtlci1jZWUuZGUNCj4gPiB3cm90ZToNCj4gPiBIaSwNCj4gPiANCj4g
PiBEdXJpbmcgQmx1ZXRvb3RoIFF1YWxpZmljYXRpb24gdGVzdHMgd2l0aCBQVFMgSSBmb3VuZCBv
dXQgdGhhdCBpZg0KPiA+IGFuDQo+ID4gYXR0cmlidXRlIHByb3ZpZGVkIGJ5IGEgR0FUVCBzZXJ2
ZXIgY3JlYXRlZCBieSBCbHVlWiA1LjUwIHJ1bm5pbmcNCj4gPiBvbiBteQ0KPiA+IElVVCBpcyB3
cml0dGVuIGJ5IHJlbW90ZSwgdGhlIHZhbHVlIG9mIHRoaXMgYXR0cmlidXRlIGlzIG5vdA0KPiA+
IHByb3ZpZGVkDQo+ID4gYnkgJ2JsdWV0b290aGQnIHRvIHRoZSB1cHBlciBsYXllci4gV2l0aCBh
IG1pbm9yIG1vZGlmaWNhdGlvbiBvZg0KPiA+ICdibHVldG9vdGhkJyBJIG1hbmFnZWQgdG8gZ2V0
IHRoZSB0ZXN0cyB0aHJvdWdoLCBzbyBJJ2QgbGlrZSB0byBnZXQNCj4gPiBmZWVkYmFjayBmcm9t
IHRoZSBjb21tdW5pdHksIHdoZXRoZXIgdGhpcyBtb2RpZmljYXRpb24gd2FzDQo+ID4gbmVjZXNz
YXJ5IG9yDQo+ID4gbWF5IGJlIHRoZXJlJ3MgYW5vdGhlciB3YXkgb2YgZ2V0dGluZyBhdHRyaWJ1
dGUgd3JpdGUgd29ya2luZy4NCj4gPiANCj4gPiBGb3IgR0FUVCB0ZXN0cyBJIHVzZWQgJ2J0Z2F0
dC1zZXJ2ZXInIGFwcGxpY2F0aW9uIHByb3ZpZGVkIGJ5DQo+ID4gQmx1ZVouIEluDQo+ID4gb3Jk
ZXIgdG8gdGVzdCB3cml0aW5nIGNoYXJhY3RlcmlzdGljIHZhbHVlIEkgbWFkZSAiRGV2aWNlIE5h
bWUiDQo+ID4gcHJvdmlkZWQgYnkgdGhlIGFwcGxpY2F0aW9uIHdyaXRhYmxlLiBJdCB0dXJuZWQg
b3V0LCB0aGF0IHRoZQ0KPiA+ICdnYXBfZGV2aWNlX25hbWVfd3JpdGVfY2InIGZ1bmN0aW9uIHRo
YXQgaXMgY2FsbGVkIGJ5IHRoZSBkYWVtb24NCj4gPiB1cG9uDQo+ID4gd3JpdGluZyAiRGV2aWNl
IE5hbWUiIGFsd2F5cyByZWNlaXZlcyAndmFsdWU9TlVMTCcgYW5kICdsZW49MCcuIFRoZQ0KPiA+
IHJlYXNvbiBmb3IgdGhpcyBpcyB0aGF0IGluIHRoZSAnZ2F0dF9kYl9hdHRyaWJ1dGVfd3JpdGUn
IGNhbGwgaW4NCj4gPiAncHJlcF93cml0ZV9jYicgaW4gJ2dhdHQtc2VydmVyLmMnIGZpbGUgaW4g
J2JsdWV0b290aGQnIGJvdGgNCj4gPiAndmFsdWUnDQo+ID4gYW5kICdsZW4nIGFyZSBoYXJkLWNv
ZGVkIHRvIE5VTEwgYW5kIDAgcmVzcGVjdGl2ZWx5Lg0KPiANCj4gV2VsbCBub3QgYWN0dWFsbHkg
YSB3cml0ZSBidXQgYSBwcmVwYXJlIHdyaXRlLCBzbyB1bnRpbCBleGVjdXRlIGlzDQo+IGNhbGxl
ZCBub3RoaW5nIHNoYWxsIGJlIHdyaXR0ZW4sIHNvIGV4Y2VwdCBpZiBJIG1pc3Npbmcgc29tZXRo
aW5nDQo+IHRoaXMNCj4gaXMgdGhlIGNvcnJlY3QgYmVoYXZpb3VyLCBpZiB5b3UgbmVlZCB0aGF0
IGZvciBhdXRob3JpemluZyB0aGUNCj4gcHJlcGFyZQ0KPiB0aGUgeW91IHNob3VsZCBsb29rIGlu
dG86DQo+IA0KPiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vYmx1ZXRvb3RoL2JsdWV6
LmdpdC90cmVlL2RvYy9nYXR0LWFwaS50eHQjbjEwNA0KPiANCj4gaHR0cHM6Ly9naXQua2VybmVs
Lm9yZy9wdWIvc2NtL2JsdWV0b290aC9ibHVlei5naXQvdHJlZS9kb2MvZ2F0dC1hcGkudHh0I24y
NzMNCj4gDQo+IA0KPiA+IFdpdGggdGhlIGZvbGxvd2luZyBtb2RpZmljYXRpb24gaW4gJ2dhdHQt
c2VydmVyLmMnIHRoZSBjYWxsYmFjayBpbg0KPiA+ICdidGdhdHQtc2VydmVyJyBhcHBsaWNhdGlv
biByZWNlaXZlcyB0aGUgYXJndW1lbnRzIGl0IGV4cGVjdHMgYW5kDQo+ID4gdGhlDQo+ID4gR0FU
VCB0ZXN0cyBjYW4gYmUgcGFzc2VkOg0KPiA+IA0KPiA+IC0tLSBhL3NyYy9zaGFyZWQvZ2F0dC1z
ZXJ2ZXIuYyAgMjAxOC0wNi0wMSAxMDozNzozNi4wMDAwMDAwMDAgKzAyMDANCj4gPiArKysgYi9z
cmMvc2hhcmVkL2dhdHQtc2VydmVyLmMgIDIwMTktMTItMTMgMTI6MTY6NTguMDAwMDAwMDAwICsw
MTAwDQo+ID4gQEAgLTEyOTEsNyArMTI5MSw3IEBADQo+ID4gICAgICAgICBwd2NkLT5sZW5ndGgg
PSBsZW5ndGg7DQo+ID4gICAgICAgICBwd2NkLT5zZXJ2ZXIgPSBzZXJ2ZXI7DQo+ID4gDQo+ID4g
LSAgICAgICBzdGF0dXMgPSBnYXR0X2RiX2F0dHJpYnV0ZV93cml0ZShhdHRyLCBvZmZzZXQsIE5V
TEwsIDAsDQo+ID4gKyAgICAgICBzdGF0dXMgPSBnYXR0X2RiX2F0dHJpYnV0ZV93cml0ZShhdHRy
LCBvZmZzZXQsIHB3Y2QtPnBkdSArDQo+ID4gNCwNCj4gPiBwd2NkLT5sZW5ndGggLSA0LA0KPiA+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJUX0FUVF9P
UF9QUkVQX1dSSVQNCj4gPiBFX1JFDQo+ID4gUSwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzZXJ2ZXItPmF0dCwNCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBwcmVwX3dyaXRlX2NvbXBsZXRlDQo+
ID4gX2NiLA0KPiA+IHB3Y2QpOw0KPiA+IA0KPiA+IA0KPiA+IEJlc3QgcmVnYXJkcw0KPiA+IEtv
bnN0YW50aW4NCj4gPiANCj4gDQo+IA0KPiANCg0K
