Return-Path: <SRS0=VswU=ZM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6260C432C0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 22:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A023D20692
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Nov 2019 22:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="E18FvbIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfKTWxs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Nov 2019 17:53:48 -0500
Received: from mga05.intel.com ([192.55.52.43]:37757 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbfKTWxs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Nov 2019 17:53:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Nov 2019 14:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,223,1571727600"; 
   d="scan'208";a="200905789"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
  by orsmga008.jf.intel.com with ESMTP; 20 Nov 2019 14:53:47 -0800
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 Nov 2019 14:53:46 -0800
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 20 Nov 2019 14:53:46 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.51) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Wed, 20 Nov 2019 14:53:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jYf5/7/ZdyRL+11v6yc9mwGLx/UHfBaqhTUpNulzPf/Bidw3EbeGRkazsyGsNfbcJ//SiGZUHYfWPslO5t7zLlGPhO0Qy627Q0jXx5xc5VsJYKJqoWfyjbbFgPxryop3vrfwzFF+C0aftsD4+TtsPA6Va1G36s7sKFyVjxP8xXkpIbRL9YcEiIAtnZvjX9w9qGKp23hlvJxvyxv/ASUF8mJT53cvrkkuKCyeF27ax+TlexqieywYiLp58tgwMjyIaxPFqPnRFaOF+NyrhhQBkEFEE9+/8k3FxfumXJrT8jdeT5VB5xGvuPOaBqc3HIRxsyguN/taCxocz1RCnLsX8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbnYl9tikh2GugZ6zvJa6INl+SUOyItgt90+DiZfxgk=;
 b=nfho81WgHcAvRXsXz7MAnf2LZJQh8GwZ0wbN2yuP0stg5LgtpF58zGGG/HZgqsTH2I3BjYYJx3D4R8OXXboWYuf81WGD72FeZmnaqTz66ShHGeqLDtwKAFY5dIzOL9S1OrP1BFPkys//dFK+lUp4CcvIKvP6t6jY4+8dY3C6ThRN9+Yvj5n5HRFDB/Tv5hqaUeiPy+Pfg02EcQOrgYDQajpAiPMG6Cndge0QMBndLmF1hEGHw0fm2U6io1CeEGG/KssoNBcbaS5+eJT27UBNDnQbn7vyK6TU1byXznvQeNUvQaYgGl26Mt5IrMsYaxZvB6wnLTOjaG9yVC2RZhtmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbnYl9tikh2GugZ6zvJa6INl+SUOyItgt90+DiZfxgk=;
 b=E18FvbIbNk7Qn16VrWBxzixSfju3YPYD1lz/eOdA2G33qx+ZcxnInD1Bv8Bb9D5r0mn2HmlyUkriKtzAz9kNRXqob6kXMHx89Tk69HsbEQkIvcJik/Hlt4wWPTRGWLOPMHr1KqHwK9KSO+lJTLckn/7ZUdqqcwJuW8ZgSqAZEGs=
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com (10.172.76.7) by
 CY4PR1101MB2216.namprd11.prod.outlook.com (10.174.54.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.29; Wed, 20 Nov 2019 22:53:45 +0000
Received: from CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06]) by CY4PR1101MB2262.namprd11.prod.outlook.com
 ([fe80::44:eac4:f8c8:ad06%11]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 22:53:45 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "rafal.gajda@silvair.com" <rafal.gajda@silvair.com>
Subject: Re: [PATCH BlueZ v2] mesh: Fix names of dbus management interface
 input arguments
Thread-Topic: [PATCH BlueZ v2] mesh: Fix names of dbus management interface
 input arguments
Thread-Index: AQHVn5BaORq65X5A9EKpdbfxtk93CaeUq5cA
Date:   Wed, 20 Nov 2019 22:53:45 +0000
Message-ID: <1cc41fe1ce7c37080c93086696f3cd01ac5444ac.camel@intel.com>
References: <20191120104950.7904-1-rafal.gajda@silvair.com>
In-Reply-To: <20191120104950.7904-1-rafal.gajda@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36039f02-c6e7-4409-3875-08d76e0c7f93
x-ms-traffictypediagnostic: CY4PR1101MB2216:
x-microsoft-antispam-prvs: <CY4PR1101MB221670433DB9B6D1ABE84B38E14F0@CY4PR1101MB2216.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(136003)(396003)(366004)(376002)(39860400002)(199004)(189003)(71190400001)(7736002)(3846002)(102836004)(6436002)(186003)(91956017)(76116006)(6116002)(118296001)(2906002)(26005)(6486002)(478600001)(6512007)(76176011)(99286004)(14454004)(486006)(2616005)(476003)(81166006)(81156014)(11346002)(2501003)(446003)(316002)(229853002)(6506007)(25786009)(6246003)(8676002)(110136005)(86362001)(66066001)(8936002)(256004)(14444005)(4001150100001)(5660300002)(305945005)(36756003)(66476007)(64756008)(66446008)(66556008)(66946007)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR1101MB2216;H:CY4PR1101MB2262.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qi7OWkJO7gaH9qoHNRH4R2bNHt6RtR0PO7c/qTIUPPsOtMUYAWCr3IJ0HNGN2jir0wXLEnWj296kofr9K9q1WoOL5elYDiswM8/XxsAkg2AVq54ermc1bL88T192a+atIWHL1h6aFQLr1VHRMnsYCQibPjSXmtqcyrySMDhqZdaehDzRM5gcX4f1U9ToBT69aADmecAg2+1WijuPmliwXLtmNZPf5yph/Weg8gbgKzmMa8//vnTg1ndVQtXRMmn7+J65QqwuX1/XLFJ1VkLsaRKirYUcUraFohYTpKD2fvKXUWVmq/sTnT4SZXhCuxQznxfxNcVWl0gzg009/a8rMXBzeBz1tHxV2wDHopNThNiE8uBx+9Nm1swkWGz5Wf1Nqt8MylOWidQhKG+tP8L2ibVz/aWgIBat7esA2M0mn2/t7LQpvdW5XDvcSuaxBJWx
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45AEAC294918914382D3ED937C70D8C9@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 36039f02-c6e7-4409-3875-08d76e0c7f93
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 22:53:45.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TPHmc5V2Y79jPl1rsPxoR9Lfq0CjRM2QP+u0F0mvfw2zfe/hUfbkpqbuKPcqnkjiieWd4oPd1GN4DoeH+rDSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2216
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzDQoNCk9uIFdlZCwgMjAxOS0xMS0yMCBhdCAxMTo0OSArMDEwMCwgUmFm
YcWCIEdhamRhIHdyb3RlOg0KPiBQcmV2aW91c2x5IG5hbWVzIGZvciBtZXRob2QgYXJndW1lbnRz
IGluICJvcmcuYmx1ZXoubWVzaC5NYW5hZ2VtZW50MSINCj4gd291bGQgbm90IHJlZ2lzdGVyIHBy
b3Blcmx5LCBiZWluZyBzaGlmdGVkIGJ5IG9uZToNCj4gCTxtZXRob2QgbmFtZT0iSW1wb3J0UmVt
b3RlTm9kZSI+DQo+IAkJIDxhcmcgbmFtZT0iIiB0eXBlPSJxIiBkaXJlY3Rpb249ImluIi8+DQo+
IAkJIDxhcmcgbmFtZT0icHJpbWFyeSIgdHlwZT0ieSIgZGlyZWN0aW9uPSJpbiIvPg0KPiAJCSA8
YXJnIG5hbWU9ImNvdW50IiB0eXBlPSJheSIgZGlyZWN0aW9uPSJpbiIvPg0KPiAJIDwvbWV0aG9k
Pg0KPiANCj4gIFRoaXMgZml4ZXMgdGhpcyBpc3N1ZToNCj4gCSA8bWV0aG9kIG5hbWU9IkltcG9y
dFJlbW90ZU5vZGUiPg0KPiAJCSA8YXJnIG5hbWU9InByaW1hcnkiIHR5cGU9InEiIGRpcmVjdGlv
bj0iaW4iLz4NCj4gCQkgPGFyZyBuYW1lPSJjb3VudCIgdHlwZT0ieSIgZGlyZWN0aW9uPSJpbiIv
Pg0KPiAJCSA8YXJnIG5hbWU9ImRldl9rZXkiIHR5cGU9ImF5IiBkaXJlY3Rpb249ImluIi8+DQo+
IAkgPC9tZXRob2Q+DQo+IC0tLQ0KPiANCj4gdjIgLSBGaXhlZCBjb2Rpbmcgc3RhbmRhcmQNCj4g
DQo+ICBtZXNoL21hbmFnZXIuYyB8IDMwICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDE2IGRlbGV0aW9ucygtKQ0KPiAN
Cj4gZGlmZiAtLWdpdCBhL21lc2gvbWFuYWdlci5jIGIvbWVzaC9tYW5hZ2VyLmMNCj4gaW5kZXgg
YWRiYjAxMjgwLi4xZmI5ZGY1ZTYgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWFuYWdlci5jDQo+ICsr
KyBiL21lc2gvbWFuYWdlci5jDQo+IEBAIC03NTAsMzYgKzc1MCwzNCBAQCBzdGF0aWMgc3RydWN0
IGxfZGJ1c19tZXNzYWdlICpzZXRfa2V5X3BoYXNlX2NhbGwoc3RydWN0IGxfZGJ1cyAqZGJ1cywN
Cj4gIA0KPiAgc3RhdGljIHZvaWQgc2V0dXBfbWFuYWdlbWVudF9pbnRlcmZhY2Uoc3RydWN0IGxf
ZGJ1c19pbnRlcmZhY2UgKmlmYWNlKQ0KPiAgew0KPiAtCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9k
KGlmYWNlLCAiQWRkTm9kZSIsIDAsIGFkZF9ub2RlX2NhbGwsICIiLCAiYXkiLA0KPiAtCQkJCQkJ
CQkidXVpZCIpOw0KPiArCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiQWRkTm9kZSIs
IDAsIGFkZF9ub2RlX2NhbGwsDQo+ICsJCQkJCQkJIiIsICJheSIsICJ1dWlkIik7DQo+ICAJbF9k
YnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJJbXBvcnRSZW1vdGVOb2RlIiwgMCwgaW1wb3J0
X25vZGVfY2FsbCwNCj4gLQkJCQkJCSIiLCAicXlheSIsICIiLCAicHJpbWFyeSIsDQo+IC0JCQkJ
CQkiY291bnQiLCAiZGV2X2tleSIpOw0KPiArCQkJCSIiLCAicXlheSIsICJwcmltYXJ5IiwgImNv
dW50IiwgImRldl9rZXkiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkRl
bGV0ZVJlbW90ZU5vZGUiLCAwLCBkZWxldGVfbm9kZV9jYWxsLA0KPiAtCQkJCQkiIiwgInF5Iiwg
IiIsICJwcmltYXJ5IiwgImNvdW50Iik7DQo+ICsJCQkJCQkiIiwgInF5IiwgInByaW1hcnkiLCAi
Y291bnQiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIlVucHJvdmlzaW9u
ZWRTY2FuIiwgMCwgc3RhcnRfc2Nhbl9jYWxsLA0KPiAtCQkJCQkJCSIiLCAicSIsICIiLCAic2Vj
b25kcyIpOw0KPiArCQkJCQkJCSIiLCAicSIsICJzZWNvbmRzIik7DQo+ICAJbF9kYnVzX2ludGVy
ZmFjZV9tZXRob2QoaWZhY2UsICJVbnByb3Zpc2lvbmVkU2NhbkNhbmNlbCIsIDAsDQo+ICAJCQkJ
CQljYW5jZWxfc2Nhbl9jYWxsLCAiIiwgIiIpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9k
KGlmYWNlLCAiQ3JlYXRlU3VibmV0IiwgMCwgY3JlYXRlX3N1Ym5ldF9jYWxsLA0KPiAtCQkJCQkJ
IiIsICJxIiwgIiIsICJuZXRfaW5kZXgiKTsNCj4gKwkJCQkJCQkiIiwgInEiLCAibmV0X2luZGV4
Iik7DQo+ICAJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJVcGRhdGVTdWJuZXQiLCAw
LCB1cGRhdGVfc3VibmV0X2NhbGwsDQo+IC0JCQkJCQkiIiwgInEiLCAiIiwgIm5ldF9pbmRleCIp
Ow0KPiArCQkJCQkJCSIiLCAicSIsICJuZXRfaW5kZXgiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNl
X21ldGhvZChpZmFjZSwgIkRlbGV0ZVN1Ym5ldCIsIDAsIGRlbGV0ZV9zdWJuZXRfY2FsbCwNCj4g
LQkJCQkJCSIiLCAicSIsICIiLCAibmV0X2luZGV4Iik7DQo+ICsJCQkJCQkJIiIsICJxIiwgIm5l
dF9pbmRleCIpOw0KPiAgCWxfZGJ1c19pbnRlcmZhY2VfbWV0aG9kKGlmYWNlLCAiSW1wb3J0U3Vi
bmV0IiwgMCwgaW1wb3J0X3N1Ym5ldF9jYWxsLA0KPiAtCQkJCQkiIiwgInFheSIsICIiLCAibmV0
X2luZGV4IiwgIm5ldF9rZXkiKTsNCj4gKwkJCQkJIiIsICJxYXkiLCAibmV0X2luZGV4IiwgIm5l
dF9rZXkiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIkNyZWF0ZUFwcEtl
eSIsIDAsIGNyZWF0ZV9hcHBrZXlfY2FsbCwNCj4gLQkJCQkJIiIsICJxcSIsICIiLCAibmV0X2lu
ZGV4IiwgImFwcF9pbmRleCIpOw0KPiArCQkJCQkiIiwgInFxIiwgIm5ldF9pbmRleCIsICJhcHBf
aW5kZXgiKTsNCj4gIAlsX2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIlVwZGF0ZUFwcEtl
eSIsIDAsIHVwZGF0ZV9hcHBrZXlfY2FsbCwNCj4gLQkJCQkJCSIiLCAicSIsICIiLCAiYXBwX2lu
ZGV4Iik7DQo+ICsJCQkJCQkJIiIsICJxIiwgImFwcF9pbmRleCIpOw0KPiAgCWxfZGJ1c19pbnRl
cmZhY2VfbWV0aG9kKGlmYWNlLCAiRGVsZXRlQXBwS2V5IiwgMCwgZGVsZXRlX2FwcGtleV9jYWxs
LA0KPiAtCQkJCQkJIiIsICJxIiwgIiIsICJhcHBfaW5kZXgiKTsNCj4gKwkJCQkJCQkiIiwgInEi
LCAiYXBwX2luZGV4Iik7DQo+ICAJbF9kYnVzX2ludGVyZmFjZV9tZXRob2QoaWZhY2UsICJJbXBv
cnRBcHBLZXkiLCAwLCBpbXBvcnRfYXBwa2V5X2NhbGwsDQo+IC0JCQkJIiIsICJxcWF5IiwgIiIs
ICJuZXRfaW5kZXgiLCAiYXBwX2luZGV4IiwNCj4gLQkJCQkJCQkJImFwcF9rZXkiKTsNCj4gKwkJ
CSIiLCAicXFheSIsICJuZXRfaW5kZXgiLCAiYXBwX2luZGV4IiwgImFwcF9rZXkiKTsNCj4gIAls
X2RidXNfaW50ZXJmYWNlX21ldGhvZChpZmFjZSwgIlNldEtleVBoYXNlIiwgMCwgc2V0X2tleV9w
aGFzZV9jYWxsLA0KPiAtCQkJCQkiIiwgInF5IiwgIiIsICJuZXRfaW5kZXgiLCAicGhhc2UiKTsN
Cj4gKwkJCQkJCSIiLCAicXkiLCAibmV0X2luZGV4IiwgInBoYXNlIik7DQo+ICB9DQo+ICANCj4g
IGJvb2wgbWFuYWdlcl9kYnVzX2luaXQoc3RydWN0IGxfZGJ1cyAqYnVzKQ0K
