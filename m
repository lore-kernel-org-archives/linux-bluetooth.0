Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF753B05A4
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791883529; cv=none; b=GT2VRPY7wmczKws1d6EMhICkpDdQ9kZEoQdYqX3ldyFTY4mMfpFJOGEdib7gsgCnTkONRUwFDb1PnTO75tb33wRpM3/lQXTlF7W50Bgyhe2eXr3maFphCCLYTqDgahAUYb+c1D53wXSk3/BEU4hYTotJW8SmG00YgqZaJe+C5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791883529; c=relaxed/simple;
	bh=E+38fAMqkeo2SkoQ8n7hSTpLs3Ek1Bw2C++QIWUrUAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKr7e+Se/4kevxOM0BKClB0zjcpyZsWNwZzv66qj7MbmOlgu4usD8nP/EV5P/75TQnndxDz7PFVDBKcup3WlL/NuHwEtY157lLMIUWC4UQZ9dxQ8Bpmg+P63etM0xmcNxi5dj6FaroR+Z9E4RaSPyYGMk1Sin+8ryOgp+/G4fmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U2/yiLGL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MshJrHtX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U2/yiLGL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MshJrHtX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791883526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xtho2iqqZNwqkJufhHeVK/o5V+FrSAKuRVkK+5Y2SlQ=;
	b=U2/yiLGLTbzzw3qoF+DOJl+b6KKgNcS9Mi9Onpy1iuAM24d1GoEa1zw3nx7opw16kwOiAX
	7/fRv+T6sByF838MkLz7uhKt565gpsaURgVnXT4XIDnWmlb07VG9N4EzoGUQsvWGJ+r/sC
	jdr+Wc1VGjpzWcLoCfXwdVoFK0OnlF4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-U9fMGlBjNQOTD1eQt9ImSQ-1; Tue, 13 Oct 2026 09:25:25 +0000
X-MC-Unique: U9fMGlBjNQOTD1eQt9ImSQ-1
X-Mimecast-MFC-AGG-ID: U9fMGlBjNQOTD1eQt9ImSQ_1791883524
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a01c621dc2so21326645e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 02:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791883524; x=1792488324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtho2iqqZNwqkJufhHeVK/o5V+FrSAKuRVkK+5Y2SlQ=;
        b=MshJrHtXqoX9PgBMpa0wBU+kKOQAcEz0HzoHHcOsCDm0KHBBP6TUBbf31DyJt6Wkf8
         fn0/q3HBqz2JAPjf5CqyQIa69N39CejwwQk4PE7yPfBSudt1V7gQV3DnuFITBLwxt3ls
         pZSiCvl/v8AVhc9jtqAJqYvvUg4gxHrCHCRGoKeJcw3smhejBJXaG5QqnzWaHRkvsmn1
         JpcUEPpqPaS7HMDe01nBd5oIkMG8BVLmEQpg0yvvr/81JbCVYE+vZCQIgQxJ+RZC8YS6
         RPURQ2AdqAXJV83En2YeAPBzwyS2NNoSbL6T8R2z1JDRjv6B1ck8nZ0Vio0r+ovQBa0r
         CMMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791883524; x=1792488324;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xtho2iqqZNwqkJufhHeVK/o5V+FrSAKuRVkK+5Y2SlQ=;
        b=tgoO0OLtRnZmzJBflxkgFhuy4E3Ds5L5UdMqqGzvp9S+LMmrnC1inpL5sqe03isckZ
         xrWe56BC1XXq78wPUhu1v2hAMQpBURMd1tKm4CjB3KY8gFdxyx8tV4+isOb+jQWZRpsM
         flWIMqDmlnRiP16Q0kGS06ZwiWitXmHJwuAX0E2sQzmcO1jWpkheX6XeGkaMUHTH04J6
         GH0VbF+dS7xshHKEc3myFb3hqbzEQa2fyJIfgaGhXfMXhDhf3zNIvOR2a+B/7mxIZtvv
         bru7u0qIsWkcg7ZA47czYlVpSzNxUSn7vH/+4tGzP5aBMhgYnCRnSMBa7imErbvndISD
         zq5Q==
X-Gm-Message-State: AFq9FYJQYcgkmwrZMPmHh8I5em3KcbP63gbFbBnHgmvLRN10qD7pKIvU
	1sSqP3bS8wl5zEWROLCp+/kLkfGBysor5aIgea6BmTpyugqYbzCRE1F5LPCYjrI3FwfutPzT+Id
	Fa0WkZqFwIc4CkKO2JFjjuATjbFYf+A0/U7nGlakrbjUJq5ltdJ9/8FxuZ79tmb/uqvQB+A==
