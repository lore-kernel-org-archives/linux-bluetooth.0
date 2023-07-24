Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A510CC0015E
	for <linux-bluetooth@archiver.kernel.org>; Mon, 24 Jul 2023 15:26:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjGXP00 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jul 2023 11:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbjGXP0Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jul 2023 11:26:24 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2048.outbound.protection.outlook.com [40.107.21.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512121B3
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jul 2023 08:26:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WF4NzQnRSkSpde5SpNByOJUfwpNr65GAAdcR1WnlWhtVq9vqPCkHvl1B457co08PuYNJp6IBXgqCmcXkKVz2isjGWHhIw56Swga4KT5g3AsppsrzzFmTE9/zxhS2/t9Vqj5GuUcJPJyQP6avPe1XZsFPsy93h8jst0BLuyO9yFS9opxQAPUICo37O4r38Y3pXWd+CgtpR0GeXQWsF0mm+0er76njrIi7WjMQSfqneKZR/7uOPEODDoDX1D8oWhiWJLm0sIIJM2S5sEB2muPHaDAQ3Sj0XCJtkSnpdyZXSIQlkLNxc8szOsPWagnDwxxQLd/csoWji2zeyzldQFbf5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5dVO2N1GTzozdG2KRHZd/DtIqmHYDStKxIVZJOp1xCI=;
 b=OdcFBb3h3X3cYh0NgA0T280bT4AECn6iGhO1uA/IwkI8mMInjFT2hB8fHtZBux6OomgMOdsSJm1ojHYXeM8npplVOvaWZ+PRPB+sTYiENi9vcarkRma6vJTzodwp6V9nyklYQnqBYDbHqV6A8vBpUG/nOoQx8oBVD9sdyUEC3zUgxRKHr9ZDlwXB/GVMw7PDs0pBJVRC0dX0cIcLZfFVRDtWtyos6SQ6HSt8UwicfLG3e0qN7ZKwuaHFgWjm82sp+MfbeMagXJoHEstl9gDx7oFLujyuFayjvUq9c6Bvvi7CxF9KP99l9r1YciAdKCFE/RNXz5CBwi8KhBXIhkY1DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5dVO2N1GTzozdG2KRHZd/DtIqmHYDStKxIVZJOp1xCI=;
 b=fZL67d0S+4CX5GuX1fCmhf5PHViNJBYw0uvaIBqTyVB+ZQypMZd0XMMmkeCfU4mB97jrYtanwvan0aRwA7RD7HqiOfTPD4Tdnst6t7wZnUJkrp9pcw6AaXqvqrJXc1q2kv3els6LgD/FQVoF5NMdQFKyBj0jcl0x/x7J1RqMV14=
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by PAXPR04MB9073.eurprd04.prod.outlook.com (2603:10a6:102:225::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Mon, 24 Jul
 2023 15:26:20 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::7fe7:582c:e250:bd4e%2]) with mapi id 15.20.6609.031; Mon, 24 Jul 2023
 15:26:20 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>,
        Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>,
        Claudia Cristina Draghicescu <claudia.rosu@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v2 0/6] Add support for BAP broadcast sink
Thread-Topic: [EXT] Re: [PATCH BlueZ v2 0/6] Add support for BAP broadcast
 sink
Thread-Index: AQHZtLuvcmSZuwK66kOguD0StUcFp6+2Z7YAgAGnZICAEOcV8A==
Date:   Mon, 24 Jul 2023 15:26:20 +0000
Message-ID: <VI1PR04MB534401E37042C36D7FE9531AEB02A@VI1PR04MB5344.eurprd04.prod.outlook.com>
References: <20230712122135.7734-1-claudia.rosu@nxp.com>
 <CABBYNZ+8MvwrB_50=cugsdTKSv_DSFePErb3w-7NestCT3nwjw@mail.gmail.com>
 <CABBYNZLEPLrm_rZ234_pxNNzi8Ls646B6nCybW8F7S6fnD8qSw@mail.gmail.com>
