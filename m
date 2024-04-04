Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A905026E
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 06:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712212559; cv=none; b=WB0FXEUqxe4bVFuF3YnGDnfpN0KfVaFMcjRf/uttdGqGfpTnWqe4k8Ir09vVj5fH3AzhATQojvn3U6hQw9ho2Iy5b5HTXWdCzj6BUEW7YEI+fsnlw2AoHPVrJo45OPCO18ewsT67iWgzaFG9hTMX4Dq5Aps57enMnVDjuLnGOUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712212559; c=relaxed/simple;
	bh=8M4hIrlK2uR6e5vTScV7TVav+ErpZMQnMSWb35WlyA4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PHA/QdwdED7JbYV+fJk2NEBjt3lcSly7QHdeppKkLsfzHPyL8QTlH4MDR7cdA4gDP48q9w+9SQBLUj6/BkxaKj8CfjuV1Q6QIZLdZNepFdfIKH79dWp7OPOn+i8zkEIiOd/oq9NxmzoShDDWGiQagHKz4AQWM+wA3ixmTQMq+rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUhbbttC; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUhbbttC"
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so541804a12.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Apr 2024 23:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712212557; x=1712817357; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K3OVNybMFs0FD/o9yBx03xj8cW+nFxr91pjuCnSQOmQ=;
        b=CUhbbttC3IeHtx9Nk5dCzrrE17Ylf0PuYMnTatH5ULWBgh5HoN6aIWXffsikkwVlr1
         iXZU/z0okwnpffhzMirSbYsTmv2jpH7kvO1jLHbo7pxrDBg1aZs/yrgRs+x/FTif+km4
         8OlUmOTJwviFhj5fEUlYQrgBs9UlObu30FrL6mWqTkytvYhYlsAFlpGAPyBpiQq9ha/a
         w/pBbvc6VU4vkiZLiOMLuMc664xX5FY4WrajLg/3XWxtXyZ0syLCs7DbcVbkz8VpYn4u
         s0Y/2ie8x+uHwHuWCIpt/lCe4/rRO47HI1ykWr4YjNGn6z3KsAZbyNXdlFFGFU98xiKM
         WlAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712212557; x=1712817357;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K3OVNybMFs0FD/o9yBx03xj8cW+nFxr91pjuCnSQOmQ=;
        b=f6uDh7ojzeVFT4A+kVYCGyqcSWo3ZmGl0dOxxiECdZ6Abi0RQyjFtSxIFAq4dL5kxt
         B/diXTRqs8VDusGaM5jpZtT8JisKIHRRjG5ZOZ7IzNADo1rdlaLllWwsZP79hilirJaP
         BdcJ3LS7yIFLV35JTNreHeh3Ugo3/tctAwkrpjjw/YyEkQIBF1bWgfpmZYdptVO6O1JC
         FdsrB/J6ogUZ+9Kclk6/CfWyhPsAQoN6hCK5HyaK8QAP/srvobOGvUKhCGYq09rKNs8X
         1LnRTpET3oD/i04oXvnVX21x4VK6aCU+JK9zhOpDjVB8V6PstqFY+Ki+rYTI5RlZ61gq
         hOPQ==
X-Gm-Message-State: AOJu0YxbsxB9PR5vsXoyqu2eXDujMbvGqz8KZ5y39acRtHKGCn/R/94O
	UcOfweGgraCt/t8K8mw9sEiKXIwvI4oru+aV7i5vNJEcZKQPzLPF9T7o81FlV7k8Yhns
X-Google-Smtp-Source: AGHT+IFDRu4sx4d9Tm1D6pr6aJYbgpN+2Sj0HuDE3f3IICe5AY4/fZIGywzFXQDZJd3KTfCEAsrRTQ==
X-Received: by 2002:a05:6a21:1506:b0:1a5:6bfd:6bdd with SMTP id nq6-20020a056a21150600b001a56bfd6bddmr1975963pzb.50.1712212557413;
        Wed, 03 Apr 2024 23:35:57 -0700 (PDT)
