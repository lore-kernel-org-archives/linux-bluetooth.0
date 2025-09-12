Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D96301018
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757691840; cv=none; b=Rhh/2kF1hpzrY63nVdOEFlxxmjnZJGi+0pkJB5fbfgPQ/h48hi9nsBaDEvZq57NIw0bOtyTzFQkcd33oFdRJi2yF2vuB6STNj4kyHsCrbkhXyrcu1D4AO5IuGCXAILrUzHSrAq0ToaJ8cQtHRMuYdQPpP35NnaiMfQODkJHkPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757691840; c=relaxed/simple;
	bh=/IF4MI9eGRI5duhi9fg2DJnP5wHEq0kiYjMDWejHQ/8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zta/AVxJ9FXPysIq4BLcsfxzEogKBeOGR2u0eJ8zlFnr2AS63FAtjiu0CS232iTYNZVp3y3U/vbmCeRaOY4FYuPJMdrxXmoWVuq4xZRCYjATMqhN/dguxhdR8vQ+sbeD97s9tAkO02uGCHY7G6+R2FGcGevFFrx6hgHlOooJJlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N6mg3yl/; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N6mg3yl/"
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id DB29F4196F
	for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 15:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1757691835;
	bh=WPTEWkxOaL5biqIQ1Hgk3QxnNrHSt84fwCIIuoDMSKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type;
	b=N6mg3yl/Kp7y+IttfHIKP/Ef/Zx+o2aXiNEX9XG3dx1zFP9jFdXMCsnauZWEwlx6D
	 s6AJmaswxkJwVojdjqOFgEdB5QM+at4FzD2gJK60K4BE71AjsDnAaFNLjmPBBOn78E
	 Otqd5gyJ7lSKX9fFX49Y5c+fmiUVzvwfD63w5nmI8baHSf9b6KichamuuG/ZWjA/vh
	 F66GoMBbHdSkqU+1am9cRE1EGUNff75wcGtsEi2SUHmePExRoGiY2qfUr4l6YmymPL
	 Kd3cZ5+BNTcpWr2xg60x3H85HTC6eC6DxLbMtaMuYShPZbMqaYFwgQ/ps70kjiUm4Z
	 oEi3JBEAtxCEg==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b07d487c9feso3690766b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 12 Sep 2025 08:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757691835; x=1758296635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPTEWkxOaL5biqIQ1Hgk3QxnNrHSt84fwCIIuoDMSKY=;
        b=SiWgeXguRAtNIkEcxmIMiruh+B2JmVYTog68cQxjpZdaXz+r3ZNQTOMYHC20cuG5KA
         UNcbNin8tbvq5/03zC6jZyXBZ+dcUKlIj0Xp9WhJ4EueqtThosr/5XrClDruv+wENsow
         L3HHa+ItW8bRcZwBddM5TYQMu1oI2tt+RZgFn2yG+6qmTM0rtgNcujWtl4LQ7w1roaPX
         eP6tCt7vYvySST2mSzJUz/LPW1ECpQ2RSFTl1d/L9+B+X/Vc0ca8GJO/R+g1A5jQcys7
         XAyipGQvE4mAdEakdUSP+JMaVjhCbmNzx3vP9yGkxm94/cEh0V5pnY+cirfAaF3V7eva
         OvzQ==
X-Gm-Message-State: AOJu0YzY4XzMnhHgnta25Y+PhxJKeGol7q6hDkzo8dyaI+ulHm7mT4PU
	rY8n4i1/selWMlzd+jpFSGek6pROl3PD2BqX2uggC2PGvS/Ozt2C9u8FKheIM3btJQaSX0c0pCu
	C8cu42qCbflrks29ptZAQac5wf2iRyyJPDQkPsNKHbrvaBJfl8DBF6HhNwsi2cwNSqb0PsaB9DB
	PEKdWStW4J+k4saXmOGA==
