Received: from GBR01-LO4-obe.outbound.protection.outlook.com (mail-lo4gbr01on2092.outbound.protection.outlook.com [40.107.122.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8851A287E;
	Tue, 10 Sep 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.122.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725989395; cv=fail; b=d+S6KpbhT6odi0MVXg5iaLyKKoYyqHPCxmHXtLamdXKQu5JACDD9N357pCy6ZaIZ+/KgjaqL2y3lrtMx5iyLN4eRbPUyBUvUfApUN/gsCcnsYr1iUz9jqrcw9skf9yQRDp6ueNvUaLVxtU5fbIZT8cgRDcz2ccAB+CI5RvGFj8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725989395; c=relaxed/simple;
	bh=Oj2Zb8MS3Bnvdht6eOt0sv2a20NqwgL1Rut4Zm0h60g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Xp79+kYZZFhnr2Vp8SFRo16IHWVX8nsYdJm08ShvhkH3tXY6E6Xol8/iQsZetrLSKtZFvYHmBVNnQK7M4g/36smvd/+aXGWTrgbUAu87UNBbbnLGMVbwGEZpz02xz/+XFxYKQrwM4Ka+gx1pWcukuKqSaInbis4bS+eMkDpwHpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk; spf=pass smtp.mailfrom=mdpsys.co.uk; dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b=jiL5f6M7; arc=fail smtp.client-ip=40.107.122.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b="jiL5f6M7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqInMfMIVst4s+K18yxp9Lfb1qImcLkJRj7Oze5atb0kR1gKVjGZurAVdDHDq9/Laeu4QM0V61tmZl7K58nOuWF9wBLZpXRwby3WV2sk7+gOQANNdyPjgQbv6VwfzLRQlaufp4MGgzvL4E5tM7plGOM8IVDcvR9jO9GqW8h1coztgerjT6N+iZgBPZJRiVNOaGNNcV41pvhph+3OtdReDOWKzecZ/zPd5irLfUouIFTK/LIdoJkBXxfUPZ0k/qY6IJqZ7RJtJt2zSmD5V2ETun9wQ+a2zMM8wFakkwwhn4GtrpfVuZFKnwhMF2gZ5f0h03+ODvveFt1kUgIF9B8K1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+Qqbk1KunLrvzLBfDxsBnoADnJvIOISWIE/YMNw8us=;
 b=SVq1svu5TuKUd5qcWDlv980ajfA0DwkeL/VRCCnldM5eDpLDhf0ES404+UWFCethlhrDttgQlDsHgnR79qESzTwl/ehhj0fxhkPLO+rcKQh7MsrhqfWsrzKrMxORxz3DmCzt8335irQdt9GI1XW97yDnAkFLkmwPipYqL8mwvGaLFwL5JBUwWCbeTh1cFrYFmDJsAwtlN+HkVBJsiPQz6xBowaWR9VTmSURrNmENzTbjNQZOCrLgiYcIvs7N0I8w7esyrimC5d2NZ3AIEyNxB5scuompCnbeb0sh315qZl0Z/jxzUQmTYbb2jL5t8S/BK2/4fRhSEjVEqKQ54NRwhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mdpsys.co.uk; dmarc=pass action=none header.from=mdpsys.co.uk;
 dkim=pass header.d=mdpsys.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mdpsys.onmicrosoft.com; s=selector1-mdpsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+Qqbk1KunLrvzLBfDxsBnoADnJvIOISWIE/YMNw8us=;
 b=jiL5f6M7fFZ18DTNVXKCLoQfZc+b46KTjOOqrR9wqWptcdAmzYLebvoJVym3M1hRpGUAtVtpL4Vsc4Hyja0W3LQZ54mFxaczqWTlKn7T8jfr7zuLeXgzQNLC9dEoQk/E9jZHyfXnWv0xImScPDcrCqyG5xObujjJTZpAvK6x40o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mdpsys.co.uk;
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b1::12)
 by CWXP123MB3973.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:c3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25; Tue, 10 Sep
 2024 17:29:49 +0000
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916]) by LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 17:29:49 +0000
Date: Tue, 10 Sep 2024 18:29:27 +0100
From: Marc Payne <marc.payne@mdpsys.co.uk>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Marcel Holtmann <marcel@holtmann.org>, Hao Qin <hao.qin@mediatek.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Chris Lu <chris.lu@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	Sean Wang <sean.wang@mediatek.com>
Subject: Re: [REGRESSION] [BISECTED] btusb: driver fails to initialize
 MT7921AUN on v6.11-rc4
