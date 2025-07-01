Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022113.outbound.protection.outlook.com [40.107.75.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39125DDBC
	for <linux-bluetooth@vger.kernel.org>; Tue,  1 Jul 2025 02:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751337447; cv=fail; b=dmbG0HvXxddqILUxnGTf8XzPJ20bB3LXF9ZE/I1CYbjTI5DEVnREA2XjCuxq2+lhchY+8HZvV1ZZFgH9gl+P8F3jCkUnMImGCmVH9Y+tX0rboKOMBa9XxSuPyJddfIGROqCAcIQKwMiUC6bDzBSSncfUEN6atnjac2geFiQvCyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751337447; c=relaxed/simple;
	bh=jzgUGgoS5I4ojrKN4KAqUmbEwRqmrGeyHeP0y8K32u0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=joQ3RLAP+CHMekIakoqB5EdliWJcwN0qPIRcrxP5VSvAA7HaAcqpfkcxVgP0hwjUsWvC5zY5KmuPXPWwpxTkjJEIXRmACdonm/e5WIY3a1g4Ww5kyI7KQNf02i5Z3aeMM+eN6EmseUnnDwuVzKYu729KvMkI6Ny0lyMZF2xKj7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=ZJ8ja9aN; arc=fail smtp.client-ip=40.107.75.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="ZJ8ja9aN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ysLdZUFkCaSt8R6zCFq+MIeacT6RsXsmGD3UWU2rRlrkuD284nzjduBwyKJQ9noxTThCFqccI8e5dmfSgvWNod+B4MA9fXvkAyPIczz2i0Y06+OkdmSMfaMItzyFQTaSuVcORAaR7ysQeF+DFuCai86oksuVbWRq1PxJ18qm7wUAjArLanbu0ul0bLjstPsgU8V/9Tu+KZ+Fqy6aJIh1ZNA9i/4dhj9nXEmtgbv4s/GVYjItjbnWZB56duu9qFtVMORPWEEp8QZwmOdZuXgR+Meak/+L3eeWd4WbPHKscmWsrb67krbIxEQ3S56t3x3NiUgI4HglHWIg7qK7Jzr7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ua8g7mJWWOBUn3yf2WFqdbQ3XrY2VyLQy0YH93d39pM=;
 b=VjmUpQa8NGBCPQy6Xd1OkF18BGhk3BZRs5lZ8VzrhAnYLKta0bqYuStbB/leQBriGmXeRhAiwKhALUZ7YKYqj5dlKTcAvCoSQz5syo8VPwQF2TMVaYC+30D+PB/hPnDEO+/VkZlPkG2KhvdN/6H/ivxlU7V9JgKKNCKK5/LWxcPf3JVJvYMlon0v5QZ221a7K0aUeLWAQM8OF/siINITGbB0SohpNM60dqbWL0GxR19mLWSAFCY8y6qPhMFO0zxQqoBdFWwmfoUpFHUGCS3bKwc+krA4TR2ljp9AdFXzxSzuv4c78Hm2TThG7SmYIQsPcID0kG3fOIATnT7Rxykzlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ua8g7mJWWOBUn3yf2WFqdbQ3XrY2VyLQy0YH93d39pM=;
 b=ZJ8ja9aNpmT5FT4tA1FYxq7Dp3t8L3tzrf0SkA1wfedx6yNxppSBsA7neqmZA1897PXvEvqaqRmaRsBmDJut0Gos8+uZ89SBxEhmcv7vBXsb66M7TBA0H0naKoyjTVcj+yvExK9+y+bzjBglEMhG71rzrDBPCdk2JwyNou/MptV44Yv/+7Mu4ymhZNU/HOlPfgQaHrNC4H2WN3tfx4xSbyAgWS2JwII6T4NZxbFTkRbrrwM9k2tJzNdW7U8LAGQzqkFwW8FsR1vZMnoLAcwr87jaUafaoLZuvHgS9cwThiWzEh8N4tVHAU06qBH2lW6wLWmibT2FrmCQPaIbwJ+mjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by TYSPR03MB8542.apcprd03.prod.outlook.com (2603:1096:405:5a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 02:37:21 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Tue, 1 Jul 2025
 02:37:21 +0000
Message-ID: <8f2f482a-d612-440f-837f-49c97127d64d@amlogic.com>
Date: Tue, 1 Jul 2025 10:36:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v2 2/2] shared/bap: Add stream state check in
 stream_disable
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com>
 <20250630-bap_for_big_sync_lost-v2-2-1491b608cda5@amlogic.com>
 <CABBYNZLA3KqrTHXkHnDM=63E1t7Y=CEbJ2hBeJEXQkFOd3wMeQ@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZLA3KqrTHXkHnDM=63E1t7Y=CEbJ2hBeJEXQkFOd3wMeQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|TYSPR03MB8542:EE_
X-MS-Office365-Filtering-Correlation-Id: b28cee3e-01cf-4dfd-7536-08ddb848341a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckJuaXM0MU84TGlOcm5SZi9uQm1qQmNsZkcvTEpod0Frdkx3NUlqelEvQnBY?=
 =?utf-8?B?ZmtlWmRyL0tLakdvRmxHR2duYmdUUnNNZDVIMENoeE9wZVJnZHExR0tFVkJI?=
 =?utf-8?B?UStjTXh2clJIU282VzNsM3dBQjMzU1pLbjlWb09VU0pvNGdwcUVVRXI3UVdZ?=
 =?utf-8?B?c3JvMERXZHlrcjNOMGNBRkozMkJoUmVxeFE5SjYrbFdhU0pqTkw3Y210RDdO?=
 =?utf-8?B?VzAwd29DcDl5bGw1M0tOckF4WjNIZG90ckVDRStjY01Ca1Q4QnRFQjZ0aDh3?=
 =?utf-8?B?aVJrMUV5MEwwYkRIR0lnVlYxVnZXRlR3TTlZejdqUXE1emxWVDBUS29MWkw1?=
 =?utf-8?B?eXBRQlpNQzgxSGZoUmZmN1I4YXRwc0daYVRwc1pBdWtWQ3l3VXVXTEhMeGFL?=
 =?utf-8?B?S1J2SHNiNE14T01uOENubmtyVkJ3dWZKM3g5Z3RxdlowQU4wSitZdHdCZ3d4?=
 =?utf-8?B?OU5nZXVxWTFKbm15eXFFSnA3dU5MVzlQazREb2doRVU3SXdCRTViTlRiM1Yy?=
 =?utf-8?B?SE0rVkVZa0wrbldSSmNIaFZ0RWFRbnZvVzEvWFg4ZkxUODFiVWRWT2FtbWZ5?=
 =?utf-8?B?ek1nczNCRzZlT0F3Sk8rZ1dOYklNc0RQUFRCZVVHbWxWNVc5d2dFTG1mNlI2?=
 =?utf-8?B?YitydFU3ZmpQdEg5SmUrdlFkZCtORTJ6aHQ2OCtzaURORWNNaTJuOUljRlZ2?=
 =?utf-8?B?d0NmaWN3N0lwSnBCL1oyVGpWUXl3Tmx0ZHFjQUk1NTM0MkpQYVptSmNlNm1p?=
 =?utf-8?B?T0hHNmFmbjhPckNWRnZPYjJNRE1TRWdyZU94S3hWMEE5SngyRVY5OWFlVEtP?=
 =?utf-8?B?UnJWOTNpQmx3eVNxWitobGZRWGhRSlR2Q3A3b1ltVTJRUXVYaVJyRkRLUjVk?=
 =?utf-8?B?NDJmMmNEelIyTmthZjRnOTByQmdhSzlQektWWnZsSzRlcGZWbHczb21RdWNH?=
 =?utf-8?B?ejJKTHhUemNjSm56cnNwSEJHaGR2RjBuVXhKOVN5b3FodkNkMmZZT0F3NDcz?=
 =?utf-8?B?SE9KdFRENXgxNzFCeER1WFlVR3NRL2xDQ0dUcGdpQVlMS1BydXBMT3RpWnZ0?=
 =?utf-8?B?WmxZWXZyTGo2ek1MMGVGVmwvZmRFRklpRlVFbGhYWm5YcGhsVTdCODFtV1po?=
 =?utf-8?B?UVdTcDN5bC9XRmxkcC9PMDNYR1daVnBwTDNXNVVDczEwZHNLeFVPWjVWMjc4?=
 =?utf-8?B?b2Njd3F2eHluZTBSSm8wK0gwV0hTRFJ6V1FweDVXV2ZHUFhhRHhVZXA3S1dD?=
 =?utf-8?B?STdvWUpVeHZKS3AxUUR1YVZ6OVV4WGdNRFZuSU1EemdpV2w4bmUvcWNselFB?=
 =?utf-8?B?dFpYU0Nac3pQeU9xemJmSDBxbDNjdkxvZHk2VXczRGdVdTFFbE1YWkhUbXJ4?=
 =?utf-8?B?ejlEYUtUbkVBMi9QWEpKUFN4dEFwMDNnM2hMYmZKSkRSQXVtTHBhNVYzZ0xr?=
 =?utf-8?B?UEljUnpjR0xDR2dmTzFXdHAxdUZVYmRPRGNiQ1NkMEZ6VWIxUjFOYllZOCtt?=
 =?utf-8?B?WFZPUCtwdEV6eWNwWFc1NllSb2x5REFjd01YZldyZGV1R1dPYWRVUUMvc1ZB?=
 =?utf-8?B?MWZ6bHlKK05hWk05Qm5hUy9CR2R3SVFJdlNaVFVRd2dhRWRCVGEwWmQ3dHFK?=
 =?utf-8?B?MGFOSkJxM0NXU01tdzhjZWMxNS9pdDFnSU1Cb0w5RXBVWVJaeWlNM21NQ3Nx?=
 =?utf-8?B?Z3dQdmhzTVN4aDZ3cHVTelNETnI4QjI5V0hJeUwwRFRBL1hLb1llb0ZHQ2pu?=
 =?utf-8?B?U3kwNmhJYnRKc3JNRlZMRFg4ZzZ6NzU4SVJIK0ZNdTZGSksyclBNa1Ard3lm?=
 =?utf-8?B?b3BkTE9KdlE4UTBLU2RzcHRoYkQ3Mng2WnpCOFM2cmk4Y2xkbXdEU2hzQW9C?=
 =?utf-8?B?ZHh5OWJuQzF5akwveWtLNy9tRkkzY0JQS0IxdUpYVUZUNTM1UVJMSFBqeXlG?=
 =?utf-8?Q?5+HbtiYSVYA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZHZjOWt6bEpMUzdIM2h1UnMxcm1sSkNUY1pMSnJDUWRWOVE5Vi80anorU3VO?=
 =?utf-8?B?TTN3djJ0eDhISVBPYkVxZ0h3eXZva0JzWEorejlMNjFnUHFNMDBraFFoQkx4?=
 =?utf-8?B?diswbDY2TTZ2RFF2OUdaU3dFOGt5NUhNemsxOHB4UXM1Rm5ueVUxZWU2cEU0?=
 =?utf-8?B?RU9GWHVyR01QZ2lacDBEcHp4QXU0RVF3VTlwbEpmYThPNTMweWNlL091bDJi?=
 =?utf-8?B?SGh6ekhRN0NQak9uelpVb3B6MzB6a2gyWGNEM1NLWjVIbVRYQUIyL25WTk9x?=
 =?utf-8?B?cHMrR2k0RFZqQSs2RVRCb0tjWUE1TXVTQXJjVDRLU0ZScklNNXZmYU5BZVM4?=
 =?utf-8?B?akdaY2l4MjdaT1R6d3ZhWUV2bHJyTlFPSWg3MlQzUEZkdnlTNndRSXAxYUpL?=
 =?utf-8?B?QjFXSFl0WHhldnBtL2NidEdVRHYwSFVZZEp6Z3lWWTFKeVF4bG10UkRnbmtZ?=
 =?utf-8?B?VUtWY3h0ZVRYS1dSVjNTc3E2dFhGNExGSGQzWitEZzducW5vYWEyUUxWOS9V?=
 =?utf-8?B?d016NDY5ZmhvS00zWTVPb1BDQkNoeCtZK3pza0lPS2pXU2daNTdxMTlOYmxX?=
 =?utf-8?B?N2ZjYVNuTTVib1Qyai9sN2czajNzUndzTDAzZjZDWXhTSXBaQkV3U01LaVF6?=
 =?utf-8?B?UTVXNC9MVjNod29nRnhrbkQ4bE5IM2R5OUw0b00rbHZ5ekZTM1hBKzEwRGtv?=
 =?utf-8?B?OTdncmxaSktwdWc1NlVuRFI0U0JkYnMrdndPMVBxVWxDTjN2WVpFcFE0bElK?=
 =?utf-8?B?Ykd0bEVnbGVucVVDa3h2QWhoUlk4WFNwNEh1bDIzN2REb0J3RTBoaTdoVDRt?=
 =?utf-8?B?WXBKSElncWVtRVBWb0tXVXVGZFVxY1RoeDRZdGVyeTN4bVl0WTZMdlNhVWE2?=
 =?utf-8?B?Skt1MXAzM1JiNWJoNUNEdGhyc3Q2TmZpczNmYWNOaGg1V1VOWmdhOHBxdGZI?=
 =?utf-8?B?ajdQSktVcmpidlhRQkNRY1Nsbi81OEYrYTBGZTFTRzZ3YW5OWk5LdHQxdlh1?=
 =?utf-8?B?TGNSYTJOSkk1eisxY0dCRnppYWZYbEx3bmFQRmxMSDJSRWhYYkxhVEkycXBU?=
 =?utf-8?B?SUFJaWFUam9ibkJXSkRabzQ1VldmamNYMyt0Q0RkdmovQUtlanYyOHgwNWNE?=
 =?utf-8?B?S3QvVENUNzhzSmxyT2IxVUJnaWtaam5IekpzMTNtaGRHeG83NmUySmt5ZXgy?=
 =?utf-8?B?K3dubitwbUpTa09uWTJ1bCsyMnMwcUszZU9yV3lQa3E5SlVIR29QeUZMVDdB?=
 =?utf-8?B?UW1YakZjd295N1NZSWhneUVUbUVIdXorUmhybStENitiZ0F0Q3M5UWJRTlVM?=
 =?utf-8?B?bVNRMTVCY2l5d29Xbi9MZ3Axckp0bEVnNkpRQ1YwN29iV0EycG1UL3pUQk1q?=
 =?utf-8?B?NERaSFZlVWRGWEtVRENlNDlCMmI2ZHY4REZvVmZmNWFUTlZ5ZGEzaGVZc05N?=
 =?utf-8?B?bnVaNytXOGYrcnlpNEhwWUlwUGtyUEhQZnFwL2FYR0dNNmtKYWNQU05LRVhh?=
 =?utf-8?B?TjB6eTRmT09rUDI4MzBUNkJxUVlWTnNpNm5HT2xoVjlqOC9HWlBPUnhaOXda?=
 =?utf-8?B?RDJZU1BHd25rV0ZSS1M2M2JYbFdLSGI1ZlVOL3EzeXJRSFlIbHNVOXQyM2tE?=
 =?utf-8?B?RVZ6dFlxRDBPZ0pTVTI5M3RWWHB3Z0xjNWMvNTN3VlB6M0tEam9VRzNXNmwx?=
 =?utf-8?B?S0F3cGdHRWdNWmVIMmptQWlEdDRidkczRXM3NitZRXZTZVl3ZUliZDBRZXpq?=
 =?utf-8?B?S1p1UGI4Sis4R0dHZ1ozSGFmUDFpUXBiY2o5VWZvMFFKeFBzWWtCakY0Ym4r?=
 =?utf-8?B?K0U5aDIxd3duTFVwNTYzRXAxcFYzTEozMmZkUHc3SjFOdXpINXBpbFBkV2ZX?=
 =?utf-8?B?emRxZUZOU3NZNkhEcDZwSjROUXhPNnIvbHM3d1JyS0N2cHYzY3ZwZC94N2RM?=
 =?utf-8?B?OGx1ZDNvNldzc2loRVhHUjhrUGhrSlJnYTI5dU9lYnZlWTBtc3lveEFOSnc0?=
 =?utf-8?B?YUptZXJXbWdwNFRmUjRSVThLUHd4WElxKzBDdU1BRUxhRnFOV21TZjRWczNQ?=
 =?utf-8?B?Z2ZVQmJTRnZhbHE4bGhyMGJrZ3RzalFsY0ozdmdLb3c5WWp2UjNNYXJNcHUx?=
 =?utf-8?Q?PNEt0Tmva0CQTXnwQtO3MRx+b?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28cee3e-01cf-4dfd-7536-08ddb848341a
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 02:37:20.9304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGuaoFCFtsGLBuEiqfA1VTU1gSjQECiRHIeIml+0wHi/oDvDCAqIaw2xI0CyJOdK37tLtXw6hVnb4eamkKXDDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB8542

Hi Luzi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Mon, Jun 30, 2025 at 4:04 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> Add a state check so that stream_disable() is a no-op when the stream
>> is not in ENABLING or STREAMING state. This prevents unexpected state
>> transitions or redundant operations during cleanup.
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   src/shared/bap.c | 8 ++++++--
>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index 984ae782d..5445ddd14 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -2134,10 +2134,14 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
>>          /* Sink can autonomously transit to QOS while source needs to go to
>>           * Disabling until BT_ASCS_STOP is received.
>>           */
>> -       if (stream->ep->dir == BT_BAP_SINK)
>> +       if (stream->ep->dir == BT_BAP_SINK &&
>> +          (stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
>> +           stream->ep->state == BT_ASCS_ASE_STATE_STREAMING))
>>                  stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>>
>> -       if (stream->ep->dir == BT_BAP_SOURCE)
>> +       if (stream->ep->dir == BT_BAP_SOURCE &&
>> +          (stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
>> +           stream->ep->state == BT_ASCS_ASE_STATE_STREAMING))
>>                  stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>>
>>          return 0;
> Well we are doing:
>
>      if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
>              stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
>          return 0;
>
> And on ep_disable we have:
>
>      switch (ep->state) {
>      /* Valid only if ASE_State field = 0x03 (Enabling) */
>      case BT_ASCS_ASE_STATE_ENABLING:
>       /* or 0x04 (Streaming) */
>      case BT_ASCS_ASE_STATE_STREAMING:
>          break;
>      default:
>          DBG(stream->bap, "Invalid state %s",
>                  bt_bap_stream_statestr(ep->state));
>          ascs_ase_rsp_add(rsp, ep->id,
>                  BT_ASCS_RSP_INVALID_ASE_STATE,
>                  BT_ASCS_REASON_NONE);
>          return 0;
>      }
>
> Perhaps on bap_ucast_disable we shall actually call ep_disale rather
> than stream disable directly, that said I wonder why stream_disable
> change is suggested here since you were attempting to fix broadcast
> and for the likes of bt_bap_stream_disable it shall result in
> bap_bcast_disable which doesn't call stream_disable:
>
> static unsigned int bap_bcast_disable(struct bt_bap_stream *stream,
>                      bool disable_links,
>                      bt_bap_stream_func_t func,
>                      void *user_data)
> {
>      bap_stream_io_detach(stream);
>      stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>
>      return 1;
> }


This patch addresses an issue where, after the CIS link is disconnected, 
the ASE state incorrectly transitions from config to QoS, which can 
cause the CIS client to behave unexpectedly. Detailed discussion can be 
found below:

https://lore.kernel.org/all/3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi/

Alternatively, the patch can be refined as follows:

@@ -2131,14 +2131,20 @@ static uint8_t stream_disable(struct 
bt_bap_stream *stream, struct iovec *rsp)

         ascs_ase_rsp_success(rsp, stream->ep->id);

-       /* Sink can autonomously transit to QOS while source needs to go to
-        * Disabling until BT_ASCS_STOP is received.
-        */
-       if (stream->ep->dir == BT_BAP_SINK)
-               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
-
-       if (stream->ep->dir == BT_BAP_SOURCE)
-               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
+       switch (stream->ep->state) {
+               case BT_ASCS_ASE_STATE_ENABLING:
+               case BT_ASCS_ASE_STATE_STREAMING:
+                       if (stream->ep->dir == BT_BAP_SINK)
+                               stream_set_state(stream, 
BT_BAP_STREAM_STATE_QOS);
+                       else if (stream->ep->dir == BT_BAP_SOURCE)
+                               /* Sink can autonomously transit to QOS 
while source needs to go to
+                               * Disabling until BT_ASCS_STOP is received.
+                               */
+                               stream_set_state(stream, 
BT_BAP_STREAM_STATE_DISABLING);
+                       break;
+               default:
+                       break;
+       }

         return 0;
  }

>> --
>> 2.42.0
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
