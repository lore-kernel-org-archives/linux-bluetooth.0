Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E3187339;
	Mon, 17 Jun 2024 07:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718608496; cv=none; b=kmbVy9J/rfCaHDiq6XbMK6h256fBU6IO/F4cIxSKPJMdbpJ6lRUM/tb2KV4m75Ruy8II97PTHw5zXxeur4h+shue15NGFIB1YkVzsQGfrLyy8e4CJEv2lSYDHvCK+IymsoYPwLYuLYCG8cYegaJEDB6l49n4omsKDqzc7IZoF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718608496; c=relaxed/simple;
	bh=RZ1n7wu/VvC4kGOxlwpcl7vWJ5w1T72u7IRgjXNV3Ik=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pC67sw9MqUw/zrQQFYOYl1muEaC2OzlryEE04OCKSvZgEKvvEWJWU8TI7KJyGI7NZk4zSpSErV06dhU6MyOyWDdr50g3vH14PtJ/TT+4cTDAe97syu44Tvx7ccUMJMPSN7EvipjRR5BhpoNOIaUgSPo2eYbrjtr7nhUUj+5dBz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.53] (ip5f5aeabd.dynamic.kabel-deutschland.de [95.90.234.189])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E1DC461E5FE07;
	Mon, 17 Jun 2024 09:14:39 +0200 (CEST)
Message-ID: <80ca0fd6-b666-4e84-a3eb-d3f6d9bfdc05@molgen.mpg.de>
Date: Mon, 17 Jun 2024 09:14:39 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_qca: Increase settling time for
 baudrate change VSC
To: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, quic_mohamull@quicinc.com,
 quic_hbandi@quicinc.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240617070039.30824-1-quic_janathot@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240617070039.30824-1-quic_janathot@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Janaki,


Thank you for your patch. Please be more specific in the summary/title:

> Increase settling time for baudrate change VSC to 30 ms


Am 17.06.24 um 09:00 schrieb Janaki Ramaiah Thota:
> This change is done to align the settling time and
> synchronization for baudrate VSC for WCN6750.
> 
> In logging disabled builds and few devices
> baudrate change and flow control is taking time
> so increasing the wait time to controller and uart
> to handle baudrate change request properly.

Is the 30 ms documented in some datasheet?

Please use 75 characters per line.

Please document the test system.

> Signed-off-by: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> ---
>   drivers/bluetooth/hci_qca.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0c9c9ee56592..667687835306 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1356,12 +1356,15 @@ static int qca_set_baudrate(struct hci_dev *hdev, uint8_t baudrate)
>   	case QCA_WCN3990:
>   	case QCA_WCN3991:
>   	case QCA_WCN3998:
> -	case QCA_WCN6750:
>   	case QCA_WCN6855:
>   	case QCA_WCN7850:
>   		usleep_range(1000, 10000);
>   		break;
>   
> +	case QCA_WCN6750:
> +		msleep(30);

Why not usleep_range?

> +		break;
> +
>   	default:
>   		msleep(300);
>   	}


Kind regards,

Paul
