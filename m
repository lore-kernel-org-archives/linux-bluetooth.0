Return-Path: <SRS0=1iyh=56=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6674C2BB85
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 15:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78EA22075E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Apr 2020 15:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="X02SWE/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440887AbgDNPrV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:47:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:64253 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440881AbgDNPrJ (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Apr 2020 11:47:09 -0400
IronPort-SDR: EYR/oWrRLw7+ku5aGEZTuLHlpvEwB+SMDw2FRavJUP2uXd3UOGcBofk0Ps3HOEZ/UyUQmCXKs2
 Xntz5eflSLbA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 08:47:08 -0700
IronPort-SDR: LQSJd07oiVpJdGMI0pK/hq6ewN9lC83nW37+scRg/h33HWwzLL2SrawR8YCJaQ9aeM7NZKTAhK
 JUvjKj0QD5HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,382,1580803200"; 
   d="scan'208";a="277298258"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 08:47:06 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 08:47:06 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Apr 2020 08:47:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPTE+5hky6pzLLq9/Eamvi5TNiGiB73mqNf1j1FH1A10U/TtewmEHZrgqXHhS1KGMhJ1yARlkfCp6aqlLK58fIBc2LzWlM2IlSvXQe346rir74KvytzcNloLqycZ7lkZqNWohAy/JgTmQHVy2eJ/xJY3qiMMeWJ8M+7Ee5/jGIVCHgkudy9/tQRPFa4En827AsT8RGTmA3m1TfaXvlwXqYBpS35WgBhUt4RThviXUBf99vPVKs+Mi6y+n199pkg1ZBKqxnSJVB/k32zFMwUzIir/D8xG+UGTMDVqoWdWBnFwywT2F+IQEFd+gBVNWs05xPIEEoZK6e/JmGMxGEO3Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIS+/OoVZopjhaeYt9jpeaq+/vLaeOLf40PkIHnGLs4=;
 b=CR1LtpGRjReBQLcOPvv8aD2afY8ns48a6mnvL96vW0ASjK1LJ1MBWe8sJ6+F1o/2mT26rRVUW1FY1Hv+D07yy7w9UoFLWWqQ4eSw+Ary5aiwX0etCnAXnU0fZf3j5f5zA4+WyHS+GRNZ04dAkmbUHz4PE2IB7awUNt8Mo/pcq4QVcgqJxKWZFLxq1U/SMwkKVKWrKUCxpaWSFao7i8rUOjQ8AobiTdt2B6ik0+qOSNbLj0XLXgTEjuWtRiYU4uHDpmePB6piADUdrjNRs5BU6v8BkkZgTU9Ipu1yY3AaPk2TQt1L6JLTjYMxH6h7MLAYTTJDmup7xR1Kq1zvS6AfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OIS+/OoVZopjhaeYt9jpeaq+/vLaeOLf40PkIHnGLs4=;
 b=X02SWE/zeaOW8F22bkTsDrX2bpqN+eI7llCQNG3znUTVRANcC8/L5y0oeeixPBoDZuSJ6g/WLVpUyi1nrjYSrt/TQ+EysMyre1bSyJw9+NTpxoZ0TPMvGFoOmwra7d6BtoUfuXvBTLFcvyIqcwC5WqSS98itq0wQCMitvUFfd6E=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4665.namprd11.prod.outlook.com (2603:10b6:303:5d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 15:47:04 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::39a4:4e3:2bb2:dd3a%3]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 15:47:04 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ v5 0/4] mesh: Always deliver tokens via JoinComplete
Thread-Topic: [PATCH BlueZ v5 0/4] mesh: Always deliver tokens via
 JoinComplete
Thread-Index: AQHWEjqWr+fQOkn+zU6gbIJnnmE0iah4w22A
Date:   Tue, 14 Apr 2020 15:47:04 +0000
Message-ID: <9b9066f410ddb9faa36d62eadc22df7cc1af362b.camel@intel.com>
References: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200414085557.23464-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.32.5 (3.32.5-1.fc30) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9bd0b4cc-5c15-4273-c9d5-08d7e08b149b
x-ms-traffictypediagnostic: MW3PR11MB4665:
x-microsoft-antispam-prvs: <MW3PR11MB4665D978CC0B89C49C60FCFCE1DA0@MW3PR11MB4665.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(376002)(366004)(396003)(346002)(39860400002)(136003)(66476007)(66556008)(66446008)(966005)(316002)(5660300002)(76116006)(91956017)(64756008)(66946007)(6512007)(186003)(71200400001)(2616005)(66574012)(2906002)(8936002)(478600001)(6506007)(26005)(110136005)(81156014)(8676002)(6486002)(86362001)(36756003)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YTSnuYM5xU5bGr5Y5lv2aZ3BIjKJdAWREW5CYXOwg8LVnaW5+M1c9i4iNKGw5kcXD5GFReE/EyNa+7SPyiObwbS/AJf9ZDVMbKo3NmZqb8bh8XLKpMqmgaP8VznuZ8IQFwpuMTmRzDDyJGxyCaZy0tL39igXbDALSeOZe28reliPeJSYI164qKs7NHHK/vXmrNmUw6I6B9RJHRYDkPrioGni6ZQYCIsKRj5m/8gQXVpP5Xa0/4bkXpd3iyyu1rWUGLFjUQLBge3aQJSr2//bl0yUnpConaGaalR6caPwA5s4yL+YJthcprW1XMu7W2OUA8p2pMOBBEC75sbDr/PXsMR8bxz/9BHel1sqZnlGB7/BDOrzJ0WqlW69B/HrGT6e6CyLhE1DgcJrgZZ0RC5mLDMpcwL27YBK5gCVVqAwdqD0mj4jYGvahwDjF6L5EOKPfLsXHddfzHEceNp844j1ZVhDdeo7L5JQ9PjUt33x3CTF0CY88EkdGjHzBKC3nlavgIN9TgMrM0NZfMkF1AjZHiyHtI638qnXAFquxdt82SOIJJbsPVERD0YdCcekT9bD
x-ms-exchange-antispam-messagedata: noeQCbr32+EnEw3zhTc1YdwwCWQLQj3d2Cy4BavY/nTavsRXpcKxEecv/9ObvEHXw2wCr7M0/6RUaA7VzVr5r3djNZeXwpCIz++pnrKgLdjHmrRu+mQKSpPhgGmMVfCvGc4WalSu3auCEAQRkgFqbw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CDD81C3A86ED647B7F8258D5D682740@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd0b4cc-5c15-4273-c9d5-08d7e08b149b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 15:47:04.4595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PfejOLerTbyXJ8F7YX5HiOUl/T/xsdAjCDFDNXcwtseV1mFrRU4L03djgZjQP8VXWxy2vLFjMHYpNjLSKce6Tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4665
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

