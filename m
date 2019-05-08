Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAD1C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 19:21:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BAA1216C4
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 19:21:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfEHTVa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 15:21:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:17829 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727407AbfEHTV3 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 15:21:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 12:21:27 -0700
X-ExtLoop1: 1
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga001.jf.intel.com with ESMTP; 08 May 2019 12:21:27 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.144]) with mapi id 14.03.0415.000;
 Wed, 8 May 2019 12:21:27 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Build Warnings, BlueZ TIP, Fedora-30
Thread-Topic: Build Warnings, BlueZ TIP, Fedora-30
Thread-Index: AQHVBdM7qJSYRVHedk2EmjO9QNxIPw==
Date:   Wed, 8 May 2019 19:21:26 +0000
Message-ID: <1557343285.14401.4.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.251.10.18]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF1F78991B1E4A45975B29CA8A6295F8@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhlc2UgMyBuZXcgYnVpbGQgd2FybmluZ3Mgc2hvd2VkIHVwIHdoZW4gSSB1cGdyYWRlZCBvbmUg
b2YgbXkgZGV2aWNlcyB0byBGZWRvcmEgMzAuDQoNClRoZXkgYXJlIGFsbCBpbiB0aGUgQW5kcm9p
ZCBzdWJ0cmVlLg0KDQoNCiQgZ2NjIC0tdmVyc2lvbg0KZ2NjIChHQ0MpIDkuMS4xIDIwMTkwNTAz
IChSZWQgSGF0IDkuMS4xLTEpDQoNCiQgdW5hbWUgLWENCkxpbnV4IGJnaXgtbnVjLTEuc2VhLmlu
dGVsLmNvbSA1LjAuMTEtMzAwLmZjMzAueDg2XzY0ICMxIFNNUCBUaHUgTWF5IDIgMTQ6MTE6Mzgg
VVRDIDIwMTkgeDg2XzY0IHg4Nl82NCB4ODZfNjQNCkdOVS9MaW51eA0KDQokIG1ha2UgLWsNCm1h
a2UgLS1uby1wcmludC1kaXJlY3RvcnkgYWxsLWFtDQogIENDICAgICAgIGFuZHJvaWQvYXZyY3At
bGliLm8NCmFuZHJvaWQvYXZyY3AtbGliLmM6IEluIGZ1bmN0aW9uIOKAmGdldF9lbGVtZW50X2F0
dHJpYnV0ZXPigJk6DQphbmRyb2lkL2F2cmNwLWxpYi5jOjk2NzoyNzogZXJyb3I6IHRha2luZyBh
ZGRyZXNzIG9mIHBhY2tlZCBtZW1iZXIgb2Yg4oCYc3RydWN0IGdldF9lbGVtZW50X2F0dHJpYnV0
ZXNfcmVx4oCZIG1heQ0KcmVzdWx0IGluIGFuIHVuYWxpZ25lZCBwb2ludGVyIHZhbHVlIFstV2Vy
cm9yPWFkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcl0NCiAgOTY3IHwgIGlmICghcGFyc2VfYXR0cmli
dXRlcyhyZXEtPmF0dHJzLCBwYXJhbXNfbGVuIC0gc2l6ZW9mKCpyZXEpLA0KICAgICAgfCAgICAg
ICAgICAgICAgICAgICAgICAgIH5+fl5+fn5+fn4NCmNjMTogYWxsIHdhcm5pbmdzIGJlaW5nIHRy
ZWF0ZWQgYXMgZXJyb3JzDQptYWtlWzFdOiAqKiogW01ha2VmaWxlOjY1Nzg6IGFuZHJvaWQvYXZy
Y3AtbGliLm9dIEVycm9yIDENCiAgQ0MgICAgICAgYW5kcm9pZC9oYW5kc2ZyZWUubw0KYW5kcm9p
ZC9oYW5kc2ZyZWUuYzogSW4gZnVuY3Rpb24g4oCYYnRfc2NvX2dldF9mZOKAmToNCmFuZHJvaWQv
aGFuZHNmcmVlLmM6MjkxMzo0NzogZXJyb3I6IHRha2luZyBhZGRyZXNzIG9mIHBhY2tlZCBtZW1i
ZXIgb2Yg4oCYc3RydWN0IHNjb19yc3BfZ2V0X2Zk4oCZIG1heSByZXN1bHQgaW4gYW4NCnVuYWxp
Z25lZCBwb2ludGVyIHZhbHVlIFstV2Vycm9yPWFkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcl0NCiAy
OTEzIHwgIGlmICghZGV2IHx8ICFidF9zY29fZ2V0X2ZkX2FuZF9tdHUoc2NvLCAmZmQsICZyc3Au
bXR1KSkNCiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIF5+fn5+fn5+DQpjYzE6IGFsbCB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0K
bWFrZVsxXTogKioqIFtNYWtlZmlsZTo2NTc4OiBhbmRyb2lkL2hhbmRzZnJlZS5vXSBFcnJvciAx
DQogIENDICAgICAgIGFuZHJvaWQvYmx1ZXRvb3RoX2RlZmF1bHRfbGEtaGFsLWJsdWV0b290aC5s
bw0KYW5kcm9pZC9oYWwtYmx1ZXRvb3RoLmM6IEluIGZ1bmN0aW9uIOKAmHNldF9hZGFwdGVyX3By
b3BlcnR54oCZOg0KYW5kcm9pZC9oYWwtYmx1ZXRvb3RoLmM6NjU5OjQ2OiBlcnJvcjogdGFraW5n
IGFkZHJlc3Mgb2YgcGFja2VkIG1lbWJlciBvZiDigJhzdHJ1Y3QgaGFsX2NtZF9zZXRfYWRhcHRl
cl9wcm9w4oCZIG1heQ0KcmVzdWx0IGluIGFuIHVuYWxpZ25lZCBwb2ludGVyIHZhbHVlIFstV2Vy
cm9yPWFkZHJlc3Mtb2YtcGFja2VkLW1lbWJlcl0NCiAgNjU5IHwgIGFkYXB0ZXJfcHJvcF9mcm9t
X2hhbChwcm9wZXJ0eSwgJmNtZC0+dHlwZSwgJmNtZC0+bGVuLCBjbWQtPnZhbCk7DQogICAgICB8
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5+fn5+fn5+fg0K
Y2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRlZCBhcyBlcnJvcnMNCm1ha2VbMV06ICoqKiBb
TWFrZWZpbGU6NjYzNzogYW5kcm9pZC9ibHVldG9vdGhfZGVmYXVsdF9sYS1oYWwtYmx1ZXRvb3Ro
LmxvXSBFcnJvciAxDQptYWtlWzFdOiBUYXJnZXQgJ2FsbC1hbScgbm90IHJlbWFkZSBiZWNhdXNl
IG9mIGVycm9ycy4NCm1ha2U6ICoqKiBbTWFrZWZpbGU6Mzg3MjogYWxsXSBFcnJvciAy
