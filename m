Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921840;
	b=hfGNZOcCkbyS8q+86scPAvWdVtqR/uy2dVwdfuwVDeUVph5gFySgb1I/fVYVkxu18bYo
	 IFotpPMZI+mhXjShZntNkdVx1PpM1ogoquxcfIYZIcHM1k8mG+TXq1MquWpNTxJvaAtw9
	 nRjP+SiNL7P5hfWlrmOaUNrhXYODPoaLVjeVG8dIvjC+n62wVmZ9bHKuYA18lz4Cezbp3
	 kBq9pJOFNOCX/4JxG3oOlRXY2yumEj6Vy/Y5iqz9g/sUxOyMf4vO28pjquNJ6QNQ7zg3/
	 89a6NARmGuK8QXLXmx1ovjHsK96vfrFlAo8JwE+TKoMLkk/IgNxI7p8tOjxMPFGcbHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921840;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:From:To:References:Content-Language:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=5/QU/tsnMyYacM6LznbPidHfqooX7ZG1j/M787PNygU=;
	b=J+rzIg8QIVIXR1Vi3TFwx9MklQXpZBegHNCykpe7iTls0q4SAC++zOZZo3QbQtav0+5Y
	 tUKttNN/vMCZrwNkRg6Q6qa/EAHjkCKbtRvTWkLt+AaO2i7M/5tSZZ/87lRTPKFx9q4Uj
	 FcsuH7Vl9OssNL5YQyPNBa0oDHuaDO8HcXWDWfuqD0Nh7pl65Ap+1d8TJRRCr6wwkjn5A
	 qS55exCGlmXlFC2P6k/c8epJ+GhvAxpNNGH4e3SC7a/1kp2H98ySdTSJ+TJG5u9aoCzSI
	 9hnD9+lxTyt6fbJTdadV2sGCgzH41zWXlFIr9QN6vhrd60KRGsqLE3YrpYmHu2ojyDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwqPXbLX;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2885606A31B
	for <linux-bluetooth@vger.kernel.org>; Thu,  5 Nov 2026 23:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2885606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MwqPXbLX
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso34403a91.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Nov 2026 15:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793921839; x=1794526639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5/QU/tsnMyYacM6LznbPidHfqooX7ZG1j/M787PNygU=;
        b=MwqPXbLXFX5ymK5ETWBQwnJo3O6nzx8vvLFMz4f4QSxFW1fS1/Vsit/7qYbOdZjIui
         vLUFyMdwkEKQpfuwo1+4LpJo1r7GNfHg/KavFfS91R8GwoRS6yM4vr3tSjjPzWAIlqdd
         129fT9XyI7VT6swRiuRBjF7g/6CQ8tMbq7U5AXcAltgPw7DJ8JcMW3I63oO/0wBxkH2g
         Q/FCISSZjUcWT+dVip3EagaslIu8xr1GxmPfX//wOOS42buj8da0KfNQVPj5yMx9nO6G
         QdOcBXY4YiEvR+s/YXy+TbbOuCKFQCJ1NG9BwXG5v4DXb3qL9mSBd5i5XDIz0oXu5xma
         7YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921839; x=1794526639;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5/QU/tsnMyYacM6LznbPidHfqooX7ZG1j/M787PNygU=;
        b=acuXPN0NaHJSEMO4iZ8AnSLB9aoYw3lCSkzDRDdStjC1L6Kb8O8oAfPo+s1lpIhCwx
         lHKFhCkaj9Wl09VB8Ah/H7CQqsoRtbxaw6VnhwjwUXrh+2tahI+gDe99KEwHfZqkfO88
         FujhjTfzqaPGrZtLyVUyggYdDzlhSsNbmk6pmf0p/fzVO4fiW7M+hiZ0rgn0O2o6xG5b
         t9Np/vP+60YjpqC5ZGMJr8HiD+ebnkW+IoxHjo1+w4gnWjR1MgkB0RfRP1TVdMGl5j8u
         afSOyYsXPGjuLY4Bc74Bu0HdJBNC7okCoDIZlAwOfYzcyn2NFAsEoDRbAmG3vWxWajmH
         9iIg==
