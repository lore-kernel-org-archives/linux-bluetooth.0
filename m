Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66ECD1624C0;
	Fri, 22 Aug 2025 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755862918; cv=none; b=m4kjKHN9VtfQ+hsftaMlaLpptHX3ZqCFvO32pUj4lxv/YX9wF8ktS+/B38ts7xhylu6EjtasOjN0E/A9cqKQ3GRXo8lyQcrEZjmTG8Wy2Jf9WRFwk1W2Fe4QNvCem7HI/E3lWBO1wHjs9it0RK0eaGEBUakj5bU95jv8ZnRzzMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755862918; c=relaxed/simple;
	bh=7zTVKcxNznwCQ46UxTYNZttYWk+v2ssfAQ+Drun7lgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SYedbPCpQPwuW/PzyZtu6FK1iSCpgqOHXDRk+Iv1atoa2kSDqA1VV47oqt+m2itDFqKz2h0Y3YTzVSnVD1Pr8AQoXmTemxvGHjZjmg+Gwu9Da4Dui+XXJ4t4dxzTkZ62qKubwdZV4VPW8HSsZT4qjyv/q9MmgCqiwei9dwqrHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id ABD4461E647BB;
	Fri, 22 Aug 2025 13:41:41 +0200 (CEST)
Message-ID: <06787d51-5d5e-4f74-bda6-b80cead5ed6d@molgen.mpg.de>
Date: Fri, 22 Aug 2025 13:41:41 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_h5: avoid sending two SYNC messages
To: Javier Nieto <jgnieto@cs.stanford.edu>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250822003912.41754-1-jgnieto@cs.stanford.edu>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250822003912.41754-1-jgnieto@cs.stanford.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Javier,


Thank you for your patch.


Am 22.08.25 um 02:39 schrieb Javier Nieto:
> Previously, h5_open() called h5_link_control() to send a SYNC message.
> But h5_link_control() only enqueues the packet and requires the caller
> to call hci_uart_tx_wakeup(). Thus, after H5_SYNC_TIMEOUT ran out
> (100ms), h5_timed_event() would be called and, realizing that the state
> was still H5_UNINITIALIZED, it would re-enqueue the SYNC and call
> hci_uart_tx_wakeup(). Consequently, two SYNC packets would be sent and
> initialization would unnecessarily wait for 100ms.
> 
> The naive solution of calling hci_uart_tx_wakeup() in h5_open() does not
> work because it will only schedule tx work if the HCI_PROTO_READY bit is
> set and hci_serdev only sets it after h5_open() returns. This patch
> removes the extraneous SYNC being enqueued and makes h5_timed_event()
> wake up on the next jiffy.

Great commit message, thank you. I’d appreciate it if you documented 
your test environment, and maybe paste the logs (for the timestamps) 
before and after, so others could easily reproduce the issue.

> Signed-off-by: Javier Nieto <jgnieto@cs.stanford.edu>
> ---
>   drivers/bluetooth/hci_h5.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
> index d0d4420c1a0f..863ee93dd8a8 100644
> --- a/drivers/bluetooth/hci_h5.c
> +++ b/drivers/bluetooth/hci_h5.c
> @@ -213,7 +213,6 @@ static void h5_peer_reset(struct hci_uart *hu)
>   static int h5_open(struct hci_uart *hu)
>   {
>   	struct h5 *h5;
> -	const unsigned char sync[] = { 0x01, 0x7e };
>   
>   	BT_DBG("hu %p", hu);
>   
> @@ -243,9 +242,11 @@ static int h5_open(struct hci_uart *hu)
>   
>   	set_bit(HCI_UART_INIT_PENDING, &hu->hdev_flags);
>   
> -	/* Send initial sync request */
> -	h5_link_control(hu, sync, sizeof(sync));
> -	mod_timer(&h5->timer, jiffies + H5_SYNC_TIMEOUT);
> +	/*
> +	 * Wait one jiffy because the UART layer won't set HCI_UART_PROTO_READY,
> +	 * which allows us to send link packets, until this function returns.
> +	 */
> +	mod_timer(&h5->timer, jiffies + 1);
>   
>   	return 0;
>   }

Makes sense.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
