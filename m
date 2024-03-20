Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2069.outbound.protection.outlook.com [40.107.104.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D7A38384
	for <linux-bluetooth@vger.kernel.org>; Wed, 20 Mar 2024 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710932190; cv=fail; b=aw7/5A7rp/sEq0hoatrCBcmep7jIbGO/e2lHjSnJD2ozWlNO4MqsNZPzfoeBN7tCsRqRJg1/eVHCnlkK2pBTY5tO8/N2T3FjLT1PAWFy/hdawWbUbf/1822ILiFrzjJreVXgrw7wqdZoNaQKF+hX3E27oJeQIfp586WRG40iS1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710932190; c=relaxed/simple;
	bh=xfjpBIIRWjWvXBTCk6i6Df5RNuOcoavUVsYl24jvMa4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G6UjKOKZJ6VnDtbKExFLFlVimwd1hZ5TJHa5m1MwCBDMjBE2snstjbxrAspHY7mqojSHw7/zl1U6v1OMEV4dey15c/kF1qi6KghfDJTf/BBtvqQLAs3/eTk4j1eLMNMFGGZHkTtQXdz17fMFbkdQXtKoHteT9iwsviJDsjIE88k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=PdCvSd86; arc=fail smtp.client-ip=40.107.104.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="PdCvSd86"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/zJ47eAD8uSs+mn+bWCl2QSadYUYlV1IStbovPO9G25pnC1fu4WOu3xRQYdMytIjLItLTnQKR+QjALI8TRjk+Ds9Q2eZwW1zBPQ8ln+3SmpdsswEo4cW11Y2Vqlw0HU/XGHsT6yRZ8RzfAEex+zwp39egJfVfYYQlV5HqCTNBdfSMBVxkwYb0kGjF2i8d92LkF+aG8Sk62mvJGHPH2b8CXd9d+FhR8tST7drSCiSZ+F9GrEO6gGPEbtM1Y7rHmPFzmuMKxNMH8HBKqUFblfP/Gj/IT0AvTOQHFwbUZFsihSm6FHrKs5jwaWGvXp5hgrYcEHAD2E+OyNxNgOHp5vqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xfjpBIIRWjWvXBTCk6i6Df5RNuOcoavUVsYl24jvMa4=;
 b=T3z8NTKMR5iNNIzS/H8PeLGXzeDEBfKdfhVeDCySMev6SXQS/9kPrfzdCRwdGjV6XpK2JS+vj755shsUvFTRUel0dJ9sQYiceBevUC13EGXwT0GDC6VtMai7F8zuzQGerDHwC5SpEJkamjY/Gm88E3nJEghVLYHFUyyyJZRkkInycDzKQRFxYOk4KeAAyQHRB0C2cI00Ph158g7TQUUhEpTWXLQuas75s2cFomRbevzdrDiz0ZF3O2NS9rf+RX+LRgh2mw+Ya+bcpCbfAXUL1/r81eB6Ko6S2wKDKErM1QvkUWg/55Expa6VlHEuyPGtooKR7cYiux2htJc1+3XSuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xfjpBIIRWjWvXBTCk6i6Df5RNuOcoavUVsYl24jvMa4=;
 b=PdCvSd8614c3HsAX4Y1u0Kkj2fdvyn8Rsu4YARpda0K+uUMDDCi5cSAIcaxPINEgeLmRLK54XHRKdCl50cr0gvf+qiTHZlFtFt1+QPpAGbzXn9FuTdBeHTRk5mQ8TGCm38xxRsQszXK93n0YlM6LKICIIHR3//UWHghCcYUzCaE=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by GV1PR04MB9101.eurprd04.prod.outlook.com (2603:10a6:150:20::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Wed, 20 Mar
 2024 10:56:25 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::5fa0:979d:f0e1:a28e%3]) with mapi id 15.20.7386.030; Wed, 20 Mar 2024
 10:56:22 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Index: AQHaeTEPMqiC0Iq8WEO4vPnWaUEu4LFAZciAgAAQ9bA=
Date: Wed, 20 Mar 2024 10:56:22 +0000
Message-ID:
 <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
