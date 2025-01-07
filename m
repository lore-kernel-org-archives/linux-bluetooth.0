Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7C1E2009
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Jan 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736251560; cv=fail; b=WLKP1DzZ+VBD2hd/GvxPka7P9UlwF1gxIUjeFatov0RiOv4RlxDLe5k5KqXN9j/BhDE6GDgVtBcE+dvfRPa2XO+B1Uked7k51J5BjC6/AeptWVgF4mVgOgfwqEaBs3+pYr5X+LGa9vtGKx6x0YIRN+Ol/wrCSyK2NDmw8TwedHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736251560; c=relaxed/simple;
	bh=8+QUN5xX2B6fH5Shn4sLurOoTVVg8BwvYZSF+GYn44Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AZ4IxlUqruF+jJbZZIvlTKilf0rycARMYmycmlaUxDWlwiMfFqROshb/aaMa35+Wj19NswhadbckloolQbhpWb6GQ3daIBurPIwNcCJw8HMxvBG7Bzuw0+MD40ht0K65RC2CbZebxQxUUkVQSWFzt2C2Uc417hpuonnuXjx06fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=egCTXVok; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="egCTXVok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pr/W28lRvjmOgDkGcguQt0pE3X/xiGuapypUeDZMfR6M5EcWkMIzKppQpabSV6sNDGH98inIB9ZQW4VxF3/J4NnumCcqM1rb12I+l1yL2ivi0iWNZvhDI2ceXVuOGmGCW5ZRsnoj0tmAFJVrERIRkWca3RdnIMkP94EVp3iSI8gU6p9QN/NeQURDYLiztg0vpWG1uI1OYAY04VnJjVXSyDH/VysTbNx4t8sTG/PcqN3TJGhY2PNum4ey+pqahrY79KTQ3jBQOsvbifHzn2VEMwDDAx3CKCl8xXzGP5quFFi16e9lpoDxyuUd2oXPRXRJsSb7M6AtH8cEEl73EJPiIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+QUN5xX2B6fH5Shn4sLurOoTVVg8BwvYZSF+GYn44Q=;
 b=CflcHgr6IWZdSN6jSnGWaAmR6oiAxRCT86yNSzOhiP0d0J3et1/2OmtqMOroSO95rr5+mKDbBN9RUyYrcVaGJbLRCulRtj6LSkagQjfaXnztBB/WV36tJsLcNoQO0geXpex8cw1xeLHKGGHX+FJ5sr5Lw9pRT1d71pCMDLlwAWJvMtKOOTSak1zAPRtWhef/2XAA40CcRkZh8fjCudkZHw6Rr9j+TuaUH0MDBKxRjrw03A9ZqhCk6yw/kR/o5ESLhu2Im0GUAneww8xNvVZHyiwy9T2hqKKpbK7E5M82J+q/EUxI0SwDCWHwAvKZA6sK9x08TPc7Sefef2WK4Imbuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+QUN5xX2B6fH5Shn4sLurOoTVVg8BwvYZSF+GYn44Q=;
 b=egCTXVokbxf+dnIXGna/FtYU0M8ZR6Kqd5rR5MkjO1BDmaLunxQfh8a6fDRqFHT5A3DjNKerXfZ92EsQW1EARFImCFNbFfzDJzolbWt51ht29ngJPIatVPNV4GLFLal54XdcH6BAkqACA0R9Q9UIi5gZs3iq3zSzqXV8N53YuqNKx1EbTa+V+1+yANvPdsBtbNNsofTLRvTxt8DfpB/fNHPsqX+M9DS0aBGGMkIslyyetnpjwlbikJnXP7qYQ7gu/HuyaQKzDCb4AkjzCn7zh40JaUmwjGhHyOjn1Tu5spysGwrD8ciJjhEYEfN8kHK0f+X8573H89bknrQQqnn5dQ==
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by DU4PR04MB10434.eurprd04.prod.outlook.com (2603:10a6:10:55e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 12:05:50 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::f1cc:8138:54fa:6fa2%6]) with mapi id 15.20.8314.015; Tue, 7 Jan 2025
 12:05:49 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>, Vinit Mehta <vinit.mehta@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue
 fixed.
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] HID device not connecting issue
 fixed.
