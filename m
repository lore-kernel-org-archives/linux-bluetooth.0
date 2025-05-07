Received: from TYDPR03CU002.outbound.protection.outlook.com (mail-japaneastazon11023099.outbound.protection.outlook.com [52.101.127.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370C8273F9
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 May 2025 07:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.127.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604248; cv=fail; b=ZJ6KkAEhGn7vJb3Qal3OEbLC9B+rjPb7Gf3MO80grSMjx4F145u148+8r6phory45LOcVbTdGbAev9uVnQ4rFboo5OkUg3xpHMKoLZQT3BaIAsVFWHmJBAc8iTQxZg/emFH+y5KX9DMJhbgafyPhrWeYWIZW56ls1lY4jt7x80Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604248; c=relaxed/simple;
	bh=CrVRhran7kvw9Vqnru61B+HU8OaVqzkIYQ0m4XmQzcc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nVETjTNDMplpfdutDK3HhXS/l1IiDGsF6TLPpXFj9LHYtRzomFZpedPM+B4U8knR3nDGRI7CWlRrvu9BhF3A+HVG5U9N+uAhLvzZ1Fo7sVPCZ7LbG2kH+gK+c+wkP+AADLro4tivCK0fIsdrCmUfEYHP99QlfSDieD0sJy6YWd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=PJ6Rz3VJ; arc=fail smtp.client-ip=52.101.127.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="PJ6Rz3VJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CbxA2oEmrS6ZLpTMqCtWj6k6jx9QOZoBucisB7akGuiWc6nIKtAhlAoBCM5lo4306DMiYJYACZ7NaWizZvbHI7XpS9U5JUHuvALPJtFQjUj5KnJArl3npz9RMKt6uPSGanha1qQ9HC+s6eEhFns13Wiuons+L4wYpp5KYmw9hu6mXtqgUiZsPFDlg3CcqZrs+ZuEpkrULptZkzuE02RgpMmA2nnGXOFODLXualgK8N9DPe8SD30QQ17Ab9L7qR1psJTz/dcutNQTQcmsBX3RhjFKYgNMA3g4Ws38ZFfT2j2hscR0I2vctGB0Uvgj7ek2Kk6avCnrH2P5YE7SvXlYoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gu/5sXG1zPA/F+JVRnQR2Dksxia5UA0msWDaeACN0aQ=;
 b=NY8dQCZwC/Q5bDfC+cLdsz/Z5g0CvR0N5gu6keFUpqShrmkHCgS+q7selltUGs3reGBQ0q6l9Go8Xyz+7NuLeosqLsh5lhFb3pf/7EUoX50Ea092BfIOtnYl/cZHboDnTvcdlU3B9yAmIhNPTIwpt4MCWNhuRrT9qA2RXgTYrmFaIBjeKvyC21Y1POAKyTAaQQNzN6RW5ebrBuUpGbDPp48I1L1t798glVHG/GhQyHwcH6SatIpbISJoJDMfs/V5pXgSwRXcmmJwpcZrYTJ7cU0q44jaWj8r2Sfq0xH1nN2PWVnIKxd9Av7NiRnQdF2kzRPGMnwlInHbvIQIVKQLfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gu/5sXG1zPA/F+JVRnQR2Dksxia5UA0msWDaeACN0aQ=;
 b=PJ6Rz3VJdp6rQpXkHty/kT7ExvMfH+DD3PwUbhHtSD4UdPOoImjgei3wLT+cpzAtWzUrimW/a/vmh9w2XhZXLIWWOu8xasH2mrI7E2ZeMCsZ2XeSczi02TgHlkv8d62Zs7Mycoj7vZeKQ8ThIf5M0xKCqqx1t0GxdP6rrac6VlxnWw/jBXQAwz2jnVTBk2LlFE9C3uI/GtJTrxro9pbMniRKSaZk+3EjzPQeqgJQUuDZfu9qSbvgE9DABvbrH9zMTgtwpMu7Z7XhXhFfTep0S6silsp6iiFolYvyeRePGU4WYVdICSRuC+nesdFLeo48rF3JiZjmclix1Ky8Cy1GEQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB7049.apcprd03.prod.outlook.com (2603:1096:101:e0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 07:50:41 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 07:50:41 +0000
Message-ID: <f1eced24-89c9-459a-8253-42de7aacfe9b@amlogic.com>
Date: Wed, 7 May 2025 15:50:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v2] bass: Set the service connection flag when
 BASS connected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
 <CABBYNZKW23-P_8OZGTz-bQ2b2vZX_SbxA_hEJ=BAbk6Bkmwsrw@mail.gmail.com>
 <bfb733a1-b39a-4a33-bd3a-aa9d25339cc1@amlogic.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <bfb733a1-b39a-4a33-bd3a-aa9d25339cc1@amlogic.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCPR01CA0150.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::19) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB7049:EE_
X-MS-Office365-Filtering-Correlation-Id: 40635c60-2429-496d-6b2c-08dd8d3bdcfe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXNWTFpoY3czUmErM0FVd05zQVVMYnBIdFdoSnR2TmpzRExrR2NqUjJucWJj?=
 =?utf-8?B?ZGZJNjhYdFRNL1h5dDBEN1dLU1lyY2JGQTdPazBTRFVMQlp5OGhwZWZsVHg4?=
 =?utf-8?B?K1VwQjN1ei9FS09KdEgxbHdPeXpSMEVTT2Ryc1Q2NGJyTjZiU2pLc3FNY3kr?=
 =?utf-8?B?S0x0Y01GcUZSdWJXMjB0emlYMll3K2YzTE52cTd3VVBvMk1BbWlvYWVJQW5S?=
 =?utf-8?B?c2VJanZoQmd3dXk1eUF0Rnc3eWFodnM2eWs4WlVYOFpJcDN4K09EMmpEN29E?=
 =?utf-8?B?SjhpUXZSTGNoa0M2S0NEZS9tS2tkY2xVVGNrWGNCK3RYbTJoUHl6OGFqcllO?=
 =?utf-8?B?TFc2RmZKMUIwK3VWZFBRbktuN1lmV242ams3M2tEcng1QkNtNnhtVU1QdGs5?=
 =?utf-8?B?NFVyT2tFZ0wxbkt1enUxcytvNHpMM3hNcjhURFR3VzVMNFk1WjVXWW1rbEFs?=
 =?utf-8?B?d2ljc25YN29nbmREUUVpeW1yWEE4K2dWLzBGeHVSOG1VQnRTaEhhRTEwZDFj?=
 =?utf-8?B?Sm5NSWs0Q25wbHRTNVFqd0NDT3FkQWp1d1hSbzh3SlAzZHJwMDFUY3FYUFZi?=
 =?utf-8?B?Mlg5dHo5TDFTbTZlc1EvSndtMGhSZ3JpM21KZ25BSGlITGpKcW9UNUtUaFNm?=
 =?utf-8?B?OUljV2RDWWNmNXJMWFRNNXZTNmxNMUwvbXlLYXJQeHEwWGVIVmk2c01XWFM0?=
 =?utf-8?B?VmlNQWNnVmxiU2kzMCtPVThaWENmL1RBbC84emRZN3BBQkVGajFjUkRKcDY0?=
 =?utf-8?B?akFLM0pUMmZSbTNiWjRDbzBSZ2hKK2RsSjQ5T3lSQzdYbUZ6ZnpPcnJFdnNw?=
 =?utf-8?B?a1dMWFVuRmx4MEZtNlRnc2x5WEtvYmYydVJwZnp3akJSY1oyNzg3MXlHZHVL?=
 =?utf-8?B?UlVqRHZmUFRsZ0kzT1FqRzJ0dWlReTh2bnU2YUl4SUdiVGx6UnpkVzVEbkNO?=
 =?utf-8?B?NHc5MXRDUTVuR2cwTTVubVpLNUpoN3AxWVc0djQ0QVpGQTlRd241Yi81bG84?=
 =?utf-8?B?b3VvZWhIUGptYnZobnl5K2x1UHBuM0J1dkVsMWttUkkrOXA0RGc0RXNmeVY2?=
 =?utf-8?B?bzdPK094ZFpQczJaTmozL1JhMmlKUXAwT1lkTGJ4K0o3UVBxQ3ZoMnlpZjh0?=
 =?utf-8?B?NHRSeFl1WGhSem5KWmx3TWNIdTZUbi82RUU0NWppWHhlN0NaTEJLa2NnSC93?=
 =?utf-8?B?eEl6TC9qa2poWjZUVDdBVXM5UHNtQnl1OTZBTTlON2ZPeTlxb2VuY3dFYnNN?=
 =?utf-8?B?bGE1b0VjVkEya1hzalZYdmhrMFBMY1k4aWs4Ry91YWVWMURwYUZUbWxwYXNs?=
 =?utf-8?B?UmtHWklpL25GRUhWWHdoeFJ1dHE0K0JXTXJsMnFUMU0zNW84c0xZRzlURG96?=
 =?utf-8?B?SThhazVkL3hSNmI5dy9Bazd3OEF2UEo4dVczc2FSVlFYck1DVncrYlNuSjlP?=
 =?utf-8?B?RmVKNk0ycmRjVnV5cmc1eXN4cnpLYy91RTk4dGpPc0p4QXl3Wm1oTlJyVG5q?=
 =?utf-8?B?R05OaVlJSUhibTJwdWhZeHJ0UnRqWk85MHVvMkxiZUJvbFhVNHE4Znp5bnRn?=
 =?utf-8?B?amZCUllaNnJuS0V0SVZqbjNEeHplNlF6REhSTnphb1VLL1JnV3VXSlNmZ01E?=
 =?utf-8?B?YVdySm1pNkJ3Rldzc3FnOVFEWlpJa0lVeG1KMzRvdFYvVE5OaXpQK3hMdERr?=
 =?utf-8?B?ejcvMkF2N2FWYUJPeStTTERCTmJ6b2tMb241b2NjVUVHWDg3UGpTUlJDY29v?=
 =?utf-8?B?R29OSE93bi94QzNtZTRjSWNpQmIxUFZSTGMzQ3d6QmtpdTk3dk5tejhnWXl1?=
 =?utf-8?Q?NB+rk/DJN29onmVTfX1CJHZnK/TBvfPrXocv8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3laWGl1NFJtVmFGa0NkS3pKR2UrUzBsbXg5UklINFNwMHNxOXFueVJ3c1lv?=
 =?utf-8?B?Mithc1BIcTJMZklpM0MrQ3d4Uyt5Q0JIUC9MeGlDcnNXd2dmMks1c0ZmSWw3?=
 =?utf-8?B?RUpQOFFTUlc5UFl0VitnNEtZc1BhQWJGWFVIckZRSUFrRDZvWC9pZGJTcXU0?=
 =?utf-8?B?dVJiR3Y2bDVYc2lyVHh6d2ZwR1VoblA0Nnh5aDJmUngrNTc4RjcvQ0dDOGVF?=
 =?utf-8?B?dk1SRmVkZy9VT2RkUHRCbHFUNEI3dDRDeDI1OWplM0ZhMUo0eG43QnhUbDdm?=
 =?utf-8?B?Tld0MkNJZ2xUYnBHQlZaRXpqQWRvcVVGaVJDbW4zYkVEaXd6NkVWSE1DQnV1?=
 =?utf-8?B?cUhxNDhzKytZSUltbEdwMGdKVUFGZUY2UUdxQkZxR0psM0U4Ui8xMEg2SUph?=
 =?utf-8?B?bm85YUh2Q1MzdXloWWVXL1U2UnM1QVZLQ1BVa01HYUlhVVptdk5uVDZ6K3Iv?=
 =?utf-8?B?cThQNzVjeXRaTXBpa0w4R3RHc3JpV0grQWZlZWpNR3phdnIwLytNZ0JuM05w?=
 =?utf-8?B?N2U1ZEV3U01rVUltaFc2MlhNVkt5RHlHM0Q0UFRLZ0tHZTlPcjFpTi9qVVdk?=
 =?utf-8?B?SkZyQ2JZbFpBS1RCbEtybHhjNis5ZVpxV1YxRUUyckRGaEdtdDY3eEdleGFi?=
 =?utf-8?B?Yk4ybEU2bkU4aUk0NmRDNHNMdllEVmpzZ0xuZ0RoWEdOT0RvbTZUcjVrb1g4?=
 =?utf-8?B?dS9TSkpFVk51YmVYeHZRWXFoa2I0b0REOHVpbmw4bWcxVGtnVzMwa0pnNmtk?=
 =?utf-8?B?RlBZWlVMU2l4ZUg4YWVwaExmdzAwdUJCVWhQL1N0Mzc4QlM5M0FCclVpaG9n?=
 =?utf-8?B?MFVLRXBzdDNmQVFWUlpCT25sYlNuQ1o5bmsyK01SYW1DZmM4cFZaMTNzQTdx?=
 =?utf-8?B?YUJNUEcvWHpJY2lxcTdHbW4zcjF5T0VCbk43ZXFPYmpPWG91MU5MaTJoNDRN?=
 =?utf-8?B?bldRalVLa0ErcnF3RTdlbkZ2eStlTFBTdDVXdTdySzZIVVVrYzdCS1diOEJJ?=
 =?utf-8?B?YzMvYnNKV1FvYUltTUpKNTdVZk03YUxPdHowVTJ2MSsvamhadmR0S20vemdM?=
 =?utf-8?B?Q2VCL256Nzl5VVBxUVZYVmhHQzdBNFc0K25HZ3NEVU1halgxZGdJTkFxNjQ0?=
 =?utf-8?B?TXhxQ0JDa0l2bFc4Tkw4LzEwR3p3TTVONHduZHdYYXdxdDRlcnE0a285bXRX?=
 =?utf-8?B?ajdUN2pCZCt4TDhZY2pOSHBlVkRKRWp2WFNoUFlNQ2dEaWFvY1BuU1ExdmNJ?=
 =?utf-8?B?cDZaZWEzNWRwdkJtdEUyMEFxTDJ2THJVU05Vei8xbUJ1YXVMaEEvbEo4dkNs?=
 =?utf-8?B?STVOUFdZSVZNR1drS2xycUVuMUhHT1BORWtyZW1jOGcwNUdsekJTM3RvbmNJ?=
 =?utf-8?B?UGhGM25ieDlPbjhBekhWb25JeTlRS1hGSXZMVFkxeWFQT2FJOUxxdVRDbHdC?=
 =?utf-8?B?dEhPVklXYUQ0Z2NOSlFhWWRtTHVaNWJDbWJHZVlWMTVtdjByVE1TdVA3QjE5?=
 =?utf-8?B?NkMvK0tTTTFCZ0E0ZWZEeDdLancxcGZjVmllYWR3MElGUGlOL2tSVUp0YVNk?=
 =?utf-8?B?WXh5d0gzSzRmckZneTBaaFArVkd6U2dRZklxK3dIUXhFcm1jcWkrakRWTGhx?=
 =?utf-8?B?cjZaRnI0ejhORngxSWpaWVB4V2pkUjV1Tkh0MFFOK29ZU0F3cFlHb1FWMTU3?=
 =?utf-8?B?OEZId0UrbjFFeExQZlQrZWN4NnpJNDFjdXJLMDlEZmFCRGJ5a1NiTEdVVXB2?=
 =?utf-8?B?Nk8yYldsNDZKSTdwNk5TUHN3cWdQeGhEV09GT3UydkNIUm5FUUtDNjcwaDM3?=
 =?utf-8?B?MUJrRCt0c2hPcVh3NW5IME95ODMrenUrMXl4eStYQ2lXYXVGNGlZcmZHaDJO?=
 =?utf-8?B?dzNQTjgzaXFMRnVZMklsTE14K3FacXJtSlhGR0YvTnd2N2VTWmV5YlpaYmpV?=
 =?utf-8?B?TTJKNDU0RWE3aVlhSlNxa2ptdS85SkQyTG1aSFBkbjhtMldoeFcycHQ2S1Rl?=
 =?utf-8?B?VFN2d3AxMno4SW55a0craytPYlloeHA4S1FRRFEyYkdNelVCRHNYMzNHc3Jn?=
 =?utf-8?B?L2hrR2NON2pIS29LblV4Uk5MdU1PbXpZODFEMzU3dFphUFdJQy9ER1M1Q2pU?=
 =?utf-8?Q?p+35/tIx3eeleCELfzpKsGP+S?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40635c60-2429-496d-6b2c-08dd8d3bdcfe
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 07:50:41.0544
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeDiwH7YTnPaHInrdS5x2sWqbZJk+4X9zUSxoECah1avObVI/QbQ9RW4DIsE2T1IwNGUMwFh5zJa+D5wC4sYXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB7049

Hi Luiz,
A gentle ping, thanks.

> Hi Luiz,
>
>
>> [ EXTERNAL EMAIL ]
>>
>> Hi Yang,
>>
>> On Wed, Apr 2, 2025 at 11:37 PM Yang Li via B4 Relay
>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>> From: Yang Li <yang.li@amlogic.com>
>>>
>>> When BASS serice connected, set the service states to
>>> BTD_SERVICE_STATE_CONNECTED. Otherwise, the device will
>>> timeout and be removed, triggering the automatic termination
>>>   of BIG.
>>>
>>> issue: https://github.com/bluez/bluez/issues/1144
>>>
>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>> ---
>>> Changes in v2:
>>> - Set the BASS service connection success flag in the connect_cb 
>>> function.
>>> - Link to v1: 
>>> https://patch.msgid.link/20250402-bass-v1-1-3e753841faa5@amlogic.com
>>> ---
>>>   profiles/audio/bass.c | 2 ++
>>>   1 file changed, 2 insertions(+)
>>>
>>> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
>>> index c36f43277..c28d9d1ad 100644
>>> --- a/profiles/audio/bass.c
>>> +++ b/profiles/audio/bass.c
>>> @@ -321,6 +321,8 @@ static void connect_cb(GIOChannel *io, GError 
>>> *err, void *user_data)
>>>          if (bt_bap_stream_set_io(stream, fd)) {
>>>                  g_io_channel_set_close_on_unref(io, FALSE);
>>>          }
>>> +
>>> + btd_service_connecting_complete(setup->dg->service, 0);
>> Ok, do we mark it as disconnected when the BIS is disconnected?
>
> Yes, the service will be marked as disconnected after the BASS service 
> is disconnected.
>
> static int bass_disconnect(struct btd_service *service)
> {
>     ......
>     btd_service_disconnecting_complete(service, 0);
>
>     return 0;
> }
>
>> In
>> case we are acting as assistante then there is probably no reason to
>> keep the device object around after it has been pushed to the remote
>> sink.
> I don't think so. As an Assistant, the mobile phone needs to record 
> the source information configured for the BIS sink. The record of the 
> source device will only be cleared when the BIS source is removed.
>>>   }
>>>
>>>   static bool link_enabled(const void *data, const void *match_data)
>>>
>>> ---
>>> base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
>>> change-id: 20250402-bass-66200bb7eba1
>>>
>>> Best regards,
>>> -- 
>>> Yang Li <yang.li@amlogic.com>
>>>
>>>
>>>
>>
>> -- 
>> Luiz Augusto von Dentz


