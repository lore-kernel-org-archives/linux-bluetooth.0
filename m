Return-Path: <SRS0=9KbV=OH=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AA4EC43441
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 17:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6F52081C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Nov 2018 17:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A6F52081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbeK2EEA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Nov 2018 23:04:00 -0500
Received: from mga18.intel.com ([134.134.136.126]:21474 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728807AbeK2EEA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Nov 2018 23:04:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2018 09:01:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,291,1539673200"; 
   d="scan'208";a="287935317"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by fmsmga005.fm.intel.com with ESMTP; 28 Nov 2018 09:01:41 -0800
Received: from orsmsx112.amr.corp.intel.com (10.22.240.13) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 28 Nov 2018 09:01:41 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX112.amr.corp.intel.com ([169.254.3.8]) with mapi id 14.03.0415.000;
 Wed, 28 Nov 2018 09:01:41 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Cinaed Simson <cinaed.simson@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: bug in mesh/net.c
Thread-Topic: bug in mesh/net.c
Thread-Index: AQHUhiXrfZVAcP0pQkqmYlzaSML63aVlakng
Date:   Wed, 28 Nov 2018 17:01:40 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375C139642@ORSMSX103.amr.corp.intel.com>
References: <5e734285-be09-bfef-6795-237a5ab0350a@GMail.COM>
In-Reply-To: <5e734285-be09-bfef-6795-237a5ab0350a@GMail.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2Y1NWNmNTAtOTE3MC00ZjlmLWExMWQtNTgxYjYyOTY3ZWIwIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOXpxdmNYRTZhSm5RXC9NWnJqTllzNlpnMWZjK1VjR1Y4WWFkd1VDTzhodE9iZnJqS1d3TXdRRGRsXC9yQWd6bk0yIn0=
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQ2luZWFkLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IG93bmVyQHZnZXIu
a2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIENpbmFlZCBTaW1zb24NCj4gU2VudDogTW9uZGF5LCBO
b3ZlbWJlciAyNiwgMjAxOCAxMTo1MSBQTQ0KPiBTdWJqZWN0OiBidWcgaW4gbWVzaC9uZXQuYw0K
PiANCj4gDQo+IExpbmUgMzMxNyBpbiBuZXQuYyByZWFkcyBzb21ldGhpbmcgbGlrZQ0KPiANCj4g
ICBmb3IoaW50IGk9MCwgLi4uLg0KPiANCj4gd2hpY2ggSSBoYWQgY2hhbmdlIHRvDQo+IA0KPiAg
IGludCBpOw0KPiAgIGZvcihpPTAsLi4uDQoNClRoYW5rIHlvdSBmb3IgdGhpcyByZXBvcnQuICBJ
ZiB5b3Ugd291bGQgbGlrZSB5b3VyIG5hbWUgaW4gdGhlIGNoYW5nZSBsb2csIHBsZWFzZSBzdWJt
aXQgdGhpcyBhcyBhIEdJVCBQYXRjaCwgYW5kIEkgd2lsbCBhcHBseSBpdCBkaXJlY3RseS4gIE90
aGVyd2lzZSwgSSB3aWxsIG1ha2Ugc3VyZSBpdCBpcyBmaXhlZCBpbiB0aGUgbmV4dCBzZXQgb2Yg
cGF0Y2hlcyB0aGF0IHdlIHB1c2guDQoNCg0KPiBpbiBvcmRlciB0byBnZXQgdGhlIGxhdGVzdCBn
aXQgdmVyc2lvbiBvZiBibHVleiB0byBjb21waWxlLg0KPiANCj4gLS0gQ2luYWVkDQo=
