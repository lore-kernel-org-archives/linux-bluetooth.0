Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56294D9E0;
	Wed, 15 May 2024 07:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715757496; cv=fail; b=DOMHOfue+dMVGH8yDpz4ji0f3FzxIvEqPdODRcl+oSsBR9+K/TPPO2REwq9nkP7DX9PvB0issfK9uE5Py5dft+YhzgdZJ4tzupIsS23cUoHmPB2fl5jt7Z+BSesW3ZTMIDRHyHycqwKy1KTWblU/yoPx4Sjg5vwbKBEONdX3sAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715757496; c=relaxed/simple;
	bh=fhEGJX8Cn/DS4yEFMGnnAkfDEnoXNL/6P6DYAgIVTh8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sXdjGh+l84HTSr3Sjn3eB72/Oh9kWAwQXdmpB9wsmEDOPDhovcJoZ8fNWtKToslTNC74ldZLSj6vZYl/KuOWn78MYGBUkVmNeMMX0j5Dj91W4sC5lD9u97755YsDR8jmsTQLv7uMPjWGMydQmnZGX7a7tCIQne6NsBSD76PZdcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=KVWjbgLL; arc=fail smtp.client-ip=40.107.7.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KVWjbgLL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ivhd6Ab95SeZLozHsZFy42hI5DXuuBHFU3y0juBmU655FYp10I56cR7kjZ5LFAL3jeH8tVa6i7XxHdAAnf6dW2RQu75tOEdwtLCSgYspqRItLB/wBYluFZJAzjt3KUEbviNKLQsdNA9quVA6D9zYnVRu4nrq8ANv6Anm4OWATd8AWOUy6EQ4FaFAGj9tT5SAKMGzMyu2jpQgdXA4T/Yz2+jcBZUHlRKAPAGz6DsVwg5D10Fg+S5E7GLXyPUcfC9dckCSMewwLqq4jlIvg6OuHVTLleZun9Wt34fueBWA/af1YMHX8/HHUwZb2KOZz90dHYu9lUZbRTzZrSImxuYkRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fhEGJX8Cn/DS4yEFMGnnAkfDEnoXNL/6P6DYAgIVTh8=;
 b=iVE3vq4lmPW65yTPkZuBJovNtGRSHOD8+xMjLtyzpaOWIHGPhV/0al0R/gBp07/vGnp+VGn1R90MDon49ufUs40d6rv93WN/0NoBvuebrun2gnMbX4U8ZQZnD+CUqWk9xwNOvAtVpRrmBVjiP3ucRH7JSf/eU0k5Khgiy6mzB/qwZ4HEBuhubGusYoCi+Yy565vGGqYYMlbqYhStgNbRZBUni4pfHC9POSpN1Cyr/Bb2iQdmJyoawKsBANDQl4VwiWRORTnZjIHL8Knzqc4A6/IF6PnYWuw2UF/HFP8rbw/6iJrEw805w/w6HAwxguy2nrFyKbjpt9rBWTLKBJ/NpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhEGJX8Cn/DS4yEFMGnnAkfDEnoXNL/6P6DYAgIVTh8=;
 b=KVWjbgLLGSB3/uPCL0HxazCMXYi3ZaARzt2EDxql5An5IySivTKTU6IKq8HgCSCDULMYrMiW4ZxytQmgyl9jBYBI9NAOnBGPIsQYFiYrKjTnl+oq0jYduYX+/NrEnP2JzK7zXPbG+gXWRpGNeA03QKmEA9O88SAHhgWdNKrZ3OA=
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GVXPR04MB10048.eurprd04.prod.outlook.com (2603:10a6:150:118::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 07:18:11 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::e60b:413c:25cd:c03b%5]) with mapi id 15.20.7587.026; Wed, 15 May 2024
 07:18:11 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
CC: "marcel@holtmann.org" <marcel@holtmann.org>, "luiz.dentz@gmail.com"
	<luiz.dentz@gmail.com>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Amitkumar Karwar <amitkumar.karwar@nxp.com>,
	Rohit Fule <rohit.fule@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, Bough Chen <haibo.chen@nxp.com>, LnxRevLi
	<LnxRevLi@nxp.com>, Guillaume Legoupil <guillaume.legoupil@nxp.com>, Salim
 Chebbo <salim.chebbo@nxp.com>
