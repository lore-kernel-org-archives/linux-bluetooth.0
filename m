Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A89F342C8F
	for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 15:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666439; cv=none; b=luriQ9hOCEmRPXXJhlZKBUTgMRh8/xmgXHbXTLgZd/IMnvzxv9Tb4OnTP3Ce7tWUXDmXas8sd3mq0yNMGLIRCJ1/MikIbVQ7egqF0EsQ3v5t8k/ZeZA7H/ghykYn84U1nqnm6MmcUMk/Q1MET4cQUeCDBzqC4EcHjnk3knoAjgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666439; c=relaxed/simple;
	bh=9Y6cuup2ygOkn1D+mhXdhwDZmH2FNUNmnj6uiwVUQJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0duXdQkCn+3WUIM1Wj1+EjrRQ4Rx4vXnlPvEMqsa2sgMBvyNE9ewBXzn0KJFH84FKWA0JzhoBjLNO4drpXnZ8U06KGmvhqnx1ZFUlZV9N42LOwQYLZ3B4wHM6ZcHj1KJDuqo4jplfIzml1+4PgwOZ5WFSkoSyPGyDV6IX5EDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tHThKcag; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHThKcag"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710653ac03so2492065e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Oct 2025 08:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761666434; x=1762271234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly7igO6UUojvT0L2mrFQ2G8pxDYiFWGNFbACO3M5+Qg=;
        b=tHThKcagI7Z0p3EP2uB3JS0FBrV7N7EWFzN63OFRRCX6WKJaUukWynvT+ySRj6FZ8Y
         pPLPCp81oUko4KJy/GDd7uwhtcIb2k6dWyb/62DYcythxCcVI73UFyOqIL3cQahUcSqP
         V+m0R0CZS5f0Ae51X9AGGgzvgd+Mf01TPadcS5djDXjj9TW96mC9Lon9Ls7p2UiLFTIH
         DKWfl1+oOq1J5BsdpqFjqhCQN3wmxQ3+NMHFWSlsTFXQ5d76/ZizniaHaO72Fj81ZJN3
         N6zdXqBogJ0DIkaelcMVSHJ8YBKE9RGyUqS3w2PZkUWLyWAct9Xnah1X4b6E7846sd/a
         spsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761666434; x=1762271234;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly7igO6UUojvT0L2mrFQ2G8pxDYiFWGNFbACO3M5+Qg=;
        b=eoa2Jods59V9rqMaaoxA6cZSWPOqC/HnnDTSnrm5oZwfWvTLCf9AHg3h+mtJUViPYf
         471CXv5vfMmde/galYdWhHcJS5G9UBDcFqc+07eKjo+VOlgAiJm/unas1x77XLU8EiCp
         aZTNYqB6eaFhjlmPHe7XPCV7RIe+afxM1GwJTJxjqACUgOiA0AMRqvNxjjBjmLw2Y7Da
         zQim1yaRDtaS1gIZYAUH2UkTnNfwnCBJ21ZOoDh9Swo6C3yI9LaJ6a3MF8DHbqGvlkER
         eOidxxVYoLzoSuCgxFAe65+b+sFHuk79w+tjEX9jBEj2a5kRSNtXzuvDhMMrfzOOzRYF
         hmig==
X-Forwarded-Encrypted: i=1; AJvYcCX728U6gOTvgjZJVDutgeM4/nfkxTkEFiOsUf8+7Emg/pllnxhDUmzMkiApuoo362XNJfMZTXZX16OhmXdehu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeTRJoVhvpVocyYaaLPg8aggNR9/hTDfxCkc9dIRwPk1wEPjh0
	OXQxcwbPtnS+EuulRya51eEIwKNJCZVIVROsQjW8PCXhTpEDpo+dWULAp9eG89PrEkNlPYjvd2t
	frtbq
X-Gm-Gg: ASbGncuPPP0rqyhOOYVwKdhlkIoixdL5w5cdEfHlLIiVXggTk3GUWYT4QyCW2ukWLkI
	RSBIMZNMkRnHkCKflWnG58Jm2w21Y1Y4G8YxMpgX7URVy7WDen1mpg+f9VxEJvHwvQwyDJP0Pwu
	gVNomCPudqFCMjk6+TtvKh8qFOtM/tNYHpE6+FfYFPSdKTACaK+rUwATTiv7EM1WaUn9bKQxbQw
	bZnom0a2nQ5D2d2KvjLA1Qa2hfs4PIsv+xzA8/ilHuKWxwLO7XIR4jVhCN9U1xePEsEtnBRGOCj
	cal3fXudW5/STnlGd9Rovp+QmqNvnxAIt8gaCPjEhUA9laGebx3aQuvU7q81YRLD5DHUIVAK3il
	FwuCQjOu4voY7Ema/Ze7P8+Q0wThKIeyLS5KYuSG0FXDTD0uEOnROSffqnN3Gc9QkXf5NbvJpzk
	XjQTBKMZ16rz/Y6mfd43bK
X-Google-Smtp-Source: AGHT+IGKgXwlOvIehOvpFN7gEcO/B/7FmJXLc3na7usvqcT8HRKr9yeuOhth8NNWw1FimUvqgwzEIw==
X-Received: by 2002:a05:600c:3513:b0:475:dca0:d457 with SMTP id 5b1f17b1804b1-47717e7f4b9mr18168985e9.8.1761666434496;
        Tue, 28 Oct 2025 08:47:14 -0700 (PDT)
