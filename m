Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=141.14.17.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962696;
	b=m7/BedtoU/NXC8qIw1fJLE/cp0BfMS1Qq95wGwrVAuOAOerHZMoJBQ32R0oGkz5+YINb
	 Zqo0yekgyiGhhccS2OtD5blvzL8R7MnsK/vaEzqHIlj2qo24qPc5TGQcvxdf+kQRn/Pl8
	 /gDJ8iK2f+SpbCP+CnponjjUl37LLvoG3/SWDBqTdo2LYV/dSotZY+hmuMseky770mUzz
	 rataPUSMQyOCESeRlRo0gqfwer/+JiDPcEbf7aMy4Y66qsBZlbUGpp2LhFbYjVM42wtKX
	 2U5OeldO2fvo8fwzINNAhDHkbrvgXlvuv8bOO9lH4EuofEvZ7U1FZ7E7Hut83zdruWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962696;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:DKIM-Signature;
	bh=SigG/up2gMWRUySXAnA/Afal/pPumps4/i8yYtBo2BY=;
	b=t6v7jYZc2LYgOqE0Rt6qlrwFVHntM+IOuYCkznsfXYN4BaIaM6FrZzd1KnYkUeHb1CNo
	 dyemWrwE8Zi/Rg2hZKgtsA0EFGfbM42G5WIm8+qq9n/CNcmQflfs+a3lawkm83lpmzKOK
	 9hndtWmFsyJi5MOPApKPF1qLIj/+fAn+DoNKsJhW90W1oD/UeYxN2VUQOocfWUeoxmNDd
	 ZQNe4l0+f7eTrerKAvkYA8e3oK4T/ms3A/+Y5406BDHGYuPicdvYlyv5KiAoE1BYeFwR6
	 8byRTr6k/pSO9e7mGb+VDUEUCjAEPdUaP/npVpC7NECGC1vZfhfeil1KRTZ9hpjBx4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=molgen.mpg.de;
	spf=pass smtp.mailfrom=molgen.mpg.de;
	dkim=pass header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=gqugLq4D;
	arc=none smtp.remote-ip=141.14.17.11
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC56606A326;
	Fri,  6 Nov 2026 10:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CC56606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=molgen.mpg.de header.i=@molgen.mpg.de header.a=rsa-sha256 header.s=20260906 header.b=gqugLq4D
Received: from [192.168.0.5] (ip-095-090-245-054.vkd79.pools.vodafone-ip.de [95.90.245.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D8FC64C2F3FFE7;
	Fri, 06 Nov 2026 11:57:42 +0100 (CET)
Message-ID: <56866622-a854-4aae-9e97-40eecc4adbe1@molgen.mpg.de>
Date: Fri, 6 Nov 2026 11:57:41 +0100
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: Disable SoC debug logging for WCN3990
To: Hex Lindqvist <hex@freenixos.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261105201952.1556185-1-hex@freenixos.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20261105201952.1556185-1-hex@freenixos.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=molgen.mpg.de; s=20260906; 
	t=1793962663; 
	h=from:from:subject:date:message-id:mime-version:content-type:content-transfer-encoding; 
	bh=SigG/up2gMWRUySXAnA/Afal/pPumps4/i8yYtBo2BY=; 
	b=gqugLq4D1JCEXa6fBfbmfyeBVO3p0y0uVSIa8cPMj3DKqWuZrgkFrWkLPtFWeTcXzOGHtSShm3w4
	FrksYy49XTzE1VVP5Ws0U5Re5MUu6Zc7MrThLQcWIw1soIFk899Ztt8+ogNw+VEK9kB6ozFRO0egx/
	z0OGdzhDRL/skemdipB81xasrakPlBvay4cDEip0vchA6W4dFfQDC1fBDYLNYqX0WVxUPlJ4PLNnu8
	wezlFPs2BtGdwRODLZ4QBzM0j49Ju770sC6GQyJG3iswu5cqB6ZWYmNB8yLg3HDgNqmb/OOI6aN7/h
	H5t/9pd+OHiM0hUMnDbvzfe24RBQb57Q==

Dear Hex,


Thank you for your patch.

Am 05.11.26 um 21:19 schrieb Hex Lindqvist:
> Unless the host turns it off, the WCN3990 firmware sends debug logs to
> the host as ACL packets on handle 0x2EDC. hci_qca passes them on as
> diagnostic packets, which the core copies to the monitor socket and then
> frees. On a OnePlus 6T (SoC version 0x40010214, ROM version 0x0201) that
> is a packet of about 490 bytes every seven seconds on average, for as
> long as the controller is up.

Does Linux log anything about this? Maybe, also paste an excerpt from 
btmon capture?

> The driver already turns this logging off after the firmware download
> for WCN3950 and WCN3991. Do the same for WCN3990.
> 
> Tested on a OnePlus 6T. With the crbtfw21.tlv rampatch from the OnePlus
> firmware, no diagnostic packets arrive any more. The controller also
> accepts the command with the crbtfw21.tlv from linux-firmware.

Both firmware file names are the same. What is the difference?

> An AI assistant helped find and test this change and drafted this
> message.
> 
> Signed-off-by: Hex Lindqvist <hex@freenixos.com>
> ---
> 
> Notes:
>      Test details (OnePlus 6T, crnv21.bin from the OnePlus firmware, counts
>      from btmon):
>      
>      - v7.2.10 with the postmarketOS sdm845 patches, OnePlus crbtfw21.tlv:
>        87 diagnostic packets in a ten-minute capture started a minute after
>        boot without this patch, none with it.
>      - bluetooth-next (31333770a468), same firmware, btmon from boot: 42 in
>        the first seven minutes without this patch, none with it; the command
>        succeeded at every setup. Plain bluetooth-next hangs this phone after
>        about seven minutes with or without this patch, hence the shorter
>        window.
>      - v7.2.10 with linux-firmware's crbtfw21.tlv (its only WCN3990
>        rampatch): the controller returns success for the command (btmon
>        during setup; not a ten-minute run).
>      
>      Not tested on other WCN3990 boards.
> 
>   drivers/bluetooth/btqca.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index 60735b70d89a..1db2cc626def 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -944,6 +944,7 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
>   	case QCA_QCA2066:
>   	case QCA_QCA6390:
>   	case QCA_WCN3950:
> +	case QCA_WCN3990:
>   	case QCA_WCN3991:
>   	case QCA_WCN6750:
>   	case QCA_WCN6855:

The diff looks good.

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
