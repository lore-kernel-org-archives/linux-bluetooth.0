Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2079828A1C6
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Jul 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067839; cv=pass; b=jrFbQ8E1XMj59wKaJ6z5ola/W6ULryG5GejWa5o12IeirNiC8aSPYaunFfjs7a4X38LKk32W+ck26C9Bc2e0fy2ixTQcHZNOP2YAJaObnGZ3gLBFvCDOrcBgdNudVt+Z7P0L/5FnlcppR0HSjfolUGDJNa755YXNtTPiBrc24Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067839; c=relaxed/simple;
	bh=JevLgu+W6wQ/j3kcqXc1bWeibNigeBT5zVughszsmvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lS5AM3PkGF1xLvSew2271QtGsrIY2UxiSGsd82HXjvpJ+X4K91STSq2R3qpfVOm2EwSBr7ERKNgEJc97JYZtJUYEy4/KwQKhJNdxyAFIcIBTnH9/Df6OI9+bGDCN+Eau72Urz/eN6P3kCTY+oJ2X8TIps3pThhFghAd2mv2iJlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b=UMSRBDIJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=frederic.danis@collabora.com header.b="UMSRBDIJ"
ARC-Seal: i=1; a=rsa-sha256; t=1752067832; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lfaagLByiQOpdq5Hv17yOmiIGLM6Ky1r76ci3lRllg39AV4hxI/qsNHEXfS33wAZ1+Z45LVoreSaJ7GeiqKoftSCVx1OZF/Ru0Gd9P16LKw6gpIrLn4qu8CtPEZLJsPCGL/4rg2SLayoKm3fNnuXzT16Dc00ZzTxa863XpAPuWQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752067832; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1v+RTFEhmoAu8eceAE6qc/hBhgCRdIFAhm7w3ZPx55U=; 
	b=oK8sLgXMy23I/CRosQM2GBj90Y+6fxLPSf31oWG6+V/6LT9/i8hexgC8PnU7r1cb61Y1BVKlQhwXYQSL6BiEziP9AckfHPunlzHiEBe4DKUVT9FuJOsK2NltciNJdeTb19+LmF2f17tZCvWDS2etwaoVoQxPPYenpmYtCRZlSf8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=frederic.danis@collabora.com;
	dmarc=pass header.from=<frederic.danis@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752067832;
	s=zohomail; d=collabora.com; i=frederic.danis@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1v+RTFEhmoAu8eceAE6qc/hBhgCRdIFAhm7w3ZPx55U=;
	b=UMSRBDIJ1svjp7yzurvDA8M9z2vIJFEOXMfTIZm6KPn4v/y5B9ntzVXatWqGlRvH
	AutK163OmBLb+0jzfi9elWmoWToEUHIKLydHCrBi/VvMCAM+sZu4TIc08kmUb0VALRK
	l2FuwT3N+q9EhQQANPl8puBMVNfjPJTOdMWF27M8=
Received: by mx.zohomail.com with SMTPS id 1752067829051816.448199730833;
	Wed, 9 Jul 2025 06:30:29 -0700 (PDT)
Message-ID: <c335c453-c589-4c46-adf9-a05f8ff4cf76@collabora.com>
Date: Wed, 9 Jul 2025 15:30:26 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] shared/util: Refactor code from strisutf8 and
 strtoutf8
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20250709094055.516584-1-frederic.danis@collabora.com>
 <CABBYNZL1oPd+VYZKiJqz0RM0Rr8oXXmUTxfTeLvkZxyi3RaGbA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis@collabora.com>
In-Reply-To: <CABBYNZL1oPd+VYZKiJqz0RM0Rr8oXXmUTxfTeLvkZxyi3RaGbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Hi Luiz,

