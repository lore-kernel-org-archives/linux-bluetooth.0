Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022134.outbound.protection.outlook.com [40.107.75.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA838F5B
	for <linux-bluetooth@vger.kernel.org>; Fri,  4 Jul 2025 01:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751591820; cv=fail; b=ghK99P4scEOmXh2+CXsY0tji5wYY25tEvb+EpHzg+7zk/tZShNkzVu+HzSyrikyVXDCi6nePsAFxZKdUdzpc3fLyqQl4duGPvoRoAsReZLclh2jDCW4z4itDzwQppU00rjSYDoqy739y8+wSgZzgj3HLGNho1YaW4NDR1VwSMVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751591820; c=relaxed/simple;
	bh=ckAnbuXNwI8NjP8EICXFIwA5co2GMcmIjS07M6+oZOc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GFLo0O8QvDniE8lbANKftxIHud8plWIR0za2D6c+YRoqSRi8vbBJuSWUumi4Flg/1KxEAeKjBA6K0C5GnouUlmk4Vj9xk8gqxmPAcli0Rkvs1JG9BCilmGJIh7oCD5cyGaMFyQITBc53GMyvXDW+vk255DG3Wyd58UOkL4jJRRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=xWW0lsEv; arc=fail smtp.client-ip=40.107.75.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="xWW0lsEv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niXptY0soy7U6KVoas4jWoT4dOu7+cGm8HmDeN3qHLk5YXpM6GN+jQSmgt+sUCkaOAlguhw+vGR7FUOlgK7fJrI3UZSEaB8CKsgWeMg0XEE6N5C7h5zcd8u3Lgm9fslE+3V6Bbzw9cUjCMGD0uuhL4fmCsLs1goJhHymU2HztuQuKliL6eZjPIcew14niSGxaWikQ0DQ4ubmCNCKCMzhuMoDqCZIbrqVR3egbuGDcqYXuDux3P0lOs3CpjXxJRfJA3YL3Jzk3Fyq1bhgyMoWmcnm1ptbbE2tkEhMaQzYQbyYrOjyz3yiLSYlLSmOUFB08we7xWbQ54yGoPNQ2p7AFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hDxCTE5t44QJaN9U6pFvxz4aQUw4TKb3U5zwFKpFRls=;
 b=MB+SllK1ZU4jCxB9Dj8gcl+xE4mfrvyeV3lkbw+N9DL+lwZejJQT9t+LmXbFAImVCTX64jNYczihHhhKquhX+6GVpErrehVJ1nQRaCjb5qa0qHHWg3dHzd3oRNWHGfKi1I0rNZYYWbjDRJj/roF4oyerk0ELqvEoP67GOf4Ir0ByPfZ8I+HBGGjTuc4wZLT2h/oEchONgQGSIfJD3UxaJmiYiTw2+n5q8sLxwm/DO4HlB9JL9M41hZl8LZK/7VRtHuDYVPDJmYg/6EfFS0Nvw0PyovvwRKZb1u5CIkeAhl68zDgS6Dozpdq4MM3Ew3R3A1IVycmWJqiGz71MBavO+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hDxCTE5t44QJaN9U6pFvxz4aQUw4TKb3U5zwFKpFRls=;
 b=xWW0lsEv2dy3/K5uA/34nQuQOec5ZXWb1lal+MLoY3oJStlU1gEEXTw5sjROQuTM6vyntR/IOdQLPQspueFm8GHPbN9HExY2otAve8jtNBmdlrZlEI9O5ey0bbZ9f+sVjM0JnDtpXXJtZlXTRxw0/aM05/T9gaEB9pZQu4jDPaiAtDhfaJPV1MoSGjSWnOTprHb/HZzt9jPnUA8OZDOiM0WN6QinobMGOoLMmrVZG2Tm+tFubzpJlHD0uNYe0B+snYda1hfQwsvX8BAaduNxRlKVkTYB2OxS5XkH2Xr+DGjrMnm6bzVI0UerjEogoQn6Gei9J/HlwHrOJCWcHEvuyw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by PUZPR03MB7210.apcprd03.prod.outlook.com (2603:1096:301:119::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 01:16:52 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%7]) with mapi id 15.20.8880.021; Fri, 4 Jul 2025
 01:16:52 +0000
