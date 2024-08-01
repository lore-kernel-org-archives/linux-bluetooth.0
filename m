Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B88157493;
	Thu,  1 Aug 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497391; cv=none; b=gOhUTayhzE/Aucy5ADZmaa/YAerNCVv0B9timpvwG9cOtTHDUGtPolTxwYMSI1flGhN7F6uqE0tKo4WOR6+jUfPbw8GV5XbI3rU3w50dq60hvXTbLQMrYOV7GIGPW3VLFqgJFquc/IMXgQxKHGvTsOPlmujnVSO8Mtf3DonZ9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497391; c=relaxed/simple;
	bh=vDhDWbVNvxYlSuCobtMzLxfA3p1ASpgV4ZueA+jhonA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tCrKMl4JFIv72vIzxjmubem8jTjjUjfRQpNMFsI/N2uDroO6H6yBpG2BZ2cp51xUibuIG8HcoIdM66vt3t3rfUO59Kl41k2NDz3FXpoRKtTU+U7fs3KYqqNhcIYsmTA/9he3VKrXoOQFaARrjJ46fdwwm66OcPr/VhcB13HZjg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.3] (ip5f5af11f.dynamic.kabel-deutschland.de [95.90.241.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2601961E5FE01;
	Thu,  1 Aug 2024 09:29:17 +0200 (CEST)
Message-ID: <07a6df7e-b1f6-4de6-bb54-a18966efc26c@molgen.mpg.de>
Date: Thu, 1 Aug 2024 09:29:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Bluetooth: hci_qca: fix QCA6390 support on non-DT
 platforms
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Wren Turkal <wt@penguintechs.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240731-hci_qca_fixes-v1-2-59dad830b243@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bartosz,


Thank you for the patch.

Am 31.07.24 um 17:20 schrieb Bartosz Golaszewski:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> QCA6390 can albo be used on non-DT systems so we must not make the power

al*s*o

> sequencing the only option. Check if the serdev device consumes an OF
> node. If so: honor the new contract as per the DT bindings. If not: fall
> back to the previous behavior by falling through to the existing
> default label.
> 
> Fixes: 9a15ce685706 ("Bluetooth: qca: use the power sequencer for QCA6390")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://lore.kernel.org/linux-bluetooth/27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org/
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/bluetooth/hci_qca.c | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index a20dd5015346..2baed7d0f479 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2412,11 +2412,14 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>   		break;
>   
>   	case QCA_QCA6390:
> -		qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
> -							   "bluetooth");
> -		if (IS_ERR(qcadev->bt_power->pwrseq))
> -			return PTR_ERR(qcadev->bt_power->pwrseq);
> -		break;
> +		if (dev_of_node(&serdev->dev)) {
> +			qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->dev,
> +								   "bluetooth");
> +			if (IS_ERR(qcadev->bt_power->pwrseq))
> +				return PTR_ERR(qcadev->bt_power->pwrseq);
> +			break;
> +		}
> +		fallthrough;
>   
>   	default:
>   		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
