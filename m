Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19274C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 16:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB52208CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 16:45:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbfH1QpX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:45:23 -0400
Received: from mga03.intel.com ([134.134.136.65]:21628 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726515AbfH1QpX (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 12:45:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 09:45:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="183186278"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga003.jf.intel.com with ESMTP; 28 Aug 2019 09:45:22 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.66]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 09:45:22 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Show error message when io initialization
 fails
Thread-Topic: [PATCH BlueZ] mesh: Show error message when io initialization
 fails
Thread-Index: AQHVVy0oBbM+cRxQqUathrhnTMvU1acRRvMA
Date:   Wed, 28 Aug 2019 16:45:21 +0000
Message-ID: <a1213a76863e29b590d6fa14a1011fe43bf7aee4.camel@intel.com>
References: <20190820075852.2932-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190820075852.2932-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.35.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CCA83014AE2FD49AAF2EFC1C7898890@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUdWUsIDIwMTktMDgtMjAgYXQgMDk6NTggKzAyMDAsIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIHdyb3RlOg0KPiAtLS0NCj4gIG1lc2gvbWVzaC1pby1nZW5lcmljLmMgfCA1
ICsrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
DQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLWlvLWdlbmVyaWMuYyBiL21lc2gvbWVzaC1p
by1nZW5lcmljLmMNCj4gaW5kZXggY2M5MWY0OTRlLi40MmJmNjRhMGIgMTAwNjQ0DQo+IC0tLSBh
L21lc2gvbWVzaC1pby1nZW5lcmljLmMNCj4gKysrIGIvbWVzaC9tZXNoLWlvLWdlbmVyaWMuYw0K
PiBAQCAtMjEsNiArMjEsOCBAQA0KPiAgI2luY2x1ZGUgPGNvbmZpZy5oPg0KPiAgI2VuZGlmDQo+
ICANCj4gKyNpbmNsdWRlIDxlcnJuby5oPg0KPiArI2luY2x1ZGUgPHN0cmluZy5oPg0KPiAgI2lu
Y2x1ZGUgPHN5cy90aW1lLmg+DQo+ICAjaW5jbHVkZSA8ZWxsL2VsbC5oPg0KPiAgDQo+IEBAIC0y
ODUsNyArMjg3LDggQEAgc3RhdGljIGJvb2wgaGNpX2luaXQoc3RydWN0IG1lc2hfaW8gKmlvKQ0K
PiAgew0KPiAgCWlvLT5wdnQtPmhjaSA9IGJ0X2hjaV9uZXdfdXNlcl9jaGFubmVsKGlvLT5wdnQt
PmluZGV4KTsNCj4gIAlpZiAoIWlvLT5wdnQtPmhjaSkgew0KPiAtCQlsX2Vycm9yKCJGYWlsZWQg
dG8gc3RhcnQgbWVzaCBpbyAoaGNpICV1KSIsIGlvLT5wdnQtPmluZGV4KTsNCj4gKwkJbF9lcnJv
cigiRmFpbGVkIHRvIHN0YXJ0IG1lc2ggaW8gKGhjaSAldSk6ICVzIiwgaW8tPnB2dC0+aW5kZXgs
DQo+ICsJCQkJCQkJc3RyZXJyb3IoZXJybm8pKTsNCj4gIAkJcmV0dXJuIGZhbHNlOw0KPiAgCX0N
Cj4gIA0K