X-Gm-Message-State: APuU4Z9MwSdYgMOp5ToEAwdqR7QfdgbkcsTVrgE3C5TB76dsLLJXUeuw
	2L0HCniAeca+/DuYmzRHRVxmRmDCj32fvaj5tfL2Exyn/E24ZcLpc010JWzI
X-Gm-Gg: AYBFou0xk0VBqiL7J2r4wKL4/+DLAClOZIavn6Ra5M3Gow0X3LrGlI1X7y/8OsOeOuj
	kZbWo5L1u1GjtUGOw+xwcR3hKXPaqYKgRmB3j8bFP0uv4hUze7Zi47Q5h7AtbsmFIdfLQaV6d9D
	aLjFlUl5UpLSOAMo2KBnNhSK880o8960nao8wL1XSmVnjdsmERTcuvbvJS4gwdZkCWKtb28clCa
	SDAGwA7BG+8V2y1PfhWpU1BvLXbsuE3lUT3qrnZ07fvdZoNc40maEfaewLQ9vymRVnkeKtVMqeh
	SKHMzwlCs6/0yshZtAronW/ul5qzz/KLYmQxQRTYyiRhyR3Tv2pWhK7Uwzgc1vLoqAGdWMeG+7v
	lILneJVI8A/JDgBpC9Vwvi5IGjxi4CLHxJtaf3470fT76d5OfLXfjyfMcAv/m7YxIbbLTJ4Pgi5
	uc5KrgFti4EmfKxAMEF0mIVxb9O2XLph3rW6v1OHR2500f9NR3xZ+12mtLpzMqizbk0E2je98t9
	T7ZIeni4Tf4DBigR3QWsa0t+kUNQvq+vjrFvNADZORkf/RejiyH5zN4Pj27vdmnIff1apMjyCgL
	ApzGsCJH7FzJ4vss1vQD3sr83L+lhZrRpbTxHZhaVvbhdjTCQEnyhhvCZqbf7lzs
X-Received: by 2002:a17:90b:2b46:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3b0db6d36a0mr652675a91.11.1793921839036;
        Thu, 05 Nov 2026 15:37:19 -0800 (PST)
