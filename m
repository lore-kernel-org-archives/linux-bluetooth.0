Return-Path: <SRS0=ILT4=BQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9F1C433E0
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 22:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A126C20748
	for <linux-bluetooth@archiver.kernel.org>; Thu,  6 Aug 2020 22:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="KBtKyELC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHFWrr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 6 Aug 2020 18:47:47 -0400
Received: from mga04.intel.com ([192.55.52.120]:20857 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbgHFWrp (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 6 Aug 2020 18:47:45 -0400
IronPort-SDR: SqiMjTx2noN/IV5c0UUeSZrxpbfkhGAkAjXjD+eNpchBFkRLoTlGD/1fVBfPOYgYUUvHUs4j7o
 7yM+KnXwgEww==
X-IronPort-AV: E=McAfee;i="6000,8403,9705"; a="150401048"
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="150401048"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 15:47:42 -0700
IronPort-SDR: TQFBkSmBcVF2wvdYcwWoHWJmOgaFoofjQS006WLrkcKOTYmNq+aqG4IvJ3bXMwq90a5f4fzFS+
 tm6+VML1XcgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,443,1589266800"; 
   d="scan'208";a="323589050"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga008.jf.intel.com with ESMTP; 06 Aug 2020 15:47:42 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 6 Aug 2020 15:47:42 -0700
Received: from FMSEDG001.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 6 Aug 2020 15:47:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 6 Aug 2020 15:47:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLotEFGba+r8kRSNxRICcXYTZXyQDKiKhQ3GH5uNl+oVNuoUmTqRBkKolB8n25K4F8vcJQDuNHqhqHxvzODG0pwfQM4fHqkyTlNrsLBPnZeauaF81qIxP+XOr8s79p0+CYqI8rrBU9wY2ircT+ffclMTd27ck7AYkOUsp5rxXjWt8wV7fdnAtwKvdrAQfLftlDvsVO0O0PpBYbvd8BMz24Z5U9kvevWHUtyGKst670aQMqXby81io2YibEe285GIgChblMTQjg8XrN9YV8BOO7ML3IDI6vx6hbY7BDBrQINmrNdo6Yz5ptaVpTF8sCJWqoBfDkJv11aeLee6Y7hx1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7XHCkoYhxVn3uqJ55SoGtJ0zb0z2/43XWdbFmOfjAs=;
 b=dzh4kWwLQ2H0MWugqe5fvOoosHK756W1YhdTapXLk7+zMTTOTobMJCtfp7mdnoWrVXruH5S7K2izSKC4fLHFsd9ilROCx2JFm/hPdbdcVFWBrdCqNv0y/BePko22t8HI8X7pM6QrGAxfofzt3o502MZ+PELInYk82JNXsd8OpeECOd86bhsZI0SUDNFJWmVeqmEKlSMHldHjb4KS65fEsqLkQZ2KoeQV6VcgOp9LXDkeCKEe6rjYYB0KcI9rVGvR8VT6NlmuZD0t32TnaOKIKHRqORXAEnsoEh0EsCZSNnlkvxt4+fun8dUtmwRoem51bpWp9jRH2k3nkwhGncCGzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7XHCkoYhxVn3uqJ55SoGtJ0zb0z2/43XWdbFmOfjAs=;
 b=KBtKyELC+X9nNOMLZrSOTEm3HcB7xhkMWCtyQsO18gndqXfMhEajhnLj7bm5NJICPbBOT62Y4IhDuYpMrbWFF2LTRFh/MI0pZuDQ8uD8j7IApuU04tpKRwuNNoWEPTpe6alGN8vIDpQwJlqYoqnlcpjraThS4XBh/dbs5+ydqhw=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR11MB1262.namprd11.prod.outlook.com (2603:10b6:300:29::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19; Thu, 6 Aug
 2020 22:47:33 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%6]) with mapi id 15.20.3261.016; Thu, 6 Aug 2020
 22:47:33 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "michal.lowas-rzechonek@silvair.com" 
        <michal.lowas-rzechonek@silvair.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH BlueZ] mesh: Allow deleting non-existing net key
Thread-Topic: [PATCH BlueZ] mesh: Allow deleting non-existing net key
Thread-Index: AQHWbBaJnr+b05JfNUW1TdQDlt2mM6krrvWA
Date:   Thu, 6 Aug 2020 22:47:33 +0000
Message-ID: <3de6d95d9fb718a23dce907197a646a08a7af6ea.camel@intel.com>
References: <20200806142108.32664-1-michal.lowas-rzechonek@silvair.com>
In-Reply-To: <20200806142108.32664-1-michal.lowas-rzechonek@silvair.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: silvair.com; dkim=none (message not signed)
 header.d=none;silvair.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.41]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e5acb108-ae6c-4c63-5c63-08d83a5ab565
