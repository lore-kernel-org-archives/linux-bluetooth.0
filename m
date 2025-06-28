Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F1924467E;
	Sat, 28 Jun 2025 12:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751112237; cv=none; b=YTnm6PHBekKXcRUiOYqc7wI0D48KVs31RnPrajELJ50+TS/vHZw+YQIiXhyV5hLy7u/VTHyZOclD+EBUW1tjpwSnwOpPmhDVkmdn9r9pSf12Whn9I4KKWJ20EmrY55cZyDi7uAcGEk0rkGa7nDQb6TV5+KVeEs38tFTU1Zmh55w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751112237; c=relaxed/simple;
	bh=fnTY0f4SyP2i7YILQaJH30PaDnbGJFQ6OxX01r/0/MU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2qneCgNVrM4uuZE963ZLuF7N8fW9Erqy5pjQvtcJORXtMllbj7b5xRMPxO4C8sLiLICpCBQWUMoyYYkIxGuwYmDNpQkD5yGLgsRkF1wulPsgiHJRNOro9BlyqyLfFUed4ds0fy9xTpkCepHf9zynpMBiSXNrr6rAAz4gBMf2oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBMoTRFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBMoTRFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B26C4CEEA;
	Sat, 28 Jun 2025 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751112236;
	bh=fnTY0f4SyP2i7YILQaJH30PaDnbGJFQ6OxX01r/0/MU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cBMoTRFA6pPl0c6hPCTLjoXP2bT4O/iPyM656V2DrsOTIBoHcAYggBn2E/sMUgQB9
	 xyEaZNWd1Lp2Oj/FmFUHPXSezukDjrKXZglA6jHvs8Ty9V35USUje0VIAlDRFkz4r8
	 EoRMokoHYx+S/vEv12Ke58DQiNRFKqYLYKpT+f5tvWFfVXTKPQaw90z/Gb/cB8eGhE
	 SReqzme1145OXv9x4MU4IxqjyvcKvSq/A2A51HkOid09SlOKvsPUW/G0a9GeGVtHX5
	 4gJJIYScN0Ku9y7E7Oc1x+5DxhahGwJT7m3VosOOgLVf9+hX6VvY6CmlcwpSraAe1c
	 2aJBbZU1OyoOg==
Date: Sat, 28 Jun 2025 14:03:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, Luiz Von Dentz <luiz.dentz@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Rob Herring <robh@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Sean Wang <sean.wang@mediatek.com>, 
	Jiande Lu <jiande.lu@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
	Chris Lu <chris.lu@mediatek.com>, Hao Qin <Hao.qin@mediatek.com>, 
	linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-mediatek <linux-mediatek@lists.infradead.org>, 
	devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/2] dt-bindings: net: mediatek,mt7925-bluetooth.yaml
Message-ID: <25t3jzrqcdko5z5udbbcctaqldcrbycryazumw6mfj2c4qihmr@jcubfbuhikvp>
References: <20250627055924.7716-1-ot_zhangchao.zhang@mediatek.com>
 <20250627055924.7716-3-ot_zhangchao.zhang@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250627055924.7716-3-ot_zhangchao.zhang@mediatek.com>


How did you manage to make mistake in my email is beyond my understand.
Tools should generate address list, not humans.

Where is the changelog?

On Fri, Jun 27, 2025 at 01:59:24PM +0800, Zhangchao Zhang wrote:
> Add hardware pins and compatible strings.

I don't see any pins here.

 
> As a binding file for the MTK Bluetooth driver code,
> it provides a set of compatible fields and hardware
> pins for the driver to use.

All this is not relevant. Describe the hardware here.

> 
> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> ---


>  .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 57 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> new file mode 100644
> index 000000000000..230c24ada3b4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bluetooth mediatek add gpio pin to reset bt

Not relevant. This is the title describing this specific hardware.

> +
> +maintainers:
> +  - Sean Wang <sean.wang@mediatek.com>
> +
> +description:
> +  7925 uses the USB bus to communicate with the host.

Waht is 7925?

> +  Two methods are used to reset Bluetooth.
> +  Provide hardware pin, when an exception occurs,
> +  resetting Bluetooth by hardware pin is more stable
> +  than resetting Bluetooth by software.
> +  If the corresponding pin is not found in dts,
> +  bluetooth can also be reset successfully.

Wrap this properly. The same commit msg.

> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,usb-bluetooth

NAK, you cannot have such compatible. I already said at v1 or v2 that it
will be rejected!

Why are you pushing this all the time, without reading the feedback?

You need SoC and device specific compatibles. There is no such hardware
as "usb-bluetooth". If there is, point me to datasheet for it.


> +
> +  gpio-controller:
> +    description:
> +      Marks the device node as s GPIO controller.

Irrelevant. Drop. See other schemas.

> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  reset-gpios:
> +    maxItems: 1
> +

Drop blank line. Look how other files are doing this.


> +    description:
> +      An active-high reset pin for the Bluetooth core; on typical M.2

active-high? Really? I have doubts.

> +      key E modules this is the W_DISABLE2# pin.
> +
> +required:
> +  - compatible
> +  - "#gpio-cells"
> +  - reset-gpios
> +
> +unevaluatedProperties: false

This is random style. Why doing something completely different than
every other file? Missing blank line.

> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +      bluetooth {

Messed indentation.

To summarize:
Except writing something entirely different than every other binding
(why?), this does not represent hardware. Your commit msg explains ZERO
about the hardware. Binding description says nothing and is actually not
correct.

So again, if you send the same it will be rejected.

I expect answers UNDER EACH OF MY COMMENTS, because you keep ignoring
entire feedback given to you.

Best regards,
Krzysztof

