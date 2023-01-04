Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E83C4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed,  4 Jan 2023 16:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjADQjw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Jan 2023 11:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjADQj3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Jan 2023 11:39:29 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE551C12B
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Jan 2023 08:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672850364; x=1704386364;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CbTx83xBDY+89m1IIruHMQ53oBpRCNByK3rwhKRJI2k=;
  b=SeUYtHVQcis2AnnnsNMdof+Qif3ERStif1Qbw83gbjAiKFQgyUppIGnA
   IoQDI+9DY833UKnWwT+U0ZpoUuCs6FnL/r8jLaGyD7G9bIFQi3E2tlIXY
   6qzhbPtgNTDROAF4WwIzBSIbu9p9qHSoIX+PWQyfrnaFit6axU4Q1aNNw
   vbFmJ7QOsUitbKIAX3lYNhfZN1VlIgPJzR/3tnKbtELszJ5b8Dknc/FGx
   xI+hK4GUPriNqg0CVbuTN/tsn83tABvxrgaXGpTDlg7mID29GV7ufPHnz
   FQ3Dt8evIwfdYc2KSZaLd4wn9WKvAwXraXm7MEvjQ7wCetcMUARnbg1TW
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="349199013"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="349199013"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 08:39:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="743909968"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="743909968"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Jan 2023 08:39:24 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 08:39:23 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 4 Jan 2023 08:39:23 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 4 Jan 2023 08:39:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 4 Jan 2023 08:39:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOo81wHg9ZO0w1sPoymdlmdhqs5rxK8tK0QxN3HsKHkvsoy4ze/2S4q5iaDSBdCm5E5JQO9H/oppwOcvY+VkcfgExqTU1Sxti5GMWav+6MCfSK9BeC4G46r+LX9q8AcgpcNtWqq52p0Yh4pw2vWJhxh8fShj2KznqvGFTTj4Z9ikwDijFBAcsXj6ceWPj1ZiXyK2xVAXWCkSy5zYgKn3sCauvoMDICOFFgym8gv/SfTKsTHDhmelPeu64hQvPvPNQbTNCEg6SX+MaHG22S07AcxwaQGoQj3oEKA4zW47vvOsB46H4ddezhPgs/5pQa5bzvAM0xUPttrBZSndck34IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CbTx83xBDY+89m1IIruHMQ53oBpRCNByK3rwhKRJI2k=;
 b=OCJY5MLC9ihdYWu3vIi9E/5lbNDtzJQw025g9OivqNR2NLgdoCSVIr0vYcaqdt7yeircSdEE7lRg1T0lGMLOjvVfoVFBHAtGH186eGqfEtm1+okxHwOO94vKq+pl88Tte6sThJWvEtBBSlSNiQyfVND4dbNPcFRuuFSm8yynzkvp9zg0AVbVqxLkrzdGUAAZ+FKQihUaavSKyg8Fuv23te4Rsv1i8XRBCOeLDQKkXTy2JfTQWZDIo7MoQe3GBm2awttRzZBEt/Qbn6EF7ZSlQcD9F/GTZvABlw1epaEhp9vlpVvMrMaUhyb+yS8SUelseXsvrdEdiQXR2rqGy/B66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by DS7PR11MB7858.namprd11.prod.outlook.com (2603:10b6:8:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Wed, 4 Jan
 2023 16:39:19 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::9a46:6994:1603:2a2d]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::9a46:6994:1603:2a2d%2]) with mapi id 15.20.5944.019; Wed, 4 Jan 2023
 16:39:19 +0000
From:   "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Abhay Maheta" <mabhay125@gmail.com>,
        "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
Subject: RE: [PATCH BlueZ v3 2/6] shared/bap: Add support to set stream
 metadata
Thread-Topic: [PATCH BlueZ v3 2/6] shared/bap: Add support to set stream
 metadata
Thread-Index: AQHZG53uDahN3vGyQ02r/JWo5OMjka6NbpyAgAEP7dA=
Date:   Wed, 4 Jan 2023 16:39:18 +0000
Message-ID: <BYAPR11MB3495390718990846A99FB91CB0F59@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20221229155257.341327-1-abhay.maheshbhai.maheta@intel.com>
 <20221229155257.341327-3-abhay.maheshbhai.maheta@intel.com>
 <CABBYNZKmxUeY+S4bkmoWhb2wqWSG88ncOLO2jA8HJbxZ6Pdi2A@mail.gmail.com>
