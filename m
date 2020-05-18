Return-Path: <SRS0=JSwD=7A=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C988C433DF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 17:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A01207ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 18 May 2020 17:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="gM/Yrnmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgERRBV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 18 May 2020 13:01:21 -0400
Received: from mga11.intel.com ([192.55.52.93]:60651 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERRBV (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 18 May 2020 13:01:21 -0400
IronPort-SDR: FWFpfb/Gs3INPk/3C/i6Z7Z7Agk+Nqu+tH1AqwluyXwqk+nK65F71D3uyiUW2+MP29g5/5VlfJ
 YIdMivlx+Y5g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 10:01:19 -0700
IronPort-SDR: P3m4bpqM5LSD94l1f7MCP+geR3u7SPgC2bbbHI1waanO1r3XMDJNLTRM1w/IXlqo4a0v5VrGUq
 8149rJSrVSeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="299284660"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
  by fmsmga002.fm.intel.com with ESMTP; 18 May 2020 10:01:19 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 18 May 2020 10:01:19 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 18 May 2020 10:01:19 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 18 May 2020 10:01:19 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 18 May 2020 10:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mAjSJnIyFHgN9LLxcsa6Vj1R4WS7XYimEI0+9tz30KT+SX92SZNLvsJu7Ydj8L7u9ErHXbf5oL+BUgpE4F/JU3eMIj8thj00pB1sagWd5VyifbFWlTIZ2puRv2HjWzgUOvB06GT28yBU8aWUDcG5FEM3RpeObHNOHsx/rSweCGNzZkTkZd/WP9cQQPM0MeV04R0D1n6cFiY8SUlm2506FyVik+7TZh41cC8rjGu0zhusQ+ZvySaEDkXBI7+NfKndJYfxh5+q6KgVWx1tDX/HsomJ26TiGQfcZDIsJQbi6dpDmVflhwJIFpDepKuaSsOZK3BY6hWbBQ/Aa8Qx6c1l3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfZNFyqQI3TC/iNTg8ScVeSLwPKenhTmmIuX2YjL71c=;
 b=l1zzcND8VMUXI9p0rg8mKrdmcxay28wGycvOD3jYIeX9oqvKL3eyYXTXtwrXpDoTXCMKMHPZ6BVFOmTs0Xl28jDjvRrfrd1XFNH1C14qsE3rPWJZXwjnCBmujm+LgHUyLwWZxMOVpKa46VWM2RT85qjxUvIcmXSVTaJsVh2wGP2gV1rNTnJjWIgbJSs7mU6lCw9AmFIN/Tx5XIO6RXneUhaZfEwtbfHzDjvlc6TqSy60WN2+8qPVeo0J1uD1lDDi+pw502nhKK9fv7lmi0aNGnVSSAeTbu5p4XUzSdT3N4GfoyqKxLkY3e547pXlRbcct7RVdr2bazov2nauen/wYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfZNFyqQI3TC/iNTg8ScVeSLwPKenhTmmIuX2YjL71c=;
 b=gM/Yrnmy/neBdr3waH8O7k7EpyLHzD2F/wuEhSXlxtRcqK1l2PihEcMAkSMltYEOj/9zoQ4lF1WyComm+UpTvugpLNa+HSQMnc7Wjwey/cfs7UlIE8b0hfxskuE5ejUCW3DWLdumTvxMBS96RqHqXvDBAMQZNU1AsuRdhFSQRhk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4713.namprd11.prod.outlook.com (2603:10b6:303:2f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Mon, 18 May
 2020 17:01:11 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3000.034; Mon, 18 May 2020
 17:01:11 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "eu@felipetonello.com" <eu@felipetonello.com>,
        "marcel@holtmann.org" <marcel@holtmann.org>
Subject: [RFC]  Persistent but intermitant unit/test-midi failure
Thread-Topic: [RFC]  Persistent but intermitant unit/test-midi failure
Thread-Index: AQHWLTXud0f5NLAvgkOQgduy6wtGhQ==
Date:   Mon, 18 May 2020 17:01:11 +0000
Message-ID: <e8b0e1ed518d5b5875c66aa5af9e7e60019a9890.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 63fbaa78-ee14-4959-2412-08d7fb4d1154
x-ms-traffictypediagnostic: MW3PR11MB4713:
x-microsoft-antispam-prvs: <MW3PR11MB47139037DADBAC6ABA2F4241E1B80@MW3PR11MB4713.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:381;
x-forefront-prvs: 04073E895A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fCBYdWc3H6Q4v6cvxVnv3fAqwk1PiPU+Bv7iWVKcFPtzfRPHC7t1cQWOrrp4WIN9WbPTB+lAiAAC60g9pkU3Pvi1P/2IOBOQr8IvbEU+4TzLDo1cP+tPcaUjMOa114iM5w66kVBVQ/CRQoJ5nRyET9jv5BYrI2KJCcB7e3rz5WiKaSQgH3pPcwbK0cl11M5o4R0guCzWDScXjO3GRHAOa5HwVwqDYp/Wi9Wnm6r3V2/AsjUCTEmb71GrLPaDiH1LludJOP8IrH9bP/R7m8BOyN17RvXvOtXK0hK1vweTs4AXtEmrxfYKiGNhqI7uyyEFaJ1DWNpbX5s36umk0FO/iCeiI1pfoAc1wW6RM9HFftFtj1rMqE2dLaPqx+r0hUS1YM9KUGGFQ7F/ZOt9IwgqOo2EoTEE5/ZVlS8sur5lYvFA2aK6CkOFOBlLnQbh4s8f
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(4326008)(316002)(26005)(186003)(2616005)(71200400001)(6506007)(66446008)(64756008)(66476007)(66556008)(66946007)(76116006)(2906002)(86362001)(8936002)(6916009)(8676002)(6486002)(54906003)(6512007)(36756003)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: vH8nBG9B7I1r+GIm9BORj+gc/h/j4AF3UmOWO+5WXLuYhEyOMqyOzFGEULw/nhj945/bbePh9dDr8bsu7JrGNrIL59N4GtKAzOvHopQebNJimJnL4D6+XI1OiSiI3yTwoHPoYBu1SVJDp69XjvyNLfxZugcNGsSBQGc7r4vYNMMTatEVdRErHaoIsxBKimJZTcZynLcndH9tXycJxQpvW7eTBxjN0N9JPNHtZdEf7L8pXYUflb0RcFudbPp0JgMFINstjycAgfvGNdvJGCU2n9Xl6bKi12Kx6e/AiQbbLKrzKOzQ31z5Aw6HPsd0UN56NOKATUf8J10hBOrKUrQWB2e+KUbx6CkcFiA8LR59IhaYLP72HoxR5eyPpEa4MDrwN/1pDeEMMtSpPTLW3ELx1S/K3T+9Fts+GpK8TzqL0lvMFcTNycRkILdIma7ywn24WErcR10LzPRsDWm/szMsVtti6XZTDzbtbte0XAY1fq/EnpwD1mq01y78iqCW0I/5
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <74AD7ABC65EECC429B38494127C30927@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 63fbaa78-ee14-4959-2412-08d7fb4d1154
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2020 17:01:11.6153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gqIL1UVWGFsbIzFkX+e/8RuiEGX5GFSp2Tc6BBZx7ok1VE1BFoWd+7SBP1OrFDFXigcCB/etDcAkLsfcBoFWCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4713
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhpcyBoYXMgYm90aGVyZWQgbWUgZm9yIHNvbWUgdGltZSwgc28gSSBkaWQgc29tZSBpbnZlc3Rp
Z2F0aW9uIG9uIGl0Lg0KDQpUaGUgdW5pdCB0ZXN0IGZvciBNaWRpIGFzc2VydC1mYWlscyBwZXJo
YXBzIDEwJSAtIDIwJSBvZiB0aGUgdGltZS4gIE91dCBvZiAxMDAgb3Igc28gdGVzdCBydW5zLCBJ
IGhhdmUgaXNvbGF0ZWQNCip3aGF0KiB0aGUgZmFpbHVyZSBpcywgYnV0IGhhdmUgbm8gYW5zd2Vy
IHRvICp3aHkqIGl0IGZhaWxzLiAgSSBzdXNwZWN0ZWQgdGhhdCBpdCBteSBiZSB0aGUgcmFuZG9t
IGJ1ZmZlciBzaXplDQp2YWx1ZSBwYXNzZWQgdG8gbWlkaV93cml0ZV9pbml0KCkgaW4gdGVzdF9t
aWRpX3dyaXRlciwgYnV0IGV2ZW4gaWYgSSAiZGUgLSByYW5kb21pemUiIGl0IChwYXNzIGEgcHJp
b3IgZmFpbGluZw0Kc2VxdWVuY2Ugb2YgdmFsdWVzKSBpdCBkb2VzIG5vdCBjaGFuZ2UgdGhlIGZy
ZXF1ZW5jeSBvZiBzdWNjZXNzIG9yIGZhaWx1cmUuDQoNCkkgaGF2ZSBvbmx5IHNlZW4gdGhlIGZh
aWx1cmVzIG9jY3VyIHdpdGggMiBkaWZmZXJlbnQgYnVmZmVycywgc3BlY2lmaWNhbGx5IHRoZSBw
YWNrZXRzIA0Kc3lzZXg0XzEgKDUgb2N0ZXRzKQ0Kc3lzZXg1XzEgKDEwMjQgb2N0ZXRzKQ0KDQpU
aGUgMyBzeW1wdG9tcyB0aGF0IGFwcGVhcnMgdG8gYWx3YXlzIGJlIHRydWUgb24gdGhlIGZhaWwg
Y2FzZToNCg0KMS4gRmFpbCBhbHdheXMgb2NjdXJzIG9uIHJlY2VwdGlvbiBvZiBhIFNORF9TRVFf
RVZFTlRfU1lTRVgNCjIuIFJlY2VpdmVkIGJ1ZmZlciBpcyBhbHdheXMgZXhhY3RseSAxIG9jdGV0
IHNob3J0ZXIgdGhhbiB3aGF0IHdhcyBleHBlY3RlZA0KMy4gVGhlIGV4cGVjdGVkIGFuZCByZWNl
aXZlZCBidWZmZXJzIGFyZSBpZGVudGljYWwgZXhjZXB0IGZvciBhIG1pc3NpbmcgMHhGNw0KICAg
b2N0ZXQgYXQgdGhlIGVuZCBvZiB0aGUgcmVjZWl2ZWQgYnVmZmVyLg0KDQpUaGF0J3MgYWxsIEkg
aGF2ZSB0aW1lIGZvciwgYW5kIEkgbWlnaHQgbm90IGtub3cgZW5vdWdoIGFib3V0IE1JREkgdG8g
Y29udGludWUgZnVydGhlci4gQnV0IGl0IHdvdWxkIGJlIG5pY2UgaWYNCnRoaXMgaW50ZXJtaXRl
bnQgVW5pdCBUZXN0IEZhaWx1cmUgd2FzIGZpeGVkLg0K
