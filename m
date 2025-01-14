Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013067.outbound.protection.outlook.com [40.107.159.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDE813A3F7;
	Tue, 14 Jan 2025 14:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863639; cv=fail; b=cjzfGqncAibkXMCBxbAvuI5tVPoQmHA+0rdfCCb+B6bns3YicxAQpjx4sH0KZFKtCg/hvvhpFQsvbSfRI1rCloQZDkwA3yuP9vc1rfOB68tHnbanhcs/hk+01E5EjXVE8XpFPt/EF+ztN14ZVZ13hHTthS4BrzJenrWfVcSq+Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863639; c=relaxed/simple;
	bh=0AbiEpESGQ7wBxa5VTZC86ijkHQJX4A9tlEoLbJycfI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+CWDHZ78yR2hfLkX55/VW+TVneK1IsGsKzHKC3qQRJgtS3U8JSav/TwDYgicgczJq4d/zIOB/YPsNrqEfKNSsEqvPnOm+DEUMGT+gGdOIfADXbhqpeaAYsDtnlSI/XSHqt1WErSj3h9QQWMcl5tGwekcEHwArGX708ns56cieY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a16nA8xi; arc=fail smtp.client-ip=40.107.159.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a16nA8xi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=irZwioQW24PndcrYLPpc6TQwq+i7YOihimt98yHVt7NfObuZ/1YLBJLczczTPS9AlkZapgBY1pWytEVBPKPnOcNZ/hzdu0t3Dkr1IaxyYEaf1J2FSaEDg44CZtKHft3xwUZdMnJAtyi072T/vznsh3/GgwDXS4JW0mR4uNoPP12+bak44BzN+jytcE/4s//FyLqrpNql/QfhBaQrnJ+aLy4sTcmUbGBrDCcC754uqHUN+obrrrCoqP3NhiAErIzasxUu3tLThmznm+MO0sYh9MpLTMOjE6xotdlYpWnzBgpWqyQj+R3Rx32I5lxbO3CmMqcFTkraiTdZs87ovYZk1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0AbiEpESGQ7wBxa5VTZC86ijkHQJX4A9tlEoLbJycfI=;
 b=vHBZxZC8TBy5EnHWj4pyLs5LjoBQBXiUhfKd68Rn+5ybPUAG93BFLc6K3YExNvAwJhrGF8x1bPRz24MH/7VDh8TpUKDqI4oWt60VRMiTD0O9r4phlRpB+KCKTiaj0BFo9+t4Rb8JeBTsn8yDgXPEdg/JLekyj7iSHOJ54F8ngu/aRIvVWE8bI3cYGwcZ+8aQK2t/+ZGvavjYped1ejbNpshuZiyLbpmKIGmK9vUZpqzFUdf0lZ3ERnuSrzX9SlxItsO6Nm82D9r9QkbYvIjNUO+ZjyglKmRkxuqoR36N8UnF3/LorM9NBGxGKgyAjnkt976lP5rTDF9pVyfcKfUNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0AbiEpESGQ7wBxa5VTZC86ijkHQJX4A9tlEoLbJycfI=;
 b=a16nA8xiA5PLsUZhiPL1Fhn3z0Ixqlz1X6CAzVLnDDvM/xl3mx7P2iLrfskUk4Z8kafmZXOGA/EKW/QWHf9DZNztKqJgocXmXM5iXA+UC5zIpx7rAfqg3sn2jRCm1P8dV1zt92lE1VLxs027abNk7/RnhaANOAs/Ipue4jIxRgPjVqsF2J6OA4NEpkziD74V5X5RAqiGiyCOtFfG4HcmLKgSDWZja9gBP6lMDhFBt90sgvh8VR2HA6tdQG2M72KuU2Gaa4dD2yo+Ml28qQBJJWfLKLnSkQXcd12bTeBr1Enozz9N7bUsi0qGAV0CIFv7dvI1Uvhetn57jciWQaHQ1g==
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com (2603:10a6:102:270::15)
 by DU2PR04MB8968.eurprd04.prod.outlook.com (2603:10a6:10:2e3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 14:07:14 +0000
Received: from PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a]) by PA4PR04MB9687.eurprd04.prod.outlook.com
 ([fe80::742e:a5ac:15f4:116a%5]) with mapi id 15.20.8335.015; Tue, 14 Jan 2025
 14:07:14 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Johan Korsnes <johan.korsnes@remarkable.no>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Luke Wang
	<ziniu.wang_1@nxp.com>, "kristian.krohn@remarkable.no"
	<kristian.krohn@remarkable.no>, Manjeet Gupta <manjeet.gupta@nxp.com>
