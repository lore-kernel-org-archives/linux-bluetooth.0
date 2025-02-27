Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2052.outbound.protection.outlook.com [40.107.103.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C565522A1EC;
	Thu, 27 Feb 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740653930; cv=fail; b=n/HOLDP/GNql3ku0nFppLZZqvY7uSp1RzQKYrksTb9KmbL8NdFeHZ4nt33eVzO1rkoD2nNesfRRgaliK79it+Tk6g+Pcycas/LXVKK9ZKYF/XV36XKu1fJg143CkWNTReX8UO4HFXSf5rHXJNro3XflKaxyjWi3gKjCYMpryN4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740653930; c=relaxed/simple;
	bh=u0ntli/PttuUbNCfl2IzZPAzYrxjualkW2cF3sybKsU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XvG8DRRORwWLCl+3ME3stcEZn/PA8KVarY036HeDfT9ZYs2qnJYjDS0aTdEw8DuN6H5O50ky/M/RrMH+0LsBNwfD2NV3vUT2uJDLuFF1Nji+YH8Ny0f81jtPU0hxka102CGyJ2HkmAz4hiw/zOa1K0gCiRtBpZH9EQPu3ueUMSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=bz+EJtMC; arc=fail smtp.client-ip=40.107.103.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="bz+EJtMC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WGnCqK1ZqLGjrokSyhxcx9kBmuvN/c4wOT0ekWhgOr3W5NTtiUHC2r3WuhiRzjZWom0MbllYdAdM4sCsUe4Iy7zWGxbJrg8alNWx2ucTUExFj2lOfwnjc0yX5liHi+ZA8Ok4mXiQ9s0XmYYEQ6g7S5HFPAY5mSUL10G2B+/id8ppnrpLeecbLNh5Oahp+9dm+DvhUvjUEIKjCmW4r7ilyCr0SFjm2G1lO7VUg7ADGOgSps8hz+gfusF0iNxPb8ggSBGsLtEwZL1lnX7lHWqDfXrsiKxXqbcHVoZydhwWlVVOpd8r0h2X6EoKUtfSSnjyplffYs82hO2KhdjurXBs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0ntli/PttuUbNCfl2IzZPAzYrxjualkW2cF3sybKsU=;
 b=yXUejIgbnVCmfjhG7DjlOkGAbwF3uBwu0TPSSfvgiku4+rgMYfnEDCrXOn5BlXQzn/NZeCXGKs1j7SJZBz4LHf7hA2AmP5EGsAIDzPFsiojhmAd/deKWnPMvY9ihMposBpLG1o4KhxkU0vIBBt53KONdEXszB7dQ19n7GJyWaqouyJsNDlsX9EGY/lfu4qFpSqs//hY9+IHe9BUw05PqBw9zsLZ5mHKRJIXlMx3O+aiAYrt/YVq58ln0z1KffUPiVcReJnG691pUrmPlsZXL7MfJmuzt8CpWwvLpfIfK2eyy7Dz3Q7j2x9KUgz8titCONay4Rq3nohcEdfN4u0CEhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0ntli/PttuUbNCfl2IzZPAzYrxjualkW2cF3sybKsU=;
 b=bz+EJtMCePquLYm9K6oazi8Wh/eY81Yqz1tPppg6Df+pScGfgQ5a9cKRcRJUDmg37BsKjlDVbruQisfnCRDzlMwDHmFg4jg7ix+y2whAUOO4YLmja0oOewsBK/233QJ2n4evKdc5ZjzC0xhY08FCal3w9iR3XwjIQo7gse0Kttk=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by DU4PR06MB9642.eurprd06.prod.outlook.com (2603:10a6:10:562::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Thu, 27 Feb
 2025 10:58:41 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%4]) with mapi id 15.20.8489.018; Thu, 27 Feb 2025
 10:58:41 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>, Loic Poulain
	<loic.poulain@linaro.org>, "marcel@holtmann.org" <marcel@holtmann.org>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
CC: Amitkumar Karwar <amitkumar.karwar@nxp.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: net: bluetooth: nxp: Add vin-supply
 property
Thread-Topic: [PATCH 2/2] dt-bindings: net: bluetooth: nxp: Add vin-supply
 property
