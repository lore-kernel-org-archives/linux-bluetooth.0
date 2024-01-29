Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F9E101EE
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 03:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706499544; cv=none; b=PCGjb+C3/RqRc6Kf30GsCZHzEoqSqlSsmtJwghRozrh2jJEABT3MMB+IXf0ALaPW5OV/0XZk9p9XybG5gBSY0jzodd8K6L0Xa1CpYORZj8IpVEh5fMQ74Q9AVehiXLTKDYus/HRTreh4s1DB2DOBHjFsck/zJVSt0RQVbPlBAM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706499544; c=relaxed/simple;
	bh=wE4cixn0oIglWKeS/zIrvtFsWbeheeYOTmOIKWPKXCE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A1P1tKK5wE1AkiYd/h6S95eiYMocwEClFmkdBLZ7rNwnqSMuafGVQaHIXB3ZyymNf+GgVvGJLeSe/dqo+NbVMxVJpz+XUM/R7LznDlKNIxtLAs9n61eKWEmeHXEqD1yyhIYFQG402p6QT7Um1U1FJ0vPCMm9hFf4iMfIC2VQtj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NhLmcjLE; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NhLmcjLE"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5110f515deaso845192e87.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jan 2024 19:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706499540; x=1707104340; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/yyUGF5rIxxEr8wGxy6mzO1hK1BzZ2gmE5L9TwgfgxA=;
        b=NhLmcjLEUKN0XxvcQ/70ZW2TkD9d3g8WQqvTjI3yX8UCNlQ/CJtbE2ApB9meI5+TDD
         zLtc948i1kSVgFnzBQqed5AHQyx2WT6BZL2t49gCmqte/vrmPc0r7DULnucETTnP0HP3
         ut/5ujrsQ0b8wjeFQqdJ+O7lkdfuLAYhny6R0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706499540; x=1707104340;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yyUGF5rIxxEr8wGxy6mzO1hK1BzZ2gmE5L9TwgfgxA=;
        b=iDrLayN0uGXq0pkOQV/lI0iN0P7dSwCf4W5QKI0dHfuifq+Of+rbI9bnc0eUfNQtvM
         jyFNXfGpxMXMuhLDqapf0AbzA6l33ZFQGchy+DO15x+Gp27FqYV1KRR/1nAu/07YSEIY
         CJqBRwZIKtFjR457k2j1GEmOVGz3aUf5E24cC7KI0gWMlmgRR8CDX+YP2qdQdprZqCsq
         HsrKyDPmegJvmocorIPy/L9zZZb79EusM/fDZXctBy80GJLGqF9skCUtBPoemEjoB5Q5
         zxhWCPlv24X2qRtmk5IYy5Ggz9hNIenlLfrCBjmWK54ByP0GRbdLfj57XWmoYlPN1k0c
         qIPw==
X-Gm-Message-State: AOJu0YzVKpyJX5MfrGR/6fdi1UMIioNJ0VJrzdYeUeVrDe12XtAdwGSv
	X7W7BUUlObHIEnE9XQZgiXNcU9yIcHKGfBcYaoYl/kmI4AClD+3q2ob4A+uODc8xx3q2shMm/hH
	Q08y5bLtSbpI0s8wXJSud/d82EqKxMhZZKBfA
X-Google-Smtp-Source: AGHT+IEXgMUgHt38rJa9lkZWY3kg2sc8NUxr6P4rZVQj9hDCI16H5nC2o9tzHW8pEEyFHfhwuR4GhhyhIWVA70eTXH0=
X-Received: by 2002:a05:6512:280e:b0:50e:b25e:94d8 with SMTP id
 cf14-20020a056512280e00b0050eb25e94d8mr3488177lfb.41.1706499540469; Sun, 28
 Jan 2024 19:39:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
In-Reply-To: <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Mon, 29 Jan 2024 11:38:49 +0800
Message-ID: <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 6:40=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/01/2024 07:34, Chen-Yu Tsai wrote:
> > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > SDIO. While the Bluetooth function is fully discoverable, the chip
> > has a pin that can reset just the Bluetooth side, as opposed to the
> > full chip. This needs to be described in the device tree.
> >
> > Add a device tree binding for MT7921S Bluetooth over SDIO specifically
> > ot document the reset line.
>
> s/ot/to/
>
> >
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v1:
> > - Reworded descriptions
> > - Moved binding maintainer section before description
> > - Added missing reference to bluetooth-controller.yaml
> > - Added missing GPIO header to example
> >
> >  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 53 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 54 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,m=
t7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> > new file mode 100644
> > index 000000000000..ff11c95c816c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-=
bluetooth.yaml
> > @@ -0,0 +1,53 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/net/bluetooth/mediatek,mt7921s-blue=
tooth.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: MediaTek MT7921S Bluetooth
> > +
> > +maintainers:
> > +  - Sean Wang <sean.wang@mediatek.com>
> > +
> > +description:
> > +  MT7921S is an SDIO-attached dual-radio WiFi+Bluetooth Combo chip; ea=
ch
> > +  function is its own SDIO function on a shared SDIO interface. The ch=
ip
> > +  has two dedicated reset lines, one for each function core.
> > +  This binding only covers the Bluetooth part of the chip.
> > +
> > +allOf:
> > +  - $ref: bluetooth-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt7921s-bluetooth
>
> Can it be also WiFi on separate bus? How many device nodes do you need
> for this device?

For the "S" variant, WiFi is also on SDIO. For the other two variants,
"U" and "E", WiFi goes over USB and PCIe respectively. On both those
variants, Bluetooth can either go over USB or UART. That is what I
gathered from the pinouts. There are a dozen GPIO pins which don't
have detailed descriptions though. If you want a comprehensive
binding of the whole chip and all its variants, I suggest we ask
MediaTek to provide it instead. My goal with the binding is to document
existing usage and allow me to upstream new device trees.

For now we only need the Bluetooth node. The WiFi part is perfectly
detectable, and the driver doesn't seem to need the WiFi reset pin.
The Bluetooth driver only uses its reset pin to reset a hung controller.

> Missing blank line.

Will fix.

> > +  reg:
> > +    const: 2
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      An active-low reset line for the Bluetooth core; on typical M.2
> > +      key E modules this is the W_DISABLE2# pin.
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
>
> Instead 'unevaluatedProperties: false'

Will fix.


Thanks
ChenYu
