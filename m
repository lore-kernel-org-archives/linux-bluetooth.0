Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2108.outbound.protection.outlook.com [40.107.121.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C5B1494BD;
	Tue, 20 Aug 2024 18:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724178932; cv=fail; b=PBuKrYL06oc3sAzXWxJJOM61JuD3C8hHrgew1h09hoZOmB041VmXGEFDtyQD9CVIoDpdf+leOQDKTHccnCspvnTegndz8U7kJJPcSYwlzn3elauDkjsMpnu/PfqjBG0YDazJEsGomivKahX6vJmCKmF1xDdsUY7tfKBwYCHZG7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724178932; c=relaxed/simple;
	bh=agSf3Oe8aHxFkpsqqDhyuC3KRmgDgzTLj7oX0h1pQSM=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VlLrtogJaZDpDYnWcy8thgXP7X19cnbQIcx9TE5RjNGzP+59Uwma+Rh49CyZ0WvV2QnyDb0KcLC2P/iuov93neSJAfyqxN8abXUhPyVdKxtzWT/AazWSsyPConhmDP7MnDNEOmFkI45qu+2Q6J+879Dk/qhmNR/pa8h+D3lcwCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk; spf=pass smtp.mailfrom=mdpsys.co.uk; dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b=Bp2RrGgB; arc=fail smtp.client-ip=40.107.121.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b="Bp2RrGgB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LNQWAhPzlCxMIGO8NxzhVovuMU5X9hFhXx3lr6ZVtObKD2ZoROSLxEQ+14fcQdU68gl5Km9ZtOAjY8Q9MhxSRClG+SXWreIOrSq+9epI+34wDiEk3YkvJJfzlFOnt6TBdW/z3aTXJrzPd3zgwEC3bdI79327Hml7C5EW3nAeXJcf7mO4VitNeu7Ji8/6SlYLr1dhbTknGO3HRS0GN81v5/MGmFuGwbF8cxJQkSqJ43bymqDevbXc9E2d7Bgo5zpZbDzbmyL16lL/XOtDwMRRu50PxRVpJE51nrlAob1o3n/FLqpQQyJWBGJPf43++oQiBQTqbCJ7dHsGD4fj3/oAAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHsIsnpHLTZMjr4DFBCAChPWg03c27YcgWCNEghQi5g=;
 b=c2HUV+zfFYbNVI22mmiHoBoGHRhP5qz8PIf/QxW7mBNnGnN+uBigLwbH/ksflvVzdERGGunGi9M3FCzTKX7CJRqwBMDF0qWhpZjHDtnCgm2hpbSE5PfzpzKu89mI+RA1eEnjtogXgW8fKZAIw1kG7/s4+gjU7k9MFNMs4E6k1j3ADHi8saYWJm8idlMrjn9y72diakQFv7pohKaSR7oBWJWxgNPY9ZaTz+6AeTDAf62vpVNoacLB11EpH6xPk+ZkrdKtoyPjkTZQuDUaxTDfWcERTYryrZgCS6BZJTveA/YxHkmE+4/Q9tRhWbqrWlTf9FG/9Hlhk706kA+qu0TZDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mdpsys.co.uk; dmarc=pass action=none header.from=mdpsys.co.uk;
 dkim=pass header.d=mdpsys.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mdpsys.onmicrosoft.com; s=selector1-mdpsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHsIsnpHLTZMjr4DFBCAChPWg03c27YcgWCNEghQi5g=;
 b=Bp2RrGgBl9MbfAvH7x4hc4llcxDDSVHw4OEB9ln3lfsQUs/7uAMmIdqP4mAKItRZzZF3nLzbkm1rteCUWF0q2RgkZua21LhlonWsPTFggVSHwZPZz8UZGkpR+yywW9ObBJNVtd+DTmb3/WupGwnj07qA8+5+LMw7X4lYIkZHUPw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mdpsys.co.uk;
Received: from CWXP123MB2965.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:41::11)
 by CWLP123MB2993.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:5c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.16; Tue, 20 Aug
 2024 18:35:26 +0000
