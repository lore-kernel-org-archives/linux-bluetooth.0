Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87767C433DB
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 03:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DADF64E28
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Feb 2021 03:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbhBKDFX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 10 Feb 2021 22:05:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:46902 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhBKDFW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 10 Feb 2021 22:05:22 -0500
IronPort-SDR: VZioLt7g8sX1l4rxAmccyDR1HtgpwSVpWtkBtknJV6MWiM03KINLa+/Xs7CexWArPBBzazguBk
 GVGqsnY4Lt9w==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="161936649"
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="161936649"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 19:04:42 -0800
IronPort-SDR: sjE9zdDJq60EUImrgq2JcuRKZ3+6bIQ3AgrHavG+sO5H5BFT/tZikkPAZFLhKxGrdc71oMeqt2
 gsHnEzucr+VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,169,1610438400"; 
   d="scan'208";a="380426458"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 10 Feb 2021 19:04:42 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 10 Feb 2021 19:04:42 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Wed, 10 Feb 2021 19:04:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Wed, 10 Feb 2021 19:04:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AdYSlupbsSTfbghGVduhGQNXyo8iletIr8P6u69BTkxkZ9yJEVFTw+t0dBotNolxEfRpg5W0DTbvHC2KiOepvRbM/CtRAhfAQZz1wtI5R2VMLPwh24XW9mbQg4CdG6zIsJMmO/CpL0+9WoB2vg+BMBmh8CKnc209/rI5dcc6U+yJO1Fi/yztHtdmXVjD0qemFh02vz7caibaYD58Ua15shuZUBm+4I3wdU54JzqZNhEdk6PiwXoWK+a24RnxNm5XA8cEJ/mzjgoZysoHP31gmig49WlDj6LNGn88DY1cfH0IN4yUyMYZUTZO0QJTE6/XsRFr1CrhhqoOpokz0OORRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf4VmOQH+tT7h4B1PVSVu3EJgC4kfrmNgQKliT9mUlo=;
 b=odrM8v4sTH9iDPA17tYItRb48DwQryqcQjIZ0HBbqvtVqCcMiVp0zScxLDosHxyGyFAAg7iorNjCD3K29b/jMM/j/0xtHW3OdKVxZZf1LWFdGwP7fPRYKjNljDZwiXzozuh+nyKHJq5Y1ZJ5CIGr1fzvzsjJ0LwpYQasMnCjKmzXsOZfwxLPAJLsJ88P6mnUmhBX3jLltjjfwP7II6i9ZWgHhWpNsaiFJubKfR6fh33dnmZCKgHVYfW3086seBvhegcgLljO0tWb2rVv1hRQTJexSEM/+F9XQPTR0EWt2wx1SxYXLcl8Wu+TOle4Hul0DiW1/u2Xy6hhldgeaWrbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tf4VmOQH+tT7h4B1PVSVu3EJgC4kfrmNgQKliT9mUlo=;
 b=REF0QnmZxXT/jaNGKvgEgaGmmAIwsTkqcdZ8+lPrpT0Uhvk57M+xpndIjjvBNyE4klBfeL4laspPtG+N3Dsn+q0vJe7dlARIebiwK/U6eCBcMWlJcm4EChpTMEl1TI51p3xsVIgJ8yMEVdcltLEv901/FgZy3FA4xYFHiSOj3qs=
