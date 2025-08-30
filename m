Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A71151991
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Aug 2025 06:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756533806; cv=none; b=C81wMX+wG5HX2pD5l7eu/HOvAhMnHm8klaD9XeJo6BBWiz+bhEyaA/n1cbTQL1g6rMswFpCw0r9vTqCb1jq0ytxZo0wRVezFEoMUAHsf9hMYbAlXvmKFUtD315zx5AgsyRQ0x/WMoh0edT/EFzLKWFRC/PnT+IlvNVuhYZECgg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756533806; c=relaxed/simple;
	bh=4DKwsW54hfGX2aelIgM0uZWIYPWXpJi9WoW+knJOHfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=e6qjDkUQrGdXhPwwiAu40PT13Geax0UQlo9QBjm/7CixFBRU1K+TmZTqDiUihgvcjPQfzi+siDbq3/lckOrTV9egwYMLEzkek87laydnsMF9BhM41h6ms/AW9Rq+KiyxhKNvqHOg+QfphBP3cdg7eEUF7vy19WCnZeGrUUgP7w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fb.dynamic.kabel-deutschland.de [95.90.247.251])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 27DFD6004C2C8;
	Sat, 30 Aug 2025 08:03:20 +0200 (CEST)
Message-ID: <f2b3c683-11c4-4a14-b53d-69aae463d310@molgen.mpg.de>
Date: Sat, 30 Aug 2025 08:03:19 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] Bluetooth: MGMT: Fix possible deadlock in
 mgmt_remove_adv_monitor_complete
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250829192104.2010557-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250829192104.2010557-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for the patch.

Am 29.08.25 um 21:21 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> This fixes the following deadlock:
> 
> --------------------------------------------
> syz.4.423/7568 is trying to acquire lock:
> ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: mgmt_remove_adv_monitor_complete+0x9e/0x2e0 net/bluetooth/mgmt.c:5524
> 
> but task is already holding lock:
> ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x3ab/0x11a0 net/bluetooth/hci_sync.c:5200
> 
> other info that might help us debug this:
>   Possible unsafe locking scenario:
> 
>         CPU0
>         ----
>    lock(&hdev->lock);
>    lock(&hdev->lock);
> 
>   *** DEADLOCK ***
> 
>   May be due to missing lock nesting notation
> 
> 3 locks held by syz.4.423/7568:
>   #0: ffff888068c48d80 (&hdev->req_lock){+.+.}-{4:4}, at: hci_dev_do_close+0x26/0x90 net/bluetooth/hci_core.c:480
>   #1: ffff888068c48078 (&hdev->lock){+.+.}-{4:4}, at: hci_dev_close_sync+0x3ab/0x11a0 net/bluetooth/hci_sync.c:5200
>   #2: ffff888068c48690 (&hdev->cmd_sync_work_lock){+.+.}-{4:4}, at: hci_cmd_sync_dequeue+0x50/0x1f0 net/bluetooth/hci_sync.c:887
> 
> Fixes: Fixes: b747a83690c8 ("Bluetooth: hci_sync: Refactor add Adv Monitor")
> Closes: https://syzkaller.appspot.com/bug?extid=e8651419c44dbc2b8768
> Reported-by: syzbot+e8651419c44dbc2b8768@syzkaller.appspotmail.com
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/mgmt.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
> index 989321b1ea27..9c1ee6ae7c66 100644
> --- a/net/bluetooth/mgmt.c
> +++ b/net/bluetooth/mgmt.c
> @@ -5189,6 +5189,14 @@ static void mgmt_add_adv_patterns_monitor_complete(struct hci_dev *hdev,
>   	struct mgmt_pending_cmd *cmd = data;
>   	struct adv_monitor *monitor = cmd->user_data;
>   
> +	/* This is likely the result of hdev being closed and mgmt_index_removed
> +	 * is attempting to clean up any pending command so
> +	 * hci_adv_monitors_clear is about to be called which will take care of
> +	 * freeing the adv_monitor instances.
> +	 */
> +	if (status == -ECANCELED)
> +		return;
> +
>   	hci_dev_lock(hdev);
>   
>   	rp.monitor_handle = cpu_to_le16(monitor->handle);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
