Return-Path: <SRS0=ctyp=MG=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F02BECE560
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Sep 2018 15:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 534AA2087A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Sep 2018 15:48:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 534AA2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbeIXVvc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Sep 2018 17:51:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:56650 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbeIXVvc (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Sep 2018 17:51:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2018 08:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,298,1534834800"; 
   d="scan'208";a="93272045"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
  by orsmga001.jf.intel.com with ESMTP; 24 Sep 2018 08:46:42 -0700
Received: from fmsmsx103.amr.corp.intel.com ([169.254.2.16]) by
 FMSMSX105.amr.corp.intel.com ([169.254.4.63]) with mapi id 14.03.0319.002;
 Mon, 24 Sep 2018 08:46:42 -0700
From:   "Hunt, Preston" <preston.hunt@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH BlueZ] test/example-advertisement: add shutdown code
Thread-Topic: [PATCH BlueZ] test/example-advertisement: add shutdown code
Thread-Index: AQHUUcuiqacHtN6PFEK5aqYfERSN+qT7iNuA//+6GYCABFUHgA==
Date:   Mon, 24 Sep 2018 15:46:41 +0000
Message-ID: <69CBFA6F-BD2D-4D2B-BBC3-93C1B83C8ADE@intel.com>
References: <5EDC8785-AB89-452A-AC80-E31A244A4467@intel.com>
 <CABBYNZKArwJcBQG+45=5VHnQ9aEb1YLz_5Of74K2sRO==VcFYw@mail.gmail.com>
 <2E41061B-EEAD-4AEA-8F2D-BB7A8753D77B@intel.com>
