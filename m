Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197303232
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 07:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713685496; cv=none; b=rcuLenX3s5g/PizE4weETK61ox2lzd0ZwD3xwW1HUTzJJ8K4036/KV3hpocYkPIFRvvvOrvEMIys8ZBy/cU3LrJQOJj0RjQurRMhZbY5Vt69IQlblSVgNsDhuc4/DShyCkGggNeTUqqN6X92qY1vPoFE+qRQvyEBACctSOx2/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713685496; c=relaxed/simple;
	bh=J3UBzWO5a/g05IN3/k7Rrapz2xKBTUeR9LuSUETnV5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SL0l8fKbc4vGR64KagQ6Lcdhh4KPY2XSOG/CEAPAnFP0eNNn96oIESuLzJpbr01rlx6iubXP9ZKdgznnhFFaUrD6O2RKlbP9PN9WAbMjKyMfTsUx6UP1kN7rTpbdMKS0sKpK4T/CD4hMmNTSzp7mI3yY+IS6cLdAnEvicGfnVtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=IveHc/F9; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="IveHc/F9"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5d8b519e438so2645923a12.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713685493; x=1714290293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZOH34XVLgutMmsA0ijOMbxhDgR/YlGuWtIEtferIMpI=;
        b=IveHc/F9TdKOkcV0R4w5Hbry/6rRiqN2z++xbsdHXS/sVXtzfeKs+Emb6HS8UuT/i3
         nX28pwQiLAlLnogVHrPeDUoVOkZygYGQFdOvD6OyS8Xb7r6dyXiqzoVlhXqU9jWAqjz2
         8oiV9vr0570C0PMOOkmKxibaqCt0j9+GCoaYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713685493; x=1714290293;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZOH34XVLgutMmsA0ijOMbxhDgR/YlGuWtIEtferIMpI=;
        b=F9WC6cFTXEfpA0tbY6bUOLp4MLNc0HmhPacCJNlHayoV45v79tJLIrPZtSBxUCbt1M
         gKagOSMDk95gDW4bxSobVNjLevLLUQe8u+gw21fz4sIdzzuJyMPt9GdGbEQeeQfmeR23
         HNw7HCxJZdpVXWxU/dXqXwY40X3NRnAguLTFqvzzMDrOqMQ+t64z+u01DLUHG/pSN43n
         500Kf7zqgRCreRjGTF3AIPDUwrUwxciUk2NrqZM2jiqB2pJm6wdGMpaOkUVVy+UcsML+
         Pu6xL+HmNt/7DUBUTEII7jMFG0eZjSIyyImA6EWg3XLJB8eEXourbi7uAn76LoBL6aJ2
         NgYw==
X-Gm-Message-State: AOJu0Yza9Fl5ixmr9CqqmJMIvd4KG/GaNVmg5eT9943q3h36CLqISwFQ
	BMzIYP7GkcoZEU+qhBty/Mr2+m24ggjxM6MEqdJYYaKuRj+54tbIRcCKALlGzg==
X-Google-Smtp-Source: AGHT+IEGSE2FkSkQVp2SqjB2LomicpyMaVdITBO04iho5Fny6/uxs1VlTXDQuTt7rhL7tVMAAVtI+Q==
X-Received: by 2002:a17:902:e543:b0:1e5:5c8c:67ec with SMTP id n3-20020a170902e54300b001e55c8c67ecmr8685047plf.5.1713685493274;
        Sun, 21 Apr 2024 00:44:53 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id e8-20020a17090301c800b001e0f5034e95sm5918798plh.288.2024.04.21.00.44.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 00:44:52 -0700 (PDT)
Message-ID: <369512e2-f091-4370-bce5-9ac32178dc4d@penguintechs.org>
Date: Sun, 21 Apr 2024 00:44:51 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] Fix two regression issues for QCA controllers
Content-Language: en-US
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 krzysztof.kozlowski@linaro.org
References: <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <1713650800-29741-1-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/20/24 3:06 PM, Zijun Hu wrote:
> This patch series are to fix below 2 regression issues for QCA controllers
> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390

@Zijun @Krzysztof and @Bartosz Would it be helpful for me to test these 
to ensure they fix the issues I reported?

> the links for these issues are shown below:
> https://bugzilla.kernel.org/show_bug.cgi?id=218726
> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> 
> Changes:
> V3 -> V4: Correct code stype and commit message
> V2 -> V3: Wrong patch sets are sent
> V1 -> V2: Remove debugging logs
> 
> Zijun Hu (2):
>    Bluetooth: qca: Fix BT enable failure for QCA_QCA6390
>    Bluetooth: qca: Fix BT enable failure for QCA_QCA6390 after disable
>      then warm reboot
> 
>   drivers/bluetooth/hci_qca.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)


-- 
You're more amazing than you think!
