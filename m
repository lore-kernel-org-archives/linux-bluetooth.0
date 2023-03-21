Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD249C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Mar 2023 03:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjCUD27 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 Mar 2023 23:28:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjCUD2y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 Mar 2023 23:28:54 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F340024C95
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Mar 2023 20:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679369332; x=1710905332;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CqaqhtfjbSManX4lejCOMsvEKg7Mld9g0p1QZ9T8qfE=;
  b=Tx6taLK+TwuK9lNpJCqmuKoH96cPPo6yAPhXIjrT1DhM/o7A4u1EHBdy
   FvtDv26ugWEA7c2sUmyZ/5lG4r3xUt9eSto37hBUGLnf7kSEfuQCsmnp8
   r4mNLsjzpmOFtD7LNOzTNkyfhMX5qWoz57FnM696keEwfaFP/GL9T/lJ9
   ELupyLzp7ejmNFe28gV67XC9N6p84ebx4FK75CbKpSiukTD43ckXesh0o
   mw6/GiVI1N/gtSTfaEh1EdE48ARrNIp6cFt3vhzN3NvKVI/8gOrKwYFLO
   4g5x1Uuf1U8OkYh7y5UukTIf5d8H2YH3UtDuxjfCX6D5HkIb1lOdQUd5D
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="341196817"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="341196817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 20:28:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10655"; a="824749360"
X-IronPort-AV: E=Sophos;i="5.98,277,1673942400"; 
   d="scan'208";a="824749360"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 20 Mar 2023 20:28:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 20:28:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 20 Mar 2023 20:28:51 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 20 Mar 2023 20:28:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 20 Mar 2023 20:28:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYaNP7dorXtMp6Y5VwqCKqPz1kKaRkVZk326kbbtg8xMJvFE4I3X3KgRQMT+RF9+Y2vjpgGYD5e5gs/v4V044rgB+rkvQ21oG1O2Tt6TCgAcuHZFTacJ7Qn1olZSh660cEAgBmo61LfXSBpTTa7qB+fTUkD4k3MXW6WumBm73MtvCHpqDaBiJYwr4N6KlOT1VCOvzZacl/CtlZ/eSy5d5xhdGM8zNW6QNLQu9QIu6vvB+sT+N2lBv1o3GOYUnVR2NQy4lI/qHKBvleIS1q+v4mfYp+ub640PAKaxh75CiUQavqpVZLx9RY+J284s0Vdgyt0/pXKXmKvTUc9e6857xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqaqhtfjbSManX4lejCOMsvEKg7Mld9g0p1QZ9T8qfE=;
 b=T/QOi64oYysw7ge9I91Y43LHvrb9U6bFA09Fe/JHsO7ZPqNR2W6zn4wCq0YUgL152BcM+Fz2SLvU5LO4Q0J4rP+/dIS4qL/gXiYGM7tXsCnSNwS+r9VTel6H/3nymFiN6/9bSAAeGC7Cc2iEXbcQPiCTuDkYgWiFWlAL6dx0nmUvvb5sMSFv4sgmR+zG0Mk7rrc6qT2E8dPZNPHlOIVHgni79HBLp3w8U0Ki32v0kIcrWFLzVB/Rcl0PYgIZJ/B4y8WqY2AAt++iLHQfrEHitBLezdm0QPDhzdRzEy5RO5NP9Nx52oPKFN33oxXHhMXrcdCgq8KyWYsWbr3T+6rZQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5901.namprd11.prod.outlook.com (2603:10b6:510:143::11)
 by IA1PR11MB7365.namprd11.prod.outlook.com (2603:10b6:208:423::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Tue, 21 Mar
 2023 03:28:47 +0000
Received: from PH0PR11MB5901.namprd11.prod.outlook.com
 ([fe80::a925:603a:18a3:44b8]) by PH0PR11MB5901.namprd11.prod.outlook.com
 ([fe80::a925:603a:18a3:44b8%3]) with mapi id 15.20.6178.037; Tue, 21 Mar 2023
 03:28:47 +0000
From:   "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar
 onwards
Thread-Topic: [PATCH] Bluetooth: btintel: Fix: Add LE States quirk form Solar
 onwards
Thread-Index: AQHZWvOFl+FtZ8TIMUS0O/rqpp9HpK8DpMIAgADvwTA=
Date:   Tue, 21 Mar 2023 03:28:47 +0000
Message-ID: <PH0PR11MB5901AAC6A9B3E53B6DECC5C5D8819@PH0PR11MB5901.namprd11.prod.outlook.com>
References: <20230320061813.69895-1-chethan.tumkur.narayan@intel.com>
 <0c579450-b7bd-dd80-c77b-e5471c30aaa9@molgen.mpg.de>
In-Reply-To: <0c579450-b7bd-dd80-c77b-e5471c30aaa9@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5901:EE_|IA1PR11MB7365:EE_
x-ms-office365-filtering-correlation-id: 456973bb-da05-4b1c-589f-08db29bc61cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jeF7+V5f5f9f+rm/Z6mII573WXTZthwG+PJtfGzL2DmylV9f6Y7tS990N422FbFNij3EuFv/+MOsZvfeSanYGvLmyN5WWuBL1wjRP5Qg/AxlBK/fgXz0RQIVcsucoVK1PQidrda6z0h8pWiY+5YTbikz/9dP/5M+uXsG5uw3P4t3CIRejIUoXsxn+vavXmGgDlxg2IytW2PuTlCaMQ2GtUvR+fnH3aSQY8+w8oU0jmfT8R8MuxiiNa74jwWpNJOU3iGzVbwdTLwgrJ60wmTuKsKXeM3wQ5GriT8zCJ8Ns83ilxAnme9FT1+e4vEQxNHObI4EYRNELcrfA1rb1Qbbi405+rHnpqpiwKZQ0AtiDn5YXGVDWf9kKRPqToUjuVY4LEPvTQtMuALcRGYPRPu5SJBtu8t2Cfay/91sSm6ksX42S2Eq6uvhdkND3u0yL+liQdJ22LlrNC6q4AeA4ItkjGIgeUnVues4+z7pzDiKMDDY22w4rIwdpfBNsPPvd9nyD/6mZk8VDphoFNyqof4Hka284bu7Hz9VK0Ivy1BSffVDblXR3moJKIxqTytAWYZqlwp47pv7HB9nNSCn5YAaynGh28g5Dpvmc0/UE+FxiMd/t/5LmQl5Kfar3ZK+vuglAHK0isHJFZj7VKV06bJ2diJzVmhepl7nexwO9wh5rM7019YXev0MXkNV5O1zvznsxm/RqX82vdRurtNN/C3+gg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5901.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199018)(2906002)(55016003)(83380400001)(9686003)(52536014)(8936002)(6506007)(5660300002)(53546011)(82960400001)(86362001)(41300700001)(26005)(7696005)(186003)(316002)(33656002)(54906003)(76116006)(478600001)(66446008)(66556008)(38070700005)(66476007)(64756008)(71200400001)(122000001)(66946007)(38100700002)(4326008)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmE0NXdsYmRGbUk1clRkemxxNnFFTXBUSG9vaWVCYVFqZWtnYzR3d2d4MG5R?=
 =?utf-8?B?Z2JFQlBwcE1IOUhpa1dWMEtuNUxmcXV2UEFsd0RsYUNtdXAwMDROQ1hBaHMz?=
 =?utf-8?B?ZmwvQ1FoL09menFRMFU5a2orRnU1cDdVTUZ2bnJJdUY3OFZqdm5vbHk4ekN6?=
 =?utf-8?B?SXRaeUQ4dzNyc0ZpOE5jUUpVRW45d21ZaGN4Yk9DeDVFOGZGb1l0MDFQYU5C?=
 =?utf-8?B?a3YxUVNxSTQ1bnlURmdMRXhLUHMwTk1ISExZYzZzeEZwMWYydXRGbGUvWEtS?=
 =?utf-8?B?aTZiT05pb3Zya3B0OGNNZDFzam9JbjNmSWlqemtGVnV3Z2wwazVmSDlyNy9v?=
 =?utf-8?B?SzFQTytnb3NRMnFXVUpXM2RTQ2pFOUNCOHozMCtmb2lkM3NUYW5EZUppUFpQ?=
 =?utf-8?B?TU9CMjlhNTRSTzVYb016ZlZzd2Q5aFFmaUJ5T2FUcFI0TzljTmdtaVhoYStY?=
 =?utf-8?B?Si84V1hsUnFBT1JYRFhtVkFYMmo5TnRITFlYWjFiMS8vMUpKY2JxZURjRldT?=
 =?utf-8?B?cytLZUZMRG1Ec2VUUzZtNVorUXNPYXFLUytlMklXMmpRbWhNTnNIb21QQm9Z?=
 =?utf-8?B?aURXUUtudVM1bWdtbUR3Z2IvR2NSdWJsU3BqUGd4MWJjNitlbzhuYnNabDB2?=
 =?utf-8?B?Q2NyandiQzZYTnZGZjFjbFpvT2dmL1VOWDdiQnpKVTh5SXp0Vk5UcXNQbHgr?=
 =?utf-8?B?Q1RFQWR4Qm1WTWZUV3NNSmd0WmZqYlFJM3VuRDQrV0lyenJidVNKcW9QSmtr?=
 =?utf-8?B?NmxuT0FkZms3R1Rrd0s4MDNRRnZ1QjhDa2U1ZllTUElvakgxQXAzUXJzcW5V?=
 =?utf-8?B?NzVFUUtrRFFLR2psY2hzazZnUWQ0ekV6TjN3bWR0M0hPR0lXR0FtZHJXQWEz?=
 =?utf-8?B?QWUraWcxUHpVdlZsNTVheWU4VFNZK0M2Q05xeGhXQjlyS0NtcW84MUNWRWFo?=
 =?utf-8?B?dXN1aEE4cjJ3RGVTTlpZekFDUE05NEFEZkNnVE5PRkZmTUNKTU94a0JnN3hO?=
 =?utf-8?B?OHRSZlJ4Um9UVWkvVEswVUVoWmN5RFF1d3Fxd1RQazM4ZksvOC9OVDZKNWMy?=
 =?utf-8?B?OW1oNHdIYVY3MmVSV3FMUUl5aHExeVFLRFZjbGlONHFleWl5YUtxSlRJbUZW?=
 =?utf-8?B?dWFUS0VKeFA3VE95N012V0Y2N256eHRvdkw3RDVSTmdWU3VIUjhmOGFkTDAx?=
 =?utf-8?B?elZCTXFGQmFOVGJnWlRtNElwRXZjbS9qMUhud1hldHhTTFlBaGR1MG5VMEJU?=
 =?utf-8?B?UFA4R25lWHZ1YW9jeHBBWUppb091bGdUQ3F6TFZOZGhkTk9QaFVqUG9HbHFR?=
 =?utf-8?B?anpneHh0NkU1MUhiSFdRMFB3N21JTXNIVzFIOWVaekhiUk5hSTR4WnBvb0RQ?=
 =?utf-8?B?OGNDdk42UWVHYnBuZGY1RmhBNmdMaVdPSXBvUk5nZ3pZWXlsczV4Z2pZWTN2?=
 =?utf-8?B?RVJLR0hub3A0S0xJcGVUZG1odXRRQlRGdTlWNVhDbG1aSmtPdG1GMmZxMnll?=
 =?utf-8?B?eWtOMFl5amJoVEhWT21UV2JHMGpnSUk3RkVyS0xuOTJmQWlGMGJ0WUNrY09r?=
 =?utf-8?B?enk0RCt6N2ZTMnFBYUJyZUhIYzM0TFFQdjNMRjVIQzc0TGRnOGZBUFR3MTBJ?=
 =?utf-8?B?R3Z6WGJ6K2FXV0Jzd0RjVUdRdkt6ZEYwVlhHRlpqTjFZdlFWWCtsRG56L0xH?=
 =?utf-8?B?VWNsTkZHWmlKbnd6Z1A5UG82RklmN1FOVktyYmdJWW42aUZhUVV2cktkL1Bi?=
 =?utf-8?B?SlpFdjRPaWhLZmhOU1NRMFRlY25TN2lMZ1ljdEZKM2RrcjdzaHBvTkxvaU9i?=
 =?utf-8?B?N3FORW1INi9BakVRR05GY0xxUDlhRkVPRHBNWWFYMHFhZTlVRG0zU01tc0Q5?=
 =?utf-8?B?MTkramp5emJKUkpydjI2T29wSDBzbVA0aDRHL3hHS0tyRlhEM2J0L0xtWEpu?=
 =?utf-8?B?SVowYXRoSUtxTm5ETWpQdXc1OUtybm8yUHhjQStXUVVSeVpVY1RqaHl6N0o3?=
 =?utf-8?B?d0E4dW5jVklDb1JXTllNYkFQUms3a29mVTY0Wm5nNFN4dlVQeGJXR2RWL0t5?=
 =?utf-8?B?YzJYcXRJeXJkTTZOWGVEOXpKUDRscFpOUllwb0xBRXJPQmFHNEtxWFd0V0di?=
 =?utf-8?B?RVkwQk4wKzliWkthbmYraG8vNlhpY09KRER2VVJWS2Y4RHFlT0ZnNVVVTjJn?=
 =?utf-8?B?RkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5901.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 456973bb-da05-4b1c-589f-08db29bc61cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 03:28:47.4338
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hGz+biF0Vxo6WDg8uAIts9WttqOcPMdQ07TIVIdErkFajdKLzcJk27BzHvbHL5zhCBQjzPKcidMlykvCts5tHhM70w6hV7tFtHb7/yjfqLl2I0N8+wSlzibi7kDXEaSx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7365
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhhbmtzIGZvciB0aGUgZmVlZGJhY2ssIHdpbGwgc2VuZCB0aGUgdXBkYXRlZCBwYXRjaC4NCg0K
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBQYXVsIE1lbnplbCA8cG1lbnpl
bEBtb2xnZW4ubXBnLmRlPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDIwLCAyMDIzIDY6NDAgUE0N
Cj4gVG86IFR1bWt1ciBOYXJheWFuLCBDaGV0aGFuIDxjaGV0aGFuLnR1bWt1ci5uYXJheWFuQGlu
dGVsLmNvbT4NCj4gQ2M6IFNyaXZhdHNhLCBSYXZpc2hhbmthciA8cmF2aXNoYW5rYXIuc3JpdmF0
c2FAaW50ZWwuY29tPjsgSywgS2lyYW4NCj4gPGtpcmFuLmtAaW50ZWwuY29tPjsgbGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBCbHVldG9vdGg6
IGJ0aW50ZWw6IEZpeDogQWRkIExFIFN0YXRlcyBxdWlyayBmb3JtIFNvbGFyDQo+IG9ud2FyZHMN
Cj4gDQo+IERlYXIgQ2hldGhhbiwNCj4gDQo+IA0KPiBUaGFuayB5b3UgZm9yIHlvdXIgcGF0Y2gu
IFRoZXJlIGlzIGEgc21hbGwgdHlwbyBpbiB0aGUgc3VtbWFyeS90aXRsZToNCj4gcy9mb3JtL2Zy
b20vDQo+IA0KPiBBbSAyMC4wMy4yMyB1bSAwNzoxOCBzY2hyaWViIENoZXRoYW4gVCBOOg0KPiA+
IFRoaXMgcGF0Y2ggc2hhbGwgZW5hYmxlIHRoZSBMRSBTdGF0ZXMgcXVpcmtzIGJ5IGRlZmF1bHQg
b24gYWxsDQo+IA0KPiBzL3NoYWxsIGVuYWJsZS9lbmFibGVzLw0KPiANCj4gPiBJbnRlbCBjb250
cm9sbGVyIGZyb20gU29sYXIgcHJvZHVjdHMgb24gd2FyZHMuDQo+IA0KPiBvbndhcmRzDQo+IA0K
PiBXaGVyZSBpcyBpdCBkb2N1bWVudGVkLCB0byBlbmFibGUgdGhhdCBxdWlyayBmb3IgYWxsPw0K
PiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBDaGV0aGFuIFQgTiA8Y2hldGhhbi50dW1rdXIubmFyYXlh
bkBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2JsdWV0b290aC9idGludGVsLmMg
fCA1ICsrLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwu
YyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IGluZGV4IGFmNzc0Njg4ZjFjMC4u
N2E2ZGMwNTU1M2YxIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwu
Yw0KPiA+ICsrKyBiL2RyaXZlcnMvYmx1ZXRvb3RoL2J0aW50ZWwuYw0KPiA+IEBAIC0yNjg0LDkg
KzI2ODQsOCBAQCBzdGF0aWMgaW50IGJ0aW50ZWxfc2V0dXBfY29tYmluZWQoc3RydWN0IGhjaV9k
ZXYNCj4gKmhkZXYpDQo+ID4gICAJCSAqLw0KPiA+ICAgCQlzZXRfYml0KEhDSV9RVUlSS19XSURF
QkFORF9TUEVFQ0hfU1VQUE9SVEVELA0KPiAmaGRldi0+cXVpcmtzKTsNCj4gPg0KPiA+IC0JCS8q
IFZhbGlkIExFIFN0YXRlcyBxdWlyayBmb3IgR2ZQICovDQo+ID4gLQkJaWYgKElOVEVMX0hXX1ZB
UklBTlQodmVyX3Rsdi5jbnZpX2J0KSA9PSAweDE4KQ0KPiA+IC0JCQlzZXRfYml0KEhDSV9RVUlS
S19WQUxJRF9MRV9TVEFURVMsICZoZGV2LQ0KPiA+cXVpcmtzKTsNCj4gPiArCQkvKiBBcHBseSBM
RSBTdGF0ZXMgcXVpcmsgZnJvbSBzb2xhciBvbndhcmRzICovDQo+ID4gKwkJc2V0X2JpdChIQ0lf
UVVJUktfVkFMSURfTEVfU1RBVEVTLCAmaGRldi0+cXVpcmtzKTsNCj4gDQo+ICBGcm9tIHRoZSBk
aWZmIGl0IGlzIHVuY2xlYXIsIGlmIFNvbGFyIGlzIHRoZSBmaXJzdCDigJxkZXZpY2XigJ0uIFNv
IEnigJlkIGJlIG5pY2UgaWYgeW91DQo+IGVsYWJvcmF0ZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdl
Lg0KPiANCj4gPg0KPiA+ICAgCQkvKiBTZXR1cCBNU0ZUIEV4dGVuc2lvbiBzdXBwb3J0ICovDQo+
ID4gICAJCWJ0aW50ZWxfc2V0X21zZnRfb3Bjb2RlKGhkZXYsDQo+IA0KPiANCj4gS2luZCByZWdh
cmRzLA0KPiANCj4gUGF1bA0K
