Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DB4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 18:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D982B60C3F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Jan 2021 18:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbhA0SvF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Jan 2021 13:51:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbhA0Su7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Jan 2021 13:50:59 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD7C061573
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 10:50:18 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id w11so1556585qvz.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Jan 2021 10:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=8jFhQiHQTa/20idqRsoppdVRNYkRBeytAJ+gngJcw3k=;
        b=i3wEWH3mbOYKJ0PO8PvBXo/zXtiBYgiag1oL+dxDd8LCrnypXDQ7dU4Rc/tjIs9CpV
         XK70q+7AsK7VqPoQtrLuv48r9nTPONIUvFpekgxDT7Oxzzdgh8oh6010rDOOcZqWDWCO
         zEqEmzN9G6YDmOYjS3qIP0lW8mM5PjxW2thheGTW/CLN9xQoLXijlfDHYis8JC1HbapP
         eaw149sq8onGTfPSGoodPSk1BymPyT7l28OVKxo57jGxDMdayTCuodjPDygq4MHhxfrc
         Ca3YXtzudC7e26H48qD5n/uaosf42U/nC0FJGsffDvKt2xP8R58cDPhy5q4+KPK5joI/
         Z2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=8jFhQiHQTa/20idqRsoppdVRNYkRBeytAJ+gngJcw3k=;
        b=agWvDJzrzcLq1NkNiagHc49QJC9UZPrsPzFwiddjKcjrTlRgLh7x2PxCDFKGAK2His
         QJOMdexd115GUCzg2gekodBMDZm/CsEF6d/oiJemc3GmSFIGttglQ+G/1pp4YfBudO6K
         qlVXVmU0+UDNhsp0qa+Nn53+oHrtHlkJUKwdy3cVjUjliBPK6vlkr8qHrA7FYu0+238F
         jWeqykNqW6c/ksdi8htJdPbKENVavSUc1yM+zG0JptRnQrJDzkAJdNBbr5kxy34erpev
         JYJVaE6GRSgzT96t2D28KV8HgMSHj5p0IcTRKNFt5B+d4vvuanyJD6YF/i3lTvyB4BZB
         nxuQ==
X-Gm-Message-State: AOAM531ipiKlwk9QQalyXrML3DK6JOoHnJEvG6GbEspgxTgNfvfbypJ7
        zy/cHfuugNCarmLcEVqm7TC9vgrqtp8bJp1L
X-Google-Smtp-Source: ABdhPJwTEqjZAiZ7lCvazciVek1UthIlbAB0e5pRUwQEgi/nQFPukg5Pb8BBF4+pMrJv0ZNonX/VwQ==
X-Received: by 2002:ad4:4cd0:: with SMTP id i16mr5072415qvz.49.1611773417636;
        Wed, 27 Jan 2021 10:50:17 -0800 (PST)
Received: from [172.17.0.2] ([20.65.34.120])
        by smtp.gmail.com with ESMTPSA id r89sm1795946qtd.25.2021.01.27.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 10:50:17 -0800 (PST)
Message-ID: <6011b5e9.1c69fb81.c6275.bea9@mx.google.com>
Date:   Wed, 27 Jan 2021 10:50:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8731102277317510006=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: Fix 32 bit Compiler Errors
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210127182328.1542194-2-brian.gix@intel.com>
References: <20210127182328.1542194-2-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8731102277317510006==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64

