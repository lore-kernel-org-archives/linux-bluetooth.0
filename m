Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B0D3BA239
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021905; cv=none; b=k7URA3AWK5OIdiWfzI0QZsbv+L1YYZ4tpT0mbWbtLceLfQEEWxyCx1pCiLfJpHnPsL4fls766epM0WWLQR/IzjjZDQ1+cFF6lJx9v7WiJkF2mOLM92blnbFgEmcdybXWpD1pBuZ5PY6xDoK4i5Lov3/SbwNDK+37j+dEYmjn2J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021905; c=relaxed/simple;
	bh=Rn94p7sYmD/w4OSshFEetShPhQwkKypxpG7kkcnTG4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKhoNcSuTd8YOqWSPnYXwWprgc20sZwa4uwi51BfzLyYMrn11CK4RtjY+1gioVWbfmplFzXr6g2XvzXYwIeXg86nfeE1TzBl0V5yqUOtGwWdabRDSyAszjqLz8bi28skz6oC9BsthYGGhQhr84AdyJI/wuQM2WTcSeKCnLLOZok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=RtBpNT4s; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="RtBpNT4s"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-490af320e2aso62796175e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781021899; x=1781626699; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cKjDaHvMusivhoihc8XQqwcmmdsEc79N0ly+xWbpwLs=;
        b=RtBpNT4snnIwbO4RbFlCrnCQ3M+2P8q9FAv3aVh30rFQlDYMkoUMm12YZBvjMCkDJT
         eDgXzMgssAaiXFC0hkocXFpK57gAZnheWAsDGWzOAMOH+xmUgn70a3/5nA1XqdW1Wl44
         ZQAlYlEpwGDSWLvWTGKcyQhj0Bks2eqcG93E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781021899; x=1781626699;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cKjDaHvMusivhoihc8XQqwcmmdsEc79N0ly+xWbpwLs=;
        b=DchPkuQEpDEXZHaAMlhFMjTXSrCVSUHWNaHUhUAQ6EXkZPiUjGJE2kf0dhwIi7Ulhb
         5mP+xMCK/+M4Cfz1p7n2cb08VtKi3GGNJYHNJVVensy2GSzqNSLbBTKpxN6877EpNiNV
         zpxD595XOvQMGgGNgATlTs/x427agN/kZOZIqGmNQvqhv3bWqQVvZJn4uSxqeUrB7O4R
         Z3X9mxFa7qhQpMj1dr1ETMHrUKNqfdE/xlNgBSftR+RCgzDbdnBXlPJ+mv60Ph3asrLq
         uC1WyeUVfcT5MP0/2yTItyKzBR4/4k5g8Tdw7AAfyhrPQkTd5Rv76VcZR4hcK1p83v9Z
         atiA==
X-Forwarded-Encrypted: i=1; AFNElJ9KYsRwVXPrT8ZyU7FA9xnRZ7bxx1awExHrUXnB81a3iD4Z3MBXCFY7CueTwHcFCVUtHoJppWbYwmcjYQdUfQ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIGZ6mnOZhzENKUf82k52e/eK63S+bwWYR2AuJaryl/PO/jrTe
	bn0dXofzcmiZftHaXYY1OQmRDDIGdkG8AkkuuyVyEH0fUOuvJcueUPeOYdi/va2yItXXeVcRAfi
	2u4gZ
X-Gm-Gg: Acq92OGVhJFWPoZNuhIIO8zQIYAfflQhw2npnEDtwZn4OhzKuYY5NoIMVa+Yw2QVLZR
	fiZVhbfe/dTBZ0qfB1wlLYB1DVudgTsSb9frg24mrKSYJls7oKqbJPFUHqxCDqTt4NYZL31oWJ3
	rlM+7mcopVp27yPWlNqgxJmmhFH4iEF6BOBckDwzpoQdtHVp00fpxW3QRCDyaPr5/hapvQyu9IE
	mQ/RU/UFp+sItDSnKVyMK6cOb7I9s+xE7mfkG73DqeIntT28LgBdLZbaCASOujQSXVe8m9ULIAd
	ZcKTx4VlypVGwYYDrJBWtZhTP0dYyIZ0lcDHCxJ2LqbV6WFpso0XCmHjpVR4OYfRl15AOHslipS
	GhVMbJRCZ5vIptzU6l2RsWxjwf3RcN+2apRkK5nZVhiKpKhJfYvxNHhvwYePUJ4VjG+CJ+32q0d
	9n1yrxV7rGz5h67kMZWP40iIh0f5KLSibczx4wI6xlYb/u7fQ/BcJ1C4bWf+Hy5VUZ
X-Received: by 2002:a05:600c:5246:b0:489:c57:7836 with SMTP id 5b1f17b1804b1-490c25ff39amr340516955e9.27.1781021898834;
        Tue, 09 Jun 2026 09:18:18 -0700 (PDT)
