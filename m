Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022089.outbound.protection.outlook.com [52.101.126.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFA635979
	for <linux-bluetooth@vger.kernel.org>; Thu, 27 Nov 2025 02:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764211562; cv=fail; b=WArPdsUw0N3JURj/GRfzJFnlCSNwgt8jAbXQ6KKbu3IaAn3MPFbccD5EP/GOj7uG/QxHgZapO+fNDvoPjEFAubnp3ecLSJYAUsNBHTAw5La+gHMGhUdpky8Nwmk+9iO04lh173QMLKY80mlXB7tTpLyMJm77Y4YvzhIVmRGWc78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764211562; c=relaxed/simple;
	bh=kB4i2doxkjUysGHdDESxcHzAu/Rlr+rhExQ32yRp0no=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kto8zXWdvaF+5RIHK5kt4dThEfVqbhgdW9+pLp65B92WqoZsEGuICEtmKpKKdz9rFgq91QCjOETHMRc+UIn50iRguMmSvZF8isqDXJleXURpu30QoCsNFOEFBxWDxKRrxTETBsnWKr4SdXRKXQzK6hF/+YVgWRTjMrDvBlYTgtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=kAdiGizO; arc=fail smtp.client-ip=52.101.126.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="kAdiGizO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toFuFSOkMcq6e17Sl+SX9gHRCWUkH5VnNkZopD9LYxvtUvCCxgpo6qPnrtPKcNXwMj1mqngPZ5ozZWoFPrxuw8oR3itMICPjmuc8Ql9/KuycUXqOfquOvYF4Wezk8IzzzBckzFd3sZDKayiJ+Ntbd14jQ/qipNkAwTV7WiVVG3JqsvMqyX8buxXYojpXEaqf4CfwYQ2/Yu9/ujq22UVS46SCtNtYHnb7EC0x2rE1Ce0IlHlbKzbr26Z72TRTNKX342C9LQsCM7a18W76AT74A83w31dBrmqWkbtkMlYFf5u3bPNTtL+m/NQ0TmSKOkCxc8a/AM6EO2+mGHwBMmObXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXisiP5Nt9XI1vyoS86QbfS7Hd3HCxjJp8I8YPAz1EI=;
 b=k3+J52R8g/lpVAxRiAzbHJoREI3abhChkprMrqR7KOmu9PBPQlrb1zO+ptREE3h2rDMUXve/9Z/QsKQ1e9FPgx/+qrH3iDiDRPA3G00M31R/t4jGSds2O4yPzj51aVgb2tWa4qZVCvnlyJDMHZy7J1IMGxnwjbLfiBKPGCZZ9OGA3fCbduMxTGQLzKexIaqaPct20f1BeDf+2XRt/fIQQXwcI+VD9n+KVGY4S70wMhrZ6APd3HB5DNoN+toCuAr16afddA+E7sA2v0RYefSHAmZfMRUOOV1+70OXE7DBSyoY9KWtfo6QX4nOyflrezPfnVQlTiPmgqZfNMTWdfvtBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXisiP5Nt9XI1vyoS86QbfS7Hd3HCxjJp8I8YPAz1EI=;
 b=kAdiGizOrg+Cwj23sdfGczCepl8HaofFUXpU+WImc3z/itFmKW1NIRYyxFdjTz8LIvZWbMOuzuTh4lBXtdfp72UH8ZIzXrZSHwJjLpVpX4Iq4aK5UhMJJhG0YcmdCB01+hbKnCx+z0/fNUhpp5f4j64wpyMqm8hVYTjRVo29TyH4CUod4X49JGZ225S7wxKVO6ev4U983ocByHztxRIx7ipb1rev6up0blNuoyEXHZps/0CtPdm1r6sdRcHVmnisisGanfkw5tcnlyMOPLAoxxHObbO7rvji7riuF4UgUHtv2i59E69ka3Jm/GavJQpYs0RqibTekL6+OjqSK5IO/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com (2603:1096:820:cc::11)
 by KUZPR03MB9383.apcprd03.prod.outlook.com (2603:1096:d10:21::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 02:45:56 +0000
Received: from KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be]) by KL1PR03MB7311.apcprd03.prod.outlook.com
 ([fe80::8c55:1070:5b66:88be%4]) with mapi id 15.20.9366.012; Thu, 27 Nov 2025
 02:45:55 +0000
