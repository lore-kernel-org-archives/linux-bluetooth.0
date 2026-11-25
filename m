Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626304;
	b=GD14irn4g9hRlpJLZQ2IIbkq7xp4BVXNSzxTobviSA6DSI5UUwllRRofgn2TFJ/q/rHM
	 6WkvCM7OTd5CLw+AjEhkHpVmv4KfymYvt0joschvboEEVDDQ/swjeWA1LGtoiZcrHoyzH
	 EF1dEWlijnNmiRtf6O/J14uPC4vkf/o6Flx1/eprD/o62x+9f8ruy3Bh0NvkHpWV3T15Z
	 ComrCPOvrLW8EJInSIPcFjlRuaV+AgWLrn0+glcYh1e41PYtIVDL/MrdnR0ymmDlNzdVN
	 K5EFAsuqdpk1bvrBJwcwOTZE/VZ8Mv4uyubbtYFQKIeia4rTFMWogTwTug7var0jA/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=z+1Z2Wduor/P0I6hU1tUUkvCPdhVaarBTXJS1VL+tFw=;
	b=YknhobI+pUxdWcaV+NdxHLrEvoh+VAn69cJUj0oODLCKAhxvZIWdiRFpx4T+km9IJUKi
	 JExCBciRCWwCvaxn/0iuaT2AzfsOV5uIpcsDmURMCIU5N9zd7rDp2VyS38/4HHu73eTha
	 s2xYYrL49HrQC0sxlBmvJkrfqGamB4y3/XAImzZsGM9rIyAqb8NQMdU8bpzYDse+dUbc6
	 FM+oaVXp8LZ+Am5DiPAqWEsgiqts2kZO5cXukhqyGHcG/pLloZqjP0CR0O4zb9OsvW4np
	 fmkdVaspBThVqP8Oy1cXPFjizu+r72uF4EsBsdVj7aspWVhBlxpLPDc5mD5NdRa6teA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xSPOlKnq;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D5D606A32A
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D5D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=xSPOlKnq
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-48e46e449e8so3904593f8f.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626302; x=1796231102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z+1Z2Wduor/P0I6hU1tUUkvCPdhVaarBTXJS1VL+tFw=;
        b=xSPOlKnqDV+5BKfVUnysUTA4O/k/f90sHjaaSFxOT2srF1uD7FEd7HrISEi/O1lOpc
         c85wT/m2YvRWrd+Qpm80jJ/rPv608hI54n6qH3z3bk0Sjh25L9dZZBkeNbv/7jeAXKtm
         Dk5+Wy5H4il6jSyV9ryv5CGai92xdE6gBtxyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626302; x=1796231102;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z+1Z2Wduor/P0I6hU1tUUkvCPdhVaarBTXJS1VL+tFw=;
        b=uXyieMgeXta6bWt4OQhVcFrW5sbRJAuqKK6V8ogLX9JvmorXF/8c+kK/5cHKVEmrMO
         0DhPmRCuiLp1g2u4YppoGGHxTU+NFhNw1wvvt4AwNMuSld/wF3TjkegChksDYYrcCw1k
         h+8z21ZPjM4fZiJNoxExnPJhq+NY7KGo8aRdRLoe1kp/i2GxVLU2wBVwe7Po5Nn90J0u
         Frs1q3LpuGm/90BcDDpi1gswALkyrCIrxAPBQSB8Pdm5HSeF8ZQI07EW2OOm44B2nJuT
         z2g5RpIQqAbBWGa8UkolP80OpnivfwGI35VSoFnKDwYL3raKkPB5GoY1rJ7O4NZrbQKI
         Y35Q==
X-Gm-Message-State: APuU4Z9qoCIVaGa6j36zSOYouxE0rqq3vvCJGBlip11tAogWNw1nTPdI
	+ECAX+Vz4LJESEXaAPHTg/OqE6HiYU+fgRzwWQS1zTahdY6L4uWhxm1bFLcsvbQHE4M=
