Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BDA2F3B;
	Thu, 27 Mar 2025 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743112382; cv=none; b=ef8bjoUF+PYOAuGAgzywooalHCzET780Fdk1DzRgV7GHCbBORW5cEgZSFT+/Y89IBVifX395wXreh8CgTQi6O5PTO3hmD4EpjxlfpoUsbLJ+7zjb1+hKR3MaUqBwS1lSYsOIcDWouBEcAXdpPrMbxGljvsabM49GWQeMRfnxA9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743112382; c=relaxed/simple;
	bh=KBnop0w+7+a9jo39keEqcTQiAqz01WBb3d4caXU8iQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lv8KAWdXxgVPKlhx5uXjKb5fQ09dkDrrpSFMK9l68+jijyhlNk8d2LCG6UQ8QJeUvQzvf0NyuHA0a4ve7a2kaurCPJ94DU8Kci5cMH77gz9wZxo8WjRAyKrxqcfkU5GYsJwXbLJ86TwkLZpqkHmY5u5KgJGRKy4VQyRc812buic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2c5.dynamic.kabel-deutschland.de [95.90.242.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8C63E61CCD89C;
	Thu, 27 Mar 2025 22:52:43 +0100 (CET)
Message-ID: <87092878-9296-4609-b744-a6e914316e52@molgen.mpg.de>
Date: Thu, 27 Mar 2025 22:52:42 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Bluetooth: btnxpuart: Add msleep() after changing
 the baudrate
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com
References: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250327182523.524534-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Neeraj,


Thank you for your patch. For the summary/title, I suggest:

Sleep 100 ms after baud rate change

Am 27.03.25 um 19:25 schrieb Neeraj Sanjay Kale:
> This adds a 100 millisec sleep after change baudrate vendor command.
> 
> It is observed that when the baudrate change command changes the
> baudrate from 3000000 to 115200, any immediate HCI command returns an
> error -22 (Device Busy).

Really 3 million?

Is this happening with every change, or only decreasing the baud rate 
with the values you listed?

> Adding a small delay after the change baudrate command complete event is
> received helps fix the issue.

100 ms is not small to me. Is this issue documented in the hardware 
documentation? Are there other ways like polling, if the command succeeded?

> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>   drivers/bluetooth/btnxpuart.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 5091dea762a0..e26fabe8fb3d 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1238,6 +1238,8 @@ static int nxp_set_baudrate_cmd(struct hci_dev *hdev, void *data)
>   		if (*status == 0) {
>   			serdev_device_set_baudrate(nxpdev->serdev, nxpdev->new_baudrate);
>   			nxpdev->current_baudrate = nxpdev->new_baudrate;
> +			/* Allow sufficiant time for chip to switch to new baudrate */

Please add the datasheet section.
sufficient

> +			sleep(100);
>   		}
>   		bt_dev_dbg(hdev, "Set baudrate response: status=%d, baudrate=%d",
>   			   *status, nxpdev->new_baudrate);


Kind regards,

Paul
