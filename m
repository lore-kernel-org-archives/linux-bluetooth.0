Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD229C320;
	Fri, 11 Apr 2025 22:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744409341; cv=none; b=lJwKmaOlMbeN468GZ/w29gIdlEDrF/BncSTFcSupdXg0Q1Ruj4ymfeT44luUEj9LC9FFTtDHNbiORAXxsNYPGGcxQO79k4zBlTmgr6rsZwLmmQpItjt51wiukDllI1NgEEVYcw7aH+GA758jQ0LNPynaBfACa5vDVQbA2TYumgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744409341; c=relaxed/simple;
	bh=CwxJV85DmXjkLTZP7LuCR5nM7rqdQ8ApRtiEEh9MpZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rRupXiM/PVazUlM2QQAyA1Jsc+saMuxIhXZJdAAfwZ7kdtAMKqKaV/viC1vUzCPVEBA8fJ66eOK4Z4s5GSab6W2sLCE2lGlDS2M9DIoOjoB4K6OgKZET986rvgadaK9SnGuMe4W39SZEh+8poHAQZnjhjLVPVgng0qjvKI6QTuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2gP/WVf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2gP/WVf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B890C4CEE2;
	Fri, 11 Apr 2025 22:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744409340;
	bh=CwxJV85DmXjkLTZP7LuCR5nM7rqdQ8ApRtiEEh9MpZQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a2gP/WVfUHALinaeKHZXcmNAR7o087H3E6hd2k8t+9LfE72OzhZqhEZPnDsngCNyX
	 oQfmZiQ07PDKhh2omu4fYK57/JceFpC4BHfJ4Lhj2Fxooo5xjfSf02fx89XfzEQeXF
	 u3ZYbxnPJ7aYr6WIepBZOx671BmLxb4hVyVR+8KWhfjZO9VP3fkY/bVMDgnKOOxhWa
	 GyPwjOWEeWaiP0AHUoQFTwYO+OlMinYHWBAt0fA/iQ2lOaI8Ii6XUHVZfUYK0eJLC5
	 N4hAzjowUt6gB8ZdTLL/izN+Px4PGMq62N5+2E1JVpRbH0J/H6Ail/53scqTb2N+Y1
	 Ye3UwHW75kT3w==
Date: Fri, 11 Apr 2025 17:08:59 -0500
From: Rob Herring <robh@kernel.org>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	amitkumar.karwar@nxp.com, sherry.sun@nxp.com, manjeet.gupta@nxp.com
Subject: Re: [PATCH v1 1/2] dt-bindings: net: bluetooth: nxp: Add support for
 host-wakeup
Message-ID: <20250411220859.GA4161337-robh@kernel.org>
References: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250411163719.326558-1-neeraj.sanjaykale@nxp.com>

On Fri, Apr 11, 2025 at 10:07:18PM +0530, Neeraj Sanjay Kale wrote:
> Add support for host-wakeup on GPIO interrupt.
> 
> Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
> ---
>  .../devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml  | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> index d02e9dd847ef..ab1411c05f49 100644
> --- a/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> +++ b/Documentation/devicetree/bindings/net/bluetooth/nxp,88w8987-bt.yaml
> @@ -48,6 +48,12 @@ properties:
>      description:
>        The GPIO number of the NXP chipset used for BT_WAKE_IN.
>  
> +  host-wakeup-gpios:
> +    maxItems: 1
> +    description:
> +      Host wakeup by falling edge interrupt on this GPIO which
> +      is connected to BT_WAKE_OUT pin of the NXP chipset.

Read the description in the Broadcom binding you copied this from. 
Define this as an interrupt named 'wakeup', not a GPIO. After all, to be 
a wake-up source, it kind of has to be an interrupt.

Just because I said no to putting wakeup source handling in serdev, 
doesn't mean the binding should change. The handling just has to be in 
the driver.

Rob
