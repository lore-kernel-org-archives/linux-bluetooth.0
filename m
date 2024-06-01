Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2114.outbound.protection.outlook.com [40.107.121.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10F1514C6
	for <linux-bluetooth@vger.kernel.org>; Sat,  1 Jun 2024 13:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247798; cv=fail; b=Yf7hkPY5IqkoB4e05SGiXxXGtxRe+1nOhlPVY31KqSZhzCd3sE4dI0fouvbRVP15zsE5E2kXrf7/1lmll7m8cFzAlCRyF99z2dZKfDRr3NBtRe2ggALy4i5ApOiav6/lsU1ItUvp8KV1ZOETdgGejQNmPp3kvR94YRAh9RY1z9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247798; c=relaxed/simple;
	bh=S6jqikzFGNprdKnzYvmq16NqEqD2kI2BEA4mYty80lE=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=ZR5e6utCG2QhXJyGUBLXF68i5s7v3X+WJC7gULaGcuB1DDMBHrj6mLsWeSVa18IHv804QTgi5g7fGXoODH/yLElUlERpp5AXSKNhdlpHG2KAzMHBLO073gDUgdIFivzzIVRNemGQMzx/I0ZTfaAI3VtttuhnKC5h7Wm66+mOhIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk; spf=pass smtp.mailfrom=mdpsys.co.uk; dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b=H7sWT2UC; arc=fail smtp.client-ip=40.107.121.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b="H7sWT2UC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLV6rR4Wtu01Xw70wubUxkCM4XbwzFOU0kt7BFPvgmHOViQQc/fUQOplM94I4VkWJe0FqlO3lQJIbqrRhGOCqvUjekh8Pf++XL6Nvu96WZd0A+8/1052K8OOKNx4vzIjiZFmwdlgGrhW5krQ+Q3gs7faWmNbdr1ftNeSqrHYsWAMrZktEwOU6HfLb8nh+1UccT6mVjrhjC0xHfKNKAjGFelnMSeOdY739ziPzyQSyJuQoNNhKpHO1NnuCKHSr4QAjBNVW/RiSMqgUI2x1+28eJCmywHd3Qz6dkscTfKJiqFfyBueywOIsDr2edC9CmntsEDAA3FMOOzXIm3pBChg8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZV5/29acoS0Tr7FtC4jq93ehy2LzAdjRwGLekdsCDU=;
 b=ktvfIFGE+X0VckdSYlXqbq/iihOc/oKuafnT36MLwPcdWPhH6P7s4A4Wq8oVj802MW2tn2XYr46MhXfkP3ddjnXejN0+l1F7inv6AmYKCbA2ud8qkXZWmehP1l3Gecr840kXuZVi1MmukxKlch/M77Fi1lKZ2pLGAoYbSCu7vdgDtxaseRovVLqhgIg7WLH5l4VcVXS6vfgNoElU4AtMDqHJy8kLnFNb0tA1BYaaOTc0GVc/CIHi6kCgLlDO7Zocfy88Qd0VVlKJhvqrfxnREZEUWwMUbAOBnA8MI1FtSxHFvBA8DVqzN+rN3dcnKwAEClr2dR4hdAKrXH64MvIMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mdpsys.co.uk; dmarc=pass action=none header.from=mdpsys.co.uk;
 dkim=pass header.d=mdpsys.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mdpsys.onmicrosoft.com; s=selector1-mdpsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZV5/29acoS0Tr7FtC4jq93ehy2LzAdjRwGLekdsCDU=;
 b=H7sWT2UCsTu0TfBDrjwkwJrEpzajAWkqHRnWz3H6xp3weti3yw+CqCfXHyoAalpNx5g2pShX1JmZDBj/7oQXQ0qCAfWmaMsJVCaCnBNR9rh+d5JZEK5LWl2YMWxI3FKX3RHZs82eZmu8LMkhQFDw4VRZI0hPv/luiaAhdkcYiyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mdpsys.co.uk;
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b1::12)
 by CWXP123MB5738.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Sat, 1 Jun
 2024 13:16:33 +0000
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916]) by LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916%6]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 13:16:33 +0000
Date: Sat, 1 Jun 2024 14:16:31 +0100
From: Marc Payne <marc.payne@mdpsys.co.uk>
To: Chris Lu <chris.lu@mediatek.com>
Cc: Josh Boyer <jwboyer@kernel.org>, linux-bluetooth@vger.kernel.org,
	linux-mediatek@vger.kernel.org, linux-firmware@vger.kernel.org,
	Marc Payne <marc.payne@mdpsys.co.uk>
