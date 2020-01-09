Return-Path: <SRS0=NtgA=26=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6B6C282DD
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A282075D
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Jan 2020 21:37:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="sewPyCtV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728750AbgAIVhc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Jan 2020 16:37:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:16366 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbgAIVhb (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Jan 2020 16:37:31 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 13:37:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="218474381"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jan 2020 13:37:31 -0800
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 13:37:31 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 13:37:30 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 9 Jan 2020 13:37:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhQPnLGdFrOjNSPn1rracwE2BxfjYDhAfJDVhbS4H2BW7yDJdpzxNdcbd5L/QYhHhnSpjLDsWw0o/Ri3ic6TXfHSal7tk1Y8r+fmhuRpkh9wp5LVQ2MObGHmadMyEpMEvQq736blspTmMH6uHYn/c60YRW4KZsQl7yaMrFreDRUwDLb116RKixhLz92R/QERlTgHlHtI0mTBzB1VHorw3yBtC1NQOLQrwSJUX8LJHkmXFFraS7Hzrz5oMR6T9LI3eTfYXkBqKRohYb2LLn5CsIK6r5gQDAhkoCgNSspCE5KKDkbZ7sEqVehr5Guq5wgLu4Q0rjJVOq6oMebR5HPrWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXebKQybkpFxCR9dNTNp9XqJ8Dwb4UgTufbgRqnJItw=;
 b=JI0A5eVHI8CAWu3+Pm8wXSxFvDPWYUb43iL/SoBTDbExb33DTgRhCkdP0DGaCd8OweBiVcruG6cLvQrd8cQv9gN07+8UTFTrGj7DwtU5cDpra8LKfIGk4KjgT3VOGUdemRt/8RMXCacX6xETyYFrPn9SvAF+e3cMCy29xjOmKbKPq7VODVvVZSQ+DCPIlEchD1mm0XTceHFXsyWk8tpjwHj+CrshbWKGEYJkazUVTLF1nk38K9M6CwreQET5Yt0ztLrkttH3rFWhdj92A8ZoLGtDXdh4fCZCXmT9AtDUEEGie1kxw2lBkYKVOQ/NeNS9mkwHeeRHjDruwwh5d8hHIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zXebKQybkpFxCR9dNTNp9XqJ8Dwb4UgTufbgRqnJItw=;
 b=sewPyCtVVv4RgoGHbPZKUOosSlXPG4OqDLJ4r0r7jupo14jeveUjMmtF14NctGO3TAjHYsPz+wpSVkGOcDZs297azaXNCzGLodWE28eQNpuZle92OwUglq3ZufmHYE0GIuilL3U4PUsY9d+b5pCQRfUIA4wY4T+onn/IKzRT4A8=
Received: from SN6PR11MB3520.namprd11.prod.outlook.com (52.135.124.204) by
 SN6PR11MB2832.namprd11.prod.outlook.com (52.135.93.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.10; Thu, 9 Jan 2020 21:37:28 +0000
Received: from SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45]) by SN6PR11MB3520.namprd11.prod.outlook.com
 ([fe80::ede7:c158:93c:ca45%7]) with mapi id 15.20.2623.010; Thu, 9 Jan 2020
 21:37:28 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>
CC:     "Gix, Brian" <brian.gix@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Correctly generate NetKey list
Thread-Topic: [PATCH BlueZ] mesh: Correctly generate NetKey list
Thread-Index: AQHVxxZodwkQV3uMbEymAVqZHxHaiqfi0V0AgAAFzQCAAAJwgIAAAjKA
Date:   Thu, 9 Jan 2020 21:37:28 +0000
Message-ID: <7347c54a1ffa3cf45195b0d8ca53d59613f946b8.camel@intel.com>
References: <20200109175715.22925-1-inga.stotland@intel.com>
         <20200109210006.e3qv6uxnr2w3isc5@kynes>
         <31a576190ecbd1ba3f7e779d746baf35815fbed9.camel@intel.com>
         <20200109212935.6dn5ivmnupfd5f2d@kynes>