Subject: Re: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
Thread-Topic: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
Thread-Index: AQHbZo2c7SfC86UBCkGPmvu6Fxzd4Q==
Date: Tue, 14 Jan 2025 14:07:14 +0000
Message-ID:
 <PA4PR04MB9687E566EEC90DEF5FB44A2CE7182@PA4PR04MB9687.eurprd04.prod.outlook.com>
References: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
 <20250114133548.2362038-2-neeraj.sanjaykale@nxp.com>
 <43beb3f3-071d-4f58-b356-6dc6b9de947a@remarkable.no>
In-Reply-To: <43beb3f3-071d-4f58-b356-6dc6b9de947a@remarkable.no>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9687:EE_|DU2PR04MB8968:EE_
x-ms-office365-filtering-correlation-id: e95660fd-4ff2-45ba-e45b-08dd34a4bf65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UE1nVWZzb0loV293UGFLbVBPdnB1QVVyN1pvZFpvMVdtMDVsVG9GS1RLWWw5?=
 =?utf-8?B?Z0xoQXBSZmoxSlJGR1owV0pta2huQ2c0Nk9FZlpWU1ZjQnJucDM1cy9ETVQx?=
 =?utf-8?B?L2VRSkJ0VFdScW9VOFpCNXhiVlNOMHJwS2ZkRDZ0ekthZDZzS0dTT29CM1g4?=
 =?utf-8?B?dUpCeS9zc29jL0NPWDlRTXR6dmxhUjN2WU9FeHBMY0ttbE1qRkNpcmIreUNz?=
 =?utf-8?B?bXpiVkprOHIvaG9OaVVOL3FlZDJLK0pFT0FhcStVdTkzN01xVHpJdTZZZTli?=
 =?utf-8?B?L0ROMWpHU1liMGMyMVBzZHZrSE9DTEhpYnJjNjV6ckxOWWZCSzcxQ2NuczN2?=
 =?utf-8?B?N29sMzZiNTJ5Zmo2ZTFxZG9tS29aN3BMVEo4K3NVU2VvRWlUNm81THZYeThQ?=
 =?utf-8?B?T0VpZkdpV2hNUXJIbC9nbHRCYW9OUjNMSDc4TUh1MTlTT1FzRm15RGd6amtO?=
 =?utf-8?B?K1JkTDVNdmxPVC95MFYvQ1grZ1VEaGFuRzFudERxUzgxVllyZlhZTHA3cHcz?=
 =?utf-8?B?QjdBcUhFUGNKbFk2dXEwbENvOHBjS2hOaUN6T0hLa2QrcHhGMEsrcTNZTFdu?=
 =?utf-8?B?d2xVVEQ2dWdaOUNVT3BRNGt1MEpKT1gzRmJmVk1KK21WeW4xV25wV1JjZC8v?=
 =?utf-8?B?UkRWVHEvUG1OcU51WDIyS2twOUtSWkZGS2JEb0pDOUVyQ1JMc2thM21ZUjYr?=
 =?utf-8?B?RW1qOVZ6Y2MyVVNaSUJPL2MyZXlnVjlwbXk0WVFVeTR6UHpsT1hyZVpCNFNn?=
 =?utf-8?B?c0JNWHJkdXJNblhuR0dSYjRJUWdUNFhDR0Y3NXFlYTRBdDhNSTlobElONVlE?=
 =?utf-8?B?SlB0bTlqbGlnM1F4eGh5ZWRwWUJDS3I5bnNwYXNwdmxhQWN1b0l6YmdBa3B2?=
 =?utf-8?B?b3ZvclhzOFJXUXN0RHJKd0ZMNHFzR3YrQUsrVjdsR25aV2poMjJFaklCeUhw?=
 =?utf-8?B?SFZ4SHFQV3BualdCdkF5eTBKeU5vVXpaVXpORjA1NzBxMzNscTRrU29tQ3pO?=
 =?utf-8?B?TjdBZ1FsYjR0elFXM1dpUnNwTUhSUVk5cHByOXNtekV6MUprS2tWM3F2WHZZ?=
 =?utf-8?B?ZGZpSm9DNlV0dEUrK3E1WjdiNTdpcTFyRmEzVWZiZ1BSaC8rbVMyZ3lyOUV4?=
 =?utf-8?B?SUZldjB3NzYyN0hpSVFCVmRIQmtiSkNDUEhmbER4ZW84RlVVV05WU2hLbHM2?=
 =?utf-8?B?QlBzWnlrRmJBYWhZMEdnMWVJYnR0WE5Qbjgxc0lWSFFwNjN4WENReThDKzly?=
 =?utf-8?B?N1d6SkMzNW11L0VwaGcrZHdQVWkzOWQvUVpLL1MvQ1J0OWJZczk0TmE5d0hj?=
 =?utf-8?B?cUtwL1Z2Tk1hUDdXVGJ2R0l4SVBaMk9FMmtuSFQ2TW00Q01LS1RFNzU5RjNU?=
 =?utf-8?B?UEN4Y1dhd08rdmhNR3JKOXppRXJKQ0M3VFRNZVUyem9FWTlhNGV0TjRvcmZm?=
 =?utf-8?B?QllTbW4yMC9LcGxWWU9mOVpJZTNkRVpPWFE4SW03cnJqUEtWZkZPcG9NMXNT?=
 =?utf-8?B?SG40cHFXdE1sWktYTno4MkFQMGRiRXN1UFBUQ2p4WkpMRHB5RHdSVkVaeUlx?=
 =?utf-8?B?Y0pVWUpTM01PT2RoM1NhUGpTVmFONXJ3V0l6VFNjUVZ6WmVlTDlPTlhleHdZ?=
 =?utf-8?B?YW9tQ1Q1eENsNEVnQlplcCtCaHI1dkxHVDVSSUZvaVZQc01rU0hBdVRJTDVs?=
 =?utf-8?B?VVIvTGg5eXI5QlhIcmtreVd4UEZla1NSc2hhajl5cUpwVnR0VjVZcnRTNW05?=
 =?utf-8?B?clF3WHV2dy8zNjNQOFpmWmpGejVJbm4vTWtKQXNDSENUQ0lHWVBmdi9qVWtq?=
 =?utf-8?B?NkprWjZyMUhDNmhPdzFGTVdPbHJKbTJaQmhqaGJ2QmlHMmVEbEV2QytnU21t?=
 =?utf-8?B?UFdINHFXQnRtTkVkTkVuTkduQkg3NmFiWWg3SUl4TXBoNVEwZ3laS1pCZGFv?=
 =?utf-8?Q?oQHvTeTJaxFqpBga5PD63j4RnwoRwbyP?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9687.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bUlBWGFyWW1QWXZkNkkvdnNMS3lHUFNjbU05a2tUKzFNdzYwUnVjQm8yWjBa?=
 =?utf-8?B?NmJFMDdKejNDT0JoR3ZSVFZkTVJPWnhmV3VuRVkvd2dyOThJWmhzWDJ0Smcr?=
 =?utf-8?B?dTJRem81ZXU5b3ZqdG5xd0x1ZFExRU9zQzM5Qjh6NlVoWng4VUxLZHA2bHoy?=
 =?utf-8?B?QVhVcXc3WHV0ZFlyN3hRc21nNXUyNXIyN0xBN215ajRvZGZVZnYzekllWkVO?=
 =?utf-8?B?TVVBemlqeHd0S1g4M0V5dVhzc25iUkh5U0ljT0s2aFBPQU1vZ0dLcEwwYnM3?=
 =?utf-8?B?a3M1c1ZXWFh4NmR1eVpiemNTMVlNcTJia3BoRU00Vk4xVEVjQ29aSGNJTTFW?=
 =?utf-8?B?K3NRQnErbUtncUUvSmhPcnN0Wi93MkdEZU1jZW1XcEVCanpjMFRsWXVDT29R?=
 =?utf-8?B?NlFwVitkRUhJVDVyS2xHL01QcnQwV3RIeTlFeFlhSUJ2dllLVEgxMVppalpY?=
 =?utf-8?B?K1BqcUh6ZnNhWGN3YWxvUDd0ZzBKNUkvOUEwV3p0eFVhTlYxdUtSbWZnR1Vh?=
 =?utf-8?B?blBKUDNDRFRrZG9xNnZzb3A1TVlES2NKUUdkc0dyKzF0WDUvMytwNkJlWSt1?=
 =?utf-8?B?MW5HSGozSzd1UHA2RDlPT0lYTVQ4ZnowdnJuYzVvZWp2T0RRcjRLVzhFWHgv?=
 =?utf-8?B?OTdRaDBHSlErQnorMkw0VU1STFZqcGFHNFREMmJkVUMyR3BPQkk2NlRmRE9w?=
 =?utf-8?B?b1QyRzlwSkFOTitqNUFybTgvTXdsV2h6SVNtYmszNzZWM24xMmZveWw0WExJ?=
 =?utf-8?B?YkVLRDB0YXVIUUF1eDhuVjBZNFJ2MWx5QmR1V1ZDSDViK3kzM1F4ei9BUmNl?=
 =?utf-8?B?U2FTNmlwbEZxUFJ0cnp5am4xTVZqdklxdGVHRWRBVUVVeGp3ZkYxSzJ0RWNP?=
 =?utf-8?B?citkNUhYalUrSlpTYk1XRkwwVHhiM242ekYreVZnTCttZ0lKbXhjMGgwSTZW?=
 =?utf-8?B?UUoyRVhpcWpBN3ZVNC91RlRVRm5UUU1tKzVzR2dHcXM1M0JZMmZIYVprMjRl?=
 =?utf-8?B?Vy9ORmVLMmYra2RCa1RuOWx0cE9nRU4yTGtIVDVpTmlkQWpPNG5aWlJhSVdD?=
 =?utf-8?B?MmRHempQRExwZ3BOK2NtTHFRMkoyeWtCY2VxdWdaYnIvR1JlQXVHMHNheGs5?=
 =?utf-8?B?WktVeU5EQTJ4bHhyaHQ1WjNmbDRNL2poNHkzNUEzRE1TMlhmVWFnV3RUem41?=
 =?utf-8?B?YTZRWHhQV050M2RhOVZPc3E5dDFRNVBYRzg4cjFLYVY5U0wyY05nQmd0c1dn?=
 =?utf-8?B?V3Rzb0o3bW1FZTRwVlFmbEUwQzJsVitJRjRCNCsxQ3FtdTVrdWNrOWlJTVIz?=
 =?utf-8?B?c3kxQS9BSEg1SXA0a0RYQXBYU04yWkpxc3dMNXVISWlPNStsR1UrRUNUT2xG?=
 =?utf-8?B?TjhhSWRnSmhpN0lRRzV2SVE3T0d0bElORTVSUjJ6eGhWRzM5Mk1ZYThaWVpt?=
 =?utf-8?B?Si9pTUtpdDlEV21peWVqL3R6eFZsU2lUVlB2Z3ZlOG1Vb2NjUEhVMFc0NUwx?=
 =?utf-8?B?UnpFeS9BbTV0eUZabkhZSjdNR3NMcHVubGt6TjQ2cU0rMy80R3VPYVhNeUNT?=
 =?utf-8?B?aDR5Nm93akprdi9LSUxIa0hLRERRNkZxT2VvTmRocjdzdFllNXhKT3FnaGln?=
 =?utf-8?B?ZnJJY3RmTHY0Z294NlVYNlpWc0tpcUpXSTQyY3J3Mnh4WDBqclFWbUtSVXFx?=
 =?utf-8?B?MDlpaW8rbFZFTWw5OWVhWVJGRm1PR3hiamh4NmJHVVVPdkpoZW1ReTJBeEIv?=
 =?utf-8?B?Zzc2aVpGV3k5MzNwMVplMHk3YjdFMG1idmdnbUJNNm9YKzdHVEhiN1hscGpp?=
 =?utf-8?B?Z3E3bkw0bFArM21XR2w2MkQyWjRxNFB1emRQWlZ0dUpLb0tUSGJxZEwwWHJk?=
 =?utf-8?B?eTh2cGRGY0RXMXF0QUE4SmxjMXBwSWkwbjF3UUtPWXk4ajRoQyt3QWlVTDdN?=
 =?utf-8?B?YnVPQzd5YmNVSjkzcjRqcnhvVTE3WnJ0a1RUdHppOGt2VlNSYk1wK1hKd0sv?=
 =?utf-8?B?ZitXWWI5blRJTXNmb25yL0NaT2o4czRkdkllTHcvRGVKUUpjb2IzdzNpcVZv?=
 =?utf-8?B?YjcxZ2I5QWd4dXh3MHZiVS9nRDR5ZkQ4UVJ4MnZXT0tSbW9XaS9BY3E0ZDgr?=
 =?utf-8?Q?crXHKGtwgel/7UJLkkJyR958t?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9687.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95660fd-4ff2-45ba-e45b-08dd34a4bf65
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2025 14:07:14.6102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWPis5AtCsCp1Stnjb40SU473eL0h/HEnDwM2MbG4tUijQg3Yav7gBEEECC52AW0Kz4B8U11lFXge7P6AuMoYejjOBi88Mhf54u5Iq5rTk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8968