Received: from [192.168.10.136] ([27.147.237.15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm5665499a91.0.2026.11.05.15.37.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 15:37:18 -0800 (PST)
Message-ID: <59040dbf-3a11-41d5-b696-3d6536b1e706@gmail.com>
Date: Fri, 6 Nov 2026 05:37:14 +0600
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
Subject: Re: Sony WF-1000XM6 call audio fails on Linux: first eSCO setup gets
 0x1f, then ACL timeout
From: Arka Bhuiyan <arkabhuiyancsedu@gmail.com>
To: linux-bluetooth@vger.kernel.org
References: <ebfb1f3b-99f4-42bc-b79a-5085af6824ae@gmail.com>
Content-Language: en-US
In-Reply-To: <ebfb1f3b-99f4-42bc-b79a-5085af6824ae@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

This is an update to my earlier report. I need to correct the versions I 
sent: the report said pipewire 1:1.6.8-1.2 and wireplumber 0.5.15-1, 
which were stale.

Current versions on my system:
- BlueZ 5.87-2.1
- PipeWire 1:1.6.10-1
- WirePlumber / libwireplumber 0.5.18-1.1
- Kernel 7.3.1-1-cachyos

Finding: with WirePlumber 0.5.15-1 and the same PipeWire version, 
LC3-SWB calls work on this device. With WirePlumber 0.5.18-1.1, the 
autoswitch to the headset-head-unit (LC3-SWB) profile sets the profile, 
the transport goes inactive right after that, and the output node goes 
to error. There is no speaker or microphone audio. mSBC still works on 
0.5.18.

I have not yet determined whether the fault is in BlueZ, PipeWire or 
WirePlumber. The transport goes inactive immediately after the profile 
is set on the WirePlumber side, so I am reporting the WirePlumber side 
upstream as well: 
[https://gitlab.freedesktop.org/pipewire/wireplumber/-/work_items/1058].

On 11/6/26 3:30 AM, Arka Bhuiyan wrote:
> Hi,
>
> My Sony WF-1000XM6 does not carry call audio on Linux. I'm sending 
> this to report the failure and the evidence I have. I don't know 
> whether the bug is in PipeWire, BlueZ, the kernel, or the device, so 
> I'm asking here.
>
> My setup
>
> - HP Victus laptop and a personal workstation, both with Intel AX201 
> (8087:0026).
> - Kernel 7.3.1-1-cachyos (linux-cachyos 7.3.1-1), bluez 5.87-2.1, 
> pipewire 1:1.6.8-1.2, wireplumber 0.5.15-1, linux-firmware 
> 1:20261019-1. PipeWire and WirePlumber are pinned, so these are the 
> versions running.
> - Firmware loaded: intel/ibt-19-0-4.sfi, Firmware Version 83-7.26.
> - Earbuds: Sony WF-1000XM6. I haven't checked its firmware version yet.
> - I also have other Sony headsets and see the same failure with them. 
> I haven't captured those yet.
>
> What happens
>
> When a call starts, the host sends an Enhanced Setup Synchronous 
> Connection command. The controller accepts it (Command Status: 
> Success), but no Synchronous Connect Complete follows. Later, an SCO 
> Connect Complete arrives with Unspecified Error (0x1f) and handle 
> 0xFFFF. About 1 ms after that, the ACL link drops with Connection 
> Timeout (0x08). In every failing capture I have, there is no codec 
> exchange (+BCS or AT+BCS) between connect and that first setup.
>
> How to reproduce
>
> 1. Pair and connect the WF-1000XM6.
> 2. Start a call in Teams for Linux, with nothing else changed.
> 3. Capture with sudo btmon.
>
> Evidence (btmon times, in seconds)
>
> - Cold run: setups at 26.02 and 50.12 are accepted with no completion. 
> SCO Connect Complete with 0x1f at 46.345 and 62.114, each followed by 
> ACL Disconnect with 0x08.
> - Debug run: Enhanced Setup at 83.73 has no completion. SCO failure 
> with 0x1f at 104.078, then ACL 0x08 at 104.079. Another failure at 
> 123.558. Before the first setup, the only HFP message is +CIEV: 2,1.
> - Call capture: Enhanced Setup at 76.276, no completion. SCO 0x1f at 
> 96.628, ACL 0x08 at 96.629. The first codec exchange comes after the 
> reconnect.
>
> Workaround
>
> If I force the codec exchange first, the setup succeeds. Before the 
> call, I run two short capture streams: one on mSBC, then one on 
> LC3-SWB. In the primed capture, +BCS: 2 and AT+BCS=2 come before the 
> mSBC setup at 23.733, which succeeds at 24.19 (eSCO, Transparent). The 
> LC3-SWB setup comes after +BCS: 3 and AT+BCS=3, and it also succeeds.
>
> In a real call with the workaround, the mSBC setup at 43.23 succeeded 
> at 43.63, and the LC3-SWB setup at 52.22 succeeded at 53.28. Audio 
> worked. There was a brief drop of about 1.2 seconds while the link 
> switched.
>
> What I ruled out or haven't checked
>
> - Duplicate device records: there is only one record.
> - Multipoint: it still fails with the phone's Bluetooth off.
> - Wi-Fi coexistence: not tested properly.
> - Firmware: not confirmed as the cause. I haven't compared it with the 
> September update.
> - CVE-2026-90255 and commit 0f00cd322d22: I haven't checked them 
> against the 7.3.1-1 source.
>
> Questions
>
> 1. Is it expected that a controller accepts Enhanced Setup Synchronous 
> Connection and never completes it, with no earlier error?
> 2. Should the host time out sooner than the ACL supervision timeout?
> 3. Should the codec selection before the first setup come from the 
> userspace implementation (PipeWire here) or from BlueZ?
>
> I can send redacted btmon excerpts on request. I won't attach raw 
> .snoop files or /var/lib/bluetooth info files, since they contain link 
> keys.
>
-- 

Best Regards,
*Arka Bhuiyan*

