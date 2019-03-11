Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B3EC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDEF214AE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbfCKWUQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:20:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:58058 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbfCKWUP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 18:20:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 15:20:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="281758112"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2019 15:20:14 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.192]) with mapi id 14.03.0415.000;
 Mon, 11 Mar 2019 15:20:13 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 0/3] Save and restore mesh models pub/sub settings
Thread-Topic: [PATCH BlueZ 0/3] Save and restore mesh models pub/sub settings
Thread-Index: AQHU1gJ0EFRDgmonCEuzuf/8MdTxa6YHeoCA
Date:   Mon, 11 Mar 2019 22:20:13 +0000
Message-ID: <1552342809.29289.2.camel@intel.com>
References: <20190308225820.20561-1-inga.stotland@intel.com>
In-Reply-To: <20190308225820.20561-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.149.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DEC5C4DC114E3B41BF03DF4B135D7CAC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2ggc2V0IGFwcGxpZWQNCg0KT24gRnJpLCAyMDE5LTAzLTA4IGF0IDE0OjU4IC0wODAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBpbXBsZW1lbnRzIHRoZSBmb2xs
b3dpbmc6DQo+IC0gV3JpdGUgdXBkYXRlcyBvZiBub2RlIG1vZGVsIHN1YnNjcmlwdGlvbnMgdG8g
bm9kZSBjb25maWcgZmlsZQ0KPiAtIFdyaXRlIHVwZGF0ZXMgb2Ygbm9kZSBtb2RlbCBwdWJsaWNh
dGlvbiBzZXR0aW5ncyB0byBub2RlIGNvbmZpZyBmaWxlDQo+IC0gQ29ycmVjdGx5IHJlc3RvcmUg
c3Vic2NyaXB0aW9ucyBhbmQgcHVibGljYXRpb25zIG9uIGRhZW1vbiBzdGFydHVwDQo+IA0KPiBJ
bmdhIFN0b3RsYW5kICgzKToNCj4gICBtZXNoOiBBZGQganNvbiBjb25maWcgZnVuY3Rpb25zIHRv
IHNhdmUgcHViL3N1YiB1cGRhdGVzDQo+ICAgbWVzaDogU2F2ZSBtb2RlbCBzdWJzY3JpcHRpb24g
dXBkYXRlcyB0byBjb25maWcgZmlsZQ0KPiAgIG1lc2g6IFN0b3JlIG1vZGVsIHB1YmxpY2F0aW9u
IHNldHRpbmdzIGluIGNvbmZpZyBmaWxlDQo+IA0KPiAgbWVzaC9jZmdtb2Qtc2VydmVyLmMgfCAx
MDQgKysrKysrKysrKysrKysrLQ0KPiAgbWVzaC9tZXNoLWRiLmMgICAgICAgfCAyODIgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiAgbWVzaC9tZXNoLWRiLmgg
ICAgICAgfCAgMTUgKystDQo+ICBtZXNoL21vZGVsLmMgICAgICAgICB8ICAyMiArKy0tDQo+ICA0
IGZpbGVzIGNoYW5nZWQsIDQwNCBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4g
