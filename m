Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11023133.outbound.protection.outlook.com [40.107.44.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1C11ADFE4
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 Jul 2026 01:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287975; cv=fail; b=mKNeON4N4CxsEJTrjoEBeyXbkrbJpekQ511mSIiFFwYq4W/HIKWpbYisMFSG7SvHv5hssoJhO5sFv8cC17cxGsMBAZPKBQAYUxfIQdWhABqjBUm3V+zqTHJHLy+4e+NOMSlH3HRazX0duYWaMBx4G1jCS20t9HZ5rvM5lsYSMhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287975; c=relaxed/simple;
	bh=yu/Zdx7hdYZRCvPXspQpoosCriyGEeI1OLSr2jFU9NM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FI1hut49qLerp31PUl7mNkDAzErv1/0Ybv3BU98GIWkLJGGDm8bT0AZIF9qUt38aNxWedJCzkUVcsJFGOIIKVO0xJ2o8MJBPydKUVLSNS3ASUOFf+93gElzuE0ZCEVrB4ARe1xROF41VEDzwmCG2Zjpiq2Ul7aUM3+MVpdBJVms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=Xv3QusVm; arc=fail smtp.client-ip=40.107.44.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="Xv3QusVm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnW2mq1KSG39EtJEySbWfl4O43RT7+Uz3njIvXpsfx34epdJ8u+jGzf80M4sS9kLkrvOxarPdYe+IsGA0hW75K/XRY41ZYJ/w8u38MnIpHyV++uN1yInKkTEeR9Lt4sbxfBeSNi/el5Hv/uHaLa/GcIHbAVxlvoG8D4MDH+bNwMgEzzGxBHkrvMfMBnCbOfH5wgAf8p+uA1zUNoJ+odXuFZjyM/pQNJ9fgJtYxsrmT7EzFo6Q/PgHYZp4qfMdfrEqWo3pF9wkRpvH80JVSa3JU1rvfq/3phV3QRBy/xKLx3wvpjV/U3Ub/yFVdPQP8tnrp3raCCySioyMHQqCd/VIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RFvjTUDpP2kh3Gv7bjyqabHPV6GBHBHGsbMiWYFKydI=;
 b=EUjmEJCtFZbS1aUaZXr6id1E0vW5q6dRgHKt7czItI+Q2Z7xSm8AhgwR0yDZUnk3WSHYII5kppEbBrJcrD5xsg6LhdoS4UF4SxH3RgnEigiGnwJyNsBgVqZ2Xak2kIemJJkyzYcoO8kNmMbyZixA5vz5jEIUbrwlHxX0UtnTr/pk2zNw+ZmyzivdLN8rHUJiOozIIwdKJjFqSZb6J6YvrSG8C0r0rJlVte5bawg/uVu9X6+6y44uNBTwTzrP55EfMes+UqRa0linDzHHAdwPw8C12jW6BklolymgAWheloEdDyg2ebtKn4Z3EfUuijIxD8drEsRbQsY7YM3B8S+p4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RFvjTUDpP2kh3Gv7bjyqabHPV6GBHBHGsbMiWYFKydI=;
 b=Xv3QusVmz5Lf5JoUQpreJO6t+7RlSHLIH2+O6oywtJPhwz2cDFfNpibUc3dRDUOwKsqMcYIVHqb46DGxPcFHOqSI3Eq9dqJJ1OiICZ43bHDOjbe9QaH+8W6AYHvQ3Dk6+LenLObeH6YXZgyMTW29OpIVWACUuQ+pUFv6WuM8i0clSVeec8yX1zvxgnglAhIVojShgDM4q7GGdMhd3VcgR93dojmGbiTpWxNm+GZy5kNqXRsU1BQ0a/0sILGx4yCyFSkEX9ufabIM+YDAE+rrPLkYPMkLJGu9xk/6QFRyDtKCJT5OiT9l9wNjxCas2rkVKaMdodaWGXwdn9+e+An5Dw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
 by KUYPR03MB9974.apcprd03.prod.outlook.com (2603:1096:d10:8e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.12; Wed, 29 Jul
 2026 01:19:29 +0000
Received: from JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69]) by JH0PR03MB7468.apcprd03.prod.outlook.com
 ([fe80::eef5:1228:beac:be69%4]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 01:19:29 +0000
Message-ID: <0370e9c5-fc3a-41e4-85b6-ee13daa58583@amlogic.com>
Date: Wed, 29 Jul 2026 09:19:26 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ bluez v3] bap: Start BIG sync after receiving
 BIGInfo
