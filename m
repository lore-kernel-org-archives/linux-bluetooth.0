Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FC11531C2
	for <linux-bluetooth@vger.kernel.org>; Fri,  1 Nov 2024 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730444828; cv=none; b=tjFq1sdW2ROYBoWy6LYFrUdprY4MeuY/SBBWV74TjId+qWWbQIg1J5oS/qqEx3GCPScmX4glKErjt4jFu1d+jFxbNAXUiecpt5uqrbuCZOtBdVsDiQ+/Pr3ECIPpu+7x6SXofThImXixt0Zs0IB9E9qTZ7PKvuaezktoSDaK29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730444828; c=relaxed/simple;
	bh=oh5h7MzrLhPb+SvUdhmJUQu+vdzHPGQ0nYUHBdZvZBA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=G8kSRQgcAlRbuoi3JM5bvgS7SVzbl/sYEMukGlt9mksYL0UzEbU2wdq4Cg+aCvLfa/QSz4b82x7uvxbuUP6xTEUKsnwF83n5K9liDj60Z+Rh/Ka+udgNmn2k4X43a8zj1hhPIUeIS6ZFGMiqd2MH5DbujYjyaibfwHVz+8Tlpmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af328.dynamic.kabel-deutschland.de [95.90.243.40])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9FFC861E5FE05;
	Fri, 01 Nov 2024 08:06:52 +0100 (CET)
Message-ID: <197d3a7e-256b-4567-bbbb-fa2d326fce69@molgen.mpg.de>
Date: Fri, 1 Nov 2024 08:06:50 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bluez PATCH v2] textfile: Fix possible bad memory access in
 find_key
To: Howard Chung <howardchung@google.com>
References: <20241101101345.Bluez.v2.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Content-Language: en-US
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241101101345.Bluez.v2.1.Ia122d85386d6c2fc69f5b3d7ea7a7169f73756e4@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Howard,


Thank you for your patch.

Am 01.11.24 um 03:13 schrieb Howard Chung:
> From: Yun-Hao Chung <howardchung@google.com>
> 
> If the searched key is a prefix of the first key in the textfile,
> the code will assume it's not the first line which is wrong.
> 
> The issue can be reproduced by a fuzzer.
> 
> Stack trace:
>      #0 0x55e1c450e7ce in find_key /src/bluez/src/textfile.c:133:9
>      #1 0x55e1c450e7ce in write_key /src/bluez/src/textfile.c:244:8
>      #2 0x55e1c450dc33 in LLVMFuzzerTestOneInput /src/fuzz_textfile.c:61:3
>      (...trace in fuzzer)
> ---
> This is reproduced by https://issues.oss-fuzz.com/issues/42515619

I’d also add the URL to the commit message.

Also for the OSS Fuzz ignorant, how would I reproduce the issue? Could 
you please add the commands?

> Changes in v2:
> - Add stack trace in commit message
> 
>   src/textfile.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/textfile.c b/src/textfile.c
> index 313098f38..8188d2ebe 100644
> --- a/src/textfile.c
> +++ b/src/textfile.c
> @@ -127,10 +127,10 @@ static inline char *find_key(char *map, size_t size, const char *key, size_t len
>   	while (ptrlen > len + 1) {
>   		int cmp = (icase) ? strncasecmp(ptr, key, len) : strncmp(ptr, key, len);
>   		if (cmp == 0) {
> -			if (ptr == map && *(ptr + len) == ' ')
> -				return ptr;
> -
> -			if ((*(ptr - 1) == '\r' || *(ptr - 1) == '\n') &&
> +			if (ptr == map) {
> +				if (*(ptr + len) == ' ')
> +					return ptr;
> +			} else if ((*(ptr - 1) == '\r' || *(ptr - 1) == '\n') &&
>   							*(ptr + len) == ' ')
>   				return ptr;
>   		}

The diff looks good.


Kind regards,

Paul
