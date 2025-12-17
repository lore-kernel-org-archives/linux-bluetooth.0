Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020092.outbound.protection.outlook.com [52.101.61.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414751F30C3
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766026624; cv=fail; b=LK2EiKu38KWC2FLbn7VbNNVZMdjRWRUKDBteOKImAuadqe1xULanxdGAKUXZjLW+sdY3tKHfQ15B7pR1eR/VrUsDC0trs7PKT7sLxP0gFjql9glkhhRVGWNBhB2/ZzE3VOzVv9osklF1x+GMzH8PmubpqpIh/Rm3TU47lsa6u9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766026624; c=relaxed/simple;
	bh=TyTgu0s4bxVBWrzRmjbUUlDxYU681ZUkgVycrcAjSfc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jmmmYEzXeoWhPuo2i4O+C02VJDXL7zqwbqBcdTwf5bLFoxLTTukrEgPHNNIMhRgotzSwgmje0TcXG/Xk5zWcQg04E4O0tH3py/Wb2IJpJovdbZqpNF+VqcRRmwk8PaNuAqUJS1dy/v9Wzk7qYB50FUOtsV6ZUzeD9xN4kprzkA8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=flSu6sDK; arc=fail smtp.client-ip=52.101.61.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="flSu6sDK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmSa5J9YDrDdFaAxwko+MMqBDByl1h3WbWMoL+pRTi+JidZBjOVrMwm9LptgPRbDn1yDTBrRar8MKd6cA0JRWLuyjx3z0UAnAlFw9XawPZgDL/kzj8tyfd3wYBGiN0tXPouWYp4UG83ddDj0Hqu8xIyYvvxitjYlVDwEgTpg5AZomqIdPyTT2wem+IMVzViUEBQ6Lr7KXh5f4kkCGHwh6P/GKyIv8oyxNShAJWDOufGyeBSqkbxZPIOKZ+pbNd5sPNbAw5UhgY9xR5Q514UqiSBjU4R7rCwJEUkL1VXlDSLlTtiQOMdaWzP1OydGZRjE0CAJzYg2kPQQC94AA54p2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0zHOKARINlYggzir5+LiqqDGWiIcPSyVR1QY8igz7M=;
 b=nwt2oIk7AsZ9sH80dJLf7ilbT841alzibUuhw//hCyURMUZCq02CLmjCJyAxxysRJk3MOWNcolk582we9N6dcRVqoh+Sbfy16vPwy+Wx8jNxnUz5PCCqFIhdNG8/RIbxXT0ViLWLJgL3LczaQockEYQ88p7syBXaakMWbRT7zpvhKWF4HRfwJA8LGIQ5AJLnEYKicJoLdlRVseOjxZC1/EkzJgiu/wU4okrQcPVYVd46HQD/L3hwkiE2pvaBgIcn5Ns1xavPKbswszEv0/ZZ5vOtZpn5zrfnem0u88EYLyR2uZSSin1oMhxEd49Lcw/G6HBxGTTaCkRdi4Mihfsxbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f0zHOKARINlYggzir5+LiqqDGWiIcPSyVR1QY8igz7M=;
 b=flSu6sDK43vj0i3OVhF8RS23gdA5lftV6nvIEcCm4RZ0UGcYNr7CBgOR+X7WsdiLzDCWskDk1hbSI6EsBE39KhA3FplOy/T3SIYTe6ia1XpYTlCTiJ2JpcN3mZYbuFSsk+0MxwRbxHq5tUZ4g094pTQMhgunEASTwKCB+cLTazBAcITByL7hepqR5hzdtlR5uPwIHA+7FCS4/skErm9Acr2kNNcabHrJpMNcO2rx73BTv1KgGJfaGlNWLGUh1VrtbsggH8Mhy1yYxP7jL82YHJ2N1TX0cb9ioZkJmN9PK1nLeM725P0xVGOwRL3o4nxJAnaIQl+3LVfhivaXTFInzQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:21:23 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:21:23 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH 0/3] Bluetooth: Fixes for BR/EDR connection idle timeout configuration
