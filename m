Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1693C4338F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDCF60F6B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jul 2021 00:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhG1ARX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 20:17:23 -0400
Received: from mga06.intel.com ([134.134.136.31]:35252 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232840AbhG1ARW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 20:17:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10058"; a="273631910"
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="273631910"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 17:17:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,275,1620716400"; 
   d="scan'208";a="506147054"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2021 17:17:21 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 17:17:20 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 17:17:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 17:17:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iK7pxbdKOe72laL53MDg416kKe8ec9HZFzddWe9nDZ3nOrtfyVoAeJYGgC89qRGOOSBMsQs0aebgrT0K3o1NWW+XS+GKxUjRzBWkO691yLJx1q0YzGD5OChyOPlqHSqT+tVeVA4ssRfSkZrAn0eqQmPXEuKbA3s6KYH2LwITZpf2j+jL5HPn1fe8izeYG1iG6M0hbEin4JzcYvIJuYXkExNMwH2UupsllhDM68c6U/ycsanD9qDQxyj74QhaxsZT1BDTW9KjKsfsRRI9IVZCaB8ohUrdkDZclWx9Euk3tZt80FFN6JUQUbU+ws3zhVRDC/qeKxoBa2dmRve30C8YZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZlwqt6Ds99RyoV7z3NSjPOiAdMcFtJpOFCrz1Xm0X8=;
 b=TIbv3WVrJkjH83uY9u8sdvUQAy2yA0Mfz+64ZOhu1j3kyu8+U7fFJu1zEo+UZpgEO7l6Gr7hZlPq9F3xKStgv9FgWPxCpiJJgnTdwA3XBJZyF2EAkPXh4Y8jGPtIMFQPC/ruYUAr/MknuGm0B5IaCNfGgn+bA3iHTsXNbHmDKfX4Rp7tYOi37RRMMQ6Q5Xe8MqKVLnCSLAGyTfrR2b7OqFae70pyvYnvQuKzcilz2R4T5dL85W1bvKvRqstCuHX/4LJo7Q8sZKgPObJQlgK8Ks5cOwCYbRzuMxXRN8vxkOqzAx93axb7AjcZOATVWe6b8s7ZjE6amA6OtaLlEPmUPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CZlwqt6Ds99RyoV7z3NSjPOiAdMcFtJpOFCrz1Xm0X8=;
 b=DmS27SOIgbvesCnaY5+nvFSFfT+xXTv+JtMgTQI6tgQwZEQjvs/E+pJ7gWT1Faq26pqAdfweDEIiHyZ5HK36NnK1ugSZUlOSmMRL9wkgXGMfxicbgLSCbru7/Ghj0Qy/2lJ0BlZsw0m8EahbitCIJVgW9KFiASzwfe/rm6q/4Ns=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.17; Wed, 28 Jul
 2021 00:17:19 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::8e3:ec48:4aa7:358a]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::8e3:ec48:4aa7:358a%7]) with mapi id 15.20.4352.031; Wed, 28 Jul 2021
 00:17:18 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC PATCH v4 00/11] Bluetooth: btintel: Refactoring setup
 routines
Thread-Topic: [RFC PATCH v4 00/11] Bluetooth: btintel: Refactoring setup
 routines
