Return-Path: <SRS0=1j7M=2I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D8FC43603
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 10:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F44227BF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 18 Dec 2019 10:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLRKen (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 18 Dec 2019 05:34:43 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:41955 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbfLRKen (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 18 Dec 2019 05:34:43 -0500
Received: from Exchange.peiker-cee.de ([82.119.189.133]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3sZs-1hiAaH0HEu-00zlBA for <linux-bluetooth@vger.kernel.org>; Wed, 18
 Dec 2019 11:34:41 +0100
Received: from Exchange.peiker-cee.de (10.0.2.22) by Exchange.peiker-cee.de
 (10.0.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1591.10; Wed, 18
 Dec 2019 11:34:34 +0100
Received: from Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17]) by
 Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17%13]) with mapi id
 15.01.1591.012; Wed, 18 Dec 2019 11:34:28 +0100
From:   Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: GATT server does not forward written attribute to application
Thread-Topic: GATT server does not forward written attribute to application
Thread-Index: AQHVtY65nC0fDfkvg06V6Un/LPntVg==
Date:   Wed, 18 Dec 2019 10:34:28 +0000
Message-ID: <e4a4844024f9c1fd4da044a6d837e2dba17e6ea6.camel@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.207]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A3EE61482E9FC04895461283F069B2BD@peiker-cee.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Provags-ID: V03:K1:ixgKIImb8rOuYx18yiNnDPfZT22oEBOpvQ9bZehcMX1VeWrYMyL
 G1AQVfnv3l9Jrk0JCMdhfKzCCYjPZTmJBO8MwHNX2MZLrDiipqbbEIrBvqaiCwL2x14Gth8
 Kd78Pn2SKLdiIMZ8mtMFmvwS7owELVe54nFwmeAik16DD4d6bVJVauDAVdoeIei6+INnHXM
 fI2VT2FsiDdBR2ruL/tFg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Tfv1smZ59WI=:d5xI7yLF3UrcO+MIBmoL/r
 4U0ry3BHC7tvztS8Oj+y5Q/rrCFOyQBPB5ai1MBaGkadlLsVqhaKRVVyVrGJy8lSx0zVyifLk
 TMjr9N3seTTutlTaJcqNgvn5xOr4/C/PamC8+o55C/MZFLr3DlbCA+0jnGBiXsh9Pwh1KIZBK
 txOpPCXxDUxONp8boQnTMZFmdZDcHspieoocICQoV3SOHsxcks/iJREuuR1PdO4wtsu8mj+XV
 HGxmzA9qm4ImY/ERXMj4vAqlDWdzPwUnzLlFTEJ1SwBeLvoU/gF2gk34vUqMbaAwFbSS1mbSf
 H4t6v4jK657cgtx9xJB1CupRZZqXCCXGJJ0dmwZmM2ztBD4+9NGeXXMpfa8v93hzCr0VccHf7
 rUyAw5uQegwqG4LdkkeGzOLew/aoL/a88WWOaMBB6WtZwQJUZvn0IqUEJ4fyDKnz/cclIAIIh
 J/zFtATY7/bsu8SW/daknZHacRSvlLmhXslAmhtEXdYplHBy1ah97eqjGXbUXM/C2nAoL+QFZ
 4e1g+KcES9eCwBpC7iYsSFiSMFY4DOXOe1zqhyTsVzbbQMVd9ClOV5SD6B5x21+H61SyAq6Hb
 LNKX1mLvIRfoMK/AeSk5wL04sTzp0WlTSTSIIdSaOJXxY3QJ2YT5JsRbwvxPJcuqQ6gkTSyVq
 ri3FmI8tYXWdJ7nggfr9aQm4aFfUyi0OdZnhfg8RnaEcZ9DVYiQQzcHSeVvKNKdUXy15swJvp
 LymNqUZZ0kUNTUnS3vaYIaVutcad0O/rTiCU0sbDeitKRO4cNeE2cSfhrAnjzShQC8WqzJ4Fm
 fSHYsjmIWbu+zoDjc4XV+dVkFKWA7RjoFK56t7QFG2pbpPiQmBxozsqbC7crNYtcLYgh1mKvW
 sZNHSGBW1/apwFptavSfE8J5x6wP2/tClCB1kuVdmfQHscHn33PEGIKECy4K4K
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksDQoNCkR1cmluZyBCbHVldG9vdGggUXVhbGlmaWNhdGlvbiB0ZXN0cyB3aXRoIFBUUyBJIGZv
dW5kIG91dCB0aGF0IGlmIGFuDQphdHRyaWJ1dGUgcHJvdmlkZWQgYnkgYSBHQVRUIHNlcnZlciBj
cmVhdGVkIGJ5IEJsdWVaIDUuNTAgcnVubmluZyBvbiBteQ0KSVVUIGlzIHdyaXR0ZW4gYnkgcmVt
b3RlLCB0aGUgdmFsdWUgb2YgdGhpcyBhdHRyaWJ1dGUgaXMgbm90IHByb3ZpZGVkDQpieSAnYmx1
ZXRvb3RoZCcgdG8gdGhlIHVwcGVyIGxheWVyLiBXaXRoIGEgbWlub3IgbW9kaWZpY2F0aW9uIG9m
DQonYmx1ZXRvb3RoZCcgSSBtYW5hZ2VkIHRvIGdldCB0aGUgdGVzdHMgdGhyb3VnaCwgc28gSSdk
IGxpa2UgdG8gZ2V0DQpmZWVkYmFjayBmcm9tIHRoZSBjb21tdW5pdHksIHdoZXRoZXIgdGhpcyBt
b2RpZmljYXRpb24gd2FzIG5lY2Vzc2FyeSBvcg0KbWF5IGJlIHRoZXJlJ3MgYW5vdGhlciB3YXkg
b2YgZ2V0dGluZyBhdHRyaWJ1dGUgd3JpdGUgd29ya2luZy4NCg0KRm9yIEdBVFQgdGVzdHMgSSB1
c2VkICdidGdhdHQtc2VydmVyJyBhcHBsaWNhdGlvbiBwcm92aWRlZCBieSBCbHVlWi4gSW4NCm9y
ZGVyIHRvIHRlc3Qgd3JpdGluZyBjaGFyYWN0ZXJpc3RpYyB2YWx1ZSBJIG1hZGUgIkRldmljZSBO
YW1lIg0KcHJvdmlkZWQgYnkgdGhlIGFwcGxpY2F0aW9uIHdyaXRhYmxlLiBJdCB0dXJuZWQgb3V0
LCB0aGF0IHRoZQ0KJ2dhcF9kZXZpY2VfbmFtZV93cml0ZV9jYicgZnVuY3Rpb24gdGhhdCBpcyBj
YWxsZWQgYnkgdGhlIGRhZW1vbiB1cG9uDQp3cml0aW5nICJEZXZpY2UgTmFtZSIgYWx3YXlzIHJl
Y2VpdmVzICd2YWx1ZT1OVUxMJyBhbmQgJ2xlbj0wJy4gVGhlDQpyZWFzb24gZm9yIHRoaXMgaXMg
dGhhdCBpbiB0aGUgJ2dhdHRfZGJfYXR0cmlidXRlX3dyaXRlJyBjYWxsIGluDQoncHJlcF93cml0
ZV9jYicgaW4gJ2dhdHQtc2VydmVyLmMnIGZpbGUgaW4gJ2JsdWV0b290aGQnIGJvdGggJ3ZhbHVl
Jw0KYW5kICdsZW4nIGFyZSBoYXJkLWNvZGVkIHRvIE5VTEwgYW5kIDAgcmVzcGVjdGl2ZWx5Lg0K
DQpXaXRoIHRoZSBmb2xsb3dpbmcgbW9kaWZpY2F0aW9uIGluICdnYXR0LXNlcnZlci5jJyB0aGUg
Y2FsbGJhY2sgaW4NCididGdhdHQtc2VydmVyJyBhcHBsaWNhdGlvbiByZWNlaXZlcyB0aGUgYXJn
dW1lbnRzIGl0IGV4cGVjdHMgYW5kIHRoZQ0KR0FUVCB0ZXN0cyBjYW4gYmUgcGFzc2VkOg0KDQot
LS0gYS9zcmMvc2hhcmVkL2dhdHQtc2VydmVyLmMJMjAxOC0wNi0wMSAxMDozNzozNi4wMDAwMDAw
MDAgKzAyMDANCisrKyBiL3NyYy9zaGFyZWQvZ2F0dC1zZXJ2ZXIuYwkyMDE5LTEyLTEzIDEyOjE2
OjU4LjAwMDAwMDAwMCArMDEwMA0KQEAgLTEyOTEsNyArMTI5MSw3IEBADQogCXB3Y2QtPmxlbmd0
aCA9IGxlbmd0aDsNCiAJcHdjZC0+c2VydmVyID0gc2VydmVyOw0KIA0KLQlzdGF0dXMgPSBnYXR0
X2RiX2F0dHJpYnV0ZV93cml0ZShhdHRyLCBvZmZzZXQsIE5VTEwsIDAsDQorCXN0YXR1cyA9IGdh
dHRfZGJfYXR0cmlidXRlX3dyaXRlKGF0dHIsIG9mZnNldCwgcHdjZC0+cGR1ICsgNCwNCnB3Y2Qt
Pmxlbmd0aCAtIDQsDQogCQkJCQkJQlRfQVRUX09QX1BSRVBfV1JJVEVfUkUNClEsDQogCQkJCQkJ
c2VydmVyLT5hdHQsDQogCQkJCQkJcHJlcF93cml0ZV9jb21wbGV0ZV9jYiwNCnB3Y2QpOw0KDQoN
CkJlc3QgcmVnYXJkcw0KS29uc3RhbnRpbg0KDQo=