Subject: Re: [PATCH v3] Bluetooth: btnxpuart: Enable status prints for
 firmware download
Thread-Topic: [PATCH v3] Bluetooth: btnxpuart: Enable status prints for
 firmware download
Thread-Index: AQHappgKuQVwlM/0j0mu78G+qKLfig==
Date: Wed, 15 May 2024 07:18:10 +0000
Message-ID:
 <AS4PR04MB969212EDE791409746028506E7EC2@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20240514091444.1508033-1-neeraj.sanjaykale@nxp.com>
 <5d7f5918-d821-4757-bce9-2fede79d7fe4@molgen.mpg.de>
In-Reply-To: <5d7f5918-d821-4757-bce9-2fede79d7fe4@molgen.mpg.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GVXPR04MB10048:EE_
x-ms-office365-filtering-correlation-id: 651ae080-3ce8-4336-ccbe-08dc74af2d79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?bHRidCtIVlFwWFNydzdjUXJNVUtqQk1aeWlPcE9WTmc5eDRDQTQxZFZrZSta?=
 =?utf-8?B?U1JWbGdKSVRVaTJIVGFKQ3JoQkNZNjNIM1d0alRVQ0JLRklCanRXek1qV2ZQ?=
 =?utf-8?B?ZmpRSmFzRzNGeUdFak5rdHlXdzdCaFIrODkyUExBdStiUW45cEJheXZzV21w?=
 =?utf-8?B?NFRaYjZqV3d4QmRaMEkxRmhkN04wcTNLaFlvdG9DWlJYT1RFcURaa3gxOWht?=
 =?utf-8?B?dnRjNHZIZkpXZEdvRWg2Mm4rbnhmUG11NTRtQ1lkZ3JHOU9QZ051d3V3ZWps?=
 =?utf-8?B?KzVCMlNWMlJkVDk2eEM0MlYrU2pLUmd4WDZCSHdBR1ZoZXlOQndKc1JHT3p3?=
 =?utf-8?B?UHdNRWY2Ny9FU1RYRmVScU5aWGUxYTFtdzBWN2lRak0rZUdTZzdiSW1QSnhK?=
 =?utf-8?B?QVF5MkRsaWdiUTM0djh4NmFiZUJuWFRaUTBlUkdsTU5WMVFvV2dTUHVvTXhj?=
 =?utf-8?B?S1NWSUlPYlNOWC9KVFFFNFlBcGtvMkhOREFQNnltM1lsTEdSbEI5MDYycTRD?=
 =?utf-8?B?Nzh6TmttdUVaUHVMaXdwVHB2ZjFxNFcwUWxscjQ4YXJ4by9pUUxDZXJNQTdx?=
 =?utf-8?B?OUhoVitIRUpZRmdoTmwxQVJpNlE5bFpHZ1Jud0Zsc1I4VjBDRU4xQWMvNG5m?=
 =?utf-8?B?WE5vdnhOem1Kb3lKZ1dWa1hENFNVcnRXWERtQTBMeDQ4MVU0a085TDVYUVA2?=
 =?utf-8?B?UHdlZnVBTTF1Skp3TWY0czgrd3I0ODVwbE9GSU5wVFJ4alhMU1BXcW9iOUFT?=
 =?utf-8?B?bjEwSEdiLzFsMnFOeWhveS90aGUwTlUrQXlYSFQ1WmtkMDJpMU4yWVNBSk8v?=
 =?utf-8?B?NFk5czVsdUdYd1VGdFo1RW9zeE42MHFsSFd5eTFGWWhsblErRGZ4cEtOSG42?=
 =?utf-8?B?MFpQU3NubThZa3Z0UjY2aHltQklxNWxSWkROWG1Ma2c4YS9yS2lMSXdyZ3NX?=
 =?utf-8?B?ekpjQjFkK3g0Z2RtOXpFT1VheXUzWDJLR2t2dzhCK2puakNjTzNNRTJWemtx?=
 =?utf-8?B?SXp4TXFIN0FNN2VjVVY5YWszd0hRaVA0bllyV1loWTM3NTAxejV0RlBpSGdi?=
 =?utf-8?B?dEhpQ2pxc1BPVUd3SjFnWjcxWTZjWnFUWFlOSklvUitNTlZjN2JnR3dkeWs0?=
 =?utf-8?B?ZSt6WXNOL2Z5S0hHYXpCMWtXa0ljT3BpRFBnTkoxaXhLdW1xWit1czFVRnF1?=
 =?utf-8?B?ekt3UUY1bTdQd3pHYVdsaDhYYXRqem1hbWkxQ00xbXVRYTVMWjlqRHdaejRW?=
 =?utf-8?B?OXBsWEJ4VFh1RE9CbVZTb2JlYjdUQ29PMzhkUWRsMlNTWXl3ZVBPWk1hRGtZ?=
 =?utf-8?B?cTBodUxWay9IaXpYSjU3MzJLS0FlbER0d0JNOUJSa3R4TDlHWXJ4Zy9HWlM1?=
 =?utf-8?B?dkhiRnN3Z3NrUzdOOVVXK095bHBCRGk1aDJTY0N1cUJWNGpESDN1VVpUckJt?=
 =?utf-8?B?eEgvVGQ0UFRUWmRwSFc4bHBubW5xNVB2R3FwWmdxbUlaamVFcXcwdnJhVHFP?=
 =?utf-8?B?R0pEZGZ4RGpLaWZVaGNVUlc3NUhDdEFHQ09OenYyVlNvYUVkN08vNVp2a1Nj?=
 =?utf-8?B?T0ltN2lLaVBQZ05CNis5VVVCeVB2WW1maWJaVG1QY3RLbVhCNWd3LzZpMlRi?=
 =?utf-8?B?eE41OWZTN0FITjhpcUVnL3k2bVNXU01VVnN0M1dEc2JXcnY4VFViSVdZVHRh?=
 =?utf-8?B?MENsWHdCdTNYSW00OTdQdEtJbUZSdzZlbzZ6VGFkTzNnc2tEUHZ3S1I4Mld5?=
 =?utf-8?B?eCt2UXM4cFlZSXBETUM0QVpqQVdRd3dsK0lSN2pDMHlGblRDbkRiRS8rU3l4?=
 =?utf-8?B?NWk4TGxpMUlaNHl5Sit4QT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUw1dlJ5TEN6a2FoZHB6cUYyZXBUeDJIY2MzY0RjTlJwZG5na3hacno1Lzky?=
 =?utf-8?B?a0JidWp4NUtITW5ldVNJc2t6T2Z3bkRBbmZqbWJidmVtcTUwbGRJaGhMdzll?=
 =?utf-8?B?MXN4TmUwbUVZclFwSkNWeHpoNWFuRlBDR0RRb01VakVWTUw1Y1g4R3UrT3l6?=
 =?utf-8?B?QXQvL0FPNUdEVktETGJpL09uUUFLZ1E0U0xxYkQwcXhsTDZOWHdSTmlqVjN3?=
 =?utf-8?B?Qk04UzROcWM3WXVjaU5CbDZUakZWWnJHVjhwU2w2L2d2NUxiaDQ5OEVaU3pQ?=
 =?utf-8?B?V3JlbHEybmUrTW82NVE5QVZ2Uk1yUjlqN2dLdWNaQ1lMVWtneU5McnFRWndB?=
 =?utf-8?B?Q1krVUlmWXZOdHJkRzBsRFl6dmRKbDQ3WTJoT1ZlWnRDc21MaHRKM1ViTlpl?=
 =?utf-8?B?VmlqQ0ZvUFdkQ3hYTEhwMnJyQnZyUjVlUjNjN3AvU0k4MVBtVWRMRmE3WjVU?=
 =?utf-8?B?NFZLNVRuTnQ1Rk51TG5aeUNMeURaZ0xTcUY5blJwaFh2RFFNTWRtMnFIaWdR?=
 =?utf-8?B?STVwUmd5MjFVQWFLWVBsbGtiYU43NW84RWJVTGtHVC8rWFBtaDRyTTNhRHRM?=
 =?utf-8?B?MjhKdGpVdFFzOGJ1MTE5aDJzTG1lVzFidFJOWnNHNFNkdVNVNU1PMzk3UUxE?=
 =?utf-8?B?b2pZVGFCcVRicFBCblFXdGtSaVNmUHJqRE53Ynd4a0UzYTBrcVBjVXFWQ0FM?=
 =?utf-8?B?MTh1dXNDL0J0WlpHamNvOXNkaWRmNFdoK1h2MEY4NVlwRkI3ODI4bDhKM2U3?=
 =?utf-8?B?SXJHN3drUFRLMHFDWVVIdjJPVEd6ZmgrdzVDaVYxZ3F1TDhmUFd6RWhBcE0y?=
 =?utf-8?B?dzNTSFRDbGZiUkFEZStLQzI4V1VhcFBicWNDcXgxNHpoSDF0UEtjQ20rVXd6?=
 =?utf-8?B?MUhKWGFBR3U3M09RcUJBZnJqdHdWYTVqQS8vSXhOeWV1eStJc2wyazQ0VCtC?=
 =?utf-8?B?bFhWL05JWGRTY1NtcW1vaXJmNG9OMG9SZ3doK3dmNWFXODJoVUV4SlI1WGw3?=
 =?utf-8?B?eTR5UFNhakpYUkErWnJ6MndheWwzSEZjY3RpbEJTZzdFWGdlV2xmb1dEcnNE?=
 =?utf-8?B?eTFwY0tpNDlnRTZQZUE1Yi9xbWNKOWtXRTVmRndFRC9EY3cvSlh6K0hUNEZ2?=
 =?utf-8?B?TGp3SkFPQ2F4cllFendPeUZJb290TVV4R0hHM2JoOHA2Q2hDRVR4Q0lXU3Vu?=
 =?utf-8?B?dUhURXpVUGxBUDVJc1F0bUdrV2pGYmFDSFJ6Z0pLVFhXNWhaVjRTdk1RcTBq?=
 =?utf-8?B?b011dHdlMExJZGZpSDVKNURNT05FS3RhT2FwRE1JZXVzNmlLOE1TWkpmL1lW?=
 =?utf-8?B?MjJLSkhXQjdrNlpYSlZwRG52MHZ2c0g3M3FKUEdUWnpJbTNvbE1veDUzVi8y?=
 =?utf-8?B?R0lGQTNOK3ZLRGU1OVJyTXhndWVjOHUrYjhaNXVaTUhNRFlyZ0dXdDFpV0tL?=
 =?utf-8?B?UVhVUVJhcEl5aFU4L1ZoaEc5SGZHRWVTSWRSaEZabW1QWkNHUVFpclJsVklh?=
 =?utf-8?B?L2VjSzNLUDBXeHU5Q012d2lhL2UxcjcvaldpektxT0Nnc1hiK3BIZHdZQU1L?=
 =?utf-8?B?bWVDT1BTazN3c0Rad1pSc1AzMWZmMVhIY0RzeTNXQWczV2JLRXM4U2doT0NW?=
 =?utf-8?B?WW9MNExyTHpwSVpVVmxCSWszNmNCZVUvQ2FRbWlUMjZuSFUrbkhjU3lIRnNQ?=
 =?utf-8?B?UHN4NXhVS3h2Z09UZWx2b2trcmVYV1ltZTlHNzZKRld4d1B6eFZZbnowZkl5?=
 =?utf-8?B?Q1ZLWHFzNTRyUGxEOGJNQkUyUG54bGNNcCt4b3djMlpJa256Vjg1bm9ReE42?=
 =?utf-8?B?MHFyK0lLVkQ1YURON29TUDRLOU5MZitsNjVuNGVoWnpESThqeHFKNHJmbWcw?=
 =?utf-8?B?S2xLOXFQWjMyTmVBL1N4bTlQS3B3clBDU25UbkdBRm1RbTl2UVQvbzF6bkJk?=
 =?utf-8?B?K0F1K3ZUcHNhbnhPbU5KcnF1UmEzUnJoSHl4OGU2YVYxckNqdTZDL1ZZbk80?=
 =?utf-8?B?MmVaTUxhdE5MZXg3WXc3c3dmeW9VK2VEdjJmVlc2STFFMDFCOXdQQXJRSFk3?=
 =?utf-8?B?OHljV2FaMU8xQ3VIT3d6SWt2TWF6aW9adTZLTTQrcHhWc2pwbkE3WmZwbWJv?=
 =?utf-8?Q?VIrN5TjJgBEv46jAsnC5ZbKZw?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9692.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651ae080-3ce8-4336-ccbe-08dc74af2d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 May 2024 07:18:11.0386
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xF8wfQZRzysjbATIZGOFbAWNfdMvxaYR4CAS8vUXFiyX7gCuvg2AYKPG1PFcK7pMFeAAHY+BTSRrEKlmMAoil2SOXCLhZfaVexK+eMLUaoE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10048

