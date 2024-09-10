Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2133.outbound.protection.outlook.com [40.107.121.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F701A254B;
	Tue, 10 Sep 2024 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725988153; cv=fail; b=N7nNx5veWaBL5FvMq+ivxHydoChdwYf0wAAitZE9Nd+eDhfBacRxeh5LWiz69a5fagJU5ik08lSSiorTrAlqAbZq5AHXvaPXpPF8sQvmU3X7Dae1I/pjRwjvSLtUnaNU9lzWi03CopSvZSkjiO4mUosbcJ0DRdSsO2jdC55XxeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725988153; c=relaxed/simple;
	bh=wR8kCeOYKykZMXlX8bE2NQFrKmNAaxSGW4Hkmc4iAXI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hiNXCxWcQiD09QczfG38yg5jIgj6tKTc/DlGnRDuTydgFXoIx3voYq3xczKJXI1v0Bs2WEn5BEJklLN0cB56AcXE96LzJZRoS7hG59DL0RcVH0JmM1GwhJWrZ4WPjiMlTo+u4LPHo5SFnCyc1JWOZA3Jmd641nfqP3p3ahxx2fQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk; spf=pass smtp.mailfrom=mdpsys.co.uk; dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b=n6ViVn1x; arc=fail smtp.client-ip=40.107.121.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b="n6ViVn1x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpXAAJAnH1ox6EwPSSgCVbNnhzcnEt8l436Xk4UPTRjiM1//GKkAZFN9NxmaOsWB90vGq0BefwXa9P/Z3BlnRY3nYBKr4V07IUXWQAksPVfeBIH6seO1YoFqXq9gGxEN7XH/8wZV9AxLc6AJ4vGuUzmIDeXWTb5kvjh4fTWpuBFxQQPO2sq7HvJSyp8gNLimyqoqimNow9ZtR0C3M1+fwk725IyLMU4CG+F0jZJ8IYrvaI70SdpB3VtzmnCC7fZ5KTpNKNey/Z5YI4BnqQFSl+/rblO8m7Z2Bv6nPdBLBLfC/dWA0i7IvV3hI1eoYVOs322reuHzV7nroQTXx466jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiNOf+DNIK1OWanrLr+An3gE+Qrk5QrKmEgpOcJppiA=;
 b=YC4hJ51U/d+PBLLxfxAUK3zAfEaI3P2f3e9UTh7yAUJdRowD0Qr/iRKPKKxHa8paBTedt+Z9XKpFg6ccAk8kQ1Uu45aqszSj5Dus5iY4dDVPvAit2fBtbODlXxncKv/LKVu/8LPDGgkKtcWH8D2CRmliwE1KuIx+E+VqkxupjjVmXETErAnNv07AAB18COEcpumc+5g43VT02/BS2l7YVBSo1/7C8K8vgMvw4WJRwX6yBc83QPLJjEQFc5m6uHbrlY5b0sjgHbYk5jzsQ1cOSJhH3eW9KK9nfYZysGXvl8DKROYX2WbHNlrQdCqrEBprs+eIpuPulE0soGiPJf0kWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mdpsys.co.uk; dmarc=pass action=none header.from=mdpsys.co.uk;
 dkim=pass header.d=mdpsys.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mdpsys.onmicrosoft.com; s=selector1-mdpsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiNOf+DNIK1OWanrLr+An3gE+Qrk5QrKmEgpOcJppiA=;
 b=n6ViVn1x3SfCXEJGG9NMZD3NldflkI3dc0NtuQDZ9VI4iVmoZC+xz657/DVF9kT7VbtFYCdF44QSX8RDXO7hMt9m/Y9nafGyPJIrsyrlkezGZeAqwB0a/XBcSBEbdIrJ7ASYOyrckw241/JwiT8GCnbwtuIRPLxKXzhAsPP/85I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mdpsys.co.uk;
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b1::12)
 by LO4P123MB6404.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 17:09:08 +0000
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916]) by LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916%5]) with mapi id 15.20.7939.022; Tue, 10 Sep 2024
 17:09:08 +0000
