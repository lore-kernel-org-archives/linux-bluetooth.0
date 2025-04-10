Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2137.outbound.protection.outlook.com [40.107.255.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0A815E97
	for <linux-bluetooth@vger.kernel.org>; Thu, 10 Apr 2025 02:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744253458; cv=fail; b=XEf7gcbpVuBu3z+VhXspiUeLmfhI6amjm4VdIU/L4i4mf5p6oCpZTXk2tutty/FXj2cZep8qlMMHJ6naCQWRUayUZMJvNGBxuhZp5zq840549eBGFEtnW3Ce8etKjZe4HVtchRlZv53DeKs/IKUjpceewacLotV7DxUNUTWyMCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744253458; c=relaxed/simple;
	bh=TZ6Zp0IvnKyPe8BrpeTXc6Zw4XBLH5BBz6ROVojA644=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W28dIsy5iKmQugHWRHvPD9h/HkcMsjhoZ5WaMzNoWdvtiCjW2m8Lql/bdOT0jr5aXofYTmy/ZuZHp3lH+gMhC958DC/gnTmjExFyhIStRt6MQzgemcXlWm1MiwivGu4G227A0LOr5M2PiAf3c9YR6vzg+3q20r96GFspIlqh9dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=plOA+aLY; arc=fail smtp.client-ip=40.107.255.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="plOA+aLY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgMOMeir4fVR2MfAxX8cXULASS/2yikfrK8YmzPL3SE1vDiyHt7dn/m9X9HHUXA/faTQNV9TX8JP15oTlXoZ3MHmQrif9HVjinCoH0ac4KnFAewYRnRYORd9SKPSoPPcZI1vpcGh9RwhetLHW+at7iWOHebm/HUv0QqmMqkOZ9cmT1z0Ud6c8m2mTVj2q8aWZQeZiY7mK2+XNEt+w54pAojZxQ7hlMjWAVXBhkT62Fvae8sLJtfcccku+MF7GRnPn+sHh8GvOmo3iELORYjYKPKJLkQVKUXHHWfYBs5VRavuPtAMtuTQ9I8zI62vvPo4EP6z2AM2hHn3stoPuf8R5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fUd4IpKqFY2em9x5+cs79lQKoeS7K0Qe6u1l/kAVLus=;
 b=q8ekLvNhmgoAPfLUjgvauOljWc/3k5FQdnn2tdygOkw1f8fRiNsfYmhTtLRKp87z9gGcGb34tbCOq8LcO7TBWeFzRJuOd3LqO6xXrBY1C5naqpvEXSog8I7FXnfQG4kg2ZAiMN29UihGXQXmRrZ1MUXvNgednWwHeaGipFAtMcPm++V/KCvaNMvvvy7PC90brGNTpmeoh1zIuOX3rIGAnEX4QZyM1DTrbNJidboH9NAC8o+zB7b915FgOP2RlC18OLCVtPV/iGPpY0/cOU89XG0mTyb3obaZyPYMwWOdgNCJfbX8rVacXHFLnvwSLYwWoVdfQY/FdIj974ONSV+MGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fUd4IpKqFY2em9x5+cs79lQKoeS7K0Qe6u1l/kAVLus=;
 b=plOA+aLYdXDPa/jbYlRVrz9/ocgI3k2whtfVm5eOoeAN08chqN7kliRaPsrUw4OlyRFj1kRwI3yyFrRSFivKGkQ8J1RRRIpE3WnCISxvY67M+BEzUOUmDczSVF2mccYfesIxx9Ti29lNVeeTJpZfRO97FS4JbTncxqTSn1c65EMHKxVWcV1lV9NllcQleymHVf7hCW/NbMpeyVMr8hJO0Ff1DNRQ8YcdLxxLHiRcg6Z4/5HlL92qKJv13UWDOoDhMJBNJ5VZ1Gt3PjS41+0ftcbYcX2vduQPXjyTXX9TD1mh0ItGpIYe/3IiE4geQCK/T78l4JR1Y0p6uNUA7cVedA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by SEYPR03MB8264.apcprd03.prod.outlook.com (2603:1096:101:1b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.35; Thu, 10 Apr
 2025 02:50:52 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::4128:9446:1a0f:11fd%4]) with mapi id 15.20.8606.029; Thu, 10 Apr 2025
 02:50:52 +0000
