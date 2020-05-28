Return-Path: <SRS0=YOMr=7K=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF9FC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 18:27:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B402207D3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 May 2020 18:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="SMppuYku"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405824AbgE1S1E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 May 2020 14:27:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:14961 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405744AbgE1S1C (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 May 2020 14:27:02 -0400
IronPort-SDR: Tw5Z+bOcqkHjMjmYTNfbQtDYzJkH3ND6+9++dqV84kphIo8XzPK1pFg1J6FbsXybEkjoNkUfjr
 MgQD7vYyAujQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 11:27:01 -0700
IronPort-SDR: MAsjYdZYF+hgGAXUL0PiCy4jSEYp4MCTqehcx4DgRW3309LBF7VtJhjLdMp9eIjF1QRIb3goLV
 65Gjrdv/5bsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,445,1583222400"; 
   d="scan'208";a="270946206"
Received: from orsmsx108.amr.corp.intel.com ([10.22.240.6])
  by orsmga006.jf.intel.com with ESMTP; 28 May 2020 11:27:00 -0700
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX108.amr.corp.intel.com (10.22.240.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 11:27:00 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX113.amr.corp.intel.com (10.22.240.9) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 11:27:00 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 28 May 2020 11:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Js+NqNAsNUhO1smnt9buC3gHxiZi3I1lyeRVCTayOBZ+qDG6ccjqm2klV4YRVCFrZ+ywuszlY1eZMEA3UMWPv9bXQrK+aXLx+8dUAkRK27Z1kf7C0F/GLM51XhyJraud1hWiNx8MHJnTNV9b+LyjQDqajRii//72X2g1DcEPp2NDrwdMID1fQNqiLdmXsvQiTidLVa+LeYG+DI1+t6wLnRkK9KykYcdL2OLMMNHUEVEOaeduXr45o7ddsaQAvBKJ7TFvAhThrzsivNMYEcTmHfJeGxYobFAPFjSbt81Lxdym7BQtMJzM6F9fEL/Wo+EI9ZGtzNoe84JbpxiBFbhoig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTp/KK6uCJO5rVUKHdwBfihwqwGtMLKNQ6ZQZ0VXkWA=;
 b=F1FexYOFOcDsv5Ghkakl7prISvdx6N8fDetLqxUPAfgl/G7XcktHAMz7vlrlDT8ObUne7U1LL7QcoZeNz9AHX7q3j5qlKoSVJG5I7ZSOYsSntf4AR68V9de8rMRrTN6PKZGr8/JlrmvaN8m7ew1tCWPAXDVc3M7V2Vt2XaKo8MeNJozb0/s1PWBvx9jNyF2x276GjdH/flaTZZkjXNpa3Lg+QX2c3uK2awbPUQlPlftbSgqPUo0h4nsPLEdf9RfQaEd+N6EiTRy2byQYfUMbDo7lyFp5twHBZLId908fGeoDYv26X/7UiziYYLxFPry8sNp4coL0wNOZug0QFkmaUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTp/KK6uCJO5rVUKHdwBfihwqwGtMLKNQ6ZQZ0VXkWA=;
 b=SMppuYkucqmonUz+ZM1XAokIbvdRO/WpZSlsi0cWwa2G2+N1ulLz/UWDZwEtxMlYt8bFlktlYUBP/Sg19xGmS/l5ZFWculClZFvg25T6qD61Lrge26F0jbnXLKaB7nmpbaLSIWnMjySppaaDKQPlB6C5jppLUxqOQ9cFfJ7rX48=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4523.namprd11.prod.outlook.com (2603:10b6:303:5b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.19; Thu, 28 May
 2020 18:26:23 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::5b4:500e:f6a0:1ac0%5]) with mapi id 15.20.3045.018; Thu, 28 May 2020
 18:26:23 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "jiaquan.he@9amtech.com" <jiaquan.he@9amtech.com>
Subject: Re: Is it possible to parallelize mesh node provisioning?
Thread-Topic: Is it possible to parallelize mesh node provisioning?
Thread-Index: AQHWNN/CwFQijdf6+U+aX41sXt15gqi9y8UAgAAFdjI=
Date:   Thu, 28 May 2020 18:26:23 +0000
Message-ID: <1063C995-611E-4D7A-A5D1-73C0DDEABCD9@intel.com>
References: <577A37D1-506F-44B7-A685-6E34FE26560E@9amtech.com>,<1406bc3a74bb10bf69dd89a19bc8b353a429fecc.camel@intel.com>
In-Reply-To: <1406bc3a74bb10bf69dd89a19bc8b353a429fecc.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [75.172.106.34]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 952c6bbc-1094-471a-c466-08d80334a03c
x-ms-traffictypediagnostic: MW3PR11MB4523:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB452356922D790D733FA32319E18E0@MW3PR11MB4523.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0417A3FFD2
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ddTrkVFpRprnXclMqhh0bhTnVCID0Ffl0cSMZBoRkcQLjcpALUrAoufFGHnfBdrpvXTjrIwCMjFJCZUoErsd4i+MSyU+qoS3s5237AuJgIh08euJf/kPc8mO12lErUmK7t8LMY1A1SO1EFrQDodUgk/SFbh3YPKbGtwwZy2ob10yVa1NipMdgAU2C3s40FqVi/CV7bhT3YedTnpVi3+VdTMftg/KPwuphs740VoWHs8RIXeWbYJGOXwvrhtFCwTY9rwZvN3fesAvDB/YqhZX1lRegj2w/+DA3Zzq1hHNXJhbeg77P56c1sl4S3FlnYN5f3sHHqxCk/Ujh4JE02EisQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(396003)(346002)(39860400002)(376002)(6862004)(316002)(6512007)(83380400001)(86362001)(71200400001)(37006003)(54906003)(6506007)(2616005)(53546011)(8936002)(36756003)(2906002)(76116006)(66556008)(5660300002)(66446008)(64756008)(26005)(66476007)(33656002)(186003)(66946007)(8676002)(4326008)(478600001)(19627235002)(6486002)(6636002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uCnFzln+NoiuL1iZ5b5+jJDD1cBYlAY26q6jgIcyeqNsKW78THHxwNb/1M+e/z4xXw1GgzUZcEM2HwHZBErsulDLvWVQV7Cx81+7E3xZ1vY8Wiw9cOLYnoF2OUVEZp+Yoh91qhtScz3Xb/iD7TMr3pq+2OzNfoPX4+gfUWcCgSQFu9wgGF/9rzkkmgf8oOg55F+7B9eexeAY6jlztFu8LZDwMr3iz9lgTAGfEHLrqIJhwPZLD72yRU7hoejQEEikdnTpQF6in5b1yUF9tbrts4/u54r3If+9dkAUwUeiO3bKM8S5bTnzAKLl3h8nJordwgN+XpAKXqcRjGw4n+StWmufeOJSD5CpeoKOSC43hiz5FtmtWYn5zEgsyGxTvGa8UX/PmJ/9lYL7ONV0Zzs/gf+Tm2Bt3nGDG1NFVQBq8QHQ3h59zI5pu3Fs6pMF9/K5odNG8vm/0tExrkYfDRkZa1rmoqwVvh4UyN0OfSE1uBY=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 952c6bbc-1094-471a-c466-08d80334a03c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2020 18:26:23.3150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XNNf0C02nWZ+RjCl4Kqdg40Y+rWqT6gvjBmM3HCrMJl12XXwT+qd/gLOHlmXeC07DFGf5Y9pjyL69U+JmKW5KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4523
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgSmlhcXVhbiwNCg0KPiBPbiBNYXkgMjgsIDIwMjAsIGF0IDExOjA2IEFNLCBTdG90bGFuZCwg
SW5nYSA8aW5nYS5zdG90bGFuZEBpbnRlbC5jb20+IHdyb3RlOg0KPiANCj4g77u/DQo+IEhpIEpp
YXF1YW4sDQo+IA0KPiBJcyBpdCByZWFsbHkgcHJhY3RpY2FsIHRvIGhhdmUgYSBwYXJhbGxlbGl6
ZWQgcHJvdmlzaW9uaW5nIHByb2Nlc3M/IFdoZW4gdGhlIHByb3Zpc2lvbmVyIGlzIHBlcmZvcm1p
bmcgZGV2aWNlIGF1dGhlbnRpY2F0aW9uIGl0J3MgcHJldHR5IG11Y2ggYSAxOjEgb3BlcmF0aW9u
LCBlc3BlY2lhbGx5IHdpdGggT09CIG1ldGhvZHMgYmVpbmcgdXNlZC4NCj4gQW5kIHRoZSBwcm92
aXNpb25pbmcgb3BlcmF0aW9uIGl0c2VsZiBkb2Vzbid0IHJlYWxseSB0YWtlIG11Y2ggdGltZS4N
Cj4gDQo+IEkgZ3Vlc3MsIHByb3Zpc2lvbmluZyAiaW4tYnVsayIgY291bGQgYmUgcGFyYWxsZWxp
emVkIGZvciAianVzdC13b3JrcyIgc2NlbmFyaW8sIGJ1dCB0aGlzIGFwcHJvYWNoIGlzIHN0cm9u
Z2x5IGRpc2NvdXJhZ2VkIGZvciBvYnZpb3VzIHNlY3VyaXR5IHJlYXNvbnMuIEFuZCBldmVuIHRo
ZW4sIHByb3Zpc2lvbmluZyBvbmUgZGV2aWNlIGF0IGEgdGltZSB3b3VsZCBiZSBmYXN0LCBwaWNr
aW5nIG9uZSBieSBvbmUgZnJvbSB1bnByb3Zpc2lvbmVkIGRldiBiZWFjb25zLg0KDQpJ4oCZZCBq
dXN0IGxpa2UgdG8gZWNobyBJbmdh4oCZcyBkaXNjb3VyYWdlbWVudHMgcmVnYXJkaW5nIHRoZSBz
ZWN1cml0eSByaXNrcyBvZiBCdWxrIHVuLW1hbm5lZCDigJxKdXN0IFdvcmtz4oCdIHN0eWxlIHBy
b3Zpc2lvbmluZywgYnV0IGFsc28gdG8gYWRkIHRoYXQgbm8sIG11bHRpcGxlIHByb3Zpc2lvbmlu
ZyDigJxzZXNzaW9uc+KAnSBhcmUgbm90IGN1cnJlbnRseSBzdXBwb3J0ZWQsIGFuZCBJIGRvIG5v
dCBzZWUgdGhlbSBhcyBzb21ldGhpbmcgd2UgcGxhbiBvbiBzdXBwb3J0aW5nLg0KDQoNCj4gDQo+
IFJlZ2FyZHMsDQo+IEluZ2ENCj4gDQo+PiBPbiBUaHUsIDIwMjAtMDUtMjggYXQgMTk6MDIgKzA4
MDAsIEppYXF1YW4gSGUgd3JvdGU6DQo+PiBIaSBBbGwsDQo+PiANCj4+IEnigJltIHdvcmtpbmcg
b24gYSBibHVldG9vdGggbWVzaCBub2RlIHByb3Zpc2lvbmVyIGJhc2VkIG9uIEJsdWVaIDUuNTQs
IGFuZCBleHBlY3RpbmcgdG8gcHJvdmlzaW9uIGEgYnVuY2ggb2YgZGV2aWNlcyAobWVzaCBub2Rl
cykuDQo+PiANCj4+IEnigJltIGp1c3Qgc2ltcGx5IGNhbGxpbmcgb3JnLmJsdWV6Lm1lc2guTWFu
YWdlbWVudDEuQWRkTm9kZSBtdWx0aXBsZSB0aW1lcywgYnV0IGl0IHNlZW1zIHRoYXQgd2UgY2Fu
IGhhdmUgb25seSBvbmUgcHJvdi1pbml0aWF0b3IgYXQgYSB0aW1lLg0KPj4gDQo+PiBTbyBpcyB0
aGVyZSBhbnkgd2F5IHRvIGhhdmUgbXVsdGlwbGUgcHJvdmlzaW9uaW5nIHNlc3Npb25zIGF0IHRo
ZSBzYW1lIHRpbWU/IE9yIGRvZXMgaXQgbWFrZSBzZW5zZSB0byBwcm92aXNpb24gbXVsdGlwbGUg
bm9kZXMgYXQgdGhlIHNhbWUgdGltZT8NCj4+IA0KPj4gVGhhbmsgeW91Lg0KPj4gDQo+PiBSZWdh
cmRzLA0KPj4gSmlhcXVhbg0KPj4gDQo=
