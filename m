Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC6242AA9;
	Sun, 15 Mar 2026 08:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773564911; cv=none; b=EVWNvXkV3zcDsP+pXkeV0Whn5F+F1jCfdx6VQDAx59/6mdnD/rHavgtIVVkE6TuU1zw1ajt4gJGXHMzn0+LYYGCwCth4Y59xGWLe6UuwibV5nYqqsfQyu2vB969DfNEhbIlGnAtzoaUH8wUMiRW6HIgkyo2x2fWeKvqvzMG7mmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773564911; c=relaxed/simple;
	bh=zn3KlHyFdAknB5/S3ls/UD0l1//k/0O5yVZi2Pdcwik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J1u91JfgdSeJL9NS2YSX28JiyY6ZKTlDlzw/q0wizHk5txhIGxuzSJlU6q4u4JFkfp2x8BCfmxDhHmi5ihNgCz+Ibk3rtrQJGo1rSih/qA5Qs+uV3vA+iJYvEGuxNLoBIjfwRRSWyD2yTOHnWaSdwgiTXQQeMnjxQb/MQ5f15/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.229] (p5dc55063.dip0.t-ipconnect.de [93.197.80.99])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 641224C443104E;
	Sun, 15 Mar 2026 09:54:55 +0100 (CET)
Message-ID: <d735e9fc-4b77-4880-95ae-12f2a00b23a9@molgen.mpg.de>
Date: Sun, 15 Mar 2026 09:54:54 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: hci_ll: Fix firmware leak on error path
To: Anas Iqbal <mohd.abd.6602@gmail.com>
Cc: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
References: <20260314165639.180559-1-mohd.abd.6602@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260314165639.180559-1-mohd.abd.6602@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Anas,


Thank you for your patch.

Am 14.03.26 um 17:56 schrieb Anas Iqbal:
> Smatch reports:
> drivers/bluetooth/hci_ll.c:587 download_firmware() warn:
> 'fw' from request_firmware() not released on lines: 544.
> 
> In download_firmware(), if request_firmware() succeeds but the returned
> firmware has no data or size, the function returns immediately without
> releasing the firmware, resulting in a resource leak.
> 
> Add a release_firmware() call before returning when request_firmware()
> succeeds but the firmware contents are invalid.

Change to *content is*.

> Signed-off-by: Anas Iqbal <mohd.abd.6602@gmail.com>

Please also add a Fixes: tag.

> ---
>   drivers/bluetooth/hci_ll.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/hci_ll.c b/drivers/bluetooth/hci_ll.c
> index 91acf24f1ef5..91c96ad12342 100644
> --- a/drivers/bluetooth/hci_ll.c
> +++ b/drivers/bluetooth/hci_ll.c
> @@ -541,6 +541,8 @@ static int download_firmware(struct ll_device *lldev)
>   	if (err || !fw->data || !fw->size) {
>   		bt_dev_err(lldev->hu.hdev, "request_firmware failed(errno %d) for %s",
>   			   err, bts_scr_name);
> +		if (!err)
> +			release_firmware(fw);
>   		return -EINVAL;
>   	}
>   	ptr = (void *)fw->data;

With the improved commit message, feel free to add:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