Received: from [10.122.244.41] ([84.245.120.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc39eb04sm496839235e9.6.2026.06.09.09.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:18:18 -0700 (PDT)
Message-ID: <fb060ed1-084d-41e7-98a5-28de3db274e1@streamunlimited.com>
Date: Tue, 9 Jun 2026 18:18:17 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] a2dp: Add codec prioritization
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20260608111658.3686364-1-simon.mikuda@streamunlimited.com>
 <f10de0ea2a69c48b40d66b79d4236b17f932c05c.camel@iki.fi>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <f10de0ea2a69c48b40d66b79d4236b17f932c05c.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

in our use case it was something like this:

we have endpoints:

AAC, SBC

later we've added LDAC and to ensure compatibility with already paired 
devices we had to add it to the end of the list:

AAC, SBC, LDAC

So when we've initiated connection to remote that supports LDAC, it was 
not selected.

But now i think your idea:

    What could be useful is something that allows per-device priority
    selection, e.g. DBus callback that BlueZ uses to query which endpoint
    to configure, before starting SelectConfiguration.

Is the way to go, definitely better than static priority in bluez.

On 6/8/26 17:58, Pauli Virtanen wrote:
> Hi,
>
> ma, 2026-06-08 kello 13:16 +0200, Simon Mikuda kirjoitti:
>> This change will select best codec when connecting to A2DP:
>> LDAC > AptX HD > AptX > AAC > SBC
> Currently it's media server's job to decide what A2DP codec to use.
>
> What they do for this sort of static ordering, is to register endpoints
> in the wanted priority order, so I think another mechanism for fixed
> ordering is not really needed.
>
> What could be useful is something that allows per-device priority
> selection, e.g. DBus callback that BlueZ uses to query which endpoint
> to configure, before starting SelectConfiguration.
>
> I'm not sure this is highly needed though, as iirc BlueZ remembers what
> configuration was used on previous connects, and if BlueZ gets it wrong
> the sound server can just reconfigure as needed at the cost of some
> extra delay when connecting.
>
>> ---
>>   profiles/audio/avdtp.c | 51 +++++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
>> index d475a545e..a8733a7e1 100644
>> --- a/profiles/audio/avdtp.c
>> +++ b/profiles/audio/avdtp.c
>> @@ -42,6 +42,8 @@
>>   #include "sink.h"
>>   #include "source.h"
>>   
>> +#include "a2dp-codecs.h"
>> +
>>   #define AVDTP_PSM 25
>>   
>>   #define MAX_SEID 0x3E
>> @@ -1293,10 +1295,49 @@ static struct avdtp_stream *find_stream_by_lseid(struct avdtp *session,
>>   	return find_stream_by_lsep(session, sep);
>>   }
>>   
>> +static unsigned int get_codec_priority(
>> +				struct avdtp_media_codec_capability *codec_cap)
>> +{
>> +	unsigned int priority = codec_cap->media_codec_type;
>> +
>> +	if (codec_cap->media_codec_type == A2DP_CODEC_VENDOR) {
>> +		a2dp_vendor_codec_t *vendor_codec = (void *) codec_cap->data;
>> +
>> +		switch (A2DP_GET_VENDOR_ID(*vendor_codec)) {
>> +		case APTX_VENDOR_ID:
>> +			return priority + 100;
>> +		case APTX_HD_VENDOR_ID:
>> +			return priority + 200;
>> +		case LDAC_VENDOR_ID:
>> +			return priority + 300;
>> +		}
>> +	}
>> +
>> +	return priority;
>> +}
>> +
>> +static int sep_codec_cmp(gconstpointer a, gconstpointer b)
>> +{
>> +	const struct avdtp_remote_sep *sep1 = a;
>> +	struct avdtp_service_capability *cap1 = sep1->codec;
>> +	unsigned int priority1 = get_codec_priority((void *) cap1->data);
>> +
>> +	const struct avdtp_remote_sep *sep2 = b;
>> +	struct avdtp_service_capability *cap2 = sep2->codec;
>> +	unsigned int priority2 = get_codec_priority((void *) cap2->data);
>> +
>> +	if (priority1 < priority2)
>> +		return 1;
>> +	if (priority1 > priority2)
>> +		return -1;
>> +	return 0;
>> +}
>> +
>>   struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
>>   						struct avdtp_local_sep *lsep)
>>   {
>>   	GSList *l;
>> +	GSList *sorted = NULL;
>>   
>>   	for (l = session->seps; l != NULL; l = g_slist_next(l)) {
>>   		struct avdtp_remote_sep *sep = l->data;
>> @@ -1325,7 +1366,15 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
>>   				continue;
>>   
>>   		if (sep->stream == NULL)
>> -			return sep;
>> +			sorted = g_slist_insert_sorted(sorted, sep,
>> +							sep_codec_cmp);
>> +	}
>> +
>> +	if (sorted) {
>> +		struct avdtp_remote_sep *sep = sorted->data;
>> +
>> +		g_slist_free(sorted);
>> +		return sep;
>>   	}
>>   
>>   	return NULL;
