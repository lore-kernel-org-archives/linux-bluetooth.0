Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC7E7EB64DD
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 09:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjHIJqg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 05:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjHIJqe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 05:46:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE20ED
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 02:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7MwB3NuqosXV5izdX1XrwN0KyTC5BRIbLZQAREEkwbNRTL17x3qh90pXJ8lEvH7Xx/s7HDdFkXiK0vmYUzCzU/Dfk6SSBtCweFBO1CRZwdt93wvm7noSii6ge78+ZsyPOUq9rPTVGryFtxID/mXf8k9Q22o5a3/Hagw+u6qisAgzXHZ3z2nIkv146kwJWg5jJknnzuspAdozv4Rqfr716WRbNvx6UdpDQ1C7xxQnyyQK8FCsXJmefRQCXonoSl1h65Sso4LIfG+U9Iep1YezekU+ISIqkjxYqIH8MTJ6Yck1JJh+k5Lk6qMS0yrMgQxSxyReGzMoGfyBKuv6VwZKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+O2Qg/ewGsHkHkWgjNxbSMVHbOP3toZEHlKA7cAQ5Ms=;
 b=QuSEvossJUa9ae06RsuA0GP2MGltUALwpYezadQWUyqtIChAYBfoPnfNb+kaMptmBj2roWf6vgdbebexDhwr0BjzHXyKKadgfUK37+e7bUEiq0TMmUNcEx6vJjB7tT3U10TC/OuzxVrvU9TPKrm6m3q1FiHOBnbqv2LoPCA+HO5lLoL+aoO4a91ro3k4RPkP3cIKUq/PvfDdyaw8Dkv2O8CvkwbtvGTUi4t3rGdHpj2Amx34jpj2nV7LcDAJU8vLRNepZRe8rfn9WruGLCVpNOnLF5abp9hFA5mek2VYu4KkQS2ZyrMO92SjItX7Wojbm14HaXWxeHjqJRGqDd66ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+O2Qg/ewGsHkHkWgjNxbSMVHbOP3toZEHlKA7cAQ5Ms=;
 b=L9bTkFnVs9gvwU6r99uM0BOQOLlHZy20Kf1GZWSXwoR/PeeC7+hd2RLFLcqr4aTZ2cDAatPxIGp71C3gJRJOmGqbJz/nYovMSsDO9s3maa9bwRROLsM8+Hf3WrBh+65kowKFs2FZCEnXRu6mOc1QQrRvvbPiu8dGr4DnlCbtTV0=
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com (2603:10a6:803:4b::31)
 by DBBPR04MB7625.eurprd04.prod.outlook.com (2603:10a6:10:202::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 09:46:31 +0000
Received: from VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c]) by VI1PR04MB5344.eurprd04.prod.outlook.com
 ([fe80::cf28:7578:cc46:bc2c%5]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 09:46:30 +0000
From:   Silviu Florian Barbulescu <silviu.barbulescu@nxp.com>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Claudia Cristina Draghicescu <claudia.rosu@nxp.com>,
        Mihai-Octavian Urzica <mihai-octavian.urzica@nxp.com>,
        Vlad Pruteanu <vlad.pruteanu@nxp.com>,
        Andrei Istodorescu <andrei.istodorescu@nxp.com>,
        Iulia Tanasescu <iulia.tanasescu@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 0/2] Configure BASE using separate structure
Thread-Topic: [EXT] Re: [PATCH v2 0/2] Configure BASE using separate structure
Thread-Index: AQHZyR6xUnFW0mExLkGmRyf7FwfiKK/fFYQAgAKfRRA=
Date:   Wed, 9 Aug 2023 09:46:30 +0000
Message-ID: <VI1PR04MB53446602D3975AF7A5548A03EB12A@VI1PR04MB5344.eurprd04.prod.outlook.com>
References: <20230807110224.6024-1-silviu.barbulescu@nxp.com>
 <CABBYNZ+ecHHUfh=3rtXWwp-u2r0kSt-_SRWmYqUJBXgUs6S=oQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+ecHHUfh=3rtXWwp-u2r0kSt-_SRWmYqUJBXgUs6S=oQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR04MB5344:EE_|DBBPR04MB7625:EE_
