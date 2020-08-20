Return-Path: <SRS0=lMkY=B6=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA222C433E1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 14:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8647B2076E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 20 Aug 2020 14:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="mjGfDGBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgHTO2E (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:28:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:13235 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726896AbgHTO17 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 20 Aug 2020 10:27:59 -0400
IronPort-SDR: HxBVpRsm+Sy2sUCPsI93t5AwCC1/Hn7nzVrgEtrO1EzpbHfqQ0RQMlGDr40HDMbxS3lLgh6YPf
 XBzi3MLqZ81w==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="154572196"
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="154572196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2020 07:27:57 -0700
IronPort-SDR: hUbAF9faVDT9PR7HfwV1sCKB0Kpda6yPybyxdfFSSRDbdKoyhP+ePuUhsQWT+pX6moGt6+Uoy5
 16U+hH85RMxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,333,1592895600"; 
   d="scan'208";a="320894461"
Received: from orsmsx605-2.jf.intel.com (HELO ORSMSX605.amr.corp.intel.com) ([10.22.229.85])
  by fmsmga004.fm.intel.com with ESMTP; 20 Aug 2020 07:27:57 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 07:27:56 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 20 Aug 2020 07:27:56 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 20 Aug 2020 07:27:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 20 Aug 2020 07:27:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KX3r5wBuz/H18zE0M5KLb15i0ZV/BLsKRKJhzYdb+LOf4+TmHRhEzj3W5dySHkYaF+oiGaUGc6+u/Gj6nFQf+E7gGawZrfaxQklRfIG3jrzSV0UWb/Xu+78qYrn5+fcdVXSpxOQSc0t4b8YR3PsrDBifGx+zKOe5pzV6lg4MukwWG/M3+ACGHi1EoV63aQjoX9HcS1EZodwQ5Qf25gbm79/rmFBqVOZq4vH+KrXNBcH+zYulfuccCImYyd7bl6xE9wN52Iy7Y8jLuQeRBJOU6gVbY7pcuEgvgp1qVGDkdf06hTDLUCUqjkyRwKMr1f8IuR9DE6cuPgq7DsPzsk5Sew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQTjL1sx4wgAVdBN4rTtRsCgHLKYak50494NwMkw758=;
 b=ZwJgDPW+5DNpL75uiOjUc+UGdoj+BWJragH/ptYepjnl2RFRe4naEsr7V5tA5Kp8ccUhyeBbRc3bkSTm3/0IeWeIuNAYN2EeTcVxRC4mkPFSsLiHVSHbk5WkruibCpd0bXrHMh+urvjv8xrBJxk01KHToK9CNypasOPVdYCNdFdnbhwcR4E1xKz+cjNDclYvJOch1M96rJ6AY+p3q0ZeoXRG8CT6ZLYIfU9M2F+7lGBCB/O52GvcG6JkGQ/WsizDbT9+JXiHYe7WtZUp+OXIti0m0dSFleQj6SvykBN7pL0ZWo4FVxq6+rsG4CYxkqBJeVw+RPH0GlHa0TR7NvMlEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQTjL1sx4wgAVdBN4rTtRsCgHLKYak50494NwMkw758=;
 b=mjGfDGBQasLjxUHTVMeB3FNHNKbzS59mfsIgYFsEtIq34jXZL16y+tCxzz3ncVkA3by74+2j6YyDDSLSbzat9zBN8aq3NQnYd/m6VmxZTdq05cGDnHfSEjc5uZidUoNDAk4y6eG3f3jOv//Yav9XvT5HWuSA5yjdSdAoAu3Xc38=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4554.namprd11.prod.outlook.com (2603:10b6:303:5d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 20 Aug
 2020 14:27:53 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3305.024; Thu, 20 Aug 2020
 14:27:53 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 1/2] mesh: Always set net modes based on node
 feature settings
Thread-Topic: [PATCH BlueZ 1/2] mesh: Always set net modes based on node
 feature settings
