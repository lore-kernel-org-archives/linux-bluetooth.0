Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 796D3C33C9E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 10:43:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5278C2467E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 10:43:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgA1Kn2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 05:43:28 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:39529 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgA1Kn1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 05:43:27 -0500
Received: from Exchange.peiker-cee.de ([82.119.189.133]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MSLEm-1j7VDB2pdw-00ShbK for <linux-bluetooth@vger.kernel.org>; Tue, 28
 Jan 2020 11:43:25 +0100
Received: from Exchange.peiker-cee.de (10.0.2.22) by Exchange.peiker-cee.de
 (10.0.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1591.10; Tue, 28
 Jan 2020 11:43:19 +0100
Received: from Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17]) by
 Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17%13]) with mapi id
 15.01.1591.012; Tue, 28 Jan 2020 11:43:19 +0100
From:   Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: ATT_Signed_Write_Command is not implemented in BlueZ 5.50
Thread-Topic: ATT_Signed_Write_Command is not implemented in BlueZ 5.50
Thread-Index: AQHV1cfBtrohoDasW027sFuW0mY2LQ==
Date:   Tue, 28 Jan 2020 10:43:19 +0000
Message-ID: <147ea403abb0a9cced62f32e3a39d951f417656c.camel@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.207]
Content-Type: text/plain; charset="utf-8"
Content-ID: <03432C7582D5524290F2D48FF41DD36D@peiker-cee.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Provags-ID: V03:K1:4fsOzpwzH/xt1vKOZoegdMypSKH7RIpkotud/8pgnZs0xICOD12
 ZxfjO8CnvnxEmWtPfGWhhv39RBTVE97kdrpMnrQKuksMgaMhA9oahMzwHyQ9+BmlmbUWZvY
 7S2Bec2RNAFj/8zhX9klUHqfXFugZ+wdK/Ma0gxY89BQmB17DdmwdHoP/1zzp6sFdJin1aC
 0D09IjEFHDM2PxfRsToWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UHJBL9SGAzo=:p+IBewn6pOj+PFCqnHZhrV
 blMGGh4PnKyvcLwp4dBoFqV94bqoL47PmR08x0LnEqj+f7jhMiQPoSO/jwjl8BMkKllKmJs6W
 cc7F1W5oKzLlFeLIzFmSG2TWtwTaPKl2+WBkvXA/zdoVT1wMIBv4B56Xsibe9Kun33AiI4f34
 2dbpPGHcrMYWvsyd3f691HM8VwJMNo/JjlOf2BdnZ2BzwGIoqKpvFmQqs5FRv9gFRLXk6GD5u
 NjFd/0J7TZu7YK/Lq59LhipIcS1ulpHpjZKjxN2ueQaVb7aTCs8A/CbIGfrITv/A3epeP8IAq
 lYyVzD70B9/NOvSxzfX7pzN6tH6XgZ2Qgm3vh6xKEpEEh1UNqgMw0/2Nkl5XDKTE1HvUkBkpB
 2bhUpe1cg8h5OwtIiH2Wx5R1iFC5jTjm+PQUhIbN4TNtzF4H4mjSp3G20GYkqGOqWwFpAIwuJ
 Cxcf79NQ+vd6qloRPisQw7EEjcoyaQ5/oV0g21OgGSRN51XVMRzvU6Rp5v7VnWwn0xxClLMAs
 o3t+EGcu0h055Liysa6nLNEJ2TSuYt3jaux73AKrXeb/FU1fJkY+X/tpB2g1jm1M/plfcwtWe
 8krR4bqXLbEpDLyZyCw2KFH0rHJ5jLfv78LKb4ot63WfPBAAWEh+d/+QXMT+N9ml5vVK4aRD9
 F8K26231xUOBvO17cG7pfE9o8KVF+bd2mO/QJfUCirym6b5XqsV6up9jC5GE/oh+orlVGHUZX
 k+xhSzIsqEqslpsZkNsJ7rWrkZcVAgKgS7xvNDO2RX7gJDcvqymtm9C/IFvp8/X260woznFF6
 dFwy5JqGp5EYyeaqbwNm8SmqGeS94ujlsn0Xz8n0jGc6v/Zxtz7Hs0o3w6r0+skMwyP7dIZj0
 f/C7Z3YN/CH2zklecQjQ==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCkR1cmluZyBCbHVldG9vdGggUXVhbGlmaWNhdGlvbiB0ZXN0cyB3aXRoIFBUUyBJIGZv
