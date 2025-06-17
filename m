Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010014.outbound.protection.outlook.com [52.101.84.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0705E295D85;
	Tue, 17 Jun 2025 09:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750154168; cv=fail; b=BTmKOjAkfm6w3JmGsX/GlnuLiWk09DOZALrvDFyA/FqZ5iFRjJlOaLfJkLkx+/ZQrcakNROFy3n6vJk6PL/N/3RnHqw0VbiwYvYa8t9Ccb3HApzIAn40MH/RcTA+jwyymbF8s3oeKFksflH468CP2IuP+QCTN9utyi/iLgM+uBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750154168; c=relaxed/simple;
	bh=EbW8/CNOw2VRC3dE9zU1rYb7nPj9t0izel3skuz+TaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s87+Loom2xCNmyt1fOw6l6lzN4qfPjKXuVOoLXPPU3bSaxMTWyq4FPPNOyQMWpHglrpJ2yN8J8Q8nMCEkddRrUes5BsMYZ83pYBERRo17a3Cq6/c931c/UD59IMYdZM0fcNqZQyatk6bjWBghKdAxnW1zIpOsDLC9YvIKLIsQ5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E0wIW/Ad; arc=fail smtp.client-ip=52.101.84.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E0wIW/Ad"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZ1Ypfr6UPq9f88i0NslMwBt5rMvkpqmjHZNiKBkYdLP/WOrM++9TluElav+KUcw5hjcBTzzVYAroVxsB7zz9/iJJG2Y1feSvvesGbyEcyamM5qCAIkDPO+0IRdqmAlybsYcOYi617tc3auIxUxRKKKXKuMkW2XE+8DzVHgsf8jytPXb7n+6yQT+P2eL7d6/36C/ADB2eUJsD5/czoZixag+Wqo/aisggnbA2nXTJlZDk2gEpNg0EOvan5mcFrV1+PVymUZyfaoN8Zz4pVA7mCQHQDpmynLvYDxUfnnE2D/7AjcQd75/bGGVNmva2ONAWPJjd4H+EToaMX7Y7VrDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbW8/CNOw2VRC3dE9zU1rYb7nPj9t0izel3skuz+TaE=;
 b=Wkij/frRV7gSf5MkYcL60QwkG3Fayp0l1TWTPkgA3P7ZptpS7EL+2CuH8oTSMHX9MK2Ds1LE1Q7ErxwDPbyulT6cU3qHfdGBw+goOYvpm/tnFB5gXN7MmX0qs5Gl9cDTZsEkblCxEPrNF6XsqY3GSpE9wB/aw+vtveSa6wUmCDe88b32DH/wdicezW/HgOKCM93ZPAFSelo4+7oEIbCs+5sye0g8p1k+i31BM6qbH2eh2Zc2120dyTiPffe7rg/eqf+A4X3DrcZ1JFCv8tvzOpWEk1D6Ld/NsJ2VQ/Bd8CsG/Vip8BqjMprUHlB37VT9QI2THKPTGmRWEsjEmr7qzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbW8/CNOw2VRC3dE9zU1rYb7nPj9t0izel3skuz+TaE=;
 b=E0wIW/Ado99qCyTSscbCxie9HF/u49NOKjl2v+YR+rotnr2rSsasR3K3vxLmPyChb/jBzfLPpbqwkXfn2UhkNllSXw0HdPMoN8WPieg49CcSpzrY9nMqAKKecPxOoAl0Ww3bbMstC7lD1a4epUJWtkEmZZ3+jwNgDxOQ8AESIvM1ZDpC6V3OhZzkkNAtT3IJ1Z5DLHkQJBcldLPVPgwjYd5KZU2+n6WX7m5l9CXhzP7lSg/w9kpiCBdsSBcCxG902zRhKP1z6rbOdwv4nRuiDaNNQcdNMhwrTUGv5MCOmeFy4hjc9oglcy7drEFZymcZL4Y4VN5vTWqbLzmXhjjCVA==
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com (2603:10a6:20b:4fe::20)
 by GV1PR04MB10477.eurprd04.prod.outlook.com (2603:10a6:150:1cb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 09:56:02 +0000
Received: from AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299]) by AS4PR04MB9692.eurprd04.prod.outlook.com
 ([fe80::a2bf:4199:6415:f299%5]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 09:56:02 +0000
From: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "marcel@holtmann.org"
	<marcel@holtmann.org>, "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Amitkumar Karwar
	<amitkumar.karwar@nxp.com>, Sherry Sun <sherry.sun@nxp.com>, Manjeet Gupta
	<manjeet.gupta@nxp.com>
Subject: RE: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Thread-Topic: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Thread-Index: AQHb322SN2g+bQpZlE+DeI96xWdma7QHHTSw
Date: Tue, 17 Jun 2025 09:56:02 +0000
Message-ID:
 <AS4PR04MB96929C2A48B10D8C7FAF282BE773A@AS4PR04MB9692.eurprd04.prod.outlook.com>
References: <20250616150919.8821-1-neeraj.sanjaykale@nxp.com>
 <e15f4d39-379d-436f-b401-36f5b3f6f010@kernel.org>
 <AS4PR04MB9692790DAB0B376EA0F6B279E773A@AS4PR04MB9692.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS4PR04MB9692790DAB0B376EA0F6B279E773A@AS4PR04MB9692.eurprd04.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9692:EE_|GV1PR04MB10477:EE_
x-ms-office365-filtering-correlation-id: ba49598c-44d0-4a2b-005a-08ddad852b42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UG9rRmpUWDd5MGhrWENaM2o4TE9yTWI0Y25ndWdsTkE2QThKRVFyckgzNG15?=
 =?utf-8?B?VHN2VkxqM25MZitHWXhLSWRkc0Vlc2VHMXMxcEZGK0p1UHYyOHJ2S0VWclJE?=
 =?utf-8?B?eTgxNzZabUpabVI5aXVEdmdsZHhPRlVxNHdWS3BneXVFWEpGS0RhQXVEc2Ux?=
 =?utf-8?B?T0RzblU2NzBMQnhDRGpqeUZtbDFTOFhMSFNHckJwYzVWUzVCR3B2SUh5ZVV6?=
 =?utf-8?B?dDZ3L3RuZWhpZW9NZkhsUU1wZ2FsYnZXMnFjSmJMZytoVHlUcHlJaVJXdmNW?=
 =?utf-8?B?R3N6VDh1Nis2cTBjb2VqVklZbnhlR3l4M0hiRVU3NWoxRnpmeTRiYTdDY0hN?=
 =?utf-8?B?bEsxaXA1ck10OVNxem9MOTlCUUdvdFplSlpnU3h2VXMwY1NWZm9TYmNVWkZm?=
 =?utf-8?B?eVFyUk8rdW5mSjFpVU5LVjdkWE1BRzZFZXNMWGxNOFM4ZjVkaHczU3IvTVdP?=
 =?utf-8?B?bitMS2V4SHhsZW9QNnRvL3ZVWS8veS9aTGZUeXp5R2xmajB4UlNKaS9NNUtW?=
 =?utf-8?B?THJMNUUyTnQxUG9vVDBIcFg5RDN6QStEM2dYZkJSZ2FiRE91N1dGSXJZUUxF?=
 =?utf-8?B?emVmeU42MzR4M0hQYXpRQzgwdEVMQXVPbXdweVY0S29IKzBkMC9neStpOFBZ?=
 =?utf-8?B?STRNdEQrT2Z0bTltZVRWRXpNbmg1allMNm1LVWFqVm1oS1B5dW1TZkFVd20w?=
 =?utf-8?B?RUdncmYrOC96QjJXMTVGZWZ2ZVg3WlRGQ2VBVjBqL1dtY3pGWndmRys4Rm9m?=
 =?utf-8?B?NWZKQ1EwZE4vaFdWUmFMTXdOeXNIUmZ5K3BWYmkrQUdGbVdzSERGM2JtR2Z0?=
 =?utf-8?B?aUh3dGlzY3BZMTZjckhRK3Y3MHlOUVNGUlMrNmMwREthY1pDMGRYK0doRTJF?=
 =?utf-8?B?WDJVcmFERXdrQUVuQ1JIMW9UdzlrM01NaWJJL1hFbDBMWW82TDg4cGdiRG5i?=
 =?utf-8?B?Z2VHVHAxVUZja0N0Y3pseVRjbnVtQ1drOGVRTzlVRE5KL3lZU2E1V3A3dmxL?=
 =?utf-8?B?L1dDczM3UURzMjQxd1BLdFlBeGtvdW5Bb0pWYWU5WVVhRlFNUTFiVElHWmdT?=
 =?utf-8?B?bng1eDdOMEd1eGNoR0JBdHBmaVZiVjc1QlBWSzB1a240c29Wejhma1diTkpt?=
 =?utf-8?B?RXJyMXRRM0t3a0cyZ1dUZkcyVndhVVVXZlM5Rm51VzQ2ZEJUY093V2xQeFY1?=
 =?utf-8?B?NkZKVjluZ3JvWUlGZUpZOVRzOUxGZmoweXNaYlJLY3dWSi9oM0VnOFBwK2FL?=
 =?utf-8?B?b29DNlhQSXEvZXBSYzdCZFVoM0RvUktrSlYvbzlkTFVxYVFEb1piK1dhMDJr?=
 =?utf-8?B?UjRudlp2SEZwbE12ZkwwMmhOV2pSaWNGb2hhNWlWWXNLUzFCTTBhNFhWSk9s?=
 =?utf-8?B?MmcvVCtVSE9WNW5nWW5vZmZxYnV2WVREam5hU2l5dWtLQnVVNmZjQkxmOGts?=
 =?utf-8?B?MktZejJrTXJ6VUFsbnRkaVlkTFpRaUwrTXNOWHFCQm5FOTJCVHZkMFp5ZzY1?=
 =?utf-8?B?d2Q4Y3NrY3ZuTFRad1BNNEFHdCsxUVNPd1dJWG5FRVphL2N2Vlp4eUt3V1ZM?=
 =?utf-8?B?K0syRThuZCtNYTV2QndDTmlWeFNjcnhOSVJoNUM4VVBCN2VLS1ZYUDdveWI0?=
 =?utf-8?B?aThYSGdpbmF1cUkyaThaRHJQcVNpNm1VcFFyUGhsMXZucWJKTGVUN3o4ZGRO?=
 =?utf-8?B?eUJpbnd4RlVZWE1TVDlkZkJmSEtxMkgybHdJWmRZWUJhcWlra3g0eHpjeGlQ?=
 =?utf-8?B?azF5azFNekVsQWx3VWhSdlg5MGQydHpFY2dEOVBoMWhiVWFkVG9URDJXMm9t?=
 =?utf-8?B?ZGw3NytZNDQ5bndpTEphdWVqZzNoemdOczhtWWZOZDhMRmt5QllTaWxQakFW?=
 =?utf-8?B?K0tEcVNvdWNkTEJwbnRGbUJ3THZnNmI4Z0JKdGNMVUkvUFlTby8zaXlHM1hZ?=
 =?utf-8?B?RjkzNkZBRjhvNjUwUEx6VSs4Y1ZIc1ZOYytFai9kaXJ5NlhCZ3pqL0FxL21T?=
 =?utf-8?B?QTBNbWhqMG9nPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9692.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MG0wSUxwM20rSmR6L0lubTl4U2J1YVFoeTZwV0c0Uyt5Tm93WXVkRnlMbFRW?=
 =?utf-8?B?ZzlnSmJ6eUpIRkdKdnhONEkxTUZkOHZEWGV2YklWWSsrNW93dFVSZkJBMERO?=
 =?utf-8?B?M1pkVmlhNUZlanA5d3NBTTlIY21lODU5dGNQOWdObGJSZGJPMFpBNURmamcz?=
 =?utf-8?B?eHBhZjBQb25ieWdZNlNjZ1BoL002TzVBUTRxWGdoWXRsRzcveXJSWWl0VGpz?=
 =?utf-8?B?ZTlGazMwNVpudnhZTHV4bE5BM000WTNkdWNXUDdzbzlJbVlnRHdUaEQ1WUlN?=
 =?utf-8?B?dEozb3VNd0RZZVVaRUJQOFJNSGhmbEN3eGRmaWkxUXdGNzVpeEtaUW9objlh?=
 =?utf-8?B?OU9wczhqQXpVM0M3MGlhSzFhUEl4NUFQTlRCQ0xQUVpEWE5LZGhMMzNSbHpi?=
 =?utf-8?B?eUZvMGxmZkxYWTJnNjdSVDMreER6T1MrYlA1cXZmS0NmU1k4T3VVb29nWXhB?=
 =?utf-8?B?M2ZDd3RmZ1kwQjBNR2QyUkdvY1piS2l6UUtYTmk1N0xBeUpWZWZTcG5ZYW0w?=
 =?utf-8?B?c2IxakpBNHRKMmZwMDVtQ1NNOVg1bkp6T1dzNEw0NHo0dFd4UTYvY0d3SWQr?=
 =?utf-8?B?VTU0N3dUSnVQVE1JazRXWEs2dFBBdnJGUnVVWExHZDVtb25sRzJNVGNSWXBB?=
 =?utf-8?B?NUJBTVdxczY4NGcrV01Gc0FYUVRveUo5MUxDVGRGbkV0dkZmWk8wOGJkK0RI?=
 =?utf-8?B?cmFPUU9kaUd3MVJUdjVjS2lGZjdwY3dkNCtMWmlDUDZBNGlHdnhORTIzVWl0?=
 =?utf-8?B?OHRkK0pJcnNSdkZPSHYvdVliZTdZOWcvUFV3cExjekNacysyeldBNnpTaGV6?=
 =?utf-8?B?ZGoyZElYV3F6a3JBVnlVV1lsTC9rbC9wemNHS0t1ZHJ4UmpIRk1SWllLdTNM?=
 =?utf-8?B?Mno0cTMyVWc4cEw3MGxPWXNSMzdlU2p0QWJIS0xpWFYvc25BY3J0OFFyKzBV?=
 =?utf-8?B?OUpSRXdITlZXMGc0aXpZdDNkQ1hJdWk4SEg5ZXBidVU3UFVBSzI2VzhNWVVT?=
 =?utf-8?B?cGFVK2JjS0oxOTAwZUg5WFJJZU1UY0pzZktEQzBENDBzd2liUHh1UFNlTEtj?=
 =?utf-8?B?cVlyVnlQbW1NOU1XaThrRXB3YlQyc2hHZWpTcU9hT2VaNzJHREN2MEZWd3hN?=
 =?utf-8?B?MUtUSkZmUENza3hKSzhjSXVzRmxncTlUZi80S1BNRmNKK1U4K3hZY0hxSHBn?=
 =?utf-8?B?ZmlPSlRMOFZXaEtEeWZVQzJOaWd2SXpMaUdUUUZxcWp2M0NHaVFxUTBNVERx?=
 =?utf-8?B?SWc3SlB5Mk9uTnp5azJiSG92VThxRXJPN2ZjOHBwL0hiWmxSL3lqc0VBT2Vk?=
 =?utf-8?B?bnRjK21WWERUVUlLaFVGb3pSVmU5TisvcEJ4WG4rdGJoQTg5VVFRQ21objJ3?=
 =?utf-8?B?Q0RhUUFDdExUYTJGS3JuL01kWlhGazBBcE1oRm1ud0tyR1VLSjZUN0tVNjNq?=
 =?utf-8?B?R0E0M0JBMnFiU1VUbFFPbElOQUt2Q1pvYVBlQXY0UkNEbEpSL1hneVJxMW9L?=
 =?utf-8?B?aFVuclhzS3pDNVhFNmgxUWZhZCtsODJEVDQ1b2V4Z2hRREgwdmphdWdnNVE0?=
 =?utf-8?B?L2NZVFBBWDlmZWhLVi9URWQrM29qZEx5dHRMZ0V5b09wTm0vc0c4RE9ON0li?=
 =?utf-8?B?OVNxYmVya3VJdmJDSDlMdGVtZ24yV0JqcWRLc3BVM0NFejVYa0Iya3VFK2FQ?=
 =?utf-8?B?S1BVcmhRa3hrY093RDdsa0cwd3FRR1ZXRGlIU0hVQUZrbkRUZWQvTU1hZG9R?=
 =?utf-8?B?Z2I5T25yRnhCQWdNMnRPOW5mRUVIZ01OeDZkZVM5ckhCVUpQbmxtejZKR1Fs?=
 =?utf-8?B?M0ZCZmd2TWVVNjNlcHk0cDlVU2xMelN4UzlIaTJ5N3Z2aE9iNlpzdFZMOVlQ?=
 =?utf-8?B?bCtNbktyMkpwRGViYWdMR1FaU3RVS1hTOGc2bmtnazBEZFF3M0YyVzJFOHdu?=
 =?utf-8?B?TWRYUisrUU80WmtFK2xjbUkxRVk4dUt5Tyt0NTVzcmlYdzFMUzhCYmIyMUxy?=
 =?utf-8?B?NVA4MTc4ZXRBTElPL1hPd0NTVEFjZG1Za2xpNE9OR3NoMjdKdzFVRVdFTFFh?=
 =?utf-8?B?T3pjcGtYSlVCNG1RcE0rZ3dFRFM2enFscDYvWk94a0ZkcC9SOU50bXVJVDVC?=
 =?utf-8?Q?x/QrkBAO8Ixgej3dTnMdAdExE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ba49598c-44d0-4a2b-005a-08ddad852b42
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2025 09:56:02.3911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0wVt3PLvHpfOPpDxzZFL6ps9lYtdusgGeOD7fFqeNsWwFRrfYfQ7jopOFQVIAilMbttPGUrWYWsEvofAy4Da3/IHoLcIvKu6wJG9MUeFl8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10477

PiBIaSBLcnp5c3p0b2YsDQo+IA0KPiBUaGFuayB5b3UgZm9yIHJldmlld2luZyB0aGUgcGF0Y2gu
DQo+IA0KPiA+DQo+ID4gT24gMTYvMDYvMjAyNSAxNzowOSwgTmVlcmFqIFNhbmpheSBLYWxlIHdy
b3RlOg0KPiA+ID4gQWRkIHN1cHBvcnQgZm9yIDQwMDAwMDAgYXMgc2Vjb25kYXJ5IGJhdWRyYXRl
IGZvciBkb3dubG9hZGluZyBGVw0KPiA+ID4gY2h1bmtzIGFuZCBhZnRlciBIQ0kgaW5pdGlhbGl6
YXRpb24gaXMgZG9uZSBhdCBmdy1pbml0LWJhdWRyYXRlLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1v
ZmYtYnk6IE5lZXJhaiBTYW5qYXkgS2FsZSA8bmVlcmFqLnNhbmpheWthbGVAbnhwLmNvbT4NCj4g
PiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LWJ0
LnlhbWwgICAgICAgICB8IDEwICsrKysrKysrKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTAg
aW5zZXJ0aW9ucygrKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQNCj4gPiA+IGEvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL25ldC9ibHVldG9vdGgvbnhwLDg4dzg5ODctDQo+IGJ0
LnlhbQ0KPiA+ID4gbA0KPiA+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
bmV0L2JsdWV0b290aC9ueHAsODh3ODk4Ny0NCj4gYnQueWFtDQo+ID4gPiBsIGluZGV4IDNhYjYw
YzcwMjg2Zi4uZjFjN2Y5MDAwMDFjIDEwMDY0NA0KPiA+ID4gLS0tDQo+ID4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LQ0KPiBi
dC55YW0NCj4gPiA+IGwNCj4gPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9uZXQvYmx1ZXRvb3RoL254cCw4OHc4OTg3LQ0KPiBidA0KPiA+ID4gKysrIC55DQo+ID4g
PiArKysgYW1sDQo+ID4gPiBAQCAtMzQsNiArMzQsMTYgQEAgcHJvcGVydGllczoNCj4gPiA+ICAg
ICAgICBUaGlzIHByb3BlcnR5IGRlcGVuZHMgb24gdGhlIG1vZHVsZSB2ZW5kb3Incw0KPiA+ID4g
ICAgICAgIGNvbmZpZ3VyYXRpb24uDQo+ID4gPg0KPiA+ID4gKyAgc2Vjb25kYXJ5LWJhdWRyYXRl
Og0KPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50
MzINCj4gPg0KPiA+IGJhdWRyYXRlIGlzIGluIHNvbWUgdmFsdWUsIHNvIHVzZSB1bml0IHN1ZmZp
eCBmcm9tIHByb3BlcnR5LXVuaXRzIGFuZA0KPiA+IGRyb3AgdGhlIHJlZi4NCj4gSW4gcHJvcGVy
dHktdW5pdHMueWFtbCwgSSBjYW4gc2VlICItYnBzIiB3aXRoIHJlZiB0eXBlIHVpbnQzMi4NCj4g
SSB3aWxsIGNoYW5nZSB0aGlzIHByb3BlcnR5IHRvICJzZWNvbmRhcnktYmF1ZHJhdGUtYnBzIiBh
bmQgZHJvcCByZWYgaW4gdjINCj4gcGF0Y2guDQo+IA0KPiA+DQo+ID4gQW5kIHRoZW4geW91IHdp
bGwgc2VlIHRoYXQgaXQgY291bGQgYmUgYWN0dWFsbHkgYW4gYXJyYXksIHNvIHdoeSBub3QNCj4g
PiB1c2luZyBleGlzdGluZyBwcm9wZXJ0aWVzPyBPdGhlcndpc2UgeW91IHdpbGwgYWRkIHNvb24g
InRlcnRpYXJ5IiBldGM/DQo+ID4gVGhpcyBkb2VzIG5vdCBzY2FsZS4NCj4gPg0KPiANCj4gVGhl
cmUgd29uJ3QgYmUgYSB0ZXJ0aWFyeSBiYXVkcmF0ZSBhcyBmYXIgYXMgSSBrbm93Lg0KPiBBbHNv
LCBpZiB3ZSByZW1vdmUgdGhlIGV4aXN0aW5nIGZ3LWluaXQtYmF1ZHJhdGUgcHJvcGVydHkgdG8g
Y29tYmluZSBmdy1pbml0LQ0KPiBiYXVkcmF0ZSBhbmQgc2Vjb25kYXJ5IGJhdWRyYXRlIGluIGFu
IGFycmF5LCBpdCB3b3VsZCBjYXVzZSBiYWNrd2FyZA0KPiBjb21wYXRpYmlsaXR5IGlzc3VlcyBm
b3IgZXhpc3RpbmcgY3VzdG9tZXJzLg0KPiANCj4gTGV0IG1lIGV4cGxhaW4gdGhlIG9iamVjdGl2
ZSBoZXJlLg0KPiBUaGUgTlhQIEJUIGNoaXAgd2lsbCBwb3dlci1vbiBhbmQgYm9vdGxvYWRlciB3
aWxsIGFsd2F5cyBjb25maWd1cmUgaXQgYXQNCj4gMTE1MjAwIGJhdWRyYXRlLCBldmVuIGZvciB0
aGUgcGxhbm5lZCBmdXR1cmUgY2hpcHNldHMuDQo+IFRoZSBkcml2ZXIgd2lsbCByZWFkIGNoaXAg
c2lnbmF0dXJlIGFuZCBmbGFncyB0byBzZWxlY3QgdGhlIGNoaXAgc3BlY2lmaWMgRlcgZmlsZQ0K
PiBhbmQgc2V0IHRoZSBjaGlwIGJhdWRyYXRlIHRvIGEgaGlnaGVyL3NlY29uZGFyeSBiYXVkcmF0
ZSBmb3IgdGhlIGFjdHVhbCBGVw0KPiBkb3dubG9hZC4NCj4gDQo+IE9uY2UgRlcgZG93bmxvYWQg
aXMgY29tcGxldGUsIEZXIHdpbGwgaW5pdGlhbGl6ZSBhbmQgYmFzZWQgb24gbW9kdWxlDQo+IHZl
bmRvcidzIE9UUCBzZXR0aW5nIHNldCB0aGUgY2hpcCdzIFVBUlQgYmF1ZHJhdGUgdG8gImZ3LWlu
aXQtYmF1ZHJhdGUiLg0KPiBIQ0kgaW5pdGlhbGl6YXRpb24gd2lsbCBoYXBwZW4gYXQgdGhpcyBm
dy1pbml0LWJhdWRyYXRlLCBhbmQgcG9zdC1pbml0LCBkcml2ZXIgd2lsbA0KPiBzZXQgY2hpcCBi
YXVkcmF0ZSB0byBoaWdoZXIvc2Vjb25kYXJ5IGJhdWRyYXRlIGZvciBub3JtYWwgb3BlcmF0aW9u
Lg0KPiANCj4gQ3VycmVudGx5LCB0aGlzIGhpZ2hlci9zZWNvbmRhcnkgYmF1ZHJhdGUgaXMgaGFy
ZGNvZGVkIHRvIDMwMDAwMDAgaW4gZHJpdmVyLg0KPiBCdXQgaWYgQlQgY2hpcCBhbmQgaG9zdCBw
cm9jZXNzb3IgYXJlIGNsb3NlLWJ5LCBvciBtb3VudGVkIG9uIHRoZSBzYW1lIFBDQiwNCj4gVUFS
VCBjb21tdW5pY2F0aW9uIGF0IDQwMDAwMDAgaXMgcG9zc2libGUuDQo+IA0KPiBUaGlzIGNhbiBi
ZSBhY2hpZXZlZCBieSBhZGRpbmcgdGhlIG5ldyBkZXZpY2UgdHJlZSBwcm9wZXJ0eSAic2Vjb25k
YXJ5LQ0KPiBiYXVkcmF0ZS1icHMgPSA8NDAwMDAwMD4iLg0KPiANCj4gQ29ubmVjdGlvbnMgd2l0
aCBGUkMgY2FibGVzIG9yIGZseS13aXJlcyBzaG93IGNvbW1hbmQgdGltZW91dCBlcnJvcnMgYXQN
Cj4gNDAwMDAwMCBiYXVkcmF0ZS4NCj4gSGVuY2UsIHdlIGtlZXAgZGVmYXVsdCBzZWNvbmRhcnkg
YmF1ZHJhdGUgYXMgMzAwMDAwMC4NCj4gDQo+IFBsZWFzZSBsZXQgbWUga25vdywgYmFzZWQgb24g
YWJvdmUgZXhwbGFuYXRpb24gaWYgd2Ugc2hvdWxkIGNoYW5nZSB0aGUNCj4gYmF1ZHJhdGUgcGFy
YW1ldGVyIHRvIGFycmF5IGluIERUIGFuZCBEcml2ZXIuDQo+IA0KDQpDYW4gdGhlIGV4aXN0aW5n
ICJtYXgtc3BlZWQiIHByb3BlcnR5IGJlIHVzZWQgaW4gdGhpcyBjb250ZXh0IGFzIGFuIGVudW0/
DQptYXgtc3BlZWQ6IHRydWUNCiAgZW51bToNCiAgICAtIDMwMDAwMDANCiAgICAtIDQwMDAwMDAN
Cg0KVGhhbmtzLA0KIE5lZXJhag0KDQo=