Thread-Index: AQHbVg+YaOt3epzHSUyb3d3V6rtB1LMKPUIAgAEOpdA=
Date: Tue, 7 Jan 2025 12:05:49 +0000
Message-ID:
 <AS5PR04MB9754DA009526DC605DD32C9B89112@AS5PR04MB9754.eurprd04.prod.outlook.com>
References: <20241224142424.10572-1-mahesh.talewad@nxp.com>
 <20241224142424.10572-2-mahesh.talewad@nxp.com>
 <CABBYNZJ8To9fm4j3bcGsmPc6ChJO376yAN-Wr3Se9hs_3GpJoQ@mail.gmail.com>
In-Reply-To:
 <CABBYNZJ8To9fm4j3bcGsmPc6ChJO376yAN-Wr3Se9hs_3GpJoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR04MB9754:EE_|DU4PR04MB10434:EE_
x-ms-office365-filtering-correlation-id: e4a95d93-0c9b-4c56-1a7e-08dd2f13a070
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Qi8wWHdGK0NuSFpTVWVFUGh6enYvSVBUSGZtQnVUV2RoNzNKM3d3VXVrZHVL?=
 =?utf-8?B?VUFabkxJNkoxMXJMQWVGN1kzZVZ3MmVRYnBOdk1vWHNreC9LenlHYnhReHp4?=
 =?utf-8?B?SlBuV1BFNjVPdHFOSDVZOXY1VkpmemFOYm1ncGZPL3FodTA3ekFNTnYzeFdV?=
 =?utf-8?B?NzZPRlVpV1VBZUd6YWxJZitYbVJCR3VCZTc2SWwwR2tTRFh1a2pOWUxJTkFx?=
 =?utf-8?B?clNIL2JWZFVDYzd5enlTRmk3amFhN3MrRldKL1E0a1FrTEIxbGV5Q1V4Y0VT?=
 =?utf-8?B?U2RCY1dpelNTZDEyR0hUanI1NmtiQ0xidUxBYlpOalFKcGlEc0NTWG9RdFNh?=
 =?utf-8?B?dEVuWERJdG5GUzlUeHpQMTNZWThOa0x6STZtSlIvT3d5RlVqdFprR1N0VnR5?=
 =?utf-8?B?RkZCdkFyTFZwanNXYWE2L2huWitNbGdXOU5aTWE3SUZRcnJIV3I3YmRsVXQ2?=
 =?utf-8?B?K0pzeVRDNjV3bE0yUHJ5bGREaHF2NUM2Z01IUHZ1N3c1NkFIdk9QcXN4WjV5?=
 =?utf-8?B?SGxwRDlRY2F0eGZiQWhHMGc4Q24xZkExdXd2dmJvWVdUTlc2SnQxbU9RaFds?=
 =?utf-8?B?RWVJYzNGeHhHeVVMeXpvcXRLaURGYmxlOEQwSVFWMzdDM05tbTAxZFo5d2pK?=
 =?utf-8?B?N01BQXRjUG1ydGRLL2ZpWGdKUWRRa2VyV0ZpUklDUWl3SDNFM3RWanF4NEdR?=
 =?utf-8?B?UGFkZlBDRmdNVmdpRmxYTEVQRzhkQjNDc3RvRms0LzgwRm5sTS8rSWVUYVVZ?=
 =?utf-8?B?c3VDdnpRTFltZ20rQnJIN0lKMk9nMENRYmF5amRVTXNKZkRyQ0E5Zk5tN1pX?=
 =?utf-8?B?UUQzUWxteE4vU0VqTkVEb3VMZy9XYiswUXhiTW5jK2UzdyttWk1sSTJGbnJN?=
 =?utf-8?B?czNybldVWSsvSkJVMFR0M1dwYVpTN1VqM2x1cVJSM2RSQXZVeHRzdVY4UFpS?=
 =?utf-8?B?YmVqSFdnQzdmTzM4YjI3eUFHNzByVjRtU2dsSmlUSTZ3K2VJL1p4dXNOMThM?=
 =?utf-8?B?SDA3bzRxUEsxUGJvZ1BleVUyRDVwK1BWNHFvUkZ0bi9TZWRXYlNjMTk5L2th?=
 =?utf-8?B?UW1CTy9MN1dvOGhWNzJPYkVUZkJJRDIyYmJ6S3pVVk92bStNVGJSd2NpUkJn?=
 =?utf-8?B?c1QvcmkwRVA3emRxNWI3VDRpUVgrK0REa1lEa3RKK2kzUnZ1SVB5UmRvbXl6?=
 =?utf-8?B?ZjM2NUJTR0FuQ2tONmowNytHcmZheFRzRXRXdUJhd2x2UjVLM1gxV1J1eE5E?=
 =?utf-8?B?dnQzN25wZTJiMnEzVG9XaUxQZkJqSHVodGV2d0t6UjNyZi9QR1hMdXM2NjdS?=
 =?utf-8?B?b0RVT21hTkRmbzR2Ny95Qi9taUhtVmtXZE53NktEd0VJWDcwTUhLUzZmU01q?=
 =?utf-8?B?MlVZN0ljbS9NSDUycFZ2S0IwWGdCZ25kakhRMkNWajlnM05MMXplOGhFcTB3?=
 =?utf-8?B?bkJWYm9ldE5neHZacDBXRXhneXV6eUxYOVZ0Tm1idDQydlMxU2lCcFd2d0l1?=
 =?utf-8?B?VHFJL2xDNTVwdXZLbnhkbmNzQStkMVladnlDcDFvMGNqem1KWlJBNUZwMWN2?=
 =?utf-8?B?b2RCQncrZEdmc3EvSnRwR20zRnppczF2eVlvcUJzbUQvSHIyRE9rZXJla25t?=
 =?utf-8?B?VDdDNFNBRkk4VzhCdHdoU3V5K3BkakZmd04yTGJKTGFBdlNKNldWZjI2R2dW?=
 =?utf-8?B?Nzk5bjRpb3c5VHlNd2NjU1ZaZWRab0dYVmNMSlFJV08wdFRRdzRmSEhwZGV3?=
 =?utf-8?B?NWkvdmdHWHB1cGdpVnJLbGhSZ25mZFRua3czWmx6ZFhuaW5uR0RSaUROWVh6?=
 =?utf-8?B?QUdJNlY2aHJUbWx6bDZyYVJtYWU4Zzk5NjFxZW1OY0trTjN3b0NXWFZLRHEy?=
 =?utf-8?B?SHVUZklONkZybWI2RGFrT0tzSWdXWU5PRFZDS3Y3VFRweUE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWNHUksyVzJpWGIrUTlLTXM1ZklwL3NuUExFWFVwVE9CMnFlZmZ5QUUxaG9S?=
 =?utf-8?B?QXg5blFpOVRYcWdSWHJFazRueXhjTzZac3Y4Z0kzR1hKTVlBRU9zU1lRa3Vw?=
 =?utf-8?B?WkhtT1RpS2ZsVjlaUmhka0srR1ZRWTk1OHVIWTBTWlVidVZyYk04YXcyNjNM?=
 =?utf-8?B?Mi9JT3ZtQVRsZURqQTNuZVBEaHM1MWdFaXZYampoS3JKSGxBVms2RUlKYjkx?=
 =?utf-8?B?NThKeUp5MkhqeTI3YklPaDl6dnBpRnEvUTRYNFVrazFFTnowUk9TNzFtZ1lL?=
 =?utf-8?B?cXppSEFadS80eG5JVWNLOE9rSEFpQWN2OE5FV3lYZnk5Q05SbmdUY3VEZFJE?=
 =?utf-8?B?NTBGZCs0QzlRN0dOQUZFUU5iOG1ISjFCQkFPQkUyZGVBeXpneE95VVByRmlJ?=
 =?utf-8?B?N2E2TDRtWkFrUWJDSlM1a1NrclZ3M1NsQ3dRdlJuVk13a3FnQ05Tcm0zREhP?=
 =?utf-8?B?V3ZUeUNUdDY4QVBYL1RwbHlWWXRXWVlsNjlhUUZVeXpDTXozbFMwaEtBdCtS?=
 =?utf-8?B?Wk5zVXhvelpvemM0L0ZRMExTaWRCaXJTUE9RYnZRbHRrQ2g1cFZjVWlJN0R0?=
 =?utf-8?B?UkpuSWZDL1BYUDJ0OUtkK21KcWhrYWFhZUk4WW9zSjBmclp4OFpDNFQ0bDhT?=
 =?utf-8?B?VXVmSFNYNlBhUFljRldIUG94Z2RqSGVITkNWNSswVmJNblhtekZpRmJUa0x0?=
 =?utf-8?B?R0hVR0FOWXJwWHFQNkwxWXlIbGIyM2V0Vlk5Y3NCaExwVGt4RUhLdHl1aGFx?=
 =?utf-8?B?SlFiYjFjRllEaGRTNWE0bWt5RkVFMStvc3ZuYzFpMHkrYmE2NmVLR083VUFo?=
 =?utf-8?B?NURDTEZ6WEpqWitEVDhLTGJ2OWd5V3JIR2RZM0dsWHl3VGVaVW9ZdGMxNUdH?=
 =?utf-8?B?dENGOW53Z1RMNmg0a1RwUlk2RnI5SHpQeUdnTGxVNEVMZlV5aFZYc3FhMlZw?=
 =?utf-8?B?ZVFQVmxVMjIraWpKcEZ6bUtaUEhHZ0Q1UU5SQksrVjZzQU15N3JXeFdFTFQ3?=
 =?utf-8?B?V0JoM0diVmhXWStKdEVIM1k0Ymk0ZjQxQXRrY09jV29IWDEyQUpWWmhjZGhF?=
 =?utf-8?B?WEhiTjZmRHpvZCtLYm5DRnVWTGlqeGFzU2dIOHlYNEt6bE9uOVdZUWFYNHlI?=
 =?utf-8?B?TjhJRVJYR1ZLb21NVGlySHQ4dlY1Y2wwSWRUY3psRkRnVnp3Ukl5ZlJqWGFv?=
 =?utf-8?B?Zmp5Y0lySGhxNGtYT3Z0SllxS01wTFc4bUxqWU81bXd3bnJDdFp3S1N2cjRk?=
 =?utf-8?B?eDcrTVlpR25nRFRtQzZOQ2VzMzdmMlB5cmFBN2lSNjY1NkRzaW1CRjc2UU9z?=
 =?utf-8?B?cSt1Y2MvMnowZURiK3F6MkU2dnF2MVNLUzVZMitGbUU3azMxWjVkNGRyMnFK?=
 =?utf-8?B?NXZwYUpPTUpNc2hXUWtwWWpmdEpYa1p4bTllZlhubUl3L1lNUmlaKzVoTU12?=
 =?utf-8?B?QTlwbW9GUTk2eEtpakxWOXY0VHBHRlZWTlJmcWZxRFBhNUpwYmU1anZoR21o?=
 =?utf-8?B?dEpJTkN4VnRkbzM2NnYyLzZxc2lxTm42QURoWXF1Y1AxOE0wYVV2ODdWZ0Zv?=
 =?utf-8?B?ZjBrYVdvRkhwRjhnQ0tXK0RRR2wvVytVNDB5VDhMSHQrdlVQVVR6clUzR21M?=
 =?utf-8?B?Y20xT01yV3FIZ0ErUjQxMFQ4SnhHRDhEQUVTSjZ0dVcrT1k4RTU3QzMvdzE2?=
 =?utf-8?B?OVQ4eDMzcVczMFdydXRpaURKek0zUU5iUEhlTjN0VWRkeXVua1JmclBST0Rr?=
 =?utf-8?B?RUp1NExLdGVUaDMvanNuczFtMDBzd2pPdjk3RUgwVG5qOE5FcHVWME9Rby9G?=
 =?utf-8?B?YmRpQVpjUUhKQWJQcUFEUjRxM2hmcFROVkMva0FhSW1VMU0wZVBGVGhYQ2JV?=
 =?utf-8?B?c3J3dkpBY0dDTGo1V1F0RlJSTjJHMVcxcXhMRU5GMndNV3N3bStCWW9SNS9P?=
 =?utf-8?B?RndqSW9jSVY2SUF0eklORTY4RkJmdTNNdzB4cyt5WTRvdWRuRHNmejBFNVd2?=
 =?utf-8?B?TURPWklzTWsyWmU4ZWcyZTRGZ25jK3dkYWpBNXR6MU84QndSMEltU2t0U0pu?=
 =?utf-8?B?ZG9pRjRaMFQ2NitDOGQvcGw4ZU54K1Y5WnpLWEUzYURsckNFT2NUVEhYWDdp?=
 =?utf-8?Q?yWN9cHKnl94CgHzJxe/YYvK18?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a95d93-0c9b-4c56-1a7e-08dd2f13a070
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2025 12:05:49.8529
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrrE2vEP4bq2rqFO9MHDtqLkvDt8URRluXRWjw3utllMYP0DNRSfgRHBnH6mmpr2pDROWotajT6gqbvdDuiung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10434

