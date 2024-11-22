Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6696B1386D1;
	Fri, 22 Nov 2024 12:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279194; cv=none; b=Ov0ZNsxMf8IRj0953zuz/vzAvWLFil5FDNSJRcGp+dD3T9/hf3z1id65eQHeNm7X/RAkSQdBObbiwpTjRDwCSpWznF0CxhdrDStGPN0eKiviq9mCEbkC477mgGUUNEzyTGG1g1FwbeHOjsc18VG1ee1ep+QZ2TjqQ19kH6qMD+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279194; c=relaxed/simple;
	bh=c66N3H3o4YHPm9fRMVCWFsvZ0TuP6FIx04Su66WqV2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WgtpHZEPpebDtut05aN/jb1YJBPaEAPQIoFaoSxSVrAiajLJZt2giCAz1B55PPtZ0grCpEo5jMPc0xjPD2btESj516Ukk2wK0tURdvdAQje79Zbr7jxtWRc8QGNk/L9OJOyOWNQ8GQMEyXmb3Y3DtVDfNZr0LsQnKnBcN5MCV3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aed53.dynamic.kabel-deutschland.de [95.90.237.83])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7BF8C61E5FE05;
	Fri, 22 Nov 2024 13:39:16 +0100 (CET)
Message-ID: <88cfa1e8-3e1f-4670-a8b5-0066079fc29a@molgen.mpg.de>
Date: Fri, 22 Nov 2024 13:39:15 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty: rfcomm: use sysfs_emit() instead of sprintf()
To: zhangheng@kylinos.cn
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 erick.archer@outlook.com, kees@kernel.org, geert@linux-m68k.org,
 jirislaby@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20241122111939.3799277-1-zhangheng@kylinos.cn>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241122111939.3799277-1-zhangheng@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Zhangheng,


Thank you for your patch.

Am 22.11.24 um 12:19 schrieb zhangheng:
> Follow the advice in Documentation/filesystems/sysfs.rst:
> show() should only use sysfs_emit() or sysfs_emit_at() when formatting
> the value to be returned to user space.
> 
> Signed-off-by: zhangheng <zhangheng@kylinos.cn>

Is zhangheng the official spelling of your name? If not, please update.

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


Kind regards,

Paul
