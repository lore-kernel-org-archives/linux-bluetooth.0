Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2082.outbound.protection.outlook.com [40.107.6.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB13A51016
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 09:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713776468; cv=fail; b=jeXmh1a9o7sig7+QnzyR33gZkDn6GwlDEhUE1T0/AZJiI3zRvNSJG+XXM+G53aZidsfcSJ39Qa1zYpsJnRAhxDiv5qu8/dwu6WTXVJ4yaPptcHY0BE0wuz6ZyE408mqPhMDRxK+t7T6RqhcYNjW+5tW3iFKDulOyA8C299W1Mus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713776468; c=relaxed/simple;
	bh=HHiLsqLhAVooJdBZS/yX0rO3fSbJZts2wjUBU6UiQ/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CVkceastnUeJ68aQplxUyl5EnTPotfXN3safASM77KTdAytcCm+8JRzbYJCCgRcjzsaYQjmGEh0YbKoB13EOxv5/d156UtxgQmWq8ht8iMRp4xgeffJz9MDE+ALlfFS35MI60oKLOk9aww6LnodTdEyoRi2jUWAx5ANXH5x/bFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KvVHBmWk; arc=fail smtp.client-ip=40.107.6.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KvVHBmWk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IF+zprj/CNeoQc2yJ2SChBHlSSPPgcEheD8WAxFbWMRaX9QCJ/fXTrSow3egKrW9+G0nLQbFGgUnZIh7ZxMfDjLDQ36cRnIwC4ILuuuBQ6vaYiWSJRpwPb8my0zXoeZChf+IzL3A8ShSsYwaXdETp4SLzkZEaqYKuj7B2AFWin9GCciN2axoF5eZPeDX4C82fxOiqUQHHAk/vNwpRoLo4pGotrzj9b8fpqYJb7vx6iv29MohzEfZwJ/x6DIVhsPquUbP+d31nLHZ52Pwxz/ZVcxur05iEhdFAhk89WqvcHGMhtD5/CjD4qF+pqevg74hxaRo9gQ8HLxlnMlmPQiTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHiLsqLhAVooJdBZS/yX0rO3fSbJZts2wjUBU6UiQ/g=;
 b=JQoxQo3wwXtfmeLejmWTxma8C9yr4L55Ye4GBMdbwrMZ5gnvMpAc70B4J/rkgaFBWMi0/bhOnYo00zidw2kW84Bs8MzIOflxQJV2oBbGPJoRluWsm1JjOP+NKjaTYVI8UVyP077niiq2QWfL0uVGYT1h20umgeYw+z7QCT8WzxlCMxkPb4BmT79TO9I98Vs2yLVy+x9XCEzwtEJ8j7eN/amagX+E9NtoBxAU3L4lQ9sJTvaPEu7/EKkydu1uCScI7LqMnYmRq94DucW12hBdR7p05+Hdla5pG5wa16E09dRXh35KZGDuElwBO52jJVzIBb78PO9tQWKKEBBTIDbW3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHiLsqLhAVooJdBZS/yX0rO3fSbJZts2wjUBU6UiQ/g=;
 b=KvVHBmWkKnxSOJMbBHqBopxSXbVrkWNMAewZBsPs7MWAjLneq5DdsutDm2BG1ihBA/gJ1/LdmfFo6jSY+mv5zgjqleuae7wF7jSNJKV69yfVuuU5glJlksk485APALfGgkiy5qa55oVWhAtnKhLEPM02zJ71RUFtW6ORLd90yS0=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by AS8PR04MB8786.eurprd04.prod.outlook.com (2603:10a6:20b:42d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 09:01:00 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::361b:7c80:c98:57f]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::361b:7c80:c98:57f%7]) with mapi id 15.20.7472.044; Mon, 22 Apr 2024
 09:01:00 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Index: AQHaeTEPMqiC0Iq8WEO4vPnWaUEu4LFAZciAgAAQ9bCAAA5eAIAzrrFQ
