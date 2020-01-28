Return-Path: <SRS0=ITs3=3R=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5025BC2D0DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 13:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A35D22522
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Jan 2020 13:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbgA1N1d (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Jan 2020 08:27:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34409 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbgA1N1d (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Jan 2020 08:27:33 -0500
Received: from Exchange.peiker-cee.de ([82.119.189.133]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N49xZ-1jesSI44av-0107LG for <linux-bluetooth@vger.kernel.org>; Tue, 28
 Jan 2020 14:27:31 +0100
Received: from Exchange.peiker-cee.de (10.0.2.22) by Exchange.peiker-cee.de
 (10.0.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.1591.10; Tue, 28
 Jan 2020 14:27:27 +0100
Received: from Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17]) by
 Exchange.peiker-cee.de ([fe80::743a:4e82:de22:ce17%13]) with mapi id
 15.01.1591.012; Tue, 28 Jan 2020 14:27:21 +0100
From:   Konstantin Forostyan <konstantin.forostyan@peiker-cee.de>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: bluetooth: If unknown option in L2CAP Configuration Request is a
 hint, Bluetooth stack responds with "Command Reject" instead of
 "Configuration Response"
Thread-Topic: bluetooth: If unknown option in L2CAP Configuration Request is a
 hint, Bluetooth stack responds with "Command Reject" instead of
 "Configuration Response"
Thread-Index: AQHV1d6ryqOWvNk7skOPLPyaAiH6AQ==
Date:   Tue, 28 Jan 2020 13:27:21 +0000
Message-ID: <3020b8d0c7d39428aec573153b3c3414213be7ce.camel@peiker-cee.de>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.17.207]
Content-Type: text/plain; charset="utf-8"
Content-ID: <223C43056D7D5747BF3F4C8D0893F07A@peiker-cee.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Provags-ID: V03:K1:1eZbgZLdIgCcie8BfFjsMI82c1q85rEpzU/4riRs06d+GhYWIUv
 /kpmem9JrtMCs2O64H7ttH7DQSAha4eyG70P1GDywC1kIRJwc59NsQO3licIAChZCwvB7qd
 oTbxsbWTAn6R84EgdfMg6of1lFBmI/Ooqsobfy6iu+0aW/ta/VICz9osR81QtlFFzBECvOF
 KTgSBQLtj2ZZZjIylzElA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wE8aDz9IOX8=:vt45Urv17YTVWopVblaMvg
 +eQ2RaERbQ3KZMoeUBpt5sjaGbFgYuqnFaoMjSyQdmoiEBCYR/MoeXD+UwWlbDDh4Jhd0jxYe
 jjxCi9HZ4B1YY3rMEWCrfXJ6rDFtLTJ7cTkL7S2ReyboBK6E3esdjbwnH5schkax50PL5tAch
 lk2l1tQMTwTj0NrdlrLqICcx+K44yrRLbx6FI8YIF05rvTkl0sFAjX/pPfAPGRTwX8LshFbET
 LnPrFvAL2sYrSKvpTlTkvbLfxsaK/jSTdmyR10aidkR9jbrp2J0c5dpqPiWWVbN42PoKEsAq0
 LYctGcvOBKIbaj9y1d5wD1KgnhXovKp6JmIB9tSXv1YPLBJ7mlX+SnEp3xzJ39b2YY3WkHKn9
 gSzy4SOwIr3Mdkbz+ULOf2hRrAy04XkCerRQs0rmI3QwA2a7L3KkgHTK0n+S/UWNgRzY2XmhU
 h6zWRmVUfDYAEoy8zPsXplNGs8XpAzrn+Ma/JzOLp89jLu+0GP1PP0j9DryQb0TUh3S4/Owqz
 9fcVW5g/4+ZkOR+Mpfy9hKbfw97O8tt0M+x+DZ4YbQvPJmXf0J3SJTP4j2tKRMjy1bigOpZV4
 riRO3PgFiPjMGBUBw06Fu/RqYjgLiNosFWKrEfFrIsO0t8gezznbfEsGKz1W9J/i+HapeLEch
 NT/U+JccWZxEVmZbIzvT2qvb24oNjDjzokFRWT67M/j636KbFn2SjWByikkI8dBCmxkxzNSIC
 eOo64nzAliVUhVjWK+cu0ljYisaGxuT+ja8ZUoXj/Chhn/jsZiuW1K2BlqEOWQWbjylqeWzwp
 yEb+nqd7qKMFUpy8UqyUFGnLwDeIPa5PM+9WWneeZv2UqYeENWlyeFnvjEkNMPqHAKQ2PtaPU
 bbIL+vVLtkBQweIW4c9g==
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGVsbG8gY29tbXVuaXR5LA0KDQpJdCBzZWVtcyB0aGF0IHRoZXJlJ3MgYSBidWcgaW4gQmx1ZXRv
b3RoIHN0YWNrIG9mIDQuMjAga2VybmVsLiBJDQpkaXNjb3ZlcmVkIGl0IGR1cmluZyBCbHVldG9v
dGggcXVhbGlmaWNhdGlvbiB0ZXN0cy4gTDJDQVAvQ09TL0NGRC9CVi0NCjEyLUMgW1Vua25vd24g
T3B0aW9uIFJlc3BvbnNlXSB0ZXN0IGZhaWxzIGJlY2F1c2UgaW5zdGVhZCBvZg0KIkNvbmZpZ3Vy
YXRpb24gUmVzcG9uc2UiIHdpdGggZXJyb3IgY29kZSAweDAwMDMgInVua25vd24gb3B0aW9uIiB0
aGUNCkJsdWV0b290aCBzdGFjayBnZW5lcmF0ZXMgIkNvbW1hbmQgUmVqZWN0Ii4NCg0KSSB0aGlu
aywgdGhpcyBoYXBwZW5zIGJlY2F1c2UgdGhlIHRlc3RlciAoQmx1ZXRvb3RoIFNJRyBQVFMpIHVz
ZXMgaGludHMNCmFzIHVua25vd24gb3B0aW9ucywgYW5kIHRoZSBCbHVldG9vdGggc3RhY2sgaGFz
IHNwZWNpYWwgaGFuZGxpbmcgZm9yDQpoaW50cy4gDQoNCkkgbWFkZSBhIHNtYWxsIHBhdGNoIGlu
IG9yZGVyIHRvIG92ZXJjb21lIHRoaXMgcHJvYmxlbS4gUGxlYXNlIGNvbmZpcm0sDQp0aGF0IHRo
ZSBwYXRjaCBpcyBmZWFzaWJsZS4gSWYgbm90LCBwbGVhc2Ugc3VnZ2VzdCBob3cgdG8gZml4IHRo
ZQ0KIkNvbW1hbmQgUmVqZWN0IiBwcm9ibGVtLg0KDQpUaGFuayB5b3UgYW5kIGJlc3QgcmVnYXJk
cywNCktvbnN0YW50aW4NCg0KLS0tIGEvbmV0L2JsdWV0b290aC9sMmNhcF9jb3JlLmMNCisrKyBi
L25ldC9ibHVldG9vdGgvbDJjYXBfY29yZS5jDQpAQCAtMzM4MSwxMSArMzM4MSwxMSBAQA0KIAkJ
CWJyZWFrOw0KIA0KIAkJZGVmYXVsdDoNCi0JCQlpZiAoaGludCkNCi0JCQkJYnJlYWs7DQotDQog
CQkJcmVzdWx0ID0gTDJDQVBfQ09ORl9VTktOT1dOOw0KLQkJCSooKHU4ICopIHB0cisrKSA9IHR5
cGU7DQorDQorCQkJaWYgKCFoaW50KQ0KKwkJCSAgICAqKCh1OCAqKSBwdHIrKykgPSB0eXBlOw0K
Kw0KIAkJCWJyZWFrOw0KIAkJfQ0KIAl9DQoNCg0K