Date: Tue, 10 Sep 2024 18:09:05 +0100
From: Marc Payne <marc.payne@mdpsys.co.uk>
To: Hao Qin <hao.qin@mediatek.com>
Cc: Chris Lu <chris.lu@mediatek.com>, Sean Wang <sean.wang@mediatek.com>,
	Deren Wu <deren.Wu@mediatek.com>,
	Aaron Hou <aaron.hou@mediatek.com>,
	Steve Lee <steve.lee@mediatek.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-mediatek <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
Message-ID: <ZuB3omUkdUHLggYu@mdpsys.co.uk>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240822052310.25220-1-hao.qin@mediatek.com>
X-ClientProxiedBy: LO4P265CA0145.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::7) To LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:b1::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB2972:EE_|LO4P123MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 29f5ae2b-82a5-48db-7d55-08dcd1bb479c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnVoVnVCRUhoQm9LSXk1NmQ4SmE0UFdBbldWcEtqdW1RdmluS3dlaW1qaENw?=
 =?utf-8?B?MHk0a2NnYUszUTBLMngvTWdzUndOZ0sxK1F2TWIvVTRMNXFOd2ZuVEZ0a2w0?=
 =?utf-8?B?QjZXRWhMM2RFcThBNjkxZDZQKzBCUGJqNlFNbStBTE8wTlEwRFA0WlBzVmVT?=
 =?utf-8?B?TXhpczdFdnI5a01MZm8yNHZndldIbGwrYkhaYVFsekdMVW9LQ2YwdTJXclVh?=
 =?utf-8?B?dnNNTXBkL3pDMWRvMUdhaUVYT01Ic1ZBc0JwdjB0L1dONVAxaEE1RGxpY25j?=
 =?utf-8?B?THh3ZXlJa3V5Vmp0OUkyd3lsWE1jeVhUUWtkV1VQRitOZ0l3dFdBZWVPamlv?=
 =?utf-8?B?SGliYW8wRnJkT3MxTDhjMWRQeVNqNHZVRUJKYlEvTldUNFF2MDljWmJrSDNt?=
 =?utf-8?B?WWdYN3ZVTlB4VTA0SVcvUkF2b1VZd25NaE9sTjNXZFo0YzQwOGdCV21UdlRD?=
 =?utf-8?B?R3owblhWMy81SS9xQkVhdWhlaC9sM0U3OWZBWWJzMnZWUXBnUzBMTDBveTlL?=
 =?utf-8?B?S3ZEUHREM2dGWitoZ1JNVzBEWGtKQUhkcUFpS1NiMjJBSE05eG1SV0tJT09w?=
 =?utf-8?B?QmYxWWsvMGNkUjdLK1dCbEdLTVA3S1FPc0R4aDVHK2FBNHBYVTllZDhEZlEv?=
 =?utf-8?B?Y1pGN1NEU2pMV2QrU2ZIODB6V0ErSUhvZmM0UGJhZ2RDcElQSHBtcHFaTlo0?=
 =?utf-8?B?ZEc5WmJEaVhKdy9BVlFGd0hydFp1OUNjQ2NaRG9sVExPK2hIS0JpZXVmK2xR?=
 =?utf-8?B?RlU5TUtkdCtOSE5Cc1puSStoN09lNWtDaXoxbzYwQzB4aUdRbVQvQ3U2bURE?=
 =?utf-8?B?c0s0bkdNZW4reTFHY2hJdXFqQjdPTk1hQ2xyaDExQjd1ajlrb2ZVT1BhbDlC?=
 =?utf-8?B?L3d6ckdZN2ZGdlFrSWJLM1MrNFhxZFExeWQxMTk0SC9tMm5SVEthcWJVdUJY?=
 =?utf-8?B?VmpiYlZQUDhzTmJMTXdvNTZlc1NjVVZFUjU2LzZDeVNQWXFCTmR5SnlXQTRQ?=
 =?utf-8?B?M1E0ZGVSdy9KWnhuK1ZFSmw5emVWYnJYOGhiWDJjMytPZXkza1hVU3ZncE94?=
 =?utf-8?B?QkpEaE9xMkp4VE40N1VqQnNTUElROVZKOFh3SjJtUEhTbndWWnoxSTdBWjZ6?=
 =?utf-8?B?UFY0Nk9MOE1SL3BvY2pPOE8rRlVaazVTSmZnNWQvM2RDNXB5RVN6RFhlUWF4?=
 =?utf-8?B?WFZib0dqcjFFR3p1NmV0TDZVN0lISDlpcnVkM2NxTS9nWmZxdmtmTXBZRjBN?=
 =?utf-8?B?NXpWMnhTeDQyUy8rejZ6TkpCY0NNQXRneGZPVERxMzhiUTR2b2VmWGt6R0ZM?=
 =?utf-8?B?NWMxSS9TWHBMaFRUVUpVSTBBMVczeWYya1c4a2tlTmpGd0x6MkFVRzM0RXNh?=
 =?utf-8?B?L2htSFdhYldPZDZJSnhhWC9iYTVRYklaNlF4WnVqcmZiVDJnYVJKVk1hNHZU?=
 =?utf-8?B?UXdSRDJVVVR2WDRjQ2NmTVl1YWgxY0Z2Y2dSUTZGVk9tSlFiQ1lZYUxVcEJu?=
 =?utf-8?B?SFRsVmxVdUYvTGcyZHc3L1QvSGw4MnpKL0lwSWtaU3lZSXFVQUQrV3k2TmZk?=
 =?utf-8?B?ZitzUmJhVXBET3NPQjBuL044VHQ4dVIwdUJMeW5jZTRmQUYrMW5KQjNsZEhj?=
 =?utf-8?B?UnZLVHpkUlIwMFFpUkM3REVXSDRCRStWaGEvYWgrak1YN25hRTVKSG0wTDdJ?=
 =?utf-8?B?WGFRQW1DLy9uSEh2VUd0UWZsZ3pXZ1FDUElPbkxwQ3lRK09RNzdSQmp6TUlQ?=
 =?utf-8?B?enNuSllmSFJCWEcvOUZQRkJ4a3dkV2xHdHBtdGJFdWVxSjZxQ1NMa2RMTmtO?=
 =?utf-8?B?U2EyNERWSTRhUUZsNG54QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUVlL0pSSktpZktyV0JlTmRRLzZ4dHREbmFzWi9DMnFqOW8wWmVUSWNYdTFG?=
 =?utf-8?B?bEd1NVFZODhMZmtoVUczblJ6eFR4WnMzV3JweTNlRGp3T1hXWVNUTnFVYnN2?=
 =?utf-8?B?dmhjSFF6eG9nMDRxcjhhVU1ZM0tmbEF1eDlCZVB3ZVBmeWxycmRaeVBEdFI5?=
 =?utf-8?B?YjhuT29TVExCRHVGSHVPa1FRRlNOai9uOTlBT3ZWdFB0clhlWXIyLzJncnBu?=
 =?utf-8?B?Y0MycEltSERIZnRvN0RVU0NxVE9MNVdhQisxQ294MGcyRFI5YjBKN1c2Sk1v?=
 =?utf-8?B?VmhvUHZ5dEFRcXRtUldXeGN3Wk1YL0Jhc0E3R3dhVFNzd08wM1lHTUhFWjBT?=
 =?utf-8?B?UnB1LzAvVUw4c21RTW1EMVY0OTBKd0VBZFJxY0NNdjdPci82QlordWJOTFFG?=
 =?utf-8?B?Zmk4M0NNWTRWRnVPd21tbnhkK0NCTjUrcWF1M0l1SHZRZUhIbHRlMUxvNFZi?=
 =?utf-8?B?VEFQem9vS3FoZTkxTk1EK3hjVW9RSWRFMjhGNVowa2MzZ1ZXQlpON2puMSto?=
 =?utf-8?B?NkwrWmdibThkRm9oaEVNTituWGNOSWphOHI0ZWlpZy8zWkZFNHBpOVM5NFpN?=
 =?utf-8?B?bjZnMy9EMGs3SktjZnNBTmVqbTh1ejByTkpJOVpvcHRMSkphdC9lY0o3dndP?=
 =?utf-8?B?ekl4czVFQ3VCa3NEejlsVldrNmFIdkVTMEVyd3RtOHkzNjBPVk5GTEVrbTM3?=
 =?utf-8?B?aDJsaTZsczdEalg5ZEt3aW5OUEhrOVhyMU1KTk5LaXNmWnM2MDF3R2F4cGlh?=
 =?utf-8?B?emVpY1lZRGFRSk1obXltUGs4SUU3TmFoTXYzczhTZjA3cnZheVFxMFA3cGR3?=
 =?utf-8?B?Wm1zdWt5QkYxZGVDQ1dJVkpOZ0d4bzJhRzhGT2xKTm93OHBhM2k5NVBSU2tr?=
 =?utf-8?B?Y2xhSVQzUWgyTnhTRXl4TUlWa08yamliVDhWR1VrQmlzazZMUTl0QjUzUldh?=
 =?utf-8?B?dFQ3NTNqTkZPOXZHdmZQRW9CS2kzSXZ1USt2L29WeXVteFJCVUZIeHBsZjVZ?=
 =?utf-8?B?cTdxQmV2RmpzSlJnaC9HbFc1T1pKTWZ6T0lKclRyRGJrTDNialZZMjNQY0Rx?=
 =?utf-8?B?dE9oRUYyOXQyaUhYUGlDZVhNZ0w1dytTN1RaM2did2ZwdnhSNmJCdDJXWHdC?=
 =?utf-8?B?UnZHK3AzY3NXelpYK09DdGpPU2Vvdmx2bFZ5UlpMZ0RIUkpBVEJzaHpTaFB1?=
 =?utf-8?B?REN3dHF4V2ZUanhSMFQ3TW1yNHRyaUtvNXBTekxmRS9mM3dBb052NnVMK2wv?=
 =?utf-8?B?WUxRVjJKVGIrakM1emhqQ1pPNHhrM2NEZWFPVjdqMUZwbGJPUTlqMEttWlFP?=
 =?utf-8?B?UUswVzZ2a3A1SDFxcHFvTDFSWlg5ZXErUkRJNW1PMG9zbEhORzRyM1RhOUpO?=
 =?utf-8?B?aFE5bmw4b2tIK2NWQTRwb3lVdGZQbmYrbEZLbVk0aENlUEp5OEZJamgrbHZU?=
 =?utf-8?B?SXEyRUZzTHFOTXFXaVlyV1VQUXNZaFJ0V3ZGbmJaOUM4ejNsMkdQcTVSZjhB?=
 =?utf-8?B?RUMrY1lmVVB0Y3hpc2RDdVlaR3JDZ3ZQSlVGT0k0a0xFaW45anJKaFZaQllD?=
 =?utf-8?B?bjR0Qk80RURYa1B0ZVpuTWRkdHlybytFVHlLeDlZSk9xYU5yZXc0aUJtMGpE?=
 =?utf-8?B?cWFyNWlmSDZsQ2dGSWx4VnNDd3BjNytobWlXWnQwdWU3VTQ3WUlUcGJRZzQz?=
 =?utf-8?B?eGUwa3pFS21FTlR2NkUvNHdHanIxeFZUQkNOSUUyU1kva0VnK3pBL0N4Y0xC?=
 =?utf-8?B?M1YvTVhQY2xkTyt1eDJJQTNlUVd1VUNRWWh5ekdDaGdJT3FkZTBlNngxMm94?=
 =?utf-8?B?VnJFRTlZalRFd3E0U1BzY09FSHlwdDAyajE1ZjM1bjdjRWpLUUNqRnJpUGtC?=
 =?utf-8?B?WGhhbVRLeUE4d0NQRlJwdHlHYVpWYnVaWWxsUCszdTFvQVI0NGR6ampiWmZt?=
 =?utf-8?B?OEVlR2NlVGtrSFMzTXRGTDREajJvcGdyY0l5bDdTMWlUZlltNHpNN25mOGl3?=
 =?utf-8?B?VzUyV09GaExxK2ZRcFEzQkFUdkFXQjF1VTVmRUdlQlljQ1BIUmFvQklEa1pr?=
 =?utf-8?B?dGU2cnRqS1ptYW5LcDlDNVVBYTVnVVMrNlRwVlc5OStPTTY2N1FNZU1ONmh4?=
 =?utf-8?Q?590hwsQoyyPSSn11QiuGMt8ca?=