Subject: [BUG] MT7921AUN: broken Bluetooth firmware?
Message-ID: <ZlsfLwqWRUYV25Lz@mdpsys.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::29) To LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:b1::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB2972:EE_|CWXP123MB5738:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c1866f-8324-4c0c-dc9a-08dc823d0ea0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUZGOUthNU9qeWdjUVZGa2xJNG1ZSW9mZmFJRiswMGRXcWlpdThnRkd6ZzZw?=
 =?utf-8?B?SERTSHVjV0NoWDhrMXpKQUFMdXptWGkzOWJKVjFEM0k3WmE2VXpabGV2d0NY?=
 =?utf-8?B?MXI4MEFZZEdicnJsZjZTSE1XbTEwMHRBYTE3blc2Rm12bzUzUVQ3RlQwWHZt?=
 =?utf-8?B?cjNYdVYvL3hlZjZZL1FsR0o1eGo5TDd5UEhIRTU5K3JGQjd5RE5Mb1NxRldQ?=
 =?utf-8?B?VTdvVzhLRUtwK2lxL1I5K1JycyswUElubXpGNW9VN3JOL25WVjQ0RkcxQm1H?=
 =?utf-8?B?MlZTQ2R0N25tWEVwNEVZS3Z0SFNvZmZqQzRJWUllWWFsSUxHNW9aemw5a2oz?=
 =?utf-8?B?MG80UnhQQVN1Q3dWUCs5bGNKTmRnOS92TEIwM1h4R2ExQ0lzMmhIbGZka1lM?=
 =?utf-8?B?M0Zla2R6V0hYKzBLRmREbUVyUVMvSzFrUWpjV2ZhNU5nbEE1SUI0bnhMeGlv?=
 =?utf-8?B?QlN4Q3JQTG14WkhjWUhpcG9VbmZRVkFlaDZ0TXJPZWpHbEpXeFJEK0JSNjNT?=
 =?utf-8?B?Wnl1cE5IdTFFbUx1YmM5TXZuTHFyUUlOZ2Z0VjlCRGxHWVgvM1VsbGd4RGdU?=
 =?utf-8?B?Q2hvVEI1ZjVkRFUzVDR1aWFjMTcyZ0ZxdWZlRHhWL29BS1Q5bVhTTjhQUWVO?=
 =?utf-8?B?eHJMNS9WYjhYcHNBY21nUW5hdC9RTk1vUnc5VW9OYXlwc2d1VzlwV1ZmV3hC?=
 =?utf-8?B?RFh6WEI5L3BiNWFGcXk5NGZ1bDd5QVEyWEk4N1VmV29VY2R5aG5DOTBhbGdN?=
 =?utf-8?B?c3hsQ3lkV2hPU0tNdkwxcmFRd2VXUHk0WEtNMXY1a3NoeklES21VamZ5WUJz?=
 =?utf-8?B?SWdhRzBaT0FISUNiVE9tbm53OXBUVlBBWVZoeERaajRQSGY0bG1yWVBDbWcw?=
 =?utf-8?B?UURESHZoemRvbmFNbng4SDFxeVRGRFMycWFRMkt3UnlYQWw2NjhkOUdmZkVV?=
 =?utf-8?B?SFRWc1VIVWlMdFhRTThnT0o0ejU1WDVzVVZreFYxaFBqUVJlcnl6QWlSSmtK?=
 =?utf-8?B?elFMRlZjWmJSbFM2SlUvVDd5eWdDUCtnUmVuS2w1Y2JhVGhhZTdRWTN0Z0t1?=
 =?utf-8?B?WGFhSlhjYXRTUURCVFNqQUh5d1N2R2JWa2FxSkJxRHRyaXdyTVNJbitSK2I4?=
 =?utf-8?B?WlhqWVJiVXJWZVZubzZIVGl6RHpUMVdySWpDN00xZVNESXNrZ0lMRG14bmk4?=
 =?utf-8?B?N1R2Q3BnbloxZkNoZ251UkcwSFZvWkhQYTlEbFdlbnlFeXJnUG00ODQ1SWhr?=
 =?utf-8?B?ZWZqS0NhTnB5U3dsVHYyLzJ6Vm9ISWEvY3QrYU9ybGtpYnYvREppeldpNEVs?=
 =?utf-8?B?ZTJCZ09uTjA2dldVdGRCNTV3a25DVnpJbVZkcE95TmYzWitSY0dzZGFuS2ZM?=
 =?utf-8?B?Wk1zbVRaK29VcUtnWnpqKy9SRFA2akNScE5GMVBlNTNZWU1wK0docjErNk5a?=
 =?utf-8?B?K21LZXQ4c1UyR0l2ZG1uZlRhVGQwTTlKb3g3VHBXZEljWmh2Vncrc2Z0bVdj?=
 =?utf-8?B?NHA4Z0NLV2MwYmdMeFBoUTJMZllzUUQ0cU0xbHljbFFpSUtQSm5hK1FBYmtr?=
 =?utf-8?B?dmdpRFROaGZWUWZtdTQyTW5FcER1VHgrNjZOd3pQcjV0dmZEdG5TcU5wMTRS?=
 =?utf-8?Q?wfy+iXQDE03AI9tpg1yYLo4ulN735PMjeemMEgWdarmc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2N3MnRjb2p1aHpSdlBKSi83T1RBTG94NVFtZlYzNFk0M1FuVlordHBnNCtv?=
 =?utf-8?B?elNBWGs0VWtEZFdjcGsxZ1dVaitzeDM1YTlNMjltcUNyejNxalJGMWFrNkVO?=
 =?utf-8?B?T2FFc0FpeUg3ZkhLaGRHNUZxQ21yUHp5aFUvR2ZNRGcvQ3ZURVpBMkZ4UWs1?=
 =?utf-8?B?dVhkc1hEZzg1VGNwZVFXZFZEMXVpQUIvQldmTlNNTGdMMEVCck9hYUJSTUJo?=
 =?utf-8?B?enFHMWxPVlV5bkFZOW9sR201ekV6UmFxRzNXejc2KytKcTZWQm1rSi93WUQ5?=
 =?utf-8?B?NWVVd2FNVHNRTGVGOTFFbVIxK1B4WnlNcG5aNmpKVk5CRWRVVFF5cjF5cmRj?=
 =?utf-8?B?L2ZLYXI0anFSUDlBVUZ3R3QvNkpzQkZWR05Wd1J4Z1JrQWRKOWJzNExQVnFw?=
 =?utf-8?B?Y0xQM3VJSW5BWGJGNDVsaUwyZloxU2EzSklOeHF1MGxGMnowTUtrS0ZCKzBG?=
 =?utf-8?B?RDNveDdRR1ZGTEJyVXg4K2xYaFBuZkZZdnM2cU8yRTNkR0JUZ1I4WGlWMEdW?=
 =?utf-8?B?QmxQb084djlGYm9SRjh0WkxJSHd3bG9GTHRBZzVCY25iN2h0V3JYcVRVSHBE?=
 =?utf-8?B?S01ub3RMallHYkw2TjZhaks0bXZxMjMvVHFKMFUydmJ0WkpVS2piS091Nyth?=
 =?utf-8?B?Z2J6VDlnU0Y2Zyt4VmkxRmd4UHVneno2WkxFOVVyZTJzQlFpZEtkT2tvN05Y?=
 =?utf-8?B?aGt6UFlYYURaYm1TZy9tTUp1cHh0Y1NBSzlseWpjNisvSTVFOUFCSjJQREEr?=
 =?utf-8?B?RGlNRlZuc1doWXBvcGJrd1BzZCtzUUZmcjRtaExwMXZ0WjE2MDlIZVJOaUFL?=
 =?utf-8?B?TlVYV0pIeExQVzYwR2dwb0JnVmZUbUhqNWtRSnY0RG00NUJ1akFjRXFmNCtD?=
 =?utf-8?B?SHdEam5yNFFydjZBd0g5ZVg4RGwzOHEyZjBpc0EvNEVHQWE5OW8yakZnVTVR?=
 =?utf-8?B?Qk5SWTJ2ZzQzd1dXMENCaW5IbHRKaW4rUkJRdkdnRkJ6UUU2ZGhnbjgzMGN1?=
 =?utf-8?B?UmI5YjBNeTE1b0p2K08zaitOTGNSSWlmczJzWDBiVnR2MWZ5UzEwQktvM3hx?=
 =?utf-8?B?NWxkUUV6VnMyVFZaRUhGWGRneHhjTzArNUEraFBOQnQ5cjJZVnRaM1hjRnc2?=
 =?utf-8?B?KzMxSlFSZHVHOXl3RGsvUjc1VVptTytUdlJ0NEs5L0lhNGlXY09UYWdhdUxL?=
 =?utf-8?B?RjJiMnJ0RXRLNWlpWEdjTThUb0hTSTdGblJybjc2amtzbDh0dG02Uld0TzUx?=
 =?utf-8?B?VFovR3BGQmJkR1VydGNaRGJ0WjV0N1pwYjQwdUwxTEdaaW9ZZ0grVUF3U3hG?=
 =?utf-8?B?K1ViR0RvTWVwa0xPcEp1dlJKMzYrOFV5OVJVY0pRV0llM250Ykd4MmJwRzdD?=
 =?utf-8?B?MTVrbDE5WHZMaDlVMnlZczREWE5Ha05keU5CWFY3dEp2ZlVWYTJSWGxJeWtK?=
 =?utf-8?B?VGhQQXFoYnhucWRHL0poZ3JWNW0wU1NiTHRoMVdqbHlmTms1cVp3Vk1WaHRG?=
 =?utf-8?B?R1dwVURvK094cyt3OEZTSkpnOU5wZEx3UG5mU21jVXY3cEEyUHM3U2cwMWha?=
 =?utf-8?B?cDR4YWxXVndVbEVQYWNCdmEzdHVrY085R2dHOU5iVm9ldTR2cGwwL1RCOFRD?=
 =?utf-8?B?MEFiSURmb2NyWG9GanBvbEdVQlUxMCszOGZmM3BOaWJ5cE9xVEJYV3FXSCtp?=
 =?utf-8?B?T0JEay9ndjkyc081UVE1WlRsM3QyWWdPaUUxdFJlRTBFYUFaY2hidml6dlZM?=
 =?utf-8?B?cVcwM3UwUkNWV25xTUtPR0FybU1pemExa2IzTzFxWVUwSXNnNWhhemd5N3FZ?=
 =?utf-8?B?YVJOWlNHMldzSWJxUkJuWER6Z2t5VnkzRWpaZVBTNjlRRkM2TlllRjE3N2tx?=
 =?utf-8?B?UkNMNEVUNVR5bTgxaURYRkE3ZXBNVkxhM1A5M2pwckdhVnVqWGNIOTJNelU1?=
 =?utf-8?B?WVpVUUxOVDlNbzBNZk5yZ3Iyd1VlWDdPWW81ZUVWaG5uVFVjTXlwMFI3aW5r?=
 =?utf-8?B?Z0l6ZXBhTXlSQzlneU80SkRBcnVWUHVvYjBKSUlJbXZ3RjN4OHF6WWlVazNi?=
 =?utf-8?B?Sit2U1FaNWxiU240azVCZlQwNkdJQTNUZmpqYjRtbVBHT3g0dXI2Y3VwRWNN?=
 =?utf-8?Q?nKL/+mlD2hwirdy9JJmHgg4en?=
