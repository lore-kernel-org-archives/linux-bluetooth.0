Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795706046;
	b=R0lFDUmuOXk8Oz8dMUVuKtozPlhiLQRcYiGD2ElAa7weVzqolBDkBxnMfEyRrLy24nKx
	 fPdNKhBdtsj9dHVFibk111MqCiRsfeXclGcFR9LO11hXNbrVi4sFxDh67Tn/CiXQhX6wD
	 uG9ptw7WcyftTAUYmauEEgV9QDYPe4ot5S1gqNOUeWblyFn7Fzka0tNp4XFsRUfixdAgm
	 2rQEA+fw2cSK9H6z5y6bkVsZfrnfi0T+WUCNenRWp3GeDGwC1QuHA9BEp+/Cn3kUSh18g
	 LqMCZZEnGVCE+58OIcnM1QkJ1OIT/6cKu9Rn10FQvNEHdhxPLEcR9A5OzGLpGuULM+Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706046;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
	b=0vUdDoTTX/wGWTK1oezs3056+6kaFQO3kS6jFe8/27ocBCjLlnEqHJ2BIG8owE+D4W5Z
	 amn7aJTEp/66XvY0g/BCXyyymo0JXzCIAG4mL8aoPMbUfYbxvMCywdSJ3Hzo+rKn+MB9J
	 dDhddG7GqQqPOODWvfLCu/76L8dpts2S7hhXvVnLuE29nAvLX8LHoFwIRMiT/y17TinHJ
	 J2KV+o7tN9+yqIH4bxc8LtpN+Ds/sefguwBE/djGfKvXVV/yuDEuNPvKJGppQwjLhbxjL
	 RDkrmDyBuDFohiQxNNAwuF97vEnzYXX+f0yAYrISjyEV8k1nTlWVhYYo5g7EkVSo5mQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Q2wYqoOf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A681E606A31E
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 15:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A681E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=Q2wYqoOf
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-67c24619b19so5960700d50.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Nov 2026 07:14:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795706045; cv=none;
        d=google.com; s=arc-20260327;
        b=D6Fv36IOxxCTXXn55xRXL0y3MZXzA6ZlVr+Y6Q2whTaYnCJgzDefdEj5hV3mlxPS45
         iqOj6pFVvL/lefDgabWMEaEGdm2FiBh8Evm8JwfRf3FixHMRgrt5xgEs2cpmVKOwhl0J
         VD9EvdMJYr1F6FFZTx213dmrSjkQMugCKLVwPlT3fnzS7qqKsBUwq8MZ3yu5Sv8Xe1I/
         Du2c9/4+G3CzAHFOvpVNX7E7SxUfLQrTNwwqgXh/sw0d1Y0QOx45Wb1178ebgpeRiQyv
         yg8nHOnRBZLVyDBXql0Lz5nVEXngqY840TQyvj8sJ8fhkocr2ZYR9vdztpfQz15N/xEy
         e7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
        fh=q7LUEz9PxpLgJcUA3pHOgqxP2J4uF6nlZ9nwIUq6E5g=;
        b=E7yKG6COyI8GEWfeBMoq/0a3IGhalRQIFvHASHP1kCAXcwPgdoAc1dL+EVmEPrlm1p
         3BcpcUeHIxsx4eo3ruutROgSxBuSmqTyB8L6fqUIvb5kmig/Y7F2ziSwQFjcCxeksPQZ
         RaFTuLO7sKbRjgiD/2qwZ9RwNKHVSwPU+JKrvHaffivlMjcBvpWjb8nXvYE5zqLTSpC2
         xw5igqU6j55q4lRFdf70+FAVHi/HgmbuuJ0xU1AE3+KCwcmStkABBko61kyCFnM4Dxxi
         h8BTSgoKGJ0vmlcefuX8BFuBX6TpaRdA00M+WoLfN4xsy6GTL2R1lFUHRbHAGK1ZdeuY
         h/+w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795706045; x=1796310845; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
        b=Q2wYqoOfAzFWcbZP2J03E9GBIo/E6xrBSXIv4+6xYv0m7fcajUrJhMlqHpmXmzUa9s
         C6gbBpV0BRxv0xJ6TyImw+JwU73hGMDeHunKLAfzk2yasf3oGGhYKZelkLsn3NbHMB3m
         +ki8zXoJgf8TK5DEMKiLBm1WAjdBGEaDrMdr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795706045; x=1796310845;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=eFW9nR5FZygzb44kff9BBbQhCAydCKU+plkkUp60yKQ=;
        b=xcLCwc4ZrwUK3wpbnsYX9TFd5BM9rZfhLQDnulPDD/Fc1HEFfr9z5Bxx0O8FT1AHTV
         vTxdRVmDznDJ2RN5WbBf7/qaUX6IA/hpGSty/rOrPL4FfW+tL1Nlr7tS7E/sQZshekiX
         Yb7vkM6INMhfmfrv4TtyKhJ3lKb0+QoXS5ZLkRFTZnoOVSl13Oo9KGahiRvAk3C18Lkl
         DwmmJOkyGJLqs9Z0M+jQb9ZnoagZksZwrFq4Fj99qI5I6QU7ZTFAhJV7HYYWQW4t21vs
         GqUnAKcE2bqpHn/3Zx2PKC/ftEDinIbxC4r/LQ9NiSQ2CW2gCOnJ+uNuV6W3gP0QrHqd
         RTQw==
