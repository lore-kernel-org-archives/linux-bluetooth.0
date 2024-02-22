Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727513770E
	for <linux-bluetooth@vger.kernel.org>; Thu, 22 Feb 2024 11:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708600990; cv=none; b=iqM4I6zqqNeHV52+R4IuFBvXh8+3LK/IxFUUnwudxvpw1ARuFZ8/eBbNhQMwAsLhEvwSr58UeaowDDWQIGUNYcI0PURemOUBfT9KJ1hF7lL9HE9doD96KD3pMg+0j9n1jFxU23NpxIo9HNNJSG9GwiglxlvCLKwpqME5ith1vKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708600990; c=relaxed/simple;
	bh=qM/Ys9cy+p0n5wtTF6yBdXp4QGvlQ64E0lXwBT7/XpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJwLs/8Ho/L08+JmwOBWS5/noheiSnOVnLqfDQaBrtim4FgeikDr5KRXOnfZtyaAobFJtV0mVMLP5NDK7qgqGm6N0PllZRsIsp61aa1Uq3dq6aryuoXzmoX8joub8Efc3kdevY44jRJmsA+kcMtylRcInVWNutGdLz8ffmP50x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=rrHZKqXW; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="rrHZKqXW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708600986;
	bh=qM/Ys9cy+p0n5wtTF6yBdXp4QGvlQ64E0lXwBT7/XpQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rrHZKqXWKu8HKzzCLd9/chpOS+cfWnep32ujt+aUSTjILmjX5w2v0afTBPAl4IdT6
	 xV+0HBHUoxxDXcbXWszfWNw2Atl9UvgG74Z2bYceBFRm9RTgms1mMJtApj5AlCUfGh
	 KDEXmC1Av86QbWEztLyD82W2GxPrScUlLAXECnkSKRto56z5IOEOWN0LtVo+JJ1Z+/
	 n0Xe2dCatGZmZevn1IkUPONYEah/I8ZvbkgOS8Q4H1wOEjFoaPGIuyz5Q06Rj3sQE7
	 BNkZb9qAltwWhI2xzcJNcc4sxBzV4wW1F5XHAnugnA5qEubUPNOdoFZ4Ll57DKiOFt
	 SF2yuwJkF0sPw==
Received: from [100.117.211.133] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: martyn)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4EFC73782082;
	Thu, 22 Feb 2024 11:23:06 +0000 (UTC)
Message-ID: <8dad5b42-a843-4935-a31e-91a2eadf0c72@collabora.com>
Date: Thu, 22 Feb 2024 11:23:05 +0000
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: af_bluetooth: Fix Use-After-Free in
 bt_sock_recvmsg
Content-Language: en-US
To: Hyunwoo Kim <v4bel@theori.io>, marcel@holtmann.org, luiz.dentz@gmail.com
Cc: imv4bel@gmail.com, johan.hedberg@gmail.com,
 linux-bluetooth@vger.kernel.org
References: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
From: Martyn Welch <martyn.welch@collabora.com>
In-Reply-To: <20231209105518.GA408904@v4bel-B760M-AORUS-ELITE-AX>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Hyunwoo,

I've been looking into a few CVEs, the one of interest in this case is 
CVE-2024-21803.

There seems to be little publicly available information about this CVE, 
however the title of this patch and the affected kernel range suggest 
this may be a fix for this CVE.

Would you be able to clarify whether this is a fix for CVE-2024-21803?

Thanks,

Martyn

On 09/12/2023 10:55, Hyunwoo Kim wrote:
> This can cause a race with bt_sock_ioctl() because
> bt_sock_recvmsg() gets the skb from sk->sk_receive_queue
> and then frees it without holding lock_sock.
> A use-after-free for a skb occurs with the following flow.
> ```
> bt_sock_recvmsg() -> skb_recv_datagram() -> skb_free_datagram()
> bt_sock_ioctl() -> skb_peek()
> ```
> Add lock_sock to bt_sock_recvmsg() to fix this issue.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> ---
> v1 -> v2: Remove duplicate release_sock()s
> ---
>   net/bluetooth/af_bluetooth.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
> index 336a76165454..b93464ac3517 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -309,11 +309,14 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>   	if (flags & MSG_OOB)
>   		return -EOPNOTSUPP;
>   
> +	lock_sock(sk);
> +
>   	skb = skb_recv_datagram(sk, flags, &err);
>   	if (!skb) {
>   		if (sk->sk_shutdown & RCV_SHUTDOWN)
> -			return 0;
> +			err = 0;
>   
> +		release_sock(sk);
>   		return err;
>   	}
>   
> @@ -343,6 +346,8 @@ int bt_sock_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
>   
>   	skb_free_datagram(sk, skb);
>   
> +	release_sock(sk);
> +
>   	if (flags & MSG_TRUNC)
>   		copied = skblen;
>   
