Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B4EC4708E
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Dec 2022 15:57:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbiL2P54 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Dec 2022 10:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233698AbiL2P5r (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Dec 2022 10:57:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D0AD2FF
        for <linux-bluetooth@vger.kernel.org>; Thu, 29 Dec 2022 07:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672329466; x=1703865466;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5A+WWq5D4lrWMoCT+ZMsjo7r3Lk1KMzwlkea2SbM3gE=;
  b=eu5lGWluPsGMVG89IKDmgtasv5sA7UmblN7QmKya0p9eOVABjAdKKvPQ
   N3ILrJpnj0a+ztB6fZlXN9MF8I6+JXzNDqIYRrQINX8iYBPSclHL8M5/i
   eRsH18qr3hDphYeoIiZ5ezYt/bogbxilIjwldOCTX9TR5VPX8hEBc1e1j
   XZ5utkM+Xj263p+NkaIe74h/tsVN3jWubjrtNqEjn99SNI/mqmdcoLbHK
   /uATbgXhpHGQPexkSFQljeHhoBngKk5IourD89KlYo+QiVR1ljJSz4QNw
   XP24p19yKiGSupWSBnDxB4lZsJds6HbwGUEUCNeAtw7900gbDc8/KOHZr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="323046740"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="323046740"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2022 07:57:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10575"; a="898996628"
X-IronPort-AV: E=Sophos;i="5.96,284,1665471600"; 
   d="scan'208";a="898996628"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 29 Dec 2022 07:57:45 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 07:57:45 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 29 Dec 2022 07:57:44 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 29 Dec 2022 07:57:44 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.106)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 29 Dec 2022 07:57:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=St/lt3OsQ64GQ7sdzzx0JMM6uo4aWxwgV7IvFMo9248t59JAkRjNtr0wo0Nc+ZE4RRixFIZPZLp67/VPmWAshQt7U3kVWT0iQmb/vnSZvnoFDoClbNz1E8q1ux+qMb3UCmp/oYFlp1nQpyrp0nDN9XQZ+ySujQx4xCw7/qauHHNF6ci9il5W20AArxxQMPOutx+n1Z9cnCCqUwamV4Ms6h3WK+ftYHgBhah1/vEDYQIGlTdUb0PUNQ8YjZmh1xezo94te7UeFzB1m3SlpM9CLBTuGqOAuzOwVocV5SVIQ41oVcMvWl5NBqi3Lb+londXUaWMV9wmrefUwCbMGRpBkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A+WWq5D4lrWMoCT+ZMsjo7r3Lk1KMzwlkea2SbM3gE=;
 b=lwAUYTvHXyIdRsQ0mz51T48CUrDJZMaAHyuSmvAHL4J35V1bnsFG9zX2WdwtVIzVfGzmuoxol60/TkwtFF1T8/J2eyjnvAZZJ5Eoz2cAjkfq9hV4I/DFQgCo7Z1PvaTkqI2YqYFECYZgbYF5GRWJamCH0VW2tngFStYKxO1h/nISWTdAWUy/OTVqBLz9NpNDoZ38pnzjQFg+6CjPFyFD3LThRrEoGs44TDA94RNkEpbEOgjutF6H+1j8m/TWUHyeWQqBzy2q+HUbuidemJBxGf5DcfMYuvbfDJ6R0BWBCJ1bGLkWyUuDK1PFHPr5BlgyOkMS5Tm/9l8paeilK7yjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BYAPR11MB3495.namprd11.prod.outlook.com (2603:10b6:a03:8a::14)
 by SA1PR11MB5948.namprd11.prod.outlook.com (2603:10b6:806:23c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Thu, 29 Dec
 2022 15:57:41 +0000
Received: from BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::9a46:6994:1603:2a2d]) by BYAPR11MB3495.namprd11.prod.outlook.com
 ([fe80::9a46:6994:1603:2a2d%6]) with mapi id 15.20.5944.016; Thu, 29 Dec 2022
 15:57:41 +0000