Message-ID: <9ef1ea7d-9989-45af-a438-3768cac2dc19@amlogic.com>
Date: Fri, 4 Jul 2025 09:16:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v3] shared/bap: Add stream state check in
 stream_disable
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250702-bap_for_big_sync_lost-v3-1-d314b60abf7a@amlogic.com>
 <CABBYNZLNdr5kW=AXYohCOp71CCmvir3hjeBungDHYq2gRD0xEg@mail.gmail.com>
 <05dcbdc1-893d-4ea6-8c8c-40abfbb906f4@amlogic.com>
 <CABBYNZ+WVE6OKp+Um_g6Ji6CCE1eO+MSuPQz8WLw4QUFCZQ2Aw@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZ+WVE6OKp+Um_g6Ji6CCE1eO+MSuPQz8WLw4QUFCZQ2Aw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|PUZPR03MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: db09f4b5-1716-45a5-1e9b-08ddba987543
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnVGZFkwNE5Qd2JLTjlXcXlsa1RDaWNxVVh1bjNkNmJScElEekFLNzJvbDha?=
 =?utf-8?B?UmRhK1J4RFM1endWVHdadWI1NTB0WHJCZDRpRVdmbXJaODRjNC9hWVhMN1dZ?=
 =?utf-8?B?N1NZNlZZWjRRZU1SUnM5RjRKb1hDcnBLSnFtUEVKNVZLWUJWdnlUT1NqelpN?=
 =?utf-8?B?eEpyeURsWWhvY2hTWTZYNWVBNXZOOE1oME1rd1ZGNTJEUmFSanZ4REFZNTZj?=
 =?utf-8?B?VmdPMVhWUzdnQWpRdEpheXZ4RDJjZXJUbHJLZktWWlFvWGswUGVVVGlKMGVW?=
 =?utf-8?B?eGs3THN6U0MxTFI5SlUwM0k1TzA5L2VVVnRRMTQyaGRwS2p4RzV0U1FRVUVh?=
 =?utf-8?B?dTdZaHRVV3lUNjFOeUhjSm9oTHNSOTZIdHhERGY4SDRKczNiTzNCZnV4d1Fu?=
 =?utf-8?B?ZlRYMEhWNkdab2VuZjdTTldudm9lUVdSaFVTQVNYSDgvVlVHc2c0SEhyQ2Vw?=
 =?utf-8?B?WjJqbmNRd2ZrNEpMaXBUamg5eEJkWmZDQWNiVDk2dkZuNnlNaEs5M1lmaWZi?=
 =?utf-8?B?VlRZNFpkZ0VBNTh4Z2lwVU9kZTl2RjBReXhIOVNKeHF3d1UvNFRDWms2UWtx?=
 =?utf-8?B?akQ1MCthdW9vY2FhdVpMSEJVeGVZbjl3NXBnSUgzanJiUndsRzJ0K3Bab3Rh?=
 =?utf-8?B?dno4U2NWOEpwWmpZbnVQTkgrbTJJVXRNS3kzMWFqMk95NVJBYXppUnNIb3kw?=
 =?utf-8?B?eTNRM1NFbmc1U3lEUVo0a2JmVk9LODhCT0lWNHFPcWFDQVFOeWsxajI5eGhT?=
 =?utf-8?B?NmlaYnZSeHdFQUhhZkpPU1U5M3lLbjR2cmUvTzBtZ0Z1M3NtRHliQkMvZmd1?=
 =?utf-8?B?Mk5TMDFGQWdnNlk2UlhtVkJaYStkZWRUbGRjSzJtQWp5bDVJeHo2VEgyNU5a?=
 =?utf-8?B?dDNaOWVYdFpCV2hKY0FwOXF4bUlkM3pIOU4zNVk5Wm9DOTZwYlVEbW5JenJB?=
 =?utf-8?B?VWhrOHFOeFR3aFFsaGFzRmVQeHVLaEswdzRYNWhtU1ZJWnpKUkpaT2RvMGxu?=
 =?utf-8?B?MXcyRHVySElRSlRuMDhlMjcwUGZkbXR5OEdiSjVVdWVWK3ZxNnZwQkVvOFhH?=
 =?utf-8?B?ekJvVFFQaUFTNnUrSzYrRy9QUk4vN2hDMmR0OXduRDV5V25xaWJDMVVoTDYr?=
 =?utf-8?B?cFJCdlBPYjNoZ2VPMVBUZ3ZiZVJzVzMwcGRiVGF1T3kvNk5WM0dTSTZyZmdO?=
 =?utf-8?B?bzlGSlpLSDFYYjRha21Dc3k2OUNUc1NBMmFzdGxIbTg0TzZ6enV5WTNjckNI?=
 =?utf-8?B?aEFKU2Vpdk9wRWFWNzBPUldOYkZYeiswOUZYUWF1N29qV3lFNU1mTXU2S3hl?=
 =?utf-8?B?Rjg3U1BiR1prZitMREJrejBzNktDbWlnemlIVGlBRHRxT0VWY3RZRVM5eFRx?=
 =?utf-8?B?ZjhUVGRsU3hmbEtRTDJaNHlIdGFGaDVUY3RCOXhxYXlDa0h1a3BPcXBvS3E2?=
 =?utf-8?B?dTBEaUt4SDJQQ3VaYzBjdm5BUStVazNsK3dEN2RoeC9TemZTWTRweWU1YnFo?=
 =?utf-8?B?Z2ZTcm05VWJVNnp0RURQVE1PS1pKTjFXQnAwMncraUp4YzVRbXlxQk5VVVlj?=
 =?utf-8?B?cGMyaUdkRnZEc3ZHTlh3UW5HcmFNV0dwc3VnN0FKMEEwUXJOdjRnM0JlTk4v?=
 =?utf-8?B?dVdkelFZRkRhQ0NrdktNK3JUbHlrcVpLSjUydjcrNW5ZMk0zQ29PemxhcVZp?=
 =?utf-8?B?Mmd6MjJRNmErb0h0V2Q2c1ZBY2VEUitpQ0FuMWNlYTRoNmp1Z3ZlVU1pRjV2?=
 =?utf-8?B?bXFiSHNrYmNqOHBZQlRHZzJUVjVQdUVqRkc4c1RFS1czMEppS2JnOTFaUC8y?=
 =?utf-8?Q?+PpyT0sHqfFLhu9b/bcqnXErJz5mjmfrrSIow=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bXkwSkxlVmNjVFZkNzB3WG9JeXh4aDNNZlFTbGw5bktQclp5OHVvZ3JEV3Uw?=
 =?utf-8?B?TUJaQUk4SG5lcnVUc05aM1NIMmxjVjlRUExvclFla0JzRTNuUklrU2RGRm5J?=
 =?utf-8?B?S1l3a0x3NWZNNDYvTjRnVTRkNnoydzNnbmU2MVk3VFNGSkdkK29rT1pSdTN3?=
 =?utf-8?B?YUZQb3hLbFVqbU5kUUd3QW9idi9qR2hGTjkyWXd4VUIxS0VYKzQ3b3JPbk1Y?=
 =?utf-8?B?a2xhWk5xTjJqS1RaQ1BOYzFNOWo4QnBpUzFHV2U2M25Mcm9xamtnbTZBSHll?=
 =?utf-8?B?emtUTkFDQ2NyZHhnaDE0dTY3bFJIek9Hb1B6ZE4rMlJwQUlxZ1hQU2ZVdnBn?=
 =?utf-8?B?VmdkaStOeXRMOUlyNHVVRzRiSVBqbDBkU2dFQkE1L2phck10SWxSNG4ydnBG?=
 =?utf-8?B?QjBUc2pPa0pMRG5GNFo1NU5RazJhdzRqUHVrdkFRanVERm5ubDljcVgzMmw5?=
 =?utf-8?B?Zzd3NXc1ZUpJK1pTVjl4SFZWcGRYRW1jaXhJT3RnWkdwWDhwODBCV1l4TU9Q?=
 =?utf-8?B?cHRSMnd2TnBYUXRRZElrRUFPVDVTdXhISTB4TTNSTU1wMDRtZ0tqOHhGT0JR?=
 =?utf-8?B?bXl2U0MwUkZmeUFVcUxlZ1hkSnJKdVBBakV0Q2dMUFRTRVJqenJFM1BSVUwy?=
 =?utf-8?B?REsvMHRNTVY4UHJGOWtBTVJPRlJDdlM3RmljNWx4amF4MGloalBGUTB6RmR5?=
 =?utf-8?B?M0NDeTBHWFg2dzMycDZNeFRjejlkeWgwWjEwVjdzL1FLZ2k4Vzdqc0pXdVk1?=
 =?utf-8?B?dVRqdkpPdE8yQ3hXdldsdkFkQlJjZ3NtRngrWVppdXdndE5EVFVNY04vd3U4?=
 =?utf-8?B?bWljUXgvUnowUVRrbCtlcS9vTVFSMzV5bisyQVRqT3VQSm9LRTlEY1d5aUNM?=
 =?utf-8?B?N0tmY1JRRjZhTnMvaU9QOFFibzVobHpqeTFCWHZqeUFIL3AzWWlmd3hIMUtQ?=
 =?utf-8?B?cGFwbGc5OVNMSTNaK0RDZUhWWUN1bmpLZER3QWxOblJwNUljYnBvbWV6c2Q1?=
 =?utf-8?B?NXFSTXBsSWRqakVXaCt1UFB1SnRwMFJlM1BkcjRXeHJMQ29oTUZ1UUVnQnBm?=
 =?utf-8?B?SkRxckU4aWxtdHJEL1hwbHczQ201ZGxPVmpNVHRsbHpPb0p1cmVpY2o4QXBQ?=
 =?utf-8?B?WFNIRTI4aVBWTVFXM0pQZ2djbEE0TDJCUUNFWDFqdnBnUkNGRXZ3UWRPdkI3?=
 =?utf-8?B?RTM5a1hYaDVrelVhdm42MjhSTGVXbDlKWW5mVEpEMHI3cGhDY0R2ODJLSnZ2?=
 =?utf-8?B?ZG0zMmlxWjIwemhBN1JBVm5oSG54OEVqbmxiWDhZUjFjMXhJcVZNeTlCNW91?=
 =?utf-8?B?RHdrdDgwUlgvWTZhWkV5a0U1MjJNOW8xd0oxV1dGQnBLeVE5c0JQdEJqSERF?=
 =?utf-8?B?WjBGMlFvRHIrSWpDbVQyckpEVDlmU09lcDRGV0YrWmNlSWVYc1ByN05RK0w3?=
 =?utf-8?B?NXNZRkp0LzI2M0VoSEg3VGphK0VYOWpWekNBYTl4ZDdUTEh6eEZiNWdQN0tH?=
 =?utf-8?B?b1NEWnZIRDJmc0xGb0pFRnZHSDRlUlJIVjlHMkpNMlc0U2Y3a01hTkpTVEt2?=
 =?utf-8?B?WnNYMGh0Z2FXRFdTeXNqYnNZT2hVTWhaTWxFcVpTa2tsTWpEQVo5ZURJMlZn?=
 =?utf-8?B?ODBmNUVCU0tYMjRGbVE4VDd1K1NSZFpyYmdNbGxzNzhOS1hIY2p1SHYzSnBL?=
 =?utf-8?B?OTVQNTFlWEZqb3VyTHBJUnprWmtRQ1hUL1NpMlR5YlN1RkFuSUY3OU12VElt?=
 =?utf-8?B?WWwyQmE4bUpEOWlsWlB5N2l0NG5TN0hTVDNieGYzS1dKaGtxR251bUhzZWt5?=
 =?utf-8?B?cE9WbE1mbFM4T0M0MTM4MWQ2NDZOaDBtOGhEckVnb0FpdTVycUtScUxhU1hW?=
 =?utf-8?B?VzdWWTZQUFZBcy9iYXZqU3NIWFN4SGN5enNrd0tVZ2xIMlJHVGJKenU4ZThi?=
 =?utf-8?B?V2tkSGozelVlZk0yS2tCb3ltT21wbGQ0L3ZSL0RpTmx4bElOQlRDdVl1TDlJ?=
 =?utf-8?B?YjJ1dGdTSkp5UWxPREhZQTJhYytQWHZTMWdLSElhQ3F3bWlyRkJRd3hpYXRX?=
 =?utf-8?B?YjdQMWhlWTJmYW96L1NxeVdQWnJyRlNZSy9nNm9ZRnNqd1N5Z3lXWE8wRllv?=
 =?utf-8?Q?Wen7tIRBJtFFBzkbB9Fmfj/QU?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db09f4b5-1716-45a5-1e9b-08ddba987543
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 01:16:52.2442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnpnYtQArkXOTPbfd2ZNc9dt1CVZKZdbtYX+ezODN0TIE6gmLF08tNgSMmOTDKRkjS6dKybeoIsw/ElVl86J6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB7210