Received: from [192.168.1.29] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475de57b156sm192684785e9.13.2025.10.28.08.47.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 08:47:13 -0700 (PDT)
Message-ID: <bd5bb1f2-a8ba-4828-9d04-2e1d433ecadb@linaro.org>
Date: Tue, 28 Oct 2025 16:47:11 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] Bluetooth: MAINTAINERS: Orphan Qualcomm hci_qca
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
 Rocky Liao <quic_rjliao@quicinc.com>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20251028-dt-bindings-qcom-bluetooth-v1-0-524a978e3cda@linaro.org>
 <20251028-dt-bindings-qcom-bluetooth-v1-1-524a978e3cda@linaro.org>
 <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com>
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
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+AhsD
 BQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmgXUEoF
 CRaWdJoACgkQG5NDfTtBYpudig/+Inb3Kjx1B7w2IpPKmpCT20QQQstx14Wi+rh2FcnV6+/9
 tyHtYwdirraBGGerrNY1c14MX0Tsmzqu9NyZ43heQB2uJuQb35rmI4dn1G+ZH0BD7cwR+M9m
 lSV9YlF7z3Ycz2zHjxL1QXBVvwJRyE0sCIoe+0O9AW9Xj8L/dmvmRfDdtRhYVGyU7fze+lsH
 1pXaq9fdef8QsAETCg5q0zxD+VS+OoZFx4ZtFqvzmhCs0eFvM7gNqiyczeVGUciVlO3+1ZUn
 eqQnxTXnqfJHptZTtK05uXGBwxjTHJrlSKnDslhZNkzv4JfTQhmERyx8BPHDkzpuPjfZ5Jp3
 INcYsxgttyeDS4prv+XWlT7DUjIzcKih0tFDoW5/k6OZeFPba5PATHO78rcWFcduN8xB23B4
 WFQAt5jpsP7/ngKQR9drMXfQGcEmqBq+aoVHobwOfEJTErdku05zjFmm1VnD55CzFJvG7Ll9
 OsRfZD/1MKbl0k39NiRuf8IYFOxVCKrMSgnqED1eacLgj3AWnmfPlyB3Xka0FimVu5Q7r1H/
 9CCfHiOjjPsTAjE+Woh+/8Q0IyHzr+2sCe4g9w2tlsMQJhixykXC1KvzqMdUYKuE00CT+wdK
 nXj0hlNnThRfcA9VPYzKlx3W6GLlyB6umd6WBGGKyiOmOcPqUK3GIvnLzfTXR5DOwU0EVUNc
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
 DFH41ZZ3t1Qbk0N9O0FimwUCaBdQXwUJFpZbKgAKCRAbk0N9O0Fim07TD/92Vcmzn/jaEBcq
 yT48ODfDIQVvg2nIDW+qbHtJ8DOT0d/qVbBTU7oBuo0xuHo+MTBp0pSTWbThLsSN1AuyP8wF
 KChC0JPcwOZZRS0dl3lFgg+c+rdZUHjsa247r+7fvm2zGG1/u+33lBJgnAIH5lSCjhP4VXiG
 q5ngCxGRuBq+0jNCKyAOC/vq2cS/dgdXwmf2aL8G7QVREX7mSl0x+CjWyrpFc1D/9NV/zIWB
 G1NR1fFb+oeOVhRGubYfiS62htUQjGLK7qbTmrd715kH9Noww1U5HH7WQzePt/SvC0RhQXNj
 XKBB+lwwM+XulFigmMF1KybRm7MNoLBrGDa3yGpAkHMkJ7NM4iSMdSxYAr60RtThnhKc2kLI
 zd8GqyBh0nGPIL+1ZVMBDXw1Eu0/Du0rWt1zAKXQYVAfBLCTmkOnPU0fjR7qVT41xdJ6KqQM
 NGQeV+0o9X91X6VBeK6Na3zt5y4eWkve65DRlk1aoeBmhAteioLZlXkqu0pZv+PKIVf+zFKu
 h0At/TN/618e/QVlZPbMeNSp3S3ieMP9Q6y4gw5CfgiDRJ2K9g99m6Rvlx1qwom6QbU06ltb
 vJE2K9oKd9nPp1NrBfBdEhX8oOwdCLJXEq83vdtOEqE42RxfYta4P3by0BHpcwzYbmi/Et7T
 2+47PN9NZAOyb771QoVr8A==
In-Reply-To: <CAMRc=MdqAATOcDPhd=u0vOb8nLxSRd7N8rLGLO8F5Ywq3+=JCw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 28/10/2025 16:43, Bartosz Golaszewski wrote:
> On Tue, Oct 28, 2025 at 4:33 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> There are no maintainers of Qualcomm hci_qca Bluetooth driver, so make
>> it explicit that driver was orphaned and no one cares to keep it
>> maintained.  That's also indication for future removal from the Linux
>> kernel.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  MAINTAINERS | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8abdc0e50699..be637b9dc7c0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -21146,7 +21146,7 @@ F:      drivers/net/wwan/qcom_bam_dmux.c
>>
>>  QUALCOMM BLUETOOTH DRIVER
>>  L:     linux-arm-msm@vger.kernel.org
>> -S:     Maintained
>> +S:     Orphan
>>  F:     drivers/bluetooth/btqca.[ch]
>>  F:     drivers/bluetooth/btqcomsmd.c
>>  F:     drivers/bluetooth/hci_qca.c
>>
>> --
>> 2.48.1
>>
>>
> 
> Actually, I added that entry so that the arm-msm list can get Cc'ed on

Ahaha, nice :)

> patches. The fact it didn't use to, caused some regressions. I have

It also points out that drivers do not have a maintainer.

> done some work on it, so I can take it over as maintainer.
Sure, I'll send separate patch for that replacing this one. Shall I add
you to the bindings as well? All or only some?

Best regards,
Krzysztof