In-Reply-To: <CABBYNZKmxUeY+S4bkmoWhb2wqWSG88ncOLO2jA8HJbxZ6Pdi2A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_|DS7PR11MB7858:EE_
x-ms-office365-filtering-correlation-id: a24da4fd-834d-497d-72dd-08daee7239d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +GYyIIoGGuFE0kT+B6aZx4Zoia3tIg1m4inI8iZcrjU79WNnOy1hpxLabBZFiTYPNnhWJymJmMvX/trav243PZTUMSJejbLa81z20or8g+7Mz4AkBAPi4mKfkPXqZxsnW2Drdj++X0pJDqeDx4zTF6MwiKAo/J2JjbaOVdy3awmccvJKpZ/Ud4oikDPVbB3+0u5BY6Z3GWGLAkcqajCpFuoZJGKvBebxvhBxRP96cpckVimPdKnHS+taf0yLkx6GVZShluh+qnOnItzbhP4xoEJGauOy09QIKIaJN5y+4lDA9QPcMq8JFLICiYgh3qmYeOdxwwCQM1bb45NQlSr1wR3MNDy9jEc2Ma4Gh8hlzd5ldDN074rpdOHmXMcr8ojEdspAJqZ3QPX8wjnzbI+RpkAHRIEVpY8MxS1rpPopNTeH8XvcgMMyr0LxJAaPUmWF43fBpaDKnFXmvGbEFkeHP9qN0XnCkh6F6pPfKwf8JYxNpj+xSCfhlvoC+kOp3pPxNhWgcqfnvyeiuSPMJ5PPtO93XK7umycOqFaZuX7Qus8cmpMqXkpG+KxvOeuVX4hT2QCBo3FkADtPf0EYPMru7d7l8lHKZ5RL35ZBHElYJnXRV6eNtrjh8IiPOvKIXFiIsalZhqlGa+J0LhAY4C+C8cXorQ0JCKH9m8mti7MxNWggkW8Qg7s/nzxXFCvW5iYFkEolic2jzalzDqizXis0Fg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(396003)(39860400002)(346002)(376002)(366004)(451199015)(83380400001)(55016003)(9686003)(186003)(26005)(53546011)(6506007)(33656002)(7696005)(107886003)(86362001)(38070700005)(38100700002)(82960400001)(122000001)(41300700001)(4326008)(8676002)(5660300002)(2906002)(8936002)(66476007)(71200400001)(478600001)(52536014)(76116006)(66946007)(66556008)(316002)(54906003)(6916009)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aUYyL1hJY1ZyNFhHMkh5bU54cGZtajNYbXY4cTNTTmVmYy9EWXZyUGNhQjJM?=
 =?utf-8?B?aGFuRGkvUHhTS1lxclRzN3cwTFlVNUUyTUs2V2pycDJCZmhvZWxHSURrcnQr?=
 =?utf-8?B?ZVhOSzNKTlN6cm5mNTErSW9YWXRURXptazBuQnR5UUthS1J1MXdJaHdzMlpY?=
 =?utf-8?B?dG81SXlpaVVOUTNoVEcvTktKWjZYYWdPdE00SEJkSDRTUXBCNzUyenhqS0di?=
 =?utf-8?B?NFkzc2VJNlFPQTcxOFhJeXN0QUpvLzd6M3MvOWZYdnpvLzhKajh6UGpTUFlR?=
 =?utf-8?B?bE5BU3FzblZyUGl0L2xxTFN6eElBaE4zeG1YTE1rdFI0cUt3Tzg0L1ppOGly?=
 =?utf-8?B?dE1lNkh6S0s1WFFOYlA4TmZSZk9PMUJYdmNhMGdieUNBdTY4R3g1RXZUaGtI?=
 =?utf-8?B?eUpwV3IxNjAzbEhNWjZZTm5JaVUzZThEcEZieE54WFpnSlBYNHdSUEovdmEw?=
 =?utf-8?B?NnV5ajJRSWRiNzBDcEZHdDdTT3JjSnZHeUVlaXdwVkluNFFNUkQ1VTlhVHNN?=
 =?utf-8?B?OURKOGhGemtGUUtzNzJNSDU2OXRXajVjSGJ5WFlDKzhVaVFKSzlsQnpnWGRL?=
 =?utf-8?B?YWN3TzlNZ3dDSlB3TG5FbklxVVorSjlZNDMzUitpZHNHYXJVaHk5YWNBaUtL?=
 =?utf-8?B?UTdnQkFPWkpOOC9JK2NJKzlmcVBlcHRVeXFxaHhUK0lLWEE0bGVLSStvQUhS?=
 =?utf-8?B?cUh5TktTTlQvNFJuYkR1L3VEM04wTWlwek12bldxaHN0b0RFclYwcG9UMDFO?=
 =?utf-8?B?OXRmNnROR1F6R3JVcU1IUnBQdzFJZ0h5LzdvQ1hGK290QzRjUlhraTZBdHZv?=
 =?utf-8?B?TGg0RGlNc1lYcVkvNWN3YUo2cEN5WXJEcmdEMUFTcXkxYmI5ek1BVjRYZGVE?=
 =?utf-8?B?c0VqUXRHeUhkTFdkWWhSUlk1M1BNU3p1ZnNIbW5ndTZiUXJkVnR3ZUtGVGox?=
 =?utf-8?B?SElOY2VONXZCQ1EvMFdIR3dqVHorenhzMkhTQXZYTEpoVEpWdnFEcG9IRm4x?=
 =?utf-8?B?TDVBUFY0c1hhRHlLY0t3V09Xa3lpZVJrb21qSWRpTDhMd1YreXNtQktVWk9F?=
 =?utf-8?B?UUxFZGc2UTlRQ1lhcnFvNTBJbjBxc2Y3RzJXSFh4OEV5cEw2QW4wdmV2eXBi?=
 =?utf-8?B?VUtMNDZPd3kva0lsUy8yd0F6MHU2N0d2RFBYWEpFOEU3Sll3aVo3b1k4NlJh?=
 =?utf-8?B?cFRVdDQzZDN4OWJxSGMvakp5blJyMVQvRmZPQjZsWHpCRHlXbllxY0cxbXVN?=
 =?utf-8?B?SE5veHg3QkhDZlgyaUh1eEl5VXk0UEQ1TVBUbElWUGVvMDRld1JKZmYyVWNS?=
 =?utf-8?B?dGNqYXVKZi93b0VnT2x0VUVwWlovZk1XOE5jOUhNeEFkM1lQTkJPUFMzZWtk?=
 =?utf-8?B?Si9mdDBtTW9IYmlscDFLdG5OcGNYd1o5aUtRRmtHRGxIMURsWGRFRHFVc2RB?=
 =?utf-8?B?MXBlVVR3dDdPd1Q0dnowMW54NXNwcG1Gcm10WFpLVEhuZmp2YlR1dS8xNTFp?=
 =?utf-8?B?Z3RKQ0R3ejFrZk1vN2ZRWWNzVWlJc1lnYnhWYzd6elRWN1FtVVBEZG16V0Jl?=
 =?utf-8?B?TDBIYWFoVmZmUy9pV1NTVGlRWWpVMElxUWxyenZIbENDS3BBR09YWFJXazVi?=
 =?utf-8?B?WFgvNjFUT2lpaW9nejB1WmFpQmozUDVLRkhLUmplOVJUNGlGZjh5b29FY1Zs?=
 =?utf-8?B?TEFFa1g4R0Fsc0hCd2prZEl4ZU5nZWIxeFlPdlppcFZtVGsrd0FNeXBld3N5?=
 =?utf-8?B?QUhHdGNhTjBRK0tlZzVLTEZSVHJzYnh0Nk5Jb2ZRdDU1Yk5oSEVIOWI1YVRx?=
 =?utf-8?B?cklKWW9WRWw1ak0wOHVtQW5pZlBSWm1sU1J1a0tCbGxrd0ZlbUNMUyt1WXBL?=
 =?utf-8?B?dkV6aEZQRzNJMENNcG9PaU93YmxvbXhuc05MSEZWSlVpeUF5cEJkT0F1Ym03?=
 =?utf-8?B?M1FNYkhFUFVYdjlkTHpuclFwNDZLWjc3UGxLRDY1VEdOREdWUlhWWVBvMk9k?=
 =?utf-8?B?b2dNVWlUai9obW5pcVBWcGh2OTFGZnNvaHVyUlB1Qm1kWjBSYktFRmttaHB5?=
 =?utf-8?B?YThCTjFMeGdVU21kclJJMlVOV2VwTXBhTkNOQUozS1BCUkVMR0pOMnZCMzUv?=
 =?utf-8?B?V1F2ZjlWdXh2aFdPTUtjSUwrdWRINEh1cDlyMEZtdTNnK0ZCS2piKzg5anVR?=
 =?utf-8?B?d0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a24da4fd-834d-497d-72dd-08daee7239d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2023 16:39:19.0071
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v6nQnguAjikaYu0IPJAVm3kHxYLIGhBXumFEMX67HPXDZR5sNqzqJshvdlw+I91fQjA5tthdnxcwtMCiIKEFKoQMP97EzrdWZQGddOop+ub+0rvucVcheXKpFqdisP62
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7858
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KSSBhZ3JlZS4gU2hhbGwgY29udGludWUgdXNpbmcgImJ0X2JhcF9zdGVhbV9t
ZXRhZGF0YSIgQVBJLg0KDQpUaGFua3MgJiBSZWdhcmRzLA0KQWJoYXkNCg0KLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCkZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpA
Z21haWwuY29tPiANClNlbnQ6IDA0IEphbnVhcnkgMjAyMyAwNTo1NQ0KVG86IE1haGV0YSwgQWJo
YXkgPGFiaGF5Lm1haGVzaGJoYWkubWFoZXRhQGludGVsLmNvbT4NCkNjOiBsaW51eC1ibHVldG9v
dGhAdmdlci5rZXJuZWwub3JnOyBBYmhheSBNYWhldGEgPG1hYmhheTEyNUBnbWFpbC5jb20+DQpT
dWJqZWN0OiBSZTogW1BBVENIIEJsdWVaIHYzIDIvNl0gc2hhcmVkL2JhcDogQWRkIHN1cHBvcnQg
dG8gc2V0IHN0cmVhbSBtZXRhZGF0YQ0KDQpIaSBBYmhheSwNCg0KT24gVGh1LCBEZWMgMjksIDIw
MjIgYXQgNzo1NyBBTSBBYmhheSBNYWhldGEgPGFiaGF5Lm1haGVzaGJoYWkubWFoZXRhQGludGVs
LmNvbT4gd3JvdGU6DQo+DQo+IFRoaXMgYWRkcyBuZXcgQVBJIHRvIHNldCBzdHJlYW0gbWV0YWRh
dGEuDQo+IC0tLQ0KPiAgc3JjL3NoYXJlZC9iYXAuYyB8IDMwICsrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLSAgDQo+IHNyYy9zaGFyZWQvYmFwLmggfCAgMiArKw0KPiAgMiBmaWxlcyBjaGFu
Z2VkLCAyNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEv
c3JjL3NoYXJlZC9iYXAuYyBiL3NyYy9zaGFyZWQvYmFwLmMgaW5kZXggDQo+IDBjYWZiNzVlNi4u
YjNjNjUyODNlIDEwMDY0NA0KPiAtLS0gYS9zcmMvc2hhcmVkL2JhcC5jDQo+ICsrKyBiL3NyYy9z
aGFyZWQvYmFwLmMNCj4gQEAgLTM0NCw4ICszNDQsMTAgQEAgc3RhdGljIHZvaWQgcGFjX2ZvcmVh
Y2godm9pZCAqZGF0YSwgdm9pZCANCj4gKnVzZXJfZGF0YSkNCj4NCj4gICAgICAgICBwID0gdXRp
bF9pb3ZfcHVzaChpb3YsIHNpemVvZigqcCkpOw0KPiAgICAgICAgIHAtPmNvZGVjLmlkID0gcGFj
LT5jb2RlYy5pZDsNCj4gLSAgICAgICBwLT5jb2RlYy5jaWQgPSBwYWMtPmNvZGVjLmNpZDsNCj4g
LSAgICAgICBwLT5jb2RlYy52aWQgPSBwYWMtPmNvZGVjLnZpZDsNCj4gKyAgICAgICBpZiAocC0+
Y29kZWMuaWQgPT0gMHhmZikgew0KPiArICAgICAgICAgICAgICAgcC0+Y29kZWMuY2lkID0gY3B1
X3RvX2xlMTYocGFjLT5jb2RlYy5jaWQpOw0KPiArICAgICAgICAgICAgICAgcC0+Y29kZWMudmlk
ID0gY3B1X3RvX2xlMTYocGFjLT5jb2RlYy52aWQpOw0KPiArICAgICAgIH0NCj4NCj4gICAgICAg
ICBpZiAocGFjLT5kYXRhKSB7DQo+ICAgICAgICAgICAgICAgICBwLT5jY19sZW4gPSBwYWMtPmRh
dGEtPmlvdl9sZW47IEBAIC0yNzczLDcgKzI3NzUsNyBAQCANCj4gc3RhdGljIHZvaWQgYmFwX3Bh
cnNlX3BhY3Moc3RydWN0IGJ0X2JhcCAqYmFwLCB1aW50OF90IHR5cGUsDQo+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3QgYnRfcGFjICpwOw0KPiAgICAgICAgICAgICAgICAgc3RydWN0IGJ0X2x0diAq
Y2M7DQo+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgYnRfcGFjX21ldGFkYXRhICptZXRhOw0KPiAt
ICAgICAgICAgICAgICAgc3RydWN0IGlvdmVjIGRhdGEsIG1ldGFkYXRhOw0KPiArICAgICAgICAg
ICAgICAgc3RydWN0IGlvdmVjIGRhdGEsICptZXRhZGF0YSA9IE5VTEw7DQo+DQo+ICAgICAgICAg
ICAgICAgICBwID0gdXRpbF9pb3ZfcHVsbF9tZW0oJmlvdiwgc2l6ZW9mKCpwKSk7DQo+ICAgICAg
ICAgICAgICAgICBpZiAoIXApIHsNCj4gQEAgLTI4MDIsOCArMjgwNCwxMSBAQCBzdGF0aWMgdm9p
ZCBiYXBfcGFyc2VfcGFjcyhzdHJ1Y3QgYnRfYmFwICpiYXAsIHVpbnQ4X3QgdHlwZSwNCj4gICAg
ICAgICAgICAgICAgIGRhdGEuaW92X2xlbiA9IHAtPmNjX2xlbjsNCj4gICAgICAgICAgICAgICAg
IGRhdGEuaW92X2Jhc2UgPSBjYzsNCj4NCj4gLSAgICAgICAgICAgICAgIG1ldGFkYXRhLmlvdl9s
ZW4gPSBtZXRhLT5sZW47DQo+IC0gICAgICAgICAgICAgICBtZXRhZGF0YS5pb3ZfYmFzZSA9IG1l
dGEtPmRhdGE7DQo+ICsgICAgICAgICAgICAgICBpZiAobWV0YS0+bGVuKSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIG1ldGFkYXRhID0gbmV3MChzdHJ1Y3QgaW92ZWMsIDEpOw0KPiArICAg
ICAgICAgICAgICAgICAgICAgICBtZXRhZGF0YS0+aW92X2xlbiA9IG1ldGEtPmxlbjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgbWV0YWRhdGEtPmlvdl9iYXNlID0gbWV0YS0+ZGF0YTsNCj4g
KyAgICAgICAgICAgICAgIH0NCj4NCj4gICAgICAgICAgICAgICAgIHV0aWxfaW92X3B1bGxfbWVt
KCZpb3YsIG1ldGEtPmxlbik7DQo+DQo+IEBAIC0yODEzLDEyICsyODE4LDE0IEBAIHN0YXRpYyB2
b2lkIGJhcF9wYXJzZV9wYWNzKHN0cnVjdCBidF9iYXAgKmJhcCwgdWludDhfdCB0eXBlLA0KPiAg
ICAgICAgICAgICAgICAgLyogQ2hlY2sgaWYgdGhlcmUgaXMgYWxyZWFkeSBhIFBBQyByZWNvcmQg
Zm9yIHRoZSBjb2RlYyAqLw0KPiAgICAgICAgICAgICAgICAgcGFjID0gYmFwX3BhY19maW5kKGJh
cC0+cmRiLCB0eXBlLCAmcC0+Y29kZWMpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHBhYykgew0K
PiAtICAgICAgICAgICAgICAgICAgICAgICBiYXBfcGFjX21lcmdlKHBhYywgJmRhdGEsICZtZXRh
ZGF0YSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJhcF9wYWNfbWVyZ2UocGFjLCAmZGF0
YSwgbWV0YWRhdGEpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICBmcmVlKG1ldGFkYXRhKTsN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+ICAgICAgICAgICAgICAgICB9
DQo+DQo+ICAgICAgICAgICAgICAgICBwYWMgPSBiYXBfcGFjX25ldyhiYXAtPnJkYiwgTlVMTCwg
dHlwZSwgJnAtPmNvZGVjLCBOVUxMLCAmZGF0YSwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZtZXRhZGF0YSk7DQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBtZXRhZGF0YSk7DQo+ICsgICAgICAgICAgICAgICBmcmVlKG1ldGFkYXRhKTsNCj4gICAg
ICAgICAgICAgICAgIGlmICghcGFjKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb250aW51
ZTsNCj4NCj4gQEAgLTQ1OTEsNiArNDU5OCwxNSBAQCBzdHJ1Y3QgYnRfYmFwX3FvcyAqYnRfYmFw
X3N0cmVhbV9nZXRfcW9zKHN0cnVjdCBidF9iYXBfc3RyZWFtICpzdHJlYW0pDQo+ICAgICAgICAg
cmV0dXJuICZzdHJlYW0tPnFvczsNCj4gIH0NCj4NCj4gK3ZvaWQgYnRfYmFwX3N0cmVhbV9zZXRf
bWV0YWRhdGEoc3RydWN0IGJ0X2JhcF9zdHJlYW0gKnN0cmVhbSwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW92ZWMgKm1ldGEpIHsNCj4gKyAgICAgICBpZiAoIXN0
cmVhbSkNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKw0KPiArICAgICAgIHN0cmVhbV9t
ZXRhZGF0YShzdHJlYW0sIG1ldGEsIE5VTEwpOyB9DQo+ICsNCj4gIHN0cnVjdCBpb3ZlYyAqYnRf
YmFwX3N0cmVhbV9nZXRfbWV0YWRhdGEoc3RydWN0IGJ0X2JhcF9zdHJlYW0gDQo+ICpzdHJlYW0p
ICB7DQo+ICAgICAgICAgaWYgKCFzdHJlYW0pDQo+IGRpZmYgLS1naXQgYS9zcmMvc2hhcmVkL2Jh
cC5oIGIvc3JjL3NoYXJlZC9iYXAuaCBpbmRleCANCj4gNDdhMTU2MzZjLi5iY2Y4MzBjZWIgMTAw
NjQ0DQo+IC0tLSBhL3NyYy9zaGFyZWQvYmFwLmgNCj4gKysrIGIvc3JjL3NoYXJlZC9iYXAuaA0K
PiBAQCAtMjQ4LDYgKzI0OCw4IEBAIHVpbnQ4X3QgYnRfYmFwX3N0cmVhbV9nZXRfZGlyKHN0cnVj
dCBidF9iYXBfc3RyZWFtIA0KPiAqc3RyZWFtKTsgIHVpbnQzMl90IGJ0X2JhcF9zdHJlYW1fZ2V0
X2xvY2F0aW9uKHN0cnVjdCBidF9iYXBfc3RyZWFtIA0KPiAqc3RyZWFtKTsgIHN0cnVjdCBpb3Zl
YyAqYnRfYmFwX3N0cmVhbV9nZXRfY29uZmlnKHN0cnVjdCBidF9iYXBfc3RyZWFtIA0KPiAqc3Ry
ZWFtKTsgIHN0cnVjdCBidF9iYXBfcW9zICpidF9iYXBfc3RyZWFtX2dldF9xb3Moc3RydWN0IA0K
PiBidF9iYXBfc3RyZWFtICpzdHJlYW0pOw0KPiArdm9pZCBidF9iYXBfc3RyZWFtX3NldF9tZXRh
ZGF0YShzdHJ1Y3QgYnRfYmFwX3N0cmVhbSAqc3RyZWFtLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgc3RydWN0IGlvdmVjICptZXRhKTsNCg0KVGhlcmUgaXMgYWxy
ZWFkeSBidF9iYXBfc3RlYW1fbWV0YWRhdGEgc28gSW0gbm90IHN1cmUgd2h5IHlvdSB3YW50IHRv
IGFkZCBhbm90aGVyIG9uZSB0aGF0IGp1c3Qgc2V0IGl0IGxvY2FsbHk/DQoNCj4gIHN0cnVjdCBp
b3ZlYyAqYnRfYmFwX3N0cmVhbV9nZXRfbWV0YWRhdGEoc3RydWN0IGJ0X2JhcF9zdHJlYW0gDQo+
ICpzdHJlYW0pOw0KPg0KPiAgc3RydWN0IGlvICpidF9iYXBfc3RyZWFtX2dldF9pbyhzdHJ1Y3Qg
YnRfYmFwX3N0cmVhbSAqc3RyZWFtKTsNCj4gLS0NCj4gMi4yNS4xDQo+DQoNCg0KLS0NCkx1aXog
QXVndXN0byB2b24gRGVudHoNCg==
