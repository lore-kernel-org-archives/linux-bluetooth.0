Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2095.outbound.protection.outlook.com [40.107.104.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056F1F8EFB;
	Mon, 13 Jan 2025 22:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736806700; cv=fail; b=hrTW6GDuS7nzU/bIxneAsAXYEnjjmni2jPYftwlzGzYVwWpmz86+t6lG4Eon8ZKdVv3JqJQaoEMN3eNrcaaI+ZeXBt3jIowBN+lDuAevDf9RFNtYwfaDQDbd0vSqxmee9M+BvWk3TB6Pdrtnf9rcboBP4hFGXOyS9kOK37RPRZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736806700; c=relaxed/simple;
	bh=2kwtlPAczaf39vAg8rIiPE355rTfxzqyaWeiY3A1EvY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZO4EYkRnPILKDGks2FZAwy31BeJ1sKqylVXi0c4Z8MwyXdzFa/FQKeaeGvQAErRI+29lSHWlFOWm7VwHlkdleMOzCoVGNEbgtfsqqywDQGFdltm+fYBZlDbZMaGHhZjgaJhEsu/+P1F7ANE2YLYMZ8Hr4lKvRJi6OQwx4QOJXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unibo.it; spf=pass smtp.mailfrom=unibo.it; dkim=pass (1024-bit key) header.d=unibo.it header.i=@unibo.it header.b=QgwxXO2u; arc=fail smtp.client-ip=40.107.104.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unibo.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unibo.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unibo.it header.i=@unibo.it header.b="QgwxXO2u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jX/wLjswQcwa3t7D2tdod95uD8yIbJfSmeO1/SULDG1NJ5f7ow7SqKGJdCNHrz2DJcCkyZ5z3VNRvoXjGS0ls6wPwg4ZEq955ydKUm9Sc6an62uR6Xe9iSXclz7ZSmIOCuXYb9cUtax7VkYJzpXLc/q+jlgtXHIEqqIbOxdUunDAmapD64gKbAv3zF8OKRL6nspT5AnSXsJxODa5FdSCJsIRlLdKikIn+BaBVboBwKmmpAbxzAu1SuWs6gJ/oruWnk+6ZE0fyqCWqdBOgDi3MrzKQREN2HnoET52tLmDC56iM9ptl0Ow2tPZmnZSd4NfH6j3XpTxs2g0mFTGuRx9pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7y0yBUlXbzUeTsxb7aa1uH7j62vJ2RnkyPXuMutW8E=;
 b=SuN8ZNIQHrIq4iMzUViJ9KXLSNecT4tvhPndfJbAGqZm+LXwQJNM2zFw/cdyqrcWGqCkIRfT1GBISFkWe4OON9XfEVnGDaegwSBF7rHz8hXP5TcVfMtPYi6kdjRy89xE9E5yBo3NR63YNnVRMZDuOgaFIf3ReDNBaKBdEtIKjnbtENS+ZcXyQpuv+GhW/B9pcIJVdRZDW1J4kYBvteDOo9PFfG23BL3xGz+mo0lXrAKbMxhBNgG79KbcdAoHBl2rAKvHFR9EWdah/97/wsAfnlS6Ftg6BJyeDxk+CDLUPnTp/OPn9qOjj0bQ9Y9OJZHVCa2IEcmIEXerD2KNiVvbng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unibo.it; dmarc=pass action=none header.from=unibo.it;
 dkim=pass header.d=unibo.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unibo.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7y0yBUlXbzUeTsxb7aa1uH7j62vJ2RnkyPXuMutW8E=;
 b=QgwxXO2u6CqswYf1rbb4DMbR1yk50FtvZKyOv99MQPXNHXfTvrcTYH0dg9/Hz1+pB4w3FcPYy/H8rZvrOkE2A6huk6IvGC+4vFOK57p6G65XJ2SNNADFGfd0Vt+Kil6iAEDkM2m5wmrdaeJPWW7NNUrLhg6kuZKkuIz55ov0mck=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unibo.it;
Received: from AS4PR01MB10106.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4f5::11) by DU0PR01MB9552.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:350::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Mon, 13 Jan
 2025 22:18:15 +0000