References: <20240318123712.9729-1-mahesh.talewad@nxp.com>
 <20240318123712.9729-2-mahesh.talewad@nxp.com>
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
In-Reply-To:
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR04MB9754:EE_|GV1PR04MB9101:EE_
x-ms-office365-filtering-correlation-id: 92b69feb-31ec-4782-eb34-08dc48cc614f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BRE8ND9yU3wqjsDT1b8k+fW88IS4vGn6yNz5Ae3m9qF8W4FGCp8qyq38Rcp00acJMvoq/StQIU1lfTVofTLrOMe8po+wj/a8iNLoXeB9m23CNRcRDZHnkmJ8AUnE/fyAKAp4gDRn1JJWRRXxUseubcJPGJWBeyqdemeY0+B5OVBQAlvrDIpoj/vC2I7BunmYR6Wn+P7K2R1Lo1CS24UuimNtRHga3TVlR1OP1B4chhqBMBUnA7kQljz2S/4lLhpQI+ADar/g6jctsVVSyjBQnV7zg6pva562+n44sZgDTTyOYf6MFOEn5ZkHpnuPNomK9WxF+iv0bvLsLIhwvMoVaKcF3syu6cZd/ujRlp4JnDFvFV9T7w6wFheHYuOwcqVKe+qfBzjrWCPPzdSnuaYXoBZmILtcxsgjE/WvsilnEwOyjFVGjOn7Aty6urOyLUz8RHwKvrBtV49Cx0Od+KnFWVFAOdeJokfyrAWbxwTYmnXJOuoiELJZBDX1ffCx02sCbaPVd0DRlnsmUBVfaryHOfG05QIaHVddc/zkTErnsUeuNSW0ArJse2PzIaK3/ygZ7e7lFmE8dO+/PyfvaH2e+Ug5qs2CP7qVc8QpDCVbPsGvb3SAZVdLtW/JsjWSrKzQ1YAWSHkSfWG4GTeTZ3iOjnjdkFRQPmub1T0ujAAWic5Lte/+skbNFPpQWWbvG6aySKW3mqKwD+pAWtpuwrLcUQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aERnS2FQckx0UERZTlYzTFlwZVFUVnpUekp6SDNETXNVN2RFQi84WFNuRGtN?=
 =?utf-8?B?TDFldFdCeDFGaUJSNFJNMFFsQWVEaFEyS2czWG83c3o1VVo4WUN3L2ZQKzdp?=
 =?utf-8?B?NFlyczhta3VCdmU3UlRyN2c5ZmJ4cG5NRXlkK3AwdEFwbi9LUHl2UkVFYnZC?=
 =?utf-8?B?dmhOQ3JyY2p5Y0VuazBQUy95YVlnN0wwSmZxK0YxZW9CbW1kTHIzWXBNUkNR?=
 =?utf-8?B?eHNidDZucnBvVDUwTSt4YllGVzk5K3g0ZExRV3Z0NnRpUVNBYVgxZmFrMDd5?=
 =?utf-8?B?YVQyY2pHN0tYZ3FrbTJPSklPaHhINUp6L0FqUGF5MC9BUVJBUmlWUzkwY0dJ?=
 =?utf-8?B?YWZlUi9QN1ZUTU1NU0N1WWx0dXNtdmtidEtxWkNQL1doOWxTTmJUYkhGQnQ3?=
 =?utf-8?B?VWZkMTlNQm10NUhUOEdHYk1iS1NlcnlSdTVFRzI5ZGJZakZuYUZFTkdVR0RH?=
 =?utf-8?B?SWpVZ2wvNUQxT3YwNHRvaVUxWjd4MS9mbTYyWDhqb2Y1N3BFN2JncDVBY2Rs?=
 =?utf-8?B?TkNPTHRPNk5scENUWWFKNHVXbG9vNzBZaTIzR29kSUZ4YnJkeVlnaUZkTFRp?=
 =?utf-8?B?TGQxT1NnZWF1TkNacG5jb1RoMllxOE0yUFlCdW04Qk9RYk5sd2ZaM2pncWRt?=
 =?utf-8?B?Z1N1YlJRN3JLWmwrdUt5WE9GVVlOQldQSm1zTjlQR3ZtWXpOSmd3Wmh1Qlo4?=
 =?utf-8?B?NG0zcFM5S2JrQ0pVRmp5L2FXcTJuRHllVE1sVnJJeGxJTk1iREEyenN2ZC9n?=
 =?utf-8?B?N0dMcXJvM2ZnUGdQeTBiWE9TcUpIV2NVYmMzeDZERGQxcUVMR25hZ0RWcVFw?=
 =?utf-8?B?QTlCc3JNTmdwUWRoYjZpSlA1REQ1cSszdnZGc29zVGRsVVg5UWRNWVJxcXQ3?=
 =?utf-8?B?aUlHVlZMcUtOVUlpWWo0dnA2VnFvdGM4WFdmOWpFaXlteWxaV3lablZhNG5i?=
 =?utf-8?B?YWQyZUtHZ25DV0NiZ2VNT1dHSldDeExROE8wRjU2L3ZQekQ1cG03NnNVWkda?=
 =?utf-8?B?R1dTcENpQXZQUnVVTEFxUHMwWmtTdkovZkdkNTNMQ0VWYzhONTJtcVpSK3dJ?=
 =?utf-8?B?eGZDZXZTZzRsRGlMTmlDT0NYNDI2SC9YeVB4ZFFBVE1wbWtvcWlZVW41cXJH?=
 =?utf-8?B?OUM4bTNISnNDcVVNajhJbmxKL0JxS3hGTjdkWTQ0aUQ3bk9GbklhbHlMWUJs?=
 =?utf-8?B?SklPT1lQL2JVZUJ2NUtFaGlMbnpPYWRTM21TTTZmN0xCN0cxZ01hT3lTNVV5?=
 =?utf-8?B?ZlM0UU8vczROVVZRYkw1RW1VMUprYXlQSkZST1BKV2hRL1FWcW96QXF4L1ky?=
 =?utf-8?B?dnBrVTZySlBQMjVPUmUzQldOMUFwMnV4ekZJUzRJRk56REhNRmluNDhQUjJ5?=
 =?utf-8?B?RzUrdVMwYUhnMStkbXNBMFhEd0w0blFRUFdwTHROdVBpV1JBYm5NYlFRNXp4?=
 =?utf-8?B?MkNxMUsrcmpJVm1BRmhURjh0OWhYVEJnaXFYUzA0ZWE1WUNQZmZYV0NaYW9T?=
 =?utf-8?B?TFJFbnk0WGVHUW12SW55UkNJL2IrNjZHT0EzL3pDNGFqQ09iKzhOZzlNcmRM?=
 =?utf-8?B?MExndDNHdHd1b0I1bzl2bW5OMkVidTlwU2xhaCtMdzVuMjB1Ny9lZE5OQjFz?=
 =?utf-8?B?dVRhYzhPNWEzU2c2THBkTXVkL0xYVjE4YS9FNWZMSUVvdmhCZ2NJNXhIL0ox?=
 =?utf-8?B?cTA5b3VuZGFhSFR1UFVRTllEcUpJZHp1WDRHSmJOZDhRYTg5T3kxV2o3RmtE?=
 =?utf-8?B?eTBxVzRCaVZoYnJpL0xiSGlpQXpMdy83SlgxZllEeWxKa2I4NGJZc1pCYkFW?=
 =?utf-8?B?M0R0M1hUTVBMM0lXVkU5MXdlTmxOTjMweGhQL1h4WUJtRGQvT0dSYnhvOXZm?=
 =?utf-8?B?VWhsV0hpTGc4Um9JOW45bDc0YnpuSWY5ZFpTMlhOYWFCb0FpaTVmamoxS1l0?=
 =?utf-8?B?VmFSZmVVOXZHdFpYQUl5ZDM5SThwU0N4djZ2S0RQWVNDOTFiL1YrZHpPamFN?=
 =?utf-8?B?WnRIU25peHQxK21HVG1MQnVMT0gvbjlpUlJLald4TEZXcFRCWkpld3RUWGg2?=
 =?utf-8?B?UWxOcm5ZYnBaOVV5RW10NkdBdXZ0eEVCUVJYSjUvejgvTXNUNGJxeG92TW9C?=
 =?utf-8?Q?Cqaq8PFPWibGD53OZV/10hg5c?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b69feb-31ec-4782-eb34-08dc48cc614f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2024 10:56:22.2358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xvIDSJnwMYArXjqOzCOYf8Ts9UlZgOHhw6XdV2lSskmQCpGrrS7G1wo2Gfg5Pqr6VcDyGXJQc60LrUc9jMvMmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9101

