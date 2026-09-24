Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D7429016;
	Thu, 24 Sep 2026 07:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790236491; cv=none; b=qEiSoSw8HNG4FzYBjfC7W+RVO8MZseOs6JNYE9wgXHrtLB/K/yRFiY440lmBE5zmL0KCf14YZawf7W/G6MiZSnjlikmpuwSCINIaQpbPs2E42HWX/WoeEAkzurfult+Gb3jAuUG0xKZLWmYWFGUwqiMyfl5LQFMF4Z/vvcNu/Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790236491; c=relaxed/simple;
	bh=KyrlKXIQ+AoNS2GqLCuyE8jLSIGi5INXseupXmkJ52M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kewfW3D+MgPSy9pzWYmAebB4uIS7b7AnhJIeP1kihiiy/lUgA+LawFwwB344q/cqfw7a5a0v8g1paSntDICAg3IlBANXfELeN3Tf2AOcJPG+2yJTwakehigaKhWadXKvrcCPjIIyO/5fCkkXQawTNzNjOZb8QHyhd3mp0LZ7MFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idxuYEtD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idxuYEtD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD5ED1F000FF;
	Thu, 24 Sep 2026 07:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790236483;
	bh=SGTgPGlkL0aDQuqd/YX777e2j57GY3NxZGYFWV1nngQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=idxuYEtDbWYd4PdtpHMZfHKsrC7mINgMAcVFvrGYYZvaCOmioS6yvw23hHV1OYwQi
	 nwuJDtungDJr3WrQzAGf3jdZRLgO5kMmIA/v1oaaTFItx3IQQEkyLxkFn/5+4CFWi2
	 zQ3DJakxXgZWjKCPCuvzykTe5uJD1FqgonU/7fc47x4UO+H8agtQkq5COD2uDPzLhm
	 bhUw+6ZmW6SSYFYNs94JUUV/IRyiAGjRMskNHtaTGqWuLxK2K21X9JUGQCg4W6mqgN
	 a4o6SE2pxCgb9i/5alwS7OKQFRlIrLglfSeEKN5ZVQrmY9WwXaf0AiKDeNeONkoTgT
	 8rU/qZ/30hJqQ==
Message-ID: <d552f9e9-4ac4-41fd-92b3-d36de92d515b@kernel.org>
Date: Thu, 24 Sep 2026 09:54:39 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bluetooth-next v5 2/3] dt-bindings: net: bluetooth: Add
 AIC8800D80
To: Yanli Yang <yanli.yang@bedmex.com>, linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, devicetree@vger.kernel.org, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-kernel@vger.kernel.org,
 zhirunliu@aicsemi.com, dijiaxu@aicsemi.com, chunqiuliu@aicsemi.com,
 liheng.wei@bedmex.com
References: <cover.1790235697.git.yanli.yang@bedmex.com>
 <9301ec4530a27a83602d1036d1b836b326c69b87.1790235697.git.yanli.yang@bedmex.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <9301ec4530a27a83602d1036d1b836b326c69b87.1790235697.git.yanli.yang@bedmex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/09/2026 05:34, Yanli Yang wrote:
> Describe the AIC8800D80 Bluetooth SDIO firmware-loading function and
> UART HCI interface. Link the UART node to its SDIO firmware provider
> with the aic,firmware-sdio phandle.
> 
> The UART interface uses H4 at 1500000 baud with hardware flow control.
> Include an example showing both nodes and their association. Add the
> Bluetooth binding to MAINTAINERS.
> 
> Signed-off-by: Zhirun Liu <zhirunliu@aicsemi.com>
> Signed-off-by: Dijia Xu <dijiaxu@aicsemi.com>
> Signed-off-by: Chunqiu Liu <chunqiuliu@aicsemi.com>
> Signed-off-by: Liheng Wei <liheng.wei@bedmex.com>
> Signed-off-by: Yanli Yang <yanli.yang@bedmex.com>
> ---


So that's v5, thus where is the changelog?

Cover letter says nothing about v1-v3, only v4. And in that v4 nothing
about this and 1/3 patches.

>  .../net/bluetooth/aic,aic8800d80-bt.yaml      | 84 +++++++++++++++++++
>  MAINTAINERS                                   | 10 +++
>  2 files changed, 94 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
> new file mode 100644
> index 000000000000..76b94fd539e7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/aic,aic8800d80-bt.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/aic,aic8800d80-bt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AIC AIC8800D80 Bluetooth
> +
> +maintainers:
> +  - Zhirun Liu <zhirunliu@aicsemi.com>
> +  - Dijia Xu <dijiaxu@aicsemi.com>
> +  - Chunqiu Liu <chunqiuliu@aicsemi.com>
> +  - Liheng Wei <liheng.wei@bedmex.com>
> +  - Yanli Yang <yanli.yang@bedmex.com>
> +
> +description:
> +  The AIC8800D80 is a Wi-Fi and Bluetooth combination chip. The Bluetooth
> +  firmware is loaded through SDIO function 1, while Bluetooth HCI traffic uses
> +  the H4 protocol over a UART interface with hardware flow control.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aic,aic8800d80-bt
> +      - aic,aic8800d80-bt-sdio

So same feedback as last time. Same device?


> +
> +  reg:
> +    maxItems: 1
> +
> +  max-speed: false
> +
> +  aic,firmware-sdio:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the SDIO function used to load the Bluetooth firmware.

What is a SDIO function in DT? Phandles can only point to device nodes.

> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: aic,aic8800d80-bt-sdio
> +    then:
> +      properties:
> +        reg:
> +          items:
> +            - items:
> +                - const: 1
> +        aic,firmware-sdio: false
> +      required:
> +        - reg
> +    else:
> +      properties:
> +        reg: false
> +      required:
> +        - aic,firmware-sdio
> +      allOf:
> +        - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    mmc {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        bt_sdio: bluetooth@1 {
> +            compatible = "aic,aic8800d80-bt-sdio";
> +            reg = <1>;
> +        };
> +    };
> +
> +    serial {
> +        uart-has-rtscts;
> +
> +        bluetooth {
> +            compatible = "aic,aic8800d80-bt";
> +            aic,firmware-sdio = <&bt_sdio>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af5a8b4b0bb5..20662fe78632 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -729,6 +729,16 @@ S:	Maintained
>  F:	drivers/scsi/aha152x*
>  F:	drivers/scsi/pcmcia/aha152x*
>  "managers" 
> +AIC BLUETOOTH DRIVER
> +M:	Zhirun Liu <zhirunliu@aicsemi.com>
> +M:	Dijia Xu <dijiaxu@aicsemi.com>
> +M:	Chunqiu Liu <chunqiuliu@aicsemi.com>
> +M:	Liheng Wei <liheng.wei@bedmex.com>
> +M:	Yanli Yang <yanli.yang@bedmex.com>

So all these 5 people are going to provide reviews?

Please confirm this explicitly, so we don't get entries for, for
example, managers which like to be notified.


Best regards,
Krzysztof
