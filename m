Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF0514F6C
	for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jan 2024 03:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706672399; cv=none; b=Ln2OlmPRSa9wMPqYqyDcMd1JpxGRSLoE1g6AGe2smetRDHfVCnp6B0sLWjbm77AHGK+XNI/XnroYL+l8SJmYTbjhOGwubEy2PQWxmzqj9hcbr0Sue90t0mrlJCOdH+0AZYfailcEnQjrTgFc0SkSlEGmfpla9bb1x0VTUe3uQss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706672399; c=relaxed/simple;
	bh=WowSxGgZlAt0SjsqlQOh0Xqips85ZOGo0PMJ67xhi14=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R5Eq785samQW7Z51WvqX3Yr7Nwyh2rIHgn/1BXXiP6HnyRZFqHvpzb2q44ID9zQakppqnpcVWvUeD7nUG/uY0Bugy5T8naEAiX71TzwgefHIy+ZCdSQK2LVAlo4zuyEViL02usuFjJDKRt9bh+RSmBSHu1IapDseY+Lh6qUH1/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jD/IOxQ0; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jD/IOxQ0"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5102a877d50so5278844e87.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jan 2024 19:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706672396; x=1707277196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qpRkgXkbQYXbK1cEg4XXsMfWT44RSVIecn26S5cDrV4=;
        b=jD/IOxQ0fBTPjZsAKx3JTUo5ygOBAsi6V/aOA7XMNYcNib4z/Cl2XvijLIVhE7rR2m
         ECF8OhwnjXxpkJf9wnJOLk4B7+6XecT3Lg/FXH1KKvKXNWoyfuJfvK25NJDsdA8rIsdP
         tGQIVo6YHypobZBohkL2I+mNjUEOJFLMishTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706672396; x=1707277196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qpRkgXkbQYXbK1cEg4XXsMfWT44RSVIecn26S5cDrV4=;
        b=ZoqIRoQ1bYd3BSdlhJbaz7gxrvO2qYf/42dOZerPCq0Q/psq3Xv4qB/3sWUTQ9mAkw
         HNoKunk0a4KjhcOAgKec4IL9f2P/oZqE4Ku0398ADYLVMw1Wede+QS8FAPt2VKqG4JQ1
         ++RzKM5m43CEUvgHFsTyxrDcM4RDwz3J7tvmmaop28ShG1gZPdNQFuJM1OFcazECEBbQ
         HpXhf/PIr/G5sKsGZqwfNAayMLzZNYYSa7Ny4iOPd3Z9T8g9LVgoiEbeewIteNcDoSwg
         hVLcsEoPEUFH9trQDYSmAs6C+IgYNC5LLQcShTfY25EeQV7U8tOJrNMoPTqj8fc9b1nI
         vvPg==
X-Gm-Message-State: AOJu0YwWB3ge1UYSfey0nxWSkwPit9qDWged7X0yK4JNYNDOlXN0H5/e
	m0zOq1mSV75h8cReDJkWeWIzouB787+5UG+VtO8t9LJKwEYgVTudLoDhoTUIrhXi03LbZMU2mRD
	ZwD0nG/+pudpKmHEQ23PP1LCcvp+JeJWrrzNs
X-Google-Smtp-Source: AGHT+IHsCbNhf/cX1e7S3SrH8YqgH2QhUc3a53hHF1zco0XT9jtlWjG4rpYd5ZxLSwo4KK0lfHA3RvEPSDfNHcGvQqM=
X-Received: by 2002:ac2:443a:0:b0:50f:18f7:855e with SMTP id
 w26-20020ac2443a000000b0050f18f7855emr285947lfl.39.1706672396151; Tue, 30 Jan
 2024 19:39:56 -0800 (PST)
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
In-Reply-To: <20240130223856.GA2538998-robh@kernel.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Wed, 31 Jan 2024 11:39:43 +0800
Message-ID: <CAGXv+5FwaNe7oesGwZ=yR0Pg82tEzEF3B0zjoex4qw+6zsSYbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: Add MediaTek MT7921S
 SDIO Bluetooth
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Sean Wang <sean.wang@mediatek.com>, linux-bluetooth@vger.kernel.org, 
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