Message-ID: <f9268355-8907-41bc-b13c-448a61f9321c@amlogic.com>
Date: Thu, 10 Apr 2025 10:50:36 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez] bap: Add idle notification for ASE State
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20250407-bap_aes_state-v1-1-dfc090c49cea@amlogic.com>
 <CABBYNZJsJAbGz=VUZuabixnTJcj1gZHM5m1P_cU06aMn3YZo3Q@mail.gmail.com>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <CABBYNZJsJAbGz=VUZuabixnTJcj1gZHM5m1P_cU06aMn3YZo3Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:4:197::14) To JH0PR03MB7468.apcprd03.prod.outlook.com
 (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|SEYPR03MB8264:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ced4749-0334-4edc-a821-08dd77da81d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VmdpYkIvMlowa1VaTFliRTZ6QUIxckpnckhKUGgyMmNrUHQ4TXFVOG9oM1Nu?=
 =?utf-8?B?ZkhVc3I0Y1pnSW9MeE9xT2srKzNBREpzKzFVN2pnMndyZDBmWnRJTkZyRnRi?=
 =?utf-8?B?TTl2NG1ZdzVwZTA0RmlJdG81N2pnUTV5TGtqMjU0dytjOHQybUt6OUxiVTYy?=
 =?utf-8?B?ZFk5RWgxbkwvSHF0T2I4a1ZaZW1nSHNTc1VhT3RyNVZxZGZ3cHdjUUpySVlX?=
 =?utf-8?B?ZlBleEVhajRuU1FQWHg1Zk91ZXFCY2s3N3lhakVGMlBpa0U3cHZlTC81dDVk?=
 =?utf-8?B?ZGNMQmRBZUNzenlGMDdnWHZlUFh2blJSR01UWDFwR29ueFNBTWpJSWNlN3JU?=
 =?utf-8?B?eER1aVdLenUxL0FTZnJSMW5zRGxBdHkxbWFUM3ZVbzB0MVRhR1J0a1dVbERH?=
 =?utf-8?B?Z1ArNUlITUkyQWhSUVVKMjNUbGpibmozT3ZMdjhrekFDZ2tqaWdaTkZqMVVy?=
 =?utf-8?B?eWlUcUUzN2RZbnFzaXJ6S25SakRGRnk2YW9XUnpYZzFkMkdZcG5hT0hiYjhW?=
 =?utf-8?B?MGFSa3VoeHYwbzBhek9oVWcwUFgwczBHcXlhWGowU0hlM3B1enh0SDU5djNs?=
 =?utf-8?B?VktVb0UreVNFa2RzUUpTMmlLeXlpNTEwT0VrUis5Mkp0aFlxSW1XTzhXMGZN?=
 =?utf-8?B?Wlpia2NnMG9kR1gvS1RrcDhKeDBjblk1L1dWVW5rRzIxOG9TRG1oK253Mm9U?=
 =?utf-8?B?dXFNalltdVh1VG9UUVU5VnNVZG5kOHd4eEdhVkZudFhING00aGVqR1JvdmtQ?=
 =?utf-8?B?UGIyTk8weTArYk82WWhCVDZaNjJJRmorVWU4TldNU2dGRzhiUFpUbW4rdGc5?=
 =?utf-8?B?eTRLZDQ5b1dBc3cxZklZMTh6bWRHL3VGOU1WaUZaUjlpc3o0cVVleUI1UVNU?=
 =?utf-8?B?YXBqNE52a0srYkxVZFd3RzZKeFhtbkFDNk1vRUM2RjNxV2Q0V3VpTloxYXE3?=
 =?utf-8?B?RDdhYlBydDZ1Y1RQRW1QcSszUGlrVGlCRkQ4T2ZRZncrODhOcE42aDBsVnIv?=
 =?utf-8?B?YkwvM0FSYUFobFdQeFFENjloZzVDdG1VcHpuM3MwSkIwbFpWKzk5eW00cC9L?=
 =?utf-8?B?dGtKTXk5K2hEaU5oZE9vWWpkVE1KSmgydjFwYTNYQlR3SUpPS3VzckFvZzlI?=
 =?utf-8?B?WlExY0xCZmVTbFpwcFRyQ2hjQ1I1UjArSkdOSmxuOTF6UWtyUE1Sb2NUR2dE?=
 =?utf-8?B?MHhMSG5mRm5mNUt1S3p2c2N5dENvVG80WUdJZytzUlhzU3gzdWN3Qmh0SU1z?=
 =?utf-8?B?TXF5bllqZHhUNTI3QmJTYk5Oekt4YWhnakNyQVJicnZrcVhRaHAxQXdSZU9j?=
 =?utf-8?B?aFlZd0xMT0t6WDVFSHFrRU90c3BCMjBmdTc4S05MVHpnSndvaDl3bk1XeHJo?=
 =?utf-8?B?ODluVEVKMkhQKy80OXBMcEkzWnljUnQwdVBPWUUvSGg0Q0VWc0ZsckhTcVU0?=
 =?utf-8?B?VGhsVU5WM3VQZ0VLV2U2SHUwdlplN05kbzB2NG8zd2tRRmRLMjRTSGluZDJH?=
 =?utf-8?B?ZXBwSXR1U2g0em1jdlBZbjZTcFp6QytUVWVIcE1Kd2tTOEJPNWdzWWdibUJ0?=
 =?utf-8?B?Zk9BTGtWVktDOTZRT2w3SitlQTdIUEI3MldESW52VDhxV0pxdTRtbVdtMVUx?=
 =?utf-8?B?TVk2UzQ0Vlh3eTVQRndvZStKaXZwYUpvdFJ4REIrbmp6aldPaS8zWWd6M0Iv?=
 =?utf-8?B?VXpZYkVkQkZ0T1d4eHFFek5YN2R1L3F1Z243ZzduYnk1ZHZLTm9yenJVbURo?=
 =?utf-8?B?RjZiL3hSK211NktqR0J5UXV2SXpoc2Q4TkZzc29PWTdOSVhLZmlHUTBjdTNG?=
 =?utf-8?B?RnRSaFBUa2FSWUQ1NHBjMUJnRU83ekYvaHgxNVptS1poZWcxaFRGY0pNVEt0?=
 =?utf-8?B?Q0NlQzRGOExqd29Xb0JnRVF5Tk9kVTgvaytIazRQV0pGVG1Sa3pvcFRYWWRD?=
 =?utf-8?Q?gVR43kJYCfg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJUQ3BGa2QzS2hMUXZmcU1ueldmR2xmdTVIczVaSFhBTnZIZWlLVFg1UkVM?=
 =?utf-8?B?aDAwTnFKeERJRUtvNnFvdmc3dG1KTC9TM3JhbFJ0ZVFWQ2VDT2hEbDVBalI1?=
 =?utf-8?B?UWNwNHhNR1JBSVoySnpHaVpNOTlBS2JRWE9UcjEwd1BVL2dwMlRFVzlmVEdh?=
 =?utf-8?B?UGJsZzI5ck0vS2h5WnFsQmNoanNEeWpFQ1NacGFsdXoyL01aZnBWZHNVVC9v?=
 =?utf-8?B?aGJ6dUJyR3FmZDVzOHdsdmRzVllDV2xueFFrZU90RTlaM0FGKzN4ekRza2c1?=
 =?utf-8?B?bFczcUYxZzBCTnQ0SjVFVUtTNjVBMG5WRGhZelRrc20wTFEybXFCejI5dEw2?=
 =?utf-8?B?Q3BiaTVqMjJRM0kxYno3VnNQeFBNYnd5UjUxSUE4M2YxTG9BQjAwTVRMQTkw?=
 =?utf-8?B?RXJpK0NVdFpYWGZ2Q2tGWWk4M2dWdDdtQlYraSt0aWFzZE92VjBpMEZPejlP?=
 =?utf-8?B?bTcvQ21CQy90U2dCK0wvTXdhWXIzVjJYSFRuNUhQRTFoUGFBTHEweUJYZDNJ?=
 =?utf-8?B?aVBiSXdnbzViSnFPNCt6QWxUd3RzT3ZSQnkzekRDbXNRbGdNNlNIVEhKbXBu?=
 =?utf-8?B?R21KRGJaQmE4UmlaRWdGNjdIeXNCNmxBZUMvVDZ0YlVESVM3WExQN0pYNHV6?=
 =?utf-8?B?NDNkY3hxY0QwclVHTTRSeEVoMWQwTjBLcjYrY2s2c0RNRWlmS0EzVzZLNWdi?=
 =?utf-8?B?bVEwYThDQ00rMTF4bFplQWhuOGM3WGxrRVkwNHZaTGUwN001WlEzcWthUVFr?=
 =?utf-8?B?cmhKazlRS280Vmo2cDhMTkZHNlBMK1hyNXpKZ2pMNy9nWXRnMTNhVWxEeXVR?=
 =?utf-8?B?YldpSjY0WDJhUzBWZVp6czRzZmFZSTg4N09ZK3ByckVtSVB0cEJqZUFadWhG?=
 =?utf-8?B?b29ucC9nWisxRHpxNEZZOG1aQkFEd3hrWVhBZ2o4dTRXK3l1TU0wOUlWdWtG?=
 =?utf-8?B?TWU0b3BXWHNsY2FyK3BpSWt6Z2hvR1dKRjVxeEZnQnNlZ0JRT0pTNHo1QlVj?=
 =?utf-8?B?TXRIUkRSZlhIRnFNMW4xUUlMcmhCam9kOVhtUzVudnJJcWtTTnhCTUpUaXdX?=
 =?utf-8?B?ay9XY3lrcjJBbkpjVUZxK1VCckc0MXU1TFR2MGoyelF4cmxWeVh6MjZhZWNJ?=
 =?utf-8?B?Q212enF5a3RSM2FTMU5MVzAzc05tSTkzUzlpL2RuNzNVNWI1bk84S2pkWUFT?=
 =?utf-8?B?UTF5SnU5WW45cWxWZ1dmK25MZVpjOTZ0WFpzbGNYVmxyMlBqaEdzbUVDU1cx?=
 =?utf-8?B?cEpkVlgrVFNwSFd5eUk1WkZ0bENGMzZqbHpmbFJKNW5HV1lRd3AxUzZBY3Rx?=
 =?utf-8?B?QmpLcDJWdGpxa3ZoZHRsdDd1bDVaNERkWkxDZkUwMi8yRFU4cCtMSS9yamls?=
 =?utf-8?B?Y0JYWndTaGhhZ0MyZ0EwM2E3Z1ZqbnJuSDl2MzlPQ1JjdGlCQWNMeVNFcFZK?=
 =?utf-8?B?QmUyYjZwaFlaRGxCWmU1aE5VV0hraTNVT0FaM3VQOWRWckVhNXdnRzY0VkNt?=
 =?utf-8?B?Tit3bGVOd2FHbjYxZUVXMmNzdGpwYlcybHhHWUdLWG1YR1VzRUM0MWx4T1Bl?=
 =?utf-8?B?d1VkZk5tcGlKUkhONHZuQzJMWStVNUZFUituckhBOXA3V0hIRnYvOVdOTm5s?=
 =?utf-8?B?RTdLQkswU3p3Z0J3NjFhVzJQRUJBdXBVSWt4TU5HUGFackZ4Nmo2cDArZncz?=
 =?utf-8?B?WFdGM3MvYTVGK1NrY0d5TzNZbmJOUWRaSHZsUjlkS1NPNlJ2RlFQUm1vSmhY?=
 =?utf-8?B?VEg4V3dFd011QW1Ed2xNQmxpekhGMVJFZUxBTlZQeUlMSE5ObGZEU0lidE5E?=
 =?utf-8?B?dmMyNnFWRE84aHNyTjE5cDB6NllSWjErWUs1N0kxaDl0bGhDbUF3UHZsQTZ4?=
 =?utf-8?B?RkNGMkc0Ykl3UFRna1RKdFVrQzFLbVFhU3QxVGF1Z2lmeUprWUFrNUhvNE4v?=
 =?utf-8?B?MWJZZlBnMzBPbDBhQ2RWcFNyNVViNFhjZ3ptRFVvZUdQTVFZVklnVnNPSWov?=
 =?utf-8?B?ODlFUzVKVnRTRHN3aVFmU0NGb3YvVTUrcWR0SDlNNE42bFhwUXphLy96NC9G?=
 =?utf-8?B?WFkwRXNnS2dCOVpPNDRTdlBoaE9UbkNpL2ltZmEyc25zUzU0b1BlUWttd3Bp?=
 =?utf-8?Q?EReKpqEkgu0SCY8bzrYaS9c9j?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ced4749-0334-4edc-a821-08dd77da81d4
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 02:50:52.2840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PPXX9ZdNfjUvCKwRvasE/5vBKvjEYp2un9PMhKsO00EiiUTUVYcdqvZSfEzMeO/+oOfMOgETyhZmakNH2CoLCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8264

Hi Luiz，
> [ EXTERNAL EMAIL ]
>
> Hi Yang,
>
> On Mon, Apr 7, 2025 at 6:34 AM Yang Li via B4 Relay
> <devnull+yang.li.amlogic.com@kernel.org> wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> When the ASE state changes from releasing(6) -> idle(0),
>> the idle state needs to be notified to the Client.
>>
>> ---
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>>   src/shared/bap.c | 13 ++++---------
>>   1 file changed, 4 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index 650bea2f4..c40d6e051 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -1123,17 +1123,12 @@ static void stream_notify_metadata(struct bt_bap_stream *stream)
>>          free(status);
>>   }
>>
>> -static void stream_notify_release(struct bt_bap_stream *stream)
>> +static void stream_notify_ase_state(struct bt_bap_stream *stream)
>>   {
>>          struct bt_bap_endpoint *ep = stream->ep;
>>          struct bt_ascs_ase_status status;
>>
>> -       DBG(stream->bap, "stream %p", stream);
>> -
>> -
>> -       memset(&status, 0, sizeof(status));
>>          status.id = ep->id;
>> -       ep->state = BT_BAP_STREAM_STATE_RELEASING;
> Not really sure why you are taking away releasing state, we actually
> depend on it for the new tests:
>
> https://patchwork.kernel.org/project/bluetooth/list/?series=950067
Well, I got it.
>>          status.state = ep->state;
>>
>>          gatt_db_attribute_notify(ep->attr, (void *)&status, sizeof(status),
>> @@ -1713,6 +1708,7 @@ static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
>>
>>          switch (state) {
>>          case BT_ASCS_ASE_STATE_IDLE:
>> +               stream_notify_ase_state(stream);
> We need something like stream_notify_idle.
Well, I got it.
>>                  break;
>>          case BT_ASCS_ASE_STATE_CONFIG:
>>                  stream_notify_config(stream);
>> @@ -1726,7 +1722,7 @@ static void stream_notify(struct bt_bap_stream *stream, uint8_t state)
>>                  stream_notify_metadata(stream);
>>                  break;
>>          case BT_ASCS_ASE_STATE_RELEASING:
>> -               stream_notify_release(stream);
>> +               stream_notify_ase_state(stream);
> This is actually wrong, we need to notify the releasing state.
>
>>                  break;
>>          }
>>   }
>> @@ -6397,9 +6393,8 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
>>          DBG(stream->bap, "stream %p io disconnected", stream);
>>
>>          if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
>> -               stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>> +               stream_set_state(stream, BT_BAP_STREAM_STATE_IDLE);
> Ok, so this is sort of reverting from  bap: Fix not generating
> releasing state? I was wondering how much testing you guys did to
> confirm this is the right behavior, I don't think it is and Im trying
> to figure out if there are any tests for the testing spec that do
> properly verify this behavior.

There are some misunderstandings that need to be clarified. Initially, 
patchset V1 
https://lore.kernel.org/all/20250106-upstream-v1-1-a16879b78ffd@amlogic.com/ 
was proposed to solve the issue 
https://github.com/bluez/bluez/issues/1053, but after discussion, I felt 
that the process of Streaming->Releasing->Idle was OK, so V1 was 
abandoned. Then I submitted patchset V2/V3 
https://lore.kernel.org/all/20250213-ascs_bug-v3-1-d5594f0f20c6@amlogic.com/. 
I tested K70 and Pixel phones on V3, and both can solve the above 
issues. So my original intention was to merge V3, but after the release 
of version 5.82, I checked the code and found that V1 was merged. So I 
submitted the modification again on the latest version.

I sorted out the process of ASE state switching when the media of 
different mobile phones is paused:

1. Redmi K70+DUT: Pause operation, ASE state process is 
Streaming--->Disabling->QoS
2. Pixel+DUT: Pause operation, DUT does not cache Codec, ASE state 
process is Streaming->Releasing->Idl
3. Pixel+RedmiBud5 earbuds: Pause operation, earbuds cache Codec, ASE 
state process is Streaming->Releasing->Codec
If the DUT also caches Codec, the latest version of the process is 
Streaming->Releasing->Codec->QoS, but the QoS status will be abnormal on 
Pixel phones, causing LE disconnection, so the process without caching 
Codec is still adopted.
>
>> -       bt_bap_stream_set_io(stream, -1);
>>          return false;
>>   }
>>
>>
>> ---
>> base-commit: 0efa20cbf3fb5693c7c2f14ba8cf67053ca029e5
>> change-id: 20250407-bap_aes_state-9306798ff95a
>>
>> Best regards,
>> --
>> Yang Li <yang.li@amlogic.com>
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
