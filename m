Return-Path: <SRS0=AkUh=SV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A7F8C282DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0E0E222AF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Apr 2019 18:28:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfDSS2u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:28:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:20116 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfDSS2t (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Apr 2019 14:28:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2019 09:09:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,370,1549958400"; 
   d="scan'208";a="224972727"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2019 09:09:57 -0700
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Fri, 19 Apr 2019 09:09:56 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.120]) with mapi id 14.03.0415.000;
 Fri, 19 Apr 2019 09:09:57 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ] mesh: Fix network information cleanup
Thread-Topic: [PATCH BlueZ] mesh: Fix network information cleanup
Thread-Index: AQHU9Z0HdrFAnIU5+0el8JtAZ0YUi6ZEHsUA
Date:   Fri, 19 Apr 2019 16:09:56 +0000
Message-ID: <1555690194.3265.0.camel@intel.com>
References: <20190418041306.18815-1-inga.stotland@intel.com>
In-Reply-To: <20190418041306.18815-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.112.76]
Content-Type: text/plain; charset="utf-8"
Content-ID: <34A1E8B5EA95E94CA9A2AC10BBDFB619@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggQXBwbGllZA0KDQpPbiBXZWQsIDIwMTktMDQtMTcgYXQgMjE6MTMgLTA3MDAsIEluZ2Eg
U3RvdGxhbmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgaXNzdWVzIGNhdXNlZCBieSBhY2Nlc3Npbmcg
aW52YWxpZGF0ZWQgZW50cmllcyBvZiBuZXRzDQo+IHF1ZXVlIHRoYXQgd2VyZSBsZWZ0IGFyb3Vu
ZCB3aGVuIHJlbW92aW5nIG5ldHdvcmsgaW5mbyBpbg0KPiBtZXNoX25ldF9kZXRhY2goKQ0KPiAt
LS0NCj4gIG1lc2gvbmV0LmMgfCAxICsNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbmV0LmMgYi9tZXNoL25ldC5jDQo+IGluZGV4IGIx
NzNlMWMwOS4uOWIxZmJkODFlIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25ldC5jDQo+ICsrKyBiL21l
c2gvbmV0LmMNCj4gQEAgLTMxMjAsNiArMzEyMCw3IEBAIHN0cnVjdCBtZXNoX2lvICptZXNoX25l
dF9kZXRhY2goc3RydWN0IG1lc2hfbmV0ICpuZXQpDQo+ICAJbWVzaF9pb19kZXJlZ2lzdGVyX3Jl
Y3ZfY2IoaW8sIE1FU0hfSU9fRklMVEVSX05FVCk7DQo+ICANCj4gIAluZXQtPmlvID0gTlVMTDsN
Cj4gKwlsX3F1ZXVlX3JlbW92ZShuZXRzLCBuZXQpOw0KPiAgDQo+ICAJcmV0dXJuIGlvOw0KPiAg
fQ==
