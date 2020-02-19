Return-Path: <SRS0=cHq6=4H=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5C1C34031
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8A122176D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 Feb 2020 02:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vJENN/2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgBSCSy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:18:54 -0500
Received: from mga12.intel.com ([192.55.52.136]:42269 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726882AbgBSCSy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 Feb 2020 21:18:54 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2020 18:18:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,458,1574150400"; 
   d="scan'208";a="235735405"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 18 Feb 2020 18:18:53 -0800
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:18:53 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 18 Feb 2020 18:18:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JGRVPeUA2/NzXjJN6K8u+zT71NkWSlvEhJt7nzcgv4lqMMgjwwCLBWA9Txo82GxkGClEh25oMUZJ8PpkXJTm0pX8NWDMeV/VOXbnvtRFZDXcuvexMyufhEyKELvIezvsuXZG+WMNxZ8A2kI0Fa+24iVPoXw+4Vbi1IauVF8x+5gm+uYGuihd75JffC9uLYfZX2ptgwS6eNlTsluIdrHVxJa4Nv+Jr25IbQm5ISB7KbN/Cn+R8GtQg6KCZIj6R2XH1+3wcg4XW7SJSZCnJ5BceZp2qZSzmL835eGzpnBR6+f4rgudNZPb8YlwCGHwXLpBlt8DWsLCg3cEZ384iP3xcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHOtZ8zPUNZATGYM+FXtCyl5J5i49A1hzOuNN1NdQuI=;
 b=lZjYgDJhXUr2inU6flVRF8wUhaWVw8VMSFkJ66IpIJyFVOazOzsAXnLt43LoFm6VCkxYQ6udc9Yp7LBJ7dIwVFiQcDeHPhFsJHVwoV0ko3Ssh+lJlpPa7bFg9SYS6gU4wxKHxO5fOmd6ntH/BT0G+dohJgrAiCVLKCtCAzOA0Bd/e2Mh5aOC813Iq/SaPpbrb2bIOb5fuOD8gSVgiVnaIdzWN0SbxdALtLDzSpuanOfh45SOdoWqBnD6CaobpI31HBsjdWsvGnEWr46pqB98qmEzfJAd9UFuKMkgEW3pP9GVVGkmmW5qM3oqYJG4NtJLNU71vWDMd36KaIiekbydug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHOtZ8zPUNZATGYM+FXtCyl5J5i49A1hzOuNN1NdQuI=;
 b=vJENN/2cfh0nUqbsF+7HnswnNfnbaIUnkb3yiUG5HgiZBTcI/CcyDRDIBWhb/2H33CRbqlIyXnFJqKtpFwq+Jpw3LRlD84bwI9eSz7+NySm/qprFpdGcfudkEWvjmqkCYz85SIZjCMN9i8by+lRXeZVsoVnehwT5YtTTEYuokas=
Received: from BN7PR11MB2580.namprd11.prod.outlook.com (52.135.246.155) by
 BN7PR11MB2708.namprd11.prod.outlook.com (52.135.252.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 02:18:52 +0000
Received: from BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6]) by BN7PR11MB2580.namprd11.prod.outlook.com
 ([fe80::c8ca:3c11:3fc5:a9d6%6]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 02:18:51 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] unit: Add Mesh test 8.3.22 - Virtual Addressing
