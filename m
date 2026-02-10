Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537573803C2
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 14:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770735053; cv=pass; b=JgL93fOCBDEUmDOB+GZvBa193hPqlhGo1TGHufAynfDZc/T29i7FMjNgrDsLwju1/2+YolAqEvkuXLw0HKSfQsA5yF25paK+fjKTTNfxwwKIm9JY4Wj9VTRGDD41iIdIf7I5kf+BeShhOkFL9a+nLF5u5JoeasgxSPbpLbpgJyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770735053; c=relaxed/simple;
	bh=ist/67f2F8v3+X6wppO7krjy5EITx3FjoUY5E9ITn/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q3WV3wfWqMkwtnI13U6STMfcmjcP+d8Yhw8ciycfmxnfM5+dIJFhBY+R3f1ZnR6K/mo9ZL4aaDJJlnInzx2HfW8Rr3d7asyg4pN90iukvo8N5BT/5AlbLI0LMzIHOWQvisqR9tqAGXwuKAVfw1+22atoMB94HKe7ZX9zfzjNL6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQBZ6yR0; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQBZ6yR0"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8947e6ffd30so46542116d6.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Feb 2026 06:50:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770735051; cv=none;
        d=google.com; s=arc-20240605;
        b=OGKDnAzVbqwihchqx+FZSHO6FI9HD+jx2e5jfJpw0DHW0DWo2861+XjwPfSPUa+/Dx
         vDUGRwi0y0flxz7HP6zGJdAJ/32wkI8zwWRVxeZLAyso+tIZfFB8rYasbQElJJWpxs6t
         9ud1cvCOasN6OM+My9ztWeIlrCPfMaHTbYiGL2QgdIwNbd/TVWp+/EUfYVMWCVrxxk+T
         m40k5tLbD62s/FCn5S8vVLiE8aZfUjClQbAOSd679W5M/KT1Qv5QH1rP5JQ0SEogGQCP
         F9NNg3z8jn0CpxNn/CpyOTgBNVMTM7Ho3mBRAI7Lz+aPaG8Gu6g0j9RQwl1xIVfIwO+z
         1BCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ist/67f2F8v3+X6wppO7krjy5EITx3FjoUY5E9ITn/w=;
        fh=yVcsFQ3kaaWZkm8DzYzKxKHrEm/DIS8TJDAKTEleFDM=;
        b=eD+CtWuUPinthHyApYJsVErR2qzV6rq43LVgBQZvGMwjU9qv96WX4ieCmGjSyeCiem
         4t2JDRJnJS/4MDM70/+uqBaTW/l13NqpyoiYreyBFZrdHNJnYuSwLg43LUkIksfYyvqr
         Rk3LvjCLBsrVAmDoHcSQKmh2Cq71jLH6q2vfOWL47vraCwWcJFL8IyqkMgLAX5ODf87N
         Qc5oA2FfeeoQutmXeMyKnHumAXH8M7q7hwrXfyx0l7qWi+TAlRhf9vKZyrXMJFnp3IIY
         293evm/4W8fbQfSHM1WgQKXCLFRfOBx2iLolQmSLxcf0yxsP4zfzLs1NGTkc+3AOszCg
         +CXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770735051; x=1771339851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ist/67f2F8v3+X6wppO7krjy5EITx3FjoUY5E9ITn/w=;
        b=ZQBZ6yR0g6f9UR6osL8CX8oOeKAxfTzTrY9ie1JdRtto8ckwfx+neiz5poJIAdz3Xl
         3+yn94s4gfnfKyiMd8ZfcrGhdgao52V1k2GSpjIfhblOgtTa4foG+BfW6aLqkFpzLS1q
         OjngBcRDz0Xg2Q9gyY0aDbObB9X3RViIOkE4IdMT3NRplUCcZ9ax09oQzMhHHwyQUr1j
         ENJdM+CLygF/4mNgS/HCzWuNvjA4jYlvs9lVsP7U4t81gO9S/MRaip4sW+WDXw3B7Vyj
         EbqTaqIlIPhJ7joM55CgABwBKIRcjzra0JP57cl0/SIyWs6VMaIt2JcOH5S1uNlemN7Z
         ZqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770735051; x=1771339851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ist/67f2F8v3+X6wppO7krjy5EITx3FjoUY5E9ITn/w=;
        b=NvBUV6pxvb2je0dzSMBG8altVrI/vA1rmb3MpkXh0x1Jw1n93Mi/N2j3ZvNC+BEoIK
         vzfPTMG7Xofmkcur8jiUwiJvPabXfqfcS2eF9BUnD9KPZUkDE5SsYf8G2yxa7u6O3cXG
         XykboomHtcfgk+EVPt+hzYdomwCJ3YMwDd4K9IlKo3S/H4D8wruEMN6wXxlmoG5GhK78
         JW/BhdBXmDHRxQCQR5+qdfLygqDYwsOFQW/HOfpE5GewwVMBrvi9AKahR2ckdIZlAGFr
         bFV66h6iTQSmIf+iydybQ7Q/sqT9upWIG6X/I2TYsUIH1qiiN7LVt3Wd85CpMmv6PCdW
         8szQ==