SGkgUGF1bCwNCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmcgdGhpcyBwYXRjaC4NCg0KPiBBbSAx
NC4wNS4yNCB1bSAxMToxNCBzY2hyaWViIE5lZXJhaiBTYW5qYXkgS2FsZToNCj4gPiBUaGlzIGVu
YWJsZXMgcHJpbnRzIGZvciBmaXJtd2FyZSBkb3dubG9hZCB3aGljaCBjYW4gaGVscCBhdXRvbWF0
aW9uDQo+ID4gdGVzdHMgdG8gdmVyaWZ5IGZpcm13YXJlIGRvd25sb2FkIGZ1bmN0aW9uYWxpdHku
DQo+IA0KPiBQbGVhc2UgcGFzdGUgdGhlIG9sZCBhbmQgbmV3IGxvZyBtZXNzYWdlcyB0byB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQo+IA0KPiA+IEEgbmV3IGZsYWcgQlROWFBVQVJUX0ZXX0RPV05MT0FE
X0FCT1JUIGlzIGFkZGVkIHdoaWNoIGhhbmRsZXMNCj4gdGhlDQo+ID4gc2l0dWF0aW9uIHdoZXJl
IGRyaXZlciBpcyByZW1vdmVkIHdoaWxlIGZpcm13YXJlIGRvd25sb2FkIGlzIGluDQo+ID4gcHJv
Z3Jlc3MuDQo+IA0KPiBDb3VsZCB0aGlzIGJlIGEgc2VwYXJhdGUgcGF0Y2g/DQo+IA0KPiA+IFRo
aXMgYWxzbyBhZGRzIGEgY2hlY2sgYmVmb3JlIGZyZWVpbmcgdGhlIHJ4LT5za2IgaW4gZmx1c2gg
YW5kIGNsb3NlDQo+ID4gZnVuY3Rpb25zIHRvIGhhbmRsZSB0aGUga2VybmVsIGNyYXNoIHNlZW4g
aW4gY2FzZSBvZiBmaXJtd2FyZSBkb3dubG9hZA0KPiA+IHRpbWVvdXQuDQo+IA0KPiBQbGVhc2Ug
bWFrZSB0aGlzIGEgc2VwYXJhdGUgY29tbWl0IHdpdGggYSBGaXhlczogdGFnLg0KPiANCg0KSSBo
YXZlIHNwbGl0IHRoaXMgcGF0Y2ggaW50byBhIDMtY29tbWl0IHBhdGNoIHNlcmllcyBhbmQgc2Vu
dCBmb3IgcmV2aWV3IHRvZGF5LiBQbGVhc2UgbGV0IG1lIGtub3cgeW91ciBmZWVkYmFjayBvbiBp
dC4NCg0KV2UgY2FuIGlnbm9yZS9kaXNjYXJkIHRoaXMgcGF0Y2ggbm93Lg0KDQpUaGFua3MsDQpO
ZWVyYWoNCg==