X-Gm-Gg: AYBFou1raqSokJvtELM5Han9cI5/Hpm7jIZoqqsiLsvvzVf8Ke7PHBE2q/Apgqhxo+5
	n4hA5f/vm6xjUVoE0Jky8KnzjLr6WpGeMz4CQDS6A6PuP7mJlLC+Jvo2tPSoBvcVfqD9d+6JQpQ
	SY5SaMgOg5GKVfVMz7p4f7T9oUi3rsw8VNsY67cDvfSOxEcukK/MOB3SjdMkHAcZZN8ZEWxPvcG
	rJ7JNxl8tIT4PVxdPSJshoglxVCpgahtnOdK9EG7eAwnYuLqQOQjwf/mxU/vQ0DzkZP/mLhZ4eB
	xmpWWnhPyuU+jvOV8ses0WhlVRLybzFslM4EKRsKXL864rcRkdM1LdXs6YB89YctvfyszsBKOsR
	T2uhxbwzsxDthDcddtaJKjcydKDYFj6gYJEa5fzKZJp0ke2khxx8ycDLUIwMXX8nAECxfKa2V6A
	==
X-Received: by 2002:a05:600c:6990:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4a18e49c43bmr234651025e9.6.1791883523965;
        Tue, 13 Oct 2026 02:25:23 -0700 (PDT)
X-Received: by 2002:a05:600c:6990:b0:4a1:80d8:aed5 with SMTP id 5b1f17b1804b1-4a18e49c43bmr234650575e9.6.1791883523538;
        Tue, 13 Oct 2026 02:25:23 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a195002123sm359024505e9.1.2026.10.13.02.25.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2026 02:25:23 -0700 (PDT)
Message-ID: <48d2ed02-c5b6-428f-b290-bb6bd92fe299@redhat.com>
Date: Tue, 13 Oct 2026 11:25:21 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] bluetooth 2026-10-12
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org
References: <20261012210758.275556-1-luiz.dentz@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261012210758.275556-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/12/26 23:07, Luiz Augusto von Dentz wrote:
> The following changes since commit e32d80293a0e1a160d5e5101daa8c82148c07510:
> 
>    Bluetooth: ISO: Serialize concurrent connect calls (2026-10-05 13:10:47 -0400)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2026-10-12
> 
> for you to fetch changes up to 23ad91f6a21a830b67f5eee790caa0053bd6537d:
> 
>    Bluetooth: MSFT: Serialize handle map cleanup with event processing (2026-10-12 16:27:16 -0400)
> 
> ----------------------------------------------------------------
> bluetooth pull request for net:
> 
> Core:
> 
>   - hci_core: Keep RCU protection through LTK filtering
>   - hci_sync: Serialize devcoredump reset during device open
>   - hci_sync: Protect IRK identity reads with RCU
>   - hci_sync: fix mesh adv timeout units
>   - hci_debugfs: Pin module for debugfs file operations
>   - L2CAP: Hold the listener while notifying child teardown
>   - ISO: Hold the listener during disconnect notification
>   - MGMT: Reject quality report requests during unregister
>   - MGMT: Fix advertising instances with Global Advertising
>   - MGMT: Fix pending state of instances added without HCI traffic
>   - MGMT: Fix leaking instance on Add Extended Advertising Parameters
>   - MGMT: Allow connection rate request as peripheral
>   - selftest: Pin module for selftest debugfs file operations
>   - 6lowpan: Pin module for 6lowpan_control debugfs file
>   - 6LoWPAN: Use RCU-safe device list removal
>   - 6lowpan: Drain RCU readers on registration failure
>   - msft: Lock failed probe cleanup against feature readers
>   - MSFT: Serialize handle map cleanup with event processing
>   - Add missing newline to bt_dev_{err,warn}_ratelimited()
>   - Fix tracking of instances sharing handle 0x00
> 
> Drivers:
> 
>   - btintel: Zero version data before parsing TLVs
>   - btmtk: fix skb double free on ISO padding failure
>   - hci_vhci: Pin module for debugfs file operations

Ouch, that quite a significant PR! Linus is pushing towards
smaller RCs: he is not going to be happy. I must admit I
would be slightly concerned by the size this late in the
cycle even without additional pressure.

Do you think anything of the above could be moved to next?
Things broken since the beginning and/or required root access
could be good candidates.

Thanks!

Paolo

