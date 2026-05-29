Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CF53B27F3
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 07:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780040127; cv=none; b=W7XyG13eCdLM9jLZUP/kB1y1UjQ6qzVtKUUs2pR1qVnnWepq9UiyUofFkJngAOw8x3B0gOYQh3J1/GzJ734xRkSs7QVGcdhQWB1SAP6QFTiJRfUHQkqWiYiqbCfo1pfUSWlhvzrykmkAO11Z90/uQJp135pssHTDhYeOTj5kqC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780040127; c=relaxed/simple;
	bh=S0Gw/6vAjouVLSqwBt7EnwCvtBf70xRCtFoUQO/ogGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzIdO5c1P8mXZzk+WGqEX2e3UiPQ0DvbQlsNGYOR8TVVDPp2NSdSAn2ONSvYa74AmQn1ALVI9ZTg0VM44CdD4+2PYfLHEfmRqT0pM6T8DehPUHPmGZVhXdYFIoLydvJUkw3FnN6fZCiKfajVtXeBVnoYM7jKHfDWL+jC26MI010=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dy9UiG5c; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CUlNJ1Tm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy9UiG5c";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CUlNJ1Tm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780040125;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fw5MZZ8NppGMrBA3xwSIGpgijj5o5wJuC0KPcEJrOxg=;
	b=dy9UiG5cB4r8qZM9x+BvVOoc86lu92F2Q4ksyemNXqhAgQFH1F6p5jl2mCCSu8OCTgDPiA
	SVkRxtN6zg0Hmb3GAuKe9sO6opyG5gQTcssfbgVGwwwku6CDeB4b3523r1OqeWsQBJq1zS
	I+778AbyPBT/ATKEmiBNKPWYrtmxkZ8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-K09l0zCuPQKGn7d_p6lksw-1; Fri, 29 May 2026 03:35:23 -0400
X-MC-Unique: K09l0zCuPQKGn7d_p6lksw-1
X-Mimecast-MFC-AGG-ID: K09l0zCuPQKGn7d_p6lksw_1780040122
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4909c0f0ba2so3113365e9.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 May 2026 00:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780040122; x=1780644922; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fw5MZZ8NppGMrBA3xwSIGpgijj5o5wJuC0KPcEJrOxg=;
        b=CUlNJ1Tm5/BGSlZGCc58cf2EXl2WXXI50WXWCC02rh3G3O+pT/aNtX5o90KsuvVfE6
         BhZ6+qpUIILESCsugZ5hhV/wdZixBsRf+7JYveRTvoWYqmJh+Mh7DvgDnKoA+h9VtlAj
         TbIUcXhoE7/3WgeCKwA4c3d5x+yCPNmS0CJiva8E/9uNjLtjcP6RgvvowAsLdK89gUMp
         +Qdq8+08m0cwX1cAt5ttogG2ey47FY78hCF8tYrmy9uJdFmzqu9VK3M+/hzB4jiIvodP
         7Di+gL7VqCM0l0D3t/lgb40p0jjyYo7ZdGsS/trDY+a/hJfzKezJQQlC2S4FMdkK8dbW
         Ny9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780040122; x=1780644922;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fw5MZZ8NppGMrBA3xwSIGpgijj5o5wJuC0KPcEJrOxg=;
        b=DVSMBh7l0mmuQFAaLdUVrLYHT3zOL8R2MIqfStEBG/lrblGPVqoRnPY9FWcuxx1GBH
         jPvrMxH++HFaJDNAXgYEuKeQZ+uwJgS5Qpkv6joB9VF/J34AeYzDrcPTcTscurwofVjl
         nTmqbZjHQIJUtaQoadG9LH21ojaYOGomNYc3WjWSQPZpQj25mn9BqjuSTmRzOsTZt63s
         ENLCcEzp1xnA2lzkAwKE56V+o5a1gkDTaITfwhPo7ZUAWkpFvkw3UXJgr0hQ7KPTDcR9
         LJgv3jHJgTR8cfufUV9/P6RYaPk1eQZAHwn+mG//nsN+LkBNPTVFKSXwrmytkMz+W8o1
         WROg==
X-Forwarded-Encrypted: i=1; AFNElJ8Mh1Qqkbd8lAK+4ySlMmonl1bSUVoE+koh3YM4DzqLyOiSK6VAK8F+GuV2wR/AN8TxV++MEcF9O+CHvj5afJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyklPuo43Q2o7LeAlSMJHs8MOTAU1mxp496W2pF4YgUNWdrQoc
	Wm0tVCilXxEAMi6y3qgZFUNCwfYoTtVE2F11ahD3T/ZTGwlrFbP5ifW30womhcpr6BUsRaJDmh2
	guc5hMh+Tb22TxUA8PHxW7wicnbBU32L874ggyFru/YHVsXYgypz/SjH7Z5O5Jvs/1bd+rQ==
