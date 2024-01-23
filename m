Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20035FEE9
	for <linux-bluetooth@vger.kernel.org>; Tue, 23 Jan 2024 13:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015794; cv=none; b=VRgcJ/4NQu/J7A7rsalWKDNmriY7QIyNFuS8RXHqqEdMwXfi+U1fETVMPV/UVTKMivvENmdoqfsChm858nbldIblwNB8X8+ld/9oJkT3GCtdSKJWqw68V8Akq9DsDegjWtVLwpJgC40Mh4vkyt0xGTjGU5/mQqrBpbcJp1U8Imo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015794; c=relaxed/simple;
	bh=8i/kjWN+Dke69ifxipa8oVEO+YPDiG+AYNpRrmDh1A0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HDEpz3H2JsXTwEf0CDZ13iaZrjBi3+6Ws2b0T7P8jteAda43b5VGt2BneMNsiX4hym08GhkrpxGWywQwyTfPGa82cwhgP64cpqORwaUf4MjkWpA02V8Y0XUULhRAUhpwISaswLCsFouyZQK8Is9JUC0scvos9RxJdJ2Z54D+Me4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CovzJODb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CovzJODb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1706015791;
	bh=8i/kjWN+Dke69ifxipa8oVEO+YPDiG+AYNpRrmDh1A0=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
	b=CovzJODbq9QqMhsFuLwX559RuHMYmDCASv36eHbNKVgSaypINDmZmHOsbLcGh4iHN
	 RirFBbCfHuC2CJ4zBprqhyHY+j1Z7My6WMGNHp04VksubsVDF8bgaj3Us6J6GxYFdq
	 LJjqluSEB5EdzY+LSWreRKq3RNpjcBJ6S/ON2XPt4EeHJZopep3UnGmUxfPFEE5JnI
	 eNmB2aUA8tcgc6r1E2nOtioY280U0XcyW3eUGDhOlDxaykiGag0Ay1OOEEWkubVc6q
	 /vy5R80U4qjXI63364EFcLjBc/Wy/MM3DalDBlZzY3MvP2Vwfv7N4UR2GsVhdtgFtv
	 7tciqVFRN0euQ==
Received: from [100.72.96.248] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 01ACD3781F99;
	Tue, 23 Jan 2024 13:16:30 +0000 (UTC)
Message-ID: <95448d9e-21d3-4893-8519-cf3dec118037@collabora.com>
Date: Tue, 23 Jan 2024 14:16:30 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
Subject: Re: [PATCH BlueZ 4/5] btgatt-client: Add function to search
 descriptors
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240122165000.279381-1-frederic.danis@collabora.com>
 <20240122165000.279381-5-frederic.danis@collabora.com>
 <CABBYNZL-uiQyss17OWRrgdpf2KdVLKmVdunO-Kd5WD1KepKw0A@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABBYNZL-uiQyss17OWRrgdpf2KdVLKmVdunO-Kd5WD1KepKw0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 22/01/2024 19:15, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Mon, Jan 22, 2024 at 12:43 PM Frédéric Danis
