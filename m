Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC4E4503C
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Feb 2024 17:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707155409; cv=none; b=kDQM1hjbp6wphVbNjLVA6EplszAW9KIhFviR+PNBuSLrV5vIInqUhqRs1VS5vBu/pCppklQBJ3vswCsMDWD6mC7yAxxNF/9kufGF8mkAzTgRQ23nh2Orcf4LNWG7+7Vrgqrk98RdSvcKX57Ul2ICe7nWvdzHmulzyYuyZ37u0/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707155409; c=relaxed/simple;
	bh=XtyKIZOHUkITyVfVCKKLQDn/bkAPoBlW71uBdrkDQ00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZEo7eP1Mb6xX3LGQWML9lFVaGvE6qTu+UEpC8BmHaILgAMb+tXlH2brzeaSMjUoGypBZi8GLo9KyZ6MTCoonGnc6qogucVaH498N8lqywPvkdeHM+6uBjCWA0KtdAYjofwQhum6CzBTt8p3Gsj9effUuYk5boFiRHTxqAzXgktQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NA5SnIQq; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NA5SnIQq"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6045db1b5a1so12268477b3.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Feb 2024 09:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707155406; x=1707760206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/5gYNDF0nkUKp5M5EY3mkMekMIIUthcO9+zxPUgVLc=;
        b=NA5SnIQqYS6Y0AHMGKLRgQc+CJBkbigT6DthXyIF8RcMeE59TaM68dOHBXH+haA347
         VJTp7V1vgowu7TLF+vwr2fQBK+TH9vLhMnScklofq7V2X7/4cKra29FB0y5UOvi8BW3Q
         X6bfdVtCw/fjLvIGOdF68sqVr1iNTPJfrQPD5EzRGbqA44R2gLj6aj1lKV0Wyq3mNv9X
         hSCtPRWIBFT+C2ym4G4pWyLxFGoCEE+V+/t9l/I+8oiv0STlz6BPRdkF4xGGM23dKDPC
         Dw9K+0FkbIVu9cYK0e2VHXS14pn0ZWyrrUuv9IsUXn35kq7R1zZ5+APl1Fu1oWroa4X1
         Iwdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707155406; x=1707760206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/5gYNDF0nkUKp5M5EY3mkMekMIIUthcO9+zxPUgVLc=;
        b=nrGbmSWf4t4tilfiSYPOxElNy/VVP2qWRznXVvIXaJ5DwWKoeBkJ1evaksnZGxuLd+
         Jagf+wGYoEQYEYL4kCgXpTdUFCdW1LTWYj3yUMCiE4O/8GGvfN/sih2CvjE6py1pnbkK
         Za29BtZvMBSUB/LCX2Ds7j8fg1T2Unf1A/bFt1q0AWF4MfEgeGrb1fvJKvx9KSxyCER5
         uTrhxP8GKdAybRcSCMqAciXJUIX30iNh8d4RUNp+UrFoQx93iq4jJRgaK9v95WzV2LlN
         ibWr+O8rPvUJUmSwNp9Lx8KR95pmiYlnh3xz4km8bOSyODhgikSAS2JO+FK6olMaPddr
         FW4Q==
X-Gm-Message-State: AOJu0Yzy0IB4V4zeOYo5m3+yJNz6/+h8u0RYfypOO6tkLuA1QyuSZK7Z
	L3E0hTTp+mV8fOffj2/u55zDimGAu3VigQdqOp0l300PIIpKan6ZQwThWgj/94iPllPshs1fdWy
	YsGxyoCxmYkyLNQefG9aEzSIEKHx0WiCiWKd9lw==
X-Google-Smtp-Source: AGHT+IHk5yq/jXGQCbTN9oiaw3qxJe+nFI2U1PdUPgItb1jUnBVqkaOpdjfeCkgO3RgvntvaJHN4Aox1RUdQzALx5WE=
X-Received: by 2002:a25:6648:0:b0:dc2:1bc4:e06b with SMTP id
 z8-20020a256648000000b00dc21bc4e06bmr95682ybm.51.1707155406596; Mon, 05 Feb
 2024 09:50:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126063500.2684087-1-wenst@chromium.org> <20240126063500.2684087-2-wenst@chromium.org>
 <74b9f249-fcb4-4338-bf7b-8477de6c935c@linaro.org> <CAGXv+5Hu+KsTBd1JtnKcaE3qUzPhHbunoVaH2++yfNopHtFf4g@mail.gmail.com>
 <21568334-b21f-429e-81cd-5ce77accaf3c@linaro.org> <CAGXv+5HxXzjigN3Bp96vkv71WfTJ1S2b7Wgafc4GxLmhu6+jMg@mail.gmail.com>
 <a4324473-e0c6-4d53-8de0-03b69480e40b@linaro.org> <CAGXv+5HAqmUizXztMH_nY6e+6oQh01hCtxEJXKtCn3_74-sOsQ@mail.gmail.com>
 <78241d63-3b9d-4c04-9ea5-11b45eac6f00@linaro.org> <20240130223856.GA2538998-robh@kernel.org>
 <CAGXv+5FwaNe7oesGwZ=yR0Pg82tEzEF3B0zjoex4qw+6zsSYbQ@mail.gmail.com>
