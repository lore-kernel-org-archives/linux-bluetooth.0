Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011028.outbound.protection.outlook.com [52.103.68.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993F4315761
	for <linux-bluetooth@vger.kernel.org>; Mon, 17 Nov 2025 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362813; cv=fail; b=BhACqgGQNm8KTCWTvMk8S9EHGpeKsDAnHVZIgKVz5PhwdVJ19RBsbypO3eP2nrzWbMV8u1ghUAKDgG+PNBER0ataO6JAQlAOd6cKzKeGuSa8I9uP7pn/oBOCgMyG7GsymvrCmSIqwadWMa4G4uGpuQkmFlCHao8rIZzOGCzUTnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362813; c=relaxed/simple;
	bh=UuCgZiIZW+/Zv5ZsmdsNHAkFBNMljg/5HML1OA0QFXU=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=hMGX4cGNOsS47cAHUujDiTRhYdyRr4roiTq0XVGblLVjDKsy14KoCrDPVazhXuQlMDhwfcz+rN4cdtPmOe8sHel34wnrsyxvUCc7AdUT8nC96+9x8iLqceIIICa1su/AicE6v0E8+3BkBXvCjf6Av3repv5JpfEJsGdJlf2D37Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=kn09RTZV; arc=fail smtp.client-ip=52.103.68.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="kn09RTZV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cuoqMm/NV/BfVwfCqacKqdXV2si0rXRLfCwSXrMvxkc0HbxcIRT+ORIwWH5gEZuEnZWwNxEYNTCicv2Op7u7OSpem46bkHrms0CEJ5AxCEFh6E71PHAzys7y9qBQu2OYfH56N4y0MPEyMFwN9dfD0odywqS8GApWkWbpkbuEI6QvlZPb3lcnhSg7kx3R/yJqUaHRXsMRb05pfR0EsOcD1U2Cfba527wKhdSH/4I70E2fBmbRrcFhuUHan7OrUN0CfG7qx1dyokzbByRL1m9v5l2pGpDp7CxNs8zAUzxX5IXZ+vP91WksqeUXGBwhubZl7uK6vHN6K8ILec12rtLgYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wVkVKpfu8+Sw23xnlVLhgOzCq2Hrv3XYTiP/QF3kpgY=;
 b=nrf2xedybRizXNqcb50XrJDXdPSyCL+HK/kfsCgUleHreBfrA+wzUm/xnJWOvXPM6KSumkcTmbD4OeyvoDAPIShTprlPpQS/6fyN1rt3cfXsDHx3XWnybrZRttvNVh+O4c58k9P22JhXtW65Nlm1psgIsbFtHXEFbIQrCwxo+ahX6JdxEyZcljgX9vK9+41zMpPeXjk9V5F/r/o7cZ2T/ZB3zE+HN2wtLCPBznTldGDIY0bXxu8Hz/Xmdx1o7Z3bu5UQ3DsINgSsJo92saADXv4GHHKQMpWE2ic36Wb9fIAqIBfp7xVba450dyQi6PWQzUpWqNp7DVibcJOxq755Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wVkVKpfu8+Sw23xnlVLhgOzCq2Hrv3XYTiP/QF3kpgY=;
 b=kn09RTZVCNZjjJjn5aD/7LgXPhwXCkXM3DBmlcZgabTjYbkGGsZkbYw3AUCriNcoN0K/t+Go5N+IJO7f4KiVe69U6bjbi2s2Uk+rHbtrIWYJ94geapiUnxlMsr5DPjVasXIHxnXKdGcmvqlBNmFz0cD+mhNcSdAOqv+AirTfVMSLLAI9aoSI0QoHcMejFhuLM0WARrIy+jsqCquTtwna5wDfrIKTRxqbdsmy6lmQQnIROai9li1Tj3vdc9zNLq6m9p2QWbCmP1YqxmP7FAcq6Lo3xu6I6Jo6D7glBpq9RtmOKW3kXDpIOlnM+EwD7ojEONCL1/vRy7PICiqiJn4xEQ==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by PNZPR01MB4446.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:1d::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:00:06 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::418:72df:21ec:64ff]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::418:72df:21ec:64ff%6]) with mapi id 15.20.9320.021; Mon, 17 Nov 2025
 07:00:06 +0000
Message-ID:
 <MAUPR01MB115469354A4850FA87E8CD663B8C9A@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