X-Gm-Gg: Acq92OHZ4KO6FFivGPZn34fDae0N907J6pNirPRWepI83k/0TJZKEbHmLrJ3K6PUO+o
	yzyUgWvgj06JJ5YMfSZd2keC1Unspzxdb2YU0mVqySXJEcNFIiULERUZuDA8ak/3yPgGuM0pmmx
	zEWjIQ1HmCV0yUrNHRXDUmuZOkgXjR7gN/J5rBLP5a0indMruCGnM7pqK0JJ0MCbUCkbHiSFYFy
	2/aIX77zqNSDZNfug6QUdQNUo/2YD8M2YVb9w5I1Gx9MRZiTidMVpjoXdSHo0/6ZnpL1N2f4v6I
	DKmdAxb+fXuypi4EU4fiDJwwiPBtQOJJH1FEBfEdzli0hX2X6EXmmifkztqdmPuQzIk/b2BqFTn
	/yjYkIp0nvp0/6xuiDalgPdFvnhzkwoNAWl/SJvMisljBWgwJsp8PRrMK3/PESqIBdPQ=
X-Received: by 2002:a05:600c:3504:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-4909c0b4ef9mr28617795e9.22.1780040121970;
        Fri, 29 May 2026 00:35:21 -0700 (PDT)
X-Received: by 2002:a05:600c:3504:b0:48a:5565:ec3d with SMTP id 5b1f17b1804b1-4909c0b4ef9mr28617235e9.22.1780040121386;
        Fri, 29 May 2026 00:35:21 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.150])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909d6a0e42sm20813525e9.8.2026.05.29.00.35.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 00:35:20 -0700 (PDT)
Message-ID: <de887211-1005-43cf-b1d3-ddf1a82c283e@redhat.com>
Date: Fri, 29 May 2026 09:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-05-28
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260528131839.462344-1-luiz.dentz@gmail.com>
 <46c6541e-9cd3-43f6-94d5-baac7b3fe7ad@redhat.com>
 <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CABBYNZJjCVRp-00vA29nZahxOWYkCE03TnX=3-QWR7jzwx4mww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/28/26 6:10 PM, Luiz Augusto von Dentz wrote:
> On Thu, May 28, 2026 at 11:52 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/28/26 3:18 PM, Luiz Augusto von Dentz wrote:
>>> The following changes since commit ab1513597c6cf17cd1ad2a21e3b045421b48e022:
>>>
>>>   Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs l2cap_conn_del() (2026-05-20 16:35:47 -0400)
>>>
>>> are available in the Git repository at:
>>>
>>>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-05-28
>>>
>>> for you to fetch changes up to cdf88b35e06f1b385f7f6228060ae541d44fbb72:
>>>
>>>   Bluetooth: hci_sync: Reset device counters in hci_dev_close_sync() (2026-05-28 08:52:21 -0400)
>>>
>>> ----------------------------------------------------------------
>>> bluetooth pull request for net:
>>>
>>>  - hci_core: Rework hci_dev_do_reset() to use hci_sync functions
>>>  - hci_conn: Fix memory leak in hci_le_big_terminate()
>>>  - hci_sync: Set HCI_CMD_DRAIN_WORKQUEUE during device close
>>>  - hci_sync: Reset device counters in hci_dev_close_sync()
>>>  - hci_sync: fix UAF in hci_le_create_cis_sync
>>>  - L2CAP: Fix possible crash on l2cap_ecred_conn_rsp
>>>  - L2CAP: fix chan ref leak in l2cap_chan_timeout() on !conn
>>>  - L2CAP: use chan timer to close channels in cleanup_listen()
>>>  - L2CAP: clear chan->ident on ECRED reconfiguration success
>>>  - ISO: fix UAF in iso_recv_frame
>>>  - ISO: serialize iso_sock_clear_timer with socket lock
>>>  - HIDP: fix missing length checks in hidp_input_report()
>>>  - 6lowpan: check skb_clone() return value in send_mcast_pkt()
>>>  - btusb: Allow firmware re-download when version matches
>>>  - hci_qca: Use 100 ms SSR delay for rampatch and NVM loading
>>
>> I'm sorry, it did not fit today's net PR; I started cooking it quite a
>> bit earlier than this one, and I looked back at the ML only after
>> completion.
> 
> Well I guess it will need to be merged for the next PR. That said, I
> wonder if I need to submit it one day earlier since there is a risk it
> doesn't get merged immediately, causing us to miss a week of the RC
> cycle. Maybe due to high influx of AI/Security patches we will need to
> submit it twice a week or something.

Indeed the AI generated load is impacting our workflow in many ways.
Among other things, our patch processing latency is roughly doubled
according to my complete wild guess. I agree posting the BT PR 1 day
earlier would be better.

Even multiple PRs per week makes sense to me, if the average size is
still significant. I'm not sure about others maintainers opinion, please
don't take my last statement as "a please go ahead with this" before
more acks.

Thanks,

Paolo