X-Gm-Gg: AZFdTZdzZH6qfYuNrgMwlO4CZiEcyweu201acgJUbT4BDwaTeqp4bcwSu3bVFRD6rQB
	y+8mzCKSr72N0oyUIzGoIGIbC+omjvRPHTxKgKy+g/vRc5+EKs4jQwzRBqtYS0DaiQplD0MB/wC
	r9U6XIFMH5fdVBEU/8zuSBlcv8diNuCQpPrfiwAaRzNNq2vGSX2vNpLCc8LcpVJSfcNphe6bHw6
	eMfBmX/tGKJ29/qCIv8RFcyOjGRxMAEIKTMK1WFT1eGrMfSQokv53IFGJR47kwjqcPrGeWcHia3
	X81w8UZgGHDo2h5TmleYwJpc1A+78Mqy475kG1m/ooutTLstawD8okki6Rr9Y5CB9+YCnj/EFyB
	jHO+N4SjYy3+Pph3AGywAuhxyJSnyYi0QYPuUlmFB+AZNcF/DI7VYWtWP7NtveqJa7wUUz4NASu
	Nud6uhK80H3bwqhGKLv4zN8sUTr5ZBNGr8mw6WqGtcbt0+YgfZkTJaEgsICtpPH7D/HznGv333N
	JjakZLSDuaHx2/nB0jsFjPRyLJmfa/S+CJFViwHbemKjLPddRqdN/I/1V4WvjixMCWm8Ry8lk3h
	3EOIOfodJxVVf1m2RCDO3JxnIoTuiHYEoU7XLN9xGW0gjZh3nRj5CZmzQVbVAJ1QPpcnFqSqEgf
	WR2uqNqk=
X-Received: by 2002:a05:6000:60e:b0:49c:fde4:1af5 with SMTP id ffacd0b85a97d-4abb9de7e8bmr34549538f8f.54.1795626302050;
        Wed, 25 Nov 2026 09:05:02 -0800 (PST)
Received: from ?IPV6:2a01:390:0:101:641b:80e1:c5fc:b7eb? ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm34944343f8f.37.2026.11.25.09.05.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 09:05:01 -0800 (PST)
Message-ID: <c16a2f13-d27c-488d-b4af-598f8e4a36bb@streamunlimited.com>
Date: Wed, 25 Nov 2026 18:05:01 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 2/2] main.conf: Add 'paired' to
 ReverseServiceDiscovery
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20261124131823.3848364-1-simon.mikuda@streamunlimited.com>
 <20261124131823.3848364-2-simon.mikuda@streamunlimited.com>
 <CABBYNZLxMmL0T6rTiMi+B+oJGTE_=2BqORgAqCUw1VW7+h7gtA@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZLxMmL0T6rTiMi+B+oJGTE_=2BqORgAqCUw1VW7+h7gtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz

Thanks for comments. I switched default back to true and reworded 
description.

Thanks!

