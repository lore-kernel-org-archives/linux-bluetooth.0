Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800437426D;
	Fri,  5 Sep 2025 15:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757084578; cv=none; b=unrn2s8vPecEH8TdzMOJA2F5sbm80kwCh/wetLJU2kWZ12MvZe8ULV/mvKPXOBH1NHeOMtZnJNWY6Lq7SPewUUEVy/Ev/bLnCweBp9tQZ/YCBcW2Ws1ME2ixtlfYjJQM6KHDT2Uq3IPiQSAB3ZYfGzSDfvRf9JLgvO7V5UCNN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757084578; c=relaxed/simple;
	bh=fXAlkg6U4rjB2T88uzlB0xsdi6LWa2QU3tBer2f0tLE=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=enzxGhEpONlHCfTsxkxr3LohLyM30xX60IEW9b78b0R+vyMw5mvkGX57VDAJxCWOn4N+AIh9a6B2O2oOKa2T0vD9CmqAmNwU028IzKRzfaf4ipom4jFY8b3u5r6n3mFwvE2UdiU3MVmHrWGw1Fq5k8t55tb+0L73WGNpj7tDcY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrXh5JC8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrXh5JC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0750C4CEF1;
	Fri,  5 Sep 2025 15:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757084578;
	bh=fXAlkg6U4rjB2T88uzlB0xsdi6LWa2QU3tBer2f0tLE=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=nrXh5JC8NNluI3p5jaLqySzGJpmeKgwV9Zu67Olq4VBiL2OHhcKZp17i1qxOAByjZ
	 IZ4BCOyAB4ZZgxu5fMVQ+gBrLQb/M77HHt6Pfvdmmbrb0gC5kFv2DggICl9HnpqV02
	 iVXgMMfQUTS64BpH9F8/DUQ0kpxwpbRoVVZsdjWg3YbcIJmoiqRkfxX56L+OSBGI8w
	 MNd7Gk13vdIAKKNRRKjk8kHQ5BkwPmP6Fzka3zSdZjAnlil3fc0Y7eeGv9JKI3sGys
	 Jx6VoHtvtf3rU5cudLlcScxlSJT+J4E1IOSyA/AjtvsJypal4QQDn9r61B6dFx9KXV
	 8T6H4OovQB4+g==
Date: Fri, 05 Sep 2025 10:02:57 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Chris Lu <chris.lu@mediatek.com>, 
 linux-mediatek <linux-mediatek@lists.infradead.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Sean Wang <sean.wang@mediatek.com>, Marcel Holtmann <marcel@holtmann.org>, 
 Jiande Lu <jiande.lu@mediatek.com>, 
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
 linux-bluetooth <linux-bluetooth@vger.kernel.org>, 
 linux-kernel <linux-kernel@vger.kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hao Qin <Hao.qin@mediatek.com>, 
 Luiz Von Dentz <luiz.dentz@gmail.com>, 
 devicetree <devicetree@vger.kernel.org>, Deren Wu <deren.Wu@mediatek.com>
To: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
In-Reply-To: <20250905084433.26999-1-ot_zhangchao.zhang@mediatek.com>
References: <20250905084433.26999-1-ot_zhangchao.zhang@mediatek.com>
Message-Id: <175708448180.930634.147702031291534747.robh@kernel.org>
Subject: Re: [PATCH v7] dt-bindings: net: mediatek,mt7925-bluetooth.yaml


On Fri, 05 Sep 2025 16:44:33 +0800, Zhangchao Zhang wrote:
> Reset BT via BT_KILL_1V2_L hardware pin.
> 
> On the M.2 standard hardware pin interface, the MTK chip
> has a pin called BT_KILL_1V2_L or W_DISABLE#2, it uses
> function-level device reset (FLDR) to reset Bluetooth.
> When it is pulled low, it can external shut down the BT
> function, it is defined as 5 on the MT7925 chip, and is
> defined as 248 on the device tree pio controller.
> 
> Signed-off-by: Zhangchao Zhang <ot_zhangchao.zhang@mediatek.com>
> ---
>  .../bluetooth/mediatek,mt7925-bluetooth.yaml  | 47 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7925-bluetooth.example.dtb: bluetooth (mediatek,mt7925-bluetooth): Unevaluated properties are not allowed ('#gpio-cells' was unexpected)
	from schema $id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7925-bluetooth.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250905084433.26999-1-ot_zhangchao.zhang@mediatek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

