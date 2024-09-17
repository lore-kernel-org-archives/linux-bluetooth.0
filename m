Received: from GBR01-CWX-obe.outbound.protection.outlook.com (mail-cwxgbr01on2131.outbound.protection.outlook.com [40.107.121.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EB8145FEB;
	Tue, 17 Sep 2024 19:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.121.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726602850; cv=fail; b=uXZi82c4kQTt8OStiGi7apqT61TXJ858YEKZLLCNtshIMgSjtpOroUAUYLIN5TBlwVPFpKfrpawExADHuYzXBswz5InVNZL+md73xdOfgybADCFdm5byJYB7PzpTUiTEpht/U4kjT+U3Z/MJvYLonHFcnMHLhZYnqpNSAkCLe8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726602850; c=relaxed/simple;
	bh=5Ho8VCu2N0VYbmQlHL29PYl5SmzqJvsUqtkVXFRk294=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u77aehaWpLXhzeTTChLTCA1W9RZEtOJ5vJRqOlemhFN+7ygYRAYedpvty94lthINLTQiu/LmfFVgRqhFbzxSQnBAX1nMGjsUnSQYi6Jk0+OawQ9AvVXoW2uz2BdTswFYCrfHt272FgWAO/Phvo1TZKeWBIzbwQVbZCItq8RkHLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk; spf=pass smtp.mailfrom=mdpsys.co.uk; dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b=p1sNne/5; arc=fail smtp.client-ip=40.107.121.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mdpsys.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mdpsys.onmicrosoft.com header.i=@mdpsys.onmicrosoft.com header.b="p1sNne/5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nXJI6Yu76pn952vluSz0tM50uuBH40PvpBEXxdm//TC4RQBjxEPpgI2cMkdPtTIIvG4xJk9w/ZucWBYuyArhP/sRdbVcnEG15NnHTM+sekR8xdc7EAmLCCk9xTd2fscMMq+qEe23AnawHQ9YdXhg3GIHmK+ijl4HbB1e6Hbl9RMUmDKC84I9iMnmA8sx2JrZLTkjuyxek0Ou3bXwhUDQrMApdcXv5BCiiRHsfyA6phP8TXybT7bUPUmW/RcqYHkEjM0lMiR83Q+2Oi9QKGYTOKNr2v3Q71J2Bez9YzyA/l1dqSjD3laGxl+vdCNclJH1CEoktzPXQ86WjJdh4YJXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Wdy8eB2crv8rrSPiYSfdAQklc/5ZHuKzKJFKOVy1Js=;
 b=quEPizMdDqaF3pOQvxL/WTjqSIa448pYAIIwJny5vlqLCv7PIIDjbLlMOVcsncGNV+i8Oz69v/K7J2HFZQtGLa2oZ9sY0OwGqgQhl5M1PuWdQvesZ+8iVxPhnUDScq2MIVJPkUVfsL0hpiPDnyHK87rXv1ayKUSnPl9Sd2X8ydP+Xe5bcxc7br9bq4tlxRJ+pLqh9Yw48lt2HRv4OYjGqPxZIDltIQu89m/O7NRSyMj0iu2fq1CkMm4DI/3jEDzQIPGZqw17Sz0ist042oI9bWVMXT9Fmw3JVKCTgcPaQWQvhyd6gY1PJvXS548MIGGdnjXPTOFn3TVQjLgz+vl1AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mdpsys.co.uk; dmarc=pass action=none header.from=mdpsys.co.uk;
 dkim=pass header.d=mdpsys.co.uk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mdpsys.onmicrosoft.com; s=selector1-mdpsys-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Wdy8eB2crv8rrSPiYSfdAQklc/5ZHuKzKJFKOVy1Js=;
 b=p1sNne/5TP+rvUpfA3yUn+uzUA+QEPTTsQzluMi9odKN7h9eWuZJZ2O6aFIbprFlT1wZDdF0EKrCNHlyxBvPeS3CHZjEgt83mokLKmUkvMgEKQnvXiFTBhSCcm1T2jBeI+NSGVemXGJJ90KscCNa/o9XASjYvuI9P/GBF/50HR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mdpsys.co.uk;
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:b1::12)
 by CW1P123MB7852.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:249::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Tue, 17 Sep
 2024 19:54:00 +0000
Received: from LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916]) by LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 ([fe80::1ead:6130:3711:f916%4]) with mapi id 15.20.7982.012; Tue, 17 Sep 2024
 19:53:59 +0000
Date: Tue, 17 Sep 2024 20:53:44 +0100
From: "marc.payne@mdpsys.co.uk" <marc.payne@mdpsys.co.uk>
To: Chris Lu =?utf-8?B?KOmZuOeomuazkyk=?= <Chris.Lu@mediatek.com>
Cc: Hao Qin =?utf-8?B?KOenpua1qSk=?= <Hao.Qin@mediatek.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Deren Wu =?utf-8?B?KOatpuW+t+S7gSk=?= <Deren.Wu@mediatek.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"johan.hedberg@gmail.com" <johan.hedberg@gmail.com>,
	Steve Lee =?utf-8?B?KOadjuimluiqoCk=?= <steve.lee@mediatek.com>,
	Sean Wang <Sean.Wang@mediatek.com>,
	Aaron Hou =?utf-8?B?KOS+r+S/iuS7sCk=?= <Aaron.Hou@mediatek.com>,
	"luiz.dentz@gmail.com" <luiz.dentz@gmail.com>
Subject: Re: [PATCH] Bluetooth: btmtk: Remove resetting mt7921 before
 downloading the fw
Message-ID: <ZuneSM4SvyUFX86j@mdpsys.co.uk>
References: <20240822052310.25220-1-hao.qin@mediatek.com>
 <ZuB3omUkdUHLggYu@mdpsys.co.uk>
 <790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <790e542aa9d08c7efeee6ef298fce2a87d8035e4.camel@mediatek.com>
X-ClientProxiedBy: LO4P265CA0293.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:38f::11) To LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:b1::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO3P123MB2972:EE_|CW1P123MB7852:EE_
X-MS-Office365-Filtering-Correlation-Id: 47c30b4d-b7d8-4750-8ea8-08dcd75278e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V3UrYmd0bStvWjdncEgwSkwzNDBWZGwzVWxGUksyajZoVWkweDNSTlZvbmor?=
 =?utf-8?B?WXVlcG9RREhaajh0c1ZnbXZqMXVPeUpETzJmWHVoQWRmSG5zTlYyVlIwa1Rj?=
 =?utf-8?B?cTFaNHMwU2ZFeklJVHBESXNQSzN1aXdaYmZnSUFaaUlQZmE3R0pHWUY1cFJt?=
 =?utf-8?B?RjlKa0ZST2g2VE0ySDAwY3BRamRhYTYxUHBJeUk3ckdlVm5rY000M1NkaEhs?=
 =?utf-8?B?M2FEZnl6WnkrRmZ2YlFyTnM0eW1FZm5LODFicVI4K3hnZ0NmUmZVUjdmTytk?=
 =?utf-8?B?UFZMMDYxNitKemtBQUxxWVRHQ0ROZm9VS21hcmpDZ3Nsdm14SU9zT2tkRWhk?=
 =?utf-8?B?S0ZaMlFHM3NMRXVMQ3lYeWhvb1VjTkQ2UkFoNGZhM1NOVjU3WGRhS2Zadzda?=
 =?utf-8?B?ZDkzWHl5c2pPRVA2NFEwZTBQdmd4cWVNZ2kwMGRXVkZmTFoyWnFTTy9PSGNG?=
 =?utf-8?B?Wjd3L2t5K05HUklqWDQwMGMxaklCcE96a0djUkZ2Ylh4OUxuVDZXb2R0dVdR?=
 =?utf-8?B?T24wQnVjYUtNRGszZlg5S1pWd0N6VHhXMzB3aXNFSkVaWWQ5YkVjaTNKRTRI?=
 =?utf-8?B?bDM4eVFNd2ZWUkZ6UmJ0bU5LTlNaazlWWGhLK1hNZ0RKTktQb1ZNRnZoazU2?=
 =?utf-8?B?Ym93bXFjbGtUUlYwVGZwOGVobXBBTW1iVlhlWlBvbXRVeUdtbW9ObUl3VVlw?=
 =?utf-8?B?bmxEeGdaOVYyYlJKd3dzZytwWHBZNkpqZTVuRlBqaDluSC84RjBMdFlPeE9k?=
 =?utf-8?B?VmtSN3U2cXB6clZMVVZtMldrVWQrdTJDcjF1WWxQMnVQb1RtQ09DNzdIWHcv?=
 =?utf-8?B?WGFHUE1tdHJwaU51RUNlSTVRUlFyS1BiaGptWEg4OEhRdU1ERi9LSERiV2Fi?=
 =?utf-8?B?NHFlMHdSZlh0R2VZazNnMnNDcmdzRDlFbWV2OU43elZxR1M2WFJwMVlUZU0x?=
 =?utf-8?B?UHM3R2ZBTjhIRDQxckZ5Sk1jN1ptWnFONmdGc0NibnhObU81alZWM2Y1VTQz?=
 =?utf-8?B?VGVKYkpJaTBNN3pqT0lkY1BERHFVQnlGdCt3Qlo1M3FYaFQ2dVdpb3ZHdFpj?=
 =?utf-8?B?eEkvUENndTcvK05acStRUXZ3LzdHdlRYSDlkbDc1QW9Vc2pjQkRLb3NuVSt3?=
 =?utf-8?B?MWhFc2I5ejVPUGhyT1Vqc2tnMkEvV0NHY3M3Z1dZK0E0RkRHZUlSQ0xyaXlU?=
 =?utf-8?B?cmVjeExsY01TQm5uRVk5c3d1Tld4RGZ5T3V5M2Q1U2I4b3VsY1VXQ1hIOGU3?=
 =?utf-8?B?b3Urb3VpOTNCSkZFSVB1VkpFRWNHWmlSYm5XeGVObzdyS01yZDRqSFR3ZUlZ?=
 =?utf-8?B?RCt0czBFbjBld1ltTTJDNDZ1MVV4TUZ3NkQ3Sms5bWdXWEo5clBZVi9EQkE4?=
 =?utf-8?B?T0pHM3p2VzFUZVZjeC82cHRSNDFUTEpzRUxyVFBZUFFuQk9hVDJnc1lGRTZ2?=
 =?utf-8?B?RUx1Vm5nd0g1M3R0a2lkMkpOd1V4NHVCK0xrTGpKZzA1RmhvSEl5Wjk0TWs3?=
 =?utf-8?B?eUloZEYyakZBaXBSUnpqU0ZuS1VXYU4wVkpqYUd4ZUI0YkNJOFE2T1RMbjNu?=
 =?utf-8?B?VWFlTXFUbENYcVM3UUY5ZGtHSTFZaW5KYVhTVE9tWTNibmxzWmVPWTBsYWsx?=
 =?utf-8?B?NTJZT0xpUmx5Z3o1L3I3OEZSbC8rdHRNWXhCR1JNVTA2R2dKMlJWZmhubGwr?=
 =?utf-8?B?UThpU1RvS0Z5RVJXejdiZUt1d0ttSnJWQW56ekNCTlRNLys1QzBZMXgxdFVs?=
 =?utf-8?B?VllsU2FjdmYxQ01UNVhITFFtWSthc2ZYODZxZElTZDZTamZOK3poWWJvajBN?=
 =?utf-8?B?d1VIa1Z4YWh2ZVJacllQdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0g5RXZBTlZYOC9vVXpMaXZlUHduV1BhZnlmUVhObFF3MEdzbVk1eVczSTUw?=
 =?utf-8?B?U29iNk9RelJEZmFWNUNVN2NYTHZvdWE3QndGWFFWU3o3TzdaazFac2NvZ1hJ?=
 =?utf-8?B?YVFhMUhCa2ZoL2VGSXJJYWJRanNlK0YzUmFSbEJpQm5uNXFOL25hWXd5akdx?=
 =?utf-8?B?U2pLcHp6ZGZQMEZiblVTd3pnQjdmc09qZlVCbkdZamtxMzZuWHFnOFNRTjkr?=
 =?utf-8?B?LzZ0OUk2ZitwNk9vWnJOUmxXNGR0dVd1ZnV0UHVDSG91Q1F0aDJOd2lKYnFZ?=
 =?utf-8?B?eElsZTQ0KzB2RVBWcFJQTEIrU1A4WHNUVGFJWjNGWHFwWXdXRzVPN3FpSnY5?=
 =?utf-8?B?eEhsbTJ5U2ZmS3lBZ0JOUzR4aXRMTjhPSFppeUJzVlBLak1xbTd5bzVINE54?=
 =?utf-8?B?VXg1ZlZGanFCMGNPNXNhSlNqVXkxR2lST2Y2WHhCWVBqTVVjd2JnQ2Rwdy9i?=
 =?utf-8?B?dkQ5RU41Q0dNb0Y1bndQcG9vbzlnS3VDZTBmUmJmcndtangycGkweTdzd0dh?=
 =?utf-8?B?OUZ1d09BZm90V0FaU0ptb0xDOVRqN0dFU3F6RVExdkRnQmlta3VwZi9qK1M1?=
 =?utf-8?B?OGUyYndZa21sdk9LSU5oVklkUjY5WEZDVTVPOEpLTFAvWStvc1VNakZ6YVhW?=
 =?utf-8?B?ZCt2bnFET2Y5Y1puRUw0eXQ0Ky9qZzdteU55Ui9Vbmw0bVIyY21qZWlNUC9x?=
 =?utf-8?B?OTZQLzYwc1RuQlVRY3E1MXFCZDdySWhKNVNmT1RYaXhIWmIyS3JIQlFvOFJz?=
 =?utf-8?B?bEtmZGM5dGV3cENPNWJvb2pydU5wck8wU28xYmRsM1JUTFZMQmg5ZGZ1ZGJy?=
 =?utf-8?B?TnpvWlRwZVVWUWZodUVzcHVpSlhoaVRDenFpVjlpUnRMM0VGQ1QrZzIzaEZ1?=
 =?utf-8?B?VmM1TGhrbjl3OGpTMCtJRkVEMXo5UUVyTTFkVTJCT0dPSGJpQ3BwVy96ZXFG?=
 =?utf-8?B?azVnamJTZ1REZnYwdHE3TUp1aGpMTnFjeml3c3FyTzI4TVRCSlVCbUtZTUlm?=
 =?utf-8?B?aExoazJIYnBicXFjajBxZzBvYmRIaUovWmt3K04zVHdxWnl6V0lYSVNqdEVh?=
 =?utf-8?B?VEZnWitXdHM3emZGR3pUWHBiNUpRa1lDaHQ1cnRNUmR3TjZwbVVFbEJOdkdW?=
 =?utf-8?B?VnI5SHJ0b01TczVwRThIMlIzRWxkaHBNMmRMckRuVHBBZGZTamVDaFBIV0Fw?=
 =?utf-8?B?dzhKck9GRGk0dVFrTzZDVGo4dVpiOUoydU5EZExGQ2xkM1M4YVljNElQcGVx?=
 =?utf-8?B?aUJVaURzakUvYkhFS3BZNm5mWm1mdkcrNW4zcW80QWxtNU5CaTM3Sk93MHI2?=
 =?utf-8?B?MVVQQ1EvWDZwR2ZQL1prN2FZYTdsSVFNUTdMK1BNZWVFTUxqTDVLL0hLb01l?=
 =?utf-8?B?a1pyaFArNWNEdU5hSzRWOUpnS0lQQ3FqTTRqTENCc0MzMnNlVFRtVm41M0V1?=
 =?utf-8?B?RnJ0SzIxeGk2TEI4NkYweGdMNFNFQVppTGdoQ2lyVUFFWnA2b3R0c2sycEpr?=
 =?utf-8?B?YU9JN0twMXVPbHoyVy9ML29hSFlFeCtZYTE3YjYvVXowV1ByTWNxdGxyK1ZT?=
 =?utf-8?B?VDF6a0V1b3ExVFVOUWV5VWNxYlRtUC96eFNML0MyUmxhaVEvUEQwY002SC9L?=
 =?utf-8?B?RExLN1lVU2ZNdHNzbjAxZ0Y3U2VKcXhmQXFSekN2TXBWOWNQcFhPZkhqT2hN?=
 =?utf-8?B?ZHZSdTVjdU1seDVCZTY3T2pqR3BtME5TYkhLNmlxeFNvRm1MWUozOFhuejVu?=
 =?utf-8?B?dFRNTmE0cGNHYWEwWFlzeEVMcjZabk1vSmhkaE05YVBmWDVCcXNxQkp0dUhD?=
 =?utf-8?B?eU9KK0o2N0lwc3hjbnBTbm4ybHJTdWVzZG80K0ROVXU2VUoxSUt6bG5GbjB1?=
 =?utf-8?B?dmVSazB2RGVyU2NsVlM0NEk3Q3VNVENOcktpQ2NReVUxc2lhcnR0VjV6a3J5?=
 =?utf-8?B?RFRXU2I0M0FuUWxzVUowRTZpWnhJSnNzeHQyaVgyYW1UVWE3NGpuYUllMmZw?=
 =?utf-8?B?TkJ6citoMGlaaitNWG5FVlgrTCs5VEszc2tURnFOT1BJN20wT0F0blNnWXRR?=
 =?utf-8?B?SVNmSlVaNFd0OEQxaXRGck5YM0s3VmN4Mmx4SjFobFUwcXVNcmlqZ3Z0dTRq?=
 =?utf-8?Q?U5PXtZrlaLr9kHlOKYR6shzg+?=
