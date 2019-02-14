Return-Path: <SRS0=ZFDx=QV=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C46BC43381
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 14:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3170D2080A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 14 Feb 2019 14:13:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393517AbfBNON1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:13:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:58403 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387611AbfBNON1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 14 Feb 2019 09:13:27 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Feb 2019 06:13:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,369,1544515200"; 
   d="scan'208";a="299729676"
Received: from irsmsx109.ger.corp.intel.com ([163.33.3.23])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2019 06:13:25 -0800
Received: from irsmsx155.ger.corp.intel.com (163.33.192.3) by
 IRSMSX109.ger.corp.intel.com (163.33.3.23) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 14 Feb 2019 14:13:24 +0000
Received: from irsmsx104.ger.corp.intel.com ([169.254.5.56]) by
 irsmsx155.ger.corp.intel.com ([169.254.14.230]) with mapi id 14.03.0415.000;
 Thu, 14 Feb 2019 14:13:24 +0000
From:   "Hedberg, Johan" <johan.hedberg@intel.com>
To:     "kunal.jagadish07@gmail.com" <kunal.jagadish07@gmail.com>
CC:     "devel@lists.zephyrproject.org" <devel@lists.zephyrproject.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [Zephyr-devel] Bluetooth mesh using nrf52 pca10040
 #bluetoothmesh #nrf52832
Thread-Topic: [Zephyr-devel] Bluetooth mesh using nrf52 pca10040
 #bluetoothmesh #nrf52832
Thread-Index: AQHUxG3NuXOCG8T6906fert0UbfZhaXfVgeA
Date:   Thu, 14 Feb 2019 14:13:24 +0000
Message-ID: <9F9CFCE6-10C9-4D15-92EB-32B15DDB2C11@intel.com>
References: <16761.1550151833825943099@lists.zephyrproject.org>
In-Reply-To: <16761.1550151833825943099@lists.zephyrproject.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.252.8.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9210064CAE22F9479F9C7232D93B9BBA@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCk9uIDE0IEZlYiAyMDE5LCBhdCAxNS40Mywga3VuYWwuamFnYWRpc2gwN0BnbWFpbC5j
b20gd3JvdGU6DQo+IEhleSwgSSBhbSB0cnlpbmcgdG8gZXN0YWJsaXNoIGEgYmx1ZXRvb3RoIG1l
c2ggdXNpbmcgdGhlIFJhc3BiZXJyeSBQaSAzIChibHVleiBtZXNoY3RsKSBhcyB0aGUgcHJvdmlz
aW9uZXIgYW5kIHRoZSBucmY1MiBib2FyZHMgYXMgdGhlIG5vZGVzLiBUaGUgbm9kZXMgaGF2ZSB0
byBwZXJpb2RpY2FsbHkgc2VuZCBzZW5zb3IgZGF0YSAoTFBOKSB0byB0aGUgcHJvdmlzaW9uZXIg
KFJhc3BiZXJyeSBQaSkgYWNyb3NzIHRoZSBtZXNoLiBUaGUgbWVzaCB3aWxsIGNvbnNpc3Qgb2Yg
fjVrIG5vZGVzLiBJIHdhbnQgdG8gZXh0cmFjdCB0aGUgZGF0YSBhbmQgdGhlIHJzc2kgdmFsdWUg
ZnJvbSB0aGUgdHJhbnNtaXR0ZWQgcGFja2V0IG9uIHRoZSBSYXNwYmVycnkgUGkuIEhvdyB3b3Vs
ZCBJIGdvIGFib3V0IHdpdGggdGhpcz8NCg0KU2luY2UgdGhpcyBpcyBhIEJsdWVaIHF1ZXN0aW9u
IGl04oCZZCBiZSBiZXR0ZXIgYXNrZWQgb24gdGhlIEJsdWVaIG1haWxpbmcgbGlzdHMuIEnigJl2
ZSBhZGRlZCBpdCB0byBDQy4gRS5nLiBCcmlhbiBvciBJbmdhICh3aG8ga25vdyB0aGUgQmx1ZVog
bWVzaCBpbXBsZW1lbnRhdGlvbiB2ZXJ5IHdlbGwpIG1pZ2h0IGJlIGFibGUgdG8gYW5zd2VyIHlv
dXIgcXVlc3Rpb24uIEnigJltIG5vdCBzdXJlIGlmIG1lc2hjdGwgdHJhY2tzIHRoZSBSU1NJIGlu
dGVybmFsbHksIGJ1dCB0byBteSB1bmRlcnN0YW5kaW5nIHRoZSBuZXcgbWVzaCBkZWFtb24gZG9l
cywgc28gaXQgbWlnaHQgYmUganVzdCBhIG1hdHRlciBvZiBlbnN1cmluZyB0aGF0IGl0IGdldHMg
ZXhwb3NlZCB0aHJvdWdoIEQtQnVzIHNvbWVob3cuDQoNCldoYXTigJlzIG5vdCBjbGVhciB0byBt
ZSBpcyBkbyB5b3Ugd2FudCB0aGlzIGZvciB0ZXN0aW5nL2RlYnVnZ2luZyBwdXJwb3NlcyBvciBz
b21ldGhpbmcgZm9yIGFuIGFjdHVhbCBhcHBsaWNhdGlvbiB1c2U/IElmIGl04oCZcyBqdXN0IGZv
ciB0ZXN0aW5nL2RlYnVnZ2luZyB5b3UgY2FuIGUuZy4gdXNlIGJ0bW9uIHRvIHNlZSB0aGUgcmF3
IEhDSSB0cmFmZmljLCBhbmQgdGhhdOKAmWxsIHRoZW4gYWxzbyBzaG93IHlvdSB0aGUgUlNTSSBv
ZiBldmVyeSByZWNlaXZlZCBhZHZlcnRpc2luZyBwYWNrZXQuDQoNCkpvaGFuDQoNCg==