Date: Mon, 22 Apr 2024 09:01:00 +0000
Message-ID:
 <AS5PR04MB9754B55170413A2FD0A00F0A89122@AS5PR04MB9754.eurprd04.prod.outlook.com>
References: <20240318123712.9729-1-mahesh.talewad@nxp.com>
 <20240318123712.9729-2-mahesh.talewad@nxp.com>
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
 <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZK5YS6paOYbx4yL6R7Wt9o+oGrtmfiQNmOaTAUo2DBfdQ@mail.gmail.com>
In-Reply-To:
 <CABBYNZK5YS6paOYbx4yL6R7Wt9o+oGrtmfiQNmOaTAUo2DBfdQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR04MB9754:EE_|AS8PR04MB8786:EE_
x-ms-office365-filtering-correlation-id: e866810a-e1a8-432c-ea1b-08dc62aabb53
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?bUpTZTAwSGxuQXNRd2pKRHZQSEdCblNXMDhkV2cyUS9BZjZKWXMvN2U0azRz?=
 =?utf-8?B?YThQRDF6ZGtBM2RGcXNCOWRtdFNHSFFPdFhmMkNyUEpLOEkxOFBtSCt6VHU1?=
 =?utf-8?B?enQ2azEwZ1BwRTgzM2hZWTNLVEVybFcvanVNSUF6eHgvYS9VaFNscnNvK2Zw?=
 =?utf-8?B?M3dFRnpLS2NUZENzRm5pdVQ0eXhpeGllTyttdXduN3dyNVNjNnJpMVhMNHNI?=
 =?utf-8?B?SGJLQ0s5cTNxVXgxTGt1Y0V1WUNoTE1ybjhuaG9YbkF6RldIT0hoVGFOQ0xN?=
 =?utf-8?B?YmNiWmhLQnZ6dGx0STV3UjJQRjlMZlhhM1M5SUNzU3dpcFk4T2o0WG9yQVA3?=
 =?utf-8?B?ZXV1Y0h4OVBxWm8wSGVXdmxBUkNZVFlGLzVCSzNSUWExeXBzV2JBUTV0dW9D?=
 =?utf-8?B?TGdtYTMySGFPOW5KZ3phcmJqZGJWTy9TK09MZFFKcnlDcyttY0JJNm5iY0dB?=
 =?utf-8?B?V1E1ejA4VVFsajdlQmhITnVDME5NakVFTy9ybU40YVlxa1BZQXFvS3l1ZHNC?=
 =?utf-8?B?dS9hT1pLbFZsRHo4ODJLajNXVzdEdnpDM3Vmd05VZWlEWTEvV1pKKzVSejVF?=
 =?utf-8?B?c3ZmeDhYMlpzN1Y4NjZuTVo0a1ZoQW1hWllSNG5vMGNuOUxyejh5c1lFTzUr?=
 =?utf-8?B?NGZ4RVBPOGh0ck5oaEtjd3ZVOGVHM1N1ZWNGUmUxSStzNkNwRDNMNnhseHJD?=
 =?utf-8?B?YUVBMFJjMEFhbXczY0tVTHhJNmtFRkpaSXVFNFNkQ29YcjhVcWcvbTd3a2E3?=
 =?utf-8?B?UzhPcVpQakl1VDh6MStyejNsWDY2SWNxNDBGaytzemdvdXNMMXI2d2FCd0lY?=
 =?utf-8?B?RUZ6VUlDdG5vTlhjbE9RZ2ptZEZhTGV6T01uSWZzWCswQ0gwdUlVczJyeTJh?=
 =?utf-8?B?R1V0QzFBVS9CM1pkNzF0Qk1sVVB1NUxEMjd0TjJLRUgzRTN4ZkpTbnZjajJ5?=
 =?utf-8?B?dDVTNUN0anYrc1lEWXVvb0ppaE5nWFV1Y2EzRDU0ZkFvTnd4MDFuMXFZNHhp?=
 =?utf-8?B?a0RhL3F6SmJuOGFYOUFVWkpwKzlLaStFM1l6WjhoN29FRkNpbWtTd0ZqU0dN?=
 =?utf-8?B?blA1dDBXQ3ZKalRMa0hVUHgrYXZaNjZoQ0lMSjBtSzFpQW5kUzZubjh2L0xr?=
 =?utf-8?B?empROE5Qd2RyMG5aNS9DUFdwZGNDbENlRXQyYkNDdVNSNURXd2lvN0FXVEc3?=
 =?utf-8?B?bFBHS1FwdjByck1ERTEvaFZIWGNYRWI2dGpRc2Yyc2p3bjVkaGtqMzFXc1BY?=
 =?utf-8?B?NUdRdWdkUngwWTVZVGQ2UWI2ai9LNHdQZy80bC9Ib1VHODlWTHlCZUR3dmEx?=
 =?utf-8?B?eG4rSERFNXJsRHo4TmZZNU5hS0RWMmlxN21xSWRGRUlrNTdidkFqNkVnUnlR?=
 =?utf-8?B?MExzN002dCs0SFl1d0Y2ZFVYRVh3SEVUZjBUL2pBN3dUM21iNkgySUhvQmxn?=
 =?utf-8?B?STRzM0huN3UyUlgxVy9ERmlhNFpjU2h1VldxaDVqRTEvNnJWQ1ZtMWRHbHFt?=
 =?utf-8?B?Z3g1Uzh2QktKNTZVa09BQjhENk5iS1RkdG9hK3pzR2VTbDVnbGNWaVV4ajZ3?=
 =?utf-8?B?YU1rRVZPNWxkTkl5Tzl2OFZTQ25PakY0RnpReWF5Qi9XVS9RUlZLV05SR041?=
 =?utf-8?B?QUFlZXRnS1B6c2tNMzdzMmg2Zmh2SE5zSmZXMm1YeW1PazFhSXc5dzFZeUgr?=
 =?utf-8?B?WFpjaDlWcWJyT3NEUWFOVnE0R2RtMDh4VFBrYWlvdVIxVktDTjRxc3I4ZFFw?=
 =?utf-8?B?bEdWREFvSERkejd6aTg0ZHIxWDNBYnJvR1dIejg3RERNQWNCdUt3eHdwQ3pa?=
 =?utf-8?B?YXFidEFTUmFRUDhSazJLdz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dDRtQms1ZmJIWXBIbGtSYnJMWUthcWlKVHVQd1F2VEg4SkNzN2FQQkVPUmhK?=
 =?utf-8?B?clBRS1c4SGZ2REtYaWN3TWNpTXl0eUFmeHg3eDN6VmJwL1dySUhwb0VWbG1X?=
 =?utf-8?B?NnRVaUc5azl2MVVzVHl6WGthVXpXbDR6ODErWnlURDg5SlRrZ0tzRnR3Yld5?=
 =?utf-8?B?a29sZVJSR09kSE52OVBTSWE5NU14b1hXRkk3b2piOHNkQWpHMGJkN3NEaTFv?=
 =?utf-8?B?dUdLaW8vTUNBZEF2Ylc2NmVwTjNBSGZkVXdUVnQwV1NkL3dVS1REcHJsNzUv?=
 =?utf-8?B?TkFzblNnMWREUjN5Ky9MMzFkSjRyZEEwanpJN1E4ZjdDbU12azgycmdBTkJv?=
 =?utf-8?B?enRpWkIxclN0RkF1M2xidDNKY3BjbTVFU21NaE9VSUs4U1lpSHB2eitCM2tB?=
 =?utf-8?B?aVE1Zno0UW0waWpGZXNvajE5T0ptd1VhT1N2UXRCZGExaXo4dmxvakdzYm0r?=
 =?utf-8?B?NjE2TUF6eHcyQ04zSnFKTFl2eUFDd25sbXUzenRLZmVzRDBPbWNnZnVtd1lO?=
 =?utf-8?B?RWRiVmM3aW1CVDlnbDZxNTRsY1Q3bnVKRmlTSEVYekRoODhQWDJVRW9uMm55?=
 =?utf-8?B?THZqUWwrbzVKbU1TNVB2Y0JBRjJrektabU9zLzBudVF4WU4vSmZNcDVXYmVK?=
 =?utf-8?B?RnF0NElnVHcxV1hGM0tSRjdPcmp3V0lpcWYydHBSQ2ZKVmlaQWZObGorTG1m?=
 =?utf-8?B?M3ZGdDd0ZDlWTTN5RUd3UUhqK2JDTVBUczRZNmJxbEJqcUttWitBZTF3S2Jw?=
 =?utf-8?B?cWZub1JGSHEvQmhha3d2T0ZGMWVvWG9td2dwbWQxSGFtRXFxOTFTWXkvRHUy?=
 =?utf-8?B?REhSaGVjVXNtWU5PNmwwY21Kbi9rUklmTjBXNm5qRkVvNUhodTAvdnZKZDNE?=
 =?utf-8?B?b3lRN0NIcTJtR215Y3puK0FWWFpRa0JZUEtXOFJaNmlwbVlHcW5NS2szZnBV?=
 =?utf-8?B?VXFibStpMTZQN1VQbXBvNXRReisrYkI2NkFsSGhEc2hPMVdMVVFwYXVGM2hH?=
 =?utf-8?B?T3RlM3AwVzJlb3BWakpya2hWVVZldzFISm9ZbW9PUFp5WVJCSnQ4R2ZWUlJG?=
 =?utf-8?B?QmRwTy81Q1NSSzVyd0lGTzBFdUZSTGIyZVBVMC9zZjNJR1FBVTdNVzRLcE1l?=
 =?utf-8?B?OHJjUkZoa2gyUVhHaEFMM0JNRld3WURkdHVQV0FsdGRRMG1Bemw4MnFuYmkz?=
 =?utf-8?B?TDNNOW9zZjRKTFQ0V2xheXphbWtLWkpyQ01nMmczYXlOdGxVZjViZWozbWwy?=
 =?utf-8?B?UDIrUzhBajdBbXNQUEJ3ZEgvQUlIcnYyR2R1emtCdStCVk5OL3BaVjg0aDJq?=
 =?utf-8?B?cVdPZmE0dFhiUThZNXNDczZVY3pNK2FVeXpXMEZFaGsyWHFCMmt5N25pV0ZS?=
 =?utf-8?B?Ym1VcTI2eklFNEkrSlBzR3RDOFZtSlZ6WUlxaVNjdWptOGVybTllcHQ4aUxO?=
 =?utf-8?B?aGdxT2V3M0pyV3g1TnVDTlh5ZXplb3NqTXdSemtMbVdkQTRtbktMZ2QzRTdC?=
 =?utf-8?B?elB4WDFiY0M3amovZGNyN2lYOGxQWkE4UWpsVEo5SU13RTRpUG1rUTVGLzEy?=
 =?utf-8?B?SjF2RnFodFhHb2txTDJuOFQxSW0rdjR2VUZGaktiT0gyMXNPMm1yeDYyTEg5?=
 =?utf-8?B?NnRtd1Z3aGprVUVlMHUvYzI0YU1yZmZjUnBtRjljY0NNbXQzWEliV1hIVk8y?=
 =?utf-8?B?Y3pTank3ZmJEVFo4d3hRaFV4WDNIUXF6ZkRKZU1OeGtQUDlZV3JaTmk3U08z?=
 =?utf-8?B?QlJzd3B3cnA2MlN0cVN4TFY4NTNqaURUdU5IazRLUENqdGZiTFNvQ1JUbDdx?=
 =?utf-8?B?YU4wekxMaE1mYW5YUmxiNSt0RkVaWWR5UW84MkY0ZGo5SjVHZXFDYllpUVBj?=
 =?utf-8?B?eXpIbU1mS1lFTDIzUDJEdnV0U0pOaXNLazdoTWJFL0Q2N0tWMjdjOGJCdGp0?=
 =?utf-8?B?SzJqekEyYWd2R1ArMXZZZE8wajNUcnQzakNram1UWW5GY3l2NC80alNlTUow?=
 =?utf-8?B?Ukt4bjFQUE02Vk9hT1BkYlEyTnZOR1ZYeG9zdElqa0NDbzdocVNqSi9URndB?=
 =?utf-8?B?VVJsRDFRWm1xVFpnUC9HcHREdERHOVBzMGhRclloa3FYRWE3b2lFUGFwcDBz?=
 =?utf-8?Q?9QaRZuShmK4i7kVAgpY/5sEVk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS5PR04MB9754.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e866810a-e1a8-432c-ea1b-08dc62aabb53
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2024 09:01:00.6432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xbh0fACbDVxE80Ixlr3sWOZmRe25LVa3LO8um1OqEN/qPvHQhNTUzjKmHKeRathPY7p8wCQl4v8UVe54HxHGyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8786

