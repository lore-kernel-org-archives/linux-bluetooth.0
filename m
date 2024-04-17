Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8784A85642
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713396735; cv=none; b=lLZAcRUbhHKyaEzO0QfelC3q+48A8dGQrUuin6S4K4W/kWaVgYCIt5E/c39ZM1BebASKuMfcob6EdcpjS8TyV/PnKfh3eUvQhu6bMOf+ky0erZu8HbJLuposx8uB0SwmcbFYcdR0H4pEdrxJAZa2XwGjt2CjbhdBXQC4U3bxdPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713396735; c=relaxed/simple;
	bh=vvp1J1SpydGRs1Ir/XmxNMPAMc5m1dHH0Oe0z/29VuE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFDVbfeFika1GtUFIsXMuhguBUs2lX/2OoaZM5/tmLQa5FFgH0MFKFyzABrnabln/5vokDwLBCF+sZRpHhJ2YMpc6gD329wSmc1Ae7kfMzS1vzHrEAaFUmJlVZGjAZZl/9LhzKwEQNS3QnB5qXrka0DOBYPbYaOErgIb/dSVdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ISw+Fe0R; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ISw+Fe0R"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-516d3776334so243181e87.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Apr 2024 16:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713396731; x=1714001531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXeaIqHgrQqvoS7w1DDDiuOy+AYJG35Jgluc3WBXL9E=;
        b=ISw+Fe0RApwzUwVDImCY+ouRCwZG7aMMd3HK5CmhhV04pKART+APpuulyB6th+mf59
         zdIh+HiPONEYyo6UHKYgYO76ABBwMT4TQ3hQNqSXrCaBuZQ6u+TeULqgYrP0wy7im3xv
         t/JIsrwLpeH0cxDtCAuntBbMMsiMP+/d4QeuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713396731; x=1714001531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXeaIqHgrQqvoS7w1DDDiuOy+AYJG35Jgluc3WBXL9E=;
        b=AL1hlbEsGSiXUkXSgHYY4dgNJ3M/AQIgsRIAo4WnvTzAH/PnL9SpvTD2lOfU2ZH8i7
         7gf8ATOijD5m4MRRiM9CU6U/eca/r7s8KwI/Xl9BF7mg9Cx2TM6mB2v25wqeFolRiA6u
         +KOb2nrst/8RR/lRX3gZKO9auf1QI6RiArkMYqrI7S0bQISDDlzxAiP6Rvu+/SftyRom
         +g+18lkhB8OC+2MMWjpscGHbyVL5VF0WOwasoXM8XrUkdls6ltPe8075PezLfKRKkh1C
         i38tvxQGiCCzED5V5q273foILDaH1NGAQE0xTH4UBv7hWYCBsvQExedvbJm4/+mRBEHe
         SB7g==
X-Forwarded-Encrypted: i=1; AJvYcCXqmHXvdZ6LM5971qp01RYfUG47rFn809bgZWaLEejGybeMERI88VOBnJxOf9C46j/ddW0BXqfGFhTBo4VIz1AhbtkU3elTnN33pTzpRSpv
X-Gm-Message-State: AOJu0YwANtRhPgBEXSJhfE2uMmh9K8AUoC3iXp85J9xhqrMRi6G/Vn+I
	o1tfIaF3dPQ+J/XPxL4iwG+jMwzWxPu/M2gZ373a+F34NFM8UfhoqvDomNLRUXDXSMVOPo+p3Xs
	4g/ATFT4EcF848d1oiOOoplDs7PkKg8EAxzEx
X-Google-Smtp-Source: AGHT+IEdA30trqC2FAaLVap4ZQxvHXDW+eQ/qMYNrW1mInC1+qlsTt9tjJAxb0ZRkJ6pUgTOzXndvJ5C7T1s5nX8MgU=
X-Received: by 2002:ac2:5b4f:0:b0:519:17b6:f20 with SMTP id
 i15-20020ac25b4f000000b0051917b60f20mr445676lfp.6.1713396730437; Wed, 17 Apr
 2024 16:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412073046.1192744-1-wenst@chromium.org> <20240412073046.1192744-2-wenst@chromium.org>
 <CAGp9Lzp=MKNYc70ZeGCAEgWfFVPOAOZQQ86BXukk+EQQM_C+OA@mail.gmail.com>
