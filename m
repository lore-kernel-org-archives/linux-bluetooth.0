Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C7ACDB465
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Oct 2023 02:31:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJQCbp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Oct 2023 22:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjJQCbo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Oct 2023 22:31:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8A7AC
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Oct 2023 19:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697509902; x=1729045902;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Ac3i84uME5x3c1ur296wFqnEqlBBQsAe8J9+F1RQAIw=;
  b=GYPL4D3ToAmluP5XshAKGSP+jxT0icLdHK438++q/zrAjTjw0U8IkeYP
   qQD/oaEHc6qw6voqqeElGErC1IdFfUMyfDAWsufwSvFIt1XsOKhj2T217
   /uYQYT46YDXf4bec0w/wg845S3zCF+UuTm5Me/0Hm9dpl1RfX9JTs1Aot
   bTEMXOSiyY20rw6BKbIkueiiKSxytzeTKxFSN+Iuzvcijhjb3IHF163rL
   4m2WDZDXN/ahUezcVI1ZJSHMCe42fBXf4SfH2kA9zhseT26EpeuOVuB/M
   gSZ1GqbEs3phbT0w+o+sEHB1scUJYBYRNqaucMboS/wc9fiJP1F+Lcx6m
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="388544944"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="388544944"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 19:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="705817075"
X-IronPort-AV: E=Sophos;i="6.03,230,1694761200"; 
   d="scan'208";a="705817075"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Oct 2023 19:31:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 19:31:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 16 Oct 2023 19:31:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 16 Oct 2023 19:31:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 16 Oct 2023 19:31:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vwg96hT5ZOLzsOj3W4zZG5zhKdevcDu56FuFVcmWTDiMUIsq+xZ4lAEVqmjW/zkH8+u6ergEGBOUhXRAjMTw7l4tYd8YmuFePNUjMOz0vHoEaOVCY6vpS8ZFxviJvHNyCFzscCd9mJv/r/j4rid6DzSK0JG2QylicH6JcgqBghieLkn6G6Dn6VVyHqhUskPbdiW87eMFs3g4Femx36QAyENUNJlJoWELOopAWcd4tLPKgsJ6hYQaF21wdImRUSW/9SZSm9uydTI27ol79Zv21ILQo+aQhqukzPy33EPhfj6AZ/5z1IR0RyBjSfHZxIrF7HYy//8jFYegF/lbNx/N9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac3i84uME5x3c1ur296wFqnEqlBBQsAe8J9+F1RQAIw=;
 b=RALinSeVrN1DkIMvDBBSx+EbkKljdWOuTpJ31ccC1NwWnMBYCYfqIil1M5D3UoCCQ84PuYJWxqu8YzxglkTbEAXMDCZn9b3pGJjBAcrzSm3P6XTSLhDi14gwRJVdFo9iSa23MKoFSOecjXBHdd4B7JZfv0FFjSb9N5bccogw/Sb5A6eKhe/hRiHGlyqXUxKiI2Xi7czUBeoVSIj2QuYs4aQKijGd9DE7CbWS7F8qa9Dzl/8Zi+HkD9fShuHu3gEhDIYfa8DUCyXii9vK9Ov0Pvo48kha4ky3hG46E6ahkAgV2o/dzHHRezXaHfuQDmnf1SaZT5p4HxLfTcgDG9SSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB7585.namprd11.prod.outlook.com (2603:10b6:510:28f::10)
 by SA1PR11MB6736.namprd11.prod.outlook.com (2603:10b6:806:25f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Tue, 17 Oct
 2023 02:31:39 +0000
Received: from PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::1696:cc4b:2d45:25a7]) by PH0PR11MB7585.namprd11.prod.outlook.com
 ([fe80::1696:cc4b:2d45:25a7%3]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 02:31:39 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH 2/2] shared/bap: Add support for Audio Locations
