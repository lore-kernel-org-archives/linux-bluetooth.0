Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023084.outbound.protection.outlook.com [40.107.44.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA5B195F0D
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Feb 2025 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739780433; cv=fail; b=mdNX1VnHnFI29nZNb+4z4f3YEOgh47y6EaJh5crq1KD0VgKx4OEkFWnHQPzAi3GohcoQwY1TkXwDTduptIwOGee3turg7nAYZJ0OLEPADz9YLfe3l0nqFwwt8CHTwrRA7MXzIsB7WBrFZSmiyTFCiZTWj/tp3LjLMAnnG1/ICl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739780433; c=relaxed/simple;
	bh=H1vMsGB+PnESxbp48jmNzmslJJYUt2osjGHb2sBgERY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jnxKzvvLwkmTjrCXsKmHOG6wREgXR9kLcXurRMuvb/Tg9hQvuM0XqsKB0Uvzd52tjLs2A5YhDjnYLLYEgBvylCqkrs+oTYLeWqLqrIXWiOjiCnMbbpqoj9QZLZs/of5MlxuEvYfSBgt2ZjTDY9S+WsM/czWdzOqt98LrpVVITe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=KMXo54T5; arc=fail smtp.client-ip=40.107.44.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="KMXo54T5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcHZ2J75BMtFfuJb2Sl7utydbgm8JPYAWPFS4bncWCGLvNCigvmMKmgi+Nf0P/DFcU0i9YQMk9ySWCfBaVujU0X9d3UgTidclPUxEhYEtDDexNlS6r320r6xka3kSCojakX/mLNfvpGPN5uT9W5jyrg3WugaCyfUSUxHDH+BvbkjSncXJ5EW4Z5yCng4Frv29INN7QAl0P8IrBCfDtArS3WjhhVE6A3jNz1OIJfKrqfH0bLONWN3uyF5ip+I3nBxWfNkPtGj9zu5NdwYpQZDdCl9bBlpiBD20RguqDB7TmCzV6NXLU8WYad2fk6ua/roRmr6lVtZhB5LChala0o4jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtAmTmdU/EY0EAMRb4DHgZa+7+dRRMguC1Fih227iSQ=;
 b=hLM2La6luyer2CZ11q360KarIC4OR0b/2nQiXITzNVmNEuvYjVeLJPGYm3pjXJKsn8PBg5VvD2fcxf95y+92YO1agwqFPkI4WGzhULM4zUika9/2snKtmMOBmjU/J0dRLvx1V0V4SbyLMwael1HTSgJQqrnugnHdI6mSD1QwpcMDjE8J/+mchP9PYi6nGNAanAvII1k71tu8l5IfwhEsvP1foFO7iaWcDv/Ofjh8QkgHzBlq6n/UwQ80Xa1auVrRV+qHR/PrTewklgnjPdrPpip6wtOfp+j4jzxRT/DxAwZhCteWDMV+J4ZMFRzxXc7xKNbJFAOfXiDm/0mVmWzdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XtAmTmdU/EY0EAMRb4DHgZa+7+dRRMguC1Fih227iSQ=;
 b=KMXo54T5nzBFgKWbR/XR7eh9xYqJDTCVkeO8k4sNxJovJgQan/QTgH7RykiEnoJ4Eh0tAViw7K0FsdHeDLFDS8Foei9VaIJCM6ZbGSPIH5bQnx82IWjwmSdbeif09nCXZUIkWvqHC30I2KGzfqOQ/d6jrLGRDvSEX6RXyU36YH0PL4xoVCvd8fw9VvtbKSpmqBWN+zZfwWVvy99hRAPFqMf5m6Ie0/RLelj+OBbTV89nguTM5wdULsWXyQzk6liYteRQZct/j9LFiWGXbrpPbl71P0jHn9qKfdtEkMvd0NrkqyklyhqDqQ4yxftvJQLr56pPOmrfht43APcFdMTGJw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEZPR03MB8487.apcprd03.prod.outlook.com (2603:1096:101:21f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 08:20:27 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 08:20:27 +0000
Message-ID: <a8173f35-d88d-4475-bb6b-b20b94281a03@amlogic.com>
Date: Mon, 17 Feb 2025 16:20:07 +0800
User-Agent: Mozilla Thunderbird
From: Yang Li <yang.li@amlogic.com>
Subject: Re: [PATCH BlueZ bluez v3] bap: fixed issue of muting music silent
 after pause and resume.
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com>
 <CABBYNZKT3g4tMc+TNLvgk09_3yUqj-N5ycXMnottHyWpfStV9Q@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZKT3g4tMc+TNLvgk09_3yUqj-N5ycXMnottHyWpfStV9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYWP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEZPR03MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a4c8cf-fa40-4889-62b5-08dd4f2bef1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aUN5S1hFSHBOMWVuNXdUaXhUd01VZjFUZzhPRENlMzVnZkdJd2d2VWQ5b3kx?=
 =?utf-8?B?L2IybkM3Ti9FWllOZlI4NU5IMktoUVlXQ3ZnNmtqWmF2ZE5IU3FHcm9jc1Az?=
 =?utf-8?B?TU1ZWk5xTWorQ3Bla1loR1I0SEoxZm5rL2s3VFN0THBYL2ZISit1U3FBVXRF?=
 =?utf-8?B?V3FUMHhRb3NYTm5LcmdRZS8wNXBJSzZRSHlWWmF1dDg4Z3ZKZlRFQXZzbWlY?=
 =?utf-8?B?TGNXZ3RGWXV1RGZraldsdldqRTZjZ1RuNWZTOVBJejcwL2x3SVkxenpQSG9L?=
 =?utf-8?B?K0VMVi9YUTFKaG9tNHozeU9KYUJZYVcyaFZ1VU1hYmxDR0tyUTVxQVRSVEpq?=
 =?utf-8?B?Zjg3OVd4LzZkVGd6MDVDdjNzbThwcVdiQlh5c0dQazZadG9MRC9MZ3FhYWVm?=
 =?utf-8?B?UnVKRDFXd0NXdjBUbWtqM2M4cjhmNkJqYk81OUtYaDdjbjI1Vld0OWg4UjJh?=
 =?utf-8?B?VmNnYTU0QjlwSlMwdENlWFZpNlNxYnFHRTRPRzRLMCtmMVNOWlRGcWdxQ2Zs?=
 =?utf-8?B?d08vUWFDcDlVenFYYWF3TEhwUTZzVWszOWNIZDR4NURSUjhPVWFoTUdyOFdj?=
 =?utf-8?B?NDUrLzNDUXhpU2NqcytDUFhBamliQTh6dEFpL3VldW02MXBweVByTWxJSkY5?=
 =?utf-8?B?emNKcGlvNDZpTThIbWxCSndMdVZUSHh2ZWNDUmtZelBDb0NTL1d1dk0vSHFN?=
 =?utf-8?B?VVJTV2FGQXhXMFc4SVg0UHBKQ0h0NzVyNXlPa09uQWFOTERYcWEycTZIQnRD?=
 =?utf-8?B?T1ltYmNrOWdGeFRpTDhaR29CMVdBalBrUW5zUjd0Uk5MSlZNZkNjWTlNK2xS?=
 =?utf-8?B?eFI2ano3cDNNTElKTkExSFc0NktQV3ZHeEw2YUJGRDlVZW9McjNhaXBJSFNk?=
 =?utf-8?B?enp6MzU0TXFGUWIzaXFSQk4wM2wzRzhHOFVGL3F2M1J0a0E1UGZGNUFpRHV2?=
 =?utf-8?B?TUZGZ29udGRrUHpaVGN6dlNpS1lUMmhDZXJsNm50K1FEZVkzSnJpb3hpVEoy?=
 =?utf-8?B?ekFVQWJDM2RTNU02cFJoa0hHdWlSS2pjeWMrRDZWeGIxbU42cGpmdWx6TFR1?=
 =?utf-8?B?eUw1T0tQSm9NODR5WUhBNHRJaHRNdTVLdmFPc1Baa1VFSGpYcVNmTGZvVmtn?=
 =?utf-8?B?aFpHNXVsdmdJZngydTZGYzR2b01CaktlNGxCZ0dnb05majNzZlUvTWZqQWNp?=
 =?utf-8?B?Wlo0eDlyWFpMTFYwZS9tZHFxcjFhWnh4SThuVWV2UHcyVDdHSkV4dXEwL2dP?=
 =?utf-8?B?Tyt6RXV2MzZEL3F6TFhUckV5YTdQZUpRWWdlYk9ORkhmUXRoWnYzNkpGSUd3?=
 =?utf-8?B?Zzd4RzNub1JPSyttNDREbXl2RTVIZ2lwWnFMcEU1S09YaWlPS01hYTJpTHVv?=
 =?utf-8?B?RWVKbnZQZHp4V0xWNTluMFJWdjNhcE5TNFdobnpVSGlYZlhqenNSdzJVMzN6?=
 =?utf-8?B?dXFGZFA1Z2Q3Y0NUQmZxbmoyQlhxRkFOcFFKR0RwQ2tVOTB1c3pyWTgzekF4?=
 =?utf-8?B?dmJyQXljWS9QYWU3MHhXc1ROWE5HWGhyVXJueWVGTFBZbnR3RC9NVS9oQU0z?=
 =?utf-8?B?TUpHTThsaVlnTk14OTh0V2JjMi92dXZ1REhUS3VlYVpSdk5lWGhFeTZJVDhM?=
 =?utf-8?B?ekNLamtCUGl1YnczY0syemcwSEMzaWw3ZU9vcXkySHdFVC9XR0dXK01DeGgw?=
 =?utf-8?B?Y1pHbWJrbUhGK0R2NnNtV2V6bGlReEM3K1ZRY2xwSWh4RU12R1hCT25vcjVE?=
 =?utf-8?B?TFFTb1lhRlU3SUxKUnFiZXNPdnl1VTFKMzNOSDRkTi9VdkxqWWxHTjVKZ3N3?=
 =?utf-8?B?TEtnRnlEeVd0dkV5M3ZZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1VUblNoWEgrcVhoSUhmTStRQURsNG5BRUgyZmowN0dzVVFYVU9FTXUvUldw?=
 =?utf-8?B?aTR3RG1uN2RpdGV0ejQwcG1aa29aR1dpSWVoU3RvbW9PQVZoKzVJYXhPUmc3?=
 =?utf-8?B?VG82dlZIY3ZEdnR0TndzWDFxYjUzYnlzQmFHU1NtbXN4UnJmckV2bG5mWHEr?=
 =?utf-8?B?UnlBVFVNNGNVLzBRalAzTmtGQzdxWXRxVFUrUmFEL2ZOWmZaSlV1MklvVmRt?=
 =?utf-8?B?dldXVjNLMTl2MTV4REpJQlpENlpqR1NteGx3YTVLV0JjdFZXdUJUMDV3dDdh?=
 =?utf-8?B?bWdhQWcvNFhDcWdmcGJ4dFlDMmo4WFRJTkJqRW12ZGlGV2lBcmwvOVYyWGJW?=
 =?utf-8?B?ODJnYUVReCtWRTVvUThXK3NSaUFOTjJZc1ZZcWttRkpSVjh4MkVtaE1lVnhV?=
 =?utf-8?B?aERYTVdmUXFLSmVmWHY4UGhwYWlhcm5YL2dYNzdUcDI2c2RPOVJPdmxKMzZX?=
 =?utf-8?B?NnRWVUR4dmxIaVhyNkpmYVhhQWVDQzV5UHhXMGFqZzVIM1dMaWtOT0dmVXow?=
 =?utf-8?B?MWN4WHFiWDExWEw3aEVDK0RtT1RHb1A4SWFYVkJsT1dJQ29lczNsWUNBUDRy?=
 =?utf-8?B?ZFpKQ2RRUG1aK3Z5a0tVd1FNKzhxcG8zbzlLYW1scHVodVF4SWFVNmFKUlVl?=
 =?utf-8?B?RHRmUTlyYnpxMVRrZ3l5cGxGUVMybW5sWjViTTlsbExkSW9IUDhWRFIyZU05?=
 =?utf-8?B?dnN6N3NPVmZhNVg1RjJNQVNGWWlGZCsxaHd0V2k1L0VHbVROV0tHTEIyZ2ha?=
 =?utf-8?B?cXhEeDA0Yk95NklGTG1tZnFsZy8rbGRRNG1nZVdQSlkyUHFZdlVHd1E2U3pz?=
 =?utf-8?B?cS9OODdEbFRwSEYzRWRVYnlwaHcxeWI2V1JJOUtnVVB3UUt3amU0S3RNQUtG?=
 =?utf-8?B?RXg5dnY3WURDNitJUHFUa2VHOXZZMEtCOHR2WUIwRjJqVDJoR0pnRVVVZ3ds?=
 =?utf-8?B?bTR1QzVqd0NlM0JyTFFQaVFoc0tJVmI2QmlhWjBWSnJvNkdzSGg1UlpnTUt1?=
 =?utf-8?B?anhVMVVzWmJNdEhQdzFpRmpEM2pLQi92dzcvY0RjalBGZnVkNkdqdHBheXdW?=
 =?utf-8?B?ZDZNYmw5eXZkMUF0MTZobHNTOS8zT1ZmamtKTzk4aDlCR3Z6VjZzc0VFZmw1?=
 =?utf-8?B?Z2k1b3gvYVh3eDNXRU5rd01raTI5aXN6RUpaS3JRdWlOUDZyYW5TWEV3WS9j?=
 =?utf-8?B?eHdnRjVtdjJSTGdIZFZEYzdKMlB3eVB5NWk4UnNobGQvWk02b3ZqcG5SQUZL?=
 =?utf-8?B?QUllOUcxTVZTYzdkV0ZLQmM4OHhqRk9pV29sTk15SEY4ekd1S3JPNVVFUXFY?=
 =?utf-8?B?YVg0dGZGY00rOXJ6TXZVVW9ud21ROUNCbEJuWXJXbjM2VEtnVEpyajdBdElV?=
 =?utf-8?B?TVA5N1BiNkFIbEFUL3d2ejFsZnRWbDdINDJ5R0Z0ak1IeEhyN1hVNFhHTXdu?=
 =?utf-8?B?STNPaDRnb3pFWjNCVUo3YWdmSTBrVUJ5U21BS0Z3b2RmT2puZUthcGZOMjNy?=
 =?utf-8?B?Yk9iaU01OERER2thVnlMcldaM1RnakZueXIrbmtTbTA0Qk8yemR4TGd4KzAw?=
 =?utf-8?B?ZmZuVWd1YXF0ZHcvZ0lFdzJweDNnMGpuRG9mNFQ2bFZjTUVVMFdnMTlGbTZU?=
 =?utf-8?B?eVgzL05jOTVQVUVrQmc4bXZUTytrbGx2S1BTTmNCTTZoaEhyanVpZU1FRVVO?=
 =?utf-8?B?V2t6QTJFWk5wT0QyYUdnU1lNWmNITVdYbzg5TGh1c2p6bm43TXZ3b0xrU2JV?=
 =?utf-8?B?NTlDcEpDeGFqeXFHRjVycTZWZHZQRk1OYzhGcUJXbkhXUnJpeHZnbEhCUFd4?=
 =?utf-8?B?blgzNTdiTEl5YU5pUjh4U3pldzNDT0RxOWF2NjRUMTlUMVZEU2pDOGZrTGw2?=
 =?utf-8?B?VkIzR1QvUm9kK2FMVUlSTVljc05FUFJSQ1lnbDUxc1dFcGw1U1ExVk11bGdu?=
 =?utf-8?B?T2E3YUdId0tRZUs2TUtzdU45MGNsZ0NvelduejZCR2lmeFBpWkdWdFp2VUJK?=
 =?utf-8?B?Zy9BU3h0TkwyNjRsM0tQb1JNa01Fd2p4TVY1OXpmanlvbDh6Q1NKWTZXREx4?=
 =?utf-8?B?WjlDdzNtUk5GaTdtRjNXNkNYYUJDQkdYRk1oMHl5bk96Y3dKbDJSUWVubkQy?=
 =?utf-8?Q?QlJpNqzuEU0DfBAmkn0zz7pl5?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a4c8cf-fa40-4889-62b5-08dd4f2bef1b
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 08:20:27.1929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DGqa2Yg3Eie6GVV6LmumNso9OOMDsdF10WZDCnH4DiV5D+JTsqXrV+72LLmEg9uEyXoe4lzLgETWlv9KC8PCBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8487

Hi Luiz
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Wed, Feb 12, 2025 at 9:58 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> After the ASE state changes (streaming->releasing->idle),
>> the Client needs to be notified. The process as follows:
>>
>> ...(Sink ASE: ID=1, State=Streaming)
>> ATT Write Command Packet (ASE Control Point: Op=Release)
>> ATT Notification Packet (Sink ASE: ID=1, State=Releasing)
>> ATT Notification Packet (Sink ASE: ID=1, State=Idle)
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Solve the compilation error reported by test.bot
>> - Link to v2: https://patch.msgid.link/20250208-ascs_bug-v2-1-b7e062d6604d@amlogic.com
>> ---
>>   src/shared/bap.c | 31 ++++++++++++++++++++++---------
>>   1 file changed, 22 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index 167501282..079f7ede0 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -930,6 +930,18 @@ static void ascs_ase_rsp_success(struct iovec *iov, uint8_t id)
>>                                          BT_ASCS_REASON_NONE);
>>   }
>>
>> +static void stream_notify_ase_state(struct bt_bap_stream *stream)
>> +{
>> +       struct bt_bap_endpoint *ep = stream->ep;
>> +       struct bt_ascs_ase_status status;
>> +
>> +       status.id = ep->id;
>> +       status.state = ep->state;
>> +
>> +       gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status),
>> +                                       bt_bap_get_att(stream->bap));
>> +}
>> +
>>   static void stream_notify_config(struct bt_bap_stream *stream)
>>   {
>>          struct bt_bap_endpoint *ep = stream->ep;
>> @@ -1634,7 +1646,9 @@ static bool stream_notify_state(void *data)
>>          struct bt_bap_stream *stream = data;
>>          struct bt_bap_endpoint *ep = stream->ep;
>>
>> -       DBG(stream->bap, "stream %p", stream);
>> +       DBG(stream->bap, "stream %p state %s",
>> +                       stream,
>> +                       bt_bap_stream_statestr(ep->state));
>>
>>          if (stream->state_id) {
>>                  timeout_remove(stream->state_id);
>> @@ -1643,6 +1657,7 @@ static bool stream_notify_state(void *data)
>>
>>          switch (ep->state) {
>>          case BT_ASCS_ASE_STATE_IDLE:
>> +               stream_notify_ase_state(stream);
>>                  break;
>>          case BT_ASCS_ASE_STATE_CONFIG:
>>                  stream_notify_config(stream);
>> @@ -1655,6 +1670,9 @@ static bool stream_notify_state(void *data)
>>          case BT_ASCS_ASE_STATE_DISABLING:
>>                  stream_notify_metadata(stream);
>>                  break;
>> +       case BT_ASCS_ASE_STATE_RELEASING:
>> +               stream_notify_ase_state(stream);
>> +               break;
>>          }
>>
>>          return false;
>> @@ -2068,17 +2086,11 @@ static unsigned int bap_ucast_metadata(struct bt_bap_stream *stream,
>>
>>   static uint8_t stream_release(struct bt_bap_stream *stream, struct iovec *rsp)
>>   {
>> -       struct bt_bap_pac *pac;
>> -
>>          DBG(stream->bap, "stream %p", stream);
>>
>>          ascs_ase_rsp_success(rsp, stream->ep->id);
>>
>> -       pac = stream->lpac;
>> -       if (pac->ops && pac->ops->clear)
>> -               pac->ops->clear(stream, pac->user_data);
> This part I don't really understand, why are you removing the call to
> clear? Or are you relying on bap_stream_clear_cfm? That is only called
> on detach/disconnect so I don't think we should be removing the code
> above since it is still possible to reconfigure after releasing.
I removed the code to allow the mobile phone to disconnect CIS iso and 
switch the ASE status to IDLE in function ofstream_io_disconnected().

If pac->ops->clear() is executed, CIS iso disconnects actively, and 
stream_disable() transitions the status to QoS. bluetoothd.log as below:

bluetoothd[2223]: src/shared/bap.c:stream_release() stream 0x1ed5ae8 
bluetoothd[2223]: profiles/audio/media.c:pac_clear() endpoint 0x1ec8780 
stream 0x1ed5ae8 bluetoothd[2223]: src/shared/bap.c:stream_disable() 
stream 0x1ed5ae8 bluetoothd[2223]: 
src/shared/bap.c:bap_ucast_set_state() stream 0x1ed5ae8 dir 0x01: 
streaming -> qos bluetoothd[2223]: 
src/shared/bap.c:bap_stream_io_detach() stream 0x1ed5ae8 
bluetoothd[2223]: src/shared/bap.c:stream_io_free() fd 18 
bluetoothd[2223]: profiles/audio/bap.c:bap_state() stream 0x1ed5ae8: 
streaming(4) -> qos(2)
Could you please guide me on where to switch the ASE status to IDLE?
>> -       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>> +       stream_set_state(stream, BT_BAP_STREAM_STATE_RELEASING);
>>
>>          return 0;
>>   }
>> @@ -6172,7 +6184,8 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
>>
>>          DBG(stream->bap, "stream %p io disconnected", stream);
>>
>> -       bt_bap_stream_set_io(stream, -1);
>> +       if (stream->ep->state == BT_BAP_STREAM_STATE_RELEASING)
>> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>
>>          return false;
>>   }
>>
>> ---
>> base-commit: 2ee08ffd4d469781dc627fa50b4a015d9ad68007
>> change-id: 20250208-ascs_bug-e7c5715d3d8c
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