Received: from CWXP123MB2965.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1b52:590c:54ee:d122]) by CWXP123MB2965.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1b52:590c:54ee:d122%7]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 18:35:26 +0000
Date: Tue, 20 Aug 2024 19:35:24 +0100
From: Marc Payne <marc.payne@mdpsys.co.uk>
To: Hao Qin <hao.qin@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Chris Lu <chris.lu@mediatek.com>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org, regressions@lists.linux.dev
Subject: [REGRESSION] [BISECTED] btusb: driver fails to initialize MT7921AUN
 on v6.11-rc4
Message-ID: <ZsTh7Jyug7MbZsLE@mdpsys.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0434.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::7) To CWXP123MB2965.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:400:41::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWXP123MB2965:EE_|CWLP123MB2993:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d1acf74-c0fc-4479-437d-08dcc146dc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QlpIbXBqenQ1eFlvMjh5czdwREtuK2VrYnJWeDQxdVh5TGYwZDhZMVVPZGFC?=
 =?utf-8?B?Wm50MlJDYlNBZ3l5T0phZXFFVys1bUlCZSs1czcrRG1idkZabFJJR2svMTJ3?=
 =?utf-8?B?a0hEZEdEK2tuemhDUC9YVC9OOWpCcjdVRXRQQTlvUVB1bUJHZlVXNHNiSmlh?=
 =?utf-8?B?bk1LaWVaUENuYXM2L0pUcWxKMnJ2VHlKaDZ3b3RNZVRlVzJ6L0h2a2cxaytq?=
 =?utf-8?B?bkpSUEpZekJ0WHAvWVRBYjRGaDFhRGZIaEU5VksrQVRNb1U2b2VyTU1ZUUtv?=
 =?utf-8?B?VS9JNzhFaXlJV0FrdGd5SHVSVXpNKzdFYnVwdHpLOHF6K3lxMnF1Sjg5OXow?=
 =?utf-8?B?ZnZvT0ZrOEtmUEphMHdKaHhxNk16cXQvN25qUGIrWEtVUGliUU9zbFF4UWl1?=
 =?utf-8?B?bWFTRTBUbDU3NzVhVmo1bjFEWlkzb0wzWEhCNUplSGxqS3gzRUNiZ01Yd1Nt?=
 =?utf-8?B?eTIrUHFZQVg3aHQxQW1CdUFWc0hDeGhTNitzQyt0RzFjNXV4M1Y3RUZPL01i?=
 =?utf-8?B?M3RiYjBMS20xaFcybGpGLzJTRjljV0FKOTBFOGJOL0F1ZmhkQjlwN2lTOEl2?=
 =?utf-8?B?enVrdDh6ZjNpbEZTa1hPdVVsbm1rTHFhaDBxeHFsaFNpalZ0cFVTNHRCL2RM?=
 =?utf-8?B?QlZmMW9UeDZtV3hOOW83MGdIZGZibEdvV1YrbTNGV2RvMVRzcHVOUHpnc0JZ?=
 =?utf-8?B?Qlh1Q0QvQ2hVYU0rNmdVRFcyVExaTHlUS2pPRS9HMCtaRENkM3dETCtXMEtv?=
 =?utf-8?B?WTYxeEhtOUJBcDBUc3psYm80cG82NEs3VkVEdWpVYVRhSUQzT2VyVi9IaXVM?=
 =?utf-8?B?NzUvRkZQYmlRQzYvWG9tTWJoUE1rNk5vT0FGOU9kTi9YbDhuREt3b0tJeXRj?=
 =?utf-8?B?ZFZEc0dXeFJmYk45US9zVWtwdkJZVzFrSmMwSW1YSEtZNGtad1BNVklBVWpq?=
 =?utf-8?B?aSs0bmtSaWtrU1BUQzYwdDFhSHhXZ3FXejhpNmplTDBZMWhxVzBPd0paSnA1?=
 =?utf-8?B?dDRIMFJZNXFKc3JQQ0tDbWdGa2k5RXN4Q2FvSFlsSXNiWWwyVXk5dzE3cm13?=
 =?utf-8?B?NHIrRTY4MXV5T1dPVUhaT01PQm5Ea1Rvazloa2lRUnhKeFlYeTk3KytQbysv?=
 =?utf-8?B?VmxTRkR2V3VILzZPeUpDV2tBRXMwOFh5cFdnT2JQWWI1VXBNZmROTlV3RnUy?=
 =?utf-8?B?OGFZSGEyWUlRdDJkd3Y0VmdXY3hyeWFveElqV1JLREgyYnBxNmt2R2pwWEZi?=
 =?utf-8?B?Zy9acW8rRlRFTmF1b0lJV215eHFRckxkMTdOZjcwQitjd05JT3dvV0RIc2Na?=
 =?utf-8?B?V2w5eE1JeVphOGpybXVNWDF2UGszVEZBKzUyQ1JaM0dhUTNDNHBwd3ZiR0t5?=
 =?utf-8?B?Q1ZsRisxck1CNzM3RDMxazJad1FlRnhtd2RIWldMQVpRTFN5czQrdEVlR3VT?=
 =?utf-8?B?Sms2NlFxSTkxWlF4KzdqNExJa0xjRWRKalV4a3AwU1RITTU3akpwb2hyWDg1?=
 =?utf-8?B?UXY3OVJUOEY3SmNudklaL2hFb3gzSC9NN2liYjMwcGFER0tyelpyZzNhRlUw?=
 =?utf-8?B?MnAxNmlzZ3pOMTdUaFA0SytCczhOZTNGVGlLV0UwbjAwYTMwMTJXMEluOFBO?=
 =?utf-8?B?RVhGcHNIREtWNWovU3N6aUd5YnhTWFp6ZnJ2bzkxRlhKYmlHU3lxQkZKellB?=
 =?utf-8?B?WHFEZGtTVW9Wd0QxcHE5eHplZVJVL0VMdk5FczlVYmsvMzM0dnM5d2F1eDlY?=
 =?utf-8?B?ZG8wME5jZmxSL25rQmhtYjVURTU4ZDA3cDJXaitHZ0ZDS1lvaGU1eGRVVVNv?=
 =?utf-8?B?Mm1JZ3kzOTVOOFF2ZTRkUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CWXP123MB2965.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eU4wRnhyaS8ySVY5Ri9rQU1XRVBVa25zYnRuY29GWXg1SnFZUXUvWW9yb0Ji?=
 =?utf-8?B?dmE5cDBJMnl6blMwOGFDQkllTW54emVUT0tDMWQ3RU1JazIxM0RrTVNvdmF4?=
 =?utf-8?B?d3EzcmhBODN6WFpjUkpWbWo4NDZIS2dNeWpVaDVKekNGaGxTZy84VVd6YVRE?=
 =?utf-8?B?bkdJSmNyV2cwUkJMcWdveHNCdVZNR3Rxei9EKzBTS3lGRk1IVTV6blhFODlw?=
 =?utf-8?B?UGRpem1ETFpCMTUzWXhYNEU1SEt1TExlT1QwVXNFSW10USt5VGRjU25TTVE1?=
 =?utf-8?B?T0ZOb1lzV0lNRUptL1RwbkZhb2J2OU1NWm1hTHFETXZBdDcxcm4rRGxsRmpa?=
 =?utf-8?B?L1luMkw3VWF1ZlpzV3dTRVpweWZUN1hBOVdubkxMR21GWFowdlJvOVdWUGlQ?=
 =?utf-8?B?Z2lRalF2Y20vMk1vdlM0Qld6RytndnM4M2hmb2pDM3c0aEN3a0g0SnpHeEVk?=
 =?utf-8?B?V1g5d0FTVlJqLytscVpsamVlalZmSmpHT0pnWkJFOGlUZEFUaE14VmR2NWU3?=
 =?utf-8?B?cHFiellreERBNStQWWdmdXhHSDJJQTRCRHpkSTUwa0twL3h4Y1RqTTYrd0g3?=
 =?utf-8?B?aFdNQU83MktiV1V6UURPbE5idDRWWmRqTmZVMmZkWlVzMWJXdE9nUXlNZStC?=
 =?utf-8?B?a2dINWVGTEZTVG9rZUR0NlVOWUx6Um1QVUNvWEhRVUdBRFcwMVJscTN0RGk4?=
 =?utf-8?B?R2tEd0pKb3gvbVFkUkRPdStsNDBNYnJtNUZITFRVaUhMc1dQZGowQWRTbWov?=
 =?utf-8?B?WE9VTTMyVGlaRVNLV3Jxbjcwb2ZadlN3aVRwcEJKc0FTdnRSLy9kZUJDOUx0?=
 =?utf-8?B?T293bks4N24xdFR1a2lBck1TV0R6dUdJTHlFSzlLd1pZekJGSWF4WlhmdXJq?=
 =?utf-8?B?SEQ0KzNLSHZPOVdrTDU2eDNTUEJEVjI1djM5UTI1WW1GcmJtd3B1R1kvTXd2?=
 =?utf-8?B?Rktpdmpra1plendKTjZYc2pYbGl0Qjd4ZjR6YXIxUU1rSk5JaUptUUJoanRX?=
 =?utf-8?B?ZlR6UDNZSCthN0c1UThTdUp4UTB4ZFJoY3RxalcvUGN6YyswU0tRVXpwWmZm?=
 =?utf-8?B?WkszOUNKbEhUN1BWcmZRRHVSUXhYT0doMVBpK01RSGtUN0RkSkIxKys1WTR0?=
 =?utf-8?B?UTF4SmRHOXRLTXI4aldxc3BSUXVOc3RqSW5Fb1JTYWpoT0cxUTlQNGFtbHM3?=
 =?utf-8?B?R091MGdPYmgwR3RjME1vY1k1Y0RMY2FDem1jMFJpK09mWnFPUEEvazd6d3VT?=
 =?utf-8?B?bUM4UGpKZlFTMk5NT0ltbmptUjlRM0dMSlBraElGQlFTVUVIM1FiT2ZkVzZM?=
 =?utf-8?B?SStzL3ROaFdrODNCUkk3Y2x6QjVVeXhlWStYQXlPWkdlNnR6cnVCVGNTZWha?=
 =?utf-8?B?SWVkZytyVWh6RFNWK2twS0l4K2d4emxHR0VHOG9xMVlBV0QzZG4rWmlIUDBC?=
 =?utf-8?B?bjFnQzJhNk5wMFlUUGdkRDgzZWJGWjZqdVJoYjNOQTFDV1JDYU92RElmR3RU?=
 =?utf-8?B?Wks2KzFlQTdHbTl1NHV1MkJaWDdqcUZib1AxdXRtR1dWNDVTd2lkZUwwYTJ4?=
 =?utf-8?B?MFB6UDd5VllpNUhsVUViNmhlTHZid2RSb1dGUjRaaXBaRFpPZlNtVElYZHdu?=
 =?utf-8?B?bG5MUHpyZzF2R1lpNXhBNm92NWpVNVBWSjhTTWFLQ0I4ZFVuOWI4dmovL1Zk?=
 =?utf-8?B?ZGR2U1lnZlZiM1F1bFZlMHV4a2N6ZUZRd1RVUUFPWmN4dk5YWWMwOHVTQ1dF?=
 =?utf-8?B?MEdNSHVTRXBFZ28yZ2FsV0RKdm1HS0d1NlFidVp0cE12a0N5NUg1Y1NML1hG?=
 =?utf-8?B?c1B6b2JQOHVZbllzNU1VVEROUDhQWFkyaXh6RURsVFJleDY0TU8zajB3SXdN?=
 =?utf-8?B?OGhGYUtTZ0Z4TnRpdTVWUHNycFk0Zi9MUW9EZ2E2a1NaMFdWaUg0eXNmNUJI?=
 =?utf-8?B?NTd5N3JTKzFXQ0hRRkh0YkRzbzBycEtCUmlJK0JxWXBIenUyTll4QXJnUFNT?=
 =?utf-8?B?VHdFbnBEeU5ZZEhPTnJJY1dhaDRxM29YNXByeVhISllobjI5N293Nlg0OUdK?=
 =?utf-8?B?MzZLV1VCUkhXdC9jcURMWFVZMng1Y1IxRGRscmVtbFM2Y29CL1JQQUxTVjgv?=
 =?utf-8?Q?Z4VAGSXVVly2UxTugAigwEdyi?=