X-OriginatorOrg: mdpsys.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c1866f-8324-4c0c-dc9a-08dc823d0ea0
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 13:16:33.1195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 07eb37f3-62d1-4b5c-a7c4-ed2a24dbebc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWo2T2v29RJkYeXWvyPzlGAXipJ/3ry6pKXZEKEoulGjr1EWHtD3DC4t0r5H8PQRAqUFM7e8CxUx+dbfDSjimA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB5738

Hi Chris,

I have been investigating a problem with my new Alfa Networks AWUS036AXML based
on the MT7921AUN (ASIC revision: 79610010), testing on both Arch Linux kernel
6.9.2 and have also compiled 6.10-rc1 using the Arch .config (olddefconfig).
Both of these builds have the fix for the recent issue where the btusb driver
was attempting to load a non-existent firmware file. That is not the issue here.

The AWUS036AXML device fails to enumerate when using the latest Bluetooth
firmware BT_RAM_CODE_MT7961_1_2_hdr.bin version 20240219111427. Relevant dmesg
output below shows the firmware loaded and the device then appears to become
unresponsive. On the WiFi side, I can see that mt7921u_probe() calls
usb_reset_device() but the reset never completes.

[  152.838441] usb 4-3.2: new SuperSpeed USB device number 3 using xhci_hcd
[  152.857243] usb 4-3.2: New USB device found, idVendor=0e8d, idProduct=7961, bcdDevice= 1.00
[  152.857253] usb 4-3.2: New USB device strings: Mfr=6, Product=7, SerialNumber=8
[  152.857256] usb 4-3.2: Product: Wireless_Device
[  152.857258] usb 4-3.2: Manufacturer: MediaTek Inc.
[  152.857260] usb 4-3.2: SerialNumber: 000000000
[  152.876640] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time: 20240219111427
[  155.724422] Bluetooth: hci1: Device setup in 2793033 usecs
[  155.724427] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  157.924923] Bluetooth: hci1: Opcode 0x0c03 failed: -110
[  160.058375] Bluetooth: hci1: Failed to read MSFT supported features (-110)
[  162.191627] Bluetooth: hci1: AOSP get vendor capabilities (-110)
[  167.311755] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  172.644969] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  172.851546] usb 4-3.2: device not accepting address 3, error -62
[  178.191602] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  183.524779] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  183.731437] usb 4-3.2: device not accepting address 3, error -62
[  189.071351] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  194.404533] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  194.611138] usb 4-3.2: device not accepting address 3, error -62
[  199.951188] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  205.284338] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  205.490868] usb 4-3.2: device not accepting address 3, error -62
[  205.492271] usb 4-3.2: USB disconnect, device number 3
[  205.493355] mt7921u 4-3.2:1.3: probe with driver mt7921u failed with error -5
[  205.493526] usbcore: registered new interface driver mt7921u
[  210.830779] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  216.164074] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  216.370640] usb 4-3.2: device not accepting address 4, error -62
[  221.710510] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  227.043717] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  227.250328] usb 4-3.2: device not accepting address 5, error -62
[  227.250902] usb 4-3-port2: attempt power cycle
[  232.803541] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  238.136787] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  238.343260] usb 4-3.2: device not accepting address 6, error -62
[  243.683076] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  249.016241] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  249.222864] usb 4-3.2: device not accepting address 7, error -62
[  249.223440] usb 4-3-port2: unable to enumerate USB device


