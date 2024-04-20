Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E89DDD9
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611016; cv=none; b=qJ4lYXkeX1mKEOqlYaPVQo55QIgVhpTALKZZr6GDlltg8+Q54Nl7467GmsNbZlateNQ4Mrha/xE/+ctQkTDRikUhbtok4gqW8phTeF9juN4XivTwXW11OvhdvjTruuqhYawOFeRkakb4IHCFvvD9aBiYty0m6rQZ9qD+vR4YWCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611016; c=relaxed/simple;
	bh=eZ3KwASrlmG1An0nP7ZkYz+dOS8Eibail0y+xbE/YLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSy6XB1scTKbeChCVUlaVRl8NOq26gPK3JYTxo/RW/pksaGIKJW+N5IjI5dVzGaEfOSCB2WyBmlFjM2NysN7B2SogLdHRZ8IvFDqhjrVm9A8VuXrmdmRg+u/gjsbbvLLtx4GpcGJg1QjJ2u8xCRaljxhf7T/BUaasMYH6yjxW0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hd5hv+9j; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hd5hv+9j"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-419fc79e4dcso997075e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 04:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713611013; x=1714215813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nafLEb94zEj1OGgZQ3DlqoP/KtaHO508OoUiKE3Uw04=;
        b=hd5hv+9jWpyBLlYFL31Sxklo0jwGCbAIjhqeo/p4A1SnKxvbEaym2XettRssm+nrdD
         ojhqwIix5PPTyuSoeSkd+FN5Yduxahxjmo/Rcb4h6dxn7tIYdmCrRw6Ey7tdsCoL6J3C
         g5L/Z3PrvuSEKGRLYgc4rXNIbQj4+s1mQTfMByE30kXZQdZ1esg6QOWwm+Q1hvEU3HZ/
         cg6BBZRjakw9ANdQKmEHUdMeZJDZThL1p9bqvvORkbBTRVVu4bWOiR4ZjEytB3ijnx9u
         htSOU9goQ5SCRwav2RhRbLlo7TF9TmR2uzDKcoM3zziTBesc3EqDKaG/vxLTphxWH5xh
         2awg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713611013; x=1714215813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nafLEb94zEj1OGgZQ3DlqoP/KtaHO508OoUiKE3Uw04=;
        b=eOhwwoLiMGYIUnOy6+Zr0YM5tF3vmZpfssR4DdV+zPEBP0hc2rUE5uibT1wt+B1Dmr
         2oE8sUDqz6SNz3VN85HxBKWL2qqMQY6DQSu7M2FpE//5jMTiKs6Yp0WVnCMsUveJF0hY
         cUm0ZjnGKZCIKH+97w2TAgI1PHoFlMuxJHBpIYtBwXAaEtpiAN1C/NSztxr7HiMz2NmP
         MEWI3or7iHlRT5tHeWAUb72STCIqUHRNXudoL/BpmOg9WvSEr2TFUkL3PBj0en4d2P4e
         BpzRkOo5QAMaL94d4146/lo85eFB0EdmlI5azbmKGtprc0JH4Rm0zJC1HE0NWK1k38mj
         tiwg==
X-Gm-Message-State: AOJu0YwqndcM9o7ZOHnMI8KMZANv5/92gRWzKsfv4xDo/N53+2GINI9j
	g34OvK2C7pn8xj+mSOu7RArAGo1Xfkob0Qq+9/iZuZQRTvx70uA3+0wnbr+KaPM=
X-Google-Smtp-Source: AGHT+IHIkgh1L6ck+7lGUSnRk9Evn/wNt4qdU6AMKgzC/yIudFIBU/HZ2xYXc82WfI/mtJncAyx1Tw==
X-Received: by 2002:a05:600c:1ca7:b0:418:93f4:b4ef with SMTP id k39-20020a05600c1ca700b0041893f4b4efmr3107199wms.0.1713611012679;
        Sat, 20 Apr 2024 04:03:32 -0700 (PDT)
Received: from [10.236.36.88] ([88.128.88.151])
        by smtp.gmail.com with ESMTPSA id o14-20020a05600c510e00b00419f572671dsm1374454wms.20.2024.04.20.04.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 04:03:32 -0700 (PDT)
Message-ID: <5e2ffea7-556e-4623-bc25-e23367e61846@linaro.org>
Date: Sat, 20 Apr 2024 13:03:31 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1713564212-21725-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2024 00:03, Zijun Hu wrote:
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()") will cause below serious regression issue:
> 
> BT can't be enabled any more after below steps:
> cold boot -> enable BT -> disable BT -> BT enable failure
> if BT reset pin is not configured within DT|ACPI for QCA_QCA6390.
> 
> The mentioned commit wrongly set quirk HCI_QUIRK_NON_PERSISTENT_SETUP
> within qca_serdev_probe() for this case and cause this serious issue.
> 
> Fixed by reverting the mentioned commit for QCA_QCA6390.
> 
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
>  drivers/bluetooth/hci_qca.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..0934e74112a6 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2357,7 +2357,8 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  		if (IS_ERR(qcadev->bt_en)) {
>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>  			power_ctrl_enabled = false;
> -		}
> +		} else if (!qcadev->bt_en && qcadev->btsoc_type == QCA_QCA6390)
> +			power_ctrl_enabled = false;
>  

Please use kernel coding style, so {}.

Please run scripts/checkpatch.pl and fix reported warnings. Then please
run `scripts/checkpatch.pl --strict` and (probably) fix more warnings.
Some warnings can be ignored, especially from --strict run, but the code
here looks like it needs a fix. Feel free to get in touch if the warning
is not clear.

Best regards,
Krzysztof