X-OriginatorOrg: mdpsys.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d1acf74-c0fc-4479-437d-08dcc146dc1b
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB2965.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 18:35:26.6694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 07eb37f3-62d1-4b5c-a7c4-ed2a24dbebc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5PUnH4Y4WAODb21ltNQKLXv3hHipUKbxk8OjdIhWKKTrquT5B/UIgYa+NhPF0WI45VQt7EKbbzk5UTWXI0m6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB2993

Hello,

I'm testing v6.11-rc4 and the btusb driver fails to properly initialize my
MT7921AUN-based Alfa Networks AWUS036AXML:

[   63.896319] usb 4-3.1.2: new SuperSpeed USB device number 4 using xhci_h=
cd
[   63.915436] usb 4-3.1.2: New USB device found, idVendor=3D0e8d, idProduc=
t=3D7961, bcdDevice=3D 1.00
[   63.915450] usb 4-3.1.2: New USB device strings: Mfr=3D6, Product=3D7, S=
erialNumber=3D8
[   63.915455] usb 4-3.1.2: Product: Wireless_Device
[   63.915459] usb 4-3.1.2: Manufacturer: MediaTek Inc.
[   63.915461] usb 4-3.1.2: SerialNumber: 000000000
[   69.146856] Bluetooth: hci1: Failed to write uhw reg(-110)
[   69.149213] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time: 2024=
0716151445
[   78.530621] usb 4-3.1.2: Failed to suspend device, error -110
[   88.553074] Bluetooth: hci1: Execution of wmt command timed out
[   88.553097] Bluetooth: hci1: Failed to send wmt patch dwnld (-110)
[   88.553186] Bluetooth: hci1: Failed to set up firmware (-110)
[   88.553193] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[   90.899462] usb 4-3.1.2: Failed to suspend device, error -110