Thread-Index: AQHWda4MLl0z9SlriUmes56mlHGlLKlBENAA
Date:   Thu, 20 Aug 2020 14:27:53 +0000
Message-ID: <748067b43861ae8fe3c17d4d0108d214bf431c8d.camel@intel.com>
References: <20200818222208.50938-1-inga.stotland@intel.com>
In-Reply-To: <20200818222208.50938-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.54.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0798940c-d5fe-48ad-b6c1-08d845153958
x-ms-traffictypediagnostic: MW3PR11MB4554:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB455475FE1A32E504278E325AE15A0@MW3PR11MB4554.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: F5vcs6TpRocsjmVFn8Zakl4JWSzKiU3Rtsx+ePUMfjTLJuuBVVOcEqgopeW3o4r0sMas/Y+okGk4fYNnL8UTOc1lUV0Z2oJ+wtlaW3G613020a6+YURce0UXgh/JrrwlXN/Yq7T5OVxKhzVw3SQCosfQOWef40pcqqTqnBGNI/kGDlNodCTOMuQmcBVmAGAE2lSHvRxEN5L0xTVLlUKAsRLJi5lx7tlJWgZHM6EI8Uv0JkpiBEw5wmoPKwEcjN2X8E19XQgJI9vTbLn2KU5T2xPFUEMyTLQrSwMx+rjUod15OsMQq2M9PTS3LMoCooFF1aFK9JWl7dQNwM68k9bvJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(366004)(39860400002)(8676002)(83380400001)(6636002)(26005)(6506007)(6486002)(71200400001)(8936002)(36756003)(86362001)(91956017)(76116006)(66946007)(66446008)(64756008)(66556008)(66476007)(186003)(2616005)(2906002)(478600001)(6512007)(5660300002)(110136005)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: pBEYolaGyJhPIFFPvTqBrOgHcUUOOgcRNCds4TcyRwj6w6JLjzi8l931Psr85vIrnn1ZwrjpC6Bw5pWdh4RyIbZVbuChZcDwr7i+EreE/W0evW4dLkueu5y4nqDmSj6+2VsoEH6Er5kpWdLGyWmrob2krUbflAkk0JZ0XOwLkJkphoHaUcUciIDtSgv/IlzHh5nexDfwmLOl5msajDwehoPZZJNN5OoRM+FX7wfbGVxQtzgOM6Ywm4eM9z/HvnRw4RxZyjJcodD3xhZF+3t7TmlS39hfj6d0/CqJYLOsFN3TeHp+sd8AdGtBL4KCa2kTXRJ14lxSPqV0qV45aYvgGqFuLSxdjYLJBEouTjAhLsOzF9SoBw0LGRyezavzvUojt7Hqb75wFLcPXImFxlM8FNL7qxgj83XAJ2Z2ix1fRY9SGWOcSIIr9vezJDuFRt1hsUYoOPBiPyU4TBtudzZeMNiLVaIefpOPTL8rTMI9svlglXySkjBqIIz1gk1ZA6RbAfgMvqD0G1bAyIkDSji0pxO7+xlncQM19ZMg3b02e7ILZt9Mo2wHRW2uzwWB/UK+Myx5q4Fk+MrKd17Jqoj5WkJiZFenImeAdy89cd8uqRLshV5JI6xa7Wo9waCK6iuX8YX7Q5qmJ+wFuY9oAJVvtw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <5419F3EB3CBF474F89BD8CB5CCC628CD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0798940c-d5fe-48ad-b6c1-08d845153958
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2020 14:27:53.1212
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9IggI9wyGtpeAkyskfZAZHNweAWzfvig1+jANcXeCJXBaP8FQJpC6xOmkwomhZdJ16Qq3gahRjjnyLCURHX/qg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4554
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBwYXRjaHNldCB3aXRoIHNwZWxsaW5nIGNvcnJlY3Rpb24NCg0KT24gVHVlLCAyMDIw
LTA4LTE4IGF0IDE1OjIyIC0wNzAwLCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGUgbmV0d29y
ayBzZXR0aW5ncyBzdWNoIGFzIHJlbGF5LCBiZWFjb24sIHByb3h5IGFuZCBmcmllbmQgYXJlDQo+
IGFsd2F5cyBzZXQgYmFzZWQgb24gbG9jYWwgbm9kZSBmZWF0dXJlIHNldHRpbmdzLiBUaGlzIGNo
YW5nZSBtYWtlcw0KPiB0aGUgbmV0IG1vZGVzIGludGlhbGl6YXRpb24gdW5jb25kaXRpb25hbCwg
dG8gaW5jbHVkZSB0aGUgIk5vIFN1cHBvcnQiDQo+IHNldHRpbmcgb24gbm9kZSBsZXZlbCB3aGlj
aCBzaG91bGQgcmVzdWx0IGluIHRoZSBkaXNhYmxlZCBtb2RlIGluIG5ldC5jDQo+IC0tLQ0KPiAg
bWVzaC9ub2RlLmMgfCAxOCArKysrKy0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21lc2gv
bm9kZS5jIGIvbWVzaC9ub2RlLmMNCj4gaW5kZXggMWVlZmZlYjhiLi5lYmMxMTFhNjIgMTAwNjQ0
DQo+IC0tLSBhL21lc2gvbm9kZS5jDQo+ICsrKyBiL21lc2gvbm9kZS5jDQo+IEBAIC0zOTksMjQg
KzM5OSwxNiBAQCBzdGF0aWMgYm9vbCBpbml0X3N0b3JhZ2VfZGlyKHN0cnVjdCBtZXNoX25vZGUg
Km5vZGUpDQo+ICANCj4gIHN0YXRpYyB2b2lkIHVwZGF0ZV9uZXRfc2V0dGluZ3Moc3RydWN0IG1l
c2hfbm9kZSAqbm9kZSkNCj4gIHsNCj4gLQl1aW50OF90IG1vZGU7DQo+ICsJc3RydWN0IG1lc2hf
bmV0ICpuZXQgPSBub2RlLT5uZXQ7DQo+ICANCj4gLQltb2RlID0gbm9kZS0+cHJveHk7DQo+IC0J
aWYgKG1vZGUgPT0gTUVTSF9NT0RFX0VOQUJMRUQgfHwgbW9kZSA9PSBNRVNIX01PREVfRElTQUJM
RUQpDQo+IC0JCW1lc2hfbmV0X3NldF9wcm94eV9tb2RlKG5vZGUtPm5ldCwgbW9kZSA9PSBNRVNI
X01PREVfRU5BQkxFRCk7DQo+ICsJbWVzaF9uZXRfc2V0X3Byb3h5X21vZGUobmV0LCBub2RlLT5w
cm94eSA9PSBNRVNIX01PREVfRU5BQkxFRCk7DQo+ICANCj4gLQltb2RlID0gbm9kZS0+ZnJpZW5k
Ow0KPiAtCWlmIChtb2RlID09IE1FU0hfTU9ERV9FTkFCTEVEIHx8IG1vZGUgPT0gTUVTSF9NT0RF
X0RJU0FCTEVEKQ0KPiAtCQltZXNoX25ldF9zZXRfZnJpZW5kX21vZGUobm9kZS0+bmV0LCBtb2Rl
ID09IE1FU0hfTU9ERV9FTkFCTEVEKTsNCj4gKwltZXNoX25ldF9zZXRfZnJpZW5kX21vZGUobmV0
LCBub2RlLT5mcmllbmQgPT0gTUVTSF9NT0RFX0VOQUJMRUQpOw0KPiAgDQo+IC0JbW9kZSA9IG5v
ZGUtPnJlbGF5Lm1vZGU7DQo+IC0JaWYgKG1vZGUgPT0gTUVTSF9NT0RFX0VOQUJMRUQgfHwgbW9k
ZSA9PSBNRVNIX01PREVfRElTQUJMRUQpDQo+IC0JCW1lc2hfbmV0X3NldF9yZWxheV9tb2RlKG5v
ZGUtPm5ldCwgbW9kZSA9PSBNRVNIX01PREVfRU5BQkxFRCwNCj4gKwltZXNoX25ldF9zZXRfcmVs
YXlfbW9kZShuZXQsIG5vZGUtPnJlbGF5Lm1vZGUgPT0gTUVTSF9NT0RFX0VOQUJMRUQsDQo+ICAJ
CQkJCW5vZGUtPnJlbGF5LmNudCwgbm9kZS0+cmVsYXkuaW50ZXJ2YWwpOw0KPiAgDQo+IC0JbW9k
ZSA9IG5vZGUtPmJlYWNvbjsNCj4gLQlpZiAobW9kZSA9PSBNRVNIX01PREVfRU5BQkxFRCB8fCBt
b2RlID09IE1FU0hfTU9ERV9ESVNBQkxFRCkNCj4gLQkJbWVzaF9uZXRfc2V0X2JlYWNvbl9tb2Rl
KG5vZGUtPm5ldCwgbW9kZSA9PSBNRVNIX01PREVfRU5BQkxFRCk7DQo+ICsJbWVzaF9uZXRfc2V0
X2JlYWNvbl9tb2RlKG5ldCwgbm9kZS0+YmVhY29uID09IE1FU0hfTU9ERV9FTkFCTEVEKTsNCj4g
IH0NCj4gIA0KPiAgc3RhdGljIGJvb2wgaW5pdF9mcm9tX3N0b3JhZ2Uoc3RydWN0IG1lc2hfY29u
ZmlnX25vZGUgKmRiX25vZGUsDQo=
