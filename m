Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 876A1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18B4A2071E
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Jan 2021 19:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbhADTvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 4 Jan 2021 14:51:09 -0500
Received: from mga17.intel.com ([192.55.52.151]:50328 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726098AbhADTvJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 4 Jan 2021 14:51:09 -0500
IronPort-SDR: j2Gz1UL2a0UQbIcQUGdcfJfasYrlV9hjNP+KPa71XGvE7zvgvv7WZcEL7JlfndwH6x/mGRtDfJ
 JgjxjvCWcpmg==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156786787"
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="156786787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2021 11:50:29 -0800
IronPort-SDR: TDZJSYFuGhNnDVT79by8Vs+zyfcadQRnM57WfyneGhoXBGYxCU7oBslFZFzXiGcTkaTyE/Lyc5
 FaLz6qPtj1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,474,1599548400"; 
   d="scan'208";a="395003349"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP; 04 Jan 2021 11:50:28 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 11:50:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 11:50:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 11:50:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 11:50:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WnKdI3X33xZkQft3KcxcjgSUL7dDd/40K57Wyr2t7BCZCQ7tyR/JHH3KB4Q94p1Rkdh+I841C2Z8E/XRXvGXRBVMvcxUSs9TJDJgAoPfXndGg36Hf1OYhgxD2PvMY6DbthDHulfRgwoxF0SrzGdstYiVOSww1EQdjYFXJlp+rCMnDXWTfsg2JgYBp9aMTL6V2TUzES7H8jcyHMJmFcX5z2mfGBtsRp5pkSYvHcDeQvWElyo5uLT2IEHco2SnmjjUlCzYARJ6H6via6oLBJFjRE40mNUkyCbeCfETDSGaRUvtZDIwdTlLdJHXDA56SJ8+C0MlYus5alxutriP/B+9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSPmQusc/nLkhZ6zA5HtCLu5xEqcRI4EFLVRqh9go1I=;
 b=GVYRkRxLYEVUyelA9BGIuB0gl8k6/55WxLsZu+SYFOJHqxAmApKJO+j30biYwoDJEOHTkoJ2AYpamCUeWqr+xocaqJE1AVWzcKF0CQ7EOdddG/FHxHPpCGN6XnwgCF3fNrpoBvrQYNPnrJAV+m5LaM+jMr63mbJ1Fw64nzO40VvDTwzFcGWHkBg4AkW6bJShcBma/vgADJgIV37CaDmTKhBJYG+XpHNgjl17Lup0ZIT0Wgd8fcr5UqP9zqIKpkNGbjbFRhXO/2gyb0Qj7rVzoZGiyswA+HBlrTtLZP0WR7su1WahE9bk9S5ndm6GAOLnyJhQm8PY3JIXEuhudu1tvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSPmQusc/nLkhZ6zA5HtCLu5xEqcRI4EFLVRqh9go1I=;
 b=K5cLFwSBGOf8uinrM0kxPoYoj4bSzZpRG1/PX+Gxu0YVCdTGNpnFI54up7N4BEnzEvPJAhQC007DVg1UpEHJLoy0B1V+FYIB4qOpA08knT/vGjjh2FlJU2sMwA4pz+x5gssft9wgqBncnftLGuIyDRgUNKCCkc2FqL1H0grPv08=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1311.namprd11.prod.outlook.com (2603:10b6:300:2a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3721.19; Mon, 4 Jan
 2021 19:50:26 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%9]) with mapi id 15.20.3721.024; Mon, 4 Jan 2021
 19:50:26 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ v2] cfg: Add check for newly used function in ELL