X-OriginatorOrg: mdpsys.co.uk
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c30b4d-b7d8-4750-8ea8-08dcd75278e7
X-MS-Exchange-CrossTenant-AuthSource: LO3P123MB2972.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 19:53:59.8241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 07eb37f3-62d1-4b5c-a7c4-ed2a24dbebc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pF5Sijjjceh7ha0cHQKluGA2mAYE4TE5A2UOCC8kDcEQ0di+TVXCH7WXj36ajBBhfwfTiTefEt4UhtOiZQrhWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P123MB7852

The 12/09/2024 07:09, Chris Lu (陸稚泓) wrote:
> On Tue, 2024-09-10 at 18:09 +0100, Marc Payne wrote:
> 
> Hi Marc,

Hi,

> 
> Is it possible to provide entire kernel log for further debugging?
> (From boot up to issue heppen)
> 
> We suspect that the issue occurred event earilier and our controller is
> not able to recover itself. Therfore, we need to check if Bluetooth
> works as expected in the booting stage.

Happy to help. Below is the log for a cold boot of Linux 6.11-rc7 (with
the additional patch to avoid the controller reset before fw load). The
MT7921AUN is directly connected to one of the computer's USB ports. The
system has an Intel AX211 fitted so I have disabled it's bluetooth
functionality in the UEFI setup.

Hope this helps.

> 
> BRs,
> Chris Lu

Regards,

Marc


