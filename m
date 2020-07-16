Return-Path: <SRS0=Zco+=A3=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A01AC433DF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 17:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1014520842
	for <linux-bluetooth@archiver.kernel.org>; Thu, 16 Jul 2020 17:20:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="p14+9xz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729763AbgGPRUS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 16 Jul 2020 13:20:18 -0400
Received: from mga14.intel.com ([192.55.52.115]:39260 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729745AbgGPRUO (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 16 Jul 2020 13:20:14 -0400
IronPort-SDR: n3W9hsnS89Fbwiwua7cX9fscNOtT4kcsjxq4UZFEA/iDWuEG6MF3hXHQZiWdfWUDaPKnldKE6Y
 ugOOVm0cUkkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9684"; a="148604663"
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="148604663"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2020 10:20:13 -0700
IronPort-SDR: eIe5sgMYOGT3b+obeqY4BJ1q63Zn8NAuq7ZKQ7FvtiIsPGPu9HXeb560hLfaQ7P2uF7AgeX3+8
 Xelx4AepF7tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,360,1589266800"; 
   d="scan'208";a="286550862"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 16 Jul 2020 10:20:12 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Jul 2020 10:20:10 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Jul 2020 10:20:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server (TLS) id
 14.3.439.0; Thu, 16 Jul 2020 10:20:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tnn4aRrAnjGZGp1ocxoIa+tITgE0FuI6YNPpW7S/4DvocyO5Mr0a6MP/iqlgNlzCJttGCZ8dl1FAM50TYFCrnNdYZTrRneGg1/f/Rsy7yogElxh6z3BWtlHu4AXkvRFY6jko76zt+PYCBCpd8gB/knxCe6norsFDwumhdGFaISFxz9FJdL1O0b7X7cj2NFBsGpEbrz21/3XlqhOfuurVRJ6QPJBGvPKCTQi5dhWHvHoMWLzP7LBwZUwYOQ8fPlx+Z35a5ArU2IVbLjW8hhGR9oOErijLCbUr/HZVzJod17TpUXIMqrcvLm29/3ZvQ+CgY6ugku1nHUVMW/4yQ1ib8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnNNpqhfvBumIYTl80Z2HX4y0kVzcKFGYHY8JFu73Pk=;
 b=nRVGrwLkJVXlWZojBvUxRR7+4NKrd1+QSFjNIkUydiMAVncHE+5xvcUj/m70+120mv20aKLQkGoe25+8IcprfzzG1lgwwlFIynzF+MZDArjyooSnATVzcAHYD9ztE+MqCVghS1jXxTo/d0pjDSI/PC9iIOcupyR6z9PWw46Nlhm0tu8Z+vrvsgLte9aWLceQFyUfXJJsWN1is4ctsKfYplTobN+1yvot+7597cOWycAZfy7ak05os5nU4LlAg/fH1M3DJdfjoL91J6/rcCZ9FltRtocAa6FpKF76BbpRscSVPk/OBDT4liAt8O/J2vAPN4jCzPDuWEb/nPuzRhCFlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnNNpqhfvBumIYTl80Z2HX4y0kVzcKFGYHY8JFu73Pk=;
 b=p14+9xz+OhJIXx9n2SM2AU73cZa5McmpfreBpsNkXti7n9to2QjEwYXgFVIYuAcQZCG6QKWq4JMhqZS4mUM1DQvChlo6v6WG2zxxuaRsPYOGo/75r9Z4gBYGYYYFs2rN4KnYzwpqqpiUtCyUdbm4w2m/0GbA7lTr13B9gP/kUQQ=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MW3PR11MB4620.namprd11.prod.outlook.com (2603:10b6:303:54::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Thu, 16 Jul
 2020 17:20:07 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::6832:48b9:8cd2:7225%7]) with mapi id 15.20.3174.026; Thu, 16 Jul 2020
 17:20:07 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ 0/3] Code re-org and clean up
