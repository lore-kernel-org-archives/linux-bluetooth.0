Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023086.outbound.protection.outlook.com [40.93.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD530DD2F
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 09:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876852; cv=fail; b=tkh0+EfEZFaBrzrpdyryTrmVjJuHFS9avz9PUz7YK6nHcZtEBFaJmyKn5eplacKWOvAkfU4sKLXEmKgExugqjj5WIMv3kfyxt81sdT7X7HdYWylHst1oq03TloI8NnxwlwKbro6Gfc0PPxRF02AiDERS0axq7fvx2nGPylIFucY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876852; c=relaxed/simple;
	bh=AyYp3SDb2H4s3lbBVtjErwTCEmak9N0qTKKUg94EG9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aPN8r5xnizGN18+lr7/7rfVws6+9WQLLlwGIosGdkaFLe6cRYgEkUhObCoLP0nCSniAke2HUzitBvdUcdhjZhnqiwU+wtKGsiEfIb+/AJbX1jP5fb8OKtGGd8CbyCs9VHLnYGDJDNJTYhBS/zabl0gpbdJfSVm7ps3cntyHKvn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=dKHiY1WS; arc=fail smtp.client-ip=40.93.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="dKHiY1WS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHNRi7KkAR7P3QOmCzCXnRy/LZ9s/wfMh4fiNMbnbbYM4NhRjB1Cj3AXrwR8hWxHvLGolztNebDFST13ut0HllZ1WGuR3vJGcFioIN86Q7X/HKxRh4W6Rx0hjRr41owUNHC75nX8aBgdcUFegdmn6cSC+W+Wjn0q8pueBKTfydJKGhyqwKf/grsXoAOUNZ0CHh+4Kb8I0343DqIoP1WD0Bn9AEw43Gqd4f5SFlFCgjMsOHjf+JrYnnFRSeIMt2UdfJCc0XFMnGx3nYeD3AY4/dhBdHguFICaXk6luThZ1pgyqTq0+2IL/HgBjA2QmVaHZHRLWijKxe9yVHHUIvMyvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy/m4MRazMyvAU5td8bXl3/LIXpRq5mQ/8J9zTgnBRo=;
 b=nAevEDSAsSe6wYotog2I0xSEdDka6qRHdM205NKZFqUBFcUA7KvTMzamSlRJlQFBT8QyhGH7D7TLECM4rUbUYdGseLDj3J1UeR77m8ijw2GPfksTsceQ1iKQkhTnlm2oTjljXSV8opovUGQpY0w1lQAwPZEofcwBQd3D0bJEazlyxHoFiMLPi0BDyBGxYJUqPsMTw4yvmGBWEr6UqtT6/gEm+TGi/D5XtAUVNDsnPb8WGrMLV2BMbleTHHcuE1NDxIRqv5Hd+/463S9jVGg0hoxSea0+5UUEjFCEX++wC/mAUGhwR6H/iNq/7TAYDkiacouZ/3WNPrswpOqsCUA9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy/m4MRazMyvAU5td8bXl3/LIXpRq5mQ/8J9zTgnBRo=;
 b=dKHiY1WSP661oHMlgbb2KFt2cKzMioDZ0YWHMjjpODcQaAIe1dAtkW6PY5qwDPt5BR1kez55xB1o9ZzC8ZvRk02PQUXXYfw2AYddIQRIMtXQQlD57eAdhTz/FNarCEd63y34Fk5R+Ni1SgyR2ka8VF7vZFUMpIOUg0EY0m3isCSdMreSGDyS4TYV0Uric9dNNnO8FVGsSWTN7eHI2XTzn7k9ZuLAygTePR1s1/9SlvAuwXErpTFyBhseQsNwrRX43AYNfCBk+tD5MT58MM8N1VV05ToFsGHv6wgkpsIj7NaPuMzvA0kMBIx/QPNlNjUnbSQTk7UqmNWt8gk/d321vw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 BY3PR01MB6548.prod.exchangelabs.com (2603:10b6:a03:361::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 09:20:49 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 09:20:48 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH 1/3] Bluetooth: hci_conn: use mod_delayed_work for active mode timeout
Date: Tue, 16 Dec 2025 10:20:09 +0100
Message-ID: <20251216092011.111208-2-ssorensen@roku.com>
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
X-MS-Office365-Filtering-Correlation-Id: cce92a50-f3c6-4426-9e4b-08de3c84663d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1FmbituaDgwSVJkYlRYb3JhMzUwNGRxNFU5dmNFQ21GKzNvczQwWVBtVENJ?=
 =?utf-8?B?d05Oc0hpQWRyQVZ0YzFVL1lKZUhxY3dMZHpKNUdydGU5UTZucTFvRVJaRk13?=
 =?utf-8?B?cWU0dXBiVTFBaUxubmg2ZExLVURxMFVhNGJtKzdTZW1rSjN4RjlrYy82amdt?=
 =?utf-8?B?RU9scVVkSG5icXcvUC81RmY1WGVQc2hIa1JNd2xpYys0ODVieHpmN3Y5dVZH?=
 =?utf-8?B?T2pPU0ZTdGFtZ0hHTEc1SE93VnltbnQ1VnNMeEtzTklCc3lPQjV4cGg2SHNT?=
 =?utf-8?B?UUttME9MSlZMOHV0aXBKb3ZyYmwvanFVOWRYbzFtNlpCeGl1YlN6NHhGWVEx?=
 =?utf-8?B?aWRBMjZVMUpyVTJsbjBqOWMvQWZzT2Q1c3lLVE5salVWZHYxS2J3T2JMdGtl?=
 =?utf-8?B?YzM3eHluSURYck1GNStoSXpWYTY2UkhDM2N2Q1Y0Z0RzZ2MzWjRZb1VvVnNO?=
 =?utf-8?B?TG5zUCtWUGRzUWl1S2dhQUVCL00vdzdZSThDMGQ0a3JmNnpRZ1BwcTFBbWpx?=
 =?utf-8?B?elFqcm52VHNYK0pNVWREZnUrTWJKczJ6SVovWEoxc2lMclZHc2pkUXJsLzZG?=
 =?utf-8?B?dk8wTzNFaHhzRGxYTkxENUJ6bWNGOUdyOVJUQ2lkQU1JQVhTTGRiaG1ZVXp4?=
 =?utf-8?B?TVd1ejA1WVlGRWQ1U2pIQ2JoOFRRVnFtSkFMcmptRWd6dkowWlpQTGM5emdj?=
 =?utf-8?B?TXBPV1c4NmEzRjMyTHNwUkdGSjZYeWZjSUNWTXdUUGp6Z09LTTFRS0lBYk9m?=
 =?utf-8?B?UzdGNnBnUnZqNkpjWW9ZdU96SnFRZCt4dnFDVFlybXNCVmV0STVmd3FBTVYr?=
 =?utf-8?B?VGwvai9QRmFTblZ3UjRoSVNaK1ZrMDVFYjJpSmxUS29jbDJJaWxFd1EwVDNr?=
 =?utf-8?B?OFhZUDNJSWFPckdpY0VVc1hSNUp5UlNKYXEvSmdkRHFJZmlxZmdzVzZCOWlX?=
 =?utf-8?B?ak5kYm1ubW14QVRHWlJ0ZWFTQStuREo3U3U3RDZVRFNhRzVTblVQcWFtS2Uy?=
 =?utf-8?B?cHBQa3Y2T1lFTldUU1U4c2ZTSU1uVG4yUGMrdWtLUmlUdGZ2bG5qT1NmM0dT?=
 =?utf-8?B?SVdtY2c3M1h4OFlZRDl6ZDhEblk1MitNM09mR2lCcmN6cjlCTnVsMUR1N0dL?=
 =?utf-8?B?aWR3Zk9pQWtjY1ZjeElhbE5IVGkvWG9sSG96Y0llN3FMQWtCUUFIbjN1bjNK?=
 =?utf-8?B?ZkE4eVExVFpVS3BkWndQZ3VUM0xJMGQwTDg2WDB6bnVIcHh2Q2dmbDVXR1dK?=
 =?utf-8?B?SkNVVUVaSjNCOExsUlRhOHRHR202UnUzbFk4ZTNIYVVRbzUzTmMyQTdNSnhx?=
 =?utf-8?B?QmJsZzY2dVBvR3UrOXBSVFNrdFNIcXBhVG9WRmtKOHg1T1AySGwyelBDNXpU?=
 =?utf-8?B?UUVWbHRVSEpqTGF3UlVoQXZhbXE1R0JiZmRFWHRrcnczcGtYOVdSbHdpbHov?=
 =?utf-8?B?QXlLZWM5ZjA0ZW9ZSGF5YzN4VG1JbmZLV1VPeU9ob1JVTlFXUno3bXRDR2pY?=
 =?utf-8?B?YVE0M2NCYnZTMjlKSGZ3L3dTVnBrTkpoQkl4K0c3d2pjNHc0ekNpN1lXaUdN?=
 =?utf-8?B?WHI5MG9hTjJlakZNMVBSelhROUxoRHp2M0E3NHVMcmVhUnNicnFpR004dEdi?=
 =?utf-8?B?WEQ5TU9MMzZNT0JkMGZidFJFSW8vSFNURUFyYjVoRXd5R01TeHpFTmxFeVpO?=
 =?utf-8?B?Nk54OVVPOTBDNWpFcTB2d1lmSlJVMTZmMm1TR0ZiVjdkZTVreTlNcmhqR08x?=
 =?utf-8?B?UlN0NjM2N3BmL2Z6Z1NWd2ozc2lHVS90SW1ydXhYQXpnV1c0cXNWL1FrQkxI?=
 =?utf-8?B?bmVvNWgyOXd5WHVRd1UrbE9XZ1p1cSswWEZ5K1hLbEE0b3NHWFloMXRKNitu?=
 =?utf-8?B?RHZ2QSs1U1NoMTIvTUYzZ2pUaWpMbE5BTzdJZ0pYWnFySXhTd3Z6eXdGakVs?=
 =?utf-8?Q?8N9UgqkIxqyj5irtKdupfpgiXMgxEiV1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzBRVm5oWS9jelplb0R1ZVdqV0phclAzU1B4dW1QZFB4MmdNcTlxVVozQUpH?=
 =?utf-8?B?cVhPdDlMZ2txbEJTZFdFTlBWajIrWk1OQmRmWHRWTElaZ2RGdjBwU21TUisw?=
 =?utf-8?B?NVB4UDRmSHpydHpFYVZ1VDNWUXZ4MmFEbHBaUGJEODI2eTVFTFRKc1hEbUwy?=
 =?utf-8?B?UlB0OVVGYm5QTyt3NFZ6VGVsWEk0eWU2aG95M3B5anc3emc5MXk2bXlMRjNv?=
 =?utf-8?B?dU11V2VTQmFlVXAvZ2VXdk5keUZvNjlvZmRrUVFLMjBKS2hwZ3h1YUs0c21s?=
 =?utf-8?B?cDhpa3R2YUtLMUoyNTBhZDUrSWNhNjZUalY5RndQMS9udEJkdnZSblJtMFc2?=
 =?utf-8?B?aW5FZ2M4aFhrUWZjZjB5WWg3bktWb0lnaUFVMFQ1dU5EbVNTZDZGR2VhRVY4?=
 =?utf-8?B?Qm51dzFtNEJ1RHJUZnFlRGNpTkdlTWpuREhMMWFIbXdHTFZpZjl4TDJiY0ox?=
 =?utf-8?B?YVhBNldrTXpHMklrNUxCamJrOG12emk3emRpRzQ0ZnpXc0laNjU5cUpNZlRj?=
 =?utf-8?B?RVdsWkRNUEFIWlJERU14UXNKQ1lHVERGYXJUbE9WSUpPUlRuK3F2dUMrRlB1?=
 =?utf-8?B?N3VoMm0wZ0lrK3ZGVGFhaXpZZzNXaWNyRVBsNDF1ME9WK0RrQkhJd2FGZzRx?=
 =?utf-8?B?bVRDVWtHWTFwamUrVTMxbjhPYjF3SkxjTm4xQUtZUFZDZDZHbS9acitUNGp5?=
 =?utf-8?B?TmgvcUpEYlB2NWt0MnJ6Ymd3QzNuWmxwREd2aktwdDBva1lkdk91RlhiU3lX?=
 =?utf-8?B?Mk5xMjF1VXRXcFUraWpKSzR2RmtraG9CeGlvb0s0QTdEQ3VnOE5kUkVld1RN?=
 =?utf-8?B?ZE1wbFYyUVRNWnNtc1p1WS85TkdlbTUzc0ZmekVTanFIT0FlWFFiWFBCTGhR?=
 =?utf-8?B?bFMvQjd1dXY0a1ZQZW40aExGeFlNVklKcGJycE43WmpCM3hnS2xEazdYeVpM?=
 =?utf-8?B?eTNWZERtL0hhMzFVZVNDOTBUUGRNcG54dnJucCs5OUtLTEZEU0FmS3NxZEVi?=
 =?utf-8?B?Z0tOeDJhR3FwNnJXbnVqdnVzekxGYTdSNFJFMktGNUNNM2gyRzljVG81Y0hR?=
 =?utf-8?B?SzFzZDlTZDdqa0J6aUxzY3VJM1RiTlRjR0lJeiszT2FRZm1yVHNEdXdKaU1a?=
 =?utf-8?B?QkY1UkFjZFQ4ODhwMmJnSlRpVGVILzZMNnZxaFJEemVTMG9mM2ZaMGZ1ajZi?=
 =?utf-8?B?K1FQTEUzcEswUEkzQzVibzRNdmVVR1Azd09UalJ0cUdtTVVTNjdMM0JiTmpQ?=
 =?utf-8?B?Yk5JbnFSUktUUTFKT1NqRHNGMDdPM21lRFJNeThIM09zM0RKSWZtOGM1eHc0?=
 =?utf-8?B?WW9wWFd1dEM3cnZncTQyUFRoZEZCZTM5ckNzME0xbnRpNVJXZFB5cmxQUzZN?=
 =?utf-8?B?YmZnMVB0aExkN2RsQVQ0Nk9VbG9nR3p5Y1FDMlFhVElDKzNIam5CeHN4M1FT?=
 =?utf-8?B?OXVHL0k0YVBUbjl5S3BkUk1uWDVHVnplZ0hOTnh0aTQ0STZLQ0ExSG1MOGVB?=
 =?utf-8?B?Rlg1M2JqOGZGWUx5N0JML0JMRnBxOEFaTHRRSVNOaGEyVUk5V296aUNwbG5l?=
 =?utf-8?B?azVkalpFZTc4Ym5oQXlGbmhTL0pESXJMdGxtb2lGOHhzSU9jK2lPQXpabHJn?=
 =?utf-8?B?WlhyV1VJcHZuRXJMUDFwM2dUcjI1QzRBNVRQRTlnMVc0T3hQVXJHL3pMYnlV?=
 =?utf-8?B?eExLUkdHYzRiN2tBMGVFdGZXbkFXMGZiOURBZUk1VW1KVGNWbVdVNU5SZVlH?=
 =?utf-8?B?dlU1UTZNcmlEMDgxaVJMb1lUejRRUUZYdk9QRnNMdURoTHdVWlNHY3ZBSnhI?=
 =?utf-8?B?QjJ4bGZUWm9CTUtyZlpQZ3hNRHluQnZ3d3ROam1XbzJBdjl0Z0hLYVFNYWY5?=
 =?utf-8?B?SzNOVU9OSmI2K1FjNmNKTUF5QXBvV29YbUprVmFkelJjd1pqQmRJVFl3bTRD?=
 =?utf-8?B?WnBuQkhBVktPQWpWRlVxY3RIN1pPSGxBTHVhUUx4VjA0MGFyU1U2Y2Rhb0Y3?=
 =?utf-8?B?SHE1VlV6TmZvOUtCREVwR3k2MnB1N1RlMDRoUG0xdXRHYVFlQ0pjVk53dEVB?=
 =?utf-8?B?Mlh4Ym1NSnJWNUJocGxpTjdScUhGKzdBOWxPbE03NkdIcmJtZEMyQkZRdDd2?=
 =?utf-8?Q?VIRgchIAE4VmBKZowDVPpu1a8?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce92a50-f3c6-4426-9e4b-08de3c84663d
X-MS-Exchange-CrossTenant-AuthSource: CYYPR01MB8289.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:20:48.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IVPLIddr9JuysRHSdK94uG96b00/FWCR57SP2OFk2Sxsp8OqXEdURXYPDSVnpycTTaiekmuPCyXbMshSHEm9gQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6548

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