dW5kIG91dA0KdGhhdCBBdHRyaWJ1dGUgU2lnbmVkIFdyaXRlIENvbW1hbmQgaXMgbm90IGltcGxl
bWVudGVkIGluICdibHVldG9vdGhkJy4NCkhlbmNlIHRoZSByZWxhdGVkIHRlc3RzIGxpa2UgR0FU
VC9TUi9HQVcvQlYtMDItQyB3b3VsZCBhbHdheXMgZmFpbC4gVGhlDQpmb2xsb3dpbmcgcGF0Y2gg
aW5jbHVkZWQgaW1wbGVtZW50YXRpb24gb2YgQVRUX1NpZ25lZF9Xcml0ZV9Db21tYW5kIGFuZA0K
YSBidWcgZml4IGluICdhdHQuYycsIHdoZXJlIHJldmVyc2VkIGxvZ2ljIGluICdpZicgc3RhdGVt
ZW50IHByZXZlbnRlZA0Kc2lnbmF0dXJlIHZlcmlmaWNhdGlvbiB3aGVuIGNyeXB0b2dyYXBoaWMg
ZnVuY3Rpb24gZXhpc3RzLg0KDQoNCi0tLSBhL3NyYy9zaGFyZWQvYXR0LmMJMjAxOC0wNi0wMSAx
MDozNzozNi4wMDAwMDAwMDAgKzAyMDANCisrKyBiL3NyYy9zaGFyZWQvYXR0LmMJMjAyMC0wMS0y
MyAxMTowNzowMy4wMDAwMDAwMDAgKzAxMDANCkBAIC04MTYsNyArODE2LDcgQEANCiAJY29uc3Qg
c3RydWN0IHF1ZXVlX2VudHJ5ICplbnRyeTsNCiAJYm9vbCBmb3VuZDsNCiANCi0JaWYgKChvcGNv
ZGUgJiBBVFRfT1BfU0lHTkVEX01BU0spICYmICFhdHQtPmNyeXB0bykgew0KKwlpZiAoKG9wY29k
ZSAmIEFUVF9PUF9TSUdORURfTUFTSykgJiYgYXR0LT5jcnlwdG8pIHsNCiAJCWlmICghaGFuZGxl
X3NpZ25lZChhdHQsIG9wY29kZSwgcGR1LCBwZHVfbGVuKSkNCiAJCQlyZXR1cm47DQogCQlwZHVf
bGVuIC09IEJUX0FUVF9TSUdOQVRVUkVfTEVOOw0KLS0tIGEvc3JjL3NoYXJlZC9nYXR0LXNlcnZl
ci5jCTIwMTgtMDYtMDEgMTA6Mzc6MzYuMDAwMDAwMDAwICswMjAwDQorKysgYi9zcmMvc2hhcmVk
L2dhdHQtc2VydmVyLmMJMjAyMC0wMS0yNCAxMTozMDo1MS4wMDAwMDAwMDAgKzAxMDANCkBAIC05
Nyw2ICs5Nyw3IEBADQogCXVuc2lnbmVkIGludCBmaW5kX2J5X3R5cGVfdmFsdWVfaWQ7DQogCXVu
c2lnbmVkIGludCB3cml0ZV9pZDsNCiAJdW5zaWduZWQgaW50IHdyaXRlX2NtZF9pZDsNCisJdW5z
aWduZWQgaW50IHNpZ25lZF93cml0ZV9jbWRfaWQ7DQogCXVuc2lnbmVkIGludCByZWFkX2lkOw0K
IAl1bnNpZ25lZCBpbnQgcmVhZF9ibG9iX2lkOw0KIAl1bnNpZ25lZCBpbnQgcmVhZF9tdWx0aXBs
ZV9pZDsNCkBAIC0xMjgsNiArMTI5LDcgQEANCiAJYnRfYXR0X3VucmVnaXN0ZXIoc2VydmVyLT5h
dHQsIHNlcnZlci0+ZmluZF9ieV90eXBlX3ZhbHVlX2lkKTsNCiAJYnRfYXR0X3VucmVnaXN0ZXIo
c2VydmVyLT5hdHQsIHNlcnZlci0+d3JpdGVfaWQpOw0KIAlidF9hdHRfdW5yZWdpc3RlcihzZXJ2
ZXItPmF0dCwgc2VydmVyLT53cml0ZV9jbWRfaWQpOw0KKwlidF9hdHRfdW5yZWdpc3RlcihzZXJ2
ZXItPmF0dCwgc2VydmVyLT5zaWduZWRfd3JpdGVfY21kX2lkKTsNCiAJYnRfYXR0X3VucmVnaXN0
ZXIoc2VydmVyLT5hdHQsIHNlcnZlci0+cmVhZF9pZCk7DQogCWJ0X2F0dF91bnJlZ2lzdGVyKHNl
cnZlci0+YXR0LCBzZXJ2ZXItPnJlYWRfYmxvYl9pZCk7DQogCWJ0X2F0dF91bnJlZ2lzdGVyKHNl
cnZlci0+YXR0LCBzZXJ2ZXItPnJlYWRfbXVsdGlwbGVfaWQpOw0KQEAgLTc2OSw3ICs3NzEsNyBA
QA0KIAlzdHJ1Y3QgYnRfZ2F0dF9zZXJ2ZXIgKnNlcnZlciA9IG9wLT5zZXJ2ZXI7DQogCXVpbnQx
Nl90IGhhbmRsZTsNCiANCi0JaWYgKCFzZXJ2ZXIgfHwgb3AtPm9wY29kZSA9PSBCVF9BVFRfT1Bf
V1JJVEVfQ01EKSB7DQorCWlmICghc2VydmVyIHx8IG9wLT5vcGNvZGUgPT0gQlRfQVRUX09QX1dS
SVRFX0NNRCB8fCBvcC0+b3Bjb2RlDQo9PSBCVF9BVFRfT1BfU0lHTkVEX1dSSVRFX0NNRCkgew0K
IAkJYXN5bmNfd3JpdGVfb3BfZGVzdHJveShvcCk7DQogCQlyZXR1cm47DQogCX0NCkBAIC04Mzcs
NyArODM5LDcgQEANCiAJZWNvZGUgPSBCVF9BVFRfRVJST1JfVU5MSUtFTFk7DQogDQogZXJyb3I6
DQotCWlmIChvcGNvZGUgPT0gQlRfQVRUX09QX1dSSVRFX0NNRCkNCisJaWYgKG9wY29kZSA9PSBC
VF9BVFRfT1BfV1JJVEVfQ01EIHx8IG9wY29kZSA9PQ0KQlRfQVRUX09QX1NJR05FRF9XUklURV9D
TUQpDQogCQlyZXR1cm47DQogDQogCWJ0X2F0dF9zZW5kX2Vycm9yX3JzcChzZXJ2ZXItPmF0dCwg
b3Bjb2RlLCBoYW5kbGUsIGVjb2RlKTsNCkBAIC0xNTE0LDYgKzE1MTYsMTMgQEANCiAJaWYgKCFz
ZXJ2ZXItPndyaXRlX2NtZF9pZCkNCiAJCXJldHVybiBmYWxzZTsNCiANCisJLyogU2lnbmVkIFdy
aXRlIENvbW1hbmQgKi8NCisJc2VydmVyLT5zaWduZWRfd3JpdGVfY21kX2lkID0gYnRfYXR0X3Jl
Z2lzdGVyKHNlcnZlci0+YXR0LA0KQlRfQVRUX09QX1NJR05FRF9XUklURV9DTUQsDQorCQkJCQkJ
CQl3cml0ZV9jDQpiLA0KKwkJCQkJCQkJc2VydmVyLA0KTlVMTCk7DQorCWlmICghc2VydmVyLT5z
aWduZWRfd3JpdGVfY21kX2lkKQ0KKwkJcmV0dXJuIGZhbHNlOw0KKw0KIAkvKiBSZWFkIFJlcXVl
c3QgKi8NCiAJc2VydmVyLT5yZWFkX2lkID0gYnRfYXR0X3JlZ2lzdGVyKHNlcnZlci0+YXR0LA0K
QlRfQVRUX09QX1JFQURfUkVRLA0KIAkJCQkJCQkJcmVhZF9jYg0KLA0KDQoNCkJlc3QgcmVnYXJk
cw0KS29uc3RhbnRpbg0KDQo=
