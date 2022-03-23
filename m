Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D55C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Mar 2022 07:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbiCWH7F (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Mar 2022 03:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiCWH7F (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Mar 2022 03:59:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDBF13FA5;
        Wed, 23 Mar 2022 00:57:33 -0700 (PDT)
X-UUID: b1a6c1c8a392452ab0767a3a4a38d1d4-20220323
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=MIME-Version:Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=UrrcXBQj40krDAspPWoXp+tYVrZ4DDB/6x5ahEt+j/E=;
        b=kIHIZZwIXJ24U5qmmimZIF2JvGDSdk9zTTkvoj8sTOymr331U7u8FaWTrVI8/nh1DvB2AFOWjUaeIyRBrBjcGej7WzSFm/M8E24SVdvtEZot2ufXVwu4XZa7ZjIxCGlfK3zfTJSf3aYnlVEk/qYb2EokwH7ZmfB8XnDLRFigwzY=;
X-UUID: b1a6c1c8a392452ab0767a3a4a38d1d4-20220323
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yake.yang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1426859568; Wed, 23 Mar 2022 15:57:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 23 Mar 2022 15:57:16 +0800
Received: from APC01-PSA-obe.outbound.protection.outlook.com (172.21.101.239)
 by mtkmbs10n1.mediatek.com (172.21.101.34) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 23 Mar 2022 15:57:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCdrc/FOPXRRkJXnISEuRij49I7e7CXhW8qsIbeGbnqNQmViYtEtYOGTcS14D6eIhEas8qALpKB5zurv0qn4xiyVVUp5chZoGl2hDxhF5adHEiqeXpiknhSqc1OMbahQ/M0BDV360hiaO2FlkHNjlHIi+x+eue+zeZfnODNRSQvK1ZPhzHpTilfCcNLb4mVf3TB4wm+dyM1LkV7ELxptPf4Klq4nyYvaA5/wa0oqDk6HvByvPkwD5b7R+lK/wsqY3EQGSyacLFKZflR5KaqirMtzb+98HSoQJZub96Q0IcTAq+T6d6T1g6WMQoFVCveuXnRa+F6hmrmg2u3jbURWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrrcXBQj40krDAspPWoXp+tYVrZ4DDB/6x5ahEt+j/E=;
 b=Ce74ypxN0IBJqVN2luik49QRDiWpU4HFv7c8gfuP9Kl+RnwNBvRcdAs1h9l5D9W4HK3hrr1CU2n74GFdDtc2zbFXMYHxHU8fjuqxO1EMn6jHgnHZd7ySEWs9FNT9mx/h8CNffJv53hkPlWKyw5/LsoAwbgKL9mLnjsJTNctXMCsidAA9e577ZJ4q9/tj5GeeITJghzFjWtVY71dmiu907BNBRJ4P0TZFswAmVs6QrSdx5iChxjGRYEK14J25BpD8lsuZh4CXtJIdk0VK4i8e0ch3zX8HyBoVH7/FYygWvhFDM+asXcZ+Hu/dqUORvmv9pP1j2KJt5dHm1ObX7E9V1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrrcXBQj40krDAspPWoXp+tYVrZ4DDB/6x5ahEt+j/E=;
 b=FRNo/C/vINBr0VMSflSLxyJrafbPC6bGkhOniEgqELbbUqVv6QiwfV/iEZ4nN+E5rKBWh/YR6LAP/5p+M3WNZczIHF+JYkf6UJR47BQK6/etl4ub82k5pzwtCe2h8pfDaEhoKZ+7sPr5MLcGJqbyWd1klJYgy36CapqQbx1zsy0=
Received: from TYZPR03MB5278.apcprd03.prod.outlook.com (2603:1096:400:3a::7)
 by SI2PR03MB5941.apcprd03.prod.outlook.com (2603:1096:4:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.8; Wed, 23 Mar
 2022 07:57:10 +0000
Received: from TYZPR03MB5278.apcprd03.prod.outlook.com
 ([fe80::a016:9018:eec:dd58]) by TYZPR03MB5278.apcprd03.prod.outlook.com
 ([fe80::a016:9018:eec:dd58%8]) with mapi id 15.20.5102.016; Wed, 23 Mar 2022
 07:57:09 +0000
From:   =?gb2312?B?WWFrZSBZYW5nICjR7tHHv8sp?= <yake.yang@mediatek.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Marcel Holtmann <marcel@holtmann.org>
CC:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Mark Chen <markyawenchen@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        =?gb2312?B?TWlsZXMgQ2hlbiAo6pDD8ZjlKQ==?= <Miles.Chen@mediatek.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBCbHVldG9vdGg6IG10NzkyMXM6IGZpeCBhIE5VTEwg?=
 =?gb2312?Q?check?=
Thread-Topic: [PATCH] Bluetooth: mt7921s: fix a NULL check
Thread-Index: AQHYPop7FGoCYwarBk2AiClx49hATKzMmLXQ
Date:   Wed, 23 Mar 2022 07:57:09 +0000
Message-ID: <TYZPR03MB5278324850B998139A88B30482189@TYZPR03MB5278.apcprd03.prod.outlook.com>
References: <20220323074830.GA4639@kili>
In-Reply-To: <20220323074830.GA4639@kili>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbXRrMDc1NDBcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1kNTk4MjMzMS1hYTdlLTExZWMtYjY4Mi1jOGQ5ZDIxNTcyNGJcYW1lLXRlc3RcZDU5ODIzMzItYWE3ZS0xMWVjLWI2ODItYzhkOWQyMTU3MjRiYm9keS50eHQiIHN6PSIxNDc3IiB0PSIxMzI5MjQ5NTgyNzgwODIzMjEiIGg9IlFEYzNhR3lTZldpTUNSanFpUzdoc0dTcDk0dz0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 326750df-e404-4d74-2b03-08da0ca2bbb1
x-ms-traffictypediagnostic: SI2PR03MB5941:EE_
x-microsoft-antispam-prvs: <SI2PR03MB5941A0DDD74022621350E09682189@SI2PR03MB5941.apcprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Dx1MgGKcqBrsFxT24g0of95yq8qI7RylsJ45XYy7y2WbmlPrKe32PSqACMUMLnuhBZlREiKD85akYMlD5B4LhcXXBpUKU8JXsSiEQNlZO1H/DNwitn8zDfrT0Cax/d/60dTSX1GqWwGES4zt0XqN6jpXBqi2nZmEP6Jk4NiYjwUhm4Y3XlSn8oOZ48cmELFXEoJ2SM2ELH8Tdk1Uq9v7aexSCA1jKu2sPwT/HmflcppB/qIYawoMol4aiTuycNFHqYVsS7KA/3G4jv9n3ng25DnredqFVRxflJTp965mbvAIcQmvCPEw5ki1jaRkf1ZL7+Zc6bVjQ5Zah3moYoYXvEC6rg4bOMzdIYn1xkKJKFz6VUvit7l6dm/yemW6iPEsRvYYmug8oOc9y68E09UuPq5yipYwdnb5Lpki092043cOal1qlwGUfYLVzno6ODT5yAULbzdj0fXZ0w9fnkMeVyZvIj2zqIUcMNd3q9IrtZXEBigME0ot9KOZyK9Zpm0h3pMGvxMgT3suFDsEE7+TdeR+0duD4aMjkZWiqAhftSiwQp+nbSTQd5/RFbGo0K2FmMTc3wO2UqbJXIyYJ+xBWyTjh9Qsx9wdYYiwr/zZg6qh9MKwqVvoRtKYlwbMC4v4A+gV0x3WRomVD0ztJ40v2A+cWr1/Bsm95EQC53Rwri0HiekZgt6xwntyGbjFmpKF7LMPS5VQq/eThEx9LVZnw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR03MB5278.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(33656002)(107886003)(186003)(2906002)(6506007)(4326008)(26005)(7696005)(83380400001)(5660300002)(52536014)(8936002)(86362001)(508600001)(71200400001)(316002)(224303003)(85182001)(38070700005)(38100700002)(122000001)(54906003)(76116006)(66946007)(66556008)(66446008)(110136005)(66476007)(64756008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VmtNNGV6VlZNSFRaaHlrS1FMaS9yVFQyME45eWtHMkU4UHowcjFlZ0EvWHNT?=
 =?gb2312?B?eC9Ld3F1OWJjdkZXK2o0amJ3Q3QxaDBFKzM1QlFlSGhZczQ0RHV4ODNTQzJF?=
 =?gb2312?B?WVVRTlFBRHFyNXJyd09HUVhxcHh4NWFuakpGYzZRWW1aUGNNb0dialp6aDJk?=
 =?gb2312?B?NXg4c1RxU0h0dzhRb2xWakVXL1NCclhoQ0lKd3BIcmNmd09ZTzRIaC9YQ1d3?=
 =?gb2312?B?Vm44dTlGU3pUb0pGSlEzL3J6RGdNdHVoNWdWdlkvaHMyaXovaWcwWjJFeUcy?=
 =?gb2312?B?TnBoYndZMzkvS0kvUmZKaDA1LzQxWXFpVHhDZ2U1blRkanRMZWlHenV1QWJG?=
 =?gb2312?B?VEpqUE9oTytjNmo2RnF4QTBqejBKYUlQd1FDUG5PWklMSTNNbDQrTlkvdTgw?=
 =?gb2312?B?VFJvS0syZWJFVEFjRkl0MFFpcDE4emJ4aDEzaXFiaUpkcTl2K0hlb2hKZDlZ?=
 =?gb2312?B?NS9vVE9WYldVWEtpNFZEYzhmYzBpeGdWSjhJL043NkVGa3FueVVRTlBXa1dG?=
 =?gb2312?B?OEpUdmgvVzdXeVhhR2RnNk4zVE5OYllscFFyNFdBSTBBelpjSTVqVjlMWU5t?=
 =?gb2312?B?cVNtQWR2bWJreWtpR1B4MmFGWFViS2sxbmF3cGk1bDlLa0JLQklyVkxOWjFv?=
 =?gb2312?B?U0IyZkoyWDMxbmUwbnp6UXNCN2syaVRVTlc5bUNtRWFHWjVoYmhmTlF1SXJq?=
 =?gb2312?B?dm01SjNjLzF3MUNONXZrN3FvQk9wQ25LRWNEODBkV3lNQUROL1hBSDhRRVpq?=
 =?gb2312?B?MGFsYUg4YmNPbkQwWFB3SDRoV2lITXUxMXFBSnBJdHdqTjJZMWlVQXh0cE1R?=
 =?gb2312?B?cDgvV0dBWGZlTXlwVGtWZGxnZDdjNkpKbUs5OVBlZU82MTFsbGJSRHJ6cEVH?=
 =?gb2312?B?Tko4UERCMnE1dXNteXBKZnp1MTA1d3FtbFVzWW94d2tWK0NKazEweVJjSHJT?=
 =?gb2312?B?NU1UYjhkWG9tZVYrSjRJMFFlbmYxWnhJMkp6L2drVG5XaG5iZjVjQXNldHNk?=
 =?gb2312?B?aDdVbXlhb3VCSkRobHdVYXliR0dWOWtBWTRpZ2VCY2xSRGJ2SmxvYk41L1hR?=
 =?gb2312?B?akhXZnFqNXg0bWc4V0QrSnNXUTJaSit4SURzbEQ5ei9FbW96V3NreE54VXBR?=
 =?gb2312?B?akduRGlZTmZQTWd2anpFQkFVNDU4V0NzaDBLRnVMTnlQNkxEeGppRWpCTU9n?=
 =?gb2312?B?NjBWQXlpdnlpSGovSzB5c05HeWZQZUdYbWt4WDkzQ1AwZ0dRVFVxcWV5TWxU?=
 =?gb2312?B?czdwd01Wd1pZNk5HRkk0S0xxY3d6MXo3aTBVOC8yMUlWL0kxQnd6NlEwZ3lU?=
 =?gb2312?B?WFRFZWV1NnBwNFJqQzZ6SDFJczY5WGJoaFByTEViM05McVd3bDJwM1BqRkM1?=
 =?gb2312?B?bVJyRlROWVVHWGhTTXVGRmZ3MG1BSmppTThpdnJzSEZFVklXUTZuR0FJWVVq?=
 =?gb2312?B?NEdJTXB1MTlkaFg3T0JXV2tKU3Q2ZCtLZEZlYjAycmN3QmVWTGxzbGFOVFhW?=
 =?gb2312?B?amNRNDZXUE8vOHQ4WnFkQmU0Ykh1N3lJT0JUcHBkZkxuNnRveUlmYTZZL0Rq?=
 =?gb2312?B?ZVcrZSt4WTBhY3o2RUFhVVFadVoxS3FBa1hNOVJISjN1akNQODhGTWpzazZP?=
 =?gb2312?B?SktzeHc0M1FwOFB0T3l6R3JwMjhZSXJITW9ScURsaEJSVERpSTluOUJvaUZN?=
 =?gb2312?B?TjgyK1pXT3h6citOSHhxcHZxb3p3ZnJUSVFPaUM3SnJ3V1lXU2w5aitaSDd1?=
 =?gb2312?B?T2dKZGwzSnZnTmRlMHdZaVhRQnFBYmU3cFVnb3ZPQnhGYWtyK056aFlVYXJm?=
 =?gb2312?B?cnhOd3RqOVE3WWRlQ1dsUVRpTVdhZ0o5ZXJVRWRIWTRiNHJ0Wjg2N1N6aVJX?=
 =?gb2312?B?MHJLcVcvbHU5UDZqRzNpenZVQXlqQ0lPWkwxL3BvSDRPNkFLM0FyQjZjWmNx?=
 =?gb2312?Q?cjnlURmTQ0VqT6QQ0cd/RWvSBJyXTRpT?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR03MB5278.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 326750df-e404-4d74-2b03-08da0ca2bbb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 07:57:09.7032
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FD0xI9ZW1xERjWlScQuuWd0mZAgZPhNHka0Oys4HSKsi04fDMP5aoImWgvAoImaGyU0Q0YL7J0MHUYuul8yXXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR03MB5941
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgRGFuLA0KVGhhbmtzIGZvciBmaXhpbmcgdGhpcyBpc3N1ZSwgd2Ugd2lsbCB1cGRhdGUgcGF0
Y2guDQoNCi0tLS0t08q8/tStvP4tLS0tLQ0Kt6K8/sjLOiBEYW4gQ2FycGVudGVyIDxkYW4uY2Fy
cGVudGVyQG9yYWNsZS5jb20+IA0Kt6LLzcqxvOQ6IDIwMjLE6jPUwjIzyNUgMTU6NDkNCsrVvP7I
yzogTWFyY2VsIEhvbHRtYW5uIDxtYXJjZWxAaG9sdG1hbm4ub3JnPjsgWWFrZSBZYW5nICjR7tHH
v8spIDx5YWtlLnlhbmdAbWVkaWF0ZWsuY29tPg0Ks63LzTogSm9oYW4gSGVkYmVyZyA8am9oYW4u
aGVkYmVyZ0BnbWFpbC5jb20+OyBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdt
YWlsLmNvbT47IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFzLmJnZ0BnbWFpbC5jb20+OyBTZWFu
IFdhbmcgPFNlYW4uV2FuZ0BtZWRpYXRlay5jb20+OyBNYXJrIENoZW4gPG1hcmt5YXdlbmNoZW5A
Z21haWwuY29tPjsgbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgbGludXgtbWVkaWF0
ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZzsga2VybmVsLWphbml0b3JzQHZnZXIua2VybmVsLm9yZw0K
1vfM4jogW1BBVENIXSBCbHVldG9vdGg6IG10NzkyMXM6IGZpeCBhIE5VTEwgY2hlY2sNCg0KVGhl
cmUgaXMgYSB0eXBvIGluIHRoZSBOVUxMIGNoZWNrIHNvIGl0J3MgbmV2ZXIgdHJ1ZS4gIEl0IHNo
b3VsZCBiZSBjaGVja2luZyAiKnZlbl9kYXRhIiBpbnN0ZWFkIG9mICJ2ZW5fZGF0YSIuDQoNCkZp
eGVzOiAzY2FiYzVjYTJjOWQgKCJCbHVldG9vdGg6IG10NzkyMXM6IEFkZCAuYnRtdGtfZ2V0X2Nv
ZGVjX2NvbmZpZ19kYXRhIikNClNpZ25lZC1vZmYtYnk6IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJw
ZW50ZXJAb3JhY2xlLmNvbT4NCi0tLQ0KIGRyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrc2Rpby5jIHwg
MiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpk
aWZmIC0tZ2l0IGEvZHJpdmVycy9ibHVldG9vdGgvYnRtdGtzZGlvLmMgYi9kcml2ZXJzL2JsdWV0
b290aC9idG10a3NkaW8uYyBpbmRleCBmM2RjNTg4MWZmZjcuLmI2ZDc3ZTA0MjQwYyAxMDA2NDQN
Ci0tLSBhL2RyaXZlcnMvYmx1ZXRvb3RoL2J0bXRrc2Rpby5jDQorKysgYi9kcml2ZXJzL2JsdWV0
b290aC9idG10a3NkaW8uYw0KQEAgLTk2MSw3ICs5NjEsNyBAQCBzdGF0aWMgaW50IGJ0bXRrc2Rp
b19nZXRfY29kZWNfY29uZmlnX2RhdGEoc3RydWN0IGhjaV9kZXYgKmhkZXYsDQogCX0NCiANCiAJ
KnZlbl9kYXRhID0ga21hbGxvYyhzaXplb2YoX191OCksIEdGUF9LRVJORUwpOw0KLQlpZiAoIXZl
bl9kYXRhKSB7DQorCWlmICghKnZlbl9kYXRhKSB7DQogCQllcnIgPSAtRU5PTUVNOw0KIAkJZ290
byBlcnJvcjsNCiAJfQ0KLS0NCjIuMjAuMQ0KDQo=
