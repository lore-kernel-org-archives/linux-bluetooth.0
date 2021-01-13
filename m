Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E0DC433E6
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 521A12339F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Jan 2021 09:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbhAMJbC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Jan 2021 04:31:02 -0500
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:45906 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbhAMJbB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Jan 2021 04:31:01 -0500
IronPort-SDR: GHfCJqCPPXmYJRZ6xpybrqpHmYnpU6lhnsBODt98q+HQicByOXDmhkhlwKvpMfs7ees+B5bhlt
 J+nBTeUXyks5vhpJpuMzLzpTJ4fTK6WXVXMrThhyIm4qUTzO0f/68qm3pO97BT+bvrpyoyHE19
 d7x6fikd2Enkq8VaKi5V79zMDnRkOyDFrj7E8Zrb9RkSILOhmn2YwO9P4UE/R8GkrVzA6X8OH3
 yJHYzCxBvXE9RICLaWvY/chjKQjUkb55l4psA/GZiRPvuVPklE84/PuvJgRklC5ClHrjBhgTM/
 u34=
X-IronPort-AV: E=Sophos;i="5.79,344,1602576000"; 
   d="scan'208";a="59307626"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 13 Jan 2021 01:30:06 -0800
IronPort-SDR: KduV7gUb7y6R6bmfnNPaEbk5gmF5tq3zLR+O9dNBFqQ2scfxg5/7gVBUyeIj0XImFEXrktGwWO
 KOfTuWqaMQ9WQ2v0I+LDYI9Hjh1VBnaLMdTS+bLMDxf/3U6pMDBVhs4x00vwqHlZ9WYqveWJdC
 1JmRqfqWbsWGVDQOrNgFRP1R8AI98ktFrF5aphV6mjpOTDBSKE6oGzC7jc0uux6E3YRftF9tCu
 MFCDoqgHtjjVm9KSQZ/9YrckAtvguD3eN73VZD88rdejEOq2JJnaUCunXyDtIK41V4HNfWT8Pw
 vJw=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Christopher William Snowhill <chris@kode54.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: AW: Bug in net/bluetooth/a2mp.c
Thread-Topic: Bug in net/bluetooth/a2mp.c
Thread-Index: AdbpheCPg6im/tndQyClx1wW55HM3QACCwIAAAAfjvA=
Date:   Wed, 13 Jan 2021 09:30:01 +0000
Message-ID: <b9b245adf5d64866881da33b2b65ce00@SVR-IES-MBX-03.mgc.mentorg.com>
References: <77dfd0e11ade47afaafdc85d276e653b@SVR-IES-MBX-03.mgc.mentorg.com>
 <ab4d664d-5ff8-498b-89b4-35eff3b95010@www.fastmail.com>
In-Reply-To: <ab4d664d-5ff8-498b-89b4-35eff3b95010@www.fastmail.com>
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

PiBZZXMuIEkgc3VibWl0dGVkIGEgcGF0Y2ggdGhhdCBjb3JyZWN0cyB0aGlzLCBhbmQgaXQgaGFz
IGFscmVhZHkgYmVlbiBhY2NlcHRlZCBpbnRvIGJsdWV0b290aC1uZXh0LiBJdCBoYXMgbm90IG1h
ZGUgaXQgaW50byBhbnkga2VybmVscyB5ZXQuDQoNClRoYW5rcyBmb3Igbm90aWZ5aW5nIG1lLg0K
DQpCUg0KQ2Fyc3Rlbg0KLS0tLS0tLS0tLS0tLS0tLS0NCk1lbnRvciBHcmFwaGljcyAoRGV1dHNj
aGxhbmQpIEdtYkgsIEFybnVsZnN0cmHDn2UgMjAxLCA4MDYzNCBNw7xuY2hlbiAvIEdlcm1hbnkN
ClJlZ2lzdGVyZ2VyaWNodCBNw7xuY2hlbiBIUkIgMTA2OTU1LCBHZXNjaMOkZnRzZsO8aHJlcjog
VGhvbWFzIEhldXJ1bmcsIEFsZXhhbmRlciBXYWx0ZXINCg==
