Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8954FC38145
	for <linux-bluetooth@archiver.kernel.org>; Wed,  7 Sep 2022 10:25:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiIGKZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230382AbiIGKYx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 7 Sep 2022 06:24:53 -0400
Received: from embla.dev.snart.me (embla.dev.snart.me [13.210.127.0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A833C28
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 03:24:46 -0700 (PDT)
Received: from embla.dev.snart.me (localhost [IPv6:::1])
        by embla.dev.snart.me (Postfix) with ESMTP id 765267E742
        for <linux-bluetooth@vger.kernel.org>; Wed,  7 Sep 2022 10:24:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 embla.dev.snart.me 765267E742
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=dev.snart.me;
        s=default; t=1662546284;
        bh=QZiAk8mNdEWJIhuZDvrBppDqc3D4ay64WARRsowkC/I=;
        h=Date:From:Subject:Reply-To:References:To:In-Reply-To:From;
        b=NjqjnVLSw2+MKMVI2Ro1Bl9LwtkeX9MSEQZRnL/2QQZoDX80ReEeN8m6h3e7y8p2E
         fVMYfoEuNIWTJcoDzshSPAp7tCqdFc4OVs0UmFCY8rm5DTnwDlqSXSXW7UEDU5uPnJ
         OHsIqxFnYW7lRX7OqUvwaiIzrpfCACiw0lSLzrD+fjpb+aDvTLNAOfevxfMLb85xSC
         vCNaOXLQtgo4z76qxPbC08ZLyJWQQmkHLsGA4rQ0IL9gXy9vtqRYGcgV6p0XUJ2sVs
         /7YC6f88guWlxYTWERjsuPuI7i9z5pP2FDCVaYhqeH0FcrW4PnQqQlwfz9W4BmdvKK
         DEwuuaXnDQepmP4gRLPo9p7GSgmVMrpp2y4/M+tBdto0DN7cT3FDXGrvGNKjMCaY2G
         ZDrA0SGSba5yH0OamGD+Fg8GKJj/JVnIQVv5E6A7le9BkPmvoZE8PuwpWqNrNeyxRr
         kiTeblifMA0+Y5m7nrrT+364Lmqb0tPiAbe+/moxEZrlYeI6LG7IjdEhldgfjdCGct
         A5Jo7MdgHJrAB9odM75QtpWSqCmFifuX9NzaMY837jEF7zNLUQ3KKqzPEPXkCJVBRU
         5GfrWQ1S8fh5s6Qqq9MX9AjsdYYqzaL7kElxGx369EaOyulZv2aKcSq9uSCXuO4s4u
         a8E6cSxPt14KmF4U0WGr/tyM=
Received: from [IPV6:2001:8004:16c0:710:ce3:b706:6364:5765] ([2001:8004:16c0:710:ce3:b706:6364:5765])
        by embla.dev.snart.me with ESMTPSA
        id OKseGGxxGGPbQQAA8KYfjw
        (envelope-from <dxdt@dev.snart.me>)
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Sep 2022 10:24:44 +0000
Message-ID: <8a76a301-3c01-e8f1-802b-9154324ddb3b@dev.snart.me>
Date:   Wed, 7 Sep 2022 18:24:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
From:   David Timber <dxdt@dev.snart.me>
Subject: How to block media sink endpoint
Content-Language: en-US
Reply-To: David Timber <dxdt@dev.snart.me>
References: <e0ffe840-e4f1-502a-4b61-bbe57de5de6d@dev.snart.me>
To:     linux-bluetooth@vger.kernel.org
Autocrypt: addr=dxdt@dev.snart.me; keydata=
 xjMEYmJg1hYJKwYBBAHaRw8BAQdAf5E+ri1XLtjqYbZdHOyc8oS+1/XJ5bSlbx5WHXmVBZzN
 IERhdmlkIFRpbWJlciA8ZHhkdEBkZXYuc25hcnQubWU+wpQEExYKADwWIQQn/Jn96EMUaIoF
 X+T/ldyyrZpWaAUCYmJg1gIbAwULCQgHAgMiAgEGFQoJCAsCBBYCAwECHgcCF4AACgkQ/5Xc
 sq2aVmjJZwD8COjPlUwccrlRvbNQ6f87DWchtYO0o8W2DNRM3RLps0EA/jEhIbRV6AsyC8jr
 30Ut3aJ3/mO/6G4sLj7OvkEEBH0MzjgEYmJg1hIKKwYBBAGXVQEFAQEHQFpgtIgaByv9lIEY
 EmpavMO0pYjtu7TMJynwdnGYkN9LAwEIB8J4BBgWCgAgFiEEJ/yZ/ehDFGiKBV/k/5Xcsq2a
 VmgFAmJiYNYCGwwACgkQ/5Xcsq2aVmhFCwEA0kM9VyYB4bLCM7+SuXUUH+5Ec99Nj4RXxFad
 Key9GuwA/2BZK6bNyrLSfEk2JDRoskqf7OIL0wa6JOD5SrBnMe8E
In-Reply-To: <e0ffe840-e4f1-502a-4b61-bbe57de5de6d@dev.snart.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

DQpJJ20gdHJ5aW5nIHRvIGRpc2FibGUvYmxvY2sgbWVkaWEgZW5kcG9pbnQgc28gdGhhdCBt
eSBsYXB0b3Agd29uJ3QgYmUgDQp1c2VkIGFzIGEgbWVkaWEgc2luayBieSBBbmRyb2lkIGRl
dmljZXMuIEkgb2NjYXNpb25hbGx5IHVzZSBCbHVldG9vdGggDQpmb3IgdHJhbnNmZXJyaW5n
IHNtYWxsIGZpbGVzIGZybyBhbmQgdG8gQW5kcm9pZCBkZXZpY2VzLiBXaGVuZXZlciBhIA0K
QW5kcm9pZCBkZXZpY2UgY29ubmVjdCB0byBteSBsYXB0b3AsIGl0IGF1dG9tYXRpY2FsbHkg
ZW5hYmxlcyAiTWVkaWEgDQphdWRpbyIgYWdhaW4uIElmIHRoZSBwaG9uZSB3YXMgcGxheWlu
ZyBtdXNpYywgdGhlIGxhcHRvcCBiZWNvbWVzIHRoZSBuZXcgDQptZWRpYSBzaW5rIGFuZCB0
aGUgbGFwdG9wIHNwZWFrZXJzIHN0YXJ0IGJsYXN0aW5nIG11c2ljIDooIFdoYXQgYSANCmhv
cnJpYmxlIGlkaW90LXByb29mIGRlc2lnbi4NCg0KR29vZ2xlIGRvZXNuJ3QgZXZlciBsaXN0
ZW4gdG8gYW55b25lLCBzbyBJIGZpZ3VyZWQgaXQncyBlYXNpZXIgdG8gZmluZCBhIA0Kc29s
dXRpb24gYnkgY29uZmlndXJpbmcgbXkgTGludXggbWFjaGluZXMuDQoNCmJsdWV0b290aGQg
b3V0cHV0Og0KDQogICAgRW5kcG9pbnQgcmVnaXN0ZXJlZDogc2VuZGVyPToxLjc4IHBhdGg9
L01lZGlhRW5kcG9pbnQvQTJEUFNpbmsvYXB0eF9oZA0KICAgIEVuZHBvaW50IHJlZ2lzdGVy
ZWQ6IHNlbmRlcj06MS43OCBwYXRoPS9NZWRpYUVuZHBvaW50L0EyRFBTaW5rL2FwdHgNCiAg
ICBFbmRwb2ludCByZWdpc3RlcmVkOiBzZW5kZXI9OjEuNzggcGF0aD0vTWVkaWFFbmRwb2lu
dC9BMkRQU2luay9zYmMNCiAgICBFbmRwb2ludCByZWdpc3RlcmVkOiBzZW5kZXI9OjEuNzgg
cGF0aD0vTWVkaWFFbmRwb2ludC9BMkRQU2luay9zYmNfeHENCg0KQW5kIGJsdWV0b290aGN0
bCBzaG93czoNCg0KICAgIFVVSUQ6IEF1ZGlvIFNpbmsgKDAwMDAxMTBiLTAwMDAtMTAwMC04
MDAwLTAwODA1ZjliMzRmYikNCg0KSSBkb24ndCB0aGluayBBdWRpbyBiYWNrLWVuZHMoQUxT
QSwgUEEsIFBXKSBhcmUgbm90IGludm9sdmVkIGluIHRoaXMgDQpkZXZpY2Ugc291cmNlLWxh
cHRvcCBzaW5rIHNldCB1cC4gSG93IGRvIEkgcHJldmVudCBteSBsYXB0b3AgZnJvbSBiZWlu
ZyANCnVzZWQgYXMgYW4gQTJEUFNpbmsgZW5kcG9pbnQ/IE9yIGlmIEkgY2FuIGp1c3QgYmxh
Y2tsaXN0IGEgY2VydGFpbiANCmtlcm5lbCBtb2R1bGUsIHRoYXQnZCBiZSBqdXN0IGZpbmUu
DQoNCg==
