Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914254;
	b=ULWHY8q8EqcBihOb50aOa9tqWELzFthFZ1R+xlZr7dAgBQx5gH4J3Ygux50QzFxIJr9U
	 22v9V3XSTsZAhLJGKf4dNDZp4fg+WSX7erdEgovwS9itNYUWEeAzucORcT9CdIp9DXN79
	 2WJBjErULLO51smQLLnYOIZXQ2PxCZy3HgRS3rPDxteSucp8vL6fPINPqYAzdaqbd0/HI
	 5RPmLED6i0bxLR1S8lcCdArQAzpMDYz5GqgDtr2XGJivaE50u567I0laTMCPUknkBpK3U
	 b9DXBSntERqMyoXiG3M4og8ZNzrEGwNiwIUXC3ovdxHWlEyMMnwmD8W1vCEo2KEe5wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914254;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:To:Content-Language:From:Subject:Content-Type:
	 Content-Transfer-Encoding;
	bh=h5dwP+J0pikfHmn14P8uKG8YB4Qt1bUrFyirRsB2r1w=;
	b=X/bBHQhAM8UtGT315dW0wQuINHQzAUgXptxhBFaitbIsINMgpd8/GrlRbXN5iSpYZRgw
	 ixZHIHWrpxArQXpx/BXg8B/qSqQNX7taQ4BRMzDnZAPHvzVQEUBs6j+87Qts9hORQ8Glb
	 RDYTdbJ0dpI0IE2KPnpfnsGmTmyhzA5bSX0a6ll57v0G1NgB182ZwYHx/J3O/fkbLLTWF
	 lsrISeHx3R8iElpvOVMRis5tUbpn7GPrhf3q0we4o9jXlm2hZhPdI6pmmgKxY+DCpn5S5
	 sANnjVooN8kuMwYhzduiUvTabAgig4yPEmVU4FeJ6Y66yfFWR9Fvx50mJ6LOaWy+Wgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzgEjb2e;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE0F606A329
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 21:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FE0F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YzgEjb2e
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b0b3754f57so4233a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 13:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793914254; x=1794519054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=h5dwP+J0pikfHmn14P8uKG8YB4Qt1bUrFyirRsB2r1w=;
        b=YzgEjb2e5d1WJmDApuIcv3GK7Tu31riGNGo8cdLC5GcW8O74odHXNMUyYOzktUD7SR
         7iv8Nj3NCamASTbHols6u7CnHZywWwc0w4fR8JI4X+cGRwMqIUzxzi25pFmo0/VF3b8r
         ooyY7Fi1s3dV/YCK9AvKttpnhax74cTxbVOgl3FS1YvbW5ZdLyBO8N+8wC17BnkI6pMx
         eAo3f/u4RjKkL3oCklI9cq73zUpr5+Fl7Brhpuj/QfpITal2waJZe6wHx3Q9yIudehEe
         oH0VhXhdfm9nq2YDPGQMkAB8311KzmZCBRKKDPtmqLwT//Z8Wlc4VrUO1u6O6rcwdGue
         KuYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793914254; x=1794519054;
        h=content-transfer-encoding:content-type:subject:from
         :content-language:to:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h5dwP+J0pikfHmn14P8uKG8YB4Qt1bUrFyirRsB2r1w=;
        b=M8UsiRVxkEQ6A7WS+ckTWPOC0/+J7KtuLBvsb30eJ5IKFs2OB4FuK5LEIzxkakkgMj
         b0cv72ADbHjRRD+Vp9b0bqkzUwVVLlN7YtzWaPDFlMx/aLKgbeimTMKnq1ZI3ZUTypKb
         jdXNJ873c1hEGR4XJwQmzqUQuVV65ynYzaVOGN8iRLO/0XYIRJwxnplOhOURfGxY05wT
         bE7QazIYnanSDQ2z+zQP7UYbNsotqitI2u5sReCR3pBv28vCRF3PeNwQep8qAfLCMeKg
         KJJfbDAfZo1ZFn4rSrrjDRgzSw1S4v6n4zJjvL7/gPuANGmgN8sTBl+x+9CxgRAHNHe5
         Ki9A==
X-Gm-Message-State: APuU4Z/AFmWdrXt+f1uzwyNWXmTtTdipMhdte7CfyKUtz/j7Lk1l2CBh
	XGxrY6mIgJmL5l/5HXU7EUy7nL+GGPghjrXoZgJHlqwERDldGAU8fHejLuqZ
X-Gm-Gg: AYBFou0DAbG8KFpCz3qxnvp0lAV9Z3qGbnmXvFXr6FO3HQ+lvqf8ENW5ARIsXa1Y1J6
	qCpkEuFRW/X4T0chzk4piHyfwGAxRZrs2/Pq3+fOlrMahu14CGe0Ezak9XYStbEtsblBR9zV1/y
	09f+YSs70+DgcRnZWGbclGGJHyqv03dZXkDgAA398thglI5LBpsrMyUsNiVXLSYkzO2n2EVCcEk
	sWUkwreY2rAcLKaFHzMhDmZcN24rilsUCCzfa4borzkPnRojKLE4Gh6L+E0unem1zsUYAP5MFfa
	9cw7BM5JfYTgHvIHLCgBz+UIHIdKdEYdaMLpuheo5yrQvfURWwZRHVck29/Ehn1NgVdTBA5LVB4
	vlSeiBx1Na57n0LNQtYPV498JYAa6jmn6ZrwTW5V7JZSN56WE63cyGcKgVlRYQX17oDAsNpoWlE
	qKMwD0vuLkPaxU1wsqLp1c9/F5zA4p9ZA0BJ76js3/yBa3AS24h2phrSQ+6z68Tg7Fab1BfUZlF
	RY9+eEzn7GE41+dOtTGfs86o8yz1GTo9devVyH7MDL/E+i/wrROEv3JpC0hnK0ngD6i0B88/4V+
	+cnbG4TCD0vOqPNIPPRerH1LxQ8hx7h9yB5Ojh4VSI9o4aVMLJd21Jwah8+cfrJk