x-ms-traffictypediagnostic: MWHPR11MB1262:
x-microsoft-antispam-prvs: <MWHPR11MB1262F11E788C1176B8911E30E1480@MWHPR11MB1262.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mt7Rkg8ZzIriRLhbmz69ATlmoRJakcOtGMQNN0L60CfgNf4xYEpvwsPM/W9DP+qbna5ZqvlGMlYtqLa2V2PHuIWNujTjGL/Ns7T1TS/dtgm4Yj7yOvVDHXsO83wN1Mswz4gljDZ7BoGKCiQy0Dtj9JfiU6OGJnnArhjPTBQ2YPtI3ia3VXHdteIxecI1lwWM+rUWpu8qGy7jyOjtnsZBLv4ejV/q8WtLcrmhDcMqZpG3OwT/duEhoxB2GPwGkxsOev4p1dM/jYuz88EapK3Flzm+SlNEfYMvPKCQM9tabYHh/WS9yzF3nhQ6/qGnXC/S
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(91956017)(2906002)(66556008)(66476007)(64756008)(66446008)(83380400001)(76116006)(66946007)(8936002)(8676002)(5660300002)(6506007)(2616005)(478600001)(4744005)(110136005)(71200400001)(6512007)(316002)(86362001)(26005)(186003)(36756003)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hYFvxhvktSsVyOqJgTA5XP5PCmnmA5nxlQH6cC89Tt7oIpVlLFRq0b30s7L+ZeV2iE9/7We9dfetDAlttHX0uliujE4tYAD8R1T0Ve/7fOj4MJDlgubWgtdGP83BETZ1oqVBYPF2j63AKsiZqWPkWmRPWzjBcywoidiWlMRVhVAo1BnY2S/jUbAS+C6Q33M3TflIOMen5z0gZhkcp4CkbtdbedbYHAGy0aAvGNr6a0hF9+ca1p4AaGWGQ4r0Fmd9juCaax2iZq+zdA8t8toAYphE90LX4rsgwhdNY1kHjYAsnMDRzRvDcN8eWXptBeWLGKiP6mvd5Ym+xMZK6XvYR2Q2x7xvskv4TUsf/mjboZRymTypakS+vKpe+9z9SaG2q8+vqZFh9cNLAPcrfsT20FUo+ZW8L7wbTTA1dWA61RtLRINOIbgql8ieQ0pf9idVboctmEfIj/Xi9Gb7ErYuCTk0GG/VyLMGTd5bzaJHUWkDGiPdjN4Kvg91AqWcex9l+QpP7VY7aW7MJiswGMZVi4haN0ATpZx5Rnltz+7cpPaAZh0Cp0HWx0nXeLLNoj64TevwEOj3EVxX0YieXMDyUzWblryivZgB+x/zuIYiJSJURNz2hmSHriDqZbWHyTnhKDPBkE/gwZKQoLRgfVKOXw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A067F867F1E09041862370A26A8B6758@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5acb108-ae6c-4c63-5c63-08d83a5ab565
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Aug 2020 22:47:33.6835
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oFIfAxDdcFgJS7pnoe45fgLuX0ABq+u7Zd6a65xsY+FRA1uHH31pdm8XIvpW+yTePBK6K1GTPLEdg8ug2zVaaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1262
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZA0KT24gVGh1LCAyMDIwLTA4LTA2IGF0IDE2OjIxICswMjAwLCBNaWNoYcWCIExvd2Fz
LVJ6ZWNob25layB3cm90ZToNCj4gV2hlbiBkZWxldGluZyBhIG5vbi1leGlzdGluZyBrZXksIGZp
cnN0IGNoZWNrIHRoYXQgaXQgZG9lc24ndCBleGlzdCAoYW5kDQo+IHJldHVybiBzdWNjZXNzKSwg
dGhlbiB2ZXJpZnkgaXQncyBub3QgdGhlIGxhc3Qga2V5IHdlIGhhdmUuDQo+IC0tLQ0KPiAgbWVz
aC9uZXQuYyB8IDggKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9uZXQuYyBiL21lc2gvbmV0
LmMNCj4gaW5kZXggN2NjNzVjZTQyLi5iMDQ0ZDdmZTAgMTAwNjQ0DQo+IC0tLSBhL21lc2gvbmV0
LmMNCj4gKysrIGIvbWVzaC9uZXQuYw0KPiBAQCAtNzg5LDE1ICs3ODksMTUgQEAgaW50IG1lc2hf
bmV0X2RlbF9rZXkoc3RydWN0IG1lc2hfbmV0ICpuZXQsIHVpbnQxNl90IGlkeCkNCj4gIAlpZiAo
IW5ldCkNCj4gIAkJcmV0dXJuIE1FU0hfU1RBVFVTX1VOU1BFQ0lGSUVEX0VSUk9SOw0KPiAgDQo+
IC0JLyogQ2Fubm90IHJlbW92ZSBwcmltYXJ5IGtleSAqLw0KPiAtCWlmIChsX3F1ZXVlX2xlbmd0
aChuZXQtPnN1Ym5ldHMpIDw9IDEpDQo+IC0JCXJldHVybiBNRVNIX1NUQVRVU19DQU5OT1RfUkVN
T1ZFOw0KPiAtDQo+ICAJc3VibmV0ID0gbF9xdWV1ZV9maW5kKG5ldC0+c3VibmV0cywgbWF0Y2hf
a2V5X2luZGV4LA0KPiAgCQkJCQkJCUxfVUlOVF9UT19QVFIoaWR4KSk7DQo+ICAJaWYgKCFzdWJu
ZXQpDQo+ICAJCXJldHVybiBNRVNIX1NUQVRVU19TVUNDRVNTOw0KPiAgDQo+ICsJLyogQ2Fubm90
IHJlbW92ZSBwcmltYXJ5IGtleSAqLw0KPiArCWlmIChsX3F1ZXVlX2xlbmd0aChuZXQtPnN1Ym5l
dHMpIDw9IDEpDQo+ICsJCXJldHVybiBNRVNIX1NUQVRVU19DQU5OT1RfUkVNT1ZFOw0KPiArDQo+
ICAJLyogRGVsZXRlIGFzc29jaWF0ZWQgYXBwIGtleXMgKi8NCj4gIAlhcHBrZXlfZGVsZXRlX2Jv
dW5kX2tleXMobmV0LCBpZHgpOw0KPiAgDQo=