Thread-Index: AQHbiHep+4vmC60zgEKmq6CcmxHKp7Na/C+A
Date: Thu, 27 Feb 2025 10:58:41 +0000
Message-ID: <69a4aa60-c74d-4c5a-a10b-ef736dde6985@leica-geosystems.com>
References: <20250226150553.1015106-1-loic.poulain@linaro.org>
 <20250226150553.1015106-2-loic.poulain@linaro.org>
 <AS4PR04MB9692A606FEFDEC56BB091FA4E7C22@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB9692A606FEFDEC56BB091FA4E7C22@AS4PR04MB9692.eurprd04.prod.outlook.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|DU4PR06MB9642:EE_
x-ms-office365-filtering-correlation-id: 252a0afd-ca28-494a-0778-08dd571db2a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QnRtOUpDeWdKT0ZHTFJoYVA0S0U2U2FFdzVnZGVseTFUSk5sc0lyU0ovaXlT?=
 =?utf-8?B?NEhla28xSXI0TFpQb0tieCtBUVRRbDNCSnhtYTVnUDNoQWFJSFhIVnBlQ1Bj?=
 =?utf-8?B?RjJjazcvSHMwdlR4cW9DM3dwdm9oRndaaVFsd21hN25DbWpYMG5qK1RrM2hQ?=
 =?utf-8?B?ZnV2T0NnM2NHM2ZNQVlGMXlJbDR0c2V3NmRxZGZCVHlzZ1VFR1BJeXFQdWNB?=
 =?utf-8?B?N2tHQVo3VGovYmVOWXNEenlZZE91TS9oMDhwWjZKMjhydnN3Q2tISXBIMGVM?=
 =?utf-8?B?ME1SenV0dDVWM1pyY2NFTFdQc1NhbUFXVXJRd1dpSTM5bjhIRTdBenZBZlZK?=
 =?utf-8?B?WDljU203MGdPZVE3TjVBVEVHbElkRU5ORTJnbFQxdTdwUzBPQUhuZ05XMHlN?=
 =?utf-8?B?azRJbDdITUFLSU9BZHVzTnVkbGljZkk3Mmw0clBrRUlZdUx3dCs1dGRDZjRO?=
 =?utf-8?B?M0p5MnFUYTVlRUlXZkRJQkhlR2R3ZS9IeXFWcXFrclUyN3Byd0pSRlNYOHAr?=
 =?utf-8?B?SXp1OWU0YmdyZXpQdDYzS0ttZU1xSUtxZTVPY041NXpsSkx2TmhuREtrSEJl?=
 =?utf-8?B?OHNEV2RpR2tBdkdGUE0zcFg4NGRjVmRxUzdzUXo2UnVQVVZJc2lEYVNMTkVE?=
 =?utf-8?B?V01lNm5YUUpqcEI2S2hkZk1NQm4vSjZuQVpwQ05DcythZm5uV3paT1I3bW53?=
 =?utf-8?B?ZUdLZC9HREhiNWt6cFhrRkRMQ2FlV3Bza296YVBhUlhoNVVZYjlFWmF0SG5n?=
 =?utf-8?B?Q29NSG5NZkdya2tHc2xJN3E3SWYvMlo3R0hma0FSN0tDOEhQNGJRSng0TXgx?=
 =?utf-8?B?cFU2ekFmZjBtdko1bWI5NVZuUHdTeTB2b0JXRUJFRFBEN0VkdkJLU25yR2x1?=
 =?utf-8?B?VU5vN280U25KUjF0RTUzb0ZJZ3hmR3pMUEFyQ0Fhd0Znd3FYT0EyWW5GZ05Z?=
 =?utf-8?B?VmtFcG5DMmxjSWUwa05Ea2JZTDlKMzc0a1J0dnllY2k3MFRNeXJQdGpzSEhN?=
 =?utf-8?B?MUdlRWpvOWloRlJaMnRIZFl4TDcyMENjOGVCZmhpUXVWLzdBZkFmbDNxalBq?=
 =?utf-8?B?Vjk0NVI5end2cjJxYVVLQ2QrRi91WVRRcWlKdXljTVF6cHBWL25xUlFaMnhz?=
 =?utf-8?B?bW1xVS9UbExsRkgzc2VZRHVibGh4RVBlaEZoQkRoYmRaaHpiVnNWS0F6akVS?=
 =?utf-8?B?b0lZR3g1UkduQy8vMGRock9hYStKRVl1ZVBlZ29FdmhQNG1NWnlUbXhUU2RX?=
 =?utf-8?B?WnNDTjJEc0JKZEFKLy9yZmVOUi9xbGVOYkV6akJYMXZubVRSMTFzZ000OU5a?=
 =?utf-8?B?Y2dTSzBCKzk1U284TXBNbnFBWUxzQ2NEeWhTb0hGYldIT3gxTytLZk1QTGtB?=
 =?utf-8?B?eWk2bm5IQlViMjdDTUFJd3FhMWtldElHQ0hLa2c0RkN4Z3Z0ZGZBUW9wNDI0?=
 =?utf-8?B?TXlXWVA1eWdHc1NjRnRnQ1dNKzNZbFNPUG5WZFBuVjVNamljY1doV3Q4U0px?=
 =?utf-8?B?dm1BR0F1eFFSSHRGbUNPQ3Y3N0xJWDJ4Qzg4TGwrdmxPTU51TUtONFlaNkhS?=
 =?utf-8?B?aTNPYkJBVmZ2Y1dJREh1cGQ5NXB3ZXZQZVAwNDlOQ2RyWURVMnY5N1VBMDVT?=
 =?utf-8?B?WjRZMnlucm0xWXNQNnZ5QVQ1RC9nR1hvVzF6emZldGY4NUJPcEIvNHZJcGZi?=
 =?utf-8?B?Z2FNWSthcmdZeUNnSzNMTG1NelV4Vk5lM25CSkExSWEwVDhrbEtXK2ZEMXFq?=
 =?utf-8?B?U3FxNVNBR2hPc01TZWtmc091L2NUY2ZKVTlFNy83a0RMRTBmNzVUVnlHTHFt?=
 =?utf-8?B?bEo3TVI4V2lyL3NhcFJVb3RmUmJBRmlUTUVpZnFpeXhjc2ZZQUJucVkxRjNl?=
 =?utf-8?B?UmhQbGU3L1dEWEpuQ09jZHBDY1J5allpc2lTRDU0V2RJQ0E9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGNlUFRyZlg2QWxDY0hOVUdJYTNzN2hYbnlWREc3S09JRUF1UUVzU01sbG9I?=
 =?utf-8?B?Q0hlb29YMzVvTVZqQXNCNXo4SjlNTnAwYlVEK2ZlMWYvcmVtNHFmSU1ORzhS?=
 =?utf-8?B?a2dnRFkraGlQY1FaSEQ1VHk3WVRad0N3blVsckg0VHJpZ2szMnNna3gyR1JL?=
 =?utf-8?B?YkE4T0g2NGtESTlzR3k3cVRkeW1qN2o2ZnhJM2NsVXNrc0hHOGtOMGhMYzdZ?=
 =?utf-8?B?UnV3cFYwTCtyYjMrbnl1ZnBzOGxjQVphYytSenoxN1plZ3BocTRQZmt5MGN4?=
 =?utf-8?B?RWJSMDNoT3hFUDl3c0lQZWhTK1hpL2Fwd0ZHL3BPU0V2cTFwRjBXR1ZuNk1q?=
 =?utf-8?B?ZGxMMllveE1INjBKdGV6QUJZSUErMkJXeWZnd1pRczlQR1hoL1V0akM3V3RR?=
 =?utf-8?B?NVloNGxWNUZWRVFuOTg4ck9QOG5UYWxaUytyS2h6Q0paSU92TGdLdGZheFlG?=
 =?utf-8?B?ZHJIcFU0MEhwTFJVOEZ3UzZESzVGL2MyM1ZJWFppUGpMWEVCalpPN2UvOTVm?=
 =?utf-8?B?c0dLVGFLWVN2Szd0eFFBRXhJM21JekgvTTFZLzZUR1lHZFphZDBjUGdWOXlo?=
 =?utf-8?B?dmJrYzBPS0hXd2FUZGVHUGI4a05KOERxS2hnZ1lFODQ4MFNJNFVwc29RSXlJ?=
 =?utf-8?B?eEVzTVZyTnc2NTVWKzBiS3ZCQnRZeHErUmNiMWtBQWtJK2d6K1M5MzA3clEr?=
 =?utf-8?B?YkRJUmhUYTNqRStydWhRaCs1MnE4Z0Z4NGNCWEIyeXpuamJNV1lQNEFDRHlL?=
 =?utf-8?B?VGpFcW91TWozazVtcmw1UjFqa2k3bmtwZVFkZFQ3RUVjZVNLanJmS0NKS0xI?=
 =?utf-8?B?SG5TR1FBTThRYXQ5Qk9jTE4yNG9IYXFzQmRrYW0zWlBsUjZHQ0d1Zzc3ZnRj?=
 =?utf-8?B?RytaekE0cG8waUIxc3hwb0xPVDkxUURkQkJhNDJuZktzOWZ1WDRpd3l1aUpi?=
 =?utf-8?B?QkNWR1JoMlM5dGxxaFR1NXpCQlhNRzJYOE4vV3RnVGVJeE03V2dleC9FcDJJ?=
 =?utf-8?B?UlJjZUxrNm1oQ2JNNDRsdnF1UzFHQ1RRM0xjcUxUdldabWVUVnVUb2o1TW0y?=
 =?utf-8?B?MS9ibFgvVDF3bW5tSG1hT1JjMUVaV203YjRTNzdnK0E1blZwRkR6NDBzUDlm?=
 =?utf-8?B?Z0Q0eWV5UEZ5V21ZS3BXT3FwTTdCYnU0UXdkejBFZnUwbE5VdVdjN0ErWExs?=
 =?utf-8?B?bDFEcExxV2FUei9kbDVKSlhJTXFoZ3NVL3RETGw5YkVRVXowS0dSemVOTmpQ?=
 =?utf-8?B?K1MzQ1NEcDRKVnExbGkwallLanJseHJYblFmSFE3NDZHTEprSUxrNEpDMnJu?=
 =?utf-8?B?YUhqb0NCa1NOdXJJeFdpeTJZWXRCTjZBaUFER3BaUnh3N0RWNmVIQjlrUjE4?=
 =?utf-8?B?dHJLcXUrTEhaN21XQXZRMFhBTjlWZTQ3elRkT1RKcVd1V2UzRWU2Q2FqaktH?=
 =?utf-8?B?Q3JvRVBId3ZUZDBoWVdJSXpjdmVzZHJtcUJOZTRXdWg3ek9yNkRVZ0tGTW5h?=
 =?utf-8?B?d3VnRVZTcjNHdFpROFMvMGV6WmZkZk1ZVEs4S1BEZGlReUFmT05nYnF0YS9n?=
 =?utf-8?B?aFcvNFkzU2tHcUEzTi9pdUhVaDg1WVRtNjBwL1JoMjBSbkRWV0VsMFdCQlIy?=
 =?utf-8?B?b1l4SjVWeTN5TGdMSkpTckgyb1pnS09yZ0FsaWNDUWtGc2M5bmhQWDFIalNU?=
 =?utf-8?B?TkhIcXpzaXAvek5oeXpmcHVlQTE0bG5LS3pzZVpKWStTR25XZTBlRlk5ayti?=
 =?utf-8?B?WE8wWTFvaEE5NkdpV21oUGw4TXREUDErVmtGak5IZTRpcTlzZjVLR20xWmJu?=
 =?utf-8?B?YUh5VmQ0MnluYkxYWjlRK3VWWGJYU2JWd1ZyYmJ1K2c2bVpKQnA0ZGJPMFVu?=
 =?utf-8?B?elM5MXZ6OVJBdm1lMUNLRWxVUTNEOUJoM0lkR0FYRGRSRjNkR0Y2T1lSeHUw?=
 =?utf-8?B?M2xieWR2dS8waXhOZjUyNUh0WENpamYxR1ZvSmxWdEkxSVg4U0kvOEJXYU5i?=
 =?utf-8?B?QWg1NC9HaEdvMXhiOFdYVDcrRXNNWGtlR3plYjFHMlNUMi9LbTJyd3J4M0dy?=
 =?utf-8?B?aHR1MTFLUTZ3dzJqNk9iaVZERVR0eDM5L2JQK2h4M3RsMzcyb2pHcmNsT3NE?=
 =?utf-8?B?ZUVZYUd4SnFReGpXYWJJMFdJTTJFYnFibFJmK25Qc1pzeVpKdEcxY2o3OEVI?=
 =?utf-8?B?c2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0FB4ACF1209D6B4C99F39AF726D6B0CF@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBAPR06MB6901.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 252a0afd-ca28-494a-0778-08dd571db2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 10:58:41.9013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R/zkexRs5sCmqdj05wxSVIpTzJZFlzWJR27YfohuhMfKniRQrLtu/QKJu/jPhmnkZJci/r+FoaHJJ2jT4lk0w8k+ef/fz2QPblq5d7YpSeCuMNPXN1TygM3cxgC1Cc6e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR06MB9642

