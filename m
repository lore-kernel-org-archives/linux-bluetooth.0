Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159DDC43219
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Oct 2022 21:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbiJFVBA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Oct 2022 17:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiJFVA6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Oct 2022 17:00:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E2FA4B8A
        for <linux-bluetooth@vger.kernel.org>; Thu,  6 Oct 2022 14:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665090057; x=1696626057;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ZoGz6l/doQJNQK1rVMDGb9uotpEtB2zWXPzxBHPsFhE=;
  b=XmLTmQOt4BsEAyAAmbgnPFGgwVU4xKjaWU0IBUuFHCU5CRz3EgWybVy7
   rDExd5gbKnbWVQYDgupgEoTQeKmY3OblZ7HKmeMX43F1EbTIHDntTB5Ro
   xBfAQN9gPTlOTmuWjQv6e5B2nCQ7XJFSOjsnPdlK50nZn7dF4Jx4wv1le
   kdUSxkEl5kT8KVkdeFcHYofEjg88Cb6yHGz7pCMbjdNTPneWg81l01xFU
   OhgUakBVjR9r+0GDecIGatgTNHEDIWG4J+umRQO5obMDCmZpPbcrSBfLX
   roeNEjbsBgOKZ4o53L6TlLJFDiuthcjiBx+ftWMH3YqQ+oQpA+N/ncgV/
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="301166495"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="301166495"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2022 14:00:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10492"; a="713999772"
X-IronPort-AV: E=Sophos;i="5.95,164,1661842800"; 
   d="scan'208";a="713999772"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 06 Oct 2022 14:00:56 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 14:00:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 6 Oct 2022 14:00:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 6 Oct 2022 14:00:55 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 6 Oct 2022 14:00:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVgdNPKOwdyaEkWFRSbrL76N6YMVgwXMzpLHDVIpDbxwsOjqpKFKRgbED9PS4DdIXdRNlxmiW/6UTL5xlzplSHj5mf3VLS5IRQrpPwAcSDzTZkGTeVXikINVDQb98M7ueXRySAWS/M+lmmf54a/wMGz9cls408qrvSQO9OGRId5OIrLAM5fPdKbUXCcg74coxshW0q+FjlSHlgLXY0mqXOZFuMowU0f4d7kbiJmRToxnqlN9OGArjdkDxUc2+FGu1f6R30dKIAU27zJyIumMn9/PIiRuFx0Whxi7D2OE7lcJxHFMi3cIRrFdQnjrLOsLyq2jh/xd+5QpYNjyQ+GHgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZoGz6l/doQJNQK1rVMDGb9uotpEtB2zWXPzxBHPsFhE=;
 b=jKnfmM+steCP0VUYc9xk3PWd5oYhGLzJQkDbIRfk5Q7eQcOzt34JTmju9WHh7YhOxbZSur/PbMItjsSPCnhfQcYwFnTfbIunWXFI/iGCI+ivhopz/cWUYgAs5yEj+F7BwuMOHCOHsyH2cM1uHYafPT9yhWXkVcRvImhYoPU4/61jEN7Qulj+1En0vbUKfVgwfm7EYi8twnhFlUsZdMBdzN14NnPDtTRP0nawuPkOZxBXWYY03uqikf6T7TrVU6w4FMn40iNbh9CQHfavL/28jxMDsW2MwStjZBEM14+IwJVfN2N+1N3kidxXGjjcHGw+bqUMiUIv9y/GMpOD8uFdNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by CO1PR11MB4881.namprd11.prod.outlook.com (2603:10b6:303:91::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 21:00:53 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::905d:e8fc:3d3f:a888%9]) with mapi id 15.20.5676.036; Thu, 6 Oct 2022
 21:00:53 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "isak.westin@loytec.com" <isak.westin@loytec.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ 0/6] Mesh: Fixes for PTS issues