X-Gm-Message-State: AOJu0YyEmk2duD15eSfZoMV/AkgbBAFzv+vw6Rl8ugU94WprzvkiQE8s
	a2icTikRtZ1a6LLYqOg3idSqoKjDvWbUx617MwaXgRAY0nQo34258ME11bP//uFa5moVBbPzNqm
	8yNBeFXE1BoIBgIFkhjYAcwnjpXqF42S5vrNKGWT7TQ==
X-Gm-Gg: AZuq6aKyYRL3AuoafqdTZC8hdn02xABXqTPidr8cqwOZ0RwSGc1+NBJtdbmaTUlZhs7
	/9BtAFuapvxkgG3oxUFdC08CgnxbX+HF0fErRzR1zfw28UtbUhx4B+bt0obG8xiw9/yZ6iMWcd9
	UY/YgkGObbNgUfe5GUJKyJP6v73Lifjcxljyi5UofAe61l7tkIfZebv28BqrIjdbkqhErfmFQOs
	RUOEMEcc20qINyEmQLNQxN2EJWkBJnxt6quSaQVElVRpHST9RQ7B4o1xY0wyFwntL7zbd0VseL9
	7wnMl6abgE19XfkLxf59rgC6/5UlKCbUiyQ4tQ==
X-Received: by 2002:a05:6214:1c09:b0:896:f588:b2e1 with SMTP id
 6a1803df08f44-896f588b6c6mr125547686d6.61.1770735051230; Tue, 10 Feb 2026
 06:50:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKZCeSVJQAsYVSDBHOmUyBMbQqBA1D7ZP4KK-azWUjb+p-vpJg@mail.gmail.com>
 <20260210100901.2769-1-hdanton@sina.com>
In-Reply-To: <20260210100901.2769-1-hdanton@sina.com>
From: kawada <youjingxiaogao2@gmail.com>
Date: Tue, 10 Feb 2026 23:50:14 +0900
X-Gm-Features: AZwV_QjmvsHK7BEdHTRaSpfBz1k_-OY6pPPGIwMTOtdy2VNYYNx6KdQi6k9ximw
Message-ID: <CAKZCeSWxJxuRfNntgm16SrY0BX9TNG2JZAUR93h+_TXwKjUpEg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix use-after-free in hci_conn_drop
To: Hillf Danton <hdanton@sina.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	johan.hedberg@gmail.com, linux-kernel@vger.kernel.org, 
	syzbot+3609b9b48e68e1fe47fd@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Apologies for the top-posting.

> Better not before spotting the reason why conn->refcnt
> failed to make the entry->destroy callback safe.

hci_conn_hold() increments conn->refcnt, but the actual
freeing of conn is done by put_device() called from
hci_conn_del(). hci_conn_del() does not check conn->refcnt
at all, so the hold/drop refcount cannot prevent the UAF
in entry->destroy callbacks.
