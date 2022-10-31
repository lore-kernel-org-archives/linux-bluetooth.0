Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3AC3ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 22:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJaWFI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 18:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiJaWFG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 18:05:06 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E3012625
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 15:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667253905; x=1698789905;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1UyJBh2UiiTzXbEOA6072NvZi3RuxUBXkOpEWLZ4Gp4=;
  b=SbvWG6fA7mweJ3f1VI+rCrrpxj2jWcXDTMIlHkYdQ0C4ULNSwKwbPCtf
   TbSDLFaNTkUcHJla5NKhyR1fEnyFI3ypuKN4TXcttvQNcHV37waaZJA9W
   cbRH0q+704xa054L5F4Pf1uNstXmGHlRFDGrr9q+OlZHT0DxlP29bJmSj
   UtHp0GSCKw1dur9J5lgaGQZ1BFsLq8MHfVjakpHE333Ouesq2omNCsmd5
   /z7g56EPO91p4aaHl2Nm8S/NMqJpdWFdJh5O39//GPRG5IjUa6C3RwNDv
   Y7kTdNriLidjWAFNp0RxPIaBLZtRBf5A9qG3EsXetahdiFWtOncvdREN0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310712426"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310712426"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 15:05:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="666982182"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="666982182"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 31 Oct 2022 15:05:05 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:05:04 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 31 Oct 2022 15:05:04 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 31 Oct 2022 15:05:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 31 Oct 2022 15:05:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVGtEFRAnAxwVgJb6yyY40sZZ+pqWB4sgVuzCD0sjbv7rYAPWA1Y3ztaDXfRF/dsDKgWoeDFEWzLGy8ht5HCFWRmSgm9PAu5tU9olLjd1t8h3iO8yYXvpSTSeEL/LEdPH//e6+Lrq5hS9f+BamkaNof+ZVLHBgpBxhbBV/JCRtLPVoYYvVOiaKaETQTRIOr9B23cAsbiexrb8XKMs2zaXpFeQ6iN8xpf0Dp8LeiGeatV8eATe8/Qqv0BtQdS9hHqIXLSM6VBEFT/EnfIi4eZYIaIRFkqkTX6VsKxecmaav+k6IEpw+OQIHa/aJNkCXH2NBCR2Yjxw6ArkuW6GjGdzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1UyJBh2UiiTzXbEOA6072NvZi3RuxUBXkOpEWLZ4Gp4=;
 b=eHjF6ZrirfVs5l4ue043kiKq11qEEqCyLC8UyrXvIad8rsDg3MbR6mfKSCeYHQhzW9NfFgmbPOTiEvygwPtef97FNjZZlF1R9RiAZ2NLrKVmiG8avy08y7e1RCtwY3KTwFGeZuuLr0uZkOwoBC3lsC3Ed7D6r6MrUWcWq7eNWbZn3M4z16wEQPS9U9SKuNvJ7hVWcQ1+/aTSI+4lLVbjMQ5Sy3hqS13iJq3vczAAR0hLsGR4UXzXdRBNarKtrFsfnQv8vJBiV3ghm2vBCXg7+fkdIMaCSJvWr/FeuJezATsPq/VgazJ3pCmGhYvT8D/htrhnbjLr3D6I9s8Mw0BNTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA0PR11MB4526.namprd11.prod.outlook.com (2603:10b6:806:96::15)
 by SJ2PR11MB7520.namprd11.prod.outlook.com (2603:10b6:a03:4c2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.16; Mon, 31 Oct
 2022 22:05:02 +0000
Received: from SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::18de:143c:207d:57fa]) by SA0PR11MB4526.namprd11.prod.outlook.com
 ([fe80::18de:143c:207d:57fa%5]) with mapi id 15.20.5769.019; Mon, 31 Oct 2022
 22:05:01 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "Vasut, Marek" <marex@denx.de>
