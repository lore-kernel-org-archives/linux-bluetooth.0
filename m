Return-Path: <SRS0=WywE=VB=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A497DC5B578
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 00:16:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81161218A0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 Jul 2019 00:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfGDAQG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Jul 2019 20:16:06 -0400
Received: from mga03.intel.com ([134.134.136.65]:2044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfGDAQG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Jul 2019 20:16:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 17:16:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,449,1557212400"; 
   d="scan'208";a="169297544"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga006.jf.intel.com with ESMTP; 03 Jul 2019 17:16:06 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 3 Jul 2019 17:16:05 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.135]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.150]) with mapi id 14.03.0439.000;
 Wed, 3 Jul 2019 17:16:05 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal@rzechonek.net" <michal@rzechonek.net>
Subject: Re: [PATCH BlueZ] mesh: Fix stack overflow in get_element_properties
Thread-Topic: [PATCH BlueZ] mesh: Fix stack overflow in
 get_element_properties
Thread-Index: AQHVMdLKjCcxAq28e0e7aXpWlH84Nqa6DQYA
Date:   Thu, 4 Jul 2019 00:16:05 +0000
Message-ID: <1562199362.23933.38.camel@intel.com>
References: <20190703190833.22039-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190703190833.22039-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.20.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0C085DC3A667E419DAAA28844AE1FCA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDctMDMgYXQgMjE6MDggKzAyMDAsIE1pY2hhxYIgTG93
YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBGcm9tOiBNaWNoYcWCICdLaG9ybmUnIExvd2FzLVJ6ZWNo
b25layA8bWljaGFsQHJ6ZWNob25lay5uZXQ+DQo+IA0KPiBELUJ1cyB0eXBlICdxJyBkZW5vdGVz
IHVpbnQxNiwgbm90IHVpbnQ4Lg0KPiAtLS0NCj4gIG1lc2gvbm9kZS5jIHwgMiArLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvbWVzaC9ub2RlLmMgYi9tZXNoL25vZGUuYw0KPiBpbmRleCBjNzNiYTU0MWYuLmY5YmU5
NmNiZCAxMDA2NDQNCj4gLS0tIGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4g
QEAgLTEyMDAsNyArMTIwMCw3IEBAIHN0YXRpYyBib29sIGdldF9lbGVtZW50X3Byb3BlcnRpZXMo
c3RydWN0IG1lc2hfbm9kZSAqbm9kZSwgY29uc3QgY2hhciAqcGF0aCwNCj4gIA0KPiAgCXdoaWxl
IChsX2RidXNfbWVzc2FnZV9pdGVyX25leHRfZW50cnkocHJvcGVydGllcywgJmtleSwgJnZhcikp
IHsNCj4gIAkJaWYgKCFzdHJjbXAoa2V5LCAiTG9jYXRpb24iKSkgew0KPiAtCQkJdWludDhfdCBs
b2M7DQo+ICsJCQl1aW50MTZfdCBsb2M7DQo+ICANCj4gIAkJCWxfZGJ1c19tZXNzYWdlX2l0ZXJf
Z2V0X3ZhcmlhbnQoJnZhciwgInEiLCAmbG9jKTsNCj4gIA==
