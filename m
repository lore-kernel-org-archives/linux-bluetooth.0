Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8D80034;
	Sun, 26 Jan 2025 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737878543; cv=none; b=HUJfnTQ56zSdAEXxG3JA0prj5Ihv9/DLMUA2W0Jg7AYQop39R33aaIFU/Aplc3N065HBsbJ1mDTVF/vssz6lCDg7JSXyDijPhldPbNhkQB7Wlwfc2zmDs7I0oEK/lMS+LVyCEoTyGMzS0x3q1hSuPgWYVx9ugOK8fuPaxat+ukk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737878543; c=relaxed/simple;
	bh=KD67eV+Nr4O+dOfjL1y0vlP9bdimj/Esw1un6yn88pI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xe1NhTnSw7ZNT0mKwFU8rY5RS596c8vFisF/4mq2wsNgiUXpFXvPw4WHbZrw0UO1iDxO8Xcw3QrM5wE5j1jpBbQlzAbfc+VkcvaMwuGW+EWhL5fH7ipjnq4boSsGidBfrom7hfS//UG9bWHEEEsajZUJ18Det6kb8OA0vPAcXM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aef0b.dynamic.kabel-deutschland.de [95.90.239.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C2AFA61E64788;
	Sun, 26 Jan 2025 09:02:06 +0100 (CET)
Message-ID: <62d9db39-5d2b-4980-99e5-f15c4555b57f@molgen.mpg.de>
Date: Sun, 26 Jan 2025 09:02:04 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: Unnecessary braces around single line
 statment.
To: Jeremy Clifton <deaner92@yahoo.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250125165804.11486-1-deaner92.ref@yahoo.com>
 <20250125165804.11486-1-deaner92@yahoo.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250125165804.11486-1-deaner92@yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Jeremy,


Thank you for your patch. Could you please make the summary/title a 
statement, and remove the dot/period at the end:

Bluetooth: Remove unnecessary braces around single line statement

Am 25.01.25 um 17:58 schrieb deaner92@yahoo.com:
> From: Jeremy Clifton <deaner92@yahoo.com>
> 
> Warning found with checkpatch.pl script. Removed unnecessary braces.

I’d use imperative mood for the second sentence:

Remove unnecessary braces.

Also please add a Fixes: tag.

> Signed-off-by: Jeremy Clifton <deaner92@yahoo.com>
> ---
>   drivers/bluetooth/bfusb.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
> index cab93935cc7f..0d6ad50da046 100644
> --- a/drivers/bluetooth/bfusb.c
> +++ b/drivers/bluetooth/bfusb.c
> @@ -365,9 +365,8 @@ static void bfusb_rx_complete(struct urb *urb)
>   			buf   += 3;
>   		}
>   
> -		if (count < len) {
> +		if (count < len)
>   			bt_dev_err(data->hdev, "block extends over URB buffer ranges");
> -		}
>   
>   		if ((hdr & 0xe1) == 0xc1)
>   			bfusb_recv_block(data, hdr, buf, len);

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