[    0.000000] Linux version 6.11.0-rc7-00001-g0e2ad6528188-dirty (marcp@mdp-archnuc) (gcc (GCC) 14.2.1 20240805, GNU ld (GNU Binutils) 2.43.0) #71 SMP PREEMPT_DYNAMIC Mon Sep  9 23:22:56 BST 2024
[    0.000000] Command line: root=UUID=0420afc7-4947-4e2e-a096-b607b8b7fd93 rw quiet initrd=boot\intel-ucode.img initrd=boot\initramfs-linux611.img resume=UUID=0420afc7-4947-4e2e-a096-b607b8b7fd93 resume_offset=106496
[    0.000000] x86/split lock detection: #AC: crashing the kernel on kernel split_locks and warning on user-space split_locks
[    0.000000] BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000009dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000000009e000-0x000000000009efff] reserved
[    0.000000] BIOS-e820: [mem 0x000000000009f000-0x000000000009ffff] usable
[    0.000000] BIOS-e820: [mem 0x00000000000a0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000004dd45fff] usable
[    0.000000] BIOS-e820: [mem 0x000000004dd46000-0x0000000056c70fff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000056c71000-0x0000000056d48fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x0000000056d49000-0x0000000056ecefff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000056ecf000-0x000000005a7fefff] reserved
[    0.000000] BIOS-e820: [mem 0x000000005a7ff000-0x000000005a7fffff] usable
[    0.000000] BIOS-e820: [mem 0x000000005a800000-0x00000000611fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000061e00000-0x00000000687fffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000c0000000-0x00000000cfffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed20000-0x00000000fed7ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x00000010977fffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] APIC: Static calls initialized
[    0.000000] efi: EFI v2.8 by American Megatrends
[    0.000000] efi: ACPI=0x56e48000 ACPI 2.0=0x56e48014 TPMFinalLog=0x56db4000 SMBIOS=0x5a483000 SMBIOS 3.0=0x5a482000 MEMATTR=0x4485d118 ESRT=0x43ea7e98 INITRD=0x41e12e98 RNG=0x56c9b018 TPMEventLog=0x41dd5018 
[    0.000000] random: crng init done
[    0.000000] efi: Remove mem115: MMIO range=[0xc0000000-0xcfffffff] (256MB) from e820 map
[    0.000000] e820: remove [mem 0xc0000000-0xcfffffff] reserved
[    0.000000] efi: Not removing mem116: MMIO range=[0xfe000000-0xfe010fff] (68KB) from e820 map
[    0.000000] efi: Not removing mem117: MMIO range=[0xfec00000-0xfec00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem118: MMIO range=[0xfed00000-0xfed00fff] (4KB) from e820 map
[    0.000000] efi: Not removing mem120: MMIO range=[0xfee00000-0xfee00fff] (4KB) from e820 map
[    0.000000] efi: Remove mem121: MMIO range=[0xff000000-0xffffffff] (16MB) from e820 map
[    0.000000] e820: remove [mem 0xff000000-0xffffffff] reserved
[    0.000000] SMBIOS 3.5.0 present.
[    0.000000] DMI: Intel(R) Client Systems NUC12WSHi7/NUC12WSBi7, BIOS WSADL357.0088.2023.0505.1623 05/05/2023
[    0.000000] DMI: Memory slots populated: 2/2
[    0.000000] tsc: Detected 2500.000 MHz processor
[    0.000000] tsc: Detected 2496.000 MHz TSC
[    0.000549] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000550] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000555] last_pfn = 0x1097800 max_arch_pfn = 0x400000000
[    0.000558] MTRR map: 5 entries (3 fixed + 2 variable; max 23), built from 10 variable MTRRs
[    0.000559] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
[    0.000935] last_pfn = 0x5a800 max_arch_pfn = 0x400000000
[    0.014044] esrt: Reserving ESRT space from 0x0000000043ea7e98 to 0x0000000043ea7f98.
[    0.014049] e820: update [mem 0x43ea7000-0x43ea7fff] usable ==> reserved
[    0.014062] Using GB pages for direct mapping
[    0.014063] Incomplete global flushes, disabling PCID
[    0.014285] Secure boot disabled
[    0.014285] RAMDISK: [mem 0x39be8000-0x4039cfff]
[    0.014312] ACPI: Early table checksum verification disabled
[    0.014315] ACPI: RSDP 0x0000000056E48014 000024 (v02 INTEL )
[    0.014318] ACPI: XSDT 0x0000000056DE4728 000114 (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014322] ACPI: FACP 0x0000000056D46000 000114 (v06 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014326] ACPI: DSDT 0x0000000056CD9000 06CECF (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014328] ACPI: FACS 0x0000000056ECC000 000040
[    0.014329] ACPI: FIDT 0x0000000056CD8000 00009C (v01 INTEL  NUCxi7A5 00000058 AMI  00010013)
[    0.014331] ACPI: SSDT 0x0000000056D48000 00038C (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014333] ACPI: SSDT 0x0000000056CD2000 005D2C (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014335] ACPI: SSDT 0x0000000056CCF000 002AA1 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014337] ACPI: SSDT 0x0000000056CCB000 0033D3 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014339] ACPI: SSDT 0x0000000056CBD000 00D39F (v02 INTEL  NUCxi7A5 00001000 INTL 20200717)
[    0.014341] ACPI: HPET 0x0000000056D47000 000038 (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014343] ACPI: APIC 0x0000000056CBC000 0001DC (v05 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014344] ACPI: MCFG 0x0000000056CBB000 00003C (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014346] ACPI: SSDT 0x0000000056CB9000 001F04 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014348] ACPI: SSDT 0x0000000056CB7000 001DFD (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014350] ACPI: UEFI 0x0000000056D9B000 000048 (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014352] ACPI: NHLT 0x0000000056CB6000 0002F1 (v00 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014353] ACPI: LPIT 0x0000000056CB5000 0000CC (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014355] ACPI: WDAT 0x0000000056CB3000 000134 (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014357] ACPI: SSDT 0x0000000056CB0000 002A83 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014359] ACPI: SSDT 0x0000000056CAD000 002357 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014361] ACPI: DBGP 0x0000000056CAC000 000034 (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014363] ACPI: DBG2 0x0000000056CAB000 000054 (v00 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014364] ACPI: DMAR 0x0000000056CAA000 000088 (v02 INTEL  NUCxi7A5 00000058      01000013)
[    0.014366] ACPI: FPDT 0x0000000056CA9000 000044 (v01 INTEL  NUCxi7A5 00000058 AMI  01000013)
[    0.014368] ACPI: SSDT 0x0000000056CA8000 000D56 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014370] ACPI: SSDT 0x0000000056CA4000 003AEA (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014372] ACPI: SSDT 0x0000000056CA0000 0035A2 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014374] ACPI: SSDT 0x0000000056C9F000 000144 (v02 INTEL  NUCxi7A5 00000058 INTL 20200717)
[    0.014376] ACPI: BGRT 0x0000000056C9E000 000038 (v01 INTEL  NUCxi7A5 00000058 AMI  00010013)
[    0.014377] ACPI: TPM2 0x0000000056C9D000 00004C (v04 INTEL  NUCxi7A5 00000058 AMI  00000000)
[    0.014379] ACPI: PHAT 0x0000000056C9C000 00062D (v01 INTEL  NUCxi7A5 00000058 MSFT 0100000D)
[    0.014381] ACPI: WSMT 0x0000000056CB4000 000028 (v01 INTEL  NUCxi7A5 00000058 AMI  00010013)
[    0.014383] ACPI: Reserving FACP table memory at [mem 0x56d46000-0x56d46113]
[    0.014384] ACPI: Reserving DSDT table memory at [mem 0x56cd9000-0x56d45ece]
[    0.014384] ACPI: Reserving FACS table memory at [mem 0x56ecc000-0x56ecc03f]
[    0.014385] ACPI: Reserving FIDT table memory at [mem 0x56cd8000-0x56cd809b]
[    0.014386] ACPI: Reserving SSDT table memory at [mem 0x56d48000-0x56d4838b]
[    0.014386] ACPI: Reserving SSDT table memory at [mem 0x56cd2000-0x56cd7d2b]
[    0.014387] ACPI: Reserving SSDT table memory at [mem 0x56ccf000-0x56cd1aa0]
[    0.014387] ACPI: Reserving SSDT table memory at [mem 0x56ccb000-0x56cce3d2]
[    0.014388] ACPI: Reserving SSDT table memory at [mem 0x56cbd000-0x56cca39e]
[    0.014388] ACPI: Reserving HPET table memory at [mem 0x56d47000-0x56d47037]
[    0.014389] ACPI: Reserving APIC table memory at [mem 0x56cbc000-0x56cbc1db]
[    0.014389] ACPI: Reserving MCFG table memory at [mem 0x56cbb000-0x56cbb03b]
[    0.014390] ACPI: Reserving SSDT table memory at [mem 0x56cb9000-0x56cbaf03]
[    0.014390] ACPI: Reserving SSDT table memory at [mem 0x56cb7000-0x56cb8dfc]
[    0.014391] ACPI: Reserving UEFI table memory at [mem 0x56d9b000-0x56d9b047]
[    0.014391] ACPI: Reserving NHLT table memory at [mem 0x56cb6000-0x56cb62f0]
[    0.014392] ACPI: Reserving LPIT table memory at [mem 0x56cb5000-0x56cb50cb]
[    0.014392] ACPI: Reserving WDAT table memory at [mem 0x56cb3000-0x56cb3133]
[    0.014393] ACPI: Reserving SSDT table memory at [mem 0x56cb0000-0x56cb2a82]
[    0.014393] ACPI: Reserving SSDT table memory at [mem 0x56cad000-0x56caf356]
[    0.014394] ACPI: Reserving DBGP table memory at [mem 0x56cac000-0x56cac033]
[    0.014394] ACPI: Reserving DBG2 table memory at [mem 0x56cab000-0x56cab053]
[    0.014395] ACPI: Reserving DMAR table memory at [mem 0x56caa000-0x56caa087]
[    0.014395] ACPI: Reserving FPDT table memory at [mem 0x56ca9000-0x56ca9043]
[    0.014396] ACPI: Reserving SSDT table memory at [mem 0x56ca8000-0x56ca8d55]
[    0.014396] ACPI: Reserving SSDT table memory at [mem 0x56ca4000-0x56ca7ae9]
[    0.014397] ACPI: Reserving SSDT table memory at [mem 0x56ca0000-0x56ca35a1]
[    0.014397] ACPI: Reserving SSDT table memory at [mem 0x56c9f000-0x56c9f143]
[    0.014398] ACPI: Reserving BGRT table memory at [mem 0x56c9e000-0x56c9e037]
[    0.014398] ACPI: Reserving TPM2 table memory at [mem 0x56c9d000-0x56c9d04b]
[    0.014399] ACPI: Reserving PHAT table memory at [mem 0x56c9c000-0x56c9c62c]
[    0.014400] ACPI: Reserving WSMT table memory at [mem 0x56cb4000-0x56cb4027]
[    0.014743] No NUMA configuration found
[    0.014744] Faking a node at [mem 0x0000000000000000-0x00000010977fffff]
[    0.014746] NODE_DATA(0) allocated [mem 0x10977fb000-0x10977fffff]
[    0.014795] Zone ranges:
[    0.014796]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.014797]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.014798]   Normal   [mem 0x0000000100000000-0x00000010977fffff]
[    0.014799]   Device   empty
[    0.014799] Movable zone start for each node
[    0.014800] Early memory node ranges
[    0.014800]   node   0: [mem 0x0000000000001000-0x000000000009dfff]
[    0.014801]   node   0: [mem 0x000000000009f000-0x000000000009ffff]
[    0.014801]   node   0: [mem 0x0000000000100000-0x000000004dd45fff]
[    0.014802]   node   0: [mem 0x000000005a7ff000-0x000000005a7fffff]
[    0.014802]   node   0: [mem 0x0000000100000000-0x00000010977fffff]
[    0.014805] Initmem setup node 0 [mem 0x0000000000001000-0x00000010977fffff]
[    0.014808] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.014809] On node 0, zone DMA: 1 pages in unavailable ranges
[    0.014821] On node 0, zone DMA: 96 pages in unavailable ranges
[    0.015998] On node 0, zone DMA32: 19129 pages in unavailable ranges
[    0.078525] On node 0, zone Normal: 22528 pages in unavailable ranges
[    0.078536] On node 0, zone Normal: 2048 pages in unavailable ranges
[    0.078567] Reserving Intel graphics memory at [mem 0x64800000-0x687fffff]
[    0.080194] ACPI: PM-Timer IO Port: 0x1808
[    0.080199] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.080200] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.080200] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.080201] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.080201] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.080201] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.080202] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.080202] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.080203] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.080203] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.080203] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.080204] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.080204] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.080205] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.080205] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.080205] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.080206] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.080206] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.080207] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.080207] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.080207] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.080208] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.080208] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.080209] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.080291] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
[    0.080293] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.080294] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.080296] ACPI: Using ACPI (MADT) for SMP configuration information
[    0.080297] ACPI: HPET id: 0x8086a201 base: 0xfed00000
[    0.080302] e820: update [mem 0x444e6000-0x44584fff] usable ==> reserved
[    0.080309] TSC deadline timer available
[    0.080311] CPU topo: Max. logical packages:   1
[    0.080311] CPU topo: Max. logical dies:       1
[    0.080312] CPU topo: Max. dies per package:   1
[    0.080313] CPU topo: Max. threads per core:   2
[    0.080314] CPU topo: Num. cores per package:    12
[    0.080314] CPU topo: Num. threads per package:  16
[    0.080314] CPU topo: Allowing 16 present CPUs plus 0 hotplug CPUs
[    0.080325] PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.080326] PM: hibernation: Registered nosave memory: [mem 0x0009e000-0x0009efff]
[    0.080327] PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000fffff]
[    0.080328] PM: hibernation: Registered nosave memory: [mem 0x43ea7000-0x43ea7fff]
[    0.080329] PM: hibernation: Registered nosave memory: [mem 0x444e6000-0x44584fff]
[    0.080330] PM: hibernation: Registered nosave memory: [mem 0x4dd46000-0x56c70fff]
[    0.080330] PM: hibernation: Registered nosave memory: [mem 0x56c71000-0x56d48fff]
[    0.080331] PM: hibernation: Registered nosave memory: [mem 0x56d49000-0x56ecefff]
[    0.080331] PM: hibernation: Registered nosave memory: [mem 0x56ecf000-0x5a7fefff]
[    0.080332] PM: hibernation: Registered nosave memory: [mem 0x5a800000-0x611fffff]
[    0.080332] PM: hibernation: Registered nosave memory: [mem 0x61200000-0x61dfffff]
[    0.080333] PM: hibernation: Registered nosave memory: [mem 0x61e00000-0x687fffff]
[    0.080333] PM: hibernation: Registered nosave memory: [mem 0x68800000-0xfdffffff]
[    0.080333] PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
[    0.080334] PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
[    0.080334] PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
[    0.080334] PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfecfffff]
[    0.080335] PM: hibernation: Registered nosave memory: [mem 0xfed00000-0xfed00fff]
[    0.080335] PM: hibernation: Registered nosave memory: [mem 0xfed01000-0xfed1ffff]
[    0.080336] PM: hibernation: Registered nosave memory: [mem 0xfed20000-0xfed7ffff]
[    0.080336] PM: hibernation: Registered nosave memory: [mem 0xfed80000-0xfedfffff]
[    0.080336] PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
[    0.080337] PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xffffffff]
[    0.080338] [mem 0x68800000-0xfdffffff] available for PCI devices
[    0.080339] Booting paravirtualized kernel on bare hardware
[    0.080340] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
[    0.084163] setup_percpu: NR_CPUS:320 nr_cpumask_bits:16 nr_cpu_ids:16 nr_node_ids:1
[    0.084800] percpu: Embedded 66 pages/cpu s233472 r8192 d28672 u524288
[    0.084804] pcpu-alloc: s233472 r8192 d28672 u524288 alloc=1*2097152
[    0.084806] pcpu-alloc: [0] 00 01 02 03 [0] 04 05 06 07 
[    0.084809] pcpu-alloc: [0] 08 09 10 11 [0] 12 13 14 15 
[    0.084820] Kernel command line: root=UUID=0420afc7-4947-4e2e-a096-b607b8b7fd93 rw quiet initrd=boot\intel-ucode.img initrd=boot\initramfs-linux611.img resume=UUID=0420afc7-4947-4e2e-a096-b607b8b7fd93 resume_offset=106496
[    0.088825] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes, linear)
[    0.090830] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes, linear)
[    0.090938] Fallback order for Node 0: 0 
[    0.090940] Built 1 zonelists, mobility grouping on.  Total pages: 16667877
[    0.090941] Policy zone: Normal
[    0.091110] mem auto-init: stack:all(zero), heap alloc:on, heap free:off
[    0.091117] software IO TLB: area num 16.
[    0.174200] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=16, Nodes=1
[    0.174233] ftrace: allocating 50629 entries in 198 pages
[    0.178623] ftrace: allocated 198 pages with 4 groups
[    0.178673] Dynamic Preempt: full
[    0.178715] rcu: Preemptible hierarchical RCU implementation.
[    0.178716] rcu: 	RCU restricting CPUs from NR_CPUS=320 to nr_cpu_ids=16.
[    0.178716] rcu: 	RCU priority boosting: priority 1 delay 500 ms.
[    0.178717] 	Trampoline variant of Tasks RCU enabled.
[    0.178718] 	Rude variant of Tasks RCU enabled.
[    0.178718] 	Tracing variant of Tasks RCU enabled.
[    0.178718] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
[    0.178719] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=16
[    0.178727] RCU Tasks: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.178728] RCU Tasks Rude: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.178729] RCU Tasks Trace: Setting shift to 4 and lim to 1 rcu_task_cb_adjust=1.
[    0.181066] NR_IRQS: 20736, nr_irqs: 2184, preallocated irqs: 16
[    0.181413] rcu: srcu_init: Setting srcu_struct sizes based on contention.
[    0.181851] kfence: initialized - using 2097152 bytes for 255 objects at 0x(____ptrval____)-0x(____ptrval____)
[    0.181876] Console: colour dummy device 80x25
[    0.181878] printk: legacy console [tty0] enabled
[    0.181906] ACPI: Core revision 20240322
[    0.182096] hpet: HPET dysfunctional in PC10. Force disabled.
[    0.182097] APIC: Switch to symmetric I/O mode setup
[    0.182099] DMAR: Host address width 39
[    0.182099] DMAR: DRHD base: 0x000000fed90000 flags: 0x0
[    0.182103] DMAR: dmar0: reg_base_addr fed90000 ver 4:0 cap 1c0000c40660462 ecap 29a00f0505e
[    0.182104] DMAR: DRHD base: 0x000000fed91000 flags: 0x1
[    0.182107] DMAR: dmar1: reg_base_addr fed91000 ver 5:0 cap d2008c40660462 ecap f050da
[    0.182109] DMAR: RMRR base: 0x00000064000000 end: 0x000000687fffff
[    0.182111] DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
[    0.182112] DMAR-IR: HPET id 0 under DRHD base 0xfed91000
[    0.182112] DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.186032] DMAR-IR: Enabled IRQ remapping in x2apic mode
[    0.186034] x2apic enabled
[    0.186100] APIC: Switched APIC routing to: cluster x2apic
[    0.197380] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    0.197384] Calibrating delay loop (skipped), value calculated using timer frequency.. 4993.00 BogoMIPS (lpj=8320000)
[    0.197430] CPU0: Thermal monitoring enabled (TM1)
[    0.197431] x86/cpu: User Mode Instruction Prevention (UMIP) activated
[    0.197530] CET detected: Indirect Branch Tracking enabled
[    0.197532] Last level iTLB entries: 4KB 0, 2MB 0, 4MB 0
[    0.197532] Last level dTLB entries: 4KB 0, 2MB 0, 4MB 0, 1GB 0
[    0.197534] process: using mwait in idle threads
[    0.197536] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
[    0.197537] Spectre V2 : Mitigation: Enhanced / Automatic IBRS
[    0.197538] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
[    0.197538] Spectre V2 : Spectre v2 / PBRSB-eIBRS: Retire a single CALL on VMEXIT
[    0.197539] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
[    0.197540] Speculative Store Bypass: Mitigation: Speculative Store Bypass disabled via prctl
[    0.197541] Register File Data Sampling: Mitigation: Clear Register File
[    0.197547] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
[    0.197548] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
[    0.197548] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.197549] x86/fpu: Supporting XSAVE feature 0x200: 'Protection Keys User registers'
[    0.197549] x86/fpu: Supporting XSAVE feature 0x800: 'Control-flow User registers'
[    0.197550] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.197551] x86/fpu: xstate_offset[9]:  832, xstate_sizes[9]:    8
[    0.197551] x86/fpu: xstate_offset[11]:  840, xstate_sizes[11]:   16
[    0.197552] x86/fpu: Enabled xstate features 0xa07, context size is 856 bytes, using 'compacted' format.
[    0.200716] Freeing SMP alternatives memory: 40K
[    0.200716] pid_max: default: 32768 minimum: 301
[    0.200716] LSM: initializing lsm=capability,landlock,lockdown,yama,bpf
[    0.200716] landlock: Up and running.
[    0.200716] Yama: becoming mindful.
[    0.200716] LSM support for eBPF active
[    0.200716] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.200716] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes, linear)
[    0.200716] smpboot: CPU0: 12th Gen Intel(R) Core(TM) i7-1260P (family: 0x6, model: 0x9a, stepping: 0x3)
[    0.200716] Performance Events: XSAVE Architectural LBR, PEBS fmt4+-baseline,  AnyThread deprecated, Alderlake Hybrid events, 32-deep LBR, full-width counters, Intel PMU driver.
[    0.200716] core: cpu_core PMU driver: 
[    0.200716] ... version:                5
[    0.200716] ... bit width:              48
[    0.200716] ... generic registers:      8
[    0.200716] ... value mask:             0000ffffffffffff
[    0.200716] ... max period:             00007fffffffffff
[    0.200716] ... fixed-purpose events:   4
[    0.200716] ... event mask:             0001000f000000ff
[    0.200716] signal: max sigframe size: 3632
[    0.200716] Estimated ratio of average max frequency by base frequency (times 1024): 1556
[    0.200716] rcu: Hierarchical SRCU implementation.
[    0.200716] rcu: 	Max phase no-delay instances is 1000.
[    0.200716] Timer migration: 2 hierarchy levels; 8 children per group; 2 crossnode level
[    0.200716] NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
[    0.200716] smp: Bringing up secondary CPUs ...
[    0.200716] smpboot: x86: Booting SMP configuration:
[    0.200716] .... node  #0, CPUs:        #2  #4  #6  #8  #9 #10 #11 #12 #13 #14 #15
[    0.018930] core: cpu_atom PMU driver: PEBS-via-PT 
[    0.018930] ... version:                5
[    0.018930] ... bit width:              48
[    0.018930] ... generic registers:      6
[    0.018930] ... value mask:             0000ffffffffffff
[    0.018930] ... max period:             00007fffffffffff
[    0.018930] ... fixed-purpose events:   3
[    0.018930] ... event mask:             000000070000003f
[    0.210777]   #1  #3  #5  #7
[    0.215011] smp: Brought up 1 node, 16 CPUs
[    0.215011] smpboot: Total of 16 processors activated (79903.00 BogoMIPS)
[    0.217482] Memory: 65276284K/66671508K available (18432K kernel code, 2185K rwdata, 13516K rodata, 3452K init, 3432K bss, 1370520K reserved, 0K cma-reserved)
[    0.218690] devtmpfs: initialized
[    0.218690] x86/mm: Memory block size: 2048MB
[    0.218690] ACPI: PM: Registering ACPI NVS region [mem 0x56d49000-0x56ecefff] (1597440 bytes)
[    0.218690] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.218690] futex hash table entries: 4096 (order: 6, 262144 bytes, linear)
[    0.218690] pinctrl core: initialized pinctrl subsystem
[    0.218690] PM: RTC time: 15:43:42, date: 2024-09-17
[    0.218690] NET: Registered PF_NETLINK/PF_ROUTE protocol family
[    0.218690] DMA: preallocated 4096 KiB GFP_KERNEL pool for atomic allocations
[    0.218815] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA pool for atomic allocations
[    0.220935] DMA: preallocated 4096 KiB GFP_KERNEL|GFP_DMA32 pool for atomic allocations
[    0.220946] audit: initializing netlink subsys (disabled)
[    0.220955] audit: type=2000 audit(1726587822.023:1): state=initialized audit_enabled=0 res=1
[    0.220955] thermal_sys: Registered thermal governor 'fair_share'
[    0.220955] thermal_sys: Registered thermal governor 'bang_bang'
[    0.220955] thermal_sys: Registered thermal governor 'step_wise'
[    0.220955] thermal_sys: Registered thermal governor 'user_space'
[    0.220955] thermal_sys: Registered thermal governor 'power_allocator'
[    0.220955] cpuidle: using governor ladder
[    0.220955] cpuidle: using governor menu
[    0.220955] acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
[    0.220955] PCI: ECAM [mem 0xc0000000-0xcfffffff] (base 0xc0000000) for domain 0000 [bus 00-ff]
[    0.220955] PCI: Using configuration type 1 for base access
[    0.220955] kprobes: kprobe jump-optimization is enabled. All kprobes are optimized if possible.
[    0.224191] HugeTLB: registered 1.00 GiB page size, pre-allocated 0 pages
[    0.224191] HugeTLB: 16380 KiB vmemmap can be freed for a 1.00 GiB page
[    0.224191] HugeTLB: registered 2.00 MiB page size, pre-allocated 0 pages
[    0.224191] HugeTLB: 28 KiB vmemmap can be freed for a 2.00 MiB page
[    0.224500] ACPI: Added _OSI(Module Device)
[    0.224500] ACPI: Added _OSI(Processor Device)
[    0.224500] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.224500] ACPI: Added _OSI(Processor Aggregator Device)
[    0.312844] ACPI: 14 ACPI AML tables successfully acquired and loaded
[    0.336673] ACPI: USB4 _OSC: OS supports USB3+ DisplayPort+ PCIe+ XDomain+
[    0.336675] ACPI: USB4 _OSC: OS controls USB3+ DisplayPort+ PCIe+ XDomain+
[    0.338150] ACPI: Dynamic OEM Table Load:
[    0.338158] ACPI: SSDT 0xFFFF9118C178D400 000394 (v02 PmRef  Cpu0Cst  00003001 INTL 20200717)
[    0.339255] ACPI: Dynamic OEM Table Load:
[    0.339260] ACPI: SSDT 0xFFFF9118C1798000 0005E4 (v02 PmRef  Cpu0Ist  00003000 INTL 20200717)
[    0.340384] ACPI: Dynamic OEM Table Load:
[    0.340388] ACPI: SSDT 0xFFFF9118C2101200 0001AB (v02 PmRef  Cpu0Psd  00003000 INTL 20200717)
[    0.341453] ACPI: Dynamic OEM Table Load:
[    0.341457] ACPI: SSDT 0xFFFF9118C179B000 0004BA (v02 PmRef  Cpu0Hwp  00003000 INTL 20200717)
[    0.342940] ACPI: Dynamic OEM Table Load:
[    0.342947] ACPI: SSDT 0xFFFF9118C1784000 001BAF (v02 PmRef  ApIst    00003000 INTL 20200717)
[    0.344827] ACPI: Dynamic OEM Table Load:
[    0.344833] ACPI: SSDT 0xFFFF9118C1780000 001038 (v02 PmRef  ApHwp    00003000 INTL 20200717)
[    0.346435] ACPI: Dynamic OEM Table Load:
[    0.346441] ACPI: SSDT 0xFFFF9118C21C6000 001349 (v02 PmRef  ApPsd    00003000 INTL 20200717)
[    0.347383] ACPI: Dynamic OEM Table Load:
[    0.347383] ACPI: SSDT 0xFFFF9118C1797000 000FBB (v02 PmRef  ApCst    00003000 INTL 20200717)
[    0.351835] ACPI: EC: EC started
[    0.351836] ACPI: EC: interrupt blocked
[    0.352497] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    0.352499] ACPI: \_SB_.PC00.LPCB.EC0_: Boot DSDT EC used to handle transactions
[    0.352501] ACPI: Interpreter enabled
[    0.352548] ACPI: PM: (supports S0 S3 S4 S5)
[    0.352549] ACPI: Using IOAPIC for interrupt routing
[    0.353800] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.353801] PCI: Ignoring E820 reservations for host bridge windows
[    0.355184] ACPI: Enabled 7 GPEs in block 00 to 7F
[    0.357600] ACPI: \_SB_.PC00.PEG0.PXP_: New power resource
[    0.373986] ACPI: \_SB_.PC00.XHCI.RHUB.HS10.BTRT: New power resource
[    0.374768] ACPI: \_SB_.PC00.PAUD: New power resource
[    0.383767] ACPI: \_SB_.PC00.CNVW.WRST: New power resource
[    0.392041] ACPI: \_SB_.PC00.TBT0: New power resource
[    0.392349] ACPI: \_SB_.PC00.TBT1: New power resource
[    0.392651] ACPI: \_SB_.PC00.D3C_: New power resource
[    0.683890] ACPI: \_TZ_.FN00: New power resource
[    0.683946] ACPI: \_TZ_.FN01: New power resource
[    0.684000] ACPI: \_TZ_.FN02: New power resource
[    0.684056] ACPI: \_TZ_.FN03: New power resource
[    0.684110] ACPI: \_TZ_.FN04: New power resource
[    0.684638] ACPI: \PIN_: New power resource
[    0.685242] ACPI: PCI Root Bridge [PC00] (domain 0000 [bus 00-fe])
[    0.685248] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI EDR HPX-Type3]
[    0.686937] acpi PNP0A08:00: _OSC: platform does not support [AER]
[    0.690313] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug SHPCHotplug PME PCIeCapability LTR DPC]
[    0.692570] PCI host bridge to bus 0000:00
[    0.692573] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
[    0.692575] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
[    0.692576] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    0.692578] pci_bus 0000:00: root bus resource [mem 0x000e0000-0x000fffff window]
[    0.692579] pci_bus 0000:00: root bus resource [mem 0x68800000-0xbfffffff window]
[    0.692580] pci_bus 0000:00: root bus resource [mem 0x4000000000-0x7fffffffff window]
[    0.692581] pci_bus 0000:00: root bus resource [bus 00-fe]
[    0.692868] pci 0000:00:00.0: [8086:4621] type 00 class 0x060000 conventional PCI endpoint
[    0.693054] pci 0000:00:02.0: [8086:46a6] type 00 class 0x030000 PCIe Root Complex Integrated Endpoint
[    0.693062] pci 0000:00:02.0: BAR 0 [mem 0x603c000000-0x603cffffff 64bit]
[    0.693067] pci 0000:00:02.0: BAR 2 [mem 0x4000000000-0x400fffffff 64bit pref]
[    0.693070] pci 0000:00:02.0: BAR 4 [io  0x3000-0x303f]
[    0.693084] pci 0000:00:02.0: DMAR: Skip IOMMU disabling for graphics
[    0.693086] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    0.693109] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x00ffffff 64bit]
[    0.693110] pci 0000:00:02.0: VF BAR 0 [mem 0x00000000-0x06ffffff 64bit]: contains BAR 0 for 7 VFs
[    0.693114] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0x1fffffff 64bit pref]
[    0.693115] pci 0000:00:02.0: VF BAR 2 [mem 0x00000000-0xdfffffff 64bit pref]: contains BAR 2 for 7 VFs
[    0.693336] pci 0000:00:06.0: [8086:464d] type 01 class 0x060400 PCIe Root Port
[    0.693379] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.693412] pci 0000:00:06.0:   bridge window [mem 0x84600000-0x846fffff]
[    0.693547] pci 0000:00:06.0: PME# supported from D0 D3hot D3cold
[    0.693596] pci 0000:00:06.0: PTM enabled (root), 4ns granularity
[    0.694331] pci 0000:00:07.0: [8086:466e] type 01 class 0x060400 PCIe Root Port
[    0.694351] pci 0000:00:07.0: PCI bridge to [bus 02-39]
[    0.694355] pci 0000:00:07.0:   bridge window [mem 0x78000000-0x841fffff]
[    0.694361] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    0.694383] pci 0000:00:07.0: Overriding RP PIO Log Size to 4
[    0.694445] pci 0000:00:07.0: PME# supported from D0 D3hot D3cold
[    0.694469] pci 0000:00:07.0: PTM enabled (root), 4ns granularity
[    0.696553] pci 0000:00:07.2: [8086:462f] type 01 class 0x060400 PCIe Root Port
[    0.696570] pci 0000:00:07.2: PCI bridge to [bus 3a-63]
[    0.696574] pci 0000:00:07.2:   bridge window [mem 0x6a000000-0x761fffff]
[    0.696580] pci 0000:00:07.2:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    0.696602] pci 0000:00:07.2: Overriding RP PIO Log Size to 4
[    0.696664] pci 0000:00:07.2: PME# supported from D0 D3hot D3cold
[    0.696688] pci 0000:00:07.2: PTM enabled (root), 4ns granularity
[    0.698832] pci 0000:00:08.0: [8086:464f] type 00 class 0x088000 conventional PCI endpoint
[    0.698840] pci 0000:00:08.0: BAR 0 [mem 0x603d1bb000-0x603d1bbfff 64bit]
[    0.698934] pci 0000:00:0a.0: [8086:467d] type 00 class 0x118000 PCIe Root Complex Integrated Endpoint
[    0.698941] pci 0000:00:0a.0: BAR 0 [mem 0x603d1a0000-0x603d1a7fff 64bit]
[    0.698958] pci 0000:00:0a.0: enabling Extended Tags
[    0.699060] pci 0000:00:0d.0: [8086:461e] type 00 class 0x0c0330 conventional PCI endpoint
[    0.699069] pci 0000:00:0d.0: BAR 0 [mem 0x603d190000-0x603d19ffff 64bit]
[    0.699109] pci 0000:00:0d.0: PME# supported from D3hot D3cold
[    0.701032] pci 0000:00:0d.2: [8086:463e] type 00 class 0x0c0340 conventional PCI endpoint
[    0.701045] pci 0000:00:0d.2: BAR 0 [mem 0x603d140000-0x603d17ffff 64bit]
[    0.701051] pci 0000:00:0d.2: BAR 2 [mem 0x603d1ba000-0x603d1bafff 64bit]
[    0.701083] pci 0000:00:0d.2: supports D1 D2
[    0.701084] pci 0000:00:0d.2: PME# supported from D0 D1 D2 D3hot D3cold
[    0.701215] pci 0000:00:0d.3: [8086:466d] type 00 class 0x0c0340 conventional PCI endpoint
[    0.701225] pci 0000:00:0d.3: BAR 0 [mem 0x603d100000-0x603d13ffff 64bit]
[    0.701231] pci 0000:00:0d.3: BAR 2 [mem 0x603d1b9000-0x603d1b9fff 64bit]
[    0.701260] pci 0000:00:0d.3: supports D1 D2
[    0.701261] pci 0000:00:0d.3: PME# supported from D0 D1 D2 D3hot D3cold
[    0.701532] pci 0000:00:14.0: [8086:51ed] type 00 class 0x0c0330 conventional PCI endpoint
[    0.701555] pci 0000:00:14.0: BAR 0 [mem 0x603d180000-0x603d18ffff 64bit]
[    0.701655] pci 0000:00:14.0: PME# supported from D3hot D3cold
[    0.703595] pci 0000:00:14.2: [8086:51ef] type 00 class 0x050000 conventional PCI endpoint
[    0.703617] pci 0000:00:14.2: BAR 0 [mem 0x603d1b0000-0x603d1b3fff 64bit]
[    0.703631] pci 0000:00:14.2: BAR 2 [mem 0x603d1b8000-0x603d1b8fff 64bit]
[    0.703850] pci 0000:00:14.3: [8086:51f0] type 00 class 0x028000 PCIe Root Complex Integrated Endpoint
[    0.703912] pci 0000:00:14.3: BAR 0 [mem 0x603d1ac000-0x603d1affff 64bit]
[    0.707442] pci 0000:00:14.3: PME# supported from D0 D3hot D3cold
[    0.708349] pci 0000:00:15.0: [8086:51e8] type 00 class 0x0c8000 conventional PCI endpoint
[    0.709079] pci 0000:00:15.0: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.712769] pci 0000:00:15.1: [8086:51e9] type 00 class 0x0c8000 conventional PCI endpoint
[    0.713499] pci 0000:00:15.1: BAR 0 [mem 0x00000000-0x00000fff 64bit]
[    0.716748] pci 0000:00:16.0: [8086:51e0] type 00 class 0x078000 conventional PCI endpoint
[    0.716773] pci 0000:00:16.0: BAR 0 [mem 0x603d1b5000-0x603d1b5fff 64bit]
[    0.716868] pci 0000:00:16.0: PME# supported from D3hot
[    0.717491] pci 0000:00:17.0: [8086:51d3] type 00 class 0x010601 conventional PCI endpoint
[    0.717511] pci 0000:00:17.0: BAR 0 [mem 0x84700000-0x84701fff]
[    0.717522] pci 0000:00:17.0: BAR 1 [mem 0x84703000-0x847030ff]
[    0.717533] pci 0000:00:17.0: BAR 2 [io  0x3090-0x3097]
[    0.717543] pci 0000:00:17.0: BAR 3 [io  0x3080-0x3083]
[    0.717554] pci 0000:00:17.0: BAR 4 [io  0x3060-0x307f]
[    0.717564] pci 0000:00:17.0: BAR 5 [mem 0x84702000-0x847027ff]
[    0.717645] pci 0000:00:17.0: PME# supported from D3hot
[    0.718046] pci 0000:00:1d.0: [8086:51b0] type 01 class 0x060400 PCIe Root Port
[    0.718078] pci 0000:00:1d.0: PCI bridge to [bus 64]
[    0.718084] pci 0000:00:1d.0:   bridge window [mem 0x84400000-0x845fffff]
[    0.718173] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.718212] pci 0000:00:1d.0: PTM enabled (root), 4ns granularity
[    0.718877] pci 0000:00:1d.2: [8086:51b2] type 01 class 0x060400 PCIe Root Port
[    0.718909] pci 0000:00:1d.2: PCI bridge to [bus 65]
[    0.718915] pci 0000:00:1d.2:   bridge window [mem 0x84200000-0x843fffff]
[    0.719004] pci 0000:00:1d.2: PME# supported from D0 D3hot D3cold
[    0.719043] pci 0000:00:1d.2: PTM enabled (root), 4ns granularity
[    0.719752] pci 0000:00:1f.0: [8086:5182] type 00 class 0x060100 conventional PCI endpoint
[    0.720154] pci 0000:00:1f.3: [8086:51c8] type 00 class 0x040100 conventional PCI endpoint
[    0.720216] pci 0000:00:1f.3: BAR 0 [mem 0x603d1a8000-0x603d1abfff 64bit]
[    0.720290] pci 0000:00:1f.3: BAR 4 [mem 0x603d000000-0x603d0fffff 64bit]
[    0.720451] pci 0000:00:1f.3: PME# supported from D3hot D3cold
[    0.721057] pci 0000:00:1f.4: [8086:51a3] type 00 class 0x0c0500 conventional PCI endpoint
[    0.721086] pci 0000:00:1f.4: BAR 0 [mem 0x603d1b4000-0x603d1b40ff 64bit]
[    0.721112] pci 0000:00:1f.4: BAR 4 [io  0xefa0-0xefbf]
[    0.721397] pci 0000:00:1f.5: [8086:51a4] type 00 class 0x0c8000 conventional PCI endpoint
[    0.721419] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]
[    0.722353] pci 0000:01:00.0: [15b7:5030] type 00 class 0x010802 PCIe Endpoint
[    0.722365] pci 0000:01:00.0: BAR 0 [mem 0x84600000-0x84603fff 64bit]
[    0.722554] pci 0000:00:06.0: PCI bridge to [bus 01]
[    0.722587] pci 0000:00:07.0: PCI bridge to [bus 02-39]
[    0.722619] pci 0000:00:07.2: PCI bridge to [bus 3a-63]
[    0.722800] pci 0000:64:00.0: [8086:15f3] type 00 class 0x020000 PCIe Endpoint
[    0.722819] pci 0000:64:00.0: BAR 0 [mem 0x84400000-0x844fffff]
[    0.722844] pci 0000:64:00.0: BAR 3 [mem 0x84500000-0x84503fff]
[    0.722977] pci 0000:64:00.0: PME# supported from D0 D3hot D3cold
[    0.723313] pci 0000:00:1d.0: PCI bridge to [bus 64]
[    0.723788] pci 0000:65:00.0: [8086:125c] type 00 class 0x020000 PCIe Endpoint
[    0.723806] pci 0000:65:00.0: BAR 0 [mem 0x84200000-0x842fffff]
[    0.723831] pci 0000:65:00.0: BAR 3 [mem 0x84300000-0x84303fff]
[    0.723963] pci 0000:65:00.0: PME# supported from D0 D3hot D3cold
[    0.724773] pci 0000:00:1d.2: PCI bridge to [bus 65]
[    0.731129] ACPI: PCI: Interrupt link LNKA configured for IRQ 0
[    0.731229] ACPI: PCI: Interrupt link LNKB configured for IRQ 1
[    0.731327] ACPI: PCI: Interrupt link LNKC configured for IRQ 0
[    0.731425] ACPI: PCI: Interrupt link LNKD configured for IRQ 0
[    0.731523] ACPI: PCI: Interrupt link LNKE configured for IRQ 0
[    0.731621] ACPI: PCI: Interrupt link LNKF configured for IRQ 0
[    0.731719] ACPI: PCI: Interrupt link LNKG configured for IRQ 0
[    0.731816] ACPI: PCI: Interrupt link LNKH configured for IRQ 0
[    1.109516] Low-power S0 idle used by default for system suspend
[    1.116947] ACPI: EC: interrupt unblocked
[    1.116948] ACPI: EC: event unblocked
[    1.116974] ACPI: EC: EC_CMD/EC_SC=0x66, EC_DATA=0x62
[    1.116975] ACPI: EC: GPE=0x6e
[    1.116977] ACPI: \_SB_.PC00.LPCB.EC0_: Boot DSDT EC initialization complete
[    1.116978] ACPI: \_SB_.PC00.LPCB.EC0_: EC: Used to handle transactions and events
[    1.117430] iommu: Default domain type: Translated
[    1.117430] iommu: DMA domain TLB invalidation policy: lazy mode
[    1.117501] SCSI subsystem initialized
[    1.117507] libata version 3.00 loaded.
[    1.117507] ACPI: bus type USB registered
[    1.117507] usbcore: registered new interface driver usbfs
[    1.117507] usbcore: registered new interface driver hub
[    1.117507] usbcore: registered new device driver usb
[    1.117507] EDAC MC: Ver: 3.0.0
[    1.120822] efivars: Registered efivars operations
[    1.120945] NetLabel: Initializing
[    1.120946] NetLabel:  domain hash size = 128
[    1.120947] NetLabel:  protocols = UNLABELED CIPSOv4 CALIPSO
[    1.120965] NetLabel:  unlabeled traffic allowed by default
[    1.120970] mctp: management component transport protocol core
[    1.120971] NET: Registered PF_MCTP protocol family
[    1.120974] PCI: Using ACPI for IRQ routing
[    1.188171] PCI: pci_cache_line_size set to 64 bytes
[    1.189575] pci 0000:00:1f.5: BAR 0 [mem 0xfe010000-0xfe010fff]: can't claim; no compatible bridge window
[    1.190227] e820: reserve RAM buffer [mem 0x0009e000-0x0009ffff]
[    1.190229] e820: reserve RAM buffer [mem 0x43ea7000-0x43ffffff]
[    1.190230] e820: reserve RAM buffer [mem 0x444e6000-0x47ffffff]
[    1.190231] e820: reserve RAM buffer [mem 0x4dd46000-0x4fffffff]
[    1.190232] e820: reserve RAM buffer [mem 0x5a800000-0x5bffffff]
[    1.190233] e820: reserve RAM buffer [mem 0x1097800000-0x1097ffffff]
[    1.190766] pci 0000:00:02.0: vgaarb: setting as boot VGA device
[    1.190766] pci 0000:00:02.0: vgaarb: bridge control possible
[    1.190766] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
[    1.190766] vgaarb: loaded
[    1.190802] clocksource: Switched to clocksource tsc-early
[    1.191172] VFS: Disk quotas dquot_6.6.0
[    1.191181] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.191242] pnp: PnP ACPI init
[    1.191703] system 00:00: [io  0x0a00-0x0a0f] has been reserved
[    1.191706] system 00:00: [io  0x0a10-0x0a2f] has been reserved
[    1.191707] system 00:00: [io  0x0a30-0x0a4f] has been reserved
[    1.191708] system 00:00: [io  0x0a50-0x0a6f] has been reserved
[    1.191709] system 00:00: [io  0x0a70-0x0a7f] has been reserved
[    1.191710] system 00:00: [io  0x0a80-0x0a8f] has been reserved
[    1.191832] system 00:01: [io  0x0680-0x069f] has been reserved
[    1.191834] system 00:01: [io  0x164e-0x164f] has been reserved
[    1.191943] system 00:02: [io  0x1854-0x1857] has been reserved
[    1.192669] pnp 00:03: disabling [mem 0xc0000000-0xcfffffff] because it overlaps 0000:00:02.0 BAR 9 [mem 0x00000000-0xdfffffff 64bit pref]
[    1.192693] system 00:03: [mem 0xfedc0000-0xfedc7fff] has been reserved
[    1.192694] system 00:03: [mem 0xfeda0000-0xfeda0fff] has been reserved
[    1.192696] system 00:03: [mem 0xfeda1000-0xfeda1fff] has been reserved
[    1.192697] system 00:03: [mem 0xfed20000-0xfed7ffff] could not be reserved
[    1.192698] system 00:03: [mem 0xfed90000-0xfed93fff] could not be reserved
[    1.192699] system 00:03: [mem 0xfed45000-0xfed8ffff] could not be reserved
[    1.192700] system 00:03: [mem 0xfee00000-0xfeefffff] could not be reserved
[    1.195625] system 00:04: [io  0x2000-0x20fe] has been reserved
[    1.196381] pnp: PnP ACPI: found 6 devices
[    1.201970] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    1.202017] NET: Registered PF_INET protocol family
[    1.202177] IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
[    1.215397] tcp_listen_portaddr_hash hash table entries: 32768 (order: 7, 524288 bytes, linear)
[    1.215446] Table-perturb hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    1.215777] TCP established hash table entries: 524288 (order: 10, 4194304 bytes, linear)
[    1.216299] TCP bind hash table entries: 65536 (order: 9, 2097152 bytes, linear)
[    1.216406] TCP: Hash tables configured (established 524288 bind 65536)
[    1.216608] MPTCP token hash table entries: 65536 (order: 8, 1572864 bytes, linear)
[    1.216758] UDP hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    1.216899] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes, linear)
[    1.217011] NET: Registered PF_UNIX/PF_LOCAL protocol family
[    1.217017] NET: Registered PF_XDP protocol family
[    1.217024] pci 0000:00:07.0: bridge window [io  0x1000-0x0fff] to [bus 02-39] add_size 1000
[    1.217028] pci 0000:00:07.2: bridge window [io  0x1000-0x0fff] to [bus 3a-63] add_size 1000
[    1.217038] pci 0000:00:02.0: VF BAR 2 [mem 0x4020000000-0x40ffffffff 64bit pref]: assigned
[    1.217042] pci 0000:00:02.0: VF BAR 0 [mem 0x4010000000-0x4016ffffff 64bit]: assigned
[    1.217045] pci 0000:00:07.0: bridge window [io  0x4000-0x4fff]: assigned
[    1.217047] pci 0000:00:07.2: bridge window [io  0x5000-0x5fff]: assigned
[    1.217049] pci 0000:00:15.0: BAR 0 [mem 0x4017000000-0x4017000fff 64bit]: assigned
[    1.217395] pci 0000:00:15.1: BAR 0 [mem 0x4017001000-0x4017001fff 64bit]: assigned
[    1.217735] pci 0000:00:1f.5: BAR 0 [mem 0x68800000-0x68800fff]: assigned
[    1.217752] pci 0000:00:06.0: PCI bridge to [bus 01]
[    1.217777] pci 0000:00:06.0:   bridge window [mem 0x84600000-0x846fffff]
[    1.217810] pci 0000:00:07.0: PCI bridge to [bus 02-39]
[    1.217812] pci 0000:00:07.0:   bridge window [io  0x4000-0x4fff]
[    1.217814] pci 0000:00:07.0:   bridge window [mem 0x78000000-0x841fffff]
[    1.217817] pci 0000:00:07.0:   bridge window [mem 0x6020000000-0x603bffffff 64bit pref]
[    1.217820] pci 0000:00:07.2: PCI bridge to [bus 3a-63]
[    1.217821] pci 0000:00:07.2:   bridge window [io  0x5000-0x5fff]
[    1.217824] pci 0000:00:07.2:   bridge window [mem 0x6a000000-0x761fffff]
[    1.217826] pci 0000:00:07.2:   bridge window [mem 0x6000000000-0x601bffffff 64bit pref]
[    1.217830] pci 0000:00:1d.0: PCI bridge to [bus 64]
[    1.217848] pci 0000:00:1d.0:   bridge window [mem 0x84400000-0x845fffff]
[    1.217855] pci 0000:00:1d.2: PCI bridge to [bus 65]
[    1.217859] pci 0000:00:1d.2:   bridge window [mem 0x84200000-0x843fffff]
[    1.217867] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
[    1.217868] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
[    1.217869] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
[    1.217871] pci_bus 0000:00: resource 7 [mem 0x000e0000-0x000fffff window]
[    1.217872] pci_bus 0000:00: resource 8 [mem 0x68800000-0xbfffffff window]
[    1.217873] pci_bus 0000:00: resource 9 [mem 0x4000000000-0x7fffffffff window]
[    1.217874] pci_bus 0000:01: resource 1 [mem 0x84600000-0x846fffff]
[    1.217875] pci_bus 0000:02: resource 0 [io  0x4000-0x4fff]
[    1.217876] pci_bus 0000:02: resource 1 [mem 0x78000000-0x841fffff]
[    1.217877] pci_bus 0000:02: resource 2 [mem 0x6020000000-0x603bffffff 64bit pref]
[    1.217878] pci_bus 0000:3a: resource 0 [io  0x5000-0x5fff]
[    1.217879] pci_bus 0000:3a: resource 1 [mem 0x6a000000-0x761fffff]
[    1.217880] pci_bus 0000:3a: resource 2 [mem 0x6000000000-0x601bffffff 64bit pref]
[    1.217881] pci_bus 0000:64: resource 1 [mem 0x84400000-0x845fffff]
[    1.217883] pci_bus 0000:65: resource 1 [mem 0x84200000-0x843fffff]
[    1.219810] PCI: CLS 64 bytes, default 64
[    1.219841] DMAR: Intel-IOMMU force enabled due to platform opt in
[    1.219847] DMAR: No ATSR found
[    1.219848] DMAR: No SATC found
[    1.219849] DMAR: IOMMU feature fl1gp_support inconsistent
[    1.219850] DMAR: IOMMU feature pgsel_inv inconsistent
[    1.219851] DMAR: IOMMU feature nwfs inconsistent
[    1.219851] DMAR: IOMMU feature dit inconsistent
[    1.219852] DMAR: IOMMU feature sc_support inconsistent
[    1.219853] DMAR: IOMMU feature dev_iotlb_support inconsistent
[    1.219854] DMAR: dmar0: Using Queued invalidation
[    1.219857] DMAR: dmar1: Using Queued invalidation
[    1.219962] Trying to unpack rootfs image as initramfs...
[    1.220076] pci 0000:00:02.0: Adding to iommu group 0
[    1.220106] pci 0000:00:00.0: Adding to iommu group 1
[    1.220117] pci 0000:00:06.0: Adding to iommu group 2
[    1.220125] pci 0000:00:07.0: Adding to iommu group 3
[    1.220133] pci 0000:00:07.2: Adding to iommu group 4
[    1.220142] pci 0000:00:08.0: Adding to iommu group 5
[    1.220150] pci 0000:00:0a.0: Adding to iommu group 6
[    1.220165] pci 0000:00:0d.0: Adding to iommu group 7
[    1.220172] pci 0000:00:0d.2: Adding to iommu group 7
[    1.220178] pci 0000:00:0d.3: Adding to iommu group 7
[    1.220192] pci 0000:00:14.0: Adding to iommu group 8
[    1.220199] pci 0000:00:14.2: Adding to iommu group 8
[    1.220206] pci 0000:00:14.3: Adding to iommu group 9
[    1.220218] pci 0000:00:15.0: Adding to iommu group 10
[    1.220226] pci 0000:00:15.1: Adding to iommu group 10
[    1.220236] pci 0000:00:16.0: Adding to iommu group 11
[    1.220243] pci 0000:00:17.0: Adding to iommu group 12
[    1.220266] pci 0000:00:1d.0: Adding to iommu group 13
[    1.220282] pci 0000:00:1d.2: Adding to iommu group 14
[    1.220300] pci 0000:00:1f.0: Adding to iommu group 15
[    1.220308] pci 0000:00:1f.3: Adding to iommu group 15
[    1.220316] pci 0000:00:1f.4: Adding to iommu group 15
[    1.220323] pci 0000:00:1f.5: Adding to iommu group 15
[    1.220331] pci 0000:01:00.0: Adding to iommu group 16
[    1.220354] pci 0000:64:00.0: Adding to iommu group 17
[    1.220381] pci 0000:65:00.0: Adding to iommu group 18
[    1.220523] DMAR: Intel(R) Virtualization Technology for Directed I/O
[    1.220524] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.220525] software IO TLB: mapped [mem 0x00000000359f8000-0x00000000399f8000] (64MB)
[    1.220564] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x23fa772cf26, max_idle_ns: 440795269835 ns
[    1.220616] clocksource: Switched to clocksource tsc
[    1.220637] platform rtc_cmos: registered platform RTC device (no PNP device found)
[    1.227245] Initialise system trusted keyrings
[    1.227255] Key type blacklist registered
[    1.227295] workingset: timestamp_bits=41 max_order=24 bucket_order=0
[    1.227305] zbud: loaded
[    1.227417] fuse: init (API version 7.40)
[    1.227488] integrity: Platform Keyring initialized
[    1.227490] integrity: Machine keyring initialized
[    1.236155] Key type asymmetric registered
[    1.236158] Asymmetric key parser 'x509' registered
[    1.236181] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 246)
[    1.236262] io scheduler mq-deadline registered
[    1.236263] io scheduler kyber registered
[    1.236272] io scheduler bfq registered
[    1.236870] pcieport 0000:00:06.0: PME: Signaling with IRQ 122
[    1.237101] pcieport 0000:00:07.0: PME: Signaling with IRQ 123
[    1.237117] pcieport 0000:00:07.0: pciehp: Slot #3 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.237433] pcieport 0000:00:07.2: PME: Signaling with IRQ 124
[    1.237449] pcieport 0000:00:07.2: pciehp: Slot #5 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
[    1.237758] pcieport 0000:00:1d.0: PME: Signaling with IRQ 125
[    1.238027] pcieport 0000:00:1d.2: PME: Signaling with IRQ 126
[    1.238133] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    1.238900] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
[    1.238922] ACPI: button: Sleep Button [SLPB]
[    1.238952] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
[    1.238963] ACPI: button: Power Button [PWRB]
[    1.238982] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
[    1.239063] ACPI: button: Power Button [PWRF]
[    1.243545] thermal LNXTHERM:00: registered as thermal_zone0
[    1.243547] ACPI: thermal: Thermal Zone [TZ00] (54 C)
[    1.243835] Serial: 8250/16550 driver, 32 ports, IRQ sharing enabled
[    1.245729] hpet_acpi_add: no address or irqs in _CRS
[    1.245765] Non-volatile memory driver v1.3
[    1.245766] Linux agpgart interface v0.103
[    1.282118] ACPI: bus type drm_connector registered
[    1.283317] Freeing initrd memory: 106196K
[    1.284291] ahci 0000:00:17.0: version 3.0
[    1.284668] ahci 0000:00:17.0: AHCI vers 0001.0301, 32 command slots, 6 Gbps, SATA mode
[    1.284672] ahci 0000:00:17.0: 1/1 ports implemented (port mask 0x2)
[    1.284673] ahci 0000:00:17.0: flags: 64bit ncq sntf pm clo only pio slum part deso sadm sds 
[    1.285087] scsi host0: ahci
[    1.285169] scsi host1: ahci
[    1.285197] ata1: DUMMY
[    1.285212] ata2: SATA max UDMA/133 abar m2048@0x84702000 port 0x84702180 irq 127 lpm-pol 4
[    1.285284] usbcore: registered new interface driver usbserial_generic
[    1.285288] usbserial: USB Serial support registered for generic
[    1.285358] rtc_cmos rtc_cmos: RTC can wake from S4
[    1.287193] rtc_cmos rtc_cmos: registered as rtc0
[    1.287570] rtc_cmos rtc_cmos: setting system clock to 2024-09-17T15:43:43 UTC (1726587823)
[    1.287610] rtc_cmos rtc_cmos: alarms up to one month, y3k, 114 bytes nvram
[    1.288735] intel_pstate: Intel P-state driver initializing
[    1.290872] intel_pstate: HWP enabled
[    1.291430] ledtrig-cpu: registered to indicate activity on CPUs
[    1.291876] [drm] Initialized simpledrm 1.0.0 for simple-framebuffer.0 on minor 0
[    1.292353] fbcon: Deferring console take-over
[    1.292358] simple-framebuffer simple-framebuffer.0: [drm] fb0: simpledrmdrmfb frame buffer device
[    1.292419] hid: raw HID events driver (C) Jiri Kosina
[    1.292473] drop_monitor: Initializing network drop monitor service
[    1.292567] NET: Registered PF_INET6 protocol family
[    1.296692] Segment Routing with IPv6
[    1.296693] RPL Segment Routing with IPv6
[    1.296704] In-situ OAM (IOAM) with IPv6
[    1.296720] NET: Registered PF_PACKET protocol family
[    1.299178] ENERGY_PERF_BIAS: Set to 'normal', was 'performance'
[    1.299835] microcode: Current revision: 0x00000434
[    1.299839] microcode: Updated early from: 0x0000042a
[    1.300531] IPI shorthand broadcast: enabled
[    1.301773] sched_clock: Marking stable (1284914767, 15597475)->(1326242945, -25730703)
[    1.302178] registered taskstats version 1
[    1.303378] Loading compiled-in X.509 certificates
[    1.306147] Loaded X.509 cert 'Build time autogenerated kernel key: cb8a38269e411cf2cea941e3c19d1521412bd34d'
[    1.308962] zswap: loaded using pool zstd/zsmalloc
[    1.309007] Demotion targets for Node 0: null
[    1.309121] Key type .fscrypt registered
[    1.309121] Key type fscrypt-provisioning registered
[    1.309500] integrity: Loading X.509 certificate: UEFI:db
[    1.309544] integrity: Loaded X.509 cert 'Microsoft Corporation UEFI CA 2011: 13adbf4309bd82709c8cd54f316ed522988a1bd4'
[    1.309544] integrity: Loading X.509 certificate: UEFI:db
[    1.309551] integrity: Loaded X.509 cert 'Microsoft Windows Production PCA 2011: a92902398e16c49778cd90f99e4f9ae17c55af53'
[    1.309972] PM:   Magic number: 8:571:740
[    1.311885] RAS: Correctable Errors collector initialized.
[    1.599328] ata2: SATA link down (SStatus 4 SControl 300)
[    1.601308] clk: Disabling unused clocks
[    1.601325] PM: genpd: Disabling unused power domains
[    1.609973] Freeing unused decrypted memory: 2028K
[    1.610569] Freeing unused kernel image (initmem) memory: 3452K
[    1.610578] Write protecting the kernel read-only data: 32768k
[    1.611494] Freeing unused kernel image (rodata/data gap) memory: 820K
[    1.616342] x86/mm: Checked W+X mappings: passed, no W+X pages found.
[    1.616345] rodata_test: all tests were successful
[    1.616356] Run /init as init process
[    1.616357]   with arguments:
[    1.616357]     /init
[    1.616358]   with environment:
[    1.616358]     HOME=/
[    1.616359]     TERM=linux
[    1.738727] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.738738] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 1
[    1.739793] xhci_hcd 0000:00:0d.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[    1.740087] xhci_hcd 0000:00:0d.0: xHCI Host Controller
[    1.740090] xhci_hcd 0000:00:0d.0: new USB bus registered, assigned bus number 2
[    1.740093] xhci_hcd 0000:00:0d.0: Host supports USB 3.2 Enhanced SuperSpeed
[    1.740135] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.740139] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.740141] usb usb1: Product: xHCI Host Controller
[    1.740142] usb usb1: Manufacturer: Linux 6.11.0-rc7-00001-g0e2ad6528188-dirty xhci-hcd
[    1.740144] usb usb1: SerialNumber: 0000:00:0d.0
[    1.740282] hub 1-0:1.0: USB hub found
[    1.740289] hub 1-0:1.0: 1 port detected
[    1.740533] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.740535] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.740537] usb usb2: Product: xHCI Host Controller
[    1.740538] usb usb2: Manufacturer: Linux 6.11.0-rc7-00001-g0e2ad6528188-dirty xhci-hcd
[    1.740539] usb usb2: SerialNumber: 0000:00:0d.0
[    1.740628] hub 2-0:1.0: USB hub found
[    1.740635] hub 2-0:1.0: 3 ports detected
[    1.741581] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.741586] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 3
[    1.742720] xhci_hcd 0000:00:14.0: hcc params 0x20007fc1 hci version 0x120 quirks 0x0000100200009810
[    1.743083] xhci_hcd 0000:00:14.0: xHCI Host Controller
[    1.743087] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 4
[    1.743089] xhci_hcd 0000:00:14.0: Host supports USB 3.1 Enhanced SuperSpeed
[    1.743129] usb usb3: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 6.11
[    1.743131] usb usb3: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.743132] usb usb3: Product: xHCI Host Controller
[    1.743133] usb usb3: Manufacturer: Linux 6.11.0-rc7-00001-g0e2ad6528188-dirty xhci-hcd
[    1.743134] usb usb3: SerialNumber: 0000:00:14.0
[    1.743239] hub 3-0:1.0: USB hub found
[    1.743267] hub 3-0:1.0: 12 ports detected
[    1.745297] usb usb4: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 6.11
[    1.745299] usb usb4: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    1.745301] usb usb4: Product: xHCI Host Controller
[    1.745302] usb usb4: Manufacturer: Linux 6.11.0-rc7-00001-g0e2ad6528188-dirty xhci-hcd
[    1.745302] usb usb4: SerialNumber: 0000:00:14.0
[    1.745388] hub 4-0:1.0: USB hub found
[    1.745410] hub 4-0:1.0: 4 ports detected
[    1.761523] nvme 0000:01:00.0: platform quirk: setting simple suspend
[    1.761605] nvme nvme0: pci function 0000:01:00.0
[    1.791467] nvme nvme0: 16/0/0 default/read/poll queues
[    1.796102]  nvme0n1: p1 p2 p3
[    1.992401] usb 3-4: new high-speed USB device number 2 using xhci_hcd
[    2.134739] usb 3-4: New USB device found, idVendor=05e3, idProduct=0608, bcdDevice=88.32
[    2.134746] usb 3-4: New USB device strings: Mfr=0, Product=1, SerialNumber=0
[    2.134748] usb 3-4: Product: USB2.0 Hub
[    2.136254] hub 3-4:1.0: USB hub found
[    2.136751] hub 3-4:1.0: 4 ports detected
[    2.137612] usb: port power management may be unreliable
[    2.203731] usb 2-1: new SuperSpeed USB device number 2 using xhci_hcd
[    2.237657] usb 2-1: New USB device found, idVendor=045e, idProduct=0955, bcdDevice= 1.41
[    2.237662] usb 2-1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.237664] usb 2-1: Product: 4-Port USB 3.0 Hub
[    2.237665] usb 2-1: Manufacturer: Generic
[    2.245834] hub 2-1:1.0: USB hub found
[    2.247480] hub 2-1:1.0: 2 ports detected
[    2.255872] usb 4-1: new SuperSpeed USB device number 2 using xhci_hcd
[    2.275009] usb 4-1: New USB device found, idVendor=0e8d, idProduct=7961, bcdDevice= 1.00
[    2.275014] usb 4-1: New USB device strings: Mfr=6, Product=7, SerialNumber=8
[    2.275015] usb 4-1: Product: Wireless_Device
[    2.275017] usb 4-1: Manufacturer: MediaTek Inc.
[    2.275018] usb 4-1: SerialNumber: 000000000
[    2.395819] usb 3-6: new high-speed USB device number 3 using xhci_hcd
[    2.469827] i915 0000:00:02.0: [drm] Found ALDERLAKE_P (device ID 46a6) display version 13.00
[    2.470484] i915 0000:00:02.0: [drm] VT-d active for gfx access
[    2.526904] i915 0000:00:02.0: vgaarb: deactivate vga console
[    2.527166] i915 0000:00:02.0: [drm] Using Transparent Hugepages
[    2.529267] i915 0000:00:02.0: vgaarb: VGA decodes changed: olddecodes=io+mem,decodes=io+mem:owns=io+mem
[    2.534856] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/adlp_dmc.bin (v2.20)
[    2.535899] usb 2-1.1: new SuperSpeed USB device number 3 using xhci_hcd
[    2.557014] usb 3-6: New USB device found, idVendor=045e, idProduct=0957, bcdDevice= 1.41
[    2.557029] usb 3-6: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.557035] usb 3-6: Product: 4-Port USB 2.0 Hub
[    2.557039] usb 3-6: Manufacturer: Generic
[    2.557797] usb 2-1.1: New USB device found, idVendor=045e, idProduct=0927, bcdDevice=31.00
[    2.557814] usb 2-1.1: New USB device strings: Mfr=1, Product=2, SerialNumber=6
[    2.557819] usb 2-1.1: Product: Ethernet Adapter
[    2.557823] usb 2-1.1: Manufacturer: Microsoft
[    2.557826] usb 2-1.1: SerialNumber: 0013DF804
[    2.561404] hub 3-6:1.0: USB hub found
[    2.563028] hub 3-6:1.0: 2 ports detected
[    2.645045] i915 0000:00:02.0: [drm] GT0: GuC firmware i915/adlp_guc_70.bin version 70.29.2
[    2.645051] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin version 7.9.3
[    2.659283] i915 0000:00:02.0: [drm] GT0: HuC: authenticated for all workloads
[    2.660460] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
[    2.660462] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
[    2.661015] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
[    2.662137] i915 0000:00:02.0: [drm] Protected Xe Path (PXP) protected content support initialized
[    2.689226] usb 3-7: new full-speed USB device number 4 using xhci_hcd
[    2.695739] [drm] Initialized i915 1.6.0 for 0000:00:02.0 on minor 1
[    2.698285] ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
[    2.699207] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
[    2.737465] fbcon: i915drmfb (fb0) is primary device
[    2.737467] fbcon: Deferring console take-over
[    2.737468] i915 0000:00:02.0: [drm] fb0: i915drmfb frame buffer device
[    2.835767] usb 3-7: New USB device found, idVendor=045e, idProduct=0800, bcdDevice= 9.34
[    2.835772] usb 3-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.835773] usb 3-7: Product: Microsoft® Nano Transceiver v2.0
[    2.835775] usb 3-7: Manufacturer: Microsoft
[    2.857652] usbcore: registered new interface driver usbhid
[    2.857654] usbhid: USB HID core driver
[    2.862052] input: Microsoft Microsoft® Nano Transceiver v2.0 as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.0/0003:045E:0800.0001/input/input4
[    2.965962] hid-generic 0003:045E:0800.0001: input,hidraw0: USB HID v1.11 Keyboard [Microsoft Microsoft® Nano Transceiver v2.0] on usb-0000:00:14.0-7/input0
[    2.968229] input: Microsoft Microsoft® Nano Transceiver v2.0 Mouse as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.1/0003:045E:0800.0002/input/input5
[    2.968393] input: Microsoft Microsoft® Nano Transceiver v2.0 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.1/0003:045E:0800.0002/input/input6
[    2.968554] hid-generic 0003:045E:0800.0002: input,hidraw1: USB HID v1.11 Mouse [Microsoft Microsoft® Nano Transceiver v2.0] on usb-0000:00:14.0-7/input1
[    2.968700] input: Microsoft Microsoft® Nano Transceiver v2.0 Consumer Control as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.2/0003:045E:0800.0003/input/input7
[    3.022596] input: Microsoft Microsoft® Nano Transceiver v2.0 System Control as /devices/pci0000:00/0000:00:14.0/usb3/3-7/3-7:1.2/0003:045E:0800.0003/input/input9
[    3.022920] hid-generic 0003:045E:0800.0003: input,hiddev96,hidraw2: USB HID v1.11 Device [Microsoft Microsoft® Nano Transceiver v2.0] on usb-0000:00:14.0-7/input2
[    3.175304] PM: Image not found (code -22)
[    3.196942] fbcon: Taking over console
[    3.209556] Console: switching to colour frame buffer device 240x67
[    3.308676] EXT4-fs (nvme0n1p2): mounted filesystem 0420afc7-4947-4e2e-a096-b607b8b7fd93 r/w with ordered data mode. Quota mode: none.
[    3.367761] systemd[1]: systemd 256.6-1-arch running in system mode (+PAM +AUDIT -SELINUX -APPARMOR -IMA +SMACK +SECCOMP +GCRYPT +GNUTLS +OPENSSL +ACL +BLKID +CURL +ELFUTILS +FIDO2 +IDN2 -IDN +IPTC +KMOD +LIBCRYPTSETUP +LIBCRYPTSETUP_PLUGINS +LIBFDISK +PCRE2 +PWQUALITY +P11KIT +QRENCODE +TPM2 +BZIP2 +LZ4 +XZ +ZLIB +ZSTD +BPF_FRAMEWORK +XKBCOMMON +UTMP -SYSVINIT +LIBARCHIVE)
[    3.367765] systemd[1]: Detected architecture x86-64.
[    3.368553] systemd[1]: Hostname set to <mdp-archnuc>.
[    3.611164] systemd[1]: bpf-restrict-fs: LSM BPF program attached
[    3.699797] systemd[1]: Queued start job for default target Graphical Interface.
[    3.753107] systemd[1]: Created slice Slice /system/dirmngr.
[    3.753888] systemd[1]: Created slice Slice /system/getty.
[    3.754461] systemd[1]: Created slice Slice /system/gpg-agent.
[    3.755011] systemd[1]: Created slice Slice /system/gpg-agent-browser.
[    3.755524] systemd[1]: Created slice Slice /system/gpg-agent-extra.
[    3.755998] systemd[1]: Created slice Slice /system/gpg-agent-ssh.
[    3.756450] systemd[1]: Created slice Slice /system/keyboxd.
[    3.756684] systemd[1]: Created slice Slice /system/modprobe.
[    3.756803] systemd[1]: Created slice Slice /system/systemd-fsck.
[    3.756872] systemd[1]: Created slice User and Session Slice.
[    3.756893] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[    3.756908] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[    3.756982] systemd[1]: Set up automount Arbitrary Executable File Formats File System Automount Point.
[    3.756989] systemd[1]: Expecting device /dev/disk/by-uuid/EF7B-A70B...
[    3.756993] systemd[1]: Expecting device /dev/disk/by-uuid/efa73f2d-495d-448d-a0f0-dd425258b7e5...
[    3.756999] systemd[1]: Reached target Local Encrypted Volumes.
[    3.757005] systemd[1]: Reached target Login Prompts.
[    3.757011] systemd[1]: Reached target Local Integrity Protected Volumes.
[    3.757020] systemd[1]: Reached target Path Units.
[    3.757027] systemd[1]: Reached target Remote File Systems.
[    3.757031] systemd[1]: Reached target Slice Units.
[    3.757043] systemd[1]: Reached target Local Verity Protected Volumes.
[    3.757076] systemd[1]: Listening on Device-mapper event daemon FIFOs.
[    3.760193] systemd[1]: Listening on Process Core Dump Socket.
[    3.760919] systemd[1]: Listening on Credential Encryption/Decryption.
[    3.761003] systemd[1]: Listening on Journal Socket (/dev/log).
[    3.761058] systemd[1]: Listening on Journal Sockets.
[    3.761093] systemd[1]: TPM PCR Measurements was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    3.761109] systemd[1]: Make TPM PCR Policy was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    3.761165] systemd[1]: Listening on udev Control Socket.
[    3.761202] systemd[1]: Listening on udev Kernel Socket.
[    3.762311] systemd[1]: Mounting Huge Pages File System...
[    3.763074] systemd[1]: Mounting POSIX Message Queue File System...
[    3.763792] systemd[1]: Mounting Kernel Debug File System...
[    3.764350] systemd[1]: Mounting Kernel Trace File System...
[    3.765317] systemd[1]: Starting Create List of Static Device Nodes...
[    3.766158] systemd[1]: Starting Load Kernel Module configfs...
[    3.766682] systemd[1]: Starting Load Kernel Module dm_mod...
[    3.767934] systemd[1]: Starting Load Kernel Module drm...
[    3.769088] systemd[1]: Starting Load Kernel Module fuse...
[    3.770335] systemd[1]: Starting Load Kernel Module loop...
[    3.770384] systemd[1]: File System Check on Root Device was skipped because of an unmet condition check (ConditionPathIsReadWrite=!/).
[    3.770425] systemd[1]: Clear Stale Hibernate Storage Info was skipped because of an unmet condition check (ConditionPathExists=/sys/firmware/efi/efivars/HibernateLocation-8cf2644b-4b0b-428f-9387-6d876050dc67).
[    3.772057] systemd[1]: Starting Journal Service...
[    3.772971] systemd[1]: Starting Load Kernel Modules...
[    3.772986] systemd[1]: TPM PCR Machine ID Measurement was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    3.773641] systemd[1]: Starting Remount Root and Kernel File Systems...
[    3.773677] systemd[1]: Early TPM SRK Setup was skipped because of an unmet condition check (ConditionSecurity=measured-uki).
[    3.774224] systemd[1]: Starting Load udev Rules from Credentials...
[    3.774948] systemd[1]: Starting Coldplug All udev Devices...
[    3.777379] systemd[1]: Mounted Huge Pages File System.
[    3.777453] systemd[1]: Mounted POSIX Message Queue File System.
[    3.777510] systemd[1]: Mounted Kernel Debug File System.
[    3.777561] systemd[1]: Mounted Kernel Trace File System.
[    3.777759] systemd[1]: Finished Create List of Static Device Nodes.
[    3.777978] systemd[1]: modprobe@configfs.service: Deactivated successfully.
[    3.778112] systemd[1]: Finished Load Kernel Module configfs.
[    3.778286] systemd[1]: modprobe@drm.service: Deactivated successfully.
[    3.778411] systemd[1]: Finished Load Kernel Module drm.
[    3.778575] systemd[1]: modprobe@fuse.service: Deactivated successfully.
[    3.778688] systemd[1]: Finished Load Kernel Module fuse.
[    3.779305] systemd[1]: Mounting FUSE Control File System...
[    3.780063] systemd[1]: Mounting Kernel Configuration File System...
[    3.780929] systemd[1]: Starting Create Static Device Nodes in /dev gracefully...
[    3.782976] systemd[1]: Finished Load udev Rules from Credentials.
[    3.783391] loop: module loaded
[    3.784044] systemd[1]: modprobe@loop.service: Deactivated successfully.
[    3.784330] systemd[1]: Finished Load Kernel Module loop.
[    3.785492] systemd[1]: Mounted FUSE Control File System.
[    3.785629] systemd[1]: Mounted Kernel Configuration File System.
[    3.785810] systemd-journald[395]: Collecting audit messages is disabled.
[    3.798212] i2c_dev: i2c /dev entries driver
[    3.799115] systemd[1]: Finished Load Kernel Modules.
[    3.799850] systemd[1]: Starting Apply Kernel Variables...
[    3.799991] device-mapper: uevent: version 1.0.3
[    3.800058] device-mapper: ioctl: 4.48.0-ioctl (2023-03-01) initialised: dm-devel@lists.linux.dev
[    3.800371] systemd[1]: modprobe@dm_mod.service: Deactivated successfully.
[    3.800462] systemd[1]: Finished Load Kernel Module dm_mod.
[    3.800633] systemd[1]: Repartition Root Disk was skipped because no trigger condition checks were met.
[    3.805467] systemd[1]: Finished Create Static Device Nodes in /dev gracefully.
[    3.806389] systemd[1]: Finished Apply Kernel Variables.
[    3.806887] systemd[1]: Started Journal Service.
[    3.832625] EXT4-fs (nvme0n1p2): re-mounted 0420afc7-4947-4e2e-a096-b607b8b7fd93 r/w. Quota mode: none.
[    3.840126] systemd-journald[395]: Received client request to flush runtime journal.
[    3.843896] Adding 67108860k swap on /swapfile.  Priority:-2 extents:86 across:334987260k SS
[    3.946711] mc: Linux media interface: v0.10
[    3.950655] mousedev: PS/2 mouse device common for all mice
[    3.971833] resource: resource sanity check: requesting [mem 0x00000000fedc0000-0x00000000fedcffff], which spans more than pnp 00:03 [mem 0xfedc0000-0xfedc7fff]
[    3.971839] caller igen6_probe+0x15e/0x7c0 [igen6_edac] mapping multiple BARs
[    3.975353] EDAC MC0: Giving out device to module igen6_edac controller Intel_client_SoC MC#0: DEV 0000:00:00.0 (INTERRUPT)
[    3.975402] EDAC MC1: Giving out device to module igen6_edac controller Intel_client_SoC MC#1: DEV 0000:00:00.0 (INTERRUPT)
[    3.975427] EDAC igen6 MC0: HANDLING IBECC MEMORY ERROR
[    3.975428] EDAC igen6 MC0: ADDR 0x7fffffffe0 
[    3.975454] intel_pmc_core INT33A1:00:  initialized
[    3.975552] EDAC igen6 MC1: HANDLING IBECC MEMORY ERROR
[    3.975556] EDAC igen6 MC1: ADDR 0x7fffffffe0 
[    3.976644] EDAC igen6: v2.5.1
[    3.985687] videodev: Linux video capture interface: v2.00
[    3.985762] pps_core: LinuxPPS API ver. 1 registered
[    3.985765] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    3.988981] input: PC Speaker as /devices/platform/pcspkr/input/input10
[    3.996243] PTP clock support registered
[    3.999181] mei_me 0000:00:16.0: enabling device (0000 -> 0002)
[    4.000730] i801_smbus 0000:00:1f.4: enabling device (0000 -> 0003)
[    4.001128] i801_smbus 0000:00:1f.4: SPD Write Disable is set
[    4.001184] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
[    4.004969] i2c i2c-13: Successfully instantiated SPD at 0x50
[    4.008414] intel-lpss 0000:00:15.0: enabling device (0004 -> 0006)
[    4.008861] idma64 idma64.0: Found Intel integrated DMA 64-bit
[    4.027139] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: IRQ index 1 not found
[    4.027145] Serial bus multi instantiate pseudo device driver INT3515:00: error -ENXIO: Error requesting irq at index 1
[    4.029512] ACPI: bus type thunderbolt registered
[    4.032631] Intel(R) 2.5G Ethernet Linux Driver
[    4.032634] Copyright(c) 2018 Intel Corporation.
[    4.032751] igc 0000:64:00.0: enabling device (0000 -> 0002)
[    4.033014] igc 0000:64:00.0: PTM enabled, 4ns granularity
[    4.038479] intel-lpss 0000:00:15.1: enabling device (0004 -> 0006)
[    4.038818] idma64 idma64.1: Found Intel integrated DMA 64-bit
[    4.047090] Creating 1 MTD partitions on "0000:00:1f.5":
[    4.047094] 0x000000000000-0x000002000000 : "BIOS"
[    4.079742] pps pps0: new PPS source ptp0
[    4.079786] igc 0000:64:00.0 (unnamed net_device) (uninitialized): PHC added
[    4.082583] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
[    4.082586] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
[    4.082588] RAPL PMU: hw unit of domain package 2^-14 Joules
[    4.082588] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
[    4.082589] RAPL PMU: hw unit of domain psys 2^-14 Joules
[    4.083350] usbcore: registered new device driver r8152-cfgselector
[    4.107228] cryptd: max_cpu_qlen set to 1000
[    4.107196] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
[    4.107949] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
[    4.109214] ee1004 13-0050: 512 byte EE1004-compliant SPD EEPROM, read-only
[    4.172477] r8152-cfgselector 2-1.1: reset SuperSpeed USB device number 3 using xhci_hcd
[    4.187010] Bluetooth: Core ver 2.22
[    4.187025] NET: Registered PF_BLUETOOTH protocol family
[    4.187026] Bluetooth: HCI device and connection manager initialized
[    4.187032] Bluetooth: HCI socket layer initialized
[    4.187034] Bluetooth: L2CAP socket layer initialized
[    4.187036] Bluetooth: SCO socket layer initialized
[    4.191558] igc 0000:64:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    4.191562] igc 0000:64:00.0 eth0: MAC: XX:XX:XX:XX:XX:XX
[    4.191837] cfg80211: Loading compiled-in X.509 certificates for regulatory database
[    4.191998] igc 0000:65:00.0: enabling device (0000 -> 0002)
[    4.192549] igc 0000:65:00.0: PTM enabled, 4ns granularity
[    4.193238] AES CTR mode by8 optimization enabled
[    4.194837] Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    4.195017] Loaded X.509 cert 'wens: 61c038651aabdcf94bd0ac7ff06c7248db18c600'
[    4.214394] snd_hda_intel 0000:00:1f.3: enabling device (0000 -> 0002)
[    4.214598] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops i915_audio_component_bind_ops [i915])
[    4.223182] usbcore: registered new interface driver btusb
[    4.224896] Bluetooth: hci0: HW/SW Version: 0x008a008a, Build Time: 20240826151221
[    4.243090] pps pps1: new PPS source ptp1
[    4.243291] igc 0000:65:00.0 (unnamed net_device) (uninitialized): PHC added
[    4.245647] r8152 2-1.1:1.0 eth1: v1.12.13
[    4.245683] usbcore: registered new interface driver r8152
[    4.261881] usbcore: registered new interface driver cdc_ether
[    4.272727] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC269VB: line_outs=1 (0x21/0x0/0x0/0x0/0x0) type:hp
[    4.272733] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.272735] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[    4.272737] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
[    4.272738] snd_hda_codec_realtek hdaudioC0D0:    inputs:
[    4.272739] snd_hda_codec_realtek hdaudioC0D0:      Mic=0x18
[    4.283158] igc 0000:65:00.0: 4.000 Gb/s available PCIe bandwidth (5.0 GT/s PCIe x1 link)
[    4.283163] igc 0000:65:00.0 eth2: MAC: XX:XX:XX:XX:XX:XX
[    4.285711] igc 0000:64:00.0 enp100s0: renamed from eth0
[    4.303471] Intel(R) Wireless WiFi driver for Linux
[    4.303618] iwlwifi 0000:00:14.3: enabling device (0000 -> 0002)
[    4.306032] iwlwifi 0000:00:14.3: Detected crf-id 0x400410, cnv-id 0x80400 wfpm id 0x80000020
[    4.306074] iwlwifi 0000:00:14.3: PCI dev 51f0/0094, rev=0x370, rfid=0x2010d000
[    4.306077] iwlwifi 0000:00:14.3: Detected Intel(R) Wi-Fi 6E AX211 160MHz
[    4.310525] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ Version: 0.0.2.42
[    4.310859] iwlwifi 0000:00:14.3: loaded firmware version 89.202a2f7b.0 so-a0-gf-a0-89.ucode op_mode iwlmvm
[    4.317505] r8152 2-1.1:1.0 enp0s13f0u1u1: renamed from eth1
[    4.317848] igc 0000:65:00.0 enp101s0: renamed from eth2
[    4.326705] input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
[    4.326777] input: HDA Intel PCH Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
[    4.326832] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
[    4.326873] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
[    4.326939] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input15
[    4.326994] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input16
[    4.430414] intel_tcc_cooling: TCC Offset locked
[    4.555399] intel_rapl_msr: PL4 support detected.
[    4.555425] intel_rapl_common: Found RAPL domain package
[    4.555428] intel_rapl_common: Found RAPL domain core
[    4.555429] intel_rapl_common: Found RAPL domain uncore
[    4.555431] intel_rapl_common: Found RAPL domain psys
[    4.613360] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    4.613411] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    4.613418] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    4.613426] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    4.613723] iwlwifi 0000:00:14.3: loaded PNVM version 35148b80
[    4.614836] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    4.630016] iwlwifi 0000:00:14.3: Detected RF GF, rfid=0x2010d000
[    4.700769] iwlwifi 0000:00:14.3: base HW address: XX:XX:XX:XX:XX:XX
[    4.833421] iwlwifi 0000:00:14.3 wlo1: renamed from wlan0
[    5.452456] EXT4-fs (nvme0n1p3): mounted filesystem efa73f2d-495d-448d-a0f0-dd425258b7e5 r/w with ordered data mode. Quota mode: none.
[    5.661641] Bluetooth: BNEP (Ethernet Emulation) ver 1.3
[    5.661644] Bluetooth: BNEP filters: protocol multicast
[    5.661647] Bluetooth: BNEP socket layer initialized
[    5.925867] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    5.925877] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    5.925885] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    5.925893] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    5.927244] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    6.019702] iwlwifi 0000:00:14.3: Registered PHC clock: iwlwifi-PTP, with index: 2
[    6.248772] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x20
[    6.248782] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x1f
[    6.248790] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
[    6.248798] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x0
[    6.250128] iwlwifi 0000:00:14.3: RFIm is deactivated, reason = 4
[    7.025262] Bluetooth: hci0: Device setup in 2736415 usecs
[    7.025270] Bluetooth: hci0: HCI Enhanced Setup Synchronous Connection command is advertised, but not supported.
[    7.466021] usbcore: registered new interface driver option
[    7.466030] usbserial: USB Serial support registered for GSM modem (1-port)
[    8.318933] Bluetooth: hci0: Mediatek coredump end
[    8.566804] igc 0000:64:00.0 enp100s0: NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[    9.199113] Bluetooth: hci0: Mediatek coredump end
[    9.209081] Bluetooth: hci0: Opcode 0x0c03 failed: -110
[   11.342488] Bluetooth: hci0: Failed to read MSFT supported features (-110)
[   13.455279] block nvme0n1: No UUID available providing old NGUID
[   13.478988] Bluetooth: hci0: AOSP get vendor capabilities (-110)
[   16.117052] wlo1: regulatory prevented using AP config, downgraded
[   16.123049] wlo1: authenticate with XX:XX:XX:XX:XX:XX (local address=XX:XX:XX:XX:XX:XX)
[   16.124244] wlo1: send auth to XX:XX:XX:XX:XX:XX (try 1/3)
[   16.166021] wlo1: authenticated
[   16.172421] wlo1: associate with XX:XX:XX:XX:XX:XX (try 1/3)
[   16.174455] wlo1: RX AssocResp from XX:XX:XX:XX:XX:XX (capab=0x111 status=0 aid=1)
[   16.184782] wlo1: associated
[   16.246848] wlo1: Limiting TX power to 23 (26 - 3) dBm as advertised by XX:XX:XX:XX:XX:XX
[   17.488650] warning: `ThreadPoolForeg' uses wireless extensions which will stop working for Wi-Fi 7 hardware; use nl80211
[   17.531765] platform INT3515:01: deferred probe pending: Serial bus multi instantiate pseudo device driver: Error creating i2c-client, idx 0
[   17.531769] platform INT3515:02: deferred probe pending: Serial bus multi instantiate pseudo device driver: Error creating i2c-client, idx 0
[   18.595698] usb 4-1: Disable of device-initiated U1 failed.
[   23.715878] usb 4-1: Disable of device-initiated U2 failed.
[   33.956071] Bluetooth: hci0: Failed to write uhw reg(-110)
[   33.956138] usb 4-1: Disable of device-initiated U2 failed.
[   39.293677] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   44.634497] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   44.841067] usb 4-1: device not accepting address 2, error -62
[   50.186371] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   55.523585] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   55.729841] usb 4-1: device not accepting address 2, error -62
[   61.072634] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   66.407700] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   66.614207] usb 4-1: device not accepting address 2, error -62
[   71.955541] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   77.289925] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   77.496512] usb 4-1: device not accepting address 2, error -62
[   77.513500] usb 4-1: USB disconnect, device number 2
[   82.837128] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   88.171049] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   88.377554] usb 4-1: device not accepting address 3, error -62
[   93.718045] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   99.051387] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[   99.258078] usb 4-1: device not accepting address 4, error -62
[   99.266739] usb usb4-port1: attempt power cycle
[  106.518206] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  111.851387] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  112.057840] usb 4-1: device not accepting address 5, error -62
[  117.397862] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  122.732729] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[  122.937708] usb 4-1: device not accepting address 6, error -62
[  122.944587] usb usb4-port1: unable to enumerate USB device



> 
> >  	 
> > External email : Please do not click links or open attachments until
> > you have verified the sender or the content.
> >  Hi,
> > 
> > The 22/08/2024 13:23, Hao Qin wrote:
> > > Remove resetting mt7921 before downloading the fw, as it may cause
> > > command timeout when performing the reset.
> > > 
> > > Signed-off-by: Hao Qin <hao.qin@mediatek.com>
> > > ---
> > >  drivers/bluetooth/btmtk.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> > > index 2b7c80043aa2..a46f70135cbd 100644
> > > --- a/drivers/bluetooth/btmtk.c
> > > +++ b/drivers/bluetooth/btmtk.c
> > > @@ -1326,7 +1326,6 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> > >  fwname = FIRMWARE_MT7668;
> > >  break;
> > >  case 0x7922:
> > > -case 0x7961:
> > >  case 0x7925:
> > >  /* Reset the device to ensure it's in the initial state before
> > >   * downloading the firmware to ensure.
> > > @@ -1334,7 +1333,8 @@ int btmtk_usb_setup(struct hci_dev *hdev)
> > >  
> > >  if (!test_bit(BTMTK_FIRMWARE_LOADED, &btmtk_data->flags))
> > >  btmtk_usb_subsys_reset(hdev, dev_id);
> > > -
> > > +fallthrough;
> > > +case 0x7961:
> > >  btmtk_fw_get_filename(fw_bin_name, sizeof(fw_bin_name), dev_id,
> > >        fw_version, fw_flavor);
> > >  
> > > -- 
> > > 2.18.0
> > > 
> > 
> > [Original regression report
> > 
> https://lore.kernel.org/linux-bluetooth/ZsTh7Jyug7MbZsLE@mdpsys.co.uk/
> > ]
> > 
> > Thanks for the patch, I have tested it on top of v6.11-rc7 and can
> > confirm
> > that it resolves the initial command timeout issue.
> > 
> > Unfortunately, when using the latest firmware version 20240826151221
> > from the
> > linux-firmware repo I'm still seeing "Mediatek coredump end" errors
> > followed by MSFT and AOSP errors. The device then appears
> > unresponsive
> > and the kernel eventually gives up attempting to enumerate:
> > 
> > [  230.042936] usb 4-3.2: new SuperSpeed USB device number 4 using
> > xhci_hcd
> > [  230.065228] usb 4-3.2: New USB device found, idVendor=0e8d,
> > idProduct=7961, bcdDevice= 1.00
> > [  230.065237] usb 4-3.2: New USB device strings: Mfr=6, Product=7,
> > SerialNumber=8
> > [  230.065240] usb 4-3.2: Product: Wireless_Device
> > [  230.065242] usb 4-3.2: Manufacturer: MediaTek Inc.
> > [  230.065245] usb 4-3.2: SerialNumber: 000000000
> > [  230.101915] Bluetooth: hci2: HW/SW Version: 0x008a008a, Build
> > Time: 20240826151221
> > [  233.005938] Bluetooth: hci2: Device setup in 2862056 usecs
> > [  233.005983] Bluetooth: hci2: HCI Enhanced Setup Synchronous
> > Connection command is advertised, but not supported.
> > [  234.306071] Bluetooth: hci2: Mediatek coredump end
> > [  235.092729] Bluetooth: hci2: Opcode 0x0c03 failed: -110
> > [  235.192772] Bluetooth: hci2: Mediatek coredump end
> > [  237.226157] Bluetooth: hci2: Failed to read MSFT supported
> > features (-110)
> > [  239.359435] Bluetooth: hci2: AOSP get vendor capabilities (-110)
> > [  244.479726] usb 4-3.2: Disable of device-initiated U1 failed.
> > [  249.599598] usb 4-3.2: Disable of device-initiated U2 failed.
> > [  259.839215] Bluetooth: hci2: Failed to write uhw reg(-110)
> > [  259.839240] usb 4-3.2: Disable of device-initiated U1 failed.
> > [  264.959343] usb 4-3.2: Disable of device-initiated U2 failed.
> > [  270.079038] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  275.412299] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  275.618812] usb 4-3.2: device not accepting address 4, error -62
> > [  280.958852] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  286.292034] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  286.498618] usb 4-3.2: device not accepting address 4, error -62
> > [  291.838759] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  297.172018] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  297.378477] usb 4-3.2: device not accepting address 4, error -62
> > [  302.718497] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  308.051867] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  308.258345] usb 4-3.2: device not accepting address 4, error -62
> > [  308.260253] usb 4-3.2: USB disconnect, device number 4
> > [  313.598307] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  318.931586] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  319.138278] usb 4-3.2: device not accepting address 5, error -62
> > [  324.478224] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  329.811444] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  330.018032] usb 4-3.2: device not accepting address 6, error -62
> > [  330.018489] usb 4-3-port2: attempt power cycle
> > [  336.211505] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  341.544640] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  341.751239] usb 4-3.2: device not accepting address 7, error -62
> > [  347.091375] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  352.424563] xhci_hcd 0000:00:14.0: Timeout while waiting for setup
> > device command
> > [  352.631136] usb 4-3.2: device not accepting address 8, error -62
> > [  352.631538] usb 4-3-port2: unable to enumerate USB device
> > 
> > 
> > Interestingly, if I revert back to an known-good firmware version
> > 20231025113744 along with your patch, the device enumerates and works
> > fine:
> > 
> > [ 4001.366725] usb 4-1: new SuperSpeed USB device number 4 using
> > xhci_hcd
> > [ 4001.385840] usb 4-1: New USB device found, idVendor=0e8d,
> > idProduct=7961, bcdDevice= 1.00
> > [ 4001.385855] usb 4-1: New USB device strings: Mfr=6, Product=7,
> > SerialNumber=8
> > [ 4001.385860] usb 4-1: Product: Wireless_Device
> > [ 4001.385863] usb 4-1: Manufacturer: MediaTek Inc.
> > [ 4001.385867] usb 4-1: SerialNumber: 000000000
> > [ 4001.398010] Bluetooth: hci1: HW/SW Version: 0x008a008a, Build
> > Time: 20231025113744
> > [ 4004.275656] Bluetooth: hci1: Device setup in 2812288 usecs
> > [ 4004.275661] Bluetooth: hci1: HCI Enhanced Setup Synchronous
> > Connection command is advertised, but not supported.
> > [ 4004.355137] Bluetooth: hci1: AOSP extensions version v0.96
> > [ 4004.355156] Bluetooth: hci1: AOSP quality report is not supported
> > [ 4004.355698] Bluetooth: MGMT ver 1.23
> > 
> > But if I then disconnect it, I get the Oops that I shared in my
> > original
> > regression report:
> > 
> > [ 4043.436215] usb 4-1: USB disconnect, device number 4
> > [ 4043.437308] Oops: general protection fault, probably for non-
> > canonical address 0xdead000000000122: 0000 [#1] PREEMPT SMP NOPTI
> > [ 4043.437332] CPU: 2 UID: 0 PID: 3698 Comm: kworker/2:0 Not tainted
> > 6.11.0-rc7-00001-g0e2ad6528188-dirty #71
> > d90fb9085e2a0686ac48ebcc408d97b104c6fbf1
> > [ 4043.437352] Hardware name: Intel(R) Client Systems
> > NUC12WSHi7/NUC12WSBi7, BIOS WSADL357.0088.2023.0505.1623 05/05/2023
> > [ 4043.437361] Workqueue: usb_hub_wq hub_event
> > [ 4043.437386] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
> > [ 4043.437548] Code: 89 ef e8 ae d4 5c c1 f0 80 8b e9 0e 00 00 08 48
> > 89 ef e8 0e c2 5c c1 48 c7 c7 68 60 52 c1 e8 22 23 5d c1 48 8b 43 08
> > 48 8b 13 <48> 3b 18 0f 85 f5 c7 06 00 48 3b 5a 08 0f 85 eb c7 06 00
> > 48 89 42
> > [ 4043.437560] RSP: 0018:ffffa10f4ae43b98 EFLAGS: 00010246
> > [ 4043.437574] RAX: dead000000000122 RBX: ffff8cf86c160000 RCX:
> > 0000000000000000
> > [ 4043.437585] RDX: dead000000000100 RSI: ffff8cf7b7d16c50 RDI:
> > ffffffffc1526068
> > [ 4043.437594] RBP: ffff8cf86c1604d0 R08: 0000000000000000 R09:
> > ffff8cf7401d8e10
> > [ 4043.437602] R10: ffffa10f4ae43ba0 R11: ffffa10f4ae43ba8 R12:
> > ffff8cf86c160000
> > [ 4043.437610] R13: ffffffffc1416278 R14: ffffffffc1416278 R15:
> > ffff8cf7f8d73850
> > [ 4043.437620] FS:  0000000000000000(0000) GS:ffff8d0697300000(0000)
> > knlGS:0000000000000000
> > [ 4043.437632] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4043.437641] CR2: 00007f98d66dc000 CR3: 0000000131124000 CR4:
> > 0000000000f50ef0
> > [ 4043.437651] PKRU: 55555554
> > [ 4043.437658] Call Trace:
> > [ 4043.437670]  <TASK>
> > [ 4043.437680]  ? __die_body.cold+0x19/0x27
> > [ 4043.437700]  ? die_addr+0x3c/0x60
> > [ 4043.437716]  ? exc_general_protection+0x17d/0x400
> > [ 4043.437738]  ? asm_exc_general_protection+0x26/0x30
> > [ 4043.437760]  ? hci_unregister_dev+0x45/0x1f0 [bluetooth
> > 6dca047d1088401e195d97746b2b4936e5756d61]
> > [ 4043.437930]  ? hci_unregister_dev+0x3e/0x1f0 [bluetooth
> > 6dca047d1088401e195d97746b2b4936e5756d61]
> > [ 4043.438080]  btusb_disconnect+0x67/0x170 [btusb
> > 5bf8186d9cab4c5be1762247dadb6753a7c72a7f]
> > [ 4043.438108]  usb_unbind_interface+0x90/0x290
> > [ 4043.438130]  device_release_driver_internal+0x19c/0x200
> > [ 4043.438150]  bus_remove_device+0xc6/0x130
> > [ 4043.438166]  device_del+0x161/0x3e0
> > [ 4043.438182]  ? kobject_put+0xa0/0x1d0
> > [ 4043.438196]  usb_disable_device+0x104/0x220
> > [ 4043.438213]  usb_disconnect+0xe6/0x2e0
> > [ 4043.438231]  hub_event+0x7f9/0x19d0
> > [ 4043.438250]  ? __pm_runtime_suspend+0x47/0xc0
> > [ 4043.438269]  process_one_work+0x17b/0x330
> > [ 4043.438287]  worker_thread+0x2c6/0x3f0
> > [ 4043.438304]  ? __pfx_worker_thread+0x10/0x10
> > [ 4043.438318]  kthread+0xcf/0x100
> > [ 4043.438337]  ? __pfx_kthread+0x10/0x10
> > [ 4043.438354]  ret_from_fork+0x31/0x50
> > [ 4043.438367]  ? __pfx_kthread+0x10/0x10
> > [ 4043.438382]  ret_from_fork_asm+0x1a/0x30
> > [ 4043.438403]  </TASK>
> > [ 4043.438408] Modules linked in: uhid mt792x_usb mt7921_common
> > mt792x_lib mt76_connac_lib mt76_usb mt76 ccm option usb_wwan cmac
> > algif_hash algif_skcipher af_alg sr_mod cdrom bnep mousedev joydev
> > vfat fat snd_sof_pci_intel_tgl snd_sof_pci_intel_cnl intel_rapl_msr
> > snd_sof_intel_hda_generic intel_rapl_common soundwire_intel
> > intel_uncore_frequency soundwire_cadence
> > intel_uncore_frequency_common snd_sof_intel_hda_common
> > snd_sof_intel_hda_mlink snd_sof_intel_hda snd_sof_pci
> > snd_sof_xtensa_dsp snd_sof iwlmvm snd_sof_utils snd_soc_hdac_hda
> > snd_soc_acpi_intel_match soundwire_generic_allocation snd_soc_acpi
> > soundwire_bus snd_soc_avs r8152 x86_pkg_temp_thermal intel_powerclamp
> > libphy snd_soc_hda_codec coretemp mac80211 snd_hda_ext_core kvm_intel
> > snd_soc_core snd_hda_codec_hdmi cdc_ether hid_generic uas usbnet
> > snd_hda_codec_realtek snd_compress kvm usb_storage mii usbhid
> > snd_hda_codec_generic ac97_bus snd_pcm_dmaengine
> > snd_hda_scodec_component snd_hda_intel libarc4 snd_intel_dspcfg btusb
> > crct10dif_pclmul snd_intel_sdw_acpi
> > [ 4043.438617]  crc32_pclmul iwlwifi btrtl snd_hda_codec
> > polyval_clmulni btintel polyval_generic btbcm ghash_clmulni_intel
> > sha512_ssse3 btmtk tps6598x sha256_ssse3 snd_hda_core typec
> > sha1_ssse3 cfg80211 bluetooth aesni_intel snd_hwdep roles gf128mul
> > crypto_simd snd_pcm cryptd mei_hdcp mei_pxp rapl ee1004 ov13858
> > snd_timer intel_cstate igc spi_nor intel_uncore i2c_i801 thunderbolt
> > snd v4l2_fwnode mei_me v4l2_async ptp wdat_wdt i2c_smbus mtd pcspkr
> > wmi_bmof intel_lpss_pci videodev mei pps_core soundcore
> > intel_pmc_core i2c_mux intel_lpss rfkill idma64 igen6_edac intel_vsec
> > serial_multi_instantiate mc pmt_telemetry pinctrl_tigerlake pmt_class
> > acpi_pad acpi_tad mac_hid i2c_dev dm_mod sg crypto_user loop
> > nfnetlink ip_tables x_tables ext4 crc32c_generic crc16 mbcache jbd2
> > xe drm_ttm_helper gpu_sched drm_suballoc_helper drm_gpuvm drm_exec
> > i915 i2c_algo_bit drm_buddy ttm nvme intel_gtt drm_display_helper
> > nvme_core spi_intel_pci cec xhci_pci crc32c_intel spi_intel nvme_auth
> > xhci_pci_renesas video wmi
> > [ 4043.438898] ---[ end trace 0000000000000000 ]---
> > [ 4043.438905] RIP: 0010:hci_unregister_dev+0x45/0x1f0 [bluetooth]
> > [ 4043.439039] Code: 89 ef e8 ae d4 5c c1 f0 80 8b e9 0e 00 00 08 48
> > 89 ef e8 0e c2 5c c1 48 c7 c7 68 60 52 c1 e8 22 23 5d c1 48 8b 43 08
> > 48 8b 13 <48> 3b 18 0f 85 f5 c7 06 00 48 3b 5a 08 0f 85 eb c7 06 00
> > 48 89 42
> > [ 4043.439048] RSP: 0018:ffffa10f4ae43b98 EFLAGS: 00010246
> > [ 4043.439058] RAX: dead000000000122 RBX: ffff8cf86c160000 RCX:
> > 0000000000000000
> > [ 4043.439065] RDX: dead000000000100 RSI: ffff8cf7b7d16c50 RDI:
> > ffffffffc1526068
> > [ 4043.439072] RBP: ffff8cf86c1604d0 R08: 0000000000000000 R09:
> > ffff8cf7401d8e10
> > [ 4043.439078] R10: ffffa10f4ae43ba0 R11: ffffa10f4ae43ba8 R12:
> > ffff8cf86c160000
> > [ 4043.439085] R13: ffffffffc1416278 R14: ffffffffc1416278 R15:
> > ffff8cf7f8d73850
> > [ 4043.439091] FS:  0000000000000000(0000) GS:ffff8d0697300000(0000)
> > knlGS:0000000000000000
> > [ 4043.439100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 4043.439108] CR2: 00007f98d66dc000 CR3: 0000000131124000 CR4:
> > 0000000000f50ef0
> > [ 4043.439116] PKRU: 55555554
> > [ 4043.439122] note: kworker/2:0[3698] exited with preempt_count 1
> > 
> > So, in summary, it looks as though there are two issues here:
> > 
> > 1. The latest firmware does not seem to work well with this chipset,
> >    perhaps it is crashing after loading?
> > 2. The Oops in the hci_unregister_dev function suggests some HCI
> >    registration bug.
> > 
> > Let me know if I can provide any further assistance.
> > 
> > Regards,
> > 
> > Marc
> > 