In-Reply-To: <CABBYNZLEPLrm_rZ234_pxNNzi8Ls646B6nCybW8F7S6fnD8qSw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5344:EE_|PAXPR04MB9073:EE_
x-ms-office365-filtering-correlation-id: c7fe99ff-2c72-4350-9df8-08db8c5a54ce
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BdWZrTK08wmBhghzs8yfMC+ScowyYk7LZ55YQO3B2tV+yFXdnbOEJ0gkQixAqNFD7TkUj/30O4yMEvchmuJ8/O4KXAImZxPj2KFOStB57zn9Hgv2D23pFfeWK5etIIjLriOat0JLHzukIU4W6ukaa2pCOmaUXADMWsgA0IqTsXCexCMG1Ln1W106x5TpR/nRlm5VqtDEUF5+Wwk/yVXBeqnFggtKARjWsLFO5zFRvmGj5hxYXvwfdAHP0s2wsMcsCHb2I9nN+qIdsfM9r8ljDGfI7axXWCLMV0682N0UkfjuUq2Keu1mFTF4AcdYdpBmMFYEwx61mmE4JUGhGg5elKSgIB4YfyX5C5hBXIMIQR91rBnZzqYN/9dCdFsUy+GQw/onYeT8RCiGeicO44izcX0hCEUk5uwAz7qA2/YqlI5ghxC/IALi6+7eztwflxcCCfXw8NJkVHRFJRCC45o1WQJ0J5EMytUsTYVj+8z1PPEbVZWkKA4jqnb7pf+mQLNKHwhh8JwuzLbCGIecO5p/bkksPZqiAhf1qYr22plvbk5GRTTjOiwVN3Az+MvwQob3vDE9TAF/CE7zQCDomfcJhna0bNLuc05Yw8chqILO2Zw25E2IBX72f/8h7scvBdlT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(7696005)(9686003)(71200400001)(54906003)(478600001)(186003)(53546011)(6506007)(26005)(2906002)(76116006)(41300700001)(6916009)(64756008)(66446008)(4326008)(66556008)(5660300002)(316002)(52536014)(8676002)(8936002)(66476007)(66946007)(38100700002)(122000001)(33656002)(38070700005)(86362001)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SC9zRmd4THJza3BoWkF2NXdreGdYUmpWU0x2OEg5V2JzQWNudnZ6UmJiVXRz?=
 =?utf-8?B?K3JlbkJML3B4VlNhUS9yUERoZmNHcnMvSzZRNzR1VWFiKys5bSs3SFJ0eDB0?=
 =?utf-8?B?VHhpZnJmM1UyQ1JseWk2OStjbHIzRkR2cnZtWTNOVWVCUklLUnBiaFJZSTZU?=
 =?utf-8?B?SGtETUtTcktjSUU5bEl1VGJNbHdJdUdGNFl1cG90Wkc1L253Vm11UFNKS2tB?=
 =?utf-8?B?WUliOGUzRDJPamhGNWRqVm9YUEJUZjdkTWdFRkxVYTArWi9LZ0VncmJUQ1Rn?=
 =?utf-8?B?clY1RE9ESS80T0RjcS9URWpCU2RkZjRXY25Fam5qMkdRSmdFazNpWGUvOGM5?=
 =?utf-8?B?ajV6bklIY1F5VG55M0l0cXU1MjFhTUtKckk3TFlkVytWRUZLUmp0enhtYVdM?=
 =?utf-8?B?VjdWVE9ETG9xdkFjZmxiVDJBY05VSUVJclhkSjN5TEF3d3F2eFgxd1dnbk5H?=
 =?utf-8?B?eXYvNmM1emJOY2xrcGtVWmdDL3dCSzJrQmtzSHU0V2ptNTRwdktBaHZ5K0pS?=
 =?utf-8?B?L3lVNzVrYWk3U3VYSzJLV3JXVnNpTk1ncFdSZ2tBYTM1d1FNaU15QmsrQVVX?=
 =?utf-8?B?VlN0WmJIcXVNWHI0OC9VOVNhSEFIb1ByMWhuV1hxL0JYNVNSZDFZc0NjZnYy?=
 =?utf-8?B?YzNkbjQxVWdaem1ObFhtZmhhb3YwSUdyRHI5ZnJIdFVTZDdOa1llazh5R0Jw?=
 =?utf-8?B?MWppclovRXdmSENKbCtkeURvRnpaS1BvdnZWTXYyQjdpZHhPZ1NDWUUxM2pP?=
 =?utf-8?B?bUN6TTFXaEJZV2ZRK3l1YW91TWUzcjRoR1BpbGw4bUtKWTI2RytqM2QveUZW?=
 =?utf-8?B?MEpRYXNPaG8rQzZYbWhxckhKUlk4c1N5VHB1cSt0blFmQ0ltRnVla3dFZmF5?=
 =?utf-8?B?TDRGbzdKNm9NVHBXZG1GUE0vdzFKRTExcEJXM1hsTFNBVXcrd0JnTUhMKzJU?=
 =?utf-8?B?UVFvR3psNm5ZV2lUZ2NKU1pHV0hzaUttbGVHd1prM2dEdDZHaFl0ZlJROW5w?=
 =?utf-8?B?R1lSVVVyY1I1bEVCOXp2MFNzZ0dkaUZvdG5ER2Y2aDhPOVBGdTcvQ25MVWY5?=
 =?utf-8?B?N0hDSGhQQ0J0NTl6QkpKR0JzVjdXVkdFMzZGT1lNOHB4WDBxODE0eHA5ei9P?=
 =?utf-8?B?cDdUT0VQdDREQU83TnhMbVhoRnZhNkJjRGNVeVlnWW10Wkg1MmpJU1RtQThn?=
 =?utf-8?B?K1FJb085TDJQdVp6TVNBWXVYM2E3aVNpckw1ZFVJcTZHaDNpa1FVTnZMVEFE?=
 =?utf-8?B?TEZ3REs1VmpjZHFxbkFrSGRtczhOTDM5WDdWYjFkbUcvdGx4c0lEb1I5VE9H?=
 =?utf-8?B?enN4eWpCZ3NVbTBIT21RSUh0ME0rREUrZEREQVd3dE01WTcya1NiR0c5L2xX?=
 =?utf-8?B?aDZwaitMUThVeXZ2b1JHcDM2MmdkblllY2JXUzdSTFNrajMyL1dVU0R6K1JI?=
 =?utf-8?B?NjNFWjBVK2RLOXVhVVE0UWxxVjErVEYreklzbEF2bk5rSjZzWFpjSXJONnZh?=
 =?utf-8?B?U2NCeTBsVUZkSDJlYnI5ZTdBM2Y2ZjNCUDVpVm1nbm1jcStDOUhSUnBwd0ZV?=
 =?utf-8?B?R3M0cmtZK0o4NVhDRXJic1VJY3h3V2xmMUhCSEcxWmtvZlJIVDFzU3JwNU1V?=
 =?utf-8?B?M0JxVHVnalpIMEFab2cwb2FneGs5K0NESy9xcXRTMGQyUlduVjdFaTQ3L2xU?=
 =?utf-8?B?K2pXUEY5aEFLc3l4ZTRTekVBUEhjd1Z1MjVkZ3E0SDVvWVRBdkRQenJXeERv?=
 =?utf-8?B?ZEpGaDNOVW53WTNRWnFuUWJCMXpFdWQ3MFNIN3hrVTZmWEY2VEJzQ3o1T0pB?=
 =?utf-8?B?RWxVT1NQSWVPemwvcXRMemUzSGZ0WFIycGRSMGYrTTJVT3MvcXQ4eDBCV1Rv?=
 =?utf-8?B?YzF4Q1pBNFFrRlc3cjhLUDlhZFBjM1J3SHhnMGx3YjBsYjZ2b05tZ0xFNUs5?=
 =?utf-8?B?YzFCTTFsWTRkS0NKV3BITi8xdWFzam5xNXZrZ2doMm1RWGdrMHloY2ZYWU9n?=
 =?utf-8?B?VnlzdkZaMjNHa3prVyszUkx3SkJYZit5OXJYWGdmQXpKVVFna2c3VEliSTJq?=
 =?utf-8?B?ajU4UlMzd3VBY0dEM05oOURFYXNRK0F3dnlpUVZvZloySGc5VUVRMlVhRzhB?=
 =?utf-8?Q?tSvRf7b7IBc1/YuZBrsZc+v0G?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fe99ff-2c72-4350-9df8-08db8c5a54ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 15:26:20.0828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LiyV4NzpB7PT8T5EJWCLETCDjolG+jkdjwm7lkVU1jtJhpZocBEb1o4JV2OYdnFaAibaAqsL2JIKOvhhzJx77HIfxXPCkwdzEfoWrquDNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9073
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

