Return-Path: <SRS0=5zPD=O5=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF640C43387
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 17:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61A220815
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Dec 2018 17:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732161AbeLTRAG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Dec 2018 12:00:06 -0500
Received: from mga12.intel.com ([192.55.52.136]:34787 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730509AbeLTRAG (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Dec 2018 12:00:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Dec 2018 09:00:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,377,1539673200"; 
   d="scan'208";a="119904416"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
  by orsmga002.jf.intel.com with ESMTP; 20 Dec 2018 09:00:05 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 20 Dec 2018 09:00:05 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.175]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.128]) with mapi id 14.03.0415.000;
 Thu, 20 Dec 2018 09:00:05 -0800
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Michal Lowas-Rzechonek <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Advertising report address types in mesh-io-generic
Thread-Topic: Advertising report address types in mesh-io-generic
Thread-Index: AQHUmH990Rtnuxk2F02mhgDFxAy+7aWH2PfA
Date:   Thu, 20 Dec 2018 17:00:03 +0000
Message-ID: <DEBB0CAA2616974FAE35E4B560B9A4375D8E337C@ORSMSX101.amr.corp.intel.com>
References: <20181220161707.lxrzzvknqa64pmyc@kynes>
In-Reply-To: <20181220161707.lxrzzvknqa64pmyc@kynes>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNmU2M2U4OWQtMGE1Mi00ODZlLWIxNDAtMWE2OWMyYmY5YWQ2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoieFNMMUY1OFd1aVVXdGdFMHQ5dzZqXC9jaURJcnJUd2VJYmtiV2QyOFdTZ0g3azBpZjJwY2FSSHZ1aVpVcEFoRDcifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.22.254.140]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IGxpbnV4
LWJsdWV0b290aC1vd25lckB2Z2VyLmtlcm5lbC5vcmcgW21haWx0bzpsaW51eC1ibHVldG9vdGgt
DQo+IG93bmVyQHZnZXIua2VybmVsLm9yZ10gT24gQmVoYWxmIE9mIE1pY2hhbCBMb3dhcy1SemVj
aG9uZWsNCj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIwLCAyMDE4IDg6MTcgQU0NCj4gVG86
IGxpbnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogQWR2ZXJ0aXNpbmcg
cmVwb3J0IGFkZHJlc3MgdHlwZXMgaW4gbWVzaC1pby1nZW5lcmljDQo+IA0KPiBIaSwNCj4gDQo+
IEkndmUgbm90aWNlZCB0aGF0IG1lc2gtaW8tZ2VuZXJpYy5jIGZpbHRlcnMgYWR2ZXJ0aXNpbmcg
cmVwb3J0IGV2ZW50cyBieQ0KPiBhZGRyZXNzIHR5cGU6DQo+IA0KPiBzdGF0aWMgdm9pZCBldmVu
dF9hZHZfcmVwb3J0KHN0cnVjdCBtZXNoX2lvICppbywgY29uc3Qgdm9pZCAqYnVmLCB1aW50OF90
DQo+IHNpemUpIHsNCj4gICAgIC4uLg0KPiANCj4gCWlmIChldnQtPmFkZHJfdHlwZSAhPSBCREFE
RFJfTEVfUFVCTElDICYmDQo+IAkJCWV2dC0+YWRkcl90eXBlICE9IEJEQUREUl9MRV9SQU5ET00p
DQo+IAkJcmV0dXJuOw0KDQpBZGRyZXNzIHR5cGVzIGNhbiBiZSBCUi9FRFIgKDB4MDApLCBMRSBQ
dWJsaWMgKDB4MDEpLCBhbmQgTEUgUmFuZG9tICgweDAyKS4NCg0KVGhpcyBmaWx0ZXJzIG91dCBC
Ui9FRFIgYWR2ZXJ0aXNlbWVudHMsIHdoaWNoIGFyZSBub3Qgc3VwcG9ydGVkIGluIE1lc2guIChz
aG91bGQgYmUgTEUgT25seSkuDQoNCj4gDQo+IERvZXMgYW55b25lIGtub3cgd2h5IChCcmlhbj8p
Pw0KPiANCj4gQmx1ZXRvb3RoIE1lc2ggc3BlYyBkb2Vzbid0IG1lbnRpb24gYWRkcmVzcyB0eXBl
cyBhdCBhbGwsIHNvIEkgYXNzdW1lZCB0aGF0DQo+IHRoaXMgbGF5ZXIgc2hvdWxkbid0IHJlYWxs
eSBjYXJlIGFib3V0IE1BQyBhZGRyZXNzZXMgYW5kIHRoZWlyIHR5cGVzLg0KPiANCj4gLS0NCj4g
TWljaGHFgiBMb3dhcy1SemVjaG9uZWsgPG1pY2hhbC5sb3dhcy1yemVjaG9uZWtAc2lsdmFpci5j
b20+DQo+IFNpbHZhaXIgaHR0cDovL3NpbHZhaXIuY29tDQo+IEphc25vZ8OzcnNrYSA0NCwgMzEt
MzU4IEtyYWtvdywgUE9MQU5EDQo=
