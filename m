Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9D236B17
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Sep 2024 06:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726554703; cv=none; b=c7eispliW4Nsr9flfQirfBN3+6ndXl1f+hTV9WgVynqmwBbiTXEWFGLtm4dwAGv35tGlvxElzXeRCEF993Fy87beSN5gjvj755JNp9K8k4fVU6w2YgrZIFnGYGZcJoFPeSOfML3KktJHHxE+YFWjsykwRIIfSCgUN+zZFuS0j8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726554703; c=relaxed/simple;
	bh=ncAKfF30gTHEG/N3Thej96v0DQx4j7j/VwtIgJxBYkc=;
	h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=cZy5zZ/oMOgyzxkbnLB7njBoRjtRP1HFMvvqo7IqKql0jJ5K+Y7JPnnMBvQJin3Tva9thwcZM2R+ixmQDBqlxTNb57fxsb6Xdgs96RqtmAMCoVz8v2SX81ALfT4a5liijhFrOHe3jFG3mpRs6aJUqm7K6cXumCBNDszUlpHW4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmij2MZt; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmij2MZt"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-205659dc63aso50947145ad.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2024 23:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726554701; x=1727159501; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTDefMiCw8xZeCPY6RuY1XQKwTYf9rKwztHbr8Q5dyE=;
        b=fmij2MZtfOOTNcuJhq0tG5zDwsevA4giK2Z20qMPwkSzHHlzyoal3jwWH6OCQF+aRe
         x6C4CpqXLC0kHwhrXOGCoUx46Jsq2AcbOfDSk7x4qqWH3+f6JIpaf1pme6b409khXNAr
         bE8HSVB0P9UOdVkZijYwLGkvMKUiO8kfKeJnhgEZB7dSqmYEWdjH0FWBvWicRojIZExL
         kwqgABUfgj8U4SCbOZFvVzKT6gQcoiQ7j2x9zrN3dncibwe+XBN5dTXkORNe6g9E3OMu
         6c/976PkLwpu8JIB2jlzttM0+54160Z9jWF1ZKAQJzh2K3Ke5vTsROyOqkeODOM5cWbc
         qI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726554701; x=1727159501;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bTDefMiCw8xZeCPY6RuY1XQKwTYf9rKwztHbr8Q5dyE=;
        b=l2dCc/RpSUQ8fJAh1btdC53Ev5W/EzO5SaRQBByXVCeBnu3+oOjYSMsGqL58hmka2t
         5Ind93RwWYSh4klpvXU+Bw4Kkn9zF2rXBCEioGx4XRBQ72q7K5ra1NNRJB+4mfZSeg/8
         fzOJjCkjuzJctiQhpMYWmq+xpLhzFVTTnbrIh1Xx1xpqidBnR7id0QFFL6uoRB9M3R5Z
         hUzBzk6MqCpYMtXQS8OEGzv01dTpO+WxPJXiJlsfL/zImGBBWrME1PCRWQh/yvaL1wry
         8VwY17x9VjVAYKuPgc9C4X/Y7ED917gIe2/nblUilfGJ+9fch9lguHBAQuJgfNJSS/PL
         +oOw==
X-Gm-Message-State: AOJu0YxKBcQhN2rf5bu25AI/pqHcGBx5cjC/4zKkjIz+6nxy8R1frwQm
	0AKavI+0XmP6UmO18SNEEU8ArAYI53cyiDnoB0TJtKQh9a0IBnHTLS+lnsiMMEs=
X-Google-Smtp-Source: AGHT+IFZfC9cXiPhhSkFxclGkR+0mNUZwTVcaZUhWUNB2/XiU/KXLE1ZCsDmo88vXTWIOfICyLMroA==
X-Received: by 2002:a17:902:f543:b0:207:6ef:d8ab with SMTP id d9443c01a7336-2076e48346emr303649135ad.49.1726554701319;
        Mon, 16 Sep 2024 23:31:41 -0700 (PDT)
