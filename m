Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022103.outbound.protection.outlook.com [52.101.126.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACD7199FBA
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 05:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750829116; cv=fail; b=ET1MMSJsmSgbadUYzQUMI+3e3em6fmxVL/tJ71i3AAV2Xr/Z528qw/gldDPjTNlhx6Git2ztIrb976l4RhW/NdsBjVdpE4NblNE7EV7MSinutEoBO+6k+3aM1ekbR9+kLi11evLYtbMjLpa/EzoMVv3dzLsuVgxfVqRcLtaSCXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750829116; c=relaxed/simple;
	bh=UgDvYWUIN8PT660bJDXRl78DcDp0ELBb2qvRqTd4kjY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K/jmf8c0nVmKajrLd/6NcmcsYXd/Crp0XDs4HH04Z5hmJMpb87kNwJ311nUtuuYq4j/O8QTm2sSOagfg2cqsSYNTMGpog9LTAPrqDHU5oXpRwQ12j71dHuwmrFbhXUGOeejroBKmQA2svLdWC7CDYfyjLGTMgM26nSnFeKeMTaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=T9Ya61qe; arc=fail smtp.client-ip=52.101.126.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="T9Ya61qe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qZ4uetOyoYcPn3CtzeLnrAfpt2PnLHmz7XyVioXuY9jYhdRtZesmA/3HhTsyz9Rr/rPeOm+0f9quDWLHMUuOcgNLh5Rv0vYd2T6znOhVeXWBLmsmL4yt/MsSiE5pFrAvlDYbkHaXS3bn43gkP7kwB7fDp3tcP7LuD2vUw431fKkAe7jmde6ZeK8J+tHxNY7oVfWTaGiInvGiSk1aMD69w9g5pozsUj75cphcc5fa1X0jnbqCikRd9/U7uoaLIYeZHsBzK3XTHUAAOvN2zsmAOxaHEALeT3iKt48oa1mSNZAfxbLVJmJYu1GJZyN1Ld1tpYbs8dxwEomQ4dQI6Njexg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/4yJwjChJjnwAVRojV/vHeo9tQcQmaDbox7csV693A=;
 b=MANGhve44g+73ZCt7kFIprhn1PSk4Nh0I2Z7pYCNiqgWmijCDTutuYLUbozx+TAD0lacDlIcYCfXYBaikmAz9QHpYHZl3mCbQt00/EB2eTSGyPjlQlOWdcLHbCAcEpazNXHoU4AxhI1H3ze2qs5mQ2Ikmy0SUPEm4yAF+dQWSN8MksPWxkIaoK5GA/Zr72UIvquHCctuIaCAxDcvRkzllCtbcZzTD/nOV98SaSgz+s3lHpV25C30to4e69XELviF3QrRsGaF9MMIS2553qG9nGCjgIRZc3FOnMzsxME37O3ng4GKwwJnprE6ndrKs2Rp4buiiWXgDFDl36Yjme0CWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/4yJwjChJjnwAVRojV/vHeo9tQcQmaDbox7csV693A=;
 b=T9Ya61qeS0BVeYuq43/W/+BiKOXrlMj96j4fwFizSilrIqMmOYjpAM/ZH6c8qZK9PkJGY3gr4zGr9rNQ8yhj7G2BaAqlxZpbJDWjOqSNrly64ODZIhxvBq4SQ64PTV9btuSRsFEIWVA+mx9ZbM3PhmuNUtDAQFZ/VSjfTdcKe0NjXBa3e6yrT8V3axu8OCvVaD0PDYNttqRFAmXExeLYyknJIKXk3OfojcJ3oEjl4rjdHYfP8IwThWh2rFLSmJnPrf7aOlaZXKgKbpyQTa5vx05KEPuh96gBiszwyver3a8a1uu0jk6Q42+SXj5BMm9L1oNQBI22+cRQ8+1PI4bGuQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by OSQPR03MB9395.apcprd03.prod.outlook.com (2603:1096:604:425::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 05:25:10 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%6]) with mapi id 15.20.8835.023; Wed, 25 Jun 2025
 05:25:09 +0000
