Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9759612BF02;
	Fri,  4 Oct 2024 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728023864; cv=none; b=ajYByd//yLwnnhHgIR6SW5d/V46ozDYk3VNlVvPg70vWBt9U0PGLVbRk7hpEEVi+dRrGvW+fUGlTEsQmaqmUet35NCTHkjuNLETcz44RSlLMZ2RdFjqcyH+ydsFE3Kt/AJA4XuUpPs8fSH6n8upl4gdozMsMOruZX2Kd3+cA0IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728023864; c=relaxed/simple;
	bh=fmiIz7ZGhk56W9CE6q0sAiRv9tksjwu8iHjEIe44L5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f2lJhOc/NRnGiJKXWPLmusQU3C9vdfC0Fu2zzBNw5NueCMJ+SEnUdLHS+SxpnSCk2ee/WQYSDKoTeq6xJzn05r/5gnF6mlXNeiMW3vCjXytu7PrhU2WYupnxl0JCLNhKBjTsySyck/o4eccwbgOaJoX4veCq4ySVZX4dExm2Kl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uw2vpVhS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uw2vpVhS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27A37C4CEC6;
	Fri,  4 Oct 2024 06:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728023864;
	bh=fmiIz7ZGhk56W9CE6q0sAiRv9tksjwu8iHjEIe44L5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uw2vpVhS+pyYwdKUhy2TNXi3zrnmY49Sk4EK16SlFWHZ0z4+GYPER1vEoGv8uT2Lk
	 tJdx1rbpzb4vdEDt4U4qMnJ1/O1B/9XQPhN1hQEflrPLsRwKlyOAPjkiqQXGihn/qi
	 6sWgURMIsCMTCTPUbbxZY6Ofh35pG2jAka6eRGzlYcPT+usq2DyrT9eKYBI/rSY4R9
	 uqLZOE8VKOTTPJOZvEeAAn/a3EYhVoFKOmtePiVL7KBWu+0SmhcN0+Sg4mO8nCoywR
	 8yggJG6qjJCRdOx2SbdC5VeeH3Z5iFPaIQ7QYvKGrL0hOe5IQEVmzT1O1P0bcV/kpY
	 15XE0hH9U1o+Q==
Date: Fri, 4 Oct 2024 08:37:40 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, amitkumar.karwar@nxp.com, 
	rohit.fule@nxp.com, sherry.sun@nxp.com, ziniu.wang_1@nxp.com, haibo.chen@nxp.com, 
	LnxRevLi@nxp.com
Subject: Re: [PATCH v2 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 power save feature using GPIO
Message-ID: <sllfy6srzwlwemkesnrgbdegywy6llysrylq45xf7no7ox7uwt@4u25dxff2fyr>
References: <20241003154507.537363-1-neeraj.sanjaykale@nxp.com>
 <20241003154507.537363-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241003154507.537363-2-neeraj.sanjaykale@nxp.com>

On Thu, Oct 03, 2024 at 09:15:06PM +0530, Neeraj Sanjay Kale wrote:
> This adds a new optional device tree property h2c-ps-gpios, which specifies
> the GPIO connected to BT_WAKE_IN pin of the NXP chipset.
> 
> If this property is defined, the driver will use this GPIO for driving chip
> into sleep/wakeup state, else use the UART break signal by default.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Rephrase description and use "-gpios". (Krzysztof, Rob)
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 37a65badb448..cd8236eb31de 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -34,6 +34,12 @@ properties:
>    firmware-name:
>      maxItems: 1
>  
> +  h2c-ps-gpios:
> +    maxItems: 1
> +    description:
> +      Host-To-Chip power save mechanism is driven by this GPIO
> +      connected to BT_WAKE_IN pin of the NXP chipset.

So this should be wakeup-gpios or device-wakeup-gpios?

Best regards,
Krzysztof

