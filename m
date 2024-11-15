Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74111BFE10
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 Nov 2024 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677512; cv=none; b=Rh/8s7/mhT1CCVcE1TO7pMJrsJ4tQp8yFLroS4Lvv9e4wUhUSeUXUQK+0ejgxaTHxjMVUjH6lBmKC2W6Tb2x7NQxuBnrieDDoqi1hG1yKp1T4uINB4gGEjx2QOTXVIG9HMTGZFYvTm/98kolv/gpsuN94KEVQrpVOQbAInersHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677512; c=relaxed/simple;
	bh=TGfeF9jfwiGzuVabAU4uBsBRpaDCe/g0eq53ZryKluE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=espSuPxEjlqR6zKCqoZOyZ+vsJal4MLwNQS9lScitxCUUeYusss6Rhs/ocUqlfmbxaj9b8AUb81gYgxFrhLFsVDUXshFsibyOtjQ3guSmXSSIrA55ReNBrMmikq15mwyQhqLZvU1VH/A+ODFk/P8vyCslGU5068cz5vCtp56pPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=hZTrJNJq; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="hZTrJNJq"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1tBwQK-007uMm-BD; Fri, 15 Nov 2024 14:31:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=9brxqYpUrPJeiMR2LOIdYKOLyfi36uyRjdHFkdjs4TM=; b=hZTrJNJqJHEHs4LpGNGqUzJsln
	KtFpykERQWFaXSABgnl440pfqyVc3dhHMw0JzmO4XsVF+rUATpssOVKMdb31aLk8vGdkKY8nLnNZ9
	1YT5kj3mS4JDJTQkZdVa9TfmtxUYtoo8UKTCp+4p4hfeaDM9OLNmZZTYp0QQ/erTcmmGgg1I5+aUM
	umH7rcsljvbPkCMHZ2cYtYmmToGvHyVh61tWvtr6NclTj6maPz+ktl9Pqa3tlrzTPOk47PoIyEtCG
	An9G2c7t9PcbwPgzLz50srjTXLXIoqwdmhJ6KVzBP0LOZrkO8KV+VQbOO0vJ9Ak9i6uQq06ty4GZt
	oVSwsnfA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1tBwQI-0004ZK-60; Fri, 15 Nov 2024 14:31:42 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1tBwQE-00CCXR-OC; Fri, 15 Nov 2024 14:31:38 +0100
Message-ID: <3dcb1f81-8eb8-44d8-8ad2-05090a4b1a98@rbox.co>
Date: Fri, 15 Nov 2024 14:31:37 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/4] llc: Improve setsockopt() handling of malformed
 user input
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-afs@lists.infradead.org, Jakub Kicinski <kuba@kernel.org>
References: <20241115-sockptr-copy-fixes-v1-0-d183c87fcbd5@rbox.co>
 <20241115-sockptr-copy-fixes-v1-2-d183c87fcbd5@rbox.co>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20241115-sockptr-copy-fixes-v1-2-d183c87fcbd5@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/15/24 00:27, Michal Luczaj wrote:
> copy_from_sockptr()'s non-zero result represents the number of bytes that
> could not be copied. Turn that into EFAULT.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Michal Luczaj <mhal@rbox.co>
> ---
>  net/llc/af_llc.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/net/llc/af_llc.c b/net/llc/af_llc.c
> index 4eb52add7103b0f83d6fe7318abf1d1af533d254..c4febedd1ca0e959dcecea524df37eb328bd626d 100644
> --- a/net/llc/af_llc.c
> +++ b/net/llc/af_llc.c
> @@ -1093,15 +1093,17 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
>  	struct sock *sk = sock->sk;
>  	struct llc_sock *llc = llc_sk(sk);
>  	unsigned int opt;
> -	int rc = -EINVAL;
> +	int rc = 0;
>  
>  	lock_sock(sk);
> -	if (unlikely(level != SOL_LLC || optlen != sizeof(int)))
> +	if (unlikely(level != SOL_LLC || optlen != sizeof(opt))) {
> +		rc = -EINVAL;
>  		goto out;
> -	rc = copy_from_sockptr(&opt, optval, sizeof(opt));
> -	if (rc)
> +	}
> +	if (copy_from_sockptr(&opt, optval, sizeof(opt))) {
> +		rc = -EFAULT;
>  		goto out;
> -	rc = -EINVAL;
> +	}
>  	switch (optname) {
>  	case LLC_OPT_RETRY:
>  		if (opt > LLC_OPT_MAX_RETRY)
> @@ -1151,9 +1153,8 @@ static int llc_ui_setsockopt(struct socket *sock, int level, int optname,
>  		break;
>  	default:
>  		rc = -ENOPROTOOPT;
> -		goto out;
> +		break;
>  	}
> -	rc = 0;
>  out:
>  	release_sock(sk);
>  	return rc;
> 

Great, I broke it in a worse way: on bad input all the checks under the
switch would silently fail. Apologies, here is v2:
https://lore.kernel.org/netdev/20241115-sockptr-copy-fixes-v2-0-9b1254c18b7a@rbox.co/

Michal

PS. Ugh, and I've just realized; sorry for forgetting about the "wait 24h
before re-submitting" rule...

