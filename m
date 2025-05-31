Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A530B1AA1E4
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 May 2025 21:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748727700; cv=none; b=KrwXVE2EdyxhkqJIxMg/9ZZYM3McW54orrgWBy9Y9ZcrJrVnww0Hr7lstSMnlLR4HHdJM3Ngkw6qIzFN9KtU3O9OvorzWGX1g8PFa0ozq96Ln2zDZWGoqJb7e9o/tD9dulsnfxloXL/wr5xZfFQ/Qq8wQUlLWfjIMmgwn++NZKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748727700; c=relaxed/simple;
	bh=hpwJ6kHawiwZ+uKEmAKCdXbtwpe4y9/PGv0Z4CX36d0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=H+1WumzY45L7ilPSASnojI8/yFKZ4sQDX1hgT2tW9ipTILQY0bgyBYxn7zWDfAAkfKirLNk9LFh2RN/wQrzBCI7IHqMzW0Adjfkjl+C9plEw5mKNss6mpCg8WzHXY7Fi29FT6EWq//3uSOFFxnwu1dRfMxX5N9iUJQx84bVdbkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.111] (p5dc5559d.dip0.t-ipconnect.de [93.197.85.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9103361E64787;
	Sat, 31 May 2025 23:41:23 +0200 (CEST)
Message-ID: <3aad402f-7ec4-4e05-ab94-750a44663339@molgen.mpg.de>
Date: Sat, 31 May 2025 23:41:21 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_core: fix list_for_each_entry_rcu usage
To: Pauli Virtanen <pav@iki.fi>
References: <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <4bfedc6d6edfdbdc7f2bde88da75a8329e78abb4.1748704997.git.pav@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Pauli,


Thank you for your patch.

Am 31.05.25 um 17:24 schrieb Pauli Virtanen:
> Releasing + re-acquiring RCU lock inside list_for_each_entry_rcu() loop
> body is not correct.
> 
> Fix by taking the update-side hdev->lock instead.
> 
> Fixes: c7eaf80bfb0c ("Bluetooth: Fix hci_link_tx_to RCU lock usage")
> Signed-off-by: Pauli Virtanen <pav@iki.fi>
> ---
>   net/bluetooth/hci_core.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 3b49828160b7..04845ff3ad57 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -3417,23 +3417,18 @@ static void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
>   
>   	bt_dev_err(hdev, "link tx timeout");
>   
> -	rcu_read_lock();
> +	hci_dev_lock(hdev);
>   
>   	/* Kill stalled connections */
> -	list_for_each_entry_rcu(c, &h->list, list) {
> +	list_for_each_entry(c, &h->list, list) {
>   		if (c->type == type && c->sent) {
>   			bt_dev_err(hdev, "killing stalled connection %pMR",
>   				   &c->dst);
> -			/* hci_disconnect might sleep, so, we have to release
> -			 * the RCU read lock before calling it.
> -			 */
> -			rcu_read_unlock();
>   			hci_disconnect(c, HCI_ERROR_REMOTE_USER_TERM);
> -			rcu_read_lock();
>   		}
>   	}
>   
> -	rcu_read_unlock();
> +	hci_dev_unlock(hdev);
>   }
>   
>   static struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
