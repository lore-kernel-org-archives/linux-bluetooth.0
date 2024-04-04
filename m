Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14DD2D7A8
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 18:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255145; cv=none; b=pv6fXbXl/paGanAgoW72ExwQOxWgMjkLsYMOjWw3SoO2eK1PZXtcfjMdV49Ds5R588yJaBw1RYWJ9Ilc5vQN3yCXr/G9AwH8UYmkmDqXCT/b9ayvmOtDwaoWaeR0d/V4WomBr4R7LE9gX7VuAFh+VdyfP6kVzaO58wi5cP6FWZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255145; c=relaxed/simple;
	bh=QxgclVs17Yz6MV452a+HRdHIz7FpZkMzNAWkG6c3G1w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YR9zlKU+I+HcJ85oiRhGsV8hLrYjiSZxWFnhTLb9AnIE6+YTzbPbgd+eEnV2Q+pjMXrPwfaKkPQRZNd4hZmdKNy08GTcRlndkauxdtkKUnp9F5nPaPJpuj4AXZihpa7txICKPnyMTkpaTy4Dpp08DgEhsLgdZ9iqYydFqXDxViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MW9Nn+wb; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MW9Nn+wb"
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-1e0f0398553so11922475ad.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 11:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712255143; x=1712859943; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7eUnHgxUtZ4tXEHSfZ8IH158cx6smLatkx0jQJVFb0=;
        b=MW9Nn+wbK4My8AZHGPQOAJ6cnNiseHNnzXVzSp5gsevXoDNDIehM7BmZU0RuWQSjaC
         LrvS/tckWgjM2eSGPgifWxO7Ms1DezeYqXO1kKGnllRnJSVDDXakBRiCgS5PfbhLUUaM
         tHQPMlMTZZjYBMvL/dUwPWP1XmD1KyRJvdfyiI5AZyAz2rtW+GFzfNPL3FBTNSDgZwTD
         +fCQ67IXauq0RtrefRSRP2+GT0NdEZhsggWeeC8TA6zIjwui5P7e4tC1L+Nkl0wzGLER
         n+a0hMwOEFXBs42PJtutD3UwF4+WD6YjHrsPCmv3bXhjVJyNyvKVh1LejqouWpyeZsYE
         JqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255143; x=1712859943;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7eUnHgxUtZ4tXEHSfZ8IH158cx6smLatkx0jQJVFb0=;
        b=ZDofZQoqVjUhLR3Ap86Mh/el+EreL+s2Ns3WnzEVt9foc/RlyGxXlhcBYxooZxentB
         qQAA2AWn6lUq2KMjGDaWu7cbau3UZePiWUhMz65da1Tod28D+SShA/SnmaO2uJ4WuaOJ
         coYJrkHxsSkKRtNTAqzr+G+c4oAI9glerJ2IMHazsvItaskYWSkta5vygigVi+9TlmnQ
         jt9HfwFMF8kQ1lXIxg+8B2F0sH+D0BNWy+GTQN70WFJ33oKorApQ7L5OSnDjih/Cfh+R
         7He5gjc/RfI2j7XRI+QYuNJYighAqvkvM/sqlRTcWEH4UrpzhV3dAuRoxYH3uyfydn0b
         cvwg==
X-Gm-Message-State: AOJu0Yxw2xTMgPRoEK4lzdclKzrroBHtR6835hBVXxn1oKEfZo6zPwGL
	XRJ8wUxjMnFg4Gq0xmyV6eXouu+QbAIUPGRguPAt7qExg2qoyI0t9s6BnWTiupPmfYtJ
X-Google-Smtp-Source: AGHT+IF4NihMzFP/RxT/URAWBFd/yfPAojES44ZaulC5ZO+XRLfoFmFFknF3KpnaeBVJLqQ0geNNQg==
X-Received: by 2002:a17:903:230c:b0:1e2:36d:c67a with SMTP id d12-20020a170903230c00b001e2036dc67amr381729plh.34.1712255142725;
        Thu, 04 Apr 2024 11:25:42 -0700 (PDT)