SGkgTHVpeiwNCg0KWWVzLCBpdHMgYXV0byBjb25uZWN0IHNjZW5hcmlvLg0KV2hpbGUgcnVubmlu
ZyBjb25uZWN0IGRpc2Nvbm5lY3QgaW4gYSBsb29wIG9uIG9uZSBvZiB0aGUgY2hpcCwgd2UgYXJl
IGdldHRpbmcgaXNzdWUgd2l0aCB0aGlzIGRlZmF1bHQgdGltZW91dCAuIEhlbmNlIHdlIGluY3Jl
YXNlZCB0aGlzIHRpbWVvdXQgdmFsdWUgdG8gc3RhbmRhcmQgTEUgdGltZW91dCBpLmUgMjBzLg0K
S2luZGx5IGxldCB1cyBrbm93LCBpcyB0aGVyZSBhbnkgdGltZW91dCBleHBsaWNpdGx5IGRlZmlu
ZWQgZm9yIHRoZSBhdXRvY29ubmVjdCBpbiB0aGUgc3BlYy4NCg0KVGhhbmtzIGFuZCByZWdhcmRz
LA0KTWFoZXNoIFZpdGhhbCBUYWxld2FkDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpG
cm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWlsLmNvbT4gDQpTZW50
OiBXZWRuZXNkYXksIE1hcmNoIDIwLCAyMDI0IDM6MjEgUE0NClRvOiBNYWhlc2ggVGFsZXdhZCA8
bWFoZXNoLnRhbGV3YWRAbnhwLmNvbT4NCkNjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwu
b3JnOyBEZXZ5YW5pIEdvZGJvbGUgPGRldnlhbmkuZ29kYm9sZUBueHAuY29tPjsgU2FydmVzaHdh
ciBCYWphaiA8c2FydmVzaHdhci5iYWphakBueHAuY29tPg0KU3ViamVjdDogW0VYVF0gUmU6IFtQ
QVRDSCBCbHVlWiB2MSAxLzFdIExFIENyZWF0ZSBDb25uZWN0aW9uIGNvbW1hbmQgdGltZW91dCBp
bmNyZWFzZWQgdG8gMjAgc2VjcyBmcm9tIDQgc2Vjcw0KDQpDYXV0aW9uOiBUaGlzIGlzIGFuIGV4
dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3Bl
bmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5n
IHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KDQoNCkhpIE1haGVzaCwNCg0KT24gTW9u
LCBNYXIgMTgsIDIwMjQgYXQgMTI6MzfigK9QTSBNYWhlc2ggVGFsZXdhZCA8bWFoZXNoLnRhbGV3
YWRAbnhwLmNvbT4gd3JvdGU6DQo+DQo+ICAtIEFzIHBlciBzcGVjcyBMRSBDb25uZWN0aW9uIHRp
bWVvdXQgaXMgMjAgc2VjcyBidXQgaW4gaW1wbGVtZW50YXRpb24sDQo+ICAgIGl0IHdhcyA0IHNl
Y3MuIEhlbmNlIGluY3JlYXNlZCB0aGlzIHRpbWVvdXQgdG8gMjAgU2Vjcy4NCj4NCj4gU2lnbmVk
LW9mZi1ieTogTWFoZXNoIFRhbGV3YWQgPG1haGVzaC50YWxld2FkQG54cC5jb20+DQo+IC0tLQ0K
PiAgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyB8IDIgKy0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0
b290aC9oY2lfZXZlbnQuYyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMgDQo+IGluZGV4IDRh
ZTIyNDgyNDAxMi4uMDZmZTVmNmI5NTQ2IDEwMDY0NA0KPiAtLS0gYS9uZXQvYmx1ZXRvb3RoL2hj
aV9ldmVudC5jDQo+ICsrKyBiL25ldC9ibHVldG9vdGgvaGNpX2V2ZW50LmMNCj4gQEAgLTYwNjcs
NyArNjA2Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgaGNpX2Nvbm4gKmNoZWNrX3BlbmRpbmdfbGVfY29u
bihzdHJ1Y3QgaGNpX2RldiAqaGRldiwNCj4gICAgICAgICB9DQo+DQo+ICAgICAgICAgY29ubiA9
IGhjaV9jb25uZWN0X2xlKGhkZXYsIGFkZHIsIGFkZHJfdHlwZSwgYWRkcl9yZXNvbHZlZCwNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQlRfU0VDVVJJVFlfTE9XLCBoZGV2LT5kZWZf
bGVfYXV0b2Nvbm5lY3RfdGltZW91dCwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QlRfU0VDVVJJVFlfTE9XLCBIQ0lfTEVfQ09OTl9USU1FT1VULA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBIQ0lfUk9MRV9NQVNURVIpOw0KPiAgICAgICAgIGlmICghSVNfRVJSKGNv
bm4pKSB7DQo+ICAgICAgICAgICAgICAgICAvKiBJZiBIQ0lfQVVUT19DT05OX0VYUExJQ0lUIGlz
IHNldCwgY29ubiBpcyBhbHJlYWR5IA0KPiBvd25lZA0KPiAtLQ0KPiAyLjM0LjENCg0KQWZhaWsg
dGhpcyBpcyBvbiBwdXJwb3NlIHNpbmNlIGl0IGlzIHRoZSBhdXRvY29ubmVjdCBwcm9jZWR1cmUs
IHJhdGhlciB0aGFuIHVzZXIgaW5pdGlhdGUgY29ubmVjdGlvbiwgc28gYXJlIHlvdSBydW5uaW5n
IGludG8gYSBwcm9ibGVtIGlmIHRoZSB0aW1lb3V0IGlzIGRpZmZlcmVudD8NCg0KLS0NCkx1aXog
QXVndXN0byB2b24gRGVudHoNCg==
