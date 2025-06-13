Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0192550A4;
	Fri, 13 Jun 2025 06:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749795239; cv=none; b=lo4tRgBwNRP7gcw+yERhnfzHKMOpqxwYPL5pk+8pXvHXNSqTwTC3fC8TSqmPB7JMCtuyVphb/uFlfi9HfBawcTOVWGAQ+TGuwDJTiVnGWOZkVD7lSpyOrBYV82Fgm80aA2VKwrOCZ/dy3VbXcfi/iHW0pPE0il88rT5LRg7WSlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749795239; c=relaxed/simple;
	bh=s2CjwCTkvEKYGIX42P5S34bwxEMhqXxZ9rUwspKC5dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=suwrtIOWJwskPINIqJsfQBSpu1EaazyIKPIMBbA1Jw08e+xaZc23LnDHdTfMq+a5wLElsMAhBRWlCZk9y3ka8T8/SGak2rQ9zsGZtYri52fVCwhYCRw620NjE5+EP8SaMwWvHIC3mkekJUOCDcSsWuYgEzdZwDdYGwgwinOdEXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eumd1Pd6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eumd1Pd6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93119C4CEE3;
	Fri, 13 Jun 2025 06:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749795237;
	bh=s2CjwCTkvEKYGIX42P5S34bwxEMhqXxZ9rUwspKC5dQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Eumd1Pd6rWFxIXhB0WmQaxmE6oq4xHwfHKyeO+SkY0fiJCC1tErHIZNvyXOovyDIS
	 HfX+Y9Ng3AXDkvJ7i2CAFZsFI74CLH1sDd5kTatKX5zBz8EkQdQDKBIRvDFqwKDPEP
	 +yuGrY7qOnndE2i/PjXG+MboxW6sfZC/u4532jP7q884aCeavdjJDU63IiefGpRy7q
	 /UAJk2cjvtE9wg7Tf47OXIgIBQ1XnLwOPB0BS5vP6/mMWVCxTArfIf9VRFyuAbtOzh
	 1KPyGAT76THHoaH5G6Zy+0PIwfVEkjuegtGm8kcmlJg1dSozQsdJVXrCr7kqpFttCm
	 lsn6WG/TaKNYg==
Message-ID: <36765047-7b88-4899-966c-e4c4362127ff@kernel.org>
Date: Fri, 13 Jun 2025 08:13:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: mediatek: add gpio pin to reset bt
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>,
 Luiz Von Dentz <luiz.dentz@gmail.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>,
 Aaron Hou <aaron.hou@mediatek.com>, Chris Lu <chris.lu@mediatek.com>,
 Hao Qin <Hao.qin@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-mediatek <linux-mediatek@lists.infradead.org>
References: <20250612072230.12537-1-ot_zhangchao.zhang@mediatek.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250612072230.12537-1-ot_zhangchao.zhang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/06/2025 09:22, Zhangchao Zhang wrote:
> This V2 patch provides two methods btmtk_reset_by_gpio,

Please do not use "This commit/patch/change", but imperative mood. See
longer explanation here:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95


And v2 makes no sense here. Describe the commit, why you are doing this,
what you are doing here, not your process.

> btmtk_reset_by_gpio_work for mediatek controller,
> it has been tested locally many times and can reset normally.
> 
> The pin is configured in dts files, bluetooth is reset by pulling

That's redundant. Do not explain us how DTS works. We all know it.
Explain WHY you are doing this, what sort of problem or hardware you are
dealing here with.

> the pin, when exception or coredump occurs, the above methods will
> be used to reset the bluetooth, if the pin is not found, it also can
> reset bluetooth successfully by software reset.
> 
> Compared with the previously submitted version, the following
> information has been revised in version V2

This goes to changelog or cover letter. See submitting patches.

And that's a v3, because you already sent v2.


