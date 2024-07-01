Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B9171088;
	Mon,  1 Jul 2024 20:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719864865; cv=none; b=WxniB0jpJjWVZkhsjIUNNvqO1XeQs8JKv5MHyUWqI4rvtqpl/OMcHAH4R9ayHU5+grBjUxZ6wJkvg/Fr3k7o65fjdaAliGM+3GVGoBwLC4OqIlFsKQIyPVDGno0rT5JcnbflDbremrcwrJx9NEtHg+JL5n5Ky7eQn6zi/hxvx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719864865; c=relaxed/simple;
	bh=4AT2VlNNqBZ1w5acWPHB5s9VSAvIH29wxPiVXwpVq/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m3Rd1ec74nWrsHDkEI2xzehGqw4P6w5jXQEr6K2anwS3RB7n2AzC/iGRR8jWPBFXCyND8udotCd753B4vXGO5CggUEZhXpMDX3c+PiZS/c+N3cURVjIO9KGJh/o/93a0HFjqYVTrla4QUqG84aSdGBz1yp4nrAhlSrmdrWCbhFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9Qx26VX; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9Qx26VX"
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-25cb15eed97so1352201fac.2;
        Mon, 01 Jul 2024 13:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719864863; x=1720469663; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lPisIHbT7NgArgGe0A8VwE546b+M0Dl/3KMl4VqlM9Q=;
        b=R9Qx26VXZUepO/OEK1JCVpt9yk63HP3GJ7fvd/LKsXWAU8VkNOnb0doAnYNRQBbdVx
         OuZm9hY2nL3jFKQ/V3wUYF9eiTw3tnbjvl0SvqNTcirUZzr1Du9gXSQ3dTjPGD0U/RLB
         2XgxaaqZf3GFH7dEVG+q2U23P43m+zI26PJKdEgBGEj4mGsrZIthEC2mROD5/8fMh30Y
         gGNVtuWoOjTxxsvUTIvgnmF7nRKkEcUbuwKE0ihh4S0TO60+J5ipPSlVSGgaEjwU7SjA
         YG+sW3X9b7NH1FptsRoBFnU+OlGkqqjRMQ1LfC8TddSD+0Y52eBpINW1EDx8oLuk7Tol
         +2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719864863; x=1720469663;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lPisIHbT7NgArgGe0A8VwE546b+M0Dl/3KMl4VqlM9Q=;
        b=f2gJ5fnpWjUdz5D0+mmIAKz2SED2nTNhk95/dPdx+PE8s/VMZg7UK5/Hgllty1Lbab
         RyCj5S7ilQb+lUqpDyhTWc18srhFmBQ/vzC8mMMhR/Gedn2DDkb1B72cHlnn04p2DxQ0
         OiYpoxYy/mzQWG/XyM293lf9ZWZWW0Id1Ucr4F9LAGQHtvQpNS53A/LZ9EvUcQqgIPdZ
         EbbrzqQ41WkTZHy2/3QEv58pow1ldDOzo4aMU7cySW8ZB8RJYqoB3cZhOzkmiCdRxSiP
         KCAeJaIcKmbD1MyKMQnzrNgQp5jjUBtzcW777CSMQEoJyM8Rfg7jMKeGI4QbeN/M+CQH
         0rXw==
X-Forwarded-Encrypted: i=1; AJvYcCXC3vOyokUrRVSQ1fB+XBR1N5t5FtY/O/S2TziZu5Zb1cHUtgmnKuNhmfwunu2pMOI7oH2sVsM2LL7lTyQBG90OKDrEpe7FzBZ3Tpfg08KHSUEsJmnnKA8MMtVuTFq2IiO5UcSQn+p0kh1oGnzt
X-Gm-Message-State: AOJu0Yw7HGSJEZS1OykdieDYLiaOUmthXgD6VqeMIktPzvcSFfAdNDTV
	l1TCqjbo/T/z6fYcq5W7EfjqwW+ssCe69DCeI24o83Y4U5bR96ukGpi9Cw==
X-Google-Smtp-Source: AGHT+IFgmVx9k0Jf41qZTCYZLtaHW4va3dB23NtgFS3Vr5Effre0PDZVRN96bkYYIS0e8QNA3uUVtw==
X-Received: by 2002:a05:6870:5b9b:b0:25c:bb8b:85bb with SMTP id 586e51a60fabf-25db351335cmr4284396fac.18.1719864863397;
        Mon, 01 Jul 2024 13:14:23 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70803ecf95bsm7163726b3a.140.2024.07.01.13.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jul 2024 13:14:22 -0700 (PDT)
Message-ID: <e1ea75d7-b59e-41e7-9a3b-bd63615a9d0c@gmail.com>
Date: Tue, 2 Jul 2024 05:14:19 +0900
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hci: fix double free in hci_req_sync
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Austin Kim
 <austindh.kim@gmail.com>, Yeoreum Yun <ppbuk5246@gmail.com>,
 MichelleJin <shjy180909@gmail.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, Levi Yun <yeoreum.yun@arm.com>
References: <20240701194531.97576-2-yskelg@gmail.com>
 <CABBYNZLL0uYpgqSpQ+75mkZ194UTx+ojv-WreBKX52+EyQJ+Hw@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CABBYNZLL0uYpgqSpQ+75mkZ194UTx+ojv-WreBKX52+EyQJ+Hw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Luiz,

On 7/2/24 5:06 오전, Luiz Augusto von Dentz wrote:
> Hi,
> 
> On Mon, Jul 1, 2024 at 3:45 PM Yunseong Kim <yskelg@gmail.com> wrote:
>>
>> The approach taken to address the 'CVE-2024-35978' introduced another
>> double-free vulnerability. commit 45d355a926ab
>> ("Bluetooth: Fix memory leak in hci_req_sync_complete()")
>>
>> 'hdev->req_skb' double free scenario:
>>
>>  cpu1                        cpu2
>>  ====                        ====
>>  sock_ioctl
>>  sock_do_ioctl
>>  hci_sock_ioctl
>>  hci_dev_cmd
>>  hci_req_sync
> 
> hci_req_sync is no longer called from hci_dev_cmd:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/commit/?id=6851d11d389ceb00c1220b267b9a04f54dbc4573
> 
> And I'm in process of removing hci_request.c completely.
> 
>>  __hci_req_sync              hci_rx_work
>>  kfree_skb(hdev->req_skb)    hci_event_packet
>>  (sleep)                     hci_req_sync_complete
>>   \__ Longer times,          kfree_skb(hdev->req_skb)
>>       reproduce well         hdev->req_skb = NULL
>>

Thank you so much your hard work.

I saw the patch email at the link below.
Link:
https://lore.kernel.org/all/a9609dd3d0cb3b8c3fd387efe8a81eddc821be0f.camel@iki.fi/T/

Does the patch you mentioned apply to backports as well?


Warm regards,

Yunseong Kim