I have bisected the issue down to the following commit:

    ccfc8948d7e4 ("Bluetooth: btusb: mediatek: reset the controller before =
downloading the fw")

The commit does not revert cleanly due to refactoring in subsequent commits=
 but
removing the relevant ten lines of code allows the driver to initialize the
device correctly, albeit with some failures and 'Mediatek coredump' errors
followed by an additional reset. Interestingly, after the reset the device =
is
now showing as hci2 rather than hci1, suggesting an HCI device registration
issue... Bluetooth devices are able to pair and connect as expected:

[   77.765047] usb 4-3.1.2: new SuperSpeed USB device number 4 using xhci_h=
cd
[   77.785044] usb 4-3.1.2: New USB device found, idVendor=3D0e8d, idProduc=
t=3D7961, bcdDevice=3D 1.00
[   77.785063] usb 4-3.1.2: New USB device strings: Mfr=3D6, Product=3D7, S=
erialNumber=3D8
[   77.785069] usb 4-3.1.2: Product: Wireless_Device
[   77.785073] usb 4-3.1.2: Manufacturer: MediaTek Inc.
[   77.785077] usb 4-3.1.2: SerialNumber: 000000000
[   77.807685] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time: 2024=
0716151445
[   80.570163] Bluetooth: hci1: Device setup in 2710186 usecs
[   80.570173] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[   81.871516] Bluetooth: hci1: Mediatek coredump end
[   82.734805] Bluetooth: hci1: Opcode 0x0c03 failed: -110
[   82.754807] Bluetooth: hci1: Mediatek coredump end
[   84.868215] Bluetooth: hci1: Failed to read MSFT supported features (-11=
0)
[   87.001566] Bluetooth: hci1: AOSP get vendor capabilities (-110)
[   92.292375] usb 4-3.1.2: reset SuperSpeed USB device number 4 using xhci=
_hcd
[   92.385619] usb 4-3.1.2: reset SuperSpeed USB device number 4 using xhci=
_hcd
[   92.406786] Bluetooth: hci2: HW/SW Version: 0x008a008a, Build Time: 2024=
0716151445
[   94.920337] Bluetooth: hci2: Device setup in 2455839 usecs
[   94.920343] Bluetooth: hci2: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[   94.994480] Bluetooth: hci2: AOSP extensions version v1.00
[   94.994494] Bluetooth: hci2: AOSP quality report is supported
[   94.995001] Bluetooth: MGMT ver 1.23

However, when disconnecting the AWUS036AXML device I get an Oops in
the hci_unregister_dev function, again indicating an issue with HCI registr=
ation
which was not present in the 6.10 kernel versions:

[ 1210.222351] usb 4-3.1.2: USB disconnect, device number 4
[ 1210.271146] Oops: general protection fault, probably for non-canonical a=
ddress 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
[ 1210.271166] CPU: 2 UID: 0 PID: 2275 Comm: kworker/2:1 Not tainted 6.11.0=
-rc4-dirty #67 a319890a1bc323fc297a70bfc980897913c059f7
[ 1210.271178] Hardware name: Intel(R) Client Systems NUC12WSHi7/NUC12WSBi7=
, BIOS WSADL357.0088.2023.0505.1623 05/05/2023
[ 1210.271183] Workqueue: usb_hub_wq hub_event
[ 1210.271200] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
[ 1210.271292] Code: 89 ef e8 0e c4 ca dc f0 80 8b e9 0e 00 00 08 48 89 ef =
e8 6e b1 ca dc 48 c7 c7 68 70 44 c1 e8 82 12 cb dc 48 8b 43 08 48 8b 13 <48=
> 3b 18 0f 85 35 c8 06 00 48 3b 5a 08 0f 85 2b c8 06 00 48 89 42
[ 1210.271297] RSP: 0018:ffffbb3b0661bb98 EFLAGS: 00010246
[ 1210.271305] RAX: dead000000000122 RBX: ffff97bc8f92e000 RCX: 00000000000=
00000
[ 1210.271310] RDX: dead000000000100 RSI: ffff97bc8ba8b610 RDI: ffffffffc14=
47068
[ 1210.271314] RBP: ffff97bc8f92e4d0 R08: ffff97bc8424b5c0 R09: 00000000802=
a0026
[ 1210.271318] R10: 00000000802a0026 R11: 0000000000000001 R12: ffff97bc8f9=
2e000
[ 1210.271323] R13: ffffffffc12ff278 R14: ffffffffc12ff278 R15: ffff97bcf25=
acc50
[ 1210.271327] FS:  0000000000000000(0000) GS:ffff97cbd7300000(0000) knlGS:=
0000000000000000
[ 1210.271332] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1210.271337] CR2: 0000285c01b10000 CR3: 00000003d6e22000 CR4: 0000000000f=
50ef0
[ 1210.271342] PKRU: 55555554
[ 1210.271346] Call Trace:
[ 1210.271352]  <TASK>
[ 1210.271359]  ? __die_body.cold+0x19/0x27
[ 1210.271371]  ? die_addr+0x3c/0x60
[ 1210.271378]  ? exc_general_protection+0x17d/0x400
[ 1210.271391]  ? asm_exc_general_protection+0x26/0x30
[ 1210.271403]  ? hci_unregister_dev+0x45/0x1f0 [bluetooth ffdb4fb65cead032=
fbb8f4718e5d0aa7b94d492f]
[ 1210.271479]  ? hci_unregister_dev+0x3e/0x1f0 [bluetooth ffdb4fb65cead032=
fbb8f4718e5d0aa7b94d492f]
[ 1210.271551]  btusb_disconnect+0x67/0x170 [btusb ce322bda915639979ec31f72=
a2b85eb752188d36]
[ 1210.271563]  usb_unbind_interface+0x90/0x290
[ 1210.271576]  device_release_driver_internal+0x19c/0x200
[ 1210.271589]  bus_remove_device+0xc6/0x130
[ 1210.271599]  device_del+0x161/0x3e0
[ 1210.271608]  ? kobject_put+0xa0/0x1d0
[ 1210.271617]  usb_disable_device+0x104/0x220
[ 1210.271627]  usb_disconnect+0xe6/0x2e0
[ 1210.271637]  hub_event+0x7f9/0x19d0
[ 1210.271648]  ? __schedule+0x3dd/0x1520
[ 1210.271656]  process_one_work+0x17b/0x330
[ 1210.271667]  worker_thread+0x2d2/0x400
[ 1210.271676]  ? __pfx_worker_thread+0x10/0x10
[ 1210.271684]  kthread+0xcf/0x100
[ 1210.271695]  ? __pfx_kthread+0x10/0x10
[ 1210.271705]  ret_from_fork+0x31/0x50
[ 1210.271711]  ? __pfx_kthread+0x10/0x10
[ 1210.271720]  ret_from_fork_asm+0x1a/0x30
[ 1210.271732]  </TASK>
[ 1210.271735] Modules linked in: mt792x_usb mt7921_common mt792x_lib mt76_=
connac_lib mt76_usb mt76 ccm option usb_wwan rndis_host uhid cmac algif_has=
h algif_skcipher af_alg bnep vfat fat cdc_ether usbnet intel_rapl_msr intel=
_rapl_common intel_uncore_frequency intel_uncore_frequency_common snd_sof_p=
ci_intel_tgl snd_sof_pci_intel_cnl iwlmvm snd_sof_intel_hda_generic soundwi=
re_intel soundwire_cadence snd_sof_intel_hda_common x86_pkg_temp_thermal in=
tel_powerclamp snd_sof_intel_hda_mlink snd_sof_intel_hda coretemp snd_sof_p=
ci snd_sof_xtensa_dsp kvm_intel snd_sof r8152 mii snd_sof_utils mac80211 li=
bphy snd_soc_hdac_hda kvm snd_soc_acpi_intel_match soundwire_generic_alloca=
tion snd_soc_acpi soundwire_bus snd_soc_avs snd_hda_codec_hdmi snd_soc_hda_=
codec snd_hda_ext_core snd_hda_codec_realtek snd_soc_core snd_hda_codec_gen=
eric snd_hda_scodec_component crct10dif_pclmul crc32_pclmul polyval_clmulni=
 snd_compress polyval_generic ac97_bus libarc4 ghash_clmulni_intel snd_pcm_=
