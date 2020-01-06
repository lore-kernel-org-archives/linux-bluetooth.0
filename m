Return-Path: <SRS0=R8GA=23=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA17C33C8C
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 15:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B10E2081E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jan 2020 15:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="OvQZyQMi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgAFPfI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:35:08 -0500
Received: from mga09.intel.com ([134.134.136.24]:8247 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726296AbgAFPfH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Jan 2020 10:35:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jan 2020 07:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,403,1571727600"; 
   d="scan'208";a="232855242"
Received: from fmsmsx104.amr.corp.intel.com ([10.18.124.202])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2020 07:35:06 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx104.amr.corp.intel.com (10.18.124.202) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 6 Jan 2020 07:35:05 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 6 Jan 2020 07:35:05 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 6 Jan 2020 07:35:05 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 6 Jan 2020 07:35:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cDnH7C+9WjU4xmREkHGrtejacLV69JkeCHeNhl5U/7NVL2NFlX3XgybcExZgxSMdKYsPhjz2siLIVG4URKatKuD3V6ycQfrQi+abKQOzuSEha5bCIzsEwUeOQJJzCa6MfhwqPSmuKejJ4TLo1lwuYWDWY+zeDJRG7U7v8WObetCZPQ2WnQiFkz8eyfE+sWKWZmZH2vDEBCAvyJ1pGeeitE31Zb60/g3hC+nbG1AKBIl1YgotGqBI+6PssXGl70ZF6mUYveiNlsb98+0IDPIvC3amPfm6PNvPnuMj+VPkGPjWV42hG7FlFE3KwiR1D03YU4ZWG9Eq9vlZtSeIVHtdsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u14X6jHO35hMxAxYT7vNMWbdcfHugZOWepo8Juft8tU=;
 b=fAOgTuuu8A8RUUoYHnZbSZwNJXIXp1UapmB+3S4OHeiByBM0iyk6nKO6RHOxRnv6pW8iXJu7nLo0d8xW813Rw/77KUZ1TeLASknldg7eQZLReHIEMXlu6g/zeRWmrRHQ5iNftq1gLmiiT0dyi0y+aAK3wclZ88KFOhhG2FFSUAQ1qbvo4TCIWFoFcZFFUh61R2PPBRfl+I+/NtAeoweqjpqLzllmwcod/yvZuaGH3UQQbGAGZzKRoXwIxHZhgsKCmuP85jjyjp+MaeKocgn/3T69ptZXhHr+csp1GuYvDNrn0fo9ddFD/aVcx+zRl7ktsT5fGWpgR6SU4TvSFh52xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u14X6jHO35hMxAxYT7vNMWbdcfHugZOWepo8Juft8tU=;
 b=OvQZyQMiNuDnyRSipKxLaE+7a0VzbQMo/5AeaSvE0ZryGExHr4xTE7Rgxsig/5UwSRl6FQkYB07zPn0D+PwVg5ZS8ykjvMn7Xw7I/NiWEcTQR5aRweFFBdPjGh3kULk575KqoM+Uklk0AMp5cTYSaNbL00Jzr/jLmGeLvTeL0VM=
Received: from CY4PR11MB1269.namprd11.prod.outlook.com (10.173.16.11) by
 CY4PR11MB1766.namprd11.prod.outlook.com (10.175.59.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Mon, 6 Jan 2020 15:35:02 +0000
Received: from CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876]) by CY4PR11MB1269.namprd11.prod.outlook.com
 ([fe80::5b2:92c7:da12:1876%7]) with mapi id 15.20.2602.015; Mon, 6 Jan 2020
 15:35:01 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Style fix