Message-ID: <bedc05e6-f3b0-4f42-96db-2238734014f9@amlogic.com>
Date: Thu, 27 Nov 2025 10:45:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v6 3/3] client: Add shell cmd for bearer
 connect/disconnect
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20251126-bearer-impl-v6-0-e93fd41f10b6@amlogic.com>
 <20251126-bearer-impl-v6-3-e93fd41f10b6@amlogic.com>
 <CABBYNZK2TpPjdraCC+WuY5u-yvAiyCJZAf-FrjtoLO7Qntp8uQ@mail.gmail.com>
Content-Language: en-US
From: Ye He <ye.he@amlogic.com>
In-Reply-To: <CABBYNZK2TpPjdraCC+WuY5u-yvAiyCJZAf-FrjtoLO7Qntp8uQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0019.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::10) To KL1PR03MB7311.apcprd03.prod.outlook.com
 (2603:1096:820:cc::11)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR03MB7311:EE_|KUZPR03MB9383:EE_
X-MS-Office365-Filtering-Correlation-Id: 259d7505-3805-497c-5929-08de2d5f1657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHE4Mjd0Rkl2a0FtanNsTkhnV1kwR0t3QmUwMW9wa2o0VGtNcjFNOXF4OXNG?=
 =?utf-8?B?YS80SDkzeVZETnRXc2MvbEtyOEN3VkVKdmxKeVdPVFB3ZXdGWDBlWmZ4OW9v?=
 =?utf-8?B?UzZlaHRUeGxNZTdxcGJyakE1NExWU2c1dlNUZFJkdC9NenpqNFcxRFBzNXQ4?=
 =?utf-8?B?TGV3LzNaM0ZGcFJYNE05ZWxZMUlpTlp4RjN0dmFEWDJHckdvOFRraXV4MGt0?=
 =?utf-8?B?cHM4dThVeloxcTJTcVdZcW9xOW8wdCtnWVl0NU51cG9xR2pXRDlPakVVdWg5?=
 =?utf-8?B?UXQxVWhUa3pZRzA4QXY4WHhueFk2ZExXUE1XUWRmVTgzZFVLSSt4NE4rOEc1?=
 =?utf-8?B?d0YvMkkrRzNXTnZEV3p3QkRreTZ2YVB2UFdYaFRmK2dXbllGc2pSb2taN1gy?=
 =?utf-8?B?Q2t6OGJnUm94d09UcUlqMGgwOHMwUDlFcFNoS0FpdXlIem5NeFpYbEtLL0Vo?=
 =?utf-8?B?RFVqQkZpbXRzTnRQQlZXYm9TZk0wRXc1eFBTT2NtOFIxVnZBYXNtK2w5L2oz?=
 =?utf-8?B?aTU0QTRzRGxqQkRWSHRScHlGMjNDRFFLN2crV2xidXF0K0pVeUkwOUE2Mzds?=
 =?utf-8?B?Y1RDK1pPL2pNdThPZ0NGQVJLTjNSWWs1ZElCZzg2QjRMVk5KY1V5d0hzdWpa?=
 =?utf-8?B?eWxYUTd6b2trNHo1WHltZ1MzaWxMM28xNmJWVGdhS2E3aCtRVzc5Qk0xa1RW?=
 =?utf-8?B?TENZWnlVVlhoYk1ubmNnUFBHL0VQTXVyMkxZNmlaTnZlN0JycGFoN0Z1QlBS?=
 =?utf-8?B?a2FabVZtbU02dEs4RVdPM0RDckJnYi8wSmEvREhMaDVicHB6ZUVTZWhaWWJN?=
 =?utf-8?B?L25EbTZ6UG5ET0VBM01mZ05acWNKYTFwL3dFOHZpVGhZOVhITFM1WEdRcDVu?=
 =?utf-8?B?Q1AwTXc4SE1BWEhlTjZOaTVnRUl4aGRMK0FjdVNiM250NHlKZkJSV0JFQWp5?=
 =?utf-8?B?SXRvbUVuYkZjNk50WmZ0UjJoNjU3d3F6MU9mcDhUQnpDbGxoS2RITkN1RENk?=
 =?utf-8?B?VllUNEhYSE9zZTB2bmt0UEhGMzF4L014NXVaeWFzelRJMFFaVkhFeU5ZeDVt?=
 =?utf-8?B?V3VBMkxyY2xVa0k2eC9ZRndjUmdjdjQ2bFh4NDIzU0YvdHd6bTFGUGl1SmFu?=
 =?utf-8?B?TEZEMUVKczBKd2VoQmtiemJiV0FFKzMzQktoRFZyeStoanBqMG42dnVBUmdL?=
 =?utf-8?B?YmdFNGthK3lZcWtsdHREb3BEangvL1BINWM3ZnZncWZQdG5mTVMyZGZ1bFRS?=
 =?utf-8?B?MHBYaVllcmlqRnJUWlFBS0VxWkJsNzYyR2ptSW4rOVhyd1pQMEx5TmF5OFhT?=
 =?utf-8?B?N0FHc04xWEg3UkJiV3FBaThTV1p0Wlh2dnB6OTc3Z1M3U05GRmZOc2hzT2hS?=
 =?utf-8?B?RVk0OEM1UlZkaVlOWjB1ajZLcTQ2SkZ4Q0psYmpvdVNzNnBRYVVBRzRFa3Ex?=
 =?utf-8?B?UjNUeUJnY0NIUVVFb21WYllrbEFrZXRRdGFIZzA4RjQzL0RHWGdDa0NQcitn?=
 =?utf-8?B?WjhLVjBMSjVlWGxYY05ZNm1yQ3RGZXhKTjhOY1ptZUFhNFJiRXFMTEZEbnls?=
 =?utf-8?B?ZlQ0MUdwZ1U1bVBxSkZHUlRFd09JMzQrS2xGN255RGhrbzlNQlh3QWN5b05n?=
 =?utf-8?B?YjZPM1FyMGlLZlZwek14eXNMcFNONEpRK1RPYWZGTDRPM0g1S2tiNllBM294?=
 =?utf-8?B?TTQ2MytRWjc4OWVzcWljdmFQOVNJMVMrekUrUCszMHlDbzBJMmI2NDJneU9h?=
 =?utf-8?B?WkxxNGZyb09tcTM0dWgzTktQTmNUeERNYTN6RU9EVktPRW5DTmE5ZW56NUV6?=
 =?utf-8?B?bnJRRS9oMmExeDE4UTZpRDhadDliakNFRG9mbU04b2k0UVRDa3RvNmhiZ3JR?=
 =?utf-8?B?c1hRVjZTRUNvaU5tdVZFK1pYSFBDR2g3RUJHenFYb25ibVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR03MB7311.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SjM2RUErR2R3S0lWM1hpRFllSTJrV0tJVmRPOWlUaU9FUjBhN1RDVVU3YUNu?=
 =?utf-8?B?NUNPQ1ZocGJRSkFkU05iYndvdE9CMkVrV0NEYlk3N3YwZ2lBcTZkaWpLTWdI?=
 =?utf-8?B?UjBvY0xEQkZucGNINFhHbmViK215d2ZGN2praTVDQVBHSkcvK1ZqK1h3SDV5?=
 =?utf-8?B?YnFYRHZkOVN1QlNGcTBBcU5JRTd1ZVFLY25qdkFUbWQ4blBjK3lLWGdBMDQ1?=
 =?utf-8?B?OWNZM2pKWVNkSjYxYUNPNWUzenhZTEIxT3VXekpJSldVVDFmWGlNZUUzN0Yz?=
 =?utf-8?B?WklXL0kwRHpmZ3NLV1F6bkExblRJWno0YXBRRFJDVzF2MW1OOHp5V0RlcERD?=
 =?utf-8?B?a0p0aGY5QlkrV0JXTTUwaW1aOFdQSE5QTkZvWFJRL2l0U1VjQ2luRzArcE52?=
 =?utf-8?B?SXBDaU9lV09GNnFmcVcrVEpvckFwamkyVGNJNGFSTmRwMElHODc5bjhVZXpq?=
 =?utf-8?B?RXphUjFjZVRBSEdrbTBPdU9Rc25JeFFya2h1SVAxeWFGMGRiR0NKZ2hPdU93?=
 =?utf-8?B?cUlENHlhS1lZSjRsK1BQNkhDek1Sdml6U3Q0ZXdPMTlRSVJOQXY1M1lORUJ1?=
 =?utf-8?B?SEpOU2ZkdzdxNjZsMjdkSlJFNTJ0dTJhMFFXODdvZlUrUW5BT2t2cUkwWlcv?=
 =?utf-8?B?MTB5eUUrNXl2N3hMaS90cWQrME5LNlhnRWxyRDZMZXlKR2VCSkxvVkJtbUVR?=
 =?utf-8?B?S010RDBxSEd6eFdKMHdBWlF3QjBSaUhua3ZaZUZuMTJLWm9IVGFkalcxek1v?=
 =?utf-8?B?MEJnUmtTZ3pJbVgxeHppRS9QWkRscFZsRkhMMkRBQU9lQVBtSmtidjJwc1JD?=
 =?utf-8?B?KzMxMXdGeHpESE1hZzZUWVA0ZHBtM1F4WU9JRDhGU0IrN2M3UDV4MVVIOFRB?=
 =?utf-8?B?ZS84N3RuODZmNlRBV0tNTW1pQy9OSkNKbFRoRkFoL2JmeWhpS1ZlWWRWOVJn?=
 =?utf-8?B?S091T1ZIUzYySk9XaDNtLytrR3cvbVhHcFJIbTUxbGVRSEV3QXRrOXlTNVBV?=
 =?utf-8?B?cld3Nmtqb09KeXorSVZOSDRpTU9ZdUxhSU45OHZJRDJsU0ZuS1FpM3AvUEs5?=
 =?utf-8?B?R3RadjlSV2FkR1BjbWhLM2ZVOTJIWDRVYVB6ZFlaK1EvbGt6QmhHVFl5OTcx?=
 =?utf-8?B?Z1NaTUZGVDlOWEVHayt1dytTWGNpQWdEUHM0eXVMejJ3bTNzMnA3TFM1SkpK?=
 =?utf-8?B?N3E2aXhISVpBRkpwSmdNRXdEK0pvMWE1THcrbTZPN1NXZlpzVktLbk5taHND?=
 =?utf-8?B?cmhNZ25Ec2Vzd0Zmc1pwSzQrekR2dmNsTklaTCtOeTlsWHZoQk94T09mN3RW?=
 =?utf-8?B?elZSdDJsZkZWd25LbDFHOS8vTTdydDQzWHllOC9yTW9SaDZ5VHBKcE9DblNB?=
 =?utf-8?B?dG5QblRUc0V3cnNxUE9meEdXZHFZTHRIblNjeHMyZUh2cDZEY0kzTGo0T0V2?=
 =?utf-8?B?aXNSTUtnYVg2czAxTnhLaHlIdzhPZ2xuTUp6ajVFSEF1SnJjT2JacDRXV2hi?=
 =?utf-8?B?QzlJaFNva09uQThIQkh2SDlUeG5PTUZYMDV0alpld3NJU3VaYnVRZTl4a3JI?=
 =?utf-8?B?SXZDaVNCcGZzRmVKNUlwa0hqOVVDVlBIVmRCSWxaUHZHSHpEUVBHWWpCOGN2?=
 =?utf-8?B?U0pYeENyMWw0L0cwNGxqOHNIMFJXVms4ZjBiOVJrMkg2Z1FkRFdnVk81cEZ1?=
 =?utf-8?B?UUVlMm5DWnp0Q3JSRktkM2dTN09OUkVRZnRXRHl3RmNUV1hsdUswa0V2Q2w0?=
 =?utf-8?B?UFo3VEVRM3h1U3pwMDFMK0gxd2dYTmVwSE1rLzlkdllEeFZrQXZSV0hPL1Zp?=
 =?utf-8?B?bEhtekJUbWhqbnFXN2FlZWVkQng1TXNpL2lCV0tQeGVXRG96WHpMZjNCV0Rm?=
 =?utf-8?B?cUtBdGVpaXRxRjNWa2VMRWRDbUcxek1keTBjSFArME03enBzc1hkV0tqWkov?=
 =?utf-8?B?RGZDZTdjVytnK3VGcjJtZzIzMnNDV3FvUGU3bTV5eG05L2JaeDlVZDVTNjZl?=
 =?utf-8?B?bVg3UHFUVTFjbXZEY3NpdU1wQ29YUDVNSnBXbmJuVEZmY2hNdVNlcks4UFhS?=
 =?utf-8?B?WUY2RWNBdXNPc3N0Y05nT2VsaE5VTk8zcTFtOVh2ZHJKUW5LYUJndGlwTjFC?=
 =?utf-8?Q?9jXUUIy8Rvr1NEUWuz79e1Jc8?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259d7505-3805-497c-5929-08de2d5f1657