UGF0Y2hzZXQgYXBwbGllZA0KT24gVHVlLCAyMDIwLTA0LTE0IGF0IDEwOjU1ICswMjAwLCBNaWNo
YcWCIExvd2FzLVJ6ZWNob25layB3cm90ZToNCj4gVGhpcyBwYXRjaHNldCBpbXBsZW1lbnRzIEFQ
SSBjaGFuZ2UgZGlzY3Vzc2VkIGluDQo+IGh0dHBzOi8vbWFyYy5pbmZvLz9sPWxpbnV4LWJsdWV0
b290aCZtPTE1NzY2MDgyMTQwMDM1MiZ3PTINCj4gDQo+IHY1Og0KPiAgLSBVcGRhdGVkIHdvcmRp
bmcgaW4gZG9jL21lc2gtYXBpLnR4dA0KPiAgLSBSZWFycmFuZ2VkIHBhdGNoZXMgdG8gaW5jbHVk
ZSBlcnJvciBjaGVja2luZyBmaXggYW5kIGxvZ3MgaW4NCj4gICAgcGF0Y2ggIzINCj4gDQo+IHY0
Og0KPiAgLSBSZXN0b3JlIG9yaWdpbmFsIEMgcGFyYW1ldGVycyBvbiB0aGUgcmVzcG9uc2UgZm9y
IGRidXMNCj4gICAgc2VuZF93aXRoX3JlcGx5LiAgQW55IHBhcmFtZXRlcnMgY2FuIG5vdyBiZSAi
cmV0dXJuZWQiIGJ5IHRoZSBBcHAsDQo+ICAgIGFuZCBhIE5VTEwgbWVzc2FnZSBpbmRpY2F0ZXMg
YW4gaW50ZXJuYWxseSBnZW5lcmF0ZWQgdGltZS1vdXQNCj4gDQo+IHYzOg0KPiAgLSBBZGQgZGlz
dHJpYnV0aW9uIGluZGVwZW5kYW50IHRpbWVvdXQgZm9yIEpvaW5Db21wbGV0ZSgpIG1ldGhvZCBj
YWxscw0KPiAgICBzdWNoIHRoYXQgYSAzMCBzZWNvbmQgdGltZW91dCBvZiB0aGUgY2FsbCBpcyB0
cmVhdGVkIGFzIGZhaWx1cmUsIHNvDQo+ICAgIHN0YWxlIG5vZGVzIGNsZWFuIHVwIGNvcnJlY3Rs
eQ0KPiANCj4gdjI6DQo+ICAtIEZpeCBtZXNoLWNmZ2NsaWVudCB0byBzZW5kIEpvaW5Db21wbGV0
ZSByZXBseSBiZWZvcmUgY2FsbGluZyBBdHRhY2gNCj4gDQo+IEJyaWFuIEdpeCAoMSk6DQo+ICAg
bWVzaDogQWRkIFRpbWUtb3V0cyB0byBjcml0aWNhbCBkYnVzIHNlbmQtd2l0aC1yZXBsaWVzDQo+
IA0KPiBNaWNoYcWCIExvd2FzLVJ6ZWNob25layAoMSk6DQo+ICAgZG9jL21lc2g6IENoYW5nZSBB
UEkgdG8gZGVsaXZlciB0b2tlbnMgdmlhIEpvaW5Db21wbGV0ZQ0KPiANCj4gUHJ6ZW15c8WCYXcg
RmllcmVrICgyKToNCj4gICBtZXNoOiBDaGFuZ2UgQVBJIHRvIGRlbGl2ZXIgdG9rZW5zIHZpYSBK
b2luQ29tcGxldGUNCj4gICB0b29scy9tZXNoLWNmZ2NsaWVudDogQWRkIHdhaXRpbmcgZm9yICdK
b2luQ29tcGxldGUnDQo+IA0KPiAgZG9jL21lc2gtYXBpLnR4dCAgICAgICB8IDMwICsrKysrKysr
Ky0tLS0tLS0NCj4gIG1lc2gvZGJ1cy5jICAgICAgICAgICAgfCA0MCArKysrKysrKysrKysrKysr
KysrKysrDQo+ICBtZXNoL2RidXMuaCAgICAgICAgICAgIHwgIDYgKysrKw0KPiAgbWVzaC9tZXNo
LmMgICAgICAgICAgICB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0K
PiAgdG9vbHMvbWVzaC1jZmdjbGllbnQuYyB8IDc4ICsrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tLS0tLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCAxNjIgaW5zZXJ0aW9ucygrKSwg
NjAgZGVsZXRpb25zKC0pDQo+IA0K
