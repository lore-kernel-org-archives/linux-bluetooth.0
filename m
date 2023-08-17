Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A29C2FC0E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 11:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350382AbjHQLkY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 07:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbjHQLkO (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 07:40:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6232210C0
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 04:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692272413; x=1723808413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7ksZIbrK12QS9W+lQTauZ3MlcPguONN+PvDnHEsLCHU=;
  b=EUxKb7Ux/W7EZIzdvJqeHPbDLwZku2s5AKOTcpYmfHUJlr8f8LHKx/GF
   k63Ex4y2bNkXSWYd8w0CIedRg/jbRiCR+HBCyFe9c6o90t0MilVnHFOVg
   C7U/EtpQ2y9o3Fbon2JWncLzY7XGf62NefLRdtQLCfXbDg7wZjIOnydNM
   M6vNN0Fo1k4uJVmQwjMfWwtIjBbBtkjcrxjK1qGyu4/kLtKbZyGnXjtmH
   JS2L1l4EjQtShvbF0GfDzrMbQIKu8+PNM4mRFUHcEs14QPsjpMXnn5DR8
   iOx2kRdoprLULUoD6Q7isk0lpA6oWOxMa/5PefPmXJ0JHtBXck34UjJmF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="362936092"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="362936092"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="981126766"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981126766"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 04:40:03 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 04:40:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 04:40:02 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 04:40:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.107)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 04:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWx/9Vi/qmMKCtFiViZAcrOdJqkEfHmbLVVlAbYT9k8L2ZTEA5Er2BBsn93FtzBDeZckYO2GUPWruCEUZ+oCCnX8hb9hB4JpFBA4bJjWRqIYyO7cZSV1breLIxn0CLzEd7barF/fDKX3G8a7QMZPpZwforgNDbFrSQPzh0GgSCLAW8f9rX7Rfsl6LcuhQhcagVMzngRuiv6xk8m7D95TymkrNBwRKe5yPO/gLVmaKQA7jMHvG0XFAGqeRt5HLYfUepVGxutwBduxGXA039NrM15NglK79ZoMQuHm904xoQRBMt51ZlG/cxtYNh18nq9bxnsaMi0/iL4F/Uy1/fpxkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ksZIbrK12QS9W+lQTauZ3MlcPguONN+PvDnHEsLCHU=;
 b=i81zdqh87o0ZAyoFU50i1hF683Jx7xY+8bZfIVX4RllsgO2loyds5sOuYLlHQxUzGAsNIYrzE80ci7u0e+0+MtKrbTeKG8xOfpzcfjdXVZSL80Hxbq6TMvWAm6UYSmkSs5x8nel0WwCYPeFe0dg4X3WXueNWUfMJwGtuXKKWmw2+ZVBCShzbW8dFvC74gTJvmDHJXOdz58yVvEuD/e8nu7OZOxgs5YW7W9i4ADBM/REdaWGu6o3xJiVhvsR1g3pMTp3exBRMr6egd+gJUwHwy9QEOJRE0bshvIm92nRCvTowBbMn4U46ce5+hbq5hRIJJAHBm70r5EKfIDX8M+XXyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5862.namprd11.prod.outlook.com (2603:10b6:510:134::6)
 by DM4PR11MB6067.namprd11.prod.outlook.com (2603:10b6:8:63::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 11:39:55 +0000
Received: from PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::124e:6f4c:5d61:d52c]) by PH7PR11MB5862.namprd11.prod.outlook.com
 ([fe80::124e:6f4c:5d61:d52c%7]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 11:39:54 +0000
From:   "Singh, Lokendra" <lokendra.singh@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Von Dentz, Luiz" <luiz.von.dentz@intel.com>,
        "An, Tedd" <tedd.an@intel.com>, "K, Kiran" <kiran.k@intel.com>,
        Seema Sreemantha <seema.sreemantha@intel.com>
Subject: RE: [PATCH v2] Bluetooth: btintel: Send new command for PPAG
Thread-Topic: [PATCH v2] Bluetooth: btintel: Send new command for PPAG
Thread-Index: AQHZy5rnDVuKVn3YIUaN87apKi1NUa/jztUAgAqC9pA=
Date:   Thu, 17 Aug 2023 11:39:54 +0000
Message-ID: <PH7PR11MB586285C7C55AB8EB662473D38E1AA@PH7PR11MB5862.namprd11.prod.outlook.com>
References: <20230810145653.1780-1-lokendra.singh@intel.com>
 <CABBYNZJogALR3GwcR4CmsmjuhQaCytAHghgcaBLLeiu+QT+Zww@mail.gmail.com>
In-Reply-To: <CABBYNZJogALR3GwcR4CmsmjuhQaCytAHghgcaBLLeiu+QT+Zww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5862:EE_|DM4PR11MB6067:EE_
x-ms-office365-filtering-correlation-id: efddc1cb-14d8-4855-0357-08db9f16ad32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: adQ5x/Q2gUMUBl2lmxDUPF3ByTA5qqDtsfTbuTtuTSW36mXMzBBmao22AhsdL6D2G5pAwwn7Fsmh9vwQp6B30Zz4cvS2h139DeBPwD7eosVLDbXiBrNbaOLszctTj+Z0hV0lOBN5uD+JBl5YiLc05U2AtB/Z3dxCjfyfHzX81F5ysfCZC4awDg1mjIS9gdTo2uuCXMIfCafOo6JgwlA5ce1P50kLG9CRl6nG6dfV8p0gzgZXPTn5EWiohyVGD2CgbRoq8Koa14/+//EEmw8AtBAUMpLxSzPxTOjiDDXsC/2BSqOmmr92UI2WToZfrZmz32OqOE50aEV4Qanoowhrs8QTYuhNH0VNs1uleMZR1Ddf3mXiCZmMI0Y1ytAZo3tIKnABDFjnD8H9cok2oy0Qn4P4oXQbGyS9q40MhmKn7XeidY6LOmMpoRIO65bspFKzN8/YfSV0+vLlXIgwYd7MZ7hyMGok1klyTGF/H+ou9/+DvNK5fDaLEvfURDcgExjbyuyNzm5uaRKJnPdXeEB6flT84OVimkWH0sf+WuUvF0Q6Ur6kdwdSYIx0ACLVJ3VJc8WCi792IU8+MbHmv4Q+ReMNTsTIrS2WbRGuh9AXL+HZg+4KIN/V36LfzX1Q0TXq
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5862.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(451199024)(1800799009)(186009)(86362001)(33656002)(38070700005)(38100700002)(82960400001)(122000001)(55016003)(52536014)(5660300002)(107886003)(66946007)(66446008)(66476007)(66556008)(76116006)(478600001)(6916009)(53546011)(64756008)(71200400001)(316002)(6506007)(7696005)(54906003)(9686003)(26005)(41300700001)(8936002)(4326008)(8676002)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1RpQmhZMHNLUi85dmQyOU1KVnBWYlFIOXNMQU9rQ3ZSUkFEenJQK1VTKzRE?=
 =?utf-8?B?QUNpTndHVkVXVmhsYTRBRmg3TnRMM0hnbVN5bEV0NGQyNFhIZzBsUlVJVE9a?=
 =?utf-8?B?VThnZXpDUVV3bWtROC9sdnc2SDRIaXdQdmlPajh2TXRQS2N2Zms3TnVxZzhD?=
 =?utf-8?B?NFJpb0IyTG9BZENJNVZpUjRLU3lSODZZNWdDY0JEbzJPbUVMNDRCUFdMbUls?=
 =?utf-8?B?R1Z5TzNpcWpnM1ZiYzZrS0VLVnJiMWphekoxdzlDakxQenFtUGx1NjQ2VVVK?=
 =?utf-8?B?eU5uTml6WVRxUlozQUF0QVlBM3lUY0VmOUV0S3ZNWC81NUdsdmdCdytmaHBR?=
 =?utf-8?B?aDlNYytYUnZWTit2eG5oZld5cDBWdDFRbndsMHovK2lXZzVtWlRoZW53Z05Y?=
 =?utf-8?B?YitwaDd1Nnd0THE4VU5sWlppYXJRK2FtMTdMVkVVNUczdUhEanYrWGpmS3JJ?=
 =?utf-8?B?ckhPTVR3VjYzK1pkMU96SmhaTlArV2R6RVpJMUE1T0pUcjhsdXZHQzRJUWlj?=
 =?utf-8?B?Vy9XdmFQWXFjaEJHdHNvUk5oNzdNRHlQU0Y5Y1QwTlB6NStpVUF1N3hHR2Ft?=
 =?utf-8?B?VDUvUTRkNk9Mc24rNlI0YzJ0ODhqVkFzamI3cHJTV2NnZzU0RDd1OE1CbzFZ?=
 =?utf-8?B?djZuczhXZkZla0pnZXhLcDh3UnpVVUtNYytpdlBjZS9EVHRacWttZFpXZncz?=
 =?utf-8?B?c1NqeHNsS2YxWXNmWlBvaXBiWEI5TStoaUVRdU4ybGNVeUM4eE93amtFeHAr?=
 =?utf-8?B?TFBnTXhsRXdOanlubkhLRWtxQlpxQis4ZSsxSVpJTk0xdktGNTY1ZWJscHdM?=
 =?utf-8?B?eFdXWkdIcnN4Q1B0SlgyeFBJOUkzMitheVdYS3F0UXBIYXVHdWUwVUdKbTJW?=
 =?utf-8?B?OGlPZ2Y0Wm5mTi9ZcVpROGdiYVVNY2xTMWQza1FVQzJDWWZiYkJrT2xnRU8y?=
 =?utf-8?B?RStoQ2RoU1V5Um80QWp4NlRPN3lpcmVwV0NoelJDYTNjcVdJQnFBQ2ZVS1oy?=
 =?utf-8?B?Y0RWVmtQN0VXMVlNZUdRN0p1cDJWdDRyNSs3d1RTZVZJalFZVDA2TzVrOTBv?=
 =?utf-8?B?U3NLT0NJL2hBZDNHcFZZRSthMHNFbytEVU1LOHdrNUs1TGJJbXExL2xFbDJw?=
 =?utf-8?B?ck9OalJwc09UaGUzQjRuOEZ5NUE2L21SQk8xcjFBWWRoY1Z6dGJIKzYrY2l0?=
 =?utf-8?B?UXdqekZVVzkybnJwTGwvRDM0bXM4SjZRR3ZMUmhpbXhEcVpTUjdKNi9LTlFF?=
 =?utf-8?B?aE8wTTAwcXhFVlYzU2lLVDlGbk9RNUwxNGc4TDUyMEpKRUEzVG1LRjN0bFhP?=
 =?utf-8?B?bG9sWEJkVzlHQ0Y5VnpBcnVIZnVzQ0NXUjNLazEwN255QTRnWVpCM2Y5YXgr?=
 =?utf-8?B?cDZ3cFVtTnZzeDNCOS9EWlpaQmc2VWZjZUdUYkUyZHhaY1NIUXhCTXV0NHFF?=
 =?utf-8?B?ZVplSlBtU3NVWWZ1Qms2Mi9SY0dBZTg4S0pnUkptakF3UTROc0ovTUFhSnVK?=
 =?utf-8?B?V1hkUXBMUkw3UFRISHZBazZUY25RV2xtUEgwRDRoNlQxRlZ3RWtmOFcxUUVY?=
 =?utf-8?B?Tm9hcmFkNG01N0NnVnpIUlE1K0FleDZxQ2R3TWI1c1gxV3phTmtxRXZoUnFa?=
 =?utf-8?B?d2xpQ0ZpVjBMZFNPbzZhbjIzbWY3SWQ3d1o5TkVrYTFTQlVnN1N4M2NHSG1G?=
 =?utf-8?B?cmVZTFpTbDdtcmk5emFLbTFZc2Urd2UrTXBDandsUWNDRityQjk2VThOZFBn?=
 =?utf-8?B?amw5NmVOV1pKczV3UXMzNjdMdU41ZzBobVhQYlowMnhZNVJWaXN3Y2JpaHdr?=
 =?utf-8?B?RSt3NS8rWXNJSnhWdmo5MEt2dHZHMzFuZ25nRmk3aWRaajd0YVlkYy8zWE5S?=
 =?utf-8?B?TlY4N0VFaWVkNXBTVStkNExRcitSR3UyQ3hHWnc1QUpaaTFpVTZ1NkJ4UXRW?=
 =?utf-8?B?MGdmY21lTHN2cmdObUU4WjR6bDM2NTRrejlnanBNS0s4RWdHci9lTGl4NFJX?=
 =?utf-8?B?Ymk3YmNvM3h4SlM3TWFmT2VWaUdjbDd3UCtBTjkwNFZ1alE3SnU1WmJMa05O?=
 =?utf-8?B?UUw5SVczb0U2VHAwTU5mMlMvL2drTWdUQVNrWVZvWnh6b1FwUy9xZ01ueTAx?=
 =?utf-8?Q?jC81Tcg/zeC+aR8LGRmcWNV3Z?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5862.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efddc1cb-14d8-4855-0357-08db9f16ad32
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2023 11:39:54.6570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08OQword9+a/zWXefohLlK66LMNeHaLNVFKaLjQ2duoBvyNEnPXHh/VEJp5krsMuR4bsSD6PUZyruDNIuy/nnatUK09WWe7EiJLfrP8DfUE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6067
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IDEwIEF1Z3VzdCwgMjAyMyAxMToyMCBQTQ0KPiBUbzogU2luZ2gsIExva2VuZHJhIDxsb2tlbmRy
YS5zaW5naEBpbnRlbC5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3Jn
OyBTcml2YXRzYSwgUmF2aXNoYW5rYXINCj4gPHJhdmlzaGFua2FyLnNyaXZhdHNhQGludGVsLmNv
bT47IFR1bWt1ciBOYXJheWFuLCBDaGV0aGFuDQo+IDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGlu
dGVsLmNvbT47IFZvbiBEZW50eiwgTHVpeg0KPiA8bHVpei52b24uZGVudHpAaW50ZWwuY29tPjsg
QW4sIFRlZGQgPHRlZGQuYW5AaW50ZWwuY29tPjsgSywgS2lyYW4NCj4gPGtpcmFuLmtAaW50ZWwu
Y29tPjsgU2VlbWEgU3JlZW1hbnRoYSA8c2VlbWEuc3JlZW1hbnRoYUBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIEJsdWV0b290aDogYnRpbnRlbDogU2VuZCBuZXcgY29tbWFu
ZCBmb3IgUFBBRw0KPiANCj4gSGkgTG9rZW5kcmEsDQo+IA0KPiBPbiBUaHUsIEF1ZyAxMCwgMjAy
MyBhdCA4OjE44oCvQU0gTG9rZW5kcmEgU2luZ2gNCj4gPGxva2VuZHJhLnNpbmdoQGludGVsLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBBZGRlZCBzdXBwb3J0IGZvciB0aGUgbmV3IGNvbW1hbmQgb3Bj
b2RlIEZFMEIgKEhDSSBJbnRlbCBQUEFHIEVuYWJsZSkuDQo+ID4NCj4gPiBidG1vbiBsb2c6DQo+
ID4gPCBIQ0kgQ29tbWFuZDogSW50ZWwgUFBBRyBFbmFibGUgKDB4M2Z8MHgwMjBiKSBwbGVuIDQN
Cj4gPiAgICAgICAgIEVuYWJsZTogMHgwMDAwMDAwMg0KPiA+ID4gSENJIEV2ZW50OiBDb21tYW5k
IENvbXBsZXRlICgweDBlKSBwbGVuIDQNCj4gPiAgICAgICBJbnRlbCBQUEFHIEVuYWJsZSAoMHgz
ZnwweDAyMGIpIG5jbWQgMQ0KPiA+ICAgICAgICAgU3RhdHVzOiBTdWNjZXNzICgweDAwKQ0KPiA+
DQo+ID4gU2lnbmVkLW9mZi1ieTogU2VlbWEgU3JlZW1hbnRoYSA8c2VlbWEuc3JlZW1hbnRoYUBp
bnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogTG9rZW5kcmEgU2luZ2ggPGxva2VuZHJhLnNp
bmdoQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5j
IHwgMjggKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLQ0KPiA+IGRyaXZlcnMvYmx1ZXRvb3Ro
L2J0aW50ZWwuaCB8ICA4ICsrKy0tLS0tDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0
aW9ucygrKSwgMTQgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gaW5k
ZXggNjMzZThkOWJmNThmLi5kMmM5M2I4OGM1MjcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9i
bHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5j
DQo+ID4gQEAgLTI0MDEsNyArMjQwMSw3IEBAIHN0YXRpYyB2b2lkIGJ0aW50ZWxfc2V0X3BwYWco
c3RydWN0IGhjaV9kZXYNCj4gPiAqaGRldiwgc3RydWN0IGludGVsX3ZlcnNpb25fdGx2ICp2ZXIg
IHsNCj4gPiAgICAgICAgIHN0cnVjdCBidGludGVsX3BwYWcgcHBhZzsNCj4gPiAgICAgICAgIHN0
cnVjdCBza19idWZmICpza2I7DQo+ID4gLSAgICAgICBzdHJ1Y3QgYnRpbnRlbF9sb2NfYXdhcmVf
cmVnIHBwYWdfY21kOw0KPiA+ICsgICAgICAgc3RydWN0IGhjaV9wcGFnX2VuYWJsZV9jbWQgcHBh
Z19jbWQ7DQo+ID4gICAgICAgICBhY3BpX2hhbmRsZSBoYW5kbGU7DQo+ID4NCj4gPiAgICAgICAg
IC8qIFBQQUcgaXMgbm90IHN1cHBvcnRlZCBpZiBDUkYgaXMgSHJQMiwgSmZwMiwgSmZQMSAqLyBA
QA0KPiA+IC0yNDA5LDYgKzI0MDksOCBAQCBzdGF0aWMgdm9pZCBidGludGVsX3NldF9wcGFnKHN0
cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiBzdHJ1Y3QgaW50ZWxfdmVyc2lvbl90bHYgKnZlcg0KPiA+
ICAgICAgICAgY2FzZSAweDUwNDogICAgIC8qIEhycDIgKi8NCj4gPiAgICAgICAgIGNhc2UgMHgy
MDI6ICAgICAvKiBKZnAyICovDQo+ID4gICAgICAgICBjYXNlIDB4MjAxOiAgICAgLyogSmZwMSAq
Lw0KPiA+ICsgICAgICAgICAgICAgICBidF9kZXZfd2FybihoZGV2LCAiUFBBRyBub3Qgc3VwcG9y
dGVkIGZvciBJbnRlbCBDTlZyDQo+ICgweCUzeCkiLA0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICB2ZXItPmNudnJfdG9wICYgMHhGRkYpOw0KPiANCj4gSWYgdGhpcyBkb2Vzbid0IGNo
YW5nZSB0aGUgZnVuY3Rpb25hbGl0eSBJJ2QgcmVjb21tZW5kIHVzaW5nIGJ0X2Rldl9kYmcNCj4g
c28gd2UgZG9uJ3Qgd2FybiB1c2VycyBmb3Igbm8gcmVhc29uLg0KDQpBY2suIEkgd2lsbCB1cGRh
dGUgaXQgaW4gbmV4dCBwYXRjaC4NCj4gDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4g
PiAgICAgICAgIH0NCj4gPg0KPiA+IEBAIC0yNDM0LDI0ICsyNDM2LDMyIEBAIHN0YXRpYyB2b2lk
IGJ0aW50ZWxfc2V0X3BwYWcoc3RydWN0IGhjaV9kZXYNCj4gKmhkZXYsIHN0cnVjdCBpbnRlbF92
ZXJzaW9uX3RsdiAqdmVyDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAgIGlmIChwcGFn
LmRvbWFpbiAhPSAweDEyKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGJ0X2Rldl93YXJuKGhkZXYs
ICJQUEFHLUJUOiBkb21haW4gaXMgbm90IGJsdWV0b290aCIpOw0KPiA+ICsgICAgICAgICAgICAg
ICBidF9kZXZfd2FybihoZGV2LCAiUFBBRy1CVDogQmx1ZXRvb3RoIGRvbWFpbiBpcw0KPiA+ICsg
ZGlzYWJsZWQgaW4gQUNQSSBmaXJtd2FyZSIpOw0KPiANCj4gRGl0dG8uDQoNCkFjay4gSSB3aWxs
IHVwZGF0ZSBpdCBpbiBuZXh0IHBhdGNoLg0KPiANCj4gPiAgICAgICAgICAgICAgICAgcmV0dXJu
Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gLSAgICAgICAvKiBQUEFHIG1vZGUsIEJJVDAgPSAw
IERpc2FibGVkLCBCSVQwID0gMSBFbmFibGVkICovDQo+ID4gLSAgICAgICBpZiAoIShwcGFnLm1v
ZGUgJiBCSVQoMCkpKSB7DQo+ID4gLSAgICAgICAgICAgICAgIGJ0X2Rldl9kYmcoaGRldiwgIlBQ
QUctQlQ6IGRpc2FibGVkIik7DQo+ID4gKyAgICAgICAvKiBQUEFHIG1vZGUNCj4gPiArICAgICAg
ICAqIEJJVCAwIDogMCBEaXNhYmxlZCBpbiBFVQ0KPiA+ICsgICAgICAgICogICAgICAgICAxIEVu
YWJsZWQgaW4gRVUNCj4gPiArICAgICAgICAqIEJJVCAxIDogMCBEaXNhYmxlZCBpbiBDaGluYQ0K
PiA+ICsgICAgICAgICogICAgICAgICAxIEVuYWJsZWQgaW4gQ2hpbmENCj4gPiArICAgICAgICAq
Lw0KPiA+ICsgICAgICAgaWYgKChwcGFnLm1vZGUgJiAweDAxKSAhPSBCSVQoMCkgJiYgKHBwYWcu
bW9kZSAmIDB4MDIpICE9DQo+IEJJVCgxKSkgew0KPiA+ICsgICAgICAgICAgICAgICBidF9kZXZf
d2FybihoZGV2LCAiUFBBRy1CVDogRVUsIENoaW5hIG1vZGUgYXJlDQo+ID4gKyBkaXNhYmxlZCBp
biBDQi9CSU9TIik7DQo+IA0KPiBEaXR0by4NCg0KQWNrLiBJIHdpbGwgdXBkYXRlIGl0IGluIG5l
eHQgcGF0Y2guDQo+IA0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICB9
DQo+ID4NCj4gPiAtICAgICAgIHBwYWdfY21kLm1jYyA9IGNwdV90b19sZTMyKDApOw0KPiA+IC0g
ICAgICAgcHBhZ19jbWQuc2VsID0gY3B1X3RvX2xlMzIoMCk7IC8qIDAgLSBFbmFibGUgLCAxIC0g
RGlzYWJsZSwgMg0KPiAtIFRlc3RpbmcgbW9kZSAqLw0KPiA+IC0gICAgICAgcHBhZ19jbWQuZGVs
dGEgPSBjcHVfdG9fbGUzMigwKTsNCj4gPiAtICAgICAgIHNrYiA9IF9faGNpX2NtZF9zeW5jKGhk
ZXYsIDB4ZmUxOSwgc2l6ZW9mKHBwYWdfY21kKSwNCj4gJnBwYWdfY21kLCBIQ0lfQ01EX1RJTUVP
VVQpOw0KPiA+ICsgICAgICAgLyogSENJX0ludGVsX1BwYWdFbmFibGVfQ01EIC0gb3Bjb2RlOiAw
eEZFMEINCj4gPiArICAgICAgICAqIHBwYWdfZW5hYmxlX2ZsYWdzIC0gcHBhZyBtb2RlDQo+ID4g
KyAgICAgICAgKi8NCj4gPiArICAgICAgIHBwYWdfY21kLnBwYWdfZW5hYmxlX2ZsYWdzID0gcHBh
Zy5tb2RlOw0KPiA+ICsNCj4gPiArICAgICAgIHNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIDB4
ZmUwYiwgc2l6ZW9mKHBwYWdfY21kKSwNCj4gPiArICZwcGFnX2NtZCwgSENJX0NNRF9USU1FT1VU
KTsNCj4gPiAgICAgICAgIGlmIChJU19FUlIoc2tiKSkgew0KPiA+ICAgICAgICAgICAgICAgICBi
dF9kZXZfd2FybihoZGV2LCAiRmFpbGVkIHRvIHNlbmQgUFBBRyBFbmFibGUgKCVsZCkiLA0KPiBQ
VFJfRVJSKHNrYikpOw0KPiA+ICAgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gICAgICAgICB9
DQo+ID4gKyAgICAgICBidF9kZXZfaW5mbyhoZGV2LCAiUFBBRy1CVDogRW5hYmxlZCAoTW9kZSAl
ZCkiLCBwcGFnLm1vZGUpOw0KPiA+ICAgICAgICAga2ZyZWVfc2tiKHNrYik7DQo+ID4gIH0NCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmggYi9kcml2ZXJz
L2JsdWV0b290aC9idGludGVsLmgNCj4gPiBpbmRleCAyZWQ2NDY2MDlkZWUuLjAxZTg3ZjY4ZmFi
MCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmgNCj4gPiArKysg
Yi9kcml2ZXJzL2JsdWV0b290aC9idGludGVsLmgNCj4gPiBAQCAtMTM3LDExICsxMzcsOSBAQCBz
dHJ1Y3QgaW50ZWxfb2ZmbG9hZF91c2VfY2FzZXMgew0KPiA+ICAgICAgICAgX191OCAgICBwcmVz
ZXRbOF07DQo+ID4gIH0gX19wYWNrZWQ7DQo+ID4NCj4gPiAtc3RydWN0IGJ0aW50ZWxfbG9jX2F3
YXJlX3JlZyB7DQo+ID4gLSAgICAgICBfX2xlMzIgbWNjOw0KPiA+IC0gICAgICAgX19sZTMyIHNl
bDsNCj4gPiAtICAgICAgIF9fbGUzMiBkZWx0YTsNCj4gPiAtfSBfX3BhY2tlZDsNCj4gPiArc3Ry
dWN0IGhjaV9wcGFnX2VuYWJsZV9jbWQgew0KPiA+ICsgICAgICAgdTMyIHBwYWdfZW5hYmxlX2Zs
YWdzOw0KPiA+ICt9Ow0KPiANCj4gTGV0cyBhbHNvIGFkZCBkZWZpbmVzIHRvIGNvbW1hbmQgb3Bj
b2RlcyBzbyB3ZSBkb24ndCBoYXZlIHRvIGFkZA0KPiBjb21tZW50cyBvbiB3aGF0IHRoZSBvcGNv
ZGUgbWVhbnMgYXJvdW5kIHRoZSBjb2RlYmFzZS4NCg0KQWNrLiBJIHdpbGwgdXBkYXRlIGl0IGlu
IG5leHQgcGF0Y2guDQo+IA0KPiA+ICAjZGVmaW5lIElOVEVMX1RMVl9UWVBFX0lEICAgICAgICAg
ICAgICAweDAxDQo+ID4NCj4gPiAtLQ0KPiA+IDIuMjUuMQ0KPiA+DQo+IA0KPiANCj4gLS0NCj4g
THVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
