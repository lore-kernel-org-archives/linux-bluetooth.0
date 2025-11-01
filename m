Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADC119E7D1;
	Sat,  1 Nov 2025 16:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762015576; cv=none; b=cl1RdJ6H4buX9CYxSdZNEliJCyeOKd0ZSNKZauS6tuDCLS/BscyFjczwcAPlck5XLqKn1xwF/aXQ/HPaUiW1QiznOMs1mYv+DhUE5iyT9/+izokjqixvofPVwErlrjDit3UgJdWxP3i9Wju3u3QviRuz4Lw+o9y4cFzte/tNLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762015576; c=relaxed/simple;
	bh=XtmwiW1VCOZqDOB1Vuv6C2ZsXjbCzk3HUdA344goqDI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jAf/P2S2LmX0PraOi99R5Kd/mv0AJ32wr+09MmmPaU7Y9ZOEBjYfUC/9+oyWzVSfnc8A4wuqpZL+ZFRnq581vxZb7P7RxpdYki83BX3eVZE5dVLh2XNMXoZjmJtw7j9bJU/3wvwrE2LlxiMjV7DV75Usn2MFUYuLI34xfS3zCDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af736.dynamic.kabel-deutschland.de [95.90.247.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D098D61CC3FF7;
	Sat, 01 Nov 2025 17:46:05 +0100 (CET)
Message-ID: <bdd501d8-d3cf-4741-9a51-f052c3c5d4c9@molgen.mpg.de>
Date: Sat, 1 Nov 2025 17:46:05 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] Bluetooth: 6lowpan: reset link-local header on ipv6
 recv path
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: Pauli Virtanen <pav@iki.fi>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 johan.hedberg@gmail.com, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
References: <639c5cb6ceb49ffd63952dc69d0d48b022aaec3b.1761998763.git.pav@iki.fi>
 <37c918cc-9b02-4901-87ce-753a6b9c90bd@molgen.mpg.de>
Content-Language: en-US
In-Reply-To: <37c918cc-9b02-4901-87ce-753a6b9c90bd@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

[Remove bouncing jukka.rissanen@linux.intel.com]

Am 01.11.25 um 16:52 schrieb Paul Menzel:
> Dear Pauli,
> 
> 
> Thank you for your patch.
> 
> Am 01.11.25 um 13:09 schrieb Pauli Virtanen:
>> Bluetooth 6lowpan.c netdev has header_ops, so it must set link-local
>> header for RX skb, otherwise things crash, eg. with AF_PACKET SOCK_RAW
>>
>> Add missing skb_reset_mac_header() for uncompressed ipv6 RX path.
>>
>> For the compressed one, it is done in lowpan_header_decompress().
>>
>> Log: (BlueZ 6lowpan-tester Client Recv Raw - Success)
>> ------
>> kernel BUG at net/core/skbuff.c:212!
>> Call Trace:
>> <IRQ>
>> ...
>> packet_rcv (net/packet/af_packet.c:2152)
>> ...
>> <TASK>
>> __local_bh_enable_ip (kernel/softirq.c:407)
>> netif_rx (net/core/dev.c:5648)
>> chan_recv_cb (net/bluetooth/6lowpan.c:294 net/bluetooth/6lowpan.c:359)
>> ------
>>
>> Fixes: 18722c247023 ("Bluetooth: Enable 6LoWPAN support for BT LE devices")
>> Signed-off-by: Pauli Virtanen <pav@iki.fi>
>> ---
>>   net/bluetooth/6lowpan.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/net/bluetooth/6lowpan.c b/net/bluetooth/6lowpan.c
>> index f0c862091bff..f1d29fa4b411 100644
>> --- a/net/bluetooth/6lowpan.c
>> +++ b/net/bluetooth/6lowpan.c
>> @@ -289,6 +289,7 @@ static int recv_pkt(struct sk_buff *skb, struct net_device *dev,
>>           local_skb->pkt_type = PACKET_HOST;
>>           local_skb->dev = dev;
>> +        skb_reset_mac_header(local_skb);
>>           skb_set_transport_header(local_skb, sizeof(struct ipv6hdr));
>>           if (give_skb_to_upper(local_skb, dev) != NET_RX_SUCCESS) {
> 
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> 
> 
> Kind regards,
> 
> Paul