Thread-Topic: [PATCH BlueZ] unit: Add Mesh test 8.3.22 - Virtual Addressing
Thread-Index: AQHV5opqQ0b/xgkcGUKk2kf0P42PDKghyMWA
Date:   Wed, 19 Feb 2020 02:18:51 +0000
Message-ID: <53be91bb910356a96f7967b3b9fa5fac4522c0be.camel@intel.com>
References: <20200218183602.9892-1-brian.gix@intel.com>
In-Reply-To: <20200218183602.9892-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=brian.gix@intel.com; 
x-originating-ip: [192.55.54.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 976d502a-555f-4eb1-9593-08d7b4e20ff8
x-ms-traffictypediagnostic: BN7PR11MB2708:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN7PR11MB2708940338F91F50620671E4E1100@BN7PR11MB2708.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2000;
x-forefront-prvs: 0318501FAE
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(346002)(396003)(39860400002)(376002)(366004)(199004)(189003)(6916009)(316002)(26005)(91956017)(66946007)(186003)(6512007)(76116006)(6486002)(5660300002)(81166006)(81156014)(36756003)(8676002)(66476007)(66556008)(107886003)(66446008)(64756008)(2616005)(478600001)(86362001)(8936002)(71200400001)(2906002)(4326008)(6506007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN7PR11MB2708;H:BN7PR11MB2580.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YON2MeXaYSpl0n0Z8feZBZySBApkVf/635cNB1EAuIUsPgP245qXC+uCXOT9IJMqGNo3Px52Gb/kLD6CMBiClZnhQvcXYnwiq6/jJIFl8/YPy8JXNFmdNlhKwg6Kh0EdhnuN0itMYH6d171Aukfo5lL9B3ur+Nc8GJaA6HUF+6ikMMh0AsG8j95t8dSFvRqHWXtUank6+nVapAErWO7mEukJ3G/q75z12Zgrn5lsnZ8XmtZxg2QCX3m0fh4qtbZYy7fPSgiEOPCfrc5i7A6k+ME7D3YvaOQHwIqp49kDPTZ6uugsdtdM5Z+oFujGvUEwRr/wyyXAdsZSTfq9Fc6uCmWMhjtqOsSs4REDWhjuwCSAPt64IoXNpVPmhIsTVklMFBoyGzNg7u8IeUT5hXRlT6L4JTVco4k5k6YoqC1JpAfRqsLt8T2OJoXJsAsZQxvJ
x-ms-exchange-antispam-messagedata: POk3YDC32KbN9JH0dDJPr9l7Z2fZILHpKTnd1iY/setk8DkeHrKIpim6H5EhAzDDHzHALsy9wjNtNgnYWsUSrp1sEYTqV+QEEzSHCgZ14XSj+UIoJpZ8n5/bhSPkWs+p0cR4DRQoHB30BV9bQoSdWw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <A36869FFF2DDA74DB53A171CA8A58844@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 976d502a-555f-4eb1-9593-08d7b4e20ff8
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2020 02:18:51.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4jpBKYVf2o706sH4ZsURs+CaF+iLjI3hmbDVwUcOTmu4q4buIiyE5d6Vq04S2OJHyy53x5UaC5N/WCwiPhX3QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2708
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVHVlLCAyMDIwLTAyLTE4IGF0IDEwOjM2IC0wODAwLCBCcmlhbiBHaXggd3Jv
dGU6DQo+IC0tLQ0KPiAgdW5pdC90ZXN0LW1lc2gtY3J5cHRvLmMgfCA0MSArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQxIGluc2Vy
dGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS91bml0L3Rlc3QtbWVzaC1jcnlwdG8uYyBiL3Vu
aXQvdGVzdC1tZXNoLWNyeXB0by5jDQo+IGluZGV4IDZjMmQzNjczNi4uMzJjNDZhNTRlIDEwMDY0
NA0KPiAtLS0gYS91bml0L3Rlc3QtbWVzaC1jcnlwdG8uYw0KPiArKysgYi91bml0L3Rlc3QtbWVz
aC1jcnlwdG8uYw0KPiBAQCAtNTg4LDYgKzU4OCw0NSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IG1l
c2hfY3J5cHRvX3Rlc3QgczhfM18xMSA9IHsNCj4gIAkucGFja2V0CQk9IHsiNWU2ZWJmYzAyMWVk
ZjVkNWU3NDhhMjBlY2ZkOThkZGZkMzJkZTgwYmVmYjQwMDIxM2QxMTM4MTNiNSJ9LA0KPiAgfTsN
Cj4gIA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtZXNoX2NyeXB0b190ZXN0IHM4XzNfMjIgPSB7
DQo+ICsJLm5hbWUJCT0gIjguMy4yMiBNZXNzYWdlICMyMiIsDQo+ICsNCj4gKwkuYXBwX2tleQk9
ICI2Mzk2NDc3MTczNGZiZDc2ZTNiNDA1MTlkMWQ5NGE0OCIsDQo+ICsJLm5ldF9rZXkJPSAiN2Rk
NzM2NGNkODQyYWQxOGMxN2MyYjgyMGM4NGMzZDYiLA0KPiArCS5kZXZfa2V5CT0gIjlkNmRkMGU5
NmViMjVkYzE5YTQwZWQ5OTE0ZjhmMDNmIiwNCj4gKwkuaXZfaW5kZXgJPSAweDEyMzQ1Njc3LA0K
PiArDQo+ICsJLm5ldF9uaWQJPSAweDY4LA0KPiArCS5uZXRfdHRsCT0gMHgwMywNCj4gKwkuYXBw
X3NlcQk9IDB4MDcwODBiLA0KPiArCS5uZXRfc2VxCT0gezB4MDcwODBifSwNCj4gKwkubmV0X3Ny
Ywk9IDB4MTIzNCwNCj4gKwkubmV0X2RzdAk9IDB4YjUyOSwNCj4gKwkudXVpZAkJPSAiMDA3M2U3
ZTRkOGI5NDQwZmFmODQxNWRmNGM1NmMwZTEiLA0KPiArCS5ha2YJCT0gdHJ1ZSwNCj4gKwkua2V5
X2FpZAk9IDB4MjYsDQo+ICsJLmFwcF9tc2cJPSAiZDUwYTAwNDg2NTZjNmM2ZiIsDQo+ICsJLmVu
Y19tc2cJPSAiMzg3MWI5MDRkNDMxNTI2MyIsDQo+ICsJLmFwcF9taWMzMgk9IDB4MTZjYTQ4YTAs
DQo+ICsNCj4gKwkuZW5jX2tleQk9ICIwOTUzZmE5M2U3Y2FhYzk2MzhmNTg4MjAyMjBhMzk4ZSIs
DQo+ICsJLmFwcF9ub25jZQk9ICIwMTAwMDcwODBiMTIzNGI1MjkxMjM0NTY3NyIsDQo+ICsNCj4g
KwkucHJpdl9rZXkJPSAiOGI4NGVlZGVjMTAwMDY3ZDY3MDk3MWRkMmFhNzAwY2YiLA0KPiArDQo+
ICsJLm5ldF9ub25jZQk9IHsiMDAwMzA3MDgwYjEyMzQwMDAwMTIzNDU2NzcifSwNCj4gKw0KPiAr
CS5wcml2X3JhbmQJPSB7IjAwMDAwMDAwMDAxMjM0NTY3N2VkMzFmM2ZkY2Y4OGE0In0sDQo+ICsN
Cj4gKwkudHJhbnNfcGt0CT0geyI2NjM4NzFiOTA0ZDQzMTUyNjMxNmNhNDhhMCJ9LA0KPiArDQo+
ICsJLm5ldF9tc2cJPSB7ImVkMzFmM2ZkY2Y4OGE0MTExMzVmZWE1NWRmNzMwYiJ9LA0KPiArDQo+
ICsJLm5ldF9taWMzMgk9IHsweDZiMjhlMjU1fSwNCj4gKw0KPiArCS5wYWNrZXQJCT0geyJlOGQ4
NWNhZWNlZjFlM2VkMzFmM2ZkY2Y4OGE0MTExMzVmZWE1NWRmNzMwYjZiMjhlMjU1IiB9LA0KPiAr
fTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtZXNoX2NyeXB0b190ZXN0IHM4XzRfMyA9
IHsNCj4gIAkubmFtZQkJPSAiOC40LjMgU2VjdXJlIE5ldHdvcmsgQmVhY29uIiwNCj4gIA0KPiBA
QCAtMjAxMyw2ICsyMDUyLDggQEAgaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkNCj4g
IAljaGVja19kZWNyeXB0KCZzOF8zXzEwKTsNCj4gIAljaGVja19lbmNyeXB0KCZzOF8zXzExKTsg
LyogU2luZ2xlIHNlZ21lbnQgdGVzdGVyIHVuYXZhaWxhYmxlICovDQo+ICAJY2hlY2tfZGVjcnlw
dCgmczhfM18xMSk7IC8qIFNpbmdsZSBzZWdtZW50IHRlc3RlciB1bmF2YWlsYWJsZSAqLw0KPiAr
CWNoZWNrX2VuY3J5cHQoJnM4XzNfMjIpOw0KPiArCWNoZWNrX2RlY3J5cHQoJnM4XzNfMjIpOw0K
PiAgDQo+ICAJLyogU2VjdGlvbiA4LjQgQmVhY29uIFNhbXBsZSBEYXRhICovDQo+ICAJY2hlY2tf
YmVhY29uKCZzOF80XzMpOw0K
