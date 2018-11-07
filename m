Return-Path: <SRS0=TbT7=NS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06FEC0044C
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:01:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C2E2081D
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Nov 2018 18:01:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C2E2081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbeKHDdJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:33:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:54471 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727168AbeKHDdJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Nov 2018 22:33:09 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2018 10:01:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,476,1534834800"; 
   d="scan'208";a="84089446"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2018 10:01:38 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 7 Nov 2018 10:01:37 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.166]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.125]) with mapi id 14.03.0415.000;
 Wed, 7 Nov 2018 10:01:37 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Hobot <michal.hobot@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: mesh: configuration.json question
Thread-Topic: mesh: configuration.json question
Thread-Index: AQHUdruiVE1KssIogUeOH+ns9Lu0OKVEmPrw
Date:   Wed, 7 Nov 2018 18:01:36 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375C130F54@ORSMSX103.amr.corp.intel.com>
References: <8781652A-AACD-4912-9A12-D7458DB85F94@silvair.com>
 <E7A583DC-3A5B-4500-881C-E22CF5C1AA17@silvair.com>
In-Reply-To: <E7A583DC-3A5B-4500-881C-E22CF5C1AA17@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTNiMmFhODgtNjIwNC00NWU1LWE5YWMtNmY0NjI1MDhiODVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidno1U1FMeDQ1YXRsT2I1MVpWWW52NlwvUjVwVjQ2d3R0cEJzQWFhK2Q0aWFtU0FVYjJPZWN5NFpIWk1oUEJRKzUifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4
LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1ibHVldG9vdGgt
DQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIE1pY2hhbCBIb2JvdA0KPiBT
ZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDcsIDIwMTggOTowMiBBTQ0KPiBUbzogbGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBtZXNoOiBjb25maWd1cmF0aW9uLmpz
b24gcXVlc3Rpb24NCj4gDQo+IERlYXIgYWxsLA0KPiBXaGVyZSBjYW4gSSBnZXQgYSBzYW1wbGUg
Y29uZmlndXJhdGlvbi5qc29uIGZpbGU/IEkgZm91bmQgYSBzYW1wbGUNCj4gY29tcG9zaXRpb24u
anNvbiwgYnV0IG5vdGhpbmcgZm9yIGNvbmZpZ3VyYXRpb24uanNvbi4NCg0KQXJlIHlvdSBsb29r
aW5nIGZvciBKU09OIGZpbGVzIGZvciBhIG5vbi1wcm92aXNpb25lciBOb2RlLCB0aGF0IHJlZmxl
Y3RzIHRoZSBzZXR1cCBvZiB0aGUgbG9jYWwgbm9kZT8gDQoNCgkqIEJlY2F1c2UgdGhpcyBpcyBu
b3QgY29udHJvbGxlZCBieSB0aGUgU0lHLCBhbmQgd2UgY2FuIHdvcmsgb24gdGhhdCB3aXRoIHlv
dS4NCg0KDQpPciBmb3IgYSBKU09OIG9mIGEgQ29uZmlndXJhdGlvbiBEYXRhYmFzZSwgdGhhdCBp
cyB0aGUgUHJvdmlzaW9uZXIncyB2aWV3IG9mIGFsbCB0aGUgb3RoZXIgTm9kZXMgaW4gdGhlIE1l
c2ggTmV0d29yaz8NCg0KCSogVGhpcyBpcyBhIGxpdHRsZSB0cmlja2llciwgYmVjYXVzZSB0aGUg
U0lHIGhhcyBub3QgeWV0IGZpbmFsaXplZCBpdC4NCg0KDQo+IFRoYW5rcyBpbiBhZHZhbmNlLA0K
PiAtLQ0KPiBNaWNoYWwgSG9ib3QNCj4gVlAgb2YgUHJvZHVjdA0KPiANCj4gKzQ4IDYwMyA3NDQg
NjY4DQo+IA0KPiBTaWx2YWlyLCBJbmMuDQo+IDcxNyBNYXJrZXQgU3RyZWV0LCBTdWl0ZSAxMDAg
ICAgICAgICAgICAgICAgICAgICAgIHVsLiBKYXNub2dvcnNrYSA0NA0KPiBDQSA5NDEwMywgU2Fu
IEZyYW5jaXNjbyAgICAgICAgICAgICAgICAgICAgICAgICAgICAzMS0zNTggS3Jha293DQo+IFVT
QSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgUG9sYW5kDQo+IA0KPiB3d3cuc2lsdmFpci5jb20NCj4gDQo+IE5PVElDRSBUTyBSRUNJ
UElFTlQNCj4gDQo+IFdlIGluZm9ybSB5b3UgdGhhdCBTaWx2YWlyIHNwLiB6IG8uby4gd2l0aCBp
dHMgcmVnaXN0ZXJlZCBvZmZpY2UgaW4gS3Jha8OzdyAoMzEtDQo+IDM1OCksIGF0IEphc25vZ8Oz
cnNrYSBTdHJlZXQgNDQgaXMgdGhlIGNvbnRyb2xsZXIgb2YgeW91ciBwZXJzb25hbCBkYXRhLiBZ
b3UgY2FuDQo+IGZpbmQgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCBwcm9jZXNzaW5nIHBlcnNvbmFs
IGRhdGEgYW5kIHlvdXIgcmlnaHRzIGhlcmUNCj4gVGhpcyBlLW1haWwgbWVzc2FnZSBhbmQgYW55
IGRvY3VtZW50cyBhY2NvbXBhbnlpbmcgaXQgY29udGFpbiBpbmZvcm1hdGlvbg0KPiB0aGF0IGJl
bG9uZ3MgdG8gU0lMVkFJUi4gVGhpcyBlLW1haWwgaXMgbWVhbnQgZm9yIG9ubHkgdGhlIGludGVu
ZGVkIHJlY2lwaWVudA0KPiBvZiB0aGUgdHJhbnNtaXNzaW9uLCBhbmQgbWF5IGJlIGEgY29tbXVu
aWNhdGlvbiBwcml2aWxlZ2VkIGJ5IGxhdywNCj4gY29uZmlkZW50aWFsIGFuZC9vciBvdGhlcndp
c2UgcHJvdGVjdGVkIGZyb20gZGlzY2xvc3VyZS4gSWYgeW91IHJlY2VpdmVkIHRoaXMNCj4gZS1t
YWlsIGluIGVycm9yIGFuZCB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkg
cmV2aWV3LCB1c2UsDQo+IGRpc3NlbWluYXRpb24sIGRpc3RyaWJ1dGlvbiwgb3IgY29weWluZyBv
ZiB0aGlzIGUtbWFpbCBvciBhdHRhY2htZW50IGlzIHN0cmljdGx5DQo+IHByb2hpYml0ZWQuIFBs
ZWFzZSBub3RpZnkgdXMgaW1tZWRpYXRlbHkgb2YgdGhlIGVycm9yIGJ5IHJldHVybiBlLW1haWwg
YW5kDQo+IHBsZWFzZSBkZWxldGUgdGhpcyBtZXNzYWdlIGZyb20geW91ciBzeXN0ZW0uDQoNCg==
