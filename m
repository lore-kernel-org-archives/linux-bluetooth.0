Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8DEEA8;
	Sat, 29 Aug 2026 23:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788046372; cv=none; b=sEhbWjm83qhuMUF3Kg43BbmsnMfLje51wutitH/IvQd7ZbiYohpFjqMUf5MMh7DKZVvHUpxEhIXbKQ3iDl15kF0q6SomVCB35qf5lL+JODkW/Kf65uXbyEM6u9MOhbbOSh8jnDcn2w/QH90VWpfXu2xC+Vs+1raVBHhDptB93x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788046372; c=relaxed/simple;
	bh=ys1HRJayDbJSNLN+4QYYiSF0H0i1a6dpj3Z0lPLmQMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY6yK+cvCmZaIn0VJ7YIr/fWK9OwYQ6WkFyWJKXzegmWCPvUHduaEbqVRjn4MR1aAElN7u9qu7svjnNY+SxoejcGDreofUYWvxiArorUE3JqAZwDeAocV7cRxnjzvEjAZL+EgLCy4E9g+mQKuyR9aJgP9jLvWMQi3aLuVwCaMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.220] (p5b13adbf.dip0.t-ipconnect.de [91.19.173.191])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 6ED8C4C2C37D61;
	Sun, 30 Aug 2026 01:24:52 +0200 (CEST)
Message-ID: <e4f4931b-c930-4efd-9bbb-9f83d6ddf360@molgen.mpg.de>
Date: Sun, 30 Aug 2026 01:24:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: L2CAP: fix wrong identifier in
 __set_ack_timer()
To: Pauli Virtanen <pav@iki.fi>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <efd26a64addcb562db0745aa4e0a8d2252be1d65.1788016177.git.pav@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <efd26a64addcb562db0745aa4e0a8d2252be1d65.1788016177.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for your patch.

Am 29.08.26 um 17:13 schrieb Pauli Virtanen:
> __set_ack_timer(c) has chan->ack_timer instead of c->ack_timer like the
> other macros.
> 
> Fix it to use the timer corresponding to the macro argument.  In current
> code this is only called as __set_ack_timer(chan) so this has no runtime
> impact.
> 
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>      Saw this one in Sashiko trace.
> 
>   include/net/bluetooth/l2cap.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
> index 69d193fee351..99c07f1278a0 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -873,8 +873,8 @@ static inline bool l2cap_clear_timer(struct l2cap_chan *chan,
>   #define __clear_chan_timer(c) l2cap_clear_timer(c, &c->chan_timer)
>   #define __clear_retrans_timer(c) l2cap_clear_timer(c, &c->retrans_timer)
>   #define __clear_monitor_timer(c) l2cap_clear_timer(c, &c->monitor_timer)
> -#define __set_ack_timer(c) l2cap_set_timer(c, &chan->ack_timer, \
> -		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO));
> +#define __set_ack_timer(c) l2cap_set_timer(c, &c->ack_timer, \
> +		msecs_to_jiffies(L2CAP_DEFAULT_ACK_TO))
>   #define __clear_ack_timer(c) l2cap_clear_timer(c, &c->ack_timer)
>   
>   static inline int __seq_offset(struct l2cap_chan *chan, __u16 seq1, __u16 seq2)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