Thread-Topic: [PATCH 2/2] shared/bap: Add support for Audio Locations
Thread-Index: AQHZ//uoLv+WMLkz1kmPWNs8Vx+zXbBMrz2AgACUCNA=
Date:   Tue, 17 Oct 2023 02:31:38 +0000
Message-ID: <PH0PR11MB75854498102379A68F76610AF5D6A@PH0PR11MB7585.namprd11.prod.outlook.com>
References: <20231016065228.424400-1-kiran.k@intel.com>
 <20231016065228.424400-2-kiran.k@intel.com>
 <CABBYNZKOzgP5ordRNK9UX=i3r=BMM4OushpaN2nO=Ntuexe_kg@mail.gmail.com>
In-Reply-To: <CABBYNZKOzgP5ordRNK9UX=i3r=BMM4OushpaN2nO=Ntuexe_kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB7585:EE_|SA1PR11MB6736:EE_
x-ms-office365-filtering-correlation-id: 822fb5c6-e243-41b2-9ee7-08dbceb930f7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QkCW/IYfdsYQ+ROYhhutMg3Txlx5r+G2nu6exYTV3e+nyxreOllac5FNSoYRWCagJJ83oeHTn1142s4fz6v6BpWmJY1DV8PUwB4r5C3fGvptzRyxH4AEMwFDQcwN7aYdBwc862hceaR/ACz1EyFCM0bR3shqZUU5gaxCEv7pSFbWpQ8twFJkPLfTrTTMmd6I/aGxwNzsRs5XF+JA4ghGMNcIH3f1NQ/GXlmwEaksI0mmDvq95NXN3r8MKuBYQ3PBVCPTdyoUn2wTJK0gQdFqP3J/2193j41YUov8CPDQ8RC2QZujYW/vp6v6NpeOp6ihmqZJUvpFTpPpQbNNAhJv+Q8X9yuXGm+6KGqbBU+Qyv2ZZ04HBox/tRKQopI2G2fAANZB6doYhQZSqYksjUJg1DQaXvjLDKaFIoPdX67QFMEagqnGrGS+g33EAEDJjQ4sEnYFTU7Oi6x3KBI+3v9QqS3iUjtRYr8cd18uKOppgMiLOlsDwak8AQAO1uYO3zSJZ4PfXuZ3zNVCFbEdTXXjXOmLI2STz0XsgpCNP1/lx+SRj6rKy1HSs+1UiWoPKAJ5PlOlAvlpvHWVA3JrOAqG2g6fFT7W3YsRz7czVQN65/UlHnXGPr3fBn3pC1hR9D4LSl8Fk2Ylkf6je+hn7caMMA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB7585.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(2013699003)(86362001)(33656002)(55016003)(66476007)(4326008)(8936002)(66946007)(26005)(8676002)(66556008)(66446008)(107886003)(41300700001)(6916009)(2906002)(76116006)(4744005)(71200400001)(64756008)(316002)(54906003)(5660300002)(6506007)(7696005)(52536014)(478600001)(82960400001)(122000001)(9686003)(38070700005)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlFCcVFkTXJzZ0J2Zml6SnB1eG5qWnZxZjAycE00ZDd5WER4RGdxQ2hWWEhU?=
 =?utf-8?B?UHVYYUd2b090NUlBT3hZM0FBTmRxcnVsSlZBWG1mZ29YUWp2QWJFTmR1ckpx?=
 =?utf-8?B?SUFGc0NrWlV6TUN1K1E3QW42anVQY3ZodmV3ZmtXclFTeTBrcC8ycmgzYzA4?=
 =?utf-8?B?MGZ1L1VkekRKeko5MXlYZitaaWxqTjlhNkcxZG1Pd1hXc0NYNXQ5SnpONDJW?=
 =?utf-8?B?ZTY3Unlha3A4UkExUWJWYitnUzFtTTdVRmk2dEVraHpSRlJUZzRKOHNyS1Nz?=
 =?utf-8?B?LzBONDhkeXVVR0RCaW5OWnVzcThwbXdCMkNtSWhkUzVLLy92RHJ0WEQ5YWIz?=
 =?utf-8?B?ZFc2dXY5S1J6bkY3a21ROVFNeXVsT1hJcDU2Q3ZnSDN4ZWhPL09CVlRXR25O?=
 =?utf-8?B?QnZJQk05cytVai9jb1czakdybUlOdDROYXdteGJ1UURtMUtoUXpXUmh2WDdC?=
 =?utf-8?B?ZUhWMUxBQm5CK3hKcllvd3NISHhGSCtMUENBN0JmL0VhcG1EUXJzU2pYbWgy?=
 =?utf-8?B?RWVveU1DaU5kZmRWVW92WWoyaTVVYllkTFROZExMcFBIVDlqLzlyZFQrU0Y3?=
 =?utf-8?B?YnU0R3BRWEpwTEJ6OWYydmhYWVIwcFZKTlNRajJ5UkdONGM3RjBlejNBYksx?=
 =?utf-8?B?N1Rwa3huOVdlbEtyTWNBUEZaT0htQnYvMmNYWlRjWGQyYThiNW9IVW1FVXNL?=
 =?utf-8?B?ZzJMQXJvUGJheHdxR05iYnRTbGRxZ0o4aHRzdFV1dk43dmE1cXpsVmJ2Ukh5?=
 =?utf-8?B?c21ORmVoeC84K2x6bmFyZ093VkhuUVVXeTNhazIzRXNzRDZKQ0FDOTNYYWI2?=
 =?utf-8?B?MFVSYjZSaXVzSy90ZTNDRXNyRUFZQ0J3T0lFaThMbmM4Wmtyd1hwQXk4VE00?=
 =?utf-8?B?NW9IclVNQU9HbzMwYnJtcmdkTVFublFDajkzQ2gybnJtRGlCSlN2LytDZFFv?=
 =?utf-8?B?RUFNWWo3TGJZK3FlVEdUZkJHNGFBWC9yb2dmK2FKbFZiS2pQT0tWbnREelZk?=
 =?utf-8?B?b0FaR3RJTDd2R0ZKcHB0YkJXZzVNeGpFUy9LUWlxS3J3dXlMZG9ua2lnZUk5?=
 =?utf-8?B?UmswM0U4eEgxamZjMHUrL21QKzVpaFBOOVNFZTJvVENWWHZ2WFpoN05rL0Yr?=
 =?utf-8?B?TXkydGRMU2NaL0o5S1NBMnZlQ2NZSDMzZVFoOUh1S20yZzducC9KTVpLZENT?=
 =?utf-8?B?SEw3OFhzOHI0alVmL0xoUXpvQnYyTXduVVczSkN2ZWFLeEpZNFRyaWczMjNi?=
 =?utf-8?B?ME1DL200RlZMN0NrM0ZURDd1ZVFtWG1WemYxa1hPR25mOTJIazZuVFNlTUpL?=
 =?utf-8?B?WHMxcnFWOWtsdmJMbWJ0anJUMVRPdWgzemtsQm42aTVSelVKUUR1eGtpTWw4?=
 =?utf-8?B?SXNuUVJWcHlVK21iZ05uV3lqdmgybjhKQmdHY3h5THhZTnZJL0NuQmxPTXJj?=
 =?utf-8?B?Rzc0bFVjOS9RQU1ncmZCNm5ZNEtCTGdnL2ZxRUxmYWo0YzdmcVQrR2NXaXl6?=
 =?utf-8?B?Z1V6QkFSZTNOTENISUc5UWdIYmppUDlWYXpDVTYvNTk5ZVBCSkVKeHdDNGpH?=
 =?utf-8?B?bG5YTXFvL3QwOVFaaVBiRnB3WVRJektIejJZL3NnSDhIZjFWQUNHVTgvQ3pk?=
 =?utf-8?B?R1UzeHRkWSs4cnZYbit3UVBTbjFQbm5UVVJKUXJVaUV3NFhZT0VBUHhWcU9C?=
 =?utf-8?B?STROUGZwa0t4S05JbVNoWHlwUzZmT3hKeklTY1RFYUp4L0lYSG5tR0U1aW0r?=
 =?utf-8?B?VUZCY0U0VSt0T1RFYkNFYzJzeE5pb24wUWF3citRdVpOclEvaGxYRUk2SU1U?=
 =?utf-8?B?bExiNjI5OWFLeFNsaHRQUnNralRvRjN3SEZ1d20yVmpkUGNKdnRDTEhtTEFs?=
 =?utf-8?B?bWR3Uk1SYUhkL2JLYWlzYVpNT3lwaHlhMUI1cVpJRzlOMWw4Zm15M2JjV3lu?=
 =?utf-8?B?cmJ0ajZiVU1GUkFIQ09jQm1sa2FGZndyaXpPdzdYUjhRWmlVZGdGVkdBSTMy?=
 =?utf-8?B?dEtseVJGUkFqdXpXSzdMajVEWm43OXlVdTRvaldNN3VZZ0NnOHAyOEZhUE5Q?=
 =?utf-8?B?VEp5VEFGekpEM1l6Vm9kS0RhNUQrNTVZajVOUjIzNUcvSEQ2Qm1QdlcyYWp2?=
 =?utf-8?Q?C4gI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7585.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822fb5c6-e243-41b2-9ee7-08dbceb930f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 02:31:38.8744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cmw4hXbW4bqWXoyImR05be6/dYW3GEGM+UVY/2ZeuLbSqgdSfGqlvfJRUtxEXIKuSxidN7XGXaiU06jXvlCsQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6736
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwNCg0KPiA+ICBzdHJ1Y3QgYnRfYmFwX3BhYyAqYnRfYmFwX2FkZF9wYWMoc3RydWN0
IGdhdHRfZGIgKmRiLCBjb25zdCBjaGFyICpuYW1lLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICB1aW50OF90IHR5cGUsIHVpbnQ4X3QgaWQsDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBidF9iYXBfcGFjX3FvcyAq
cW9zLA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
aW92ZWMgKmRhdGEsDQo+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHN0cnVjdCBpb3ZlYyAqbWV0YWRhdGEpOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgaW92ZWMgKm1ldGFkYXRhLA0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB1aW50MzJfdCBsb2NhdGlvbik7DQo+IA0KPiBJZiB5
b3UgY2hhbmdlIHRoZSBBUEkgeW91IHdpbGwgbmVlZCB0byBmaXggdGhlaXIgdXNlcnMgYXMgd2Vs
bCBvdGhlcndpc2UgaXQNCj4gd29uJ3QgYnVpbGQgYW5kIENJIHdpbGwgZmFpbC4NCg0KQWdyZWUu
IEkgYWxzbyBmb3VuZCBsYXRlciB0aGF0IGxvY2F0aW9uIGZpZWxkIGlzIGFscmVhZHkgcGFydCBv
ZiBxb3Mgc3RydWN0dXJlLiBJIHdvdWxkIHJlLXdvcmsgdG8gdXNlIHRoZSBzYW1lIGluc3RlYWQg
b2YgY2hhbmdpbmcgQVBJIGFuZCBzdWJtaXQgdjIgcGF0Y2hzZXQuDQo+IA0KPiA+ICBzdHJ1Y3Qg
YnRfYmFwX3BhY19vcHMgew0KPiA+ICAgICAgICAgaW50ICgqc2VsZWN0KShzdHJ1Y3QgYnRfYmFw
X3BhYyAqbHBhYywgc3RydWN0IGJ0X2JhcF9wYWMNCj4gPiAqcnBhYywNCj4gPiAtLQ0KPiA+IDIu
MzQuMQ0KPiANCj4gDQo+IA0KPiAtLQ0KPiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6DQoNClRoYW5r
cywNCktpcmFuDQoNCg==