Thread-Index: AQHXg0JgotGoDiHeJk+DBVxIW/vShKtXhVQA
Date:   Wed, 28 Jul 2021 00:17:18 +0000
Message-ID: <ec19aeb722249764a52fd74a27b25a78a28a3f09.camel@intel.com>
References: <20210727235127.173149-1-hj.tedd.an@gmail.com>
In-Reply-To: <20210727235127.173149-1-hj.tedd.an@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.36.5 (3.36.5-2.fc32) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58b99adf-2ea4-4295-bbac-08d9515d0fdb
x-ms-traffictypediagnostic: MW3PR11MB4716:
x-microsoft-antispam-prvs: <MW3PR11MB4716D26A4C61B01F75BF5CD1FFEA9@MW3PR11MB4716.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1824;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +/2GDmwIyofiqLfjdP0VjXCZQE7MdCPPo/34RX7TSghx04UDKcL0vnIL9UnZYl4qCOEw4IRcQ/ePZr0BhjWbsS6Eb6QFUPI99GTxJzYDbRCs0Ct835xxcBH7R7s0KGa1O25hpKJPi3MDm9eta6uOJWbu+mw3rduabIikZY+EmyobD1wUDw81Gz5l1EGQ89vdAhpjJ9XOWafdq7yGLzPELiH1bU0J7UVGElMYc6+BHxb9ViPWhQ/zs11AkK8daN0JZDLUAt8aaxE4QgQ+ZtvYGWK853Vf8ZWTfXnaj3CqbTbbiafRiXkL4u7OFGKkxvQRoOvA6Q8+qW2f5vvosDE1gvPgnAyl+FZloSyFoWVNdOdD8nfhQ5VMMI4u4Q5dy7tq4uVl2oNw1MgmkKauLPWTGdoRqERw6znNlls4HGkJnjAhhMnQxQnYEG+D2HJlj/Wlsd5ZkCRKbAC/Hy5FvMIbZVjpTi+Jv0M0eij3VEkAnsElc3SWI6LOsZzaQnraNlgv986G9E0CChAp20Nr5+05H+3iQdaFNB5ZkLQ/CB7dnaWVs6OJ8TKOP+LNhaPjaPDBBCi/WjBab2c9m9o6OW2LiTzOur4GVRbf4DrETbc56FybxX1+9Ux0iGq8FT0PUN4O5m0abR5ZFcjdMtNXyHJ8ohQHS+G9pDCVxM9H0BPgHB6zMtqm9oNvwm7o81qZMYg2YY0JRVsxVMp+CdsGY/mrXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(186003)(122000001)(38100700002)(66446008)(83380400001)(5660300002)(66476007)(316002)(6916009)(66946007)(8676002)(86362001)(66556008)(64756008)(8936002)(6506007)(6486002)(71200400001)(508600001)(36756003)(2616005)(26005)(6512007)(38070700005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aXJOREFXS20vUmdoK1R4RFpZTXFUbUhnQ1hqRUY4RTVkdm52aUV6OWpmSjZM?=
 =?utf-8?B?TUszdHRuY3FNWmNXZWI2YTc3d3hKTjZzUDF6Ung1NXRTZGlxeThRMTJwUW16?=
 =?utf-8?B?SVVFQjByYkZmTkFFRjBtdSsrbkJjWi9FdTd4OWE1NE82R0swT2FpVU9FTCs3?=
 =?utf-8?B?dmJvZ1JyUElDY2Z5VGJrUE5lNjBtTC9HNkhMTU1FZ2J6eHNxZXVkMStscGlW?=
 =?utf-8?B?bHlhRVk3SExLNFRJY2lBSml5Y0dzK1prSmpMR21VUlhIelg2eDdEKzN6OHJS?=
 =?utf-8?B?VmFtTUt0MUU3b1NPUzVyblJpa3pvNEpVRk11M1YxVmJkbmtFWHluOTEvVW5j?=
 =?utf-8?B?eERib2RSbFNQZnFRREtodFVpbFk1alUvcEdBZk5EZW1ZZ1grR1RPb05KVDU1?=
 =?utf-8?B?T3h3a0pGWjQvN1NEeGxOVktNMzdpaVpCRVM2OFU0Yk1YOUZHbytyWWhyUHBV?=
 =?utf-8?B?OFJpd1VIRDcyb3JGcmdCU2VYZ3FGVnI1bXliNHlQRVRBK2ZpbzRWaW5uNEFQ?=
 =?utf-8?B?K0lrWFdITmNpMVc1ZXRKRVNtdHZjbHUwSEVySE56dUxXdFVnUS9wTnJFVFI2?=
 =?utf-8?B?Sks1TmNXM2l4UXk2UW9qc3U3bUhFeFFJN00yMDIxRlJESW5KMTFXUHIwWmVq?=
 =?utf-8?B?SHY3aWIxS1R1bEE0RzRVVnZtV2tEU3F6ZitLc0tJZ2ViU1l6OEVlZ2NPMEc4?=
 =?utf-8?B?ekRyUkgwYkY4aTYyNjlGQUx3WjFpaFpjSkhUT0taalEyczd0elhJVTRRaVcz?=
 =?utf-8?B?Y2NYWVVBSkdsNllXakhJaFArTlFUL3FFTnB2eTNpRWRKMHVvc2J5SjMxYldx?=
 =?utf-8?B?K2lJa3lERFNzT0tuV0N1bGxFSmx3T2Z1V1RoVXhQcWtTUC9zNTZwRGd4Y1dS?=
 =?utf-8?B?Um1Sa0IvcHpEVXhZd0RBallNQ2FQaXRLNXZCU1Zia29ZS1pBbTF2WC8xUmRW?=
 =?utf-8?B?R1VUdVNNeDBkd1F5UWpvYnF2UFJTUWpncXlHOThQOTNLSVh1aFhpTFdMV2N2?=
 =?utf-8?B?SDFna2JFaGFZblRxOEMwRjMyTENtV1M1Q2poKzd3MGk1L2dEVkhHQ0NDZGJZ?=
 =?utf-8?B?QWhaUjgxS0wwZFhZSmxEQktDNVhaV2VSdk5qaGhFNStoditUR1Y5TCtPMERR?=
 =?utf-8?B?bTY4MVJ3YURGTFUxTGtkbHFCZUJaQm9NR081b1RqWmVwWDkzOUdFNk44OVlM?=
 =?utf-8?B?STFHWmE2SmVyeXZ4WldnOEVHK3grT1RXQVRJSHZ5Ykk5dFNSM2pYVGZsWWhN?=
 =?utf-8?B?NmF5VFh5K0dGNERnNjEwTVYwY29JM242enBpUDMyeFgxdTgwUC9qL3lMTVFK?=
 =?utf-8?B?Q0Z1Wis4dmdJaGlJRWkrTVpEbktvSHpCaEVOWFVaTVZDTllPaGZrS3lLeFdS?=
 =?utf-8?B?MXBNV0dIR3RtUUtlQll2aENXZUhYbWc2ZVVlaTgvVmxwMU15anQxNkZDODRn?=
 =?utf-8?B?VDVtTXZCYnRkMTkrSUJteEo2ZEVFWnlDdDV3T0x5cktFaUhJZ01VQURKVitn?=
 =?utf-8?B?VTUydHJJdFFVMGRjdnNGQWdab1NBZ3dzS1pXU05kWnhaU09PTTRLd052RGdW?=
 =?utf-8?B?TnhUWG9ialFBcUFGV3RaTGY2b2tKSm10ODJianhaUTlybDdkeFpLaVQ1S1RG?=
 =?utf-8?B?QmhBZnB2aFJqSjVmYzFmWXhMeEVqWkNJZERjK2I2Q0JMQ3RHTHFMVEdoMnFi?=
 =?utf-8?B?KytMaVFTVU84ZUhqdUYrZXVYdnRtQjYxaEdackphRms5cHU5RGJmcW9md01n?=
 =?utf-8?Q?C/zfIPblSMcUO08o5IWpIC1It5IaQMAxer2naVE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBC23BAAA8D16547B0CA1DEA8FF7A221@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b99adf-2ea4-4295-bbac-08d9515d0fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2021 00:17:18.8402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1he2QbM0ZM0GmRqD9PUL8Y1UhQYmQUDFFsleHjI0kf4S3BeZjry08PC/mULnAmHCMHr0Z/HVphSJju1k/kIRJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGksIA0KDQpTb21lIGxldmVsIG9mIHRlc3RpbmdzIHdlcmUgZG9uZSBhbmQgc2hhcmluZyB0aGUg
cmVzdWx0czoNCg0KVGVzdHMgZXhlY3V0ZWQ6DQoJMS4gTG9hZGluZyBmaXJtd2FyZQ0KCTIuIFJl
bW92ZSBkZXZpY2UgKHVucGx1ZyBVU0IpDQoJMy4gUmVib290DQoJNC4gQ29sZCBib290DQoJNS4g
U2NhbiBhbmQgY29ubmVjdA0KCTYuIENvbm5lY3QgTW91c2UgKEhJRCkNCgk3LiBDb25uZWN0IFNw
ZWFrZXIgKEEyRFApDQoJOC4gQ29ubmVjdCBIZWFkc2V0IChIRlApDQoNCkRldmljZSBmaXJtd2Fy
ZXM6DQoJVElQIGZyb20gdGhlIGxpbnV4LWZpcm13YXJlIHRyZWUNCgljb21taXQ6IDE2ODQ1MmUg
KCJNZXJnZSB0YWcgJ2l3bHdpZmktZnctMjAyMS0wNy0xOScgb2YgLi4uIikNCg0KQmx1ZVo6DQoJ
NS41MyBvbiBVYnVudHUgMjAuMDQuMiBMVFMNCg0KRGV2aWNlcyB0ZXN0ZWQ6DQoJTGVnYWN5IFJP
TTogU3RQLCBTZFANCglMZWdhY3kgQm9vdGxvYWRlcjogU2ZQLCBXc1AsIFRoUCwgVGhQMiwgQ2NQ
DQoJVExWIEJvb3Rsb2FkZXI6IEdmUA0KDQpSZXN1bHRzOg0KCUFsbCBkZXZpY2VzIHBhc3NlZCB0
aGUgdGVzdHMuDQoNClJlZ2FyZHMsDQpUZWRkDQoNCk9uIFR1ZSwgMjAyMS0wNy0yNyBhdCAxNjo1
MSAtMDcwMCwgVGVkZCBIby1KZW9uZyBBbiB3cm90ZToNCj4gRnJvbTogVGVkZCBIby1KZW9uZyBB
biA8dGVkZC5hbkBpbnRlbC5jb20+DQo+IA0KPiBUaGlzIHBhdGNoIHNldCByZWZhY3RvcnMgdGhl
IG11bHRpcGxlIHNldHVwIHJvdXRpbmVzIGZvciB2YXJpb3VzIEludGVsIGRldmljZXMNCj4gdG8g
YSBjb21iaW5lZCBzaW5nbGUgZW50cnkuIEhlcmUgYXJlIHRoZSBoaWdobGlnaHQgb2YgdGhlIGNo
YW5nZXM6DQo+IA0KPiAwLiBTeW5jIHdpdGggdGhlIGN1cnJlbnQgdGlwIG9mIHRoZSBtYXN0ZXI6
DQo+ICAgIGFjZDVhZWE0MDAgKCJCbHVldG9vdGg6IGJ0dXNiOiBBZGQgdmFsaWQgbGUgc3RhdGVz
IHF1aXJrIikNCj4gDQo+IDEuIFVwZGF0ZWQgaGNpX2FsbG9jX2RldigpIHRvIGFsbG9jYXRlIHRo
ZSBoZGV2IG9iamVjdCB3aXRoIGFuIGV4dHJhIGJ1ZmZlcg0KPiAgICBmb3IgdGhlIHByaXZhdGUg
ZGF0YS4gYnRpbnRlbCBpbnRyb2R1Y2VzIHRoZSBidGludGVsX2RhdGEgc3RydWN0IGFuZA0KPiAg
ICBzdG9yZSBpdCB0byB0aGUgcHJpdmF0ZSBkYXRhIGluIGhkZXYgb2JqZWN0Lg0KPiANCj4gMi4g
QWRkZWQgYSBzaW5nbGUgZW50cnkgZm9yIHNldHVwIGFuZCBzaHV0ZG93biBhbmQgdXNlcyB0aGUN
Cj4gICAgSENJX0ludGVsX1JlYWRfVmVyc2lvbiBjb21tYW5kIHRvIGlkZW50aWZ5IHRoZSBkZXZp
Y2UsIGluc3RlYWQgb2YNCj4gICAgcmVseWluZyBvbiB0aGUgVVNCIFZJRCBhbmQgUElELg0KPiAN
Cj4gICAgQWxzbywgaXQgdXNlcyB0aGUgbmV3IGZvcm1hdCBvZiBIQ0lfSW50ZWxfUmVhZF9WZXJz
aW9uIGNvbW1hbmQgZm9yDQo+ICAgIGxlZ2FjeSBST00gYW5kIGxlZ2FjeSBib290bG9hZGVyIGRl
dmljZXMuIEx1Y2tseSBsZWdhY3kgZGV2aWNlcw0KPiAgICBzdXBwb3J0IHRoZSBuZXcgZm9ybWF0
Lg0KPiANCj4gMy4gS2VlcCB0aGUgc3RhdGUgb2YgYm9vdGxvYWRlciBpbiBidGludGVsIG9iamVj
dC4gVGhlIGJvb3Rsb2FkZXIgc3RhdGUNCj4gICAgaXMgYWdub3N0aWMgdG8gdGhlIHRyYW5zcG9y
dCB0eXBlLCBzbyBidGludGVsIHVzZXMgdGhlIGJ0aW50ZWxfZGF0YQ0KPiAgICB0byBrZWVwIHRy
YWNrIG9mIHRoZSBzdGF0ZSBpbiB0aGUgcHJpdmF0ZSBkYXRhIHNlY3Rpb24gaW4gaGRldi4NCj4g
DQo+IDQuIEFmdGVyIGlkZW50aWZ5aW5nIHRoZSBzZXR1cCB0eXBlIGZvciB0aGUgZGV2aWNlLCBp
dCB1c2VzIHRoZQ0KPiAgICBjb3JyZXNwb25kIHNldHVwIHJvdXRpbmVzIGJhc2VkIG9uIHRoZSBz
ZXR1cCB0eXBlLCBhbmQgdGhlIHNldHVwDQo+ICAgIHJvdXRpbmVzIHdlcmUgbW92ZWQgZnJvbSBi
dHVzYiB0byBidGludGVsLg0KPiAgICBIb3dldmVyLCBhY3R1YWwgd29yayBmb3IgdGhlIHNldHVw
IHJvdXRpbmVzIHdlcmUgbm90IGNoYW5nZWQgb3IgdmVyeQ0KPiAgICBtaW5pbWFsLg0KPiANCj4g
NS4gU2luY2UgbWFueSBmdW5jdGlvbnMgd2VyZSBtb3ZlZCBmcm9tIGJ0dXNiIHRvIGJ0aW50ZWws
IGNsZWFuIHVwIHRoZQ0KPiAgICBleHBvcnRlZCBmdW5jdGlvbnMgYW5kIG1ha2UgdGhlbSBzdGF0
aWMgaWYgcG9zc2libGUuDQo+IA0KPiA2LiBGcm9tIHRoZSBKZlAvVGhQLCB0aGUgb3BlcmF0aW9u
YWwgZmlybXdhcmUgc3VwcG9ydCB0aGUgbmV3IFRMViBiYXNlZA0KPiAgICBIQ0lfSW50ZWxfUmVh
ZF9WZXJzaW9uIGNvbW1hbmQsIHdoaWNoIGNvbmZ1ZXMgdGhlIHVzYWdlIGR1cmluZyB0aGUNCj4g
ICAgc2V0dXAgcm91dGluZS4gU28sIHRoZSBjaGVjayBmb3IgZmlybXdhcmUgdmFyaWFudCBvZiB0
aG9zZSBsZWdhY3kNCj4gICAgYm9vdGxvYWRlciBza3UgaXMgYWRkZWQgdG8gdXNlIHRoZSBsZWdh
Y3kgYm9vdGxvYWRlciBzZXR1cCBjYWxsLg0KPiANCj4gVGVkZCBIby1KZW9uZyBBbiAoMTEpOg0K
PiAgIEJsdWV0b290aDogQWRkIHN1cHBvcnQgaGRldiB0byBhbGxvY2F0ZSBwcml2YXRlIGRhdGEN
Cj4gICBCbHVldG9vdGg6IGJ0aW50ZWw6IEFkZCBjb21iaW5lZCBzZXR1cCBhbmQgc2h1dGRvd24g
ZnVuY3Rpb25zDQo+ICAgQmx1ZXRvb3RoOiBidGludGVsOiBSZWZhY3RvcmluZyBzZXR1cCByb3V0
aW5lIGZvciBsZWdhY3kgUk9NIHNrdQ0KPiAgIEJsdWV0b290aDogYnRpbnRlbDogQWRkIGJ0aW50
ZWwgZGF0YSBzdHJ1Y3QNCj4gICBCbHVldG9vdGg6IGJ0aW50ZWw6IEZpeCB0aGUgZmlyc3QgSENJ
IGNvbW1hbmQgbm90IHdvcmsgd2l0aCBST00NCj4gICAgIGRldmljZS4NCj4gICBCbHVldG9vdGg6
IGJ0aW50ZWw6IEZpeCB0aGUgTEVEIGlzIG5vdCB0dXJuaW5nIG9mZiBpbW1lZGlhdGVseQ0KPiAg
IEJsdWV0b290aDogYnRpbnRlbDogQWRkIGNvbWJpbmVkIHNldF9kaWFnIGZ1bmN0aW9ucw0KPiAg
IEJsdWV0b290aDogYnRpbnRlbDogUmVmYWN0b3Jpbmcgc2V0dXAgcm91dGluZSBmb3IgbGVnYWN5
IGJvb3Rsb2FkZXINCj4gICBCbHVldG9vdGg6IGJ0aW50ZWw6IFJlZmFjdG9yaW5nIHNldHVwIHJv
dXRpbmUgZm9yIFRMViBiYXNlZCBib29sb2FkZXINCj4gICBCbHVldG9vdGg6IGJ0aW50ZWw6IENs
ZWFuIHRoZSBleHBvcnRlZCBmdW5jdGlvbiB0byBzdGF0aWMNCj4gICBCbHVldG9vdGg6IGJ0aW50
ZWw6IEZpeCB0aGUgbGVnYWN5IGJvb3Rsb2FkZXIgcmV0dXJucyB0bHYgYmFzZWQNCj4gICAgIHZl
cnNpb24NCj4gDQo+ICBkcml2ZXJzL2JsdWV0b290aC9iZnVzYi5jICAgICAgICB8ICAgIDIgKy0N
Cj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2JsdWVjYXJkX2NzLmMgIHwgICAgMiArLQ0KPiAgZHJpdmVy
cy9ibHVldG9vdGgvYnBhMTB4LmMgICAgICAgfCAgICAyICstDQo+ICBkcml2ZXJzL2JsdWV0b290
aC9idDNjX2NzLmMgICAgICB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwu
YyAgICAgIHwgMTIxNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIGRyaXZlcnMv
Ymx1ZXRvb3RoL2J0aW50ZWwuaCAgICAgIHwgICA4MyArLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgv
YnRtcnZsX21haW4uYyAgfCAgICAyICstDQo+ICBkcml2ZXJzL2JsdWV0b290aC9idG10a3NkaW8u
YyAgICB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrdWFydC5jICAgIHwgICAg
MiArLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgvYnRxY29tc21kLmMgICAgfCAgICAyICstDQo+ICBk
cml2ZXJzL2JsdWV0b290aC9idHJzaS5jICAgICAgICB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvYmx1
ZXRvb3RoL2J0c2Rpby5jICAgICAgIHwgICAgMiArLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgvYnR1
c2IuYyAgICAgICAgfCAxMTA1ICsrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgZHJpdmVy
cy9ibHVldG9vdGgvZHRsMV9jcy5jICAgICAgfCAgICAyICstDQo+ICBkcml2ZXJzL2JsdWV0b290
aC9oY2lfbGRpc2MuYyAgICB8ICAgIDIgKy0NCj4gIGRyaXZlcnMvYmx1ZXRvb3RoL2hjaV9zZXJk
ZXYuYyAgIHwgICAgMiArLQ0KPiAgZHJpdmVycy9ibHVldG9vdGgvaGNpX3ZoY2kuYyAgICAgfCAg
ICAyICstDQo+ICBkcml2ZXJzL2JsdWV0b290aC92aXJ0aW9fYnQuYyAgICB8ICAgIDIgKy0NCj4g
IGluY2x1ZGUvbmV0L2JsdWV0b290aC9oY2lfY29yZS5oIHwgICAgNyArLQ0KPiAgbmV0L2JsdWV0
b290aC9oY2lfY29yZS5jICAgICAgICAgfCAgIDExICstDQo+ICAyMCBmaWxlcyBjaGFuZ2VkLCAx
MjYyIGluc2VydGlvbnMoKyksIDExODggZGVsZXRpb25zKC0pDQo+IA0K