dmaengine sha512_ssse3 sha256_ssse3 snd_hda_intel sha1_ssse3
[ 1210.271851]  aesni_intel btusb snd_intel_dspcfg snd_intel_sdw_acpi gf128=
mul iwlwifi snd_hda_codec btrtl crypto_simd cryptd btintel tps6598x btbcm t=
ypec snd_hda_core btmtk rapl cfg80211 roles mei_pxp mei_hdcp snd_hwdep inte=
l_cstate ee1004 bluetooth igc snd_pcm spi_nor intel_uncore ov13858 mei_me s=
nd_timer thunderbolt v4l2_fwnode snd ptp mei i2c_i801 v4l2_async wdat_wdt m=
td pcspkr intel_lpss_pci wmi_bmof pps_core i2c_smbus intel_lpss videodev so=
undcore i2c_mux rfkill idma64 intel_pmc_core mousedev igen6_edac joydev ser=
ial_multi_instantiate intel_vsec mc pmt_telemetry acpi_pad acpi_tad pinctrl=
_tigerlake pmt_class mac_hid i2c_dev dm_mod sg crypto_user loop nfnetlink i=
p_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2 xe drm_ttm_helper =
gpu_sched drm_suballoc_helper drm_gpuvm drm_exec i915 hid_generic usbhid i2=
c_algo_bit drm_buddy ttm intel_gtt nvme drm_display_helper nvme_core video =
spi_intel_pci cec xhci_pci crc32c_intel nvme_auth spi_intel xhci_pci_renesa=
s wmi
[ 1210.271992] ---[ end trace 0000000000000000 ]---
[ 1210.271996] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
[ 1210.272061] Code: 89 ef e8 0e c4 ca dc f0 80 8b e9 0e 00 00 08 48 89 ef =
e8 6e b1 ca dc 48 c7 c7 68 70 44 c1 e8 82 12 cb dc 48 8b 43 08 48 8b 13 <48=
> 3b 18 0f 85 35 c8 06 00 48 3b 5a 08 0f 85 2b c8 06 00 48 89 42
[ 1210.272066] RSP: 0018:ffffbb3b0661bb98 EFLAGS: 00010246
[ 1210.272071] RAX: dead000000000122 RBX: ffff97bc8f92e000 RCX: 00000000000=
00000
[ 1210.272075] RDX: dead000000000100 RSI: ffff97bc8ba8b610 RDI: ffffffffc14=
47068
[ 1210.272078] RBP: ffff97bc8f92e4d0 R08: ffff97bc8424b5c0 R09: 00000000802=
a0026
[ 1210.272082] R10: 00000000802a0026 R11: 0000000000000001 R12: ffff97bc8f9=
2e000
[ 1210.272085] R13: ffffffffc12ff278 R14: ffffffffc12ff278 R15: ffff97bcf25=
acc50
[ 1210.272088] FS:  0000000000000000(0000) GS:ffff97cbd7300000(0000) knlGS:=
0000000000000000
[ 1210.272092] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1210.272096] CR2: 0000285c01b10000 CR3: 00000003d6e22000 CR4: 0000000000f=
50ef0
[ 1210.272099] PKRU: 55555554
[ 1210.272102] note: kworker/2:1[2275] exited with preempt_count 1


The kworker exiting obviously means that the kernel no longer responds to e=
vents
on any of the USB ports...

I hope you can track down the issue, let me know if you need any additional
details.

Regards,

Marc