Received: from AS4PR01MB10106.eurprd01.prod.exchangelabs.com
 ([fe80::de5d:230e:da8:61da]) by AS4PR01MB10106.eurprd01.prod.exchangelabs.com
 ([fe80::de5d:230e:da8:61da%7]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 22:18:15 +0000
Message-ID: <9ae25475-e8f4-4ee1-8022-7621fbe8ebc6@unibo.it>
Date: Mon, 13 Jan 2025 23:18:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Takashi Iwai <tiwai@suse.de>
Cc: "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 =?UTF-8?B?RGVyZW4gV3UgKOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
 "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
 =?UTF-8?B?U3RldmUgTGVlICjmnY7oppboqqAp?= <steve.lee@mediatek.com>,
 "marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>,
 Sean Wang <Sean.Wang@mediatek.com>, =?UTF-8?B?QWFyb24gSG91ICjkvq/kv4rku7Ap?=
 <Aaron.Hou@mediatek.com>, =?UTF-8?B?Q2hyaXMgTHUgKOmZuOeomuazkyk=?=
 <Chris.Lu@mediatek.com>, =?UTF-8?B?SGFvIFFpbiAo56em5rWpKQ==?=
 <Hao.Qin@mediatek.com>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
 <ZuB3omUkdUHLggYu@mdpsys.co.uk>
 <790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
 <ZuneSM4SvyUFX86j@mdpsys.co.uk>
 <9bfbbf24ac2480d94d3455f7e33e4b5502b38ced.camel@mediatek.com>
 <CABBYNZKYsL9jcF2n9TsA1BjU-CjXOdXu7MDLP9Sz_Ly8hBAf1w@mail.gmail.com>
 <c01e6dfa730dd10a7d4dba60fe31e82b9c296b37.camel@mediatek.com>
 <Zuyk1c6Gkxx3G0PB@mdpsys.co.uk>
 <f9e8688ebe559e10c019d0cbab4e8b1f5a7d2339.camel@mediatek.com>
 <ff502f63-2d87-4dee-a893-cce53353df8b@leemhuis.info>
 <87iktk4d9l.wl-tiwai@suse.de>
 <75f671b6-ce2a-4404-b662-2c9c7d28a598@leemhuis.info>
 <d0f70e662f5e9329cff43f92a5c191601cc599f1.camel@mediatek.com>
 <0a988691-8c18-4dca-ac78-94e36a9b8b37@leemhuis.info>
 <f3c6f6f857d19c867941c86c644042fa195621ac.camel@mediatek.com>
 <643d8055-5a9f-4f5b-865b-830d33651dfe@leemhuis.info>
 <87ttcqt0hx.wl-tiwai@suse.de>
 <746e7fa8-41ba-483f-a674-2121fa0ea2d8@leemhuis.info>
From: Sergio Callegari <sergio.callegari@unibo.it>
Content-Language: en-US, it-IT
Organization: =?UTF-8?Q?DEI/ARCES_Alma_mater_Studiorum_=E2=80=94_University_?=
 =?UTF-8?Q?of_Bologna?=
In-Reply-To: <746e7fa8-41ba-483f-a674-2121fa0ea2d8@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0013.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::8) To AS4PR01MB10106.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:4f5::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR01MB10106:EE_|DU0PR01MB9552:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f3ad130-849f-486f-af05-08dd34202ca8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y09wV1AxNUZaNVYyK2NNaEdrL1RIdTdmZW5GZkYwUkFrNks4NHR0TGYzTUY1?=
 =?utf-8?B?am5qNnZWZ0hSUFBERG9XWmxVMEJtbDdTRjdCR2YvazF4T2IrRWduTk04ZVZs?=
 =?utf-8?B?VHNtUnRZeFFiYkZCSnZ4cGNLYXNTVnNMYVBnVjN3T1V5Zjg3WHgxYnd0YlZY?=
 =?utf-8?B?TEJKMDJHU29TVnpzLzZKQndCN0MvVkE1Qk5lS3ZNeENjMzdFbTZjYVR3SVNG?=
 =?utf-8?B?eEExbE9sM3BETHRlRlZIRXhXS25ORUcyOWdzWGVMbmM5SUl5bitWS1JLbjI5?=
 =?utf-8?B?c0RmbUs1aEkxVDdsQmQxQ25MTThuNVhBelVMTHZpTkE2UGNkaGJ0dDVZUnNS?=
 =?utf-8?B?MktjbHo4dFNpVWUxdnYwNk5oR1Rhdkxxa0E4eTZHYXhrcWQrdEFBeVVxUkV4?=
 =?utf-8?B?SzNKbGRwVmsvSG9aZG1Idy92YjJQK2FNZXEwZUc5OXZJbUxvU1o0N2VNQmt5?=
 =?utf-8?B?NmRLZVgxVHNkTmpTK3B2MGw4K0E1YU9kVjJRSlRyQVBkYWRRMFVzMzBrTEFP?=
 =?utf-8?B?bU5LL0lDOXlFWXhRSTRJZjZyRjY2V3BSQlMySWFhcjV2YTM1TzdhVzhDcEE5?=
 =?utf-8?B?Mk4vZFluZ1Z2ZThmeFB0STZDLzZCQnJjZDBWQ08rd1RFSVFhSWF6NTl5ZkNq?=
 =?utf-8?B?UUo4cGcySEpzTGJ3MVF3REtROVNOREQ3Lzhvb2FoOUVnQ2RUbUtYNDZGdjlF?=
 =?utf-8?B?akNhK1VUK0hjdE1Md2NzMHQyMUpXYnhneXVCT0JMeUZ0cHdHUWswVW5zU3ZL?=
 =?utf-8?B?dGR1TzVDeGRERzd6Q0ZwMTNJdExPSUJvQ3gzV3FNdmxDM2hBdnA5R2ZDSlkv?=
 =?utf-8?B?cUF3VDRjMERCZ3RlczJZQlgvbmhlOW1vaXVIQ1J1azdBZ0RvNnY1RVdycVY2?=
 =?utf-8?B?R2QydHhqUEFKdXZkSnZFSjFERThJejJnSFpOcTBMR0FNZmc4cVJGNDBIU0ho?=
 =?utf-8?B?SnFGMU1TdlpjTFZjNVNNSVo4VXFpSHpQZ09MWnpzd2V0WFdnV3JzSzhRdjhD?=
 =?utf-8?B?SlZoamtsZFVtZTBxMmY0TzljWThOKzNpenFSUmZacGVzVE1Ya3NlTnZkRUdI?=
 =?utf-8?B?UFVTRjZPSmpFRlpzL1U3SnJsODc4K3NHelQzOEhvR0c0RkxRQVhoMnJCalVo?=
 =?utf-8?B?RytWck9OR3ZZTGZXVzVyY3VQQUM4TXFnL0Q3WWRaZyt1SmtBekN0eWUzSXIr?=
 =?utf-8?B?M3hXdXovdm1BSmtTVDJ6TFFVcHFJWUdrN3FSSzMyTU1KU3U3d0JiUGlsRkVF?=
 =?utf-8?B?RHhzUFhQNGlaamgzRHVNRUYzdzBLdGdsdkFzb1UyUTdDZXlaU2J6REpZUDFz?=
 =?utf-8?B?YklMYUJZNUFtbDEySmVtVTd0d1BOSXcwbHZUbEF6WnhmNk9xTlhHNTcvZkxl?=
 =?utf-8?B?c0w1eGJXaFNlZE1MMlJXOGpELzdNbG8zQzVsNWRoenV3NzR1UU81aU9SZXhs?=
 =?utf-8?B?bk5CNi92K1k3YnVQQnJVeWYyYVh1UWdPUENlVmoyQ2o4SVdtRHNrQWJaMzk1?=
 =?utf-8?B?QlhJWTMyS21DTDQrckdmald6SFk3bEhCTTRCem03MkRxRHBJL285M1VVbmVl?=
 =?utf-8?B?NU5ReHczRmN0MWI4YnZWaEVuazR0ZzlpS2pLT3BZTm02UmVwQW1qR3VPUkhX?=
 =?utf-8?B?UFl5czl6b09iZVh0em9lWVNwMDZyZzlybjRablZLeS8va2FzWWJNZDkydE5v?=
 =?utf-8?B?U3ZFWE1sektGR28rZUM1UXNDTk1JbU1WWWpSN3ZSTnFpUDZwd09GV05KMnpZ?=
 =?utf-8?B?MitWaUhxYytGbTZJMVF6Mll5ejd5Yk16K1V5QTMxNjQ5dkd3T1BiejlCOUZP?=
 =?utf-8?B?QUNiUHZuTEVOc09xcit3NHdnWG5JdUY0cnY5T3JSR3Rlb0V6elVVTkdGT3hV?=
 =?utf-8?Q?oRp566fs1+vzF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR01MB10106.eurprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0I4eWlScERyODF0RGdRZXlmdHIxRFpzMGw5amFKTEhmU2NNZFV6TjdjNFJ0?=
 =?utf-8?B?K250ckE3alhQb3N5L25RVlAzVllhQ1dXR2doZDBFQXFJM2t2eU52OENZM05r?=
 =?utf-8?B?L05lRUowYzJwbERGS1NncDJUTDRTUmtPTVBqTGI1VkJMVXAzMDR4NkV2bEYx?=
 =?utf-8?B?V2lualdQU1lFaCtzMjdNTFNOYXUzOHZTQURnTzVwdVE0TVlGaGR1OXVLMDlY?=
 =?utf-8?B?Z29BR0NHa1F1QjVib3hFMTc2dXFmWnVFSWhqak9UdlBXYzltMlNhV250Q3Fu?=
 =?utf-8?B?aVU0TENReTVmNVpjRHhvWXFWUzFYMDlVcWlsd3dPL2g4VWprWGdjWkxuUE9p?=
 =?utf-8?B?eHhnTHAwdTBkWTZTK3ZkdUZlaktGUW8wSkIvdkJvN1JOdnZoRGVXakc4V211?=
 =?utf-8?B?cnk0Ym9JRWY4REsrTFdCQ3M5dHFmQmcwbEpaZmEwT0xFT0pMYzN3SGh0RnJj?=
 =?utf-8?B?L2s2N29wYThVQjR6SC8wZGw2TUdUS2R2a0RNRUtUQm9MaVNwMFkrRXNFMkt0?=
 =?utf-8?B?ek51ZEd6OTkyU3R0OUpRQXRRMnlpeXBnT1FJY2RMbncvWEZXdWNJS2YyTW9l?=
 =?utf-8?B?TTdRRXh0OVhLRFZ1MExzZXFHUVZ2bzllb1NCdTlQTWQxRUNWdytXYlVHRTgz?=
 =?utf-8?B?eXlkd04wY0RBZ1duZCtMUzdXUlhSNU1CamQweVBYVUZIeE9lWEQzSEg2UXh4?=
 =?utf-8?B?R0J6dWd3SkdVN3J1dCtTMUUrRUNwK0Q0SzhXZGw1Y05CUW1yeTRMajhzNVFG?=
 =?utf-8?B?eU5zT1BqZ1B6L0cvQW9INzlMckZmbVN2clp0aENUK05Ob0k1QjJJOTh4aERi?=
 =?utf-8?B?UGJSS0lFQVNqbVppc05sYzN6SzlKLzRSaXNJSEJaVmRDQno3eWtyZnpHRXFt?=
 =?utf-8?B?R3htYUUrenhqRVBWOEFWd0lsVURobFlYNjJrU0x1SWQ4TW9VQ1FnY3pSZGJK?=
 =?utf-8?B?aS84a0dxUE5sQkE2MjdicUxvbnJ0QXM0cWJnK0I3VHdsMTRZV2tjUVpSeWUx?=
 =?utf-8?B?aFVjYjFaMzNIV0JyUmNaWHlQZm5aQlZvSEpXeTNEY2psNTd1OTJza0c5aloy?=
 =?utf-8?B?RnRZS01tZ3MxbVY4cU9sbU5LMU1TUHE1R25FVEdxVzhoeTJMMFpwZGh6UnVl?=
 =?utf-8?B?ZFAzWlFoTkk0UXdZMjNhb0Y1MFJNQ2ErTE5zeHpHR1J1M293SXp0SXRxWEtj?=
 =?utf-8?B?OW12OWV2QjV1Wkp6emVwTlQzd3R1b2lyRzB2dzdJbmJ4RmVTQVRrVlFJUHJP?=
 =?utf-8?B?YmpFTEljb3B0NEFMMGlJd1J5VTh1R2wwNzF5ZHIxbk9EOGIrd0pIeVh1cjBI?=
 =?utf-8?B?dDdueUVwTE45MUxSM0xUN3VtQXdPaGhFOHYvb0xFbk5RUXM1Tlh1NElZeXg4?=
 =?utf-8?B?S0xGUEEzQzJhaEZCcjZCUi9RMXh2dnYxOTZpSk01OE5ISGZZaFhuSVdwQVB1?=
 =?utf-8?B?MFRUeUw5LytodlBMeW5kS0MzSGV1K0h6Q29FWDgvcDFWa2I2SGpic2wyRmI0?=
 =?utf-8?B?YW0wRlIyTkplbmIyNXh3SWZ5cnpNanBzbVY0ZjlhcE0yVkRzNW52RHJ3T1o5?=
 =?utf-8?B?ZFNaQVExTi9JRGFsWWhQdHZKOW1JWmVqT0NrNEF2WXMxZGprVnBlWnJwYUVW?=
 =?utf-8?B?SlhsaTR6cENVczhGUHRZSE15Ym4wWDNuUXVXSHNBQ3hFQnNBWG1LSnFoOHM2?=
 =?utf-8?B?R0Rwc3JUOXAvR1o3NHlIc01odk9IYkRaTlNLYkZpQi9oM3lVeksrVDYwZDlF?=
 =?utf-8?B?TEx4WU50ZmJ5SXlvSnN1MFJtblhmNTE5eHlqZ2xrSloyQmxscmlGNDk4NXg1?=
 =?utf-8?B?L0VLWjkrandkUFRnckJ1cGJqRXRubWE1WnJQdWNpOC9UZ0pPVWEwRGR1YlIv?=
 =?utf-8?B?cUJ4WVY4RnVkcHkvUkFXTlJMU1lMV0pTM2hUWW45QmtTenduWHRhWCt3NlVp?=
 =?utf-8?B?VlhkSkNkSW1FeWpKLzBRbW9wZ0dHbTFhVFZCRWs5eUd4Z2xDbFYyUFVmUUpl?=
 =?utf-8?B?ZS9JLzFLZ2tCSCtlTlFVQUwrcEhQOStXSVlCWUVtZ2JheTliNDI2cjZjSmVm?=
 =?utf-8?B?RVNTL2RIR2J6RHZQdnd6dHpWcjgyZUluRXBCL1psUjgrMjJKa1h5ZVdZTzM3?=
 =?utf-8?B?UUszN0pnYm5Ic0NobVVlV3JwcTlNUmlkWnRFL09XOU52MGx4V3NPWEFQTFQ2?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: unibo.it
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f3ad130-849f-486f-af05-08dd34202ca8
X-MS-Exchange-CrossTenant-AuthSource: AS4PR01MB10106.eurprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 22:18:15.2427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e99647dc-1b08-454a-bf8c-699181b389ab
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q73sZq6Pb6Ki3qpS0cMDfTSrYvXoDRm/F6IGq6CJSfYvQCfTZ8XVO3w7/APqKCBHCR5sbUdSu9/p8D8nW61i7QGrA6pvOTQ7yHx34f5WeAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR01MB9552