In-Reply-To: <20200109212935.6dn5ivmnupfd5f2d@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=inga.stotland@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da30fb77-16d4-4478-8d23-08d7954c200b
x-ms-traffictypediagnostic: SN6PR11MB2832:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR11MB2832A696911FA91B2A1F6F37FB390@SN6PR11MB2832.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02778BF158
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(199004)(189003)(91956017)(71200400001)(186003)(26005)(86362001)(36756003)(6916009)(8936002)(6486002)(8676002)(81156014)(2616005)(81166006)(498600001)(6506007)(2906002)(4326008)(54906003)(66476007)(66946007)(76116006)(66446008)(5660300002)(64756008)(66556008)(6512007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR11MB2832;H:SN6PR11MB3520.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FXr3wclMfuC5pFloa25gFV6A+t0j7LetFhC28FZu8li0tuk0+6nEu0rjNKRTEQ4kAplC6AHfjgh70ZBG6QUgGUizgXp54FZ8NMy8oejCIWubThF6qBOFkWZcIe/nEr3enegsD1kyrlz/TrbamUAn4BVldjsCUnLm6/8/9bQkduyw8SwemNqk4vvGRXJruBOwVx8+xgzdj4qcXGUZtmQvwoYJp/bPXrrMwu3vh8N/djUXIGstcmrKOzXYuHRjwLZge7QZd6E8OF5LqETFsSHGJxzv9zrNKlf0pEtlTvGNLfUCfe7Pw5nqTIqbBIsXZSb37ZTbS1VHUeSff5sv9WgFrhu/C8YWBp9ZUZ96re6+grJkWQbSOtBcI90IsfQAmdAASSZ905CP4ftPMPHHxh2LtsZBV+S5yqe01kVgXXHAZZt1cWT/95xLBabmV0ObTFkv
Content-Type: text/plain; charset="utf-8"
Content-ID: <9826B96CA40989418C025A928F415352@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: da30fb77-16d4-4478-8d23-08d7954c200b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2020 21:37:28.2976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpvdeCdeQz024joXmeOjgLUVXzosExPvH9ajhadAOaS5LcEVMKImrDCe91QekJyFQF3FXuaPcwluBJ7rir9bFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2832
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTA5IGF0IDIyOjI5ICswMTAwLCBtaWNoYWwubG93YXMtcnplY2hvbmVr
QHNpbHZhaXIuY29tDQp3cm90ZToNCj4gT24gMDEvMDksIFN0b3RsYW5kLCBJbmdhIHdyb3RlOg0K
PiA+ID4gUGxlYXNlIGRvbid0IHVzZSBiaXQgc2hpZnRzIGZvciBkaXZpc2lvbi4NCj4gPiBXaHk/
DQo+IA0KPiBCZWNhdXNlIGl0J3MgYSBkaWZmZXJlbnQgb3BlcmF0aW9uLCBhbmQgaXMgbGVzcyBy
ZWFkYWJsZS4gIEl0J3MgYQ0KPiBmb3JtdWxhLCBzbyB1c2UgbWF0aCBvcGVyYXRvcnMgZm9yIG51
bWJlcnMgYW5kIGJpdCBvcGVyYXRvcnMgZm9yIGJpdHMuDQo+IA0KPiBGb3IgZXhhbXBsZSwgaWR4
X3BhaXIgPDw9IDEyIGlzIGZpbmUsIGJlY2F1c2UgdGhlICpjb250ZXh0KiBpcw0KPiBiaXQtcGFj
a2luZy4gTm9vbmUgc2FuZSB3b3VsZCB3cml0ZSB0aGlzIGFzIGlkeF9wYWlyICo9IDQwOTYuIFRo
aXMNCj4gcmVhc29uaW5nIGFwcGxpZXMgdGhlIG90aGVyIHdheSBhcyB3ZWxsOiBkb24ndCB3cml0
ZSBmb28gPj4gMiB3aGVyZSB5b3UNCj4gbWVhbiBmb28gLyA0Lg0KDQpXZWxsLCBzaGlmdCBpcyBh
IGxlc3MgZXhwZW5zaXZlIG9wZXJhdGlvbiB0aGFuIGEgZGl2aXNpb24gKEkgYmVsaWV2ZSwNCnNv
bWUgY29tcGlsZXJzIG1heSBzdWJzdGl0dXRlIGludGVnZXIgZGl2aXNpb24gYnkgMiB3aXRoIGEg
c2hpZnQpLg0KDQpJIGRvbid0IHNlZSBhbnkgcmVhc29uIG5vdCB0byB1c2UgPj4gaW4gdGhpcyBw
YXJ0aWN1bGFyIGNhc2UsIGJ1dCBJIGNhbg0KY2hhbmdlIGlmIHRoaXMgaXMgbm90IHJlYWRhYmxl
Li4uDQoNCj4gDQo+ID4gPiBBbHNvLCBJIHRoaW5rIGl0J3MgY2xlYXJlciB0byB3cml0ZSB0aGlz
IGFzOg0KPiA+ID4gICAgIHJlcV9zaXplID0gbnVtX2tleXMgKiAzIC0gbnVtX2tleXMgJSAyDQo+
ID4gDQo+ID4gTm8sIHRoaXMgaXMgbm90IGhvdyBJIHJlYWQgdGhlIHNwZWMuIFdlIG5lZWQgdG8g
cGFjayAyIGtleSBpbmRpY2VzIGluIDMgb2N0ZXRzLg0KPiA+IEZvciBleGFtcGxlLCA0IGtleXMg
YXJlIHBhY2tlZCBpbiA2IG9jdGV0cyBhbmQgNSBrZXlzIGFyZSBwYWNrZWQgaW4gOCBvY3RldHMu
DQo+IA0KPiBZZXMsIHlvdSdyZSByaWdodC4gU29ycnkuDQo+IA0K
