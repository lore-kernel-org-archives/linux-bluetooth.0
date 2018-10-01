Return-Path: <SRS0=AfC+=MN=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A709AC43143
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 09:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C64020C0A
	for <linux-bluetooth@archiver.kernel.org>; Mon,  1 Oct 2018 09:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C64020C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbeJAQDj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 1 Oct 2018 12:03:39 -0400
Received: from mga06.intel.com ([134.134.136.31]:37330 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729028AbeJAQDj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 1 Oct 2018 12:03:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 01 Oct 2018 02:26:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,327,1534834800"; 
   d="scan'208";a="267380772"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 01 Oct 2018 02:26:46 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 1 Oct 2018 02:26:46 -0700
Received: from bgsmsx154.gar.corp.intel.com (10.224.48.47) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Mon, 1 Oct 2018 02:26:45 -0700
Received: from bgsmsx105.gar.corp.intel.com ([169.254.3.9]) by
 BGSMSX154.gar.corp.intel.com ([169.254.7.90]) with mapi id 14.03.0319.002;
 Mon, 1 Oct 2018 14:56:43 +0530
From:   "Phulari, Mallikarjun" <mallikarjun.phulari@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth : Errata Service Release 8, Erratum 3253
Thread-Topic: [PATCH] Bluetooth : Errata Service Release 8, Erratum 3253
Thread-Index: AQHUVk4v5YfhXKFLGE2D0LWU1vNTYqUKIuNg
Date:   Mon, 1 Oct 2018 09:26:42 +0000
Message-ID: <70C091497DE2844DBD9E143B2282ABDA9C2A9C@BGSMSX105.gar.corp.intel.com>
References: <1537780600-4098-1-git-send-email-mallikarjun.phulari@intel.com>
 <6855B2F4-544E-4CE7-A3C9-6324877E25F9@holtmann.org>
In-Reply-To: <6855B2F4-544E-4CE7-A3C9-6324877E25F9@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZDQ2ZjNmMTgtZDJkYy00MjRhLWExYTItOWEyZmQ0MTgyNGM4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiUzRSRVhBdDRqOER6N0tTTFYyT3dkeCtRcUFCZXB1YWlpcTZ6M2hWUkR6eVBiWWVPc2xNejQyTEdzdkp4WHhCSSJ9
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.223.10.10]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+IEhpIE1hbGxpa2FyanVuLA0KPiANCj4gPiBMMkNBUDogTmV3IHJlc3Vs
dCB2YWx1ZXMNCj4gPiAJMHgwMDA2IC0gQ29ubmVjdGlvbiByZWZ1c2VkIOKAkyBJbnZhbGlkIFNv
dXJjZSBDSUQNCj4gPiAJMHgwMDA3IC0gQ29ubmVjdGlvbiByZWZ1c2VkIOKAkyBTb3VyY2UgQ0lE
IGFscmVhZHkgYWxsb2NhdGVkDQo+ID4NCj4gPiBBcyBwZXIgdGhlIEVTUjA4X1YxLjAuMCwgMS4x
MS4yIEVycmF0dW0gMzI1MywgUGFnZSBOby4gNTQsICJSZW1vdGUgQ0lEDQo+ID4gaW52YWxpZCBJ
c3N1ZSIuDQo+ID4gQXBwbGllcyB0byBDb3JlIFNwZWNpZmljYXRpb24gdmVyc2lvbnM6IFY1LjAs
IFY0LjIsIHY0LjEsIHY0LjAsIGFuZA0KPiA+IHYzLjAgKyBIUyBWb2wgMywgUGFydCBBLCBTZWN0
aW9uIDQuMiwgNC4zLCA0LjE0LCA0LjE1Lg0KPiA+DQo+ID4gQ29yZSBTcGVjaWZpY2F0aW9uIFZl
cnNpb24gNS4wLCBQYWdlIE5vLjE3NTMsIFRhYmxlIDQuNiBhbmQgUGFnZSBOby4NCj4gPiAxNzY3
LCBUYWJsZSA0LjE0DQo+ID4NCj4gPiBOZXcgcmVzdWx0IHZhbHVlcyBhcmUgYWRkZWQgdG8gbDJj
YXAgY29ubmVjdC9jcmVhdGUgY2hhbm5lbCByZXNwb25zZQ0KPiA+IGFzDQo+ID4gMHgwMDA2IC0g
Q29ubmVjdGlvbiByZWZ1c2VkIOKAkyBJbnZhbGlkIFNvdXJjZSBDSUQNCj4gPiAweDAwMDcgLSBD
b25uZWN0aW9uIHJlZnVzZWQg4oCTIFNvdXJjZSBDSUQgYWxyZWFkeSBhbGxvY2F0ZWQNCj4gPg0K
PiA+IFNpZ25lZC1vZmYtYnk6IE1hbGxpa2FyanVuIFBodWxhcmkgPG1hbGxpa2FyanVuLnBodWxh
cmlAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+IGluY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5o
IHwgIDYgKysrKysrDQo+ID4gbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMgICAgfCAxNyArKysr
KysrKysrKysrKysrLQ0KPiA+IDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9s
MmNhcC5oDQo+ID4gYi9pbmNsdWRlL25ldC9ibHVldG9vdGgvbDJjYXAuaCBpbmRleCAwNjk3ZmQ0
Li5jN2Y5N2NjIDEwMDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbmV0L2JsdWV0b290aC9sMmNhcC5o
DQo+ID4gKysrIGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2wyY2FwLmgNCj4gPiBAQCAtMjg0LDYg
KzI4NCwxMiBAQCBzdHJ1Y3QgbDJjYXBfY29ubl9yc3Agew0KPiA+ICNkZWZpbmUgTDJDQVBfQ1Jf
SU5WQUxJRF9TQ0lECTB4MDAwOQ0KPiA+ICNkZWZpbmUgTDJDQVBfQ1JfU0NJRF9JTl9VU0UJMHgw
MDBBDQo+ID4NCj4gPiArLyogY29ubmVjdC9jcmVhdGUgY2hhbm5lbCByZXN1bHRzDQo+ID4gKyAq
IE5ldyByZXN1bHQgY29kZXNBcyBwZXIgRVNSMDhfVjEuMC4wLCBFcnJhdHVtIDMyNTMgICovDQo+
ID4gKyNkZWZpbmUgTDJDQVBfQ1JfQlJFRFJfSU5WQUxJRF9TQ0lECTB4MDAwNg0KPiA+ICsjZGVm
aW5lIEwyQ0FQX0NSX0JSRURSX1NDSURfSU5fVVNFCTB4MDAwNw0KPiA+ICsNCj4gDQo+IEkgYW0g
Y29uZnVzZWQgaGVyZS4gV2UgY3VycmVudGx5IGhhdmUgdGhpcyBsaXN0Og0KPiANCj4gLyogY29u
bmVjdC9jcmVhdGUgY2hhbm5lbCByZXN1bHRzICovDQo+ICNkZWZpbmUgTDJDQVBfQ1JfU1VDQ0VT
UyAgICAgICAgMHgwMDAwDQo+ICNkZWZpbmUgTDJDQVBfQ1JfUEVORCAgICAgICAgICAgMHgwMDAx
DQo+ICNkZWZpbmUgTDJDQVBfQ1JfQkFEX1BTTSAgICAgICAgMHgwMDAyDQo+ICNkZWZpbmUgTDJD
QVBfQ1JfU0VDX0JMT0NLICAgICAgMHgwMDAzDQo+ICNkZWZpbmUgTDJDQVBfQ1JfTk9fTUVNICAg
ICAgICAgMHgwMDA0DQo+ICNkZWZpbmUgTDJDQVBfQ1JfQkFEX0FNUCAgICAgICAgMHgwMDA1DQo+
ICNkZWZpbmUgTDJDQVBfQ1JfQVVUSEVOVElDQVRJT04gMHgwMDA1DQo+ICNkZWZpbmUgTDJDQVBf
Q1JfQVVUSE9SSVpBVElPTiAgMHgwMDA2DQo+ICNkZWZpbmUgTDJDQVBfQ1JfQkFEX0tFWV9TSVpF
ICAgMHgwMDA3DQo+ICNkZWZpbmUgTDJDQVBfQ1JfRU5DUllQVElPTiAgICAgMHgwMDA4DQo+ICNk
ZWZpbmUgTDJDQVBfQ1JfSU5WQUxJRF9TQ0lEICAgMHgwMDA5DQo+ICNkZWZpbmUgTDJDQVBfQ1Jf
U0NJRF9JTl9VU0UgICAgMHgwMDBBDQo+IA0KPiBOb3cgaGVyZSB3ZSBoYXZlIDB4MDAwNiBhbmQg
MHgwMDA3IHRha2VuLiBIYXZlIHRoZXNlIGJlZW4gY2hhbmdlZCBub3cuDQo+IFRoZSBMMkNBUF9D
Ul9BVVRIT1JJWkFUSU9OIHdlIGFjdHVhbGx5IGRvIHVzZSBpbiBMRSBhbmQgaWYgdGhpcyB0YWJs
ZSBpcyBub3QNCj4gdHJlYXRlZCB3aXRoIGluZGVwZW5kZW50IG5hbWUgc3BhY2VzIGZvciBCUi9F
RFIgdnMgTEUsIHRoZW4gd2UgbmVlZCB0byBzcGxpdA0KPiB0aGlzIG9uZSBmaXJzdCBhbmQgZ2V0
IHRoZSBMRSBvbmx5IG9uZXMgcHJvcGVyIG5hbWVzIGFuZCBmaXggdGhlaXIgdXNhZ2UuDQo+IA0K
VGhlIGN1cnJlbnQgbmFtZSBzcGFjZXMgdGhhdCB5b3UgaGF2ZSBtZW50aW9uZWQgYWJvdmUsIGhh
dmUgdGhlIGNvbWJpbmVkIHJlc3VsdCB2YWx1ZXMgZm9yIExFIENyZWRpdCBiYXNlIENvbm5lY3Rp
b24gKFZPTCAzLCBQYXJ0IEEsIDQuMjMsIFRhYmxlIDQuMjApIGFuZCBmb3IgTDJDQVAgQ3JlYXRl
L0Nvbm5lY3QgKFZPTDMsIFBhcnQgQSwgNC4zIC80LjE1LCBUYWJsZSA0LjYvNC4xNCkuDQpUbyBj
cmVhdGUgc2VwYXJhdGUgbmFtZSBzcGFjZXMgZm9yIGVhY2ggc2V0IG9mIGVycm9yIGNvZGVzIGZv
ciBMMkNBUCBjaGFubmVsIHJlcXVlc3QsIEwyQ0FQIGNyZWF0ZSBDb25uZWN0aW9uIGFuZCBMRSBj
cmVkaXQgYmFzZWQgY3JlYXRlIGNvbm5lY3Rpb24gd2lsbCBhZGQgbW9yZSByZXdvcmsgdG8gcmVw
bGFjZSB0aGUgZXJyb3IgY29kZXMgd2hlcmUgdGhlc2UgYXJlIGJlaW5nIHVzZWQuDQoNClRoZXJl
Zm9yZSwgdG8gYXZvaWQgdGhlIHJld29yayAsIEkgaGFkIHVzZWQgdGhlIHJlc3VsdCB2YWx1ZXMg
YXM6DQoNCiNkZWZpbmUgTDJDQVBfQ1JfQlJFRFJfSU5WQUxJRF9TQ0lECTB4MDAwNg0KI2RlZmlu
ZSBMMkNBUF9DUl9CUkVEUl9TQ0lEX0lOX1VTRQkweDAwMDcNCg0KSWYgeW91IHN1Z2dlc3QgdG8g
c2VwYXJhdGUgdGhlIG5hbWUgc3BhY2VzIGZvciBMRSBhbmQgQlJFRFIgcmVzdWx0IHZhbHVlcywg
SSBzaGFsbCByZS1zZW5kIHRoZSB2MyBwYXRjaCB3aXRoIHRoZSBjaGFuZ2VzLg0KDQo+IFJlZ2Fy
ZHMNCj4gDQo+IE1hcmNlbA0KDQpSZWdhcmRzLA0KTWFsbGlrYXJqdW4gUGh1bGFyaQ0K