Received: from ?IPV6:2600:3c0a:e002:7f00::1001? ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b001e249843f3csm9873741plb.223.2024.04.03.23.35.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 23:35:57 -0700 (PDT)
Message-ID: <b7769335-3af4-469a-bf58-a3a51f03c842@gmail.com>
Date: Wed, 3 Apr 2024 23:35:56 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Revert "device: Consider service state on
 device_is_connected"
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-bluetooth@vger.kernel.org
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240403205252.71978-2-dimitris.on.linux@gmail.com>
 <06c64895-a99b-4705-8965-d8ea66eef74a@molgen.mpg.de>
Content-Language: en-US
From: Dimitris <dimitris.on.linux@gmail.com>
In-Reply-To: <06c64895-a99b-4705-8965-d8ea66eef74a@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paul,

> Please document the reason for the revert.

I've since done a narrower change; instead of the revert I'm only 
factoring out the state check that avoids the busy loop at "rfkill block 
bluetooth" time.

Updated cover letter and patch under the "V2" part of the thread:

https://lore.kernel.org/linux-bluetooth/20240404024521.120349-1-dimitris.on.linux@gmail.com/T/#u

Issue steps to reproduce from e.g. 
https://github.com/bluez/bluez/issues/785 :

- Connect at least one device. Tried this with either one of: Logitech 
MX Master 3, Google Pixel Buds Pro.
- Run rfkill block bluetooth
- bluetoothd takes a whole core, GNOME quick settings and status still 
shows bluetooth as "active". I have to kill -9 the process to get the 
block to really complete.
- Turning off the connected device does not break the loop.

Busy loop stack looks like:

> #0  adapter_remove_connection (adapter=0x55a17e6889d0, device=0x55a17e698d30, bdaddr_type=2 '\002') at src/adapter.c:7476
> #1  0x000055a17e55979f in adapter_stop (adapter=0x55a17e6889d0) at src/adapter.c:7527
> #2  settings_changed (settings=<optimized out>, adapter=0x55a17e6889d0) at src/adapter.c:622
> #3  new_settings_callback (index=<optimized out>, length=<optimized out>, param=<optimized out>, user_data=0x55a17e6889d0) at src/adapter.c:705
> #4  0x000055a17e59981e in queue_foreach (user_data=0x7ffe49a7ef20, function=0x55a17e591e60 <notify_handler>, queue=0x55a17e683280) at src/shared/queue.c:207
> #5  queue_foreach (user_data=0x7ffe49a7ef20, function=0x55a17e591e60 <notify_handler>, queue=0x55a17e683280) at src/shared/queue.c:190
> #6  process_notify (param=<optimized out>, length=<optimized out>, index=<optimized out>, event=<optimized out>, mgmt=0x55a17e682f30) at src/shared/mgmt.c:349
> #7  can_read_data (io=<optimized out>, user_data=0x55a17e682f30) at src/shared/mgmt.c:409
> #8  0x000055a17e5bb679 in watch_callback (channel=<optimized out>, cond=<optimized out>, user_data=<optimized out>) at src/shared/io-glib.c:157
> #9  0x00007f876edd4e5c in g_main_context_dispatch_unlocked.lto_priv () from target:/lib64/libglib-2.0.so.0
> #10 0x00007f876ee2ff18 in g_main_context_iterate_unlocked.isra () from target:/lib64/libglib-2.0.so.0
> #11 0x00007f876edd6447 in g_main_loop_run () from target:/lib64/libglib-2.0.so.0
> #12 0x000055a17e4f1d64 in mainloop_run () at src/shared/mainloop-glib.c:66
> #13 mainloop_run_with_signal (func=0x55a17e544740 <signal_callback>, user_data=0x0) at src/shared/mainloop-notify.c:188
> #14 main (argc=<optimized out>, argv=<optimized out>) at src/main.c:1455

First time submitter here, should I resubmit/start a new thread for this 
"V2" approach?

Thanks

D.
