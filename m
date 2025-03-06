Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F361FF7CC;
	Thu,  6 Mar 2025 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276591; cv=fail; b=m8ZxxXps8cmiU7c9fNd+EaS63OEx/uPcOcCSjIHP2AYUKQAwF7KMEZDqsxy25+8PofMZ0Yuc4rlQT7x+ZAhetrBSdQ+2ocz7P9lez684Js0o+PGZpwz4F/tDjyNYqLLkXlkPXd9RgmIWYhRzElStl4qzmm9TPjP6ttoiGJctlRM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276591; c=relaxed/simple;
	bh=hDWqWxrjeABnfD+V9YkZrYyc6HP7qtxjmOVOx+5gVxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Y1Y1/np+NeIfLw1VZYVlqXdydnkbwMJ2iSyScCSCAwkVvw2XI/g+MB/etuQjqk+sKBVfg3qlAofBpQI0u0T7mczCRgZ1yCxWstJjK4SbO+7OLnTDd+bMvcbmVyy8z2gcqyLNNF9Mw5/THwT2YHlj8Wws0eIZYFipdftuEiw3KQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=Wss+1fj4; arc=fail smtp.client-ip=52.101.66.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="Wss+1fj4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbxluZsQlqAcQ3ef1o/hayKOuQ9dI8Ez92BlSAfnjnnQ5MvO+hGhUHkn0sOpdvBue2/3aszKMN5Gt5VoMrY1Ev2MpASGM+/zo4Map7dEFRcwYp/Ii6AQDjnC1HnJtynVNnkJ4HopIO7aHbroXAvCNzN9m0ricsRemPzgbTfdQf3hr1vrN0gb3HxFRxBuI1R1ZV8AEHX9hUOoTomXY95C+ZURiSLBQROS2ftIsrzQhofFD8KXRKPNaYEOjHmfxwVdhBkM6PyTn52590ev4PZyhneKLQ5ol48EJgRVfyGjqLMTFGLbzkNdLb1IsPhUCQlj/4FY3Z1hnwoDLWW7xNZoRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDWqWxrjeABnfD+V9YkZrYyc6HP7qtxjmOVOx+5gVxk=;
 b=xFAxz5yyzdV8jyTEuCENW3GfRtlnHELMVYttbjRuXWACm2BGzfem2FsPN3CsmZKBExx95Yh0Y6P7g4/18sa6uyH4W+xRrPyzeIOQaGmI5vw5J9eNGjEj8lc2qHnHvoBXkp1GRzR1qXd2XhhQGJF9FFx8akAIXtNszWHikAe0KSGF2TPghFNvgAtxPV4zgNjr9HoPo4il1grbNwMDSWreaY2mA2wkR6PTVwMt+gJsp043zQdjHEnXSGEyrnobrq8+4f/BWh2A2bpSKnUvx7WoBhoa7xkKX49Fj1+j0xcuA8SR6yxWpMypLrJkC275WcnLT8i1Q1gzfhMuCSjAKbpQjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDWqWxrjeABnfD+V9YkZrYyc6HP7qtxjmOVOx+5gVxk=;
 b=Wss+1fj4ZdtBGAyQaIsdQVIqROBqVZcWfKeCYmrv4ylfuDloibe1XwjfnWpjfQ1m/fnqjhYGVi+7/BJDLceNFdtQOWK958Mwi7CNJjZuxovloHwUcH6c8u3jhMXUujNy9eWvIHWPwfiEswhF8ID65VZSt94faZPSDtir9eR9p6o=
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com (2603:10a6:10:1a0::11)
 by DB9PR06MB8218.eurprd06.prod.outlook.com (2603:10a6:10:29f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 15:56:26 +0000
Received: from DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0]) by DBAPR06MB6901.eurprd06.prod.outlook.com
 ([fe80::3988:68ff:8fd1:7ea0%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 15:56:19 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Loic Poulain <loic.poulain@linaro.org>
CC: "neeraj.sanjaykale@nxp.com" <neeraj.sanjaykale@nxp.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>, "amitkumar.karwar@nxp.com"
	<amitkumar.karwar@nxp.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Subject: Re: [PATCH next v2 2/2] bluetooth: btnxpuart: implement powerup
 sequence
Thread-Topic: [PATCH next v2 2/2] bluetooth: btnxpuart: implement powerup
 sequence
Thread-Index: AQHbiQZh1+xHu3a1AE6P+BzFycW0KLNmRy8AgAAHXYA=
Date: Thu, 6 Mar 2025 15:56:19 +0000
Message-ID: <92e69f32-149b-46bb-9a29-ef587c3f1c75@leica-geosystems.com>
References: <20250227105718.1692639-1-catalin.popescu@leica-geosystems.com>
 <20250227105718.1692639-2-catalin.popescu@leica-geosystems.com>
 <CAMZdPi-4rvKfPJ2zQJ8mMOkuJ7SSXk3OePKrFYapFmdw9KZs7g@mail.gmail.com>
In-Reply-To:
 <CAMZdPi-4rvKfPJ2zQJ8mMOkuJ7SSXk3OePKrFYapFmdw9KZs7g@mail.gmail.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DBAPR06MB6901:EE_|DB9PR06MB8218:EE_
x-ms-office365-filtering-correlation-id: aed8409f-500c-4c98-62a5-08dd5cc76f63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODNYUFVwNDArbm9COUJmblVscEx2TmR0T0RxWVZ3cnNTdE53eXFyVFNkd2lD?=
 =?utf-8?B?ZC9XbGhNVE1oR0YxbVRGRGtQT1pwSlQ1dmZuRTZQaHQ2Q3dDaG5JbUpORFhB?=
 =?utf-8?B?MVlmSzBYMmJkZnNGZFp3Q3FkbTRNTURnbm5zQXNmOVZWK2JhWklBOUdvUW9T?=
 =?utf-8?B?eGhDTDRhS2VQdzRYTWRVVFhDaTFRRThUdmg4RjNmcjBvc2JOTVNMSzIwSmx6?=
 =?utf-8?B?WGtTRGs1MVdTVGJOeEl4ZUNrbFJTSklsb1hBZ0JFMldMWm94K0xyS0lMTDZW?=
 =?utf-8?B?a0ZSMDlhenhsdk1SbGU0dWwzczd2Zk9vSCtvZDBvdmdXM203cHBONCtwVTZt?=
 =?utf-8?B?ZmRNbGNLc21ySGRJUHFzV0R4SGp1Z2V4aGdIdFZFTTBiMEFvZ29hT2Npcncy?=
 =?utf-8?B?U0RsMFZsZFREVUJNVUwvM2dCQXNMSXNsb0FxRWF4cGIrTHZSM2N4cytRRjcx?=
 =?utf-8?B?YTlDMjVBOWNSU0dZZTlPaXFremJ0WTZSUXRCVDFxWWY4VnMyWWJmVnVzbmla?=
 =?utf-8?B?RXZaUk8xVGIwYkpDUWNORzdOTEptL2c5aEREeVpTWkJSWWtVWTVQYVE3a3l2?=
 =?utf-8?B?UG56Q2NKZmUranhBTGd2ZEdsVDExNVhoUVpPYStHUE84WEJuQkl6MmN3SS9F?=
 =?utf-8?B?VzRSODRHemRIWlkyeHZ0OXNaMmIwTmc3dVk3WDBXOWdGUERxcXk0anVaWWVN?=
 =?utf-8?B?d24zUCtUZm5Xcy8rcnM3R1p2blR5ZHBJY1IreWdPVFFocmgzM0h6OWsrdE5N?=
 =?utf-8?B?TEdUL1NuYjNxVVp3RTY4K2VIbkM5TFV6eGpiK2UvOVNBTXNKaW5ER1Q1QzZl?=
 =?utf-8?B?VmFvYXRISFltcWtQMjg5VmNpRlFocWdzRWFKdGl1RFh2bGoxZDh2anY5T3Rk?=
 =?utf-8?B?M0FTRW9mVmVtY0laOTNLSnIyd1NLRVJtRkR4Zy9OenBRVmxJZ3IyWDBkVU1J?=
 =?utf-8?B?R25BaE5YL0VORXh2K2IzS2ZuTTFoV0tTbUNlSS95T0xrWGViQWFhaFJpUk9K?=
 =?utf-8?B?QndiVXFNUC9yM0FmNjRTZWx5VnFERHh1djBXbm1CekhzMWpRRjRsS0M2eWFj?=
 =?utf-8?B?VWtQSlI5WlVBQkdmc0JGSHkwTko3K0JNSXNGZWoyNzJXRTJNTXYrWWdwOTRv?=
 =?utf-8?B?Y240ckNVWUxsZjlkRXZIeDhlayswN0o4OVY0aWlPRHhUeENyMTYyRHZDZTNO?=
 =?utf-8?B?a25WYXAyZVZ6czBqQk50NE10V2FvOUJLTzJMYllqdTlEbDJoZTJRWDNtZGJR?=
 =?utf-8?B?OHJZMlQvZmg1TXk2NmJjRU1sUFBWNmlzWmt5aUpsMzNVNkVTaXc1YTFBeWR3?=
 =?utf-8?B?bHE3NTlIQUluREpBSUJVUm9zNlBxVi9HUDlSbjZpdlhBd2FvOEZ0bFNrcDA2?=
 =?utf-8?B?cE4rSy9MQm45VWdWUGd1S3Awb2NCNk9SbnZSZlVwUmIzZ3VSSzd0Rk0vZmQ3?=
 =?utf-8?B?ZWt5MmROOFphYVRrRU12cFljMlA2dXQ3KzlnMnBBMVpoYkg3Q0Nob1ZWY2oz?=
 =?utf-8?B?RFBuK3doV2g0cUlkbk05V3BTMlliZzdnSVJualdWM0JIVmt1RWRDSlpTVk5a?=
 =?utf-8?B?Y3NaUHdnU2M2RjRYNjhvR2dYQzRlNVZVSmZlcXlVVlFhcFdiMjlMN3k2b2xm?=
 =?utf-8?B?cXlrV2oyZzF5Rkp2eEZNTWpNeWxsbXZ3cDlVZThGUUpUbTkzWnhqNHlnRXc3?=
 =?utf-8?B?OEZYMWhJMm1IbCtsZ0NkdGpBSVNVWHVZckMwU0NEdjB0ZUJrN0ZodUtQeHZQ?=
 =?utf-8?B?bmZWRDJnVGZKUERqcEVVYnhoUTcwdEZDakcybTNXUmttZFhueCtueEt4bEdU?=
 =?utf-8?B?S3c0VFpGYjlqM0pIbCtIWUM4R2F0STZadGYvSWRtcGwyeHpTUUNUTld1bmY4?=
 =?utf-8?B?ODcvYmk1Ty9XcXRkY2ZZV1R0bXBqMG15WmhiOG9MaUh0M2RoTVpZRElZRjdq?=
 =?utf-8?Q?TV9ApmVm+aj7OCLjnqLR6XfCTbGOfuPY?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR06MB6901.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVhxbSt6bnhHNzc5bnVuQnF0SUwzQXpjZ1kzSWtJbW5BZ1JLWHh5RzFrL0tt?=
 =?utf-8?B?OEFlRWlBYkc2QU4yNVBtUk5BR0l1TEtDWnNVaStjSEJiUEVHODhaSE8yeXBY?=
 =?utf-8?B?Nkc3R0RudHFmcVMydjBsUWxPMzJWTXlmbzBGeG92NEFQcFgvUWhwczk5Umds?=
 =?utf-8?B?WmJMTElvbjZpZ2pENnp6eWV6NVdWaXRQckEwa0ZwRm1hejZvWnpPUGlYeExv?=
 =?utf-8?B?UG14a0h1b09ncDdkalNoMXZFNXA5NjVpNjcvK3hUVU9HWmRhb2xidUpXMS9q?=
 =?utf-8?B?ZlNqTkJXS0pjS3RGdTVTdmRQdnA1S0dzTzhsU2Nad00wK1J5Q1MyZlc2dm1S?=
 =?utf-8?B?R2YrUVBsZ290bFZzR0Z5Q1AzUGc3ZzlQYktCTU5NcnFwVURyNmlqc0g4Z3lr?=
 =?utf-8?B?b0dIS056VC84UGtoajM5RU9OeXNOUlhLVUFVRzBSaVRuNEFNYTR5R1VKd29n?=
 =?utf-8?B?MGZxZ0l1amhWVUF2NDBVcmNKa1B4Qk9PRHlSbjVUUkloeDB1VTMvS2pnZVFO?=
 =?utf-8?B?NVh4aTVyRnA2eHBHVkZxNUhwMDBhVUg2USs1MkVtbDVuUVBsMjM5eUJEclZ2?=
 =?utf-8?B?MHFGQTNoWWh1N0lsaFpkVUFHRXdKVnp2TTQvT1A2cThKaFVjU1EzNGx6THd3?=
 =?utf-8?B?UWtqUVhQbzI3ZDJrbzdBKzV1TFN4K2lJUyt0bTBTRm1Ya2tvdkFOWGxUTVY5?=
 =?utf-8?B?dEsyN0x1ay80U1ZFK3YxeWdKdzc1NlZVV3Fkdmk5WEpQcTljWHVlTm1aRkd2?=
 =?utf-8?B?ckM4TVVrcm15Z2pSS1RtUk9ObFBrMElPRkxLSFpseFJ0dThVVHVpcHNsSEkv?=
 =?utf-8?B?aHdIdWZ5NUdEK1U2VWZlRmlPMVFpTDVuOC9RL1BGalp3THh0d1h0RVc4OUlt?=
 =?utf-8?B?b3A0ZkIxd200Sm1mZlVDYnhJSm1Jb3F3QWMvUkNoWnJVZDZJcS9JR2Yvd1VQ?=
 =?utf-8?B?ZmYvcENjUHBFYUswaDNKSWwrMktERzQxb3ZhWCtnY3ozcHhaRnpPOHZUQ2o0?=
 =?utf-8?B?R1FRQjVta2w2ejcvbjhxVXo4cmlKcDRBem1iNUJDejNJZUpHbFBiNTRyQmZO?=
 =?utf-8?B?NmJUTTQ4VzQ4WlVhSlB4a09xWjBsZWRnVXcxY3NrdGhhQU9RQUUyY0lrUFEv?=
 =?utf-8?B?d1BRQ3FKQlFTTFBPLzVpVmdPbTQ2aTFrelI2V0F5R0RLejVVbjZkeEpXWkE5?=
 =?utf-8?B?aU04dkU5a0ZjRUFSZFB3bjZLRnJJOG1Ud2FJU3J5M1V4L1pDbitTeWhObTly?=
 =?utf-8?B?Y3JjbW16Y2xGRUVzMG15WkI5eGVSazlGbGdLWTJFNVZTTFM5MVdBMm9XNmRI?=
 =?utf-8?B?VC9ubDloaGRFZ0VaOWxRVHhlOE82ZnZXbnpuUzBQcGxKRFlIUm52d1hQbnZs?=
 =?utf-8?B?U05wSzNVd0NQVkI1aklmTWtPSWZEVldWNVk1bFFEUVBYQlVzcEthNEp2K2ZL?=
 =?utf-8?B?Z3dCd2FYOWozZzlCd2Yram9PUFpFMHM0cDJyNE1pdUlOSDhnZTZ2ektlaDJJ?=
 =?utf-8?B?VW80ZS8zbTdZNTEzV2tnOXNpNVlra1hHMjkzVElyUU1rR3NocU1OVUxLN0pD?=
 =?utf-8?B?azF1cUhveFFsbkxzRXpuTGlvWk9IS0VCK1lzMmpBdHo3aVVRSWsyOHFrdC9v?=
 =?utf-8?B?MlZSUy93SEltNFRoUDd2OHdUMSt1aU10NEVJUVlmQklNdEdYcUloYTh3M2dL?=
 =?utf-8?B?bndDSG9PSEdmTTUxL05ZL0pqdHhzNmJ0M1NRcWV4b3VBS3REaWNwR3dNdkhH?=
 =?utf-8?B?WnJNSk50QVlRdVlZNitVcFRFNXlnOXF3UzFXSm5iSXdxOGgvSzdZc3IySWwz?=
 =?utf-8?B?Y1I3OTNpUCt4NnBpbUdGc3B0bmlCZ3AvVUZzcjhFbTBGcW1FL05yMXdySW1Z?=
 =?utf-8?B?UDN0cHZ0Qzd5aE5mY0hGdUNiQ2VFUFJBdWlxdlVUUnltU2V2S0thcXI1RE1S?=
 =?utf-8?B?RXVDNVhPbkpNQ05lOHlwazBMbVhJb3h3cGFXa05nRFNqeHhueHpxR0hBQzVi?=
 =?utf-8?B?UkFOMWlDRUlBRHREUlZqeDh3Y2hWYVROSWg1RW5CUkdPL3BjUzViSXZoTFFC?=
 =?utf-8?B?clVXYUFHYTFsaExxS2RjL09ycmt0T2dyaWZKL3V5ZzlwL01TZ2lQakdMcENa?=
 =?utf-8?B?WkN3cm1GczQyOWxpN2drUVRoU0ZkekE5cXV1ei80Q1dGREZ4WnU5bkwvdVc2?=
 =?utf-8?B?QUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <880F5047639EE74185D8813CF2217E9E@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aed8409f-500c-4c98-62a5-08dd5cc76f63
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 15:56:19.3214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xQqNWZd1CvctSsZFWhCQOsZnBKaAqzt1Wh8zmgklhX3KUu3b6w5SdjiS6L1Gu3Y6JLCpzDSJSq6x6sxaYgmcJTH04DDZhLS8RKShP5DfZI8rcwQ7HcIZLimevkaQH/E8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR06MB8218

T24gMDYvMDMvMjAyNSAxNjoyOSwgTG9pYyBQb3VsYWluIHdyb3RlOg0KPiBUaGlzIGVtYWlsIGlz
IG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZSBjYXJl
ZnVsIHdoaWxlIGNsaWNraW5nIGxpbmtzLCBvcGVuaW5nIGF0dGFjaG1lbnRzLCBvciByZXBseWlu
ZyB0byB0aGlzIGVtYWlsLg0KPg0KPg0KPiBIaSwNCkhpIExvaWMNCj4NCj4gT24gVGh1LCAyNyBG
ZWIgMjAyNSBhdCAxMTo1NywgQ2F0YWxpbiBQb3Blc2N1DQo+IDxjYXRhbGluLnBvcGVzY3VAbGVp
Y2EtZ2Vvc3lzdGVtcy5jb20+IHdyb3RlOg0KPj4gTlhQIGJsdWV0b290aCBjaGlwIHNoYXJlcyBw
b3dlciBzdXBwbHkgYW5kIHJlc2V0IGdwaW8gd2l0aCBhIFdMQU4NCj4+IGNoaXAuIEFkZCBzdXBw
b3J0IGZvciBwb3dlciBzdXBwbHkgYW5kIHJlc2V0IGFuZCBlbmZvcmNlIHBvd2VydXANCj4+IHNl
cXVlbmNlOg0KPj4gLSBhcHBseSBwb3dlciBzdXBwbHkNCj4+IC0gZGVhc3NlcnQgcmVzZXQvcG93
ZXJkb3duDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2F0YWxpbiBQb3Blc2N1IDxjYXRhbGluLnBv
cGVzY3VAbGVpY2EtZ2Vvc3lzdGVtcy5jb20+DQo+PiBSZXZpZXdlZC1ieTogTmVlcmFqIFNhbmph
eSBLYWxlIDxuZWVyYWouc2FuamF5a2FsZUBueHAuY29tPg0KPj4gLS0tDQo+PiB2MjoNCj4+IC0g
cmViYXNlIG9uIGxpbnV4LW5leHQgdGFnIG5leHQtMjAyNTAyMjcNCj4+IC0gYWRkIHJldmlld2Vk
LWJ5DQo+IFsuLi5dDQo+PiBAQCAtMTUyMiw2ICsxNTI1LDcgQEAgc3RhdGljIGludCBueHBfc2Vy
ZGV2X3Byb2JlKHN0cnVjdCBzZXJkZXZfZGV2aWNlICpzZXJkZXYpDQo+PiAgIHsNCj4+ICAgICAg
ICAgIHN0cnVjdCBoY2lfZGV2ICpoZGV2Ow0KPj4gICAgICAgICAgc3RydWN0IGJ0bnhwdWFydF9k
ZXYgKm54cGRldjsNCj4+ICsgICAgICAgaW50IGVycjsNCj4+DQo+PiAgICAgICAgICBueHBkZXYg
PSBkZXZtX2t6YWxsb2MoJnNlcmRldi0+ZGV2LCBzaXplb2YoKm54cGRldiksIEdGUF9LRVJORUwp
Ow0KPj4gICAgICAgICAgaWYgKCFueHBkZXYpDQo+PiBAQCAtMTU0OSw2ICsxNTUzLDE2IEBAIHN0
YXRpYyBpbnQgbnhwX3NlcmRldl9wcm9iZShzdHJ1Y3Qgc2VyZGV2X2RldmljZSAqc2VyZGV2KQ0K
Pj4NCj4+ICAgICAgICAgIGNyYzhfcG9wdWxhdGVfbXNiKGNyYzhfdGFibGUsIFBPTFlOT01JQUw4
KTsNCj4+DQo+PiArICAgICAgIG54cGRldi0+cGRuID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9v
cHRpb25hbF9zaGFyZWQoJnNlcmRldi0+ZGV2LCBOVUxMKTsNCj4gTWF5YmUgZGV2bV9yZXNldF9j
b250cm9sX2dldF9vcHRpb25hbF9zaGFyZWRfZGVhc3NlcnRlZCBjb3VsZCBiZQ0KPiB1c2VmdWwg
aGVyZSBpbnN0ZWFkPw0KVGhpcyBpcyBhIG5ldyBBUEkgaW50cm9kdWNlZCBpbiA2LjEzIGFuZCBt
eSBrZXJuZWwgaXMgbm90IHVwdG9kYXRlIA0KZW5vdWdoIHRvIHRlc3QgaXQgKDYuMTIpLg0KTW9y
ZW92ZXIsIGl0IHdvdWxkIGJyZWFrIHRoZSBwb3dlcnVwIHNlcXVlbmNlIGFzIHdlIGZpcnN0IG5l
ZWQgdG8gYXBwbHkgDQpwb3dlciB0aGVuIGRlYXNzZXJ0IHRoZSByZXNldC4NCj4NCj4NCj4NCj4+
ICsgICAgICAgaWYgKElTX0VSUihueHBkZXYtPnBkbikpDQo+PiArICAgICAgICAgICAgICAgcmV0
dXJuIFBUUl9FUlIobnhwZGV2LT5wZG4pOw0KPj4gKw0KPj4gKyAgICAgICBlcnIgPSBkZXZtX3Jl
Z3VsYXRvcl9nZXRfZW5hYmxlKCZzZXJkZXYtPmRldiwgInZjYyIpOw0KPj4gKyAgICAgICBpZiAo
ZXJyKSB7DQo+PiArICAgICAgICAgICAgICAgZGV2X2Vycigmc2VyZGV2LT5kZXYsICJGYWlsZWQg
dG8gZW5hYmxlIHZjYyByZWd1bGF0b3JcbiIpOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiBl
cnI7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICAgICAgICAgIC8qIEluaXRpYWxpemUgYW5kIHJl
Z2lzdGVyIEhDSSBkZXZpY2UgKi8NCj4+ICAgICAgICAgIGhkZXYgPSBoY2lfYWxsb2NfZGV2KCk7
DQo+PiAgICAgICAgICBpZiAoIWhkZXYpIHsNCj4+IEBAIC0xNTU2LDYgKzE1NzAsOCBAQCBzdGF0
aWMgaW50IG54cF9zZXJkZXZfcHJvYmUoc3RydWN0IHNlcmRldl9kZXZpY2UgKnNlcmRldikNCj4+
ICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+PiAgICAgICAgICB9DQo+Pg0KPj4g
KyAgICAgICByZXNldF9jb250cm9sX2RlYXNzZXJ0KG54cGRldi0+cGRuKTsNCj4+ICsNCj4+ICAg
ICAgICAgIG54cGRldi0+aGRldiA9IGhkZXY7DQo+Pg0KPj4gICAgICAgICAgaGRldi0+YnVzID0g
SENJX1VBUlQ7DQo+PiBAQCAtMTU4Myw2ICsxNTk5LDcgQEAgc3RhdGljIGludCBueHBfc2VyZGV2
X3Byb2JlKHN0cnVjdCBzZXJkZXZfZGV2aWNlICpzZXJkZXYpDQo+PiAgICAgICAgICByZXR1cm4g
MDsNCj4+DQo+PiAgIHByb2JlX2ZhaWw6DQo+PiArICAgICAgIHJlc2V0X2NvbnRyb2xfYXNzZXJ0
KG54cGRldi0+cGRuKTsNCj4+ICAgICAgICAgIGhjaV9mcmVlX2RldihoZGV2KTsNCj4+ICAgICAg
ICAgIHJldHVybiAtRU5PREVWOw0KPj4gICB9DQo+PiBAQCAtMTYwOSw2ICsxNjI2LDcgQEAgc3Rh
dGljIHZvaWQgbnhwX3NlcmRldl9yZW1vdmUoc3RydWN0IHNlcmRldl9kZXZpY2UgKnNlcmRldikN
Cj4+ICAgICAgICAgIH0NCj4+ICAgICAgICAgIHBzX2NsZWFudXAobnhwZGV2KTsNCj4+ICAgICAg
ICAgIGhjaV91bnJlZ2lzdGVyX2RldihoZGV2KTsNCj4+ICsgICAgICAgcmVzZXRfY29udHJvbF9h
c3NlcnQobnhwZGV2LT5wZG4pOw0KPj4gICAgICAgICAgaGNpX2ZyZWVfZGV2KGhkZXYpOw0KPj4g
ICB9DQo+Pg0KPj4gLS0NCj4+IDIuNDMuMA0KPj4NCg0K