X-Received: by 2002:a17:90b:270e:b0:3b0:ac2c:1619 with SMTP id 98e67ed59e1d1-3b0db70a2b5mr273477a91.39.1793914253567;
        Thu, 05 Nov 2026 13:30:53 -0800 (PST)
Received: from [192.168.10.136] ([27.147.237.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b313c143sm5211775a91.2.2026.11.05.13.30.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 13:30:53 -0800 (PST)
Message-ID: <ebfb1f3b-99f4-42bc-b79a-5085af6824ae@gmail.com>
Date: Fri, 6 Nov 2026 03:30:49 +0600
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
To: linux-bluetooth@vger.kernel.org
Content-Language: en-US
From: Arka Bhuiyan <arkabhuiyancsedu@gmail.com>
Subject: Sony WF-1000XM6 call audio fails on Linux: first eSCO setup gets
 0x1f, then ACL timeout
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

My Sony WF-1000XM6 does not carry call audio on Linux. I'm sending this 
to report the failure and the evidence I have. I don't know whether the 
bug is in PipeWire, BlueZ, the kernel, or the device, so I'm asking here.

My setup

- HP Victus laptop and a personal workstation, both with Intel AX201 
(8087:0026).
- Kernel 7.3.1-1-cachyos (linux-cachyos 7.3.1-1), bluez 5.87-2.1, 
pipewire 1:1.6.8-1.2, wireplumber 0.5.15-1, linux-firmware 1:20261019-1. 
PipeWire and WirePlumber are pinned, so these are the versions running.
- Firmware loaded: intel/ibt-19-0-4.sfi, Firmware Version 83-7.26.
- Earbuds: Sony WF-1000XM6. I haven't checked its firmware version yet.
- I also have other Sony headsets and see the same failure with them. I 
haven't captured those yet.

What happens

When a call starts, the host sends an Enhanced Setup Synchronous 
Connection command. The controller accepts it (Command Status: Success), 
but no Synchronous Connect Complete follows. Later, an SCO Connect 
Complete arrives with Unspecified Error (0x1f) and handle 0xFFFF. About 
1 ms after that, the ACL link drops with Connection Timeout (0x08). In 
every failing capture I have, there is no codec exchange (+BCS or 
AT+BCS) between connect and that first setup.

How to reproduce

1. Pair and connect the WF-1000XM6.
2. Start a call in Teams for Linux, with nothing else changed.
3. Capture with sudo btmon.

Evidence (btmon times, in seconds)

- Cold run: setups at 26.02 and 50.12 are accepted with no completion. 
SCO Connect Complete with 0x1f at 46.345 and 62.114, each followed by 
ACL Disconnect with 0x08.
- Debug run: Enhanced Setup at 83.73 has no completion. SCO failure with 
0x1f at 104.078, then ACL 0x08 at 104.079. Another failure at 123.558. 
Before the first setup, the only HFP message is +CIEV: 2,1.
- Call capture: Enhanced Setup at 76.276, no completion. SCO 0x1f at 
96.628, ACL 0x08 at 96.629. The first codec exchange comes after the 
reconnect.

Workaround

If I force the codec exchange first, the setup succeeds. Before the 
call, I run two short capture streams: one on mSBC, then one on LC3-SWB. 
In the primed capture, +BCS: 2 and AT+BCS=2 come before the mSBC setup 
at 23.733, which succeeds at 24.19 (eSCO, Transparent). The LC3-SWB 
setup comes after +BCS: 3 and AT+BCS=3, and it also succeeds.

In a real call with the workaround, the mSBC setup at 43.23 succeeded at 
43.63, and the LC3-SWB setup at 52.22 succeeded at 53.28. Audio worked. 
There was a brief drop of about 1.2 seconds while the link switched.

What I ruled out or haven't checked

- Duplicate device records: there is only one record.
- Multipoint: it still fails with the phone's Bluetooth off.
- Wi-Fi coexistence: not tested properly.
- Firmware: not confirmed as the cause. I haven't compared it with the 
September update.
- CVE-2026-90255 and commit 0f00cd322d22: I haven't checked them against 
the 7.3.1-1 source.

Questions

1. Is it expected that a controller accepts Enhanced Setup Synchronous 
Connection and never completes it, with no earlier error?
2. Should the host time out sooner than the ACL supervision timeout?
3. Should the codec selection before the first setup come from the 
userspace implementation (PipeWire here) or from BlueZ?

I can send redacted btmon excerpts on request. I won't attach raw .snoop 
files or /var/lib/bluetooth info files, since they contain link keys.

-- 

Best Regards,
*Arka Bhuiyan*

