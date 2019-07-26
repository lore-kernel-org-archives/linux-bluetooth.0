Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3D3C7618B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB6F218EA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfGZQUG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:06 -0400
Received: from mga01.intel.com ([192.55.52.88]:13615 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbfGZQUG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:20:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="161348682"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 26 Jul 2019 09:20:05 -0700
Received: from orsmsx152.amr.corp.intel.com (10.22.226.39) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 09:20:05 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX152.amr.corp.intel.com ([169.254.8.114]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 09:20:05 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] test/test-mesh: Initialize required properties
Thread-Topic: [PATCH BlueZ] test/test-mesh: Initialize required properties
Thread-Index: AQHVQxc4NKCaBULA306nNddUyHdYoKbdix+A
Date:   Fri, 26 Jul 2019 16:20:04 +0000
Message-ID: <1564158003.16999.2.camel@intel.com>
References: <20190725183145.23604-1-inga.stotland@intel.com>
In-Reply-To: <20190725183145.23604-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.105.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FC8EB2C774ED8B4197D55E3EE32B3023@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDctMjUgYXQgMTE6MzEgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgaW5pdGlhbGl6ZWQgcmVxdWlyZWQgIk1vZGVscyIgYW5kICJWZW5k
b3JNb2RlbHMiIHByb3BlcnRpZXMNCj4gd2hlaGVyIHRoZSBhY3R1YWwgbW9kZWxzIGV4aXN0IG9y
IG5vdCwgYWNjb3JkaW5nIHRvIHRoZSBtZXNoLWFwaS50eHQuDQo+IEluIGNhc2Ugd2hlbiBhbiBl
bGVtZW50IGRvZXMgbm90IGNvbnRhaW4gZWl0aGVyIFNJRyBkZWZpbmVkIG1vZGVscyBvcg0KPiB2
ZW5kb3IgZGVmaW5lZWQgbW9kZWxzLCB0aGUgY29ycmVzcG9uZGluZyBwcm9wZXJ0aWVzIHNob3Vs
ZCBjb250YWluDQo+IGVtcHR5IGFycmF5cy4NCj4gLS0tDQo+ICB0ZXN0L3Rlc3QtbWVzaCB8IDYg
KystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL3Rlc3QvdGVzdC1tZXNoIGIvdGVzdC90ZXN0LW1lc2gNCj4g
aW5kZXggNmU5MTk2MzY2Li4zYzVkZWQ3YjMgMTAwNzU1DQo+IC0tLSBhL3Rlc3QvdGVzdC1tZXNo
DQo+ICsrKyBiL3Rlc3QvdGVzdC1tZXNoDQo+IEBAIC01MzcsMTAgKzUzNyw4IEBAIGNsYXNzIEVs
ZW1lbnQoZGJ1cy5zZXJ2aWNlLk9iamVjdCk6DQo+ICAJCXNpZ19tb2RlbHMgPSBzZWxmLl9nZXRf
c2lnX21vZGVscygpDQo+ICANCj4gIAkJcHJvcHMgPSB7J0luZGV4JyA6IGRidXMuQnl0ZShzZWxm
LmluZGV4KX0NCj4gLQkJaWYgbGVuKHNpZ19tb2RlbHMpICE9IDA6DQo+IC0JCQlwcm9wc1snTW9k
ZWxzJ10gPSBkYnVzLkFycmF5KHNpZ19tb2RlbHMsIHNpZ25hdHVyZT0ncScpDQo+IC0JCWlmIGxl
bih2ZW5kb3JfbW9kZWxzKSAhPSAwOg0KPiAtCQkJcHJvcHNbJ1ZlbmRvck1vZGVscyddID0gZGJ1
cy5BcnJheSh2ZW5kb3JfbW9kZWxzLA0KPiArCQlwcm9wc1snTW9kZWxzJ10gPSBkYnVzLkFycmF5
KHNpZ19tb2RlbHMsIHNpZ25hdHVyZT0ncScpDQo+ICsJCXByb3BzWydWZW5kb3JNb2RlbHMnXSA9
IGRidXMuQXJyYXkodmVuZG9yX21vZGVscywNCj4gIAkJCQkJCQlzaWduYXR1cmU9JyhxcSknKQ0K
PiAgCQkjcHJpbnQocHJvcHMpDQo+ICAJCXJldHVybiB7IE1FU0hfRUxFTUVOVF9JRkFDRTogcHJv
cHMgfQ==
