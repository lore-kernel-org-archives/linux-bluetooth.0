Return-Path: <SRS0=ax5w=RO=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF6BC43381
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB7F2087F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 11 Mar 2019 22:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbfCKWTs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:19:48 -0400
Received: from mga04.intel.com ([192.55.52.120]:40490 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727976AbfCKWTs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 11 Mar 2019 18:19:48 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 15:19:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="150738768"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga002.fm.intel.com with ESMTP; 11 Mar 2019 15:19:49 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.179]) with mapi id 14.03.0415.000;
 Mon, 11 Mar 2019 15:19:47 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/1] mesh: Set node ID for a newly provisioned node
Thread-Topic: [PATCH BlueZ 1/1] mesh: Set node ID for a newly provisioned
 node
Thread-Index: AQHU1gIy1QSEUcpTkUCWmeSdU8AiB6YHemMA
Date:   Mon, 11 Mar 2019 22:19:46 +0000
Message-ID: <1552342784.29289.1.camel@intel.com>
References: <20190308225634.20351-1-inga.stotland@intel.com>
In-Reply-To: <20190308225634.20351-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.149.88]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BA472853017514C90BBEE4A7448E066@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBGcmksIDIwMTktMDMtMDggYXQgMTQ6NTYgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFdoZW4gYSBuZXcgbm9kZSBpcyBjcmVhdGVkIGFmdGVyIHN1Y2Nlc3NmdWwg
cHJvdmlzaW9uaW5nLCBhIDQtZGlnaXQNCj4gaGV4IG5vZGUgaWQgbmVlZHMgdG8gYmUgZ2VuZXJh
dGVkIGFuZCBwcmVzZXJ2ZWQuDQo+IC0tLQ0KPiAgbWVzaC9zdG9yYWdlLmMgfCAyICsrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9z
dG9yYWdlLmMgYi9tZXNoL3N0b3JhZ2UuYw0KPiBpbmRleCBmZTMxMDJmYmEuLmU4NGMyYzkzMyAx
MDA2NDQNCj4gLS0tIGEvbWVzaC9zdG9yYWdlLmMNCj4gKysrIGIvbWVzaC9zdG9yYWdlLmMNCj4g
QEAgLTU0Niw2ICs1NDYsOCBAQCBib29sIHN0b3JhZ2VfY3JlYXRlX25vZGVfY29uZmlnKHN0cnVj
dCBtZXNoX25vZGUgKm5vZGUsIHZvaWQgKmRhdGEpDQo+ICAJaWYgKG51bV90cmllcyA9PSAxMCkN
Cj4gIAkJbF9lcnJvcigiRmFpbGVkIHRvIGdlbmVyYXRlIHVuaXF1ZSBub2RlIElEIik7DQo+ICAN
Cj4gKwlub2RlX2lkX3NldChub2RlLCBub2RlX2lkKTsNCj4gKw0KPiAgCXNucHJpbnRmKG5hbWVf
YnVmLCBQQVRIX01BWCwgIiVzLyUwNHgiLCBzdG9yYWdlX2Rpciwgbm9kZV9pZCk7DQo+ICANCj4g
IAkvKiBDcmVhdGUgYSBuZXcgZGlyZWN0b3J5IGFuZCBub2RlLmpzb24gZmlsZSAqLw==
