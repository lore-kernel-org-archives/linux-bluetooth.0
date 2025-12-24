Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013040.outbound.protection.outlook.com [52.101.72.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D71333F364
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Dec 2025 18:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766599542; cv=fail; b=cJ0g42ejQs97dS4tmOE6/PkaqXch5fzXT9nggcqvpwKu6v4nFjjpPeQpChKPCqqmRTaCQdPpkJOi9N4sJ5ebK/K7DzX8HQbVjM1eijrKiQ2PhLFPg2+3nCeZ+PlySd4+DpRdilcVojJVCBKaXYLGSMdTDxL3Z629fBLod5PSeiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766599542; c=relaxed/simple;
	bh=4IxZ/9Jrj82AQ3quZ7ViP/Xjna5oChnCAh4o8nKu27w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ujftvonz7f1ceo45O+U5M7m5mP+ZKydswV9xKEG0VGphC0p2O/KkQ/YB3ZjBzzE2hGcsbsJGFtCokrucrTs2VOEiHB+W3xGic1ta9Sq9y/HJ6y9mfKnFpr7IG97i3ENGPG4GTWmiE2Dg5XrpJvvmU5DClBOwC7TTTys2YE1+YSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PPtH3fkP; arc=fail smtp.client-ip=52.101.72.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PPtH3fkP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v45VMZP7xblXKP8Q84VhOvguUgkJxkt26O7GCeRqze6Dp31ndf4PoeSl4OOMlGq1QJ+6vIeDfdo24JgpkHNa86DSivYB2R7v9B3+vTSuLMieQOjTJNsINU7S8WwqxpKtCqDeFjnOuHlCMegteYhXDOfZIfUzD6D4X9fJ+DZHPD/lT/ChqRVto8EIJRDHKrAFdSfmy/J4akCz6tF2fKqc/Wf48hXFKE5vpPcwaSMvh/oHcNGTBhhvd5AsNyAKkcrf50Ek8QZV1QE+Z7UPCpboGpYH3CkRmocvAQX1fSfKpM5mgAF9VMJSfhSjBUeDJBC3/akEx3izg+n9S1+03/Wl+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4IxZ/9Jrj82AQ3quZ7ViP/Xjna5oChnCAh4o8nKu27w=;
 b=ZRnxwYjPIjJcd1RNfT4zhZwGSFgQBBRNVHcXSy2swChelwlNLYuL73c+I29cnr7eZTxr9/yMhwpeGcNBG6qcdB9w4OinxGfLrGXrFuujuqYfPgoOg+4u4J4K2pmeQHceo/r+1JBeI33hi8+kNAgMOovixOhRCoF1PD0iPxdb7AMhEC8QHR7KNjCJSQ/KmT8D0NdB4rvfIBhyoJ1PQXqrzs44GRhR63VSGCkriwepgwpXZCIGr0QhcYKEDg3GPDMbbk71NiU50SpmKN1a6rP0UKFbbjssvmfrCvvZ7lIHD95n9VBPzPKbCVX1bQns0L0GXWWQ7KFxP83fT4UBjAyW5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4IxZ/9Jrj82AQ3quZ7ViP/Xjna5oChnCAh4o8nKu27w=;
 b=PPtH3fkPuRN7mGjXgqTnV1nGPw1od4eMdQ9Xud+oPe5NKEgLfQ0azHUV+hkWw94BqVlxrPrhArc0ugEpBL9Rho8yMzEve68LwPPlQhKhaJeyAuZGeAXr8nrpgHUfSUP+ptPsi3f/wNAWwN/82ahNKkHjEu121N51uFktZl7paqCF+zY0EdlhUv+pY1cwWSRlHmsNG78s24YbTHKHq3O5aDXJQCHEjfWqITHglczOhQiXDkgLOWldgQoYwNUGt27fbc0ApZW8xuDL8nDK+AscFudnZEJdaUO1zeP4sKWqCm/HgC3MOlzbts4p/IYrS9oEDH2dqADLRUy0gOgyubnUmQ==
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16)
 by AS5PR04MB11466.eurprd04.prod.outlook.com (2603:10a6:20b:6c6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.11; Wed, 24 Dec
 2025 18:05:37 +0000
Received: from AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::8e4e:9bae:9fbd:cb52]) by AS1PR04MB9630.eurprd04.prod.outlook.com
 ([fe80::8e4e:9bae:9fbd:cb52%4]) with mapi id 15.20.9456.008; Wed, 24 Dec 2025
 18:05:37 +0000
