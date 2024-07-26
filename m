Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142922582;
	Fri, 26 Jul 2024 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721984426; cv=none; b=u6+euyaGsWz7K8U+KiybbN7j8y+xmJjwaMo6wXu7pFil1Zo9xpzTMpe0yW5ARMfNBH6kIkEvoaTls6KOSK81D9gJAbZM36ezSQoNIEjrWK/TyETI7sx/SeG1xdt/VPY1Tx6ZgtoMzVoLr0oySmEswf5CAJ95uqcG+9I+0UKZMz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721984426; c=relaxed/simple;
	bh=mTWmn9F6T8f1TDrrU9JJ/nN7UEzvYIt3exK8cibuYQY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=YyXQVS2osV/k+s3ei9mATdhN4YFGOR9Fx/kqH9eP/uySutncOH7934IM30srEyuoKtC1L3K8lOm2Fp8NSZWjzA3pWrJ+S5x5/Yhojz6evPoY3jqutecLAu+KlhVAxdJkzms1Q8VOXVezFs4p2VNv6k5ssEMVLNO42ILvnzMtCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N/ptK/fF; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/ptK/fF"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4280812ca01so10215765e9.1;
        Fri, 26 Jul 2024 02:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721984423; x=1722589223; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V7ExwDaqxbplNlKvaO4A3WJAVxQSbAGokTEdqWh6okk=;
        b=N/ptK/fFEuMJe2pSC2usAoUsgAYN7iFJORGvIBJ/2YYiwoL5q/D7AmWisUQcQmiUSx
         DBYkQ3DoAxb1HC5JyApzPiLX8UdSqFEr3t6EINd+N89v6QMu40iEjjtposJfjbQO7gxQ
         p3MN1EsAJKQMM3etijTMgcrLLWZmjSi3d3Tj/PkzXD2wqV7BVmRBcBqYq5oing1sRu63
         MTbQ5ONvfwzh4eA3qD5TKDoOFrZcjGifkAqpZkxliw3lXXHR2Ae0eG9q4UheobwBBYqc
         i7XUjkfKlLNe5sJFj59zW//9vBnNpWlmLbONy+TUmoqZXl/Esu1Q/F+GSdayU89AKoK+
         SndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721984423; x=1722589223;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7ExwDaqxbplNlKvaO4A3WJAVxQSbAGokTEdqWh6okk=;
        b=v18M3Wyek1FEpDPHcMpt1UGM/pXfHwZz3XaEgFYBY1UDIeo0VkJfYTtj2InNeXC8IF
         Vf6sTW/mRDWz+P9cFtDma+NJC8FtvIiVRdH9o1pcLMmo0ROBcDKYLi2HbwaebTIjBqfS
         M9sA1JB/GsNAreVkac3tvc9ZUWWj+yVKD90eLhFR3pTUcRlqDe3Rq/p4ePJcvNR8CAmN
         7P1AgJWLwTv2XVxySCgiTLKalyVu/G6374UbvjksYkk5ueo0rLHDh0OR+dzo8bu75FRv
         MBlE0sSQEoI5QUBsof/ISqbtgPSpEfFm7z1akFxvKrNTgKd4PduQyNrfmZblDfPRZAKf
         OCEg==
X-Forwarded-Encrypted: i=1; AJvYcCUKYslN8T+M8zuaauOaWZ41eZmpjFyk8V9bRvFYFeO83wDXkXErJuo8e0JQh82b2+uRpX7KUI7wgoIBfS2ZYdK48JXrUP0HQZR5hpdThtBXkaFSVrtOgr6eCK284hI4SsaY3T8aTGMvkVy95GG6ez7XSmcpf0H2g6R6waf3RBkBZn9R1Id5xNog
X-Gm-Message-State: AOJu0Yxi8urc9pQ3j6YxWe9S26m0kLgKo7akvNn0yTZ45y+OC8iRp7Jo
	nHIqzsNJ4au8otnQeI+S/yQn8iH0gQcVamglsrJgOpkApSM4mq/S
X-Google-Smtp-Source: AGHT+IHZoP+/wYwA7WVbZ0aLHIqhcws5Q4w17Lw8VDEzTu3mvC7Q0hy7Xe1o6stzbmJ3Lbr71fKgkA==
X-Received: by 2002:a05:600c:4511:b0:426:654e:16da with SMTP id 5b1f17b1804b1-428053c1344mr34971195e9.0.1721984422989;
        Fri, 26 Jul 2024 02:00:22 -0700 (PDT)
Received: from [85.64.140.6] (85.64.140.6.dynamic.barak-online.net. [85.64.140.6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427f93e6871sm112695845e9.30.2024.07.26.02.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 02:00:22 -0700 (PDT)
Message-ID: <f30d186c-2924-e708-cc08-e0b9a7f70ca4@gmail.com>
Date: Fri, 26 Jul 2024 12:00:01 +0300
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From: Eli Billauer <eli.billauer@gmail.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in touch_wq_lockdep_map
To: syzbot <syzbot+91dbdfecdd3287734d8e@syzkaller.appspotmail.com>,
 arnd@arndb.de, gregkh@linuxfoundation.org, hdanton@sina.com,
 johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
References: <0000000000000ab25a061e1dfe9f@google.com>
Content-Language: en-US
In-Reply-To: <0000000000000ab25a061e1dfe9f@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26/07/2024 6:20, syzbot wrote:
> WARNING: possible recursive locking detected
> 6.10.0-syzkaller-g933069701c1b #0 Not tainted
> --------------------------------------------
> kworker/1:1H/1247 is trying to acquire lock:
> ffff888121075948 ((wq_completion)xillyusb){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x6e/0x120 kernel/workqueue.c:3876
> 
> but task is already holding lock:
> ffff888121075948 ((wq_completion)xillyusb){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206

This is caused by xillyusb.c: destroy_workqueue() is (potentially) 
called from within a work item function, wakeup_all(). So the work item 
may attempt to destroy the work queue it sits on.

This bug has sneaked through the hardware tests as well as XillyUSB's 
users for several years, as its scenario is extremely unlikely in real 
life. It's nevertheless a bug to be fixed -- I'll submit a patch for this.

Thanks,
   Eli