X-Gm-Gg: ASbGncv1IhEELp/DjFOPwPBzKuwxH3LPURxNaHftvcUANOT75Z1Kdnzx/6XJEaOaW4Y
	8Bo9vuM4gR2xR7Zt0Rk2Yi3mvYEYXub3lgcKAUDNlCHLtc/M9NbMWgvurvdAWQwC7dpsLAIxCp4
	oi8wcaVmsurRcEBgI4iYirpSKaggUP4TPXEyHRsF/fCctbQhYdCsRdnmj6BlhP9TlZMEP7zZafh
	dpId6cBoT+sBZDnskNW/gxGA7RNHodFy7QhOe9FT0RPHg2Ahnd6RcPjotfjZyu/4jwrEEfuxuBR
	VCMOMz/6ivIBuNeovSXf/cihzdzvdXSp8Pk7/aoelT6hDPPFhxVicY45D/L82Hu363sWPO2TMxj
	NfzPUQdWnR8DFLaSWT+cQ1Q==
X-Received: by 2002:a17:907:3f95:b0:b04:36bb:54e with SMTP id a640c23a62f3a-b07c353ff38mr176044766b.1.1757691835275;
        Fri, 12 Sep 2025 08:43:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHACjZlcoUjdr2Di8czZuYlwT3EK+AK5sA9Cs+y8nCvilgrvyjavVvhKgdjb4NS+8NBCGbCVQ==
X-Received: by 2002:a17:907:3f95:b0:b04:36bb:54e with SMTP id a640c23a62f3a-b07c353ff38mr176042466b.1.1757691834801;
        Fri, 12 Sep 2025 08:43:54 -0700 (PDT)
Received: from [10.0.0.64] (188-23-192-136.adsl.highway.telekom.at. [188.23.192.136])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b32f202dsm393948566b.84.2025.09.12.08.43.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 08:43:54 -0700 (PDT)
Message-ID: <9ac417b8-f531-40ed-9d8e-7b2c03e0e53c@canonical.com>
Date: Fri, 12 Sep 2025 17:43:54 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] src/adapter: add timeout for missing discovery
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250912103550.49240-1-andreas.glinserer@canonical.com>
 <CABBYNZLnZ_E93uf5ReLQzgXsny8O6QmOcSj=ci5O_0Xtb-UdUQ@mail.gmail.com>
Content-Language: en-US
From: Andreas Glinserer <andreas.glinserer@canonical.com>
In-Reply-To: <CABBYNZLnZ_E93uf5ReLQzgXsny8O6QmOcSj=ci5O_0Xtb-UdUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 9/12/25 16:15, Luiz Augusto von Dentz wrote:
> Hi Andreas,
> 
> On Fri, Sep 12, 2025 at 6:36 AM Andreas Glinserer
> <andreas.glinserer@canonical.com> wrote:
>>
>> Add a timeout to detect when the controller stops sending discovery
>> events. Without this, the system silently discovering new devices
>> and the scan list gradually empties due to DEFAULT_TEMPORARY_TIMEOUT.
>>
>> When the timeout triggers, issue MGMT_OP_STOP_DISCOVERY to restart the
>> event loop and resume discovery.
> 
> I'm not really sure how sending stop would make any difference?
The correct technical reason I also do not understand. Sending the stop 
gets the controller out of the (presumably) faulty state and correctly 
starts rediscovering. To get to the bottom of this, I am missing more 
fundamental knowledge. My first assumption was, that just sending 
another start discovery would work, but this returned a busy. From this 
I concluded, that the controller is doing something and stuck at doing 
it. The next logical thing for me was stopping it by sending stop which 
is working and getting the controller back into a working event loop.

 From my testing I can see it is not a hardware specific issue. I had 
