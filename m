Return-Path: <SRS0=u3xs=74=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA580C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 19:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75CC02071A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Jun 2020 19:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="eW4MH3t+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbgFOTzz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Jun 2020 15:55:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:23630 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728771AbgFOTzy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Jun 2020 15:55:54 -0400
IronPort-SDR: Dp/nlt9mndfPIUsUx0h2FpFXch9IhmmBoLZKoA0pFc0bIPXnKKpAMN4xJBWx1YrIyMmptAYxRm
 RFAoZC30MwGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2020 12:55:53 -0700
IronPort-SDR: raVGGDkpmVMDEVEBnBfPchXCsvFiTnsIaCjmB+DilyCaiUuLqRnd05MsY7Itn2oc5yKXp4GFAn
 4Yb1UTFC4vbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,515,1583222400"; 
   d="scan'208";a="276670798"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by orsmga006.jf.intel.com with ESMTP; 15 Jun 2020 12:55:53 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 15 Jun 2020 12:55:53 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 15 Jun 2020 12:55:52 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 15 Jun 2020 12:55:52 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Mon, 15 Jun 2020 12:55:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhOyfp3bxjsDBMupFEzyAW8FHOkLyttsHfx6WicI0F0fK/QGlR90cuO2Z46x8vshKpxaYLo3BbRjWZIdr9qEM97IneaOGOGJQYqxHxnrApl93ltWiSF3TlM43EM/eME/EX4bp4R3BAyT28FNzSKDWsAP/GOCy9nJVlNePBq3SqnhIpIwqQCuUVMYIfvDR/BI9jdzYwD5yPBJ3nnPFJj70jDe0LPMdwxv94om2N33p+wXFxDqjIXhDFDNSgK6f2zTgUJ7SLz8CrfZq8x9PKQaxPHGfgddLs+lktnhBUIzsI60dl2a6zXT+hDjYGY2ngCNnXYtLKkXeWCZ5UXLWfS3zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIIrA2IHfY4PIKmELJrOc1V70oay99ef3PSdG35Oz2A=;
 b=I6dASh5xyRAjg7ebLIsOcTrMxfYCPwVGw/uiroGc5zPkjq7K8d8VsBD0+z9qvaouLdUIUHjZDdIck/6t96thy5JgGxq8PG9F70vWJ624CNTqwWsG9PcQ++xBQSrHIsFUems2SN+in/ahBKiUs4KKsmiRCmBGtFki+gVhHe0syiDslYRsvnD1yUhM8Z8EzrPp7CnPslvALFGMeeDTLBUASJNo84MmyipJ4ixa82Cnf4z1vbUetOQHkBa2oh2+cpWWRsoCb7m+uvUZy+7KB0ney9mlsutdJMo2rz/2reIfPg/r1VvOH/XJr+PAlboHUbFuQYnIoTC2ERMyci1H1kW3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIIrA2IHfY4PIKmELJrOc1V70oay99ef3PSdG35Oz2A=;
 b=eW4MH3t+Uk6gwFDmDD2/3G/BqOVwbCTNeKi9OUYGX3yDkh3Qkg118VXcXHTepGjC1tNK+jx8XJ8RyahC3M1uNkwIQ/m01sklJAbnaSo3Y/4Gygnw+BsNhmGP6VeIVE9VtqTGqauccrvIAl94R9SiyFTOeWXNWh3FlnWWkCp1GDM=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4682.namprd11.prod.outlook.com (2603:10b6:303:2e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.21; Mon, 15 Jun
 2020 19:55:47 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%6]) with mapi id 15.20.3088.029; Mon, 15 Jun 2020
 19:55:47 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Fix updating CID, PID, VID & CRPL on node
 attach
Thread-Topic: [PATCH BlueZ] mesh: Fix updating CID, PID, VID & CRPL on node
 attach