> <frederic.danis@collabora.com>  wrote:
>> This is requested to pass PTS GATT/CL/GAD/BV-06-C test.
>> This search descriptors based on start and end handles.
> Is this test mandatory though? Afaik if we do support the discovery of
> all procedure this becomes useless, because the stack can perform
> these operations locally by using its cache.
This test is optional, as tests GATT/CL/GAR/BI-10-C and 
GATT/CL/GAR/BI-11-C which also needs this patch to pass. 
GATT/CL/GAR/BI-10-C and GATT/CL/GAR/BI-11-C request the ability to 
prevent security upgrade. This may need to add a security retry flag to 
bt_gatt_read_by_type() in src/shared/gatt-helpers.{ch} to be able to 
call bt_att_set_retry() introduced in the first patch of this series. 
Does it seem correct?
>> ---
>>   tools/btgatt-client.c | 79 +++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 79 insertions(+)
>>
>> diff --git a/tools/btgatt-client.c b/tools/btgatt-client.c
>> index bb0822658..a7d5d76ba 100644
>> --- a/tools/btgatt-client.c
>> +++ b/tools/btgatt-client.c
>> @@ -1490,6 +1490,83 @@ static void cmd_search_characteristics(struct client *cli, char *cmd_str)
>>                                                  NULL);
>>   }
>>
>> +static void search_descriptors_usage(void)
>> +{
>> +       printf("Usage: search-descriptors <start_hanlde> <end_handle>\n"
>> +               "e.g.:\n"
>> +               "\tsearch-descriptors 0x0001 0xFFFF\n");
>> +}
>> +
>> +static void search_descriptors_cb(bool success, uint8_t att_ecode,
>> +                                       struct bt_gatt_result *result,
>> +                                       void *user_data)
>> +{
>> +       struct bt_gatt_iter iter;
>> +       uint16_t handle;
>> +       uint128_t u128;
>> +       bt_uuid_t uuid;
>> +       char uuid_str[MAX_LEN_UUID_STR];
>> +
>> +       if (!success) {
>> +               PRLOG("\nDescriptors discovery failed: %s (0x%02x)\n",
>> +                               ecode_to_string(att_ecode), att_ecode);
>> +               return;
>> +       }
>> +
>> +       if (!result || !bt_gatt_iter_init(&iter, result))
>> +               return;
>> +
>> +       printf("\n");
>> +       while (bt_gatt_iter_next_descriptor(&iter, &handle, u128.data)) {
>> +               bt_uuid128_create(&uuid, u128);
>> +               bt_uuid_to_string(&uuid, uuid_str, sizeof(uuid_str));
>> +               printf("Found handle: 0x%04x UUID: %s\n", handle, uuid_str);
>> +       }
>> +       PRLOG("\n");
>> +}
>> +
>> +static void cmd_search_descriptors(struct client *cli, char *cmd_str)
>> +{
>> +       char *argv[3];
>> +       int argc = 0;
>> +       uint16_t start_handle, end_handle;
>> +       char *endptr = NULL;
>> +
>> +       if (!bt_gatt_client_is_ready(cli->gatt)) {
>> +               printf("GATT client not initialized\n");
>> +               return;
>> +       }
>> +
>> +       if (!parse_args(cmd_str, 2, argv, &argc)) {
>> +               printf("Too many arguments\n");
>> +               search_descriptors_usage();
>> +               return;
>> +       }
>> +
>> +       if (argc < 1) {
>> +               search_descriptors_usage();
>> +               return;
>> +       }
>> +
>> +       start_handle = strtol(argv[0], &endptr, 0);
>> +       if (!endptr || *endptr != '\0') {
>> +               printf("Invalid start handle: %s\n", argv[0]);
>> +               return;
>> +       }
>> +
>> +       end_handle = strtol(argv[1], &endptr, 0);
>> +       if (!endptr || *endptr != '\0') {
>> +               printf("Invalid end handle: %s\n", argv[1]);
>> +               return;
>> +       }
>> +
>> +       bt_gatt_discover_descriptors(bt_gatt_client_get_att(cli->gatt),
>> +                                               start_handle, end_handle,
>> +                                               search_descriptors_cb,
>> +                                               NULL,
>> +                                               NULL);
>> +}
>> +
>>   static void cmd_help(struct client *cli, char *cmd_str);
>>
>>   typedef void (*command_func_t)(struct client *cli, char *cmd_str);
>> @@ -1530,6 +1607,8 @@ static struct {
>>                                  "\tSearch service"},
>>          { "search-characteristics", cmd_search_characteristics,
>>                                  "\tSearch characteristics"},
>> +       { "search-descriptors", cmd_search_descriptors,
>> +                               "\tSearch descriptors"},
>>          { }
>>   };
>>
>> --
>> 2.34.1
>>
>>

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

