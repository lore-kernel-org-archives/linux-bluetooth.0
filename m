Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B266C4707F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 21:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E74656128D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 27 May 2021 21:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234316AbhE0VJy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 May 2021 17:09:54 -0400
Received: from mail-dm6nam08on2063.outbound.protection.outlook.com ([40.107.102.63]:62593
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233387AbhE0VJv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 May 2021 17:09:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TW3QsGuvQPCJ/xL37UGHASc9a7Fz0glbRSHYzP2PeCPJaVmna/2l0CAkU/diJgrMFvV+aAqoQMJrte4XxII2AxHaLCWXoHbV7kI4dugSkg4h9ty7DT7rUN9G1eaM4vFr14dRFcW803Qus+/rB3zF3c0fBZoGG3jNKNaqaez6UQl6alG/dkokxXfa/0QK8CwmhqOY1UX9l88mN/98SFgZYjkDmFIPDsE7JexiMCOVGbAfWEedFLIaXBpPJRfGy4EKUcQF9fz7NEf1uXsVXtT8505gx3mRRz/6fJSXhFpdy2SwALdbw69oHxWLWynJ/AzX5XtmDlxkyZbiF3Z3B140Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT/t5t410oWDuMi7LXSEe3net0fG/3h9/QpwfuV+OwE=;
 b=n9pbCUakAlnknDM/0gtoiCDyA61fEenCWyKpLEkJIPPRESJnLRPnBti8ZqVb7LQXS2P91K2yJ5YvNSPAlawKX01+veuc+BV9uyaVJvDW+fmq230MwopI3hy7JzADmIQHRoceU8TfvJUJohcBaL2zl9Othx8KQj1t2mXTGArNSDLzigdT06QpNAH78KDEwvQlt2EpO8cuRxxZ9Si7v7zOCYl5geRfV+e3J8gcp5K8JqgC4DoqVfyuQeuLWcfbvjv3O23HvlF+044ATrrIPnF+q3P29oYYsmF5BjgU9/s3b2KnPJf8cNe3Vue1w993X8YounId+poJDiHqLnA5Jkunmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=infinera.com; dmarc=pass action=none header.from=infinera.com;
 dkim=pass header.d=infinera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infinera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uT/t5t410oWDuMi7LXSEe3net0fG/3h9/QpwfuV+OwE=;
 b=FLQJICWK3khUJt7a+qE+IhMAqJL44SPGC6ySJt7T46MrEl8vN5wEGYgEAbWpQ15dw9QWPBM7Y5d9GR4rVHbyaAhu/mC5I54bvnfeZOV8NnWWw3j48U1mCglDaJrROF9xEJT3vbL9JZzXOtL8LBQn90K/ifgdjjSXBx4ww2j83+Q=
Received: from PH0PR10MB4615.namprd10.prod.outlook.com (2603:10b6:510:36::24)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Thu, 27 May
 2021 21:08:16 +0000
Received: from PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::5021:f762:e76f:d567]) by PH0PR10MB4615.namprd10.prod.outlook.com
 ([fe80::5021:f762:e76f:d567%7]) with mapi id 15.20.4173.021; Thu, 27 May 2021
 21:08:16 +0000
