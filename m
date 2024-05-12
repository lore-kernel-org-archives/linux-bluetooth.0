Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D0200C1;
	Sun, 12 May 2024 12:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715518513; cv=none; b=IEKq+bZ8n84FkCH4WNc0RPzggQePz7xUXgMbOkiQVf4+dZhafraSkxoBQWvqPVXXVzUbc6m0BzsiAIXNbcZWXiulxzwHEO6KUcwhCvHjYJ2kR06V4ih97n/+CLZSefcdsaOeIxVC3WXwdK9/L/UMGOnD5DuqRRsNRmaA60fJOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715518513; c=relaxed/simple;
	bh=mIt63qw212cpAShNPP9LQYJ12C7+kTwiUZQ8TsN9/Jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H2XSSnhWniNnfaZZ+VpWT+5FeFv0aWhMut3c6gBSj7iFom752ow0MJTR4TRGfmXz2PNngyDxvw762NPOIrNxJSuFmI0lxojioT72iDyAWFqkGzXrqt4SjcRQyeQm2u8a+EyDgQi2LeiFCipE3ZlgSrtuMlumRQjRtaxWsb+enxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=pYi6gSZT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="pYi6gSZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1715518485; x=1716123285; i=wahrenst@gmx.net;
	bh=65uydMKsXwdgGvElxFGsQ1IHZwcsbe/Z1F22WVwwxT0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=pYi6gSZTWWr2qGxXXW2TzarxCiS/2CI3jUqS5o3E/cceGdSdyem4AlUKrrxklPyz
	 mVkOtv/8mrzQdn8V+m13DX0IAHnt6UYmYSzQ3MH1NulJR3ONJRdNRGaoCPmVvmMpE
	 rEST+QqmDTRIU8ulpdB8ULhPt+/TdP0df20Fb4i4kruY6XGsTyKds/OQcfOuDti8c
	 ugZfWfZAeP2U3n+Ls9GkY9AqB4VWat1ANsmUsee9ThmgdoYk5z0drXTD+Sqvp9ELZ
	 zrl9rX4B8Aq0jworPAm5cDuAQk8ZqZdOx/BxOXZ8fyRoVD8p8TkhW4/ndA4HmvBJp
	 GYcwUGmhBxGmF6/bZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.126] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5wLZ-1sDXe347L9-007UP2; Sun, 12
 May 2024 14:54:45 +0200
Message-ID: <3ddebd00-4c3e-4b80-88a8-50906e86b6fa@gmx.net>
Date: Sun, 12 May 2024 14:54:42 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm4377: Increase boot timeout
To: sven@svenpeter.dev, Hector Martin <marcan@marcan.st>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240512-btfix-msgid-v1-0-ab1bd938a7f4@svenpeter.dev>
 <20240512-btfix-msgid-v1-1-ab1bd938a7f4@svenpeter.dev>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240512-btfix-msgid-v1-1-ab1bd938a7f4@svenpeter.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:wDNzp1FdFaP8gPWjqAL6qQ4hYViTop2O8vxFQiURhUFUphGZ+9s
 HPLuU49yKlTKVdBFV4x2MT+drPg9BYCn7XTddd6imZEQhnZgSL+sLN2rEJTeAK+yhKw05H8
 zgociRAj2my2NMbTqHoaUlZSpFqes3W+OHFvUlcVzMiwWUUjeH6YtiFjgyeqwAgWC9dL9st
 BLtUecVkhAJDhKi3nyjqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:L5PpRHjVWwU=;MmaKHzK0c2w6z2F2Xbl+MQcS+I+
 t8a6zhJ1uNNpmLKnQysMceeuJvuFZj1dHMMTGCkkD9Js7mqW8uJPTQZN4gGYQTVr3FCi30j3I
 b64NBN8LN4MWqMIwwCilGswYq8AAaEz7Ofaa/Nxq0ZO44pvEafATCHJZOLhwaRhAakDWgskPe
 fRv62VHsVJi+PMLl/2fkXLY3UJvxuHzojmHNOfzWQPyB91o5oL2Nq79896/XWlvHjrhVfBWCn
 b/ATnSBhZ7rk5UQUiI0fRS2NpOb39XvdmzWtW78GKbUaM7Fgt29akObIlNRx1vWrnaF0Jzk58
 R7rZkym18p1AkFXkn1nua3lj5cpFF882dWksMNvnDvU1bwqMwqLbchvp78RDmO8gs4V48ZOTC
 IdokiThSNZ/crKfogDl/AhoEHD3afBYJhkDZtvwtxZ0TlaOA+FcbWWwMqEshUYgpbpHUlcmrE
 tsxxlHBUftwj6ITx+HXvL8TALHAGDPZyJhBozN0mm63K/HCzsEGmI4xQFP6otx6SxveRcv711
 hmC7L0z89gmQ7SCFzVWVCfrswFjnrBlr/5wVdO6GhHrpNghU5SS5lVtwp6oxwnVIpvkTuj43u
 fTyn1+35IvHnOBkf81m1aBUR8rt3nSRBzpWjmQIHc4yoW0EPrir4Eb+mznq9H8CvBcQ4nWwip
 1BUQAPE23BVavG4a/YciN9onBDI+5zO6FKFaW7YRFoVgPbxg5dJnuzCk4hCwSPIYY3M67ClLb
 FgrEXcej523oXrODx6QNAK9uTb1zja/oiAt5P0z2EUxhYKLIGzzFxr1RHFY+jQiMlHqPsL8eV
 hrE5bt/8Ju2SfbgE58zDvVTPBW3sFNNF3e2GKX+lPgWtQ=

Hi Sven,

Am 12.05.24 um 14:12 schrieb Sven Peter via B4 Relay:
> From: Hector Martin <marcan@marcan.st>
>
> BCM4388 takes over 2 seconds to boot, so increase the timeout (and also
> fix the units while we're here).
>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Reviewed-by: Sven Peter <sven@svenpeter.dev>
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>   drivers/bluetooth/hci_bcm4377.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/bluetooth/hci_bcm4377.c b/drivers/bluetooth/hci_bcm=
4377.c
> index 9a7243d5db71..5b818a0e33d6 100644
> --- a/drivers/bluetooth/hci_bcm4377.c
> +++ b/drivers/bluetooth/hci_bcm4377.c
> @@ -32,7 +32,8 @@ enum bcm4377_chip {
>   #define BCM4378_DEVICE_ID 0x5f69
>   #define BCM4387_DEVICE_ID 0x5f71
>
> -#define BCM4377_TIMEOUT 1000
> +#define BCM4377_TIMEOUT msecs_to_jiffies(1000)
this change affect all timeouts not just the boot timeout, so i would
prefer to split this.
> +#define BCM4377_BOOT_TIMEOUT msecs_to_jiffies(5000)
>
>   /*
>    * These devices only support DMA transactions inside a 32bit window
> @@ -1857,7 +1858,7 @@ static int bcm4377_boot(struct bcm4377_data *bcm43=
77)
>   	dev_dbg(&bcm4377->pdev->dev, "waiting for firmware to boot\n");
>
>   	ret =3D wait_for_completion_interruptible_timeout(&bcm4377->event,
> -							BCM4377_TIMEOUT);
> +							BCM4377_BOOT_TIMEOUT);
>   	if (ret =3D=3D 0) {
>   		ret =3D -ETIMEDOUT;
>   		goto out_dma_free;
>