SGkgTmVlcmFqLA0KDQpUaGFua3MgZm9yIHRoZSBoZWFkcy11cCwgSSBqdXN0IHNlbnQgYSB2MiBw
YXRjaHNldCByZWJhc2VkIG9uIGxpbnV4LW5leHQuDQoNCkJSLA0KQ2F0YWxpbg0KDQpPbiAyNi8w
Mi8yMDI1IDE4OjU1LCBOZWVyYWogU2FuamF5IEthbGUgd3JvdGU6DQo+IFRoaXMgZW1haWwgaXMg
bm90IGZyb20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVm
dWwgd2hpbGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5n
IHRvIHRoaXMgZW1haWwuDQo+DQo+DQo+IEhpIExvaWMsDQo+DQo+IFRoYW5rIHlvdSBmb3IgeW91
ciBwYXRjaC4NCj4NCj4gVGhlcmUgaXMgYSBzaW1pbGFyIHBhdGNoIHNlcmllcyBmcm9tIENhdGFs
aW4gUG9wZXNjdSwgd2hpY2ggaGFzIGJlZW4gYXBwcm92ZWQgYnV0IHBlbmRpbmcgbWVyZ2U6DQo+
IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9ibHVldG9vdGgvbGlzdC8/c2Vy
aWVzPTg5NTUzOSZzdGF0ZT0lMkEmYXJjaGl2ZT1ib3RoDQo+DQo+ICsrIEx1aXosIENhdGFsaW4N
Cj4NCj4gSGkgQ2F0YWxpbiwNCj4gQ2FuIHlvdSBwbGVhc2UgcmVzZW5kIHlvdXIgcGF0Y2ggc2Vy
aWVzIHdoaWNoIGltcGxlbWVudHMgcG93ZXItdXAgc2VxdWVuY2U/DQo+DQo+IFRoYW5rcywNCj4g
TmVlcmFqDQo+DQo+PiBUbyBzcGVjaWZ5IHRoZSBWSU4gc3VwcGx5IGZvciBpbnRlcm5hbCBidWNr
ICgxLjhWKS4gVGhpcyBzdXBwbHkgaXMgdXN1YWxseQ0KPj4gcmVmZXJlbmNlZCBieSBib3RoIHRo
ZSBibHVldG9vdGggYW5kIFdpRmkgbm9kZXMsIGFzIHRoZXkgc2hhcmUgdGhlIHNhbWUNCj4+IGNv
bWJvIGNoaXAgaW5wdXQgdm9sdGFnZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBMb2ljIFBvdWxh
aW4gPGxvaWMucG91bGFpbkBsaW5hcm8ub3JnPg0KPj4gLS0tDQo+PiAgIC4uLi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctYnQueWFtbCAgICAgIHwgMyArKysN
Cj4+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQg
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3
ODk4Ny0NCj4+IGJ0LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0
L2JsdWV0b290aC9ueHAsODh3ODk4Ny0NCj4+IGJ0LnlhbWwNCj4+IGluZGV4IDA0ZjU1ZmFjNDJj
ZS4uMjc1YzFlNWE2ZjcyIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctDQo+PiBidC55YW1sDQo+PiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbmV0L2JsdWV0b290aC9ueHAsODh3
ODk4Ny0NCj4+IGJ0LnlhbQ0KPj4gKysrIGwNCj4+IEBAIC01MCw2ICs1MCw5IEBAIHByb3BlcnRp
ZXM6DQo+PiAgICAgICBkZXNjcmlwdGlvbjoNCj4+ICAgICAgICAgVGhlIEdQSU8gbnVtYmVyIG9m
IHRoZSBOWFAgY2hpcHNldCB1c2VkIGZvciBCVF9XQUtFX09VVC4NCj4+DQo+PiArICB2aW4tc3Vw
cGx5Og0KPj4gKyAgICBkZXNjcmlwdGlvbjogSW5wdXQgc3VwcGx5IHBoYW5kbGUgKDEuOFYpDQo+
PiArDQo+PiAgIHJlcXVpcmVkOg0KPj4gICAgIC0gY29tcGF0aWJsZQ0KPj4NCj4+IC0tDQo+PiAy
LjM0LjENCg0KDQo=
