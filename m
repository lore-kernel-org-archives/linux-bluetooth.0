Return-Path: <SRS0=Sobe=CX=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412AC2BBD1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 20:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE2F620757
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Sep 2020 20:26:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="Tp3u9yAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgINU04 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Sep 2020 16:26:56 -0400
Received: from mga02.intel.com ([134.134.136.20]:26566 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgINU0m (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Sep 2020 16:26:42 -0400
IronPort-SDR: qBdsz+KkdLea0NMLZUdVdqMUIsbDAZNRYfC8hbbk4xby1W5aF2V8JOlNjcrYvK+ZLCIgNvNenl
 pTo2qaL0SYRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9744"; a="146847472"
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="146847472"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2020 13:26:37 -0700
IronPort-SDR: yCkQfVz25Gwz7JvndaYWPnJxy6WpXPXBmH0iMFv5QOKrfLD3zXdbVOjcWUzKkPMajU4xDKvIjp
 A8PVIa7mUcAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,427,1592895600"; 
   d="scan'208";a="306307503"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 14 Sep 2020 13:26:36 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 14 Sep 2020 13:26:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 14 Sep 2020 13:26:36 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 14 Sep 2020 13:26:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+oQNzHFLvobEM0uXu1U/BA6GkDobnpdKLaP/af5/UEbPLsHoxOURU72/NLyqFPkLBeP5dzjfE5orYbDpzs2RsRTKkYWqE7KRdMeQVdDmZKGA+w62FLUy1Zo6KXQ4CU1l/goxcWYoPoptnXZ18BY2l9hW2+klZ2JiSxSavyDDrV0KFKKlG4boVtLJDCovMlTNVx//FX2i0YEj4T+K8YohEUjNeFaPlojNzCnewlDL9HCMC0HB9FqwSobIT2+SYZ2DXRY7LsaMJ7OYr4utt6v5rQ4FDIGjgSx9D8LUr05fOkskPD31fj02sdswLir9auhqyyNq14tI6Two36kh3y/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05XU9X1DwqNXj1T7WQA8oZt+kjLQsOBzbOpfyZ1iCAQ=;
 b=Dvs92uUe9rzPVxbLyRd4zHTUQISDB6rB8W3JxTMSg9kkmDEvzKe5bgUb+5kqcdiVqsCrW9BTH/rxZ7WjfKfTsRwFz2XGF4Oi6thWkcpHC3AjhnvyGFNWR5aSutwLyMMfbNdeBiX5QYIIGmGaFdHEMJnkkQ5EGHpHwxE6wNmorPRuEzoT0Qm4YtHqIFZGQuPo4RMffMJcLpnTmG+ZtTgh6R82LgTgQ5k8TuY0JIlvp0fJhIce548SAxLhgCe7md6Zpx3bO+DhtAN2ittskEwSg8A4dVv9BGEx/R6YXZOStL7ACpAA7rScgs5i1ZFj2p2xZqIz9Ofc0WhRuyJBHT9gRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05XU9X1DwqNXj1T7WQA8oZt+kjLQsOBzbOpfyZ1iCAQ=;
 b=Tp3u9yAFufxPKXqVrE0ug7FfMT2z28cCZomsqMoKw4sFpLBfB8bbAzOMl55zdzh7nPg6rGnwcMDWtlf6T/z62PvS8PFtoCueX0pJUp9YbwLNxMb6ncuWPDliyDADhVVlAAXu9y4VFSsLT6fEGA1QtsJ3KRMVtcOgD8klmmqYFCQ=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1357.namprd11.prod.outlook.com (2603:10b6:300:2b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Mon, 14 Sep
 2020 20:26:34 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::243f:4543:6dfd:ff22]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::243f:4543:6dfd:ff22%4]) with mapi id 15.20.3348.016; Mon, 14 Sep 2020
 20:26:34 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@linux.intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BlueZ 13/17] plugins: Add SPDX License Identifer
Thread-Topic: [BlueZ 13/17] plugins: Add SPDX License Identifer
Thread-Index: AQHWiM1eQSpy2EkukUmtVvat2FRFBaloaIoA//+7LoA=
Date:   Mon, 14 Sep 2020 20:26:34 +0000
Message-ID: <A8434ACD-6E35-4A52-93ED-64FC110AF335@intel.com>
References: <20200912062357.23926-1-tedd.an@linux.intel.com>
 <20200912062357.23926-14-tedd.an@linux.intel.com>
 <CABBYNZLiUJi8qZnZgBAMGwu8bKM1RoeiDcjZ5AK6jfWJ7ShTpw@mail.gmail.com>
