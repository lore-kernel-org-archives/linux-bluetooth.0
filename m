Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4A52563
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713611642; cv=none; b=T8xyRosjlE3NCCGOh0PZLOsMWu++1uBMw96mIE1CZZWGoeyhASl3pb7+udEFhB+7asVMfjRIyT6/X92t5jOz/tSA9Zs0NdlGFlpAE+5rSb19IIrLWOx1I8n50o4FAWXN5Ysn3TR0Wy7Rd7QUlpMohCOmBAXPHS8aKEiyeoFdclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713611642; c=relaxed/simple;
	bh=RppZEGV/ccSUfwt8cxXV9ey8UXG91HSJotMChd5giyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPee0tHgdO9NvRJAXTsHHNLXxCCCLm9TZYqSxJ8EowqaqkDr9BZrsFAWKHS+OyhknSL+hUMdJWyci/iKPfMc9L2p3xcwzkD8nr8QgVvBDOLmyvyzZWi2tOcuJiWcYC8I0PfpMRuJmNxaBpkpAS4C88ROi6cBzu8ERWc+pPU71/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NhuiMAie; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NhuiMAie"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-344047ac7e4so2339638f8f.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Apr 2024 04:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713611639; x=1714216439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RpaCBLRwVUaHxyixxxO4YLcvdiQBR/wSVK4Af+7Ypjo=;
        b=NhuiMAie14eGocopTv9uosSsS6GqAm/62qPnctglJede9cTZmMT0Mmu/GFZkRXINwE
         WjfSaLs46PkIyGozgswdFrv0HmL9gGIGUuq0mXsJMlUM7Jh9T+ljthoM2NjLe885x86M
         oSoI4tD9xUYY/q27rP9adHNTaEJErWiIC+R2ywze7Cz/cxjt92EkruCpdlMeC51OZ8+E
         OHk70RwQ3ojPRbgxrkKrzV6Ax0XcS6RQX561UI+25nP7BDHGnaatx4JICa5K4PyWSDi4
         b4O1rd2JhYdCoT5w/dzSi7o3uO5E0XYcFbtFEZ9hRyk+hK3LKw6sSD5n3bsmlVSrJtDp
         P/5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713611639; x=1714216439;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpaCBLRwVUaHxyixxxO4YLcvdiQBR/wSVK4Af+7Ypjo=;
        b=rR1GXpEq4fLSJZKcb0uMFmGgHn2KhG6tJNzY9PL5I9CBdSjVn45iweKIlJC8MQsK5m
         rE3xsda+blZVkI/fEEWZmRrc6dDbwt2TuF3ce94m36vmKDD8yLSR6Ebx4vvyNUWt1zTZ
         /Ku/L2i46s3NXGngPtfeVCXHhrKeMTkc8+cHrTYPovz43nWzfoAvsvUHrqoq5VCs5c7B
         mpi0hVc/XugBeM+uUsuQxMKcntG6TAb8DXqVoiz7hESXnesqu+7qR389Y/UHFl3weXs5
         G6VZHdUrhHYPlw1DgRkdvdqCmybISGZ5vhX2bf05DFGFdp2VFF48md+XC1BQBWjt/q75
         OzCg==
X-Gm-Message-State: AOJu0YwRfnb8OJI8MXoWoCi5LI2XBq6WqBRNtknClmq6G7W8mupO6sma
	DrwskzoW228TJ0WXZFOdu54rkCXT1LxidMKHSmQqlp73DwIZ5X3Kgw6IyPQN9Qw=
X-Google-Smtp-Source: AGHT+IH1t6QHvvfCXDANhOc1olr/YG2gMPevTSnDuD58D+Mtdx67w6z/M6stgqfiJ+9Dmq/+ywxYkw==
X-Received: by 2002:adf:f68c:0:b0:341:b5ca:9e9c with SMTP id v12-20020adff68c000000b00341b5ca9e9cmr3170711wrp.25.1713611639262;
        Sat, 20 Apr 2024 04:13:59 -0700 (PDT)