VGhpcyBpcyBhdXRvbWF0ZWQgZW1haWwgYW5kIHBsZWFzZSBkbyBub3QgcmVwbHkgdG8gdGhpcyBl
bWFpbCEKCkRlYXIgc3VibWl0dGVyLAoKVGhhbmsgeW91IGZvciBzdWJtaXR0aW5nIHRoZSBwYXRj
aGVzIHRvIHRoZSBsaW51eCBibHVldG9vdGggbWFpbGluZyBsaXN0LgpUaGlzIGlzIGEgQ0kgdGVz
dCByZXN1bHRzIHdpdGggeW91ciBwYXRjaCBzZXJpZXM6ClBXIExpbms6aHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wcm9qZWN0L2JsdWV0b290aC9saXN0Lz9zZXJpZXM9NDIzMTQ5CgotLS1U
ZXN0IHJlc3VsdC0tLQoKIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNr
UGF0Y2ggLSBGQUlMCk91dHB1dDoKYWR2ZXJ0aXNpbmc6IE1ha2UgZGF0YSBzaXplIGV4cGxpY2l0
IGZvciBmb3JtYXRzCldBUk5JTkc6Q09NTUlUX0xPR19MT05HX0xJTkU6IFBvc3NpYmxlIHVud3Jh
cHBlZCBjb21taXQgZGVzY3JpcHRpb24gKHByZWZlciBhIG1heGltdW0gNzUgY2hhcnMgcGVyIGxp
bmUpCiMxNjogCnVuc2lnbmVkIGludOKAmSwgYnV0IGFyZ3VtZW50IDUgaGFzIHR5cGUg4oCYdW5z
aWduZWQgaW504oCZIFstV2Vycm9yPWZvcm1hdD1dCgotIHRvdGFsOiAwIGVycm9ycywgMSB3YXJu
aW5ncywgOCBsaW5lcyBjaGVja2VkCgpOT1RFOiBGb3Igc29tZSBvZiB0aGUgcmVwb3J0ZWQgZGVm
ZWN0cywgY2hlY2twYXRjaCBtYXkgYmUgYWJsZSB0bwogICAgICBtZWNoYW5pY2FsbHkgY29udmVy
dCB0byB0aGUgdHlwaWNhbCBzdHlsZSB1c2luZyAtLWZpeCBvciAtLWZpeC1pbnBsYWNlLgoKIltQ
QVRDSF0gYWR2ZXJ0aXNpbmc6IE1ha2UgZGF0YSBzaXplIGV4cGxpY2l0IGZvciBmb3JtYXRzIiBo
YXMgc3R5bGUgcHJvYmxlbXMsIHBsZWFzZSByZXZpZXcuCgpOT1RFOiBJZ25vcmVkIG1lc3NhZ2Ug
dHlwZXM6IENPTU1JVF9NRVNTQUdFIENPTVBMRVhfTUFDUk8gQ09OU1RfU1RSVUNUIEZJTEVfUEFU
SF9DSEFOR0VTIE1JU1NJTkdfU0lHTl9PRkYgUFJFRkVSX1BBQ0tFRCBTUExJVF9TVFJJTkcgU1ND
QU5GX1RPX0tTVFJUTwoKTk9URTogSWYgYW55IG9mIHRoZSBlcnJvcnMgYXJlIGZhbHNlIHBvc2l0
aXZlcywgcGxlYXNlIHJlcG9ydAogICAgICB0aGVtIHRvIHRoZSBtYWludGFpbmVyLCBzZWUgQ0hF
Q0tQQVRDSCBpbiBNQUlOVEFJTkVSUy4KCnRvb2xzL21nbXQtdGVzdGVyOiBNYWtlIGRhdGEgc2l6
ZSBleHBsaWNpdCBmb3IgbG9nCldBUk5JTkc6Q09NTUlUX0xPR19MT05HX0xJTkU6IFBvc3NpYmxl
IHVud3JhcHBlZCBjb21taXQgZGVzY3JpcHRpb24gKHByZWZlciBhIG1heGltdW0gNzUgY2hhcnMg
cGVyIGxpbmUpCiMxNTogCuKAmGxvbmcgdW5zaWduZWQgaW504oCZLCBidXQgYXJndW1lbnQgMiBo
YXMgdHlwZSDigJh1bnNpZ25lZCBpbnTigJkgWy1XZXJyb3I9Zm9ybWF0PV0KCi0gdG90YWw6IDAg
ZXJyb3JzLCAxIHdhcm5pbmdzLCA4IGxpbmVzIGNoZWNrZWQKCk5PVEU6IEZvciBzb21lIG9mIHRo
ZSByZXBvcnRlZCBkZWZlY3RzLCBjaGVja3BhdGNoIG1heSBiZSBhYmxlIHRvCiAgICAgIG1lY2hh
bmljYWxseSBjb252ZXJ0IHRvIHRoZSB0eXBpY2FsIHN0eWxlIHVzaW5nIC0tZml4IG9yIC0tZml4
LWlucGxhY2UuCgoiW1BBVENIXSB0b29scy9tZ210LXRlc3RlcjogTWFrZSBkYXRhIHNpemUgZXhw
bGljaXQgZm9yIGxvZyIgaGFzIHN0eWxlIHByb2JsZW1zLCBwbGVhc2UgcmV2aWV3LgoKTk9URTog
SWdub3JlZCBtZXNzYWdlIHR5cGVzOiBDT01NSVRfTUVTU0FHRSBDT01QTEVYX01BQ1JPIENPTlNU
X1NUUlVDVCBGSUxFX1BBVEhfQ0hBTkdFUyBNSVNTSU5HX1NJR05fT0ZGIFBSRUZFUl9QQUNLRUQg
U1BMSVRfU1RSSU5HIFNTQ0FORl9UT19LU1RSVE8KCk5PVEU6IElmIGFueSBvZiB0aGUgZXJyb3Jz
IGFyZSBmYWxzZSBwb3NpdGl2ZXMsIHBsZWFzZSByZXBvcnQKICAgICAgdGhlbSB0byB0aGUgbWFp
bnRhaW5lciwgc2VlIENIRUNLUEFUQ0ggaW4gTUFJTlRBSU5FUlMuCgoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IENoZWNrR2l0TGludCAtIFBBU1MKCiMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjIwpUZXN0OiBDaGVja0J1aWxkIC0gUEFTUwoKIyMjIyMjIyMjIyMjIyMj
IyMjIyMjIyMjIyMjIyMjClRlc3Q6IE1ha2VDaGVjayAtIFBBU1MKCgoKLS0tClJlZ2FyZHMsCkxp
bnV4IEJsdWV0b290aAoK

--===============8731102277317510006==--
