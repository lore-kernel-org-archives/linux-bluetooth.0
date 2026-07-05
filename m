Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D28A1E98E3;
	Sun,  5 Jul 2026 09:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783244464; cv=none; b=OetSS4O/e3MeBgJh3tXiBtzcyjyzZ3bp2pyhgY6x4rP1ocFN9RmLARFBTFg5TLwQX6tsn18+1Dd/nsZfGLAzHJvL4ZBKHTF9xopH45bmOHk0RU2ZVwtoF0Xnb67qzu/mes1jK5dIrBcruPlwsvvjEbQtsXEWFNDoN6nAEwZ1dSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783244464; c=relaxed/simple;
	bh=9BIwAT2H0rDSI/lKbvxm2OFan7zA2VrfktjGTwaQUG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YOtxdc+3KQDywdXw97ANFyeqEO7dnRwp3cQdRb9V0LTDERjiKdn8xS+z73is3AUrOb1RAdE6o1MZsj7twX/DK6tTihdGRg0HlZR/nOID7X0U60q9Ba7DBXN0LXR+TODaKAohNElu3jjuzHbd30jUzetz7Z40ZbeQ5eF/Vjcqx1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnZeET97; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnZeET97"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8B51F000E9;
	Sun,  5 Jul 2026 09:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783244463;
	bh=Hdyh5zOFcKcufj1yOBd3EhgY7X7r9MufdMbg4bsq0YA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnZeET97yyxw2QaeXV9SMqVKxwHxV5VTk4VGyY38ExBPj0oFJy+/KYKlUUif4pTgQ
	 6N9nolWBwZffC6kxm+s6HhWRCnoz2XZxXT0ZTSuI/swVSqvKMRzpRvm8+AhP7iG/rM
	 T5jUTcd76hiep6vQBwl9XoM5/WRhXYMHfpCUu/Y/SBLUfeOeapcNTVZ9ej7bV+dinu
	 LrdGiePki+uv9AIRbNV6UGhevdtOUt4MyOOVhfVcGjRNS3icOebUrZ+NVuQ9mpy1OJ
	 0zMek7AWhPwR7zRFS5nBHFXOnD4qZVrY9iRyHXzd2b/YHGlgHgWVyaOVZWeHbl7FZg
	 pOc1CLpzitS4w==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wgJLQ-00000001NIa-3FhT;
	Sun, 05 Jul 2026 11:41:00 +0200
Date: Sun, 5 Jul 2026 11:41:00 +0200
From: Johan Hovold <johan@kernel.org>
To: Xiang Mei <xmei5@asu.edu>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	bestswngs@gmail.com
Subject: Re: [PATCH bluetooth] Bluetooth: qca: fix NVM tag length underflow
 in TLV parser
Message-ID: <akomrM-h521h6M0i@hovoldconsulting.com>
References: <20260704231030.996390-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704231030.996390-1-xmei5@asu.edu>

On Sat, Jul 04, 2026 at 04:10:30PM -0700, Xiang Mei wrote:
> In the TLV_TYPE_NVM branch of qca_tlv_check_data() the tag loop bound is
> "while (idx < length - sizeof(struct tlv_type_nvm))". "length" is a signed
> int from the firmware TLV header and sizeof(struct tlv_type_nvm) is a
> size_t (12), so "length" is converted to size_t and any firmware-supplied
> "length" < 12 makes the subtraction wrap to a huge value.

Yeah, there should have been a lower bound check on length before the
loop.

> The loop body
> then reads a 12-byte struct tlv_type_nvm past the end of the short
> vmalloc'd firmware buffer (and the EDL_TAG_ID_* handlers can write past it).

No, only four bytes are read before the loop exits without any further
consequences due to the following check:

	 if (length < idx + sizeof(struct tlv_type_nvm) + tag_len)
	 	return -EINVAL;

which is false if length < 12.

> Rewrite the bound as "idx + sizeof(struct tlv_type_nvm) <= length"; both
> operands are non-negative, so it no longer underflows and a "length" too
> small for one record correctly skips the loop.

This works too.

>   BUG: KASAN: vmalloc-out-of-bounds in qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421)
>   Read of size 2 at addr ffffc900000e5004 by task kworker/u9:0/52
>   Workqueue: hci0 hci_power_on
>   Call Trace:
>    ...
>    kasan_report (mm/kasan/report.c:595)
>    qca_download_firmware.isra.0 (drivers/bluetooth/btqca.c:421 drivers/bluetooth/btqca.c:617)
>    qca_uart_setup (drivers/bluetooth/btqca.c:948)
>    qca_setup (drivers/bluetooth/hci_qca.c:2029)
>    hci_uart_setup (drivers/bluetooth/hci_ldisc.c:438)
>    hci_dev_open_sync (net/bluetooth/hci_sync.c:5227)
>    hci_power_on (net/bluetooth/hci_core.c:920)
>    process_one_work (kernel/workqueue.c:3322)
>    worker_thread (kernel/workqueue.c:3486)
>    kthread (kernel/kthread.c:436)
>    ret_from_fork (arch/x86/kernel/process.c:158)
>    ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
> 
> Fixes: 2e4edfa1e2bd ("Bluetooth: qca: add missing firmware sanity checks")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/bluetooth/btqca.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 04ebe290bc78..10c496eaea2c 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -415,7 +415,7 @@ static int qca_tlv_check_data(struct hci_dev *hdev,
>  
>  		idx = 0;
>  		data = tlv->data;
> -		while (idx < length - sizeof(struct tlv_type_nvm)) {
> +		while (idx + sizeof(struct tlv_type_nvm) <= length) {
>  			tlv_nvm = (struct tlv_type_nvm *)(data + idx);
>  
>  			tag_id = le16_to_cpu(tlv_nvm->tag_id);

With the commit message fixed you can add my:

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
