Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44441B423B;
	Thu,  9 Oct 2025 07:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759993301; cv=none; b=IBLYUSJ3H0ROCuPMICcs2HmicRsoGCEapfJXxjzI9c9MTK9kVKXRCbsj9gJSqU3FCpMBSLSFmx5TW3zo9k3aCCNNse2KXyrv3tgL3pZBecTOdGsu4+Wf7KMXOs6ExhhOnljvSIRU0zCwiiVLIsiYV8Zg+NZVgUprQfTF8tw65zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759993301; c=relaxed/simple;
	bh=wyXto7zF5l8jpzborrAqVA8LX2KMVMDyUHOgy1rr0Kg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gXM22a3srWRGuYo+llSMtTIL36HijYHyHrFc3+jEVndkVICsn53AKAB78JMQDWTmbO8BqPRKufc7EhQ1MgbwbjeMaEq+TYMr7zKyBmuBqoDnC4b0/SvuB8bFqnI2Rj0szXfw05v4+2T2rVWyWFJe0QvAa5+1xlFddIhpYypEBdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af0f4.dynamic.kabel-deutschland.de [95.90.240.244])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id F3D5D6028F350;
	Thu, 09 Oct 2025 09:01:18 +0200 (CEST)
Message-ID: <572c2a33-18dd-4bf0-8c41-e051d75f481b@molgen.mpg.de>
Date: Thu, 9 Oct 2025 09:01:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Bluetooth: bfusb: Fix buffer over-read in rx
 processing loop
To: Seungjin Bae <eeodqql09@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Kyungtae Kim <Kyungtae.Kim@dartmouth.edu>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, linux-kernel@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <77bde79f-2080-4e40-a013-52b480c0928c@molgen.mpg.de>
 <20251009025701.3756598-2-eeodqql09@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251009025701.3756598-2-eeodqql09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Seungjin,


Thank you for the patch.

Am 09.10.25 um 04:57 schrieb pip-izony:
> From: Seungjin Bae <eeodqql09@gmail.com>
> 
> The bfusb_rx_complete() function parses incoming URB data in a while loop.
> The logic does not sufficiently validate the remaining buffer size(count)
> across loop iterations, which can lead to a buffer over-read.
> 
> For example, with 4-bytes remaining buffer, if the first iteration takes
> the `hdr & 0x4000` branch, 2-bytes are consumed. On the next iteration,
> only 2-bytes remain, but the else branch is trying to access the third
> byte(buf[2]). This causes an out-of-bounds read and a potential kernel
> panic.
> 
> This patch fixes the vulnerability by adding checks to ensure enough
> data remains in the buffer before it is accessed.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Seungjin Bae <eeodqql09@gmail.com>
> ---
>   v1 -> v2: Fixing the error function name
>   v2 -> v3: Addressing feedback from Paul Menzel
> 
>   drivers/bluetooth/bfusb.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index 8df310983bf6..90ca5ab2acc3 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -360,6 +360,12 @@ static void bfusb_rx_complete(struct urb *urb)
>   			count -= 2;
>   			buf   += 2;
>   		} else {
> +			if (count < 3) {
> +				bt_dev_err(data->hdev,
> +				       "block header is too short (count=%d, expected=3)",

Why not: block header count %d < 3 (too short)

> +				       count);
> +				break;
> +			}
>   			len = (buf[2] == 0) ? 256 : buf[2];
>   			count -= 3;
>   			buf   += 3;

Either way:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
