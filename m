Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11023086.outbound.protection.outlook.com [40.93.196.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9803337107
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Dec 2025 09:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765876854; cv=fail; b=e6tNcD3gsbyPhPp1WWaKX4fy7TBiXb4yBmgJHwRZf7YnXM4NVsAS1WSlFHMSEyK9x7ommpBdaxZPiCk8o9j7PHe6XzJ5yv1V++xB+q1i739IopcHZsU1xUTqZyzRalvFVyztAiEtovKS82PXbKRQddcUTltrULkYI3lmh5wRyu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765876854; c=relaxed/simple;
	bh=PI3CZ5ZjHHcjX5O/Lipaf7btZfW8hefJT5/j5AW/boA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mL9kmDqAtegkQ0B4p0fn5AmlZ6EfaqwAj4kz0zOyz4PbXm7UND2Z2/NDwqEfNGRA/STTNCF9/FW225oSyBc8nTGWhw/6fTAomY009D9dsZDC5efE+gTMDteLStde86mTVjT1pUh7Brw+VVSo3SCJtZeLEFLxXiftVLMcx07tmi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=qhvgnPYL; arc=fail smtp.client-ip=40.93.196.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="qhvgnPYL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q9hgFFvsvlKeLP3VgJpWQRg2JOCZX2k24v3Gj6L4onKFy/yAmANbHMj0Qqu3Bz+59/kHOGMOIIdaZ1o3q0RbIqKIwxN4/5LYhCjtvdM6x0Tkt32pXHjQiXKQjPSAPLbm+I0v4B4napjs1kfi8UIW3KVWv6KYdCcnL+YLORlaxpOAItFqm9lOYKK022akRgrmZLI426zF08S+qRyFiH4HJTU3gcbjGoOfRFwXFX0rZjMEJMaNVlmr6p+ufuQehROl9D67g/N4EB/CodhQ3ldLLDMLfKxm1jcDgKObIXNMmlxmWnCT65Rpl1ZR0cP4jmsjbTcHaiM61zKJ/gHuvxIKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rr/5ZsGnx2nKJltOY2aHc+ElBZLTFXTG48mmusuZWM=;
 b=UdPqPOhlHmEWFMkA8YAP2vzBP0r0d0xuTC5eYJKLiOvfPNbHwF+LJzZdLEJRjoKErBMtcRI5sb99thI3AG8fzHJX2HVvKmjRXmNiAuPx/pP8fTeZQFtmi4CIjxsKOdKeKLU5v68iPvVkr719v9Gr9qJskjTq4ZBZ3xNPFwo3scOyjOPYPhj1CA9LSjtYoMmZ0qooS7Zuwz85P1hq0y/UQYxLbX1vI2WbzMVk+pPS0kYyoXZmuhuBUyDDcQj+2tyhw+iUfXsgLig4ibLyzN9ikPCSBqFevH7xiooRlqqhzKLggYSMaFh7pMvhFkjs5t0u/6VbrDjcQee/EJGITuCxuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rr/5ZsGnx2nKJltOY2aHc+ElBZLTFXTG48mmusuZWM=;
 b=qhvgnPYLU+jEAS6B+IXMrHmo+R5eRSpePRNdekzEQsiodwTnCuLMGHop8sOYH//+BRo3xI5f8sOA6GA0Nk0jh7O7+5xjlAxSmsbuMDwLcNA3nEALh35J0dnb15e3wF1fvkhZ0mDttbEMnb0822hyDQR3OE+RzlK5DX+GJv6MfwbA73R0cK/ViEbvATD4Ns4AStht38n0vM716H+rs15nC71gyeOg5SY7+WclMP69xU/EZYhW/JKTOE+zPwq2kKiEBCmTe8D2VdCt0OogCL2DwyT9NgOjoySUssvI8oNgyWTxDFZnZN3j9vdghvdZduDmPqMe+/iD0rKXZSlO/AubqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 BY3PR01MB6548.prod.exchangelabs.com (2603:10b6:a03:361::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.13; Tue, 16 Dec 2025 09:20:51 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 09:20:51 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH 2/3] Bluetooth: hci_conn: Set link_policy on incoming ACL connections
Date: Tue, 16 Dec 2025 10:20:10 +0100
Message-ID: <20251216092011.111208-3-ssorensen@roku.com>
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
X-MS-Office365-Filtering-Correlation-Id: 434d87c3-16aa-44ec-ffa1-08de3c8467c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OG5IeFltZFNMdkNqUXhCWXVhcW5pR3ZoYXZybC9aRUtWakxObHJUd0hUS2VM?=
 =?utf-8?B?dXFyT2t4NmR4dWlySnhYUUpwTm9mM2prV3hlallDam4xMzg4dmRCR0dLZk5O?=
 =?utf-8?B?cDFwdWFEV2YzME1zM3VIN0lkYlB1V2JMZHFFQ2szUk5wT0VEQ0dYRlZuTThV?=
 =?utf-8?B?RHlVejk3RGRobGpQUEZiU3lEODg2b1JGU3dib3FTNTlkWG10N1dMd1N3bDNx?=
 =?utf-8?B?TlY2d1I2RUlycVhGMTlJNzB2Q09xb3RoeTcxRFRlM0RwK0YzODlzK0trS2wv?=
 =?utf-8?B?ZmcwdEgxT1hHV2VPcWRVR1pTRTBkM0R3MG5kV1o1SituQjNuNGNjM1RBRTdq?=
 =?utf-8?B?aE9Sa1JSdGg3Q1JJTjlaQ1NNOTUrWFVlaTlSUUw4ODJOWktwaDdUcUw5TDJP?=
 =?utf-8?B?V2hMMURsb3pONjVBZnpCQWZla2hRQ0x2aFN6ekNFM2RuK2JQVzc1VXhMVlAw?=
 =?utf-8?B?bEV0dkZvU1JZWVJtOTNiNjZVSm5lUStoQjFyZVFpanViVGM4T0ZGbDcyM21T?=
 =?utf-8?B?T3hBb1h4bXNZVFRFVCtMZEY2SWIvZ00wNjlnREgrRjhaOWRSaGdRUVZlanVr?=
 =?utf-8?B?LzRKYmxrVjZBdlJ4R3RWVklYQmhaK2JpZE5abStYN2dCZmlWOUdDN0hGZC9h?=
 =?utf-8?B?UFJtQ0xEbmUvTUhjM25QWlQ1eWNYcnlNeXVUUGtjVndGOG9SazVGNGVxYnJ5?=
 =?utf-8?B?QkNPajVCUk9FditsL1EyLzRac2M1MUVocEQ2R1M3bEpycC91R2JVYmtHOUZa?=
 =?utf-8?B?NCtNS2oraVA5dDU5c01ZTEVFQVhML1VrK2ZpQkd6RDJHbVp3QUdzOGxQdmFn?=
 =?utf-8?B?djVyb3BoNVV1eHFKeW9Lb2gyME8zS1lBSFl5aFc4MzFjamQvMndFNVR6L05F?=
 =?utf-8?B?b216ZlA3NE5EVlpnbzJha01MZDF6V293VlNpUGdSbFNMMjlCb3MvajNYWGpV?=
 =?utf-8?B?bGFqNk9FZ2xaZHNxck1VRDVaSllONE5XelY3VEUzYlZZQWFsUjZPMjk1YnRt?=
 =?utf-8?B?aFpqTEQxYStCdTNxdlJqaldPYTVTUEV0Q2ZNdi9PeXU4L00xYzd4Q3VoM3o0?=
 =?utf-8?B?bFRCYXJBWHlBWmxrUHM2UTJwT2kxS2xsMTltZmp6VllZZ3RJNkp4QjN0blNk?=
 =?utf-8?B?dTdNcC9HNXp4WThieGxLWGJZenhGTFU0VVMxd3puT0N0VGdPbG1WTWVCcms5?=
 =?utf-8?B?cDh5VVdiL2RCT2VXbmxibHphYzVWbXBmQmk3QzF6cHQwSEowTFhKUGdWNzJ0?=
 =?utf-8?B?MHBxUTFtMXgxcnVRbVBvTyswaGwzMGZIeGk0emYyNEx4UVhLOE9jMGZqNE9r?=
 =?utf-8?B?REFhak1HRVc2VHBXcDZzeHRBWm1mMU1UWmUzam9OTVVTS1A0LytONFppclNx?=
 =?utf-8?B?TTIvRDNOeUZGdmdNeUs2TDZVVlg0djZIc2lpMjJNZFVFNVJEclNRSXJFMFJq?=
 =?utf-8?B?aWoxdFN4TkdiaTlRaFNMczBUNER0VFpkYmR5Ri8weExlTVJRSC9STzdicTFK?=
 =?utf-8?B?d0VMN1NCeUJJNlpXZjMrc0ZrYkhZclg1Z2d3Wk1RMjRaL3ZJYitNY1AyNSsr?=
 =?utf-8?B?ZFA4M3NweFR1QnREKzJKWU5BNzUvYitkd2pBSHovbVR4UndFY0sxNkFMS1NI?=
 =?utf-8?B?eHptL1o5ZlltNFd5QVZTejk4Q3pzU1RSeXpZaFV3UUN0QUpXNTVDVVdqZVZX?=
 =?utf-8?B?TDZ2SzJpWFdUVXpwM0RlOEtKYTdWcmh1QjNCUTAzU1N2UjJCUkVqY2VTdktZ?=
 =?utf-8?B?M1F2Y1lEMDhuVS9vdlFCUEgxY0RJM1ZaQzRkaXk0V1ZIcTRBdk9KZW5Mc0Za?=
 =?utf-8?B?Q1NtYzIrOWsySUZOTVkyamJDUHZuVHVGTGxOcm9NczhsdWpwNVowMG1idEE3?=
 =?utf-8?B?dlVuQmhIaUtrUXNDM0o1V3ZCemFQQWxVemR0SUdPM2JvM1plV0dVUUVybXdr?=
 =?utf-8?Q?snm60jm9r+FH12KGR7aMzHgf1zM9/8re?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDAxT0QyTG13QkczTHZlQlduUnIwakxBNEJXaVd4ekgzTXZEOXNDS3NJbEM4?=
 =?utf-8?B?ZzNLS2VNOHRROE51emVPY1NDQ0pCT1RrNUkyTkN2M1pwVmNNWWx5NWhyaEda?=
 =?utf-8?B?QktacThUREZHM004RldVdDIzUGlVQzJXZVlaYmtldGdkK3NvcVJZa2c5QnhW?=
 =?utf-8?B?Ry9ldWQ2bGtFQ01tOTlRUUtjZTUxSmtkVVk4KzZ1b0FwQ25xeHBBM2xhOXNs?=
 =?utf-8?B?eHFsOVFJSE9vcGxZaHZvNXROK1VOVGdwOW9SdFMvK2lCNm1sVitoRlhxNmk5?=
 =?utf-8?B?ZHEzZ2RsMDNnM0lyYzNtZHY3ZHkwalB6WDdoNFlEcVJ0RldBMXE2TnlwSFJk?=
 =?utf-8?B?TC9jTXhEN1R0eDhIZDRJa0dIU2xQMnVraTZPRGdCbGp0dDU3Y3MrWU96cmlP?=
 =?utf-8?B?NmtldllXTlZ6N0NyMkVndzNHS0tKQnpqNmZwVU9YTGVGWVRDUzZaOE85NHI5?=
 =?utf-8?B?Wk94QmlpZ0J2aXJmKzFyUTk5U2NkNXhzbGdjcWUwODZmOS9qSmpWQjRhS2ww?=
 =?utf-8?B?K0dud3lGWFBWUkFuSi9DUnRsWUN6R3ZzQXdkUUt5OHRHOWpVMkZOVW9ZYTlI?=
 =?utf-8?B?blFwNUNKVjNpcjFMaStCemdaOUNENVc2UkdaVXZjMUtUZ2JVQWtaZnZhcUtH?=
 =?utf-8?B?NmlLbnpKcENzR21saHdDNjRoL0lUcDUvdjRNVlFJY2xBazYxWjFHZzFvUC9m?=
 =?utf-8?B?VTRBZDloY0paT2NaVWxUNzFxTEtkTFE0NklYMTRqTmVRemJ4M0Qyam5hUnZw?=
 =?utf-8?B?R2k4TWNVRDc3NS9OOWx3bnRWTGo1d1NyU3JpaTRQeW8xZEtxYXZ1bE11Q09V?=
 =?utf-8?B?S2g2aXFsS0VUMlByWDQ4K3gvejhPVjZqc0dwbXEyalhoMHprTU8xa3EvQzFw?=
 =?utf-8?B?bmo0Y1RFMndGaEROZEtoT3ZUMlVvWkk3LzhzWFNYelcxWSsyN1hhdmtmSDkz?=
 =?utf-8?B?QmdpcFhMVFVWaEoyVWEvSFJyaVFzY2N4RHYzTjhPRjEzL01laTJQZWFDdm5D?=
 =?utf-8?B?WGRsdUNlRmRtVkcwaCtJalR3a2V1a2tpT0VGTGVRUXlPVEpYYWtONVdpNm5N?=
 =?utf-8?B?QWRtUzMxRkVBQ01BUWNzNGhFN0VSVFV5MUJnNnd3WXFVeHVxcEdCM3hkbnpD?=
 =?utf-8?B?enF1cDVBcGhPODlxVUY4MWdxSldZMG1kVi9nRStGVzlzOFd5L2NnMEZ2R3gz?=
 =?utf-8?B?T3lkVUM1RUNldEtkYmZVUW1hOUUwS1dWcnAxS3JYR3lzNHVmSDd1RHhqeVRw?=
 =?utf-8?B?WFRXdGZoVFY2ZzNld1lHcUp5TXNvclp3NG55ZE1ZLy9IZjFUZ1Q2Rlh2ajVq?=
 =?utf-8?B?cSt2bTdER1VMWEgvNG41WHFLS29SM2hXM0JCTTVuditSSDFFMVZqMzJsclNR?=
 =?utf-8?B?THdUTkxJRlNoRStjU3NheWxxQ1VWNkc4TGdyQ05ZeFJ0NHlrbWFuRi9aWkkx?=
 =?utf-8?B?aFVodkFpeXM2dkFZTmVDeEprOTd2MFdmUFdjaDlRVU5TcTZUbmhnRUlqdWxH?=
 =?utf-8?B?dS9ZMk52MnE4UHJGZTdwazRFYWpaRmlmeU9wMzBkU28rTUNtL1NwSTYvTzlj?=
 =?utf-8?B?dWU2SW5Tbm9ZMGxwcHpTSmFUM0w2bGRibUJJSHBkRVBSWDJLVHlwcGxSbWh1?=
 =?utf-8?B?d1kwUThsR2hKT0Y4OUR0UGRId3NhM2ZRV1hDSEFPYjg0UE1ybnlUMyt5RE9w?=
 =?utf-8?B?Y2Nnelo0WEpZdDZ0TGNtekRWcWFETTZXUVRKNm9UMUk0UkdiNy9oa1JDUndH?=
 =?utf-8?B?dDhyTFBQTEF1akd5Uzh0QUl5ZkJBV2tIZDFpYjIydnd5WEZSeHltMWxuWUhX?=
 =?utf-8?B?cys4MXVLeWM1OWliQ1Nwa3NGbTdxZzJJRXNLeHFaNWFIbklWbmtHbnVaNlNV?=
 =?utf-8?B?SmkzcG5PWmdSejBWUEsvSHl4VnpBQ3BVc0xWSWZWUEN2eTNvaS9QSWR1aVR2?=
 =?utf-8?B?Qy9JbWJDaWF4L290WGNFdmhyZWdRQm5ERkYwT2JCcmVXNzJPYUR2Wjhkd1JB?=
 =?utf-8?B?UFlTR1h3SkRyTmJsUlA0SnRXM0JIcDBPMDRMdFV2TGJXWUhiV250N0xrVmE5?=
 =?utf-8?B?eXYraXVuV3N5Um9iclZhL0F6WHhKVlFwVFpQVm85L25rYmxIUXhSYXlpeC9Q?=
 =?utf-8?Q?qGjQvjFsZSq52esNUINW+WoQF?=
X-OriginatorOrg: roku.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 434d87c3-16aa-44ec-ffa1-08de3c8467c3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR01MB8289.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 09:20:51.2108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hl33t5QTqNNbEM+Kp4pcGFfldZUWlfbCvdcRZto6QqTviGTaSjumVetrptlhkG1rzcW898X0Sp7xATFhZZpW2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR01MB6548

The connection link policy is only set when establishing an outgoing
ACL connection causing connection idle modes not to be available on
incoming connections. Move the setting of the link policy to the
creation of the connection so all ACL connection will use the link
policy set on the HCI device.

Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
---
 net/bluetooth/hci_conn.c | 1 +
 net/bluetooth/hci_sync.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 837038b5c5681..fe73528ce2bf0 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1002,6 +1002,7 @@ static struct hci_conn *__hci_conn_add(struct hci_dev *hdev, int type,
 	switch (type) {
 	case ACL_LINK:
 		conn->pkt_type = hdev->pkt_type & ACL_PTYPE_MASK;
+		conn->link_policy = hdev->link_policy;
 		conn->mtu = hdev->acl_mtu;
 		break;
 	case LE_LINK:
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a9f5b1a68356e..3b620c6eed70c 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6896,8 +6896,6 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 	conn->attempt++;
 
-	conn->link_policy = hdev->link_policy;
-
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.bdaddr, &conn->dst);
 	cp.pscan_rep_mode = 0x02;
-- 
2.52.0

