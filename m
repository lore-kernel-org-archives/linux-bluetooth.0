Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E08C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 19:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BCDC216C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 19:13:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfEHTNz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 15:13:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:11007 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfEHTNy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 15:13:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 12:13:54 -0700
X-ExtLoop1: 1
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga002.jf.intel.com with ESMTP; 08 May 2019 12:13:54 -0700
Received: from orsmsx156.amr.corp.intel.com (10.22.240.22) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 8 May 2019 12:13:54 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX156.amr.corp.intel.com ([169.254.8.17]) with mapi id 14.03.0415.000;
 Wed, 8 May 2019 12:13:53 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v3 0/1] mesh: Use node uuids as storage directory
 names
Thread-Topic: [PATCH BlueZ v3 0/1] mesh: Use node uuids as storage directory
 names
Thread-Index: AQHVBanWCWa7WPRSx0agJY/l17xmF6ZiDlyA
Date:   Wed, 8 May 2019 19:13:53 +0000
Message-ID: <1557342831.14401.0.camel@intel.com>
References: <20190508142445.4508-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20190508142445.4508-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.10.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4B35BEE793EEA54FA2271256856B7066@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDUtMDggYXQgMTY6MjQgKzAyMDAsIE1pY2hh
xYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBUaGlzIHZlcnNpb24gb2YgdGhlIHBhdGNoIGRy
b3BzIGRpcmVjdCBhc3ByaW50ZigpIGNhbGxzIGluIGZhdm9yIG9mDQo+IGxfc3RyZHVwX3ByaW50
Zi4NCj4gDQo+IE1pY2hhxYIgTG93YXMtUnplY2hvbmVrICgxKToNCj4gICBtZXNoOiBVc2Ugbm9k
ZSB1dWlkcyBhcyBzdG9yYWdlIGRpcmVjdG9yeSBuYW1lcw0KPiANCj4gIGRvYy9tZXNoLWFwaS50
eHQgfCAyNiArKysrKysrKysrLS0tDQo+ICBtZXNoL1JFQURNRSAgICAgIHwgIDcgKystLQ0KPiAg
bWVzaC9tZXNoLWRiLmMgICB8ICA0IC0tDQo+ICBtZXNoL21lc2gtZGIuaCAgIHwgIDEgLQ0KPiAg
bWVzaC9tZXNoLmMgICAgICB8ICA3ICsrKysNCj4gIG1lc2gvbm9kZS5jICAgICAgfCAzOCArKysr
KystLS0tLS0tLS0tLS0tDQo+ICBtZXNoL25vZGUuaCAgICAgIHwgIDIgKy0NCj4gIG1lc2gvc3Rv
cmFnZS5jICAgfCA5NiArKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gIDggZmlsZXMgY2hhbmdlZCwgNzIgaW5zZXJ0aW9ucygrKSwgMTA5IGRlbGV0aW9u
cygtKQ0KPiA=