From: Sarveshwar Bajaj <sarveshwar.bajaj@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Vinit
 Mehta <vinit.mehta@nxp.com>, Mahesh Talewad <mahesh.talewad@nxp.com>, Devyani
 Godbole <devyani.godbole@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] profiles/audio/bap.c: Fix
 heap-use-after-free in setup_free()
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] profiles/audio/bap.c: Fix
 heap-use-after-free in setup_free()
Thread-Index: AQHcdBNU3nPgF4+yMEStSH9FHS3MxrUvTCCAgAHHmDA=
Date: Wed, 24 Dec 2025 18:05:37 +0000
Message-ID:
 <AS1PR04MB9630CCF6B346BB2D652AD60A93B2A@AS1PR04MB9630.eurprd04.prod.outlook.com>
References: <20251223135134.706-1-sarveshwar.bajaj@nxp.com>
 <20251223135134.706-2-sarveshwar.bajaj@nxp.com>
 <CABBYNZKGSo5Uza6JoBXyCqQyi82WS4tQTBKOzpQ=HdOKu0Oa-A@mail.gmail.com>
In-Reply-To:
 <CABBYNZKGSo5Uza6JoBXyCqQyi82WS4tQTBKOzpQ=HdOKu0Oa-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS1PR04MB9630:EE_|AS5PR04MB11466:EE_
