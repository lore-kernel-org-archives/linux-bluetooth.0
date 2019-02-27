Return-Path: <SRS0=vyxk=RC=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B662EC43381
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 18:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E94A2183F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Feb 2019 18:36:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfB0Sg0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:36:26 -0500
Received: from mga03.intel.com ([134.134.136.65]:51266 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726594AbfB0Sg0 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Feb 2019 13:36:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 10:36:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="121294496"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2019 10:36:25 -0800
Received: from orsmsx160.amr.corp.intel.com (10.22.226.43) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 27 Feb 2019 10:36:25 -0800
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.129]) by
 ORSMSX160.amr.corp.intel.com ([169.254.13.249]) with mapi id 14.03.0415.000;
 Wed, 27 Feb 2019 10:36:24 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "a.rai@samsung.com" <a.rai@samsung.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Anupam Roy <anupam.r@samsung.com>,
        Maneesh Jain <maneesh.jain@samsung.com>,
        SACHIN DEV SHARMA <sachin.dev@samsung.com>
Subject: RE: Query regarding BLE Mesh provisioning
Thread-Topic: Query regarding BLE Mesh provisioning
Thread-Index: AQHUzOfRrK3WWA+yQUqs3uge+mNS0qXz+oaw
Date:   Wed, 27 Feb 2019 18:36:24 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D93969B@ORSMSX103.amr.corp.intel.com>
References: <CGME20190225082813epcms5p8052825469b7459d632a2a1aa6508192a@epcms5p8>
 <20190225082813epcms5p8052825469b7459d632a2a1aa6508192a@epcms5p8>
In-Reply-To: <20190225082813epcms5p8052825469b7459d632a2a1aa6508192a@epcms5p8>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMTg3MTliODgtYmI0OS00NmU1LTg5NDctYjMxYzVjNzA5ODA2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoidTlaV2JTanBxUlJxdjdnemVrOG5UXC82YnJiMUJoNURHa2RmUjFpVGJNWHpZNFlqNFRubnZjQnZUN21ncFhxRXoifQ==
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQXR1bCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51eC1i
bHVldG9vdGgtb3duZXJAdmdlci5rZXJuZWwub3JnIFttYWlsdG86bGludXgtYmx1ZXRvb3RoLQ0K
PiBvd25lckB2Z2VyLmtlcm5lbC5vcmddIE9uIEJlaGFsZiBPZiBBdHVsIEt1bWFyIFJhaQ0KPiBT
ZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI1LCAyMDE5IDEyOjI4IEFNDQo+IFRvOiBsaW51eC1ibHVl
dG9vdGhAdmdlci5rZXJuZWwub3JnDQo+IENjOiBBbnVwYW0gUm95IDxhbnVwYW0uckBzYW1zdW5n
LmNvbT47IE1hbmVlc2ggSmFpbg0KPiA8bWFuZWVzaC5qYWluQHNhbXN1bmcuY29tPjsgU0FDSElO
IERFViBTSEFSTUENCj4gPHNhY2hpbi5kZXZAc2Ftc3VuZy5jb20+DQo+IFN1YmplY3Q6IFF1ZXJ5
IHJlZ2FyZGluZyBCTEUgTWVzaCBwcm92aXNpb25pbmcNCj4gDQo+IEhpLA0KPiANCj4gV2UgYXJl
IGxvb2tpbmcgdG8gZW5hYmxlIEJMRSBNZXNoIGluIG91ciBzZXR1cC4NCj4gQnV0IGl0IHNlZW1z
IGN1cnJlbnRseSBvbmx5IFBCLUFEViBiYXNlZCBtZXNoIG5vZGUgcm9sZSBpcyBzdXBwb3J0ZWQg
YnkNCj4gYmx1ZXRvb3RoLW1lc2hkLHdoaWxlIG1lc2hjdGwgb25seSBzdXBwb3J0cyBQQi1HQVRU
IGJhc2VkIG1lc2gNCj4gcHJvdmlzaW9uZXIuDQoNCkFEViBiYXNlZCBQcm92aXNpb25lciByb2xl
IGlzIGF0IHRoZSB0b3Agb2YgbXkgVE9ETyBsaXN0IGZvciBzdXBwb3J0LCBhbmQgdGhhdCBpcyB3
aGF0IEkgYW0gcGVyc29uYWxseSB3b3JraW5nIG9uIHN1cHBvcnRpbmcgbmV4dC4gIEl0IHJlcXVp
cmVzIHNvbWUgZXh0cmEgRC1CdXMgaW50ZXJmYWNlcyB0byBhbGxvdyBjb250cm9sIG9mIGEgTWVz
aCBOZXR3b3JrIChib3RoIGZvciBQcm92aXNpb25pbmcgYW5kIGFzICJDb25maWd1cmF0aW9uIENs
aWVudCIpIGFuZCB0aGVuIHdpbGwgYWxzbyByZXF1aXJlIGFuIEFwcGxpY2F0aW9uIChleHRlcm5h
bCB0byB0aGUgZGFlbW9uKSB3aGljaCB3aWxsIHVzZSB0aGUgbmV3IEFQSXMuDQoNCg0KPiBDb3Vs
ZCB5b3UgcGxlYXNlIGxldCB1cyBrbm93LCBieSB3aGVuIG1lc2ggcHJvdmlzaW9uZXIgcm9sZSBz
dXBwb3J0IHdpbGwgYmUNCj4gYXZhaWxhYmxlIGluIGJsdWV0b290aC1tZXNoZC4NCj4gQWxzbyBw
bGVhc2UgZ3VpZGUgbWUgb24sICJob3cgdG8gcHJvdmlzaW9uIGJsdWV0b290aC1tZXNoZCBiYXNl
ZCBub2RlIg0KPiBjdXJyZW50bHkuDQoNCklmIHlvdSBoYXZlIGFuIEFEViBiYXNlZCBwcm92aXNp
b25lciwgeW91IGNhbiBjdXJyZW50bHkgcnVuIHRoZSB0ZXN0L3Rlc3Qtam9pbiBweXRob24gc2Ny
aXB0Og0KDQolIHB5dGhvbjMgdGVzdC90ZXN0LWpvaW4NCg0Kd2hpY2ggaWYgc3VjY2Vzc2Z1bCB3
aWxsIGNyZWF0ZSBhIG5ldyBsb2NhbCBtZXNoIG5vZGUuDQoNCj4gDQo+IC0gUmVnYXJkcywNCj4g
QXR1bCBLdW1hciBSYWkNCj4gDQo=
