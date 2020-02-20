Return-Path: <SRS0=cA0y=4I=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE72C11D0C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 19:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDBD2467A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Feb 2020 19:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="S8Es6N/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbgBTTAs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Feb 2020 14:00:48 -0500
Received: from mga18.intel.com ([134.134.136.126]:14446 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727535AbgBTTAr (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Feb 2020 14:00:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 11:00:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="349222226"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2020 11:00:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Feb 2020 11:00:46 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Feb 2020 11:00:45 -0800
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Feb 2020 11:00:45 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Feb 2020 11:00:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxSZnJhrRIrF853SQM/SfreHKZoSuMznAIO//6gIQ1LUyyOyYcDiAmkO/9M7S8ZIJybj6/etazdDLMKpp3M/ek5ZQhsES1PuSBkJ4iEfQiPqSjeaQfBoVTOgwMdtTNMU4nS29rZOO/KAOX/rcGyBNUJDk2/qOgMRNLZgdUvO+7FBefypD1WBDthYpk0w3BoiBbtfHNEKYXwkHO0cgjz7K3uXIaaRKvbT7eDFanNQ+Stpqlo58o1muLHMXl+lW/tQFWqPnxJyGds3mZq0nchILCjE5asSI78PdGQAfD8umbhWjO9HzsqcWGNyfad2VSF14G11xJ/iA9QIJLPpMlZbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5c9b2hmI4V44TJWUhjz1MrtQxOahxdbsXnr1DaTx1U=;
 b=UgumF/w/8ZGxja1VlNKiSJOI8GDhxYljBhexaDqHZm9ukkmdLWrMXN0/xFl86gtY65LkMzKI/BZe4OfNUXNuXAmsyLbeJ798y/JqV6cX2WU5wDlyrQge7YZbMgaumTZnAra7PXHqaaYw5ZsuS8VH73MTGyJg8CQqqH+HAQmwnGouxN+Fr3s9bJY4vuINMAB0LGXqlU4FsZp+IHeCHmIAHNd+6yZxNHwTaGizsA80AszMTqylKTTrfLEXRapXhIl4UTDQ494IP9Qb6rg8vGgcECNK6BkcysrpjLdJWff1t9gbESkbU06v1KE6z5uT6v0JYqZ0RPGFvvFZLyybdyK/JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5c9b2hmI4V44TJWUhjz1MrtQxOahxdbsXnr1DaTx1U=;
 b=S8Es6N/9Q89hOEhJ6o8OlRW919jvzYAfjybisEXAm8VhjBLwX4vAPrEb4XwAHiao+EoBffkWJfcp9nq/H2uawKYzIsgAvVgMYMNAJ9iyiqpdFoj8iinAYGWPEbsRcVWcJ5rPVl8vkaCRjob0r6McZptgzBGe1nF+bCiRXlQc8oU=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (2603:10b6:406:b5::27)
 by BN7PR11MB2657.namprd11.prod.outlook.com (2603:10b6:406:b1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Thu, 20 Feb
 2020 19:00:41 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2729.033; Thu, 20 Feb 2020
 19:00:41 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "nazeer.m@phytec.in" <nazeer.m@phytec.in>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: mesh-cfgclient Node is not attached
Thread-Topic: mesh-cfgclient Node is not attached
Thread-Index: AQHV58IK9jCGMXfZFkufIs4o0bgNVagkcJCA
Date:   Thu, 20 Feb 2020 19:00:40 +0000
Message-ID: <e9577a1d890c83da99c8dcc2908fff680c9ecb7e.camel@intel.com>
References: <OF2849A126.CB6B1F2C-ONC1258514.0028F058-C1258514.0028F05A@phytec.de>
In-Reply-To: <OF2849A126.CB6B1F2C-ONC1258514.0028F058-C1258514.0028F05A@phytec.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 953cb6b2-97e5-48b3-e75d-08d7b6372e36
x-ms-traffictypediagnostic: BN7PR11MB2657:
x-microsoft-antispam-prvs: <BN7PR11MB2657E9C98112BB81DE581315E1130@BN7PR11MB2657.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(39860400002)(396003)(199004)(189003)(478600001)(5660300002)(71200400001)(6512007)(86362001)(91956017)(76116006)(66446008)(66556008)(64756008)(66946007)(66476007)(8676002)(6506007)(36756003)(81156014)(81166006)(2906002)(316002)(26005)(2616005)(8936002)(6486002)(110136005)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2657;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5O2D90jLhuEtQZa5ggH+w6UDk8OcsejE0nVSRf+NZikj8eiZuCPjfpMjHtu9wEISnw6h+EOSTLW/NjP11kFuOCrWsK/6004OmUOvPQXC7AMO74rthQvjdJAAQb3kEqudwtCItxp7hdDUYN292c4AOAmr6mc/DxOogTuS0Ja0p0CPTVcG8CtMKnB/+o8UsP7Nbcn1K42bvNj2mD+4HddHaeDmwp1pmZIbkMkmppoW6pPBCpzhmBiZjNAnn44SzR+LjmucJRICkLrvif3rD6cSc5YC8UkHScSxQpoCMJLcqRK8aQGDqFgGUYxcmyFQfHdRAqxIj49X1YLtNSOEPlcO2YT36LQBK9KVjc45IpEJ3yirUApGASv0/YIIBadopPX5B378PqOXbssTJOZpbgQqeUztJ+nEleutEhv1y/ddU4TbkMPoDt8HQJ3ExMuHxYwX
x-ms-exchange-antispam-messagedata: nn0MJqlxQ9XFdaqqbD36T+/jsNpmAgHz/GtpGEoHRKsxJa8S1vjJ3ONVeqxutfOZzwzQWhKrCKCYE+3MKNIApCO8bKL5prqyukuJdXgYmxEpuNOqpy5cAaDdL6lK8VRq57VRtKK5teRdayzA5kS2nQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2CBADBB34769F4884AF6E6D4D41B7D2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 953cb6b2-97e5-48b3-e75d-08d7b6372e36
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 19:00:40.9761
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Bm9hybeCTRtuGRGB06DsFInwvjAtHwPirDcH+p8wLfr1zfmqzFl5J3SNVa/ypvU27EJidlLXiKKxFc8ZyEuzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2657
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTXIgTmF6ZWVyLA0KDQpPbiBUaHUsIDIwMjAtMDItMjAgYXQgMDg6MjcgKzAxMDAsIE1haGFi
b29iIE5hemVlciBTSyB3cm90ZToNCj4gSGksDQo+IA0KPiBJIHdhcyB0cnlpbmcgdG8gcHJvdmlz
aW9uIGEgbm9kZSB1c2luZyBhIG1lc2gtY2ZnY2xpZW50Lg0KPiANCj4gSSBoYXZlIHN1Y2Nlc3Nm
dWxseSByYW4gY3JlYXRlIGFuZCBpIHdhcyBhYmxlIHRvIGdldCBjb25maWd1cmF0aW9uIA0KPiBm
aWxlcyBpbiB0aGUgLmNvbmZpZy4NCj4gDQo+IFttZXNoLWNmZ2NsaWVudF0jIGNyZWF0ZSANCj4g
TWVzaCBuZXR3b3JrIGNvbmZpZ3VyYXRpb24gZXhpc3RzICgvaG9tZS9uYXplZXIvLmNvbmZpZy9t
ZXNoY2ZnL2NvbmZpZ19kYi5qc29uKQ0KPiANCj4gQWZ0ZXIgdGhhdCBpIGhhdmUgdHJpZWQgdG8g
ZGlzY292ZXIgdGhlIHVucHJvdmlzaW9uZWQgbm9kZSBidXQgaSBnZXQgDQo+IE5vZGUgaXMgbm90
IGF0dGFjaGVkIG1lc3NhZ2UuDQo+IA0KPiBbbWVzaC1jZmdjbGllbnRdIyBkaXNjb3Zlci11bnBy
b3Zpc2lvbmVkIG9uDQo+IE5vZGUgaXMgbm90IGF0dGFjaGVkDQo+IFttZXNoLWNmZ2NsaWVudF0j
DQoNClRoZSBwcm9ibGVtIHlvdSBkZXNjcmliZSBpcyBwcm9iYWJseSBkdWUgdG8gdGhlIGRhZW1v
biBub3QgZmluZGluZyBhbiBhcHByb3ByaWF0ZSBCVCBjb250cm9sbGVyIHRvIGF0dGFjaCB0by4g
DQpUaGlzIGxlZCB0byB0aGUgIkF0dGFjaCIgZmFpbGluZyBhZnRlciB0aGUgIkNyZWF0ZSIsIGFu
ZCB0aGVuIG5vbmUgb2YgdGhlIGNvbW1hbmRzIHRvIHRoZSBub2RlIGFyZSBhYmxlIHRvIGJlDQpz
ZW50Lg0KDQoNClRoZXJlIGFyZSBhIGNvdXBsZSBvZiBvcHRpb25zIGhlcmU6DQoNCjEuIElmIHlv
dSBoYXZlIGEgc2luZ2xlIEJUIENvbnRyb2xsZXIgKHY0IG9yIG5ld2VyKSB5b3Ugd2lsbCBuZWVk
IHRvIGRpc2FibGUgdGhlIG1haW4gYmx1ZXRvb3RoIGRhZW1vbiBzbyB0aGF0DQp0aGUgYmx1ZXRv
b3RoLW1lc2hkIGRhZW1vbiBoYXMgYWNjZXNzIHRvIGl0Og0KJCBzdWRvIHN5c3RlbWN0bCBkaXNh
YmxlIGJsdWV0b290aA0KJCBzdWRvIHN5c3RlbWN0bCBzdG9wIGJsdWV0b290aA0KDQoyLiBJZiB5
b3UgaGF2ZSAqbXVsdGlwbGUqIEJUIGNvbnRyb2xsZXJzLCBtYWtlIHN1cmUgdGhlIGJsdWV0b290
aCBkYWVtb24gaGFzbid0IGF1dG9tYXRpY2FsbHkgY2xhaW1lZCB0aGVtIGFsbDoNCkluIC9ldGMv
Ymx1ZXRvb3RoL21haW4uY29uZiwgbWFrZSBzdXJlIEF1dG9FbmFibGU9ZmFsc2UgKHJlYm9vdCBt
YXkgdGhlbiBiZSByZXF1aXJlZCkNCg0KDQpJbiB0aGUgZnV0dXJlLCB3ZSB3aWxsIGJlIGRvaW5n
IHdvcmsgdG8gZW5hYmxlIGNvLWV4aXN0YW5jZSBhbmQgY29udHJvbGxlciBzaGFyaW5nIGZvciBz
aW5nbGUgY29udHJvbGxlcg0Kc3lzdGVtcy4gSG93ZXZlciwgdGhpcyB3aWxsIHJlcXVpcmUgc29t
ZSBjaGFuZ2VzIGluIHRoZSBrZXJuZWwuDQoNCg0KPiANCj4gQ291bGQgeW91IHBsZWFzZSBsZXQg
bWUga25vdyBpZiB3ZWF0aGVyIHRoZXJlIGFyZSBzb21lIA0KPiBtb3JlIHN0ZXBzIGludm9sdmVk
IHRvIGRpc2NvdmVyIGFuZCBwcm92aXNpb24gYSBub2RlIG9yIGlmIGFtIG1pc3Npbmcgc29tZXRo
aW5ncy4NCj4gDQo+IFRoYW5rIHlvdS4NCg0KUmVnYXJkcywNCg0KLS1CcmlhbiBHaXgNCg0K
