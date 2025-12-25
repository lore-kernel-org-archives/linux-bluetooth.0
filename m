Received: from smtp153-141.sina.com.cn (smtp153-141.sina.com.cn [61.135.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DD74C6D
	for <linux-bluetooth@vger.kernel.org>; Thu, 25 Dec 2025 02:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766628613; cv=none; b=nHldBMnvxTYvD6EvpdmdyFSn5aQxz914MmSTnf52mBIQru9l/n6uVMEbC8oXvH9nD8izkNvF7ePWGFH2NrFdko7Dd+pR0oxAGxiyW2659R+Qm45N8+YSCu8yiSsheXREQPMHpq3gALTy7HnWbJ+Lrf+/InRTeMKUKHRYFpvcyMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766628613; c=relaxed/simple;
	bh=B6L3Y9HqlvinDxhwiMo8m0JyZ6af3xIUJiAz30SCTIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uaNjLZgvdh+PisUFm8jRRZbiyuyFd6IzJ12U41MhqjWFsxSH+pbY8H9CARf385T2A7XfdoNflUGW8wOALLjv9btGVDCkMyXXWElxkPa08TKmfzRIl+KjFzcM35Uk9fqrp8GvNgXjFLXh+p2nNyuhBxiXBzgASXKuB7eW7DK6AoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=gG++QxGF; arc=none smtp.client-ip=61.135.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="gG++QxGF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1766628605;
	bh=nzALO9gTaXvwoTSHIIQgQRKYo8GwYiwbZQN/c0FRisk=;
	h=From:Subject:Date:Message-ID;
	b=gG++QxGFKO1AS52G04C9/9/UBbvv1wnTjEr3un4YcZDDj7OD0u7dg+Xby9nRbkmWW
	 WgrzFkCm3LCLeZnKk9T/RQmZ7e844MnaJ1oX07djAX8460WMSEZu0z24mOTvQosvrE
	 VYxhXxyi1h+Vh1Z7tWJQor+90TEBU3I9TmLalZl8=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.57.85])
	by sina.com (10.54.253.31) with ESMTP
	id 694C9CCD00003B7F; Thu, 25 Dec 2025 10:09:20 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 2071096816229
X-SMAIL-UIID: 924ED4C03428480C8704F0AE601C6113-20251225-100920-1
From: Hillf Danton <hdanton@sina.com>
To: Szymon Wilczek <swilczek.lx@gmail.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com
Subject: Re: [PATCH] Bluetooth: hci_core: Fix slab-use-after-free in hci_cmd_work
Date: Thu, 25 Dec 2025 10:09:11 +0800
Message-ID: <20251225020913.1821-1-hdanton@sina.com>
In-Reply-To: <20251224235407.46333-1-swilczek.lx@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 25 Dec 2025 00:54:07 +0100 Szymon Wilczek wrote:
> syzbot reported a slab-use-after-free in hci_cmd_work.
> The issue is that hci_send_cmd_sync() consumes the skb reference
> (either by passing it to the driver which frees it, or by calling
> kfree_skb() on error), but the skb might be accessed after the call
> in certain configurations or due to race conditions with the freeing
> process (e.g. vhci_read).
> 
> Explicitly hold a reference to the skb using skb_get() before calling
> hci_send_cmd_sync() and release it with kfree_skb() afterwards. This
> ensures the skb object remains valid throughout the function call,
> regardless of how hci_send_cmd_sync() handles the original reference.
> 
> Reported-by: syzbot+4d6b203d625d2f57d4ca@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=4d6b203d625d2f57d4ca
> Signed-off-by: Szymon Wilczek <swilczek.lx@gmail.com>
> ---
>  net/bluetooth/hci_core.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 8ccec73dce45..af4ef31295c4 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -4149,7 +4149,10 @@ static void hci_cmd_work(struct work_struct *work)
>  		if (!skb)
>  			return;
>  
> +		skb_get(skb);
>  		err = hci_send_cmd_sync(hdev, skb);
> +		kfree_skb(skb);
> +
>  		if (err)
>  			return;
>  
> -- 
> 2.52.0
> 
Given skb_dequeue() in both vhci_read() and hci_cmd_work(), what is
missed is the root cause of the issue.
