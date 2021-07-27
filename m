Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76A71C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 07:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D06861179
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 07:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235882AbhG0HVg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 03:21:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:7681 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235867AbhG0HVe (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 03:21:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212109799"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="212109799"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2021 00:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; 
   d="scan'208";a="580096624"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jul 2021 00:21:34 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Tue, 27 Jul 2021 00:21:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Tue, 27 Jul 2021 00:21:33 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Tue, 27 Jul 2021 00:21:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE8sroyZ7CPAAoM8QVG7bcV0xtYH0QjzE89vZaRJPGeHQoxPwQv0Zem3Z5Jpd6nPKUkTI/3d022h1Q4uCJI3n7ScHSEWHGDLfXaM1QDGMdAw3KIRKoWKS5YFU1qwxN1qSHnEJBDlS8lX5865tErZDC7sLXwYfNk5mWpMkiPDEIOPNiv0HB/SJOKlnySYgBigeY5QcpwlbHh6rvp8JH6fuqnGgLlScdkWp7vk9LwTDltpAdtLpCZtWaCC+o7dXYCo0EI3YNzTHcECGUd/647UVEZQTSX+4QBrvL/z/hrkaVAt59a9Ze+h55uUc/3R/guWkjis2TMfuxyHqR/llqB0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTKM9W+jz5qQ2nfRa/gA9lEMx1ZAhrqeKooH8mPjd9w=;
 b=EMM6qucbFmbx1kPwbQ+fYtYUtQKt0fpvWrT1PNX8C45sdbQPr/B66tI9JbNgyPJQFcKAwLTZmx5Y8UhTYsyVrR0DbBSTq3ajjLwvE4gs+DiKauwu9NJQvPAl1GtXB4J4dCVoa88lTdcEqPfyW3GT0Dl2AdcxoEDdNnH1pDlmTS1mAr8ULb87AIAO+74pmyjVWD4NShg0CXPxyIqcVJVANbWzIiHnvYsFtdC8EnKyJMKZbHrLn6s5/5bhBrmGLwhfcaFi+RpBDZq0v51rsGbtbWknKy31CYuKrEJ3HPhszcKe6Untus7Y+XTzyB+PRrIqoBOJg6qYy1HGYOGPc4fSVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GTKM9W+jz5qQ2nfRa/gA9lEMx1ZAhrqeKooH8mPjd9w=;
 b=iUpcWqoRp4Od0uZAffocVpdXjrvIoBX6dPweWq1YgOaqfRMG7Jm+qjLSpxymyDkcEQfR9WqlCJhEKkdI5oQcULvcr6F61Hc7dz7xStLCBLwrCx13tTqofnRMrzcPzA6Ysu5nCaOOA51fFCkPwcfd/EcUJcVETFyb4nxCd+WEzEc=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM4PR11MB5566.namprd11.prod.outlook.com (2603:10b6:5:39c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4352.26; Tue, 27 Jul 2021 07:21:29 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::498d:94c4:3363:ea10%9]) with mapi id 15.20.4352.031; Tue, 27 Jul 2021
 07:21:29 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v10 10/10] Bluetooth: Add offload feature under
 experimental flag
Thread-Topic: [PATCH v10 10/10] Bluetooth: Add offload feature under
 experimental flag
Thread-Index: AQHXbYaAUPeBC7Tjn0uX3OjUW01jBass+OIAgCIwKQCAAD3AgIAABNqAgAACRwCAAAwGAIAHGsiw
Date:   Tue, 27 Jul 2021 07:21:29 +0000
Message-ID: <DM8PR11MB5573BADBF0F969CD2EB6CBDFF5E99@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210630080807.12600-1-kiran.k@intel.com>
 <20210630080807.12600-10-kiran.k@intel.com>
 <CABBYNZK-bE6vxikRHhxBM_7ucyZqMjxUBY6VEyw_e8C_xxAigA@mail.gmail.com>
 <B7EC95F8-FFDF-40CE-83B6-85861D530FD5@holtmann.org>
 <CABBYNZKMrq_6Rb9rJKhMU-w=WjznQsVc=yYfDVuxKtEjvtNLdw@mail.gmail.com>
 <87EBBD58-71B1-4712-A5BC-8B53E739DAFE@holtmann.org>
 <CABBYNZJjjxzrSzLHwyzT-KyMOXYArrwVffHd6s=Kn-OLpTZhXQ@mail.gmail.com>
 <72541BF8-3226-410C-962B-7128FB2B192C@holtmann.org>
