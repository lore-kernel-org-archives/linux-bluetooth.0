Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020142.outbound.protection.outlook.com [52.101.193.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41912F9D98
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 20:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766003864; cv=fail; b=cL29XJsQEDYnfgfMInb4q5lNY5OJmJjUQfxbu7vsGRcxKEdRw9TxVTMkEKdwhNn010KcWxDnT9EflsJju4NELZ8gQBmP3rffELnT12IoIEc7MAu+G46KaVXAtUL6Vt0KM4C+n30KhIZh8lHPHxt7csyUJYsM0GZzx8p59zp39lo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766003864; c=relaxed/simple;
	bh=hjh5HfLe9FLG7SJ2eImLYuocHt3jMl9izxcYbHcaauo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XBybqDC6kjHs2uBO0xUJ9s1iHaWrVYTcVzzl+bovvGoIQeApMvBodyjJ/pS8XWturq+y/oEl9Ab7rvsy+fb148uHSoip9q70Gp0w9Ucu0N7onAQ5wRmLEyka0v/Bi4AfgiGP/zwkpy74fsSSr8/6EbmA7MCYf8pohYN4whqKbQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=P5BSF7yK; arc=fail smtp.client-ip=52.101.193.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="P5BSF7yK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vb4O6KOdzTVsV/idzJf1RFopW4UfMvJ8QiX9TBWjw74RnYMH3TTRGAkqMzfcyjDdzYzrnh8uoeRoAd+p3iXDXVZZ97xTZHXW9XLoeVXjkl4A4wTfh7u7i2SPbhTzfoAIQmlaIONPAGeqaVZSee2VD7YzkFk4HGOX4p+ra/ZWrBlGwv/D94AcSSsB6GRRH3H7jzBYi325XRCmX4Mllq7PIP2wbmpZn47OtmwePiIkCX2CKNEkiuYZtaORRzuI3w/5q4HJzYCCAA5JYx2HTTueh9XmftAlQdRIJIQLdYUTOX4BPKg5ElROplujz6tiGek7awBT9+33/FT6ZM0cVW3tNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TH7s7HPp+CrHFJR9MoFLtdUKrRL66ODt57gXdEGdDY=;
 b=df4OM+O6xbvPrsqUPbk9l8csTOjK2tgkD2VrNYHRUejswsTAkRf04aS/qsUsWWfNmoatu/ydtujGBPDtSik35N9umAkdBaM7ctrBLu8W6XmtxaTUU/ISMszkrmRf3J9Kdx08wkoGwl+e2k4peh0Yezb3AqKxtnH8Ag7KzLtByOAfTw6lgyk/lQmtBH1X/W1ArMZPuGEY88+JE02Ud/vJH2Dj8cdoEyQHSgN8RZGF1ymJx+lYqvM6r1gyOFEOdH2gt0Ynjs2a2qe6qdcE7G9GohMMRruMlZhHMOwQrc6dSK2ejJIMTbKwhVt/Xti3QPlBP0nsx7VmGDY0lnLk+3bE3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TH7s7HPp+CrHFJR9MoFLtdUKrRL66ODt57gXdEGdDY=;
 b=P5BSF7yKIHbVU4clAHDTH5G8h1X1RW9FVleuD6RMME8eAVKtsDwpG18b5yseClZo7zPEzuACcbyfvemP9MG8aQGuk+GcwZE3jMaHkiDew1JVfBQZxBfLZYd4G1xX0Pf1iVXQSBY/6P70iwWn11leVcA0cwirPaNmVBalak2y78gX/nbb0eHQPCo3riKkBn2mxeHoRdPf6QrplU2DsmNkc/g0Hn4KPR7tUsoPZvAw4iQLE/TwZU92/CvE1wMr/0coGAwqdSGCmoTEI8q/PZIpdXW+JGhoC6BelZvUyziOwfJPx3T9yzpPkyE0hFeabLpOGi6GXHfWOkl3vHIXg0g2+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 PH7PR01MB8665.prod.exchangelabs.com (2603:10b6:510:30d::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:03:25 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:03:25 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH BlueZ 0/4] Decode system parameters and add BR/EDR idle timeout
Date: Wed, 17 Dec 2025 17:02:52 +0100
Message-ID: <20251217160256.441737-1-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR04CA0181.namprd04.prod.outlook.com
 (2603:10b6:408:e9::6) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8282:EE_|PH7PR01MB8665:EE_
X-MS-Office365-Filtering-Correlation-Id: 88ef84d9-d753-4d41-7c5f-08de3d85cf0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U1ZJY1F3dzNiK082ZUIwUDVpQ2Nqa2ZvMWt2TTdEVEl5Y2JDcm85UVlyeVky?=
 =?utf-8?B?cmd5RnJEV1NjRXBzQW1xcHUxdUxHbGhPdnV4dzZJaTJmT09jMUUvM25ub013?=
 =?utf-8?B?U2lneEYxVGZoS1BvV3FlakhvNjN1OEhUZnAxeUlENWd5Ri9Nd21KOWcrbDBh?=
 =?utf-8?B?WVg2OTB5dnFOSzZXelNZU0F5S1FSMkJDT3NsRkRxU3pvYTZZQnVQUExRVnVJ?=
 =?utf-8?B?ZGZ0VjRTMEV1UmpKVFVDMS9JeEp4RFB0emVjN01ZcDVTZk1FVVp1K2hKU0da?=
 =?utf-8?B?KzA2ZFpwYmJ6dlpGOFlGSTNjam9aNElHdGlZUmFveDA1cXhvSGdZcExTa210?=
 =?utf-8?B?YzlZbW9yL3E2ajRmMkFCSFp5SXRQaEFtejVNdDVMODI0OW42bDJhZWNLZmgx?=
 =?utf-8?B?UUM1cnFHaDNmTXh2TzBybnhHejdmWTNIWmZnRjhubC9Bczlia1Ura1hKbXpN?=
 =?utf-8?B?UkFacFV4UkljNjFTZnp3TmRXaXpOaCszTHlsMWNhcjdQeE4wWUE1RlRLbVZm?=
 =?utf-8?B?dVNRcVlWMVIrczNQNHltMGtFWWhGaGtqREh6aDgwcWRxR2xISDlQTXljUmxL?=
 =?utf-8?B?ZUM0RCtzaEVQSG40ZFhQRG5lWi95Q21VRFlIY2hFY0JkRGE3NkhBNkdmVlV4?=
 =?utf-8?B?a3BVbFhPZXJ6RGZKdEwzTEplcG51VDBBZzZjSkRDeTVkWGF2TVpJNVFFWFN3?=
 =?utf-8?B?OE1nTDB6SjJUY0tTZlliV0puUTR0elI1eUhZa2RhWndCdFNDc0FCZ25sSXB3?=
 =?utf-8?B?UGNIdnNrVC9kWmlWbWpEL25wSVIwK3o3N0I2b3RteEhaNDBsb0JqYWJiWkNu?=
 =?utf-8?B?Nm45YzV4VTBjd2diQkpsVlhVTGs2UkNHTDZUZFZjRmpDcXZUSmNVSnk5eVY5?=
 =?utf-8?B?WW1IME40aE43MHZHTjBTWUh3Tk9kS3pUcTgwNTZzYy9zem5pMHUwY3YzeEIx?=
 =?utf-8?B?aEpmVlRNY2I1SlFmVHRDR0xHTHBGd24xWktJTFQvTlhndHE5eGFXdHY2UVZm?=
 =?utf-8?B?cldsUHMwalp3R2dWYWtLa0Rjc1ZNaHlzYXhVQ1hLYXNWM2xWOTlJalQ4MVlj?=
 =?utf-8?B?YW9CWENaa25IUjAvbm1BSHh0Vk9CWXZ4VHdHOVh3VFVUSWQzMTNuTDNwdnI2?=
 =?utf-8?B?R2FFdEFQbjhtSGhzWDVaVUM1ckZkY3ArY0Ivbk80UzVVNGJqVktqVmdVUTR4?=
 =?utf-8?B?bGkwUmtQYUFXbmQvRjQzcXcwMUNiYkRnMkFHa1VOY3FDYmRCdldhcXppSWNj?=
 =?utf-8?B?VzI4U1Z0SVBFR1N0VFBFbmxXREFSQnY3NGpvU01heG03blJ3UFJZRVhSRXhk?=
 =?utf-8?B?NFZCdm5YZDVYMW9OMmdvcDJqWDZaV0U5cVF4S3JlN3RuSVR0NkxMckdTZkgw?=
 =?utf-8?B?S1FmM0gzTGNsMUhqT3ZHUTBNMWhnbnNBM24vczV2dnlFcUFCVWViYTdwWWQ3?=
 =?utf-8?B?b1UzOXVNV1hPc0dZcnJBRlNjemFaYUNDa0h6MXRTTmRKOGxFT1FUQ3J2ZGQ3?=
 =?utf-8?B?dUFLTnpmN2dmYnVHclU2ZFBsdG5RcEswRGZvN2dvVUJLU1FLeTI1dDRPRDla?=
 =?utf-8?B?Zzl6S3gyVXFVeitKU3ljUjNNY0R0YllFUHhTL0tINlUydDYvMFh6RjZOVVF3?=
 =?utf-8?B?MlByV1k2Z29EREtaUkVsWjA2a0QyZldMVVcyeGU2WmxhTVFIK1RZSzdjMW4x?=
 =?utf-8?B?WjBjeUwrTEFhUVNnMXVRclZBQTBEdTJRaWZENHp2UlAvYXNNR3gwMEVGdDJs?=
 =?utf-8?B?ajhVRklZRGptUVVmazZkMmZYUUVpVlovcTZSZEorZGRqbUtzZlRxTDJuODVw?=
 =?utf-8?B?alY4M3U5QUNtcDZjdkltYy80TDJHYWFZTnZtZG1XY1hsaVdWc213VGlic294?=
 =?utf-8?B?NzF3MUJZdU42T0lZS3RDaEczb1ZkUkExbmFxUmVUd0RYaGdwSGZtSjVuVlZT?=
 =?utf-8?Q?SVtT5r89WsC3rRXpg1haBvxyHyNJIVnS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cy85RWtRSGpvWDBNUTZhUHNKNkdJSmFIUm1WdktIVmdmd003czBDV1JQYnVE?=
 =?utf-8?B?YlRnQ3V6Yk9yS1BEd3YwcE44dkNUNUQ1bUI3aHhDMlAybm1wNUVzSm1HemRr?=
 =?utf-8?B?SFNVVTk2VWtwN1d1dE1ZbHFQZTlwTDZvQ05kL05naW1OTW12dFRlaFdNYlZR?=
 =?utf-8?B?RmlUSUxnQmYxQzgvSlhBaVNVRnp5a3p5dXdLWnZxb3F1TUo3dVAwZk1iVWZn?=
 =?utf-8?B?NG51RXNlSVA2bjhaRkpFVkxIMTRMNjMzeThMN090WEpLM1ZIbmpLb1ZVREx1?=
 =?utf-8?B?UkFpV0cxc2l3QjNmdGVVQUFHclpUdUN0TlowWDlxSVVKOW9qMExxUUFIRmF6?=
 =?utf-8?B?cHArOEhnTVZtQVh1T0srVHZjNWNCZXR6R01BOGU4YThhTUN3UGpWeHFXWEw4?=
 =?utf-8?B?cWQwQUJxUjN2enBZdjl0aXYzYkg1NG8rQzJzcElNU01NQnViMWpBRzlTeERB?=
 =?utf-8?B?cERKcW1zWk81bk8wWGlvdFR5K0FSc1N1blk1cnZKTHo3a0NpTlFuc0NpWVJM?=
 =?utf-8?B?OWdid0xoTmRkMTdvVzdrNFhhNTR1WFVQTFFNWFIrSWpkSC9zRFdWMGo2TFhk?=
 =?utf-8?B?dVViYkVLZVNQM3FIQnl3RXlTbW1Tc1FWbHZCTjFRYXZCNjhnSW9tam9YaWhr?=
 =?utf-8?B?VjBaNGQrZHh0MFJVSStoMmM1cExiL3BLMjA0VytkK1ladHl2MjdlTTE3L0dC?=
 =?utf-8?B?eXN4VGZDd1ZRUHhEb2MwY3diTWl1WkFCVWpEbXE5c0VGTUdTbWJ6UEI3aGpP?=
 =?utf-8?B?c2Z3YXpDRndHNkNNMndMOFhycUNCbTFkRGRvbGcxcXhIZ1VtWDVtWlhSa3Rr?=
 =?utf-8?B?OE9HYjBZNXFJUFpvc0pLWmFKR3NVdU9Oc3JORTVPczVaVlYvTi9ZQUxsWjBu?=
 =?utf-8?B?ZDBtcjVlMGpvdGdQTmk4Zlo0NFUvY3hYeTI2NFNXMDFPWlRKK3FsUVI2MG8v?=
 =?utf-8?B?Q3FRTVBkdm50WWRlekozaWJ0ajBhN1VXOEtsZHF6UlNKb1ZmRVdPSXpxeFkr?=
 =?utf-8?B?dStoRzh2cVAzdThkSkVYR2t2M2VhVU9DYnBVSTFzNndTenl2a0MxRld1QnY0?=
 =?utf-8?B?dUdscVd2QWtrVExjMldQUWdpQndoMGI0eWMvWmhJUTBRQTJ1V1RpdnpUaDVP?=
 =?utf-8?B?Ynh6V203R2VRK0Y3a1RDbnhWRzl3TVNpSHNSdVRmNlp0T3NtYzYzOXh0MlQy?=
 =?utf-8?B?Y3hQK0hpaUl2dWRuQ2t6RnM0RE9DUFJjeWNMeXhWczdDQkVtOGlEb1RnRGl2?=
 =?utf-8?B?cWlYdlZiSmVXc2c2Y1dOakl3K0NGTFkvSG8vcTRIZTlVd00xeVJIaTVSajJq?=
 =?utf-8?B?T2JXZDA4eFR4NUl1L3AycW1PaktrZVNUajJtV0pvUUlzSklWTWlhdVd6NEN4?=
 =?utf-8?B?R2E3NDI3ODFNem9LcGxNTlg3aDNjMWFVVndxaXZCWm9CWFBLZTNwaDZ3bEd2?=
 =?utf-8?B?WWF5YjJuVndYenlIUk85VUtIWVZic2oxMjh3SDZsQWUxRnBEQ1hQallPZ1Q2?=
 =?utf-8?B?U0FLRFhScWhXVmRTQkE5ZHNGeVRUcXJVa1M0ekNzcXh3bEZuNjRBWTZWMkNG?=
 =?utf-8?B?REIwWUFsYWVqTHB0VzBvNFZYeDZOby9EWC9jZHRWNlViTkFuejhEL2ZXblZx?=
 =?utf-8?B?YzgrbS9SN2FhMmhseS9velVYYUpOSEh0UFMrUVlzcG1aMWR1M0ltd2JPTFBr?=
 =?utf-8?B?L2ZOWStZZ2gxQVdSVXQ2OWpldUNBZENWeXR6RWhJRWNScXo0Y1hXdTZ0MXJ0?=
 =?utf-8?B?QUMwdkpWNFJERSsyVk5EZW1WQTIxU29YU0pXREMzb25LeGVOMFl5VmFMTmdU?=
 =?utf-8?B?Y3U3QkZub0N1VlU0dktVQ1FmcmhZZUIxWkFROFZyTVlqTTZMQWU3enltTkcw?=
 =?utf-8?B?bFk0Y2JTQnRRbW9OaWVnNUF5T1NnZjRIWFFMR3JwZ2JZekNkdGxZQ1crNzB6?=
 =?utf-8?B?Q2xBaWgrbENQRXVOOWJrRldTaHF6dUIwUjBXR0YzTkFLQmFQVkJqWnJ6akdv?=
 =?utf-8?B?WFF6MDJYeSt6dzl1amtjU1FPQlJNdThLR3NKVlhJcDdvT0xjbUF3Z0hyRUlW?=
 =?utf-8?B?MlBYWVBLSHpuWDBVN3ZmUUI3VE4xd3p5aXE0c2ZWbDJYeTB1ZHdUSGJOZVE1?=
 =?utf-8?Q?zlJFSsxsVFg+Cq2cEAeVWjkli?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88ef84d9-d753-4d41-7c5f-08de3d85cf0d
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:03:25.1681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ayILIetfJexab4ZwVRZPlURrrgkiqHx+Mm2YZDZgMBqMUkvtuuM8mMATxjuP36fnbGV9LFvALM+SkmyZFA2YA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR01MB8665

This series adds support for setting the BR/EDR system default
connection idle timeout, documents some previously added default
system configuration parameters and adds decoding of read/set default
system parameters.

Stefan Sørensen (4):
  doc: Sync default system parameter list with kernel
  adapter: Do not send empty default system parameter list
  monitor: Decode MGMT read/set default system parameters
  main: Add BR.IdleTimeout option

 doc/mgmt.rst      |   4 ++
 monitor/packet.c  | 117 +++++++++++++++++++++++++++++++++++++++++++---
 src/adapter.c     |   9 ++++
 src/btd.h         |   1 +
 src/main.c        |  10 +++-
 src/main.conf     |   3 ++
 src/shared/mgmt.c |   5 ++
 src/shared/mgmt.h |   1 +
 8 files changed, 142 insertions(+), 8 deletions(-)

-- 
2.52.0