Subject: Re: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Thread-Topic: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Thread-Index: AQHY7XR1tGR1PoJWs0+u/R5GlIi3Va4pDruA
Date:   Mon, 31 Oct 2022 22:05:01 +0000
Message-ID: <4e1c396b6f5929980fa26f02c285981fae751c4e.camel@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-2.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4526:EE_|SJ2PR11MB7520:EE_
x-ms-office365-filtering-correlation-id: d7aa1073-de6f-4dfb-6795-08dabb8bf571
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5VWPLB+g1bY6YoKDz/jP5le8yvWewPHwTvslPl5butzh7yb8FGo9S51Nhq1Dh9ugFE6zzuj374eOQ4Lt/KlQZ1GXme9X4AHx/M2AFHEeLUQ8UquchEB3EQSJlhNbC+YKJ0cgRRztXgdh+d6w5GTDqzrLojM1R5ShWkZKWABiWrANq1sps/QEhUwh9eTJ2Dq8/6xkctD2/geuQG3WZNDxuvgZf/32V0etzA4/9a300TXhAN1XlFln8SFVB71l3cNaXtNkkL0izm6GPc8rnk76coUDUylE6XsvB2FBiYuQr19+ipM6viJTXJB7xSsYsdvDHGWm6awZQAtZswXRTDcf1EAiQVIODZCdo3YSR0IDGT55YB0XKzcIwnKi+2UNCmz1iQDqjd284DG7sYEI3dzUI52IJtj9Lo/L8qlYKh+unhpGXYihDxDci7ovjexh5hm/RDDIaGRTqeNxL3zA2rw1sgPaw0A9UR6acXXLAKsbBq6lHTBVkHMPe1DzAY9a6ihQmqIjH8MMPH9KPHtou9mhCMrBlRqQtPLqIhpg7kKZgOdcCMEv++YM/cIAFS2CFhK9gNyHbfd10vs5FZcvNXdh+kM2xOW7E5RGMVtXl7En6fzwZrj3HPZjKtxGJjH6FId5sWxHnTLEqWF17ZrQT+z1Cg4PdmBVCIR407EIhubbx0Pi6yRtTVCpuowWX+F3oQI3fHWGdH+m/CD4nFNNRoRBc6Uq8MxAtD7Jfmafy1sivkvvwO83EtA2jPCD2bCxktZjVP17QoMa7qw4W02EwwG+Mg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4526.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(376002)(39860400002)(396003)(366004)(451199015)(316002)(6486002)(71200400001)(478600001)(8676002)(54906003)(66476007)(6916009)(66556008)(66946007)(91956017)(66446008)(4326008)(64756008)(76116006)(186003)(4001150100001)(2616005)(6512007)(2906002)(86362001)(5660300002)(41300700001)(26005)(36756003)(8936002)(83380400001)(38100700002)(122000001)(38070700005)(82960400001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjIyS2Y0QTJjbFBEL0ZxQVVJQnJWWWVUdmhXNGw2amVOOWphQWRnbmVlTUZs?=
 =?utf-8?B?UmlhQW84Z2lHeWhySS81Y1ZORjMycXd5Uk9JdktwcFU2YzRteWo4cTZPZnVP?=
 =?utf-8?B?RTNGQkwxaVhNT2gyWTliKzBtalJEWGpMVVRqcnVHcjJXWHZjZlJ6U3lBVitR?=
 =?utf-8?B?UzhjR1ErQytGdVE0dkxVOWRSL0wzV3RtdXdFdWRRR3dtOVRvNnJjaU9JbjBk?=
 =?utf-8?B?NmEwd2JybEM2TVJzUWJQT0UyenZwTWdiZXZkallGN1hTakM5QkZ2NWZjdjRv?=
 =?utf-8?B?eng1SXpHaVkxSG5wNW9EbHZnVzR6NW14QTUvUGFWZXJQeS9EeEJFSjN0NmZj?=
 =?utf-8?B?OUR2d3RMUUM4MXZKVUt0WUsybUcrVjQyditod3JEaWFTcGFlSW5zRVJzZXM0?=
 =?utf-8?B?TU5VeSsxN1pRVlRDT1BpSjM1Q0hwWFkzOFJqMUdKOEczMFhQbGFqSTNsQ2xs?=
 =?utf-8?B?WDAzZmtPVVBLNVV5K0l1bXI3bjdRbEFPbkR0Y1RjZTJZN3diNURPQW5pdWhZ?=
 =?utf-8?B?OWlTWm9LUTBlYmxHQ3JZcG1GVFMrbnVobVRYRWN2enptbjRvNmhHK0twRFNo?=
 =?utf-8?B?dStIWitLc1N2ai9nRnpNeUl4U1JobzloS3Q5ZUJsNmdhdVErOGtnS0dwY3pO?=
 =?utf-8?B?bkNBRW9INTZwaTMvRGVsOEZBQnpQRDN6VmN1TTZSdGZ2TkZ2d29zcXA0ZW1H?=
 =?utf-8?B?ZXhoOXlwa3NXVlZpM3ovc0xCOHluL3pheDRRbzkxZ1JnRStmaHhBdU9yUVM3?=
 =?utf-8?B?OHl0WVFrNGI5eWFEVUxwVWJINnpQYTZHUndDaEJDejJCd2kzN2hTTjNXY0w2?=
 =?utf-8?B?b3V1azEwd0prMCtOdUI3THlNU2diM0wxSzltL3FybkJ3ZU9Mbng4ZUx0RWlM?=
 =?utf-8?B?V0F6ZWFwVm9ZM0tsV1Y2ZkVKZUZ6dE9HWUVWcFpkOUhXbFVoMnIwQlU2Mkts?=
 =?utf-8?B?TVFmbTFtRWFnd1Y4TXpEd2szVWFzd0gvUTVNN3RxekhXcE1IUk5oRUFuOXRr?=
 =?utf-8?B?UC93c0wvUkZOOHRtNFF6ZnFoRHZWd1NWVGg2MlhxK3ZVSVZTaStmMFhMQlNH?=
 =?utf-8?B?RWtNeld0U2pFV2RvRm9sUVMybTZhZWQ5bytjY21xV3FMeFdhSVJ3Skc5WnJO?=
 =?utf-8?B?LzVvcG8wOFpROUcrNzAxU083RzI0U1pIdDIreGFnU0krUDhSOW5QMmRTV1dN?=
 =?utf-8?B?YzlmalR0UkduSU9DR3QxQng4bEkvWjN1MlZqRDBZelUwWTR4OWZLOFZLNkpk?=
 =?utf-8?B?VThnVGx6YnRZTU45eGh5UTJZNnpPM0lNb3RCeFlnSzIrVnF2YUhmNGFvSnlL?=
 =?utf-8?B?eDFyZUtQSVNhVzJLVzI2UDZNa1ZBOXlKQ3JWYnlBNkw1bE1vVGdrTmV2Tjhs?=
 =?utf-8?B?b05qZVhIUWFNOFgrQTVMRWZMKzBhUVMyWkFYZVV6OFNnNUgydVRudnBWbVVN?=
 =?utf-8?B?ZjlZb283TE5GV2JDWFpHMGw4MHZ0UjBJNmNkY1RmSWVRSENtcXJzTHkxY0xs?=
 =?utf-8?B?ZSs0cC9WcXc2VW5ZYmpUVnFWWFdZb3E1cEFoNzF2dGtsTHJzblRNaW5Hd24w?=
 =?utf-8?B?N0crYzMvQXBlZGJXZmRwN1ZocVJHV2V0dWdDc0YxM3F1Qlh6akZGNFRyOE5P?=
 =?utf-8?B?MGU0dW5SenVhZE4yQVhGNkdnR0V5Zy9udCs4NXp6Nlp0Z2o1djVEU1lUUW5p?=
 =?utf-8?B?Z0JTdUxHS1kzblVlUHcyVTl1RTEwWTFUK0FDdmxIM0lNMURFS3lLTTFDcVo4?=
 =?utf-8?B?RlJXVHBHN3gybkdHeVM4SXgxVVFGSzlPQjl6aThWc3FjTy9HYkFuM3BEd0gz?=
 =?utf-8?B?WU41aWFOSGNtRGdlU0MrcEg3V0xTWTJaSDJrVXJRQ1hycHpmY0hIRzVCL1dC?=
 =?utf-8?B?S3kyTGhVRUkycktDWU0rVk11QW8yQlBpR0ppWjc2dDZxNU02QkJ0R3JzTFdV?=
 =?utf-8?B?UFJwU3gyQmw5Tkd0VXd1K0hBWVlES2x0enpwRURVVzdKNUtXVVYxY0thUHI2?=
 =?utf-8?B?aEt5MUo0MkhzSEtTWTNpczloN21rMFdTVExmOTBMTnNCSUk2ZytkdTNVV01S?=
 =?utf-8?B?TS9ocXA3d2RIQ01XeStTZkIyR3c5WE5qRkZmdFRaeXFzU0xUMlVuMWxUYi94?=
 =?utf-8?B?a3drN1N3SHBLd0h2dEdGUGdDeW1ONkFzMVd6aU9tdUdkUm8zL3BZNTFWV0xT?=
 =?utf-8?B?WUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3798FB71869F7946B230BC53226A3608@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4526.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7aa1073-de6f-4dfb-6795-08dabb8bf571
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Oct 2022 22:05:01.8419
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLUnSgFDHnhlmGu3oKp+XAVehAtr2z2vCqs03IY8cY8gQznkgJTHCFVD8XrnJCq4kgjp1IDMn34cA6ZvrBbo2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7520
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWF0ZXVzeiwKClBsZWFzZSBub3RlIHRoYXQgdGhpcyBpcyBVTlRFU1RFRCwgaGVuY2UgdGhl
IFJGQyB0YWcuICBJIGRvbid0IGhhdmUgYW55CmNvZGUgdGhhdCBleGVyY2lzZXMgdGhpcyBwYXJ0
aWN1bGFyIHBhcnQgb2YgdGhlIGNvZGUsIGJ1dCBpZiBpdCB3b3JrcywKaXQgc2hvdWxkIHNvbHZl
IHlvdXI6CgogICAgICAgIEJsdWV0b290aDogaGNpMDogSENJX1JFUS0weGZjZjAKCmVycm9yLgoK
LS1CcmlhbgoKT24gTW9uLCAyMDIyLTEwLTMxIGF0IDE1OjAyIC0wNzAwLCBCcmlhbiBHaXggd3Jv
dGU6Cj4gVGhlIG1zZnRfc2V0X2ZpbHRlcl9lbmFibGUoKSBjb21tYW5kIHdhcyB1c2luZyB0aGUg
ZGVwcmVjYXRlZAo+IGhjaV9yZXF1ZXN0IG1lY2hhbmlzbSByYXRoZXIgdGhhbiBoY2lfc3luYy4g
VGhpcyBjYXVzZWQgdGhlIHdhcm5pbmcKPiBlcnJvcjoKPiBoY2kwOiBIQ0lfUkVRLTB4ZmNmMAo+
IAo+IFNpZ25lZC1vZmYtYnk6IEJyaWFuIEdpeCA8YnJpYW4uZ2l4QGludGVsLmNvbT4KPiAtLS0K
PiDCoG5ldC9ibHVldG9vdGgvbXNmdC5jIHwgMzYgKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMjUgZGVsZXRp
b25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL25ldC9ibHVldG9vdGgvbXNmdC5jIGIvbmV0L2JsdWV0
b290aC9tc2Z0LmMKPiBpbmRleCBiZWU2YTRjNjU2YmUuLmJmNWNlZTQ4OTE2YyAxMDA2NDQKPiAt
LS0gYS9uZXQvYmx1ZXRvb3RoL21zZnQuYwo+ICsrKyBiL25ldC9ibHVldG9vdGgvbXNmdC5jCj4g
QEAgLTc0MywxNyArNzQzLDEyIEBAIF9fdTY0IG1zZnRfZ2V0X2ZlYXR1cmVzKHN0cnVjdCBoY2lf
ZGV2ICpoZGV2KQo+IMKgfQo+IMKgCj4gwqBzdGF0aWMgdm9pZCBtc2Z0X2xlX3NldF9hZHZlcnRp
c2VtZW50X2ZpbHRlcl9lbmFibGVfY2Ioc3RydWN0Cj4gaGNpX2RldiAqaGRldiwKPiAtwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1OCBzdGF0dXMsIHUx
Ngo+IG9wY29kZSwKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzdHJ1Y3Qgc2tfYnVmZgo+ICpza2IpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdm9pZAo+ICp1c2VyX2RhdGEsCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTggc3RhdHVzKQo+IMKg
ewo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBtc2Z0X2NwX2xlX3NldF9hZHZlcnRpc2VtZW50X2Zp
bHRlcl9lbmFibGUgKmNwOwo+IC3CoMKgwqDCoMKgwqDCoHN0cnVjdCBtc2Z0X3JwX2xlX3NldF9h
ZHZlcnRpc2VtZW50X2ZpbHRlcl9lbmFibGUgKnJwOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBt
c2Z0X2NwX2xlX3NldF9hZHZlcnRpc2VtZW50X2ZpbHRlcl9lbmFibGUgKmNwID0KPiB1c2VyX2Rh
dGE7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBtc2Z0X2RhdGEgKm1zZnQgPSBoZGV2LT5tc2Z0
X2RhdGE7Cj4gwqAKPiAtwqDCoMKgwqDCoMKgwqBycCA9IChzdHJ1Y3QgbXNmdF9ycF9sZV9zZXRf
YWR2ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxlCj4gKilza2ItPmRhdGE7Cj4gLcKgwqDCoMKgwqDC
oMKgaWYgKHNrYi0+bGVuIDwgc2l6ZW9mKCpycCkpCj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoHJldHVybjsKPiAtCj4gwqDCoMKgwqDCoMKgwqDCoC8qIEVycm9yIDB4MEMgd291bGQg
YmUgcmV0dXJuZWQgaWYgdGhlIGZpbHRlciBlbmFibGVkIHN0YXR1cwo+IGlzCj4gwqDCoMKgwqDC
oMKgwqDCoCAqIGFscmVhZHkgc2V0IHRvIHdoYXRldmVyIHdlIHdlcmUgdHJ5aW5nIHRvIHNldC4K
PiDCoMKgwqDCoMKgwqDCoMKgICogQWx0aG91Z2ggdGhlIGRlZmF1bHQgc3RhdGUgc2hvdWxkIGJl
IGRpc2FibGVkLCBzb21lCj4gY29udHJvbGxlciBzZXQKPiBAQCAtNzY2LDcgKzc2MSw2IEBAIHN0
YXRpYyB2b2lkCj4gbXNmdF9sZV9zZXRfYWR2ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxlX2NiKHN0
cnVjdCBoY2lfZGV2ICpoZGV2LAo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoGhjaV9kZXZfbG9jayho
ZGV2KTsKPiDCoAo+IC3CoMKgwqDCoMKgwqDCoGNwID0gaGNpX3NlbnRfY21kX2RhdGEoaGRldiwg
aGRldi0+bXNmdF9vcGNvZGUpOwo+IMKgwqDCoMKgwqDCoMKgwqBtc2Z0LT5maWx0ZXJfZW5hYmxl
ZCA9IGNwLT5lbmFibGU7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHN0YXR1cyA9PSAweDBD
KQo+IEBAIC04MDQsMzEgKzc5OCwyMyBAQCBpbnQgbXNmdF9yZW1vdmVfbW9uaXRvcihzdHJ1Y3Qg
aGNpX2RldiAqaGRldiwKPiBzdHJ1Y3QgYWR2X21vbml0b3IgKm1vbml0b3IpCj4gwqDCoMKgwqDC
oMKgwqDCoHJldHVybiBtc2Z0X3JlbW92ZV9tb25pdG9yX3N5bmMoaGRldiwgbW9uaXRvcik7Cj4g
wqB9Cj4gwqAKPiAtdm9pZCBtc2Z0X3JlcV9hZGRfc2V0X2ZpbHRlcl9lbmFibGUoc3RydWN0IGhj
aV9yZXF1ZXN0ICpyZXEsIGJvb2wKPiBlbmFibGUpCj4gLXsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1
Y3QgaGNpX2RldiAqaGRldiA9IHJlcS0+aGRldjsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgbXNm
dF9jcF9sZV9zZXRfYWR2ZXJ0aXNlbWVudF9maWx0ZXJfZW5hYmxlIGNwOwo+IC0KPiAtwqDCoMKg
wqDCoMKgwqBjcC5zdWJfb3Bjb2RlID0gTVNGVF9PUF9MRV9TRVRfQURWRVJUSVNFTUVOVF9GSUxU
RVJfRU5BQkxFOwo+IC3CoMKgwqDCoMKgwqDCoGNwLmVuYWJsZSA9IGVuYWJsZTsKPiAtCj4gLcKg
wqDCoMKgwqDCoMKgaGNpX3JlcV9hZGQocmVxLCBoZGV2LT5tc2Z0X29wY29kZSwgc2l6ZW9mKGNw
KSwgJmNwKTsKPiAtfQo+IC0KPiDCoGludCBtc2Z0X3NldF9maWx0ZXJfZW5hYmxlKHN0cnVjdCBo
Y2lfZGV2ICpoZGV2LCBib29sIGVuYWJsZSkKPiDCoHsKPiAtwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qg
aGNpX3JlcXVlc3QgcmVxOwo+ICvCoMKgwqDCoMKgwqDCoHN0cnVjdCBtc2Z0X2NwX2xlX3NldF9h
ZHZlcnRpc2VtZW50X2ZpbHRlcl9lbmFibGUgY3A7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBt
c2Z0X2RhdGEgKm1zZnQgPSBoZGV2LT5tc2Z0X2RhdGE7Cj4gwqDCoMKgwqDCoMKgwqDCoGludCBl
cnI7Cj4gwqAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKCFtc2Z0KQo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FT1BOT1RTVVBQOwo+IMKgCj4gLcKgwqDCoMKgwqDCoMKg
aGNpX3JlcV9pbml0KCZyZXEsIGhkZXYpOwo+IC3CoMKgwqDCoMKgwqDCoG1zZnRfcmVxX2FkZF9z
ZXRfZmlsdGVyX2VuYWJsZSgmcmVxLCBlbmFibGUpOwo+IC3CoMKgwqDCoMKgwqDCoGVyciA9IGhj
aV9yZXFfcnVuX3NrYigmcmVxLAo+IG1zZnRfbGVfc2V0X2FkdmVydGlzZW1lbnRfZmlsdGVyX2Vu
YWJsZV9jYik7Cj4gK8KgwqDCoMKgwqDCoMKgY3Auc3ViX29wY29kZSA9IE1TRlRfT1BfTEVfU0VU
X0FEVkVSVElTRU1FTlRfRklMVEVSX0VOQUJMRTsKPiArwqDCoMKgwqDCoMKgwqBjcC5lbmFibGUg
PSBlbmFibGU7Cj4gK8KgwqDCoMKgwqDCoMKgZXJyID0gX19oY2lfY21kX3N5bmNfc3RhdHVzKGhk
ZXYsIGhkZXYtPm1zZnRfb3Bjb2RlLAo+IHNpemVvZihjcCksICZjcCwKPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
SENJX0NNRF9USU1FT1VUKTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgbXNmdF9sZV9zZXRfYWR2ZXJ0
aXNlbWVudF9maWx0ZXJfZW5hYmxlX2NiKGhkZXYsICZjcCwgZXJyKTsKPiDCoAo+IC3CoMKgwqDC
oMKgwqDCoHJldHVybiBlcnI7Cj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIDA7Cj4gwqB9Cj4gwqAK
PiDCoGJvb2wgbXNmdF9jdXJ2ZV92YWxpZGl0eShzdHJ1Y3QgaGNpX2RldiAqaGRldikKCg==
