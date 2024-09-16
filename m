Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D63D1E86F
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726502242; cv=none; b=V8vkv81tltma+h466YbU329T5JhQV+OX+Mv8HSq1hlIWbEHD/yHfganWevEEM0qNVwDRDWdMcIGn8pVz0UXR1f5D61JzsBIBTxR7XbkqdAftJKDlibedhghPrvLZz90n9net06CSRl8wpCbB6LngBLCOHrNNRy/+FUerZWFcIbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726502242; c=relaxed/simple;
	bh=/p3fCPZC2Irk+EuS0zhXngPgOlzERJ5hyPQNAVea9jI=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=eYtt5n15SLcAJ4z+scRux1jXfvqUrCGHCnRK6evRVqLwCpBXPesFZeAYB7LWm9QcKcxXL7UmssUtEdgNev00+Ul/0jUEtoivNt1hGcjgnEYjKDuIw2qCmATy36FBLkOVA7xNciqW+al6ayzuFhbOMJgl42rINEuf4fnRkFgWeNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg29+ycR; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg29+ycR"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-718e2855479so3355074b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 08:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726502241; x=1727107041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=eR8VySSk+c5OmDAn/6W3cgSGH/viAAJJj9IA4bf9Jl0=;
        b=Kg29+ycR+pyi2I3jldYpI4+nnmMfkQaMPZrNO2qlIRVO38eH3vdTT+St/41H8/Gnop
         WhPUYvJRbl/Gu5wX1HCKYzULv4bwOM90L4KXrLAsUNFDfusfh/UB/I2Yusi9WtogR5ts
         t+b+5MPeh+4U2YbzkYOLthd1AmKvfKHWGM3EuPNA8rG1kAC1QxJ5EBzrWodh23Wi0MlD
         HPGSzRzt2WJwHUQbKe3+lU3Zpy3zPgSOEuMpoR7+NLCpVH3zY4AbACSaGWmfQ7dB+Hs0
         GBzXv4vzpL0qH6WVZ+KyzFvvJH189JvuuYEJ8rTmv51MWiTAj0mGrwulRuNpvlD4jTj3
         Z10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726502241; x=1727107041;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eR8VySSk+c5OmDAn/6W3cgSGH/viAAJJj9IA4bf9Jl0=;
        b=tJy4YNFQIkJ7shDp0fJ9G+JlXNWL/8DRVFSHKzZ2BgyS9Ce8+7ZB3vAnCZNmx5wqbc
         htoOSOVTuqokr8oQzy72Alpo19nTsvk3/4ywP+fsSws7BC8t9sKN8U3N9SpJ68uiI8N2
         ddlOCwy+a2nEZXi9IHYG70bZQoGZQ3aYNPnMuhFuXOIds/KZJxPCMnduQsY702P0ALIO
         ap5/0O5XIOKUJA8lTQWBIOLLsdkNd0BUyqtv1XKhFsvkQlYfw0VjH0iAy6I4XV9BZ4/i
         kT96g+eD8jqmYaZmLNNrtHl49TKdj1x5bVxaT/pUzsrmL6K6q9lUIeyJuxWG533YtgAf
         9dJQ==
X-Gm-Message-State: AOJu0YydZoy2SyZa8naYUgmPdNIkNRiE160STDSXCFJhzOKpNcBO73gk
	UJEzk1mPzMyL1O2hkOL4OX8p6MEDeEBIzBPGpFGPW646opUW12XrQuC2oCOJaEw=
X-Google-Smtp-Source: AGHT+IEpIdS8gip1oePMw92MrlkQ2z8QKlmGDiuAYOFAgfDbZTln8GgACbWhCxvP01rNYtZm6cBOoA==
X-Received: by 2002:a05:6a00:ad5:b0:710:50c8:ddcb with SMTP id d2e1a72fcca58-719260654d1mr23888995b3a.5.1726502240450;
        Mon, 16 Sep 2024 08:57:20 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944bc3440sm3846036b3a.202.2024.09.16.08.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 08:57:19 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <5f11a98c-9f41-44a4-9e30-df33b8a0560e@gmail.com>
Date: Mon, 16 Sep 2024 23:57:17 +0800
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluez v2] monitor: fix buffer overflow when terminal width
 > 255
Content-Language: en-GB-large
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Bluez <linux-bluetooth@vger.kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>
References: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
 <CABBYNZ+YMC856CdhETpCM9u4OYeO5+R+3hSbgigLszVaa+UPQQ@mail.gmail.com>
 <098e9614-7a88-405c-8fb4-e13bc4f40efc@gmail.com>
In-Reply-To: <098e9614-7a88-405c-8fb4-e13bc4f40efc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-09-16 23:39, Celeste Liu wrote:
> 
> On 2024-09-16 23:10, Luiz Augusto von Dentz wrote:
>> Hi Celeste,
>>
>> On Sat, Sep 14, 2024 at 12:10 PM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>>
>>> In current code, we create line buffer with size 256, which can contains
>>> 255 ASCII characters. But in modern system, terminal can have larger
>>> width. It may cause buffer overflow in snprintf() text.
>>>
>>> We need allocate line buffer with size which can contains one line in
>>> terminal. The size should be difficult to calculate because of multibyte
>>> characters, but our code using line buffer assumed all characters has
>>> 1 byte size (e.g. when we put packet text into line buffer via
>>> snprintf(), we calculate max size by 1B * col.), so it's safe to
>>> allocate line buffer with col + 1.
>>>
>>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>>> ---
>>> Changes in v2:
>>> - Add free() forgot in v1.
>>> - Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com
>>> ---
>>>  monitor/packet.c | 4 +++-
>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/monitor/packet.c b/monitor/packet.c
>>> index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..bef55477a221b6cb43ff224454ac3fa593cd8221 100644
>>> --- a/monitor/packet.c
>>> +++ b/monitor/packet.c
>>> @@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
>>>                                         const char *text, const char *extra)
>>>  {
>>>         int col = num_columns();
>>> -       char line[256], ts_str[96], pid_str[140];
>>> +       char ts_str[96], pid_str[140];
>>> +       char *line = (char *) malloc(sizeof(char) * col + 1);
>>
>> Perhaps we could replace malloc with alloca here so we allocate the
>> line on the heap rather than stack.
> 
> I will replace it with alloca() in the next version.
> But to be honest, I think alloca() is not a good choice. The compiler will 
> prevent the functions that call alloca() be inline, otherwise it may trigger 
> unexpected stack overflow because it's not a scope-based lifetime. It may be 
> better to replace it with VLA once we bump the standard requirement to C99 or 
> above.

But I found a VLA usage in monitor/display.h:82, which was introduced by Marcel Holtmann
in d9e3aab39d2af7d7a822993ededaa41cd0311c53 in 2012. Could we use VLA directly? Or we
need to treat that usage as a bug and fix it?

> 
>>
>>>         int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
>>>         static size_t last_frame;
>>>
>>> @@ -525,6 +526,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
>>>                 printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", ts_str);
>>>         } else
>>>                 printf("%s\n", line);
>>> +       free(line);
>>>  }
>>>
>>>  static const struct {
>>>
>>> ---
>>> base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
>>> change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8
>>>
>>> Best regards,
>>> --
>>> Celeste Liu <CoelacanthusHex@gmail.com>
>>>
>>>
>>
>>