In-Reply-To: <CABBYNZLiUJi8qZnZgBAMGwu8bKM1RoeiDcjZ5AK6jfWJ7ShTpw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.40.20081000
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [73.164.224.32]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4101810a-1ee7-4b30-babc-08d858ec797b
x-ms-traffictypediagnostic: MWHPR11MB1357:
x-microsoft-antispam-prvs: <MWHPR11MB13572CD73CA9C93528D89CA2FF230@MWHPR11MB1357.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WrBmDvH/C+psnjJ5ufHcELC/6l2uOPGeDz/antonmMlUVpcului8Bp5/SAj6RDe8awl8JZviP4zWAUzV0jk404gsN4FKU1B6GTWaASB8jsVBagSKEgKrylDPk3+X0bwJtQ/s1JvufnaprhdIMS6H8d4/7mbkgII+2sqe92u5UIEXphgKP9zYRIOSaaiM1M/9dqdy/2bXZBo6yeKFStvnLDSWhfVINu1TPmYddQSzHga+Z2I6dHCLCTAKzyFBAbPnFuateDY6ywgZe3OdqCOmzRL/8gvJ952V9OfGksA6skoZDzDMcvwsfXq0kn4ojt47xON+BimMla1NAkx7SJHhoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(346002)(366004)(39860400002)(110136005)(6506007)(8676002)(5660300002)(71200400001)(66476007)(83380400001)(76116006)(66446008)(64756008)(66556008)(66946007)(2616005)(26005)(6486002)(478600001)(4326008)(186003)(316002)(33656002)(86362001)(36756003)(2906002)(8936002)(53546011)(6512007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wQYSRMotFhFCLtYTiBR4Paxq2Wn0E/kA3lxjfu1FdQiQMuJRtXFZurhLTQ/B0Y1UY9U9g6MLdLH6DLaplyTchGSP+cFNqwaGpd1yCDwecYWS1V5/Pm5AJtVJJ/81JFPRg3yxH9d4pwvkx/6K/DqyxAvgM4KqgmNBjaAMCe8F8tqkknQqFITX6UBRkWDy8vY3VWcb/LhsNpkmvtJsVSZxg+x1dy+9repFQJYaK2atwGjwXW4Y92jg7pUzE/zV0XXy+p89e1Cbb4oF7u2WKO1WOIsFrj/XhpkKyAZhAOe2MKffe+SyBKckMU3aQh3p83bUd6MIAQ/PBA+hqPMStOxyFkSPYRRYWnfuJ2ssx6TD6yDTwhGMX0IqUp7rObdFt6273cAOv9kxhR6imJau2A5wFFKcU/OS2vL0wBOjltaGrzaQqfI/xIiKI8+C/ue159T6hC6cDsg85h/pxq1CXOtxa1jnwF5t31BySHqLJM9vMM6Qf1xdoSD4RFT6t1NGYOoIDA+jILMccDr17Ke2FZR2pFZvWxiOpFc54o5/00Dp6i0evBjD1Hns3yXHWhw1krFSdtGyRbrydtyarZUnPopNBWEuvHFKcm3vhzgoAUt7KYCiYZSab5KYb7FjTJpAET5y/dICFlyMbx8gKsvnIMrx9g==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E40F3A3FA23B9E4985E100B5D0510399@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4101810a-1ee7-4b30-babc-08d858ec797b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2020 20:26:34.6075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jDKwEH7eekJwodaLML0Ye2j0SX0mpQdwvtLcc6fbm9KVL0ILitSTUroNZUVFklaB7lnCnTTqydGrgcL/E+m6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1357
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KSSByZWFsaXplZCB0aGF0IHRoZXJlIGlzIG5vIEdQTCAyLjEgb3IgbGF0ZXIu
DQoNCk9ubHkgZm9yIExHUEwgMi4xIG9yIGxhdGVyLi4uDQpJIHdpbGwga2VlcCBhcyBpcy4NCg0K
UmVnYXJkcywNClRlZGQNCg0K77u/T24gOS8xNC8yMCwgMTA6MzMgQU0sICJMdWl6IEF1Z3VzdG8g
dm9uIERlbnR6IiA8bHVpei5kZW50ekBnbWFpbC5jb20+IHdyb3RlOg0KDQogICAgSGkgVGVkZCwN
Cg0KICAgIE9uIEZyaSwgU2VwIDExLCAyMDIwIGF0IDExOjQxIFBNIDx0ZWRkLmFuQGxpbnV4Lmlu
dGVsLmNvbT4gd3JvdGU6DQogICAgPg0KICAgID4gRnJvbTogVGVkZCBIby1KZW9uZyBBbiA8dGVk
ZC5hbkBpbnRlbC5jb20+DQogICAgPg0KICAgID4gVGhpcyBwYXRjaCBhZGRzIFNQRFggTGljZW5z
ZSBJZGVudGlmaWVyLg0KICAgID4NCiAgICA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCiAgICA+ICAgICAgICBMaWNlbnNlICAgICAgICAgICAgQ09VTlQNCiAgICA+IC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiAgICA+ICBHUEwtMi4wLW9yLWxh
dGVyICAgICA6ICAgICAgNw0KDQogICAgSSBndWVzcyBhbGwgR1BMIDIuMCBvciBsYXRlciBjYW4g
YmUgdXBkYXRlZCB0byBHUEwgMi4xIG9yIGxhdGVyLg0KDQogICAgPiBMaWNlbnNlOiBHUEwtMi4w
LW9yLWxhdGVyDQogICAgPiAgICBwbHVnaW5zL2F1dG9wYWlyLmMNCiAgICA+ICAgIHBsdWdpbnMv
aG9zdG5hbWUuYw0KICAgID4gICAgcGx1Z2lucy9uZWFyZC5jDQogICAgPiAgICBwbHVnaW5zL3Bv
bGljeS5jDQogICAgPiAgICBwbHVnaW5zL3NpeGF4aXMuYw0KICAgID4gICAgcGx1Z2lucy93aWlt
b3RlLmMNCiAgICA+ICAgIHBsdWdpbnMvZXh0ZXJuYWwtZHVtbXkuYw0KICAgID4gLS0tDQogICAg
PiAgcGx1Z2lucy9hdXRvcGFpci5jICAgICAgIHwgMSArDQogICAgPiAgcGx1Z2lucy9leHRlcm5h
bC1kdW1teS5jIHwgMSArDQogICAgPiAgcGx1Z2lucy9ob3N0bmFtZS5jICAgICAgIHwgMSArDQog
ICAgPiAgcGx1Z2lucy9uZWFyZC5jICAgICAgICAgIHwgMSArDQogICAgPiAgcGx1Z2lucy9wb2xp
Y3kuYyAgICAgICAgIHwgMSArDQogICAgPiAgcGx1Z2lucy9zaXhheGlzLmMgICAgICAgIHwgMSAr
DQogICAgPiAgcGx1Z2lucy93aWltb3RlLmMgICAgICAgIHwgMSArDQogICAgPiAgNyBmaWxlcyBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCiAgICA+DQogICAgPiBkaWZmIC0tZ2l0IGEvcGx1Z2lu
cy9hdXRvcGFpci5jIGIvcGx1Z2lucy9hdXRvcGFpci5jDQogICAgPiBpbmRleCAzMDg5NDMwYTgu
LjM4MWQ5MWM4ZiAxMDA2NDQNCiAgICA+IC0tLSBhL3BsdWdpbnMvYXV0b3BhaXIuYw0KICAgID4g
KysrIGIvcGx1Z2lucy9hdXRvcGFpci5jDQogICAgPiBAQCAtMSwzICsxLDQgQEANCiAgICA+ICsv
LyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KDQogICAgV2h5IGFy
ZSB5b3UgdXNpbmcgQysrIC8vIGNvbW1lbnRzIG9uIHRoZSAuYyBmaWxlcyBhbmQgLyogKi8gY29t
bWVudHMNCiAgICBvbiAuaD8gQWxzbyBpdCBsb29rcyBsaWtlIHlvdSBhcmUga2VlcGluZyB0aGUg
b2xkIGxpY2Vuc2UgdGV4dCB3aGljaA0KICAgIHNob3VsZCBubyBsb25nZXIgYmUgbmVjZXNzYXJ5
Lg0KDQogICAgPiAgLyoNCiAgICA+ICAgKg0KICAgID4gICAqICBCbHVlWiAtIEJsdWV0b290aCBw
cm90b2NvbCBzdGFjayBmb3IgTGludXgNCiAgICA+IGRpZmYgLS1naXQgYS9wbHVnaW5zL2V4dGVy
bmFsLWR1bW15LmMgYi9wbHVnaW5zL2V4dGVybmFsLWR1bW15LmMNCiAgICA+IGluZGV4IDUzNmFk
MDY2My4uNzgzNzdiMDIxIDEwMDY0NA0KICAgID4gLS0tIGEvcGx1Z2lucy9leHRlcm5hbC1kdW1t
eS5jDQogICAgPiArKysgYi9wbHVnaW5zL2V4dGVybmFsLWR1bW15LmMNCiAgICA+IEBAIC0xLDMg
KzEsNCBAQA0KICAgID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyDQogICAgPiAgLyoNCiAgICA+ICAgKg0KICAgID4gICAqICBCbHVlWiAtIEJsdWV0b290aCBw
cm90b2NvbCBzdGFjayBmb3IgTGludXgNCiAgICA+IGRpZmYgLS1naXQgYS9wbHVnaW5zL2hvc3Ru
YW1lLmMgYi9wbHVnaW5zL2hvc3RuYW1lLmMNCiAgICA+IGluZGV4IDRmOWRmZTZkOC4uMzJmMTVi
M2E1IDEwMDY0NA0KICAgID4gLS0tIGEvcGx1Z2lucy9ob3N0bmFtZS5jDQogICAgPiArKysgYi9w
bHVnaW5zL2hvc3RuYW1lLmMNCiAgICA+IEBAIC0xLDMgKzEsNCBAQA0KICAgID4gKy8vIFNQRFgt
TGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQogICAgPiAgLyoNCiAgICA+ICAg
Kg0KICAgID4gICAqICBCbHVlWiAtIEJsdWV0b290aCBwcm90b2NvbCBzdGFjayBmb3IgTGludXgN
CiAgICA+IGRpZmYgLS1naXQgYS9wbHVnaW5zL25lYXJkLmMgYi9wbHVnaW5zL25lYXJkLmMNCiAg
ICA+IGluZGV4IDZmZmNkNmUxMC4uMWZlZmM1MDE1IDEwMDY0NA0KICAgID4gLS0tIGEvcGx1Z2lu
cy9uZWFyZC5jDQogICAgPiArKysgYi9wbHVnaW5zL25lYXJkLmMNCiAgICA+IEBAIC0xLDMgKzEs
NCBAQA0KICAgID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVy
DQogICAgPiAgLyoNCiAgICA+ICAgKg0KICAgID4gICAqICBCbHVlWiAtIEJsdWV0b290aCBwcm90
b2NvbCBzdGFjayBmb3IgTGludXgNCiAgICA+IGRpZmYgLS1naXQgYS9wbHVnaW5zL3BvbGljeS5j
IGIvcGx1Z2lucy9wb2xpY3kuYw0KICAgID4gaW5kZXggZGU1MWU1OGI5Li44NmViMjVlZTkgMTAw
NjQ0DQogICAgPiAtLS0gYS9wbHVnaW5zL3BvbGljeS5jDQogICAgPiArKysgYi9wbHVnaW5zL3Bv
bGljeS5jDQogICAgPiBAQCAtMSwzICsxLDQgQEANCiAgICA+ICsvLyBTUERYLUxpY2Vuc2UtSWRl
bnRpZmllcjogR1BMLTIuMC1vci1sYXRlcg0KICAgID4gIC8qDQogICAgPiAgICoNCiAgICA+ICAg
KiAgQmx1ZVogLSBCbHVldG9vdGggcHJvdG9jb2wgc3RhY2sgZm9yIExpbnV4DQogICAgPiBkaWZm
IC0tZ2l0IGEvcGx1Z2lucy9zaXhheGlzLmMgYi9wbHVnaW5zL3NpeGF4aXMuYw0KICAgID4gaW5k
ZXggOTM5ZmVkNzU5Li44MzUwZDYzZjggMTAwNjQ0DQogICAgPiAtLS0gYS9wbHVnaW5zL3NpeGF4
aXMuYw0KICAgID4gKysrIGIvcGx1Z2lucy9zaXhheGlzLmMNCiAgICA+IEBAIC0xLDMgKzEsNCBA
QA0KICAgID4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyDQog
ICAgPiAgLyoNCiAgICA+ICAgKg0KICAgID4gICAqICBCbHVlWiAtIEJsdWV0b290aCBwcm90b2Nv
bCBzdGFjayBmb3IgTGludXgNCiAgICA+IGRpZmYgLS1naXQgYS9wbHVnaW5zL3dpaW1vdGUuYyBi
L3BsdWdpbnMvd2lpbW90ZS5jDQogICAgPiBpbmRleCAwY2VkMjc1MTQuLjk0NDFhNzY4MSAxMDA2
NDQNCiAgICA+IC0tLSBhL3BsdWdpbnMvd2lpbW90ZS5jDQogICAgPiArKysgYi9wbHVnaW5zL3dp
aW1vdGUuYw0KICAgID4gQEAgLTEsMyArMSw0IEBADQogICAgPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXINCiAgICA+ICAvKg0KICAgID4gICAqDQogICAgPiAg
ICogIEJsdWVaIC0gQmx1ZXRvb3RoIHByb3RvY29sIHN0YWNrIGZvciBMaW51eA0KICAgID4gLS0N
CiAgICA+IDIuMjUuNA0KICAgID4NCg0KDQogICAgLS0gDQogICAgTHVpeiBBdWd1c3RvIHZvbiBE
ZW50eg0KDQo=
