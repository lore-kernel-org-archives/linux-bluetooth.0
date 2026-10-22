Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792685978;
	b=KTXKp5ovo259Dxc7U4p5mrMTqgxcGhdyWpUgw0Ovnj9lZTMyZFZrBbWWrU6Y2DiZNOUV
	 f2cVLUhOAn/wTqFr8nSpzzWRVCInlJtyxS0gfBe9DrOLdaZC6fqZL2nVomWk60hebGgCh
	 +6IYt53iiQhcPYuY0eBkCQbRbekwaqUD/UBCLhPuTjDBFBKyDSEU+q4PuOh1IPsbXVj10
	 LZ02q0ZCD1BgbyWeYSk7my9GonibMNITAEMfI657gqnqhWJedzx1N914VO/S29Nt0LjkB
	 TrOjCF/GeqXXCDiA3cqvki17YHwrbkmXmQmnc1oP2a66fOcxHiOsrZGMPZT0jCM794g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792685978;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
	b=RTMi/bZFkQiX50edr84RkrxaFObOUImIOG6DD8vWFtE7vGck4ye3h3IhRvqIFRrGfY1y
	 ZYEXCsTlzehpTuD2TYB4iOtQX/DZDk0NMjV8CdpuPJyaJvZRo/607l77hzD/uLs+7hhUR
	 XxaytfFUkAh3frr5IOSMOMUcanFLY6Di9Fj5sz4EqaVN6jegGqiguKXaZbc7IFCdWMA2k
	 amOKv+FI+9+WpjA9RrHz2fpnak3mXMmrttP9cx++w2AfQvY9YdNTxLQbqZGDUUQ7t1wlJ
	 dtXBsuJOf6ptzKzuAQ+vhC1wdWTcorpH4d5/JVQnM71aTpVmJ7trKxSjyYyVTL9v7aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOE9VyiR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AL+caT8H;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50838606A319
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 16:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 50838606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZOE9VyiR;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=AL+caT8H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792685977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
	b=ZOE9VyiRY7HwsOc/p2WX3FlWJhYiIjw9+3OFaXnLq5ANr6NtP8AImcLv5wbt5EwV8xC2MM
	94JDwFsbE4pttgDz85C5Z4o/R1/9yohhE7t7XfS0ZOiWvOomx0SG3z/jpfKDPSneq+NFGJ
	RFqLrykVO+kQ9HvxzavITfgIW3C7Wb0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-kZkVpymqMAOZeiPXaLwfRQ-1; Thu, 22 Oct 2026 12:19:30 -0400
X-MC-Unique: kZkVpymqMAOZeiPXaLwfRQ-1
X-Mimecast-MFC-AGG-ID: kZkVpymqMAOZeiPXaLwfRQ_1792685969
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-48e1ad3cb66so1108991f8f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Oct 2026 09:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792685969; x=1793290769; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
        b=AL+caT8HyyLq7KDvAejUaK3d6aSmiFay5v7mIeVHf6Vs7XzD84r6FiTPAf3vUrLkqh
         /HxTI8I02rU3OHWJ6dV2dFubwpLXy1YYCERzqq3tXTIsweiQ/4QR1tyyxqW+j+9jZ1ea
         R7439NXcOR6zRABLqB6K5aMVTn48c8AL3leFB90ewAXOzzPpZD+dZoEYlYvdcXLJvVZA
         qL4hSfJ8pII3F+5whWKN4S8lxPSTF9PHFlrA8pYbeS4zA2b7cvMaqs9a21+9EkHN+pUe
         C0JsKyowtfZHPjrElMDest+JsI3YVH8+058GZqDhIl6sp2KgU5Xc71a5Gi2PFPqAEiKv
         88Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792685969; x=1793290769;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rQv+vHmR/Q2SHrYd52K5xLtIzo1Bo85ScgYlpurBBjk=;
        b=CTtmHnUpeDUaJEVniNKDug9jbZlR+K/EzlXzAkV6v7SSa6TVot6RvMPdyU8ZgzO32Y
         Kd5AaHEyKT9v7Vi+ROYTlbCSdm3D3iwdKGYYQ8KyVBDeS9Y/8G3DvDC3E7hUxaeKDZkt
         qqWlyNb1HYTXqPnuehG9m42e9f2mFJF33omnd+7gEjfHB78G2Kqwz0uOMkCYy3xVtTra
         QNyp8M6YV8MxvU3tpptf1tBd1R6wMmAsU0GwBvuVj6RsWCSX2hypRrHXi+2AZc0A1zNn
         LCxAuc+8QB8fuMRoDYHFHhrSidjit9HboVD0+25EbvDF4PnSWJYSaaTEso1GqmCtecRl
         rIKw==