Thread-Index: AQHWQwXKG3yQnkQF/keoq+5ni3ZKrqjaF+CA
Date:   Mon, 15 Jun 2020 19:55:47 +0000
Message-ID: <32674f54152dea5d1d1e602c1f573d2490d847de.camel@intel.com>
References: <20200615111152.29089-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200615111152.29089-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3fca30c7-fecc-4f79-53ce-08d81166192c
x-ms-traffictypediagnostic: MW3PR11MB4682:
x-microsoft-antispam-prvs: <MW3PR11MB46828212E8B0FFE5B702F623E19C0@MW3PR11MB4682.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4pmgY5dwclVw6qCqFLpMcXq4vt8oWp/WuYZ64EzoiENBJf4xqNFY5VJdRhHgfO/oEcxi4LlWSTIhNdiWaxy2onlDMuzQ41bV6sMGDfJXvGq7xGX6g1/OAQD0+cPnGnaOu8Vm66tNAcVxLSAF8TaYkGXPx8WWdWwQSB7UuICMSRD7mjidhwv1H4bqOEWCy82C3egyywJIfqUSak5z6wWPVbFJXWQU41OJHF1wfSGNbWLp3jtk7noSeZBROZ4Rk4kJFpjN7cngnwojnMCK5J33IXZIxFlO7oa26OmZCOwZ1XstSJfqZftJHc5ZqcRDusH1GKURdjV1nQtGr6uLr0dyVQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(346002)(366004)(39860400002)(396003)(136003)(71200400001)(8936002)(6506007)(26005)(66556008)(66476007)(66946007)(76116006)(91956017)(316002)(66446008)(64756008)(186003)(110136005)(86362001)(8676002)(6486002)(478600001)(6512007)(36756003)(2906002)(83380400001)(2616005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: TrGLmMd4W3qMoXf3b/fQLOOcMGPUK3k0PXATqjnTUMOXJx7u/7zh0cDzTrWbsB7+YOeqtF/6VythVQWLr88lEvhpPcSEyzUNGqXXkIvb0wxr/EZiCy/0Pr1u98d+j04ap/f7fWyan3GyP/aD+GsHs9xxeB5RdmZssoNSZ6NS5G6/5V9MMyeh7AAf8pPTN+yyi5swDBCiIOF1eMOHVSmGHdmK5PXs/Ed1YtqGR4oaOd3gStV8CUVvG1X8tXP5P0juQMWDSSCBHSnJ5qkr+F+ROCbUhXBDY0VvjCrz/ld749a2Mm//O6RijLUI9V/rm2NFgyCf76BArk3E2legSpGj3r17kwn9USFJC4uy0CwkJdu4JyUKtQdYKzuu9Z/xQyUmW3rSbYlvALjads8krp7p24O7MBiuQ5j5+//a0F59QrvmWtfMSqiWz1S15xyoW9ysiPUSblteZmrPNHY1YzNjG/lavU+KFolxMAnChg83Yq4=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C7554E0F6B21554DB89D557F3873FCCC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fca30c7-fecc-4f79-53ce-08d81166192c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 19:55:47.7964
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlbgHOPvj++h/gxOJY8mBsj+ccCBxzjoO6FKSXqXn7UYjHZ3HOn8e2RQe31VRJ1ebE00AGizeB9ffMXJTE0bKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4682
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzLg0KDQpPbiBNb24sIDIwMjAtMDYtMTUgYXQgMTM6MTEgKzAyMDAsIE1p
Y2hhxYIgTG93YXMtUnplY2hvbmVrIHdyb3RlOg0KPiBJbiA4YTM4MjI2MjEyNTc4N2NhZjM4YTFm
ODAwZWM4OTU2YTFiZjcxZDg1LCB3ZSB3YW50ZWQgdG8gYWxsb3cgdGhlDQo+IGFwcGxpY2F0aW9u
IHRvIHVwZGF0ZSBjZXJ0YWluIGNvbXBvc2l0aW9uIGZpZWxkcy4gVGhpcyBwYXRjaCBtYWtlcyBp
dA0KPiB3b3JrLg0KPiAtLS0NCj4gIG1lc2gvbm9kZS5jIHwgMTAgKysrKysrLS0tLQ0KPiAgMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9tZXNoL25vZGUuYyBiL21lc2gvbm9kZS5jDQo+IGluZGV4IDEwYjQ0YzhhNS4uNjE0
MGZkZjlmIDEwMDY0NA0KPiAtLS0gYS9tZXNoL25vZGUuYw0KPiArKysgYi9tZXNoL25vZGUuYw0K
PiBAQCAtMTM2NSwxNiArMTM2NSwxOCBAQCBzdGF0aWMgYm9vbCBhZGRfbG9jYWxfbm9kZShzdHJ1
Y3QgbWVzaF9ub2RlICpub2RlLCB1aW50MTZfdCB1bmljYXN0LCBib29sIGtyLA0KPiAgc3RhdGlj
IHZvaWQgdXBkYXRlX2NvbXBvc2l0aW9uKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHN0cnVjdCBt
ZXNoX25vZGUgKmF0dGFjaCkNCj4gIHsNCj4gIAlpZiAobm9kZS0+Y29tcC5jaWQgIT0gYXR0YWNo
LT5jb21wLmNpZCkNCj4gLQkJbWVzaF9jb25maWdfdXBkYXRlX2NvbXBhbnlfaWQobm9kZS0+Y2Zn
LCBhdHRhY2gtPmNvbXAuY2lkKTsNCj4gKwkJbWVzaF9jb25maWdfdXBkYXRlX2NvbXBhbnlfaWQo
YXR0YWNoLT5jZmcsIG5vZGUtPmNvbXAuY2lkKTsNCj4gIA0KPiAgCWlmIChub2RlLT5jb21wLnBp
ZCAhPSBhdHRhY2gtPmNvbXAucGlkKQ0KPiAtCQltZXNoX2NvbmZpZ191cGRhdGVfcHJvZHVjdF9p
ZChub2RlLT5jZmcsIGF0dGFjaC0+Y29tcC5waWQpOw0KPiArCQltZXNoX2NvbmZpZ191cGRhdGVf
cHJvZHVjdF9pZChhdHRhY2gtPmNmZywgbm9kZS0+Y29tcC5waWQpOw0KPiAgDQo+ICAJaWYgKG5v
ZGUtPmNvbXAudmlkICE9IGF0dGFjaC0+Y29tcC52aWQpDQo+IC0JCW1lc2hfY29uZmlnX3VwZGF0
ZV92ZXJzaW9uX2lkKG5vZGUtPmNmZywgYXR0YWNoLT5jb21wLnZpZCk7DQo+ICsJCW1lc2hfY29u
ZmlnX3VwZGF0ZV92ZXJzaW9uX2lkKGF0dGFjaC0+Y2ZnLCBub2RlLT5jb21wLnZpZCk7DQo+ICAN
Cj4gIAlpZiAobm9kZS0+Y29tcC5jcnBsICE9IGF0dGFjaC0+Y29tcC5jcnBsKQ0KPiAtCQltZXNo
X2NvbmZpZ191cGRhdGVfY3JwbChub2RlLT5jZmcsIGF0dGFjaC0+Y29tcC5jcnBsKTsNCj4gKwkJ
bWVzaF9jb25maWdfdXBkYXRlX2NycGwoYXR0YWNoLT5jZmcsIG5vZGUtPmNvbXAuY3JwbCk7DQo+
ICsNCj4gKwlhdHRhY2gtPmNvbXAgPSBub2RlLT5jb21wOw0KPiAgfQ0KPiAgDQo+ICBzdGF0aWMg
Ym9vbCBjaGVja19yZXFfbm9kZShzdHJ1Y3QgbWFuYWdlZF9vYmpfcmVxdWVzdCAqcmVxKQ0K
