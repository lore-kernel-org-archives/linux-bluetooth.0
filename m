Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41F23C4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  1 Nov 2022 18:57:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiKAS5N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiKAS5L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 1 Nov 2022 14:57:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648EF1C405
        for <linux-bluetooth@vger.kernel.org>; Tue,  1 Nov 2022 11:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667329031; x=1698865031;
  h=message-id:subject:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version;
  bh=/gk2sWeDQMK4W9YVdWnML0zdSPXGtDisRe0BqJhg7HE=;
  b=FMnjj9eZWicuCKD0HgGVKNNt8SsgLb1BQ+G5+oogd/cKOMZtPxEWbUcH
   NA6xKBOu9D6l7+dEyxri511qvNZv5/JhiWdLBdOqf/gerwhkT083VlLjt
   93eBQG3E6GAJCZZZp/3xmN2pC7doHNZ8gZ0RCcXj6JyyUYFdDQ4jGHNTA
   tXf4h/fLR71pTdU6Q1hB6Se8hlEuoEdbLtVDFrS6ssikwEWmTtYcrTF+F
   k3BCwihlOerkRJDFZAsMijjos+okNIlIcH5Uu1os8tAa0Y7Lptqz9o56Y
   ZmfzYqBp2P9OLBcwhFNlNNQJlDfYxoh2x1rrRpzjiT0iqYJtcrfx3izel
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="309214859"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="309214859"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:57:11 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="636499146"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="636499146"
Received: from han1-mobl4.jf.intel.com (HELO [10.24.8.139]) ([10.24.8.139])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:57:11 -0700
Message-ID: <012893abec97796db9f187a9d5c42477b5ebc54a.camel@linux.intel.com>
Subject: Re: [PATCH 1/2] Bluetooth: L2CAP: Fix accepting connection request
 for invalid SPSM
From:   Tedd Ho-Jeong An <tedd.an@linux.intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Tue, 01 Nov 2022 11:57:06 -0700
In-Reply-To: <20221031231033.2718204-1-luiz.dentz@gmail.com>
References: <20221031231033.2718204-1-luiz.dentz@gmail.com>
Organization: Intel Corporation
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwKCk9uIE1vbiwgMjAyMi0xMC0zMSBhdCAxNjoxMCAtMDcwMCwgTHVpeiBBdWd1c3Rv
IHZvbiBEZW50eiB3cm90ZToKPiBGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LnZv
bi5kZW50ekBpbnRlbC5jb20+Cj4gCj4gVGhlIEJsdWV0b290aCBzcGVjIHN0YXRlcyB0aGF0IHRo
ZSB2YWxpZCByYW5nZSBmb3IgU1BTTSBpcyBmcm9tCj4gMHgwMDAxLTB4MDBmZiBzbyBpdCBpcyBp
bnZhbGlkIHRvIGFjY2VwdCB2YWx1ZXMgb3V0c2lkZSBvZiB0aGlzIHJhbmdlOgo+IAo+IMKgIEJM
VUVUT09USCBDT1JFIFNQRUNJRklDQVRJT04gVmVyc2lvbiA1LjMgfCBWb2wgMywgUGFydCBBCj4g
wqAgcGFnZSAxMDU5Ogo+IMKgIFRhYmxlIDQuMTU6IEwyQ0FQX0xFX0NSRURJVF9CQVNFRF9DT05O
RUNUSU9OX1JFUSBTUFNNIHJhbmdlcwo+IAo+IENWRTogQ1ZFLTIwMjItNDI4OTYKPiBDQzogc3Rh
YmxlQHZnZXIua2VybmVsLm9yZwo+IFJlcG9ydGVkLWJ5OiBUYW3DoXMgS29jemthIDxwb3ByZGlA
Z29vZ2xlLmNvbT4KClJldmlld2VkLWJ5OiBUZWRkIEhvLUplb25nIEFuIDx0ZWRkLmFuQGludGVs
LmNvbT4KCj4gU2lnbmVkLW9mZi1ieTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei52b24u
ZGVudHpAaW50ZWwuY29tPgo+IC0tLQo+IMKgbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMgfCAy
NSArKysrKysrKysrKysrKysrKysrKysrKysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0
aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2wyY2FwX2NvcmUuYyBiL25l
dC9ibHVldG9vdGgvbDJjYXBfY29yZS5jCj4gaW5kZXggZWY3MjVlZDQxMzAzLi4yOTc4YTM0ZWEz
M2YgMTAwNjQ0Cj4gLS0tIGEvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMKPiArKysgYi9uZXQv
Ymx1ZXRvb3RoL2wyY2FwX2NvcmUuYwo+IEBAIC01ODEzLDYgKzU4MTMsMTkgQEAgc3RhdGljIGlu
dCBsMmNhcF9sZV9jb25uZWN0X3JlcShzdHJ1Y3QgbDJjYXBfY29ubiAqY29ubiwKPiDCoMKgwqDC
oMKgwqDCoMKgQlRfREJHKCJwc20gMHglMi4yeCBzY2lkIDB4JTQuNHggbXR1ICV1IG1wcyAldSIs
IF9fbGUxNl90b19jcHUocHNtKSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNjaWQs
IG10dSwgbXBzKTsKPiDCoAo+ICvCoMKgwqDCoMKgwqDCoC8qIEJMVUVUT09USCBDT1JFIFNQRUNJ
RklDQVRJT04gVmVyc2lvbiA1LjMgfCBWb2wgMywgUGFydCBBCj4gK8KgwqDCoMKgwqDCoMKgICog
cGFnZSAxMDU5Ogo+ICvCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDCoMKgwqDCoMKgICogVmFsaWQg
cmFuZ2U6IDB4MDAwMS0weDAwZmYKPiArwqDCoMKgwqDCoMKgwqAgKgo+ICvCoMKgwqDCoMKgwqDC
oCAqIFRhYmxlIDQuMTU6IEwyQ0FQX0xFX0NSRURJVF9CQVNFRF9DT05ORUNUSU9OX1JFUSBTUFNN
IHJhbmdlcwo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoGlmICghcHNtIHx8
IF9fbGUxNl90b19jcHUocHNtKSA+IEwyQ0FQX1BTTV9MRV9EWU5fRU5EKSB7Cj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJlc3VsdCA9IEwyQ0FQX0NSX0xFX0JBRF9QU007Cj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNoYW4gPSBOVUxMOwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBnb3RvIHJlc3BvbnNlOwo+ICvCoMKgwqDCoMKgwqDCoH0KPiArCj4g
wqDCoMKgwqDCoMKgwqDCoC8qIENoZWNrIGlmIHdlIGhhdmUgc29ja2V0IGxpc3RlbmluZyBvbiBw
c20gKi8KPiDCoMKgwqDCoMKgwqDCoMKgcGNoYW4gPSBsMmNhcF9nbG9iYWxfY2hhbl9ieV9wc20o
QlRfTElTVEVOLCBwc20sICZjb25uLT5oY29uLT5zcmMsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgJmNvbm4tPmhjb24tPmRzdCwgTEVfTElOSyk7Cj4gQEAgLTYwMDEsNiArNjAxNCwxOCBAQCBz
dGF0aWMgaW5saW5lIGludCBsMmNhcF9lY3JlZF9jb25uX3JlcShzdHJ1Y3QgbDJjYXBfY29ubiAq
Y29ubiwKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBwc23CoCA9IHJlcS0+cHNtOwo+IMKgCj4gK8Kg
wqDCoMKgwqDCoMKgLyogQkxVRVRPT1RIIENPUkUgU1BFQ0lGSUNBVElPTiBWZXJzaW9uIDUuMyB8
IFZvbCAzLCBQYXJ0IEEKPiArwqDCoMKgwqDCoMKgwqAgKiBwYWdlIDEwNTk6Cj4gK8KgwqDCoMKg
wqDCoMKgICoKPiArwqDCoMKgwqDCoMKgwqAgKiBWYWxpZCByYW5nZTogMHgwMDAxLTB4MDBmZgo+
ICvCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDCoMKgwqDCoMKgICogVGFibGUgNC4xNTogTDJDQVBf
TEVfQ1JFRElUX0JBU0VEX0NPTk5FQ1RJT05fUkVRIFNQU00gcmFuZ2VzCj4gK8KgwqDCoMKgwqDC
oMKgICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFwc20gfHwgX19sZTE2X3RvX2NwdShwc20pID4g
TDJDQVBfUFNNX0xFX0RZTl9FTkQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
cmVzdWx0ID0gTDJDQVBfQ1JfTEVfQkFEX1BTTTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZ290byByZXNwb25zZTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+IMKgwqDCoMKgwqDC
oMKgwqBCVF9EQkcoInBzbSAweCUyLjJ4IG10dSAldSBtcHMgJXUiLCBfX2xlMTZfdG9fY3B1KHBz
bSksIG10dSwgbXBzKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBtZW1zZXQoJnBkdSwgMCwgc2l6
ZW9mKHBkdSkpOwoKUmVnYXJkcywKVGVkZAo=