If I remove the BT_RAM_CODE_MT7961_1_2_hdr.bin firmware file, the device is
enumerated successfully and WiFi works, the Bluetooth controller is not
available, per the dmesg output:

[  358.372419] usb 4-3.2: new SuperSpeed USB device number 8 using xhci_hcd
[  358.390809] usb 4-3.2: New USB device found, idVendor=0e8d, idProduct=7961, bcdDevice= 1.00
[  358.390825] usb 4-3.2: New USB device strings: Mfr=6, Product=7, SerialNumber=8
[  358.390832] usb 4-3.2: Product: Wireless_Device
[  358.390836] usb 4-3.2: Manufacturer: MediaTek Inc.
[  358.390841] usb 4-3.2: SerialNumber: 000000000
[  358.399664] bluetooth hci1: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin failed with error -2
[  358.399678] Bluetooth: hci1: Failed to load firmware file (-2)
[  358.399683] Bluetooth: hci1: Failed to set up firmware (-2)
[  358.399687] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  358.479828] usb 4-3.2: reset SuperSpeed USB device number 8 using xhci_hcd
[  358.503178] bluetooth hci1: Direct firmware load for mediatek/BT_RAM_CODE_MT7961_1_2_hdr.bin failed with error -2
[  358.503187] Bluetooth: hci1: Failed to load firmware file (-2)
[  358.503190] Bluetooth: hci1: Failed to set up firmware (-2)
[  358.503193] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  358.540080] mt7921u 4-3.2:1.3: HW/SW Version: 0x8a108a10, Build Time: 20240219110958a
[  358.804074] mt7921u 4-3.2:1.3: WM Firmware Version: ____010000, Build Time: 20240219111038
[  360.394590] mt7921u 4-3.2:1.3 wlp0s20f0u3u2i3: renamed from wlan0


