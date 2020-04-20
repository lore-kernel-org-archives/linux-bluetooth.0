Return-Path: <SRS0=YdAw=6E=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D6AC3A5A0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A66206F6
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 Apr 2020 16:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="g03+K1p5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgDTQhS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Apr 2020 12:37:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:14846 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbgDTQhS (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Apr 2020 12:37:18 -0400
IronPort-SDR: TYWrykhKTse3MkDs7x7WhCp69oUMR/gcyLbxl6DeOZs6hZ5ymzfO8QfKUuWz3nLA0hpn4BxURE
 ZRG/sz8DrU/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2020 09:37:16 -0700
IronPort-SDR: Q2O+3HEBp0a0qUWp01ClSJ+uu2vDU9nvSwwL81RPWgZfgzxyXXb+793UJ1LZw+xczNNSgV30sF
 1mlKgqFdeukQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,407,1580803200"; 
   d="scan'208";a="290321925"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by orsmga008.jf.intel.com with ESMTP; 20 Apr 2020 09:37:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 09:37:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Apr 2020 09:37:15 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Apr 2020 09:37:15 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Apr 2020 09:37:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWUX1hPcGE+ao3b3NGOg0qJcvbP2pP4/XO1yYnpaV30gXqzayzFqAWcLJLtT7uQgYkwnuU3MI6V34gmh2xWHJpLHFeojXdMQ8vcZzDuCOfiWkEJeXzayO+gGdK7K4QsMtiYAyvpZFX12hkyHiFLX65n/Wk/KycIZ1B3TgReD9grlUQEvhEQ+9HGqzCQypBMQdycUMkBPxvZ/cNEkONBm2QO9xDkvKPkcTJ5GJsxiGbjMJ+hAT+hhusGJgx6hqBWAzFcZRxCz46r0KoNPfj2YNXYqWM+ouvD7SctAD/+rWc0hG9/Su1eJrfre+UGWtvxxy0/9xCBdvtWEv/ViEEhT3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR3uu9qXKFBxhbps2nuztR12728ChoPiQe39Hp9CIf0=;
 b=af1YSusX+F/sCfHFmc6pxs80ACPvI1yIAYWgoQMymh3wt9bKyAAu1W3tU27wkyR4ndRb2//Slstcy55cVeK/M4uUHqkst4fRIumCitCM3pmr4u4DIQaJAiAMCDK02hqw0he4OMAamBP0+Ip4iihdUoM7HRM+S5I4a82WDKZy5R9yXtbGTwEVClMpmbsWQrld/qiKi/uXLb5U0o3wLlclqOaS7KIqhYduFwfxMYwbUFAg02HkGMkVVG7n2zGb/ANw7A6P6KIwFdGgFthsev96Sp0kcdEzHi/yKZkVHEpesAGD2c8oHr+FTJu0qMxYbZDqqIoS+Md7WAoVtiZYQ9h3AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nR3uu9qXKFBxhbps2nuztR12728ChoPiQe39Hp9CIf0=;
 b=g03+K1p5jh13Vy0qw4vKcEtfTLVDYJ3dSdbZfoWI05Y7079JB/U41WxiPDPugxiAVUNMjif0iMgT+4hIs134/vhROu159UwkNI3yxqngDUuC3XpcKegvzqNCSZ6rmtSp0IJVIbsT8HsDWQMY0jSSfkqwUgi5fcYioKJ/ikGR+Ec=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4571.namprd11.prod.outlook.com (2603:10b6:303:59::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 16:37:13 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5552:f057:3dbf:716c%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 16:37:13 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "szymon.janc@codecoup.pl" <szymon.janc@codecoup.pl>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 3/4] avctp: Fix compilation with GCC 10
Thread-Topic: [PATCH 3/4] avctp: Fix compilation with GCC 10
Thread-Index: AQHWFwxb+POQgQfgwUmeMKN9K7H5SKiCNcqA
Date:   Mon, 20 Apr 2020 16:37:13 +0000
Message-ID: <a1e5a35a5073bda33d7f36c08bd776397f8c36da.camel@intel.com>
References: <20200420120705.89691-1-szymon.janc@codecoup.pl>
         <20200420120705.89691-3-szymon.janc@codecoup.pl>