x-ms-office365-filtering-correlation-id: 074b0af8-aa64-4a53-4933-08de43170a95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?VUROSjJWc1FNeEJxRFVuNVZtVnNVTXZicFV6Wk92bFl3NVJIYTBrTjBLYWdR?=
 =?utf-8?B?bjZ6dW9CVkVEd0Q0R1JOV0pRT2Z2NEJ5MmswZGlkMnhGZ0hHVzVudkdTVXp1?=
 =?utf-8?B?dkRnZHg3SXBrWkVrd2Urai83bFp0WjkwQjhRUEtCM29WRlRZRzhEVXVwajZ3?=
 =?utf-8?B?T3FWeW5LaXp4R1dhV0gwMzU2QlRpSVozVWNlaS9ieS9HTDdNTFd2dDZyczFu?=
 =?utf-8?B?SEQ1N1V1NE1MS0pOcUc4RE95WFhpZDZMR3JZTkNadVlxQzIwbzAwY2lnRTF0?=
 =?utf-8?B?emlZRzZLandyWndoS2hjVEh0MUNUMFlqdGIrRzBLcVRXVCtmTTJqZ1hIbGQv?=
 =?utf-8?B?a2laaHFYY1Z2V1lXZXFsNDllN3A2M3dodDVYK1hCVW52emk2SUJpOXc4a1E0?=
 =?utf-8?B?SXJmQTYyVnQ0alFaekZVSzRkWDJwWUFqMEtMTFdPN3BlOEg4QVZnTGU3S3ZE?=
 =?utf-8?B?QWo0TWFrL1lOM1FyY2dZamJta0F4dElSTVhIbWxxWTdQTXhweG1FbWlBNlZK?=
 =?utf-8?B?YlEzMU5iMFg5VUZrelNYblZzUERsMlY4eWJxZ3dRZDR3MVllL1Q0cUpMWDRE?=
 =?utf-8?B?dXhwWWFPSkxIbXlMR0ZLQTYzQnYvTlBRdUd0cmtQZDRTWXlqM2ZxK0pYbEVY?=
 =?utf-8?B?Z2NSR2JudUdRNzl2dmdQdDZTUDlEclRSTVA4UXowa3J6UEVxdlBoY2N4QW9x?=
 =?utf-8?B?ZjZRMzJZYU5MV0RZbUprZFF5dkdFdTNnWVhMMFB5NU9iMWdaZTFNdmJhcDNI?=
 =?utf-8?B?d3JBUVJzSXpFTkxvYWhsZ2hVTnpkb2g3b1NoRFA4Qkw0WnZsZzBUWGZ3dWU0?=
 =?utf-8?B?Rm4wQmM5OU9VQTFNQVljNW1FSTNwYzFvNURheEc0cTkrZDZRM2pJNXo3RTdF?=
 =?utf-8?B?TVEvM0FSeHpURlR6ME9EZEFlTE1lNHdTNVEvNk5EbU1mRlMrUDJaaWhsUGN4?=
 =?utf-8?B?MW9oeUNSd1dkUis5KzZMVzc2K0EvUGdUSjJadGMyRHpLZGZBMnZNQWlTdnIx?=
 =?utf-8?B?T2lMNVVSM084a0lITE00NnNyWHZJakhNRjlVeldWSWs3aWpITFNPR3diMzVV?=
 =?utf-8?B?YXN3ZmltMTlEc1R1SnE1dm1DbDJYcHhTZGQrWCtQVzUyMVd0MS9rWXpXWG01?=
 =?utf-8?B?MFdpOHJ1UjNqdjc3RVFHOEs2cGNEU0pVVHptN0VTVi9BUEYrZG5uS2oyWUlI?=
 =?utf-8?B?Ym45MHNuekhzTDlOYU0wYzJRT3RHUk8xc3JoSXV3MUFjTDRqbGFmTEhtZTIz?=
 =?utf-8?B?ODRjd3pTR0h1d1piWDExeUNYOEFwYUExcGxFRE1sZ1pMYWQrZDJ5eVBMc0p5?=
 =?utf-8?B?MVlNNDdnYjNQeXhub0FBd3JDK21CNTB2VFBEQVdZSG5tdnZyUHNjcVlnUUdZ?=
 =?utf-8?B?TktXUkJhekNhUkNqVVhNNVlURCtyNnAyc2tDRVJBK0dXNXMxRlp1eWcwcEp1?=
 =?utf-8?B?b1FPR1BZb0hMWUN2M21aWXVLZVhhSnpqQ1F2RU9VQUtKNU5JVkt4aDlYaEhs?=
 =?utf-8?B?Y1dYc2JWNnA1TXltM2VTdFdMOCtlQ1NEakZNallvSktxNnBYWFMya3BZVGVJ?=
 =?utf-8?B?T3A2TGtUVW0zdTY0S0hKN0ZoZmZYdlNaVDFONk9zMWlEbTN3MnFuZG1UMk02?=
 =?utf-8?B?bkpMNHRhUmRJV1NvQkVjS3Y2a1h6bFV4alJFTG5PTVBhN2QyTmQveXhrRlFQ?=
 =?utf-8?B?NFU1eVprMHhaWk16MjlyNkRZOVJiNklIcXZKUnNVSmErNEluZVpQODB6TU9D?=
 =?utf-8?B?dnQvRzdNVldxVmlYNFpzTWlmSit2SzcydVVPVkZHWVRqK0NiOWdobnNaVzVK?=
 =?utf-8?B?UVNOcHQvMTc4a1NQUDZWYmtMTkx3NFBLakNzY3pxdHBnWWluUnZZcm1scU1I?=
 =?utf-8?B?SGVyMlBUN3VwSE5VVVhhdW1FSUpObTZ3eTlCalp6U3U4Y0d3R0ZxMU5EekQr?=
 =?utf-8?B?R0RvU1I0Ull5dm1zQ21ubG1KVE5iQXg1citLWTVwcWQ0Mnk4eEdDMDhCcXFo?=
 =?utf-8?B?L0lJWXAzUEU3VXkzbThLUFRzcVduWlBvQndYQU1nb2l3Z09kV3FkQXpFY25w?=
 =?utf-8?Q?kz/DWu?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR04MB9630.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?emI2OXNRRTVDNW8wRFFaWjZ3bnd2TG9BMlZoMW5WZ0ZGSDVrTk5VTEh1WDU2?=
 =?utf-8?B?SUR2djV6UmlTVEM3MGJJdCtmM1Z6SDBaWHlUTVh3WTdlWG5mMllWKzJJYnlR?=
 =?utf-8?B?MnQxdURqelpGRzZ4OUlveEhKU0NveVFlZXNYMnNOZjV0SFpKNXp3WnNiMThQ?=
 =?utf-8?B?bTNpVWo2YWM4aEt1aXRQaisrN0JwSDV6VlUyVUp1aUVYUkxMMVFyZlFnVzY3?=
 =?utf-8?B?QVZGQ2Y4Q2hIVzRTa1lseUptRmxaSGx5a1lPU3dtUUFDN0dZaVpZTXBjL1FZ?=
 =?utf-8?B?VE9LRWEwVlBVSnFoR2lUU29jSEUrMVBtYzlvY0xnZVJ1SE1QcVNJYUwzdVps?=
 =?utf-8?B?dUZ4cm4vS3lSQmtBaURYeDNHOHkrUXgzVkNJdFp0bzY3aHRaOURlanNVY1lw?=
 =?utf-8?B?eWNabHkxZzd0S3dNeVRiUDl1alVPMnd5Z3RsOGYvYzExbStZKzlHYXV4MERT?=
 =?utf-8?B?VGV5UERGZEJxQUFXTGNFWi9GcHFGU2hVV1VyMXgzMUZsTU5jWWk5V1Noc09X?=
 =?utf-8?B?aWQ3SUIrOTRyWHJiZWFiR1Z6MkhkZVNpNDQwOFNOV1dyMStrRDh0ZGZ1T1Qy?=
 =?utf-8?B?WTZ6am4zSUVWK2t4WHpiVTdETWpHTUJnTjk2Y3NRbTk4dmtwZm1lM0tYRnJz?=
 =?utf-8?B?VUg0TkZ5QzFJeVpFL212bWk1VCsxUUxqa1N5Y1pCWTUwWE9PQWdYRHBmVGp5?=
 =?utf-8?B?WEVhT212Q1Z0djMxWlVKSTNHbExrdFdYMTZSTE8zdzlUaUlUa0xwK2tiOUtZ?=
 =?utf-8?B?RmRyV1FITS9DYThuSnJlYnRHTlNEZkRYSlYxRG1ibUEzbGUxbkI2b1BCVWcr?=
 =?utf-8?B?SGNUWVFpejFuTHBrVHBxWWdjSjhHUEJsTEg4dUdncVkwRWZaN29Na2JSckk4?=
 =?utf-8?B?UXl4a0k0RDNOVWRHTGFuNFgvVU9yRXdTRmxORytzbENFdHY2Sno3bmFDWHRU?=
 =?utf-8?B?K240L2V5K0o1aFN4cEh2U0YzOXZpQ3lMRG1nTkZKV2dOUGwyWXpnblBKNHlS?=
 =?utf-8?B?RkdZYVY1ZmdaMVRwUXU2ZVROK0M4VTFLZ083RStRdlZ3T3VuMzV3ejVNYUNO?=
 =?utf-8?B?T2QxaG1ENlRrQ3hLNzhsL0htSGtPQWJpZEdKc0FhZjdpaU5ia1A3VWFtVjBW?=
 =?utf-8?B?ZU5XRGRHUzVkVmpSZmM2cVYwOFFqd0RPUE9nWkV3c2lyM3l5YWFLUUpDSWtB?=
 =?utf-8?B?QXpuK05GSE03QlJiV1FHUmRhZ1NvcDZHSzNTU0Y3KzkzSGgvT0hWYnl4WTM2?=
 =?utf-8?B?WGFGMW80Q3V3Tmlkc2RtMEkzalBveThLWFdUTk1aTmVySGlycnBFcWRYTFFB?=
 =?utf-8?B?a2RLcGtJSG9uSzNuUUJWZ2t6aWNyM3JmOWhPWDM2MXB0eXJqNkhPeVlRTUsy?=
 =?utf-8?B?LzhHVkhGK2Q5RXhBdk94Q29hdnlhRVc4MHd3UFUvSm5XbTZxaDM0c2tPazJl?=
 =?utf-8?B?blZlaERtOW9veGFGYkdGaTRpc252a1Z5VGN4N2oxTXUxb2h6ZWJnZzQvWkpp?=
 =?utf-8?B?TnBSUmdmRVQ5Z0NBRnBYcTZuRkRmUmg0bUozOHBWZ2dwNVE3VW80U1FSVlUw?=
 =?utf-8?B?aHBhU2VqeXVBNGUvU0pSTUhVR3dJSDhCbzc2STNFWUY3WnhmVVJzYWt3cXJP?=
 =?utf-8?B?bnRxT3ZBZ2tGRncybDJtK0VSdUhpSFFQeDRuSllEVmhOaXNaWmg2V1oxSGpJ?=
 =?utf-8?B?cEE4S1YzUTFENS91ZVFWN1NzTGhiblpsKzN2elVSajhJQTF3YUlFM0hycDJj?=
 =?utf-8?B?L2tPYTVQYXR6L2E4Z2FkMFBjRHhjL1V5ZE9jQ0hORlUraEdMSVc0USswc0xm?=
 =?utf-8?B?ZG04d3d6dU5sYU9NYngvWkdDWm9MTWFvUVdkZ0dwM3dmSEZyby9uS2p2Y2NC?=
 =?utf-8?B?dURBYzFLS040b2ZHMXU5MldxcnJkNGNaeEpqb1k0K3N5KzN4YzdtSFgrVFJC?=
 =?utf-8?B?ZmUvd1JkZGx0MzQ3MC96dHQ2dDA5bjlrYk5TYTFUdTNBQkt1cU5vWXhibzFJ?=
 =?utf-8?B?bUlMT3ZHTmpZcFIzb252eWVpS1RBVnNTMmVpT2NVOGNtVTY1L1E1WmJmLzdS?=
 =?utf-8?B?bXIxd3FEd2t5Lzh2NFFLOUhTQ2FaamIycHJTM1g4LzkrUjE3RVIyaGdnK0pW?=
 =?utf-8?B?d2YybWQ1eW1OQms0aUtBd1p1SjA2UFM3UXVEQVo3dHFOT3ZSRXpvMWhJTEV1?=
 =?utf-8?B?MjVMN1Awc1dURXkyVjQ2dFEvU0duK3A5TW1LOGZ2Qks4dXFqTEZUdDhPSFlo?=
 =?utf-8?B?WnF0NEdDcWRhbjVEK1RVQTlJMW9nT1hCT1E3MUlteTFXanBBZFVVZ3lIVXhp?=
 =?utf-8?B?Zml6c0NqKzdIR0Rvb2d4R0g5MnhtajVIejdWd3Z1djRCSEV5L3VZQT09?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9630.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 074b0af8-aa64-4a53-4933-08de43170a95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2025 18:05:37.3234
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fksD71QgzHAUkoqvNuwL567yXjd4sf+z9D+Ue+op5Px/nqE5V1PjdYaEnF7wkmO5SDJaWOWz8CXwC4orMoT98aJ4bagzQJYGZ5MEApdAJPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB11466

