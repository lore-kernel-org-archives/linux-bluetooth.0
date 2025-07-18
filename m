Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003E91A8F97;
	Fri, 18 Jul 2025 07:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752824541; cv=none; b=FIkW0/RtA2zyFNxVt8EmqPQ3ehKbEHPDiFngqmUxpE8qE8al+gB0AgiZ+ChM+u+RM6Wu5lUH3seKfqrG6bIYGlY4CMiIDovuojVrmG0ge5A7sm/xmPpkdh+Xwl2/jprZw1cpPDqi1KMOh8hBut5fB1W/d8bXV+48s0qzc0eqv6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752824541; c=relaxed/simple;
	bh=sxW7GiDWMp9LTC9Kd7bYRbAsSSKwt6hnI/6yrrKG5sI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qu7EXsAKqIs4dD3AFXJ9GZBZDgw54gWiAByAAgIcbnE6XtKKpvcAXnsra7NvOl5lcmqBFxIp/o1RqcrN8/3mmBwhRVr4tGaHKqUQsrazL290NTcJnAIG7qTn+PVScwCNkccfIUUKA6PXwBN41692uHwf4z94vUbVwwZ9XCmrTRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7d9.dynamic.kabel-deutschland.de [95.90.247.217])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E676561E647A7;
	Fri, 18 Jul 2025 09:41:59 +0200 (CEST)
Message-ID: <2cacbbf0-0e7b-410f-9ca1-b4542e0d51d4@molgen.mpg.de>
Date: Fri, 18 Jul 2025 09:41:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_devcd_dump: fix out-of-bounds via
 dev_coredumpv
To: Ivan Pravdin <ipravdin.official@gmail.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
References: <20250717151051.195106-2-ipravdin.official@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250717151051.195106-2-ipravdin.official@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ivan,


Thank you for your patch.

Am 17.07.25 um 17:10 schrieb Ivan Pravdin:
> Currently both dev_coredumpv and skb_put_data in hci_devcd_dump use
> hdev->dump.head. However, dev_coredumpv can free the buffer. From
> dev_coredumpm_timeout documentation, which is used by dev_coredumpv:
> 
>      > Creates a new device coredump for the given device. If a previous one hasn't
>      > been read yet, the new coredump is discarded. The data lifetime is determined
>      > by the device coredump framework and when it is no longer needed the @free
>      > function will be called to free the data.

Should you resend, the lines do not need to be intended, that means the 
 > should be at the very beginning.

> If the data has not been read by the userspace yet, dev_coredumpv will
> discard new buffer, freeing hdev->dump.head. This leads to
> vmalloc-out-of-bounds error when skb_put_data tries to access
> hdev->dump.head.
> 
> A crash report from syzbot illustrates this:
> 
>      ==================================================================
>      BUG: KASAN: vmalloc-out-of-bounds in skb_put_data
>      include/linux/skbuff.h:2752 [inline]
>      BUG: KASAN: vmalloc-out-of-bounds in hci_devcd_dump+0x142/0x240
>      net/bluetooth/coredump.c:258
>      Read of size 140 at addr ffffc90004ed5000 by task kworker/u9:2/5844
> 
>      CPU: 1 UID: 0 PID: 5844 Comm: kworker/u9:2 Not tainted
>      6.14.0-syzkaller-10892-g4e82c87058f4 #0 PREEMPT(full)
>      Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>      Google 02/12/2025
>      Workqueue: hci0 hci_devcd_timeout
>      Call Trace:
>       <TASK>
>       __dump_stack lib/dump_stack.c:94 [inline]
>       dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>       print_address_description mm/kasan/report.c:408 [inline]
>       print_report+0xc3/0x670 mm/kasan/report.c:521
>       kasan_report+0xe0/0x110 mm/kasan/report.c:634
>       check_region_inline mm/kasan/generic.c:183 [inline]
>       kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
>       __asan_memcpy+0x23/0x60 mm/kasan/shadow.c:105
>       skb_put_data include/linux/skbuff.h:2752 [inline]
>       hci_devcd_dump+0x142/0x240 net/bluetooth/coredump.c:258
>       hci_devcd_timeout+0xb5/0x2e0 net/bluetooth/coredump.c:413
>       process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
>       process_scheduled_works kernel/workqueue.c:3319 [inline]
>       worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
>       kthread+0x3c2/0x780 kernel/kthread.c:464
>       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
>       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>       </TASK>
> 
>      The buggy address ffffc90004ed5000 belongs to a vmalloc virtual mapping
>      Memory state around the buggy address:
>       ffffc90004ed4f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>       ffffc90004ed4f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>      >ffffc90004ed5000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                         ^
>       ffffc90004ed5080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>       ffffc90004ed5100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>      ==================================================================
> 
> To avoid this issue, reorder dev_coredumpv to be called after
> skb_put_data that does not free the data.
> 
> Reported-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ac3c79181f6aecc5120c
> Fixes: b257e02ecc46 ("HCI: coredump: Log devcd dumps into the monitor")
> Tested-by: syzbot+ac3c79181f6aecc5120c@syzkaller.appspotmail.com
> Signed-off-by: Ivan Pravdin <ipravdin.official@gmail.com>
> ---
> 
> Changes since v2:
>   * Updated subject line
>   * Updated comment to include more details about the issue
>   * Moved dev_coredumpv instead of using temporary buffer
> 
> Changes since v1:
>   * Changed subject prefix to Bluetooth:
> 
> [v2] https://lore.kernel.org/linux-bluetooth/20250716003726.124975-2-ipravdin.official@gmail.com/
> [v1] https://lore.kernel.org/linux-bluetooth/20250614041910.219584-1-ipravdin.official@gmail.com/

One minor thing, *v3* is missing in the tag in summary, so it’d be 
[PATCH v3]. `git format-patch -v3` should accomplish this.

>   net/bluetooth/coredump.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/coredump.c b/net/bluetooth/coredump.c
> index 819eacb38762..720cb79adf96 100644
> --- a/net/bluetooth/coredump.c
> +++ b/net/bluetooth/coredump.c
> @@ -249,15 +249,15 @@ static void hci_devcd_dump(struct hci_dev *hdev)
>   
>   	size = hdev->dump.tail - hdev->dump.head;
>   
> -	/* Emit a devcoredump with the available data */
> -	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
> -
>   	/* Send a copy to monitor as a diagnostic packet */
>   	skb = bt_skb_alloc(size, GFP_ATOMIC);
>   	if (skb) {
>   		skb_put_data(skb, hdev->dump.head, size);
>   		hci_recv_diag(hdev, skb);
>   	}
> +
> +	/* Emit a devcoredump with the available data */
> +	dev_coredumpv(&hdev->dev, hdev->dump.head, size, GFP_KERNEL);
>   }
>   
>   static void hci_devcd_handle_pkt_complete(struct hci_dev *hdev,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
