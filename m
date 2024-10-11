Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8961D0DF2
	for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675838; cv=none; b=UueLfanHtfOgeyCTzbkFot2/WJZ/iApjaEyx5mRlUuaxzGm9l1fARmgd8emJlPCyZUkTv4TJfbZm7qKXKgcFoOXmm88z2GqHfmwmTp5iWvOKPrMed+x6vERufokrkh9sg0XG4bewcrI3SD3XJvNCSjvAQoDLQRLY0TW3LfTvA8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675838; c=relaxed/simple;
	bh=UEieaCly8CsTMP8Slw84ziyizZtR2owvtScXAa06vJQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+pDUwFWyBBFHa5blka/vwgGPymBqsREcxEALgegRM+RJIFW8W5BPUaHrBmmuK7e/cP6voE3E/ae4Ek3gtE/C+DZE6rpxrwOMNanujtiVpb03S1qt3E0JGN7CcjuY0ZTbGuCYp5DBzZMdIxpNGI8a5TbMu4dmvF6w5Hd4269yNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AI39zKFC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AI39zKFC"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a99422c796eso387875466b.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Oct 2024 12:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675835; x=1729280635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=SDigYJRs9s0cqrPs337ykIC/lJ5lY/aTkzkKnAbaowc=;
        b=AI39zKFCAzSFHv0it/LT30fcCIXGIlID4mYvBWzkpP80as8loGn0w39UIqH/uj3wEA
         xRS8G2GexFlXfWguMVPNnB3yLacehhzxX943jy0PLcEQPXnYXLP6JRmv0USx3BS4NSnF
         4znNGDRjNoeDog7zJMyc1YDrCWcj0XtPh4WitCmpW4Ezfa36ZtAMxGgB4IATQkG63H+r
         QRB2ney1vnwnD5RP+haSAwqg55LIO2L029TTkum2XRfmBZWDc+zuMkdXioF9APvU3mqu
         PcOGqbjBvMSe8hbCWHqWOr2Mj0yAL44GF7J5edzTxIjnjRS4HiJioXNA9LCg24dINij8
         JObw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675835; x=1729280635;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDigYJRs9s0cqrPs337ykIC/lJ5lY/aTkzkKnAbaowc=;
        b=kzJ8X8KUxxquK4O7mGWw/pvwhXvi/d6OD29EO19jZJMzeQ5Q5bvnompPU+ErB6ur0H
         SDeQtAuM0TyZs9Yql4pxnmOzNfSF36iGh5RByCeCqEKISglIHCX7ESc8//rZw8TVZHXp
         wC+mAXfxRaJ9yepvIsRKvWFLdJD6b7ahr18Koghw1NTG3X/TB3+APKF2SCpQwY+LC8xk
         v77WD9yWYBg6/+QKTM970r9dB+wGCnr22EWwlpv5iB1TA6sfWM8QmuCoDkFswWVwhZI2
         yP5iZjvUx9OhFdvjHcfcKw8444+ddaoqVR4ZjuDLipc+xPuMqc5RXfkotPUlHRsgnMr+
         F4NA==
X-Forwarded-Encrypted: i=1; AJvYcCWyeSQpVLzh5/zUicuWs9NENB/T0lQQnPxYasH2hHPlP+e8rtQIBH12DsLeDEdMCohzvP5FFjySXSPCsW1zmLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyO0bWIllaMiIImayL980zaQHgH4T1qvMfnUYrqyS6fDecKkgW
	05bZ5C5plvbbKt4KSATi6Uue0xiKnW9knEJVSYOZP9kQnlJX1wPUjQlenw==
X-Google-Smtp-Source: AGHT+IGdOGTLB8Cc1bYv+sgcalnhpwMYMfdhifiQT5yXy/lxxw+s2l/2okNtJ9C2cl61WUFjSqp8VQ==
X-Received: by 2002:a17:907:36c8:b0:a99:89e9:a43d with SMTP id a640c23a62f3a-a99b940f030mr398909066b.39.1728675834490;
        Fri, 11 Oct 2024 12:43:54 -0700 (PDT)
Received: from ?IPV6:2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce? (dynamic-2a02-3100-afd7-9a00-94ac-542a-1cd2-c9ce.310.pool.telefonica.de. [2a02:3100:afd7:9a00:94ac:542a:1cd2:c9ce])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5c9370d273fsm2286003a12.16.2024.10.11.12.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:43:53 -0700 (PDT)
Message-ID: <020c69d7-ad86-44d3-a508-22ff949ee7ec@gmail.com>
Date: Fri, 11 Oct 2024 21:43:52 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Connection issue since 81b3e33bb054 ("Bluetooth: btusb: Don't
 fail external suspend requests")
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 BlueZ development <linux-bluetooth@vger.kernel.org>,
 Kiran K <kiran.k@intel.com>
References: <595efd8b-e0fe-4a87-90b1-4b579f3cc876@gmail.com>
 <CABBYNZJMWni33VQ2sX9EDcNbsFbX7pjAFj4QLri9N7jyLY0HvQ@mail.gmail.com>
 <c8b5c842-463e-4c30-b7e0-f41bf1d59305@gmail.com>
 <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <CABBYNZ+kcwgPvCNFZHZZok_a6ZNXEPNABNefb4iaSNDNm4wPVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11.10.2024 21:05, Luiz Augusto von Dentz wrote:
> Hi Heiner,
> 
> On Fri, Oct 11, 2024 at 2:52 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 11.10.2024 18:36, Luiz Augusto von Dentz wrote:
>>> Hi Heiner,
>>>
>>> On Fri, Oct 11, 2024 at 6:49 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> Since linux-next from Oct 4th my bt speaker fails to connect if I switch it on.
>>>> It just hangs trying. Manually connecting it via bluetoothctl works though.
>>>> With this patch reverted it auto-connects again.
>>>> If you need additional details, please let me know.
>>>
>>> I suspect something is trying to suspend the controller then, it
>>> shouldn't be USB auto-suspend since that should behave as it
>>> previously but if there is something externally (aka. userspace)
>>> trying to suspend then it will force it to suspend.
>>>
>> On the host side it's a combined WiFi/BT PCIe adapter (RTL8822CE).
>> Runtime PM is enabled, so this may kick in. I'm not aware of any
>> userspace tool which may try to suspend the WiFi/BT adapter.
>> Disabling Runtime PM may be a workaround, but I don't think that's
>> the actual solution.
>>
> 
> Well I assume it still using USB as transport, not PCIe, otherwise it
> wouldn't be using btusb. Regarding runtime PM, I assume it still means

Right, it's a M.2 adapter which utilizes PCIe and USB.

> PMSG_IS_AUTO Documentation/driver-api/usb/power-management.rst:
> 
>      'External suspend calls should never be allowed to fail in this way,
>      only autosuspend calls.  The driver can tell them apart by applying
>      the :c:func:`PMSG_IS_AUTO` macro to the message argument to the
>      ``suspend`` method; it will return True for internal PM events'
> 

