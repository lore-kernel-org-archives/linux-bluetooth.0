Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B37C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Jan 2023 21:57:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjAJV55 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Jan 2023 16:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAJV54 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Jan 2023 16:57:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070385DE73
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Jan 2023 13:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673387876; x=1704923876;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GNVCLBhehkiRya0w3wzfw68RkT4IxG/vc3xSpyrrue4=;
  b=RHDZ7zYHXJ109d7W9ZJ3px4H7cThaLGm/kzY2hxmCE51j5sb5agSqOBk
   kxQdRgASGP7N6u5PNOSPrxdzNCPWTHcmtjlOvPD8pXem5ZUl1FlDI1J3B
   Y2I6ayZTeQ4ABz8JL20LtrI5rAGsAodW8MJ9Erh2KEdJbZyyT8x4s0Ctj
   0PK5uwrb8p96tARJRQTsH5Kp85dur6ZDT8QWfHO4mQxcRBv4OZpQRp1mo
   gu/hGoFaAknoazaPnviVrIwgH2r48+0ALBBaivvwH9jadaUBMCAZRlJ99
   nl0EjIpUuAovs66aj+peK97m47KQtY/wQt0lHIiPDCbMdu/k4hFpd4s1m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="387726888"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="387726888"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 13:57:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="689558266"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="689558266"
Received: from han1-mobl4.amr.corp.intel.com (HELO [10.209.99.26]) ([10.209.99.26])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 13:57:55 -0800
Message-ID: <4e705bd4dba26a2bcb82bba12ff80238280e2b77.camel@linux.intel.com>
Subject: Re: [PATCH v1] btintel: Add recovery when secure verification of
 firmware fails
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Kiran K <kiran.k@intel.com>, linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com,
        Chethan Tumkur Narayan <chethan.tumkur.narayan@intel.com>