X-OriginatorOrg: mdpsys.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 29f5ae2b-82a5-48db-7d55-08dcd1bb479c
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 17:09:08.0036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 07eb37f3-62d1-4b5c-a7c4-ed2a24dbebc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8i+KshrZADzFupLjJN3UKZ9BWl0CTcBMwGERkKfqWcmrmp3WVJ0OpfRrBeagTYbBeY8kw5mGP4rOpQsx28x/wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO4P123MB6404

Hi,

The 22/08/2024 13:23, Hao Qin wrote:
> Remove resetting mt7921 before downloading the fw, as it may cause
> command timeout when performing the reset.
>=20
> Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 2b7c80043aa2..a46f70135cbd 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1326,7 +1326,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>  		fwname =3D FIRMWARE_MT7668;
>  		break;
>  	case 0x7922:
> -	case 0x7961:
>  	case 0x7925:
>  		/* Reset the device to ensure it's in the initial state before
>  		 * downloading the firmware to ensure.
> @@ -1334,7 +1333,8 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> =20
>  		if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
>  			btmtk_usb_subsys_reset(hdev, dev_id);
> -
> +		fallthrough;
> +	case 0x7961:
>  		btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
>  				      fw_version, fw_flavor);
> =20
> --=20
> 2.18.0
>=20

[Original regression report
https://lore.kernel.org/linux-bluetooth/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/]

Thanks for the patch, I have tested it on top of v6.11-rc7 and can confirm
that it resolves the initial command timeout issue.

Unfortunately, when using the latest firmware version 20240826151221 from t=
he
linux-firmware repo I'm still seeing "Mediatek coredump end" errors
followed by MSFT and AOSP errors. The device then appears unresponsive
and the kernel eventually gives up attempting to enumerate:

[  230.042936] usb 4-3.2: new SuperSpeed USB device number 4 using xhci_hcd
[  230.065228] usb 4-3.2: New USB device found, idVendor=3D0e8d, idProduct=
=3D7961, bcdDevice=3D 1.00
[  230.065237] usb 4-3.2: New USB device strings: Mfr=3D6, Product=3D7, Ser=
ialNumber=3D8
[  230.065240] usb 4-3.2: Product: Wireless_Device
[  230.065242] usb 4-3.2: Manufacturer: MediaTek Inc.
[  230.065245] usb 4-3.2: SerialNumber: 000000000
[  230.101915] Bluetooth: hci2: HW/SW Version: 0x008a008a, Build Time: 2024=
0826151221
[  233.005938] Bluetooth: hci2: Device setup in 2862056 usecs
[  233.005983] Bluetooth: hci2: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[  234.306071] Bluetooth: hci2: Mediatek coredump end
[  235.092729] Bluetooth: hci2: Opcode 0x0c03 failed: -110
[  235.192772] Bluetooth: hci2: Mediatek coredump end
[  237.226157] Bluetooth: hci2: Failed to read MSFT supported features (-11=
0)
[  239.359435] Bluetooth: hci2: AOSP get vendor capabilities (-110)
[  244.479726] usb 4-3.2: Disable of device-initiated U1 failed.
[  249.599598] usb 4-3.2: Disable of device-initiated U2 failed.
[  259.839215] Bluetooth: hci2: Failed to write uhw reg(-110)
[  259.839240] usb 4-3.2: Disable of device-initiated U1 failed.
[  264.959343] usb 4-3.2: Disable of device-initiated U2 failed.
[  270.079038] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  275.412299] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  275.618812] usb 4-3.2: device not accepting address 4, error -62
[  280.958852] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  286.292034] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  286.498618] usb 4-3.2: device not accepting address 4, error -62
[  291.838759] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  297.172018] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  297.378477] usb 4-3.2: device not accepting address 4, error -62
[  302.718497] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  308.051867] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  308.258345] usb 4-3.2: device not accepting address 4, error -62
[  308.260253] usb 4-3.2: USB disconnect, device number 4
[  313.598307] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  318.931586] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  319.138278] usb 4-3.2: device not accepting address 5, error -62
[  324.478224] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  329.811444] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  330.018032] usb 4-3.2: device not accepting address 6, error -62
[  330.018489] usb 4-3-port2: attempt power cycle
[  336.211505] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  341.544640] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  341.751239] usb 4-3.2: device not accepting address 7, error -62
[  347.091375] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  352.424563] xhci_hcd 0000:00:14.0: Timeout while waiting for setup devic=
e command
[  352.631136] usb 4-3.2: device not accepting address 8, error -62
[  352.631538] usb 4-3-port2: unable to enumerate USB device


Interestingly, if I revert back to an known-good firmware version
20231025113744 along with your patch, the device enumerates and works fine:

[ 4001.366725] usb 4-1: new SuperSpeed USB device number 4 using xhci_hcd
[ 4001.385840] usb 4-1: New USB device found, idVendor=3D0e8d, idProduct=3D=
7961, bcdDevice=3D 1.00
[ 4001.385855] usb 4-1: New USB device strings: Mfr=3D6, Product=3D7, Seria=
lNumber=3D8
[ 4001.385860] usb 4-1: Product: Wireless_Device
[ 4001.385863] usb 4-1: Manufacturer: MediaTek Inc.
[ 4001.385867] usb 4-1: SerialNumber: 000000000
[ 4001.398010] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time: 2023=
1025113744
[ 4004.275656] Bluetooth: hci1: Device setup in 2812288 usecs
[ 4004.275661] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection c=
ommand is advertised, but not supported.
[ 4004.355137] Bluetooth: hci1: AOSP extensions version v0.96
[ 4004.355156] Bluetooth: hci1: AOSP quality report is not supported
[ 4004.355698] Bluetooth: MGMT ver 1.23

But if I then disconnect it, I get the Oops that I shared in my original
regression report:

[ 4043.436215] usb 4-1: USB disconnect, device number 4
[ 4043.437308] Oops: general protection fault, probably for non-canonical a=
ddress 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
[ 4043.437332] CPU: 2 UID: 0 PID: 3698 Comm: kworker/2:0 Not tainted 6.11.0=
-rc7-00001-g0e2ad6528188-dirty #71 d90fb9085e2a0686ac48ebcc408d97b104c6fbf1
[ 4043.437352] Hardware name: Intel(R) Client Systems NUC12WSHi7/NUC12WSBi7=
, BIOS WSADL357.0088.2023.0505.1623 05/05/2023
[ 4043.437361] Workqueue: usb_hub_wq hub_event
[ 4043.437386] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
[ 4043.437548] Code: 89 ef e8 ae d4 5c c1 f0 80 8b e9 0e 00 00 08 48 89 ef =
e8 0e c2 5c c1 48 c7 c7 68 60 52 c1 e8 22 23 5d c1 48 8b 43 08 48 8b 13 <48=
> 3b 18 0f 85 f5 c7 06 00 48 3b 5a 08 0f 85 eb c7 06 00 48 89 42
[ 4043.437560] RSP: 0018:ffffa10f4ae43b98 EFLAGS: 00010246
[ 4043.437574] RAX: dead000000000122 RBX: ffff8cf86c160000 RCX: 00000000000=
00000
[ 4043.437585] RDX: dead000000000100 RSI: ffff8cf7b7d16c50 RDI: ffffffffc15=
26068
[ 4043.437594] RBP: ffff8cf86c1604d0 R08: 0000000000000000 R09: ffff8cf7401=
d8e10
[ 4043.437602] R10: ffffa10f4ae43ba0 R11: ffffa10f4ae43ba8 R12: ffff8cf86c1=
60000
[ 4043.437610] R13: ffffffffc1416278 R14: ffffffffc1416278 R15: ffff8cf7f8d=
73850
[ 4043.437620] FS:  0000000000000000(0000) GS:ffff8d0697300000(0000) knlGS:=
0000000000000000
[ 4043.437632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4043.437641] CR2: 00007f98d66dc000 CR3: 0000000131124000 CR4: 0000000000f=
50ef0
[ 4043.437651] PKRU: 55555554
[ 4043.437658] Call Trace:
[ 4043.437670]  <TASK>
[ 4043.437680]  ? __die_body.cold+0x19/0x27
[ 4043.437700]  ? die_addr+0x3c/0x60
[ 4043.437716]  ? exc_general_protection+0x17d/0x400
[ 4043.437738]  ? asm_exc_general_protection+0x26/0x30
[ 4043.437760]  ? hci_unregister_dev+0x45/0x1f0 [bluetooth 6dca047d1088401e=
195d97746b2b4936e5756d61]
[ 4043.437930]  ? hci_unregister_dev+0x3e/0x1f0 [bluetooth 6dca047d1088401e=
195d97746b2b4936e5756d61]
[ 4043.438080]  btusb_disconnect+0x67/0x170 [btusb 5bf8186d9cab4c5be1762247=
dadb6753a7c72a7f]
[ 4043.438108]  usb_unbind_interface+0x90/0x290
[ 4043.438130]  device_release_driver_internal+0x19c/0x200
[ 4043.438150]  bus_remove_device+0xc6/0x130
[ 4043.438166]  device_del+0x161/0x3e0
[ 4043.438182]  ? kobject_put+0xa0/0x1d0
[ 4043.438196]  usb_disable_device+0x104/0x220
[ 4043.438213]  usb_disconnect+0xe6/0x2e0
[ 4043.438231]  hub_event+0x7f9/0x19d0
[ 4043.438250]  ? __pm_runtime_suspend+0x47/0xc0
[ 4043.438269]  process_one_work+0x17b/0x330
[ 4043.438287]  worker_thread+0x2c6/0x3f0
[ 4043.438304]  ? __pfx_worker_thread+0x10/0x10
[ 4043.438318]  kthread+0xcf/0x100
[ 4043.438337]  ? __pfx_kthread+0x10/0x10
[ 4043.438354]  ret_from_fork+0x31/0x50
[ 4043.438367]  ? __pfx_kthread+0x10/0x10
[ 4043.438382]  ret_from_fork_asm+0x1a/0x30
[ 4043.438403]  </TASK>
[ 4043.438408] Modules linked in: uhid mt792x_usb mt7921_common mt792x_lib =
mt76_connac_lib mt76_usb mt76 ccm option usb_wwan cmac algif_hash algif_skc=
ipher af_alg sr_mod cdrom bnep mousedev joydev vfat fat snd_sof_pci_intel_t=
gl snd_sof_pci_intel_cnl intel_rapl_msr snd_sof_intel_hda_generic intel_rap=
l_common soundwire_intel intel_uncore_frequency soundwire_cadence intel_unc=
ore_frequency_common snd_sof_intel_hda_common snd_sof_intel_hda_mlink snd_s=
of_intel_hda snd_sof_pci snd_sof_xtensa_dsp snd_sof iwlmvm snd_sof_utils sn=
d_soc_hdac_hda snd_soc_acpi_intel_match soundwire_generic_allocation snd_so=
c_acpi soundwire_bus snd_soc_avs r8152 x86_pkg_temp_thermal intel_powerclam=
p libphy snd_soc_hda_codec coretemp mac80211 snd_hda_ext_core kvm_intel snd=
_soc_core snd_hda_codec_hdmi cdc_ether hid_generic uas usbnet snd_hda_codec=
_realtek snd_compress kvm usb_storage mii usbhid snd_hda_codec_generic ac97=
_bus snd_pcm_dmaengine snd_hda_scodec_component snd_hda_intel libarc4 snd_i=
ntel_dspcfg btusb crct10dif_pclmul snd_intel_sdw_acpi
[ 4043.438617]  crc32_pclmul iwlwifi btrtl snd_hda_codec polyval_clmulni bt=
intel polyval_generic btbcm ghash_clmulni_intel sha512_ssse3 btmtk tps6598x=
 sha256_ssse3 snd_hda_core typec sha1_ssse3 cfg80211 bluetooth aesni_intel =
snd_hwdep roles gf128mul crypto_simd snd_pcm cryptd mei_hdcp mei_pxp rapl e=
e1004 ov13858 snd_timer intel_cstate igc spi_nor intel_uncore i2c_i801 thun=
derbolt snd v4l2_fwnode mei_me v4l2_async ptp wdat_wdt i2c_smbus mtd pcspkr=
 wmi_bmof intel_lpss_pci videodev mei pps_core soundcore intel_pmc_core i2c=
_mux intel_lpss rfkill idma64 igen6_edac intel_vsec serial_multi_instantiat=
e mc pmt_telemetry pinctrl_tigerlake pmt_class acpi_pad acpi_tad mac_hid i2=
c_dev dm_mod sg crypto_user loop nfnetlink ip_tables x_tables ext4 crc32c_g=
eneric crc16 mbcache jbd2 xe drm_ttm_helper gpu_sched drm_suballoc_helper d=
rm_gpuvm drm_exec i915 i2c_algo_bit drm_buddy ttm nvme intel_gtt drm_displa=
y_helper nvme_core spi_intel_pci cec xhci_pci crc32c_intel spi_intel nvme_a=
uth xhci_pci_renesas video wmi
[ 4043.438898] ---[ end trace 0000000000000000 ]---
[ 4043.438905] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
[ 4043.439039] Code: 89 ef e8 ae d4 5c c1 f0 80 8b e9 0e 00 00 08 48 89 ef =
e8 0e c2 5c c1 48 c7 c7 68 60 52 c1 e8 22 23 5d c1 48 8b 43 08 48 8b 13 <48=
> 3b 18 0f 85 f5 c7 06 00 48 3b 5a 08 0f 85 eb c7 06 00 48 89 42
[ 4043.439048] RSP: 0018:ffffa10f4ae43b98 EFLAGS: 00010246
[ 4043.439058] RAX: dead000000000122 RBX: ffff8cf86c160000 RCX: 00000000000=
00000
[ 4043.439065] RDX: dead000000000100 RSI: ffff8cf7b7d16c50 RDI: ffffffffc15=
26068
[ 4043.439072] RBP: ffff8cf86c1604d0 R08: 0000000000000000 R09: ffff8cf7401=
d8e10
[ 4043.439078] R10: ffffa10f4ae43ba0 R11: ffffa10f4ae43ba8 R12: ffff8cf86c1=
60000
[ 4043.439085] R13: ffffffffc1416278 R14: ffffffffc1416278 R15: ffff8cf7f8d=
73850
[ 4043.439091] FS:  0000000000000000(0000) GS:ffff8d0697300000(0000) knlGS:=
0000000000000000
[ 4043.439100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4043.439108] CR2: 00007f98d66dc000 CR3: 0000000131124000 CR4: 0000000000f=
50ef0
[ 4043.439116] PKRU: 55555554
[ 4043.439122] note: kworker/2:0[3698] exited with preempt_count 1

So, in summary, it looks as though there are two issues here:

1. The latest firmware does not seem to work well with this chipset,
   perhaps it is crashing after loading?
2. The Oops in the hci_unregister_dev function suggests some HCI
   registration bug.

Let me know if I can provide any further assistance.

Regards,

Marc

