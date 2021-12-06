Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3997EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Dec 2021 18:32:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhLFSfq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 6 Dec 2021 13:35:46 -0500
Received: from mga05.intel.com ([192.55.52.43]:30461 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233544AbhLFSfn (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 6 Dec 2021 13:35:43 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="323630430"
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="323630430"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 10:32:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,292,1631602800"; 
   d="scan'208";a="562894884"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga008.fm.intel.com with ESMTP; 06 Dec 2021 10:32:07 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 10:32:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 6 Dec 2021 10:32:07 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Mon, 6 Dec 2021 10:32:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OaYqnODiFaQlX2jehfX0sED/Ah7Yxuv6MySGBZsrzso0yu69/zbtSYxkJuMkfHmIeikHjkVf0xLW10OBwEwiqN5bg+PQph5KF6IoxPPVHtToS5o+84wn/+282AhDK+Jhc3uGJq9jHuk/8C1JWJkhibxxJXMErFCmKoKSdIb41WslXckAmb5rW7RFfY7z4wAs1iXMAcuXJecy3nNdbUaAUpFtkFAYgf8guDoV2KwnTtPtbykqiHlqDxF0yB/4lxTOr9CKFG+g91IOvvQTH8jZ37HTkWtAHqeRFb0rhX+Tp27iBEEv5RCFd/DmSu3TCfSXq5PJMW1zw0aNRW6XPMdMQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4KfiFEUdwxzYzSu0U1g634vRujr2Sjao4QTeYPUSck=;
 b=WIuuZQdZvpLmjeLp5b+kY4t9npRjTkcytDr1dlG9XjqE1osj8dEfD5XuvIcs6FqOuUoz+yIb3wxWP83MnfxZBjxc1pWJFOOFRX99w8/hA+UKa/15HrQfuIHg7FxjI1N/K8x7qUCCozanEpvzxt7keYjw9nMq24nQ024TluMlt5bTcdd9EnT+S02AiGf1pSgavjEO20EgfD9XL82pA/VoNr/ohtrhLP8GOeJTSfiEvkniqflYVbEGwuG3oE85NbekxI/XJfVmCTo99R0mhFDri1xG13XPjXLgo5D2sKMg7diZ+d3jBWcl9HfxJw/13kDzIO/H71TXSEh+h1vy6V1e6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4KfiFEUdwxzYzSu0U1g634vRujr2Sjao4QTeYPUSck=;
 b=U5mjT6hX4NkI/DP8xzLc+aAhJCZSdN7uCgnslfZP7eTQMmelzCh1JmAHQOdTggytvV4mD5Fnko+hJQQypT8i03jK5RaAsXolxjJ8O3Tfz/wp8YO46zMLSoaAi1RfrHVOGG1e6g9mOw0ZFK1BwMoy5osRjDdfic98BQMrkY4SGW4=
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SA2PR11MB5033.namprd11.prod.outlook.com (2603:10b6:806:115::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Mon, 6 Dec
 2021 18:32:05 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::d4ff:c285:74cb:c2d6]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::d4ff:c285:74cb:c2d6%5]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 18:32:05 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Don't log error for false positive mkdir
 failure
Thread-Topic: [PATCH BlueZ] mesh: Don't log error for false positive mkdir
 failure
Thread-Index: AQHX5kACsyeN3YNxZUSLlDO9ySUqLqwl0qCA
Date:   Mon, 6 Dec 2021 18:32:05 +0000
Message-ID: <abf0f388e0c2e135b956476d5a6b2d53aea942e1.camel@intel.com>
References: <20211130231412.97437-1-inga.stotland@intel.com>
In-Reply-To: <20211130231412.97437-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.4 (3.38.4-1.fc33) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 04dc7710-7ff5-459c-c8e3-08d9b8e6b40d
x-ms-traffictypediagnostic: SA2PR11MB5033:EE_
x-microsoft-antispam-prvs: <SA2PR11MB50330ACC65A1B67DE9000417E16D9@SA2PR11MB5033.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tiRokfmmHk4Nb6i68HzC4z9DbxdlupMdc/b84yrAtlqSKPdg86tpg8kIQYyEuh4m1PpLNu/qWxs71DJlMQMrQmU/Rpv0Vv8w9mIbXd3rApD9+paD1HQSAOTIGa70XlAs0YOuNFRlZ0z87qdXX2bgpHTbeIupbZoAGq+HEhO222Vb6XOOxWQcFei2OBoua5ZLs6BDbfRBSsGEyK8iY01/XfP7nywmKTl6nzrUObjEWYNOMIMle4hqHDOcs9DYaSmipJObzEqFiecYR+5NOOs9v4wPucCembVYtxWwAwmVGiuvQ+GPuLQK8WO2scE5aaTV646uiHZBZlVYby/4ahNgNCkAgFPx/s02e20Z6OmIEKt40qvWFJ96YB43mvFzlgIahq06nw8QCZSskNTAHMN6Fvi1JsA1J/Ca/vBt8J81t0jt4TexJsT21qCgiG/rwKbTTNTIoPVJNtVbQde+0J7wSBDv69Mx/767YaqG34w6VNQpg4oh2wG0UCq/jV0McNBiaPk+vfngCOwANYow1zjhjeZoWWHc4FT7ENAM+Vx9+7tTr1kqXfT9CUsnE/8qEjGefinAw7NdYomDl2Ya9Xdhhw+p4ko7tl5Fniy4msM5UR9NzfClA8n87eQCrvEQynn4YMIcPDJGOuYLTme5dwaS6gF41JjOMvC8WJTntxDQcHRNzGJKQgbziLGEfNIPINuEiDZs0DySAesU63JzsHu8nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(71200400001)(86362001)(4001150100001)(8936002)(2616005)(83380400001)(186003)(26005)(91956017)(36756003)(316002)(6486002)(76116006)(64756008)(66556008)(66946007)(122000001)(66476007)(2906002)(66446008)(6636002)(6512007)(38100700002)(110136005)(508600001)(5660300002)(82960400001)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S1BXczdqbGx2UzR5TGpaSDl4WHNJZXRoN3ZCWkxBM3ZEZ0tDQWVQOGttTTJ6?=
 =?utf-8?B?MkpBNlJUdHhJdUlqYU5GN2hqMXNoS3UvK1hnN3E4SUpWRVlTbnVyZlR3VitV?=
 =?utf-8?B?UTJiR2xLaStzUTNiVjlEckZFMkdSdVBSVExtTzQ1RkZscXYwVEtIWGdIcUlR?=
 =?utf-8?B?U3UwcVRtTUlpcXAyQng2dyt3WitaMWsxZmhUWU9rd2RPLzF2L1QzRmlOdS82?=
 =?utf-8?B?VG5yZFozZkxoOWp1NmFQZURiYStQVXdpdmNweXY5RlgrVXBRMFNGcVhOMXV2?=
 =?utf-8?B?aWRvNUxjQjU1cjFBN0ttcXp0dEJJa0pLUjMwNWJKc0ZJUDc0Y3V3L2JRVlhC?=
 =?utf-8?B?Q3hmcjdPcG1wejd3dWFwbkNITXNNQnRsOTl5allZcGhZTnRQQVJTRVFON3hX?=
 =?utf-8?B?SG9CZmFQL3JhZ2ZYdmFKSmpzWW81eHE0cUh5VHc0TmJxVkhYTlVIZ2NaMXQw?=
 =?utf-8?B?b3FIL2NmdW5oUTg3Q2t6V29ubTJFQkJPVXlRdXU1TmtnT1U5SFp0T1VuMlUz?=
 =?utf-8?B?Q0hnVG1VdExZOENwMVZWeU9pelFSK1d5TjEveGF2bXpnaEpPOXAxMkxTWkVM?=
 =?utf-8?B?dVdKcU5pYjVBYWxZTmtXdkpaRUp1SG0ybC9GeFdrbzhTWElyVHdHUnVVM0xM?=
 =?utf-8?B?aENIL1h3dkpNeExoNEZtdTlKNVhZRW9yYmdXWTFQZTNQSDBTMUxCTENyaFlj?=
 =?utf-8?B?L29WZEs1elI2emRTVFVidzBTV3BrWGM2RWNST1c1YWxmU3ZmU29Gdy9YcDNX?=
 =?utf-8?B?WlZraENWRlp3NFliSzZYYjMxalNzZHRVSFRSQWNpQ1FnZjRycCtIS3p5UWpW?=
 =?utf-8?B?Tzd2SmdIRkhEOG5lMHk1SEhNcjNNQ2xBZVg2WnpZSktYMVZWWHdTTjQ0REdH?=
 =?utf-8?B?aUxPUjRZL0J6SDVJbEhKNzM5Z0ZDRGhaNUpabXFYSVZ1b1VDMVdIYmdWdnVv?=
 =?utf-8?B?VGNkWVZVZUxPQStiZlJsRXVXUFhiTmFFVlJpTG85N09zUXhPcG1mL1ljV3N1?=
 =?utf-8?B?dFl1ZzY2YmJOaDE5OTRNYkx6RVJKR01waExCYzhQYTZlVE1tZVpueWJaNUU5?=
 =?utf-8?B?Y2xGZmxzaDIrSVQwckhnR0NqQzJrM1hsU1JEUU9INHEyYjVIY0VvbzB6UjB0?=
 =?utf-8?B?MUNCYXpSSG5iK2FPOXhBQnU4alpFeDJPbXdpblpMakR3cjEvZm1RbzF3VHVL?=
 =?utf-8?B?WFNuRXkzcDdHVk43VGNYeTJPOSs3anBSRE5sTzlTSWU5RWxkNyttS3BpMjdp?=
 =?utf-8?B?ZXZWUTE1M2RsZGVaMWE3dVRVc3FjRmxCQXE0NktyaUFqNWVzM3JFR0xSZ01m?=
 =?utf-8?B?SE4yOUROZzNwUDlQWFNXeE9hOHRZMVBVdUNiS1pDWGg5Wk83Z01BT0ZTOUNG?=
 =?utf-8?B?UzJwWW9JOW9rRUNTT3c4cTNrUldiVHh5S0dyd09QeGdSLzNmd1dnbzFnRjMz?=
 =?utf-8?B?SUtmZVE2VWZCeVh0YjdLMGI4OG9JVFZFN3U2Qm9aRVFaYlRhendJZk1BRUFx?=
 =?utf-8?B?N3JTeTJDb3ozTDEyODRqQkFHcTZNYmtCVHpnZFM3OHVaVXA0OHZCTitRZmtW?=
 =?utf-8?B?KzhEMnlHTENZVlBIZDdzcmgwbkJmTmZELytEZ1JxUlFhWTVNMm43RDVtMUZj?=
 =?utf-8?B?eW9GTzRRNjJBRXpoTzZhR01ZMnhUb1pDRENsQzBQQ3RxUE9uTWZlL1Y2d1Fn?=
 =?utf-8?B?V3N2WXNYYWNIMjZSQWFhVzRBdExaWmw5amEwU3F0ZHVwZW5PMjJpU1FXYXFP?=
 =?utf-8?B?VjNaMVRVL2NJUWQyYTNtL1ZWV2RTMmhTZ0taUFpwakJpazVrK3hlV0xNNUtz?=
 =?utf-8?B?RW9RZzFXakxLc05yaUpIWjVVZDdPTzFieDZCQkE4aWFSa3c3L0RmTUdnem5P?=
 =?utf-8?B?T0pLbXV2anM2RW1RQUNHblZTSURsYTNyRmJCbW9nMkRib2xsbHVSdy9CWFhq?=
 =?utf-8?B?cFZaMFVPQndhMEN4R0NzT3ZXU1liY1d0c3p3V2ova3pURWhaK0VuOHBYeU5l?=
 =?utf-8?B?dXFBT1BQWUh3a0tSdUNZemJiSHhzVWJiL0dMTE1IaENyazRmdy96N2RZa29m?=
 =?utf-8?B?YlBhZENhMmpLU3BlZll6UytNMlhwZVJ0VHBuTjFtZjdDTHdQTmpRb2VPOWRK?=
 =?utf-8?B?Nm4vZnoxcU5BM2R0UHZCYWloS3cvdEZ5YTlqQ1ptOVBNSFAwU1VvNFlnay9h?=
 =?utf-8?Q?ZiaW32dez/wjlNr0d6zibhA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA952C941D06CF4881399ED42E9747B4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04dc7710-7ff5-459c-c8e3-08d9b8e6b40d
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 18:32:05.1630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: muIdZYiNAahRWj5vTlxY0csAPPza21DzyAEnwLSOBsGvqRSAMOeGzH4DG7jki7UE1fj+bPRwxo0q9U1pBFcJ3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5033
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCwgVGhhbmtzLg0KDQpPbiBUdWUsIDIwMjEtMTEtMzAgYXQgMTU6MTQgLTA4MDAsIElu
Z2EgU3RvdGxhbmQgd3JvdGU6DQo+IFdoZW4gaW52b2tpbmcgbWtkaXIoKSBmb3IgbWVzaCBjb25m
aWd1cmF0aW9uIHN0b3JhZ2UsIGRvIG5vdA0KPiByZXBvcnQgYW4gZXJyb3IgaWYgYSB0YXJnZXQg
ZGlyZWN0b3J5IGFscmVhZHkgZXhpc3RzLg0KPiAtLS0NCj4gwqBtZXNoL2tleXJpbmcuYyB8IDIg
Ky0NCj4gwqBtZXNoL3JwbC5jwqDCoMKgwqAgfCA0ICsrLS0NCj4gwqBtZXNoL3V0aWwuY8KgwqDC
oCB8IDQgKystLQ0KPiDCoDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0
aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gva2V5cmluZy5jIGIvbWVzaC9rZXlyaW5n
LmMNCj4gaW5kZXggNTE2MjE3NzdkLi5iNDQwOTExNTQgMTAwNjQ0DQo+IC0tLSBhL21lc2gva2V5
cmluZy5jDQo+ICsrKyBiL21lc2gva2V5cmluZy5jDQo+IEBAIC01MCw3ICs1MCw3IEBAIHN0YXRp
YyBpbnQgb3Blbl9rZXlfZmlsZShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBjb25zdCBjaGFyICpr
ZXlfZGlyLA0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGZsYWdzICYgT19DUkVBVCkgew0K
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHNucHJpbnRmKGZuYW1lLCBQQVRIX01B
WCwgIiVzJXMiLCBub2RlX3BhdGgsIGtleV9kaXIpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgaWYgKG1rZGlyKGZuYW1lLCAwNzU1KSAhPSAwKQ0KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgaWYgKG1rZGlyKGZuYW1lLCAwNzU1KSAhPSAwICYmIGVycm5vICE9IEVF
WElTVCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
bF9lcnJvcigiRmFpbGVkIHRvIGNyZWF0ZSBkaXIoJWQpOiAlcyIsIGVycm5vLCBmbmFtZSk7DQo+
IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IGRpZmYgLS1naXQgYS9tZXNoL3JwbC5jIGIvbWVz
aC9ycGwuYw0KPiBpbmRleCA5YTk5YWZlN2IuLjZiYjM1MzJiMiAxMDA2NDQNCj4gLS0tIGEvbWVz
aC9ycGwuYw0KPiArKysgYi9tZXNoL3JwbC5jDQo+IEBAIC0yNTUsNyArMjU1LDcgQEAgdm9pZCBy
cGxfdXBkYXRlKHN0cnVjdCBtZXNoX25vZGUgKm5vZGUsIHVpbnQzMl90IGN1cikNCj4gwqANCj4g
wqDCoMKgwqDCoMKgwqDCoC8qIE1ha2Ugc3VyZSBwYXRoIGV4aXN0cyAqLw0KPiDCoMKgwqDCoMKg
wqDCoMKgc25wcmludGYocGF0aCwgUEFUSF9NQVgsICIlcyVzIiwgbm9kZV9wYXRoLCBycGxfZGly
KTsNCj4gLcKgwqDCoMKgwqDCoMKgaWYgKG1rZGlyKHBhdGgsIDA3NTUpICE9IDApDQo+ICvCoMKg
wqDCoMKgwqDCoGlmIChta2RpcihwYXRoLCAwNzU1KSAhPSAwICYmIGVycm5vICE9IEVFWElTVCkN
Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX2Vycm9yKCJGYWlsZWQgdG8gY3Jl
YXRlIGRpciglZCk6ICVzIiwgZXJybm8sIHBhdGgpOw0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKg
ZGlyID0gb3BlbmRpcihwYXRoKTsNCj4gQEAgLTI5Myw3ICsyOTMsNyBAQCBib29sIHJwbF9pbml0
KGNvbnN0IGNoYXIgKm5vZGVfcGF0aCkNCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gZmFsc2U7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqBzbnByaW50ZihwYXRoLCBQ
QVRIX01BWCwgIiVzJXMiLCBub2RlX3BhdGgsIHJwbF9kaXIpOw0KPiAtwqDCoMKgwqDCoMKgwqBp
ZiAobWtkaXIocGF0aCwgMDc1NSkgIT0gMCkNCj4gK8KgwqDCoMKgwqDCoMKgaWYgKG1rZGlyKHBh
dGgsIDA3NTUpICE9IDAgJiYgZXJybm8gIT0gRUVYSVNUKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoGxfZXJyb3IoIkZhaWxlZCB0byBjcmVhdGUgZGlyKCVkKTogJXMiLCBlcnJu
bywgcGF0aCk7DQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gdHJ1ZTsNCj4gwqB9DQo+IGRpZmYg
LS1naXQgYS9tZXNoL3V0aWwuYyBiL21lc2gvdXRpbC5jDQo+IGluZGV4IGQ1MDVlN2EwYy4uODJi
NTdmNjQyIDEwMDY0NA0KPiAtLS0gYS9tZXNoL3V0aWwuYw0KPiArKysgYi9tZXNoL3V0aWwuYw0K
PiBAQCAtMTE4LDEzICsxMTgsMTMgQEAgaW50IGNyZWF0ZV9kaXIoY29uc3QgY2hhciAqZGlyX25h
bWUpDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgfQ0KPiDCoA0KPiDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cm5jYXQoZGlyLCBwcmV2ICsgMSwgbmV4dCAtIHBy
ZXYpOw0KPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKG1rZGlyKGRpciwgMDc1
NSkgIT0gMCkNCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChta2RpcihkaXIs
IDA3NTUpICE9IDAgJiYgZXJybm8gIT0gRUVYSVNUKQ0KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX2Vycm9yKCJGYWlsZWQgdG8gY3JlYXRlIGRpcigl
ZCk6ICVzIiwgZXJybm8sIGRpcik7DQo+IMKgDQo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgcHJldiA9IG5leHQ7DQo+IMKgwqDCoMKgwqDCoMKgwqB9DQo+IMKgDQo+IC3CoMKgwqDC
oMKgwqDCoGlmIChta2RpcihkaXJfbmFtZSwgMDc1NSkgIT0gMCkNCj4gK8KgwqDCoMKgwqDCoMKg
aWYgKG1rZGlyKGRpcl9uYW1lLCAwNzU1KSAhPSAwICYmIGVycm5vICE9IEVFWElTVCkNCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBsX2Vycm9yKCJGYWlsZWQgdG8gY3JlYXRlIGRp
ciglZCk6ICVzIiwgZXJybm8sIGRpcl9uYW1lKTsNCj4gwqANCj4gwqDCoMKgwqDCoMKgwqDCoHJl
dHVybiAwOw0KDQo=