In-Reply-To: <CAGXv+5FwaNe7oesGwZ=yR0Pg82tEzEF3B0zjoex4qw+6zsSYbQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Feb 2024 18:49:30 +0100
Message-ID: <CAPDyKFofy24N7ymzTF7wiADc17Tw9FiNTYMnbxgoioMBwDKVhA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 31 Jan 2024 at 04:39, Chen-Yu Tsai <wenst@chromium.org> wrote:
>
> (+CC Ulf Hansson)
>
> On Wed, Jan 31, 2024 at 6:38=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
> >
> > On Tue, Jan 30, 2024 at 05:25:38PM +0100, Krzysztof Kozlowski wrote:
> > > On 30/01/2024 08:47, Chen-Yu Tsai wrote:
> > > > On Tue, Jan 30, 2024 at 3:37=E2=80=AFPM Krzysztof Kozlowski
> > > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >>
> > > >> On 30/01/2024 04:32, Chen-Yu Tsai wrote:
> > > >>> On Mon, Jan 29, 2024 at 3:34=E2=80=AFPM Krzysztof Kozlowski
> > > >>> <krzysztof.kozlowski@linaro.org> wrote:
> > > >>>>
> > > >>>> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
> > > >>>>
> > > >>>>>>> +allOf:
> > > >>>>>>> +  - $ref: bluetooth-controller.yaml#
> > > >>>>>>> +
> > > >>>>>>> +properties:
> > > >>>>>>> +  compatible:
> > > >>>>>>> +    enum:
> > > >>>>>>> +      - mediatek,mt7921s-bluetooth
> > > >>>>>>
> > > >>>>>> Can it be also WiFi on separate bus? How many device nodes do =
you need
> > > >>>>>> for this device?
> > > >>>>>
> > > >>>>> For the "S" variant, WiFi is also on SDIO. For the other two va=
riants,
> > > >>>>> "U" and "E", WiFi goes over USB and PCIe respectively. On both =
those
> > > >>>>> variants, Bluetooth can either go over USB or UART. That is wha=
t I
> > > >>>>> gathered from the pinouts. There are a dozen GPIO pins which do=
n't
> > > >>>>> have detailed descriptions though. If you want a comprehensive
> > > >>>>> binding of the whole chip and all its variants, I suggest we as=
k
> > > >>>>> MediaTek to provide it instead. My goal with the binding is to =
document
> > > >>>>> existing usage and allow me to upstream new device trees.
> > > >>>>>
> > > >>>>> For now we only need the Bluetooth node. The WiFi part is perfe=
ctly
> > > >>>>> detectable, and the driver doesn't seem to need the WiFi reset =
pin.
> > > >>>>> The Bluetooth driver only uses its reset pin to reset a hung co=
ntroller.
> > > >>>>
> > > >>>> Then suffix "bluetooth" seems redundant.
> > > >>>
> > > >>> I think keeping the suffix makes more sense though. The chip is a=
 two
> > > >>> function piece, and this only targets one of the functions. Also,=
 the
> > > >>
> > > >> That's why I asked and you said there is only one interface: SDIO.
> > > >
> > > > There's only one interface, SDIO, but two SDIO functions. The two
> > > > functions, if both were to be described in the device tree, would
> > > > be two separate nodes. We just don't have any use for the WiFi one
> > > > right now. Does that make sense to keep the suffix?
> > >
> > > Number of functions does not really matter. Number of interfaces on t=
he
> > > bus would matter. Why would you have two separate nodes for the same
> > > SDIO interface? Or do you want to say there are two interfaces?
>
> There is only one external interface. I don't know how the functions
> are stitched together internally.
>
> It could be that the separate functions have nothing in common other
> than sharing a standard external SDIO interface. Each function can be
> individually controlled, and operations for different functions are
> directed internally to the corresponding core.
>
> > Right, one device at 2 addresses on a bus should be a node with 2 "reg"
> > entries, not 2 nodes with 1 "reg" address each.
>
> AFAICU that's not what the MMC controller binding, which I quote below,
> says. It implies that each SDIO function shall be a separate node under
> the MMC controller node.

Yes, that's what we decided to go with, a long time ago. At least in
this particular case, I think it makes sense, as each function
(child-node) may also describe additional resources routed to each
function.

A typical description could be for a WiFi-Bluetooth combo-chip, where
each function may have its own clocks, irqs and regulators being
routed.

>
>
> patternProperties:
>   "^.*@[0-9]+$":
>     type: object
>     description: |
>       On embedded systems the cards connected to a host may need
>       additional properties. These can be specified in subnodes to the
>       host controller node. The subnodes are identified by the
>       standard \'reg\' property. Which information exactly can be
>       specified depends on the bindings for the SDIO function driver
>       for the subnode, as specified by the compatible string.
>
>     properties:
>       compatible:
>         description: |
>           Name of SDIO function following generic names recommended
>           practice
>
>       reg:
>         items:
>           - minimum: 0
>             maximum: 7
>             description:
>               Must contain the SDIO function number of the function this
>               subnode describes. A value of 0 denotes the memory SD
>               function, values from 1 to 7 denote the SDIO functions.
>
>
> ChenYu

Kind regards
Uffe