Message-ID: <ZuCB98DSdtKCgxaL@mdpsys.co.uk>
References: <ZsTh7Jyug7MbZsLE@mdpsys.co.uk>
 <76922517-7497-48b5-a581-d1290d413604@molgen.mpg.de>
 <acc76c2a-b176-4a19-8b5b-2ced402c3c8e@leemhuis.info>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <acc76c2a-b176-4a19-8b5b-2ced402c3c8e@leemhuis.info>
X-ClientProxiedBy: LO6P123CA0033.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2fe::6) To LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:b1::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB2972:EE_|CWXP123MB3973:EE_
X-MS-Office365-Filtering-Correlation-Id: a5b8165e-7cac-4068-9fa6-08dcd1be2c3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SGkzcGt2Rys0Z29CRXVLbHZkeWRwcWxObHdFZEdwMjN3aStPaUZkYjhaenZN?=
 =?utf-8?B?WkJ1YjVwUjU3VCtqVWVqUHl2a0F5d3RSWEozVmFZVTZPYzZmdjFFL1QycjNl?=
 =?utf-8?B?Z2dUL09qZVhUMVVnOFhUdHhmVVRXSnVIMG9SbGczNFZwMSt5Yll4ZURQSnFw?=
 =?utf-8?B?ellZM1A5cDlSb255ZFRqd0hRb0w0aGc0c3NBWkpFQkhpVnZuNk12ME5OYmJY?=
 =?utf-8?B?cVdCTGVROWthQUVOTGtjVmtNaWwwNVIxZ1A4VnhDc0w3eG1acDJDendNZVJw?=
 =?utf-8?B?bXMxbkU2TXo1akNKYktpTlFYMHZKUXJSbmxOZHZSRE1qTGJQM0VPMFltS2N0?=
 =?utf-8?B?eWhHb3RzZ0tEQVJVR0paZndhRktsUnZaQXBHK3B0NVZhN0MvbkloZDNlWjZG?=
 =?utf-8?B?RUF6ajNqbGo0Q0I0TmJZdVRyWTh5Yy9EMzVKYkdqb3lRdElWaDU5Y1JnNmlm?=
 =?utf-8?B?Q3JCYmFZbVhLL2tBYjdSVHVaemFJZjA5ZXR5S0tQdURWck9TSzZOeTRZTUtV?=
 =?utf-8?B?UTAzL0x1c1AyeHIvUk9MbEJoM0pUVStXSXVyUGJVNFdMT2lHTGtaNjBjQnNE?=
 =?utf-8?B?cFd4Wm1pZXBlVFQ1MUtZc0hnRnJVVHQ3RGoraG51WEpkc2wyNHZXeExJcEly?=
 =?utf-8?B?YUFsYjU5eWwvZ0tES3JINGRXOHBGYzFuMHdLOHIrM3FackxlNVVkektlQlI3?=
 =?utf-8?B?SHFnUHBla3FlY1dXSTBnZDRoS0VRRW5lZzV6MFp5NEVIMzFQdlZsNWhoRGZ3?=
 =?utf-8?B?d1VjMHh2SURZNEZYVDJuZTByd2ZVc0VKcUtmM2U1d0FDNkJ2NlV6K1hHenhk?=
 =?utf-8?B?U244M2RVdGJ6c0UrOTJzUDVXTkR5L2p3R2dvOUZEU2lPcUhvTkY2MUw0elNk?=
 =?utf-8?B?U040emwvOUVXbWRhVjM4VVFXSTFPYkpmUm92MnBkZ2RIV2VkcGV5ZHp0WjAr?=
 =?utf-8?B?em85UVE5RnlFZHExbDI2UUxWQ2hKb1Z3V0dDbkdjRStGMnFleEVvblkzM0p4?=
 =?utf-8?B?a3EzZnA3OFlENE13WE1FYU9lN3d4SFA2SlEvU2l1NDVCdHdsY2hqd2dHTkdv?=
 =?utf-8?B?MmpZallPbENXY053YkNLaW92NDhYWThCUnAveUE3VUp3dFMvWEdBaXN1c2Z6?=
 =?utf-8?B?WWw1TUl0QnZkamZWWTlRMlBkWVJ5MVdvU1ByMU5HSDhMNkVOdm9WUlgrOWpN?=
 =?utf-8?B?UE52OWtPY1kzRThVZm5GemsvcHN3RHNqUEZoSlVKbUpvdmdqUVFXS08wTjdI?=
 =?utf-8?B?UXBSeC9QcHJDbjFHR0MrNHFXQ2l2cndXNjAyU1NsV3pUd0xHeHo3OU0wMndk?=
 =?utf-8?B?VzdYK0RRV1BVUlpVTHpOS0thclpQNElpdUFpOGo3VGxjc1N1b0wyMjI3QWU3?=
 =?utf-8?B?T3N0cHgxMTFEWUJpblR6VWNydFdhQ1lsdHU1WEVoTnN0aUl3czNXR1QySVB6?=
 =?utf-8?B?ZDFqYkRKWEpNR09ERHVBY0QyMTFnNU5lRTlsNmdQWTN4cFJkWDJKcG1VZ0d2?=
 =?utf-8?B?VjB1OVBVY2ZVUTNJN1RLVDBBcXQ0cnNzem9MbHZzNjRPNXB6ckc3MVhxMlNZ?=
 =?utf-8?B?c3Y0WUJwa1pyZ1p2c09QeHJIQTJWUkR2ME1CaGoxSE55cDRFNmcrRmdvRTJ5?=
 =?utf-8?B?VVk5Umx3Z0NsOXgrSnczakU5M0NaRit4YnRCUVprREV0bGRkd0c0eC9DTThL?=
 =?utf-8?B?MGhUYU55UVdWWjRzQjRwK3RISjUxNlU2N3NLQUt0NTJGeW9MclVrbzlsV1lY?=
 =?utf-8?Q?xGnqLOSAUdzNM6WoZE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHNjZ3paNklkMUNUTTd1cXJYTU9aMHIwNFFvVTJVWG0xWlNONDVNOCsrTHNS?=
 =?utf-8?B?a05IZWVId3dINlpNVDZhQWhPYlhjRjVNcjNubzBPdUYvNmV4TmdGMzduc1Ri?=
 =?utf-8?B?SmZyRFRRZnF0WjZwbTJKNWxZS1hyaWxQZFd6dVlXUDVZMU5lZE1PRm1SeEx0?=
 =?utf-8?B?MkNvS2d4UW1zMHFtQjNiMzhPdmVUMEdlcUtTaXpDdFJZb0QxcVBITyttOGZj?=
 =?utf-8?B?Nlo4RUhXOXRiSkoxOTFmMFA3RGVRRTJsYVRkaFpBZnJ4OE5LS1hMVE1IUE5J?=
 =?utf-8?B?N21pTlNvVng2V2c4V3FIOXNWMzlrUzZ5T3BuTnE5WU1VMGMvb1BUM2tQdC9V?=
 =?utf-8?B?RlYrWnJXbnZTQjJBQVdSb1FBYVhyZHZEKy9PWUpBMGJwYVRtRjFyeFFvTWlV?=
 =?utf-8?B?aHNhVks3U1lDL0dZRm9qZWh3MlA5VkpyUExEajU4dS85dlFESVhxQkZmL3RE?=
 =?utf-8?B?U2g2SDdjL0VtSi9aVzVtTGdzU0V2WktPZVJITHFRNDdJQ0g2MmlYZXk2WU9m?=
 =?utf-8?B?R01iYUJyNlltRjRtc2pKRzZTVG5TcUtZL01RbzNLczZadERYZ1h6OGlQdjhM?=
 =?utf-8?B?WWhuOTh2b0VxSTRMV2psbUJ4cUJkR08wVDFRWHl6NHIxQTVLK0pxZm5oTVg4?=
 =?utf-8?B?MUt1NXYvZnZ2dzVvN0EzNURaMFdZbmIySWdsU0c3T0wwV083dTh0RStzV3V4?=
 =?utf-8?B?M2NuSnAzOERmUktZeEVHTmlKUDhIMDJRT2piVmJJNVJCOTdUdUJBaGdZOUJY?=
 =?utf-8?B?RUIwTWZhdmo5Y0VnWU1uTE1GWmg2NU00eTFJcmFKQmJoaGc5NHhXd3crMG56?=
 =?utf-8?B?SW9LdFFuSUc1Y0V2aDNuUGpVMU0wbURYUUJ1ZWlxNFpOdVVFbnpPSXM2cFFW?=
 =?utf-8?B?bU8wSlRZN2lzRXNwWTRHczlETVRWQTRQMjFnMGZ3YkZzSUF6VXI4WStDWE9i?=
 =?utf-8?B?N21nQ3NycURRN3FlWC9QcjNYMWxBeUpkcjdVV2g0cS9hb0FVUnZCREpjVmwr?=
 =?utf-8?B?emp0alZ5a0dWdDJ6Y2hCWVVMbVVCeVpkVEFmbVpiSEFCbHBtSDhPZXF4bUt0?=
 =?utf-8?B?bEF4YytKTWtFaWdRWU1ZUFlkLzE3TU5ZQVU5dHRxeWliekFVOTBPcnBnZEQv?=
 =?utf-8?B?UGoxOVF0VDJOWHJGOVlRaXJuYWxQeUU2blZxc0FxTTZNU2w3TmFOYS9JZ2J6?=
 =?utf-8?B?M2x1ZVZUc2NnTXQvQisvYlVaSVdNMER2M09QVm13TnBHOCtpVjE2R1hHMllj?=
 =?utf-8?B?MUYrK1NzQS84UUFsSEgvdDN5V01qOCtGR2lkdkxyTkQ5UGJwYUtsaUFZWHRG?=
 =?utf-8?B?WmxGOXZqWjZKRnNCMlFRWTVhaDNsMWZYRGI2OE1PSDJtWVc0RU1SUm00czZM?=
 =?utf-8?B?bDk1OE9JdlViZ1V5amx6UURKVnBmUzVwdXdzVDdteGp1QnIyK0lzS1orTHJI?=
 =?utf-8?B?TWVhSW1JZU91ZjVPVUd4T3pEc1o1Y2RvZ0cvVW9wam5TTGZ2MVNpOVFhNHdv?=
 =?utf-8?B?M0ZZTGVZV1lhNzM1M1E1YzB0bC9uRnl6amlhNHJZcnF1ZjNXRXlpWnZJQTBU?=
 =?utf-8?B?Q05ET25NOE51SEpzUDQvbGhqb0hEQVRxT0hjeTM4SGV0RE9Pd3JiZjNQL3VH?=
 =?utf-8?B?aktLOThGcjI3Q3h4SGpkWDNIeHFqTGEydzJqMkpJTEFBYnNXdDcxSWNLVWs3?=
 =?utf-8?B?OC9OWTB1NG5BRTBZZ0dYdWUvVStVUCt4MXZoWXlCcXJocDVPYllDaHRzYkxO?=
 =?utf-8?B?R2dvS05xWVkxZmtuRVI3Zmhwb29rczFVOUZRTVM1U3F4a2JJWGh2blVaOXpt?=
 =?utf-8?B?TTJMbitxa01Cc1FRbStXWE1TSUpuUDJycDBqSC9VS1h6cFFXZ2kyVUgyV2Q1?=
 =?utf-8?B?MTdlYVd3dU1hQmRUdS84N3B5cUc2WEo1YUVwS0VQQ2tocGxibDdGa2RwUUg4?=
 =?utf-8?B?THJqSE9ZL0J1NmtiU1FqcHJkMHZCUDR5aE04M1Y2M3I5UGRKUzZUYkh6eXZC?=
 =?utf-8?B?Q2h0OTFBSkF2aW96cGtjSlY3bzltbmtMaEtMakhMN2J6dXFTNW1nOTVQV2pH?=
 =?utf-8?B?ckc3ZjNWMWdKNVYxK3dHQ1ZKTU9iK1FmekFlejNXRzJPRG9tcklYa0M3K3ZS?=
 =?utf-8?Q?NgOVF5nwT3OFZp8HGSwfsyVTO?=