Message-ID: <1f2fe697-6437-4000-8aa3-d09bb7090a46@amlogic.com>
Date: Wed, 25 Jun 2025 13:24:48 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] shared/bap: Set stream to idle when I/O is
 disconnected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250624-bap_for_big_sync_lost-v1-1-0df90a0f55d0@amlogic.com>
 <CABBYNZK=5-N8wcHhSp5ii8FmM5CzPFqKheKHOcCs8brNhVp_ww@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZK=5-N8wcHhSp5ii8FmM5CzPFqKheKHOcCs8brNhVp_ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0034.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::17) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|OSQPR03MB9395:EE_
X-MS-Office365-Filtering-Correlation-Id: 55c8431b-adea-477e-41c2-08ddb3a8a731
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czVodEZPY3M4NjQ1c1BLZmpWTFhGWmd0MDd5bGg1QUhLWWFGbnliTXd5alVl?=
 =?utf-8?B?RmtIQ2R1VmNHREpKbXplb1BQWlJDcFU4c1ppQTg1eFV3NTZoVDQ1d0tBV2Qy?=
 =?utf-8?B?V1B5SEJMejFhSm5JL1VjOXp3d0k2YmdOZVlpN29YcUhSYktjZ0FPMVpONVBl?=
 =?utf-8?B?b1lURmR6Z01HL3FGdCt4eVRDb1dZTXRHcm5iK3pFejJ6dkJnd2t5Y1c0RXlX?=
 =?utf-8?B?LzdjbDB3TTdxUlJoRzE5OXRtanlPczNDbnR6NmJBdHlBL1lwVGI5a3UwZkZS?=
 =?utf-8?B?WHlWUlBpNXdhNE54Rk9id3gzNkFiUFMvMWgrMkNmckpXUWc1cldTeGFoNkVh?=
 =?utf-8?B?UU5iMzFDS2dGRENLd0kzZTRBMnBVbFdPQkI3K2MvYzVkMXZneGk5OVlXRDI2?=
 =?utf-8?B?N1Nvc215ZDYxcGZBZFdGWUZweGVBQVJ6VE8zY1NUdzRxWW92S0psZ0t5WlFo?=
 =?utf-8?B?V1BzcGdmYzFQZUZpelQvMFZTUGx6VzdublRaMHhQSXJydmdHcko2d1M5cTJY?=
 =?utf-8?B?QmhGTnpVNHFzT0phYU5BUUtKbXAwY3A1aVhOMlUrbXVVN2lEajZNTUZRUFQ4?=
 =?utf-8?B?Z2FMb0pFWjJNVG40WEZtMngrblo0V1FJSEQ0S2ppVnhWdmJ0MnBHK0RKSS9B?=
 =?utf-8?B?bzVjTFcvdTcydmZMcmFSRGZYelhwakpCRVo1bm1kL3pXSnJIZzNYZkpCQnEv?=
 =?utf-8?B?NlFXMGN6Mzd0REhlckNiSjg5VmRsQnVmek82djNSOFBXUjBKMFdHVnJhL1Vj?=
 =?utf-8?B?OG9Lank5cFIwQVpUTWpjbEhYQ2NmcUg4R0VSL29pTWRVSktSSm4rdllBMnhI?=
 =?utf-8?B?UWRzeTgwcU5yam5HRExRaWY5Q3dRTSt5M1JHL3A1RlNrcXR5UGdHbW9BU05Q?=
 =?utf-8?B?ZzJoN1JJcSt2emkvRHVxa2xxZnlKYlJZOG5iMk5Tb0g5MkN5WWtRdHdOTFZU?=
 =?utf-8?B?bCtJWEJhM2tYcytuMjZmQXdRYlhUY3BEU1Z0c2NWWjlBUi9oWUlFR1dRemdq?=
 =?utf-8?B?QnVvT3Y4dkhxRjBBQmlZbGF5aXlOekl0KzJuU2dYL3ZBRFMxZ0hQUmg0LzBr?=
 =?utf-8?B?N28zVTRQNTZVWkwvRTBsczhrSFNwWWVuUjNjWTVMaFB3U0M0Yy9WeS96VTM5?=
 =?utf-8?B?eFozS0JWRC9teWVmUmlmQlRpM3FSbk8zZkhJb201UHZRTUpKYTlYdHZ3T0xm?=
 =?utf-8?B?U2NQeHJYc1pUSVBvMGs2b0hRc2tQTHpxVXBzZG5tVlptREVaL0lETUFVdERT?=
 =?utf-8?B?UjVSYUJYcFlodkp5bWVBNGk0QkVkUUxMMzlPQnhOaDRnQmtRV3oydG4xaU1Z?=
 =?utf-8?B?S3ZETUtSR3JSN2I5UThINmZQY2JPbW5ZM09aUUd6R0tERWg4VnEyMXB0ckZS?=
 =?utf-8?B?OW9pU3o4NUVCRFJSTmxhbHpiTHpoakZQOHhNL2JHajBtQnJaMGJmanBOcEtP?=
 =?utf-8?B?SWpEbXFrTkEya3R3OXdwWmh1azYxWFV1RTBBVFdUOFZwY2lTc1lGZUVPYWY0?=
 =?utf-8?B?QnZacEs2SU1nWWJyaGt2eHIyV09aakdEdFFqWmJkZDkvUDY1RGNBeG5SMm9v?=
 =?utf-8?B?SnVaMWxicXhyRlliT01pazVaR3FiMUlXMEZkRWk0c2NEY0cvT3RoWmwxQmRF?=
 =?utf-8?B?WVRveTd0OHBSTmtpNGtlSmZtbWJMTmJTUW5pdzVNQUFQcUNHbEpyZzhKdzVO?=
 =?utf-8?B?dkZHRVNXa1VvWnFLT2xtQ1VnTUtMQWFPd0d5S1F0SXFadGNmNkpBdDBtZ0p6?=
 =?utf-8?B?b2hZMzFxZlJWcnV2aFBaZmdRaGIwenl3cGN5VkxwRTZ3L0F1WmduZUx3OUVi?=
 =?utf-8?B?N1JoZ1gxdVoxYW80UW83dW9ET2dFcm12VjJoM01tN2kyQUdiUmIxQWtkRkRT?=
 =?utf-8?B?My9xWTV5RmR6RG9Zc2N1cW5uSVc2dFJQSWZERjdYNE5QaEJVdmZPWFYrNXV4?=
 =?utf-8?Q?Ru/jxPzE5oQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MHRvZzZjeUt6UWd2bFIrLzhWUE95UThuck0xaDhuTWJOcFkzcGhuYlM2NG9y?=
 =?utf-8?B?Y0pMUXhSNEY0dEdLcmV5Nkd6cGR6Mk00RnN4dEVqdVhoK2txL09XaGF1WnUy?=
 =?utf-8?B?OHFlbS96b29JQWYzQ1NpSVJ4TzREMFVyMTcwWVBOeUNGb1lIUWl0VHd2WlVj?=
 =?utf-8?B?NVROdFYwTHhtRjYvMkQ1RE9HUktKTW5JVk51WTJzdUp6Nm5YWUloUndzODk3?=
 =?utf-8?B?OVl1dm9nbWJsOVFDTWZnbVF6S0VFV3VqUUMvMDJTTzJaQU5hczZrOW8zNEpk?=
 =?utf-8?B?WFZnSzJYT1RJZWtlWEJ4OW1mQUZZVG8yODZ2RWpNVCtEam5sTUY1YjUxK09s?=
 =?utf-8?B?Wi9DMXZlREkxVE5paFdKTmtPUGpxNTJZcWg3eTIwcFhONm52OGpqdEZiTDlq?=
 =?utf-8?B?SHpkUmx0VUxabGpEK0pjaWFBY2hmaDN3c01xRnk2R1RtVCs5eE1FdllrRURK?=
 =?utf-8?B?cE5Wb1NtZEV5enJXRUM1Rk50RmQrVnJ3RjY3TUxRRDkzN0ZheWc1aUI4cXBm?=
 =?utf-8?B?WXFnMmRHVmcxWkRUSjNGUzN4b1VFVTJsdUQza1BXUU1tWklHOWIwT1JzeHJX?=
 =?utf-8?B?bitlb01XRE1mVXFJeU8rVDJHVllJUWdUazVwaWJKRU4xdUYzNDBpR3NWMzJP?=
 =?utf-8?B?czJjanF5VUFlSnhuZ2hGSWZlaWpLUmlGSGxxUi92Wk1PbldNUDhyRjFMQTBB?=
 =?utf-8?B?Z3NEbHVjSmZoa1lsTDZBWXNGaFpVckVOcHprdFpURHN0ZUluZjBNOVlyQnRj?=
 =?utf-8?B?SjlLMTJOQm5lRlZDQ2lOcUE3c3pNVFQ2dmljTG9GWG8rVG1UN1BsNS9ib2hS?=
 =?utf-8?B?Smd1cDg2YWNoMndta09oa2QvbmR6aVBhUXlWdHZrdmFlWjZPcEVLaE9TeVZO?=
 =?utf-8?B?NjVGelBlZjZ5aUN1VGpMQUludHdOWGhOOTZQTFlMMDRGdlBzQkdlSXNEajUw?=
 =?utf-8?B?Y1g5M1ZxS3lOaDRTL29KZ0pIeUZGaUhsY0Q1SkJ6blNCNHdTb3Q5QTE3T0xr?=
 =?utf-8?B?OTROSWpoTkM5azFTSzNYTUIrUmpKandIVHI4RmtHY2FGZENSLzdTVlZHUitF?=
 =?utf-8?B?dTdrcnBBa2ZPeU9ZUlFlSVJ0OTQ5bFZwZHJVdHZvZDl5aVFUeVVOeWJoMGZ4?=
 =?utf-8?B?d2RHME5PWmd6c1VwdS9FV1FiV0tHcytLRU5CZWRCZ1RGUk03YVlsd1NWUEZw?=
 =?utf-8?B?Z2IwRXRNVkNpOWdtYXVTN080YklDNVpIdUF3dGxvU01mR2duZXU4UHJYUzNL?=
 =?utf-8?B?TCtoTjBCS01GaktKWndsSWxXbWpxUDFKeG5vR0lJMjZyYXdPU0dMZkQ2RWlJ?=
 =?utf-8?B?RFlyaTdOYVN5T1NqVG5PcnJ6dGdNSWdhUVk3V3RUSmhUdEtRUzIzNC8wNG0v?=
 =?utf-8?B?UTgzOHlYOWhvN2htd2M2YmxkaUhhZUpIcnVpWFZlaTNVTUxKVTVWOWRsSVVD?=
 =?utf-8?B?Mmo5SmN3a2hZbTJjTjV4MWdyQUFGV1UyRnZiUmZQNUZuZEYvUzQ2RmxWRjFh?=
 =?utf-8?B?M21TeTFSZTlET3dtVDdUZnZzRUlwK3grZVhmK3VXNjVWV1dDTFBrZ0lmaUFX?=
 =?utf-8?B?UkZ6a3F6Q09UbFo1c002LzVzWVhyT1BvTk1rZkxma294dUZ4cThwV3pFb0tU?=
 =?utf-8?B?dDhFUFJoOGRudlhTMW5FS1dtb0ZpRlNBbUYxK29UYmRkelAwSCtXRGxjQ1BL?=
 =?utf-8?B?MTZPdFZjRUdKV1JJWVJOejQ0aWxmVWZtVXAzQjJMT3oyLzJRNDVsSXZFdXFS?=
 =?utf-8?B?QzgwbFNGYVFYZHZOaXJZOGdieUcvMkdzQlJUczVaOG9Qc3BKR2Fxa3QxL3NN?=
 =?utf-8?B?TVZMUE5CT0NkWkcyakJPa25icGxadFI0T0JKODFzcHpTQWxKSlIzRGFFSUJQ?=
 =?utf-8?B?ZkhrOGgzQVlidnl3RHdSa2ttYTAxbUVBOW1qVVVhM05pK2ZncVAvakJiN0U3?=
 =?utf-8?B?cTZ4QkxvZEltQVJITXZEbmdjWHoxaXJqRlNEVm1OVmZySUFWbmxyeWRGUFJk?=
 =?utf-8?B?R21TTHRqTHg1ajBIbXRvOFFqc3pxTk9EQllVblNWckZpZkhwZjdkWHl3QjJL?=
 =?utf-8?B?U2ZMeTRKK1VqY3JZTk81a1h6ZjdXREk3c2VvSnFjenBhcngzM21nQ3NHRkEz?=
 =?utf-8?Q?vrkqORSnMb0yySJn+nRCB+kMd?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c8431b-adea-477e-41c2-08ddb3a8a731
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 05:25:09.8510
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMzAdDHG+d4CYrHHoNxtpNUjB2ylWRGewFAFYxs2BXZdYZxxLOpXnfEC69CjDA28xY5Ml/LPG50shk468UJDSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR03MB9395


