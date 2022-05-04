Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4012AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 May 2022 21:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234081AbiEDVly (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 May 2022 17:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230214AbiEDVly (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 May 2022 17:41:54 -0400
Received: from mslow1.mail.gandi.net (mslow1.mail.gandi.net [217.70.178.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34AF271B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 14:38:16 -0700 (PDT)
Received: from relay2-d.mail.gandi.net (unknown [IPv6:2001:4b98:dc4:8::222])
        by mslow1.mail.gandi.net (Postfix) with ESMTP id 7B6C8C04CB
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 May 2022 21:37:20 +0000 (UTC)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 3B75F40004;
        Wed,  4 May 2022 21:37:16 +0000 (UTC)
Message-ID: <6792e558daf326716ac0ac87867367cd91da3b45.camel@hadess.net>
Subject: Re: [Bluez PATCH v3 2/3] doc: add "Bonded" flag to dbus property
From:   Bastien Nocera <hadess@hadess.net>
To:     Zhengping Jiang <jiangzp@google.com>,
        linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Yun-Hao Chung <howardchung@chromium.org>
Date:   Wed, 04 May 2022 23:37:15 +0200
In-Reply-To: <20220504140940.Bluez.v3.2.I52f3efc7576fd0048437f1419dd2e1e687f7ac65@changeid>
References: <20220504210948.2968827-1-jiangzp@google.com>
         <20220504140940.Bluez.v3.2.I52f3efc7576fd0048437f1419dd2e1e687f7ac65@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.0 (3.44.0-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gV2VkLCAyMDIyLTA1LTA0IGF0IDE0OjA5IC0wNzAwLCBaaGVuZ3BpbmcgSmlhbmcgd3JvdGU6
Cj4gQm9uZGVkIGZsYWcgaXMgdXNlZCB0byBpbmRpY2F0ZSB0aGUgbGluayBrZXkgb3IgbHRrIG9m
IHRoZSByZW1vdGUKPiBkZXZpY2UgaGFzIGJlZW4gc3RvcmVkLgo+IAo+IFJldmlld2VkLWJ5OiBT
b25ueSBTYXNha2EgPHNvbm55c2FzYWthQGNocm9taXVtLm9yZz4KPiBSZXZpZXdlZC1ieTogWXVu
LUhhbyBDaHVuZyA8aG93YXJkY2h1bmdAY2hyb21pdW0ub3JnPgo+IAo+IFNpZ25lZC1vZmYtYnk6
IFpoZW5ncGluZyBKaWFuZyA8amlhbmd6cEBnb29nbGUuY29tPgo+IC0tLQo+IAo+IENoYW5nZXMg
aW4gdjM6Cj4gLSBNb3ZlIGRvY3VtZW50YXRpb24gdXBkYXRlIHRvIGEgc2VwYXJhdGUgcGF0Y2gK
PiAtIEFkZCBkZXNjcmlwdGlvbiB0byBib25kZWQgYW5kIHBhaXJlZAo+IAo+IMKgZG9jL2Rldmlj
ZS1hcGkudHh0IHwgMTIgKysrKysrKysrKystCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS1naXQgYS9kb2MvZGV2aWNlLWFwaS50
eHQgYi9kb2MvZGV2aWNlLWFwaS50eHQKPiBpbmRleCAxZTg1OTBiMjdkNTguLmM3ZTIxN2MwNzUy
NiAxMDA2NDQKPiAtLS0gYS9kb2MvZGV2aWNlLWFwaS50eHQKPiArKysgYi9kb2MvZGV2aWNlLWFw
aS50eHQKPiBAQCAtMjQ2LDcgKzI0NiwxNyBAQCBQcm9wZXJ0aWVzwqBzdHJpbmcgQWRkcmVzcyBb
cmVhZG9ubHldCj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGJvb2xlYW4g
UGFpcmVkIFtyZWFkb25seV0KPiDCoAo+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgSW5kaWNhdGVzIGlmIHRoZSByZW1vdGUgZGV2aWNlIGlzIHBhaXJlZC4K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoEluZGljYXRl
cyBpZiB0aGUgcmVtb3RlIGRldmljZSBpcyBwYWlyZWQuIFBhaXJpbmcgaXMKPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHRoZSBwcm9jZXNzIHdoZXJlIGRl
dmljZXMgZXhjaGFuZ2UgdGhlIGluZm9ybWF0aW9uIHRvCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBlc3RhYmxpc2ggYW4gZW5jcnlwdGVkIGNvbm5lY3Rp
b24uCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBib29sZWFuIEJvbmRlZCBb
cmVhZG9ubHldCj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgSW5kaWNhdGVzIGlmIHRoZSByZW1vdGUgZGV2aWNlIGlzIGJvbmRlZC4gQm9uZGVkIG1l
YW5zCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB0aGUg
bGluayBrZXkgb3IgdGhlIGx0ayBmcm9tIHRoZSBwYWlyaW5nIHByb2Nlc3MgaGFzCj4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBiZWVuIHN0b3JlZC4KCiJs
b25nLXRlcm0ga2V5IChMVEspIgoKSXMgUGFpcmVkIGVmZmVjdGl2ZWx5IHRoZSBzYW1lIGFzIEJv
bmRlZCBmb3IgQ2xhc3NpYyBkZXZpY2VzPyBJZiBzbywKd291bGQgYmUgZ3JlYXQgdG8gbWVudGlv
bi4KCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBBIFBy
b3BlcnRpZXNDaGFuZ2VkIHNpZ25hbCBpbmRpY2F0ZSBjaGFuZ2VzIHRvIHRoaXMKPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0YXR1cy4KPiDCoAo+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgYm9vbGVhbiBDb25uZWN0ZWQgW3JlYWRvbmx5
XQo+IMKgCgo=

