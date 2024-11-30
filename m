Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB32145B1D
	for <linux-bluetooth@vger.kernel.org>; Sat, 30 Nov 2024 08:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732955080; cv=none; b=KUAQg8ttKOIaeUaKbSlNLhDcUoLBCtbI7fFrUh55EFUXdjOm87bSznN05w53s+EUa+M3c/mUZ9QeGuewXO2Xpu+GQJa65rkiOE7J0dDSMEiT7Y4DS1NcwlRcTvIzXR59NceRuA+/bUuuiGKo1eQXmkrJrYU3NgSM+Ez2EX9DAlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732955080; c=relaxed/simple;
	bh=T3ZEkR8FRmoGfS+iUyMyev1GAYYNn73koObaMJIbYTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HBfMLk3ZHGNAp34rLOgl0Gy8DlYgNljjTRuqn4UC6XyKQxvNOUzzuSpflmrARWTeMIg2UTCQO5sn+yxFEkig0k/L3bqw2PYF0Pb58kZH3IOYlZ6OepCrSXwoJA67E/QxsFJyFu3n25DWPLZJ6BoDso8tkhW8QMhcVSzX+UGphvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NHJt8hrc; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHJt8hrc"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e3983426f80so1507654276.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 30 Nov 2024 00:24:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732955077; x=1733559877; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/ULrCe/2Ff2FSpV/AO7lLO8UIbyUN2jMxQuSykRyzA=;
        b=NHJt8hrciPsj4dP5MblfovlRQUFihV/MU8C/dhYWcMpQrTzHiWR22MuxIc62cGSRnR
         xbOjWKkivNTo9KZpDd+Lu1X31zAVKLJvjlnk+zuaO9rwnsciaCqn/i08AGNOpzfjnfif
         wASpwo/Rq9ZIxxEoZdDMh0gj95Rc+CqPvj5Pt/3RuM9i/ZI9l6mpEJvR2K/Zbd4FodZV
         SRlKzpyyYIBO+SYS+7GUmm8IZs3X4f8VE50rm/hHdE6suSbd9hpKC7xDqw8EwAay0Wx0
         Z1J/Lu3efgKuhai4e6o45CB/LA34ccTHYr0qe3jceyLlDW1i76F4F79xyataFk82nqUt
         2uOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732955077; x=1733559877;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/ULrCe/2Ff2FSpV/AO7lLO8UIbyUN2jMxQuSykRyzA=;
        b=SSVzCdCUaRrx/4ItBeFz7uQZH728vfEISyad1ambH+3e4UWdUnYXSMVooVxGUraX+9
         Zeq5Oy896WqsLpaqtTRa0CCCGJx1neLq+kvQ4R73XTzGVShhz5qvo2cZQOsgx9BR28lb
         cE5Zl8a2drg8wGTIII0acR5vQJJ4KdnDJZJWbV4UGyaQmba/d8VE3C65enb2+NH3Gbf5
         xYMaHgdiFyEeJ0h1LsjsaEP9PaZyc6QWWNr73/hMMOWfCOVPzitXesA+j0YWJ3VJp6HE
         G2RQ2C/3ZVlYoeCVfdRAcJtSoNcxkNu8+tg3MKTLU3b9+vl8B5ehxq3nmUnURJPOJh/B
         LVXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDIzCJLsv8UfxNLO2szpyzfSCQ0SIWrSDow2+Yi2+B0hN/z6uc0R7ZjrCx2HvgUHuDGBHuShDYnNZug3KzYGM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHDZtPafQx8Ng5P0Wiaqu75nwxjSKB3TCFiIIhAO1Ci0LCuttX
	6K8h4fEhD+8PjdXvlh/BtimNwSyK34JlGQE14t48Lxf8yHTo7a98VPMEJ2BCK5pRuPYjxJjpdIW
	wC7pTZTXPFsKXINuBBBZwZvoGc6dC45q2L0JjpA==
X-Gm-Gg: ASbGnctpMMYRUNOpAzrohwsCE4vUe0qWRqgxJPlDdSOuiU3f7lQCvnzCarwc5ihq8sr
	8pfQgd5hUgLwSw3hklQ8zEBermSoI+qIy
X-Google-Smtp-Source: AGHT+IHFtwIx+xIGxgtLl06FwKCAMpkX4wI1vOoW0DJY8p3/N1CSY9tG7GAJulWq+lCQjzID8VtEYI/abuGt1T7MRbQ=
X-Received: by 2002:a05:6902:f84:b0:e38:b6be:1d58 with SMTP id
 3f1490d57ef6-e395b893aaemr18050418276.21.1732955077495; Sat, 30 Nov 2024
 00:24:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241120095428.1122935-1-quic_chejiang@quicinc.com>
 <20241120095428.1122935-2-quic_chejiang@quicinc.com> <454tdpuglu23nmxfqqesv42h5rk3vqiji7spo3naf2djqwojqt@6x3ram3lnlkq>
 <fb5bc38b-83b3-4924-b1d0-39219a2927b4@quicinc.com> <CAA8EJpqAOD_+SLG2LbiodWOs28_rquvMefmSH5CY1yB_rkiZPg@mail.gmail.com>
 <a7ec9426-8c8a-49b3-9916-4c2660c38e49@quicinc.com>
In-Reply-To: <a7ec9426-8c8a-49b3-9916-4c2660c38e49@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sat, 30 Nov 2024 10:24:26 +0200
Message-ID: <CAA8EJpqpzwGL38F_MYUJVuAT8q96QZO7CSh00ZpNBU5cGWUqqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: bluetooth: add 'qcom,product-variant'
To: "Cheng Jiang (IOE)" <quic_chejiang@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, Rocky Liao <quic_rjliao@quicinc.com>, 
	quic_zijuhu@quicinc.com, linux-bluetooth@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, quic_mohamull@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Nov 2024 at 05:48, Cheng Jiang (IOE)
