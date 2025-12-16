Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023086.outbound.protection.outlook.com [40.93.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5ED328261
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876850; cv=fail; b=E2UqEdOj6n+XhMSyfxndZo0BjAMeALNiDwHCxuuURvEOeQf4qurfNiA81I8HtUJBbGIvurTMPSgEMM5rMrM9u0OUFwfGLU5I8zMwtjBICXoNrVxgj+klQC5PApC4hc5IeORRLJ5uHGJGw0wAEch/B5roqS4+khn2FstG5xPsjQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876850; c=relaxed/simple;
	bh=dMrUgfFHyN+dHAjbOXIVX7gwAM57/tjecj0nDnWW0gQ=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=J4Kp6g8tDrIfOHCIK4pleMXLnhU/eJcl293Ox/Me1GpDldC/1Mj9BU95eL5OlLz/e6VBZd4U65VqsCOwCYGyXUYRyFs/iIqEny/txU/vU0xovI8XMhXdzw77xbrqJzyzZDNKEvu+nolLsGmKtBq1AIs8jTN8N1zfx3P7EH0vITM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=T2fZqtDQ; arc=fail smtp.client-ip=40.93.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="T2fZqtDQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lja6UvwgGF9UxG6bRGuAZYgU765+qkzsr0fWbSoK/gYkAOtl6sxhUs4KvijD9cF9mHm2XPpdjuqB5lpkdsKFHuBlv6pjbxcsNdphqU/TG/RumCQzgPz6sdpCNXs1dL0tnPKd5ex9DMr0h8nYJdR/44ecfAr+tJevJcyglmCCevn5JMuZFnUeNXPyA7qhqNoDwJ2GZLNi9zepy3hjYATquWvFph75mnJAy8sT4lg7W0WaKXH5Hv/4rckB9njoITJikU+XIOhqKNOdB2PVMhx3acSMUiWwpGxJIHaCFdNTAUrmlrSikutSbpWoVvT2/UYn0dEV3I1xO80iRo7Q6exiHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVuJQ3th5jJ+CX4TvbLVis9uTdJMvJf92UosrXw/xOo=;
 b=kfYE9QJyZpGAINWmehuLVCM1c03Zp019lJsM8i5hBDZIai5bCnhfiQolDkY9Awd+bhs3ozAFa1dABGEOgYGsxRIFbNWEAV/GkxhuCCEOR0azhLnrHBrmX9IYzaoh4Hdh/nzbPvjALF6cYdBbN23qKk7giUDem0YbZ/QNl34JYyfm7gcqOTi9uYs8ObaH3o+bFe7HhlmR4jaYO+NZ+JF23VFtWs78nsP747iNNW55zhbdzAjVSSjgEZST0em6E5r6b5eUzX4w0ooqu+31mCn08lusWj3b5anlkioUiMfuTG41Zup1h/pX9IT9tIjHQoBFqLiCIiupm+i8m5K8cMGDUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVuJQ3th5jJ+CX4TvbLVis9uTdJMvJf92UosrXw/xOo=;
 b=T2fZqtDQRWSueu/c05tSPH9VawLRgE4A0ibzAEm4IgtZvQvsUteS8pIk4PCRvnOpkOKSqcgZEJ3NlzVNRihIOHd4rYy6gOFfE4SKwex2m0qiWtmaKa12xQStalI4s9QW9Y7Avx6ZVWhaxgp/6vQ0SC5j4GPZd8l8GaZfhbxEPHnzb6ofPR5iGKoMaV/8w/SLkS0U1yk5RH9F02PHciHLt4Z4edTK89iAx6B8LPEDbUJrpHn9lXOH7+K6eSRITwCAULIgEySXlzexQ985Kk32FP4UQP60tC2GBlSB3Qo5yAdcAy+65hWs8kwzIqyMe6kkJ49+l+sF75CJopQZlkje5A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 BY3PR01MB6548.prod.exchangelabs.com (2603:10b6:a03:361::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 09:20:46 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 09:20:46 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH 0/3] Bluetooth: Fixes for BR/EDR connection idle timeout configuration
Date: Tue, 16 Dec 2025 10:20:08 +0100
Message-ID: <20251216092011.111208-1-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0219.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::9) To CYYPR01MB8289.prod.exchangelabs.com
 (2603:10b6:930:bf::10)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR01MB8282:EE_|BY3PR01MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4d0758-da60-4473-3e2a-08de3c8464bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0R4dVpLdVVTUmdwcWJmUS9KRkM3MTZaNER2VFlFVmZ4cDkrczNCNjBHM2ZL?=
 =?utf-8?B?Yzdpc0pTK1JDMGZ2ajBEYXJJemwzZlQyS1J4MG55cmd1VnpJZlJLVnVtVDBp?=
 =?utf-8?B?eDdDV3JsYjI5ZHhaRWZEMzAxem13bUVVN0JCMk5pUXNuMTN2aXlUVncvN20y?=
 =?utf-8?B?LzR1cU5hVjJiNmVZKzN5MDZ4bXZ3MnBRc3lLQk1aTVJ6NnlGL1YxNUMyVTZp?=
 =?utf-8?B?WlF6cUlDMmNtd3ZNZW0rT2l5NDIwNHQrOGpkSldxTlpZVXR5c3lmQTBIYW1L?=
 =?utf-8?B?M3d0Tk1VWjFDWHlFQTF4azRpSThva0xtcGU1VFF1MjN6c2tuQ3RDTjFDNlBP?=
 =?utf-8?B?OEhmN2UxT3JCQnc2cWxZZlFkdWhtYXdKZ3ZOYmlJZ1oyL3RHY2Z1aU5iZTM1?=
 =?utf-8?B?NmdZS1g3Ri9ZY0FwbXI1NE4yTVcyV25zWUNYQ0V5OHNiRlA3TDNLUVlSZmQr?=
 =?utf-8?B?OTVENm52MkduTkVHeEVESXRadVl3cS9RaS9XZEFtU2hRbHJ5RlhmWW5TZldE?=
 =?utf-8?B?K1JlTmprRlBXK2pQWHYrVVdIc2V6a1AyOVUySExWS3JMUVZxc3pXRysvaFVx?=
 =?utf-8?B?bk9qT0RaWkc4VFJ1U0ZqVjRMeTljT0g4SW82bllPZElCcWRYYllDYTZXNm9j?=
 =?utf-8?B?bkVhTGZmZDFwOWdtK2hsRnVJTVB0Z3l6MkFpWmsvVUZjVDRTcVV6ZTlVc3lo?=
 =?utf-8?B?UUJoaGMwTXZOaHgzbWNiRVN3M1VlYlNMQUtwSkw0N3ExQW1WTXFLeHh0ZGNG?=
 =?utf-8?B?YkU5UFJ2eWlEQnZjM3FPSGFKblJ5TDAxSUdLVjhxTmJrOUp0VUdpRzJSY0tl?=
 =?utf-8?B?aEQ4ckRDZjJGaVdTd1JFMUthVzJYS1QrTDlGZDErNUJncDZBcCsvbnlBdUNX?=
 =?utf-8?B?eGV0N2FjQWJkcWRuU0dVU3RBUUI3bWVqY0plYklVSGhzMjRTUk1wSUkzSnZC?=
 =?utf-8?B?bkx4SXlHdUcxRWtCK1dWNWNyRm5jU2NFejMrS1NKNG1Mc1dQS2tYanhtYWNV?=
 =?utf-8?B?MzZzd1g3V0dWRjVNM3BzS2xzNGZvSU9xNHVVWWNjTTBzYktwVnQraEhXdTF5?=
 =?utf-8?B?elhJbGo5T0R6NFcxa3ZqekxxeVA1UmFnbmViS0poUmhMNDBWNHNoUDVJc3ZW?=
 =?utf-8?B?MTRQMzU5Q1hPSEVmWnliUDB6eVVpLzR3aWFRVjhHZFlscHNhM0pob1hGUHJC?=
 =?utf-8?B?cEhYdkR0Snd6SW9PbHFJSHNSVkhpbjVUWFZXQUcrcXRCTHVGSzN5TnBnRmRE?=
 =?utf-8?B?Y2FNcHJIdGdJc29pWlhSSTN1Um1MWVF3WUVRQmsvby9vZWk1UUoxZUxMUnRi?=
 =?utf-8?B?RkR0ODNHZ2t4R0FOQy80aW1ubVYvQ3hyVWk5bkxKaEdFRGJCL25uSkF2UEkr?=
 =?utf-8?B?YU50dHpZc2FOR2NHQ1A1TnRxVWRRaDAvdFg4TEhjY1o5U2RMdld4dGJ4ZWdJ?=
 =?utf-8?B?U2syM0NadmZyK2NWaVFnU0dPdHZ4WW52RUl5emZ2WVVsellVOWxoMTZFOGxB?=
 =?utf-8?B?ZzdUOWRjYTJ3SWF5dS9RNDIrb0ErVFNpMXhyTkdpMVVicFMrRW1TNzJFSDlm?=
 =?utf-8?B?Q3VzR2JJd3dyaVp3WEd2Q2VKbkpsdGxMMmUyRlhkbGZzVU1oaHRSL0RvazhM?=
 =?utf-8?B?RjNkOTlldFQ2enhqNmpnWEk2d0hwRW93ZjF6RGg3WHJqOUMrNSs1bHh2clE0?=
 =?utf-8?B?cGZHVm85WEZNN2d6ZlNQTDdDN0JIYmg5ZWM5VHRxREdoTzczdFVYdTdHMi9U?=
 =?utf-8?B?NTJsOHJrMndHcEdUVGM4aXBScjZpSWlQWW1mNEt6b3J2cW5BMGpTSHFqWDNn?=
 =?utf-8?B?aFdtR3dvMnZCM1dGMzJuUEc1ZXMyR3B2NlBjV0pmNjhkcXFOVTRMWjJ0dGZI?=
 =?utf-8?B?NUk3bFJhS2ZJNlN5eEFsbUViZUowcDJJNXF4azc2TkZtREJ1MTl1dWQ4S2dS?=
 =?utf-8?Q?vGQSPPVdfNQ1/N/ah1X/bmcLJaJhUi64?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VE1PazQ5OEdPTVJMSXNnVnMvSmhzU3hGTml1V1dMS2NNcTBtKzN0MWJoYjhk?=
 =?utf-8?B?bzVQRzdWeGdLRVRYa2xSWG1KWUc4ZERBaFpJQkIveHhXa09XM1pJYVlwQUs3?=
 =?utf-8?B?c2VqV2dFUmxHTVJ4Ymw3MmRDclBicGlxQ0thZDF3L0k4aDNtaUtNZHUwNXpF?=
 =?utf-8?B?ejJJTnpCY3J0UW55YTNuYnJ1MVlpRTkvS0llNkdkSDlyVEpmNGFvaDFhZGty?=
 =?utf-8?B?d203TTEwZ21EcmdLVWxlZW1VNjhSSW1zbUdhUjBkMDZOQW8xNjFhalVHM2p5?=
 =?utf-8?B?K2c4TjZVek42UHpnaS9ERDQ4UENmdGlHOFY5VXUvckM4WVFsUzBDWVJ5MWd5?=
 =?utf-8?B?NFN0OXJDUEhobURzMzFFcjUzeHVZVGJ0bWtIb0pYUnhxeVhGU2ZoV2JWSXpK?=
 =?utf-8?B?eWdieDAyeWRXS2lLRGlrMXRad24zTnhkYWgxNVhTdnRZMzBva2Y2RXFDbUZM?=
 =?utf-8?B?NVNhWVpsUU9JcVcxU252aTRoRm5kOCs0NkFubk5TMFhGeUFETTBMUzN3ZlN3?=
 =?utf-8?B?K05EWXhMTjJuOHN4dEVIN2dlQjZCMmFwVm5FUkF6ay9TbTFYTDdPTFFmVFI4?=
 =?utf-8?B?UkY5aXl4S1NrdjBUYlIxRnJHU244RzdjS2dia3U3bHRqMnVQQTBxTFJ3bU04?=
 =?utf-8?B?T3lJSy8rOW9sWGtTWDZJdjhpR2gxSGRTeEZwSlE0ZVJJNWc5ajZybkhKOHdW?=
 =?utf-8?B?bFFYR3A5R1dGSDVucmFCYUQzNTJtcWtVZTkwbDdJbit6cllTM1ZOeDF1a1Bm?=
 =?utf-8?B?Tk1MOGZYWTEvSTFNUGkxb0NKQ1kybTZRTHgrMHgrcktpMUgvNHo2M1JodCtK?=
 =?utf-8?B?ZTNHOUlTaUF6dSttOG54b0lGMnc5aTZiQUFPdFIwem1UeHV5SWl6L290cEdj?=
 =?utf-8?B?emh5WmoyaEhIb21LSytoSGxiU04zSTJjcnh2UWU5QWlCMWIraTN3cUhEOWxo?=
 =?utf-8?B?cW9oOWtWUGh4cHV3K3VwME13Uk9kblJkSytPREdXT3Y5R2pjeGpuMHFIRTlO?=
 =?utf-8?B?U1hRbVNRek9POENYMnZ3anFhbjJ2MUpCMm93d2VteTBJMythUGRZZmVvbVow?=
 =?utf-8?B?U1M5cDRwZWxrUHBzUkZiWG9KRlpLWVRnWTRlQnNMWGFJMFhZcGdmbTBiUXM2?=
 =?utf-8?B?Mm5pMit6ZXFSSExoQnI5Q3V3UUp4TkVUc2xGbWNudks1Q1A2bStVZEV2bXd2?=
 =?utf-8?B?d2V5K2I5NmNyK0szWURXd1F2RWtJQldQNDVSaDYxamliTEh4MjUrU1NZS1ls?=
 =?utf-8?B?bHFpYWZuWk9HQ1dyM0l6Tm1xY1UwYU4yMXdUQTZtQTFpSlc0Q3p2ZVQyby9s?=
 =?utf-8?B?bElscE9mUFpuejViR2dxQStmUXhmMzhaZG11aG16YTJYdVBPbWx3SjlQR24w?=
 =?utf-8?B?SmQ5bGpuUjhJSGt1NUErMXVaQ1RyUTk4RzFZSmhQUW1odXdZUGhvdnlsYTVC?=
 =?utf-8?B?UjNOU2dkajk3M1V1bWh2cVRWOE9ibExFR3hIR21RSzFLQjE1MktMTDVKRk9j?=
 =?utf-8?B?VXhmQ1poR1ZxZi9JeVdOSHZoMWdDZlJFV3NIMnJiMGpaT3dWTlZKdCtNUWhv?=
 =?utf-8?B?RlJNNkFjZG40d1dBaWFFTzdCU3pnTmtIaXpEWU9KWGdrbytoa3hSSmNmTDJN?=
 =?utf-8?B?OXBDRWlxRUFKVCtGUmExVFJlSWkzUnBGeVdYWE5CNEdpQXUxSEhKMks5S2wr?=
 =?utf-8?B?RUJ4ZjNLaWMxcklMMEdRSlJVTi9rZ09TNjJtVkk1NHQxaGF4REFoTWVqWlE0?=
 =?utf-8?B?OXFwWHJaVW9zOXFoSVhTL1IxVXpWWW0vZjJNcnlPa0RCWlh4cWFlSllFdGdw?=
 =?utf-8?B?cTVLRGg4MXVTMW9sSUdnQzhYcjF5Z1B0U3pFdWlnVlFBRzdUUTczUEZBbVFq?=
 =?utf-8?B?Qm1GVUxaRUQzaHFyU3BvanJKcVNVa1hUTjd0MmVMaHNFWTBhak5sc3BTY1h6?=
 =?utf-8?B?bU9qTUpiWWVGNlNFcUVBS20yVm9wdllCUEx3ZndNMkNUaWxmK1lmN3MwN2NB?=
 =?utf-8?B?WWlPaXgwclQ5TlNybWNLcFlvWW95aGtoUzJDdVFkQjVvVzBTR2FKMU82TUN4?=
 =?utf-8?B?cFV0T095NDBoWUNjWWdxNVNmaHIrSGY2NHMwS1dvb2JTU1RtODhOeDN0ZkYr?=
 =?utf-8?Q?G0AO7FYcOPhbF8uyTvDZo42dO?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4d0758-da60-4473-3e2a-08de3c8464bc
