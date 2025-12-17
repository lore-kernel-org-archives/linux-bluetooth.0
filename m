Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11021142.outbound.protection.outlook.com [40.93.194.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0891DDA18
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Dec 2025 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766006833; cv=fail; b=XFKDd2w/RFZ4bJkis5ll5qzNcdhBwssc4Z5+wbJgvwAbN3EfHjp8OOdvLdzOACSXI3w1+wF9Py8H0iTnrDE8h0aEjoizPC5k4w374lLt9y761O/10ZfzLI/bYqED1senaliR5VvZlkVGBaWUJK2/v3NBFAuR/tc9qlWiyb2PKqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766006833; c=relaxed/simple;
	bh=AyYp3SDb2H4s3lbBVtjErwTCEmak9N0qTKKUg94EG9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ORz2GMnQ63yjs7eOCC8wo5rYrf49QJuLTV7Fy5F5hCMAyaV6/db8tfsZRwTdIny+SNBCmnGVgXGKMnxEzBlSYFOOIYqEtackccD/6zgTvjSay66WDINn+Zpa+2JJZwE/K+eyK13lkGUUJbemcAgjC4r2SJn7JA9OGYL02uUu+k4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=czDbzS6f; arc=fail smtp.client-ip=40.93.194.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="czDbzS6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LYmOyjuImG41UwW/XyvIAMXKowlKnzvBGNJb0fzU1lk3bQjMqa39NNrjEhpII6/+rI+rOaFEw0s2fQGJVDRW8c6l9ZKGGh1A+8afpbBNQ8euzg/XiFXyTnbC2VN6ZK11jBLkLI9cj3fMRNJHwGsrTJTMZ52VT6pKrqNsu5rhegQl6XX7/8sE6ctUWa9mQSTNKP3MJBF5MB8FCRXUthdT2dCChl1XLzDnM/ftY3DIsiK1vWVjgUbfxWbRLfF4Ljnunk/e9UW9lKx/5LDDpvTI3vxe0gF/xt5zyXj1igHxlmEJpK7JWLfIWBnFvKnPIhxAKmu1t6LHEcevMqTzOvHwIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy/m4MRazMyvAU5td8bXl3/LIXpRq5mQ/8J9zTgnBRo=;
 b=CxlApSzq4k1Kmr2teefXzsjLNEhhyBDbAOUX9iCoh/56oUN6IRg7+rdxaYqxEN/Ga5rvtSw99uHKoqz7kQd/aiFvTcoco7Uwhn2hSkdMYG+AScaFVWGeI2GibhmN8idgle/qZ+EeFS097iVOhs0A0uQixBLQJNpgL/AI9Yi4388q04PzV/Q8RNmapBx4kand210Fp2JU3slUw1geP9Kh4PD812ZAOGXm7PoNniXncjTnBFGaGb9JdmfQgZ3lAS0T9dq1OuTUCT5tJFOI4Str8aV5NGbiNeFgEUyZd1Ad1RYhd2e/STEXHzIrDqDiiVIPYZq1XW7dQo7ZbTzLaAGTRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy/m4MRazMyvAU5td8bXl3/LIXpRq5mQ/8J9zTgnBRo=;
 b=czDbzS6fVKKJ/BuiLHkpKYoqGifCRrU+aAHO19462pzRVO4LoyvgLPGC4VyZqMJXwwmPaRPPGtlBZ/F7TetLxH/650fSCyg5fRRTt3kcFx0lW7wyxhuPF2eh7DrzBpLKra7HqMQp11Wk+DkMeyT1ea/TKz50EPrAnmEvfGsxDdxwsJV3+Zw7aAbF+tvJ+VVVcHHCtiqip+frpIGZ6q9tZ48BbATnOmFG4fXuf9HPpl77814xk/h0JxQ6VjOLr2zfNfGk3+Mi5j6U0dmSSbRnU9ONDopJL8vVpoToCOOORlpkhQe4isAgJWpcJryXitup+c/78/HkMlpSYi4TSNUBHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:21:26 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:21:25 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH v2 1/3] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