Sorry for getting one more message in this discussion, but the issue is 
still biting.

On 11/11/2024 10:21, Linux regression tracking (Thorsten Leemhuis) wrote:
 > On 02.11.24 11:04, Takashi Iwai wrote:
 >> On Fri, 01 Nov 2024 15:22:13 +0100,
 >> Thorsten Leemhuis wrote:
 >>>
 >>> Thx for the insights, but it feels like this is not the complete story.
 >>>  From Takashi's mail earlier in the thread it appears to me that 
there is
 >>> a regression that the patch at the start of the thread fixes:
 >>> https://lore.kernel.org/all/87iktk4d9l.wl-tiwai@suse.de/
To the best of my understanding the patch mentioned here is now in 6.11 
and 6.12. However, it does not fix the regression from 6.10.
 >>> So it appears to me (please correct me if I'm wrong, which I might be)
 >>> there is some regression that must be fixed independently of any
 >>> firmware changes; not sure, maybe it's a different regression that the
 >>> one Marc saw.
The new firmware does not fix it either.
 >> That's hard to judge, unfortunately.  The only fact is that 6.11 and
 >> 6.12-rc are still buggy and fail to boot due to the kernel Oops from
 >> Mediatek BT stuff.  The patch
 >> 
https://lore.kernel.org/all/20240822052310.25220-1-hao.qin@mediatek.com/
 >> seems working around it, but it doesn't mean that this is the right
 >> fix, either.
I understand this is also in current 6.11 and 6.12 that still hang on 
resume from hibernate.

Unclear to me who can reproduce the bug. From reports it looks like it 
should be relatively easy to reproduce. Framework laptops as well as 
Asus ROG Zephyrus 14 2022 do show the issue.
 >> My wild guess is that there are substantial problems at btmtk stuff
 >> about the firmware management.  It blocks unbinding if something goes
 >> wrong, and this bug surfaced casually due to another change.
 >>> I just don't know what's the best way forward to resolve the regresson.
 >>> A revert of the culprit? The patch at the start of this thread?
 >>> Something else?
The issue was not present in 6.10. Having an idea of what to revert 
would ease testing from the users side.
 >> Either a revert of the firmware or the patch that triggered the issue
 >> would be helpful as a temporary workaround, yes.  We need a quick
 >> duct-tape coverage, then fix the fundamental failure.
The fact that 6.10 has gone EOL has already left all those on rolling 
distros with no usable kernel unless one overrides the kernel from those 
offered by distros. So, yes, having some duct-tape solution would 
definitively help.
 > I agree, but seems everybody else sees it differently or does not care
 > enough to do anything about it.

Substituting an intel wifi card for the mediatek one is a relatively 
cheap solution, but given that the issue seems a regression it is not 
the expected one. Wonder if 6.10 was working /while being wrong too/ for 
some weird combination of factors.

 > Or is some firmware update that fixes things within reach by now?
 > Assuming here that the firmware is the only problem here (not sure at
 > all if that is the case), as users never should be expected to update
 > the firmware to fix a regression caused by a kernel change.
The more recent firmware does not seem to fix the issue.
The issue has in fact worsened. Until not long ago it was enough to 
rfkill bt to work around the issue. Now, this does not suffice and I 
need to switch down the wifi too.
 >>> Takashi, Luiz, can you help me out here? I guess I otherwise soon will
 >>> have to involve higher level maintainers to sort this out (e.g. the 
-net
 >>> maintainers and/or Linus).
 >> I can build a test kernel and ask the reporter for testing if once
 >> something is provided, of course.  Just ping me.
Is there any patch to try against 6.11 or 6.12 at this point?
 > Hmmm. Given the above I wonder if it would be good if you could make the
 > reporter test a kernel with the revert and see if that helps -- and if
 > it does then consider submitting that (with Linus and the -net
 > maintainers in CC) to see if that gets anybody into action.
 >
 > Ciao, Thorsten
Thanks for the attention,
Sergio