SGkgTHVpeiwNCg0KSSByYW4gdGVzdCB1c2luZyBCbHVleiBUb1QgbWFzdGVyIGJyYW5jaChjb21t
aXQjMDU4MTNkZjVlKSB3aXRoIGtlcm5lbCB2ZXJzaW9uIDYuMTguMg0KSGFzIHRoaXMgaXNzdWUg
YmVlbiByZXNvbHZlZCBpbiB0aGUgbGF0ZXN0IGtlcm5lbCBzZXJpZXMgKDYuMTkpPyBJZiBzbywg
Y291bGQgeW91IHByb3ZpZGUgZGV0YWlscyBvbiB0aGUgbGlrZWx5IGZpeD8NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEx1aXogQXVndXN0byB2b24gRGVudHogPGx1aXouZGVu
dHpAZ21haWwuY29tPiANClNlbnQ6IDIzIERlY2VtYmVyIDIwMjUgMjA6MTENClRvOiBTYXJ2ZXNo
d2FyIEJhamFqIDxzYXJ2ZXNod2FyLmJhamFqQG54cC5jb20+DQpDYzogbGludXgtYmx1ZXRvb3Ro
QHZnZXIua2VybmVsLm9yZzsgVmluaXQgTWVodGEgPHZpbml0Lm1laHRhQG54cC5jb20+OyBNYWhl
c2ggVGFsZXdhZCA8bWFoZXNoLnRhbGV3YWRAbnhwLmNvbT47IERldnlhbmkgR29kYm9sZSA8ZGV2
eWFuaS5nb2Rib2xlQG54cC5jb20+DQpTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIEJsdWVaIHYx
IDEvMV0gcHJvZmlsZXMvYXVkaW8vYmFwLmM6IEZpeCBoZWFwLXVzZS1hZnRlci1mcmVlIGluIHNl
dHVwX2ZyZWUoKQ0KDQpDYXV0aW9uOiBUaGlzIGlzIGFuIGV4dGVybmFsIGVtYWlsLiBQbGVhc2Ug
dGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBhdHRhY2htZW50cy4gV2hl
biBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdlIHVzaW5nIHRoZSAnUmVwb3J0IHRoaXMgZW1h
aWwnIGJ1dHRvbg0KDQoNCkhpIFNhcnZlc2h3YXIsDQoNCk9uIFR1ZSwgRGVjIDIzLCAyMDI1IGF0
IDg6NTLigK9BTSBTYXJ2ZXNod2FyIEJhamFqIDxzYXJ2ZXNod2FyLmJhamFqQG54cC5jb20+IHdy
b3RlOg0KPg0KPiBGaXggY3Jhc2ggd2hlbiByZW1vdmluZyBvciBkaXNjb25uZWN0aW5nIGEgZGV2
aWNlIHdpdGggYWN0aXZlIA0KPiBicm9hZGNhc3Qgc3RyZWFtcy4gQWRkcmVzc1Nhbml0aXplciBy
ZXBvcnRzIGEgaGVhcC11c2UtYWZ0ZXItZnJlZSBpbg0KPiBidF9iYXBfc3RyZWFtX2dldF9zdGF0
ZSgpIGNhbGxlZCBmcm9tIHJlbGVhc2Vfc3RyZWFtKCkgZHVyaW5nIA0KPiBzZXR1cF9mcmVlKCku
DQo+DQo+IERldGFjaCBmcmVlcyBCSVMgc3RyZWFtcyBkdXJpbmcgdGVhcmRvd24sIGJ1dCBzZXR1
cF9mcmVlKCkgc3RpbGwgDQo+IHVubG9ja3MgYW5kIHJlbGVhc2VzIHNldHVwLT5zdHJlYW0gYWZ0
ZXJ3YXJkcywgbGVhdmluZyBhIHN0YWxlIHBvaW50ZXIgDQo+IGFuZCB0cmlnZ2VyaW5nIFVBRi4g
VGhpcyBjYW4gaGFwcGVuIHdpdGggbXVsdGlwbGUgQklTIHN0cmVhbXMgc2luY2UgDQo+IGVhY2gg
c2V0dXAgaG9sZHMgaXRzIG93biBpbnZhbGlkIHJlZmVyZW5jZS4NCj4NCj4gRml4IGJ5IHNraXBw
aW5nIHVubG9jay9yZWxlYXNlIGluIHNldHVwX2ZyZWUoKSBhbmQgY2xlYXJpbmcNCj4gc2V0dXAt
PnN0cmVhbSB0byBwcmV2ZW50IGZ1cnRoZXIgYWNjZXNzLg0KPg0KPiBMb2c6DQo+IEVSUk9SOiBB
ZGRyZXNzU2FuaXRpemVyOiBoZWFwLXVzZS1hZnRlci1mcmVlIG9uIGFkZHJlc3MNCj4gMHg3YzQz
YTQzZTM0NTggYXQgcGMgMHg1NzI0MTVhODYwM2QgYnAgMHg3ZmZjZGVmOWI4NzAgc3AgDQo+IDB4
N2ZmY2RlZjliODYwIFJFQUQgb2Ygc2l6ZSA4IGF0IDB4N2M0M2E0M2UzNDU4IHRocmVhZCBUMA0K
PiAgICAgIzAgMHg1NzI0MTVhODYwM2MgaW4gYnRfYmFwX3N0cmVhbV9nZXRfc3RhdGUgc3JjL3No
YXJlZC9iYXAuYzo2Mzg2DQo+ICAgICAjMSAweDU3MjQxNThmOWQwYSBpbiByZWxlYXNlX3N0cmVh
bSBwcm9maWxlcy9hdWRpby9iYXAuYzo5NTENCj4gICAgICMyIDB4NTcyNDE1OGZhMTBlIGluIHNl
dHVwX2ZyZWUgcHJvZmlsZXMvYXVkaW8vYmFwLmM6MTEyMQ0KPiAgICAgIzMgMHg1NzI0MTVhMjkz
YzEgaW4gcXVldWVfcmVtb3ZlX2FsbCBzcmMvc2hhcmVkL3F1ZXVlLmM6MzQxDQo+ICAgICAjNCAw
eDU3MjQxNWEyOTQ0MCBpbiBxdWV1ZV9kZXN0cm95IHNyYy9zaGFyZWQvcXVldWUuYzo2MA0KPiAg
ICAgIzUgMHg1NzI0MTU4Zjk0NjQgaW4gYmFwX2RhdGFfZnJlZSBwcm9maWxlcy9hdWRpby9iYXAu
YzoxOTINCj4gICAgICM2IDB4NTcyNDE1OGY5NDY0IGluIGJhcF9kYXRhX3JlbW92ZSBwcm9maWxl
cy9hdWRpby9iYXAuYzoyMTENCj4gICAgICM3IDB4NTcyNDE1OTA0MGU0IGluIGJhcF9iY2FzdF9y
ZW1vdmUgcHJvZmlsZXMvYXVkaW8vYmFwLmM6MzgyMQ0KPiAgICAgIzggMHg1NzI0MTU5YTdlYjkg
aW4gc2VydmljZV9yZW1vdmUgc3JjL3NlcnZpY2UuYzoyMzkNCj4gICAgICM5IDB4NTcyNDE1OWNm
YTQ5IGluIGRldmljZV9yZW1vdmUgc3JjL2RldmljZS5jOjU0ODkNCj4gICAgICMxMCAweDU3MjQx
NTk5OTg4OSBpbiBidGRfYWRhcHRlcl9yZW1vdmVfZGV2aWNlIHNyYy9hZGFwdGVyLmM6MTQ1OA0K
PiAgICAgIzExIDB4NTcyNDE1OWI5OWM3IGluIGRldmljZV9kaXNhcHBlYXJlZCBzcmMvZGV2aWNl
LmM6Mzg1NA0KDQpIbW0sIEkgdGhvdWdodCB3ZSBmaXggdGhlIGRldmljZSBiZWluZyB0ZW1wb3Jh
cnkgd2l0aCBicm9hZGNhc3QsIGlmIHRoZXJlIGlzIGEgYnJvYWRjYXN0IHN0cmVhbSB0aGVuIHRo
ZSBkZXZpY2Ugc2hhbGwgYmUgbWFya2VkIGFzIGNvbm5lY3RlZCBzbyBpdCB3b3VsZG4ndCB0cmln
Z2VyIHRoZSBzZXF1ZW5jZSBhYm92ZS4gUGVyaGFwcyB5b3UgZW5jb3VudGVyIHRoaXMgd2l0aCBh
biBvbGQgdmVyc2lvbj8gT3IgbWF5YmUgaXQgaXMgdGhlIGtlcm5lbCB0aGF0IGlzIG9sZC4NCg0K
PiAgICAgIzEyIDB4NTcyNDE1YWJjZWE1IGluIHRpbWVvdXRfY2FsbGJhY2sgc3JjL3NoYXJlZC90
aW1lb3V0LWdsaWIuYzoyNQ0KPiAgICAgIzEzIDB4N2Y2M2E1OGY5MzI5ICgvbGliL3g4Nl82NC1s
aW51eC1nbnUvbGliZ2xpYi0yLjAuc28uMCsweDY4MzI5KQ0KPiAgICAgIzE0IDB4N2Y2M2E1OGY3
ZGUxICgvbGliL3g4Nl82NC1saW51eC1nbnUvbGliZ2xpYi0yLjAuc28uMCsweDY2ZGUxKQ0KPiAg
ICAgIzE1IDB4N2Y2M2E1OTY5MWY3ICgvbGliL3g4Nl82NC1saW51eC1nbnUvbGliZ2xpYi0yLjAu
c28uMCsweGQ4MWY3KQ0KPiAgICAgIzE2IDB4N2Y2M2E1OGY5MTU2IGluIGdfbWFpbl9sb29wX3J1
bg0KPiAgICAgICAgICgvbGliL3g4Nl82NC1saW51eC1nbnUvbGliZ2xpYi0yLjAuc28uMCsweDY4
MTU2KQ0KPiAgICAgIzE3IDB4NTcyNDE1YWJkMThkIGluIG1haW5sb29wX3J1biBzcmMvc2hhcmVk
L21haW5sb29wLWdsaWIuYzo2NQ0KPiAgICAgIzE4IDB4NTcyNDE1YWJkOWM0IGluIG1haW5sb29w
X3J1bl93aXRoX3NpZ25hbA0KPiAgICAgICAgIHNyYy9zaGFyZWQvbWFpbmxvb3Atbm90aWZ5LmM6
MTk2DQo+ICAgICAjMTkgMHg1NzI0MTU5ZWEzNzggaW4gbWFpbiBzcmMvbWFpbi5jOjE1NTANCj4g
ICAgICMyMCAweDdmNjNhNTYyYTU3NyBpbiBfX2xpYmNfc3RhcnRfY2FsbF9tYWluDQo+ICAgICAg
ICAgLi4vc3lzZGVwcy9ucHRsL2xpYmNfc3RhcnRfY2FsbF9tYWluLmg6NTgNCj4gICAgICMyMSAw
eDdmNjNhNTYyYTYzYSBpbiBfX2xpYmNfc3RhcnRfbWFpbl9pbXBsIC4uL2NzdS9saWJjLXN0YXJ0
LmM6MzYwDQo+ICAgICAjMjIgMHg1NzI0MTU4N2Q0NjQgaW4gX3N0YXJ0DQo+ICAgICAgICAgKC9o
b21lL3dvcmtzcGFjZS9ibHVlei9zcmMvYmx1ZXRvb3RoZCsweDEwNjQ2NCkNCj4gMHg3YzQzYTQz
ZTM0NTggaXMgbG9jYXRlZCAxMjAgYnl0ZXMgaW5zaWRlIG9mIDE2MC1ieXRlIHJlZ2lvbg0KPiBb
MHg3YzQzYTQzZTMzZTAsMHg3YzQzYTQzZTM0ODApDQo+IGZyZWVkIGJ5IHRocmVhZCBUMCBoZXJl
Og0KPiAgICAgIzAgMHg3ZjYzYTViMjEyYWIgaW4gZnJlZQ0KPiAgICAgICAgIC4uLy4uLy4uLy4u
L3NyYy9saWJzYW5pdGl6ZXIvYXNhbi9hc2FuX21hbGxvY19saW51eC5jcHA6NTENCj4gICAgICMx
IDB4NTcyNDE1YTcxMGY0IGluIGJhcF9zdHJlYW1fZnJlZSBzcmMvc2hhcmVkL2JhcC5jOjEyNTQN
Cj4gICAgICMyIDB4NTcyNDE1YTcxMGY0IGluIGJ0X2JhcF9zdHJlYW1fdW5yZWYgc3JjL3NoYXJl
ZC9iYXAuYzoxMzM3DQo+IC0tLQ0KPiAgcHJvZmlsZXMvYXVkaW8vYmFwLmMgfCA3ICstLS0tLS0N
Cj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgNiBkZWxldGlvbnMoLSkNCj4NCj4g
ZGlmZiAtLWdpdCBhL3Byb2ZpbGVzL2F1ZGlvL2JhcC5jIGIvcHJvZmlsZXMvYXVkaW8vYmFwLmMg
aW5kZXggDQo+IGNkYTEwYTY0My4uZjMwMjYyOTg3IDEwMDY0NA0KPiAtLS0gYS9wcm9maWxlcy9h
dWRpby9iYXAuYw0KPiArKysgYi9wcm9maWxlcy9hdWRpby9iYXAuYw0KPiBAQCAtMTExMywxMiAr
MTExMyw3IEBAIHN0YXRpYyB2b2lkIHNldHVwX2ZyZWUodm9pZCAqZGF0YSkNCj4gICAgICAgICBp
ZiAoc2V0dXAtPmRlc3Ryb3kpDQo+ICAgICAgICAgICAgICAgICBzZXR1cC0+ZGVzdHJveShzZXR1
cCk7DQo+DQo+IC0gICAgICAgYnRfYmFwX3N0cmVhbV91bmxvY2soc2V0dXAtPnN0cmVhbSk7DQo+
IC0NCj4gLSAgICAgICBpZiAoIWNsb3NpbmcpIHsNCj4gLSAgICAgICAgICAgICAgIC8qIFJlbGVh
c2UgaWYgbm90IGFscmVhZHkgZG9uZSAqLw0KPiAtICAgICAgICAgICAgICAgcmVsZWFzZV9zdHJl
YW0oc2V0dXAtPnN0cmVhbSk7DQo+IC0gICAgICAgfQ0KPiArICAgICAgIHNldHVwLT5zdHJlYW0g
PSBOVUxMOw0KPg0KPiAgICAgICAgIGlmIChzZXR1cC0+ZXApDQo+ICAgICAgICAgICAgICAgICBi
YXBfdXBkYXRlX2NpZ3Moc2V0dXAtPmVwLT5kYXRhKTsNCj4gLS0NCj4gMi40OC4xDQo+DQoNCg0K
LS0NCkx1aXogQXVndXN0byB2b24gRGVudHoNCg==