In-Reply-To: <72541BF8-3226-410C-962B-7128FB2B192C@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d1243c69-f30c-4da1-c15e-08d950cf2717
x-ms-traffictypediagnostic: DM4PR11MB5566:
x-microsoft-antispam-prvs: <DM4PR11MB556609215B061C9C33AF2104F5E99@DM4PR11MB5566.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h0BS+McQ5aSySrjiV+8rM54uUCMPFthTMXxzqobHC91yc798NzPktbi8tjGcVtCzz/MSQm5kCaVJ8fLUhpuIzCcwzK33707A60fsyi4mv+OV9751A637TjOQ1cuLr0wvf/2lIVs+RBXVZnTYOkWRDWLF29poEDVYaKyIynKOHRIjwhQo3RP13sw5mlyMCRv9kZnPrmRxjcDoQnf6M/YKfir7BZ9f8SrzFbqKq7AZhoQuG0WkfH4e7fgAr+6mv2o9l4c9R3T2mrfEIYQL7wP/8N0RkliRSL6tz+Dx7UKSln8mCmyx3nq3CRiUVoo7eGsg9WDMsmYnrcS3LHxUlvvUJEvMGxlIT6t7jjFl7RUQ8D1wuybEOdFrEo5SDiKGBNPtMwbpqOZAeYTTfVHmHeXQqq3MekMwAKS24qtJJCk5W7bM/jxocbsaLN447ZBCStfy7pYyfPB+BYPIhbMWDEVf+sniSLBKpb9OiDq7aFllbpNeE1IcbRqPMgc3QrkECKlmGp/QxppS87Fa+aVV+9nSMGoYHmJ33KMV+3d8mrJdjUPCYxW9MdKx4yxlS1oXnZKI3NrG+4MBsq1QJTGqYtJqiwB2fZ3i9r3KcHbbONALXE/vcahvyYIi7LiaUf8K6eifq1kXqG+YvCkm4E1jVE699MR8CrzpPqD41SOcvtvDGNF2ktqyO819ZAicvY2EyBXsN+jfVpaWj+4H1k3BRO9OZg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(110136005)(66446008)(66946007)(33656002)(2906002)(4326008)(8676002)(316002)(8936002)(9686003)(55016002)(66556008)(478600001)(76116006)(66476007)(186003)(64756008)(5660300002)(38100700002)(83380400001)(86362001)(122000001)(7696005)(6506007)(53546011)(52536014)(71200400001)(38070700004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUdVNCtoOTVLSGttYXdzMTB4M1kzRk54aitJMVdvREhvMENYR04xVlhwUGxR?=
 =?utf-8?B?L3lubE5EN3JmUXl1T2ZqU0RkRkxjSFlxUnlWVWk0dDJmbkdNMmlPMjJSOUhQ?=
 =?utf-8?B?d0NMTVNBdUI3dFJGbWdnZzFINHM4U2krTlVTV2RxQ0VEa0pJRU9QKzh2d2R3?=
 =?utf-8?B?R0tTUi94QVNITVY5TXh1YlJuVGJaUllJK3hnay9WQytOY2o2MUFFTWNzWm5r?=
 =?utf-8?B?ZVdRSC9qTlhRQWNPM2VHRmlnQ1BjN2FINmpxQitVbjNmWEcwZWdQYkNjZTl3?=
 =?utf-8?B?TlVuTXBtMWdTbFpMZ2ttMklXb2dWYUx4TEMybWZJZzJZN0hRRjBOUHZtWFNX?=
 =?utf-8?B?MmxYbGdyLytDdEpZRDZPclNMNHM2RG82a3F0ekRJK2hKOXJlSGNTUFg1ZFFE?=
 =?utf-8?B?cWo4dXgwTkw3Y0h3Y1pFVlBzMEVvRUszcVdrNldzYkErUVQrOGN3dG93Z0pZ?=
 =?utf-8?B?bjNoQmQ2NUxvNzlwSlk4aUR0d1owWFVCZ0dReTJxcy9jQkFvaFJsSmdoNDBt?=
 =?utf-8?B?N2lvNFh1Y0hlSDFIYlcwV1l3TW9PN0VZUFI1ZFhpMzVueWRSaDAxb0hiUmdk?=
 =?utf-8?B?elFuaytUZWtZd0pHbHZmSWdHMWE5YkNORXh2Z2szNGhJMFNoREk5c0FRMVNW?=
 =?utf-8?B?ZVNOODJrUGFvc0NNb2RqYVpyUU5SdWMwKzN5VldGWGNudy9jczdXY0lsUGlB?=
 =?utf-8?B?QXdjeGxSZ2EzNVhiYTB2cWQvaWR1NmxuSVE1SW5oWkFzU041cnY3UDlSZ21t?=
 =?utf-8?B?c1pza0Z4WStyU1ZxeVUxRWVPVWlmWGNEVVdpQXR3emdqQVZMOXgybnBEdUlu?=
 =?utf-8?B?QmYxZ1ZhWlVqQW5OZG1CQ1YwT1Q4eWRuWXVPeDhoVk5XdFFucmczbFNnazZO?=
 =?utf-8?B?YjZjUXJpVG0wRGhJVFJ3Nkk0aHlWKzh6a1NYVGJSZlZ5NWlzL2txcGt3YnA4?=
 =?utf-8?B?a0ZaQUxZbnhmTjUvM3NVVHp4cldiR01VVXJJc1cwaVVWbFFTYitsMm42YjV6?=
 =?utf-8?B?THA2cTV5Y25tdGVjb3ZkTHlBa0h6NEQ2VTc2dzAvQzF0T1VmSzVpZ2pTQjg0?=
 =?utf-8?B?aHQrVUlOdmo1aVl0TmFiU0tPNUV2WC9pc3BaMXB4K0t5a0NJSXo2WExNdG1D?=
 =?utf-8?B?Y0dvcldDV2Zrck9OU1pzN2VJLzFCK1VLYXZac3JodGhqSmsrdTMzV1pIUVpl?=
 =?utf-8?B?YWRwNEpRZjJPdDExbkVIb2lWRFJpcmt3MWl0WmdyZVZUSE85c1hIbDJ4dHph?=
 =?utf-8?B?d2VpbDZLaWlYanlheFhVN1BGZS9TaCtHckExK2todjlaNWpIeVd3aGNHc09J?=
 =?utf-8?B?TEJEWjFMRE9hS1VGdDZtQjBQc0dHdzRaR0Z0YzMySmVCMHVFMlQ2QXVPVS9G?=
 =?utf-8?B?N054eEZIZWtHVmVuQTRKcCtOMVc4eXVSbDFRanRIQkxvQ0tzYzNhcXVhVmNY?=
 =?utf-8?B?bTllNGU4bHZNbk4xMEt4VS9SbVg2Nlp5SitWMys3a3k3OXFEdlRuQWZFaVVU?=
 =?utf-8?B?cjcyTDVNUHJvanBUMjdpSGlrY0VUZ05pdlFTQ0pMcnY2VXUwdkpWY0VjbG9P?=
 =?utf-8?B?blIrYlprWkdsQThSOVFvT3JVSTkwVEx2MDFia2RlRk9LUlFPa3dBSkhxSFQw?=
 =?utf-8?B?TVMzSEtPcUR1WC9FUU9KRldkUi9UMEtIQ3R3WkcvNml1RVVXdWlpTXVCdUZQ?=
 =?utf-8?B?dTQwaTdobTBKTFV2TFFFTXlUQmdwdkdwNGFuNXpodEFaKzVEMDEvZ1MwYmw2?=
 =?utf-8?B?bTBxTnp5czBqMnVVbld4TkV4SGc4bGU4UnlRUnhNTnliNU5oWDIzU3dFbGJ2?=
 =?utf-8?B?K2wxaFBTOVcvN3FEaW1sVFY5ZjVjUDJiWEtTZjdSdy9LZDZkblZOUnVtZmZR?=
 =?utf-8?Q?2kLfj2pJhw5/f?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1243c69-f30c-4da1-c15e-08d950cf2717
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2021 07:21:29.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uwTy6vqYDekNr8uY+a0N5RiTG9FkZcN5FLVCFeJGfHCUU120lRIU19Vcwh8iayHpuoZooJRfui2uTeIZ9MLmqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5566
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwgTWFyY2VsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206
IE1hcmNlbCBIb2x0bWFubiA8bWFyY2VsQGhvbHRtYW5uLm9yZz4NCj4gU2VudDogRnJpZGF5LCBK
dWx5IDIzLCAyMDIxIDEyOjIxIEFNDQo+IFRvOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6
LmRlbnR6QGdtYWlsLmNvbT4NCj4gQ2M6IEssIEtpcmFuIDxraXJhbi5rQGludGVsLmNvbT47IGxp
bnV4LWJsdWV0b290aEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MTAg
MTAvMTBdIEJsdWV0b290aDogQWRkIG9mZmxvYWQgZmVhdHVyZSB1bmRlcg0KPiBleHBlcmltZW50
YWwgZmxhZw0KPiANCj4gSGkgTHVpeiwNCj4gDQo+ID4+Pj4+PiBBbGxvdyB1c2VyIGxldmVsIHBy
b2Nlc3MgdG8gZW5hYmxlIC8gZGlzYWJsZSBjb2RlYyBvZmZsb2FkDQo+ID4+Pj4+PiBmZWF0dXJl
IHRocm91Z2ggbWdtdCBpbnRlcmZhY2UuIEJ5IGRlZmF1bHQgb2ZmbG9hZCBjb2RlYyBmZWF0dXJl
DQo+ID4+Pj4+PiBpcyBkaXNhYmxlZC4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5
OiBLaXJhbiBLIDxraXJhbi5rQGludGVsLmNvbT4NCj4gPj4+Pj4+IFJldmlld2VkLWJ5OiBDaGV0
aGFuIFQgTiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+ID4+Pj4+PiBSZXZp
ZXdlZC1ieTogU3JpdmF0c2EgUmF2aXNoYW5rYXINCj4gPj4+Pj4+IDxyYXZpc2hhbmthci5zcml2
YXRzYUBpbnRlbC5jb20+DQo+ID4+Pj4+PiAtLS0NCj4gPj4+Pj4+ICogY2hhbmdlcyBpbiB2MTA6
DQo+ID4+Pj4+PiAtIG5ldyBwYXRjaCBhZGRlZCB0byBwbGFjZSBvZmZsb2FkIGNvZGVjIGZlYXR1
cmUgdW5kZXINCj4gPj4+Pj4+IGV4cGVyaW1lbnRhbCBmbGFnDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4g
aW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIHwgICA0ICsrDQo+ID4+Pj4+PiBuZXQvYmx1ZXRv
b3RoL21nbXQuYyAgICAgICAgfCAxMDYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKystDQo+ID4+Pj4+PiBuZXQvYmx1ZXRvb3RoL3Njby5jICAgICAgICAgfCAgMTAgKysrKw0K
PiA+Pj4+Pj4gMyBmaWxlcyBjaGFuZ2VkLCAxMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL25ldC9ibHVldG9vdGgv
aGNpLmgNCj4gPj4+Pj4+IGIvaW5jbHVkZS9uZXQvYmx1ZXRvb3RoL2hjaS5oIGluZGV4IGUyMDMx
ODg1NDkwMC4uNWNhOThkOWY2NGRkDQo+ID4+Pj4+PiAxMDA2NDQNCj4gPj4+Pj4+IC0tLSBhL2lu
Y2x1ZGUvbmV0L2JsdWV0b290aC9oY2kuaA0KPiA+Pj4+Pj4gKysrIGIvaW5jbHVkZS9uZXQvYmx1
ZXRvb3RoL2hjaS5oDQo+ID4+Pj4+PiBAQCAtMzMxLDYgKzMzMSwxMCBAQCBlbnVtIHsNCj4gPj4+
Pj4+ICAgICAgSENJX0NNRF9QRU5ESU5HLA0KPiA+Pj4+Pj4gICAgICBIQ0lfRk9SQ0VfTk9fTUlU
TSwNCj4gPj4+Pj4+DQo+ID4+Pj4+PiArI2lmIElTX0VOQUJMRUQoQ09ORklHX0JUX09GRkxPQURf
Q09ERUNTKQ0KPiA+Pj4+Pj4gKyAgICAgICBIQ0lfT0ZGTE9BRF9DT0RFQ1NfRU5BQkxFRCwgI2Vu
ZGlmDQo+ID4+Pj4+DQo+ID4+Pj4+IFRoYXQgaXMgcHJvYmFibHkgYSBiYWQgaWRlYSBhcyBpdCBj
b3VsZCBsZWFkIHRoZSBlbnVtIHRvIGFzc3VtZQ0KPiA+Pj4+PiBkaWZmZXJlbnQgdmFsdWVzIGJh
c2VkIG9uIHdoYXQgaXMgZW5hYmxlZCwgYmVzaWRlcyB3ZSBkb24ndCBnYWluDQo+ID4+Pj4+IGFu
eXRoaW5nIGJ5IG5vdCBoYXZpbmcgdGhlIHN5bWJvbCBkZWZpbmVkIGFsbCB0aGUgdGltZS4NCj4g
Pj4+Pg0KPiA+Pj4+IFdoaWxlIHRoaXMgd291bGQgd29yayB3aXRoIGRldl9mbGFncyB3aGljaCBh
cmUgaW50ZXJuYWwgYW5kIG5vdCBBUEksIEkNCj4gc3RpbGwgZG9u4oCZdCBsaWtlIGl0Lg0KPiA+
Pj4+DQo+ID4+Pj4gVGhlcmUgaXMgcmVhbGx5IG5vIGJlbmVmaXQgdG8gbWFrZSB0aGlzIGEgY29t
cGlsZSB0aW1lIG9wdGlvbi4gQW5kIGFzIGZhcg0KPiBhcyBJIHJlbWVtYmVyIEkgbmV2ZXIgc2Fp
ZCB0aGlzIG5lZWRzIHRvIGJlIGNvbXBpbGUgdGltZS4gQWN0dWFsbHkgSSByYXRoZXINCj4gaGF2
ZSB0aGlzIGFzIGFuIGV4cGVyaW1lbnRhbCBzZXR0aW5nIHNvIHRoYXQgaXQgY2FuIGJlIHN3aXRj
aGVkIG9uIGF0IHJ1bnRpbWUuDQo+IE5vYm9keSBpcyBnb2luZyB0byByZWNvbXBpbGUgdGhlaXIg
a2VybmVscyB0byB0ZXN0IGNvZGVjIG9mZmxvYWQuDQo+ID4+Pg0KPiA+Pj4gSW5pdGlhbGx5IEkg
d2FzIHdpdGggdGhlIHNhbWUgb3BpbmlvbiwgYnV0IHRoZSBwcm9ibGVtIGlzIHRoZSBjb2RlY3MN
Cj4gPj4+IGFyZSByZWFkIGF0IGluaXQgc2VxdWVuY2UgYW5kIHRoZSBleHBlcmltZW50YWwgZmxh
Z3MgYXJlIHNldCBhdCBhDQo+ID4+PiBsYXRlciBzdGFnZSB0aHVzIHdoeSBJIHN1Z2dlc3RlZCBh
IEtDb25maWcgb3B0aW9uIHVudGlsIHRoZSBmZWF0dXJlDQo+ID4+PiBpcyBtb3JlIG1hdHVyZSBh
bmQgd2UgY2FuIHJlbW92ZSB0aGUgb3B0aW9uIGFsdG9nZXRoZXIuDQo+ID4+DQo+ID4+IEkgYW0g
ZmluZSB3aXRoIHRoZSBjb2RlYyBvcHRpb25zIGJlaW5nIHJlYWQgYWxsIHRoZSB0aW1lLiBJIG1l
YW4gaGF2aW5nIGFuDQo+IGV4cGVyaW1lbnRhbCBvcHRpb24gdG8gY29udHJvbCB0aGUgdXNlIG9m
IG9mZmxvYWQuDQo+ID4NCj4gPiBBbHJpZ2h0LCB0aGVuIHdlIGRvbid0IG5lZWQgdGhlIEtjb25m
aWcgYWZ0ZXIgYWxsLCB0aGUgZXhwZXJpbWVudGFsDQo+ID4gZmxhZyB3aWxsIG9ubHkgY29udHJv
bCB0aGUgdXNlIG9mIHRoZSBjb2RlY3MgZS5nLiBzb2NrZXRvcHRzIHdvdWxkIG5vdA0KPiA+IHdv
cmsgaWYgdGhlIGZsYWcgaXMgbm90IGVuYWJsZWQgSSBhc3N1bWU/DQo+IA0KPiBleGFjdGx5LiBJ
dCB3b3VsZCB0aGVuIHJldHVybiBFT1BOT1RTVVBQIGVycm9yLiBJdCB3b3VsZCBiZSBzaW1pbGFy
IHRvIGFuIG9sZA0KPiBrZXJuZWwgd2hlcmUgdGhpcyBzb2NrZXQgb3B0aW9uIGlzIG5vdCBhdmFp
bGFibGUgZWl0aGVyLg0KDQpBY2suIEkgd2lsbCBzZW5kIHRoZSBjaGFuZ2VzIGluIHRoZSBuZXh0
IHBhdGNoc2V0Lg0KDQo+IA0KPiBSZWdhcmRzDQo+IA0KPiBNYXJjZWwNCg0KUmVnYXJkcywNCktp
cmFuDQoNCg0K