> 1)-Changed the capitalization of co-developer names,
>    using the correct capitalization of abbreviations and full
>    name, and corrected obvious spelling errors.
> 2)-Add a revision history.
> 3)-Remove the "BT Driver" in the prefix.
> 4)-Add the bt-binding document, include inforamtion related to reset
>    pin and compatibility matching.
> 5)-Add a comment before the schedule_delayed_work function call,
>    although schedule_delayed_work is asynchronous, there is no risk.
>    Even if it is not completed within 200ms, it will only postpone
>    the subsequent probe and will not have any impact.
> 6-)Add a comment before the btmtk_reset_by_gpio function call,
>    if the compatibility filed or pin cannot be found in the dts
>    files, it can still reset bluetooth using software reset.
> 
> Co-developed-by Hao Qin <hao.qin@mediatek.com>
> Co-developed-Chris Lu <chris.lu@mediatek.com>
> Co-developed-Jiande Lu <jiande.lu@mediatek.com>
> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> ---
>  .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 54 +++++++++++++++

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching. For bindings, the preferred subjects are
explained here:
https://www.kernel.org/doc/html/latest/devicetree/bindings/submitting-patches.html#i-for-patch-submitters

>  drivers/bluetooth/btmtk.c                     | 69 +++++++++++++++++++
>  drivers/bluetooth/btmtk.h                     |  5 ++
>  3 files changed, 128 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> new file mode 100644
> index 000000000000..bcdb46effdba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT7925 Bluetooth
> +
> +maintainers:
> +  - Zhangchao Zhang <zhangchao.zhang@mediatek.com>
> +
> +description:
> +  7925 uses the USB bus to communicate with the host.
> +  Two methods are used to reset Bluetooth.
> +  When Bluetooth crashes or core dumps,
> +  the pin will be pulled low, then held for 200ms,
> +  and then pulled high again before next probe.
> +
> +allOf:
> +  - $ref: bluetooth-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - mediatek,mt7925-bluetooth
> +
> +  reg:
> +    const: 2
> +
> +  reset-gpios:
> +    maxItems: 1
> +    description:
> +      An active-high reset pin for the Bluetooth core;

Blank line and drop final ;

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    &xhci0 {
> +      vbus-supply = <&pp5000_usb>;
> +      usb2-lpm-disable;

Drop node above

> +
> +      status = "okay";

Drop

> +
> +      bt_reset: bt-reset{

Messy style, missing space. See DTS coding style.

> +        compatible = "mediatek,usb-bluetooth";

Look at your binding which you *just* wrote.

> +        reset-gpios = <&pio 248 GPIO_ACTIVE_HIGH>;

That's so incomplete... and will fail tests. You need to write COMPLETE
binding and then COMPLETE example.

> +      };
> +    };
> \ No newline at end of file

You have patch warnings.


> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index 4390fd571dbd..3e5f3ca6f0d5 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -6,6 +6,8 @@
>  #include <linux/firmware.h>
>  #include <linux/usb.h>
>  #include <linux/iopoll.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  #include <linux/unaligned.h>
>  
>  #include <net/bluetooth/bluetooth.h>
> @@ -109,6 +111,65 @@ static void btmtk_coredump_notify(struct hci_dev *hdev, int state)
>  	}
>  }
>  
> +static void btmtk_reset_by_gpio_work(struct work_struct *work)
> +{
> +	struct btmtk_reset_gpio *reset_gpio_data =
> +			container_of(work, struct btmtk_reset_gpio, reset_work.work);
> +
> +	gpio_direction_output(reset_gpio_data->gpio_number, 1);
> +	kfree(reset_gpio_data);
> +}
> +
> +static int btmtk_reset_by_gpio(struct hci_dev *hdev)
> +{
> +	struct btmtk_data *data = hci_get_priv(hdev);
> +	struct btmtk_reset_gpio *reset_gpio_data;
> +	struct device_node *node;
> +	int reset_gpio_number;
> +
> +	node = of_find_compatible_node(NULL, NULL, "mediatek,usb-bluetooth");

Same comment as before. Nothing improved.

Best regards,
Krzysztof
