Return-Path: <SRS0=qzIG=TC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E6CC43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC120675
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 May 2019 16:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbfEBQB2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 May 2019 12:01:28 -0400
Received: from mga01.intel.com ([192.55.52.88]:9186 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726197AbfEBQB2 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 May 2019 12:01:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 May 2019 09:01:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,422,1549958400"; 
   d="scan'208";a="136266600"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 02 May 2019 09:01:27 -0700
Received: from orsmsx111.amr.corp.intel.com (10.22.240.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 2 May 2019 09:01:26 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX111.amr.corp.intel.com ([169.254.12.39]) with mapi id 14.03.0415.000;
 Thu, 2 May 2019 09:01:26 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 0/4] Cleanup of org.bluez.mesh.Network1 interface
Thread-Topic: [PATCH BlueZ 0/4] Cleanup of org.bluez.mesh.Network1 interface
Thread-Index: AQHU/sQUDVeruPdLAEqyhWpD21Mfy6ZYeGUA
Date:   Thu, 2 May 2019 16:01:26 +0000
Message-ID: <1556812884.28287.0.camel@intel.com>
References: <20190429194509.3378-1-inga.stotland@intel.com>
In-Reply-To: <20190429194509.3378-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.29.125]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A17C9693D9ADA4F8599347CCD713F9D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gTW9uLCAyMDE5LTA0LTI5IGF0IDEyOjQ1IC0wNzAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHNldCBvZiBwYXRjaGVzIHRpZ2h0ZW5zIHRoZSBl
eGlzdGluZyBpbXBsZW1lbnRhdGlvbiBvZiBKb2luKCkgYW5kDQo+IEF0dGFjaCgpIG1ldGhvZHMu
IFNvbWUgcmVkdW5kYWNpZXMgYXJlIHJlbW92ZWQsIGNvbW1vbiBjb2RlIGlzIGNvbWJpbmVkIGFu
ZA0KPiB2YWxpZGF0aW9uIG9mIG5vZGUgY29tcG9zaXRpb24gaXMgYWRkZWQgZm9yIEF0dGFjaCBt
ZXRob2QuDQo+IA0KPiBJbmdhIFN0b3RsYW5kICg0KToNCj4gICBtZXNoOiBSZW1vdmUgTm9kZSBp
bnRlcmZhY2UgaWYgbm9kZSBvd25lciBkaXNjb25uZWN0cw0KPiAgIG1lc2g6IENsZWFuIHVwIHBy
b2Nlc3Npbmcgb2YgQXR0YWNoKCkgbWV0aG9kDQo+ICAgbWVzaDogQ29uc29saWRhdGUgcHJvY2Vz
c2luZyBvZiBtZXNoIGVsZW1lbnQgcHJvcGVydGllcw0KPiAgIG1lc2g6IFVuaWZ5IHByb2Nlc3Np
bmcgb2YgR2V0TWFuYWdlZE9iamVjdHMgcmVzdWx0DQo+IA0KPiAgbWVzaC9tZXNoLWRlZnMuaCB8
ICAgMiArDQo+ICBtZXNoL21lc2guYyAgICAgIHwgIDY5ICsrKy0tLQ0KPiAgbWVzaC9ub2RlLmMg
ICAgICB8IDU1OCArKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiAgbWVzaC9ub2RlLmggICAgICB8ICAgOSArLQ0KPiAgNCBmaWxlcyBjaGFuZ2VkLCAzNDQg
aW5zZXJ0aW9ucygrKSwgMjk0IGRlbGV0aW9ucygtKQ0KPiA=
