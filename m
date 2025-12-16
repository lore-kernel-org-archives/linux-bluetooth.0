Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023086.outbound.protection.outlook.com [40.93.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0F4330B02
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876856; cv=fail; b=YA40BM/6YUdMsw5/Z+dSaY9/6rWzZwzo/ujWk25siQqg2lSbnc4pTdNPlKo7R5t1VVrCZGnDDR0jQ3sENi9mg1t0/g+PuFNCawfnaUWQoKrhrhnagr+88T34BqfMNXOOZcZAknuXMN7B7vwfnP0KHZfUHocWeHdljljCh6boHVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876856; c=relaxed/simple;
	bh=7flEKj5Bi4+hG7RCUrXLKdbxS9PnG8BBNehuuA8+Xr0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pg8R8hMkXcSMh1/mIHbh2/0KJkm3/x4mp8Tq8Xh+XZ/HwRphsxwZ9nVuGxVvpY7w7KNDtZVy8/5EB7LK8tTJ8Zmbzmwo9QyUGYJnIrTHHGZ0jWFRXj6OBQm+92McWN7vg/YgvmXLlONjbvygLeg22jZM8GKAp+OAIZnGdW1JZwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=VoSwjMgm; arc=fail smtp.client-ip=40.93.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="VoSwjMgm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfpCGYqYrVxHTItCjvIxGPInczrsQoFpwe7GTRNytm1R7xJL+0pYaSrKUEf6G1IixLmtrAZNQStp2u8uCIXd4A6ZCopqUKiBpjq1l2sIq/DWwQx4h0tQAm5+O/mxWYCXsl8iaXx/lYGw9oSjVr7rzg3Cu94PGqd1NZZxSRT9tPuIMkk+WBxkY+Xh/VzGhqF22G0HGrGocNXDQnXPZYnMDPLntpRZOXvBzod6kAhZaNktYiRgmg/wngEcSNCfn2Ph9AT4CDcvOfVsbaOqrO4JDoJ6hx4ED3T1jyTebluOt6dFdh3leNMfb/zN/rGbsE1Vh4HbUj40DeGTctzMyzTIPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVvsjoM72BEZbtsVy0kBckWPz4JAJT6Zjn/CKAH/C7M=;
 b=oq3rBhb9XOcGwa18Xh9mFk65guECQclN3ewaYNbHa3qUcNfsSfL+hc5BEtXuZUdN+NqsRsMTvZpKDhZC7uSvgdXnHShgOKQWlyIwSxRDrtsNLiXDOQQuG69qwhegy8XuilnN2CE1rub54BZUL4S6inDD0pep+fFndqA7EawIxTwFe/i2U7LGUVKgtdo4yRpNnlSvX/58vnhuCFoQ2USOmy8A3QxdeXBdYFJpiHemIviW6iibDus5M7AqxmEnnFxw0jooO6wl7VAhibMQTIsXBN6oMuY/wih+2OsZW4Rrm+UTXgY9AD9nzWBTUMJMvR9AJf/RvEBW3IxeAXFG3ddmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVvsjoM72BEZbtsVy0kBckWPz4JAJT6Zjn/CKAH/C7M=;
 b=VoSwjMgmn9bUp+soxBIP4fsztFvwDxr8MpSJb55T+W7HIR9cMR3IDVuMbCEeJziXNnZpgeD1Uy8k2XBprApaBoWU67SPEhPuM+FT5mfbiEkVC3bXeid98zXQFs2SETU3gJ2+xfZRJm4NHazrnPjCtZaCe9gc6k8yz24/R+SYqJ4y6SdBSc1Kr2o0k110jkufJ/zRZSOS9N+zsikK9PBwsLEjt2Wy07LUILxco3UxCdQUY79qr30NaZFYnd5vnAczjkQPGWA9Z5xpSxmOQOexAwgsfNs3vPWxs1ZTGjcOE2i9yPgGeaiC602GA7Eh2ks0aLTe8l2H21qO8jr4uVPEbA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 BY3PR01MB6548.prod.exchangelabs.com (2603:10b6:a03:361::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 09:20:53 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 09:20:53 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH 3/3] Bluetooth: mgmt: Add idle_timeout to configurable system parameters
Date: Tue, 16 Dec 2025 10:20:11 +0100
Message-ID: <20251216092011.111208-4-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216092011.111208-1-ssorensen@roku.com>
References: <20251216092011.111208-1-ssorensen@roku.com>
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
X-MS-Office365-Filtering-Correlation-Id: e713b7c7-895b-4ef2-a691-08de3c84692a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T0NybDlnSUtKOUVYRVg3cnlXdDBNaC9BdzI1eG9qckpqa0M1UnozQ2t3MWhh?=
 =?utf-8?B?S04vTnEyOFBxUFNOdUpVNkt0QUZEQlowRG9nQWR3dkpBS2xoTXFTMHpLQ1hK?=
 =?utf-8?B?STduSWUzN2pOOHludHhTTUQ0SW9GamhxaThVU00zYVRkaEJaOEdlWStiMXl1?=
 =?utf-8?B?QjY5TDdjWmZKUDd3bDVWYmdHbWJtRklNNkl0VWtVcjI0UXB1SHVnUGo0T0tW?=
 =?utf-8?B?T3RsVnVvZEtKdGhGbStlYnhOZ0oxN1pUc2xadWZMcURrL00zS08rRW03N1RJ?=
 =?utf-8?B?Q2hsSW5JVENSaFVOa3dFUnZJZGhNK0szcDFMa2Zwc05QV3BvUHYzSXl1MENk?=
 =?utf-8?B?K2JHUVAvMVk0amh4U3NCa3BaaTQ3MjMyekY0c25ySWoxa1UvTUVTemoyNXJM?=
 =?utf-8?B?dG8rbnpzNThmdkwyTzdLTkErNkZiMERGeUQzbDY1YkVZTUE5WThHZExHaXRJ?=
 =?utf-8?B?MFdYamhUOUM4YkxMblNLNkZXc3NZcU9Bcy9lU3V5VHRFZFJ0NDZINjN5SFNt?=
 =?utf-8?B?L2J5WWxiSWdGcjh5V0ZSa2hxbk9EY0Q1R2VPeFhPUDhRVk83UG8zaW04ckhl?=
 =?utf-8?B?c0RnYmRUWm9kOU9RWkpNMm9TMmorcWVaTVZxYkZDaHJYbC9KL0FhSGJuSWVq?=
 =?utf-8?B?QUZmWVNrclpFbkJzeHpTL25WNGpIRWd1QjJPL2cxc1VwUUFjcGpoSk5BWmE3?=
 =?utf-8?B?b0xYclRQTGpQTlIveG5zWjRZdVNpR3JvYkswa3l6SnlrTUxqUk00MWZIZ3NH?=
 =?utf-8?B?OHE3MzhsOWk5bmRXMHZBeGlhazg3cXhCdjZkVTc4SlZWTXBpRHlDemNrT1Y2?=
 =?utf-8?B?SzJsSnhmdHlqckNSRi9sbUFweUJRdkZYSmxkekczdDRJTTBlNHcxQ0dEbmx3?=
 =?utf-8?B?N2t0TkxrYUxuVE9VL0s5c1FxQldzT2R5dVdDZElpei9HRVJJMkdwcjFFUGVL?=
 =?utf-8?B?eENNZm9sc0lvZTcrMjVKMGlzREQyWmJJeGx6VzdTczJHR3VpL1RBYTROcnVD?=
 =?utf-8?B?MnMxQjRZblR5MkdBeVFTcStvWWlYTEoxUXFUMitOOHpFd3ZYWW04L3k4N0hM?=
 =?utf-8?B?bENmV2U5S3I4U3ltRHd4Z1VnN0NaNFhGN1VwWlNMQ3l6YUY4anF3UXo1cjhB?=
 =?utf-8?B?eGxNTlZtdmgwQ0RXajhiMkNraFR5QjFzQjZKbHlIT2Z5bDFHc1FwVlFYRXZ4?=
 =?utf-8?B?Z05IZC9kYUJyNnJvWDVPOXRGMGRhTVN2RC9VT1F0eCtDZHBwamlUdEpVMEVo?=
 =?utf-8?B?c3g2Yk9yOXZHYjVxZ2UxU1E5UHFsQXBxK0ZYZzZIWUl5QXNocnVVMmVFelBr?=
 =?utf-8?B?U25FYXVxK0g0NkVKd3Axb3JTV0FvcURsQzgvYkJhRnJoREtJKytWbG5qSng1?=
 =?utf-8?B?Y2NRcStmckdtTGZNa0p5VnRIaHdtR3c3anBIZER6MzdZOG4rYXc0emg1Q0wr?=
 =?utf-8?B?aVRmaDdTeDQ2REVQMzNFZ2pPeHhqRkVYU2t6aWFxaUxQTjJTbEVBNCszakpi?=
 =?utf-8?B?bGVzSFRvbVBHRFI2NVBCeTk5b0VRT3p0bVJwcU9NcUYzdmlleDloL0xXaE1k?=
 =?utf-8?B?aVN0YmN3N3hLU2RRTU5OeUFmWm83VkNmaVlURWhnT21YYjNaYno0YWdqaDVh?=
 =?utf-8?B?SFczNFVHZWh1ZDl5dXAzNFFlWXNiT3hRVVRTSjBLRlF5OU96bjJNQTNYMXd6?=
 =?utf-8?B?RWF3dCt3STlmcG9jZEp4UzZZS3RML3QzeWdCVE1aeWhxOUFRM0tVVVN2d1oy?=
 =?utf-8?B?TnJDRFBVNDAvODlNZytYKysvYkxhZUZjenFIZ3dzblp4VGdIbXdlSFMvd2s0?=
 =?utf-8?B?TXRTaDBUNTRnRGVNR21RQXJEcjZuNExiSzd1VElYTUJ3SVZETjZSaWxmajZV?=
 =?utf-8?B?dDlVdnBnemtkZUcwcGJzK2V1TndGUWlsRlcrc01ybDRCOCs2bi9vWkpySXBC?=
 =?utf-8?Q?6B5/RRvWqzT6a8UMG+blcAV3Cada0pCs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UFVXQ0tkbXNtYjN4Ujc4RVZWcGFtRWxYTW1scDRNbjVUdjh5NTJpV3lPeVpy?=
 =?utf-8?B?SlhWN0xub2VFRi9pRWV0SzlEZVpFdFlMWkxLa0FRMUF1ekRqSjJNSyt1ZTVK?=
 =?utf-8?B?eEliZ1Vyb2w3eWE2K0laRkJBNHVvK1RCdkovTUIzRUk2UXdpUGlxcEYwUmlE?=
 =?utf-8?B?b0dvQ3ZlQytHU0F1TkFIeEdCdm0vbEhVT0cyYjNFNkpOeVdleVFkdnppQjdt?=
 =?utf-8?B?UWdZaFZxdkViM0VQVXNqRHBLVGxGRUcrcElXRlY2NEU5K3BkZHFxQlJSYTU0?=
 =?utf-8?B?SHBra3hWV05zZUFMS2RpWVN1dWpSRUloTU9Ba3VDTVlnMnlYeGF6V0NJdFht?=
 =?utf-8?B?UGlCc0M2L0Qzd3BzUzZISUloT2FuRGRmME16TFJNYUpHTmZCcVdCN216M2VM?=
 =?utf-8?B?SXh6anFUNk9KemNpSDJ6V1dTQ3E1M3V3aVA3TkNnWllEY2VKVWQvRkNCQTgz?=
 =?utf-8?B?aEpxRlEyS1ZiSmkwZDJIUkhYZ1hTb01rQjhSRHErNkw2UFAweXpORVovK29P?=
 =?utf-8?B?Zm11bmpKTDROMUI3SUwzdUxVQkVkRWpPSHd1cURpSTB3eGs4bkhRSmJSVURi?=
 =?utf-8?B?bHBjOEFWRTlCbFpSdGFva0VwRys4UVRZcTFaSlk1ajViUXluSmtGYTdXUXRG?=
 =?utf-8?B?YUpaaE1reHNXYnRIbkFaN01OZ3c5TU9DQVlPZ2FOUjBvY3FROTFOV2ZlSmhz?=
 =?utf-8?B?TGMxWTNFUGNnUEIyMlFBWDk5QXppb1VXc1MwOG5CZGFDTXhnSVhXQ0NDc1FM?=
 =?utf-8?B?Y0pyNy9nNEZPV202YnM0eFNPNWU3THo3YVhLcSsvVXFxdTZJVGRMLzdjK3M1?=
 =?utf-8?B?eWhkMEFndzhiSXVDWHhzek42NDFPVUp5Vy9NMzhyQStiNkxTWU5aMzg4dmNP?=
 =?utf-8?B?ekdPNWhIWTRkMTVwUEhBQzJtbld2aWhXZ1k4ZjMvSWVuOFZ2RXkvWXRNa2t3?=
 =?utf-8?B?OVBEWVgyZWJJMkg2UzloTEp0eWtObGljajNIOG1ydWJnR3VKRHpDUlk3TFBL?=
 =?utf-8?B?SWI1UEdEaEFVOEtTMEo3U3NQbC8wcmRnazlPNm9LK3BxQjBzQlczZDB6enVa?=
 =?utf-8?B?c1RweGdXS1JCRThNTk9Tc2ZmWVdFYUFSMGhLMnJoUSs3WHJsOHZIamJBMEtr?=
 =?utf-8?B?WHFHd2RNK1k1SXhHV0U4MzFrVEh2c0wxZlo5N3ZrT0tQNlpVbjVZK2ZNeVFP?=
 =?utf-8?B?Yis3YVZFcXRHRVN2MmZrNlBUTDNWZkJRdWdGLzhlQUE4TGkwM0pZWUFjQXB4?=
 =?utf-8?B?eFlQSDI0bmhlZmZYWGdYTHhITGdhMDFsNXF4Ris1Y1h6MVBnTkVyck5QZm14?=
 =?utf-8?B?azJoWG5PMytZeFVMOVJGR0szWFFxWjNWTGNwMStDbmZVcG8vbXlrTlIwUmsz?=
 =?utf-8?B?MkR6ckRMbEZucWswa25mbjhpYkJ6UHBERlVqKzRXbjhDaUgxcm1UaDZMVXFZ?=
 =?utf-8?B?ZzM2M2FKdjZXM1E2NEJpNFlCdlZqY3NUa2RqekJ3Z0VuZkN4aFJCUzZQMXcv?=
 =?utf-8?B?VHJCUThnWlNaVUpBbkQxTG14c25ScHVobTFQc0Ywam1TLzkxSmtUdFl6bzZD?=
 =?utf-8?B?Zks4VnBtVUlXVHZhRFhEMWdIMUhzQlJjSlk5T1ljWlB1Wi91VklvTkFid3Ba?=
 =?utf-8?B?V1h0NWpiZk9UN1pwbnJvS05mT0Y4RFdWaVV5UUVXd0FwS2FHa1BPbGcwYm1G?=
 =?utf-8?B?VStpeDQ4RkVSSldlSlJPaWdJaCttRmxLNjA2K01CY2RCRUZ3SmJoWkxxYWRq?=
 =?utf-8?B?TnRZV3NHeFhONnJQTnJOVWltNVIzeHMzN1FSY2JCeThRdXdSblRjVjVIV2tN?=
 =?utf-8?B?cmdZQXpaZitTaXBubnl1QkNiVUlxTFFuT1AzQmY4VXhqQW1lellRTFQraU8z?=
 =?utf-8?B?R0grZHVzNjhyUis2T2dHQlllemRocitWTG5oZVNvWDAwbGlEYTNTSHQwWEhk?=
 =?utf-8?B?TDZ1bytYcEJXRktyWmlFb2huNTFOU082OEVmY2pDTStQVm9wWmtjYmk0cGxR?=
 =?utf-8?B?aVFxMFdsVE5lV3JiRXRMeHRjMTRINmxjbXdidXBlekFtQmp0VkU3bzd4aVZV?=
 =?utf-8?B?OTE5YmI4bFFxcjE1YjhoQmxkN3IrWDI1ODhjbWVFOEExRldyZ3F5aWNWd1NV?=
 =?utf-8?Q?Oinu72Alb28TmIkDu1I9GftjM?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e713b7c7-895b-4ef2-a691-08de3c84692a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR01MB8289.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:20:53.5685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8/H+zUvxatQ5Ph05uihYT1SEgldmUDczpBbHTWsCB6uBanrzpTlFvIIKp+aJZMs7MCu60vboHG7i/LA/O9P4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6548

While the configurable system parameters allow controlling the SNIFF
mode parameters, they do not include the idle_timeout parameter
responsible for enabling SNIFF mode.

Add the idle_timeout parameter to allow controlling the idle timeout
of BR/EDR connections.

Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
---
 net/bluetooth/mgmt_config.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
index c4063d200c0a6..4ec6c008cb7e6 100644
--- a/net/bluetooth/mgmt_config.c
+++ b/net/bluetooth/mgmt_config.c
@@ -11,6 +11,12 @@
 #include "mgmt_util.h"
 #include "mgmt_config.h"
 
+#define HDEV_PARAM_U32(_param_name_) \
+	struct {\
+		struct mgmt_tlv_hdr entry; \
+		__le32 value; \
+	} __packed _param_name_
+
 #define HDEV_PARAM_U16(_param_name_) \
 	struct {\
 		struct mgmt_tlv_hdr entry; \
@@ -29,6 +35,12 @@
 		cpu_to_le16(hdev->_param_name_) \
 	}
 
+#define TLV_SET_U32(_param_code_, _param_name_) \
+	{ \
+		{ cpu_to_le32(_param_code_), sizeof(__u32) }, \
+		cpu_to_le32(hdev->_param_name_) \
+	}
+
 #define TLV_SET_U8(_param_code_, _param_name_) \
 	{ \
 		{ cpu_to_le16(_param_code_), sizeof(__u8) }, \
@@ -78,6 +90,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		HDEV_PARAM_U16(advmon_allowlist_duration);
 		HDEV_PARAM_U16(advmon_no_filter_duration);
 		HDEV_PARAM_U8(enable_advmon_interleave_scan);
+		HDEV_PARAM_U32(idle_timeout);
 	} __packed rp = {
 		TLV_SET_U16(0x0000, def_page_scan_type),
 		TLV_SET_U16(0x0001, def_page_scan_int),
@@ -111,6 +124,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		TLV_SET_U16(0x001d, advmon_allowlist_duration),
 		TLV_SET_U16(0x001e, advmon_no_filter_duration),
 		TLV_SET_U8(0x001f, enable_advmon_interleave_scan),
+		TLV_SET_U32(0x0020, idle_timeout),
 	};
 
 	bt_dev_dbg(hdev, "sock %p", sk);
@@ -122,6 +136,7 @@ int read_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 }
 
 #define TO_TLV(x)		((struct mgmt_tlv *)(x))
+#define TLV_GET_LE32(tlv)	le32_to_cpu(*((__le32 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_LE16(tlv)	le16_to_cpu(*((__le16 *)(TO_TLV(tlv)->value)))
 #define TLV_GET_U8(tlv)		(*((__u8 *)(TO_TLV(tlv)->value)))
 
@@ -191,6 +206,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x001f:
 			exp_type_len = sizeof(u8);
 			break;
+		case 0x0020:
+			exp_type_len = sizeof(u32);
+			break;
 		default:
 			exp_type_len = 0;
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
@@ -314,6 +332,9 @@ int set_def_system_config(struct sock *sk, struct hci_dev *hdev, void *data,
 		case 0x0001f:
 			hdev->enable_advmon_interleave_scan = TLV_GET_U8(buffer);
 			break;
+		case 0x00020:
+			hdev->idle_timeout = TLV_GET_LE32(buffer);
+			break;
 		default:
 			bt_dev_warn(hdev, "unsupported parameter %u", type);
 			break;
-- 
2.52.0