In-Reply-To: <20200420120705.89691-3-szymon.janc@codecoup.pl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56bc00d9-d011-48a5-0ed2-08d7e54914aa
x-ms-traffictypediagnostic: MW3PR11MB4571:
x-microsoft-antispam-prvs: <MW3PR11MB4571DBEE79A86B53869E0F20E1D40@MW3PR11MB4571.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(136003)(376002)(346002)(396003)(39860400002)(366004)(2906002)(8676002)(110136005)(81156014)(8936002)(316002)(186003)(6506007)(26005)(71200400001)(6512007)(6486002)(76116006)(2616005)(66946007)(36756003)(66446008)(478600001)(5660300002)(86362001)(91956017)(66556008)(64756008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZDjyGj+Y4k7lFzsTZD0ZlDzwJnYerr5+yVLLol9sRXo8KS/JUkC3M1wm0g9+m+EXD6ZSRMAB6KIrox/+8rYgXvjAMdDitYmXHN3NBA5AQ0WrUH3A+2Lv1YaXgk2RtHXS8g6LrEa4JQ87Sh9d2z3rLxeOEnCemNlm0hoLRkz57uHm7XGtmSl4AkfRUZTvPvLZDKuSnS1y9D2NRIdZSOzQFFv7bHAnkoRv50csBNsw9M8avGNU3EsuVEUVcSSw042fm02nmd68nMYTjQNM9w/4QM4NcL9HTFcQ+0z/Y4geArXtNIlwxjveK9pIZvU/t7HsuGTCsB8uFZIMWR/Y6krTfW1cMnGmR8fCaM9dbh7fQxBd3qWNdJXYY3sgPuT6PW3eByI7ftx5ApmxfxVSJHDxYTYheRaJxPjPbjDYHqWm4UbBGGWxnykTTCxhRSW+x9m7
x-ms-exchange-antispam-messagedata: xirQff/ln2P4z22q0oI1Sjryx9JEOhkJTpaMEqD4iRBEYcbqLSN8EbdIhE1Hfp+d6pXNkLAuZs0J96+qWa0fTn7AQlMIOXnrWgnUjw5RVAiCUUxhVTWw7QExaLknETwpVfeYLWVCJm++mjONEMtR46swjOji6he0Kz5mg/AAl5QfwskBLAowROknnCPPW4iuQMTu8H93b60c1fdNEC5Xoh6m3Fu0OuXVcsn9hn/tUefMcYnfcDzRkkaQcwPVrpWn/S/R6zPDhnZTcb+tbLp1MkSFIu47NUnMMtAatS67FWx3ZEsCLmCvHQAnntSSRr31bdecmMXG23A0AU2TxRIOMhTV3MtJiBkLQ9S/pG4f/3/q9gA4RY4WSbbDZQX0LCeK2ICM2G6TnNKNUV86cDqhzjA8yYejwYlHW8jaSOzQcomvxaGSrMx2a+rYc0MRGzQGYiXv5AGxqfIDyJgLyD7L+4a6byMRq0AEkcWPOgkkHpEmttWuLpPGw68c0B6n5xemIzYeu3YrU85ALFsPOHYPJaBV/D7+dRMQQTTKtct/lEWnbju9QDyQ8MF0ITqkGDjB/78dCZdUL0qMIZVmozjUfpO8RghQaUNrzbeFJuaqRiBen5LYcY7sf/4AVEMEONXjUF/Zx6LiL6x0s94D39EEzifN9hM2yyzlK6LeUXLmoxnDFTjxw3TeIc5ZH6cY5mSkM6553E8l0D/A/7C72+4ZdTVyj7U82k4eoaHS8yDkPA/TWeCA90o3XhkJMr2jh32X4n1K4lYAzVF/KJPswls3opSivVgmXKS5ls3PbddgKeM=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE628B3DC4EA9B48A064F9CCD8E11A12@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 56bc00d9-d011-48a5-0ed2-08d7e54914aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 16:37:13.7181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dGTXXPBhI/5qJly0Aso7D8SWbByQDHOGCanvaaLV9mj7setzCd8HN5tGl3py33OCjssSauJeO1KqRY+bYwnjow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4571
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTIwIGF0IDE0OjA3ICswMjAwLCBTenltb24gSmFuYyB3cm90ZToNCj4g
VGhpcyBvbmUgaXMgYSBmYWxzZSBwb3NpdGl2ZSBidXQgc2luY2Ugd2UgbmV2ZXIgdXNlIG1vcmUg
dGhhbg0KPiBVSU5QVVRfTUFYX05BTUVfU0laRSBieXRlcyBvZiBuYW1lIHdlIGNhbiBzaWxlbmNl
IEdDQyBieSByZWR1Y2luZw0KPiBzaXplIG9mIHNvdXJjZSBzdHJpbmcuDQo+IA0KPiAgIENDICAg
ICAgIHByb2ZpbGVzL2F1ZGlvL2JsdWV0b290aGQtYXZjdHAubw0KPiBJbiBmdW5jdGlvbiDigJh1
aW5wdXRfY3JlYXRl4oCZLA0KPiAgICAgaW5saW5lZCBmcm9tIOKAmGluaXRfdWlucHV04oCZIGF0
IHByb2ZpbGVzL2F1ZGlvL2F2Y3RwLmM6MTI1OToyMDoNCj4gcHJvZmlsZXMvYXVkaW8vYXZjdHAu
YzoxMTg4OjM6IGVycm9yOiDigJhzdHJuY3B54oCZIG91dHB1dCBtYXkgYmUgdHJ1bmNhdGVkIGNv
cHlpbmcgNzkgYnl0ZXMgZnJvbSBhIHN0cmluZyBvZg0KPiBsZW5ndGggMjQ4IFstV2Vycm9yPXN0
cmluZ29wLXRydW5jYXRpb25dDQo+ICAxMTg4IHwgICBzdHJuY3B5KGRldi5uYW1lLCBuYW1lLCBV
SU5QVVRfTUFYX05BTUVfU0laRSk7DQo+ICAgICAgIHwgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCj4gY2MxOiBhbGwgd2FybmluZ3MgYmVpbmcgdHJlYXRl
ZCBhcyBlcnJvcnMNCj4gLS0tDQo+ICBwcm9maWxlcy9hdWRpby9hdmN0cC5jIHwgMiArLQ0KPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvcHJvZmlsZXMvYXVkaW8vYXZjdHAuYyBiL3Byb2ZpbGVzL2F1ZGlvL2F2Y3RwLmMN
Cj4gaW5kZXggMzdmZmRlOWU3Li4wNThiNDRhOGIgMTAwNjQ0DQo+IC0tLSBhL3Byb2ZpbGVzL2F1
ZGlvL2F2Y3RwLmMNCj4gKysrIGIvcHJvZmlsZXMvYXVkaW8vYXZjdHAuYw0KPiBAQCAtMTI0Niw3
ICsxMjQ2LDcgQEAgc3RhdGljIGludCB1aW5wdXRfY3JlYXRlKHN0cnVjdCBidGRfZGV2aWNlICpk
ZXZpY2UsIGNvbnN0IGNoYXIgKm5hbWUsDQo+ICANCj4gIHN0YXRpYyB2b2lkIGluaXRfdWlucHV0
KHN0cnVjdCBhdmN0cCAqc2Vzc2lvbikNCj4gIHsNCj4gLQljaGFyIG5hbWVbMjQ4ICsgMV07DQo+
ICsJY2hhciBuYW1lW1VJTlBVVF9NQVhfTkFNRV9TSVpFXTsNCg0KU2hvdWxkIHRoaXMgYmUgbnVs
IHRlcm1pbmF0ZWQ/ICAoVUlOUFVUX01BWF9OQU1FX1NJWkUgKyAxKSAgPw0KDQo+ICANCj4gIAlk
ZXZpY2VfZ2V0X25hbWUoc2Vzc2lvbi0+ZGV2aWNlLCBuYW1lLCBzaXplb2YobmFtZSkpOw0KPiAg
CWlmIChnX3N0cl9lcXVhbChuYW1lLCAiTm9raWEgQ0stMjBXIikpIHsNCg==
