Return-Path: <SRS0=Rej4=6X=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD1A8C28CBC
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 13:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761E3214D8
	for <linux-bluetooth@archiver.kernel.org>; Sat,  9 May 2020 13:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="E+BUC4Q/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEINuB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 9 May 2020 09:50:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:23965 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgEINuA (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 9 May 2020 09:50:00 -0400
IronPort-SDR: QrMS/saZrLjiMnXaxToZFtuTkzgspKpfSYD77bECBOznnGtdUEWXdrznTiY4AxFJYmtpVC7qpF
 RWCOrtvm/vSg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2020 06:50:00 -0700
IronPort-SDR: eWIslaKqcJ7gZPEBN2YMN3eddCbm3vlUcbQB7Pjq7U32W51cMbBbkBcUmKqSW5/Q1eHfAouPSH
 lwBiYSYz9kXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,371,1583222400"; 
   d="scan'208";a="462612045"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2020 06:49:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 9 May 2020 06:49:59 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 9 May 2020 06:49:59 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sat, 9 May 2020 06:49:58 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.53) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Sat, 9 May 2020 06:49:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kFyZZO2B67YH3zjd3voEfJShRF3urTTVR1MzbXLGXStNDIVwQmRUTVU0gPqaZHbK+EacmTEY+WcOGDjR3CLftVX/crQCiJVbFVrGEJ0ffLDxrxgUB/LcqrDaHn/uUwxHja5Q5vK6AlDW75nX6jng9/FckwGCNB7wnu5P0H9k2HY2m3q4FtAC5WVHEChEJV1tjvT4rau+bx3ql5bPwmu5vRLEPw0K8GDeTUh/7Ilo9CvK1LhTtRYS7o8Gp5pOsWq5kLNi9pUZe+WCfXSN0ESMgMJstya1NwDpBpMjAhEouyDEbOfAwQhYbcgo8dlhlwDhDy47gVIkgdPOBPtvj2I1aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxDtMBnrxCmONfrUdYhwwyLHznrLdKIuVStDqg8GdkM=;
 b=RuLLbJYX5mz8CjtBVnkw2NIC06pCyfMtpyWRgqdYK3Z+r5V1fcQk6AYNqb23EjzJA3zj7TOuXAfltDzZzFdH8iVQ4RhybIycWTnwfCkfVnd0oVbOV83baNt357heRGZYwOkWVIo8etw/QdkteQ6stAHmf9qpyHhNV/mRpPFePFQ2VxnB6dYMo43gZk4DYd0n/57J02I532INodBCQfbBSwayCmIv5sfn57pMhz3cCNuk0d3r6XtSZ3wAAFqYwSxvn46NC7ZcKjbfvy4BGRU6jy/sZ0QEooTA6ucgQWvpbNfzhWx7H1qnHqbv7/LHJgkWkuTyb7m2sna81+M5IgFqIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wxDtMBnrxCmONfrUdYhwwyLHznrLdKIuVStDqg8GdkM=;
 b=E+BUC4Q/mIS1PMwUWL/Jck90Ow3xmB8zTN9JGb3Jl03q0nJGReNq4FXRJ91NqwacGmqUAecB4lyA5s+MAXoPlGW37QJ3md3ODL93SguRjJnLIIhx8y54hjIVIRZk8Ryqvb+dL2Pd0vaE7KfJ6Sqdvfi/acDUJEDy8vty1b7fkHI=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4540.namprd11.prod.outlook.com (2603:10b6:303:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.33; Sat, 9 May
 2020 13:49:57 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.2979.033; Sat, 9 May 2020
 13:49:57 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/4] mesh: On node attach, verify element/model
 composition only
Thread-Topic: [PATCH BlueZ 1/4] mesh: On node attach, verify element/model
 composition only
Thread-Index: AQHWJZT4F/laVtXs8Uu/5bOGRg3mKKifxheA
Date:   Sat, 9 May 2020 13:49:56 +0000
Message-ID: <baf587ce6f45ab88a2ae9ad04acd1ee84ac6d21f.camel@intel.com>
References: <20200509000024.5704-1-inga.stotland@intel.com>
         <20200509000024.5704-2-inga.stotland@intel.com>