X-MS-Exchange-CrossTenant-AuthSource: KL1PR03MB7311.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:45:55.4482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tN9Y0VNSIXpRtxvkcICHHXzpN9XvjsVtmTAQ/I9ObaSL6d69QXjdqipkUSUSWxXekihcEWZSW01KjwXyqaLURA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR03MB9383

Hi Luiz,


> [ EXTERNAL EMAIL ]
>
> Hi,
>
> On Wed, Nov 26, 2025 at 12:21 AM Ye He via B4 Relay
> <devnull+ye.he.amlogic.com@kernel.org> wrote:
>> From: Ye He <ye.he@amlogic.com>
>>
>> This patch adds shell command for bearer connect/disconnect.
>>
>> Signed-off-by: Ye He <ye.he@amlogic.com>
>> ---
>>   client/bluetoothctl.rst |  34 ++++++++++++
>>   client/main.c           | 141 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 175 insertions(+)
>>
>> diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
>> index 0187e877d60b28eb1e735181b3203e60da821e6f..e10933eb90e9d1ab830ebba6d210d940b2d91d35 100644
>> --- a/client/bluetoothctl.rst
>> +++ b/client/bluetoothctl.rst
>> @@ -296,6 +296,40 @@ needed.
>>
>>   :Usage: **> disconnect <dev> [uuid]**
>>
>> +connect-bearer
>> +--------------
>> +
>> +Connect device with specified bearer.
>> +
>> +This command initiates a bearer-level connection to a remote device.
>> +
>> +By default this command connects the specified bearer (LE or BREDR)
>> +and all profiles that are associated with that bearer and marked as
>> +auto-connectable. Only the profiles bound to the selected bearer
>> +will be considered, profiles on the other bearer are not affected.
>> +
>> +For LE connections an active scan report is required before the connection
>> +can be established. If no advertising report is received before the timeout,
>> +a le-connection-abort-by-local error will be issued.
>> +
>> +:Usage: > connect-bearer <dev> <le/bredr>
>> +:Example: > connect-bearer 1C:48:F9:9D:81:5C le
>> +:Example: > connect-bearer 1C:48:F9:9D:81:5C bredr
>> +
>> +disconnect-bearer
>> +-----------------
>> +
>> +Disconnect device with specified bearer.
>> +
>> +By default this command disconnects all profiles associated with the specified
>> +bearer (LE or BREDR) and then terminates that bearer's link. Only profiles
>> +bound to the selected bearer are affected, profiles on the other bearer remain
>> +connected.
>> +
>> +:Usage: > disconnect-bearer <dev> <le/bredr>
>> +:Example: > disconnect-bearer 1C:48:F9:9D:81:5C le
>> +:Example: > disconnect-bearer 1C:48:F9:9D:81:5C bredr
>
> I think it would be better if we do something like
> le.connect/bredr.connect instead of having to pass the bearer as
> parameter, this should also help with tab completion since in that
> case we can make it list just the devices that support the given
> bearer.
That's fine, thanks for your suggestion. I will rework it in V7.
>>   info
>>   ----
>>
>> diff --git a/client/main.c b/client/main.c
>> index 0a928efaa9bb0d2a806895ff8f8c0c7c0d2493bd..ea551498f5d09879f87b8c77d7de2f0668b53fa6 100644
>> --- a/client/main.c
>> +++ b/client/main.c
>> @@ -2303,6 +2303,141 @@ static void cmd_disconn(int argc, char *argv[])
>>                                                  proxy_address(proxy));
>>   }
>>
>> +static void bearer_connect_reply(DBusMessage *message, void *user_data)
>> +{
>> +       DBusError error;
>> +
>> +       dbus_error_init(&error);
>> +
>> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
>> +               bt_shell_printf("Failed to connect: %s %s\n", error.name,
>> +                               error.message);
>> +               dbus_error_free(&error);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Connection successful\n");
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void bearer_disconn_reply(DBusMessage *message, void *user_data)
>> +{
>> +       DBusError error;
>> +
>> +       dbus_error_init(&error);
>> +
>> +       if (dbus_set_error_from_message(&error, message) == TRUE) {
>> +               bt_shell_printf("Failed to disconnect: %s %s\n", error.name,
>> +                               error.message);
>> +               dbus_error_free(&error);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Disconnection successful\n");
>> +
>> +       return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>> +}
>> +
>> +static void cmd_connect_bearer(int argc, char *argv[])
>> +{
>> +       const char *type;
>> +       GDBusProxy *device;
>> +       GDBusProxy *bearer = NULL;
>> +
>> +       if (argc < 3) {
>> +               bt_shell_printf("Usage: connect-bearer <dev> <le/bredr>\n");
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       device = find_device(argc, argv);
>> +       if (!device) {
>> +               bt_shell_printf("Device %s not available\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       type = argv[2];
>> +
>> +       if (strcmp(type, "le") != 0 && strcmp(type, "bredr") != 0) {
>> +               bt_shell_printf("Invalid bearer type: %s, "
>> +                       "Usage: connect-bearer <dev> <le/bredr>\n", type);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       if (!strcmp(type, "bredr"))
>> +               bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                       g_dbus_proxy_get_path(device),
>> +                                       "org.bluez.Bearer.BREDR1");
>> +       else if (!strcmp(type, "le"))
>> +               bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                       g_dbus_proxy_get_path(device),
>> +                                       "org.bluez.Bearer.LE1");
>> +
>> +       if (!bearer) {
>> +               bt_shell_printf("No bearer(%s) on device %s\n", type, argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       if (g_dbus_proxy_method_call(bearer, "Connect", NULL,
>> +                               bearer_connect_reply, NULL, NULL) == FALSE) {
>> +               bt_shell_printf("Failed to call bearer Connect\n");
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Attempting to connect bearer(%s) to %s\n",
>> +                       type, argv[1]);
>> +}
>> +
>> +static void cmd_disconnect_bearer(int argc, char *argv[])
>> +{
>> +       const char *type;
>> +       GDBusProxy *device;
>> +       GDBusProxy *bearer = NULL;
>> +
>> +       if (argc < 3) {
>> +               bt_shell_printf("Usage: disconnect-bearer <dev> <le/bredr>\n");
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       device = find_device(argc, argv);
>> +       if (!device) {
>> +               bt_shell_printf("Device %s not available\n", argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       type = argv[2];
>> +
>> +       if (strcmp(type, "le") != 0 && strcmp(type, "bredr") != 0) {
>> +               bt_shell_printf("Invalid bearer type: %s, "
>> +                       "Usage: disconnect-bearer <dev> <le/bredr>\n", type);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       if (!strcmp(type, "bredr"))
>> +               bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                       g_dbus_proxy_get_path(device),
>> +                                       "org.bluez.Bearer.BREDR1");
>> +       else if (!strcmp(type, "le"))
>> +               bearer = find_proxies_by_iface(default_ctrl->bearers,
>> +                                       g_dbus_proxy_get_path(device),
>> +                                       "org.bluez.Bearer.LE1");
>> +
>> +       if (!bearer) {
>> +               bt_shell_printf("No bearer(%s) on device %s\n", type, argv[1]);
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       if (g_dbus_proxy_method_call(bearer, "Disconnect", NULL,
>> +                               bearer_disconn_reply, NULL, NULL) == FALSE) {
>> +               bt_shell_printf("Failed to call bearer Disconnect\n");
>> +               return bt_shell_noninteractive_quit(EXIT_FAILURE);
>> +       }
>> +
>> +       bt_shell_printf("Attempting to disconnect bearer(%s) from %s\n",
>> +                       type,
>> +                       argv[1]);
>> +}
>> +
>>   static void cmd_wake(int argc, char *argv[])
>>   {
>>          GDBusProxy *proxy;
>> @@ -3528,6 +3663,12 @@ static const struct bt_shell_menu main_menu = {
>>          { "disconnect",   "[dev] [uuid]", cmd_disconn,
>>                                  "Disconnect a device or optionally disconnect "
>>                                  "a single profile only", dev_generator },
>> +       { "connect-bearer", "<dev> <le/bredr>", cmd_connect_bearer,
>> +                               "Connect a specific bearer on a device",
>> +                                                       dev_generator },
>> +       { "disconnect-bearer", "<dev> <le/bredr>", cmd_disconnect_bearer,
>> +                               "Disconnect a specific bearer on a device",
>> +                                                       dev_generator },
>>          { "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake support",
>>                                                          dev_generator },
>>          { "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
>>
>> --
>> 2.42.0
>>
>>
>>
>
> --
> Luiz Augusto von Dentz
