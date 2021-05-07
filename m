Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63676C433B4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 10:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3548961008
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 May 2021 10:59:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235578AbhEGLAl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 May 2021 07:00:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:17577 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbhEGLAl (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 May 2021 07:00:41 -0400
IronPort-SDR: Q+Q0t3BrgdDvz/eQLohX4hBH0N/KfxJsInxNEmD5z4RN+zTNHBVE915VIp8ZEuSLoCuAc/kZ6c
 Nkr0Syy/t8Sw==
X-IronPort-AV: E=McAfee;i="6200,9189,9976"; a="196687016"
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="196687016"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2021 03:59:39 -0700
IronPort-SDR: e4QkbdzvynIxrcEwOBgrKtG/K8sOhz2T76WX7Ibw9DXn2JIh/Lm2cGytffKSlOLcLqspVFc7dq
 BcfoBJOoaptQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,280,1613462400"; 
   d="scan'208";a="389994119"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 07 May 2021 03:59:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 03:59:38 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 7 May 2021 03:59:38 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 7 May 2021 03:59:38 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 7 May 2021 03:59:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P30uU0vbmmNalajE/Ri3Url3OLGvJWIEdbij/49l2HRri8zAEMeswM1tgPyhjum9emXzxKiXhXY+CKE8qq2ZrjGnjIboLJPdWCaPKGCZiuVlx7aRaL5RTw8CloyolVn3vpl3+/SkC/ZRLt4lV85h5xqvC5hUu6Qu2ONVZ6aSnWlNVyVYV4RXhOkoFZff1A1huZphuMFeni+dhdnq+Z9nME5cPani2NYAP1DEGU0oyVnrTP2EfmYVXHJOdofhodnVvPEFtqV/ks95rgyIE7Cx5kd+VkFEvR1i09bEnB3iw5ygb5LxsWuBG9a1EPoDC1paNE0sdklb23CPXu+2QiBRjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/EewB8OfKARN+gIro9zqmEXVHElwyTfHAGV70CBpoM=;
 b=nLEgs9hzCrHHrLrpsmS/jkPlBUOQ+dj9UkwTL2GStmTCdbh6D17FygosXU1TG5j5DLnZ457iOmn+8bLLtjoOXK0xW0erBlDtdBF8Jn49fIattJFQAKhxEtm4LpA1+Sym6DRafi2t+MQwyY2zXvTvSkP4RYEGi6pLsaNaVI8oFsSspnrFbAyuygbBbZ6Lak0cga9kapvzoWyxU0F3IeGOjq0tJyd+Rfiri+499GqNEu6Dvcw1LNJpzKZlSq21lnHGxhSjfvkvLMdJCAvmenjmlnY85G6MVdNAFgoeDDN+Pb7ZUYyM3GGfrftpYS1+bMC0ypsJ9x4oS61TY8Lof3nBcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/EewB8OfKARN+gIro9zqmEXVHElwyTfHAGV70CBpoM=;
 b=xWx35yUeW4QxWdKVzrtR5fPwUG0BONFGUlTyJywE3FGuABtcsjCMecSyvZY7wcPQ8m04/LV+IzTEZeF1opWyhmbylzuDp74jNMBo66y0/8i59sqkreB73ueoUkjJIxoSrPBTHP/cEgPCV0ysBuo5I3kQAARFq4bH8XYW3QT3qZc=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5655.namprd11.prod.outlook.com (2603:10b6:8:28::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25; Fri, 7 May 2021 10:59:37 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4108.029; Fri, 7 May 2021
 10:59:37 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     Marcel Holtmann <marcel@holtmann.org>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>
Subject: RE: [PATCH v6 2/2] Bluetooth: Add support for Read Local Supported
 Codecs V2
Thread-Topic: [PATCH v6 2/2] Bluetooth: Add support for Read Local Supported
 Codecs V2
Thread-Index: AQHXP076uCYeIj+T+0ycBheb+jxI1KrXureAgAAmMIA=
Date:   Fri, 7 May 2021 10:59:36 +0000
Message-ID: <DM8PR11MB5573B86EFD008E257C7ABCC9F5579@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210502123442.19483-1-kiran.k@intel.com>
 <20210502123442.19483-2-kiran.k@intel.com>
 <D241B632-E9EC-4D75-B7D4-48A710D8772E@holtmann.org>
In-Reply-To: <D241B632-E9EC-4D75-B7D4-48A710D8772E@holtmann.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: holtmann.org; dkim=none (message not signed)
 header.d=none;holtmann.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [2405:201:d012:c812:d91c:4ca7:faa4:ba4b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f3be03ae-941b-4c46-358a-08d911473479
x-ms-traffictypediagnostic: DM8PR11MB5655:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5655013BE1FA8DA9131B1F1BF5579@DM8PR11MB5655.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EcLen0bSFILK4jtjQ3GXSx3kgt7wk+7YGpv38pIhu+fUd9KWPAK+S1qR6RqXOG/Jn6ykBs+oRDQSmQSy7vRefBzqjy7hhwv76CCnPEkJ/ReFrbhS/pmKwpvJMiwE9B+uH6oSvzXVMtI/JiE6VAdNhJd2L9bI3lpHPmGsfNzU6Nprm62gM1G7ZslZgyoqyvnfnRMeq+FUFT4RyUgz9Od1ap/wNlgEV/aRkpTulbesLMzvyppKs7ald23yX25w0Mk9NScx9v0XfHUeSDaOwCQ/rG92vM9lzgy3JrbxulI/ehYt1LLyffrnxIZ8ODKdmZfg5S8fzmMfvDsSXZDDd1wBelC09E1hm+ShSghDPzD7/SUZJhegIWPsuOsZg+RJG9S4GS1b2mnZijv3SoF8JFCsTc4OnESi7AIM3de5DPZ+du0NKyONjAqqRUK/+cTOMkoqv7uIhYfjTGOZ/rkZKjJDTbzwAj1Eu5Kkke322hS8zCHPI1DiBz8+jvCp6SMTrDwePUfA14vxuBfTO6XTFI+h7IopEr9Q6arhoH2oFNfC5D0sgdqUq8FLW6CoArMzDXX/kU1se31iM0ft9X16Cm33eQuMzDiaYoIE99BMuLURBK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(39860400002)(376002)(366004)(136003)(66446008)(122000001)(64756008)(38100700002)(8676002)(5660300002)(55016002)(4744005)(76116006)(6916009)(54906003)(186003)(6506007)(8936002)(86362001)(66946007)(66476007)(4326008)(478600001)(33656002)(66556008)(52536014)(71200400001)(7696005)(9686003)(2906002)(83380400001)(316002)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?TnJtT3RUMUo1UHNXZHJiRG1LWitSaVdEd3dWN2NvYWpVMU5WMTVGY1VUc2Jw?=
 =?utf-8?B?L1dLemt1WjVybzU3aUZZcmZINWllVWEvbVZTMzYydzd2TUg3S0xGakRwL2x3?=
 =?utf-8?B?Tm5rOWRwSis1dWFlS25GblpTdFUzM2ZYRHpmUko4bW9aSDh4NWpyQ2RrUkQ3?=
 =?utf-8?B?b0xSeVJNOGN4a3VHZmhpeW0zNW5tc1R3ZnU2L1BZZXV3aTZVT2tld3RZUFVE?=
 =?utf-8?B?UWErRmo5STJvdllIR2VPK0VjaVdrQnljd3dSa09mU3ZKWERXMHEySEgzRm9J?=
 =?utf-8?B?MGcrNFB3YmdVdTFTUUo0S0RMUlVZODA5QlBXQ3N3cUtDMSthaldwdGVIV0NT?=
 =?utf-8?B?c0lBcUt0aXNJMmxnUmFsc2RheWdTS2FwUDRVWGZpL25MT3Axek03WkxvZkFZ?=
 =?utf-8?B?Wmd1M05qMVkrbzh0Z1pmQ3ZTMHhsRDRQSEkzVWNpQzNUZXFzTW1WL1BtaFJ4?=
 =?utf-8?B?R1VHdHAwNGt6SExKL0tQY0p1ejdES0J5UVZtU2FTeERuZVJJVzkvK2V4SENl?=
 =?utf-8?B?TXhmQlRaNGxkZnZFL3dWOTJnWVVJdHdDR2k4bWd5VVVlU1dnY2NyRXFXQkor?=
 =?utf-8?B?WG1hRldpMTFRcTFEcjRVNHJKb2ZiOThKMXdmT2JSdEN6eFNWclVZTys4Q3o5?=
 =?utf-8?B?bHp2MGxRQStVb0VtYm5TaTlUVkFEK1VWc09wT1REalRDdTduWlZZSk5yRmtM?=
 =?utf-8?B?bFJhSGhmaWZybXNreUc4a2JPWHg3MFRkT2I2MG9OY2YyN09mejlNemRsZnVL?=
 =?utf-8?B?YTJlTTFTQWppSUZscXZtTUtqYjRjSGlDREIwQVpIMGlFVisrNzA4blI0bzcw?=
 =?utf-8?B?UlhteEptVzdiUlBrMDAzV3lIK2diU1J5TmhEaERVOVR1alVrSGVFSjdTMlBl?=
 =?utf-8?B?bnZ2ZW05TlhPNXlFOGpBL2hjaHh0WWw1NDFDSHVma3lhQ1JyckdQeExDa2E1?=
 =?utf-8?B?byt2Z21WRVYzcjlRTzJLaTF3ZFZLSEdyNTR3eFNXTFUrM2RjNElJWXdLRGo3?=
 =?utf-8?B?YWF6REdHMVNYZzBCc0R5V25tTnBJdjZMbE5HR1IxS0FVYkpMNWJvZmRBS2RP?=
 =?utf-8?B?anZ1WFFjaGdrYTBWVW84YmxQQzJFRkhvSEJOeWhUbFRpNFk5bDNyK2ZneGJT?=
 =?utf-8?B?eEw0SmFXMEFzWnB4cUVXQnZKbTh6VFc5VVFiQ2lXREZ6MitXMjBjZzBjQk9p?=
 =?utf-8?B?TzY1Mkxmd3U5S21ZZXJuMTJVRG5kT3lTMGJvVmNMMEx2NTlRNVBrejh3bmtP?=
 =?utf-8?B?N21iR2l6ZW8xQ0xZRnZpN2ZLclJRRXJuN3lRMlVzVExoRk1tdmlnSmlEWUtM?=
 =?utf-8?B?dmlOOVFHeHJJYmtTZDc2aS9NekREVExtWGpUdUNKVmtQeFpLMHo0NGp2MmpR?=
 =?utf-8?B?ck00TGNmSDZSdzYwQXh0RFlWcGVmZElLanREOS9qaldCSU5lYitGaTVITjgv?=
 =?utf-8?B?bUdBQnRzUUh5K1dzR2RhUWRKME1uMlh1bFQ4aFpJT0pyVXBDVVUveUVKaG9t?=
 =?utf-8?B?UWJmRlBYNmxUWDh1OW55bEJtQkpHWmYzVTRaWVQyUEo1QWZ5TE9ZQ3BPS2h2?=
 =?utf-8?B?cEpnOXNMZFhTc0E3RmZodzVjM0tFMDl3bnczZEZHQURSMmdqTjNlZ1M0ekNz?=
 =?utf-8?B?Q0NEdDY2ZGlBMkw1em5GREt2c0FGK3A3NVFidzkwRTcybUNSZWtDYytVelFM?=
 =?utf-8?B?UFBsdUs3LzNEUEJqTmJkZkpGemNhbkMzRVFmbGtVR1RNMmJsaDVHdFN2MVpW?=
 =?utf-8?B?Q3VzTERoT24vdDFWWW8yQWZFR2VTSVR0dEkrajd1bWlqemJ1Tm1selFuL1lh?=
 =?utf-8?B?UDVrWU1sa281cXZPbjk1ckRkMjRTcWZVZHdPR0pQOCtQbDVvTVYzQnFVTEFk?=
 =?utf-8?Q?wYgw+6o+58/AV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3be03ae-941b-4c46-358a-08d911473479
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2021 10:59:36.8463
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CfpJcOGyinlHvCyqXF5fbqpwKgT7IdxusP3behWH8oCWHXOyd/GVpWbpiD8IJValZHliFksdY7JuUFBJb3OxMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5655
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTWFyY2VsLA0KDQo+ID4gKw0KPiA+IHN0YXRpYyB2b2lkIGhjaV9pbml0NV9yZXEoc3RydWN0
IGhjaV9kZXYgKmhkZXYpIHsNCj4gPiAJLyogUmVhZCBsb2NhbCBjb2RlYyBsaXN0IGlmIHRoZSBI
Q0kgY29tbWFuZCBpcyBzdXBwb3J0ZWQgKi8NCj4gPiAtCWlmIChoZGV2LT5jb21tYW5kc1syOV0g
JiAweDIwKQ0KPiA+ICsJaWYgKGhkZXYtPmNvbW1hbmRzWzQ1XSAmIDB4MDQpDQo+ID4gKwkJaGNp
X3JlYWRfc3VwcG9ydGVkX2NvZGVjc192MihoZGV2KTsNCj4gPiArCWVsc2UgaWYgKGhkZXYtPmNv
bW1hbmRzWzI5XSAmIDB4MjApDQo+ID4gCQloY2lfcmVhZF9zdXBwb3J0ZWRfY29kZWNzKGhkZXYp
Ow0KPiA+IH0NCj4gDQo+IG5vdyBJIHNlZSB3aGF0IHlvdSBhcmUgZG9pbmcgaGVyZS4gRG9u4oCZ
dCB1c2UgdGhlIG5hbWUgaGNpX2luaXQ1X3JlcSBzaW5jZQ0KPiB0aGF0IGlzIG1pc2xlYWRpbmcu
IEp1c3QgcHV0IHRoaXMgcmlnaHQgaW50byBpbml0IG1haW4gZnVuY3Rpb24uIE5vIG5lZWQgdG8N
Cj4gb2JzdHJ1Y3QgaXQuDQoNCkkgd2lsbCBmaXggIGFuZCBzZW5kIHVwZGF0ZWQgdmVyc2lvbi4g
VGhhbmtzLg0KPiANCj4gUmVnYXJkcw0KPiANCj4gTWFyY2VsDQoNClJlZ2FyZHMsDQpLaXJhbg0K
DQoNCg==
