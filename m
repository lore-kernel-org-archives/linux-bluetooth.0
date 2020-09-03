Return-Path: <SRS0=fWrd=CM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F30C433E2
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72A97206CA
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Sep 2020 21:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="oWb0YGVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgICV2P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Sep 2020 17:28:15 -0400
Received: from mga05.intel.com ([192.55.52.43]:38966 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728015AbgICV2N (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Sep 2020 17:28:13 -0400
IronPort-SDR: PHgEmU4GoVdUxgpDvRWnoz3WbRpr3B2kbB95CrteDg+hiOgk9I5A3SqDeh8nZnZaGZUeIyGW32
 lm+wAHhWrUWA==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="242480206"
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="242480206"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2020 14:28:07 -0700
IronPort-SDR: ASpMO4+JO0WzkPsVDJKEnc4Pn/TcZmonf1dwF07HOsHlqknFaTKqTb4qDPvF6kf83BQx3X6mNj
 i9uxiPmfVCGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,387,1592895600"; 
   d="scan'208";a="298187054"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 03 Sep 2020 14:28:08 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 14:28:07 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 3 Sep 2020 14:28:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 3 Sep 2020 14:28:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Thu, 3 Sep 2020 14:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R53get7VsZRXG9SXTgJQBJ2MQQ1m1S3U6dq5DAlU9GbHClr91oyY7qGlZDyArLMqKt6KldhhpBoKaTcgLIPdKlcgtDUDwneJDK3jqlp7X5O0Jlihk7q1DFOgqRrZFllsHriVHxIhj0BcKCngJ557T+AOP9fTcsUVUXSYe13igUzCeLO5Oij8woFNJLRajg5GzgQMu29T5cjFysg5XuoMdoIX4aJJASCa5pLoC5ci0bZSF8g85u3M2NJBrRmcnFICtf5D4t77bwbQr0LVl4PTZAT1MEWPIMxqdu/Dghw0k8VxRX+Zp++h7GuA9lyItXsy4T78JCDUvHtoVXiGWydaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMhfnpdW5jRrD0u+oTmIo/44FBaSDpfWdv/+ihhGt20=;
 b=U+pLVzgwWHz04XGzt2rT1tiKSwn0y5UMhYfiw4RGd7kC2itFEouEW0apyuunBxfkgZRs9xVO6ftli2/kwQeMyslj4eN9nfa+P3WIPgo3Gf1zmxbmujvZioasWUBa/sw0sobb2x6m5a9e4dXP73kgJ3UUlcGYYfpp6dT2KVsV8bOL0+tP/8YytF6ySdisvMqAHUPqwXNIJ3ROm1WHxXrwWFdfKdagMiGjSGBsBs7GwvT8cTXUpPh8RDSPwNtjwBmKcVhA6Ce/FQlQJs8n7OtEruBfLoEfpy3b5EOh36XLm+sVVbzJJdSBTHm4dlY9QhPJ/+7Ll4YMgz9HcU6R28wpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMhfnpdW5jRrD0u+oTmIo/44FBaSDpfWdv/+ihhGt20=;
 b=oWb0YGVphLdWBkEwsip4wy2ny7mCzKJsloHVM4Mfa9aMw0jW+gopUSbPQIsuO8H8D2j7nVUobQR6N7SLYiqHSY+dhRp6MEDmwJZT2CutKMBZD1HIwmMIJqmG0A3NPlV7akE6wPIHzSiT2PgCbYYquW4pwi2+wgsc2So+VjNK1lk=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1903.namprd11.prod.outlook.com (2603:10b6:300:10e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 3 Sep
 2020 21:28:06 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3348.016; Thu, 3 Sep 2020
 21:28:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Align option names with functionality
Thread-Topic: [PATCH BlueZ] mesh: Align option names with functionality
Thread-Index: AQHWgi0DW/VshLDcYkKI1ojjvVsdJKlXbd6A
Date:   Thu, 3 Sep 2020 21:28:05 +0000
Message-ID: <8debd6d1d3bdc97cb898fa77ecf7ef3be5de8198.camel@intel.com>
References: <20200903200052.11005-1-inga.stotland@intel.com>
In-Reply-To: <20200903200052.11005-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2acc826d-ad29-425e-d5da-08d850503f23
x-ms-traffictypediagnostic: MWHPR11MB1903:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB19035D13C4AC8152C3323288E12C0@MWHPR11MB1903.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cGVLWFdwIMmKCqgnNZvI30zmPgA3VS/9+G59HBdTE7t0doDgdu/ga1ZHgz92EEWLwwXNXFWe5ah0gUvAPU6IT34xOz5S3/ycRqCBt15k0FIVOFeAWk4JnKPwo1HY5rEJ5SKBxlUy/HUYG0oeLWGAS/x6nzE/5y2M9Q1XwZ4DbvotYKjI/HSAoXg822lITzQm53JdXP+eCYCmZ7bGK8EBT/+sFRTM3Cvlrm7SakYaY3frJwsFpBaWlOyx9AOD5oVwTSO/HhhIIg0WVMpeYATmCg3vVxuGKHg8COXjxEm4FHpcy3cirg8oKJYDg/4PCYIvzeSn/w9LR5qB/N+eHVv5nQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(2906002)(86362001)(36756003)(5660300002)(186003)(478600001)(8676002)(6506007)(6486002)(6512007)(6636002)(83380400001)(316002)(66556008)(8936002)(71200400001)(66476007)(91956017)(66446008)(2616005)(66946007)(64756008)(110136005)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /Q1Q0+q3Crw8FyrJzA+WhoShrLLYgS/inEj5+gbeFUsGkW7BD22tuJWx6QnPUBO5PxCQ2uUJjFJrAmfOxytsFI7jBN1LroaNAk0gA5l1Djb1vEJRy1r5DsSb60BLOhzNor6DfK2Rbrg2lhNIGaHVqeHR4ne2GyC3ZEc1J1uZeA0/8R32QcF1y5QUob7sxWROqkLl8qHhQW1B9q/RbAd+1wHixtDT6vK4FBs1sMMR4uDtAsEYeFQLWEKVp3As+WrlBtXgpXCvFlyWm4VpdWdQoxIn5rxx8W+FivOrk3535P4NljUHQukTj7OShpsH6jycs2M6tHdFNF8cWFlx1SR84/h5zz2/GOIX+JdtPpsBcMSVZddkEQ/1xEFD7py4G2ABrcx+N7CuGbiHz4D5uAz3oobIHlxEz2xmW8aGE7hthnD0qkjen24owu329REqkZ6+gJI/BsZ6rv/niwvcLHHgbXX+/qB9yqL9itlFRjdSIx8msQEtbiiFM+GAnS+lf/OXBCqSxTzQVECewiIZ3hqHqhl5h4PioqhC7HxQ3z6hjw7BSdJw0Gi7hdGaa0imWfCMrzRCZ4wwf1yj5i7CP2M1wpioKGDmV0C+Nxx177VqTRnWLO1Mc9zXPioSnSI9onfiMkZqL+fTOu2o/wTC4npeiQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <09A403034A27984C9016A596A0E4AADA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2acc826d-ad29-425e-d5da-08d850503f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2020 21:28:05.7633
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEaQPZ2MMMdJ8NNmrfqGpebKpgIWY29f92mBqQB1i7k5dPVOc7P2UXeRMftRE4OtLHdpoDrmBD+5C8OkUbt2hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1903
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KDQpPbiBUaHUsIDIwMjAtMDktMDMgYXQgMTM6MDAgLTA3MDAsIEluZ2EgU3RvdGxh
bmQgd3JvdGU6DQo+IENoYW5nZSBvcHRpb24gImNvbmZpZyIgKCdjJykgdG8gInN0b3JhZ2UiICgn
cykgdG8gc3BlY2lmeQ0KPiBhIGN1c3RvbSBzdG9yYWdlIGRpcmVjdG9yeSBmb3Igbm9kZSBjb25m
aWd1cmF0aW9uLg0KPiANCj4gQ2hhbmdlIG9wdGlvbiAnZicgKGxvbmcgbmFtZSB3YXMgbWlzc2lu
ZykgdG8gImNvbmZpZyIgKCdjJykNCj4gdG8gc3BlY2lmeSBhIGN1c3RvbSBtZXNoIGNvbmZpZ3Vy
YXRpb24gZmlsZSB0byBvdmVycmlkZSB0aGUNCj4gZGVmYXVsdCBtZXNoLW1haW4uY29uZg0KPiAt
LS0NCj4gIG1lc2gvbWFpbi5jIHwgMTUgKysrKysrKystLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgOCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21l
c2gvbWFpbi5jIGIvbWVzaC9tYWluLmMNCj4gaW5kZXggMWE0ZTZiYTc2Li41YTNjYmYyOTAgMTAw
NjQ0DQo+IC0tLSBhL21lc2gvbWFpbi5jDQo+ICsrKyBiL21lc2gvbWFpbi5jDQo+IEBAIC0zOSwx
NCArMzksMTUgQEANCj4gICNpbmNsdWRlICJtZXNoL21lc2gtaW8uaCINCj4gICNpbmNsdWRlICJt
ZXNoL3V0aWwuaCINCj4gIA0KPiAtc3RhdGljIGNvbnN0IGNoYXIgKmNvbmZpZ19kaXI7DQo+ICtz
dGF0aWMgY29uc3QgY2hhciAqc3RvcmFnZV9kaXI7DQo+ICBzdGF0aWMgY29uc3QgY2hhciAqbWVz
aF9jb25mX2ZuYW1lOw0KPiAgc3RhdGljIGVudW0gbWVzaF9pb190eXBlIGlvX3R5cGU7DQo+ICBz
dGF0aWMgdm9pZCAqaW9fb3B0czsNCj4gIA0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBvcHRpb24g
bWFpbl9vcHRpb25zW10gPSB7DQo+ICAJeyAiaW8iLAkJcmVxdWlyZWRfYXJndW1lbnQsCU5VTEws
ICdpJyB9LA0KPiAtCXsgImNvbmZpZyIsCW9wdGlvbmFsX2FyZ3VtZW50LAlOVUxMLCAnYycgfSwN
Cj4gKwl7ICJzdG9yYWdlIiwJcmVxdWlyZWRfYXJndW1lbnQsCU5VTEwsICdzJyB9LA0KPiArCXsg
ImNvbmZpZyIsCXJlcXVpcmVkX2FyZ3VtZW50LAlOVUxMLCAnYycgfSwNCj4gIAl7ICJub2RldGFj
aCIsCW5vX2FyZ3VtZW50LAkJTlVMTCwgJ24nIH0sDQo+ICAJeyAiZGVidWciLAlub19hcmd1bWVu
dCwJCU5VTEwsICdkJyB9LA0KPiAgCXsgImRidXMtZGVidWciLAlub19hcmd1bWVudCwJCU5VTEws
ICdiJyB9LA0KPiBAQCAtMTA4LDcgKzEwOSw3IEBAIHN0YXRpYyB2b2lkIHJlcXVlc3RfbmFtZV9j
YWxsYmFjayhzdHJ1Y3QgbF9kYnVzICpkYnVzLCBib29sIHN1Y2Nlc3MsDQo+ICAJCXJldHVybjsN
Cj4gIAl9DQo+ICANCj4gLQlpZiAoIW1lc2hfaW5pdChjb25maWdfZGlyLCBtZXNoX2NvbmZfZm5h
bWUsIGlvX3R5cGUsIGlvX29wdHMsDQo+ICsJaWYgKCFtZXNoX2luaXQoc3RvcmFnZV9kaXIsIG1l
c2hfY29uZl9mbmFtZSwgaW9fdHlwZSwgaW9fb3B0cywNCj4gIAkJCQkJbWVzaF9yZWFkeV9jYWxs
YmFjaywgZGJ1cykpIHsNCj4gIAkJbF9lcnJvcigiRmFpbGVkIHRvIGluaXRpYWxpemUgbWVzaCIp
Ow0KPiAgCQlsX21haW5fcXVpdCgpOw0KPiBAQCAtMTk1LDcgKzE5Niw3IEBAIGludCBtYWluKGlu
dCBhcmdjLCBjaGFyICphcmd2W10pDQo+ICAJZm9yICg7Oykgew0KPiAgCQlpbnQgb3B0Ow0KPiAg
DQo+IC0JCW9wdCA9IGdldG9wdF9sb25nKGFyZ2MsIGFyZ3YsICJpOmM6ZjpuZGJoIiwgbWFpbl9v
cHRpb25zLCBOVUxMKTsNCj4gKwkJb3B0ID0gZ2V0b3B0X2xvbmcoYXJnYywgYXJndiwgImk6czpj
Om5kYmgiLCBtYWluX29wdGlvbnMsIE5VTEwpOw0KPiAgCQlpZiAob3B0IDwgMCkNCj4gIAkJCWJy
ZWFrOw0KPiAgDQo+IEBAIC0yMTMsMTAgKzIxNCwxMCBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQ0KPiAgCQljYXNlICdkJzoNCj4gIAkJCWVuYWJsZV9kZWJ1ZygpOw0KPiAgCQkJ
YnJlYWs7DQo+IC0JCWNhc2UgJ2MnOg0KPiAtCQkJY29uZmlnX2RpciA9IG9wdGFyZzsNCj4gKwkJ
Y2FzZSAncyc6DQo+ICsJCQlzdG9yYWdlX2RpciA9IG9wdGFyZzsNCj4gIAkJCWJyZWFrOw0KPiAt
CQljYXNlICdmJzoNCj4gKwkJY2FzZSAnYyc6DQo+ICAJCQltZXNoX2NvbmZfZm5hbWUgPSBvcHRh
cmc7DQo+ICAJCQlicmVhazsNCj4gIAkJY2FzZSAnYic6DQo=
