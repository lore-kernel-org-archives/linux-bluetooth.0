Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE87E7D0B4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 22 Sep 2023 05:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjIVFU3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 22 Sep 2023 01:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbjIVFU1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 22 Sep 2023 01:20:27 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2069.outbound.protection.outlook.com [40.107.255.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE0E18F
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Sep 2023 22:20:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3Kji4ATZfWSPh9oCz6iApAhiV62A3j/3txsAOF9fYTD5gRnEFHZq7mmi01qZM4zbbnDEz2We47uWs9viwk5q1TyC34QizvDmrwfE0kIZoaOP4kAV7OxrhQoovn2ixux7zeWfW4PVY3mnSZNdlzwtg1tHO54l/ac67aJDZ/lizGGZOoEguJeCPUGxeGvJCOzjvKlAxlp2KfTI1CR+xd4nx1T3vuBP0Jvzakog0J40c/kK6ss/QKQ21NsKNyPn95dwh2cvWYpgpogGx3Dmc0k/0cFdgjqezdIa+tsnz2q3tz8ZrAxG5VAoTCi/1q0SFb/v8VQ4if6v4YaSYN7HVd+hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X30hKWj1k+0N1OJ+F6In1IfZLZCD8rBTUAaLfDVxBSA=;
 b=Lotl5fWnPBnVx4MgmDHMyAJepVKcAW5eQwwDYoVrAVUyklboKUgRGdhlKCP+kHinSJbvO2hb8Rw2/JX5eEF8eXdnTnF73zB91mx58HAyMDJMZ9daPuqilx+CA7H1GUPi6OX+g+VJf68Tzp/pxoS8b779d5pYKYKEzs4FGFG0N8WFmK9H72TVvJ3mxfFxZ26peI7ewWSGoWlRaBfyyi3T2pYWwyZPThPgv128VJ/i2OfGZSpnCLGsbgub9o2UcxYkhcHdMHcfi4tPstRI4yO4khUP5zMqSk0aYsBII0PpaI2VMSjtS3Nl+4cqCXS4rKR5OvXCfic/cyQytN+lAeQh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quectel.com; dmarc=pass action=none header.from=quectel.com;
 dkim=pass header.d=quectel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quectel.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X30hKWj1k+0N1OJ+F6In1IfZLZCD8rBTUAaLfDVxBSA=;
 b=Dnw+FUjuVjc9EKVF4pqHeWhGCOVuQP6eJcMzBdHfETDgbpwk0gVDSsiRvfrTybfyLJrXUMnWxzyDyQx5SBkIzSrVjiVBDhzh8fQeBIuJ0MVR25zeJ1sXnzbNRLyW/bQLmgra3ls06aQpZGb5Ui6PjgmieHYtgbJOgqXNDNgii3M=
Received: from SI2PR06MB4121.apcprd06.prod.outlook.com (2603:1096:4:fe::9) by
 KL1PR0601MB3874.apcprd06.prod.outlook.com (2603:1096:820:28::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Fri, 22 Sep
 2023 05:20:16 +0000
Received: from SI2PR06MB4121.apcprd06.prod.outlook.com
 ([fe80::47e0:db79:910e:e3d5]) by SI2PR06MB4121.apcprd06.prod.outlook.com
 ([fe80::47e0:db79:910e:e3d5%7]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 05:20:15 +0000
From:   =?gb2312?B?WmhvbmdqdW4gWXUo09rW0r78KQ==?= <Zhongjun.Yu@quectel.com>
To:     "marcel@holtmann.org" <marcel@holtmann.org>,
        "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
        "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC:     Ankie Wan <alwan@qti.qualcomm.com>,
        Huibin Lian <huiblian@qti.qualcomm.com>,
        =?gb2312?B?Q29yeSBaaGFuZyjVxb2hKQ==?= <cory.zhang@quectel.com>,
        =?gb2312?B?TGlkb25nIFpob3Uo1tzA8barKQ==?= <Lidong.Zhou@quectel.com>,
        =?gb2312?B?Q29saW4gWXUo0/TQy7uqKQ==?= <colin.yu@quectel.com>,
        =?gb2312?B?QnJ5YW4gWmhhbijVsrb3s6wp?= <bryan.zhan@quectel.com>
Subject: =?gb2312?B?s7e72DogYmxlIHdha2UgdXAgaXNzdWU=?=
Thread-Topic: ble wake up issue
Thread-Index: AQHZ7RR44BGLgksCgEy/V4X2XCL4IQ==
X-CallingTelephoneNumber: IPM.Note
X-VoiceMessageDuration: 17
X-FaxNumberOfPages: 0
Date:   Fri, 22 Sep 2023 05:20:15 +0000
Message-ID: <SI2PR06MB4121607EE4991AD443C8D1B2EDFFA@SI2PR06MB4121.apcprd06.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quectel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB4121:EE_|KL1PR0601MB3874:EE_
x-ms-office365-filtering-correlation-id: 73bab6b7-0066-4af5-4eb9-08dbbb2b9abe
x-ms-exchange-recallreportgenerated: true
x-ms-exchange-recallreportcfmgenerated: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i5eeRxsxPML1ZJ8jv6OpUZMg3pYgXuTw31bkNEe7K0WjKGxcUU29jNdddKsMTLfVaVqDxjsri/ZdebaippxWT1yalI6CrxzsVviCOuCZURz0GXgofy1MTRbddqqs/1go+QmaDFneewE7GofB0M3oaWXkJW2bLksMHGBU6KNKtPbpS4TAKEm2K1IWMxguLgdh9fjbuJAhg7jxWe8AamZlPUnN9OaHjulxTXG+Dcl28tgNLgXrMhN22YFgfd+bGQkmryeAz94q4i4/F3SP8Su7QZ6RQ2Pvby4rGvB6c+l/Ypg1Sile3w7/oM641Bs7wNST+kiQoQZLAMlcjWM16kgABMLrFhHbNdMfp0JzYykIL1g2GHjrBz22pBJWNP7N9GjmO9iZDUY0bOAk2RpxcWaVW1lpcSPfzstIYOwRqNaoKr+c1lxIpdrXY+EbQsmTl8z2yEDPS7e+hThOZxKCKwI0ggoEKnXA0ZRwErkO5D1wb4FtmyvhYih9AzGvQ+mR0k6RvZ2tDsbVFJKn+3AEC98CwIoE40xd1rg0/118gz/HR/INncg/lyw10XfjpIek50Z2MgTzhyV1VZptVCBGyxeXe0iw4w3S9QymaRF16KJkXNfSs9dgmLEa9+O5+L0Hl/KK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB4121.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(1800799009)(451199024)(186009)(38100700002)(7696005)(38070700005)(6506007)(558084003)(55016003)(122000001)(85182001)(86362001)(224303003)(33656002)(2906002)(4326008)(478600001)(26005)(9686003)(71200400001)(110136005)(8936002)(41300700001)(5660300002)(66476007)(66556008)(66946007)(64756008)(316002)(52536014)(107886003)(76116006)(54906003)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZnBvYVVCckkvcTRiOVltelZxZEc5emJkNUY0RXdrUEM0b29tT2Fib1lCMjBP?=
 =?gb2312?B?ZHJGQnY5WWdtR0wrd3IyMXF6UzRVV3MvdHhQUmV1SGJkTGlWTDNBUzRWSk8w?=
 =?gb2312?B?WXRjQ0FGREU0anExNHZ2SlhBd3M1cGRaSUFIYVVsMUJRL2dMUVNJNnFWaHZm?=
 =?gb2312?B?Mm0zdlBNNVoyTzdxQzBFT01MbEJkdzZxb3pzUGF4ei92LzdpRHRLTlhLT1U2?=
 =?gb2312?B?SkxERTIwMFplUnRrQjN3bHgyZEZuUUpwRWNuSkVXa3BPRVJ0WEFHWUNzamF5?=
 =?gb2312?B?VndvNHZCc1pRMlA1TExFdE41aDRTSHdxYjg1QmZlOHpmcmJTNDhacFJBeWlB?=
 =?gb2312?B?dlZDclBQbmZiNE16WFZ0ZzJSZDZsblRIclU1bUt0czFFdWZOUGN6OUxQdzE2?=
 =?gb2312?B?cWNzSE1CTHltNlVQa0JkR3JZeUg0SE5qOSttVkJFUlZkdTdlS2w2U3RTNCs3?=
 =?gb2312?B?NExhem9JNS9rODdkcU11dGZBVkltd2E2dXE0NE42RXlvU2JQYUsrc1luQXJj?=
 =?gb2312?B?ZkxGaXRkNC95Rjk3NDVmQWZyZ0NTNitoQUtkYThqMVVocEEwTzhlVHloU3ds?=
 =?gb2312?B?bXIvQ1FmL1lSL0czNnNEc1RTMmRXaldXSW11QTdUcFV0MEZJVDlvazFNRVdO?=
 =?gb2312?B?TVB3NzVub2pRY2FnbEw4cnhyK2Nud2M1SWxpYXBqMFUrSWpRem1peXc3R0RL?=
 =?gb2312?B?UDFPUnBaY201L3ZJeE8yMVFzMWNsY2ovQ29oMm5CRnZHRnpsZnRZSUtwMFhC?=
 =?gb2312?B?M1JmUFh0ZDlFdmxkTnBtUFpZMm4ybEhGbFlSeERLc1pkNXVBRldJY1p6Qm0x?=
 =?gb2312?B?SXhMYktpWklRbGVGSkIyd0MvUW11SHpoaHBHaGJyMDBRQ0dDVE5QWXBOM25p?=
 =?gb2312?B?Y1ZqK08rUThvY0ZsSjAvUXljZUx2QWM4d2pOVTltMHExSERjRWNUa3FWaUdO?=
 =?gb2312?B?VXBSVXZQcmk5Z3I0RTVvbzFsYUhKQ1JyZFNjbzBGbUtUMTdSTzRCdDh3SFBn?=
 =?gb2312?B?UTlxaHNMU1kzT2UrVVNCNXlVVHJGTU4xSmJWWXRLUlBpaEpsUFRSSDdBaU54?=
 =?gb2312?B?TXhmMEtMS2FFMXhsVFVqa0tqak9kdytQTk4wTHdnL0o1b210WFR3UkpxNWRD?=
 =?gb2312?B?RG9KS0Jpd1ArQlBLVUdicXdiczYyNUFDWU9yc2dRTXJhQ0VYRFFDUGpOb3RK?=
 =?gb2312?B?QnVuOWtqNVBUYmtwQ3FLSEJDRG5OR1ROeTBKZ0EvWnU0WkhJS0wwM3cvRVpW?=
 =?gb2312?B?T1NLVjlwTEhCRE1peVZJRUFuM3hWQWFqaWppS3lmQlhGVnd1Y24xZU1VTmp2?=
 =?gb2312?B?Snc0aHJJdFRNeHpzRlZOS1grZ1l4UC8raUpDVjZRT1I2WW8zd3ZxMmxVU3kv?=
 =?gb2312?B?VEFFR2Rqb3l1UW85TFAyM0xrYkVjZGdTS3RBRzluSE5YV0xSMkt5SzM3SU45?=
 =?gb2312?B?ZHdrdXJyZjRCM042bVExY0xDZlphanVaQTJFQU9XVHNCcGNyQ0srOXlleGV4?=
 =?gb2312?B?eGE5b01lVW1SNjh6WXA4SnhldExRUHQ0RmppZGhMbTU0ZHQzZ0s4dkF6Tnpw?=
 =?gb2312?B?S0E4SjJtYkZyMDJZeEJ3bnRac05meVZqaFdQSFRIVEV4MHBucHhmZjJpT2Va?=
 =?gb2312?B?aGcvUDhwZkx1bHR6cDN0RTQ5L0tUcDhWZEVxRjBRSkF5bmdNSTZjckRXZGRX?=
 =?gb2312?B?UVV6OVgvL1AyaDR6L0h0Z21CWUxudDA1ZlBaM1J1NGxta1BQQjBUeURwdkla?=
 =?gb2312?B?TmtrVzAyWWJHNGZnOENSMnNVblVUWGhVQWEwWGZnZzJaL3MwWlc3OHNjOWdQ?=
 =?gb2312?B?YmVhaVErM0xMSUNMZ2I2d0F1Ulh6UWtvUFpycmw1TGc1dHBCRXVNTk9Na0JL?=
 =?gb2312?B?NHNscDdiUnpLUEdVa2EvbStCUVhTZmtVMWVuTmdaeUZQT25heDdZQ3Y4K0E0?=
 =?gb2312?B?SnNmRWV3SUFMLys0NWZoUWRGVG8wd0dJNzVLT0FodHdXWjBhbVh1aUJEcVVj?=
 =?gb2312?B?cGx2S2JXQmFZcTB1d2VLdVdyMU92QXlWOUxrNUJ1QXdzV3E1NkpkWC91WXpO?=
 =?gb2312?B?MXV5em4rYTdGTzhJMzNPWWUwOXBhVGhmTm9oOEFGUkVMcENLUWw0SkduT0tK?=
 =?gb2312?Q?kf4C57MdLf1YknQkpN5iUG0+h?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quectel.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4121.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73bab6b7-0066-4af5-4eb9-08dbbb2b9abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 05:20:15.6672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7730d043-e129-480c-b1ba-e5b6a9f476aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MMqvaLLH2A8D6zpxCTty/pw1Zy7ouHA6l/t652HaHM1wA3LbudnBt3weUPVAvhxceNcU5HJ/3DTazZNOGhv2GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB3874
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

WmhvbmdqdW4gWXUo09rW0r78KSC9q7O3u9jTyrz+obBibGUgd2FrZSB1cCBpc3N1ZaGxoaM=