X-MS-Exchange-CrossTenant-AuthSource: CYYPR01MB8289.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:20:46.3380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zhT2c5elsE5jvomRh7y2MDjYbwDc5JzGtAGw57Mkt7TJ0A6LlRFnvjrGtXDEgIgoF0K6YotD9CBW+rulytuZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6548

This series addresses issues with how Bluetooth BR/EDR connections handle
idle timeouts (entering Sniff mode) and exposes the timeout value to
userspace: 

1. Ensure the active mode timeout is correctly updated using
   mod_delayed_work(), preventing the timer from being ignored if
   already queued.
2. Apply the link policy to incoming ACL connections (previously only
   applied to outgoing), ensuring incoming connections can also enter
   idle modes.
3. Add idle_timeout to the configurable system parameters in the
   Management interface. This allows userspace to control when the
   Sniff mode is triggered, complementing the existing ability to
   control the Sniff parameters themselves.

Stefan Sørensen (3):
  Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
  Bluetooth: hci_conn: Set link_policy on incoming ACL connections
  Bluetooth: mgmt: Add idle_timeout to configurable system parameters

 net/bluetooth/hci_conn.c    |  3 ++-
 net/bluetooth/hci_sync.c    |  2 --
 net/bluetooth/mgmt_config.c | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.52.0

