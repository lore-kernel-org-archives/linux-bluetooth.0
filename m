Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2047.outbound.protection.outlook.com [40.107.105.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AA715CD7B
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 13:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966596; cv=fail; b=IS9GxxUBl0DEBXVU8MRRtfjAO65DxImdgooSUArF6x7N29MB2oSjR7+eVz/yozBO+cBOkFLzR8ErdLtLoew9ijAmxUA+sWK/QIMS06nF1scEviXUYIouTQCTCSakRn8KquJ1uG8WofxHs386aBPvnPtFCBN69e0wq0ZwEs8ePQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966596; c=relaxed/simple;
	bh=Lorujn5TVTHyCgqNy3gPZbrtOi9su1uZPZXur/eoe2s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Keb8KHCFOmfPldgqY0ZRuJQYNXCAmLoYU/nzRxvJ7vamkVJMS7lVELomu+Aqee/F6sGPOo0vVnRflmKK+o9nMKFpdYGKt3QcvHbudHSWoskZeuRrx2N13M+yJfaXnwUIEdJ0vB41Sh3Eg8EvXb8LnMpxCfGKQgkDJsyJNsSOVsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=swwHvn8G; arc=fail smtp.client-ip=40.107.105.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="swwHvn8G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKly57I7BNHJaXUr8jzfrjPEURojW2GmF+CslTNANbW8Ekiq7vxF/EHacEZC8EA7y2Nt0iyVUyQKE4mc9AZk0xH1QS3z8ENeYezXdxVl5z6MGaXD1pYdj7XNPMhmmbMkw5hK1nHESBUlegGms15NGKUJ37XCZ+KtnzccXfUi9zrpANi4wJ70DqBDAxCV6fSVM8Z8tIDHgmXcEO3qtnS7huefozGT0Sw3F9N3N19K1MCqzNtXwZoUk/JQbQAy1VZRVaXsqfV9WEeB0nGzyEu4j703H+zvHRtExelRxr9paa3/68NPdYWhLpC/KFfi8DUeIGxv0uIwjcjHlr3IdZCBHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lorujn5TVTHyCgqNy3gPZbrtOi9su1uZPZXur/eoe2s=;
 b=OPVfhjOitlSuUv4IDFXBIIGwxU4IrnvXhqUuZkk2O5hfFYrqzdczxa/HRRbI8XS/M0Wt6bKdiXLAAyXn0Rupxct4AiMZUeVtMbk6R340h2+7lnbK70U02m1AGEGUfOpq78pmIx5ma3fd/bTOSqbYo7tCfya6UtpeNI/mvkI6IxKQhaKNfwdJPDBCZAbhAHtbUTon830rJw2QegKwNOxo8Pvmyr3nnq2UJ9hTDUujTmkDIc/JoXTFAWgsihm9CWTY1l/H80rzljfjalMeJbCqFqaoGZPJ6jHs6bR1pAbehxJtrJnZwIbCwBnhocYWVrSsp9UXpFc5Zj3A8KZDpFyA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lorujn5TVTHyCgqNy3gPZbrtOi9su1uZPZXur/eoe2s=;
 b=swwHvn8Gu0MvJjE39OoUvFTOTya3os4UDmBZx2gIQOxaVVyWKOVblRioK1eOPccfp1MMuh1yE4AHJqG0Cn+pCDnuptTZ45QCf4CpxmRxKVVkSfC2/3WJQppDEJpgfWC9lg+v2fsUxA7e1xXxsrsQ3XvMQ5QYiyjHA+MzLbuHigA=
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com (2603:10a6:20b:654::9)
 by AS5PR04MB9753.eurprd04.prod.outlook.com (2603:10a6:20b:679::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 13:49:50 +0000
Received: from AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::361b:7c80:c98:57f]) by AS5PR04MB9754.eurprd04.prod.outlook.com
 ([fe80::361b:7c80:c98:57f%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 13:49:50 +0000
From: Mahesh Talewad <mahesh.talewad@nxp.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Devyani Godbole <devyani.godbole@nxp.com>, Sarveshwar Bajaj
	<sarveshwar.bajaj@nxp.com>
Subject: RE: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Topic: [EXT] Re: [PATCH BlueZ v1 1/1] LE Create Connection command
 timeout increased to 20 secs from 4 secs
Thread-Index: AQHaeTEPMqiC0Iq8WEO4vPnWaUEu4LFAZciAgAAQ9bCAAA5eAIAzrrFQgAN1N8A=
Date: Wed, 24 Apr 2024 13:49:50 +0000
Message-ID:
 <AS5PR04MB9754210A13AD74FB8C3E361D89102@AS5PR04MB9754.eurprd04.prod.outlook.com>
References: <20240318123712.9729-1-mahesh.talewad@nxp.com>
 <20240318123712.9729-2-mahesh.talewad@nxp.com>
 <CABBYNZKvAmb5JjfxkPADED6CQKD+GxsRqLajHX=w0GE+imhCMA@mail.gmail.com>
 <AS5PR04MB975486834B434042CE2A693689332@AS5PR04MB9754.eurprd04.prod.outlook.com>
 <CABBYNZK5YS6paOYbx4yL6R7Wt9o+oGrtmfiQNmOaTAUo2DBfdQ@mail.gmail.com>
 <AS5PR04MB9754B55170413A2FD0A00F0A89122@AS5PR04MB9754.eurprd04.prod.outlook.com>
In-Reply-To:
 <AS5PR04MB9754B55170413A2FD0A00F0A89122@AS5PR04MB9754.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS5PR04MB9754:EE_|AS5PR04MB9753:EE_
x-ms-office365-filtering-correlation-id: 1b0a0b00-669f-46bc-364b-08dc646569b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?SVFqY0wwN3p0TG9yVS9aRWRJbHc2dWpDeE9hZGgyeGVjUFY4SWczY2lzdFo0?=
 =?utf-8?B?NjQ3YUNPNVNBb0dRbmpiQnA0MVZyWFM3Rmt0NUV2aGF4WXErdEYyTHhVSHpp?=
 =?utf-8?B?NjhNU3pZNzJreDhlb01GcmZYV0RnNko0TFhjTDJTODF2OHI3T09qZkRrNllI?=
 =?utf-8?B?QUlDc2J2dEEzT0hmT0lPMnpJd2xWZXlPeW5vNEk2VlIxNXJaajUyeERzSEJu?=
 =?utf-8?B?NjNUZkdSdVpxeDQ2SUVWSHJ4bkYxUXVPT2Y1ajdtL1Y5ZlRXZ0xmWW1PaTBB?=
 =?utf-8?B?V1RISy8zU3JZNnVMbG9adG14MjMxaXBCNkV0YzY5OXlxMDhBdXdxUkd2cTdF?=
 =?utf-8?B?eTI3OTdMQVdtcms2NkZUYlp0ZUs5RXZpSjF1WkVoaUYxdnRhVWcxa3M3OVlj?=
 =?utf-8?B?K3NBRC8xNmtmTUdJa1lSTlBoOUUrL0hxS0JKNWhrdmY3aDBRSGVQMHFVRnk4?=
 =?utf-8?B?cy9ia0NDVjhOY2xPVkZtWGRIQWV0T0pRMzU4c0ZkTU1jQ20rbUVyTzN5SkE3?=
 =?utf-8?B?QlVVWkNXaDhWY01sOVJ6OFY3MDhvMFpuNE1CbTFuN0pkVVErUmZ4alBsUUxz?=
 =?utf-8?B?R1RoZDZiazhOekJ2alBEV08veXdPbXpZc25yWVo2bVBtajRUVjM5Z1NxeE5p?=
 =?utf-8?B?NUgyYnNwWlVTc1F0ZUhLWEQ3V1lCSDM5bW44ZHBYSUcxdnRvc0hBQ1lEM0Q3?=
 =?utf-8?B?UnN1Z2tyaDVwUVlyc2xMNHZWNmptV3pBMEl3bnZpR0F6VENIT1NPSDg0OXI1?=
 =?utf-8?B?REp6anJnamxxK2d5K0ZGbzZwZlhiVnJ2VllLblBvbVFkTk1mRnY4Q2RPUENC?=
 =?utf-8?B?K2p1Z1JudCtDZ2V1M3o1NmVVZ0dFeTZIbG9iR0tNODdZdnFMeXNmeXJmdXR3?=
 =?utf-8?B?ZUJ6QTRFMW41OUdaYzg1ZGFHY0NJTFVESzhJNkh6L0ZhclNCaWQ2RUhGdGEy?=
 =?utf-8?B?dEtjOGtYeFZYY3QxMEo0OE1IZ1ZJb3VLZHg2WkVPVEx5VmdIY2wyN2JCc3NE?=
 =?utf-8?B?VnRTL3AxQXB6Qi9ibjhpR01xeEZKem8zbVZpOWNVTVlsWlRqZXF5QXhjWjlM?=
 =?utf-8?B?T1U1ZUE0M2Nkc1ErTTZTdlZUcU9HQUE3QStzVThRR2IwNFgrSmFQd3l0U2tq?=
 =?utf-8?B?aUt0U3dTU3ZXYVNKZGpuRmFTZE1ON2QwU1FRcUQrTUdFK2cvK1hCdkFBbkFx?=
 =?utf-8?B?RlRGcEhicFB5ZW9LYWI3b25yUWRQYmhQOXdpcm9FclFEUHU4SkRNbXRHaVht?=
 =?utf-8?B?aUo1V0FWU0Y2NW1NeG5BRElYSzViMG1BM3kybVBHOVhzYVpRM01RMmU2UnNy?=
 =?utf-8?B?WWJrT3NBTm1aUldtZkpsOFk4Wi9ZVUdqUEh3eFh0Ry9MMzZ0bHdGRjBmSG9J?=
 =?utf-8?B?WEtQYjZ1TkpaUXBoYTBSK1g4cFBLMTVxUzhVUEs5aWVnOGxldnBzemYrMzBE?=
 =?utf-8?B?YW05Mm02azd4Z24vL3FQSlZzenk1UzF4T2lOSm9QN0tkNEdhMGovOWJSRFR2?=
 =?utf-8?B?UFE3UHBDUnRXNGhzbE9ERExSTUZLcEMzUThnWVpxWkhWMThxeFhya3ZUY0Vw?=
 =?utf-8?B?d09sYVRmbDFVY21mMGJKM2FMblg5bFBCVEJvVjNmSnZRSmJmUk1takxaY2ZX?=
 =?utf-8?B?MjFOc2hjeC9pQzNtdzNsVmM2SXJkT1FlZ01ueHNDcTZrSERvOXFzMlNTQ3VE?=
 =?utf-8?B?R0w0OFNGQTN4SlltZE5ZTGZTVExJZ3UxUmZTRFZ2L1k3K0h4QjNwb3J3ZEpI?=
 =?utf-8?B?a2N6NWVRZmp5Q0VDRnBuckFhWGtBbmh2ZDJFRllyTk9jU2tEalBITDB0YkNN?=
 =?utf-8?B?d0o1MlNTcWhDdFB2ckVydz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS5PR04MB9754.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dGlYeFZtdE42Z3dXSnMvWXpZRVZRd3o2YjNKOWZxVEEwNkJIckVEdzZtbUI3?=
 =?utf-8?B?M2VJTzFuaXZObklJMkU4ZFU4UVo3SVBaVjVYMWVseXFRS3RsR0dvQm52dHRW?=
 =?utf-8?B?RjZocFdpQWtpUHU2dE54N1lJSWt5b2s0VkovSUVsOU1qZm1vQjBuTmR2ZTZS?=
 =?utf-8?B?TFEwWWM5SHRVTjFoZEYxMlRmWWU1VDl1azN5aXo3YU9Oc1p4Y21mMUhra3FO?=
 =?utf-8?B?aVZ2U1lSNHhHTFdZTHpCL2laT3k0ZFE4cmZpUEMvZ0RwUklJanNyZ1h1a09U?=
 =?utf-8?B?SnEzdHU5QXM5WHJsV3JXNjN0VEV5N3AvbEZPL3FEcGozTG4vUnhSU2hCc2dh?=
 =?utf-8?B?Wm0yWDNiS0orejZJOGRHc3N2R3BodzJyNnN5aHBFMm1hME5DN3VkVFo2QXFh?=
 =?utf-8?B?dU1raDlMOHlwbldmMmNXa3lTNDlZbzZMZk9TdFk0L042MmdaSkFXWVVuSWpK?=
 =?utf-8?B?K045alBLbEIxL1Fpek4rdVczT2FFMnpwTGpyV2JDUjl0QmlFb21nOGQvdTZG?=
 =?utf-8?B?Q0IybHFDa0NaL3VHUDZ3SVg3d1VOVSt1WnRnOHllcEtTR2h2UVNTSFJmbTNv?=
 =?utf-8?B?U3hOT2lPSHRaWWhTZzFIdkRENXZBY1hvd2VuNlJzdGNldHZ1aGh6Z2xWMVZZ?=
 =?utf-8?B?T1FTWkpQczMrMjNsdzNoN0tmelRxWksxcFZTdlBHUjgzUHY0aFNrbkthSUJ6?=
 =?utf-8?B?Z0Zkd3FUSWsvUFNCRXN1aFgraTB0OE50Wkl1SWdOQmlnLys4L1QzbkFRajhv?=
 =?utf-8?B?L2tIcDVGTlFMeVlDN3k2TnliNGFKOStuSlBDU2ZMVkZacnpjclUzcXIwb3E4?=
 =?utf-8?B?YiszUmk2NCtpSTNKQkhIY2tFUkRYc1U5TStYR0Zucld1MTRkb211aDBYSTJW?=
 =?utf-8?B?YjZVV09TeTQ4OVVURUNsNmw5WCtDdVlTQmF3eENvR21TTVYzemREN2dHemJn?=
 =?utf-8?B?c1Z6WStNd056LzE2VDdjaEZ5S29adnc4ditacExjMjluZzVSek8rdXZJbHhY?=
 =?utf-8?B?d1JTRWR4ZGpZNXFMVDVyWWlEaW1QNk90VXVyS1hTaFR2ays3MVBmT3lJSXVC?=
 =?utf-8?B?M3hHdFJPazR0QnU5dHZoL1RweE9vYUxTbHFGSFNEdTZXS3hRYWNvQ0hXUnFu?=
 =?utf-8?B?WDdaMXR2YjMyQmdNbUQybGFOMU1iRHpaZVYxemVlazNWTjh2R0NUdE1DUDRo?=
 =?utf-8?B?dDErci9oQzZHT09TQnRJN1gwL2VlZ3JnaEg3bW9OcEhzckJOMHVWZTIyeEVS?=
 =?utf-8?B?dzY0WjBXWXVaQ1U0Yks0WGNrQ05nQ0FFdEszaHpTRVBDeTVIYjZIZE5JRGg3?=
 =?utf-8?B?L0ZiY1dHN1I2Vk15eG1jaXFZMm9UdHliY1lvMmNOQXpzVTRJcHRtWFFwQlNv?=
 =?utf-8?B?d1p1ekorTFRxeFV3VXRLWXY4SmR2VVJSSEpvbzNEcTJWVi80emFvcEhqeXpR?=
 =?utf-8?B?cjZydjlwS3BZY0NXSGJCdWE1SXV2UzAvSW9xZzU3c1FJNzhSSFdDcGFlSWZ1?=
 =?utf-8?B?M1hOcTFTZHUwSmlrNXB0QmtvTTRRWmczWERyTXBKbHdLcFRuUUw3K2U2MzJn?=
 =?utf-8?B?RjljSDliUjJhM3JicHV1NzB4dGlpK1ZwSVN4ekhpZzNaTDlNUlZaNk1YR0Jk?=
 =?utf-8?B?YzRraHVtSjR3Yk1MLzJ4MUFIb1R6dlN5RXIzMUtDQ244Y1NMZmx5bmhBem9n?=
 =?utf-8?B?dVRlU2RUUnh2SytDNmQ4TTlUNCtKRXFHcjdsWUYydVAxMWgwS05UNUdwOWY2?=
 =?utf-8?B?QUJBaVduMlU4Ly9GaXpDNFBuY2VuY3RlVUxzUC9NVFdscG1idkFjMVZJRXU3?=
 =?utf-8?B?Qk1ldjlQQjgxQThkNGNkcE1lbDJGc3grc3JnemxpRXBxNmxuLzRjdlY5Z3dq?=
 =?utf-8?B?VlRSd3JJeFYydXZ5V1RZWmRKZ1hXSmd4RHI3SmF4NkkyMEVzeVZ3SThIVkY4?=
 =?utf-8?B?UUZOMmI1ekJaM2RKTmIzRFNpNnJMN3laNTFxN053d2pQZVNnTWw1KzdtZzV5?=
 =?utf-8?B?ajVCRlJzSm1IVk40S3F3ZjhwdnljN29wUG12VFkvZmRWaVVFZThRSi9UU0JC?=
 =?utf-8?B?UVdVbUlXTmg4NGNZWFl4b0JYajlxb3BNejZ3MGJPSi9KaGhyQngvT3F4azAr?=
 =?utf-8?Q?91urZvM+SJxPh5FRvO3XRpJH6?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b0a0b00-669f-46bc-364b-08dc646569b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2024 13:49:50.7092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6bImm9L04Bvp9egrIPK01FbFVzcapBRiHqdCTphHXjdZt1b6+CeZ749NOeBvmCQ1xz5n8FmFpI1djVtnxap3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9753

SGkgTHVpeiwNCg0KV2UgdHJpZWQgd2l0aCAtIDYwOTNmMjg0MDJhYTYzNDI4OTBmYzNhZGI2YmUz
NTVmODA0YjcxOWQgLSB3aXRoIHRoaXMgYXMgd2VsbCBpc3N1ZSBpcyBvYnNlcnZlZC4NCg0KVGhh
bmtzIGFuZCByZWdhcmRzLA0KTWFoZXNoIFZpdGhhbCBUYWxld2FkDQoNCi0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQpGcm9tOiBNYWhlc2ggVGFsZXdhZCANClNlbnQ6IE1vbmRheSwgQXByaWwg
MjIsIDIwMjQgMjozMSBQTQ0KVG86ICdMdWl6IEF1Z3VzdG8gdm9uIERlbnR6JyA8bHVpei5kZW50
ekBnbWFpbC5jb20+DQpDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgRGV2eWFu
aSBHb2Rib2xlIDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNvbT47IFNhcnZlc2h3YXIgQmFqYWogPHNh
cnZlc2h3YXIuYmFqYWpAbnhwLmNvbT4NClN1YmplY3Q6IFJFOiBbRVhUXSBSZTogW1BBVENIIEJs
dWVaIHYxIDEvMV0gTEUgQ3JlYXRlIENvbm5lY3Rpb24gY29tbWFuZCB0aW1lb3V0IGluY3JlYXNl
ZCB0byAyMCBzZWNzIGZyb20gNCBzZWNzDQoNCkhpIEx1aXosDQoNCk9uIG91ciBEVVQsIHdlIGNh
biBzZWUgdGhhdCB0aGUgaG9zdCBpc3N1ZXMgY3JlYXRlIGNvbm5lY3Rpb24gY2FuY2VsIGNvbW1h
bmQgYWZ0ZXIgNC1zZWMgaWYgdGhlcmUgaXMgbm8gY29ubmVjdGlvbiBjb21wbGV0ZSBldmVudCBm
b3IgTEUgY3JlYXRlIGNvbm5lY3Rpb24gY21kLg0KQXMgcGVyIGNvcmUgc3BlYyB2NS4zIHNlY3Rp
b24gNy44LjUsIGFkdmVydGlzZW1lbnQgaW50ZXJ2YWwgcmFuZ2UgaXMgLQ0KDQpBZHZlcnRpc2lu
Z19JbnRlcnZhbF9NaW4NCkRlZmF1bHQgOiAweDA4MDAoMS4yOHMpDQpUaW1lIFJhbmdlOiAyMG1z
IHRvIDEwLjI0cw0KDQpBZHZlcnRpc2luZ19JbnRlcnZhbF9NYXgNCkRlZmF1bHQgOiAweDA4MDAo
MS4yOHMpDQpUaW1lIFJhbmdlOiAyMG1zIHRvIDEwLjI0cw0KDQpJZiB0aGUgcmVtb3RlIGRldmlj
ZSBpcyB1c2luZyBhZHYgaW50ZXJ2YWwgb2YgPiA0IHNlYywgaXQgaXMgZGlmZmljdWx0IHRvIG1h
a2UgYSBjb25uZWN0aW9uIHdpdGggdGhlIGN1cnJlbnQgdGltZW91dCB2YWx1ZS4NCkFsc28sIHdp
dGggdGhlIGRlZmF1bHQgaW50ZXJ2YWwgb2YgMS4yOCBzZWMsIHdlIHdpbGwgZ2V0IG9ubHkgMyBj
aGFuY2VzIHRvIGNhcHR1cmUgdGhlIGFkdiBwYWNrZXRzIHdpdGggdGhlIDQgc2VjIHdpbmRvdy4N
CkhlbmNlIHdlIHdhbnQgdG8gaW5jcmVhc2UgdGhpcyB0aW1lb3V0IHRvIDIwc2VjLg0KTm90ZTog
SW4gQW5kcm9pZCB0aGlzIHRpbWVvdXQgdmFsdWUgaXMgMjkgc2Vjcy4NCkRvZXMgc2V0dGluZyB2
aWEgJ2Nvbm4tPmNvbm5fdGltZW91dCcgbWVhbiBzZXR0aW5nICdBdXRvY29ubmVjdHRpbWVvdXQ9
dmFsdWUnIGluIG1haW4uY29uZiBmaWxlPw0KDQpUaGFua3MgYW5kIHJlZ2FyZHMsDQpNYWhlc2gg
Vml0aGFsIFRhbGV3YWQNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEx1aXog
QXVndXN0byB2b24gRGVudHogPGx1aXouZGVudHpAZ21haWwuY29tPg0KU2VudDogV2VkbmVzZGF5
LCBNYXJjaCAyMCwgMjAyNCA1OjEzIFBNDQpUbzogTWFoZXNoIFRhbGV3YWQgPG1haGVzaC50YWxl
d2FkQG54cC5jb20+DQpDYzogbGludXgtYmx1ZXRvb3RoQHZnZXIua2VybmVsLm9yZzsgRGV2eWFu
aSBHb2Rib2xlIDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNvbT47IFNhcnZlc2h3YXIgQmFqYWogPHNh
cnZlc2h3YXIuYmFqYWpAbnhwLmNvbT4NClN1YmplY3Q6IFJlOiBbRVhUXSBSZTogW1BBVENIIEJs
dWVaIHYxIDEvMV0gTEUgQ3JlYXRlIENvbm5lY3Rpb24gY29tbWFuZCB0aW1lb3V0IGluY3JlYXNl
ZCB0byAyMCBzZWNzIGZyb20gNCBzZWNzDQoNCkNhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwg
ZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvciBvcGVuaW5nIGF0
dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdS
ZXBvcnQgdGhpcyBlbWFpbCcgYnV0dG9uDQoNCg0KSGkgTWFoZXNoLA0KDQpPbiBXZWQsIE1hciAy
MCwgMjAyNCBhdCAxMDo1NuKAr0FNIE1haGVzaCBUYWxld2FkIDxtYWhlc2gudGFsZXdhZEBueHAu
Y29tPiB3cm90ZToNCj4NCj4gSGkgTHVpeiwNCj4NCj4gWWVzLCBpdHMgYXV0byBjb25uZWN0IHNj
ZW5hcmlvLg0KPiBXaGlsZSBydW5uaW5nIGNvbm5lY3QgZGlzY29ubmVjdCBpbiBhIGxvb3Agb24g
b25lIG9mIHRoZSBjaGlwLCB3ZSBhcmUgZ2V0dGluZyBpc3N1ZSB3aXRoIHRoaXMgZGVmYXVsdCB0
aW1lb3V0IC4gSGVuY2Ugd2UgaW5jcmVhc2VkIHRoaXMgdGltZW91dCB2YWx1ZSB0byBzdGFuZGFy
ZCBMRSB0aW1lb3V0IGkuZSAyMHMuDQo+IEtpbmRseSBsZXQgdXMga25vdywgaXMgdGhlcmUgYW55
IHRpbWVvdXQgZXhwbGljaXRseSBkZWZpbmVkIGZvciB0aGUgYXV0b2Nvbm5lY3QgaW4gdGhlIHNw
ZWMuDQoNCldoYXQgZXhhY3RseSBpcyB0aGUgaXNzdWUgdGhvdWdoLCBvciBhcmUgeW91IHNheWlu
ZyBpdCBpcyBhIGNvbnRyb2xsZXIgaXNzdWUgYmVjYXVzZSB0aGUgYXR0ZW1wdHMgYXJlIHRvbyBj
bG9zZWx5IHRvZ2V0aGVyIHdoZW4gdGhlIHRpbWVvdXQgaXMganVzdCA0IHNlY29uZHMsIG5vdGUg
dGhhdCB5b3UgYXJlIGp1c3Qgd29ya2luZyBhcm91bmQgdGhlIHByb2JsZW0gYmVjYXVzZSB1c2Vy
cyBjYW4gYnlwYXNzIHRoZSBkZWZhdWx0IHdoZW4gc2V0IHZpYSBjb25uLT5jb25uX3RpbWVvdXQu
DQoNCj4gVGhhbmtzIGFuZCByZWdhcmRzLA0KPiBNYWhlc2ggVml0aGFsIFRhbGV3YWQNCj4NCj4g
LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVpeiBBdWd1c3RvIHZvbiBEZW50
eiA8bHVpei5kZW50ekBnbWFpbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjAsIDIw
MjQgMzoyMSBQTQ0KPiBUbzogTWFoZXNoIFRhbGV3YWQgPG1haGVzaC50YWxld2FkQG54cC5jb20+
DQo+IENjOiBsaW51eC1ibHVldG9vdGhAdmdlci5rZXJuZWwub3JnOyBEZXZ5YW5pIEdvZGJvbGUg
DQo+IDxkZXZ5YW5pLmdvZGJvbGVAbnhwLmNvbT47IFNhcnZlc2h3YXIgQmFqYWogPHNhcnZlc2h3
YXIuYmFqYWpAbnhwLmNvbT4NCj4gU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBCbHVlWiB2MSAx
LzFdIExFIENyZWF0ZSBDb25uZWN0aW9uIGNvbW1hbmQgDQo+IHRpbWVvdXQgaW5jcmVhc2VkIHRv
IDIwIHNlY3MgZnJvbSA0IHNlY3MNCj4NCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBl
bWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNsaWNraW5nIA0KPiBsaW5rcyBvciBvcGVuaW5n
IGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgDQo+
IHRoZSAnUmVwb3J0IHRoaXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBIaSBNYWhlc2gsDQo+DQo+
IE9uIE1vbiwgTWFyIDE4LCAyMDI0IGF0IDEyOjM34oCvUE0gTWFoZXNoIFRhbGV3YWQgPG1haGVz
aC50YWxld2FkQG54cC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gIC0gQXMgcGVyIHNwZWNzIExFIENv
bm5lY3Rpb24gdGltZW91dCBpcyAyMCBzZWNzIGJ1dCBpbiBpbXBsZW1lbnRhdGlvbiwNCj4gPiAg
ICBpdCB3YXMgNCBzZWNzLiBIZW5jZSBpbmNyZWFzZWQgdGhpcyB0aW1lb3V0IHRvIDIwIFNlY3Mu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBNYWhlc2ggVGFsZXdhZCA8bWFoZXNoLnRhbGV3YWRA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyB8IDIgKy0N
Cj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYyBiL25ldC9ibHVldG9v
dGgvaGNpX2V2ZW50LmMgDQo+ID4gaW5kZXggNGFlMjI0ODI0MDEyLi4wNmZlNWY2Yjk1NDYgMTAw
NjQ0DQo+ID4gLS0tIGEvbmV0L2JsdWV0b290aC9oY2lfZXZlbnQuYw0KPiA+ICsrKyBiL25ldC9i
bHVldG9vdGgvaGNpX2V2ZW50LmMNCj4gPiBAQCAtNjA2Nyw3ICs2MDY3LDcgQEAgc3RhdGljIHN0
cnVjdCBoY2lfY29ubiAqY2hlY2tfcGVuZGluZ19sZV9jb25uKHN0cnVjdCBoY2lfZGV2ICpoZGV2
LA0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gICAgICAgICBjb25uID0gaGNpX2Nvbm5lY3RfbGUo
aGRldiwgYWRkciwgYWRkcl90eXBlLCBhZGRyX3Jlc29sdmVkLA0KPiA+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIEJUX1NFQ1VSSVRZX0xPVywgaGRldi0+ZGVmX2xlX2F1dG9jb25uZWN0
X3RpbWVvdXQsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQlRfU0VDVVJJVFlf
TE9XLCBIQ0lfTEVfQ09OTl9USU1FT1VULA0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIEhDSV9ST0xFX01BU1RFUik7DQo+ID4gICAgICAgICBpZiAoIUlTX0VSUihjb25uKSkgew0K
PiA+ICAgICAgICAgICAgICAgICAvKiBJZiBIQ0lfQVVUT19DT05OX0VYUExJQ0lUIGlzIHNldCwg
Y29ubiBpcyBhbHJlYWR5IA0KPiA+IG93bmVkDQo+ID4gLS0NCj4gPiAyLjM0LjENCj4NCj4gQWZh
aWsgdGhpcyBpcyBvbiBwdXJwb3NlIHNpbmNlIGl0IGlzIHRoZSBhdXRvY29ubmVjdCBwcm9jZWR1
cmUsIHJhdGhlciB0aGFuIHVzZXIgaW5pdGlhdGUgY29ubmVjdGlvbiwgc28gYXJlIHlvdSBydW5u
aW5nIGludG8gYSBwcm9ibGVtIGlmIHRoZSB0aW1lb3V0IGlzIGRpZmZlcmVudD8NCj4NCj4gLS0N
Cj4gTHVpeiBBdWd1c3RvIHZvbiBEZW50eg0KDQoNCg0KLS0NCkx1aXogQXVndXN0byB2b24gRGVu
dHoNCg==