<quic_chejiang@quicinc.com> wrote:
>
> Hi Dmitry,
>
> On 11/21/2024 12:38 PM, Dmitry Baryshkov wrote:
> > On Thu, 21 Nov 2024 at 06:02, Cheng Jiang <quic_chejiang@quicinc.com> wrote:
> >>
> >> Hi Dmitry,
> >>
> >> On 11/20/2024 6:43 PM, Dmitry Baryshkov wrote:
> >>> On Wed, Nov 20, 2024 at 05:54:25PM +0800, Cheng Jiang wrote:
> >>>> Several Qualcomm projects will use the same Bluetooth chip, each
> >>>> focusing on different features. For instance, consumer projects
> >>>> prioritize the A2DP SRC feature, while IoT projects focus on the A2DP
> >>>> SINK feature, which may have more optimizations for coexistence when
> >>>> acting as a SINK. Due to the patch size, it is not feasible to include
> >>>> all features in a single firmware.
> >>>>
> >>>> Therefore, the 'product-variant' devicetree property is used to provide
> >>>> product information for the Bluetooth driver to load the appropriate
> >>>> firmware.
> >>>>
> >>>> If this property is not defined, the default firmware will be loaded,
> >>>> ensuring there are no backward compatibility issues with older
> >>>> devicetrees.
> >>>>
> >>>> The product-variant defines like this:
> >>>>   0 - 15 (16 bits) are product line specific definitions
> >>>>   16 - 23 (8 bits) are for the product line.
> >>>>   24 - 31 (8 bits) are reserved for future use, 0 currently
> >>>
> >>> Please use text strings instead of encoding this information into random
> >>> integers and then using just 3 bits out of 32.
> >> Ack. Originally intended to make it more flexible for future use. It can be
> >> text strings for current requirement.
> >
> > No, fixed-format data isn't flexible. Fine-grained properties are.
> > Please define exactly what is necessary rather than leaving empty
> > holes "for future expansion".=
> >
> >>>
> >>>>
> >>>> |---------------------------------------------------------------------|
> >>>> |                       32 Bits                                       |
> >>>> |---------------------------------------------------------------------|
> >>>> |  31 - 24 (bits)   |    23 - 16 (bits)   | 15 - 0 (16 bits)          |
> >>>> |---------------------------------------------------------------------|
> >>>> |   Reserved        |    0: default       | 0: default                |
> >>>> |                   |    1: CE            |                           |
> >>>> |                   |    2: IoT           |                           |
> >>>> |                   |    3: Auto          |                           |
> >>>> |                   |    4: Reserved      |                           |
> >>>> |---------------------------------------------------------------------|
> >>>>
> >>>> Signed-off-by: Cheng Jiang <quic_chejiang@quicinc.com>
> >>>> ---
> >>>>  .../bindings/net/bluetooth/qualcomm-bluetooth.yaml          | 6 ++++++
> >>>>  1 file changed, 6 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> index 7bb68311c609..9019fe7bcdc6 100644
> >>>> --- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
> >>>> @@ -110,6 +110,12 @@ properties:
> >>>>      description:
> >>>>        boot firmware is incorrectly passing the address in big-endian order
> >>>>
> >>>> +  qcom,product-variant:
> >>>> +    $ref: /schemas/types.yaml#/definitions/uint32
> >>>> +    description:
> >>>> +      specify the product information for driver to load the appropriate firmware
> >>>
> >>> DT describes hardware. Is this a hardware property?
> >>
> >> It has been added to identify the firmware image for the platform. The driver
> >> parses it, and then the rampatch is selected from a specify directory. Currently,
> >> there is a 'firmware-name' parameter, but it is only used to specify the NVM
> >> (config) file. We also need to specify the rampatch (TLV file).
> >>
> >>
> >> Can we re-use the "firmware-name"? add two segments like the following?
> >> firmware-name = "rampatch_xx.tlv",  "nvm_xx.bin";
> >
> > I think this is the better solution
> >
> How about the following logic for handling 'firmware-name' property:
> 1. If there is only one string in firmware-name, it must be the NVM file, which is used
>    for backward compatibility.
>
> 2. If there are two strings in firmware-name, the first string is for the rampatch, and
>    the second string is for the NVM.

I'd say, other way around: the first one is always NVM, the second one
is rampatch and it is optional.

>
> 3. Due to variations in RF performance of chips from different foundries, different NVM
>    configurations are used based on the board ID. If the second string ends with boardid,
>    the NVM file will be selected according to the board ID.

Is there a reason why you can not use the exact firmware name? The
firmware name is a part of the board DT file. I assume you know the
board ID that has been used for the board.

>
>
> Here are two examples:
>
>  firmware-name = "qca/QCA6698/hpbtfw21.tlv",  "qca/QCA6698/hpnv21.bin";
> In this configuration, the driver will use the two files directly.
>
>
>  firmware-name = "qca/QCA6698/hpbtfw21.tlv",  "qca/QCA6698/hpnv21.boardid";
> In this configuration, the driver will replace boardid with the actual board information.
> If the board id is 0x0206, the nvm file name will be qca/QCA6698/hpnv21.b0206
>
> >>
> >> Or add a new property to specify the rampatch file?
> >> rampatch-name = "rampatch_xx.tlv";
> >>
> >>>
> >>>> +
> >>>> +
> >>>>  required:
> >>>>    - compatible
> >>>>
> >>>> --
> >>>> 2.25.1
> >>>>
> >>>
> >>
> >
> >
>

--
With best wishes
Dmitry
