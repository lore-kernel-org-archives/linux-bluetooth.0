Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E38430E85C;
	Fri, 20 Jun 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750403857; cv=none; b=YtAAqXJxBHk99f3z53jID8HusviBGMxK+00wIHIRVwDDcFl0oae6tH7RRfsNtkNwM8JZ1nysth8SYza7ZfYexl84MWvIwhdCOJs43a091ATds01x+synBTmD/erb/r5MpH/lR28v08C+k126/DP5sVFUdxKShvIKMSOY2bNsVy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750403857; c=relaxed/simple;
	bh=EkT8c7NhUhxATwkYAQb5mAtqvgYpiTu6GWN9+u+uTJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TygCOPWF6tjShWHReonRl3gyyMeN8ANqTXZbrK444hV5AipHgQvP82cYph6ve+Vg+KVuneuybqnMgbVMNg4WdauKuy6aRhB+6kpjJmPR3eHra8nbt81ODg88b71xwGqg4I2Xkao6F21Y/d+QXjFJJ8hbwRYU1LMl+HlieV6i7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZ6dc0Vj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZ6dc0Vj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EEBC4CEE3;
	Fri, 20 Jun 2025 07:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750403857;
	bh=EkT8c7NhUhxATwkYAQb5mAtqvgYpiTu6GWN9+u+uTJc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DZ6dc0VjDoWXwJTV7yxRF03i+CmBFCRDsk9f+lknU/j9Chbq/9nTCI6j/8Ab7O3Ij
	 X3PP52VLgFlsl2Eyd0sRUiTxWtN6pEVmZWJehGwmUimc4klbdPOyCOQQ51DvrE/uPB
	 NvWIJA7GLz8fVtHV6p5NFTqXFspM19OOGIhzZGNbzFAV3AKHYitwaHhfgoCPnbpF2+
	 bjncjJ+eKZ7K8XSiE1V54YVOzPsdcMB28qURL3TVYdJijxPlWHAlaUEWTP3Je06ek1
	 hMcXXGJIFOo1BEqxbUjsv20Witu+JNZW2UQk4DmzIDCz5BPyygBtyY7lRDYTw+ve6M
	 UhDw5+IPVFufw==
Date: Fri, 20 Jun 2025 09:17:34 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, amitkumar.karwar@nxp.com, 
	sherry.sun@nxp.com, manjeet.gupta@nxp.com
Subject: Re: [PATCH v4 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 4M baudrate
Message-ID: <20250620-colossal-competent-turaco-d4f8b5@kuoka>
References: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250619111629.30098-1-neeraj.sanjaykale@nxp.com>

On Thu, Jun 19, 2025 at 04:46:28PM GMT, Neeraj Sanjay Kale wrote:
> Add support for 4000000 as secondary baudrate.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
> v2: Use the available 'max-speed' device tree property. (Krzysztof)
> v3: No Change
> v4: Add ref for max-speed. (Krzysztof)

No, why?

> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index 3ab60c70286f..bb9ab5dd3b4a 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -34,6 +34,13 @@ properties:
>        This property depends on the module vendor's
>        configuration.
>  
> +  max-speed:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No, drop, I did not ask that.

I asked to do like other bindings, just look at them. I gave you exact
ref which is missing.

NAK

Best regards,
Krzysztof