Thread-Topic: [PATCH BlueZ] mesh: Style fix
Thread-Index: AQHVxFVRV1xUuGlt2E+i++rZ5ux7AafdxQsA
Date:   Mon, 6 Jan 2020 15:35:01 +0000
Message-ID: <cfbd414959195e25d9e27f1195d64018b1c04918.camel@intel.com>
References: <20200106055049.31997-1-inga.stotland@intel.com>
In-Reply-To: <20200106055049.31997-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fb4ba30e-df6a-4ce7-f463-08d792bdfee0
x-ms-traffictypediagnostic: CY4PR11MB1766:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB176647B16D50C53BA69E8453E13C0@CY4PR11MB1766.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 0274272F87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(6486002)(5660300002)(6512007)(6506007)(2616005)(2906002)(110136005)(316002)(86362001)(36756003)(71200400001)(64756008)(6636002)(81166006)(8676002)(26005)(76116006)(66946007)(66556008)(91956017)(66476007)(66446008)(186003)(8936002)(81156014)(478600001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR11MB1766;H:CY4PR11MB1269.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q/A0ve1mCNkpV+z/+d/GI9G3cmkV1uHtKFYwegVtlwCSAkmPATOl2oVwGQVgf0j9zlQfldyRQTRKtWv5wtybpHmtrlLyMu2LsjEU4PHKiDKMHA9a7kg/WEo4IquBCv+Zh1oIB5PFvvlgzBTkLPc97tSD5f9oaOB5MB8M2NAvlPCRWh+oBxqOoRyfUBKkW5Hux8aJr/BGTuBr99Kno6IvPdGsvo774/aCMlbKp5N8Wpym7J3wjqzDkUsYsPeVwRdGDBlOUWHVMHjezy1ks+IvjWKbxEThvd+xUHRX1VrkIa4juAoql7mn3vM/lo73t6xENWXF92GTA8tFRJNPNemxjY5rwVBy6pYZuU8aYsH10Z6i4AUxWGOZdKqFpc6J9CoxSwULtzdgt2yzr4h61FyFuya3w/7Gqk2GTh6u+5d5x4vfKU6R7DWGdWfrQZ+wuZJe
Content-Type: text/plain; charset="utf-8"
Content-ID: <27774D2B3E020E4B8DA60668A71FACF4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fb4ba30e-df6a-4ce7-f463-08d792bdfee0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2020 15:35:01.7214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vH+RTGR3+E4YiIjpOrEs7C/GI2ya2ubcKsLC+6prslDE/LoQHFWg/QIh5fvsq3s74ANNntyZJ+FHLxyNFH39qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1766
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCANCk9uIFN1biwgMjAyMC0wMS0wNSBhdCAyMTo1MCAtMDgwMCwgSW5nYSBTdG90bGFu
ZCB3cm90ZToNCj4gVGhpcyBmaXhlcyBzdHlsZSBpc3N1ZXM6IHNwYWNlcyAtPiB0YWJzLCBhbGln
bm1lbnQuDQo+IC0tLQ0KPiAgbWVzaC9tYW5hZ2VyLmMgfCA1OSArKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDMwIGlu
c2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gvbWFu
YWdlci5jIGIvbWVzaC9tYW5hZ2VyLmMNCj4gaW5kZXggMWFkNmMxMjZkLi5lNGE3ZGVhZWIgMTAw
NjQ0DQo+IC0tLSBhL21lc2gvbWFuYWdlci5jDQo+ICsrKyBiL21lc2gvbWFuYWdlci5jDQo+IEBA
IC03NTAsMzUgKzc1MCwzNiBAQCBzdGF0aWMgc3RydWN0IGxfZGJ1c19tZXNzYWdlICpzZXRfa2V5
X3BoYXNlX2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywNCj4gIA0KPiAgc3RhdGljIHZvaWQgc2V0
dXBfbWFuYWdlbWVudF9pbnRlcmZhY2Uoc3RydWN0IGxfZGJ1c19pbnRlcmZhY2UgKmlmYWNlKQ0K
PiAgew0KPiAtICAgIGxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiQWRkTm9kZSIsIDAs
IGFkZF9ub2RlX2NhbGwsICIiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICJheSIs
ICJ1dWlkIik7DQo+IC0gICAgbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJJbXBvcnRS
ZW1vdGVOb2RlIiwgMCwgaW1wb3J0X25vZGVfY2FsbCwgIiIsDQo+IC0gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgInF5YXkiLCAicHJpbWFyeSIsICJjb3VudCIsICJkZXZfa2V5Iik7DQo+IC0g
ICAgbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJEZWxldGVSZW1vdGVOb2RlIiwgMCwg
ZGVsZXRlX25vZGVfY2FsbCwgIiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgInF5
IiwgInByaW1hcnkiLCAiY291bnQiKTsNCj4gLSAgICBsX2RidXNfaW50ZXJmYWNlX21ldGhvZChp
ZmFjZSwgIlVucHJvdmlzaW9uZWRTY2FuIiwgMCwgc3RhcnRfc2Nhbl9jYWxsLCAiIiwNCj4gLSAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAicSIsICJzZWNvbmRzIik7DQo+IC0gICAgbF9kYnVz
X2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJVbnByb3Zpc2lvbmVkU2NhbkNhbmNlbCIsIDAsIGNh
bmNlbF9zY2FuX2NhbGwsICIiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICIiKTsN
Cj4gLSAgICBsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkNyZWF0ZVN1Ym5ldCIsIDAs
IGNyZWF0ZV9zdWJuZXRfY2FsbCwgIiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
InEiLCAibmV0X2luZGV4Iik7DQo+IC0gICAgbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2Us
ICJVcGRhdGVTdWJuZXQiLCAwLCB1cGRhdGVfc3VibmV0X2NhbGwsICIiLA0KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICJxIiwgIm5ldF9pbmRleCIpOw0KPiAtICAgIGxfZGJ1c19pbnRl
cmZhY2VfbWV0aG9kKGlmYWNlLCAiRGVsZXRlU3VibmV0IiwgMCwgZGVsZXRlX3N1Ym5ldF9jYWxs
LCAiIiwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAicSIsICJuZXRfaW5kZXgiKTsN
Cj4gLSAgICBsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkltcG9ydFN1Ym5ldCIsIDAs
IGltcG9ydF9zdWJuZXRfY2FsbCwgIiIsDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAg
InFheSIsICJuZXRfaW5kZXgiLCAibmV0X2tleSIpOw0KPiAtICAgIGxfZGJ1c19pbnRlcmZhY2Vf
bWV0aG9kKGlmYWNlLCAiQ3JlYXRlQXBwS2V5IiwgMCwgY3JlYXRlX2FwcGtleV9jYWxsLCAiIiwN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAicXEiLCAibmV0X2luZGV4IiwgImFwcF9p
bmRleCIpOw0KPiAtICAgIGxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiVXBkYXRlQXBw
S2V5IiwgMCwgdXBkYXRlX2FwcGtleV9jYWxsLCAiIiwNCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAicSIsICJhcHBfaW5kZXgiKTsNCj4gLSAgICBsX2RidXNfaW50ZXJmYWNlX21ldGhv
ZChpZmFjZSwgIkRlbGV0ZUFwcEtleSIsIDAsIGRlbGV0ZV9hcHBrZXlfY2FsbCwgIiIsDQo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgInEiLCAiYXBwX2luZGV4Iik7DQo+IC0gICAgbF9k
YnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJJbXBvcnRBcHBLZXkiLCAwLCBpbXBvcnRfYXBw
a2V5X2NhbGwsICIiLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICJxcWF5IiwgIm5l
dF9pbmRleCIsICJhcHBfaW5kZXgiLCAiYXBwX2tleSIpOw0KPiAtICAgIGxfZGJ1c19pbnRlcmZh
Y2VfbWV0aG9kKGlmYWNlLCAiU2V0S2V5UGhhc2UiLCAwLCBzZXRfa2V5X3BoYXNlX2NhbGwsICIi
LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICJxeSIsICJuZXRfaW5kZXgiLCAicGhh
c2UiKTsNCj4gLSB9DQo+ICsJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJBZGROb2Rl
IiwgMCwgYWRkX25vZGVfY2FsbCwgIiIsDQo+ICsJCQkJCQkJCSJheSIsICJ1dWlkIik7DQo+ICsJ
bF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJJbXBvcnRSZW1vdGVOb2RlIiwgMCwgaW1w
b3J0X25vZGVfY2FsbCwNCj4gKwkJCQkiIiwgInF5YXkiLCAicHJpbWFyeSIsICJjb3VudCIsICJk
ZXZfa2V5Iik7DQo+ICsJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJEZWxldGVSZW1v
dGVOb2RlIiwgMCwgZGVsZXRlX25vZGVfY2FsbCwNCj4gKwkJCQkJCSIiLCAicXkiLCAicHJpbWFy
eSIsICJjb3VudCIpOw0KPiArCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiVW5wcm92
aXNpb25lZFNjYW4iLCAwLCBzdGFydF9zY2FuX2NhbGwsDQo+ICsJCQkJCQkJIiIsICJxIiwgInNl
Y29uZHMiKTsNCj4gKwlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIlVucHJvdmlzaW9u
ZWRTY2FuQ2FuY2VsIiwgMCwNCj4gKwkJCQkJCWNhbmNlbF9zY2FuX2NhbGwsICIiLCAiIik7DQo+
ICsJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJDcmVhdGVTdWJuZXQiLCAwLCBjcmVh
dGVfc3VibmV0X2NhbGwsDQo+ICsJCQkJCQkJIiIsICJxIiwgIm5ldF9pbmRleCIpOw0KPiArCWxf
ZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiVXBkYXRlU3VibmV0IiwgMCwgdXBkYXRlX3N1
Ym5ldF9jYWxsLA0KPiArCQkJCQkJCSIiLCAicSIsICJuZXRfaW5kZXgiKTsNCj4gKwlsX2RidXNf
aW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkRlbGV0ZVN1Ym5ldCIsIDAsIGRlbGV0ZV9zdWJuZXRf
Y2FsbCwNCj4gKwkJCQkJCQkiIiwgInEiLCAibmV0X2luZGV4Iik7DQo+ICsJbF9kYnVzX2ludGVy
ZmFjZV9tZXRob2QoaWZhY2UsICJJbXBvcnRTdWJuZXQiLCAwLCBpbXBvcnRfc3VibmV0X2NhbGws
DQo+ICsJCQkJCSIiLCAicWF5IiwgIm5ldF9pbmRleCIsICJuZXRfa2V5Iik7DQo+ICsJbF9kYnVz
X2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJDcmVhdGVBcHBLZXkiLCAwLCBjcmVhdGVfYXBwa2V5
X2NhbGwsDQo+ICsJCQkJCSIiLCAicXEiLCAibmV0X2luZGV4IiwgImFwcF9pbmRleCIpOw0KPiAr
CWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiVXBkYXRlQXBwS2V5IiwgMCwgdXBkYXRl
X2FwcGtleV9jYWxsLA0KPiArCQkJCQkJCSIiLCAicSIsICJhcHBfaW5kZXgiKTsNCj4gKwlsX2Ri
dXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkRlbGV0ZUFwcEtleSIsIDAsIGRlbGV0ZV9hcHBr
ZXlfY2FsbCwNCj4gKwkJCQkJCQkiIiwgInEiLCAiYXBwX2luZGV4Iik7DQo+ICsJbF9kYnVzX2lu
dGVyZmFjZV9tZXRob2QoaWZhY2UsICJJbXBvcnRBcHBLZXkiLCAwLCBpbXBvcnRfYXBwa2V5X2Nh
bGwsDQo+ICsJCQkJCQkJIiIsICJxcWF5IiwgIm5ldF9pbmRleCIsDQo+ICsJCQkJCQkJImFwcF9p
bmRleCIsICJhcHBfa2V5Iik7DQo+ICsJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJT
ZXRLZXlQaGFzZSIsIDAsIHNldF9rZXlfcGhhc2VfY2FsbCwgIiIsDQo+ICsJCQkJCQkicXkiLCAi
bmV0X2luZGV4IiwgInBoYXNlIik7DQo+ICt9DQo+ICANCj4gIGJvb2wgbWFuYWdlcl9kYnVzX2lu
aXQoc3RydWN0IGxfZGJ1cyAqYnVzKQ0KPiAgew0K