From:   Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Topic: Please backport BTUSB_INTEL_NEWGEN to stable 5.10.x
Thread-Index: AQHXUzxp1Hmy/K78mkezsPdlt1nyqw==
Date:   Thu, 27 May 2021 21:08:16 +0000
Message-ID: <cdab6dbada26fe31d21bb133ef087574c85c1411.camel@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.40.0 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=infinera.com;
x-originating-ip: [88.131.87.201]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43c91d7c-2a33-43f3-6c57-08d921538bfd
x-ms-traffictypediagnostic: PH0PR10MB4421:
x-microsoft-antispam-prvs: <PH0PR10MB44210CAE611DC53B6B577816F4239@PH0PR10MB4421.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LoMCyn/OnKQ7PcsmwBaxCZpvkvkGJ7fSdT6H6EZiZnuPqXkuLb/GMLAXWOp9+SqLDDHuSoTVHJWTs2ptxyoVfj/BPgiSRcLmPqDWy68kyLIpACk67yPWz3gp2wht8N6zI1RzcDDGDemu6YTUGR9AXihdS4tdQ0PFBGNu2RqjA2K3yq+KjwX2FsJOdKFMlHczR7MUAlrxN9V1aYDHUZMaqbRxUGqpDKYKzhtGAWN9lSY8O8LeAicvs5QFYTLmQzK7G1qVtOiP9jbWkHTZA7gqebL77nJQ6Wtut5BHZkLkNNc8XAQNGDMKVM2g204apYwKATMOfqVK6SO35DjV0Lz4PHqSZsThG6dPGMcc69QjjN0Ioxm7X4ZTcz+Wfu1Pdpe4YRAe1MOC8bRnM761d0GFUkDnCgZ23cjCFIf5ikIhlq/mOYoYkTaFoQsAskCFK4sibSxVVGPJB/0vkdZV3fKXyATEqesBDMgt7CFFyyymv4wJhY8/WoeujRXZj25wq3kqnvemOVn288jekITO2OsWcJxGoOR+9AwB9fSzNx7pzP9BeyfDMhxw/rQXI2HXEwzHoHcUvHnqzOwA0viCEwUBclahx7RjIKLmm/6L5Qcg56U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4615.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(71200400001)(186003)(8936002)(86362001)(66446008)(66946007)(6506007)(8676002)(66476007)(64756008)(66556008)(6916009)(91956017)(6486002)(76116006)(2616005)(36756003)(6512007)(2906002)(316002)(26005)(558084003)(478600001)(38100700002)(5660300002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?Mm9JSWExUy9sZCtqLzlFUlBYZ204cHJQcWZqYVNtZTZGOCtkSFM5QUFEeDJy?=
 =?utf-8?B?U3NkY2FhVHZtVDJPWDZONTFCZ1JqSStMeXBKQXpDL3dBdjlHS09mQ2JFOS9j?=
 =?utf-8?B?WjJuT2tTaUorK1RSWVB1d1ZpMTVjSjZ2eTBIVHZFUGV0Yk1NS2MyaVFSNXhF?=
 =?utf-8?B?VFMyWWlyUWZXZFZIY1laVHMyK3doR1hrZXd2R2x0WVQ3enhrekNxSFY5TEln?=
 =?utf-8?B?NFJpL1hDMTVSNmdkbGYxdjY2dHVMNE1JWWtacW5VNitpUnhidFcxaitWRS9o?=
 =?utf-8?B?Z1NPQkxGTWVPRXNwOGxOd2krTkN2UnY3K3NwR0Fsa3Nac0FaOEZIdjNua2sv?=
 =?utf-8?B?Y05vVkUyQUNiQVpybjdHMTVkOWhuMjVBbmpHOVFBTEVQaG1Jd3lqYVVoQmxs?=
 =?utf-8?B?ejNMVktDTzZZMmJsS0R2WFk3dks5V3VCanBTeVlWRmdYZ1dtQVYxR1RKaENv?=
 =?utf-8?B?cWRnbUo3dnQxbjYwanA2YjFjS1dGaXA3WnNPQ2twUEtrYUcrVW1ISVFqN0xV?=
 =?utf-8?B?N0N4ZU15UmxyQW5MREpIcVczeUppY0xLaTVtaXVxRVgzT1F0V1lISUtJNGpI?=
 =?utf-8?B?bkNwemY5UnFZUXdiU3lRc0tmeHlueE40VUloSy9TdE1kY0ZQWmVySEZtUHBu?=
 =?utf-8?B?MWgvRE1reUJ2N1RXNFRJaTlMQmV4UGNNcnpQaWVTcHl3SzZzZU92SEVWZDFu?=
 =?utf-8?B?aUJsd2xjS0JWZTdHVlc0L0UwdWYzQkJZU3ZsUzhPSTV2dURNWUtobzJXTU1Y?=
 =?utf-8?B?WDZkSlR0UnJ4UDh5bWtDcmdHNEVkNGFIVWtDQllQazE3ZTc4enZLb3d6ckRh?=
 =?utf-8?B?MmJpaXdkZWJSYW9nc0Y4K3hjdVpraEU0bG5qV25lQllRMUxubVpjVFA0YU4x?=
 =?utf-8?B?T1ZzbjFGbDlHR2ZPSktMWFZIRHY0SW5sZ3YvVE5tNHJKQnlBSnoxSmduLzJu?=
 =?utf-8?B?TUZUZ09EWDJNVjZsYjZpdFFaZzZvVUI3VElhVDgwTXg0QVdMNGRMZVl3QU1n?=
 =?utf-8?B?UmhwWWZRWHZQRFU5S1l4TEZ0RFVIUXVGWHU2Yk9reTRMUE5qczAxU0hlYmJS?=
 =?utf-8?B?aExIWWhjQUsrQXI5TERLMWZEY000QmJ0ZUgzK05GT01PWFFnN1BZZXBCRk1k?=
 =?utf-8?B?Rnh2VU1QLzJzTEorelZDdTFXOXlJcDVWK21yZStVMUE4K3k1NmMvTytKRjhh?=
 =?utf-8?B?dlF0NXl0MHZBQXZwZFVLWXN2ZkJiUTlMOXFaVUxYQzB1NFVkQWh6VEQ0RWtN?=
 =?utf-8?B?MSszVzdCUEk2cE16UHRqb09FRDZscnZPNkN4d0ZSYXdKSDhOZHRGVGJiNzNN?=
 =?utf-8?B?bmtXdHBBR0xxNkVZRlE5YzZ4VER1VjJncE5QODkrMlVoVm1YQjlxZkhIUmRD?=
 =?utf-8?B?UGwwNDVVOTFmSkRNd2ljL1JEbXdGaUVodmNTeWpPeHdpTUJHUUlaSmQzMVc2?=
 =?utf-8?B?SlBiYUtEeUtQd0M2cEFoRExWVnloaUFoOEZFMEs1OW80UGlvSytiT1N4azV5?=
 =?utf-8?B?STl2cmRaRFJkc0JjMmdrbWRDZFJVR0JLbVJveTViNXd2dUdaTHdYeVdTQ2dL?=
 =?utf-8?B?MTNLS3ZONlhHU0ZVOEM5cUw4YVFoME4vMlIrTGRRTmJCMzlXOURxdTN6T1RF?=
 =?utf-8?B?MWVBV3BoaVRwYUJ0bWZVa0E3Uzc3WjljcVJLQlhubWR5NWYyZWJqemRhc2pQ?=
 =?utf-8?B?T2hPLzJDTEMvanhId2hZU2RLZmY0aEVhd2hTWjJBK0d0VFZjRXZnT1pIc1hU?=
 =?utf-8?B?eExxUEhLdFlKbWwrSHBrUkMrU2dkcjVqQnFlWERYeURtbjlhWEZodm5EN3hN?=
 =?utf-8?B?dnUwWDRvSHdMMDVCeERVdz09?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <228757E3BB31C74DA2B5849793BDDA9B@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: infinera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4615.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c91d7c-2a33-43f3-6c57-08d921538bfd
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 21:08:16.2497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 285643de-5f5b-4b03-a153-0ae2dc8aaf77
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stwA90V1RPx4VFarJU8IyuRzW3fVlDOUa0CvWcfLyOwcdNT/T+OWfNMspe8YhMenGaFj4sstswwotXqe1mcE9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

VGhlIGRldmljZXMgYXJlIHBvcHBpbmcgdXAgbm93IGluIGxhcHRvcHMgbGlrZSBMZW5vdm8gVDE0
IEdlbiAyIGFuZCB0aGVyZSBpcyBubyBzdGFibGUga2VybmVsIHN1cHBvcnQgZm9yIHRoZW0uDQoN
Cg==
