Return-Path: <SRS0=N1M0=WY=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66E1C3A5A1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 16:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8BF208CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Aug 2019 16:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfH1Qpr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Aug 2019 12:45:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:12059 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726513AbfH1Qpr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Aug 2019 12:45:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Aug 2019 09:45:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,441,1559545200"; 
   d="scan'208";a="171602343"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 28 Aug 2019 09:45:46 -0700
Received: from orsmsx123.amr.corp.intel.com (10.22.240.116) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 28 Aug 2019 09:45:46 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.221]) by
 ORSMSX123.amr.corp.intel.com ([169.254.1.98]) with mapi id 14.03.0439.000;
 Wed, 28 Aug 2019 09:45:46 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v2 0/2] mesh: Implement org.bluez.mesh.Node1
 properties
Thread-Topic: [PATCH BlueZ v2 0/2] mesh: Implement org.bluez.mesh.Node1
 properties
Thread-Index: AQHVXXWZZGPWv+yQQEG18MUcMA9J+KcROoCA
Date:   Wed, 28 Aug 2019 16:45:45 +0000
Message-ID: <a0019b324df26f3083e7f545b1ba32eaee2701d5.camel@intel.com>
References: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190828075230.21594-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.35.27]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8606E1C11C282E4E8D703648C9AC15D3@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDgtMjggYXQgMDk6NTIgKzAyMDAsIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBUaGlzIHBhdGNoLXNldCBpbXBsZW1lbnRzIHByZXZpb3Vz
bHkgZGVmaW5lZCBwcm9wZXJ0aWVzIG9uIE5vZGUxDQo+IGludGVyZmFjZSBhbmQgYWRkcyBhbiBh
ZGRpdGlvbmFsIHJlYWQtb25seSBwcm9wZXJ0eSB3aXRoIGxpc3Qgb2YgdW5pY2FzdA0KPiBhZGRy
ZXNzZXMgY2xhaW1lZCBieSB0aGUgbm9kZS4NCj4gDQo+IE1pY2hhxYIgTG93YXMtUnplY2hvbmVr
ICgyKToNCj4gICBtZXNoOiBJbXBsZW1lbnQgcHJvcGVydGllcyBvbiBvcmcuYmx1ZXoubWVzaC5O
b2RlMSBpbnRlcmZhY2UNCj4gICBtZXNoOiBBZGQgb3JnLmJsdWV6Lm1lc2guTm9kZTEuQWRkcmVz
c2VzIHByb3BlcnR5DQo+IA0KPiAgZG9jL21lc2gtYXBpLnR4dCB8ICAgNCArKw0KPiAgbWVzaC9u
ZXQuYyAgICAgICB8ICAgNCArKw0KPiAgbWVzaC9uZXQuaCAgICAgICB8ICAgMSArDQo+ICBtZXNo
L25vZGUuYyAgICAgIHwgMTI5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystDQo+ICA0IGZpbGVzIGNoYW5nZWQsIDEzNyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0K
