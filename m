Return-Path: <SRS0=ssTf=VI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171A2C74A35
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 15:48:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC552216B7
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Jul 2019 15:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729113AbfGKPsH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Jul 2019 11:48:07 -0400
Received: from mga09.intel.com ([134.134.136.24]:41661 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729094AbfGKPsC (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Jul 2019 11:48:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jul 2019 08:48:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,479,1557212400"; 
   d="scan'208";a="193441553"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by fmsmga002.fm.intel.com with ESMTP; 11 Jul 2019 08:48:01 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 11 Jul 2019 08:48:01 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.44]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.199]) with mapi id 14.03.0439.000;
 Thu, 11 Jul 2019 08:48:01 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: RE: [PATCH BlueZ 6/8] mesh: Fix implementation of Provisioner
 Initiator
Thread-Topic: [PATCH BlueZ 6/8] mesh: Fix implementation of Provisioner
 Initiator
Thread-Index: AQHVN3RrvDxatkr6tkGrpminVP05TKbFfFCAgAASFIA=
Date:   Thu, 11 Jul 2019 15:48:00 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4376CBCCF12@ORSMSX103.amr.corp.intel.com>
References: <20190710230757.8425-1-brian.gix@intel.com>
 <20190710230757.8425-7-brian.gix@intel.com>
 <20190711073329.osw52lx72muov6sg@mlowasrzechonek2133>
In-Reply-To: <20190711073329.osw52lx72muov6sg@mlowasrzechonek2133>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNjVlZjJkY2MtZTg0ZS00MzAyLTg4MTktZWY1Y2U5MjgzYzVjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOStHdERGSCtSc1dTZjYrN1Mxd2RPK0lETHdmbmVTSStNOHdEUkROMlJcL0JKTmJYM3diRXNhUW9yeXpXVVBCdWMifQ==
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGHFgiwNCg0KSSB3aWxsIGZpeCB0aGUgc3R5bGUgZ3VpZGUgYW5kIHNwZWMgYWxpZ25t
ZW50IGlzc3VlcyB5b3UgcG9pbnRlZCBhdCBlbHNld2hlcmUuLi4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiA+ICsJaWYgKGtleS5waGFzZSA9PSBLRVlfUkVGUkVTSF9QSEFTRV9U
V08pIHsNCj4gPiArCQltZW1jcHkob3V0ICsgMSwga2V5Lm5ld19rZXksIDE2KTsNCj4gPiArCQlz
bmJfZmxhZ3MgfD0gUFJPVl9GTEFHX0tSOw0KPiA+ICsJfSBlbHNlDQo+ID4gKwkJbWVtY3B5KG91
dCArIDEsIGtleS5vbGRfa2V5LCAxNik7DQo+ID4gKw0KPiA+ICsJbF9wdXRfYmUxNihuZXRfaWR4
LCBvdXQgKyAxICsgMTYpOw0KPiA+ICsJbF9wdXRfdTgoc25iX2ZsYWdzLCBvdXQgKyAxICsgMTYg
KyAyKTsNCj4gPiArCWxfcHV0X2JlMzIoaXZfaW5kZXgsIG91dCArIDEgKyAxNiArIDIgKyAxKTsN
Cj4gPiArCWxfcHV0X2JlMTYocHJpbWFyeSwgb3V0ICsgMSArIDE2ICsgMiArIDEgKyA0KTsNCj4g
DQo+IE5vdCByZWFsbHkgcmVsYXRlZCB0byB0aGlzIHBhdGNoc2V0LCBidXQgYSBnZW5lcmFsIGNv
bW1lbnQgYWJvdXQgcGFja2V0DQo+IGJ1aWxkaW5nIGFuZCBwYXJzaW5nOiBjb3VsZCB3ZSBwbGVh
c2UgbW92ZSBhd2F5IGZyb20gY2FsY3VsYXRpbmcgYnl0ZSBvZmZzZXRzDQo+IGFuZCB1c2UgcGFj
a2VkIHN0cnVjdHMgaW5zdGVhZD8gRG8geW91IGhhdmUgYW55IG9waW5pb24gb24gdGhhdD8NCg0K
DQpZb3UgYXJlIHByb2JhYmx5IHJpZ2h0IGFib3V0IHRoaXMuICBUZWNobmljYWxseSwgdGhpcyBp
cyBhICJOZXR3b3JrIFBhY2tldCIgKGV2ZW4gdGhvdWdoIA0Kd2UgbG9jYWxseSBlbmNyeXB0IGl0
IGJlZm9yZSBzZW5kaW5nKSBhbmQgc28gd2Ugc2hvdWxkIHRyZWF0IGl0IGxpa2UgYW55IHBhY2tl
dCB3ZQ0Kc2VuZCBvdmVyIGEgc29ja2V0IChmb3IgaW5zdGFuY2UsIHRoZSBIQ0kgc29ja2V0cyB3
ZSB1c2UgdG8gdGFsayB0byBjb250cm9sbGVycykuICBUaGlzIGlzDQphIHZlc3RpZ2Ugb2YgbXkg
Im9sZCBtYW4gZW5naW5lZXJpbmciIHdoZXJlIEkgY291bGRuJ3QgYWx3YXlzIHRydXN0IGNvbXBp
bGVycyBhY3Jvc3MNCmFsbCBwbGF0Zm9ybXMgdG8gZmFpdGhmdWxseSBwYWNrIG9jdGV0cyB0aGUg
c2FtZSwgYnV0IG9idmlvdXNseSBpZiB3ZSBhcmUgdHJ1c3RpbmcgdGhlDQpwYWNraW5nIGZvciBI
Q0ksIHdlIHNob3VsZCBiZSB0cnVzdGluZyB0aGUgcGFja2luZyBmb3IgdGhpcy4gSSB3aWxsIHNj
cnViIHRoZSBjb2RlIGZvciANCm9wcG9ydHVuaXRpZXMgZm9yIHBhY2tpbmcgdGhpcyAoYW5kIG90
aGVyIHNpbWlsYXIpIHN0cnVjdHVyZXMuDQoNCg==