I have tried older versions of the firmware file from the linux-firmware.git
repository and the most recent version that worked as expected was 20230526131214 (commit
185f49df055ae37db22ac0c3179dd45deae34879), dmesg output:

[  812.319864] usb 4-3.2: new SuperSpeed USB device number 14 using xhci_hcd
[  812.338553] usb 4-3.2: New USB device found, idVendor=0e8d, idProduct=7961, bcdDevice= 1.00
[  812.338563] usb 4-3.2: New USB device strings: Mfr=6, Product=7, SerialNumber=8
[  812.338566] usb 4-3.2: Product: Wireless_Device
[  812.338567] usb 4-3.2: Manufacturer: MediaTek Inc.
[  812.338569] usb 4-3.2: SerialNumber: 000000000
[  812.347291] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time: 20230526131214
[  815.004726] Bluetooth: hci1: Device setup in 2596683 usecs
[  815.004730] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  817.116351] Bluetooth: hci1: Opcode 0x0c03 failed: -110
[  819.249711] Bluetooth: hci1: Failed to read MSFT supported features (-110)
[  821.382922] Bluetooth: hci1: AOSP get vendor capabilities (-110)
[  821.457115] usb 4-3.2: reset SuperSpeed USB device number 14 using xhci_hcd
[  821.481680] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build Time: 20230526131214
[  821.506714] mt7921u 4-3.2:1.3: HW/SW Version: 0x8a108a10, Build Time: 20240219110958a
[  821.605008] Bluetooth: hci1: Device setup in 122221 usecs
[  821.605021] Bluetooth: hci1: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[  821.763117] mt7921u 4-3.2:1.3: WM Firmware Version: ____010000, Build Time: 20240219111038
[  821.840029] Bluetooth: hci1: AOSP extensions version v1.00
[  821.840040] Bluetooth: hci1: AOSP quality report is supported
[  821.840453] Bluetooth: MGMT ver 1.22
[  823.355497] mt7921u 4-3.2:1.3 wlp0s20f0u3u2i3: renamed from wlan0


I believe the three timed-out hci commands are the result of the device reset.
Once the reset is completed everything works.

Based on my experience detailed above, this doesn’t seem to be a case of faulty
hardware. In fact, it appears that I’m not the only user experiencing this
issue, similar reports [1], [2]. It seems surprising that multiple firmware
versions have now been released that are incompatible with the MT7921AUN.

Is Mediatek aware of any issues with this firmware?

Why do firmware versions dated before 20231109191416 work fine?

Was a change made after version 20230526131214 that could have caused an
incompatibility with the MT7921AUN?

I’d be grateful for any insight and solutions that you can provide.

Thanks,

Marc

[1] https://forum.garudalinux.org/t/problem-with-alfa-mediatek-wifi-awus036axml-mt7961/34098
[2] https://bbs.archlinux.org/viewtopic.php?id=292420


-- 
Marc Payne
