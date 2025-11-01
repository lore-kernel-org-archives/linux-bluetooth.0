Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9323313E;
	Sat,  1 Nov 2025 15:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762012445; cv=none; b=iHUQg62DJQWUnYKN4JzFkWGGZv3Aaye6pxJyfLOiDq9qS9cnoiXezBfVGHwD2c/sfHVYjLjdH+ANo+nzX0tianmXhO9PCfondJqh3ke1C5R5JYa7EefmgAGOJU5uw5lk4EOp7saXcdAWprAgBB8fGqPxny4VSlFkZzZWqtFmRhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762012445; c=relaxed/simple;
	bh=XXqhB3GOVSDLddidiZlNuz1jOVJyuIppL/dLwYnhkc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gH7ECyhLMab4dokfR6kX0Q7DoHrFfGeaVVZl4KCM1ZgFRrJiysUPCiJECI2lgs2vCgluXsuNLi+NYyXu6PlZoj6JVTXTbMfyCFvSpoIxBlF+c2gp6AjLzgxUrRuXI2OCIqd8SIE1Nikie0vn8NH7QsfUkBi35rOikKyPfZyhRIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.103] (unknown [185.238.219.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 4B5BD61CC3FE8;
	Sat, 01 Nov 2025 16:52:49 +0100 (CET)
Message-ID: <37c918cc-9b02-4901-87ce-753a6b9c90bd@molgen.mpg.de>
Date: Sat, 1 Nov 2025 16:52:47 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Bluetooth: 6lowpan: reset link-local header on ipv6
 recv path
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 jukka.rissanen@linux.intel.com, linux-kernel@vger.kernel.org
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for your patch.

Am 01.11.25 um 13:09 schrieb Pauli Virtanen:
> Bluetooth 6lowpan.c netdev has header_ops, so it must set link-local
> header for RX skb, otherwise things crash, eg. with AF_PACKET SOCK_RAW
> 
> Add missing skb_reset_mac_header() for uncompressed ipv6 RX path.
> 
> For the compressed one, it is done in lowpan_header_decompress().
> 
> Log: (BlueZ 6lowpan-tester Client Recv Raw - Success)
> ------
> kernel BUG at net/core/skbuff.c:212!
> Call Trace:
> <IRQ>
> ...
> packet_rcv (net/packet/af_packet.c:2152)
> ...
> <TASK>
> __local_bh_enable_ip (kernel/softirq.c:407)
> netif_rx (net/core/dev.c:5648)
> chan_recv_cb (net/bluetooth/6lowpan.c:294 net/bluetooth/6lowpan.c:359)
> ------
> 
> Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>   net/bluetooth/6lowpan.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
> index f0c862091bff..f1d29fa4b411 100644
> --- a/net/bluetooth/6lowpan.c
> +++ b/net/bluetooth/6lowpan.c
> @@ -289,6 +289,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>   		local_skb->pkt_type = PACKET_HOST;
>   		local_skb->dev = dev;
>   
> +		skb_reset_mac_header(local_skb);
>   		skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
>   
>   		if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