Received: from ?IPV6:2600:3c0a:e002:7f00::1001? ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id y8-20020a17090322c800b001e26b7ac950sm6448303plg.272.2024.04.04.11.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 11:25:42 -0700 (PDT)
Message-ID: <18bbe5d0-a77a-4180-a468-1026ae16c4ac@gmail.com>
Date: Thu, 4 Apr 2024 11:25:41 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Refactor btd_device_is_connected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-2-dimitris.on.linux@gmail.com>
 <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
 <0f681858-fe53-4964-82f9-5f3c3ee903e3@gmail.com>
 <CABBYNZLmff+NWTp3=5S5g8nx=KxJ0=PgxT7v9viO_hS=U15=1g@mail.gmail.com>
Content-Language: en-US
From: Dimitris <dimitris.on.linux@gmail.com>
In-Reply-To: <CABBYNZLmff+NWTp3=5S5g8nx=KxJ0=PgxT7v9viO_hS=U15=1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Luiz,

On 4/4/24 09:16, Luiz Augusto von Dentz wrote:

>>> I guess the problem is that some service is indicating it is still
>>> connected though?
>>
>> Newbie question for sure, but: As this is happening in the code path for
>> "disabling bluetooth", shouldn't services already be disconnected here?
> 
> That is exactly what I would like to know, why is there a service
> still indicating it is connected if the controller is rfkilled, so
> while this should break it back to the old behavior we still need to
> fix the service that is causing the problem so perhaps we need to
> print its profile/drive name and figure out what is the driver that is
> causing it.
> 

I added a debug kludge:


> diff --git a/src/device.c b/src/device.c
> index 74dd67a09..c461a6a3a 100644
> --- a/src/device.c
> +++ b/src/device.c
> @@ -344,7 +344,15 @@ static GSList *find_service_with_state(GSList *list,
>                 struct btd_service *service = l->data;
>  
>                 if (btd_service_get_state(service) == state)
> +               {
> +                       char name[256];
> +                       device_get_name(btd_service_get_device(service), name, 256);
> +                       info("Found service: err: %d, device: %s",
> +                               btd_service_get_error(service),
> +                               name
> +                       );
>                         return l;
> +               }
>         }
>  
>         return NULL;
> @@ -3282,7 +3290,12 @@ bool btd_device_is_connected(struct btd_device *dev)
>  
>  bool btd_device_bearer_is_connected(struct btd_device *dev)
>  {
> -       return dev->bredr_state.connected || dev->le_state.connected;
> +       if(dev->bredr_state.connected || dev->le_state.connected)
> +               return true;
> +       else {
> +               find_service_with_state(dev->services, BTD_SERVICE_STATE_CONNECTED);
> +               return false;
> +       };
>  }
>  
>  static void clear_temporary_timer(struct btd_device *dev)

And it seems that every device I have available triggers this:  MX 
Master 3 mouse, Google Pixel Buds Pro, Google Pixel 7.  Ran experiments 
with each one of the devices being connected when running rfkill block:

> Apr 04 11:06:31 bluetoothd[331222]: Found service: err: 0, device: MX Master 3
> Apr 04 11:06:46 bluetoothd[331222]: Found service: err: 0, device: MX Master 3
> Apr 04 11:06:58 bluetoothd[331222]: Found service: err: 0, device: MX Master 3
> Apr 04 11:07:28 bluetoothd[331222]: Found service: err: 0, device: coral buds
> Apr 04 11:07:29 bluetoothd[331222]: Found service: err: 0, device: coral buds
> Apr 04 11:07:29 bluetoothd[331222]: Found service: err: 0, device: coral buds
> Apr 04 11:07:29 bluetoothd[331222]: src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free Voice gateway: getpeername: Transport endpoint is not connected (107)
> Apr 04 11:08:01 bluetoothd[331222]: Found service: err: 0, device: coral buds
> Apr 04 11:08:01 bluetoothd[331222]: src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free Voice gateway: getpeername: Transport endpoint is not connected (107)
> Apr 04 11:08:40 bluetoothd[331222]: Found service: err: 0, device: coral buds
> Apr 04 11:08:40 bluetoothd[331222]: src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free Voice gateway: getpeername: Transport endpoint is not connected (107)
> Apr 04 11:09:47 bluetoothd[331222]: Found service: err: 0, device: p7
> Apr 04 11:09:47 bluetoothd[331222]: src/profile.c:ext_io_disconnected() Unable to get io data for Hands-Free unit: getpeername: Transport endpoint is not connected (107)

The BT adapter is a Mediatek MT7922 WiFi/BT M2 adapter, seems to be 
using the btmtk driver.

In parallel, I've sent a V3 of the "bring back previous behavior" patch 
with the new function named btd_device_bearer_is_connected.

D.