DQpIaSBKb2hhbiwNCg0KPiANCj4gT24gMS8xNC8yNSAyOjM1IFBNLCBOZWVyYWogU2FuamF5IEth
bGUgd3JvdGU6DQo+ID4gVGhpcyBhZGRzIHN1cHBvcnQgZm9yIHNldHRpbmcgQkQgYWRkcmVzcyBk
dXJpbmcgaGNpIHJlZ2lzdHJhdGlvbi4gTlhQDQo+ID4gRlcgZG9lcyBub3QgYWxsb3cgdmVuZG9y
IGNvbW1hbmRzIHVubGVzcyBpdCByZWNlaXZlcyBhIHJlc2V0IGNvbW1hbmQNCj4gPiBhZnRlciBG
VyBkb3dubG9hZCBhbmQgaW5pdGlhbGl6YXRpb24gZG9uZS4NCj4gPiBBcyBhIHdvcmthcm91bmQs
IHRoZSAuc2V0X2JkYWRkciBjYWxsYmFjayBmdW5jdGlvbiB3aWxsIGZpcnN0IHNlbmQgdGhlDQo+
ID4gSENJIHJlc2V0IGNvbW1hbmQsIGZvbGxvd2VkIGJ5IHRoZSBhY3R1YWwgdmVuZG9yIGNvbW1h
bmQgdG8gc2V0IEJEDQo+ID4gYWRkcmVzcy4NCj4gPg0KPiANCj4gSGkgTmVlcmFqLA0KPiANCj4g
SWYgTlhQIGZpcm13YXJlIGRvZXMgbm90IGFsbG93IHZlbmRvciBjb21tYW5kcyBwcmlvciB0byB0
aGlzIHJlc2V0LCB3b3VsZCBpdA0KPiBub3QgYmUgYmV0dGVyIHRvIHBlcmZvcm0gdGhpcyByZXNl
dCBkdXJpbmcgcHJvYmUvaW5pdD8NCj4NCkhDSSByZXNldCBpcyBhbHJlYWR5IHBhcnQgb2Yga2Vy
bmVsIGluaXQgc2VxdWVuY2UgaGNpX2luaXQwX3N5bmMoKS4NCkhvd2V2ZXIsIC5zZXRfYmRhZGRy
KCkgaXMgY2FsbGVkIGltbWVkaWF0ZWx5IGFmdGVyIEZXIGRvd25sb2FkIGlzIGNvbXBsZXRlLCBi
dXQgYmVmb3JlIHRoaXMgaW5pdCBzZXF1ZW5jZS4NCg0KQWxzbywgaWYgbG9jYWwtYmQtYWRkcmVz
cyBwcm9wZXJ0eSBpcyBub3QgZGVmaW5lZCBpbiB0aGUgRFRCLCBzZW5kaW5nIEhDSSByZXNldCBj
b21tYW5kIGluIHByb2JlIGRvZXMgbm90IGFkZCBhbnkgdmFsdWUuDQoNCldpdGggY3VycmVudCBp
bXBsZW1lbnRhdGlvbiwgaWYgbG9jYWwtYmQtYWRkcmVzcyBpcyBkZWZpbmVkLCBkcml2ZXIgc2Vu
ZHMgSENJIHJlc2V0LCBmb2xsb3dlZCBieSBzZXQgQkQgYWRkcmVzcyB2ZW5kb3IgY29tbWFuZCwg
YW5kIGtlcm5lbCBjb250aW51ZXMgd2l0aCB0aGUgSENJIGluaXQgc2VxdWVuY2UuDQoNClRoYW5r
cywNCk5lZXJhag0K
