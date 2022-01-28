Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ECAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 10:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242760AbiA1KGR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 28 Jan 2022 05:06:17 -0500
Received: from deltahqout.deltaww.com ([113.196.174.111]:57828 "EHLO
        deltahqout.deltaww.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiA1KGQ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 28 Jan 2022 05:06:16 -0500
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5C72512A352;
        Fri, 28 Jan 2022 18:06:13 +0800 (CST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=loytec.com;
        s=Delta2019; t=1643364373;
        bh=MPD3Wv8zEioXXUXWpcdIF8JLAvnn8glE8dWVg4daVaw=; h=From:To:Date;
        b=bw08ULDpD/If6ICZiHYeFL2x53yevFLcwTwtae0+Dm+jINS8G4cmkT54bTDfyj36e
         n4j6sarKN6l6WNzPFkFtcnf8ZuGDd5R3IqmgtLOR504m5yTq36CfLtsIdOGyO7exSP
         rCJwC4bdp/qjeqojJD2SCprSqkVsqjVK9vEWz5ZY=
Received: from deltahqout.deltaww.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4642A12A308;
        Fri, 28 Jan 2022 18:06:13 +0800 (CST)
Received: from TWTPEDLPDP02 (unknown [10.136.156.145])
        by deltahqout.deltaww.com (Postfix) with ESMTP;
        Fri, 28 Jan 2022 18:06:13 +0800 (CST)
Received: from TWTPEDLPDP02.delta.corp (TWTPEDLPDP02.delta.corp [127.0.0.1])
        by TWTPEDLPDP02.delta.corp (Service) with ESMTP id 1827D167BA3;
        Fri, 28 Jan 2022 18:06:12 +0800 (CST)
Received: from TWPJ1EXHYBRID04.delta.corp (unknown [10.145.157.228])
        by TWTPEDLPDP02.delta.corp (Service) with ESMTP id 00DD3167BA2;
        Fri, 28 Jan 2022 18:06:12 +0800 (CST)
Received: from TWTPEEXHYBRID03.delta.corp (10.136.157.227) by
 TWPJ1EXHYBRID04.delta.corp (10.145.157.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 28 Jan 2022 18:06:12 +0800
Received: from CHE01-GV0-obe.outbound.protection.outlook.com (104.47.22.42) by
 TWTPEEXHYBRID03.delta.corp (10.136.157.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8
 via Frontend Transport; Fri, 28 Jan 2022 18:06:12 +0800
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1d::7) by
 ZR0P278MB0235.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.15; Fri, 28 Jan 2022 10:06:08 +0000
Received: from GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4581:b3de:6f25:8351]) by GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
 ([fe80::4581:b3de:6f25:8351%8]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 10:06:07 +0000
From:   Isak Westin <karl.westin@loytec.com>
To:     "Stotland, Inga" <inga.stotland@intel.com>,
        "Gix, Brian" <brian.gix@intel.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Topic: Bluetooth Mesh: Option to retrieve RSSI value from received mesh
 messages
Thread-Index: AdgR/qveFxHMZltZR7KeA1FkQqvEPgAJM5KAAAPizYAAfDVX4A==
Date:   Fri, 28 Jan 2022 10:06:07 +0000
Message-ID: <GV0P278MB012970D06C9CDCBF652BC61095229@GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM>
References: <ZRAP278MB014417E1D86BB8D4E82A6174955F9@ZRAP278MB0144.CHEP278.PROD.OUTLOOK.COM>
         <586e79c74800693d1a21d06073503b41828f98bd.camel@intel.com>
 <9b716d8a604268a62b4f50662fd6f6c669e8d6ba.camel@intel.com>
In-Reply-To: <9b716d8a604268a62b4f50662fd6f6c669e8d6ba.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=loytec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72f74cdb-84f8-46ac-17e8-08d9e245cd9d
x-ms-traffictypediagnostic: ZR0P278MB0235:EE_
x-microsoft-antispam-prvs: <ZR0P278MB02350C02497CEC12CB836A6F95229@ZR0P278MB0235.CHEP278.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: he9g8UW0EE/ZXMQrPJ1Pp+m3DOJx+yg994nzvh5u3oVFbdPep+KoMzbZSlUIdtKXVPCo7+FzazEiKCStQcrcdH9Odp9R5PBU8n9AyuiPRuI1RUKNT+BAW2lCPT9DRrz4bc9JZ04LQscGxpj4ge2BDz9131B2t7NvouZjYNDKx8h8pd/3N7Jet0VJzVXZ48s29VNmGVrTV3j8oK54+x3ZzOsPFkX6iKsS6zjME7ISnrCfKyx+trhDm+WkTN7iZ8yMp/mnjaBAPKIUuUccTogwxD4gso2huTeHeiEf4WROOuYzPfN1VeEUmFeVSy902lEJCGH6FgwLN/WR+ls7/9ngheXeIdfkDuEwjCjxHaJnycNToLTZHh1/sqqwW4/KsgPryL4GZwa7hDVU03zqRoETubnB3uGdTjxf5kvSgAfqP7SPyFqqDaQFcuFAi15Fa1ZdEpnS+b11hSPDvXtr6/67b5CEzXnHTFUxJZaw7a2gP64XftaeUjUo5mI7ANmNIZOCvGaVr8HY53YajTnWRHJDbAWnrTIC1G81IQEn4aWKBxrXl/M4JQQbRwXzjhswzGux+NocYyLxwaDUCOUMoj3h5bcFauY5PUpado+zOIUf6olVSI3W6tvRaC/Bj+FwOL1hb0qej/1odIiMAIZbBGcMRvDh593yxUkq0X8NqXsaBVIWSYM2iI77WFcQ0TC+Ckkr6tZKgHjJ10Hf7QDqtBr0vg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(5660300002)(66556008)(15650500001)(76116006)(66446008)(66476007)(38100700002)(110136005)(66946007)(8676002)(64756008)(8936002)(55016003)(86362001)(186003)(38070700005)(26005)(508600001)(316002)(4326008)(83380400001)(33656002)(122000001)(7696005)(6506007)(9686003)(71200400001)(2906002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TUZabUtMNEwzbGU0ZHJPb2g4RkNMb0U3UGZ1TWFYNGM1c3VaR3owY1lmNThK?=
 =?utf-8?B?RmFOeEw2UE04OTFzc213clMzNktEc0pQOFlRdEVlUW9XaHBYTS9rMzRGNmFF?=
 =?utf-8?B?Z0NRMXdKaEtadGxpcm1rRGJoRi9WUmpqdmg2YkV1NEpUSzZEUW8zVG8yWUtu?=
 =?utf-8?B?ajdPL1BIdWdPUU9qeFNBYjRVcmQ4SHd0YkZadk01QjZBaVdVS2YxcEw4Zno5?=
 =?utf-8?B?U1k1eWtHVjB1d2xFcmdlclAvT3d5RXREN1Exb2Y5OXcxSzNIa2JPR2VzdHJq?=
 =?utf-8?B?MWl3bTdxTlJSQXJlZWlrUTJORTJRd2J0VS8zeG4xVG5xdFhWdXBYb0pjSzdr?=
 =?utf-8?B?S3B1ZmJ4OG4wa29jZ0czZ1d4OXJ3VUMxRHA1UXNLVnRWRmc5OFExMzBoZVBH?=
 =?utf-8?B?aUhHTzRDT1BtSERPWE5iS01NK09YVlFkcUNoM1FjK09pb3E4TjVkT0hHSUFU?=
 =?utf-8?B?c3VRdG5Tb3d3WUFzd25JTncxR2N6d2lDQldLQ3grb1dIVzRCbW5PMVBLRWor?=
 =?utf-8?B?VDN0ZkUxRTc5SmZqWnovM096LzVJeFl3ZnBLbWM2TmJnRDJCN3l6Qnl5WjZO?=
 =?utf-8?B?YnlQU1podmVrUDRSMGxaTFdCaFVJYXBlRDBFNWpSUGRqSXVvUUU3aXJiTGNQ?=
 =?utf-8?B?UTFSQjl6TXZrak5GeHdLVThjbzRwSmZUZG9TaG9Lc2IzdktZRmpxWDZzWnIw?=
 =?utf-8?B?anlUVHd5MXIwSXJPNkxDRjVWQk8ySUkwNXhiNnFtRVUydUJzeDZRTS9Ma0tZ?=
 =?utf-8?B?MHgybXVKQjZheUI0enpYL1NXaXhaMHMwQ3RhZHdGLzgvWTZUdUp6UlZ0TDY1?=
 =?utf-8?B?TFl1Y3ZNY3FmNVdXMWxyZlhncjhteDY3SjZxUG9IVXV4TWxYcUl2aXl1VlhN?=
 =?utf-8?B?NUgyaVZYSlRianFnQk1qUVlCdFE1a0hPRDF3OG16eCtNT2ZtZVAvRld2MUw1?=
 =?utf-8?B?blNyaklQdWVqVmttSTRpZnNBZ3ZZRWh3NGNxOTBFZ2JzOFZpQ1VvUjJjU0R2?=
 =?utf-8?B?OStmMGVpOERaNmsweFpXM3JmMlB2VVRWWkJsY1pGeXMzczZVaWNycnJtWWp5?=
 =?utf-8?B?TUw1Nkx5MTB0akswdWwxbHNLQXlJc25YRloyTEVQZ0pJQy9GTFM0ZVVISmo5?=
 =?utf-8?B?Q2trU05DL3RrdWtkZVg1cm5QZDRqVkROSmY5YmlaR1lzdHhLcjRXYVJnWlVL?=
 =?utf-8?B?d1NTRVRJMlpReXN2b3hiZE5GNE5PbnFrakxqUmxIU1o0anpMbWhFSi92VTUy?=
 =?utf-8?B?YUxZUzFLYmVVa0FNNndFOTB6bnBIUUtjR2VWNmVDSVhockNjMVppcUxrL25q?=
 =?utf-8?B?dnh5bjRSUTJISXFMTUdkd1BqQ1p4a3ZVNG9udy85VGY3K1FGUXk2UlRkdmtD?=
 =?utf-8?B?Wk9Qblk0V2czWjBwL2o5a05BTjBReFJLUEE0OXcyOGUxUmorNW1VeGg1MWYr?=
 =?utf-8?B?V2prOGcxUlFOYUdvR0xsMWNrd1FNYlFuTFVuV0FYd0FOSmc2Sm9VWDh2cWlJ?=
 =?utf-8?B?SDN2ZitPWTdDMXVZUjVxN2hCei9Bb2dsR09pbFpHeW1IVjFjYnpJNjNNZGFo?=
 =?utf-8?B?YVBSaThTMHRVUHBtQWpjb1Avbms3SnNWUDZtaXltRUNZZE9WMDQ4eUloZ2VC?=
 =?utf-8?B?ZTdBWDNTWjNpSkVMZVVrS05IT3Z3VS95ekwvRHU4cFNNa2JqWWtSbWQ3WS8w?=
 =?utf-8?B?UVlIYTI1bDVaaXBuOTVseUUxV0VKMDdxK1ZqTk9FZGVLYjNJWkRiVHRvZjVS?=
 =?utf-8?B?eVQ3bi8yNnBSV25OZko0Qk1qWU94MU9iTDlkaEoyUnliTjgwSVpoelZKT2pj?=
 =?utf-8?B?bWpDWDBmL3Nlemkxa2xHMnZzcEI4SzRBMzg5bjVmbUVUTE5XV3liaTFISDIy?=
 =?utf-8?B?YmZrVVMzM08wc3lWUCtSMTdvOEY0ak1sZFpIcGhUanQxUkpHN1lKN00wSkRF?=
 =?utf-8?B?RDlrbHNqTlR5aEdnOVhUQVoxc2VoTzhPcEFTL0hmYmI3N0JzWU96dXgzS3Jh?=
 =?utf-8?B?SVRJdmZkQnZMRlkyNXJHdEZqYkpCQlNUUGtXckpwVWVJR2J3aUhjZDVxTEsz?=
 =?utf-8?B?K1MrSUNWbmNBR1FTRm1GaFFEd0NKQ0pibHFyWkNiY1YwSGtZMm1BclpTaVg2?=
 =?utf-8?B?N1ZpM3VKSC9QcTlyTEVwakFrcU94Vjgwc0NiU0lxcUdqd3BQN0lReC9QVnJJ?=
 =?utf-8?B?QlE9PQ==?=
arc-seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoPIXyIVbf2ba9FrvZZovmYGNpUATDuiZFgRGTAxyjIR76eFXsGyVbwlDXgwn3q5B8uAWzMqhd5MWZGPfPj41762m4M3O7UEmy8rKzka5iS823CzVH8//j98G9ZQQMnTuD4ngzOFA125Q13l4IC4AQefeccpljpTryX1fpeig1aH4XPiTQvmpP+6QpPsxbJ+rpO4Z3ipuZMFIPBoOtoEgKvwUSIoFcFH3A7hYdM3OeUtsuVZrmK4/H+5tPSBwHL+NClD2KQ2XCjl+2no6AWJ3eMRtCtmz+bB3jHCe1s44jMjCkI1LE01QyEGy7F048ummme+ZZYs0hIcbqrdarIk0Q==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSqZAw3Mm+s4oYcdSmVaHcCjsMTDl6z1GjS3N1aqE+8=;
 b=ATO5CUIgbiH/FVUDAWq/mkyBS3nLtO78pEVZC7o7w9AJwnRc983vkDY1DHht79iTVwREvyJ53hw1CNgUPoWhuFyvyyIWbQieJHoqCzqwb3OYj9isYyCFtzLC67IF3UfjV9N83QUODFY3RsDiStlWb6ErbYer1dfd/VuqVUY9dXgiUPDKDIKf+nshXfeSyUT5+FbZWQVuNLhfMmaTWapEwTijT9z/mTSsjLAg10qL0DDaVrjNJIlvHJ0kF6KdylrnC7vo3GRxGRlMMR7N0t30G5spy6LkjByA5PStZcRis6T3KQIWkM/OYQfv0f9S65wd6bqjrBfboz1ldpq8tm3j6Q==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: GV0P278MB0129.CHEP278.PROD.OUTLOOK.COM
x-ms-exchange-crosstenant-network-message-id: 72f74cdb-84f8-46ac-17e8-08d9e245cd9d
x-ms-exchange-crosstenant-originalarrivaltime: 28 Jan 2022 10:06:07.7694 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 19f25823-17ff-421f-ad4e-8fed035aedda
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: 5TFzvWytAZmtZCJWsTOEBJd992wZWcddDh4UdMLsnEGMuTeQ7KhAc0tEGnc0lITjriqZVgW3TqKRumf9rcGB/A==
x-ms-exchange-transport-crosstenantheadersstamped: ZR0P278MB0235
x-originatororg: loytec.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.2090-8.6.0.1018-26680.007
X-TM-AS-Result: No--10.048-7.0-31-10
X-imss-scan-details: No--10.048-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.2090-8.6.1018-26680.007
X-TMASE-Result: 10--10.048100-10.000000
X-TMASE-MatchedRID: qsaWi0FWcYukmOzIPyaddzMvozJIQnRWC/ExpXrHizygunpxJlu0X74M
        MKRy8RIdKn1Itv0A4niRu9XqNtIUVj4pt4Z7puj96HuV1BUJYPPNehe81b8uuFdiz1afoTLuts7
        /QvqhWClrcWJ8SpF2Y3fuU9v6XekOJhH6eAB9ExfylEfNwb6iLVwp6KDoOP25LX3qyf3ewG8DE6
        k/i6Y0RXFnQp1moK9xVKZk6yCJKfoIvo4vLR/wGnGg/sD2gWLWf/TIOqPsDIuuKuu7osK18SpMp
        4rJtg2jSC1SDxViogcuQwvXOhe6ZSzB69I7dfoFPE3khmVvHO7YUDvAr2Y/1/bZHXiKNkOMXXhS
        nmnfG0KZL/ZMYGYQsV19RvmRmaACdnHJSLgIbPURyVsAxhhjrKm9/6ObPjnDYCqC2izr39M/NIb
        qEKEJc7Y5H3/nMi/Z3lsQcg5rpVagVfDnBz2l8/SG/+sPtZVk9+PHtghP8GLB+Z+eWYE9bqxIjS
        YfsSaZqE3XJBQ36ovmPt+u0BVvXuA4UzWGh1IDLTHwnYOikQ0J2MLcsMaGgU7luHtaajINgsmlv
        iVpIWpbmmu0uF719ewy9ry+kHFqtCUKfxFPSAWTeuX4xo2DEL/I3arxTrvihFVH1g68LDajxYyR
        Ba/qJRVHsNBZf9aRPcCXjNqUmkUgBwKKRHe+r5m8HvudgcAYbjaf96cxwRqzTbNzru445au+qYX
        FaMOQLxmcS0YG6oU=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgQnJpYW4gYW5kIEluZ2EsDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJlc3BvbnNlIQ0KDQo+IEhp
IElzYWssDQo+DQo+IE9uIFR1ZSwgMjAyMi0wMS0yNSBhdCAxOTo0MSArMDAwMCwgR2l4LCBCcmlh
biB3cm90ZToNCj4gPiBIaSBJc2FrLA0KPiA+DQo+ID4gT24gVHVlLCAyMDIyLTAxLTI1IGF0IDE1
OjIwICswMDAwLCBJc2FrIFdlc3RpbiB3cm90ZToNCj4gPiA+IEhpIGFsbCwNCj4gPiA+DQo+ID4g
PiBJbiBteSBjb21wYW55IHdlIGFyZSBidWlsZGluZyBhIEJsdWV0b290aCBNZXNoIGFwcGxpY2F0
aW9uIG9uIHRvcCBvZg0KPiA+ID4gdGhlIGJsdWV0b290aC1tZXNoIGRhZW1vbiwgdXNpbmcgdGhl
IERCVVMgaW50ZXJmYWNlLg0KPiA+ID4gV2Ugd2FudCB0byB1c2UgdGhlIFJTU0kgdmFsdWUgb2Yg
bWVzaCBtZXNzYWdlcyByZWNlaXZlZCBmcm9tDQo+ID4gPiBwcm92aXNpb25lZCBub2RlcyBhcyBw
YXJ0IG9mIGV2YWx1YXRpbmcgdGhlIGdlbmVyYWwgcXVhbGl0eSBvZiBhDQo+ID4gPiBiaWdnZXIg
bWVzaCBuZXR3b3JrLiBBbHNvLCBlLmcuIHRvIGRlY2lkZSB3aGljaCBub2RlcyBzaG91bGQgaGF2
ZQ0KPiA+ID4gdGhlIHJlbGF5IGZlYXR1cmUgZW5hYmxlZC4NCj4gPiA+IFRoZSBSU1NJIHZhbHVl
IGlzIGRlbGl2ZXJlZCBpbiB0aGUgTEUgQWR2ZXJ0aXNpbmcgUmVwb3J0cyB2aWEgSENJLA0KPiA+
ID4gYnV0IHRoZXJlIHNlZW1zIHRvIGJlIG5vIHdheSB0byBtYWtlIHRoZSBkYWVtb24gcGFzcyB0
aGlzDQo+ID4gPiBpbmZvcm1hdGlvbiBmdXJ0aGVyIHRvIHRoZSBhcHBsaWNhdGlvbi4NCj4gPiA+
DQo+ID4NCj4gPiBUaGUgb25seSBtZXNzYWdlcyBjdXJyZW50bHkgd2l0aCBSU1NJIHByb3BhZ2F0
ZWQgdXAgdG8gdGhlIGFwcGxpY2F0aW9uDQo+ID4gYXJlIHRoZSBVbnByb3Zpc2lvbmVkIEJlYWNv
bnMsIHdoaWNoIGFyZSB1c2VkIHRvIGluZGljYXRlIHNpZ25hbCBsZXZlbA0KPiA+IG9mIGRldmlj
ZXMgc2Vla2luZyB0byBiZSBwcm92aXNpb25lZC4NCj4gPiBUaGUgUlNTSSBtZWFzdXJlbWVudCBp
cyByZWFsbHkgb25seSB1c2VmdWwgZm9yIGRldGVybWluaW5nIHNpZ25hbA0KPiA+IHN0cmVuZ3Ro
IG9mIGRpcmVjdCBuZWlnaGJvcnMsIG9yIHRoZSAibGFzdCBob3AiIG9mIGEgbWVzaCBwYXRoLCBz
bw0KPiA+IGZyb20gYSBwZXJzcGVjdGl2ZSBvZiBtZWFzdXJpbmcgdGhlIGxhcmdlciBxdWFsaXR5
IG9mIHRoZSBtZXNoDQo+ID4gbmV0d29yaywgaXQgd29uJ3QgcmVhbGx5IHRlbGwgeW91IHdoYXQg
eW91IGFyZSBsb29raW5nIGZvci4NCj4NCj4gTWF5YmUgSGVhcnRiZWF0IHB1Yi9zdWIgbWVjaGFu
aXNtIHdvdWxkIGJlIG1vcmUgdXNlZnVsIHdoZW4gYW5hbHlzaW5nIHRoZSB0b3BvbG9neSBvZiBh
IG1lc2ggbmV0d29yaz8NCj4gU3BlY2lmaWNhbGx5LCBrZWVwaW5nIHRyYWNrIG9mIG1pbi9tYXgg
aG9wIHZhbHVlcyByZWNlaXZlZCBvbiB0aGUgc3Vic2NyaWJlcidzIHNpZGUuDQoNCkkgY29ycmVj
dCBteXNlbGY6IEl0IGlzIHRoZSBzaWduYWwgc3RyZW5ndGggb2YgdGhlIGRpcmVjdCBuZWlnaGJv
dXJzIG9ubHkgdGhhdCB3ZSB3b3VsZCBsaWtlIHRvIGRldGVybWluZS4NCkZvciBub3cgaW4gb3Vy
IGFwcGxpY2F0aW9uLCB3ZSBleHBlY3QgYWxsIG5vZGVzIGluIHRoZSBuZXR3b3JrIHRvIGJlIGRp
cmVjdCBuZWlnaGJvdXJzLg0KDQpXZSBhcmUgdXNpbmcgdGhlIEhlYXJ0YmVhdCBwdWIvc3ViIHRv
IGRldGVybWluZSBnZW5lcmFsIG5ldHdvcmsgcXVhbGl0eS4gVGhlIGlkZWEgaGFzIGJlZW4gdG8g
YWRkaXRpb25hbGx5IHVzZQ0KdGhlIFJTU0kgdmFsdWVzIG9mIGRpcmVjdCBuZWlnaGJvdXJzIHRv
IHNpbXBseSBoYXZlIG1vcmUgaW5mb3JtYXRpb24gaW4gb3JkZXIgdG8gbWFrZSBiZXR0ZXIgZGVj
aXNpb25zIHJlZ2FyZGluZyByZWxheWluZy4NCkZvciBleGFtcGxlLCBpdCBjb3VsZCBiZSB1c2Vm
dWwgY292ZXIgdGhlIChwZXJoYXBzIHJhcmUpIGNhc2VzIHdoZW4gYSBub2RlIGlzIG9uIHRoZSBl
ZGdlIG9mIHRoZSBtYXhpbXVtIHJhbmdlDQphbmQgYSBjaGFuZ2UgaW4gdGhlIGV4dGVybmFsIGVu
dmlyb25tZW50IHdvdWxkIHRlbXBvcmFyaWx5IGludGVycnVwdCB0aGUgImRpcmVjdCBjb21tdW5p
Y2F0aW9uIi4gSWYgd2UgYXJlIHVubHVja3ksDQp0aGUgbWluL21heCBob3AgdmFsdWVzIHdpbGwg
bm90IGRpc3BsYXkgdGhlIG5lZWQgb2YgYSByZWxheWluZyBub2RlIGluLWJldHdlZW4uDQpIZXJl
LCB0aGUgUlNTSSB2YWx1ZSBjb3VsZCBoZWxwIHRvIGRldGVybWluZSBpZiBhIG5vZGUgaXMgbG9j
YXRlZCBhdCBzdWNoIGFuICJ1bnJlbGlhYmxlIHJhbmdlIi4NCg0KSG93ZXZlciwgSSB1bmRlcnN0
YW5kIHRoYXQgaXQgbWlnaHQgbm90IHJlYWxseSBmaXQgaW50byB0aGUgQmx1ZXRvb3RoIG1lc2gg
Y29uY2VwdCBhbmQgdGhhdCBpdCBtaWdodCBub3QgYmUgd29ydGggYW4gaW50ZXJmYWNlIGNoYW5n
ZS4NCklmIEknbSBub3QgbWlzdGFraW5nLCB0aGUgaW50ZW50aW9uIGluIHRoZSBmdXR1cmUgaXMg
dG8gdXNlIHRoZSBNR01UIGludGVyZmFjZSB0byBzZW5kIGFuZCByZWNlaXZlIG1lc2ggcGFja2Fn
ZXMsIGFzIHdlbGwgYXMgYWxsb3dpbmcgY28tZXhpc3RhbmNlDQpiZXR3ZWVuIGJsdWV0b290aGQg
YW5kIGJsdWV0b290aC1tZXNoZC4gV291bGQgeW91IGV4cGVjdCB0aGF0IHRoZSBSU1NJIHdpbGwg
YmUgbW9yZSBhY2Nlc3NpYmxlIGFmdGVyIHRoYXQgY2hhbmdlPw0KDQo+DQo+DQo+ID4NCj4gPiA+
IElzIHRoZXJlIGFuIGVhc3kgd2F5LCB0aGF0IEkgaGF2ZSBtaXNzZWQsIHRvIGdldCB0aGUgUlNT
SSB2YWx1ZXMgZm9yDQo+ID4gPiByZWNlaXZlZCBtZXNoIG1lc3NhZ2VzPyBJZiBub3QsIHdoYXQg
YXJlIHlvdXIgdGhvdWdodHMgYWJvdXQgbWFraW5nDQo+ID4gPiB0aGUgaW5mb3JtYXRpb24gYXZh
aWxhYmxlIHNvbWVob3csIHBlcmhhcHMgYXMgcGFydCBvZiB0aGUgREJVUw0KPiA+ID4gbWV0aG9k
cyBNZXNzYWdlUmVjZWl2ZWQgYW5kIERldktleU1lc3NhZ2VSZWNlaXZlZD8NCj4gPg0KPiA+IEEg
dG9vbCB0aGF0IG1lYXN1cmVzIHRoZSBzaWduYWwgc3RyZW5ndGggb2YgZWFjaCBob3Agd291bGQg
cmVxdWlyZSBub3QNCj4gPiBvbmx5IERCdXMgQVBJIGNoYW5nZXMsIGJ1dCBhbHNvIGEgVmVuZGVy
IHN0eWxlIGFwcGxpY2F0aW9uIHRoYXQNCj4gPiByZXNpZGVzIG9uIGVhY2ggbm9kZSwgYW5kIGNv
bGxlY3RzIG1lYXN1cmVtZW50cywgZm9yd2FyZGluZyB0aGVtIHRvIGENCj4gPiBjZW50cmFsIGRh
dGEgY29sbGVjdGlvbiBwb2ludC4gIFRoaXMgd291bGQgcmVxdWlyZSBjb250cm9sbGluZyB0aGUN
Cj4gPiBzb2Z0d2FyZSBvZg0KPiA+ICpldmVyeSogbm9kZSBpbiB0aGUgbWVhc2ggbmV0d29yaywg
bWFraW5nIGl0IGltcHJhY3RpY2FsIGZvciBhbiBlbmQNCj4gPiBjdXN0b21lciBzZXR1cCB0aGF0
IGhhcyBub2RlcyBmcm9tIG11bHRpcGxlIG1hbnVmYWN0dXJlcnMuDQo+ID4NCj4gPiA+DQo+ID4g
PiBUaGFuayB5b3UgYW5kIGJlc3QgcmVnYXJkcywNCj4gPiA+IElzYWsNCj4gPiA+DQo+ID4NCj4g
PiAtLUJyaWFuDQo+DQo+DQo=