X-Forwarded-Encrypted: i=1; AL+hErHAXnGv+q2SCb0k7NdqJujN4n7UiB/qRqrRZnRlqIFuRgoli+51LiMgcPHwXHhrETw65lGTup27snbPbq5T34E=@vger.kernel.org
X-Gm-Message-State: APuU4Z+HA4FHLrlDU+FVQkxZJv/RFSSGagBSF4h1yv8eYdRlL7TbhLm2
	XgD1L3O9RirjtkM12PgJzu9F0np4swTCRjA2L8frrbjiIJ1I5lDixUCWuatyIj8bF6r6Q9AM6Z0
	ht3Jo1/12Xt/B1l5h1GLSFNiOlZ2rJddLavMfpS0nCpnVw7QmLSHMXBE=
X-Gm-Gg: AZFdTZeYrx+MxtFstlNBdc2osIO6Gtd9zkK2rCJNVh/N/v/nhOi4NPZaarj/Y2M1f14
	EBhkdWZEN+z9fw3/97XfqwNdIAr2UXEL5LM9F7idI83Vgf+RYrucNC7noJx4PJu89GT7upmgM1O
	0Fo7MukZx5mZDG228wB1aZ3L+K5E/9oZ6odWrrFbUUrVMdXgs8WGlAz3Y8iaEdKf4mEG5g5Tw57
	iyDZ/WUZlogA+rtQiA9QyZ7FQWllNA14SZpfY/0LF7f/49KJI6bOw0SgnkJUJtlYeWz8pcPQK4x
	6XgchxDPzg19aygQKWCXnXD099G5cte9a5BMXpEM4VZkXRpfNNTsQ2X+9RVMcy5Z4lQeTIsmRaM
	mg83b/BaycRJ+bh4aBwUM5ZbDGnwsNy0L1GCtZF6Y2bzcEGAhHW8ErDLqGh0zhAMxRSUeHRLSlC
	o68rIMfguSO7EhzEqp3HFtOvy/SCdwAJR4G/Sv7ZNZNgYV06I1xfP7xWDxthMLrO4JHWOjG2qh1
	PY033wC6p/NUHlCtzMcewK1lLj52kKlEzxD
X-Received: by 2002:a05:690e:438d:b0:67a:693a:b1c1 with SMTP id
 956f58d0204a3-67df450894emr5317515d50.107.1795706044640; Thu, 26 Nov 2026
 07:14:04 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 26 Nov 2026 09:14:04 -0600
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAFaZ9epjtBjMgjWapQR6QAzUYK4Ytq1m+VvwFv1Wu9kYauW0Zg@mail.gmail.com>
References: <CAFaZ9epjtBjMgjWapQR6QAzUYK4Ytq1m+VvwFv1Wu9kYauW0Zg@mail.gmail.com>
From: Dickson Wu <dickson.wu@certik.com>
Date: Thu, 26 Nov 2026 09:14:04 -0600
X-Gm-Features: Aa3M54peyYs6lEDi797Y2lCFVLy5gaYAuU8bITlzCgTwK1T10kqaMjoy_53KYjs
Message-ID: <CAFaZ9epcBDcZ3L72Z5KbouBiw9nMEiii8o46d8Rpxh9R-MwtXQ@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
 write_work is canceled
To: stable@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, Nov 26, 2026 at 02:44:59 AM +0000, Dickson Wu wrote:
> [PATCH 6.1.y] Bluetooth: hci_uart: clear HCI_UART_SENDING when
> write_work is canceled

Please disregard this one, sorry for the noise. My mail client damaged
the whitespace, so it doesn't apply. I'll send a v2 through b4 once
the serdev follow-up it should carry is in mainline.

Best,
Dickson

