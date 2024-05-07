Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20CB0381C4
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 May 2024 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715063243; cv=none; b=Wg9zJmiOiaqKQXhN+J9uKSC2zTTfsOb988EnQbtuDVju2cAkZtM3UCOPxpwiQ/dGcIeSXAMAwAwXZ4BYac/L8TRyvdVjsinOEiTrFMK5H3LuvATOxJxht3egU6PECAZ4GRR/6ksRepBpMHF7PA4AryVNOCo3ITIIhX1llASuwG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715063243; c=relaxed/simple;
	bh=OBdfW5aLuDecsyCU1p2RlGuUvfAu7kQ3qHZ6UE6wcSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uJ5Pbzmju2jcOdA1evwMRxSOWnX7KrW+CvUWu/cBriYDzAijhW70beb79aeW2355d8xFkZbyldkrVkeIzqNN07daQqJ3Cn45l/TmojTwAd/nZkXR9ifm9LGCoo0txgJpA5wNFjYeruyDkYkx7JzeUnRC/y0fTiQIu87D3hcTWRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tr65OS8X; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tr65OS8X"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a59a934ad50so595938566b.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 23:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715063240; x=1715668040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Bf2zdEkKOdIbrvVJ1LE+LZvtdsAMqAjWrwIEHtThy6Y=;
        b=tr65OS8X+vR1f1y7zs7Lu8Lr8SOMpsCfREjkOFCIzzats2fVD/2hPBKts0JomiL5Fk
         8Ri/YAN/r8WHOPjoWcCCX8rOkuE4Vrh9uVptaYNYmhP8TboOKGSvgrlPW2JZ/Sp+b06Z
         ZDOAjsuBvwUNI1cYzXsn8B3NpONrI+ojzSFPJfOsIBxQDnbFulPSoEwWAmwxrofJEsr8
         MqjWmRhukksaL3uaRqNUaIdZzF5dIpPtUN8A/CErt+Wq23WAow811LegG0lC1Eo0kuUi
         r3av4LbxlXBr1a5Qsv4/nIxNv68xZvwbgqIdAX0T6V5fN5zVnUfPybYAc9RgUPvQ+loS
         1Mng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715063240; x=1715668040;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf2zdEkKOdIbrvVJ1LE+LZvtdsAMqAjWrwIEHtThy6Y=;
        b=c2zecPUCfW3fsHNxrVWesxv/TbSUYXQkyQuGn6TJkVJI/W0UdXgIh5qR0eVV0ikokr
         +vq9tgZufMVhwRX049Q15L4sgVI/4VuMVLTj2hXVClkg04Rb8pbdROiq2s2ODFdZRJRy
         djjYWemH+hm3rcw3Wjkay1lml2NX5Cl5HUmG63HDP3eUt/Pu9qJWqki+BSoickWagB7F
         o/xsGyVgLg2eRV/WKEk/piF+Thnq00iCSK54q9eCH/ZPXix51zYa1bXDC2tDeADyQPi2
         xDyB5Htj7zwjRUPn4B954GC9WGldBnghWMkdVulvVy61SvlqervRtcBhHCOYpgF3n/5P
         92cQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoYLQlOKC+BxzLXtdzwo96FlDGFundgyqHpDjGupaw9vrRAs/83kQwqo839ILiHEcKrz7bLJSGNDMOcGZ+HHuU5bkQvDneGnnLUCu618/j
X-Gm-Message-State: AOJu0YxhYkOb80/yGZHxwWpBMEBkiCY+1tQSVk41ZKorMypnQwUnzCJg
	Nz2FrMt1+gLieD+gK5OGQhprhlkSiBy6UHetDAp72UlyRGhCBphpHbR5kE043os=
X-Google-Smtp-Source: AGHT+IHTp7tUdf1f6Wrs1v/r1aQIno/Z+7Lcedp6iPp3ZdfyFC/RH8U61xIhVl4Snsj5KPU/ei8s8w==
X-Received: by 2002:a17:907:940b:b0:a59:bbf0:88fa with SMTP id dk11-20020a170907940b00b00a59bbf088famr5239950ejc.28.1715063240432;
        Mon, 06 May 2024 23:27:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.206.169])
        by smtp.gmail.com with ESMTPSA id n26-20020a170906119a00b00a59cd12c9c6sm2166647eja.116.2024.05.06.23.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 23:27:19 -0700 (PDT)
Message-ID: <08241854-2837-4e8b-ba12-79bcbc970c1b@linaro.org>
Date: Tue, 7 May 2024 08:27:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: path to landing patch to fix warm boot issue for qca6390
To: Wren Turkal <wt@penguintechs.org>, linux-bluetooth@vger.kernel.org
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
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
In-Reply-To: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/05/2024 21:21, Wren Turkal wrote:
> Krzysztof,
> 
> I am reaching out to you as you had the most important objections to the 
> change to fix qca6390 for the warm boot/module reload bug that I am 
> experiencing.
> 
> For context, the problem is that the hci_uart module will send specific 
> vendor specfic commands during shutdown of the hardware under most 
> situations. These VSCs put the bluetooth device into a non-working state 
> on my Dell XPS 13 9310 with qca6390 bluetooth hardware.
> 
> Zijun's proposed fix is to not send these commands when it's not 
> appropriate for the hardware. The vendor commands should be avoided when 
> the hardware does not have persistent configuration or when the device 
> is in setup state (indicating that is has never been setup and should 
> not be sent the VSCs on the shutdown path). This is what Zijun's patch 
> implements.
> 
> In addition, Zijun's change removes the influence of both
> the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts 
> that those flags should not influence the sending of the VSCs in the 
> shutdown path. If I understand KK's objections properly, this is where 
> his objection is stemming from. KK, is this correct?

Yes, because this basically reverts my fix for shutdown path and
re-opens the race condition.

> 
> Zijun's proposed fix can be seen here: 
> https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/
> 
> I'm wondering if we can resolve this impasse by splitting the change 
> into two changes, as follows:
> 
> 1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING 
> flags in the shutdown path.

There was no explanation why this was removed, so it does not matter to
me whether this should be separate path or not.

Zijun, even though I asked four times, did not provide information on
which kernel this was prepared and tested, and on which hardware.

I assume Zijun did not understand original issue, thus assumes changing
the code to HCI_SETUP fixes it.


> 2. Add the quirk from Zijun's patch that fixes my hardward configuration.
> 
> I'm hoping that better clearer descriptions for #1 can help get that 
> landed since the logic current appears to be at odds with how the 
> hardware works.
> 
> Also, I am happy to split the patches into the two patches, or (maybe 
> more ideally) just modify the commit message to better indicate the 
> reason the change. I just need guidance from maintainers so that 
> whatever work I do leads to something acceptable for y'all.
> 
> So, please help me get this done. I am just a user with broken hardware 
> and a fondness for Linux. I would love to help do what's needed to get 
> this fix landed.

Best regards,
Krzysztof