X-Forwarded-Encrypted: i=1; AKwUvBxCSz8GjLMX+K4GAxCiWFq9pKZavYT1Qvnpid0Uzcuzkpw1fycknqz5AOgqDfjh8/WLKpT/qxJGO+61o/NhXr4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIFTuRESopAfCpXeys9fklMsVqanq9XC8QwkmvbAtTnWeP+HXBz
	fIPLhalraSB68xeiACbcT7VC6mFHavPXwb3w8qxk3/LMdDnLFQKqKTj1QOKj+ero6U3VpKj++UZ
	A08SfT7cwwpmKSdRro4pYRgE32J5jWnXaDR5gpsZNpkbgy4bXRTp04fysgaHi9JXuNb5StQ==
X-Gm-Gg: AYBFou0th+mk6dIJJqFEFCwf14bLg9enjehrA0ZgMIqqP6L3BNiI2/q3ZhJPXAgxqmj
	LkihqoGeLAc3KvqlR8vFOv2UdARDsKXbTXONWmRY/ekq7nyAyw/D10N2qAJMuoKyw9C/YwwYFwf
	8SoJFXMYkZ+ZkEQWGeo9RZu+LUsRGZZ+JVFlUiHVSf+laKtZZRdS4WThPMvyaYa8UE0efELA/LA
	KQwKj37iTsdAdc90NZyqMbQpMA6XvvjpkrN17JKfaumwntvZ9luaBzQFrU116b2L7d2KmvUoX5h
	za7ECEjBRHGOHjStlDLZluGfB7NYQwSgBw9co1iJUU4DfGrayNwY+zz0WxPMP/rEH8I9iMY66d8
	8rRZWv8AwE4qfI658q4D4Naz+vcouEZVCrwWDIHIxqxLi86UozkiBLPnXsDgJNgXY34zOEO24ug
	==
X-Received: by 2002:a05:6000:4555:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e264a3264mr8170283f8f.13.1792685968588;
        Thu, 22 Oct 2026 09:19:28 -0700 (PDT)
X-Received: by 2002:a05:6000:4555:b0:48d:f470:6b3e with SMTP id ffacd0b85a97d-48e264a3264mr8170243f8f.13.1792685968106;
        Thu, 22 Oct 2026 09:19:28 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e254f093asm13752672f8f.4.2026.10.22.09.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 09:19:27 -0700 (PDT)
Message-ID: <e084641c-d7aa-439f-b994-85011d7c11f8@redhat.com>
Date: Thu, 22 Oct 2026 18:19:26 +0200
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Bluetooth: btusb: disable by default Qualcomm
 multi-subsystem
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org, Zijun Hu <zijun.hu@oss.qualcomm.com>
References: <50f92fe870de717fca6368e750e0a6cbc8f46597.1792683340.git.pabeni@redhat.com>
 <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZL_EV5LHaXO4rUGu1jg7domF_h1xfmg1m9odHBfgFPA4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/22/26 17:44, Luiz Augusto von Dentz wrote:
> Hi Paolo,
> 
> On Thu, Oct 22, 2026 at 11:38 AM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> New knobs should default to 'n'. The mentioned one depends on
>> BT_HCIBTUSB, but the latter is enabled on most systems.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> this is a last minute fixlet to avoid breaking expectation for the
>> upcoming net-next PR. I'll merge it in a matter of minutes unless
>> someone scream very loudly very soon!
>> ---
>>   drivers/bluetooth/Kconfig | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
>> index db0189ca3cbe..0dca5e43edc5 100644
>> --- a/drivers/bluetooth/Kconfig
>> +++ b/drivers/bluetooth/Kconfig
>> @@ -96,13 +96,12 @@ config BT_HCIBTUSB_QCOM
>>          select FW_LOADER
>>          select GPIOLIB
>>          select WANT_DEV_COREDUMP
>> -       default y
>> +       default n
>>          help
>>            Enables various required support, such as configuration, firmware
>>            download, and error recovery, for Qualcomm Bluetooth controllers.
>>
>>            Say Y here to compile support for Qualcomm protocol.
>> -         If unsure, say Y.
>>
>>   config BT_HCIBTSDIO
>>          tristate "HCI SDIO driver"
>> --
>> 2.56.0
> 
> Reviewed-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Thank you _a lot_ for the very prompt reply. Really appreciated and
really useful!

+1 on my beer-o-matic :)

/P

