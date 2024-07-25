Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A03249ED
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721940483; cv=none; b=oZxCMuZ1DvKUrvvXsEMnqke24JWLS9znSNgqloxC5DuP0zb0tPNQ0f4WA/yNiEDFHvws6gQe0fbjIBUg4MeCRARiN6uvhPdx0YngYQ1XatuMHiChokq2nCKemVoouga1Lm72rTfh2nqsj6O/P9/ahi8H3rPYI0JMkD+0YOOvcOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721940483; c=relaxed/simple;
	bh=rhXoNqDfqqggPPDeX8KuavAyrGa9lS4NvvS718U3qqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwHRJ1rYWEYuzcPhm2ZxRSc4c+FPZRhUM+BcVLQx/uFFy0H6nQWlLEIq7QsJvJR1WizrQ5H7Z6I3CUXXBroXctpf0AfXi9yYjO13P4TOCIe6wrckeNL1uhd482uI0YMdkXXEvcveyPzn3QG/nIozU/wBOffhYFDQ5XI4uvSsPfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=dihqZx2D; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="dihqZx2D"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a115c427f1so215138a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 25 Jul 2024 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1721940480; x=1722545280; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SGas4NAIZlgp1NOKOLjoYlKyc4maTrUF5UV+zPz4UcU=;
        b=dihqZx2DVg+lYhP4foEiaoJohRP8xkbug82sS+pyvnBzKgW7TYJFtozU3MNntq8j+p
         GNGthkGT0uLWnotHG8uyRMgqGp4JT6F/B5XTPZqW5WIwNnMhIz9+O79TEcC0YDQGCYfI
         YFmCPZYfYplRqP7cKUeidSCviYRmpHo21fENo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721940480; x=1722545280;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SGas4NAIZlgp1NOKOLjoYlKyc4maTrUF5UV+zPz4UcU=;
        b=nOx3WQRddtDUJIa4m1KbQ45bAIp8rpoFMpzy3ddszX21LlZ6ai5VUAnSqrpChdqmWZ
         V32Br1uYeO84J4UmGxYFgSpm52fj6o7OkYrbMqQEZp4ygTmfOh2UcQ0cpqggfHL48qmT
         6t7bgD/VWf2c+dp+muz7GibEI/3MPrXJ8EKBESeZepuY72r2M0BvFErPBLk5gNxn8v0t
         O9P0PgPnGYPXDeJ7TzGQSeeb0o9xtuWnUrKFpGo2u7eMZGFBz1hoVtJV/+owffQcVtd5
         RrLUCVWycJMkL9SwV7o5zSbTwoR3M9I9F5P0nFP5iAgkxfQZq1Vs86xUOZI6oTwwud5d
         6zLQ==
X-Gm-Message-State: AOJu0YyRheUOM3GnEgb8MKmJYxPGXzAgbVUVsKpanEGJvdcrEWVS711f
	1DKFrpLpwgudbj1Rn//Gmq8zCEigp+8dYnEdn3FctjF835FDu1Mpxr2jYm5tU4lGHKHKmcO1FYd
	wvA==
X-Google-Smtp-Source: AGHT+IFVKupZQZl9SVw6WfvRtUtjWeLYhis6k0gFAnjdUNF/b/i3KaSxCxBP/k2KJtmYBQCVLDZXdQ==
X-Received: by 2002:a05:6a20:cf8d:b0:1bd:28b9:6f88 with SMTP id adf61e73a8af0-1c47b1a1fbemr3794379637.24.1721940479709;
        Thu, 25 Jul 2024 13:47:59 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a9f8655dffsm1361446a12.39.2024.07.25.13.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jul 2024 13:47:59 -0700 (PDT)
Message-ID: <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
Date: Thu, 25 Jul 2024 13:47:57 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
> Hi Wren,
> 
> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org> wrote:
>>
>> Hello BT folks,
>>
>> Just so y'all know, the QCA6390 bluetooth hardware appears to be broken
>> at least since commit 720261cfc732.
>>
>> The KDE and Gnome bluetooth control panels appear to think there is no
>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>
>> I have a Dell XPS13 9310.
>>
>> I will attempt to capture some kernel logs in a bit.
> 
> git show 720261cfc732
> fatal: ambiguous argument '720261cfc732': unknown revision or path not
> in the working tree.

I gave you the sha for the built fedora rawhide kernel package, not a 
mainline sha. Sorry about that. I thought it was a mainline sha. I am 
trying to bisect the problem. Hopefully, I can get a mainline git sha 
for you soon.

If it helps, the build date of the kernel is 2024-07-19.

Sorry about the confusion. Hope this helps track down the problem.

wt
-- 
You're more amazing than you think!