Received: from [10.236.36.88] ([88.128.88.151])
        by smtp.gmail.com with ESMTPSA id bf7-20020a0560001cc700b003439d2a5f99sm6632775wrb.55.2024.04.20.04.13.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 04:13:58 -0700 (PDT)
Message-ID: <2166fc66-9340-4e8c-8662-17a19a7d8ce6@linaro.org>
Date: Sat, 20 Apr 2024 13:13:57 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 bartosz.golaszewski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
 <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
 <0dca7c9b-6a97-4171-9b0c-5b806a4e8a60@quicinc.com>
 <4e4d8ee0-fbbe-4dc7-b40b-b983f9f39539@linaro.org>
 <01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2024 07:25, quic_zijuhu wrote:
> On 4/19/2024 9:49 PM, Krzysztof Kozlowski wrote:
> 
> Hi Krzysztof,bartosz,
> 
> let me summarize our discussion here in order to reduce unneccessary
> disagreements here.
> 
> 1) i only revert your change IS_ERR() to my change IS_ERR_OR_NULL.
> 
> 2) your change will cause serious regression issues for many lunched
> products

Instead of repeating every time "serious regression" can you actually
explain the problem?
None of commit messages from v3 help there.

> 
> 3) we only need to discuss how to handle devm_gpiod_get_optional(...,
> "enable", ...) returning NULL since this is only difference between your
> change and mine.
> 
> 4) your change doesn't solve any actual issue and the reason you
> submitted is that "The optional variants for the gpiod_get() family of
> functions return NULL if the GPIO in question is not associated with
> this device, and should not treat it as error".
> 
> code applet of your merged change is shown by below link
> https://patchwork.kernel.org/project/bluetooth/patch/20240208164017.26699-1-brgl@bgdev.pl/#25705104
> 
> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>  					       GPIOD_OUT_LOW);
> -		if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> +		if (IS_ERR(qcadev->bt_en)) {
>  			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>  			power_ctrl_enabled = false;
>  		}
> 
> 5) Original BT driver design agree with your point mentioned at 4), so
> for case "qcadev->bt_en == nullptr", qca_serdev_probe() don't do error
> return for this scenario and use dev_warn() instead of dev_err() to give
> user prompt.
> 
> 6) your wrong fix changes flag power_ctrl_enabled set logic and will
> cause serious BT regression issue, hope you will realize this point.

Sorry, not realized and you did not explain it. Neither above nor in
commit msg.

> 
> 
> i would like to give below extra comments even if these comments are
> irrelevant to the critical point of this issue mentioned at above 3)
> 
> A) you need to investigate it is a) the prompting approach or message
>  error or b) the if condition error even if if dev_err() is used to give
> prompt instead of dev_warn() in above 4).

What?

> 
> B) don't talk about how about devm_gpiod_get_optional() returning error
> case since it is meaningless as explained by above 3). also don't
> require a fix to fix another unreported issue. a fix is a good fix
> if it fix the issue in question and don't introduce new issue.

What?

> 
> C) per DTS property enable-gpios of BT, different soc types have
> different requirements, many are required and another many are NOT
> mandatory as shown be below link.
> https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git/tree/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml.
> 
> for a soc type which are attached to 3rd platform, customer doesn't
> would like to or are not able to congfig BT reset pin within DTS for QCA
> driver even if QC strongly suggest customer config it and also be marked
> as required within above DTS bindings spec link. i often meet this
> scenario. there are many of such lunched products.

So where is it documented? Where is it explained? Which binding or which
commit msg?

> 
> i will try to fix this issue due your change product by product in new
> patch thread based on this DTS comment.
> 
> D) you maybe ping me offline about this issue if you are a member of QC
> since you known "go/upstream"

Please keep all discussions public, unless your customer requires some
sort of confidentiality. Although even then I would argue that you can
hide company secrets and discuss about hardware.

Best regards,
Krzysztof