X-OriginatorOrg: mdpsys.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: a5b8165e-7cac-4068-9fa6-08dcd1be2c3b
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 17:29:49.7213
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 07eb37f3-62d1-4b5c-a7c4-ed2a24dbebc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 67U9TSNqNK/yG8lLZbVJhHPGnp7IrF1LaJTo4bH7aEFa98xKsQZ7mqZNCZW1YRhxs3ylGAV6GjyRZb1bji0naQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB3973

Hi Thorsten,

Thanks for following this up.

The 06/09/2024 12:34, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Marc, does the problem still occur with recent mainline? It looks like
> nobody ever took care of this report, but I might be missing something
> -- or maybe some later change fixed this intentionally or due to
> side-effects.
> 

I can confirm that the regression is still present on v6.11-rc7. I have
tested the patch I have been made aware of [1] and it solves the command
timeout but the device remains unusable running the latest firmware and the
Oops still occurs on device disconnection. I have reported this back in
response to the patch [2].

[1] https://lore.kernel.org/lkml/20240822052310.25220-1-hao.qin@mediatek.com/
[2] https://lore.kernel.org/lkml/ZuB3omUkdUHLggYu@mdpsys.co.uk/

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> 
> On 21.08.24 07:27, Paul Menzel wrote:
> > [Cc: +Marcel, +Luiz]
> > 
> > Thank you for your report and bisecting the issue. I just add the
> > maintainers, and tell regzbot about it.
> > 
> > Am 20.08.24 um 20:35 schrieb Marc Payne:
> >> Hello,
> >>
> >> I'm testing v6.11-rc4 and the btusb driver fails to properly
> >> initialize my
> >> MT7921AUN-based Alfa Networks AWUS036AXML:
> >>
> >> [   63.896319] usb 4-3.1.2: new SuperSpeed USB device number 4 using
> >> xhci_hcd
> >> [   63.915436] usb 4-3.1.2: New USB device found, idVendor=0e8d,
> >> idProduct=7961, bcdDevice= 1.00
> >> [   63.915450] usb 4-3.1.2: New USB device strings: Mfr=6, Product=7,
> >> SerialNumber=8
> >> [   63.915455] usb 4-3.1.2: Product: Wireless_Device
> >> [   63.915459] usb 4-3.1.2: Manufacturer: MediaTek Inc.
> >> [   63.915461] usb 4-3.1.2: SerialNumber: 000000000
> >> [   69.146856] Bluetooth: hci1: Failed to write uhw reg(-110)
> >> [   69.149213] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time:
> >> 20240716151445
> >> [   78.530621] usb 4-3.1.2: Failed to suspend device, error -110
> >> [   88.553074] Bluetooth: hci1: Execution of wmt command timed out
> >> [   88.553097] Bluetooth: hci1: Failed to send wmt patch dwnld (-110)
> >> [   88.553186] Bluetooth: hci1: Failed to set up firmware (-110)
> >> [   88.553193] Bluetooth: hci1: HCI Enhanced Setup Synchronous
> >> Connection command is advertised, but not supported.
> >> [   90.899462] usb 4-3.1.2: Failed to suspend device, error -110
> >>
> >> I have bisected the issue down to the following commit:
> >>
> >>      ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller
> >> before downloading the fw")
> >>
> >> The commit does not revert cleanly due to refactoring in subsequent
> >> commits but
> >> removing the relevant ten lines of code allows the driver to
> >> initialize the
> >> device correctly, albeit with some failures and 'Mediatek coredump'
> >> errors
> >> followed by an additional reset. Interestingly, after the reset the
> >> device is
> >> now showing as hci2 rather than hci1, suggesting an HCI device
> >> registration
> >> issue... Bluetooth devices are able to pair and connect as expected:
> >>
> >> [   77.765047] usb 4-3.1.2: new SuperSpeed USB device number 4 using
> >> xhci_hcd
> >> [   77.785044] usb 4-3.1.2: New USB device found, idVendor=0e8d,
> >> idProduct=7961, bcdDevice= 1.00
> >> [   77.785063] usb 4-3.1.2: New USB device strings: Mfr=6, Product=7,
> >> SerialNumber=8
> >> [   77.785069] usb 4-3.1.2: Product: Wireless_Device
> >> [   77.785073] usb 4-3.1.2: Manufacturer: MediaTek Inc.
> >> [   77.785077] usb 4-3.1.2: SerialNumber: 000000000
> >> [   77.807685] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time:
> >> 20240716151445
> >> [   80.570163] Bluetooth: hci1: Device setup in 2710186 usecs
> >> [   80.570173] Bluetooth: hci1: HCI Enhanced Setup Synchronous
> >> Connection command is advertised, but not supported.
> >> [   81.871516] Bluetooth: hci1: Mediatek coredump end
> >> [   82.734805] Bluetooth: hci1: Opcode 0x0c03 failed: -110
> >> [   82.754807] Bluetooth: hci1: Mediatek coredump end
> >> [   84.868215] Bluetooth: hci1: Failed to read MSFT supported features
> >> (-110)
> >> [   87.001566] Bluetooth: hci1: AOSP get vendor capabilities (-110)
> >> [   92.292375] usb 4-3.1.2: reset SuperSpeed USB device number 4 using
> >> xhci_hcd
> >> [   92.385619] usb 4-3.1.2: reset SuperSpeed USB device number 4 using
> >> xhci_hcd
> >> [   92.406786] Bluetooth: hci2: HW/SW Version: 0x008a008a, Build Time:
> >> 20240716151445
> >> [   94.920337] Bluetooth: hci2: Device setup in 2455839 usecs
> >> [   94.920343] Bluetooth: hci2: HCI Enhanced Setup Synchronous
> >> Connection command is advertised, but not supported.
> >> [   94.994480] Bluetooth: hci2: AOSP extensions version v1.00
> >> [   94.994494] Bluetooth: hci2: AOSP quality report is supported
> >> [   94.995001] Bluetooth: MGMT ver 1.23
> >>
> >> However, when disconnecting the AWUS036AXML device I get an Oops in
> >> the hci_unregister_dev function, again indicating an issue with HCI
> >> registration
> >> which was not present in the 6.10 kernel versions:
> >>
> >> [ 1210.222351] usb 4-3.1.2: USB disconnect, device number 4
> >> [ 1210.271146] Oops: general protection fault, probably for non-
> >> canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
> >> [ 1210.271166] CPU: 2 UID: 0 PID: 2275 Comm: kworker/2:1 Not tainted
> >> 6.11.0-rc4-dirty #67 a319890a1bc323fc297a70bfc980897913c059f7
> >> [ 1210.271178] Hardware name: Intel(R) Client Systems NUC12WSHi7/
> >> NUC12WSBi7, BIOS WSADL357.0088.2023.0505.1623 05/05/2023
> >> [ 1210.271183] Workqueue: usb_hub_wq hub_event
> >> [ 1210.271200] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
> >> [ 1210.271292] Code: 89 ef e8 0e c4 ca dc f0 80 8b e9 0e 00 00 08 48
> >> 89 ef e8 6e b1 ca dc 48 c7 c7 68 70 44 c1 e8 82 12 cb dc 48 8b 43 08
> >> 48 8b 13 <48> 3b 18 0f 85 35 c8 06 00 48 3b 5a 08 0f 85 2b c8 06 00 48
> >> 89 42
> >> [ 1210.271297] RSP: 0018:ffffbb3b0661bb98 EFLAGS: 00010246
> >> [ 1210.271305] RAX: dead000000000122 RBX: ffff97bc8f92e000 RCX:
> >> 0000000000000000
> >> [ 1210.271310] RDX: dead000000000100 RSI: ffff97bc8ba8b610 RDI:
> >> ffffffffc1447068
> >> [ 1210.271314] RBP: ffff97bc8f92e4d0 R08: ffff97bc8424b5c0 R09:
> >> 00000000802a0026
> >> [ 1210.271318] R10: 00000000802a0026 R11: 0000000000000001 R12:
> >> ffff97bc8f92e000
> >> [ 1210.271323] R13: ffffffffc12ff278 R14: ffffffffc12ff278 R15:
> >> ffff97bcf25acc50
> >> [ 1210.271327] FS:  0000000000000000(0000) GS:ffff97cbd7300000(0000)
> >> knlGS:0000000000000000
> >> [ 1210.271332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [ 1210.271337] CR2: 0000285c01b10000 CR3: 00000003d6e22000 CR4:
> >> 0000000000f50ef0
> >> [ 1210.271342] PKRU: 55555554
> >> [ 1210.271346] Call Trace:
> >> [ 1210.271352]  <TASK>
> >> [ 1210.271359]  ? __die_body.cold+0x19/0x27
> >> [ 1210.271371]  ? die_addr+0x3c/0x60
> >> [ 1210.271378]  ? exc_general_protection+0x17d/0x400
> >> [ 1210.271391]  ? asm_exc_general_protection+0x26/0x30
> >> [ 1210.271403]  ? hci_unregister_dev+0x45/0x1f0 [bluetooth
> >> ffdb4fb65cead032fbb8f4718e5d0aa7b94d492f]
> >> [ 1210.271479]  ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
> >> ffdb4fb65cead032fbb8f4718e5d0aa7b94d492f]
> >> [ 1210.271551]  btusb_disconnect+0x67/0x170 [btusb
> >> ce322bda915639979ec31f72a2b85eb752188d36]
> >> [ 1210.271563]  usb_unbind_interface+0x90/0x290
> >> [ 1210.271576]  device_release_driver_internal+0x19c/0x200
> >> [ 1210.271589]  bus_remove_device+0xc6/0x130
> >> [ 1210.271599]  device_del+0x161/0x3e0
> >> [ 1210.271608]  ? kobject_put+0xa0/0x1d0
> >> [ 1210.271617]  usb_disable_device+0x104/0x220
> >> [ 1210.271627]  usb_disconnect+0xe6/0x2e0
> >> [ 1210.271637]  hub_event+0x7f9/0x19d0
> >> [ 1210.271648]  ? __schedule+0x3dd/0x1520
> >> [ 1210.271656]  process_one_work+0x17b/0x330
> >> [ 1210.271667]  worker_thread+0x2d2/0x400
> >> [ 1210.271676]  ? __pfx_worker_thread+0x10/0x10
> >> [ 1210.271684]  kthread+0xcf/0x100
> >> [ 1210.271695]  ? __pfx_kthread+0x10/0x10
> >> [ 1210.271705]  ret_from_fork+0x31/0x50
> >> [ 1210.271711]  ? __pfx_kthread+0x10/0x10
> >> [ 1210.271720]  ret_from_fork_asm+0x1a/0x30
> >> [ 1210.271732]  </TASK>
> >> [ 1210.271735] Modules linked in: mt792x_usb mt7921_common mt792x_lib
> >> mt76_connac_lib mt76_usb mt76 ccm option usb_wwan rndis_host uhid cmac
> >> algif_hash algif_skcipher af_alg bnep vfat fat cdc_ether usbnet
> >> intel_rapl_msr intel_rapl_common intel_uncore_frequency
> >> intel_uncore_frequency_common snd_sof_pci_intel_tgl
> >> snd_sof_pci_intel_cnl iwlmvm snd_sof_intel_hda_generic soundwire_intel
> >> soundwire_cadence snd_sof_intel_hda_common x86_pkg_temp_thermal
> >> intel_powerclamp snd_sof_intel_hda_mlink snd_sof_intel_hda coretemp
> >> snd_sof_pci snd_sof_xtensa_dsp kvm_intel snd_sof r8152 mii
> >> snd_sof_utils mac80211 libphy snd_soc_hdac_hda kvm
> >> snd_soc_acpi_intel_match soundwire_generic_allocation snd_soc_acpi
> >> soundwire_bus snd_soc_avs snd_hda_codec_hdmi snd_soc_hda_codec
> >> snd_hda_ext_core snd_hda_codec_realtek snd_soc_core
> >> snd_hda_codec_generic snd_hda_scodec_component crct10dif_pclmul
> >> crc32_pclmul polyval_clmulni snd_compress polyval_generic ac97_bus
> >> libarc4 ghash_clmulni_intel snd_pcm_dmaengine sha512_ssse3
> >> sha256_ssse3 snd_hda_intel sha1_ssse3
> >> [ 1210.271851]  aesni_intel btusb snd_intel_dspcfg snd_intel_sdw_acpi
> >> gf128mul iwlwifi snd_hda_codec btrtl crypto_simd cryptd btintel
> >> tps6598x btbcm typec snd_hda_core btmtk rapl cfg80211 roles mei_pxp
> >> mei_hdcp snd_hwdep intel_cstate ee1004 bluetooth igc snd_pcm spi_nor
> >> intel_uncore ov13858 mei_me snd_timer thunderbolt v4l2_fwnode snd ptp
> >> mei i2c_i801 v4l2_async wdat_wdt mtd pcspkr intel_lpss_pci wmi_bmof
> >> pps_core i2c_smbus intel_lpss videodev soundcore i2c_mux rfkill idma64
> >> intel_pmc_core mousedev igen6_edac joydev serial_multi_instantiate
> >> intel_vsec mc pmt_telemetry acpi_pad acpi_tad pinctrl_tigerlake
> >> pmt_class mac_hid i2c_dev dm_mod sg crypto_user loop nfnetlink
> >> ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 xe
> >> drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec i915
> >> hid_generic usbhid i2c_algo_bit drm_buddy ttm intel_gtt nvme
> >> drm_display_helper nvme_core video spi_intel_pci cec xhci_pci
> >> crc32c_intel nvme_auth spi_intel xhci_pci_renesas wmi
> >> [ 1210.271992] ---[ end trace 0000000000000000 ]---
> >> [ 1210.271996] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
> >> [ 1210.272061] Code: 89 ef e8 0e c4 ca dc f0 80 8b e9 0e 00 00 08 48
> >> 89 ef e8 6e b1 ca dc 48 c7 c7 68 70 44 c1 e8 82 12 cb dc 48 8b 43 08
> >> 48 8b 13 <48> 3b 18 0f 85 35 c8 06 00 48 3b 5a 08 0f 85 2b c8 06 00 48
> >> 89 42
> >> [ 1210.272066] RSP: 0018:ffffbb3b0661bb98 EFLAGS: 00010246
> >> [ 1210.272071] RAX: dead000000000122 RBX: ffff97bc8f92e000 RCX:
> >> 0000000000000000
> >> [ 1210.272075] RDX: dead000000000100 RSI: ffff97bc8ba8b610 RDI:
> >> ffffffffc1447068
> >> [ 1210.272078] RBP: ffff97bc8f92e4d0 R08: ffff97bc8424b5c0 R09:
> >> 00000000802a0026
> >> [ 1210.272082] R10: 00000000802a0026 R11: 0000000000000001 R12:
> >> ffff97bc8f92e000
> >> [ 1210.272085] R13: ffffffffc12ff278 R14: ffffffffc12ff278 R15:
> >> ffff97bcf25acc50
> >> [ 1210.272088] FS:  0000000000000000(0000) GS:ffff97cbd7300000(0000)
> >> knlGS:0000000000000000
> >> [ 1210.272092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> [ 1210.272096] CR2: 0000285c01b10000 CR3: 00000003d6e22000 CR4:
> >> 0000000000f50ef0
> >> [ 1210.272099] PKRU: 55555554
> >> [ 1210.272102] note: kworker/2:1[2275] exited with preempt_count 1
> >>
> >>
> >> The kworker exiting obviously means that the kernel no longer responds
> >> to events
> >> on any of the USB ports...
> >>
> >> I hope you can track down the issue, let me know if you need any
> >> additional
> >> details.
> >>
> >> Regards,
> >>
> >> Marc
> 
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> #regzbot poke
> 

Regards,

Marc

