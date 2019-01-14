Return-Path: <SRS0=wTsk=PW=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE5BC43387
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E330720656
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Jan 2019 22:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727139AbfANWKH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:10:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:44887 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfANWKG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Jan 2019 17:10:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2019 14:10:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,479,1539673200"; 
   d="scan'208";a="138258799"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga001.fm.intel.com with ESMTP; 14 Jan 2019 14:10:05 -0800
Received: from orsmsx153.amr.corp.intel.com (10.22.226.247) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Mon, 14 Jan 2019 14:10:04 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX153.amr.corp.intel.com ([169.254.12.21]) with mapi id 14.03.0415.000;
 Mon, 14 Jan 2019 14:10:04 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: remove uneeded BDADDR type check
Thread-Topic: [PATCH BlueZ] mesh: remove uneeded BDADDR type check
Thread-Index: AQHUqTtenZKwMh/QX0+rTSeSA+/0ZaWv33AA
Date:   Mon, 14 Jan 2019 22:10:04 +0000
Message-ID: <1547503802.32139.0.camel@intel.com>
References: <20190110232229.22630-1-brian.gix@intel.com>
In-Reply-To: <20190110232229.22630-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.134.233]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F7C385AD8FCEEF4ABCE23C54480876A8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDEtMTAgYXQgMTU6MjIgLTA4MDAsIEJyaWFu
IEdpeCB3cm90ZToNCj4gQlRfSENJX0VWVF9MRV9BRFZfUkVQT1JUIG9ubHkgY29tZXMgZnJvbSBs
ZWdhbCBMRSBldmVudHMNCj4gLS0tDQo+ICBtZXNoL21lc2gtaW8tZ2VuZXJpYy5jIHwgNCAtLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9t
ZXNoL21lc2gtaW8tZ2VuZXJpYy5jIGIvbWVzaC9tZXNoLWlvLWdlbmVyaWMuYw0KPiBpbmRleCA0
OGU0N2U3YTQuLjY3MGM3YWI5NyAxMDA2NDQNCj4gLS0tIGEvbWVzaC9tZXNoLWlvLWdlbmVyaWMu
Yw0KPiArKysgYi9tZXNoL21lc2gtaW8tZ2VuZXJpYy5jDQo+IEBAIC0xMzAsMTAgKzEzMCw2IEBA
IHN0YXRpYyB2b2lkIGV2ZW50X2Fkdl9yZXBvcnQoc3RydWN0IG1lc2hfaW8gKmlvLCBjb25zdCB2
b2lkICpidWYsIHVpbnQ4X3Qgc2l6ZSkNCj4gIAlpZiAoZXZ0LT5ldmVudF90eXBlICE9IDB4MDMp
DQo+ICAJCXJldHVybjsNCj4gIA0KPiAtCWlmIChldnQtPmFkZHJfdHlwZSAhPSBCREFERFJfTEVf
UFVCTElDICYmDQo+IC0JCQlldnQtPmFkZHJfdHlwZSAhPSBCREFERFJfTEVfUkFORE9NKQ0KPiAt
CQlyZXR1cm47DQo+IC0NCj4gIAlpbnN0YW50ID0gZ2V0X2luc3RhbnQoKTsNCj4gIAlhZHYgPSBl
dnQtPmRhdGE7DQo+ICAJYWR2X2xlbiA9IGV2dC0+ZGF0YV9sZW47
