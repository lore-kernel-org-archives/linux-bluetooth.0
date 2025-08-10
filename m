Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2741F1FECBA
	for <linux-bluetooth@vger.kernel.org>; Sun, 10 Aug 2025 20:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754857263; cv=none; b=YyoEvSXEERXBWD/GOrJT9VYgS1B86ff5oToLGWSG1F4pGla/ayaWAFgo8CFNfB6n6DhIZNe1tZ0MSxb5fUBC49SfJMTaw7wDAergs9pKQ4SZUh04YOofqk8ZdvS4yI+lsJ1fI+lbCZJV30zrgStEZHsjoAU0WYeKZUtxSgQoDVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754857263; c=relaxed/simple;
	bh=wG9UkhyMM9dEb/eZ4f4VtkgcW3Q08haOd/Uybzrqylk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7+O+3vBYOrkWndUGirZXzJtq+dZy3aBV1+KtbyrC3LXk0gGU3vzVeW/4/f6HppurHUg7qdIrGgjvQchXsPtgCnaIB8vzPW0/nQ0t9YfSDzD68Du0k+57mXtS5vniLzLmON2l/KWBF4y9X5YsfIS0ckDiOwbpF9mWhMr49bG4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7e1.dynamic.kabel-deutschland.de [95.90.247.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 43F2C61E647BA;
	Sun, 10 Aug 2025 22:20:46 +0200 (CEST)
Message-ID: <5b9be348-8ea5-4492-8299-2ab8ef2e11d2@molgen.mpg.de>
Date: Sun, 10 Aug 2025 22:20:45 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Fixed heap-buffer-overflow in
 `compute_seq_size`.
To: Oliver Chang <ochang@google.com>
Cc: hadess@hadess.net, linux-bluetooth@vger.kernel.org
References: <20250810064656.1810093-2-ochang@google.com>
 <20250810064656.1810093-4-ochang@google.com>
 <42be480f-d301-4963-b5f6-73811586e857@molgen.mpg.de>
 <CAFqAZO+WK1m2ww1B5qi-iUC8rV-mnsuBk=VeHbBy5euGWBH77Q@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAFqAZO+WK1m2ww1B5qi-iUC8rV-mnsuBk=VeHbBy5euGWBH77Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Oliver,


Am 10.08.25 um 10:20 schrieb Oliver Chang:

>> Thank you for the patch. For the summary, I’d use imperative mood and do
>> not add a dot/period at the end:
>>
>> Fix heap-buffer-overflow in `compute_seq_size`
> 
> Thank you for the suggestion, I will make sure to do this for future
> commit summaries. What do I need to do here in this instance to make
> this change? Do I need to resend the patch with a new subject?

If you want to, you could send v2. (`git format-patch -v2`)

>> The last comment says:
>>
>>> This issue was migrated from crbug.com/oss-fuzz/51480?no_tracker_redirect=1
>>
>> But that URL gives *Page Not Found*.
> 
> Apologies for that. We had a migration from a legacy issue tracking
> system, and that legacy system has since been turned down.

Understood. No problem.

>>> https://oss-fuzz.com/testcase-detail/5896441415729152
>>
>> I am unable to access this without logging in.
> 
> The emails that can access this are the ones listed here:
> https://github.com/google/oss-fuzz/blob/ef1c29822d62470fb6b0af7b73412d245d05f80c/projects/bluez/project.yaml#L3.
> Are there any other emails we should add?

I am not a maintainer, so, as these might security sensitive, I guess 
it’s fine, that I am unable to access it in general.

> These emails also receive automatic email notifications whenever
> OSS-Fuzz finds a new bug. Note though, to view the oss-fuzz.com
> report, you'll need either a GitHub or Google account associated with
> the email.
> 
> https://oss-fuzz.com/testcase-detail/5896441415729152 contains the
> ASan stacktrace, which I've also included in my earlier email.

Understood, in the cover letter [1]. Thank you! I personally prefer 
everything to be in the commit message, so it’s self-contained.

>> With your patch and the test case, what error is logged now?
> 
> There is still a memory leak detected by ASan that's unrelated to this
> patch/issue, but the buffer overflow report is gone.
> 
> I don't see any other log messages, including the ones I added in the
> patch. This is likely because `sdp_xml_parse_record` calls
> `g_markup_parse_context_parse` with a NULL `error`, so any parsing
> errors encountered are not propagated.
> 
> ```
> if (g_markup_parse_context_parse(ctx, data, size, NULL) == FALSE) {
> ```
> 
> It seems useful to enable propagating of parsing errors to
> `sdp_xml_parse_record` in the future. But if preferred, I can remove
> the logging I added since they're not going anywhere right now.

Thank you for analyzing this, and giving the reason. I’d keep it like 
this, but add a note to the commit message.


Thank you again and kind regards,

Paul


[1]: 
https://lore.kernel.org/all/20250810064656.1810093-2-ochang@google.com/#t