In-Reply-To: <2E41061B-EEAD-4AEA-8F2D-BB7A8753D77B@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/10.10.2.180910
x-originating-ip: [10.254.47.183]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BED8477AD312BC4C9F6A164A55129B0E@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhlIHByZXZpb3VzIHNhbXBsZSBjb2RlIGRpZCBub3QgcmVsZWFzZSBhbGwgcmVzb3VyY2VzIHdo
ZW4gc2h1dHRpbmcNCmRvd24uIFRoaXMgaXMgZmluZSB3aGVuIGl0J3MgYSBzdGFuZGFsb25lIHBy
b2dyYW0gc2luY2UgUHl0aG9uIHdpbGwgZnJlZQ0KYWxsIHJlc291cmNlcyBhdXRvbWF0aWNhbGx5
IHdoZW4gdGhlIHByb2Nlc3MgdGVybWluYXRlcy4gSG93ZXZlciwgaW4gYQ0KbG9uZy1ydW5uaW5n
IHByb2Nlc3MsIHRoaXMgd2lsbCBldmVudHVhbGx5IGNhdXNlIHByb2JsZW1zLg0KDQpUaGlzIGNo
YW5nZXNldCBzaG93cyBob3cgdG8gcHJvcGVybHkgcmVsZWFzZSBhbGwgcmVzb3VyY2VzLCBpZiBh
biBvcHRpb25hbA0KY29tbWFuZCBsaW5lICItLXRpbWVvdXQiIGFyZ3VtZW50IGlzIHVzZWQuIFRo
ZSBkZWZhdWx0IGlzIG5vIHRpbWVvdXQgdG8NCm1haW50YWluIGJlaGF2aW9yIG9mIHRoZSBwcmV2
aW91cyBpbXBsZW1lbnRhdGlvbiAoYWR2ZXJ0aXNlbWVudHMgd2lsbCBydW4NCmZvcmV2ZXIpLg0K
LS0tDQogdGVzdC9leGFtcGxlLWFkdmVydGlzZW1lbnQgfCA0MiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygr
KSwgMTAgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS90ZXN0L2V4YW1wbGUtYWR2ZXJ0aXNl
bWVudCBiL3Rlc3QvZXhhbXBsZS1hZHZlcnRpc2VtZW50DQppbmRleCBmZDg0ZWFjLi44OGEyN2Fi
IDEwMDc1NQ0KLS0tIGEvdGVzdC9leGFtcGxlLWFkdmVydGlzZW1lbnQNCisrKyBiL3Rlc3QvZXhh
bXBsZS1hZHZlcnRpc2VtZW50DQpAQCAtMiwxOSArMiwxOCBAQA0KIA0KIGZyb20gX19mdXR1cmVf
XyBpbXBvcnQgcHJpbnRfZnVuY3Rpb24NCiANCitpbXBvcnQgYXJncGFyc2UNCiBpbXBvcnQgZGJ1
cw0KIGltcG9ydCBkYnVzLmV4Y2VwdGlvbnMNCiBpbXBvcnQgZGJ1cy5tYWlubG9vcC5nbGliDQog
aW1wb3J0IGRidXMuc2VydmljZQ0KLQ0KLWltcG9ydCBhcnJheQ0KK2ltcG9ydCB0aW1lDQoraW1w
b3J0IHRocmVhZGluZw0KIA0KIHRyeToNCi0gIGZyb20gZ2kucmVwb3NpdG9yeSBpbXBvcnQgR09i
amVjdCAgIyBweXRob24zDQorICAgIGZyb20gZ2kucmVwb3NpdG9yeSBpbXBvcnQgR09iamVjdCAg
IyBweXRob24zDQogZXhjZXB0IEltcG9ydEVycm9yOg0KLSAgaW1wb3J0IGdvYmplY3QgYXMgR09i
amVjdCAgIyBweXRob24yDQotDQotZnJvbSByYW5kb20gaW1wb3J0IHJhbmRpbnQNCisgICAgaW1w
b3J0IGdvYmplY3QgYXMgR09iamVjdCAgIyBweXRob24yDQogDQogbWFpbmxvb3AgPSBOb25lDQog
DQpAQCAtMTM2LDYgKzEzNSw3IEBAIGNsYXNzIEFkdmVydGlzZW1lbnQoZGJ1cy5zZXJ2aWNlLk9i
amVjdCk6DQogICAgIGRlZiBSZWxlYXNlKHNlbGYpOg0KICAgICAgICAgcHJpbnQoJyVzOiBSZWxl
YXNlZCEnICUgc2VsZi5wYXRoKQ0KIA0KKw0KIGNsYXNzIFRlc3RBZHZlcnRpc2VtZW50KEFkdmVy
dGlzZW1lbnQpOg0KIA0KICAgICBkZWYgX19pbml0X18oc2VsZiwgYnVzLCBpbmRleCk6DQpAQCAt
MTcwLDcgKzE3MCwxMyBAQCBkZWYgZmluZF9hZGFwdGVyKGJ1cyk6DQogICAgIHJldHVybiBOb25l
DQogDQogDQotZGVmIG1haW4oKToNCitkZWYgc2h1dGRvd24odGltZW91dCk6DQorICAgIHByaW50
KCdBZHZlcnRpc2luZyBmb3Ige30gc2Vjb25kcy4uLicuZm9ybWF0KHRpbWVvdXQpKQ0KKyAgICB0
aW1lLnNsZWVwKHRpbWVvdXQpDQorICAgIG1haW5sb29wLnF1aXQoKQ0KKw0KKw0KK2RlZiBtYWlu
KHRpbWVvdXQ9MCk6DQogICAgIGdsb2JhbCBtYWlubG9vcA0KIA0KICAgICBkYnVzLm1haW5sb29w
LmdsaWIuREJ1c0dNYWluTG9vcChzZXRfYXNfZGVmYXVsdD1UcnVlKQ0KQEAgLTE4Myw3ICsxODks
NyBAQCBkZWYgbWFpbigpOg0KICAgICAgICAgcmV0dXJuDQogDQogICAgIGFkYXB0ZXJfcHJvcHMg
PSBkYnVzLkludGVyZmFjZShidXMuZ2V0X29iamVjdChCTFVFWl9TRVJWSUNFX05BTUUsIGFkYXB0
ZXIpLA0KLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIm9yZy5mcmVlZGVza3Rv
cC5EQnVzLlByb3BlcnRpZXMiKTsNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICJvcmcuZnJlZWRlc2t0b3AuREJ1cy5Qcm9wZXJ0aWVzIikNCiANCiAgICAgYWRhcHRlcl9wcm9w
cy5TZXQoIm9yZy5ibHVlei5BZGFwdGVyMSIsICJQb3dlcmVkIiwgZGJ1cy5Cb29sZWFuKDEpKQ0K
IA0KQEAgLTE5OCw3ICsyMDQsMjMgQEAgZGVmIG1haW4oKToNCiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVwbHlfaGFuZGxlcj1yZWdpc3Rlcl9hZF9jYiwNCiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZXJyb3JfaGFuZGxlcj1yZWdpc3Rlcl9hZF9l
cnJvcl9jYikNCiANCi0gICAgbWFpbmxvb3AucnVuKCkNCisgICAgaWYgdGltZW91dCA+IDA6DQor
ICAgICAgICB0aHJlYWRpbmcuVGhyZWFkKHRhcmdldD1zaHV0ZG93biwgYXJncz0odGltZW91dCwp
KS5zdGFydCgpDQorICAgIGVsc2U6DQorICAgICAgICBwcmludCgnQWR2ZXJ0aXNpbmcgZm9yZXZl
ci4uLicpDQorDQorICAgIG1haW5sb29wLnJ1bigpICAjIGJsb2NrcyB1bnRpbCBtYWlubG9vcC5x
dWl0KCkgaXMgY2FsbGVkDQorDQorICAgIGFkX21hbmFnZXIuVW5yZWdpc3RlckFkdmVydGlzZW1l
bnQodGVzdF9hZHZlcnRpc2VtZW50KQ0KKyAgICBwcmludCgnQWR2ZXJ0aXNlbWVudCB1bnJlZ2lz
dGVyZWQnKQ0KKyAgICBkYnVzLnNlcnZpY2UuT2JqZWN0LnJlbW92ZV9mcm9tX2Nvbm5lY3Rpb24o
dGVzdF9hZHZlcnRpc2VtZW50KQ0KKw0KIA0KIGlmIF9fbmFtZV9fID09ICdfX21haW5fXyc6DQot
ICAgIG1haW4oKQ0KKyAgICBwYXJzZXIgPSBhcmdwYXJzZS5Bcmd1bWVudFBhcnNlcigpDQorICAg
IHBhcnNlci5hZGRfYXJndW1lbnQoJy0tdGltZW91dCcsIGRlZmF1bHQ9MCwgdHlwZT1pbnQsIGhl
bHA9ImFkdmVydGlzZSAiICsNCisgICAgICAgICAgICAgICAgICAgICAgICAiZm9yIHRoaXMgbWFu
eSBzZWNvbmRzIHRoZW4gc3RvcCwgMD1ydW4gZm9yZXZlciAiICsNCisgICAgICAgICAgICAgICAg
ICAgICAgICAiKGRlZmF1bHQ6IDApIikNCisgICAgYXJncyA9IHBhcnNlci5wYXJzZV9hcmdzKCkN
CisNCisgICAgbWFpbihhcmdzLnRpbWVvdXQpDQotLSANCjIuNy40DQoNCg==