Date: Wed, 17 Dec 2025 17:21:09 +0100
Message-ID: <20251217162112.444181-1-ssorensen@roku.com>
X-Mailer: git-send-email 2.52.0
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
X-MS-Office365-Filtering-Correlation-Id: 6b7ea182-6947-4b58-dc3d-08de3d8851e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TStGTzZpNENFQ1FyOFJkcFprRDZBZStYaktRZmc3SWxCYmRMcDVibXJML0VQ?=
 =?utf-8?B?eDZPc3hOb0kxMCtYVXhPdUcvRklPZ3BEOU9uRFRCdGpNWUoybmV6RjJKK2ZT?=
 =?utf-8?B?Q0MwdEMrYmFoekdmUXJ0VjVCQU5FbnFYQnZuTVJQR2tncElaT2JkWWlCTjcr?=
 =?utf-8?B?YytVVG0vN3VQd0hFLzRvMmFCb2hCaXlNMUVOaEY5V0VjczlLNUhXZXRKQVd3?=
 =?utf-8?B?TjBXYmJVeU95N1FXMVB1YmJoUlh2K1J6ZFRmOEJyTmorMFBNRGIrNzhuZnhF?=
 =?utf-8?B?Y2FkRjN6ajVQZ0dZb0tYcFFiU3lQa2h2ZFFtcU1oalhORGxHNDRZYmFNNzRs?=
 =?utf-8?B?dzB3NlFlVFN5eGRTdFlTTnRnUlAzaTVqT1ZOWncrRGZTcWhmTm5qY1QzeDZz?=
 =?utf-8?B?eW96U3JnaXBjUzJUeWpVLzRGMmY1R2RnMlhOQXN1SGdDdWp1ZmVHQlJ5b0hj?=
 =?utf-8?B?MFdwaUxrSHlTYjhkN1M1VHRLVldlTlgzNlhWa1o2cVRCNnpqZFZ4NmI3YWVM?=
 =?utf-8?B?bXhPNlk2eitZSExYdm1nZlhGRVBjelZOdFh4UWFxTnJ3bTVtZzU2OWwrcWR2?=
 =?utf-8?B?dGhsQlBXZ2wzYkdHWXhwWWtQSEgrdklPdVFFZWVLVVkrMHR2VVBjWG9YSW4r?=
 =?utf-8?B?VC82UWZqYnNIRFZlWGNHOGdSWlM2YTBSMVVrOW9JY3ZDK0hLdHp5cGdmaCtK?=
 =?utf-8?B?N0hWMVdjU1h1VHJPSittVTlCQVRaMnloUlpyb2VzNW9Kckk3YVJkVm1rMytq?=
 =?utf-8?B?Nm1scTZZWGJWa2VrREVnZ0l3QlgxUGQzQ0VPRVE1VHgvZGtwR3kwNVNZdWk5?=
 =?utf-8?B?RUhkTXBES2dUZWxNbDhrcUovendIN0QzcmFUTlVNVnl3cDMzVHFwK0w3dHdZ?=
 =?utf-8?B?djAzN2czZk05V21BY3VPUVoyMzBJbEp0VnVva2tGd0ppK0svUExhQUgrZm1l?=
 =?utf-8?B?K0E0YmpiaEZKbUY0UGRLREkrb0k5Z290K1VReC9rVzlMd2pKQjRaQnR6bXJS?=
 =?utf-8?B?NzNCQlo2Q3dMNjNWU1hqdzdTTzJwVml6UE42bjl3ZWdpYkFaMVdGcmMzVUQ4?=
 =?utf-8?B?Vks4RUI4Nm9ENjV1Q3pXK21GTitkdE4yaXZUT25jcjQxaU90N1RtUnFRK0I4?=
 =?utf-8?B?OFFmbVk5N0VZNXB4QnZtSHBHdHNTcTkzSjc0OUhjSzF5SDhVMjB0anZRZGdP?=
 =?utf-8?B?STFVTzY2SHozMmNkMllCelI0MlhiRE44Znc5Snc0MnRBaUV3VmcvbUtWVk82?=
 =?utf-8?B?MzRVQWVrQjVDTnpaL05abGw5VUs0YjNSckgvK2xVSVZNWmE3YUhJUy8yc1or?=
 =?utf-8?B?UmtaOEtpSEd4T0JZWkpVUkJVT1pRM20yVVZ0TWpmQ3F3bFVFZVRHajhBYXdm?=
 =?utf-8?B?cDR5amtxNDhTNU5vRUZRbk5yemR3eTlhZmF5Zk5rbzZEWGhCVmdHSDFHWTRw?=
 =?utf-8?B?U0RTTU5NSW05OFl6Z2pxMmpqVnk0Q2w3UDBraEwxcGdlanoycmNGbThWNFlQ?=
 =?utf-8?B?ekVBa2NWc3E0dEZrOXkvN3NFWW9uMTR2aklaVWlFeGRmZjBpZkN6R0V1Z2tN?=
 =?utf-8?B?UzhaTlhQMXl3SDdTQVdycG1uNnUrVnBBeTJvUGNlNGk0cng4V1RkeVpOOTM1?=
 =?utf-8?B?bDZsSUtyY041OHhxYkIzSlJpcEVIMGVFV3NXL1dtYmszNmxPUWtlYTF2RmQy?=
 =?utf-8?B?WC96NXZGb3pGYmpmM1pJWDFQTER2ZTNzaFV0YWVqKy9ydmhQS1hsaUhaeCs3?=
 =?utf-8?B?bTJPTjN6YmVmY0FIbVlwTDhVTEMzTXQyWC8yUS9BSmhSN0c0VlRaMEc1cFNz?=
 =?utf-8?B?azBjOVp0NDFMRnFIdkZ2U00rRWlxZVc3QnpzZnBnWERDbHFUaE5Sc2VqNXRU?=
 =?utf-8?B?dkp6TncvcXdnYlpIekZKcUtETjlEOUhQVENkSUZTcnBrSTdyYytWMFA3bmp5?=
 =?utf-8?Q?AHD4D717wz8Uia9kx6bGNHwMj7oiERes?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TTJyK2RRT0FPZzJZaUdWS3dLWi9pY3JaMDJUU0lGV0loWFJVWC9PVXJTTlNm?=
 =?utf-8?B?Q3NyTnloTVFOQWdVSUhOZ1VFblIycGN5QXQ3TXI3Qy9TYmxtMUZnZ08vL1Vw?=
 =?utf-8?B?cVRVdUlwdGxiNDcrR0hmeVhTN3Y0eTFUZEZ4S3NKRzdyUmFWWTdjY2Y2NVY4?=
 =?utf-8?B?VUIzQVA1YTBFZ2hQclFHWVZwd21jdlF2TXR5VGVjN1RlZ29oSkpTTkw0R3lK?=
 =?utf-8?B?aWtZRGd1RWh1N2pzSTR6bTFOWkttdDludW8zb0hOdG9EZC9aVS83c1VUVURE?=
 =?utf-8?B?ZjBxODR4dzBvUGVLNmtZU0VLU1ZQRXdjbTV0dGRLZWVrblY0OWNaVHU1bWVO?=
 =?utf-8?B?ajh3cW9qa0NYWEdtdXd0R1ZsdFJienhvalZJU3UvQWp4WHBaOUlHOHpnLzZr?=
 =?utf-8?B?YzRWQUVRN0o1V2Rvb1hBZ1dISFBLRDBxZDhTdUxDd2lIOWZWWTVjbnRQWG5k?=
 =?utf-8?B?eG14VmtJSHVjWjJPYmZsaVBVeFNvUEZtNng1SFNrQVFVZDRtR3RhNDBIejRz?=
 =?utf-8?B?Tm1HK1puTjB5RXQrb2lSTFMyN0tWM2tqcm9UMlB5dVBxeHcybEpROFpjL2sy?=
 =?utf-8?B?cjhkS2c4T2E4UGU4a3dlTVVxV05uZk5BT3R5cHBTMTF0VlRxNHNIdFY3Q3c1?=
 =?utf-8?B?OW5MYmp0aVhIcnJ3bEJQMXJLRElDbm1sb2tnRWxxNmFRdUdBK0ZSUjVXcnp2?=
 =?utf-8?B?VGp6RjY0RHFlMVZoeXBPb0ZtcEU4b2t6TFU5R3BYbHR0cjZJNmVDaEN1WGwz?=
 =?utf-8?B?eVZab1lmMHhvZHp3K0tQcXp5b3V1U3ZGV21DNGlrRGpxWG1nTHcweG01VVVm?=
 =?utf-8?B?WWdYV2xCMFU3enZQT0sreTg0OC9JVG9wSTlqa2N1VjdYRTNSSnNjTGZkTGlm?=
 =?utf-8?B?VVkvcC9ScXROTjROek10L205cS9TSkhGRXZ3L2F0RFFWaldhOG9Sc0orelEv?=
 =?utf-8?B?YVpzdEVzY3IxVVpXYTIxdFZtRGlVVDNhL2lvK0RxRytnUFZzeUVwVDB4ZVJp?=
 =?utf-8?B?NVFzZVZGMVIwckt6TGV5YjhXTHI3VWx4K1hwdGMrSExmMUxXNDNjRjlwbUVm?=
 =?utf-8?B?NGlXZEdVdllMZnNBNGZDTmVrNGNIdUNwRXVpUVllTTNCeVpqcE1lWHlRTG5Q?=
 =?utf-8?B?ZGpyVGtjQ1VSQnVrN29qNnFrQ0RXK3JEL3hUQytzZ3U0TVo2dlhSd1pvZVU0?=
 =?utf-8?B?emZZYng3NVBkc0Q1UVFnTTBJNi9rTHBibTRRR2dLKzFHR3dxR1k2TS83bmg5?=
 =?utf-8?B?WnJBbU5rUk4va1ZyYzhyMTFXMkR5endrSzhaVjhGTTR4TXZvUjN2ZjNzNXlP?=
 =?utf-8?B?bG1GaUdHc1dQbXEyMHNqWTlQWXdWSzh5WEJWVTdHcjF5K1ZXNkJHMHl3QmRv?=
 =?utf-8?B?MnVsMkVDVW9oZzlNbGZNNCtoM20wYm5Cd3JhYllWZURTZThEKzVXSG41bkJ5?=
 =?utf-8?B?UTVKeWZvcmNDcy8vWmM0U0s3TFIzaDdKc0hHb3pkeHQ2MXdhMGl2SUZaWVpq?=
 =?utf-8?B?eit2MTBuWWtWSWFncGhhVzZqS1RCd1B0THg5aStPRVZGcDdhbTVjTE9PRjF5?=
 =?utf-8?B?SUFxbENod2NkTDdhN3lXWUlLT09XOFJ6YmJqVEJDajZZRmVvUW0xMkNlL0xC?=
 =?utf-8?B?NGI3VDhYSUp2dXhnaWlTU2hBUUNSWlREdFRzZ2toZ3dYaEgwbTRyY0p6UTc3?=
 =?utf-8?B?MnhsdkN2QXhrUEUwN0JKMHJOMG4vZXJub1REUDQ3aUR5a2FHeDNMUUtVbUJG?=
 =?utf-8?B?ME5WZE9ITzI3VWtla3cwUzhqSXpxVittUGRBdE9sMm84WVBJWmdjdW9uN2VB?=
 =?utf-8?B?S3JlUzNKdktHYjdjaGZOMzc4YmxoZ2xQOU9RYVFxZGdjYWNac01rY2xLenA0?=
 =?utf-8?B?YVhIQ3FBR2VXajVCZTVWNTFSVU42UVFDMk9RM1c0T2EyVVVpNTlxalJBSk1H?=
 =?utf-8?B?UW9LUFVzam1BcUNReDg2NmhLRnlYSGhycWRtWFZJaFhsdkVYWmNRWUNvRkQw?=
 =?utf-8?B?czZxdEtCSUlwYitGR3hTbjlMVEprR09GcGVpY1NjZDNBTmdUeGE0cFRidnBS?=
 =?utf-8?B?RXlMaldsRmI5TlhIWnF3WTU0STlndUVFY2FyYmNhMnhRWGY2NzMyd1g2d0Vm?=
 =?utf-8?Q?W3aa9V7TH5VaL3hfhqph6kpom?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7ea182-6947-4b58-dc3d-08de3d8851e4
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:21:23.5005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSZeZdW8W09hEO5kR6eq5JdDMVlR3+j/0BwNZMCZJ/yWkGIdGwCDcqXv0mpm33ZqT7w+ZjwokP/ODvAGdc7oEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091

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

Changes in v2:
 - Fix type of parameter code in TLV

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