To: Bastien Nocera <hadess@hadess.net>,
 Linux Bluetooth <linux-bluetooth@vger.kernel.org>
References: <20260728-big_sync-v3-1-c2da19f3c00b@amlogic.com>
 <12e961a0fdd2211fbca60a5ace35ae4490e53c1a.camel@hadess.net>
Content-Language: en-US
From: Yang Li <yang.li@amlogic.com>
In-Reply-To: <12e961a0fdd2211fbca60a5ace35ae4490e53c1a.camel@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SL2P216CA0076.KORP216.PROD.OUTLOOK.COM (2603:1096:101:2::9)
 To JH0PR03MB7468.apcprd03.prod.outlook.com (2603:1096:990:16::12)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR03MB7468:EE_|KUYPR03MB9974:EE_
X-MS-Office365-Filtering-Correlation-Id: a3fd198d-fc59-4c32-dbdd-08deed0f6feb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|6133799003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OUuMRHDf5UJ3YlHHUsotkge2usLCRyOurkKmz7A8JkgECUCvwjiaeoQRBeKkgOkBJRFi4hskAMKewl08ovzZBV8tLAc/miaiseGBXTo+eJlaMewKrmTcVLyf/Hm5WA85T8Wfi6xN9YUeQZR+VCC+8SmFTxjKpKD+TbMY4N2qPnI+DbfhkaNaLfph+5zXlXUjwCyfoOcrSQwDW+hVJ1+ha5ZH6HsJQQvBWB7KC3uMC1rfoHSNdZgZRXPCkhsTeU9K5BJiZ11pLG1g5LIfWVOvW/JKrvBZyRE7DUk8ig8eZAjYY92E353NP+A4jsMx/zqbL5S1GlS3xlsbWG1NIqZmZ8HK1WFZr8ZBlqiwbg8/L1dd5Jw9Iox0Ylwa02sncDs8Et2FvNpL5lbWwv92PL2AGstKssxd63PPDkuX4NwlI5FYuh4HSYjd/8Y3z1BiBzhMjJS0AJVNxBHQ9WFYWCfK+EyHpoKqK4mYwC9bIl6aoSYu8Jvp5la88mSzTQsGxFfXXIXoTPkuGBm+d69l07VmxpBF7GkG9wFbTktFZDL27d7bHO6x7W+NU5o2/sg4pxVzFF9dAfCK02oxKa8hD5gt3PnEMlBvrYvxpDFBscV/43/mknFDVth/UHZ/pG3wBjtZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR03MB7468.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(6133799003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2dwdGxJcU4zSTBVaHV5WUxxMEZzQUEwMGVENUR5Wk1CMWZRVVl1N01mM3gy?=
 =?utf-8?B?SXdITkIydlNIcEpjdkJoS3N4dDdneVBqRnhKMWZYaDdsN3V5NjJIbUIxOWk3?=
 =?utf-8?B?MFB5VlJUMFZ1QzFVZ3dWS0djUlBrcGRHMXk4bTZidm9hTk0vZ3VJYW9PNWdY?=
 =?utf-8?B?UFl6MFVMb0t1ajErMCtuMjRQbFB4L0V6WEZZSVJXeDVmQXppVXZvYUhzU2ht?=
 =?utf-8?B?WnZkZGY2c3lNYzZrZGMrOTFhRnlpMEphVDYxR0dBMXpMMWxzdUNETytKWktP?=
 =?utf-8?B?cm0raFFHNVlGREJNbEdSRm5GdWZYTXNPMHRvd0Z2SUFrU3d1S3huaHVibzdT?=
 =?utf-8?B?eHlraENZeU9RZHlNREx4MkxWZ2xsSE50bTJvSXRHbVRtZ2NYVWZsc1JKUXlM?=
 =?utf-8?B?WW4vcGVkbkl1Mi9hWWxxMThjR0xVRmJVRGtuZEZYTFE5dndSQ2s2YTdsN25G?=
 =?utf-8?B?QXowak5NSnhLdVdxOFovOG11OHoySjJZc3NBME44QnFGNmFaSFhmbC9BU29M?=
 =?utf-8?B?SzBNczY4cFR2YjZRUHFXTE4vNytpeUVQTnhYL3RTNGZvSWszeFIzWDRWa0Yz?=
 =?utf-8?B?RFVoTzV1K1pUYkx1N2toZXhDNGdKK3gvcHdjSkJCMzgwMHU4a3lxRURWVkxy?=
 =?utf-8?B?N2ZoYmRQRkFyalErWTc0U1dKKzZ5aGtRRWNPUnZVdG1wWWVmbXBxbGdWNUlo?=
 =?utf-8?B?d3RlUWlNSXRsRndUcXhoZFRISWVpejAwZFFmZTdNTXJ6Tm1JRkdpVHJOblg2?=
 =?utf-8?B?Z3dIOTNIZ1dmZDhDTERURWUva29hUmxwSE1CZys5VHJiOHZNRE1JS1pXaWlY?=
 =?utf-8?B?MWJpZFlWRHBQRHNQaGFCak82YXpwaXhWT3dnM2R4NUoxRllkME1QNEVyNVRv?=
 =?utf-8?B?WmRNVVpvd1Jvb3FubmttaEduNTRpNVhpaWFYNy9mNEZ3c3M5TDBOckpiNTVn?=
 =?utf-8?B?ODR0eVI4RkgvWFVBN3hrZzl5UXBjMERJRHcwMUdLMzRXUDdDQlpUdU4xYzE1?=
 =?utf-8?B?QnMweVc5NWdaRDExM1l4RTJlK0xSOVNWQWhHTEtSK2VzTmVzVjFpVWY4V3lX?=
 =?utf-8?B?aHBPbi9XZnVZTlJWZEdqaFlpcVhTTURjcU1rM3l3dlJEejhFWHFNSjFZaWRj?=
 =?utf-8?B?N05xUXhNT0NWTkZJdzk5SEkvN0tZNUlJT0VqRXk3a1A2ZUdheFdEcVV6bXR1?=
 =?utf-8?B?dlRsV09keFR3QTdRanUxK2VjOEJuTTVGQUlIenQxR3BwWGh4RTJKMTJmWGIx?=
 =?utf-8?B?ODIzUEtlOXl0WGl1eUtBT3dhVE93eDJ0eWxoV01WUGZjYng2U3NkV1BXVmRK?=
 =?utf-8?B?eDdMYTh5K0toU1RTKzc4RU9QYjRMdStuWWpqc00wL3p3VmlZdTR2R1NlY0F5?=
 =?utf-8?B?Z3M4RXR6c3B4YlhkZWUxQU9DbTR3d2tUWEQrejBtZlpycFBzT2xveXg1RUNI?=
 =?utf-8?B?L3lnTEFjdHh5eEdhMW84aXJ1d0p2VXlteXdvUGc2bytPUXBLNEc3YWw4SHZE?=
 =?utf-8?B?SWNNaHNwTTFQVVQrU2I3WW5OcUo4clZ4Y0NUYVZNSE1MZ3pCRG9FSVQxNnIr?=
 =?utf-8?B?TTJQcVEzVjI1LzJ3NGppWjA0RHVTL1Y5dDJudFVzRkl6YWsrR3JLTXBsaytx?=
 =?utf-8?B?UHFLcWRxcXp6SWdBcTlvZW93aW91bUswUTdXdk90cjZxQWl6WnpmdWRnN0No?=
 =?utf-8?B?QXFSMERNQ2xGTnlKL0U5RVNxODZTUFN3NzhpbzQwRG1VWHN6RSt2bU90b0Qz?=
 =?utf-8?B?dkNuVFBXR1p1VCtrWmJUOGFaVnJ2TTBGVXZhY2VjY2Y3RksralIzSnlSMjlT?=
 =?utf-8?B?NFk2YWZucG9KQytFc3dxMXBkTk9kL0dGTU1NL0p3MzVuSmQ1ODZ5VDFqK0Va?=
 =?utf-8?B?aXJrRW1DQW13WUFGbHZLSitNbXVHTVpIQXNrUmZ0WFk2OGkyd3ZVb1FVc0xG?=
 =?utf-8?B?aWhQSk1heVFFd2pUQWdKd0F5QmFLRk1xU2kzellKZUk4Q0tpYndXdytPbGsw?=
 =?utf-8?B?aHJtaDAzUGNacmZUWDBxR2M1WkdaalpnYkVhSGI4ajVGa2FDeHRQcWxKZkdl?=
 =?utf-8?B?VGd0OVN2YTd2aUJBOFJ2ZHhxMnVlNzZVcm05V1JwMHM4R21FTGRiV3NRcWww?=
 =?utf-8?B?UGdyRzl3OExueE4zZzNqUkdYZkZwbmV2Q1VDeWt0U2Rid2UwWkNaVjNCejUv?=
 =?utf-8?B?dFErRmt5MHRQazdwc0IxaWNpZS9NS0xBQmFOTzNlQ0k0K3I5MDlUeHJ5ZU5n?=
 =?utf-8?B?MlVjc0JIQVgxSHNOTVdpU1FiYVZQcEJuV2RwSjZ5ZksrczdDdEpDWXo5dVpN?=
 =?utf-8?B?TGRtMjgwZ0U4Y1RZNFdzdFVIdEsxZVlaa2JLY1hyUnVHWGUyaDllZz09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3fd198d-fc59-4c32-dbdd-08deed0f6feb
X-MS-Exchange-CrossTenant-AuthSource: JH0PR03MB7468.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 01:19:29.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CybCC2dfWAoWazafpf+z/23SA6u6Lm51I7k4xOuNsqAOX2uuEtcCI+VHtdKbCgIt/cqfxBVyiICrNUiBkGTNDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUYPR03MB9974

Hi,
> [ EXTERNAL EMAIL ]
>
> On Tue, 2026-07-28 at 14:26 +0800, Yang Li via B4 Relay wrote:
>> From: Yang Li <yang.li@amlogic.com>
>>
>> The current implementation starts BIG sync before receiving a BIGInfo
>> report. According to the Bluetooth Core Specification, BIG sync
>> should
>> only be initiated after BIGInfo has been received.
>>
>> Starting BIG sync too early may cause unexpected controller behavior.
>>
>> Trigger BIG sync from the BIGInfo callback, following the same
>> approach
>> used by the short PA flow.
>>
>> Fixes: https://github.com/bluez/bluez/issues/2345
>>
>> Signed-off-by: Yang Li <yang.li@amlogic.com>
>> ---
>> Changes in v3:
>> - Fixed coding style warning.
>> - Link to v2:
>> https://patch.msgid.link/20260727-big_sync-v2-1-053fd3bcc3be@amlogic.com
>>
>> Changes in v2:
>> - Fixed build error.
>> - Link to v1:
>> https://patch.msgid.link/20260724-big_sync-v1-1-0a35013e30ba@amlogic.com
>> ---
>>   profiles/audio/bap.c | 25 +++++++++++++++++++++----
>>   1 file changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/profiles/audio/bap.c b/profiles/audio/bap.c
>> index dd4b3c8ff..473e4cfc2 100644
>> --- a/profiles/audio/bap.c
>> +++ b/profiles/audio/bap.c
>> @@ -3650,7 +3650,8 @@ static void setup_refresh_qos(void *data, void
>> *user_data)
>>        setup->qos = *bt_bap_stream_get_qos(stream);
>>   }
>>
>> -static void iso_do_big_sync(GIOChannel *io, void *user_data)
>> +static gboolean iso_do_big_sync(GIOChannel *io, GIOCondition cond,
>> +                                             void *user_data)
> The return here is for:
> "The function should return FALSE if the event source should be
> removed."
> Not success or failure.
>
> See:
> https://docs.gtk.org/glib/callback.IOFunc.html
> https://docs.gtk.org/glib/func.io_add_watch.html


