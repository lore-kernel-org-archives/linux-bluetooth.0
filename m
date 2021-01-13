Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1004C433DB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AE0233E2
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbhAMJY6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:24:58 -0500
Received: from esa3.mentor.iphmx.com ([68.232.137.180]:57967 "EHLO
        esa3.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbhAMJY6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:24:58 -0500
X-Greylist: delayed 591 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 04:24:57 EST
IronPort-SDR: oQx+oW3YgQ34GUkiRWB/lbjxIo/sXT4IDXADHu5MoXOmTQ4Oty5nGwtoL/GwG7gtYvlr+IDlJv
 hO14eXMICsGBwGmvO6h2iivyokdjWHmRpvXvQDfevPmeVKKiWtxIZl55CNZSGUm4VXHaHhAowR
 CkFkZ5bnUkze7g9BXNU+pCm/yb3KUCYtIuAaZkFJyJvHOvWeWoMhBpKK/wmBjuLrTGry1ObGZF
 wjoFwb5Y9UaNcky68ghBD31ZbfeK0BjLzgJa6kdOAYgKp3GhAxZXHwCc3jbPFudoE4F3OOUFqU
 XZY=
X-IronPort-AV: E=Sophos;i="5.79,343,1602576000"; 
   d="scan'208";a="57025122"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa3.mentor.iphmx.com with ESMTP; 13 Jan 2021 01:14:10 -0800
IronPort-SDR: v+yBA8g8gSN1j3hSW+HqpyVzdeOKAwBOKODYOZ07cegDo5g5yF/Tn8REgajk0wxZc96GIRUz5K
 jAUxb97Ox1zjnFxhoQlugYVN3VHa8gIIV2bexLK3xcRkr1q7Skx8Q/2vboK/SM+YY7dt2dXVz6
 WwXHLw9dv51uZCPbjFD+hBANL8p6pQXUYN46Y4z/0coQ0VQopjycz/duRUtT8mEqt2y9nR7Qfm
 lk6Ekw1188TpilbOzEOhpwzj+JPDXvTL20Tgq2vy0gEEevRsggrBfBZOovsWoyJttrRD/2/S/8
 KiA=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: [PATCH] Bluetooth: A2MP: Fix zeroing rsp ID field
Thread-Topic: [PATCH] Bluetooth: A2MP: Fix zeroing rsp ID field
Thread-Index: AdbpjDEpj2Bt5FvMTi+VqXfLqRQOOg==
Date:   Wed, 13 Jan 2021 09:14:05 +0000
Message-ID: <96880a534a9c477c87ee9f57fa6ff7fd@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLCBMdWl6LA0KDQppIGhhdmUgcHJlcGFyZWQgYSBwYXRjaCBmb3IgdGhlIGVycm9u
ZW91cyB6ZXJvaW5nIG9mIHJzcC5pZC4NClNlZSBiZWxvdy4NCg0KQmVzdCByZWdhcmRzDQpDYXJz
dGVuDQotLS0tLS0tLS0tLS0tDQpGcm9tIDQ5NTc0OGFlMzA3MmMzMjhmOTI0MzVmZDE4NGZkMjc4
Zjc2M2RlODQgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBDYXJzdGVuIFNjaG1pZCA8
Y2Fyc3Rlbl9zY2htaWRAbWVudG9yLmNvbT4NCkRhdGU6IFdlZCwgMTMgSmFuIDIwMjEgMDk6MzQ6
NTEgKzAxMDANClN1YmplY3Q6IFtQQVRDSF0gQmx1ZXRvb3RoOiBBMk1QOiBGaXggemVyb2luZyBy
c3AgSUQgZmllbGQNCg0KUGF0Y2ggIkJsdWV0b290aDogQTJNUDogRml4IG5vdCBpbml0aWFsaXpp
bmcgYWxsIG1lbWJlcnMiIGhhcyBvbmUgcGxhY2Ugd2hlcmUNCnRoZSBzdGFjayB2YXJpYWJsZSBy
c3AuaWQgaXMgemVyb2VkIHdpdGggbWVtc2V0IGFmdGVyIGluaXRpYWxpemluZyBpdC4NCg0KRml4
IHRoaXMgYnkgemVyb2luZyB0aGUgc3RhY2sgdmFyaWFibGUgYW5kIHNldHRpbmcgcnNwLmlkIGFm
dGVyLg0KDQpEZXRlY3RlZC1ieTogVG9iaWFzIEthdWZtYW5uIDx0b2JpYXMuYS5rYXVmbWFubkBi
bXcuZGU+DQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KRml4ZXM6IGVkZGI3NzMyMTE5ZCAo
IkJsdWV0b290aDogQTJNUDogRml4IG5vdCBpbml0aWFsaXppbmcgYWxsIG1lbWJlcnMiKQ0KU2ln
bmVkLW9mZi1ieTogQ2Fyc3RlbiBTY2htaWQgPGNhcnN0ZW5fc2NobWlkQG1lbnRvci5jb20+DQot
LS0NCiBuZXQvYmx1ZXRvb3RoL2EybXAuYyB8IDQgKystLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3Ro
L2EybXAuYyBiL25ldC9ibHVldG9vdGgvYTJtcC5jDQppbmRleCBkYTdmZDdjOGMyZGMuLjY0ZTcz
Nzg4M2EwZSAxMDA2NDQNCi0tLSBhL25ldC9ibHVldG9vdGgvYTJtcC5jDQorKysgYi9uZXQvYmx1
ZXRvb3RoL2EybXAuYw0KQEAgLTM4MSwxMCArMzgxLDEwIEBAIHN0YXRpYyBpbnQgYTJtcF9nZXRh
bXBhc3NvY19yZXEoc3RydWN0IGFtcF9tZ3IgKm1nciwgc3RydWN0IHNrX2J1ZmYgKnNrYiwNCiBo
ZGV2ID0gaGNpX2Rldl9nZXQocmVxLT5pZCk7DQogaWYgKCFoZGV2IHx8IGhkZXYtPmFtcF90eXBl
ID09IEFNUF9UWVBFX0JSRURSIHx8IHRtcCkgew0KIHN0cnVjdCBhMm1wX2FtcF9hc3NvY19yc3Ag
cnNwOw0KLXJzcC5pZCA9IHJlcS0+aWQ7DQotDQogbWVtc2V0KCZyc3AsIDAsIHNpemVvZihyc3Ap
KTsNCg0KK3JzcC5pZCA9IHJlcS0+aWQ7DQorDQogaWYgKHRtcCkgew0KIHJzcC5zdGF0dXMgPSBB
Mk1QX1NUQVRVU19DT0xMSVNJT05fT0NDVVJFRDsNCiBhbXBfbWdyX3B1dCh0bXApOw0KLS0NCjIu
MTcuMQ0KLS0tLS0tLS0tLS0tLS0tLS0NCk1lbnRvciBHcmFwaGljcyAoRGV1dHNjaGxhbmQpIEdt
YkgsIEFybnVsZnN0cmHDn2UgMjAxLCA4MDYzNCBNw7xuY2hlbiAvIEdlcm1hbnkNClJlZ2lzdGVy
Z2VyaWNodCBNw7xuY2hlbiBIUkIgMTA2OTU1LCBHZXNjaMOkZnRzZsO8aHJlcjogVGhvbWFzIEhl
dXJ1bmcsIEFsZXhhbmRlciBXYWx0ZXINCg==
