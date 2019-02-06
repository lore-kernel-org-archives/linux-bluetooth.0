Return-Path: <SRS0=OPIh=QN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9732C169C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 16:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48172175B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Feb 2019 16:23:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbfBFQXj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:23:39 -0500
Received: from mga14.intel.com ([192.55.52.115]:42726 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726306AbfBFQXj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Feb 2019 11:23:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Feb 2019 08:23:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,340,1544515200"; 
   d="scan'208";a="297714993"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 06 Feb 2019 08:23:38 -0800
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 6 Feb 2019 08:23:38 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.210]) by
 ORSMSX163.amr.corp.intel.com ([169.254.9.130]) with mapi id 14.03.0415.000;
 Wed, 6 Feb 2019 08:23:37 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>
Subject: Re: [PATCH BlueZ v2] TODO: Fix complexity level for Bluetooth mesh
 items
Thread-Topic: [PATCH BlueZ v2] TODO: Fix complexity level for Bluetooth mesh
 items
Thread-Index: AQHUvOGy1Fv96JatHkSROavQb49nvqXTfPaA
Date:   Wed, 6 Feb 2019 16:23:36 +0000
Message-ID: <1549470215.20217.0.camel@intel.com>
References: <20190204233101.6775-1-inga.stotland@intel.com>
In-Reply-To: <20190204233101.6775-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.13.173]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3923A40363629C4FBDD13D55BF427676@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

YXBwbGllZA0KDQpPbiBNb24sIDIwMTktMDItMDQgYXQgMTU6MzEgLTA4MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IC0tLQ0KPiAgVE9ETyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL1RPRE8g
Yi9UT0RPDQo+IGluZGV4IDM3NDYyZDZlOC4uNTk4NjEwMjgwIDEwMDY0NA0KPiAtLS0gYS9UT0RP
DQo+ICsrKyBiL1RPRE8NCj4gQEAgLTIxNSwxMiArMjE1LDEyIEBAIE1lc2gNCj4gIC0gRGVzaWdu
IGFuZCBpbXBsZW1lbnQgTWVzaCBQcm92aXNpb25lci8gQ29uZmlndXJhdGlvbiBDbGllbnQgTW9k
ZWwuDQo+ICANCj4gICAgUHJpb3JpdHk6IE1lZGl1bQ0KPiAtICBDb21wbGV4aXR5OiBDMw0KPiAr
ICBDb21wbGV4aXR5OiBDNA0KPiAgDQo+ICAtIEFkZCBzdXBwb3J0IGZvciBHQVRUIHByb3h5IHNl
cnZlcg0KPiAgDQo+ICAgIFByaW9yaXR5OiBMb3cNCj4gLSAgQ29tcGxleGl0eTogQzMNCj4gKyAg
Q29tcGxleGl0eTogQzQNCj4gIA0KPiAgLSBNZXJnZSBjb21tb24gZnVuY3Rpb25hbGl0eSBmcm9t
IHRvb2xzL21lc2guIElkZWFsbHksIHNvdXJjZSBjb2RlIGZyb20gdGhlDQo+ICAgIHRvb2xzL21l
c2ggZGlyZWN0b3J5IHNob3VsZCBjb21wbGV0ZWx5IGRpc3NhcGVhci4NCj4gQEAgLTIzMyw3ICsy
MzMsNyBAQCBNZXNoDQo+ICAgIFByaW9yaXR5OiBMb3cNCj4gICAgQ29tcGxleGl0eTogQzQNCj4g
IA0KPiAtLSBTdXBwb3J0IGZvciBhbGwgdGhlIFByb3Zpc2lvbmluZ3MgT09CIHN0eWxlcw0KPiAr
LSBTdXBwb3J0IGZvciBhbGwgdGhlIHByb3Zpc2lvbmluZyBPT0IgdHlwZXMNCj4gIA0KPiAgICBQ
cmlvcml0eTogTWVkaXVtDQo+ICAgIENvbXBsZXhpdHk6IEMy
