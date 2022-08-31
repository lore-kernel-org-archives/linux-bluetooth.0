Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AE2ECAAD4
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 11:36:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiHaLga (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiHaLg3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 07:36:29 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACF3A5C4A
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 04:36:28 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 90A11E0002
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 11:36:26 +0000 (UTC)
Message-ID: <f1b688fee24886a1279f433442c1eb30b042f7e4.camel@hadess.net>
Subject: Re: [PATCH BlueZ v4 1/6] adapter: Keep track of whether the adapter
 is rfkill'ed
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 31 Aug 2022 13:36:26 +0200
In-Reply-To: <20220831091912.47894-1-hadess@hadess.net>
References: <20220831091912.47894-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIyLTA4LTMxIGF0IDExOjE5ICswMjAwLCBCYXN0aWVuIE5vY2VyYSB3cm90ZToK
PiBAQCAtNzU0OCw2ICs3NTUzLDEyIEBAIGludCBidGRfY2FuY2VsX2F1dGhvcml6YXRpb24oZ3Vp
bnQgaWQpCj4gwqAKPiDCoGludCBidGRfYWRhcHRlcl9yZXN0b3JlX3Bvd2VyZWQoc3RydWN0IGJ0
ZF9hZGFwdGVyICphZGFwdGVyKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoGlmIChhZGFwdGVyLT5i
bG9ja2VkKSB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFkYXB0ZXItPmJsb2Nr
ZWQgPSBmYWxzZTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnX2RidXNfZW1pdF9w
cm9wZXJ0eV9jaGFuZ2VkKGRidXNfY29ubiwgYWRhcHRlci0+cGF0aCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgQURBUFRFUl9JTlRFUkZBQ0UsICJQb3dlclN0YXRlIik7CgpUaGlzIHNob3VsZCBo
YXZlIGJlZW4gaW4gdGhlIG5leHQgcGF0Y2guCgo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4gwqDC
oMKgwqDCoMKgwqDCoGlmIChidGRfYWRhcHRlcl9nZXRfcG93ZXJlZChhZGFwdGVyKSkKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IMKgCj4gQEAgLTc1NTYsNiAr
NzU2NywxNiBAQCBpbnQgYnRkX2FkYXB0ZXJfcmVzdG9yZV9wb3dlcmVkKHN0cnVjdCBidGRfYWRh
cHRlciAqYWRhcHRlcikKPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAKPiAr
aW50IGJ0ZF9hZGFwdGVyX3NldF9ibG9ja2VkKHN0cnVjdCBidGRfYWRhcHRlciAqYWRhcHRlcikK
PiArewo+ICvCoMKgwqDCoMKgwqDCoGlmICghYWRhcHRlci0+YmxvY2tlZCkgewo+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhZGFwdGVyLT5ibG9ja2VkID0gdHJ1ZTsKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBnX2RidXNfZW1pdF9wcm9wZXJ0eV9jaGFuZ2VkKGRidXNf
Y29ubiwgYWRhcHRlci0+cGF0aCwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgQURBUFRFUl9JTlRF
UkZBQ0UsICJQb3dlclN0YXRlIik7CgpEaXR0by4K

