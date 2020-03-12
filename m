Return-Path: <SRS0=41cZ=45=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C531C10DCE
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 18:21:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49929206EB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Mar 2020 18:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="av2WgQ60"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCLSVH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:21:07 -0400
Received: from mga05.intel.com ([192.55.52.43]:39791 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgCLSVH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Mar 2020 14:21:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Mar 2020 11:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; 
   d="scan'208";a="243124125"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 11:21:06 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:21:05 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX123.amr.corp.intel.com (10.22.240.116) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:21:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 12 Mar 2020 11:20:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlHp6JRwNFNVoq0gBcvkM3znOTMC643i52rlHMRnin5N9AjsjZ48xNcrJ0N0BBOZExxddk/p/lk5EqBgwaFcGz8ewc+Kj5mKW2CsMc66TpCHtvBMCNQdqAo94qB9uRrCkUFPMi+BkhGkwzJMzHrYl94f2FCC+3DHlhTpU0jzDtxTIFVUx7FlmsKfAUOEKJf/swnqgFHCKaqIZ2hq79+fWQBIVsyPG1AyZIV3m8Eguoj2FHxattLGHqOrqW6MXviMe+QiOofKmXZuE7SBToKZCpJUVhvxucVLkAG4P57EMYQ1IqT+Dktv3VsDsPDjjCUWIUoy/vtw1rVNAQD2HdQ/Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7qFqrbkrSO5xwSTkeBumIzxGivD3YmicLPP83qB05Q=;
 b=Ui6v4UUH1gPe6ADdVmXBfse9dy/Mz5Ew81UT6OSrevPifksWwKM/QGhZIT1+8zh1ZZnP/VqQ0CEEBA/x9kCvQyjs3G5rK4L8nRTobH+ubqC9UNOpgZFXIa2X4o2jslgFnE8Ob/I6J/QEQRFFoz4gguICR+NYJWo5wqVBpLxyDlw2zrQHNH2niD3UF1/DlQy/ZfZFd98lYAyp+UPstLq4isvW9uxpjx0qZXuhfVt+Sah7q4xxJ1sXdnGAM+sg9+WQv5x2X6yTgMUMpcNs1aOBszt0DO3b71iSZ9kqkj8TmmM+tfaM092qWTu1EzKyipw6FNI9FMbtEwioN2/3+c3vWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7qFqrbkrSO5xwSTkeBumIzxGivD3YmicLPP83qB05Q=;
 b=av2WgQ60HjCOUkA533D/NPhD47pk2PyNwqJolynq2MZXJtb3jGMEHMXAL24EtbhLob4+qPkQu6bqJh+kI2oP+bmJM228/xyoQ3B5Kukj3d+IjId6FFxfzEVk4rftvAhY62yMtLvxtbPH3oufnilcmigoYKMuVF1QQRlr1eYVf5E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4746.namprd11.prod.outlook.com (2603:10b6:303:5f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Thu, 12 Mar
 2020 18:19:59 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 18:19:59 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "testtgsh@gmail.com" <testtgsh@gmail.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] tools/mesh-cfgclient: Add support for Static OOB
 key
Thread-Topic: [PATCH BlueZ v2] tools/mesh-cfgclient: Add support for Static
 OOB key
Thread-Index: AQHV9/jQvIv81MzAhE2Mt9J8HJWpbqhFRboA
Date:   Thu, 12 Mar 2020 18:19:59 +0000
Message-ID: <662ab7993d46a10c04f4736c27b5168ac5ae5b02.camel@intel.com>
References: <20200311225940.6628-1-brian.gix@intel.com>
In-Reply-To: <20200311225940.6628-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45436727-cf26-4377-a3ae-08d7c6b1f9d5
x-ms-traffictypediagnostic: MW3PR11MB4746:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB474680B5B272479779753B4CE1FD0@MW3PR11MB4746.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:121;
x-forefront-prvs: 0340850FCD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(376002)(346002)(396003)(136003)(39860400002)(199004)(2616005)(5660300002)(86362001)(478600001)(81166006)(6506007)(8936002)(8676002)(2906002)(81156014)(26005)(6512007)(6486002)(6916009)(186003)(4326008)(36756003)(107886003)(54906003)(66946007)(66446008)(91956017)(71200400001)(316002)(66556008)(64756008)(76116006)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:MW3PR11MB4746;H:MW3PR11MB4539.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aO/Snuj0hmtOIR/jMFSmPjFdX+I1LsegGphbhghZccVPshVDEvEE9VgsoRGS0CDlglIDTUZeg+8X9tVTOnoXA1jaj/wOLNkYbzXfuxpYwtPNrsBZivtINIIxdknPILNW5iRIUlM49Q73pxnTmil1LmNMs5OIrXOp8IVTYMvBTgdJXtsEBuY0pV3VPJfmS58hP8XX2b+vhXX47WMRiHV8Z35d+YXR5orK41etlVEV4t3vF90i36LEeI/Qhu/cYw0jVQ4Py2gOAtq07cFbdWaVmeWXZzNkN0uGgBKZKI0HiFyB/j5tO7LaXbyysJXbhhTb9GGDpgPA065JOlhrwr4zro6Vby/xVA1F9hUP6igaUVDZdqjBqU/5PTHja1uouE1piBKD4nJMNaAnPEDyoMRT1cTJX9a1RsNDP95DXSREM/XKgOGdI5/PCO/gGojGitHK
x-ms-exchange-antispam-messagedata: 3UPiVcnz0Pr+4IaIY/sJfK4mERgcGwxIZA6B5fdsycI2Ra2u/PFBYVtuOwWNsB0Uf98kvzjekwLIjMQx6jGKkQFuFrQxLEgXF5MPhISv+OYQZzwdmCatfGQWfH/C4MaozagAILyBgM8Rk2M6tICUiQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A201FCA25B2ECB4BBE2AFC603A13A55D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45436727-cf26-4377-a3ae-08d7c6b1f9d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2020 18:19:59.7087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xqKl6T7X817KOkYjkgKGGJPAM/UzNEe70bXeaeZywf0prlheYFjk8xBDHZdg95SyAqKRvwf2Sx6Wi2Z8XWQyxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4746
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gV2VkLCAyMDIwLTAzLTExIGF0IDE1OjU5IC0wNzAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IFRoaXMgZml4ZXMgYSBidWcgdGhhdCBkaWRuJ3QgYWxsb3cgMTYgb2N0ZXQgU3RhdGlj
IE9PQiBzdHJpbmdzIGR1cmluZw0KPiBwcm92aXNpb25pbmcuDQo+IC0tLQ0KPiAgdG9vbHMvbWVz
aC1jZmdjbGllbnQuYyB8IDI5ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+ICB0b29s
cy9tZXNoL2FnZW50LmMgICAgIHwgMTAgKysrKysrLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAy
NSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS90b29s
cy9tZXNoLWNmZ2NsaWVudC5jIGIvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0KPiBpbmRleCBiNGQ3
NmRlOTMuLjRiN2JkMjIwMCAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC1jZmdjbGllbnQuYw0K
PiArKysgYi90b29scy9tZXNoLWNmZ2NsaWVudC5jDQo+IEBAIC0zNzIsMTIgKzM3MiwxMSBAQCBz
dGF0aWMgdm9pZCBhZ2VudF9pbnB1dF9kb25lKG9vYl90eXBlX3QgdHlwZSwgdm9pZCAqYnVmLCB1
aW50MTZfdCBsZW4sDQo+ICAJc3RydWN0IGxfZGJ1c19tZXNzYWdlICpyZXBseSA9IE5VTEw7DQo+
ICAJc3RydWN0IGxfZGJ1c19tZXNzYWdlX2J1aWxkZXIgKmJ1aWxkZXI7DQo+ICAJdWludDMyX3Qg
dmFsX3UzMjsNCj4gLQl1aW50OF90IGFzY2lpWzE2XTsNCj4gKwl1aW50OF90IG9vYl9kYXRhWzE2
XTsNCj4gIA0KPiAgCXN3aXRjaCAodHlwZSkgew0KPiAgCWNhc2UgTk9ORToNCj4gIAljYXNlIE9V
VFBVVDoNCj4gLQljYXNlIEhFWEFERUNJTUFMOg0KPiAgCWRlZmF1bHQ6DQo+ICAJCWJyZWFrOw0K
PiAgDQo+IEBAIC0zODYsMTIgKzM4NSwxOCBAQCBzdGF0aWMgdm9pZCBhZ2VudF9pbnB1dF9kb25l
KG9vYl90eXBlX3QgdHlwZSwgdm9pZCAqYnVmLCB1aW50MTZfdCBsZW4sDQo+ICAJCQlidF9zaGVs
bF9wcmludGYoIkJhZCBpbnB1dCBsZW5ndGhcbiIpOw0KPiAgCQkJYnJlYWs7DQo+ICAJCX0NCj4g
KwkJLyogRmFsbCBUaHJvdWdoICovDQo+ICANCj4gLQkJbWVtc2V0KGFzY2lpLCAwLCAxNik7DQo+
IC0JCW1lbWNweShhc2NpaSwgYnVmLCBsZW4pOw0KPiArCWNhc2UgSEVYQURFQ0lNQUw6DQo+ICsJ
CWlmIChsZW4gPiAxNikgew0KPiArCQkJYnRfc2hlbGxfcHJpbnRmKCJCYWQgaW5wdXQgbGVuZ3Ro
XG4iKTsNCj4gKwkJCWJyZWFrOw0KPiArCQl9DQo+ICsJCW1lbXNldChvb2JfZGF0YSwgMCwgMTYp
Ow0KPiArCQltZW1jcHkob29iX2RhdGEsIGJ1ZiwgbGVuKTsNCj4gIAkJcmVwbHkgPSBsX2RidXNf
bWVzc2FnZV9uZXdfbWV0aG9kX3JldHVybihtc2cpOw0KPiAgCQlidWlsZGVyID0gbF9kYnVzX21l
c3NhZ2VfYnVpbGRlcl9uZXcocmVwbHkpOw0KPiAtCQlhcHBlbmRfYnl0ZV9hcnJheShidWlsZGVy
LCBhc2NpaSwgMTYpOw0KPiArCQlhcHBlbmRfYnl0ZV9hcnJheShidWlsZGVyLCBvb2JfZGF0YSwg
MTYpOw0KPiAgCQlsX2RidXNfbWVzc2FnZV9idWlsZGVyX2ZpbmFsaXplKGJ1aWxkZXIpOw0KPiAg
CQlsX2RidXNfbWVzc2FnZV9idWlsZGVyX2Rlc3Ryb3koYnVpbGRlcik7DQo+ICAJCWJyZWFrOw0K
PiBAQCAtNTM5LDEyICs1NDQsMTYgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqcHJv
bXB0X3N0YXRpY19jYWxsKHN0cnVjdCBsX2RidXMgKmRidXMsDQo+ICAJCXJldHVybiBsX2RidXNf
bWVzc2FnZV9uZXdfZXJyb3IobXNnLCBkYnVzX2Vycl9mYWlsLCBOVUxMKTsNCj4gIAl9DQo+ICAN
Cj4gLQlpZiAoIXN0cmNtcChzdHIsICJpbi1hbHBoYSIpICYmICFzdHJjbXAoc3RyLCAib3V0LWFs
cGhhIikpDQo+IC0JCXJldHVybiBsX2RidXNfbWVzc2FnZV9uZXdfZXJyb3IobXNnLCBkYnVzX2Vy
cl9zdXBwb3J0LCBOVUxMKTsNCj4gLQ0KPiAtCWxfZGJ1c19tZXNzYWdlX3JlZihtc2cpOw0KPiAt
CWFnZW50X2lucHV0X3JlcXVlc3QoQVNDSUksIDgsICJFbnRlciBkaXNwbGF5ZWQgQXNjaWkgY29k
ZSIsDQo+ICsJaWYgKCFzdHJjbXAoc3RyLCAiaW4tYWxwaGEiKSB8fCAhc3RyY21wKHN0ciwgIm91
dC1hbHBoYSIpKSB7DQo+ICsJCWxfZGJ1c19tZXNzYWdlX3JlZihtc2cpOw0KPiArCQlhZ2VudF9p
bnB1dF9yZXF1ZXN0KEFTQ0lJLCA4LCAiRW50ZXIgZGlzcGxheWVkIEFzY2lpIGNvZGUiLA0KPiAg
CQkJCQkJCWFnZW50X2lucHV0X2RvbmUsIG1zZyk7DQo+ICsJfSBlbHNlIGlmICghc3RyY21wKHN0
ciwgInN0YXRpYy1vb2IiKSkgew0KPiArCQlsX2RidXNfbWVzc2FnZV9yZWYobXNnKTsNCj4gKwkJ
YWdlbnRfaW5wdXRfcmVxdWVzdChIRVhBREVDSU1BTCwgMTYsICJFbnRlciBTdGF0aWMgS2V5IiwN
Cj4gKwkJCQkJCQlhZ2VudF9pbnB1dF9kb25lLCBtc2cpOw0KPiArCX0gZWxzZQ0KPiArCQlyZXR1
cm4gbF9kYnVzX21lc3NhZ2VfbmV3X2Vycm9yKG1zZywgZGJ1c19lcnJfc3VwcG9ydCwgTlVMTCk7
DQo+ICANCj4gIAlyZXR1cm4gTlVMTDsNCj4gIH0NCj4gZGlmZiAtLWdpdCBhL3Rvb2xzL21lc2gv
YWdlbnQuYyBiL3Rvb2xzL21lc2gvYWdlbnQuYw0KPiBpbmRleCAxZjgzMzQ3YmYuLjAyNThhMzgw
MyAxMDA2NDQNCj4gLS0tIGEvdG9vbHMvbWVzaC9hZ2VudC5jDQo+ICsrKyBiL3Rvb2xzL21lc2gv
YWdlbnQuYw0KPiBAQCAtODEsMTUgKzgxLDE2IEBAIHN0YXRpYyBib29sIHN0cjJoZXgoY29uc3Qg
Y2hhciAqc3RyLCB1aW50MTZfdCBpbl9sZW4sIHVpbnQ4X3QgKm91dCwNCj4gIHN0YXRpYyB2b2lk
IHJlc3BvbnNlX2hleGFkZWNpbWFsKGNvbnN0IGNoYXIgKmlucHV0LCB2b2lkICp1c2VyX2RhdGEp
DQo+ICB7DQo+ICAJdWludDhfdCBidWZbTUFYX0hFWEFERUNJTUFMX09PQl9MRU5dOw0KPiArCXVp
bnQxNl90IGxlbiA9IHBlbmRpbmdfcmVxdWVzdC5sZW47DQo+ICANCj4gIAlpZiAoIXN0cjJoZXgo
aW5wdXQsIHN0cmxlbihpbnB1dCksIGJ1ZiwgcGVuZGluZ19yZXF1ZXN0LmxlbikgKSB7DQo+ICAJ
CWJ0X3NoZWxsX3ByaW50ZigiSW5jb3JyZWN0IGlucHV0OiBleHBlY3RpbmcgJWQgaGV4IG9jdGV0
c1xuIiwNCj4gIAkJCSAgcGVuZGluZ19yZXF1ZXN0Lmxlbik7DQo+IC0JCXJldHVybjsNCj4gKwkJ
bGVuID0gMDsNCj4gIAl9DQo+ICANCj4gIAlpZiAocGVuZGluZ19yZXF1ZXN0LmNiKQ0KPiAtCQlw
ZW5kaW5nX3JlcXVlc3QuY2IoSEVYQURFQ0lNQUwsIGJ1ZiwgcGVuZGluZ19yZXF1ZXN0LmxlbiwN
Cj4gKwkJcGVuZGluZ19yZXF1ZXN0LmNiKEhFWEFERUNJTUFMLCBidWYsIGxlbiwNCj4gIAkJCQkJ
cGVuZGluZ19yZXF1ZXN0LnVzZXJfZGF0YSk7DQo+ICANCj4gIAlyZXNldF9pbnB1dF9yZXF1ZXN0
KCk7DQo+IEBAIC05OCwxNCArOTksMTUgQEAgc3RhdGljIHZvaWQgcmVzcG9uc2VfaGV4YWRlY2lt
YWwoY29uc3QgY2hhciAqaW5wdXQsIHZvaWQgKnVzZXJfZGF0YSkNCj4gIHN0YXRpYyB2b2lkIHJl
c3BvbnNlX2RlY2ltYWwoY29uc3QgY2hhciAqaW5wdXQsIHZvaWQgKnVzZXJfZGF0YSkNCj4gIHsN
Cj4gIAl1aW50OF90IGJ1ZltERUNJTUFMX09PQl9MRU5dOw0KPiArCXVpbnQxNl90IGxlbiA9IERF
Q0lNQUxfT09CX0xFTjsNCj4gIA0KPiAgCWlmIChzdHJsZW4oaW5wdXQpID4gcGVuZGluZ19yZXF1
ZXN0LmxlbikNCj4gLQkJcmV0dXJuOw0KPiArCQlsZW4gPSAwOw0KPiAgDQo+ICAJYnRfcHV0X2Jl
MzIoYXRvaShpbnB1dCksIGJ1Zik7DQo+ICANCj4gIAlpZiAocGVuZGluZ19yZXF1ZXN0LmNiKQ0K
PiAtCQlwZW5kaW5nX3JlcXVlc3QuY2IoREVDSU1BTCwgYnVmLCBERUNJTUFMX09PQl9MRU4sDQo+
ICsJCXBlbmRpbmdfcmVxdWVzdC5jYihERUNJTUFMLCBidWYsIGxlbiwNCj4gIAkJCQkJcGVuZGlu
Z19yZXF1ZXN0LnVzZXJfZGF0YSk7DQo+ICANCj4gIAlyZXNldF9pbnB1dF9yZXF1ZXN0KCk7DQo=
