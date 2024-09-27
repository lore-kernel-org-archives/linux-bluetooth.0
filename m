Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017A815D5C1;
	Fri, 27 Sep 2024 06:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727419747; cv=none; b=ITGxlJs4avNQcNyqCF1HU7MPPB19R+UU5DmXqHUCH8Svcc2irZPs6pm5hWPxKAzTQN7Azu/APtF59/d6Kci5xCoGmP1wgsbuIEzZctqJ0hf4Kar9duZ5ogmi6mqLApCpSihh5wobO8fjewt3p2wzCn3J6xf0MJhiPjF4ihQPNSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727419747; c=relaxed/simple;
	bh=EyQm+Ncbs6BRpLLC0a2IJtD7y3/C59KdCxFZcwgEe7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gG2G8Dj2FmsAvJazGrsUYFqevodTCn8qxPesBue+Ced/hsJz1oRSFD00/mqH7JM2KQ6I24JPC7BWfCB9CE8LorMRWhfpqSQCkmxO1np/I/Q/fdqLMqJMonswegpa+TdQWhl0vvYsN5C/1v/yopa7XRe5flmGB2KdUFCXV/LrPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [172.18.132.162] (ip-185-104-138-57.ptr.icomera.net [185.104.138.57])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7A98561E5FE05;
	Fri, 27 Sep 2024 08:48:21 +0200 (CEST)
Message-ID: <6e333fc5-cd36-4fed-9704-9e3d69633155@molgen.mpg.de>
Date: Fri, 27 Sep 2024 08:48:20 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btrtl: Shorten HCI_OP_RESET timeout
To: Hilda Wu <hildawu@realtek.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, max.chou@realtek.com, kidman@realtek.com,
 howardchung@google.com, apusaka@chromium.org, yinghsu@chromium.org,
 johnlai@google.com
References: <20240927064127.4167789-1-hildawu@realtek.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240927064127.4167789-1-hildawu@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Hilda,


Thank you for your patch.

Am 27.09.24 um 08:41 schrieb Hilda Wu:
> Shorten the timeout for the HCI Reset on shutdown.

Why? It’d be great if you elaborated, and documented how to reproduce 
the problem.

What is the old and new timeout value? For the git commit message 
summary, maybe use:

Bluetooth: btrtl: Decrease HCI_OP_RESET timeout from x ms to y ms

> Signed-off-by: Hilda Wu <hildawu@realtek.com>
> ---
>   drivers/bluetooth/btrtl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 2d95b3ea046d..7128a8a0ba25 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1371,7 +1371,7 @@ int btrtl_shutdown_realtek(struct hci_dev *hdev)
>   	/* According to the vendor driver, BT must be reset on close to avoid
>   	 * firmware crash.
>   	 */
> -	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_INIT_TIMEOUT);
> +	skb = __hci_cmd_sync(hdev, HCI_OP_RESET, 0, NULL, HCI_CMD_TIMEOUT);
>   	if (IS_ERR(skb)) {
>   		ret = PTR_ERR(skb);
>   		bt_dev_err(hdev, "HCI reset during shutdown failed");


Kind regards,

Paul