From:   "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
CC:     Abhay Maheta <mabhay125@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Maheta, Abhay" <abhay.maheshbhai.maheta@intel.com>
Subject: RE: [PATCH BlueZ v2 0/6] To add support for Metadata, CID, VID
Thread-Topic: [PATCH BlueZ v2 0/6] To add support for Metadata, CID, VID
Thread-Index: AQHZG354T00U527ffU2LZhOqfcFBbK6EyV+AgAA7//A=
Date:   Thu, 29 Dec 2022 15:57:41 +0000
Message-ID: <BYAPR11MB3495A609CE824C934B6A16DBB0F39@BYAPR11MB3495.namprd11.prod.outlook.com>
References: <20221229122821.340073-1-abhay.maheshbhai.maheta@intel.com>
 <20aebdae-8780-40c0-ae6c-3a67fe46cb60@molgen.mpg.de>
In-Reply-To: <20aebdae-8780-40c0-ae6c-3a67fe46cb60@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB3495:EE_|SA1PR11MB5948:EE_
x-ms-office365-filtering-correlation-id: 578ae566-b23b-4749-a1ee-08dae9b56ac3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qFd2r5FG0QenGHay/Qy1ZeX4xEnJ+o4m6kgDqbWkOGClsZd9NGQX9XOhRleT0cxYmqvMmzTQXzk9H7X7NkS68oz8OoGxPOargHvxVYbOdzkd83fLEOesayCi1U5nX2eDFF2jJmDbSgxp44IHJnjEPqU3gvI5EEuIF5pNzAf03BmzrqNOjrTY0qfwq1qzk5Scf2pgZvUBuyeKE5vy7OMHmzMExD6HOY8arLj1y8n76mvlVN6pevko+6hhFZNCIeq4ZYWTdAht3G4ZVCsrfqFU3gUW+KGq51v1GtHR35ENMKroY15zuIUfk/2U/gKfgch0ZLUcexT1tEaCROFM4oCMrc1gH+702b+o0v2LLXzNO82nRbTkKxUNjXIWMbSVP+msVKwReAPLjNZC9OcrMjtFogRxH0ufOkukmN6Svo94P7z+j27+sx6cMNFyLdF1txbOAE/ZLP4oKdqvoj2H2XV2ykPgI7pPwdO+wuLp9KDrn9lfhY9a8B6GA6TSz3vWO/aoqJQ/Br8+Sm/5wtBIkpXLg2+3YfhizOWSEQ5NqYzEmu0oCJL55UfTljbpcuHx37DtFckJOZJzU/bfL1EzOKYRfqc21klh+8j0YDsCpcIUXpalryHZN1pEH6+t6bO0AnmIfoe9phWQ/XMD8iIZxG2qI1jSa4IUEmXAvjahCHDTBHQnRNacJJ28V9zoiwA2ete/hD5mua9UTfA47q+SflCePg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3495.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(136003)(376002)(39860400002)(396003)(451199015)(122000001)(55016003)(41300700001)(5660300002)(4744005)(52536014)(8936002)(4326008)(76116006)(64756008)(66476007)(66446008)(66556008)(86362001)(33656002)(2906002)(66946007)(8676002)(54906003)(6916009)(316002)(6506007)(82960400001)(38100700002)(71200400001)(38070700005)(7696005)(478600001)(83380400001)(53546011)(107886003)(9686003)(186003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VS9pMFYvUXgzOTRmL2Y4N3pQa052SDExVWxreklWNExqN29qWDB5WWUrOFVN?=
 =?utf-8?B?SWxBOXljVEg2QUNhV3ZqckpiNFdwT0JxWmtlcFdwWUorTE5WSmVjYUNlbnl3?=
 =?utf-8?B?UHZCeFk2MmZIb0NZNld0ZzlnRkFZMUtua2xRK0RQdE0wVWMzajA5VCt5cTY5?=
 =?utf-8?B?cnQwZ3BiandTQWxSQTVXdG5LOWtmWi9kM2JZRjdRbGx2VjRaWXRWaGRVODd6?=
 =?utf-8?B?Y0cvK3BpSHNNS20wQ051eXU1aUtJbzRlZjJhcDRpT253VUFYSytJQklkamtz?=
 =?utf-8?B?TGNoVjMwNlZtRzd1R3FXZHBjUUpDT1lWU0FTWW9oakszUkVIYmpOR3NteUxn?=
 =?utf-8?B?NzlOK09xQXAvck9uQkpEdGc5RXY3bWkya3h0RERscGQ5MGJ1eUkwSlZJeGV2?=
 =?utf-8?B?akY0dmRPWlkyRzFTSWc2bTgvSEhic0h6UWN2Skt2L3dLVTByZWgxczdGeTlv?=
 =?utf-8?B?VG50ZDR6bzZWNDkyQTBtZS8raWNicjU4ZndiSllHTStDVkdid3oxbmNodjg0?=
 =?utf-8?B?RHY3SW5mVUl2UEduTmRZa3RJZVdKVnFNdk0yL0IxaFBwTzVlZENwa25HSjFp?=
 =?utf-8?B?dk5DOW5wakdsVFFWUjFqUkw0TjRRRFQxTzBVMnFlYUJDaTV4N1R4SUhiTE1K?=
 =?utf-8?B?Z2c3R0lKQVhLTEplZkxyNkhiaU12aVNkbGp0V2FzRUdJeG15VEphN21GY3hN?=
 =?utf-8?B?d2JMSU9mY25wbm5yemIyUWJpOFFCNFFJR01hTTdXZ2o5OTJQM1lVSUpwZjRF?=
 =?utf-8?B?djJXZGFlTlZLSytuMkpRT3JLTTFYY3NZcWR2dkdqc2J5TWxyS1Q3aXdzejNF?=
 =?utf-8?B?WFltQnd3UW9lNXBiMDl1dVNCWkExbWlRYWV1ZDNNL0FXSXVDT2p1WVoralBx?=
 =?utf-8?B?S1ZLa3Z4L0N3bDF5RUJkWS9qbmFITk43Q0tsaFVGTDljcUQrZjd0UUJIcEY4?=
 =?utf-8?B?QTFMY3g1UjFKZDN6OEM5cDhFVmdGS3VQUUJuWkFCUVlJbTRBbUpHc0UvVVh5?=
 =?utf-8?B?Zm94cWJvTSt6eUN2anBYaXBCUlcyR1dpZXJhWGw5NXl4U2M1TnNQYU9hYUlQ?=
 =?utf-8?B?QUtkMkJ4QnJPdnRlYWlyS2ZQQ3ZnS2x6OHhDbERaUU1RZksraGZSbnNFZlpm?=
 =?utf-8?B?M051TFBxZHRKdytDWUtJUjNGeUk3YWlpUjRQamM4VnNXWE5jTDN0OXVoaGVk?=
 =?utf-8?B?azdQVDhlRElLZ0V4Z2hpRGVsWlc5UjY0T2xWSkx1blRuRUc0NE5ERDRxTmxE?=
 =?utf-8?B?Z2Rxb2x5cnFRdTJhL1lxcWdOTGV2UnJ4ZUNNODFQck15c29DRWx1REhSWExt?=
 =?utf-8?B?bGQwOGtRa2JMdWJJWnNyaXNnMGpzeHlDK1VRNW5JRHhlQTFaOU1UMGVRZDlq?=
 =?utf-8?B?Vi9INzJUblRycUtlQzZDT3VWUnlYU2s0d1dQZHBLR2xnRkpYMWJrWjRtRDJa?=
 =?utf-8?B?U1Uxa2V2REtZOGFXQU01TTlvNWJrZXVBUkxRSThNc043bldCMTZDU3RkcUpF?=
 =?utf-8?B?M25GYWM2c2hPK2pyQWhuUUpiNlgzSDlRQytCSDhNVUtDbExHQU55SCsrUnY0?=
 =?utf-8?B?dlBtZDF5aTgvS1lqVEpZMDBHN24zYTdVT0YrSWJqYVJUdy9aWkxkVE9xNUxZ?=
 =?utf-8?B?MzdZUlBKSjRVRmxPMk5PWnJTSDZwZ0hhZDhDbE93ZDB1S2Jic0p1RURiV3F5?=
 =?utf-8?B?K1lpSFZGdDNsakFmR2dZVGRPa05KS2ZxQUZnVlhBTjZQRHlDUjB4bkxmeXZ3?=
 =?utf-8?B?bXJ3ZjdMdE11c0pTZlZEa1lzWlJQTUdkNnFKTitLN3MrT2pZcjNOQTZ5Rm1j?=
 =?utf-8?B?RE45cnJ5VGRUeTVLZDZsSWtDS216NDlzUC9WSHZ0eUhjOUR6NEUwcHBacHdE?=
 =?utf-8?B?U3l4aEV6N0ppd2FoZzlIcWRXMFRuTUw4VGF3WmQ3WnNxNGkxR25qNEZsMzJw?=
 =?utf-8?B?eEpRRTVyV1JjZUVTWHR1b3VNeS9NNkRvaThJY1VFYkxQRGN2dXZZc1B6b294?=
 =?utf-8?B?RVZ3ZzRQeldtQjB3Z05QeVhXdXdBMkE4Vm14UmVVTEMrcHdPOGxKanVmSGVa?=
 =?utf-8?B?ejhsNExKUE9wWDhkOWFkWGJlZHpId0hWV0Z1WkpwclZneTJ1ZVVNNXk4akh3?=
 =?utf-8?B?eHBacjRjUU5KbUdVRStVbkVuc1IrcXBDQkZBSnhhRVNGKzdqd29XOVp2Wmll?=
 =?utf-8?B?UlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3495.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578ae566-b23b-4749-a1ee-08dae9b56ac3
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2022 15:57:41.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YxWXYrSJXdXu5mY1I0mJTtbYHdbbDxDEYMrsPdzJQEDozd0BvOEGAn7TmLI1PYZM4wITcCutGowEsBrrGybLgHBKe2zx/Kbuls8s7wz49Dfwx/35gGkVRuT5CzgamoA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5948
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciB5b3VyIGZlZWRiYWNrLg0KSSBoYXZlIHVwZGF0ZWQg
dGltZSBhbmQgcmV1cGxvYWRlZCB0aGUgcGF0Y2hlcy4NCg0KVGhhbmtzICYgUmVnYXJkcywNCkFi
aGF5DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBQYXVsIE1lbnplbCA8cG1l
bnplbEBtb2xnZW4ubXBnLmRlPiANClNlbnQ6IDI5IERlY2VtYmVyIDIwMjIgMTc6NTINClRvOiBN
YWhldGEsIEFiaGF5IDxhYmhheS5tYWhlc2hiaGFpLm1haGV0YUBpbnRlbC5jb20+DQpDYzogQWJo
YXkgTWFoZXRhIDxtYWJoYXkxMjVAZ21haWwuY29tPjsgbGludXgtYmx1ZXRvb3RoQHZnZXIua2Vy
bmVsLm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCBCbHVlWiB2MiAwLzZdIFRvIGFkZCBzdXBwb3J0
IGZvciBNZXRhZGF0YSwgQ0lELCBWSUQNCg0KRGVhciBBYmhheSwNCg0KDQpUaGFuayB5b3UgZm9y
IHlvdXIgcGF0Y2hlcy4NCg0KDQpBbSAyOS4xMi4yMiB1bSAxMzoyOCBzY2hyaWViIEFiaGF5IE1h
aGV0YToNCg0KW+KApl0NCg0KSnVzdCBhIG5vdGUsIHRoYXQgeW91ciBzeXN0ZW0gdGltZSBpcyBj
b25maWd1cmVkIGluY29ycmVjdGx5IGFuZCBzZXQgdG8gdGhlIGZ1dHVyZS4NCg0KICAgICBSZWNl
aXZlZDogZnJvbSB0ZXN0ZXItbGF0aXR1ZGUtNzQ4MC5paW5kLmludGVsLmNvbSAoWzEwLjIyNC4x
ODYuMTIyXSkNCiAgICAgICBieSBvcnNtZ2EwMDQuamYuaW50ZWwuY29tIHdpdGggRVNNVFA7IDI5
IERlYyAyMDIyIDA0OjA5OjQ4IC0wODAwDQogICAgIFvigKZdDQogICAgIERhdGU6ICAgVGh1LCAy
OSBEZWMgMjAyMiAxNzo1ODoxNyArMDUzMA0KDQpJdOKAmWQgYmUgZ3JlYXQsIGlmIHlvdSBmaXhl
ZCB0aGF0LCBhcyBpdCBtZXNzZXMgdXAgdGhlIG9yZGVyaW5nIGluIHRoZSBpbmJveC4NCg0KDQpL
aW5kIHJlZ2FyZHMsDQoNClBhdWwNCg==