SGkgTHVpeiwNCg0KT24gb3VyIERVVCwgd2UgY2FuIHNlZSB0aGF0IHRoZSBob3N0IGlzc3VlcyBj
cmVhdGUgY29ubmVjdGlvbiBjYW5jZWwgY29tbWFuZCBhZnRlciA0LXNlYyBpZiB0aGVyZSBpcyBu
byBjb25uZWN0aW9uIGNvbXBsZXRlIGV2ZW50IGZvciBMRSBjcmVhdGUgY29ubmVjdGlvbiBjbWQu
DQpBcyBwZXIgY29yZSBzcGVjIHY1LjMgc2VjdGlvbiA3LjguNSwgYWR2ZXJ0aXNlbWVudCBpbnRl
cnZhbCByYW5nZSBpcyAtDQoNCkFkdmVydGlzaW5nX0ludGVydmFsX01pbg0KRGVmYXVsdCA6IDB4
MDgwMCgxLjI4cykNClRpbWUgUmFuZ2U6IDIwbXMgdG8gMTAuMjRzDQoNCkFkdmVydGlzaW5nX0lu
dGVydmFsX01heA0KRGVmYXVsdCA6IDB4MDgwMCgxLjI4cykNClRpbWUgUmFuZ2U6IDIwbXMgdG8g
MTAuMjRzDQoNCklmIHRoZSByZW1vdGUgZGV2aWNlIGlzIHVzaW5nIGFkdiBpbnRlcnZhbCBvZiA+
IDQgc2VjLCBpdCBpcyBkaWZmaWN1bHQgdG8gbWFrZSBhIGNvbm5lY3Rpb24gd2l0aCB0aGUgY3Vy
cmVudCB0aW1lb3V0IHZhbHVlLg0KQWxzbywgd2l0aCB0aGUgZGVmYXVsdCBpbnRlcnZhbCBvZiAx
LjI4IHNlYywgd2Ugd2lsbCBnZXQgb25seSAzIGNoYW5jZXMgdG8gY2FwdHVyZSB0aGUgYWR2IHBh
Y2tldHMgd2l0aCB0aGUgNCBzZWMgd2luZG93Lg0KSGVuY2Ugd2Ugd2FudCB0byBpbmNyZWFzZSB0
aGlzIHRpbWVvdXQgdG8gMjBzZWMuDQpOb3RlOiBJbiBBbmRyb2lkIHRoaXMgdGltZW91dCB2YWx1
ZSBpcyAyOSBzZWNzLg0KRG9lcyBzZXR0aW5nIHZpYSAnY29ubi0+Y29ubl90aW1lb3V0JyBtZWFu
IHNldHRpbmcgJ0F1dG9jb25uZWN0dGltZW91dD12YWx1ZScgaW4gbWFpbi5jb25mIGZpbGU/DQoN
ClRoYW5rcyBhbmQgcmVnYXJkcywNCk1haGVzaCBWaXRoYWwgVGFsZXdhZA0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50
ekBnbWFpbC5jb20+IA0KU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyMCwgMjAyNCA1OjEzIFBNDQpU
bzogTWFoZXNoIFRhbGV3YWQgPG1haGVzaC50YWxld2FkQG54cC5jb20+DQpDYzogbGludXgtYmx1
ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgRGV2eWFuaSBHb2Rib2xlIDxkZXZ5YW5pLmdvZGJvbGVA
bnhwLmNvbT47IFNhcnZlc2h3YXIgQmFqYWogPHNhcnZlc2h3YXIuYmFqYWpAbnhwLmNvbT4NClN1
YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIEJsdWVaIHYxIDEvMV0gTEUgQ3JlYXRlIENvbm5l
Y3Rpb24gY29tbWFuZCB0aW1lb3V0IGluY3JlYXNlZCB0byAyMCBzZWNzIGZyb20gNCBzZWNzDQoN
CkNhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hl
biBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCBy
ZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQoN
Cg0KSGkgTWFoZXNoLA0KDQpPbiBXZWQsIE1hciAyMCwgMjAyNCBhdCAxMDo1NuKAr0FNIE1haGVz
aCBUYWxld2FkIDxtYWhlc2gudGFsZXdhZEBueHAuY29tPiB3cm90ZToNCj4NCj4gSGkgTHVpeiwN
Cj4NCj4gWWVzLCBpdHMgYXV0byBjb25uZWN0IHNjZW5hcmlvLg0KPiBXaGlsZSBydW5uaW5nIGNv
bm5lY3QgZGlzY29ubmVjdCBpbiBhIGxvb3Agb24gb25lIG9mIHRoZSBjaGlwLCB3ZSBhcmUgZ2V0
dGluZyBpc3N1ZSB3aXRoIHRoaXMgZGVmYXVsdCB0aW1lb3V0IC4gSGVuY2Ugd2UgaW5jcmVhc2Vk
IHRoaXMgdGltZW91dCB2YWx1ZSB0byBzdGFuZGFyZCBMRSB0aW1lb3V0IGkuZSAyMHMuDQo+IEtp
bmRseSBsZXQgdXMga25vdywgaXMgdGhlcmUgYW55IHRpbWVvdXQgZXhwbGljaXRseSBkZWZpbmVk
IGZvciB0aGUgYXV0b2Nvbm5lY3QgaW4gdGhlIHNwZWMuDQoNCldoYXQgZXhhY3RseSBpcyB0aGUg
aXNzdWUgdGhvdWdoLCBvciBhcmUgeW91IHNheWluZyBpdCBpcyBhIGNvbnRyb2xsZXIgaXNzdWUg
YmVjYXVzZSB0aGUgYXR0ZW1wdHMgYXJlIHRvbyBjbG9zZWx5IHRvZ2V0aGVyIHdoZW4gdGhlIHRp
bWVvdXQgaXMganVzdCA0IHNlY29uZHMsIG5vdGUgdGhhdCB5b3UgYXJlIGp1c3Qgd29ya2luZyBh
cm91bmQgdGhlIHByb2JsZW0gYmVjYXVzZSB1c2VycyBjYW4gYnlwYXNzIHRoZSBkZWZhdWx0IHdo
ZW4gc2V0IHZpYSBjb25uLT5jb25uX3RpbWVvdXQuDQoNCj4gVGhhbmtzIGFuZCByZWdhcmRzLA0K
PiBNYWhlc2ggVml0aGFsIFRhbGV3YWQNCj4NCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0N
Cj4gRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIwMjQgMzoyMSBQTQ0KPiBUbzogTWFoZXNoIFRh
bGV3YWQgPG1haGVzaC50YWxld2FkQG54cC5jb20+DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdl
ci5rZXJuZWwub3JnOyBEZXZ5YW5pIEdvZGJvbGUgDQo+IDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNv
bT47IFNhcnZlc2h3YXIgQmFqYWogPHNhcnZlc2h3YXIuYmFqYWpAbnhwLmNvbT4NCj4gU3ViamVj
dDogW0VYVF0gUmU6IFtQQVRDSCBCbHVlWiB2MSAxLzFdIExFIENyZWF0ZSBDb25uZWN0aW9uIGNv
bW1hbmQgDQo+IHRpbWVvdXQgaW5jcmVhc2VkIHRvIDIwIHNlY3MgZnJvbSA0IHNlY3MNCj4NCj4g
Q2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVu
IGNsaWNraW5nIA0KPiBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0
LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgDQo+IHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1
dHRvbg0KPg0KPg0KPiBIaSBNYWhlc2gsDQo+DQo+IE9uIE1vbiwgTWFyIDE4LCAyMDI0IGF0IDEy
OjM34oCvUE0gTWFoZXNoIFRhbGV3YWQgPG1haGVzaC50YWxld2FkQG54cC5jb20+IHdyb3RlOg0K
PiA+DQo+ID4gIC0gQXMgcGVyIHNwZWNzIExFIENvbm5lY3Rpb24gdGltZW91dCBpcyAyMCBzZWNz
IGJ1dCBpbiBpbXBsZW1lbnRhdGlvbiwNCj4gPiAgICBpdCB3YXMgNCBzZWNzLiBIZW5jZSBpbmNy
ZWFzZWQgdGhpcyB0aW1lb3V0IHRvIDIwIFNlY3MuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBN
YWhlc2ggVGFsZXdhZCA8bWFoZXNoLnRhbGV3YWRAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0
L2JsdWV0b290aC9oY2lfZXZlbnQuYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0
b290aC9oY2lfZXZlbnQuYyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgDQo+ID4gaW5kZXgg
NGFlMjI0ODI0MDEyLi4wNmZlNWY2Yjk1NDYgMTAwNjQ0DQo+ID4gLS0tIGEvbmV0L2JsdWV0b290
aC9oY2lfZXZlbnQuYw0KPiA+ICsrKyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMNCj4gPiBA
QCAtNjA2Nyw3ICs2MDY3LDcgQEAgc3RhdGljIHN0cnVjdCBoY2lfY29ubiAqY2hlY2tfcGVuZGlu
Z19sZV9jb25uKHN0cnVjdCBoY2lfZGV2ICpoZGV2LA0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICBjb25uID0gaGNpX2Nvbm5lY3RfbGUoaGRldiwgYWRkciwgYWRkcl90eXBlLCBhZGRy
X3Jlc29sdmVkLA0KPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJUX1NFQ1VSSVRZ
X0xPVywgaGRldi0+ZGVmX2xlX2F1dG9jb25uZWN0X3RpbWVvdXQsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQlRfU0VDVVJJVFlfTE9XLCBIQ0lfTEVfQ09OTl9USU1FT1VULA0K
PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEhDSV9ST0xFX01BU1RFUik7DQo+ID4g
ICAgICAgICBpZiAoIUlTX0VSUihjb25uKSkgew0KPiA+ICAgICAgICAgICAgICAgICAvKiBJZiBI
Q0lfQVVUT19DT05OX0VYUExJQ0lUIGlzIHNldCwgY29ubiBpcyBhbHJlYWR5IA0KPiA+IG93bmVk
DQo+ID4gLS0NCj4gPiAyLjM0LjENCj4NCj4gQWZhaWsgdGhpcyBpcyBvbiBwdXJwb3NlIHNpbmNl
IGl0IGlzIHRoZSBhdXRvY29ubmVjdCBwcm9jZWR1cmUsIHJhdGhlciB0aGFuIHVzZXIgaW5pdGlh
dGUgY29ubmVjdGlvbiwgc28gYXJlIHlvdSBydW5uaW5nIGludG8gYSBwcm9ibGVtIGlmIHRoZSB0
aW1lb3V0IGlzIGRpZmZlcmVudD8NCj4NCj4gLS0NCj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0K
DQoNCg0KLS0NCkx1aXogQXVndXN0byB2b24gRGVudHoNCg==