Date: Mon, 17 Nov 2025 12:29:46 +0530
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
From: Aditya Garg <gargaditya08@live.com>
Subject: [BUG] Bluetooth doesn't pair to devices properly on MacBook Pro
 16inch 2019
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4P287CA0126.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:2b2::9) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID:
 <8601a2a8-9152-4a94-95ab-6d9888a6cce4@live.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|PNZPR01MB4446:EE_
X-MS-Office365-Filtering-Correlation-Id: eb3e2bc6-20d9-4cf6-5be2-08de25a6eec7
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5072599009|461199028|41001999006|6090799003|8060799015|19110799012|8022599003|23021999003|12121999013|15080799012|440099028|3412199025|10035399007|12091999003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekNIU3JVVjdaNjZBcytCaFcwNU9jTHZBNnRkdmQyL0FPU3Zja1NETm9MMi9i?=
 =?utf-8?B?ZU9mME1QTmVubitEV1VQZ1BUWG1LR0xLaW5ISUVrZ1puZnV4NHpMT0RnVno4?=
 =?utf-8?B?T1hVVGZldjNhc3JScExxMmhuU0t5MmVsMTYvbkh5NXBWSHB1N3RxQkZHMzk2?=
 =?utf-8?B?RW94R1VFdUdhT0FhL0xBVGt6emMxbkJrc0lEN25Ndk5mYXI2eTFXSDRzanFv?=
 =?utf-8?B?SlBKOE1WTy9OVmNkcS9MRHNJWDJ5d2s5akNhbi8wZ1htb25oWURkcXBmeEN6?=
 =?utf-8?B?NzFCdmlXS0syZklOVlM4dVZCRndIRTkzYzRtY0s1QWVGQzE1NGY2KzF4MTVM?=
 =?utf-8?B?S0lHa043ZDhxMHFYcHVra3Y1MVhwY1BCZEg5V1FkMWJ6aVVxWVRrdDBQTE8y?=
 =?utf-8?B?R3REQlNxTHRnUUx4cmxDRnhEQ2JBR0dPbEc2MEVSSnZIbGZHbEUveU92cXVO?=
 =?utf-8?B?aGpYcGI4TW9jTWwzdHVzSVJLQlBkckh3Y1dPOXIvb1BoOER2RE9MRnQwQnlt?=
 =?utf-8?B?bmhlbW0vSVIwaExPSHZKSkRtU2h6NVJ2U1hiRko2cDVCZ1pZazlqeXlwU1NF?=
 =?utf-8?B?T0lOa2pEQktnZFRtR2RjbXZCTG1id1A2NjhVaG9KV3BWRWJPcWd3VFp6dDlu?=
 =?utf-8?B?ZVEwVWxZTCsrTUpqWGRVWVBwaXNtYnh5OW1wc0ZYYnRuRm95ZXZqS3RsYkVV?=
 =?utf-8?B?cm9ndFp2ZkYyQWRiL0J5UmRPOEk4U0NNelJOR2lhYlJLSkp1Qmh6dnB0UkMr?=
 =?utf-8?B?L3hFQWN2WFVJSWExblgweHJBMk9YT1RySTBxajM4NmFqVktJL2ZIbVJsMnNO?=
 =?utf-8?B?QngwN0NwdEwxK0QvTFZJWlpxZGttQ1AwVGoxMGNrZWtOWUVuRTVhSm1rSVBq?=
 =?utf-8?B?bUVGb3dEcFY0a3NJeUJ0eEtPSnluZW1XdGthRGJHOEUrUkxFWUdFWUVaWStw?=
 =?utf-8?B?ZmlucERhNFA4d2MyRjNldmZOdldUQ2ZNOFAwVDdTVk8xRmIrZ01EdE9SamFB?=
 =?utf-8?B?K2RtZDJ1UHdoNzVRRHQxcklLdkU1anQ1ZUNrVWNFVnpiN2trcmp3RWFvY3Ew?=
 =?utf-8?B?bC82ZXUxZG0zU2JvNW55RVZzVGNyWks2WVdLUFVYbGRFV3dUQmhHN0c3ZS9J?=
 =?utf-8?B?NHFhVUVjcDhwbEUwMms2blIxZFREWWh2NHdZbnhEZlJQSzAwemQyekNkVXU4?=
 =?utf-8?B?cUZwblNibWx0VVpzV3Uyczd4SmZiZndyTFZ5UlBaUU5GQzRRNjY4Y1RWNERQ?=
 =?utf-8?B?ZzgwOUZHOGtOZXJ5dDRGVk40Qlg0dklZcE1vcWE4ZmdKcWl0ZWM1b0VyUGRr?=
 =?utf-8?B?ZnlRT0oyemw1UFMvZDFOZVlYVU9oSVM0N3RtNUxQemQ5SjFFNlJ3c0VzeklD?=
 =?utf-8?B?Mk9oU09kOC9EN3JYUXdwekRPbWJRcFg5dHZJdk8rd2ZmMWxZU0RuZHVRayto?=
 =?utf-8?B?UG4yMUsxd3lmUjV5TnlJOStwWlF0S2ZLbzZlL2ZWaGRydW5VRjU5eEgyVlE5?=
 =?utf-8?B?d1M3ZGtjUCt1QzJrTGdwR290RFN5bEpXUzYyeWNzQTg4UlJyc05ZWjhia09E?=
 =?utf-8?B?MGdXL3NvYVlhK1VIa1E1TXc2Y29tMVBuL0MwUTBFVGxBWjlCVktaUE5nSW4x?=
 =?utf-8?B?UXlVbitiWitMV05OYjJlQXJrdG9UbHE0bHoyT0F6eFhjUXJ1YnlTL3JCNERz?=
 =?utf-8?B?cU5paFZmU2JqQ2dNQ2ZpbTlqWnJSTlI4TG5SM0xZL2VHb0xWbDRCYTMwR3d0?=
 =?utf-8?Q?1YIHIRlE5Lyt/IvHdE=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WW9uSnRVRGVTcjBkclZaT2IwckJZMnpPTVZ0aXlTdG9ZRGJtdG5DNGhJUG1i?=
 =?utf-8?B?NHQ2MXhUZlJ2Nmp6YVRBNlpFK2dZYkE1ZFJKOTJsaUZRcG5jWUJFeWVsZGtW?=
 =?utf-8?B?RDRhUnRlNDdYSytzUG52dy9EeE1mR3dOMTk0R0RqZXpUWW8vbUVPL0VGazQr?=
 =?utf-8?B?NTQ3Yi9tUmxHeHdLYlZyMldiQTcrMVRiU3V4aXVXTkNFcGU4VXlYN0FiN3Nl?=
 =?utf-8?B?ZWxzQS90N2dBYUYzZ24vZGR6MURQdDllSHdLeEhML0psWnlVL3BVOFFKYUor?=
 =?utf-8?B?dzZxL0xSVUdNbEgyWWt1OVZDbGJlSVpjTytkZ1pyWkhuNUd2NGYzaFdKQVVk?=
 =?utf-8?B?VGI2VThyRy83eWFEQlBSV09OWGpxeUMzZlJ3T3BoTS8vU09LT2owL1BjUElS?=
 =?utf-8?B?VEpOdXBUY0wzT2EvVkk1cUtqMWk1c2RDNndZVk9RY0pIWmtYdm9tOVdMOW5L?=
 =?utf-8?B?REdDWDVMV2xCRkZjNXY3Nzd4RnFiWjlUUGx2TE5yTGt6ektxNU9pbG5xakFC?=
 =?utf-8?B?MUFkWTBPZnRUZ2dTcnk4bVZCdDlzclBGaWxOWUt5SlJwZTFRVUZhOHdQWGhw?=
 =?utf-8?B?UHptUUUzL3FMenkwN1Z1aTJUWUh4ZFVERlJlRy9oNXBEOGc2aklGYWg1VG9Q?=
 =?utf-8?B?c3lvNjdJOGovaUhRZXdBLytRNlNXc1dXa1hPemorVERNY0JuU2RFNkxWa3Qr?=
 =?utf-8?B?TXZROSt5WngzVmZRQkZBS1BSN0tsQWdwa2tXU3djVWRicFB0RFFMZjhHWWp2?=
 =?utf-8?B?NXNnVlZpY2xLNFdNUjVRQnpuQ01ybHA3ZlBCSmZReVlKOFBjRisrQ3g1L0Va?=
 =?utf-8?B?MzZTMURqUGRFeno0RlErd25rNkE4bm9mQlJxMnNHUUh3eGVRbFA3S1Rqa0xk?=
 =?utf-8?B?bjdrelUvTzNBMkdmQWFINHk2b1JMMkMrSm5IRXBKTEZNVlBOdTN5NDBZclRw?=
 =?utf-8?B?NjJITWovWnEwL3Rtc2xoYTA2Zld3Umd6WVZSZWRNanVrODdwVW41bnlxaVFS?=
 =?utf-8?B?SzFTakREZUc0djlURVY2VWdqQUFrV2xLdTZSd1U4eDdYbnFoc2RBZERSYUZ1?=
 =?utf-8?B?emw4QnpGakwvcUFPUzk0cHh0clNDZ3ZnSHUzS3pjbWEyYWp5UzQvVHNwaSty?=
 =?utf-8?B?N29BY0kwVHhyUEk3Z2xoV1NyajIzcmZJVU1UcFBMVkdnazhlYjlybndkQlFH?=
 =?utf-8?B?b3NoUC9LZ29nQm5sWDBDTjBzWlhlNSs2S01NM2ZoNkhNYlZYbURlbVp6Wkxm?=
 =?utf-8?B?Q1AyNHp2OXVycGw3VnB5WjZxUnNobUgxSHpEZGIrS3V3eGh4UEl1dU84eWQr?=
 =?utf-8?B?ekNKNUJDeE5XaDl5b1JweFlzSnpGTnFqUzE5cWhENmJCSFpTNngybEw0T2NE?=
 =?utf-8?B?d1VlZXlmZXA2UHNFVmUySGhQU0VqV0FPY21CMm9tV3RUTEFuVFVUQjFVY284?=
 =?utf-8?B?alJaOUhkM2hwb1RQcVVhMUs2UW9ZTStJcm5HMjUwMGJOcTdkRElEYU1LYWRF?=
 =?utf-8?B?WWt5QnF1eVEyYVRqVjFEZWh6T005bUJ2T04ya0xCdkxiSHZMM01XY0Vxd0FB?=
 =?utf-8?B?UXMydFBoQnpFbjVjc1FobUUzWEJ0TnVTcFJrTExBV0pSdjdUQSs1cXUxRTRo?=
 =?utf-8?B?WGVpU3kyWmdsWjN3aVZzTGpmTTNzM2N5NmpxTVNTeDYvell0TUp3ZXNJNWYw?=
 =?utf-8?Q?T2+VqWqvG+Txrq4P+iO0?=
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-6aa33.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: eb3e2bc6-20d9-4cf6-5be2-08de25a6eec7
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:00:06.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4446

