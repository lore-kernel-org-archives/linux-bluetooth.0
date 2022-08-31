Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8013FECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 09:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiHaJXV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 05:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbiHaJXO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 05:23:14 -0400
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D142E642E3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 02:23:12 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id D9B26240012
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 09:23:10 +0000 (UTC)
Message-ID: <6d94adc5cd4a9a1144d31f2b3ff0284155572005.camel@hadess.net>
Subject: Re: [PATCH BlueZ v4 6/6] adapter: Remove experimental flag for
 PowerState
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-bluetooth@vger.kernel.org
Date:   Wed, 31 Aug 2022 11:23:10 +0200
In-Reply-To: <20220831091912.47894-6-hadess@hadess.net>
References: <20220831091912.47894-1-hadess@hadess.net>
         <20220831091912.47894-6-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

WW91J2xsIHdhbnQgdG8gZ2l2ZSBhIG1pc3MgdG8gdGhpcyBvbmUgaW4gdGhlIGZpcnN0IHBhc3Mg
OykKCk9uIFdlZCwgMjAyMi0wOC0zMSBhdCAxMToxOSArMDIwMCwgQmFzdGllbiBOb2NlcmEgd3Jv
dGU6Cj4gTm93IHRoYXQgdGhlIGZlYXR1cmUgaGFzIGJlZW4gdGVzdGVkLCB0aGF0IHRoZSBBUEkg
aXMgZGVlbWVkIGFkZXF1YXRlCj4gYW5kIHRoZSByZWxpYWJpbGl0eSBzdWZmaWNpZW50Lgo+IC0t
LQo+IMKgc3JjL2FkYXB0ZXIuYyB8IDMgKy0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDIgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL3NyYy9hZGFwdGVyLmMgYi9z
cmMvYWRhcHRlci5jCj4gaW5kZXggMTFhMjFjYTVjLi4yYTRhMGE5NzcgMTAwNjQ0Cj4gLS0tIGEv
c3JjL2FkYXB0ZXIuYwo+ICsrKyBiL3NyYy9hZGFwdGVyLmMKPiBAQCAtMzgwOCw4ICszODA4LDcg
QEAgc3RhdGljIGNvbnN0IEdEQnVzUHJvcGVydHlUYWJsZQo+IGFkYXB0ZXJfcHJvcGVydGllc1td
ID0gewo+IMKgwqDCoMKgwqDCoMKgwqB7ICJBbGlhcyIsICJzIiwgcHJvcGVydHlfZ2V0X2FsaWFz
LCBwcm9wZXJ0eV9zZXRfYWxpYXMgfSwKPiDCoMKgwqDCoMKgwqDCoMKgeyAiQ2xhc3MiLCAidSIs
IHByb3BlcnR5X2dldF9jbGFzcyB9LAo+IMKgwqDCoMKgwqDCoMKgwqB7ICJQb3dlcmVkIiwgImIi
LCBwcm9wZXJ0eV9nZXRfcG93ZXJlZCwgcHJvcGVydHlfc2V0X3Bvd2VyZWQKPiB9LAo+IC3CoMKg
wqDCoMKgwqDCoHsgIlBvd2VyU3RhdGUiLCAicyIsIHByb3BlcnR5X2dldF9wb3dlcl9zdGF0ZSwg
TlVMTCwgTlVMTCwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIEdfREJVU19QUk9QRVJUWV9GTEFHX0VYUEVSSU1FTlRBTCB9LAo+ICvCoMKg
wqDCoMKgwqDCoHsgIlBvd2VyU3RhdGUiLCAicyIsIHByb3BlcnR5X2dldF9wb3dlcl9zdGF0ZSB9
LAo+IMKgwqDCoMKgwqDCoMKgwqB7ICJEaXNjb3ZlcmFibGUiLCAiYiIsIHByb3BlcnR5X2dldF9k
aXNjb3ZlcmFibGUsCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcm9wZXJ0eV9zZXRfZGlzY292
ZXJhYmxlIH0sCj4gwqDCoMKgwqDCoMKgwqDCoHsgIkRpc2NvdmVyYWJsZVRpbWVvdXQiLCAidSIs
Cj4gcHJvcGVydHlfZ2V0X2Rpc2NvdmVyYWJsZV90aW1lb3V0LAoK

