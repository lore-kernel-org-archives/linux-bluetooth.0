Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15F0F1CACEB;
	Wed, 23 Oct 2024 18:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729706519; cv=none; b=P2Dh+9qa5c0FqBE/TeF3WF3SZkFIaPf3HJBWZP2pS9/T4BPyULakMyOgt4ytsUCzvP6PW9HRBy9d9hN+NbhaVcCXlV5TfAbAINo9Y3sk0id3Y/zcjl5MexLCPIwv+6JNOEuIKDWk3U7BlxZFc1/CDZYc5v/9HsvfU7PKXbdz2Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729706519; c=relaxed/simple;
	bh=I4ACWuI3n//844emNhkHmFAsuW4VmmJSm0tQ+SRlj3g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eh30rhKOliuIz5ijQNXuCKYHoYLaAzdbdkyLJ8Mh2PvFGEv1jPJT5GpYwz1RP77i1Eoz5ijvNu5kk2VYQUvrX1ovpvV8k/b0YTOZJ4GfGTOXIxg3pqz/eROBaRU2mY7VIkaUbGtOeVQjbD9006pnfMzN0lG2FkwAtSBU0gCWQfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HT2Y2LN4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HT2Y2LN4"
Received: from [10.16.80.132] (unknown [131.107.174.132])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6232C210EF5C;
	Wed, 23 Oct 2024 11:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6232C210EF5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729706517;
	bh=Pd0YmvTZ9O7FYi5bes/feEPtOCby6koWSsHELkx9c4M=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HT2Y2LN4iLDg0zAAzh9RS2T5g37f+n0GamzE1kh1LlsJEU/nCflhQ0hmytXgboFjG
	 mqjXE5avKBwTjjISt/8UU2rKC0lNbwZihU2gZym5gGX811UgO43xWqgaJKN5suqU55
	 LhmhqxfmI+a3R6CQ+XXMJJceUX2N06js2V4eK+x8=
Message-ID: <e7a96b43-6d01-49ae-ad0d-4cb75ea69822@linux.microsoft.com>
Date: Wed, 23 Oct 2024 11:02:00 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] jiffies: Define secs_to_jiffies()
To: Anna-Maria Behnsen <anna-maria@linutronix.de>, lkp@intel.com,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:BLUETOOTH SUBSYSTEM" <linux-bluetooth@vger.kernel.org>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
 <8734kngfni.fsf@somnus>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <8734kngfni.fsf@somnus>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/23/2024 5:36 AM, Anna-Maria Behnsen wrote:
> Easwar Hariharan <eahariha@linux.microsoft.com> writes:
> 
>> There are ~500 usages of msecs_to_jiffies() that either use a multiplier
>> value of 1000 or equivalently MSEC_PER_SEC. Define secs_to_jiffies() to
>> allow such code to be less clunky.
> 
> Can you please provide a proper cover letter for a series (also if it is
> a series with only 2 patches)?

Yes, apologies, this isn't my usual mode of operations.

> 
> Regarding your commit message: secs_to_jiffies() is defined in hci_event
> and cannot be reused by other callsites and this is why it's valuable to
> move it into core code. Especially because there are ~500 users which do
> the multiplier thing and there are also several users which use (secs *
> HZ).
> 
> What do you think about converting the other users e.g. using
> Coccinelle?
> 

I intended to follow up this series with such. I'm not super familiar
with Coccinelle and am occupied by commercial work, so that may take longer.

>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>  include/linux/jiffies.h   | 2 ++
>>  net/bluetooth/hci_event.c | 2 --
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
>> index 1220f0fbe5bf..50dba516fd2f 100644
>> --- a/include/linux/jiffies.h
>> +++ b/include/linux/jiffies.h
>> @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>>  	}
>>  }
>>  
>> +#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * MSEC_PER_SEC)
>> +
> 
> Why not only doing
> 
> #define secs_to_jiffies(s) (s * HZ)

Yes, fair enough, I can change accordingly.

Thanks,
Easwar
