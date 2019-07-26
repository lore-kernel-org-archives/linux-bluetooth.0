Return-Path: <SRS0=WgJd=VX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B454C76191
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 355E022CB9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Jul 2019 16:20:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728681AbfGZQUo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Jul 2019 12:20:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:35967 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728611AbfGZQUo (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Jul 2019 12:20:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jul 2019 09:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,311,1559545200"; 
   d="scan'208";a="369576060"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jul 2019 09:20:43 -0700
Received: from orsmsx155.amr.corp.intel.com (10.22.240.21) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 26 Jul 2019 09:20:43 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.29]) by
 ORSMSX155.amr.corp.intel.com ([169.254.7.34]) with mapi id 14.03.0439.000;
 Fri, 26 Jul 2019 09:20:42 -0700
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Fix storage init of Friend and LPN features
Thread-Topic: [PATCH BlueZ] mesh: Fix storage init of Friend and LPN features
Thread-Index: AQHVQxZzbGACAeFtGU+0d+cTWCv6gqbdi06A
Date:   Fri, 26 Jul 2019 16:20:42 +0000
Message-ID: <1564158041.16999.3.camel@intel.com>
References: <20190725182612.23401-1-inga.stotland@intel.com>
In-Reply-To: <20190725182612.23401-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.105.75]
Content-Type: text/plain; charset="utf-8"
Content-ID: <43F27FDC9700F040AED2B3FA6F09AEA7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMTktMDctMjUgYXQgMTE6MjYgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IFRoaXMgZml4ZXMgYSB0eXBvIGluIG1lc2gtY29uZmlnLWpzb24uYyB3aGVu
IEZyaWVuZCBmZWF0dXJlDQo+IHdhcyBpbml0aWFsaXplZCB0d2ljZSBhbmQgTFBOIHdhcyBub3Qg
aW5pdGlhbGl6ZWQgYXQgYWxsLg0KPiAtLS0NCj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwg
MiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMgYi9tZXNoL21lc2gtY29u
ZmlnLWpzb24uYw0KPiBpbmRleCA3NTAxNWU2MDcuLmUzYmFmNWRjNiAxMDA2NDQNCj4gLS0tIGEv
bWVzaC9tZXNoLWNvbmZpZy1qc29uLmMNCj4gKysrIGIvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMN
Cj4gQEAgLTExOTEsNyArMTE5MSw3IEBAIHN0YXRpYyB2b2lkIHBhcnNlX2ZlYXR1cmVzKGpzb25f
b2JqZWN0ICpqY29uZmlnLCBzdHJ1Y3QgbWVzaF9jb25maWdfbm9kZSAqbm9kZSkNCj4gIAlpZiAo
anNvbl9vYmplY3Rfb2JqZWN0X2dldF9leChqY29uZmlnLCAibG93UG93ZXIiLCAmanZhbHVlKSkg
ew0KPiAgCQltb2RlID0gZ2V0X21vZGUoanZhbHVlKTsNCj4gIAkJaWYgKG1vZGUgPD0gTUVTSF9N
T0RFX1VOU1VQUE9SVEVEKQ0KPiAtCQkJbm9kZS0+bW9kZXMuZnJpZW5kID0gbW9kZTsNCj4gKwkJ
CW5vZGUtPm1vZGVzLmxwbiA9IG1vZGU7DQo+ICAJfQ0KPiAgDQo+ICAJaWYgKGpzb25fb2JqZWN0
X29iamVjdF9nZXRfZXgoamNvbmZpZywgImJlYWNvbiIsICZqdmFsdWUpKSB7