SGkgTHVpeiwNCg0KV2UgdHJpZWQgd2l0aCBvcHRpb24gLSAiIFVzZXJzcGFjZUhJRD10cnVlIiBp
biBpbnB1dC5jb25mIGJ1dCBISUQgQ29ubmVjdGlvbiBkaWQgbm90IGhhcHBlbi4NCg0KVGhhbmtz
IGFuZCByZWdhcmRzLA0KTWFoZXNoIFZpdGhhbCBUYWxld2FkDQoNCi0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQpGcm9tOiBMdWl6IEF1Z3VzdG8gdm9uIERlbnR6IDxsdWl6LmRlbnR6QGdtYWls
LmNvbT4NClNlbnQ6IFR1ZXNkYXksIEphbnVhcnkgNywgMjAyNSAxOjI0IEFNDQpUbzogTWFoZXNo
IFRhbGV3YWQgPG1haGVzaC50YWxld2FkQG54cC5jb20+DQpDYzogbGludXgtYmx1ZXRvb3RoQHZn
ZXIua2VybmVsLm9yZzsgRGV2eWFuaSBHb2Rib2xlIDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNvbT47
IFNhcnZlc2h3YXIgQmFqYWogPHNhcnZlc2h3YXIuYmFqYWpAbnhwLmNvbT47IFZpbml0IE1laHRh
IDx2aW5pdC5tZWh0YUBueHAuY29tPg0KU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBCbHVlWiB2
MSAxLzFdIEhJRCBkZXZpY2Ugbm90IGNvbm5lY3RpbmcgaXNzdWUgZml4ZWQuDQoNCkNhdXRpb246
IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2lu
ZyBsaW5rcyBvciBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQoNCg0KSGkgTWFo
ZXNoLA0KDQpPbiBUdWUsIERlYyAyNCwgMjAyNCBhdCA5OjI04oCvQU0gTWFoZXNoIFRhbGV3YWQg
PG1haGVzaC50YWxld2FkQG54cC5jb20+IHdyb3RlOg0KPg0KPiBXaGlsZSBjb25uZWN0aW5nIEJU
LUhJRCBkZXZpY2Ugc2hvd2luZyBici1wcm9maWxlIHVuYXZhaWxhYmxlIGFuZA0KPiBjb25uZWN0
aW9uIGRpZCBub3QgaGFwcGVuLg0KPiBTdGVwcyBmb2xsb3dlZDoNCj4gICAgICAgICAxLiBQYWly
IFJlZiBkZXZpY2UNCj4gICAgICAgICAyLiBDb25uZWN0IFJlZiBkZXZpY2UNCj4gV2l0aCB0aGlz
IHBhdGNoIEhJRCBkZXZpY2UgaXMgYWJsZSB0byBjb25uZWN0IGFuZCBISUQgdHJhZmZpYyBjYW4g
YmUNCj4gb2JzZXJ2ZWQgaW4gYnRtb24uDQo+IC0tLQ0KPiAgcHJvZmlsZXMvaW5wdXQvZGV2aWNl
LmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkNCj4NCj4gZGlmZiAtLWdpdCBhL3Byb2ZpbGVzL2lucHV0L2RldmljZS5jIGIvcHJvZmlsZXMv
aW5wdXQvZGV2aWNlLmMgaW5kZXgNCj4gOGNmOGU1ZWE3Li5hNjA0Nzk5OGEgMTAwNjQ0DQo+IC0t
LSBhL3Byb2ZpbGVzL2lucHV0L2RldmljZS5jDQo+ICsrKyBiL3Byb2ZpbGVzL2lucHV0L2Rldmlj
ZS5jDQo+IEBAIC04OSw3ICs4OSw3IEBAIHN0cnVjdCBpbnB1dF9kZXZpY2UgeyAgfTsNCj4NCj4g
IHN0YXRpYyBpbnQgaWRsZV90aW1lb3V0ID0gMDsNCj4gLXN0YXRpYyB1aGlkX3N0YXRlX3QgdWhp
ZF9zdGF0ZSA9IFVISURfRU5BQkxFRDsNCj4gK3N0YXRpYyB1aGlkX3N0YXRlX3QgdWhpZF9zdGF0
ZSA9IFVISURfRElTQUJMRUQ7DQoNCldlbGwgdGhpcyB3b3VsZCBjb250cmFkaWN0IGlucHV0LmNv
bmY6DQoNCmh0dHBzOi8vZ2l0aHViLmNvbS9ibHVlei9ibHVlei9ibG9iL21hc3Rlci9wcm9maWxl
cy9pbnB1dC9pbnB1dC5jb25mI0wxOA0KDQpQZXJoYXBzIHdoYXQgaXMgbWlzc2luZyBpcyB0aGUg
ZGV0ZWN0aW9uIHRoYXQgaWYgdWhpZCBpcyBub3QgZW5hYmxlZCBpbiB0aGUga2VybmVsIGl0IHdv
dWxkIHN3aXRjaCBpdCBvZmYgYXV0b21hdGljYWxseSwgdGhhdCBzYWlkIGl0IHdhcyBpbnRlbmRl
ZCBieSB0aGUgZGlzdHJvIHRvIGtub3cgd2hldGhlciB0byBlbmFibGUgaXQgb3Igbm90LCBzbyB3
ZSBkb24ndCBoYXZlIHRvIHBsYXkgYSBndWVzcyBnYW1lIHJ1bnRpbWUuDQoNCj4gIHN0YXRpYyBi
b29sIGNsYXNzaWNfYm9uZGVkX29ubHkgPSB0cnVlOw0KPg0KPiAgdm9pZCBpbnB1dF9zZXRfaWRs
ZV90aW1lb3V0KGludCB0aW1lb3V0KQ0KPiAtLQ0KPiAyLjM0LjENCj4NCg0KDQotLQ0KTHVpeiBB
dWd1c3RvIHZvbiBEZW50eg0K
