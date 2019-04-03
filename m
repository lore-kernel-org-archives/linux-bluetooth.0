Return-Path: <SRS0=5fC3=SF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B815EC4360F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 17:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88B402084B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Apr 2019 17:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDCRwJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Apr 2019 13:52:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:41991 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfDCRwJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Apr 2019 13:52:09 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Apr 2019 10:47:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,305,1549958400"; 
   d="scan'208";a="161097096"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 03 Apr 2019 10:47:04 -0700
Received: from orsmsx116.amr.corp.intel.com (10.22.240.14) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 3 Apr 2019 10:47:04 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX116.amr.corp.intel.com ([169.254.7.78]) with mapi id 14.03.0415.000;
 Wed, 3 Apr 2019 10:47:04 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>
Subject: Re: [PATCH BlueZ v2 1/1] build: Check if explicit_bzero is missing
Thread-Topic: [PATCH BlueZ v2 1/1] build: Check if explicit_bzero is missing
Thread-Index: AQHU6LsX+WzyvF3gVUuhdahQw9f4HqYrLl8A
Date:   Wed, 3 Apr 2019 17:47:03 +0000
Message-ID: <1554313622.20501.0.camel@intel.com>
References: <20190401184518.1816-1-brian.gix@intel.com>
In-Reply-To: <20190401184518.1816-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.31.196]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2ABBD683B1F9184BB6B83859B4B75092@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gTW9uLCAyMDE5LTA0LTAxIGF0IDExOjQ1IC0wNzAwLCBCcmlhbiBHaXggd3JvdGU6DQo+IFRo
aXMgY2hlY2sgZ2V0cyBhcm91bmQgdGhlIHJlZGVmaW5pdGlvbiBvZiBleHBsaWNpdF9iemVybyBp
biBFTEwNCj4gDQo+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSBlbGwvcmFuZG9tLmM6MzQ6MDoNCj4g
ZWxsL21pc3NpbmcuaDo1OToyMDogZXJyb3I6IHN0YXRpYyBkZWNsYXJhdGlvbiBvZiDigJhleHBs
aWNpdF9iemVyb+KAmSBmb2xsb3dzIG5vbi1zdGF0aWMgZGVjbGFyYXRpb24NCj4gIHN0YXRpYyBp
bmxpbmUgdm9pZCBleHBsaWNpdF9iemVybyh2b2lkICpzLCBzaXplX3QgbikNCj4gICAgICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fg0KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9lbGwv
dXRpbC5oOjI2OjAsDQo+ICAgICAgICAgICAgICAgICAgZnJvbSBlbGwvcHJpdmF0ZS5oOjI2LA0K
PiAgICAgICAgICAgICAgICAgIGZyb20gZWxsL3JhbmRvbS5jOjMzOg0KPiAvdXNyL2luY2x1ZGUv
c3RyaW5nLmg6NDM1OjEzOiBub3RlOiBwcmV2aW91cyBkZWNsYXJhdGlvbiBvZiDigJhleHBsaWNp
dF9iemVyb+KAmSB3YXMgaGVyZQ0KPiAgZXh0ZXJuIHZvaWQgZXhwbGljaXRfYnplcm8gKHZvaWQg
Kl9fcywgc2l6ZV90IF9fbikgX19USFJPVyBfX25vbm51bGwgKCgxKSk7DQo+ICAgICAgICAgICAg
ICBefn5+fn5+fn5+fn5+fg0KPiAtLS0NCj4gIGNvbmZpZ3VyZS5hYyB8IDIgKysNCj4gIDEgZmls
ZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUu
YWMgYi9jb25maWd1cmUuYWMNCj4gaW5kZXggYWU2NGRkYzBmLi4wYWZlMWU2ZGIgMTAwNjQ0DQo+
IC0tLSBhL2NvbmZpZ3VyZS5hYw0KPiArKysgYi9jb25maWd1cmUuYWMNCj4gQEAgLTQ2LDYgKzQ2
LDggQEAgTUlTQ19GTEFHUw0KPiAgQUNfQVJHX0VOQUJMRSh0aHJlYWRzLCBBQ19IRUxQX1NUUklO
RyhbLS1lbmFibGUtdGhyZWFkc10sDQo+ICAJCVtlbmFibGUgdGhyZWFkaW5nIHN1cHBvcnRdKSwg
W2VuYWJsZV90aHJlYWRzPSR7ZW5hYmxldmFsfV0pDQo+ICANCj4gK0FDX0NIRUNLX0ZVTkNTKGV4
cGxpY2l0X2J6ZXJvKQ0KPiArDQo+ICBBQ19DSEVDS19GVU5DKHNpZ25hbGZkLCBkdW1teT15ZXMs
DQo+ICAJCQlBQ19NU0dfRVJST1Ioc2lnbmFsZmQgc3VwcG9ydCBpcyByZXF1aXJlZCkpDQo+ICAN
Cg0KUGF0Y2ggQXBwbGllZA==