Hi,
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Thu, Jul 3, 2025 at 4:40 AM Yang Li <yang.li@amlogic.com> wrote:
>> Hi Luzi,
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi,
>>>
>>> On Tue, Jul 1, 2025 at 9:19 PM Yang Li via B4 Relay
>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> Add a state check so that stream_disable() is a no-op when the stream
>>>> is not in ENABLING or STREAMING state. This prevents unexpected state
>>>> transitions or redundant operations during cleanup.
>>> What is the issue here, do you have traces, debug logs, etc?
>> Regarding the Unicast caching configuration you mentioned, there is
>> currently an issue in the code flow. The relevant log is shown below:
>>
>> When music is paused on the pixel 9 phone, the CIS link gets
>> disconnected. As the transport state changes from ACTIVE to IDLE, the
>> stream state transitions from config to qos.
>>
>>   > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [hci0]
>> 49.572089
>> Status: Success (0x00)
>> Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
>> Identity type: Random (0x01)
>> Identity: E8:D5:2B:59:57:A6 (Static)
>> Reason: Remote User Terminated Connection (0x13)
>> bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream
>> 0x1f9fc20 io disconnected
>> bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
>> 0x1f9fc20 dir 0x01: releasing -> config
>> bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20
>> state 1
>> bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed()
>> stream 0x1f9fc20: releasing(6) -> config(1)
>> bluetoothd[2313]:
>> profiles/audio/transport.c:transport_update_playing()
>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=TRANSPORT_STATE_ACTIVE
>> Playing=0
>> bluetoothd[2313]:
>> profiles/audio/transport.c:media_transport_remove_owner() Transport
>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
>> bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() Owner
>> :1.1
>> bluetoothd[2313]:
>> profiles/audio/transport.c:media_transport_suspend() Transport
>> /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
>> bluetoothd[2313]: profiles/audio/transport.c:transport_set_state()
>> State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1:
>> TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
>> bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
>> bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream
>> 0x1f9fc20 dir 0x01: config -> qos
> Ok, this indeed is not expected, that said we do have the following
> checks already in place so we might as well update them:
>
>      if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
>              stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
>          return 0;