Thread-Topic: [PATCH BlueZ 0/3] Code re-org and clean up
Thread-Index: AQHWWWoixoubjY9ol0mpy1g9EZK8vqkKd94A
Date:   Thu, 16 Jul 2020 17:20:07 +0000
Message-ID: <d7030d55af456021bdb72fc0324c6abb54dde1bf.camel@intel.com>
References: <20200713230528.107948-1-inga.stotland@intel.com>
In-Reply-To: <20200713230528.107948-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [134.134.137.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90f42207-ae0f-4e14-3776-08d829ac7cb5
x-ms-traffictypediagnostic: MW3PR11MB4620:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW3PR11MB462099410AED86174BF99639E17F0@MW3PR11MB4620.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VpHAZYif3kvKfeeU1cZ8hdriQlrr6oi0jyBsFShL2wLfhJ1W8IJHZF1LKIypYkDz6uTJWAL7FNz/aYmcpCTWmOAW6NkJfdQWVg5+nToR5qZkwDe2AsHQqDzsAQ0xSessmWmwmUdD7J5dAMmHXJQuCydlT8Js9kYxf+3YCFgxSNkjtQ15iB7qRvw5x80p8ll/cqGm4RxktNw6SctwVxvCUHCjiMHlD5a8oP/T8eECbFHKIQMw7/Y4u1I+7Fxeee2DpuhuZ3jC2PuXBCC1w1N7ROn8cU19jzMlAqBSZIA0j/tWATOJ104jVPHXJarZ6VI8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(71200400001)(316002)(110136005)(6506007)(83380400001)(6636002)(6486002)(36756003)(6512007)(2906002)(26005)(66946007)(86362001)(2616005)(66476007)(66446008)(4744005)(8676002)(478600001)(8936002)(186003)(76116006)(64756008)(66556008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Dk+D1hqKmANdOjA5Z9reP8kK5S8okzfgAcBbbvK84rQhERNhOwLuQzqxwyfkD+rThvWZPVlAnKDXmbtRCHe7BLckVTkrj3gWedvSsZHs7XoDofNdn+0FYNc2T+DIrgfLAAusgisvBDnRaotCHDOCx1nCl91HOrTKc4Le9VvDt5T2FGRkYL6wr2PChBzp/kVKMDCS6EZnhtKtOKqOzFbwzv5v6dxqGIVzvnQKJC9hTvAzrjg6fIwXn5WqCTxXdU4Mz1x5TkO7yD68BvK8UPXUU7ZIkblq0p7XvjRYG970zaylO0BYaRCZQV/paqUD/jUZnjYZ5yQug47xqTFdIz4fnzWo0tML47daK0+u8zBJUSJtqVQb4btyNXcpmeFYlQyMsMK9603QZz+tO4zU8Vu88pRqK0cMtmH6knfo51PnnwxFx0HARbpu10QPuiAHuz0sIi4xyJmIqqRwEg4ouRrPLwkWSQmNfOwAvyRZhNcxdc6UDbf6FPu6JbV7f90PTbZH
Content-Type: text/plain; charset="utf-8"
Content-ID: <E5568DB302DC1C408CFCA23EF356C8F8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f42207-ae0f-4e14-3776-08d829ac7cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2020 17:20:07.4487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbaCvYeblekwERB8/Ulp1Ysw054t9Q631FcjhzQekgNDxQmlVojeQfv5VsF3Y6cmOeWdTnZKbrzEYebZDIM35A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4620
X-OriginatorOrg: intel.com
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBmaXJzdCB0d28gb2YgcGF0Y2hzZXQuDQoNCkhvbGRpbmcgb2ZmIG9uIHRoZSAzcmQg
dW50aWwgSSBjYW4gbW9yZSB0ZXN0IG1vcmUgY29tcGxldGVseS4NCg0KT24gTW9uLCAyMDIwLTA3
LTEzIGF0IDE2OjA1IC0wNzAwLCBJbmdhIFN0b3RsYW5kIHdyb3RlOg0KPiBUaGlzIHBhdGNoIHNl
dCBpcyBwYXJ0IG9mIHRoZSBvbi1nb2luZyAgY2xlYW4gdXAgZWZmb3J0IHRoYXQgdGFyZ2V0cyBz
b21lDQo+IG9mIG1vcmUgY29udm9sdXRlZCBhcmVhcyBvZiBtZXNoZCBzb3VyY2UgY29kZS4NCj4g
VGhlIHBhdGNoc2V0IHByb3ZpZGVzIGJldHRlciBmdW5jdGlvbmFsIHNlcGFyYXRpb24sIHNtYWxs
ZXIgZnVuY3Rpb24NCj4gZ3JhbnVsYXJpdHkgYW5kIGJldHRlciBtZW1vcnkgaGFuZGxpbmcuDQo+
IA0KPiBJbmdhIFN0b3RsYW5kICgzKToNCj4gICBtZXNoOiBVc2Ugc3RhdGljIGFycmF5IHRvIGhv
bGQgY29uZmlnIHNlcnZlciByZXNwb25zZQ0KPiAgIG1lc2g6IEFkZCBzaXplIGNoZWNrcyBmb3Ig
ZXZlcnkgb3Bjb2RlIGluIGNvbmZpZyBzZXJ2ZXINCj4gICBtZXNoOiBtb3ZlIG1vZGVsIGZ1bmN0
aW9uYWxpdHkgb3V0IG9mIG5vZGUuYyB0byBtb2RlbC5jDQo+IA0KPiAgbWVzaC9jZmdtb2Qtc2Vy
dmVyLmMgICAgfCAgOTkgKysrKysrLS0tLS0NCj4gIG1lc2gvY2ZnbW9kLmggICAgICAgICAgIHwg
ICA0ICstDQo+ICBtZXNoL21lc2gtY29uZmlnLWpzb24uYyB8ICAgNSArLQ0KPiAgbWVzaC9tb2Rl
bC5jICAgICAgICAgICAgfCAzNTkgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tLQ0KPiAgbWVzaC9tb2RlbC5oICAgICAgICAgICAgfCAgMzIgKystLQ0KPiAgbWVzaC9ub2Rl
LmMgICAgICAgICAgICAgfCAyODYgKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
IDYgZmlsZXMgY2hhbmdlZCwgNDAzIGluc2VydGlvbnMoKyksIDM4MiBkZWxldGlvbnMoLSkNCj4g
DQo=