In-Reply-To: <CAGp9Lzp=MKNYc70ZeGCAEgWfFVPOAOZQQ86BXukk+EQQM_C+OA@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 17 Apr 2024 16:31:59 -0700
Message-ID: <CAGXv+5FeRwYm7x+fYS9KPXW-0tQ-zSuk5nU6AZ-=yU07wXnJ9w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Sean Wang <sean.wang@kernel.org>
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

On Wed, Apr 17, 2024 at 4:04=E2=80=AFPM Sean Wang <sean.wang@kernel.org> wr=
ote:
>
> Hi Chen-Yu,
>
> On Fri, Apr 12, 2024 at 12:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org=
> wrote:
> >
> > The MediaTek MT7921S is a WiFi/Bluetooth combo chip that works over
> > SDIO. WiFi and Bluetooth are separate SDIO functions within the chip.
> > While the Bluetooth SDIO function is fully discoverable, the chip has
> > a pin that can reset just the Bluetooth core, as opposed to the full
> > chip. This should be described in the device tree.
> >
> > Add a device tree binding for the Bluetooth SDIO function of the MT7921=
S
> > specifically to document the reset line. This binding is based on the M=
MC
> > controller binding, which specifies one device node per SDIO function.
> >
> > Cc: Sean Wang <sean.wang@mediatek.com>
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> > Changes since v2:
> > - Expand description and commit message to clearly state that WiFi and
> >   Bluetooth are separate SDIO functions, and that each function should
> >   be a separate device node, as specified by the MMC binding.
> > - Change 'additionalProperties' to 'unevaluatedProperties'
> > - Add missing separating new line
> > - s/ot/to/
> >
> > Angelo's reviewed-by was not picked up due to the above changes.
> >
> > Changes since v1:
> > - Reworded descriptions
> > - Moved binding maintainer section before description
> > - Added missing reference to bluetooth-controller.yaml
> > - Added missing GPIO header to example
> > ---
> >  .../bluetooth/mediatek,mt7921s-bluetooth.yaml | 55 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 56 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/net/bluetooth/mediatek,m=
t7921s-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/med=
iatek,mt7921s-bluetooth.yaml
> > new file mode 100644
> > index 000000000000..67ff7caad599
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921s-=
bluetooth.yaml
> > @@ -0,0 +1,55 @@
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
> > +  This binding only covers the Bluetooth SDIO function, with one devic=
e
> > +  node describing only this SDIO function.
> > +
> > +allOf:
> > +  - $ref: bluetooth-controller.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt7921s-bluetooth
> > +
> > +  reg:
> > +    const: 2
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description:
> > +      An active-low reset line for the Bluetooth core; on typical M.2
> > +      key E modules this is the W_DISABLE2# pin.
> > +
>
> Thanks for adding the new setup for the MT7921S devices. They look good t=
o me.
> Sometimes, the MT7921S might be set up to wake up the host when it's
> asleep using a sideband signal.
> This might need an extra pin called "wakeup" to make it happen. Can
> you help add this pin to the settings in the same update, or should I
> do it later?

I suggest you send a patch on top of this one? I'm not sure if you
would model it as a GPIO or interrupt. And there doesn't seem to be
any code in the driver expecting it.


ChenYu

> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    mmc {
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <0>;
> > +
> > +        bluetooth@2 {
> > +            compatible =3D "mediatek,mt7921s-bluetooth";
> > +            reg =3D <2>;
> > +            reset-gpios =3D <&pio 8 GPIO_ACTIVE_LOW>;
> > +        };
> > +    };
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 88981d9f3958..218bc2a21207 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -13818,6 +13818,7 @@ M:      Sean Wang <sean.wang@mediatek.com>
> >  L:     linux-bluetooth@vger.kernel.org
> >  L:     linux-mediatek@lists.infradead.org (moderated for non-subscribe=
rs)
> >  S:     Maintained
> > +F:     Documentation/devicetree/bindings/net/bluetooth/mediatek,mt7921=
s-bluetooth.yaml
> >  F:     Documentation/devicetree/bindings/net/mediatek-bluetooth.txt
> >  F:     drivers/bluetooth/btmtkuart.c
> >
> > --
> > 2.44.0.683.g7961c838ac-goog
> >
> >