Received: from [127.0.0.1] ([103.156.242.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794706f41sm44865495ad.215.2024.09.16.23.31.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 23:31:40 -0700 (PDT)
From: Celeste Liu <coelacanthushex@gmail.com>
X-Google-Original-From: Celeste Liu <CoelacanthusHex@gmail.com>
Message-ID: <3384f1fa-eba3-4426-9935-124872d80ef0@gmail.com>
Date: Tue, 17 Sep 2024 14:31:38 +0800
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
 <5f11a98c-9f41-44a4-9e30-df33b8a0560e@gmail.com>
 <CABBYNZ+fm3y4NXc1WTjoc6E-ZiSeVeADgGsmRjuOEU7FjdL4pA@mail.gmail.com>
In-Reply-To: <CABBYNZ+fm3y4NXc1WTjoc6E-ZiSeVeADgGsmRjuOEU7FjdL4pA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2024-09-17 00:22, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Sep 16, 2024 at 11:57 AM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>
>>
>> On 2024-09-16 23:39, Celeste Liu wrote:
>>>
>>> On 2024-09-16 23:10, Luiz Augusto von Dentz wrote:
>>>> Hi Celeste,
>>>>
>>>> On Sat, Sep 14, 2024 at 12:10 PM Celeste Liu <coelacanthushex@gmail.com> wrote:
>>>>>
>>>>> In current code, we create line buffer with size 256, which can contains
>>>>> 255 ASCII characters. But in modern system, terminal can have larger
>>>>> width. It may cause buffer overflow in snprintf() text.
>>>>>
>>>>> We need allocate line buffer with size which can contains one line in
>>>>> terminal. The size should be difficult to calculate because of multibyte
>>>>> characters, but our code using line buffer assumed all characters has
>>>>> 1 byte size (e.g. when we put packet text into line buffer via
>>>>> snprintf(), we calculate max size by 1B * col.), so it's safe to
>>>>> allocate line buffer with col + 1.
>>>>>
>>>>> Signed-off-by: Celeste Liu <CoelacanthusHex@gmail.com>
>>>>> ---
>>>>> Changes in v2:
>>>>> - Add free() forgot in v1.
>>>>> - Link to v1: https://patch.msgid.link/20240914-fix-log-buffer-overflow-v1-1-733cb4fff673@gmail.com
>>>>> ---
>>>>>  monitor/packet.c | 4 +++-
>>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/monitor/packet.c b/monitor/packet.c
>>>>> index c2599fe6864ab44d657c121fcc3ceecc1ebc52a6..bef55477a221b6cb43ff224454ac3fa593cd8221 100644
>>>>> --- a/monitor/packet.c
>>>>> +++ b/monitor/packet.c
>>>>> @@ -376,7 +376,8 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
>>>>>                                         const char *text, const char *extra)
>>>>>  {
>>>>>         int col = num_columns();
>>>>> -       char line[256], ts_str[96], pid_str[140];
>>>>> +       char ts_str[96], pid_str[140];
>>>>> +       char *line = (char *) malloc(sizeof(char) * col + 1);
>>>>
>>>> Perhaps we could replace malloc with alloca here so we allocate the
>>>> line on the heap rather than stack.
>>>
>>> I will replace it with alloca() in the next version.
>>> But to be honest, I think alloca() is not a good choice. The compiler will
>>> prevent the functions that call alloca() be inline, otherwise it may trigger
>>> unexpected stack overflow because it's not a scope-based lifetime. It may be
>>> better to replace it with VLA once we bump the standard requirement to C99 or
>>> above.
>>
>> But I found a VLA usage in monitor/display.h:82, which was introduced by Marcel Holtmann
>> in d9e3aab39d2af7d7a822993ededaa41cd0311c53 in 2012. Could we use VLA directly? Or we
>> need to treat that usage as a bug and fix it?
> 
> Afaik VLA has more problems than using alloca, because depending on
> the C (11-23) version VLA is optional, so afaik alloca is a safer
> option provided the length is not considered too big, anyway perhaps
> we should use some define like LINE_MAX instead:
> 
>        {LINE_MAX}
>              Unless otherwise noted, the maximum length, in bytes, of a
>              utility's input line (either standard input or another
>              file), when the utility is described as processing text
>              files. The length includes room for the trailing <newline>.
>              Minimum Acceptable Value: {_POSIX2_LINE_MAX}
> https://www.man7.org/linux/man-pages/man0/limits.h.0p.html

v3 has been sent.

> So something like the following:
> 
> diff --git a/monitor/packet.c b/monitor/packet.c
> index c2599fe6864a..32a440bbea68 100644
> --- a/monitor/packet.c
> +++ b/monitor/packet.c
> @@ -26,6 +26,7 @@
>  #include <time.h>
>  #include <sys/time.h>
>  #include <sys/socket.h>
> +#include <limits.h>
> 
>  #include "lib/bluetooth.h"
>  #include "lib/uuid.h"
> @@ -376,7 +377,7 @@ static void print_packet(struct timeval *tv,
> struct ucred *cred, char ident,
>                                         const char *text, const char *extra)
>  {
>         int col = num_columns();
> -       char line[256], ts_str[96], pid_str[140];
> +       char line[LINE_MAX], ts_str[96], pid_str[140];
>         int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
>         static size_t last_frame;
> 
>>>
>>>>
>>>>>         int n, ts_len = 0, ts_pos = 0, len = 0, pos = 0;
>>>>>         static size_t last_frame;
>>>>>
>>>>> @@ -525,6 +526,7 @@ static void print_packet(struct timeval *tv, struct ucred *cred, char ident,
>>>>>                 printf("%s%s\n", use_color() ? COLOR_TIMESTAMP : "", ts_str);
>>>>>         } else
>>>>>                 printf("%s\n", line);
>>>>> +       free(line);
>>>>>  }
>>>>>
>>>>>  static const struct {
>>>>>
>>>>> ---
>>>>> base-commit: 41f943630d9a03c40e95057b2ac3d96470b9c71e
>>>>> change-id: 20240914-fix-log-buffer-overflow-9aa5e61ee5b8
>>>>>
>>>>> Best regards,
>>>>> --
>>>>> Celeste Liu <CoelacanthusHex@gmail.com>
>>>>>
>>>>>
>>>>
>>>>
>>
> 
> 

