Return-Path: <SRS0=YDOl=QL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADBAC282C4
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 040ED20821
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Feb 2019 20:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbfBDUMb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Feb 2019 15:12:31 -0500
Received: from mga18.intel.com ([134.134.136.126]:19552 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbfBDUMb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Feb 2019 15:12:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 12:12:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="317606536"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by fmsmga005.fm.intel.com with ESMTP; 04 Feb 2019 12:12:30 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX110.amr.corp.intel.com ([169.254.10.158]) with mapi id 14.03.0415.000;
 Mon, 4 Feb 2019 12:12:30 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ v2 0/2] Updated mesh D-Bus policy patch
Thread-Topic: [PATCH BlueZ v2 0/2] Updated mesh D-Bus policy patch
Thread-Index: AQHUr6tKquoRqqMinE2xZmIpx81a5KXQsqwA
Date:   Mon, 4 Feb 2019 20:12:29 +0000
Message-ID: <1549311148.22761.4.camel@intel.com>
References: <20190119035837.6053-1-inga.stotland@intel.com>
In-Reply-To: <20190119035837.6053-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.13.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B69A3D6FEB51ED45AF0B2CD3CE605187@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQoNCkFwcGxpZWQNCg0KT24gRnJpLCAyMDE5LTAxLTE4IGF0IDE5OjU4IC0wODAwLCBJbmdhIFN0
b3RsYW5kIHdyb3RlOg0KPiBUaGlzIEFkZHJlc3NlcyBNYXJjZWwncyBjb21tZW50czoNCj4gbWVz
aCBkYWVtaW9uIGV4ZWN1dGFibGUgaXMgcmVuYW1lZCB0byBibHVldG9vdGgtbWVzaGQgYW5kDQo+
IHRoZSBELUJ1cyBwb2xpY3kgaXMgbmFtZSBhY2NvcmRpbmdseSBibHVldG9vdGgtbWVzaC5jb25m
DQo+IA0KPiBJbmdhIFN0b3RsYW5kICgyKToNCj4gICBtZXNoOiBSZW5hbWUgbWVzaCBkYWVtb24g
ZXhlY3V0YWJsZSB0byBibHVldG9vdGgtbWVzaGQNCj4gICBtZXNoOiBBZGQgRC1CdXMgcG9saWN5
IGZvciBCbHVldG9vdGggbWVzaCBkYWVtb24NCj4gDQo+ICBNYWtlZmlsZS5tZXNoICAgICAgICAg
ICAgfCAxNCArKysrKysrKysrLS0tLQ0KPiAgbWVzaC9ibHVldG9vdGgtbWVzaC5jb25mIHwgMjIg
KysrKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQ0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IG1lc2gvYmx1ZXRvb3Ro
LW1lc2guY29uZg0KPiA=
