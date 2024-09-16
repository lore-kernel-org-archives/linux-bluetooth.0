Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F371814AD2B
	for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 15:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726501149; cv=none; b=dsp+t3hjq1N5DUizqboxdx4dUSfYMJsJtUVi3cTxBUioJHpmZ1i3hgd6l1XGVOXURyQIH0rBYSy61m8obqgDJ4kFP0iau7wvIosFl5GCaHFt3qC4ggsf7osBl4L4/mQo086MaGbk6aNIMj8D29dHNS5RbITJ3WR4Tb+9C493nY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726501149; c=relaxed/simple;
	bh=3Pxfc6BiNBAWwSRoVFuoJpTDGWe+rsWlFhBCoPQoXow=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oalsxQUzjPLCa8oA/GBVxl1RUjGZ5bb0J1cj5U01s2ioVprIJOUpl4wy0d83QB8SUCZKctOlJYwKrh+liRqAr0sxZ3vPyRwEoDUNyDpvvRDoEBJFOdXYghJ9COEpzo9neVKffI5VrdT2zK72nX87v4XtxFr3WIvgrjAfQr5J1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKTTK+hx; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKTTK+hx"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2068a7c9286so35518955ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 08:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726501147; x=1727105947; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ut5QamMaJpARm0DyVbgQWN4wFSOYc3/Zxorz8qP8VsQ=;
        b=VKTTK+hxxjs7m8HA2crdAomxEE2hZvVp9wlYe6BUreND0lSp5y9V16v8jKPhmtnYFU
         b9nvCFi3nwAp2OLk8JLZQLff5op2rBLKHR8JoiHwvIlcximszFRX3qNORQpqzC1icdX9
         VpwE7I4cSwDcIYlCasVq7PqMh+PJbWlUv1k/iEBAxZJWziXZgTv7vMPoD6vRXJJHHsl0
         O8ROMUHJ/HUJrrKkbXVCCksU9FQtj9mJvVgzrqvBjWTa+Nk3dYKBATHxQkZjKDBkE9Jl
         ZpQwFp/c4mNXCIDz7mf3gOwhzitWGNRTcypwnAryaruBi2L7z2z1W2nmLoBWy4CCMHO2
         XcHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726501147; x=1727105947;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ut5QamMaJpARm0DyVbgQWN4wFSOYc3/Zxorz8qP8VsQ=;
        b=nodpw4GbdizeS5drXUlrk0rcRzxa6hdbOE7CyEMs76Tk9118X/71usY06Pt0rwl5/b
         oUSb1MAf7vvVRlZ7YsCIPWXGISTBmxyT/C7x89u4rZ1Cn+G12WFylaB40g0VahlsRpIi
         3AuQOcfDpkE28jjbJbjeGiPRWx5fQbYjkH5gTNQ571EWXG8WEU6ZBqO/LW4UqbXZYbR0
         wv3bhXTUwExV/AL/mFJQNo08xnqZTXtSHHwTqe2ZI3MZbmAoH1O8/2n52vj0nySGXlB/
         i82vfZxGkz1EnrIYC6vH0cMA99sHnhQ6whJnPkmiYA0/bDVVzm63xycveEUPyP56ZFsU
         gGPg==
X-Gm-Message-State: AOJu0YxBoTItDmgAr9E1Q0TjmSEJDlJXyb5Nk1JtfQgYygU6K/rEQhf2
	t3uBGoWMerE+xHnMB7VaoJQ7Em1KlNE9urFYDHRvk1NKpFw11SA3
X-Google-Smtp-Source: AGHT+IEo4U6Oat3Ov3iOO18yVPmKWxm7amL+vdC/IlvIt9ZaY8vDMy/3NdNPbHKgZcR7F0DDMy8OjQ==
X-Received: by 2002:a17:903:32ca:b0:1fd:5fa0:e98f with SMTP id d9443c01a7336-20782a6a145mr154166985ad.44.1726501146970;
        Mon, 16 Sep 2024 08:39:06 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2079470f1a2sm37311045ad.236.2024.09.16.08.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 08:39:06 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <098e9614-7a88-405c-8fb4-e13bc4f40efc@gmail.com>
Date: Mon, 16 Sep 2024 23:39:04 +0800
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
Cc: Bluez <linux-bluetooth@vger.kernel.org>
References: <20240915-fix-log-buffer-overflow-v2-1-fb6b52a7d4b2@gmail.com>
 <CABBYNZ+YMC856CdhETpCM9u4OYeO5+R+3hSbgigLszVaa+UPQQ@mail.gmail.com>
In-Reply-To: <CABBYNZ+YMC856CdhETpCM9u4OYeO5+R+3hSbgigLszVaa+UPQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-09-16 23:10, Luiz Augusto von Dentz wrote:
> Hi Celeste,
> 
> On Sat, Sep 14, 2024 at 12:10 PM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>
>> In current code, we create line buffer with size 256, which can contains
>> 255 ASCII characters. But in modern system, terminal can have larger
>> width. It may cause buffer overflow in snprintf() text.
>>
>> We need allocate line buffer with size which can contains one line in
>> terminal. The size should be difficult to calculate because of multibyte
>> characters, but our code using line buffer assumed all characters has
>> 1 byte size (e.g. when we put packet text into line buffer via
>> snprintf(), we calculate max size by 1B * col.), so it's safe to
>> allocate line buffer with col + 1.
>>
>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>> ---
>> Changes in v2:
>> - Add free() forgot in v1.
>> - Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com
>> ---
>>  monitor/packet.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor/packet.c b/monitor/packet.c
>> index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..bef55477a221b6cb43ff224454ac3fa593cd8221 100644
>> --- a/monitor/packet.c
>> +++ b/monitor/packet.c
>> @@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
>>                                         const char *text, const char *extra)
>>  {
>>         int col = num_columns();
>> -       char line[256], ts_str[96], pid_str[140];
>> +       char ts_str[96], pid_str[140];
>> +       char *line = (char *) malloc(sizeof(char) * col + 1);
> 
> Perhaps we could replace malloc with alloca here so we allocate the
> line on the heap rather than stack.

I will replace it with alloca() in the next version.
But to be honest, I think alloca() is not a good choice. The compiler will 
prevent the functions that call alloca() be inline, otherwise it may trigger 
unexpected stack overflow because it's not a scope-based lifetime. It may be 
better to replace it with VLA once we bump the standard requirement to C99 or 
above.

> 
>>         int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
>>         static size_t last_frame;
>>
>> @@ -525,6 +526,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
>>                 printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", ts_str);
>>         } else
>>                 printf("%s\n", line);
>> +       free(line);
>>  }
>>
>>  static const struct {
>>
>> ---
>> base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
>> change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8
>>
>> Best regards,
>> --
>> Celeste Liu <CoelacanthusHex@gmail.com>
>>
>>
> 
> 
