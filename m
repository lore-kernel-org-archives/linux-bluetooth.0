Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907A48CF2
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 08:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713773524; cv=none; b=fS4y11/8PDdmynbkezyMgJWc26bw+/asOlg3XGB6W5Zw3Fpbogz/+Pq8/Rb3Kb4zkcA0BCPSJFToQ19v1hMg83f5lP1xFqO/LezCOk5zpj9zVhg4brqSKmln0ePOSduklF4LUZqYxWwpBU72PqXHKtadJ0k2Igh4VQERVGaGfDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713773524; c=relaxed/simple;
	bh=EJS75RiQ4+VKkI6GAcRc18ZHl/iOJDA37IaZDvkvWK8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CwRTXPQ1x4+CCPUBYBbkz+CArObTElQ86Iq1xNGVMbNHguXcp1flrDMp0iZ5tk78Fvc/YhIBqLDNB70G7B0uS0/AUb31fEmA1dqErEuAudBtArPOmmG+9bNHNqdP69+BE6iofUTzGbtqyn2A+GJa22eTUm7xsdYJzlzKHhqXYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xwcn00j/; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xwcn00j/"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-571bddddbc2so3642656a12.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 01:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713773521; x=1714378321; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/iU3fDLaUZxUe2psEdvl7LghmqEnc4MozhRH9whnhks=;
        b=xwcn00j/b5j/Ss2oaRJcsPIFXAhbOK4CAXWpVfHsIK9F7Hcsb40/es320UNAhGDCWu
         Za28jj1b2yFS3bBfAvOWsWGXFqzOXSHT3IqaB48x6hTps7sood8ib+O6Hvh070IHeDaP
         GcBE5RMVE345cGkMIxN+MR8lfFZOXiDmmrHgvOPZEWcyD6LKNRloK8GLSUfwGDNKxpw2
         9kGFcsiONza4BuTp2fxFEXbpdCrzHAHsWqtipcorCnmlov1J/KvHzj7OkYhGJwaHd8TZ
         2Z7G4hC8nQJyjTIhaZfubQudLy4CVxmIfvBa5WQAg9FwGKisZ+k4MchlMutNpUm1HFrS
         WMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713773521; x=1714378321;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/iU3fDLaUZxUe2psEdvl7LghmqEnc4MozhRH9whnhks=;
        b=f4D9GHli2IodieU5GKu8DCSoasoHqRiT79qxsSx0d1U1xIsrlgX9QQmXyn+6eKZPzP
         If23zOcHcti+VZASXIoWbqsYfQC6nFHBggL/xeTqwYAMM0aChiXcmu2lpP0vEKGbgvrg
         e7VrtfmDdtVmj0lOJ3J9QeNvezVLBe3HL+S+7vn/K51aJAQAoPjc3zPGxPqIJYDZ0TBd
         CXK1DGOH3aEI/NY666aHFGHvAkBPFFmyqmNVnUTdo5sMFRWNMAkh1euMr5JA4bHB1L5m
         SoQziFFRhTl3J0VhYg0PUsQhe2lzQCrKpQnrCkkRCdMPLYt96WSmKi9xp5SfZvlI5CkR
         4jhg==
X-Gm-Message-State: AOJu0YyVlljKc1tyVdF/PMM0CoGgPEyAhC3THe6813/lVbvlIpK7Jc8E
	w3mmx3jp5XLLtj0ilYEWi2rInrop6BKGYDilSk1RNmuWClwi2kyWUhhXno/pyZk=
X-Google-Smtp-Source: AGHT+IGJ73o1FzW/S1GDWiPkhKaUE+9BGVJBixf5S3BB9b+sYuEbxBulXb/oNdhgKw0sCR7qHTLf2g==
X-Received: by 2002:a17:907:980e:b0:a52:2d35:5e28 with SMTP id ji14-20020a170907980e00b00a522d355e28mr7077405ejc.57.1713773520988;
        Mon, 22 Apr 2024 01:12:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id lv11-20020a170906bc8b00b00a555eaf25c7sm5372845ejb.123.2024.04.22.01.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 01:12:00 -0700 (PDT)
Message-ID: <8b767a0b-5c5e-4128-9daf-7aad6378880b@linaro.org>
Date: Mon, 22 Apr 2024 10:11:59 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix two regression issues for QCA controllers
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <3ab33f9c-206a-4c77-816a-471769591b6c@linaro.org>
 <8e2b0731-fc0e-446e-af83-478e6e86a7ad@linaro.org>
 <04211e34-5a6b-45ec-91f7-60aaf0b6e2c5@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <04211e34-5a6b-45ec-91f7-60aaf0b6e2c5@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 10:07, quic_zijuhu wrote:
> On 4/22/2024 3:44 PM, Krzysztof Kozlowski wrote:
>> On 20/04/2024 13:01, Krzysztof Kozlowski wrote:
>>> On 20/04/2024 00:03, Zijun Hu wrote:
>>>> This patch series are to fix below 2 regression issues for QCA controllers
>>>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>>>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>>>
>>>> the links for these issues are shown below:
>>>> https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>> https://lore.kernel.org/linux-bluetooth/ea20
>>>
>>>
>>> Provide changelog, either in cover letter or in individual patches under
>>> ---.
>>>
>>> Do not attach (thread) your patchsets to some other threads (unrelated
>>> or older versions). This buries them deep in the mailbox and might
>>> interfere with applying entire sets.
>>>
>>
> sorry, not notice this.
> in order to send vN patch sets.
> do i need to --in-reply-to  v(N-1) cover letter or v0 cover-letter ?

No. b4 or git send-email handle everything correctly. Read go/upstream
before posting. If you ask such question, I doubt that you read it.
Eventually get someone experienced to help you with this.

> 
>> How did you implement these two feedbacks?
>>
> actually. i don't understand that two feedbacks so ask above questions.

You did not ask questions. You ignored that feedback and kept sending
patches, pushing for your point of view and responding to review with
unrelated sentences.

Best regards,
Krzysztof

