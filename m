Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27F21BC3F;
	Sat,  9 Nov 2024 13:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731157513; cv=none; b=Q6YjJWkLdJMXm/rPlcpeWtG9PhgnQCakw4BKqSODz61HD432TVnGexV601D+s2ongO+nAGYD2slFLmZ+6mkvXFi1SSBOZ0DKRB5xsADCKkBnSvBhznFvvOnl4UrjAgMupRRRQkfEPr4Y9/K6HkBVsLpFO0LHTvEU2SLgJT0L4+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731157513; c=relaxed/simple;
	bh=LKxGa3hdSJuN63xV7vt+/MAZaNUkVNGNJZk7eugYXAI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oj9qqqwxM19w2p6NDWjR5YogVVEafz/ILuIMQRGX8mR/2JzHlct4IjgF2I6UCDqbB5E8JjWpQYi+jUZQ5N1LagKNwhVCiQn5xl0wiE8VLNZZS/WGF5Txr/wLrwZO6O5rp7Dr7XhvnPTCxzc5rnp5vnsA0onz/UmyafIAyJJs/cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.44.133] (unknown [185.238.219.89])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 25FBF600AA6A5;
	Sat, 09 Nov 2024 14:04:28 +0100 (CET)
Message-ID: <ce8cfe47-a442-4296-a317-2f4a04bf6b1e@molgen.mpg.de>
Date: Sat, 9 Nov 2024 14:04:27 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tty: rfcomm: use sysfs_emit() instead of sprintf()
To: zhangheng@kylinos.cn
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 erick.archer@outlook.com, kees@kernel.org, geert@linux-m68k.org,
 jirislaby@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241109091748.4037589-1-zhangheng@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241109091748.4037589-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear zhangheng,


Thank you for your patch.

Am 09.11.24 um 10:17 schrieb zhangheng:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: zhangheng <zhangheng@kylinos.cn>

Currently your username is used. Could it be Zhang Heng?

     $ git config --global user.name "Zhang Heng"
     $ git commit --amend --author="Zhang Heng <zhangheng@kylinos.cn>"

> ---
>   net/bluetooth/rfcomm/tty.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
> index af80d599c337..21a5b5535ebc 100644
> --- a/net/bluetooth/rfcomm/tty.c
> +++ b/net/bluetooth/rfcomm/tty.c
> @@ -201,14 +201,14 @@ static ssize_t address_show(struct device *tty_dev,
>   			    struct device_attribute *attr, char *buf)
>   {
>   	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
> -	return sprintf(buf, "%pMR\n", &dev->dst);
> +	return sysfs_emit(buf, "%pMR\n", &dev->dst);
>   }
>   
>   static ssize_t channel_show(struct device *tty_dev,
>   			    struct device_attribute *attr, char *buf)
>   {
>   	struct rfcomm_dev *dev = dev_get_drvdata(tty_dev);
> -	return sprintf(buf, "%d\n", dev->channel);
> +	return sysfs_emit(buf, "%d\n", dev->channel);
>   }
>   
>   static DEVICE_ATTR_RO(address);

With the nit above addressed:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
