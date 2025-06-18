Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B202E8E0A;
	Wed, 18 Jun 2025 14:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257882; cv=none; b=LZnTjCzp0MU0yJqBnJ4hbzqQYX0oSWdvn572epVnItar1RNrBoolYXTCIu/0YPDLjHUFFFy++SVm8Y4hvv56PawldfmPESOVtmwTCXR6Ej3sRSouRFR2TRg5EkI5zO5U9Q0P4cOR2rWkPtuLG7/Ul+8OwWtTAqpootxpGryuskc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257882; c=relaxed/simple;
	bh=RaTSkFpWiiBo3+PG2gYlJYjf9802oCl6fMHRXphKPuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B+hni6IsIsBfPvxnD/0F3W3isKEHb0WK3TiWLO8F5c5oqGtU/MndrDK/DgMfH0/adTWD6pR/0Nt8MDbly8RDUomJb2izPkRlQK0yKFFDzh0qEz/ndDHrkkDiE1Hm+WqX3Q43aaVHhF64ke9WL9ey+cvyJJHcykPqiJoNZRhYnbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 99D0C6028825F;
	Wed, 18 Jun 2025 16:44:18 +0200 (CEST)
Message-ID: <3fb36656-5aeb-45f4-9460-acc8a2bc3c61@molgen.mpg.de>
Date: Wed, 18 Jun 2025 16:44:18 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 amitkumar.karwar@nxp.com, sherry.sun@nxp.com, manjeet.gupta@nxp.com
References: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250618142012.25153-1-neeraj.sanjaykale@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Neeraj,


Thank you for the patch.

Am 18.06.25 um 16:20 schrieb Neeraj Sanjay Kale:
> Add support for 4000000 as secondary baudrate.

Could you specify how you tested this, that means, how did you set the 
speed, and then do the test, that it actually works at that speed.

> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Use the available 'max-speed' device tree property. (Krzysztof)
> ---
>   .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 3ab60c70286f..4a1b6ea48a2f 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -34,6 +34,12 @@ properties:
>         This property depends on the module vendor's
>         configuration.
>   
> +  max-speed:
> +    enum:
> +      - 3000000
> +      - 4000000
> +    default: 3000000
> +
>     firmware-name:
>       maxItems: 1
>   
> @@ -78,6 +84,7 @@ examples:
>           bluetooth {
>               compatible = "nxp,88w8987-bt";
>               fw-init-baudrate = <3000000>;
> +            max-speed = <4000000>;
>               firmware-name = "uartuart8987_bt_v0.bin";
>               device-wakeup-gpios = <&gpio 11 GPIO_ACTIVE_HIGH>;
>               nxp,wakein-pin = /bits/ 8 <18>;


Kind regards,

Paul
