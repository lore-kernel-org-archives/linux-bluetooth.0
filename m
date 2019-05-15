Return-Path: <SRS0=OL4k=TP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D528C04E53
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 16:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12CAF20873
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 May 2019 16:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727350AbfEOQpn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 May 2019 12:45:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:17752 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727108AbfEOQpn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 May 2019 12:45:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 15 May 2019 09:45:43 -0700
X-ExtLoop1: 1
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by orsmga005.jf.intel.com with ESMTP; 15 May 2019 09:45:43 -0700
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 15 May 2019 09:45:42 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.155]) with mapi id 14.03.0415.000;
 Wed, 15 May 2019 09:45:42 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ 0/2] Start implementing mesh Management interface
Thread-Topic: [PATCH BlueZ 0/2] Start implementing mesh Management interface
Thread-Index: AQHVCqfxP4+3VBTBzU6VJX6qa/jBMaZs20yA
Date:   Wed, 15 May 2019 16:45:42 +0000
Message-ID: <1557938741.32584.3.camel@intel.com>
References: <20190514225407.29594-1-inga.stotland@intel.com>
In-Reply-To: <20190514225407.29594-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.7.218]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D72DA32FAC5DB4D82C2A293FE40387D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2gtc2V0IGFwcGxpZWQNCg0KT24gVHVlLCAyMDE5LTA1LTE0IGF0IDE1OjU0IC0wNzAwLCBJ
bmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNldCBhZHMgYSBza2V0bGV0b24gZm9y
IG9yZy5ibHVlei5tZXNoLk1hbmFnZW1lbnQxIGludGVyZmFjZS4NCj4gQWxzbywgYWRkcyBjaGVj
ayBmb3IgdGhlIGV4aXN0ZW5jZSBvZiB0aGUgcHJvdmlzaW9uaW5nIGFnZW50IGZvciBhbg0KPiBh
dHRhY2hpbmcgbm9kZTogdGhpcyBpbmZvcm1hdGlvbiB3aWxsIGJlIGZ1cnRoZXIgdXNlZCB0byB2
YWxpZGF0ZQ0KPiBudW1iZXIgb2YgbWV0aG9kIGNhbGxzIG9uIE1hbmFnZW1lbnQgaW50ZXJmYWNl
DQo+IA0KPiBJbmdhIFN0b3RsYW5kICgyKToNCj4gICBtZXNoOiBBZGQgY2hlY2sgZm9yIG9yZy5i
bHVlei5tZXNoLlByb3Zpc2lvbmVyMSBpbnRlcmZhY2UNCj4gICBtZXNoOiBBZGQgc2tlbGV0b24g
Zm9yIG9yZy5ibHVlei5tZXNoLk1hbmFnZW1lbnQxIGludGVyZmFjZQ0KPiANCj4gIE1ha2VmaWxl
Lm1lc2ggIHwgICAxICsNCj4gIG1lc2gvZGJ1cy5jICAgIHwgIDEyICsrLQ0KPiAgbWVzaC9lcnJv
ci5oICAgfCAgIDEgKw0KPiAgbWVzaC9tYW5hZ2VyLmMgfCAyNjYgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgbWVzaC9tYW5hZ2VyLmggfCAgMjAg
KysrKw0KPiAgbWVzaC9tZXNoLmggICAgfCAgIDQgKy0NCj4gIG1lc2gvbm9kZS5jICAgIHwgICA1
ICstDQo+ICA3IGZpbGVzIGNoYW5nZWQsIDMwMyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygt
KQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IG1lc2gvbWFuYWdlci5jDQo+ICBjcmVhdGUgbW9kZSAx
MDA2NDQgbWVzaC9tYW5hZ2VyLmgNCj4g
