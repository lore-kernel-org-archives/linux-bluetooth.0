Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEEC433ED
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 02:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 390556115C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Apr 2021 02:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbhDOC0X (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 22:26:23 -0400
Received: from mga11.intel.com ([192.55.52.93]:62248 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229475AbhDOC0W (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 22:26:22 -0400
IronPort-SDR: BzS6/KXfBpfiLtB4B97mD14nmm7+A90xnnP9EufijjAkgKVeox3hHE5w1l0WqLiL5Otyw8QU2o
 3ayF/1Igp7TA==
X-IronPort-AV: E=McAfee;i="6200,9189,9954"; a="191588583"
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="191588583"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 19:26:00 -0700
IronPort-SDR: nodMgDHlXpQuU2+2SmMcKW8rzbM4TfhG2X4VN7Q0GUbR6UVElMl+HhHEve3C+FpzeaDf7ZxlL/
 k24BoczrqaDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,223,1613462400"; 
   d="scan'208";a="600995725"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Apr 2021 19:25:59 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 14 Apr 2021 19:25:59 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 14 Apr 2021 19:25:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 14 Apr 2021 19:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fX6SswbJRxcdjyy4LNUE6pjAIPjpDZhYxS2NP8kQJn4d3hL93SYGkCSAs+nFmkRX8CskLxXbJFT383RGrQVRXpj1MjcjyON6RuB35/+tWmGxqGnCx2eIgjyUVHI8yBczd2agRh+JdFRMfutkFyjFcoHfI5e7+SKe4QBtLzMvslZinC+/2RvBTYOoTHsT+JOMQ9xX2mnn0/5/qOqqz0coQkZpQs0hi5oQ4OJMOcH+xGa9V5+f+b5CL2ifh8bySukrouZ2edo+K8TzHM7dEfX551wqSidA76B8k4UOCh95bXilH6MfH46t7VVQkYZG1LHTCJm1yE6vdJgvKA2lQMuHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa9fTBIMOeSR6fK2D8zS4U0xY0nLkfBPWnYovWMGmPQ=;
 b=hlKX1V5jmZo67F4BnzrZuasQhCVrogZrdB/PHS4gyQSwBBPuokJqC+Ar8BrVzrwGlPRuyYiaLtdG/PvvRuS22mRA5MDqZY+BpvE9d4hFADna6wjmRPJxcMekQWGRK/Sxuc8X2EsBGB2i8wnianc+j4HnQiHjPIuMJsv0e+cb/puUj3lLSEK84aGoXyhnH8UtTbfvMfid+PBt0v3wvo8SaDeg7sc3YUZIhJFJpsAFFVG1atP7kuVacdp+wV/LquSprxQPyCoUPQvm+Jw7hhmsJtt1X1AOaNleBxGxXHmDTVsRzmy6+pAbCOBlXAgUpXWMPpZHVwwMbE5EUDmIZI52tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa9fTBIMOeSR6fK2D8zS4U0xY0nLkfBPWnYovWMGmPQ=;
 b=Be8YAgZ1rv3gbsCardW0wMJNxTE7uTqwaW1HfuM7OFfUUUog7FFogM2khTjBxnafXtpRBhm5qf4OPO5l3MADeZPF/D8voNfgAwvr+jD6xI3xERO4EuUuLRh9FqOd0QEKCcCTQDSj+bs07TW1E+DFPWrENh5aiRh9l7M1plWFvE8=
Received: from MW3PR11MB4748.namprd11.prod.outlook.com (2603:10b6:303:2e::9)
 by MWHPR11MB1919.namprd11.prod.outlook.com (2603:10b6:300:106::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Thu, 15 Apr
 2021 02:25:56 +0000
Received: from MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::a995:ea7a:29cf:d212]) by MW3PR11MB4748.namprd11.prod.outlook.com
 ([fe80::a995:ea7a:29cf:d212%5]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 02:25:56 +0000
From:   "An, Tedd" <tedd.an@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [BlueZ] monitor: Fix the incorrect vendor name
Thread-Topic: [BlueZ] monitor: Fix the incorrect vendor name
Thread-Index: AQHXMOgk15dMr1hDQkWBJ+Hvf6uh16qzym4AgACbvIA=
Date:   Thu, 15 Apr 2021 02:25:56 +0000
Message-ID: <34494443-5CE2-40F1-95DF-EF05914BD741@intel.com>
References: <tedd.an@intel.com> <20210414043857.371176-1-hj.tedd.an@gmail.com>
 <6D9FBA0A-3058-4C96-8CFD-6BE5B585DE8E@holtmann.org>
In-Reply-To: <6D9FBA0A-3058-4C96-8CFD-6BE5B585DE8E@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/16.48.21041102
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [76.115.118.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1dc848b-a1fb-4374-a984-08d8ffb5cd10
x-ms-traffictypediagnostic: MWHPR11MB1919:
x-microsoft-antispam-prvs: <MWHPR11MB1919342CA38C0FB2E7FC6CBFFF4D9@MWHPR11MB1919.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fUoH793DZvx4TtSKb7nolgQ1lImrslAsyxd/s+5SXXMGwhsYyRrXkN/vgH+bzzJLenGzgFK7k1oASJ/0dtqhbf9f5JuaMejGC6b/yZ+PS7C1ZwQekwETE1xrHDYYHn7GheP7TnQTzEG/h1pHRUVuXV7jwqGfGZn9czdk3MbQis9ZSKDMbOP26YFBwCmA6Zlspg5iUUv2EvnADChycBKZU+k3GPvFnX6E/WGIS/WlLjZXCMx6CmwncxU5asvjcqzeSeJ533/FhDrUQqlgLo9rHXzC5rm5xZtvStjqS9ZY8xoqhxI5QNmXUtcb883JLk7t/GFxO2xMfJCza4suvzARZFZwJRTag918S9M2Y+FrsmtFk+ToQlF1BV65t79pVpB+6W1OPj4Qdgihq+FoOdLqqiJnorbAy64oLBjMsFsfz9VGNFP8GF99ZtSD7AeFR0a0y5XCzi4NJbTA8twqSG70S7MihCE4g2kaCli5MWjbqznl0XdLsyLtSqDrjl4QvTpdOMS0CKGXMgXjICLJKo3Zz/enuY+/Rb8voR0TsdgYyg/nixr/kUAvw+qHk3rtX/0KX+QCcN+SpA4FfZ5ezxihFVlb/V7PARrbuUw6zzeYZBI3KLOOSKvqyAf9pxmzG79gkNn0PSkEa+AmbvPkmiauox+SugIlauFQNoyEc6y6jjs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4748.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(366004)(376002)(346002)(396003)(6512007)(2616005)(36756003)(66446008)(186003)(2906002)(33656002)(5660300002)(86362001)(8936002)(38100700002)(66556008)(71200400001)(45080400002)(6506007)(76116006)(6916009)(122000001)(316002)(66476007)(66946007)(83380400001)(4326008)(26005)(64756008)(478600001)(6486002)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?aDluWncvc1g1bERlYVQvb3BDNzJ4NUphWHZCY09XR1NUOVVKc21Wa3lwc1J0?=
 =?utf-8?B?TklicnBnUjFyNlZBVHNmTW1lYzZvWnF2VVhwV0M0cGVUbnFXZGU2VVN0Nmhy?=
 =?utf-8?B?RGdJUTBOS2ZvclR6ZlVta1hXZDFmcXJ6cHIrWnVyeXFsV2dpYkNHeUIwaVhO?=
 =?utf-8?B?ZG1wV3ltckJ6RDhsbmx2Y1JTcnhKblNvQVl5TVp2VjJSY2NrSXZSQzNqbHcz?=
 =?utf-8?B?cTVwaGNtS1RTbU9rRmR6aXlZbDJwQXN1UFlqajlqbHhXazcvNUk0bHNsUWZB?=
 =?utf-8?B?a1hoQ21oNVNBaU9sWHEzODMxL0lWeW1MUDZxTnFVMEVhWklLSGNpY0VFUisz?=
 =?utf-8?B?SnBhRlJpcVI4SXVxNVhKcjR3bmdaMjVPWmV3QVNKVVpGV0FMcS90SDdtbStF?=
 =?utf-8?B?SWJyVE16WWh0ajRUVWY1VmVZSkxTM0QyTThPYlVFQkxXbEtveis4RWJqZ0xa?=
 =?utf-8?B?cUllNEdYcFBMTDB0MXR6MTF1UmRIU0tSTnlpdUhkRUV3YkFyOWFveU0zMTFx?=
 =?utf-8?B?bnRRUWpzQWM0d3VzYTNpTGx1TzJ4clZaUkp1T285YUdDRGtNTlpydk5FWHZv?=
 =?utf-8?B?b0lzbmxnSzVWbjBxeVBHazdYMWN4dWdTNHpFRHNaTEVDSTI0TVNVTitaakpB?=
 =?utf-8?B?VkJvYTI4Y2NTNXhBK0NNZEJweHR3UlJUS0YyNGNYczJjYVZsc2xCbjBNNGRY?=
 =?utf-8?B?NHZ0NUVNK1FXbXd1VCt2Y1doVmVyMzNRUyt1SmRMTzVFQk5McGtnOHVSWHI5?=
 =?utf-8?B?bkYyTi9Jc0V2NWM4VnI3UjVRa0lmQlFBN3Y5RzRpQkdjNG02cEEzdmpOeENs?=
 =?utf-8?B?L0VEWEplL2FnKzJKM2pMTFU5V0NYbVAxSnBwcFU2OVdVajFoZ2srQ2t6Mmxp?=
 =?utf-8?B?K0NEdU1iQy9GS3U4c3pHaFdqeXFDSkhXZzEwMmorZ01Dam1HWHppSzZyN0Jx?=
 =?utf-8?B?dFl2cmlWTG1lSm1oVVY0VzB3ME1SZjd2WVVGSmV4bTJrWDlURDh5cTNxME42?=
 =?utf-8?B?Q3RGZ3FUR1NhR2dXTU1uMXEyMDQxTlk2TGs5ckZmT0F6bjZQNjJOVUpFb3Mw?=
 =?utf-8?B?aVoxSlVXSkpsNzZoYzdzQzJMQjBMTEFadnJJaEZZbGZaTWFhU2R4STBRc0pB?=
 =?utf-8?B?clRkS3ZpbVp2MVkvYWNoVVdXaENFdUsxYjFlN1RETFpXbmRWVXN2aTJ3WXRv?=
 =?utf-8?B?WEVZWEtsQllwY2NYeEI3b2hpaCtybGI0Z2ljU2c2Y25rL2V5QnYvTDdNcjR5?=
 =?utf-8?B?QzNpelowRExJZW44R0RaQ05ObTVyb0kxUXozbC9VUDUvNGxreTU3UllCcFRU?=
 =?utf-8?B?dGxHUHNQTTRqYlRIdVExdllVc2pmdzhnOUJ4YzJKRXdvMWhzQXdTa01tUlFx?=
 =?utf-8?B?U1diRWJUMm9wOGtheDlCa3BhbjhSN3IvN0NYV0VNdE1VNHErYUNZeUh3NlF4?=
 =?utf-8?B?RWJxdzlyMEJwOXlScEhDcHZFb3Zpemx3cW9KQ0l2cytMcFVDUnhWUG1VNm1O?=
 =?utf-8?B?cUh0V1lsMWkzNUpNVzlDcUhVSm4xc0lDbzFYN1gzSitFMThXaTY0WEhVcEQ1?=
 =?utf-8?B?eTI4QzBHTUh1S2ord2F6TlorOThFeW9JYmlpWHl1M0NBQ25sTVZ4NENOeW1R?=
 =?utf-8?B?REF2RlBXWXZUVCtuQ1QxRW9xRUpkenEreGpmRk9uNEp5c3gxalJVYm9wM25M?=
 =?utf-8?B?WEk1WWxVVTM3VTl3NzFDQUJsdkRDSVhLeTl1RDZ2dkplZUszNGg4OWhFQ0Vx?=
 =?utf-8?Q?t5wjnKjhJSRApDEHbMFlmiuBGe/OB5+fwx9OKWN?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0AE3D0C8207FB4894FF06F1A56A826B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4748.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1dc848b-a1fb-4374-a984-08d8ffb5cd10
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2021 02:25:56.6653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yENq4waX9syrCRtKKZOgLhAzRjlbjaBFNrabx9yolzNEE7twX+dojy+yyfrpruVU5Ctg0RXz19fE06OA0PyVfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1919
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQrvu79PbiA0LzE0LzIxLCAzOjA5IEFNLCAiTWFyY2VsIEhvbHRtYW5uIiA8
bWFyY2VsQGhvbHRtYW5uLm9yZz4gd3JvdGU6DQoNCiAgICBIaSBUZWRkLA0KDQogICAgPiBUaGlz
IHBhdGNoIGZpeGVzIHRoZSB2ZW5kb3IgbmFtZSBpcyBhbHdhc3kgc2hvd24gYXMgIk1pY3Jvc29m
dCIgZXZlbg0KICAgID4gdGhvdWdoIGEgZGlmZmVyZW50IHZlbmRvci4NCiAgICA+IA0KICAgID4g
PCBIQ0kgQ29tbWFuZDogTWljcm9zb2Z0IFNlY3VyZSBTZW5kICgweDNmfDB4MDAwOSkgcGxlbiAy
NDkNCiAgICA+ICAgICAgICBUeXBlOiBEYXRhIGZyYWdtZW50ICgweDAxKQ0KICAgID4+IEhDSSBF
dmVudDogQ29tbWFuZCBDb21wbGV0ZSAoMHgwZSkgcGxlbiA0DQogICAgPiAgICAgIE1pY3Jvc29m
dCBTZWN1cmUgU2VuZCAoMHgzZnwweDAwMDkpIG5jbWQgMzENCiAgICA+ICAgICAgICBTdGF0dXM6
IFN1Y2Nlc3MgKDB4MDApDQogICAgPiAtLS0NCiAgICA+IG1vbml0b3IvcGFja2V0LmMgfCAxMiAr
KystLS0tLS0tLS0NCiAgICA+IDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDkgZGVs
ZXRpb25zKC0pDQogICAgPiANCiAgICA+IGRpZmYgLS1naXQgYS9tb25pdG9yL3BhY2tldC5jIGIv
bW9uaXRvci9wYWNrZXQuYw0KICAgID4gaW5kZXggZDcyOWEwMWNjLi45MWQyMjk0ZmYgMTAwNjQ0
DQogICAgPiAtLS0gYS9tb25pdG9yL3BhY2tldC5jDQogICAgPiArKysgYi9tb25pdG9yL3BhY2tl
dC5jDQogICAgPiBAQCAtOTMyNSwxOCArOTMyNSwxMiBAQCBzdGF0aWMgY29uc3QgY2hhciAqZ2V0
X3N1cHBvcnRlZF9jb21tYW5kKGludCBiaXQpDQogICAgPiANCiAgICA+IHN0YXRpYyBjb25zdCBj
aGFyICpjdXJyZW50X3ZlbmRvcl9zdHIodm9pZCkNCiAgICA+IHsNCiAgICA+IC0JdWludDE2X3Qg
bWFudWZhY3R1cmVyLCBtc2Z0X29wY29kZTsNCiAgICA+ICsJdWludDE2X3QgbWFudWZhY3R1cmVy
Ow0KICAgID4gDQogICAgPiAtCWlmIChpbmRleF9jdXJyZW50IDwgTUFYX0lOREVYKSB7DQogICAg
PiArCWlmIChpbmRleF9jdXJyZW50IDwgTUFYX0lOREVYKQ0KICAgID4gCQltYW51ZmFjdHVyZXIg
PSBpbmRleF9saXN0W2luZGV4X2N1cnJlbnRdLm1hbnVmYWN0dXJlcjsNCiAgICA+IC0JCW1zZnRf
b3Bjb2RlID0gaW5kZXhfbGlzdFtpbmRleF9jdXJyZW50XS5tc2Z0X29wY29kZTsNCiAgICA+IC0J
fSBlbHNlIHsNCiAgICA+ICsJZWxzZQ0KICAgID4gCQltYW51ZmFjdHVyZXIgPSBmYWxsYmFja19t
YW51ZmFjdHVyZXI7DQogICAgPiAtCQltc2Z0X29wY29kZSA9IEJUX0hDSV9DTURfTk9QOw0KICAg
ID4gLQl9DQogICAgPiAtDQogICAgPiAtCWlmIChtc2Z0X29wY29kZSAhPSBCVF9IQ0lfQ01EX05P
UCkNCiAgICA+IC0JCXJldHVybiAiTWljcm9zb2Z0IjsNCg0KICAgIHNlZW1zIHdlIGhhdmUgYSBi
dWcgaGVyZSwgYnV0IHRoZSBmaXggY2FuIG5vdCBiZSBjb3JyZWN0IGVpdGhlci4gSWYgd2UgYXJl
IHJ1bm5pbmcgb24gSW50ZWwgZmlybXdhcmUgYW5kIHRoZSBNaWNyb3NvZnQgZXh0ZW5zaW9uIGlz
IHVzZWQsIGl0IHNob3VsZCBzaG93IE1pY3Jvc29mdCBhbmQgbm90IEludGVsIGZvciB0aGUgdmVu
ZG9yIGNvbW1hbmRzLg0KDQpJIHN1Ym1pdHRlZCB2MiBhbmQgSSB0aGluayBJIHRvb2sgY2FyZSBv
ZiB0aGUgbXNmdF9vcGNvZGUgaGFuZGxpbmcgYnV0IEkgcmVhbGl6ZWQgdGhhdCB0aGUgbXNmdF9l
dmVudF9vcGNvZGUgaXMgYWxzbyBsaWtlIG1zZnRfb3Bjb2RlIC0gZWFjaCB2ZW5kb3Igd2lsbCBo
YXZlIGEgZGlmZmVyZW50IHZhbHVlLg0KSSBrbm93IHRoZSBtc2Z0X2V2ZW50X2NvZGUgZm9yIElu
dGVsLCB3aGljaCBpcyAweDUwLCBidXQgZG9uJ3Qga25vdyBmb3IgUmVhbHRlay4gKERvIHlvdSBo
YXBwZW4gdG8ga25vdz8pDQoNCkkgY2hhbmdlZCB0aGUgdjIgdG8gUkZDIGZvciB5b3VyIGZ1cnRo
ZXIgY29tbWVudHMuDQoNCiAgICBSZWdhcmRzDQoNCiAgICBNYXJjZWwNCg0KUmVnYXJkcywNClRl
ZGQNCg0K
