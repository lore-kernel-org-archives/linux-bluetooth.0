Return-Path: <SRS0=u1pM=5S=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18064C43331
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 01:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEDD720721
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Apr 2020 01:33:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="M4K3/9CL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732660AbgDBBdN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Apr 2020 21:33:13 -0400
Received: from mga07.intel.com ([134.134.136.100]:50364 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732537AbgDBBdN (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Apr 2020 21:33:13 -0400
IronPort-SDR: kBiCVrRAAew75Y3rX0Ty3jjVp8AoaG5U/5CKP4NaTcBErgydwtJwVusXyX/xPtA9Le6q9iaOVN
 bfMHhb7jigbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 18:33:12 -0700
IronPort-SDR: x87l/1o4yppsvsLSO2qfQHw21lpCWQwuCOjGtFQmYqOgivBJze/lkn2R3gdG8XA5GVimyE9/hA
 W34MrVSdyeTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,333,1580803200"; 
   d="scan'208";a="242909955"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2020 18:33:12 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 18:33:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 18:33:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxYVcEB6QW1MkdN+OUjZLcNZYfhNgOsYVMDUlncdY2ngYDpKcL8S7QaSr8OVPn5jCRUDi4G4CGQZnTra1vDtPVSn1Uf8mv3QMaEo+x4tWoaKEe8VRmsdGblZEe7a9PBNDIqpipmcvODCMOk+823MovZZo/AIw1WSScUT0r8G4YzTrk/BQYtJosnudKoD1CstrkTeePh+7H14kk1QdW59F8Uu6lFKl/QSPc+n8VaoT/oQi6v3ky4Zs5KT5zrVt0zPez9TuF7WM/5ChWKtM6QBMusT1KlL60ET+52Nosc8fZ8P4q8ECU7SrKOPg0P8ToiS30Mnc5vErqF1zPJxAFzf3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiI6G5rkH09EEHQVZLPoO4auoNuY5uYwuioRTKBf/TU=;
 b=iMJQcN58N60ilUgK4ww9+pITyhYFn8U73S4ipWPiM3C81N4Pk0iGhy3K6yjp7vuo71I4lQs5bi5b3gC+eFW2kMkThKmXnEVTPXQO+FJ4hnzaYRLBvvsr6uGPyptrLbaIZ0xipGcE+0uKWeHSPj2Df+NVP8pmo4NCQT9DdvSni5DMzGw5LAOqM4AUc3OzIkDfaWAznsS134mPUq7VTOpq3THA4MXamr4IkWQdI1d06eYFXpr6+1Cqd2hUcENL8u6mNJxKUKUNukxDVbR00fSVuvV3Y2GYi5h2mKY3PJ01yzIkeTJv6n6ErEL5PzuEMKVhXcp0az8LhHE6gSNMsplaBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OiI6G5rkH09EEHQVZLPoO4auoNuY5uYwuioRTKBf/TU=;
 b=M4K3/9CL2yI1BUD/7KF97zgUpi5QpU+u6JdmN+HJ9J1BQWP2ZySiTjT8If0fQFaRVXkrnA9zXDS+jxHtUoDBUSVaHth443z0/42obAerOcqJnSR/HJoqnsjLEA8L6wIJC5rNoNDJkuFQC1cKPBPKFdGfg6IF+8ui7hf7m8D842s=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4763.namprd11.prod.outlook.com (2603:10b6:303:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Thu, 2 Apr
 2020 01:33:01 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 01:33:01 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/2] mesh: Move SEQ_MASK define in mesh-defs.h
Thread-Topic: [PATCH BlueZ 1/2] mesh: Move SEQ_MASK define in mesh-defs.h
Thread-Index: AQHWCIJdlhkB+FulQ0e6IoZhY78ECKhlDEUA
Date:   Thu, 2 Apr 2020 01:33:01 +0000
Message-ID: <2c8a8ff08d3fcf31328be9c28b1ba2b6d1ef9be3.camel@intel.com>
References: <20200402000436.23209-1-inga.stotland@intel.com>
In-Reply-To: <20200402000436.23209-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e464f79-9d69-48b5-2959-08d7d6a5c85e
x-ms-traffictypediagnostic: MW3PR11MB4763:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB4763385DF4972243DD060F8DE1C60@MW3PR11MB4763.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:415;
x-forefront-prvs: 0361212EA8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(396003)(39860400002)(346002)(376002)(136003)(366004)(66556008)(110136005)(81166006)(8936002)(86362001)(6486002)(186003)(316002)(81156014)(26005)(36756003)(478600001)(66476007)(76116006)(66946007)(5660300002)(66446008)(71200400001)(8676002)(91956017)(6506007)(2616005)(64756008)(2906002)(6512007)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +NwanAGDceDGMXOuyyjrhzQG6bxNbwHA9e+DvEIs20mgB58QQSzJJN1xv2JmY7bc55OHeglIYVM68DHQy2VkMATVQY3HRoJAH9Z+sHtqUskX4Z4sPwen8kD8yvfyvXlehuu1FZAQRDyOssFV52Ucv0lLTfpjUz/OUXHNY2Z2iaa4o4PERehiRmivgHgfzRPJKcAHxTGT1Sn0V9PVDxMKXMKLEg9uAixWQSwTe0TEaOz6zLUUvrZ6AyDzyLCMy1JHb/LJiLsY/vxAOPVKcCaPjWjfQYg2fu0WWR70Id7sopcAATKWG7ab2CwpAh2yzH/9CAbT7Bvkv6jj+wqBwjN8NY1KcSAh6lpyNglfOrbih4m2x3GNHUROd4bi7uDDXr+TdOLy9O2p8ePRxeUMwPWnzWNcnjqD8xQZ4X06W/naSYkr/5DES6JRHUz6pcKy6VmI
x-ms-exchange-antispam-messagedata: 3YvXhqMjrqtpJoqxZj32VC44FolOUr+7+5JSJVbbLr7ewZ5+yVTnLvwRh8On53LIL+Ot+0ffvyJ4mBYhHmAhe1XbVvdUthwgbv9/uo+RV/3W6rq+Npk2i8cm1iimuP9O7mn+ty+1tU91ECRqbfCs0A==
Content-Type: text/plain; charset="utf-8"
Content-ID: <1BE01D6A44879247BEB7172BE441FFAE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e464f79-9d69-48b5-2959-08d7d6a5c85e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2020 01:33:01.4522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ahMCho9ImaAHREF1lzGa65nGjPcbe/kyTqwFja38iMZ+MHAjdBMrwIr/W1/7/4XMg+F2mjPeqHfzI3JLvNawew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4763
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgYXBwbGllZA0KT24gV2VkLCAyMDIwLTA0LTAxIGF0IDE3OjA0IC0wNzAwLCBJbmdh
IFN0b3RsYW5kIHdyb3RlOg0KPiAtLS0NCj4gIG1lc2gvbWVzaC1jb25maWctanNvbi5jIHwgMSAt
DQo+ICBtZXNoL21lc2gtZGVmcy5oICAgICAgICB8IDEgKw0KPiAgbWVzaC9uZXQuaCAgICAgICAg
ICAgICAgfCAxIC0NCj4gIDMgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDIgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMgYi9tZXNo
L21lc2gtY29uZmlnLWpzb24uYw0KPiBpbmRleCBhZDJkNGQwZjguLjE3MmUwZTM1NSAxMDA2NDQN
Cj4gLS0tIGEvbWVzaC9tZXNoLWNvbmZpZy1qc29uLmMNCj4gKysrIGIvbWVzaC9tZXNoLWNvbmZp
Zy1qc29uLmMNCj4gQEAgLTQwLDcgKzQwLDYgQEANCj4gICNpbmNsdWRlICJtZXNoL21lc2gtZGVm
cy5oIg0KPiAgI2luY2x1ZGUgIm1lc2gvdXRpbC5oIg0KPiAgI2luY2x1ZGUgIm1lc2gvbWVzaC1j
b25maWcuaCINCj4gLSNpbmNsdWRlICJtZXNoL25ldC5oIg0KPiAgDQo+ICAvKiBUbyBwcmV2ZW50
IGxvY2FsIG5vZGUgSlNPTiBjYWNoZSB0aHJhc2hpbmcsIG1pbmltdW0gdXBkYXRlIHRpbWVzICov
DQo+ICAjZGVmaW5lIE1JTl9TRVFfQ0FDSEVfVFJJR0dFUgkzMg0KPiBkaWZmIC0tZ2l0IGEvbWVz
aC9tZXNoLWRlZnMuaCBiL21lc2gvbWVzaC1kZWZzLmgNCj4gaW5kZXggOTM1M2Q3MzUxLi5iYmRl
NTMzMDMgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbWVzaC1kZWZzLmgNCj4gKysrIGIvbWVzaC9tZXNo
LWRlZnMuaA0KPiBAQCAtMTEwLDYgKzExMCw3IEBADQo+ICAjZGVmaW5lIEFQUF9JRFhfREVWX0xP
Q0FMCTB4N2ZmZg0KPiAgDQo+ICAjZGVmaW5lIERFRkFVTFRfU0VRVUVOQ0VfTlVNQkVSIDB4MDAw
MDAwDQo+ICsjZGVmaW5lIFNFUV9NQVNLCQkweGZmZmZmZg0KPiAgDQo+ICAjZGVmaW5lIElTX1VO
QVNTSUdORUQoeCkJKCh4KSA9PSBVTkFTU0lHTkVEX0FERFJFU1MpDQo+ICAjZGVmaW5lIElTX1VO
SUNBU1QoeCkJCSgoKHgpID4gVU5BU1NJR05FRF9BRERSRVNTKSAmJiBcDQo+IGRpZmYgLS1naXQg
YS9tZXNoL25ldC5oIGIvbWVzaC9uZXQuaA0KPiBpbmRleCA2MDM5NmRiZTcuLmJmYzgwNjRmMyAx
MDA2NDQNCj4gLS0tIGEvbWVzaC9uZXQuaA0KPiArKysgYi9tZXNoL25ldC5oDQo+IEBAIC0zMSw3
ICszMSw2IEBAIHN0cnVjdCBtZXNoX25vZGU7DQo+ICAjZGVmaW5lIEFQUF9BSURfREVWCTB4MDAN
Cj4gIA0KPiAgI2RlZmluZSBDVEwJCTB4ODANCj4gLSNkZWZpbmUgU0VRX01BU0sJMHhmZmZmZmYN
Cj4gIA0KPiAgI2RlZmluZSBDUkVERkxBR19NQVNLCTB4MTAwMA0KPiAgDQo=
