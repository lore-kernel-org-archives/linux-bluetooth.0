Return-Path: <SRS0=XR6q=ZU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ECFFC432C0
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 16:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9CA21739
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Nov 2019 16:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="QRvPsppB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbfK1QIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Nov 2019 11:08:00 -0500
Received: from mga12.intel.com ([192.55.52.136]:41952 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726545AbfK1QIA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Nov 2019 11:08:00 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Nov 2019 08:08:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,253,1571727600"; 
   d="scan'208";a="359843244"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
  by orsmga004.jf.intel.com with ESMTP; 28 Nov 2019 08:07:59 -0800
Received: from fmsmsx102.amr.corp.intel.com (10.18.124.200) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 08:07:59 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX102.amr.corp.intel.com (10.18.124.200) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 Nov 2019 08:07:59 -0800
Received: from NAM03-CO1-obe.outbound.protection.outlook.com (104.47.40.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 28 Nov 2019 08:07:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCmyvQgJb0d031w2fdj4z4xAPOP3nZq0v5/p7iqZtL4yVYCq4Szulnzh5DDp8D7b6Q5gwFP3GUmxlDxAykgnGPH2vuL8DIWgxwHhfQ7m8mHvlOgBxoYtdcyHxEMKIOFjaYbQcSOmr+rukNbAWUKU69ORsCwguPy5IpLTf8Ai8b7Uxz0XrBwoX/G0yFpqyAtm2q5TgidV2bPYw4mZodeP8nLRbijtQvbmt1COfDpOMYpIWssC9I2LSnJTFxIqEyR2boxGsDjhG97Uw94duy3ineE+/gbofYTaLKsSebKzYut7RzH8cUsLPx5jhhA9Ie6GNVs4GJln5CVU1iy4BwJpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnvpzpC2FGiqSLdsD11QAX2Tha2/W0Rlqsf1aO5a2d4=;
 b=AtGLbQrVIpVCsonyoV+z9ofWCo1g1+Wwydgnm1fyRFcz+0YYeAue8Gw2+setAwYtNezwbsdgn1Rr69h11YDCUzQmL+itQbCEV26pX9sJdpoNkCKn8EOF5VyV5KJ13JzlcynCDLLAHlatSgYNbWFE4FPiYeWjCnn5UtLF5wh/5nZ8Ga8YwyqtydSAtjF0lGSeNSiij6JqgDNL9k7Gw8MrKxx+Q4UvoYNaPYgvfizyxyoO2tWKB/TrD9lJtld7k4OK2CfGWMpzw1YddfQoOix0xrnwRAAJuoeVSqKHNdy0Mkav8KDCEO1M3rP6eLjce1t2nAoaEc4QuC7/6Mx30rcLeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NnvpzpC2FGiqSLdsD11QAX2Tha2/W0Rlqsf1aO5a2d4=;
 b=QRvPsppBeZFgUT+G/OYgYk4QfUW6N99Jr9YYwGBYHZZqu3oE+rh8A1EUcoNaGA3RruyHeu75xFAyxMFXp6jjuciiEOCYLGrAzKOB2bHB1EbK4CQkYav+R6W89qco9uNFfp/TPLDyjeUwHJIoRl3LLRoXmgKWz7PZ+Z8FHbE/Uvg=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2133.namprd11.prod.outlook.com (10.172.75.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.22; Thu, 28 Nov 2019 16:07:58 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2495.014; Thu, 28 Nov 2019
 16:07:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     Venkat Vallapaneni <vallapaneni@socoptimum.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez meshctl error: socket operation on non-socket
Thread-Topic: bluez meshctl error: socket operation on non-socket
Thread-Index: AQHVpNmB1BrGXaui40afLcRxzNHhYKefoNxqgADK+ACAAFZ4KA==
Date:   Thu, 28 Nov 2019 16:07:57 +0000
Message-ID: <F3DC25C3-6C29-402B-B935-A4171B336403@intel.com>
References: <b260550e-0884-662d-e395-90e7678cb1a7@socoptimum.com>
 <78DAB7EA-B99D-4EDE-804B-7D127203DA1B@intel.com>,<b332ed76-d5b1-c245-9301-3af578a274e4@socoptimum.com>
In-Reply-To: <b332ed76-d5b1-c245-9301-3af578a274e4@socoptimum.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [97.126.71.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2eb552f9-96d2-4530-7600-08d7741d22a7
x-ms-traffictypediagnostic: CY4PR1101MB2133:
x-microsoft-antispam-prvs: <CY4PR1101MB2133CABCFEDAA8ECD75EF341E1470@CY4PR1101MB2133.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0235CBE7D0
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(136003)(346002)(366004)(396003)(39860400002)(51914003)(199004)(189003)(6506007)(14454004)(76116006)(53546011)(6436002)(5660300002)(478600001)(6116002)(2616005)(66476007)(33656002)(66946007)(66446008)(99286004)(305945005)(316002)(66556008)(36756003)(6916009)(91956017)(25786009)(71200400001)(86362001)(71190400001)(8676002)(66066001)(229853002)(256004)(3846002)(8936002)(6512007)(2906002)(7736002)(81156014)(81166006)(64756008)(186003)(26005)(76176011)(446003)(4326008)(102836004)(6246003)(11346002)(6486002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2133;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pk9BYtF4q71ibI0vcWilFYarydxB3f+QCek5r5w7vPvOP7nWKa4x/YfftuT/Zpb6PWpv2N6GshHnL4S0id02kJfyY2nrXGHCAGHh+YlWIpVeXlRULofcSiKW7Kp244wK5Xs+EWh5AP+EpN3DlQ4FFMEXdwtbg8iAxy0nAP2fBk6OsFBBeAYG+eyW6Tfdthho5kv2QNWwK3s6qersqTwXja/zdDQVFnkBZwf9ONtf/I0zOj27EKh44/gIahZQT8DIt0gJl8GHulkaJU7kDGHk7pxS5XqkhxPC3ZX3EqmL8dISUfBAd6nUpAGsGRVTtKE/EN+Ha4bXgbuiC+800ZBWgm2QNdJ3QhcwArxiQK/c3Qe7I+ey+EjWq66uwXyXzKzkuIEeB3ixYuxQNNwOiZh/XCcTueLMr+tj2M8jpBp0uunqJiJxGUZlsFVJCjSRC1I9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb552f9-96d2-4530-7600-08d7741d22a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Nov 2019 16:07:57.7049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /etlmlF5NeA9fkdSzt3fglxyWHCq+v1kEPplwIRwChtsHG1zPYpqitm1RGyD2hVZl7poPXnDOtIc+1rHMRz/FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2133
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgVmVua2F0LA0KDQo+IE9uIE5vdiAyOCwgMjAxOSwgYXQgMjo1OSBBTSwgVmVua2F0IFZhbGxh
cGFuZW5pIDx2YWxsYXBhbmVuaUBzb2NvcHRpbXVtLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79IaSBC
cmlhbiwNCj4gDQo+IFRoYW5rcyBmb3IgdGhlIHJlc3BvbnNlLiBZZXMsIEkgYW0gdXNpbmcgUEIt
R0FUVCBiYXJyaWVyLiBXaXRoIGJsdWV0b29vdGhkIHJ1bm5pbmcsIEkgYW0gYWJsZSB0byBwcm92
aXNpb24gbXkgZGV2aWNlLg0KDQpPay4uLiB3ZWxsIGlmIHRoaXMgaXMgc3BlY2lmaWNhbGx5IHRv
IHBsYXkgd2l0aCBaZXBoeXIsIHlvdSBjYW4gYnVpbGQgaXQgdG8gYWNjZXB0IFBCLUFEViBiYXNl
ZCBwcm92aXNpb25pbmcgYXMgd2VsbC4gQnV0IGkgdGhpbmsgWmVwaHlycyBtZXNoIHRpcCBpcyBQ
Ti1HQVRUIGJ5IGRlZmF1bHQuDQoNCj4gSSBhbHNvIHRyaWVkIG1lc2gtY2ZnY2xpZW50IGJ1dCB1
bnN1Y2Nlc3NmdWwuIEkgbGF1bmNoZWQgdGhlIHNoZWxsIHdpdGggbWVzaC1jZmdjbGllbnQgKHdp
dGggYmx1ZXRvb3RoLW1lc2hkIHJ1bm5pbmcpIGFuZCBJIGdhdmUgY3JlYXRlIGNvbW1hbmQgaW4g
dGhlIHNoZWxsLiBJIHNlZSBzZWdtZW50YXRpb24gZmF1bHQuIEFueSBzdGVwcyBJIGFtIG1pc3Np
bmc/DQoNCkFyZSB5b3Ugb24gdGhlIHRpcCBvZiBib3RoIHRoZSBCbHVlWiB0cmVlLCBhbmQgdGhl
IEVMTCB0cmVlPyBBbHNvLCB3aGF0IGxpbnV4IGRpc3RybyBhcmUgeW91IHVzaW5nPw0KDQo+IElz
IG1lc2gtY2ZnY2xpZW50IG9ubHkgZm9yIHByb3Zpc2lvbmluZyBvciBhbHNvIGZvciBzZW5kaW5n
IG1lc2ggbWVzc2FnZXMgYWxzbz8NCg0KbWVzaC1jZmdjbGllbnQgbm90IG9ubHkgcHJvdmlzaW9u
cyBkZXZpY2VzIHdpdGggUEItQURWLCBidXQgaXQgYWxzbyBpcyBhIGZ1bGwgZmVhdHVyZWQgQ29u
ZmlnIENsaWVudC4gSXQgY2FuIHNlbmQga2V5cywgYmluZGluZ3MsIHN1YnNjcmlwdGlvbnMsIGFu
ZCBwdWJsaWNhdGlvbnMuDQoNCg0KPiBSZ2RzLA0KPiANCj4gVmVua2F0Lg0KPiANCj4gDQo+PiBP
biAyOC8xMS8xOSA0OjIyIGFtLCBHaXgsIEJyaWFuIHdyb3RlOg0KPj4gSGkgVmVua2F0LA0KPj4g
DQo+PiBBcmUgeW91IGF0dGVtcHRpbmcgdG8gcHJvdmlzaW9uIGEgZGV2aWNlIHRoYXQgcmVxdWly
ZXMgUEItR0FUVCBwcm92aXNpb25pbmc/ICBJZiBzbywgdGhlIGJsdWV0b290aGQgZGFlbW9uIG11
c3QgYmUgdXAgYW5kIHJ1bm5pbmcuIEhvd2V2ZXIsIHRoaXMgdG9vbCBpcyBvbGQsIGFuZCB3aWxs
IHByb2JhYmx5IGJlIGRlcHJlY2F0ZWQgYXQgc29tZSBwb2ludC4NCj4+IA0KPj4gSG93ZXZlciBt
b3N0IE1lc2ggZGV2aWNlcyBzaG91bGQgc3VwcG9ydCBBZHZlcnRpc2luZyBiYXNlZCBwcm92aXNp
b25pbmcuDQo+PiANCj4+IFRoZSBNZXNoIGRhZW1vbiAoQmx1ZXRvb3RoLW1lc2hkKSBhbmQgdGhl
IG1lc2gtY2ZnY2xpZW50IHRvb2wgKGluIHRoZSB0b29scyBkaXJlY3RvcnkpIGhhcyBiZWVuIHVu
ZGVyZ29pbmcgbW9kaWZpY2F0aW9uIGV2ZW4gc2luY2UgdjUuNTIsIHNvIHlvdSB3aWxsIHdhbnQg
dG8gY2hlY2tvdXQgdGhlIHRpcC4NCj4+IA0KPj4gLi90b29scy9tZXNoLWNmZ2NsaWVudCBpcyB0
aGUgdG9vbCBtb3N0IGFwcHJvcHJpYXRlIGZvciBtZXNoIGRldmVsb3BtZW50IHRvZGF5Lg0KPj4g
DQo+PiANCj4+IA0KPj4+PiBPbiBOb3YgMjYsIDIwMTksIGF0IDg6MTYgUE0sIFZlbmthdCBWYWxs
YXBhbmVuaSA8dmFsbGFwYW5lbmlAc29jb3B0aW11bS5jb20+IHdyb3RlOg0KPj4+IA0KPj4+IO+7
v0hpLA0KPj4+IA0KPj4+IEkgYW0gdHJ5aW5nIHRvIHVzZSBibHVleiA1LjUyIGZvciBwcm92aXNp
b25pbmcgYSBibHVldG9vdGggbWVzaCBjYXBhYmxlIGRldmljZS4gV2hlbiBJIGdhdmUgcHJvdmlz
aW9uIDx1dWlkPiwgSSBnZXQgdGhpcyBiZWxvdyBlcnJvci4gUGxlYXNlIGxldCBtZSBrbm93IHdo
YXQgSSBhbSBtaXNzaW5nLg0KPj4+IA0KPj4+IEkgYW0gdXNpbmcgZWxsIDAuMjYgb24gdWJ1bnR1
IDE4LjA0LiBJIGFtIGFibGUgdG8gcHJvdmlzaW9uIHN1Y2Nlc3NmdWxseSB3aXRoIGJsdWV6IDUu
NTAuDQo+Pj4gDQo+Pj4gQWNxdWlyZVdyaXRlIHN1Y2Nlc3M6IGZkIDggTVRVIDY5DQo+Pj4gR0FU
VC1UWDogICAgIDAzIDAwIDEwDQo+Pj4gKnNlbmRtc2c6IFNvY2tldCBvcGVyYXRpb24gb24gbm9u
LXNvY2tldCpbWmVwaHlyXSMNCj4+PiANCj4+PiBSZ2RzLA0KPj4+IFZlbmthdC4NCj4+PiANCj4+
PiANCg==