On Wed, 25 Nov 2026 18:44:59 -0800, Dickson Wu <dickson.wu@certik.com> wrote:
> From: Pauli Virtanen <pav@iki.fi>
>
> commit 1b0d946d6f08bd39211385bc703a440911b41e46 upstream.
>
> HCI_UART_SENDING bit in tx_state means write_work is pending and blocks
> queueing it again. Currently this bit is not cleared when canceling the
> work in hci_uart_close(), which blocks future writes when device is
> reopened later if write_work was pending.
>
> Fix by clearing HCI_UART_SENDING when canceling the work.
>
> Also make clearing of tx_skb safe by using disable_work_sync +
> enable_work instead of just cancel_work_sync. hci_uart_flush() purges
> the proto tx queue so we can cancel the pending write_work there,
> instead of doing it just in hci_uart_close(). Re-enable and possibly
> requeue the work after queue flush.
>
> Fixes: c1bb9336ae6b ("Bluetooth: hci_uart: fix UAFs and race conditions in close and init paths")
> Link: https://lore.kernel.org/linux-bluetooth/07e0a28650773abec711ee492fdb1bf5d21a6c98.camel@iki.fi/
> Cc: stable@vger.kernel.org
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> [ adapted to 6.1: no disable_work_sync()/enable_work(), use tx_lock and HCI_UART_FLUSHING around cancel_work_sync() ]
> Signed-off-by: Dickson Wu <dickson.wu@certik.com>
> ---
> 6.12.y and 6.18.y already have this. 6.1 has no disable_work_sync() or
> enable_work(), so instead of disabling write_work during the flush this
> adds a tx_lock and an HCI_UART_FLUSHING bit. hci_uart_tx_wakeup() won't
> queue write_work while a flush is running, the flush cancels and waits
> for any running work, holds HCI_UART_SENDING while it frees tx_skb, then
> clears both bits and replays a wakeup that came in meanwhile. That's the
> sequence upstream gets from disable_work_sync() and enable_work().
>
> The serdev follow-up, ee43bade37c4 ("Bluetooth: hci_serdev: serialize
> flush with transmit work"), isn't in 6.12.y or 6.18.y yet, so it's not
> included here.
>
> Tested on v6.1.193:
> - x86_64 allmodconfig W=1 build of drivers/bluetooth/, base vs patched,
>   no new warnings
> - x86_64 defconfig with BT_HCIUART, BT_HCIUART_SERDEV and BT_HCIUART_H4
>   built in, boots under QEMU/KVM
> - I don't have UART Bluetooth hardware, so the close/flush race itself
>   is untested here. No existing selftest reaches it.
>
> Since the locking here differs from upstream, a look from the Bluetooth
> folks would be very welcome.
>
> The backport and the test runs were prepared with AI coding tools
> (OpenAI Codex agents, with review by Claude). I went over the result
> before signing off.
>
>  drivers/bluetooth/hci_ldisc.c  | 37 ++++++++++++++++++++++++----------
>  drivers/bluetooth/hci_serdev.c |  1 +
>  drivers/bluetooth/hci_uart.h   |  4 ++++
>  3 files changed, 31 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index 0116dbaf7431..1378ae614ca4 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -116,6 +116,8 @@ static inline struct sk_buff *hci_uart_dequeue(struct hci_uart *hu)
>
>  int hci_uart_tx_wakeup(struct hci_uart *hu)
>  {
> +	unsigned long flags;
> +
>  	/* This may be called in an IRQ context, so we can't sleep. Therefore
>  	 * we try to acquire the lock only, and if that fails we assume the
>  	 * tty is being closed because that is the only time the write lock is
> @@ -129,13 +131,14 @@ int hci_uart_tx_wakeup(struct hci_uart *hu)
>  	    !test_bit(HCI_UART_PROTO_INIT, &hu->flags))
>  		goto no_schedule;
>
> +	spin_lock_irqsave(&hu->tx_lock, flags);
>  	set_bit(HCI_UART_TX_WAKEUP, &hu->tx_state);
> -	if (test_and_set_bit(HCI_UART_SENDING, &hu->tx_state))
> -		goto no_schedule;
> -
> -	BT_DBG("");
> -
> -	schedule_work(&hu->write_work);
> +	if (!test_bit(HCI_UART_FLUSHING, &hu->tx_state) &&
> +	    !test_and_set_bit(HCI_UART_SENDING, &hu->tx_state)) {
> +		BT_DBG("");
> +		schedule_work(&hu->write_work);
> +	}
> +	spin_unlock_irqrestore(&hu->tx_lock, flags);
>
>  no_schedule:
>  	percpu_up_read(&hu->proto_lock);
> @@ -176,7 +179,8 @@ static void hci_uart_write_work(struct work_struct *work)
>  	}
>
>  	clear_bit(HCI_UART_SENDING, &hu->tx_state);
> -	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
> +	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state) &&
> +	    !test_bit(HCI_UART_FLUSHING, &hu->tx_state))
>  		goto restart;
>
>  	wake_up_bit(&hu->tx_state, HCI_UART_SENDING);
> @@ -236,9 +240,16 @@ static int hci_uart_flush(struct hci_dev *hdev)
>  {
>  	struct hci_uart *hu  = hci_get_drvdata(hdev);
>  	struct tty_struct *tty = hu->tty;
> +	unsigned long flags;
>
>  	BT_DBG("hdev %p tty %p", hdev, tty);
>
> +	spin_lock_irqsave(&hu->tx_lock, flags);
> +	set_bit(HCI_UART_FLUSHING, &hu->tx_state);
> +	spin_unlock_irqrestore(&hu->tx_lock, flags);
> +	cancel_work_sync(&hu->write_work);
> +	set_bit(HCI_UART_SENDING, &hu->tx_state);
> +
>  	if (hu->tx_skb) {
>  		kfree_skb(hu->tx_skb); hu->tx_skb = NULL;
>  	}
> @@ -254,6 +265,13 @@ static int hci_uart_flush(struct hci_dev *hdev)
>
>  	percpu_up_read(&hu->proto_lock);
>
> +	spin_lock_irqsave(&hu->tx_lock, flags);
> +	clear_bit(HCI_UART_FLUSHING, &hu->tx_state);
> +	clear_bit(HCI_UART_SENDING, &hu->tx_state);
> +	spin_unlock_irqrestore(&hu->tx_lock, flags);
> +	if (test_bit(HCI_UART_TX_WAKEUP, &hu->tx_state))
> +		hci_uart_tx_wakeup(hu);
> +
>  	return 0;
>  }
>
> @@ -271,12 +289,8 @@ static int hci_uart_open(struct hci_dev *hdev)
>  /* Close device */
>  static int hci_uart_close(struct hci_dev *hdev)
>  {
> -	struct hci_uart *hu = hci_get_drvdata(hdev);
> -
>  	BT_DBG("hdev %p", hdev);
>
> -	cancel_work_sync(&hu->write_work);
> -
>  	hci_uart_flush(hdev);
>  	hdev->flush = NULL;
>  	return 0;
> @@ -516,6 +530,7 @@ static int hci_uart_tty_open(struct tty_struct *tty)
>
>  	tty->disc_data = hu;
>  	hu->tty = tty;
> +	spin_lock_init(&hu->tx_lock);
>  	tty->receive_room = 65536;
>
>  	/* disable alignment support by default */
> diff --git a/drivers/bluetooth/hci_serdev.c b/drivers/bluetooth/hci_serdev.c
> index 158b057ed3a6..b3148a84e9af 100644
> --- a/drivers/bluetooth/hci_serdev.c
> +++ b/drivers/bluetooth/hci_serdev.c
> @@ -312,6 +312,7 @@ int hci_uart_register_device(struct hci_uart *hu,
>
>  	if (percpu_init_rwsem(&hu->proto_lock))
>  		return -ENOMEM;
> +	spin_lock_init(&hu->tx_lock);
>
>  	err = serdev_device_open(hu->serdev);
>  	if (err)
> diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
> index 70449949d527..195957f41f28 100644
> --- a/drivers/bluetooth/hci_uart.h
> +++ b/drivers/bluetooth/hci_uart.h
> @@ -12,6 +12,8 @@
>  #define N_HCI	15
>  #endif
>
> +#include <linux/spinlock.h>
> +
>  /* Ioctls */
>  #define HCIUARTSETPROTO		_IOW('U', 200, int)
>  #define HCIUARTGETPROTO		_IOR('U', 201, int)
> @@ -76,6 +78,7 @@ struct hci_uart {
>
>  	struct sk_buff		*tx_skb;
>  	unsigned long		tx_state;
> +	spinlock_t		tx_lock;
>
>  	unsigned int init_speed;
>  	unsigned int oper_speed;
> @@ -94,6 +97,7 @@ struct hci_uart {
>  /* TX states  */
>  #define HCI_UART_SENDING	1
>  #define HCI_UART_TX_WAKEUP	2
> +#define HCI_UART_FLUSHING	3
>
>  int hci_uart_register_proto(const struct hci_uart_proto *p);
>  int hci_uart_unregister_proto(const struct hci_uart_proto *p);
