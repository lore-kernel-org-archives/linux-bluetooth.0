Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3117C68
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771762; cv=none; b=MTj0FD2wYIRaqR3q7B5WSquL+r4eOFGYOYOjMyEisEUk59IH6nYGETsk4AJJvM8mpxc2cmCCEia3LctTC0+QtKKm8wFQ+FIhAvDqrNyUQqwFyjrkWrSoaRLOFRssGEWAleplth9qGUk5ao6V0Yahv0E6giHX/RtZkUfSYXtdMNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771762; c=relaxed/simple;
	bh=z8/PSmwxLF2S+4SptZ0HzOZvgEt3Dq5cgrryR4fEcKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mf1ObD/P/2T6j3ev4ux/HhUiuJAgdHLFyo+0EaW2Mrqrc7shHAgNqHMzFhCmL3PJgYl4syUgS6hChijmnStjre3R/kEMw6pUNwshFQFrKTVlzNjgZ9mcWqVioUZLPjBJEdNWmmCoI6+ARJ9nayfgURXITKrESrv1KsnbQbam/C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rz9/iFE9; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rz9/iFE9"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41a523e2888so4007435e9.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 00:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713771759; x=1714376559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=J52MRbBtgwmUpKH/9xgXI6HwwsLdnJ4Z7klv/rZIsGM=;
        b=rz9/iFE9rgJpaGwW77uDAzzwoX16toZ/PXT8XmPNuuWkTa6l8Q+RYAfRMsKHrN1BGe
         9QpYY9OSXXPlgF0Sa95jK1ixURZpblYwyOzAEUlOBfCdkT4seHXHXlUrLy8KGTh4qNFF
         OfrjWEVEmX8R9PU4iumRcIk4qvvpdo8PqrM7r6Ot/pdJ3YSxvIGCAXbjooxCqc1K8qEF
         QtzK4U4IzhClXzgpkNrAR3Cz2V9xI9MU96ecFW6nQrg0Y4vN18dIIzThJUo5P/hwMni+
         ssrF1O/XrOF/y1r9hq9vv0TTsVAiwH5j34jxI8gnzgohJZIFWjOQk7HLDH5DibSygh9c
         mt6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771759; x=1714376559;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J52MRbBtgwmUpKH/9xgXI6HwwsLdnJ4Z7klv/rZIsGM=;
        b=VCwGysh7sA9jOKh+F/ZS+xoXHgVJ/pUR4X+KkD3sg7tetNyRdW8fPk7DUob+myDwmN
         bnW5FaW+PVEz3yLHjUnOW4o41b8Wg3qNaOHC3VrSYzZeM8OtPOTofUcQeRyAbPEmTp9U
         49sEFYvFDj64broWeDZ8VTCCMY/eAY+8mZ7tMJBlNSOidiAiJjzta839gVCKnmlSDbKY
         42SHpaBjeTiHpGXz93yi76Okeq+7P+Nf1LseB3TdKkzvbbDGLcLVTnQt1WqvnSyVE0D1
         qegxBLgizEM+kCC2lsaujxBGxLIev1TQhCTwGnGnmT4GzubBLQpA6xkNmZboRHOAM5gt
         211Q==
X-Gm-Message-State: AOJu0YzYkPKdUFK32WnwWbM+0lt/12ckvNXq9e0hIJM/qp4MT0BW5hb/
	hciYYZBhW1o89mB+WVnBerEqth/7z+FQvFiHrkpC9e49JcH+U3jrwRsRIztc3/g=
X-Google-Smtp-Source: AGHT+IEOgdrH4XYIeogpG+nNhHEbQZRr92d/vLqLw+HKkSlC5A6lbjzAA7YUzkQ4qhEbGIeSEd8p5Q==
X-Received: by 2002:a05:600c:35c7:b0:418:5e80:a6fa with SMTP id r7-20020a05600c35c700b004185e80a6famr7340511wmq.14.1713771759292;
        Mon, 22 Apr 2024 00:42:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n5-20020a05600c3b8500b0041a3b5ed993sm3864358wms.25.2024.04.22.00.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:42:38 -0700 (PDT)
Message-ID: <f744a2ba-f842-454a-a04f-76207f0db9bf@linaro.org>
Date: Mon, 22 Apr 2024 09:42:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] Bluetooth: qca: Fix BT enable failure for
 QCA_QCA6390 after disable then warm reboot
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org, regressions@lists.linux.dev
References: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713771497-5733-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713771497-5733-3-git-send-email-quic_zijuhu@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1713771497-5733-3-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 09:38, Zijun Hu wrote:
> From: Zijun Hu <zijuhu@qti.qualcomm.com>
> 
> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
> serdev") will cause below regression issue:
> 
> BT can't be enabled after below steps:
> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA_QCA6390.
> 
> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
> during reboot, but also introduces this new issue regarding above steps
> since the VSC is not sent to reset controller during warm reboot.
> 
> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
> once BT was ever enabled, and the use-after-free issue is also be fixed
> by this change since serdev is still opened when send to serdev.
> 
> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
> Reported-by: Wren Turkal <wt@penguintechs.org>

NAK. This is way too much. Previous discussion is going, I asked there
questions and before any answers happen, you keep sending new version.
This leads to previous discussion gone/missed.

You ignored several questions and feedbacks.

Best regards,
Krzysztof

