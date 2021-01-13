Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E980C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E69D623340
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 08:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbhAMIm5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 03:42:57 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:43306 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbhAMIm5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 03:42:57 -0500
X-Greylist: delayed 592 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 03:42:56 EST
IronPort-SDR: 8Qpk3qUg0q/n8mzpYjMCN8XisKQz2BHkrqKKZEawUpf3dehfxNUPeZPeNvy1OSJLFKI1JrYTBv
 L0yavoWICaI9N3gmGwBdk/h5wONK1OS2u2ku1uIMZ0dFkf3vutNj129dyZ8ia44wH0G+0eHCEw
 PkdJxH0G2pRr6K7VnRE7HAyfd/svJrYEbDfG0Mc6PUrUgV7aZBsFNiZXhdrjjiopCxirIdv2H0
 5YkUABtSf+GWtaZ8t0Rl5e4nrw0MbhDnNXbpA3u3LwFlnc1fLk9LfGvDv9PzldgrItEZza0E8t
 xg0=
X-IronPort-AV: E=Sophos;i="5.79,343,1602576000"; 
   d="scan'208";a="59305962"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 13 Jan 2021 00:32:09 -0800
IronPort-SDR: 3BIvytXjmdLqaRs+wNaCLSEBZ4xc9BnSSMn0Pn1HWNvzqsDQoZV+Tp9KWgv96BQMTXiYmpkqEJ
 f4qsniLmPMA4TigYMbVVKvL/2VvecyhIb+hwRZNlp3CB282OIB8PluRc7ZL+Bmk6vumXxch3rM
 dibCA1iZMXRmDFsuIKiSewr0lsbU6z0s5Yri7Pu/ZsaytbpHAjR27VDMhl1LiX48e+UQnnnyWl
 nYTWe/YyTimrAEY3qxeyAd/sIjnJvYcpLQkBJkh1eLLNYG+mg2zYtOSgjw7bcTe0zgmTYv3TnS
 piI=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Bug in net/bluetooth/a2mp.c
Thread-Topic: Bug in net/bluetooth/a2mp.c
Thread-Index: AdbpheCPg6im/tndQyClx1wW55HM3Q==
Date:   Wed, 13 Jan 2021 08:32:04 +0000
Message-ID: <77dfd0e11ade47afaafdc85d276e653b@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLCBMdWlzLA0KDQppIGp1c3QgYmFja3BvcnRlZCB5b3VyIHBhdGNoDQplZGRiNzcz
MjExOWQ1MzQwMGY0OGEwMjUzNmE4NGM1MDk2OTJmYWE4IEJsdWV0b290aDogQTJNUDogRml4IG5v
dCBpbml0aWFsaXppbmcgYWxsIG1lbWJlcnMNCmludG8gb3VyIHByb2plY3Qga2VybmVsLCBhbmQg
YSByZXZpZXdlciBoYXMgZm91bmQgYSBidWc6DQoNCkBAIC0zNzYsNiArMzgzLDggQEAgc3RhdGlj
IGludCBhMm1wX2dldGFtcGFzc29jX3JlcShzdHJ1Y3QgYW1wX21nciAqbWdyLCBzdHJ1Y3Qgc2tf
YnVmZiAqc2tiLA0KIHN0cnVjdCBhMm1wX2FtcF9hc3NvY19yc3AgcnNwOw0KIHJzcC5pZCA9IHJl
cS0+aWQ7DQoNCittZW1zZXQoJnJzcCwgMCwgc2l6ZW9mKHJzcCkpOw0KKw0KIGlmICh0bXApIHsN
CiByc3Auc3RhdHVzID0gQTJNUF9TVEFUVVNfQ09MTElTSU9OX09DQ1VSRUQ7DQogYW1wX21ncl9w
dXQodG1wKTsNCg0KDQpIZXJlLCByc3AuaWQgaXMgc2V0IHRvIHJlcS0+aWQgYnV0IHRoZW4gemVy
b2VkIHdpdGggbWVtc2V0Lg0KDQpUd28gaHVua3MgYWJvdmUgaW4gdGhlIHNhbWUgcGF0Y2ggdGhp
cyBpcyBkb25lIGluIHJldmVyc2Ugb3JkZXI6DQpAQCAtMzA1LDYgKzMwOCw4IEBAIHN0YXRpYyBp
bnQgYTJtcF9nZXRpbmZvX3JlcShzdHJ1Y3QgYW1wX21nciAqbWdyLCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLA0KIGlmICghaGRldiB8fCBoZGV2LT5kZXZfdHlwZSAhPSBIQ0lfQU1QKSB7DQogc3RydWN0
IGEybXBfaW5mb19yc3AgcnNwOw0KDQorbWVtc2V0KCZyc3AsIDAsIHNpemVvZihyc3ApKTsNCisN
CiByc3AuaWQgPSByZXEtPmlkOw0KIHJzcC5zdGF0dXMgPSBBMk1QX1NUQVRVU19JTlZBTElEX0NU
UkxfSUQ7DQoNCkkgYXNzdW1lIHRoaXMgaXMgdGhlIGNvcnJlY3Qgd2F5Lg0KQ291bGQgdGhpcyBs
ZWFkIHRvIGJsdWV0b290aCBtYWxmdW5jdGlvbmluZywgYW5kIG5lZWRzIHRvIGJlIHBhdGNoZWQ/
IFNoYWxsIGkgcHJlcGFyZSBhIHBhdGNoPw0KDQpCZXN0IHJlZ2FyZHMNCkNhcnN0ZW4NCi0tLS0t
LS0tLS0tLS0tLS0tDQpNZW50b3IgR3JhcGhpY3MgKERldXRzY2hsYW5kKSBHbWJILCBBcm51bGZz
dHJhw59lIDIwMSwgODA2MzQgTcO8bmNoZW4gLyBHZXJtYW55DQpSZWdpc3RlcmdlcmljaHQgTcO8
bmNoZW4gSFJCIDEwNjk1NSwgR2VzY2jDpGZ0c2bDvGhyZXI6IFRob21hcyBIZXVydW5nLCBBbGV4
YW5kZXIgV2FsdGVyDQo=