On 11/24/26 17:06, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Tue, Nov 24, 2026 at 8:18 AM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> Reverse GATT discovery on a device that connected to us but is not
>> paired reads characteristics that may need encryption. The remote
>> answers those with ATT error Insufficient Authentication (0x05) or
>> Insufficient Encryption (0x0f), and bt_att then raises the link's
>> security level to retry the read, which sends a pairing request to the
>> device although nobody asked for pairing.
>>
>> Add 'paired' in addition to true and false to reverse discovery conf
>> it waits until the device is paired, and the GATT client of an LE link
>> that connected without one is started once it is.
> Hmm, actually it is not the reverse discovery isn't what triggers the
> read, etc.; it's the accept callback which causes the profiles to
> start the 'attach' procedures.
>
>> Set the default ReverseServiceDiscovery to new 'paired' option.
>>
>> Assisted-by: Claude:claude-opus-5-5
>> ---
>>   src/btd.h     |  8 +++++++-
>>   src/device.c  | 26 +++++++++++++++++++++++---
>>   src/main.c    | 29 ++++++++++++++++++++++++++---
>>   src/main.conf |  7 +++++--
>>   4 files changed, 61 insertions(+), 9 deletions(-)
>>
>> diff --git a/src/btd.h b/src/btd.h
>> index 9bf310271..2c897756c 100644
>> --- a/src/btd.h
>> +++ b/src/btd.h
>> @@ -48,6 +48,12 @@ enum bt_gatt_export_t {
>>          BT_GATT_EXPORT_READ_WRITE,
>>   };
>>
>> +enum reverse_discovery_t {
>> +       REVERSE_DISCOVERY_NEVER,
>> +       REVERSE_DISCOVERY_ALWAYS,
>> +       REVERSE_DISCOVERY_PAIRED,
>> +};
>> +
>>   struct btd_br_defaults {
>>          uint16_t        page_scan_type;
>>          uint16_t        page_scan_interval;
>> @@ -144,7 +150,7 @@ struct btd_opts {
>>
>>          struct btd_defaults defaults;
>>
>> -       bool            reverse_discovery;
>> +       uint8_t         reverse_discovery;
>>          bool            name_resolv;
>>          bool            debug_keys;
>>          bool            fast_conn;
>> diff --git a/src/device.c b/src/device.c
>> index 40d17bae4..3ece82c8d 100644
>> --- a/src/device.c
>> +++ b/src/device.c
>> @@ -350,6 +350,18 @@ bool btd_device_is_initiator(struct btd_device *dev)
>>          return dev->att_io ? true : false;
>>   }
>>
>> +static bool reverse_discovery(struct btd_device *dev, uint8_t bdaddr_type)
>> +{
>> +       switch (btd_opts.reverse_discovery) {
>> +       case REVERSE_DISCOVERY_ALWAYS:
>> +               return true;
>> +       case REVERSE_DISCOVERY_PAIRED:
>> +               return device_is_paired(dev, bdaddr_type);
>> +       default:
>> +               return false;
>> +       }
>> +}
>> +
>>   static GSList *find_service_with_profile(GSList *list, struct btd_profile *p)
>>   {
>>          GSList *l;
>> @@ -6471,7 +6483,8 @@ static void gatt_client_init(struct btd_device *device)
>>
>>          gatt_client_cleanup(device);
>>
>> -       if (!btd_device_is_initiator(device) && !btd_opts.reverse_discovery) {
>> +       if (!btd_device_is_initiator(device) &&
>> +                       !reverse_discovery(device, device->bdaddr_type)) {
>>                  DBG("Reverse service discovery disabled: skipping GATT client");
>>                  return;
>>          }
>> @@ -6970,6 +6983,12 @@ static int device_browse_gatt(struct btd_device *device, DBusMessage *msg)
>>          if (!req)
>>                  return -EBUSY;
>>
>> +       /* Connected without a client, as reverse discovery waited for the
>> +        * device to be paired: start it on the existing link.
>> +        */
>> +       if (!device->client && device->att)
>> +               gatt_client_init(device);
>> +
>>          if (device->client) {
>>                  /*
>>                   * If discovery has not yet completed, then wait for gatt-client
>> @@ -7627,7 +7646,8 @@ void device_bonding_complete(struct btd_device *device, uint8_t bdaddr_type,
>>                  }
>>                  bonding_request_free(bonding);
>>          } else if (!state->svc_resolved && !state->browse &&
>> -                       !state->discov_timer && btd_opts.reverse_discovery) {
>> +                       !state->discov_timer &&
>> +                       reverse_discovery(device, bdaddr_type)) {
>>                  /* If we are not initiators and there is no currently
>>                   * active discovery or discovery timer, set discovery
>>                   * timer on the bearer that was bonded.
>> @@ -7672,7 +7692,7 @@ unsigned int device_wait_for_svc_complete(struct btd_device *dev,
>>
>>          dev->svc_callbacks = g_slist_prepend(dev->svc_callbacks, cb);
>>
>> -       if (state->svc_resolved || !btd_opts.reverse_discovery)
>> +       if (state->svc_resolved || !reverse_discovery(dev, BDADDR_BREDR))
>>                  cb->idle_id = g_idle_add(svc_idle_cb, cb);
>>          else {
>>                  if (dev->bredr_state.discov_timer > 0)
>> diff --git a/src/main.c b/src/main.c
>> index 3a051c5a4..4003a9627 100644
>> --- a/src/main.c
>> +++ b/src/main.c
>> @@ -924,6 +924,30 @@ static bool parse_config_bool(GKeyFile *config, const char *group,
>>          return true;
>>   }
>>
>> +static void parse_reverse_discovery(GKeyFile *config)
>> +{
>> +       char *str = NULL;
>> +       bool val;
>> +
>> +       if (parse_config_bool(config, "General", "ReverseServiceDiscovery",
>> +                                                               &val)) {
>> +               btd_opts.reverse_discovery = val ? REVERSE_DISCOVERY_ALWAYS :
>> +                                               REVERSE_DISCOVERY_NEVER;
>> +               return;
>> +       }
>> +
>> +       if (!parse_config_string(config, "General", "ReverseServiceDiscovery",
>> +                                                               &str))
>> +               return;
>> +
>> +       if (!strcmp(str, "paired"))
>> +               btd_opts.reverse_discovery = REVERSE_DISCOVERY_PAIRED;
>> +       else
>> +               warn("Invalid value for ReverseServiceDiscovery: %s", str);
>> +
>> +       g_free(str);
>> +}
>> +
>>   static void parse_privacy(GKeyFile *config)
>>   {
>>          char *str = NULL;
>> @@ -1096,8 +1120,7 @@ static void parse_general(GKeyFile *config)
>>                                                  &btd_opts.pairto,
>>                                                  0, UINT32_MAX);
>>          parse_device_id(config);
>> -       parse_config_bool(config, "General", "ReverseServiceDiscovery",
>> -                                               &btd_opts.reverse_discovery);
>> +       parse_reverse_discovery(config);
>>          parse_config_bool(config, "General", "NameResolving",
>>                                                  &btd_opts.name_resolv);
>>          parse_config_bool(config, "General", "DebugKeys",
>> @@ -1473,7 +1496,7 @@ static void init_defaults(void)
>>          btd_opts.pairto = DEFAULT_PAIRABLE_TIMEOUT;
>>          btd_opts.discovto = DEFAULT_DISCOVERABLE_TIMEOUT;
>>          btd_opts.tmpto = DEFAULT_TEMPORARY_TIMEOUT;
>> -       btd_opts.reverse_discovery = TRUE;
>> +       btd_opts.reverse_discovery = REVERSE_DISCOVERY_PAIRED;
>>          btd_opts.name_resolv = TRUE;
>>          btd_opts.debug_keys = FALSE;
>>          btd_opts.refresh_discovery = TRUE;
>> diff --git a/src/main.conf b/src/main.conf
>> index c9906148d..b2c834244 100644
>> --- a/src/main.conf
>> +++ b/src/main.conf
>> @@ -34,8 +34,11 @@
>>   # BITE tester doesn't like us doing reverse SDP for some test cases, for LE
>>   # this disables the GATT client functionally so it can be used in system which
>>   # can only operate as peripheral (see also GATT Client option).
>> -# Defaults to 'true'.
>> -#ReverseServiceDiscovery = true
>> +# Possible values: 'true', 'false' or 'paired'. With 'paired' it is done only
>> +# once the device is paired, so that reading the services of a device that
>> +# connected to us does not start pairing when they need encryption.
>> +# Defaults to 'paired'.
>> +#ReverseServiceDiscovery = paired
> I can leave with it being an optional argument, but not the default,
> that said this may overlap with the [GATT] client support, although
> this maybe cleaner, but we can't really anticipate if any profile,
> etc, is not depending on the auto pairing logic.
>
>>   # Enable name resolving after inquiry. Set it to 'false' if you don't need
>>   # remote devices name and want shorter discovery cycle. Defaults to 'true'.
>> --
>> 2.43.0
>>
>>
>