Well, I got it, but this patch has been applied, I will send the new one 
to fix it.

>
>>   {
>>        GError *err = NULL;
>>        struct bap_setup *setup = user_data;
>> @@ -3659,7 +3660,7 @@ static void iso_do_big_sync(GIOChannel *io,
>> void *user_data)
>>        struct bt_iso_qos qos;
>>        struct queue *links = bt_bap_stream_io_get_links(setup-
>>> stream);
>> -     DBG("PA Sync done");
>> +     DBG("BIG info received, do BIG sync");
>>
>>        g_io_channel_unref(data->listen_io);
>>        g_io_channel_shutdown(data->listen_io, TRUE, NULL);
>> @@ -3682,6 +3683,7 @@ static void iso_do_big_sync(GIOChannel *io,
>> void *user_data)
>>                        BT_IO_OPT_INVALID)) {
>>                error("bt_io_set: %s", err->message);
>>                g_error_free(err);
>> +             return FALSE;
> This is wrong, this should be TRUE or better G_SOURCE_REMOVE.
>
>>        }
>>
>>        if (!bt_io_bcast_accept(io,
>> @@ -3692,16 +3694,31 @@ static void iso_do_big_sync(GIOChannel *io,
>> void *user_data)
>>                        iso_bc_addr.bc_bis, BT_IO_OPT_INVALID)) {
>>                error("bt_io_bcast_accept: %s", err->message);
>>                g_error_free(err);
>> +             return FALSE;
> Here too.
>
>>        }
>> +
>> +     return TRUE;
>> +}
>> +
>> +static void long_pa_sync_confirm_cb(GIOChannel *io, void *user_data)
>> +{
>> +     struct bap_setup *setup = user_data;
>> +     struct bap_data *data = setup->data;
>> +
>> +     DBG("Long PA Sync done");
>> +
>> +     /* store io and add watch that will call iso_do_big_sync */
>> +     data->io_id = g_io_add_watch(io, G_IO_OUT, iso_do_big_sync,
>> +                                                     setup);
>>   }
>>
>>   static void pa_and_big_sync(struct bap_setup *setup)
>>   {
>>        GError *err = NULL;
>>        struct bap_data *bap_data = setup->data;
>> -
>>        DBG("Create PA sync with this source");
>> -     bap_data->listen_io = bt_io_listen(NULL, iso_do_big_sync,
>> setup,
>> +
>> +     bap_data->listen_io = bt_io_listen(NULL,
>> long_pa_sync_confirm_cb, setup,
>>                        NULL, &err,
>>                        BT_IO_OPT_SOURCE_BDADDR,
>>                        btd_adapter_get_address(bap_data->adapter),
>>
>> ---
>> base-commit: 89d477bb5494eef0b24e5667be62f854da250a97
>> change-id: 20260724-big_sync-45c24ec09121
>>
>> Best regards,