Date: Wed, 17 Dec 2025 17:21:10 +0100
Message-ID: <20251217162112.444181-2-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217162112.444181-1-ssorensen@roku.com>
References: <20251217162112.444181-1-ssorensen@roku.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:208:335::10) To SJ2PR01MB8282.prod.exchangelabs.com
 (2603:10b6:a03:540::13)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8282:EE_|CH0PR01MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: 90abbb93-49b9-4e40-4374-08de3d885333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?c2JlRlZhU2JjN3VneUtvRmNROUY1bkJsQUNVdkNHNjRNMGRvZy81S1dMMG12?=
 =?utf-8?B?U0xSNndnQm5xYVByQ3A1U01XemljalRwYVAxbUxPYVA3aWMyRlg0NDFLM3FD?=
 =?utf-8?B?cm5xRWVvMTZIYWpiZUJuMlBHWjR6Z1RNQ3JvTlAySXFkSmxwRjNxUzRSbzNJ?=
 =?utf-8?B?dW8rUTBqOEpsbnhPdkdmYTQ1RHJ0YWpueFMwQXFJZk5QZTFwd0xRZG5oTTZL?=
 =?utf-8?B?cGNoY3o2RjhTaG55eS9CUGVlRlRSTCtNR1QyTjRnZ28veEhNdUJLZU9rZzFV?=
 =?utf-8?B?YnQ4MVlUOFNVUFg4dkhONzRFMFMvRTRrUTRkem9LQm1XK1NobklJNW15N0ZB?=
 =?utf-8?B?eXhvMXNRbTA1SHc3UEkyZG9uV0Z2TG1EMXVCdlBnNFRrZzVQaGt2cVlsQmpW?=
 =?utf-8?B?d09wM0J6ZktNY0NpRHpqOGFmTkRSWEp2ZmZNS2V2aEYvSHczVjdWTEF5cjBS?=
 =?utf-8?B?bnE0ZE0wVjF3UFZyb0R3OW1TQXR3RHZ4UnhOMERJaHFkTEZIRVdCVkxaZ0lD?=
 =?utf-8?B?OTFaMlpFRnpUaE14WkpHeDVXci9KVkZsNHI2Mk9QY2xFUUtSbm9qVi9mR0No?=
 =?utf-8?B?T055K05DREtoWVVOWVozVUFMTytiTlhsWm9QRlVEYVFaRVcxeFhFODN5NXJR?=
 =?utf-8?B?aTdFVTY5RkhYTjFZVENJTjQ3U2E0SnlpQWdvTFc3dWJFZjRIdHFadjdXckNs?=
 =?utf-8?B?dW1TblhuQ1Jqalh3NlRiQWxVbkowMWRNcHRMY0o0QmtsRFlnbjRGUkU5enEr?=
 =?utf-8?B?dXE4MGlybTczMlF5aHgyamxhOEkwb3AxNnlha3pWNGpNTUJkRWx6dHI3K3JG?=
 =?utf-8?B?dzVNeFRnVWVpQ1BWQXdSMDJpNWJyUkN5VDhISjZpc1RDQXZSSEZRdThzSC82?=
 =?utf-8?B?YldSdmJ5YnF4Q2dYZStGdkhxcUVnN2JKVnAwMWtITHdRL1RUSGFldDFsdUNB?=
 =?utf-8?B?Sko5NmZFYzBJSk0zVEd5N0l6Vmdsc3RDVXY0UjJsVXlwdEFCZElDUDF3YkpR?=
 =?utf-8?B?dEZxb3dBbkpmcW9mUXhJT0I2d0VsNE1PL205ejRRRUkvaHBhaXU2RnMvdWFv?=
 =?utf-8?B?R3dKTEp2djVVMnFocEhBNlNGYlZPci95dm9OMDNRMEtmS3VBKy9naFl6UzlJ?=
 =?utf-8?B?dkQrbmxmZGx0KytWS2FtYkludnpTK3o3MWJmQUs1SWRRQTY3a1I5WmRkSkFD?=
 =?utf-8?B?SWIzbnE4SlVYR2MrM0VWM2FFN0lGckg0UCtNNmZFYTAxbEVnbmRoNTJOM0U4?=
 =?utf-8?B?NDB6QTNiOFBoNHBiM1dxUjhjRTQyaWFNSFpsZGIzbzNyQUhNdGV3T2lna21X?=
 =?utf-8?B?d1o5TFovV09aRmlBc0NNcnU2cmFoSldROEdhOFZsNlJXS0FJa3VEcmszcjZF?=
 =?utf-8?B?TUZBd0xxMlM3bG1KUGxaamxiZzZCYUthOHk0b0E0YjZ6aGhJeml4RnRVOVFz?=
 =?utf-8?B?eGI4ZWxaVHNhdjhHbEpaMGFxUVNrVnJiU2phMVdzZWtTWjdLYStMVElaYjJK?=
 =?utf-8?B?V216UmhHQzU0U1dQVWhDYm5ZOERGbmRnNWF4MTVkTHhHaWpyL1ZBRzIrR2tu?=
 =?utf-8?B?OGlXNkNjVXU3TE82TDhrZC8vQ1FBdkxMU0hTTExDc045cGNSN2xPVFIxZUxY?=
 =?utf-8?B?ZXQ1YTFpNnhhMjFwV1BRbjZ3M0NFM2hDOXZOZEtrQjhNNnhxSnBjMjYrUWYw?=
 =?utf-8?B?YW1VNThhNkhvcFRRcW5GbUtaMHd5ZzNNWTFzT3pIYWRDMFZSL2R4SVF0Q0Q2?=
 =?utf-8?B?OEpUVXNaRnB6c2t4NVlhUUJ0WDhJekR4bnVHb0x6U2MvNG0zckdXakc4M3pD?=
 =?utf-8?B?M3Ezek5hQm5PeWpqVUNsWlJkQ1BkZmxNU0RDYUpnZWJFL0xhd2dZcXkva2du?=
 =?utf-8?B?YnptQ3ExYjJTYm5PakpnRmJWS2pUUnkwM2NidC9OS2VzQUYyL0hwazJ2L0hj?=
 =?utf-8?Q?0PV6OdNTNAJ+Qg25rko2QvBa9ShcgaFD?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VTZGVlNQTVNLYXhqU1BmVFBSM3hGTk5ETmRRbDhucVp1SXFhbnVkOGNHOHFG?=
 =?utf-8?B?WWtkZ2lnSittSk93N09HQkpud0RtNkdqRWFlejBKTkdnOWFaZGR0ZFZpRlRD?=
 =?utf-8?B?SHA2Si8ycWVjTXV6czBBbWZ3emJJWkUvTy9rTHZxTDF5bUlmZHIzZC9XdGNa?=
 =?utf-8?B?V1lwckdhSmt5WVR3dXJ5bklRSjVLVm5GZm11aHJISy8zUXhGdXRLZW5UNnpw?=
 =?utf-8?B?NmdKbEhIMnNicE5tMkZyM0lpb2haUWpSZkV0dmh4blRqZ2ZKVjBQNysyMWJu?=
 =?utf-8?B?ejdaYkQ2LzNFL1ZZMmpMbVRvUHV6VDhTZ0FJRWpvTW16cVB0bmxGUVdRdXAw?=
 =?utf-8?B?VjNad0Fqd3hmVGxjcXlVVVAybWdGV2FuVWQ3dFg2Wk5IU0diNzNLS3laOVIy?=
 =?utf-8?B?N2FoQ2lMdWQraE56VnZpNkZCVXpMcjVyRzAxL2tEQlpoOHh3T2VEWUE0L0hK?=
 =?utf-8?B?aDFmSjJGTlFjREo2MVNiendocjJ0MVloMUgveUd6Ni9EQndScjl3djVhbkpF?=
 =?utf-8?B?WnRGeVFVS21OVm5NNXVQa29kVFFhaUEyVEJhTVNvZFJmRERVaE50aDdFdWZq?=
 =?utf-8?B?QlFDUWtpb0xoLzlheGdaVHMzSkxnVUtpbG1mYkE0QkEyN1QvZ0NycjJKMmtJ?=
 =?utf-8?B?Z0VzWjlSZ3g4NGNCZ0dYMDBFMUNXbzVBbW1LVElSRTBBOU90WGVDbFYzRHcx?=
 =?utf-8?B?cFNlamdobjdBMWo0VmZCVmw5Tk1YUXJOazhqWEQzckV1bi9UZ0NiSWtZTzU4?=
 =?utf-8?B?cEcxcTkxcXRpQlVra1hHcDlEL3RWdmlaV0trbUdUYjcvUkxQeHpZbzlGMXI2?=
 =?utf-8?B?aFlWbVlpQTNnMkZBZDZtYkNoc29JTVZTUTF5MDBQTFd6U1VqYnlCaHozRzFz?=
 =?utf-8?B?OXIyaEtJK0ZMTDRyZzBNQmhEOFBHSmJFRXRlU3dFUHdvSVpXVWhzL3h0aXg1?=
 =?utf-8?B?R0lkanpKWVZwc2E2cEFYcWJhTGNpY01FNVk2WDhpYmdhV1VUUWNybHd3WWlt?=
 =?utf-8?B?L3dLWDJaOW95ZFNPZG0zSS9XMVo3MGIxalAvV2NRZ3Ayb2NiNkhxbTFrVjF0?=
 =?utf-8?B?MkJHTlUyNy9Pako2RkJabjNOb0kxS2pwRktlZkZ2YWhVN2tvYjVGL3ZodlNy?=
 =?utf-8?B?Vm9XalIwZHlCSXBoMXFXSGN1MlVjNmdXNzIrdENKQ3RqK21zbVFXMzdDRXdp?=
 =?utf-8?B?Rkt3NklvM0xYNVJ2eUVFN05xOGY1eUFmbU1pTDFOQVRDaGgyTGkwRDVhUGFR?=
 =?utf-8?B?TEowM0YyKzFNRXNzdWcrZWZLOXQ3WGN2Tzl1SnNCN2FTcHI0Y1UxWWtwQ1JR?=
 =?utf-8?B?U0IvOGtUU21XUU8zM2NZRjBZdHkyd2p6Mk05d2RNMEp1TTR2KzF2bVFpNXlX?=
 =?utf-8?B?eVJhZUZuVHg2Umphb2s1WUpQbm1tdlBuRFhBV2tqeEIyMGZ6WFpXcFNvRUJV?=
 =?utf-8?B?Tlo4Qjl4K0ZETXlsd3dFSjl5azJndURhQ1p4dWFnSm9zV0g1NHA3bmVVRDBz?=
 =?utf-8?B?ejk3U1FOQmwxZXQ3R3V6ZGt2N2NqZk1KVkhzaWRMSG5yTTlqN2hWOGxkN3BR?=
 =?utf-8?B?VTZiaHlYbDFKZ3NlZW9SSWVYL1NJRy9NOEZtNytmWnZJRFN5SjltQTNiRkUw?=
 =?utf-8?B?NUUxdUNsNUluVkdLMldkemRxYXlYTkRuOHZrNUF6Y2NVVVBWVEEvRXpnMGtJ?=
 =?utf-8?B?cFBYa0JEU0hqZGNuOEdOT1BJUzAvckxXb1J3Rk9keWtUYlNlRTNjM0p1UzBa?=
 =?utf-8?B?bzFjTHo1eFZRYmwvT21ja25BaFgvOUtqT3NqbXJDVmtaNEw2UW5MQm5BVW1a?=
 =?utf-8?B?Mks5Z01qYklsbFFwQy9lWDFNV2MrdHZaamlvYkVuTi9HYXREbDB4eEUwVE0x?=
 =?utf-8?B?OGQ4Y2NrRnBFRnFXd0JQZWFQNHZ5Y1E2UTQwZGRDNXNlOVJDQjJiV0h2OUtw?=
 =?utf-8?B?K1Y4Q0ZEMk1Xb2QvdlZZSFJQN2QrQUtEeUlJWERCV2VqZUhxUXJmWEFKTzlN?=
 =?utf-8?B?N0M4b1JsYmFIWXdib2M1dzh6QzNVYUhKOXFWbGM4Z0Jxdm41N1FSNEdVSWcz?=
 =?utf-8?B?U1FvSEVIRkV0RmhENFQ4MUs3UHNqT2ZTRi9ZeHZsNUxTR3VpVjJzRE5WdkFB?=
 =?utf-8?Q?9zr0BrnmOEDhzTe1K85h0SddD?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90abbb93-49b9-4e40-4374-08de3d885333
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:21:25.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e8yfx0V58YyVmlcFHi2WzUl0jfWzljQ8rDAy/s+A1W/rR4osBRHzHWJ6VdBPX7ZRPa8y7mhAfTFVytIwN2JRow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091

hci_conn_enter_active_mode() uses queue_delayed_work() with the
intention that the work will run after the given timeout. However,
queue_delayed_work() does nothing if the work is already queued, so
depending on the link policy we may end up putting the connection
into idle mode every hdev->idle_timeout ms.

Use mod_delayed_work() instead so the work is queued if not already
queued, and the timeout is updated otherwise.

Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
---
 net/bluetooth/hci_conn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 5a4374ccf8e84..837038b5c5681 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2619,7 +2619,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 
 timer:
 	if (hdev->idle_timeout > 0)
-		queue_delayed_work(hdev->workqueue, &conn->idle_work,
+		mod_delayed_work(hdev->workqueue, &conn->idle_work,
 				   msecs_to_jiffies(hdev->idle_timeout));
 }
 
-- 
2.52.0

