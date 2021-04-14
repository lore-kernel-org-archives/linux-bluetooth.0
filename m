Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4CDC433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 06:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADB8611C9
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Apr 2021 06:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349053AbhDNGEv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Apr 2021 02:04:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:13569 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348555AbhDNGEt (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Apr 2021 02:04:49 -0400
IronPort-SDR: s3Cc/9IU5Ln1EjQiGdKbdfH1NfuyWjINsT7rZh78G4ORmTk3MYDDIxZP4X0qgy0tyNWGuR+Oi3
 z0cOLiFIK5MA==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="194137653"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="194137653"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 23:04:26 -0700
IronPort-SDR: AH04xp8wmqHguHPv1d9S0ETFv6abgabF51ytmzQrS3t3U/bQXEsyxSq4CyMyApI1KK/EKwxHU8
 ESTK7HTZLgMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="452305827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 13 Apr 2021 23:04:26 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 23:04:25 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 13 Apr 2021 23:04:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Tue, 13 Apr 2021 23:04:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Tue, 13 Apr 2021 23:04:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOfXkSU8k+J3YRDh0cWko7mn4BgeNIAuQNUFFlXoRTrBk63DQ0l3/uiZsO5UGCaiQQZJZ1nevr44A2E9NDNbCXJrY9md89t6/yUKB3y1nUTQ7JPpBA46CGEco/GXs/CfLBDFNlCsIVyqidPiEmjB/spYl7gzGpABe2o09TGlhFJDIFsckBmzI0SD5eTXJtQQJIoMK2ksqASWb98WQbcVN/CTl3FM6CLWqJ/1iEs3oDCS23HGcLJtKXCmvwc1/7Gb/+q0if/1t4wPQGq4zz4qrToLGtr/8XihakbfmShWFpPVlKHzSZhD6RNBhumgMJlsY2sZC1u2QropLWadx00f2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znBxOxA4K6lt17KUcwbU6/PC0NXpJqJsIu9jyyjYvKE=;
 b=LvqyqJFnfm07JyDsOwXsX0b39cw+cwB8wp7W2M6vvaWElWzgpqygaCa4UNNkx8m7ErIj1JJm9vgpHCr/Ib5SzyFaUdYPLqxkE6nm0CT4iFTBYRQKeCtN9c4/p1MntNMtRJEy2NR5Jkh66a0ub5NMmCb6FRQTkeLMBHR1OAXBQZwKbCr3/wj4ByYHy3ct0MN9FYxeLwmuLDu13U79QncdUru0iaPUQgAMHPKDrfVE54TOW/fJd4b1d9fRSuymVNUufHBU6OTgxmBj7mPHIJbKtqm6H3d9zsUHszcnwjJh4tCQx/CeI2c1d5t8l8oNPcCrfRr3+VPVON64+rja5eCfaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znBxOxA4K6lt17KUcwbU6/PC0NXpJqJsIu9jyyjYvKE=;
 b=WcoC++xptKOHAF4cH4ceFAftMm2ZSn8sKwWUtZRkBisS2MZopfl6BZNimbQF3BYECgNuHWFUcuHYhCR4Jk2+tliH6Ox/IivtkDiHkicFfpMPWFFB0Q4HtMjt9EHlcpcP8kIK77y3cVXZq5x0kzbM0KN2mCW5VR9jofWKt5anOPU=
Received: from DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) by
 DM8PR11MB5590.namprd11.prod.outlook.com (2603:10b6:8:32::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16; Wed, 14 Apr 2021 06:04:24 +0000
Received: from DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7]) by DM8PR11MB5573.namprd11.prod.outlook.com
 ([fe80::38f3:7a5:2cec:8ff7%5]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 06:04:24 +0000
From:   "K, Kiran" <kiran.k@intel.com>
To:     "K, Kiran" <kiran.k@intel.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     "Srivatsa, Ravishankar" <ravishankar.srivatsa@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>,
        "Singh, Lokendra" <lokendra.singh@intel.com>
Subject: RE: [PATCH v1] Bluetooth: Fix alt settings for incoming SCO with
 transparent coding format
Thread-Topic: [PATCH v1] Bluetooth: Fix alt settings for incoming SCO with
 transparent coding format
Thread-Index: AQHXLJhkI71TXOARq02S6euvLW0HZKqzjqUw
Date:   Wed, 14 Apr 2021 06:04:24 +0000
Message-ID: <DM8PR11MB55737FE71CE1AB95DAB988CEF54E9@DM8PR11MB5573.namprd11.prod.outlook.com>
References: <20210408170159.19510-1-kiran.k@intel.com>
In-Reply-To: <20210408170159.19510-1-kiran.k@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [122.179.93.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d896180b-4afe-42b1-8ffe-08d8ff0b2771
x-ms-traffictypediagnostic: DM8PR11MB5590:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM8PR11MB5590E7B845FB0359A67FCEA6F54E9@DM8PR11MB5590.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Kp3eqCmyV9g8npAbo1AeHPpkf7Q0sNKIZag27qRansnF+OqEymuAmu2vhpWnO7pxFYBiFFdz8oZ+YxnnGTEvlCXxkyp+tgfgWzQMQBmmZUpF4wftn3lJnwfTtjCp1FZ+NZjpmxzw6cneVRz98qwknThbBVAJ41cCbxil8SMuNWrhN7UbMOTtDjIBQ+1ob/AUaBQ8nKwyTYBe795BgqrNqAw28FxsEn3cyn0kuex2Y0qZdo/LtX/AXvwh1UOZJ+A2fY+ryNsuaro7HD88v4ua7dS9ZUc6dqTssh0CKQwRATj/qzmd/bPze4M1KZao1zy0JAOxcSZ9rQLJca7fx9ursvZPt81ZIBK4D0CQ+FUP/ztTYQBE0qJ4GOwbtRCpn8O3q6WHZcsGp4Q19jnmU8B/zIPrnW+XBL/1H9jcgqJ5HbSb3EOpJf/SSEw0rszse3BUN9VDXmxIkNuugiQQzCkcZfxmXYjX+0dXTJ+UO28ufcBschfNmTAh3Y8OxgNqXixBj5uLOzkvlk+2U45T0tqN7lsTn3UvlhxZIdIcdRtPJm8SXxfBr3ZKxjGJlUpI7hnQMIZHnvbnYv+neXsAR9zQOhKKDgOJxlwWFnLLkeM49UI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(366004)(136003)(8676002)(186003)(86362001)(8936002)(4326008)(83380400001)(107886003)(53546011)(6506007)(52536014)(5660300002)(2906002)(122000001)(9686003)(38100700002)(110136005)(54906003)(316002)(66556008)(7696005)(33656002)(76116006)(55016002)(66446008)(64756008)(66946007)(66476007)(478600001)(71200400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zfUpwPR8tfUdHKdYCqfMYK8RZgj51S+SGX4KpZAHTpTMJWYBk65ec09MRkOI?=
 =?us-ascii?Q?5ofXMxQc7MhQRucLWs0Xd6fi1qO0rhA36b4Cv0fbhPHogAkXQpDbM3uUtly6?=
 =?us-ascii?Q?a8USN74QZiVN0f9yAHZ6slHcPQaV2BTNXxOxNaawrzdw0KQyRZdUrexPfvJT?=
 =?us-ascii?Q?RXuU1NKpJ+0ZqQrNKsg6o2igxDwHK/7KPgRpspDPsoy09/8DypWBhnDfeP5R?=
 =?us-ascii?Q?o8LJB55UgTlQjAGzXiggfjOjmYTNXVJJM0pR0hPEKqE/19fBtKQ6SBQSAPmd?=
 =?us-ascii?Q?yMsF9qoqUeGVqRN9OmpQy1CsA8dUHoyZv/oiy5H8OStGIqqlR6VxLW5l5Tse?=
 =?us-ascii?Q?s3DAslHNTLsM3RJ26plptxNum+g1RcM3DfFrlD8W95EibQO583lmwXpF1U4t?=
 =?us-ascii?Q?4JCSIMa7AGOi5ikWnBCbhwueIfexqiPlyVNRebbW4o0IStwICMBHIXFRkQAI?=
 =?us-ascii?Q?xqhdtu9xH5PSmnJOSosiKjgVhqDbc7+HVBIaJWLgMbnnQyjSx9mZYCan0Wwn?=
 =?us-ascii?Q?uR3WkC5K6Ee0S+mrrl12lFLWEXLuJ6f1GQcT0wJA1fS8uoVdY44UXpYWwHJ/?=
 =?us-ascii?Q?iPqKQIlSZf9EzomzBF7pG8A0E24DvWW+X6SrYGSkNlAWYp+Hb1P92YP/Pc2n?=
 =?us-ascii?Q?jqjGlLNs0wZAsmgxP/wsVTLFXJbdtncMahY4iHbA4bq+oBXhb+8Mr9LPQjgp?=
 =?us-ascii?Q?+VNVcNDKUgt6pG14n/HnEh7XR2NSKM+fAvuCogPX2WSaJeHfjsUyH5NzNAzW?=
 =?us-ascii?Q?Uw67waSKQmUjHYr7LgURaGvbPAdmKAaUzmauLiXRG0/BApmNQApOeqnA1cNo?=
 =?us-ascii?Q?CImiAJlPtK6O5yygIIMV/EXT2HuD9brc2WDvP0OWJn1OGvaFtBXa/Q5vUo1L?=
 =?us-ascii?Q?yRSIT8sj9oogMeg0MZR21DwWgPtVyPxPAbs1EVqPmDbTxLtTbauu/vij7EhG?=
 =?us-ascii?Q?oQuPT8DGx54AJd0m5A08zHRoNAxg7YtbHAqX5wSFyVbABAzI+xL5nuYWZZRe?=
 =?us-ascii?Q?rqHNUL5ILyPGqQNLyafkjCEiPSBpt04Cf8UBN/BbonjvgQlyiHWMtdnuSItF?=
 =?us-ascii?Q?+RBhGsZy++FOYUdYnT2O/6jytFLADs0d5xgwvMbqcJw4Khg+7Me/w3BEbhWN?=
 =?us-ascii?Q?dKOhyviD9gPH9UYohKX/ZE8l5Fuq7pOQziZmwwF73AD8Lw19J7t7zPjSAJi8?=
 =?us-ascii?Q?vCXs7JAYLHKJK46ZoS4xPhiJk4xz7fYSu81kOvjVDMlEXumIDztHx5m+pwcw?=
 =?us-ascii?Q?QLqyyWdBfzOn6npr9m/rBGQjkdw80T7VCxPJa63xKBYyVmNGoHWCuqcEk8tO?=
 =?us-ascii?Q?vyXYgsoIIQ5RZnLWFotQJvkG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d896180b-4afe-42b1-8ffe-08d8ff0b2771
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 06:04:24.3356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dtNffURRQSGwRx1w8BjcoyzhlUpDxV4lGUPpp+aRS4hTyNeD3DsEPbyuQsE1M0rTKnfp0/PvUT9gb1Iob+4mwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5590
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

Gentle reminder.

Thanks,
Kiran


> -----Original Message-----
> From: Kiran K <kiran.k@intel.com>
> Sent: Thursday, April 8, 2021 10:32 PM
> To: linux-bluetooth@vger.kernel.org
> Cc: Srivatsa, Ravishankar <ravishankar.srivatsa@intel.com>; Tumkur
> Narayan, Chethan <chethan.tumkur.narayan@intel.com>; K, Kiran
> <kiran.k@intel.com>; Singh, Lokendra <lokendra.singh@intel.com>
> Subject: [PATCH v1] Bluetooth: Fix alt settings for incoming SCO with
> transparent coding format
>=20
> For incoming SCO connection with transparent coding format, alt setting o=
f
> CVSD is getting applied instead of Transparent.
>=20
> Before fix:
> < HCI Command: Accept Synchron.. (0x01|0x0029) plen 21  #2196 [hci0]
> 321.342548
>         Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Max latency: 13
>         Setting: 0x0003
>           Input Coding: Linear
>           Input Data Format: 1's complement
>           Input Sample Size: 8-bit
>           # of bits padding at MSB: 0
>           Air Coding Format: Transparent Data
>         Retransmission effort: Optimize for link quality (0x02)
>         Packet type: 0x003f
>           HV1 may be used
>           HV2 may be used
>           HV3 may be used
>           EV3 may be used
>           EV4 may be used
>           EV5 may be used
> > HCI Event: Command Status (0x0f) plen 4               #2197 [hci0] 321.=
343585
>       Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Synchronous Connect Comp.. (0x2c) plen 17  #2198 [hci0]
> > 321.351666
>         Status: Success (0x00)
>         Handle: 257
>         Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>         Link type: eSCO (0x02)
>         Transmission interval: 0x0c
>         Retransmission window: 0x04
>         RX packet length: 60
>         TX packet length: 60
>         Air mode: Transparent (0x03)
> ........
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2336 [hci0] 321.=
383655
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2337 [hci0] 321.=
389558
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2338 [hci0] 321.=
393615
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2339 [hci0] 321.=
393618
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2340 [hci0] 321.=
393618
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2341 [hci0] 321.=
397070
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2342 [hci0] 321.=
403622
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2343 [hci0] 321.=
403625
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2344 [hci0] 321.=
403625
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2345 [hci0] 321.=
403625
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2346 [hci0] 321.=
404569
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2347 [hci0] 321.=
412091
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2348 [hci0] 321.=
413626
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2349 [hci0] 321.=
413630
> > SCO Data RX: Handle 257 flags 0x00 dlen 48            #2350 [hci0] 321.=
413630
> < SCO Data TX: Handle 257 flags 0x00 dlen 60            #2351 [hci0] 321.=
419674
>=20
> After fix:
>=20
> < HCI Command: Accept Synchronou.. (0x01|0x0029) plen 21  #309 [hci0]
> 49.439693
>         Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Max latency: 13
>         Setting: 0x0003
>           Input Coding: Linear
>           Input Data Format: 1's complement
>           Input Sample Size: 8-bit
>           # of bits padding at MSB: 0
>           Air Coding Format: Transparent Data
>         Retransmission effort: Optimize for link quality (0x02)
>         Packet type: 0x003f
>           HV1 may be used
>           HV2 may be used
>           HV3 may be used
>           EV3 may be used
>           EV4 may be used
>           EV5 may be used
> > HCI Event: Command Status (0x0f) plen 4                 #310 [hci0] 49.=
440308
>       Accept Synchronous Connection Request (0x01|0x0029) ncmd 1
>         Status: Success (0x00)
> > HCI Event: Synchronous Connect Complete (0x2c) plen 17  #311 [hci0]
> > 49.449308
>         Status: Success (0x00)
>         Handle: 257
>         Address: 1C:CC:D6:E2:EA:80 (Xiaomi Communications Co Ltd)
>         Link type: eSCO (0x02)
>         Transmission interval: 0x0c
>         Retransmission window: 0x04
>         RX packet length: 60
>         TX packet length: 60
>         Air mode: Transparent (0x03)
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #312 [hci0] 49.=
450421
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #313 [hci0] 49.=
457927
> > HCI Event: Max Slots Change (0x1b) plen 3               #314 [hci0] 49.=
460345
>         Handle: 256
>         Max slots: 5
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #315 [hci0] 49.=
465453
> > SCO Data RX: Handle 257 flags 0x00 dlen 60              #316 [hci0] 49.=
470502
> > SCO Data RX: Handle 257 flags 0x00 dlen 60              #317 [hci0] 49.=
470519
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #318 [hci0] 49.=
472996
> > SCO Data RX: Handle 257 flags 0x00 dlen 60              #319 [hci0] 49.=
480412
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #320 [hci0] 49.=
480492
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #321 [hci0] 49.=
487989
> > SCO Data RX: Handle 257 flags 0x00 dlen 60              #322 [hci0] 49.=
490303
> < SCO Data TX: Handle 257 flags 0x00 dlen 60              #323 [hci0] 49.=
495496
> > SCO Data RX: Handle 257 flags 0x00 dlen 60              #324 [hci0] 49.=
500304
> > SCO Data RX: Handle 257 flags 0x00 dlen 60              #325 [hci0] 49.=
500311
>=20
> Signed-off-by: Kiran K <kiran.k@intel.com>
> Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
> ---
>  net/bluetooth/hci_event.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c index
> 016b2999f219..47166cea68bb 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -4404,12 +4404,12 @@ static void hci_sync_conn_complete_evt(struct
> hci_dev *hdev,
>=20
>  	bt_dev_dbg(hdev, "SCO connected with air mode: %02x", ev-
> >air_mode);
>=20
> -	switch (conn->setting & SCO_AIRMODE_MASK) {
> -	case SCO_AIRMODE_CVSD:
> +	switch (ev->air_mode) {
> +	case 0x02:
>  		if (hdev->notify)
>  			hdev->notify(hdev,
> HCI_NOTIFY_ENABLE_SCO_CVSD);
>  		break;
> -	case SCO_AIRMODE_TRANSP:
> +	case 0x03:
>  		if (hdev->notify)
>  			hdev->notify(hdev,
> HCI_NOTIFY_ENABLE_SCO_TRANSP);
>  		break;
> --
> 2.17.1

