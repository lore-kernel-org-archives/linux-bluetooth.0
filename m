Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A314225A642
	for <linux-bluetooth@vger.kernel.org>; Sat,  4 Oct 2025 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759583860; cv=none; b=nQtZDiUDOoJdfpN/ndlO5G3QBXL0k9cPs8lG88axI+gS9mrWrdr+6F/kcBI5OsTOAbzIUbFdKO20AabMq4jAt0MI6PFYIEygHLwlVrCKp7GjAbp/UuD+TBJabpbI+I6biYG0sH4SLrx0RxOfR0fLo31fRuKrFPhIv7jBArgIr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759583860; c=relaxed/simple;
	bh=ail652poz7xDAFmXp9CU32uEKZi94qF7Eslz1c9voEU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=O1llt1mKCTohAZ5IB1q/86J45TGFKms4+b2P2OYPHZw7LAvb2tmP0hRxj+GlcMjaPM53JGsBA5tSHggSLq2GWccT6jygvFC+ixMCbm2p5WTgj12t5FaF6lIs4kBMxaaDWcHp27VvuQFi7uWiUOZOGUpzy0czaGP5GdbzcJ+Abx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.212] (p57bd9ba3.dip0.t-ipconnect.de [87.189.155.163])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id DB1C06028F34A;
	Sat, 04 Oct 2025 15:17:09 +0200 (CEST)
Message-ID: <10955511-f53d-411a-ac2b-92da32378ae4@molgen.mpg.de>
Date: Sat, 4 Oct 2025 15:17:07 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: ISO/SCO: hold sock in recv_frame
To: Pauli Virtanen <pav@iki.fi>
References: <b1d0f88cdb992967daf6806116599d1b29711d6b.1759577633.git.pav@iki.fi>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <b1d0f88cdb992967daf6806116599d1b29711d6b.1759577633.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for your patch.

Am 04.10.25 um 13:37 schrieb Pauli Virtanen:
> In sco_recv_frame(), sk is accessed without holding lock or refcount.
> conn->sk is obtained under lock, it guards data race on conn->sk versus
> sco_chan_del() / sco_sock_kill(), but does not prevent sk from being
> destroyed after unlock.  Similarly for ISO. (L2CAP holds chan_lock so is
> OK).
> 
> Use sock_hold()/sock_put() during the section sk is accessed.
> 
> Simultaneous socket release in theory could cause UAF here, but probably
> hard to hit in practice.
> 
> Fixes: ccf74f2390d60 ("Bluetooth: Add BTPROTO_ISO socket type")
> Fixes: eb5a4de80f266 ("Bluetooth: Remove sco_chan_get helper function")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
> 
> Notes:
>      v2:
>      - handle NULL conn->sk properly
> 
>   net/bluetooth/iso.c | 7 ++++++-
>   net/bluetooth/sco.c | 7 ++++++-
>   2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 954e1916506b..1f9a4c784ba3 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -572,6 +572,8 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
>   
>   	iso_conn_lock(conn);
>   	sk = conn->sk;
> +	if (sk)
> +		sock_hold(sk);
>   	iso_conn_unlock(conn);
>   
>   	if (!sk)
> @@ -583,10 +585,13 @@ static void iso_recv_frame(struct iso_conn *conn, struct sk_buff *skb)
>   		goto drop;
>   
>   	if (!sock_queue_rcv_skb(sk, skb))
> -		return;
> +		goto done;
>   
>   drop:
>   	kfree_skb(skb);
> +done:
> +	if (sk)
> +		sock_put(sk);
>   }
>   
>   /* -------- Socket interface ---------- */
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index ab0cf442d57b..e7273dc8a073 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -402,6 +402,8 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
>   
>   	sco_conn_lock(conn);
>   	sk = conn->sk;
> +	if (sk)
> +		sock_hold(sk);
>   	sco_conn_unlock(conn);
>   
>   	if (!sk)
> @@ -413,10 +415,13 @@ static void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
>   		goto drop;
>   
>   	if (!sock_queue_rcv_skb(sk, skb))
> -		return;
> +		goto done;
>   
>   drop:
>   	kfree_skb(skb);
> +done:
> +	if (sk)
> +		sock_put(sk);
>   }
>   
>   /* -------- Socket interface ---------- */

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