(+CC Ulf Hansson)

On Wed, Jan 31, 2024 at 6:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Jan 30, 2024 at 05:25:38PM +0100, Krzysztof Kozlowski wrote:
> > On 30/01/2024 08:47, Chen-Yu Tsai wrote:
> > > On Tue, Jan 30, 2024 at 3:37=E2=80=AFPM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > >>
> > >> On 30/01/2024 04:32, Chen-Yu Tsai wrote:
> > >>> On Mon, Jan 29, 2024 at 3:34=E2=80=AFPM Krzysztof Kozlowski
> > >>> <krzysztof.kozlowski@linaro.org> wrote:
> > >>>>
> > >>>> On 29/01/2024 04:38, Chen-Yu Tsai wrote:
> > >>>>
> > >>>>>>> +allOf:
> > >>>>>>> +  - $ref: bluetooth-controller.yaml#
> > >>>>>>> +
> > >>>>>>> +properties:
> > >>>>>>> +  compatible:
> > >>>>>>> +    enum:
> > >>>>>>> +      - mediatek,mt7921s-bluetooth
> > >>>>>>
> > >>>>>> Can it be also WiFi on separate bus? How many device nodes do yo=
u need
> > >>>>>> for this device?
> > >>>>>
> > >>>>> For the "S" variant, WiFi is also on SDIO. For the other two vari=
ants,
> > >>>>> "U" and "E", WiFi goes over USB and PCIe respectively. On both th=
ose
> > >>>>> variants, Bluetooth can either go over USB or UART. That is what =
I
> > >>>>> gathered from the pinouts. There are a dozen GPIO pins which don'=
t
> > >>>>> have detailed descriptions though. If you want a comprehensive
> > >>>>> binding of the whole chip and all its variants, I suggest we ask
> > >>>>> MediaTek to provide it instead. My goal with the binding is to do=
cument
> > >>>>> existing usage and allow me to upstream new device trees.
> > >>>>>
> > >>>>> For now we only need the Bluetooth node. The WiFi part is perfect=
ly
> > >>>>> detectable, and the driver doesn't seem to need the WiFi reset pi=
n.
> > >>>>> The Bluetooth driver only uses its reset pin to reset a hung cont=
roller.
> > >>>>
> > >>>> Then suffix "bluetooth" seems redundant.
> > >>>
> > >>> I think keeping the suffix makes more sense though. The chip is a t=
wo
> > >>> function piece, and this only targets one of the functions. Also, t=
he
> > >>
> > >> That's why I asked and you said there is only one interface: SDIO.
> > >
> > > There's only one interface, SDIO, but two SDIO functions. The two
> > > functions, if both were to be described in the device tree, would
> > > be two separate nodes. We just don't have any use for the WiFi one
> > > right now. Does that make sense to keep the suffix?
> >
> > Number of functions does not really matter. Number of interfaces on the
> > bus would matter. Why would you have two separate nodes for the same
> > SDIO interface? Or do you want to say there are two interfaces?

There is only one external interface. I don't know how the functions
are stitched together internally.

It could be that the separate functions have nothing in common other
than sharing a standard external SDIO interface. Each function can be
individually controlled, and operations for different functions are
directed internally to the corresponding core.

> Right, one device at 2 addresses on a bus should be a node with 2 "reg"
> entries, not 2 nodes with 1 "reg" address each.

AFAICU that's not what the MMC controller binding, which I quote below,
says. It implies that each SDIO function shall be a separate node under
the MMC controller node.


patternProperties:
  "^.*@[0-9]+$":
    type: object
    description: |
      On embedded systems the cards connected to a host may need
      additional properties. These can be specified in subnodes to the
      host controller node. The subnodes are identified by the
      standard \'reg\' property. Which information exactly can be
      specified depends on the bindings for the SDIO function driver
      for the subnode, as specified by the compatible string.

    properties:
      compatible:
        description: |
          Name of SDIO function following generic names recommended
          practice

      reg:
        items:
          - minimum: 0
            maximum: 7
            description:
              Must contain the SDIO function number of the function this
              subnode describes. A value of 0 denotes the memory SD
              function, values from 1 to 7 denote the SDIO functions.


ChenYu