Thread-Topic: [PATCH BlueZ v2] cfg: Add check for newly used function in ELL
Thread-Index: AQHW4tGCvlDb0DDLGk+4H8vXr6X40aoX4A4A
Date:   Mon, 4 Jan 2021 19:50:26 +0000
Message-ID: <37981ea9ebc880146441915878a52d84324ac17a.camel@intel.com>
References: <20210104194013.580654-1-brian.gix@intel.com>
In-Reply-To: <20210104194013.580654-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.43]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6a0b40bd-35dc-4f30-44d7-08d8b0e9fb9d
x-ms-traffictypediagnostic: MWHPR11MB1311:
x-microsoft-antispam-prvs: <MWHPR11MB1311942818222EB9423BECCFE1D20@MWHPR11MB1311.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NPICzyeIqKKfOHiw4Lp/LjJGpOyxYl1OIza4BLHp1jw1SCHkBWEvtHw39ACFANzsfAQZHSpws3TJWzGJg9dbzS3jy9f/UWGDFvfXOKQhHqCaBIKPt7U1w8x9p4T/J1HcwvmTwMz34/gbiJOuOVzkgl3z1MCXQUPl2qNEZD08hdql/r/I8xDbzWfn0/u5tCOHvuQ0GTPcZdu1ZfzdzNqHkLY5d1LCj9RjhPeTBGDTmtE3FfhNx6ALl1z+WO9vp73dMVGtU13kjEhd+YidkMNkvSCc6HfE9XoRCTewUUTwirBgW1kB8AXkvBPLIDJTxlo8CY9s0WZCtODZWn8hq7deyV6YxoA2EhHLnBUEazdgT0dGQBj8pJysoh/X8ZE61OVGa14RWx/ZSDFzEHe1DIe9uQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(6506007)(8676002)(66476007)(2906002)(5660300002)(36756003)(83380400001)(26005)(6486002)(186003)(71200400001)(478600001)(66556008)(66946007)(316002)(66446008)(64756008)(91956017)(4744005)(8936002)(2616005)(76116006)(6512007)(6916009)(86362001)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?b3ptU1V4a2tXUEpUL25aQTlocEl5NVdYQitiME9ROWJCbmo0ZXhFZjA0Wldi?=
 =?utf-8?B?ZHZVUnlrM3kyRjFCei9iY2dvVklZMmpwUEpOa2RpSW9KeTFlenNQSDdjMHNr?=
 =?utf-8?B?SkFwMEhyNkljRnNWNXBEWGpNZnI1SFN5ZDVrWTNpc3EvVGhhdVFpWUk5eFBE?=
 =?utf-8?B?ckRrRHBiRUF5M3hnWFZkUDFGYS9oSEliUWFJTTR1TGlpakVmTlF3UWt0cmNG?=
 =?utf-8?B?SnJ5MkhrdUVZa3JGNC9Wb1JGcU1xaDhBVmdaYWRCa3Z5VisxSG9GMUR2cnNH?=
 =?utf-8?B?WHYrZVJLblBFWnR5NWt2eG5ZMTlzOWRDbk4yUExVMmdBS3VPTmtPaVZnVDRn?=
 =?utf-8?B?VlBmbVY2MkM4S3NyTjJna2M0M0RZMENmcUtQcGJ1YUpZcGxZeTJ4YzdyNVow?=
 =?utf-8?B?aTdRS2l3ZHl0Z3M1VXZhZnRwM1Z3azVFa1cwb09kSERGVWVtbDZ5YTJuekhD?=
 =?utf-8?B?RWkyVE83ZkIwdWx3UEtXYlpvVVBwdVVtcFZ6V0JlNlh3c2ZLZUtZT2JUbUJy?=
 =?utf-8?B?U2VRUDBZYUNwdnZXNnVJd2NyS2lMREJnSytvRUNOM1pBSGFhZzhBdG95anB2?=
 =?utf-8?B?aVRDNkNtSHBaTnl0VzNuMVJCSGNML21qSlRsZW1ZRTJ5a0NDNFhUUVFLS0hI?=
 =?utf-8?B?c0tSV2JHVFZpS0dyZGw4ak50Q09tdDdWU1Y0ekFQNVNueFppYzluLzF1RllW?=
 =?utf-8?B?QXJhbVhmNGxXZkp0UkRRN2NZNkJQUWxwbVk2Sks1RFRxOXlqZ1dYWGV3VHBl?=
 =?utf-8?B?QUlDSVRsZmFYekRqaEdaWEhyd25lK2dySG9USnZTNEVZeVE0azV6dFRrOEx2?=
 =?utf-8?B?b1Zoek1DRThOekpKSzMwYTBVV0dINHZpcFdTelZkajRMQjNlRmFQU3M5ZjVk?=
 =?utf-8?B?YktzQWRHU04yblZzZ0tLS29Eak1zUEp0Q01lZ3lGS2VSQk9Mb0g3cnJtWnV1?=
 =?utf-8?B?ZFlrbTJyc2xCclhlVmpqRW1NLy9USkFFWlZHQ3IxdkR5ZmczRWdheWFlL1RZ?=
 =?utf-8?B?QTFJWWJtQWtUajNFNVlFRXpOeWo1bzZtSm1DSHhzL2ppbkFKUnI0TUdhZmhS?=
 =?utf-8?B?MWFyWkxCdlp6K2dqOGdFU0x4elJMOUNFYWtjUGtqVXNQVUZuVUJaRkVtTm1i?=
 =?utf-8?B?MktNVzJVdlFqMUJtMU8ycy9TSVFiUTk1NmJ6Qi9LU1ZvRjRGNUdJVGZGYUQy?=
 =?utf-8?B?UVBQNVJTTVloVkVnRDgyTmx5ck93NGljL3huN25wMTNndXErdDlYb2ZTMVlM?=
 =?utf-8?B?R2JKRWJtOUhZb2E2bG9XUUZDc203Ykgyc012WEZBWTZ6SEdZWTdlbjI2aHhJ?=
 =?utf-8?Q?rZVCmrOpb1bULqtfwHnmsmI5uwPTi0rs40?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACD7605B05D2584C86D8A115BC776E73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0b40bd-35dc-4f30-44d7-08d8b0e9fb9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2021 19:50:26.7305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R/3Ll8Jdc+EqJl7EyO56kNsRP+++9zlNMUDXgT2mnAXTGtuO0M2eeWT4GhAIqna5RJJmRao7aMiyAYXpONv0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1311
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gTW9uLCAyMDIxLTAxLTA0IGF0IDExOjQwIC0wODAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IEVMTCBoYXMgYSBuZXcgZGVwZW5kZW5jeSBvbiByYXdtZW1jaHIoKSB3aGljaCBuZWVk
cyB0byBiZSBhY2NvdW50ZWQgZm9yDQo+IGF0IGNvbmZpZ3VyZSB0aW1lLg0KPiAtLS0NCj4gIGNv
bmZpZ3VyZS5hYyB8IDIgKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykNCj4g
DQo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMNCj4gaW5kZXggZDYz
NDdjMDk4Li42ZjQwOTZjODggMTAwNjQ0DQo+IC0tLSBhL2NvbmZpZ3VyZS5hYw0KPiArKysgYi9j
b25maWd1cmUuYWMNCj4gQEAgLTQ5LDYgKzQ5LDggQEAgQUNfQVJHX0VOQUJMRSh0aHJlYWRzLCBB
Q19IRUxQX1NUUklORyhbLS1lbmFibGUtdGhyZWFkc10sDQo+ICANCj4gIEFDX0NIRUNLX0ZVTkNT
KGV4cGxpY2l0X2J6ZXJvKQ0KPiAgDQo+ICtBQ19DSEVDS19GVU5DUyhyYXdtZW1jaHIpDQo+ICsN
Cj4gIEFDX0NIRUNLX0ZVTkMoc2lnbmFsZmQsIGR1bW15PXllcywNCj4gIAkJCUFDX01TR19FUlJP
UihzaWduYWxmZCBzdXBwb3J0IGlzIHJlcXVpcmVkKSkNCj4gIA0K