Received: from MW3PR11MB4539.namprd11.prod.outlook.com (2603:10b6:303:2f::13)
 by MWHPR1101MB2192.namprd11.prod.outlook.com (2603:10b6:301:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Thu, 11 Feb
 2021 03:04:39 +0000
Received: from MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab]) by MW3PR11MB4539.namprd11.prod.outlook.com
 ([fe80::30c6:ea80:eabe:2aab%7]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 03:04:39 +0000
From:   "Gix, Brian" <brian.gix@intel.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "Stotland, Inga" <inga.stotland@intel.com>
Subject: Re: [PATCH BlueZ] mesh: Clear node's agent pointer after agent
 removal
Thread-Topic: [PATCH BlueZ] mesh: Clear node's agent pointer after agent
 removal
Thread-Index: AQHXACF5R+W3oejR8U+9ofRdxfOjY6pSRQEA
Date:   Thu, 11 Feb 2021 03:04:38 +0000
Message-ID: <2f07671fc65a685042027b3dad54b2383659ff73.camel@intel.com>
References: <20210211025558.11791-1-inga.stotland@intel.com>
In-Reply-To: <20210211025558.11791-1-inga.stotland@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.4 (3.34.4-1.fc31) 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.55.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85d446c1-742e-4b2d-4c33-08d8ce39c546
x-ms-traffictypediagnostic: MWHPR1101MB2192:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB21927006468E3D2B0615E860E18C9@MWHPR1101MB2192.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FCO1RzNWPNpwzl+WXc6I3yus3QEK9tzifjwgpCI/OoAA6pUchY5zjPoFMo20Z5rnc9PX2ePPw2S5ZlQrkefTTiMt5HykQprl/9LJabWCw2q/sn3kDXWElm6ML/q47BeruZQQVmf5KrBHDQOFmfdXM2aMiYFCeOGo5Sj8bhbAVn9P8QAIOQyH6MHQn2Da/dAMgJJhWgUDKiAW1mYmwtLsB8DFaCtsjgFf/a6OqZaAxOC1hJCfaE7bzmrvIb0GiOWBUlklxGMTGynGreWqMv2Ug+8HhOGgo7n5trUL+9h1CkZ7TfNb9uBu9Dfj1Yzxa+5yLObbm0LJj+iKtTP2a4vLO/J6Qu1OFi7BsoRxgZPtjpUrfmOiEQ3EYUrsW6wNSMcw6bcYJBzQErc/kXvOtWrR3Vky8RKlUvbbb6VoSHtes5vfF6NbTxPY79xe6rId1cOJGRGpJ9fJQm/xz1yxPceIJiVuK8q6xuuEe+ocKk1SJxwSuZycsZc/v+NW9AXae1TXr7u3mq9xluMBDpteDGG0Qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4539.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(366004)(376002)(346002)(8936002)(5660300002)(86362001)(66556008)(36756003)(4744005)(26005)(2616005)(71200400001)(6506007)(6636002)(186003)(2906002)(91956017)(316002)(66476007)(8676002)(76116006)(66946007)(6512007)(110136005)(6486002)(64756008)(66446008)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?utf-8?B?OUVMcEhKVmRqcW0yUkx3cHkwVXYwZE5NdmJsKzRnSnk4UGN5N0VxUVFsWnYy?=
 =?utf-8?B?SUdVTFBuTXhPNndxdGhGMWFXSy9SOW5xYUVvMUdGb3ZiaU9YN1RkL2JtUExz?=
 =?utf-8?B?VjVOSWhWQmxvcWpMSDllRU1rOTJrZ3J3cnU3blVEUVlTQ0JNSEcxRmVBTzQ3?=
 =?utf-8?B?dm1EZDFDRnpDM2tLbFdQYVByT3JGM2hGbnJJSENHZXF2Tkc1dWlUS0ljVVl2?=
 =?utf-8?B?UDF2N3ord0JvOE54c0Q5bHhmRWt5Um95WDczcFE3S1k4YVF2WlhHbEFBajlo?=
 =?utf-8?B?Zm9QVUI2eWt1bWJ5UE13cWdTSVBhcERRc04vTDhjK2YyTEw5UlNHVUNKV0NQ?=
 =?utf-8?B?Ti9QRnBsV3Z6Z2NISDgxZUlwSG96d2VGSFFoeEZhckJjUzh3bkY5MzR3LzRs?=
 =?utf-8?B?WlY4SHRMOFY5TWJtQnZmU1ZBOFRob3U5ckY4SythN0VaUEYzT0g2bUFQcm9C?=
 =?utf-8?B?ZUxPMzFLaG1NbkdqRmJpMXkvenFYaDBkT1R0bFBQL09FQkIvVU1yUVY4Ritj?=
 =?utf-8?B?TmpnK2xRZ2V2MVpRNjdHZDdTVmV2QlBiWVo3bjB4elBTVjdkYTc1M3NmVDBR?=
 =?utf-8?B?RUpmdHhhdWZqM291SlpURSttLytvU2tSN3RhY0h3UVRsdlhscm9zTzYzZGtz?=
 =?utf-8?B?Z0R0SEdNUVhJY2xvbmNtZmdzY2g4cGsxRDVLNm1XRDdpVFd6b1JXcnZ5NVV6?=
 =?utf-8?B?YVo3TUNrREN3TGVzSWZ6REVORFFpVXUzMVRpYnBLbTlHdjJKOEVVOTBOMlE5?=
 =?utf-8?B?TnhPdkNrNXd1bmZvVXRlQlBnb1M1aHZuMnhsSHNjV1lyMkU4ZUpGZlk5amFS?=
 =?utf-8?B?L2tOVksrR1lkZ3R2VnRZY2pQSkY2aEhQZjJhZ1gwc3ZjQVhyV1ZkcUJvc2ht?=
 =?utf-8?B?VW90SHpKN3hGbE94UWlOeU1Nb3kzaTZsYjdXOC9kWkR3YlpvTHVsK0lKUzY2?=
 =?utf-8?B?ZGN6cnJjZ3VGUlJvUjBMdTcydllmazN3M3dZTmFhS0lxY2R5d25FbjB2V05k?=
 =?utf-8?B?bGl1eEIyVjRxM0sxeVFJbmwvSXhOVEtkVnZ3MDIwUE5lZ3oveUtBWEEydlVL?=
 =?utf-8?B?WllGaU1rY0NWcnpTMExsQnlkYkVuWllvOGlYVzBuRWE1VjdYK21FNzcwSEx0?=
 =?utf-8?B?TWsvdytOQVhDdU0yVCtXeGtheGo0R3pWNGhhWUlFVXIvVVhvTjFlR0hNV2Y3?=
 =?utf-8?B?YmxZRjdQdjh2M3cwRUxYYkFibmcwRmdEM00wTEZMazAyZXpobTRVdVhDVmE3?=
 =?utf-8?B?V1lBQ0hZUlhUQlBoTHRDaGczT2pieHVndDgzc0NXeDFRbERDQllOUGV1Rm83?=
 =?utf-8?B?YkVGSEMxWEsrZ3ZHL2JMOTRyZWwvUk0yNVNDd285K3RVUVFHVEN5dlpraGlG?=
 =?utf-8?B?NkU2Umo2S1lkbzFaZU9TY2NhYS96SWdvL0FiVDdqMzhzV3ZMb1ZvdVZOVVhL?=
 =?utf-8?B?aTN3UFU2Zkg5dERuTE9qQmxEOHpnVVkvVlR6eWlHWlZrS2JTempiNENJK0hV?=
 =?utf-8?B?VUdRczFhb3JENGFkaGI4RDZteGJwaFd5a3hlMWRwSGN6NzgxdmdPTVhYcWpM?=
 =?utf-8?B?TThSbGVpZExCN2VhVmlTZWZJb0VuaDZzaEFiNXR4L0wzYlBYNE8zSmRrbWxV?=
 =?utf-8?B?Z1QzU0w0TVRwejV6L1g2L1pZdE1xdUhDSUhiUEtyMVhrVUNGY2cvZWFUaHg1?=
 =?utf-8?B?Kzd5TnI2WHA3ZXluMS8wb3RXUUdGM1pMMWhsZ3NVT3Z4ZWRpYmRGTzBNUTda?=
 =?utf-8?Q?yVyJKiEJGYr79cX0q7i7ZyAXPgm6P9ZHnVe5Ve2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5070266B2585604792301D3B30611892@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4539.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d446c1-742e-4b2d-4c33-08d8ce39c546
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Feb 2021 03:04:38.9807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BtM0sDPA5+F6lNiBTx5P0OwOId7cuE6oqD8uEilJs6q4k1S2xdMyiLYXqIAOFs/aidBnj+XUMH0mzLDUh5RjOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2192
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

QXBwbGllZCBoaWdoIHByaW9yaXR5IHBhdGNoLg0KDQpPbiBXZWQsIDIwMjEtMDItMTAgYXQgMTg6
NTUgLTA4MDAsIEluZ2EgU3RvdGxhbmQgd3JvdGU6DQo+IFdoZW4gYSBub2RlIGlzIGNyZWF0ZWQv
cHJvdmlzaW9uZWQvaW1wb3J0ZWQsIHRoZSBuZXcgbm9kZSdzIGFnZW50DQo+IGlzIHJlbW92ZWQu
IFRoZSBjb3JyZXNwb25kaW5nIHBvaW50ZXIgaW4gdGhlIG5vZGUgc3RydWN0dXJlIG5lZWRzDQo+
IHRvIGJlIHNldCB0byBOVUxMIHRvIGF2b2lkIHBvaW50aW5nIHRvIGZyZWVkIG1lbW9yeS4NCj4g
LS0tDQo+ICBtZXNoL25vZGUuYyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbWVzaC9ub2RlLmMgYi9tZXNoL25vZGUuYw0KPiBpbmRl
eCA0YmMxMTMwOWIuLmU4MWFhODJmZSAxMDA2NDQNCj4gLS0tIGEvbWVzaC9ub2RlLmMNCj4gKysr
IGIvbWVzaC9ub2RlLmMNCj4gQEAgLTIzMjEsNiArMjMyMSw3IEBAIHZvaWQgbm9kZV9maW5hbGl6
ZV9uZXdfbm9kZShzdHJ1Y3QgbWVzaF9ub2RlICpub2RlLCBzdHJ1Y3QgbWVzaF9pbyAqaW8pDQo+
ICANCj4gIAlmcmVlX25vZGVfZGJ1c19yZXNvdXJjZXMobm9kZSk7DQo+ICAJbWVzaF9hZ2VudF9y
ZW1vdmUobm9kZS0+YWdlbnQpOw0KPiArCW5vZGUtPmFnZW50ID0gTlVMTDsNCj4gIA0KPiAgCW5v
ZGUtPmJ1c3kgPSBmYWxzZTsNCj4gIA0K