this issue on the following devices/bluetooth controller on different pcs:
- Intel Bluetooth 9460/9560 Jefferson Peak
- Mediatek 7925
- Intel BE200 usb device
> 
>>
>> Link: https://github.com/bluez/bluez/issues/1554
> 
> The bug mentioned BlueZ version 1.72?, well I guess that is 4.72 which
> is very old, have you tried with something more recent?
I am terribly sorry, version is 5.72 (Ubuntu 24.04). I also corrected it 
in the GH issue. I see this issue with 5.79 (Ubuntu 25.04) as well.
> 
>> ---
>>   src/adapter.c | 35 +++++++++++++++++++++++++++++++++++
>>   1 file changed, 35 insertions(+)
>>
>> diff --git a/src/adapter.c b/src/adapter.c
>> index dc5ba65d7..1ec665c73 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -342,6 +342,7 @@ struct btd_adapter {
>>
>>          struct queue *exp_pending;
>>          struct queue *exps;
>> +       unsigned int last_discovery_timeout_id;         /* Timeout for discovery stop if no cb is coming */
>>   };
>>
>>   static char *adapter_power_state_str(uint32_t power_state)
>> @@ -1727,6 +1728,11 @@ static void discovery_cleanup(struct btd_adapter *adapter, int timeout)
>>                  adapter->discovery_idle_timeout = 0;
>>          }
>>
>> +       if (adapter->last_discovery_timeout_id > 0) {
>> +               timeout_remove(adapter->last_discovery_timeout_id);
>> +               adapter->last_discovery_timeout_id = 0;
>> +       }
>> +
>>          g_slist_free_full(adapter->discovery_found,
>>                                                  invalidate_rssi_and_tx_power);
>>          adapter->discovery_found = NULL;
>> @@ -1833,6 +1839,8 @@ static struct discovery_client *discovery_complete(struct btd_adapter *adapter,
>>          return client;
>>   }
>>
>> +static bool time_since_last_discovery_cb(gpointer user_data);
>> +
>>   static void start_discovery_complete(uint8_t status, uint16_t length,
>>                                          const void *param, void *user_data)
>>   {
>> @@ -1900,6 +1908,20 @@ static void start_discovery_complete(uint8_t status, uint16_t length,
>>          trigger_start_discovery(adapter, IDLE_DISCOV_TIMEOUT * 2);
>>   }
>>
>> +static bool time_since_last_discovery_cb(gpointer user_data)
>> +{
>> +       struct btd_adapter *adapter = user_data;
>> +       struct mgmt_cp_start_discovery cp;
>> +       DBG("");
>> +       cp.type =  get_scan_type(adapter);
>> +
>> +       mgmt_send(adapter->mgmt, MGMT_OP_STOP_DISCOVERY,
>> +               adapter->dev_id, sizeof(cp), &cp,
>> +               NULL, NULL, NULL);
>> +
>> +       return FALSE;
>> +}
>> +
>>   static bool start_discovery_timeout(gpointer user_data)
>>   {
>>          struct btd_adapter *adapter = user_data;
>> @@ -1909,6 +1931,9 @@ static bool start_discovery_timeout(gpointer user_data)
>>          DBG("");
>>
>>          adapter->discovery_idle_timeout = 0;
>> +       adapter->last_discovery_timeout_id = timeout_add_seconds(
>> +               IDLE_DISCOV_TIMEOUT * 3, time_since_last_discovery_cb,
>> +               adapter, NULL);
>>
>>          /* If we're doing filtered discovery, it must be quickly restarted */
>>          adapter->no_scan_restart_delay = !!adapter->current_discovery_filter;
>> @@ -2009,6 +2034,11 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
>>          if (!btd_adapter_get_powered(adapter))
>>                  return;
>>
>> +       if (adapter->last_discovery_timeout_id > 0) {
>> +               timeout_remove(adapter->last_discovery_timeout_id);
>> +               adapter->last_discovery_timeout_id = 0;
>> +       }
>> +
>>          adapter->discovery_idle_timeout = timeout_add_seconds(delay,
>>                                          start_discovery_timeout, adapter, NULL);
>>   }
>> @@ -2053,6 +2083,11 @@ static void suspend_discovery(struct btd_adapter *adapter)
>>                  adapter->discovery_idle_timeout = 0;
>>          }
>>
>> +       if (adapter->last_discovery_timeout_id > 0) {
>> +               timeout_remove(adapter->last_discovery_timeout_id);
>> +               adapter->last_discovery_timeout_id = 0;
>> +       }
>> +
>>          if (adapter->discovery_enable == 0x00)
>>                  return;
>>
>> --
>> 2.43.0
>>
>>
> 
> 

