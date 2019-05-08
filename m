Return-Path: <SRS0=XQ0Y=TI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7B3C04A6B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 709B021530
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 May 2019 14:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbfEHO20 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 May 2019 10:28:26 -0400
Received: from mga02.intel.com ([134.134.136.20]:18529 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726783AbfEHO2Z (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 May 2019 10:28:25 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2019 07:23:23 -0700
X-ExtLoop1: 1
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga008.jf.intel.com with ESMTP; 08 May 2019 07:23:23 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 8 May 2019 07:23:22 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.76]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.180]) with mapi id 14.03.0415.000;
 Wed, 8 May 2019 07:23:22 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "denkenz@gmail.com" <denkenz@gmail.com>
CC:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ v2] mesh: Use node uuids as storage directory names
Thread-Topic: [PATCH BlueZ v2] mesh: Use node uuids as storage directory
 names
Thread-Index: AQHVBKSLCrBBQTDcJUeXfCA/+naXTKZglnIAgAAEHgCAAIFpgIAAo0GA
Date:   Wed, 8 May 2019 14:23:22 +0000
Message-ID: <1557325399.31289.16.camel@intel.com>
References: <20190507071340.20675-1-michal.lowas-rzechonek@silvair.com>
         <1557261666.31289.11.camel@intel.com>
         <18e096c6-3b22-0096-5cb2-bef7264dbefe@gmail.com>
         <20190508043901.bcueazjay3nm6cya@kynes>
In-Reply-To: <20190508043901.bcueazjay3nm6cya@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.87.84]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BE958F324BBF5546BCE6ABE1D6945208@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQpPbiBXZWQsIDIwMTktMDUtMDggYXQgMDY6MzkgKzAyMDAsIG1pY2hhbC5s
b3dhcy1yemVjaG9uZWtAc2lsdmFpci5jb20gd3JvdGU6DQo+IEhpIERlbmlzLCBCcmlhbiwNCj4g
DQo+IE9uIDA1LzA3LCBEZW5pcyBLZW56aW9yIHdyb3RlOg0KPiA+ID4gPiArCQlpZiAoYXNwcmlu
dGYoJmNmZywgIiVzLyVzL25vZGUuanNvbiIsIGRpcl9uYW1lLA0KPiA+ID4gPiArCQkJCQkJZW50
cnktPmRfbmFtZSkgPCAwKQ0KPiA+ID4gPiArCQkJY29udGludWU7DQo+ID4gPiANCj4gPiA+IFdp
dGggRUxMLCB3ZSBkbyBub3QgdXNlIGFzcHJpbnRmLiAgRXZlcnkgZHluYW1pYyBhbGxvY2F0aW9u
IG11c3QgbWFwDQo+ID4gPiBiYWNrIHRvIGxfbWFsbG9jLCB3aGljaCBwZXJmb3JtcyBhbiBhYm9y
dCgpIGlmIGEgbWVtb3J5IGFsbG9jYXRpb24NCj4gPiA+IGZhaWxzLiAgU28gdGhpcyBzaG91bGQg
YmUgcmUtY29kZWQgYXMgYSBtYWxsb2Mgb2YgdGhlIGRlc2lyZWQgc2l6ZSwNCj4gPiA+IGFuZCB0
aGVuIHVzZSBzbnByaW50ZiwgdXNpbmcgdGhlIG1hbGxvYydkIGxlbmd0aCBhcyBOLg0KPiA+IA0K
PiA+IC4uLm9yIHVzZSBsX3N0cmR1cF9wcmludGYuICBXaGljaCBpcyBhY3R1YWxseSBhc3ByaW50
ZiB1bmRlcm5lYXRoLi4uDQo+ID4gOykNCj4gDQo+IFdpbGwgZG8sIHRoYW5rcyBmb3IgdGhlIHRp
cCENCj4gDQo+IEluY2lkZW50YWxseSwgYXJlIHlvdSBhd2FyZSB3aHkgJ21haW4nIGJsdWV6IGFp
bXMgdG8gZHJvcCBnbGliPw0KDQpFTEwgaXMgYSBzcGFjZSBlZmZpY2llbnQgbGlicmFyeSB0YWls
b3JlZCBmb3Igc2VydmljZXMgdGhhdCBjYW4gYmUgdGFyZ2V0ZWQgYXQgZW1iZWRkZWQgc3lzdGVt
cywgYW5kIHN1ZmZlcnMNCmZyb20gbGVzcyAiU2l6ZSBCbG9hdCIgdGhhbiBHTElCLiBUaGF0IGlz
IHRoZSBtYWluIHJlYXNvbiwgYW5kIGhhcyBiZWVuIGNoYW1waW9uZWQgYnkgTWFyY2VsLCB3aG8g
bWlnaHQgaGF2ZQ0KbW9yZSB0byBzYXkgYWJvdXQgaXQu
