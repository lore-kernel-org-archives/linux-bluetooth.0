Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DF71D1756;
	Wed,  2 Oct 2024 21:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903117; cv=none; b=m5xW/RIYNDMhgGdYhuzw79T3k3KrjYlgH5xBGtBeEmFzBLT4rWNAJyt1a27cZqf0KJvgIMsC9/MEhbZNUyfyKMumMQfEu+TH2EU3LoMcttAkhumsTFmU6aVFlXzi/mwMOyaYMxi4NZ7hwOumqmNvsOAb0XVaxorbrsZRu8T4yeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903117; c=relaxed/simple;
	bh=zza68S7VBLC5J8R2UTdQx0C9CfDZO1rdUJrFvS11/uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meCK3xN6DfOxDN6IpvGNUdlhdXZiSFpFQoW517Gz6rqr8KuCYeAq46FvsIMcLsLOXU+wNmuK7yZY97NKZ9W0tL3XUrfCHstlnNk1YAYBngpRzwWKmkWZwSzyqHwvRdKpEUI1/8cbBK/RUHR5CLW2wSTk2ct8Hq9o4IwhVeVV414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz9xV+0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz9xV+0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D95C4CEC2;
	Wed,  2 Oct 2024 21:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727903117;
	bh=zza68S7VBLC5J8R2UTdQx0C9CfDZO1rdUJrFvS11/uI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mz9xV+0IBSD6CQ43w3oKs31MkfzfpO6T3hjMG1ULBg0ZHg+yP1choXl1wz0+lM8ue
	 ZKaGNPoo1tZQI45pP20S/h6y+A7FF1nJPwrpp4eGuff3Anh4oaDoe3Q1NmfF88nFul
	 voy27wenyhsweuwbRs1lB4b0KkcS9wWpOGY8WCyIy3M6IR7cjVv3DdWJ9m/gIygDgN
	 67KT9bd127o5D76H0CQB1d7TdpvrVT0vuLBzknYa8FwELtb4Y2hzwEo9WvmUxbkp5g
	 UHKbOtWBm4Y9u0plnA0dBtOGVV962eDm2SqHADQqU4lPUPNf5mSr5OsGjZaU48Bf8N
	 tusfmjhwAIjHw==
Date: Wed, 2 Oct 2024 16:05:16 -0500
From: Rob Herring <robh@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com
Subject: Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 power save feature using GPIO
Message-ID: <20241002210516.GA1312086-robh@kernel.org>
References: <20241001174021.522254-1-neeraj.sanjaykale@nxp.com>
 <20241001174021.522254-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001174021.522254-2-neeraj.sanjaykale@nxp.com>

On Tue, Oct 01, 2024 at 11:10:20PM +0530, Neeraj Sanjay Kale wrote:
> This adds a new optional device tree property called h2c-ps-gpio.
> 
> If this property is defined, the driver will use this GPIO for driving chip
> into sleep/wakeup state.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 37a65badb448..e4eeee9bed68 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -34,6 +34,11 @@ properties:
>    firmware-name:
>      maxItems: 1
>  
> +  h2c-ps-gpio:

'-gpio' is deprecated. Use '-gpios'.

> +    maxItems: 1
> +    description:
> +      Host-To-Chip power save mechanism is driven by this GPIO.
> +
>  required:
>    - compatible
>  
> @@ -41,10 +46,12 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>      serial {
>          bluetooth {
>              compatible = "nxp,88w8987-bt";
>              fw-init-baudrate = <3000000>;
>              firmware-name = "uartuart8987_bt_v0.bin";
> +            h2c-ps-gpio = <&gpio 11 GPIO_ACTIVE_HIGH>;
>          };
>      };
> -- 
> 2.25.1
> 
