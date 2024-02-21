Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A477553816
	for <linux-bluetooth@vger.kernel.org>; Wed, 21 Feb 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521225; cv=fail; b=Q6OVbidpeVEcBWdYSYs3ygL5n7wp9VoY3gMfRB3Ds6jqhfMajrZEPNg1Egc97AlYI2m0ItgiAkNcTpc5T9sd+FBcwmPAb9EGSTtw8UMEl/QlolCETecb5k8Q25w/Y/zrOQ+fvb++CVOAsILCvmDnPp7m+6IObxlLDC2vn+D3WlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521225; c=relaxed/simple;
	bh=l/vx9it8jsIx2rL6BUQ1RAvWXekHXskPz6CW4LYT+OM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhPgiukQ+JfH8IUJuaXZK98NdKSWXrWqpUQQomROHCmZYOJJ27IxeZN6FBzuqewy46zX1QSbfz+qKOhmZ+zVi8KlgAsE04VUhUZym5C/di38LG0JKf9bZxnzmTWwreMeV8ndjO3Ivo34xchIFbWN0wQ7W2n2asgIJHqxOdNUjyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2C+1bsx; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2C+1bsx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708521223; x=1740057223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l/vx9it8jsIx2rL6BUQ1RAvWXekHXskPz6CW4LYT+OM=;
  b=B2C+1bsxYlAjU0hMokb9uL+1iwkZIzfceV8NAe81a2caYq13v6Fnbd5q
   /BcELHK5wE+iWRQqpHyCvnUobY0ahQCqI/1L5ezwycXWU6BBq93eewSUv
   pMEGHQp0xBi7BnZewa5lnAbnoi4z/E2vGTbu5Ebsa26JQaWmFFk22n/wg
   dV3cDaLO3Iu+emmxetVle2HEDLLcVkJw0R/s+DzdWs6IpV/r3kLp9uVkL
   BNDQ+CQ9QzwYbSN7ZGebhRNtnfwP4pA72d7dzyrZSFTxJ+Nn81Np37Jbr
   mdyCTJOFT/I2D2fa96uVCUe6m2MTsODIvJ9Kh8wZBAN40CQE28Fmt7LQR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2802731"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2802731"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 05:13:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5436957"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 05:13:42 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 05:13:41 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 05:13:41 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 05:13:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PS9WnW4Y562fRQRdE6B57jIqDPQoxpIfWA+2Vic/+Fk4nenbUFcFyAihOQ5pN3I9mXgeVOb7JpetneJeLxeJQgAFgvrPqbENeRtQYSVoMQE/quv9vSyZ9B3CGk82F1uIu3WsQwPvpIuPeHOfT2a9nkg/CjuIUVUWhme4jNMC2m77eLhIO8UQqzDw3SfpVB9YM4sg3wnbZWLwVC7GmlFOuN7u9Ap8OKcVQNryaW3F6bYrfACAM5KXxpDghhqhW3myOZvNtNm5y4Ho4IjIYUE5nWrj9d2+p3OhZtMaHCR5rHQEK5lE/Zqo8Bd0I5A8BrKc4qOQ/z9FJbobI5sNHJOQ2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/vx9it8jsIx2rL6BUQ1RAvWXekHXskPz6CW4LYT+OM=;
 b=cmZ+BXwJbvqBfq3ceZC8T2XonsM9fk9B8WdVN1qKJYv9cvMSg+GGA9Y9NHrF80IdFuSdoXG563/qHc0N1UGztsSXLy6PVJnqUBgnsoXuplav2IX3lWz3jlvhhJu9kNJp1qBK4sB+QGdCUwnht+Y0Z9dP6uLgcMb1/ajYl22B7RJpTVGFhbm+so55FivPCRPRvvfPNZvYAWNu8oGMSPqcx278ABt+3sJGab0wc2lqu4eOEeJS5kDN/y1UIHqNNIGLx3wCg2AOZW/wSgYDGFWfGT79EzEI5wMhPaqLj7EaJu8v9wjvuuxRkS3vEE29L0x2K+cvg3xOguqL05kLC6drKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB7600.namprd11.prod.outlook.com (2603:10b6:a03:4cd::6)
 by SN7PR11MB7637.namprd11.prod.outlook.com (2603:10b6:806:340::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 13:13:39 +0000
Received: from SJ2PR11MB7600.namprd11.prod.outlook.com
 ([fe80::9e1f:a422:1d22:194f]) by SJ2PR11MB7600.namprd11.prod.outlook.com
 ([fe80::9e1f:a422:1d22:194f%5]) with mapi id 15.20.7292.033; Wed, 21 Feb 2024
 13:13:39 +0000
From: "K, Kiran" <kiran.k@intel.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>, "Tumkur Narayan,
 Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer
 information
Thread-Topic: [PATCH v1] Bluetooth: btintel: Print Firmware Sequencer
 information
Thread-Index: AQHaXpRKgM0eyY7u6k+9PV/vOo9Kp7EIcRyAgAxg+6A=
Date: Wed, 21 Feb 2024 13:13:39 +0000
Message-ID: <SJ2PR11MB7600C7545481B456363AC7E2F5572@SJ2PR11MB7600.namprd11.prod.outlook.com>
References: <20240213160152.2836131-1-kiran.k@intel.com>
 <CABBYNZJL9FKuWU_4c1KrskzjAtBVxtW9PDqP==MAYGOc+NZB5Q@mail.gmail.com>
In-Reply-To: <CABBYNZJL9FKuWU_4c1KrskzjAtBVxtW9PDqP==MAYGOc+NZB5Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB7600:EE_|SN7PR11MB7637:EE_
x-ms-office365-filtering-correlation-id: d23fb7ab-a70e-4eac-88ab-08dc32deeb78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6Yo0PklkiJhQijcPMmusbYrBM4HtceC0SEFx9ZtdCmCcUeCbboOwJQUk42ARw4XXhAEYfK0svXS26Me5z29tKf6dE4itZK2vCt0AI1VWynRnmpEqHGV4BaXb70LQolUGCx7cN1IFxVOR1o2mJGlygNx5M2zhSz4gvr+xhJyP3uYJig+OYXYEHSOBz59e+RWdbuUqg/ARRsGjPvgIY3nuO8zBZ+rKgvBzSVjwmLYtYUkDHSMfsfnahTQ06k2uvVkw5xLPAerzuVVObTm+UPmehSKEPC7qqpMq5305OKG2KSj+je0oc5sKwBnUUzE+Kts19Ff3q6GBqPY0smTL82hzoXOTOof0CVe6Lc1e1rmKNwpk909m36eh9/NUSebU2bzCafi+TbpNYihJPsBruUKLAnNgrVRgUn9j6mWQ1d52s321Euq1dyy3GTIhgFoVegKSIJgCwOXNp8SEnBUfJ/4Ib1C0CRajnoUFv49H6dlHPR1jBOIb4+VB0l4MpUoC9nDwuFviEpqbVaYsvg1nJIAPYqBH410oKi5G/phfXTQkqn0TK3uin1y6s79emwcyJguFmQdliC9JVgSc27DZCYayiYGziUvMS/nrhD3Yki4hhy1V7fz31FGZeDfmjqye0G/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7600.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3ZOK1RYejVzaDRER0hxa2MzaGJzb0N6ZUFyTXF4S1BPOUpUd2x3YllZRk1o?=
 =?utf-8?B?M1NwZFdVTUo0NGVNMXMzV01ybkdCRVEwZ09lWFRHczg3djgrZUdYam1kTDFY?=
 =?utf-8?B?dW1MS1Z3QytTK2Zubk1mZmNwek1IblZ2T2pCbDRTMXZmZUhkTXE2ZC9zYnVS?=
 =?utf-8?B?aDVRemRYdFRDWVIxMmV3ZmR2bXZjVVZBWFo5bDB2b1ZPUXZIVldoREFXSGpJ?=
 =?utf-8?B?VTdyUURibjRWTTNwY0wzbU4rS29NaUhuZW9GQ0l1YnAwTStaU1VKL3lTdkJE?=
 =?utf-8?B?NHYzMEtPL1ZoSGZxUnk1cHVkVDZEbEovK1MyQ2h5MkxvUmNFVzB6QnBZTnVm?=
 =?utf-8?B?eDNvUER2eUExTExwTTRsVmpQQjdPNzRGRm5EMW5oM0RrMGRhVnJFVzRoenpU?=
 =?utf-8?B?OWovMVFkS0JkSWNEQkFoVXQyOVJoZmhBREJxTnN1YU1hbHd6WDhHN3k0amRS?=
 =?utf-8?B?aEZpMjFseU1MM0prYUtobTkxcktZWWlvbVJsUmRFQnE3TG9EdjdWVWJRL1BH?=
 =?utf-8?B?YTZ0VUJZNFg5WTdNay9rWU5WbndhaEU1bWJjV3dBTGFSUG1WL2JXaTZPaWNz?=
 =?utf-8?B?OTdFUlFxdSttZG5ycVdGSUZuU29pa0liMWZob0pCejZicGV2Ry9vcUN1ZFZI?=
 =?utf-8?B?eDZWK21leG5acFZiYjFFazF6bU1Oc0YzQTVIQ2U3T2E2Q3QwYVRtbE5MNEZF?=
 =?utf-8?B?djdJemx5TTRUY1lnL2thOWd5MnJOcmVscnlQS3hwdmk5c0RzSlVURHRzTWNT?=
 =?utf-8?B?aEFweUFhb1dsWmVXekFaZXNiV3ZHUXFrQ2ZzM0FSMDlTMHdXb2hZTlRDUEdq?=
 =?utf-8?B?Si95TGFHZXhMaGZCUldmSjdwamE5MVJsMEdjY3QvL3pmaGluR0xtUmd2aUJn?=
 =?utf-8?B?U2E4RWd3MnZqWkYzSHR5M3c0NE94RUlMTlNNNFdEWnJyVm94T2RVZkpFaXpG?=
 =?utf-8?B?emtsNCs0RU4zOWtPZmtxT0o0TXZvY1NkZ0JzazdOM1I0RTRoL05OOTREdWtU?=
 =?utf-8?B?RDFhczJuNFdBK2htVlVzMHNiUVU2RmFGTmp1QUxhWVVOTDF6dDkzOFY2Y1NM?=
 =?utf-8?B?bjlmOUc1bzBVY3lwd21DSktJejVPRkxBZU1LM1grNEErdk1YWlhjWnNFQXlJ?=
 =?utf-8?B?VGtYdzFBV2Q1NDE4VjE4ZnlzbHZVeXhhNDhFbFBTd25BZW8yMXNOOWx5RDYv?=
 =?utf-8?B?a3JTRG83T0N4V29QYjhHRDFzNlBLTlVjRHJVV0lzUnhYUm1yMExSRlBkeTJq?=
 =?utf-8?B?T0ZxYS9XVFIvSVkrSXpCZndnalRWQlUyTGUyUnNBVzZTVGxGTXdVampvSmVR?=
 =?utf-8?B?NUF1MWkwZlFsVit2S3ZKSkVMSU02aURuQ1llZTk1QUw1NGw5NXJCYmNrVUNo?=
 =?utf-8?B?ZFExQi9MVVpjVTFRZ0FmQWorak5ubVNCT2FTMXdnNEwybFpOQkVxWnBKbDZE?=
 =?utf-8?B?Nk15R3ZWdWZnbnF2Q3E3dFpyUmxEWjZleHZwdUk1MzFyS2NtbTErM1VKYURI?=
 =?utf-8?B?V2pYZ0Y1dlBUUWZaVURRNXZ6QkxNdTR2d3Q2Yk1lUHZrOFpMVWlnMks4SzBS?=
 =?utf-8?B?SXJ1ZWo4bVVkRGFWRWs0R3dLSk9DQllEVVg1ZDZ3dUY2RTdwTWpXb0hXZDZo?=
 =?utf-8?B?K1IxME9NQ2FpUGQzc01TODlzVUV3RWcwZUhPTEU4RldxNnY1LzVhdWJ6Nlp3?=
 =?utf-8?B?blhIbVVFU2FUenI4N0FTQ1RLdU9kMmlJdURFRXJnN3hzeUpqWmNEVDRFT3pa?=
 =?utf-8?B?NzY2S1RhaGhFOGo4SURJWU9BaHFPMkNKc0ovUjVHd2wxdzBqcjNmRm1vdHRa?=
 =?utf-8?B?Rjh6VWhYZnNRMlZlR2FBcjN5bkVKVXd0TFhucEVJYlByRXEvQkZXdThGNTFn?=
 =?utf-8?B?ZXIrZjRWb1VIMW55L012QnVZbHhvQldaMWNQZEJVMmJaR2l4NnZSUTFoKzdY?=
 =?utf-8?B?NzFZUGtxUnJDRGJrcWtNRDRPOFhzQTdNRE5uMy9MV2N3VjFmZStFbHhHbFNC?=
 =?utf-8?B?TmJxdi9ZYXBCc080WVdVMktlaldKN1JXQ0NjYm5hWlNreXozYm15M0xHT2pa?=
 =?utf-8?B?dmY3MFRyM0NLdURCL0ZZY3VLMWtseDVya2cxcVM0eUc5MnFWbEtWOE1nVlVi?=
 =?utf-8?Q?2f9E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7600.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d23fb7ab-a70e-4eac-88ab-08dc32deeb78
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 13:13:39.4207
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zxHOwwBxkrDcYIz1KM6r+NJSP3738/UJSSE3YdeqQrb71OqxfVcqsDRkVnlHY84nUvo7IK345OpEai3sTaCCnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7637
X-OriginatorOrg: intel.com

SGkgTHVpeiwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWl6IEF1
Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwg
RmVicnVhcnkgMTMsIDIwMjQgOTo0MCBQTQ0KPiBUbzogSywgS2lyYW4gPGtpcmFuLmtAaW50ZWwu
Y29tPg0KPiBDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgU3JpdmF0c2EsIFJh
dmlzaGFua2FyDQo+IDxyYXZpc2hhbmthci5zcml2YXRzYUBpbnRlbC5jb20+OyBUdW1rdXIgTmFy
YXlhbiwgQ2hldGhhbg0KPiA8Y2hldGhhbi50dW1rdXIubmFyYXlhbkBpbnRlbC5jb20+DQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggdjFdIEJsdWV0b290aDogYnRpbnRlbDogUHJpbnQgRmlybXdhcmUg
U2VxdWVuY2VyDQo+IGluZm9ybWF0aW9uDQo+IA0KPiBIaSBLaXJhbiwNCj4gDQo+IE9uIFR1ZSwg
RmViIDEzLCAyMDI0IGF0IDEwOjUx4oCvQU0gS2lyYW4gSyA8a2lyYW4ua0BpbnRlbC5jb20+IHdy
b3RlOg0KPiA+DQo+ID4gRmlybXdhcmUgc2VxdWVuY2VyKEZTRVEpIGlzIGEgY29tbW9uIGNvZGUg
c2hhcmVkIGFjcm9zcyBCbHVldG9vdGggYW5kDQo+ID4gV2lmaS4gUHJpbnRpbmcgRlNFUSB3aWxs
IGhlbHAgdG8gZGVidWcgaWYgdGhlcmUgaXMgYW55IG1pc21hdGNoDQo+ID4gYmV0d2VlbiBCbHVl
dG9vdGggYW5kIFdpZmkgRlNFUS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEtpcmFuIEsgPGtp
cmFuLmtAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL2JsdWV0b290aC9idGludGVs
LmMgfCAxMDYNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEwNiBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jIGIvZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5j
DQo+ID4gaW5kZXggZTViMDQzZDk2MjA3Li4wZDA2N2VlMzk0MDggMTAwNjQ0DQo+ID4gLS0tIGEv
ZHJpdmVycy9ibHVldG9vdGgvYnRpbnRlbC5jDQo+ID4gKysrIGIvZHJpdmVycy9ibHVldG9vdGgv
YnRpbnRlbC5jDQo+ID4gQEAgLTI2NzAsNiArMjY3MCwxMTEgQEAgc3RhdGljIHZvaWQgYnRpbnRl
bF9zZXRfbXNmdF9vcGNvZGUoc3RydWN0DQo+IGhjaV9kZXYgKmhkZXYsIHU4IGh3X3ZhcmlhbnQp
DQo+ID4gICAgICAgICB9DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBidGludGVsX3By
aW50X2ZzZXFfaW5mbyhzdHJ1Y3QgaGNpX2RldiAqaGRldikgew0KPiA+ICsgICAgICAgc3RydWN0
IHNrX2J1ZmYgKnNrYjsNCj4gPiArICAgICAgIHU4ICpwOw0KPiA+ICsgICAgICAgY29uc3QgY2hh
ciAqc3RyOw0KPiA+ICsNCj4gPiArICAgICAgIHNrYiA9IF9faGNpX2NtZF9zeW5jKGhkZXYsIDB4
ZmNiMywgMCwgTlVMTCwgSENJX0NNRF9USU1FT1VUKTsNCj4gPiArICAgICAgIGlmIChJU19FUlIo
c2tiKSkgew0KPiA+ICsgICAgICAgICAgICAgICBidF9kZXZfZGJnKGhkZXYsICJSZWFkaW5nIGZz
ZXEgc3RhdHVzIGNvbW1hbmQgZmFpbGVkICglbGQpIiwNCj4gPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICBQVFJfRVJSKHNrYikpOw0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4g
KyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgaWYgKHNrYi0+bGVuIDwgKHNpemVvZih1MzIp
ICogMTYgKyAyKSkgew0KPiA+ICsgICAgICAgICAgICAgICBidF9kZXZfZGJnKGhkZXYsICJNYWxm
b3JtZWQgcGFja2V0Iik7DQo+ID4gKyAgICAgICAgICAgICAgIGtmcmVlX3NrYihza2IpOw0KPiA+
ICsgICAgICAgICAgICAgICByZXR1cm47DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAg
ICAgaWYgKHNrYi0+ZGF0YVswXSkgew0KPiA+ICsgICAgICAgICAgICAgICBidF9kZXZfZGJnKGhk
ZXYsICJGYWlsZWQgdG8gZ2V0IGZzZXEgc3RhdHVzICgweCUyLjJ4KSIsDQo+ID4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgc2tiLT5kYXRhWzBdKTsNCj4gPiArICAgICAgICAgICAgICAga2Zy
ZWVfc2tiKHNrYik7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gPiArICAgICAgIH0N
Cj4gPiArDQo+ID4gKyAgICAgICBwID0gc2tiLT5kYXRhOw0KPiA+ICsgICAgICAgLyogc2tpcCBz
dGF0dXMgKi8NCj4gPiArICAgICAgIHAgPSBwICsgMTsNCj4gDQo+IEhvdyBhYm91dCB3ZSB1c2Ug
c2tiX3B1bGxfZGF0YSBpbnN0ZWFkIG9mIGFjY2Vzc2luZyB0aGVzZSBmaWVsZHMgd2l0aCBhDQo+
IHBvaW50ZXIgY3Vyc29yPw0KDQpJIHdpbGwgZml4IGl0IGluIHYyIHZlcnNpb24gb2YgcGF0Y2gu
DQoNCj4gDQo+ID4gKyAgICAgICBzd2l0Y2ggKCpwKSB7DQoNClRoYW5rcywNCktpcmFuDQoNCg==