In-Reply-To: <20200509000024.5704-2-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3344797f-1aee-4069-7cc3-08d7f41fdc19
x-ms-traffictypediagnostic: MW3PR11MB4540:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB45405EE4B9AE93A06BC77CCAE1A30@MW3PR11MB4540.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03982FDC1D
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODkLlQZIilu3mhcUlDU5ogqjtoylftOUI5LWs7525FTqkYR81B8MuoWDZ3jX9Y0T1QYV84pml/ijtT0IlbVqTGyGcM88ssUEDRgXCP4TdL2mQ+AczlqUvUooGCbls156AVk2wolDh9/KlL845cgkqyN+nY8Dt4m3zdV6nhv7Jl95zFviFkM7mY+CD261mFXg3OrrdsEk1znRKl9bHN6sxcfOHdKSdGsbv5qYdTo62Ax+5HeTcIET2z8V3mO5Oxxusk18qJgBsWmWsyVm6OqxukAuQ1EyuKih9cZwMGIDVL6mzb0M7fCcOlla8tXs950axalp9r1Y8D74zhN8zzIFejaYEKPzVOX9P64Lr8MYechvfj/4hX68I/8i5tDrOF4SavN2tjhhThc4vma2e8G/Kqt66Da7AjCsR5OZgEz16OEprWJUpPtTVk/pPCpvFm6+GS5I0qi1V/ZGnhrRn4Avg+dCbivB6Gll8nLPYeTzkPEwrmKhvTfxtSwJ2msgozlhzl1Wcr+fMEHxYyzRymwUOA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(366004)(346002)(396003)(39860400002)(136003)(33430700001)(8936002)(6512007)(186003)(15650500001)(33440700001)(26005)(2906002)(6506007)(71200400001)(36756003)(6486002)(316002)(66946007)(110136005)(86362001)(91956017)(5660300002)(2616005)(6636002)(8676002)(76116006)(64756008)(478600001)(66556008)(66476007)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CoJdPExxOLHnS/HuhiyVEFoEp/WwWeDOU90nS3HOPNcLhHmatZd+EckFlNZbJ+TU2IQl16AtBPsfMYQnjTZ6UPuVCs3AOYlXCVVtiSb9Ip5OitdO11Hvi8AAhbUj9qSdmJbvUAhGDPWFOqiv2vS0k0MPTzyZ5ekFGvVDx5iNiRwc9FEystUfwZztA1x7ccYV3XfT/F798nFTZlxg/RQF5hsAb0jduyvBIy0LKi7OsHlfh04IKzUuZhmiBw/3T+JkCQ9hJQzQxCvKxwEynuWaHetq+Rl41yjrdaxbGjKAWSHFMWjYaHGRSsjSePfAypE8GpGdd3yEg/E06jx20UFfvGfZzhB9+7sqaZrWe5ThR+xMrSH06nb+PVKCYZQHR4vWabnHFFA4YH9x5G3Ph0gJ1iHPH30h6o9oA8pMO2PaPwDtWITWDBtzpXSXvh4fzisQyNAJS/JW/Sf7/U0zmzy3y9lwdM7EP8VgGK8MmX5dZSM=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34C57C40DB14C54B944185941E12FE20@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 3344797f-1aee-4069-7cc3-08d7f41fdc19
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2020 13:49:56.8990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7xks3eZB0EhbZuTvjVijqky5gncuN1AiiZhBcLRLjeS/c1k/qEdlHI/1EJ4vYjtLmw0lESBGiJv7128Jt7ZRTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4540
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbHlpbmcgdGhpcyBwYXRjaCBvZiB0aGUgc2V0IGVhcmx5LCBkdWUgdG8gcG9wdWxhciBkZW1h
bmQuDQoNCk9uIEZyaSwgMjAyMC0wNS0wOCBhdCAxNzowMCAtMDcwMCwgSW5nYSBTdG90bGFuZCB3
cm90ZToNCj4gV2hlbiBhdHRhY2hpbmcgYW4gZXhpc3Rpbmcgbm9kZSwgdmVyaWZ5IG9ubHkgdGhl
ICJlbGVtZW50cyIgcGFydA0KPiBvZiBkZXZpY2UgY29tcG9zaXRpb24sIGkuZS4sIHNraXAgdmVy
aWZpY2F0aW9uIG9mIENJRC9QSUQvVklELCBDUlBMDQo+IGFuZCBmZWF0dXJlcy4NCj4gLS0tDQo+
ICBtZXNoL25vZGUuYyB8IDEwICsrKystLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9ub2RlLmMg
Yi9tZXNoL25vZGUuYw0KPiBpbmRleCBhY2RhNmQ0NzIuLmUzZjllNTJlMyAxMDA2NDQNCj4gLS0t
IGEvbWVzaC9ub2RlLmMNCj4gKysrIGIvbWVzaC9ub2RlLmMNCj4gQEAgLTEzNzgsNyArMTM3OCw3
IEBAIHN0YXRpYyBib29sIGNoZWNrX3JlcV9ub2RlKHN0cnVjdCBtYW5hZ2VkX29ial9yZXF1ZXN0
ICpyZXEpDQo+ICB7DQo+ICAJdWludDhfdCBub2RlX2NvbXBbTUFYX01TR19MRU4gLSAyXTsNCj4g
IAl1aW50OF90IGF0dGFjaF9jb21wW01BWF9NU0dfTEVOIC0gMl07DQo+IC0NCj4gKwl1aW50MTZf
dCBvZmZzZXQgPSAxMDsNCj4gIAl1aW50MTZfdCBub2RlX2xlbiA9IG5vZGVfZ2VuZXJhdGVfY29t
cChyZXEtPm5vZGUsIG5vZGVfY29tcCwNCj4gIAkJCQkJCQlzaXplb2Yobm9kZV9jb21wKSk7DQo+
ICANCj4gQEAgLTEzODksMTIgKzEzODksMTAgQEAgc3RhdGljIGJvb2wgY2hlY2tfcmVxX25vZGUo
c3RydWN0IG1hbmFnZWRfb2JqX3JlcXVlc3QgKnJlcSkNCj4gIAkJdWludDE2X3QgYXR0YWNoX2xl
biA9IG5vZGVfZ2VuZXJhdGVfY29tcChyZXEtPmF0dGFjaCwNCj4gIAkJCQkJYXR0YWNoX2NvbXAs
IHNpemVvZihhdHRhY2hfY29tcCkpOw0KPiAgDQo+IC0JCS8qIElnbm9yZSBmZWF0dXJlIGJpdHMg
aW4gQ29tcG9zaXRpb24gQ29tcGFyZSAqLw0KPiAtCQlub2RlX2NvbXBbOF0gPSAwOw0KPiAtCQlh
dHRhY2hfY29tcFs4XSA9IDA7DQo+IC0NCj4gKwkJLyogVmVyaWZ5IG9ubHkgZWxlbWVudC9tb2Rl
bHMgY29tcG9zaXRpb24gKi8NCj4gIAkJaWYgKG5vZGVfbGVuICE9IGF0dGFjaF9sZW4gfHwNCj4g
LQkJCQltZW1jbXAobm9kZV9jb21wLCBhdHRhY2hfY29tcCwgbm9kZV9sZW4pKSB7DQo+ICsJCQkJ
bWVtY21wKCZub2RlX2NvbXBbb2Zmc2V0XSwgJmF0dGFjaF9jb21wW29mZnNldF0sDQo+ICsJCQkJ
CQkJbm9kZV9sZW4gLSBvZmZzZXQpKSB7DQo+ICAJCQlsX2RlYnVnKCJGYWlsZWQgdG8gdmVyaWZ5
IGFwcCdzIGNvbXBvc2l0aW9uIGRhdGEiKTsNCj4gIAkJCXJldHVybiBmYWxzZTsNCj4gIAkJfQ0K
