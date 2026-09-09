Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04802D2394;
	Wed,  9 Sep 2026 06:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936588; cv=none; b=stZAYkRBwv4ahHUO8b16FbUchv1/4AOwzi0AL1UjioumhrZpGCRYmLHa68i+gRsJb3xPBw+EUxqUUfVu5FGrApbVyi6Vp+6l5AERZMDfMlRPEIw53DjolsrdzwsPiJwkG2wvsaZvhCqOFcO5vYjtBUFHV2LL05KYQGdyNOL/Zic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936588; c=relaxed/simple;
	bh=XBnhsi6xvd4e0jQm3n+/womrD2HTzZRCWmLgKfzumUY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H/Qe6uvykrNtzACunUNr9CdCwECyuqAwVcFO/nYvSPqiPyB4W8cIE0s/FKdSEZSrTizLTxQ+Y2VTq3l2npV3yDWUcp9WUy6B7usYRo6MklUYhBPJ4OaxhoiRqlML3MHhhWjbacCgGB92lcTs9pRCkmD2lPtxHwXNq6E5GTt7EcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dr33Oncq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dr33Oncq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097701F00A3A;
	Wed,  9 Sep 2026 06:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936586;
	bh=kKazGw5+atcf0ULky7HaRXouWtqNdBEt7UPDBRT986Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dr33OncqDBFbFP0lBx8VgSPNAVtFNI0WyeYLAVUD2xAgJjZQnZt5h3njQ+KQcPZon
	 O95u0acudgbsHa1xmlZlG6TCivLf5XPp8SVoaVjkzSBKv/Z3LzSlioRG405Ign4Gu3
	 sJHz1Oy+Q+idOmcEiuvqQO1iP85QX7qdBW/Id6MO7WgfmmNdKMNQjpff5RTah+uL/V
	 YEDVbcClRjPEqrIVjiyO+3OmZE/J9HGltD/nD2XW8OZT6CMNq1vsNscBelvU+b0gPa
	 ukscqMCQA5YKAnGTNgPHPv2HjvgQHT0wA60csavZbmth/w1Csld28/Qz03y1dCobta
	 mvnvtKb6gwhOw==
Subject: Re: [PATCH] Bluetooth: bnep: linearize skb before sending
From: netdev-bot+sashiko@kernel.org
To: adrianox@gmail.com
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org
Date: Wed, 09 Sep 2026 06:49:45 +0000
Message-ID: <178893658555.219967.8683671441014742630@kernel.org>
In-Reply-To: <20260905194725.284347-1-adrianox@gmail.com>
References: <20260905194725.284347-1-adrianox@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] net/bluetooth/bnep/core.c:bnep_tx_frame() — the newly added
  skb_linearize() is placed at the `send:` label (line 480), i.e. AFTER…

--

Bluetooth: bnep: linearize skb before sending

This replaces the FIXME comment and its dead block in bnep_tx_frame()
with an skb_linearize() call at the send: label, freeing the skb and
returning -ENOMEM on failure.  The commit describes the change as
defensive since the stack should already have linearized the skb.

> diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
> index f7d88c33e23e4..e9bbd4b0dff17 100644
> --- a/net/bluetooth/bnep/core.c
> +++ b/net/bluetooth/bnep/core.c
> @@ -477,13 +477,15 @@ static int bnep_tx_frame(struct bnep_session *s, struct sk_buff *skb)
>  	}
>  
>  send:
> +	if (skb_linearize(skb)) {
> +		kfree_skb(skb);
> +		return -ENOMEM;
> +	}
> +

[Severity: High]
Is this placement of skb_linearize() too late?  The commit message says
"Check the skb is linear before building its kvec", but at the send:
label part of the kvec array has already been built from pointers into
the old skb head.

bnep_tx_frame() captures eh at entry:

	struct ethhdr *eh = (void *) skb->data;

and for the compressed cases it stores eh-derived bases into iv[]:

	case BNEP_COMPRESSED_SRC_ONLY:
		iv[il++] = (struct kvec) { eh->h_source, ETH_ALEN };
		len += ETH_ALEN;
		break;

	case BNEP_COMPRESSED_DST_ONLY:
		iv[il++] = (struct kvec) { eh->h_dest, ETH_ALEN };
		len += ETH_ALEN;
		break;

skb_linearize() -> __skb_linearize() -> __pskb_pull_tail() can reallocate
the head:

net/core/skbuff.c:__pskb_pull_tail() {
	...
	if (eat > 0 || skb_cloned(skb)) {
		if (pskb_expand_head(skb, 0, eat > 0 ? eat + 128 : 0,
				     GFP_ATOMIC))
			return NULL;
	}
	...
}

pskb_expand_head() allocates a new head, copies the data over and frees
the old buffer, which is why its kerneldoc says all pointers into the skb
header must be reloaded after the call.  eh is never reloaded here, so
does iv[1] end up pointing at the freed head?

> @@ ... (continued)
>  	iv[il++] = (struct kvec) { skb->data, skb->len };
>  	len += skb->len;
>  
> -	/* FIXME: linearize skb */
> -	{
> -		len = kernel_sendmsg(sock, &s->msg, iv, il, len);
> -	}
> +	len = kernel_sendmsg(sock, &s->msg, iv, il, len);
>  	kfree_skb(skb);
>  
>  	if (len > 0) {

[Severity: High]
Can this kernel_sendmsg() then read six bytes of freed slab memory and
transmit them to the remote BNEP peer, along with a corrupted MAC header
in the frame?

There is also a self-consistency question about the change: when the skb
is already linear, skb_linearize() is a no-op and the patch has no
effect.  The only case where the new call does anything is the nonlinear
case, which is exactly the case where it can invalidate iv[1].  Would
moving the linearization to function entry, before eh is dereferenced and
before the skb_pull(skb, ETH_ALEN * 2), or reloading eh after a
successful linearize, match what the commit message describes?

For reference, the RX side in the same file already linearizes before any
header is touched:

net/bluetooth/bnep/core.c:bnep_session() {
	...
		while ((skb = skb_dequeue(&sk->sk_receive_queue))) {
			skb_orphan(skb);
			if (!skb_linearize(skb))
				bnep_rx_frame(s, skb);
			else
				kfree_skb(skb);
		}
	...
}

On reachability of the dangling pointer today: bnep_net_setup() in
net/bluetooth/bnep/netdev.c only calls ether_setup() and never advertises
NETIF_F_SG or NETIF_F_FRAGLIST, and netif_skb_features() can only reduce
dev->features, so validate_xmit_skb()/skb_needs_linearize() should
already have linearized before ndo_start_xmit, and skb_gso_segment() with
!NETIF_F_SG produces linear segments.  So the freed-memory read may not
be demonstrably reachable in-tree, but the ordering the commit message
claims to establish is not the ordering the code implements.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260905194725.284347-1-adrianox%40gmail.com