Hi

I am currently using a MacBook Pro 16inch 2019 and the Bluetooth there is quite flaky.

It discovers the devices well, but doesn't connect to them seamlessly.

I managed to dig it up a bit, and found these logs in journalctl:

Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART driver ver 2.3
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol H4 registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol BCSP registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol LL registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol ATH3K registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol Three-wire (H5) registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol Intel registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol Broadcom registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol QCA registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol AG6XX registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol Marvell registered
Nov 17 11:53:57 MacBook kernel: Bluetooth: HCI UART protocol AML registered
Nov 17 11:53:57 MacBook kernel: hci_uart_bcm serial0-0: Unexpected ACPI gpio_int_idx: -1
Nov 17 11:53:57 MacBook kernel: hci_uart_bcm serial0-0: Unexpected number of ACPI GPIOs: 0
Nov 17 11:53:57 MacBook kernel: hci_uart_bcm serial0-0: No reset resource, using default baud rate
Nov 17 11:53:57 MacBook kernel: Bluetooth: hci0: BCM: failed to write update baudrate (-16)
Nov 17 11:53:57 MacBook kernel: Bluetooth: hci0: Failed to set baudrate
Nov 17 11:53:57 MacBook kernel: Bluetooth: hci0: BCM: chip id 150
Nov 17 11:53:57 MacBook kernel: Bluetooth: hci0: BCM: features 0x07
Nov 17 11:53:57 MacBook kernel: Bluetooth: hci0: BCM4364B3 Trinidad Olympic GEN (MFG)
Nov 17 11:53:57 MacBook kernel: Bluetooth: hci0: BCM (001.016.091) build 0115