SGkgTHVpeiwgDQoNCj5IaSBDbGF1ZGlhLA0KPg0KPk9uIFdlZCwgSnVsIDEyLCAyMDIzIGF0IDEw
OjQ14oCvQU0gTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+IHdy
b3RlOg0KPj4NCj4+IEhpIENsYXVkaWEsDQo+Pg0KPj4gT24gV2VkLCBKdWwgMTIsIDIwMjMgYXQg
NTo0NuKAr0FNIENsYXVkaWEgRHJhZ2hpY2VzY3UgDQo+PiA8Y2xhdWRpYS5yb3N1QG54cC5jb20+
IHdyb3RlOg0KPj4gPg0KPj4gPiBUaGlzIHNlcmllcyBvZiBwYXRjaGVzIGFkZHMgc3VwcG9ydCBm
b3IgQkFQIGJyb2FkY2FzdCBzaW5rLg0KPj4gPiBJdCBjb25zaXN0cyBpbiByZWdpc3RlcmluZyBh
IHNpbmsgZW5kcG9pbnQgdXNpbmcgdGhlIFNpbmsgUEFDIFVVSUQsIA0KPj4gPiBkaXNjb3Zlcmlu
ZyBvZiBicm9hZGNhc3QgYWR2ZXJ0aXNlcnMgdGhhdCBhbm5vdW5jZSB0aGUgQnJvYWRjYXN0IA0K
Pj4gPiBBdWRpbyBBbm5vdW5jZW1lbnQgc2VydmljZSwgc3luY2hyb25pemVzIHRvIHRoZSBQZXJp
b2RpYyANCj4+ID4gYWR2ZXJ0aXNlbWVudHMgb2YgdGhlIHNvdXJjZSBhbmQgc3luY2hyb25pemVz
IHRvIHRoZSBCSUcgYWR2ZXJ0aXNlZCANCj4+ID4gaW4gdGhlIFBBIHRyYWluLg0KPj4gPiBUbyBy
ZXRyaWV2ZSB0aGUgQkFTRSBpbmZvIGFkdmVydGlzZWQgaW4gdGhlIFBBIHRyYWluLCB0aGUgcGF0
Y2gNCj4+ID4gQmx1ZXRvb3RoOiBJU086IEFkZCBzdXBwb3J0IGZvciBwZXJpb2RpYyBhZHYgcmVw
b3J0cyBwcm9jZXNzaW5nIHdhcyANCj4+ID4gdXNlZC4NCj4+ID4NCj4+ID4gVGhpcyBmZWF0dXJl
IHdhcyB0ZXN0ZWQgdXNpbmcgYmx1ZXRvb3RoY3RsIHdpdGggdGhlIGZvbGxvd2luZyBjb21tYW5k
czoNCj4+ID4NCj4+ID4gW2JsdWV0b290aF0jIGVuZHBvaW50LnJlZ2lzdGVyIDAwMDAyYmM5LTAw
MDAtMTAwMC04MDAwLTAwODA1ZjliMzRmYiANCj4+ID4gMHgwNiBbL2xvY2FsL2VuZHBvaW50L2Vw
MF0gQXV0byBBY2NlcHQgKHllcy9ubyk6IHkgDQo+PiA+IFsvbG9jYWwvZW5kcG9pbnQvZXAwXSBN
YXggVHJhbnNwb3J0cyAoYXV0by92YWx1ZSk6IGEgDQo+PiA+IFsvbG9jYWwvZW5kcG9pbnQvZXAw
XSB1bmljYXN0L2Jyb2FkY2FzdCAodS9iKTogYiANCj4+ID4gWy9sb2NhbC9lbmRwb2ludC9lcDBd
IEJJRyAoYXV0by92YWx1ZSk6IGEgWy9sb2NhbC9lbmRwb2ludC9lcDBdIEJJUyANCj4+ID4gKGF1
dG8vdmFsdWUpOiBhDQo+Pg0KPj4gSXZlIHRob3VnaHQgd2Ugd291bGQgYmUgdXNpbmcgQkFBIFVV
SUQgaW5zdGVhZCB0byBmb2xsb3cgdGhlIHNhbWUgDQo+PiBzZXR1cCBhcyB0aGUgYnJvYWRjYXN0
ZXIgcm9sZS4NCg0KV2UgdGhpbmsgYWRkaW5nIGEgbmV3IFVVSUQgZm9yIHRoZSBicm9hZGNhc3Qg
c2luayAoMHgxODUxKSBhbG9uZyB3aXRoIHRoZQ0KVVVJRCBmb3IgdGhlIGJyb2FkY2FzdCBzb3Vy
Y2UgKDB4MTg1MikgaXMgdGhlIGJlc3QgY2hvaWNlIGJlY2F1c2Ugd2UgbmVlZA0KdG8gZGlmZmVy
ZW50aWF0ZSB0aGUgZW5kcG9pbnQgYW5kIHRyYW5zcG9ydCBpbiBvdGhlciBhcHBsaWNhdGlvbnMg
bGlrZSBQaXBlV2lyZS4NClRoaXMgZm9sbG93cyB0aGUgc2FtZSBwcm9jZWR1cmUgYXMgZm9yIGJh
cCB1bmljYXN0IHdoZXJlIFBBQ19TT1VSQ0VfVVVJRA0KYW5kIFBBQ19TSU5LX1VVSUQgYXJlIHVz
ZWQgdG8gZGlmZmVyZW50aWF0ZSBiZXR3ZWVuIEJBUCB1bmljYXN0IHNvdXJjZSBhbmQgc2luaw0K
ZW5kcG9pbnRzIGFuZCB0cmFuc3BvcnRzLg0KDQo+Pg0KPj4gPiBbYmx1ZXRvb3RoXSMgc2NhbiBv
bg0KPj4NCj4+IFRoZW4gd2hpbGUgc2Nhbm5pbmcgaWYgd2UgZmluZCBhbiBhbm5vdW5jZW1lbnQg
aXQgc2hvdWxkIGNyZWF0ZSBhIA0KPj4gcmVtb3RlIGVuZHBvaW50IHVuZGVyIHRoZSBkZXZpY2Ug
b2JqZWN0IHBhdGgsIGp1c3QgYXMgaW4gY2FzZSBvZiANCj4+IHVuaWNhc3QsIHdoaWNoIGNhbiBs
YXRlciBiZSB1c2VkIHdpdGggZW5kcG9pbnQuY29uZmlnLg0KPg0KPkkgaGFkIGEgZmV3IG1vcmUg
dGhvdWdodHMgYWJvdXQgaG93IHRvIGVudW1lcmF0ZSB0aGUgcmVtb3RlIGJyb2FkY2FzdCBlbmRw
b2ludHMsIHdlIG1heSB3YW50IHRvIGludHJvZHVjZSBhIGRyaXZlciBmb3IgQkFBIFVVSUQgc28g
d2hlbiBhIGRldmljZSBpcyBmb3VuZCB3aXRoIEJBQSBhcyBwYXJ0IG9mIHRoZSBhZHZlcnRpc2Vk
IA0KPlVVSUQgd291bGQgZ2V0IHByb2JlZCBhbmQgdGhlIGRyaXZlciBjYW4gdGFrZSBjYXJlIG9m
IGNyZWF0aW5nIHRoZSBNZWRpYUVuZHBvaW50IG9iamVjdHMgYmFzZWQgb2YgdGhlIGFkdmVydGlz
ZWQgZGF0YSwgcHJvYmFibHkgZWFjaCBCSVMgc2hvdWxkIGhhdmUgYSBlbmRwb2ludCwNCj4NCj4+
ID4gW2JsdWV0b290aF0jIGVuZHBvaW50LmNvbmZpZyAvb3JnL2JsdWV6L2hjaTAvcGFjX2JjYXN0
MA0KPj4gPiAvbG9jYWwvZW5kcG9pbnQvZXAwIDE2XzJfMSA8c291cmNlX2FkZHJlc3M+DQo+Pg0K
Pj4gSGVyZSB0aGVuIG9uZSB3b3VsZCByZXBsYWNlIC9vcmcvYmx1ZXovaGNpMC9wYWNfYmNhc3Qw
IHdpdGggdGhlIG9uZSANCj4+IGZvdW5kIGR1cmluZyB0aGUgc2Nhbm5pbmcsIHNvIHRoZSBkaWZm
ZXJlbmNlIHdpdGggYnJvYWRjYXN0ZXIgYmVjb21lcyANCj4+IHRoZSBzb3VyY2UgZW5kcG9pbnQs
IGlmIHlvdSBwYXNzIHRoZSBhZGFwdGVyIGl0IGlzIGZvciBicm9hZGNhc3RlciANCj4+IHJvbGUg
b3IgaW4gY2FzZSBpdCBpcyBhIHJlbW90ZSBlbmRwb2ludCB0aGUgaXQgaXMgZm9yIGxpc3RlbmVy
IHJvbGUgc28gDQo+PiB0aGUgY29tbWFuZHMgd291bGQgd29yayBzaW1pbGFybHkgaW4gYWxsIGRp
cmVjdGlvbnMNCj4+DQo+PiA+IENsYXVkaWEgRHJhZ2hpY2VzY3UgKDYpOg0KPj4gPiAgIGNsaWVu
dC9wbGF5ZXI6IEFkZCBicm9hZGNhc3Qgc2luayBlbmRwb2ludCByZWdpc3RyYXRpb24gYW5kDQo+
PiA+ICAgICBjb25maWd1cmF0aW9uLg0KPj4gPiAgIGNsaWVudC9tYWluOiBBZGQgYnJvYWRjYXN0
IHNvdXJjZSBkaXNjb3ZlcnkNCj4+ID4gICBtZWRpYTogQWRkIHN1cHBvcnQgZm9yIGEgYnJvYWRj
YXN0IHNpbmsgbWVkaWEgZW5kcG9pbnQNCj4+ID4gICB0cmFuc3BvcnQ6IFVwZGF0ZSB0cmFuc3Bv
cnQgcHJvcGVydGllcyBmb3IgYSBicm9hZGNhc3Qgc3RyZWFtDQo+PiA+ICAgYnRpbzogQWRkIHN1
cHBvcnQgZm9yIGdldHNvY2tvcHQoQlRfSVNPX0JBU0UpDQo+PiA+ICAgYmFwOiBBZGQgZ2RidXMg
aW50ZXJmYWNlIGZvciBCQVAgYnJvYWRjYXN0IHNpbmssIGNyZWF0ZQ0KPj4gPiAgICAgc3luY2hy
b25pemF0aW9uIHdpdGggc291cmNlIGFuZCBjcmVhdGUgQkFQIGJyb2FkY2FzdCBzaW5rIHN0cmVh
bQ0KPj4gPg0KPj4gPiAgYnRpby9idGlvLmMgICAgICAgICAgICAgICAgfCAgMTMgKy0NCj4+ID4g
IGNsaWVudC9tYWluLmMgICAgICAgICAgICAgIHwgIDU3ICsrKysrLQ0KPj4gPiAgY2xpZW50L3Bs
YXllci5jICAgICAgICAgICAgfCAxODcgKysrKysrKysrKysrKysrKysrKy0NCj4+ID4gIGNsaWVu
dC9wbGF5ZXIuaCAgICAgICAgICAgIHwgICAzICsNCj4+ID4gIHByb2ZpbGVzL2F1ZGlvL2JhcC5j
ICAgICAgIHwgMzQ3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0NCj4+ID4g
IHByb2ZpbGVzL2F1ZGlvL21lZGlhLmMgICAgIHwgIDM1ICsrKy0NCj4+ID4gIHByb2ZpbGVzL2F1
ZGlvL21lZGlhLmggICAgIHwgICAyICstDQo+PiA+ICBwcm9maWxlcy9hdWRpby90cmFuc3BvcnQu
YyB8IDI0NCArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4gPiAgc3JjL3NoYXJlZC9iYXAu
YyAgICAgICAgICAgfCAgNTAgKysrKystDQo+PiA+ICBzcmMvc2hhcmVkL2JhcC5oICAgICAgICAg
ICB8ICAgNCArLQ0KPj4gPiAgMTAgZmlsZXMgY2hhbmdlZCwgODg4IGluc2VydGlvbnMoKyksIDU0
IGRlbGV0aW9ucygtKQ0KPj4gPg0KPj4gPg0KPj4gPiBiYXNlLWNvbW1pdDogODM4ZTE1NzgwNzI5
MDBkMWY5OGRmYjMxY2M1Mzg5NDBkMmZhZDg3Ng0KPj4gPiAtLQ0KPj4gPiAyLjM0LjENCj4+ID4N
Cj4+DQo+Pg0KPj4gLS0NCj4+IEx1aXogQXVndXN0byB2b24gRGVudHoNCj4NCj4NCj4NCj4tLQ0K
Pkx1aXogQXVndXN0byB2b24gRGVudHoNCg==
