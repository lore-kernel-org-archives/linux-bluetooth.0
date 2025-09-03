Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022130.outbound.protection.outlook.com [40.107.75.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB502E1C79;
	Wed,  3 Sep 2025 07:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886329; cv=fail; b=ZuH2cnDqKIXTGxLJv7wDsU9Nog0mnxXGEZTCk+L2SzoHp4OhDJlGUysEVVHLQxsWLtzMWe5E3w7jcpnXGxp8kbo1vV2ogbBnYE4VmNAwpiUO8iFB0523QTGatBL/NN1cmjY87dOaRID/zxwDm7sqbUCU+A9vwBbkJ9marHZBz50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886329; c=relaxed/simple;
	bh=fRFJ2Zeg4PFTF9FXNoZ31hTSPVrhjZ6E5MXWc7t3z40=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EB50tN2YL3Lgp/oRtmfO9X+ivzKyJ7/32JCkIMEIEPs5hxMRg8oV+Y2ApgrO47I+Chl9dZpxmMIiJNNhOZjSrCuI0StkdNC3e2hL1BoHBbyZkUez4i9aeggGmyN6VkLQqtJrKKF1SWtZNPlKgUDxYywAmwAQhW2NrIu7DkBhs3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Hs83S0lz; arc=fail smtp.client-ip=40.107.75.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Hs83S0lz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpdZnvj/pHGnhhgK0FKy9ObkSNeWvnNlKyQhKvISrRE1PF95Z2oFAueRtiL9+FfLL9wWlWSazq/ZxzuXopjmoE2aHnvHKf299xK8nDursp9w6Gblt7FVmGdsADvRfV2xGistWFgmORiNXP7XE6c90I6NpMkpmtYf8zhGoTR/FwScRY2ct4l9mZhrEFf3uiAEkcE5In+1RJFU+yOCyw0UleU2OWlpXRe230+wag0o2ypWB9NBJS/umLVWR8ZhtK8oxkElwXYCzALG0OodUCa66iwk34CstaDxuaS3J8+O36HgQep5BcfOT+7mGeSomHjX3GDTS/DBCOa//P2gUXE2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAKzAPb8QA3sxOaK89Zkt1rPgtLBTgduvLCj4mxFlWM=;
 b=B0JGPyO9wvypxVXvoF1VJAYdx13d0+LUQo/snSXkAvaf0iX41o1eqU0bHG+wnj+Ehu/+WZL4tpQZa8cpkROvk+YDKEpqP+wW9fexRWigbq24Dd4yKRoQ3spVbYTpF77YKFBgsLX7kqDQOj3IDNc7JpPMEr0jbCd3LscwgEeFma55C34QuJmHpTSxtkDGHveaTosO3nwLdxLs83JTw2M/iHIZx/W6YC/rHLYlUMGmEnRPpuLXtCj0gpB5FEMf78V/biJnlZ1mkHuThVZyQG//4KasOoB0T+dI4KU1bwsgWooEjBOhsTBPBMNL9uo7d0S5XfkYyDIloorfz+1+bVfKPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAKzAPb8QA3sxOaK89Zkt1rPgtLBTgduvLCj4mxFlWM=;
 b=Hs83S0lz4x1gqetmRQxx8Hfpq+0SuUjvc31XH7K3s+lyGw39uzW7GuLcdatjUIU2HG5p0O04d1aTmCC+99JqXi7cT2J5P1U8RSvTzpAOiLIVIzq7sT3Ss2ijGpaZ3XglD49OiN25eukqg1tTNq58yaneNDEopq6+i8+VrnjtsNIi3dUa3IupTE3wUixworD4pXgMx+2NbkaIgFQY39/+M3XXKjykv4Ibx2syozvGbIr52NUGr4Mblo9hChiK+mJcJGz7dJSECTfoeqRUSYPg44YhpcPB2bMgPlnO63w8zwSIZtFJQ4M0x300vmPJPlVNt9LFmTNYzB8Iot2mvkPb2w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by PUZPR03MB6965.apcprd03.prod.outlook.com (2603:1096:301:fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 3 Sep
 2025 07:58:41 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.9094.015; Wed, 3 Sep 2025
 07:58:41 +0000
Message-ID: <5874e307-fa81-4baf-b270-478128d30412@amlogic.com>
Date: Wed, 3 Sep 2025 15:58:14 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: iso: fix socket matching ambiguity between
 BIS and CIS
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250731-bis_cis_coexist-v3-1-1f9bd60ef712@amlogic.com>
 <CABBYNZJu3izq6ZhNRKjMz-mW1CcP2VAE7Xs5oq=NupnVD7aayg@mail.gmail.com>
 <4e0b2df6-1139-49df-b03b-a2f31925d52f@amlogic.com>
 <CABBYNZ+buYOXaBST-bCyzDWtWihMOoXGaoNzp6+kowKgo+-6=w@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZ+buYOXaBST-bCyzDWtWihMOoXGaoNzp6+kowKgo+-6=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|PUZPR03MB6965:EE_
X-MS-Office365-Filtering-Correlation-Id: ddda0ec3-f7bb-40ba-6d29-08ddeabfb283
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlhuM2hkcjltYnpxVE5ZV0dFR0pnaTl5aVpiZGh6RVZMbjlSYk5kLzA4RTN6?=
 =?utf-8?B?Sks2aHlIOVpRdGVJUCtiNHFBTHg2Q0R0dXJYa2YzUGFWbHUzMGlldFNKTVp1?=
 =?utf-8?B?VDRPQWpaWDN3b2tnbnFzRUs0MUlQcU8yS2d6UTNIUHdDQVZkbGxhNXlDMUNK?=
 =?utf-8?B?bVMvNk9XM0V3SWlzSEM3Ry8yU1Qwdnp3MGtIM09HNjU4alJaYis5OXNWaEF4?=
 =?utf-8?B?MlVzRy9nbEQzelFpZU4xYUFEelNqV2RPYWdYRmV1NzhVTFF0dEp4aUpONDVK?=
 =?utf-8?B?L3hEaXZmdEFtNWJjVDZ5RUt3eG1QWEVQWFZsUFZKNzZoY1NYd294Y2huRlpC?=
 =?utf-8?B?NWJPek83WmJDc21vMTR4ZzRxMzJXNkpLS2dzUTAvNUpSaDRsSldvdEF3dDdM?=
 =?utf-8?B?SE5uN1lxY0dyK2R4RE9yZmIzL01ZSUZpSzAzZHNLdW9Wb3pKRERCRE9OdG5s?=
 =?utf-8?B?dFBzN1c1V01DTmNIVEo1eUxwRDVuSTB1WG1CMkxTcWpLbzQxQzdZelVuMWtp?=
 =?utf-8?B?aXR2YjZvVkhHUENaNm9pUnBmZGFrYnlkSjh3ajBsSDFxSnA5TGYyb1JYUUZw?=
 =?utf-8?B?ZXBqeE96RFBGdGpEdXp4RTdmUmdBZVAwUzR3QlJvM2t5eWtEN3p3Rzh6V09a?=
 =?utf-8?B?L29zbG9meE5vV0NkVjhRZ2VqM1ZzOG1ncHhDNnlGT2tKUUt0RUg2KzVXKzhJ?=
 =?utf-8?B?UDZoMVdDU2w2QTJ2SlRrQUNyRDl1SmdVUFB0V0ZCNzF4UzlPV1IvcmV2ek5h?=
 =?utf-8?B?d0tCV20zeldYcENiRzRlVWJuWk1rd1BDU015YjQ4VkVlYzNBZjJJc3ZkZTY1?=
 =?utf-8?B?bHJJNGdFRjlEcGlPZllOMDJ2Q2t5L0pTekc3MWY4ZEtodTJON01ZVFp2L2tX?=
 =?utf-8?B?WWZUTzBDL3kvKytnZWp0K1daWHl2YThIZkpqbHF3VmdPRVBFbkwvQmxzWVM5?=
 =?utf-8?B?K2hCSEFZTVc4S2tkc2VoZnNBVW51MHBHc3d1Sko3cHNzVjd6N1E4ZTZBb0dM?=
 =?utf-8?B?WVUyM0RsVEJod2pBdnJwV0JTYUR4Zm5ZZ1VBRmRpQjRkMm80SEFuU1Nmcnds?=
 =?utf-8?B?cW1SN29CVmdjQ3kzTDNVTFZsUkJvcDhUbGJ1V0hKVU5QNW9vdC81Z0hnSU1R?=
 =?utf-8?B?ak9TbXRSOGpvbisyRkt6WHZLRnUxNjI1QmJLK1RPM3BaTUVGWkNDazhRbEts?=
 =?utf-8?B?RUpRemlidml6OGlGblVMVnJ3dk5raFZEU2pFQUZRSDNWTzB4Z1NqSTdVWXll?=
 =?utf-8?B?aW9GNHYyMDZGZ2E2RExoMHVYSVh4dTFJTjFCNzdVR3VZYkV2cnRsOEZCM1lE?=
 =?utf-8?B?MFVxMHlKZ01pSVVKUnV4bm02YmwvUkRPb0dmTmZPamJRcTBkOUhCS01LRmxN?=
 =?utf-8?B?eEpaTXlSNDJ3QlR2SEk2NnRERklIWWMzY2l0TTZ4alk4cFR6S0V6UVVLQk1T?=
 =?utf-8?B?aUZMdXplL0R4QXlWMDl2K3IyVVRQaVpwcmtSWlVUR0JYL3kwbEVjaURtL1B3?=
 =?utf-8?B?bFFGcU05MERJTXMvNWR1ZjB1U1d2ejhPNVZaMWNUQy9YTklTZXdwczBGSW5I?=
 =?utf-8?B?QndYclVSMFlMK0xZSVZSZHM4QXlmYzRIdGpLUHF0NjMvQUxnSDJSWTBnTHFC?=
 =?utf-8?B?QXRRTW9SYnh3Z1luS25PM3RFNlJJcStlaTVrZG1uang5UDRmNVV6U1FmQ09Z?=
 =?utf-8?B?ZDBIcFRQMVhXczR2TzlXSHVPd2RTaC9PRHc3WWpteFV1ZkpVSXVWVmNKT2tM?=
 =?utf-8?B?M2RwV09vazhzOUlMUFN5TDVhVmh2YXo1OU9OSmtoWmNhdXB1blZuODg3dStJ?=
 =?utf-8?B?Z1gxOVNyWHpVVWtwMVpkWkIwSzBVRDVzTXpzdTNhTExJZ2VwTE1zMnNsQWpp?=
 =?utf-8?B?cXN6NHNjUjRjemhUMzZ6cll5VEY5ZnNqbFNjajc3aXoyS1F0UUhXRlpzcXh4?=
 =?utf-8?Q?6gxmcIWT7Yc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VDVVTWQyR0lrQTd3dlNFeGxZc0l5R2lBUTVobnhMM2srekNqY1lPdW0zbzdV?=
 =?utf-8?B?Nmx2SHJDZUFGUlpCbURkWGpnNDlTOGh0Q1NGbFE1M3A1UEFneVdHOEt0dGY3?=
 =?utf-8?B?QzRoZ2Jjb2NodE9PL2JXdnFialMyU0VlSDN4bk5ObGhiN2lpa3ZSL1ZBQnJS?=
 =?utf-8?B?REJ0bXRUaVV0YnAzczRZV0JlODBFVXZRa0dEeDV6Wkc5NnJ3UkZqeUVOSGhu?=
 =?utf-8?B?V3Q5OXA1bSs0WnBMeTZyWUFkYnFKTitHRE50UlpWek02bEx6SWJhc2Jjcnp3?=
 =?utf-8?B?VDJUVjdVb0NNa2kyWm1pQURkZ2FBbHdsUTdvWEQzY2UybUlMVXU3WFI2RkY1?=
 =?utf-8?B?UE1aZk4rYWlsS3ljeG9ibURtNmFPOXYxN3NNL2pqcnd6bCtZWjhkZHo1dGF2?=
 =?utf-8?B?YUcwS3lXcm5QcnFqU1oxblhTZEJaM1UyUU9vRU5FUlg3QlhKd25PNVkyY2Jq?=
 =?utf-8?B?eUxUalRJM1VtbUpZTHNiVSs2WXdRMWpVMFk5LzV5NHNSdCthV2JzUHJNME1P?=
 =?utf-8?B?bE5JNHMwVUVXK3M1TlFlZWxBT3BKd3Y4QVUxRFV6MEpTcmtVRk5EM2t3UGk4?=
 =?utf-8?B?WEZzSFQ2V1lWV0VTQVVzQWNpbUFReDYwbGNlTGxFSWhVTEFSOFAzazMyOXl4?=
 =?utf-8?B?UDhjamhHTktIdFp0akx5V0kxRHRVd1V2Uy9zY2N3UVhCanl5ZjIyb0s4cDJp?=
 =?utf-8?B?U24vaFZ6NDduU05aUTlkV3V0aFlQMWNXYnVCOHdLOUJlTkRoNi9BVm9mNGEy?=
 =?utf-8?B?eHA2bWxoeU1BRk5nUytWa2t1WS9XMVAzL0pZeHZ0TmR3MXZPWFZXcTlXRmdD?=
 =?utf-8?B?U2Z4TXVCUGVPOFBmWmVjaVJXWkYzMmlGN0h6S28zS3hySmFUUTEyZWdsTTc3?=
 =?utf-8?B?Vy9lVE40Vk1jYWxoR2hESW5zWDk4TWhHV0NjTEZsaGs1bHEwdksrSFcrTXow?=
 =?utf-8?B?MnllT21zSnFqQyt4ZDNzT2JidDRnY3c3UHBkd0lDbW5HOWtCa3hDbS9kNVNa?=
 =?utf-8?B?VUpLRmRjN3pKWnNTQXNodzFzRXRNZXJka25YMjBGeXJKNlFacVE3anlkeUVN?=
 =?utf-8?B?RkUvRy9KbUFwM3JPVjluTXh5M3Nhd0VzcnVqSW40U0wrc0lMdndsU0ZubFdl?=
 =?utf-8?B?cit1SXpZdXdWYXJEcUQ4NkZ1TXIvTG9wdnpMK1BrLzJjYy95S0hvWnpyN3E1?=
 =?utf-8?B?TDF2TFN4UU02Nm83bzA5dk0zbXlUKzhkOVpVYXBHMWZYZkVwL2w1aXk4YS9P?=
 =?utf-8?B?RFUzVjZTMURYWFNweGlraEpuYm51a0dMRit4SEtTQ0hiNlIyTmMrVkRXSzFI?=
 =?utf-8?B?c1dGVStKNlRscDkzOEJCSklMNzNBOWN6UEZ1QUtYczllQ3dnUjNnR1lJbDV3?=
 =?utf-8?B?TExLc0EvaXZWUE9mTTE5TFJUSTYyOW0yMElvdGozZVRYNUYyQlpSYzJveSt2?=
 =?utf-8?B?bVRSSzdhSitoOTZvdGM4aUpZTWl4VHk1SjJzYXVySVJjVjBkSE1CRzFnN1Bk?=
 =?utf-8?B?OVUyTi9QQ0Y0cS9tazFRNUtERHpocTA3Z0hTQjM1K0hiWG84Y1Y3aFpacjVn?=
 =?utf-8?B?WnRvOVN2WDRkQm1VS3BVRHA3dkcvQkt6ejBWNkhCbVczOWdzeGNLa3dqVkV4?=
 =?utf-8?B?dHJWVjMrTzRnS2FlK252cFQ5UUJtZ2ZmU1RrNGs5MmJ2YTFRRUxqUHEzT2Ew?=
 =?utf-8?B?TnltNDNpNkM3SS96ZXJqcjlBNGEzbUNpcFM0TmdDeHNwc21NMkFJTDliOERS?=
 =?utf-8?B?VDJxbXVDZmZ3eFZaejNNSEg1Wk1WWEVBN3VjSXJkV3g3ZUo2bi9jeThzaGNi?=
 =?utf-8?B?amxaZDBqdGFUNnVIOWQzd1Zrb3dRWnF0c1QrVDY3NHVZRnM3Vlh3dlVic3lh?=
 =?utf-8?B?dTVjV3NXUUFaNjZxY2NrWWpqU0F1bWZrbkNpbUp5V0RieDZzOGZzR0RLNTZL?=
 =?utf-8?B?cWx4aTVwOHpWK1FoVVhDci9HMSs3TGFKOXQ5VUtqWE93YzJXZDQzMDRJSEJp?=
 =?utf-8?B?RGJ5a3ExU2lPN0hPa2hyVFdNVFpuaUgremp1VjJTSktjRnRrMmgvVXhSb3Zm?=
 =?utf-8?B?azd6YWJDZ2xSNFUwV2wyVTVXUGhjYTNpR0c3TmVhSVlmMTdHYjBkZlMzaWtG?=
 =?utf-8?Q?p2JxnvYvYSyMfz5l3f9DfzSqc?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddda0ec3-f7bb-40ba-6d29-08ddeabfb283
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 07:58:41.3363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6F1i2unZeLsg9XQQvHpzD0w+VLaf0D1XLgjD5fGLQvto0lMmG7ws/V04q9rm1XtrHEcTzLOUL6Ld9SXz3G1p1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6965

Hi Luiz,
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Sun, Aug 3, 2025 at 9:07 PM Yang Li <yang.li@amlogic.com> wrote:
>> Hi Luiz,
>>> [ EXTERNAL EMAIL ]
>>>
>>> Hi Yang,
>>>
>>> On Thu, Jul 31, 2025 at 4:00 AM Yang Li via B4 Relay
>>> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>>>> From: Yang Li <yang.li@amlogic.com>
>>>>
>>>> When both BIS and CIS links exist, their sockets are in
>>>> the BT_LISTEN state.
>>> We probably need to introduce tests to iso-test that setup both then
>>> to avoid reintroducing the problem.
>>
>> Since the coexistence of BIS sink and CIS sink is determined by
>> application-level logic, it may be difficult to reproduce this scenario
>> using iso-test.
> Looks like you haven't look at what iso-tester tools tests do, that is
> not tight to bluetoothd, it directly operates at the socket layer so
> we can create any scenario we want.


Based on the current structure of iso-tester, it is not possible to 
implement test cases where CIS and BIS listen simultaneously. There are 
several issues:

 1.

    In struct iso_client_data, although both CIS and BIS related
    elements are defined, they are mutually exclusive. CIS and BIS
    cannot be used at the same time. For example, .bcast must explicitly
    specify whether it is broadcast or unicast.

 2.

    The setup_listen_many function also identifies BIS or CIS through
    .bcast.

Therefore, if we want to add test cases for the coexistence of BIS and 
CIS, the current data structure needs to be modified to completely 
separate the elements for BIS and CIS.


>> Do you have any suggestions on how to simulate or test this case more
>> effectively?
>>
>>>> dump sock:
>>>>     sk 000000001977ef51 state 6
>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>>>     sk 0000000031d28700 state 7
>>>>     src 10:a5:62:31:05:cf dst00:00:00:00:00:00
>>>>     sk 00000000613af00e state 4   # listen sock of bis
>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>>>     sk 000000001710468c state 9
>>>>     src 10:a5:62:31:05:cf dst 54:00:00:d4:99:30
>>>>     sk 000000005d97dfde state 4   #listen sock of cis
>>>>     src 10:a5:62:31:05:cf dst 00:00:00:00:00:00
>>>>
>>>> To locate the CIS socket correctly, check both the BT_LISTEN
>>>> state and whether dst addr is BDADDR_ANY.
>>>>
>>>> Link: https://github.com/bluez/bluez/issues/1224
>>>>
>>>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>>>> ---
>>>>    net/bluetooth/iso.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
>>>> index eaffd25570e3..9a4dea03af8c 100644
>>>> --- a/net/bluetooth/iso.c
>>>> +++ b/net/bluetooth/iso.c
>>>> @@ -1919,6 +1919,11 @@ static bool iso_match_pa_sync_flag(struct sock *sk, void *data)
>>>>           return test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags);
>>>>    }
>>>>
>>>> +static bool iso_match_dst(struct sock *sk, void *data)
>>>> +{
>>>> +       return !bacmp(&iso_pi(sk)->dst, (bdaddr_t *)data);
>>>> +}
>>>> +
>>>>    static void iso_conn_ready(struct iso_conn *conn)
>>>>    {
>>>>           struct sock *parent = NULL;
>>>> @@ -1981,7 +1986,7 @@ static void iso_conn_ready(struct iso_conn *conn)
>>>>
>>>>                   if (!parent)
>>>>                           parent = iso_get_sock(&hcon->src, BDADDR_ANY,
>>>> -                                             BT_LISTEN, NULL, NULL);
>>>> +                                             BT_LISTEN, iso_match_dst, BDADDR_ANY);
>>>>
>>>>                   if (!parent)
>>>>                           return;
>>>> @@ -2220,7 +2225,7 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
>>>>                   }
>>>>           } else {
>>>>                   sk = iso_get_sock(&hdev->bdaddr, BDADDR_ANY,
>>>> -                                 BT_LISTEN, NULL, NULL);
>>>> +                                 BT_LISTEN, iso_match_dst, BDADDR_ANY);
>>> Perhaps we should add helper function that wrap the iso_get_sock (e.g.
>>> iso_get_sock_cis and iso_get_sock_bis) to make it clearer what is the
>>> expected socket type, also if the hcon has been set perhaps that
>>> should be matched as well with CIS_LINK/BIS_LINK, or perhaps we
>>> introduce a socket type to differentiate since the use of the address
>>> can make the logic a little confusing when the socket types are mixed
>>> together.
>>>
>>> Now looking at the source code perhaps we can have a separate list for
>>> cis and bis sockets instead of global iso_sk_list (e.g. cis_sk_list
>>> and bis_sk_list), that way we don't need a type and there is no risk
>>> of confusing the sockets since they would never be in the same list.
>>
>> Alright, I will give it a try.
>>
>>>>           }
>>>>
>>>>    done:
>>>>
>>>> ---
>>>> base-commit: 9c533991fe15be60ad9f9a7629c25dbc5b09788d
>>>> change-id: 20250731-bis_cis_coexist-717a442d5c42
>>>>
>>>> Best regards,
>>>> --
>>>> Yang Li <yang.li@amlogic.com>
>>>>
>>>>
>>> --
>>> Luiz Augusto von Dentz
>
>
> --
> Luiz Augusto von Dentz
