Received: from HK3PR03CU002.outbound.protection.outlook.com (mail-eastasiaazon11021103.outbound.protection.outlook.com [52.101.129.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A9B20FAAC
	for <linux-bluetooth@vger.kernel.org>; Mon,  7 Apr 2025 02:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.129.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743991537; cv=fail; b=PtQdYlg+h4sJ5F/RngIBB+4YiqDwFGIY+IDALBrCeehvfTF3pWOz5RKFLhBZUjFJnCtCYg1XaCJnKuychOoWKrEZgdjDYS4gFKHnS6ZKRWMODHYwis5ElA+wXZBsC3fLX2KcESVaZCQlKMQDDnmmShQU6reu7oSgo8QDxISR74I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743991537; c=relaxed/simple;
	bh=h9rF4Vg/Qzm2Pa5l77JuxFr2d1HdBzGBbBJpw4ikkYo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pRTTcbWoziow4pRXzpR04IePdYfCZ2WhoKGgONBH98v07Y5iJrwt9rTA2xMbHm771sT84KxWP5MkZ0PEAoBpLMrXuK/GeBeSUVyR3i3XZSG25JWVyGDGoZPVTACIaEbvkWqHtLJTov54e9SsdLEKvbQXCpyVn4U6I7kZNys7470=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=zUAdbE7C; arc=fail smtp.client-ip=52.101.129.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="zUAdbE7C"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYe/G+cZvpUOzZ6LObQa+uYNh88+4nivz+w+MzAwysrgrtO2ZhPsC3q+WOrdcYvSu+dw01Y3HPvRdOAn8MAlPTm3Fbk7R/IyHB10gBzNwPWKDMhq3qzX9Nc7iZ7xarF2kJ14wYgtRD5NF5KoROVSnclhYpWV+brsEsJIuVzvwCoyPVkzLYMCkFFtH3MMSPsaQxwvhqk8wKWnZUAPAlskEHnMpzeS6NyEUiQkDnH7LFsvDr2bV2jh0fewyOEoy35r5yQ/CHaVpo0fRiNBAcMcDrZKWRwSW58r+SoCff6x4nwybzRd1YMCkkhd2CGQTKIq8slEMCLEwAnqyxHv1HYjZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j+w8vGjoGfP7bsDp14TELbkCMzkaXCVc/onZ7s43YWk=;
 b=X91SDSKJVfj0fTk3AvaVtWhDRIqUy5usY6d48bcuk5DhEJR/xC1/2u3nlgzkP8ifVxEwNWR1y9IYu3qlT1jq9e4FYlh8eA3LIT02khhhzi+PM3E5zZgzla1w/ZI7Y5b/xGhzmvFVoDmX1es2gBlDqsg209QC2+P4QytP3mIUz5hlprCzCZz8PIS5EsajLhFZARpxxSHA2ugEI+Lh/xaAywKw1Dv//wnTiggWC+E1fsVOaIPA1/YxMGMVCga+tmbD6wNkJIQP5Jrc05om8mU3hYU8/o86x6wDWYOV9/AHAuEhJdR1xttk+rOvhQG5rLU3FWp5dDlQBbUMue3xffdxJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j+w8vGjoGfP7bsDp14TELbkCMzkaXCVc/onZ7s43YWk=;
 b=zUAdbE7Cui+RTBkLIZeXXELGY+0huMHLTi96LurqVOWwe5AnH6RoFZIArs595k1pbht2S1kgF5tN9P1tGlWUtYQnXcY2ukWdBUuPjxuuZfVSQL9fxSEBXwePdauF7O3TbAMuG9IsyChUYL7Esq3u9mwSfLKhfP+ZsQNHorTBouW76kxcIKqgSE9mDbqkr94RFI+/QvBORk9YoT+cBRNga1HRH6/oCg7tcQP6MkxaRqdyoyytK22oEtfihbP3+HQVe15zcDzu4irUE7JHWiX7GbxBTRw4MsZyQPhPIzNVIHEeW9g4uSo1JnDKcxI82NX7RaqmW7yofKyK2jrEdi90kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
 by TYZPR03MB7517.apcprd03.prod.outlook.com (2603:1096:400:41c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Mon, 7 Apr
 2025 02:05:30 +0000
Received: from SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749]) by SEZPR03MB7472.apcprd03.prod.outlook.com
 ([fe80::914c:d8f6:2700:2749%4]) with mapi id 15.20.8606.027; Mon, 7 Apr 2025
 02:05:29 +0000
Message-ID: <bfb733a1-b39a-4a33-bd3a-aa9d25339cc1@amlogic.com>
Date: Mon, 7 Apr 2025 10:05:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v2] bass: Set the service connection flag when
 BASS connected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250403-bass-v2-1-7925bb16468a@amlogic.com>
 <CABBYNZKW23-P_8OZGTz-bQ2b2vZX_SbxA_hEJ=BAbk6Bkmwsrw@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZKW23-P_8OZGTz-bQ2b2vZX_SbxA_hEJ=BAbk6Bkmwsrw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To SEZPR03MB7472.apcprd03.prod.outlook.com (2603:1096:101:12b::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR03MB7472:EE_|TYZPR03MB7517:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cd046a-565c-4ec3-322b-08dd7578ab31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2YzUU9xNzhVSWJFeER1eXAvTWQvdkxybjdyVFFzVEtjNzBVNTRTcE1Ickht?=
 =?utf-8?B?UDBFRStzU1J4Tk1CMmxYWkRqNCtyaFpZNmthc0lSeUtETVJZMVNaVzNicTF3?=
 =?utf-8?B?aWhvSjl4K2NNU0MzQTdxSXh0OEszNzZKUyt6WTl2bzgrMDlVb083N1JxL01n?=
 =?utf-8?B?TGRpd1F0dkhMNjNxQWJicVhOWWNlSjJadEdQU3BYUDlOblBIQTk3dmJPcmtE?=
 =?utf-8?B?SXIzOHFXemw0bHFuQkhGVjdCRXhhU0NvWFA5MVlRdEJqMk9IVWFiMzlzZ2M5?=
 =?utf-8?B?Tkg1eFJucERlUXNTVDd5SEF2ZzZ3VDdxTTdtUEJHbml6enBnZUpLSWFmdGNH?=
 =?utf-8?B?STRmQjlHVm1sei9UOGxEaEw5S1FONWN5YlpYb0xPWVBPR2RIUkVmRXhXZ2tP?=
 =?utf-8?B?ZDMzT2RRUG9WQTBOSXpBeVVETVVVQ3gxQ3Y4TUZNMnFKUzNoaGc3aVY0allS?=
 =?utf-8?B?M2RBNWpybDkzY0hFTGZoWWRFOUdocVZuOXZiZDJYdXlHSnZaUGN5dFNDRndB?=
 =?utf-8?B?alNDRmNBaDRQZUNRTjcrMDhJelUzaktMeTJjVDFuL0RvU0NEK3hCVldlZkN1?=
 =?utf-8?B?KzZoWFNQVjJYRVhHSUdhZ2JzRVpxcnU2RDRuWmx2cHBEM2x0TG9JMEdUQVhv?=
 =?utf-8?B?T3ZiUzA3eG9KSElqbkVkWVFvWG9YRkp2cldLcU1RSDF0UE51dmgwQkFTc1VT?=
 =?utf-8?B?S0lYcm5FSzZPQVlnd1Ric01lVkZZQnZ6R2labzN6bEwyaEtySEJrdmlwMkl3?=
 =?utf-8?B?K0ZmLzBIWEZuN3lPVXpFOTlnbUZkdWdjRWN2aHZFWGhyYkxybXIwRzhxMXM0?=
 =?utf-8?B?aE11TWJNQ2pYY25qNjluY2lpTHYvYU1tUTdXazZXUlA5dGFiSlNhNkZRSHJI?=
 =?utf-8?B?TWVkaExGMGJzNDkwMnlHNEZTdGs5MitoZ3hqbmZkWHlBdGF0NjYwNU1DSDhp?=
 =?utf-8?B?TXVsQ0k1LzVWNllsWVBRQjNxYit6MjhodHZicDlGcjdpMklhb3lSd3VuVTIz?=
 =?utf-8?B?RjVIVzdzcEgyQXI0YU1PVjhIc1JjUEgxbGtGMUIwZ3hQSkhWTkFTcHNSLy83?=
 =?utf-8?B?Tzl2RUl5NWVpcG8wWlNLN0c2eDJpaEhEc214UzlNdWV0TVJBeGtHRUpIR3dB?=
 =?utf-8?B?bW4yRmJUemFFb3Q1cktJTDZSUEJOS0cvZ0FMK3QzZ1BqdHVnN09BTDFzM0lR?=
 =?utf-8?B?K09Zd3k0bzdKbVNwMDB4djduZDd3dkFnZ2JjaTZXZWkvamlOcnFtb29OTXcy?=
 =?utf-8?B?eWRXRlRDOHBCMHhvMjJZSUNBZEYvNlRyM3AzZVFQWEtobjNuYXowVTFsdUlj?=
 =?utf-8?B?UVRaaHFpY0Y3RmhVak80NmoxY0V4ZWszeDdQY0RtdmMrSVo5SE1FZDc3UVVj?=
 =?utf-8?B?RllBRkZZeGNGbml3RHlwbXRha3V4a1NsZTFZQ1hUck16L1RxblNpdUEvbzNr?=
 =?utf-8?B?c2hkNis4S0R1SVdEaFFnNTQ3NTV1Y0tBRGtNb2ZQY0x2QWo0VFI3UmtJVkI1?=
 =?utf-8?B?VzNwODdYYU5HT0s4Tzh4RVU3ekxSQkkyVEF0R0NYTVB5WEY2U1hMQnBTMGR4?=
 =?utf-8?B?MWJKNUZoYWthTE5ZaXNmWHhoNXlIdG40WDVOdWNZZ0ZYdE8rVUFwdG04bXN5?=
 =?utf-8?B?OTNvMUFCY1RWY0R5aHk1VXVkVzhRRWdmRWtOeDBPc09kTVZ1dnhMWm9uWXl0?=
 =?utf-8?B?ZFp0cmtTWWlHV3Q2N1BTTWROcDlEeFdHdjUvSUQ4dW1nU3BKWE5nMEVDQk1z?=
 =?utf-8?B?RVBZUzdjZ2RmTHltOWY4SS9wLzJrdmZsMmJaWEU0TlptWVlmNTdOalZRdFdX?=
 =?utf-8?Q?B0+GdObOtTNsQoI9LzxH4YFK8TShWwONkFlls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7472.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzRIaGZwc0xIejdSaThrRGxMVWJweVlxQXZGNGtNYjVDOENQMVludlpEbkx6?=
 =?utf-8?B?ZVVSekdTWHVBRUh0ZXBaMzcwTGYxbnR6dFpsL3BhUWlseG5oa3U3VjVURGFl?=
 =?utf-8?B?VTNGQXhrWVlKbnlXVjQ0cGxiR2V5dTEwd0JHcWZ1MUd2U1F0NEYyWTFXREdR?=
 =?utf-8?B?eFFVVUFMVHA4ZlJUa3g3aU5HS0ZhS3RPdGdRWVNHUmNsQUJnaFZHVkVzMWdE?=
 =?utf-8?B?Qjd1R084M1paOGdwTDd3VTBxbkpkdFpiUi9TdzZBcnAzaWM2U1NwbmxnQ3Rs?=
 =?utf-8?B?ZS9GaDE5ZXozNngzUUE3MlVBZW1QcmR2eTFoZ1BpK2c0RkZ0cW43dVhKQ3Bz?=
 =?utf-8?B?NFVMU1hFSzdzeUNtSXlWMm5ZdFpWYkFrN2RzM3ZVSnhNeURmeVVhSHdZamdD?=
 =?utf-8?B?enpPYTdEZ0VsVlJ3bk1KeDVEZGpkeHo2Q3FibzVud1BRV2JmaEErL3pLdkY4?=
 =?utf-8?B?cDYwR2hXWTI2UUtvNjBEV0k5OTdLcGNLajMxVVMrR3d6WkIyc2RmdjVhR2xF?=
 =?utf-8?B?Yk5SallCRnJHVm5FRUxDZWpEell5R1NtT2JWNXpVeTNITDVLZWg3V0ZlKzd1?=
 =?utf-8?B?R3kwSDM4Y25WVkI3ZEh5UzhqRC9tUlhLeGpPcjlLQVFDSTE1S3A3WURNWjU5?=
 =?utf-8?B?dGZOdlc4OUl3TTVGM1NKYTNIK2UwTllOUXhWaDRVVTZNYVFXRFlKaGl1Nmh2?=
 =?utf-8?B?WmJ0WlVXaXV2Rld3Z20vTFMyQktDNE9VNTI4M3l6Mzc2VGU3YUFldXNsZWht?=
 =?utf-8?B?N1ExRzRBOVkvdkFlaEZuaGpOS0dZVXBKV1JmalFkRXcxUGpCbEU2Wjg4R29l?=
 =?utf-8?B?eHUrck1ZU1VJUmZDTFFOL1UvNEFhSmh4UmpPYmtBdGUrSG53WUs5SU9ZcnJV?=
 =?utf-8?B?R3M2ZWU0UzhiRUR3bUlRYy9BbVZPcmYrUUlhVVlaRUpacXd0eWx5Uzh4Y2Q0?=
 =?utf-8?B?NHg1anFFbklrTmxKSWZobnZnRm8xUTd3WlppVHVKVC9mT2U5VGc5ZTQxZHNy?=
 =?utf-8?B?OWk5MGZwZWE0OE9taGVXalFHY0pmeXFUdFdhZk9qMkxIZUJaNVJFT2tKKzFi?=
 =?utf-8?B?TXJCSDBKT2s0bzBIQTR0eXpVMnJEVldndk1UOFYvYmxaWDZBSnh4SXJaSWhV?=
 =?utf-8?B?MWtDWmdTMnAvVlptN1JaZHhnWlI0YnVISnY5WnA0aXpFU3hyMDdtT3ZEVlQx?=
 =?utf-8?B?WS9zdWF3U0RNL3B6QlBJTHVPalJIbWN2Z090ZFFvd2dGQTljbkRSenBENHE5?=
 =?utf-8?B?MFlmWUc2cDJwZ0NGUnNoRXZCKy8zLytoZTVGRnUva1l6QWI1NGJsSHFNQjc1?=
 =?utf-8?B?a3FxankyQWRUNWw1Wnc3cWJQOW1lVWwrYXJ0UmJqekxwMjRtaWlseHM2bHZG?=
 =?utf-8?B?emlkOEROaU1PTDd3cWVQSlZQVk0yUVlaajMrWjZkQWhFSWdLOVUwcW1vSG95?=
 =?utf-8?B?NlVTMFRaV0d4dnNPQjA1RDg3VTlBNFFuQ3JHa200TWZzUlpvWHVJdVhETktC?=
 =?utf-8?B?NnlodlhodWx4NVQzR0gydHZQR09ZSzZBdWxITktJQTF3dkEzRVE3anZlcFFG?=
 =?utf-8?B?dHVJUEwrUlo5eHdEOGUwUXpmNXZSYzZZWjlDLzRoSlNIanNod1pZZytRUjZ6?=
 =?utf-8?B?MGpKTTJoTXZxaU5MMnBrcDUvUjl2U0lzV1FtSzF0SlVhcjZkaTczcUJvemcz?=
 =?utf-8?B?bG5mek0zVm01KytJaDIvazVsMkdXOTJCWVl5YjhLZnluQXdMekhmVHJ2cHRz?=
 =?utf-8?B?d0p6WG9saVY2c2pndzJqRnJWUVFMcHE2YmgxUzArUEVVcXdHYjJvZ1FUSXRa?=
 =?utf-8?B?SStqcWI2RDFhZCtmUFFYUS9zYUI4ckd4L2ZkOENFMFAyaElraFo3ZE5mb2NF?=
 =?utf-8?B?THBUVFBnRUxiVDFhRjJ0QXdSd04xdldSL1E0RGVWM3NRaVJOVGJyK29pV2JZ?=
 =?utf-8?B?OHh1OHk4K0pDaTNvMHBkVWNkTHpMK1U5QmFOV2FNVHo5a0VSUmhiZjlhSG1p?=
 =?utf-8?B?RmNqU1VFVkZUWVA1WWFiQ0ZhaHRzbHY2aWVRZlcydmF1azVVQjUrUXZRVm9D?=
 =?utf-8?B?aGZzd292YXF5OWRNdFlBUnNHekxvNmZXYkFKUUpVWGdVejVYZ3JRd3hidDBJ?=
 =?utf-8?Q?wY7FIu2gUi/NqpG6q3QbSGYsD?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cd046a-565c-4ec3-322b-08dd7578ab31
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7472.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 02:05:29.0218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+sOqrOLrRSxdxska+yUpC7pvKB7WbnT08g1I1dosqUU+p2D+4G3tRbOGCtBwjt0FJTtxfEIox8RnzQvps6dlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB7517

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Wed, Apr 2, 2025 at 11:37 PM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When BASS serice connected, set the service states to
>> BTD_SERVICE_STATE_CONNECTED. Otherwise, the device will
>> timeout and be removed, triggering the automatic termination
>>   of BIG.
>>
>> issue: https://github.com/bluez/bluez/issues/1144
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v2:
>> - Set the BASS service connection success flag in the connect_cb function.
>> - Link to v1: https://patch.msgid.link/20250402-bass-v1-1-3e753841faa5@amlogic.com
>> ---
>>   profiles/audio/bass.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/profiles/audio/bass.c b/profiles/audio/bass.c
>> index c36f43277..c28d9d1ad 100644
>> --- a/profiles/audio/bass.c
>> +++ b/profiles/audio/bass.c
>> @@ -321,6 +321,8 @@ static void connect_cb(GIOChannel *io, GError *err, void *user_data)
>>          if (bt_bap_stream_set_io(stream, fd)) {
>>                  g_io_channel_set_close_on_unref(io, FALSE);
>>          }
>> +
>> +       btd_service_connecting_complete(setup->dg->service, 0);
> Ok, do we mark it as disconnected when the BIS is disconnected?

Yes, the service will be marked as disconnected after the BASS service 
is disconnected.

static int bass_disconnect(struct btd_service *service)
{
     ......
     btd_service_disconnecting_complete(service, 0);

     return 0;
}

> In
> case we are acting as assistante then there is probably no reason to
> keep the device object around after it has been pushed to the remote
> sink.
I don't think so. As an Assistant, the mobile phone needs to record the 
source information configured for the BIS sink. The record of the source 
device will only be cleared when the BIS source is removed.
>>   }
>>
>>   static bool link_enabled(const void *data, const void *match_data)
>>
>> ---
>> base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
>> change-id: 20250402-bass-66200bb7eba1
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
