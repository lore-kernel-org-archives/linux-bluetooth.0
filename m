Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBE53FD4;
	Wed, 23 Oct 2024 12:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729686982; cv=none; b=ewjpF/mHmLFfXzs2dwEDd5ALuU0d8CtrBU6UP8Uv9SEHuvaG2YreVsOW63e7YKJc0+YH/fEpB3yfyx/9rnpk0CiqHisADKrtjdDF+exZ3DRZj8Z0Zij+K/YrcGPvkmT4qDS8CxKMh6QHqPXhogrrADvf1cavEICImBX6ZdtpLq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729686982; c=relaxed/simple;
	bh=NvsJE6+70r058CqDZmm0zhoJg5vg9HC6I+sdV1QinMk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=e2H87cTiaK5QZdUE2/57EooAiHMZTxmUK04GVjiLAt/lZ8YrybzJaOV21cuNnETRWXgqpuEP5NMaOk1NSOT7t3ybIem0Fy/yln06eQRSm5q01iHDuIF+2i/jASh4DtBxKXJMggyM77UrRca6Go9FSqLoFjU0t5VR+NnJcbBiZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xXpMY4k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6RCBy6TO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xXpMY4k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6RCBy6TO"
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729686978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nQSjfJGOGf1mrKKvQ32s12pZQzwn91hTdN/0eRPA0Q=;
	b=0xXpMY4k8cRYFEX3kTypsLX3mAnvzVbNiXpPynffj/2zEaIaducig2wJEGso+5wQzKYqnV
	qE3WP9/ooMuIaoJFMOcrzE2+yHZidtLmbP0x8WVpCpTQgTPjtg7myxg9HUWo6c43HLqUbh
	ZK13Krr1WhfJGqawTc6IykWVIY1CLxm/2PFm7yw1GEb9rlcMlJ6YBNfIoSk3HwDW0dc589
	HuQov475yhfy8NulMtgHGBJ7tbn/krVKAl4CGU48etFw1Xhyzc7zL+2nyAYTqYy0Zkjlar
	mw76klzECFfyhtl6KrQ6QqsQYvcM43OEzbZ3FWA+Ye2rHeRP1S0BmErVcVvhIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729686978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+nQSjfJGOGf1mrKKvQ32s12pZQzwn91hTdN/0eRPA0Q=;
	b=6RCBy6TO/Hm5dZzzZBuNaFBs8yW8T/L3RBcebEVE0PFsd5Yz3e5fUN5O78Ew4TzrImcy5x
	7nAbGGV38Mq53ICw==
To: Easwar Hariharan <eahariha@linux.microsoft.com>, lkp@intel.com, Marcel
 Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Thomas Gleixner
 <tglx@linutronix.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Easwar
 Hariharan <eahariha@linux.microsoft.com>, open list
 <linux-kernel@vger.kernel.org>, "open list:BLUETOOTH SUBSYSTEM"
 <linux-bluetooth@vger.kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, Michael Kelley
 <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] jiffies: Define secs_to_jiffies()
In-Reply-To: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
References: <20241022185353.2080021-1-eahariha@linux.microsoft.com>
Date: Wed, 23 Oct 2024 14:36:17 +0200
Message-ID: <8734kngfni.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Easwar Hariharan <eahariha@linux.microsoft.com> writes:

> There are ~500 usages of msecs_to_jiffies() that either use a multiplier
> value of 1000 or equivalently MSEC_PER_SEC. Define secs_to_jiffies() to
> allow such code to be less clunky.

Can you please provide a proper cover letter for a series (also if it is
a series with only 2 patches)?

Regarding your commit message: secs_to_jiffies() is defined in hci_event
and cannot be reused by other callsites and this is why it's valuable to
move it into core code. Especially because there are ~500 users which do
the multiplier thing and there are also several users which use (secs *
HZ).

What do you think about converting the other users e.g. using
Coccinelle?

> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
> ---
>  include/linux/jiffies.h   | 2 ++
>  net/bluetooth/hci_event.c | 2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/jiffies.h b/include/linux/jiffies.h
> index 1220f0fbe5bf..50dba516fd2f 100644
> --- a/include/linux/jiffies.h
> +++ b/include/linux/jiffies.h
> @@ -526,6 +526,8 @@ static __always_inline unsigned long msecs_to_jiffies(const unsigned int m)
>  	}
>  }
>  
> +#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * MSEC_PER_SEC)
> +

Why not only doing

#define secs_to_jiffies(s) (s * HZ)

>  extern unsigned long __usecs_to_jiffies(const unsigned int u);
>  #if !(USEC_PER_SEC % HZ)
>  static inline unsigned long _usecs_to_jiffies(const unsigned int u)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 0bbad90ddd6f..7b35c58bbbeb 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -42,8 +42,6 @@
>  #define ZERO_KEY "\x00\x00\x00\x00\x00\x00\x00\x00" \
>  		 "\x00\x00\x00\x00\x00\x00\x00\x00"
>  
> -#define secs_to_jiffies(_secs) msecs_to_jiffies((_secs) * 1000)
> -
>  /* Handle HCI Event packets */
>  
>  static void *hci_ev_skb_pull(struct hci_dev *hdev, struct sk_buff *skb,

Thanks,

	Anna-Maria

