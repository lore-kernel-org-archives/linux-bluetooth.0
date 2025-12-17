Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11021114.outbound.protection.outlook.com [52.101.62.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD2620311
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 07:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766043381; cv=fail; b=bpO4Zm+txBrgUV4S2vlwC1cRV+VA7k/zyaCk8HghbsEOftd66VZGdv9y9sIw0abXdnQo975DqJsRUfrIuGEaGV+N7d3QibJJSrX3OhBA3pQeDGHtZs8JEoN+I++arqiyhJVfyVa+mGOYiMSDeO/3mbPmQUNyut9xmp+AkYOdlkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766043381; c=relaxed/simple;
	bh=PI3CZ5ZjHHcjX5O/Lipaf7btZfW8hefJT5/j5AW/boA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AQwyxaqrwSYmP/F92u988etOJJS0J+/6di3i1Nx8AINTNLBbOQwi/3OuKAOAwg0wa/4bZZCz/Z4YBmPN+nYqvM5IPJoqFd5V6WQIQ/2/Oy5mWLuZFqy/Cuju00p5h9wr0vtqrfPmmn1zoKo/PXzOQIZ0xOze9Z2I9Y+y0hooe30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com; spf=pass smtp.mailfrom=roku.com; dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b=uYjLyYPM; arc=fail smtp.client-ip=52.101.62.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=roku.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=roku.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=roku.com header.i=@roku.com header.b="uYjLyYPM"
Received: from CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) by
 SA1PR01MB8303.prod.exchangelabs.com (2603:10b6:806:389::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Thu, 18 Dec 2025 03:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KHdLqP5y/2T2cTdw06kqrRlYyNrmNWsGMgW9UaXaNwji06qv8TVMQje42/UNnT3slJQ+e5fxG2f3fwSUEUtglxRY3TiWoKbPK+MACAWjPfugREw+CYKxC2eRDxJej/DPGbpKdlFIuWAp2PQzhtJxsHW/TTjlsnOKgy2LgpHkLGCBOUEyIPoYQqk6KoZ6R3QWKPok7yJwK5A/zUZUzKyMhFqAOn9GNqDP0YfVLEBcScmfgQ6JzGrqB1ueWC4vyJQxHm1kSYP692lTqjvKOc5AxzBMOf1p1iICm/tuoMwQ1N1lDRowWsI/wRjc28isLJlhd7R5sK0yA4NvA4N6UKmrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rr/5ZsGnx2nKJltOY2aHc+ElBZLTFXTG48mmusuZWM=;
 b=qc5XRmI6En0yKQZqiPsMqribX+Yut0FppITS3Bwb0feKH16PKRXxXdYqWIYC8z7ltgMdr1a7o8Ce5sKW1vAxZ4pf1ufy9PbBNsT+aqWXISd04QU8Bt18sG7/yqRjSkiKpgQSqAywD8fTrl3jUAbsh/n/L3HBUb0ZDQYkl0iL5372K4slagkXovT6R15uKnMKOjK2cXPlUhJmWk2K56m/8VnTsn6B4UV3s0NyqHWC+cUWENZNbLROvRHx0eKyWOC8kgbTNk9MkV2lhbJsWNb2jUIWS4QBnMEOcjTuXN31uIn2K03RapD+BfCTaR7Kn1M2voHbtWECBA+NI1mCbP7Ktg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=roku.com; dmarc=pass action=none header.from=roku.com;
 dkim=pass header.d=roku.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=roku.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rr/5ZsGnx2nKJltOY2aHc+ElBZLTFXTG48mmusuZWM=;
 b=uYjLyYPMkAyKyv3rgMsId9N7h6XgVX3EMhdBnGlDJjZQAuQkrNcfoWRTIuDVNP0xzIy44Fzx30GLpCUMkoc74NQH8FAkgejKHY8i4m7HmSprwsMvXekqSwSQJXF7GPnkk43+MKxIKGoTwxWl5Vq5DSvDg4pVcrgO6wMdfXi1PNL09B6/AZHXBoC1w+kGryUIMgmQOi7MYuGc7795NhKegnUkmWWSpdsa57bF9Qi2Vsp0hZKSbi2QIkvcI60teFE0mqW0TXgoiXJHB0mSIq/nChh3AZSdVQU8R+4YxhtTtg2AKP/ftE8rnNkRT9LBpjGgHgFxqHx35PzOJ3gyuWD8vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=roku.com;
Received: from SJ2PR01MB8282.prod.exchangelabs.com (2603:10b6:a03:540::13) by
 CH0PR01MB7091.prod.exchangelabs.com (2603:10b6:610:f1::8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6; Wed, 17 Dec 2025 16:21:27 +0000
Received: from SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f]) by SJ2PR01MB8282.prod.exchangelabs.com
 ([fe80::1b0b:87da:f914:dd1f%7]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 16:21:27 +0000
From: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <ssorensen@roku.com>
Subject: [PATCH v2 2/3] Bluetooth: hci_conn: Set link_policy on incoming ACL connections
Date: Wed, 17 Dec 2025 17:21:11 +0100
Message-ID: <20251217162112.444181-3-ssorensen@roku.com>
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
X-MS-TrafficTypeDiagnostic:
	SJ2PR01MB8282:EE_|CH0PR01MB7091:EE_|SA1PR01MB8303:EE_
X-MS-Office365-Filtering-Correlation-Id: babbe9dd-c325-41e1-3c82-08de3d88546a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WExJN04xU1E1bENLV015THczNnFIUkFBQnpPV1lzUi9jQ29WRUJyWU5Xcmx4?=
 =?utf-8?B?dVo1UGRyT3R3UzZaYnIrWVZRTCt1WTlWWEo3dFREdG9WVnArOERZT3JkbjF0?=
 =?utf-8?B?azZiSnNUMUZ0Vmo1RjZOalVrWk5WVXFsVTJkL0lmTzVCd1ZQNGJUUjJxdGE1?=
 =?utf-8?B?ZmZMd2VaOUdzazN1cWxuVWw1Ym84UXVqMUFielNZV2d6TzlWRFFVbTRiRXJh?=
 =?utf-8?B?REcraGYwVVQ5cXBSejVFSGhBSmh3Y09CUEwxNCtHZ3EwNXBjYWh6dm41VXFY?=
 =?utf-8?B?ZCs5Rnl4U01McjJlOUxTcGQ3QzZxRHNocTBMcWRZV09VT3dUVnhDdzFPbzJG?=
 =?utf-8?B?RDdoVDRSRTljWCtDZDFOZWRtNXUvSW5uZmgxMXU4aHRoQmRyc1ByZ3VvakVW?=
 =?utf-8?B?bWlxaG5jNUtqTGtLYU1CYUZOV1pzdFJ5TzZXNzlJYm8vZnlhU28veGswaWkx?=
 =?utf-8?B?TUhHWVJmQWtxR1hJSEpSdkd0US9rR0JEN2JoSmw1ZWRNSktnMXZxRjUrUGdx?=
 =?utf-8?B?TGlqMDZaQ3dPZ2pkNWxaVCtmMGhZbnZ0dWl6elNzSWNxRUJHZ2JOei9xdG1v?=
 =?utf-8?B?dlMwN3NpMERraE9oQjdDanNkNk01a0E2NnBrYVdkTmN3Mmsxc0E0RlVhMFdo?=
 =?utf-8?B?S1c0U05xaERDTU4xZ1Yzb1NIWVU0YmZsRnFCQ1dvTkZQV3Raa1VBT3Z1b3Ry?=
 =?utf-8?B?RVpEY0xQaTBNVk1XYVgzNEYzQ05waklka0ZiODhkMGVmYzduQlpmOFN2UlBY?=
 =?utf-8?B?NVBpeXN1SHpDUzB0R0cvUWMzeG9UVFFmOXJqQndnUHZRcmlmNEhtQmdpNjJ1?=
 =?utf-8?B?bmNGVU14MmdKclhjOVAxY1hWcStGdTcxeVBxVDhLb2RLVHE5a0I2MEIrZCth?=
 =?utf-8?B?SWo1dCs0Q0Q0SGVJRUZxNHNXSTcybnJ6QzJPK3B4bFdFY3gzRTNmNFlSTEYx?=
 =?utf-8?B?U09XdzNqRVF2MGxuQXNtTDMvVzBtd1BqdkVjbVRzQnBkbUo4emRkQVowbmNw?=
 =?utf-8?B?L09BMHZjNXRueklNcGRkVGw1eWsrVEZWb01QdmxzcVgzaTdBMnk3TXE3d3p0?=
 =?utf-8?B?b0FhM0tqZTIyMVV2TnI3amwyK3pyMm5BN0gzUE9XWTVaQWhKMUN3T2JiRTB4?=
 =?utf-8?B?WVlUWE96TjRGYkh3U015Z2djZzcyWFJ5RnRsSUJDREpMN05MVDgyWU90Z3JH?=
 =?utf-8?B?MG5pb2JYUG5ocGw3d3pDblFiVi9McTBLOVlGWnh1MFBTcFJyRCtyV3RwZDZN?=
 =?utf-8?B?SXkwckZIWDBuaW9BaVhTYktPTFNZU2tYL3BLU3ZRMklFQ0V5ZDdzMjNFbnlS?=
 =?utf-8?B?UXFjSTdqSUFTc1NDY0IzK2JubDI1R29TUHJhSG9mUHhGSEI4ZGk1KytLWXUr?=
 =?utf-8?B?U1VBS3hWZXRZSVhRZDU3MnZWeU1DVlB2b0dxbWpBY25uTW1FNU40VWswcjQv?=
 =?utf-8?B?elAvZUQ0c1VqdUx1bEtpVzVrNkFuS0MyKzEzZVptSjNDUjhuMU1MT1l4TzZ5?=
 =?utf-8?B?SVJUT3d3TUprZDRWalk5RjdhbVpNQlFaT2JKMSt5Qng2WUhtcjFUbXFYaGpO?=
 =?utf-8?B?ZFFZbEkrbm0rZWNDV09zWjdsdHJOeDlSNFczcGlDWWNldlZsZ1hiNlB0QXZM?=
 =?utf-8?B?djRFejY5SFY0ZGtHcWpHc2NsQUwrdVh2OWMwQUdaZnVpQXNKZEd5dFBzQ20w?=
 =?utf-8?B?aTdmWU52bTBjMzRyR1ZGbm1PSVlRb2lMOUZ0cXYwbUpqZm5ZU2hVSlluRXZx?=
 =?utf-8?B?eEpZQTUzR3hkcWNZbUFIM2ladm1WVHp6cWNsdWF6Y01xTmQ4YXdCQ0RMVldX?=
 =?utf-8?B?Rk92eG5ySUdRdDBBQ2hhakM1QzRDUG1uaEVzZ2tTd2VwMWs5Y1dyZTMrTjRa?=
 =?utf-8?B?SjRJQysvVmtVeTVmc3drNzVYR09OT1h6ZzFKakNUaUFKam1IODF3UnZoY0Vi?=
 =?utf-8?Q?cghRrr33iE/e+fEg4rktMHNu38vYz/sT?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR01MB8282.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?THFxWFI3M2V6Tk9hbXc5N2lvVUhGMTE5NjN0YmQrWUVNK2pET2pOc3RjcC9l?=
 =?utf-8?B?Z3pFbWE4NzA3YkZ4VGc4bkowZ3lzenVYTnFsbWVYU3NZU0xXSXNWNFZrak9t?=
 =?utf-8?B?cWJhWEtEcG8veThIK3grR0x1OXN0cHY2UGE3ZmJ3dVBuKyswL09kTlA1OVN6?=
 =?utf-8?B?cmw0QmVaMWxLV3ZuaW1Bb3ArSjFlWUp4emtySmlUOEpZTDl4Rk5JTkhOTXhr?=
 =?utf-8?B?OW1KMnArUVZ3Um1MNGRYNHMvUW54RHR4MkdQWWZrek1NekFUVlBIOENBbzcy?=
 =?utf-8?B?ckRFbmllR050VEhlT05Idm9wK1ZCUmkwaXRuQUZqUWp3QmswMmhRQm1rbEQv?=
 =?utf-8?B?Nm0va0hmVlMvMXdaSEhNbk5hYTByQ2xrcHFsdDk4Wkc0WUNTRGU1Qm9aN3Zt?=
 =?utf-8?B?L1hLenAvOVRzVlVIR2ZzZkhGUjRwUURvMis3eGp0elR0WEN6aVdRbmhrTGJG?=
 =?utf-8?B?cWdsNlZWdXF3ZmZhRzMwUjNWVXRsY1lmUU9DUGd4amwreVRUdXg5VUFLY09B?=
 =?utf-8?B?bm5yYXo4bkxXbVhDWlM4R20vdSswMWZERmhCaXdwYkp0bDFZdGg0S2JFMGht?=
 =?utf-8?B?ZE05OEFWQWFxSDFwMDRIZ3ZqMG9yNFJUbjB1Yk0wZGtRR25tNWtwODlXWFBZ?=
 =?utf-8?B?ck5zMHlFMFZkYUFhWkcxRXRvR01ZcEJLRmxFYXNzclRXbjNYOE1sU3duVG5C?=
 =?utf-8?B?K3Y2bUdha0dUenNXNDQzeFFRb3MxQmwyMEV2SlhEWklxM2JoeGNCQ045YU13?=
 =?utf-8?B?clR5N1FHbHo3QzBTZ0tuOE5jWGQ4NkROM3EzUUlDOW5jSTRmQU9MZWRiTklz?=
 =?utf-8?B?R3dQNVMxWnNwQ2luRk1RL0tUV2hhTkl6R2dVb1lxUGM2eWdwK1NHSjZINmVM?=
 =?utf-8?B?MFArRHFoRysyQWd0ZGlNS0V3V25nTS9SR0I0MlJ3MDIwMUw0Qys0Q3JQSTNR?=
 =?utf-8?B?bmltUldZcWJ2THVOU0V3eFF6aGkrVDFnZVVJanAwWHM3dHJGdktsL2x6WTZw?=
 =?utf-8?B?dkMrVGc2ZWZMOUVCMmVWVmtySEJxd2NvRi8zbG5VREloVzRMM0hhVkhoMEhs?=
 =?utf-8?B?YnNIbTVMM1dieDdQUU1yYkhDd05pUS9ZNm5SMVVtaGVsb2QyUUJBZ2VxLzZ1?=
 =?utf-8?B?Sm0xOGJKcjAyMU9tWDhMcFNYcVEvTjhyQ2lQYS9YYjVETG5FNnNWWjBHUENE?=
 =?utf-8?B?NFdTTDE5bU03ZmhWREhtN3h5dnQ1blhWQTg1cVByWml5eTFVbHlQbE9hQXZJ?=
 =?utf-8?B?YWQ5RURlcUpLRzBEcHBjcDEvQXp5NTBNZGVTbkI5elI2aWdvV21yc2pYWTY4?=
 =?utf-8?B?cnpHaEJtS2dHUjhsZEF3Rysrd3BFclQ1ZnpZRjlmTzAzWWQwQzZ3d0tMTVhV?=
 =?utf-8?B?dDJ3Q1BMQ2ZvcmJheTI0ZG9OcFhJUkdPdEsvenI4ZFlLUHhNVUowTkR4S3RV?=
 =?utf-8?B?NHYwb2tGczhhclhqT0FRYzRFM0wwMkVnU1Bxbkt2MjdNTlRzVWlONXQ1YlRG?=
 =?utf-8?B?T1lMQU9XMjl4bXVFbVFiZHdJa2k3NndXTlYrL2FRYzIxTGtiYzl0QWFKdzhn?=
 =?utf-8?B?UGY3UXVLeURuNk9oSnFEdjFHdUZIQnFzWXFpcFgzMzZJRGtoVkdSUWF5R3Jj?=
 =?utf-8?B?R3JlNkZNbDBNRVUrY0xrVENxeFpYVmwzblJBcjFJV1RaNFFQSVhHRkd2WFFy?=
 =?utf-8?B?TUJNOVZMZkNTNFJjMjZ1M2VCd1FXV295U0Jld0ZjY0JSS0NCVndiVXdyb0lC?=
 =?utf-8?B?a016RXZ1eVMvemN4VHlEME9hVEJSN1dEUG1jaWhYbXRBNmlSWkRzRWVZaU9M?=
 =?utf-8?B?R3hYUlROdlMyUlYyZG9KT2Q2MmNYSnlzVnh3dFJhSGZjUnppdklRby9EQzUr?=
 =?utf-8?B?ekcrcVFoWHdhRjA4d2tXSWsrQ1VXRlYrdlVXSS9BY0RJOEpMOFdDWmZxN3Ni?=
 =?utf-8?B?WEN6ZTFFTHpYR1pJUURFcUJISWl2Wk45NzhQK0tiMjU5ajhZRkxzTWJ5Mkdi?=
 =?utf-8?B?Yyt1aFhKT1F2NnlxbXdaNnc5WVhJRHN5S1AzRlZKNURDZXNQSGlqYVdiT0hB?=
 =?utf-8?B?T1Bsa3FkMUx0d1kyY3JhUXROQ3BBQWF3NjJvQmNiSmROdmdTV3Fyb0REM2JR?=
 =?utf-8?Q?ZV0yFK/X2ViRfA4SsfPwy5hR2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: babbe9dd-c325-41e1-3c82-08de3d88546a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR01MB8282.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 16:21:27.6599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 00fc7e42-ad65-4c4c-ab54-848ba124a5b7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NK81Dt7a1mn+LQ/4RDUc+FWPlpLAt+4Ju+30V+sQeNrzynpHB5Z8ywb01B/QHJYoUPKGf1Ifv1NQzqBacQrrkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR01MB7091
X-OriginatorOrg: roku.com

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