I also was able to find some useful stuff from dsdt acpi tables:

            Scope (URT0)
            {
                Device (BLTH)
                {
                    Name (_HID, EisaId ("BCM2E7C"))  // _HID: Hardware ID
                    Name (_CID, "apple-uart-blth")  // _CID: Compatible ID
                    Name (_UID, One)  // _UID: Unique ID
                    Name (_ADR, Zero)  // _ADR: Address
                    Method (_STA, 0, NotSerialized)  // _STA: Status
                    {
                        Return (0x0F)
                    }

                    Method (_PRW, 0, NotSerialized)  // _PRW: Power Resources for Wake
                    {
                        If (OSDW ())
                        {
                            Return (Package (0x02)
                            {
                                0x6F, 
                                0x04
                            })
                        }
                        Else
                        {
                            Return (Package (0x02)
                            {
                                0x6F, 
                                0x03
                            })
                        }
                    }

                    Method (_CRS, 0, Serialized)  // _CRS: Current Resource Settings
                    {
                        Name (UBUF, ResourceTemplate ()
                        {
                            UartSerialBusV2 (0x0001C200, DataBitsEight, StopBitsOne,
                                0xC0, LittleEndian, ParityTypeNone, FlowControlHardware,
                                0x0020, 0x0020, "\\_SB.PCI0.URT0",
                                0x00, ResourceProducer, , Exclusive,
                                )
                        })
                        Name (ABUF, Buffer (0x02)
                        {
                             0x79, 0x00                                       // y.
                        })
                        If (!OSDW ())
                        {
                            Return (UBUF) /* \_SB_.PCI0.URT0.BLTH._CRS.UBUF */
                        }

                        Return (ABUF) /* \_SB_.PCI0.URT0.BLTH._CRS.ABUF */
                    }

                    Method (_DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
                    {
                        If ((Arg0 == ToUUID ("a0b5b7c6-1318-441c-b0c9-fe695eaf949b") /* Unknown UUID */))
                        {
                            Local0 = Package (0x08)
                                {
                                    "baud", 
                                    Buffer (0x08)
                                    {
                                         0xC0, 0xC6, 0x2D, 0x00, 0x00, 0x00, 0x00, 0x00   // ..-.....
                                    }, 

                                    "parity", 
                                    Buffer (0x08)
                                    {
                                         0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                                    }, 

                                    "dataBits", 
                                    Buffer (0x08)
                                    {
                                         0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                                    }, 

                                    "stopBits", 
                                    Buffer (0x08)
                                    {
                                         0x01, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00   // ........
                                    }
                                }
                            DTGP (Arg0, Arg1, Arg2, Arg3, RefOf (Local0))
                            Return (Local0)
                        }

                        Return (Zero)
                    }

                    Method (BTPU, 0, Serialized)
                    {
                        ^^^LPCB.EC.BTPC = One
                        Sleep (0x0A)
                    }

                    Method (BTPD, 0, Serialized)
                    {
                        ^^^LPCB.EC.BTPC = Zero
                        Sleep (0x0A)
                    }

                    Method (BTRS, 0, Serialized)
                    {
                        BTPD ()
                        BTPU ()
                    }

                    Method (BTLP, 1, Serialized)
                    {
                        If ((Arg0 == Zero))
                        {
                            ^^^LPCB.EC.BTDW = One
                        }

                        If ((Arg0 == One))
                        {
                            ^^^LPCB.EC.BTDW = Zero
                        }
                    }

                    Method (BTRB, 1, Serialized)
                    {
                        If ((Arg0 == Zero))
                        {
                            SGOV (0x0309000A, One)
                            SGDO (0x0309000A)
                        }

                        If ((Arg0 == One))
                        {
                            SGOV (0x0309000A, Zero)
                            SGDO (0x0309000A)
                        }
                    }

                    Method (_PSW, 1, NotSerialized)  // _PSW: Power State Wake
                    {
                        If ((^^^LPCB.EC.SWBT == One))
                        {
                            If (^^^LPCB.EC.ECOK)
                            {
                                If (OSDW ())
                                {
                                    If (Arg0)
                                    {
                                        ^^^LPCB.EC.EWBT = One
                                    }
                                    Else
                                    {
                                        ^^^LPCB.EC.EWBT = Zero
                                        ^^^LPCB.EC.LWBT = Zero
                                    }
                                }
                            }
                        }
                        Else
                        {
                        }
                    }
                }

You can find the complete logs here:

1. journalctl: https://pastebin.com/y0hzUUhj

2. dsdt acpi table: https://pastebin.com/FuByaMm8

Any help in fixing this bug will be highly appreciated!

Thanks
Aditya