Thread-Topic: [PATCH BlueZ 0/6] Mesh: Fixes for PTS issues
Thread-Index: AQHY2ZRkGuN2lytvDUSNf1n8/Bfu9q4B2kcA
Date:   Thu, 6 Oct 2022 21:00:52 +0000
Message-ID: <28afe97d8dec779a4f1a892442ed61b45777f867.camel@intel.com>
References: <20221006145927.32731-1-isak.westin@loytec.com>
In-Reply-To: <20221006145927.32731-1-isak.westin@loytec.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|CO1PR11MB4881:EE_
x-ms-office365-filtering-correlation-id: f27cb3b5-b191-4aa9-396f-08daa7dddb03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LLNKJ/gDMuxh5FKZREELDYFeos5UKcAe5r6cnhWwjnGPcDL/9azntk4+VWtrQDGc+TkI0EYlSoaxqi+A/Fa7aATENxOH7YIIi+alsE07TSZsKWFmsZpaRWrZgP2TsyJvjNGGjeMjc5KRQUbi40dyQqw+O2XXpUGyWMOCaSBt51HBJM9T4AwaxVwlhOi/xV5++sKdnrwEDaLL7kT6lJreDu/3CVouy2hySNkXrlkoRO7f5XEAq3/d2FHsE+WIx6Xi+sYJailYP8kB0UJ/EhDwu5UEScz2c3pPVo5LhhI9JN0/rjVEkxeQ9VpIgJnd9VFJ+RK5v1CpKineuum04WPhBzY9mh9JtovliYteiWBrc9zoXE2QxWQMOB3sK4XX8OvOvGmksgNpQut4wPjAVPahzBROh7WJLULzgBltalEJTsdiVRpHKydsKnlkfc/Y+lofqPVZytJGzLDAneHmHHvZUSUqn7oNY1O44/JFM+AJydyeaLiThitIvijx9alO1yAvAUNYA/XXCCuAXzx/eDGOAtk2hUqMLm1r2GJpQVNpYwh2uXmreDRPWexShkq54NPIIuTyl1L2Dqp/Zdwk6aemmF1qi/yI/DsnT+SAIkR3PXZanWVR5Y/5WOWz1wci7+0otLShUSjgkfPABtT60HxzIMPSi3eKlJIO0g+V2PETZFHcEat/YCdNcmMhsIZlHwKH6+FzNGIMjQYpCwrQDrdOE1JDO6fj2RYZf1ZHa7c/wvQ4gGTBUoDZogqNkGdSNoE/jmFuxwKmX1KvF/i/pByHjw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(346002)(376002)(39860400002)(136003)(451199015)(38100700002)(82960400001)(36756003)(38070700005)(122000001)(86362001)(76116006)(66476007)(64756008)(8676002)(66946007)(66446008)(91956017)(66556008)(110136005)(83380400001)(316002)(41300700001)(2906002)(8936002)(4744005)(5660300002)(2616005)(186003)(478600001)(6486002)(71200400001)(6512007)(26005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qk5OOHdTbWNnMmtwK3pDak8xZ0JxSmJwUkNWL2xYWVEvMWhVeWdwRi9LRnpE?=
 =?utf-8?B?bWtmMEwrNzhTMGRDSmVsVWNjcWUwVVVhSk4rdDBHVk5Wb0xRMmR5M3B3Myta?=
 =?utf-8?B?MGg3MVUwSm1XT3kzeWVwdDNxdHo3d2wyWG1leDZuam0yTlprVVZwaUo3Rlcy?=
 =?utf-8?B?NVlDbWRYSnRoNlM3cWtGZTErc2owN0dGNVg1UVJBcXpYSEdOT2YrS1pYaDlM?=
 =?utf-8?B?STArRyt4anpVT3RzUDl1dUZOc29LRFZ2MmtQOFFiYjM3ay9YWDdGc2RxSEVw?=
 =?utf-8?B?Qmx3Y1hHaEtlUVd2cUluODYyUHRPYkduSk1lMlBKbHpyRGUxbFI2OWw0QVBO?=
 =?utf-8?B?eElBU3M2VzhmNk91YnE4RXdNYUVKZTFCeWFBMXp3TnlGYVF1bndTRTc2QWw4?=
 =?utf-8?B?N2lKcEZJcTBmS2tMM0dldkJZSFBNVjAzT3BsVXhiME1sbnBmUVA5NldoWWkx?=
 =?utf-8?B?RjlZVVBQS3FIM2x1SmVKSU0yV1czSVp4cGVhRS9adnh6RkNZT1hadWZwWXph?=
 =?utf-8?B?OGhMY3JzKzE4ZTIvUDlRTjJOZVZsU253MUxXMG1kSnU0dmZzdjBYMjBsM2hX?=
 =?utf-8?B?aXJOQWlnVW5FeWRFN1hFOTdMdXNSS3I3QldPVWZjOGl6QWhKOHAyNU9DcHlz?=
 =?utf-8?B?SGxEYXMyWDFvSVRtdEFMS29LS2s0SWhaeWhHUnpGSENMZmluMDJPbWRpeTRn?=
 =?utf-8?B?UVE3VVMzbkxSemI1QmR0bnJZQWtUaE5Tblpxc2NWZ1RQVElqYUxaaS9LYWdz?=
 =?utf-8?B?QnRsRGJld3dzeFNuamtDQWFub3YrYzlKVTZpQklRUVNkY0JnaUp4a2VsY1pt?=
 =?utf-8?B?N25teUltbWJWK0pza3BUVVNDb0M4VFA3Q3dxVnk5dlJtTzBDVVo3SC9BVWpu?=
 =?utf-8?B?NytlNnMrUldmMjlWU25aVWE2di9yR1VKaDJPeHhpYy9TTTF6d2ovMzBoSU9k?=
 =?utf-8?B?MzNORWhybFJBamlLQ1RzbGQvU1BkUWlBRlhVRUUxS3hvVmhKV0ZJVWxkRDVn?=
 =?utf-8?B?UzMyTEluRThXVlUzS05sckxqT2Y2ZGJSRit4TGIyVVpadGxUeUxIQ0hUdnFL?=
 =?utf-8?B?UlFOZEJOOXpZOUNMMjhMeUQzMUdoZmtrNXl0Vlp4VXFjeVI2L2g1YlVibmNR?=
 =?utf-8?B?eTJYc3F1SG5EUTlLKy9EWnVvb0xPd3VXeU1qMlV3cTBKWjVZeGRBeDlWYVFL?=
 =?utf-8?B?eVFCUVBoMG1FdWFiWE1oNTROVHRhUFRQb0NZOXVtTWgwOVhGOVh6UXFZRlRa?=
 =?utf-8?B?c24wdi9LSWVtc3VZQjJqcWhtQ1dna1lheHo3YlVWWDNtSjlHOEJDTTRtU1l3?=
 =?utf-8?B?Vkw5eWZiNi9mMCtkQ09hSEZaQkpsZjRDVFllQ1FqclJEYWF5Q0dlZVV4VmZW?=
 =?utf-8?B?VTFyK0p5emp5ZTRhc290R1JhNk5tTlJHMUZJUExmbW9RUjZ1OFBmbHlLT24z?=
 =?utf-8?B?R2dQajBHYWVhdVQ4TEJOV0JuWkRiVk1vZEpuc0JYc1N3dVZ1VzFqSW5wWnlR?=
 =?utf-8?B?NXIwTzhIOTRMRTRjY1ErUm96WmYvcHJjY0NBaDNsQ1ArOUpxSVhNVUtNdTRq?=
 =?utf-8?B?MUVFcjUvelVsblFjMEc3RmtIdzNiR3pJUzFiaUdPR0E0cVRIL0c0b3ozUVBw?=
 =?utf-8?B?RUUrUlY2K0cwZ3EwbDIzK2lsT0duWEhRUUdWbGZzb3JVUlpabnVObGNQa3Ax?=
 =?utf-8?B?Zk5pQ3JhZkZUZ215VjBiNGFoY01rNnpRWFRFYlhsWm45QkFzd0FRbVZRL3Zr?=
 =?utf-8?B?eVJDWHBRaFJ3SnZ1SE55Tk96cm5mVEhVdmJWOWZTR1VQb2pZT254dzJMVm5w?=
 =?utf-8?B?cTNUSUdSN0NVREphT2F5c3huOFFLakFyY010NzE5WUMvV2xWVnlMR1U5ZjdO?=
 =?utf-8?B?NTEzYmZHMEljUFNubkJiRkg4T01aUE9xSFlqN2I2UzFtdlA2anBKY0xTMUJG?=
 =?utf-8?B?OHZaaC9OOHgyRWRWWFRlT1UyQUNzRDZkU2VlcS94Skx2bmcwdlRkZmdlZzV4?=
 =?utf-8?B?UFFQVk1yZmJFUVZvaWpuTXF0NUNUcGFWQjV3SWpTT29RaE14QjVFTnpjK05t?=
 =?utf-8?B?bStWWk80SnJiaG1HM3djMjVWVyt0UWZkVzRGOVNScVBkRXlWajdhKzUrRnpL?=
 =?utf-8?Q?sQjf1GylO0z6Ls8QXu6YTwk0G?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA60F270DE29624384A13EB5B73684E5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27cb3b5-b191-4aa9-396f-08daa7dddb03
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2022 21:00:52.9910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: D/ztQT9cgRWCI12V2ApAQaMpoAV1NONH2Eedi2p1gV3NaD+uej8ngCD9/Ir5bSdGs9D6JUZzPqMFzFyfjOnWpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4881
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSXNhaywNCg0KUGF0Y2hlcyAxLTQgb2YgcGF0Y2hzZXQgYXBwbGllZC4NCg0KUGF0Y2hlcyA1
IGFuZCA2IGhhdmUgb3V0c3RhbmRpbmcgY29tbWVudHMuDQoNClRoYW5rcywNCi0tQnJpYW4NCg0K
T24gVGh1LCAyMDIyLTEwLTA2IGF0IDE2OjU5ICswMjAwLCBJc2FrIFdlc3RpbiB3cm90ZToNCj4g
SGksDQo+IA0KPiBIZXJlIGlzIHRoZSBsYXN0IHBhdGNoIHNldCB3aXRoIGZpeGVzIGZvciBpc3N1
ZXMgZm91bmQgZHVyaW5nIFBUUw0KPiB0ZXN0aW5nLiBUaGlzIGNvdmVycyBmb2xsb3dpbmcgdGVz
dHM6DQo+IMKgLSBNRVNIL05PREUvUFJPVi8qDQo+IMKgLSBNRVNIL05PREUvVE5QVC8qDQo+IMKg
LSBNRVNIL05PREUvUkxZLyoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gSXNhaw0KPiANCj4gSXNh
ayBXZXN0aW4gKDYpOg0KPiDCoCBtZXNoOiBVcGRhdGUgS2V5IFJlZnJlc2ggZmxhZyBhZnRlciBw
cm92aXNpb24NCj4gwqAgbWVzaDogcHJvdmlzaW9uZWU6IEhhbmRsZSB1bmtub3duIFBEVXMNCj4g
wqAgbWVzaDogcHJvdmlzaW9uZWU6IEhhbmRsZSBmYWlsZWQgcHJvdmlzaW9uaW5nDQo+IMKgIG1l
c2g6IHByb3Zpc2lvbmVlOiBDaGVjayBwcm92IHN0YXJ0IHBhcmFtZXRlcnMNCj4gwqAgbWVzaDog
S2VlcCBjYW5jZWxlZCBTQVIgZGF0YSBmb3IgYXQgbGVhc3QgMTAgc2VjDQo+IMKgIG1lc2g6IEZp
eCBtc2cgY2FjaGUgcmluZyBidWZmZXINCj4gDQo+IMKgbWVzaC9uZXQuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMzMgKysrKysrKysrKysrKysrKystLS0NCj4gwqBtZXNoL25vZGUuY8KgwqDCoMKg
wqDCoMKgwqDCoCB8wqAgNCArLS0NCj4gwqBtZXNoL3Byb3YtYWNjZXB0b3IuYyB8IDczICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAtLQ0KPiDCoDMgZmlsZXMg
Y2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pDQo+IA0KDQo=