Date:   Tue, 10 Jan 2023 13:57:55 -0800
In-Reply-To: <20230110155905.18203-1-kiran.k@intel.com>
References: <20230110155905.18203-1-kiran.k@intel.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgS2lyYW4KCk9uIFR1ZSwgMjAyMy0wMS0xMCBhdCAyMToyOSArMDUzMCwgS2lyYW4gSyB3cm90
ZToKPiBPbiB3YXJtIHJlYm9vdCBzdHJlc3MgdGVzdCBjYXNlLCBmaXJtd2FyZSBkb3dubG9hZCBm
YWlsdXJlCj4gaGFzIGJlZW4gb2JzZXJ2ZWQgd2l0aCBmYWlsdXJlIGluIHNlY3VyZSB2ZXJpZmlj
YXRpb24gb2YgZmlybXdhcmUKPiBhbmQgQlQgYmVjb21lcyBjb21wbGV0ZWx5IGluYWNjZXNzaWJs
ZS4gVGhpcyBjYW4gaGFwcGVuIGR1ZSB0byBhIHJhY2UKPiBjb25kaXRpb24gaW4gVE9QIHJlZ2lz
dGVycyB3aGVuIFdpZmkgZHJpdmVyIGlzIGFsc28gZ2V0dGluZyBsb2FkZWQKPiBhdCB0aGUgc2Ft
ZSB0aW1lLiBUaGlzIHBhdGNoIGFkZHMgYSB3b3JrIGFyb3VuZCB0byBsb2FkIHRoZSBCVCBmaXJt
d2FyZQo+IGFnYWluIHdoZW4gc2VjdXJlIHZlcmlmeSBmYWlsdXJlIGlzIG9ic2VydmVkLgo+IAo+
IFNpZ25lZC1vZmYtYnk6IEtpcmFuIEsgPGtpcmFuLmtAaW50ZWwuY29tPgo+IFNpZ25lZC1vZmYt
Ynk6IENoZXRoYW4gVHVta3VyIE5hcmF5YW4gPGNoZXRoYW4udHVta3VyLm5hcmF5YW5AaW50ZWwu
Y29tPgo+IC0tLQo+IMKgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIHwgMjAgKysrKysrKysr
KysrKysrKy0tLS0KPiDCoGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuaCB8wqAgMSArCj4gwqAy
IGZpbGVzIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYyBiL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWwuYwo+IGluZGV4IGQ0ZTJjYjlhNGViNC4uM2YyOTc2ZmIwNTZhIDEwMDY0NAo+IC0t
LSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYwo+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWwuYwo+IEBAIC0xNzAwLDYgKzE3MDAsMTEgQEAgc3RhdGljIGludCBidGludGVsX2Rv
d25sb2FkX3dhaXQoc3RydWN0IGhjaV9kZXYgKmhkZXYsIGt0aW1lX3QgY2FsbHRpbWUsIGludCBt
c2UKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAtRVRJTUVET1VUOwo+
IMKgwqDCoMKgwqDCoMKgwqB9Cj4gwqAKPiArwqDCoMKgwqDCoMKgwqBpZiAoYnRpbnRlbF90ZXN0
X2ZsYWcoaGRldiwgSU5URUxfRklSTVdBUkVfVkVSSUZZX0ZBSUxFRCkpIHsKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgYnRfZGV2X2VycihoZGV2LCAiRmlybXdhcmUgc2VjdXJlIHZl
cmlmaWNhdGlvbiBmYWlsZWQiKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0
dXJuIC1FQUdBSU47Cj4gK8KgwqDCoMKgwqDCoMKgfQo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgaWYg
KGJ0aW50ZWxfdGVzdF9mbGFnKGhkZXYsIElOVEVMX0ZJUk1XQVJFX0ZBSUxFRCkpIHsKPiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJ0X2Rldl9lcnIoaGRldiwgIkZpcm13YXJlIGxv
YWRpbmcgZmFpbGVkIik7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4g
LUVOT0VYRUM7Cj4gQEAgLTE5NjEsNyArMTk2Niw3IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9kb3du
bG9hZF9mdyhzdHJ1Y3QgaGNpX2RldiAqaGRldiwKPiDCoMKgwqDCoMKgwqDCoMKgICogb2YgdGhp
cyBkZXZpY2UuCj4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBi
dGludGVsX2Rvd25sb2FkX3dhaXQoaGRldiwgY2FsbHRpbWUsIDUwMDApOwo+IC3CoMKgwqDCoMKg
wqDCoGlmIChlcnIgPT0gLUVUSU1FRE9VVCkKPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyID09IC1F
VElNRURPVVQgfHwgZXJyID09IC1FQUdBSU4pCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBidGludGVsX3Jlc2V0X3RvX2Jvb3Rsb2FkZXIoaGRldik7Cj4gwqAKPiDCoGRvbmU6Cj4g
QEAgLTIxNTMsNyArMjE1OCw3IEBAIHN0YXRpYyBpbnQgYnRpbnRlbF9wcmVwYXJlX2Z3X2Rvd25s
b2FkX3RsdihzdHJ1Y3QgaGNpX2RldiAqaGRldiwKPiDCoMKgwqDCoMKgwqDCoMKgICogb2YgdGhp
cyBkZXZpY2UuCj4gwqDCoMKgwqDCoMKgwqDCoCAqLwo+IMKgwqDCoMKgwqDCoMKgwqBlcnIgPSBi
dGludGVsX2Rvd25sb2FkX3dhaXQoaGRldiwgY2FsbHRpbWUsIDUwMDApOwo+IC3CoMKgwqDCoMKg
wqDCoGlmIChlcnIgPT0gLUVUSU1FRE9VVCkKPiArwqDCoMKgwqDCoMKgwqBpZiAoZXJyID09IC1F
VElNRURPVVQgfHwgZXJyID09IC1FQUdBSU4pCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBidGludGVsX3Jlc2V0X3RvX2Jvb3Rsb2FkZXIoaGRldik7Cj4gwqAKPiDCoGRvbmU6Cj4g
QEAgLTI2NDQsOCArMjY0OSwxNSBAQCB2b2lkIGJ0aW50ZWxfc2VjdXJlX3NlbmRfcmVzdWx0KHN0
cnVjdCBoY2lfZGV2ICpoZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAobGVuICE9IHNpemVvZigq
ZXZ0KSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybjsKPiDCoAo+IC3C
oMKgwqDCoMKgwqDCoGlmIChldnQtPnJlc3VsdCkKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgYnRpbnRlbF9zZXRfZmxhZyhoZGV2LCBJTlRFTF9GSVJNV0FSRV9GQUlMRUQpOwo+ICvC
oMKgwqDCoMKgwqDCoGlmIChldnQtPnJlc3VsdCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqBidF9kZXZfZXJyKGhkZXYsICJJbnRlbCBTZWN1cmUgU2VuZCBSZXN1bHRzIGV2ZW50
IHJlc3VsdDogJXUgc3RhdHVzOiAldSIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGV2dC0+cmVzdWx0LCBldnQtPnN0YXR1cyk7Cj4gKwo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoZXZ0LT5yZXN1bHQgPT0gMykKUGxlYXNl
IGF2b2lkIGFueSBtYWdpYyBudW1iZXIgaGVyZS4gWW91IGNhbiBkZWZpbmUgaXQgaW4gYnRpbnRl
bC5oLgpBcyBMdWl6IHN1Z2dlc3RlZCwgbGV0J3MgdHJ5IHRvIGFkZCB0aGUgcmVsb2FkaW5nIGNv
dW50ZXIgaW4gYnRpbnRlbF9kYXRhIHRvIGxpbWl0IHRoZSByZWxvYWRpbmcgdHJ5LgogCj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBidGludGVsX3NldF9m
bGFnKGhkZXYsIElOVEVMX0ZJUk1XQVJFX1ZFUklGWV9GQUlMRUQpOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBlbHNlCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBidGludGVsX3NldF9mbGFnKGhkZXYsIElOVEVMX0ZJUk1XQVJFX0ZBSUxF
RCk7Cj4gK8KgwqDCoMKgwqDCoMKgfQo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGlmIChidGludGVs
X3Rlc3RfYW5kX2NsZWFyX2ZsYWcoaGRldiwgSU5URUxfRE9XTkxPQURJTkcpICYmCj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBidGludGVsX3Rlc3RfZmxhZyhoZGV2LCBJTlRFTF9GSVJNV0FSRV9M
T0FERUQpKQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmggYi9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsLmgKPiBpbmRleCBlMDA2MGU1ODU3M2MuLjEwZTViZTdlNDUx
YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmgKPiArKysgYi9kcml2
ZXJzL2JsdWV0b290aC9idGludGVsLmgKPiBAQCAtMTQ3LDYgKzE0Nyw3IEBAIGVudW0gewo+IMKg
wqDCoMKgwqDCoMKgwqBJTlRFTF9CT09UTE9BREVSLAo+IMKgwqDCoMKgwqDCoMKgwqBJTlRFTF9E
T1dOTE9BRElORywKPiDCoMKgwqDCoMKgwqDCoMKgSU5URUxfRklSTVdBUkVfTE9BREVELAo+ICvC
oMKgwqDCoMKgwqDCoElOVEVMX0ZJUk1XQVJFX1ZFUklGWV9GQUlMRUQsCj4gwqDCoMKgwqDCoMKg
wqDCoElOVEVMX0ZJUk1XQVJFX0ZBSUxFRCwKPiDCoMKgwqDCoMKgwqDCoMKgSU5URUxfQk9PVElO
RywKPiDCoMKgwqDCoMKgwqDCoMKgSU5URUxfQlJPS0VOX0lOSVRJQUxfTkNNRCwKClJlZ2FyZHMs
ClRlZGQKCg==

