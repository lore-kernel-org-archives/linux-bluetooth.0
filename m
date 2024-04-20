Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79819D51C
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611250; cv=none; b=C6kW1NtAHU/O/FKCfdxgtNzIKHtheNu8NLR2ginAKMrsgIgc80o0LKbJijdigOTotsAlYvbgZNpcTkPyt0yvGeuINSyOyI3ne9BVvyZEGemZvwNVcR7Gk/jyhmbSGNLRJqzImKmd45j61tqdp8oXyFUNW95Imm3M//zyzNv42OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611250; c=relaxed/simple;
	bh=dcW6W541cjLlLnbUpd3lLRGLVMDIgEMRWZZlYdifHNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mK0Ti+MoB3JR1n4jprLARbPvM7Bme3UFTLv/DcUr5bxdU811hvCQMK+s/vN8thV+4ejQlhAw1hmNlo14ONcLSK1lR+oAALCNwncNR1ol7oIexOaYXPBv7zcHK7pZ5djpiGKFeT4l/HzmQ1ap8uTHqmKUMZPkSVYZM95vD9CUIVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qx9hY8dl; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qx9hY8dl"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2dd19c29c41so4634521fa.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 04:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713611247; x=1714216047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=70EAjH1mEPJsSZtzQGTYG3z9ROiGq6xc+NqESZ9kKzE=;
        b=Qx9hY8dlToW+VcoJp/6/mek+VrCyhnVm48QqhpNtfFqUUdUEUNbuaflj39knNMAlKx
         7ZTsvQ8OL9A8ppP6sI4NoFY1ZTozNUlaoRdDtHjbvqnLwwaxapjHnDHBhPo7W7KxI7+o
         SPcTIjnI4cNcddiKaUAs3D3aLbRiXuGvGWdwBuQlTcBEhhBsewasPpiCf0fr9336fwAs
         B2xKPRvI67FAHgtNy/YSgeEA+oz/d5ovMugiLu4LZrbFUzDoZPsVU9MUpdhVeVqknInr
         06IUbL0qr/o1NRU9iWx1KC/wnRLSVNcqIyo7ESYMB4GyviVwAMZdienhPkdlsqFQFtE7
         sy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713611247; x=1714216047;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70EAjH1mEPJsSZtzQGTYG3z9ROiGq6xc+NqESZ9kKzE=;
        b=hX6ngTEd3n/97WBa3hHKW3iFx3IYCL1KS0P7rLysqtP3klKkUUNpscToCCx2WV+yLt
         BLE3SwRwARltq03DqMIdRW1QHmdqY+8R2Ao8vKz607Db7v3yki9fZDDEwMudxyh3eW6U
         gBUofKRyxvjoVyOOLYPEpvyRIgEGjHI/QToU03cTUvQc2oBmoFb7k6Rk9A8YBrnGtWLo
         uIy5Dq9pouK77pXCCOmLAoKSIDhpxhl6hBLDIUzgnlV4IprUVhNaeOzHySYjAkGc29i+
         VY8tP+slZJwrDfaeNqS13pR8yEudB+cJI1H53+xRv+Yd7Njk4yfW43Rl7atw6f8jonRo
         nIpw==
X-Gm-Message-State: AOJu0YxeyIYRDP9s8lMS7MI9u5UBL/6G3YcESrH2PFVn59I7uUZwwmrB
	pwCUg6Pbn3ALSwfpIYJAaZZcWrCbXTs3O68REm12pt3cgt6j3WTk0mkseGUwk1YuZa81qbrTkNm
	/W0J2oA==
X-Google-Smtp-Source: AGHT+IGUMfG4KUYlOGX63zoLLlLm/XtH1SiAn+er2ONxrMOw/cBMDGkbS1h/wRyR8lDLFq9gu2NOPA==
X-Received: by 2002:a05:651c:622:b0:2d8:5fb1:4b80 with SMTP id k34-20020a05651c062200b002d85fb14b80mr2619187lje.24.1713611246615;
        Sat, 20 Apr 2024 04:07:26 -0700 (PDT)
Received: from [10.236.36.88] ([88.128.88.151])
        by smtp.gmail.com with ESMTPSA id bg5-20020a05600c3c8500b00419f419236fsm1433804wmb.41.2024.04.20.04.07.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 04:07:26 -0700 (PDT)
Message-ID: <63772c3f-eab7-4be0-8b1c-0cebea361eae@linaro.org>
Date: Sat, 20 Apr 2024 13:07:25 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390 after disable then warm reboot
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-3-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1713564212-21725-3-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2024 00:03, Zijun Hu wrote:
> From: Zijun Hu <zijuhu@qti.qualcomm.com>
> 
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.

Please mention if QCA6390 requires reset pin, according to datasheet or
some hardware guideline.

> 
> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled.
> 
> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Signed-off-by: Zijun Hu <zijuhu@qti.qualcomm.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
>  drivers/bluetooth/hci_qca.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 0934e74112a6..3f5173f1180b 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2438,13 +2438,12 @@ static void qca_serdev_shutdown(struct device *dev)
>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>  	struct hci_uart *hu = &qcadev->serdev_hu;
>  	struct hci_dev *hdev = hu->hdev;
> -	struct qca_data *qca = hu->priv;
>  	const u8 ibs_wake_cmd[] = { 0xFD };
>  	const u8 edl_reset_soc_cmd[] = { 0x01, 0x00, 0xFC, 0x01, 0x05 };
>  
>  	if (qcadev->btsoc_type == QCA_QCA6390) {
> -		if (test_bit(QCA_BT_OFF, &qca->flags) ||
> -		    !test_bit(HCI_RUNNING, &hdev->flags))
> +		if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks) ||
> +		    hci_dev_test_flag(hdev, HCI_SETUP))
>  			return;

I am sorry, but why do we need to perform shutdown procedure now if
device is off?

I raised questions about this and I still don't understand. Not much got
better comparing to previous version. Actually, I have no clue what
changed. Where is the changelog?


Best regards,
Krzysztof