On 09/07/2025 15:11, Luiz Augusto von Dentz wrote:
> Hi Frédéric,
>
> On Wed, Jul 9, 2025 at 5:46 AM Frédéric Danis
> <frederic.danis@collabora.com> wrote:
>> Move duplicate code to static validateutf8() and fix boundary access
>> on multi-byte character check.
>> ---
>>   src/shared/util.c | 56 +++++++++++++++--------------------------------
>>   1 file changed, 18 insertions(+), 38 deletions(-)
>>
>> diff --git a/src/shared/util.c b/src/shared/util.c
>> index 4780f26b6..36c06188f 100644
>> --- a/src/shared/util.c
>> +++ b/src/shared/util.c
>> @@ -1909,7 +1909,7 @@ char *strstrip(char *str)
>>          return str;
>>   }
>>
>> -bool strisutf8(const char *str, size_t len)
>> +static bool validateutf8(const char *str, size_t len, size_t *invalid_index)
>>   {
>>          size_t i = 0;
>>
>> @@ -1928,17 +1928,23 @@ bool strisutf8(const char *str, size_t len)
>>                          size = 3;
>>                  else if ((c & 0xF8) == 0xF0)
>>                          size = 4;
>> -               else
>> +               else {
>>                          /* Invalid UTF-8 sequence */
>> +                       if (invalid_index)
>> +                               *invalid_index = i;
>>                          return false;
>> +               }
>>
>>                  /* Check the following bytes to ensure they have the correct
>>                   * format.
>>                   */
>>                  for (size_t j = 1; j < size; ++j) {
>> -                       if (i + j > len || (str[i + j] & 0xC0) != 0x80)
>> +                       if (i + j >= len || (str[i + j] & 0xC0) != 0x80) {
>>                                  /* Invalid UTF-8 sequence */
>> +                               if (invalid_index)
>> +                                       *invalid_index = i;
>>                                  return false;
>> +                       }
>>                  }
>>
>>                  /* Move to the next character */
>> @@ -1948,6 +1954,11 @@ bool strisutf8(const char *str, size_t len)
>>          return true;
>>   }
>>
>> +bool strisutf8(const char *str, size_t len)
>> +{
>> +       return validateutf8(str, len, NULL);
>> +}
>> +
>>   bool argsisutf8(int argc, char *argv[])
>>   {
>>          for (int i = 0; i < argc; i++) {
>> @@ -1962,42 +1973,11 @@ bool argsisutf8(int argc, char *argv[])
>>
>>   char *strtoutf8(char *str, size_t len)
>>   {
>> -       size_t i = 0;
>> -
>> -       while (i < len) {
>> -               unsigned char c = str[i];
>> -               size_t size = 0;
>> -
>> -               /* Check the first byte to determine the number of bytes in the
>> -                * UTF-8 character.
>> -                */
>> -               if ((c & 0x80) == 0x00)
>> -                       size = 1;
>> -               else if ((c & 0xE0) == 0xC0)
>> -                       size = 2;
>> -               else if ((c & 0xF0) == 0xE0)
>> -                       size = 3;
>> -               else if ((c & 0xF8) == 0xF0)
>> -                       size = 4;
>> -               else
>> -                       /* Invalid UTF-8 sequence */
>> -                       goto done;
>> -
>> -               /* Check the following bytes to ensure they have the correct
>> -                * format.
>> -                */
>> -               for (size_t j = 1; j < size; ++j) {
>> -                       if (i + j > len || (str[i + j] & 0xC0) != 0x80)
>> -                               /* Invalid UTF-8 sequence */
>> -                               goto done;
>> -               }
>> +       size_t invalid_index = 0;
>>
>> -               /* Move to the next character */
>> -               i += size;
>> -       }
>> +       if (!validateutf8(str, len, &invalid_index))
>> +               /* Truncate to the longest valid UTF-8 string */
>> +               memset(str + invalid_index, 0, len - invalid_index);
>>
>> -done:
>> -       /* Truncate to the longest valid UTF-8 string */
>> -       memset(str + i, 0, len - i);
>>          return str;
>>   }
>> --
>> 2.43.0
>>
> I did something similar yesterday:
>
> https://patchwork.kernel.org/project/bluetooth/patch/20250708174628.2949030-1-luiz.dentz@gmail.com/
>
> Let me know if you have any comments.

Sorry, I missed it, you can discard mine

-- 
Frédéric Danis
Senior Software Engineer

Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, United Kingdom
Registered in England & Wales, no. 5513718