在 2025/6/24 21:08, Luiz Augusto von Dentz 写道:
> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Tue, Jun 24, 2025 at 2:04 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the CIS link is disconnected, the ASE status transitions from Releasing to
>> Idle.
>>
>>    > HCI Event: Disconnect Complete (0x05) plen 4           #1484 [hci0] 67.947425
>>                  Status: Success (0x00)
>>                  Handle: 512 Address: 5C:B1:E1:2F:01:B9 (Resolvable)
>>                  Identity type: Random (0x01)
>>                  Identity: E8:D5:2B:59:57:A6 (Static)
>>                  Reason: Remote User Terminated Connection (0x13)
>>    = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0x..   67.948018
>>    = bluetoothd: src/shared/bap.c:bap_ucast_set_state() stream 0xdff..   67.948145
>>    = bluetoothd: src/shared/bap.c:stream_notify() stream 0xdffda8 st..   67.948275
>>    = bluetoothd: src/gatt-database.c:send_notification_to_device() G..   67.948525
>>    = bluetoothd: profiles/audio/bap.c:bap_state() stream 0xdffda8: r..   67.948679
>>    = bluetoothd: profiles/audio/transport.c:bap_state_changed() stre..   67.948967
>>    = bluetoothd: profiles/audio/transport.c:transport_update_playing..   67.949061
>>    = bluetoothd: profiles/audio/transport.c:media_transport_remove_o..   67.949106
>>    = bluetoothd: profiles/audio/transport.c:media_owner_free() Owner..   67.949149
>>    = bluetoothd: profiles/audio/transport.c:media_transport_suspend(..   67.949375
>>    = bluetoothd: profiles/audio/transport.c:transport_set_state() St..   67.949423
>>    = bluetoothd: src/shared/bap.c:bap_ucast_detach() stream 0xdffda8..   67.949574
>>    = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd2d2..   67.949710
>>
>> When BIG sync is lost, the stream status transitions from Streaming to Idle.
>>
>>    > HCI Event: LE Meta Event (0x3e) plen 3                #3189 [hci0] 118.870863
>>          LE Broadcast Isochronous Group Sync Lost (0x1e)
>>                  BIG Handle: 0x00
>>                  Reason: Remote User Terminated Connection (0x13)
>>    = bluetoothd: src/shared/bap.c:stream_io_disconnected() stream 0..   118.871183
>>    = bluetoothd: src/shared/bap.c:bap_bcast_set_state() stream 0xdf..   118.871227
>>    = bluetoothd: profiles/audio/bap.c:bap_state_bcast_sink() stream..   118.871258
>>    = bluetoothd: profiles/audio/bass.c:bap_state_changed() stream 0..   118.871307
>>    = bluetoothd: src/gatt-database.c:send_notification_to_device()...   118.871384
>>    = bluetoothd: profiles/audio/transport.c:bap_state_changed() str..   118.871452
>>    = bluetoothd: profiles/audio/transport.c:transport_bap_update_li..   118.871509
>>    = bluetoothd: profiles/audio/transport.c:transport_update_playin..   118.871555
>>    = bluetoothd: profiles/audio/transport.c:transport_set_state() S..   118.871610
>>    = bluetoothd: src/shared/bap.c:bap_bcast_sink_detach() stream 0x..   118.871660
>>    = bluetoothd: profiles/audio/media.c:pac_clear() endpoint 0xdd25..   118.871689
>>
>> Fixes: https://github.com/bluez/bluez/issues/1343
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   src/shared/bap.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index bccbc73ff..d51f3106e 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -6584,10 +6584,8 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
>>
>>          DBG(stream->bap, "stream %p io disconnected", stream);
>>
>> -       if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
>> -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
> This is actually on purpose for unicast since that supports caching
> the configuration, now perhaps this is not the case for broadcast
> since the BIG may have been terminated so we probably need to check if
> this is a broadcast stream or a unicast stream, or add a dedicated
> callback for each type.


Regarding the Unicast caching configuration you mentioned, there is 
currently an issue in the code flow. The relevant log is shown below:

When music is paused on the pixel 9 phone, the CIS link gets 
disconnected. As the transport state changes from ACTIVE to IDLE, the 
stream state transitions from config to qos.

   > HCI Event: Disconnect Complete (0x05) plen 4           #1425 [hci0] 
49.572089
           Status: Success (0x00)
           Handle: 512 Address: 6A:AB:51:47:3B:80 (Resolvable)
             Identity type: Random (0x01)
             Identity: E8:D5:2B:59:57:A6 (Static)
           Reason: Remote User Terminated Connection (0x13)
   bluetoothd[2313]: src/shared/bap.c:stream_io_disconnected() stream 
0x1f9fc20 io disconnected
   bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 
0x1f9fc20 dir 0x01: releasing -> config
   bluetoothd[2313]: src/shared/bap.c:stream_notify() stream 0x1f9fc20 
state 1
   bluetoothd[2313]: profiles/audio/transport.c:bap_state_changed() 
stream 0x1f9fc20: releasing(6) -> config(1)
   bluetoothd[2313]: 
profiles/audio/transport.c:transport_update_playing() 
/org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 State=TRANSPORT_STATE_ACTIVE 
Playing=0
   bluetoothd[2313]: 
profiles/audio/transport.c:media_transport_remove_owner() Transport 
/org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner :1.1
   bluetoothd[2313]: profiles/audio/transport.c:media_owner_free() Owner 
:1.1
   bluetoothd[2313]: 
profiles/audio/transport.c:media_transport_suspend() Transport 
/org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1 Owner
   bluetoothd[2313]: profiles/audio/transport.c:transport_set_state() 
State changed /org/bluez/hci0/dev_6A_AB_51_47_3B_80/fd1: 
TRANSPORT_STATE_ACTIVE -> TRANSPORT_STATE_IDLE
   bluetoothd[2313]: src/shared/bap.c:stream_disable() stream 0x1f9fc20
   bluetoothd[2313]: src/shared/bap.c:bap_ucast_set_state() stream 
0x1f9fc20 dir 0x01: config -> qos
   ATTbluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1426 
[hci0] 49.585656
       ATT: Handle Value Notification (0x1b) len 46
         Handle: 0x007b Type: Sink ASE (0x2bc4)
           Data[44]: 
01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
             ASE ID: 1
             State: Codec Configured (0x01)
             Framing: Unframed PDUs supported (0x00)
             PHY: 0x02
             LE 2M PHY preffered (0x02)
             RTN: 5
             Max Transport Latency: 10
             Presentation Delay Min: 20000 us
   ...
   bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 24 #1427 [hci0] 
49.585725
       ATT: Handle Value Notification (0x1b) len 19
         Handle: 0x007b Type: Sink ASE (0x2bc4)
           Data[17]: 0102010010270000025000050a00204e00
             ASE ID: 1
             State: QoS Configured (0x02)
             CIG ID: 0x01
             CIS ID: 0x00
   ...

when playback resumes on the phone, it attempts to set the ASE state to 
Codec. However, since the stream has already transitioned from config to 
qos, the phone ends up disconnecting the connection.

   bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 12  #1433 [hci0] 
60.216004
       ATT: Handle Value Notification (0x1b) len 7
         Handle: 0x0087 Type: ASE Control Point (0x2bc6)
           Data[5]: 0101010000
             Opcode: Codec Configuration (0x01)
             Number of ASE(s): 1
             ASE: #0
             ASE ID: 0x01
             ASE Response Code: Success (0x00)
             ASE Response Reason: None (0x00)
   bluetoothd[2313]: < ACL Data TX: H.. flags 0x00 dlen 51 #1434 [hci0] 
60.226086
       ATT: Handle Value Notification (0x1b) len 46
         Handle: 0x007b Type: Sink ASE (0x2bc4)
           Data[44]: 
01010002050a00204e00409c00204e00409c0006000000001302010302020105030300000003042800020501
             ASE ID: 1
             State: Codec Configured (0x01)
             Framing: Unframed PDUs supported (0x00)
             PHY: 0x02
             LE 2M PHY preffered (0x02)
             RTN: 5
             Max Transport Latency: 10
             Presentation Delay Min: 20000 us
             Presentation Delay Max: 40000 us
             Preferred Presentation Delay Min: 20000 us
             Preferred Presentation Delay Max: 40000 us
             Codec: LC3 (0x06)
             Codec Specific Configuration: #0: len 0x02 type 0x01
               Sampling Frequency: 16 Khz (0x03)
             Codec Specific Configuration: #1: len 0x02 type 0x02
               Frame Duration: 10 ms (0x01)
             Codec Specific Configuration: #2: len 0x05 type 0x03
            Location: 0x00000003
               Front Left (0x00000001)
               Front Right (0x00000002)
             Codec Specific Configuration: #3: len 0x03 type 0x04
               Frame Length: 40 (0x0028)
             Codec Specific Configuration: #4: len 0x02 type 0x05
               Frame Blocks per SDU: 1 (0x01)

   ...

   > HCI Event: Disconnect Complete (0x05) plen 4           #1445 [hci0] 
63.651497
         Status: Success (0x00)
         Handle: 16 Address: 6A:AB:51:47:3B:80 (Resolvable)
           Identity type: Random (0x01)
           Identity: E8:D5:2B:59:57:A6 (Static)
         Reason: Remote User Terminated Connection (0x13)

Introducing a check in the stream logic to distinguish between Unicast 
and Broadcast would indeed make it easier to handle different stream 
types cleanly.
However, if we temporarily ignore Unicast caching, a simpler and cleaner 
approach would be to transition the stream directly to IDLE when I/O is 
disconnected.

Once the Unicast caching issue is properly resolved, we can revisit and 
introduce stream-type-based handling accordingly.

>> +       stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
>>
>> -       bt_bap_stream_set_io(stream, -1);
>>          return false;
>>   }
>>
>>
>> ---
>> base-commit: ae1b7f6ba805f82742bbc32ff275e268248ef9f8
>> change-id: 20250624-bap_for_big_sync_lost-63476c679dbb
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