x-ms-office365-filtering-correlation-id: 97a1e5ad-7ec9-4311-6d8b-08db98bd825d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Od5cSIzv3V9igcY3eIyjY3tcyaojVDOBu6WlT8T8G2RH/E646iPdTJLTkEvQjESawWwmktLLAg/wgWLIh2dO6zaV85d8g/xj6IiJ+PIFCKZPvUv4FJmoFRqKV8/9RPZR/3Nq9PUANddfyY44N+aAg/zNQe0bQ1eoz0C4rzJm6mroIiTk7ed9WSoMOlYvq4xrypj3xEHGn6i7VgUZxifKNiu+WgTS1fSghwLNNbBvPCabO9tzdisG2mykyfMl22cFjj/ZUy52LdrowBgy8qbcHKvX3FDhqHrqP+CWLZdgS8+sIrV88Hv9dlj8wLKRwrS67DfuoOGlC9C/tGjgdOBmLapfhw4ulCqv7bg0Aymeqv/JHX8pqbwpNKbpVhUj9/gEP3XTklbL1MwfkEtHUbV4F19xKByARH72cnc0U23X7m7PUdRQicu4bx7OPbORUxsX4ZrEUJnXfdcGjW6paF1arWNX/c4CtANMXYx2Gq0sySafAsVzruk7MImXblvzokHO0b+xPdsPXjACvmm1fN9RxIrBMGMHkjqKA5fWjXdViQO3tT3DgMa6PhoEScMNLP0yStvkPBtuOtgxJArVjZ3k8QZx1xpRW5vbbWL+Bi6WyautY/T5XcEkdzSjvnk322L
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5344.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(366004)(376002)(346002)(136003)(39860400002)(186006)(1800799006)(451199021)(478600001)(122000001)(83380400001)(9686003)(26005)(55016003)(6506007)(33656002)(66446008)(66476007)(66556008)(64756008)(8676002)(66946007)(76116006)(41300700001)(8936002)(316002)(4326008)(6916009)(2906002)(7696005)(71200400001)(54906003)(38100700002)(86362001)(38070700005)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OE1OVWpVcVIrOG9OclR6dVFzZERRVU9jMVBkQWFEZUU3YjcxQ1JqNmU2OGpX?=
 =?utf-8?B?ZXR6ZWIzaG8yRVJBOWdNTWZ3L3gyMlJzUlVNdjlET214dlpaNDUzSnIzemhX?=
 =?utf-8?B?d25FaXQyVHdlU2YveVpCdEZ4eXNBdzJNdGhwUWt2NWFUbXhSZTdPUDdHOElB?=
 =?utf-8?B?Wklob3RVSGZFeTIzR00zNzJZc0dDRjZNVE1ZWVNVMXJtMGpva1cveVFub21n?=
 =?utf-8?B?T1g4SnB1VXNlSW1QcFdyeDVoWGtHK0UzWmI3UXkxWkhtWHoyeEVlTExuZ0Jt?=
 =?utf-8?B?dThaYnhORDVtM2RXSlQ1T005bXJFd29vVTBHMjBIQjUrRVp3K2QxbVNnVWRQ?=
 =?utf-8?B?eW1PVlA0aURkdENlS3ZHWHNDbGFRUUR4ZUhDK2MyeEpCUUxVSmZUWEwxd1pM?=
 =?utf-8?B?VW9BUjlLS3k4NjRPQmIxMjdnbHlJY1p4OTlBYytML0JwWTVvWllDTTNwQWJ1?=
 =?utf-8?B?RWdRTlJDUERVVVE4ajVLQzNXSERVckVhWXBTSk03YlZxa0llU09TRGFDbndD?=
 =?utf-8?B?V3l5ZU1rOXp1Wk9SMFF0VFBianRuSCtlU2l5MnFuY3lvV29TM2JXSmFSdDBm?=
 =?utf-8?B?NGluVlVwM0I3cll2Z0h3b0Y2T1NJelpuOTd1SGM2ekp0L1lBRGRJRE5KTFQw?=
 =?utf-8?B?QnJDRXNJODFBRXg1ZEg3V0VyNzkrdUpOVFQ1eDQ3dWMyTWp4QXZYTkQrdEhO?=
 =?utf-8?B?WWJDYkUrWWR4Y2o5NHcyZ0Rtek54Rm5DN3NKZlpJWEpkSDI1OUMxSlZKL3Zx?=
 =?utf-8?B?VXJhR3J1OS9zVXlzYXByaDBRSlZ5ZkJoRG5abnVOT2FxN2ZXVUI3T2pWdEhL?=
 =?utf-8?B?MDc5cytkbWlTZnArdDQ5WGdwai9xUWl2RnpieElFU3FmM3I2TzhjcW1pVHQ3?=
 =?utf-8?B?b1c3d1VCaGZiL2Z0dThzYUxzVml6WlV0cDg4TktjYk5Yc2ptWmpVUVA4b1kz?=
 =?utf-8?B?ZEtRUlFIeElIbnpFaWt3ZndhTTFmTWY2ajhyNXpzREpnMW5QOHpBOG9sZEZp?=
 =?utf-8?B?aVpIZEtISVF4NjVqZVNlbWxkN1BLd2h3dTdIVkpZS2xBM21mUkpYMlZRbWNN?=
 =?utf-8?B?bzZEc0FqclgwYk1Gc0pFT0ZWbWJEMlJvZjgyM2N6N3laSkVtMnNFdUI0a3Fk?=
 =?utf-8?B?V1ovNThYb0gvbVh0TmdrTzV5cHFXU05KSm5wMlZNcHRhQWxUaGQxa201VlNB?=
 =?utf-8?B?Zk0vM2hBa0RCTzlPcXFoM0JZZFh0YmNNellURmlheGN2QW5iT1JqZlJIRktk?=
 =?utf-8?B?bUErdFVhRlN5R2tmaEJEM2lCT0cwYlJpVlgzUlJneHVJRFBycjVMS1lBcmo5?=
 =?utf-8?B?Y09KKy9RNTAyb20yWUpyZ0REODhQZlUrelZyY0Z5bytTenN0dUcwREJTZmV2?=
 =?utf-8?B?WTNqQ2FiTHk1aDA4VTJ3Q080R3IrTnlJQkJTRGNMYUlINXhBVmh4bmlzaGdm?=
 =?utf-8?B?VDJUbWJTUStnaGVTWUlZaXE2RjZNRjVGUG9mbzd1cXVhUkRCWHJKNTFmUy9n?=
 =?utf-8?B?M0M4MkVJOU12WGF1dm1GakJXRmIwTGlNeWlTeGI1cDM2M3IwL3c1OWlxWjBv?=
 =?utf-8?B?aTZrTGRxUTBIZTVQamVNbGZQWWNTYTJNaGwzQk1MbVFROXI2S3hhNG1YYUFj?=
 =?utf-8?B?UWZMdUc3c1RqNkliWTNxcG5KTkJLbCttRjRXQW9zU3RyZXhXclZucVhIL1FL?=
 =?utf-8?B?alNWQVc0WWVlWU5rckZqTTgrTXVlcWZneDVoQytGb0NPMGVvMjZZeTNIRXBx?=
 =?utf-8?B?NEkyZDRXU09ES0RQclZFSk5GaTI4emg0eHhzaW5ocXRoVEwwem5iczJhc3ZY?=
 =?utf-8?B?NDhSTmlSV05Ic0RWdFNMMno3UWRJNjdUMjJybFFqdksxMXZOUW1xQkhPczd3?=
 =?utf-8?B?RUhPU2xMdG5lWVZaSE1xUGhjZmNsancyVjdRclNPR0FsMkJZelg4N0ZLMURH?=
 =?utf-8?B?aVQ3RHd1R2NCQUdEUnNTMlZQUjdyelE5YUw2UG9mZk9xNDBiWVkwTTNpeVpq?=
 =?utf-8?B?MXExd1NvV0o4MDlTSmVWTTVVUnBvNkxjS0RYY3VVK28zeDZwRFpxWW5FVllz?=
 =?utf-8?B?ZVgwRkFNNHIvMkUvWGtpRzVQbWlhWVF4K2hjSUlwOUQrdEJQSjYxeTZOdkdE?=
 =?utf-8?Q?97FzSjcW2mAEEBc2dsrWGv2wh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5344.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a1e5ad-7ec9-4311-6d8b-08db98bd825d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 09:46:30.6308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7inPnCcddHajNnDqqezi6XWeOb9jHIxSQ/XRbMYwas5iT2O6ly98co5d5sSAWqgjv4uMFCnBOsvNSkAVsXQQ6+Mod0Kd5eldUhM56oN8t14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7625
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

PkZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPiANCj5T
ZW50OiBNb25kYXksIEF1Z3VzdCA3LCAyMDIzIDg6MjMgUE0NCj5UbzogU2lsdml1IEZsb3JpYW4g
QmFyYnVsZXNjdSA8c2lsdml1LmJhcmJ1bGVzY3VAbnhwLmNvbT4NCj5DYzogbGludXgtYmx1ZXRv
b3RoQHZnZXIua2VybmVsLm9yZzsgQ2xhdWRpYSBDcmlzdGluYSBEcmFnaGljZXNjdSA8Y2xhdWRp
YS5yb3N1QG54cC5jb20+OyBNaWhhaS1PY3RhdmlhbiBVcnppY2EgPG1paGFpLW9jdGF2aWFuLnVy
emljYUBueHAuY29tPjsgVmxhZCBQcnV0ZWFudSA8dmxhZC5wcnV0ZWFudUBueHAuY29tPjsgQW5k
cmVpIElzdG9kb3Jlc2N1IDxhbmRyZWkuaXN0b2RvcmVzY3VAbnhwLmNvbT47IEl1bGlhIFRhbmFz
ZXNjdSA8aXVsaWEudGFuYXNlc2N1QG54cC5jb20+DQo+U3ViamVjdDogW0VYVF0gUmU6IFtQQVRD
SCB2MiAwLzJdIENvbmZpZ3VyZSBCQVNFIHVzaW5nIHNlcGFyYXRlIHN0cnVjdHVyZQ0KPg0KPkNh
dXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBj
bGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBv
cnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+
DQo+SGkgU2lsdml1LA0KPg0KPk9uIE1vbiwgQXVnIDcsIDIwMjMgYXQgNDoxMeKAr0FNIFNpbHZp
dSBGbG9yaWFuIEJhcmJ1bGVzY3UgPHNpbHZpdS5iYXJidWxlc2N1QG54cC5jb20+IHdyb3RlOg0K
Pj4NCj4+IFVzZSBwcmVzZXQgY29uZmlndXJhdGlvbiBpbiBjYXBhYmlsaXRpZXMuDQo+PiBDb25m
aWd1cmUgQkFTRSB1c2luZyBzZXBhcmF0ZSBzdHJ1Y3R1cmUuDQo+DQo+SW0gbm90IHJlYWxseSBz
dXJlIHdoeSB3ZSB3YW50IHRvIHN3aXRjaCB0byB1c2UgQkFTRSBvdmVyIENhcGFiaWxpdGllcywg
dXAgdW50aWwgbm93IENhcGFiaWxpdGllcyBpcyBzb3J0IG9mIG1hbmRhdG9yeSBhbmQgaXMgYWxy
ZWFkeSBwcm9maWxlIHNwZWNpZmljIGluIGNhc2UgeW91IGFyZSB3b25kZXJpbmcgaG93IGNhbiBz
b21lb25lIGRldGVjdCB3aGF0IGlzIHRoZSBmb3JtYXQgdXNlZCBpbiBDYXBhYmlsaXRpZXMgdGhh
dCBpcyBiYXNlZCBvbiB0aGUgVVVJRCBhbHJlYWR5Lg0KDQpIaSBMdWl6LCB3ZSBkb24ndCBpbnRl
bmQgdG8gc3dpdGNoIHVzZSBCQVNFIG92ZXIgQ2FwYWJpbGl0aWVzLCB3ZSBqdXN0IHdhbnQgdG8g
dXNlIGJvdGggZm9yIGJyb2FkY2FzdC4gQ2FwYWJpbGl0aWVzIGZvciBjb2RlYyBjYXBhYmlsaXRp
ZXMgZnJvbSBwcmVzZXQgdGhhdCB3aWxsIGJlIHVzZWQgaW4gdHJhbnNwb3J0IGNvbmZpZ3VyYXRp
b24uIEJBU0UgaXMgdXNlZCBmb3IgdGhlIG92ZXItdGhlLWFpciBwYXlsb2FkIGluIFBlcmlvZGlj
IEFkdiBEYXRhIHdoaWNoIGlzIGNvbmZvcm1hbnQgdG8gVGFibGUgMy4xNTogRm9ybWF0IG9mIEJB
U0UgdXNlZCBpbiBCYXNpYyBBdWRpbyBBbm5vdW5jZW1lbnRzIGZyb20gQkFQIFNwZWNpZmljYXRp
b24sIGFsc28gaXQgaXMgdXNlZCBmb3IgUFRTIHRlc3RpbmcgdGhhdCBhc2sgdG8gbW9kaWZ5IHRo
ZSBCQVNFIHN0cnVjdHVyZS4gQW5kIHdlIHdpbGwgY29weSB0aGUgY2FwYWJpbGl0aWVzIHByZXNl
dCB0byB0aGUgYmFzZSBzdHJ1Y3R1cmUgdG8gYmUgc3VyZSB3ZSBoYXZlIHRoZSBzYW1lIGNvZGVj
IGNhcGFiaWxpdGllcyBpbiBib3RoIG9mIHRoZW0uIA0KDQo+DQo+PiBDbGF1ZGlhIERyYWdoaWNl
c2N1ICgyKToNCj4+ICAgY2xpZW50L3BsYXllcjogVXNlIHByZXNldCBjb25maWd1cmF0aW9uIGlu
IGNhcGFiaWxpdGllcy4gQ29uZmlndXJlDQo+PiAgICAgQkFTRSB1c2luZyBzZXBhcmF0ZSBzdHJ1
Y3R1cmUNCj4+ICAgYmFwOiBVc2UgdGhlIEJBU0Ugc3RydWN0dXJlIHJlY2VpdmVkIGZyb20gdXBw
ZXIgbGF5ZXINCj4+DQo+PiAgY2xpZW50L3BsYXllci5jICAgICAgfCAyNCArKysrKysrKysrKysr
KysrKy0tLS0tLS0NCj4+ICBwcm9maWxlcy9hdWRpby9iYXAuYyB8IDEzICsrKysrKysrKystLS0N
Cj4+ICAyIGZpbGVzIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0K
Pj4NCj4+DQo+PiBiYXNlLWNvbW1pdDogODAxMDc2MzAzOTZkM2QzYTM5ODRjNTk5ZTBjYjliMDE1
YmUwNDk5Yw0KPj4gLS0NCj4+IDIuMzQuMQ0KPj4NCj4NCj4NCj4tLQ0KPkx1aXogQXVndXN0byB2
b24gRGVudHoNCg==
