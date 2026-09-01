Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B75F3921D6;
	Tue,  1 Sep 2026 13:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270202; cv=none; b=rfTz6X9955Rz8eyyx4rLZmpLuaO1YGM3tNg7f5WfOOvnOzK8JuEnLlQJ4iZOovDqkNUDQAPFMlyAUsJ5HRFE9IbGGnaclaNtCWXgPVluQOi6ZHc/PQ29AW29JP8cXYKRuWW3Ta8SjaDlQZ3lcbmmXD8hbqDVgcscXdNY4bN8PYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270202; c=relaxed/simple;
	bh=4AJ69ty18E8UErU5nzS7IECG6x++X+btgqpLBDrd5iU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D8Y3QwI2FQT1auYZ+cgKzPj2tkZpu2zvLjFeHPeDyUK6+OnvAxeYkiVUDOM7nklXcsq8LvQ05WW615Sl81cB6737O+Pn+hcKtwvovNNHWT+YHIZtXMjjDvlfX5CXghTUCdaPYYj1DawomUPgd/zbocJvfa0g3dUFKHXvw5zisKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 606CD4C2C37F01;
	Tue, 01 Sep 2026 15:42:51 +0200 (CEST)
Message-ID: <d1183f33-30b4-4675-87e6-42b887e9da8e@molgen.mpg.de>
Date: Tue, 1 Sep 2026 15:42:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] Bluetooth: dt-bindings: net: bluetooth: add
 BCM4384
To: Andy Chang <andy.chang@synaptics.corp-partner.google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org
References: <20260901023300.1382808-2-andy.chang@synaptics.corp-partner.google.com>
 <20260901085702.1515378-1-andy.chang@synaptics.corp-partner.google.com>
 <20260901085702.1515378-2-andy.chang@synaptics.corp-partner.google.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260901085702.1515378-2-andy.chang@synaptics.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy,


Thank you for your patch.

Am 01.09.26 um 10:57 schrieb Andy Chang:
> Add the brcm,bcm4384-bt compatible string to support the
> Synaptics BCM4384 Bluetooth controller.
> 
> A fallback compatible is not suitable here because the BCM4384
> controller requires a dedicated firmware patch file (.hcd) matching
> its specific hardware ID and revision.
> 
> Falling back to an existing compatible would cause the driver to
> request the wrong firmware binary and fail the controller
> initialization.
> 
> Signed-off-by: Andy Chang <andy.chang@synaptics.corp-partner.google.com>

I’d use your @synaptics.com address.

> ---
> Changes in v3:
>   - Fix typo and GitLint failure.

kaihsin.chung@synaptics.corp-partner.google.com also sent in patches 
[1]. It’d be great if you could coordinate.

>   .../devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml        | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> index 95501e858e6f..612d21123aaa 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/brcm,bluetooth.yaml
> @@ -31,6 +31,7 @@ properties:
>             - brcm,bcm43540-bt
>             - brcm,bcm4335a0
>             - brcm,bcm4349-bt
> +          - brcm,bcm4384-bt
>             - cypress,cyw4373a0-bt
>             - infineon,cyw55572-bt

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul


[1]: 
https://lore.kernel.org/all/?q=kaihsin.chung@synaptics.corp-partner.google.com
