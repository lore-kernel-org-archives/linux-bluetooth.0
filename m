Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C95277008;
	Wed, 16 Jul 2025 03:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752635217; cv=none; b=mCC1UJ7K56tn+J+6MBKrfxVzZi3YTxj0PVLTpsQdAcRVZLnPLv0MCbbgOqXfYel2teJ/fPrOoOoHw17m1NJHYUHou6tNO2iOPTethZlzzOeayGNUKIK2Ziv3/TqklacgxSmYm8i/71R0J7DGcq5KNnspu2tTC6eqZBmsKmZUpNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752635217; c=relaxed/simple;
	bh=C5BY+mWJWOVURmn38pEjDOkBKzl+ii4awTwOdrv5Dro=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eZvhZWwKkMLcIFdpZx+HdseDEZLyg5HzzEucf3zZ6fKycXIiTPTAsBH3CVNjr8vAjy1y/mNqXKiGmNM3qPw3Z0jMqsjGkAZ5gGfzfnTv/Q76FCre7oqfKj/TnQhxXEJu3aObtOYf4/ikwxRpaz1gOyBtVVIKQSdmwLs0Q1YoYgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.196] (p5b13a973.dip0.t-ipconnect.de [91.19.169.115])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1E87A61E64848;
	Wed, 16 Jul 2025 05:06:40 +0200 (CEST)
Message-ID: <d8a85b98-4c70-4fcf-9d7b-bd1de2d780c3@molgen.mpg.de>
Date: Wed, 16 Jul 2025 05:06:38 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: coredump: Use tmp buffer with dev_coredumpv
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
References: <20250716003726.124975-2-ipravdin.official@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250716003726.124975-2-ipravdin.official@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ivan,


Thank you for your patch and fixing the report.

Am 16.07.25 um 02:37 schrieb Ivan Pravdin:

Personally, I’d start with the problem description.

> Create and use new vmalloc'ed buffer with dev_coredumpv. From
> dev_coredumpv documentation:
> 
> `This function takes ownership of the vmalloc'ed data and will free
> it when it is no longer used.`

You could use email/Markdown style citation by prepending the lines with 
`> `.

> As hdev->dump is used after dev_coredumpv, create temporary buffer to
> hold hdev->dump data.
> 
> Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaa688.050a0220.1547ec.014a.GAE@google.com

Add a trace excerpt to the commit message?

> Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> ---
> v1 -> v2: Changed subject prefix to Bluetooth:
> 
>   net/bluetooth/coredump.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> index 819eacb38762..1232c9a94f95 100644
> --- a/net/bluetooth/coredump.c
> +++ b/net/bluetooth/coredump.c
> @@ -243,6 +243,7 @@ static void hci_devcd_handle_pkt_pattern(struct hci_dev *hdev,
>   static void hci_devcd_dump(struct hci_dev *hdev)
>   {
>   	struct sk_buff *skb;
> +	char *coredump;
>   	u32 size;
>   
>   	bt_dev_dbg(hdev, "state %d", hdev->dump.state);
> @@ -250,7 +251,11 @@ static void hci_devcd_dump(struct hci_dev *hdev)
>   	size = hdev->dump.tail - hdev->dump.head;
>   
>   	/* Emit a devcoredump with the available data */
> -	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> +	coredump = vmalloc(size);
> +	if (coredump) {
> +		memcpy(coredump, hdev->dump.head, size);
> +		dev_coredumpv(&hdev->dev, coredump, size, GFP_KERNEL);
> +	}

Should it be logged, if allocation fails?

>   
>   	/* Send a copy to monitor as a diagnostic packet */
>   	skb = bt_skb_alloc(size, GFP_ATOMIC);


Kind regards,

Paul