Just to confirm — do you mean I should add a filter for 
BT_BAP_STREAM_STATE_CONFIG directly?
If so, I’ll update it as follows:

static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec 
*rsp)
{
     if (!stream || stream->ep->state == BT_BAP_STREAM_STATE_QOS ||
+            stream->ep->state == BT_BAP_STREAM_STATE_CONFIG ||
             stream->ep->state == BT_BAP_STREAM_STATE_IDLE)
         return 0;

>> ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426
>> [hci0] 49.585656
>> ATT: Handle Value Notification (0x1b) len 46
>> Handle: 0x007b Type: Sink ASE (0x2bc4)
>> Data[44]:
>> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
>> ASE ID: 1
>> State: Codec Configured (0x01)
>> Framing: Unframed PDUs supported (0x00)
>> PHY: 0x02
>> LE 2M PHY preffered (0x02)
>> RTN: 5
>> Max Transport Latency: 10
>> Presentation Delay Min: 20000 us
>> ...
>> bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hci0]
>> 49.585725
>> ATT: Handle Value Notification (0x1b) len 19
>> Handle: 0x007b Type: Sink ASE (0x2bc4)
>> Data[17]: 0102010010270000025000050a00204e00
>> ASE ID: 1
>> State: QoS Configured (0x02)
>> CIG ID: 0x01
>> CIS ID: 0x00
>> ...
>>
>> when playback resumes on the phone, it attempts to set the ASE state to
>> Codec. However, since the stream has already transitioned from config to
>> qos, the phone ends up disconnecting the connection.
>>
>> bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [hci0]
>> 60.216004
>> ATT: Handle Value Notification (0x1b) len 7
>> Handle: 0x0087 Type: ASE Control Point (0x2bc6)
>> Data[5]: 0101010000
>> Opcode: Codec Configuration (0x01)
>> Number of ASE(s): 1
>> ASE: #0
>> ASE ID: 0x01
>> ASE Response Code: Success (0x00)
>> ASE Response Reason: None (0x00)
>> bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hci0]
>> 60.226086
>> ATT: Handle Value Notification (0x1b) len 46
>> Handle: 0x007b Type: Sink ASE (0x2bc4)
>> Data[44]:
>> 01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
>> ASE ID: 1
>> State: Codec Configured (0x01)
>> Framing: Unframed PDUs supported (0x00)
>> PHY: 0x02
>> LE 2M PHY preffered (0x02)
>> RTN: 5
>> Max Transport Latency: 10
>> Presentation Delay Min: 20000 us
>> Presentation Delay Max: 40000 us
>> Preferred Presentation Delay Min: 20000 us
>> Preferred Presentation Delay Max: 40000 us
>> Codec: LC3 (0x06)
>> Codec Specific Configuration: #0: len 0x02 type 0x01
>> Sampling Frequency: 16 Khz (0x03)
>> Codec Specific Configuration: #1: len 0x02 type 0x02
>> Frame Duration: 10 ms (0x01)
>> Codec Specific Configuration: #2: len 0x05 type 0x03
>> Location: 0x00000003
>> Front Left (0x00000001)
>> Front Right (0x00000002)
>> Codec Specific Configuration: #3: len 0x03 type 0x04
>> Frame Length: 40 (0x0028)
>> Codec Specific Configuration: #4: len 0x02 type 0x05
>> Frame Blocks per SDU: 1 (0x01)
>>
>> ...
>>
>>   > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [hci0]
>> 63.651497
>> Status: Success (0x00)
>> Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
>> Identity type: Random (0x01)
>> Identity: E8:D5:2B:59:57:A6 (Static)
>> Reason: Remote User Terminated Connection (0x13)
>>
>> Here is Pauli Virtanen’s analysis and solution:
>> https://lore.kernel.org/all/3ac16d0a7c5569bce0b28f18bc2245bef8ab64c2.camel@iki.fi/
>>
>> AFAICS the bug appears to be:
>>
>> - bap.c:stream_disable() should do nothing if stream is
>> not ENABLING or STREAMING
>>
>> since it's called from bt_bap_stream_disable() which is called on
>> transport suspend which should be noop for BAP server if stream is
>> already gone.
>>
>> Next, I will attach the relevant btmon trace to the commit message.
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>> Changes in v3:
>>>> - Optimizing the code
>>>> - Link to v2: https://patch.msgid.link/20250630-bap_for_big_sync_lost-v2-0-1491b608cda5@amlogic.com
>>>>
>>>> bap for big sync lost
>>>>
>>>> To: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>>
>>>> Changes in v2:
>>>> - Add state check in stream_disable.
>>>> - Add type check in stream_io_disconnected.
>>>> - Link to v1: https://patch.msgid.link/20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com
>>>> ---
>>>>    src/shared/bap.c | 22 ++++++++++++++--------
>>>>    1 file changed, 14 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>>>> index 40e1c974b..1790b277b 100644
>>>> --- a/src/shared/bap.c
>>>> +++ b/src/shared/bap.c
>>>> @@ -2131,14 +2131,20 @@ static uint8_t stream_disable(struct bt_bap_stream *stream, struct iovec *rsp)
>>>>
>>>>           ascs_ase_rsp_success(rsp, stream->ep->id);
>>>>
>>>> -       /* Sink can autonomously transit to QOS while source needs to go to
>>>> -        * Disabling until BT_ASCS_STOP is received.
>>>> -        */
>>>> -       if (stream->ep->dir == BT_BAP_SINK)
>>>> -               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>>>> -
>>>> -       if (stream->ep->dir == BT_BAP_SOURCE)
>>>> -               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>>>> +       switch (stream->ep->state) {
>>>> +               case BT_ASCS_ASE_STATE_ENABLING:
>>>> +               case BT_ASCS_ASE_STATE_STREAMING:
>>>> +                       if (stream->ep->dir == BT_BAP_SINK)
>>>> +                               stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>>>> +                       else if (stream->ep->dir == BT_BAP_SOURCE)
>>>> +                               /* Sink can autonomously transit to QOS while source needs to go to
>>>> +                               * Disabling until BT_ASCS_STOP is received.
>>>> +                               */
>>>> +                               stream_set_state(stream, BT_BAP_STREAM_STATE_DISABLING);
>>>> +                       break;
>>>> +               default:
>>>> +                       break;
>>>> +       }
>>>>
>>>>           return 0;
>>>>    }
>>>>
>>>> ---
>>>> base-commit: 55a6763cde8a2309fd23a96479ee4cf2fc23a442
>>>> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
>>>>
>>>> Best regards,
>>>> --
>>>> Yang Li <yang.li@amlogic.com>
>>>>
>>>>
>>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz
