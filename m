Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794435542;
	b=wbDHZl6oHr34fJocDMWSi9WO3VfxuKB7yLzMoX7zZMRqCNORHZi473eCooc+F+clnnRu
	 uXjNxGjeROlJSq41lWHL0z/F9FpJJ75CBX5sxwQHPCNSRuQLTNnjsEonEbbVoh/52RV/5
	 WNExCDAnGqW1pkOLfHvVpFleOYu+I4fJh13f4IxNPzAhHM4eex7WFxCL0LJekqypYrk1V
	 OU2ip6iR1HjxuZW29HnuSD3ubLmzCxC6TCgWILsU6FbczOfWa7WOd10aaBhq9WtRZ46YW
	 QrLNUNN0NxH6DAh6uMJ71Ob/ms/ihSl2WQDh5I/JGEv3rG6O+dOjjRfBY83QZy8268Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435542;
	h=DMARC-Filter:Received:Received:Message-ID:Date:User-Agent:From:
	 Subject:To:Cc:Content-Language:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ehfYjNx03i5K8ciSXlPMb6MJQRO870uxeaOxOPrgJVM=;
	b=HJBKCWMqXE2TTpPmzjG+nBtbRO5kooopVYuOQ3JQwqKMgtpi7SC6p7O7Z7W5CbWK5aYe
	 tXqD9FBQaEljGjxvAPBxDhmaXSlXXPvuTmDm9pRvVGIkj5lWBjAWyLCSGjQWWYEEiS+Ym
	 Zhb4UBRKoL/Re9oHrrRAPweaK2yfXGJDzXcn2j7TLvly2zrwrXPfy82rPRRW8EHFYxpF9
	 85ZVL8qn6KRamaGX//mhfWIYjELvAyhw9JDpANyzrdg584euhFG5O7VCkshPHTdlfNIxF
	 aPwiTx40BOdF2c85euAhhD49eMCqxThKuJqe87Bdy6/XF3yuPfxNBYHbzt9OQexO4og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=jwillmer.de;
	spf=pass smtp.mailfrom=jwillmer.de;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.33.36
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazolkn19011036.outbound.protection.outlook.com [52.103.33.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C9606A327
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 22:19:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 531C9606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jwillmer.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jwillmer.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fMjXkRWTFDttEFWYj5XbvTKazNaOB8/IDRGyS2MdgV31dzkJ86i+FjS3953m1+IGNnFLv7DDOpUenSKTgLCnsjh4+fV+sjq1dh3e4SifCqwoTJ7IyIAyxWjvPCChxm83wS9NSShCWP/nAnXlaaXPOudKUBrwHIc+IgUhTI4Q4I14zkOJ4Z9qN8WaS/mt8oZ/7CSNRuBmxGu/9O7G6BU/jV4hqFD4EsboDLT0M3EzXHGs8Z+WSE/N0TMIGRft8G8uYKy467fu87b+NYqIryYtzDyN5B9BiBjvnetlxEWiZWHpLTSlxfndtuK8ChjDpf8NZaHH91tu4/Uo9g882Q0n2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehfYjNx03i5K8ciSXlPMb6MJQRO870uxeaOxOPrgJVM=;
 b=tSLnWOJxTKjk3o35Lf9u19I7l4VpSrkEky+KsXESXusu+IuQ2+LvP/3/nyDX3T4EX6lpBR2V84NIxPKgx5twZXE1b6b5C48jG0flDXNNs9GfyY0dN8o2A0F8n2g2D1ICQjLjFraOrSSNGWv6WCPn5DILFbdtAZ6WvaebPjxLZXyDdRl3/y2iYwABXzCftcqF7lASS6pHuV66CGMNPTAVl1rhBRPPKv4YvtAFiBkv054d8ikj6QUlVmX4K3FK3YcK0jCMMJrAUYmaAoWRef3lHO41cfdrBj26rOc95scaank9rTyxf76AzeTrjFIyqQi7uzU0vG7eUh9HvvJ7V3ArRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from VE1PR08MB5247.eurprd08.prod.outlook.com (2603:10a6:803:10d::16)
 by AS2PR08MB10053.eurprd08.prod.outlook.com (2603:10a6:20b:640::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 22:18:58 +0000
Received: from VE1PR08MB5247.eurprd08.prod.outlook.com
 ([fe80::c16c:8c20:cce6:13fc]) by VE1PR08MB5247.eurprd08.prod.outlook.com
 ([fe80::c16c:8c20:cce6:13fc%4]) with mapi id 15.21.0592.009; Wed, 11 Nov 2026
 22:18:58 +0000
Message-ID:
 <VE1PR08MB5247BE2C05F27B1A2675FA25D5712@VE1PR08MB5247.eurprd08.prod.outlook.com>
Date: Wed, 11 Nov 2026 23:18:57 +0100
User-Agent: Betterbird (Linux)
From: Jens Willmer <info@jwillmer.de>
Subject: [PATCH] Bluetooth: btusb: Wait for setup to finish before system
 sleep
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ce::11) To VE1PR08MB5247.eurprd08.prod.outlook.com
 (2603:10a6:803:10d::16)
X-Microsoft-Original-Message-ID:
 <8452911b-7c02-4bec-ba2c-990b54e62571@jwillmer.de>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB5247:EE_|AS2PR08MB10053:EE_
X-MS-Office365-Filtering-Correlation-Id: dc84b7d9-7f98-49d1-400c-08df4041c824
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|15080799012|5062599005|24021099003|23021999003|6090799003|5072599009|39105399006|41001999006|20031999006|19110799012|8060799015|4140399003|25010399006|440099028|3412199025|56899033|40105399003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3FZaVhYQTdRTCtlaWc0ZEdnQ0ppMFhJdWZZTk91Q1V6Vm02NCtUZXE1RGxL?=
 =?utf-8?B?VEtCYnY4eFlEQjZyQjFGWXk5YVorYnE1YlZ0UWlFTE96eTJYRXVwaExRaVVh?=
 =?utf-8?B?U2U0N200ZTlnekJLT0hvcFplTlc0YzY1Q04wT0xrK1hKelNMSGsrQk5FUzZW?=
 =?utf-8?B?OStLaCtYa2duMzhRa2kvVTg2U0Y5M0MxZ1RjZUZSVzJzTEswM3hHSXptUmp4?=
 =?utf-8?B?WmtXNFhxWG5JTWFOUXlZZmU2Skl6VXBwTG1XL3NNbnVmeXpQMTRkOXAzaWJF?=
 =?utf-8?B?WnhMSGNsTUdadXE1L003UEtxWlFDa3BNYktXbDZUQ2Qzb29yV3RuVWU4Q1RZ?=
 =?utf-8?B?MVhvclZqRm1Zb0xBSDZjNlJhSTY0a0JYbW5sVjdERjZoeGR6dmM5UTI2ZlVE?=
 =?utf-8?B?Z1AzMnBXUG9qV3ptUGtqQXBuaE1pUFE1TU4wRzd0ZTczb0JNdjVxb1VoUk9U?=
 =?utf-8?B?NzFIY0l2ZG5seFBmYXg4UnhxR3dCTXBsRmNzRmEzemN5NjhSODVaUkJRY09P?=
 =?utf-8?B?eVUvWDN6TDdmV2MzTmJrR051Wk1qYXdPMmFHOUIxamZQUUxkU0JnWWhUNTRx?=
 =?utf-8?B?RkQ0RWs0c1MzbG9waWJwK1RtaEd3OGhoS0owNTdsa2JERGdnY1c5RnBvajNU?=
 =?utf-8?B?Tno4NzdNYnlkSWFYMlNCZmRDU3dOWm03SjB0eUdMQmp5YldVQ3dIU2lpcDRo?=
 =?utf-8?B?eklocXRhQ0FGYzVyczBreGNIL2lrN2t4c1I3Zy9SM29vczFXbktUamRoUjkv?=
 =?utf-8?B?ekJPTEdYUlhmNTRLR2lGdTlTOFJtLzBueWpCbFFkV0huanR6OW1mL2VUYzhq?=
 =?utf-8?B?eGhOQ0MzYkJrZjd2UW1pVnRPc1hsdWdhU21oWkI5ek9HeTJid1FFbElwN1Z0?=
 =?utf-8?B?NFJPVlVpOUtPQ04rOWhPRHRVdFJJVHlKVVNPL1lGcWdpeENYQmdmNWlvbm1I?=
 =?utf-8?B?ZEtsTmZJZHBuQU9idVZyeFdzYTdmN29CWDZqOXFLSmQ4OStZSGJDNlZMZzZM?=
 =?utf-8?B?Vy9Sa1RBQVRrbC9EQkovWEFqZWhRYXRJQWNlUXU4R1IySDBLNTNqRTc2d0h5?=
 =?utf-8?B?NWNKTDJhbmFJSmlsenN2SEhKek5ObTh0M0tiQUtPRWRlUUxGWFdHRndMbmMy?=
 =?utf-8?B?UzBKUmpFeGRqamVnWDRMM3ZhcDUrNU5OMmRNK0wxL3lXaytJTjZWbEQzVnJ4?=
 =?utf-8?B?NGsyNGVranR0dmNGa1R6NW9xRlhjRG5DeTBVSE4yNUR1ZGVtN3FwM1M5dFg0?=
 =?utf-8?B?SE9pclRnYUYxdzJuOTE2bFo0UklMd3NjQmo5SFp3SkNYY2xHK0phN01udVNh?=
 =?utf-8?B?cDVGUlVBSmg4cytRVVhzRGhvYkptT3BtMm05b01VQUZudTZZMnh3VDF0bE9E?=
 =?utf-8?B?UENsRGRlMmE5L05jS3hPY0Zub0QrWitwMEx0TEtYdTM4SlZSbUY5S3NJc1NY?=
 =?utf-8?Q?iPrR/V0e?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blVERjFyOGpOd2FaRElUaXFMcEZMSzFDN0R5S3ZnZC9rd1QvRmlmQUVweW1m?=
 =?utf-8?B?UDYrQTJvcjVTUlBIYWIvaUpNU3FYd1lmRWNLU21aWTlOeFpiY0F4anpYejBB?=
 =?utf-8?B?QTNaUW05OFNOeXhGY2FEdUdkVFZZeUJWMGxpa05OM0xMY296c2VSZVZoYStZ?=
 =?utf-8?B?eldhRkZhWnk5ZllUcTRPQk15UGV1RVI1a1VLbHIvSzU2TWtQbHljdGNXUldp?=
 =?utf-8?B?ZG9GcmRIQ0VCTS9SbFhRUCtsWmpERnhTUURJc1JTSnRxdWJYSzg0dVVXZnZQ?=
 =?utf-8?B?WENBemJDc3RnWGFmRGJsdlZvMkg4dGFyZjdqZVk3R01ybVhEczZPZVpqc2tE?=
 =?utf-8?B?UjVnK1FmeW9GU045UHdNdG9JdEF1QTV5Y3huMEhCeXZBc3ZZTmRBS0l4NTJU?=
 =?utf-8?B?djR4c0RtbHRTWEJqcmtieG5JL3NiTGZHUDBzTURsRm9Wb2xub1Y0bWgzV1lt?=
 =?utf-8?B?ajFXbU9jaW5qa29wY1RtYUplMVZ4eko4TlU3bEFhRWdtaVB0RUVvTklzMVFR?=
 =?utf-8?B?b1dsdGpFaTFabmZPcmI2bm1IRjZldHZ3aWxhbjBxd2ZSMUxBeTdpNG1YZHFt?=
 =?utf-8?B?bXRyODZQd2c4OUZJenNPWXo5Unlmd0lkZU5zbTM3UXc5SGtMV0I3S0cwYmFm?=
 =?utf-8?B?aFlSTkRhVzhUN3FrcjJIZUo4d3lQNlBSaTBNYWhLZEg0ZEp1S2VOQ1hWWkdn?=
 =?utf-8?B?bWtaL1Zaa00rYmFjUDNobzNjaVdSTnZlbHk0RE5aWlZsQkxORFhwTEtRM1Fo?=
 =?utf-8?B?M2ptUjF4aldJVzlYTGRrc0RVaGJzai9uLytsanFpZ2xzdUVOeUgzNWtTS1FZ?=
 =?utf-8?B?T2p4OUFYK3NQTlhiMytWQkZqZ1o1KytKVnBuYlZRQmRDVGgxM3daQ0dMYkZl?=
 =?utf-8?B?Mmsxay9hekdwRzlxWkdjTDZIYkVsSTgwc1MyZGVYdCtmc2gzOEhhU3V2cC9Q?=
 =?utf-8?B?RkVwVHI5MVgxOVVxdkRnNStjbmZNRlJlSStrMGZyak5HM2ttQVZaT0Q1TW15?=
 =?utf-8?B?VWhzb1p0dlA0eS80c2VHOUZSbnBVVHdXNk1VLzIxbGlZZ0Jnc25Da1NVZHVo?=
 =?utf-8?B?aGxpdkM0QTZwNUw4bU9Nb3RJSUNRN2xYQkZLUzJVdEg5ejBjWURzdEtBZ0tq?=
 =?utf-8?B?U0NuSEhnRGV5cEJsRWtJeFdGZm5SNEhlSVlpWkxOakxCcWNWS3RVeHBvRXRv?=
 =?utf-8?B?N0lLdWhRYy91S3hpR1dLc2FNdjNxUUd1RTFab1p5aGhkL3FQZGk0VGRzTTM4?=
 =?utf-8?B?U29ZK1VTZHBEWEFZU0d4eW9WcUFrZ3JHL1hLeS9hc1BrdkoweUhJY01YZE1F?=
 =?utf-8?B?eEhSUnJ5TnFWcVdrK0RnSitLUnY3US9zbFF6RUdacmVOaWR2ako4a09vRkVF?=
 =?utf-8?B?WWtVR0cyV1lmZDl5ek44Rmo1TXo2YXNXR0JOQkZEeXVnZGt0ejk0dUNNNW05?=
 =?utf-8?B?TWlDNXg1RFNiNXRWeXVTb1VVcXhnbjdMTGtJb1BHanJNYzR6a04yYklndDFG?=
 =?utf-8?B?LzhtSjk5dDg5WUVMSHNyUDBLSHp4Sjh6VlZTU1FOWHBTYWdqQTc5TUp6Mlpi?=
 =?utf-8?B?a3UwYzJUbE9xaWRRK3BMeGtHR1VDZWc4YXpTc1dMNmhxNEc4eXhPaEswcUtL?=
 =?utf-8?B?UExXMzcrRjBiR0ZhNmIydHI3cFh6N0w1QkpxSm1YUHo4VkJpTGYwUkxJTFhk?=
 =?utf-8?B?WDJzL2EyWDl2RVFVa3Z3NGRWeG9zUmpibHh4K3BkV1JhNnRZUnkwU0tiNlFn?=
 =?utf-8?B?SEtNR1dLRld0YzZ3ZDF5YStHcndtWm1FdDFNSmtuU0JKTEkxQllNdVdPL0JR?=
 =?utf-8?B?L2wrRm5YUElzOExsOGcwQ01TUFE1ZWJnVGdWU3U4THpMVGJZaXZGaldvU25i?=
 =?utf-8?Q?wHNOFQbLJS5ly?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-fbb9b.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: dc84b7d9-7f98-49d1-400c-08df4041c824
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5247.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 22:18:58.7032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB10053

A Realtek controller loses its firmware in S3, so btusb sets
reset_resume, is probed again on resume and downloads the firmware
from hci_power_on(). On an RTL8852CU (0bda:0852) this takes about two
seconds.

If the system goes to sleep again during that time, for example when
systemd's suspend-then-hibernate fails to hibernate and suspends again
right away, nothing waits for the download. hci_suspend_dev() returns
early because the device is not powered yet, and btusb_suspend() kills
the pending command:

  PM: suspend exit
  PM: suspend entry (deep)
  Bluetooth: hci0: RTL: download fw command failed (-2)

The controller keeps the partial download and a USB reset does not
clear it. After the next resume every command times out, and the device
is reset and probed in a loop until it is power cycled:

  Bluetooth: hci0: command 0xfc20 tx timeout
  Bluetooth: hci0: Resetting usb device.
  Bluetooth: hci1: command 0xfc61 tx timeout
  Bluetooth: hci1: RTL: Failed to generate devcoredump

Register a PM notifier per device and flush hdev->power_on before
suspend and hibernation, so that a setup in flight completes first.
The notifier runs before tasks are frozen. Without a pending setup the
flush returns at once.

Fixes: 04b8c8143d46 ("Bluetooth: btusb: fix Realtek suspend/resume")
Cc: stable@vger.kernel.org
Signed-off-by: Jens Willmer <info@jwillmer.de>
---

Notes:
    Tested on kernel 7.2.15 (Pop!_OS build) with the same change applied to
    btusb.c, RTL8852CU 0bda:0852, firmware rtl_bt/rtl8852cu_fw_v2.bin.
    Reproducer: two suspends back to back, each woken by the RTC, so the
    second one starts while the firmware is downloading:
    
      A=/sys/class/rtc/rtc0/wakealarm
      echo 0 > $A; echo +20 > $A; echo mem > /sys/power/state
      echo 0 > $A; echo +25 > $A; echo mem > /sys/power/state
    
    Without the patch the second suspend kills the download and the
    controller is stuck after the wake (logs as in the commit message).
    With the patch the second suspend waits 1.2 s:
    
      [11733.476390] Bluetooth: hci0: RTL: loading rtl_bt/rtl8852cu_fw_v2.bin
      [11734.070703] PM: suspend exit
      [11734.071285] PM: suspend entry (deep)
      [11735.275401] Bluetooth: hci0: RTL: fw version 0x040d7225
      [11735.482027] Freezing remaining freezable tasks
    
    Not tested: this exact patch on bluetooth-next at run time (only built,
    i386 defconfig with BT_HCIBTUSB=m, W=1, no warnings), hibernation
    entered during the download, and controllers other than the RTL8852CU.
    
    The same wait could live in hci_suspend_notifier() in hci_core.c and
    would then cover every transport. I kept it in btusb because that is
    what I could test. I am happy to move it if that is preferred.
    
    Tool use: the analysis of the logs, the patch and this text were
    written with the AI assistant Claude (Anthropic), working from my
    problem report and logs on my machine. I reviewed the change and ran
    the tests above on my hardware.

 drivers/bluetooth/btusb_main.c | 35 +++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb_main.c b/drivers/bluetooth/btusb_main.c
index 95398e2ca..c8af3669e 100644
--- a/drivers/bluetooth/btusb_main.c
+++ b/drivers/bluetooth/btusb_main.c
@@ -1090,6 +1090,8 @@ struct btusb_data {
 	int oob_wake_irq;   /* irq for out-of-band wake-on-bt */
 
 	struct dentry *force_poll_sync_dentry;
+
+	struct notifier_block pm_notifier;
 };
 
 static void btusb_reset(struct hci_dev *hdev)
@@ -4382,6 +4384,29 @@ static int btusb_send_vendor_frame_qcom(struct hci_dev *hdev, struct sk_buff *sk
  * ============================================================================
  */
 
+/* The vendor setup (firmware download) runs in hdev->power_on before the
+ * device is powered, so hci_suspend_dev() does not wait for it and
+ * btusb_suspend() kills its URBs. A Realtek controller interrupted in the
+ * download stays half-patched until it is power cycled. Let the setup finish
+ * before the system goes to sleep.
+ */
+static int btusb_pm_notifier(struct notifier_block *nb, unsigned long action,
+			     void *unused)
+{
+	struct btusb_data *data = container_of(nb, struct btusb_data,
+					       pm_notifier);
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+	case PM_RESTORE_PREPARE:
+		flush_work(&data->hdev->power_on);
+		break;
+	}
+
+	return NOTIFY_DONE;
+}
+
 static int btusb_probe(struct usb_interface *intf,
 		       const struct usb_device_id *id)
 {
@@ -4816,10 +4841,17 @@ static int btusb_probe(struct usb_interface *intf,
 	if (data->proto == BTUSB_PROTO_LEGACY)
 		data->poll_sync = enable_poll_sync;
 
-	err = hci_register_dev(hdev);
+	data->pm_notifier.notifier_call = btusb_pm_notifier;
+	err = register_pm_notifier(&data->pm_notifier);
 	if (err < 0)
 		goto err_release_siblings;
 
+	err = hci_register_dev(hdev);
+	if (err < 0) {
+		unregister_pm_notifier(&data->pm_notifier);
+		goto err_release_siblings;
+	}
+
 	usb_set_intfdata(intf, data);
 
 	data->force_poll_sync_dentry =
@@ -4880,6 +4912,7 @@ static void btusb_disconnect(struct usb_interface *intf)
 	if (data->disconnect)
 		data->disconnect(hdev);
 
+	unregister_pm_notifier(&data->pm_notifier);
 	hci_unregister_dev(hdev);
 
 	if (data->oob_wake_irq) {
-- 
2.43.0

