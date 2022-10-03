Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79934C433FE
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 23:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiJCXKE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 19:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJCXKC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 19:10:02 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBFE12D09
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 16:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664838599; x=1696374599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hZK4QPH1XeQB6dSmvHlHVmf4io5RTyF+2VUFEi1xAXI=;
  b=WfLVZ1nqDyrF7vuENkMIp5eDpJ88C4dltlNe5mzyBamPFGbVZRXbmr4X
   1iib4IrY88n4wnsUnkHbZrA7kaS6Pu4dp5ZJNehS6mW+Y/5C3flnV7nt2
   xJpYWRrDZ6ThfvQptXAI2ZRnOAPqFYj32yRJWWjYFjbDPSs0tMI+W28kK
   myRjNEdm4MRDfFEBTer2oR2XEHAeoJtJEOrfuDGA/g2jns5J+iISv6u5c
   f7oqB9e/gRvcPoQ/d49JRiHkNumZmARD3Ktsbg/sxee0xZmDX99trsZ2/
   Q7b8seWHJbbBDsULH31ZzG1/iKV8diqu7PSbdQtcJIyCM5+m5mTCb8CxI
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="285973088"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="285973088"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 16:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10489"; a="727988093"
X-IronPort-AV: E=Sophos;i="5.93,366,1654585200"; 
   d="scan'208";a="727988093"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 03 Oct 2022 16:09:58 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:09:57 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 3 Oct 2022 16:09:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 3 Oct 2022 16:09:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 3 Oct 2022 16:09:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7UEhKrolcHO2LgLkFdWGRQiHVDdu7jJbvMKujMFZntb1fdeCvzLkrM0JnYg4sS0jnUJGtfoUhKX5TzOMIhYU/X3qInMBNkWU3cI4zm9HrBpDpRS/gO5Thhf+QSY0Sf3+mN5CG2eNVOnVYEHSFYc+zdkVKbcUtSRSYQki2h0ojdwOzDlhdZkDKrW6c9RjtdLVcRo+/2nfdRtftDVXMUc4M6gtZ7PIKFJnQk0A4bLktxaBrEYg0miPcpBXkp538SzyaIWVJbsu5B2uLWZ4MpNK8zqr8FbBB3pQiwA/wFoWtMTFXE7kOFhhuND6/4eMjyJyWqVtBNdo84gCC25eptSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hZK4QPH1XeQB6dSmvHlHVmf4io5RTyF+2VUFEi1xAXI=;
 b=NZnhIjYKkGEZXnQ4wrHMSzKS+MxPUFJY34SYnmkmuIcv993ZYjSIScrDgOFjY/ASeuTeM7q3SX+F7UEQvgjAnpiHzaIdmLZzPIAkeZgqf4L+Ik4gR4QWHcMXhkBGKrqANvVyk0sNXtap1ObeWp+T/DgypOBDb7nvN1NfwHsLag28gfJvKhKqM1SH8MJ7DEa4ecshWSwZ0edu+WTyg1Arj78uwMRMPUiciv7wDM8z5hGKgAdG4EhHTBs6pkhUuNqYClIL/4F4v8+uheVySTPjKfQ3UIGj2C8NqffxyIW01UoP6ZjiLcyBmokJzmdWjhahVKr675yC40Kam/534aS+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4556.namprd11.prod.outlook.com (2603:10b6:303:5b::21)
 by PH0PR11MB4934.namprd11.prod.outlook.com (2603:10b6:510:30::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Mon, 3 Oct
 2022 23:09:54 +0000
Received: from MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::b685:c163:2836:d1d4]) by MW3PR11MB4556.namprd11.prod.outlook.com
 ([fe80::b685:c163:2836:d1d4%7]) with mapi id 15.20.5676.030; Mon, 3 Oct 2022
 23:09:54 +0000
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>
Subject: Re: [PATCH BlueZ] README: Update Mesh required Kernel Config section
Thread-Topic: [PATCH BlueZ] README: Update Mesh required Kernel Config section
Thread-Index: AQHYtAzk9txbVDDnbkKCwhYDno+6PK39kmQA
Date:   Mon, 3 Oct 2022 23:09:54 +0000
Message-ID: <9b1114d762c15f6d70f99be37ca5e8708f3b9998.camel@intel.com>
References: <20220819204649.244035-1-inga.stotland@intel.com>
In-Reply-To: <20220819204649.244035-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4556:EE_|PH0PR11MB4934:EE_
x-ms-office365-filtering-correlation-id: 1ff5aeb8-2e97-4e26-3c34-08daa5946237
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jd66vObixNLr3yH1XSPppNOoXL/N5TcUmkvSeWiCLGjfIjax6Z6Q/wyyhk8aR6B3o+JIxKTodzpoFrSKOWC1kK6d6jlCO++tb1QuO+cIwinq3l+fVhGZjG51ATqsLpq0Eb+keSM6Qrgw8eVOsKaYGLhVkAArk8OuAXMsCzVFGE3iuhfOsC3kmXZoVwhHM6MxfdS+pcL0V4cJufvQ0EDily0R2NqnAe3k61Pj1GQI/H2LSdkhgFtrhLW7o/Kxt3hxOcrxw4ZI1xoJ2EPz8Jx+vidHPT0BIyUIxBks++cixlAwsTrnsAQvE4naRe2TIq1cz6R91Ouexncr57F7GZ/ZD2IoJwwXU9yVUUHLdU+cs12/jI8IsLMiCM/a4wg+0PBU33rKfEn1HDLoS67zhlBwtm9CSjBwok770XKWQL+vNY4iWK3BjTGFnv7RvGUKid9j03C0Qg6AHaoAwrH5vH8FRDZR6gKINEXhHBEnJPSdmFigegqD7TbkDPwZ7C9EaM8CAKvPaqA48fTpwlT5yoQFDA/LdxnRMvrp4VSNwp9nnk6GxFI0NUpdVylbA72rBplr24xiYoNSqbDm3ZjWFixfdcu3+UhCBqkww1xVpEfm5UaOqeM69tRemKlzZB2T7kNlAAGmZ8ZYO64pCQkqvBoynjBD2guUS0tbNnEozcKx3ARPdE92/ZgESIDJDJuFAbQOfsYGU26feFqLmkJmhmNcJV2Bi69b+BQpU8Mtu65hWegiV2TymsGqDp8QrOeZT0bZhPzbLLidP8huwBfvzgGBNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(136003)(376002)(39860400002)(346002)(451199015)(2616005)(54906003)(107886003)(26005)(6512007)(6506007)(76116006)(6916009)(66946007)(4326008)(316002)(8676002)(91956017)(36756003)(66476007)(66556008)(478600001)(64756008)(66446008)(38100700002)(82960400001)(71200400001)(122000001)(86362001)(38070700005)(6486002)(186003)(4744005)(5660300002)(8936002)(41300700001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NytoamhjTSthSjV5Wnh6Q2JQL0JMZmIzRDAvQ3BSTWN1Ty9WZzdnZjVPY0k1?=
 =?utf-8?B?STZDRHlGdUVqN1NwWUJUbTlkRXI5NmxnSDB6dEFDNlRGZXdZSlI2NGFMMXAx?=
 =?utf-8?B?QUZacXUxSUdhcDR5REY1TTJxVkNxOVFVc3pzbklvVFgxQjR6OFZTMEJCblNV?=
 =?utf-8?B?SnBNcWs2eUhpMlZNS0xvVy84MDlJMFRPRDJ6UlJ3QmdlU0VRM0U0ajZVYWRm?=
 =?utf-8?B?dzIrMDlHZ0R5S0NobmUwck11UzRtSkhkQWlBSkp1MGdmck1xdTB1OUo0WmM2?=
 =?utf-8?B?UTB5RjdGeUFmeHlNWWFBS1ZRQ3BsRFpDY1lISmxwN0pGaUpxOU5aRWtqV1Zm?=
 =?utf-8?B?VCt2YzlNQTUwRDBrN2F0ZDdFaDBwVG9ydnRrbTRjeUU3R1RoQ2dhWUplOElW?=
 =?utf-8?B?UGZ2UmxNT0ZUMDdjT0Z5VTRISEFZTEd0dDdRSUFTcFpocDRINDFkWVJGRFlU?=
 =?utf-8?B?QVdnMXl2cWV2bTZLRFhBZzEvNkxTSXFsdVZMcjdkZnZtWXBTUkdXN1pLZmhN?=
 =?utf-8?B?U3B1Nmd2RXlzYWR6U0lxdkZIM205UG9DN1lRL2JkV0FsUCtvMEozN1Y4TGxC?=
 =?utf-8?B?REk4dnFMdDVPM2FSRDdCaFFSbnJoa3hsTmE1ZDBTS2c4TzNlYVY1UUQ1bTNk?=
 =?utf-8?B?Y2dIYWw1Y29YbTF4a3kzSzJaQmwvc01ocUpnamFTTDNaUEc0NnNJWlg0UW5m?=
 =?utf-8?B?QkVqME8wN2pCZHlUK0VMQWZXQnFzSnh6S2tFWG5SdkxYKzAwYmFjd0JndEdx?=
 =?utf-8?B?Q1I0d2lUamRXKys1Y0hDT24rYklvMkV4QnpWVlIwZ2Y1Y0hETk1nY3podkUr?=
 =?utf-8?B?ZVZFYVhzUUdZb2FVN0dFY3hJQkp3RXg2MlJERTY2NTJBSjJ6eUV5c2QrZkkx?=
 =?utf-8?B?Wko0Y0d2VGV5ZndCTCtiVUp6N0dCMUJRWWkwUm1RWkxaNHNQS1FkMUJBTzY0?=
 =?utf-8?B?MjFqeFk2L21VZ1lyZ2h4eUdXN2gvOVA4Q2o5czFRZlVuaklZenpESDJoQWRT?=
 =?utf-8?B?VnBORGpYTkNUWDdNZFh4bmxTa0xuWVNPUjQyczFhU2RKV0Exb2VBMGVac2FB?=
 =?utf-8?B?eEI5eU0yY2FscVUreVgyWFNyNDF4WU1GQ2VFWXF0OVJxK0tHK2ZKVnovMW5M?=
 =?utf-8?B?eE5kL2R2VEQvcncvdWR1bWZ6U0pYNFQ0MGhpN1JmQnBpTS9LMkowR2E0TktG?=
 =?utf-8?B?Z1NQQlFSemYvY252aHV2L3pQVEM2NmJJMzFxVzlBV090ZTYvYTcvQlRWYnhu?=
 =?utf-8?B?aDVWZ0RQaVp4U1pSRnpOR05CNitWYXQvZERpamZ0d1dmaHBLT1QwbnVWWkNJ?=
 =?utf-8?B?dFFtaUt1M1pIblRMbmhIQzJvc1VpbGNYcnVVMmt0UE1GcWpoL2xRUy9hVTA3?=
 =?utf-8?B?WjM2bjZiaUc4dHhOSi9wRVIzQS9odHFlenBIcWU3Kys3cldwQkFLY0RhTitS?=
 =?utf-8?B?Q1k0Mmp4QUdnbjVycCtjemZwdWxtT3NvUW5XQ3NKU2ZZekpYdktwSk5zdmg2?=
 =?utf-8?B?dThsVUNKT1lVZmMrQTNCZGF6Ri9aZ3NYVTYrbjN1RCtEdXhkRy8waHk3b0Jt?=
 =?utf-8?B?cEVndStsemE1cUxTRWdXMVF5czBVeW8xSXBmVk5vc3NERWdmd0VQdHJxZi9z?=
 =?utf-8?B?UXVwanEyanM5UGxWZ1ZuaFFSR2dQWG4xYjYrNjQ3TUN4UG5xZjF2MXZvRDZi?=
 =?utf-8?B?cU9kVTVsODZDdEhPWGFuY1ptUnFhSkNDM20yQjV4UnJkSjlQU0ZMM1dnYWtE?=
 =?utf-8?B?aEpGZm8xN0RyVVpBYllDVzNDK1VNVHBTSEV3RHRyU09lWGQxN1pIUUJpZnl4?=
 =?utf-8?B?RmI1UUhJTmVIbFVGMS9qM0NRNURUcmt5d1I2azk0Wm9PYmxDbUNkM3hQc3Fs?=
 =?utf-8?B?QlE4NmxMRFlnWkdMSjFJVmVaZk5qTVFxUVB6QUdLQ3Iyd2E0SGZ4RGZZUDlu?=
 =?utf-8?B?bU9MSUNwZUFVNVEwMnlJeFM1V0FMNEpGM2JocjhGbjlMekt2cDY1R0RWS1M3?=
 =?utf-8?B?TktKN01HN3JqeTFNRHFMM0xkdVBrVzFaM1VraFUrZWRVTlBBTk1ZZnRkZHBN?=
 =?utf-8?B?VndWOUc5NEVERDlVYmVNR0NlTHBINWxNMURMSFl0QjZ5cm53dVcyS2NWUFND?=
 =?utf-8?B?Ky95MVV4cWlOdzU5TEFraExXUFp2N2U4c1dUY1Y5Rms4V2JIUWI2ZElMamFG?=
 =?utf-8?B?Tnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80A58633BD2FBF40859A9233985024D4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ff5aeb8-2e97-4e26-3c34-08daa5946237
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2022 23:09:54.7407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRUFhzoUYg+bfLr+hnhaF0t9lxXGCP48y8U9EuFhS7WUTKImFoPqlO4f11+YfNvdhU7Luy/wcUcSNSPUzvDQwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4934
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGluZw0KDQpPbiBGcmksIDIwMjItMDgtMTkgYXQgMTM6NDYgLTA3MDAsIEluZ2EgU3RvdGxhbmQg
d3JvdGU6DQo+IEFkZCBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVSIHRvIHRoZSBsaXN0
IG9mIHRoZSByZXF1aXJlZA0KPiAuY29uZmlnIG9wdGlvbnMNCj4gLS0tDQo+IMKgUkVBRE1FIHwg
MSArDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvUkVBRE1FIGIvUkVBRE1FDQo+IGluZGV4IDNkYzIyNmZmMS4uN2RlNzA0NWE4IDEwMDY0NA0K
PiAtLS0gYS9SRUFETUUNCj4gKysrIGIvUkVBRE1FDQo+IEBAIC03OSw2ICs3OSw3IEBAIG1heSBu
ZWVkIHRvIGJlIGVuYWJsZWQsIGFuZCB0aGUga2VybmVsIHJlYnVpbHQuDQo+IMKgwqDCoMKgwqDC
oMKgwqBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJDQo+IMKgwqDCoMKgwqDCoMKgwqBDT05GSUdfQ1JZ
UFRPX1VTRVJfQVBJX0FFQUQNCj4gwqDCoMKgwqDCoMKgwqDCoENPTkZJR19DUllQVE9fVVNFUl9B
UElfSEFTSA0KPiArwqDCoMKgwqDCoMKgwqBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX1NLQ0lQSEVS
DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBDT05GSUdfQ1JZUFRPX0FFUw0KPiDCoMKgwqDCoMKg
wqDCoMKgQ09ORklHX0NSWVBUT19DQ00NCg0K
