Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484F7C282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:10:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 163BF20821
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbfBDUKg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:10:36 -0500
Received: from mga17.intel.com ([192.55.52.151]:56085 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbfBDUKg (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 15:10:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:10:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="317606233"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2019 12:10:36 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.158]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 12:10:35 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Remove unnecessary variable initialization
Thread-Topic: [PATCH BlueZ] mesh: Remove unnecessary variable initialization
Thread-Index: AQHUusN3vVWWCeS79UWFjYV2ss9R3qXQm/QA
Date:   Mon, 4 Feb 2019 20:10:34 +0000
Message-ID: <1549311034.22761.1.camel@intel.com>
References: <20190202064935.13579-1-inga.stotland@intel.com>
In-Reply-To: <20190202064935.13579-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.13.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2655C9A18B05D7489DFAECBE895F2782@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpBcHBsaWVkDQoNCk9uIEZyaSwgMjAxOS0wMi0wMSBhdCAyMjo0OSAtMDgwMCwgSW5nYSBTdG90
bGFuZCB3cm90ZToNCj4gLS0tDQo+ICBtZXNoL21lc2guYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvbWVzaC5jIGIvbWVzaC9tZXNoLmMNCj4gaW5kZXggODgxYjZlZDczLi4yYzQ1YzBhODcgMTAw
NjQ0DQo+IC0tLSBhL21lc2gvbWVzaC5jDQo+ICsrKyBiL21lc2gvbWVzaC5jDQo+IEBAIC02NjUs
NyArNjY1LDcgQEAgc3RhdGljIHN0cnVjdCBsX2RidXNfbWVzc2FnZSAqYXR0YWNoX2NhbGwoc3Ry
dWN0IGxfZGJ1cyAqZGJ1cywNCj4gIAkJCQkJCXN0cnVjdCBsX2RidXNfbWVzc2FnZSAqbXNnLA0K
PiAgCQkJCQkJdm9pZCAqdXNlcl9kYXRhKQ0KPiAgew0KPiAtCXVpbnQ2NF90IHRva2VuID0gMTsN
Cj4gKwl1aW50NjRfdCB0b2tlbjsNCj4gIAljb25zdCBjaGFyICphcHBfcGF0aCwgKnNlbmRlcjsN
Cj4gIAlzdHJ1Y3QgYXR0YWNoX2RhdGEgKnBlbmRpbmc7DQo+ICA=
